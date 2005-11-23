Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVKWTBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVKWTBo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVKWTBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:01:44 -0500
Received: from serv01.siteground.net ([70.85.91.68]:59076 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S932197AbVKWTBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:01:42 -0500
Date: Wed, 23 Nov 2005 11:01:38 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, y-goto@jp.fujitsu.com
Subject: Re: [patch] Cleanup bootmem allocator and fix alloc_bootmem_low
Message-ID: <20051123190138.GA3613@localhost.localdomain>
References: <20051108073224.GA3753@localhost.localdomain> <20051110013654.75e55a61.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051110013654.75e55a61.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 01:36:54AM -0800, Andrew Morton wrote:
> 
> mm/bootmem.c: In function `__alloc_bootmem_low':
> mm/bootmem.c:432: warning: integer constant is too large for "long" type
> mm/bootmem.c:432: warning: large integer implicitly truncated to unsigned type
> mm/bootmem.c: In function `__alloc_bootmem_low_node':
> mm/bootmem.c:446: warning: integer constant is too large for "long" type
> mm/bootmem.c:446: warning: large integer implicitly truncated to unsigned type
> 
>

I had compiled and tested this on 64bit, and unsigned long was big enough for
0x100000000.  Obviously, it is too big for 32 bit platforms.  This patch
fixes that by changing the LOW32LIMIT constant to 0xffffffff.

Please apply

Thanks,
Kiran

---

Patch cleans up the alloc_bootmem fix for swiotlb.  Patch removes
alloc_bootmem_*_limit api and fixes alloc_boot_*low api to do the right
thing -- allocate from low32 memory.

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.15-rc1/include/linux/bootmem.h
===================================================================
--- linux-2.6.15-rc1.orig/include/linux/bootmem.h	2005-10-27 17:02:08.000000000 -0700
+++ linux-2.6.15-rc1/include/linux/bootmem.h	2005-11-22 22:12:32.000000000 -0800
@@ -43,50 +43,38 @@
 extern unsigned long __init bootmem_bootmap_pages (unsigned long);
 extern unsigned long __init init_bootmem (unsigned long addr, unsigned long memend);
 extern void __init free_bootmem (unsigned long addr, unsigned long size);
-extern void * __init __alloc_bootmem_limit (unsigned long size, unsigned long align, unsigned long goal, unsigned long limit);
+extern void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
+extern void * __init __alloc_bootmem_low(unsigned long size,
+					 unsigned long align,
+					 unsigned long goal);
+extern void * __init __alloc_bootmem_low_node(pg_data_t *pgdat,
+					      unsigned long size,
+					      unsigned long align,
+					      unsigned long goal);
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 extern void __init reserve_bootmem (unsigned long addr, unsigned long size);
 #define alloc_bootmem(x) \
 	__alloc_bootmem((x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low(x) \
-	__alloc_bootmem((x), SMP_CACHE_BYTES, 0)
+	__alloc_bootmem_low((x), SMP_CACHE_BYTES, 0)
 #define alloc_bootmem_pages(x) \
 	__alloc_bootmem((x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low_pages(x) \
-	__alloc_bootmem((x), PAGE_SIZE, 0)
-
-#define alloc_bootmem_limit(x, limit)						\
-	__alloc_bootmem_limit((x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS), (limit))
-#define alloc_bootmem_low_limit(x, limit)			\
-	__alloc_bootmem_limit((x), SMP_CACHE_BYTES, 0, (limit))
-#define alloc_bootmem_pages_limit(x, limit)					\
-	__alloc_bootmem_limit((x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS), (limit))
-#define alloc_bootmem_low_pages_limit(x, limit)		\
-	__alloc_bootmem_limit((x), PAGE_SIZE, 0, (limit))
-
+	__alloc_bootmem_low((x), PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
 extern unsigned long __init free_all_bootmem (void);
-
+extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
 extern unsigned long __init init_bootmem_node (pg_data_t *pgdat, unsigned long freepfn, unsigned long startpfn, unsigned long endpfn);
 extern void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size);
 extern void __init free_bootmem_node (pg_data_t *pgdat, unsigned long addr, unsigned long size);
 extern unsigned long __init free_all_bootmem_node (pg_data_t *pgdat);
-extern void * __init __alloc_bootmem_node_limit (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal, unsigned long limit);
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 #define alloc_bootmem_node(pgdat, x) \
 	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_pages_node(pgdat, x) \
 	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low_pages_node(pgdat, x) \
-	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, 0)
-
-#define alloc_bootmem_node_limit(pgdat, x, limit)				\
-	__alloc_bootmem_node_limit((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS), (limit))
-#define alloc_bootmem_pages_node_limit(pgdat, x, limit)				\
-	__alloc_bootmem_node_limit((pgdat), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS), (limit))
-#define alloc_bootmem_low_pages_node_limit(pgdat, x, limit)		\
-	__alloc_bootmem_node_limit((pgdat), (x), PAGE_SIZE, 0, (limit))
-
+	__alloc_bootmem_low_node((pgdat), (x), PAGE_SIZE, 0)
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
 
 #ifdef CONFIG_HAVE_ARCH_ALLOC_REMAP
@@ -123,15 +111,5 @@
 #endif
 extern int __initdata hashdist;		/* Distribute hashes across NUMA nodes? */
 
-static inline void *__alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal)
-{
-	return __alloc_bootmem_limit(size, align, goal, 0);
-}
-
-static inline void *__alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align,
-				     unsigned long goal)
-{
-	return __alloc_bootmem_node_limit(pgdat, size, align, goal, 0);
-}
 
 #endif /* _LINUX_BOOTMEM_H */
Index: linux-2.6.15-rc1/lib/swiotlb.c
===================================================================
--- linux-2.6.15-rc1.orig/lib/swiotlb.c	2005-11-17 15:35:41.000000000 -0800
+++ linux-2.6.15-rc1/lib/swiotlb.c	2005-11-22 22:12:32.000000000 -0800
@@ -142,8 +142,7 @@
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
-	io_tlb_start = alloc_bootmem_low_pages_limit(io_tlb_nslabs *
-					     (1 << IO_TLB_SHIFT), 0x100000000);
+	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs * (1 << IO_TLB_SHIFT));
 	if (!io_tlb_start)
 		panic("Cannot allocate SWIOTLB buffer");
 	io_tlb_end = io_tlb_start + io_tlb_nslabs * (1 << IO_TLB_SHIFT);
