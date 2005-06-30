Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262919AbVF3JUK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbVF3JUK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 05:20:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVF3JUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 05:20:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:50650 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262911AbVF3JSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 05:18:24 -0400
Date: Thu, 30 Jun 2005 02:18:12 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, Matt_Domsch@dell.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz
Subject: [RFC] PCI: clean up the dynamic pci id logic
Message-ID: <20050630091812.GA25285@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The dynamic pci id logic has been bothering me for a while, and now that
I started to look into how to move some of this to the driver core, I
thought it was time to clean it all up.

So here's a patch against 2.6.13-rc1 that does so.  It ends up making
the code smaller, and easier to follow, and fixes a few bugs at the same
time (dynamic ids were not being matched everywhere, and so could be
missed on some call paths for new devices, semaphore not needed to be
grabbed when adding a new id and calling the driver core, etc.)

Matt, any objection to this patch?

I also renamed the function pci_match_device() to pci_match_id() as
that's what it really does, but maybe I should just put it back to be
compatible.  Nah...

thanks,

greg k-h


Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/i386/kernel/cpu/cpufreq/gx-suspmod.c |    2 
 drivers/char/hw_random.c                  |    2 
 drivers/char/watchdog/i8xx_tco.c          |    2 
 drivers/ide/setup-pci.c                   |    2 
 drivers/parport/parport_pc.c              |    2 
 drivers/pci/pci-driver.c                  |  196 ++++++++++--------------------
 include/linux/pci-dynids.h                |   18 --
 include/linux/pci.h                       |    3 
 sound/pci/bt87x.c                         |    2 
 9 files changed, 79 insertions(+), 150 deletions(-)

