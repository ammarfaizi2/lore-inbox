Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750911AbVJSMr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbVJSMr6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 08:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbVJSMr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 08:47:58 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:59281 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750911AbVJSMr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 08:47:57 -0400
Date: Wed, 19 Oct 2005 21:47:02 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Alex Williamson <alex.williamson@hp.com>,
       Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, shai@scalex86.org
In-Reply-To: <1129684966.17545.50.camel@lts1.fc.hp.com>
References: <20051018232203.GB4535@localhost.localdomain> <1129684966.17545.50.camel@lts1.fc.hp.com>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.051
Message-Id: <20051019212041.6378.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2005-10-18 at 16:22 -0700, Ravikiran G Thirumalai wrote:
> 
> > Hope the following works.   Using __alloc_bootmem_node now with a hard coded
> > goal to avoid 16MB DMA zone.  It is ugly :( and hope it works this time
> > <fingers crossed>. 
> 
>    Nope, it still gives me memory above 4GB.  If I change goal to 0x0 it
> works. 
>  One nit, shouldn't IS_LOW_AGES() be more like this:
> 
> #define IS_LOWPAGES(paddr, size) ((paddr+size-1) < 0x100000000UL)
> 
> Minor optimization not checking the start, but a 64MB swiotlb starting
> at 4GB-64MB should be found as ok.  Thanks,
> 
> 	Alex
> 


Hmm.....
How is this patch? This is another way.

I think that true issue is there is no way for requester to
specify maxmum address at __alloc_bootmem_core().

"goal" is just to keep space lower address as much as possible.
and __alloc_bootmem_core() doesn't care about max address for requester.
I suppose it is a bit strange. The swiotlb's case is good example
by it.

So, I made a patch that __alloc_bootmem_core() cares it.

Thanks.


Signed-off-by: Yasunori Goto <y-goto@jp.fujitsu.com>
-------

Index: 3rdbootmem/arch/ia64/lib/swiotlb.c
===================================================================
--- 3rdbootmem.orig/arch/ia64/lib/swiotlb.c	2005-10-19 21:05:15.000000000 +0900
+++ 3rdbootmem/arch/ia64/lib/swiotlb.c	2005-10-19 21:05:18.000000000 +0900
@@ -123,8 +123,8 @@ swiotlb_init_with_default_size (size_t d
 	/*
 	 * Get IO TLB memory from the low pages
 	 */
-	io_tlb_start = alloc_bootmem_low_pages(io_tlb_nslabs *
-					       (1 << IO_TLB_SHIFT));
+	io_tlb_start = alloc_bootmem_low_pages_limit(io_tlb_nslabs *
+					     (1 << IO_TLB_SHIFT), 0x100000000);
 	if (!io_tlb_start)
 		panic("Cannot allocate SWIOTLB buffer");
 	io_tlb_end = io_tlb_start + io_tlb_nslabs * (1 << IO_TLB_SHIFT);
Index: 3rdbootmem/include/linux/bootmem.h
===================================================================
--- 3rdbootmem.orig/include/linux/bootmem.h	2005-10-19 21:05:15.000000000 +0900
+++ 3rdbootmem/include/linux/bootmem.h	2005-10-19 21:09:21.000000000 +0900
@@ -43,7 +43,7 @@ typedef struct bootmem_data {
 extern unsigned long __init bootmem_bootmap_pages (unsigned long);
 extern unsigned long __init init_bootmem (unsigned long addr, unsigned long memend);
 extern void __init free_bootmem (unsigned long addr, unsigned long size);
-extern void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal);
+extern void * __init __alloc_bootmem_limit (unsigned long size, unsigned long align, unsigned long goal, unsigned long limit);
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 extern void __init reserve_bootmem (unsigned long addr, unsigned long size);
 #define alloc_bootmem(x) \
@@ -54,6 +54,16 @@ extern void __init reserve_bootmem (unsi
 	__alloc_bootmem((x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low_pages(x) \
 	__alloc_bootmem((x), PAGE_SIZE, 0)
+
+#define alloc_bootmem_limit(x, limit)						\
+	__alloc_bootmem_limit((x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS), (limit))
+#define alloc_bootmem_low_limit(x, limit)			\
+	__alloc_bootmem_limit((x), SMP_CACHE_BYTES, 0, (limit))
+#define alloc_bootmem_pages_limit(x, limit)					\
+	__alloc_bootmem_limit((x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS), (limit))
+#define alloc_bootmem_low_pages_limit(x, limit)		\
+	__alloc_bootmem_limit((x), PAGE_SIZE, 0, (limit))
+
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
 extern unsigned long __init free_all_bootmem (void);
 
@@ -61,7 +71,7 @@ extern unsigned long __init init_bootmem
 extern void __init reserve_bootmem_node (pg_data_t *pgdat, unsigned long physaddr, unsigned long size);
 extern void __init free_bootmem_node (pg_data_t *pgdat, unsigned long addr, unsigned long size);
 extern unsigned long __init free_all_bootmem_node (pg_data_t *pgdat);
-extern void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal);
+extern void * __init __alloc_bootmem_node_limit (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal, unsigned long limit);
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 #define alloc_bootmem_node(pgdat, x) \
 	__alloc_bootmem_node((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS))
@@ -69,6 +79,14 @@ extern void * __init __alloc_bootmem_nod
 	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS))
 #define alloc_bootmem_low_pages_node(pgdat, x) \
 	__alloc_bootmem_node((pgdat), (x), PAGE_SIZE, 0)
+
+#define alloc_bootmem_node_limit(pgdat, x, limit)				\
+	__alloc_bootmem_node_limit((pgdat), (x), SMP_CACHE_BYTES, __pa(MAX_DMA_ADDRESS), (limit))
+#define alloc_bootmem_pages_node_limit(pgdat, x, limit)				\
+	__alloc_bootmem_node_limit((pgdat), (x), PAGE_SIZE, __pa(MAX_DMA_ADDRESS), (limit))
+#define alloc_bootmem_low_pages_node_limit(pgdat, x, limit)		\
+	__alloc_bootmem_node_limit((pgdat), (x), PAGE_SIZE, 0, (limit))
+
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
 
 #ifdef CONFIG_HAVE_ARCH_ALLOC_REMAP
@@ -105,5 +123,15 @@ extern void *__init alloc_large_system_h
 #endif
 extern int __initdata hashdist;		/* Distribute hashes across NUMA nodes? */
 
+static inline void *__alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal)
+{
+	return __alloc_bootmem_limit(size, align, goal, 0);
+}
+
+static inline void *__alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align,
+				     unsigned long goal)
+{
+	return __alloc_bootmem_node_limit(pgdat, size, align, goal, 0);
+}
 
 #endif /* _LINUX_BOOTMEM_H */
