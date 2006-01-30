Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWA3JqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWA3JqY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWA3JqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:46:24 -0500
Received: from mtaout4.012.net.il ([84.95.2.10]:52201 "EHLO mtaout4.012.net.il")
	by vger.kernel.org with ESMTP id S932172AbWA3JqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:46:23 -0500
Date: Mon, 30 Jan 2006 11:44:34 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [PATCH RESEND] move swiotlb.h header file to asm-generic
To: Andrew Morton <akpm@osdl.org>
Cc: Jon Mason <jdmason@us.ibm.com>, Christoph Hellwig <hch@lst.de>,
       Andi Kleen <ak@suse.de>, "Luck, Tony" <tony.luck@intel.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Muli Ben-Yehuda <MULI@il.ibm.com>
Message-id: <20060130094434.GG23968@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:

- creates asm-generic/swiotlb.h
- makes it use 'enum dma_data_direction dir' rather than 'int dir'
- updates x86-64 and IA64 to use the common swiotlb.h
- fixes the resulting fall out (s/int dir/enum dma_data_direction dir/
  all over the place).

Generated code should be functionally equivalent. Compile tested on
x86-64 (w/ gart, nommu and swiotlb) and IA66 (defconfig). Patch is
against 2.6.16-rc1-mm4.

Signed-off-by: Muli Ben-Yehuda <mulix@mulix.org>

muli@granada:~/tmp$ diffstat move-swiotlb-header-to-common-code-B2 
 arch/ia64/hp/common/hwsw_iommu.c           |   24 +++++++---
 arch/ia64/hp/common/sba_iommu.c            |   12 +++--
 arch/ia64/kernel/machvec.c                 |    6 +-
 arch/ia64/sn/kernel/io_init.c              |    3 -
 arch/ia64/sn/pci/pci_dma.c                 |   16 +++----
 arch/ia64/sn/pci/pcibr/pcibr_dma.c         |    3 -
 arch/ia64/sn/pci/tioca_provider.c          |    3 -
 arch/ia64/sn/pci/tioce_provider.c          |    3 -
 arch/x86_64/kernel/pci-gart.c              |   19 ++++----
 arch/x86_64/kernel/pci-nommu.c             |    8 +--
 include/asm-generic/swiotlb.h              |   64 +++++++++++++++++++++++++++++
 include/asm-ia64/machvec.h                 |   23 +++++-----
 include/asm-ia64/sn/pcibr_provider.h       |    2 
 include/asm-ia64/sn/pcibus_provider_defs.h |    4 +
 include/asm-x86_64/dma-mapping.h           |   45 ++++++++++----------
 include/asm-x86_64/swiotlb.h               |   43 -------------------
 include/linux/dma-data-direction.h         |   13 +++++
 include/linux/dma-mapping.h                |   10 ----
 lib/swiotlb.c                              |   41 ++++++++++--------
 19 files changed, 204 insertions(+), 138 deletions(-)

diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/arch/ia64/hp/common/hwsw_iommu.c mm4.swiotlb/arch/ia64/hp/common/hwsw_iommu.c
--- mm4.orig/arch/ia64/hp/common/hwsw_iommu.c	2006-01-30 10:33:12.000000000 +0200
+++ mm4.swiotlb/arch/ia64/hp/common/hwsw_iommu.c	2006-01-30 10:46:24.000000000 +0200
@@ -98,7 +98,8 @@ hwsw_free_coherent (struct device *dev, 
 }
 
 dma_addr_t
