Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUDGXOs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 19:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbUDGXOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 19:14:48 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:8597 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261232AbUDGXOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 19:14:42 -0400
Date: Wed, 07 Apr 2004 16:13:30 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org, geert@linux-m68k.org
cc: hannal@us.ibm.com, greg@kroah.com, noring@nocrew.org, lars@nocrew.org,
       tomas@nocrew.org
Subject: [PATCH 2.6] add class support to dsp56k.c 
Message-ID: <61760000.1081379610@dyn318071bld.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is a patch that adds sysfs class support to /drivers/char/dsp56k.c

I dont have the hardware or a cross compiler... If someone could test it
I would appreciate it.

Thanks.

Hanna
IBM Linux Technology Center
-----
diff -Nrup linux-2.6.5/drivers/char/dsp56k.c linux-2.6.5p/drivers/char/dsp56k.c
--- linux-2.6.5/drivers/char/dsp56k.c	2004-04-03 19:37:07.000000000 -0800
+++ linux-2.6.5p/drivers/char/dsp56k.c	2004-04-07 14:44:28.000000000 -0700
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 
 #include <asm/atarihw.h>
 #include <asm/traps.h>
@@ -149,6 +150,8 @@ static struct dsp56k_device {
 	int tx_wsize, rx_wsize;
 } dsp56k;
 
+static struct class_simple *dsp56k_class;
+
 static int dsp56k_reset(void)
 {
 	u_char status;
@@ -502,6 +505,8 @@ static char banner[] __initdata = KERN_I
 
 static int __init dsp56k_init_driver(void)
 {
+	int err = 0;
+
 	if(!MACH_IS_ATARI || !ATARIHW_PRESENT(DSP56K)) {
 		printk("DSP56k driver: Hardware not present\n");
 		return -ENODEV;
@@ -511,12 +516,28 @@ static int __init dsp56k_init_driver(voi
 		printk("DSP56k driver: Unable to register driver\n");
 		return -ENODEV;
 	}
+	dsp56k_class = class_simple_create(THIS_MODULE, "dsp56k");
+	if (IS_ERR(dsp56k_class)) {
+		err = PTR_ERR(dsp56k_class);
+		goto out_chrdev;
+	}
+	class_simple_device_add(dsp56k_class, MKDEV(DSP56K_MAJOR, 0), NULL, "dsp56k");
 
-	devfs_mk_cdev(MKDEV(DSP56K_MAJOR, 0),
+	err = devfs_mk_cdev(MKDEV(DSP56K_MAJOR, 0),
 		      S_IFCHR | S_IRUSR | S_IWUSR, "dsp56k");
+	if(err)
+		goto out_class;
 
 	printk(banner);
-	return 0;
+	goto out;
+
+out_class:
+	class_simple_device_remove(MKDEV(DSP56K_MAJOR, 0));
+	class_simple_destroy(dsp56k_class);
+out_chrdev:
+	unregister_chrdev(DSP56K_MAJOR, "sdp56k");
+out:
+	return err;
 }
 module_init(dsp56k_init_driver);
 
@@ -524,6 +545,8 @@ static void __exit dsp56k_cleanup_driver
 {
 	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
 	devfs_remove("dsp56k");
+	class_simple_device_remove(MKDEV(DSP56K_MAJOR, 0));
+	class_simple_destroy(dsp56k_class);
 }
 module_exit(dsp56k_cleanup_driver);
 

