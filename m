Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267686AbUHENgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267686AbUHENgZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267685AbUHENgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:36:18 -0400
Received: from mail.tpgi.com.au ([203.12.160.103]:26293 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267680AbUHENeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:34:16 -0400
Subject: RFC: Device tree patch (support for partial tree suspend/resume)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Patrick Mochel <mochel@digitalimplant.org>
Content-Type: text/plain
Message-Id: <1091712854.2532.12.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 05 Aug 2004 23:34:14 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

As mentioned in a previous email on LKML, here's a patch I've written
which adds support for suspending and resuming portions of the device
tree. It's a simple extension of the current scheme: imagine the
dpm_active, dpm_off and dpm_irq_off lists as representing not
necessarily the whole tree but possibly just a portion of it. The
current device_suspend, device_resume... functions are retained, and
operate on this 'default_device_tree'. At runtime, however, new trees
can be created, devices and their ancestors moved to the new trees,
suspended and resumed separately to the main tree and then merged back
into the main tree when done with. New *_tree functions allow the
current suspend/resume/powerdown/powerup operations to be applied to
these dynamically created trees.

That's what the following patch does.

I've tested it using suspend2 and then pulled out the relevant portion.
If you want some sample usage, just say the word!

Regards,

Nigel

diff -ruN linux-2.6.8-rc3-mm1/drivers/base/power/main.c device-tree/drivers/base/power/main.c
--- linux-2.6.8-rc3-mm1/drivers/base/power/main.c	2004-07-30 16:51:59.000000000 +1000
+++ device-tree/drivers/base/power/main.c	2004-08-05 23:19:42.000000000 +1000
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
@@ -76,7 +87,9 @@
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
@@ -92,6 +105,7 @@
 	dpm_sysfs_remove(dev);
 	device_pm_release(dev->power.pm_parent);
 	list_del(&dev->power.entry);
+	dev->current_list = DEVICE_LIST_NONE;
 	up(&dpm_sem);
 }
 
diff -ruN linux-2.6.8-rc3-mm1/drivers/base/power/Makefile device-tree/drivers/base/power/Makefile
--- linux-2.6.8-rc3-mm1/drivers/base/power/Makefile	2004-04-17 03:21:03.000000000 +1000
+++ device-tree/drivers/base/power/Makefile	2004-08-05 23:19:42.000000000 +1000
@@ -1,5 +1,5 @@
 obj-y			:= shutdown.o
-obj-$(CONFIG_PM)	+= main.o suspend.o resume.o runtime.o sysfs.o
+obj-$(CONFIG_PM)	+= main.o suspend.o resume.o runtime.o sysfs.o tree.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
 EXTRA_CFLAGS += -DDEBUG
diff -ruN linux-2.6.8-rc3-mm1/drivers/base/power/power.h device-tree/drivers/base/power/power.h
--- linux-2.6.8-rc3-mm1/drivers/base/power/power.h	2004-07-30 16:51:59.000000000 +1000
+++ device-tree/drivers/base/power/power.h	2004-08-05 23:19:42.000000000 +1000
@@ -30,10 +30,22 @@
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
@@ -59,7 +71,9 @@
  * resume.c
  */
 
+extern void dpm_resume_tree(struct partial_device_tree * tree);
 extern void dpm_resume(void);
+extern void dpm_power_up_tree(struct partial_device_tree * tree);
 extern void dpm_power_up(void);
 extern int resume_device(struct device *);
 
diff -ruN linux-2.6.8-rc3-mm1/drivers/base/power/resume.c device-tree/drivers/base/power/resume.c
--- linux-2.6.8-rc3-mm1/drivers/base/power/resume.c	2004-07-30 16:51:59.000000000 +1000
+++ device-tree/drivers/base/power/resume.c	2004-08-05 23:20:43.000000000 +1000
@@ -29,20 +29,25 @@
 
 
 
