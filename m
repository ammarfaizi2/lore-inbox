Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbTD3PVI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbTD3PVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:21:08 -0400
Received: from verein.lst.de ([212.34.181.86]:57868 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262277AbTD3PU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:20:57 -0400
Date: Wed, 30 Apr 2003 17:33:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] use .devfs_name in struct miscdevice
Message-ID: <20030430173315.A4057@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's three drivers in the tree that workaround the suboptimal
devfs name choice of the misc device layer (/dev/misc/<foo>) using
devfs_mk_symlink.    Switch them to set miscdev.devfs_name instead
to get the right name from the very beginning.



--- 1.18/arch/i386/kernel/microcode.c	Thu Mar 27 11:24:37 2003
+++ edited/arch/i386/kernel/microcode.c	Wed Apr 30 16:19:41 2003
@@ -65,7 +65,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/miscdevice.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 
@@ -116,9 +115,10 @@
 };
 
 static struct miscdevice microcode_dev = {
-	.minor = MICROCODE_MINOR,
-	.name	= "microcode",
-	.fops	= &microcode_fops,
+	.minor		= MICROCODE_MINOR,
+	.name		= "microcode",
+	.devfs_name	= "cpu/microcode",
+	.fops		= &microcode_fops,
 };
 
 static int __init microcode_init(void)
@@ -127,26 +127,17 @@
 
 	error = misc_register(&microcode_dev);
 	if (error)
-		goto fail;
-	error = devfs_mk_symlink("cpu/microcode", "../misc/microcode");
-	if (error)
-		goto fail_deregister;
+		return error;
 
 	printk(KERN_INFO 
 		"IA-32 Microcode Update Driver: v%s <tigran@veritas.com>\n", 
 		MICROCODE_VERSION);
 	return 0;
-
-fail_deregister:
-	misc_deregister(&microcode_dev);
-fail:
-	return error;
 }
 
 static void __exit microcode_exit(void)
 {
 	misc_deregister(&microcode_dev);
-	devfs_remove("cpu/microcode");
 	kfree(mc_applied);
 	printk(KERN_INFO "IA-32 Microcode Update Driver v%s unregistered\n", 
 			MICROCODE_VERSION);
--- 1.18/drivers/md/dm-ioctl.c	Sat Apr 26 00:16:28 2003
+++ edited/drivers/md/dm-ioctl.c	Wed Apr 30 16:20:30 2003
@@ -1084,9 +1084,10 @@
 };
 
 static struct miscdevice _dm_misc = {
-	.minor = MISC_DYNAMIC_MINOR,
-	.name  = DM_NAME,
-	.fops  = &_ctl_fops
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= DM_NAME,
+	.devfs_name	= "mapper/control",
+	.fops		= &_ctl_fops
 };
 
 /*
@@ -1107,18 +1108,12 @@
 		return r;
 	}
 
-	r = devfs_mk_symlink(DM_DIR "/control", "../misc/" DM_NAME);
-	if (r) {
-		DMERR("devfs_mk_symlink failed for control device");
-		goto failed;
-	}
 	DMINFO("%d.%d.%d%s initialised: %s", DM_VERSION_MAJOR,
 	       DM_VERSION_MINOR, DM_VERSION_PATCHLEVEL, DM_VERSION_EXTRA,
 	       DM_DRIVER_EMAIL);
 	return 0;
 
       failed:
-	devfs_remove(DM_DIR "/control");
 	if (misc_deregister(&_dm_misc) < 0)
 		DMERR("misc_deregister failed for control device");
 	dm_hash_exit();
@@ -1127,7 +1122,6 @@
 
 void dm_interface_exit(void)
 {
-	devfs_remove(DM_DIR "/control");
 	if (misc_deregister(&_dm_misc) < 0)
 		DMERR("misc_deregister failed for control device");
 	dm_hash_exit();
--- 1.9/drivers/media/radio/miropcm20-rds.c	Sat Mar 22 16:37:12 2003
+++ edited/drivers/media/radio/miropcm20-rds.c	Wed Apr 30 16:21:08 2003
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/miscdevice.h>
-#include <linux/devfs_fs_kernel.h>
 #include <asm/uaccess.h>
 #include "miropcm20-rds-core.h"
 
@@ -114,28 +113,17 @@
 static struct miscdevice rds_miscdev = {
 	.minor		= MISC_DYNAMIC_MINOR,
 	.name		= "radiotext",
+	.devfs_name	= "v4l/rds/radiotext",
 	.fops		= &rds_fops,
 };
 
 static int __init miropcm20_rds_init(void)
 {
-	int error;
-
-	error = misc_register(&rds_miscdev);
-	if (error)
-		return error;
-
-	error = devfs_mk_symlink("v4l/rds/radiotext",
-				 "../misc/radiotext");
-	if (error)
-		misc_deregister(&rds_miscdev);
-
-	return error;
+	return misc_register(&rds_miscdev);
 }
 
 static void __exit miropcm20_rds_cleanup(void)
 {
-	devfs_remove("v4l/rds/radiotext");
 	misc_deregister(&rds_miscdev);
 }
 
