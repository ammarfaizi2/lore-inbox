Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTEVVvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 17:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbTEVVvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 17:51:50 -0400
Received: from granite.he.net ([216.218.226.66]:42251 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263310AbTEVVvA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 17:51:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10536411592031@kroah.com>
Subject: Re: [PATCH] PCI changes for 2.5.69
In-Reply-To: <10536411591193@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 22 May 2003 15:05:59 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1042.117.2, 2003/05/05 13:00:19-05:00, Matt_Domsch@dell.com

Shrink dynids feature set

Per recommendation from GregKH:
Remove directory 'dynamic_id'
Remove exporting dynamic_id/0 files
Remove probe_it driver attribute
Move new_id into driver directory as a driver attribute.  Make it
probe when new IDs are added.
Move attribute existance test into pci-driver.c completely.



 drivers/pci/pci-sysfs-dynids.c |  251 -----------------------------------------
 drivers/pci/Makefile           |    2 
 drivers/pci/pci-driver.c       |  110 +++++++++++------
 drivers/pci/pci.h              |    1 
 include/linux/device.h         |   11 -
 include/linux/pci-dynids.h     |   28 ----
 include/linux/pci.h            |   20 ++-
 7 files changed, 91 insertions(+), 332 deletions(-)


diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Thu May 22 14:52:46 2003
+++ b/drivers/pci/Makefile	Thu May 22 14:52:46 2003
@@ -4,7 +4,7 @@
 
 obj-y		+= access.o bus.o probe.o pci.o pool.o quirks.o \
 			names.o pci-driver.o search.o hotplug.o \
-			pci-sysfs.o pci-sysfs-dynids.o
+			pci-sysfs.o
 obj-$(CONFIG_PM)  += power.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Thu May 22 14:52:46 2003
+++ b/drivers/pci/pci-driver.c	Thu May 22 14:52:46 2003
@@ -6,6 +6,8 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/device.h>
+#include <linux/pci-dynids.h>
 #include "pci.h"
 
 /*
@@ -86,14 +88,14 @@
 {		   
 	int error = -ENODEV;
 	struct list_head *pos;
-	struct dynid_attribute *dattr;
+	struct dynid *dynid;
 	
 	spin_lock(&drv->dynids.lock);
 	list_for_each(pos, &drv->dynids.list) {
-		dattr = list_entry(pos, struct dynid_attribute, node);
-		if (pci_match_one_device(dattr->id, pci_dev)) {
+		dynid = list_entry(pos, struct dynid, node);
+		if (pci_match_one_device(&dynid->id, pci_dev)) {
 			spin_unlock(&drv->dynids.lock);
-			error = drv->probe(pci_dev, dattr->id);
+			error = drv->probe(pci_dev, &dynid->id);
 			if (error >= 0) {
 				pci_dev->driver = drv;
 				return 0;
@@ -185,7 +187,6 @@
 }
 
 /*
- * Attribute to force driver probe for devices
  * If __pci_device_probe() returns 0, it matched at least one previously
  * unclaimed device.  If it returns -ENODEV, it didn't match.  Both are
  * alright in this case, just keep searching for new devices.
@@ -207,32 +208,66 @@
 	return error;
 }
 
-static ssize_t
-store_probe_it(struct device_driver *driver, const char *buf, size_t count)
+static inline void
+dynid_init(struct dynid *dynid)
 {
-	int error = 0;
-	struct pci_driver *drv = to_pci_driver(driver);
-	int writeone = 0;
-	if (!((sscanf(buf, "%d", &writeone) == 1) && writeone == 1))
-		return -EINVAL;
-	
-	if (get_driver(driver)) {
-		error = probe_each_pci_dev(drv);
-		put_driver(driver);
-	}
-	if (error < 0)
-		return error;
-	return count;
+	memset(dynid, 0, sizeof(*dynid));
+	INIT_LIST_HEAD(&dynid->node);
 }
 
-static int
-probe_it_exists(struct device_driver *driver)
+/**
+ * store_new_id
+ * @ pdrv
+ * @ buf
+ * @ count
+ *
+ * Adds a new dynamic pci device ID to this driver,
+ * and causes the driver to probe for all devices again.
+ */
+static inline ssize_t
+store_new_id(struct device_driver * driver, const char * buf, size_t count)
 {
+	struct dynid *dynid;
 	struct pci_driver *pdrv = to_pci_driver(driver);
-	return pdrv->probe != NULL;
+	__u32 vendor=PCI_ANY_ID, device=PCI_ANY_ID, subvendor=PCI_ANY_ID,
+		subdevice=PCI_ANY_ID, class=0, class_mask=0;
+	unsigned long driver_data=0;
+	int fields=0, error=0;
+
+	fields = sscanf(buf, "%x %x %x %x %x %x %lux",
+			&vendor, &device, &subvendor, &subdevice,
+			&class, &class_mask, &driver_data);
+	if (fields < 0) return -EINVAL;
+
+	dynid = kmalloc(sizeof(*dynid), GFP_KERNEL);
+	if (!dynid) return -ENOMEM;
+	dynid_init(dynid);
+
+	dynid->id.vendor = vendor;
+	dynid->id.device = device;
+	dynid->id.subvendor = subvendor;
+	dynid->id.subdevice = subdevice;
+	dynid->id.class = class;
+	dynid->id.class_mask = class_mask;
+	dynid->id.driver_data = pdrv->dynids.use_driver_data ? driver_data : 0UL;
+
+	spin_lock(&pdrv->dynids.lock);
+	list_add(&pdrv->dynids.list, &dynid->node);
+	spin_unlock(&pdrv->dynids.lock);
+
+        if (get_driver(&pdrv->driver)) {
+                error = probe_each_pci_dev(pdrv);
+                put_driver(&pdrv->driver);
+        }
+        if (error < 0)
+                return error;
+        return count;
+
+
+	return count;
 }
 
-static DRIVER_ATTR_EXISTS(probe_it, S_IWUSR, NULL, store_probe_it, probe_it_exists);
+static DRIVER_ATTR(new_id, S_IWUSR, NULL, store_new_id);
 
 #define kobj_to_pci_driver(obj) container_of(obj, struct device_driver, kobj)
 #define attr_to_driver_attribute(obj) container_of(obj, struct driver_attribute, attr)
@@ -275,25 +310,19 @@
 static struct kobj_type pci_driver_kobj_type = {
 	.sysfs_ops     = &pci_driver_sysfs_ops,
 };
-static struct driver_attribute * driver_attrs[] = {
-	&driver_attr_probe_it,
-	NULL,
-};
 
-static void pci_populate_driver_dir(struct pci_driver * drv)
+static int
+pci_populate_driver_dir(struct pci_driver * drv)
 {
-	struct driver_attribute * attr;
-	int error = 0, i;
+	int error = 0;
 
-	for (i = 0; (attr = driver_attrs[i]) && !error; i++) {
-		if (!attr->exists || 
-		    (attr->exists && attr->exists(&drv->driver)))
-			error = sysfs_create_file(&drv->driver.kobj,&attr->attr);
-	}
+	if (drv->probe != NULL)
+		error = sysfs_create_file(&drv->driver.kobj,&driver_attr_new_id.attr);
+	return error;
 }
 
 static inline void
-pci_init_dynids(struct pci_dynamic_id_kobj *dynids)
+pci_init_dynids(struct pci_dynids *dynids)
 {
 	memset(dynids, 0, sizeof(*dynids));
 	spin_lock_init(&dynids->lock);
@@ -329,7 +358,6 @@
 
 	if (count >= 0) {
 		pci_populate_driver_dir(drv);
-		pci_register_dynids(drv);
 	}
 		
 	return count ? count : 1;
@@ -392,7 +420,7 @@
 	const struct pci_device_id * ids = pci_drv->id_table;
 	const struct pci_device_id *found_id;
 	struct list_head *pos;
-	struct dynid_attribute *dattr;
+	struct dynid *dynid;
 
 	if (!ids)
 		return 0;
@@ -403,8 +431,8 @@
 
 	spin_lock(&pci_drv->dynids.lock);
 	list_for_each(pos, &pci_drv->dynids.list) {
-		dattr = list_entry(pos, struct dynid_attribute, node);
-		if (pci_match_one_device(dattr->id, pci_dev)) {
+		dynid = list_entry(pos, struct dynid, node);
+		if (pci_match_one_device(&dynid->id, pci_dev)) {
 			spin_unlock(&pci_drv->dynids.lock);
 			return 1;
 		}
diff -Nru a/drivers/pci/pci-sysfs-dynids.c b/drivers/pci/pci-sysfs-dynids.c
--- a/drivers/pci/pci-sysfs-dynids.c	Thu May 22 14:52:46 2003
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,251 +0,0 @@
-/*
- * linux/drivers/pci/pci-sysfs-dynids.c
- *  Copyright (C) 2003 Dell Computer Corporation
- *  by Matt Domsch <Matt_Domsch@dell.com>
- *
- * sysfs interface for exporting dynamic device IDs
- */
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/stat.h>
-#include <linux/sysfs.h>
-#include <linux/pci-dynids.h>
-#include "pci.h"
-
-/**
- *	dynid_create_file - create sysfs file for a dynamic ID
- *	@pdrv:	pci_driver
- *	@dattr:	the attribute to create
- */
-static int dynid_create_file(struct pci_driver * pdrv, struct dynid_attribute * dattr)
-{
-	int error;
-
-	if (get_driver(&pdrv->driver)) {
-		error = sysfs_create_file(&pdrv->dynids.kobj,&dattr->attr);
-		put_driver(&pdrv->driver);
-	} else
-		error = -EINVAL;
-	return error;
-}
-
-/**
- *	dynid_remove_file - remove sysfs file for a dynamic ID
- *	@drv:	driver.
- *	@id:	the id to to remove
- */
-static void dynid_remove_file(struct pci_driver * pdrv, struct dynid_attribute * dattr)
-{
-	if (get_driver(&pdrv->driver)) {
-		sysfs_remove_file(&pdrv->dynids.kobj,&dattr->attr);
-		put_driver(&pdrv->driver);
-	}
-}
-
-#define kobj_to_dynids(obj) container_of(obj,struct pci_dynamic_id_kobj,kobj)
-#define dynids_to_pci_driver(obj) container_of(obj,struct pci_driver,dynids)
-#define attr_to_dattr(_attr) container_of(_attr, struct dynid_attribute, attr)
-
-static inline ssize_t
-default_show_id(const struct pci_device_id * id, char * buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%08x %08x %08x %08x %08x %08x\n",
-			id->vendor,
-			id->device,
-			id->subvendor,
-			id->subdevice,
-			id->class,
-			id->class_mask);
-}
-
-static ssize_t
-dynid_show_id(struct pci_driver * pdrv, struct dynid_attribute *dattr, char *buf)
-{
-	return pdrv->dynids.show_id ?
-		pdrv->dynids.show_id(dattr->id, dattr, buf) :
-		default_show_id(dattr->id, buf);
-}	
-
-static ssize_t
-default_show_new_id(char * buf)
-{
-	char *p = buf;	
-	p += sprintf(p,
-		     "echo vendor device subvendor subdevice class classmask\n");
-	p += sprintf(p,
-		     "where each field is a 32-bit value in ABCD (hex) format (no leading 0x).\n");
-	p += sprintf(p,
-		     "Pass only as many fields as you need to override the defaults below.\n");
-	p += sprintf(p,
-		     "Default vendor, device, subvendor, and subdevice fields\n");
-	p += sprintf(p, "are set to FFFFFFFF (PCI_ANY_ID).\n");
-	p += sprintf(p,
-		     "Default class and classmask fields are set to 0.\n");
-	return p - buf;
-}
-
-static inline void
-__dattr_init(struct dynid_attribute *dattr)
-{
-	memset(dattr, 0, sizeof(*dattr));
-	INIT_LIST_HEAD(&dattr->node);
-	dattr->attr.mode = S_IRUGO;
-	dattr->attr.name = dattr->name;
-}
-
-static inline ssize_t
-default_store_new_id(struct pci_driver * pdrv, const char * buf, size_t count)
-{
-	struct dynid_attribute *dattr;
-	struct pci_device_id *id;
-	__u32 vendor=PCI_ANY_ID, device=PCI_ANY_ID, subvendor=PCI_ANY_ID,
-		subdevice=PCI_ANY_ID, class=0, class_mask=0;
-	int fields=0, error=0;
-
-	fields = sscanf(buf, "%x %x %x %x %x %x",
-			&vendor, &device, &subvendor, &subdevice,
-			&class, &class_mask);
-	if (fields < 0) return -EINVAL;
-
-	dattr = kmalloc(sizeof(*dattr), GFP_KERNEL);
-	if (!dattr) return -ENOMEM;
-	__dattr_init(dattr);
-	
-	id = kmalloc(sizeof(*id), GFP_KERNEL);
-	if (!id) {
-		kfree(dattr);
-		return -ENOMEM;
-	}
-	dattr->id = id;
-	dattr->show = dynid_show_id;
-
-	id->vendor = vendor;
-	id->device = device;
-	id->subvendor = subvendor;
-	id->subdevice = subdevice;
-	id->class = class;
-	id->class_mask = class_mask;
-
-	spin_lock(&pdrv->dynids.lock);
-	snprintf(dattr->name, KOBJ_NAME_LEN, "%d", pdrv->dynids.nextname);
-	pdrv->dynids.nextname++;
-	spin_unlock(&pdrv->dynids.lock);
-	
-	error = dynid_create_file(pdrv,dattr);
-	if (error) {
-		kfree(id);
-		kfree(dattr);
-		return error;
-	}
-
-	spin_lock(&pdrv->dynids.lock);
-	list_add(&pdrv->dynids.list, &dattr->node);
-	spin_unlock(&pdrv->dynids.lock);
-	return count;
-}
-
-static ssize_t
-dynid_show_new_id(struct pci_driver * pdrv, struct dynid_attribute *unused, char * buf)
-{
-	return pdrv->dynids.show_new_id ?
-		pdrv->dynids.show_new_id(pdrv, buf) :
-		default_show_new_id(buf);
-}
-
-static ssize_t
-dynid_store_new_id(struct pci_driver * pdrv, struct dynid_attribute *unused, const char * buf, size_t count)
-{
-	return pdrv->dynids.store_new_id ?
-		pdrv->dynids.store_new_id(pdrv, buf, count) :
-		default_store_new_id(pdrv, buf, count);
-}
-
-#define DYNID_ATTR(_name,_mode,_show,_store) \
-struct dynid_attribute dynid_attr_##_name = { 		\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
-        .id   = NULL,                                   \
-	.show	= _show,				\
-	.store	= _store,				\
-}
-
-static DYNID_ATTR(new_id,S_IRUSR|S_IWUSR,dynid_show_new_id,dynid_store_new_id);
-
-static struct attribute * dynids_def_attrs[] = {
-	&dynid_attr_new_id.attr,
-	NULL,
-};
-
-static ssize_t
-dynid_show(struct kobject * kobj, struct attribute *attr, char *buf)
-{
-	struct pci_dynamic_id_kobj *dynid_kobj = kobj_to_dynids(kobj);
-	struct pci_driver *pdrv = dynids_to_pci_driver(dynid_kobj);
-	struct dynid_attribute *dattr = attr_to_dattr(attr);
-
-	if (dattr->show)
-		return dattr->show(pdrv, dattr, buf);
-	return -ENOSYS;
-}
-
-static ssize_t
-dynid_store(struct kobject * kobj, struct attribute *attr, const char *buf, size_t count)
-{
-	struct pci_dynamic_id_kobj *dynid_kobj = kobj_to_dynids(kobj);
-	struct pci_driver *pdrv = dynids_to_pci_driver(dynid_kobj);
-	struct dynid_attribute *dattr = attr_to_dattr(attr);
-	
-	if (dattr->store)
-		return dattr->store(pdrv, dattr, buf, count);
-	return -ENOSYS;
-}
-
-static void
-dynids_release(struct kobject *kobj)
-{
-	struct pci_dynamic_id_kobj *dynids = kobj_to_dynids(kobj);
-	struct pci_driver *pdrv = dynids_to_pci_driver(dynids);
-	struct list_head *pos, *n;
-	struct dynid_attribute *dattr;
-
-	spin_lock(&dynids->lock);
-	list_for_each_safe(pos, n, &dynids->list) {
-		dattr = list_entry(pos, struct dynid_attribute, node);
-		dynid_remove_file(pdrv, dattr);
-		list_del(&dattr->node);
-		if (dattr->id)
-			kfree(dattr->id);
-		kfree(dattr);
-	}
-	spin_unlock(&dynids->lock);
-}
-
-static struct sysfs_ops dynids_attr_ops = {
-	.show = dynid_show,
-	.store = dynid_store,
-};
-static struct kobj_type dynids_kobj_type = {
-	.release = dynids_release,
-	.sysfs_ops = &dynids_attr_ops,
-	.default_attrs = dynids_def_attrs,
-};
-
-/**
- * pci_register_dynids - initialize and register driver dynamic_ids kobject
- * @driver - the device_driver structure
- * @dynids - the dynamic ids structure
- */
-int
-pci_register_dynids(struct pci_driver *drv)
-{
-	struct device_driver *driver = &drv->driver;
-	struct pci_dynamic_id_kobj *dynids = &drv->dynids;
-	if (drv->probe) {
-		dynids->kobj.parent = &driver->kobj;
-		dynids->kobj.ktype = &dynids_kobj_type;
-		snprintf(dynids->kobj.name, KOBJ_NAME_LEN, "dynamic_id");
-		return kobject_register(&dynids->kobj);
-	}
-	return -ENODEV;
-}
-
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	Thu May 22 14:52:46 2003
+++ b/drivers/pci/pci.h	Thu May 22 14:52:46 2003
@@ -3,4 +3,3 @@
 extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
 			 char *buffer, int buffer_size);
 extern void pci_create_sysfs_dev_files(struct pci_dev *pdev);
-extern int pci_register_dynids(struct pci_driver *drv);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Thu May 22 14:52:46 2003
+++ b/include/linux/device.h	Thu May 22 14:52:46 2003
@@ -143,7 +143,6 @@
 	struct attribute	attr;
 	ssize_t (*show)(struct device_driver *, char * buf);
 	ssize_t (*store)(struct device_driver *, const char * buf, size_t count);
-	int (*exists)(struct device_driver *);
 };
 
 #define DRIVER_ATTR(_name,_mode,_show,_store)	\
