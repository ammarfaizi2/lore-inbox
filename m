Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTD3VdL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTD3VdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:33:10 -0400
Received: from smtp9.us.dell.com ([143.166.148.136]:25285 "EHLO
	smtp9.us.dell.com") by vger.kernel.org with ESMTP id S262373AbTD3Vcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:32:54 -0400
Date: Wed, 30 Apr 2003 16:45:14 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: greg@kroah.com, <alan@redhat.com>
cc: linux-kernel@vger.kernel.org, <jgarzik@redhat.com>
Subject: [RFC][PATCH] Dynamic PCI Device IDs
Message-ID: <Pine.LNX.4.44.0304301640450.8917-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg and Alan, for your consideration.

Patch below and at: 
http://domsch.com/linux/patches/dynids/linux-2.5/linux-2.5.68-dynids-20030416.patch.bz2

BK:  http://mdomsch.bkbits.net/linux-2.5-dynids

Feedback welcome.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

You can import this changeset into BK by piping this whole message to
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.1067, 2003-04-16 16:03:20-05:00, Matt_Domsch@dell.com
  Device Driver Dynamic PCI Device IDs
  
  Provides a mechanism to pass new PCI device IDs to device drivers
  at runtime, rather than relying only on a static compiled-in list
  of supported IDs.
  
  For each driver which has a pci_driver->probe routine, two things
  are added: a probe_it file, and a dynamic_id directory.  In the
  dynamic_id directory is a new file, new_id.
  
  /sys/bus/pci/drivers/e100
  |-- dynamic_id
  |   `-- new_id
  `-- probe_it
  
  One may read the new_id file, which by default returns:
  $ cat new_id
  echo vendor device subvendor subdevice class classmask
  where each field is a 32-bit value in ABCD (hex) format (no leading 0x).
  Pass only as many fields as you need to override the defaults below.
  Default vendor, device, subvendor, and subdevice fields
  are set to FFFFFFFF (PCI_ANY_ID).
  Default class and classmask fields are set to 0.
  
  One may write new PCI device IDs into the new_id file:
  echo "8086 1229" > new_id
  
  which will cause a new device ID (sysfs name 0) to be added to the driver.
  
  /sys/bus/pci/drivers/e100
  |-- dynamic_id
  |   |-- 0
  |   `-- new_id
  `-- probe_it
  
  $ cat 0
  00008086 00001229 ffffffff ffffffff 00000000 00000000
  
  One can then cause the driver to probe for devices again.
  echo 1 > probe_it
  
  Individual device drivers may override the behavior of the new_id
  file, for instance, if they need to also pass driver-specific
  information.  Likewise, reading the individual dynamic ID files
  can be overridden by the driver.
  
  This also adds an existance test field to struct driver_attribute,
  necessary because we only want the probe_it file to appear iff
  struct pci_driver->probe is non-NULL.
  
  The device probing routines in pci-driver.c are enhanced to scan
  first the static list of IDs, then the dynamic list (if any).
  


 drivers/pci/Makefile           |    2 
 drivers/pci/pci-driver.c       |  267 +++++++++++++++++++++++++++++++++++++----
 drivers/pci/pci-sysfs-dynids.c |  251 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h              |    1 
 include/linux/device.h         |   11 +
 include/linux/pci-dynids.h     |   40 ++++++
 include/linux/pci.h            |    2 
 7 files changed, 547 insertions(+), 27 deletions(-)


diff -Nru a/drivers/pci/Makefile b/drivers/pci/Makefile
--- a/drivers/pci/Makefile	Wed Apr 16 16:07:05 2003
+++ b/drivers/pci/Makefile	Wed Apr 16 16:07:05 2003
@@ -4,7 +4,7 @@
 
 obj-y		+= access.o bus.o probe.o pci.o pool.o quirks.o \
 			names.o pci-driver.o search.o hotplug.o \
-			pci-sysfs.o
+			pci-sysfs.o pci-sysfs-dynids.o
 obj-$(CONFIG_PM)  += power.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Wed Apr 16 16:07:05 2003
+++ b/drivers/pci/pci-driver.c	Wed Apr 16 16:07:05 2003
@@ -13,6 +13,26 @@
  */
 
 /**
+ * pci_match_one_device - Tell if a PCI device structure has a matching PCI device id structure
+ * @id: single PCI device id structure to match
+ * @dev: the PCI device structure to match against
+ * 
+ * Returns the matching pci_device_id structure or %NULL if there is no match.
+ */
+
+static inline const struct pci_device_id *
+pci_match_one_device(const struct pci_device_id *id, const struct pci_dev *dev)
+{
+	if ((id->vendor == PCI_ANY_ID || id->vendor == dev->vendor) &&
+	    (id->device == PCI_ANY_ID || id->device == dev->device) &&
+	    (id->subvendor == PCI_ANY_ID || id->subvendor == dev->subsystem_vendor) &&
+	    (id->subdevice == PCI_ANY_ID || id->subdevice == dev->subsystem_device) &&
+	    !((id->class ^ dev->class) & id->class_mask))
+		return id;
+	return NULL;
+}
+
+/**
  * pci_match_device - Tell if a PCI device structure has a matching PCI device id structure
  * @ids: array of PCI device id structures to search in
  * @dev: the PCI device structure to match against
@@ -25,17 +45,88 @@
 pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev)
 {
 	while (ids->vendor || ids->subvendor || ids->class_mask) {
-		if ((ids->vendor == PCI_ANY_ID || ids->vendor == dev->vendor) &&
-		    (ids->device == PCI_ANY_ID || ids->device == dev->device) &&
-		    (ids->subvendor == PCI_ANY_ID || ids->subvendor == dev->subsystem_vendor) &&
-		    (ids->subdevice == PCI_ANY_ID || ids->subdevice == dev->subsystem_device) &&
-		    !((ids->class ^ dev->class) & ids->class_mask))
-			return ids;
+		if (pci_match_one_device(ids, dev))
+		    return ids;
 		ids++;
 	}
 	return NULL;
 }
 
+/**
+ * pci_device_probe_static()
+ * 
+ * returns 0 and sets pci_dev->driver when drv claims pci_dev, else error.
+ */
+static int
+pci_device_probe_static(struct pci_driver *drv,
+			  struct pci_dev *pci_dev)
+{		   
+	int error = -ENODEV;
+	const struct pci_device_id *id;
+	
+	id = pci_match_device(drv->id_table, pci_dev);
+	if (id)
+		error = drv->probe(pci_dev, id);
+	if (error >= 0) {
+		pci_dev->driver = drv;
+		return 0;
+	}
+	return error;
+}
+
+/**
+ * pci_device_probe_dynamic()
+ * 
+ * Walk the dynamic ID list looking for a match.
+ * returns 0 and sets pci_dev->driver when drv claims pci_dev, else error.
+ */
+static int
+pci_device_probe_dynamic(struct pci_driver *drv,
+			   struct pci_dev *pci_dev)
+{		   
+	int error = -ENODEV;
+	struct list_head *pos;
+	struct dynid_attribute *dattr;
+	
+	spin_lock(&drv->dynids.lock);
+	list_for_each(pos, &drv->dynids.list) {
+		dattr = list_entry(pos, struct dynid_attribute, node);
+		if (pci_match_one_device(dattr->id, pci_dev)) {
+			spin_unlock(&drv->dynids.lock);
+			error = drv->probe(pci_dev, dattr->id);
+			if (error >= 0) {
+				pci_dev->driver = drv;
+				return 0;
+			}
+			return error;
+		}
+	}
+	spin_unlock(&drv->dynids.lock);
+	return error;
+}
+
+/**
+ * __pci_device_probe()
+ * 
+ * returns 0  on success, else error.
+ * side-effect: pci_dev->driver is set to drv when drv claims pci_dev.
+ */
+static int
+__pci_device_probe(struct pci_driver *drv,
+		   struct pci_dev *pci_dev)
+{		   
+	int error = 0;
+
+	if (!pci_dev->driver && drv->probe) {
+		error = pci_device_probe_static(drv, pci_dev);
+		if (error >= 0)
+			return error;
+
+		error = pci_device_probe_dynamic(drv, pci_dev);
+	}
+	return error;
+}
+
 static int pci_device_probe(struct device * dev)
 {
 	int error = 0;
@@ -44,17 +135,9 @@
 
 	drv = to_pci_driver(dev->driver);
 	pci_dev = to_pci_dev(dev);
-
-	if (!pci_dev->driver && drv->probe) {
-		const struct pci_device_id *id;
-
-		id = pci_match_device(drv->id_table, pci_dev);
-		if (id)
-			error = drv->probe(pci_dev, id);
-		if (error >= 0) {
-			pci_dev->driver = drv;
-			error = 0;
-		}
+	if (get_device(dev)) {
+		error = __pci_device_probe(drv, pci_dev);
+		put_device(dev);
 	}
 	return error;
 }
@@ -101,6 +184,122 @@
 	return 0;
 }
 
+/*
+ * Attribute to force driver probe for devices
+ * If __pci_device_probe() returns 0, it matched at least one previously
+ * unclaimed device.  If it returns -ENODEV, it didn't match.  Both are
+ * alright in this case, just keep searching for new devices.
+ */
+
+static int
+probe_each_pci_dev(struct pci_driver *drv)
+{
+	struct pci_dev *pci_dev=NULL;
+	int error = 0;
+	pci_for_each_dev(pci_dev) {
+		if (get_device(&pci_dev->dev)) {
+			error = __pci_device_probe(drv, pci_dev);
+			put_device(&pci_dev->dev);
+			if (error && error != -ENODEV)
+				return error;
+		}
+	}
+	return error;
+}
+
+static ssize_t
+store_probe_it(struct device_driver *driver, const char *buf, size_t count)
+{
+	int error = 0;
+	struct pci_driver *drv = to_pci_driver(driver);
+	int writeone = 0;
+	if (!((sscanf(buf, "%d", &writeone) == 1) && writeone == 1))
+		return -EINVAL;
+	
+	if (get_driver(driver)) {
+		error = probe_each_pci_dev(drv);
+		put_driver(driver);
+	}
+	if (error < 0)
+		return error;
+	return count;
+}
+
+static int
+probe_it_exists(struct device_driver *driver)
+{
+	struct pci_driver *pdrv = to_pci_driver(driver);
+	return pdrv->probe != NULL;
+}
+
+static DRIVER_ATTR_EXISTS(probe_it, S_IWUSR, NULL, store_probe_it, probe_it_exists);
+
+#define kobj_to_pci_driver(obj) container_of(obj, struct device_driver, kobj)
+#define attr_to_driver_attribute(obj) container_of(obj, struct driver_attribute, attr)
+
+static ssize_t
+pci_driver_attr_show(struct kobject * kobj, struct attribute *attr, char *buf)
+{
+	struct device_driver *driver = kobj_to_pci_driver(kobj);
+	struct driver_attribute *dattr = attr_to_driver_attribute(attr);
+	ssize_t ret = 0;
+
+	if (get_driver(driver)) {
+		if (dattr->show)
+			ret = dattr->show(driver, buf);
+		put_driver(driver);
+	}
+	return ret;
+}
+
+static ssize_t
+pci_driver_attr_store(struct kobject * kobj, struct attribute *attr,
+		      const char *buf, size_t count)
+{
+	struct device_driver *driver = kobj_to_pci_driver(kobj);
+	struct driver_attribute *dattr = attr_to_driver_attribute(attr);
+	ssize_t ret = 0;
+
+	if (get_driver(driver)) {
+		if (dattr->store)
+			ret = dattr->store(driver, buf, count);
+		put_driver(driver);
+	}
+	return ret;
+}
+
+static struct sysfs_ops pci_driver_sysfs_ops = {
+	.show = pci_driver_attr_show,
+	.store = pci_driver_attr_store,
+};
+static struct kobj_type pci_driver_kobj_type = {
+	.sysfs_ops     = &pci_driver_sysfs_ops,
+};
+static struct driver_attribute * driver_attrs[] = {
+	&driver_attr_probe_it,
+	NULL,
+};
+
+static void pci_populate_driver_dir(struct pci_driver * drv)
+{
+	struct driver_attribute * attr;
+	int error = 0, i;
+
+	for (i = 0; (attr = driver_attrs[i]) && !error; i++) {
+		if (!attr->exists || 
+		    (attr->exists && attr->exists(&drv->driver)))
+			error = sysfs_create_file(&drv->driver.kobj,&attr->attr);
+	}
+}
+
+static inline void
+pci_init_dynids(struct pci_dynamic_id_kobj *dynids)
+{
+	memset(dynids, 0, sizeof(*dynids));
+	spin_lock_init(&dynids->lock);
+	INIT_LIST_HEAD(&dynids->list);
+}
+
 /**
  * pci_register_driver - register a new pci driver
  * @drv: the driver structure to register
@@ -122,9 +321,17 @@
 	drv->driver.resume = pci_device_resume;
 	drv->driver.suspend = pci_device_suspend;
 	drv->driver.remove = pci_device_remove;
+	drv->driver.kobj.ktype = &pci_driver_kobj_type;
+	pci_init_dynids(&drv->dynids);
 
 	/* register with core */
 	count = driver_register(&drv->driver);
+
+	if (count >= 0) {
+		pci_populate_driver_dir(drv);
+		pci_register_dynids(drv);
+	}
+		
 	return count ? count : 1;
 }
 
