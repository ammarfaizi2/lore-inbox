Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262639AbSJHAHG>; Mon, 7 Oct 2002 20:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263403AbSJHAFz>; Mon, 7 Oct 2002 20:05:55 -0400
Received: from air-2.osdl.org ([65.172.181.6]:34728 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S263941AbSJHADv>;
	Mon, 7 Oct 2002 20:03:51 -0400
Date: Mon, 7 Oct 2002 17:11:53 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [bk/patch] Rename driverfs to kfs
In-Reply-To: <Pine.LNX.4.44.0210071701460.16276-100000@cherise.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210071711440.16276-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet@1.573.1.139, 2002-10-07 15:20:08-07:00, mochel@osdl.org
  kfs: s/driverfs/kfs/ for kfs API calls and their users in the kernel.

diff -Nru a/drivers/acpi/acpi_bus.h b/drivers/acpi/acpi_bus.h
--- a/drivers/acpi/acpi_bus.h	Mon Oct  7 15:40:20 2002
+++ b/drivers/acpi/acpi_bus.h	Mon Oct  7 15:40:20 2002
@@ -255,7 +255,7 @@
 	struct acpi_device_ops	ops;
 	struct acpi_driver	*driver;
 	void			*driver_data;
-	struct driver_dir_entry	driverfs_dir;
+	struct driver_dir_entry	kfs_dir;
 };
 
 #define acpi_driver_data(d)	((d)->driver_data)
diff -Nru a/drivers/acpi/kfs.c b/drivers/acpi/kfs.c
--- a/drivers/acpi/kfs.c	Mon Oct  7 15:40:20 2002
+++ b/drivers/acpi/kfs.c	Mon Oct  7 15:40:20 2002
@@ -1,5 +1,5 @@
 /*
- * driverfs.c - ACPI bindings for driverfs.
+ * kfs.c - ACPI bindings for kfs.
  *
  * Copyright (c) 2002 Patrick Mochel
  * Copyright (c) 2002 The Open Source Development Lab
@@ -17,7 +17,7 @@
 	.mode	= (S_IRWXU | S_IRUGO | S_IXUGO),
 };
  
-/* driverfs ops for ACPI attribute files go here, when/if
+/* kfs ops for ACPI attribute files go here, when/if
  * there are ACPI attribute files. 
  * For now, we just have directory creation and removal.
  */
@@ -25,22 +25,22 @@
 void acpi_remove_dir(struct acpi_device * dev)
 {
 	if (dev)
-		driverfs_remove_dir(&dev->driverfs_dir);
+		kfs_remove_dir(&dev->kfs_dir);
 }
 
 int acpi_create_dir(struct acpi_device * dev)
 {
 	struct driver_dir_entry * parent;
 
-	parent = dev->parent ? &dev->parent->driverfs_dir : &acpi_dir;
-	dev->driverfs_dir.name = dev->pnp.bus_id;
-	dev->driverfs_dir.mode  = (S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO);
-	return driverfs_create_dir(&dev->driverfs_dir,parent);
+	parent = dev->parent ? &dev->parent->kfs_dir : &acpi_dir;
+	dev->kfs_dir.name = dev->pnp.bus_id;
+	dev->kfs_dir.mode  = (S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO);
+	return kfs_create_dir(&dev->kfs_dir,parent);
 }
 
-static int __init acpi_driverfs_init(void)
+static int __init acpi_kfs_init(void)
 {
-	return driverfs_create_dir(&acpi_dir,NULL);
+	return kfs_create_dir(&acpi_dir,NULL);
 }
 
-subsys_initcall(acpi_driverfs_init);
+subsys_initcall(acpi_kfs_init);
diff -Nru a/drivers/base/fs/bus.c b/drivers/base/fs/bus.c
--- a/drivers/base/fs/bus.c	Mon Oct  7 15:40:20 2002
+++ b/drivers/base/fs/bus.c	Mon Oct  7 15:40:20 2002
@@ -11,7 +11,7 @@
 #define to_bus(dir) container_of(dir,struct bus_type,dir)
 
 
-/* driverfs ops for device attribute files */
+/* kfs ops for device attribute files */
 
 static int
 bus_attr_open(struct driver_dir_entry * dir)
@@ -55,7 +55,7 @@
 	return ret;
 }
 
