Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWCNI02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWCNI02 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752025AbWCNI01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:26:27 -0500
Received: from mtaout1.012.net.il ([84.95.2.1]:17370 "EHLO mtaout1.012.net.il")
	by vger.kernel.org with ESMTP id S1750955AbWCNI00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:26:26 -0500
Date: Tue, 14 Mar 2006 10:25:52 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [PATCH RFC 2/3] x86-64: Calgary IOMMU - Calgary specific bits
In-reply-to: <20060314082432.GE23631@granada.merseine.nu>
To: Andi Kleen <ak@suse.de>
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <MULI@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Message-id: <20060314082552.GF23631@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060314082432.GE23631@granada.merseine.nu>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch introduces the Calgary specific bits. The implementation
draws inspiration from both PPC (which has support for the same chip
but requires firmware support which we don't have on x86-64) and
gart. Calgary is different from gart in that it support a translation
table per PHB, as opposed to the single gart aperture.

The patch is against 2.6.16-rc6 and has been heavily tested on both
IBM x366 servers and AMD Opteron machines with gart, with Calgary
enabled and disabled in the .config and with
iommu={off|soft|force}. Performance numbers are reasonable. There's
plenty more to do, but we're aiming for release early and often.

Signed-off-by: Muli Ben-Yehuda <mulix@mulix.org>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>

---

muli@granada:~/tmp$ diffstat calgary-specific-B1
 arch/x86_64/kernel/pci-calgary.c |  887 +++++++++++++++++++++++++++++++++++++++
 arch/x86_64/kernel/tce.c         |  188 ++++++++
 include/asm-x86_64/calgary.h     |   64 ++
 include/asm-x86_64/tce.h         |   48 ++
 4 files changed, 1187 insertions(+)

diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/arch/x86_64/kernel/pci-calgary.c linux/arch/x86_64/kernel/pci-calgary.c
--- iommu_detected/arch/x86_64/kernel/pci-calgary.c	1970-01-01 02:00:00.000000000 +0200
+++ linux/arch/x86_64/kernel/pci-calgary.c	2006-03-12 20:26:03.000000000 +0200
@@ -0,0 +1,887 @@
+/*
+ * Derived from arch/powerpc/kernel/iommu.c
+ *
+ * Copyright (C) 2006 Jon Mason <jdmason@us.ibm.com>, IBM Corporation
+ * Copyright (C) 2006 Muli Ben-Yehuda <mulix@mulix.org>, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/bitops.h>
+#include <linux/pci_ids.h>
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <asm/proto.h>
+#include <asm/calgary.h>
+#include <asm/tce.h>
+#include <asm/pci-direct.h>
+#include <asm/system.h>
+#include <asm/dma.h>
+
+#define PCI_DEVICE_ID_IBM_CALGARY 0x02a1
+#define PCI_VENDOR_DEVICE_ID_CALGARY \
+	(PCI_VENDOR_ID_IBM | PCI_DEVICE_ID_IBM_CALGARY << 16)
+
+/* register offsets in Calgary's internal register space */
+#define BBAR_OFFSET		0x0500
+#define TAR0_OFFSET		0x0580
+#define TAR1_OFFSET		0x0588
+#define TAR2_OFFSET		0x0590
+#define TAR3_OFFSET		0x0598
+#define SPLITQ0_OFFSET		0x4870
+#define SPLITQ1_OFFSET		0x5870
+#define SPLITQ2_OFFSET		0x6870
+#define SPLITQ3_OFFSET		0x7870
+#define PHB0_OFFSET		0x8000
+#define PHB1_OFFSET		0x9000
+#define PHB2_OFFSET		0xA000
+#define PHB3_OFFSET		0xB000
+
+/* register offsets inside the PHB space */
+#define PHB_PLSSR_OFFSET	0x0120
+#define PHB_CONFIG_RW_OFFSET	0x0160
+#define PHB_IOBASE_BAR_LOW	0x0170
+#define PHB_IOBASE_BAR_HIGH	0x0180
+#define PHB_MEM_1_LOW		0x0190
+#define PHB_MEM_1_HIGH		0x01A0
+#define PHB_IO_ADDR_SIZE	0x01B0
+#define PHB_MEM_1_SIZE		0x01C0
+#define PHB_MEM_ST_OFFSET	0x01D0
+#define PHB_DOSHOLE_OFFSET	0x08E0
+#define PHB_AER_OFFSET		0x0200
+#define PHB_CONFIG_0_HIGH	0x0220
+#define PHB_CONFIG_0_LOW	0x0230
+#define PHB_CONFIG_0_END	0x0240
+#define PHB_MEM_2_LOW		0x02B0
+#define PHB_MEM_2_HIGH		0x02C0
+#define PHB_MEM_2_SIZE_HIGH	0x02D0
+#define PHB_MEM_2_SIZE_LOW	0x02E0
+
+/* PHB_CONFIG_RW */
+#define PHB_TCE_ENABLE		0x20000000
+#define PHB_DAC_DISABLE		0x01000000
+#define PHB_MEM2_ENABLE		0x00400000
+/* TAR (Table Address Register) */
+#define TAR_SW_BITS		0x0000ffffffff800fUL
+#define TAR_VALID		0x0000000000000008UL
+
+#define MAX_NUM_NODES		4 /* max number of NUMA nodes */
+#define MAX_NUM_OF_PHBS		8 /* how many PHBs in total? */
+#define MAX_PHB_BUS_NUM		(MAX_NUM_OF_PHBS * 2) /* max dev->bus->number */
+#define PHBS_PER_CALGARY	4
+
+void* tce_table_kva[MAX_NUM_OF_PHBS * MAX_NUM_NODES];
+unsigned int specified_table_size = TCE_TABLE_SIZE_UNSPECIFIED;
+static int translate_empty_slots __read_mostly = 0;
+static int calgary_detected __read_mostly = 0;
+
+static void tce_cache_blast(struct iommu_table *tbl);
+
+/* enable this to stress test the chip's TCE cache */
+#undef BLAST_TCE_CACHE_ON_UNMAP
+
+#ifdef BLAST_TCE_CACHE_ON_UNMAP
+static inline void tce_cache_blast_stress(struct iommu_table *tbl)
+{
+	tce_cache_blast(tbl);
+}
+#else
+static inline void tce_cache_blast_stress(struct iommu_table *tbl)
+{
+}
+#endif /* BLAST_TCE_CACHE_ON_UNMAP */
+
+static inline unsigned int num_dma_pages(unsigned long dma, unsigned int dmalen)
+{
+	unsigned int npages;
+
+	npages = PAGE_ALIGN(dma + dmalen) - (dma & PAGE_MASK);
+	npages >>= PAGE_SHIFT;
+
+	return npages;
+}
+
+static inline int valid_dma_direction(int dma_direction)
+{
+	return ((dma_direction == DMA_BIDIRECTIONAL) ||
+		(dma_direction == DMA_TO_DEVICE) ||
+		(dma_direction == DMA_FROM_DEVICE));
+}
+
+static void iommu_range_reserve(struct iommu_table *tbl,
+        unsigned long start_addr, unsigned int npages)
+{
+	unsigned long index;
+	unsigned long end;
+
+	index = start_addr >> PAGE_SHIFT;
+
+	/* bail out if we're asked to reserve a region we don't cover */
+	if (index >= tbl->it_size)
+		return;
+
+	end = index + npages;
+	if (end > tbl->it_size) /* don't go off the table */
+		end = tbl->it_size;
+
+	while (index < end) {
+		if (test_bit(index, tbl->it_map))
+			printk(KERN_ERR "Calgary: entry already allocated at "
+			       "0x%lx tbl %p dma 0x%lx npages %u\n",
+			       index, tbl, start_addr, npages);
+		++index;
+	}
+	set_bit_string(tbl->it_map, start_addr >> PAGE_SHIFT, npages);
+}
+
+static unsigned long iommu_range_alloc(struct iommu_table *tbl,
+	unsigned int npages)
+{
+	unsigned long offset;
+
+	BUG_ON(npages == 0);
+
+	offset = find_next_zero_string(tbl->it_map, tbl->it_hint,
+				       tbl->it_size, npages);
+	if (offset == ~0UL) {
+		tce_cache_blast(tbl);
+		offset = find_next_zero_string(tbl->it_map, 0,
+					       tbl->it_size, npages);
+		if (offset == ~0UL)
+			panic("Calgary: IOMMU full, fix the allocator.\n");
+	}
+
+	set_bit_string(tbl->it_map, offset, npages);
+	tbl->it_hint = offset + npages;
+	BUG_ON(tbl->it_hint > tbl->it_size);
+
+	return offset;
+}
+
+static dma_addr_t iommu_alloc(struct iommu_table *tbl, void *vaddr,
+	unsigned int npages, int direction)
+{
+	unsigned long entry, flags;
+	dma_addr_t ret = bad_dma_address;
+
+	spin_lock_irqsave(&tbl->it_lock, flags);
+
+	entry = iommu_range_alloc(tbl, npages);
+
+	ret = entry << PAGE_SHIFT; /* set the return dma address */
+
+	if (unlikely(ret == bad_dma_address))
+		goto error;
+
+	/* put the TCEs in the HW table */
+	tce_build(tbl, entry, npages, (unsigned long)vaddr & PAGE_MASK,
+		  direction);
+	/* make sure HW sees the new TCEs */
+	mb();
+
+	spin_unlock_irqrestore(&tbl->it_lock, flags);
+
+	return ret;
+
+error:
+	spin_unlock_irqrestore(&tbl->it_lock, flags);
+	printk(KERN_WARNING "Calgary: failed to allocate %u pages in "
+	       "iommu %p\n", npages, tbl);
+	return bad_dma_address;
+}
+
+static void __iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
+	unsigned int npages)
+{
+	unsigned long entry;
+	unsigned long i;
+
+	entry = dma_addr >> PAGE_SHIFT;
+
+	BUG_ON(entry + npages > tbl->it_size);
+
+	tce_free(tbl, entry, npages);
+	mb();
+
+	for (i = 0; i < npages; ++i) {
+		if (!test_bit(entry + i, tbl->it_map))
+			printk(KERN_ERR "Calgary: bit is off at 0x%lx "
+			       "tbl %p dma 0x%Lx entry 0x%lx npages %u\n",
+			       entry + i, tbl, dma_addr, entry, npages);
+	}
+
+	__clear_bit_string(tbl->it_map, entry, npages);
+
+	tce_cache_blast_stress(tbl);
+}
+
+static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
+	unsigned int npages)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&tbl->it_lock, flags);
+
+	__iommu_free(tbl, dma_addr, npages);
+
+	spin_unlock_irqrestore(&tbl->it_lock, flags);
+}
+
+static void __calgary_unmap_sg(struct iommu_table *tbl,
+	struct scatterlist *sglist, int nelems, int direction)
+{
+	while (nelems--) {
+		unsigned int npages;
+		dma_addr_t dma = sglist->dma_address;
+		unsigned int dmalen = sglist->dma_length;
+
+		if (dmalen == 0)
+			break;
+
+		npages = num_dma_pages(dma, dmalen);
+		__iommu_free(tbl, dma, npages);
+		sglist++;
+	}
+}
+
+void calgary_unmap_sg(struct device *dev, struct scatterlist *sglist,
+		      int nelems, int direction)
+{
+	unsigned long flags;
+	struct iommu_table *tbl = to_pci_dev(dev)->bus->self->sysdata;
+
+	BUG_ON(!valid_dma_direction(direction));
+	BUG_ON(!tbl);
+
+	spin_lock_irqsave(&tbl->it_lock, flags);
+
+	__calgary_unmap_sg(tbl, sglist, nelems, direction);
+
+	spin_unlock_irqrestore(&tbl->it_lock, flags);
+}
+
+int calgary_map_sg(struct device *dev, struct scatterlist *sg,
+	int nelems, int direction)
+{
+	struct iommu_table *tbl = to_pci_dev(dev)->bus->self->sysdata;
+	unsigned long flags;
+	unsigned long vaddr;
+	unsigned int npages;
+	unsigned long entry;
+	int i;
+
+	BUG_ON(!valid_dma_direction(direction));
+	BUG_ON(!tbl);
+
+	spin_lock_irqsave(&tbl->it_lock, flags);
+
+	for (i = 0; i < nelems; i++ ) {
+		struct scatterlist *s = &sg[i];
+		BUG_ON(!s->page);
+
+		vaddr = (unsigned long)page_address(s->page) + s->offset;
+		npages = num_dma_pages(vaddr, s->length);
+
+		entry = iommu_range_alloc(tbl, npages);
+		if ((entry << PAGE_SHIFT) == bad_dma_address) {
+			s->dma_length = 0; /* makes sure unmap knows to stop */
+			goto error;
+		}
+
+		s->dma_address = (entry << PAGE_SHIFT) | s->offset;
+
+		/* insert into HW table */
+		tce_build(tbl, entry, npages, vaddr & PAGE_MASK, direction);
+
+		s->dma_length = s->length;
+	}
+
+	spin_unlock_irqrestore(&tbl->it_lock, flags);
+
+	/* make sure updates are seen by hardware */
+	mb();
+
+	return nelems;
+error:
+	__calgary_unmap_sg(tbl, sg, nelems, direction);
+	for (i = 0; i < nelems; i++) {
+		sg[i].dma_address = bad_dma_address;
+		sg[i].dma_length = 0;
+	}
+	spin_unlock_irqrestore(&tbl->it_lock, flags);
+	return 0;
+}
+
+dma_addr_t calgary_map_single(struct device *dev, void *vaddr,
+	size_t size, int direction)
+{
+	dma_addr_t dma_handle = bad_dma_address;
+	unsigned long uaddr;
+	unsigned int npages;
+	struct iommu_table *tbl = to_pci_dev(dev)->bus->self->sysdata;
+
+	BUG_ON(!valid_dma_direction(direction));
+	BUG_ON(!tbl);
+
+	uaddr = (unsigned long)vaddr;
+	npages = num_dma_pages(uaddr, size);
+
+	dma_handle = iommu_alloc(tbl, vaddr, npages, direction);
+	if (dma_handle != bad_dma_address)
+		dma_handle |= (uaddr & ~PAGE_MASK);
+
+	return dma_handle;
+}
+
+void calgary_unmap_single(struct device *dev, dma_addr_t dma_handle,
+	size_t size, int direction)
+{
+	struct iommu_table *tbl = to_pci_dev(dev)->bus->self->sysdata;
+	unsigned int npages;
+
+	BUG_ON(!valid_dma_direction(direction));
+	BUG_ON(!tbl);
+
+	npages = num_dma_pages(dma_handle, size);
+	iommu_free(tbl, dma_handle, npages);
+}
+
+void* calgary_alloc_coherent(struct device *dev, size_t size,
+	dma_addr_t *dma_handle, gfp_t flag)
+{
+	void *ret = NULL;
+	dma_addr_t mapping;
+	unsigned int npages, order;
+	struct iommu_table *tbl;
+
+	tbl = to_pci_dev(dev)->bus->self->sysdata;
+	BUG_ON(!tbl);
+
+	size = PAGE_ALIGN(size); /* size rounded up to full pages */
+	npages = size >> PAGE_SHIFT;
+	order = get_order(size);
+
+	/* alloc enough pages (and possibly more) */
+	ret = (void *)__get_free_pages(flag, order);
+	if (!ret)
+		goto error;
+	memset(ret, 0, size);
+
+	/* set up tces to cover the allocated range */
+	mapping = iommu_alloc(tbl, ret, npages, DMA_BIDIRECTIONAL);
+	if (mapping == bad_dma_address)
+		goto free;
+
+	*dma_handle = mapping;
+
+	return ret;
+
+free:
+	free_pages((unsigned long)ret, get_order(size));
+	ret = NULL;
+error:
+	return ret;
+}
+
+static struct dma_mapping_ops calgary_dma_ops = {
+	.alloc_coherent = calgary_alloc_coherent,
+	.map_single = calgary_map_single,
+	.unmap_single = calgary_unmap_single,
+	.map_sg = calgary_map_sg,
+	.unmap_sg = calgary_unmap_sg,
+};
+
+static inline int busno_to_phbid(unsigned char num)
+{
+	return bus_to_phb(num) % PHBS_PER_CALGARY;
+}
+
+static inline unsigned long split_queue_offset(unsigned char num)
+{
+	switch (busno_to_phbid(num)) {
+	case 0: return SPLITQ0_OFFSET;
+	case 1: return SPLITQ1_OFFSET;
+	case 2: return SPLITQ2_OFFSET;
+	case 3: return SPLITQ3_OFFSET;
+	default: BUG();
+	}
+}
+
+static inline unsigned long tar_offset(unsigned char num)
+{
+	switch (busno_to_phbid(num)) {
+	case 0: return TAR0_OFFSET;
+	case 1: return TAR1_OFFSET;
+	case 2: return TAR2_OFFSET;
+	case 3: return TAR3_OFFSET;
+	default: BUG();
+	}
+}
+
+static inline unsigned long phb_offset(unsigned char num)
+{
+	switch (busno_to_phbid(num)) {
+	case 0: return PHB0_OFFSET;
+	case 1: return PHB1_OFFSET;
+	case 2: return PHB2_OFFSET;
+	case 3: return PHB3_OFFSET;
+	default: BUG();
+	}
+}
+
+static inline void __iomem* calgary_reg(void __iomem *bar, unsigned long offset)
+{
+	unsigned long target = ((unsigned long)bar) | offset;
+	return (void __iomem*)target;
+}
+
+static void tce_cache_blast(struct iommu_table *tbl)
+{
+	u64 val;
+	u32 aer;
+	int i = 0;
+	void __iomem *bbar = tbl->bbar;
+	void __iomem *target;
+
+	/* disable arbitration on the bus */
+	target = calgary_reg(bbar, phb_offset(tbl->it_busno) | PHB_AER_OFFSET);
+	aer = readl(target);
+	writel(0, target);
+
+	/* read plssr to ensure it got there */
+	target = calgary_reg(bbar, phb_offset(tbl->it_busno) | PHB_PLSSR_OFFSET);
+	val = readl(target);
+
+	/* poll split queues until all DMA activity is done */
+	target = calgary_reg(bbar, split_queue_offset(tbl->it_busno));
+	do {
+		val = readq(target);
+		i++;
+	} while ((val & 0xff) != 0xff && i < 100);
+	if (i == 100)
+		printk(KERN_WARNING "Calgary: PCI bus not quiesced, "
+		       "continuing anyway\n");
+
+	/* invalidate TCE cache */
+	target = calgary_reg(bbar, tar_offset(tbl->it_busno));
+	writeq(tbl->tar_val, target);
+
+	/* enable arbitration */
+	target = calgary_reg(bbar, phb_offset(tbl->it_busno) | PHB_AER_OFFSET);
+	writel(aer, target);
+	(void)readl(target); /* flush */
+}
+
+static void __init calgary_reserve_mem_region(struct pci_dev *dev, u64 start,
+	u64 limit)
+{
+	unsigned int numpages;
+
+	limit = limit | 0xfffff;
+	limit++;
+
+	numpages = ((limit - start) >> PAGE_SHIFT);
+	iommu_range_reserve(dev->sysdata, start, numpages);
+}
+
+static void __init calgary_reserve_peripheral_mem_1(struct pci_dev *dev)
+{
+	void __iomem *target;
+	u64 low, high, sizelow;
+	u64 start, limit;
+	struct iommu_table *tbl = dev->sysdata;
+	unsigned char busnum = dev->bus->number;
+	void __iomem *bbar = tbl->bbar;
+
+	/* peripheral MEM_1 region */
+	target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_1_LOW);
+	low = be32_to_cpu(readl(target));
+	target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_1_HIGH);
+	high = be32_to_cpu(readl(target));
+	target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_1_SIZE);
+	sizelow = be32_to_cpu(readl(target));
+
+	start = (high << 32) | low;
+	limit = sizelow;
+
+	calgary_reserve_mem_region(dev, start, limit);
+}
+
+static void __init calgary_reserve_peripheral_mem_2(struct pci_dev *dev)
+{
+	void __iomem *target;
+	u32 val32;
+	u64 low, high, sizelow, sizehigh;
+	u64 start, limit;
+	struct iommu_table *tbl = dev->sysdata;
+	unsigned char busnum = dev->bus->number;
+	void __iomem *bbar = tbl->bbar;
+
+	/* is it enabled? */
+	target = calgary_reg(bbar, phb_offset(busnum) | PHB_CONFIG_RW_OFFSET);
+	val32 = be32_to_cpu(readl(target));
+	if (!(val32 & PHB_MEM2_ENABLE))
+		return;
+
+	target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_2_LOW);
+	low = be32_to_cpu(readl(target));
+	target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_2_HIGH);
+	high = be32_to_cpu(readl(target));
+	target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_2_SIZE_LOW);
+	sizelow = be32_to_cpu(readl(target));
+	target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_2_SIZE_HIGH);
+	sizehigh = be32_to_cpu(readl(target));
+
+	start = (high << 32) | low;
+	limit = (sizehigh << 32) | sizelow;
+
+	calgary_reserve_mem_region(dev, start, limit);
+}
+
+static void __init calgary_reserve_regions(struct pci_dev *dev)
+{
+	unsigned int npages;
+	void __iomem *bbar;
+	unsigned char busnum;
+	u64 start;
+	struct iommu_table *tbl = dev->sysdata;
+
+	bbar = tbl->bbar;
+	busnum = dev->bus->number;
+
+	/* reserve bad_dma_address in case it's a legal address */
+	iommu_range_reserve(tbl, bad_dma_address, 1);
+
+	/* avoid the BIOS/VGA first 640KB-1MB region */
+	start = (640 * 1024);
+	npages = ((1024 - 640) * 1024) >> PAGE_SHIFT;
+	iommu_range_reserve(tbl, start, npages);
+
+	calgary_reserve_peripheral_mem_1(dev);
+	calgary_reserve_peripheral_mem_2(dev);
+}
+
+static int __init calgary_setup_tar(struct pci_dev *dev, void __iomem *bbar)
+{
+	u64 val64;
+	u64 table_phys;
+	void __iomem *target;
+	int ret;
+	struct iommu_table *tbl;
+
+	/* build TCE tables for each PHB */
+	ret = build_tce_table(dev, bbar);
+	if (ret)
+		goto done;
+
+	calgary_reserve_regions(dev);
+
+	/* set TARs for each PHB */
+	target = calgary_reg(bbar, tar_offset(dev->bus->number));
+	val64 = be64_to_cpu(readq(target));
+
+	/* zero out all TAR bits under sw control */
+	val64 &= ~TAR_SW_BITS;
+
+	tbl = dev->sysdata;
+	table_phys = (u64)__pa(tbl->it_base);
+	val64 |= table_phys;
+
+	BUG_ON(specified_table_size > TCE_TABLE_SIZE_8M);
+	val64 |= (u64) specified_table_size;
+
+	tbl->tar_val = cpu_to_be64(val64);
+	writeq(tbl->tar_val, target);
+	readq(target); /* flush */
+
+	return 0;
+
+done:
+	return ret;
+}
+
+static void __init calgary_free_tar(struct pci_dev *dev)
+{
+	u64 val64;
+	struct iommu_table *tbl = dev->sysdata;
+	void __iomem *target;
+
+	target = calgary_reg(tbl->bbar, tar_offset(dev->bus->number));
+	val64 = be64_to_cpu(readq(target));
+	val64 &= ~TAR_SW_BITS;
+	writeq(cpu_to_be64(val64), target);
+	readq(target); /* flush */
+
+	kfree(tbl);
+	dev->sysdata = NULL;
+}
+
+static void __init calgary_enable_translation(struct pci_dev *dev)
+{
+	u32 val32;
+	unsigned char busnum;
+	void __iomem *target;
+	void __iomem *bbar;
+	struct iommu_table *tbl;
+
+	busnum = dev->bus->number;
+	tbl = dev->sysdata;
+	bbar = tbl->bbar;
+
+	/* enable TCE in PHB Config Register */
+	target = calgary_reg(bbar, phb_offset(busnum) | PHB_CONFIG_RW_OFFSET);
+	val32 = be32_to_cpu(readl(target));
+	val32 |= PHB_TCE_ENABLE | PHB_DAC_DISABLE;
+
+	printk(KERN_INFO "Calgary: enabling translation on PHB %d!\n", busnum);
+	writel(cpu_to_be32(val32), target);
+	readl(target); /* flush */
+}
+
+static void __init calgary_disable_translation(struct pci_dev *dev)
+{
+	u32 val32;
+	unsigned char busnum;
+	void __iomem *target;
+	void __iomem *bbar;
+	struct iommu_table *tbl;
+
+	busnum = dev->bus->number;
+	tbl = dev->sysdata;
+	bbar = tbl->bbar;
+
+	/* disable TCE in PHB Config Register */
+	target = calgary_reg(bbar, phb_offset(busnum) | PHB_CONFIG_RW_OFFSET);
+	val32 = be32_to_cpu(readl(target));
+	val32 &= ~(PHB_TCE_ENABLE | PHB_DAC_DISABLE);
+
+	printk(KERN_INFO "Calgary: disabling translation on PHB %d!\n", busnum);
+	writel(cpu_to_be32(val32), target);
+	readl(target); /* flush */
+}
+
+static inline unsigned int __init locate_register_space(struct pci_dev *dev)
+{
+	int nodeid;
+	u32 address;
+
+	nodeid = (dev->bus->number % 15 > 4) ? 3 : 2;
+	/*
+	 * FE0MB-8MB*OneBasedChassisNumber+1MB*(RioNodeId-ChassisBase)
+	 * ChassisBase is always zero for x366/x260/x460
+	 * RioNodeId is 2 for first Calgary, 3 for second Calgary
+	 */
+	address = 0xfe000000 - (0x800000 * (1 + dev->bus->number / 15)) +
+		(0x100000) * (nodeid - 0);
+	return address;
+}
+
+static int __init calgary_init_one(struct pci_dev *dev)
+{
+	u32 address;
+	void __iomem *bbar;
+	int ret;
+
+	address = locate_register_space(dev);
+	/* map entire 1MB of Calgary config space */
+	bbar = ioremap(address, 1024 * 1024);
+	if (!bbar) {
+		ret = -ENODATA;
+		goto done;
+	}
+
+	ret = calgary_setup_tar(dev, bbar);
+	if (ret)
+		goto iounmap;
+
+	dev->bus->self = dev;
+	calgary_enable_translation(dev);
+
+	return 0;
+
+iounmap:
+	iounmap(bbar);
+done:
+	return ret;
+}
+
+static int __init calgary_init(void)
+{
+	int i, ret = -ENODEV;
+	struct pci_dev *dev = NULL;
+
+	for (i = 0; i < MAX_NUM_OF_PHBS * MAX_NUM_NODES; i++) {
+		dev = pci_get_device(PCI_VENDOR_ID_IBM, PCI_DEVICE_ID_IBM_CALGARY, dev);
+		if (!dev)
+			break;
+		if (!tce_table_kva[i] && !translate_empty_slots)
+			continue;
+		ret = calgary_init_one(dev);
+		if (ret)
+			goto error;
+	}
+
+	return ret;
+
+error:
+	for (i--; i >= 0; i--) {
+		dev = pci_find_device_reverse(PCI_VENDOR_ID_IBM,
+					      PCI_DEVICE_ID_IBM_CALGARY,
+					      dev);
+		if (!tce_table_kva[i] && !translate_empty_slots)
+			continue;
+		calgary_disable_translation(dev);
+		calgary_free_tar(dev);
+	}
+
+	return ret;
+}
+
+static inline int __init determine_tce_table_size(u64 ram)
+{
+	int ret;
+
+	if (specified_table_size != TCE_TABLE_SIZE_UNSPECIFIED)
+		return specified_table_size;
+
+	/*
+	 * Table sizes are from 0 to 7 (TCE_TABLE_SIZE_64K to
+	 * TCE_TABLE_SIZE_8M). Table size 0 has 8K entries and each
+	 * larger table size has twice as many entries, so shift the
+	 * max ram address by 13 to divide by 8K and then look at the
+	 * order of the result to choose between 0-7.
+	 */
+	ret = get_order(ram >> 13);
+	if (ret > TCE_TABLE_SIZE_8M)
+		ret = TCE_TABLE_SIZE_8M;
+
+	return ret;
+}
+
+void __init detect_calgary(void)
+{
+	u32 val;
+	int bus, calgary;
+	void *tbl;
+
+	/*
+	 * if the user specified iommu=off or iommu=soft or we found
+	 * another HW IOMMU already, bail out.
+	 */
+	if (swiotlb || no_iommu || iommu_detected)
+		return;
+
+	printk(KERN_INFO "PCI-DMA: detecting Calgary chipset...\n");
+
+	specified_table_size = determine_tce_table_size(end_pfn * PAGE_SIZE);
+
+	for (bus = 0, calgary = 0;
+	     bus < MAX_NUM_OF_PHBS * num_online_nodes() * 2;
+	     bus++) {
+		BUG_ON(bus >= MAX_PHB_BUS_NUM * MAX_NUM_NODES);
+		if (read_pci_config(bus, 0, 0, 0) != PCI_VENDOR_DEVICE_ID_CALGARY)
+			continue;
+		/*
+		 * scan the first slot of the PCI bus to see if there
+		 * are any devices present
+		 */
+		val = read_pci_config(bus, 1, 0, 0);
+		if (val != 0xffffffff || translate_empty_slots) {
+			tbl = alloc_tce_table();
+			if (!tbl)
+				goto cleanup;
+		} else
+			tbl = NULL;
+
+		tce_table_kva[calgary] = tbl;
+		calgary++;
+	}
+
+	if (calgary) {
+		iommu_detected = 1;
+		calgary_detected = 1;
+		printk(KERN_INFO "PCI-DMA: Calgary IOMMU detected. "
+		       "TCE table spec is %d.\n", specified_table_size);
+	}
+	return;
+
+cleanup:
+	for (--calgary; calgary >= 0; --calgary)
+		free_tce_table(tce_table_kva[calgary]);
+}
+
+int __init calgary_iommu_init(void)
+{
+	int ret;
+
+	if (!calgary_detected || no_iommu || swiotlb)
+		return 0;
+
+	printk(KERN_INFO "PCI-DMA: Using Calgary IOMMU\n");
+
+	ret = calgary_init();
+	if (ret) {
+		printk(KERN_ERR "PCI-DMA: Calgary init failed %x, "
+		       "falling back to no_iommu\n", ret);
+		if (end_pfn > MAX_DMA32_PFN)
+			printk(KERN_ERR "WARNING more than 4GB of memory, "
+					"32bit PCI may malfunction.\n");
+		return ret;
+	}
+
+	force_iommu = 1;
+	dma_ops = &calgary_dma_ops;
+
+	return ret;
+}
+
+void __init calgary_parse_options(char *p)
+{
+	while (*p) {
+		if (!strncmp(p, "64k", 3))
+			specified_table_size = TCE_TABLE_SIZE_64K;
+		else if (!strncmp(p, "128k", 4))
+			specified_table_size = TCE_TABLE_SIZE_128K;
+		else if (!strncmp(p, "256k", 4))
+			specified_table_size = TCE_TABLE_SIZE_256K;
+		else if (!strncmp(p, "512k", 4))
+			specified_table_size = TCE_TABLE_SIZE_512K;
+		else if (!strncmp(p, "1M", 2))
+			specified_table_size = TCE_TABLE_SIZE_1M;
+		else if (!strncmp(p, "2M", 2))
+			specified_table_size = TCE_TABLE_SIZE_2M;
+		else if (!strncmp(p, "4M", 2))
+			specified_table_size = TCE_TABLE_SIZE_4M;
+		else if (!strncmp(p, "8M", 2))
+			specified_table_size = TCE_TABLE_SIZE_8M;
+
+		if (!strncmp(p, "translate_empty_slots", 19))
+			translate_empty_slots = 1;
+
+		p += strcspn(p, ",");
+		if (*p == ',')
+			++p;
+	}
+}
diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/arch/x86_64/kernel/tce.c linux/arch/x86_64/kernel/tce.c
--- iommu_detected/arch/x86_64/kernel/tce.c	1970-01-01 02:00:00.000000000 +0200
+++ linux/arch/x86_64/kernel/tce.c	2006-03-12 09:48:55.000000000 +0200
@@ -0,0 +1,188 @@
+/*
+ * Derived from arch/powerpc/platforms/pseries/iommu.c
+ *
+ * Copyright (C) 2006 Jon Mason <jdmason@us.ibm.com>, IBM Corporation
+ * Copyright (C) 2006 Muli Ben-Yehuda <mulix@mulix.org>, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/bootmem.h>
+#include <asm/tce.h>
+#include <asm/calgary.h>
+#include <asm/proto.h>
+
+void tce_build(struct iommu_table *tbl, unsigned long index,
+	unsigned int npages, unsigned long uaddr, int direction)
+{
+	union tce_entry *tp;
+	union tce_entry t;
+
+	t.te_word = 0;
+	t.bits.read = 1;
+	t.bits.write = (direction != DMA_TO_DEVICE);
+
+	tp = ((union tce_entry *)tbl->it_base) + index;
+
+	while (npages--) {
+		t.bits.rpn = (virt_to_bus((void*)uaddr)) >> PAGE_SHIFT;
+		tp->te_word = cpu_to_be64(t.te_word);
+
+		uaddr += PAGE_SIZE;
+		tp++;
+	}
+}
+
+void tce_free(struct iommu_table *tbl, long index, unsigned int npages)
+{
+	union tce_entry *tp;
+
+	tp  = ((union tce_entry *)tbl->it_base) + index;
+
+	while (npages--) {
+		tp->te_word = cpu_to_be64(0);
+		tp++;
+	}
+}
+
+static inline unsigned int table_size_to_number_of_entries(unsigned char size)
+{
+	/*
+	 * size is the order of the table, 0-7
+	 * smallest table is 8K entries, so shift result by 13 to
+	 * multiply by 8K
+	 */
+	return (1 << size) << 13;
+}
+
+static int tce_table_setparms(struct pci_dev *dev, struct iommu_table *tbl)
+{
+	unsigned int bitmapsz;
+	unsigned int tce_table_index;
+	unsigned long bmppages;
+	int ret;
+
+	tbl->it_busno = dev->bus->number;
+
+	/* set the tce table size - measured in entries */
+	tbl->it_size = table_size_to_number_of_entries(specified_table_size);
+
+	tce_table_index = bus_to_phb(tbl->it_busno);
+	tbl->it_base = (unsigned long)tce_table_kva[tce_table_index];
+	if (!tbl->it_base) {
+		printk(KERN_ERR "Calgary: iommu_table_setparms: "
+		       "no table allocated?!\n");
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	/*
+	 * number of bytes needed for the bitmap size in number of
+	 * entries; we need one bit per entry
+	 */
+	bitmapsz = tbl->it_size / BITS_PER_BYTE;
+	bmppages = __get_free_pages(GFP_KERNEL, get_order(bitmapsz));
+	if (!bmppages) {
+		printk(KERN_ERR "Calgary: cannot allocate bitmap\n");
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	tbl->it_map = (unsigned long*)bmppages;
+
+	memset(tbl->it_map, 0, bitmapsz);
+
+	tbl->it_hint = 0;
+
+	spin_lock_init(&tbl->it_lock);
+
+	return 0;
+
+done:
+	return ret;
+}
+
+int build_tce_table(struct pci_dev *dev, void __iomem *bbar)
+{
+	struct iommu_table *tbl;
+	int ret;
+
+	if (dev->sysdata) {
+		printk(KERN_ERR "Calgary: dev %p has sysdata %p\n",
+		       dev, dev->sysdata);
+		BUG();
+	}
+
+	tbl = kzalloc(sizeof(struct iommu_table), GFP_KERNEL);
+	if (!tbl) {
+		printk(KERN_ERR "Calgary: error allocating iommu_table\n");
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	ret = tce_table_setparms(dev, tbl);
+	if (ret)
+		goto free_tbl;
+
+	tce_free(tbl, 0, tbl->it_size);
+	mb(); /* flush TCE table update */
+
+	tbl->bbar = bbar;
+	dev->sysdata = tbl;
+
+	return 0;
+
+free_tbl:
+	kfree(tbl);
+done:
+	return ret;
+}
+
+void* alloc_tce_table(void)
+{
+	void *p;
+	unsigned int size;
+
+	size = table_size_to_number_of_entries(specified_table_size);
+	size *= sizeof(union tce_entry);
+
+	p = __alloc_bootmem_low(size, size, 0);
+	if (!p)
+		printk(KERN_ERR "Calgary: cannot allocate TCE table of "
+		       "size 0x%x\n", size);
+
+	return p;
+}
+
+void free_tce_table(void *tbl)
+{
+	unsigned int size;
+
+	if (!tbl)
+		return;
+
+	size = table_size_to_number_of_entries(specified_table_size);
+	size *= sizeof(union tce_entry);
+
+	free_bootmem(__pa(tbl), size);
+}
diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/include/asm-x86_64/calgary.h linux/include/asm-x86_64/calgary.h
--- iommu_detected/include/asm-x86_64/calgary.h	1970-01-01 02:00:00.000000000 +0200
+++ linux/include/asm-x86_64/calgary.h	2006-03-09 09:52:53.000000000 +0200
@@ -0,0 +1,64 @@
+/*
+ * Derived from include/asm-powerpc/iommu.h
+ *
+ * Copyright (C) 2006 Jon Mason <jdmason@us.ibm.com>, IBM Corporation
+ * Copyright (C) 2006 Muli Ben-Yehuda <mulix@mulix.org>, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#ifndef _ASM_X86_64_CALGARY_H
+#define _ASM_X86_64_CALGARY_H
+
+#include <linux/config.h>
+#include <linux/spinlock.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <asm/types.h>
+
+struct iommu_table {
+	unsigned long  it_base;      /* mapped address of tce table */
+	unsigned long  it_hint;      /* Hint for next alloc */
+	unsigned long *it_map;       /* A simple allocation bitmap for now */
+	spinlock_t     it_lock;      /* Protects it_map */
+	unsigned int   it_size;      /* Size of iommu table in entries */
+	unsigned char  it_busno;     /* Bus number this table belongs to */
+	void __iomem  *bbar;
+	u64	       tar_val;
+};
+
+#define TCE_TABLE_SIZE_UNSPECIFIED	~0
+#define TCE_TABLE_SIZE_64K		0
+#define TCE_TABLE_SIZE_128K		1
+#define TCE_TABLE_SIZE_256K		2
+#define TCE_TABLE_SIZE_512K		3
+#define TCE_TABLE_SIZE_1M		4
+#define TCE_TABLE_SIZE_2M		5
+#define TCE_TABLE_SIZE_4M		6
+#define TCE_TABLE_SIZE_8M		7
+
+struct scatterlist;
+struct device_node;
+
+extern void calgary_parse_options(char *);
+extern void iommu_init_table(struct iommu_table *tbl);
+extern int calgary_iommu_init(void);
+
+static inline unsigned int bus_to_phb(unsigned char busno)
+{
+	return ((busno % 15 == 0) ? 0 : busno / 2 + 1);
+}
+
+#endif /* _ASM_X86_64_CALGARY_H */
diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/include/asm-x86_64/tce.h linux/include/asm-x86_64/tce.h
--- iommu_detected/include/asm-x86_64/tce.h	1970-01-01 02:00:00.000000000 +0200
+++ linux/include/asm-x86_64/tce.h	2006-03-09 09:52:53.000000000 +0200
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2006 Muli Ben-Yehuda <mulix@mulix.org>, IBM Corporation
+ * Copyright (C) 2006 Jon Mason <jdmason@us.ibm.com>, IBM Corporation
+ *
+ * This file is derived from asm-powerpc/tce.h.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#ifndef _ASM_X86_64_TCE_H
+#define _ASM_X86_64_TCE_H
+
+extern void* tce_table_kva[];
+extern unsigned int specified_table_size;
+struct iommu_table;
+
+union tce_entry {
+   	u64 te_word;
+	struct {
+		unsigned int  read     :1;   /* read allowed */
+		unsigned int  write    :1;   /* write allowed */
+		unsigned int  hubid    :6;   /* hub id - unused */
+		unsigned int  rsvd     :4;   /* reserved */
+		unsigned long rpn      :36;  /* Real page number */
+		unsigned int  unused   :16;  /* unused */
+	} bits;
+};
+
+extern void tce_build(struct iommu_table *tbl, unsigned long index,
+        unsigned int npages, unsigned long uaddr, int direction);
+extern void tce_free(struct iommu_table *tbl, long index, unsigned int npages);
+extern void* alloc_tce_table(void);
+extern void free_tce_table(void *tbl);
+extern int build_tce_table(struct pci_dev *dev, void __iomem *bbar);
+
+#endif /* _ASM_X86_64_TCE_H */

-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

