Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTEFQ2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 12:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263973AbTEFQ12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 12:27:28 -0400
Received: from smtp3.us.dell.com ([143.166.148.134]:7698 "EHLO
	smtp3.us.dell.com") by vger.kernel.org with ESMTP id S263953AbTEFQWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 12:22:50 -0400
Date: Tue, 6 May 2003 11:35:17 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: Greg KH <greg@kroah.com>, <mochel@osdl.org>
cc: alan@redhat.com, <linux-kernel@vger.kernel.org>, <jgarzik@redhat.com>
Subject: Re: [RFC][PATCH] Dynamic PCI Device IDs
In-Reply-To: <20030506035635.GA5403@kroah.com>
Message-ID: <Pine.LNX.4.44.0305061123490.7233-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can't just call driver_attach(), as the bus semaphore needs to be
> locked before doing so.  In short, you almost need to duplicate
> bus_add_driver(), but not quite :)

Right, and it seems to work. I made driver_attach non-static, declared
it extern in pci.h, and call it in pci-driver.c while holding the bus
semaphore and references to the driver and the bus.  This also let me
delete my probe_each_pci_dev() function and let the driver core
handle it.

Pat, can you ack the changes to bus.c and device.h please?

Now when an ID is added and a new device is found, the symlink for the
device shows up under sys/bus/pci/drivers/{driver}/.

Before:

/sys/bus/pci/drivers/e100
`-- new_id

After:

/sys/bus/pci/drivers/e100
|-- 00:04.0 -> ../../../../devices/pci0/00:04.0
`-- new_id


Patch below, and at:
http://domsch.com/linux/patches/dynids/linux-2.5/linux-2.5.69-dynids-20030506.patch.bz2
http://domsch.com/linux/patches/dynids/linux-2.5/linux-2.5.69-dynids-20030506.patch.bz2.asc

 Documentation/pci.txt      |   24 +++
 drivers/base/bus.c         |    2
 drivers/pci/pci-driver.c   |  281 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/device.h     |    1
 include/linux/pci-dynids.h |   18 ++
 include/linux/pci.h        |   16 ++
 6 files changed, 312 insertions(+), 30 deletions(-)

BK:
http://mdomsch.bkbits.net/linux-2.5-dynids

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/Documentation/pci.txt dynids/linux-2.5-dynids/Documentation/pci.txt
--- linux-2.5/Documentation/pci.txt	Mon May  5 17:19:05 2003
+++ dynids/linux-2.5-dynids/Documentation/pci.txt	Tue May  6 11:16:08 2003
@@ -45,8 +45,6 @@
 	id_table	Pointer to table of device ID's the driver is
 			interested in.  Most drivers should export this
 			table using MODULE_DEVICE_TABLE(pci,...).
-			Set to NULL to call probe() function for every
-			PCI device known to the system.
 	probe		Pointer to a probing function which gets called (during
 			execution of pci_register_driver for already existing
 			devices or later if a new device gets inserted) for all
@@ -82,6 +80,28 @@
 	class,		Device class to match. The class_mask tells which bits
 	class_mask	of the class are honored during the comparison.
 	driver_data	Data private to the driver.
+
+Most drivers don't need to use the driver_data field.  Best practice
+for use of driver_data is to use it as an index into a static list of
+equivalant device types, not to use it as a pointer.
+
+Have a table entry {PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID}
+to have probe() called for every PCI device known to the system.
+
+New PCI IDs may be added to a device driver at runtime by writing
+to the file /sys/bus/pci/drivers/{driver}/new_id.  When added, the
+driver will probe for all devices it can support.
+
+echo "vendor device subvendor subdevice class class_mask driver_data" > \
+ /sys/bus/pci/drivers/{driver}/new_id
+where all fields are passed in as hexadecimal values (no leading 0x).
+Users need pass only as many fields as necessary; vendor, device,
+subvendor, and subdevice fields default to PCI_ANY_ID (FFFFFFFF),
+class and classmask fields default to 0, and driver_data defaults to
+0UL.  Device drivers must call
+   pci_dynids_set_use_driver_data(pci_driver *, 1)
+in order for the driver_data field to get passed to the driver.
+Otherwise, only a 0 is passed in that field.
 
 When the driver exits, it just calls pci_unregister_driver() and the PCI layer
 automatically calls the remove hook for all devices handled by the driver.
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/drivers/base/bus.c dynids/linux-2.5-dynids/drivers/base/bus.c
--- linux-2.5/drivers/base/bus.c	Mon May  5 17:19:17 2003
+++ dynids/linux-2.5-dynids/drivers/base/bus.c	Tue May  6 11:16:18 2003
@@ -316,7 +316,7 @@
  *	Note that we ignore the error from bus_match(), since it's perfectly
  *	valid for a driver not to bind to any devices.
  */
