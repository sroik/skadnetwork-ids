require 'json'

config_path = File.expand_path('convert-config.json', File.dirname(__FILE__)) 
networks_path = File.expand_path('../skadnetwork-ids.json', File.dirname(__FILE__))

config_file = File.open(config_path).read
networks_file = File.open(networks_path).read

required_names = JSON.parse(config_file)
networks_json = JSON.parse(networks_file)

required_networks = networks_json.filter do |network| 
  required_names.include?(network['network'])
end

puts("Add the following code to your Info.plist:\n\n")
puts("<key>SKAdNetworkItems</key>")
puts("<array>")

required_networks.each do |network| 
  name = network["network"]
  ids = network["ids"]

  puts("<!-- #{name} -->")
  ids.each do |id|
    puts("  <dict>")
    puts("    <key>SKAdNetworkIdentifier</key>")
    puts("    <string>#{id}</string>")
    puts("  </dict>")  
  end
end

puts("</array>")