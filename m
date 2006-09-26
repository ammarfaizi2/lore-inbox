Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751422AbWIZFqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751422AbWIZFqu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWIZFqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:46:19 -0400
Received: from cantor2.suse.de ([195.135.220.15]:55765 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751422AbWIZFkC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:40:02 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 37/47] add __must_check to device management code
Date: Mon, 25 Sep 2006 22:37:57 -0700
Message-Id: <11592492023883-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.2.1
In-Reply-To: <1159249200793-git-send-email-greg@kroah.com>
References: <20060926053728.GA8970@kroah.com> <1159249087369-git-send-email-greg@kroah.com> <11592490903867-git-send-email-greg@kroah.com> <11592490933346-git-send-email-greg@kroah.com> <1159249096460-git-send-email-greg@kroah.com> <11592490993970-git-send-email-greg@kroah.com> <11592491023995-git-send-email-greg@kroah.com> <1159249104512-git-send-email-greg@kroah.com> <11592491082990-git-send-email-greg@kroah.com> <1159249111668-git-send-email-greg@kroah.com> <11592491152668-git-send-email-greg@kroah.com> <115924911859-git-send-email-greg@kroah.com> <11592491211162-git-send-email-greg@kroah.com> <1159249124371-git-send-email-greg@kroah.com> <11592491274168-git-send-email-greg@kroah.com> <11592491303012-git-send-email-greg@kroah.com> <11592491342421-git-send-email-greg@kroah.com> <11592491371254-git-send-email-greg@kroah.com> <1159249140339-git-send-email-greg@kroah.com> <11592491451786-git-send-email-greg@kroah.com> <11592491482560-git-send-email-greg@kroah.com> <11592491512
 235-git-send-email-greg@kroah.com> <11592491551919-git-send-email-greg@kroah.com> <11592491581007-git-send-email-greg@kroah.com> <11592491611339-git-send-email-greg@kroah.com> <11592491643725-git-send-email-greg@kroah.com> <11592491672052-git-send-email-greg@kroah.com> <11592491704137-git-send-email-greg@kroah.com> <11592491744040-git-send-email-greg@kroah.com> <1159249177618-git-send-email-greg@kroah.com> <11592491803904-git-send-email-greg@kroah.com> <11592491833450-git-send-email-greg@kroah.com> <11592491862904-git-send-email-greg@kroah.com> <11592491901464-git-send-email-greg@kroah.com> <11592491924093-git-send-email-greg@kroah.com> <1159249196427-git-send-email-greg@kroah.com> <1159249200793-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@osdl.org>

We're getting a lot of crashes in the sysfs/kobject/device/bus/class code and
they're very hard to diagnose.

I'm suspecting that in some cases this is because drivers aren't checking
return values and aren't handling errors correctly.  So the code blithely
blunders on and crashes later in very obscure ways.

There's just no reason to ignore errors which can and do occur.  So the patch
sprinkles __must_check all over these APIs.

Causes 1,513 new warnings.  Heh.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 include/linux/device.h  |   52 +++++++++++++++++++++++++----------------------
 include/linux/kobject.h |   16 ++++++++------
 include/linux/pci.h     |   34 ++++++++++++++++---------------
 include/linux/sysfs.h   |   19 ++++++++++-------
 4 files changed, 66 insertions(+), 55 deletions(-)

diff --git a/include/linux/device.h b/include/linux/device.h
index 7d447d7..ad4db72 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -15,6 +15,7 @@ #include <linux/ioport.h>
 #include <linux/kobject.h>
 #include <linux/klist.h>
 #include <linux/list.h>
+#include <linux/compiler.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/pm.h>
@@ -58,7 +59,7 @@ struct bus_type {
 	int (*resume)(struct device * dev);
 };
 
-extern int bus_register(struct bus_type * bus);
+extern int __must_check bus_register(struct bus_type * bus);
 extern void bus_unregister(struct bus_type * bus);
 
 extern void bus_rescan_devices(struct bus_type * bus);
