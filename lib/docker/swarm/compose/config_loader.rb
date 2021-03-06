require "docker/swarm/compose/config"

module Docker
  module Swarm
    module Compose
      module ConfigLoader
        CONFIG_FILES = %w(docker-swarm-compose.yml docker-swarm-compose.yaml)

        def self.load_config
          CONFIG_FILES.select { |file| File.exist? file }
                      .map { |file| Config.parse(File.expand_path(file)) }
                      .first
        end

        def config
          @config ||= ConfigLoader.load_config
          unless @config
            fail "failed to load any of #{CONFIG_FILES.join(', ')}"
          end
          @config
        end
      end
    end
  end
end
