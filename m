Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261808AbULGNUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbULGNUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 08:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbULGNUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 08:20:42 -0500
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:26331 "EHLO
	timesys.com") by vger.kernel.org with ESMTP id S261808AbULGNUc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 08:20:32 -0500
Date: Tue, 7 Dec 2004 08:20:31 -0500
From: Jason McMullan <jason.mcmullan@timesys.com>
To: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] include/asm-ppc/dma-mapping.h macro patch
Message-ID: <20041207132031.GA23542@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>
Summary: [ppc] dma-mapping.h - Fix macro semantics
Description:
	This patch makes the macros for dma_* semantically
	equivalent to the functions they mask. For example,
	dma_cache_inv(func_with_side_effects(), sizeof(foo))
	will execure 'func_with_side_effects()' in the function
	case, but would not execute it in the macro case.
	This patch fixes this discrepancy.
Comment: More landmines like this may be all over the kernel.
	 Janitor project, anyone?


--- linux-2.6.9.old/include/asm-ppc/dma-mapping.h	2004-12-07 08:14:32.769502853 -0500
+++ linux-2.6.9/include/asm-ppc/dma-mapping.h	2004-12-07 08:14:02.777362775 -0500
@@ -36,22 +36,22 @@
  * Cache coherent cores.
  */
 
-#define dma_cache_inv(_start,_size)		do { } while (0)
-#define dma_cache_wback(_start,_size)		do { } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { } while (0)
-
-#define __dma_alloc_coherent(gfp, size, handle)	NULL
-#define __dma_free_coherent(size, addr)		do { } while (0)
-#define __dma_sync(addr, size, rw)		do { } while (0)
-#define __dma_sync_page(pg, off, sz, rw)	do { } while (0)
+#define dma_cache_inv(_start,_size)		do { (void)(_start); (void)(_size); } while (0)
+#define dma_cache_wback(_start,_size)		do { (void)(_start); (void)(_size); } while (0)
+#define dma_cache_wback_inv(_start,_size)	do { (void)(_start); (void)(_size); } while (0)
+
+#define __dma_alloc_coherent(gfp, size, handle)	((void)(gfp),(void)(size),(void)(handle),NULL)
+#define __dma_free_coherent(size, addr)		do { (void)(size); (void)(addr); } while (0)
+#define __dma_sync(addr, size, rw)		do { (void)(addr); (void)(size); (void)(rw); } while (0)
+#define __dma_sync_page(pg, off, sz, rw)	do { (void)(pg); (void)(off); (void)(sz); (void)(rw); } while (0)
 
 #endif /* ! CONFIG_NOT_COHERENT_CACHE */
 
-#define dma_supported(dev, mask)	(1)
+#define dma_supported(dev, mask)	((void)(dev), (void)(mask), 1)
 
 static inline int dma_set_mask(struct device *dev, u64 dma_mask)
 {
-	if (!dev->dma_mask || !dma_supported(dev, mask))
+	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
 		return -EIO;
 
 	*dev->dma_mask = dma_mask;
@@ -121,7 +121,7 @@
 }
 
 /* We do nothing. */
-#define dma_unmap_page(dev, handle, size, dir)	do { } while (0)
+#define dma_unmap_page(dev, handle, size, dir)	do { (void)(dev); (void)(handle); (void)(size); (void)(dir); } while (0)
 
 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
@@ -141,7 +141,7 @@
 }
 
 /* We don't do anything here. */
-#define dma_unmap_sg(dev, sg, nents, dir)	do { } while (0)
+#define dma_unmap_sg(dev, sg, nents, dir)	do { (void)(dev); (void)(sg); (void)(nents); (void)(dir); } while (0)
 
 static inline void
 dma_sync_single_for_cpu(struct device *dev, dma_addr_t dma_handle,
@@ -190,9 +190,9 @@
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
 #ifdef CONFIG_NOT_COHERENT_CACHE
-#define dma_is_consistent(d)	(0)
+#define dma_is_consistent(d)	((void)(d), 0)
 #else
-#define dma_is_consistent(d)	(1)
+#define dma_is_consistent(d)	((void)(d), 1)
 #endif
 
 static inline int dma_get_cache_alignment(void)
-- 
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation
