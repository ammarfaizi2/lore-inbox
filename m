Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263657AbTCVQro>; Sat, 22 Mar 2003 11:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263667AbTCVQro>; Sat, 22 Mar 2003 11:47:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40968 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263657AbTCVQpT>; Sat, 22 Mar 2003 11:45:19 -0500
Date: Sat, 22 Mar 2003 16:56:20 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PCI patches (2/3)
Message-ID: <20030322165620.F8712@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030322165525.D8712@flint.arm.linux.org.uk> <20030322165556.E8712@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030322165556.E8712@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sat, Mar 22, 2003 at 04:55:56PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1131  -> 1.1132 
#	drivers/pci/setup-bus.c	1.16    -> 1.17   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/22	ink@ru.rmk.(none)	1.1132
# [PCI] Make setup-bus.c aware of cardbus bridges.
# 
# Comments from rmk:
# 
# Make setup-bus.c properly aware of cardbus bridges.  We treat the
# bus behind a cardbus bridge more or less like any other bus, except
# we don't explicitly descend below.  We do, however, explicitly
# reserve IO and memory space as we have done in the past.  Memory
# space is doubed to 32MB as a measure to allow the Mobility
# cardbus-pci stuff to work.  The amount of space reserved is now
# specified by a couple of #defines at the top of the file.
# 
# This allows pci_bus_assign_resources() and pci_bus_size_bridges()
# to be called for both root buses as well as cardbus secondary buses.
# 
# Comments from Ivan follows:
# 
# This patch combines your(rmk) cardbus changes (formerly pci-11)
# and my "arbitrary resource layout" stuff. This + current bk works
# on nautilus.
# 
# Most interesting feature: this can be used on partially
# allocated PCI tree. For instance, i386 PCI code has always been
# absolutely helpless wrt incorrectly initialized p2p bridges.
# Now it can just call pci_assign_unassigned_resources() in the
# end of PCI init and it would fix following problems:
# - completely uninitialized bridge windows (with base and limit 0);
# - erroneously "closed" windows;
# - windows overlapping with something else.
# --------------------------------------------
#
diff -Nru a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c	Sat Mar 22 16:53:12 2003
+++ b/drivers/pci/setup-bus.c	Sat Mar 22 16:53:12 2003
@@ -36,6 +36,13 @@
 
 #define ROUND_UP(x, a)		(((x) + (a) - 1) & ~((a) - 1))
 
+/*
+ * FIXME: IO should be max 256 bytes.  However, since we may
+ * have a P2P bridge below a cardbus bridge, we need 4K.
+ */
+#define CARDBUS_IO_SIZE		(4096)
+#define CARDBUS_MEM_SIZE	(32*1024*1024)
+
 static int __devinit
 pbus_assign_resources_sorted(struct pci_bus *bus)
 {
@@ -67,12 +74,67 @@
 	return found_vga;
 }
 
+static void __devinit
+pci_setup_cardbus(struct pci_bus *bus)
+{
+	struct pci_dev *bridge = bus->self;
+	struct pci_bus_region region;
+
+	printk("PCI: Bus %d, cardbus bridge: %s\n",
+		bus->number, bridge->slot_name);
+
+	pcibios_resource_to_bus(bridge, &region, bus->resource[0]);
+	if (bus->resource[0]->flags & IORESOURCE_IO) {
+		/*
+		 * The IO resource is allocated a range twice as large as it
+		 * would normally need.  This allows us to set both IO regs.
+		 */
+		printk("  IO window: %08lx-%08lx\n",
+			region.start, region.end);
+		pci_write_config_dword(bridge, PCI_CB_IO_BASE_0,
+					region.start);
+		pci_write_config_dword(bridge, PCI_CB_IO_LIMIT_0,
+					region.end);
+	}
+
+	pcibios_resource_to_bus(bridge, &region, bus->resource[1]);
+	if (bus->resource[1]->flags & IORESOURCE_IO) {
+		printk("  IO window: %08lx-%08lx\n",
+			region.start, region.end);
+		pci_write_config_dword(bridge, PCI_CB_IO_BASE_1,
+					region.start);
+		pci_write_config_dword(bridge, PCI_CB_IO_LIMIT_1,
+					region.end);
+	}
+
+	pcibios_resource_to_bus(bridge, &region, bus->resource[2]);
+	if (bus->resource[2]->flags & IORESOURCE_MEM) {
+		printk("  PREFETCH window: %08lx-%08lx\n",
+			region.start, region.end);
+		pci_write_config_dword(bridge, PCI_CB_MEMORY_BASE_0,
+					region.start);
+		pci_write_config_dword(bridge, PCI_CB_MEMORY_LIMIT_0,
+					region.end);
+	}
+
+	pcibios_resource_to_bus(bridge, &region, bus->resource[3]);
+	if (bus->resource[3]->flags & IORESOURCE_MEM) {
+		printk("  MEM window: %08lx-%08lx\n",
+			region.start, region.end);
+		pci_write_config_dword(bridge, PCI_CB_MEMORY_BASE_1,
+					region.start);
+		pci_write_config_dword(bridge, PCI_CB_MEMORY_LIMIT_1,
+					region.end);
+	}
+}
+
 /* Initialize bridges with base/limit values we have collected.
    PCI-to-PCI Bridge Architecture Specification rev. 1.1 (1998)
    requires that if there is no I/O ports or memory behind the
    bridge, corresponding range must be turned off by writing base
    value greater than limit to the bridge's base/limit registers.  */
