Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263150AbUCSXoH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 18:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUCSXlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 18:41:31 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:57227 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263156AbUCSXjL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 18:39:11 -0500
Date: Fri, 19 Mar 2004 15:38:05 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: claus@momo.math.rwth-aachen.de, greg@kroah.com, hannal@us.ibm.com
Subject: [PATCH 2.6 RFT] add class support to floppy tape driver zftape-init.c
Message-ID: <58110000.1079739485@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to add class support to zftape-init.c:

MODULE_DESCRIPTION(ZFTAPE_VERSION " - "
                   "VFS interface for the Linux floppy tape driver. "
                   "Support for QIC-113 compatible volume table "
                   "and builtin compression (lzrw3 algorithm)");

I have verified it compiles but do not have the hardware to test it.
If someone who does could test it please do.

Hanna

-----


diff -Nrup -Xdontdiff linux-2.6.4/drivers/char/ftape/zftape/zftape-init.c linux-2.6.4p/drivers/char/ftape/zftape/zftape-init.c
--- linux-2.6.4/drivers/char/ftape/zftape/zftape-init.c	2004-03-10 18:55:26.000000000 -0800
+++ linux-2.6.4p/drivers/char/ftape/zftape/zftape-init.c	2004-03-18 16:37:56.000000000 -0800
@@ -38,6 +38,7 @@
 
 #include <linux/zftape.h>
 #include <linux/init.h>
+#include <linux/device.h>
 
 #include "../zftape/zftape-init.h"
 #include "../zftape/zftape-read.h"
@@ -103,6 +104,8 @@ static struct file_operations zft_cdev =
 	.release	= zft_close,
 };
 
+static struct class_simple *zft_class;
+
 /*      Open floppy tape device
  */
 static int zft_open(struct inode *ino, struct file *filep)
@@ -341,22 +344,29 @@ KERN_INFO
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
@@ -386,12 +396,19 @@ static void zft_exit(void)
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

