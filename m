Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263862AbTDVUu5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 16:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263876AbTDVUuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 16:50:15 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:32713 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263862AbTDVUpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 16:45:49 -0400
Date: Tue, 22 Apr 2003 13:57:19 -0700
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Cc: hannal@us.ibm.com, andmike@us.ibm.com
Subject: [RFC] Device class rework [1/5]
Message-ID: <20030422205719.GB4701@kroah.com>
References: <20030422205545.GA4701@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422205545.GA4701@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, these are all against a clean 2.5.68, sorry to not note that, last
message.

On Tue, Apr 22, 2003 at 01:55:45PM -0700, Greg KH wrote:
>  - all of the driver core conversions.  This is the meat of the
>    changes.


diff -Nru a/drivers/base/Makefile b/drivers/base/Makefile
--- a/drivers/base/Makefile	Tue Apr 22 13:08:01 2003
+++ b/drivers/base/Makefile	Tue Apr 22 13:08:01 2003
@@ -1,8 +1,6 @@
 # Makefile for the Linux device tree
 
 obj-y			:= core.o sys.o interface.o power.o bus.o \
-			   driver.o class.o intf.o platform.o \
+			   driver.o class.o platform.o \
 			   cpu.o firmware.o init.o
 obj-$(CONFIG_NUMA)	+= node.o  memblk.o
-obj-y			+= fs/
-obj-$(CONFIG_HOTPLUG)	+= hotplug.o
diff -Nru a/drivers/base/base.h b/drivers/base/base.h
--- a/drivers/base/base.h	Tue Apr 22 13:07:57 2003
+++ b/drivers/base/base.h	Tue Apr 22 13:07:57 2003
@@ -1,28 +1,8 @@
 extern struct semaphore device_sem;
-extern struct semaphore devclass_sem;
 
 extern int bus_add_device(struct device * dev);
 extern void bus_remove_device(struct device * dev);
 
 extern int bus_add_driver(struct device_driver *);
 extern void bus_remove_driver(struct device_driver *);
-
-extern int devclass_add_device(struct device *);
-extern void devclass_remove_device(struct device *);
-
-extern int devclass_add_driver(struct device_driver *);
-extern void devclass_remove_driver(struct device_driver *);
-
-extern int interface_add_dev(struct device *);
-extern void interface_remove_dev(struct device *);
-
-
-#ifdef CONFIG_HOTPLUG
-extern int class_hotplug(struct device *dev, const char *action);
-#else
-static inline int class_hotplug(struct device *dev, const char *action)
-{
-	return 0;
-}
-#endif
 
diff -Nru a/drivers/base/bus.c b/drivers/base/bus.c
--- a/drivers/base/bus.c	Tue Apr 22 13:07:50 2003
+++ b/drivers/base/bus.c	Tue Apr 22 13:07:50 2003
@@ -311,8 +311,7 @@
  *	Walk the list of devices that the bus has on it and try to match
  *	the driver with each one.
  *	If bus_match() returns 0 and the @dev->driver is set, we've found
- *	a compatible pair, so we call devclass_add_device() to add the 
- *	device to the class. 
+ *	a compatible pair.
  *
  *	Note that we ignore the error from bus_match(), since it's perfectly
  *	valid for a driver not to bind to any devices.
@@ -328,8 +327,7 @@
 	list_for_each(entry,&bus->devices.list) {
 		struct device * dev = container_of(entry,struct device,bus_list);
 		if (!dev->driver) {
-			if (!bus_match(dev,drv))
-				devclass_add_device(dev);
+			bus_match(dev,drv);
 		}
 	}
 }
@@ -351,7 +349,6 @@
 	if (drv) {
 		sysfs_remove_link(&drv->kobj,dev->kobj.name);
 		list_del_init(&dev->driver_list);
-		devclass_remove_device(dev);
 		if (drv->remove)
 			drv->remove(dev);
 		dev->driver = NULL;
@@ -443,8 +440,7 @@
 		}
 
 		down_write(&bus->subsys.rwsem);
