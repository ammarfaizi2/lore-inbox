Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318259AbSHKHdv>; Sun, 11 Aug 2002 03:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318155AbSHKHbf>; Sun, 11 Aug 2002 03:31:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43782 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318035AbSHKH0b>;
	Sun, 11 Aug 2002 03:26:31 -0400
Message-ID: <3D5614D8.A36B326B@zip.com.au>
Date: Sun, 11 Aug 2002 00:40:08 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 18/21] per-zone LRU locking
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Now the LRUs are per-zone, make their lock per-zone as well.

In this patch the per-zone lock shares a cacheline with the zone's
buddy list lock, which is very bad.  Some groundwork is needed to fix
this well.

This change is expected to be a significant win on NUMA, where most
page allocation comes from the local node's zones.

For NUMA the `struct zone' itself should really be placed in that
node's memory, which is something the platform owners should look at. 
However the internode cache will help here.

Per-node kswapd would make heaps of sense too.




 include/linux/mm.h         |    2 
 include/linux/mmzone.h     |    1 
 include/linux/page-flags.h |    2 
 include/linux/swap.h       |    2 
 mm/filemap.c               |    3 -
 mm/memory.c                |    2 
 mm/page_alloc.c            |    3 -
 mm/rmap.c                  |    6 +-
 mm/swap.c                  |   99 +++++++++++++++++++++++++--------------------
 mm/vmscan.c                |   38 ++++++++---------
 10 files changed, 86 insertions(+), 72 deletions(-)

--- 2.5.31/mm/filemap.c~per-zone-lock	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/mm/filemap.c	Sun Aug 11 00:20:57 2002
@@ -59,7 +59,7 @@
  *        ->swap_device_lock		(exclusive_swap_page, others)
  *	    ->rmap_lock			(to/from swapcache)
  *            ->mapping->page_lock
- *		->pagemap_lru_lock	(zap_pte_range)
+ *		->zone->lru_lock	(zap_pte_range)
  *      ->inode_lock			(__mark_inode_dirty)
  *        ->sb_lock			(fs/fs-writeback.c)
  *
@@ -68,7 +68,6 @@
  *    ->mapping->page_lock		(try_to_unmap_one)
  *
  */
-spinlock_t _pagemap_lru_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 /*
  * Remove a page from the page cache and free it. Caller has to make
--- 2.5.31/mm/memory.c~per-zone-lock	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/mm/memory.c	Sun Aug 11 00:20:35 2002
@@ -405,7 +405,7 @@ static void zap_pte_range(mmu_gather_t *
 			cached_rmap_lock(page, &rmap_lock, &last_lockno);
 			__page_remove_rmap(page, ptep);
 			/*
-			 * This will take pagemap_lru_lock.  Which nests inside
+			 * This will take zone->lru_lock.  Which nests inside
 			 * rmap_lock
 			 */
 			tlb_remove_page(tlb, &pvec, page);
--- 2.5.31/mm/rmap.c~per-zone-lock	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/mm/rmap.c	Sun Aug 11 00:20:44 2002
@@ -14,7 +14,7 @@
 /*
  * Locking:
  * - the page->pte.chain is protected by the PG_chainlock bit,
- *   which nests within the pagemap_lru_lock, then the
+ *   which nests within the zone->lru_lock, then the
  *   mm->page_table_lock, and then the page lock.
  * - because swapout locking is opposite to the locking order
  *   in the page fault path, the swapout path uses trylocks
@@ -317,7 +317,7 @@ void page_remove_rmap(struct page *page,
  * table entry mapping a page. Because locking order here is opposite
  * to the locking order used by the page fault path, we use trylocks.
  * Locking:
- *	pagemap_lru_lock		page_launder()
+ *	zone->lru_lock			page_launder()
  *	    page lock			page_launder(), trylock
  *		rmap_lock		page_launder()
  *		    mm->page_table_lock	try_to_unmap_one(), trylock
@@ -385,7 +385,7 @@ out_unlock:
  * @page: the page to get unmapped
  *
  * Tries to remove all the page table entries which are mapping this
- * page, used in the pageout path.  Caller must hold pagemap_lru_lock
+ * page, used in the pageout path.  Caller must hold zone->lru_lock
  * and the page lock.  Return values are:
  *
  * SWAP_SUCCESS	- we succeeded in removing all mappings
--- 2.5.31/mm/swap.c~per-zone-lock	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/mm/swap.c	Sun Aug 11 00:20:35 2002
@@ -26,26 +26,20 @@
 int page_cluster;
 
 /*
- * Move an inactive page to the active list.
+ * FIXME: speed this up?
  */
-static inline void activate_page_nolock(struct page * page)
+void activate_page(struct page *page)
 {
+	struct zone *zone = page_zone(page);
+
+	spin_lock_irq(&zone->lru_lock);
 	if (PageLRU(page) && !PageActive(page)) {
-		del_page_from_inactive_list(page);
+		del_page_from_inactive_list(zone, page);
 		SetPageActive(page);
-		add_page_to_active_list(page);
+		add_page_to_active_list(zone, page);
 		KERNEL_STAT_INC(pgactivate);
 	}
-}
-
-/*
- * FIXME: speed this up?
- */
-void activate_page(struct page * page)
-{
-	spin_lock_irq(&_pagemap_lru_lock);
-	activate_page_nolock(page);
-	spin_unlock_irq(&_pagemap_lru_lock);
+	spin_unlock_irq(&zone->lru_lock);
 }
 
 /**
@@ -80,13 +74,14 @@ void __page_cache_release(struct page *p
 {
 	BUG_ON(page_count(page) != 0);
 	if (PageLRU(page)) {
+		struct zone *zone = page_zone(page);
 		unsigned long flags;
 
-		spin_lock_irqsave(&_pagemap_lru_lock, flags);
+		spin_lock_irqsave(&zone->lru_lock, flags);
 		if (!TestClearPageLRU(page))
 			BUG();
-		del_page_from_lru(page);
-		spin_unlock_irqrestore(&_pagemap_lru_lock, flags);
+		del_page_from_lru(zone, page);
+		spin_unlock_irqrestore(&zone->lru_lock, flags);
 	}
 	__free_page(page);
 }
@@ -96,7 +91,7 @@ void __page_cache_release(struct page *p
  * pagevec's pages.  If it fell to zero then remove the page from the LRU and
  * free it.
  *
- * Avoid taking pagemap_lru_lock if possible, but if it is taken, retain it
+ * Avoid taking zone->lru_lock if possible, but if it is taken, retain it
  * for the remainder of the operation.
  *
  * The locking in this function is against shrink_cache(): we recheck the
@@ -108,28 +103,31 @@ void __page_cache_release(struct page *p
 void __pagevec_release(struct pagevec *pvec)
 {
 	int i;
-	int lock_held = 0;
 	struct pagevec pages_to_free;
+	struct zone *zone = NULL;
 
 	pagevec_init(&pages_to_free);
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
+		struct zone *pagezone;
 
 		if (!put_page_testzero(page))
 			continue;
 
-		if (!lock_held) {
-			spin_lock_irq(&_pagemap_lru_lock);
-			lock_held = 1;
+		pagezone = page_zone(page);
+		if (pagezone != zone) {
+			if (zone)
+				spin_unlock_irq(&zone->lru_lock);
+			zone = pagezone;
+			spin_lock_irq(&zone->lru_lock);
 		}
-
 		if (TestClearPageLRU(page))
-			del_page_from_lru(page);
+			del_page_from_lru(zone, page);
 		if (page_count(page) == 0)
 			pagevec_add(&pages_to_free, page);
 	}
-	if (lock_held)
-		spin_unlock_irq(&_pagemap_lru_lock);
+	if (zone)
+		spin_unlock_irq(&zone->lru_lock);
 
 	pagevec_free(&pages_to_free);
 	pagevec_init(pvec);
@@ -164,26 +162,27 @@ void __pagevec_release_nonlru(struct pag
 void pagevec_deactivate_inactive(struct pagevec *pvec)
 {
 	int i;
-	int lock_held = 0;
+	struct zone *zone = NULL;
 
 	if (pagevec_count(pvec) == 0)
 		return;
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
+		struct zone *pagezone = page_zone(page);
 
-		if (!lock_held) {
+		if (pagezone != zone) {
 			if (PageActive(page) || !PageLRU(page))
 				continue;
-			spin_lock_irq(&_pagemap_lru_lock);
-			lock_held = 1;
-		}
-		if (!PageActive(page) && PageLRU(page)) {
-			struct zone *zone = page_zone(page);
-			list_move(&page->lru, &zone->inactive_list);
+			if (zone)
+				spin_unlock_irq(&zone->lru_lock);
+			zone = pagezone;
+			spin_lock_irq(&zone->lru_lock);
 		}
+		if (!PageActive(page) && PageLRU(page))
+			list_move(&page->lru, &pagezone->inactive_list);
 	}
-	if (lock_held)
-		spin_unlock_irq(&_pagemap_lru_lock);
+	if (zone)
+		spin_unlock_irq(&zone->lru_lock);
 	__pagevec_release(pvec);
 }
 
@@ -194,16 +193,24 @@ void pagevec_deactivate_inactive(struct 
 void __pagevec_lru_add(struct pagevec *pvec)
 {
 	int i;
+	struct zone *zone = NULL;
 
-	spin_lock_irq(&_pagemap_lru_lock);
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
+		struct zone *pagezone = page_zone(page);
 
+		if (pagezone != zone) {
+			if (zone)
+				spin_unlock_irq(&zone->lru_lock);
+			zone = pagezone;
+			spin_lock_irq(&zone->lru_lock);
+		}
 		if (TestSetPageLRU(page))
 			BUG();
-		add_page_to_inactive_list(page);
+		add_page_to_inactive_list(zone, page);
 	}
-	spin_unlock_irq(&_pagemap_lru_lock);
+	if (zone)
+		spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(pvec);
 }
 
@@ -214,16 +221,24 @@ void __pagevec_lru_add(struct pagevec *p
 void __pagevec_lru_del(struct pagevec *pvec)
 {
 	int i;
+	struct zone *zone = NULL;
 
-	spin_lock_irq(&_pagemap_lru_lock);
 	for (i = 0; i < pagevec_count(pvec); i++) {
 		struct page *page = pvec->pages[i];
+		struct zone *pagezone = page_zone(page);
 
+		if (pagezone != zone) {
+			if (zone)
+				spin_unlock_irq(&zone->lru_lock);
+			zone = pagezone;
+			spin_lock_irq(&zone->lru_lock);
+		}
 		if (!TestClearPageLRU(page))
 			BUG();
-		del_page_from_lru(page);
+		del_page_from_lru(zone, page);
 	}
-	spin_unlock_irq(&_pagemap_lru_lock);
+	if (zone)
+		spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(pvec);
 }
 
--- 2.5.31/mm/vmscan.c~per-zone-lock	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/mm/vmscan.c	Sun Aug 11 00:20:35 2002
@@ -264,7 +264,7 @@ keep:
 }
 
 /*
- * pagemap_lru_lock is heavily contented.  We relieve it by quickly privatising
+ * zone->lru_lock is heavily contented.  We relieve it by quickly privatising
  * a batch of pages and working on them outside the lock.  Any pages which were
  * not freed will be added back to the LRU.
  *
@@ -292,7 +292,7 @@ shrink_cache(int nr_pages, struct zone *
 	pagevec_init(&pvec);
 
 	lru_add_drain();
-	spin_lock_irq(&_pagemap_lru_lock);
+	spin_lock_irq(&zone->lru_lock);
 	while (max_scan > 0 && nr_pages > 0) {
 		struct page *page;
 		int n = 0;
@@ -318,7 +318,7 @@ shrink_cache(int nr_pages, struct zone *
 			n++;
 		}
 		zone->nr_inactive -= n;
-		spin_unlock_irq(&_pagemap_lru_lock);
+		spin_unlock_irq(&zone->lru_lock);
 
 		if (list_empty(&page_list))
 			goto done;
@@ -331,7 +331,7 @@ shrink_cache(int nr_pages, struct zone *
 		if (nr_pages <= 0 && list_empty(&page_list))
 			goto done;
 
-		spin_lock_irq(&_pagemap_lru_lock);
+		spin_lock_irq(&zone->lru_lock);
 		/*
 		 * Put back any unfreeable pages.
 		 */
@@ -341,17 +341,17 @@ shrink_cache(int nr_pages, struct zone *
 				BUG();
 			list_del(&page->lru);
 			if (PageActive(page))
-				add_page_to_active_list(page);
+				add_page_to_active_list(zone, page);
 			else
-				add_page_to_inactive_list(page);
+				add_page_to_inactive_list(zone, page);
 			if (!pagevec_add(&pvec, page)) {
-				spin_unlock_irq(&_pagemap_lru_lock);
+				spin_unlock_irq(&zone->lru_lock);
 				__pagevec_release(&pvec);
-				spin_lock_irq(&_pagemap_lru_lock);
+				spin_lock_irq(&zone->lru_lock);
 			}
 		}
   	}
-	spin_unlock_irq(&_pagemap_lru_lock);
+	spin_unlock_irq(&zone->lru_lock);
 done:
 	pagevec_release(&pvec);
 	return nr_pages;	
@@ -364,9 +364,9 @@ done:
  * processes, from rmap.
  *
  * If the pages are mostly unmapped, the processing is fast and it is
- * appropriate to hold pagemap_lru_lock across the whole operation.  But if
+ * appropriate to hold zone->lru_lock across the whole operation.  But if
  * the pages are mapped, the processing is slow (page_referenced()) so we
- * should drop pagemap_lru_lock around each page.  It's impossible to balance
+ * should drop zone->lru_lock around each page.  It's impossible to balance
  * this, so instead we remove the pages from the LRU while processing them.
  * It is safe to rely on PG_active against the non-LRU pages in here because
  * nobody will play with that bit on a non-LRU page.
@@ -388,7 +388,7 @@ refill_inactive_zone(struct zone *zone, 
 	unsigned last_lockno = -1;
 
 	lru_add_drain();
-	spin_lock_irq(&_pagemap_lru_lock);
+	spin_lock_irq(&zone->lru_lock);
 	while (nr_pages && !list_empty(&zone->active_list)) {
 		page = list_entry(zone->active_list.prev, struct page, lru);
 		prefetchw_prev_lru_page(page, &zone->active_list, flags);
@@ -398,7 +398,7 @@ refill_inactive_zone(struct zone *zone, 
 		list_move(&page->lru, &l_hold);
 		nr_pages--;
 	}
-	spin_unlock_irq(&_pagemap_lru_lock);
+	spin_unlock_irq(&zone->lru_lock);
 
 	while (!list_empty(&l_hold)) {
 		page = list_entry(l_hold.prev, struct page, lru);
@@ -416,7 +416,7 @@ refill_inactive_zone(struct zone *zone, 
 	drop_rmap_lock(&rmap_lock, &last_lockno);
 
 	pagevec_init(&pvec);
-	spin_lock_irq(&_pagemap_lru_lock);
+	spin_lock_irq(&zone->lru_lock);
 	while (!list_empty(&l_inactive)) {
 		page = list_entry(l_inactive.prev, struct page, lru);
 		prefetchw_prev_lru_page(page, &l_inactive, flags);
@@ -426,9 +426,9 @@ refill_inactive_zone(struct zone *zone, 
 			BUG();
 		list_move(&page->lru, &zone->inactive_list);
 		if (!pagevec_add(&pvec, page)) {
-			spin_unlock_irq(&_pagemap_lru_lock);
+			spin_unlock_irq(&zone->lru_lock);
 			__pagevec_release(&pvec);
-			spin_lock_irq(&_pagemap_lru_lock);
+			spin_lock_irq(&zone->lru_lock);
 		}
 	}
 	while (!list_empty(&l_active)) {
@@ -439,14 +439,14 @@ refill_inactive_zone(struct zone *zone, 
 		BUG_ON(!PageActive(page));
 		list_move(&page->lru, &zone->active_list);
 		if (!pagevec_add(&pvec, page)) {
-			spin_unlock_irq(&_pagemap_lru_lock);
+			spin_unlock_irq(&zone->lru_lock);
 			__pagevec_release(&pvec);
-			spin_lock_irq(&_pagemap_lru_lock);
+			spin_lock_irq(&zone->lru_lock);
 		}
 	}
 	zone->nr_active -= pgdeactivate;
 	zone->nr_inactive += pgdeactivate;
-	spin_unlock_irq(&_pagemap_lru_lock);
+	spin_unlock_irq(&zone->lru_lock);
 	pagevec_release(&pvec);
 
 	KERNEL_STAT_ADD(pgscan, nr_pages_in - nr_pages);
--- 2.5.31/include/linux/mm.h~per-zone-lock	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/linux/mm.h	Sun Aug 11 00:20:50 2002
@@ -157,7 +157,7 @@ struct page {
 	struct address_space *mapping;	/* The inode (or ...) we belong to. */
 	unsigned long index;		/* Our offset within mapping. */
 	struct list_head lru;		/* Pageout list, eg. active_list;
-					   protected by pagemap_lru_lock !! */
+					   protected by zone->lru_lock !! */
 	union {
 		struct pte_chain * chain;	/* Reverse pte mapping pointer.
 					 * protected by PG_chainlock */
--- 2.5.31/include/linux/page-flags.h~per-zone-lock	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/linux/page-flags.h	Sun Aug 11 00:20:35 2002
@@ -28,7 +28,7 @@
  *
  * Note that the referenced bit, the page->lru list_head and the active,
  * inactive_dirty and inactive_clean lists are protected by the
- * pagemap_lru_lock, and *NOT* by the usual PG_locked bit!
+ * zone->lru_lock, and *NOT* by the usual PG_locked bit!
  *
  * PG_error is set to indicate that an I/O error occurred on this page.
  *
--- 2.5.31/include/linux/swap.h~per-zone-lock	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/linux/swap.h	Sun Aug 11 00:20:35 2002
@@ -212,8 +212,6 @@ extern struct swap_list_t swap_list;
 asmlinkage long sys_swapoff(const char *);
 asmlinkage long sys_swapon(const char *, int);
 
-extern spinlock_t _pagemap_lru_lock;
-
 extern void FASTCALL(mark_page_accessed(struct page *));
 
 extern spinlock_t swaplock;
--- 2.5.31/mm/page_alloc.c~per-zone-lock	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/mm/page_alloc.c	Sun Aug 11 00:20:50 2002
@@ -829,7 +829,8 @@ void __init free_area_init_core(int nid,
 		printk("zone(%lu): %lu pages.\n", j, size);
 		zone->size = size;
 		zone->name = zone_names[j];
-		zone->lock = SPIN_LOCK_UNLOCKED;
+		spin_lock_init(&zone->lock);
+		spin_lock_init(&zone->lru_lock);
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
 		zone->need_balance = 0;
--- 2.5.31/include/linux/mmzone.h~per-zone-lock	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/linux/mmzone.h	Sun Aug 11 00:20:58 2002
@@ -44,6 +44,7 @@ struct zone {
 	unsigned long		pages_min, pages_low, pages_high;
 	int			need_balance;
 
+	spinlock_t		lru_lock;	
 	struct list_head	active_list;
 	struct list_head	inactive_list;
 	atomic_t		refill_counter;

.
