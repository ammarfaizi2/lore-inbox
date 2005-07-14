Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262966AbVGNJJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbVGNJJc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbVGNJHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:07:32 -0400
Received: from peabody.ximian.com ([130.57.169.10]:7561 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262966AbVGNJFb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:05:31 -0400
Subject: [RFC][PATCH] Add PCI<->PCI bridge driver [4/9]
From: Adam Belay <abelay@novell.com>
To: linux-kernel@vger.kernel.org
Cc: greg@kroah.com
Content-Type: text/plain
Date: Thu, 14 Jul 2005 04:55:19 -0400
Message-Id: <1121331319.3398.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a basic PCI<->PCI bridge driver that utilizes the new
PCI bus class API.

Signed-off-by: Adam Belay <abelay@novell.com>

--- a/drivers/pci/bus/pci-bridge.c	1969-12-31 19:00:00.000000000 -0500
+++ b/drivers/pci/bus/pci-bridge.c	2005-07-08 02:18:43.000000000 -0400
@@ -0,0 +1,165 @@
+/*
+ * pci-bridge.c - a generic PCI bus driver for PCI<->PCI bridges
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+static struct pci_device_id ppb_id_tbl[] = {
+	{ PCI_DEVICE_CLASS(PCI_CLASS_BRIDGE_PCI << 8, 0xffff00) },
+	{ 0 },
+};
+
+MODULE_DEVICE_TABLE(pci, ppb_id_tbl);
+
+/**
+ * ppb_create_bus - allocates a bus and fills in basic information
+ * @dev: the pci bridge device
+ */
+static struct pci_bus * ppb_create_bus(struct pci_dev *dev)
+{
+	int i;
+	struct pci_bus *bus = pci_alloc_bus();
+
+	if (!bus)
+		return NULL;
+
+	bus->parent = dev->bus;
+	bus->bridge = &dev->dev;
+	bus->ops = bus->parent->ops;
+	bus->sysdata = bus->parent->sysdata;
+	bus->bridge = get_device(&dev->dev);
+
+	/* Set up default resource pointers and names.. */
+	for (i = 0; i < 4; i++) {
+		bus->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
+		bus->resource[i]->name = bus->name;
+	}
+
+	return bus;
+}
+
+/**
+ * ppb_detect_bus - creates a bus and reads configuration space data
+ * @dev: the pci bridge device
+ *
+ * This function will do some verification to ensure we should drive this
+ * bridge.
+ */
+static struct pci_bus * ppb_detect_bus(struct pci_dev *dev)
+{
+	struct pci_bus *bus;
+	u32 buses;
+	u16 bctl;
+	unsigned int busnr;
+
+	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
+	busnr = (buses >> 8) & 0xFF;
+
+	/*
+	 * FIXME: This driver currently doesn't support bridges that haven't
+	 * been configured by the BIOS.
+	 */
+	if (!(buses & 0xffff00)) {
+		printk(KERN_INFO "PCI: Unable to drive bus %04x:%02x\n",
+				pci_domain_nr(dev->bus), busnr);
+		return NULL;
+	}
+
+	/*
+	 * If we already got to this bus through a different bridge,
+	 * ignore it.  This can happen with the i450NX chipset.
+	 */
+	if (pci_find_bus(pci_domain_nr(dev->bus), busnr)) {
+		printk(KERN_INFO "PCI: Bus %04x:%02x already known\n",
+				pci_domain_nr(dev->bus), busnr);
+		return NULL;
+	}
+
+	bus = ppb_create_bus(dev);
+	if (!bus)
+		return NULL;
+
+	/* Disable MasterAbortMode during probing to avoid reporting
+	 * of bus errors (in some architectures)
+	 */ 
+	pci_read_config_word(dev, PCI_BRIDGE_CONTROL, &bctl);
+	pci_write_config_word(dev, PCI_BRIDGE_CONTROL,
+			      bctl & ~PCI_BRIDGE_CTL_MASTER_ABORT);
+
+	bus->number = bus->secondary = busnr;
+	bus->primary = buses & 0xFF;
+	bus->subordinate = (buses >> 16) & 0xFF;
+	bus->bridge_ctl = bctl;
+
+	return bus;
+}
+
+/**
+ * ppb_detect_children - detects and registers child devices
+ * @bus: pci bus
+ */
+static void ppb_detect_children(struct pci_bus *bus)
+{
+	unsigned int devfn;
+
+	/* Go find them, Rover! */
+	for (devfn = 0; devfn < 0x100; devfn += 8)
+		pci_scan_slot(bus, devfn);
+
+	pcibios_fixup_bus(bus);
+	pci_bus_add_devices(bus);
+}
+
+static int ppb_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	int err;
+	struct pci_bus *bus;
+
+	if (dev->hdr_type != PCI_HEADER_TYPE_BRIDGE)
+		return -ENODEV;
+
+	bus = ppb_detect_bus(dev);
+	if (!bus)
+		return -ENODEV;
+
+	err = pci_add_bus(bus);
+	if (err)
+		goto out;
+
+	dev->subordinate = bus;
+	ppb_detect_children(bus);
+	return 0;
+
+out:
+	kfree(bus);
+	return err;
+}
+
+static void ppb_remove(struct pci_dev *dev)
+{
+	pci_remove_behind_bridge(dev);
+	pci_remove_bus(dev->subordinate);
+}
+
+static struct pci_driver ppb_driver = {
+	.name		= "pci-bridge",
+	.id_table	= ppb_id_tbl,
+	.probe		= ppb_probe,
+	.remove		= ppb_remove,
+};
+
+static int __init ppb_init(void)
+{
+	return pci_register_driver(&ppb_driver);
+}
+
+static void __exit ppb_exit(void)
+{
+	pci_unregister_driver(&ppb_driver);
+}
+
+module_init(ppb_init);
+module_exit(ppb_exit);
--- a/drivers/pci/bus/Makefile	2005-07-07 22:22:49.000000000 -0400
+++ b/drivers/pci/bus/Makefile	2005-07-08 02:16:39.000000000 -0400
@@ -2,4 +2,4 @@
 # Makefile for the PCI device detection
 #
 
-obj-y :=  bus.o config.o device.o probe.o
+obj-y :=  bus.o config.o device.o probe.o pci-bridge.o


