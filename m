Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262963AbUCXBum (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 20:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUCXBum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 20:50:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:27051 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262964AbUCXBuj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 20:50:39 -0500
Date: Tue, 23 Mar 2004 17:50:56 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: gerg@snapgear.com, greg@kroah.com, hannal@us.ibm.com
Subject: [PATCH 2.6 istallion.c] RFT added class support to istallion.c
Message-ID: <129960000.1080093056@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Here is a patch to add class support to the Stallion Intelligent multiport 
serial driver.

I have verified it compiles but do not have the hardware. 
If you do please verify, thanks.

Please consider for Inclusion or Testing.

Thanks.

Hanna
---------
diff -Nrup -Xdontdiff linux-2.6.4/drivers/char/istallion.c linux-2.6.4p/drivers/char/istallion.c
--- linux-2.6.4/drivers/char/istallion.c	2004-03-10 18:55:34.000000000 -0800
+++ linux-2.6.4p/drivers/char/istallion.c	2004-03-23 16:49:29.000000000 -0800
@@ -40,6 +40,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -795,6 +796,8 @@ static int	stli_timeron;
 
 /*****************************************************************************/
 
+static struct class_simple *istallion_class;
+
 #ifdef MODULE
 
 /*
@@ -853,9 +856,12 @@ static void __exit istallion_module_exit
 		return;
 	}
 	put_tty_driver(stli_serial);
-	for (i = 0; i < 4; i++)
+	for (i = 0; i < 4; i++) {
 		devfs_remove("staliomem/%d", i);
+		class_simple_device_remove(MKDEV(STL_SIOMEMMAJOR, i));
+	}
 	devfs_remove("staliomem");
+	class_simple_destroy(istallion_class);
 	if ((i = unregister_chrdev(STL_SIOMEMMAJOR, "staliomem")))
 		printk("STALLION: failed to un-register serial memory device, "
 			"errno=%d\n", -i);
@@ -5311,10 +5317,13 @@ int __init stli_init(void)
 				"device\n");
 
 	devfs_mk_dir("staliomem");
+	istallion_class = class_simple_create(THIS_MODULE, "staliomem");
 	for (i = 0; i < 4; i++) {
 		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
 			       S_IFCHR | S_IRUSR | S_IWUSR,
 			       "staliomem/%d", i);
+		class_simple_device_add(istallion_class, MKDEV(STL_SIOMEMMAJOR, i), 
+				NULL, "staliomem/%d", i);
 	}
 
 /*

