Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbUDFMo2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 08:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUDFMo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 08:44:28 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:6827 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S263792AbUDFMoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 08:44:00 -0400
Date: Tue, 06 Apr 2004 21:44:11 +0900 (JST)
Message-Id: <20040406.214411.127967444.taka@valinux.co.jp>
To: linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: [patch 1/6] memory hotplug for hugetlbpages
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040406.214123.129013798.taka@valinux.co.jp>
References: <20040406105353.9BDE8705DE@sv1.valinux.co.jp>
	<20040406.214123.129013798.taka@valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 1 of memory hotplug patches for hugetlbpages.

$Id: va-hugepagealloc.patch,v 1.4 2004/04/01 14:10:46 taka Exp $

--- linux-2.6.4.ORG/include/linux/page-flags.h	Thu Apr  1 14:24:07 2032
+++ linux-2.6.4/include/linux/page-flags.h	Thu Apr  1 15:32:16 2032
@@ -77,6 +77,7 @@
 #define PG_compound		19	/* Part of a compound page */
 
 #define PG_again		20
+#define PG_booked		21
 
 
 /*
@@ -275,6 +276,10 @@ extern void get_full_page_state(struct p
 #define PageAgain(page)	test_bit(PG_again, &(page)->flags)
 #define SetPageAgain(page)	set_bit(PG_again, &(page)->flags)
 #define ClearPageAgain(page)	clear_bit(PG_again, &(page)->flags)
+
+#define PageBooked(page)	test_bit(PG_booked, &(page)->flags)
+#define SetPageBooked(page)	set_bit(PG_booked, &(page)->flags)
+#define ClearPageBooked(page)	clear_bit(PG_booked, &(page)->flags)
 
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
--- linux-2.6.4.ORG/include/linux/mmzone.h	Thu Apr  1 14:24:07 2032
+++ linux-2.6.4/include/linux/mmzone.h	Thu Apr  1 15:32:16 2032
@@ -154,6 +154,9 @@ struct zone {
 	char			*name;
 	unsigned long		spanned_pages;	/* total size, including holes */
 	unsigned long		present_pages;	/* amount of memory (excluding holes) */
+	unsigned long		contig_pages_alloc_hint;
+	unsigned long		booked_pages;
+	long			scan_pages;
 } ____cacheline_maxaligned_in_smp;
 
 #define ZONE_DMA		0
