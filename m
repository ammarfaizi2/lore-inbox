Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbTDDTst (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 14:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbTDDTst (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 14:48:49 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:36260 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261281AbTDDTsK (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 14:48:10 -0500
Date: Fri, 4 Apr 2003 12:01:59 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Cc: kpfleming@cox.net
Subject: [RFC] kobject hotplug support for 2.5.66
Message-ID: <20030404200159.GA2430@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a patch against 2.5.66 that adds /sbin/hotplug support for
kobjects that are registered with a subsystem.  This allows partitions
in /sys/block to get hotplug calls.  The /sys/device/ hotplug calls were
also moved to use this logic, but the /sys/class/ hotplug call can not,
as it does not create new kobjects.

This work is based on work done by Kevin Fleming, who originally got the
hotplug support working for /sys/block.

Any comments or objections to me sending this on to Linus?

thanks,

greg k-h



diff -Nru a/arch/i386/kernel/edd.c b/arch/i386/kernel/edd.c
--- a/arch/i386/kernel/edd.c	Fri Apr  4 11:52:35 2003
+++ b/arch/i386/kernel/edd.c	Fri Apr  4 11:52:35 2003
@@ -598,7 +598,7 @@
 	.default_attrs	= def_attrs,
 };
 
-static decl_subsys(edd,&ktype_edd);
+static decl_subsys(edd,&ktype_edd,NULL);
 
 
 /**
diff -Nru a/drivers/acpi/bus.c b/drivers/acpi/bus.c
--- a/drivers/acpi/bus.c	Fri Apr  4 11:52:35 2003
+++ b/drivers/acpi/bus.c	Fri Apr  4 11:52:35 2003
@@ -676,7 +676,7 @@
 	return_VALUE(-ENODEV);
 }
 
-decl_subsys(acpi,NULL);
+decl_subsys(acpi,NULL,NULL);
 
 static int __init acpi_init (void)
 {
diff -Nru a/drivers/base/base.h b/drivers/base/base.h
--- a/drivers/base/base.h	Fri Apr  4 11:52:35 2003
+++ b/drivers/base/base.h	Fri Apr  4 11:52:35 2003
@@ -20,13 +20,8 @@
 
 
 #ifdef CONFIG_HOTPLUG
-extern int dev_hotplug(struct device *dev, const char *action);
 extern int class_hotplug(struct device *dev, const char *action);
 #else
-static inline int dev_hotplug(struct device *dev, const char *action)
-{
-	return 0;
-}
 static inline int class_hotplug(struct device *dev, const char *action)
 {
 	return 0;
diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Fri Apr  4 11:52:35 2003
+++ b/drivers/base/bus.c	Fri Apr  4 11:52:35 2003
@@ -132,7 +132,7 @@
 
 };
 
-decl_subsys(bus,&ktype_bus);
+decl_subsys(bus,&ktype_bus,NULL);
 
 /**
  *	bus_for_each_dev - device iterator.
diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Fri Apr  4 11:52:35 2003
+++ b/drivers/base/class.c	Fri Apr  4 11:52:35 2003
@@ -49,7 +49,9 @@
 	.sysfs_ops	= &class_sysfs_ops,
 };
 
-static decl_subsys(class,&ktype_devclass);
+/* Classes can't use the kobject hotplug logic, as
+ * they do not add new kobjects to the system */
+static decl_subsys(class,&ktype_devclass,NULL);
 
 
 static int devclass_dev_link(struct device_class * cls, struct device * dev)
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Fri Apr  4 11:52:35 2003
+++ b/drivers/base/core.c	Fri Apr  4 11:52:35 2003
@@ -23,13 +23,12 @@
 
 DECLARE_MUTEX(device_sem);
 
-#define to_dev(obj) container_of(obj,struct device,kobj)
-
 
 /*
  * sysfs bindings for devices.
  */
 
+#define to_dev(obj) container_of(obj,struct device,kobj)
 #define to_dev_attr(_attr) container_of(_attr,struct device_attribute,attr)
 
 extern struct attribute * dev_default_attrs[];
@@ -86,11 +85,55 @@
 	.default_attrs	= dev_default_attrs,
 };
 
+
+static int dev_hotplug_filter(struct kset *kset, struct kobject *kobj)
+{
+	struct kobj_type *ktype = get_ktype(kobj);
+
+	if (ktype == &ktype_device) {
+		struct device *dev = to_dev(kobj);
+		if (dev->bus)
+			return 1;
+	}
+	return 0;
+}
+
+static char *dev_hotplug_name(struct kset *kset, struct kobject *kobj)
+{
+	struct device *dev = to_dev(kobj);
+
+	return dev->bus->name;
+}
+
+static int dev_hotplug(struct kset *kset, struct kobject *kobj, char **envp,
+			int num_envp, char *buffer, int buffer_size)
+{
+	struct device *dev = to_dev(kobj);
+	int retval = 0;
+
+	if (dev->bus->hotplug) {
+		/* have the bus specific function add its stuff */
+		retval = dev->bus->hotplug (dev, envp, num_envp, buffer, buffer_size);
+			if (retval) {
+			pr_debug ("%s - hotplug() returned %d\n",
+				  __FUNCTION__, retval);
+		}
+	}
+
+	return retval;
+}
+
+static struct kset_hotplug_ops device_hotplug_ops = {
+	.filter =	dev_hotplug_filter,
+	.name =		dev_hotplug_name,
+	.hotplug =	dev_hotplug,
+};
+
 /**
  *	device_subsys - structure to be registered with kobject core.
  */
 
-decl_subsys(devices,&ktype_device);
+decl_subsys(devices, &ktype_device, &device_hotplug_ops);
 
 
 /**
@@ -192,9 +235,6 @@
 	if (platform_notify)
 		platform_notify(dev);
 
-	/* notify userspace of device entry */
-	dev_hotplug(dev, "add");
-
 	devclass_add_device(dev);
  register_done:
 	if (error && parent)
@@ -277,9 +317,6 @@
 	 */
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
-
-	/* notify userspace that this device is about to disappear */
-	dev_hotplug (dev, "remove");
 
 	bus_remove_device(dev);
 
diff -Nru a/drivers/base/firmware.c b/drivers/base/firmware.c
--- a/drivers/base/firmware.c	Fri Apr  4 11:52:35 2003
+++ b/drivers/base/firmware.c	Fri Apr  4 11:52:35 2003
@@ -6,7 +6,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-static decl_subsys(firmware,NULL);
+static decl_subsys(firmware,NULL,NULL);
 
 int firmware_register(struct subsystem * s)
 {
diff -Nru a/drivers/base/hotplug.c b/drivers/base/hotplug.c
--- a/drivers/base/hotplug.c	Fri Apr  4 11:52:35 2003
+++ b/drivers/base/hotplug.c	Fri Apr  4 11:52:35 2003
@@ -2,8 +2,8 @@
  * drivers/base/hotplug.c - hotplug call code
  * 
  * Copyright (c) 2000-2001 David Brownell
- * Copyright (c) 2002 Greg Kroah-Hartman
- * Copyright (c) 2002 IBM Corp.
+ * Copyright (c) 2002-2003 Greg Kroah-Hartman
+ * Copyright (c) 2002-2003 IBM Corp.
  *
  * Based off of drivers/usb/core/usb.c:call_agent(), which was 
  * written by David Brownell.
@@ -53,17 +53,6 @@
 	if (!hotplug_path [0])
 		return -ENODEV;
 
-	if (in_interrupt ()) {
-		pr_debug ("%s - in_interrupt, not allowed!", __FUNCTION__);
-		return -EIO;
-	}
-
-	if (!current->fs->root) {
-		/* don't try to do anything unless we have a root partition */
-		pr_debug ("%s - %s -- no FS yet\n", __FUNCTION__, action);
-		return -EIO;
-	}
-
 	envp = (char **) kmalloc (NUM_ENVP * sizeof (char *), GFP_KERNEL);
 	if (!envp)
 		return -ENOMEM;
@@ -127,23 +116,6 @@
 	kfree (envp);
 	return retval;
 }
-
-
-/*
- * dev_hotplug - called when any device is added or removed from a bus
- */
-int dev_hotplug (struct device *dev, const char *action)
-{
-	pr_debug ("%s\n", __FUNCTION__);
-	if (!dev)
-		return -ENODEV;
-
-	if (!dev->bus)
-		return -ENODEV;
-
-	return do_hotplug (dev, dev->bus->name, action, dev->bus->hotplug);
-}
-
 
 /*
  * class_hotplug - called when a class is added or removed from a device
diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	Fri Apr  4 11:52:35 2003
+++ b/drivers/block/genhd.c	Fri Apr  4 11:52:35 2003
@@ -525,9 +525,21 @@
 	.default_attrs	= default_attrs,
 };
 
+extern struct kobj_type ktype_part;
+
+static int block_hotplug_filter(struct kset *kset, struct kobject *kobj)
+{
+	struct kobj_type *ktype = get_ktype(kobj);
+
+	return ((ktype == &ktype_block) || (ktype == &ktype_part));
+}
+
+static struct kset_hotplug_ops block_hotplug_ops = {
+	.filter	= block_hotplug_filter,
+};
 
 /* declare block_subsys. */
-static decl_subsys(block,&ktype_block);
+static decl_subsys(block, &ktype_block, &block_hotplug_ops);
 
 
 struct gendisk *alloc_disk(int minors)
diff -Nru a/drivers/hotplug/pci_hotplug_core.c b/drivers/hotplug/pci_hotplug_core.c
--- a/drivers/hotplug/pci_hotplug_core.c	Fri Apr  4 11:52:35 2003
+++ b/drivers/hotplug/pci_hotplug_core.c	Fri Apr  4 11:52:35 2003
@@ -100,7 +100,7 @@
 	.sysfs_ops = &hotplug_slot_sysfs_ops
 };
 
