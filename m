Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129670AbQKTMnv>; Mon, 20 Nov 2000 07:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130537AbQKTMnl>; Mon, 20 Nov 2000 07:43:41 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:21259 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129670AbQKTMnh>;
	Mon, 20 Nov 2000 07:43:37 -0500
Date: Mon, 20 Nov 2000 13:13:29 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/initrd.txt update (for 2.4)
Message-ID: <20001120131329.B599@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this patch contains the long overdue revision of Documentation/initrd.txt.
The changes are mainly updates (e.g. mention devfs), and I've changed the
focus from change_root to pivot_root.

The changes in detail:
 - updated e-mail addresses of authors
 - reduced description of change_root mechanism and moved it to the end
 - described pivot_root instead
 - corrected description of root=/dev/ram0
 - changed RAM disk initrd example to loop devices
 - described device names with and without devfs
 - using name /dev/ram0 consistently (/dev/ram is sometimes /dev/ram1)
 - use  blockdev --flushbufs  instead of  freeramdisk
 - changed example kernel name from vmlinuz to bzImage
 - text now reflects the fact that most boot loaders support initrd
 - generalized the CD-ROM boot scenario
 - /proc/mounts is now more accurate, and mounted file systems are no
   longer a problem
 - described how to test initrd with chroot
 - added reference to "Booting Linux" document
 - added reference to newlib package
 - various minor changes

Should apply to any kernel since ~2.3.41, including 2.4.0-test11.

Cheers, Werner

---------------------------------- cut here -----------------------------------

--- linux.orig/Documentation/initrd.txt	Wed Jun 24 23:30:07 1998
+++ linux/Documentation/initrd.txt	Mon Nov 20 01:12:07 2000
@@ -1,25 +1,28 @@
 Using the initial RAM disk (initrd)
 ===================================
 
-Written 1996 by Werner Almesberger <almesber@lrc.epfl.ch> and
-		Hans Lermen <lermen@elserv.ffm.fgan.de>
+Written 1996,2000 by Werner Almesberger <werner.almesberger@epfl.ch> and
+                     Hans Lermen <lermen@fgan.de>
 
 
-initrd adds the capability to load a RAM disk by the boot loader. This
-RAM disk can then be mounted as the root file system and programs can be
-run from it. Afterwards, a new root file system can be mounted from a
-different device. The previous root (from initrd) is then either moved
-to the directory /initrd or it is unmounted.
+initrd provides the capability to load a RAM disk by the boot loader.
+This RAM disk can then be mounted as the root file system and programs
+can be run from it. Afterwards, a new root file system can be mounted
+from a different device. The previous root (from initrd) is then moved
+to a directory and can be subsequently unmounted.
 
 initrd is mainly designed to allow system startup to occur in two phases,
 where the kernel comes up with a minimum set of compiled-in drivers, and
 where additional modules are loaded from initrd.
 
+This document gives a brief overview of the use of initrd. A more detailed
+discussion of the boot process can be found in [1].
+
 
 Operation
 ---------
 
-When using initrd, the system boots as follows:
+When using initrd, the system typically boots as follows:
 
   1) the boot loader loads the kernel and the initial RAM disk
   2) the kernel converts initrd into a "normal" RAM disk and
@@ -28,28 +31,17 @@
   4) /linuxrc is executed (this can be any valid executable, including
      shell scripts; it is run with uid 0 and can do basically everything
      init can do)
-  5) when linuxrc terminates, the "real" root file system is mounted
-  6) if a directory /initrd exists, the initrd is moved there
-     otherwise, initrd is unmounted
+  5) linuxrc mounts the "real" root file system
+  6) linuxrc places the root file system at the root directory using the
+     pivot_root system call
   7) the usual boot sequence (e.g. invocation of /sbin/init) is performed
      on the root file system
+  8) the initrd file system is removed
 
-Note that moving initrd from / to /initrd does not involve unmounting it.
-It is therefore possible to leave processes running on initrd (or leave
-file systems mounted, but see below) during that procedure. However, if
-/initrd doesn't exist, initrd can only be unmounted if it is not used by
-anything. If it can't be unmounted, it will stay in memory.
-
-Also note that file systems mounted under initrd continue to be accessible,
-but their /proc/mounts entries are not updated. Also, if /initrd doesn't
-exist, initrd can't be unmounted and will "disappear" and take those file
-systems with it, thereby preventing them from being re-mounted. It is
-therefore strongly suggested to generally unmount all file systems (except
-of course for the root file system, but including /proc) before switching
-from initrd to the "normal" root file system.
-
-In order to deallocate the memory used for the initial RAM disk, you have
-to execute freeramdisk (see 'Resources' below) after unmounting /initrd.
+Note that changing the root directory does not involve unmounting it.
+It is therefore possible to leave processes running on initrd during that
+procedure. Also note that file systems mounted under initrd continue to
+be accessible.
 
 
 Boot command-line options
