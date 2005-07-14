Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262965AbVGNJJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbVGNJJd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbVGNJH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:07:27 -0400
Received: from peabody.ximian.com ([130.57.169.10]:6537 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262965AbVGNJFb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:05:31 -0400
Subject: [RFC][PATCH] device registration cleanups [3/9]
From: Adam Belay <abelay@novell.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Content-Type: text/plain
Date: Thu, 14 Jul 2005 04:55:15 -0400
Message-Id: <1121331316.3398.91.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves all device registration related functions to
bus/device.c.

Signed-off-by: Adam Belay <abelay@novell.com>

--- a/drivers/pci/bus/device.c	1969-12-31 19:00:00.000000000 -0500
+++ b/drivers/pci/bus/device.c	2005-07-12 01:32:41.000000000 -0400
@@ -0,0 +1,187 @@
+/*
+ * device.c - PCI device registration
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+
+#include "../pci.h" 
+
+/**
+ * add a single device
+ * @dev: device to add
+ *
+ * This adds a single pci device to the global
+ * device list and adds sysfs and procfs entries
+ */
+void __devinit pci_bus_add_device(struct pci_dev *dev)
+{
+	device_add(&dev->dev);
+
+	spin_lock(&pci_bus_lock);
+	list_add_tail(&dev->global_list, &pci_devices);
+	spin_unlock(&pci_bus_lock);
+
+	pci_proc_attach_device(dev);
+	pci_create_sysfs_dev_files(dev);
+}
+
+EXPORT_SYMBOL_GPL(pci_bus_add_device);
+
+/**
+ * pci_bus_add_devices - insert newly discovered PCI devices
+ * @bus: bus to check for new devices
+ *
+ * Add newly discovered PCI devices (which are on the bus->devices
+ * list) to the global PCI device list, add the sysfs and procfs
+ * entries.  Where a bridge is found, add the discovered bus to
+ * the parents list of child buses, and recurse (breadth-first
+ * to be compatible with 2.4)
+ *
+ * Call hotplug for each new devices.
+ */
+void __devinit pci_bus_add_devices(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		/*
+		 * Skip already-present devices (which are on the
+		 * global device list.)
+		 */
+		if (!list_empty(&dev->global_list))
+			continue;
+		pci_bus_add_device(dev);
+	}
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+
+		BUG_ON(list_empty(&dev->global_list));
+
+		/*
+		 * If there is an unattached subordinate bus, attach
+		 * it and then scan for unattached PCI devices.
+		 */
+		if (dev->subordinate) {
+			if (list_empty(&dev->subordinate->node)) {
+				spin_lock(&pci_bus_lock);
+				list_add_tail(&dev->subordinate->node,
+					      &dev->bus->children);
+				spin_unlock(&pci_bus_lock);
+			} 
+			pci_bus_add_devices(dev->subordinate);
+
+			sysfs_create_link(&dev->subordinate->class_dev.kobj, &dev->dev.kobj, "bridge");
+		}
+	}
+}
+
+EXPORT_SYMBOL(pci_bus_add_devices);
+
+static void pci_free_resources(struct pci_dev *dev)
+{
+	int i;
+
+ 	msi_remove_pci_irq_vectors(dev);
+
+	pci_cleanup_rom(dev);
+	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+		struct resource *res = dev->resource + i;
+		if (res->parent)
+			release_resource(res);
+	}
+}
+
+static void pci_destroy_dev(struct pci_dev *dev)
+{
+	if (!list_empty(&dev->global_list)) {
+		pci_proc_detach_device(dev);
+		pci_remove_sysfs_dev_files(dev);
+		device_unregister(&dev->dev);
+		spin_lock(&pci_bus_lock);
+		list_del(&dev->global_list);
+		dev->global_list.next = dev->global_list.prev = NULL;
+		spin_unlock(&pci_bus_lock);
+	}
+
+	/* Remove the device from the device lists, and prevent any further
+	 * list accesses from this device */
+	spin_lock(&pci_bus_lock);
+	list_del(&dev->bus_list);
+	dev->bus_list.next = dev->bus_list.prev = NULL;
+	spin_unlock(&pci_bus_lock);
+
+	pci_free_resources(dev);
+	pci_dev_put(dev);
+}
+
+/**
+ * pci_remove_device_safe - remove an unused hotplug device
+ * @dev: the device to remove
+ *
+ * Delete the device structure from the device lists and 
+ * notify userspace (/sbin/hotplug), but only if the device
+ * in question is not being used by a driver.
+ * Returns 0 on success.
+ */
+int pci_remove_device_safe(struct pci_dev *dev)
+{
+	if (pci_dev_driver(dev))
+		return -EBUSY;
+	pci_destroy_dev(dev);
+	return 0;
+}
+
+EXPORT_SYMBOL(pci_remove_device_safe);
+
+/**
+ * pci_remove_bus_device - remove a PCI device and any children
+ * @dev: the device to remove
+ *
+ * Remove a PCI device from the device lists, informing the drivers
+ * that the device has been removed.  We also remove any subordinate
+ * buses and children in a depth-first manner.
+ *
+ * For each device we remove, delete the device structure from the
+ * device lists, remove the /proc entry, and notify userspace
+ * (/sbin/hotplug).
+ */
+void pci_remove_bus_device(struct pci_dev *dev)
+{
+	if (dev->subordinate) {
+		struct pci_bus *b = dev->subordinate;
+
+		pci_remove_behind_bridge(dev);
+		pci_remove_bus(b);
+		dev->subordinate = NULL;
+	}
+
+	pci_destroy_dev(dev);
+}
+
+EXPORT_SYMBOL(pci_remove_bus_device);
+
+/**
+ * pci_remove_behind_bridge - remove all devices behind a PCI bridge
+ * @dev: PCI bridge device
+ *
+ * Remove all devices on the bus, except for the parent bridge.
+ * This also removes any child buses, and any devices they may
+ * contain in a depth-first manner.
+ */
+void pci_remove_behind_bridge(struct pci_dev *dev)
+{
+	struct list_head *l, *n;
+
+	if (dev->subordinate) {
+		list_for_each_safe(l, n, &dev->subordinate->devices) {
+			struct pci_dev *dev = pci_dev_b(l);
+
+			pci_remove_bus_device(dev);
+		}
+	}
+}
+
+EXPORT_SYMBOL(pci_remove_behind_bridge);
--- a/drivers/pci/bus/Makefile	2005-07-12 00:59:58.000000000 -0400
+++ b/drivers/pci/bus/Makefile	2005-07-12 01:09:47.000000000 -0400
@@ -2,4 +2,4 @@
 # Makefile for the PCI device detection
 #
 
