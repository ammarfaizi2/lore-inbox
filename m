Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbTCOKDH>; Sat, 15 Mar 2003 05:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261378AbTCOKDG>; Sat, 15 Mar 2003 05:03:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12557 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261374AbTCOKCz>; Sat, 15 Mar 2003 05:02:55 -0500
Date: Sat, 15 Mar 2003 10:13:41 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm7
Message-ID: <20030315101341.A1297@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030315011758.7098b006.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030315011758.7098b006.akpm@digeo.com>; from akpm@digeo.com on Sat, Mar 15, 2003 at 01:17:58AM -0800
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +pci-6.patch
> +pci-7.patch
> +pci-8.patch
> +pci-9.patch
> +pci-10.patch
> +pci-11.patch
> +pci-12.patch
> +pci-13.patch
> +pci-14.patch
> +pci-15.patch
> 
>  Some of Russell King's PCI patches.

Following comments from Ivan, the following patches changed:

pci-9

  only enable ROM resources if res->flags has PCI_ROM_ADDRESS_ENABLE set.

pci-10

  don't use PCI_BUS_NUM_RESOURCES here - PPC machines can (in theory) have
  more than 4 primary bus resources.

pci-11

  breaks Alpha Nautilus host bridge sizing - patch dropped from patch set.

For those trying the above out, please apply the following patch on top of
-mm7:

