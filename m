Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUDPWmI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUDPWji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:39:38 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:16026 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263870AbUDPWiD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:38:03 -0400
Date: Fri, 16 Apr 2004 15:35:20 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [PATCH 2.6.5] Add class support to drivers/mtd/mtdchar.c
Message-ID: <221630000.1082154920@w-hlinder.beaverton.ibm.com>
In-Reply-To: <1082063698.2949.6.camel@localhost.localdomain>
References: <207270000.1082063407@w-hlinder.beaverton.ibm.com> <1082063698.2949.6.camel@localhost.localdomain>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Thursday, April 15, 2004 05:14:59 PM -0400 David Woodhouse <dwmw2@infradead.org> wrote:

> CONFIG_MTD_MTDRAM would let you test -- otherwise I'll look at it when I
> get back to the office in a couple of weeks. Thanks.
> 
> -- 
> dwmw2

Thanks David. I tried the MTDRAM and it showed up in the class tree but
no dev file was made. I suspect it needs a device attached. Anyway, I found
a small bug by code inspection so here is the new patch.

Thanks.

Hanna

-----
diff -Nrup -Xdontdiff linux-2.6.5/drivers/mtd/mtdchar.c linux-2.6.5mtd/drivers/mtd/mtdchar.c
--- linux-2.6.5/drivers/mtd/mtdchar.c	2004-04-03 19:37:37.000000000 -0800
+++ linux-2.6.5mtd/drivers/mtd/mtdchar.c	2004-04-16 15:18:33.000000000 -0700
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
@@ -492,22 +522,37 @@ static void mtd_notify_remove(struct mtd
 
 static int __init init_mtdchar(void)
 {
+	int err = 0;
+
 	if (register_chrdev(MTD_CHAR_MAJOR, "mtd", &mtd_fops)) {
 		printk(KERN_NOTICE "Can't allocate major number %d for Memory Technology Devices.\n",
 		       MTD_CHAR_MAJOR);
-		return -EAGAIN;
+		err = -EAGAIN;
+		goto out;
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