@@ -151,17 +150,7 @@
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.show	= _show,				\
 	.store	= _store,				\
-	.exists	= NULL,				        \
 };
-
-#define DRIVER_ATTR_EXISTS(_name,_mode,_show,_store,_exists)	\
-struct driver_attribute driver_attr_##_name = { 		\
-	.attr = {.name = __stringify(_name), .mode = _mode },	\
-	.show	= _show,				\
-	.store	= _store,				\
-	.exists	= _exists,				\
-};
-
 
 extern int driver_create_file(struct device_driver *, struct driver_attribute *);
 extern void driver_remove_file(struct device_driver *, struct driver_attribute *);
diff -Nru a/include/linux/pci-dynids.h b/include/linux/pci-dynids.h
--- a/include/linux/pci-dynids.h	Thu May 22 14:52:46 2003
+++ b/include/linux/pci-dynids.h	Thu May 22 14:52:46 2003
@@ -7,34 +7,12 @@
 #ifndef LINUX_PCI_DYNIDS_H
 #define LINUX_PCI_DYNIDS_H
 
-#include <linux/mod_devicetable.h>
-#include <linux/types.h>
-#include <linux/config.h>
 #include <linux/list.h>
-#include <linux/device.h>
-#include <linux/pci.h>
-
-struct pci_driver;
-struct pci_device_id;
+#include <linux/mod_devicetable.h>
 
