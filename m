Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285250AbRLSLKR>; Wed, 19 Dec 2001 06:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285246AbRLSLKI>; Wed, 19 Dec 2001 06:10:08 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:54790 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S285241AbRLSLJ6>; Wed, 19 Dec 2001 06:09:58 -0500
Date: Tue, 18 Dec 2001 23:50:35 +0000
From: Russell King <rmk@flint.arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PCI updates - prefetchable memory regions
Message-ID: <20011218235035.P13126@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Traditionally, Linux has treated prefetchable memory regions as if they were
non-prefetchable memory regions.

The following patch allows architectures to split the prefetchable memory
regions from the non-prefetchable regions if they wish by supplying a
third bus resource.  This third resource must have the IORESOURCE_PREFETCH
flag set.  (Other parts of the PCI layer already assume this is true).
Currently, some ARM based machines make use of this facility.

If this resource is not present, we fall back to the original scheme, where
we allocate prefetchable memory regions as if they were non-prefetchable.
This magic is handled by pdev_adjust_mem_ranges().

We introduce 3 new elements into pbus_set_ranges_data:
 - prefetch_valid - indicates if we have resource[2] in the parent bus
   (which is used for the prefetchable memory region).
 - prefetch_start - the start of the prefetchable memory region.
 - prefetch_end - the end of the prefetchable memory region.

The last two are treated in the same way as mem_start and mem_end for
determining the memory region which the bridge should forward.

Please review this patch, which is targetted solely for 2.5.

diff -ur orig/drivers/pci/setup-bus.c linux/drivers/pci/setup-bus.c
--- orig/drivers/pci/setup-bus.c	Sun Oct 14 20:53:14 2001
+++ linux/drivers/pci/setup-bus.c	Tue Dec 18 23:20:13 2001
@@ -12,6 +12,8 @@
 /*
  * Nov 2000, Ivan Kokshaysky <ink@jurassic.park.msu.ru>
  *	     PCI-PCI bridges cleanup, sorted resource allocation
+ * May 2001, Russell King <rmk@arm.linux.org.uk>
+ *           Allocate prefetchable memory regions where available.
  */
 
 #include <linux/init.h>
@@ -32,6 +34,26 @@
 
 #define ROUND_UP(x, a)		(((x) + (a) - 1) & ~((a) - 1))
 
+static inline void
+pdev_adjust_mem_ranges(struct resource *res, struct pbus_set_ranges_data *ranges)
+{
+	unsigned long *end = &ranges->mem_end;
+
+	/*
+	 * We can't use this resources prefetch flag to determine which
+	 * region it belongs to - we may have allocated it in the non-
+	 * prefetchable region.  Use the parent resource instead.
+	 */
+	if (res->parent->flags & IORESOURCE_PREFETCH) {
+		end = &ranges->prefetch_end;
+		if (ranges->prefetch_valid == 0)
+			BUG();
+	}
+
+	if (*end < res->end)
+		*end = res->end;
+}
+
 static int __init
 pbus_assign_resources_sorted(struct pci_bus *bus,
 			     struct pbus_set_ranges_data *ranges)
@@ -89,9 +111,8 @@
 	for (list = head_mem.next; list;) {
 		res = list->res;
 		idx = res - &list->dev->resource[0];
-		if (pci_assign_resource(list->dev, idx) == 0
-		    && ranges->mem_end < res->end)
-			ranges->mem_end = res->end;
+		if (pci_assign_resource(list->dev, idx) == 0)
+			pdev_adjust_mem_ranges(res, ranges);
 		tmp = list;
 		list = list->next;
 		kfree(tmp);
@@ -113,9 +134,12 @@
 		ranges->io_end += 1;
 	if (ranges->mem_end == ranges->mem_start)
 		ranges->mem_end += 1;
+	if (ranges->prefetch_end == ranges->prefetch_start)
+		ranges->prefetch_end += 1;
 #endif
 	ranges->io_end = ROUND_UP(ranges->io_end, 4*1024);
 	ranges->mem_end = ROUND_UP(ranges->mem_end, 1024*1024);
+	ranges->prefetch_end = ROUND_UP(ranges->prefetch_end, 1024*1024);
 
 	return found_vga;
 }
@@ -130,15 +154,24 @@
 
 	if (!bridge || (bridge->class >> 8) != PCI_CLASS_BRIDGE_PCI)
 		return;
+
 	ranges.io_start = bus->resource[0]->start;
 	ranges.io_end = bus->resource[0]->end;
 	ranges.mem_start = bus->resource[1]->start;
 	ranges.mem_end = bus->resource[1]->end;
