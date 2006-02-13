Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbWBMBhr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWBMBhr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 20:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWBMBhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 20:37:47 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:19906 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751125AbWBMBhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 20:37:46 -0500
Date: Sun, 12 Feb 2006 19:40:52 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Muli Ben-Yehuda <mulix@mulix.org>
Subject: [PATCH 1/2] move swiotlb.h header file to asm-generic (revised)
Message-ID: <20060213014051.GA7798@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a cut down version of the one Muli submitted on January
24th (http://lkml.org/lkml/2006/1/24/262).  It removes the miscellaneous
changes from "int" to "enum dma_data_direction", and only contains the
move to asm-generic.

Thanks,
Jon

Signed-Off-By: Muli Ben-Yehuda <mulix@mulix.org>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 2fa13972604f include/asm-x86_64/swiotlb.h
--- a/include/asm-x86_64/swiotlb.h	Wed Feb  8 17:58:27 2006
+++ b/include/asm-x86_64/swiotlb.h	Sun Feb 12 15:29:57 2006
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
diff -r 2fa13972604f include/asm-generic/swiotlb.h
--- /dev/null	Wed Feb  8 17:58:27 2006
+++ b/include/asm-generic/swiotlb.h	Sun Feb 12 15:29:57 2006
@@ -0,0 +1,62 @@
+#ifndef _ASM_GENERIC_SWIOTLB_H
+#define _ASM_GENERIC_SWTIOLB_H 1
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
+        int dir);
+
+extern void
+swiotlb_unmap_single(struct device *hwdev, dma_addr_t dev_addr, size_t size,
+        int dir);
+
+extern void
+swiotlb_sync_single_for_cpu(struct device *hwdev, dma_addr_t dev_addr, size_t size,
+       int dir);
+
+extern void
+swiotlb_sync_single_for_device(struct device *hwdev, dma_addr_t dev_addr,
+       size_t size, int dir);
+
+extern void
+swiotlb_sync_single_range_for_cpu(struct device *hwdev, dma_addr_t dev_addr,
+       unsigned long offset, size_t size, int dir);
+
+extern void
+swiotlb_sync_single_range_for_device(struct device *hwdev, dma_addr_t dev_addr,
+       unsigned long offset, size_t size, int dir);
+
+extern void
+swiotlb_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg, int nelems,
+       int dir);
+
+extern void
+swiotlb_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
+       int nelems, int dir);
+
+extern int
+swiotlb_map_sg(struct device *hwdev, struct scatterlist *sg, int nents,
+       int direction);
+
+extern void
+swiotlb_unmap_sg(struct device *hwdev, struct scatterlist *sg, int nents,
+       int direction);
+
+extern int
+swiotlb_dma_mapping_error(dma_addr_t dma_addr);
+
+#endif /* _ASM_GENERIC_SWTIOLB_H */
