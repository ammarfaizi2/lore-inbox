Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbUDORsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 13:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbUDORoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:44:55 -0400
Received: from mail.kroah.org ([65.200.24.183]:26550 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263166AbUDORmP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:15 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <1082050912553@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:52 -0700
Message-Id: <10820509122975@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.9, 2004/03/25 10:44:05-08:00, hannal@us.ibm.com

[PATCH] added class support to istallion.c

Here is a patch to add class support to the Stallion Intelligent multiport
serial driver.


 drivers/char/istallion.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)


diff -Nru a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c	Thu Apr 15 10:20:49 2004
+++ b/drivers/char/istallion.c	Thu Apr 15 10:20:49 2004
@@ -40,6 +40,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -795,6 +796,8 @@
 
 /*****************************************************************************/
 
+static struct class_simple *istallion_class;
+
 #ifdef MODULE
 
 /*
@@ -853,9 +856,12 @@
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
@@ -5311,10 +5317,13 @@
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

