Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264114AbUDRElt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 00:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbUDRElt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 00:41:49 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:31671 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264114AbUDRElT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 00:41:19 -0400
Message-ID: <408206E8.5000600@yahoo.com.au>
Date: Sun, 18 Apr 2004 14:41:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Singer <elf@buici.com>
CC: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
References: <20040417193855.GP743@holomorphy.com> <20040417212958.GA8722@flea> <20040417162125.3296430a.akpm@osdl.org> <20040417233037.GA15576@flea> <20040417165151.24b1fed5.akpm@osdl.org> <20040418002343.GA16025@flea> <4081F809.4030606@yahoo.com.au> <20040418041748.GW743@holomorphy.com>
In-Reply-To: <20040418041748.GW743@holomorphy.com>
Content-Type: multipart/mixed;
 boundary="------------090306040603040809030804"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090306040603040809030804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

William Lee Irwin III wrote:
> On Sun, Apr 18, 2004 at 01:37:45PM +1000, Nick Piggin wrote:
> 
>>swappiness is pretty arbitrary and unfortunately it means
>>different things to machines with different sized memory.
>>Also, once you *have* gone past the reclaim_mapped threshold,
>>mapped pages aren't really given any preference above
>>unmapped pages.
>>I have a small patchset which splits the active list roughly
>>into mapped and unmapped pages. It might hopefully solve your
>>problem. Would you give it a try? It is pretty stable here.
> 
> 
> It would be interesting to see the results of this on Marc's system.
> It's a more comprehensive solution than tweaking numbers.
> 

Well, here is the current patch against 2.6.5-mm6. -mm is
different enough from -linus now that it is not 100% trivial
to patch (mainly the rmap and hugepages work).

Marc if you could test this it would be great. I've been doing
very swap heavy tests for the last 24 hours on a SMP system
here, so it should be fairly stable.

It replaces /proc/sys/vm/swappiness with
/proc/sys/vm/mapped_page_cost, which is in units of unmapped
pages. I have found 8 to be pretty good, so that is the
default. Higher makes it less likely to evict mapped pages.

Nick

--------------090306040603040809030804
Content-Type: text/x-patch;
 name="split-active-list.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="split-active-list.patch"

 linux-2.6-npiggin/include/linux/buffer_head.h |    1 
 linux-2.6-npiggin/include/linux/mm_inline.h   |   48 +++++--
 linux-2.6-npiggin/include/linux/mmzone.h      |   28 ----
 linux-2.6-npiggin/include/linux/page-flags.h  |   54 ++++---
 linux-2.6-npiggin/include/linux/swap.h        |    4 
 linux-2.6-npiggin/kernel/sysctl.c             |    9 -
 linux-2.6-npiggin/mm/filemap.c                |    6 
 linux-2.6-npiggin/mm/hugetlb.c                |    9 -
 linux-2.6-npiggin/mm/memory.c                 |    1 
 linux-2.6-npiggin/mm/page_alloc.c             |   26 ++-
 linux-2.6-npiggin/mm/shmem.c                  |    1 
 linux-2.6-npiggin/mm/swap.c                   |   54 +------
 linux-2.6-npiggin/mm/vmscan.c                 |  176 ++++++++++----------------
 13 files changed, 193 insertions(+), 224 deletions(-)

diff -puN include/linux/buffer_head.h~rollup include/linux/buffer_head.h
--- linux-2.6/include/linux/buffer_head.h~rollup	2004-04-18 14:30:20.000000000 +1000
+++ linux-2.6-npiggin/include/linux/buffer_head.h	2004-04-18 14:30:21.000000000 +1000
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/linkage.h>
 #include <linux/wait.h>
