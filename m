Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbTCEAaF>; Tue, 4 Mar 2003 19:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266907AbTCEAaE>; Tue, 4 Mar 2003 19:30:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26386 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266987AbTCEA3i>; Tue, 4 Mar 2003 19:29:38 -0500
Date: Wed, 5 Mar 2003 00:40:04 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] PCI probing for cardbus (3/5)
Message-ID: <20030305004004.D25251@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030305003635.A25251@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030305003635.A25251@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Wed, Mar 05, 2003 at 12:36:35AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u orig/drivers/pci/bus.c linux/drivers/pci/bus.c
--- orig/drivers/pci/bus.c	Mon Mar  3 21:24:55 2003
+++ orig/drivers/pci/bus.c	Mon Mar  3 21:26:41 2003
@@ -12,6 +12,10 @@
 #include <linux/pci.h>
 #include <linux/errno.h>
 #include <linux/ioport.h>
+#include <linux/proc_fs.h>
+#include <linux/init.h>
+
+#include "pci.h"
 
 /**
  * pci_bus_alloc_resource - allocate a resource from a parent bus
@@ -64,6 +68,47 @@
 	return ret;
 }
 
+/**
+ * pci_bus_add_devices - insert newly discovered PCI devices
+ * @bus: bus to check for new devices
+ *
+ * Add newly discovered PCI devices (which are on the bus->devices
+ * list) to the global PCI device list, add the sysfs and procfs
+ * entries.  Where a bridge is found, add the discovered bus to
+ * the parents list of child buses, and recurse.
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
+
+		device_register(&dev->dev);
+		list_add_tail(&dev->global_list, &pci_devices);
+#ifdef CONFIG_PROC_FS
+		pci_proc_attach_device(dev);
+#endif
+		pci_create_sysfs_dev_files(dev);
+
+		/*
+		 * If there is an unattached subordinate bus, attach
+		 * it and then scan for unattached PCI devices.
+		 */
+		if (dev->subordinate && list_empty(&dev->subordinate->node)) {
+			list_add_tail(&dev->subordinate->node, &dev->bus->children);
+			pci_bus_add_devices(dev->subordinate);
+		}
+	}
+}
+
 void pci_enable_bridges(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
@@ -78,4 +123,5 @@
 }
 
 EXPORT_SYMBOL(pci_bus_alloc_resource);
+EXPORT_SYMBOL(pci_bus_add_devices);
 EXPORT_SYMBOL(pci_enable_bridges);
diff -u orig/drivers/pci/probe.c linux/drivers/pci/probe.c
--- orig/drivers/pci/probe.c	Mon Mar  3 21:24:47 2003
+++ linux/drivers/pci/probe.c	Mon Mar  3 21:25:47 2003
@@ -221,6 +221,7 @@
 	b = kmalloc(sizeof(*b), GFP_KERNEL);
 	if (b) {
 		memset(b, 0, sizeof(*b));
+		INIT_LIST_HEAD(&b->node);
 		INIT_LIST_HEAD(&b->children);
 		INIT_LIST_HEAD(&b->devices);
 	}
@@ -477,10 +478,18 @@
 	return dev;
 }
 
-struct pci_dev * __devinit pci_scan_slot(struct pci_bus *bus, int devfn)
+/**
+ * pci_scan_slot - scan a PCI slot on a bus for devices.
+ * @bus: PCI bus to scan
+ * @devfn: slot number to scan (must have zero function.)
+ *
+ * Scan a PCI slot on the specified PCI bus for devices, adding
+ * discovered devices to the @bus->devices list.  New devices
+ * will have an empty dev->global_list head.
+ */
+int __devinit pci_scan_slot(struct pci_bus *bus, int devfn)
 {
-	struct pci_dev *first_dev = NULL;
-	int func;
+	int func, nr = 0;
 
 	for (func = 0; func < 8; func++, devfn++) {
 		struct pci_dev *dev;
@@ -489,22 +498,19 @@
 		if (!dev)
 			continue;
 
-		if (func == 0) {
-			first_dev = dev;
-		} else {
+		if (func != 0)
 			dev->multifunction = 1;
-		}
 
 		/* Fix up broken headers */
 		pci_fixup_device(PCI_FIXUP_HEADER, dev);
 
 		/*
-		 * Link the device to both the global PCI device chain and
-		 * the per-bus list of devices and add the /proc entry.
-		 * Note: this also runs the hotplug notifiers (bad!) --rmk
+		 * Add the device to our list of discovered devices
+		 * and the bus list for fixup functions, etc.
 		 */
-		device_register(&dev->dev);
-		pci_insert_device (dev, bus);
+		INIT_LIST_HEAD(&dev->global_list);
+		list_add_tail(&dev->bus_list, &bus->devices);
+		nr++;
 
 		/*
 		 * If this is a single function device,
@@ -513,17 +519,15 @@
 		if (!dev->multifunction)
 			break;
 	}
-	return first_dev;
+	return nr;
 }
 
-unsigned int __devinit pci_do_scan_bus(struct pci_bus *bus)
+static unsigned int __devinit pci_scan_child_bus(struct pci_bus *bus)
 {
-	unsigned int devfn, max, pass;
-	struct list_head *ln;
+	unsigned int devfn, pass, max = bus->secondary;
 	struct pci_dev *dev;
 
 	DBG("Scanning bus %02x\n", bus->number);
-	max = bus->secondary;
 
 	/* Go find them, Rover! */
 	for (devfn = 0; devfn < 0x100; devfn += 8)
@@ -550,6 +554,20 @@
 	 * Return how far we've got finding sub-buses.
 	 */
 	DBG("Bus scan for %02x returning with max=%02x\n", bus->number, max);
+	return max;
+}
+
+unsigned int __devinit pci_do_scan_bus(struct pci_bus *bus)
+{
+	unsigned int max;
+
+	max = pci_scan_child_bus(bus);
+
+	/*
+	 * Make the discovered devices available.
+	 */
+	pci_bus_add_devices(bus);
+
 	return max;
 }
 
--- orig/include/linux/pci.h	Tue Feb 25 23:34:29 2003
+++ linux/include/linux/pci.h	Tue Feb 25 23:37:27 2003
@@ -549,7 +549,8 @@
 {
 	return pci_alloc_primary_bus_parented(NULL, bus);
 }
-struct pci_dev *pci_scan_slot(struct pci_bus *bus, int devfn);
+int pci_scan_slot(struct pci_bus *bus, int devfn);
+void pci_bus_add_devices(struct pci_bus *bus);
 int pci_proc_attach_device(struct pci_dev *dev);
 int pci_proc_detach_device(struct pci_dev *dev);
 int pci_proc_attach_bus(struct pci_bus *bus);

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

