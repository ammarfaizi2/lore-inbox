Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWFUTxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWFUTxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWFUTxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:53:22 -0400
Received: from ns2.suse.de ([195.135.220.15]:20122 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030256AbWFUTuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:50:07 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 18/22] [PATCH] Driver core: allow struct device to have a dev_t
Reply-To: Greg KH <greg@kroah.com>
Date: Wed, 21 Jun 2006 12:46:01 -0700
Message-Id: <1150919221158-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.0
In-Reply-To: <1150919218895-git-send-email-greg@kroah.com>
References: <20060621194511.GA23982@kroah.com> <11509191652021-git-send-email-greg@kroah.com> <11509191682051-git-send-email-greg@kroah.com> <11509191721672-git-send-email-greg@kroah.com> <1150919175882-git-send-email-greg@kroah.com> <11509191781796-git-send-email-greg@kroah.com> <11509191812079-git-send-email-greg@kroah.com> <115091918546-git-send-email-greg@kroah.com> <11509191893358-git-send-email-greg@kroah.com> <1150919192294-git-send-email-greg@kroah.com> <11509191951525-git-send-email-greg@kroah.com> <11509191982588-git-send-email-greg@kroah.com> <11509192022315-git-send-email-greg@kroah.com> <11509192043044-git-send-email-greg@kroah.com> <11509192081167-git-send-email-greg@kroah.com> <11509192111668-git-send-email-greg@kroah.com> <1150919214366-git-send-email-greg@kroah.com> <1150919218895-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

This is the first step in moving class_device to being replaced by
struct device.  It allows struct device to export a dev_t and makes it
easy to dynamically create and destroy struct device as long as they are
associated with a specific class.

Cc: Kay Sievers <kay.sievers@vrfy.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/class.c   |    1 
 drivers/base/core.c    |  162 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |   14 ++++
 3 files changed, 176 insertions(+), 1 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index 41a8e09..50e841a 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -142,6 +142,7 @@ int class_register(struct class * cls)
 	pr_debug("device class '%s': registering\n", cls->name);
 
 	INIT_LIST_HEAD(&cls->children);
+	INIT_LIST_HEAD(&cls->devices);
 	INIT_LIST_HEAD(&cls->interfaces);
 	init_MUTEX(&cls->sem);
 	error = kobject_set_name(&cls->subsys.kset.kobj, "%s", cls->name);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index d5e15a0..252cf40 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -15,6 +15,7 @@ #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/kdev_t.h>
 
 #include <asm/semaphore.h>
 
@@ -98,6 +99,8 @@ static int dev_uevent_filter(struct kset
 		struct device *dev = to_dev(kobj);
 		if (dev->bus)
 			return 1;
+		if (dev->class)
+			return 1;
 	}
 	return 0;
 }