@@ -180,22 +387,30 @@
  */
 static int pci_bus_match(struct device * dev, struct device_driver * drv) 
 {
-	struct pci_dev * pci_dev = to_pci_dev(dev);
+	const struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * pci_drv = to_pci_driver(drv);
 	const struct pci_device_id * ids = pci_drv->id_table;
+	const struct pci_device_id *found_id;
+	struct list_head *pos;
+	struct dynid_attribute *dattr;
 
-	if (!ids) 
+	if (!ids)
 		return 0;
 
-	while (ids->vendor || ids->subvendor || ids->class_mask) {
-		if ((ids->vendor == PCI_ANY_ID || ids->vendor == pci_dev->vendor) &&
-		    (ids->device == PCI_ANY_ID || ids->device == pci_dev->device) &&
-		    (ids->subvendor == PCI_ANY_ID || ids->subvendor == pci_dev->subsystem_vendor) &&
-		    (ids->subdevice == PCI_ANY_ID || ids->subdevice == pci_dev->subsystem_device) &&
-		    !((ids->class ^ pci_dev->class) & ids->class_mask))
+	found_id = pci_match_device(ids, pci_dev);
+	if (found_id) 
+		return 1;
+
+	spin_lock(&pci_drv->dynids.lock);
+	list_for_each(pos, &pci_drv->dynids.list) {
+		dattr = list_entry(pos, struct dynid_attribute, node);
+		if (pci_match_one_device(dattr->id, pci_dev)) {
+			spin_unlock(&pci_drv->dynids.lock);
 			return 1;
-		ids++;
+		}
 	}
+	spin_unlock(&pci_drv->dynids.lock);
+
 	return 0;
 }
 
diff -Nru a/drivers/pci/pci-sysfs-dynids.c b/drivers/pci/pci-sysfs-dynids.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pci/pci-sysfs-dynids.c	Wed Apr 16 16:07:05 2003
@@ -0,0 +1,251 @@
+/*
+ * linux/drivers/pci/pci-sysfs-dynids.c
+ *  Copyright (C) 2003 Dell Computer Corporation
+ *  by Matt Domsch <Matt_Domsch@dell.com>
+ *
+ * sysfs interface for exporting dynamic device IDs
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/stat.h>
+#include <linux/sysfs.h>
+#include <linux/pci-dynids.h>
+#include "pci.h"
+
+/**
+ *	dynid_create_file - create sysfs file for a dynamic ID
+ *	@pdrv:	pci_driver
+ *	@dattr:	the attribute to create
+ */
+static int dynid_create_file(struct pci_driver * pdrv, struct dynid_attribute * dattr)
+{
+	int error;
+
+	if (get_driver(&pdrv->driver)) {
+		error = sysfs_create_file(&pdrv->dynids.kobj,&dattr->attr);
+		put_driver(&pdrv->driver);
+	} else
+		error = -EINVAL;
+	return error;
+}
+
+/**
+ *	dynid_remove_file - remove sysfs file for a dynamic ID
+ *	@drv:	driver.
+ *	@id:	the id to to remove
+ */
+static void dynid_remove_file(struct pci_driver * pdrv, struct dynid_attribute * dattr)
+{
+	if (get_driver(&pdrv->driver)) {
+		sysfs_remove_file(&pdrv->dynids.kobj,&dattr->attr);
+		put_driver(&pdrv->driver);
+	}
+}
+
+#define kobj_to_dynids(obj) container_of(obj,struct pci_dynamic_id_kobj,kobj)
+#define dynids_to_pci_driver(obj) container_of(obj,struct pci_driver,dynids)
+#define attr_to_dattr(_attr) container_of(_attr, struct dynid_attribute, attr)
+
+static inline ssize_t
+default_show_id(const struct pci_device_id * id, char * buf)
+{
+	return snprintf(buf, PAGE_SIZE, "%08x %08x %08x %08x %08x %08x\n",
+			id->vendor,
+			id->device,
+			id->subvendor,
+			id->subdevice,
+			id->class,
+			id->class_mask);
+}
+
+static ssize_t
+dynid_show_id(struct pci_driver * pdrv, struct dynid_attribute *dattr, char *buf)
+{
+	return pdrv->dynids.show_id ?
+		pdrv->dynids.show_id(dattr->id, dattr, buf) :
+		default_show_id(dattr->id, buf);
+}	
+
+static ssize_t
+default_show_new_id(char * buf)
+{
+	char *p = buf;	
+	p += sprintf(p,
+		     "echo vendor device subvendor subdevice class classmask\n");
+	p += sprintf(p,
+		     "where each field is a 32-bit value in ABCD (hex) format (no leading 0x).\n");
+	p += sprintf(p,
+		     "Pass only as many fields as you need to override the defaults below.\n");
+	p += sprintf(p,
+		     "Default vendor, device, subvendor, and subdevice fields\n");
+	p += sprintf(p, "are set to FFFFFFFF (PCI_ANY_ID).\n");
+	p += sprintf(p,
+		     "Default class and classmask fields are set to 0.\n");
+	return p - buf;
+}
+
+static inline void
+__dattr_init(struct dynid_attribute *dattr)
+{
+	memset(dattr, 0, sizeof(*dattr));
+	INIT_LIST_HEAD(&dattr->node);
+	dattr->attr.mode = S_IRUGO;
+	dattr->attr.name = dattr->name;
+}
+
+static inline ssize_t
+default_store_new_id(struct pci_driver * pdrv, const char * buf, size_t count)
+{
+	struct dynid_attribute *dattr;
+	struct pci_device_id *id;
+	__u32 vendor=PCI_ANY_ID, device=PCI_ANY_ID, subvendor=PCI_ANY_ID,
+		subdevice=PCI_ANY_ID, class=0, class_mask=0;
+	int fields=0, error=0;
+
+	fields = sscanf(buf, "%x %x %x %x %x %x",
+			&vendor, &device, &subvendor, &subdevice,
+			&class, &class_mask);
+	if (fields < 0) return -EINVAL;
+
+	dattr = kmalloc(sizeof(*dattr), GFP_KERNEL);
+	if (!dattr) return -ENOMEM;
+	__dattr_init(dattr);
+	
+	id = kmalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		kfree(dattr);
+		return -ENOMEM;
+	}
+	dattr->id = id;
+	dattr->show = dynid_show_id;
+
+	id->vendor = vendor;
+	id->device = device;
+	id->subvendor = subvendor;
+	id->subdevice = subdevice;
+	id->class = class;
+	id->class_mask = class_mask;
+
+	spin_lock(&pdrv->dynids.lock);
+	snprintf(dattr->name, KOBJ_NAME_LEN, "%d", pdrv->dynids.nextname);
+	pdrv->dynids.nextname++;
+	spin_unlock(&pdrv->dynids.lock);
+	
+	error = dynid_create_file(pdrv,dattr);
+	if (error) {
+		kfree(id);
+		kfree(dattr);
+		return error;
+	}
+
+	spin_lock(&pdrv->dynids.lock);
+	list_add(&pdrv->dynids.list, &dattr->node);
+	spin_unlock(&pdrv->dynids.lock);
+	return count;
+}
+
+static ssize_t
+dynid_show_new_id(struct pci_driver * pdrv, struct dynid_attribute *unused, char * buf)
+{
+	return pdrv->dynids.show_new_id ?
+		pdrv->dynids.show_new_id(pdrv, buf) :
+		default_show_new_id(buf);
+}
+
+static ssize_t
+dynid_store_new_id(struct pci_driver * pdrv, struct dynid_attribute *unused, const char * buf, size_t count)
+{
+	return pdrv->dynids.store_new_id ?
+		pdrv->dynids.store_new_id(pdrv, buf, count) :
+		default_store_new_id(pdrv, buf, count);
+}
+
+#define DYNID_ATTR(_name,_mode,_show,_store) \
+struct dynid_attribute dynid_attr_##_name = { 		\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
+        .id   = NULL,                                   \
+	.show	= _show,				\
+	.store	= _store,				\
+}
+
+static DYNID_ATTR(new_id,S_IRUSR|S_IWUSR,dynid_show_new_id,dynid_store_new_id);
+
+static struct attribute * dynids_def_attrs[] = {
+	&dynid_attr_new_id.attr,
+	NULL,
+};
+
+static ssize_t
+dynid_show(struct kobject * kobj, struct attribute *attr, char *buf)
+{
+	struct pci_dynamic_id_kobj *dynid_kobj = kobj_to_dynids(kobj);
+	struct pci_driver *pdrv = dynids_to_pci_driver(dynid_kobj);
+	struct dynid_attribute *dattr = attr_to_dattr(attr);
+
+	if (dattr->show)
+		return dattr->show(pdrv, dattr, buf);
+	return -ENOSYS;
+}
+
+static ssize_t
+dynid_store(struct kobject * kobj, struct attribute *attr, const char *buf, size_t count)
+{
+	struct pci_dynamic_id_kobj *dynid_kobj = kobj_to_dynids(kobj);
+	struct pci_driver *pdrv = dynids_to_pci_driver(dynid_kobj);
+	struct dynid_attribute *dattr = attr_to_dattr(attr);
+	
+	if (dattr->store)
+		return dattr->store(pdrv, dattr, buf, count);
+	return -ENOSYS;
+}
+
+static void
+dynids_release(struct kobject *kobj)
+{
+	struct pci_dynamic_id_kobj *dynids = kobj_to_dynids(kobj);
+	struct pci_driver *pdrv = dynids_to_pci_driver(dynids);
+	struct list_head *pos, *n;
+	struct dynid_attribute *dattr;
+
+	spin_lock(&dynids->lock);
+	list_for_each_safe(pos, n, &dynids->list) {
+		dattr = list_entry(pos, struct dynid_attribute, node);
+		dynid_remove_file(pdrv, dattr);
+		list_del(&dattr->node);
+		if (dattr->id)
+			kfree(dattr->id);
+		kfree(dattr);
+	}
+	spin_unlock(&dynids->lock);
+}
+
+static struct sysfs_ops dynids_attr_ops = {
+	.show = dynid_show,
+	.store = dynid_store,
+};
+static struct kobj_type dynids_kobj_type = {
+	.release = dynids_release,
+	.sysfs_ops = &dynids_attr_ops,
+	.default_attrs = dynids_def_attrs,
+};
+
+/**
+ * pci_register_dynids - initialize and register driver dynamic_ids kobject
+ * @driver - the device_driver structure
+ * @dynids - the dynamic ids structure
+ */
+int
+pci_register_dynids(struct pci_driver *drv)
+{
+	struct device_driver *driver = &drv->driver;
+	struct pci_dynamic_id_kobj *dynids = &drv->dynids;
+	if (drv->probe) {
+		dynids->kobj.parent = &driver->kobj;
+		dynids->kobj.ktype = &dynids_kobj_type;
+		snprintf(dynids->kobj.name, KOBJ_NAME_LEN, "dynamic_id");
+		return kobject_register(&dynids->kobj);
+	}
+	return -ENODEV;
+}
+
diff -Nru a/drivers/pci/pci.h b/drivers/pci/pci.h
--- a/drivers/pci/pci.h	Wed Apr 16 16:07:05 2003
+++ b/drivers/pci/pci.h	Wed Apr 16 16:07:05 2003
@@ -3,3 +3,4 @@
 extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
 			 char *buffer, int buffer_size);
 extern void pci_create_sysfs_dev_files(struct pci_dev *pdev);