@@ -57,7 +49,7 @@
 
 initrd adds the following new options:
 
-  initrd=<path>    (LOADLIN only)
+  initrd=<path>    (e.g. LOADLIN)
 
     Loads the specified file as the initial RAM disk. When using LILO, you
     have to specify the RAM disk image file in /etc/lilo.conf, using the
@@ -71,40 +63,38 @@
     in this case and doesn't necessarily have to be a file system image.
     This option is used mainly for debugging.
 
-    Note that /dev/initrd is read-only and that it can only be used once.
-    As soon as the last process has closed it, all data is freed and
-    /dev/initrd can't be opened any longer.
-
-  root=/dev/ram
-
-    initrd is mounted as root, and /linuxrc is started. If no /linuxrc
-    exists, the normal boot procedure is followed, with the RAM disk
-    still mounted as root. This option is mainly useful when booting from
-    a floppy disk. Compared to directly mounting an on-disk file system,
-    the intermediate step of going via initrd adds a little speed
-    advantage and it allows the use of a compressed file system.
-    Also, together with LOADLIN you may load the RAM disk directly from
-    CDROM or disk, hence having a floppyless boot from CD,
-    e.g.: E:\loadlin E:\bzImage root=/dev/ram initrd=E:\rdimage
+    Note: /dev/initrd is read-only and it can only be used once. As soon
+    as the last process has closed it, all data is freed and /dev/initrd
+    can't be opened anymore.
+
+  root=/dev/ram0   (without devfs)
+  root=/dev/rd/0   (with devfs)
+
+    initrd is mounted as root, and the normal boot procedure is followed,
+    with the RAM disk still mounted as root.
 
 
 Installation
 ------------
 
-First, the "normal" root file system has to be prepared as follows:
+First, a directory for the initrd file system has to be created on the
+"normal" root file system, e.g.
 
-# mknod /dev/initrd b 1 250 
-# chmod 400 /dev/initrd
 # mkdir /initrd
 
+The name is not relevant. More details can be found on the pivot_root(2)
+man page.
+
 If the root file system is created during the boot procedure (i.e. if
-you're creating an install floppy), the root file system creation
-procedure should perform these operations.
+you're building an install floppy), the root file system creation
+procedure should create the /initrd directory.
 
-Note that neither /dev/initrd nor /initrd are strictly required for
-correct operation of initrd, but it is a lot easier to experiment with
-initrd if you have them, and you may also want to use /initrd to pass
-data to the "real" system.
+If initrd will not be mounted in some cases, its content is still
+accessible if the following device has been created (note that this
+does not work if using devfs):
+
+# mknod /dev/initrd b 1 250 
+# chmod 400 /dev/initrd
 
 Second, the kernel has to be compiled with RAM disk support and with
 support for the initial RAM disk enabled. Also, at least all components
@@ -112,100 +102,148 @@
 system) must be compiled into the kernel.
 
 Third, you have to create the RAM disk image. This is done by creating a
-file system on a block device and then by copying files to it as needed.
-With recent kernels, at least three types of devices are suitable for
-that:
+file system on a block device, copying files to it as needed, and then
+copying the content of the block device to the initrd file. With recent
+kernels, at least three types of devices are suitable for that:
 
  - a floppy disk (works everywhere but it's painfully slow)
  - a RAM disk (fast, but allocates physical memory)
- - a loopback device (the most elegant solution, but currently requires a
-   modified mount)
+ - a loopback device (the most elegant solution)
 
-We'll describe the RAM disk method:
+We'll describe the loopback device method:
 
- 1) make sure you have a RAM disk device /dev/ram (block, major 1, minor 0)
+ 1) make sure loopback block devices are configured into the kernel
  2) create an empty file system of the appropriate size, e.g.
-    # mke2fs -m0 /dev/ram 300   
+    # dd if=/dev/zero of=initrd bs=300k count=1
+    # mke2fs -F -m0 initrd
     (if space is critical, you may want to use the Minix FS instead of Ext2)
