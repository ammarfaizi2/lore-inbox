Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbUBYBm2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 20:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbUBYBh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 20:37:27 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:44238 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262571AbUBYBez convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 20:34:55 -0500
Subject: Re: [PATCH] request_firmware(): fixes and polishing.
In-Reply-To: <10776728892832@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 25 Feb 2004 02:34:49 +0100
Message-Id: <10776728891691@kroah.com>
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


Changelog:
	- Remove races related to the handling and release of 'struct firmware'

Index: linux-2.5/drivers/base/firmware_class.c
===================================================================
--- linux-2.5.orig/drivers/base/firmware_class.c	2004-01-06 13:41:22.000000000 +0100
+++ linux-2.5/drivers/base/firmware_class.c	2004-01-06 13:43:58.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/vmalloc.h>
 #include <asm/hardirq.h>
 #include <linux/bitops.h>
+#include <asm/semaphore.h>
 
 #include <linux/firmware.h>
 #include "base.h"
@@ -24,11 +25,16 @@
 
 enum {
 	FW_STATUS_LOADING,
+	FW_STATUS_DONE,
 	FW_STATUS_ABORT,
 };
 
 static int loading_timeout = 10;	/* In seconds */
 
+/* fw_lock could be moved to 'struct firmware_priv' but since it is just
+ * guarding for corner cases a global lock should be OK */
+static DECLARE_MUTEX(fw_lock);
+
 struct firmware_priv {
 	char fw_id[FIRMWARE_NAME_MAX];
 	struct completion completion;
@@ -126,11 +132,13 @@
 
 	switch (loading) {
 	case 1:
+		down(&fw_lock);
 		vfree(fw_priv->fw->data);
 		fw_priv->fw->data = NULL;
 		fw_priv->fw->size = 0;
 		fw_priv->alloc_size = 0;
 		set_bit(FW_STATUS_LOADING, &fw_priv->status);
+		up(&fw_lock);
 		break;
 	case 0:
 		if (test_bit(FW_STATUS_LOADING, &fw_priv->status)) {
@@ -160,15 +168,26 @@
 {
 	struct class_device *class_dev = to_class_dev(kobj);
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
-	struct firmware *fw = fw_priv->fw;
+	struct firmware *fw;
+	ssize_t ret_count = count;
 
-	if (offset > fw->size)
-		return 0;
-	if (offset + count > fw->size)
-		count = fw->size - offset;
+	down(&fw_lock);
+	fw = fw_priv->fw;
+	if (test_bit(FW_STATUS_DONE, &fw_priv->status)) {
+		ret_count = -ENODEV;
+		goto out;
+	}
+	if (offset > fw->size) {
+		ret_count = 0;
+		goto out;
+	}
+	if (offset + ret_count > fw->size)
+		ret_count = fw->size - offset;
 
-	memcpy(buffer, fw->data + offset, count);
-	return count;
+	memcpy(buffer, fw->data + offset, ret_count);
+out:
+	up(&fw_lock);
+	return ret_count;
 }
 static int
 fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
@@ -209,18 +228,26 @@
 {
 	struct class_device *class_dev = to_class_dev(kobj);
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
-	struct firmware *fw = fw_priv->fw;
-	int retval;
+	struct firmware *fw;
+	ssize_t retval;
 
+	down(&fw_lock);
+	fw = fw_priv->fw;
+	if (test_bit(FW_STATUS_DONE, &fw_priv->status)) {
+		retval = -ENODEV;
+		goto out;
+	}
 	retval = fw_realloc_buffer(fw_priv, offset + count);
 	if (retval)
-		return retval;
+		goto out;
 
 	memcpy(fw->data + offset, buffer, count);
 
 	fw->size = max_t(size_t, offset + count, fw->size);
-
-	return count;
+	retval = count;
+out:
+	up(&fw_lock);
+	return retval;
 }
 static struct bin_attribute firmware_attr_data_tmpl = {
 	.attr = {.name = "data", .mode = 0644},
@@ -252,7 +279,7 @@
 	strlcpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
 }
 static int
-fw_setup_class_device(struct class_device **class_dev_p,
+fw_setup_class_device(struct firmware *fw, struct class_device **class_dev_p,
 		      const char *fw_name, struct device *device)
 {
 	int retval = 0;
@@ -290,6 +317,8 @@
 		goto error_kfree;
 	}
 
+	fw_priv->fw = fw;
+
 	retval = sysfs_create_bin_file(&class_dev->kobj, &fw_priv->attr_data);
 	if (retval) {
 		printk(KERN_ERR "%s: sysfs_create_bin_file failed\n",
@@ -305,20 +334,9 @@
 		goto error_remove_data;
 	}
 
-	fw_priv->fw = kmalloc(sizeof (struct firmware), GFP_KERNEL);
-	if (!fw_priv->fw) {
-		printk(KERN_ERR "%s: kmalloc(struct firmware) failed\n",
-		       __FUNCTION__);
-		retval = -ENOMEM;
-		goto error_remove_loading;
-	}
-	memset(fw_priv->fw, 0, sizeof (*fw_priv->fw));
-
 	*class_dev_p = class_dev;
 	goto out;
 
-error_remove_loading:
-	class_device_remove_file(class_dev, &class_device_attr_loading);
 error_remove_data:
 	sysfs_remove_bin_file(&class_dev->kobj, &fw_priv->attr_data);
 error_unreg_class_dev:
@@ -354,21 +372,29 @@
  *	firmware image for this or any other device.
  **/
 int
-request_firmware(const struct firmware **firmware, const char *name,
+request_firmware(const struct firmware **firmware_p, const char *name,
 		 struct device *device)
 {
 	struct class_device *class_dev;
 	struct firmware_priv *fw_priv;
+	struct firmware *firmware;
 	int retval;
 
-	if (!firmware)
+	if (!firmware_p)
 		return -EINVAL;
 
-	*firmware = NULL;
+	*firmware_p = firmware = kmalloc(sizeof (struct firmware), GFP_KERNEL);
+	if (!firmware) {
+		printk(KERN_ERR "%s: kmalloc(struct firmware) failed\n",
+		       __FUNCTION__);
+		retval = -ENOMEM;
+		goto out;
+	}
+	memset(firmware, 0, sizeof (*firmware));
 
-	retval = fw_setup_class_device(&class_dev, name, device);
+	retval = fw_setup_class_device(firmware, &class_dev, name, device);
 	if (retval)
-		goto out;
+		goto error_kfree_fw;
 
 	fw_priv = class_get_devdata(class_dev);
 
@@ -378,17 +404,23 @@
 	}
 
 	wait_for_completion(&fw_priv->completion);
+	set_bit(FW_STATUS_DONE, &fw_priv->status);
 
 	del_timer_sync(&fw_priv->timeout);
 
-	if (fw_priv->fw->size && !test_bit(FW_STATUS_ABORT, &fw_priv->status)) {
-		*firmware = fw_priv->fw;
-	} else {
+	down(&fw_lock);
+	if (!fw_priv->fw->size || test_bit(FW_STATUS_ABORT, &fw_priv->status)) {
 		retval = -ENOENT;
-		vfree(fw_priv->fw->data);
-		kfree(fw_priv->fw);
+		release_firmware(fw_priv->fw);
+		*firmware_p = NULL;
 	}
+	fw_priv->fw = NULL;
+	up(&fw_lock);
 	fw_remove_class_device(class_dev);
+	goto out;
+
+error_kfree_fw:
+	kfree(firmware);
 out:
 	return retval;
 }

