Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUJNMsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUJNMsE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 08:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUJNMsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 08:48:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18631 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263818AbUJNMrl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 08:47:41 -0400
Date: Thu, 14 Oct 2004 13:47:37 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: [PATCH] Introduce PCI <-> CPU address conversion [1/2]
Message-ID: <20041014124737.GM16153@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some machines have a different address space on the PCI bus from the
CPU's bus.  This is currently fixed up in pcibios_fixup_bus().  However,
this is not called for hotplug devices.  Calling pcibios_fixup_bus() when
a device is hotplugged onto a bus is also wrong as it would attempt to
fixup devices that have already been fixed up with potentially horrific
consequences.

This patch teaches the generic PCI layer that there may be different
address spaces, and converts from bus views to cpu views when reading
from BARs.  Some drivers (eg sym2, acpiphp) need to go back the other
way, so it also introduces the inverse operation.

Architectures can migrate to the new pci_phys_to_bus() / pci_bus_to_phys()
interface in their own time; I shall post the patch for ia64 seperately.

 drivers/pci/probe.c  |   99 +++++++++++++++++++++++++++------------------------
 drivers/pci/quirks.c |    4 +-
 include/linux/pci.h  |   11 +++++
 3 files changed, 67 insertions(+), 47 deletions(-)

Index: pci-2.6/drivers/pci/probe.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/pci/probe.c,v
retrieving revision 1.14
diff -u -p -r1.14 probe.c
--- pci-2.6/drivers/pci/probe.c	13 Sep 2004 15:23:21 -0000	1.14
+++ pci-2.6/drivers/pci/probe.c	14 Oct 2004 12:04:02 -0000
@@ -82,9 +82,10 @@ static inline unsigned int pci_calc_reso
 /*
  * Find the extent of a PCI decode..
  */
