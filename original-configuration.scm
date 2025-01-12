;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
  (locale "en_GB.utf8")
  (timezone "Europe/London")
  (keyboard-layout (keyboard-layout "gb"))
  (host-name "sentinel")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                  (name "james")
                  (comment "James")
                  (group "users")
                  (home-directory "/home/james")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                (user-account
                  (name "tomaz")
                  (comment "Tomaz")
                  (group "users")
                  (home-directory "/home/tomaz")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list (specification->package "nss-certs"))
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list (service gnome-desktop-service-type)

                 ;; To configure OpenSSH, pass an 'openssh-configuration'
                 ;; record as a second argument to 'service' below.
                 (service openssh-service-type)
                 (service cups-service-type)
                 (set-xorg-configuration
                  (xorg-configuration (keyboard-layout keyboard-layout))))

           ;; This is the default list of services we
           ;; are appending to.
           %desktop-services))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "f4b96838-827c-4ffe-b362-cab07de8b0d5")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "6E48-872D"
                                       'fat32))
                         (type "vfat"))
                       (file-system
                         (mount-point "/")
                         (device (uuid
                                  "df70bec0-49b8-4c9f-b6da-25f058907349"
                                  'ext4))
                         (type "ext4")) %base-file-systems)))
