Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSJFOlQ>; Sun, 6 Oct 2002 10:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261628AbSJFOlQ>; Sun, 6 Oct 2002 10:41:16 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:23048 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S261624AbSJFOlO>; Sun, 6 Oct 2002 10:41:14 -0400
Date: Sun, 6 Oct 2002 18:46:15 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 2.5.40] read-only PCI BARs, try #2
Message-ID: <20021006184615.A12895@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,
here is a non-destructive version of the previous patch.
It's a bit more complex as we have to handle
the 'old_value == probed_value' case correctly without
extra write(0) probe.

Ivan.

--- 2.5.40/drivers/pci/probe.c	Sat Sep 21 12:54:53 2002
+++ linux/drivers/pci/probe.c	Sun Oct  6 01:59:31 2002
@@ -34,13 +34,20 @@ static inline unsigned int pci_calc_reso
 }
 
 /*
- * Find the extent of a PCI decode..
+ * Find the extent of a PCI decode, do sanity checks.
  */
-static u32 pci_size(u32 base, unsigned long mask)
+static u32 pci_size(u32 base, u32 maxbase, unsigned long mask)
 {
-	u32 size = mask & base;		/* Find the significant bits */
+	u32 size = mask & maxbase;	/* Find the significant bits */
+	if (!size)
+		return 0;
 	size = size & ~(size-1);	/* Get the lowest of them to find the decode size */
-	return size-1;			/* extent = size - 1 */
+	size -= 1;			/* extent = size - 1 */
+	if (base == maxbase && ((base | size) & mask) != mask)
+		return 0;		/* base == maxbase can be valid only
+					   if the BAR has been already
+					   programmed with all 1s */
+	return size;
 }
 
 static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, int rom)
@@ -63,13 +70,17 @@ static void pci_read_bases(struct pci_de
 		if (l == 0xffffffff)
 			l = 0;
 		if ((l & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_MEMORY) {
+			sz = pci_size(l, sz, PCI_BASE_ADDRESS_MEM_MASK);
+			if (!sz)
+				continue;
 			res->start = l & PCI_BASE_ADDRESS_MEM_MASK;
 			res->flags |= l & ~PCI_BASE_ADDRESS_MEM_MASK;
-			sz = pci_size(sz, PCI_BASE_ADDRESS_MEM_MASK);
 		} else {
+			sz = pci_size(l, sz, PCI_BASE_ADDRESS_IO_MASK & 0xffff);
+			if (!sz)
+				continue;
 			res->start = l & PCI_BASE_ADDRESS_IO_MASK;
 			res->flags |= l & ~PCI_BASE_ADDRESS_IO_MASK;
-			sz = pci_size(sz, PCI_BASE_ADDRESS_IO_MASK & 0xffff);
 		}
 		res->end = res->start + (unsigned long) sz;
 		res->flags |= pci_calc_resource_flags(l);
@@ -99,6 +110,7 @@ static void pci_read_bases(struct pci_de
 	if (rom) {
 		dev->rom_base_reg = rom;
 		res = &dev->resource[PCI_ROM_RESOURCE];
+		res->name = dev->name;
 		pci_read_config_dword(dev, rom, &l);
 		pci_write_config_dword(dev, rom, ~PCI_ROM_ADDRESS_ENABLE);
 		pci_read_config_dword(dev, rom, &sz);
@@ -106,13 +118,14 @@ static void pci_read_bases(struct pci_de
 		if (l == 0xffffffff)
 			l = 0;
 		if (sz && sz != 0xffffffff) {
+			sz = pci_size(l, sz, PCI_ROM_ADDRESS_MASK);
+			if (!sz)
+				return;
 			res->flags = (l & PCI_ROM_ADDRESS_ENABLE) |
 			  IORESOURCE_MEM | IORESOURCE_PREFETCH | IORESOURCE_READONLY | IORESOURCE_CACHEABLE;
 			res->start = l & PCI_ROM_ADDRESS_MASK;
-			sz = pci_size(sz, PCI_ROM_ADDRESS_MASK);
 			res->end = res->start + (unsigned long) sz;
 		}
-		res->name = dev->name;
 	}
 }
 
