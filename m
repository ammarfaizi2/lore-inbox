Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263271AbUENX2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbUENX2o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264526AbUENXNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:13:25 -0400
Received: from mail.kroah.org ([65.200.24.183]:55516 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263271AbUENXIM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:08:12 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.6
In-Reply-To: <1084576042499@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Fri, 14 May 2004 16:07:22 -0700
Message-Id: <1084576042851@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.5.17, 2004/05/02 20:29:59-07:00, hannal@us.ibm.com

[PATCH] add class support to drivers/char/tipar.c

This patch adds class support to the Texas Instruments graphing calculators
with a parallel link cable.

I have verified it compiles. If someone has the hardware please verify it works.


 drivers/char/tipar.c |   49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 42 insertions(+), 7 deletions(-)


diff -Nru a/drivers/char/tipar.c b/drivers/char/tipar.c
--- a/drivers/char/tipar.c	Fri May 14 15:58:43 2004
+++ b/drivers/char/tipar.c	Fri May 14 15:58:43 2004
@@ -58,6 +58,7 @@
 #include <asm/bitops.h>
 #include <linux/devfs_fs_kernel.h>	/* DevFs support */
 #include <linux/parport.h>	/* Our code depend on parport */
+#include <linux/device.h>
 
 /*
  * TI definitions
@@ -92,6 +93,8 @@
 static unsigned int tp_count;	/* tipar count */
 static unsigned long opened;	/* opened devices */
 
+static struct class_simple *tipar_class;
+
 /* --- macros for parport access -------------------------------------- */
 
 #define r_dtr(x)        (parport_read_data(table[(x)].dev->port))
@@ -424,18 +427,26 @@
 static int
 tipar_register(int nr, struct parport *port)
 {
+	int err = 0;
+
 	/* Register our module into parport */
 	table[nr].dev = parport_register_device(port, "tipar",
 						NULL, NULL, NULL, 0,
 						(void *) &table[nr]);
 
-	if (table[nr].dev == NULL)
-		return 1;
+	if (table[nr].dev == NULL) {
+		err = 1;
+		goto out;
+	}
 
+	class_simple_device_add(tipar_class, MKDEV(TIPAR_MAJOR, TIPAR_MINOR + nr),
+			NULL, "par%d", nr);
 	/* Use devfs, tree: /dev/ticables/par/[0..2] */
-	devfs_mk_cdev(MKDEV(TIPAR_MAJOR, TIPAR_MINOR + nr),
+	err = devfs_mk_cdev(MKDEV(TIPAR_MAJOR, TIPAR_MINOR + nr),
 			S_IFCHR | S_IRUGO | S_IWUGO,
 			"ticables/par/%d", nr);
+	if (err)
+		goto out_class;
 
 	/* Display informations */
 	printk(KERN_INFO "tipar%d: using %s (%s).\n", nr, port->name,
@@ -447,7 +458,14 @@
 	else
 		printk("tipar%d: link cable not found.\n", nr);
 
-	return 0;
+	err = 0;
+	goto out;
+
+out_class:
+	class_simple_device_remove(MKDEV(TIPAR_MAJOR, TIPAR_MINOR + nr));
+	class_simple_destroy(tipar_class);
+out:
+	return err;
 }
 
 static void
@@ -477,23 +495,38 @@
 int __init
 tipar_init_module(void)
 {
+	int err = 0;
+
 	printk("tipar: parallel link cable driver, version %s\n",
 	       DRIVER_VERSION);
 
 	if (register_chrdev(TIPAR_MAJOR, "tipar", &tipar_fops)) {
 		printk("tipar: unable to get major %d\n", TIPAR_MAJOR);
-		return -EIO;
+		err = -EIO;
+		goto out;
 	}
 
 	/* Use devfs with tree: /dev/ticables/par/[0..2] */
 	devfs_mk_dir("ticables/par");
 
+	tipar_class = class_simple_create(THIS_MODULE, "ticables");
+	if (IS_ERR(tipar_class)) {
+		err = PTR_ERR(tipar_class);
+		goto out_chrdev;
+	}
 	if (parport_register_driver(&tipar_driver)) {
 		printk("tipar: unable to register with parport\n");
-		return -EIO;
+		err = -EIO;
+		goto out;
 	}
 
-	return 0;
+	err = 0;
+	goto out;
+
+out_chrdev:
+	unregister_chrdev(TIPAR_MAJOR, "tipar");
+out:
+	return err;	
 }
 
 void __exit
@@ -510,8 +543,10 @@
 		if (table[i].dev == NULL)
 			continue;
 		parport_unregister_device(table[i].dev);
+		class_simple_device_remove(MKDEV(TIPAR_MAJOR, i));
 		devfs_remove("ticables/par/%d", i);
 	}
+	class_simple_destroy(tipar_class);
 	devfs_remove("ticables/par");
 
 	printk("tipar: module unloaded !\n");