-		if (!(error = devclass_add_driver(drv)))
-			driver_attach(drv);
+		driver_attach(drv);
 		up_write(&bus->subsys.rwsem);
 
 		if (error) {
@@ -471,7 +467,6 @@
 		down_write(&drv->bus->subsys.rwsem);
 		pr_debug("bus %s: remove driver %s\n",drv->bus->name,drv->name);
 		driver_detach(drv);
-		devclass_remove_driver(drv);
 		up_write(&drv->bus->subsys.rwsem);
 		kobject_unregister(&drv->kobj);
 		put_bus(drv->bus);
diff -Nru a/drivers/base/class.c b/drivers/base/class.c
--- a/drivers/base/class.c	Tue Apr 22 13:08:03 2003
+++ b/drivers/base/class.c	Tue Apr 22 13:08:03 2003
@@ -10,16 +10,16 @@
 #include <linux/string.h>
 #include "base.h"
 
-#define to_class_attr(_attr) container_of(_attr,struct devclass_attribute,attr)
-#define to_class(obj) container_of(obj,struct device_class,subsys.kset.kobj)
+#define to_class_attr(_attr) container_of(_attr,struct class_attribute,attr)
+#define to_class(obj) container_of(obj,struct class,subsys.kset.kobj)
 
-DECLARE_MUTEX(devclass_sem);
+DECLARE_MUTEX(class_dev_sem);
 
 static ssize_t
-devclass_attr_show(struct kobject * kobj, struct attribute * attr, char * buf)
+class_attr_show(struct kobject * kobj, struct attribute * attr, char * buf)
 {
-	struct devclass_attribute * class_attr = to_class_attr(attr);
-	struct device_class * dc = to_class(kobj);
+	struct class_attribute * class_attr = to_class_attr(attr);
+	struct class * dc = to_class(kobj);
 	ssize_t ret = 0;
 
 	if (class_attr->show)
@@ -28,11 +28,11 @@
 }
 
 static ssize_t
-devclass_attr_store(struct kobject * kobj, struct attribute * attr, 
-		    const char * buf, size_t count)
+class_attr_store(struct kobject * kobj, struct attribute * attr, 
+		 const char * buf, size_t count)
 {
-	struct devclass_attribute * class_attr = to_class_attr(attr);
-	struct device_class * dc = to_class(kobj);
+	struct class_attribute * class_attr = to_class_attr(attr);
+	struct class * dc = to_class(kobj);
 	ssize_t ret = 0;
 
 	if (class_attr->store)
@@ -41,242 +41,369 @@
 }
 
 static struct sysfs_ops class_sysfs_ops = {
-	.show	= devclass_attr_show,
-	.store	= devclass_attr_store,
+	.show	= class_attr_show,
+	.store	= class_attr_store,
 };
 
-static struct kobj_type ktype_devclass = {
+static struct kobj_type ktype_class = {
 	.sysfs_ops	= &class_sysfs_ops,
 };
 
-/* Classes can't use the kobject hotplug logic, as
- * they do not add new kobjects to the system */
-static decl_subsys(class,&ktype_devclass,NULL);
+/* Hotplug events for classes go to the class_obj subsys */
+static decl_subsys(class,&ktype_class,NULL);
 
 
-static int devclass_dev_link(struct device_class * cls, struct device * dev)
+int class_create_file(struct class * cls, struct class_attribute * attr)
 {
-	char	linkname[16];
-	snprintf(linkname,16,"%u",dev->class_num);
-	return sysfs_create_link(&cls->devices.kobj,&dev->kobj,linkname);
+	int error;
+	if (cls) {
+		error = sysfs_create_file(&cls->subsys.kset.kobj,&attr->attr);
+	} else
+		error = -EINVAL;
+	return error;
 }
 
-static void devclass_dev_unlink(struct device_class * cls, struct device * dev)
+void class_remove_file(struct class * cls, struct class_attribute * attr)
 {
-	char	linkname[16];
-	snprintf(linkname,16,"%u",dev->class_num);
-	sysfs_remove_link(&cls->devices.kobj,linkname);
+	if (cls)
+		sysfs_remove_file(&cls->subsys.kset.kobj,&attr->attr);
 }
 
-static int devclass_drv_link(struct device_driver * drv)
+struct class * class_get(struct class * cls)
 {
-	char	name[KOBJ_NAME_LEN * 3];
-	snprintf(name,KOBJ_NAME_LEN * 3,"%s:%s",drv->bus->name,drv->name);
-	return sysfs_create_link(&drv->devclass->drivers.kobj,&drv->kobj,name);
+	if (cls)
+		return container_of(subsys_get(&cls->subsys),struct class,subsys);
+	return NULL;
 }
 
-static void devclass_drv_unlink(struct device_driver * drv)
+void class_put(struct class * cls)
 {
-	char	name[KOBJ_NAME_LEN * 3];
-	snprintf(name,KOBJ_NAME_LEN * 3,"%s:%s",drv->bus->name,drv->name);
-	return sysfs_remove_link(&drv->devclass->drivers.kobj,name);
+	subsys_put(&cls->subsys);
 }
 
+int class_register(struct class * cls)
+{
+	pr_debug("device class '%s': registering\n",cls->name);
 
-int devclass_create_file(struct device_class * cls, struct devclass_attribute * attr)
+	INIT_LIST_HEAD(&cls->children);
+	INIT_LIST_HEAD(&cls->interfaces);
+	
+	strncpy(cls->subsys.kset.kobj.name,cls->name,KOBJ_NAME_LEN);
+	subsys_set_kset(cls,class_subsys);
+	subsystem_register(&cls->subsys);
+
+	return 0;
+}
+
+void class_unregister(struct class * cls)
 {
-	int error;
-	if (cls) {
-		error = sysfs_create_file(&cls->subsys.kset.kobj,&attr->attr);
-	} else
-		error = -EINVAL;
+	pr_debug("device class '%s': unregistering\n",cls->name);
+	subsystem_unregister(&cls->subsys);
+}
+
+/* Class Device Stuff */
+
+int class_device_create_file(struct class_device * class_dev,
+			     struct class_device_attribute * attr)
+{
+	int error = -EINVAL;
+	if (class_dev)
+		error = sysfs_create_file(&class_dev->kobj, &attr->attr);
 	return error;
 }
 
-void devclass_remove_file(struct device_class * cls, struct devclass_attribute * attr)
+void class_device_remove_file(struct class_device * class_dev,
+			      struct class_device_attribute * attr)
 {
-	if (cls)
-		sysfs_remove_file(&cls->subsys.kset.kobj,&attr->attr);
+	if (class_dev)
+		sysfs_remove_file(&class_dev->kobj, &attr->attr);
 }
 
+static int class_device_dev_link(struct class_device * class_dev)
+{
+	if (class_dev->dev)
+		return sysfs_create_link(&class_dev->kobj,
+					 &class_dev->dev->kobj, "device");
+	return 0;
+}
 
-int devclass_add_driver(struct device_driver * drv)
+static void class_device_dev_unlink(struct class_device * class_dev)
 {
-	struct device_class * cls = get_devclass(drv->devclass);
-	int error = 0;
+	if (class_dev->dev)
+		sysfs_remove_link(&class_dev->kobj, "device");
+}
 
-	if (cls) {
-		down_write(&cls->subsys.rwsem);
-		pr_debug("device class %s: adding driver %s:%s\n",
-			 cls->name,drv->bus->name,drv->name);
-		error = devclass_drv_link(drv);
-		
-		if (!error)
-			list_add_tail(&drv->class_list,&cls->drivers.list);
-		up_write(&cls->subsys.rwsem);
-	}
-	return error;
+#define to_class_dev(obj) container_of(obj,struct class_device,kobj)
+#define to_class_dev_attr(_attr) container_of(_attr,struct class_device_attribute,attr)
+
+static ssize_t
+class_device_attr_show(struct kobject * kobj, struct attribute * attr,
+		       char * buf)
+{
+	struct class_device_attribute * class_dev_attr = to_class_dev_attr(attr);
+	struct class_device * cd = to_class_dev(kobj);
+	ssize_t ret = 0;
+
+	if (class_dev_attr->show)
+		ret = class_dev_attr->show(cd,buf);
+	return ret;
 }
 
-void devclass_remove_driver(struct device_driver * drv)
+static ssize_t
+class_device_attr_store(struct kobject * kobj, struct attribute * attr, 
+			const char * buf, size_t count)
 {
-	struct device_class * cls = drv->devclass;
-	if (cls) {
-		down_write(&cls->subsys.rwsem);
-		pr_debug("device class %s: removing driver %s:%s\n",
-			 cls->name,drv->bus->name,drv->name);
-		list_del_init(&drv->class_list);
-		devclass_drv_unlink(drv);
-		up_write(&cls->subsys.rwsem);
-		put_devclass(cls);
-	}
+	struct class_device_attribute * class_dev_attr = to_class_dev_attr(attr);
+	struct class_device * cd = to_class_dev(kobj);
+	ssize_t ret = 0;
+
+	if (class_dev_attr->store)
+		ret = class_dev_attr->store(cd,buf,count);
+	return ret;
 }
 
+static struct sysfs_ops class_dev_sysfs_ops = {
+	.show	= class_device_attr_show,
+	.store	= class_device_attr_store,
+};
+
+static struct kobj_type ktype_class_device = {
+	.sysfs_ops	= &class_dev_sysfs_ops,
+};
 
-static void enum_device(struct device_class * cls, struct device * dev)
+static int class_hotplug_filter(struct kset *kset, struct kobject *kobj)
 {
-	u32 val;
-	val = cls->devnum++;
-	dev->class_num = val;
-	devclass_dev_link(cls,dev);
-}
-
-static void unenum_device(struct device_class * cls, struct device * dev)
-{
-	devclass_dev_unlink(cls,dev);
-	dev->class_num = 0;
-}
-
-/**
- *	devclass_add_device - register device with device class
- *	@dev:   device to be registered 
- *
- *	This is called when a device is either registered with the 
- *	core, or after the a driver module is loaded and bound to
- *	the device. 
- *	The class is determined by looking at @dev's driver, so one
- *	way or another, it must be bound to something. Once the 
- *	class is determined, it's set to prevent against concurrent
- *	calls for the same device stomping on each other. 
- *
- *	/sbin/hotplug should be called once the device is added to 
- *	class and all the interfaces. 
- */
-int devclass_add_device(struct device * dev)
-{
-	struct device_class * cls;
-	int error = 0;
-
-	down(&devclass_sem);
-	if (dev->driver) {
-		cls = get_devclass(dev->driver->devclass);
-
-		if (!cls)
-			goto Done;
-
-		pr_debug("device class %s: adding device %s\n",
-			 cls->name,dev->name);
-		if (cls->add_device) 
-			error = cls->add_device(dev);
-		if (error) {
-			put_devclass(cls);
-			goto Done;
-		}
+	struct kobj_type *ktype = get_ktype(kobj);
+
+	if (ktype == &ktype_class_device) {
+		struct class_device *class_dev = to_class_dev(kobj);
+		if (class_dev->class)
+			return 1;
+	}
+	return 0;
+}
+
+static char *class_hotplug_name(struct kset *kset, struct kobject *kobj)
+{
+	struct class_device *class_dev = to_class_dev(kobj);
 
-		down_write(&cls->subsys.rwsem);
-		enum_device(cls,dev);
-		list_add_tail(&dev->class_list,&cls->devices.list);
-		/* notify userspace (call /sbin/hotplug) */
-		class_hotplug (dev, "add");
+	return class_dev->class->name;
+}
 
-		up_write(&cls->subsys.rwsem);
+static int class_hotplug(struct kset *kset, struct kobject *kobj, char **envp,
+			 int num_envp, char *buffer, int buffer_size)
+{
+	struct class_device *class_dev = to_class_dev(kobj);
+	int retval = 0;
 
-		interface_add_dev(dev);
+	pr_debug("%s - name = %s\n", __FUNCTION__, class_dev->class_id);
+	if (class_dev->class->hotplug) {
+		/* have the bus specific function add its stuff */
+		retval = class_dev->class->hotplug (class_dev, envp, num_envp,
+						    buffer, buffer_size);
+			if (retval) {
+			pr_debug ("%s - hotplug() returned %d\n",
+				  __FUNCTION__, retval);
+		}
 	}
- Done:
-	up(&devclass_sem);
-	return error;
+
+	return retval;
 }
 
-void devclass_remove_device(struct device * dev)
+static struct kset_hotplug_ops class_hotplug_ops = {
+	.filter =	class_hotplug_filter,
+	.name =		class_hotplug_name,
+	.hotplug =	class_hotplug,
+};
+
+static decl_subsys(class_obj, &ktype_class_device, &class_hotplug_ops);
+
+void class_device_initialize(struct class_device *class_dev)
 {
-	struct device_class * cls;
+	kobject_init(&class_dev->kobj);
+	INIT_LIST_HEAD(&class_dev->node);
+}
 
-	down(&devclass_sem);
-	if (dev->driver) {
-		cls = dev->driver->devclass;
-		if (!cls) 
-			goto Done;
+int class_device_add(struct class_device *class_dev)
+{
+	struct class * parent;
+	struct class_interface * class_intf;
+	struct list_head * entry;
+	int error;
 
-		interface_remove_dev(dev);
+	class_dev = class_device_get(class_dev);
+	if (!class_dev || !strlen(class_dev->class_id))
+		return -EINVAL;
+
+	parent = class_get(class_dev->class);
+	if (class_dev->dev)
+		get_device(class_dev->dev);
+
+	pr_debug("CLASS: registering class device: ID = '%s'\n",
+		 class_dev->class_id);
+
+	/* first, register with generic layer. */
+	strncpy(class_dev->kobj.name, class_dev->class_id, KOBJ_NAME_LEN);
+	kobj_set_kset_s(class_dev, class_subsys);
+	kobj_set_kset_s(class_dev, class_obj_subsys);
+	if (parent)
+		class_dev->kobj.parent = &parent->subsys.kset.kobj;
+
+	if ((error = kobject_add(&class_dev->kobj)))
+		goto register_done;
+
+	/* now take care of our own registration */
+	if (parent) {
+		down(&class_dev_sem);
+		list_add_tail(&class_dev->node, &parent->children);
+		list_for_each(entry, &parent->interfaces) {
+			class_intf = container_of(entry, struct class_interface, node);
+			if (class_intf->add)
+				class_intf->add(class_dev);
+		}
+		up(&class_dev_sem);
+	}
 
-		down_write(&cls->subsys.rwsem);
-		pr_debug("device class %s: removing device %s\n",
-			 cls->name,dev->name);
+	class_device_dev_link(class_dev);
 
-		unenum_device(cls,dev);
+ register_done:
+	if (error && parent)
+		class_put(parent);
+	class_device_put(class_dev);
+	return error;
+}
 
-		list_del(&dev->class_list);
+int class_device_register(struct class_device *class_dev)
+{
+	class_device_initialize(class_dev);
+	return class_device_add(class_dev);
+}
 
-		/* notify userspace (call /sbin/hotplug) */
-		class_hotplug (dev, "remove");
+void class_device_del(struct class_device *class_dev)
+{
+	struct class * parent = class_dev->class;
+	struct class_interface * class_intf;
+	struct list_head * entry;
 
-		up_write(&cls->subsys.rwsem);
+	if (parent) {
+		down(&class_dev_sem);
+		list_del_init(&class_dev->node);
+		list_for_each(entry, &parent->interfaces) {
+			class_intf = container_of(entry, struct class_interface, node);
+			if (class_intf->remove)
+				class_intf->remove(class_dev);
+		}
+		up(&class_dev_sem);
+	}
 
-		if (cls->remove_device)
-			cls->remove_device(dev);
-		put_devclass(cls);
+	if (class_dev->dev) {
+		class_device_dev_unlink(class_dev);
+		put_device(class_dev->dev);
 	}
- Done:
-	up(&devclass_sem);
+	
+	kobject_del(&class_dev->kobj);
+
+	if (parent)
+		class_put(parent);
 }
 
-struct device_class * get_devclass(struct device_class * cls)
+void class_device_unregister(struct class_device *class_dev)
 {
-	return cls ? container_of(subsys_get(&cls->subsys),struct device_class,subsys) : NULL;
+	pr_debug("CLASS: Unregistering class device. ID = '%s'\n",
+		 class_dev->class_id);
+	class_device_del(class_dev);
+	class_device_put(class_dev);
 }
 
-void put_devclass(struct device_class * cls)
+struct class_device * class_device_get(struct class_device *class_dev)
 {
-	subsys_put(&cls->subsys);
+	if (class_dev)
+		return to_class_dev(kobject_get(&class_dev->kobj));
+	return NULL;
+}
+
+void class_device_put(struct class_device *class_dev)
+{
+	kobject_put(&class_dev->kobj);
 }
 
 
-int devclass_register(struct device_class * cls)
+int class_interface_register(struct class_interface *class_intf)
 {
-	pr_debug("device class '%s': registering\n",cls->name);
-	strncpy(cls->subsys.kset.kobj.name,cls->name,KOBJ_NAME_LEN);
-	subsys_set_kset(cls,class_subsys);
-	subsystem_register(&cls->subsys);
+	struct class * parent;
+	struct class_device * class_dev;
+	struct list_head * entry;
+
+	if (!class_intf || !class_intf->class)
+		return -ENODEV;
+
+	parent = class_get(class_intf->class);
+
+	down(&class_dev_sem);
+	list_add_tail(&class_intf->node, &parent->interfaces);
 
-	snprintf(cls->devices.kobj.name,KOBJ_NAME_LEN,"devices");
-	cls->devices.subsys = &cls->subsys;
-	kset_register(&cls->devices);
-
-	snprintf(cls->drivers.kobj.name,KOBJ_NAME_LEN,"drivers");
-	cls->drivers.subsys = &cls->subsys;
-	kset_register(&cls->drivers);
+	if (class_intf->add) {
+		list_for_each(entry, &parent->children) {
+			class_dev = container_of(entry, struct class_device, node);
+			class_intf->add(class_dev);
+		}
+	}
+	up(&class_dev_sem);
 
 	return 0;
 }
 
-void devclass_unregister(struct device_class * cls)
+void class_interface_unregister(struct class_interface *class_intf)
 {
-	pr_debug("device class '%s': unregistering\n",cls->name);
-	kset_unregister(&cls->drivers);
-	kset_unregister(&cls->devices);
-	subsystem_unregister(&cls->subsys);
+	struct class * parent = class_intf->class;
+	struct list_head * entry;
+
+	down(&class_dev_sem);
+	list_del_init(&class_intf->node);
+
+	if (class_intf->remove) {
+		list_for_each(entry, &parent->children) {
+			struct class_device *class_dev = container_of(entry, struct class_device, node);
+			class_intf->remove(class_dev);
+		}
+	}
+	up(&class_dev_sem);
+
+	class_put(parent);
 }
 
+
+
 int __init classes_init(void)
 {
-	return subsystem_register(&class_subsys);
+	int retval;
+
+	retval = subsystem_register(&class_subsys);
+	if (retval)
+		return retval;
+
+	/* ick, this is ugly, the things we go through to keep from showing up
+	 * in sysfs... */
+	subsystem_init(&class_obj_subsys);
+	if (!class_obj_subsys.kset.subsys)
+			class_obj_subsys.kset.subsys = &class_obj_subsys;
+	return 0;
 }
 
-EXPORT_SYMBOL(devclass_create_file);
-EXPORT_SYMBOL(devclass_remove_file);
-EXPORT_SYMBOL(devclass_register);
-EXPORT_SYMBOL(devclass_unregister);
-EXPORT_SYMBOL(get_devclass);
-EXPORT_SYMBOL(put_devclass);
+EXPORT_SYMBOL(class_create_file);
+EXPORT_SYMBOL(class_remove_file);
+EXPORT_SYMBOL(class_register);
+EXPORT_SYMBOL(class_unregister);
+EXPORT_SYMBOL(class_get);
+EXPORT_SYMBOL(class_put);
+
+EXPORT_SYMBOL(class_device_register);
+EXPORT_SYMBOL(class_device_unregister);
+EXPORT_SYMBOL(class_device_initialize);
+EXPORT_SYMBOL(class_device_add);
+EXPORT_SYMBOL(class_device_del);
+EXPORT_SYMBOL(class_device_get);
+EXPORT_SYMBOL(class_device_put);
+EXPORT_SYMBOL(class_device_create_file);
+EXPORT_SYMBOL(class_device_remove_file);
 
diff -Nru a/drivers/base/core.c b/drivers/base/core.c
--- a/drivers/base/core.c	Tue Apr 22 13:07:51 2003
+++ b/drivers/base/core.c	Tue Apr 22 13:07:51 2003
@@ -185,7 +185,6 @@
 	INIT_LIST_HEAD(&dev->children);
 	INIT_LIST_HEAD(&dev->driver_list);
 	INIT_LIST_HEAD(&dev->bus_list);
-	INIT_LIST_HEAD(&dev->class_list);
 }
 
 /**
@@ -235,7 +234,6 @@
 	if (platform_notify)
 		platform_notify(dev);
 
-	devclass_add_device(dev);
  register_done:
 	if (error && parent)
 		put_device(parent);
diff -Nru a/drivers/base/cpu.c b/drivers/base/cpu.c
--- a/drivers/base/cpu.c	Tue Apr 22 13:07:58 2003
+++ b/drivers/base/cpu.c	Tue Apr 22 13:07:58 2003
@@ -10,23 +10,16 @@
 #include <asm/topology.h>
 
 
-static int cpu_add_device(struct device * dev)
-{
-	return 0;
-}
-struct device_class cpu_devclass = {
+struct class cpu_class = {
 	.name		= "cpu",
-	.add_device	= cpu_add_device,
 };
 
 
 struct device_driver cpu_driver = {
 	.name		= "cpu",
 	.bus		= &system_bus_type,
-	.devclass	= &cpu_devclass,
 };
 
-
 /*
  * register_cpu - Setup a driverfs device for a CPU.
  * @num - CPU number to use when creating the device.
@@ -35,6 +28,8 @@
  */
 int __init register_cpu(struct cpu *cpu, int num, struct node *root)
 {
+	int retval;
+
 	cpu->node_id = cpu_to_node(num);
 	cpu->sysdev.name = "cpu";
 	cpu->sysdev.id = num;
@@ -42,7 +37,19 @@
 		cpu->sysdev.root = &root->sysroot;
 	snprintf(cpu->sysdev.dev.name, DEVICE_NAME_SIZE, "CPU %u", num);
 	cpu->sysdev.dev.driver = &cpu_driver;
-	return sys_device_register(&cpu->sysdev);
+	retval = sys_device_register(&cpu->sysdev);
+	if (retval)
+		return retval;
+	memset(&cpu->sysdev.class_dev, 0x00, sizeof(struct class_device));
+	cpu->sysdev.class_dev.dev = &cpu->sysdev.dev;
+	cpu->sysdev.class_dev.class = &cpu_class;
+	snprintf(cpu->sysdev.class_dev.class_id, BUS_ID_SIZE, "cpu%d", num);
+	retval = class_device_register(&cpu->sysdev.class_dev);
+	if (retval) {
+		// FIXME cleanup sys_device_register
+		return retval;
+	}
+	return 0;
 }
 
 
@@ -50,11 +57,11 @@
 {
 	int error;
 
-	error = devclass_register(&cpu_devclass);
+	error = class_register(&cpu_class);
 	if (!error) {
 		error = driver_register(&cpu_driver);
 		if (error)
-			devclass_unregister(&cpu_devclass);
+			class_unregister(&cpu_class);
 	}
 	return error;
 }
diff -Nru a/drivers/base/driver.c b/drivers/base/driver.c
--- a/drivers/base/driver.c	Tue Apr 22 13:08:03 2003
+++ b/drivers/base/driver.c	Tue Apr 22 13:08:03 2003
@@ -82,7 +82,6 @@
 int driver_register(struct device_driver * drv)
 {
 	INIT_LIST_HEAD(&drv->devices);
-	INIT_LIST_HEAD(&drv->class_list);
 	init_MUTEX_LOCKED(&drv->unload_sem);
 	return bus_add_driver(drv);
 }
diff -Nru a/drivers/base/fs/Makefile b/drivers/base/fs/Makefile
--- a/drivers/base/fs/Makefile	Tue Apr 22 13:08:03 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,2 +0,0 @@
-obj-y		:= device.o
-
diff -Nru a/drivers/base/fs/device.c b/drivers/base/fs/device.c
--- a/drivers/base/fs/device.c	Tue Apr 22 13:07:49 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,49 +0,0 @@
-/*
- * drivers/base/fs.c - driver model interface to driverfs 
- *
- * Copyright (c) 2002 Patrick Mochel
- *		 2002 Open Source Development Lab
- */
-
-#undef DEBUG
-
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/string.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/stat.h>
-#include <linux/limits.h>
-
-int get_devpath_length(struct device * dev)
-{
-	int length = 1;
-	struct device * parent = dev;
-
-	/* walk up the ancestors until we hit the root.
-	 * Add 1 to strlen for leading '/' of each level.
-	 */
-	do {
-		length += strlen(parent->bus_id) + 1;
-		parent = parent->parent;
-	} while (parent);
-	return length;
-}
-
-void fill_devpath(struct device * dev, char * path, int length)
-{
-	struct device * parent;
-	--length;
-	for (parent = dev; parent; parent = parent->parent) {
-		int cur = strlen(parent->bus_id);
-
-		/* back up enough to print this bus id with '/' */
-		length -= cur;
-		strncpy(path + length,parent->bus_id,cur);
-		*(path + --length) = '/';
-	}
-
-	pr_debug("%s: path = '%s'\n",__FUNCTION__,path);
-}
-
diff -Nru a/drivers/base/fs/fs.h b/drivers/base/fs/fs.h
--- a/drivers/base/fs/fs.h	Tue Apr 22 13:07:53 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,5 +0,0 @@
-
-int get_devpath_length(struct device * dev);
-
-void fill_devpath(struct device * dev, char * path, int length);
-
diff -Nru a/drivers/base/hotplug.c b/drivers/base/hotplug.c
--- a/drivers/base/hotplug.c	Tue Apr 22 13:07:49 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,145 +0,0 @@
-/*
- * drivers/base/hotplug.c - hotplug call code
- * 
- * Copyright (c) 2000-2001 David Brownell
- * Copyright (c) 2002-2003 Greg Kroah-Hartman
- * Copyright (c) 2002-2003 IBM Corp.
- *
- * Based off of drivers/usb/core/usb.c:call_agent(), which was 
- * written by David Brownell.
- *
- */
-
-#undef DEBUG
-
-#include <linux/device.h>
-#include <linux/slab.h>
-#include <linux/err.h>
-#include <linux/kmod.h>
-#include <linux/interrupt.h>
-#include <linux/sched.h>
-#include <linux/string.h>
-#include "base.h"
-#include "fs/fs.h"
-
-/*
- * hotplugging invokes what /proc/sys/kernel/hotplug says (normally
- * /sbin/hotplug) when devices or classes get added or removed.
- *
- * This invokes a user mode policy agent, typically helping to load driver
- * or other modules, configure the device, and more.  Drivers can provide
- * a MODULE_DEVICE_TABLE to help with module loading subtasks.
- *
- * See the documentation at http://linux-hotplug.sf.net for more info.
- * 
- */
-
-#define BUFFER_SIZE	1024	/* should be enough memory for the env */
-#define NUM_ENVP	32	/* number of env pointers */
-
-static char prefix [] = "devices";	/* /sys/devices/... */
-
-static int do_hotplug (struct device *dev, char *argv1, const char *action,
-			int (* hotplug) (struct device *, char **, int, char *, int))
-{
-	char *argv [3], **envp, *buffer, *scratch;
-	char *dev_path;
-	int retval;
-	int i = 0;
-	int dev_length;
-
-	pr_debug ("%s\n", __FUNCTION__);
-
-	if (!hotplug_path [0])
-		return -ENODEV;
-
-	envp = (char **) kmalloc (NUM_ENVP * sizeof (char *), GFP_KERNEL);
-	if (!envp)
-		return -ENOMEM;
-	memset (envp, 0x00, NUM_ENVP * sizeof (char *));
-
-	buffer = kmalloc (BUFFER_SIZE, GFP_KERNEL);
-	if (!buffer) {
-		kfree (envp);
-		return -ENOMEM;
-	}
-
-	dev_length = get_devpath_length (dev);
-	dev_length += strlen(prefix);
-	dev_path = kmalloc (dev_length, GFP_KERNEL);
-	if (!dev_path) {
-		kfree (buffer);
-		kfree (envp);
-		return -ENOMEM;
-	}
-	memset (dev_path, 0x00, dev_length);
-	strcpy (dev_path, prefix);
-	fill_devpath (dev, dev_path, dev_length);
-
-	argv [0] = hotplug_path;
-	argv [1] = argv1;
-	argv [2] = 0;
-
-	/* minimal command environment */
-	envp [i++] = "HOME=/";
-	envp [i++] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-
-	scratch = buffer;
-
-	envp [i++] = scratch;
-	scratch += sprintf (scratch, "ACTION=%s", action) + 1;
-
-	envp [i++] = scratch;
-	scratch += sprintf (scratch, "DEVPATH=%s", dev_path) + 1;
-	
-	if (hotplug) {
-		/* have the bus specific function add its stuff */
-		retval = hotplug (dev, &envp[i], NUM_ENVP - i, scratch,
-				  BUFFER_SIZE - (scratch - buffer));
-		if (retval) {
-			pr_debug ("%s - hotplug() returned %d\n",
-				  __FUNCTION__, retval);
-			goto exit;
-		}
-	}
-
-	pr_debug ("%s: %s %s %s %s %s %s\n", __FUNCTION__, argv [0], argv[1],
-		  envp[0], envp[1], envp[2], envp[3]);
-	retval = call_usermodehelper (argv [0], argv, envp, 0);
-	if (retval)
-		pr_debug ("%s - call_usermodehelper returned %d\n",
-			  __FUNCTION__, retval);
-
-exit:
-	kfree (dev_path);
-	kfree (buffer);
-	kfree (envp);
-	return retval;
-}
-
-/*
- * class_hotplug - called when a class is added or removed from a device
- */
-int class_hotplug (struct device *dev, const char *action)
-{
-	struct device_class * cls;
-	int retval;
-
-	pr_debug ("%s\n", __FUNCTION__);
-
-	if (!dev)
-		return -ENODEV;
-
-	if (!dev->bus)
-		return -ENODEV;
-
-	cls = get_devclass(dev->driver->devclass);
-	if (!cls)
-		return -ENODEV;
-
-	retval = do_hotplug (dev, cls->name, action, cls->hotplug);
-
-	put_devclass(cls);
-
-	return retval;
-}
diff -Nru a/drivers/base/intf.c b/drivers/base/intf.c
--- a/drivers/base/intf.c	Tue Apr 22 13:07:50 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,225 +0,0 @@
-/*
- * intf.c - class-specific interface management
- */
-
-#undef DEBUG
-
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/string.h>
-#include "base.h"
-
-
-#define to_intf(node) container_of(node,struct device_interface,kset.kobj.entry)
-
-#define to_dev(d) container_of(d,struct device,class_list)
-
-/**
- *	intf_dev_link - create sysfs symlink for interface.
- *	@intf:	interface.
- *	@dev:	device.
- *
- *	Create a symlink 'phys' in the interface's directory to 
- */
-
-static int intf_dev_link(struct device_interface * intf, struct device * dev)
-{
-	return sysfs_create_link(&intf->kset.kobj,&dev->kobj,dev->bus_id);
-}
-
-/**
- *	intf_dev_unlink - remove symlink for interface.
- *	@intf:	interface.
- *	@dev:	device.
- *
- */
-
-static void intf_dev_unlink(struct device_interface * intf, struct device * dev)
-{
-	sysfs_remove_link(&intf->kset.kobj,dev->bus_id);
-}
-
-
-/**
- *	add - attach device to interface
- *	@intf:	interface.
- *	@dev:	device.
- *
- *	This is just a simple helper. Check the interface's interface
- *	helper and call it. This is called when adding an interface
- *	the class's devices, or a device to the class's interfaces.
- */
-
-static int add(struct device_interface * intf, struct device * dev)
-{
-	int error = 0;
-
-	if (intf->add_device) {
-		if (!(error = intf->add_device(dev)))
-			intf_dev_link(intf,dev);
-	}
-	pr_debug(" -> %s (%d)\n",dev->bus_id,error);
-	return error;
-}
-
-/**
- *	del - detach device from interface.
- *	@intf:	interface.
- *	@dev:	device.
- */
-
-static void del(struct device_interface * intf, struct device * dev)
-{
-	pr_debug(" -> %s ",intf->name);
-	if (intf->remove_device)
-		intf->remove_device(dev);
-	intf_dev_unlink(intf,dev);
-}
-
-
-/**
- *	add_intf - add class's devices to interface.
- *	@intf:	interface.
- *
- *	Loop over the devices registered with the class, and call
- *	the interface's add_device() method for each.
- *
- *	On an error, we won't break, but we will print debugging info.
- */
-static void add_intf(struct device_interface * intf)
-{
-	struct device_class * cls = intf->devclass;
-	struct list_head * entry;
-
-	list_for_each(entry,&cls->devices.list)
-		add(intf,to_dev(entry));
-}
-
-/**
- *	interface_register - register an interface with a device class.
- *	@intf:	interface.
- *
- *	An interface may be loaded after drivers and devices have been
- *	added to the class. So, we must add each device already known to
- *	the class to the interface as its registered.
- */
-
-int interface_register(struct device_interface * intf)
-{
-	struct device_class * cls = get_devclass(intf->devclass);
-
-	down(&devclass_sem);
-	if (cls) {
-		pr_debug("register interface '%s' with class '%s'\n",
-			 intf->name,cls->name);
-
-		strncpy(intf->kset.kobj.name,intf->name,KOBJ_NAME_LEN);
-		kset_set_kset_s(intf,cls->subsys);
-		kset_register(&intf->kset);
-		add_intf(intf);
-	}
-	up(&devclass_sem);
-	return 0;
-}
-
-
-/**
- *	del_intf - remove devices from interface.
- *	@intf:	interface being unloaded.
- *
- *	This loops over the devices registered with a class and 
- *	calls the interface's remove_device() method for each.
- *	This is called when an interface is being unregistered.
- */
-
-static void del_intf(struct device_interface * intf)
-{
-	struct device_class * cls = intf->devclass;
-	struct list_head * entry;
-
-	list_for_each(entry,&cls->devices.list) {
-		struct device * dev = to_dev(entry);
-		del(intf,dev);
-	}
-}
-
-/**
- *	interface_unregister - remove interface from class.
- *	@intf:	interface.
- *
- *	This is called when an interface in unloaded, giving it a
- *	chance to remove itself from devicse that have been added to 
- *	it.
- */
-
-void interface_unregister(struct device_interface * intf)
-{
-	struct device_class * cls = intf->devclass;
-
-	down(&devclass_sem);
-	if (cls) {
-		pr_debug("unregistering interface '%s' from class '%s'\n",
-			 intf->name,cls->name);
-		del_intf(intf);
-		kset_unregister(&intf->kset);
-		put_devclass(cls);
-	}
-	up(&devclass_sem);
-}
-
-
-/**
- *	interface_add_dev - add device to interfaces.
- *	@dev:	device.
- *
- *	This is a helper for the class driver core. When a 
- *	device is being added to a class, this is called to add
- *	the device to all the interfaces in the class.
- *
- *	The operation is simple enough: loop over the interfaces
- *	and call add() [above] for each. The class rwsem is assumed
- *	to be held.
- */
-
-int interface_add_dev(struct device * dev)
-{
-	struct device_class * cls = dev->driver->devclass;
-	struct list_head * node;
-
-	pr_debug("interfaces: adding device %s\n",dev->name);
-
-	list_for_each(node,&cls->subsys.kset.list) {
-		struct device_interface * intf = to_intf(node);
-		add(intf,dev);
-	}
-	return 0;
-}
-
-
-/**
- *	interface_remove_dev - remove device from interfaces.
- *	@dev:	device.
- *
- *	This is another helper for the class driver core, and called
- *	when the device is being removed from the class. 
- *	
- *	We iterate over the list of the class's devices and call del() 
- *	[above] for each. Again, the class's rwsem is _not_ held, but
- *	the devclass_sem is (see class.c).
- */
-
-void interface_remove_dev(struct device * dev)
-{
-	struct list_head * entry, * next;
-	struct device_class * cls = dev->driver->devclass;
-
-	pr_debug("interfaces: removing device %s\n",dev->name);
-
-	list_for_each_safe(entry,next,&cls->subsys.kset.list) {
-		struct device_interface * intf = to_intf(entry);
-		del(intf,dev);
-	}
-}
-
-EXPORT_SYMBOL(interface_register);
-EXPORT_SYMBOL(interface_unregister);
diff -Nru a/drivers/base/memblk.c b/drivers/base/memblk.c
--- a/drivers/base/memblk.c	Tue Apr 22 13:07:56 2003
+++ b/drivers/base/memblk.c	Tue Apr 22 13:07:56 2003
@@ -11,20 +11,14 @@
 #include <asm/topology.h>
 
 
-static int memblk_add_device(struct device * dev)
-{
-	return 0;
-}
-struct device_class memblk_devclass = {
+static struct class memblk_class = {
 	.name		= "memblk",
-	.add_device	= memblk_add_device,
 };
 
 
-struct device_driver memblk_driver = {
+static struct device_driver memblk_driver = {
 	.name		= "memblk",
 	.bus		= &system_bus_type,
-	.devclass	= &memblk_devclass,
 };
 
 
@@ -51,11 +45,11 @@
 {
 	int error;
 
-	error = devclass_register(&memblk_devclass);
+	error = class_register(&memblk_class);
 	if (!error) {
 		error = driver_register(&memblk_driver);
 		if (error)
-			devclass_unregister(&memblk_devclass);
+			class_unregister(&memblk_class);
 	}
 	return error;
 }
diff -Nru a/drivers/base/node.c b/drivers/base/node.c
--- a/drivers/base/node.c	Tue Apr 22 13:07:58 2003
+++ b/drivers/base/node.c	Tue Apr 22 13:07:58 2003
@@ -11,20 +11,14 @@
 #include <asm/topology.h>
 
 
-static int node_add_device(struct device * dev)
-{
-	return 0;
-}
-struct device_class node_devclass = {
+static struct class node_class = {
 	.name		= "node",
-	.add_device	= node_add_device,
 };
 
 
-struct device_driver node_driver = {
+static struct device_driver node_driver = {
 	.name		= "node",
 	.bus		= &system_bus_type,
-	.devclass	= &node_devclass,
 };
 
 
@@ -93,11 +87,11 @@
 {
 	int error;
 	
-	error = devclass_register(&node_devclass);
+	error = class_register(&node_class);
 	if (!error) {
 		error = driver_register(&node_driver);
 		if (error)
-			devclass_unregister(&node_devclass);
+			class_unregister(&node_class);
 	}
 	return error;
 }
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Tue Apr 22 13:08:00 2003
+++ b/include/linux/device.h	Tue Apr 22 13:08:00 2003
@@ -1,7 +1,7 @@
 /*
  * device.h - generic, centralized driver model
  *
- * Copyright (c) 2001 Patrick Mochel <mochel@osdl.org>
+ * Copyright (c) 2001-2003 Patrick Mochel <mochel@osdl.org>
  *
  * This is a relatively simple centralized driver model.
  * The data structures were mainly lifted directly from the PCI
@@ -60,7 +60,8 @@
 
 struct device;
 struct device_driver;
-struct device_class;
+struct class;
+struct class_device;
 
 struct bus_type {
 	char			* name;
@@ -116,11 +117,9 @@
 struct device_driver {
 	char			* name;
 	struct bus_type		* bus;
-	struct device_class	* devclass;
 
 	struct semaphore	unload_sem;
 	struct kobject		kobj;
-	struct list_head	class_list;
 	struct list_head	devices;
 
 	int	(*probe)	(struct device * dev);
@@ -160,74 +159,106 @@
 /*
  * device classes
  */
-struct device_class {
+struct class {
 	char			* name;
-	u32			devnum;
 
 	struct subsystem	subsys;
-	struct kset		devices;
-	struct kset		drivers;
+	struct list_head	children;
+	struct list_head	interfaces;
 
-	int	(*add_device)(struct device *);
-	void	(*remove_device)(struct device *);
-	int	(*hotplug)(struct device *dev, char **envp, 
+	int	(*hotplug)(struct class_device *dev, char **envp, 
 			   int num_envp, char *buffer, int buffer_size);
 };
 
-extern int devclass_register(struct device_class *);
-extern void devclass_unregister(struct device_class *);
+extern int class_register(struct class *);
+extern void class_unregister(struct class *);
 
-extern struct device_class * get_devclass(struct device_class *);
-extern void put_devclass(struct device_class *);
+extern struct class * class_get(struct class *);
+extern void class_put(struct class *);
 
 
-struct devclass_attribute {
+struct class_attribute {
 	struct attribute	attr;
-	ssize_t (*show)(struct device_class *, char * buf);
-	ssize_t (*store)(struct device_class *, const char * buf, size_t count);
+	ssize_t (*show)(struct class *, char * buf);
+	ssize_t (*store)(struct class *, const char * buf, size_t count);
 };
 
-#define DEVCLASS_ATTR(_name,_str,_mode,_show,_store)	\
-struct devclass_attribute devclass_attr_##_name = { 		\
-	.attr = {.name	= _str,	.mode	= _mode },	\
-	.show	= _show,				\
-	.store	= _store,				\
+#define CLASS_ATTR(_name,_mode,_show,_store)			\
+struct class_attribute class_attr_##_name = { 			\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.show	= _show,					\
+	.store	= _store,					\
 };
 
-extern int devclass_create_file(struct device_class *, struct devclass_attribute *);
-extern void devclass_remove_file(struct device_class *, struct devclass_attribute *);
+extern int class_create_file(struct class *, struct class_attribute *);
+extern void class_remove_file(struct class *, struct class_attribute *);
 
 
-/*
- * device interfaces
- * These are the logical interfaces of device classes. 
- * These entities map directly to specific userspace interfaces, like 
- * device nodes.
- * Interfaces are registered with the device class they belong to. When
- * a device is registered with the class, each interface's add_device 
- * callback is called. It is up to the interface to decide whether or not
- * it supports the device.
- */
+struct class_device {
+	struct list_head	node;
 
-struct device_interface {
-	char			* name;
-	struct device_class	* devclass;
+	struct kobject		kobj;
+	struct class		* class;	/* required */
+	struct device		* dev;		/* not necessary, but nice to have */
+	void			* class_data;	/* class-specific data */
+
+	char	class_id[BUS_ID_SIZE];	/* unique to this class */
+};
+
+static inline void *
+class_get_devdata (struct class_device *dev)
+{
+	return dev->class_data;
+}
+
+static inline void
+class_set_devdata (struct class_device *dev, void *data)
+{
+	dev->class_data = data;
+}
+
+
+extern int class_device_register(struct class_device *);
+extern void class_device_unregister(struct class_device *);
+extern void class_device_initialize(struct class_device *);
+extern int class_device_add(struct class_device *);
+extern void class_device_del(struct class_device *);
+
+extern struct class_device * class_device_get(struct class_device *);
+extern void class_device_put(struct class_device *);
+
+struct class_device_attribute {
+	struct attribute	attr;
+	ssize_t (*show)(struct class_device *, char * buf);
+	ssize_t (*store)(struct class_device *, const char * buf, size_t count);
+};
+
+#define CLASS_DEVICE_ATTR(_name,_mode,_show,_store)		\
+struct class_device_attribute class_device_attr_##_name = { 	\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.show	= _show,					\
+	.store	= _store,					\
+};
 
-	struct kset		kset;
-	u32			devnum;
+extern int class_device_create_file(struct class_device *, struct class_device_attribute *);
+extern void class_device_remove_file(struct class_device *, struct class_device_attribute *);
 
-	int (*add_device)	(struct device *);
-	int (*remove_device)	(struct device *);
+
+struct class_interface {
+	struct list_head	node;
+	struct class		*class;
+
+	int (*add)	(struct class_device *);
+	int (*remove)	(struct class_device *);
 };
 
-extern int interface_register(struct device_interface *);
-extern void interface_unregister(struct device_interface *);
+extern int class_interface_register(struct class_interface *);
+extern void class_interface_unregister(struct class_interface *);
 
 
 struct device {
 	struct list_head node;		/* node in sibling list */
 	struct list_head bus_list;	/* node in bus's list */
-	struct list_head class_list;
 	struct list_head driver_list;
 	struct list_head children;
 	struct device 	* parent;
@@ -240,14 +271,10 @@
 	struct device_driver *driver;	/* which driver has allocated this
 					   device */
 	void		*driver_data;	/* data private to the driver */
-
-	u32		class_num;	/* class-enumerated value */
-	void		* class_data;	/* class-specific data */
-
 	void		*platform_data;	/* Platform specific data (e.g. ACPI,
 					   BIOS data relevant to device) */
 
-	u32		power_state;  /* Current operating state. In
+	u32		power_state;	/* Current operating state. In
 					   ACPI-speak, this is D0-D3, D0
 					   being fully functional, and D3
 					   being off. */
@@ -347,6 +374,7 @@
 	u32		id;
 	struct sys_root	* root;
 	struct device	dev;
+	struct class_device class_dev;
 };
 
 extern int sys_device_register(struct sys_device *);
