Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271570AbRHPM33>; Thu, 16 Aug 2001 08:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271571AbRHPM3O>; Thu, 16 Aug 2001 08:29:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:65162 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S271570AbRHPM2p>;
	Thu, 16 Aug 2001 08:28:45 -0400
Date: Thu, 16 Aug 2001 05:28:47 -0700 (PDT)
Message-Id: <20010816.052847.89277778.davem@redhat.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: kill alt_address (Re: [patch] zero-bounce highmem I/O)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20010816135150.X4352@suse.de>
In-Reply-To: <20010815.070204.39155321.davem@redhat.com>
	<20010815.072548.48531893.davem@redhat.com>
	<20010816135150.X4352@suse.de>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jens Axboe <axboe@suse.de>
   Date: Thu, 16 Aug 2001 13:51:50 +0200

   On Wed, Aug 15 2001, David S. Miller wrote:
   > As promised.  I actually got bored during the build and tried to
   
   Looks good! And works here too, even... ->

Ok, here is my current patch, it kills off alt_address as well
as provide the new PCI dma interfaces.

I have no way to test the alt_address stuff here locally, and I'd
be happy if someone would give it a go.  All I guarentee is that
it builds here on my machines :-)

--- ./arch/alpha/kernel/pci_iommu.c.~1~	Sun Aug 12 23:50:25 2001
+++ ./arch/alpha/kernel/pci_iommu.c	Wed Aug 15 03:04:24 2001
@@ -636,7 +636,7 @@
    supported properly.  */
 
 int
-pci_dma_supported(struct pci_dev *pdev, dma_addr_t mask)
+pci_dma_supported(struct pci_dev *pdev, u64 mask)
 {
 	struct pci_controller *hose;
 	struct pci_iommu_arena *arena;
--- ./arch/sparc64/kernel/pci_iommu.c.~1~	Wed May 23 17:57:03 2001
+++ ./arch/sparc64/kernel/pci_iommu.c	Wed Aug 15 06:40:54 2001
@@ -356,6 +356,20 @@
 	return 0;
 }
 
