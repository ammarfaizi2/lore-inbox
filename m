Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVFHQkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVFHQkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbVFHQIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:08:05 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:12468 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S261346AbVFHQAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:00:09 -0400
X-IronPort-AV: i="3.93,183,1115010000"; 
   d="scan'208"; a="270665989:sNHT28621596"
Date: Wed, 8 Jun 2005 10:56:41 -0500
From: Abhay Salunke <Abhay_Salunke@dell.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Cc: abhay_salunke@dell.com, matt_domsch@dell.com, Greg KH <greg@kroah.com>,
       Manuel Estrada Sainz <ranty@debian.org>
Subject: [patch 2.6.12-rc3] modifications in firmware_class.c to support nohotplug
Message-ID: <20050608155641.GA12206@littleblue.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -364,6 +364,7 @@ fw_setup_class_device(struct firmware *f
>>  		printk(KERN_ERR "%s: class_device_create_file failed\n",
>>  		       __FUNCTION__);
>>  		goto error_unreg;
>> +r
>>  	}

> Broken?

Oh! yes, fixed in the following patch 

By making a contribution to this project, I certify that:
The contribution was created in whole or in part by me and I have the
right to submit it under the open source license indicated in the file.
Resubmitting after cleaning up spaces/tabs etc...

Signed-off-by: Abhay Salunke <Abhay_Salunke@dell.com>

Thanks,
Abhay Salunke
Software Engineer.
DELL Inc

diff -uprN /usr/src/linux-2.6.11.11.ORIG/drivers/base/firmware_class.c /usr/src/linux-2.6.11.11/drivers/base/firmware_class.c
--- /usr/src/linux-2.6.11.11.ORIG/drivers/base/firmware_class.c	2005-06-08 09:49:57.874162352 -0500
+++ /usr/src/linux-2.6.11.11/drivers/base/firmware_class.c	2005-06-08 10:32:35.581331760 -0500
@@ -87,7 +87,7 @@ static struct class firmware_class = {
 	.name		= "firmware",
 	.hotplug	= firmware_class_hotplug,
 	.release	= fw_class_dev_release,
-};
+};  
 
 int
 firmware_class_hotplug(struct class_device *class_dev, char **envp,
@@ -376,6 +376,65 @@ out:
 	return retval;
 }
 
+static int
+_request_firmware(const struct firmware **firmware_p, const char *name,
+                 struct device *device, int fw_hotplug)
+{
+        struct class_device *class_dev;
+        struct firmware_priv *fw_priv;
+        struct firmware *firmware;
+        int retval;
+
+        if (!firmware_p)
+               return -EINVAL;
+
+        *firmware_p = firmware = kmalloc(sizeof (struct firmware), GFP_KERNEL);
+        if (!firmware) {
+                printk(KERN_ERR "%s: kmalloc(struct firmware) failed\n",
+                       __FUNCTION__);
+                retval = -ENOMEM;
+                goto out;
+        }
+        memset(firmware, 0, sizeof (*firmware));
+
+        retval = fw_setup_class_device(firmware, &class_dev, name, device);
+        if (retval)
+                goto error_kfree_fw;
+
+        fw_priv = class_get_devdata(class_dev);
+
+	if ( fw_hotplug == FW_DO_HOTPLUG) {
+	        if (loading_timeout) {
+        	        fw_priv->timeout.expires = 
+				jiffies + loading_timeout * HZ;
+                	add_timer(&fw_priv->timeout);
+        	}
+	       	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
+	}
+
+        wait_for_completion(&fw_priv->completion);
+        set_bit(FW_STATUS_DONE, &fw_priv->status);
+
+        del_timer_sync(&fw_priv->timeout);
+
+        down(&fw_lock);
+        if (!fw_priv->fw->size || test_bit(FW_STATUS_ABORT, &fw_priv->status)) {
+                retval = -ENOENT;
+                release_firmware(fw_priv->fw);
+                *firmware_p = NULL;
+        }
+        fw_priv->fw = NULL;
+        up(&fw_lock);
+        class_device_unregister(class_dev);
+        goto out;
+
+error_kfree_fw:
+        kfree(firmware);
+        *firmware_p = NULL;
+out:
+        return retval;
+}
+
 /**
  * request_firmware: - request firmware to hotplug and wait for it
  * Description:
@@ -392,56 +451,7 @@ int
 request_firmware(const struct firmware **firmware_p, const char *name,
 		 struct device *device)
 {
-	struct class_device *class_dev;
-	struct firmware_priv *fw_priv;
-	struct firmware *firmware;
-	int retval;
-
-	if (!firmware_p)
-		return -EINVAL;
-
-	*firmware_p = firmware = kmalloc(sizeof (struct firmware), GFP_KERNEL);
-	if (!firmware) {
-		printk(KERN_ERR "%s: kmalloc(struct firmware) failed\n",
-		       __FUNCTION__);
-		retval = -ENOMEM;
-		goto out;
-	}
-	memset(firmware, 0, sizeof (*firmware));
-
-	retval = fw_setup_class_device(firmware, &class_dev, name, device);
-	if (retval)
-		goto error_kfree_fw;
-
-	fw_priv = class_get_devdata(class_dev);
-
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
-
-	down(&fw_lock);
-	if (!fw_priv->fw->size || test_bit(FW_STATUS_ABORT, &fw_priv->status)) {
-		retval = -ENOENT;
-		release_firmware(fw_priv->fw);
-		*firmware_p = NULL;
-	}
-	fw_priv->fw = NULL;
-	up(&fw_lock);
-	class_device_unregister(class_dev);
-	goto out;
-
-error_kfree_fw:
-	kfree(firmware);
-	*firmware_p = NULL;
-out:
-	return retval;
+	return _request_firmware(firmware_p, name, device, FW_DO_HOTPLUG);
 }
 
 /**
@@ -472,14 +482,15 @@ register_firmware(const char *name, cons
 	 * decide if firmware caching is reasonable just leave it as a
 	 * noop */
 }
