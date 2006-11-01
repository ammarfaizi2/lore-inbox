Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946793AbWKALTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946793AbWKALTr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 06:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946795AbWKALTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 06:19:46 -0500
Received: from calculon.skynet.ie ([193.1.99.88]:1932 "EHLO calculon.skynet.ie")
	by vger.kernel.org with ESMTP id S1946793AbWKALTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 06:19:42 -0500
From: Mel Gorman <mel@csn.ul.ie>
To: linux-mm@kvack.org
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org
Message-Id: <20061101111940.18798.50389.sendpatchset@skynet.skynet.ie>
In-Reply-To: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
References: <20061101111620.18798.34778.sendpatchset@skynet.skynet.ie>
Subject: [PATCH 10/11] Remove dependency on page->flag bits
Date: Wed,  1 Nov 2006 11:19:41 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The anti-fragmentation implementation uses page flags to track page usage.
In preparation for their replacement with corresponding pageblock flags
remove the page->flags manipulation.

After this patch, anti-fragmentation is broken until the next patch in the
set is applied.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>
---

 arch/x86_64/kernel/e820.c  |    8 -------
 include/linux/page-flags.h |   45 +---------------------------------------
 init/Kconfig               |    1 
 mm/page_alloc.c            |   10 --------
 4 files changed, 2 insertions(+), 62 deletions(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-101_pageblock_bits/arch/x86_64/kernel/e820.c linux-2.6.19-rc4-mm1-102_remove_antifrag_pageflags/arch/x86_64/kernel/e820.c
--- linux-2.6.19-rc4-mm1-101_pageblock_bits/arch/x86_64/kernel/e820.c	2006-10-31 13:52:17.000000000 +0000
+++ linux-2.6.19-rc4-mm1-102_remove_antifrag_pageflags/arch/x86_64/kernel/e820.c	2006-10-31 17:44:48.000000000 +0000
@@ -217,13 +217,6 @@ void __init e820_reserve_resources(void)
 	}
 }
 
-#ifdef CONFIG_PAGEALLOC_ANTIFRAG
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
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-101_pageblock_bits/include/linux/page-flags.h linux-2.6.19-rc4-mm1-102_remove_antifrag_pageflags/include/linux/page-flags.h
--- linux-2.6.19-rc4-mm1-101_pageblock_bits/include/linux/page-flags.h	2006-10-31 13:52:17.000000000 +0000
+++ linux-2.6.19-rc4-mm1-102_remove_antifrag_pageflags/include/linux/page-flags.h	2006-10-31 17:44:48.000000000 +0000
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
- * As anti-fragmentation requires two flags, it was best to reuse the suspend
- * flags and make anti-fragmentation depend on !SOFTWARE_SUSPEND. This works
- * on the assumption that machines being suspended do not really care about
- * large contiguous allocations.
- */
-#ifndef CONFIG_PAGEALLOC_ANTIFRAG
-#define PG_nosave		13	/* Used for system suspend/resume */
-#define PG_nosave_free		18	/* Free, should not be written */
-#else
-#define PG_kernrclm		13	/* Page is a kernel reclaim page */
-#define PG_easyrclm		18	/* Page is an easy reclaim page */
-#endif
-
 #if (BITS_PER_LONG > 32)
 /*
  * 64-bit-only flags build down from bit 31
@@ -221,7 +209,6 @@ static inline void SetPageUptodate(struc
 		ret;							\
 	})
 
-#ifndef CONFIG_PAGEALLOC_ANTIFRAG
 #define PageNosave(page)	test_bit(PG_nosave, &(page)->flags)
 #define SetPageNosave(page)	set_bit(PG_nosave, &(page)->flags)
 #define TestSetPageNosave(page)	test_and_set_bit(PG_nosave, &(page)->flags)
@@ -232,34 +219,6 @@ static inline void SetPageUptodate(struc
 #define SetPageNosaveFree(page)	set_bit(PG_nosave_free, &(page)->flags)
 #define ClearPageNosaveFree(page)		clear_bit(PG_nosave_free, &(page)->flags)
 
-#define PageKernRclm(page)	(0)
-#define SetPageKernRclm(page)	do {} while (0)
-#define ClearPageKernRclm(page)	do {} while (0)
-#define __SetPageKernRclm(page)	do {} while (0)
-#define __ClearPageKernRclm(page) do {} while (0)
-
-#define PageEasyRclm(page)	(0)
-#define SetPageEasyRclm(page)	do {} while (0)
-#define ClearPageEasyRclm(page)	do {} while (0)
-#define __SetPageEasyRclm(page)	do {} while (0)
-#define __ClearPageEasyRclm(page) do {} while (0)
-
-#else
-
-#define PageKernRclm(page)	test_bit(PG_kernrclm, &(page)->flags)
-#define SetPageKernRclm(page)	set_bit(PG_kernrclm, &(page)->flags)
-#define ClearPageKernRclm(page)	clear_bit(PG_kernrclm, &(page)->flags)
-#define __SetPageKernRclm(page)	__set_bit(PG_kernrclm, &(page)->flags)
-#define __ClearPageKernRclm(page) __clear_bit(PG_kernrclm, &(page)->flags)
-
-#define PageEasyRclm(page)	test_bit(PG_easyrclm, &(page)->flags)
-#define SetPageEasyRclm(page)	set_bit(PG_easyrclm, &(page)->flags)
-#define ClearPageEasyRclm(page)	clear_bit(PG_easyrclm, &(page)->flags)
-#define __SetPageEasyRclm(page)	__set_bit(PG_easyrclm, &(page)->flags)
-#define __ClearPageEasyRclm(page) __clear_bit(PG_easyrclm, &(page)->flags)
-#endif /* CONFIG_PAGEALLOC_ANTIFRAG */
-
-
 #define PageBuddy(page)		test_bit(PG_buddy, &(page)->flags)
 #define __SetPageBuddy(page)	__set_bit(PG_buddy, &(page)->flags)
 #define __ClearPageBuddy(page)	__clear_bit(PG_buddy, &(page)->flags)
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-101_pageblock_bits/init/Kconfig linux-2.6.19-rc4-mm1-102_remove_antifrag_pageflags/init/Kconfig
--- linux-2.6.19-rc4-mm1-101_pageblock_bits/init/Kconfig	2006-10-31 13:52:17.000000000 +0000
+++ linux-2.6.19-rc4-mm1-102_remove_antifrag_pageflags/init/Kconfig	2006-10-31 17:44:48.000000000 +0000
@@ -494,7 +494,6 @@ config PAGEALLOC_ANTIFRAG
 	  you are interested in working with large pages, say Y and set
 	  /proc/sys/vm/min_free_bytes to be 10% of physical memory. Otherwise
  	  say N
