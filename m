Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267413AbUGNOM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267413AbUGNOM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267414AbUGNOMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:12:45 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:8380 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S267413AbUGNOFK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:05:10 -0400
Date: Wed, 14 Jul 2004 23:04:54 +0900 (JST)
Message-Id: <20040714.230454.127669883.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Cc: linux-mm@kvack.org
Subject: [PATCH] memory hotremoval for linux-2.6.7 [8/16]
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040714.224138.95803956.taka@valinux.co.jp>
References: <20040714.224138.95803956.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.6.7.ORG/include/linux/page-flags.h	Sun Jul 11 10:45:27 2032
+++ linux-2.6.7/include/linux/page-flags.h	Sun Jul 11 10:51:49 2032
@@ -79,6 +79,7 @@
 #define PG_anon			20	/* Anonymous: anon_vma in mapping */
 
 #define PG_again		21
+#define PG_booked		22
 
 
 /*
@@ -303,6 +304,10 @@ extern unsigned long __read_page_state(u
 #define PageAgain(page)	test_bit(PG_again, &(page)->flags)
 #define SetPageAgain(page)	set_bit(PG_again, &(page)->flags)
 #define ClearPageAgain(page)	clear_bit(PG_again, &(page)->flags)
+
+#define PageBooked(page)	test_bit(PG_booked, &(page)->flags)
+#define SetPageBooked(page)	set_bit(PG_booked, &(page)->flags)
+#define ClearPageBooked(page)	clear_bit(PG_booked, &(page)->flags)
 
 #define PageAnon(page)		test_bit(PG_anon, &(page)->flags)
 #define SetPageAnon(page)	set_bit(PG_anon, &(page)->flags)
--- linux-2.6.7.ORG/include/linux/mmzone.h	Sun Jul 11 10:45:27 2032
+++ linux-2.6.7/include/linux/mmzone.h	Sun Jul 11 10:51:49 2032
@@ -187,6 +187,9 @@ struct zone {
 	char			*name;
 	unsigned long		spanned_pages;	/* total size, including holes */
 	unsigned long		present_pages;	/* amount of memory (excluding holes) */
+	unsigned long		contig_pages_alloc_hint;
+	unsigned long		booked_pages;
+	long			scan_pages;
 } ____cacheline_maxaligned_in_smp;
 
 
--- linux-2.6.7.ORG/mm/page_alloc.c	Sun Jul 11 10:49:53 2032
+++ linux-2.6.7/mm/page_alloc.c	Sun Jul 11 10:53:04 2032
@@ -12,6 +12,7 @@
  *  Zone balancing, Kanoj Sarcar, SGI, Jan 2000
  *  Per cpu hot/cold page lists, bulk allocation, Martin J. Bligh, Sept 2002
  *          (lots of bits borrowed from Ingo Molnar & Andrew Morton)
+ *  Dynamic compound page allocation, Hirokazu Takahashi, Jul 2004
  */
 
 #include <linux/config.h>
@@ -25,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/suspend.h>
 #include <linux/pagevec.h>
+#include <linux/mm_inline.h>
 #include <linux/memhotplug.h>
 #include <linux/blkdev.h>
 #include <linux/slab.h>
