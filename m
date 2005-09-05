Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbVIFAAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbVIFAAP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 20:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbVIFAAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 20:00:15 -0400
Received: from ozlabs.org ([203.10.76.45]:26595 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964976AbVIFAAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 20:00:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17180.54583.575784.494320@cargo.ozlabs.ibm.com>
Date: Tue, 6 Sep 2005 09:31:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: Greg KH <greg@kroah.com>
CC: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] Small rearrangement of PCI probing code
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some small rearrangements of the PCI probing code in
order to make it possible for arch code to set up the PCI tree
without needing to duplicate code from the PCI layer unnecessarily.
PPC64 will use this to set up the PCI tree from the Open Firmware
device tree, which we need to do on logically-partitioned pSeries
systems.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 drivers/pci/pci.h   |    1 -
 drivers/pci/probe.c |   50 +++++++++++++++++++++++++++++++++-----------------
 include/linux/pci.h |    3 +++
 3 files changed, 36 insertions(+), 18 deletions(-)

diff -urN linux-2.6/drivers/pci/pci.h g5-ofpci/drivers/pci/pci.h
--- linux-2.6/drivers/pci/pci.h	2005-08-17 17:51:11.000000000 +1000
+++ g5-ofpci/drivers/pci/pci.h	2005-08-22 16:25:43.000000000 +1000
@@ -29,7 +29,6 @@
 #endif
 
 /* Functions for PCI Hotplug drivers to use */
-extern struct pci_bus * pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr);
 extern unsigned int pci_do_scan_bus(struct pci_bus *bus);
 extern int pci_remove_device_safe(struct pci_dev *dev);
 extern unsigned char pci_max_busnr(void);
diff -urN linux-2.6/drivers/pci/probe.c g5-ofpci/drivers/pci/probe.c
--- linux-2.6/drivers/pci/probe.c	2005-07-31 17:38:35.000000000 +1000
+++ g5-ofpci/drivers/pci/probe.c	2005-08-22 15:03:30.000000000 +1000
@@ -753,6 +753,12 @@
 		kfree(dev);
 		return NULL;
 	}
+
+	return dev;
+}
+
+void __devinit pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
+{
 	device_initialize(&dev->dev);
 	dev->dev.release = pci_release_dev;
 	pci_dev_get(dev);
@@ -762,20 +768,6 @@
 	dev->dev.dma_mask = &dev->dma_mask;
 	dev->dev.coherent_dma_mask = 0xffffffffull;
 
-	return dev;
-}
-
-struct pci_dev * __devinit
-pci_scan_single_device(struct pci_bus *bus, int devfn)
-{
-	struct pci_dev *dev;
-
-	dev = pci_scan_device(bus, devfn);
-	pci_scan_msi_device(dev);
-
-	if (!dev)
-		return NULL;
-	
 	/* Fix up broken headers */
 	pci_fixup_device(pci_fixup_header, dev);
 
@@ -787,6 +779,19 @@
 	spin_lock(&pci_bus_lock);
 	list_add_tail(&dev->bus_list, &bus->devices);
 	spin_unlock(&pci_bus_lock);
+}
+
+struct pci_dev * __devinit
+pci_scan_single_device(struct pci_bus *bus, int devfn)
+{
+	struct pci_dev *dev;
+
+	dev = pci_scan_device(bus, devfn);
+	if (!dev)
+		return NULL;
+
+	pci_device_add(dev, bus);
+	pci_scan_msi_device(dev);
 
 	return dev;
 }
@@ -883,7 +888,8 @@
 	return max;
 }
 
-struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent, int bus, struct pci_ops *ops, void *sysdata)
+struct pci_bus * __devinit pci_create_bus(struct device *parent,
+		int bus, struct pci_ops *ops, void *sysdata)
 {
 	int error;
 	struct pci_bus *b;
@@ -940,8 +946,6 @@
 	b->resource[0] = &ioport_resource;
 	b->resource[1] = &iomem_resource;
 
-	b->subordinate = pci_scan_child_bus(b);
-
 	return b;
 
 sys_create_link_err:
@@ -959,6 +963,18 @@
 	kfree(b);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(pci_create_bus);
+
+struct pci_bus * __devinit pci_scan_bus_parented(struct device *parent,
+		int bus, struct pci_ops *ops, void *sysdata)
+{
+	struct pci_bus *b;
+
+	b = pci_create_bus(parent, bus, ops, sysdata);
+	if (b)
+		b->subordinate = pci_scan_child_bus(b);
+	return b;
+}
 EXPORT_SYMBOL(pci_scan_bus_parented);
 
 #ifdef CONFIG_HOTPLUG
diff -urN linux-2.6/include/linux/pci.h g5-ofpci/include/linux/pci.h
--- linux-2.6/include/linux/pci.h	2005-08-17 17:51:11.000000000 +1000
+++ g5-ofpci/include/linux/pci.h	2005-08-24 21:06:14.000000000 +1000
@@ -745,8 +745,11 @@
 		pci_bus_add_devices(root_bus);
 	return root_bus;
 }
+struct pci_bus *pci_create_bus(struct device *parent, int bus, struct pci_ops *ops, void *sysdata);
+struct pci_bus * pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev, int busnr);
 int pci_scan_slot(struct pci_bus *bus, int devfn);
 struct pci_dev * pci_scan_single_device(struct pci_bus *bus, int devfn);
+void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
 unsigned int pci_scan_child_bus(struct pci_bus *bus);
 void pci_bus_add_device(struct pci_dev *dev);
 void pci_name_device(struct pci_dev *dev);
