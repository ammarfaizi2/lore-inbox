Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWFNVGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWFNVGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 17:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbWFNVGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 17:06:04 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:46049
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932310AbWFNVGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 17:06:02 -0400
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Initramfs docs update.
Date: Wed, 14 Jun 2006 17:06:00 -0400
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606141706.00390.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New section on creating an external initramfs image using cpio (with script),
a warning about bad advice in the cpio man page, a bit of debugging advice
(hello world and rdinit=/bin/sh), and a few minor tweaks to other parts of it.

Signed-off-by: Rob Landley <rob@landley.net>

--- linux-old/Documentation/filesystems/ramfs-rootfs-initramfs.txt	2006-06-14 13:20:34.000000000 -0400
+++ linux-2.6.16.20/Documentation/filesystems/ramfs-rootfs-initramfs.txt	2006-06-14 16:47:30.000000000 -0400
@@ -70,11 +70,13 @@
 What is rootfs?
 ---------------
 
-Rootfs is a special instance of ramfs, which is always present in 2.6 systems.
-(It's used internally as the starting and stopping point for searches of the
-kernel's doubly-linked list of mount points.)
+Rootfs is a special instance of ramfs (or tmpfs, if that's enabled), which is
+always present in 2.6 systems.  You can't unmount rootfs for approximately the
+same reason you can't kill the init process; rather than having special code
+to check for and handle an empty list, it's smaller and simpler for the kernel
+to just make sure certain lists can't become empty.
 
-Most systems just mount another filesystem over it and ignore it.  The
+Most systems just mount another filesystem over rootfs and ignore it.  The
 amount of space an empty instance of ramfs takes up is tiny.
 
 What is initramfs?
@@ -92,14 +94,16 @@
 
 All this differs from the old initrd in several ways:
 
-  - The old initrd was a separate file, while the initramfs archive is linked
-    into the linux kernel image.  (The directory linux-*/usr is devoted to
-    generating this archive during the build.)
+  - The old initrd was always a separate file, while the initramfs archive is
+    linked into the linux kernel image.  (The directory linux-*/usr is devoted
+    to generating this archive during the build.)
 
   - The old initrd file was a gzipped filesystem image (in some file format,
-    such as ext2, that had to be built into the kernel), while the new
+    such as ext2, that needed a driver built into the kernel), while the new
     initramfs archive is a gzipped cpio archive (like tar only simpler,
-    see cpio(1) and Documentation/early-userspace/buffer-format.txt).
+    see cpio(1) and Documentation/early-userspace/buffer-format.txt).  The
+    kernel's cpio extraction code is not only extremely small, it's also
+    __init data that can be discarded during the boot process.
 
   - The program run by the old initrd (which was called /initrd, not /init) did
     some setup and then returned to the kernel, while the init program from
@@ -124,13 +128,14 @@
 
 The 2.6 kernel build process always creates a gzipped cpio format initramfs
 archive and links it into the resulting kernel binary.  By default, this
-archive is empty (consuming 134 bytes on x86).  The config option
-CONFIG_INITRAMFS_SOURCE (for some reason buried under devices->block devices
-in menuconfig, and living in usr/Kconfig) can be used to specify a source for
-the initramfs archive, which will automatically be incorporated into the
-resulting binary.  This option can point to an existing gzipped cpio archive, a
-directory containing files to be archived, or a text file specification such
-as the following example:
+archive is empty (consuming 134 bytes on x86).
+
+The config option CONFIG_INITRAMFS_SOURCE (for some reason buried under
+devices->block devices in menuconfig, and living in usr/Kconfig) can be used
+to specify a source for the initramfs archive, which will automatically be
+incorporated into the resulting binary.  This option can point to an existing
+gzipped cpio archive, a directory containing files to be archived, or a text
+file specification such as the following example:
 
   dir /dev 755 0 0
   nod /dev/console 644 0 0 c 5 1
@@ -146,23 +151,84 @@
 Run "usr/gen_init_cpio" (after the kernel build) to get a usage message
 documenting the above file format.
 
-One advantage of the text file is that root access is not required to
+One advantage of the configuration file is that root access is not required to
 set permissions or create device nodes in the new archive.  (Note that those
 two example "file" entries expect to find files named "init.sh" and "busybox" in
 a directory called "initramfs", under the linux-2.6.* directory.  See
 Documentation/early-userspace/README for more details.)
 
-The kernel does not depend on external cpio tools, gen_init_cpio is created
-from usr/gen_init_cpio.c which is entirely self-contained, and the kernel's
-boot-time extractor is also (obviously) self-contained.  However, if you _do_
-happen to have cpio installed, the following command line can extract the
-generated cpio image back into its component files:
+The kernel does not depend on external cpio tools.  If you specify a
+directory instead of a configuration file, the kernel's build infrastructure
+creates a configuration file from that directory (usr/Makefile calls
+scripts/gen_initramfs_list.sh), and proceeds to package up that directory
+using the config file (by feeding it to usr/gen_init_cpio, which is created
+from usr/gen_init_cpio.c).  The kernel's build-time cpio creation code is
+entirely self-contained, and the kernel's boot-time extractor is also
+(obviously) self-contained.
+
+The one thing you might need external cpio utilities installed for is creating
+or extracting your own preprepared cpio files to feed to the kernel build
+(instead of a config file or directory).
+
+The following command line can extract a cpio image (either by the above script
+or by the kernel build) back into its component files:
 
   cpio -i -d -H newc -F initramfs_data.cpio --no-absolute-filenames
 
