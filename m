Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262958AbVDBAkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262958AbVDBAkf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbVDBAKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:10:00 -0500
Received: from mail.kroah.org ([69.55.234.183]:39132 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262947AbVDAXsR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:17 -0500
Cc: bjorn.helgaas@hp.com
Subject: [PATCH] PCI: trivial DBG tidy-up
In-Reply-To: <11123992703458@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:50 -0800
Message-Id: <11123992702271@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.8, 2005/03/17 13:50:00-08:00, bjorn.helgaas@hp.com

[PATCH] PCI: trivial DBG tidy-up

Tidy-up a bunch of PCI DBG output to use pci_name() when possible,
add domain when appropriate, remove redundancy, settle on one
style (DBG vs DBGC), etc.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/hotplug.c   |   10 ++++------
 drivers/pci/probe.c     |   13 +++++++------
 drivers/pci/setup-bus.c |   25 ++++++++++++-------------
 drivers/pci/setup-irq.c |    8 ++++----
 drivers/pci/setup-res.c |   14 +++++++-------
 5 files changed, 34 insertions(+), 36 deletions(-)


diff -Nru a/drivers/pci/hotplug.c b/drivers/pci/hotplug.c
--- a/drivers/pci/hotplug.c	2005-04-01 15:37:39 -08:00
+++ b/drivers/pci/hotplug.c	2005-04-01 15:37:39 -08:00
@@ -71,7 +71,8 @@
 	struct pci_dev_wrapped wrapped_dev;
 	int result = 0;
 
-	DBG("scanning bus %02x\n", wrapped_bus->bus->number);
+	DBG("PCI: Scanning bus %04x:%02x\n", pci_domain_nr(wrapped_bus->bus),
+		wrapped_bus->bus->number);
 
 	if (fn->pre_visit_pci_bus) {
 		result = fn->pre_visit_pci_bus(wrapped_bus, wrapped_parent);
@@ -106,8 +107,7 @@
 	struct pci_bus_wrapped wrapped_bus;
 	int result = 0;
 
-	DBG("scanning bridge %02x, %02x\n", PCI_SLOT(wrapped_dev->dev->devfn),
-	    PCI_FUNC(wrapped_dev->dev->devfn));
+	DBG("PCI: Scanning bridge %s\n", pci_name(wrapped_dev->dev));
 
 	if (fn->visit_pci_dev) {
 		result = fn->visit_pci_dev(wrapped_dev, wrapped_parent);
@@ -153,8 +153,7 @@
 				return result;
 			break;
 		default:
-			DBG("scanning device %02x, %02x\n",
-			    PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
+			DBG("PCI: Scanning device %s\n", pci_name(dev));
 			if (fn->visit_pci_dev) {
 				result = fn->visit_pci_dev (wrapped_dev,
 							    wrapped_parent);
@@ -169,4 +168,3 @@
 	return result;
 }
 EXPORT_SYMBOL(pci_visit_dev);
-
diff -Nru a/drivers/pci/probe.c b/drivers/pci/probe.c
--- a/drivers/pci/probe.c	2005-04-01 15:37:39 -08:00
+++ b/drivers/pci/probe.c	2005-04-01 15:37:39 -08:00
@@ -422,7 +422,7 @@
 
 	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
 
-	DBG("Scanning behind PCI bridge %s, config %06x, pass %d\n",
+	DBG("PCI: Scanning behind PCI bridge %s, config %06x, pass %d\n",
 	    pci_name(dev), buses & 0xffffff, pass);
 
 	/* Disable MasterAbortMode during probing to avoid reporting
@@ -559,8 +559,8 @@
 	dev->class = class;
 	class >>= 8;
 
-	DBG("Found %02x:%02x [%04x/%04x] %06x %02x\n", dev->bus->number,
-	    dev->devfn, dev->vendor, dev->device, class, dev->hdr_type);
+	DBG("PCI: Found %s [%04x/%04x] %06x %02x\n", pci_name(dev),
+	    dev->vendor, dev->device, class, dev->hdr_type);
 
 	/* "Unknown power state" */
 	dev->current_state = 4;
@@ -815,7 +815,7 @@
 	unsigned int devfn, pass, max = bus->secondary;
 	struct pci_dev *dev;
 
-	DBG("Scanning bus %02x\n", bus->number);
+	DBG("PCI: Scanning bus %04x:%02x\n", pci_domain_nr(bus), bus->number);
 
 	/* Go find them, Rover! */
 	for (devfn = 0; devfn < 0x100; devfn += 8)
@@ -825,7 +825,7 @@
 	 * After performing arch-dependent fixup of the bus, look behind
 	 * all PCI-to-PCI bridges on this bus.
 	 */
-	DBG("Fixups for bus %02x\n", bus->number);
+	DBG("PCI: Fixups for bus %04x:%02x\n", pci_domain_nr(bus), bus->number);
 	pcibios_fixup_bus(bus);
 	for (pass=0; pass < 2; pass++)
 		list_for_each_entry(dev, &bus->devices, bus_list) {
@@ -841,7 +841,8 @@
 	 *
 	 * Return how far we've got finding sub-buses.
 	 */
-	DBG("Bus scan for %02x returning with max=%02x\n", bus->number, max);
+	DBG("PCI: Bus scan for %04x:%02x returning with max=%02x\n",
+		pci_domain_nr(bus), bus->number, max);
 	return max;
 }
 
diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c	2005-04-01 15:37:39 -08:00
+++ b/drivers/pci/setup-bus.c	2005-04-01 15:37:39 -08:00
@@ -29,9 +29,9 @@
 
 #define DEBUG_CONFIG 1
 #if DEBUG_CONFIG
-# define DBGC(args)     printk args
+#define DBG(x...)     printk(x)
 #else
-# define DBGC(args)
+#define DBG(x...)
 #endif
 
 #define ROUND_UP(x, a)		(((x) + (a) - 1) & ~((a) - 1))
@@ -151,8 +151,7 @@
 	struct pci_bus_region region;
 	u32 l, io_upper16;
 
-	DBGC((KERN_INFO "PCI: Bus %d, bridge: %s\n",
-			bus->number, pci_name(bridge)));
+	DBG(KERN_INFO "PCI: Bridge: %s\n", pci_name(bridge));
 
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
 	pcibios_resource_to_bus(bridge, &region, bus->resource[0]);
@@ -163,14 +162,14 @@
 		l |= region.end & 0xf000;
 		/* Set up upper 16 bits of I/O base/limit. */
 		io_upper16 = (region.end & 0xffff0000) | (region.start >> 16);
-		DBGC((KERN_INFO "  IO window: %04lx-%04lx\n",
-				region.start, region.end));
+		DBG(KERN_INFO "  IO window: %04lx-%04lx\n",
+				region.start, region.end);
 	}
 	else {
 		/* Clear upper 16 bits of I/O base/limit. */
 		io_upper16 = 0;
 		l = 0x00f0;
-		DBGC((KERN_INFO "  IO window: disabled.\n"));
+		DBG(KERN_INFO "  IO window: disabled.\n");
 	}
 	/* Temporarily disable the I/O range before updating PCI_IO_BASE. */
 	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0x0000ffff);
@@ -185,12 +184,12 @@
 	if (bus->resource[1]->flags & IORESOURCE_MEM) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
-		DBGC((KERN_INFO "  MEM window: %08lx-%08lx\n",
-				region.start, region.end));
+		DBG(KERN_INFO "  MEM window: %08lx-%08lx\n",
+				region.start, region.end);
 	}
 	else {
 		l = 0x0000fff0;
-		DBGC((KERN_INFO "  MEM window: disabled.\n"));
+		DBG(KERN_INFO "  MEM window: disabled.\n");
 	}
 	pci_write_config_dword(bridge, PCI_MEMORY_BASE, l);
 
@@ -204,12 +203,12 @@
 	if (bus->resource[2]->flags & IORESOURCE_PREFETCH) {
 		l = (region.start >> 16) & 0xfff0;
 		l |= region.end & 0xfff00000;
-		DBGC((KERN_INFO "  PREFETCH window: %08lx-%08lx\n",
-				region.start, region.end));
+		DBG(KERN_INFO "  PREFETCH window: %08lx-%08lx\n",
+				region.start, region.end);
 	}
 	else {
 		l = 0x0000fff0;
-		DBGC((KERN_INFO "  PREFETCH window: disabled.\n"));
+		DBG(KERN_INFO "  PREFETCH window: disabled.\n");
 	}
 	pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);
 
diff -Nru a/drivers/pci/setup-irq.c b/drivers/pci/setup-irq.c
--- a/drivers/pci/setup-irq.c	2005-04-01 15:37:39 -08:00
+++ b/drivers/pci/setup-irq.c	2005-04-01 15:37:39 -08:00
@@ -20,9 +20,9 @@
 
 #define DEBUG_CONFIG 0
 #if DEBUG_CONFIG
-# define DBGC(args)     printk args
+#define DBG(x...)     printk(x)
 #else
-# define DBGC(args)
+#define DBG(x...)
 #endif
 
 
@@ -53,8 +53,8 @@
 		irq = 0;
 	dev->irq = irq;
 
-	DBGC((KERN_ERR "PCI fixup irq: (%s) got %d\n", 
-		dev->dev.kobj.name, dev->irq));
+	DBG(KERN_ERR "PCI: fixup irq: (%s) got %d\n",
+		dev->dev.kobj.name, dev->irq);
 
 	/* Always tell the device, so the driver knows what is
 	   the real IRQ to use; the device does not use it. */
diff -Nru a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
--- a/drivers/pci/setup-res.c	2005-04-01 15:37:39 -08:00
+++ b/drivers/pci/setup-res.c	2005-04-01 15:37:39 -08:00
@@ -27,9 +27,9 @@
 
 #define DEBUG_CONFIG 0
 #if DEBUG_CONFIG
-# define DBGC(args)     printk args
+#define DBG(x...)     printk(x)
 #else
-# define DBGC(args)
+#define DBG(x...)
 #endif
 
 
@@ -42,10 +42,10 @@
 
 	pcibios_resource_to_bus(dev, &region, res);
 
-	DBGC((KERN_ERR "  got res [%lx:%lx] bus [%lx:%lx] flags %lx for "
+	DBG(KERN_ERR "  got res [%lx:%lx] bus [%lx:%lx] flags %lx for "
 	      "BAR %d of %s\n", res->start, res->end,
 	      region.start, region.end, res->flags,
-	      resno, pci_name(dev)));
+	      resno, pci_name(dev));
 
 	new = region.start | (res->flags & PCI_REGION_FLAG_MASK);
 	if (res->flags & IORESOURCE_IO)
@@ -60,7 +60,7 @@
 		reg = dev->rom_base_reg;
 	} else {
 		/* Hmm, non-standard resource. */
-		BUG();
+	
 		return;		/* kill uninitialised var warning */
 	}
 
@@ -85,9 +85,9 @@
 		}
 	}
 	res->flags &= ~IORESOURCE_UNSET;
-	DBGC((KERN_INFO "PCI: moved device %s resource %d (%lx) to %x\n",
+	DBG(KERN_INFO "PCI: moved device %s resource %d (%lx) to %x\n",
 		pci_name(dev), resno, res->flags,
-		new & ~PCI_REGION_FLAG_MASK));
+		new & ~PCI_REGION_FLAG_MASK);
 }
 
 int __devinit