-hwsw_map_single (struct device *dev, void *addr, size_t size, int dir)
+hwsw_map_single (struct device *dev, void *addr, size_t size,
+		 enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		return swiotlb_map_single(dev, addr, size, dir);
@@ -107,7 +108,8 @@ hwsw_map_single (struct device *dev, voi
 }
 
 void
-hwsw_unmap_single (struct device *dev, dma_addr_t iova, size_t size, int dir)
+hwsw_unmap_single (struct device *dev, dma_addr_t iova, size_t size,
+		   enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		return swiotlb_unmap_single(dev, iova, size, dir);
@@ -117,7 +119,8 @@ hwsw_unmap_single (struct device *dev, d
 
 
 int
-hwsw_map_sg (struct device *dev, struct scatterlist *sglist, int nents, int dir)
+hwsw_map_sg (struct device *dev, struct scatterlist *sglist, int nents,
+	     enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		return swiotlb_map_sg(dev, sglist, nents, dir);
@@ -126,7 +129,8 @@ hwsw_map_sg (struct device *dev, struct 
 }
 
 void
-hwsw_unmap_sg (struct device *dev, struct scatterlist *sglist, int nents, int dir)
+hwsw_unmap_sg (struct device *dev, struct scatterlist *sglist, int nents,
+	       enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		return swiotlb_unmap_sg(dev, sglist, nents, dir);
@@ -135,7 +139,8 @@ hwsw_unmap_sg (struct device *dev, struc
 }
 
 void
-hwsw_sync_single_for_cpu (struct device *dev, dma_addr_t addr, size_t size, int dir)
+hwsw_sync_single_for_cpu (struct device *dev, dma_addr_t addr, size_t size,
+			  enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		swiotlb_sync_single_for_cpu(dev, addr, size, dir);
@@ -144,7 +149,8 @@ hwsw_sync_single_for_cpu (struct device 
 }
 
 void
-hwsw_sync_sg_for_cpu (struct device *dev, struct scatterlist *sg, int nelems, int dir)
+hwsw_sync_sg_for_cpu (struct device *dev, struct scatterlist *sg, int nelems,
+		      enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		swiotlb_sync_sg_for_cpu(dev, sg, nelems, dir);
@@ -153,7 +159,8 @@ hwsw_sync_sg_for_cpu (struct device *dev
 }
 
 void
-hwsw_sync_single_for_device (struct device *dev, dma_addr_t addr, size_t size, int dir)
+hwsw_sync_single_for_device (struct device *dev, dma_addr_t addr, size_t size,
+			     enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		swiotlb_sync_single_for_device(dev, addr, size, dir);
@@ -162,7 +169,8 @@ hwsw_sync_single_for_device (struct devi
 }
 
 void
-hwsw_sync_sg_for_device (struct device *dev, struct scatterlist *sg, int nelems, int dir)
+hwsw_sync_sg_for_device (struct device *dev, struct scatterlist *sg, int nelems,
+			 enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		swiotlb_sync_sg_for_device(dev, sg, nelems, dir);
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/arch/ia64/hp/common/sba_iommu.c mm4.swiotlb/arch/ia64/hp/common/sba_iommu.c
--- mm4.orig/arch/ia64/hp/common/sba_iommu.c	2006-01-30 10:33:12.000000000 +0200
+++ mm4.swiotlb/arch/ia64/hp/common/sba_iommu.c	2006-01-30 10:46:24.000000000 +0200
@@ -884,7 +884,8 @@ sba_mark_invalid(struct ioc *ioc, dma_ad
  * See Documentation/DMA-mapping.txt
  */
 dma_addr_t
-sba_map_single(struct device *dev, void *addr, size_t size, int dir)
+sba_map_single(struct device *dev, void *addr, size_t size,
+	       enum dma_data_direction dir)
 {
 	struct ioc *ioc;
 	dma_addr_t iovp;
@@ -998,7 +999,8 @@ sba_mark_clean(struct ioc *ioc, dma_addr
  *
  * See Documentation/DMA-mapping.txt
  */
-void sba_unmap_single(struct device *dev, dma_addr_t iova, size_t size, int dir)
+void sba_unmap_single(struct device *dev, dma_addr_t iova, size_t size,
+		      enum dma_data_direction dir)
 {
 	struct ioc *ioc;
 #if DELAYED_RESOURCE_CNT > 0
@@ -1387,7 +1389,8 @@ sba_coalesce_chunks( struct ioc *ioc,
  *
  * See Documentation/DMA-mapping.txt
  */
-int sba_map_sg(struct device *dev, struct scatterlist *sglist, int nents, int dir)
+int sba_map_sg(struct device *dev, struct scatterlist *sglist, int nents,
+	       enum dma_data_direction dir)
 {
 	struct ioc *ioc;
 	int coalesced, filled = 0;
@@ -1477,7 +1480,8 @@ int sba_map_sg(struct device *dev, struc
  *
  * See Documentation/DMA-mapping.txt
  */
-void sba_unmap_sg (struct device *dev, struct scatterlist *sglist, int nents, int dir)
+void sba_unmap_sg (struct device *dev, struct scatterlist *sglist, int nents,
+		   enum dma_data_direction dir)
 {
 #ifdef ASSERT_PDIR_SANITY
 	struct ioc *ioc;
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/arch/ia64/kernel/machvec.c mm4.swiotlb/arch/ia64/kernel/machvec.c
--- mm4.orig/arch/ia64/kernel/machvec.c	2005-06-17 22:48:29.000000000 +0300
+++ mm4.swiotlb/arch/ia64/kernel/machvec.c	2006-01-30 10:46:24.000000000 +0200
@@ -56,14 +56,16 @@ machvec_timer_interrupt (int irq, void *
 EXPORT_SYMBOL(machvec_timer_interrupt);
 
 void
-machvec_dma_sync_single (struct device *hwdev, dma_addr_t dma_handle, size_t size, int dir)
+machvec_dma_sync_single (struct device *hwdev, dma_addr_t dma_handle, size_t size,
+			 enum dma_data_direction dir)
 {
 	mb();
 }
 EXPORT_SYMBOL(machvec_dma_sync_single);
 
 void
-machvec_dma_sync_sg (struct device *hwdev, struct scatterlist *sg, int n, int dir)
+machvec_dma_sync_sg (struct device *hwdev, struct scatterlist *sg, int n,
+		     enum dma_data_direction dir)
 {
 	mb();
 }
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/arch/ia64/sn/kernel/io_init.c mm4.swiotlb/arch/ia64/sn/kernel/io_init.c
--- mm4.orig/arch/ia64/sn/kernel/io_init.c	2006-01-30 10:34:57.000000000 +0200
+++ mm4.swiotlb/arch/ia64/sn/kernel/io_init.c	2006-01-30 10:46:24.000000000 +0200
@@ -58,7 +58,8 @@ sn_default_pci_map(struct pci_dev *pdev,
 }
 
 static void
-sn_default_pci_unmap(struct pci_dev *pdev, dma_addr_t addr, int direction)
+sn_default_pci_unmap(struct pci_dev *pdev, dma_addr_t addr,
+		     enum dma_data_direction direction)
 {
 	return;
 }
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/arch/ia64/sn/pci/pcibr/pcibr_dma.c mm4.swiotlb/arch/ia64/sn/pci/pcibr/pcibr_dma.c
--- mm4.orig/arch/ia64/sn/pci/pcibr/pcibr_dma.c	2006-01-30 10:34:57.000000000 +0200
+++ mm4.swiotlb/arch/ia64/sn/pci/pcibr/pcibr_dma.c	2006-01-30 10:46:24.000000000 +0200
@@ -204,7 +204,8 @@ pcibr_dmatrans_direct32(struct pcidev_in
  * DMA mappings for Direct 64 and 32 do not have any DMA maps.
  */
 void
-pcibr_dma_unmap(struct pci_dev *hwdev, dma_addr_t dma_handle, int direction)
+pcibr_dma_unmap(struct pci_dev *hwdev, dma_addr_t dma_handle,
+		enum dma_data_direction direction)
 {
 	struct pcidev_info *pcidev_info = SN_PCIDEV_INFO(hwdev);
 	struct pcibus_info *pcibus_info =
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/arch/ia64/sn/pci/pci_dma.c mm4.swiotlb/arch/ia64/sn/pci/pci_dma.c
--- mm4.orig/arch/ia64/sn/pci/pci_dma.c	2006-01-30 10:34:57.000000000 +0200
+++ mm4.swiotlb/arch/ia64/sn/pci/pci_dma.c	2006-01-30 10:46:24.000000000 +0200
@@ -167,7 +167,7 @@ EXPORT_SYMBOL(sn_dma_free_coherent);
  *       figure out how to save dmamap handle so can use two step.
  */
 dma_addr_t sn_dma_map_single(struct device *dev, void *cpu_addr, size_t size,
-			     int direction)
+			     enum dma_data_direction direction)
 {
 	dma_addr_t dma_addr;
 	unsigned long phys_addr;
@@ -198,7 +198,7 @@ EXPORT_SYMBOL(sn_dma_map_single);
  * coherent, so we just need to free any ATEs associated with this mapping.
  */
 void sn_dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-			 int direction)
+			 enum dma_data_direction direction)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct sn_pcibus_provider *provider = SN_PCIDEV_BUSPROVIDER(pdev);
@@ -219,7 +219,7 @@ EXPORT_SYMBOL(sn_dma_unmap_single);
  * Unmap a set of streaming mode DMA translations.
  */
 void sn_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-		     int nhwentries, int direction)
+		     int nhwentries, enum dma_data_direction direction)
 {
 	int i;
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -245,7 +245,7 @@ EXPORT_SYMBOL(sn_dma_unmap_sg);
  * Maps each entry of @sg for DMA.
  */
 int sn_dma_map_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-		  int direction)
+		  enum dma_data_direction direction)
 {
 	unsigned long phys_addr;
 	struct scatterlist *saved_sg = sg;
@@ -283,28 +283,28 @@ int sn_dma_map_sg(struct device *dev, st
 EXPORT_SYMBOL(sn_dma_map_sg);
 
 void sn_dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
-				size_t size, int direction)
+				size_t size, enum dma_data_direction direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 }
 EXPORT_SYMBOL(sn_dma_sync_single_for_cpu);
 
 void sn_dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
-				   size_t size, int direction)
+				   size_t size, enum dma_data_direction direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 }
 EXPORT_SYMBOL(sn_dma_sync_single_for_device);
 
 void sn_dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-			    int nelems, int direction)
+			    int nelems, enum dma_data_direction direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 }
 EXPORT_SYMBOL(sn_dma_sync_sg_for_cpu);
 
 void sn_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-			       int nelems, int direction)
+			       int nelems, enum dma_data_direction direction)
 {
 	BUG_ON(dev->bus != &pci_bus_type);
 }
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/arch/ia64/sn/pci/tioca_provider.c mm4.swiotlb/arch/ia64/sn/pci/tioca_provider.c
--- mm4.orig/arch/ia64/sn/pci/tioca_provider.c	2006-01-30 10:34:57.000000000 +0200
+++ mm4.swiotlb/arch/ia64/sn/pci/tioca_provider.c	2006-01-30 10:46:24.000000000 +0200
@@ -465,7 +465,8 @@ map_return:
  * resources to release.
  */
 static void
-tioca_dma_unmap(struct pci_dev *pdev, dma_addr_t bus_addr, int dir)
+tioca_dma_unmap(struct pci_dev *pdev, dma_addr_t bus_addr,
+		enum dma_data_direction dir)
 {
 	int i, entry;
 	struct tioca_common *tioca_common;
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/arch/ia64/sn/pci/tioce_provider.c mm4.swiotlb/arch/ia64/sn/pci/tioce_provider.c
--- mm4.orig/arch/ia64/sn/pci/tioce_provider.c	2006-01-30 10:34:57.000000000 +0200
+++ mm4.swiotlb/arch/ia64/sn/pci/tioce_provider.c	2006-01-30 11:26:06.000000000 +0200
@@ -456,7 +456,8 @@ tioce_dma_barrier(u64 bus_addr, int on)
  * to release.
  */
 void
-tioce_dma_unmap(struct pci_dev *pdev, dma_addr_t bus_addr, int dir)
+tioce_dma_unmap(struct pci_dev *pdev, dma_addr_t bus_addr,
+		enum dma_data_direction dir)
 {
 	int i;
 	int port;
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/arch/x86_64/kernel/pci-gart.c mm4.swiotlb/arch/x86_64/kernel/pci-gart.c
--- mm4.orig/arch/x86_64/kernel/pci-gart.c	2006-01-30 10:34:04.000000000 +0200
+++ mm4.swiotlb/arch/x86_64/kernel/pci-gart.c	2006-01-30 10:46:24.000000000 +0200
@@ -193,7 +193,7 @@ void dump_leak(void)
 #define CLEAR_LEAK(x)
 #endif
 
-static void iommu_full(struct device *dev, size_t size, int dir)
+static void iommu_full(struct device *dev, size_t size, enum dma_data_direction dir)
 {
 	/* 
 	 * Ran out of IOMMU space for this operation. This is very bad.
@@ -253,7 +253,7 @@ static inline int nonforced_iommu(struct
  * Caller needs to check if the iommu is needed and flush.
  */
 static dma_addr_t dma_map_area(struct device *dev, dma_addr_t phys_mem,
-				size_t size, int dir)
+				size_t size, enum dma_data_direction dir)
 { 
 	unsigned long npages = to_pages(phys_mem, size);
 	unsigned long iommu_page = alloc_iommu(npages);
@@ -276,7 +276,7 @@ static dma_addr_t dma_map_area(struct de
 }
 
 static dma_addr_t gart_map_simple(struct device *dev, char *buf,
-				 size_t size, int dir)
+				 size_t size, enum dma_data_direction dir)
 {
 	dma_addr_t map = dma_map_area(dev, virt_to_bus(buf), size, dir);
 	flush_gart(dev);
@@ -284,7 +284,8 @@ static dma_addr_t gart_map_simple(struct
 }
 
 /* Map a single area into the IOMMU */
-dma_addr_t gart_map_single(struct device *dev, void *addr, size_t size, int dir)
+dma_addr_t gart_map_single(struct device *dev, void *addr, size_t size,
+			   enum dma_data_direction dir)
 {
 	unsigned long phys_mem, bus;
 
@@ -304,7 +305,8 @@ dma_addr_t gart_map_single(struct device
 /*
  * Wrapper for pci_unmap_single working with scatterlists.
  */
-void gart_unmap_sg(struct device *dev, struct scatterlist *sg, int nents, int dir)
+void gart_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+		   enum dma_data_direction dir)
 {
 	int i;
 
@@ -318,7 +320,7 @@ void gart_unmap_sg(struct device *dev, s
 
 /* Fallback for dma_map_sg in case of overflow */
 static int dma_map_sg_nonforce(struct device *dev, struct scatterlist *sg,
-			       int nents, int dir)
+			       int nents, enum dma_data_direction dir)
 {
 	int i;
 
@@ -402,7 +404,8 @@ static inline int dma_map_cont(struct sc
  * DMA map all entries in a scatterlist.
  * Merge chunks that have page aligned sizes into a continuous mapping. 
  */
-int gart_map_sg(struct device *dev, struct scatterlist *sg, int nents, int dir)
+int gart_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+		enum dma_data_direction dir)
 {
 	int i;
 	int out;
@@ -472,7 +475,7 @@ error:
  * Free a DMA mapping.
  */ 
 void gart_unmap_single(struct device *dev, dma_addr_t dma_addr,
-		      size_t size, int direction)
+		      size_t size, enum dma_data_direction direction)
 {
 	unsigned long iommu_page; 
 	int npages;
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/arch/x86_64/kernel/pci-nommu.c mm4.swiotlb/arch/x86_64/kernel/pci-nommu.c
--- mm4.orig/arch/x86_64/kernel/pci-nommu.c	2006-01-30 10:34:04.000000000 +0200
+++ mm4.swiotlb/arch/x86_64/kernel/pci-nommu.c	2006-01-30 10:46:24.000000000 +0200
@@ -22,7 +22,7 @@ check_addr(char *name, struct device *hw
 
 static dma_addr_t
 nommu_map_single(struct device *hwdev, void *ptr, size_t size,
-	       int direction)
+		 enum dma_data_direction direction)
 {
 	dma_addr_t bus = virt_to_bus(ptr);
 	if (!check_addr("map_single", hwdev, bus, size))
@@ -31,7 +31,7 @@ nommu_map_single(struct device *hwdev, v
 }
 
 void nommu_unmap_single(struct device *dev, dma_addr_t addr,size_t size,
-			int direction)
+			enum dma_data_direction direction)
 {
 }
 
@@ -51,7 +51,7 @@ void nommu_unmap_single(struct device *d
  * the same here.
  */
 int nommu_map_sg(struct device *hwdev, struct scatterlist *sg,
-	       int nents, int direction)
+	       int nents, enum dma_data_direction direction)
 {
 	int i;
 
@@ -72,7 +72,7 @@ int nommu_map_sg(struct device *hwdev, s
  * pci_unmap_single() above.
  */
 void nommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-		  int nents, int dir)
+		  int nents, enum dma_data_direction dir)
 {
 }
 
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/include/asm-generic/swiotlb.h mm4.swiotlb/include/asm-generic/swiotlb.h
--- mm4.orig/include/asm-generic/swiotlb.h	1970-01-01 02:00:00.000000000 +0200
+++ mm4.swiotlb/include/asm-generic/swiotlb.h	2006-01-30 10:46:24.000000000 +0200
@@ -0,0 +1,64 @@
+#ifndef _ASM_GENERIC_SWIOTLB_H
+#define _ASM_GENERIC_SWTIOLB_H 1
+
+#include <linux/dma-data-direction.h>
+
+struct device;
+struct scatterlist;
+
+extern void swiotlb_init(void);
+
+extern int swiotlb_dma_supported(struct device *hwdev, u64 mask);
+
+extern void*
+swiotlb_alloc_coherent(struct device *hwdev, size_t size, dma_addr_t *dma_handle,
+       gfp_t flags);
+
+extern void
+swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
+       dma_addr_t dma_handle);
+
+extern dma_addr_t
+swiotlb_map_single(struct device *hwdev, void *ptr, size_t size,
+        enum dma_data_direction dir);
+
+extern void
+swiotlb_unmap_single(struct device *hwdev, dma_addr_t dev_addr, size_t size,
+        enum dma_data_direction dir);
+
+extern void
+swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr, size_t size,
+       enum dma_data_direction dir);
+
+extern void
+swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
+       size_t size, enum dma_data_direction dir);
+
+extern void
+swiotlb_sync_single_range_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
+       unsigned long offset, size_t size, enum dma_data_direction dir);
+
+extern void
+swiotlb_sync_single_range_for_device(struct device *hwdev, dma_addr_t dev_addr,
+       unsigned long offset, size_t size, enum dma_data_direction dir);
+
+extern void
+swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg, int nelems,
+       enum dma_data_direction dir);
+
+extern void
+swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
+       int nelems, enum dma_data_direction dir);
+
+extern int
+swiotlb_map_sg(struct device *hwdev, struct scatterlist *sg, int nents,
+       enum dma_data_direction direction);
+
+extern void
+swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sg, int nents,
+       enum dma_data_direction direction);
+
+extern int
+swiotlb_dma_mapping_error(dma_addr_t dma_addr);
+
+#endif /* _ASM_GENERIC_SWTIOLB_H */
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/include/asm-ia64/machvec.h mm4.swiotlb/include/asm-ia64/machvec.h
--- mm4.orig/include/asm-ia64/machvec.h	2006-01-30 10:34:59.000000000 +0200
+++ mm4.swiotlb/include/asm-ia64/machvec.h	2006-01-30 10:46:24.000000000 +0200
@@ -12,6 +12,9 @@
 
 #include <linux/config.h>
 #include <linux/types.h>
+#include <linux/dma-data-direction.h>
+
+#include <asm-generic/swiotlb.h>
 
 /* forward declarations: */
 struct device;
@@ -41,14 +44,14 @@ typedef void ia64_mv_migrate_t(struct ta
 typedef void ia64_mv_dma_init (void);
 typedef void *ia64_mv_dma_alloc_coherent (struct device *, size_t, dma_addr_t *, gfp_t);
 typedef void ia64_mv_dma_free_coherent (struct device *, size_t, void *, dma_addr_t);
-typedef dma_addr_t ia64_mv_dma_map_single (struct device *, void *, size_t, int);
-typedef void ia64_mv_dma_unmap_single (struct device *, dma_addr_t, size_t, int);
-typedef int ia64_mv_dma_map_sg (struct device *, struct scatterlist *, int, int);
-typedef void ia64_mv_dma_unmap_sg (struct device *, struct scatterlist *, int, int);
-typedef void ia64_mv_dma_sync_single_for_cpu (struct device *, dma_addr_t, size_t, int);
-typedef void ia64_mv_dma_sync_sg_for_cpu (struct device *, struct scatterlist *, int, int);
-typedef void ia64_mv_dma_sync_single_for_device (struct device *, dma_addr_t, size_t, int);
-typedef void ia64_mv_dma_sync_sg_for_device (struct device *, struct scatterlist *, int, int);
+typedef dma_addr_t ia64_mv_dma_map_single (struct device *, void *, size_t, enum dma_data_direction);
+typedef void ia64_mv_dma_unmap_single (struct device *, dma_addr_t, size_t, enum dma_data_direction);
+typedef int ia64_mv_dma_map_sg (struct device *, struct scatterlist *, int, enum dma_data_direction);
+typedef void ia64_mv_dma_unmap_sg (struct device *, struct scatterlist *, int, enum dma_data_direction);
+typedef void ia64_mv_dma_sync_single_for_cpu (struct device *, dma_addr_t, size_t, enum dma_data_direction);
+typedef void ia64_mv_dma_sync_sg_for_cpu (struct device *, struct scatterlist *, int, enum dma_data_direction);
+typedef void ia64_mv_dma_sync_single_for_device (struct device *, dma_addr_t, size_t, enum dma_data_direction);
+typedef void ia64_mv_dma_sync_sg_for_device (struct device *, struct scatterlist *, int, enum dma_data_direction);
 typedef int ia64_mv_dma_mapping_error (dma_addr_t dma_addr);
 typedef int ia64_mv_dma_supported (struct device *, u64);
 
@@ -95,8 +98,8 @@ machvec_noop_task (struct task_struct *t
 
 extern void machvec_setup (char **);
 extern void machvec_timer_interrupt (int, void *, struct pt_regs *);
-extern void machvec_dma_sync_single (struct device *, dma_addr_t, size_t, int);
-extern void machvec_dma_sync_sg (struct device *, struct scatterlist *, int, int);
+extern void machvec_dma_sync_single (struct device *, dma_addr_t, size_t, enum dma_data_direction);
+extern void machvec_dma_sync_sg (struct device *, struct scatterlist *, int, enum dma_data_direction);
 extern void machvec_tlb_migrate_finish (struct mm_struct *);
 
 # if defined (CONFIG_IA64_HP_SIM)
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/include/asm-ia64/sn/pcibr_provider.h mm4.swiotlb/include/asm-ia64/sn/pcibr_provider.h
--- mm4.orig/include/asm-ia64/sn/pcibr_provider.h	2006-01-30 10:34:59.000000000 +0200
+++ mm4.swiotlb/include/asm-ia64/sn/pcibr_provider.h	2006-01-30 10:46:24.000000000 +0200
@@ -132,7 +132,7 @@ extern int  pcibr_init_provider(void);
 extern void *pcibr_bus_fixup(struct pcibus_bussoft *, struct pci_controller *);
 extern dma_addr_t pcibr_dma_map(struct pci_dev *, unsigned long, size_t, int type);
 extern dma_addr_t pcibr_dma_map_consistent(struct pci_dev *, unsigned long, size_t, int type);
-extern void pcibr_dma_unmap(struct pci_dev *, dma_addr_t, int);
+extern void pcibr_dma_unmap(struct pci_dev *, dma_addr_t, enum dma_data_direction);
 
 /*
  * prototypes for the bridge asic register access routines in pcibr_reg.c
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/include/asm-ia64/sn/pcibus_provider_defs.h mm4.swiotlb/include/asm-ia64/sn/pcibus_provider_defs.h
--- mm4.orig/include/asm-ia64/sn/pcibus_provider_defs.h	2006-01-30 10:34:59.000000000 +0200
+++ mm4.swiotlb/include/asm-ia64/sn/pcibus_provider_defs.h	2006-01-30 10:46:24.000000000 +0200
@@ -8,6 +8,8 @@
 #ifndef _ASM_IA64_SN_PCI_PCIBUS_PROVIDER_H
 #define _ASM_IA64_SN_PCI_PCIBUS_PROVIDER_H
 
+#include <linux/dma-data-direction.h> /* for enum dma_data_direction */
+
 /*
  * SN pci asic types.  Do not ever renumber these or reuse values.  The
  * values must agree with what prom thinks they are.
@@ -47,7 +49,7 @@ struct pci_controller;
 struct sn_pcibus_provider {
 	dma_addr_t	(*dma_map)(struct pci_dev *, unsigned long, size_t, int flags);
 	dma_addr_t	(*dma_map_consistent)(struct pci_dev *, unsigned long, size_t, int flags);
-	void		(*dma_unmap)(struct pci_dev *, dma_addr_t, int);
+	void		(*dma_unmap)(struct pci_dev *, dma_addr_t, enum dma_data_direction);
 	void *		(*bus_fixup)(struct pcibus_bussoft *, struct pci_controller *);
  	void		(*force_interrupt)(struct sn_irq_info *);
  	void		(*target_interrupt)(struct sn_irq_info *);
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/include/asm-x86_64/dma-mapping.h mm4.swiotlb/include/asm-x86_64/dma-mapping.h
--- mm4.orig/include/asm-x86_64/dma-mapping.h	2006-01-30 10:34:11.000000000 +0200
+++ mm4.swiotlb/include/asm-x86_64/dma-mapping.h	2006-01-30 10:46:24.000000000 +0200
@@ -19,35 +19,35 @@ struct dma_mapping_ops {
 	void            (*free_coherent)(struct device *dev, size_t size,
                                 void *vaddr, dma_addr_t dma_handle);
 	dma_addr_t      (*map_single)(struct device *hwdev, void *ptr,
-                                size_t size, int direction);
+                                size_t size, enum dma_data_direction direction);
 	/* like map_single, but doesn't check the device mask */
 	dma_addr_t      (*map_simple)(struct device *hwdev, char *ptr,
-                                size_t size, int direction);
+                                size_t size, enum dma_data_direction direction);
 	void            (*unmap_single)(struct device *dev, dma_addr_t addr,
-		                size_t size, int direction);
+		                size_t size, enum dma_data_direction direction);
 	void            (*sync_single_for_cpu)(struct device *hwdev,
 		                dma_addr_t dma_handle, size_t size,
-				int direction);
+				enum dma_data_direction direction);
 	void            (*sync_single_for_device)(struct device *hwdev,
                                 dma_addr_t dma_handle, size_t size,
-				int direction);
+				enum dma_data_direction direction);
 	void            (*sync_single_range_for_cpu)(struct device *hwdev,
                                 dma_addr_t dma_handle, unsigned long offset,
-		                size_t size, int direction);
+		                size_t size, enum dma_data_direction direction);
 	void            (*sync_single_range_for_device)(struct device *hwdev,
 				dma_addr_t dma_handle, unsigned long offset,
-		                size_t size, int direction);
+		                size_t size, enum dma_data_direction direction);
 	void            (*sync_sg_for_cpu)(struct device *hwdev,
                                 struct scatterlist *sg, int nelems,
-				int direction);
+				enum dma_data_direction direction);
 	void            (*sync_sg_for_device)(struct device *hwdev,
 				struct scatterlist *sg, int nelems,
-				int direction);
+				enum dma_data_direction direction);
 	int             (*map_sg)(struct device *hwdev, struct scatterlist *sg,
-		                int nents, int direction);
+		                int nents, enum dma_data_direction direction);
 	void            (*unmap_sg)(struct device *hwdev,
 				struct scatterlist *sg, int nents,
-				int direction);
+				enum dma_data_direction direction);
 	int             (*dma_supported)(struct device *hwdev, u64 mask);
 	int		is_phys;
 };