- 3) mount the file system on an appropriate directory, e.g.
-    # mount -t ext2 /dev/ram /mnt
- 4) create the console device:
+ 3) mount the file system, e.g.
+    # mount -t ext2 -o loop initrd /mnt
+ 4) create the console device (not necessary if using devfs, but it can't
+    hurt to do it anyway):
     # mkdir /mnt/dev
-    # mknod /mnt/dev/tty1 c 4 1
+    # mknod /mnt/dev/console c 5 1
  5) copy all the files that are needed to properly use the initrd
     environment. Don't forget the most important file, /linuxrc
     Note that /linuxrc's permissions must include "x" (execute).
- 6) unmount the RAM disk
-    # umount /dev/ram
- 7) copy the image to a file
-    # dd if=/dev/ram bs=1k count=300 of=/boot/initrd
- 8) deallocate the RAM disk
-    # freeramdisk /dev/ram
-
-For experimenting with initrd, you may want to take a rescue floppy (e.g.
-rescue.gz from Slackware) and only add a symbolic link from /linuxrc to
-/bin/sh, e.g.
-
- # gunzip <rescue.gz >/dev/ram
- # mount -t minix /dev/ram /mnt
- # ln -s /bin/sh /mnt/linuxrc
- # umount /dev/ram
- # dd if=/dev/ram bs=1k count=1440 of=/boot/initrd
- # freeramdisk /dev/ram
-
-Finally, you have to boot the kernel and load initrd. Currently,
-preliminary versions of LOADLIN 1.6 and LILO 18 support initrd (see
-below for where to get them). With LOADLIN, you simply execute
+ 6) correct operation the initrd environment can frequently be tested
+    even without rebooting with the command
+    # chroot /mnt /linuxrc
+    This is of course limited to initrds that do not interfere with the
+    general system state (e.g. by reconfiguring network interfaces,
+    overwriting mounted devices, trying to start already running demons,
+    etc. Note however that it is usually possible to use pivot_root in
+    such a chroot'ed initrd environment.)
+ 7) unmount the file system
+    # umount /mnt
+ 8) the initrd is now in the file "initrd". Optionally, it can now be
+    compressed
+    # gzip -9 initrd
+
+For experimenting with initrd, you may want to take a rescue floppy and
+only add a symbolic link from /linuxrc to /bin/sh. Alternatively, you
+can try the experimental newlib environment [2] to create a small
+initrd.
+
+Finally, you have to boot the kernel and load initrd. Almost all Linux
+boot loaders support initrd. Since the boot process is still compatible
+with an older mechanism, the following boot command line parameters
+have to be given:
+
+  root=/dev/ram0 init=/linuxrc rw
+
+if not using devfs, or
+
+  root=/dev/rd/0 init=/linuxrc rw
+
+if using devfs. (rw is only necessary if writing to the initrd file
+system.)
+
+With LOADLIN, you simply execute
 
      LOADLIN <kernel> initrd=<disk_image>
-e.g. LOADLIN C:\LINUX\VMLINUZ initrd=C:\LINUX\INITRD
+e.g. LOADLIN C:\LINUX\BZIMAGE initrd=C:\LINUX\INITRD.GZ root=/dev/ram0
+       init=/linuxrc rw
 
 With LILO, you add the option INITRD=<path> to either the global section
-or to the section of the respective kernel in /etc/lilo.conf, e.g.
+or to the section of the respective kernel in /etc/lilo.conf, and pass
+the options using APPEND, e.g.
 
-  image = /vmlinuz
-    initrd = /boot/initrd
+  image = /bzImage
+    initrd = /boot/initrd.gz
+    append = "root=/dev/ram0 init=/linuxrc rw"
 
 and run /sbin/lilo
 
-Now you can boot and enjoy using initrd.
-
+For other boot loaders, please refer to the respective documentation.
 
-Setting the root device
------------------------
+Now you can boot and enjoy using initrd.
 
-By default, the standard settings in the kernel are used for the root
-device, i.e. the default compiled in or set with rdev, or what was passed
-with root=xxx on the command line, or, with LILO, what was specified in
-/etc/lilo.conf It is also possible to use initrd with an NFS-mounted
-root; you have to use the nfs_root_name and nfs_root_addrs boot options
-for this.
-
-It is also possible to change the root device from within the initrd
-environment. In order to do so, /proc has to be mounted. Then, the
-following files are available:
-
-  /proc/sys/kernel/real-root-dev
-  /proc/sys/kernel/nfs-root-name
-  /proc/sys/kernel/nfs-root-addrs
 
