Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVB0NrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVB0NrO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 08:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbVB0NrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 08:47:13 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:32908 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261395AbVB0NnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 08:43:24 -0500
To: linux-mm@kvack.org
Subject: [PATCH] 2/2 Prezeroing large blocks of pages during allocation
Cc: linux-kernel@vger.kernel.org, clameter@sgi.com
Message-Id: <20050227134316.2D0F1ECE4@skynet.csn.ul.ie>
Date: Sun, 27 Feb 2005 13:43:16 +0000 (GMT)
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog V2
o Updated to be in sync with placement policy patches
o Fixed critical bug where non-zerod pages would be returned to __GFP_ZERO

Changelog V1
 o Initial release

This is a patch that makes a step towards merging the modified allocator
for reducing fragmentation with the prezeroing of pages that is based
on a discussion with Christoph. When a block has to be split to satisfy a
zero-page, both buddies are zero'd, one is allocated and the other is placed
on the free-list for the USERZERO pool. Care is taken to make sure the pools
are not accidentally fragmented.

When looking at /proc/buddyinfo, it will seem strange that the number of
blocks free at each order for USERZERO will never get over zero. This is
expected as when a page is freed, it cannot go back into the USERZERO pool
on the assumption it is no longer all zeros.

I would expect that a scrubber daemon would go through the KERNNORCLM pool,
remove pages, scrub them and move them to USERZERO. It is important that pages
not be moved from the USERRCLM or KERNRCLM pools as it'll cause fragmentation
problems over time.

The patch also counts how many blocks of each order were zeroed. This gives
a rough indicator if large blocks are frequently zeroed or not.  I found
that order-0 are the most frequent zeroed block because of the per-cpu
caches. This means we rarely win with zeroing in the allocator but the
accounting mechanisms are still handy for the scrubber daemon.

This patch seriously regresses how well fragmentation is handled making it
perform almost as badly as the standard allocator. It is because the fallback
ordering for USERZERO has a tendency to clobber the reserved lists because
of the mix of allocation types that need to be zeroed.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc4-v18/include/linux/mmzone.h linux-2.6.11-rc4-v18-prezero/include/linux/mmzone.h
--- linux-2.6.11-rc4-v18/include/linux/mmzone.h	2005-02-27 12:00:46.000000000 +0000
+++ linux-2.6.11-rc4-v18-prezero/include/linux/mmzone.h	2005-02-27 01:33:15.000000000 +0000
@@ -19,12 +19,13 @@
 #else
 #define MAX_ORDER CONFIG_FORCE_MAX_ZONEORDER
 #endif
-#define ALLOC_TYPES 4
-#define BITS_PER_ALLOC_TYPE 3
+#define ALLOC_TYPES 5
+#define BITS_PER_ALLOC_TYPE 4
 #define ALLOC_KERNNORCLM 0
 #define ALLOC_KERNRCLM 1
 #define ALLOC_USERRCLM 2
 #define ALLOC_FALLBACK 3
