Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbUBYBir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbUBYBhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:37:41 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:46286 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262574AbUBYBe4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:34:56 -0500
Subject: Re: [PATCH] request_firmware(): fixes and polishing.
In-Reply-To: <10776728891691@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Feb 2004 02:34:49 +0100
Message-Id: <10776728893691@kroah.com>
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
	- Refactor fw_setup_class_device for readability and maintainability.

Index: linux-2.5/drivers/base/firmware_class.c
===================================================================
--- linux-2.5.orig/drivers/base/firmware_class.c	2004-01-06 13:40:49.000000000 +0100
+++ linux-2.5/drivers/base/firmware_class.c	2004-01-06 13:40:58.000000000 +0100
@@ -278,11 +278,12 @@
 	/* XXX warning we should watch out for name collisions */
 	strlcpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
 }
+
 static int
-fw_setup_class_device(struct firmware *fw, struct class_device **class_dev_p,
-		      const char *fw_name, struct device *device)
+fw_register_class_device(struct class_device **class_dev_p,
+			 const char *fw_name, struct device *device)
 {
-	int retval = 0;
+	int retval;
 	struct firmware_priv *fw_priv = kmalloc(sizeof (struct firmware_priv),
 						GFP_KERNEL);
 	struct class_device *class_dev = kmalloc(sizeof (struct class_device),
@@ -301,13 +302,13 @@
 	init_completion(&fw_priv->completion);
 	fw_priv->attr_data = firmware_attr_data_tmpl;
 	strlcpy(fw_priv->fw_id, fw_name, FIRMWARE_NAME_MAX);
-	fw_setup_class_device_id(class_dev, device);
-	class_dev->dev = device;
 
 	fw_priv->timeout.function = firmware_class_timeout;
 	fw_priv->timeout.data = (u_long) fw_priv;
 	init_timer(&fw_priv->timeout);
 
+	fw_setup_class_device_id(class_dev, device);
+	class_dev->dev = device;
 	class_dev->class = &firmware_class;
 	class_set_devdata(class_dev, fw_priv);
 	retval = class_device_register(class_dev);
@@ -316,7 +317,28 @@
 		       __FUNCTION__);
 		goto error_kfree;
 	}
+	*class_dev_p = class_dev;
+	return 0;
 
+error_kfree:
+	kfree(fw_priv);
+	kfree(class_dev);
+	return retval;
+}
+static int
+fw_setup_class_device(struct firmware *fw, struct class_device **class_dev_p,
+		      const char *fw_name, struct device *device)
+{
+	struct class_device *class_dev;
+	struct firmware_priv *fw_priv;
+	int retval;
+
+	*class_dev_p = NULL;
+	retval = fw_register_class_device(&class_dev, fw_name, device);
+	if (retval)
+		goto out;
+
+	fw_priv = class_get_devdata(class_dev);
 	fw_priv->fw = fw;
 
 	retval = sysfs_create_bin_file(&class_dev->kobj, &fw_priv->attr_data);
@@ -341,11 +363,6 @@
 	sysfs_remove_bin_file(&class_dev->kobj, &fw_priv->attr_data);
 error_unreg_class_dev:
 	class_device_unregister(class_dev);
-	goto out;
-
-error_kfree:
-	kfree(fw_priv);
-	kfree(class_dev);
 out:
 	return retval;
 }

