Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265130AbSLQRVP>; Tue, 17 Dec 2002 12:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbSLQRVP>; Tue, 17 Dec 2002 12:21:15 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:45830 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265130AbSLQRVF>; Tue, 17 Dec 2002 12:21:05 -0500
Date: Tue, 17 Dec 2002 20:28:27 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5] PCI: setup-bus.c cleanup
Message-ID: <20021217202827.B16940@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's basically the same patch that I sent couple of weeks ago, but
comments has been updated in attempt to make this stuff less confusing.

- Remove dependency on fixed bus resource layout. This should
  make setup-bus routines more suitable for arbitrary bridges.
- Check for already allocated bus resources and skip them, so
  all these routines can be used on [partially] allocated PCI tree.
- Fix long standing typo ('size' instead of 'r_size') which led to
  overestimation of the bridge memory ranges calculated
  in pbus_size_mem().

Ivan.

--- 2.5/drivers/pci/setup-bus.c	Tue Dec 10 09:15:16 2002
+++ linux/drivers/pci/setup-bus.c	Tue Dec 10 10:51:59 2002
@@ -206,6 +206,26 @@ pci_bridge_check_ranges(struct pci_bus *
 		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
 }
 
+/* Helper function for sizing routines: find first unallocated
+   bus resource of a given type. Bus resources that are already
+   assigned (even with matching types) will be skipped - we're
+   not going to touch them anyway. */
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
@@ -214,16 +234,19 @@ static void __devinit
 pbus_size_io(struct pci_bus *bus)
 {
 	struct list_head *ln;
-	struct resource *b_res = bus->resource[0];
+	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
 	unsigned long size = 0, size1 = 0;
 
-	if (!(b_res->flags & IORESOURCE_IO))
+	if (!b_res)
 		return;
 
+	DBGC((KERN_INFO "PCI: found %s resource %ld for IO\n",
+			bus->name, b_res - bus->resource[0]));
+
 	for (ln=bus->devices.next; ln != &bus->devices; ln=ln->next) {
 		struct pci_dev *dev = pci_dev_b(ln);
 		int i;
-		
+
 		for (i = 0; i < PCI_NUM_RESOURCES; i++) {
 			struct resource *r = &dev->resource[i];
 			unsigned long r_size;
@@ -259,15 +282,21 @@ pbus_size_io(struct pci_bus *bus)
 
 /* Calculate the size of the bus and minimal alignment which
    guarantees that all child resources fit in this size. */
-static void __devinit
+static int __devinit
 pbus_size_mem(struct pci_bus *bus, unsigned long mask, unsigned long type)
 {
 	struct list_head *ln;
 	unsigned long min_align, align, size;
 	unsigned long aligns[12];	/* Alignments from 1Mb to 2Gb */
 	int order, max_order;
-	struct resource *b_res = (type & IORESOURCE_PREFETCH) ?
-				 bus->resource[2] : bus->resource[1];
+	struct resource *b_res = find_free_bus_resource(bus, type);
+
+	if (!b_res)
+		return 0;
+
+	DBGC((KERN_INFO "PCI: found %s resource %ld for %s\n",
+			bus->name, b_res - bus->resource[0],
+			type & IORESOURCE_PREFETCH ? "PREF" : "MEM"));
 
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
@@ -299,7 +328,7 @@ pbus_size_mem(struct pci_bus *bus, unsig
 				order = 0;
 			/* Exclude ranges with size > align from
 			   calculation of the alignment. */
-			if (size == align)
+			if (r_size == align)
 				aligns[order] += align;
 			if (order > max_order)
 				max_order = order;
@@ -325,17 +354,18 @@ pbus_size_mem(struct pci_bus *bus, unsig
 	size = ROUND_UP(size, min_align);
 	if (!size) {
 		b_res->flags = 0;
-		return;
+		return 1;
 	}
 	b_res->start = min_align;
 	b_res->end = size + min_align - 1;
+	return 1;
 }
 
 void __devinit
 pci_bus_size_bridges(struct pci_bus *bus)
 {
 	struct list_head *ln;
-	unsigned long mask, type;
+	unsigned long mask, prefetch;
 
 	for (ln=bus->children.next; ln != &bus->children; ln=ln->next)
 		pci_bus_size_bridges(pci_bus_b(ln));
@@ -348,15 +378,17 @@ pci_bus_size_bridges(struct pci_bus *bus
 
 	pbus_size_io(bus);
 
-	mask = type = IORESOURCE_MEM;
-	/* If the bridge supports prefetchable range, size it separately. */
-	if (bus->resource[2] &&
-	    bus->resource[2]->flags & IORESOURCE_PREFETCH) {
-		pbus_size_mem(bus, IORESOURCE_PREFETCH, IORESOURCE_PREFETCH);
-		mask |= IORESOURCE_PREFETCH;	/* Size non-prefetch only. */
-	}
-	pbus_size_mem(bus, mask, type);
+	/* If the bridge supports prefetchable range, size it separately.
+	   If it doesn't, or its prefetchable window has been already
+	   allocated by arch code, try non-prefetchable range for
+	   both types of PCI memory resources. */
+	mask = IORESOURCE_MEM;
+	prefetch = IORESOURCE_MEM | IORESOURCE_PREFETCH;
+	if (pbus_size_mem(bus, prefetch, prefetch))
+		mask = prefetch;	/* Success, size non-prefetch only. */
+	pbus_size_mem(bus, mask, IORESOURCE_MEM);
 }
+
 EXPORT_SYMBOL(pci_bus_size_bridges);
 
 void __devinit
@@ -380,6 +412,7 @@ pci_bus_assign_resources(struct pci_bus 
 		pci_setup_bridge(b);
 	}
 }
+
 EXPORT_SYMBOL(pci_bus_assign_resources);
 
 void __init
