Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262930AbUDOVLc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUDOVLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:11:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:44687 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262930AbUDOVLR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:11:17 -0400
Date: Thu, 15 Apr 2004 14:10:07 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, hannal@us.ibm.com, dwmw2@infradead.org
Subject: [PATCH 2.6.5] Add class support to drivers/mtd/mtdchar.c
Message-ID: <207270000.1082063407@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch add sysfs class support to the MTD char device driver.
I have verified it compiles and works. Please review or test with an 
actual device if possible.

Thanks.

Hanna Linder
IBM Linux Technology Center
----
diff -Nrup -Xdontdiff linux-2.6.5/drivers/mtd/mtdchar.c linux-2.6.5p/drivers/mtd/mtdchar.c
--- linux-2.6.5/drivers/mtd/mtdchar.c	2004-04-03 19:37:37.000000000 -0800
+++ linux-2.6.5p/drivers/mtd/mtdchar.c	2004-04-15 13:48:44.000000000 -0700
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/device.h>
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_DEVFS_FS
@@ -26,6 +27,10 @@ static struct mtd_notifier notifier = {
 
 #endif
 
+/* For class support */
+static struct class_simple *mtd_class;
+static int mtd_minor;
+
 static loff_t mtd_lseek (struct file *file, loff_t offset, int orig)
 {
 	struct mtd_info *mtd=(struct mtd_info *)file->private_data;
@@ -473,18 +478,43 @@ static struct file_operations mtd_fops =
 
 static void mtd_notify_add(struct mtd_info* mtd)
 {
+	int err = 0;
 	if (!mtd)
 		return;
-	devfs_mk_cdev(MKDEV(MTD_CHAR_MAJOR, mtd->index*2),
+	class_simple_device_add(mtd_class, MKDEV(MTD_CHAR_MAJOR, mtd->index*2), 
+			NULL, "mtd%d", mtd->index);
+	err = devfs_mk_cdev(MKDEV(MTD_CHAR_MAJOR, mtd->index*2),
 			S_IFCHR | S_IRUGO | S_IWUGO, "mtd/%d", mtd->index);
-	devfs_mk_cdev(MKDEV(MTD_CHAR_MAJOR, mtd->index*2+1),
+	if (err) {
+		class_simple_device_remove(MKDEV(MTD_CHAR_MAJOR, mtd->index*2));
+		goto out_class;
+	}
+	class_simple_device_add(mtd_class, MKDEV(MTD_CHAR_MAJOR, mtd->index*2+1), 
+			NULL, "mtd%dro", mtd->index);
+	err = devfs_mk_cdev(MKDEV(MTD_CHAR_MAJOR, mtd->index*2+1),
 			S_IFCHR | S_IRUGO | S_IWUGO, "mtd/%dro", mtd->index);
+	if (err) 
+		class_simple_device_remove(MKDEV(MTD_CHAR_MAJOR, mtd->index*2+1));
+	else
+		goto out;
+out_class:
+	class_simple_destroy(mtd_class);
+	unregister_chrdev(MTD_CHAR_MAJOR, "mtd");
+out:
+	/* Need the minor number to be global so the module_exit function can see it*/
+	mtd_minor = mtd->index;
+	return err;
+		
 }
 
 static void mtd_notify_remove(struct mtd_info* mtd)
 {
 	if (!mtd)
 		return;
+
+	class_simple_device_remove(MKDEV(MTD_CHAR_MAJOR, mtd->index*2));
+	class_simple_device_remove(MKDEV(MTD_CHAR_MAJOR, mtd->index*2+1));
+	class_simple_destroy(mtd_class);
 	devfs_remove("mtd/%d", mtd->index);
 	devfs_remove("mtd/%dro", mtd->index);
 }
@@ -492,22 +522,36 @@ static void mtd_notify_remove(struct mtd
 
 static int __init init_mtdchar(void)
 {
+	int err = 0;
+
 	if (register_chrdev(MTD_CHAR_MAJOR, "mtd", &mtd_fops)) {
 		printk(KERN_NOTICE "Can't allocate major number %d for Memory Technology Devices.\n",
 		       MTD_CHAR_MAJOR);
-		return -EAGAIN;
+		err = -EAGAIN;
+	}
+	mtd_class = class_simple_create(THIS_MODULE, "mtd");
+	if (IS_ERR(mtd_class)) {
+		err = PTR_ERR(mtd_class);
+		goto out_chrdev;
 	}
-
 #ifdef CONFIG_DEVFS_FS
 	devfs_mk_dir("mtd");
 
 	register_mtd_user(&notifier);
 #endif
-	return 0;
+	goto out;
+
+out_chrdev:
+	unregister_chrdev(MTD_CHAR_MAJOR, "mtd");
+out:
+	return err;
 }
 
 static void __exit cleanup_mtdchar(void)
 {
+	class_simple_device_remove(MKDEV(MTD_CHAR_MAJOR, mtd_minor*2));
+	class_simple_device_remove(MKDEV(MTD_CHAR_MAJOR, mtd_minor*2+1));
+	class_simple_destroy(mtd_class);
 #ifdef CONFIG_DEVFS_FS
 	unregister_mtd_user(&notifier);
 	devfs_remove("mtd");