+#include <linux/mm_inline.h>
 #include <asm/atomic.h>
 
 enum bh_state_bits {
diff -puN include/linux/mm_inline.h~rollup include/linux/mm_inline.h
--- linux-2.6/include/linux/mm_inline.h~rollup	2004-04-18 14:30:20.000000000 +1000
+++ linux-2.6-npiggin/include/linux/mm_inline.h	2004-04-18 14:30:21.000000000 +1000
@@ -1,9 +1,21 @@
+#ifndef _LINUX_MM_INLINE_H
+#define _LINUX_MM_INLINE_H
+
+#include <linux/mm.h>
+#include <linux/page-flags.h>
 
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
@@ -14,10 +26,17 @@ add_page_to_inactive_list(struct zone *z
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
@@ -31,10 +50,23 @@ static inline void
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
 }
+
+/*
+ * Mark a page as having seen activity.
+ */
+static inline void mark_page_accessed(struct page *page)
+{
+	SetPageReferenced(page);
+}
+
+#endif /* _LINUX_MM_INLINE_H */
diff -puN include/linux/mmzone.h~rollup include/linux/mmzone.h
--- linux-2.6/include/linux/mmzone.h~rollup	2004-04-18 14:30:20.000000000 +1000
+++ linux-2.6-npiggin/include/linux/mmzone.h	2004-04-18 14:30:21.000000000 +1000
@@ -104,11 +104,14 @@ struct zone {
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
@@ -116,25 +119,6 @@ struct zone {
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
--- linux-2.6/include/linux/page-flags.h~rollup	2004-04-18 14:30:20.000000000 +1000
+++ linux-2.6-npiggin/include/linux/page-flags.h	2004-04-18 14:30:21.000000000 +1000
@@ -58,25 +58,27 @@
 
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
-#define PG_maplock		15	/* Lock bit for rmap to ptes */
-
-#define PG_direct		16	/* ->pte_chain points directly at pte */
-#define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
-#define PG_reclaim		18	/* To be reclaimed asap */
-#define PG_compound		19	/* Part of a compound page */
-#define PG_anon			20	/* Anonymous page: anon_vma in mapping*/
-#define PG_swapcache		21	/* Swap page: swp_entry_t in private */
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
+#define PG_maplock		16	/* Lock bit for rmap to ptes */
+#define PG_direct		17	/* ->pte_chain points directly at pte */
+#define PG_mappedtodisk		18	/* Has blocks allocated on-disk */
+#define PG_reclaim		19	/* To be reclaimed asap */
+
+#define PG_compound		20	/* Part of a compound page */
+#define PG_anon			21	/* Anonymous page: anon_vma in mapping*/
+#define PG_swapcache		22	/* Swap page: swp_entry_t in private */
 
 
 /*
@@ -213,11 +215,17 @@ extern void get_full_page_state(struct p
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
--- linux-2.6/include/linux/swap.h~rollup	2004-04-18 14:30:20.000000000 +1000
+++ linux-2.6-npiggin/include/linux/swap.h	2004-04-18 14:30:21.000000000 +1000
@@ -165,8 +165,6 @@ extern unsigned int nr_free_pagecache_pa
 /* linux/mm/swap.c */
 extern void FASTCALL(lru_cache_add(struct page *));
 extern void FASTCALL(lru_cache_add_active(struct page *));
-extern void FASTCALL(activate_page(struct page *));
-extern void FASTCALL(mark_page_accessed(struct page *));
 extern void lru_add_drain(void);
 extern int rotate_reclaimable_page(struct page *page);
 extern void swap_setup(void);
@@ -174,7 +172,7 @@ extern void swap_setup(void);
 /* linux/mm/vmscan.c */
 extern int try_to_free_pages(struct zone **, unsigned int, unsigned int);
 extern int shrink_all_memory(int);
-extern int vm_swappiness;
+extern int vm_mapped_page_cost;
 
 #ifdef CONFIG_MMU
 /* linux/mm/shmem.c */
diff -puN kernel/sysctl.c~rollup kernel/sysctl.c
--- linux-2.6/kernel/sysctl.c~rollup	2004-04-18 14:30:20.000000000 +1000
+++ linux-2.6-npiggin/kernel/sysctl.c	2004-04-18 14:30:21.000000000 +1000
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
diff -puN mm/filemap.c~rollup mm/filemap.c
--- linux-2.6/mm/filemap.c~rollup	2004-04-18 14:30:20.000000000 +1000
+++ linux-2.6-npiggin/mm/filemap.c	2004-04-18 14:30:21.000000000 +1000
@@ -663,11 +663,7 @@ page_ok:
 		if (mapping_writably_mapped(mapping))
 			flush_dcache_page(page);
 
-		/*
-		 * Mark the page accessed if we read the beginning.
-		 */
-		if (!offset)
-			mark_page_accessed(page);
+		mark_page_accessed(page);
 
 		/*
 		 * Ok, we have the page, and it's up-to-date, so
diff -puN mm/hugetlb.c~rollup mm/hugetlb.c
--- linux-2.6/mm/hugetlb.c~rollup	2004-04-18 14:30:20.000000000 +1000
+++ linux-2.6-npiggin/mm/hugetlb.c	2004-04-18 14:30:21.000000000 +1000
@@ -127,9 +127,12 @@ static void update_and_free_page(struct 
 	int i;
 	nr_huge_pages--;
 	for (i = 0; i < (HPAGE_SIZE / PAGE_SIZE); i++) {
-		page[i].flags &= ~(1 << PG_locked | 1 << PG_error | 1 << PG_referenced |
-				1 << PG_dirty | 1 << PG_active | 1 << PG_reserved |
-				1 << PG_private | 1<< PG_writeback);
+		page[i].flags &= ~(
+			1 << PG_locked		| 1 << PG_error		|
+			1 << PG_referenced	| 1 << PG_dirty		|
+			1 << PG_active_mapped	| 1 << PG_active_unmapped |
+			1 << PG_reserved	| 1 << PG_private	|
+			1 << PG_writeback);
 		set_page_count(&page[i], 0);
 	}
 	set_page_count(page, 1);
diff -puN mm/memory.c~rollup mm/memory.c
--- linux-2.6/mm/memory.c~rollup	2004-04-18 14:30:20.000000000 +1000
+++ linux-2.6-npiggin/mm/memory.c	2004-04-18 14:30:21.000000000 +1000
@@ -38,6 +38,7 @@
 
 #include <linux/kernel_stat.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/hugetlb.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
diff -puN mm/page_alloc.c~rollup mm/page_alloc.c
--- linux-2.6/mm/page_alloc.c~rollup	2004-04-18 14:30:20.000000000 +1000
+++ linux-2.6-npiggin/mm/page_alloc.c	2004-04-18 14:30:21.000000000 +1000
@@ -82,7 +82,7 @@ static void bad_page(const char *functio
 	page->flags &= ~(1 << PG_private	|
 			1 << PG_locked	|
 			1 << PG_lru	|
-			1 << PG_active	|
+			1 << PG_active_mapped	|
 			1 << PG_dirty	|
 			1 << PG_maplock |
 			1 << PG_anon    |
@@ -224,7 +224,8 @@ static inline void free_pages_check(cons
 			1 << PG_lru	|
 			1 << PG_private |
 			1 << PG_locked	|
-			1 << PG_active	|
+			1 << PG_active_mapped	|
+			1 << PG_active_unmapped	|
 			1 << PG_reclaim	|
 			1 << PG_slab	|
 			1 << PG_maplock |
@@ -334,7 +335,8 @@ static void prep_new_page(struct page *p
 			1 << PG_private	|
 			1 << PG_locked	|
 			1 << PG_lru	|
-			1 << PG_active	|
+			1 << PG_active_mapped	|
+			1 << PG_active_unmapped	|
 			1 << PG_dirty	|
 			1 << PG_reclaim	|
 			1 << PG_maplock |
@@ -859,7 +861,8 @@ unsigned int nr_used_zone_pages(void)
 	struct zone *zone;
 
 	for_each_zone(zone)
-		pages += zone->nr_active + zone->nr_inactive;
+		pages += zone->nr_active_mapped + zone->nr_active_unmapped
+			+ zone->nr_inactive;
 
 	return pages;
 }
@@ -996,7 +999,7 @@ void get_zone_counts(unsigned long *acti
 	*inactive = 0;
 	*free = 0;
 	for_each_zone(zone) {
-		*active += zone->nr_active;
+		*active += zone->nr_active_mapped + zone->nr_active_unmapped;
 		*inactive += zone->nr_inactive;
 		*free += zone->free_pages;
 	}
@@ -1114,7 +1117,7 @@ void show_free_areas(void)
 			K(zone->pages_min),
 			K(zone->pages_low),
 			K(zone->pages_high),
-			K(zone->nr_active),
+			K(zone->nr_active_mapped + zone->nr_active_unmapped),
 			K(zone->nr_inactive),
 			K(zone->present_pages)
 			);
@@ -1461,8 +1464,6 @@ static void __init free_area_init_core(s
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
 
-		zone->temp_priority = zone->prev_priority = DEF_PRIORITY;
-
 		/*
 		 * The per-cpu-pages pools are set to around 1000th of the
 		 * size of the zone.  But no more than 1/4 of a meg - there's
@@ -1496,11 +1497,14 @@ static void __init free_area_init_core(s
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
diff -puN mm/shmem.c~rollup mm/shmem.c
--- linux-2.6/mm/shmem.c~rollup	2004-04-18 14:30:20.000000000 +1000
+++ linux-2.6-npiggin/mm/shmem.c	2004-04-18 14:30:21.000000000 +1000
@@ -25,6 +25,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
+#include <linux/mm_inline.h>
 #include <linux/mman.h>
 #include <linux/file.h>
 #include <linux/swap.h>
diff -puN mm/swap.c~rollup mm/swap.c
--- linux-2.6/mm/swap.c~rollup	2004-04-18 14:30:20.000000000 +1000
+++ linux-2.6-npiggin/mm/swap.c	2004-04-18 14:30:21.000000000 +1000
@@ -79,14 +79,18 @@ int rotate_reclaimable_page(struct page 
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
@@ -97,42 +101,6 @@ int rotate_reclaimable_page(struct page 
 	return 0;
 }
 
-/*
- * FIXME: speed this up?
- */
-void fastcall activate_page(struct page *page)
-{
-	struct zone *zone = page_zone(page);
-
-	spin_lock_irq(&zone->lru_lock);
-	if (PageLRU(page) && !PageActive(page)) {
-		del_page_from_inactive_list(zone, page);
-		SetPageActive(page);
-		add_page_to_active_list(zone, page);
-		inc_page_state(pgactivate);
-	}
-	spin_unlock_irq(&zone->lru_lock);
-}
-
-/*
- * Mark a page as having seen activity.
- *
- * inactive,unreferenced	->	inactive,referenced
- * inactive,referenced		->	active,unreferenced
- * active,unreferenced		->	active,referenced
- */
-void fastcall mark_page_accessed(struct page *page)
-{
-	if (!PageActive(page) && PageReferenced(page) && PageLRU(page)) {
-		activate_page(page);
-		ClearPageReferenced(page);
-	} else if (!PageReferenced(page)) {
-		SetPageReferenced(page);
-	}
-}
-
-EXPORT_SYMBOL(mark_page_accessed);
-
 /**
  * lru_cache_add: add a page to the page lists
  * @page: the page to add
@@ -331,9 +299,13 @@ void __pagevec_lru_add_active(struct pag
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
--- linux-2.6/mm/vmscan.c~rollup	2004-04-18 14:30:21.000000000 +1000
+++ linux-2.6-npiggin/mm/vmscan.c	2004-04-18 14:30:21.000000000 +1000
@@ -40,10 +40,9 @@
 #include <linux/swapops.h>
 
 /*
- * From 0 .. 100.  Higher means more swappy.
+ * From 1 .. 100.  Higher means less swappy.
  */
-int vm_swappiness = 60;
-static long total_memory;
+int vm_mapped_page_cost = 8;
 
 #define lru_to_page(_head) (list_entry((_head)->prev, struct page, lru))
 
@@ -264,11 +263,11 @@ shrink_list(struct list_head *page_list,
 		if (TestSetPageLocked(page))
 			goto keep;
 
-		/* Double the slab pressure for mapped and swapcache pages */
-		if (page_mapped(page) || PageSwapCache(page))
-			(*nr_scanned)++;
+		/* Increase the slab pressure for mapped pages */
+		if (page_mapped(page))
+			(*nr_scanned) += vm_mapped_page_cost;
 
-		BUG_ON(PageActive(page));
+		BUG_ON(PageActiveMapped(page) || PageActiveUnmapped(page));
 
 		if (PageWriteback(page))
 			goto keep_locked;
@@ -444,7 +443,10 @@ free_it:
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
@@ -540,8 +542,10 @@ shrink_cache(struct zone *zone, unsigned
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
@@ -574,36 +578,32 @@ done:
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
-		page = lru_to_page(&zone->active_list);
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
@@ -611,61 +611,21 @@ refill_inactive_zone(struct zone *zone, 
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
+		int referenced;
 		page = lru_to_page(&l_hold);
 		list_del(&page->lru);
-		if (page_mapped(page)) {
-			if (!reclaim_mapped) {
-				list_add(&page->lru, &l_active);
-				continue;
-			}
-			rmap_lock(page);
-			if (page_referenced(page)) {
-				rmap_unlock(page);
-				list_add(&page->lru, &l_active);
-				continue;
-			}
-			rmap_unlock(page);
-		}
+		rmap_lock(page);
+		referenced = page_referenced(page);
+		rmap_unlock(page);
 		/*
 		 * FIXME: need to consider page_count(page) here if/when we
 		 * reap orphaned pages via the LRU (Daniel's locking stuff)
 		 */
-		if (total_swap_pages == 0 && PageAnon(page)) {
+		if (referenced || (total_swap_pages == 0 && PageAnon(page))) {
 			list_add(&page->lru, &l_active);
 			continue;
 		}
@@ -680,7 +640,8 @@ refill_inactive_zone(struct zone *zone, 
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
 		if (TestSetPageLRU(page))
 			BUG();
-		if (!TestClearPageActive(page))
+		if (!TestClearPageActiveMapped(page)
+				&& !TestClearPageActiveUnmapped(page))
 			BUG();
 		list_move(&page->lru, &zone->inactive_list);
 		pgmoved++;
@@ -704,27 +665,41 @@ refill_inactive_zone(struct zone *zone, 
 	}
 
 	pgmoved = 0;
+	pgmoved_unmapped = 0;
 	while (!list_empty(&l_active)) {
 		page = lru_to_page(&l_active);
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
 
@@ -737,6 +712,8 @@ shrink_zone(struct zone *zone, int max_s
 		int *total_scanned, struct page_state *ps, int do_writepage)
 {
 	unsigned long ratio;
+	unsigned long long mapped_ratio;
+	unsigned long nr_active;
 	int count;
 
 	/*
@@ -749,14 +726,27 @@ shrink_zone(struct zone *zone, int max_s
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
@@ -796,9 +786,6 @@ shrink_caches(struct zone **zones, int p
 		struct zone *zone = zones[i];
 		int max_scan;
 
-		if (zone->free_pages < zone->pages_high)
-			zone->temp_priority = priority;
-
 		if (zone->all_unreclaimable && priority != DEF_PRIORITY)
 			continue;	/* Let kswapd poll it */
 
@@ -833,15 +820,11 @@ int try_to_free_pages(struct zone **zone
 	int ret = 0;
 	int nr_reclaimed = 0;
 	struct reclaim_state *reclaim_state = current->reclaim_state;
-	int i;
 	unsigned long total_scanned = 0;
 	int do_writepage = 0;
 
 	inc_page_state(allocstall);
 
-	for (i = 0; zones[i] != 0; i++)
-		zones[i]->temp_priority = DEF_PRIORITY;
-
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
 		int scanned = 0;
 		struct page_state ps;
@@ -880,8 +863,6 @@ int try_to_free_pages(struct zone **zone
 	if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY))
 		out_of_memory();
 out:
-	for (i = 0; zones[i] != 0; i++)
-		zones[i]->prev_priority = zones[i]->temp_priority;
 	return ret;
 }
 
@@ -922,12 +903,6 @@ static int balance_pgdat(pg_data_t *pgda
 
 	inc_page_state(pageoutrun);
 
-	for (i = 0; i < pgdat->nr_zones; i++) {
-		struct zone *zone = pgdat->node_zones + i;
-
-		zone->temp_priority = DEF_PRIORITY;
-	}
-
 	for (priority = DEF_PRIORITY; priority; priority--) {
 		int all_zones_ok = 1;
 		int end_zone = 0;	/* Inclusive.  0 = ZONE_DMA */
@@ -977,7 +952,6 @@ scan:
 				if (zone->free_pages <= zone->pages_high)
 					all_zones_ok = 0;
 			}
-			zone->temp_priority = priority;
 			max_scan = zone->nr_inactive >> priority;
 			reclaimed = shrink_zone(zone, max_scan, GFP_KERNEL,
 					&scanned, ps, do_writepage);
@@ -1012,11 +986,6 @@ scan:
 			blk_congestion_wait(WRITE, HZ/10);
 	}
 out:
-	for (i = 0; i < pgdat->nr_zones; i++) {
-		struct zone *zone = pgdat->node_zones + i;
-
-		zone->prev_priority = zone->temp_priority;
-	}
 	return total_reclaimed;
 }
 
@@ -1150,7 +1119,6 @@ static int __init kswapd_init(void)
 	for_each_pgdat(pgdat)
 		pgdat->kswapd
 		= find_task_by_pid(kernel_thread(kswapd, pgdat, CLONE_KERNEL));
-	total_memory = nr_free_pagecache_pages();
 	hotcpu_notifier(cpu_callback, 0);
 	return 0;
 }

_

--------------090306040603040809030804--