-static u32 pci_size(u32 base, u32 maxbase, unsigned long mask)
+static unsigned long
+pci_size(unsigned long base, unsigned long maxbase, unsigned long mask)
 {
-	u32 size = mask & maxbase;	/* Find the significant bits */
+	unsigned long size = mask & maxbase;	/* Find the significant bits */
 	if (!size)
 		return 0;
 
@@ -100,14 +101,18 @@ static u32 pci_size(u32 base, u32 maxbas
 	return size;
 }
 
+#define IS_MEMORY(l)	(((l) & PCI_BASE_ADDRESS_SPACE) == \
+				PCI_BASE_ADDRESS_SPACE_MEMORY)
+#define IS_64BIT(l)	(((l) & PCI_BASE_ADDRESS_MEM_TYPE_64) != 0)
+
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
 {
-	unsigned int pos, reg, next;
+	unsigned int pos, reg;
 	u32 l, sz;
 	struct resource *res;
 
-	for(pos=0; pos<howmany; pos = next) {
-		next = pos+1;
+	for (pos = 0; pos < howmany; pos++) {
+		unsigned long start, size;
 		res = &dev->resource[pos];
 		res->name = pci_name(dev);
 		reg = PCI_BASE_ADDRESS_0 + (pos << 2);
@@ -119,43 +124,45 @@ static void pci_read_bases(struct pci_de
 			continue;
 		if (l == 0xffffffff)
 			l = 0;
-		if ((l & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY) {
-			sz = pci_size(l, sz, PCI_BASE_ADDRESS_MEM_MASK);
-			if (!sz)
-				continue;
-			res->start = l & PCI_BASE_ADDRESS_MEM_MASK;
-			res->flags |= l & ~PCI_BASE_ADDRESS_MEM_MASK;
-		} else {
-			sz = pci_size(l, sz, PCI_BASE_ADDRESS_IO_MASK & 0xffff);
-			if (!sz)
-				continue;
-			res->start = l & PCI_BASE_ADDRESS_IO_MASK;
-			res->flags |= l & ~PCI_BASE_ADDRESS_IO_MASK;
-		}
-		res->end = res->start + (unsigned long) sz;
-		res->flags |= pci_calc_resource_flags(l);
-		if ((l & (PCI_BASE_ADDRESS_SPACE | PCI_BASE_ADDRESS_MEM_TYPE_MASK))
-		    == (PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64)) {
-			pci_read_config_dword(dev, reg+4, &l);
-			next++;
+		if (IS_MEMORY(l)) {
+			size = sz;
+			start = l;
+			if (IS_64BIT(l)) {
+				pos++;
+				pci_read_config_dword(dev, reg+4, &l);
 #if BITS_PER_LONG == 64
-			res->start |= ((unsigned long) l) << 32;
-			res->end = res->start + sz;
-			pci_write_config_dword(dev, reg+4, ~0);
-			pci_read_config_dword(dev, reg+4, &sz);
-			pci_write_config_dword(dev, reg+4, l);
-			if (~sz)
-				res->end = res->start + 0xffffffff +
-						(((unsigned long) ~sz) << 32);
+				start |= ((unsigned long) l) << 32;
+				pci_write_config_dword(dev, reg+4, ~0);
+				pci_read_config_dword(dev, reg+4, &sz);
+				pci_write_config_dword(dev, reg+4, l);
+				size |= ((unsigned long) sz) << 32;
 #else
-			if (l) {
-				printk(KERN_ERR "PCI: Unable to handle 64-bit address for device %s\n", pci_name(dev));
-				res->start = 0;
-				res->flags = 0;
-				continue;
-			}
+				if (l) {
+					printk(KERN_ERR "PCI: Unable to handle "
+							"64-bit address for "
+							"device %s\n",
+							pci_name(dev));
+					res->flags = 0;
+					continue;
+				}
 #endif
+			}
+
+			size = pci_size(start, size, PCI_BASE_ADDRESS_MEM_MASK);
+			if (!size)
+				continue;
+			start = start & PCI_BASE_ADDRESS_MEM_MASK;
+			res->flags = start & ~PCI_BASE_ADDRESS_MEM_MASK;
+		} else {
+			size = pci_size(l, sz, PCI_BASE_ADDRESS_IO_MASK & 0xffff);
+			if (!size)
+				continue;
+			start = l & PCI_BASE_ADDRESS_IO_MASK;
+			res->flags = l & ~PCI_BASE_ADDRESS_IO_MASK;
 		}
+		res->flags |= pci_calc_resource_flags(res->flags);
+		res->start = pci_bus_to_phys(dev, start, res->flags);
+		res->end = res->start + size;
 	}
 	if (rom) {
 		dev->rom_base_reg = rom;
@@ -173,7 +180,9 @@ static void pci_read_bases(struct pci_de
 				res->flags = (l & PCI_ROM_ADDRESS_ENABLE) |
 				  IORESOURCE_MEM | IORESOURCE_PREFETCH |
 				  IORESOURCE_READONLY | IORESOURCE_CACHEABLE;
-				res->start = l & PCI_ROM_ADDRESS_MASK;
+				res->start = pci_bus_to_phys(dev,
+						l & PCI_ROM_ADDRESS_MASK,
+						res->flags);
 				res->end = res->start + (unsigned long) sz;
 			}
 		}
@@ -218,8 +227,8 @@ void __devinit pci_read_bridge_bases(str
 
 	if (base <= limit) {
 		res->flags = (io_base_lo & PCI_IO_RANGE_TYPE_MASK) | IORESOURCE_IO;
-		res->start = base;
-		res->end = limit + 0xfff;
+		res->start = pci_bus_to_phys(dev, base, IORESOURCE_IO);
+		res->end = pci_bus_to_phys(dev, limit + 0xfff, IORESOURCE_IO);
 	}
 
 	res = child->resource[1];
@@ -229,8 +238,8 @@ void __devinit pci_read_bridge_bases(str
 	limit = (mem_limit_lo & PCI_MEMORY_RANGE_MASK) << 16;
 	if (base <= limit) {
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM;
-		res->start = base;
-		res->end = limit + 0xfffff;
+		res->start = pci_bus_to_phys(dev, base, IORESOURCE_MEM);
+		res->end = pci_bus_to_phys(dev, limit + 0xfffff, IORESOURCE_MEM);
 	}
 
 	res = child->resource[2];
@@ -255,8 +264,8 @@ void __devinit pci_read_bridge_bases(str
 	}
 	if (base <= limit) {
 		res->flags = (mem_base_lo & PCI_MEMORY_RANGE_TYPE_MASK) | IORESOURCE_MEM | IORESOURCE_PREFETCH;
-		res->start = base;
-		res->end = limit + 0xfffff;
+		res->start = pci_bus_to_phys(dev, base, IORESOURCE_MEM);
+		res->end = pci_bus_to_phys(dev, limit + 0xfffff, IORESOURCE_MEM);
 	}
 }
 
Index: pci-2.6/drivers/pci/quirks.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/pci/quirks.c,v
retrieving revision 1.16
diff -u -p -r1.16 quirks.c
--- pci-2.6/drivers/pci/quirks.c	13 Sep 2004 15:23:21 -0000	1.16
+++ pci-2.6/drivers/pci/quirks.c	14 Oct 2004 12:04:02 -0000
@@ -236,8 +236,8 @@ static void __devinit quirk_io_region(st
 		struct resource *res = dev->resource + nr;
 
 		res->name = pci_name(dev);
-		res->start = region;
-		res->end = region + size - 1;
+		res->start = pci_bus_to_phys(dev, region, IORESOURCE_IO);
+		res->end = res->start + size - 1;
 		res->flags = IORESOURCE_IO;
 		pci_claim_resource(dev, nr);
 	}
Index: pci-2.6/include/linux/pci.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/linux/pci.h,v
retrieving revision 1.18
diff -u -p -r1.18 pci.h
--- pci-2.6/include/linux/pci.h	13 Sep 2004 15:24:12 -0000	1.18
+++ pci-2.6/include/linux/pci.h	14 Oct 2004 12:04:07 -0000
@@ -994,6 +994,17 @@ static inline char *pci_name(struct pci_
 #endif
 
 /*
+ * Convert between the CPU's view of addresses on a PCI card and the PCI
+ * device's view of the same location.  The default implementation is a no-op
+ * as most architectures have the same addresses on the CPU and PCI busses.
+ */
+
+#ifndef pci_phys_to_bus
+#define pci_phys_to_bus(busdev, addr, flags) (addr)
+#define pci_bus_to_phys(busdev, addr, flags) (addr)
+#endif
+
+/*
  *  The world is not perfect and supplies us with broken PCI devices.
  *  For at least a part of these bugs we need a work-around, so both
  *  generic (drivers/pci/quirks.c) and per-architecture code can define
-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
