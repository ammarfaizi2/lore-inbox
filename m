Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVGTSva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVGTSva (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 14:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbVGTSva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 14:51:30 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:61363 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261490AbVGTSv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 14:51:28 -0400
X-OUTRCPT-TO: linux-kernel@vger.kernel.org, greg@kroah.com, akpm@osdl.org, abhay_salunke@dell.com
X-OUTMAIL-FROM: abhay_salunke@abhays.us.dell.com
X-IronPort-AV: i="3.94,212,1118034000"; 
   d="scan'208"; a="288736621:sNHT19078548"
Date: Wed, 20 Jul 2005 18:49:49 -0500
From: Abhay Salunke <Abhay_Salunke@dell.com>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Cc: akpm@osdl.org, abhay_salunke@dell.com
Subject: [patch 2.6.12-rc3] modified firmware_class.c to support no hotplug
Message-ID: <20050720234949.GA6473@abhays.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reseending the patch for firmware_class.c submitted earlier ,the patch 
upgrades the request_firmware_nowait function to not start the hotplug 
action on a firmware update.

This patch is tested along with dell_rbu driver on i386 and x86-64 systems.

Andrew, could you please add this patch to the -mm tree.

Signed-off-by: Abhay Salunke <Abhay_Salunke@dell.com>

Thanks
Abhay
diff -uprN linux-2.6.11.11.orig/drivers/base/firmware_class.c linux-2.6.11.11.new/drivers/base/firmware_class.c
--- linux-2.6.11.11.orig/drivers/base/firmware_class.c	2005-06-17 22:02:47.000000000 -0500
+++ linux-2.6.11.11.new/drivers/base/firmware_class.c	2005-07-12 15:40:52.000000000 -0500
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
@@ -501,23 +518,27 @@ request_firmware_work_func(void *arg)
 	return 0;
 }
 
+
 /**
  * request_firmware_nowait:
  *
  * Description:
- *	Asynchronous variant of request_firmware() for contexts where
- *	it is not possible to sleep.
+ *      Asynchronous variant of request_firmware() for contexts where
+ *      it is not possible to sleep.
+ *
+ *	@hotplug invokes hotplug event to copy the firmware image if this flag
+ *	is non-zero else the firmware copy must be done manually.
  *
- *	@cont will be called asynchronously when the firmware request is over.
+ *      @cont will be called asynchronously when the firmware request is over.
  *
- *	@context will be passed over to @cont.
+ *      @context will be passed over to @cont.
  *
- *	@fw may be %NULL if firmware request fails.
+ *      @fw may be %NULL if firmware request fails.
  *
  **/
 int
 request_firmware_nowait(
-	struct module *module,
+	struct module *module, int hotplug,
 	const char *name, struct device *device, void *context,
 	void (*cont)(const struct firmware *fw, void *context))
 {
@@ -538,6 +559,7 @@ request_firmware_nowait(
 		.device = device,
 		.context = context,
 		.cont = cont,
+		.hotplug = hotplug,
 	};
 
 	ret = kernel_thread(request_firmware_work_func, fw_work,
diff -uprN linux-2.6.11.11.orig/include/linux/firmware.h linux-2.6.11.11.new/include/linux/firmware.h
--- linux-2.6.11.11.orig/include/linux/firmware.h	2005-06-14 20:53:13.000000000 -0500
+++ linux-2.6.11.11.new/include/linux/firmware.h	2005-07-12 15:51:05.000000000 -0500
@@ -3,6 +3,9 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #define FIRMWARE_NAME_MAX 30 
+#define FW_ACTION_NOHOTPLUG 0
+#define FW_ACTION_HOTPLUG 1
+
 struct firmware {
 	size_t size;
 	u8 *data;
@@ -11,10 +14,9 @@ struct device;
 int request_firmware(const struct firmware **fw, const char *name,
 		     struct device *device);
 int request_firmware_nowait(
-	struct module *module,
+	struct module *module, int hotplug,
 	const char *name, struct device *device, void *context,
 	void (*cont)(const struct firmware *fw, void *context));
-
 void release_firmware(const struct firmware *fw);
 void register_firmware(const char *name, const u8 *data, size_t size);
 #endif
