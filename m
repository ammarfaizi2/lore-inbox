Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbUCKAGe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUCKAGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:06:34 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:37848 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262900AbUCKAEO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:04:14 -0500
Message-ID: <404FACF4.3030601@cyberone.com.au>
Date: Thu, 11 Mar 2004 11:04:04 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
CC: Mike Fedyk <mfedyk@matchmail.com>, plate@gmx.tm
Subject: [PATCH] 2.6.4-rc2-mm1: vm-split-active-lists
Content-Type: multipart/mixed;
 boundary="------------030503010107030407070708"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030503010107030407070708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is my updated patches rolled into one.


--------------030503010107030407070708
Content-Type: text/x-patch;
 name="vm-split-active.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-split-active.patch"

 linux-2.6-npiggin/arch/i386/mm/hugetlbpage.c    |    4 
 linux-2.6-npiggin/arch/ia64/mm/hugetlbpage.c    |    4 
 linux-2.6-npiggin/arch/ppc64/mm/hugetlbpage.c   |    4 
 linux-2.6-npiggin/arch/sparc64/mm/hugetlbpage.c |    4 
 linux-2.6-npiggin/include/linux/mm_inline.h     |   33 +++-
 linux-2.6-npiggin/include/linux/mmzone.h        |   28 ---
 linux-2.6-npiggin/include/linux/page-flags.h    |   50 +++---
 linux-2.6-npiggin/include/linux/swap.h          |    2 
 linux-2.6-npiggin/kernel/sysctl.c               |    9 -
 linux-2.6-npiggin/mm/page_alloc.c               |   26 +--
 linux-2.6-npiggin/mm/swap.c                     |   35 +++-
 linux-2.6-npiggin/mm/vmscan.c                   |  193 ++++++++++--------------
 12 files changed, 197 insertions(+), 195 deletions(-)

diff -puN arch/i386/mm/hugetlbpage.c~rollup arch/i386/mm/hugetlbpage.c
--- linux-2.6/arch/i386/mm/hugetlbpage.c~rollup	2004-03-11 10:59:25.000000000 +1100
+++ linux-2.6-npiggin/arch/i386/mm/hugetlbpage.c	2004-03-11 10:59:26.000000000 +1100
@@ -411,8 +411,8 @@ static void update_and_free_page(struct 
 	htlbzone_pages--;
 	for (j = 0; j < (HPAGE_SIZE / PAGE_SIZE); j++) {
 		map->flags &= ~(1 << PG_locked | 1 << PG_error | 1 << PG_referenced |
-				1 << PG_dirty | 1 << PG_active | 1 << PG_reserved |
-				1 << PG_private | 1<< PG_writeback);
+				1 << PG_dirty | 1 << PG_active_mapped | 1 << PG_active_unmapped |
+				1 << PG_reserved | 1 << PG_private | 1<< PG_writeback);
 		set_page_count(map, 0);
 		map++;
 	}
diff -puN arch/ia64/mm/hugetlbpage.c~rollup arch/ia64/mm/hugetlbpage.c
--- linux-2.6/arch/ia64/mm/hugetlbpage.c~rollup	2004-03-11 10:59:25.000000000 +1100
+++ linux-2.6-npiggin/arch/ia64/mm/hugetlbpage.c	2004-03-11 10:59:26.000000000 +1100
@@ -431,8 +431,8 @@ void update_and_free_page(struct page *p
 	htlbzone_pages--;
 	for (j = 0; j < (HPAGE_SIZE / PAGE_SIZE); j++) {
 		map->flags &= ~(1 << PG_locked | 1 << PG_error | 1 << PG_referenced |
-				1 << PG_dirty | 1 << PG_active | 1 << PG_reserved |
-				1 << PG_private | 1<< PG_writeback);
+				1 << PG_dirty | 1 << PG_active_mapped | 1 << PG_active_unmapped |
+				1 << PG_reserved | 1 << PG_private | 1<< PG_writeback);
 		set_page_count(map, 0);
 		map++;
 	}
diff -puN arch/ppc64/mm/hugetlbpage.c~rollup arch/ppc64/mm/hugetlbpage.c
--- linux-2.6/arch/ppc64/mm/hugetlbpage.c~rollup	2004-03-11 10:59:25.000000000 +1100
+++ linux-2.6-npiggin/arch/ppc64/mm/hugetlbpage.c	2004-03-11 10:59:26.000000000 +1100
@@ -800,8 +800,8 @@ static void split_and_free_hugepage(stru
 	htlbpage_total--;
 	for (j = 0; j < (HPAGE_SIZE / PAGE_SIZE); j++) {
 		map->flags &= ~(1 << PG_locked | 1 << PG_error | 1 << PG_referenced |
-				1 << PG_dirty | 1 << PG_active | 1 << PG_reserved |
-				1 << PG_private | 1<< PG_writeback);
+				1 << PG_dirty | 1 << PG_active_mapped | 1 << PG_active_unmapped |
+				1 << PG_reserved | 1 << PG_private | 1<< PG_writeback);
 		set_page_count(map, 0);
 		map++;
 	}
