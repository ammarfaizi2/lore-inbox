Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbUDOSST (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbUDORn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:43:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:30646 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263207AbUDORmU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:20 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <10820509124057@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:52 -0700
Message-Id: <10820509121239@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.12, 2004/04/08 14:45:41-07:00, hannal@us.ibm.com

[PATCH] add class support to dsp56k.c

Here is a patch that adds sysfs class support to /drivers/char/dsp56k.c


 drivers/char/dsp56k.c |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)


diff -Nru a/drivers/char/dsp56k.c b/drivers/char/dsp56k.c
--- a/drivers/char/dsp56k.c	Thu Apr 15 10:20:35 2004
+++ b/drivers/char/dsp56k.c	Thu Apr 15 10:20:35 2004
@@ -35,6 +35,7 @@
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
+#include <linux/device.h>
 
 #include <asm/atarihw.h>
 #include <asm/traps.h>
@@ -149,6 +150,8 @@
 	int tx_wsize, rx_wsize;
 } dsp56k;
 
+static struct class_simple *dsp56k_class;
+
 static int dsp56k_reset(void)
 {
 	u_char status;
@@ -502,6 +505,8 @@
 
 static int __init dsp56k_init_driver(void)
 {
+	int err = 0;
+
 	if(!MACH_IS_ATARI || !ATARIHW_PRESENT(DSP56K)) {
 		printk("DSP56k driver: Hardware not present\n");
 		return -ENODEV;
@@ -511,17 +516,35 @@
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
+	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
+out:
+	return err;
 }
 module_init(dsp56k_init_driver);
 
 static void __exit dsp56k_cleanup_driver(void)
 {
+	class_simple_device_remove(MKDEV(DSP56K_MAJOR, 0));
+	class_simple_destroy(dsp56k_class);
 	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
 	devfs_remove("dsp56k");
 }