@@ -71,14 +71,14 @@ extern void dma_free_coherent(struct dev
 
 static inline dma_addr_t
 dma_map_single(struct device *hwdev, void *ptr, size_t size,
-	       int direction)
+	       enum dma_data_direction direction)
 {
 	return dma_ops->map_single(hwdev, ptr, size, direction);
 }
 
 static inline void
 dma_unmap_single(struct device *dev, dma_addr_t addr,size_t size,
-		 int direction)
+		 enum dma_data_direction direction)
 {
 	dma_ops->unmap_single(dev, addr, size, direction);
 }
@@ -90,7 +90,7 @@ dma_unmap_single(struct device *dev, dma
 
 static inline void
 dma_sync_single_for_cpu(struct device *hwdev, dma_addr_t dma_handle,
-			size_t size, int direction)
+			size_t size, enum dma_data_direction direction)
 {
 	if (dma_ops->sync_single_for_cpu)
 		dma_ops->sync_single_for_cpu(hwdev, dma_handle, size,
@@ -100,7 +100,7 @@ dma_sync_single_for_cpu(struct device *h
 
 static inline void
 dma_sync_single_for_device(struct device *hwdev, dma_addr_t dma_handle,
-			   size_t size, int direction)
+			   size_t size, enum dma_data_direction direction)
 {
 	if (dma_ops->sync_single_for_device)
 		dma_ops->sync_single_for_device(hwdev, dma_handle, size,
@@ -110,7 +110,8 @@ dma_sync_single_for_device(struct device
 
 static inline void
 dma_sync_single_range_for_cpu(struct device *hwdev, dma_addr_t dma_handle,
-			      unsigned long offset, size_t size, int direction)
+			      unsigned long offset, size_t size,
+			      enum dma_data_direction direction)
 {
 	if (dma_ops->sync_single_range_for_cpu) {
 		dma_ops->sync_single_range_for_cpu(hwdev, dma_handle, offset, size, direction);
@@ -121,7 +122,8 @@ dma_sync_single_range_for_cpu(struct dev
 
 static inline void
 dma_sync_single_range_for_device(struct device *hwdev, dma_addr_t dma_handle,
-				 unsigned long offset, size_t size, int direction)
+				 unsigned long offset, size_t size,
+				 enum dma_data_direction direction)
 {
 	if (dma_ops->sync_single_range_for_device)
 		dma_ops->sync_single_range_for_device(hwdev, dma_handle,
@@ -132,7 +134,7 @@ dma_sync_single_range_for_device(struct 
 
 static inline void
 dma_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
-		    int nelems, int direction)
+		    int nelems, enum dma_data_direction direction)
 {
 	if (dma_ops->sync_sg_for_cpu)
 		dma_ops->sync_sg_for_cpu(hwdev, sg, nelems, direction);
@@ -141,7 +143,7 @@ dma_sync_sg_for_cpu(struct device *hwdev
 
 static inline void
 dma_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
-		       int nelems, int direction)
+		       int nelems, enum dma_data_direction direction)
 {
 	if (dma_ops->sync_sg_for_device) {
 		dma_ops->sync_sg_for_device(hwdev, sg, nelems, direction);
@@ -151,14 +153,15 @@ dma_sync_sg_for_device(struct device *hw
 }
 
 static inline int
-dma_map_sg(struct device *hwdev, struct scatterlist *sg, int nents, int direction)
+dma_map_sg(struct device *hwdev, struct scatterlist *sg, int nents,
+	   enum dma_data_direction direction)
 {
 	return dma_ops->map_sg(hwdev, sg, nents, direction);
 }
 
 static inline void
 dma_unmap_sg(struct device *hwdev, struct scatterlist *sg, int nents,
-	     int direction)
+	     enum dma_data_direction direction)
 {
 	dma_ops->unmap_sg(hwdev, sg, nents, direction);
 }
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/include/asm-x86_64/swiotlb.h mm4.swiotlb/include/asm-x86_64/swiotlb.h
--- mm4.orig/include/asm-x86_64/swiotlb.h	2006-01-30 10:34:11.000000000 +0200
+++ mm4.swiotlb/include/asm-x86_64/swiotlb.h	2006-01-30 10:46:24.000000000 +0200
@@ -3,52 +3,13 @@
 
 #include <linux/config.h>
 
-#include <asm/dma-mapping.h>
-
-/* SWIOTLB interface */
-
-extern dma_addr_t swiotlb_map_single(struct device *hwdev, void *ptr,
-				     size_t size, int dir);
-extern void *swiotlb_alloc_coherent(struct device *hwdev, size_t size,
-                       dma_addr_t *dma_handle, gfp_t flags);
-extern void swiotlb_unmap_single(struct device *hwdev, dma_addr_t dev_addr,
-				  size_t size, int dir);
-extern void swiotlb_sync_single_for_cpu(struct device *hwdev,
-					 dma_addr_t dev_addr,
-					 size_t size, int dir);
-extern void swiotlb_sync_single_for_device(struct device *hwdev,
-					    dma_addr_t dev_addr,
-					    size_t size, int dir);
-extern void swiotlb_sync_single_range_for_cpu(struct device *hwdev,
-					      dma_addr_t dev_addr,
-					      unsigned long offset,
-					      size_t size, int dir);
-extern void swiotlb_sync_single_range_for_device(struct device *hwdev,
-						 dma_addr_t dev_addr,
-						 unsigned long offset,
-						 size_t size, int dir);
-extern void swiotlb_sync_sg_for_cpu(struct device *hwdev,
-				     struct scatterlist *sg, int nelems,
-				     int dir);
-extern void swiotlb_sync_sg_for_device(struct device *hwdev,
-					struct scatterlist *sg, int nelems,
-					int dir);
-extern int swiotlb_map_sg(struct device *hwdev, struct scatterlist *sg,
-		      int nents, int direction);
-extern void swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sg,
-			 int nents, int direction);
-extern int swiotlb_dma_mapping_error(dma_addr_t dma_addr);
-extern void swiotlb_free_coherent (struct device *hwdev, size_t size,
-				   void *vaddr, dma_addr_t dma_handle);
-extern int swiotlb_dma_supported(struct device *hwdev, u64 mask);
-extern void swiotlb_init(void);
+#include <asm-generic/swiotlb.h>
 
 #ifdef CONFIG_SWIOTLB
+extern void pci_swiotlb_init(void);
 extern int swiotlb;
 #else
 #define swiotlb 0
 #endif
 
-extern void pci_swiotlb_init(void);
-
 #endif /* _ASM_SWTIOLB_H */
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/include/linux/dma-data-direction.h mm4.swiotlb/include/linux/dma-data-direction.h
--- mm4.orig/include/linux/dma-data-direction.h	1970-01-01 02:00:00.000000000 +0200
+++ mm4.swiotlb/include/linux/dma-data-direction.h	2006-01-30 10:46:24.000000000 +0200
@@ -0,0 +1,13 @@
+#ifndef _ASM_LINUX_DMA_DATA_DIRECTION_H
+#define _ASM_LINUX_DMA_DATA_DIRECTION_H
+
+/* These definitions mirror those in pci.h, so they can be used
+ * interchangeably with their PCI_ counterparts */
+enum dma_data_direction {
+	DMA_BIDIRECTIONAL = 0,
+	DMA_TO_DEVICE = 1,
+	DMA_FROM_DEVICE = 2,
+	DMA_NONE = 3,
+};
+
+#endif /* _ASM_LINUX_DMA_DATA_DIRECTION_H */
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/include/linux/dma-mapping.h mm4.swiotlb/include/linux/dma-mapping.h
--- mm4.orig/include/linux/dma-mapping.h	2006-01-30 10:34:59.000000000 +0200
+++ mm4.swiotlb/include/linux/dma-mapping.h	2006-01-30 10:46:24.000000000 +0200
@@ -3,15 +3,7 @@
 
 #include <linux/device.h>
 #include <linux/err.h>
-
-/* These definitions mirror those in pci.h, so they can be used
- * interchangeably with their PCI_ counterparts */
-enum dma_data_direction {
-	DMA_BIDIRECTIONAL = 0,
-	DMA_TO_DEVICE = 1,
-	DMA_FROM_DEVICE = 2,
-	DMA_NONE = 3,
-};
+#include <linux/dma-data-direction.h>
 
 #define DMA_64BIT_MASK	0xffffffffffffffffULL
 #define DMA_40BIT_MASK	0x000000ffffffffffULL
diff -Naurp --exclude-from /home/muli/w/dontdiff mm4.orig/lib/swiotlb.c mm4.swiotlb/lib/swiotlb.c
--- mm4.orig/lib/swiotlb.c	2006-01-30 10:34:12.000000000 +0200
+++ mm4.swiotlb/lib/swiotlb.c	2006-01-30 10:46:24.000000000 +0200
@@ -279,7 +279,8 @@ address_needs_mapping(struct device *hwd
  * Allocates bounce buffer and returns its kernel virtual address.
  */
 static void *
-map_single(struct device *hwdev, char *buffer, size_t size, int dir)
+map_single(struct device *hwdev, char *buffer, size_t size,
+	   enum dma_data_direction dir)
 {
 	unsigned long flags;
 	char *dma_addr;
@@ -362,7 +363,8 @@ map_single(struct device *hwdev, char *b
  * dma_addr is the kernel virtual address of the bounce buffer to unmap.
  */
 static void
-unmap_single(struct device *hwdev, char *dma_addr, size_t size, int dir)
+unmap_single(struct device *hwdev, char *dma_addr, size_t size,
+	     enum dma_data_direction dir)
 {
 	unsigned long flags;
 	int i, count, nslots = ALIGN(size, 1 << IO_TLB_SHIFT) >> IO_TLB_SHIFT;
@@ -407,7 +409,7 @@ unmap_single(struct device *hwdev, char 
 
 static void
 sync_single(struct device *hwdev, char *dma_addr, size_t size,
-	    int dir, int target)
+	    enum dma_data_direction dir, int target)
 {
 	int index = (dma_addr - io_tlb_start) >> IO_TLB_SHIFT;
 	char *buffer = io_tlb_orig_addr[index];
@@ -496,7 +498,8 @@ swiotlb_free_coherent(struct device *hwd
 }
 
 static void
-swiotlb_full(struct device *dev, size_t size, int dir, int do_panic)
+swiotlb_full(struct device *dev, size_t size, enum dma_data_direction dir,
+	     int do_panic)
 {
 	/*
 	 * Ran out of IOMMU space for this operation. This is very bad.
@@ -524,7 +527,8 @@ swiotlb_full(struct device *dev, size_t 
  * either swiotlb_unmap_single or swiotlb_dma_sync_single is performed.
  */
 dma_addr_t
-swiotlb_map_single(struct device *hwdev, void *ptr, size_t size, int dir)
+swiotlb_map_single(struct device *hwdev, void *ptr, size_t size,
+		   enum dma_data_direction dir)
 {
 	unsigned long dev_addr = virt_to_phys(ptr);
 	void *map;
@@ -588,7 +592,7 @@ mark_clean(void *addr, size_t size)
  */
 void
 swiotlb_unmap_single(struct device *hwdev, dma_addr_t dev_addr, size_t size,
-		     int dir)
+		     enum dma_data_direction dir)
 {
 	char *dma_addr = phys_to_virt(dev_addr);
 
@@ -612,7 +616,8 @@ swiotlb_unmap_single(struct device *hwde
  */
 static inline void
 swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
-		    size_t size, int dir, int target)
+		    size_t size, enum dma_data_direction dir,
+		    int target)
 {
 	char *dma_addr = phys_to_virt(dev_addr);
 
@@ -626,14 +631,14 @@ swiotlb_sync_single(struct device *hwdev
 
 void
 swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
-			    size_t size, int dir)
+			    size_t size, enum dma_data_direction dir)
 {
 	swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_CPU);
 }
 
 void
 swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
-			       size_t size, int dir)
+			       size_t size, enum dma_data_direction dir)
 {
 	swiotlb_sync_single(hwdev, dev_addr, size, dir, SYNC_FOR_DEVICE);
 }
@@ -644,7 +649,7 @@ swiotlb_sync_single_for_device(struct de
 static inline void
 swiotlb_sync_single_range(struct device *hwdev, dma_addr_t dev_addr,
 			  unsigned long offset, size_t size,
-			  int dir, int target)
+			  enum dma_data_direction dir, int target)
 {
 	char *dma_addr = phys_to_virt(dev_addr) + offset;
 
@@ -658,7 +663,8 @@ swiotlb_sync_single_range(struct device 
 
 void
 swiotlb_sync_single_range_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
-				  unsigned long offset, size_t size, int dir)
+				  unsigned long offset, size_t size,
+				  enum dma_data_direction dir)
 {
 	swiotlb_sync_single_range(hwdev, dev_addr, offset, size, dir,
 				  SYNC_FOR_CPU);
@@ -666,7 +672,8 @@ swiotlb_sync_single_range_for_cpu(struct
 
 void
 swiotlb_sync_single_range_for_device(struct device *hwdev, dma_addr_t dev_addr,
-				     unsigned long offset, size_t size, int dir)
+				     unsigned long offset, size_t size,
+				     enum dma_data_direction dir)
 {
 	swiotlb_sync_single_range(hwdev, dev_addr, offset, size, dir,
 				  SYNC_FOR_DEVICE);
@@ -690,7 +697,7 @@ swiotlb_sync_single_range_for_device(str
  */
 int
 swiotlb_map_sg(struct device *hwdev, struct scatterlist *sg, int nelems,
-	       int dir)
+	       enum dma_data_direction dir)
 {
 	void *addr;
 	unsigned long dev_addr;
@@ -726,7 +733,7 @@ swiotlb_map_sg(struct device *hwdev, str
  */
 void
 swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sg, int nelems,
-		 int dir)
+		 enum dma_data_direction dir)
 {
 	int i;
 
@@ -749,7 +756,7 @@ swiotlb_unmap_sg(struct device *hwdev, s
  */
 static inline void
 swiotlb_sync_sg(struct device *hwdev, struct scatterlist *sg,
-		int nelems, int dir, int target)
+		int nelems, enum dma_data_direction dir, int target)
 {
 	int i;
 
@@ -764,14 +771,14 @@ swiotlb_sync_sg(struct device *hwdev, st
 
 void
 swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
-			int nelems, int dir)
+			int nelems, enum dma_data_direction dir)
 {
 	swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_CPU);
 }
 
 void
 swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
-			   int nelems, int dir)
+			   int nelems, enum dma_data_direction dir)
 {
 	swiotlb_sync_sg(hwdev, sg, nelems, dir, SYNC_FOR_DEVICE);
 }




