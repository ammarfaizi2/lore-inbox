Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162377AbWLAXcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162377AbWLAXcI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162269AbWLAXXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:23:41 -0500
Received: from ns1.suse.de ([195.135.220.2]:30605 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1162243AbWLAXXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:23:24 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 21/36] Driver core: convert firmware code to use struct device
Date: Fri,  1 Dec 2006 15:21:51 -0800
Message-Id: <11650153922117-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650153891878-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com> <11650153891878-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Converts from using struct "class_device" to "struct device" making
everything show up properly in /sys/devices/ with symlinks from the
/sys/class directory.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/firmware_class.c |  119 +++++++++++++++++++---------------------
 1 files changed, 57 insertions(+), 62 deletions(-)

diff --git a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
index 1461569..4bad287 100644
--- a/drivers/base/firmware_class.c
+++ b/drivers/base/firmware_class.c
@@ -21,6 +21,8 @@
 #include <linux/firmware.h>
 #include "base.h"
 
+#define to_dev(obj) container_of(obj, struct device, kobj)
+
 MODULE_AUTHOR("Manuel Estrada Sainz <ranty@debian.org>");
 MODULE_DESCRIPTION("Multi purpose firmware loading support");
 MODULE_LICENSE("GPL");
@@ -86,12 +88,12 @@ firmware_timeout_store(struct class *cla
 
 static CLASS_ATTR(timeout, 0644, firmware_timeout_show, firmware_timeout_store);
 
-static void  fw_class_dev_release(struct class_device *class_dev);
+static void fw_dev_release(struct device *dev);
 
-static int firmware_class_uevent(struct class_device *class_dev, char **envp,
-				 int num_envp, char *buffer, int buffer_size)
+static int firmware_uevent(struct device *dev, char **envp, int num_envp,
+			   char *buffer, int buffer_size)
 {
-	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	struct firmware_priv *fw_priv = dev_get_drvdata(dev);
 	int i = 0, len = 0;
 
 	if (!test_bit(FW_STATUS_READY, &fw_priv->status))
@@ -110,21 +112,21 @@ static int firmware_class_uevent(struct
 
 static struct class firmware_class = {
 	.name		= "firmware",
-	.uevent		= firmware_class_uevent,
-	.release	= fw_class_dev_release,
+	.dev_uevent	= firmware_uevent,
+	.dev_release	= fw_dev_release,
 };
 
-static ssize_t
-firmware_loading_show(struct class_device *class_dev, char *buf)
+static ssize_t firmware_loading_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
 {
-	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	struct firmware_priv *fw_priv = dev_get_drvdata(dev);
 	int loading = test_bit(FW_STATUS_LOADING, &fw_priv->status);
 	return sprintf(buf, "%d\n", loading);
 }
 
 /**
  * firmware_loading_store - set value in the 'loading' control file
- * @class_dev: class_device pointer
+ * @dev: device pointer
  * @buf: buffer to scan for loading control value
  * @count: number of bytes in @buf
  *
@@ -134,11 +136,11 @@ firmware_loading_show(struct class_devic
  *	 0: Conclude the load and hand the data to the driver code.
  *	-1: Conclude the load with an error and discard any written data.
  **/
-static ssize_t
-firmware_loading_store(struct class_device *class_dev,
-		       const char *buf, size_t count)
+static ssize_t firmware_loading_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
 {
-	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	struct firmware_priv *fw_priv = dev_get_drvdata(dev);
 	int loading = simple_strtol(buf, NULL, 10);
 
 	switch (loading) {
@@ -174,15 +176,14 @@ firmware_loading_store(struct class_devi
 	return count;
 }
 
-static CLASS_DEVICE_ATTR(loading, 0644,
-			firmware_loading_show, firmware_loading_store);
+static DEVICE_ATTR(loading, 0644, firmware_loading_show, firmware_loading_store);
 
 static ssize_t
 firmware_data_read(struct kobject *kobj,
 		   char *buffer, loff_t offset, size_t count)
 {
-	struct class_device *class_dev = to_class_dev(kobj);
-	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	struct device *dev = to_dev(kobj);
+	struct firmware_priv *fw_priv = dev_get_drvdata(dev);
 	struct firmware *fw;
 	ssize_t ret_count = count;
 
@@ -234,7 +235,7 @@ fw_realloc_buffer(struct firmware_priv *
 
 /**
  * firmware_data_write - write method for firmware
- * @kobj: kobject for the class_device
+ * @kobj: kobject for the device
  * @buffer: buffer being written
  * @offset: buffer offset for write in total data store area
  * @count: buffer size
@@ -246,8 +247,8 @@ static ssize_t
 firmware_data_write(struct kobject *kobj,
 		    char *buffer, loff_t offset, size_t count)
 {
-	struct class_device *class_dev = to_class_dev(kobj);
-	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	struct device *dev = to_dev(kobj);
+	struct firmware_priv *fw_priv = dev_get_drvdata(dev);
 	struct firmware *fw;
 	ssize_t retval;
 
@@ -280,13 +281,12 @@ static struct bin_attribute firmware_att
 	.write = firmware_data_write,
 };
 
-static void
-fw_class_dev_release(struct class_device *class_dev)
+static void fw_dev_release(struct device *dev)
 {
-	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	struct firmware_priv *fw_priv = dev_get_drvdata(dev);
 
 	kfree(fw_priv);
-	kfree(class_dev);
+	kfree(dev);
 
 	module_put(THIS_MODULE);
 }
@@ -298,26 +298,23 @@ firmware_class_timeout(u_long data)
 	fw_load_abort(fw_priv);
 }
 
-static inline void
-fw_setup_class_device_id(struct class_device *class_dev, struct device *dev)
+static inline void fw_setup_device_id(struct device *f_dev, struct device *dev)
 {
 	/* XXX warning we should watch out for name collisions */
-	strlcpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
+	strlcpy(f_dev->bus_id, dev->bus_id, BUS_ID_SIZE);
 }
 
-static int
-fw_register_class_device(struct class_device **class_dev_p,
-			 const char *fw_name, struct device *device)
+static int fw_register_device(struct device **dev_p, const char *fw_name,
+			      struct device *device)
 {
 	int retval;
 	struct firmware_priv *fw_priv = kzalloc(sizeof(*fw_priv),
 						GFP_KERNEL);
-	struct class_device *class_dev = kzalloc(sizeof(*class_dev),
-						 GFP_KERNEL);
+	struct device *f_dev = kzalloc(sizeof(*f_dev), GFP_KERNEL);
 
-	*class_dev_p = NULL;
+	*dev_p = NULL;
 
-	if (!fw_priv || !class_dev) {
+	if (!fw_priv || !f_dev) {
 		printk(KERN_ERR "%s: kmalloc failed\n", __FUNCTION__);
 		retval = -ENOMEM;
 		goto error_kfree;
@@ -331,55 +328,54 @@ fw_register_class_device(struct class_de
 	fw_priv->timeout.data = (u_long) fw_priv;
 	init_timer(&fw_priv->timeout);
 
-	fw_setup_class_device_id(class_dev, device);
-	class_dev->dev = device;
-	class_dev->class = &firmware_class;
-	class_set_devdata(class_dev, fw_priv);
-	retval = class_device_register(class_dev);
+	fw_setup_device_id(f_dev, device);
+	f_dev->parent = device;
+	f_dev->class = &firmware_class;
+	dev_set_drvdata(f_dev, fw_priv);
+	retval = device_register(f_dev);
 	if (retval) {
-		printk(KERN_ERR "%s: class_device_register failed\n",
+		printk(KERN_ERR "%s: device_register failed\n",
 		       __FUNCTION__);
 		goto error_kfree;
 	}
-	*class_dev_p = class_dev;
+	*dev_p = f_dev;
 	return 0;
 
 error_kfree:
 	kfree(fw_priv);
-	kfree(class_dev);
+	kfree(f_dev);
 	return retval;
 }
 
-static int
-fw_setup_class_device(struct firmware *fw, struct class_device **class_dev_p,
-		      const char *fw_name, struct device *device, int uevent)
+static int fw_setup_device(struct firmware *fw, struct device **dev_p,
+			   const char *fw_name, struct device *device,
+			   int uevent)
 {
-	struct class_device *class_dev;
+	struct device *f_dev;
 	struct firmware_priv *fw_priv;
 	int retval;
 
-	*class_dev_p = NULL;
-	retval = fw_register_class_device(&class_dev, fw_name, device);
+	*dev_p = NULL;
+	retval = fw_register_device(&f_dev, fw_name, device);
 	if (retval)
 		goto out;
 
 	/* Need to pin this module until class device is destroyed */
 	__module_get(THIS_MODULE);
 
-	fw_priv = class_get_devdata(class_dev);
+	fw_priv = dev_get_drvdata(f_dev);
 
 	fw_priv->fw = fw;
-	retval = sysfs_create_bin_file(&class_dev->kobj, &fw_priv->attr_data);
+	retval = sysfs_create_bin_file(&f_dev->kobj, &fw_priv->attr_data);
 	if (retval) {
 		printk(KERN_ERR "%s: sysfs_create_bin_file failed\n",
 		       __FUNCTION__);
 		goto error_unreg;
 	}
 
-	retval = class_device_create_file(class_dev,
-					  &class_device_attr_loading);
+	retval = device_create_file(f_dev, &dev_attr_loading);
 	if (retval) {
-		printk(KERN_ERR "%s: class_device_create_file failed\n",
+		printk(KERN_ERR "%s: device_create_file failed\n",
 		       __FUNCTION__);
 		goto error_unreg;
 	}
@@ -388,11 +384,11 @@ fw_setup_class_device(struct firmware *f
                 set_bit(FW_STATUS_READY, &fw_priv->status);
         else
                 set_bit(FW_STATUS_READY_NOHOTPLUG, &fw_priv->status);
-	*class_dev_p = class_dev;
+	*dev_p = f_dev;
 	goto out;
 
 error_unreg:
-	class_device_unregister(class_dev);
+	device_unregister(f_dev);
 out:
 	return retval;
 }
@@ -401,7 +397,7 @@ static int
 _request_firmware(const struct firmware **firmware_p, const char *name,
 		 struct device *device, int uevent)
 {
-	struct class_device *class_dev;
+	struct device *f_dev;
 	struct firmware_priv *fw_priv;
 	struct firmware *firmware;
 	int retval;
@@ -417,12 +413,11 @@ _request_firmware(const struct firmware
 		goto out;
 	}
 
-	retval = fw_setup_class_device(firmware, &class_dev, name, device,
-				       uevent);
+	retval = fw_setup_device(firmware, &f_dev, name, device, uevent);
 	if (retval)
 		goto error_kfree_fw;
 
-	fw_priv = class_get_devdata(class_dev);
+	fw_priv = dev_get_drvdata(f_dev);
 
 	if (uevent) {
 		if (loading_timeout > 0) {
@@ -430,7 +425,7 @@ _request_firmware(const struct firmware
 			add_timer(&fw_priv->timeout);
 		}
 
-		kobject_uevent(&class_dev->kobj, KOBJ_ADD);
+		kobject_uevent(&f_dev->kobj, KOBJ_ADD);
 		wait_for_completion(&fw_priv->completion);
 		set_bit(FW_STATUS_DONE, &fw_priv->status);
 		del_timer_sync(&fw_priv->timeout);
@@ -445,7 +440,7 @@ _request_firmware(const struct firmware
 	}
 	fw_priv->fw = NULL;
 	mutex_unlock(&fw_lock);
-	class_device_unregister(class_dev);
+	device_unregister(f_dev);
 	goto out;
 
 error_kfree_fw:
-- 
1.4.4.1

