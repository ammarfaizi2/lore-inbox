Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265895AbSKFSDw>; Wed, 6 Nov 2002 13:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265900AbSKFSDv>; Wed, 6 Nov 2002 13:03:51 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:6916 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S265895AbSKFSCb>; Wed, 6 Nov 2002 13:02:31 -0500
Date: Wed, 6 Nov 2002 21:09:02 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5-bk] PCI 3/3: setup-bus update
Message-ID: <20021106210902.E686@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove dependency on fixed bus resource layout. This should
  make setup-bus routines more suitable for arbitrary bridges.
- Check for already allocated bus resources and skip them, so
  that all this stuff could be used on [partially] allocated
  PCI tree.

Ivan.

--- 2.5-bk/drivers/pci/setup-bus.c	Wed Nov  6 17:39:18 2002
+++ linux/drivers/pci/setup-bus.c	Wed Nov  6 17:44:26 2002
@@ -207,6 +207,21 @@ pci_bridge_check_ranges(struct pci_bus *
 		b_res[2].flags |= IORESOURCE_MEM | IORESOURCE_PREFETCH;
 }
 
+/* Find first free bus resource of a given type */
+static struct resource * __devinit
+pbus_find_resource(struct pci_bus *bus, unsigned long type)
+{
+	int i;
+	struct resource *r;
+
+	for (i = 0; i < PCI_BUS_NUM_RESOURCES; i++) {
+		r = bus->resource[i];
+		if (r && !((r->flags ^ type) & type) && !r->parent)
+			return r;
+	}
+	return NULL;
+}
+
 /* Sizing the IO windows of the PCI-PCI bridge is trivial,
    since these windows have 4K granularity and the IO ranges
    of non-bridge PCI devices are limited to 256 bytes.
@@ -215,12 +230,15 @@ static void __devinit
 pbus_size_io(struct pci_bus *bus)
 {
 	struct list_head *ln;
-	struct resource *b_res = bus->resource[0];
+	struct resource *b_res = pbus_find_resource(bus, IORESOURCE_IO);
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
@@ -260,15 +278,21 @@ pbus_size_io(struct pci_bus *bus)
 
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
+	struct resource *b_res = pbus_find_resource(bus, type);
+
+	if (!b_res)
+		return 0;
+
+	DBGC((KERN_INFO "PCI: found %s resource %ld for %s\n",
+			bus->name, b_res - bus->resource[0],
+			type & IORESOURCE_PREFETCH ? "PREF" : "MEM"));
 
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
@@ -326,17 +350,18 @@ pbus_size_mem(struct pci_bus *bus, unsig
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
 pbus_size_bridges(struct pci_bus *bus)
 {
 	struct list_head *ln;
-	unsigned long mask, type;
+	unsigned long mask, prefetch;
 
 	for (ln=bus->children.next; ln != &bus->children; ln=ln->next)
 		pbus_size_bridges(pci_bus_b(ln));
@@ -349,14 +374,12 @@ pbus_size_bridges(struct pci_bus *bus)
 
 	pbus_size_io(bus);
 
-	mask = type = IORESOURCE_MEM;
+	mask = IORESOURCE_MEM;
+	prefetch = IORESOURCE_MEM | IORESOURCE_PREFETCH;
 	/* If the bridge supports prefetchable range, size it separately. */
-	if (bus->resource[2] &&
-	    bus->resource[2]->flags & IORESOURCE_PREFETCH) {
-		pbus_size_mem(bus, IORESOURCE_PREFETCH, IORESOURCE_PREFETCH);
-		mask |= IORESOURCE_PREFETCH;	/* Size non-prefetch only. */
-	}
-	pbus_size_mem(bus, mask, type);
+	if (pbus_size_mem(bus, prefetch, prefetch))
+		mask = prefetch;		/* Size non-prefetch only. */
+	pbus_size_mem(bus, mask, IORESOURCE_MEM);
 }
 EXPORT_SYMBOL(pbus_size_bridges);
 
@@ -369,7 +392,8 @@ pbus_assign_resources(struct pci_bus *bu
 	if (found_vga) {
 		struct pci_bus *b;
 
-		/* Propagate presence of the VGA to upstream bridges */
+		/* Propagate presence of the VGA to upstream bridges.
+		   This hack eventually will go away. */
 		for (b = bus; b->parent; b = b->parent) {
 			b->resource[0]->flags |= IORESOURCE_BUS_HAS_VGA;
 		}
