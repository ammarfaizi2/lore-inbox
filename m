Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265327AbTL0FcV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 00:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbTL0Fb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 00:31:28 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:21630 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265327AbTL0Fal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 00:30:41 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [2.6 PATCH/RFC] Firmware loader fixes - take 2 (patch 1/2)
Date: Sat, 27 Dec 2003 00:29:56 -0500
User-Agent: KMail/1.5.4
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manuel Estrada Sainz <ranty@debian.org>,
       Patrick Mochel <mochel@osdl.org>
References: <200312210137.41343.dtor_core@ameritech.net> <1072169289.2876.57.camel@pegasus> <200312270025.24160.dtor_core@ameritech.net>
In-Reply-To: <200312270025.24160.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200312270028.26952.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================


ChangeSet@1.1527, 2003-12-25 22:44:59-05:00, dtor_core@ameritech.net
  Firmware loader: correctly free allocated resources
   - free allocated memory in class_device release method
   - rely on sysfs to remove all attributes when device class
     gets unregistered


 firmware_class.c |  229 ++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 135 insertions(+), 94 deletions(-)


===================================================================



diff -Nru a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
--- a/drivers/base/firmware_class.c	Sat Dec 27 00:27:19 2003
+++ b/drivers/base/firmware_class.c	Sat Dec 27 00:27:19 2003
@@ -21,6 +21,11 @@
 MODULE_DESCRIPTION("Multi purpose firmware loading support");
 MODULE_LICENSE("GPL");
 
+#define FW_STATE_ABORTED	-1
+#define FW_STATE_LOADED		0
+#define FW_STATE_LOADING	1
+#define FW_STATE_NEW		2
+
 static int loading_timeout = 10;	/* In seconds */
 
 struct firmware_priv {
@@ -28,8 +33,7 @@
 	struct completion completion;
 	struct bin_attribute attr_data;
 	struct firmware *fw;
-	int loading;
-	int abort;
+	int state;
 	int alloc_size;
 	struct timer_list timeout;
 };
@@ -91,7 +95,23 @@
 firmware_loading_show(struct class_device *class_dev, char *buf)
 {
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
-	return sprintf(buf, "%d\n", fw_priv->loading);
+	return sprintf(buf, "%d\n", fw_priv->state);
+}
+
+static void firmware_start_loading(struct firmware_priv *fw_priv)
+{
+	fw_priv->state = FW_STATE_LOADING;
+	vfree(fw_priv->fw->data);
+	fw_priv->fw->data = NULL;
+	fw_priv->fw->size = 0;
+	fw_priv->alloc_size = 0;
+}
+
+static void firmware_finish_loading(struct firmware_priv *fw_priv, int commit)
+{
+	fw_priv->state = commit ? FW_STATE_LOADED : FW_STATE_ABORTED;
+	wmb();
+	complete(&fw_priv->completion);
 }
 
 /**
@@ -108,25 +128,21 @@
 		       const char *buf, size_t count)
 {
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
-	int prev_loading = fw_priv->loading;
+	int new_state = simple_strtol(buf, NULL, 10);
+	int complete;
 
-	fw_priv->loading = simple_strtol(buf, NULL, 10);
-
-	switch (fw_priv->loading) {
-	case -1:
-		fw_priv->abort = 1;
-		wmb();
-		complete(&fw_priv->completion);
+	switch (new_state) {
+	case FW_STATE_LOADING:
+		firmware_start_loading(fw_priv);
 		break;
-	case 1:
-		kfree(fw_priv->fw->data);
-		fw_priv->fw->data = NULL;
-		fw_priv->fw->size = 0;
-		fw_priv->alloc_size = 0;
+	case FW_STATE_LOADED:
+		complete = fw_priv->state == FW_STATE_LOADING &&
+			   fw_priv->fw->size != 0;
+		firmware_finish_loading(fw_priv, complete); 
 		break;
-	case 0:
-		if (prev_loading == 1)
-			complete(&fw_priv->completion);
+	case FW_STATE_ABORTED:
+	default:
+		firmware_finish_loading(fw_priv, 0);
 		break;
 	}
 
@@ -164,7 +180,7 @@
 	if (!new_data) {
 		printk(KERN_ERR "%s: unable to alloc buffer\n", __FUNCTION__);
 		/* Make sure that we don't keep incomplete data */