-static decl_subsys(hotplug_slots, &hotplug_slot_ktype);
+static decl_subsys(hotplug_slots, &hotplug_slot_ktype, NULL);
 
 
 /* these strings match up with the values in pci_bus_speed */
diff -Nru a/fs/filesystems.c b/fs/filesystems.c
--- a/fs/filesystems.c	Fri Apr  4 11:52:35 2003
+++ b/fs/filesystems.c	Fri Apr  4 11:52:35 2003
@@ -61,7 +61,7 @@
 
 
 /* define fs_subsys */
-static decl_subsys(fs, NULL);
+static decl_subsys(fs, NULL, NULL);
 
 static int register_fs_subsys(struct file_system_type * fs)
 {
diff -Nru a/fs/partitions/check.c b/fs/partitions/check.c
--- a/fs/partitions/check.c	Fri Apr  4 11:52:35 2003
+++ b/fs/partitions/check.c	Fri Apr  4 11:52:35 2003
@@ -248,7 +248,7 @@
 
 extern struct subsystem block_subsys;
 
-static struct kobj_type ktype_part = {
+struct kobj_type ktype_part = {
 	.default_attrs	= default_attrs,
 	.sysfs_ops	= &part_sysfs_ops,
 };
diff -Nru a/include/linux/kobject.h b/include/linux/kobject.h
--- a/include/linux/kobject.h	Fri Apr  4 11:52:35 2003
+++ b/include/linux/kobject.h	Fri Apr  4 11:52:35 2003
@@ -57,12 +57,24 @@
  *	of object; multiple ksets can belong to one subsystem. All 
  *	ksets of a subsystem share the subsystem's lock.
  *
+ *      Each kset can support hotplugging; if it does, it will be given
+ *      the opportunity to filter out specific kobjects from being
+ *      reported, as well as to add its own "data" elements to the
+ *      environment being passed to the hotplug helper.
  */
+struct kset_hotplug_ops {
+	int (*filter)(struct kset *kset, struct kobject *kobj);
+	char *(*name)(struct kset *kset, struct kobject *kobj);
+	int (*hotplug)(struct kset *kset, struct kobject *kobj, char **envp,
+			int num_envp, char *buffer, int buffer_size);
+};
+
 struct kset {
 	struct subsystem	* subsys;
 	struct kobj_type	* ktype;
 	struct list_head	list;
 	struct kobject		kobj;
+	struct kset_hotplug_ops	* hotplug_ops;
 };
 
 
@@ -86,6 +98,13 @@
 	kobject_put(&k->kobj);
 }
 
+static inline struct kobj_type * get_ktype(struct kobject * k)
+{
+	if (k->kset && k->kset->ktype)
+		return k->kset->ktype;
+	else 
+		return k->ktype;
+}
 
 extern struct kobject * kset_find_obj(struct kset *, const char *);
 
@@ -95,11 +114,12 @@
 	struct rw_semaphore	rwsem;
 };
 
