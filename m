Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUDUW46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUDUW46 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 18:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUDUW46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 18:56:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:26579 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262744AbUDUW4y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 18:56:54 -0400
Date: Wed, 21 Apr 2004 15:54:48 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-parport@torque.net
cc: linux-kernel@vger.kernel.org, greg@kroah.com, hannal@us.ibm.com
Subject: [PATCH 2.6.6-rc1] RFT add class support to drivers/block/paride/pg.c
Message-ID: <40530000.1082588088@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds class support to pg.c, the parallel port generic ATAPI device driver.

I have verified it compiles but do not have the hardware. If someone does and
could test that would be helpful.

Thanks.

Hanna Linder
IBM Linux Technology Center
----
diff -Nrup linux-2.6.6-rc1/drivers/block/paride/pg.c linux-2.6.6-rc1p/drivers/block/paride/pg.c
--- linux-2.6.6-rc1/drivers/block/paride/pg.c	2004-04-14 18:35:37.000000000 -0700
+++ linux-2.6.6-rc1p/drivers/block/paride/pg.c	2004-04-21 14:50:32.000000000 -0700
@@ -161,6 +161,7 @@ enum {D_PRT, D_PRO, D_UNI, D_MOD, D_SLV,
 #include <linux/slab.h>
 #include <linux/mtio.h>
 #include <linux/pg.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 
@@ -240,6 +241,8 @@ static int pg_identify(struct pg *dev, i
 
 static char pg_scratch[512];	/* scratch block buffer */
 
+static struct class_simple *pg_class;
+
 /* kernel glue structures */
 
 static struct file_operations pg_fops = {
@@ -658,15 +661,19 @@ static ssize_t pg_read(struct file *filp
 
 static int __init pg_init(void)
 {
-	int unit;
+	int unit, err = 0;
 
-	if (disable)
-		return -1;
+	if (disable){
+		err = -1;
+		goto out;
+	}
 
 	pg_init_units();
 
-	if (pg_detect())
-		return -1;
+	if (pg_detect()) {
+		err = -1;
+		goto out;
+	}
 
 	if (register_chrdev(major, name, &pg_fops)) {
 		printk("pg_init: unable to get major number %d\n", major);
@@ -675,18 +682,37 @@ static int __init pg_init(void)
 			if (dev->present)
 				pi_release(dev->pi);
 		}
-		return -1;
+		err = -1;
+		goto out;
+	}
+	pg_class = class_simple_create(THIS_MODULE, "pg");
+	if (IS_ERR(pg_class)) {
+		err = PTR_ERR(pg_class);
+		goto out_chrdev;
 	}
 	devfs_mk_dir("pg");
 	for (unit = 0; unit < PG_UNITS; unit++) {
 		struct pg *dev = &devices[unit];
 		if (dev->present) {
-			devfs_mk_cdev(MKDEV(major, unit),
+			class_simple_device_add(pg_class, MKDEV(major, unit), 
+					NULL, "pg%u", unit);
+			err = devfs_mk_cdev(MKDEV(major, unit),
 				      S_IFCHR | S_IRUSR | S_IWUSR, "pg/%u",
 				      unit);
+			if (err) 
+				goto out_class;
 		}
 	}
-	return 0;
+	err = 0;
+	goto out;
+
+out_class:
+	class_simple_device_remove(MKDEV(major, unit));
+	class_simple_destroy(pg_class);
+out_chrdev:
+	unregister_chrdev(major, "pg");
+out:
+	return err;
 }
 
 static void __exit pg_exit(void)
@@ -695,10 +721,12 @@ static void __exit pg_exit(void)
 
 	for (unit = 0; unit < PG_UNITS; unit++) {
 		struct pg *dev = &devices[unit];
-		if (dev->present)
+		if (dev->present) {
+			class_simple_device_remove(MKDEV(major, unit));
 			devfs_remove("pg/%u", unit);
+		}
 	}
-
+	class_simple_destroy(pg_class);
 	devfs_remove("pg");
 	unregister_chrdev(major, name);
 

