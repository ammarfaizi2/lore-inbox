Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266102AbTLaB7x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 20:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266112AbTLaB7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 20:59:53 -0500
Received: from smtp2.us.dell.com ([143.166.85.133]:18570 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP id S266102AbTLaB7R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 20:59:17 -0500
Date: Tue, 30 Dec 2003 19:58:54 -0600 (CST)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@localhost.localdomain
To: linux-kernel@vger.kernel.org
Subject: 2.4.x dynamic PCI IDs for hacking
Message-ID: <Pine.LNX.4.44.0312301947180.8573-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At OLS this past summer, Jeff Garzik asked if I could put together the
PCI dynamic IDs functionality which had at that time recently been
included in 2.5.x.  I took a stab at it, then promptly forgot about
it.  Below is a good first pass, but it's certainly not ready for
inclusion, and with 2.4.x closed to such things now, never will.  But,
we thought someone *might* be interested in it, so here goes.

This creates a new file /proc/bus/pci/new_id, roughly analogous to
/sys/bus/pci/drivers/{drivername}/new_id.  You write into this file
values like:

"e1000 8086 9999 ABCD ABCD 0 0 0"

where the arguments are:
drivername - text string as the driver calls itself
vendor ID - defaults to PCI_ANY_ID if not passed
device ID - defaults to PCI_ANY_ID if not passed
subsystem vendor ID - defaults to PCI_ANY_ID if not passed
subsystem device ID - defaults to PCI_ANY_ID if not passed
class - defaults to 0 if not passed
classmask - defaults to 0 if not passed
driver_data - defaults to 0 if not passed

all in hex.  This is the same as in 2.6, only with the addition of the
driver name, needed to look up the right driver.  (In 2.6 the lookup
has already happened by virtue of writing into
/sys/bus/pci/drivers/{drivername}/.)

When done, the ID provided is added to the list of IDs searched if using 
a static pci_device_id list in the driver.

Not guaranteed to work right, or not to eat your data, but it's a good
start if someone were interested in the work.  Patch below is against
2.4.22-pre7. 

Thanks,
Matt

--
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com



===== drivers/pci/pci.c 1.43 vs edited =====
--- 1.43/drivers/pci/pci.c	Wed Dec 18 07:29:54 2002
+++ edited/drivers/pci/pci.c	Fri Jul 25 21:17:45 2003
@@ -24,6 +24,7 @@
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/cache.h>
+#include <linux/pci-dynids.h>
 
 #include <asm/page.h>
 #include <asm/dma.h>	/* isa_dma_bridge_buggy */
@@ -602,55 +603,155 @@
 static LIST_HEAD(pci_drivers);
 
 /**
- * pci_match_device - Tell if a PCI device structure has a matching PCI device id structure
+ * pci_match_one_device - Tell if a PCI device structure has a matching
+ *                        PCI device id structure
+ * @id: single PCI device id structure to match
+ * @dev: the PCI device structure to match against
+ *
+ * Returns the matching pci_device_id structure or %NULL if there is no match.
+ */
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
- * 
+ *
  * Used by a driver to check whether a PCI device present in the
- * system is in its list of supported devices.Returns the matching
+ * system is in its list of supported devices. Returns the matching
  * pci_device_id structure or %NULL if there is no match.
  */
 const struct pci_device_id *
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
-
+/**
+ * pci_device_probe_static()
+ * @drv - driver to match
+ * @pci_dev - pci_device to match
+ *
+ * ->probe returns 0 on success, or error.
+ * returns 1 on successful match, 0 if no match.
+ */
 static int
-pci_announce_device(struct pci_driver *drv, struct pci_dev *dev)
+pci_device_probe_static(struct pci_driver *drv, struct pci_dev *pci_dev)
 {
+	int err = 0;
 	const struct pci_device_id *id;
-	int ret = 0;
 
 	if (drv->id_table) {
-		id = pci_match_device(drv->id_table, dev);
-		if (!id) {
-			ret = 0;
-			goto out;
-		}
+		id = pci_match_device(drv->id_table, pci_dev);
+		if (!id)
+			return 0;
 	} else
 		id = NULL;
 
 	dev_probe_lock();
-	if (drv->probe(dev, id) >= 0) {
-		dev->driver = drv;
-		ret = 1;
-	}
+	err = drv->probe(pci_dev, id);
 	dev_probe_unlock();
-out:
+
+	if (err >= 0) {
+		pci_dev->driver = drv;
+		return 1;
+	}
+	return 0;
+}
+
+/**
+ * pci_device_probe_dynamic()
+ *
+ * Walk the dynamic ID list looking for a match.
+ * returns 1 on successful match, 0 if no match.
+ * ->probe returns 0 on success, or error.
+ */
+static int
+pci_device_probe_dynamic(struct pci_driver *drv, struct pci_dev *pci_dev)
+{
+	int error, ret=0;
+	struct list_head *pos;
+	struct dynid *dynid;
+
+	spin_lock(&drv->dynids.lock);
+	list_for_each(pos, &drv->dynids.list) {
+		dynid = list_entry(pos, struct dynid, node);
+		if (pci_match_one_device(&dynid->id, pci_dev)) {
+			spin_unlock(&drv->dynids.lock);
+			dev_probe_lock();
+			error = drv->probe(pci_dev, &dynid->id);
+			dev_probe_unlock();
+			if (error >= 0) {
+				pci_dev->driver = drv;
+				ret = 1;
+			}
+			break;
+		}
+	}
+	spin_unlock(&drv->dynids.lock);
 	return ret;
 }
 
 /**
+ * pci_announce_device
+ *
+ * returns 1 on successful match, 0 if no match, or error.
+ * side-effect: pci_dev->driver is set to drv when drv claims pci_dev.
+ */
+static int
+pci_announce_device(struct pci_driver *drv, struct pci_dev *dev)
+{
+	int count = 0;
+
+	if (!dev->driver && drv->probe) {
+		count += pci_device_probe_static(drv, dev);
+		if (count >= 0)
+			return count;
+
+		count += pci_device_probe_dynamic(drv, dev);
+	}
+	return count;
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
+static void
+pci_free_dynids(struct pci_driver *drv)
+{
+	struct list_head *pos, *n;
+	struct dynid *dynid;
+
+	spin_lock(&drv->dynids.lock);
+	list_for_each_safe(pos, n, &drv->dynids.list) {
+		dynid = list_entry(pos, struct dynid, node);
+		list_del(&dynid->node);
+		kfree(dynid);
+	}
+	spin_unlock(&drv->dynids.lock);
+}
+
+/**
  * pci_register_driver - register a new pci driver
  * @drv: the driver structure to register
  * 
@@ -665,6 +766,7 @@
 	struct pci_dev *dev;
 	int count = 0;
 
+	pci_init_dynids(&drv->dynids);
 	list_add_tail(&drv->node, &pci_drivers);
 	pci_for_each_dev(dev) {
 		if (!pci_dev_driver(dev))
@@ -694,10 +796,54 @@
 			if (drv->remove)
 				drv->remove(dev);
 			dev->driver = NULL;
+			pci_free_dynids(drv);
 		}
 	}
 }
 
+/**
+ * pci_add_id_to_driver - Adds a dynid to the driver.
+ * @drv: the driver structure to register
+ */
+int
+pci_add_id_to_driver(struct pci_driver *drv, struct dynid *dynid)
+{
+	struct pci_dev *dev;
+	int count=0;
+
+	spin_lock(&drv->dynids.lock);
+	list_add_tail(&dynid->node, &drv->dynids.list);
+	spin_unlock(&drv->dynids.lock);
+
+	pci_for_each_dev(dev) {
+		if (!pci_dev_driver(dev))
+			count += pci_announce_device(drv, dev);
+	}
+	return count;
+}
+
+/**
+ * pci_find_driver_by_name
+ * @name: the driver structure to register
+ *
+ * Returns pci_driver that matches name.
+ * FIXME - pci_drivers list isn't protected by a lock,
+ * additions/lookups/removals could race.
+ */
+struct pci_driver *
+pci_find_driver_by_name(const char *name)
+{
+	struct list_head *pos;
+	struct pci_driver *drv;
+
+	list_for_each(pos, &pci_drivers) {
+		drv = list_entry(pos, struct pci_driver, node);
+		if (!strcmp(drv->name, name))
+			return drv;
+	}
+	return NULL;
+}
+
 #ifdef CONFIG_HOTPLUG
 
 #ifndef FALSE
@@ -2157,6 +2303,8 @@
 EXPORT_SYMBOL(pci_dev_driver);
 EXPORT_SYMBOL(pci_match_device);
 EXPORT_SYMBOL(pci_find_parent_resource);
+EXPORT_SYMBOL(pci_add_id_to_driver);
+EXPORT_SYMBOL(pci_find_driver_by_name);
 
 #ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pci_setup_device);
===== drivers/pci/proc.c 1.7 vs edited =====
--- 1.7/drivers/pci/proc.c	Thu Sep 19 19:37:18 2002
+++ edited/drivers/pci/proc.c	Fri Jul 25 21:26:52 2003
@@ -12,6 +12,7 @@
 #include <linux/proc_fs.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
+#include <linux/pci-dynids.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -550,6 +551,63 @@
 	release:	seq_release,
 };
 
+static inline void
+dynid_init(struct dynid *dynid)
+{
+	memset(dynid, 0, sizeof(*dynid));
+	INIT_LIST_HEAD(&dynid->node);
+}
+
+/**
+ * proc_bus_pci_new_id_write()
+ *
+ * Write a string to the new_id file in the format
+ * "drivername vendor device subvendor subdevice class class_mask driver_data"
+ * Finds the named driver and adds a dynid to it.
+ */
+static int
+proc_bus_pci_new_id_write(struct file *file, const char *buffer,
+			  unsigned long count, void *data)
+{
+	struct dynid *dynid;
+	struct pci_driver *drv;
+	char driver_name[16];
+	__u32 vendor=PCI_ANY_ID, device=PCI_ANY_ID, subvendor=PCI_ANY_ID,
+		subdevice=PCI_ANY_ID, class=0, class_mask=0;
+	unsigned long driver_data=0;
+	int fields=0;
+
+	memset(driver_name, 0, sizeof(driver_name));
o+	fields = sscanf(buffer, "%15s %x %x %x %x %x %x %lux",
+			driver_name,
+			&vendor, &device, &subvendor, &subdevice,
+			&class, &class_mask, &driver_data);
+	if (fields < 0)
+		return -EINVAL;
+
+	drv = pci_find_driver_by_name(driver_name);
+	if (!drv)
+		return -ENODEV;
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
+	dynid->id.driver_data = drv->dynids.use_driver_data ?
+		driver_data : 0UL;
+
+	pci_add_id_to_driver(drv, dynid);
+
+	return count;
+}
+
 static int __init pci_proc_init(void)
 {
 	if (pci_present()) {
@@ -559,6 +617,10 @@
 		entry = create_proc_entry("devices", 0, proc_bus_pci_dir);
 		if (entry)
 			entry->proc_fops = &proc_bus_pci_dev_operations;
+		entry = create_proc_entry("new_id", 0200, proc_bus_pci_dir);
+		if (entry) {
+			entry->write_proc = proc_bus_pci_new_id_write;
+		}
 		pci_for_each_dev(dev) {
 			pci_proc_attach_device(dev);
 		}
===== include/linux/pci.h 1.31 vs edited =====
--- 1.31/include/linux/pci.h	Thu Jun 26 06:39:58 2003
+++ edited/include/linux/pci.h	Fri Jul 25 21:33:20 2003
@@ -333,6 +333,8 @@
 #include <linux/ioport.h>
 #include <linux/list.h>
 #include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/pci-dynids.h>
 
 /* File state for mmap()s on /proc/bus/pci/X/Y */
 enum pci_mmap_state {
@@ -351,8 +353,6 @@
 #define DEVICE_COUNT_DMA	2
 #define DEVICE_COUNT_RESOURCE	12
 
-#define PCI_ANY_ID (~0)
-
 #define pci_present pcibios_present
 
 
@@ -501,11 +501,12 @@
 	unsigned long prefetch_start, prefetch_end;
 };
 
-struct pci_device_id {
-	unsigned int vendor, device;		/* Vendor and device ID or PCI_ANY_ID */
-	unsigned int subvendor, subdevice;	/* Subsystem ID's or PCI_ANY_ID */
-	unsigned int class, class_mask;		/* (class,subclass,prog-if) triplet */
-	unsigned long driver_data;		/* Data private to the driver */
+#include <linux/mod_devicetable.h>
+
+struct pci_dynids {
+	spinlock_t lock;            /* protects list, index */
+	struct list_head list;      /* for IDs added at runtime */
+	unsigned int use_driver_data:1; /* pci_device_id->driver_data is used */
 };
 
 struct pci_driver {
@@ -518,6 +519,7 @@
 	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
+	struct pci_dynids dynids;
 };
 
 
@@ -638,6 +640,8 @@
 void pci_announce_device_to_drivers(struct pci_dev *);
 unsigned int pci_do_scan_bus(struct pci_bus *bus);
 struct pci_bus * pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr);
+int pci_add_id_to_driver(struct pci_driver *drv, struct dynid *dynid);
+struct pci_driver * pci_find_driver_by_name(const char *name);
 
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 struct pci_pool *pci_pool_create (const char *name, struct pci_dev *dev,
--- /dev/null	2003-01-30 05:24:37.000000000 -0500
+++ include/linux/mod_devicetable.h	2003-07-25 21:33:11.000000000 -0400
@@ -0,0 +1,25 @@
+/*
+ * Device tables which are exported to userspace via
+ * scripts/table2alias.c.  You must keep that file in sync with this
+ * header.
+ */
+
+#ifndef LINUX_MOD_DEVICETABLE_H
+#define LINUX_MOD_DEVICETABLE_H
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+typedef unsigned long kernel_ulong_t;
+#endif
+
+#define PCI_ANY_ID (~0)
+
+struct pci_device_id {
+	__u32 vendor, device;		/* Vendor and device ID or PCI_ANY_ID*/
+	__u32 subvendor, subdevice;	/* Subsystem ID's or PCI_ANY_ID */
+	__u32 class, class_mask;	/* (class,subclass,prog-if) triplet */
+	kernel_ulong_t driver_data;	/* Data private to the driver */
+};
+
+
+#endif /* LINUX_MOD_DEVICETABLE_H */
--- /dev/null	2003-01-30 05:24:37.000000000 -0500
+++ include/linux/pci-dynids.h	2003-07-25 21:32:59.000000000 -0400
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