-static void driver_attach(struct device_driver * drv)
+void driver_attach(struct device_driver * drv)
 {
 	struct bus_type * bus = drv->bus;
 	struct list_head * entry;
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/drivers/pci/pci-driver.c dynids/linux-2.5-dynids/drivers/pci/pci-driver.c
--- linux-2.5/drivers/pci/pci-driver.c	Mon May  5 17:19:31 2003
+++ dynids/linux-2.5-dynids/drivers/pci/pci-driver.c	Tue May  6 11:16:29 2003
@@ -6,6 +6,8 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/device.h>
+#include <linux/pci-dynids.h>
 #include "pci.h"
 
 /*
@@ -13,7 +15,29 @@
  */
 
 /**
- * pci_match_device - Tell if a PCI device structure has a matching PCI device id structure
+ * pci_match_one_device - Tell if a PCI device structure has a matching
+ *                        PCI device id structure
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
+ * pci_match_device - Tell if a PCI device structure has a matching
+ *                    PCI device id structure
  * @ids: array of PCI device id structures to search in
  * @dev: the PCI device structure to match against
  * 
@@ -25,17 +49,87 @@
 pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev)
 {
 	while (ids->vendor || ids->subvendor || ids->class_mask) {
-		if ((ids->vendor == PCI_ANY_ID || ids->vendor == dev->vendor) &&
-		    (ids->device == PCI_ANY_ID || ids->device == dev->device) &&
-		    (ids->subvendor == PCI_ANY_ID || ids->subvendor == dev->subsystem_vendor) &&
-		    (ids->subdevice == PCI_ANY_ID || ids->subdevice == dev->subsystem_device) &&
-		    !((ids->class ^ dev->class) & ids->class_mask))
+		if (pci_match_one_device(ids, dev))
 			return ids;
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
+pci_device_probe_static(struct pci_driver *drv, struct pci_dev *pci_dev)
+{		   
+	int error = -ENODEV;
+	const struct pci_device_id *id;
+
+	if (!drv->id_table)
+		return error;
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
+pci_device_probe_dynamic(struct pci_driver *drv, struct pci_dev *pci_dev)
+{		   
+	int error = -ENODEV;
+	struct list_head *pos;
+	struct dynid *dynid;
+
+	spin_lock(&drv->dynids.lock);
+	list_for_each(pos, &drv->dynids.list) {
+		dynid = list_entry(pos, struct dynid, node);
+		if (pci_match_one_device(&dynid->id, pci_dev)) {
+			spin_unlock(&drv->dynids.lock);
+			error = drv->probe(pci_dev, &dynid->id);
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
+__pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
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
@@ -44,17 +138,9 @@
 
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
@@ -101,6 +187,134 @@
 	return 0;
 }
 
+static inline void
+dynid_init(struct dynid *dynid)
+{
+	memset(dynid, 0, sizeof(*dynid));
+	INIT_LIST_HEAD(&dynid->node);
+}
+
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
+{
+	struct dynid *dynid;
+	struct bus_type * bus;
+	struct pci_driver *pdrv = to_pci_driver(driver);
+	__u32 vendor=PCI_ANY_ID, device=PCI_ANY_ID, subvendor=PCI_ANY_ID,
+		subdevice=PCI_ANY_ID, class=0, class_mask=0;
+	unsigned long driver_data=0;
+	int fields=0;
+
+	fields = sscanf(buf, "%x %x %x %x %x %x %lux",
+			&vendor, &device, &subvendor, &subdevice,
+			&class, &class_mask, &driver_data);
+	if (fields < 0)
+		return -EINVAL;
+
+	dynid = kmalloc(sizeof(*dynid), GFP_KERNEL);
+	if (!dynid)
+		return -ENOMEM;
+	dynid_init(dynid);
+
+	dynid->id.vendor = vendor;
+	dynid->id.device = device;
+	dynid->id.subvendor = subvendor;
+	dynid->id.subdevice = subdevice;
+	dynid->id.class = class;
+	dynid->id.class_mask = class_mask;
+	dynid->id.driver_data = pdrv->dynids.use_driver_data ?
+		driver_data : 0UL;
+
+	spin_lock(&pdrv->dynids.lock);
+	list_add(&pdrv->dynids.list, &dynid->node);
+	spin_unlock(&pdrv->dynids.lock);
+
+	bus = get_bus(pdrv->driver.bus);
+	if (bus) {
+		if (get_driver(&pdrv->driver)) {
+			down_write(&bus->subsys.rwsem);
+			driver_attach(&pdrv->driver);
+			up_write(&bus->subsys.rwsem);
+			put_driver(&pdrv->driver);
+		}
+		put_bus(bus);
+	}
+	
+	return count;
+}
+
+static DRIVER_ATTR(new_id, S_IWUSR, NULL, store_new_id);
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
+	.sysfs_ops = &pci_driver_sysfs_ops,
+};
+
+static int
+pci_populate_driver_dir(struct pci_driver * drv)
+{
+	int error = 0;
+
+	if (drv->probe != NULL)
+		error = sysfs_create_file(&drv->driver.kobj,
+					  &driver_attr_new_id.attr);
+	return error;
+}
+
+static inline void
+pci_init_dynids(struct pci_dynids *dynids)
+{
+	memset(dynids, 0, sizeof(*dynids));
+	spin_lock_init(&dynids->lock);
+	INIT_LIST_HEAD(&dynids->list);
+}
+
 /**
  * pci_register_driver - register a new pci driver
  * @drv: the driver structure to register
@@ -122,9 +336,16 @@
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
+	}
+
 	return count ? count : 1;
 }
 
@@ -180,22 +401,30 @@
  */
 static int pci_bus_match(struct device * dev, struct device_driver * drv) 
 {
-	struct pci_dev * pci_dev = to_pci_dev(dev);
+	const struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * pci_drv = to_pci_driver(drv);
 	const struct pci_device_id * ids = pci_drv->id_table;
+	const struct pci_device_id *found_id;
+	struct list_head *pos;
+	struct dynid *dynid;
 
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
+		dynid = list_entry(pos, struct dynid, node);
+		if (pci_match_one_device(&dynid->id, pci_dev)) {
+			spin_unlock(&pci_drv->dynids.lock);
 			return 1;
-		ids++;
+		}
 	}
+	spin_unlock(&pci_drv->dynids.lock);
+
 	return 0;
 }
 
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/include/linux/device.h dynids/linux-2.5-dynids/include/linux/device.h
--- linux-2.5/include/linux/device.h	Mon May  5 17:19:50 2003
+++ dynids/linux-2.5-dynids/include/linux/device.h	Tue May  6 11:16:45 2003
@@ -318,6 +318,7 @@
  */
 extern void device_bind_driver(struct device * dev);
 extern void device_release_driver(struct device * dev);
