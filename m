Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281174AbRKLXTS>; Mon, 12 Nov 2001 18:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281177AbRKLXTL>; Mon, 12 Nov 2001 18:19:11 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:10510 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S281181AbRKLXSy>; Mon, 12 Nov 2001 18:18:54 -0500
Date: Tue, 13 Nov 2001 00:18:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: PATCH: addition to real_root_dev patch
Message-ID: <Pine.LNX.4.33.0111130012050.489-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch below adds the proper conversion function to convert
real_root_dev (which is now int) into/from kdev_t.

bye, Roman

diff -ur -X /opt/home/roman/nodiff linux-2.4/drivers/block/rd.c linux-kdev/drivers/block/rd.c
--- linux-2.4/drivers/block/rd.c	Mon Nov 12 22:30:24 2001
+++ linux-kdev/drivers/block/rd.c	Mon Nov 12 22:21:50 2001
@@ -809,13 +809,14 @@

 static void __init rd_load_disk(int n)
 {
+	kdev_t real_root = to_kdev_t(real_root_dev);

 	if (rd_doload == 0)
 		return;

 	if (MAJOR(ROOT_DEV) != FLOPPY_MAJOR
 #ifdef CONFIG_BLK_DEV_INITRD
-		&& MAJOR(real_root_dev) != FLOPPY_MAJOR
+		&& MAJOR(real_root) != FLOPPY_MAJOR
 #endif
 	)
 		return;
@@ -827,8 +828,8 @@
 #ifdef CONFIG_MAC_FLOPPY
 		if(MAJOR(ROOT_DEV) == FLOPPY_MAJOR)
 			swim3_fd_eject(MINOR(ROOT_DEV));
-		else if(MAJOR(real_root_dev) == FLOPPY_MAJOR)
-			swim3_fd_eject(MINOR(real_root_dev));
+		else if(MAJOR(real_root) == FLOPPY_MAJOR)
+			swim3_fd_eject(MINOR(real_root));
 #endif
 		printk(KERN_NOTICE
 		       "VFS: Insert root floppy disk to be loaded into RAM disk and press ENTER\n");
diff -ur -X /opt/home/roman/nodiff linux-2.4/include/linux/devfs_fs_kernel.h linux-kdev/include/linux/devfs_fs_kernel.h
--- linux-2.4/include/linux/devfs_fs_kernel.h	Sun Sep 23 22:56:16 2001
+++ linux-kdev/include/linux/devfs_fs_kernel.h	Mon Nov 12 22:24:25 2001
@@ -49,7 +49,7 @@


 #ifdef CONFIG_BLK_DEV_INITRD
-#  define ROOT_DEVICE_NAME ((real_root_dev ==ROOT_DEV) ? root_device_name:NULL)
+#  define ROOT_DEVICE_NAME ((to_kdev_t(real_root_dev) == ROOT_DEV) ? root_device_name:NULL)
 #else
 #  define ROOT_DEVICE_NAME root_device_name
 #endif
diff -ur -X /opt/home/roman/nodiff linux-2.4/init/main.c linux-kdev/init/main.c
--- linux-2.4/init/main.c	Mon Nov 12 22:30:31 2001
+++ linux-kdev/init/main.c	Mon Nov 12 22:26:28 2001
@@ -752,7 +752,7 @@
 		mount_initrd = 0;
 	if (mount_initrd)
 		root_mountflags &= ~MS_RDONLY;
-	real_root_dev = ROOT_DEV;
+	real_root_dev = kdev_t_to_nr(ROOT_DEV);
 #endif

 #ifdef CONFIG_BLK_DEV_RAM
@@ -771,7 +771,7 @@

 #ifdef CONFIG_BLK_DEV_INITRD
 	root_mountflags = real_root_mountflags;
-	if (mount_initrd && ROOT_DEV != real_root_dev
+	if (mount_initrd && ROOT_DEV != to_kdev_t(real_root_dev)
 	    && MAJOR(ROOT_DEV) == RAMDISK_MAJOR && MINOR(ROOT_DEV) == 0) {
 		int error;
 		int i, pid;
@@ -783,9 +783,9 @@
 				schedule();
 			}
 		}
-		if (MAJOR(real_root_dev) != RAMDISK_MAJOR
-		     || MINOR(real_root_dev) != 0) {
-			error = change_root(real_root_dev,"/initrd");
+		if (MAJOR(to_kdev_t(real_root_dev)) != RAMDISK_MAJOR
+		     || MINOR(to_kdev_t(real_root_dev)) != 0) {
+			error = change_root(to_kdev_t(real_root_dev),"/initrd");
 			if (error)
 				printk(KERN_ERR "Change root to /initrd: "
 				    "error %d\n",error);

