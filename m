Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTLUGia (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 01:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTLUGia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 01:38:30 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:47746 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262198AbTLUGhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 01:37:53 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6 PATCH/RFC] Firmware loader - fix races and resource dealloocation problems
Date: Sun, 21 Dec 2003 01:37:39 -0500
User-Agent: KMail/1.5.4
Cc: Manuel Estrada Sainz <ranty@debian.org>, Patrick Mochel <mochel@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312210137.41343.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that implementation of the firmware loader is racy as it relies
on kobject hotplug handler. Unfortunately that handler runs too early,
before firmware class attributes controlling the loading process, are
created. This causes firmware loading fail at least half of the times on
my laptop.

Another problem that I see is that the present implementation tries to free
some of the allocated resources manually instead of relying on driver model.
Particularly damaging is freeing fw_priv in request_firmware. Although the
code calls fw_remove_class_device (which in turns calls 
class_device_unregister) the freeing of class device and all its attributes
can be delayed as the attribute files may still be held open by the
userspace handler or any other program. Subsequent access to these files
could cause trouble.

Also, there is no protection from overwriting firmware image once it has
been committed.

I tried to correct all 3 problems in the patch below. It creates a custom
hotplug handler that is called from request_hardware. I tried to mimic the
hotplug handler from kobject - it's nice to have DEVPATH pointing to the
right place - so I exported kobject_get_path_length and kobject_fill_path
(former get_kobj_path_length and fill_kobj_patch). I think these 2 should
not be considered "implementation details" and exporting them is OK.
Write access to firmware device class attributes is protected by a semaphore
and the code refuses any updates once firmware loading has been committed or
aborted. Firmware 

Dmitry

===================================================================


ChangeSet@1.1521, 2003-12-21 01:00:41-05:00, dtor_core@ameritech.net
  - Provide handcrafted hotplug method as generic one runs too early.
  - Do not allow changes to firmware image once it has been committed.
  - Correctly free resources.


 drivers/base/firmware_class.c |  530 +++++++++++++++++++++++++-----------------
 include/linux/kobject.h       |    2 
 lib/kobject.c                 |   29 +-
 3 files changed, 347 insertions(+), 214 deletions(-)


===================================================================



diff -Nru a/drivers/base/firmware_class.c b/drivers/base/firmware_class.c
--- a/drivers/base/firmware_class.c	Sun Dec 21 01:03:27 2003
+++ b/drivers/base/firmware_class.c	Sun Dec 21 01:03:27 2003
@@ -7,12 +7,14 @@
  *
  */
 
+#include <linux/kobject.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/timer.h>
 #include <linux/vmalloc.h>
 #include <asm/hardirq.h>
+#include <asm/semaphore.h>
 
 #include <linux/firmware.h>
 #include "base.h"
@@ -21,124 +23,109 @@
 MODULE_DESCRIPTION("Multi purpose firmware loading support");
 MODULE_LICENSE("GPL");
 
+#define FW_STATE_NEW		0
+#define FW_STATE_LOADING	1
+#define FW_STATE_LOADED		2
+#define FW_STATE_ABORTED	3
+
 static int loading_timeout = 10;	/* In seconds */
 
 struct firmware_priv {
-	char fw_id[FIRMWARE_NAME_MAX];
+	struct semaphore semaphore;
 	struct completion completion;
 	struct bin_attribute attr_data;
 	struct firmware *fw;
+	int state;
 	int loading;
-	int abort;
 	int alloc_size;
 	struct timer_list timeout;
 };
 
-static ssize_t
-firmware_timeout_show(struct class *class, char *buf)
-{
-	return sprintf(buf, "%d\n", loading_timeout);
-}
-
 /**
- * firmware_timeout_store:
- * Description:
- *	Sets the number of seconds to wait for the firmware.  Once
- *	this expires an error will be return to the driver and no
- *	firmware will be provided.
+ * firmware loading attribute
  *
- *	Note: zero means 'wait for ever'
- *  
+ *	Controls process of loading firmware into kernel.
+ *	The relevant values are: 
+ *
+ *	 1: Start a load, discarding any previous partial load.
+ *	 0: Conclude the load and handle the data to the driver code.
+ *	-1: Conclude the load with an error and discard any written data.
+ *
+ *	Note: If no firmware has been loaded 0 is equivalent to -1
  **/