+#define ALLOC_USERZERO 4
 #define ALLOC_ACCOUNTING 1
 
 struct free_area {
@@ -170,6 +171,7 @@ struct zone {
 	unsigned long reserve_count[ALLOC_TYPES];
 	unsigned long kernnorclm_full_steal;
 	unsigned long kernnorclm_partial_steal;
+	unsigned long zeroblock_count[MAX_ORDER];
 #endif
 
 	/* 
@@ -281,6 +283,8 @@ struct zone {
 #define inc_alloc_count(zone, type) zone->alloc_count[type]++
 #define inc_kernnorclm_partial_steal(zone) zone->kernnorclm_partial_steal++
 #define inc_kernnorclm_full_steal(zone) zone->kernnorclm_full_steal++
+#define inc_zeroblock_count(zone, order, flags) \
+	flags & __GFP_ZERO ? zone->zeroblock_count[order]++ : 0
 static inline void inc_reserve_count(struct zone *zone, int type) {
 	if (type == ALLOC_FALLBACK) zone->fallback_reserve++;
 	zone->reserve_count[type]++;
@@ -301,6 +305,7 @@ static inline void dec_reserve_count(str
 		zone->fallback_reserve-- : 0
 #define inc_kernnorclm_partial_steal(zone) do {} while (0)
 #define inc_kernnorclm_full_steal(zone) do {} while (0)
+#define inc_zeroblock_count(zone, order) do {} while (0)
 #endif
 
 /*
diff -rup -X /usr/src/patchset-0.5/bin//dontdiff linux-2.6.11-rc4-v18/mm/page_alloc.c linux-2.6.11-rc4-v18-prezero/mm/page_alloc.c
--- linux-2.6.11-rc4-v18/mm/page_alloc.c	2005-02-27 12:04:19.000000000 +0000
+++ linux-2.6.11-rc4-v18-prezero/mm/page_alloc.c	2005-02-27 12:36:32.000000000 +0000
@@ -57,6 +57,8 @@ int sysctl_lowmem_reserve_ratio[MAX_NR_Z
 EXPORT_SYMBOL(totalram_pages);
 EXPORT_SYMBOL(nr_swap_pages);
 
+static inline void prep_zero_page(struct page *page, int order, int gfp_flags);
+
 /**
  * The allocator tries to put allocations of the same type in the
  * same 2^MAX_ORDER blocks of pages. When memory is low, this may
@@ -70,10 +72,11 @@ EXPORT_SYMBOL(nr_swap_pages);
  *
  */
 int fallback_allocs[ALLOC_TYPES][ALLOC_TYPES] = { 
-	{ALLOC_KERNNORCLM, ALLOC_FALLBACK,   ALLOC_KERNRCLM,   ALLOC_USERRCLM},
-	{ALLOC_KERNRCLM,   ALLOC_FALLBACK,   ALLOC_KERNNORCLM, ALLOC_USERRCLM},
-	{ALLOC_USERRCLM,   ALLOC_FALLBACK,   ALLOC_KERNNORCLM, ALLOC_KERNRCLM},
-	{ALLOC_FALLBACK,   ALLOC_KERNNORCLM, ALLOC_KERNRCLM,   ALLOC_USERRCLM}
+	{ALLOC_KERNNORCLM, ALLOC_FALLBACK,   ALLOC_USERZERO,   ALLOC_KERNRCLM,   ALLOC_USERRCLM},
+	{ALLOC_KERNRCLM,   ALLOC_FALLBACK,   ALLOC_KERNNORCLM, ALLOC_USERZERO, ALLOC_USERRCLM},
+	{ALLOC_USERRCLM,   ALLOC_FALLBACK,   ALLOC_KERNNORCLM, ALLOC_USERZERO, ALLOC_KERNRCLM},
+	{ALLOC_FALLBACK,   ALLOC_KERNNORCLM, ALLOC_KERNRCLM,   ALLOC_USERZERO, ALLOC_USERRCLM},
+	{ALLOC_USERZERO,   ALLOC_KERNNORCLM, ALLOC_FALLBACK,   ALLOC_KERNRCLM, ALLOC_USERRCLM}
 };
 
 /*
@@ -85,7 +88,7 @@ EXPORT_SYMBOL(zone_table);
 
 static char *zone_names[MAX_NR_ZONES] = { "DMA", "Normal", "HighMem" };
 static char *type_names[ALLOC_TYPES] = { "KernNoRclm", "KernRclm", 
-					"UserRclm", "Fallback"};
+					"UserRclm", "Fallback", "UserZero"};
 int min_free_kbytes = 1024;
 
 unsigned long __initdata nr_kernel_pages;
@@ -150,6 +153,9 @@ static inline int get_pageblock_type(str
 	/* Bit 3 means that the block is reserved for fallbacks */
 	if (test_bit(bitidx+2, zone->free_area_usemap)) return ALLOC_FALLBACK;
 
+	/* Bit 4 means that the block is reserved for zero-page allocations */
+	if (test_bit(bitidx+3, zone->free_area_usemap)) return ALLOC_USERZERO;
+
 	return ALLOC_KERNNORCLM;
 }
 
@@ -167,6 +173,7 @@ static inline void set_pageblock_type(st
 		set_bit(bitidx, zone->free_area_usemap);
 		clear_bit(bitidx+1, zone->free_area_usemap);
 		clear_bit(bitidx+2, zone->free_area_usemap);
+		clear_bit(bitidx+3, zone->free_area_usemap);
 		return;
 	}
 
@@ -174,6 +181,7 @@ static inline void set_pageblock_type(st
 		clear_bit(bitidx, zone->free_area_usemap);
 		set_bit(bitidx+1, zone->free_area_usemap);
 		clear_bit(bitidx+2, zone->free_area_usemap);
+		clear_bit(bitidx+3, zone->free_area_usemap);
 		return;
 	}
 
@@ -181,11 +189,23 @@ static inline void set_pageblock_type(st
 		clear_bit(bitidx, zone->free_area_usemap);
 		clear_bit(bitidx+1, zone->free_area_usemap);
 		set_bit(bitidx+2, zone->free_area_usemap);
+		clear_bit(bitidx+3, zone->free_area_usemap);
 	}
 
+
+	if (type == ALLOC_USERZERO) {
+		clear_bit(bitidx,   zone->free_area_usemap);
+		clear_bit(bitidx+1, zone->free_area_usemap);
+		clear_bit(bitidx+2, zone->free_area_usemap);
+		set_bit(bitidx+3, zone->free_area_usemap);
+		return;
+	}
+
+	/* KERNNORCLM allocation */
 	clear_bit(bitidx, zone->free_area_usemap);
 	clear_bit(bitidx+1, zone->free_area_usemap);
 	clear_bit(bitidx+2, zone->free_area_usemap);
+	clear_bit(bitidx+3, zone->free_area_usemap);
 	
 }
 