+extern void driver_attach(struct device_driver * drv);
 
 
 /* driverfs interface for exporting device attributes */
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/include/linux/pci-dynids.h dynids/linux-2.5-dynids/include/linux/pci-dynids.h
--- linux-2.5/include/linux/pci-dynids.h	Wed Dec 31 18:00:00 1969
+++ dynids/linux-2.5-dynids/include/linux/pci-dynids.h	Tue May  6 11:16:45 2003
@@ -0,0 +1,18 @@
+/*
+ *	PCI defines and function prototypes
+ *	Copyright 2003 Dell Computer Corporation
+ *        by Matt Domsch <Matt_Domsch@dell.com>
+ */
+
+#ifndef LINUX_PCI_DYNIDS_H
+#define LINUX_PCI_DYNIDS_H
+
+#include <linux/list.h>
+#include <linux/mod_devicetable.h>
+
+struct dynid {
+	struct list_head        node;
+	struct pci_device_id    id;
+};
+
+#endif
diff -Nur --exclude=RCS --exclude=CVS --exclude=SCCS --exclude=BitKeeper --exclude=ChangeSet linux-2.5/include/linux/pci.h dynids/linux-2.5-dynids/include/linux/pci.h
--- linux-2.5/include/linux/pci.h	Mon May  5 17:19:51 2003
+++ dynids/linux-2.5-dynids/include/linux/pci.h	Tue May  6 11:16:45 2003
@@ -490,10 +490,16 @@
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
-	const struct pci_device_id *id_table;	/* NULL if wants all devices */
+	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
 	int  (*save_state) (struct pci_dev *dev, u32 state);    /* Save Device Context */
@@ -502,6 +508,7 @@
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 
 	struct device_driver	driver;
+	struct pci_dynids dynids;
 };
 
 #define	to_pci_driver(drv) container_of(drv,struct pci_driver, driver)
@@ -702,6 +709,12 @@
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
@@ -750,6 +763,7 @@
 static inline int scsi_to_pci_dma_dir(unsigned char scsi_dir) { return scsi_dir; }
 static inline int pci_find_capability (struct pci_dev *dev, int cap) {return 0; }
 static inline const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev) { return NULL; }
+static inline void pci_dynids_set_use_driver_data(struct pci_driver *pdrv, int val) { }
 
 /* Power management related routines */
 static inline int pci_save_state(struct pci_dev *dev, u32 *buffer) { return 0; }