diff -ur orig/drivers/pci/setup-res.c linux/drivers/pci/setup-res.c
--- orig/drivers/pci/setup-res.c	Sat Mar 15 09:54:19 2003
+++ linux/drivers/pci/setup-res.c	Sat Mar 15 09:55:38 2003
@@ -55,8 +55,7 @@
 	if (resno < 6) {
 		reg = PCI_BASE_ADDRESS_0 + 4 * resno;
 	} else if (resno == PCI_ROM_RESOURCE) {
-		res->flags |= PCI_ROM_ADDRESS_ENABLE;
-		new |= PCI_ROM_ADDRESS_ENABLE;
+		new |= res->flags & PCI_ROM_ADDRESS_ENABLE;
 		reg = dev->rom_base_reg;
 	} else {
 		/* Hmm, non-standard resource. */
diff -ur orig/drivers/pci/probe.c linux/drivers/pci/probe.c
--- orig/drivers/pci/probe.c	Sat Mar 15 09:59:15 2003
+++ linux/drivers/pci/probe.c	Sat Mar 15 09:58:47 2003
@@ -256,7 +256,7 @@
 		child->subordinate = 0xff;
 
 		/* Set up default resource pointers and names.. */
-		for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
+		for (i = 0; i < 4; i++) {
 			child->resource[i] = &bridge->resource[PCI_BRIDGE_RESOURCES+i];
 			child->resource[i]->name = child->name;
 		}
diff -ur orig/drivers/pci/setup-bus.c linux/drivers/pci/setup-bus.c
--- orig/drivers/pci/setup-bus.c	Sat Mar 15 10:01:05 2003
+++ linux/drivers/pci/setup-bus.c	Sat Mar 15 09:58:44 2003
@@ -36,13 +36,6 @@
 
 #define ROUND_UP(x, a)		(((x) + (a) - 1) & ~((a) - 1))
 
-/*
- * FIXME: IO should be max 256 bytes.  However, since we may
- * have a P2P bridge below a cardbus bridge, we need 4K.
- */
-#define CARDBUS_IO_SIZE		(4096)
-#define CARDBUS_MEM_SIZE	(32*1024*1024)
-
 static int __devinit
 pbus_assign_resources_sorted(struct pci_bus *bus)
 {
@@ -74,59 +67,6 @@
 	return found_vga;
 }
 
-static void __devinit pci_setup_cardbus(struct pci_bus *bus)
-{
-	struct pci_dev *bridge = bus->self;
-	struct pci_bus_region region;
-
-	printk("PCI: Bus %d, cardbus bridge: %s\n",
-		bus->number, bridge->slot_name);
-
-	pcibios_resource_to_bus(bridge, &region, bus->resource[0]);
-	if (bus->resource[0]->flags & IORESOURCE_IO) {
-		/*
-		 * The IO resource is allocated a range twice as large as it
-		 * would normally need.  This allows us to set both IO regs.
-		 */
-		printk("  IO window: %08lx-%08lx\n",
-			region.start, region.end);
-		pci_write_config_dword(bridge, PCI_CB_IO_BASE_0,
-					region.start);
-		pci_write_config_dword(bridge, PCI_CB_IO_LIMIT_0,
-					region.end);
-	}
-
-	pcibios_resource_to_bus(bridge, &region, bus->resource[1]);
-	if (bus->resource[1]->flags & IORESOURCE_IO) {
-		printk("  IO window: %08lx-%08lx\n",
-			region.start, region.end);
-		pci_write_config_dword(bridge, PCI_CB_IO_BASE_1,
-					region.start);
-		pci_write_config_dword(bridge, PCI_CB_IO_LIMIT_1,
-					region.end);
-	}
-
-	pcibios_resource_to_bus(bridge, &region, bus->resource[2]);
-	if (bus->resource[2]->flags & IORESOURCE_MEM) {
-		printk("  PREFETCH window: %08lx-%08lx\n",
-			region.start, region.end);
-		pci_write_config_dword(bridge, PCI_CB_MEMORY_BASE_0,
-					region.start);
-		pci_write_config_dword(bridge, PCI_CB_MEMORY_LIMIT_0,
-					region.end);
-	}
-
-	pcibios_resource_to_bus(bridge, &region, bus->resource[3]);
-	if (bus->resource[3]->flags & IORESOURCE_MEM) {
-		printk("  MEM window: %08lx-%08lx\n",
-			region.start, region.end);
-		pci_write_config_dword(bridge, PCI_CB_MEMORY_BASE_1,
-					region.start);
-		pci_write_config_dword(bridge, PCI_CB_MEMORY_LIMIT_1,
-					region.end);
-	}
-}
-
 /* Initialize bridges with base/limit values we have collected.
    PCI-to-PCI Bridge Architecture Specification rev. 1.1 (1998)
    requires that if there is no I/O ports or memory behind the
@@ -214,6 +154,9 @@
 	struct pci_dev *bridge = bus->self;
 	struct resource *b_res;
 
+	if (!bridge || (bridge->class >> 8) != PCI_CLASS_BRIDGE_PCI)
+		return;
+
 	b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
 	b_res[1].flags |= IORESOURCE_MEM;
 
@@ -245,10 +188,11 @@
    since these windows have 4K granularity and the IO ranges
    of non-bridge PCI devices are limited to 256 bytes.
    We must be careful with the ISA aliasing though. */
-static void __devinit pbus_size_io(struct pci_bus *bus, int resno)
+static void __devinit
+pbus_size_io(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
-	struct resource *b_res = bus->resource[resno];
+	struct resource *b_res = bus->resource[0];
 	unsigned long size = 0, size1 = 0;
 
 	if (!(b_res->flags & IORESOURCE_IO))
@@ -271,6 +215,9 @@
 			else
 				size1 += r_size;
 		}
+		/* ??? Reserve some resources for CardBus. */
+		if ((dev->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS)
+			size1 += 4*1024;
 	}
 /* To be fixed in 2.5: we should have sort of HAVE_ISA
    flag in the struct pci_bus. */
@@ -290,13 +237,14 @@
 /* Calculate the size of the bus and minimal alignment which
    guarantees that all child resources fit in this size. */
 static void __devinit
-pbus_size_mem(struct pci_bus *bus, int resno, unsigned long mask, unsigned long type)
+pbus_size_mem(struct pci_bus *bus, unsigned long mask, unsigned long type)
 {
-	struct resource *b_res = bus->resource[resno];
 	struct pci_dev *dev;
 	unsigned long min_align, align, size;
 	unsigned long aligns[12];	/* Alignments from 1Mb to 2Gb */
 	int order, max_order;
+	struct resource *b_res = (type & IORESOURCE_PREFETCH) ?
+				 bus->resource[2] : bus->resource[1];
 
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
@@ -332,6 +280,11 @@
 			if (order > max_order)
 				max_order = order;
 		}
+		/* ??? Reserve some resources for CardBus. */
+		if ((dev->class >> 8) == PCI_CLASS_BRIDGE_CARDBUS) {
+			size += 1UL << 24;		/* 16 Mb */
+			aligns[24 - 20] += 1UL << 24;
+		}
 	}
 
 	align = 0;
@@ -354,104 +307,37 @@
 	b_res->end = size + min_align - 1;
 }
 