-static ssize_t
-firmware_timeout_store(struct class *class, const char *buf, size_t count)
+static void firmware_start_loading(struct firmware_priv *fw_priv)
 {
-	loading_timeout = simple_strtol(buf, NULL, 10);
-	return count;
+	fw_priv->state = FW_STATE_LOADING;
+	vfree(fw_priv->fw->data);
+	fw_priv->fw->data = NULL;
+	fw_priv->fw->size = 0;
+	fw_priv->alloc_size = 0;
 }
 
-static CLASS_ATTR(timeout, 0644, firmware_timeout_show, firmware_timeout_store);
-
-static void  fw_class_dev_release(struct class_device *class_dev);
-int firmware_class_hotplug(struct class_device *dev, char **envp,
-			   int num_envp, char *buffer, int buffer_size);
-
-static struct class firmware_class = {
-	.name		= "firmware",
-	.hotplug	= firmware_class_hotplug,
-	.release	= fw_class_dev_release,
-};
-
-int
-firmware_class_hotplug(struct class_device *class_dev, char **envp,
-		       int num_envp, char *buffer, int buffer_size)
+static void firmware_abort_loading(struct firmware_priv *fw_priv)
 {
-	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
-	int i = 0;
-	char *scratch = buffer;
-
-	if (buffer_size < (FIRMWARE_NAME_MAX + 10))
-		return -ENOMEM;
-	if (num_envp < 1)
-		return -ENOMEM;
+	fw_priv->state = FW_STATE_ABORTED;
+	wmb();
+	complete(&fw_priv->completion);
+}
 
-	envp[i++] = scratch;
-	scratch += sprintf(scratch, "FIRMWARE=%s", fw_priv->fw_id) + 1;
-	return 0;
+static void firmware_finish_loading(struct firmware_priv *fw_priv)
+{
+	fw_priv->state = FW_STATE_LOADED;
+	wmb();
+	complete(&fw_priv->completion);
 }
 
-static ssize_t
-firmware_loading_show(struct class_device *class_dev, char *buf)
+static ssize_t firmware_loading_show(struct class_device *class_dev, char *buf)
 {
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
 	return sprintf(buf, "%d\n", fw_priv->loading);
 }
 
-/**
- * firmware_loading_store: - loading control file
- * Description:
- *	The relevant values are: 
- *
- *	 1: Start a load, discarding any previous partial load.
- *	 0: Conclude the load and handle the data to the driver code.
- *	-1: Conclude the load with an error and discard any written data.
- **/
-static ssize_t
-firmware_loading_store(struct class_device *class_dev,
-		       const char *buf, size_t count)
+static ssize_t firmware_loading_store(struct class_device *class_dev,
+				      const char *buf, size_t count)
 {
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
-	int prev_loading = fw_priv->loading;
+	int retval = count;
 
-	fw_priv->loading = simple_strtol(buf, NULL, 10);
+	down(&fw_priv->semaphore);
 
-	switch (fw_priv->loading) {
-	case -1:
-		fw_priv->abort = 1;
-		wmb();
-		complete(&fw_priv->completion);
-		break;
-	case 1:
-		kfree(fw_priv->fw->data);
-		fw_priv->fw->data = NULL;
-		fw_priv->fw->size = 0;
-		fw_priv->alloc_size = 0;
-		break;
-	case 0:
-		if (prev_loading == 1)
-			complete(&fw_priv->completion);
-		break;
-	}
+	if (fw_priv->state <= FW_STATE_LOADING) {
+		fw_priv->loading = simple_strtol(buf, NULL, 10);
 
-	return count;
+		switch (fw_priv->loading) {
+		case -1:
+			firmware_abort_loading(fw_priv);
+			break;
+		case 1:
+			firmware_start_loading(fw_priv);
+			break;
+		case 0:
+			if (fw_priv->state == FW_STATE_LOADING && fw_priv->fw->size)
+				firmware_finish_loading(fw_priv); 
+			else
+				firmware_abort_loading(fw_priv);
+			break;
+		}
+	} else
+		retval = -EACCES;
+
+	up(&fw_priv->semaphore);
+
+	return retval;
 }
 
 static CLASS_DEVICE_ATTR(loading, 0644,
-			firmware_loading_show, firmware_loading_store);
+			 firmware_loading_show, firmware_loading_store);
 
