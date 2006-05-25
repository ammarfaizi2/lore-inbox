Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964843AbWEYDwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbWEYDwW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 23:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWEYDwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 23:52:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:9095 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964843AbWEYDwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 23:52:21 -0400
X-IronPort-AV: i="4.05,170,1146466800"; 
   d="scan'208"; a="41049685:sNHT16649199"
Subject: [PATCH 1/2] request_firmware without a device
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Greg <greg@kroah.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 25 May 2006 11:50:45 +0800
Message-Id: <1148529045.32046.102.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch allows calling request_firmware without a 'struct device'.
It appears we just need a name here from 'struct device'. I changed it
to use a kobject as Patrick suggested.
Next patch will use the new API to request firmware (microcode) for a CPU.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc4-root/drivers/base/firmware_class.c |   32 ++++++++++++--------
 linux-2.6.17-rc4-root/include/linux/firmware.h      |    2 +
 2 files changed, 22 insertions(+), 12 deletions(-)

diff -puN drivers/base/firmware_class.c~request_firmware_nodevice drivers/base/firmware_class.c
--- linux-2.6.17-rc4/drivers/base/firmware_class.c~request_firmware_nodevice	2006-05-15 14:25:09.000000000 +0800
+++ linux-2.6.17-rc4-root/drivers/base/firmware_class.c	2006-05-22 07:30:51.000000000 +0800
@@ -301,15 +301,15 @@ firmware_class_timeout(u_long data)
 }
 
 static inline void
-fw_setup_class_device_id(struct class_device *class_dev, struct device *dev)
+fw_setup_class_device_id(struct class_device *class_dev, struct kobject *kobj)
 {
 	/* XXX warning we should watch out for name collisions */
-	strlcpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
+	strlcpy(class_dev->class_id, kobj->k_name, BUS_ID_SIZE);
 }
 
 static int
 fw_register_class_device(struct class_device **class_dev_p,
-			 const char *fw_name, struct device *device)
+			 const char *fw_name, struct kobject *kobj)
 {
 	int retval;
 	struct firmware_priv *fw_priv = kzalloc(sizeof(*fw_priv),
@@ -333,8 +333,7 @@ fw_register_class_device(struct class_de
 	fw_priv->timeout.data = (u_long) fw_priv;
 	init_timer(&fw_priv->timeout);
 
-	fw_setup_class_device_id(class_dev, device);
-	class_dev->dev = device;
+	fw_setup_class_device_id(class_dev, kobj);
 	class_dev->class = &firmware_class;
 	class_set_devdata(class_dev, fw_priv);
 	retval = class_device_register(class_dev);
@@ -354,14 +353,14 @@ error_kfree:
 
 static int
 fw_setup_class_device(struct firmware *fw, struct class_device **class_dev_p,
-		      const char *fw_name, struct device *device, int uevent)
+		      const char *fw_name, struct kobject *kobj, int uevent)
 {
 	struct class_device *class_dev;
 	struct firmware_priv *fw_priv;
 	int retval;
 
 	*class_dev_p = NULL;
-	retval = fw_register_class_device(&class_dev, fw_name, device);
+	retval = fw_register_class_device(&class_dev, fw_name, kobj);
 	if (retval)
 		goto out;
 
@@ -401,7 +400,7 @@ out:
 
 static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
-		 struct device *device, int uevent)
+		 struct kobject *kobj, int uevent)
 {
 	struct class_device *class_dev;
 	struct firmware_priv *fw_priv;
@@ -419,7 +418,7 @@ _request_firmware(const struct firmware 
 		goto out;
 	}
 
-	retval = fw_setup_class_device(firmware, &class_dev, name, device,
+	retval = fw_setup_class_device(firmware, &class_dev, name, kobj,
 				       uevent);
 	if (retval)
 		goto error_kfree_fw;
@@ -477,7 +476,15 @@ request_firmware(const struct firmware *
                  struct device *device)
 {
         int uevent = 1;
-        return _request_firmware(firmware_p, name, device, uevent);
+        return _request_firmware(firmware_p, name, &device->kobj, uevent);
+}
+
+int
+request_firmware_kobj(const struct firmware **firmware_p, const char *name,
+                      struct kobject *kobj)
+{
+        int uevent = 1;
+        return _request_firmware(firmware_p, name, kobj, uevent);
 }
 
 /**
@@ -534,7 +541,7 @@ request_firmware_work_func(void *arg)
 		return 0;
 	}
 	daemonize("%s/%s", "firmware", fw_work->name);
-	ret = _request_firmware(&fw, fw_work->name, fw_work->device,
+	ret = _request_firmware(&fw, fw_work->name, &fw_work->device->kobj,
 		fw_work->uevent);
 	if (ret < 0)
 		fw_work->cont(NULL, fw_work->context);
@@ -624,10 +631,11 @@ firmware_class_exit(void)
 	class_unregister(&firmware_class);
 }
 
-module_init(firmware_class_init);
+fs_initcall(firmware_class_init);
 module_exit(firmware_class_exit);
 
 EXPORT_SYMBOL(release_firmware);
 EXPORT_SYMBOL(request_firmware);
+EXPORT_SYMBOL(request_firmware_kobj);
 EXPORT_SYMBOL(request_firmware_nowait);
 EXPORT_SYMBOL(register_firmware);
diff -puN include/linux/firmware.h~request_firmware_nodevice include/linux/firmware.h
--- linux-2.6.17-rc4/include/linux/firmware.h~request_firmware_nodevice	2006-05-15 14:26:34.000000000 +0800
+++ linux-2.6.17-rc4-root/include/linux/firmware.h	2006-05-22 07:24:08.000000000 +0800
@@ -13,6 +13,8 @@ struct firmware {
 struct device;
 int request_firmware(const struct firmware **fw, const char *name,
 		     struct device *device);
+int request_firmware_kobj(const struct firmware **fw, const char *name,
+			  struct kobject *kobj);
 int request_firmware_nowait(
 	struct module *module, int uevent,
 	const char *name, struct device *device, void *context,
_