-real-root-dev can be changed by writing the number of the new root FS
-device to it, e.g.
+Changing the root device
+------------------------
 
-  # echo 0x301 >/proc/sys/kernel/real-root-dev
+When finished with its duties, linuxrc typically changes the root device
+and proceeds with starting the Linux system on the "real" root device.
 
-for /dev/hda1. When using an NFS-mounted root, nfs-root-name and
-nfs-root-addrs have to be set accordingly and then real-root-dev has to
-be set to 0xff, e.g.
-
-  # echo /var/nfsroot >/proc/sys/kernel/nfs-root-name
-  # echo 193.8.232.2:193.8.232.7::255.255.255.0:idefix \
-    >/proc/sys/kernel/nfs-root-addrs
-  # echo 255 >/proc/sys/kernel/real-root-dev
-
-If the root device is set to the RAM disk, the root file system is not
-moved to /initrd, but the boot procedure is simply continued by starting
-init on the initial RAM disk.
+The procedure involves the following steps:
+ - mounting the new root file system
+ - turning it into the root file system
+ - removing all accesses to the old (initrd) root file system
+ - unmounting the initrd file system and de-allocating the RAM disk
+
+Mounting the new root file system is easy: it just needs to be mounted on
+a directory under the current root. Example:
+
+# mkdir /new-root
+# mount -o ro /dev/hda1 /new-root
+
+The root change is accomplished with the pivot_root system call, which
+is also available via the pivot_root utility (see pivot_root(8) man
+page; pivot_root is distributed with util-linux version 2.10h or higher
+[3]). pivot_root moves the current root to a directory under the new
+root, and puts the new root at its place. The directory for the old root
+must exist before calling pivot_root. Example:
+
+# cd /new-root
+# mkdir initrd
+# pivot_root . initrd
+
+Now, the linuxrc process may still access the old root via its
+executable, shared libraries, standard input/output/error, and its
+current root directory. All these references are dropped by the
+following command:
+
+# exec chroot . what-follows <dev/console >dev/console 2>&1
+
+Where what-follows is a program under the new root, e.g. /sbin/init
+If the new root file system will be used with devfs and has no valid
+/dev directory, devfs must be mounted before invoking chroot in order to
+provide /dev/console.
+
+Note: implementation details of pivot_root may change with time. In order
+to ensure compatibility, the following points should be observed:
+
+ - before calling pivot_root, the current directory of the invoking
+   process should point to the new root directory
+ - use . as the first argument, and the _relative_ path of the directory
+   for the old root as the second argument
+ - a chroot program must be available under the old and the new root
+ - chroot to the new root afterwards
+ - use relative paths for dev/console in the exec command
+
+Now, the initrd can be unmounted and the memory allocated by the RAM
+disk can be freed:
+
+# umount /initrd
+# blockdev --flushbufs /dev/ram0    # /dev/rd/0 if using devfs
+
+It is also possible to use initrd with an NFS-mounted root, see the
+pivot_root(8) man page for details.
+
+Note: if linuxrc or any program exec'ed from it terminates for some
+reason, the old change_root mechanism is invoked (see section "Obsolete
+root change mechanism").
 
 
 Usage scenarios
@@ -215,32 +253,30 @@
 kernel configuration at system installation. The procedure would work
 as follows:
 
-  1) systems boots from floppy or other media with a minimal kernel
-     (e.g. support for RAM disks, initrd, a.out, and the ext2 FS) and
+  1) system boots from floppy or other media with a minimal kernel
+     (e.g. support for RAM disks, initrd, a.out, and the Ext2 FS) and
      loads initrd
   2) /linuxrc determines what is needed to (1) mount the "real" root FS
      (i.e. device type, device drivers, file system) and (2) the
      distribution media (e.g. CD-ROM, network, tape, ...). This can be
      done by asking the user, by auto-probing, or by using a hybrid
      approach.
-  3) /linuxrc loads the necessary modules
+  3) /linuxrc loads the necessary kernel modules
   4) /linuxrc creates and populates the root file system (this doesn't
      have to be a very usable system yet)