-static struct driverfs_ops bus_attr_ops = {
+static struct kfs_ops bus_attr_ops = {
 	.open	= bus_attr_open,
 	.close	= bus_attr_close,
 	.show	= bus_attr_show,
@@ -66,7 +66,7 @@
 {
 	int error;
 	if (get_bus(bus)) {
-		error = driverfs_create_file(&attr->attr,&bus->dir);
+		error = kfs_create_file(&attr->attr,&bus->dir);
 		put_bus(bus);
 	} else
 		error = -EINVAL;
@@ -76,7 +76,7 @@
 void bus_remove_file(struct bus_type * bus, struct bus_attribute * attr)
 {
 	if (get_bus(bus)) {
-		driverfs_remove_file(&bus->dir,attr->attr.name);
+		kfs_remove_file(&bus->dir,attr->attr.name);
 		put_bus(bus);
 	}
 }
@@ -100,10 +100,10 @@
 
 void bus_remove_dir(struct bus_type * bus)
 {
-	/* remove driverfs entries */
-	driverfs_remove_dir(&bus->driver_dir);
-	driverfs_remove_dir(&bus->device_dir);
-	driverfs_remove_dir(&bus->dir);
+	/* remove kfs entries */
+	kfs_remove_dir(&bus->driver_dir);
+	kfs_remove_dir(&bus->device_dir);
+	kfs_remove_dir(&bus->dir);
 }
 
 static struct driver_dir_entry bus_dir = {
@@ -113,8 +113,8 @@
 
 static int __init bus_init(void)
 {
-	/* make 'bus' driverfs directory */
-	return driverfs_create_dir(&bus_dir,NULL);
+	/* make 'bus' kfs directory */
+	return kfs_create_dir(&bus_dir,NULL);
 }
 
 core_initcall(bus_init);
diff -Nru a/drivers/base/fs/class.c b/drivers/base/fs/class.c
--- a/drivers/base/fs/class.c	Mon Oct  7 15:40:20 2002
+++ b/drivers/base/fs/class.c	Mon Oct  7 15:40:20 2002
@@ -1,5 +1,5 @@
 /*
- * class.c - driverfs bindings for device classes.
+ * class.c - kfs bindings for device classes.
  */
 
 #include <linux/device.h>
@@ -43,7 +43,7 @@
 	return ret;
 }
 
-static struct driverfs_ops devclass_attr_ops = {
+static struct kfs_ops devclass_attr_ops = {
 	show:	devclass_attr_show,
 	store:	devclass_attr_store,
 };
@@ -52,7 +52,7 @@
 {
 	int error;
 	if (dc) {
-		error = driverfs_create_file(&attr->attr,&dc->dir);
+		error = kfs_create_file(&attr->attr,&dc->dir);
 	} else
 		error = -EINVAL;
 	return error;
@@ -61,7 +61,7 @@
 void devclass_remove_file(struct device_class * dc, struct devclass_attribute * attr)
 {
 	if (dc)
-		driverfs_remove_file(&dc->dir,attr->attr.name);
+		kfs_remove_file(&dc->dir,attr->attr.name);
 }
 
 /**
@@ -98,7 +98,7 @@
 	fill_devpath(dev,path,length);
 	
 	snprintf(linkname,16,"%u",dev->class_num);
-	error = driverfs_create_symlink(&cls->device_dir,linkname,path);
+	error = kfs_create_symlink(&cls->device_dir,linkname,path);
 	kfree(path);
 	return error;
 }
@@ -108,7 +108,7 @@
 	char	linkname[16];
 
 	snprintf(linkname,16,"%u",dev->class_num);
-	driverfs_remove_file(&cls->device_dir,linkname);
+	kfs_remove_file(&cls->device_dir,linkname);
 }
 
 /**
@@ -153,7 +153,7 @@
 		 "/drivers/",
 		 drv->name);
 
-	error = driverfs_create_symlink(&drv->devclass->driver_dir,name,path);
+	error = kfs_create_symlink(&drv->devclass->driver_dir,name,path);
  Done:
 	kfree(name);
 	kfree(path);
@@ -167,16 +167,16 @@
 
 	length = strlen(drv->name) + strlen(drv->bus->name) + 2;
 	if ((name = kmalloc(length,GFP_KERNEL))) {
-		driverfs_remove_file(&drv->devclass->driver_dir,name);
+		kfs_remove_file(&drv->devclass->driver_dir,name);
 		kfree(name);
 	}
 }
 
 void devclass_remove_dir(struct device_class * dc)
 {
-	driverfs_remove_dir(&dc->device_dir);
-	driverfs_remove_dir(&dc->driver_dir);
-	driverfs_remove_dir(&dc->dir);
+	kfs_remove_dir(&dc->device_dir);
+	kfs_remove_dir(&dc->driver_dir);
+	kfs_remove_dir(&dc->dir);
 }
 
 int devclass_make_dir(struct device_class * dc)
@@ -194,7 +194,7 @@
 			error = device_create_dir(&dc->device_dir,&dc->dir);
 		}
 		if (error)
-			driverfs_remove_dir(&dc->dir);
+			kfs_remove_dir(&dc->dir);
 	}
 	return error;
 }
@@ -204,12 +204,12 @@
 	mode:	(S_IRWXU | S_IRUGO | S_IXUGO),
 };
 
-static int __init devclass_driverfs_init(void)
+static int __init devclass_kfs_init(void)
 {
-	return driverfs_create_dir(&class_dir,NULL);
+	return kfs_create_dir(&class_dir,NULL);
 }
 
-core_initcall(devclass_driverfs_init);
+core_initcall(devclass_kfs_init);
 
 EXPORT_SYMBOL(devclass_create_file);
 EXPORT_SYMBOL(devclass_remove_file);
diff -Nru a/drivers/base/fs/device.c b/drivers/base/fs/device.c
--- a/drivers/base/fs/device.c	Mon Oct  7 15:40:20 2002
+++ b/drivers/base/fs/device.c	Mon Oct  7 15:40:20 2002
@@ -1,5 +1,5 @@
 /*
- * drivers/base/fs.c - driver model interface to driverfs 
+ * drivers/base/fs.c - driver model interface to kfs 
  *
  * Copyright (c) 2002 Patrick Mochel
  *		 2002 Open Source Development Lab
@@ -28,7 +28,7 @@
 #define to_device(d) container_of(d, struct device, dir)
 
 
-/* driverfs ops for device attribute files */
+/* kfs ops for device attribute files */
 
 static int
 dev_attr_open(struct driver_dir_entry * dir)
@@ -72,7 +72,7 @@
 	return ret;
 }
 
-static struct driverfs_ops dev_attr_ops = {
+static struct kfs_ops dev_attr_ops = {
 	.open	= dev_attr_open,
 	.close	= dev_attr_close,
 	.show	= dev_attr_show,
@@ -80,7 +80,7 @@
 };
 
 /**
- * device_create_file - create a driverfs file for a device
+ * device_create_file - create a kfs file for a device
  * @dev:	device requesting file
  * @entry:	entry describing file
  *
@@ -92,7 +92,7 @@
 
 	if (dev) {
 		get_device(dev);
-		error = driverfs_create_file(&entry->attr,&dev->dir);
+		error = kfs_create_file(&entry->attr,&dev->dir);
 		put_device(dev);
 	}
 	return error;
@@ -108,7 +108,7 @@
 {
 	if (dev) {
 		get_device(dev);
-		driverfs_remove_file(&dev->dir,attr->attr.name);
+		kfs_remove_file(&dev->dir,attr->attr.name);
 		put_device(dev);
 	}
 }
@@ -120,7 +120,7 @@
 void device_remove_dir(struct device * dev)
 {
 	if (dev)
-		driverfs_remove_dir(&dev->dir);
+		kfs_remove_dir(&dev->dir);
 }
 
 int get_devpath_length(struct device * dev)
@@ -183,28 +183,28 @@
 	strcpy(path,"../../../root");
 
 	fill_devpath(dev,path,length);
-	error = driverfs_create_symlink(&dev->bus->device_dir,dev->bus_id,path);
+	error = kfs_create_symlink(&dev->bus->device_dir,dev->bus_id,path);
 	kfree(path);
 	return error;
 }
 
 void device_remove_symlink(struct driver_dir_entry * dir, const char * name)
 {
-	driverfs_remove_file(dir,name);
+	kfs_remove_file(dir,name);
 }
 
 int device_create_dir(struct driver_dir_entry * dir, struct driver_dir_entry * parent)
 {
 	dir->mode  = (S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO);
-	return driverfs_create_dir(dir,parent);
+	return kfs_create_dir(dir,parent);
 }
 
 /**
- * device_make_dir - create a driverfs directory
+ * device_make_dir - create a kfs directory
  * @name:	name of directory
  * @parent:	dentry for the parent directory
  *
- * Do the initial creation of the device's driverfs directory
+ * Do the initial creation of the device's kfs directory
  * and populate it with the one default file.
  *
  * This is just a helper for device_register(), as we
@@ -234,12 +234,12 @@
 	return error;
 }
 
-static int device_driverfs_init(void)
+static int device_kfs_init(void)
 {
-	return driverfs_create_dir(&device_root_dir,NULL);
+	return kfs_create_dir(&device_root_dir,NULL);
 }
 
-core_initcall(device_driverfs_init);
+core_initcall(device_kfs_init);
 
 EXPORT_SYMBOL(device_create_file);
 EXPORT_SYMBOL(device_remove_file);
diff -Nru a/drivers/base/fs/driver.c b/drivers/base/fs/driver.c
--- a/drivers/base/fs/driver.c	Mon Oct  7 15:40:20 2002
+++ b/drivers/base/fs/driver.c	Mon Oct  7 15:40:20 2002
@@ -9,7 +9,7 @@
 #define to_drv(d) container_of(d, struct device_driver, dir)
 
 
-/* driverfs ops for device attribute files */
+/* kfs ops for device attribute files */
 
 static int
 drv_attr_open(struct driver_dir_entry * dir)
@@ -53,7 +53,7 @@
 	return ret;
 }
 
-static struct driverfs_ops drv_attr_ops = {
+static struct kfs_ops drv_attr_ops = {
 	.open	= drv_attr_open,
 	.close	= drv_attr_close,
 	.show	= drv_attr_show,
@@ -64,7 +64,7 @@
 {
 	int error;
 	if (get_driver(drv)) {
-		error = driverfs_create_file(&attr->attr,&drv->dir);
+		error = kfs_create_file(&attr->attr,&drv->dir);
 		put_driver(drv);
 	} else
 		error = -EINVAL;
@@ -74,13 +74,13 @@
 void driver_remove_file(struct device_driver * drv, struct driver_attribute * attr)
 {
 	if (get_driver(drv)) {
-		driverfs_remove_file(&drv->dir,attr->attr.name);
+		kfs_remove_file(&drv->dir,attr->attr.name);
 		put_driver(drv);
 	}
 }
 
 /**
- * driver_make_dir - create a driverfs directory for a driver
+ * driver_make_dir - create a kfs directory for a driver
  * @drv:	driver in question
  */
 int driver_make_dir(struct device_driver * drv)
@@ -93,7 +93,7 @@
 
 void driver_remove_dir(struct device_driver * drv)
 {
-	driverfs_remove_dir(&drv->dir);
+	kfs_remove_dir(&drv->dir);
 }
 
 EXPORT_SYMBOL(driver_create_file);
diff -Nru a/drivers/base/fs/intf.c b/drivers/base/fs/intf.c
--- a/drivers/base/fs/intf.c	Mon Oct  7 15:40:20 2002
+++ b/drivers/base/fs/intf.c	Mon Oct  7 15:40:20 2002
@@ -1,5 +1,5 @@
 /*
- * intf.c - driverfs glue for device interfaces
+ * intf.c - kfs glue for device interfaces
  */
 
 #include <linux/device.h>
@@ -30,7 +30,7 @@
 	fill_devpath(data->dev,path,length);
 
 	snprintf(linkname,16,"%u",data->intf_num);
-	error = driverfs_create_symlink(&data->intf->dir,linkname,path);
+	error = kfs_create_symlink(&data->intf->dir,linkname,path);
 	kfree(path);
 	return error;
 }
@@ -39,12 +39,12 @@
 {
 	char	linkname[16];
 	snprintf(linkname,16,"%u",data->intf_num);
-	driverfs_remove_file(&data->intf->dir,linkname);
+	kfs_remove_file(&data->intf->dir,linkname);
 }
 
 void intf_remove_dir(struct device_interface * intf)
 {
-	driverfs_remove_dir(&intf->dir);
+	kfs_remove_dir(&intf->dir);
 }
 
 int intf_make_dir(struct device_interface * intf)
diff -Nru a/drivers/base/interface.c b/drivers/base/interface.c
--- a/drivers/base/interface.c	Mon Oct  7 15:40:20 2002
+++ b/drivers/base/interface.c	Mon Oct  7 15:40:20 2002
@@ -1,5 +1,5 @@
 /*
- * drivers/base/interface.c - common driverfs interface that's exported to 
+ * drivers/base/interface.c - common kfs interface that's exported to 
  * 	the world for all devices.
  * Copyright (c) 2002 Patrick Mochel
  *		 2002 Open Source Development Lab
diff -Nru a/fs/kfs/inode.c b/fs/kfs/inode.c
--- a/fs/kfs/inode.c	Mon Oct  7 15:40:20 2002
+++ b/fs/kfs/inode.c	Mon Oct  7 15:40:20 2002
@@ -527,12 +527,12 @@
 }
 
 /**
- * driverfs_create_dir - create a directory in the filesystem
+ * kfs_create_dir - create a directory in the filesystem
  * @entry:	directory entry
  * @parent:	parent directory entry
  */
 int
-driverfs_create_dir(struct driver_dir_entry * entry,
+kfs_create_dir(struct driver_dir_entry * entry,
 		    struct driver_dir_entry * parent)
 {
 	struct dentry * dentry = NULL;
@@ -571,12 +571,12 @@
 }
 
 /**
- * driverfs_create_file - create a file
+ * kfs_create_file - create a file
  * @entry:	structure describing the file
  * @parent:	directory to create it in
  */
 int
-driverfs_create_file(struct attribute * entry,
+kfs_create_file(struct attribute * entry,
 		     struct driver_dir_entry * parent)
 {
 	struct dentry * dentry;
@@ -602,13 +602,13 @@
 }
 
 /**
- * driverfs_create_symlink - make a symlink
+ * kfs_create_symlink - make a symlink
  * @parent:	directory we're creating in 
  * @entry:	entry describing link
  * @target:	place we're symlinking to
  * 
  */
-int driverfs_create_symlink(struct driver_dir_entry * parent, 
+int kfs_create_symlink(struct driver_dir_entry * parent, 
 			    char * name, char * target)
 {
 	struct dentry * dentry;
@@ -632,14 +632,14 @@
 }
 
 /**
- * driverfs_remove_file - exported file removal
+ * kfs_remove_file - exported file removal
  * @dir:	directory the file supposedly resides in
  * @name:	name of the file
  *
  * Try and find the file in the dir's list.
  * If it's there, call __remove_file() (above) for the dentry.
  */
-void driverfs_remove_file(struct driver_dir_entry * dir, const char * name)
+void kfs_remove_file(struct driver_dir_entry * dir, const char * name)
 {
 	struct dentry * dentry;
 
@@ -659,13 +659,13 @@
 }
 
 /**
- * driverfs_remove_dir - exportable directory removal
+ * kfs_remove_dir - exportable directory removal
  * @dir:	directory to remove
  *
  * To make sure we don't orphan anyone, first remove
  * all the children in the list, then do clean up the directory.
  */
-void driverfs_remove_dir(struct driver_dir_entry * dir)
+void kfs_remove_dir(struct driver_dir_entry * dir)
 {
 	struct list_head * node, * next;
 	struct dentry * dentry = dir->dentry;
@@ -700,9 +700,9 @@
 	put_mount();
 }
 
-EXPORT_SYMBOL(driverfs_create_file);
-EXPORT_SYMBOL(driverfs_create_symlink);
-EXPORT_SYMBOL(driverfs_create_dir);
-EXPORT_SYMBOL(driverfs_remove_file);
-EXPORT_SYMBOL(driverfs_remove_dir);
+EXPORT_SYMBOL(kfs_create_file);
+EXPORT_SYMBOL(kfs_create_symlink);
+EXPORT_SYMBOL(kfs_create_dir);
+EXPORT_SYMBOL(kfs_remove_file);
+EXPORT_SYMBOL(kfs_remove_dir);
 MODULE_LICENSE("GPL");
diff -Nru a/include/linux/kfs.h b/include/linux/kfs.h
--- a/include/linux/kfs.h	Mon Oct  7 15:40:20 2002
+++ b/include/linux/kfs.h	Mon Oct  7 15:40:20 2002
@@ -29,7 +29,7 @@
 struct driver_dir_entry;
 struct attribute;
 
-struct driverfs_ops {
+struct kfs_ops {
 	int	(*open)(struct driver_dir_entry *);
 	int	(*close)(struct driver_dir_entry *);
 	ssize_t	(*show)(struct driver_dir_entry *, struct attribute *,char *, size_t, loff_t);
@@ -40,7 +40,7 @@
 	char			* name;
 	struct dentry		* dentry;
 	mode_t			mode;
-	struct driverfs_ops	* ops;
+	struct kfs_ops	* ops;
 };
 
 struct attribute {
@@ -49,22 +49,20 @@
 };
 
 extern int
-driverfs_create_dir(struct driver_dir_entry *, struct driver_dir_entry *);
+kfs_create_dir(struct driver_dir_entry *, struct driver_dir_entry *);
 
 extern void
-driverfs_remove_dir(struct driver_dir_entry * entry);
+kfs_remove_dir(struct driver_dir_entry * entry);
 
 extern int
-driverfs_create_file(struct attribute * attr,
+kfs_create_file(struct attribute * attr,
 		     struct driver_dir_entry * parent);
 
 extern int 
-driverfs_create_symlink(struct driver_dir_entry * parent, 
+kfs_create_symlink(struct driver_dir_entry * parent, 
 			char * name, char * target);
 
 extern void
-driverfs_remove_file(struct driver_dir_entry *, const char * name);
-
-extern int init_driverfs_fs(void);
+kfs_remove_file(struct driver_dir_entry *, const char * name);
 
 #endif /* _DDFS_H_ */

