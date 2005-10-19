Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751623AbVJSWwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbVJSWwa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 18:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbVJSWwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 18:52:30 -0400
Received: from serv01.siteground.net ([70.85.91.68]:49082 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751622AbVJSWw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 18:52:29 -0400
Date: Wed, 19 Oct 2005 15:52:18 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>,
       Alex Williamson <alex.williamson@hp.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, shai@scalex86.org,
       mulix@mulix.org, jdmason@us.ibm.com
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Message-ID: <20051019225218.GA4684@localhost.localdomain>
References: <20051018232203.GB4535@localhost.localdomain> <1129684966.17545.50.camel@lts1.fc.hp.com> <20051019212041.6378.Y-GOTO@jp.fujitsu.com> <20051019180702.GA3680@localhost.localdomain> <Pine.LNX.4.64.0510191343590.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0510191343590.3369@g5.osdl.org>
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

On Wed, Oct 19, 2005 at 01:45:21PM -0700, Linus Torvalds wrote:
> ... 
> Can you re-post the final version as such, with explanations for the 
> commit messages and the sign-off, and people who have issues with it 
> _please_ speak up asap?

The final version which works for everyone is from Yasunori Goto. 

His patch introduces a limit parameter to the core bootmem allocator;  This
new parameter indicates that physical memory allocated by the bootmem allocator
should be within the requested limit.  The patch also introduces
alloc_bootmem_low_pages_limit(), alloc_bootmem_node_limit,
alloc_bootmem_low_pages_node_limit apis, but alloc_bootmem_low_pages_limit()
is the only api used for swiotlb.  IMO, instead of introducing xxx_limit apis,
the existing alloc_bootmem_low_pages() api could instead be changed and made 
to pass right limit to the core allocator.  But then that would make the 
patch more intrusive for 2.6.14, as other  arches use alloc_bootmem_low_pages().
(So maybe that can be done post 2.6.14 if Yasunori-san is OK with that)

With the patch, swiotlb gets memory within 4G for both x86_64 and ia64 arches.
Here's his post FYR

Thanks,
Kiran

--

From:	Yasunori Goto <y-goto@jp.fujitsu.com>
To:	Alex Williamson <alex.williamson@hp.com>,
	Ravikiran G Thirumalai <kiran@scalex86.org>
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Cc:	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
	discuss@x86-64.org, tglx@linutronix.de, shai@scalex86.org

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

