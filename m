Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTEVVzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 17:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTEVVxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 17:53:52 -0400
Received: from granite.he.net ([216.218.226.66]:44811 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263338AbTEVVvG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 17:51:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10536411591193@kroah.com>
Subject: [PATCH] PCI changes for 2.5.69
In-Reply-To: <20030522220251.GA6814@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 22 May 2003 15:05:59 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1042.9.1, 2003/04/16 16:03:20-05:00, Matt_Domsch@dell.com

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
--- a/drivers/pci/Makefile	Thu May 22 14:54:18 2003
+++ b/drivers/pci/Makefile	Thu May 22 14:54:18 2003
@@ -4,7 +4,7 @@
 
 obj-y		+= access.o bus.o probe.o pci.o pool.o quirks.o \
 			names.o pci-driver.o search.o hotplug.o \
-			pci-sysfs.o
+			pci-sysfs.o pci-sysfs-dynids.o
 obj-$(CONFIG_PM)  += power.o
 obj-$(CONFIG_PROC_FS) += proc.o
 
diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Thu May 22 14:54:18 2003
+++ b/drivers/pci/pci-driver.c	Thu May 22 14:54:18 2003
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
+++ b/drivers/pci/pci-sysfs-dynids.c	Thu May 22 14:54:18 2003
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
--- a/drivers/pci/pci.h	Thu May 22 14:54:18 2003
+++ b/drivers/pci/pci.h	Thu May 22 14:54:18 2003
@@ -3,3 +3,4 @@
 extern int pci_hotplug (struct device *dev, char **envp, int num_envp,
 			 char *buffer, int buffer_size);
 extern void pci_create_sysfs_dev_files(struct pci_dev *pdev);
+extern int pci_register_dynids(struct pci_driver *drv);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Thu May 22 14:54:18 2003
+++ b/include/linux/device.h	Thu May 22 14:54:18 2003
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
+++ b/include/linux/pci-dynids.h	Thu May 22 14:54:18 2003
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
--- a/include/linux/pci.h	Thu May 22 14:54:18 2003
+++ b/include/linux/pci.h	Thu May 22 14:54:18 2003
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