diff -puN arch/sparc64/mm/hugetlbpage.c~rollup arch/sparc64/mm/hugetlbpage.c
--- linux-2.6/arch/sparc64/mm/hugetlbpage.c~rollup	2004-03-11 10:59:25.000000000 +1100
+++ linux-2.6-npiggin/arch/sparc64/mm/hugetlbpage.c	2004-03-11 10:59:26.000000000 +1100
@@ -365,8 +365,8 @@ static void update_and_free_page(struct 
 	htlbzone_pages--;
 	for (j = 0; j < (HPAGE_SIZE / PAGE_SIZE); j++) {
 		map->flags &= ~(1 << PG_locked | 1 << PG_error | 1 << PG_referenced |
-				1 << PG_dirty | 1 << PG_active | 1 << PG_reserved |
-				1 << PG_private | 1<< PG_writeback);
+				1 << PG_dirty | 1 << PG_active_mapped | 1 << PG_active_unmapped |
+				1 << PG_reserved | 1 << PG_private | 1<< PG_writeback);
 		set_page_count(map, 0);
 		map++;
 	}
diff -puN include/linux/mm_inline.h~rollup include/linux/mm_inline.h
--- linux-2.6/include/linux/mm_inline.h~rollup	2004-03-11 10:59:25.000000000 +1100
+++ linux-2.6-npiggin/include/linux/mm_inline.h	2004-03-11 10:59:26.000000000 +1100
@@ -1,9 +1,16 @@
 
 static inline void
-add_page_to_active_list(struct zone *zone, struct page *page)
+add_page_to_active_mapped_list(struct zone *zone, struct page *page)
 {
-	list_add(&page->lru, &zone->active_list);
-	zone->nr_active++;
+	list_add(&page->lru, &zone->active_mapped_list);
+	zone->nr_active_mapped++;
+}
+
+static inline void
+add_page_to_active_unmapped_list(struct zone *zone, struct page *page)
+{
+	list_add(&page->lru, &zone->active_unmapped_list);
+	zone->nr_active_unmapped++;
 }
 
 static inline void
@@ -14,10 +21,17 @@ add_page_to_inactive_list(struct zone *z
 }
 
 static inline void
-del_page_from_active_list(struct zone *zone, struct page *page)
+del_page_from_active_mapped_list(struct zone *zone, struct page *page)
+{
+	list_del(&page->lru);
+	zone->nr_active_mapped--;
+}
+
+static inline void
+del_page_from_active_unmapped_list(struct zone *zone, struct page *page)
 {
 	list_del(&page->lru);
-	zone->nr_active--;
+	zone->nr_active_unmapped--;
 }
 
 static inline void
