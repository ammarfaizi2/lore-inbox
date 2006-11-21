Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031284AbWKUWx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031284AbWKUWx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031290AbWKUWxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:53:55 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:35751 "EHLO
	calculon.skynet.ie") by vger.kernel.org with ESMTP id S1031284AbWKUWxo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:53:44 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org, clameter@sgi.com
Message-Id: <20061121225343.11710.19257.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
References: <20061121225022.11710.72178.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 10/11] Remove dependency on page->flag bits
Date: Tue, 21 Nov 2006 22:53:43 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The page clustering implementation uses page flags to track page usage.
In preparation for their replacement with corresponding pageblock flags
remove the page->flags manipulation.

After this patch, page clustering is broken until the next patch in the set
is applied.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 arch/x86_64/kernel/e820.c  |    8 -------
 include/linux/page-flags.h |   44 +---------------------------------------
 init/Kconfig               |    1 
 mm/page_alloc.c            |   16 --------------
 4 files changed, 2 insertions(+), 67 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-101_pageblock_bits/arch/x86_64/kernel/e820.c linux-2.6.19-rc5-mm2-102_remove_clustering_flags/arch/x86_64/kernel/e820.c
--- linux-2.6.19-rc5-mm2-101_pageblock_bits/arch/x86_64/kernel/e820.c	2006-11-21 10:57:46.000000000 +0000
+++ linux-2.6.19-rc5-mm2-102_remove_clustering_flags/arch/x86_64/kernel/e820.c	2006-11-21 11:25:08.000000000 +0000
@@ -217,13 +217,6 @@ void __init e820_reserve_resources(void)
 	}
 }
 
-#ifdef CONFIG_PAGE_CLUSTERING
-static void __init
-e820_mark_nosave_range(unsigned long start, unsigned long end)
-{
-	printk("Nosave not set when anti-frag is enabled");
-}
-#else
 /* Mark pages corresponding to given address range as nosave */
 static void __init
 e820_mark_nosave_range(unsigned long start, unsigned long end)
@@ -239,7 +232,6 @@ e820_mark_nosave_range(unsigned long sta
 		if (pfn_valid(pfn))
 			SetPageNosave(pfn_to_page(pfn));
 }
-#endif
 
 /*
  * Find the ranges of physical addresses that do not correspond to
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-101_pageblock_bits/include/linux/page-flags.h linux-2.6.19-rc5-mm2-102_remove_clustering_flags/include/linux/page-flags.h
--- linux-2.6.19-rc5-mm2-101_pageblock_bits/include/linux/page-flags.h	2006-11-21 10:57:46.000000000 +0000
+++ linux-2.6.19-rc5-mm2-102_remove_clustering_flags/include/linux/page-flags.h	2006-11-21 11:25:08.000000000 +0000
@@ -82,29 +82,17 @@
 #define PG_private		11	/* If pagecache, has fs-private data */
 
 #define PG_writeback		12	/* Page is under writeback */
+#define PG_nosave		13	/* Used for system suspend/resume */
 #define PG_compound		14	/* Part of a compound page */
 #define PG_swapcache		15	/* Swap page: swp_entry_t in private */
 
 #define PG_mappedtodisk		16	/* Has blocks allocated on-disk */
 #define PG_reclaim		17	/* To be reclaimed asap */
+#define PG_nosave_free		18	/* Free, should not be written */
 #define PG_buddy		19	/* Page is free, on buddy lists */
 
 #define PG_readahead		20	/* Reminder to do readahead */
 
