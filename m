Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbULHQl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbULHQl2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 11:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbULHQl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 11:41:28 -0500
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:49805 "EHLO
	timesys.com") by vger.kernel.org with ESMTP id S261258AbULHQlL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 11:41:11 -0500
Date: Wed, 8 Dec 2004 11:41:09 -0500
From: Jason McMullan <jason.mcmullan@timesys.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/asm-ppc/dma-mapping.h macro patch
Message-ID: <20041208164109.GA22881@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-07 at 15:03 +0000, Christoph Hellwig wrote:
> +#define dma_cache_inv(_start,_size)		do { (void)(_start);
> (void)(_size); } while (0)
> 
> this looks really horrible.  What about turning these into inlines?
> 

Sure thing:

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
Summary: [ppc] dma-mapping.h - Fix macro semantics
Release: Dec 8, 2004
Description:
        This patch makes the macros for dma_* semantically
        equivalent to the functions they mask. For example,
        dma_cache_inv(func_with_side_effects(), sizeof(foo))
        will execure 'func_with_side_effects()' in the function
        case, but would not execute it in the macro case.
        This patch fixes this discrepancy using 'static inline'
	functions.

--- linux-orig/include/asm-ppc/dma-mapping.h
+++ linux/include/asm-ppc/dma-mapping.h
@@ -24,34 +24,43 @@
 extern void __dma_sync(void *vaddr, size_t size, int direction);
 extern void __dma_sync_page(struct page *page, unsigned long offset,
 				 size_t size, int direction);
-#define dma_cache_inv(_start,_size) \
-	invalidate_dcache_range(_start, (_start + _size))
-#define dma_cache_wback(_start,_size) \
-	clean_dcache_range(_start, (_start + _size))
-#define dma_cache_wback_inv(_start,_size) \
-	flush_dcache_range(_start, (_start + _size))
+
+static inline void dma_cache_inv(unsigned long _start,size_t _size)
+{
+	invalidate_dcache_range(_start, (_start + _size));
+}
+
+static inline void dma_cache_wback(unsigned long _start,size_t _size)
+{
+	clean_dcache_range(_start, (_start + _size));
+}
+
+static inline void dma_cache_wback_inv(unsigned long _start,size_t _size)
+{
+	flush_dcache_range(_start, (_start + _size));
+}
 
 #else /* ! CONFIG_NOT_COHERENT_CACHE */
 /*
  * Cache coherent cores.
  */
 
-#define dma_cache_inv(_start,_size)		do { } while (0)
-#define dma_cache_wback(_start,_size)		do { } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { } while (0)
+static inline void dma_cache_inv(unsigned long _start,size_t _size) {}
+static inline void dma_cache_wback(unsigned long _start,size_t _size) {}
+static inline void dma_cache_wback_inv(unsigned long _start,size_t _size) {}
 
-#define __dma_alloc_coherent(gfp, size, handle)	NULL
-#define __dma_free_coherent(size, addr)		do { } while (0)
-#define __dma_sync(addr, size, rw)		do { } while (0)
-#define __dma_sync_page(pg, off, sz, rw)	do { } while (0)
+static inline void *__dma_alloc_coherent(size_t size, dma_addr_t handle, int gfp) { return NULL; }
+static inline void __dma_free_coherent(size_t size, void *vaddr) {}
+static inline void __dma_sync(void *vaddr, size_t size, int rw) {}
+static inline void __dma_sync_page(struct page *pg, unsigned long off, size_t sz, int rw) {}
 
 #endif /* ! CONFIG_NOT_COHERENT_CACHE */
 
-#define dma_supported(dev, mask)	(1)
+static inline int dma_supported(struct device *dev, u64 dma_mask) { return 1; }
 
 static inline int dma_set_mask(struct device *dev, u64 dma_mask)
 {
-	if (!dev->dma_mask || !dma_supported(dev, mask))
+	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
 		return -EIO;
 
 	*dev->dma_mask = dma_mask;
@@ -106,7 +115,11 @@
 }
 
 /* We do nothing. */
-#define dma_unmap_single(dev, addr, size, dir)	do { } while (0)
+static inline void
+dma_unmap_single(struct device *dev, unsigned long addr, size_t size,
+	         enum dma_data_direction direction)
+{
+}
 
 static inline dma_addr_t
 dma_map_page(struct device *dev, struct page *page,
@@ -121,7 +134,9 @@
 }
 
 /* We do nothing. */
-#define dma_unmap_page(dev, handle, size, dir)	do { } while (0)
+static inline void
+dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
+		size_t size, enum dma_data_direction direction) {}
 
 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
@@ -141,7 +156,9 @@
 }
 
 /* We don't do anything here. */
-#define dma_unmap_sg(dev, sg, nents, dir)	do { } while (0)
+static inline void
+dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
+	     enum dma_data_direction dir) {}
 
 static inline void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
@@ -190,9 +207,9 @@
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 #ifdef CONFIG_NOT_COHERENT_CACHE
-#define dma_is_consistent(d)	(0)
+static inline int dma_is_consistent(dma_addr_t dma_handle) { return 0; }
 #else
-#define dma_is_consistent(d)	(1)
+static inline int dma_is_consistent(dma_addr_t dma_handle) { return 1; }
 #endif
 
 static inline int dma_get_cache_alignment(void)

-- 
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation
