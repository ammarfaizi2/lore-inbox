Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315878AbSEGPvp>; Tue, 7 May 2002 11:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315884AbSEGPvo>; Tue, 7 May 2002 11:51:44 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:1796 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S315878AbSEGPvf>; Tue, 7 May 2002 11:51:35 -0400
Date: Tue, 7 May 2002 19:51:28 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.14: New PCI allocation code (alpha, arm, parisc) [2/2]
Message-ID: <20020507195128.B660@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of changes:
- alpha, arm: code related to PCI-PCI bridges from pcibios_fixup_bus()
  removed - now it's generic;
- pdev_sort_resource: sort resources all together, no matter IO or memory;
- pbus_assign_resources_sorted: ditto;
- pci_bridge_check_ranges, pci_setup_bridge: changed for prefetch support;
- pbus_size_io, pbus_size_mem: core stuff; tested with randomly generated
  sets of resources;
- pbus_size_bridges: pass #2 (pass #1 is PCI probing, common for all archs);
- pbus_assign_resources: pass #3.

Ivan.

PS. These patches are completely independent to PCI reorg suggested
by Greg KH. The only conflict would be in arch/i386/kernel/pci-i386.c
(pcibios_align_resource) due to changed location of this file.

--- 2.5.14/arch/alpha/kernel/pci.c	Sun May  5 18:40:21 2002
+++ linux/arch/alpha/kernel/pci.c	Sun May  5 18:40:35 2002
@@ -246,25 +246,6 @@ pcibios_fixup_bus(struct pci_bus *bus)
 		/* Root bus */
 		bus->resource[0] = hose->io_space;
 		bus->resource[1] = hose->mem_space;