Index: 3rdbootmem/mm/bootmem.c
===================================================================
--- 3rdbootmem.orig/mm/bootmem.c	2005-10-19 21:05:15.000000000 +0900
+++ 3rdbootmem/mm/bootmem.c	2005-10-19 21:05:18.000000000 +0900
@@ -154,10 +154,10 @@ static void __init free_bootmem_core(boo
  */
 static void * __init
 __alloc_bootmem_core(struct bootmem_data *bdata, unsigned long size,
-		unsigned long align, unsigned long goal)
+	      unsigned long align, unsigned long goal, unsigned long limit)
 {
 	unsigned long offset, remaining_size, areasize, preferred;
-	unsigned long i, start = 0, incr, eidx;
+	unsigned long i, start = 0, incr, eidx, end_pfn = bdata->node_low_pfn;
 	void *ret;
 
 	if(!size) {
@@ -166,7 +166,14 @@ __alloc_bootmem_core(struct bootmem_data
 	}
 	BUG_ON(align & (align-1));
 
-	eidx = bdata->node_low_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
+	if (limit && bdata->node_boot_start >= limit)
+		return NULL;
+
+        limit >>=PAGE_SHIFT;
+	if (limit && end_pfn > limit)
+		end_pfn = limit;
+
+	eidx = end_pfn - (bdata->node_boot_start >> PAGE_SHIFT);
 	offset = 0;
 	if (align &&
 	    (bdata->node_boot_start & (align - 1UL)) != 0)
@@ -178,11 +185,12 @@ __alloc_bootmem_core(struct bootmem_data
 	 * first, then we try to allocate lower pages.
 	 */
 	if (goal && (goal >= bdata->node_boot_start) && 
-	    ((goal >> PAGE_SHIFT) < bdata->node_low_pfn)) {
+	    ((goal >> PAGE_SHIFT) < end_pfn)) {
 		preferred = goal - bdata->node_boot_start;
 
 		if (bdata->last_success >= preferred)
-			preferred = bdata->last_success;
+			if (!limit || (limit && limit > bdata->last_success))
+				preferred = bdata->last_success;
 	} else
 		preferred = 0;
 
@@ -382,14 +390,15 @@ unsigned long __init free_all_bootmem (v
 	return(free_all_bootmem_core(NODE_DATA(0)));
 }
 
-void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal)
+void * __init __alloc_bootmem_limit (unsigned long size, unsigned long align, unsigned long goal,
+				unsigned long limit)
 {
 	pg_data_t *pgdat = pgdat_list;
 	void *ptr;
 
 	for_each_pgdat(pgdat)
 		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
-						align, goal)))
+						 align, goal, limit)))
 			return(ptr);
 
 	/*
@@ -400,14 +409,16 @@ void * __init __alloc_bootmem (unsigned 
 	return NULL;
 }
 
-void * __init __alloc_bootmem_node (pg_data_t *pgdat, unsigned long size, unsigned long align, unsigned long goal)
+
+void * __init __alloc_bootmem_node_limit (pg_data_t *pgdat, unsigned long size, unsigned long align,
+				     unsigned long goal, unsigned long limit)
 {
 	void *ptr;
 
-	ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal);
+	ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal, limit);
 	if (ptr)
 		return (ptr);
 
-	return __alloc_bootmem(size, align, goal);
+	return __alloc_bootmem_limit(size, align, goal, limit);
 }
 


-- 
Yasunori Goto 

