Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbUBYBiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbUBYBhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:37:52 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:46030 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262573AbUBYBe4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:34:56 -0500
Subject: Re: [PATCH] request_firmware(): fixes and polishing.
In-Reply-To: <10776728893691@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Feb 2004 02:34:49 +0100
Message-Id: <1077672889458@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>, jt@hpl.hp.com,
       Simon Kelley <simon@thekelleys.org.uk>
Content-Transfer-Encoding: 7BIT
From: Manuel Estrada Sainz <ranty@ranty.pantax.net>
X-SA-Exim-Mail-From: ranty@ranty.pantax.net
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on patch and suggestions from Dmitry Torokhov

Changelog:
	- Don't remove attributes, they should be gone automatically.

Index: linux-2.5/drivers/base/firmware_class.c
===================================================================
--- linux-2.5.orig/drivers/base/firmware_class.c	2004-01-06 13:40:58.000000000 +0100
+++ linux-2.5/drivers/base/firmware_class.c	2004-01-06 13:41:07.000000000 +0100
@@ -339,13 +339,13 @@
 		goto out;
 
 	fw_priv = class_get_devdata(class_dev);
-	fw_priv->fw = fw;
 
+	fw_priv->fw = fw;
 	retval = sysfs_create_bin_file(&class_dev->kobj, &fw_priv->attr_data);
 	if (retval) {
 		printk(KERN_ERR "%s: sysfs_create_bin_file failed\n",
 		       __FUNCTION__);
-		goto error_unreg_class_dev;
+		goto error_unreg;
 	}
 
 	retval = class_device_create_file(class_dev,
@@ -353,28 +353,17 @@
 	if (retval) {
 		printk(KERN_ERR "%s: class_device_create_file failed\n",
 		       __FUNCTION__);
-		goto error_remove_data;
+		goto error_unreg;
 	}
 
 	*class_dev_p = class_dev;
 	goto out;
 
-error_remove_data:
-	sysfs_remove_bin_file(&class_dev->kobj, &fw_priv->attr_data);
-error_unreg_class_dev:
+error_unreg:
 	class_device_unregister(class_dev);
 out:
 	return retval;
 }
-static void
-fw_remove_class_device(struct class_device *class_dev)
-{
-	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
-
-	class_device_remove_file(class_dev, &class_device_attr_loading);
-	sysfs_remove_bin_file(&class_dev->kobj, &fw_priv->attr_data);
-	class_device_unregister(class_dev);
-}
 
 /** 
  * request_firmware: - request firmware to hotplug and wait for it
@@ -433,7 +422,7 @@
 	}
 	fw_priv->fw = NULL;
 	up(&fw_lock);
-	fw_remove_class_device(class_dev);
+	class_device_unregister(class_dev);
 	goto out;
 
 error_kfree_fw:
@@ -569,7 +558,6 @@
 static void __exit
 firmware_class_exit(void)
 {
-	class_remove_file(&firmware_class, &class_attr_timeout);
 	class_unregister(&firmware_class);
 }
 

