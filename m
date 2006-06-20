Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965116AbWFTLtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbWFTLtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 07:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965044AbWFTLtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 07:49:08 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:21377 "EHLO
	sequoia.sous-sol.org") by vger.kernel.org with ESMTP
	id S1030224AbWFTLtG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 07:49:06 -0400
Message-Id: <20060620114647.556424000@sous-sol.org>
References: <20060620114527.934114000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 20 Jun 2006 00:00:03 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 03/13] SPARC64: Respect gfp_t argument to dma_alloc_coherent().
Content-Disposition: inline; filename=sparc64-respect-gfp_t-argument-to-dma_alloc_coherent.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

Using asm-generic/dma-mapping.h does not work because pushing
the call down to pci_alloc_coherent() causes the gfp_t argument
of dma_alloc_coherent() to be ignored.

Fix this by implementing things directly, and adding a gfp_t
argument we can use in the internal call down to the PCI DMA
implementation of pci_alloc_coherent().

This fixes massive memory corruption when using the sound driver
layer, which passes things like __GFP_COMP down into these
routines and (correctly) expects that to work.

This is a disk eater when sound is used, so it's pretty critical.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 arch/sparc64/kernel/pci_iommu.c     |    4 -
 arch/sparc64/kernel/sparc64_ksyms.c |    2 
 include/asm-sparc64/dma-mapping.h   |  141 +++++++++++++++++++++++++++++++++++-
 include/asm-sparc64/pci.h           |    4 -
 4 files changed, 146 insertions(+), 5 deletions(-)

--- linux-2.6.16.21.orig/arch/sparc64/kernel/pci_iommu.c
+++ linux-2.6.16.21/arch/sparc64/kernel/pci_iommu.c
@@ -219,7 +219,7 @@ static inline void iommu_free_ctx(struct
  * DMA for PCI device PDEV.  Return non-NULL cpu-side address if
  * successful and set *DMA_ADDRP to the PCI side dma address.
  */
-void *pci_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr_t *dma_addrp)
+void *__pci_alloc_consistent(struct pci_dev *pdev, size_t size, dma_addr_t *dma_addrp, gfp_t gfp)
 {
 	struct pcidev_cookie *pcp;
 	struct pci_iommu *iommu;
@@ -233,7 +233,7 @@ void *pci_alloc_consistent(struct pci_de
 	if (order >= 10)
 		return NULL;
 
-	first_page = __get_free_pages(GFP_ATOMIC, order);
+	first_page = __get_free_pages(gfp, order);
 	if (first_page == 0UL)
 		return NULL;
 	memset((char *)first_page, 0, PAGE_SIZE << order);
--- linux-2.6.16.21.orig/arch/sparc64/kernel/sparc64_ksyms.c
+++ linux-2.6.16.21/arch/sparc64/kernel/sparc64_ksyms.c
@@ -221,7 +221,7 @@ EXPORT_SYMBOL(insl);
 EXPORT_SYMBOL(ebus_chain);
 EXPORT_SYMBOL(isa_chain);
 EXPORT_SYMBOL(pci_memspace_mask);
-EXPORT_SYMBOL(pci_alloc_consistent);
+EXPORT_SYMBOL(__pci_alloc_consistent);
 EXPORT_SYMBOL(pci_free_consistent);
 EXPORT_SYMBOL(pci_map_single);
 EXPORT_SYMBOL(pci_unmap_single);
--- linux-2.6.16.21.orig/include/asm-sparc64/dma-mapping.h
+++ linux-2.6.16.21/include/asm-sparc64/dma-mapping.h
@@ -4,7 +4,146 @@
 #include <linux/config.h>
 
 #ifdef CONFIG_PCI
-#include <asm-generic/dma-mapping.h>
+
+/* we implement the API below in terms of the existing PCI one,
+ * so include it */
+#include <linux/pci.h>
+/* need struct page definitions */
+#include <linux/mm.h>
+
+static inline int
+dma_supported(struct device *dev, u64 mask)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_dma_supported(to_pci_dev(dev), mask);
+}
+
+static inline int
+dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
+}
+
+static inline void *
+dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *dma_handle,
+		   gfp_t flag)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return __pci_alloc_consistent(to_pci_dev(dev), size, dma_handle, flag);
+}
+
+static inline void
+dma_free_coherent(struct device *dev, size_t size, void *cpu_addr,
+		    dma_addr_t dma_handle)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_free_consistent(to_pci_dev(dev), size, cpu_addr, dma_handle);
+}
+
+static inline dma_addr_t
+dma_map_single(struct device *dev, void *cpu_addr, size_t size,
+	       enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_map_single(to_pci_dev(dev), cpu_addr, size, (int)direction);
+}
+
+static inline void
+dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
+		 enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_unmap_single(to_pci_dev(dev), dma_addr, size, (int)direction);
+}
+
+static inline dma_addr_t
+dma_map_page(struct device *dev, struct page *page,
+	     unsigned long offset, size_t size,
+	     enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_map_page(to_pci_dev(dev), page, offset, size, (int)direction);
+}
+
+static inline void
+dma_unmap_page(struct device *dev, dma_addr_t dma_address, size_t size,
+	       enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_unmap_page(to_pci_dev(dev), dma_address, size, (int)direction);
+}
+
+static inline int
+dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
+	   enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	return pci_map_sg(to_pci_dev(dev), sg, nents, (int)direction);
+}
+
+static inline void
+dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nhwentries,
+	     enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_unmap_sg(to_pci_dev(dev), sg, nhwentries, (int)direction);
+}
+
+static inline void
+dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle, size_t size,
+			enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_dma_sync_single_for_cpu(to_pci_dev(dev), dma_handle,
+				    size, (int)direction);
+}
+
+static inline void
+dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle, size_t size,
+			   enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_dma_sync_single_for_device(to_pci_dev(dev), dma_handle,
+				       size, (int)direction);
+}
+
+static inline void
+dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nelems,
+		    enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_dma_sync_sg_for_cpu(to_pci_dev(dev), sg, nelems, (int)direction);
+}
+
+static inline void
+dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nelems,
+		       enum dma_data_direction direction)
+{
+	BUG_ON(dev->bus != &pci_bus_type);
+
+	pci_dma_sync_sg_for_device(to_pci_dev(dev), sg, nelems, (int)direction);
+}
+
+static inline int
+dma_mapping_error(dma_addr_t dma_addr)
+{
+	return pci_dma_mapping_error(dma_addr);
+}
+
 #else
 
 struct device;
--- linux-2.6.16.21.orig/include/asm-sparc64/pci.h
+++ linux-2.6.16.21/include/asm-sparc64/pci.h
@@ -44,7 +44,9 @@ struct pci_dev;
 /* Allocate and map kernel buffer using consistent mode DMA for a device.
  * hwdev should be valid struct pci_dev pointer for PCI devices.
  */
-extern void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size, dma_addr_t *dma_handle);
+extern void *__pci_alloc_consistent(struct pci_dev *hwdev, size_t size, dma_addr_t *dma_handle, gfp_t gfp);
+#define pci_alloc_consistent(DEV,SZ,HANDLE) \
+	__pci_alloc_consistent(DEV,SZ,HANDLE,GFP_ATOMIC)
 
 /* Free and unmap a consistent DMA buffer.
  * cpu_addr is what was returned from pci_alloc_consistent,

--