--- linux-2.6.4.ORG/mm/page_alloc.c	Thu Apr  1 14:24:25 2032
+++ linux-2.6.4/mm/page_alloc.c	Thu Apr  1 15:32:16 2032
@@ -182,7 +182,11 @@ static inline void __free_pages_bulk (st
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
 
@@ -201,6 +205,9 @@ static inline void __free_pages_bulk (st
 		buddy2 = base + page_idx;
 		BUG_ON(bad_range(zone, buddy1));
 		BUG_ON(bad_range(zone, buddy2));
+		if (PageBooked(buddy1) != PageBooked(buddy2)) {
+			break;
+		}
 		list_del(&buddy1->list);
 		mask <<= 1;
 		area++;
@@ -356,8 +363,13 @@ static struct page *__rmqueue(struct zon
 		area = zone->free_area + current_order;
 		if (list_empty(&area->free_list))
 			continue;
+		list_for_each_entry(page, &area->free_list, list) {
+			if (!PageBooked(page))
+				goto gotit;
+		}
+		continue;
 
-		page = list_entry(area->free_list.next, struct page, list);
+gotit:
 		list_del(&page->list);
 		index = page - zone->zone_mem_map;
 		if (current_order != MAX_ORDER-1)
@@ -463,6 +475,11 @@ static void fastcall free_hot_cold_page(
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
@@ -530,6 +547,241 @@ static struct page *buffered_rmqueue(str
 	return page;
 }
 
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_MEMHOTPLUG)
+/* 
+ * Check wheter the page is freeable or not.
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
+/*
+ * sweepout_pages() might not work well as the booked pages 
+ * may include some unfreeable pages.
+ */
+static int
+sweepout_pages(struct zone *zone, struct page *page, int num)
+{
+	struct page *p;
+	int failed = 0;
+	int retry = 0;
+	int retry_save = 0;
+	int retry_count = 20;
+
+again:
+	on_each_cpu((void (*)(void*))drain_local_pages, NULL, 1, 1);
+	for (p = page; p <= &page[num - 1]; p++) {
+		if (!page_count(p))
+			continue;
+		if (!PageBooked(p)) {
+			printk(KERN_ERR "ERROR sweepout_pages: page:%p isn't booked. page(%p) num(%d)\n", p, page, num);
+		}
+
+		spin_lock_irq(&zone->lru_lock);
+		if (!PageLRU(p)) {
+			spin_unlock_irq(&zone->lru_lock);
+			retry++;
+			continue;
+		}
+		list_del(&p->lru);
+		if (!TestClearPageLRU(p))
+			BUG();
+		if (PageActive(p)) {
+			zone->nr_active--;
+			if (page_count(p) == 0) {
+				/* the page is in pagevec_release();
+				   shrink_cache says so. */
+				SetPageLRU(p);
+				list_add(&p->lru, &zone->active_list);
+				spin_unlock_irq(&zone->lru_lock);
+				continue;
+			}
+		} else {
+			zone->nr_inactive--;
+			if (page_count(p) == 0) {
+				/* the page is in pagevec_release();
+				   shrink_cache says so. */
+				SetPageLRU(p);
+				list_add(&p->lru, &zone->inactive_list);
+				spin_unlock_irq(&zone->lru_lock);
+				continue;
+			}
+		}
+		page_cache_get(p);
+		spin_unlock_irq(&zone->lru_lock);
+		if (remap_onepage_normal(p, REMAP_ANYNODE, 0)) {
+			failed++;
+			spin_lock_irq(&zone->lru_lock);
+			if (PageActive(p)) {
+				list_add(&p->lru, &zone->active_list);
+				zone->nr_active++;
+			} else {
+				list_add(&p->lru, &zone->inactive_list);
+				zone->nr_inactive++;
+			}
+			SetPageLRU(p);
+			spin_unlock_irq(&zone->lru_lock);
+			page_cache_release(p);
+		}
+	}
+	if (retry && (retry_count--)) {
+		retry_save = retry;
+		retry = 0;
+		schedule_timeout(HZ/4);
+		/* Actually we should wait on the pages */
+		goto again;
+	}
+	on_each_cpu((void (*)(void*))drain_local_pages, NULL, 1, 1);
+	return failed;
+}
+
+/*
+ * Allocate contiguous pages enen if pages are fragmented in zones.
+ * Migrating pages helps to make enough space in them.
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
+	if (down_trylock(&bookedpage_sem)) {
+		down(&bookedpage_sem);
+	}
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
@@ -585,8 +837,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 			local_low >>= 1;
 		min += local_low;
 
-		if (z->free_pages >= min ||
-				(!wait && z->free_pages >= z->pages_high)) {
+		if (enough_pages(z, min, wait)) {
 			page = buffered_rmqueue(z, order, cold);
 			if (page)
 		       		goto got_pg;
@@ -610,8 +861,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 		if (rt_task(p))
 			local_min >>= 1;
 		min += local_min;
-		if (z->free_pages >= min ||
-				(!wait && z->free_pages >= z->pages_high)) {
+		if (enough_pages(z, min, wait)) {
 			page = buffered_rmqueue(z, order, cold);
 			if (page)
 				goto got_pg;
@@ -653,14 +903,27 @@ rebalance:
 		struct zone *z = zones[i];
 
 		min += z->pages_min;
-		if (z->free_pages >= min ||
-				(!wait && z->free_pages >= z->pages_high)) {
+		if (enough_pages(z, min, wait)) {
 			page = buffered_rmqueue(z, order, cold);
 			if (page)
 				goto got_pg;
 		}
 		min += z->pages_low * sysctl_lower_zone_protection;
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
--- linux-2.6.4.ORG/mm/memhotplug.c	Thu Apr  1 14:24:07 2032
+++ linux-2.6.4/mm/memhotplug.c	Thu Apr  1 15:32:16 2032
@@ -180,7 +180,7 @@ radix_tree_replace_pages(struct page *pa
 	}
 	/* don't __put_page(page) here. truncate may be in progress */
 	newpage->flags |= page->flags & ~(1 << PG_uptodate) &
-	    ~(1 << PG_highmem) & ~(1 << PG_chainlock) &
+	    ~(1 << PG_highmem) & ~(1 << PG_chainlock) & ~(1 << PG_booked) &
 	    ~(1 << PG_direct) & ~(~0UL << NODEZONE_SHIFT);
 
 	/* list_del(&page->list); XXX */
