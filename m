Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263153AbUDOSST (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 14:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263225AbUDORnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 13:43:42 -0400
Received: from mail.kroah.org ([65.200.24.183]:29622 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263185AbUDORmT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 13:42:19 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core update for 2.6.6-rc1
In-Reply-To: <1082050912368@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Thu, 15 Apr 2004 10:41:52 -0700
Message-Id: <1082050912553@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1643.36.8, 2004/03/25 10:43:11-08:00, hannal@us.ibm.com

[PATCH] added class support to stallion.c

Here is a patch to add class support to the Stallion multiport
serial driver.


 drivers/char/stallion.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)


diff -Nru a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c	Thu Apr 15 10:20:54 2004
+++ b/drivers/char/stallion.c	Thu Apr 15 10:20:54 2004
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
+#include <linux/device.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -732,6 +733,8 @@
 
 /*****************************************************************************/
 
+static struct class_simple *stallion_class;
+
 #ifdef MODULE
 
 /*
@@ -788,12 +791,15 @@
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
@@ -3181,10 +3187,12 @@
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

