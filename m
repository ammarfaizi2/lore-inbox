Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284612AbRLXKji>; Mon, 24 Dec 2001 05:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284617AbRLXKj3>; Mon, 24 Dec 2001 05:39:29 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:27910 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S284612AbRLXKjR>; Mon, 24 Dec 2001 05:39:17 -0500
Date: Mon, 24 Dec 2001 13:38:50 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.5: PCI setup reorg (alpha, arm, parisc)
Message-ID: <20011224133850.A10238@jurassic.park.msu.ru>
In-Reply-To: <20011222190548.A2097@jurassic.park.msu.ru> <20011222171538.A21533@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011222171538.A21533@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Dec 22, 2001 at 05:15:38PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2001 at 05:15:38PM +0000, Russell King wrote:
> What's happening about prefetchable memory regions?  You said in your
> previous emails on this subject that it would be covered in your up
> and coming patch (which I believe this is), but I haven't seen any
> mention of it, nor do I see any sign of it in the code.

You are right, it wasn't included, because I would like to see that
one integrated first. :-)
Anyway, appended here, applies on the top of previous patch.
Some more work is needed though - we should handle specific pci-pci bridge
quirks. I think we need something like this in the struct pci_bus:

	unsigned short  bridge_ctl;	/* manage NO_ISA/FBB/et al behaviors */
-	unsigned short  pad2;
+	unsigned short  bridge_quirks;
};

so that chip specific routines could pass info to the generic code.
Currently I have one candidate - DECchip 21050 (very first pci-pci bridge,
I think). It has address boundary disconnect problem causing data corruption,
and most reliable workaround seems to be disabling prefetchable window.

Ivan.

--- linux/drivers/pci/setup-bus.c.orig	Fri Dec 21 21:33:58 2001
+++ linux/drivers/pci/setup-bus.c	Mon Dec 24 13:01:52 2001
@@ -44,7 +44,8 @@
 
 static int __init
 pbus_assign_resources_sorted(struct pci_bus *bus,
-			     struct pbus_set_ranges_data *ranges)
+			     struct pbus_set_ranges_data *ranges,
+			     int pfmem)
 {
 	struct list_head *ln;
 	struct resource *res;
@@ -57,6 +58,12 @@ pbus_assign_resources_sorted(struct pci_
 		struct pci_dev *dev = pci_dev_b(ln);
 		u16 class = dev->class >> 8;
 
+		if (pfmem) {
+			pdev_sort_resources(dev, &head_mem,
+						 IORESOURCE_PREFETCH);
+			continue;
+		}
+
 		found_vga |= (class == PCI_CLASS_DISPLAY_VGA ||
 			      class == PCI_CLASS_NOT_DEFINED_VGA);
 
@@ -72,22 +79,25 @@ pbus_assign_resources_sorted(struct pci_
 		pdev_sort_resources(dev, &head_mem, IORESOURCE_MEM);
 	}
 
-	for (list = head_io.next; list;) {
+	for (list = head_mem.next; list;) {
 		res = list->res;
 		idx = res - &list->dev->resource[0];
 		if (pci_assign_resource(list->dev, idx) == 0
-		    && ranges->io_end < res->end)
-			ranges->io_end = res->end;
+		    && ranges->mem_end < res->end)
+			ranges->mem_end = res->end;
 		tmp = list;
 		list = list->next;
 		kfree(tmp);
 	}
-	for (list = head_mem.next; list;) {
+	if (pfmem)
+		goto pfmem_done;
+
+	for (list = head_io.next; list;) {
 		res = list->res;
 		idx = res - &list->dev->resource[0];
 		if (pci_assign_resource(list->dev, idx) == 0
-		    && ranges->mem_end < res->end)
-			ranges->mem_end = res->end;
+		    && ranges->io_end < res->end)
+			ranges->io_end = res->end;
 		tmp = list;
 		list = list->next;
 		kfree(tmp);
@@ -97,6 +107,8 @@ pbus_assign_resources_sorted(struct pci_
 	ranges->mem_end += mem_reserved;
 
 	ranges->io_end = ROUND_UP(ranges->io_end, 4*1024);
+
+ pfmem_done:
 	ranges->mem_end = ROUND_UP(ranges->mem_end, 1024*1024);
 
 	return found_vga;
@@ -119,9 +131,12 @@ pci_setup_bridge(struct pci_bus *bus)
 	ranges.mem_end = bus->resource[1]->end;
 	pcibios_fixup_pbus_ranges(bus, &ranges);
 
-	DBGC((KERN_ERR "PCI: Bus %d, bridge: %s\n", bus->number, bridge->name));
-	DBGC((KERN_ERR "  IO window: %04lx-%04lx\n", ranges.io_start, ranges.io_end));
-	DBGC((KERN_ERR "  MEM window: %08lx-%08lx\n", ranges.mem_start, ranges.mem_end));
+	DBGC((KERN_INFO "PCI: Bus %d, bridge: %s\n",
+			bus->number, bridge->name));
+	DBGC((KERN_INFO "  IO window: %04lx-%04lx\n",
+			ranges.io_start, ranges.io_end));
+	DBGC((KERN_INFO "  MEM window: %08lx-%08lx\n",
+			ranges.mem_start, ranges.mem_end));
 
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
 	pci_read_config_dword(bridge, PCI_IO_BASE, &l);
@@ -146,8 +161,18 @@ pci_setup_bridge(struct pci_bus *bus)
 	l |= ranges.mem_end & 0xfff00000;
 	pci_write_config_dword(bridge, PCI_MEMORY_BASE, l);
 
-	/* Disable PREF memory range. */
-	pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0000fff0);
+	/* Set up the top and bottom of the PCI Prefetchable Memory segment
+	   for this bus. */
+	ranges.mem_start = bus->resource[2]->start;
+	ranges.mem_end = bus->resource[2]->end;
+	pcibios_fixup_pbus_ranges(bus, &ranges);
+
+	DBGC((KERN_INFO "  PREF MEM window: %08lx-%08lx\n",
+			ranges.mem_start, ranges.mem_end));
+
+	l = (ranges.mem_start >> 16) & 0xfff0;
+	l |= ranges.mem_end & 0xfff00000;
+	pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);
 
 	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, bus->bridge_ctl);
 
@@ -155,13 +180,15 @@ pci_setup_bridge(struct pci_bus *bus)
 	pci_set_master(bridge);
 }
 