-static void __devinit pci_setup_bridge(struct pci_bus *bus)
+static void __devinit
+pci_setup_bridge(struct pci_bus *bus)
 {
 	struct pci_dev *bridge = bus->self;
 	struct pci_bus_region region;
@@ -154,9 +216,6 @@
 	struct pci_dev *bridge = bus->self;
 	struct resource *b_res;
 
-	if (!bridge || (bridge->class >> 8) != PCI_CLASS_BRIDGE_PCI)
-		return;
-
 	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
 	b_res[1].flags |= IORESOURCE_MEM;
 
@@ -184,6 +243,26 @@
 		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
 }
 
+/* Helper function for sizing routines: find first available
+   bus resource of a given type. Note: we intentionally skip
+   the bus resources which have already been assigned (that is,
+   have non-NULL parent resource). */
+static struct resource * __devinit
+find_free_bus_resource(struct pci_bus *bus, unsigned long type)
+{
+	int i;
+	struct resource *r;
+	unsigned long type_mask = IORESOURCE_IO | IORESOURCE_MEM |
+				  IORESOURCE_PREFETCH;
+
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
+		r = bus->resource[i];
+		if (r && (r->flags & type_mask) == type && !r->parent)
+			return r;
+	}
+	return NULL;
+}
+
 /* Sizing the IO windows of the PCI-PCI bridge is trivial,
    since these windows have 4K granularity and the IO ranges
    of non-bridge PCI devices are limited to 256 bytes.
@@ -192,15 +271,15 @@
 pbus_size_io(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
-	struct resource *b_res = bus->resource[0];
+	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
 	unsigned long size = 0, size1 = 0;
 
-	if (!(b_res->flags & IORESOURCE_IO))
-		return;
+	if (!b_res)
+ 		return;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		int i;
-		
+
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 			struct resource *r = &dev->resource[i];
 			unsigned long r_size;
@@ -215,9 +294,6 @@
 			else
 				size1 += r_size;
 		}
-		/* ??? Reserve some resources for CardBus. */
-		if ((dev->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS)
-			size1 += 4*1024;
 	}
 /* To be fixed in 2.5: we should have sort of HAVE_ISA
    flag in the struct pci_bus. */
@@ -236,15 +312,17 @@
 
 /* Calculate the size of the bus and minimal alignment which
    guarantees that all child resources fit in this size. */
-static void __devinit
+static int __devinit
 pbus_size_mem(struct pci_bus *bus, unsigned long mask, unsigned long type)
 {
 	struct pci_dev *dev;
 	unsigned long min_align, align, size;
 	unsigned long aligns[12];	/* Alignments from 1Mb to 2Gb */
 	int order, max_order;
-	struct resource *b_res = (type & IORESOURCE_PREFETCH) ?
-				 bus->resource[2] : bus->resource[1];
+	struct resource *b_res = find_free_bus_resource(bus, type);
+
+	if (!b_res)
+		return 0;
 
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
@@ -280,11 +358,6 @@
 			if (order > max_order)
 				max_order = order;
 		}
-		/* ??? Reserve some resources for CardBus. */
-		if ((dev->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS) {
-			size += 1UL << 24;		/* 16 Mb */
-			aligns[24 - 20] += 1UL << 24;
-		}
 	}
 
 	align = 0;
@@ -301,38 +374,111 @@
 	size = ROUND_UP(size, min_align);
 	if (!size) {
 		b_res->flags = 0;
-		return;
+		return 1;
 	}
 	b_res->start = min_align;
 	b_res->end = size + min_align - 1;
