Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWAYJjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWAYJjL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 04:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWAYJjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 04:39:11 -0500
Received: from ns2.suse.de ([195.135.220.15]:63967 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751059AbWAYJjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 04:39:11 -0500
Date: Wed, 25 Jan 2006 10:39:09 +0100
From: Nick Piggin <npiggin@suse.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
Subject: [RFC] non-refcounted pages, application to slab?
Message-ID: <20060125093909.GE32653@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If an allocator knows exactly the lifetime of its page, then there is no
need to do refcounting or the final put_page_zestzero (atomic op + mem
barriers).

This is probably not worthwhile for most cases, but slab did strike me
as a potential candidate (however the complication here is that some
code I think uses the refcount of underlying pages of slab allocations
eg nommu code). So it is not a complete patch, but I wonder if anyone
thinks the savings might be worth the complexity?

Is there any particular code that is really heavy on slab allocations?
That isn't mostly handled by the slab's internal freelists?

Thanks,
Nick

--
Index: linux-2.6/include/linux/gfp.h
===================================================================
--- linux-2.6.orig/include/linux/gfp.h
+++ linux-2.6/include/linux/gfp.h
@@ -47,15 +47,16 @@ struct vm_area_struct;
 #define __GFP_ZERO	((__force gfp_t)0x8000u)/* Return zeroed page on success */
 #define __GFP_NOMEMALLOC ((__force gfp_t)0x10000u) /* Don't use emergency reserves */
 #define __GFP_HARDWALL   ((__force gfp_t)0x20000u) /* Enforce hardwall cpuset memory allocs */
+#define __GFP_NOREF	((__force gfp_t)0x40000u)/* Don't refcount page */
 
 #define __GFP_BITS_SHIFT 20	/* Room for 20 __GFP_FOO bits */
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /* if you forget to add the bitmask here kernel will crash, period */
 #define GFP_LEVEL_MASK (__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS| \
-			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT| \
-			__GFP_NOFAIL|__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP| \
-			__GFP_NOMEMALLOC|__GFP_HARDWALL)
+			__GFP_COLD|__GFP_NOWARN|__GFP_REPEAT|__GFP_NOFAIL| \
+			__GFP_NORETRY|__GFP_NO_GROW|__GFP_COMP|__GFP_ZERO| \
+			__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_NOREF)
 
 /* GFP_ATOMIC means both !wait (__GFP_WAIT not set) and use emergency pool */
 #define GFP_ATOMIC	(__GFP_HIGH)
@@ -118,6 +119,12 @@ static inline struct page *alloc_pages_n
 		NODE_DATA(nid)->node_zonelists + gfp_zone(gfp_mask));
 }
 
+static inline struct page *alloc_pages_noref_node(int nid, gfp_t gfp_mask,
+						unsigned int order)
+{
+	return alloc_pages_node(nid, gfp_mask|__GFP_NOREF, order);
+}
+
 #ifdef CONFIG_NUMA
 extern struct page *alloc_pages_current(gfp_t gfp_mask, unsigned order);
 
