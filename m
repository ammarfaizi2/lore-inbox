Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312823AbSCZXK3>; Tue, 26 Mar 2002 18:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312803AbSCZXKR>; Tue, 26 Mar 2002 18:10:17 -0500
Received: from air-2.osdl.org ([65.201.151.6]:57996 "EHLO segfault.osdl.org")
	by vger.kernel.org with ESMTP id <S312823AbSCZXJu>;
	Tue, 26 Mar 2002 18:09:50 -0500
Date: Tue, 26 Mar 2002 15:08:07 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
To: <linux-kernel@vger.kernel.org>
cc: <jgarzik@mandrakesoft.com>
Subject: [patch] Device model update (with power state transitions)
Message-ID: <Pine.LNX.4.33.0203261458000.3237-100000@segfault.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch does three things. 

(The first is not necessarily related to the other two, but the other two 
were created relative to the first, and it's otherwise innocuous).

1. Implements notion of 'system' bus, so system level devices can be added 
in a comon spot. This includes things like CPUs, PICs, timers, etc.

2. Adds all devices to an ordered global list. Nodes are inserted in a 
depth-first fashion, so that iterating over the list is equivalent to 
doing a depth-first walk of the tree; backwards equivalent to a 
breadth-first walk. This was done by Kai Germaschewski.

3. Adds the routines for power state transitions:

- device_suspend - forward iteration of list, calling suspend callback of 
  each node
- device_resume - backward iteration of list, calling resume callback of 
  each node
- device_shutdown - forward iteration of list, calling remove callback of 
  each node

This should provide the mechanism for replacing the reboot notifiers and 
doing properly ordered power management transtions. Comments welcome. 

Testing welcome also, though I wouldn't expect one to get very far, since 
they're not actually used. ;) Which, brings up another question - what 
would be the proper place to call device_shutdown()? (I haven't looked 
very far into that part...)

	-pat


	Pull from master.kernel.org:/home/mochel/BK/linux-2.5


diffstat results: 
 drivers/base/Makefile  |    4 -
 drivers/base/base.h    |   14 +++++
 drivers/base/core.c    |   39 ++++++---------
 drivers/base/power.c   |  122 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/sys.c     |   48 +++++++++++++++++++
 include/linux/device.h |   12 ++++
 6 files changed, 215 insertions, 24 deletions

ChangeSet
  1.541 02/03/26 14:26:46 mochel@segfault.osdl.org +3 -0
  Add device_{suspend,resume,shutdown} calls.

  include/linux/device.h
    1.10 02/03/26 14:26:45 mochel@segfault.osdl.org +5 -0
    add prototypes for device_{suspend,resume,shutdown}

  drivers/base/power.c
    1.2 02/03/26 14:26:45 mochel@segfault.osdl.org +122 -0
    Populate power.c with the suspend, resume, and shutdown walks of the global device list.

  drivers/base/Makefile
    1.3 02/03/26 14:26:45 mochel@segfault.osdl.org +2 -2
    Add power.o target.

ChangeSet
  1.540 02/03/26 14:12:38 mochel@segfault.osdl.org +4 -0
  Driver model update:
  Create global list in which all devices are inserted. Done by Kai Germaschewski.

  include/linux/device.h
    1.9 02/03/26 14:12:38 mochel@segfault.osdl.org +7 -0
    Add global list node to struct device
    Add static inline to get device from global list node
    (Done by Kai Germaschewski)

  drivers/base/core.c
    1.17 02/03/26 14:12:38 mochel@segfault.osdl.org +17 -22
    Include base.h
    Move some declarations to base.h
    Fix comment for put_device
    Insert device into global list when registering and remove when unregistering
    (Done by Kai Germaschewski).

  drivers/base/base.h
    1.2 02/03/26 14:12:38 mochel@segfault.osdl.org +14 -0
    add common header for all the drivers/base/ files to use.

  drivers/base/base.h
    1.1 02/03/26 13:52:25 mochel@segfault.osdl.org +0 -0

  drivers/base/base.h
    1.0 02/03/26 13:52:25 mochel@segfault.osdl.org +0 -0
    BitKeeper file /home/mochel/src/kernel/devel/linux-2.5-export/drivers/base/base.h

  drivers/base/power.c
    1.1 02/03/26 13:42:35 mochel@segfault.osdl.org +0 -0

  drivers/base/power.c
    1.0 02/03/26 13:42:35 mochel@segfault.osdl.org +0 -0
    BitKeeper file /home/mochel/src/kernel/devel/linux-2.5-export/drivers/base/power.c

ChangeSet
  1.539 02/03/26 09:51:26 mochel@segfault.osdl.org +1 -0
  Ok, really add drivers/base/sys.c

  drivers/base/sys.c
    1.2 02/03/26 09:51:26 mochel@segfault.osdl.org +48 -0
    Ok, really add the support for system buses.

ChangeSet
  1.538 02/03/26 09:49:57 mochel@segfault.osdl.org +3 -0
  Add concept of system bus, so system devices (CPUs, PICs, etc) can have a common home in the device tree.
  Add helper functions for {un,}registering.

  include/linux/device.h
    1.8 02/03/26 09:44:11 mochel@segfault.osdl.org +4 -0
    Add prototypes for {un,}register_sys_device().

  drivers/base/Makefile
    1.2 02/03/26 09:44:11 mochel@segfault.osdl.org +2 -2
    add sys.o target

  drivers/base/sys.c
    1.1 02/03/26 09:18:22 mochel@segfault.osdl.org +0 -0

  drivers/base/sys.c
    1.0 02/03/26 09:18:22 mochel@segfault.osdl.org +0 -0
    BitKeeper file /home/mochel/src/kernel/devel/linux-2.5-export/drivers/base/sys.c


diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile	Tue Mar 26 14:56:54 2002
+++ b/drivers/base/Makefile	Tue Mar 26 14:56:54 2002
@@ -1,7 +1,7 @@
 O_TARGET	:= base.o
 
-obj-y		:= core.o sys.o interface.o fs.o
+obj-y		:= core.o sys.o interface.o fs.o power.o
 
-export-objs	:= core.o sys.o interface.o fs.o 
+export-objs	:= $(obj-y)
 
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/base/base.h b/drivers/base/base.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/base/base.h	Tue Mar 26 14:56:54 2002
@@ -0,0 +1,14 @@
+#undef DEBUG
+
+#ifdef DEBUG
+# define DBG(x...) printk(x)
+#else
+# define DBG(x...)
+#endif
+
+extern struct device device_root;
+extern spinlock_t device_lock;
+
+extern int device_make_dir(struct device * dev);
+extern void device_remove_dir(struct device * dev);
+
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Tue Mar 26 14:56:54 2002
+++ b/drivers/base/core.c	Tue Mar 26 14:56:54 2002
@@ -10,16 +10,9 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/err.h>
+#include "base.h"
 
-#undef DEBUG
-
-#ifdef DEBUG
-# define DBG(x...) printk(x)
-#else
-# define DBG(x...)
-#endif
-
-static struct device device_root = {
+struct device device_root = {
 	bus_id:		"root",
 	name:		"System root",
 };
@@ -27,10 +20,7 @@
 int (*platform_notify)(struct device * dev) = NULL;
 int (*platform_notify_remove)(struct device * dev) = NULL;
 
-extern int device_make_dir(struct device * dev);
-extern void device_remove_dir(struct device * dev);
-
-static spinlock_t device_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t device_lock = SPIN_LOCK_UNLOCKED;
 
 /**
  * device_register - register a device
@@ -39,10 +29,14 @@
  * First, make sure that the device has a parent, create
  * a directory for it, then add it to the parent's list of
  * children.
+ *
+ * Maintains a global list of all devices, in depth-first ordering.
+ * The head for that list is device_root.g_list.
  */
 int device_register(struct device *dev)
 {
 	int error;
+	struct device *prev_dev;
 
 	if (!dev || !strlen(dev->bus_id))
 		return -EINVAL;
@@ -50,6 +44,7 @@
 	spin_lock(&device_lock);
 	INIT_LIST_HEAD(&dev->node);
 	INIT_LIST_HEAD(&dev->children);
+	INIT_LIST_HEAD(&dev->g_list);
 	spin_lock_init(&dev->lock);
 	atomic_set(&dev->refcount,2);
 
@@ -57,6 +52,13 @@
 		if (!dev->parent)
 			dev->parent = &device_root;
 		get_device(dev->parent);
+
+		if (list_empty(&dev->parent->children))
+			prev_dev = dev->parent;
+		else
+			prev_dev = list_entry(dev->parent->children.prev, struct device, node);
+		list_add(&dev->g_list, &prev_dev->g_list);
+
 		list_add_tail(&dev->node,&dev->parent->children);
 	}
 	spin_unlock(&device_lock);
@@ -79,22 +81,15 @@
 }
 
 /**
- * put_device - clean up device
+ * put_device - decrement reference count, and clean up when it hits 0
  * @dev:	device in question
- *
- * Decrement reference count for device.
- * If it hits 0, we need to clean it up.
- * However, we may be here in interrupt context, and it may
- * take some time to do proper clean up (removing files, calling
- * back down to device to clean up everything it has).
- * So, we remove it from its parent's list and add it to the list of
- * devices to be cleaned up.
  */
 void put_device(struct device * dev)
 {
 	if (!atomic_dec_and_lock(&dev->refcount,&device_lock))
 		return;
 	list_del_init(&dev->node);
+	list_del_init(&dev->g_list);
 	spin_unlock(&device_lock);
 
 	DBG("DEV: Unregistering device. ID = '%s', name = '%s'\n",
diff -Nru a/drivers/base/power.c b/drivers/base/power.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/base/power.c	Tue Mar 26 14:56:54 2002
@@ -0,0 +1,122 @@
+/*
+ * power.c - power management functions for the device tree.
+ * 
+ * Copyright (c) 2002 Patrick Mochel
+ *		 2002 Open Source Development Lab
+ * 
+ *  Kai Germaschewski contributed to the list walking routines.
+ *
+ * FIXME: The suspend and shutdown walks are identical. The resume walk
+ * is simply walking the list backward. Anyway we can combine these (cleanly)?
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include "base.h"
+
+/**
+ * device_suspend - suspend all devices on the device tree
+ * @state:	state we're entering
+ * @level:	what stage of the suspend process we're at 
+ * 
+ * The entries in the global device list are inserted such that they're in a 
+ * depth-first ordering. So, simply iterate over the list, and call the driver's
+ * suspend callback for each device.
+ */
+int device_suspend(u32 state, u32 level)
+{
+	struct device * dev;
+	struct device * prev = &device_root;
+	int error = 0;
+
+	get_device(prev);
+
+	spin_lock(&device_lock);
+	dev = g_list_to_dev(prev->g_list.next);
+	while(dev != &device_root && !error) {
+		get_device(dev);
+		spin_unlock(&device_lock);
+		put_device(prev);
+
+		if (dev->driver && dev->driver->suspend)
+			error = dev->driver->suspend(dev,state,level);
+
+		spin_lock(&device_lock);
+		prev = dev;
+		dev = g_list_to_dev(prev->g_list.next);
+	}
+	spin_unlock(&device_root);
+	put_device(prev);
+
+	return error;
+}
+
+/**
+ * device_resume - resume all the devices in the system
+ * @level:	stage of resume process we're at 
+ * 
+ * Similar to device_suspend above, though we want to do a breadth-first
+ * walk of the tree to make sure we wake up parents before children.
+ * So, we iterate over the list backward. 
+ */
+void device_resume(u32 level)
+{
+	struct device * dev;
+	struct device * prev = &device_root;
+
+	get_device(prev);
+
+	spin_lock(&device_lock);
+	dev = g_list_to_dev(prev->g_list.prev);
+	while(dev != &device_root) {
+		get_device(dev);
+		spin_unlock(&device_lock);
+		put_device(prev);
+
+		if (dev->driver && dev->driver->resume)
+			dev->driver->resume(dev,level);
+
+		spin_lock(&device_lock);
+		prev = dev;
+		dev = g_list_to_dev(prev->g_list.prev);
+	}
+	spin_unlock(&device_root);
+	put_device(prev);
+}
+
+/**
+ * device_shutdown - queisce all the devices before reboot/shutdown
+ *
+ * Do depth first iteration over device tree, calling ->remove() for each
+ * device. This should ensure the devices are put into a sane state before
+ * we reboot the system.
+ *
+ */
+void device_shutdown(void)
+{
+	struct device * dev;
+	struct device * prev = &device_root;
+
+	get_device(prev);
+
+	spin_lock(&device_lock);
+	dev = g_list_to_dev(prev->g_list.next);
+	while(dev != &device_root) {
+		get_device(dev);
+		spin_unlock(&device_lock);
+		put_device(prev);
+
+		if (dev->driver && dev->driver->remove)
+			dev->driver->remove(dev,REMOVE_FREE_RESOURCES);
+
+		spin_lock(&device_lock);
+		prev = dev;
+		dev = g_list_to_dev(prev->g_list.next);
+	}
+	spin_unlock(&device_root);
+	put_device(prev);
+}
+
+EXPORT_SYMBOL(device_suspend);
+EXPORT_SYMBOL(device_resume);
+EXPORT_SYMBOL(device_shutdown);
diff -Nru a/drivers/base/sys.c b/drivers/base/sys.c
--- a/drivers/base/sys.c	Tue Mar 26 14:56:54 2002
+++ b/drivers/base/sys.c	Tue Mar 26 14:56:54 2002
@@ -0,0 +1,48 @@
+/*
+ * sys.c - pseudo-bus for system 'devices' (cpus, PICs, timers, etc)
+ *
+ * Copyright (c) 2002 Patrick Mochel
+ *              2002 Open Source Development Lab
+ * 
+ * This exports a 'system' bus type. 
+ * By default, a 'sys' bus gets added to the root of the system. There will
+ * always be core system devices. Devices can use register_sys_device() to
+ * add themselves as children of the system bus.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+
+static struct device system_bus = {
+       name:           "System Bus",
+       bus_id:         "sys",
+};
+
+int register_sys_device(struct device * dev)
+{
+       int error = -EINVAL;
+
+       if (dev) {
+               if (!dev->parent)
+                       dev->parent = &system_bus;
+               error = device_register(dev);
+       }
+       return error;
+}
+
+void unregister_sys_device(struct device * dev)
+{
+       if (dev)
+               put_device(dev);
+}
+
+static int sys_bus_init(void)
+{
+       return device_register(&system_bus);
+}
+
+subsys_initcall(sys_bus_init);
+EXPORT_SYMBOL(register_sys_device);
+EXPORT_SYMBOL(unregister_sys_device);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Mar 26 14:56:54 2002
+++ b/include/linux/device.h	Tue Mar 26 14:56:54 2002
@@ -64,6 +64,7 @@
 };
 
 struct device {
+	struct list_head g_list;        /* node in depth-first order list */
 	struct list_head node;		/* node in sibling list */
 	struct list_head children;
 	struct device 	* parent;
@@ -99,6 +100,12 @@
 	return list_entry(node, struct device, node);
 }
 
+static inline struct device *
+g_list_to_dev(struct list_head *g_list)
+{
+	return list_entry(g_list, struct device, g_list);
+}
+
 /*
  * High level routines for use by the bus drivers
  */
@@ -146,5 +153,10 @@
 /* drivers/base/sys.c */
 extern int register_sys_device(struct device * dev);
 extern void unregister_sys_device(struct device * dev);
+
+/* drivers/base/power.c */
+extern int device_suspend(u32 state, u32 level);
+extern void device_resume(u32 level);
+extern void device_shutdown(void);
 
 #endif /* _DEVICE_H_ */