+	return 1;
+}
+
+static void __devinit
+pci_bus_size_cardbus(struct pci_bus *bus)
+{
+	struct pci_dev *bridge = bus->self;
+	struct resource *b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
+	u16 ctrl;
+
+	/*
+	 * Reserve some resources for CardBus.  We reserve
+	 * a fixed amount of bus space for CardBus bridges.
+	 */
+	b_res[0].start = CARDBUS_IO_SIZE;
+	b_res[0].end = b_res[0].start + CARDBUS_IO_SIZE - 1;
+	b_res[0].flags |= IORESOURCE_IO;
+
+	b_res[1].start = CARDBUS_IO_SIZE;
+	b_res[1].end = b_res[1].start + CARDBUS_IO_SIZE - 1;
+	b_res[1].flags |= IORESOURCE_IO;
+
+	/*
+	 * Check whether prefetchable memory is supported
+	 * by this bridge.
+	 */
+	pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
+	if (!(ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0)) {
+		ctrl |= PCI_CB_BRIDGE_CTL_PREFETCH_MEM0;
+		pci_write_config_word(bridge, PCI_CB_BRIDGE_CONTROL, ctrl);
+		pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
+	}
+
+	/*
+	 * If we have prefetchable memory support, allocate
+	 * two regions.  Otherwise, allocate one region of
+	 * twice the size.
+	 */
+	if (ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0) {
+		b_res[2].start = CARDBUS_MEM_SIZE;
+		b_res[2].end = b_res[2].start + CARDBUS_MEM_SIZE - 1;
+		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
+
+		b_res[3].start = CARDBUS_MEM_SIZE;
+		b_res[3].end = b_res[3].start + CARDBUS_MEM_SIZE - 1;
+		b_res[3].flags |= IORESOURCE_MEM;
+	} else {
+		b_res[3].start = CARDBUS_MEM_SIZE * 2;
+		b_res[3].end = b_res[3].start + CARDBUS_MEM_SIZE * 2 - 1;
+		b_res[3].flags |= IORESOURCE_MEM;
+	}
 }
 
 void __devinit
 pci_bus_size_bridges(struct pci_bus *bus)
 {
-	struct pci_bus *b;
-	unsigned long mask, type;
+	struct pci_dev *dev;
+	unsigned long mask, prefmask;
 
-	list_for_each_entry(b, &bus->children, node) {
-		pci_bus_size_bridges(b);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		struct pci_bus *b = dev->subordinate;
+		if (!b)
+			continue;
+
+		switch (dev->class >> 8) {
+		case PCI_CLASS_BRIDGE_CARDBUS:
+			pci_bus_size_cardbus(b);
+			break;
+
+		case PCI_CLASS_BRIDGE_PCI:
+		default:
+			pci_bus_size_bridges(b);
+			break;
+		}
 	}
 
 	/* The root bus? */
 	if (!bus->self)
 		return;
 
-	pci_bridge_check_ranges(bus);
-
-	pbus_size_io(bus);
-
-	mask = type = IORESOURCE_MEM;
-	/* If the bridge supports prefetchable range, size it separately. */
-	if (bus->resource[2] &&
-	    bus->resource[2]->flags & IORESOURCE_PREFETCH) {
-		pbus_size_mem(bus, IORESOURCE_PREFETCH, IORESOURCE_PREFETCH);
-		mask |= IORESOURCE_PREFETCH;	/* Size non-prefetch only. */
+	switch (bus->self->class >> 8) {
+	case PCI_CLASS_BRIDGE_CARDBUS:
+		/* don't size cardbuses yet. */
+		break;
+
+	case PCI_CLASS_BRIDGE_PCI:
+		pci_bridge_check_ranges(bus);
+	default:
+		pbus_size_io(bus);
+		/* If the bridge supports prefetchable range, size it
+		   separately. If it doesn't, or its prefetchable window
+		   has already been allocated by arch code, try
+		   non-prefetchable range for both types of PCI memory
+		   resources. */
+		mask = IORESOURCE_MEM;
+		prefmask = IORESOURCE_MEM | IORESOURCE_PREFETCH;
+		if (pbus_size_mem(bus, prefmask, prefmask))
+			mask = prefmask; /* Success, size non-prefetch only. */
+		pbus_size_mem(bus, mask, IORESOURCE_MEM);
+		break;
 	}
-	pbus_size_mem(bus, mask, type);
 }
 EXPORT_SYMBOL(pci_bus_size_bridges);
 
@@ -351,9 +497,24 @@
 	}
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		b = dev->subordinate;
-		if (b) {
-			pci_bus_assign_resources(b);
+		if (!b)
+			continue;
+
+		pci_bus_assign_resources(b);
+
+		switch (dev->class >> 8) {
+		case PCI_CLASS_BRIDGE_PCI:
 			pci_setup_bridge(b);
+			break;
+
+		case PCI_CLASS_BRIDGE_CARDBUS:
+			pci_setup_cardbus(b);
+			break;
+
+		default:
+			printk(KERN_INFO "PCI: not setting up bridge %s "
+			       "for bus %d\n", dev->slot_name, b->number);
+			break;
 		}
 	}
 }

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