+extern int pci_register_dynids(struct pci_driver *drv);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Wed Apr 16 16:07:05 2003
+++ b/include/linux/device.h	Wed Apr 16 16:07:05 2003
@@ -144,6 +144,7 @@
 	struct attribute	attr;
 	ssize_t (*show)(struct device_driver *, char * buf);
 	ssize_t (*store)(struct device_driver *, const char * buf, size_t count);
+	int (*exists)(struct device_driver *);
 };
 
 #define DRIVER_ATTR(_name,_mode,_show,_store)	\
@@ -151,7 +152,17 @@
 	.attr = {.name = __stringify(_name), .mode = _mode },	\
 	.show	= _show,				\
 	.store	= _store,				\
+	.exists	= NULL,				        \
 };
+
+#define DRIVER_ATTR_EXISTS(_name,_mode,_show,_store,_exists)	\
+struct driver_attribute driver_attr_##_name = { 		\
+	.attr = {.name = __stringify(_name), .mode = _mode },	\
+	.show	= _show,				\
+	.store	= _store,				\
+	.exists	= _exists,				\
+};
+
 
 extern int driver_create_file(struct device_driver *, struct driver_attribute *);
 extern void driver_remove_file(struct device_driver *, struct driver_attribute *);
diff -Nru a/include/linux/pci-dynids.h b/include/linux/pci-dynids.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/pci-dynids.h	Wed Apr 16 16:07:05 2003
@@ -0,0 +1,40 @@
+/*
+ *	PCI defines and function prototypes
+ *	Copyright 2003 Dell Computer Corporation
+ *        by Matt Domsch <Matt_Domsch@dell.com>
+ */
+
+#ifndef LINUX_PCI_DYNIDS_H
+#define LINUX_PCI_DYNIDS_H
+
+#include <linux/mod_devicetable.h>
+#include <linux/types.h>
+#include <linux/config.h>
+#include <linux/list.h>
+#include <linux/device.h>
+#include <linux/pci.h>
+
+struct pci_driver;
+struct pci_device_id;
+
+struct dynid_attribute {
+	struct attribute	attr;
+	struct list_head        node;
+	struct pci_device_id   *id;
+	ssize_t (*show)(struct pci_driver * pdrv, struct dynid_attribute *dattr, char * buf);
+	ssize_t (*store)(struct pci_driver * pdrv, struct dynid_attribute *dattr, const char * buf, size_t count);
+	char name[KOBJ_NAME_LEN];
+};
+
+struct pci_dynamic_id_kobj {
+	ssize_t (*show_new_id)(struct pci_driver * pdrv, char * buf);
+	ssize_t (*store_new_id)(struct pci_driver * pdrv, const char * buf, size_t count);
+	ssize_t (*show_id)(struct pci_device_id * id, struct dynid_attribute *dattr, char * buf);
+
+	spinlock_t lock;            /* protects list, index */
+	struct list_head list;      /* for IDs added at runtime */
+	struct kobject kobj;        /* for displaying the list in sysfs */
+	unsigned int nextname;     /* name of next dynamic ID twhen created */
+};
+
+#endif
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Wed Apr 16 16:07:05 2003
+++ b/include/linux/pci.h	Wed Apr 16 16:07:05 2003
@@ -343,6 +343,7 @@
 #include <linux/list.h>
 #include <linux/errno.h>
 #include <linux/device.h>
+#include <linux/pci-dynids.h>
 
 /* File state for mmap()s on /proc/bus/pci/X/Y */
 enum pci_mmap_state {
@@ -502,6 +503,7 @@
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 
 	struct device_driver	driver;
+	struct pci_dynamic_id_kobj  dynids;
 };
 
 #define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)

===================================================================


This BitKeeper patch contains the following changesets:
1.1067
## Wrapped with gzip_uu ##


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
18:?;';3[MO&_R1:UPC-8    
 

