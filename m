Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbUBYBma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbUBYBgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:36:52 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:42958 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262570AbUBYBey convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:34:54 -0500
Subject: Re: [PATCH] request_firmware(): fixes and polishing.
In-Reply-To: <10776728892888@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Feb 2004 02:34:49 +0100
Message-Id: <1077672889385@kroah.com>
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
	- Take advantage of strlcpy.
	- Extra error logging.
	- Use struct coping instead of memcpy.
	- Put all aborting code in a single place, and fully abort if
	  fw_realloc_buffer fails.
	- Abort on unexpected 'loading' values.

Index: linux-2.5/drivers/base/firmware_class.c
===================================================================
--- linux-2.5.orig/drivers/base/firmware_class.c	2004-01-06 03:23:14.000000000 +0100
+++ linux-2.5/drivers/base/firmware_class.c	2004-01-06 03:53:30.000000000 +0100
@@ -34,6 +34,14 @@
 	struct timer_list timeout;
 };
 
+static inline void
+fw_load_abort(struct firmware_priv *fw_priv)
+{
+	fw_priv->abort = 1;
+	wmb();
+	complete(&fw_priv->completion);
+}
+
 static ssize_t
 firmware_timeout_show(struct class *class, char *buf)
 {
@@ -113,11 +121,6 @@
 	fw_priv->loading = simple_strtol(buf, NULL, 10);
 
 	switch (fw_priv->loading) {
-	case -1:
-		fw_priv->abort = 1;
-		wmb();
-		complete(&fw_priv->completion);
-		break;
 	case 1:
 		vfree(fw_priv->fw->data);
 		fw_priv->fw->data = NULL;
@@ -125,8 +128,17 @@
 		fw_priv->alloc_size = 0;
 		break;
 	case 0:
-		if (prev_loading == 1)
+		if (prev_loading == 1) {
 			complete(&fw_priv->completion);
+			break;
+		}
+		/* fallthrough */
+	default:
+		printk(KERN_ERR "%s: unexpected value (%d)\n", __FUNCTION__,
+		       fw_priv->loading);
+		/* fallthrough */
+	case -1:
+		fw_load_abort(fw_priv);
 		break;
 	}
 
@@ -164,7 +176,7 @@
 	if (!new_data) {
 		printk(KERN_ERR "%s: unable to alloc buffer\n", __FUNCTION__);
 		/* Make sure that we don't keep incomplete data */
-		fw_priv->abort = 1;
+		fw_load_abort(fw_priv);
 		return -ENOMEM;
 	}
 	fw_priv->alloc_size += PAGE_SIZE;
@@ -221,17 +233,14 @@
 firmware_class_timeout(u_long data)
 {
 	struct firmware_priv *fw_priv = (struct firmware_priv *) data;
-	fw_priv->abort = 1;
-	wmb();
-	complete(&fw_priv->completion);
+	fw_load_abort(fw_priv);
 }
 
 static inline void
 fw_setup_class_device_id(struct class_device *class_dev, struct device *dev)
 {
 	/* XXX warning we should watch out for name collisions */
-	strncpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
-	class_dev->class_id[BUS_ID_SIZE - 1] = '\0';
+	strlcpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
 }
 static int
 fw_setup_class_device(struct class_device **class_dev_p,
@@ -244,6 +253,7 @@
 						 GFP_KERNEL);
 
 	if (!fw_priv || !class_dev) {
+		printk(KERN_ERR "%s: kmalloc failed\n", __FUNCTION__);
 		retval = -ENOMEM;
 		goto error_kfree;
 	}
@@ -251,12 +261,8 @@
 	memset(class_dev, 0, sizeof (*class_dev));
 
 	init_completion(&fw_priv->completion);
-	memcpy(&fw_priv->attr_data, &firmware_attr_data_tmpl,
-	       sizeof (firmware_attr_data_tmpl));
-
-	strncpy(&fw_priv->fw_id[0], fw_name, FIRMWARE_NAME_MAX);
-	fw_priv->fw_id[FIRMWARE_NAME_MAX - 1] = '\0';
-
+	fw_priv->attr_data = firmware_attr_data_tmpl;
+	strlcpy(fw_priv->fw_id, fw_name, FIRMWARE_NAME_MAX);
 	fw_setup_class_device_id(class_dev, device);
 	class_dev->dev = device;
 

