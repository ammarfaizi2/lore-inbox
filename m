Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318019AbSHCWaW>; Sat, 3 Aug 2002 18:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318016AbSHCW30>; Sat, 3 Aug 2002 18:29:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:61713 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318013AbSHCW2O>; Sat, 3 Aug 2002 18:28:14 -0400
To: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 14: 2.5.29-pci
Message-Id: <E17b7R3-0007aN-00@flint.arm.linux.org.uk>
Date: Sat, 03 Aug 2002 23:31:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

This is something that I ported forward from Ivan's original PCI
changes, and has been sitting in the -rmk patch since the previous
round of PCI changes, and has working for me since.

If anyone wants to pick it up and do something with it, that's
fine by me.

Unfortunately, there doesn't seem to be a listed maintainer for
the PCI subsystem.

 drivers/pci/setup-bus.c |   22 ++++++++++------------
 include/linux/ioport.h  |    1 -
 include/linux/pci.h     |    2 ++
 3 files changed, 12 insertions, 13 deletions

diff -urN orig/drivers/pci/setup-bus.c linux/drivers/pci/setup-bus.c
--- orig/drivers/pci/setup-bus.c	Wed May 29 21:40:34 2002
+++ linux/drivers/pci/setup-bus.c	Wed May 29 21:55:30 2002
@@ -35,13 +35,13 @@
 
 #define ROUND_UP(x, a)		(((x) + (a) - 1) & ~((a) - 1))
 
-static int __init
+static void __init
 pbus_assign_resources_sorted(struct pci_bus *bus)
 {
 	struct list_head *ln;
 	struct resource *res;
 	struct resource_list head, *list, *tmp;
-	int idx, found_vga = 0;
+	int idx;
 
 	head.next = NULL;
 	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
@@ -57,7 +57,7 @@
 		   have VGA behind them.  */
 		if (class == PCI_CLASS_DISPLAY_VGA
 				|| class == PCI_CLASS_NOT_DEFINED_VGA)
-			found_vga = 1;
+			bus->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
 		else if (class >> 8 != PCI_BASE_CLASS_BRIDGE) {
 			pci_read_config_word(dev, PCI_COMMAND, &cmd);
 			cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY
@@ -76,8 +76,6 @@
 		list = list->next;
 		kfree(tmp);
 	}
-
-	return found_vga;
 }
 
 /* Initialize bridges with base/limit values we have collected.
@@ -159,10 +157,7 @@
 	}
 	pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);
 
-	/* Check if we have VGA behind the bridge.
-	   Enable ISA in either case (FIXME!). */
-	l = (bus->resource[0]->flags & IORESOURCE_BUS_HAS_VGA) ? 0x0c : 0x04;
-	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, l);
+	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
 }
 
 /* Check whether the bridge supports optional I/O and
@@ -362,18 +357,21 @@
 pbus_assign_resources(struct pci_bus *bus)
 {
 	struct list_head *ln;
-	int found_vga = pbus_assign_resources_sorted(bus);
 
-	if (found_vga) {
+	pbus_assign_resources_sorted(bus);
+
+	if (bus->bridge_ctl & PCI_BRIDGE_CTL_VGA) {
 		struct pci_bus *b;
 
 		/* Propagate presence of the VGA to upstream bridges */
 		for (b = bus; b->parent; b = b->parent) {
-			b->resource[0]->flags |= IORESOURCE_BUS_HAS_VGA;
+			b->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
 		}
 	}
 	for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
 		struct pci_bus *b = pci_bus_b(ln);
+
+		b->bridge_ctl = PCI_BRIDGE_CTL_NO_ISA;
 
 		pbus_assign_resources(b);
 		pci_setup_bridge(b);
diff -urN orig/include/linux/ioport.h linux/include/linux/ioport.h
--- orig/include/linux/ioport.h	Mon May 13 10:48:43 2002
+++ linux/include/linux/ioport.h	Mon May 13 10:42:24 2002
@@ -40,7 +40,6 @@
 #define IORESOURCE_CACHEABLE	0x00004000
 #define IORESOURCE_RANGELENGTH	0x00008000
 #define IORESOURCE_SHADOWABLE	0x00010000
-#define IORESOURCE_BUS_HAS_VGA	0x00080000
 
 #define IORESOURCE_UNSET	0x20000000
 #define IORESOURCE_AUTO		0x40000000
diff -urN orig/include/linux/pci.h linux/include/linux/pci.h
--- orig/include/linux/pci.h	Thu Jul 25 20:13:54 2002
+++ linux/include/linux/pci.h	Thu Jul 25 19:59:46 2002
@@ -433,6 +433,8 @@
 	unsigned char	productver;	/* product version */
 	unsigned char	checksum;	/* if zero - checksum passed */
 	unsigned char	pad1;
+	unsigned short  bridge_ctl;	/* manage NO_ISA/FBB/et al behaviors */
+	unsigned short  pad2;
 	struct	device	* dev;
 };
 