@@ -190,7 +192,11 @@ static inline void __free_pages_bulk (st
 		BUG();
 	index = page_idx >> (1 + order);
 
-	zone->free_pages -= mask;
+	if (!PageBooked(page))
+		zone->free_pages -= mask;
+	else {
+		zone->booked_pages -= mask;
+	}
 	while (mask + (1 << (MAX_ORDER-1))) {
 		struct page *buddy1, *buddy2;
 
@@ -209,6 +215,9 @@ static inline void __free_pages_bulk (st
 		buddy2 = base + page_idx;
 		BUG_ON(bad_range(zone, buddy1));
 		BUG_ON(bad_range(zone, buddy2));
+		if (PageBooked(buddy1) != PageBooked(buddy2)) {
+			break;
+		}
 		list_del(&buddy1->lru);
 		mask <<= 1;
 		area++;
@@ -371,7 +380,12 @@ static struct page *__rmqueue(struct zon
 		if (list_empty(&area->free_list))
 			continue;
 
-		page = list_entry(area->free_list.next, struct page, lru);
+		list_for_each_entry(page, &area->free_list, lru) {
+			if (!PageBooked(page))
+				goto gotit;
+		}
+		continue;
+gotit:
 		list_del(&page->lru);
 		index = page - zone->zone_mem_map;
 		if (current_order != MAX_ORDER-1)
@@ -503,6 +517,11 @@ static void fastcall free_hot_cold_page(
 	struct per_cpu_pages *pcp;
 	unsigned long flags;
 
+	if (PageBooked(page)) {
+		__free_pages_ok(page, 0);
+		return;
+	}
+
 	kernel_map_pages(page, 1, 0);
 	inc_page_state(pgfree);
 	free_pages_check(__FUNCTION__, page);
@@ -572,6 +591,225 @@ buffered_rmqueue(struct zone *zone, int 
 	return page;
 }
 
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_MEMHOTPLUG)
+/* 
+ * Check whether the page is freeable or not.
+ * It might not be free even if this function says OK,
+ * when it is just being allocated.
+ * This check is almost sufficient but not perfect.
+ */
+static inline int is_page_freeable(struct page *page)
+{
+	return (page->mapping || page_mapped(page) || !page_count(page)) &&
+	    !(page->flags & (1<<PG_reserved|1<<PG_compound|1<<PG_booked|1<<PG_slab));
+}
+
+static inline int is_free_page(struct page *page)
+{
+	return !(page_mapped(page) ||
+		page->mapping != NULL ||
+		page_count(page) != 0 ||
+		(page->flags & (
+			1 << PG_reserved|
+			1 << PG_compound|
+			1 << PG_booked	|
+			1 << PG_lru	|
+			1 << PG_private |
+			1 << PG_locked	|
+			1 << PG_active	|
+			1 << PG_reclaim	|
+			1 << PG_dirty	|
+			1 << PG_slab	|
+			1 << PG_writeback )));
+}
+
+static int
+try_to_book_pages(struct zone *zone, struct page *page, unsigned int order)
+{
+	struct page	*p;
+	int booked_count = 0;
+	unsigned long	flags;
+
+	spin_lock_irqsave(&zone->lock, flags);
+
+	for (p = page; p < &page[1<<order]; p++) {
+		if (!is_page_freeable(p))
+			goto out;
+		if (is_free_page(p))
+			booked_count++;
+		SetPageBooked(p);
+	}
+
+	zone->booked_pages = booked_count;
+	zone->free_pages -= booked_count;
+
+	spin_unlock_irqrestore(&zone->lock, flags);
+	return 1;
+out:
+	for (p--; p >= page; p--) {
+		ClearPageBooked(p);
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+	return 0;
+}
+
+/*
+ * Mark PG_booked on all pages in a specified section to reserve 
+ * for future use. These won't be reused until PG_booked is cleared.
+ */
+static struct page *
+book_pages(struct zone *zone, unsigned int gfp_mask, unsigned int order)
+{
+	unsigned long	num = 1<<order;
+	unsigned long	slot = zone->contig_pages_alloc_hint;
+	struct page	*page;
+	
+	slot = (slot + num - 1) & ~(num - 1);	/* align */
+
+	for ( ; zone->scan_pages > 0; slot += num) {
+		zone->scan_pages -= num;
+		if (slot + num > zone->present_pages)
+			slot = 0;
+		page = &zone->zone_mem_map[slot];
+		if (try_to_book_pages(zone, page, order)) {
+			zone->contig_pages_alloc_hint = slot + num;
+			return page;
+		}
+	}
+	return NULL;
+}
+
+static void
+unbook_pages(struct zone *zone, struct page *page, unsigned int order)
+{
+	struct page	*p;
+	for (p = page; p < &page[1<<order]; p++) {
+		ClearPageBooked(p);
+	}
+}
+
+struct sweepctl {
+	struct page *start;
+	struct page *end;
+	int rest;
+};
+
+/*
+ * Choose a page among the booked pages.
+ *
+ */
+static struct page*
+get_booked_page(struct zone *zone, void *arg)
+{
+	struct sweepctl *ctl = (struct sweepctl *)arg;
+	struct page *page = ctl->start;
+	struct page *end = ctl->end;
+
+	for (; page <= end; page++) {
+		if (!page_count(page) && !PageLRU(page))
+			continue;
+		if (!PageBooked(page)) {
+			printk(KERN_ERR "ERROR sweepout_pages: page:%p isn't booked.\n", page);
+		}
+		if (!PageLRU(page) || steal_page_from_lru(zone, page) == NULL) {
+			ctl->rest++;
+			continue;
+		}
+		ctl->start = page + 1;
+		return page;
+	}
+	ctl->start = end + 1;
+	return NULL;
+}
+
+/*
+ * sweepout_pages() might not work well as the booked pages 
+ * might include some unfreeable pages.
+ */
+static int
+sweepout_pages(struct zone *zone, struct page *page, int num)
+{
+	struct sweepctl ctl;
+	int failed = 0;
+	int retry = 0;
+again:
+	on_each_cpu((void (*)(void*))drain_local_pages, NULL, 1, 1);
+	ctl.start = page;
+	ctl.end = &page[num - 1];
+	ctl.rest = 0;
+	failed = try_to_migrate_pages(zone, MIGRATE_ANYNODE, get_booked_page, &ctl);
+
+	if (retry != failed || ctl.rest) {
+		retry = failed;
+		schedule_timeout(HZ/4);
+		/* Actually we should wait on the pages */
+		goto again;
+	}
+
+	on_each_cpu((void (*)(void*))drain_local_pages, NULL, 1, 1);
+	return failed;
+}
+
+/*
+ * Allocate contiguous pages even if pages are fragmented in zones.
+ * Page Migration mechanism helps to make enough space in them.
+ */
+static struct page *
+force_alloc_pages(unsigned int gfp_mask, unsigned int order,
+			struct zonelist *zonelist)
+{
+	struct zone **zones = zonelist->zones;
+	struct zone *zone;
+	struct page *page = NULL;
+	unsigned long flags;
+	int i;
+	int ret;
+
+	static DECLARE_MUTEX(bookedpage_sem);
+
+	down(&bookedpage_sem);
+
+	for (i = 0; zones[i] != NULL; i++) {
+		zone = zones[i];
+		zone->scan_pages = zone->present_pages;
+		while (zone->scan_pages > 0) {
+			page = book_pages(zone, gfp_mask, order);
+			if (!page)
+				break;
+			ret = sweepout_pages(zone, page, 1<<order);
+			if (ret) {
+				spin_lock_irqsave(&zone->lock, flags);
+				unbook_pages(zone, page, order);
+				page = NULL;
+
+				zone->free_pages += zone->booked_pages;
+				spin_unlock_irqrestore(&zone->lock, flags);
+				continue;
+			}
+			spin_lock_irqsave(&zone->lock, flags);
+			unbook_pages(zone, page, order);
+			zone->free_pages += zone->booked_pages;
+			page = __rmqueue(zone, order);
+			spin_unlock_irqrestore(&zone->lock, flags);
+			if (page) {
+				prep_compound_page(page, order);
+				up(&bookedpage_sem);
+				return page;
+			}
+		}
+	}
+	up(&bookedpage_sem);
+	return NULL;
+}
+#endif /* CONFIG_HUGETLB_PAGE */
+
+static inline int
+enough_pages(struct zone *zone, unsigned long min, const int wait)
+{
+	return (long)zone->free_pages - (long)min >= 0 ||
+		(!wait && (long)zone->free_pages - (long)zone->pages_high >= 0);
+}
+
 /*
  * This is the 'heart' of the zoned buddy allocator.
  *
@@ -623,8 +861,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 		if (rt_task(p))
 			min -= z->pages_low >> 1;
 
-		if (z->free_pages >= min ||
-				(!wait && z->free_pages >= z->pages_high)) {
+		if (enough_pages(z, min, wait)) {
 			page = buffered_rmqueue(z, order, gfp_mask);
 			if (page) {
 				zone_statistics(zonelist, z);
@@ -648,8 +885,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 		if (rt_task(p))
 			min -= z->pages_low >> 1;
 
-		if (z->free_pages >= min ||
-				(!wait && z->free_pages >= z->pages_high)) {
+		if (enough_pages(z, min, wait)) {
 			page = buffered_rmqueue(z, order, gfp_mask);
 			if (page) {
 				zone_statistics(zonelist, z);
@@ -694,8 +930,7 @@ rebalance:
 
 		min = (1UL << order) + z->protection[alloc_type];
 
-		if (z->free_pages >= min ||
-				(!wait && z->free_pages >= z->pages_high)) {
+		if (enough_pages(z, min, wait)) {
 			page = buffered_rmqueue(z, order, gfp_mask);
 			if (page) {
  				zone_statistics(zonelist, z);
@@ -703,6 +938,20 @@ rebalance:
 			}
 		}
 	}
+
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_MEMHOTPLUG)
+	/*
+	 * Defrag pages to allocate large contiguous pages
+	 *
+	 * FIXME: The following code will work only if CONFIG_HUGETLB_PAGE
+	 *        flag is on.
+	 */
+	if (order) {
+		page = force_alloc_pages(gfp_mask, order, zonelist);
+		if (page)
+			goto got_pg;
+	}
+#endif /* CONFIG_HUGETLB_PAGE */
 
 	/*
 	 * Don't let big-order allocations loop unless the caller explicitly
--- linux-2.6.7.ORG/mm/memhotplug.c	Sun Jul 11 10:45:27 2032
+++ linux-2.6.7/mm/memhotplug.c	Sun Jul 11 10:51:49 2032
@@ -240,7 +240,7 @@ radix_tree_replace_pages(struct page *pa
 	}
 	/* Don't __put_page(page) here.  Truncate may be in progress. */
 	newpage->flags |= page->flags & ~(1 << PG_uptodate) &
-	    ~(1 << PG_highmem) & ~(1 << PG_anon) &
+	    ~(1 << PG_highmem) & ~(1 << PG_anon) & ~(1 << PG_booked) &
 	    ~(1 << PG_maplock) &
 	    ~(1 << PG_active) & ~(~0UL << NODEZONE_SHIFT);
 