Index: linux-2.6.15-rc1/mm/bootmem.c
===================================================================
--- linux-2.6.15-rc1.orig/mm/bootmem.c	2005-11-17 15:35:41.000000000 -0800
+++ linux-2.6.15-rc1/mm/bootmem.c	2005-11-22 22:51:32.000000000 -0800
@@ -391,15 +391,14 @@
 	return(free_all_bootmem_core(NODE_DATA(0)));
 }
 
-void * __init __alloc_bootmem_limit (unsigned long size, unsigned long align, unsigned long goal,
-				unsigned long limit)
+void * __init __alloc_bootmem(unsigned long size, unsigned long align, unsigned long goal)
 {
 	pg_data_t *pgdat = pgdat_list;
 	void *ptr;
 
 	for_each_pgdat(pgdat)
 		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
-						 align, goal, limit)))
+						 align, goal, 0)))
 			return(ptr);
 
 	/*
@@ -411,15 +410,40 @@
 }
 
 
-void * __init __alloc_bootmem_node_limit (pg_data_t *pgdat, unsigned long size, unsigned long align,
-				     unsigned long goal, unsigned long limit)
+void * __init __alloc_bootmem_node(pg_data_t *pgdat, unsigned long size, unsigned long align,
+				   unsigned long goal)
 {
 	void *ptr;
 
-	ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal, limit);
+	ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal, 0);
 	if (ptr)
 		return (ptr);
 
-	return __alloc_bootmem_limit(size, align, goal, limit);
+	return __alloc_bootmem(size, align, goal);
 }
 
+#define LOW32LIMIT 0xffffffff
+
+void * __init __alloc_bootmem_low(unsigned long size, unsigned long align, unsigned long goal)
+{
+	pg_data_t *pgdat = pgdat_list;
+	void *ptr;
+
+	for_each_pgdat(pgdat)
+		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
+						 align, goal, LOW32LIMIT)))
+			return(ptr);
+
+	/*
+	 * Whoops, we cannot satisfy the allocation request.
+	 */
+	printk(KERN_ALERT "low bootmem alloc of %lu bytes failed!\n", size);
+	panic("Out of low memory");
+	return NULL;
+}
+
+void * __init __alloc_bootmem_low_node(pg_data_t *pgdat, unsigned long size,
+				       unsigned long align, unsigned long goal)
+{
+	return __alloc_bootmem_core(pgdat->bdata, size, align, goal, LOW32LIMIT);
+}
