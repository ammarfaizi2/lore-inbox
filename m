Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbUK0QSV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbUK0QSV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 11:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUK0QRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 11:17:50 -0500
Received: from [220.248.27.114] ([220.248.27.114]:40669 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261247AbUK0QOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 11:14:46 -0500
Date: Sun, 28 Nov 2004 00:13:19 +0800
From: hugang@soulinfo.com
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 merge: 1/51: Device trees
Message-ID: <20041127161319.GB2472@hugang.soulinfo.com>
References: <20041125165413.GB476@openzaurus.ucw.cz> <20041125185304.GA1260@elf.ucw.cz> <1101421336.27250.80.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101421336.27250.80.camel@desktop.cunninghams>
User-Agent: Mutt/1.3.28i
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> SUSPEND all but swap device and parents
> WRITE LRU pages
> SUSPEND swap device and parents (+sysdev)
> Snapshot
> RESUME swap device and parents (+sysdev)
> WRITE snapshot
> SUSPEND swap device and parents
> POWERDOWN everything
> 
-device-tree.diff-
diff -urp 2.6.9-lzf/drivers/base/class.c 2.6.9/drivers/base/class.c
--- 2.6.9-lzf/drivers/base/class.c	2004-11-25 14:13:02.000000000 +0800
+++ 2.6.9/drivers/base/class.c	2004-11-27 19:10:38.000000000 +0800
@@ -465,6 +465,25 @@ void class_device_put(struct class_devic
 	kobject_put(&class_dev->kobj);
 }
 
+struct class * class_find(char * name)
+{
+	struct class * this_class;
+
+	if (!name)
+		return NULL;
+
+	down_read(&class_subsys.rwsem);
+	list_for_each_entry(this_class, &class_subsys.kset.list, subsys.kset.kobj.entry) {
+		if (!(strcmp(this_class->name, name))) {
+			class_get(this_class);
+			up_read(&class_subsys.rwsem);
+			return this_class;
+		}
+	}
+	up_read(&class_subsys.rwsem);
+
+	return NULL;
+}
 
 int class_interface_register(struct class_interface *class_intf)
 {
@@ -547,3 +566,5 @@ EXPORT_SYMBOL(class_device_remove_file);
 
 EXPORT_SYMBOL(class_interface_register);
 EXPORT_SYMBOL(class_interface_unregister);
+
+EXPORT_SYMBOL(class_find);
diff -urp 2.6.9-lzf/drivers/base/power/main.c 2.6.9/drivers/base/power/main.c
--- 2.6.9-lzf/drivers/base/power/main.c	2004-11-25 14:13:02.000000000 +0800
+++ 2.6.9/drivers/base/power/main.c	2004-11-27 18:38:54.000000000 +0800
@@ -4,6 +4,9 @@
  * Copyright (c) 2003 Patrick Mochel
  * Copyright (c) 2003 Open Source Development Lab
  *
+ * Partial tree additions
+ * Copyright (c) 2004 Nigel Cunningham
+ *
  * This file is released under the GPLv2
  *
  *
@@ -23,10 +26,18 @@
 #include <linux/device.h>
 #include "power.h"
 
-LIST_HEAD(dpm_active);
-LIST_HEAD(dpm_off);
-LIST_HEAD(dpm_off_irq);
-
+struct partial_device_tree default_device_tree =
+{ 
+	.dpm_active	= LIST_HEAD_INIT(default_device_tree.dpm_active),
+	.dpm_off	= LIST_HEAD_INIT(default_device_tree.dpm_off),
+	.dpm_off_irq	= LIST_HEAD_INIT(default_device_tree.dpm_off_irq),
+};
+EXPORT_SYMBOL(default_device_tree);
+
+/* 
+ * One mutex for all trees because we can be moving items
+ * between trees.
+ */
 DECLARE_MUTEX(dpm_sem);
 
 /*
@@ -76,7 +87,9 @@ int device_pm_add(struct device * dev)
 		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
 	atomic_set(&dev->power.pm_users, 0);
 	down(&dpm_sem);
-	list_add_tail(&dev->power.entry, &dpm_active);
+	list_add_tail(&dev->power.entry, &default_device_tree.dpm_active);
+	dev->current_list = DEVICE_LIST_DPM_ACTIVE;
+	dev->tree = &default_device_tree;
 	device_pm_set_parent(dev, dev->parent);
 	if ((error = dpm_sysfs_add(dev)))
 		list_del(&dev->power.entry);
@@ -92,6 +105,7 @@ void device_pm_remove(struct device * de
 	dpm_sysfs_remove(dev);
 	device_pm_release(dev->power.pm_parent);
 	list_del(&dev->power.entry);
+	dev->current_list = DEVICE_LIST_NONE;
 	up(&dpm_sem);
 }
 
diff -urp 2.6.9-lzf/drivers/base/power/Makefile 2.6.9/drivers/base/power/Makefile
--- 2.6.9-lzf/drivers/base/power/Makefile	2004-11-25 14:13:03.000000000 +0800
+++ 2.6.9/drivers/base/power/Makefile	2004-11-27 18:38:54.000000000 +0800
@@ -1,5 +1,5 @@
 obj-y			:= shutdown.o
-obj-$(CONFIG_PM)	+= main.o suspend.o resume.o runtime.o sysfs.o
+obj-$(CONFIG_PM)	+= main.o suspend.o resume.o runtime.o sysfs.o tree.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
diff -urp 2.6.9-lzf/drivers/base/power/power.h 2.6.9/drivers/base/power/power.h
--- 2.6.9-lzf/drivers/base/power/power.h	2004-11-27 17:33:21.000000000 +0800
+++ 2.6.9/drivers/base/power/power.h	2004-11-27 18:38:54.000000000 +0800
@@ -30,10 +30,22 @@ extern struct semaphore dpm_sem;
 /*
  * The PM lists.
  */
-extern struct list_head dpm_active;
-extern struct list_head dpm_off;
-extern struct list_head dpm_off_irq;
 
+struct partial_device_tree 
+{
+	struct list_head dpm_active;
+	struct list_head dpm_off;
+	struct list_head dpm_off_irq;
+};
+
+enum {
+	DEVICE_LIST_NONE,
+	DEVICE_LIST_DPM_ACTIVE,
+	DEVICE_LIST_DPM_OFF,
+	DEVICE_LIST_DPM_OFF_IRQ,
+};
+
+extern struct partial_device_tree default_device_tree;
 
 static inline struct dev_pm_info * to_pm_info(struct list_head * entry)
 {
@@ -59,7 +71,9 @@ extern void dpm_sysfs_remove(struct devi
  * resume.c
  */
 
+extern void dpm_resume_tree(struct partial_device_tree * tree);
 extern void dpm_resume(void);
+extern void dpm_power_up_tree(struct partial_device_tree * tree);
 extern void dpm_power_up(void);
 extern int resume_device(struct device *);
 
diff -urp 2.6.9-lzf/drivers/base/power/resume.c 2.6.9/drivers/base/power/resume.c
--- 2.6.9-lzf/drivers/base/power/resume.c	2004-11-27 17:33:21.000000000 +0800
+++ 2.6.9/drivers/base/power/resume.c	2004-11-27 18:56:49.000000000 +0800
@@ -29,20 +29,25 @@ int resume_device(struct device * dev)
 
 
 
-void dpm_resume(void)
+void dpm_resume_tree(struct partial_device_tree * tree)
 {
-	while(!list_empty(&dpm_off)) {
-		struct list_head * entry = dpm_off.next;
+	while(!list_empty(&tree->dpm_off)) {
+		struct list_head * entry = tree->dpm_off.next;
 		struct device * dev = to_device(entry);
 		list_del_init(entry);
 
 		if (dev->power.prev_state == PMSG_ON)
 			resume_device(dev);
 
-		list_add_tail(entry, &dpm_active);
+		list_add_tail(entry, &tree->dpm_active);
+		dev->current_list = DEVICE_LIST_DPM_ACTIVE;
 	}
 }
 
+void dpm_resume(void)
+{
+	dpm_resume_tree(&default_device_tree);
+}
 
 /**
  *	device_resume - Restore state of each device in system.
@@ -60,6 +65,14 @@ void device_resume(void)
 
 EXPORT_SYMBOL(device_resume);
 
+void device_resume_tree(struct partial_device_tree * tree)
+{
+	down(&dpm_sem);
+	dpm_resume_tree(tree);
+	up(&dpm_sem);
+}
+
+EXPORT_SYMBOL(device_resume_tree);
 
 /**
  *	device_power_up_irq - Power on some devices.
@@ -72,16 +85,23 @@ EXPORT_SYMBOL(device_resume);
  *	Interrupts must be disabled when calling this.
  */
 
-void dpm_power_up(void)
+void dpm_power_up_tree(struct partial_device_tree * tree)
 {
-	while(!list_empty(&dpm_off_irq)) {
-		struct list_head * entry = dpm_off_irq.next;
+	while(!list_empty(&tree->dpm_off_irq)) {
+		struct list_head * entry = tree->dpm_off_irq.next;
+		struct device * dev = to_device(entry);
 		list_del_init(entry);
-		resume_device(to_device(entry));
-		list_add_tail(entry, &dpm_active);
+		resume_device(dev);
+		list_add_tail(entry, &tree->dpm_active);
+		dev->current_list = DEVICE_LIST_DPM_ACTIVE;
 	}
 }
+EXPORT_SYMBOL(dpm_power_up_tree);
 
+void dpm_power_up(void)
+{
+	dpm_power_up_tree(&default_device_tree);
+}
 
 /**
  *	device_pm_power_up - Turn on all devices that need special attention.
@@ -97,6 +117,58 @@ void device_power_up(void)
 	dpm_power_up();
 }
 
+#if 0
+
+/**
+ *
+ * 	pci_find_class_storage
+ *
+ *	Find a PCI storage device.
+ *	Based upon pci_find_class, but less strict.
+ */
+
+static struct pci_dev *
+pci_find_class_storage(unsigned int class, const struct pci_dev *from)
+{
+	struct list_head *n;
+	struct pci_dev *dev;
+
+	spin_lock(&pci_bus_lock);
+	n = from ? from->global_list.next : pci_devices.next;
+
+	while (n && (n != &pci_devices)) {
+		dev = pci_dev_g(n);
+		if (((dev->class & 0xff00) >> 16) == class)
+			goto exit;
+		n = n->next;
+	}
+	dev = NULL;
+exit:
+	spin_unlock(&pci_bus_lock);
+	return dev;
+}
+
+
+/**
+ *	device_resume_type - Resume some devices.
+ *
+ *	Resume devices of a specific type and their parents.
+ *	Interrupts must be disabled when calling this.
+ *
+ *	Note that we only handle pci devices at the moment.
+ *	We have no way that I can tell of getting the class
+ *	of devices not on the pci bus.
+ */
+void device_resume_type(type)
+{
+	struct device * dev_dev;
+	struct pci_dev * pci_dev = NULL;
+	
+	while ((dev = pci_find_class(PCI_BASE_CLASS_STORAGE, dev))) {
+	}
+}
+#endif
+
 EXPORT_SYMBOL(device_power_up);
 
 
diff -urp 2.6.9-lzf/drivers/base/power/shutdown.c 2.6.9/drivers/base/power/shutdown.c
--- 2.6.9-lzf/drivers/base/power/shutdown.c	2004-11-27 17:33:21.000000000 +0800
+++ 2.6.9/drivers/base/power/shutdown.c	2004-11-27 18:38:54.000000000 +0800
@@ -66,3 +66,4 @@ void device_shutdown(void)
 	sysdev_shutdown();
 }
 
+EXPORT_SYMBOL(device_shutdown);
diff -urp 2.6.9-lzf/drivers/base/power/suspend.c 2.6.9/drivers/base/power/suspend.c
--- 2.6.9-lzf/drivers/base/power/suspend.c	2004-11-27 17:33:21.000000000 +0800
+++ 2.6.9/drivers/base/power/suspend.c	2004-11-28 00:09:08.000000000 +0800
@@ -51,7 +51,7 @@ int suspend_device(struct device * dev, 
 
 
 /**
- *	device_suspend - Save state and stop all devices in system.
+ *	device_suspend_tree - Save state and stop all devices in system.
  *	@state:		Power state to put each device in.
  *
  *	Walk the dpm_active list, call ->suspend() for each device, and move
@@ -60,7 +60,7 @@ int suspend_device(struct device * dev, 
  *	the device to the dpm_off list. If it returns -EAGAIN, we move it to
  *	the dpm_off_irq list. If we get a different error, try and back out.
  *
- *	If we hit a failure with any of the devices, call device_resume()
+ *	If we hit a failure with any of the devices, call device_resume_tree()
  *	above to bring the suspended devices back to life.
  *
  *	Note this function leaves dpm_sem held to
@@ -70,22 +70,24 @@ int suspend_device(struct device * dev, 
  *
  */
 
-int device_suspend(pm_message_t state)
+int device_suspend_tree(pm_message_t state, struct partial_device_tree * tree)
 {
 	int error = 0;
 
 	down(&dpm_sem);
-	while(!list_empty(&dpm_active)) {
-		struct list_head * entry = dpm_active.prev;
+	while(!list_empty(&tree->dpm_active)) {
+		struct list_head * entry = tree->dpm_active.prev;
 		struct device * dev = to_device(entry);
 		error = suspend_device(dev, state);
 
 		if (!error) {
 			list_del(&dev->power.entry);
-			list_add(&dev->power.entry, &dpm_off);
+			list_add(&dev->power.entry, &tree->dpm_off);
+			dev->current_list = DEVICE_LIST_DPM_OFF;
 		} else if (error == -EAGAIN) {
 			list_del(&dev->power.entry);
-			list_add(&dev->power.entry, &dpm_off_irq);
+			list_add(&dev->power.entry, &tree->dpm_off_irq);
+			dev->current_list = DEVICE_LIST_DPM_OFF_IRQ;
 		} else {
 			printk(KERN_ERR "Could not suspend device %s: "
 				"error %d\n", kobject_name(&dev->kobj), error);
@@ -96,10 +98,15 @@ int device_suspend(pm_message_t state)
 	up(&dpm_sem);
 	return error;
  Error:
-	dpm_resume();
+	dpm_resume_tree(tree);
 	goto Done;
 }
+EXPORT_SYMBOL(device_suspend_tree);
 
+int device_suspend(pm_message_t state)
+{
+	return device_suspend_tree(state, &default_device_tree);
+}
 EXPORT_SYMBOL(device_suspend);
 
 
@@ -112,19 +119,17 @@ EXPORT_SYMBOL(device_suspend);
  *	done, power down system devices.
  */
 
-int device_power_down(pm_message_t state)
+int device_power_down_tree(pm_message_t state, struct partial_device_tree * tree)
 {
 	int error = 0;
 	struct device * dev;
 
-	list_for_each_entry_reverse(dev, &dpm_off_irq, power.entry) {
+	list_for_each_entry_reverse(dev, &tree->dpm_off_irq, power.entry) {
 		if ((error = suspend_device(dev, state)))
 			break;
 	}
 	if (error)
 		goto Error;
-	if ((error = sysdev_suspend(state)))
-		goto Error;
  Done:
 	return error;
  Error:
@@ -132,5 +137,14 @@ int device_power_down(pm_message_t state
 	goto Done;
 }
 
-EXPORT_SYMBOL(device_power_down);
+EXPORT_SYMBOL(device_power_down_tree);
 
+int device_power_down(pm_message_t state)
+{
+	int error;
+
+	if (!(error = device_power_down_tree(state, &default_device_tree)))
+		error = sysdev_suspend(state);
+	return error;
+}
+EXPORT_SYMBOL(device_power_down);
Only in 2.6.9/drivers/base/power: tree.c
diff -urp 2.6.9-lzf/drivers/base/sys.c 2.6.9/drivers/base/sys.c
--- 2.6.9-lzf/drivers/base/sys.c	2004-11-25 14:13:03.000000000 +0800
+++ 2.6.9/drivers/base/sys.c	2004-11-27 18:38:54.000000000 +0800
@@ -337,7 +337,7 @@ int sysdev_suspend(u32 state)
 	}
 	return 0;
 }
-
+EXPORT_SYMBOL(sysdev_suspend);
 
 /**
  *	sysdev_resume - Bring system devices back to life.
@@ -384,6 +384,7 @@ int sysdev_resume(void)
 	}
 	return 0;
 }
+EXPORT_SYMBOL(sysdev_resume);
 
 
 int __init system_bus_init(void)
-- 
--
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