@@ -70,9 +71,9 @@ int bus_for_each_dev(struct bus_type * b
 struct device * bus_find_device(struct bus_type *bus, struct device *start,
 				void *data, int (*match)(struct device *, void *));
 
-int bus_for_each_drv(struct bus_type * bus, struct device_driver * start, 
-		     void * data, int (*fn)(struct device_driver *, void *));
-
+int __must_check bus_for_each_drv(struct bus_type *bus,
+		struct device_driver *start, void *data,
+		int (*fn)(struct device_driver *, void *));
 
 /* driverfs interface for exporting bus attributes */
 
@@ -85,7 +86,8 @@ struct bus_attribute {
 #define BUS_ATTR(_name,_mode,_show,_store)	\
 struct bus_attribute bus_attr_##_name = __ATTR(_name,_mode,_show,_store)
 
-extern int bus_create_file(struct bus_type *, struct bus_attribute *);
+extern int __must_check bus_create_file(struct bus_type *,
+					struct bus_attribute *);
 extern void bus_remove_file(struct bus_type *, struct bus_attribute *);
 
 struct device_driver {
@@ -107,14 +109,13 @@ struct device_driver {
 };
 
 
-extern int driver_register(struct device_driver * drv);
+extern int __must_check driver_register(struct device_driver * drv);
 extern void driver_unregister(struct device_driver * drv);
 
 extern struct device_driver * get_driver(struct device_driver * drv);
 extern void put_driver(struct device_driver * drv);
 extern struct device_driver *driver_find(const char *name, struct bus_type *bus);
 
-
 /* driverfs interface for exporting driver attributes */
 
 struct driver_attribute {
@@ -126,16 +127,17 @@ struct driver_attribute {
 #define DRIVER_ATTR(_name,_mode,_show,_store)	\
 struct driver_attribute driver_attr_##_name = __ATTR(_name,_mode,_show,_store)
 
-extern int driver_create_file(struct device_driver *, struct driver_attribute *);
+extern int __must_check driver_create_file(struct device_driver *,
+					struct driver_attribute *);
 extern void driver_remove_file(struct device_driver *, struct driver_attribute *);
 
-extern int driver_for_each_device(struct device_driver * drv, struct device * start,
-				  void * data, int (*fn)(struct device *, void *));
+extern int __must_check driver_for_each_device(struct device_driver * drv,
+		struct device *start, void *data,
+		int (*fn)(struct device *, void *));
 struct device * driver_find_device(struct device_driver *drv,
 				   struct device *start, void *data,
 				   int (*match)(struct device *, void *));
 
-
 /*
  * device classes
  */
@@ -168,7 +170,7 @@ struct class {
 	int	(*resume)(struct device *);
 };
 
-extern int class_register(struct class *);
+extern int __must_check class_register(struct class *);
 extern void class_unregister(struct class *);
 
 
@@ -181,7 +183,8 @@ struct class_attribute {
 #define CLASS_ATTR(_name,_mode,_show,_store)			\
 struct class_attribute class_attr_##_name = __ATTR(_name,_mode,_show,_store) 
 
-extern int class_create_file(struct class *, const struct class_attribute *);
+extern int __must_check class_create_file(struct class *,
+					const struct class_attribute *);
 extern void class_remove_file(struct class *, const struct class_attribute *);
 
 struct class_device_attribute {
@@ -194,7 +197,7 @@ #define CLASS_DEVICE_ATTR(_name,_mode,_s
 struct class_device_attribute class_device_attr_##_name = 	\
 	__ATTR(_name,_mode,_show,_store)
 
-extern int class_device_create_file(struct class_device *,
+extern int __must_check class_device_create_file(struct class_device *,
 				    const struct class_device_attribute *);
 
 /**
@@ -254,10 +257,10 @@ class_set_devdata (struct class_device *
 }
 
 
-extern int class_device_register(struct class_device *);
+extern int __must_check class_device_register(struct class_device *);
 extern void class_device_unregister(struct class_device *);
 extern void class_device_initialize(struct class_device *);
-extern int class_device_add(struct class_device *);
+extern int __must_check class_device_add(struct class_device *);
 extern void class_device_del(struct class_device *);
 
 extern int class_device_rename(struct class_device *, char *);
@@ -267,7 +270,7 @@ extern void class_device_put(struct clas
 
 extern void class_device_remove_file(struct class_device *, 
 				     const struct class_device_attribute *);
-extern int class_device_create_bin_file(struct class_device *,
+extern int __must_check class_device_create_bin_file(struct class_device *,
 					struct bin_attribute *);
 extern void class_device_remove_bin_file(struct class_device *,
 					 struct bin_attribute *);
@@ -282,7 +285,7 @@ struct class_interface {
 	void (*remove_dev)	(struct device *, struct class_interface *);
 };
 
-extern int class_interface_register(struct class_interface *);
+extern int __must_check class_interface_register(struct class_interface *);
 extern void class_interface_unregister(struct class_interface *);
 
 extern struct class *class_create(struct module *owner, const char *name);
@@ -307,7 +310,8 @@ struct device_attribute {
 #define DEVICE_ATTR(_name,_mode,_show,_store) \
 struct device_attribute dev_attr_##_name = __ATTR(_name,_mode,_show,_store)
 
-extern int device_create_file(struct device *device, struct device_attribute * entry);
+extern int __must_check device_create_file(struct device *device,
+					struct device_attribute * entry);
 extern void device_remove_file(struct device * dev, struct device_attribute * attr);
 extern int __must_check device_create_bin_file(struct device *dev,
 					       struct bin_attribute *attr);
@@ -380,12 +384,12 @@ static inline int device_is_registered(s
 /*
  * High level routines for use by the bus drivers
  */
-extern int device_register(struct device * dev);
+extern int __must_check device_register(struct device * dev);
 extern void device_unregister(struct device * dev);
 extern void device_initialize(struct device * dev);
-extern int device_add(struct device * dev);
+extern int __must_check device_add(struct device * dev);
 extern void device_del(struct device * dev);
-extern int device_for_each_child(struct device *, void *,
+extern int __must_check device_for_each_child(struct device *, void *,
 		     int (*fn)(struct device *, void *));
 extern int device_rename(struct device *dev, char *new_name);
 
@@ -395,7 +399,7 @@ extern int device_rename(struct device *
  */
 extern void device_bind_driver(struct device * dev);
 extern void device_release_driver(struct device * dev);
-extern int  device_attach(struct device * dev);
+extern int  __must_check device_attach(struct device * dev);
 extern void driver_attach(struct device_driver * drv);
 extern void device_reprobe(struct device *dev);
 
@@ -433,7 +437,7 @@ extern void device_shutdown(void);
 
 
 /* drivers/base/firmware.c */
-extern int firmware_register(struct subsystem *);
+extern int __must_check firmware_register(struct subsystem *);
 extern void firmware_unregister(struct subsystem *);
 
 /* debugging and troubleshooting/diagnostic helpers. */
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index 2d22932..bcd9cd1 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -20,6 +20,7 @@ #ifdef __KERNEL__
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/sysfs.h>
+#include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/rwsem.h>
 #include <linux/kref.h>
@@ -71,12 +72,12 @@ static inline const char * kobject_name(
 extern void kobject_init(struct kobject *);
 extern void kobject_cleanup(struct kobject *);
 
-extern int kobject_add(struct kobject *);
+extern int __must_check kobject_add(struct kobject *);
 extern void kobject_del(struct kobject *);
 
-extern int kobject_rename(struct kobject *, const char *new_name);
+extern int __must_check kobject_rename(struct kobject *, const char *new_name);
 
-extern int kobject_register(struct kobject *);
+extern int __must_check kobject_register(struct kobject *);
 extern void kobject_unregister(struct kobject *);
 
 extern struct kobject * kobject_get(struct kobject *);
@@ -128,8 +129,8 @@ struct kset {
 
 
 extern void kset_init(struct kset * k);
-extern int kset_add(struct kset * k);
-extern int kset_register(struct kset * k);
+extern int __must_check kset_add(struct kset * k);
+extern int __must_check kset_register(struct kset * k);
 extern void kset_unregister(struct kset * k);
 
 static inline struct kset * to_kset(struct kobject * kobj)
@@ -239,7 +240,7 @@ #define subsys_set_kset(obj,_subsys) \
 	(obj)->subsys.kset.kobj.kset = &(_subsys).kset
 
 extern void subsystem_init(struct subsystem *);
-extern int subsystem_register(struct subsystem *);
+extern int __must_check subsystem_register(struct subsystem *);
 extern void subsystem_unregister(struct subsystem *);
 
 static inline struct subsystem * subsys_get(struct subsystem * s)
@@ -258,7 +259,8 @@ struct subsys_attribute {
 	ssize_t (*store)(struct subsystem *, const char *, size_t); 
 };
 
-extern int subsys_create_file(struct subsystem * , struct subsys_attribute *);
+extern int __must_check subsys_create_file(struct subsystem * ,
+					struct subsys_attribute *);
 
 #if defined(CONFIG_HOTPLUG)
 void kobject_uevent(struct kobject *kobj, enum kobject_action action);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9514bbf..3ec7255 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -49,6 +49,7 @@ #include <linux/mod_devicetable.h>
 #include <linux/types.h>
 #include <linux/ioport.h>
 #include <linux/list.h>
+#include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/device.h>
 
@@ -403,7 +404,7 @@ extern struct list_head pci_root_buses;	
 extern struct list_head pci_devices;	/* list of all devices */
 
 void pcibios_fixup_bus(struct pci_bus *);
-int pcibios_enable_device(struct pci_dev *, int mask);
+int __must_check pcibios_enable_device(struct pci_dev *, int mask);
 char *pcibios_setup (char *str);
 
 /* Used only when drivers/pci/setup.c is used */
@@ -490,19 +491,19 @@ static inline int pci_write_config_dword
 	return pci_bus_write_config_dword (dev->bus, dev->devfn, where, val);
 }
 
-int pci_enable_device(struct pci_dev *dev);
-int pci_enable_device_bars(struct pci_dev *dev, int mask);
+int __must_check pci_enable_device(struct pci_dev *dev);
+int __must_check pci_enable_device_bars(struct pci_dev *dev, int mask);
 void pci_disable_device(struct pci_dev *dev);
 void pci_set_master(struct pci_dev *dev);
 #define HAVE_PCI_SET_MWI
-int pci_set_mwi(struct pci_dev *dev);
+int __must_check pci_set_mwi(struct pci_dev *dev);
 void pci_clear_mwi(struct pci_dev *dev);
 void pci_intx(struct pci_dev *dev, int enable);
 int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
 int pci_set_consistent_dma_mask(struct pci_dev *dev, u64 mask);
 void pci_update_resource(struct pci_dev *dev, struct resource *res, int resno);
-int pci_assign_resource(struct pci_dev *dev, int i);
-int pci_assign_resource_fixed(struct pci_dev *dev, int i);
+int __must_check pci_assign_resource(struct pci_dev *dev, int i);
+int __must_check pci_assign_resource_fixed(struct pci_dev *dev, int i);
 void pci_restore_bars(struct pci_dev *dev);
 
 /* ROM control related routines */
@@ -528,23 +529,24 @@ void pdev_sort_resources(struct pci_dev 
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS	2
-int pci_request_regions(struct pci_dev *, const char *);
+int __must_check pci_request_regions(struct pci_dev *, const char *);
 void pci_release_regions(struct pci_dev *);
-int pci_request_region(struct pci_dev *, int, const char *);
+int __must_check pci_request_region(struct pci_dev *, int, const char *);
 void pci_release_region(struct pci_dev *, int);
 
 /* drivers/pci/bus.c */
-int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
-			   resource_size_t size, resource_size_t align,
-			   resource_size_t min, unsigned int type_mask,
-			   void (*alignf)(void *, struct resource *,
-					  resource_size_t, resource_size_t),
-			   void *alignf_data);
+int __must_check pci_bus_alloc_resource(struct pci_bus *bus,
+			struct resource *res, resource_size_t size,
+			resource_size_t align, resource_size_t min,
+			unsigned int type_mask,
+			void (*alignf)(void *, struct resource *,
+				resource_size_t, resource_size_t),
+			void *alignf_data);
 void pci_enable_bridges(struct pci_bus *bus);
 
 /* Proper probing supporting hot-pluggable devices */
-int __pci_register_driver(struct pci_driver *, struct module *);
-static inline int pci_register_driver(struct pci_driver *driver)
+int __must_check __pci_register_driver(struct pci_driver *, struct module *);
+static inline int __must_check pci_register_driver(struct pci_driver *driver)
 {
 	return __pci_register_driver(driver, THIS_MODULE);
 }
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 95f6db5..02ad790 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -10,6 +10,7 @@
 #ifndef _SYSFS_H_
 #define _SYSFS_H_
 
+#include <linux/compiler.h>
 #include <asm/atomic.h>
 
 struct kobject;
@@ -86,37 +87,39 @@ #define SYSFS_NOT_PINNED	(SYSFS_KOBJ_ATT
 
 #ifdef CONFIG_SYSFS
 
-extern int
+extern int __must_check
 sysfs_create_dir(struct kobject *);
 
 extern void
 sysfs_remove_dir(struct kobject *);
 
-extern int
+extern int __must_check
 sysfs_rename_dir(struct kobject *, const char *new_name);
 
-extern int
+extern int __must_check
 sysfs_create_file(struct kobject *, const struct attribute *);
 
-extern int
+extern int __must_check
 sysfs_update_file(struct kobject *, const struct attribute *);
 
-extern int
+extern int __must_check
 sysfs_chmod_file(struct kobject *kobj, struct attribute *attr, mode_t mode);
 
 extern void
 sysfs_remove_file(struct kobject *, const struct attribute *);
 
-extern int
+extern int __must_check
 sysfs_create_link(struct kobject * kobj, struct kobject * target, const char * name);
 
 extern void
 sysfs_remove_link(struct kobject *, const char * name);
 
-int sysfs_create_bin_file(struct kobject * kobj, struct bin_attribute * attr);
+int __must_check sysfs_create_bin_file(struct kobject *kobj,
+					struct bin_attribute *attr);
 void sysfs_remove_bin_file(struct kobject *kobj, struct bin_attribute *attr);
 
-int sysfs_create_group(struct kobject *, const struct attribute_group *);
+int __must_check sysfs_create_group(struct kobject *,
+					const struct attribute_group *);
 void sysfs_remove_group(struct kobject *, const struct attribute_group *);
 void sysfs_notify(struct kobject * k, char *dir, char *attr);
 
-- 
1.4.2.1