-void dpm_resume(void)
+void dpm_resume_tree(struct partial_device_tree * tree)
 {
-	while(!list_empty(&dpm_off)) {
-		struct list_head * entry = dpm_off.next;
+	while(!list_empty(&tree->dpm_off)) {
+		struct list_head * entry = tree->dpm_off.next;
 		struct device * dev = to_device(entry);
 		list_del_init(entry);
 
 		if (!dev->power.prev_state)
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
@@ -60,6 +65,14 @@
 
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
@@ -72,17 +85,24 @@
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
 
 
+void dpm_power_up(void)
+{
+	dpm_power_up_tree(&default_device_tree);
+}
+
 /**
  *	device_pm_power_up - Turn on all devices that need special attention.
  *
@@ -97,6 +117,12 @@
 	dpm_power_up();
 }
 
+void device_power_up_tree(struct partial_device_tree * tree)
+{
+	sysdev_resume();
+	dpm_power_up_tree(tree);
+}
+
 EXPORT_SYMBOL(device_power_up);
 
 
diff -ruN linux-2.6.8-rc3-mm1/drivers/base/power/suspend.c device-tree/drivers/base/power/suspend.c
--- linux-2.6.8-rc3-mm1/drivers/base/power/suspend.c	2004-07-30 16:51:59.000000000 +1000
+++ device-tree/drivers/base/power/suspend.c	2004-08-05 23:19:42.000000000 +1000
@@ -51,7 +51,7 @@
 
 
 /**
- *	device_suspend - Save state and stop all devices in system.
+ *	device_suspend_tree - Save state and stop all devices in system.
  *	@state:		Power state to put each device in.
  *
  *	Walk the dpm_active list, call ->suspend() for each device, and move
@@ -60,7 +60,7 @@
  *	the device to the dpm_off list. If it returns -EAGAIN, we move it to
  *	the dpm_off_irq list. If we get a different error, try and back out.
  *
- *	If we hit a failure with any of the devices, call device_resume()
+ *	If we hit a failure with any of the devices, call device_resume_tree()
  *	above to bring the suspended devices back to life.
  *
  *	Note this function leaves dpm_sem held to
@@ -70,22 +70,24 @@
  *
  */
 
-int device_suspend(u32 state)
+int device_suspend_tree(u32 state, struct partial_device_tree * tree)
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
@@ -96,10 +98,15 @@
 	up(&dpm_sem);
 	return error;
  Error:
-	dpm_resume();
+	dpm_resume_tree(tree);
 	goto Done;
 }
+EXPORT_SYMBOL(device_suspend_tree);
 
+int device_suspend(u32 state)
+{
+	return device_suspend_tree(state, &default_device_tree);
+}
 EXPORT_SYMBOL(device_suspend);
 
 
@@ -112,12 +119,12 @@
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
@@ -131,6 +138,10 @@
 	dpm_power_up();
 	goto Done;
 }
+EXPORT_SYMBOL(device_power_down_tree);
 
+int device_power_down(u32 state)
+{
+	return device_power_down_tree(state, &default_device_tree);
+}
 EXPORT_SYMBOL(device_power_down);
-
diff -ruN linux-2.6.8-rc3-mm1/drivers/base/power/tree.c device-tree/drivers/base/power/tree.c
--- linux-2.6.8-rc3-mm1/drivers/base/power/tree.c	1970-01-01 10:00:00.000000000 +1000
+++ device-tree/drivers/base/power/tree.c	2004-08-05 23:19:42.000000000 +1000
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
diff -ruN linux-2.6.8-rc3-mm1/include/linux/device.h device-tree/include/linux/device.h
--- linux-2.6.8-rc3-mm1/include/linux/device.h	2004-08-05 20:46:16.000000000 +1000
+++ device-tree/include/linux/device.h	2004-08-05 23:19:42.000000000 +1000
@@ -289,6 +289,11 @@
 					     override */
 
 	void	(*release)(struct device * dev);
+
+	struct partial_device_tree * tree; /* Which tree of devices this
+					      device is in */
+	int	current_list;		/* Which list within the tree the
+					   device is on (speeds moving) */
 };
 
 static inline struct device *
diff -ruN linux-2.6.8-rc3-mm1/include/linux/pm.h device-tree/include/linux/pm.h
--- linux-2.6.8-rc3-mm1/include/linux/pm.h	2004-07-30 16:52:21.000000000 +1000
+++ device-tree/include/linux/pm.h	2004-08-05 23:19:42.000000000 +1000
@@ -241,12 +241,22 @@
 
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
+extern struct partial_device_tree * device_create_tree(void);
+extern void device_destroy_tree(struct partial_device_tree * tree);
 #endif /* __KERNEL__ */
 
 #endif /* _LINUX_PM_H */


