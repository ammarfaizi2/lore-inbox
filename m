Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbUENXKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUENXKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264461AbUENXJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:09:54 -0400
Received: from mail.kroah.org ([65.200.24.183]:52188 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263166AbUENXIG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:06 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <1084576042887@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:22 -0700
Message-Id: <1084576042804@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.15, 2004/05/02 20:29:22-07:00, hannal@us.ibm.com

[PATCH] add class support to drivers/block/paride/pg.c

This patch adds class support to pg.c, the parallel port generic ATAPI device driver.

I have verified it compiles but do not have the hardware. If someone does and
could test that would be helpful.


 drivers/block/paride/pg.c |   48 ++++++++++++++++++++++++++++++++++++----------
 1 files changed, 38 insertions(+), 10 deletions(-)


diff -Nru a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
--- a/drivers/block/paride/pg.c	Fri May 14 15:59:12 2004
+++ b/drivers/block/paride/pg.c	Fri May 14 15:59:12 2004
@@ -161,6 +161,7 @@
 #include <linux/slab.h>
 #include <linux/mtio.h>
 #include <linux/pg.h>
+#include <linux/device.h>
 
 #include <asm/uaccess.h>
 
@@ -240,6 +241,8 @@
 
 static char pg_scratch[512];	/* scratch block buffer */
 
+static struct class_simple *pg_class;
+
 /* kernel glue structures */
 
 static struct file_operations pg_fops = {
@@ -658,15 +661,19 @@
 
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
@@ -675,18 +682,37 @@
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
@@ -695,10 +721,12 @@
 
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
 

