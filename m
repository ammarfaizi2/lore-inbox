Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbUD1WLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbUD1WLZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 18:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUD1WLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 18:11:25 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:11518 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261430AbUD1WLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 18:11:20 -0400
Date: Wed, 28 Apr 2004 15:09:26 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com, hannal@us.ibm.com, roms@lpg.ticalc.org,
       linux-parport@lists.infradead.org
Subject: [PATCH 2.6.6-rc3] add class support to drivers/char/tipar.c
Message-ID: <53520000.1083190166@dyn318071bld.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds class support to the Texas Instruments graphing calculators
with a parallel link cable.

I have verified it compiles. If someone has the hardware please verify it works.

Thanks.

Hanna Linder
IBM Linux Technology Center
-----------
diff -Nrup -X dontdiff linux-2.6.6-rc3/drivers/char/tipar.c linux-2.6.6-rc3p/drivers/char/tipar.c
--- linux-2.6.6-rc3/drivers/char/tipar.c	2004-04-27 18:36:20.000000000 -0700
+++ linux-2.6.6-rc3p/drivers/char/tipar.c	2004-04-28 13:48:10.000000000 -0700
@@ -58,6 +58,7 @@
 #include <asm/bitops.h>
 #include <linux/devfs_fs_kernel.h>	/* DevFs support */
 #include <linux/parport.h>	/* Our code depend on parport */
+#include <linux/device.h>
 
 /*
  * TI definitions
@@ -92,6 +93,8 @@ static int timeout = TIMAXTIME;	/* timeo
 static unsigned int tp_count;	/* tipar count */
 static unsigned long opened;	/* opened devices */
 
+static struct class_simple *tipar_class;
+
 /* --- macros for parport access -------------------------------------- */
 
 #define r_dtr(x)        (parport_read_data(table[(x)].dev->port))
@@ -424,18 +427,26 @@ tipar_setup(char *str)
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
@@ -447,7 +458,14 @@ tipar_register(int nr, struct parport *p
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
@@ -477,23 +495,38 @@ static struct parport_driver tipar_drive
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
@@ -510,8 +543,10 @@ tipar_cleanup_module(void)
 		if (table[i].dev == NULL)
 			continue;
 		parport_unregister_device(table[i].dev);
+		class_simple_device_remove(MKDEV(TIPAR_MAJOR, i));
 		devfs_remove("ticables/par/%d", i);
 	}
+	class_simple_destroy(tipar_class);
 	devfs_remove("ticables/par");
 
 	printk("tipar: module unloaded !\n");

