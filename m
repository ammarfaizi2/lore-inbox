Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTEQWHB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 18:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbTEQWHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 18:07:01 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:34971 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S261861AbTEQWGo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 18:06:44 -0400
Date: Sun, 18 May 2003 00:19:22 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       jt@hpl.hp.com, Pavel Roskin <proski@gnu.org>,
       Oliver Neukum <oliver@neukum.org>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: request_firmware() hotplug interface, third round and a halve
Message-ID: <20030517221921.GA28077@ranty.ddts.net>
Reply-To: ranty@debian.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Hi,

 There is some new stuff:
 -----------------------

 - 'struct device *device' is used instead of 'char *device'. So we now
   have the device symlink :)

 - request_firmware_nowait is implemented, please comment on it.
 
 - It doesn't abuse the stack any more, or at least not that much :)
 
 - There is a timeout, changeable from userspace. Feedback on a
   reasonable default value appreciated.
 
 - Extended 'loading' semantics:
 	echo 1 > loading:
		start a new load, and flush any data from a previous
		partial load.
	echo 0 > loading:
		finish load.
	echo -1 > loading:
		cancel load and give an error to the driver.
		
 - adapted to new sysfs interface.
 
 - it is now a patch against current bk-cvs gateway.
 
 - There is a *working* sample on how to use the firmware class without
   using request_firmware(). It is not clean, but it works, if it is
   found to be interesting it should be further polished.

 Some random notes:
 -----------------

 - request_firmware_cancel is not needed, request_firmware_nowait will
   lock the client module into memory until after triggering the
   callback.
   The only other problem that I can think of is the device getting
   unplugged while waiting for firmware, so the driver callback should
   first make sure that the device is still there.

 - firmware-class.diff adds both samples to the kernel tree, that
   doesn't mean that I want them there, it is just for easier testing.

 Patches:
 -------

 - firmware-class.diff:
 	firmware_class code and the two samples.

 - sysfs-bin-flexible-size.diff:
 	Make dynamically sized files possible.
	And return the right value on successful write.

 - sysfs-bin-lost-dget.diff:
 	I was having trouble when calling request_firmware() from a
	work queue, and after a little investigations it seams that this
	dget got lost along the way. Adding it back fixed the issue.
	Or am I causing a dentry leak now?

PS: If you guys consider this abusive CC:ing, please complain.
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="firmware-class.diff"

diff --exclude=CVS -urN linux-2.5.orig/drivers/base/Makefile linux-2.5.mine/drivers/base/Makefile
--- linux-2.5.orig/drivers/base/Makefile	2003-05-17 20:44:03.000000000 +0200
+++ linux-2.5.mine/drivers/base/Makefile	2003-05-17 23:17:21.000000000 +0200
@@ -3,4 +3,6 @@
 obj-y			:= core.o sys.o interface.o power.o bus.o \
 			   driver.o class.o platform.o \
 			   cpu.o firmware.o init.o