+	ranges.prefetch_start = bus->resource[2]->start;
+	ranges.prefetch_end = bus->resource[2]->end;
+
 	pcibios_fixup_pbus_ranges(bus, &ranges);
 
-	DBGC((KERN_ERR "PCI: Bus %d, bridge: %s\n", bus->number, bridge->name));
-	DBGC((KERN_ERR "  IO window: %04lx-%04lx\n", ranges.io_start, ranges.io_end));
-	DBGC((KERN_ERR "  MEM window: %08lx-%08lx\n", ranges.mem_start, ranges.mem_end));
+	DBGC((KERN_ERR "PCI: Bus %d, bridge: %s\n",
+		bus->number, bridge->name));
+	DBGC((KERN_ERR "  IO window: %08lx-%08lx\n",
+		ranges.io_start, ranges.io_end));
+	DBGC((KERN_ERR "  MEM window: %08lx-%08lx\n",
+		ranges.mem_start, ranges.mem_end));
+	DBGC((KERN_ERR "  PREFETCH window: %08lx-%08lx\n",
+		ranges.prefetch_start, ranges.prefetch_end));
 
 	/* Set up the top and bottom of the PCI I/O segment for this bus. */
 	pci_read_config_dword(bridge, PCI_IO_BASE, &l);
@@ -161,13 +197,15 @@
 	pci_write_config_dword(bridge, PCI_MEMORY_BASE, l);
 
 	/* Set up PREF base/limit. */
-	l = (bus->resource[2]->start >> 16) & 0xfff0;
-	l |= bus->resource[2]->end & 0xfff00000;
+	l = (ranges.prefetch_start >> 16) & 0xfff0;
+	l |= ranges.prefetch_end & 0xfff00000;
 	pci_write_config_dword(bridge, PCI_PREF_MEMORY_BASE, l);
 
 	/* Check if we have VGA behind the bridge.
 	   Enable ISA in either case. */
-	l = (bus->resource[0]->flags & IORESOURCE_BUS_HAS_VGA) ? 0x0c : 0x04;
+	l = (bus->resource[0]->flags & IORESOURCE_BUS_HAS_VGA) ?
+		PCI_BRIDGE_CTL_VGA | PCI_BRIDGE_CTL_NO_ISA :
+		PCI_BRIDGE_CTL_NO_ISA;
 	pci_write_config_word(bridge, PCI_BRIDGE_CONTROL, l);
 }
 
@@ -195,11 +233,21 @@
 
 		b->resource[0]->start = ranges->io_start = ranges->io_end;
 		b->resource[1]->start = ranges->mem_start = ranges->mem_end;
+		if (ranges->prefetch_valid)
+			b->resource[2]->start = ranges->prefetch_start =
+					 ranges->prefetch_end;
 
 		pbus_assign_resources(b, ranges);
 
 		b->resource[0]->end = ranges->io_end - 1;
 		b->resource[1]->end = ranges->mem_end - 1;
+		if (ranges->prefetch_valid)
+			b->resource[2]->end = ranges->prefetch_end - 1;
+
+		request_resource(bus->resource[0], b->resource[0]);
+		request_resource(bus->resource[1], b->resource[1]);
+		if (ranges->prefetch_valid)
+			request_resource(bus->resource[2], b->resource[2]);
 
 		pci_setup_bridge(b);
 	}
@@ -219,6 +267,11 @@
 		ranges.mem_start = b->resource[1]->start + PCIBIOS_MIN_MEM;
 		ranges.io_end = ranges.io_start;
 		ranges.mem_end = ranges.mem_start;
+		ranges.prefetch_valid = b->resource[2] != NULL;
+		if (ranges.prefetch_valid) {
+			ranges.prefetch_start = b->resource[2]->start + PCIBIOS_MIN_MEM;
+			ranges.prefetch_end = ranges.prefetch_start;
+		}
 		ranges.found_vga = 0;
 		pbus_assign_resources(b, &ranges);
 	}
--- orig/include/linux/pci.h	Fri Nov 23 10:12:30 2001
+++ linux/include/linux/pci.h	Thu Nov 22 12:43:00 2001
@@ -460,9 +460,11 @@
 
 struct pbus_set_ranges_data
 {
-	int found_vga;
+	int found_vga:1;
+	int prefetch_valid:1;
 	unsigned long io_start, io_end;
 	unsigned long mem_start, mem_end;
+	unsigned long prefetch_start, prefetch_end;
 };
 
 struct pci_device_id {



--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