@@ -344,6 +364,12 @@ static inline void __free_pages_bulk (st
 
 	/* Select the areas to place free pages on */
 	alloctype = get_pageblock_type(page);
+
+	/*
+	 * Tricky, if the page was originally a zerod page, chances are it
+	 * is not any more
+	 */
+	if (alloctype == ALLOC_USERZERO) alloctype = ALLOC_KERNNORCLM;
 	freelist = zone->free_area_lists[alloctype];
 
 	zone->free_pages += order_size;
@@ -539,7 +565,8 @@ static void prep_new_page(struct page *p
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
-static struct page *__rmqueue(struct zone *zone, unsigned int order, int flags)
+static struct page *__rmqueue(struct zone *zone, unsigned int order, int flags,
+				unsigned long *irq_flags)
 {
 	struct free_area * area;
 	unsigned int current_order;
@@ -551,7 +578,11 @@ static struct page *__rmqueue(struct zon
 	int alloctype, start_alloctype;
 	int retry_count=0;
 	int startorder = order;
-	if (flags & __GFP_USERRCLM) {
+
+	if (flags & __GFP_ZERO) {
+		alloctype = ALLOC_USERZERO;
+	}
+	else if (flags & __GFP_USERRCLM) {
 		alloctype = ALLOC_USERRCLM;
 	}
 	else if (flags & __GFP_KERNRCLM) {
@@ -621,11 +652,49 @@ remove_page:
 			} else inc_kernnorclm_partial_steal(zone);
 		}
 
+		/*
+		 * If this is a request for a zero page and the page was
+		 * not taken from the USERZERO pool, zero it all
+		 */
+		if ((flags & __GFP_ZERO) && alloctype != ALLOC_USERZERO) {
+			int zero_order=order;
+
+			/*
+			 * This is important. We are about to zero a block
+			 * which may be larger than we need so we have to
+			 * determine do we zero just what we need or do
+			 * we zero the whole block and put the pages in
+			 * the zero page. 
+			 *
+			 * We zero the whole block in the event we are taking
+			 * from the KERNNORCLM pools and otherwise zero just
+			 * what we need. The reason we do not always zero
+			 * everything is because we do not want unreclaimable
+			 * pages to leak into the USERRCLM and KERNRCLM 
+			 * pools
+			 *
+			 */
+			if (alloctype != ALLOC_USERRCLM &&
+			    alloctype != ALLOC_KERNRCLM) {
+				area = zone->free_area_lists[ALLOC_USERZERO] +
+					current_order;
+				zero_order = current_order;
+			}
+
+			
+			spin_unlock_irqrestore(&zone->lock, *irq_flags);
+			prep_zero_page(page, zero_order, flags);
+			inc_zeroblock_count(zone, zero_order, flags);
+			spin_lock_irqsave(&zone->lock, *irq_flags);
+
+		}
+
 		return expand(zone, page, order, current_order, area);
 	}
 
 	/* Take from the global pool if this is the first attempt */
 	if (!global_split && !list_empty(&(zone->free_area_global.free_list))){
+		int reserve_type=start_alloctype;
 		/*
 		 * Remove a MAX_ORDER block from the global pool and add
 		 * it to the list of desired alloc_type
@@ -633,11 +702,22 @@ remove_page:
 		page = list_entry(zone->free_area_global.free_list.next,
 				struct page, lru);
 		list_del(&page->lru);
-		list_add(&page->lru, 
-			&(zone->free_area_lists[alloctype][MAX_ORDER-1].free_list));
 		inc_globalsteal_count(zone);
 		global_split=1;
 
+		/* Zero the whole block if this is a __GFP_ZERO allocation */
+		if (start_alloctype == ALLOC_USERZERO) {
+			spin_unlock_irqrestore(&zone->lock, *irq_flags);
+			prep_zero_page(page, MAX_ORDER-1, flags);
+			inc_zeroblock_count(zone, MAX_ORDER-1, flags);
+
+			/* Do not bother reserving zones for zeroed allocs */
+			reserve_type=ALLOC_KERNNORCLM;
+			spin_lock_irqsave(&zone->lock, *irq_flags);
+		}
+
+		list_add(&page->lru, 
+			&(zone->free_area_lists[start_alloctype][MAX_ORDER-1].free_list));
 		/* 
 		 * Reserve this whole block of pages. If the number of blocks
 		 * reserved for fallbacks is below 10%, it will be reserved
@@ -652,8 +732,8 @@ remove_page:
 			set_pageblock_type(page, zone, ALLOC_FALLBACK);
 			inc_reserve_count(zone, ALLOC_FALLBACK);
 		} else {
-			set_pageblock_type(page, zone, alloctype);
-			inc_reserve_count(zone, alloctype);
+			set_pageblock_type(page, zone, reserve_type);
+			inc_reserve_count(zone, reserve_type);
 		}
 		startorder = MAX_ORDER-1;
 
@@ -709,7 +789,7 @@ static int rmqueue_bulk(struct zone *zon
 	
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		page = __rmqueue(zone, order, gfp_flags);
+		page = __rmqueue(zone, order, gfp_flags, &flags);
 		if (page == NULL)
 			break;
 		allocated++;
@@ -866,6 +946,7 @@ buffered_rmqueue(struct zone *zone, int 
 	unsigned long flags;
 	struct page *page = NULL;
 	int cold = !!(gfp_flags & __GFP_COLD);
+	int need_zero=0;
 
 	if (order == 0 && (gfp_flags & __GFP_USERRCLM)) {
 		struct per_cpu_pages *pcp;
@@ -880,14 +961,19 @@ buffered_rmqueue(struct zone *zone, int 
 			page = list_entry(pcp->list.next, struct page, lru);
 			list_del(&page->lru);
 			pcp->count--;
+			if (gfp_flags & __GFP_ZERO) need_zero=1;
 		}
 		local_irq_restore(flags);
 		put_cpu();
+		if (need_zero) {
+			prep_zero_page(page, order, gfp_flags);
+			inc_zeroblock_count(zone, order, gfp_flags);
+		}
 	}
 
 	if (page == NULL) {
 		spin_lock_irqsave(&zone->lock, flags);
-		page = __rmqueue(zone, order, gfp_flags);
+		page = __rmqueue(zone, order, gfp_flags, &flags);
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
 
@@ -896,9 +982,6 @@ buffered_rmqueue(struct zone *zone, int 
 		mod_page_state_zone(zone, pgalloc, 1 << order);
 		prep_new_page(page, order);
 
-		if (gfp_flags & __GFP_ZERO)
-			prep_zero_page(page, order, gfp_flags);
-
 		if (order && (gfp_flags & __GFP_COMP))
 			prep_compound_page(page, order);
 	}
@@ -1975,6 +2058,8 @@ static void __init free_area_init_core(s
 					sizeof(zone->alloc_count));
 		memset((unsigned long *)zone->alloc_count, 0, 
 					sizeof(zone->alloc_count));
+		memset((unsigned long *)zone->zeroblock_count, 0,
+					sizeof(zone->zeroblock_count));
 		zone->kernnorclm_partial_steal=0;
 		zone->kernnorclm_full_steal=0;
 #endif
@@ -2164,6 +2249,13 @@ static int frag_show(struct seq_file *m,
 			reserve_count[i] += zone->reserve_count[i];
 			fallback_count[i] += zone->fallback_count[i];
 		}
+
+		seq_printf(m, "Zeroblock count ");
+		for (i=0; i < MAX_ORDER; i++) {
+			seq_printf(m, "%6lu ", zone->zeroblock_count[i]);
+		}
+		seq_printf(m, "\n");
+
  
 #endif
 		spin_unlock_irqrestore(&zone->lock, flags);