+dma64_addr_t pci64_map_page(struct pci_dev *pdev,
+			    struct page *page, unsigned long offset,
+			    size_t sz, int direction)
+{
+	if (!(pdev->dma_flags & PCI_DMA_FLAG_HUGE_MAPS)) {
+		return (dma64_addr_t)
+			pci_map_single(pdev,
+				       page_address(page) + offset,
+				       sz, direction);
+	}
+
+	return PCI64_ADDR_BASE + (__pa(page_address(page)) + offset);
+}
+
 /* Unmap a single streaming mode DMA translation. */
 void pci_unmap_single(struct pci_dev *pdev, dma_addr_t bus_addr, size_t sz, int direction)
 {
@@ -378,7 +392,8 @@
 		((bus_addr - iommu->page_table_map_base) >> PAGE_SHIFT);
 #ifdef DEBUG_PCI_IOMMU
 	if (iopte_val(*base) == IOPTE_INVALID)
-		printk("pci_unmap_single called on non-mapped region %08x,%08x from %016lx\n", bus_addr, sz, __builtin_return_address(0));
+		printk("pci_unmap_single called on non-mapped region %08x,%08x from %016lx\n",
+		       bus_addr, sz, __builtin_return_address(0));
 #endif
 	bus_addr &= PAGE_MASK;
 
@@ -423,18 +438,38 @@
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
-static inline void fill_sg(iopte_t *iopte, struct scatterlist *sg, int nused, unsigned long iopte_protection)
+void pci64_unmap_page(struct pci_dev *pdev, dma64_addr_t bus_addr,
+		      size_t sz, int direction)
+{
+	if (!(pdev->dma_flags & PCI_DMA_FLAG_HUGE_MAPS)) {
+		if ((bus_addr >> 32) != (dma64_addr_t) 0)
+			BUG();
+
+		return pci_unmap_single(pdev, (dma_addr_t) bus_addr,
+					sz, direction);
+	}
+
+	/* If doing real DAC, there is nothing to do. */
+}
+
+#define SG_ENT_PHYS_ADDRESS(SG)	\
+	((SG)->address ? \
+	 __pa((SG)->address) : \
+	 (__pa(page_address((SG)->page)) + (SG)->offset))
+
+static inline void fill_sg(iopte_t *iopte, struct scatterlist *sg,
+			   int nused, unsigned long iopte_protection)
 {
 	struct scatterlist *dma_sg = sg;
 	int i;
 
 	for (i = 0; i < nused; i++) {
 		unsigned long pteval = ~0UL;
-		u32 dma_npages;
+		u64 dma_npages;
 
-		dma_npages = ((dma_sg->dvma_address & (PAGE_SIZE - 1UL)) +
-			      dma_sg->dvma_length +
-			      ((u32)(PAGE_SIZE - 1UL))) >> PAGE_SHIFT;
+		dma_npages = ((dma_sg->dma_address & (PAGE_SIZE - 1UL)) +
+			      dma_sg->dma_length +
+			      ((PAGE_SIZE - 1UL))) >> PAGE_SHIFT;
 		do {
 			unsigned long offset;
 			signed int len;
@@ -447,7 +482,7 @@
 			for (;;) {
 				unsigned long tmp;
 
-				tmp = (unsigned long) __pa(sg->address);
+				tmp = SG_ENT_PHYS_ADDRESS(sg);
 				len = sg->length;
 				if (((tmp ^ pteval) >> PAGE_SHIFT) != 0UL) {
 					pteval = tmp & PAGE_MASK;
@@ -480,9 +515,9 @@
 			 * detect a page crossing event.
 			 */
 			while ((pteval << (64 - PAGE_SHIFT)) != 0UL &&
-			       pteval == __pa(sg->address) &&
+			       (pteval == SG_ENT_PHYS_ADDRESS(sg)) &&
 			       ((pteval ^
-				 (__pa(sg->address) + sg->length - 1UL)) >> PAGE_SHIFT) == 0UL) {
+				 (SG_ENT_PHYS_ADDRESS(sg) + sg->length - 1UL)) >> PAGE_SHIFT) == 0UL) {
 				pteval += sg->length;
 				sg++;
 			}
@@ -505,14 +540,19 @@
 	struct pci_strbuf *strbuf;
 	unsigned long flags, ctx, npages, iopte_protection;
 	iopte_t *base;
-	u32 dma_base;
+	u64 dma_base;
 	struct scatterlist *sgtmp;
 	int used;
 
 	/* Fast path single entry scatterlists. */
 	if (nelems == 1) {
-		sglist->dvma_address = pci_map_single(pdev, sglist->address, sglist->length, direction);
-		sglist->dvma_length = sglist->length;
+		sglist->dma_address = (dma64_addr_t)
+			pci_map_single(pdev,
+				       (sglist->address ?
+					sglist->address :
+					(page_address(sglist->page) + sglist->offset)),
+				       sglist->length, direction);
+		sglist->dma_length = sglist->length;
 		return 1;
 	}
 
@@ -540,8 +580,8 @@
 	used = nelems;
 
 	sgtmp = sglist;
-	while (used && sgtmp->dvma_length) {
-		sgtmp->dvma_address += dma_base;
+	while (used && sgtmp->dma_length) {
+		sgtmp->dma_address += dma_base;
 		sgtmp++;
 		used--;
 	}
@@ -574,6 +614,23 @@
 	return 0;
 }
 
+int pci64_map_sg(struct pci_dev *pdev, struct scatterlist *sg,
+		 int nelems, int direction)
+{
+	if ((pdev->dma_flags & PCI_DMA_FLAG_HUGE_MAPS) != 0) {
+		int i;
+
+		for (i = 0; i < nelems; i++) {
+			sg[i].dma_address =
+				PCI64_ADDR_BASE + SG_ENT_PHYS_ADDRESS(&sg[i]);
+			sg[i].dma_length = sg[i].length;
+		}
+		return nelems;
+	}
+
+	return pci_map_sg(pdev, sg, nelems, direction);
+}
+
 /* Unmap a set of streaming mode DMA translations. */
 void pci_unmap_sg(struct pci_dev *pdev, struct scatterlist *sglist, int nelems, int direction)
 {
@@ -582,7 +639,7 @@
 	struct pci_strbuf *strbuf;
 	iopte_t *base;
 	unsigned long flags, ctx, i, npages;
-	u32 bus_addr;
+	u64 bus_addr;
 
 	if (direction == PCI_DMA_NONE)
 		BUG();
@@ -591,20 +648,21 @@
 	iommu = pcp->pbm->iommu;
 	strbuf = &pcp->pbm->stc;
 	
-	bus_addr = sglist->dvma_address & PAGE_MASK;
+	bus_addr = sglist->dma_address & PAGE_MASK;
 
 	for (i = 1; i < nelems; i++)
-		if (sglist[i].dvma_length == 0)
+		if (sglist[i].dma_length == 0)
 			break;
 	i--;
-	npages = (PAGE_ALIGN(sglist[i].dvma_address + sglist[i].dvma_length) - bus_addr) >> PAGE_SHIFT;
+	npages = (PAGE_ALIGN(sglist[i].dma_address + sglist[i].dma_length) - bus_addr) >> PAGE_SHIFT;
 
 	base = iommu->page_table +
 		((bus_addr - iommu->page_table_map_base) >> PAGE_SHIFT);
 
 #ifdef DEBUG_PCI_IOMMU
 	if (iopte_val(*base) == IOPTE_INVALID)
-		printk("pci_unmap_sg called on non-mapped region %08x,%d from %016lx\n", sglist->dvma_address, nelems, __builtin_return_address(0));
+		printk("pci_unmap_sg called on non-mapped region %016lx,%d from %016lx\n",
+		       sglist->dma_address, nelems, __builtin_return_address(0));
 #endif
 
 	spin_lock_irqsave(&iommu->lock, flags);
@@ -616,7 +674,7 @@
 
 	/* Step 1: Kick data out of streaming buffers if necessary. */
 	if (strbuf->strbuf_enabled) {
-		u32 vaddr = bus_addr;
+		u32 vaddr = (u32) bus_addr;
 
 		PCI_STC_FLUSHFLAG_INIT(strbuf);
 		if (strbuf->strbuf_ctxflush &&
@@ -648,6 +706,15 @@
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
+void pci64_unmap_sg(struct pci_dev *pdev, struct scatterlist *sglist,
+		    int nelems, int direction)
+{
+	if (!(pdev->dma_flags & PCI_DMA_FLAG_HUGE_MAPS))
+		return pci_unmap_sg(pdev, sglist, nelems, direction);
+
+	/* If doing real DAC, there is nothing to do. */
+}
+
 /* Make physical memory consistent for a single
  * streaming mode DMA translation after a transfer.
  */
@@ -709,6 +776,20 @@
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
+void pci64_dma_sync_single(struct pci_dev *pdev, dma64_addr_t bus_addr,
+			   size_t sz, int direction)
+{
+	if (!(pdev->dma_flags & PCI_DMA_FLAG_HUGE_MAPS)) {
+		if ((bus_addr >> 32) != (dma64_addr_t) 0)
+			BUG();
+
+		return pci_dma_sync_single(pdev, (dma_addr_t) bus_addr,
+					   sz, direction);
+	}
+
+	/* If doing real DAC, there is nothing to do. */
+}
+
 /* Make physical memory consistent for a set of streaming
  * mode DMA translations after a transfer.
  */
@@ -735,7 +816,7 @@
 		iopte_t *iopte;
 
 		iopte = iommu->page_table +
-			((sglist[0].dvma_address - iommu->page_table_map_base) >> PAGE_SHIFT);
+			((sglist[0].dma_address - iommu->page_table_map_base) >> PAGE_SHIFT);
 		ctx = (iopte_val(*iopte) & IOPTE_CONTEXT) >> 47UL;
 	}
 
@@ -752,15 +833,15 @@
 		} while (((long)pci_iommu_read(matchreg)) < 0L);
 	} else {
 		unsigned long i, npages;
-		u32 bus_addr;
+		u64 bus_addr;
 
-		bus_addr = sglist[0].dvma_address & PAGE_MASK;
+		bus_addr = sglist[0].dma_address & PAGE_MASK;
 
 		for(i = 1; i < nelems; i++)
-			if (!sglist[i].dvma_length)
+			if (!sglist[i].dma_length)
 				break;
 		i--;
-		npages = (PAGE_ALIGN(sglist[i].dvma_address + sglist[i].dvma_length) - bus_addr) >> PAGE_SHIFT;
+		npages = (PAGE_ALIGN(sglist[i].dma_address + sglist[i].dma_length) - bus_addr) >> PAGE_SHIFT;
 		for (i = 0; i < npages; i++, bus_addr += PAGE_SIZE)
 			pci_iommu_write(strbuf->strbuf_pflush, bus_addr);
 	}
@@ -774,10 +855,19 @@
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
-int pci_dma_supported(struct pci_dev *pdev, dma_addr_t device_mask)
+void pci64_dma_sync_sg(struct pci_dev *pdev, struct scatterlist *sglist,
+		       int nelems, int direction)
+{
+	if (!(pdev->dma_flags & PCI_DMA_FLAG_HUGE_MAPS))
+		return pci_dma_sync_sg(pdev, sglist, nelems, direction);
+
+	/* If doing real DAC, there is nothing to do. */
+}
+
+int pci_dma_supported(struct pci_dev *pdev, u64 device_mask)
 {
 	struct pcidev_cookie *pcp = pdev->sysdata;
-	u32 dma_addr_mask;
+	u64 dma_addr_mask;
 
 	if (pdev == NULL) {
 		dma_addr_mask = 0xffffffff;
--- ./arch/sparc64/kernel/iommu_common.c.~1~	Tue Nov 28 08:33:08 2000
+++ ./arch/sparc64/kernel/iommu_common.c	Wed Aug 15 05:13:34 2001
@@ -12,7 +12,7 @@
  */
 
 #ifdef VERIFY_SG
-int verify_lengths(struct scatterlist *sg, int nents, int npages)
+static int verify_lengths(struct scatterlist *sg, int nents, int npages)
 {
 	int sg_len, dma_len;
 	int i, pgcount;
@@ -22,8 +22,8 @@
 		sg_len += sg[i].length;
 
 	dma_len = 0;
-	for (i = 0; i < nents && sg[i].dvma_length; i++)
-		dma_len += sg[i].dvma_length;
+	for (i = 0; i < nents && sg[i].dma_length; i++)
+		dma_len += sg[i].dma_length;
 
 	if (sg_len != dma_len) {
 		printk("verify_lengths: Error, different, sg[%d] dma[%d]\n",
@@ -32,13 +32,13 @@
 	}
 
 	pgcount = 0;
-	for (i = 0; i < nents && sg[i].dvma_length; i++) {
+	for (i = 0; i < nents && sg[i].dma_length; i++) {
 		unsigned long start, end;
 
-		start = sg[i].dvma_address;
+		start = sg[i].dma_address;
 		start = start & PAGE_MASK;
 
-		end = sg[i].dvma_address + sg[i].dvma_length;
+		end = sg[i].dma_address + sg[i].dma_length;
 		end = (end + (PAGE_SIZE - 1)) & PAGE_MASK;
 
 		pgcount += ((end - start) >> PAGE_SHIFT);
@@ -55,15 +55,16 @@
 	return 0;
 }
 
-int verify_one_map(struct scatterlist *dma_sg, struct scatterlist **__sg, int nents, iopte_t **__iopte)
+static int verify_one_map(struct scatterlist *dma_sg, struct scatterlist **__sg, int nents, iopte_t **__iopte)
 {
 	struct scatterlist *sg = *__sg;
 	iopte_t *iopte = *__iopte;
-	u32 dlen = dma_sg->dvma_length;
-	u32 daddr = dma_sg->dvma_address;
+	u32 dlen = dma_sg->dma_length;
+	u32 daddr;
 	unsigned int sglen;
 	unsigned long sgaddr;
 
+	daddr = dma_sg->dma_address;
 	sglen = sg->length;
 	sgaddr = (unsigned long) sg->address;
 	while (dlen > 0) {
@@ -136,7 +137,7 @@
 	return nents;
 }
 
-int verify_maps(struct scatterlist *sg, int nents, iopte_t *iopte)
+static int verify_maps(struct scatterlist *sg, int nents, iopte_t *iopte)
 {
 	struct scatterlist *dma_sg = sg;
 	struct scatterlist *orig_dma_sg = dma_sg;
@@ -147,7 +148,7 @@
 		if (nents <= 0)
 			break;
 		dma_sg++;
-		if (dma_sg->dvma_length == 0)
+		if (dma_sg->dma_length == 0)
 			break;
 	}
 
@@ -174,14 +175,15 @@
 	    verify_maps(sg, nents, iopte) < 0) {
 		int i;
 
-		printk("verify_sglist: Crap, messed up mappings, dumping, iodma at %08x.\n",
-		       (u32) (sg->dvma_address & PAGE_MASK));
+		printk("verify_sglist: Crap, messed up mappings, dumping, iodma at ");
+		printk("%016lx.\n", sg->dma_address & PAGE_MASK);
+
 		for (i = 0; i < nents; i++) {
 			printk("sg(%d): address(%p) length(%x) "
-			       "dma_address[%08x] dma_length[%08x]\n",
+			       "dma_address[%016lx] dma_length[%08x]\n",
 			       i,
 			       sg[i].address, sg[i].length,
-			       sg[i].dvma_address, sg[i].dvma_length);
+			       sg[i].dma_address, sg[i].dma_length);
 		}
 	}
 
@@ -189,30 +191,23 @@
 }
 #endif
 
-/* Two addresses are "virtually contiguous" if and only if:
- * 1) They are equal, or...
- * 2) They are both on a page boundry
- */
-#define VCONTIG(__X, __Y)	(((__X) == (__Y)) || \
-				 (((__X) | (__Y)) << (64UL - PAGE_SHIFT)) == 0UL)
-
 unsigned long prepare_sg(struct scatterlist *sg, int nents)
 {
 	struct scatterlist *dma_sg = sg;
 	unsigned long prev;
-	u32 dent_addr, dent_len;
+	u64 dent_addr, dent_len;
 
 	prev  = (unsigned long) sg->address;
 	prev += (unsigned long) (dent_len = sg->length);
-	dent_addr = (u32) ((unsigned long)sg->address & (PAGE_SIZE - 1UL));
+	dent_addr = (u64) ((unsigned long)sg->address & (PAGE_SIZE - 1UL));
 	while (--nents) {
 		unsigned long addr;
 
 		sg++;
 		addr = (unsigned long) sg->address;
 		if (! VCONTIG(prev, addr)) {
-			dma_sg->dvma_address = dent_addr;
-			dma_sg->dvma_length = dent_len;
+			dma_sg->dma_address = dent_addr;
+			dma_sg->dma_length = dent_len;
 			dma_sg++;
 
 			dent_addr = ((dent_addr +
@@ -225,8 +220,8 @@
 		dent_len += sg->length;
 		prev = addr + sg->length;
 	}
-	dma_sg->dvma_address = dent_addr;
-	dma_sg->dvma_length = dent_len;
+	dma_sg->dma_address = dent_addr;
+	dma_sg->dma_length = dent_len;
 
 	return ((unsigned long) dent_addr +
 		(unsigned long) dent_len +
--- ./arch/sparc64/kernel/sbus.c.~1~	Wed May 23 17:57:03 2001
+++ ./arch/sparc64/kernel/sbus.c	Wed Aug 15 06:41:43 2001
@@ -376,6 +376,11 @@
 	spin_unlock_irqrestore(&iommu->lock, flags);
 }
 
+#define SG_ENT_PHYS_ADDRESS(SG)	\
+	((SG)->address ? \
+	 __pa((SG)->address) : \
+	 (__pa(page_address((SG)->page)) + (SG)->offset))
+
 static inline void fill_sg(iopte_t *iopte, struct scatterlist *sg, int nused, unsigned long iopte_bits)
 {
 	struct scatterlist *dma_sg = sg;
@@ -383,11 +388,11 @@
 
 	for (i = 0; i < nused; i++) {
 		unsigned long pteval = ~0UL;
-		u32 dma_npages;
+		u64 dma_npages;
 
-		dma_npages = ((dma_sg->dvma_address & (PAGE_SIZE - 1UL)) +
-			      dma_sg->dvma_length +
-			      ((u32)(PAGE_SIZE - 1UL))) >> PAGE_SHIFT;
+		dma_npages = ((dma_sg->dma_address & (PAGE_SIZE - 1UL)) +
+			      dma_sg->dma_length +
+			      ((PAGE_SIZE - 1UL))) >> PAGE_SHIFT;
 		do {
 			unsigned long offset;
 			signed int len;
@@ -400,7 +405,7 @@
 			for (;;) {
 				unsigned long tmp;
 
-				tmp = (unsigned long) __pa(sg->address);
+				tmp = (unsigned long) SG_ENT_PHYS_ADDRESS(sg);
 				len = sg->length;
 				if (((tmp ^ pteval) >> PAGE_SHIFT) != 0UL) {
 					pteval = tmp & PAGE_MASK;
@@ -433,9 +438,9 @@
 			 * detect a page crossing event.
 			 */
 			while ((pteval << (64 - PAGE_SHIFT)) != 0UL &&
-			       pteval == __pa(sg->address) &&
+			       (pteval == SG_ENT_PHYS_ADDRESS(sg)) &&
 			       ((pteval ^
-				 (__pa(sg->address) + sg->length - 1UL)) >> PAGE_SHIFT) == 0UL) {
+				 (SG_ENT_PHYS_ADDRESS(sg) + sg->length - 1UL)) >> PAGE_SHIFT) == 0UL) {
 				pteval += sg->length;
 				sg++;
 			}
@@ -461,8 +466,13 @@
 
 	/* Fast path single entry scatterlists. */
 	if (nents == 1) {
-		sg->dvma_address = sbus_map_single(sdev, sg->address, sg->length, dir);
-		sg->dvma_length = sg->length;
+		sg->dma_address = (dma64_addr_t)
+			sbus_map_single(sdev,
+					(sg->address ?
+					 sg->address :
+					 (page_address(sg->page) + sg->offset)),
+					sg->length, dir);
+		sg->dma_length = sg->length;
 		return 1;
 	}
 
@@ -478,8 +488,8 @@
 	sgtmp = sg;
 	used = nents;
 
-	while (used && sgtmp->dvma_length) {
-		sgtmp->dvma_address += dma_base;
+	while (used && sgtmp->dma_length) {
+		sgtmp->dma_address += dma_base;
 		sgtmp++;
 		used--;
 	}
@@ -507,22 +517,22 @@
 {
 	unsigned long size, flags;
 	struct sbus_iommu *iommu;
-	u32 dvma_base;
+	u64 dvma_base;
 	int i;
 
 	/* Fast path single entry scatterlists. */
 	if (nents == 1) {
-		sbus_unmap_single(sdev, sg->dvma_address, sg->dvma_length, direction);
+		sbus_unmap_single(sdev, sg->dma_address, sg->dma_length, direction);
 		return;
 	}
 
-	dvma_base = sg[0].dvma_address & PAGE_MASK;
+	dvma_base = sg[0].dma_address & PAGE_MASK;
 	for (i = 0; i < nents; i++) {
-		if (sg[i].dvma_length == 0)
+		if (sg[i].dma_length == 0)
 			break;
 	}
 	i--;
-	size = PAGE_ALIGN(sg[i].dvma_address + sg[i].dvma_length) - dvma_base;
+	size = PAGE_ALIGN(sg[i].dma_address + sg[i].dma_length) - dvma_base;
 
 	iommu = sdev->bus->iommu;
 	spin_lock_irqsave(&iommu->lock, flags);
@@ -547,16 +557,16 @@
 {
 	struct sbus_iommu *iommu = sdev->bus->iommu;
 	unsigned long flags, size;
-	u32 base;
+	u64 base;
 	int i;
 
-	base = sg[0].dvma_address & PAGE_MASK;
+	base = sg[0].dma_address & PAGE_MASK;
 	for (i = 0; i < nents; i++) {
-		if (sg[i].dvma_length == 0)
+		if (sg[i].dma_length == 0)
 			break;
 	}
 	i--;
-	size = PAGE_ALIGN(sg[i].dvma_address + sg[i].dvma_length) - base;
+	size = PAGE_ALIGN(sg[i].dma_address + sg[i].dma_length) - base;
 
 	spin_lock_irqsave(&iommu->lock, flags);
 	strbuf_flush(iommu, base, size >> PAGE_SHIFT);
--- ./arch/sparc64/kernel/iommu_common.h.~1~	Mon Aug 13 11:04:26 2001
+++ ./arch/sparc64/kernel/iommu_common.h	Wed Aug 15 07:00:20 2001
@@ -18,10 +18,7 @@
 #undef VERIFY_SG
 
 #ifdef VERIFY_SG
-int verify_lengths(struct scatterlist *sg, int nents, int npages);
-int verify_one_map(struct scatterlist *dma_sg, struct scatterlist **__sg, int nents, iopte_t **__iopte);
-int verify_maps(struct scatterlist *sg, int nents, iopte_t *iopte);
-void verify_sglist(struct scatterlist *sg, int nents, iopte_t *iopte, int npages);
+extern void verify_sglist(struct scatterlist *sg, int nents, iopte_t *iopte, int npages);
 #endif
 
 /* Two addresses are "virtually contiguous" if and only if:
@@ -31,4 +28,4 @@
 #define VCONTIG(__X, __Y)	(((__X) == (__Y)) || \
 				 (((__X) | (__Y)) << (64UL - PAGE_SHIFT)) == 0UL)
 
-unsigned long prepare_sg(struct scatterlist *sg, int nents);
+extern unsigned long prepare_sg(struct scatterlist *sg, int nents);
--- ./arch/sparc64/kernel/sparc64_ksyms.c.~1~	Mon Jun  4 20:39:50 2001
+++ ./arch/sparc64/kernel/sparc64_ksyms.c	Wed Aug 15 06:23:37 2001
@@ -216,10 +216,16 @@
 EXPORT_SYMBOL(pci_free_consistent);
 EXPORT_SYMBOL(pci_map_single);
 EXPORT_SYMBOL(pci_unmap_single);
+EXPORT_SYMBOL(pci64_map_page);
+EXPORT_SYMBOL(pci64_unmap_page);
 EXPORT_SYMBOL(pci_map_sg);
 EXPORT_SYMBOL(pci_unmap_sg);
+EXPORT_SYMBOL(pci64_map_sg);
+EXPORT_SYMBOL(pci64_unmap_sg);
 EXPORT_SYMBOL(pci_dma_sync_single);
+EXPORT_SYMBOL(pci64_dma_sync_single);
 EXPORT_SYMBOL(pci_dma_sync_sg);
+EXPORT_SYMBOL(pci64_dma_sync_sg);
 EXPORT_SYMBOL(pci_dma_supported);
 #endif
 
--- ./arch/ia64/sn/io/pci_dma.c.~1~	Fri Apr 13 22:44:54 2001
+++ ./arch/ia64/sn/io/pci_dma.c	Thu Aug 16 04:50:22 2001
@@ -182,7 +182,7 @@
 }
 
 /*
- * On sn1 we use the alt_address entry of the scatterlist to store
+ * On sn1 we use the orig_address entry of the scatterlist to store
  * the physical address corresponding to the given virtual address
  */
 int
--- ./arch/parisc/kernel/ccio-dma.c.~1~	Sun Feb 11 23:53:07 2001
+++ ./arch/parisc/kernel/ccio-dma.c	Wed Aug 15 03:07:31 2001
@@ -638,7 +638,7 @@
 }
 
 
-static int ccio_dma_supported( struct pci_dev *dev, dma_addr_t mask)
+static int ccio_dma_supported( struct pci_dev *dev, u64 mask)
 {
 	if (dev == NULL) {
 		printk(MODULE_NAME ": EISA/ISA/et al not supported\n");
--- ./arch/parisc/kernel/pci-dma.c.~1~	Sun Feb 11 23:53:07 2001
+++ ./arch/parisc/kernel/pci-dma.c	Wed Aug 15 03:07:50 2001
@@ -77,7 +77,7 @@
 static inline void dump_resmap(void) {;}
 #endif
 
-static int pa11_dma_supported( struct pci_dev *dev, dma_addr_t mask)
+static int pa11_dma_supported( struct pci_dev *dev, u64 mask)
 {
 	return 1;
 }
--- ./arch/parisc/kernel/ccio-rm-dma.c.~1~	Wed Dec  6 05:30:33 2000
+++ ./arch/parisc/kernel/ccio-rm-dma.c	Wed Aug 15 03:07:42 2001
@@ -93,7 +93,7 @@
 }
 
 
-static int ccio_dma_supported( struct pci_dev *dev, dma_addr_t mask)  
+static int ccio_dma_supported( struct pci_dev *dev, u64 mask)
 {
 	if (dev == NULL) {
 		printk(MODULE_NAME ": EISA/ISA/et al not supported\n");
--- ./arch/parisc/kernel/sba_iommu.c.~1~	Sun Feb 11 23:53:07 2001
+++ ./arch/parisc/kernel/sba_iommu.c	Wed Aug 15 03:07:56 2001
@@ -779,7 +779,7 @@
 }
 
 static int
-sba_dma_supported( struct pci_dev *dev, dma_addr_t mask)
+sba_dma_supported( struct pci_dev *dev, u64 mask)
 {
 	if (dev == NULL) {
 		printk(MODULE_NAME ": EISA/ISA/et al not supported\n");
--- ./drivers/net/acenic.c.~1~	Mon Aug 13 09:55:44 2001
+++ ./drivers/net/acenic.c	Wed Aug 15 02:33:22 2001
@@ -202,6 +202,7 @@
 #define pci_free_consistent(cookie, size, ptr, dma_ptr)	kfree(ptr)
 #define pci_map_single(cookie, address, size, dir)	virt_to_bus(address)
 #define pci_unmap_single(cookie, address, size, dir)
+#define pci_set_dma_mask(dev, mask)		do { } while (0)
 #endif
 
 #if (LINUX_VERSION_CODE < 0x02032b)
@@ -258,11 +259,6 @@
 #define ace_mark_net_bh()			{do{} while(0);}
 #define ace_if_down(dev)			{do{} while(0);}
 #endif
-
-#ifndef pci_set_dma_mask
-#define pci_set_dma_mask(dev, mask)		dev->dma_mask = mask;
-#endif
-
 
 #if (LINUX_VERSION_CODE >= 0x02031b)
 #define NEW_NETINIT
--- ./drivers/pci/pci.c.~1~	Mon Aug 13 22:05:39 2001
+++ ./drivers/pci/pci.c	Wed Aug 15 06:22:34 2001
@@ -832,7 +832,7 @@
 }
 
 int
-pci_set_dma_mask(struct pci_dev *dev, dma_addr_t mask)
+pci_set_dma_mask(struct pci_dev *dev, u64 mask)
 {
     if(! pci_dma_supported(dev, mask))
         return -EIO;
@@ -842,6 +842,12 @@
     return 0;
 }
     
+void
+pci_change_dma_flag(struct pci_dev *dev, unsigned int on, unsigned int off)
+{
+	dev->dma_flags |= on;
+	dev->dma_flags &= ~off;
+}
 
 /*
  * Translate the low bits of the PCI base
@@ -1954,6 +1960,7 @@
 EXPORT_SYMBOL(pci_find_subsys);
 EXPORT_SYMBOL(pci_set_master);
 EXPORT_SYMBOL(pci_set_dma_mask);
+EXPORT_SYMBOL(pci_change_dma_flag);
 EXPORT_SYMBOL(pci_assign_resource);
 EXPORT_SYMBOL(pci_register_driver);
 EXPORT_SYMBOL(pci_unregister_driver);
--- ./drivers/scsi/sr.c.~1~	Thu Jul  5 22:11:52 2001
+++ ./drivers/scsi/sr.c	Thu Aug 16 04:59:37 2001
@@ -265,6 +265,7 @@
 	struct scatterlist *sg, *old_sg = NULL;
 	int i, fsize, bsize, sg_ent, sg_count;
 	char *front, *back;
+	void **bbpnt, **old_bbpnt = NULL;
 
 	back = front = NULL;
 	sg_ent = SCpnt->use_sg;
@@ -292,17 +293,25 @@
 	 * extend or allocate new scatter-gather table
 	 */
 	sg_count = SCpnt->use_sg;
-	if (sg_count)
+	if (sg_count) {
 		old_sg = (struct scatterlist *) SCpnt->request_buffer;
-	else {
+		old_bbpnt = SCpnt->bounce_buffers;
+	} else {
 		sg_count = 1;
 		sg_ent++;
 	}
 
-	i = ((sg_ent * sizeof(struct scatterlist)) + 511) & ~511;
+	/* Get space for scatterlist and bounce buffer array. */
+	i  = sg_ent * sizeof(struct scatterlist);
+	i += sg_ent * sizeof(void *);
+	i  = (i + 511) & ~511;
+
 	if ((sg = scsi_malloc(i)) == NULL)
 		goto no_mem;
 
+	bbpnt = (void **)
+		((char *)sg + (sg_ent * sizeof(struct scatterlist)));
+
 	/*
 	 * no more failing memory allocs possible, we can safely assign
 	 * SCpnt values now
@@ -313,13 +322,15 @@
 
 	i = 0;
 	if (fsize) {
-		sg[0].address = sg[0].alt_address = front;
+		sg[0].address = bbpnt[0] = front;
 		sg[0].length = fsize;
 		i++;
 	}
 	if (old_sg) {
 		memcpy(sg + i, old_sg, SCpnt->use_sg * sizeof(struct scatterlist));
-		scsi_free(old_sg, ((SCpnt->use_sg * sizeof(struct scatterlist)) + 511) & ~511);
+		memcpy(bbpnt + i, old_bbpnt, SCpnt->use_sg * sizeof(void *));
+		scsi_free(old_sg, (((SCpnt->use_sg * sizeof(struct scatterlist)) +
+				    (SCpnt->use_sg * sizeof(void *))) + 511) & ~511);
 	} else {
 		sg[i].address = SCpnt->request_buffer;
 		sg[i].length = SCpnt->request_bufflen;
@@ -327,11 +338,12 @@
 
 	SCpnt->request_bufflen += (fsize + bsize);
 	SCpnt->request_buffer = sg;
+	SCpnt->bounce_buffers = bbpnt;
 	SCpnt->use_sg += i;
 
 	if (bsize) {
 		sg[SCpnt->use_sg].address = back;
-		sg[SCpnt->use_sg].alt_address = back;
+		bbpnt[SCpnt->use_sg] = back;
 		sg[SCpnt->use_sg].length = bsize;
 		SCpnt->use_sg++;
 	}
--- ./drivers/scsi/sym53c8xx.c.~1~	Thu Jul  5 22:11:53 2001
+++ ./drivers/scsi/sym53c8xx.c	Wed Aug 15 02:34:39 2001
@@ -13101,7 +13101,7 @@
 		(int) (PciDeviceFn(pdev) & 7));
 
 #ifdef SCSI_NCR_DYNAMIC_DMA_MAPPING
-	if (pci_set_dma_mask(pdev, (dma_addr_t) (0xffffffffUL))) {
+	if (pci_set_dma_mask(pdev, 0xffffffff)) {
 		printk(KERN_WARNING NAME53C8XX
 		       "32 BIT PCI BUS DMA ADDRESSING NOT SUPPORTED\n");
 		return -1;
--- ./drivers/scsi/sym53c8xx_comm.h.~1~	Tue Aug 14 21:43:17 2001
+++ ./drivers/scsi/sym53c8xx_comm.h	Wed Aug 15 03:05:23 2001
@@ -2186,7 +2186,7 @@
 		(int) (PciDeviceFn(pdev) & 7));
 
 #ifdef SCSI_NCR_DYNAMIC_DMA_MAPPING
-	if (!pci_dma_supported(pdev, (dma_addr_t) (0xffffffffUL))) {
+	if (!pci_dma_supported(pdev, 0xffffffff)) {
 		printk(KERN_WARNING NAME53C8XX
 		       "32 BIT PCI BUS DMA ADDRESSING NOT SUPPORTED\n");
 		return -1;
--- ./drivers/scsi/aha1542.c.~1~	Tue May  1 18:50:05 2001
+++ ./drivers/scsi/aha1542.c	Thu Aug 16 04:21:56 2001
@@ -67,12 +67,10 @@
 		       int nseg,
 		       int badseg)
 {
-	printk(KERN_CRIT "sgpnt[%d:%d] addr %p/0x%lx alt %p/0x%lx length %d\n",
+	printk(KERN_CRIT "sgpnt[%d:%d] addr %p/0x%lx length %d\n",
 	       badseg, nseg,
 	       sgpnt[badseg].address,
 	       SCSI_PA(sgpnt[badseg].address),
-	       sgpnt[badseg].alt_address,
-	       sgpnt[badseg].alt_address ? SCSI_PA(sgpnt[badseg].alt_address) : 0,
 	       sgpnt[badseg].length);
 
 	/*
@@ -716,7 +714,7 @@
 				unsigned char *ptr;
 				printk(KERN_CRIT "Bad segment list supplied to aha1542.c (%d, %d)\n", SCpnt->use_sg, i);
 				for (i = 0; i < SCpnt->use_sg; i++) {
-					printk(KERN_CRIT "%d: %x %x %d\n", i, (unsigned int) sgpnt[i].address, (unsigned int) sgpnt[i].alt_address,
+					printk(KERN_CRIT "%d: %p %d\n", i, sgpnt[i].address,
 					       sgpnt[i].length);
 				};
 				printk(KERN_CRIT "cptr %x: ", (unsigned int) cptr);
--- ./drivers/scsi/osst.c.~1~	Mon Jul 23 05:12:27 2001
+++ ./drivers/scsi/osst.c	Thu Aug 16 04:22:30 2001
@@ -4933,7 +4933,6 @@
 			tb->sg[0].address =
 			    (unsigned char *)__get_free_pages(priority, order);
 			if (tb->sg[0].address != NULL) {
-			    tb->sg[0].alt_address = NULL;
 			    tb->sg[0].length = b_size;
 			    break;
 			}
@@ -4969,7 +4968,6 @@
 				tb = NULL;
 				break;
 			    }
-			    tb->sg[segs].alt_address = NULL;
 			    tb->sg[segs].length = b_size;
 			    got += b_size;
 			    segs++;
@@ -5043,7 +5041,6 @@
 			normalize_buffer(STbuffer);
 			return FALSE;
 		}
-		STbuffer->sg[segs].alt_address = NULL;
 		STbuffer->sg[segs].length = b_size;
 		STbuffer->sg_segs += 1;
 		got += b_size;
--- ./drivers/scsi/scsi_debug.c.~1~	Tue Nov 28 08:33:08 2000
+++ ./drivers/scsi/scsi_debug.c	Thu Aug 16 04:23:40 2001
@@ -154,10 +154,7 @@
 	if (SCpnt->use_sg) {
 		sgpnt = (struct scatterlist *) SCpnt->buffer;
 		for (i = 0; i < SCpnt->use_sg; i++) {
-			lpnt = (int *) sgpnt[i].alt_address;
-			printk(":%p %p %d\n", sgpnt[i].alt_address, sgpnt[i].address, sgpnt[i].length);
-			if (lpnt)
-				printk(" (Alt %x) ", lpnt[15]);
+			printk(":%p %d\n", sgpnt[i].address, sgpnt[i].length);
 		};
 	} else {
 		printk("nosg: %p %p %d\n", SCpnt->request.buffer, SCpnt->buffer,
@@ -175,12 +172,6 @@
 	printk("\n");
 	if (flag == 0)
 		return;
-	lpnt = (unsigned int *) sgpnt[0].alt_address;
-	for (i = 0; i < sizeof(Scsi_Cmnd) / 4 + 1; i++) {
-		if ((i & 7) == 0)
-			printk("\n");
-		printk("%x ", *lpnt++);
-	};
 #if 0
 	printk("\n");
 	lpnt = (unsigned int *) sgpnt[0].address;
--- ./drivers/scsi/scsi.h.~1~	Wed Aug 15 06:48:23 2001
+++ ./drivers/scsi/scsi.h	Thu Aug 16 04:41:17 2001
@@ -745,7 +745,8 @@
 	unsigned request_bufflen;	/* Actual request size */
 
 	struct timer_list eh_timeout;	/* Used to time out the command. */
-	void *request_buffer;	/* Actual requested buffer */
+	void *request_buffer;		/* Actual requested buffer */
+        void **bounce_buffers;		/* Array of bounce buffers when using scatter-gather */
 
 	/* These elements define the operation we ultimately want to perform */
 	unsigned char data_cmnd[MAX_COMMAND_SIZE];
--- ./drivers/scsi/scsi_merge.c.~1~	Thu Jul  5 22:11:52 2001
+++ ./drivers/scsi/scsi_merge.c	Thu Aug 16 04:58:34 2001
@@ -120,9 +120,11 @@
 {
 	int jj;
 	struct scatterlist *sgpnt;
+	void **bbpnt;
 	int consumed = 0;
 
 	sgpnt = (struct scatterlist *) SCpnt->request_buffer;
+	bbpnt = SCpnt->bounce_buffers;
 
 	/*
 	 * Now print out a bunch of stats.  First, start with the request
@@ -136,15 +138,13 @@
 	 */
 	for(jj=0; jj < SCpnt->use_sg; jj++)
 	{
-		printk("[%d]\tlen:%d\taddr:%p\talt:%p\n",
+		printk("[%d]\tlen:%d\taddr:%p\tbounce:%p\n",
 		       jj,
 		       sgpnt[jj].length,
 		       sgpnt[jj].address,
-		       sgpnt[jj].alt_address);		       
-		if( sgpnt[jj].alt_address != NULL )
-		{
-			consumed = (sgpnt[jj].length >> 9);
-		}
+		       (bbpnt ? bbpnt[jj] : NULL));
+		if (bbpnt && bbpnt[jj])
+			consumed += sgpnt[jj].length;
 	}
 	printk("Total %d sectors consumed\n", consumed);
 	panic("DMA pool exhausted");
@@ -807,6 +807,7 @@
 	int		     sectors;
 	struct scatterlist * sgpnt;
 	int		     this_count;
+	void		   ** bbpnt;
 
 	/*
 	 * FIXME(eric) - don't inline this - it doesn't depend on the
@@ -861,10 +862,19 @@
 
 	/* 
 	 * Allocate the actual scatter-gather table itself.
-	 * scsi_malloc can only allocate in chunks of 512 bytes 
 	 */
-	SCpnt->sglist_len = (SCpnt->use_sg
-			     * sizeof(struct scatterlist) + 511) & ~511;
+	SCpnt->sglist_len = (SCpnt->use_sg * sizeof(struct scatterlist));
+
+	/* If we could potentially require ISA bounce buffers, allocate
+	 * space for this array here.
+	 */
+	if (dma_host)
+		SCpnt->sglist_len += (SCpnt->use_sg * sizeof(void *));
+
+	/* scsi_malloc can only allocate in chunks of 512 bytes so
+	 * round it up.
+	 */
+	SCpnt->sglist_len = (SCpnt->sglist_len + 511) & ~511;
 
 	sgpnt = (struct scatterlist *) scsi_malloc(SCpnt->sglist_len);
 
@@ -889,6 +899,14 @@
 	SCpnt->request_bufflen = 0;
 	bhprev = NULL;
 
+	if (dma_host)
+		bbpnt = (void **) ((char *)sgpnt +
+			 (SCpnt->use_sg * sizeof(struct scatterlist)));
+	else
+		bbpnt = NULL;
+
+	SCpnt->bounce_buffers = bbpnt;
+
 	for (count = 0, bh = SCpnt->request.bh;
 	     bh; bh = bh->b_reqnext) {
 		if (use_clustering && bhprev != NULL) {
@@ -956,7 +974,7 @@
 			if( scsi_dma_free_sectors - sectors <= 10  ) {
 				/*
 				 * If this would nearly drain the DMA
-				 * pool, mpty, then let's stop here.
+				 * pool empty, then let's stop here.
 				 * Don't make this request any larger.
 				 * This is kind of a safety valve that
 				 * we use - we could get screwed later
@@ -970,7 +988,7 @@
 				break;
 			}
 
-			sgpnt[i].alt_address = sgpnt[i].address;
+			bbpnt[i] = sgpnt[i].address;
 			sgpnt[i].address =
 			    (char *) scsi_malloc(sgpnt[i].length);
 			/*
@@ -987,7 +1005,7 @@
 				break;
 			}
 			if (SCpnt->request.cmd == WRITE) {
-				memcpy(sgpnt[i].address, sgpnt[i].alt_address,
+				memcpy(sgpnt[i].address, bbpnt[i],
 				       sgpnt[i].length);
 			}
 		}
--- ./drivers/scsi/scsi_lib.c.~1~	Sun Aug 12 23:50:32 2001
+++ ./drivers/scsi/scsi_lib.c	Thu Aug 16 04:41:34 2001
@@ -496,13 +496,16 @@
 	 */
 	if (SCpnt->use_sg) {
 		struct scatterlist *sgpnt;
+		void **bbpnt;
 		int i;
 
 		sgpnt = (struct scatterlist *) SCpnt->request_buffer;
+		bbpnt = SCpnt->bounce_buffers;
 
-		for (i = 0; i < SCpnt->use_sg; i++) {
-			if (sgpnt[i].alt_address) {
-				scsi_free(sgpnt[i].address, sgpnt[i].length);
+		if (bbpnt) {
+			for (i = 0; i < SCpnt->use_sg; i++) {
+				if (bbpnt[i])
+					scsi_free(sgpnt[i].address, sgpnt[i].length);
 			}
 		}
 		scsi_free(SCpnt->request_buffer, SCpnt->sglist_len);
@@ -568,18 +571,22 @@
 	 */
 	if (SCpnt->use_sg) {
 		struct scatterlist *sgpnt;
+		void **bbpnt;
 		int i;
 
 		sgpnt = (struct scatterlist *) SCpnt->buffer;
+		bbpnt = SCpnt->bounce_buffers;
 
-		for (i = 0; i < SCpnt->use_sg; i++) {
-			if (sgpnt[i].alt_address) {
-				if (SCpnt->request.cmd == READ) {
-					memcpy(sgpnt[i].alt_address, 
-					       sgpnt[i].address,
-					       sgpnt[i].length);
+		if (bbpnt) {
+			for (i = 0; i < SCpnt->use_sg; i++) {
+				if (bbpnt[i]) {
+					if (SCpnt->request.cmd == READ) {
+						memcpy(bbpnt[i],
+						       sgpnt[i].address,
+						       sgpnt[i].length);
+					}
+					scsi_free(sgpnt[i].address, sgpnt[i].length);
 				}
-				scsi_free(sgpnt[i].address, sgpnt[i].length);
 			}
 		}
 		scsi_free(SCpnt->buffer, SCpnt->sglist_len);
--- ./drivers/scsi/st.c.~1~	Sun Aug 12 23:50:32 2001
+++ ./drivers/scsi/st.c	Thu Aug 16 04:48:18 2001
@@ -3222,7 +3222,6 @@
 			tb->sg[0].address =
 			    (unsigned char *) __get_free_pages(priority, order);
 			if (tb->sg[0].address != NULL) {
-				tb->sg[0].alt_address = NULL;
 				tb->sg[0].length = b_size;
 				break;
 			}
@@ -3258,7 +3257,6 @@
 					tb = NULL;
 					break;
 				}
-				tb->sg[segs].alt_address = NULL;
 				tb->sg[segs].length = b_size;
 				got += b_size;
 				segs++;
@@ -3332,7 +3330,6 @@
 			normalize_buffer(STbuffer);
 			return FALSE;
 		}
-		STbuffer->sg[segs].alt_address = NULL;
 		STbuffer->sg[segs].length = b_size;
 		STbuffer->sg_segs += 1;
 		got += b_size;
--- ./drivers/scsi/qlogicfc.c.~1~	Sun Aug 12 23:50:32 2001
+++ ./drivers/scsi/qlogicfc.c	Wed Aug 15 06:53:38 2001
@@ -65,7 +65,7 @@
 
 #if 1
 /* Once pci64_ DMA mapping interface is in, kill this. */
-typedef dma_addr_t dma64_addr_t;
+#define dma64_addr_t dma_addr_t
 #define pci64_alloc_consistent(d,s,p) pci_alloc_consistent((d),(s),(p))
 #define pci64_free_consistent(d,s,c,a) pci_free_consistent((d),(s),(c),(a))
 #define pci64_map_single(d,c,s,dir) pci_map_single((d),(c),(s),(dir))
@@ -80,6 +80,7 @@
 #define pci64_dma_lo32(a) (a)
 #endif	/* BITS_PER_LONG */
 #define pci64_dma_build(hi,lo) (lo)
+#undef sg_dma64_address
 #define sg_dma64_address(s) sg_dma_address(s)
 #define sg_dma64_len(s) sg_dma_len(s)
 #if BITS_PER_LONG > 32
--- ./include/asm-alpha/pci.h.~1~	Wed May 23 17:57:18 2001
+++ ./include/asm-alpha/pci.h	Wed Aug 15 03:05:38 2001
@@ -144,7 +144,7 @@
    only drive the low 24-bits during PCI bus mastering, then
    you would pass 0x00ffffff as the mask to this function.  */
 
-extern int pci_dma_supported(struct pci_dev *hwdev, dma_addr_t mask);
+extern int pci_dma_supported(struct pci_dev *hwdev, u64 mask);
 
 /* Return the index of the PCI controller for device PDEV. */
 extern int pci_controller_num(struct pci_dev *pdev);
--- ./include/asm-alpha/scatterlist.h.~1~	Tue Nov 28 08:33:08 2000
+++ ./include/asm-alpha/scatterlist.h	Thu Aug 16 04:50:38 2001
@@ -5,8 +5,6 @@
 
 struct scatterlist {
 	char *address;			/* Source/target vaddr.  */
-	char *alt_address;		/* Location of actual if address is a
-					   dma indirect buffer, else NULL.  */
 	dma_addr_t dma_address;
 	unsigned int length;
 	unsigned int dma_length;
--- ./include/asm-arm/pci.h.~1~	Sun Aug 12 23:50:35 2001
+++ ./include/asm-arm/pci.h	Wed Aug 15 03:05:45 2001
@@ -152,7 +152,7 @@
  * only drive the low 24-bits during PCI bus mastering, then
  * you would pass 0x00ffffff as the mask to this function.
  */
-static inline int pci_dma_supported(struct pci_dev *hwdev, dma_addr_t mask)
+static inline int pci_dma_supported(struct pci_dev *hwdev, u64 mask)
 {
 	return 1;
 }
--- ./include/asm-arm/scatterlist.h.~1~	Tue Nov 28 08:33:08 2000
+++ ./include/asm-arm/scatterlist.h	Thu Aug 16 04:50:52 2001
@@ -5,7 +5,6 @@
 
 struct scatterlist {
 	char		*address;	/* virtual address		 */
-	char		*alt_address;	/* indirect dma address, or NULL */
 	dma_addr_t	dma_address;	/* dma address			 */
 	unsigned int	length;		/* length			 */
 };
--- ./include/asm-i386/pci.h.~1~	Fri Jul 27 02:21:22 2001
+++ ./include/asm-i386/pci.h	Wed Aug 15 06:47:07 2001
@@ -55,6 +55,9 @@
 extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
 				void *vaddr, dma_addr_t dma_handle);
 
+/* This is always fine. */
+#define pci_dac_cycles_ok(pci_dev)		(1)
+
 /* Map a single buffer of the indicated size for DMA in streaming mode.
  * The 32-bit bus address to use is returned.
  *
@@ -84,6 +87,46 @@
 	/* Nothing to do */
 }
 
+/*
+ * pci_{map,unmap}_single_page maps a kernel page to a dma_addr_t. identical
+ * to pci_map_single, but takes a struct page instead of a virtual address
+ */
+static inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page *page,
+				      unsigned long offset, size_t size, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+
+	return (page - mem_map) * PAGE_SIZE + offset;
+}
+
+static inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
+				  size_t size, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+	/* Nothing to do */
+}
+
+/* 64-bit variants */
+static inline dma64_addr_t pci64_map_page(struct pci_dev *hwdev, struct page *page,
+					  unsigned long offset, size_t size, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+
+	return (((dma64_addr_t) (page - mem_map)) *
+		((dma64_addr_t) PAGE_SIZE)) + (dma64_addr_t) offset;
+}
+
+static inline void pci64_unmap_page(struct pci_dev *hwdev, dma64_addr_t dma_address,
+				    size_t size, int direction)
+{
+	if (direction == PCI_DMA_NONE)
+		BUG();
+	/* Nothing to do */
+}
+
 /* Map a set of buffers described by scatterlist in streaming
  * mode for DMA.  This is the scather-gather version of the
  * above pci_map_single interface.  Here the scatter gather list
@@ -102,8 +145,26 @@
 static inline int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
 			     int nents, int direction)
 {
+	int i;
+
 	if (direction == PCI_DMA_NONE)
 		BUG();
+
+	/*
+	 * temporary 2.4 hack
+	 */
+	for (i = 0; i < nents; i++ ) {
+		if (sg[i].address && sg[i].page)
+			BUG();
+		else if (!sg[i].address && !sg[i].page)
+			BUG();
+
+		if (sg[i].address)
+			sg[i].dma_address = virt_to_bus(sg[i].address);
+		else
+			sg[i].dma_address = page_to_bus(sg[i].page) + sg[i].offset;
+	}
+
 	return nents;
 }
 
@@ -119,6 +180,9 @@
 	/* Nothing to do */
 }
 
+#define pci64_map_sg	pci_map_sg
+#define pci64_unmap_sg	pci_unmap_sg
+
 /* Make physical memory consistent for a single
  * streaming mode DMA translation after a transfer.
  *
@@ -152,12 +216,15 @@
 	/* Nothing to do */
 }
 
+#define pci64_dma_sync_single	pci_dma_sync_single
+#define pci64_dma_sync_sg	pci_dma_sync_sg
+
 /* Return whether the given PCI device DMA address mask can
  * be supported properly.  For example, if your device can
  * only drive the low 24-bits during PCI bus mastering, then
  * you would pass 0x00ffffff as the mask to this function.
  */
-static inline int pci_dma_supported(struct pci_dev *hwdev, dma_addr_t mask)
+static inline int pci_dma_supported(struct pci_dev *hwdev, u64 mask)
 {
         /*
          * we fall back to GFP_DMA when the mask isn't all 1s,
@@ -173,10 +240,10 @@
 /* These macros should be used after a pci_map_sg call has been done
  * to get bus addresses of each of the SG entries and their lengths.
  * You should only work with the number of sg entries pci_map_sg
- * returns, or alternatively stop on the first sg_dma_len(sg) which
- * is 0.
+ * returns.
  */
-#define sg_dma_address(sg)	(virt_to_bus((sg)->address))
+#define sg_dma_address(sg)	((dma_addr_t) ((sg)->dma_address))
+#define sg_dma64_address(sg)	((sg)->dma_address)
 #define sg_dma_len(sg)		((sg)->length)
 
 /* Return the index of the PCI controller for device. */
--- ./include/asm-i386/scatterlist.h.~1~	Tue Nov 28 08:33:08 2000
+++ ./include/asm-i386/scatterlist.h	Thu Aug 16 04:51:00 2001
@@ -2,9 +2,12 @@
 #define _I386_SCATTERLIST_H
 
 struct scatterlist {
-    char *  address;    /* Location data is to be transferred to */
-    char * alt_address; /* Location of actual if address is a 
-			 * dma indirect buffer.  NULL otherwise */
+    char *  address;    /* Location data is to be transferred to, NULL for
+			 * highmem page */
+    struct page * page; /* Location for highmem page, if any */
+    unsigned int offset;/* for highmem, page offset */
+
+    dma64_addr_t dma_address;
     unsigned int length;
 };
 
--- ./include/asm-i386/types.h.~1~	Tue Nov 28 08:33:08 2000
+++ ./include/asm-i386/types.h	Wed Aug 15 06:32:48 2001
@@ -27,6 +27,8 @@
  */
 #ifdef __KERNEL__
 
+#include <linux/config.h>
+
 typedef signed char s8;
 typedef unsigned char u8;
 
@@ -44,6 +46,11 @@
 /* Dma addresses are 32-bits wide.  */
 
 typedef u32 dma_addr_t;
+#ifdef CONFIG_HIGHMEM
+typedef u64 dma64_addr_t;
+#else
+typedef u32 dma64_addr_t;
+#endif
 
 #endif /* __KERNEL__ */
 
--- ./include/asm-m68k/scatterlist.h.~1~	Tue Nov 28 08:33:08 2000
+++ ./include/asm-m68k/scatterlist.h	Thu Aug 16 04:51:09 2001
@@ -3,8 +3,6 @@
 
 struct scatterlist {
     char *  address;    /* Location data is to be transferred to */
-    char * alt_address; /* Location of actual if address is a 
-			 * dma indirect buffer.  NULL otherwise */
     unsigned int length;
     unsigned long dvma_address;
 };
--- ./include/asm-mips/pci.h.~1~	Tue Jul  3 18:14:13 2001
+++ ./include/asm-mips/pci.h	Wed Aug 15 03:06:03 2001
@@ -206,7 +206,7 @@
  * only drive the low 24-bits during PCI bus mastering, then
  * you would pass 0x00ffffff as the mask to this function.
  */
-extern inline int pci_dma_supported(struct pci_dev *hwdev, dma_addr_t mask)
+extern inline int pci_dma_supported(struct pci_dev *hwdev, u64 mask)
 {
 	/*
 	 * we fall back to GFP_DMA when the mask isn't all 1s,
--- ./include/asm-mips/scatterlist.h.~1~	Tue Nov 28 08:33:08 2000
+++ ./include/asm-mips/scatterlist.h	Thu Aug 16 04:51:17 2001
@@ -3,8 +3,6 @@
 
 struct scatterlist {
     char *  address;    /* Location data is to be transferred to */
-    char * alt_address; /* Location of actual if address is a 
-			 * dma indirect buffer.  NULL otherwise */
     unsigned int length;
     
     __u32 dvma_address;
--- ./include/asm-ppc/pci.h.~1~	Wed May 23 17:57:21 2001
+++ ./include/asm-ppc/pci.h	Wed Aug 15 03:06:10 2001
@@ -108,7 +108,7 @@
  * only drive the low 24-bits during PCI bus mastering, then
  * you would pass 0x00ffffff as the mask to this function.
  */
-extern inline int pci_dma_supported(struct pci_dev *hwdev, dma_addr_t mask)
+extern inline int pci_dma_supported(struct pci_dev *hwdev, u64 mask)
 {
 	return 1;
 }
--- ./include/asm-ppc/scatterlist.h.~1~	Wed May 23 17:57:21 2001
+++ ./include/asm-ppc/scatterlist.h	Thu Aug 16 04:51:23 2001
@@ -9,8 +9,6 @@
 
 struct scatterlist {
     char *  address;    /* Location data is to be transferred to */
-    char * alt_address; /* Location of actual if address is a 
-			 * dma indirect buffer.  NULL otherwise */
     unsigned int length;
 };
 
--- ./include/asm-sparc/pci.h.~1~	Sat May 12 03:47:41 2001
+++ ./include/asm-sparc/pci.h	Wed Aug 15 03:06:17 2001
@@ -108,7 +108,7 @@
  * only drive the low 24-bits during PCI bus mastering, then
  * you would pass 0x00ffffff as the mask to this function.
  */
-extern inline int pci_dma_supported(struct pci_dev *hwdev, dma_addr_t mask)
+extern inline int pci_dma_supported(struct pci_dev *hwdev, u64 mask)
 {
 	return 1;
 }
--- ./include/asm-sparc/scatterlist.h.~1~	Thu Dec 14 14:52:04 2000
+++ ./include/asm-sparc/scatterlist.h	Thu Aug 16 04:51:30 2001
@@ -6,8 +6,6 @@
 
 struct scatterlist {
     char *  address;    /* Location data is to be transferred to */
-    char * alt_address; /* Location of actual if address is a 
-			 * dma indirect buffer.  NULL otherwise */
     unsigned int length;
 
     __u32 dvma_address; /* A place to hang host-specific addresses at. */
--- ./include/asm-sparc64/types.h.~1~	Tue Nov 28 08:33:08 2000
+++ ./include/asm-sparc64/types.h	Wed Aug 15 02:13:44 2001
@@ -45,9 +45,10 @@
 
 #define BITS_PER_LONG 64
 
-/* Dma addresses are 32-bits wide for now.  */
+/* Dma addresses come in 32-bit and 64-bit flavours.  */
 
 typedef u32 dma_addr_t;
+typedef u64 dma64_addr_t;
 
 #endif /* __KERNEL__ */
 
--- ./include/asm-sparc64/pci.h.~1~	Tue Aug 14 21:31:07 2001
+++ ./include/asm-sparc64/pci.h	Wed Aug 15 06:43:53 2001
@@ -28,6 +28,15 @@
 /* Dynamic DMA mapping stuff.
  */
 
+/* PCI 64-bit addressing works for all slots on all controller
+ * types on sparc64.  However, it requires that the device
+ * can drive enough of the 64 bits.
+ */
+#define PCI64_ADDR_BASE		0x3fff000000000000
+#define PCI64_REQUIRED_MASK	(~(dma64_addr_t)0)
+#define pci_dac_cycles_ok(pci_dev) \
+	(((pci_dev)->dma_mask & PCI64_REQUIRED_MASK) == PCI64_REQUIRED_MASK)
+
 #include <asm/scatterlist.h>
 
 struct pci_dev;
@@ -64,6 +73,20 @@
  */
 extern void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr, size_t size, int direction);
 
+/* No highmem on sparc64, plus we have an IOMMU, so mapping pages is easy. */
+#define pci_map_page(dev, page, off, size, dir) \
+	pci_map_single(dev, (page_address(page) + (off)), size, dir)
+#define pci_unmap_page(dev,addr,sz,dir) pci_unmap_single(dev,addr,sz,dir)
+
+/* The 64-bit cases might have to do something interesting if
+ * PCI_DMA_FLAG_HUGE_MAPS is set in hwdev->dma_flags.
+ */
+extern dma64_addr_t pci64_map_page(struct pci_dev *hwdev,
+				   struct page *page, unsigned long offset,
+				   size_t size, int direction);
+extern void pci64_unmap_page(struct pci_dev *hwdev, dma64_addr_t dma_addr,
+			     size_t size, int direction);
+
 /* Map a set of buffers described by scatterlist in streaming
  * mode for DMA.  This is the scather-gather version of the
  * above pci_map_single interface.  Here the scatter gather list
@@ -79,13 +102,19 @@
  * Device ownership issues as mentioned above for pci_map_single are
  * the same here.
  */
-extern int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg, int nents, int direction);
+extern int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+		      int nents, int direction);
+extern int pci64_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+			int nents, int direction);
 
 /* Unmap a set of streaming mode DMA translations.
  * Again, cpu read rules concerning calls here are the same as for
  * pci_unmap_single() above.
  */
-extern void pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg, int nhwents, int direction);
+extern void pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+			 int nhwents, int direction);
+extern void pci64_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
+			   int nhwents, int direction);
 
 /* Make physical memory consistent for a single
  * streaming mode DMA translation after a transfer.
@@ -96,7 +125,10 @@
  * next point you give the PCI dma address back to the card, the
  * device again owns the buffer.
  */
-extern void pci_dma_sync_single(struct pci_dev *hwdev, dma_addr_t dma_handle, size_t size, int direction);
+extern void pci_dma_sync_single(struct pci_dev *hwdev, dma_addr_t dma_handle,
+				size_t size, int direction);
+extern void pci64_dma_sync_single(struct pci_dev *hwdev, dma64_addr_t dma_handle,
+				  size_t size, int direction);
 
 /* Make physical memory consistent for a set of streaming
  * mode DMA translations after a transfer.
@@ -105,13 +137,14 @@
  * same rules and usage.
  */
 extern void pci_dma_sync_sg(struct pci_dev *hwdev, struct scatterlist *sg, int nelems, int direction);
+extern void pci64_dma_sync_sg(struct pci_dev *hwdev, struct scatterlist *sg, int nelems, int direction);
 
 /* Return whether the given PCI device DMA address mask can
  * be supported properly.  For example, if your device can
  * only drive the low 24-bits during PCI bus mastering, then
  * you would pass 0x00ffffff as the mask to this function.
  */
-extern int pci_dma_supported(struct pci_dev *hwdev, dma_addr_t mask);
+extern int pci_dma_supported(struct pci_dev *hwdev, u64 mask);
 
 /* Return the index of the PCI controller for device PDEV. */
 
--- ./include/asm-sparc64/scatterlist.h.~1~	Tue Nov 28 08:33:08 2000
+++ ./include/asm-sparc64/scatterlist.h	Thu Aug 16 04:51:36 2001
@@ -5,17 +5,24 @@
 #include <asm/page.h>
 
 struct scatterlist {
-    char *  address;    /* Location data is to be transferred to */
-    char * alt_address; /* Location of actual if address is a 
-			 * dma indirect buffer.  NULL otherwise */
-    unsigned int length;
+	/* This will disappear in 2.5.x */
+	char *address;
 
-    __u32 dvma_address; /* A place to hang host-specific addresses at. */
-    __u32 dvma_length;
+	/* These two are only valid if ADDRESS member of this
+	 * struct is NULL.
+	 */
+	struct page *page;
+	unsigned int offset;
+
+	unsigned int length;
+
+	dma64_addr_t dma_address;
+	__u32 dma_length;
 };
 
-#define sg_dma_address(sg) ((sg)->dvma_address)
-#define sg_dma_len(sg)     ((sg)->dvma_length)
+#define sg_dma_address(sg)	((dma_addr_t) ((sg)->dma_address))
+#define sg_dma64_address(sg)	((sg)->dma_address)
+#define sg_dma_len(sg)     	((sg)->dma_length)
 
 #define ISA_DMA_THRESHOLD	(~0UL)
 
--- ./include/linux/pci.h.~1~	Tue Aug 14 21:31:11 2001
+++ ./include/linux/pci.h	Wed Aug 15 06:43:53 2001
@@ -314,6 +314,12 @@
 #define PCI_DMA_FROMDEVICE	2
 #define PCI_DMA_NONE		3
 
+/* These are the boolean attributes stored in pci_dev->dma_flags. */
+#define PCI_DMA_FLAG_HUGE_MAPS	0x00000001 /* Device may hold an enormous number
+					    * of mappings at once?
+					    */
+#define PCI_DMA_FLAG_ARCHMASK	0xf0000000 /* Reserved for arch-specific flags */
+
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_IRQ	2
 #define DEVICE_COUNT_DMA	2
@@ -353,11 +359,12 @@
 
 	struct pci_driver *driver;	/* which driver has allocated this device */
 	void		*driver_data;	/* data private to the driver */
-	dma_addr_t	dma_mask;	/* Mask of the bits of bus address this
+	u64		dma_mask;	/* Mask of the bits of bus address this
 					   device implements.  Normally this is
 					   0xffffffff.  You only need to change
 					   this if your device has broken DMA
 					   or supports 64-bit transfers.  */
+	unsigned int	dma_flags;	/* See PCI_DMA_FLAG_* above */
 
 	u32             current_state;  /* Current operating state. In ACPI-speak,
 					   this is D0-D3, D0 being fully functional,
@@ -559,7 +566,8 @@
 int pci_enable_device(struct pci_dev *dev);
 void pci_disable_device(struct pci_dev *dev);
 void pci_set_master(struct pci_dev *dev);
-int pci_set_dma_mask(struct pci_dev *dev, dma_addr_t mask);
+int pci_set_dma_mask(struct pci_dev *dev, u64 mask);
+void pci_change_dma_flag(struct pci_dev *dev, unsigned int on, unsigned int off);
 int pci_assign_resource(struct pci_dev *dev, int i);
 
 /* Power management related routines */
@@ -641,7 +649,8 @@
 static inline int pci_enable_device(struct pci_dev *dev) { return -EIO; }
 static inline void pci_disable_device(struct pci_dev *dev) { }
 static inline int pci_module_init(struct pci_driver *drv) { return -ENODEV; }
-static inline int pci_set_dma_mask(struct pci_dev *dev, dma_addr_t mask) { return -EIO; }
+static inline int pci_set_dma_mask(struct pci_dev *dev, u64 mask) { return -EIO; }
+static inline void pci_change_dma_flag(struct pci_dev *dev, unsigned int on, unsigned int off) { }
 static inline int pci_assign_resource(struct pci_dev *dev, int i) { return -EBUSY;}
 static inline int pci_register_driver(struct pci_driver *drv) { return 0;}
 static inline void pci_unregister_driver(struct pci_driver *drv) { }
--- ./include/asm-sh/pci.h.~1~	Fri Jun 29 14:26:55 2001
+++ ./include/asm-sh/pci.h	Wed Aug 15 03:06:33 2001
@@ -167,7 +167,7 @@
  * only drive the low 24-bits during PCI bus mastering, then
  * you would pass 0x00ffffff as the mask to this function.
  */
-extern inline int pci_dma_supported(struct pci_dev *hwdev, dma_addr_t mask)
+extern inline int pci_dma_supported(struct pci_dev *hwdev, u64 mask)
 {
 	return 1;
 }
--- ./include/asm-sh/scatterlist.h.~1~	Tue Nov 28 08:33:08 2000
+++ ./include/asm-sh/scatterlist.h	Thu Aug 16 04:51:43 2001
@@ -3,8 +3,6 @@
 
 struct scatterlist {
     char *  address;    /* Location data is to be transferred to */
-    char * alt_address; /* Location of actual if address is a 
-			 * dma indirect buffer.  NULL otherwise */
     unsigned int length;
 };
 
--- ./include/asm-s390/scatterlist.h.~1~	Fri Feb 16 21:04:19 2001
+++ ./include/asm-s390/scatterlist.h	Thu Aug 16 04:51:50 2001
@@ -3,8 +3,6 @@
 
 struct scatterlist {
     char *  address;    /* Location data is to be transferred to */
-    char * alt_address; /* Location of actual if address is a 
-			 * dma indirect buffer.  NULL otherwise */
     unsigned int length;
 };
 
--- ./include/asm-ia64/pci.h.~1~	Sat May 12 03:47:41 2001
+++ ./include/asm-ia64/pci.h	Wed Aug 15 03:06:42 2001
@@ -52,7 +52,7 @@
  * you would pass 0x00ffffff as the mask to this function.
  */
 static inline int
-pci_dma_supported (struct pci_dev *hwdev, dma_addr_t mask)
+pci_dma_supported (struct pci_dev *hwdev, u64 mask)
 {
 	return 1;
 }
--- ./include/asm-ia64/scatterlist.h.~1~	Tue Nov 28 08:33:08 2000
+++ ./include/asm-ia64/scatterlist.h	Thu Aug 16 04:52:17 2001
@@ -8,11 +8,6 @@
 
 struct scatterlist {
 	char *address;		/* location data is to be transferred to */
-	/*
-	 * Location of actual buffer if ADDRESS points to a DMA
-	 * indirection buffer, NULL otherwise:
-	 */
-	char *alt_address;
 	char *orig_address;	/* Save away the original buffer address (used by pci-dma.c) */
 	unsigned int length;	/* buffer length */
 };
--- ./include/asm-mips64/pci.h.~1~	Thu Jul  5 16:52:48 2001
+++ ./include/asm-mips64/pci.h	Wed Aug 15 03:06:49 2001
@@ -195,7 +195,7 @@
 #endif
 }
 
-extern inline int pci_dma_supported(struct pci_dev *hwdev, dma_addr_t mask)
+extern inline int pci_dma_supported(struct pci_dev *hwdev, u64 mask)
 {
 	/*
 	 * we fall back to GFP_DMA when the mask isn't all 1s,
--- ./include/asm-mips64/scatterlist.h.~1~	Tue Nov 28 08:33:08 2000
+++ ./include/asm-mips64/scatterlist.h	Thu Aug 16 04:52:23 2001
@@ -3,8 +3,6 @@
 
 struct scatterlist {
     char *  address;    /* Location data is to be transferred to */
-    char * alt_address; /* Location of actual if address is a 
-			 * dma indirect buffer.  NULL otherwise */
     unsigned int length;
     
     __u32 dvma_address;
--- ./include/asm-parisc/pci.h.~1~	Sat May 12 03:47:41 2001
+++ ./include/asm-parisc/pci.h	Wed Aug 15 03:07:07 2001
@@ -113,7 +113,7 @@
 ** See Documentation/DMA-mapping.txt
 */
 struct pci_dma_ops {
-	int  (*dma_supported)(struct pci_dev *dev, dma_addr_t mask);
+	int  (*dma_supported)(struct pci_dev *dev, u64 mask);
 	void *(*alloc_consistent)(struct pci_dev *dev, size_t size, dma_addr_t *iova);
 	void (*free_consistent)(struct pci_dev *dev, size_t size, void *vaddr, dma_addr_t iova);
 	dma_addr_t (*map_single)(struct pci_dev *dev, void *addr, size_t size, int direction);
--- ./include/asm-parisc/scatterlist.h.~1~	Wed Dec  6 05:30:34 2000
+++ ./include/asm-parisc/scatterlist.h	Thu Aug 16 04:52:28 2001
@@ -3,8 +3,6 @@
 
 struct scatterlist {
 	char *  address;    /* Location data is to be transferred to */
-	char * alt_address; /* Location of actual if address is a 
-			     * dma indirect buffer.  NULL otherwise */
 	unsigned int length;
 
 	/* an IOVA can be 64-bits on some PA-Risc platforms. */
--- ./include/asm-s390x/scatterlist.h.~1~	Fri Feb 16 21:04:20 2001
+++ ./include/asm-s390x/scatterlist.h	Thu Aug 16 04:52:35 2001
@@ -3,8 +3,6 @@
 
 struct scatterlist {
     char *  address;    /* Location data is to be transferred to */
-    char * alt_address; /* Location of actual if address is a 
-			 * dma indirect buffer.  NULL otherwise */
     unsigned int length;
 };
 
--- ./net/ipv6/mcast.c.~1~	Wed Apr 25 13:46:34 2001
+++ ./net/ipv6/mcast.c	Wed Aug 15 00:36:31 2001
@@ -5,7 +5,7 @@
  *	Authors:
  *	Pedro Roque		<roque@di.fc.ul.pt>	
  *
- *	$Id: mcast.c,v 1.37 2001/04/25 20:46:34 davem Exp $
+ *	$Id: mcast.c,v 1.38 2001/08/15 07:36:31 davem Exp $
  *
  *	Based on linux/ipv4/igmp.c and linux/ipv4/ip_sockglue.c 
  *
@@ -90,7 +90,6 @@
 
 	mc_lst->next = NULL;
 	memcpy(&mc_lst->addr, addr, sizeof(struct in6_addr));
-	mc_lst->ifindex = ifindex;
 
 	if (ifindex == 0) {
 		struct rt6_info *rt;
@@ -107,6 +106,8 @@
 		sock_kfree_s(sk, mc_lst, sizeof(*mc_lst));
 		return -ENODEV;
 	}
+
+	mc_lst->ifindex = dev->ifindex;
 
 	/*
 	 *	now add/increase the group membership on the device