@@ -31,9 +45,12 @@ static inline void
 del_page_from_lru(struct zone *zone, struct page *page)
 {
 	list_del(&page->lru);
-	if (PageActive(page)) {
-		ClearPageActive(page);
-		zone->nr_active--;
+	if (PageActiveMapped(page)) {
+		ClearPageActiveMapped(page);
+		zone->nr_active_mapped--;
+	} else if (PageActiveUnmapped(page)) {
+		ClearPageActiveUnmapped(page);
+		zone->nr_active_unmapped--;
 	} else {
 		zone->nr_inactive--;
 	}
diff -puN include/linux/mmzone.h~rollup include/linux/mmzone.h
--- linux-2.6/include/linux/mmzone.h~rollup	2004-03-11 10:59:25.000000000 +1100
+++ linux-2.6-npiggin/include/linux/mmzone.h	2004-03-11 10:59:26.000000000 +1100
@@ -74,11 +74,14 @@ struct zone {
 	ZONE_PADDING(_pad1_)
 
 	spinlock_t		lru_lock;	
-	struct list_head	active_list;
+	struct list_head	active_mapped_list;
+	struct list_head	active_unmapped_list;
 	struct list_head	inactive_list;
-	atomic_t		nr_scan_active;
+	atomic_t		nr_scan_active_mapped;
+	atomic_t		nr_scan_active_unmapped;
 	atomic_t		nr_scan_inactive;
-	unsigned long		nr_active;
+	unsigned long		nr_active_mapped;
+	unsigned long		nr_active_unmapped;
 	unsigned long		nr_inactive;
 	int			all_unreclaimable; /* All pages pinned */
 	unsigned long		pages_scanned;	   /* since last reclaim */
@@ -86,25 +89,6 @@ struct zone {
 	ZONE_PADDING(_pad2_)
 
 	/*
-	 * prev_priority holds the scanning priority for this zone.  It is
-	 * defined as the scanning priority at which we achieved our reclaim
-	 * target at the previous try_to_free_pages() or balance_pgdat()
-	 * invokation.
-	 *
-	 * We use prev_priority as a measure of how much stress page reclaim is
-	 * under - it drives the swappiness decision: whether to unmap mapped
-	 * pages.
-	 *
-	 * temp_priority is used to remember the scanning priority at which
-	 * this zone was successfully refilled to free_pages == pages_high.
-	 *
-	 * Access to both these fields is quite racy even on uniprocessor.  But
-	 * it is expected to average out OK.
-	 */
-	int temp_priority;
-	int prev_priority;
-
-	/*
 	 * free areas of different sizes
 	 */
 	struct free_area	free_area[MAX_ORDER];
diff -puN include/linux/page-flags.h~rollup include/linux/page-flags.h
--- linux-2.6/include/linux/page-flags.h~rollup	2004-03-11 10:59:25.000000000 +1100
+++ linux-2.6-npiggin/include/linux/page-flags.h	2004-03-11 10:59:26.000000000 +1100
@@ -58,23 +58,25 @@
 
 #define PG_dirty	 	 4
 #define PG_lru			 5
-#define PG_active		 6
-#define PG_slab			 7	/* slab debug (Suparna wants this) */
+#define PG_active_mapped	 6
+#define PG_active_unmapped	 7
 
-#define PG_highmem		 8
-#define PG_checked		 9	/* kill me in 2.5.<early>. */
-#define PG_arch_1		10
-#define PG_reserved		11
-
-#define PG_private		12	/* Has something at ->private */
-#define PG_writeback		13	/* Page is under writeback */
-#define PG_nosave		14	/* Used for system suspend/resume */
-#define PG_chainlock		15	/* lock bit for ->pte_chain */
-
-#define PG_direct		16	/* ->pte_chain points directly at pte */
-#define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
-#define PG_reclaim		18	/* To be reclaimed asap */
-#define PG_compound		19	/* Part of a compound page */
+#define PG_slab			 8	/* slab debug (Suparna wants this) */
+#define PG_highmem		 9
+#define PG_checked		10	/* kill me in 2.5.<early>. */
+#define PG_arch_1		11
+
+#define PG_reserved		12
+#define PG_private		13	/* Has something at ->private */
+#define PG_writeback		14	/* Page is under writeback */
+#define PG_nosave		15	/* Used for system suspend/resume */
+
+#define PG_chainlock		16	/* lock bit for ->pte_chain */
+#define PG_direct		17	/* ->pte_chain points directly at pte */
+#define PG_mappedtodisk		18	/* Has blocks allocated on-disk */
+#define PG_reclaim		19	/* To be reclaimed asap */
+
+#define PG_compound		20	/* Part of a compound page */
 
 
 /*
@@ -211,11 +213,17 @@ extern void get_full_page_state(struct p
 #define TestSetPageLRU(page)	test_and_set_bit(PG_lru, &(page)->flags)
 #define TestClearPageLRU(page)	test_and_clear_bit(PG_lru, &(page)->flags)
 
-#define PageActive(page)	test_bit(PG_active, &(page)->flags)
-#define SetPageActive(page)	set_bit(PG_active, &(page)->flags)
-#define ClearPageActive(page)	clear_bit(PG_active, &(page)->flags)
-#define TestClearPageActive(page) test_and_clear_bit(PG_active, &(page)->flags)
-#define TestSetPageActive(page) test_and_set_bit(PG_active, &(page)->flags)
+#define PageActiveMapped(page)		test_bit(PG_active_mapped, &(page)->flags)
+#define SetPageActiveMapped(page)	set_bit(PG_active_mapped, &(page)->flags)
+#define ClearPageActiveMapped(page)	clear_bit(PG_active_mapped, &(page)->flags)
+#define TestClearPageActiveMapped(page) test_and_clear_bit(PG_active_mapped, &(page)->flags)
+#define TestSetPageActiveMapped(page) test_and_set_bit(PG_active_mapped, &(page)->flags)
+
+#define PageActiveUnmapped(page)	test_bit(PG_active_unmapped, &(page)->flags)
+#define SetPageActiveUnmapped(page)	set_bit(PG_active_unmapped, &(page)->flags)
+#define ClearPageActiveUnmapped(page)	clear_bit(PG_active_unmapped, &(page)->flags)
+#define TestClearPageActiveUnmapped(page) test_and_clear_bit(PG_active_unmapped, &(page)->flags)
+#define TestSetPageActiveUnmapped(page) test_and_set_bit(PG_active_unmapped, &(page)->flags)
 
 #define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
 #define SetPageSlab(page)	set_bit(PG_slab, &(page)->flags)
diff -puN include/linux/swap.h~rollup include/linux/swap.h
--- linux-2.6/include/linux/swap.h~rollup	2004-03-11 10:59:26.000000000 +1100
+++ linux-2.6-npiggin/include/linux/swap.h	2004-03-11 10:59:26.000000000 +1100
@@ -175,7 +175,7 @@ extern void swap_setup(void);
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
-extern int vm_swappiness;
+extern int vm_mapped_page_cost;
 
 /* linux/mm/rmap.c */
 #ifdef CONFIG_MMU
diff -puN kernel/sysctl.c~rollup kernel/sysctl.c
--- linux-2.6/kernel/sysctl.c~rollup	2004-03-11 10:59:26.000000000 +1100
+++ linux-2.6-npiggin/kernel/sysctl.c	2004-03-11 10:59:26.000000000 +1100
@@ -621,6 +621,7 @@ static ctl_table kern_table[] = {
 /* Constants for minimum and maximum testing in vm_table.
    We use these as one-element integer vectors. */
 static int zero;
+static int one = 1;
 static int one_hundred = 100;
 
 
@@ -697,13 +698,13 @@ static ctl_table vm_table[] = {
 	},
 	{
 		.ctl_name	= VM_SWAPPINESS,
-		.procname	= "swappiness",
-		.data		= &vm_swappiness,
-		.maxlen		= sizeof(vm_swappiness),
+		.procname	= "mapped_page_cost",
+		.data		= &vm_mapped_page_cost,
+		.maxlen		= sizeof(vm_mapped_page_cost),
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec_minmax,
 		.strategy	= &sysctl_intvec,
-		.extra1		= &zero,
+		.extra1		= &one,
 		.extra2		= &one_hundred,
 	},
 #ifdef CONFIG_HUGETLB_PAGE
diff -puN mm/page_alloc.c~rollup mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c~rollup	2004-03-11 10:59:26.000000000 +1100
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-03-11 10:59:26.000000000 +1100
@@ -81,7 +81,7 @@ static void bad_page(const char *functio
 	page->flags &= ~(1 << PG_private	|
 			1 << PG_locked	|
 			1 << PG_lru	|
-			1 << PG_active	|
+			1 << PG_active_mapped	|
 			1 << PG_dirty	|
 			1 << PG_writeback);
 	set_page_count(page, 0);
@@ -217,7 +217,8 @@ static inline void free_pages_check(cons
 			1 << PG_lru	|
 			1 << PG_private |
 			1 << PG_locked	|
-			1 << PG_active	|
+			1 << PG_active_mapped	|
+			1 << PG_active_unmapped	|
 			1 << PG_reclaim	|
 			1 << PG_slab	|
 			1 << PG_writeback )))
@@ -324,7 +325,8 @@ static void prep_new_page(struct page *p
 			1 << PG_private	|
 			1 << PG_locked	|
 			1 << PG_lru	|
-			1 << PG_active	|
+			1 << PG_active_mapped	|
+			1 << PG_active_unmapped	|
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
 			1 << PG_writeback )))
@@ -818,7 +820,8 @@ unsigned int nr_used_zone_pages(void)
 	struct zone *zone;
 
 	for_each_zone(zone)
-		pages += zone->nr_active + zone->nr_inactive;
+		pages += zone->nr_active_mapped + zone->nr_active_unmapped
+			+ zone->nr_inactive;
 
 	return pages;
 }
@@ -955,7 +958,7 @@ void get_zone_counts(unsigned long *acti
 	*inactive = 0;
 	*free = 0;
 	for_each_zone(zone) {
-		*active += zone->nr_active;
+		*active += zone->nr_active_mapped + zone->nr_active_unmapped;
 		*inactive += zone->nr_inactive;
 		*free += zone->free_pages;
 	}
@@ -1068,7 +1071,7 @@ void show_free_areas(void)
 			K(zone->pages_min),
 			K(zone->pages_low),
 			K(zone->pages_high),
-			K(zone->nr_active),
+			K(zone->nr_active_mapped + zone->nr_active_unmapped),
 			K(zone->nr_inactive),
 			K(zone->present_pages)
 			);
@@ -1408,8 +1411,6 @@ static void __init free_area_init_core(s
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
 
-		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
-
 		/*
 		 * The per-cpu-pages pools are set to around 1000th of the
 		 * size of the zone.  But no more than 1/4 of a meg - there's
@@ -1443,11 +1444,14 @@ static void __init free_area_init_core(s
 		}
 		printk("  %s zone: %lu pages, LIFO batch:%lu\n",
 				zone_names[j], realsize, batch);
-		INIT_LIST_HEAD(&zone->active_list);
+		INIT_LIST_HEAD(&zone->active_mapped_list);
+		INIT_LIST_HEAD(&zone->active_unmapped_list);
 		INIT_LIST_HEAD(&zone->inactive_list);
-		atomic_set(&zone->nr_scan_active, 0);
+		atomic_set(&zone->nr_scan_active_mapped, 0);
+		atomic_set(&zone->nr_scan_active_unmapped, 0);
 		atomic_set(&zone->nr_scan_inactive, 0);
-		zone->nr_active = 0;
+		zone->nr_active_mapped = 0;
+		zone->nr_active_unmapped = 0;
 		zone->nr_inactive = 0;
 		if (!size)
 			continue;
diff -puN mm/swap.c~rollup mm/swap.c
--- linux-2.6/mm/swap.c~rollup	2004-03-11 10:59:26.000000000 +1100
+++ linux-2.6-npiggin/mm/swap.c	2004-03-11 10:59:26.000000000 +1100
@@ -58,14 +58,18 @@ int rotate_reclaimable_page(struct page 
 		return 1;
 	if (PageDirty(page))
 		return 1;
-	if (PageActive(page))
+	if (PageActiveMapped(page))
+		return 1;
+	if (PageActiveUnmapped(page))
 		return 1;
 	if (!PageLRU(page))
 		return 1;
 
 	zone = page_zone(page);
 	spin_lock_irqsave(&zone->lru_lock, flags);
-	if (PageLRU(page) && !PageActive(page)) {
+	if (PageLRU(page)
+		&& !PageActiveMapped(page) && !PageActiveUnmapped(page)) {
+
 		list_del(&page->lru);
 		list_add_tail(&page->lru, &zone->inactive_list);
 		inc_page_state(pgrotated);
@@ -84,10 +88,18 @@ void fastcall activate_page(struct page 
 	struct zone *zone = page_zone(page);
 
 	spin_lock_irq(&zone->lru_lock);
-	if (PageLRU(page) && !PageActive(page)) {
+	if (PageLRU(page)
+		&& !PageActiveMapped(page) && !PageActiveUnmapped(page)) {
+
 		del_page_from_inactive_list(zone, page);
-		SetPageActive(page);
-		add_page_to_active_list(zone, page);
+
+		if (page_mapped(page)) {
+			SetPageActiveMapped(page);
+			add_page_to_active_mapped_list(zone, page);
+		} else {
+			SetPageActiveUnmapped(page);
+			add_page_to_active_unmapped_list(zone, page);
+		}
 		inc_page_state(pgactivate);
 	}
 	spin_unlock_irq(&zone->lru_lock);
@@ -102,7 +114,8 @@ void fastcall activate_page(struct page 
  */
 void fastcall mark_page_accessed(struct page *page)
 {
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
+	if (!PageActiveMapped(page) && !PageActiveUnmapped(page)
+			&& PageReferenced(page) && PageLRU(page)) {
 		activate_page(page);
 		ClearPageReferenced(page);
 	} else if (!PageReferenced(page)) {
@@ -310,9 +323,13 @@ void __pagevec_lru_add_active(struct pag
 		}
 		if (TestSetPageLRU(page))
 			BUG();
-		if (TestSetPageActive(page))
-			BUG();
-		add_page_to_active_list(zone, page);
+		if (page_mapped(page)) {
+			SetPageActiveMapped(page);
+			add_page_to_active_mapped_list(zone, page);
+		} else {
+			SetPageActiveMapped(page);
+			add_page_to_active_unmapped_list(zone, page);
+		}
 	}
 	if (zone)
 		spin_unlock_irq(&zone->lru_lock);
diff -puN mm/vmscan.c~rollup mm/vmscan.c
--- linux-2.6/mm/vmscan.c~rollup	2004-03-11 10:59:26.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2004-03-11 10:59:26.000000000 +1100
@@ -40,10 +40,11 @@
 #include <linux/swapops.h>
 
 /*
- * From 0 .. 100.  Higher means more swappy.
+ * From 1 .. 100.  Higher means less swappy.
  */
-int vm_swappiness = 60;
-static long total_memory;
+int vm_mapped_page_cost = 8;
+
+#define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
 
 #ifdef ARCH_HAS_PREFETCH
 #define prefetch_prev_lru_page(_page, _base, _field)			\
@@ -51,8 +52,7 @@ static long total_memory;
 		if ((_page)->lru.prev != _base) {			\
 			struct page *prev;				\
 									\
-			prev = list_entry(_page->lru.prev,		\
-					struct page, lru);		\
+			prev = lru_to_page(&(_page->lru));		\
 			prefetch(&prev->_field);			\
 		}							\
 	} while (0)
@@ -66,8 +66,7 @@ static long total_memory;
 		if ((_page)->lru.prev != _base) {			\
 			struct page *prev;				\
 									\
-			prev = list_entry(_page->lru.prev,		\
-					struct page, lru);		\
+			prev = lru_to_page(&(_page->lru));			\
 			prefetchw(&prev->_field);			\
 		}							\
 	} while (0)
@@ -262,7 +261,7 @@ shrink_list(struct list_head *page_list,
 		int may_enter_fs;
 		int referenced;
 
-		page = list_entry(page_list->prev, struct page, lru);
+		page = lru_to_page(page_list);
 		list_del(&page->lru);
 
 		if (TestSetPageLocked(page))
@@ -272,7 +271,7 @@ shrink_list(struct list_head *page_list,
 		if (page_mapped(page) || PageSwapCache(page))
 			(*nr_scanned)++;
 
-		BUG_ON(PageActive(page));
+		BUG_ON(PageActiveMapped(page) || PageActiveUnmapped(page));
 
 		if (PageWriteback(page))
 			goto keep_locked;
@@ -450,7 +449,10 @@ free_it:
 		continue;
 
 activate_locked:
-		SetPageActive(page);
+		if (page_mapped(page))
+			SetPageActiveMapped(page);
+		else
+			SetPageActiveUnmapped(page);
 		pgactivate++;
 keep_locked:
 		unlock_page(page);
@@ -496,8 +498,7 @@ shrink_cache(struct zone *zone, unsigned
 
 		while (nr_scan++ < SWAP_CLUSTER_MAX &&
 				!list_empty(&zone->inactive_list)) {
-			page = list_entry(zone->inactive_list.prev,
-						struct page, lru);
+			page = lru_to_page(&zone->inactive_list);
 
 			prefetchw_prev_lru_page(page,
 						&zone->inactive_list, flags);
@@ -542,12 +543,14 @@ shrink_cache(struct zone *zone, unsigned
 		 * Put back any unfreeable pages.
 		 */
 		while (!list_empty(&page_list)) {
-			page = list_entry(page_list.prev, struct page, lru);
+			page = lru_to_page(&page_list);
 			if (TestSetPageLRU(page))
 				BUG();
 			list_del(&page->lru);
-			if (PageActive(page))
-				add_page_to_active_list(zone, page);
+			if (PageActiveMapped(page))
+				add_page_to_active_mapped_list(zone, page);
+			else if (PageActiveUnmapped(page))
+				add_page_to_active_unmapped_list(zone, page);
 			else
 				add_page_to_inactive_list(zone, page);
 			if (!pagevec_add(&pvec, page)) {
@@ -580,36 +583,32 @@ done:
  * The downside is that we have to touch page->count against each page.
  * But we had to alter page->flags anyway.
  */
-static void
-refill_inactive_zone(struct zone *zone, const int nr_pages_in,
-			struct page_state *ps)
+static void shrink_active_list(struct zone *zone, struct list_head *list,
+		unsigned long *list_count, const int nr_scan,
+		struct page_state *ps)
 {
-	int pgmoved;
+	int pgmoved, pgmoved_unmapped;
 	int pgdeactivate = 0;
-	int nr_pages = nr_pages_in;
+	int nr_pages = nr_scan;
 	LIST_HEAD(l_hold);	/* The pages which were snipped off */
 	LIST_HEAD(l_inactive);	/* Pages to go onto the inactive_list */
 	LIST_HEAD(l_active);	/* Pages to go onto the active_list */
 	struct page *page;
 	struct pagevec pvec;
-	int reclaim_mapped = 0;
-	long mapped_ratio;
-	long distress;
-	long swap_tendency;
 
 	lru_add_drain();
 	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
-	while (nr_pages && !list_empty(&zone->active_list)) {
-		page = list_entry(zone->active_list.prev, struct page, lru);
-		prefetchw_prev_lru_page(page, &zone->active_list, flags);
+	while (nr_pages && !list_empty(list)) {
+		page = lru_to_page(list);
+		prefetchw_prev_lru_page(page, list, flags);
 		if (!TestClearPageLRU(page))
 			BUG();
 		list_del(&page->lru);
 		if (page_count(page) == 0) {
 			/* It is currently in pagevec_release() */
 			SetPageLRU(page);
-			list_add(&page->lru, &zone->active_list);
+			list_add(&page->lru, list);
 		} else {
 			page_cache_get(page);
 			list_add(&page->lru, &l_hold);
@@ -617,62 +616,26 @@ refill_inactive_zone(struct zone *zone, 
 		}
 		nr_pages--;
 	}
-	zone->nr_active -= pgmoved;
+	*list_count -= pgmoved;
 	spin_unlock_irq(&zone->lru_lock);
 
-	/*
-	 * `distress' is a measure of how much trouble we're having reclaiming
-	 * pages.  0 -> no problems.  100 -> great trouble.
-	 */
-	distress = 100 >> zone->prev_priority;
-
-	/*
-	 * The point of this algorithm is to decide when to start reclaiming
-	 * mapped memory instead of just pagecache.  Work out how much memory
-	 * is mapped.
-	 */
-	mapped_ratio = (ps->nr_mapped * 100) / total_memory;
-
-	/*
-	 * Now decide how much we really want to unmap some pages.  The mapped
-	 * ratio is downgraded - just because there's a lot of mapped memory
-	 * doesn't necessarily mean that page reclaim isn't succeeding.
-	 *
-	 * The distress ratio is important - we don't want to start going oom.
-	 *
-	 * A 100% value of vm_swappiness overrides this algorithm altogether.
-	 */
-	swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
-
-	/*
-	 * Now use this metric to decide whether to start moving mapped memory
-	 * onto the inactive list.
-	 */
-	if (swap_tendency >= 100)
-		reclaim_mapped = 1;
-
 	while (!list_empty(&l_hold)) {
-		page = list_entry(l_hold.prev, struct page, lru);
+		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
-		if (page_mapped(page)) {
-			if (!reclaim_mapped) {
-				list_add(&page->lru, &l_active);
-				continue;
-			}
-			pte_chain_lock(page);
-			if (page_referenced(page)) {
-				pte_chain_unlock(page);
-				list_add(&page->lru, &l_active);
-				continue;
-			}
+		pte_chain_lock(page);
+		if (page_referenced(page)) {
 			pte_chain_unlock(page);
+			list_add(&page->lru, &l_active);
+			continue;
 		}
+		pte_chain_unlock(page);
+
 		/*
 		 * FIXME: need to consider page_count(page) here if/when we
 		 * reap orphaned pages via the LRU (Daniel's locking stuff)
 		 */
-		if (total_swap_pages == 0 && !page->mapping &&
-						!PagePrivate(page)) {
+		if (unlikely(total_swap_pages == 0 && !page->mapping &&
+						!PagePrivate(page))) {
 			list_add(&page->lru, &l_active);
 			continue;
 		}
@@ -683,11 +646,12 @@ refill_inactive_zone(struct zone *zone, 
 	pgmoved = 0;
 	spin_lock_irq(&zone->lru_lock);
 	while (!list_empty(&l_inactive)) {
-		page = list_entry(l_inactive.prev, struct page, lru);
+		page = lru_to_page(&l_inactive);
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
 		if (TestSetPageLRU(page))
 			BUG();
-		if (!TestClearPageActive(page))
+		if (!TestClearPageActiveMapped(page)
+				&& !TestClearPageActiveUnmapped(page))
 			BUG();
 		list_move(&page->lru, &zone->inactive_list);
 		pgmoved++;
@@ -711,27 +675,41 @@ refill_inactive_zone(struct zone *zone, 
 	}
 
 	pgmoved = 0;
+	pgmoved_unmapped = 0;
 	while (!list_empty(&l_active)) {
-		page = list_entry(l_active.prev, struct page, lru);
+		page = lru_to_page(&l_active);
 		prefetchw_prev_lru_page(page, &l_active, flags);
 		if (TestSetPageLRU(page))
 			BUG();
-		BUG_ON(!PageActive(page));
-		list_move(&page->lru, &zone->active_list);
-		pgmoved++;
+		if(!TestClearPageActiveMapped(page)
+				&& !TestClearPageActiveUnmapped(page))
+			BUG();
+		if (page_mapped(page)) {
+			SetPageActiveMapped(page);
+			list_move(&page->lru, &zone->active_mapped_list);
+			pgmoved++;
+		} else {
+			SetPageActiveUnmapped(page);
+			list_move(&page->lru, &zone->active_unmapped_list);
+			pgmoved_unmapped++;
+		}
+
 		if (!pagevec_add(&pvec, page)) {
-			zone->nr_active += pgmoved;
+			zone->nr_active_mapped += pgmoved;
 			pgmoved = 0;
+			zone->nr_active_unmapped += pgmoved_unmapped;
+			pgmoved_unmapped = 0;
 			spin_unlock_irq(&zone->lru_lock);
 			__pagevec_release(&pvec);
 			spin_lock_irq(&zone->lru_lock);
 		}
 	}
-	zone->nr_active += pgmoved;
+	zone->nr_active_mapped += pgmoved;
+	zone->nr_active_unmapped += pgmoved_unmapped;
 	spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(&pvec);
 
-	mod_page_state_zone(zone, pgrefill, nr_pages_in - nr_pages);
+	mod_page_state_zone(zone, pgrefill, nr_scan - nr_pages);
 	mod_page_state(pgdeactivate, pgdeactivate);
 }
 
@@ -744,6 +722,8 @@ shrink_zone(struct zone *zone, int max_s
 		int *total_scanned, struct page_state *ps)
 {
 	unsigned long ratio;
+	unsigned long long mapped_ratio;
+	unsigned long nr_active;
 	int count;
 
 	/*
@@ -756,14 +736,27 @@ shrink_zone(struct zone *zone, int max_s
 	 * just to make sure that the kernel will slowly sift through the
 	 * active list.
 	 */
-	ratio = (unsigned long)SWAP_CLUSTER_MAX * zone->nr_active /
-				((zone->nr_inactive | 1) * 2);
+	nr_active = zone->nr_active_mapped + zone->nr_active_unmapped;
+	ratio = (unsigned long)SWAP_CLUSTER_MAX * nr_active /
+				(zone->nr_inactive * 2 + 1);
+	mapped_ratio = (unsigned long long)ratio * nr_active;
+	do_div(mapped_ratio, (zone->nr_active_unmapped * vm_mapped_page_cost) +1);
+
+	ratio = ratio - mapped_ratio;
+	atomic_add(ratio+1, &zone->nr_scan_active_unmapped);
+	count = atomic_read(&zone->nr_scan_active_unmapped);
+	if (count >= SWAP_CLUSTER_MAX) {
+		atomic_set(&zone->nr_scan_active_unmapped, 0);
+		shrink_active_list(zone, &zone->active_unmapped_list,
+					&zone->nr_active_unmapped, count, ps);
+	}
 
-	atomic_add(ratio+1, &zone->nr_scan_active);
-	count = atomic_read(&zone->nr_scan_active);
+	atomic_add(mapped_ratio+1, &zone->nr_scan_active_mapped);
+	count = atomic_read(&zone->nr_scan_active_mapped);
 	if (count >= SWAP_CLUSTER_MAX) {
-		atomic_set(&zone->nr_scan_active, 0);
-		refill_inactive_zone(zone, count, ps);
+		atomic_set(&zone->nr_scan_active_mapped, 0);
+		shrink_active_list(zone, &zone->active_mapped_list,
+					&zone->nr_active_mapped, count, ps);
 	}
 
 	atomic_add(max_scan, &zone->nr_scan_inactive);
@@ -802,9 +795,6 @@ shrink_caches(struct zone **zones, int p
 		struct zone *zone = zones[i];
 		int max_scan;
 
-		if (zone->free_pages < zone->pages_high)
-			zone->temp_priority = priority;
-
 		if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 			continue;	/* Let kswapd poll it */
 
@@ -838,13 +828,9 @@ int try_to_free_pages(struct zone **zone
 	int ret = 0;
 	int nr_reclaimed = 0;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
-	int i;
 
 	inc_page_state(allocstall);
 
-	for (i = 0; zones[i] != 0; i++)
-		zones[i]->temp_priority = DEF_PRIORITY;
-
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int total_scanned = 0;
 		struct page_state ps;
@@ -877,8 +863,6 @@ int try_to_free_pages(struct zone **zone
 	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
 		out_of_memory();
 out:
-	for (i = 0; zones[i] != 0; i++)
-		zones[i]->prev_priority = zones[i]->temp_priority;
 	return ret;
 }
 
@@ -916,12 +900,6 @@ static int balance_pgdat(pg_data_t *pgda
 
 	inc_page_state(pageoutrun);
 
-	for (i = 0; i < pgdat->nr_zones; i++) {
-		struct zone *zone = pgdat->node_zones + i;
-
-		zone->temp_priority = DEF_PRIORITY;
-	}
-
 	for (priority = DEF_PRIORITY; priority; priority--) {
 		int all_zones_ok = 1;
 		int pages_scanned = 0;
@@ -972,7 +950,6 @@ scan:
 				if (zone->free_pages <= zone->pages_high)
 					all_zones_ok = 0;
 			}
-			zone->temp_priority = priority;
 			max_scan = zone->nr_inactive >> priority;
 			reclaimed = shrink_zone(zone, max_scan, GFP_KERNEL,
 					&total_scanned, ps);
@@ -998,11 +975,6 @@ scan:
 			blk_congestion_wait(WRITE, HZ/10);
 	}
 out:
-	for (i = 0; i < pgdat->nr_zones; i++) {
-		struct zone *zone = pgdat->node_zones + i;
-
-		zone->prev_priority = zone->temp_priority;
-	}
 	return nr_pages - to_free;
 }
 
@@ -1136,7 +1108,6 @@ static int __init kswapd_init(void)
 	for_each_pgdat(pgdat)
 		pgdat->kswapd
 		= find_task_by_pid(kernel_thread(kswapd, pgdat, CLONE_KERNEL));
-	total_memory = nr_free_pagecache_pages();
 	hotcpu_notifier(cpu_callback, 0);
 	return 0;
 }

_

--------------030503010107030407070708--