-static ssize_t
-firmware_data_read(struct kobject *kobj,
-		   char *buffer, loff_t offset, size_t count)
+/**
+ * firmware data attribute
+ *
+ *	Data written to the 'data' attribute will be later handled to
+ *	the driver as a firmware image.
+ **/
+static ssize_t firmware_data_read(struct kobject *kobj,
+		   		  char *buffer, loff_t offset, size_t count)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
@@ -152,8 +139,8 @@
 	memcpy(buffer, fw->data + offset, count);
 	return count;
 }
-static int
-fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
+
+static int fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
 {
 	u8 *new_data;
 
@@ -164,7 +151,7 @@
 	if (!new_data) {
 		printk(KERN_ERR "%s: unable to alloc buffer\n", __FUNCTION__);
 		/* Make sure that we don't keep incomplete data */
-		fw_priv->abort = 1;
+		fw_priv->state = FW_STATE_ABORTED;
 		return -ENOMEM;
 	}
 	fw_priv->alloc_size += PAGE_SIZE;
@@ -177,33 +164,33 @@
 	return 0;
 }
 
-/**
- * firmware_data_write:
- *
- * Description:
- *
- *	Data written to the 'data' attribute will be later handled to
- *	the driver as a firmware image.
- **/
-static ssize_t
-firmware_data_write(struct kobject *kobj,
-		    char *buffer, loff_t offset, size_t count)
+static ssize_t firmware_data_write(struct kobject *kobj,
+				   char *buffer, loff_t offset, size_t count)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
 	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
 	struct firmware *fw = fw_priv->fw;
 	int retval;
 
-	retval = fw_realloc_buffer(fw_priv, offset + count);
-	if (retval)
-		return retval;
+	down(&fw_priv->semaphore);
 
-	memcpy(fw->data + offset, buffer, count);
+	if (fw_priv->state != FW_STATE_LOADING) {
+		retval = -EACCES;
+	} else {
+		retval = fw_realloc_buffer(fw_priv, offset + count);
 
-	fw->size = max_t(size_t, offset + count, fw->size);
+		if (!retval) {
+			memcpy(fw->data + offset, buffer, count);
+			fw->size = max_t(size_t, offset + count, fw->size);
+			retval = count;
+		}
+	}
 
-	return count;
+	up(&fw_priv->semaphore);
+
+	return retval;
 }
+
 static struct bin_attribute firmware_attr_data_tmpl = {
 	.attr = {.name = "data", .mode = 0644},
 	.size = 0,
@@ -211,73 +198,228 @@
 	.write = firmware_data_write,
 };
 
-static void
-fw_class_dev_release(struct class_device *class_dev)
+/**
+ * firmware timeout attribute
+ *
+ *	Applies to all instances of firmware loaders (it is a class
+ *	attribute.
+ *
+ *	Sets the number of seconds to wait for the firmware.  Once
+ *	this expires an error will be return to the driver and no
+ *	firmware will be provided.
+ *
+ *	Note: zero means 'wait for ever'
+ *  
+ **/
+static void firmware_class_timeout(u_long data)
 {
-	kfree(class_dev);
+	struct firmware_priv *fw_priv = (struct firmware_priv *) data;
+	
+	down(&fw_priv->semaphore);
+
+	firmware_abort_loading(fw_priv);
+
+	up(&fw_priv->semaphore);
 }
 
-static void
-firmware_class_timeout(u_long data)
+static ssize_t firmware_timeout_show(struct class *class, char *buf)
 {
-	struct firmware_priv *fw_priv = (struct firmware_priv *) data;
-	fw_priv->abort = 1;
-	wmb();
-	complete(&fw_priv->completion);
+	return sprintf(buf, "%d\n", loading_timeout);
 }
 
