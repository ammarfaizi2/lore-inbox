Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbUKXNHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbUKXNHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262670AbUKXNFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:05:42 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:27796 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262633AbUKXNAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:00:35 -0500
Subject: Suspend2 merge: 1/51: Device trees
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101292600.5805.188.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Nov 2004 23:56:46 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows the device tree to be split up into multiple trees. I
don't really expect it to be merged, but it is an important part of
suspend at the moment, and I certainly want to see something like it
that will allow us to suspend some parts of the device tree and not
others. Suspend2 uses it to keep alive the hard drive (or equivalent)
that we're writing the image to while suspending other devices, thus
improving the consistency of the image written.

I remember from last time this was posted that someone commented on
exporting the default device tree; I haven't changed that yet.

diff -ruN 205-device-pm-trees-old/drivers/base/power/main.c 205-device-pm-trees-new/drivers/base/power/main.c
--- 205-device-pm-trees-old/drivers/base/power/main.c	2004-11-24 09:52:56.000000000 +1100
+++ 205-device-pm-trees-new/drivers/base/power/main.c	2004-11-24 19:48:29.133671960 +1100
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
 DECLARE_MUTEX(dpm_list_sem);
 
@@ -77,7 +88,9 @@
 		 dev->bus ? dev->bus->name : "No Bus", dev->kobj.name);
 	atomic_set(&dev->power.pm_users, 0);
 	down(&dpm_list_sem);
-	list_add_tail(&dev->power.entry, &dpm_active);
+	list_add_tail(&dev->power.entry, &default_device_tree.dpm_active);
+	dev->current_list = DEVICE_LIST_DPM_ACTIVE;
+	dev->tree = &default_device_tree;
 	device_pm_set_parent(dev, dev->parent);
 	if ((error = dpm_sysfs_add(dev)))
 		list_del(&dev->power.entry);
@@ -93,6 +106,7 @@
 	dpm_sysfs_remove(dev);
 	device_pm_release(dev->power.pm_parent);
 	list_del_init(&dev->power.entry);
+	dev->current_list = DEVICE_LIST_NONE;
 	up(&dpm_list_sem);
 }
 
diff -ruN 205-device-pm-trees-old/drivers/base/power/Makefile 205-device-pm-trees-new/drivers/base/power/Makefile
--- 205-device-pm-trees-old/drivers/base/power/Makefile	2004-11-03 21:51:55.000000000 +1100
+++ 205-device-pm-trees-new/drivers/base/power/Makefile	2004-11-24 19:48:29.134671808 +1100
@@ -1,5 +1,5 @@
 obj-y			:= shutdown.o
-obj-$(CONFIG_PM)	+= main.o suspend.o resume.o runtime.o sysfs.o
+obj-$(CONFIG_PM)	+= main.o suspend.o resume.o runtime.o sysfs.o tree.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
diff -ruN 205-device-pm-trees-old/drivers/base/power/power.h 205-device-pm-trees-new/drivers/base/power/power.h
--- 205-device-pm-trees-old/drivers/base/power/power.h	2004-11-24 09:52:56.000000000 +1100
+++ 205-device-pm-trees-new/drivers/base/power/power.h	2004-11-24 19:48:29.135671656 +1100
@@ -35,10 +35,22 @@
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
@@ -64,7 +76,9 @@
  * resume.c
  */
 
+extern void dpm_resume_tree(struct partial_device_tree * tree);
 extern void dpm_resume(void);
+extern void dpm_power_up_tree(struct partial_device_tree * tree);
 extern void dpm_power_up(void);
 extern int resume_device(struct device *);
 
diff -ruN 205-device-pm-trees-old/drivers/base/power/resume.c 205-device-pm-trees-new/drivers/base/power/resume.c
--- 205-device-pm-trees-old/drivers/base/power/resume.c	2004-11-24 09:52:56.000000000 +1100
+++ 205-device-pm-trees-new/drivers/base/power/resume.c	2004-11-24 19:48:29.136671504 +1100
@@ -29,16 +29,17 @@
 
 
 
