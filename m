Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264313AbUAHLj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 06:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbUAHLj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 06:39:29 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:16302 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S264313AbUAHLjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 06:39:17 -0500
Date: Thu, 08 Jan 2004 20:37:34 +0900 (JST)
Message-Id: <20040108.203734.122074391.taka@valinux.co.jp>
To: lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Cc: iwamoto@valinux.co.jp
Subject: [PATCH] dynamic allocation of huge continuous pages
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <20040108073634.8A9947007A@sv1.valinux.co.jp>
References: <20040108073634.8A9947007A@sv1.valinux.co.jp>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just implemented a patch which allow us to allocate huge
continuous pages easily. As We know it's very hard to allocate
them on demand, since free memory on system may be fragmented.
My approach is that I let annoying pages move to another place
so that we can make free coninuous space on memory. Iwamoto's
memory-hot-removal patch will help to do it.

I believe moving pages approach will be much better than random swaping
page out approach for this purpose.

iwamoto> This is an update of the memory hot removal patch.
	      :
iwamoto> http://people.valinux.co.jp/~iwamoto/mh.html 

My patch needs the iwamoto's memory-hot-removeval patch.
You should apply both of them against linux-2.6.0.

Known problems:
      - This patch doesn't work if CONFIG_HUGETLB_PAGE isn't set.
        Does anybody have good idea to solve it, 
	since it's difficult to know whether a specified page
	is free or a part of a large continuous page without
	PG_compound flag.

ToDos:
      - It's hard to allocate HugePages for hugetlbfs on a box
        which dosen't have HighMem zones yet.
      - We will make some continuous pages allocation work
	at the same time.

Thank you,
Hirokazu Takahashi.


--- include/linux/page-flags.h.ORG	Thu Jan  8 19:06:48 2032
+++ include/linux/page-flags.h	Thu Jan  8 19:08:42 2032
@@ -77,6 +77,7 @@
 #define PG_compound		19	/* Part of a compound page */
 
 #define	PG_again		20
+#define PG_booked		21
 
 
 /*
@@ -274,6 +275,10 @@ extern void get_full_page_state(struct p
 #define PageAgain(page)	test_bit(PG_again, &(page)->flags)
 #define SetPageAgain(page)	set_bit(PG_again, &(page)->flags)
 #define ClearPageAgain(page)	clear_bit(PG_again, &(page)->flags)
+
+#define PageBooked(page)	test_bit(PG_booked, &(page)->flags)
+#define SetPageBooked(page)	set_bit(PG_booked, &(page)->flags)
+#define ClearPageBooked(page)	clear_bit(PG_booked, &(page)->flags)
 
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
--- include/linux/mmzone.h.ORG	Thu Jan  8 19:06:56 2032
+++ include/linux/mmzone.h	Thu Jan  8 19:12:07 2032
@@ -154,6 +154,9 @@ struct zone {
 	char			*name;
 	unsigned long		spanned_pages;	/* total size, including holes */
 	unsigned long		present_pages;	/* amount of memory (excluding holes) */
+	unsigned long		contig_pages_alloc_hint;
+	unsigned long		booked_pages;
+	long			scan_pages;
 } ____cacheline_maxaligned_in_smp;
 
 #define ZONE_DMA		0
--- mm/page_alloc.c.ORG	Thu Jan  8 19:07:27 2032
+++ mm/page_alloc.c	Thu Jan  8 19:51:24 2032
@@ -185,7 +185,11 @@ static inline void __free_pages_bulk (st
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
 
@@ -204,6 +208,9 @@ static inline void __free_pages_bulk (st
 		buddy2 = base + page_idx;
 		BUG_ON(bad_range(zone, buddy1));
 		BUG_ON(bad_range(zone, buddy2));
+		if (PageBooked(buddy1) != PageBooked(buddy2)) {
+			break;
+		}
 		list_del(&buddy1->list);
 		mask <<= 1;
 		area++;
@@ -352,13 +359,20 @@ static struct page *__rmqueue(struct zon
 	unsigned int current_order;
 	struct page *page;
 	unsigned int index;
+	struct list_head *p;
 
 	for (current_order = order; current_order < MAX_ORDER; ++current_order) {
 		area = zone->free_area + current_order;
 		if (list_empty(&area->free_list))
 			continue;
+		list_for_each(p, &area->free_list) {
+			page = list_entry(p, struct page, list);
+			if (!PageBooked(page))
+				goto gotit;
+		}
+		continue;
 
-		page = list_entry(area->free_list.next, struct page, list);
+gotit:
 		list_del(&page->list);
 		index = page - zone->zone_mem_map;
 		if (current_order != MAX_ORDER-1)
@@ -456,6 +470,11 @@ static void free_hot_cold_page(struct pa
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
@@ -542,6 +561,242 @@ zone_activep(const struct zone *z)
 }
 #endif
 
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_MEMHOTPLUGTEST)
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
+extern int remap_onepage(struct page *);
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
+		if (remap_onepage(p)) {
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
@@ -602,8 +857,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 			local_low >>= 1;
 		min += local_low;
 
-		if (z->free_pages >= min ||
-				(!wait && z->free_pages >= z->pages_high)) {
+		if (enough_pages(z, min, wait)) {
 			page = buffered_rmqueue(z, order, cold);
 			if (page)
 		       		goto got_pg;
@@ -631,8 +885,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 		if (rt_task(p))
 			local_min >>= 1;
 		min += local_min;
-		if (z->free_pages >= min ||
-				(!wait && z->free_pages >= z->pages_high)) {
+		if (enough_pages(z, min, wait)) {
 			page = buffered_rmqueue(z, order, cold);
 			if (page)
 				goto got_pg;
@@ -682,14 +935,27 @@ rebalance:
 			continue;
 #endif
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
+#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_MEMHOTPLUGTEST)
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
--- mm/vmscan.c.ORG	Thu Jan  8 19:07:40 2032
+++ mm/vmscan.c	Thu Jan  8 19:08:42 2032
@@ -1183,7 +1183,7 @@ bufferdone:
 	}
 	/* don't __put_page(page) here. truncate may be in progress */
 	newpage->flags |= page->flags & ~(1 << PG_uptodate) &
-	    ~(1 << PG_highmem) & ~(1 << PG_chainlock) &
+	    ~(1 << PG_highmem) & ~(1 << PG_chainlock) & ~(1 << PG_booked) &
 	    ~(1 << PG_direct) & ~(~0UL << ZONE_SHIFT);
 
 	/* list_del(&page->list); XXX */