-  5) /linuxrc unmounts the root file system and possibly any other file
-     systems it has mounted, sets /proc/sys/kernel/..., and terminates
-  6) the root file system is mounted
-  7) now that we're sure that the file system is accessible and intact,
-     the boot loader can be installed
-  8) the boot loader is configured to load an initrd with the set of
+  5) /linuxrc invokes pivot_root to change the root file system and
+     execs - via chroot - a program that continues the installation
+  6) the boot loader is installed
+  7) the boot loader is configured to load an initrd with the set of
      modules that was used to bring up the system (e.g. /initrd can be
      modified, then unmounted, and finally, the image is written from
-     /dev/ram to a file)
-  9) now the system is bootable and additional installation tasks can be
+     /dev/ram0 or /dev/rd/0 to a file)
+  8) now the system is bootable and additional installation tasks can be
      performed
 
 The key role of initrd here is to re-use the configuration data during
 normal system operation without requiring the use of a bloated "generic"
-kernel or re-compilation or re-linking of the kernel.
+kernel or re-compiling or re-linking the kernel.
 
 A second scenario is for installations where Linux runs on systems with
 different hardware configurations in a single administrative domain. In
@@ -252,35 +288,53 @@
 
 A third scenario are more convenient recovery disks, because information
 like the location of the root FS partition doesn't have to be provided at
-boot time, but the system loaded from initrd can use a user-friendly
+boot time, but the system loaded from initrd can invoke a user-friendly
 dialog and it can also perform some sanity checks (or even some form of
 auto-detection).
 
-Last not least, CDROM distributors may use it for better installation from CD,
-either using a LILO boot floppy and bootstrapping a bigger RAM disk via
-initrd from CD, or using LOADLIN to directly load the RAM disk from CD
-without need of floppies.
+Last not least, CD-ROM distributors may use it for better installation
+from CD, e.g. by using a boot floppy and bootstrapping a bigger RAM disk
+via initrd from CD; or by booting via a loader like LOADLIN or directly
+from the CD-ROM, and loading the RAM disk from CD without need of
+floppies. 
+
+
+Obsolete root change mechanism
+------------------------------
+
+The following mechanism was used before the introduction of pivot_root.
+Current kernels still support it, but you should _not_ rely on its
+continued availability.
+
+It works by mounting the "real" root device (i.e. the one set with rdev
+in the kernel image or with root=... at the boot command line) as the
+root file system when linuxrc exits. The initrd file system is then
+unmounted, or, if it is still busy, moved to a directory /initrd, if
+such a directory exists on the new root file system.
+
+In order to use this mechanism, you do not have to specify the boot
+command options root, init, or rw. (If specified, they will affect
+the real root file system, not the initrd environment.)
+  
+If /proc is mounted, the "real" root device can be changed from within
+linuxrc by writing the number of the new root FS device to the special
+file /proc/sys/kernel/real-root-dev, e.g.
+
+  # echo 0x301 >/proc/sys/kernel/real-root-dev
+
+Note that the mechanism is incompatible with NFS and similar file
+systems.
 
-Since initrd is a fairly generic mechanism, it is likely that additional
-uses will be found.
+This old, deprecated mechanism is commonly called "change_root", while
+the new, supported mechanism is called "pivot_root".
 
 
 Resources
 ---------
 
-The bzImage+initrd patch (bzImage is an extension to load kernels directly
-above 1 MB, which allows kernels sizes of up to approximately 2 MB) can be
-found at
-ftp://lrcftp.epfl.ch/pub/people/almesber/lilo/bzImage+initrd-1.3.71.patch.gz
-and
-ftp://elserv.ffm.fgan.de/pub/linux/loadlin-1.6/bzImage+initrd-1.3.71.patch.gz
-
-A preliminary version of LOADLIN 1.6 is available on
-ftp://elserv.ffm.fgan.de/pub/linux/loadlin-1.6/loadlin-1.6-pre8-bin.tgz
-
-A preliminary version of LILO 18 is available on
-ftp://lrcftp.epfl.ch/pub/people/almesber/lilo/lilo.18dev3.tar.gz
-
-A very simple example for building an image for initrd, also including
-the program 'freeramdisk', can be found on
-ftp://elserv.ffm.fgan.de/pub/linux/loadlin-1.6/initrd-example.tgz
+[1] Almesberger, Werner; "Booting Linux: The History and the Future"
+    ftp://icaftp.epfl.ch/pub/people/almesber/booting/bootinglinux-current.ps.gz
+[2] newlib package (experimental), with initrd example
+    ftp://icaftp.epfl.ch/pub/people/almesber/misc/newlib-linux/
+[3] Brouwer, Andries; "util-linux: Miscellaneous utilities for Linux"
+    ftp://ftp.win.tue.nl/pub/linux-local/utils/util-linux/

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
