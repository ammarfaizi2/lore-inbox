Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVAYAv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVAYAv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 19:51:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVAYAcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 19:32:22 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:48619 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261749AbVAYAaT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 19:30:19 -0500
Cc: linux-kernel@vger.kernel.org, js@linuxtv.org
In-Reply-To: <11066130981300@linuxtv.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 25 Jan 2005 01:31:40 +0100
Message-Id: <11066131001936@linuxtv.org>
Mime-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
From: Johannes Stezenbach <js@linuxtv.org>
X-SA-Exim-Connect-IP: 217.86.181.249
Subject: [PATCH 3/4] support up to six DVB cards
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] core: add support for up to six DVB cards by using
  32bit dev_t capabilities

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

--- linux-2.6.11-rc2-bk2/drivers/media/dvb/dvb-core/dvbdev.c	2004-12-24 22:34:26.000000000 +0100
+++ linux-2.6.11-rc2-bk2-dvb/drivers/media/dvb/dvb-core/dvbdev.c	2005-01-25 00:35:45.000000000 +0100
@@ -31,6 +31,8 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
 
 #include "dvbdev.h"
 
@@ -50,8 +52,9 @@ static const char * const dnames[] = {
 };
 
 
-#define DVB_MAX_IDS              4
+#define DVB_MAX_IDS              6
 #define nums2minor(num,type,id)  ((num << 6) | (id << 4) | type)
+#define MAX_DVB_MINORS           (DVB_MAX_IDS*64)
 
 struct class_simple *dvb_class;
 EXPORT_SYMBOL(dvb_class);
@@ -109,6 +112,11 @@ static struct file_operations dvb_device
 };
 
 
+static struct cdev dvb_device_cdev = {
+	.kobj   = {.name = "dvb", },
+	.owner  =       THIS_MODULE,
+};
+
 int dvb_generic_open(struct inode *inode, struct file *file)
 {
         struct dvb_device *dvbdev = file->private_data;
@@ -400,25 +408,41 @@ out:
 static int __init init_dvbdev(void)
 {
 	int retval;
+	dev_t dev = MKDEV(DVB_MAJOR, 0);
+
+	if ((retval = register_chrdev_region(dev, MAX_DVB_MINORS, "DVB")) != 0) {
+		printk("dvb-core: unable to get major %d\n", DVB_MAJOR);
+		return retval;
+	}
 
-	if ((retval = register_chrdev(DVB_MAJOR,"DVB", &dvb_device_fops)))
+	cdev_init(&dvb_device_cdev, &dvb_device_fops);
+	if ((retval = cdev_add(&dvb_device_cdev, dev, MAX_DVB_MINORS)) != 0) {
 		printk("dvb-core: unable to get major %d\n", DVB_MAJOR);
+		goto error;
+	}
 
 	devfs_mk_dir("dvb");
 
 	dvb_class = class_simple_create(THIS_MODULE, "dvb");
-	if (IS_ERR(dvb_class))
-		return PTR_ERR(dvb_class);
+	if (IS_ERR(dvb_class)) {
+		retval = PTR_ERR(dvb_class);
+		goto error;
+	}
+	return 0;
 
+error:
+	cdev_del(&dvb_device_cdev);
+	unregister_chrdev_region(dev, MAX_DVB_MINORS);
 	return retval;
 }
 
 
 static void __exit exit_dvbdev(void)
 {
-	unregister_chrdev(DVB_MAJOR, "DVB");
         devfs_remove("dvb");
 	class_simple_destroy(dvb_class);
+	cdev_del(&dvb_device_cdev);
+        unregister_chrdev_region(MKDEV(DVB_MAJOR, 0), MAX_DVB_MINORS);
 }
 
 module_init(init_dvbdev);

