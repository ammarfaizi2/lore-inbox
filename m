Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbUJWUG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbUJWUG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 16:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbUJWUG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 16:06:28 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:47055 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261287AbUJWUDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 16:03:45 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: james4765@verizon.net
Message-Id: <20041023200344.10839.30049.60955@localhost.localdomain>
Subject: [PATCH] to Documentation/ramdisk.txt
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [209.158.211.53] at Sat, 23 Oct 2004 15:03:44 -0500
Date: Sat, 23 Oct 2004 15:03:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All right - Try 3 with the sendpatchset script.

Thanks to Paul Jackson for the help in getting it to work w/ my ISP.

Description: General cleanup and updating of ramdisk.txt file in the Documentation
directory.  Apply against 2.6.9.

Signed-off by: Jim Nelson <james4765@gmail.com>

diff -urN linux-2.6.9-original/Documentation/ramdisk.txt linux-2.6.9/Documentation/ramdisk.txt

--- linux-2.6.9-original/Documentation/ramdisk.txt	2004-08-14 01:36:13.000000000 -0400
+++ linux-2.6.9/Documentation/ramdisk.txt	2004-10-22 22:38:12.408538109 -0400
@@ -5,115 +5,66 @@
 
 	1) Overview
 	2) Kernel Command Line Parameters
-	3) Using "rdev -r" With New Kernels
+	3) Using "rdev -r"
 	4) An Example of Creating a Compressed RAM Disk 
 
 
 1) Overview
 -----------
 
-As of kernel v1.3.48, the RAM disk driver was substantially changed.
-
-The older versions would grab a chunk of memory off the top before
-handing the remainder to the kernel at boot time. Thus a size parameter
-had to be specified via "ramdisk=1440" or "rdev -r /dev/fd0 1440" so
-that the driver knew how much memory to grab.
-
-Now the RAM disk dynamically grows as more space is required. It does
-this by using RAM from the buffer cache. The driver marks the buffers
-it is using with a new "BH_Protected" flag so that the kernel does 
-not try to reuse them later. This means that the old size parameter
-is no longer used, new command line parameters exist, and the behavior
-of the "rdev -r" or "ramsize" (usually a symbolic link to "rdev")
-command has changed.
-
-Also, the new RAM disk supports up to 16 RAM disks out of the box, and can
-be reconfigured in rd.c to support up to 255 RAM disks.  To use multiple
-RAM disk support with your system, run 'mknod /dev/ramX b 1 X' and chmod
-(to change its permissions) it to your liking.  The default /dev/ram(disk)
-uses minor #1, so start with ram2 and go from there.
-
-The old "ramdisk=<ram_size>" has been changed to "ramdisk_size=<ram_size>"
-to make it clearer.  The original "ramdisk=<ram_size>" has been kept around
-for compatibility reasons, but it will probably be removed in 2.1.x.
+The RAM disk driver is a way to use main system memory as a block device.  It
+is required for initrd, an initial filesystem used if you need to load modules
+in order to access the root filesystem (see Documentation/initrd.txt).  It can
+also be used for a temporary filesystem for crypto work, since the contents
+are erased on reboot.
+
+The RAM disk dynamically grows as more space is required. It does this by using
+RAM from the buffer cache. The driver marks the buffers it is using as dirty
+so that the VM subsystem does not try to reclaim them later.
+
+Also, the RAM disk supports up to 16 RAM disks out of the box, and can
+be reconfigured to support up to 255 RAM disks - change "#define NUM_RAMDISKS"
+in drivers/block/rd.c.  To use RAM disk support with your system, run
+'./MAKEDEV ram' from the /dev directory.  RAM disks are all major number 1, and
+start with minor number 0 for /dev/ram0, etc.  If used, modern kernels use
+/dev/ram0 for an initrd.
+
+The old "ramdisk=<ram_size>" has been changed to "ramdisk_size=<ram_size>" to
+make it clearer.  The original "ramdisk=<ram_size>" has been kept around for
+compatibility reasons, but it may be removed in the future.
 
 The new RAM disk also has the ability to load compressed RAM disk images,
 allowing one to squeeze more programs onto an average installation or 
 rescue floppy disk.
 
-Notes: You may have "/dev/ram" or "/dev/ramdisk" or both. They are
-equivalent from the standpoint of this document. Also, the new RAM disk
-is a config option. When running "make config", make sure you enable
-RAM disk support for the kernel with which you intend to use the RAM disk.
-
 
 2) Kernel Command Line Parameters
 ---------------------------------
 
