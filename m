Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbUB1AQj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 19:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263227AbUB1ANe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 19:13:34 -0500
Received: from mail.kroah.org ([65.200.24.183]:51877 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263220AbUB1AJx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 19:09:53 -0500
Subject: Re: [PATCH] PCI fixes for 2.6.4-rc1
In-Reply-To: <10779269823562@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 27 Feb 2004 16:09:43 -0800
Message-Id: <10779269821259@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1615, 2004/02/24 11:07:59-08:00, rmk-pci@arm.linux.org.uk

[PATCH] PCI: Introduce bus->bridge_ctl member

GregKH mentioned confirmed that people have been waiting for this patch.
Appologies, it had completely evaporated from my mind.

This patch introduces the "bridge_ctl" member of pci_bus, which allows
architectures to tweak the bridge control register (eg, for setting
fast back to back modes etc) in pcibios_fixup_bus().

Please note, though, that the value is only written back if
pci_setup_bridge() is called.  This will be called if an architecture
is using the generic PCI bus setup functionality in setup-bus.c.
If an architecture doesn't, then it is the responsibility of the
architecture to write this value to the bridge as appropriate.

(That said, the bridge control register is only ever changed if an
architecture is using setup-bus.c anyway, so there should be no
overall functional change.)


 drivers/pci/probe.c     |    4 ++++
 drivers/pci/setup-bus.c |   22 ++++++++++------------
 include/linux/pci.h     |    2 ++
 3 files changed, 16 insertions(+), 12 deletions(-)


diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	Fri Feb 27 15:57:26 2004
+++ b/drivers/pci/probe.c	Fri Feb 27 15:57:26 2004
@@ -366,6 +366,8 @@
 		child = pci_alloc_child_bus(bus, dev, busnr);
 		child->primary = buses & 0xFF;
 		child->subordinate = (buses >> 16) & 0xFF;
+		child->bridge_ctl = bctl;
+
 		cmax = pci_scan_child_bus(child);
 		if (cmax > max) max = cmax;
 	} else {
@@ -400,6 +402,8 @@
 		pci_write_config_dword(dev, PCI_PRIMARY_BUS, buses);
 
 		if (!is_cardbus) {
+			child->bridge_ctl = PCI_BRIDGE_CTL_NO_ISA;
+
 			/* Now we can scan all subordinate buses... */
 			max = pci_scan_child_bus(child);
 		} else {
diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c	Fri Feb 27 15:57:26 2004
+++ b/drivers/pci/setup-bus.c	Fri Feb 27 15:57:26 2004
@@ -43,13 +43,15 @@
 #define CARDBUS_IO_SIZE		(4096)
 #define CARDBUS_MEM_SIZE	(32*1024*1024)
 
-static int __devinit
+static void __devinit
 pbus_assign_resources_sorted(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 	struct resource *res;
 	struct resource_list head, *list, *tmp;
-	int idx, found_vga = 0;
+	int idx;
+
+	bus->bridge_ctl &= ~PCI_BRIDGE_CTL_VGA;
 
 	head.next = NULL;
 	list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -57,7 +59,7 @@
 
 		if (class == PCI_CLASS_DISPLAY_VGA
 				|| class == PCI_CLASS_NOT_DEFINED_VGA)
-			found_vga = 1;
+			bus->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
 
 		pdev_sort_resources(dev, &head);
 	}
@@ -70,8 +72,6 @@
 		list = list->next;
 		kfree(tmp);
 	}
-
-	return found_vga;
 }
 
 static void __devinit
@@ -211,10 +211,7 @@
 	/* Clear out the upper 32 bits of PREF base. */
 	pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, 0);
 
-	/* Check if we have VGA behind the bridge.
-	   Enable ISA in either case (FIXME!). */
-	l = (bus->resource[0]->flags & IORESOURCE_BUS_HAS_VGA) ? 0x0c : 0x04;
-	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, l);
+	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
 }
 
 /* Check whether the bridge supports optional I/O and
@@ -498,13 +495,14 @@
 pci_bus_assign_resources(struct pci_bus *bus)
 {
 	struct pci_bus *b;
-	int found_vga = pbus_assign_resources_sorted(bus);
 	struct pci_dev *dev;
 
-	if (found_vga) {
+	pbus_assign_resources_sorted(bus);
+
+	if (bus->bridge_ctl & PCI_BRIDGE_CTL_VGA) {
 		/* Propagate presence of the VGA to upstream bridges */
 		for (b = bus; b->parent; b = b->parent) {
-			b->resource[0]->flags |= IORESOURCE_BUS_HAS_VGA;
+			b->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
 		}
 	}
 	list_for_each_entry(dev, &bus->devices, bus_list) {
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Fri Feb 27 15:57:26 2004
+++ b/include/linux/pci.h	Fri Feb 27 15:57:26 2004
@@ -468,6 +468,8 @@
 
 	char		name[48];
 
+	unsigned short  bridge_ctl;	/* manage NO_ISA/FBB/et al behaviors */
+	unsigned short  pad2;
 	struct device		*bridge;
 	struct class_device	class_dev;
 };