-struct dynid_attribute {
-	struct attribute	attr;
+struct dynid {
 	struct list_head        node;
-	struct pci_device_id   *id;
-	ssize_t (*show)(struct pci_driver * pdrv, struct dynid_attribute *dattr, char * buf);
-	ssize_t (*store)(struct pci_driver * pdrv, struct dynid_attribute *dattr, const char * buf, size_t count);
-	char name[KOBJ_NAME_LEN];
-};
-
-struct pci_dynamic_id_kobj {
-	ssize_t (*show_new_id)(struct pci_driver * pdrv, char * buf);
-	ssize_t (*store_new_id)(struct pci_driver * pdrv, const char * buf, size_t count);
-	ssize_t (*show_id)(struct pci_device_id * id, struct dynid_attribute *dattr, char * buf);
-
-	spinlock_t lock;            /* protects list, index */
-	struct list_head list;      /* for IDs added at runtime */
-	struct kobject kobj;        /* for displaying the list in sysfs */
-	unsigned int nextname;     /* name of next dynamic ID twhen created */
+	struct pci_device_id    id;
 };
 
 #endif
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Thu May 22 14:52:46 2003
+++ b/include/linux/pci.h	Thu May 22 14:52:46 2003
@@ -343,7 +343,6 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/device.h>
-#include <linux/pci-dynids.h>
 
 /* File state for mmap()s on /proc/bus/pci/X/Y */
 enum pci_mmap_state {
@@ -491,6 +490,12 @@
 	unsigned long end;
 };
 
+struct pci_dynids {
+	spinlock_t lock;            /* protects list, index */
+	struct list_head list;      /* for IDs added at runtime */
+	unsigned int use_driver_data:1; /* pci_driver->driver_data is used */
+};
+
 struct pci_driver {
 	struct list_head node;
 	char *name;
@@ -503,12 +508,14 @@
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 
 	struct device_driver	driver;
-	struct pci_dynamic_id_kobj  dynids;
+	struct pci_dynids dynids;
 };
 
 #define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)
 
 
+
+
 /* these external functions are only available when PCI support is enabled */
 #ifdef CONFIG_PCI
 
@@ -704,6 +711,12 @@
 			 struct pci_bus_wrapped *wrapped_parent);
 extern int pci_remove_device_safe(struct pci_dev *dev);
 
+static inline void
+pci_dynids_set_use_driver_data(struct pci_driver *pdrv, int val)
+{
+	pdrv->dynids.use_driver_data = val;
+}
+
 #endif /* CONFIG_PCI */
 
 /* Include architecture-dependent settings and functions */
@@ -752,6 +765,7 @@
 static inline int scsi_to_pci_dma_dir(unsigned char scsi_dir) { return scsi_dir; }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
+static inline void pci_dynids_set_use_driver_data(struct pci_driver *pdrv, int val) { }
 
 /* Power management related routines */
 static inline int pci_save_state(struct pci_dev *dev, u32 *buffer) { return 0; }
@@ -763,6 +777,8 @@
 	for(dev = NULL; 0; )
 
 #define	isa_bridge	((struct pci_dev *)NULL)
+
+
 
 #else
 

