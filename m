Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWIAQCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWIAQCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 12:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWIAQCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 12:02:14 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:12953 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932327AbWIAQCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 12:02:11 -0400
Date: Fri, 1 Sep 2006 11:02:08 -0500 (CDT)
From: John Keller <jpk@sgi.com>
To: linux-ia64@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, ayoung@sgi.com, linux-kernel@vger.kernel.org,
       John Keller <jpk@sgi.com>, pcihpd-discuss@lists.sourceforge.net
Message-Id: <20060901160208.31826.69050.77712@attica.americas.sgi.com>
Subject: [PATCH 2/3] - Altix: Add initial ACPI IO support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SN ACPI hotplug support.

A few minor changes to the way slot/device fixup is done.

No need to be calling sn_pci_controller_fixup(), as
a root bus cannot be hotplugged.

Signed-off-by: John Keller <jpk@sgi.com>

 sgi_hotplug.c |   34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)


Index: linux-2.6/drivers/pci/hotplug/sgi_hotplug.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/sgi_hotplug.c	2006-08-31 13:48:37.041468566 -0500
+++ linux-2.6/drivers/pci/hotplug/sgi_hotplug.c	2006-08-31 14:27:13.326389685 -0500
@@ -205,21 +205,6 @@ static struct hotplug_slot * sn_hp_destr
 	return bss_hotplug_slot;
 }
 
-static void sn_bus_alloc_data(struct pci_dev *dev)
-{
-	struct pci_bus *subordinate_bus;
-	struct pci_dev *child;
-
-	sn_pci_fixup_slot(dev);
-
-	/* Recursively sets up the sn_irq_info structs */
-	if (dev->subordinate) {
-		subordinate_bus = dev->subordinate;
-		list_for_each_entry(child, &subordinate_bus->devices, bus_list)
-			sn_bus_alloc_data(child);
-	}
-}
-
 static void sn_bus_free_data(struct pci_dev *dev)
 {
 	struct pci_bus *subordinate_bus;
@@ -337,6 +322,11 @@ static int sn_slot_disable(struct hotplu
 	return rc;
 }
 
+/*
+ * Power up and configure the slot via a SAL call to PROM.
+ * Scan slot (and any children), do any platform specific fixup,
+ * and find device driver.
+ */
 static int enable_slot(struct hotplug_slot *bss_hotplug_slot)
 {
 	struct slot *slot = bss_hotplug_slot->private;
@@ -367,9 +357,6 @@ static int enable_slot(struct hotplug_sl
 		return -ENODEV;
 	}
 
-	sn_pci_controller_fixup(pci_domain_nr(slot->pci_bus),
-				slot->pci_bus->number,
-				slot->pci_bus);
 	/*
 	 * Map SN resources for all functions on the card
 	 * to the Linux PCI interface and tell the drivers
@@ -380,6 +367,13 @@ static int enable_slot(struct hotplug_sl
 				   PCI_DEVFN(slot->device_num + 1,
 					     PCI_FUNC(func)));
 		if (dev) {
+			/* Need to do slot fixup on PPB before fixup of children
+			 * (PPB's pcidev_info needs to be in pcidev_info list
+			 * before child's SN_PCIDEV_INFO() call to setup
+			 * pdi_host_pcidev_info).
+			 */
+			pcibios_fixup_device_resources(dev);
+			sn_pci_fixup_slot(dev);
 			if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
 				unsigned char sec_bus;
 				pci_read_config_byte(dev, PCI_SECONDARY_BUS,
@@ -387,12 +381,8 @@ static int enable_slot(struct hotplug_sl
 				new_bus = pci_add_new_bus(dev->bus, dev,
 							  sec_bus);
 				pci_scan_child_bus(new_bus);
-				sn_pci_controller_fixup(pci_domain_nr(new_bus),
-							new_bus->number,
-							new_bus);
 				new_ppb = 1;
 			}
-			sn_bus_alloc_data(dev);
 			pci_dev_put(dev);
 		}
 	}