-	ramdisk_start=NNN
-	=================
-
-To allow a kernel image to reside on a floppy disk along with a compressed
-RAM disk image, the "ramdisk_start=<offset>" command was added. The kernel
-can't be included into the compressed RAM disk filesystem image, because
-it needs to be stored starting at block zero so that the BIOS can load the 
-boot sector and then the kernel can bootstrap itself to get going.
-
-Note: If you are using an uncompressed RAM disk image, then the kernel can
-be a part of the filesystem image that is being loaded into the RAM disk,
-and the floppy can be booted with LILO, or the two can be separate as
-is done for the compressed images.
-
-If you are using a two-disk boot/root setup (kernel on #1, RAM disk image
-on #2) then the RAM disk would start at block zero, and an offset of
-zero would be used. Since this is the default value, you would not need
-to actually use the command at all.
-
-If instead, you have a "zImage" of about 350 kB, and a "fs_image.gz" of
-say about 1 MB, and you want them both on the same disk, then you
-would use an offset. If you stored the "fs_image.gz" onto the floppy
-starting at an offset of 400 kB, you would use "ramdisk_start=400".
-
-
-	load_ramdisk=N
-	==============
-
-This parameter tells the kernel whether it is to try to load a
-RAM disk image or not. Specifying "load_ramdisk=1" will tell the
-kernel to load a floppy into the RAM disk. The default value is
-zero, meaning that the kernel should not try to load a RAM disk.
-
-
-	prompt_ramdisk=N
-	================
-
-This parameter tells the kernel whether or not to give you a prompt
-asking you to insert the floppy containing the RAM disk image. In
-a single floppy configuration the RAM disk image is on the same floppy
-as the kernel that just finished loading/booting and so a prompt
-is not needed. In this case one can use "prompt_ramdisk=0". In a
-two floppy configuration, you will need the chance to switch disks,
-and thus "prompt_ramdisk=1" can be used. Since this is the default 
-value, it doesn't really need to be specified.
-
 	ramdisk_size=N
 	==============
 
 This parameter tells the RAM disk driver to set up RAM disks of N k size.  The
-default is 4096 (4 MB). 
+default is 4096 (4 MB) (8192 (8 MB) on S390).
+
+	ramdisk_blocksize=N
+	===================
+
+This parameter tells the RAM disk driver how many bytes to use per block.  The
+default is 512.
 
-3) Using "rdev -r" With New Kernels
------------------------------------
 
-The usage of the word (two bytes) that "rdev -r" sets in the kernel image
-has changed. The low 11 bits (0 -> 10) specify an offset (in 1 k blocks) 
-of up to 2 MB (2^11) of where to find the RAM disk (this used to be the 
-size). Bit 14 indicates that a RAM disk is to be loaded, and bit 15
-indicates whether a prompt/wait sequence is to be given before trying
-to read the RAM disk. Since the RAM disk dynamically grows as data is
-being written into it, a size field is no longer required. Bits 11
-to 13 are not currently used and may as well be zero. These numbers
-are no magical secrets, as seen below:
+3) Using "rdev -r"
+------------------
+
+The usage of the word (two bytes) that "rdev -r" sets in the kernel image is
+as follows. The low 11 bits (0 -> 10) specify an offset (in 1 k blocks) of up
+to 2 MB (2^11) of where to find the RAM disk (this used to be the size). Bit
+14 indicates that a RAM disk is to be loaded, and bit 15 indicates whether a
+prompt/wait sequence is to be given before trying to read the RAM disk. Since
+the RAM disk dynamically grows as data is being written into it, a size field
+is not required. Bits 11 to 13 are not currently used and may as well be zero.
+These numbers are no magical secrets, as seen below:
 
 ./arch/i386/kernel/setup.c:#define RAMDISK_IMAGE_START_MASK     0x07FF
 ./arch/i386/kernel/setup.c:#define RAMDISK_PROMPT_FLAG          0x8000
@@ -152,10 +103,10 @@
 To create a RAM disk image, you will need a spare block device to
 construct it on. This can be the RAM disk device itself, or an
 unused disk partition (such as an unmounted swap partition). For this 
-example, we will use the RAM disk device, "/dev/ram".
+example, we will use the RAM disk device, "/dev/ram0".
 
 Note: This technique should not be done on a machine with less than 8 MB
-of RAM. If using a spare disk partition instead of /dev/ram, then this
+of RAM. If using a spare disk partition instead of /dev/ram0, then this
 restriction does not apply.
 
 a) Decide on the RAM disk size that you want. Say 2 MB for this example.
@@ -164,11 +115,11 @@
    area (esp. for disks) so that maximal compression is achieved for
    the unused blocks of the image that you are about to create.
 
-	dd if=/dev/zero of=/dev/ram bs=1k count=2048
+	dd if=/dev/zero of=/dev/ram0 bs=1k count=2048
 
 b) Make a filesystem on it. Say ext2fs for this example.
 
-	mke2fs -vm0 /dev/ram 2048
+	mke2fs -vm0 /dev/ram0 2048
 
 c) Mount it, copy the files you want to it (eg: /etc/* /dev/* ...)
    and unmount it again.
@@ -177,7 +128,7 @@
    will be approximately 50% of the space used by the files. Unused
    space on the RAM disk will compress to almost nothing.
 
-	dd if=/dev/ram bs=1k count=2048 | gzip -v9 > /tmp/ram_image.gz
+	dd if=/dev/ram0 bs=1k count=2048 | gzip -v9 > /tmp/ram_image.gz
 
 e) Put the kernel onto the floppy
 
@@ -203,4 +154,14 @@
 users may wish to combine steps (d) and (f) by using a pipe.
 
 --------------------------------------------------------------------------
-						Paul Gortmaker 12/95	
+						Paul Gortmaker 12/95
+
+Changelog:
+----------
+
+10-22-04 :	Updated to reflect changes in command line options, remove
+		obsolete references, general cleanup.
+		James Nelson (james4765@gmail.com)
+	
+
+12-95 :		Original Document
