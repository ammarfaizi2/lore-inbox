Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUCTCIW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 21:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263202AbUCTCIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 21:08:22 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:33421 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263199AbUCTCIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 21:08:19 -0500
Date: Fri, 19 Mar 2004 18:08:47 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: gerg@snapgear.com, greg@kroah.com, hannal@us.ibm.com
Subject: [PATCH 2.6 stallion.c] RFT added class support to stallion.c
Message-ID: <68680000.1079748527@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a patch to add class support to the Stallion multiport 
serial driver.

I have verified it compiles but do not have the hardware. 
If you can please verify, thanks.

Please consider for Inclusion or Testing.

Hanna
---
diff -Nrup linux-2.6.4/drivers/char/stallion.c linux-2.6.4p/drivers/char/stallion.c
--- linux-2.6.4/drivers/char/stallion.c	2004-03-10 18:55:37.000000000 -0800
+++ linux-2.6.4p/drivers/char/stallion.c	2004-03-19 17:28:08.000000000 -0800
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -732,6 +733,8 @@ static struct file_operations	stl_fsiome
 
 /*****************************************************************************/
 
+static struct class_simple *stallion_class;
+
 #ifdef MODULE
 
 /*
@@ -788,12 +791,15 @@ static void __exit stallion_module_exit(
 		restore_flags(flags);
 		return;
 	}
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < 4; i++) {
 		devfs_remove("staliomem/%d", i);
+		class_simple_device_remove(MKDEV(STL_SIOMEMMAJOR, i));
+	}
 	devfs_remove("staliomem");
 	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
 		printk("STALLION: failed to un-register serial memory device, "
 			"errno=%d\n", -i);
+	class_simple_destroy(stallion_class);
 
 	if (stl_tmpwritebuf != (char *) NULL)
 		kfree(stl_tmpwritebuf);
@@ -3181,10 +3187,12 @@ int __init stl_init(void)
 		printk("STALLION: failed to register serial board device\n");
 	devfs_mk_dir("staliomem");
 
+	stallion_class = class_simple_create(THIS_MODULE, "staliomem");
 	for (i = 0; i < 4; i++) {
 		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
 				S_IFCHR|S_IRUSR|S_IWUSR,
 				"staliomem/%d", i);
+		class_simple_device_add(stallion_class, MKDEV(STL_SIOMEMMAJOR, i), NULL, "staliomem/%d", i);
 	}
 
 	stl_serial->owner = THIS_MODULE;