-static inline void
-fw_setup_class_device_id(struct class_device *class_dev, struct device *dev)
+static ssize_t firmware_timeout_store(struct class *class, 
+				      const char *buf, size_t count)
 {
-	/* XXX warning we should watch out for name collisions */
-	strncpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
-	class_dev->class_id[BUS_ID_SIZE - 1] = '\0';
+	loading_timeout = simple_strtol(buf, NULL, 10);
+	return count;
 }
-static int
-fw_setup_class_device(struct class_device **class_dev_p,
-		      const char *fw_name, struct device *device)
+
+static CLASS_ATTR(timeout, 0644, firmware_timeout_show, firmware_timeout_store);
+
+/**
+ * fw_class_hotplug
+ *
+ *	Dummy hotplug handler that inhibits driver model core generating
+ *	hotplug events when firmware class device is created or destroyed.
+ *	The code hotplug events can not be used because when firmware class
+ *	device is registered its attributes are not awailable yet and they
+ *	are needed by userspace to communicate with the kernel.
+ **/
+static int fw_class_hotplug(struct class_device *class_dev, char **envp,
+			    int num_envp, char *buffer, int buffer_size)
 {
-	int retval = 0;
-	struct firmware_priv *fw_priv = kmalloc(sizeof (struct firmware_priv),
-						GFP_KERNEL);
-	struct class_device *class_dev = kmalloc(sizeof (struct class_device),
-						 GFP_KERNEL);
+	return -ENODEV;
+}
+
+/**
+ * firmware_hotplug
+ *
+ *	Generates handcrafted hotplug event mimicing events from the
+ *	driver model core. It is called after the class device is
+ *	registered. 
+ **/
+static int firmware_hotplug(struct class_device *class_dev, const char *fw_name)
+{
+	char *argv[3], *envp[5];
+	char *buf, *scratch, *path;
+	int path_len;
+	int i = 0;
+	int retval;
+
+	if (!hotplug_path[0])
+		return -ENODEV;
+	
+	if (!(buf = scratch = kmalloc(1024, GFP_KERNEL))) {
+		printk(KERN_ERR "%s: not enough memory allocating environment\n",
+		       __FUNCTION__);
+		return -ENOMEM;
+	}
 
-	if (!fw_priv || !class_dev) {
+	argv[0] = hotplug_path;
+	argv[1] = "firmware";
+	argv[2] = 0;
+
+	envp[i++] = "HOME=/";
+	envp[i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+	envp[i++] = "ACTION=add";
+
+	path_len = kobject_get_path_length(&class_dev->kobj);
+        path = kmalloc(path_len, GFP_KERNEL);
+        if (!path) {
 		retval = -ENOMEM;
-		goto error_kfree;
+                goto out;
 	}
-	memset(fw_priv, 0, sizeof (*fw_priv));
-	memset(class_dev, 0, sizeof (*class_dev));
+        kobject_fill_path(&class_dev->kobj, path, path_len);
 
-	init_completion(&fw_priv->completion);
-	memcpy(&fw_priv->attr_data, &firmware_attr_data_tmpl,
-	       sizeof (firmware_attr_data_tmpl));
+        envp [i++] = scratch;
+        scratch += sprintf(scratch, "DEVPATH=%s", path) + 1;
 
-	strncpy(&fw_priv->fw_id[0], fw_name, FIRMWARE_NAME_MAX);
-	fw_priv->fw_id[FIRMWARE_NAME_MAX - 1] = '\0';
+	envp[i++] = scratch;
+	scratch += sprintf(scratch, "FIRMWARE=%s", fw_name) + 1;
 
-	fw_setup_class_device_id(class_dev, device);
-	class_dev->dev = device;
+	envp[i++] = 0;
+
+	retval = call_usermodehelper(argv[0], argv, envp, 0);
+
+out:
+	kfree(buf);
+
+	return retval;
+}
+
+static void fw_class_dev_release(struct class_device *class_dev)
+{
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+
+	if (fw_priv->state != FW_STATE_LOADED)
+		release_firmware(fw_priv->fw);
+
+	kfree(fw_priv);
+	kfree(class_dev);
+}
 
+static struct class firmware_class = {
+	.name		= "firmware",
+	.hotplug	= fw_class_hotplug,
+	.release	= fw_class_dev_release,
+};
+
+static void fw_setup_class_device_id(struct class_device *class_dev,
+				     struct device *dev)
+{
+	/* XXX warning we should watch out for name collisions */
+	strlcpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
+}
+
+static struct class_device *fw_alloc_class_device(struct device *device)
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
+		retval = -ENOMEM;
+		goto err_out; 
+	}
+
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
+	init_MUTEX(&fw_priv->semaphore);
+	init_completion(&fw_priv->completion);
+	fw_priv->attr_data = firmware_attr_data_tmpl;
+	fw_priv->fw = firmware;
+	init_timer(&fw_priv->timeout);
 	fw_priv->timeout.function = firmware_class_timeout;
 	fw_priv->timeout.data = (u_long) fw_priv;
-	init_timer(&fw_priv->timeout);
 
+	class_dev = kmalloc(sizeof(struct class_device), GFP_KERNEL);
+	if (!class_dev) {
+		printk(KERN_ERR "%s: kmalloc(struct class_device) failed\n",
+		       __FUNCTION__);
+		goto err_out_free_fw_priv;
+	}
+
+	memset(class_dev, 0, sizeof(*class_dev));
+	fw_setup_class_device_id(class_dev, device);
+	class_dev->dev = device;
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
+static int fw_setup_class_device(struct class_device **class_dev_p,
+		      		 struct device *device)
+{
+	struct class_device *class_dev = fw_alloc_class_device(device);
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
-	if (retval) {
+	if (retval) { 
 		printk(KERN_ERR "%s: sysfs_create_bin_file failed\n",
 		       __FUNCTION__);
-		goto error_unreg_class_dev;
+		goto err_out_unregister;
 	}
 
 	retval = class_device_create_file(class_dev,
@@ -285,43 +427,18 @@
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
@@ -335,20 +452,21 @@
  *	should be distinctive enough not to be confused with any other
  *	firmware image for this or any other device.
  **/
-int
-request_firmware(const struct firmware **firmware, const char *name,
-		 struct device *device)
+int request_firmware(const struct firmware **firmware,
+		     const char *name, struct device *device)
 {
 	struct class_device *class_dev;
 	struct firmware_priv *fw_priv;
-	int retval;
+	int retval = 0;
 
-	if (!firmware)
-		return -EINVAL;
+	if (!firmware) {
+		retval = -EINVAL;
+		goto out; 
+	}
 
 	*firmware = NULL;
 
-	retval = fw_setup_class_device(&class_dev, name, device);
+	retval = fw_setup_class_device(&class_dev, device);
 	if (retval)
 		goto out;
 
@@ -359,19 +477,20 @@
 		add_timer(&fw_priv->timeout);
 	}
 
-	wait_for_completion(&fw_priv->completion);
+	retval = firmware_hotplug(class_dev, name);
+	if (retval)
+		goto out_device_unregister;
 
+	wait_for_completion(&fw_priv->completion);
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
+out_device_unregister:
+	class_device_unregister(class_dev);	
 out:
 	return retval;
 }
@@ -379,11 +498,11 @@
 /**
  * release_firmware: - release the resource associated with a firmware image
  **/
-void
-release_firmware(const struct firmware *fw)
+void release_firmware(const struct firmware *fw)
 {
 	if (fw) {
-		vfree(fw->data);
+		if (fw->data)
+			vfree(fw->data);
 		kfree(fw);
 	}
 }
@@ -397,8 +516,7 @@
  *	Note: This will not be possible until some kind of persistence
  *	is available.
  **/
-void
-register_firmware(const char *name, const u8 *data, size_t size)
+void register_firmware(const char *name, const u8 *data, size_t size)
 {
 	/* This is meaningless without firmware caching, so until we
 	 * decide if firmware caching is reasonable just leave it as a
@@ -415,8 +533,7 @@
 	void (*cont)(const struct firmware *fw, void *context);
 };
 
-static void
-request_firmware_work_func(void *arg)
+static void request_firmware_work_func(void *arg)
 {
 	struct firmware_work *fw_work = arg;
 	const struct firmware *fw;
@@ -443,11 +560,9 @@
  *	@fw may be %NULL if firmware request fails.
  *
  **/
-int
-request_firmware_nowait(
-	struct module *module,
-	const char *name, struct device *device, void *context,
-	void (*cont)(const struct firmware *fw, void *context))
+int request_firmware_nowait(struct module *module,
+			    const char *name, struct device *device, void *context,
+			    void (*cont)(const struct firmware *fw, void *context))
 {
 	struct firmware_work *fw_work = kmalloc(sizeof (struct firmware_work),
 						GFP_ATOMIC);
@@ -471,27 +586,26 @@
 	return 0;
 }
 
-static int __init
-firmware_class_init(void)
+static int __init firmware_class_init(void)
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
 
 }
-static void __exit
-firmware_class_exit(void)
+static void __exit firmware_class_exit(void)
 {
-	class_remove_file(&firmware_class, &class_attr_timeout);
 	class_unregister(&firmware_class);
 }
 
diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	Sun Dec 21 01:03:27 2003
+++ b/include/linux/kobject.h	Sun Dec 21 01:03:27 2003
@@ -56,6 +56,8 @@
 extern struct kobject * kobject_get(struct kobject *);
 extern void kobject_put(struct kobject *);
 
+extern int kobject_get_path_length(struct kobject *);
+extern void kobject_fill_path(struct kobject *, char *, int);
 
 struct kobj_type {
 	void (*release)(struct kobject *);
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Sun Dec 21 01:03:27 2003
+++ b/lib/kobject.c	Sun Dec 21 01:03:27 2003
@@ -64,9 +64,12 @@
 	return container_of(entry,struct kobject,entry);
 }
 
+/**
+ *	kobject_get_path_length - get length of path to the object.
+ *	@kobj:	object in question.
+ */
 
-#ifdef CONFIG_HOTPLUG
-static int get_kobj_path_length(struct kset *kset, struct kobject *kobj)
+int kobject_get_path_length(struct kobject *kobj)
 {
 	int length = 1;
 	struct kobject * parent = kobj;
@@ -82,10 +85,21 @@
 	return length;
 }
 
-static void fill_kobj_path(struct kset *kset, struct kobject *kobj, char *path, int length)
+EXPORT_SYMBOL(kobject_get_path_length);
+
+/**
+ *	kobject_get_path_length - get length of path to the object.
+ *	@kobj:		object in question.
+ *	@path:		buffer where path should go
+ *	@length:	length of the buffer obtained by calling
+ *			kobject_get_path_length 
+ */
+
+void kobject_fill_path(struct kobject *kobj, char *path, int length)
 {
 	struct kobject * parent;
 
+	memset(path, 0x00, length);
 	--length;
 	for (parent = kobj; parent; parent = parent->parent) {
 		int cur = strlen(kobject_name(parent));
@@ -98,6 +112,10 @@
 	pr_debug("%s: path = '%s'\n",__FUNCTION__,path);
 }
 
+EXPORT_SYMBOL(kobject_fill_path);
+
+#ifdef CONFIG_HOTPLUG
+
 #define BUFFER_SIZE	1024	/* should be enough memory for the env */
 #define NUM_ENVP	32	/* number of env pointers */
 static unsigned long sequence_num;
@@ -163,12 +181,11 @@
 	envp [i++] = scratch;
 	scratch += sprintf(scratch, "SEQNUM=%ld", seq) + 1;
 
-	kobj_path_length = get_kobj_path_length (kset, kobj);
+	kobj_path_length = kobject_get_path_length (kobj);
 	kobj_path = kmalloc (kobj_path_length, GFP_KERNEL);
 	if (!kobj_path)
 		goto exit;
-	memset (kobj_path, 0x00, kobj_path_length);
-	fill_kobj_path (kset, kobj, kobj_path, kobj_path_length);
+	kobject_fill_path (kobj, kobj_path, kobj_path_length);
 
 	envp [i++] = scratch;
 	scratch += sprintf (scratch, "DEVPATH=%s", kobj_path) + 1;
