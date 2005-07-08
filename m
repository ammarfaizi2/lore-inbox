Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262791AbVGHTWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbVGHTWw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 15:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262784AbVGHTUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 15:20:51 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:44388 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262787AbVGHTST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 15:18:19 -0400
X-IronPort-AV: i="3.94,182,1118034000"; 
   d="scan'208"; a="263769653:sNHT18212466"
Date: Fri, 8 Jul 2005 19:16:38 -0500
From: Abhay Salunke <Abhay_Salunke@dell.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, abhay_salunke@dell.com
Cc: greg@kroah.com
Subject: [patch 2.6.12-rc3] modified firmware_class.c to add a new function request_firmware_nowait_nohotplug
Message-ID: <20050709001638.GA29546@abhays.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch which add a new function request_firmware_nowait_nohotplug 
in firmware_calss.c  This function is exported and used by dell_rbu driver.
It makes the file entries created by request_firmware to be agnostic to any 
hotplug or timeout events.

Andrew , 
Could you add this patch to the -mm tree. This patch was submitted about a
week ago for review.


Signed-off-by: Abhay Salunke <Abhay_Salunke@dell.com>

Thanks
Abhay
diff -uprN linux-2.6.11.11.orig/drivers/base/firmware_class.c linux-2.6.11.11.new/drivers/base/firmware_class.c
--- linux-2.6.11.11.orig/drivers/base/firmware_class.c	2005-06-17 22:02:47.000000000 -0500
+++ linux-2.6.11.11.new/drivers/base/firmware_class.c	2005-06-22 00:16:06.000000000 -0500
@@ -28,6 +28,7 @@ enum {
 	FW_STATUS_DONE,
 	FW_STATUS_ABORT,
 	FW_STATUS_READY,
+	FW_STATUS_READY_NOHOTPLUG,
 };
 
 static int loading_timeout = 10;	/* In seconds */
@@ -334,7 +335,7 @@ error_kfree:
 
 static int
 fw_setup_class_device(struct firmware *fw, struct class_device **class_dev_p,
-		      const char *fw_name, struct device *device)
+		      const char *fw_name, struct device *device, int hotplug)
 {
 	struct class_device *class_dev;
 	struct firmware_priv *fw_priv;
@@ -365,8 +366,11 @@ fw_setup_class_device(struct firmware *f
 		       __FUNCTION__);
 		goto error_unreg;
 	}
-
-	set_bit(FW_STATUS_READY, &fw_priv->status);
+	
+	if (hotplug)
+		set_bit(FW_STATUS_READY, &fw_priv->status);
+	else
+		set_bit(FW_STATUS_READY_NOHOTPLUG, &fw_priv->status);
 	*class_dev_p = class_dev;
 	goto out;
 
@@ -376,21 +380,9 @@ out:
 	return retval;
 }
 
-/**
- * request_firmware: - request firmware to hotplug and wait for it
- * Description:
- *	@firmware will be used to return a firmware image by the name
- *	of @name for device @device.
- *
- *	Should be called from user context where sleeping is allowed.
- *
- *	@name will be use as $FIRMWARE in the hotplug environment and
- *	should be distinctive enough not to be confused with any other
- *	firmware image for this or any other device.
- **/
-int
-request_firmware(const struct firmware **firmware_p, const char *name,
-		 struct device *device)
+static int
+_request_firmware(const struct firmware **firmware_p, const char *name,
+		 struct device *device, int hotplug)
 {
 	struct class_device *class_dev;
 	struct firmware_priv *fw_priv;
@@ -409,22 +401,25 @@ request_firmware(const struct firmware *
 	}
 	memset(firmware, 0, sizeof (*firmware));
 
-	retval = fw_setup_class_device(firmware, &class_dev, name, device);
+	retval = fw_setup_class_device(firmware, &class_dev, name, device, 
+		hotplug);
 	if (retval)
 		goto error_kfree_fw;
 
 	fw_priv = class_get_devdata(class_dev);
+	
+	if (hotplug) {
+		if (loading_timeout) {
+			fw_priv->timeout.expires = jiffies + loading_timeout * HZ;
+			add_timer(&fw_priv->timeout);
+		}
 
-	if (loading_timeout) {
-		fw_priv->timeout.expires = jiffies + loading_timeout * HZ;
-		add_timer(&fw_priv->timeout);
-	}
-
-	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
-	wait_for_completion(&fw_priv->completion);
-	set_bit(FW_STATUS_DONE, &fw_priv->status);
-
-	del_timer_sync(&fw_priv->timeout);
+		kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
+		wait_for_completion(&fw_priv->completion);
+		set_bit(FW_STATUS_DONE, &fw_priv->status);
+		del_timer_sync(&fw_priv->timeout);
+	} else
+		wait_for_completion(&fw_priv->completion);
 
 	down(&fw_lock);
 	if (!fw_priv->fw->size || test_bit(FW_STATUS_ABORT, &fw_priv->status)) {
@@ -445,6 +440,26 @@ out:
 }
 
 /**
+ * request_firmware: - request firmware to hotplug and wait for it
+ * Description:
+ *      @firmware will be used to return a firmware image by the name
+ *      of @name for device @device.
+ *
+ *      Should be called from user context where sleeping is allowed.
+ *
+ *      @name will be use as $FIRMWARE in the hotplug environment and
+ *      should be distinctive enough not to be confused with any other
+ *      firmware image for this or any other device.
+ **/
+int
+request_firmware(const struct firmware **firmware_p, const char *name,
+                 struct device *device)
+{
+	int hotplug = 1;
+	return _request_firmware(firmware_p, name, device, hotplug);	
+}
+
+/**
  * release_firmware: - release the resource associated with a firmware image
  **/
 void
@@ -481,6 +496,7 @@ struct firmware_work {
 	struct device *device;
 	void *context;
 	void (*cont)(const struct firmware *fw, void *context);
+	int hotplug;
 };
 
 static int
@@ -493,7 +509,8 @@ request_firmware_work_func(void *arg)
 		return 0;
 	}
 	daemonize("%s/%s", "firmware", fw_work->name);