-/*
- * As page clustering requires two flags, it was best to reuse the suspend
- * flags and make page clustering depend on !SOFTWARE_SUSPEND. This works
- * on the assumption that machines being suspended do not really care about
- * large contiguous allocations.
- */
-#ifndef CONFIG_PAGE_CLUSTERING
-#define PG_nosave		13	/* Used for system suspend/resume */
-#define PG_nosave_free		18	/* Free, should not be written */
-#else
-#define PG_reclaimable		13	/* Page is reclaimable */
-#define PG_movable		18	/* Page is movable */
-#endif
-
 #if (BITS_PER_LONG > 32)
 /*
  * 64-bit-only flags build down from bit 31
@@ -221,7 +209,6 @@ static inline void SetPageUptodate(struc
 		ret;							\
 	})
 
-#ifndef CONFIG_PAGE_CLUSTERING
 #define PageNosave(page)	test_bit(PG_nosave, &(page)->flags)
 #define SetPageNosave(page)	set_bit(PG_nosave, &(page)->flags)
 #define TestSetPageNosave(page)	test_and_set_bit(PG_nosave, &(page)->flags)
@@ -232,33 +219,6 @@ static inline void SetPageUptodate(struc
 #define SetPageNosaveFree(page)	set_bit(PG_nosave_free, &(page)->flags)
 #define ClearPageNosaveFree(page)		clear_bit(PG_nosave_free, &(page)->flags)
 
-#define PageReclaimable(page)	(0)
-#define SetPageReclaimable(page)	do {} while (0)
-#define ClearPageReclaimable(page)	do {} while (0)
-#define __SetPageReclaimable(page)	do {} while (0)
-#define __ClearPageReclaimable(page) do {} while (0)
-
-#define PageMovable(page)	(0)
-#define SetPageMovable(page)	do {} while (0)
-#define ClearPageMovable(page)	do {} while (0)
-#define __SetPageMovable(page)	do {} while (0)
-#define __ClearPageMovable(page) do {} while (0)
-
-#else
-
-#define PageReclaimable(page)	test_bit(PG_reclaimable, &(page)->flags)
-#define SetPageReclaimable(page)	set_bit(PG_reclaimable, &(page)->flags)
-#define ClearPageReclaimable(page)	clear_bit(PG_reclaimable, &(page)->flags)
-#define __SetPageReclaimable(page)	__set_bit(PG_reclaimable, &(page)->flags)
-#define __ClearPageReclaimable(page) __clear_bit(PG_reclaimable, &(page)->flags)
-
-#define PageMovable(page)	test_bit(PG_movable, &(page)->flags)
-#define SetPageMovable(page)	set_bit(PG_movable, &(page)->flags)
-#define ClearPageMovable(page)	clear_bit(PG_movable, &(page)->flags)
-#define __SetPageMovable(page)	__set_bit(PG_movable, &(page)->flags)
-#define __ClearPageMovable(page) __clear_bit(PG_movable, &(page)->flags)
-#endif /* CONFIG_PAGE_CLUSTERING */
-
 #define PageBuddy(page)		test_bit(PG_buddy, &(page)->flags)
 #define __SetPageBuddy(page)	__set_bit(PG_buddy, &(page)->flags)
 #define __ClearPageBuddy(page)	__clear_bit(PG_buddy, &(page)->flags)
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-101_pageblock_bits/init/Kconfig linux-2.6.19-rc5-mm2-102_remove_clustering_flags/init/Kconfig
--- linux-2.6.19-rc5-mm2-101_pageblock_bits/init/Kconfig	2006-11-21 10:57:46.000000000 +0000
+++ linux-2.6.19-rc5-mm2-102_remove_clustering_flags/init/Kconfig	2006-11-21 11:25:08.000000000 +0000
@@ -502,7 +502,6 @@ config SLOB
 
 config PAGE_CLUSTERING
 	bool "Cluster movable pages together in the page allocator"
-	depends on !SOFTWARE_SUSPEND
 	def_bool n
 	help
 	  The standard allocator will fragment memory over time which means
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc5-mm2-101_pageblock_bits/mm/page_alloc.c linux-2.6.19-rc5-mm2-102_remove_clustering_flags/mm/page_alloc.c
--- linux-2.6.19-rc5-mm2-101_pageblock_bits/mm/page_alloc.c	2006-11-21 11:52:45.000000000 +0000
+++ linux-2.6.19-rc5-mm2-102_remove_clustering_flags/mm/page_alloc.c	2006-11-21 11:52:50.000000000 +0000
@@ -145,7 +145,6 @@ static unsigned long __initdata dma_rese
 #ifdef CONFIG_PAGE_CLUSTERING
 static inline int get_page_migratetype(struct page *page)
 {
-	return ((PageMovable(page) != 0) << 1) | (PageReclaimable(page) != 0);
 }
 
 static inline int gfpflags_to_migratetype(gfp_t gfp_flags)
@@ -443,14 +442,6 @@ static inline void __free_one_page(struc
 
 	page_idx = page_to_pfn(page) & ((1 << MAX_ORDER) - 1);
 
-	/*
-	 * Free pages are always marked movable so the bits are in a known
-	 * state on alloc. As movable allocations are the most common, this
-	 * will result in less bit manipulations
-	 */
-	__SetPageMovable(page);
-	__ClearPageReclaimable(page);
-
 	VM_BUG_ON(page_idx & (order_size - 1));
 	VM_BUG_ON(bad_range(zone, page));
 
@@ -850,12 +841,6 @@ static struct page *__rmqueue(struct zon
 	page = __rmqueue_fallback(zone, order, migratetype);
 
 got_page:
-	if (unlikely(migratetype != MIGRATE_MOVABLE) && page)
-		__ClearPageMovable(page);
-
-	if (migratetype == MIGRATE_RECLAIMABLE && page)
-		__SetPageReclaimable(page);
-
 	return page;
 }
 
@@ -2312,7 +2297,6 @@ void __meminit memmap_init_zone(unsigned
 		 * the address space during boot when many long-lived
 		 * kernel allocations are made
 		 */
-		SetPageMovable(page);
 
 		INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