@@ -148,7 +155,9 @@ extern unsigned long FASTCALL(get_zeroed
 		__get_free_pages((gfp_mask) | GFP_DMA,(order))
 
 extern void FASTCALL(__free_pages(struct page *page, unsigned int order));
+extern void FASTCALL(__free_pages_noref(struct page *page, unsigned int order));
 extern void FASTCALL(free_pages(unsigned long addr, unsigned int order));
+extern void FASTCALL(free_pages_noref(unsigned long addr, unsigned int order));
 extern void FASTCALL(free_hot_page(struct page *page));
 extern void FASTCALL(free_cold_page(struct page *page));
 
Index: linux-2.6/mm/slab.c
===================================================================
--- linux-2.6.orig/mm/slab.c
+++ linux-2.6/mm/slab.c
@@ -1220,7 +1220,7 @@ static void *kmem_getpages(kmem_cache_t 
 	int i;
 
 	flags |= cachep->gfpflags;
-	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
+	page = alloc_pages_noref_node(nodeid, flags, cachep->gfporder);
 	if (!page)
 		return NULL;
 	addr = page_address(page);
@@ -1253,7 +1253,7 @@ static void kmem_freepages(kmem_cache_t 
 	sub_page_state(nr_slab, nr_freed);
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += nr_freed;
-	free_pages((unsigned long)addr, cachep->gfporder);
+	free_pages_noref((unsigned long)addr, cachep->gfporder);
 	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
 		atomic_sub(1 << cachep->gfporder, &slab_reclaim_pages);
 }
@@ -2604,10 +2604,10 @@ static inline void *__cache_alloc(kmem_c
 
 	local_irq_save(save_flags);
 	objp = ____cache_alloc(cachep, flags);
+	prefetchw(objp);
 	local_irq_restore(save_flags);
 	objp = cache_alloc_debugcheck_after(cachep, flags, objp,
 					    __builtin_return_address(0));
-	prefetchw(objp);
 	return objp;
 }
 
Index: linux-2.6/mm/page_alloc.c
===================================================================
--- linux-2.6.orig/mm/page_alloc.c
+++ linux-2.6/mm/page_alloc.c
@@ -493,10 +493,19 @@ static inline void expand(struct zone *z
 	}
 }
 
+static inline void prep_zero_page(struct page *page, int order, gfp_t gfp_flags)
+{
+	int i;
+
+	VM_BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
+	for(i = 0; i < (1 << order); i++)
+		clear_highpage(page + i);
+}
+
 /*
  * This page is about to be returned from the page allocator
  */
-static int prep_new_page(struct page *page, int order)
+static int prep_new_page(struct page *page, int order, gfp_t gfp_flags)
 {
 	if (unlikely(page_mapcount(page) |
 		(page->mapping != NULL)  |
@@ -525,7 +534,16 @@ static int prep_new_page(struct page *pa
 			1 << PG_referenced | 1 << PG_arch_1 |
 			1 << PG_checked | 1 << PG_mappedtodisk);
 	set_page_private(page, 0);
-	set_page_refs(page, order);
+
+	if (!(gfp_flags & __GFP_NOREF))
+		set_page_refs(page, order);
+
+	if (gfp_flags & __GFP_ZERO)
+		prep_zero_page(page, order, gfp_flags);
+
+	if (order && (gfp_flags & __GFP_COMP))
+		prep_compound_page(page, order);
+
 	kernel_map_pages(page, 1 << order, 1);
 	return 0;
 }
@@ -733,15 +751,6 @@ void fastcall free_cold_page(struct page
 	free_hot_cold_page(page, 1);
 }
 
-static inline void prep_zero_page(struct page *page, int order, gfp_t gfp_flags)
-{
-	int i;
-
-	VM_BUG_ON((gfp_flags & (__GFP_WAIT | __GFP_HIGHMEM)) == __GFP_HIGHMEM);
-	for(i = 0; i < (1 << order); i++)
-		clear_highpage(page + i);
-}
-
 /*
  * split_page takes a non-compound higher-order page, and splits it into
  * n (1<<order) sub-pages: page[0..n]
@@ -805,14 +814,8 @@ again:
 	put_cpu();
 
 	VM_BUG_ON(bad_range(zone, page));
-	if (prep_new_page(page, order))
+	if (prep_new_page(page, order, gfp_flags))
 		goto again;
-
-	if (gfp_flags & __GFP_ZERO)
-		prep_zero_page(page, order, gfp_flags);
-
-	if (order && (gfp_flags & __GFP_COMP))
-		prep_compound_page(page, order);
 	return page;
 
 failed:
@@ -1113,6 +1116,14 @@ fastcall void __free_pages(struct page *
 
 EXPORT_SYMBOL(__free_pages);
 
+fastcall void __free_pages_noref(struct page *page, unsigned int order)
+{
+	if (order == 0)
+		free_hot_page(page);
+	else
+		__free_pages_ok(page, order);
+}
+
 fastcall void free_pages(unsigned long addr, unsigned int order)
 {
 	if (addr != 0) {
@@ -1123,6 +1134,15 @@ fastcall void free_pages(unsigned long a
 
 EXPORT_SYMBOL(free_pages);
 
+fastcall void free_pages_noref(unsigned long addr, unsigned int order)
+{
+	if (addr != 0) {
+		VM_BUG_ON(!virt_addr_valid((void *)addr));
+		__free_pages_noref(virt_to_page((void *)addr), order);
+	}
+}
+
+
 /*
  * Total amount of free (allocatable) RAM:
  */