@@ -106,7 +109,11 @@ static const char *dev_uevent_name(struc
 {
 	struct device *dev = to_dev(kobj);
 
-	return dev->bus->name;
+	if (dev->bus)
+		return dev->bus->name;
+	if (dev->class)
+		return dev->class->name;
+	return NULL;
 }
 
 static int dev_uevent(struct kset *kset, struct kobject *kobj, char **envp,
@@ -117,6 +124,16 @@ static int dev_uevent(struct kset *kset,
 	int length = 0;
 	int retval = 0;
 
+	/* add the major/minor if present */
+	if (MAJOR(dev->devt)) {
+		add_uevent_var(envp, num_envp, &i,
+			       buffer, buffer_size, &length,
+			       "MAJOR=%u", MAJOR(dev->devt));
+		add_uevent_var(envp, num_envp, &i,
+			       buffer, buffer_size, &length,
+			       "MINOR=%u", MINOR(dev->devt));
+	}
+
 	/* add bus name of physical device */
 	if (dev->bus)
 		add_uevent_var(envp, num_envp, &i,
@@ -161,6 +178,12 @@ static ssize_t store_uevent(struct devic
 	return count;
 }
 
+static ssize_t show_dev(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	return print_dev_t(buf, dev->devt);
+}
+
 /*
  *	devices_subsys - structure to be registered with kobject core.
  */
@@ -231,6 +254,7 @@ void device_initialize(struct device *de
 	klist_init(&dev->klist_children, klist_children_get,
 		   klist_children_put);
 	INIT_LIST_HEAD(&dev->dma_pools);
+	INIT_LIST_HEAD(&dev->node);
 	init_MUTEX(&dev->sem);
 	device_init_wakeup(dev, 0);
 }
@@ -274,6 +298,31 @@ int device_add(struct device *dev)
 	dev->uevent_attr.store = store_uevent;
 	device_create_file(dev, &dev->uevent_attr);
 
+	if (MAJOR(dev->devt)) {
+		struct device_attribute *attr;
+		attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+		if (!attr) {
+			error = -ENOMEM;
+			goto PMError;
+		}
+		attr->attr.name = "dev";
+		attr->attr.mode = S_IRUGO;
+		if (dev->driver)
+			attr->attr.owner = dev->driver->owner;
+		attr->show = show_dev;
+		error = device_create_file(dev, attr);
+		if (error) {
+			kfree(attr);
+			goto attrError;
+		}
+
+		dev->devt_attr = attr;
+	}
+
+	if (dev->class)
+		sysfs_create_link(&dev->class->subsys.kset.kobj, &dev->kobj,
+				  dev->bus_id);
+
 	if ((error = device_pm_add(dev)))
 		goto PMError;
 	if ((error = bus_add_device(dev)))
@@ -292,6 +341,11 @@ int device_add(struct device *dev)
  BusError:
 	device_pm_remove(dev);
  PMError:
+	if (dev->devt_attr) {
+		device_remove_file(dev, dev->devt_attr);
+		kfree(dev->devt_attr);
+	}
+ attrError:
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
  Error:
@@ -366,6 +420,10 @@ void device_del(struct device * dev)
 
 	if (parent)
 		klist_del(&dev->knode_parent);
+	if (dev->devt_attr)
+		device_remove_file(dev, dev->devt_attr);
+	if (dev->class)
+		sysfs_remove_link(&dev->class->subsys.kset.kobj, dev->bus_id);
 	device_remove_file(dev, &dev->uevent_attr);
 
 	/* Notify the platform of the removal, in case they
@@ -450,3 +508,105 @@ EXPORT_SYMBOL_GPL(put_device);
 
 EXPORT_SYMBOL_GPL(device_create_file);
 EXPORT_SYMBOL_GPL(device_remove_file);
+
+
+static void device_create_release(struct device *dev)
+{
+	pr_debug("%s called for %s\n", __FUNCTION__, dev->bus_id);
+	kfree(dev);
+}
+
+/**
+ * device_create - creates a device and registers it with sysfs
+ * @cs: pointer to the struct class that this device should be registered to.
+ * @parent: pointer to the parent struct device of this new device, if any.
+ * @dev: the dev_t for the char device to be added.
+ * @fmt: string for the class device's name
+ *
+ * This function can be used by char device classes.  A struct
+ * device will be created in sysfs, registered to the specified
+ * class.
+ * A "dev" file will be created, showing the dev_t for the device, if
+ * the dev_t is not 0,0.
+ * If a pointer to a parent struct device is passed in, the newly
+ * created struct device will be a child of that device in sysfs.  The
+ * pointer to the struct device will be returned from the call.  Any
+ * further sysfs files that might be required can be created using this
+ * pointer.
+ *
+ * Note: the struct class passed to this function must have previously
+ * been created with a call to class_create().
+ */
+struct device *device_create(struct class *class, struct device *parent,
+			     dev_t devt, char *fmt, ...)
+{
+	va_list args;
+	struct device *dev = NULL;
+	int retval = -ENODEV;
+
+	if (class == NULL || IS_ERR(class))
+		goto error;
+	if (parent == NULL) {
+		printk(KERN_WARNING "%s does not work yet for NULL parents\n", __FUNCTION__);
+		goto error;
+	}
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev) {
+		retval = -ENOMEM;
+		goto error;
+	}
+
+	dev->devt = devt;
+	dev->class = class;
+	dev->parent = parent;
+	dev->release = device_create_release;
+
+	va_start(args, fmt);
+	vsnprintf(dev->bus_id, BUS_ID_SIZE, fmt, args);
+	va_end(args);
+	retval = device_register(dev);
+	if (retval)
+		goto error;
+
+	/* tie the class to the device */
+	down(&class->sem);
+	list_add_tail(&dev->node, &class->devices);
+	up(&class->sem);
+
+	return dev;
+
+error:
+	kfree(dev);
+	return ERR_PTR(retval);
+}
+EXPORT_SYMBOL_GPL(device_create);
+
+/**
+ * device_destroy - removes a device that was created with device_create()
+ * @class: the pointer to the struct class that this device was registered * with.
+ * @dev: the dev_t of the device that was previously registered.
+ *
+ * This call unregisters and cleans up a class device that was created with a
+ * call to class_device_create()
+ */
+void device_destroy(struct class *class, dev_t devt)
+{
+	struct device *dev = NULL;
+	struct device *dev_tmp;
+
+	down(&class->sem);
+	list_for_each_entry(dev_tmp, &class->devices, node) {
+		if (dev_tmp->devt == devt) {
+			dev = dev_tmp;
+			break;
+		}
+	}
+	up(&class->sem);
+
+	if (dev) {
+		list_del_init(&dev->node);
+		device_unregister(dev);
+	}
+}
+EXPORT_SYMBOL_GPL(device_destroy);
diff --git a/include/linux/device.h b/include/linux/device.h
index ade10dd..b473f42 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -142,6 +142,7 @@ struct class {
 
 	struct subsystem	subsys;
 	struct list_head	children;
+	struct list_head	devices;
 	struct list_head	interfaces;
 	struct semaphore	sem;	/* locks both the children and interfaces lists */
 
@@ -305,6 +306,7 @@ struct device {
 	struct kobject kobj;
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
 	struct device_attribute uevent_attr;
+	struct device_attribute *devt_attr;
 
 	struct semaphore	sem;	/* semaphore to synchronize calls to
 					 * its driver.
@@ -332,6 +334,11 @@ struct device {
 	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
 					     override */
 
+	/* class_device migration path */
+	struct list_head	node;
+	struct class		*class;		/* optional*/
+	dev_t			devt;		/* dev_t, creates the sysfs "dev" */
+
 	void	(*release)(struct device * dev);
 };
 
@@ -373,6 +380,13 @@ extern int  device_attach(struct device 
 extern void driver_attach(struct device_driver * drv);
 extern void device_reprobe(struct device *dev);
 
+/*
+ * Easy functions for dynamically creating devices on the fly
+ */
+extern struct device *device_create(struct class *cls, struct device *parent,
+				    dev_t devt, char *fmt, ...)
+				    __attribute__((format(printf,4,5)));
+extern void device_destroy(struct class *cls, dev_t devt);
 
 /*
  * Platform "fixup" functions - allow the platform to have their say
-- 
1.4.0