-
+ 
 /* Async support */
 struct firmware_work {
 	struct work_struct work;
-	struct module *module;
+ 	struct module *module;
 	const char *name;
 	struct device *device;
 	void *context;
+	int hotplug;
 	void (*cont)(const struct firmware *fw, void *context);
 };
 
@@ -493,7 +504,7 @@ request_firmware_work_func(void *arg)
 		return 0;
 	}
 	daemonize("%s/%s", "firmware", fw_work->name);
-	request_firmware(&fw, fw_work->name, fw_work->device);
+	_request_firmware(&fw, fw_work->name, fw_work->device, fw_work->hotplug);
 	fw_work->cont(fw, fw_work->context);
 	release_firmware(fw);
 	module_put(fw_work->module);
@@ -501,23 +512,9 @@ request_firmware_work_func(void *arg)
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
+	struct module *module, int fw_hotplug,
 	const char *name, struct device *device, void *context,
 	void (*cont)(const struct firmware *fw, void *context))
 {
@@ -528,7 +525,7 @@ request_firmware_nowait(
 	if (!fw_work)
 		return -ENOMEM;
 	if (!try_module_get(module)) {
-		kfree(fw_work);
+ 		kfree(fw_work);
 		return -EFAULT;
 	}
 
@@ -538,6 +535,7 @@ request_firmware_nowait(
 		.device = device,
 		.context = context,
 		.cont = cont,
+		.hotplug = fw_hotplug,
 	};
 
 	ret = kernel_thread(request_firmware_work_func, fw_work,
@@ -550,6 +548,41 @@ request_firmware_nowait(
 	return 0;
 }
 
+/**
+ * request_firmware_nowait:
+ *
+ * Description:
+ *	Asynchronous variant of request_firmware() for contexts where
+ *	it is not possible to sleep.
+ *
+ *	@cont will be called asynchronously when the firmware request is over.
+ *
+ *	@context will be passed over to @cont.
+ *
+ *	@fw may be %NULL if firmware request fails.
+ *
+ **/
+int
+request_firmware_nowait(
+	struct module *module,
+	const char *name, struct device *device, void *context,
+	void (*cont)(const struct firmware *fw, void *context))
+{
+	return _request_firmware_nowait(module, FW_DO_HOTPLUG, name, 
+					device, context, cont);
+}
+
+int
+request_firmware_nohotplug(
+	struct module *module,
+        const char *name, struct device *device,void *context,
+        void (*cont)(const struct firmware *fw, void *context))
+{
+	return _request_firmware_nowait(module, FW_NO_HOTPLUG_NO_TIMEOUT, 
+					name, device, context, cont);
+}
+
+
 static int __init
 firmware_class_init(void)
 {
@@ -568,6 +601,7 @@ firmware_class_init(void)
 	return error;
 
 }
+
 static void __exit
 firmware_class_exit(void)
 {
@@ -581,3 +615,5 @@ EXPORT_SYMBOL(release_firmware);
 EXPORT_SYMBOL(request_firmware);
 EXPORT_SYMBOL(request_firmware_nowait);
 EXPORT_SYMBOL(register_firmware);
+EXPORT_SYMBOL(request_firmware_nohotplug);
+
diff -uprN /usr/src/linux-2.6.11.11.ORIG/include/linux/firmware.h /usr/src/linux-2.6.11.11/include/linux/firmware.h
--- /usr/src/linux-2.6.11.11.ORIG/include/linux/firmware.h	2005-06-08 09:49:57.711187128 -0500
+++ /usr/src/linux-2.6.11.11/include/linux/firmware.h	2005-06-08 09:50:41.714497608 -0500
@@ -3,6 +3,8 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #define FIRMWARE_NAME_MAX 30 
+#define FW_DO_HOTPLUG (0)
+#define FW_NO_HOTPLUG_NO_TIMEOUT (1)
 struct firmware {
 	size_t size;
 	u8 *data;
@@ -15,6 +17,11 @@ int request_firmware_nowait(
 	const char *name, struct device *device, void *context,
 	void (*cont)(const struct firmware *fw, void *context));
 
+int request_firmware_nohotplug(
+	struct module *module,
+	const char *name, struct device *device, void *context,
+	void (*cont)(const struct firmware *fw, void *context));
+
 void release_firmware(const struct firmware *fw);
 void register_firmware(const char *name, const u8 *data, size_t size);
 #endif