-obj-y :=  bus.o config.o probe.o
+obj-y :=  bus.o config.o device.o probe.o
--- a/drivers/pci/bus.c	2005-07-08 17:06:19.000000000 -0400
+++ b/drivers/pci/bus.c	2005-07-12 01:28:22.000000000 -0400
@@ -68,73 +68,6 @@
 	return ret;
 }
 
-/**
- * add a single device
- * @dev: device to add
- *
- * This adds a single pci device to the global
- * device list and adds sysfs and procfs entries
- */
-void __devinit pci_bus_add_device(struct pci_dev *dev)
-{
-	device_add(&dev->dev);
-
-	spin_lock(&pci_bus_lock);
-	list_add_tail(&dev->global_list, &pci_devices);
-	spin_unlock(&pci_bus_lock);
-
-	pci_proc_attach_device(dev);
-	pci_create_sysfs_dev_files(dev);
-}
-
-/**
- * pci_bus_add_devices - insert newly discovered PCI devices
- * @bus: bus to check for new devices
- *
- * Add newly discovered PCI devices (which are on the bus->devices
- * list) to the global PCI device list, add the sysfs and procfs
- * entries.  Where a bridge is found, add the discovered bus to
- * the parents list of child buses, and recurse (breadth-first
- * to be compatible with 2.4)
- *
- * Call hotplug for each new devices.
- */
-void __devinit pci_bus_add_devices(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		/*
-		 * Skip already-present devices (which are on the
-		 * global device list.)
-		 */
-		if (!list_empty(&dev->global_list))
-			continue;
-		pci_bus_add_device(dev);
-	}
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-
-		BUG_ON(list_empty(&dev->global_list));
-
-		/*
-		 * If there is an unattached subordinate bus, attach
-		 * it and then scan for unattached PCI devices.
-		 */
-		if (dev->subordinate) {
-		       if (list_empty(&dev->subordinate->node)) {
-			       spin_lock(&pci_bus_lock);
-			       list_add_tail(&dev->subordinate->node,
-					       &dev->bus->children);
-			       spin_unlock(&pci_bus_lock);
-		       }
-			pci_bus_add_devices(dev->subordinate);
-
-			sysfs_create_link(&dev->subordinate->class_dev.kobj, &dev->dev.kobj, "bridge");
-		}
-	}
-}
-
 void pci_enable_bridges(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -149,6 +82,4 @@
 }
 
 EXPORT_SYMBOL(pci_bus_alloc_resource);
