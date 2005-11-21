Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbVKUV4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVKUV4u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbVKUV4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:56:50 -0500
Received: from mtaout1.012.net.il ([84.95.2.1]:3571 "EHLO mtaout1.012.net.il")
	by vger.kernel.org with ESMTP id S1751101AbVKUV4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:56:49 -0500
Date: Mon, 21 Nov 2005 23:56:43 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [RFC PATCH 3/3] move swiotlb header file into common code - IA64 bits
In-reply-to: <20051121215542.GG22728@granada.merseine.nu>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Message-id: <20051121215643.GH22728@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20051121215048.GE22728@granada.merseine.nu>
 <20051121215403.GF22728@granada.merseine.nu>
 <20051121215542.GG22728@granada.merseine.nu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 arch/ia64/hp/common/hwsw_iommu.c   |   23 +++++++++++++++--------
 arch/ia64/hp/common/sba_iommu.c    |   12 ++++++++----
 arch/ia64/kernel/machvec.c         |    6 ++++--
 arch/ia64/sn/pci/pci_dma.c         |   16 ++++++++--------
 arch/ia64/sn/pci/pcibr/pcibr_dma.c |    3 ++-
 arch/ia64/sn/pci/tioca_provider.c  |    3 ++-
 arch/ia64/sn/pci/tioce_provider.c  |    3 ++-
 include/asm-ia64/machvec.h         |   22 ++++++++++++----------
 8 files changed, 53 insertions(+), 35 deletions(-)

---

diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/ia64/hp/common/hwsw_iommu.c dma_data_direction.hg/arch/ia64/hp/common/hwsw_iommu.c
--- vanilla/arch/ia64/hp/common/hwsw_iommu.c	2005-10-30 04:52:06.000000000 -0500
+++ dma_data_direction.hg/arch/ia64/hp/common/hwsw_iommu.c	2005-11-18 16:46:51.000000000 -0500
@@ -98,7 +98,7 @@ hwsw_free_coherent (struct device *dev, 
 }
 
 dma_addr_t