+obj-m			:= firmware_class.o firmware_sample_driver.o \
+			   firmware_sample_firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o  memblk.o
diff --exclude=CVS -urN linux-2.5.orig/drivers/base/firmware_class.c linux-2.5.mine/drivers/base/firmware_class.c
--- linux-2.5.orig/drivers/base/firmware_class.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.mine/drivers/base/firmware_class.c	2003-05-17 22:44:27.000000000 +0200
@@ -0,0 +1,425 @@
+/*
+ * firmware_class.c - Multi purpose firmware loading support
+ *
+ * Copyright (c) 2003 Manuel Estrada Sainz <ranty@debian.org>
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <asm/hardirq.h>
+
+#include "linux/firmware.h"
+
+MODULE_AUTHOR("Manuel Estrada Sainz <ranty@debian.org>");
+MODULE_DESCRIPTION("Multi purpose firmware loading support");
+MODULE_LICENSE("GPL");
+
+static int loading_timeout = 10; /* In seconds */
+
+static inline struct class_device *to_class_dev(struct kobject *obj)
+{
+	return container_of(obj,struct class_device,kobj);
+}
+static inline
+struct class_device_attribute *to_class_dev_attr(struct attribute *_attr)
+{
+	return container_of(_attr,struct class_device_attribute,attr);
+}
+
+int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+
+struct firmware_priv {
+	char fw_id[FIRMWARE_NAME_MAX];
+	struct completion completion;
+	struct bin_attribute attr_data;
+	struct firmware *fw;
+	s32 loading:2;
+	u32 abort:1;
+	int alloc_size;
+	struct timer_list timeout;
+};
+
+static ssize_t firmware_timeout_show(struct class *class, char *buf)
+{
+	return sprintf(buf, "%d\n", loading_timeout);
+}
+static ssize_t firmware_timeout_store(struct class *class,
+				      const char *buf, size_t count)
+{
+	loading_timeout = simple_strtol(buf, NULL, 10);
+	return count;
+}
+CLASS_ATTR(timeout, 0644, firmware_timeout_show, firmware_timeout_store);
+
+int firmware_class_hotplug(struct class_device *dev, char **envp,
+			   int num_envp, char *buffer, int buffer_size);
+
+struct class firmware_class = {
+        .name           = "firmware",
+	.hotplug        = firmware_class_hotplug,
+};
+
+
+int firmware_class_hotplug(struct class_device *class_dev, char **envp,
+			   int num_envp, char *buffer, int buffer_size)
+{
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	int i=0;
+	char *scratch=buffer;
+
+	if (buffer_size < (FIRMWARE_NAME_MAX+10))
+		return -ENOMEM;
+
+	envp [i++] = scratch;
+	scratch += sprintf(scratch, "FIRMWARE=%s", fw_priv->fw_id) + 1;
+	return 0;
+}
+
+static ssize_t firmware_loading_show(struct class_device *class_dev, char *buf)
+{
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	return sprintf(buf, "%d\n", fw_priv->loading);
+}
+static ssize_t firmware_loading_store(struct class_device *class_dev,
+				      const char *buf, size_t count)
+{
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	int prev_loading = fw_priv->loading;
+
+	fw_priv->loading = simple_strtol(buf, NULL, 10);
+	
+	switch(fw_priv->loading){
+	case -1:
+		fw_priv->abort = 1;
+		wmb();
+		complete(&fw_priv->completion);
+		break;
+	case 1:
+		kfree(fw_priv->fw->data);
+		fw_priv->fw->data=NULL;
+		fw_priv->fw->size=0;
+		fw_priv->alloc_size=0;
+		break;
+	case 0:
+		if(prev_loading==1)
+			complete(&fw_priv->completion);
+		break;
+	}
+
+	return count;
+}
+CLASS_DEVICE_ATTR(loading, 0644,
+		  firmware_loading_show, firmware_loading_store);
+
+static ssize_t firmware_data_read(struct kobject *kobj,
+				  char *buffer, loff_t offset, size_t count)
+{
+	struct class_device *class_dev = to_class_dev(kobj);
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	struct firmware *fw = fw_priv->fw;
+
+	printk("%s: count:%d offset:%lld\n", __FUNCTION__, count, offset);
+
+	if (offset > fw->size)
+		return 0;
+	if (offset + count > fw->size)
+		count = fw->size - offset;
+
+	memcpy(buffer, fw->data, fw->size);
+	return count;
+}
+static int fw_realloc_buffer(struct firmware_priv *fw_priv, int min_size)
+{
+	u8 *new_data;
+
+	if (min_size <= fw_priv->alloc_size)
+		return 0;
+
+	new_data = kmalloc(fw_priv->alloc_size+PAGE_SIZE, GFP_KERNEL);
+	if(!new_data){
+		printk(KERN_ERR "%s: unable to alloc buffer\n",
+		       __FUNCTION__);
+		/* Make sure that we don't keep incomplete data */
+		fw_priv->abort = 1;
+		return -ENOMEM;
+	}
+	fw_priv->alloc_size += PAGE_SIZE;
+	if(fw_priv->fw->data){
+		memcpy(new_data, fw_priv->fw->data, fw_priv->fw->size);
+		kfree(fw_priv->fw->data);
+	}
+	fw_priv->fw->data=new_data;
+	BUG_ON(min_size > fw_priv->alloc_size);
+	return 0;
+}
+static ssize_t firmware_data_write(struct kobject *kobj,
+				   char *buffer, loff_t offset, size_t count)
+{
+	struct class_device *class_dev = to_class_dev(kobj);
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	struct firmware *fw = fw_priv->fw;
+	int retval;
+
+	printk("%s: count:%d offset:%lld\n", __FUNCTION__, count, offset);
+	retval = fw_realloc_buffer(fw_priv, offset+count);
+	if(retval){
+		printk("%s: retval:%d\n", __FUNCTION__, retval);
+		return retval;
+	}
+	printk("%s: retval:%d\n", __FUNCTION__, retval);
+
+	memcpy(fw->data+offset, buffer, count);
+
+	fw->size = max_t(size_t, offset+count, fw->size);
+
+	return count;
+}
+static struct bin_attribute firmware_attr_data_tmpl = {
+	.attr = {.name = "data", .mode = 0644},
+	.size = 0,
+	.read = firmware_data_read,
+	.write = firmware_data_write,
+};
+static void firmware_class_timeout(u_long data)
+{
+	struct firmware_priv *fw_priv = (struct firmware_priv *)data;
+	fw_priv->abort=1;
+	wmb();
+	complete(&fw_priv->completion);	
+}
+static inline void fw_setup_class_device_id(struct class_device *class_dev,
+				       struct device *dev)
+{
+#warning we should watch out for name collisions
+	strncpy(class_dev->class_id, dev->bus_id, BUS_ID_SIZE);
+	class_dev->class_id[BUS_ID_SIZE-1] = '\0';
+}
+static int fw_setup_class_device(struct class_device *class_dev,
+				 const char *fw_name,
+				 struct device *device)
+{
+	int retval = 0;
+	struct firmware_priv *fw_priv = kmalloc(sizeof(struct firmware_priv),
+						GFP_KERNEL);
+
+	if(!fw_priv){
+		retval = -ENOMEM;
+		goto out;
+	}
+	memset(fw_priv, 0, sizeof(*fw_priv));
+	memset(class_dev, 0, sizeof(*class_dev));
+
+	init_completion(&fw_priv->completion);
+	memcpy(&fw_priv->attr_data, &firmware_attr_data_tmpl,
+	       sizeof(firmware_attr_data_tmpl));
+
+	strncpy(fw_priv->fw_id, fw_name, FIRMWARE_NAME_MAX);
+	fw_priv->fw_id[FIRMWARE_NAME_MAX-1] = '\0';
+
+	fw_setup_class_device_id(class_dev, device);
+	class_dev->dev = device;
+
+	fw_priv->timeout.function = firmware_class_timeout;
+	fw_priv->timeout.data = (u_long)fw_priv;
+	init_timer(&fw_priv->timeout);
+
+	class_dev->class = &firmware_class,
+	class_set_devdata(class_dev, fw_priv);
+	retval = class_device_register(class_dev);
+	if (retval){
+		printk(KERN_ERR "%s: class_device_register failed\n",
+		       __FUNCTION__);
+		goto error_free_fw_priv;
+	}
+
+	retval = sysfs_create_bin_file(&class_dev->kobj,
+				       &fw_priv->attr_data);
+	if (retval){
+		printk(KERN_ERR "%s: sysfs_create_bin_file failed\n",
+		       __FUNCTION__);
+		goto error_unreg_class_dev;
+	}
+
+	retval = class_device_create_file(class_dev,
+					  &class_device_attr_loading);
+	if (retval){
+		printk(KERN_ERR "%s: class_device_create_file failed\n",
+		       __FUNCTION__);
+		goto error_remove_data;
+	}
+
+	fw_priv->fw=kmalloc(sizeof(struct firmware), GFP_KERNEL);
+	if(!fw_priv->fw){
+		printk(KERN_ERR "%s: kmalloc(struct firmware) failed\n",
+		       __FUNCTION__);
+		retval = -ENOMEM;
+		goto error_remove_loading;
+	}
+	memset(fw_priv->fw, 0, sizeof(*fw_priv->fw));
+
+	goto out;
+	
+error_remove_loading:
+	class_device_remove_file(class_dev, &class_device_attr_loading);
+error_remove_data:
+	sysfs_remove_bin_file(&class_dev->kobj, &fw_priv->attr_data);
+error_unreg_class_dev:
+	class_device_unregister(class_dev);
+error_free_fw_priv:
+	kfree(fw_priv);
+out:
+	return retval;
+}
+static void fw_remove_class_device(struct class_device *class_dev)
+{
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+
+	class_device_remove_file(class_dev, &class_device_attr_loading);
+	sysfs_remove_bin_file(&class_dev->kobj, &fw_priv->attr_data);
+	class_device_unregister(class_dev);
+}
+
+int request_firmware (const struct firmware **firmware, const char *name,
+		      struct device *device)
+{
+	struct class_device *class_dev = kmalloc(sizeof(struct class_device),
+						 GFP_KERNEL);
+	struct firmware_priv *fw_priv;
+	int retval;
+
+	if(!class_dev)
+		return -ENOMEM;
+
+	if(!firmware){
+		retval = -EINVAL;
+		goto out;
+	}
+	*firmware=NULL;
+
+	retval = fw_setup_class_device(class_dev, name, device);
+	if(retval)
+		goto out;
+
+	fw_priv = class_get_devdata(class_dev);
+
+	fw_priv->timeout.expires = jiffies + loading_timeout*HZ;
+	add_timer(&fw_priv->timeout);
+
+	wait_for_completion(&fw_priv->completion);
+
+	del_timer(&fw_priv->timeout);
+	fw_remove_class_device(class_dev);
+
+	if(fw_priv->fw->size && !fw_priv->abort){
+		*firmware = fw_priv->fw;
+	} else {
+		retval = -ENOENT;
+		kfree(fw_priv->fw->data);
+		kfree(fw_priv->fw);
+	}
+	kfree(fw_priv);
+out:
+	kfree(class_dev);
+	return retval;
+}
+void release_firmware (const struct firmware *fw)
+{
+	if(fw){
+		kfree(fw->data);
+		kfree(fw);
+	}
+}
+
+void register_firmware (const char *name, const u8 *data, size_t size)
+{
+	/* This is meaningless without firmware caching, so until we
+	 * decide if firmware caching is reasonable just leave it as a
+	 * noop */
+}
+
+/* Async support */
+struct firmware_work {
+	struct work_struct work;
+	struct module *module;
+	const char *name;
+	struct device *device;
+	void *context;
+	void (*cont)(const struct firmware *fw, void *context);
+};
+
+static void request_firmware_work_func(void *arg)
+{
+	struct firmware_work *fw_work = arg;
+	const struct firmware *fw;
+	if(!arg)
+		return;
+	request_firmware(&fw, fw_work->name, fw_work->device);
+	fw_work->cont(fw, fw_work->context);
+	release_firmware(fw);
+	module_put(fw_work->module);
+	kfree(fw_work);
+}
+
+int request_firmware_nowait (
+	struct module *module,
+	const char *name, struct device *device, void *context,
+	void (*cont)(const struct firmware *fw, void *context))
+{
+	struct firmware_work *fw_work = kmalloc(sizeof(struct firmware_work),
+						GFP_ATOMIC);
+	if(!fw_work)
+		return -ENOMEM;
+	if(!try_module_get(module)){
+		kfree(fw_work);
+		return -EFAULT;
+	}
+
+	*fw_work = (struct firmware_work){
+		.module = module,
+		.name = name,
+		.device = device,
+		.context = context,
+		.cont = cont,
+	};
+	INIT_WORK(&fw_work->work, request_firmware_work_func, fw_work);
+
+	schedule_work(&fw_work->work);
+	return 0;
+}
+
+
+
+static int __init firmware_class_init(void)
+{
+	int error;
+        error = class_register(&firmware_class);
+        if (error) {
+		printk(KERN_ERR "%s: class_register failed\n",
+		       __FUNCTION__);
+	}
+	error = class_create_file(&firmware_class, &class_attr_timeout);
+	if (error){
+		printk(KERN_ERR "%s: class_create_file failed\n",
+		       __FUNCTION__);
+		class_unregister(&firmware_class);
+	}
+        return error;
+
+}
+static void __exit firmware_class_exit(void)
+{
+	class_remove_file(&firmware_class, &class_attr_timeout);
+	class_unregister(&firmware_class);
+}
+module_init(firmware_class_init);
+module_exit(firmware_class_exit);
+
+EXPORT_SYMBOL(release_firmware);
+EXPORT_SYMBOL(request_firmware);
+EXPORT_SYMBOL(request_firmware_nowait);
+EXPORT_SYMBOL(register_firmware);
+EXPORT_SYMBOL(firmware_class);
diff --exclude=CVS -urN linux-2.5.orig/drivers/base/firmware_sample_driver.c linux-2.5.mine/drivers/base/firmware_sample_driver.c
--- linux-2.5.orig/drivers/base/firmware_sample_driver.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.mine/drivers/base/firmware_sample_driver.c	2003-05-17 23:20:45.000000000 +0200
@@ -0,0 +1,115 @@
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+
+#include "linux/firmware.h"
+
+#define WE_CAN_NEED_FIRMWARE_BEFORE_USERSPACE_IS_AVAILABLE
+#ifdef WE_CAN_NEED_FIRMWARE_BEFORE_USERSPACE_IS_AVAILABLE
+char __init inkernel_firmware[] = "let's say that this is firmware\n";
+#endif
+
+static struct device ghost_device = {
+	.name      = "Ghost Device",
+	.bus_id    = "ghost0",
+};
+
+
+static void sample_firmware_load(char *firmware, int size)
+{
+	u8 buf[size+1];
+	memcpy(buf, firmware, size);
+	buf[size] = '\0';
+	printk("firmware_sample_driver: firmware: %s\n", buf);
+}
+
+static void sample_probe_default(void)
+{
+	/* uses the default method to get the firmware */
+        const struct firmware *fw_entry;
+	printk("firmware_sample_driver: a ghost device got inserted :)\n");
+
+        if(request_firmware(&fw_entry, "sample_driver_fw", &ghost_device)!=0)
+	{
+		printk(KERN_ERR
+		       "firmware_sample_driver: Firmware not available\n");
+		return;
+	}
+	
+	sample_firmware_load(fw_entry->data, fw_entry->size);
+
+	release_firmware(fw_entry);
+
+	/* finish setting up the device */
+}
+static void sample_probe_specific(void)
+{
+	/* Uses some specific hotplug support to get the firmware from
+	 * userspace  directly into the hardware, or via some sysfs file */
+
+	/* NOTE: This currently doesn't work */
+
+	printk("firmware_sample_driver: a ghost device got inserted :)\n");
+
+        if(request_firmware(NULL, "sample_driver_fw", &ghost_device)!=0)
+	{
+		printk(KERN_ERR
+		       "firmware_sample_driver: Firmware load failed\n");
+		return;
+	}
+	
+	/* request_firmware blocks until userspace finished, so at
+	 * this point the firmware should be already in the device */
+
+	/* finish setting up the device */
+}
+static void sample_probe_async_cont(const struct firmware *fw, void *context)
+{
+	if(!fw){
+		printk(KERN_ERR
+		       "firmware_sample_driver: firmware load failed\n");
+		return;
+	}
+
+	printk("firmware_sample_driver: device pointer \"%s\"\n",
+	       (char *)context);
+	sample_firmware_load(fw->data, fw->size);
+}
+static void sample_probe_async(void)
+{
+	/* Let's say that I can't sleep */
+	int error;
+	error = request_firmware_nowait (THIS_MODULE,
+					 "sample_driver_fw", &ghost_device,
+					 "my device pointer",
+					 sample_probe_async_cont);
+	if(error){
+		printk(KERN_ERR 
+		       "firmware_sample_driver:"
+		       " request_firmware_nowait failed\n");
+	}
+}
+
+static int sample_init(void)
+{
+#ifdef WE_CAN_NEED_FIRMWARE_BEFORE_USERSPACE_IS_AVAILABLE
+	register_firmware("sample_driver_fw", inkernel_firmware,
+			  sizeof(inkernel_firmware));
+#endif
+	device_initialize(&ghost_device);
+	/* since there is no real hardware insertion I just call the
+	 * sample probe functions here */
+	sample_probe_specific();
+	sample_probe_default();
+	sample_probe_async();
+	return 0;
+}
+static void __exit sample_exit(void)
+{
+}
+
+module_init (sample_init);
+module_exit (sample_exit);
+
+MODULE_LICENSE("GPL");
diff --exclude=CVS -urN linux-2.5.orig/drivers/base/firmware_sample_firmware_class.c linux-2.5.mine/drivers/base/firmware_sample_firmware_class.c
--- linux-2.5.orig/drivers/base/firmware_sample_firmware_class.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.mine/drivers/base/firmware_sample_firmware_class.c	2003-05-17 23:19:44.000000000 +0200
@@ -0,0 +1,200 @@
+/*
+ * firmware_class.c - Multi purpose firmware loading support
+ *
+ * Copyright (c) 2003 Manuel Estrada Sainz <ranty@debian.org>
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <asm/hardirq.h>
+
+#include "linux/firmware.h"
+
+MODULE_AUTHOR("Manuel Estrada Sainz <ranty@debian.org>");
+MODULE_DESCRIPTION("Hackish sample for using firmware class directly");
+MODULE_LICENSE("GPL");
+
+static inline struct class_device *to_class_dev(struct kobject *obj)
+{
+	return container_of(obj,struct class_device,kobj);
+}
+static inline
+struct class_device_attribute *to_class_dev_attr(struct attribute *_attr)
+{
+	return container_of(_attr,struct class_device_attribute,attr);
+}
+
+int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+int sysfs_remove_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+
+struct firmware_priv {
+	char fw_id[FIRMWARE_NAME_MAX];
+	s32 loading:2;
+	u32 abort:1;
+};
+
+extern struct class firmware_class;
+
+static ssize_t firmware_loading_show(struct class_device *class_dev, char *buf)
+{
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	return sprintf(buf, "%d\n", fw_priv->loading);
+}
+static ssize_t firmware_loading_store(struct class_device *class_dev,
+				      const char *buf, size_t count)
+{
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	int prev_loading = fw_priv->loading;
+
+	fw_priv->loading = simple_strtol(buf, NULL, 10);
+	
+	switch(fw_priv->loading){
+	case -1:
+		/* abort load an panic */
+		break;
+	case 1:
+		/* setup load */
+		break;
+	case 0:
+		if(prev_loading==1){
+			/* finish load and get the device back to working
+			 * state */
+		}
+		break;
+	}
+
+	return count;
+}
+CLASS_DEVICE_ATTR(loading, 0644,
+		  firmware_loading_show, firmware_loading_store);
+
+static ssize_t firmware_data_read(struct kobject *kobj,
+				  char *buffer, loff_t offset, size_t count)
+{
+	struct class_device *class_dev = to_class_dev(kobj);
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+
+	/* read from the devices firmware memory */
+
+	return count;
+}
+static ssize_t firmware_data_write(struct kobject *kobj,
+				   char *buffer, loff_t offset, size_t count)
+{
+	struct class_device *class_dev = to_class_dev(kobj);
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+
+	/* write to the devices firmware memory */
+
+	return count;
+}
+static struct bin_attribute firmware_attr_data = {
+	.attr = {.name = "data", .mode = 0644},
+	.size = 0,
+	.read = firmware_data_read,
+	.write = firmware_data_write,
+};
+static int fw_setup_class_device(struct class_device *class_dev,
+				 const char *fw_name,
+				 struct device *device)
+{
+	int retval = 0;
+	struct firmware_priv *fw_priv = kmalloc(sizeof(struct firmware_priv),
+						GFP_KERNEL);
+
+	if(!fw_priv){
+		retval = -ENOMEM;
+		goto out;
+	}
+	memset(fw_priv, 0, sizeof(*fw_priv));
+	memset(class_dev, 0, sizeof(*class_dev));
+
+	strncpy(fw_priv->fw_id, fw_name, FIRMWARE_NAME_MAX);
+	fw_priv->fw_id[FIRMWARE_NAME_MAX-1] = '\0';
+
+	strncpy(class_dev->class_id, device->bus_id, BUS_ID_SIZE);
+	class_dev->class_id[BUS_ID_SIZE-1] = '\0';
+	class_dev->dev = device;
+
+	class_dev->class = &firmware_class,
+	class_set_devdata(class_dev, fw_priv);
+	retval = class_device_register(class_dev);
+	if (retval){
+		printk(KERN_ERR "%s: class_device_register failed\n",
+		       __FUNCTION__);
+		goto error_free_fw_priv;
+	}
+
+	retval = sysfs_create_bin_file(&class_dev->kobj, &firmware_attr_data);
+	if (retval){
+		printk(KERN_ERR "%s: sysfs_create_bin_file failed\n",
+		       __FUNCTION__);
+		goto error_unreg_class_dev;
+	}
+
+	retval = class_device_create_file(class_dev,
+					  &class_device_attr_loading);
+	if (retval){
+		printk(KERN_ERR "%s: class_device_create_file failed\n",
+		       __FUNCTION__);
+		goto error_remove_data;
+	}
+
+	goto out;
+	
+error_remove_data:
+	sysfs_remove_bin_file(&class_dev->kobj, &firmware_attr_data);
+error_unreg_class_dev:
+	class_device_unregister(class_dev);
+error_free_fw_priv:
+	kfree(fw_priv);
+out:
+	return retval;
+}
+static void fw_remove_class_device(struct class_device *class_dev)
+{
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+
+	class_device_remove_file(class_dev, &class_device_attr_loading);
+	sysfs_remove_bin_file(&class_dev->kobj, &firmware_attr_data);
+	class_device_unregister(class_dev);
+}
+
+static struct class_device *class_dev;
+
+static struct device my_device = {
+	.name      = "Sample Device",
+	.bus_id    = "my_dev0",
+};
+
+static int __init firmware_sample_init(void)
+{
+	int error;
+
+	device_initialize(&my_device);
+	class_dev = kmalloc(sizeof(struct class_device), GFP_KERNEL);
+	if(!class_dev)
+		return -ENOMEM;
+
+	error = fw_setup_class_device(class_dev, "my_firmware_image",
+				      &my_device);
+	if(error){
+		kfree(class_dev);
+		return error;
+	}
+        return 0;
+
+}
+static void __exit firmware_sample_exit(void)
+{
+	struct firmware_priv *fw_priv = class_get_devdata(class_dev);
+	fw_remove_class_device(class_dev);
+	kfree(fw_priv);
+	kfree(class_dev);
+}
+module_init(firmware_sample_init);
+module_exit(firmware_sample_exit);
+
diff --exclude=CVS -urN linux-2.5.orig/include/linux/firmware.h linux-2.5.mine/include/linux/firmware.h
--- linux-2.5.orig/include/linux/firmware.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.5.mine/include/linux/firmware.h	2003-05-17 22:16:36.000000000 +0200
@@ -0,0 +1,20 @@
+#ifndef _LINUX_FIRMWARE_H
+#define _LINUX_FIRMWARE_H
+#include <linux/module.h>
+#include <linux/types.h>
+#define FIRMWARE_NAME_MAX 30 
+struct firmware {
+	size_t size;
+	u8 *data;
+};
+int request_firmware (const struct firmware **fw, const char *name,
+		      struct device *device);
+int request_firmware_nowait (
+	struct module *module,
+	const char *name, struct device *device, void *context,
+	void (*cont)(const struct firmware *fw, void *context));
+/* Maybe 'device' should be 'struct device *' */
+
+void release_firmware (const struct firmware *fw);
+void register_firmware (const char *name, const u8 *data, size_t size);
+#endif

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysfs-bin-flexible-size.diff"

