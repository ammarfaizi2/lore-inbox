Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261680AbVFPAiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbVFPAiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 20:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVFPAiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 20:38:10 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:34747 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261680AbVFPAhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 20:37:53 -0400
X-IronPort-AV: i="3.93,202,1115010000"; 
   d="scan'208"; a="254822504:sNHT18661108"
Date: Wed, 15 Jun 2005 19:34:14 -0500
From: Abhay Salunke <Abhay_Salunke@dell.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Cc: abhay_salunke@dell.com, matt_domsch@dell.com
Subject: [patch 2.6.12-rc3] Adds persistent entryies using request_firmware_nowaitManuel Estrada Sainz <ranty@debian.org>,
Message-ID: <20050616003414.GA1814@littleblue.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a patch to make the /sys/class/firmware entries persistent. 
This has been tested with dell_rbu; dell_rbu was modified to not call
request_firmware_nowait again form the callback function. 

The new mechanism to make the entries persistent is as follows
1> echo 0 > /sys/class/firmware/timeout
2> echo 2 > /sys/class/firmware/xxx/loading

step 1 prevents timeout to occur , step 2 makes the entry xxx persistent

if we want to remove persistence then do this
ech0 -2 > /sys/class/firmware/xxx/loading

The rest of the functionality is not affected.

Also not the persistence is supported only if the driver calls
request_firmware_nowait. If the driver is just calling request_firmware, 
step 2 is treated as unknown entry.

Signed-off-by: Abhay Salunke <Abhay_Salunke@dell.com>

Thanks,
Abhay Salunke
Software Engineer.
DELL Inc

diff -uprN /usr/src/linux-2.6.11.11.orig/drivers/base/firmware_class.c /usr/src/linux-2.6.11.11.new/drivers/base/firmware_class.c
--- /usr/src/linux-2.6.11.11.orig/drivers/base/firmware_class.c	2005-06-14 20:53:04.000000000 -0500
+++ /usr/src/linux-2.6.11.11.new/drivers/base/firmware_class.c	2005-06-16 00:21:10.000000000 -0500
@@ -6,6 +6,11 @@
  * Please see Documentation/firmware_class/ for more information.
  *
  */
+ /*
+ * 2005-06-15: 	Abhay Salunke <abhay_salunke@dell.com>
+ *		Added firmware persistent when request_firmware_nowait.
+ *		is called. 
+ */
 
 #include <linux/device.h>
 #include <linux/module.h>
@@ -28,6 +33,8 @@ enum {
 	FW_STATUS_DONE,
 	FW_STATUS_ABORT,
 	FW_STATUS_READY,
+	FW_STATUS_PERSISTENT,
+	FW_STATUS_PERSISTENT_ABORT,
 };
 
 static int loading_timeout = 10;	/* In seconds */
@@ -142,13 +149,20 @@ firmware_loading_store(struct class_devi
 		set_bit(FW_STATUS_LOADING, &fw_priv->status);
 		up(&fw_lock);
 		break;
+	case 2:
+                set_bit(FW_STATUS_PERSISTENT, &fw_priv->status);
+		fw_load_abort(fw_priv);
+		break;
 	case 0:
 		if (test_bit(FW_STATUS_LOADING, &fw_priv->status)) {
 			complete(&fw_priv->completion);
 			clear_bit(FW_STATUS_LOADING, &fw_priv->status);
 			break;
 		}
-		/* fallthrough */
+	case -2:
+		set_bit(FW_STATUS_PERSISTENT_ABORT, &fw_priv->status);
+                fw_load_abort(fw_priv);
+                break;
 	default:
 		printk(KERN_ERR "%s: unexpected value (%d)\n", __FUNCTION__,
 		       loading);
@@ -389,8 +403,8 @@ out:
  *	firmware image for this or any other device.
  **/
 int
-request_firmware(const struct firmware **firmware_p, const char *name,
-		 struct device *device)
+_request_firmware(const struct firmware **firmware_p, const char *name,
+		 struct device *device, unsigned long *fw_status)
 {
 	struct class_device *class_dev;
 	struct firmware_priv *fw_priv;
@@ -422,6 +436,14 @@ request_firmware(const struct firmware *
 
 	kobject_hotplug(&class_dev->kobj, KOBJ_ADD);
 	wait_for_completion(&fw_priv->completion);
+	
+	if (test_bit(FW_STATUS_PERSISTENT, &fw_priv->status) ||
+		test_bit(FW_STATUS_PERSISTENT_ABORT, &fw_priv->status)) {
+		*fw_status = fw_priv->status;
+                clear_bit(FW_STATUS_PERSISTENT, &fw_priv->status);
+                clear_bit(FW_STATUS_PERSISTENT_ABORT, &fw_priv->status);
+        }
+
 	set_bit(FW_STATUS_DONE, &fw_priv->status);
 
 	del_timer_sync(&fw_priv->timeout);
@@ -443,6 +465,25 @@ error_kfree_fw:
 out:
 	return retval;
 }
+/**
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
+	unsigned long status;
+	return _request_firmware(firmware_p, name,device,&status);
+}
 
 /**
  * release_firmware: - release the resource associated with a firmware image
@@ -481,6 +522,7 @@ struct firmware_work {
 	struct device *device;
 	void *context;
 	void (*cont)(const struct firmware *fw, void *context);
+	unsigned long status;
 };
 
 static int
@@ -493,9 +535,14 @@ request_firmware_work_func(void *arg)
 		return 0;
 	}
 	daemonize("%s/%s", "firmware", fw_work->name);
-	request_firmware(&fw, fw_work->name, fw_work->device);
-	fw_work->cont(fw, fw_work->context);
-	release_firmware(fw);
+	fw_work->status = FW_STATUS_LOADING;	
+	
+	do {
+		_request_firmware(&fw, fw_work->name, fw_work->device, &fw_work->status);
+		fw_work->cont(fw, fw_work->context);
+		release_firmware(fw);
+	} while (test_bit(FW_STATUS_PERSISTENT, &fw_work->status));
+
 	module_put(fw_work->module);
 	kfree(fw_work);
 	return 0;