-	} else {
-		/* This is a bridge. Do not care how it's initialized,
-		   just link its resources to the bus ones */
-		int i;
-
-		for(i=0; i<3; i++) {
-			bus->resource[i] =
-				&dev->resource[PCI_BRIDGE_RESOURCES+i];
-			bus->resource[i]->name = bus->name;
-		}
-		bus->resource[0]->flags |= pci_bridge_check_io(dev);
-		bus->resource[1]->flags |= IORESOURCE_MEM;
-		/* For now, propogate hose limits to the bus;
-		   we'll adjust them later. */
-		bus->resource[0]->end = hose->io_space->end;
-		bus->resource[1]->end = hose->mem_space->end;
-		/* Turn off downstream PF memory address range by default */
-		bus->resource[2]->start = 1024*1024;
-		bus->resource[2]->end = bus->resource[2]->start - 1;
 	}
 
 	for (ln = bus->devices.next; ln != &bus->devices; ln = ln->next) {
@@ -349,6 +330,10 @@ pcibios_fixup_pbus_ranges(struct pci_bus
 	ranges->io_end -= hose->io_space->start;
 	ranges->mem_start -= hose->mem_space->start;
 	ranges->mem_end -= hose->mem_space->start;
+/* FIXME: On older alphas we could use dense memory space
+	  to access prefetchable resources. */
+	ranges->prefetch_start -= hose->mem_space->start;
+	ranges->prefetch_end -= hose->mem_space->start;
 }
 
 int
--- 2.5.14/arch/arm/kernel/bios32.c	Sun May  5 18:40:21 2002
+++ linux/arch/arm/kernel/bios32.c	Sun May  5 18:40:35 2002
@@ -346,20 +346,7 @@ pbus_assign_bus_resources(struct pci_bus
 	struct pci_dev *dev = bus->self;
 	int i;
 
-	if (dev) {
-		for (i = 0; i < 3; i++) {
-			if (root->resource[i]) {
-				bus->resource[i] = &dev->resource[PCI_BRIDGE_RESOURCES+i];
-				bus->resource[i]->end  = root->resource[i]->end;
-				bus->resource[i]->name = bus->name;
-			}
-		}
-		bus->resource[0]->flags |= pci_bridge_check_io(dev);
-		bus->resource[1]->flags |= IORESOURCE_MEM;
-
-		if (bus->resource[2] && root->resource[2])
-			bus->resource[2]->flags = root->resource[2]->flags;
-	} else {
+	if (!dev) {
 		/*
 		 * Assign root bus resources.
 		 */
--- 2.5.14/include/linux/pci.h	Sun May  5 18:40:21 2002
+++ linux/include/linux/pci.h	Mon May  6 13:46:28 2002
@@ -464,9 +464,9 @@ struct pci_ops {
 
 struct pbus_set_ranges_data
 {
-	int found_vga;
 	unsigned long io_start, io_end;
 	unsigned long mem_start, mem_end;
+	unsigned long prefetch_start, prefetch_end;
 };
 
 struct pci_device_id {
@@ -583,8 +583,7 @@ int pci_enable_wake(struct pci_dev *dev,
 int pci_claim_resource(struct pci_dev *, int);
 void pci_assign_unassigned_resources(void);
 void pdev_enable_device(struct pci_dev *);
-void pdev_sort_resources(struct pci_dev *, struct resource_list *, u32);
-unsigned long pci_bridge_check_io(struct pci_dev *);
+void pdev_sort_resources(struct pci_dev *, struct resource_list *);
 void pci_fixup_irqs(u8 (*)(struct pci_dev *, u8 *),
 		    int (*)(struct pci_dev *, u8, u8));
 #define HAVE_PCI_REQ_REGIONS
--- 2.5.14/drivers/pci/setup-bus.c	Fri May  3 04:22:51 2002
+++ linux/drivers/pci/setup-bus.c	Mon May  6 13:56:42 2002
@@ -11,7 +11,10 @@
 
 /*
  * Nov 2000, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
- *	     PCI-PCI bridges cleanup, sorted resource allocation
+ *	     PCI-PCI bridges cleanup, sorted resource allocation.
+ * Feb 2002, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
+ *	     Converted to allocation in 3 passes, which gives
+ *	     tighter packing. Prefetchable range support.
  */
 
 #include <linux/init.h>
@@ -23,7 +26,7 @@
 #include <linux/slab.h>
 
 
-#define DEBUG_CONFIG 0
+#define DEBUG_CONFIG 1
 #if DEBUG_CONFIG
 # define DBGC(args)     printk args
 #else
@@ -33,16 +36,14 @@
 #define ROUND_UP(x, a)		(((x) + (a) - 1) & ~((a) - 1))
 
 static int __init
-pbus_assign_resources_sorted(struct pci_bus *bus,
-			     struct pbus_set_ranges_data *ranges)
+pbus_assign_resources_sorted(struct pci_bus *bus)
 {
 	struct list_head *ln;
 	struct resource *res;
-	struct resource_list head_io, head_mem, *list, *tmp;
-	unsigned long io_reserved = 0, mem_reserved = 0;
+	struct resource_list head, *list, *tmp;
 	int idx, found_vga = 0;
 
-	head_io.next = head_mem.next = NULL;
+	head.next = NULL;
 	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
 		struct pci_dev *dev = pci_dev_b(ln);
 		u16 class = dev->class >> 8;
@@ -64,63 +65,26 @@ pbus_assign_resources_sorted(struct pci_
 			pci_write_config_word(dev, PCI_COMMAND, cmd);
 		}
 
-		/* Reserve some resources for CardBus.
-		   Are these values reasonable? */
-		if (class == PCI_CLASS_BRIDGE_CARDBUS) {
-			io_reserved += 8*1024;
-			mem_reserved += 32*1024*1024;
-			continue;
-		}
-
-		pdev_sort_resources(dev, &head_io, IORESOURCE_IO);
-		pdev_sort_resources(dev, &head_mem, IORESOURCE_MEM);
+		pdev_sort_resources(dev, &head);
 	}
 
-	for (list = head_io.next; list;) {
+	for (list = head.next; list;) {
 		res = list->res;
 		idx = res - &list->dev->resource[0];
-		if (pci_assign_resource(list->dev, idx) == 0
-		    && ranges->io_end < res->end)
-			ranges->io_end = res->end;
+		pci_assign_resource(list->dev, idx);
 		tmp = list;
 		list = list->next;
 		kfree(tmp);
 	}
-	for (list = head_mem.next; list;) {
-		res = list->res;
-		idx = res - &list->dev->resource[0];
-		if (pci_assign_resource(list->dev, idx) == 0
-		    && ranges->mem_end < res->end)
-			ranges->mem_end = res->end;
-		tmp = list;
-		list = list->next;
-		kfree(tmp);
-	}
-
-	ranges->io_end += io_reserved;
-	ranges->mem_end += mem_reserved;
-
-	/* PCI-to-PCI Bridge Architecture Specification rev. 1.1 (1998)
-	   requires that if there is no I/O ports or memory behind the
-	   bridge, corresponding range must be turned off by writing base
-	   value greater than limit to the bridge's base/limit registers.  */
-#if 1
-	/* But assuming that some hardware designed before 1998 might
-	   not support this (very unlikely - at least all DEC bridges
-	   are ok and I believe that was standard de-facto. -ink), we
-	   must allow for at least one unit.  */
-	if (ranges->io_end == ranges->io_start)
-		ranges->io_end += 1;
-	if (ranges->mem_end == ranges->mem_start)
-		ranges->mem_end += 1;
-#endif
-	ranges->io_end = ROUND_UP(ranges->io_end, 4*1024);
-	ranges->mem_end = ROUND_UP(ranges->mem_end, 1024*1024);
 
 	return found_vga;
 }
 
-/* Initialize bridges with base/limit values we have collected */
+/* Initialize bridges with base/limit values we have collected.
+   PCI-to-PCI Bridge Architecture Specification rev. 1.1 (1998)
+   requires that if there is no I/O ports or memory behind the
+   bridge, corresponding range must be turned off by writing base
+   value greater than limit to the bridge's base/limit registers.  */
 static void __init
 pci_setup_bridge(struct pci_bus *bus)
 {
@@ -130,120 +94,311 @@ pci_setup_bridge(struct pci_bus *bus)
 
 	if (!bridge || (bridge->class >> 8) != PCI_CLASS_BRIDGE_PCI)
 		return;
+
 	ranges.io_start = bus->resource[0]->start;
 	ranges.io_end = bus->resource[0]->end;
 	ranges.mem_start = bus->resource[1]->start;
 	ranges.mem_end = bus->resource[1]->end;
+	ranges.prefetch_start = bus->resource[2]->start;
+	ranges.prefetch_end = bus->resource[2]->end;
 	pcibios_fixup_pbus_ranges(bus, &ranges);
 
-	DBGC((KERN_ERR "PCI: Bus %d, bridge: %s\n", bus->number, bridge->name));
-	DBGC((KERN_ERR "  IO window: %04lx-%04lx\n", ranges.io_start, ranges.io_end));
-	DBGC((KERN_ERR "  MEM window: %08lx-%08lx\n", ranges.mem_start, ranges.mem_end));
+	DBGC((KERN_INFO "PCI: Bus %d, bridge: %s\n",
+			bus->number, bridge->name));
 
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
-	pci_read_config_dword(bridge, PCI_IO_BASE, &l);
-	l &= 0xffff0000;
-	l |= (ranges.io_start >> 8) & 0x00f0;
-	l |= ranges.io_end & 0xf000;
+	if (bus->resource[0]->flags & IORESOURCE_IO) {
+		pci_read_config_dword(bridge, PCI_IO_BASE, &l);
+		l &= 0xffff0000;
+		l |= (ranges.io_start >> 8) & 0x00f0;
+		l |= ranges.io_end & 0xf000;
+		/* Set up upper 16 bits of I/O base/limit. */
+		pci_write_config_word(bridge, PCI_IO_BASE_UPPER16,
+				      ranges.io_start >> 16);
+		pci_write_config_word(bridge, PCI_IO_LIMIT_UPPER16,
+				      ranges.io_end >> 16);
+		DBGC((KERN_INFO "  IO window: %04lx-%04lx\n",
+				ranges.io_start, ranges.io_end));
+	}
+	else {
+		/* Clear upper 16 bits of I/O base/limit. */
+		pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0);
+		l = 0x00f0;
+		DBGC((KERN_INFO "  IO window: disabled.\n"));
+	}
 	pci_write_config_dword(bridge, PCI_IO_BASE, l);
 
-	/* Clear upper 16 bits of I/O base/limit. */
-	pci_write_config_dword(bridge, PCI_IO_BASE_UPPER16, 0);
+	/* Set up the top and bottom of the PCI Memory segment
+	   for this bus. */
+	if (bus->resource[1]->flags & IORESOURCE_MEM) {
+		l = (ranges.mem_start >> 16) & 0xfff0;
+		l |= ranges.mem_end & 0xfff00000;
+		DBGC((KERN_INFO "  MEM window: %08lx-%08lx\n",
+				ranges.mem_start, ranges.mem_end));
+	}
+	else {
+		l = 0x0000fff0;
+		DBGC((KERN_INFO "  MEM window: disabled.\n"));
+	}
+	pci_write_config_dword(bridge, PCI_MEMORY_BASE, l);
 
 	/* Clear out the upper 32 bits of PREF base/limit. */
 	pci_write_config_dword(bridge, PCI_PREF_BASE_UPPER32, 0);
 	pci_write_config_dword(bridge, PCI_PREF_LIMIT_UPPER32, 0);
 
-	/* Set up the top and bottom of the PCI Memory segment
-	   for this bus. */
-	l = (ranges.mem_start >> 16) & 0xfff0;
-	l |= ranges.mem_end & 0xfff00000;
-	pci_write_config_dword(bridge, PCI_MEMORY_BASE, l);
-
 	/* Set up PREF base/limit. */
-	l = (bus->resource[2]->start >> 16) & 0xfff0;
-	l |= bus->resource[2]->end & 0xfff00000;
+	if (bus->resource[2]->flags & IORESOURCE_PREFETCH) {
+		l = (ranges.prefetch_start >> 16) & 0xfff0;
+		l |= ranges.prefetch_end & 0xfff00000;
+		DBGC((KERN_INFO "  PREFETCH window: %08lx-%08lx\n",
+				ranges.prefetch_start, ranges.prefetch_end));
+	}
+	else {
+		l = 0x0000fff0;
+		DBGC((KERN_INFO "  PREFETCH window: disabled.\n"));
+	}
 	pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);
 
 	/* Check if we have VGA behind the bridge.
-	   Enable ISA in either case. */
+	   Enable ISA in either case (FIXME!). */
 	l = (bus->resource[0]->flags & IORESOURCE_BUS_HAS_VGA) ? 0x0c : 0x04;
 	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, l);
 }
 
+/* Check whether the bridge supports optional I/O and
+   prefetchable memory ranges. If not, the respective
+   base/limit registers must be read-only and read as 0. */
 static void __init
-pbus_assign_resources(struct pci_bus *bus, struct pbus_set_ranges_data *ranges)
+pci_bridge_check_ranges(struct pci_bus *bus)
+{
+	u16 io;
+	u32 pmem;
+	struct pci_dev *bridge = bus->self;
+	struct resource *b_res;
+
+	if (!bridge || (bridge->class >> 8) != PCI_CLASS_BRIDGE_PCI)
+		return;
+
+	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
+	b_res[1].flags |= IORESOURCE_MEM;
+
+	pci_read_config_word(bridge, PCI_IO_BASE, &io);
+	if (!io) {
+		pci_write_config_word(bridge, PCI_IO_BASE, 0xf0f0);
+		pci_read_config_word(bridge, PCI_IO_BASE, &io);
+ 		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
+ 	}
+ 	if (io)
+		b_res[0].flags |= IORESOURCE_IO;
+	/*  DECchip 21050 pass 2 errata: the bridge may miss an address
+	    disconnect boundary by one PCI data phase.
+	    Workaround: do not use prefetching on this device. */
+	if (bridge->vendor == PCI_VENDOR_ID_DEC && bridge->device == 0x0001)
+		return;
+	pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
+	if (!pmem) {
+		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE,
+					       0xfff0fff0);
+		pci_read_config_dword(bridge, PCI_PREF_MEMORY_BASE, &pmem);
+		pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, 0x0);
+	}
+	if (pmem)
+		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
+}
+
+/* Sizing the IO windows of the PCI-PCI bridge is trivial,
+   since these windows have 4K granularity and the IO ranges
+   of non-bridge PCI devices are limited to 256 bytes.
+   We must be careful with the ISA aliasing though. */
+static void __init
+pbus_size_io(struct pci_bus *bus)
 {
 	struct list_head *ln;
-	int found_vga = pbus_assign_resources_sorted(bus, ranges);
+	struct resource *b_res = bus->resource[0];
+	unsigned long size = 0, size1 = 0;
 
-	if (!ranges->found_vga && found_vga) {
-		struct pci_bus *b;
+	if (!(b_res->flags & IORESOURCE_IO))
+		return;
 
-		ranges->found_vga = 1;
-		/* Propogate presence of the VGA to upstream bridges */
-		for (b = bus; b->parent; b = b->parent) {
-#if 0
-			/* ? Do we actually need to enable PF memory? */
-			b->resource[2]->start = 0;
+	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
+		struct pci_dev *dev = pci_dev_b(ln);
+		int i;
+		
+		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+			struct resource *r = &dev->resource[i];
+			unsigned long r_size;
+
+			if (!(r->flags & IORESOURCE_IO))
+				continue;
+			if (r->parent)
+				BUG();
+			r_size = r->end - r->start + 1;
+
+			if (r_size < 0x400)
+				/* Might be re-aligned for ISA */
+				size += r_size;
+			else
+				size1 += r_size;
+		}
+		/* ??? Reserve some resources for CardBus. */
+		if ((dev->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS)
+			size1 += 4*1024;
+	}
+/* To be fixed in 2.5: we should have sort of HAVE_ISA
+   flag in the struct pci_bus. */
+#if defined(CONFIG_ISA) || defined(CONFIG_EISA)
+	size = (size & 0xff) + ((size & ~0xffUL) << 2);
 #endif
-			b->resource[0]->flags |= IORESOURCE_BUS_HAS_VGA;
+	size = ROUND_UP(size + size1, 4096);
+	if (!size) {
+		b_res->flags = 0;
+		return;
+	}
+	/* Alignment of the IO window is always 4K */
+	b_res->start = 4096;
+	b_res->end = b_res->start + size - 1;
+}
+
+/* Calculate the size of the bus and minimal alignment which
+   guarantees that all child resources fit in this size. */
+static void __init
+pbus_size_mem(struct pci_bus *bus, unsigned long mask, unsigned long type)
+{
+	struct list_head *ln;
+	unsigned long min_align, align, size;
+	unsigned long aligns[12];	/* Alignments from 1Mb to 2Gb */
+	int order, max_order;
+	struct resource *b_res = (type & IORESOURCE_PREFETCH) ?
+				 bus->resource[2] : bus->resource[1];
+
+	memset(aligns, 0, sizeof(aligns));
+	max_order = 0;
+	size = 0;
+
+	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
+		struct pci_dev *dev = pci_dev_b(ln);
+		int i;
+		
+		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+			struct resource *r = &dev->resource[i];
+			unsigned long r_size;
+
+			if ((r->flags & mask) != type)
+				continue;
+			if (r->parent)
+				BUG();
+			r_size = r->end - r->start + 1;
+			/* For bridges size != alignment */
+			align = (i < PCI_BRIDGE_RESOURCES) ? r_size : r->start;
+			order = __ffs(align) - 20;
+			if (order > 11) {
+				printk(KERN_WARNING "PCI: region %s/%d "
+				       "too large: %lx-%lx\n",
+				       dev->slot_name, i, r->start, r->end);
+				r->flags = 0;
+				continue;
+			}
+			size += r_size;
+			if (order < 0)
+				order = 0;
+			/* Exclude ranges with size > align from
+			   calculation of the alignment. */
+			if (size == align)
+				aligns[order] += align;
+			if (order > max_order)
+				max_order = order;
+		}
+		/* ??? Reserve some resources for CardBus. */
+		if ((dev->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS) {
+			size += 1UL << 24;		/* 16 Mb */
+			aligns[24 - 20] += 1UL << 24;
 		}
 	}
-	for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
-		struct pci_bus *b = pci_bus_b(ln);
 
-		b->resource[0]->start = ranges->io_start = ranges->io_end;
-		b->resource[1]->start = ranges->mem_start = ranges->mem_end;
+	align = 0;
+	min_align = 0;
+	for (order = 0; order <= max_order; order++) {
+		unsigned long align1 = 1UL << (order + 20);
+
+		if (!align)
+			min_align = align1;
+		else if (ROUND_UP(align + min_align, min_align) < align1)
+			min_align = align1 >> 1;
+		align += aligns[order];
+	}
+	size = ROUND_UP(size, min_align);
+	if (!size) {
+		b_res->flags = 0;
+		return;
+	}
+	b_res->start = min_align;
+	b_res->end = size + min_align - 1;
+}
+
+void __init
+pbus_size_bridges(struct pci_bus *bus)
+{
+	struct list_head *ln;
+	unsigned long mask, type;
 
-		pbus_assign_resources(b, ranges);
+	for (ln=bus->children.next; ln != &bus->children; ln=ln->next)
+		pbus_size_bridges(pci_bus_b(ln));
 
-		b->resource[0]->end = ranges->io_end - 1;
-		b->resource[1]->end = ranges->mem_end - 1;
+	/* The root bus? */
+	if (!bus->self)
+		return;
 
-		pci_setup_bridge(b);
+	pci_bridge_check_ranges(bus);
+
+	pbus_size_io(bus);
+
+	mask = type = IORESOURCE_MEM;
+	/* If the bridge supports prefetchable range, size it separately. */
+	if (bus->resource[2] &&
+	    bus->resource[2]->flags & IORESOURCE_PREFETCH) {
+		pbus_size_mem(bus, IORESOURCE_PREFETCH, IORESOURCE_PREFETCH);
+		mask |= IORESOURCE_PREFETCH;	/* Size non-prefetch only. */
 	}
+	pbus_size_mem(bus, mask, type);
 }
 
 void __init
-pci_assign_unassigned_resources(void)
+pbus_assign_resources(struct pci_bus *bus)
 {
-	struct pbus_set_ranges_data ranges;
 	struct list_head *ln;
-	struct pci_dev *dev;
+	int found_vga = pbus_assign_resources_sorted(bus);
 
-	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next) {
-		struct pci_bus *b = pci_bus_b(ln);
+	if (found_vga) {
+		struct pci_bus *b;
 
-		ranges.io_start = b->resource[0]->start + PCIBIOS_MIN_IO;
-		ranges.mem_start = b->resource[1]->start + PCIBIOS_MIN_MEM;
-		ranges.io_end = ranges.io_start;
-		ranges.mem_end = ranges.mem_start;
-		ranges.found_vga = 0;
-		pbus_assign_resources(b, &ranges);
+		/* Propagate presence of the VGA to upstream bridges */
+		for (b = bus; b->parent; b = b->parent) {
+			b->resource[0]->flags |= IORESOURCE_BUS_HAS_VGA;
+		}
 	}
-	pci_for_each_dev(dev) {
-		pdev_enable_device(dev);
+	for (ln=bus->children.next; ln != &bus->children; ln=ln->next) {
+		struct pci_bus *b = pci_bus_b(ln);
+
+		pbus_assign_resources(b);
+		pci_setup_bridge(b);
 	}
 }
 
-/* Check whether the bridge supports I/O forwarding.
-   If not, its I/O base/limit register must be
-   read-only and read as 0. */
-unsigned long __init
-pci_bridge_check_io(struct pci_dev *bridge)
+void __init
+pci_assign_unassigned_resources(void)
 {
-	u16 io;
+	struct list_head *ln;
+	struct pci_dev *dev;
 
-	pci_read_config_word(bridge, PCI_IO_BASE, &io);
-	if (!io) {
-		pci_write_config_word(bridge, PCI_IO_BASE, 0xf0f0);
-		pci_read_config_word(bridge, PCI_IO_BASE, &io);
-		pci_write_config_word(bridge, PCI_IO_BASE, 0x0);
+	/* Depth first, calculate sizes and alignments of all
+	   subordinate buses. */
+	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next)
+		pbus_size_bridges(pci_bus_b(ln));
+	/* Depth last, allocate resources and update the hardware. */
+	for(ln=pci_root_buses.next; ln != &pci_root_buses; ln=ln->next)
+		pbus_assign_resources(pci_bus_b(ln));
+
+	pci_for_each_dev(dev) {
+		pdev_enable_device(dev);
 	}
-	if (io)
-		return IORESOURCE_IO;
-	printk(KERN_WARNING "PCI: bridge %s does not support I/O forwarding!\n",
-				bridge->name);
-	return 0;
 }
--- 2.5.14/drivers/pci/setup-res.c	Sun May  5 18:40:21 2002
+++ linux/drivers/pci/setup-res.c	Sun May  5 18:40:35 2002
@@ -136,47 +136,45 @@ pci_assign_resource(struct pci_dev *dev,
 	return 0;
 }
 
-/* Sort resources of a given type by alignment */
+/* Sort resources by alignment */
 void __init
-pdev_sort_resources(struct pci_dev *dev,
-		    struct resource_list *head, u32 type_mask)
+pdev_sort_resources(struct pci_dev *dev, struct resource_list *head)
 {
 	int i;
 
 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 		struct resource *r;
 		struct resource_list *list, *tmp;
-		unsigned long r_size;
-
-		/* PCI-PCI bridges may have I/O ports or
-		   memory on the primary bus */
-		if (dev->class >> 8 == PCI_CLASS_BRIDGE_PCI &&
-						i >= PCI_BRIDGE_RESOURCES)
-			continue;
+		unsigned long r_align;
 
 		r = &dev->resource[i];
-		r_size = r->end - r->start;
+		r_align = r->end - r->start;
 		
-		if (!(r->flags & type_mask) || r->parent)
+		if (!(r->flags) || r->parent)
 			continue;
-		if (!r_size) {
+		if (!r_align) {
 			printk(KERN_WARNING "PCI: Ignore bogus resource %d "
-					 "[%lx:%lx] of %s\n",
-					  i, r->start, r->end, dev->name);
+					    "[%lx:%lx] of %s\n",
+					    i, r->start, r->end, dev->name);
 			continue;
 		}
+		r_align = (i < PCI_BRIDGE_RESOURCES) ? r_align + 1 : r->start;
 		for (list = head; ; list = list->next) {
-			unsigned long size = 0;
+			unsigned long align = 0;
 			struct resource_list *ln = list->next;
+			int idx;
 
-			if (ln)
-				size = ln->res->end - ln->res->start;
-			if (r_size > size) {
+			if (ln) {
+				idx = ln->res - &ln->dev->resource[0];
+				align = (idx < PCI_BRIDGE_RESOURCES) ?
+					ln->res->end - ln->res->start + 1 :
+					ln->res->start;
+			}
+			if (r_align > align) {
 				tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
-				if (!tmp) {
-					printk(KERN_ERR "pdev_sort_resources(): kmalloc() failed!\n");
-					continue;
-				}
+				if (!tmp)
+					panic("pdev_sort_resources(): "
+					      "kmalloc() failed!\n");
 				tmp->next = ln;
 				tmp->res = r;
 				tmp->dev = dev;
