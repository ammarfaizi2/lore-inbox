Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932428AbWDMC27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbWDMC27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 22:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWDMC27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 22:28:59 -0400
Received: from lixom.net ([66.141.50.11]:2719 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S932428AbWDMC26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 22:28:58 -0400
Date: Wed, 12 Apr 2006 21:05:59 -0500
To: paulus@samba.org
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] [1/2] POWERPC: IOMMU support for honoring dma_mask
Message-ID: <20060413020559.GC24769@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Paulus -- Ben mentioned being interested in this going into 2.6.17,
since the bcm43xx driver will need it to be usable on G5s with more than
1GB memory.

Built with iseries_defconfig and ppc64_defconfig, boot tested on pSeries
and G5, but I'm away from home so I haven't been able to install an
Airport card in the G5.

Since time is somewhat of essense (if 2.6.17 is still an option), I went
for the choice of sending now and follow up with a small bugfix later
in case something shows up, especially since quick regression tests seem
ok.


Thanks,

Olof


---




Some devices don't support full 32-bit DMA address space, which we currently
assume. Add the required mask-passing to the IOMMU allocators.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: 2.6/arch/powerpc/kernel/iommu.c
===================================================================
--- 2.6.orig/arch/powerpc/kernel/iommu.c
+++ 2.6/arch/powerpc/kernel/iommu.c
@@ -61,6 +61,7 @@ __setup("iommu=", setup_iommu);
 static unsigned long iommu_range_alloc(struct iommu_table *tbl,
                                        unsigned long npages,
                                        unsigned long *handle,
+                                       unsigned long mask,
                                        unsigned int align_order)
 { 
 	unsigned long n, end, i, start;
@@ -97,9 +98,21 @@ static unsigned long iommu_range_alloc(s
 	 */
 	if (start >= limit)
 		start = largealloc ? tbl->it_largehint : tbl->it_hint;
-	
+
  again:
 
+	if (limit + tbl->it_offset > mask) {
+		limit = mask - tbl->it_offset + 1;
+		/* If we're constrained on address range, first try
+		 * at the masked hint to avoid O(n) search complexity,
+		 * but on second pass, start at 0.
+		 */
+		if ((start & mask) >= limit || pass > 0)
+			start = 0;
+		else
+			start &= mask;
+	}
+
 	n = find_next_zero_bit(tbl->it_map, limit, start);
 
 	/* Align allocation */
@@ -150,14 +163,14 @@ static unsigned long iommu_range_alloc(s
 
 static dma_addr_t iommu_alloc(struct iommu_table *tbl, void *page,
 		       unsigned int npages, enum dma_data_direction direction,
-		       unsigned int align_order)
+		       unsigned long mask, unsigned int align_order)
 {
 	unsigned long entry, flags;
 	dma_addr_t ret = DMA_ERROR_CODE;
-	
+
 	spin_lock_irqsave(&(tbl->it_lock), flags);
 
-	entry = iommu_range_alloc(tbl, npages, NULL, align_order);
+	entry = iommu_range_alloc(tbl, npages, NULL, mask, align_order);
 
 	if (unlikely(entry == DMA_ERROR_CODE)) {
 		spin_unlock_irqrestore(&(tbl->it_lock), flags);
@@ -236,7 +249,7 @@ static void iommu_free(struct iommu_tabl
 
 int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		struct scatterlist *sglist, int nelems,
-		enum dma_data_direction direction)
+		unsigned long mask, enum dma_data_direction direction)
 {
 	dma_addr_t dma_next = 0, dma_addr;
 	unsigned long flags;
@@ -274,7 +287,7 @@ int iommu_map_sg(struct device *dev, str
 		vaddr = (unsigned long)page_address(s->page) + s->offset;
 		npages = PAGE_ALIGN(vaddr + slen) - (vaddr & PAGE_MASK);
 		npages >>= PAGE_SHIFT;
-		entry = iommu_range_alloc(tbl, npages, &handle, 0);
+		entry = iommu_range_alloc(tbl, npages, &handle, mask >> PAGE_SHIFT, 0);
 
 		DBG("  - vaddr: %lx, size: %lx\n", vaddr, slen);
 
@@ -479,7 +492,8 @@ void iommu_free_table(struct device_node
  * byte within the page as vaddr.
  */
 dma_addr_t iommu_map_single(struct iommu_table *tbl, void *vaddr,
-		size_t size, enum dma_data_direction direction)
+		size_t size, unsigned long mask,
+		enum dma_data_direction direction)
 {
 	dma_addr_t dma_handle = DMA_ERROR_CODE;
 	unsigned long uaddr;
@@ -492,7 +506,8 @@ dma_addr_t iommu_map_single(struct iommu
 	npages >>= PAGE_SHIFT;
 
 	if (tbl) {
-		dma_handle = iommu_alloc(tbl, vaddr, npages, direction, 0);
+		dma_handle = iommu_alloc(tbl, vaddr, npages, direction,
+					 mask >> PAGE_SHIFT, 0);
 		if (dma_handle == DMA_ERROR_CODE) {
 			if (printk_ratelimit())  {
 				printk(KERN_INFO "iommu_alloc failed, "
@@ -521,7 +536,7 @@ void iommu_unmap_single(struct iommu_tab
  * to the dma address (mapping) of the first page.
  */
 void *iommu_alloc_coherent(struct iommu_table *tbl, size_t size,
-		dma_addr_t *dma_handle, gfp_t flag)
+		dma_addr_t *dma_handle, unsigned long mask, gfp_t flag)
 {
 	void *ret = NULL;
 	dma_addr_t mapping;
@@ -551,7 +566,8 @@ void *iommu_alloc_coherent(struct iommu_
 	memset(ret, 0, size);
 
 	/* Set up tces to cover the allocated range */
-	mapping = iommu_alloc(tbl, ret, npages, DMA_BIDIRECTIONAL, order);
+	mapping = iommu_alloc(tbl, ret, npages, DMA_BIDIRECTIONAL,
+			      mask >> PAGE_SHIFT, order);
 	if (mapping == DMA_ERROR_CODE) {
 		free_pages((unsigned long)ret, order);
 		ret = NULL;
Index: 2.6/arch/powerpc/kernel/vio.c
===================================================================
--- 2.6.orig/arch/powerpc/kernel/vio.c
+++ 2.6/arch/powerpc/kernel/vio.c
@@ -202,7 +202,7 @@ static dma_addr_t vio_map_single(struct 
 			  size_t size, enum dma_data_direction direction)
 {
 	return iommu_map_single(to_vio_dev(dev)->iommu_table, vaddr, size,
-			direction);
+			~0ul, direction);
 }
 
 static void vio_unmap_single(struct device *dev, dma_addr_t dma_handle,
@@ -216,7 +216,7 @@ static int vio_map_sg(struct device *dev
 		int nelems, enum dma_data_direction direction)
 {
 	return iommu_map_sg(dev, to_vio_dev(dev)->iommu_table, sglist,
-			nelems, direction);
+			nelems, ~0ul, direction);
 }
 
 static void vio_unmap_sg(struct device *dev, struct scatterlist *sglist,
@@ -229,7 +229,7 @@ static void *vio_alloc_coherent(struct d
 			   dma_addr_t *dma_handle, gfp_t flag)
 {
 	return iommu_alloc_coherent(to_vio_dev(dev)->iommu_table, size,
-			dma_handle, flag);
+			dma_handle, ~0ul, flag);
 }
 
 static void vio_free_coherent(struct device *dev, size_t size,
Index: 2.6/include/asm-powerpc/iommu.h
===================================================================
--- 2.6.orig/include/asm-powerpc/iommu.h
+++ 2.6/include/asm-powerpc/iommu.h
@@ -70,17 +70,18 @@ extern void iommu_free_table(struct devi
 extern struct iommu_table *iommu_init_table(struct iommu_table * tbl);
 
 extern int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
-		struct scatterlist *sglist, int nelems,
+		struct scatterlist *sglist, int nelems, unsigned long mask,
 		enum dma_data_direction direction);
 extern void iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
 		int nelems, enum dma_data_direction direction);
 
 extern void *iommu_alloc_coherent(struct iommu_table *tbl, size_t size,
-		dma_addr_t *dma_handle, gfp_t flag);
+		dma_addr_t *dma_handle, unsigned long mask, gfp_t flag);
 extern void iommu_free_coherent(struct iommu_table *tbl, size_t size,
 		void *vaddr, dma_addr_t dma_handle);
 extern dma_addr_t iommu_map_single(struct iommu_table *tbl, void *vaddr,
-		size_t size, enum dma_data_direction direction);
+		size_t size, unsigned long mask,
+		enum dma_data_direction direction);
 extern void iommu_unmap_single(struct iommu_table *tbl, dma_addr_t dma_handle,
 		size_t size, enum dma_data_direction direction);
 
Index: 2.6/arch/powerpc/kernel/pci_iommu.c
===================================================================
--- 2.6.orig/arch/powerpc/kernel/pci_iommu.c
+++ 2.6/arch/powerpc/kernel/pci_iommu.c
@@ -59,6 +59,25 @@ static inline struct iommu_table *devnod
 }
 
 
+static inline unsigned long device_to_mask(struct device *hwdev)
+{
+	struct pci_dev *pdev;
+
+	if (!hwdev) {
+		pdev = ppc64_isabridge_dev;
+		if (!pdev) /* This is the best guess we can do */
+			return 0xfffffffful;
+	} else
+		pdev = to_pci_dev(hwdev);
+
+	if (pdev->dma_mask)
+		return pdev->dma_mask;
+
+	/* Assume devices without mask can take 32 bit addresses */
+	return 0xfffffffful;
+}
+
+
 /* Allocates a contiguous real buffer and creates mappings over it.
  * Returns the virtual address of the buffer and sets dma_handle
  * to the dma address (mapping) of the first page.
@@ -67,7 +86,7 @@ static void *pci_iommu_alloc_coherent(st
 			   dma_addr_t *dma_handle, gfp_t flag)
 {
 	return iommu_alloc_coherent(devnode_table(hwdev), size, dma_handle,
-			flag);
+			device_to_mask(hwdev), flag);
 }
 
 static void pci_iommu_free_coherent(struct device *hwdev, size_t size,
@@ -86,7 +105,7 @@ static dma_addr_t pci_iommu_map_single(s
 		size_t size, enum dma_data_direction direction)
 {
 	return iommu_map_single(devnode_table(hwdev), vaddr, size, 
-			        direction);
+			        device_to_mask(hwdev), direction);
 }
 
 
@@ -101,7 +120,7 @@ static int pci_iommu_map_sg(struct devic
 		int nelems, enum dma_data_direction direction)
 {
 	return iommu_map_sg(pdev, devnode_table(pdev), sglist,
-			nelems, direction);
+			nelems, device_to_mask(pdev), direction);
 }
 
 static void pci_iommu_unmap_sg(struct device *pdev, struct scatterlist *sglist,
@@ -113,7 +132,19 @@ static void pci_iommu_unmap_sg(struct de
 /* We support DMA to/from any memory page via the iommu */
 static int pci_iommu_dma_supported(struct device *dev, u64 mask)
 {
-	return 1;
+	struct iommu_table *tbl = devnode_table(dev);
+	
+	if (!tbl || tbl->it_offset > mask) {
+		printk(KERN_INFO "Warning: IOMMU table offset too big for device mask\n");
+		if (tbl)
+			printk(KERN_INFO "mask: 0x%08lx, table offset: 0x%08lx\n",
+				mask, tbl->it_offset);
+		else
+			printk(KERN_INFO "mask: 0x%08lx, table unavailable\n",
+				mask);
+		return 0;
+	} else
+		return 1;
 }
 
 void pci_iommu_init(void)