-		fw_priv->abort = 1;
+		firmware_finish_loading(fw_priv, 0);
 		return -ENOMEM;
 	}
 	fw_priv->alloc_size += PAGE_SIZE;
@@ -214,6 +230,12 @@
 static void
 fw_class_dev_release(struct class_device *class_dev)
 {
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+
+	if (fw_priv->state != FW_STATE_LOADED)
+		release_firmware(fw_priv->fw);
+
+	kfree(fw_priv);
 	kfree(class_dev);
 }
 
@@ -221,63 +243,109 @@
 firmware_class_timeout(u_long data)
 {
 	struct firmware_priv *fw_priv = (struct firmware_priv *) data;
-	fw_priv->abort = 1;
-	wmb();
-	complete(&fw_priv->completion);
+
+	firmware_finish_loading(fw_priv, 0);
 }
 
 static inline void
 fw_setup_class_device_id(struct class_device *class_dev, struct device *dev)
 {
 	/* XXX warning we should watch out for name collisions */
-	strncpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
-	class_dev->class_id[BUS_ID_SIZE - 1] = '\0';
+	strlcpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
 }
-static int
-fw_setup_class_device(struct class_device **class_dev_p,
-		      const char *fw_name, struct device *device)
-{
-	int retval = 0;
-	struct firmware_priv *fw_priv = kmalloc(sizeof (struct firmware_priv),
-						GFP_KERNEL);
-	struct class_device *class_dev = kmalloc(sizeof (struct class_device),
-						 GFP_KERNEL);
 
-	if (!fw_priv || !class_dev) {
+static struct class_device *fw_alloc_class_device(struct device *device,
+						  const char *fw_name)
+{
+	struct firmware *firmware;
+	struct firmware_priv *fw_priv;
+	struct class_device *class_dev;
+	int retval;
+ 
+	firmware = kmalloc(sizeof (struct firmware), GFP_KERNEL);
+	if (!firmware) {
+		printk(KERN_ERR "%s: kmalloc(struct firmware) failed\n",
+		       __FUNCTION__);
 		retval = -ENOMEM;
-		goto error_kfree;
+		goto err_out; 
 	}
-	memset(fw_priv, 0, sizeof (*fw_priv));
-	memset(class_dev, 0, sizeof (*class_dev));
 
+	memset(firmware, 0, sizeof (*firmware));
+       
+	fw_priv = kmalloc(sizeof(struct firmware_priv), GFP_KERNEL);
+	if (!fw_priv) {
+		printk(KERN_ERR "%s: kmalloc(struct firmware_priv) failed\n",
+		       __FUNCTION__);
+		goto err_out_free_firmware;
+        }
+
+	memset(fw_priv, 0, sizeof (*fw_priv));
+	strlcpy(fw_priv->fw_id, fw_name, FIRMWARE_NAME_MAX);
 	init_completion(&fw_priv->completion);
-	memcpy(&fw_priv->attr_data, &firmware_attr_data_tmpl,
-	       sizeof (firmware_attr_data_tmpl));
+	fw_priv->attr_data = firmware_attr_data_tmpl;
+	fw_priv->fw = firmware;
+	fw_priv->state = FW_STATE_NEW;
+	init_timer(&fw_priv->timeout);
+	fw_priv->timeout.function = firmware_class_timeout;
+	fw_priv->timeout.data = (u_long) fw_priv;
 
-	strncpy(&fw_priv->fw_id[0], fw_name, FIRMWARE_NAME_MAX);
-	fw_priv->fw_id[FIRMWARE_NAME_MAX - 1] = '\0';
+	class_dev = kmalloc(sizeof(struct class_device), GFP_KERNEL);
+	if (!class_dev) {
+		printk(KERN_ERR "%s: kmalloc(struct class_device) failed\n",
+		       __FUNCTION__);
+		goto err_out_free_fw_priv;
+	}
 
+	memset(class_dev, 0, sizeof(*class_dev));
 	fw_setup_class_device_id(class_dev, device);
 	class_dev->dev = device;
-
-	fw_priv->timeout.function = firmware_class_timeout;
-	fw_priv->timeout.data = (u_long) fw_priv;
-	init_timer(&fw_priv->timeout);
-
 	class_dev->class = &firmware_class;
 	class_set_devdata(class_dev, fw_priv);
+
+	return class_dev;
+
+err_out_free_fw_priv:
+	kfree(fw_priv);
+err_out_free_firmware:
+	kfree(firmware);
+err_out:
+	return NULL;
+}
+
+static int
+fw_setup_class_device(struct class_device **class_dev_p,
+		      const char *fw_name, struct device *device)
+{
+	struct class_device *class_dev = fw_alloc_class_device(device, fw_name);
+	struct firmware_priv *fw_priv;
+	int retval;
+
+	if (!class_dev) {
+		retval = -ENOMEM;
+		goto err_out;
+	}
+
+	fw_priv = class_get_devdata(class_dev);
+
 	retval = class_device_register(class_dev);
 	if (retval) {
 		printk(KERN_ERR "%s: class_device_register failed\n",
 		       __FUNCTION__);
-		goto error_kfree;
+		fw_class_dev_release(class_dev);
+		retval = -ENOMEM;
+		goto err_out;
 	}
 
+	/*
+	 * We successfully registered class_dev, now we should not
+	 * manually free resources as they will be freed automatically.
+	 */
+
 	retval = sysfs_create_bin_file(&class_dev->kobj, &fw_priv->attr_data);
 	if (retval) {
 		printk(KERN_ERR "%s: sysfs_create_bin_file failed\n",
 		       __FUNCTION__);
-		goto error_unreg_class_dev;
+		goto err_out_unregister;
 	}
 
 	retval = class_device_create_file(class_dev,
@@ -285,43 +353,18 @@
 	if (retval) {
 		printk(KERN_ERR "%s: class_device_create_file failed\n",
 		       __FUNCTION__);
-		goto error_remove_data;
+		goto err_out_unregister;
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
-	goto out;
+	*class_dev_p = class_dev;
+	return 0;
 
-error_remove_loading:
-	class_device_remove_file(class_dev, &class_device_attr_loading);
-error_remove_data:
-	sysfs_remove_bin_file(&class_dev->kobj, &fw_priv->attr_data);
-error_unreg_class_dev:
+err_out_unregister:
 	class_device_unregister(class_dev);
-error_kfree:
-	kfree(fw_priv);
-	kfree(class_dev);
+err_out:
 	*class_dev_p = NULL;
-out:
-	*class_dev_p = class_dev;
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
@@ -362,16 +405,13 @@
 	wait_for_completion(&fw_priv->completion);
 
 	del_timer(&fw_priv->timeout);
-	fw_remove_class_device(class_dev);
 
-	if (fw_priv->fw->size && !fw_priv->abort) {
+	if (fw_priv->state == FW_STATE_LOADED)
 		*firmware = fw_priv->fw;
-	} else {
+	else
 		retval = -ENOENT;
-		vfree(fw_priv->fw->data);
-		kfree(fw_priv->fw);
-	}
-	kfree(fw_priv);
+
+	class_device_unregister(class_dev);
 out:
 	return retval;
 }
@@ -475,23 +515,24 @@
 firmware_class_init(void)
 {
 	int error;
+
 	error = class_register(&firmware_class);
 	if (error) {
 		printk(KERN_ERR "%s: class_register failed\n", __FUNCTION__);
-	}
-	error = class_create_file(&firmware_class, &class_attr_timeout);
-	if (error) {
-		printk(KERN_ERR "%s: class_create_file failed\n",
-		       __FUNCTION__);
-		class_unregister(&firmware_class);
+	} else {
+		error = class_create_file(&firmware_class, &class_attr_timeout);
+		if (error) {
+			printk(KERN_ERR "%s: class_create_file failed\n",
+			       __FUNCTION__);
+			class_unregister(&firmware_class);
+		}
 	}
 	return error;
-
 }
+
 static void __exit
 firmware_class_exit(void)
 {
-	class_remove_file(&firmware_class, &class_attr_timeout);
 	class_unregister(&firmware_class);
 }
 