-#define decl_subsys(_name,_type) \
+#define decl_subsys(_name,_type,_hotplug_ops) \
 struct subsystem _name##_subsys = { \
 	.kset = { \
 		.kobj = { .name = __stringify(_name) }, \
 		.ktype = _type, \
+		.hotplug_ops =_hotplug_ops, \
 	} \
 }
 
diff -Nru a/lib/kobject.c b/lib/kobject.c
--- a/lib/kobject.c	Fri Apr  4 11:52:35 2003
+++ b/lib/kobject.c	Fri Apr  4 11:52:35 2003
@@ -11,14 +11,6 @@
 
 static spinlock_t kobj_lock = SPIN_LOCK_UNLOCKED;
 
-static inline struct kobj_type * get_ktype(struct kobject * k)
-{
-	if (k->kset && k->kset->ktype)
-		return k->kset->ktype;
-	else 
-		return k->ktype;
-}
-
 /**
  *	populate_dir - populate directory with attributes.
  *	@kobj:	object we're working on.
@@ -67,6 +59,140 @@
 }
 
 
+#ifdef CONFIG_HOTPLUG
+static int get_kobj_path_length(struct kset *kset, struct kobject *kobj)
+{
+	int length = 1;
+	struct kobject * parent = kobj;
+
+	/* walk up the ancestors until we hit the one pointing to the 
+	 * root.
+	 * Add 1 to strlen for leading '/' of each level.
+	 */
+	do {
+		length += strlen (parent->name) + 1;
+		parent = parent->parent;
+	} while (parent);
+	return length;
+}
+
+static void fill_kobj_path(struct kset *kset, struct kobject *kobj, char *path, int length)
+{
+	struct kobject * parent;
+
+	--length;
+	for (parent = kobj; parent; parent = parent->parent) {
+		int cur = strlen (parent->name);
+		/* back up enough to print this name with '/' */
+		length -= cur;
+		strncpy (path + length, parent->name, cur);
+		*(path + --length) = '/';
+	}
+
+	pr_debug("%s: path = '%s'\n",__FUNCTION__,path);
+}
+
+#define BUFFER_SIZE	1024	/* should be enough memory for the env */
+#define NUM_ENVP	32	/* number of env pointers */
+static void kset_hotplug(const char *action, struct kset *kset,
+			 struct kobject *kobj)
+{
+	char *argv [3];
+	char **envp;
+	char *buffer;
+	char *scratch;
+	int i = 0;
+	int retval;
+	int kobj_path_length;
+	char *kobj_path;
+	char *name = NULL;
+
+	/* If the kset has a filter operation, call it. If it returns
+	   failure, no hotplug event is required. */
+	if (kset->hotplug_ops->filter) {
+		if (!kset->hotplug_ops->filter(kset, kobj))
+			return;
+	}
+
+	pr_debug ("%s\n", __FUNCTION__);
+
+	if (!hotplug_path[0])
+		return;
+
+	envp = (char **)kmalloc(NUM_ENVP * sizeof (char *), GFP_KERNEL);
+	if (!envp)
+		return;
+	memset (envp, 0x00, NUM_ENVP * sizeof (char *));
+
+	buffer = kmalloc(BUFFER_SIZE, GFP_KERNEL);
+	if (!buffer) {
+		kfree(envp);
+		return;
+	}
+
+	if (kset->hotplug_ops->name)
+		name = kset->hotplug_ops->name(kset, kobj);
+	if (name == NULL)
+		name = kset->kobj.name;
+
+	argv [0] = hotplug_path;
+	argv [1] = name;
+	argv [2] = 0;
+
+	/* minimal command environment */
+	envp [i++] = "HOME=/";
+	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
+
+	scratch = buffer;
+
+	envp [i++] = scratch;
+	scratch += sprintf(scratch, "ACTION=%s", action) + 1;
+
+	kobj_path_length = get_kobj_path_length (kset, kobj);
+	kobj_path = kmalloc (kobj_path_length, GFP_KERNEL);
+	if (!kobj_path) {
+		kfree (buffer);
+		kfree (envp);
+		return;
+	}
+	memset (kobj_path, 0x00, kobj_path_length);
+	fill_kobj_path (kset, kobj, kobj_path, kobj_path_length);
+
+	envp [i++] = scratch;
+	scratch += sprintf (scratch, "DEVPATH=%s", kobj_path) + 1;
+
+	if (kset->hotplug_ops->hotplug) {
+		/* have the kset specific function add its stuff */
+		retval = kset->hotplug_ops->hotplug (kset, kobj,
+				  &envp[i], NUM_ENVP - i, scratch,
+				  BUFFER_SIZE - (scratch - buffer));
+		if (retval) {
+			pr_debug ("%s - hotplug() returned %d\n",
+				  __FUNCTION__, retval);
+			goto exit;
+		}
+	}
+
+	pr_debug ("%s: %s %s %s %s %s %s\n", __FUNCTION__, argv[0], argv[1],
+		  envp[0], envp[1], envp[2], envp[3]);
+	retval = call_usermodehelper (argv[0], argv, envp, 0);
+	if (retval)
+		pr_debug ("%s - call_usermodehelper returned %d\n",
+			  __FUNCTION__, retval);
+
+exit:
+	kfree (kobj_path);
+	kfree (buffer);
+	return;
+}
+#else
+static void kset_hotplug(const char *action, struct kset *kset,
+			 struct kobject *kobj)
+{
+	return 0;
+}
+#endif	/* CONFIG_HOTPLUG */
+
 /**
  *	kobject_init - initialize object.
  *	@kobj:	object in question.
@@ -111,6 +237,7 @@
 {
 	int error = 0;
 	struct kobject * parent;
+	struct kobject * top_kobj;
 
 	if (!(kobj = kobject_get(kobj)))
 		return -ENOENT;
@@ -134,6 +261,19 @@
 	error = create_dir(kobj);
 	if (error)
 		unlink(kobj);
+	else {
+		/* If this kobj does not belong to a kset,
+		   try to find a parent that does. */
+		top_kobj = kobj;
+		if (!top_kobj->kset && top_kobj->parent) {
+			do {
+				top_kobj = top_kobj->parent;
+			} while (!top_kobj->kset && top_kobj->parent);
+		}
+	
+		if (top_kobj->kset && top_kobj->kset->hotplug_ops)
+			kset_hotplug("add", top_kobj->kset, kobj);
+	}
 	return error;
 }
 
@@ -162,6 +302,20 @@
 
 void kobject_del(struct kobject * kobj)
 {
+	struct kobject * top_kobj;
+
+	/* If this kobj does not belong to a kset,
+	   try to find a parent that does. */
+	top_kobj = kobj;
+	if (!top_kobj->kset && top_kobj->parent) {
+		do {
+			top_kobj = top_kobj->parent;
+		} while (!top_kobj->kset && top_kobj->parent);
+	}
+
+	if (top_kobj->kset && top_kobj->kset->hotplug_ops)
+		kset_hotplug("remove", top_kobj->kset, kobj);
+
 	sysfs_remove_dir(kobj);
 	unlink(kobj);
 }
diff -Nru a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c	Fri Apr  4 11:52:35 2003
+++ b/net/core/dev.c	Fri Apr  4 11:52:35 2003
@@ -2811,7 +2811,7 @@
 extern void dv_init(void);
 #endif /* CONFIG_NET_DIVERT */
 
-static decl_subsys(net,NULL);
+static decl_subsys(net,NULL,NULL);
 
 
 /*