-	depends on !SOFTWARE_SUSPEND
 
 menu "Loadable module support"
 
diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.19-rc4-mm1-101_pageblock_bits/mm/page_alloc.c linux-2.6.19-rc4-mm1-102_remove_antifrag_pageflags/mm/page_alloc.c
--- linux-2.6.19-rc4-mm1-101_pageblock_bits/mm/page_alloc.c	2006-10-31 17:42:25.000000000 +0000
+++ linux-2.6.19-rc4-mm1-102_remove_antifrag_pageflags/mm/page_alloc.c	2006-10-31 17:44:48.000000000 +0000
@@ -142,7 +142,6 @@ static unsigned long __initdata dma_rese
 #ifdef CONFIG_PAGEALLOC_ANTIFRAG
 static inline int get_page_rclmtype(struct page *page)
 {
-	return ((PageEasyRclm(page) != 0) << 1) | (PageKernRclm(page) != 0);
 }
 
 static inline int gfpflags_to_rclmtype(gfp_t gfp_flags)
@@ -440,8 +439,6 @@ static inline void __free_one_page(struc
 		destroy_compound_page(page, order);
 
 	page_idx = page_to_pfn(page) & ((1 << MAX_ORDER) - 1);
-	__SetPageEasyRclm(page);
-	__ClearPageKernRclm(page);
 
 	VM_BUG_ON(page_idx & (order_size - 1));
 	VM_BUG_ON(bad_range(zone, page));
@@ -834,12 +831,6 @@ static struct page *__rmqueue(struct zon
 	page = __rmqueue_fallback(zone, order, gfp_flags);
 
 got_page:
-	if (unlikely(rclmtype != RCLM_EASY) && page)
-		__ClearPageEasyRclm(page);
-
-	if (rclmtype == RCLM_KERN && page)
-		SetPageKernRclm(page);
-
 	return page;
 }
 
@@ -2185,7 +2176,6 @@ void __meminit memmap_init_zone(unsigned
 		init_page_count(page);
 		reset_page_mapcount(page);
 		SetPageReserved(page);
-		SetPageEasyRclm(page);
 		INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
 		/* The shift won't overflow because ZONE_NORMAL is below 4G. */
