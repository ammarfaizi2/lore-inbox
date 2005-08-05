Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262558AbVHEOua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbVHEOua (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:50:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVHEOua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:50:30 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:21037 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262558AbVHEOtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:49:55 -0400
X-IronPort-AV: i="3.95,170,1120453200"; 
   d="scan'208"; a="295052936:sNHT25936956"
Date: Fri, 5 Aug 2005 14:48:19 -0500
From: Abhay Salunke <Abhay_Salunke@dell.com>
To: linux-kernel@vger.kernel.org, greg@kroah.com
Cc: akpm@osdl.org, abhay_salunke@dell.com
Subject: [patch 2.6.13-rc5] modified firmware_class.c to support no hotplug
Message-ID: <20050805194819.GA3445@abhays.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh!!Please ignore the earlier firmware_calss.c patch sent a worng one by mistake :-(
This is the correct patch :-).

Reseending the patch for firmware_class.c submitted earlier ,the patch 
upgrades the request_firmware_nowait function to not start the hotplug 
action on a firmware update.

This patch is tested along with dell_rbu driver on i386 and x86-64 systems.

Andrew, could you please add this patch to the -mm tree.

Signed-off-by: Abhay Salunke <Abhay_Salunke@dell.com>

Thanks
Abhay
diff -uprN linux-2.6.13-rc5.orig/drivers/base/firmware_class.c linux-2.6.13-rc5.new/drivers/base/firmware_class.c
--- linux-2.6.13-rc5.orig/drivers/base/firmware_class.c	2005-08-03 18:31:24.000000000 -0500
+++ linux-2.6.13-rc5.new/drivers/base/firmware_class.c	2005-08-04 11:48:41.000000000 -0500
@@ -28,6 +28,7 @@ enum {
 	FW_STATUS_DONE,
 	FW_STATUS_ABORT,
 	FW_STATUS_READY,
+	FW_STATUS_READY_NOHOTPLUG,
 };
 
 static int loading_timeout = 10;	/* In seconds */
@@ -344,7 +345,7 @@ error_kfree:
 
 static int
 fw_setup_class_device(struct firmware *fw, struct class_device **class_dev_p,
-		      const char *fw_name, struct device *device)
+		      const char *fw_name, struct device *device, int hotplug)
 {
 	struct class_device *class_dev;
 	struct firmware_priv *fw_priv;
@@ -376,7 +377,10 @@ fw_setup_class_device(struct firmware *f
 		goto error_unreg;
 	}
 
-	set_bit(FW_STATUS_READY, &fw_priv->status);
+	if (hotplug)
+                set_bit(FW_STATUS_READY, &fw_priv->status);
+        else
+                set_bit(FW_STATUS_READY_NOHOTPLUG, &fw_priv->status);
 	*class_dev_p = class_dev;
 	goto out;
 
@@ -386,21 +390,9 @@ out:
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
@@ -419,22 +411,25 @@ request_firmware(const struct firmware *
 	}
 	memset(firmware, 0, sizeof (*firmware));
 
-	retval = fw_setup_class_device(firmware, &class_dev, name, device);
+	retval = fw_setup_class_device(firmware, &class_dev, name, device, 
+		hotplug);
 	if (retval)
 		goto error_kfree_fw;
 
 	fw_priv = class_get_devdata(class_dev);
 
-	if (loading_timeout > 0) {
-		fw_priv->timeout.expires = jiffies + loading_timeout * HZ;
-		add_timer(&fw_priv->timeout);
-	}
-
-	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
-	wait_for_completion(&fw_priv->completion);
-	set_bit(FW_STATUS_DONE, &fw_priv->status);
+	if (hotplug) {
+		if (loading_timeout > 0) {
+			fw_priv->timeout.expires = jiffies + loading_timeout * HZ;
+			add_timer(&fw_priv->timeout);
+		}
 
-	del_timer_sync(&fw_priv->timeout);
+		kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
+		wait_for_completion(&fw_priv->completion);
+		set_bit(FW_STATUS_DONE, &fw_priv->status);
+		del_timer_sync(&fw_priv->timeout);
+	} else 
+		wait_for_completion(&fw_priv->completion);
 
 	down(&fw_lock);
 	if (!fw_priv->fw->size || test_bit(FW_STATUS_ABORT, &fw_priv->status)) {
@@ -455,6 +450,26 @@ out:
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
+        int hotplug = 1;
+        return _request_firmware(firmware_p, name, device, hotplug);
+}
+
+/**
  * release_firmware: - release the resource associated with a firmware image
  **/
 void
@@ -491,6 +506,7 @@ struct firmware_work {
 	struct device *device;
 	void *context;
 	void (*cont)(const struct firmware *fw, void *context);
+	int hotplug;
 };
 
 static int
@@ -503,7 +519,8 @@ request_firmware_work_func(void *arg)
 		return 0;
 	}
 	daemonize("%s/%s", "firmware", fw_work->name);
-	request_firmware(&fw, fw_work->name, fw_work->device);
+	_request_firmware(&fw, fw_work->name, fw_work->device,
+		fw_work->hotplug);
 	fw_work->cont(fw, fw_work->context);
 	release_firmware(fw);
 	module_put(fw_work->module);
@@ -518,6 +535,9 @@ request_firmware_work_func(void *arg)
  *	Asynchronous variant of request_firmware() for contexts where
  *	it is not possible to sleep.
  *
+ *      @hotplug invokes hotplug event to copy the firmware image if this flag
+ *      is non-zero else the firmware copy must be done manually.
+ * 
  *	@cont will be called asynchronously when the firmware request is over.
  *
  *	@context will be passed over to @cont.
@@ -527,7 +547,7 @@ request_firmware_work_func(void *arg)
  **/
 int
 request_firmware_nowait(
-	struct module *module,
+	struct module *module, int hotplug,
 	const char *name, struct device *device, void *context,
 	void (*cont)(const struct firmware *fw, void *context))
 {
@@ -548,6 +568,7 @@ request_firmware_nowait(
 		.device = device,
 		.context = context,
 		.cont = cont,
+		.hotplug = hotplug,
 	};
 
 	ret = kernel_thread(request_firmware_work_func, fw_work,
diff -uprN linux-2.6.13-rc5.orig/include/linux/firmware.h linux-2.6.13-rc5.new/include/linux/firmware.h
--- linux-2.6.13-rc5.orig/include/linux/firmware.h	2005-06-17 14:48:29.000000000 -0500
+++ linux-2.6.13-rc5.new/include/linux/firmware.h	2005-08-04 11:49:10.000000000 -0500
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
@@ -11,7 +14,7 @@ struct device;
 int request_firmware(const struct firmware **fw, const char *name,
 		     struct device *device);
 int request_firmware_nowait(
-	struct module *module,
+	struct module *module, int hotplug,
 	const char *name, struct device *device, void *context,
 	void (*cont)(const struct firmware *fw, void *context));
 
