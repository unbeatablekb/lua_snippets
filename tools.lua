--- Print Lua Table for human's use, Not a valid Json.
-- Support print nil、boolean、number、string、table、function's name
-- Not support userdata
-- FIXME print more types
-- TODO handle comma
local function print_table(tab, depth, key)
    if not depth or depth == 0 then
        print(tab)
        depth = 0
    end

    local prefix_unit = "    "
    local root_prefix = ""
    local child_prefix = ""

    for i = 1 , depth do
        root_prefix = root_prefix .. prefix_unit
    end

    if not key then
        print(root_prefix .. "{")
    else
        print(root_prefix .. '"' .. key .. '": ' .. "{")
    end

    depth = depth + 1
    for i = 1 , depth do
        child_prefix = child_prefix .. prefix_unit
    end

    -- Use ipairs to print array items specially seems no need
    --[[ 
    for _, array_value in ipairs(tab) do
        local value_type = type(array_value)
        if value_type == "string" then
            print(child_prefix .. '"' .. array_value .. '"')
        elseif value_type == "number" or value_type == "boolean" then
            print(child_prefix .. array_value)
        elseif value_type == "nil" then
            print(child_prefix .. "null")
        elseif value_type == "function" then
            print(child_prefix .. array_value)
        elseif value_type == "table" then
            print_table(array_value, depth, key)
        end
    end
    ]]--

    local tab_prefix
    for key, value in pairs(tab) do
        tab_prefix = child_prefix .. '"' .. key .. '": '
        local value_type = type(value)
        if value_type == "string" then
            print(tab_prefix .. '"' .. value .. '"')
        elseif value_type == "number" or value_type == "boolean" then
            print(tab_prefix .. value)
        elseif value_type == "nil" then
            print(tab_prefix .. "null")
        elseif value_type == "function" then
            print(tab_prefix .. value)
        elseif value_type == "table" then
            print_table(value, depth, key)
        end
    end

    print(root_prefix .. "}")
end


return {
    ["print_table"] = print_table
}