-hwsw_map_single (struct device *dev, void *addr, size_t size, int dir)
+hwsw_map_single (struct device *dev, void *addr, size_t size, enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		return swiotlb_map_single(dev, addr, size, dir);
@@ -107,7 +107,8 @@ hwsw_map_single (struct device *dev, voi
 }
 
 void
-hwsw_unmap_single (struct device *dev, dma_addr_t iova, size_t size, int dir)
+hwsw_unmap_single (struct device *dev, dma_addr_t iova, size_t size,
+		   enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		return swiotlb_unmap_single(dev, iova, size, dir);
@@ -117,7 +118,8 @@ hwsw_unmap_single (struct device *dev, d
 
 
 int
-hwsw_map_sg (struct device *dev, struct scatterlist *sglist, int nents, int dir)
+hwsw_map_sg (struct device *dev, struct scatterlist *sglist, int nents,
+	     enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		return swiotlb_map_sg(dev, sglist, nents, dir);
@@ -126,7 +128,8 @@ hwsw_map_sg (struct device *dev, struct 
 }
 
 void
-hwsw_unmap_sg (struct device *dev, struct scatterlist *sglist, int nents, int dir)
+hwsw_unmap_sg (struct device *dev, struct scatterlist *sglist, int nents,
+	       enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		return swiotlb_unmap_sg(dev, sglist, nents, dir);
@@ -135,7 +138,8 @@ hwsw_unmap_sg (struct device *dev, struc
 }
 
 void
-hwsw_sync_single_for_cpu (struct device *dev, dma_addr_t addr, size_t size, int dir)
+hwsw_sync_single_for_cpu (struct device *dev, dma_addr_t addr, size_t size,
+			  enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		swiotlb_sync_single_for_cpu(dev, addr, size, dir);
@@ -144,7 +148,8 @@ hwsw_sync_single_for_cpu (struct device 
 }
 
 void
-hwsw_sync_sg_for_cpu (struct device *dev, struct scatterlist *sg, int nelems, int dir)
+hwsw_sync_sg_for_cpu (struct device *dev, struct scatterlist *sg, int nelems,
+		      enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		swiotlb_sync_sg_for_cpu(dev, sg, nelems, dir);
@@ -153,7 +158,8 @@ hwsw_sync_sg_for_cpu (struct device *dev
 }
 
 void
-hwsw_sync_single_for_device (struct device *dev, dma_addr_t addr, size_t size, int dir)
+hwsw_sync_single_for_device (struct device *dev, dma_addr_t addr, size_t size,
+			     enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		swiotlb_sync_single_for_device(dev, addr, size, dir);
@@ -162,7 +168,8 @@ hwsw_sync_single_for_device (struct devi
 }
 
 void
-hwsw_sync_sg_for_device (struct device *dev, struct scatterlist *sg, int nelems, int dir)
+hwsw_sync_sg_for_device (struct device *dev, struct scatterlist *sg, int nelems,
+			 enum dma_data_direction dir)
 {
 	if (use_swiotlb(dev))
 		swiotlb_sync_sg_for_device(dev, sg, nelems, dir);
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/ia64/hp/common/sba_iommu.c dma_data_direction.hg/arch/ia64/hp/common/sba_iommu.c
--- vanilla/arch/ia64/hp/common/sba_iommu.c	2005-10-30 04:52:06.000000000 -0500
+++ dma_data_direction.hg/arch/ia64/hp/common/sba_iommu.c	2005-11-18 16:48:22.000000000 -0500
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
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/ia64/kernel/machvec.c dma_data_direction.hg/arch/ia64/kernel/machvec.c
--- vanilla/arch/ia64/kernel/machvec.c	2005-09-08 07:06:37.000000000 -0400
+++ dma_data_direction.hg/arch/ia64/kernel/machvec.c	2005-11-18 16:49:39.000000000 -0500
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
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/ia64/sn/pci/pcibr/pcibr_dma.c dma_data_direction.hg/arch/ia64/sn/pci/pcibr/pcibr_dma.c
--- vanilla/arch/ia64/sn/pci/pcibr/pcibr_dma.c	2005-09-26 08:09:53.000000000 -0400
+++ dma_data_direction.hg/arch/ia64/sn/pci/pcibr/pcibr_dma.c	2005-11-18 16:52:01.000000000 -0500
@@ -179,7 +179,8 @@ pcibr_dmatrans_direct32(struct pcidev_in
  * DMA mappings for Direct 64 and 32 do not have any DMA maps.
  */
 void
-pcibr_dma_unmap(struct pci_dev *hwdev, dma_addr_t dma_handle, int direction)
+pcibr_dma_unmap(struct pci_dev *hwdev, dma_addr_t dma_handle,
+		enum dma_data_direction direction)
 {
 	struct pcidev_info *pcidev_info = SN_PCIDEV_INFO(hwdev);
 	struct pcibus_info *pcibus_info =
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/ia64/sn/pci/pci_dma.c dma_data_direction.hg/arch/ia64/sn/pci/pci_dma.c
--- vanilla/arch/ia64/sn/pci/pci_dma.c	2005-10-30 04:52:06.000000000 -0500
+++ dma_data_direction.hg/arch/ia64/sn/pci/pci_dma.c	2005-11-18 16:50:15.000000000 -0500
@@ -166,7 +166,7 @@ EXPORT_SYMBOL(sn_dma_free_coherent);
  *       figure out how to save dmamap handle so can use two step.
  */
 dma_addr_t sn_dma_map_single(struct device *dev, void *cpu_addr, size_t size,
-			     int direction)
+			     enum dma_data_direction direction)
 {
 	dma_addr_t dma_addr;
 	unsigned long phys_addr;
@@ -197,7 +197,7 @@ EXPORT_SYMBOL(sn_dma_map_single);
  * coherent, so we just need to free any ATEs associated with this mapping.
  */
 void sn_dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
-			 int direction)
+			 enum dma_data_direction direction)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct sn_pcibus_provider *provider = SN_PCIDEV_BUSPROVIDER(pdev);
@@ -218,7 +218,7 @@ EXPORT_SYMBOL(sn_dma_unmap_single);
  * Unmap a set of streaming mode DMA translations.
  */
 void sn_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
-		     int nhwentries, int direction)
+		     int nhwentries, enum dma_data_direction direction)
 {
 	int i;
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -244,7 +244,7 @@ EXPORT_SYMBOL(sn_dma_unmap_sg);
  * Maps each entry of @sg for DMA.
  */
 int sn_dma_map_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
-		  int direction)
+		  enum dma_data_direction direction)
 {
 	unsigned long phys_addr;
 	struct scatterlist *saved_sg = sg;
@@ -281,28 +281,28 @@ int sn_dma_map_sg(struct device *dev, st
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
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/ia64/sn/pci/tioca_provider.c dma_data_direction.hg/arch/ia64/sn/pci/tioca_provider.c
--- vanilla/arch/ia64/sn/pci/tioca_provider.c	2005-10-30 04:52:06.000000000 -0500
+++ dma_data_direction.hg/arch/ia64/sn/pci/tioca_provider.c	2005-11-18 16:52:25.000000000 -0500
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
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/arch/ia64/sn/pci/tioce_provider.c dma_data_direction.hg/arch/ia64/sn/pci/tioce_provider.c
--- vanilla/arch/ia64/sn/pci/tioce_provider.c	2005-11-12 15:51:54.000000000 -0500
+++ dma_data_direction.hg/arch/ia64/sn/pci/tioce_provider.c	2005-11-18 16:52:37.000000000 -0500
@@ -323,7 +323,8 @@ tioce_dma_barrier(uint64_t bus_addr, int
  * to release.
  */
 void
-tioce_dma_unmap(struct pci_dev *pdev, dma_addr_t bus_addr, int dir)
+tioce_dma_unmap(struct pci_dev *pdev, dma_addr_t bus_addr,
+		enum dma_data_direction dir)
 {
 	int i;
 	int port;
diff -Naurp --exclude-from /home/muli/w/dontdiff vanilla/include/asm-ia64/machvec.h dma_data_direction.hg/include/asm-ia64/machvec.h
--- vanilla/include/asm-ia64/machvec.h	2005-10-30 04:52:23.000000000 -0500
+++ dma_data_direction.hg/include/asm-ia64/machvec.h	2005-11-21 13:46:44.000000000 -0500
@@ -13,6 +13,8 @@
 #include <linux/config.h>
 #include <linux/types.h>
 
+#include <asm-generic/swiotlb.h>
+
 /* forward declarations: */
 struct device;
 struct pt_regs;
@@ -39,14 +41,14 @@ typedef int ia64_mv_pci_legacy_write_t (
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
 
@@ -87,8 +89,8 @@ machvec_noop_mm (struct mm_struct *mm)
 
 extern void machvec_setup (char **);
 extern void machvec_timer_interrupt (int, void *, struct pt_regs *);
-extern void machvec_dma_sync_single (struct device *, dma_addr_t, size_t, int);
-extern void machvec_dma_sync_sg (struct device *, struct scatterlist *, int, int);
+extern void machvec_dma_sync_single (struct device *, dma_addr_t, size_t, enum dma_data_direction);
+extern void machvec_dma_sync_sg (struct device *, struct scatterlist *, int, enum dma_data_direction);
 extern void machvec_tlb_migrate_finish (struct mm_struct *);
 
 # if defined (CONFIG_IA64_HP_SIM)


-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