-	request_firmware(&fw, fw_work->name, fw_work->device);
+	_request_firmware(&fw, fw_work->name, fw_work->device, 
+		fw_work->hotplug);
 	fw_work->cont(fw, fw_work->context);
 	release_firmware(fw);
 	module_put(fw_work->module);
@@ -501,23 +518,9 @@ request_firmware_work_func(void *arg)
 	return 0;
 }
 
-/**
- * request_firmware_nowait:
- *
- * Description:
- *	Asynchronous variant of request_firmware() for contexts where
- *	it is not possible to sleep.
- *
- *	@cont will be called asynchronously when the firmware request is over.
- *
- *	@context will be passed over to @cont.
- *
- *	@fw may be %NULL if firmware request fails.
- *
- **/
-int
-request_firmware_nowait(
-	struct module *module,
+static int
+_request_firmware_nowait(
+	struct module *module, int hotplug,
 	const char *name, struct device *device, void *context,
 	void (*cont)(const struct firmware *fw, void *context))
 {
@@ -538,6 +541,7 @@ request_firmware_nowait(
 		.device = device,
 		.context = context,
 		.cont = cont,
+		.hotplug = hotplug,
 	};
 
 	ret = kernel_thread(request_firmware_work_func, fw_work,
@@ -550,6 +554,56 @@ request_firmware_nowait(
 	return 0;
 }
 
+/**
+ * request_firmware_nowait:
+ *
+ * Description:
+ *      Asynchronous variant of request_firmware() for contexts where
+ *      it is not possible to sleep.
+ *
+ *      @cont will be called asynchronously when the firmware request is over.
+ *
+ *      @context will be passed over to @cont.
+ *
+ *      @fw may be %NULL if firmware request fails.
+ *
+ **/
+int
+request_firmware_nowait(
+        struct module *module,
+        const char *name, struct device *device, void *context,
+        void (*cont)(const struct firmware *fw, void *context))
+{
+	int hotplug = 1;
+	return _request_firmware_nowait(module, hotplug, name, device,
+		context, cont);	
+}
+
+/**
+ * request_firmware_nowait_nohotplug:
+ *
+ * Description:
+ *      Similar to request_firmware_nowait except it does not use 
+ * 	hotplug.
+ *
+ *      @cont will be called asynchronously when the firmware request is over.
+ *
+ *      @context will be passed over to @cont.
+ *
+ *      @fw may be %NULL if firmware request fails.
+ *
+ **/
+int
+request_firmware_nowait_nohotplug(
+        struct module *module,
+        const char *name, struct device *device, void *context,
+        void (*cont)(const struct firmware *fw, void *context))
+{
+        int hotplug = 0;
+        return _request_firmware_nowait(module, hotplug, name, device,
+                context, cont);
+}
+
 static int __init
 firmware_class_init(void)
 {
@@ -580,4 +634,5 @@ module_exit(firmware_class_exit);
 EXPORT_SYMBOL(release_firmware);
 EXPORT_SYMBOL(request_firmware);
 EXPORT_SYMBOL(request_firmware_nowait);
+EXPORT_SYMBOL(request_firmware_nowait_nohotplug);
 EXPORT_SYMBOL(register_firmware);