+The following shell script can create a prebuilt cpio archive you can
+use in place of the above config file:
+
+  #!/bin/sh
+
+  # Copyright 2006 Rob Landley <rob@landley.net> and TimeSys Corporation.
+  # Licensed under GPL version 2
+
+  if [ $# -ne 2 ]
+  then
+    echo "usage: mkinitramfs directory imagename.cpio.gz"
+    exit 1
+  fi
+
+  if [ -d "$1" ]
+  then
+    echo "creating $2 from $1"
+    (cd "$1"; find . | cpio -o -H newc | gzip) > "$2"
+  else
+    echo "First argument must be a directory"
+    exit 1
+  fi
+
+Note: The cpio man page contains some bad advice that will break your initramfs
+archive if you follow it.  It says "A typical way to generate the list
+of filenames is with the find command; you should give find the -depth option
+to minimize problems with permissions on directories that are unwritable or not
+searchable."  Don't do this when creating initramfs.cpio.gz images, it won't
+work.  The Linux kernel cpio extractor won't create files in a directory that
+doesn't exist, so the directory entries must go before the files that go in
+those directories.  The above script gets them in the right order.
+
+External initramfs images:
+--------------------------
+
+If the kernel has initrd support enabled, an external cpio.gz archive can also
+be passed into a 2.6 kernel in place of an initrd.  In this case, the kernel
+will autodetect the type (initramfs, not initrd) and extract the external cpio
+archive into rootfs before trying to run /init.
+
+This has the memory efficiency advantages of initramfs (no ramdisk block
+device) but the separate packaging of initrd (which is nice if you have
+non-GPL code you'd like to run from initramfs, without conflating it with
+the GPL licensed Linux kernel binary).
+
+It can also be used to supplement the kernel's built-in initamfs image.  The
+files in the external archive will overwrite any conflicting files in
+the built-in initramfs archive.  Some distributors also prefer to customize
+a single kernel image with task-specific initramfs images, without recompiling.
+
 Contents of initramfs:
 ----------------------
 
+An initramfs archive is a complete self-contained root filesystem for Linux.
 If you don't already understand what shared libraries, devices, and paths
 you need to get a minimal root filesystem up and running, here are some
 references:
@@ -176,13 +242,36 @@
 
 I use uClibc (http://www.uclibc.org) and busybox (http://www.busybox.net)
 myself.  These are LGPL and GPL, respectively.  (A self-contained initramfs
-package is planned for the busybox 1.2 release.)
+package is planned for the busybox 1.3 release.)
 
 In theory you could use glibc, but that's not well suited for small embedded
 uses like this.  (A "hello world" program statically linked against glibc is
 over 400k.  With uClibc it's 7k.  Also note that glibc dlopens libnss to do
 name lookups, even when otherwise statically linked.)
 
+A good first step is to get initramfs to run a statically linked "hello world"
+program as init, and test it under an emulator like qemu (www.qemu.org) or
+User Mode Linux, like so:
+
+  cat > hello.c << EOF
+  #include <stdio.h>
+  #include <unistd.h>
+
+  int main(int argc, char *argv[])
+  {
+    printf("Hello world!\n");
+    sleep(999999999);
+  }
+  EOF
+  gcc -static hello2.c -o init
+  echo init | cpio -o -H newc | gzip > test.cpio.gz
+  # Testing external initramfs using the initrd loading mechanism.
+  qemu -kernel /boot/vmlinuz -initrd test.cpio.gz /dev/zero
+
+When debugging a normal root filesystem, it's nice to be able to boot with
+"init=/bin/sh".  The initramfs equivalent is "rdinit=/bin/sh", and it's
+just as useful.
+
 Why cpio rather than tar?
 -------------------------
 
@@ -241,7 +330,7 @@
 Future directions:
 ------------------
 
-Today (2.6.14), initramfs is always compiled in, but not always used.  The
+Today (2.6.16), initramfs is always compiled in, but not always used.  The
 kernel falls back to legacy boot code that is reached only if initramfs does
 not contain an /init program.  The fallback is legacy code, there to ensure a
 smooth transition and allowing early boot functionality to gradually move to
@@ -258,8 +347,9 @@
 
 This kind of complexity (which inevitably includes policy) is rightly handled
 in userspace.  Both klibc and busybox/uClibc are working on simple initramfs
-packages to drop into a kernel build, and when standard solutions are ready
-and widely deployed, the kernel's legacy early boot code will become obsolete
-and a candidate for the feature removal schedule.
+packages to drop into a kernel build.
 
-But that's a while off yet.
+The klibc package has now been accepted into Andrew Morton's 2.6.17-mm tree.
+The kernel's current early boot code (partition detection, etc) will probably
+be migrated into a default initramfs, automatically created and used by the
+kernel build.

-- 
Never bet against the cheap plastic solution.