-void dpm_resume(void)
+void dpm_resume_tree(struct partial_device_tree * tree)
 {
 	down(&dpm_list_sem);
-	while(!list_empty(&dpm_off)) {
-		struct list_head * entry = dpm_off.next;
+	while(!list_empty(&tree->dpm_off)) {
+		struct list_head * entry = tree->dpm_off.next;
 		struct device * dev = to_device(entry);
 
 		get_device(dev);
 		list_del_init(entry);
-		list_add_tail(entry, &dpm_active);
+		list_add_tail(entry, &tree->dpm_active);
+		dev->current_list = DEVICE_LIST_DPM_ACTIVE;
 
 		up(&dpm_list_sem);
 		if (!dev->power.prev_state)
@@ -50,6 +51,11 @@
 }
 
 
+void dpm_resume(void)
+{
+	dpm_resume_tree(&default_device_tree);
+}
+
 /**
  *	device_resume - Restore state of each device in system.
  *
@@ -66,6 +72,14 @@
 
 EXPORT_SYMBOL_GPL(device_resume);
 
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
@@ -78,20 +92,27 @@
  *	Interrupts must be disabled when calling this.
  */
 
-void dpm_power_up(void)
+void dpm_power_up_tree(struct partial_device_tree * tree)
 {
-	while(!list_empty(&dpm_off_irq)) {
-		struct list_head * entry = dpm_off_irq.next;
+	while(!list_empty(&tree->dpm_off_irq)) {
+		struct list_head * entry = tree->dpm_off_irq.next;
 		struct device * dev = to_device(entry);
 
 		get_device(dev);
 		list_del_init(entry);
-		list_add_tail(entry, &dpm_active);
+		list_add_tail(entry, &tree->dpm_active);
+		dev->current_list = DEVICE_LIST_DPM_ACTIVE;
 		resume_device(dev);
 		put_device(dev);
 	}
 }
+EXPORT_SYMBOL(dpm_power_up_tree);
+
 
+void dpm_power_up(void)
+{
+	dpm_power_up_tree(&default_device_tree);
+}
 
 /**
  *	device_pm_power_up - Turn on all devices that need special attention.
diff -ruN 205-device-pm-trees-old/drivers/base/power/shutdown.c 205-device-pm-trees-new/drivers/base/power/shutdown.c
--- 205-device-pm-trees-old/drivers/base/power/shutdown.c	2004-11-03 21:54:14.000000000 +1100
+++ 205-device-pm-trees-new/drivers/base/power/shutdown.c	2004-11-24 19:48:29.137671352 +1100
@@ -65,3 +65,4 @@
 	sysdev_shutdown();
 }
 
+EXPORT_SYMBOL(device_shutdown);
diff -ruN 205-device-pm-trees-old/drivers/base/power/suspend.c 205-device-pm-trees-new/drivers/base/power/suspend.c
--- 205-device-pm-trees-old/drivers/base/power/suspend.c	2004-11-24 09:52:56.000000000 +1100
+++ 205-device-pm-trees-new/drivers/base/power/suspend.c	2004-11-24 19:51:15.776338424 +1100
@@ -51,7 +51,7 @@
 
 
 /**
- *	device_suspend - Save state and stop all devices in system.
+ *	device_suspend_tree - Save state and stop all devices in system.
  *	@state:		Power state to put each device in.
  *
  *	Walk the dpm_active list, call ->suspend() for each device, and move
@@ -60,19 +60,19 @@
  *	the device to the dpm_off list. If it returns -EAGAIN, we move it to
  *	the dpm_off_irq list. If we get a different error, try and back out.
  *
- *	If we hit a failure with any of the devices, call device_resume()
+ *	If we hit a failure with any of the devices, call device_resume_tree()
  *	above to bring the suspended devices back to life.
  *
  */
 
-int device_suspend(u32 state)
+int device_suspend_tree(u32 state, struct partial_device_tree * tree)
 {
 	int error = 0;
 
 	down(&dpm_sem);
 	down(&dpm_list_sem);
-	while (!list_empty(&dpm_active) && error == 0) {
-		struct list_head * entry = dpm_active.prev;
+	while (!list_empty(&tree->dpm_active) && error == 0) {
+		struct list_head * entry = tree->dpm_active.prev;
 		struct device * dev = to_device(entry);
 
 		get_device(dev);
@@ -87,10 +87,12 @@
 			/* Move it to the dpm_off or dpm_off_irq list */
 			if (!error) {
 				list_del(&dev->power.entry);
-				list_add(&dev->power.entry, &dpm_off);
+				list_add(&dev->power.entry, &tree->dpm_off);
+				dev->current_list = DEVICE_LIST_DPM_OFF;
 			} else if (error == -EAGAIN) {
 				list_del(&dev->power.entry);
-				list_add(&dev->power.entry, &dpm_off_irq);
+				list_add(&dev->power.entry, &tree->dpm_off_irq);
+				dev->current_list = DEVICE_LIST_DPM_OFF_IRQ;
 				error = 0;
 			}
 		}
@@ -101,11 +103,17 @@
 	}
 	up(&dpm_list_sem);
 	if (error)
-		dpm_resume();
+		dpm_resume_tree(tree);
 	up(&dpm_sem);
 	return error;
 }
 
+EXPORT_SYMBOL(device_suspend_tree);
+
+int device_suspend(u32 state)
+{
+	return device_suspend_tree(state, &default_device_tree);
+}
 EXPORT_SYMBOL_GPL(device_suspend);
 
 
@@ -118,25 +126,28 @@
  *	done, power down system devices.
  */
 
-int device_power_down(u32 state)
+int device_power_down_tree(u32 state, struct partial_device_tree * tree)
 {
 	int error = 0;
 	struct device * dev;
 
-	list_for_each_entry_reverse(dev, &dpm_off_irq, power.entry) {
+	list_for_each_entry_reverse(dev, &tree->dpm_off_irq, power.entry) {
 		if ((error = suspend_device(dev, state)))
 			break;
 	}
 	if (error)
-		goto Error;
-	if ((error = sysdev_suspend(state)))
-		goto Error;
- Done:
+		dpm_power_up();
 	return error;
- Error:
-	dpm_power_up();
-	goto Done;
 }
 
-EXPORT_SYMBOL_GPL(device_power_down);
+EXPORT_SYMBOL_GPL(device_power_down_tree);
 
+int device_power_down(u32 state)
+{
+	int error;
+
+	if (!(error = device_power_down_tree(state, &default_device_tree)))
+		error = sysdev_suspend(state);
+	return error;
+}
+EXPORT_SYMBOL(device_power_down);
diff -ruN 205-device-pm-trees-old/drivers/base/power/tree.c 205-device-pm-trees-new/drivers/base/power/tree.c
--- 205-device-pm-trees-old/drivers/base/power/tree.c	1970-01-01 10:00:00.000000000 +1000
+++ 205-device-pm-trees-new/drivers/base/power/tree.c	2004-11-24 19:48:29.139671048 +1100
@@ -0,0 +1,105 @@
+/*
+ * suspend.c - Functions for moving devices between trees.
+ *
+ * Copyright (c) 2004 Nigel Cunningham
+ *
+ * This file is released under the GPLv2
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include "power.h"
+
+/*
+ *	device_merge_tree - Move an entire tree into another tree
+ *	@source: The tree to be moved
+ *	@dest  : The destination tree
+ */
+
+void device_merge_tree(	struct partial_device_tree * source,
+			struct partial_device_tree * dest)
+{
+	down(&dpm_sem);
+	list_splice_init(&source->dpm_active, &dest->dpm_active);
+	list_splice_init(&source->dpm_off, &dest->dpm_off);
+	list_splice_init(&source->dpm_off_irq, &dest->dpm_off_irq);
+	up(&dpm_sem);
+}
+EXPORT_SYMBOL(device_merge_tree);
+
+/*
+ * 	device_switch_trees - Move a device and its ancestors to a new tree
+ * 	@dev:	The lowest device to be moved.
+ * 	@tree:	The destination tree.
+ *
+ * 	Note that siblings can be left in the original tree. This is because
+ * 	we want to be able to keep part of a tree in one state while part is
+ * 	in another.
+ *
+ * 	Since we iterate all the way back to the top, and may move entries
+ * 	already in the destination tree, we will never violate the depth
+ * 	first property of the destination tree.
+ */
+
+void device_switch_trees(struct device * dev, struct partial_device_tree * tree)
+{
+	down(&dpm_sem);
+	while (dev) {
+		list_del(&dev->power.entry);
+		switch (dev->current_list) {
+			case DEVICE_LIST_DPM_ACTIVE:
+				list_add(&dev->power.entry, &tree->dpm_active);
+				break;
+			case DEVICE_LIST_DPM_OFF:
+				list_add(&dev->power.entry, &tree->dpm_off);
+				break;
+			case DEVICE_LIST_DPM_OFF_IRQ:
+				list_add(&dev->power.entry, &tree->dpm_off_irq);
+				break;
+		}
+			
+		dev = dev->parent;
+	}
+	up(&dpm_sem);
+}
+
+EXPORT_SYMBOL(device_switch_trees);
+
+/*
+ * 	create_device_tree - Create a new device tree
+ */
+
+struct partial_device_tree * device_create_tree(void)
+{
+	struct partial_device_tree * new_tree;
+
+	new_tree = (struct partial_device_tree *) 
+		kmalloc(sizeof(struct partial_device_tree),  GFP_ATOMIC);
+
+	if (!IS_ERR(new_tree)) {
+		INIT_LIST_HEAD(&new_tree->dpm_active);
+		INIT_LIST_HEAD(&new_tree->dpm_off);
+		INIT_LIST_HEAD(&new_tree->dpm_off_irq);
+	}
+
+	return new_tree;
+}
+EXPORT_SYMBOL(device_create_tree);
+
+/*
+ * 	device_destroy_tree - Destroy a dynamically created tree
+ */
+
+void device_destroy_tree(struct partial_device_tree * tree)
+{
+	BUG_ON(tree == &default_device_tree);
+	
+	BUG_ON(!list_empty(&tree->dpm_active));
+	BUG_ON(!list_empty(&tree->dpm_off));
+	BUG_ON(!list_empty(&tree->dpm_off_irq));
+
+	kfree(tree);
+}
+
+EXPORT_SYMBOL(device_destroy_tree);
diff -ruN 205-device-pm-trees-old/drivers/base/sys.c 205-device-pm-trees-new/drivers/base/sys.c
--- 205-device-pm-trees-old/drivers/base/sys.c	2004-11-24 09:52:56.000000000 +1100
+++ 205-device-pm-trees-new/drivers/base/sys.c	2004-11-24 19:48:29.140670896 +1100
@@ -337,7 +337,7 @@
 	}
 	return 0;
 }
-
+EXPORT_SYMBOL(sysdev_suspend);
 
 /**
  *	sysdev_resume - Bring system devices back to life.
@@ -384,6 +384,7 @@
 	}
 	return 0;
 }
+EXPORT_SYMBOL(sysdev_resume);
 
 
 int __init system_bus_init(void)
diff -ruN 205-device-pm-trees-old/include/linux/device.h 205-device-pm-trees-new/include/linux/device.h
--- 205-device-pm-trees-old/include/linux/device.h	2004-11-24 09:53:11.000000000 +1100
+++ 205-device-pm-trees-new/include/linux/device.h	2004-11-24 21:31:45.988606816 +1100
@@ -285,6 +285,11 @@
 					     override */
 
 	void	(*release)(struct device * dev);
+
+	struct partial_device_tree * tree; /* Which tree of devices this
+					      device is in */
+	int	current_list;		/* Which list within the tree the
+					   device is on (speeds moving) */
 };
 
 static inline struct device *
diff -ruN 205-device-pm-trees-old/include/linux/pm.h 205-device-pm-trees-new/include/linux/pm.h
--- 205-device-pm-trees-old/include/linux/pm.h	2004-11-24 09:53:11.000000000 +1100
+++ 205-device-pm-trees-new/include/linux/pm.h	2004-11-24 19:48:29.144670288 +1100
@@ -235,12 +235,25 @@
 
 extern void device_pm_set_parent(struct device * dev, struct device * parent);
 
+struct partial_device_tree;
+extern struct partial_device_tree default_device_tree;
+
 extern int device_suspend(u32 state);
+extern int device_suspend_tree(u32 state, struct partial_device_tree * tree);
 extern int device_power_down(u32 state);
+extern int device_power_down_tree(u32 state, struct partial_device_tree * tree);
 extern void device_power_up(void);
+extern void device_power_up_tree(struct partial_device_tree * tree);
 extern void device_resume(void);
-
-
+extern void device_resume_tree(struct partial_device_tree * tree);
+extern void device_merge_tree(	struct partial_device_tree * source,
+				struct partial_device_tree * dest);
+extern void device_switch_trees(struct device * dev, struct partial_device_tree * tree);
+extern void dpm_power_up_tree(struct partial_device_tree * tree);
+extern int sysdev_suspend(u32 state);
+extern int sysdev_resume(void);
+extern struct partial_device_tree * device_create_tree(void);
+extern void device_destroy_tree(struct partial_device_tree * tree);
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_PM_H */