-EXPORT_SYMBOL_GPL(pci_bus_add_device);
-EXPORT_SYMBOL(pci_bus_add_devices);
 EXPORT_SYMBOL(pci_enable_bridges);
--- a/drivers/pci/Makefile	2005-07-12 00:59:58.000000000 -0400
+++ b/drivers/pci/Makefile	2005-07-12 01:09:47.000000000 -0400
@@ -2,8 +2,8 @@
 # Makefile for the PCI bus specific drivers.
 #
 
-obj-y		+= access.o bus.o remove.o pci.o quirks.o names.o \
-		   pci-driver.o search.o pci-sysfs.o rom.o bus/
+obj-y		+= access.o bus.o pci.o quirks.o names.o pci-driver.o \
+		   search.o pci-sysfs.o rom.o bus/
 
 obj-$(CONFIG_PROC_FS) += proc.o
 
--- a/drivers/pci/remove.c	2005-07-12 01:08:20.000000000 -0400
+++ b/drivers/pci/remove.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,108 +0,0 @@
-#include <linux/pci.h>
-#include <linux/module.h>
-#include "pci.h"
-
-static void pci_free_resources(struct pci_dev *dev)
-{
-	int i;
-
- 	msi_remove_pci_irq_vectors(dev);
-
-	pci_cleanup_rom(dev);
-	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
-		struct resource *res = dev->resource + i;
-		if (res->parent)
-			release_resource(res);
-	}
-}
-
-static void pci_destroy_dev(struct pci_dev *dev)
-{
-	if (!list_empty(&dev->global_list)) {
-		pci_proc_detach_device(dev);
-		pci_remove_sysfs_dev_files(dev);
-		device_unregister(&dev->dev);
-		spin_lock(&pci_bus_lock);
-		list_del(&dev->global_list);
-		dev->global_list.next = dev->global_list.prev = NULL;
-		spin_unlock(&pci_bus_lock);
-	}
-
-	/* Remove the device from the device lists, and prevent any further
-	 * list accesses from this device */
-	spin_lock(&pci_bus_lock);
-	list_del(&dev->bus_list);
-	dev->bus_list.next = dev->bus_list.prev = NULL;
-	spin_unlock(&pci_bus_lock);
-
-	pci_free_resources(dev);
-	pci_dev_put(dev);
-}
-
-/**
- * pci_remove_device_safe - remove an unused hotplug device
- * @dev: the device to remove
- *
- * Delete the device structure from the device lists and 
- * notify userspace (/sbin/hotplug), but only if the device
- * in question is not being used by a driver.
- * Returns 0 on success.
- */
-int pci_remove_device_safe(struct pci_dev *dev)
-{
-	if (pci_dev_driver(dev))
-		return -EBUSY;
-	pci_destroy_dev(dev);
-	return 0;
-}
-EXPORT_SYMBOL(pci_remove_device_safe);
-
-
-/**
- * pci_remove_bus_device - remove a PCI device and any children
- * @dev: the device to remove
- *
- * Remove a PCI device from the device lists, informing the drivers
- * that the device has been removed.  We also remove any subordinate
- * buses and children in a depth-first manner.
- *
- * For each device we remove, delete the device structure from the
- * device lists, remove the /proc entry, and notify userspace
- * (/sbin/hotplug).
- */
-void pci_remove_bus_device(struct pci_dev *dev)
-{
-	if (dev->subordinate) {
-		struct pci_bus *b = dev->subordinate;
-
-		pci_remove_behind_bridge(dev);
-		pci_remove_bus(b);
-		dev->subordinate = NULL;
-	}
-
-	pci_destroy_dev(dev);
-}
-
-/**
- * pci_remove_behind_bridge - remove all devices behind a PCI bridge
- * @dev: PCI bridge device
- *
- * Remove all devices on the bus, except for the parent bridge.
- * This also removes any child buses, and any devices they may
- * contain in a depth-first manner.
- */
-void pci_remove_behind_bridge(struct pci_dev *dev)
-{
-	struct list_head *l, *n;
-
-	if (dev->subordinate) {
-		list_for_each_safe(l, n, &dev->subordinate->devices) {
-			struct pci_dev *dev = pci_dev_b(l);
-
-			pci_remove_bus_device(dev);
-		}
-	}
-}
-
-EXPORT_SYMBOL(pci_remove_bus_device);
-EXPORT_SYMBOL(pci_remove_behind_bridge);