diff --exclude=CVS -urN linux-2.5.orig/fs/sysfs/bin.c linux-2.5.mine/fs/sysfs/bin.c
--- linux-2.5.orig/fs/sysfs/bin.c	2003-05-17 20:44:03.000000000 +0200
+++ linux-2.5.mine/fs/sysfs/bin.c	2003-05-17 14:53:01.000000000 +0200
@@ -30,10 +30,15 @@
 	loff_t offs = *off;
 	int ret;
 
-	if (offs > size)
-		return 0;
-	if (offs + count > size)
-		count = size - offs;
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
+
+	if(size){
+		if (offs > size)
+			return 0;
+		if (offs + count > size)
+			count = size - offs;
+	}
 
 	ret = fill_read(dentry, buffer, offs, count);
 	if (ret < 0) 
@@ -69,10 +74,14 @@
 	loff_t offs = *off;
 	int ret;
 
-	if (offs > size)
-		return 0;
-	if (offs + count > size)
-		count = size - offs;
+	if (count > PAGE_SIZE)
+		count = PAGE_SIZE;
+	if (size) {
+		if (offs > size)
+			return 0;
+		if (offs + count > size)
+			count = size - offs;
+	}
 
 	ret = -EFAULT;
 	if (copy_from_user(buffer + offs, userbuf, count))
@@ -81,7 +90,7 @@
 	count = flush_write(dentry, buffer, offs, count);
 	if (count > 0)
 		*off = offs + count;
-	ret = 0;
+	ret = count;
  Done:
 	return ret;
 }
@@ -102,7 +111,7 @@
 		goto Done;
 
 	error = -ENOMEM;
-	file->private_data = kmalloc(attr->size, GFP_KERNEL);
+	file->private_data = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!file->private_data)
 		goto Done;
 

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysfs-bin-lost-dget.diff"

diff --exclude=CVS -urN linux-2.5.orig/fs/sysfs/inode.c linux-2.5.mine/fs/sysfs/inode.c
--- linux-2.5.orig/fs/sysfs/inode.c	2003-05-17 20:44:03.000000000 +0200
+++ linux-2.5.mine/fs/sysfs/inode.c	2003-05-17 20:30:34.000000000 +0200
@@ -60,9 +60,10 @@
  Proceed:
 	if (init)
 		error = init(inode);
-	if (!error)
+	if (!error){
 		d_instantiate(dentry, inode);
-	else
+		dget(dentry); /* Extra count - pin the dentry in core */
+	} else
 		iput(inode);
  Done:
 	return error;

--pf9I7BMVVzbSWLtt--