--- gregkh-2.6.orig/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c	2005-06-17 12:48:29.000000000 -0700
+++ gregkh-2.6/arch/i386/kernel/cpu/cpufreq/gx-suspmod.c	2005-06-30 01:32:34.000000000 -0700
@@ -190,7 +190,7 @@
 
 	/* detect which companion chip is used */
 	while ((gx_pci = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, gx_pci)) != NULL) {
-		if ((pci_match_device (gx_chipset_tbl, gx_pci)) != NULL) {
+		if ((pci_match_id(gx_chipset_tbl, gx_pci)) != NULL) {
 			return gx_pci;
 		}
 	}
--- gregkh-2.6.orig/drivers/char/hw_random.c	2005-06-17 12:48:29.000000000 -0700
+++ gregkh-2.6/drivers/char/hw_random.c	2005-06-30 01:27:23.000000000 -0700
@@ -579,7 +579,7 @@
 
 	/* Probe for Intel, AMD RNGs */
 	for_each_pci_dev(pdev) {
-		ent = pci_match_device (rng_pci_tbl, pdev);
+		ent = pci_match_id(rng_pci_tbl, pdev);
 		if (ent) {
 			rng_ops = &rng_vendor_ops[ent->driver_data];
 			goto match;
--- gregkh-2.6.orig/drivers/char/watchdog/i8xx_tco.c	2005-06-17 12:48:29.000000000 -0700
+++ gregkh-2.6/drivers/char/watchdog/i8xx_tco.c	2005-06-30 01:32:57.000000000 -0700
@@ -401,7 +401,7 @@
 	 */
 
 	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		if (pci_match_device(i8xx_tco_pci_tbl, dev)) {
+		if (pci_match_id(i8xx_tco_pci_tbl, dev)) {
 			i8xx_tco_pci = dev;
 			break;
 		}
--- gregkh-2.6.orig/drivers/ide/setup-pci.c	2005-06-17 12:48:29.000000000 -0700
+++ gregkh-2.6/drivers/ide/setup-pci.c	2005-06-30 01:26:47.000000000 -0700
@@ -847,7 +847,7 @@
 		d = list_entry(l, struct pci_driver, node);
 		if(d->id_table)
 		{
-			const struct pci_device_id *id = pci_match_device(d->id_table, dev);
+			const struct pci_device_id *id = pci_match_id(d->id_table, dev);
 			if(id != NULL)
 			{
 				if(d->probe(dev, id) >= 0)
--- gregkh-2.6.orig/drivers/parport/parport_pc.c	2005-06-29 07:55:19.000000000 -0700
+++ gregkh-2.6/drivers/parport/parport_pc.c	2005-06-30 01:33:43.000000000 -0700
@@ -3008,7 +3008,7 @@
 	int ret = 0;
 
 	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
-		id = pci_match_device (parport_pc_pci_tbl, pdev);
+		id = pci_match_id(parport_pc_pci_tbl, pdev);
 		if (id == NULL || id->driver_data >= last_sio)
 			continue;
 
--- gregkh-2.6.orig/drivers/pci/pci-driver.c	2005-06-29 07:55:19.000000000 -0700
+++ gregkh-2.6/drivers/pci/pci-driver.c	2005-06-30 02:04:37.000000000 -0700
@@ -7,7 +7,6 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
-#include <linux/pci-dynids.h>
 #include "pci.h"
 
 /*
@@ -19,35 +18,11 @@
  */
 
 #ifdef CONFIG_HOTPLUG
-/**
- * pci_device_probe_dynamic()
- *
- * Walk the dynamic ID list looking for a match.
- * returns 0 and sets pci_dev->driver when drv claims pci_dev, else error.
- */
-static int
-pci_device_probe_dynamic(struct pci_driver *drv, struct pci_dev *pci_dev)
-{
-	int error = -ENODEV;
-	struct list_head *pos;
-	struct dynid *dynid;
 
-	spin_lock(&drv->dynids.lock);
-	list_for_each(pos, &drv->dynids.list) {
-		dynid = list_entry(pos, struct dynid, node);
-		if (pci_match_one_device(&dynid->id, pci_dev)) {
-			spin_unlock(&drv->dynids.lock);
-			error = drv->probe(pci_dev, &dynid->id);
-			if (error >= 0) {
-				pci_dev->driver = drv;
-				return 0;
-			}
-			return error;
-		}
-	}
-	spin_unlock(&drv->dynids.lock);
-	return error;
-}
+struct pci_dynid {
+	struct list_head node;
+	struct pci_device_id id;
+};
 
 /**
  * store_new_id
@@ -58,8 +33,7 @@
 static inline ssize_t
 store_new_id(struct device_driver *driver, const char *buf, size_t count)
 {
-	struct dynid *dynid;
-	struct bus_type * bus;
+	struct pci_dynid *dynid;
 	struct pci_driver *pdrv = to_pci_driver(driver);
 	__u32 vendor=PCI_ANY_ID, device=PCI_ANY_ID, subvendor=PCI_ANY_ID,
 		subdevice=PCI_ANY_ID, class=0, class_mask=0;
@@ -91,37 +65,22 @@
 	list_add_tail(&pdrv->dynids.list, &dynid->node);
 	spin_unlock(&pdrv->dynids.lock);
 
-	bus = get_bus(pdrv->driver.bus);
-	if (bus) {
-		if (get_driver(&pdrv->driver)) {
-			down_write(&bus->subsys.rwsem);
-			driver_attach(&pdrv->driver);
-			up_write(&bus->subsys.rwsem);
-			put_driver(&pdrv->driver);
-		}
-		put_bus(bus);
+	if (get_driver(&pdrv->driver)) {
+		driver_attach(&pdrv->driver);
+		put_driver(&pdrv->driver);
 	}
 
 	return count;
 }
-
 static DRIVER_ATTR(new_id, S_IWUSR, NULL, store_new_id);
-static inline void
-pci_init_dynids(struct pci_dynids *dynids)
-{
-	spin_lock_init(&dynids->lock);
-	INIT_LIST_HEAD(&dynids->list);
-}
 
 static void
 pci_free_dynids(struct pci_driver *drv)
 {
-	struct list_head *pos, *n;
-	struct dynid *dynid;
+	struct pci_dynid *dynid, *n;
 
 	spin_lock(&drv->dynids.lock);
-	list_for_each_safe(pos, n, &drv->dynids.list) {
-		dynid = list_entry(pos, struct dynid, node);
+	list_for_each_entry_safe(dynid, n, &drv->dynids.list, node) {
 		list_del(&dynid->node);
 		kfree(dynid);
 	}
@@ -138,83 +97,70 @@
 	return error;
 }
 
-static int
-pci_bus_match_dynids(const struct pci_dev *pci_dev, struct pci_driver *pci_drv)
-{
-	struct list_head *pos;
-	struct dynid *dynid;
-
-	spin_lock(&pci_drv->dynids.lock);
-	list_for_each(pos, &pci_drv->dynids.list) {
-		dynid = list_entry(pos, struct dynid, node);
-		if (pci_match_one_device(&dynid->id, pci_dev)) {
-			spin_unlock(&pci_drv->dynids.lock);
-			return 1;
-		}
-	}
-	spin_unlock(&pci_drv->dynids.lock);
-	return 0;
-}
-
 #else /* !CONFIG_HOTPLUG */
-static inline int pci_device_probe_dynamic(struct pci_driver *drv, struct pci_dev *pci_dev)
-{
-	return -ENODEV;
-}
-static inline void pci_init_dynids(struct pci_dynids *dynids) {}
 static inline void pci_free_dynids(struct pci_driver *drv) {}
 static inline int pci_create_newid_file(struct pci_driver *drv)
 {
 	return 0;
 }
-static inline int pci_bus_match_dynids(const struct pci_dev *pci_dev, struct pci_driver *pci_drv)
-{
-	return 0;
-}
 #endif
 
 /**
- * pci_match_device - Tell if a PCI device structure has a matching
- *                    PCI device id structure
+ * pci_match_id - See if a pci device matches a given pci_id table
  * @ids: array of PCI device id structures to search in
- * @dev: the PCI device structure to match against
- * 
+ * @dev: the PCI device structure to match against.
+ *
  * Used by a driver to check whether a PCI device present in the
- * system is in its list of supported devices.Returns the matching
+ * system is in its list of supported devices.  Returns the matching
  * pci_device_id structure or %NULL if there is no match.
+ *
+ * Depreciated, don't use this as it will not catch any dynamic ids
+ * that a driver might want to check for.
  */
-const struct pci_device_id *
-pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev)
+const struct pci_device_id *pci_match_id(const struct pci_device_id *ids,
+					 struct pci_dev *dev)
 {
-	while (ids->vendor || ids->subvendor || ids->class_mask) {
-		if (pci_match_one_device(ids, dev))
-			return ids;
-		ids++;
+	if (ids) {
+		while (ids->vendor || ids->subvendor || ids->class_mask) {
+			if (pci_match_one_device(ids, dev))
+				return ids;
+			ids++;
+		}
 	}
 	return NULL;
 }
 
 /**
- * pci_device_probe_static()
- * 
- * returns 0 and sets pci_dev->driver when drv claims pci_dev, else error.
+ * pci_match_device - Tell if a PCI device structure has a matching
+ *                    PCI device id structure
+ * @ids: array of PCI device id structures to search in
+ * @dev: the PCI device structure to match against
+ * @drv: the PCI driver to match against
+ *
+ * Used by a driver to check whether a PCI device present in the
+ * system is in its list of supported devices.  Returns the matching
+ * pci_device_id structure or %NULL if there is no match.
  */
-static int
-pci_device_probe_static(struct pci_driver *drv, struct pci_dev *pci_dev)
-{		   
-	int error = -ENODEV;
+const struct pci_device_id *pci_match_device(struct pci_driver *drv,
+					     struct pci_dev *dev)
+{
 	const struct pci_device_id *id;
+	struct pci_dynid *dynid;
 
-	if (!drv->id_table)
-		return error;
-	id = pci_match_device(drv->id_table, pci_dev);
+	id = pci_match_id(drv->id_table, dev);
 	if (id)
-		error = drv->probe(pci_dev, id);
-	if (error >= 0) {
-		pci_dev->driver = drv;
-		error = 0;
+		return id;
+
+	/* static ids didn't match, lets look at the dynamic ones */
+	spin_lock(&drv->dynids.lock);
+	list_for_each_entry(dynid, &drv->dynids.list, node) {
+		if (pci_match_one_device(&dynid->id, dev)) {
+			spin_unlock(&drv->dynids.lock);
+			return &dynid->id;
+		}
 	}
-	return error;
+	spin_unlock(&drv->dynids.lock);
+	return NULL;
 }
 
 /**
@@ -225,13 +171,20 @@
  */
 static int
 __pci_device_probe(struct pci_driver *drv, struct pci_dev *pci_dev)
-{		   
+{
+	const struct pci_device_id *id;
 	int error = 0;
 
 	if (!pci_dev->driver && drv->probe) {
-		error = pci_device_probe_static(drv, pci_dev);
-		if (error == -ENODEV)
-			error = pci_device_probe_dynamic(drv, pci_dev);
+		error = -ENODEV;
+
+		id = pci_match_device(drv, pci_dev);
+		if (id)
+			error = drv->probe(pci_dev, id);
+		if (error >= 0) {
+			pci_dev->driver = drv;
+			error = 0;
+		}
 	}
 	return error;
 }
@@ -371,12 +324,6 @@
 	.sysfs_ops = &pci_driver_sysfs_ops,
 };
 
-static int
-pci_populate_driver_dir(struct pci_driver *drv)
-{
-	return pci_create_newid_file(drv);
-}
-
 /**
  * pci_register_driver - register a new pci driver
  * @drv: the driver structure to register
@@ -401,13 +348,15 @@
 		drv->driver.shutdown = pci_device_shutdown;
 	drv->driver.owner = drv->owner;
 	drv->driver.kobj.ktype = &pci_driver_kobj_type;
-	pci_init_dynids(&drv->dynids);
+
+	spin_lock_init(&drv->dynids.lock);
+	INIT_LIST_HEAD(&drv->dynids.list);
 
 	/* register with core */
 	error = driver_register(&drv->driver);
 
 	if (!error)
-		pci_populate_driver_dir(drv);
+		error = pci_create_newid_file(drv);
 
 	return error;
 }
@@ -463,21 +412,17 @@
  * system is in its list of supported devices.Returns the matching
  * pci_device_id structure or %NULL if there is no match.
  */
-static int pci_bus_match(struct device * dev, struct device_driver * drv) 
+static int pci_bus_match(struct device *dev, struct device_driver *drv)
 {
-	const struct pci_dev * pci_dev = to_pci_dev(dev);
-	struct pci_driver * pci_drv = to_pci_driver(drv);
-	const struct pci_device_id * ids = pci_drv->id_table;
+	struct pci_dev *pci_dev = to_pci_dev(dev);
+	struct pci_driver *pci_drv = to_pci_driver(drv);
 	const struct pci_device_id *found_id;
 
-	if (!ids)
-		return 0;
-
-	found_id = pci_match_device(ids, pci_dev);
+	found_id = pci_match_device(pci_drv, pci_dev);
 	if (found_id)
 		return 1;
 
-	return pci_bus_match_dynids(pci_dev, pci_drv);
+	return 0;
 }
 
 /**
@@ -536,6 +481,7 @@
 
 postcore_initcall(pci_driver_init);
 
+EXPORT_SYMBOL(pci_match_id);
 EXPORT_SYMBOL(pci_match_device);
 EXPORT_SYMBOL(pci_register_driver);
 EXPORT_SYMBOL(pci_unregister_driver);
--- gregkh-2.6.orig/include/linux/pci.h	2005-06-29 18:03:29.000000000 -0700
+++ gregkh-2.6/include/linux/pci.h	2005-06-30 01:45:50.000000000 -0700
@@ -860,7 +860,8 @@
 void pci_unregister_driver(struct pci_driver *);
 void pci_remove_behind_bridge(struct pci_dev *);
 struct pci_driver *pci_dev_driver(const struct pci_dev *);
-const struct pci_device_id *pci_match_device(const struct pci_device_id *ids, const struct pci_dev *dev);
+const struct pci_device_id *pci_match_device(struct pci_driver *drv, struct pci_dev *dev);
+const struct pci_device_id *pci_match_id(const struct pci_device_id *ids, struct pci_dev *dev);
 int pci_scan_bridge(struct pci_bus *bus, struct pci_dev * dev, int max, int pass);
 
 /* kmem_cache style wrapper around pci_alloc_consistent() */
--- gregkh-2.6.orig/sound/pci/bt87x.c	2005-06-30 01:31:36.000000000 -0700
+++ gregkh-2.6/sound/pci/bt87x.c	2005-06-30 01:32:06.000000000 -0700
@@ -804,7 +804,7 @@
 	int i;
 	const struct pci_device_id *supported;
 
-	supported = pci_match_device(snd_bt87x_ids, pci);
+	supported = pci_match_device(driver, pci);
 	if (supported)
 		return supported->driver_data;
 
--- gregkh-2.6.orig/include/linux/pci-dynids.h	2005-06-17 12:48:29.000000000 -0700
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,18 +0,0 @@
-/*
- *	PCI defines and function prototypes
- *	Copyright 2003 Dell Inc.
- *        by Matt Domsch <Matt_Domsch@dell.com>
- */
-
-#ifndef LINUX_PCI_DYNIDS_H
-#define LINUX_PCI_DYNIDS_H
-
-#include <linux/list.h>
-#include <linux/mod_devicetable.h>
-
-struct dynid {
-	struct list_head        node;
-	struct pci_device_id    id;
-};
-
-#endif
