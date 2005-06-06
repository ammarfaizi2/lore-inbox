Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261762AbVFFWgs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261762AbVFFWgs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 18:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVFFWfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 18:35:54 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:47072 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261732AbVFFW2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 18:28:09 -0400
Message-Id: <200506062008.j56K87sZ008947@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org, torvalds@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 1/5] UML - Make the emulated iomem driver work on 2.6
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Jun 2005 16:08:06 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the minimal fixes needed to make the UML iomem driver work in
2.6.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/Kconfig_char
===================================================================
--- linux-2.6.12-rc.orig/arch/um/Kconfig_char	2005-05-26 17:15:14.000000000 -0400
+++ linux-2.6.12-rc/arch/um/Kconfig_char	2005-05-28 22:50:34.000000000 -0400
@@ -204,5 +204,11 @@ config UML_RANDOM
 	http://sourceforge.net/projects/gkernel/).  rngd periodically reads
 	/dev/hwrng and injects the entropy into /dev/random.
 
+config MMAPPER
+	tristate "iomem emulation driver"
+	help
+	This driver allows a host file to be used as emulated IO memory inside
+	UML.
+
 endmenu
 
Index: linux-2.6.12-rc/arch/um/drivers/mmapper_kern.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/mmapper_kern.c	2005-05-28 22:39:00.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/mmapper_kern.c	2005-05-28 22:49:05.000000000 -0400
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/init.h> 
 #include <linux/smp_lock.h>
+#include <linux/miscdevice.h>
 #include <asm/uaccess.h>
 #include <asm/irq.h>
 #include <asm/pgtable.h>
@@ -117,24 +118,39 @@ static struct file_operations mmapper_fo
 	.release	= mmapper_release,
 };
 
+static struct miscdevice mmapper_dev = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= "mmapper",
+	.fops		= &mmapper_fops
+};
+
 static int __init mmapper_init(void)
 {
+	int err;
+
 	printk(KERN_INFO "Mapper v0.1\n");
 
 	v_buf = (char *) find_iomem("mmapper", &mmapper_size);
 	if(mmapper_size == 0){
 		printk(KERN_ERR "mmapper_init - find_iomem failed\n");
-		return(0);
+		goto out;
 	}
 
-	p_buf = __pa(v_buf);
+	err = misc_register(&mmapper_dev);
+	if(err){
+		printk(KERN_ERR "mmapper - misc_register failed, err = %d\n", 
+		       err);
+		goto out;
+	}
 
-	devfs_mk_cdev(MKDEV(30, 0), S_IFCHR|S_IRUGO|S_IWUGO, "mmapper");
-	return(0);
+	p_buf = __pa(v_buf);
+out:
+	return 0;
 }
 
 static void mmapper_exit(void)
 {
+	misc_deregister(&mmapper_dev);
 }
 
 module_init(mmapper_init);