-/* Check whether the bridge supports I/O forwarding.
-   If not, its I/O base/limit register must be
-   read-only and read as 0. */
+/* Check whether the bridge supports optional I/O and
+   prefetchable memory ranges. If not, the respective
+   base/limit registers must be read-only and read as 0. */
 static unsigned long __init
-pci_bridge_check_io(struct pci_dev *bridge)
+pci_bridge_check_ranges(struct pci_dev *bridge)
 {
 	u16 io;
+	u32 pmem;
+	unsigned long ret = 0;
 
 	pci_read_config_word(bridge, PCI_IO_BASE, &io);
 	if (!io) {
@@ -170,29 +197,32 @@ pci_bridge_check_io(struct pci_dev *brid
 		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
 	}
 	if (io)
-		return IORESOURCE_IO;
-	printk(KERN_WARNING "PCI: bridge %s does not support I/O forwarding!\n",
-				bridge->name);
-	return 0;
+		ret |= IORESOURCE_IO;
+	pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
+	if (!pmem) {
+		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE,
+					       0xfff0fff0);
+		pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
+		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
+	}
+	if (pmem)
+		ret |= IORESOURCE_PREFETCH;
+	return ret;
 }
 
 static void __init
-pbus_assign_resources(struct pci_bus *bus, struct pbus_set_ranges_data *ranges)
+pbus_assign_pfmem_resources(struct pci_bus *bus,
+			    struct pbus_set_ranges_data *ranges)
 {
 	struct list_head *ln;
-	int found_vga = pbus_assign_resources_sorted(bus, ranges);
 
-	if (!ranges->found_vga && found_vga) {
-		struct pci_bus *b;
+	pbus_assign_resources_sorted(bus, ranges, 1);
 
-		ranges->found_vga = 1;
-		/* Propagate presence of the VGA to upstream bridges */
-		for (b = bus; b->parent; b = b->parent)
-			b->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
-	}
 	for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
 		struct pci_bus *b = pci_bus_b(ln);
 		struct pci_dev *bridge = b->self;
+		struct resource *parent;
+		unsigned long flags = pci_bridge_check_ranges(bridge);
 		int i;
 
 		/* Link bus resources to the bridge ones.  */
@@ -201,8 +231,49 @@ pbus_assign_resources(struct pci_bus *bu
 				&bridge->resource[PCI_BRIDGE_RESOURCES + i];
 			b->resource[i]->name = bus->name;
 		}
-		b->resource[0]->flags |= pci_bridge_check_io(bridge);
+		b->resource[0]->flags |= flags & IORESOURCE_IO;
+		b->resource[2]->flags |= flags & IORESOURCE_PREFETCH;
+
+		b->resource[2]->start = ranges->mem_start = ranges->mem_end;
+
+		/* For now, set prefetcheble memory limit of this bus
+		   same as limit of its parent bus. If the parent bus
+		   doesn't support prefetch, use non-prefetchable area. */
+		parent = bus->resource[2] ? bus->resource[2] : bus->resource[1];
+		b->resource[2]->end = parent->end;
+
+		pbus_assign_pfmem_resources(b, ranges);
+
+		b->resource[2]->end = ranges->mem_end - 1;
+
+		/* Add this to the resource tree. */
+		if (b->resource[2]->end > b->resource[2]->start &&
+		    request_resource(parent, b->resource[2]) < 0)
+			printk(KERN_ERR "PCI: failed to request PREF MEM "
+					"for bus %d\n", b->number);
+	}
+}
+
+static void __init
+pbus_assign_iomem_resources(struct pci_bus *bus,
+			    struct pbus_set_ranges_data *ranges)
+{
+	struct list_head *ln;
+	int found_vga = pbus_assign_resources_sorted(bus, ranges, 0);
+
+	if (!ranges->found_vga && found_vga) {
+		struct pci_bus *b;
+
+		ranges->found_vga = 1;
+		/* Propagate presence of the VGA to upstream bridges */
+		for (b = bus; b->parent; b = b->parent)
+			b->bridge_ctl |= PCI_BRIDGE_CTL_VGA;
+	}
+	for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
+		struct pci_bus *b = pci_bus_b(ln);
+
 		b->resource[1]->flags |= IORESOURCE_MEM;
+
 		b->resource[0]->start = ranges->io_start = ranges->io_end;
 		b->resource[1]->start = ranges->mem_start = ranges->mem_end;
 
@@ -211,7 +282,7 @@ pbus_assign_resources(struct pci_bus *bu
 		b->resource[0]->end = bus->resource[0]->end;
 		b->resource[1]->end = bus->resource[1]->end;
 
-		pbus_assign_resources(b, ranges);
+		pbus_assign_iomem_resources(b, ranges);
 
 		/* PCI-to-PCI Bridge Architecture Specification rev. 1.1 (1998)
 		   requires that if there is no I/O ports or memory behind the
@@ -244,12 +315,24 @@ pci_assign_unassigned_resources(void)
 
 	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next) {
 		struct pci_bus *b = pci_bus_b(ln);
+		struct resource *pfmem = b->resource[2];
+		unsigned long memstart;
+
+		memstart = b->resource[1]->start + PCIBIOS_MIN_MEM;
+
+		/* First, allocate prefetchable memory resources.
+		   If the root bus doesn't have prefetching region,
+		   use regular PCI memory area. */
+		ranges.mem_start = pfmem ? pfmem->start : memstart;
+		ranges.mem_end = ranges.mem_start;
+		pbus_assign_pfmem_resources(b, &ranges);
 
 		ranges.io_start = b->resource[0]->start + PCIBIOS_MIN_IO;
-		ranges.mem_start = b->resource[1]->start + PCIBIOS_MIN_MEM;
 		ranges.io_end = ranges.io_start;
-		ranges.mem_end = ranges.mem_start;
 		ranges.found_vga = 0;
-		pbus_assign_resources(b, &ranges);
+		if (pfmem)
+			ranges.mem_end = memstart;
+		ranges.mem_start = ranges.mem_end;
+		pbus_assign_iomem_resources(b, &ranges);
 	}
 }
