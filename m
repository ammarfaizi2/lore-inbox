Return-Path: <linux-kernel-owner+w=401wt.eu-S1751951AbWLNGoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751951AbWLNGoc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 01:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbWLNGoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 01:44:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:44056 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbWLNGob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 01:44:31 -0500
Date: Thu, 14 Dec 2006 06:44:30 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1] ib_verbs: Use explicit if-else statements to avoid errors with do-while macros
Message-ID: <20061214064430.GM4587@ftp.linux.org.uk>
References: <1166065805.6748.135.camel@gullible>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166065805.6748.135.camel@gullible>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 10:10:05PM -0500, Ben Collins wrote:
> At least on PPC, the "op ? op : dma" construct causes a compile failure
> because the dma_* is a do{}while(0) macro.
> 
> This turns all of them into proper if/else to avoid this problem.

NAK.

Proper fix is to kill stupid do { } while (0) mess.  It's supposed
to behave like a function returning void, so it should be ((void)0).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

diff --git a/include/asm-alpha/dma-mapping.h b/include/asm-alpha/dma-mapping.h
index 57e09f5..ce759ea 100644
--- a/include/asm-alpha/dma-mapping.h
+++ b/include/asm-alpha/dma-mapping.h
@@ -41,9 +41,9 @@ #define dma_supported(dev, mask)		(mask 
 #define dma_map_single(dev, va, size, dir)	virt_to_phys(va)
 #define dma_map_page(dev, page, off, size, dir)	(page_to_pa(page) + off)
 
-#define dma_unmap_single(dev, addr, size, dir)	do { } while (0)
-#define dma_unmap_page(dev, addr, size, dir)	do { } while (0)
-#define dma_unmap_sg(dev, sg, nents, dir)	do { } while (0)
+#define dma_unmap_single(dev, addr, size, dir)	((void)0)
+#define dma_unmap_page(dev, addr, size, dir)	((void)0)
+#define dma_unmap_sg(dev, sg, nents, dir)	((void)0)
 
 #define dma_mapping_error(addr)  (0)
 
@@ -55,12 +55,12 @@ #define dma_is_consistent(d, h)			(1)
 
 int dma_set_mask(struct device *dev, u64 mask);
 
-#define dma_sync_single_for_cpu(dev, addr, size, dir)	  do { } while (0)
-#define dma_sync_single_for_device(dev, addr, size, dir)  do { } while (0)
-#define dma_sync_single_range(dev, addr, off, size, dir)  do { } while (0)
-#define dma_sync_sg_for_cpu(dev, sg, nents, dir)	  do { } while (0)
-#define dma_sync_sg_for_device(dev, sg, nents, dir)	  do { } while (0)
-#define dma_cache_sync(dev, va, size, dir)		  do { } while (0)
+#define dma_sync_single_for_cpu(dev, addr, size, dir)	  ((void)0)
+#define dma_sync_single_for_device(dev, addr, size, dir)  ((void)0)
+#define dma_sync_single_range(dev, addr, off, size, dir)  ((void)0)
+#define dma_sync_sg_for_cpu(dev, sg, nents, dir)	  ((void)0)
+#define dma_sync_sg_for_device(dev, sg, nents, dir)	  ((void)0)
+#define dma_cache_sync(dev, va, size, dir)		  ((void)0)
 
 #define dma_get_cache_alignment()			  L1_CACHE_BYTES
 
diff --git a/include/asm-powerpc/dma-mapping.h b/include/asm-powerpc/dma-mapping.h
index 7c7de87..a19a6f1 100644
--- a/include/asm-powerpc/dma-mapping.h
+++ b/include/asm-powerpc/dma-mapping.h
@@ -37,9 +37,9 @@ #else /* ! CONFIG_NOT_COHERENT_CACHE */
  */
 
 #define __dma_alloc_coherent(gfp, size, handle)	NULL
-#define __dma_free_coherent(size, addr)		do { } while (0)
-#define __dma_sync(addr, size, rw)		do { } while (0)
-#define __dma_sync_page(pg, off, sz, rw)	do { } while (0)
+#define __dma_free_coherent(size, addr)		((void)0)
+#define __dma_sync(addr, size, rw)		((void)0)
+#define __dma_sync_page(pg, off, sz, rw)	((void)0)
 
 #endif /* ! CONFIG_NOT_COHERENT_CACHE */
 
@@ -251,7 +251,7 @@ dma_map_single(struct device *dev, void 
 }
 
 /* We do nothing. */
-#define dma_unmap_single(dev, addr, size, dir)	do { } while (0)
+#define dma_unmap_single(dev, addr, size, dir)	((void)0)
 
 static inline dma_addr_t
 dma_map_page(struct device *dev, struct page *page,
@@ -266,7 +266,7 @@ dma_map_page(struct device *dev, struct 
 }
 
 /* We do nothing. */
-#define dma_unmap_page(dev, handle, size, dir)	do { } while (0)
+#define dma_unmap_page(dev, handle, size, dir)	((void)0)
 
 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
@@ -286,7 +286,7 @@ dma_map_sg(struct device *dev, struct sc
 }
 
 /* We don't do anything here. */
-#define dma_unmap_sg(dev, sg, nents, dir)	do { } while (0)
+#define dma_unmap_sg(dev, sg, nents, dir)	((void)0)
 
 #endif /* CONFIG_PPC64 */
 