-static void __devinit pci_bus_size_cardbus(struct pci_bus *bus)
-{
-	struct pci_dev *bridge = bus->self;
-	struct resource *b_res = &bridge->resource[PCI_BRIDGE_RESOURCES];
-	u16 ctrl;
-
-	/*
-	 * Reserve some resources for CardBus.  We reserve
-	 * a fixed amount of bus space for CardBus bridges.
-	 */
-	b_res[0].start = CARDBUS_IO_SIZE;
-	b_res[0].end = b_res[0].start + CARDBUS_IO_SIZE - 1;
-	b_res[0].flags |= IORESOURCE_IO;
-
-	b_res[1].start = CARDBUS_IO_SIZE;
-	b_res[1].end = b_res[1].start + CARDBUS_IO_SIZE - 1;
-	b_res[1].flags |= IORESOURCE_IO;
-
-	/*
-	 * Check whether prefetchable memory is supported
-	 * by this bridge.
-	 */
-	pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
-	if (!(ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0)) {
-		ctrl |= PCI_CB_BRIDGE_CTL_PREFETCH_MEM0;
-		pci_write_config_word(bridge, PCI_CB_BRIDGE_CONTROL, ctrl);
-		pci_read_config_word(bridge, PCI_CB_BRIDGE_CONTROL, &ctrl);
-	}
-
-	/*
-	 * If we have prefetchable memory support, allocate
-	 * two regions.  Otherwise, allocate one region of
-	 * twice the size.
-	 */
-	if (ctrl & PCI_CB_BRIDGE_CTL_PREFETCH_MEM0) {
-		b_res[2].start = CARDBUS_MEM_SIZE;
-		b_res[2].end = b_res[2].start + CARDBUS_MEM_SIZE - 1;
-		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
-
-		b_res[3].start = CARDBUS_MEM_SIZE;
-		b_res[3].end = b_res[3].start + CARDBUS_MEM_SIZE - 1;
-		b_res[3].flags |= IORESOURCE_MEM;
-	} else {
-		b_res[3].start = CARDBUS_MEM_SIZE * 2;
-		b_res[3].end = b_res[3].start + CARDBUS_MEM_SIZE * 2 - 1;
-		b_res[3].flags |= IORESOURCE_MEM;
-	}
-}
-
 void __devinit
 pci_bus_size_bridges(struct pci_bus *bus)
 {
-	struct pci_dev *dev;
-	unsigned long mask;
+	struct pci_bus *b;
+	unsigned long mask, type;
 
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		struct pci_bus *b = dev->subordinate;
-		if (!b)
-			continue;
-
-		switch (dev->class >> 8) {
-		case PCI_CLASS_BRIDGE_PCI:
-			pci_bus_size_bridges(b);
-			break;
-
-		case PCI_CLASS_BRIDGE_CARDBUS:
-			pci_bus_size_cardbus(b);
-			break;
-		}
+	list_for_each_entry(b, &bus->children, node) {
+		pci_bus_size_bridges(b);
 	}
 
 	/* The root bus? */
 	if (!bus->self)
 		return;
 
-	switch (bus->self->class >> 8) {
-	case PCI_CLASS_BRIDGE_PCI:
-		pci_bridge_check_ranges(bus);
-		pbus_size_io(bus, 0);
-		mask = IORESOURCE_MEM;
-		/* If the bridge supports prefetchable range, size it separately. */
-		if (bus->resource[2] &&
-		    bus->resource[2]->flags & IORESOURCE_PREFETCH) {
-			pbus_size_mem(bus, 2, IORESOURCE_PREFETCH | IORESOURCE_MEM,
-				      IORESOURCE_PREFETCH | IORESOURCE_MEM);
-			mask |= IORESOURCE_PREFETCH;	/* Size non-prefetch only. */
-		}
-		pbus_size_mem(bus, 1, mask, IORESOURCE_MEM);
-		break;
+	pci_bridge_check_ranges(bus);
+
+	pbus_size_io(bus);
 
-	case PCI_CLASS_BRIDGE_CARDBUS:
-		/* don't size cardbuses yet. */
-		break;
+	mask = type = IORESOURCE_MEM;
+	/* If the bridge supports prefetchable range, size it separately. */
+	if (bus->resource[2] &&
+	    bus->resource[2]->flags & IORESOURCE_PREFETCH) {
+		pbus_size_mem(bus, IORESOURCE_PREFETCH, IORESOURCE_PREFETCH);
+		mask |= IORESOURCE_PREFETCH;	/* Size non-prefetch only. */
 	}
+	pbus_size_mem(bus, mask, type);
 }
 EXPORT_SYMBOL(pci_bus_size_bridges);
 
-void __devinit pci_bus_assign_resources(struct pci_bus *bus)
+void __devinit
+pci_bus_assign_resources(struct pci_bus *bus)
 {
 	struct pci_bus *b;
 	int found_vga = pbus_assign_resources_sorted(bus);
@@ -465,24 +351,9 @@
 	}
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		b = dev->subordinate;
-		if (!b)
-			continue;
-
-		pci_bus_assign_resources(b);
-
-		switch (dev->class >> 8) {
-		case PCI_CLASS_BRIDGE_PCI:
+		if (b) {
+			pci_bus_assign_resources(b);
 			pci_setup_bridge(b);
-			break;
-
-		case PCI_CLASS_BRIDGE_CARDBUS:
-			pci_setup_cardbus(b);
-			break;
-
-		default:
-			printk(KERN_INFO "PCI: not setting up bridge %s "
-			       "for bus %d\n", dev->slot_name, b->number);
-			break;
 		}
 	}
 }



-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

