Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbUDOSJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbUDORqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:46:50 -0400
Received: from mail.kroah.org ([65.200.24.183]:24246 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263126AbUDORmL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:11 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <10820509121457@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:52 -0700
Message-Id: <10820509122120@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.6, 2004/03/19 16:39:37-08:00, hannal@us.ibm.com

[PATCH] add class support to floppy tape driver zftape-init.c

Here is a patch to add class support to zftape-init.c:

MODULE_DESCRIPTION(ZFTAPE_VERSION " - "
                   "VFS interface for the Linux floppy tape driver. "
                   "Support for QIC-113 compatible volume table "
                   "and builtin compression (lzrw3 algorithm)");

I have verified it compiles but do not have the hardware to test it.


 drivers/char/ftape/zftape/zftape-init.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+)


diff -Nru a/drivers/char/ftape/zftape/zftape-init.c b/drivers/char/ftape/zftape/zftape-init.c
--- a/drivers/char/ftape/zftape/zftape-init.c	Thu Apr 15 10:21:03 2004
+++ b/drivers/char/ftape/zftape/zftape-init.c	Thu Apr 15 10:21:03 2004
@@ -38,6 +38,7 @@
 
 #include <linux/zftape.h>
 #include <linux/init.h>
+#include <linux/device.h>
 
 #include "../zftape/zftape-init.h"
 #include "../zftape/zftape-read.h"
@@ -103,6 +104,8 @@
 	.release	= zft_close,
 };
 
+static struct class_simple *zft_class;
+
 /*      Open floppy tape device
  */
 static int zft_open(struct inode *ino, struct file *filep)
@@ -341,22 +344,29 @@
 	      "installing zftape VFS interface for ftape driver ...");
 	TRACE_CATCH(register_chrdev(QIC117_TAPE_MAJOR, "zft", &zft_cdev),);
 
+	zft_class = class_simple_create(THIS_MODULE, "zft");
 	for (i = 0; i < 4; i++) {
+		class_simple_device_add(zft_class, MKDEV(QIC117_TAPE_MAJOR, i), NULL, "qft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"qft%i", i);
+		class_simple_device_add(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 4), NULL, "nqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 4),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"nqft%i", i);
+		class_simple_device_add(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 16), NULL, "zqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 16),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"zqft%i", i);
+		class_simple_device_add(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 20), NULL, "nzqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 20),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"nzqft%i", i);
+		class_simple_device_add(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 32), NULL, "rawqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 32),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"rawqft%i", i);
+		class_simple_device_add(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 36), NULL, "nrawrawqft%i", i);
 		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 36),
 				S_IFCHR | S_IRUSR | S_IWUSR,
 				"nrawqft%i", i);
@@ -386,12 +396,19 @@
 	}
         for (i = 0; i < 4; i++) {
 		devfs_remove("qft%i", i);
+		class_simple_device_remove(MKDEV(QIC117_TAPE_MAJOR, i));
 		devfs_remove("nqft%i", i);
+		class_simple_device_remove(MKDEV(QIC117_TAPE_MAJOR, i + 4));
 		devfs_remove("zqft%i", i);
+		class_simple_device_remove(MKDEV(QIC117_TAPE_MAJOR, i + 16));
 		devfs_remove("nzqft%i", i);
+		class_simple_device_remove(MKDEV(QIC117_TAPE_MAJOR, i + 20));
 		devfs_remove("rawqft%i", i);
+		class_simple_device_remove(MKDEV(QIC117_TAPE_MAJOR, i + 32));
 		devfs_remove("nrawqft%i", i);
+		class_simple_device_remove(MKDEV(QIC117_TAPE_MAJOR, i + 36));
 	}
+	class_simple_destroy(zft_class);
 	zft_uninit_mem(); /* release remaining memory, if any */
         printk(KERN_INFO "zftape successfully unloaded.\n");
 	TRACE_EXIT;

