Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318080AbSHKHbc>; Sun, 11 Aug 2002 03:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318118AbSHKHaw>; Sun, 11 Aug 2002 03:30:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41990 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318080AbSHKH00>;
	Sun, 11 Aug 2002 03:26:26 -0400
Message-ID: <3D5614D2.EDA7A18A@zip.com.au>
Date: Sun, 11 Aug 2002 00:40:02 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 17/21] per-zone LRUs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Replace the global page LRUs with per-zone LRUs.

This fixes the failure described at
http://mail.nl.linux.org/linux-mm/2002-08/msg00049.html

It will also fix the problem wherein a search for a reclaimable
ZONE_NORMAL page will undesirably move aged ZONE_HIGHMEM pages to the
head of the inactive list.  (I haven't tried to measure any benefit
from this aspect).

It will also reduces the amount of CPU spent scanning pages in page
reclaim. I haven't instrumented this either.

This is a minimal conversion - the aging and reclaim logic is left
unchanged, as far as is possible.

I was bitten by the "incremental min" logic in __alloc_pages again. 
There's a state in which the sum-of-mins exceeds zone->pages_high.  So
we call into try_to_free_pages(), which does nothing at all (all zones
have free_pages > pages_high).  The incremental min is unchanged and
the VM locks up.

This was fixed in __alloc_pages: if zone->free_pages is greater than
zone->pages_high then just go and grab a page.




 fs/proc/proc_misc.c        |    9 +++-
 include/linux/mm_inline.h  |   40 ++++++++++++++++++
 include/linux/mmzone.h     |   11 ++++-
 include/linux/page-flags.h |    2 
 include/linux/swap.h       |   45 --------------------
 mm/filemap.c               |    7 +--
 mm/page_alloc.c            |   54 +++++++++++++++++-------
 mm/swap.c                  |   26 ++++-------
 mm/vmscan.c                |   98 ++++++++++++++++++++++++++-------------------
 9 files changed, 166 insertions(+), 126 deletions(-)

--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 2.5.31-akpm/include/linux/mm_inline.h	Sun Aug 11 00:20:35 2002
@@ -0,0 +1,40 @@
+
+static inline void
+add_page_to_active_list(struct zone *zone, struct page *page)
+{
+	list_add(&page->lru, &zone->active_list);
+	zone->nr_active++;
+}
+
+static inline void
+add_page_to_inactive_list(struct zone *zone, struct page *page)
+{
+	list_add(&page->lru, &zone->inactive_list);
+	zone->nr_inactive++;
+}
+
+static inline void
+del_page_from_active_list(struct zone *zone, struct page *page)
+{
+	list_del(&page->lru);
+	zone->nr_active--;
+}
+
+static inline void
+del_page_from_inactive_list(struct zone *zone, struct page *page)
+{
+	list_del(&page->lru);
+	zone->nr_inactive--;
+}
+
+static inline void
+del_page_from_lru(struct zone *zone, struct page *page)
+{
+	list_del(&page->lru);
+	if (PageActive(page)) {
+		ClearPageActive(page);
+		zone->nr_active--;
+	} else {
+		zone->nr_inactive--;
+	}
+}
--- 2.5.31/include/linux/mmzone.h~per-zone-lru	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/linux/mmzone.h	Sun Aug 11 00:21:00 2002
@@ -8,6 +8,7 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 #include <linux/wait.h>
+#include <asm/atomic.h>
 
 /*
  * Free memory management - zoned buddy allocator.
@@ -43,6 +44,12 @@ struct zone {
 	unsigned long		pages_min, pages_low, pages_high;
 	int			need_balance;
 
+	struct list_head	active_list;
+	struct list_head	inactive_list;
+	atomic_t		refill_counter;
+	unsigned long		nr_active;
+	unsigned long		nr_inactive;
+
 	/*
 	 * free areas of different sizes
 	 */
@@ -157,10 +164,10 @@ memclass(struct zone *pgzone, struct zon
  * prototypes for the discontig memory code.
  */
 struct page;
-extern void show_free_areas_core(pg_data_t *pgdat);
-extern void free_area_init_core(int nid, pg_data_t *pgdat, struct page **gmap,
+void free_area_init_core(int nid, pg_data_t *pgdat, struct page **gmap,
   unsigned long *zones_size, unsigned long paddr, unsigned long *zholes_size,
   struct page *pmap);
+void get_zone_counts(unsigned long *active, unsigned long *inactive);
 
 extern pg_data_t contig_page_data;
 
--- 2.5.31/include/linux/swap.h~per-zone-lru	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/linux/swap.h	Sun Aug 11 00:21:00 2002
@@ -216,51 +216,6 @@ extern spinlock_t _pagemap_lru_lock;
 
 extern void FASTCALL(mark_page_accessed(struct page *));
 
-/*
- * List add/del helper macros. These must be called
- * with the pagemap_lru_lock held!
- */
-#define DEBUG_LRU_PAGE(page)			\
-do {						\
-	if (!PageLRU(page))			\
-		BUG();				\
-	if (PageActive(page))			\
-		BUG();				\
-} while (0)
-
-#define __add_page_to_active_list(page)		\
-do {						\
-	list_add(&(page)->lru, &active_list);	\
-	inc_page_state(nr_active);		\
-} while (0)
-
-#define add_page_to_active_list(page)		\
-do {						\
-	DEBUG_LRU_PAGE(page);			\
-	SetPageActive(page);			\
-	__add_page_to_active_list(page);	\
-} while (0)
-
-#define add_page_to_inactive_list(page)		\
-do {						\
-	DEBUG_LRU_PAGE(page);			\
-	list_add(&(page)->lru, &inactive_list);	\
-	inc_page_state(nr_inactive);		\
-} while (0)
-
-#define del_page_from_active_list(page)		\
-do {						\
-	list_del(&(page)->lru);			\
-	ClearPageActive(page);			\
-	dec_page_state(nr_active);		\
-} while (0)
-
-#define del_page_from_inactive_list(page)	\
-do {						\
-	list_del(&(page)->lru);			\
-	dec_page_state(nr_inactive);		\
-} while (0)
-
 extern spinlock_t swaplock;
 
 #define swap_list_lock()	spin_lock(&swaplock)
--- 2.5.31/mm/page_alloc.c~per-zone-lru	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/mm/page_alloc.c	Sun Aug 11 00:21:00 2002
@@ -27,8 +27,6 @@
 unsigned long totalram_pages;
 unsigned long totalhigh_pages;
 int nr_swap_pages;
-LIST_HEAD(active_list);
-LIST_HEAD(inactive_list);
 pg_data_t *pgdat_list;
 
 /*
@@ -267,7 +265,7 @@ struct page *_alloc_pages(unsigned int g
 #endif
 
 static /* inline */ struct page *
-balance_classzone(struct zone *classzone, unsigned int gfp_mask,
+balance_classzone(struct zone* classzone, unsigned int gfp_mask,
 			unsigned int order, int * freed)
 {
 	struct page * page = NULL;
@@ -345,7 +343,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 
 		/* the incremental min is allegedly to discourage fallback */
 		min += z->pages_low;
-		if (z->free_pages > min) {
+		if (z->free_pages > min || z->free_pages >= z->pages_high) {
 			page = rmqueue(z, order);
 			if (page)
 				return page;
@@ -368,7 +366,7 @@ __alloc_pages(unsigned int gfp_mask, uns
 		if (gfp_mask & __GFP_HIGH)
 			local_min >>= 2;
 		min += local_min;
-		if (z->free_pages > min) {
+		if (z->free_pages > min || z->free_pages >= z->pages_high) {
 			page = rmqueue(z, order);
 			if (page)
 				return page;
@@ -411,7 +409,7 @@ nopage:
 		struct zone *z = zones[i];
 
 		min += z->pages_min;
-		if (z->free_pages > min) {
+		if (z->free_pages > min || z->free_pages >= z->pages_high) {
 			page = rmqueue(z, order);
 			if (page)
 				return page;
@@ -562,13 +560,23 @@ void get_page_state(struct page_state *r
 		ret->nr_dirty += ps->nr_dirty;
 		ret->nr_writeback += ps->nr_writeback;
 		ret->nr_pagecache += ps->nr_pagecache;
-		ret->nr_active += ps->nr_active;
-		ret->nr_inactive += ps->nr_inactive;
 		ret->nr_page_table_pages += ps->nr_page_table_pages;
 		ret->nr_reverse_maps += ps->nr_reverse_maps;
 	}
 }
 
+void get_zone_counts(unsigned long *active, unsigned long *inactive)
+{
+	struct zone *zone;
+
+	*active = 0;
+	*inactive = 0;
+	for_each_zone(zone) {
+		*active += zone->nr_active;
+		*inactive += zone->nr_inactive;
+	}
+}
+
 unsigned long get_page_cache_size(void)
 {
 	struct page_state ps;
@@ -605,8 +613,11 @@ void show_free_areas(void)
 	pg_data_t *pgdat;
 	struct page_state ps;
 	int type;
+	unsigned long active;
+	unsigned long inactive;
 
 	get_page_state(&ps);
+	get_zone_counts(&active, &inactive);
 
 	printk("Free pages:      %6dkB (%6dkB HighMem)\n",
 		K(nr_free_pages()),
@@ -615,21 +626,27 @@ void show_free_areas(void)
 	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->pgdat_next)
 		for (type = 0; type < MAX_NR_ZONES; ++type) {
 			struct zone *zone = &pgdat->node_zones[type];
-			printk("Zone:%s "
-				"freepages:%6lukB "
-				"min:%6lukB "
-				"low:%6lukB " 
-				"high:%6lukB\n", 
+			printk("Zone:%s"
+				" freepages:%6lukB"
+				" min:%6lukB"
+				" low:%6lukB"
+				" high:%6lukB"
+				" active:%6lukB"
+				" inactive:%6lukB"
+				"\n",
 				zone->name,
 				K(zone->free_pages),
 				K(zone->pages_min),
 				K(zone->pages_low),
-				K(zone->pages_high));
+				K(zone->pages_high),
+				K(zone->nr_active),
+				K(zone->nr_inactive)
+				);
 		}
 
 	printk("( Active:%lu inactive:%lu dirty:%lu writeback:%lu free:%u )\n",
-		ps.nr_active,
-		ps.nr_inactive,
+		active,
+		inactive,
 		ps.nr_dirty,
 		ps.nr_writeback,
 		nr_free_pages());
@@ -816,6 +833,11 @@ void __init free_area_init_core(int nid,
 		zone->zone_pgdat = pgdat;
 		zone->free_pages = 0;
 		zone->need_balance = 0;
+		INIT_LIST_HEAD(&zone->active_list);
+		INIT_LIST_HEAD(&zone->inactive_list);
+		atomic_set(&zone->refill_counter, 0);
+		zone->nr_active = 0;
+		zone->nr_inactive = 0;
 		if (!size)
 			continue;
 
--- 2.5.31/mm/swap.c~per-zone-lru	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/mm/swap.c	Sun Aug 11 00:21:00 2002
@@ -19,6 +19,7 @@
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 #include <linux/init.h>
+#include <linux/mm_inline.h>
 #include <linux/prefetch.h>
 
 /* How many pages do we try to swap or page in/out together? */
@@ -31,6 +32,7 @@ static inline void activate_page_nolock(
 {
 	if (PageLRU(page) && !PageActive(page)) {
 		del_page_from_inactive_list(page);
+		SetPageActive(page);
 		add_page_to_active_list(page);
 		KERNEL_STAT_INC(pgactivate);
 	}
@@ -83,10 +85,7 @@ void __page_cache_release(struct page *p
 		spin_lock_irqsave(&_pagemap_lru_lock, flags);
 		if (!TestClearPageLRU(page))
 			BUG();
-		if (PageActive(page))
-			del_page_from_active_list(page);
-		else
-			del_page_from_inactive_list(page);
+		del_page_from_lru(page);
 		spin_unlock_irqrestore(&_pagemap_lru_lock, flags);
 	}
 	__free_page(page);
@@ -124,12 +123,8 @@ void __pagevec_release(struct pagevec *p
 			lock_held = 1;
 		}
 
-		if (TestClearPageLRU(page)) {
-			if (PageActive(page))
-				del_page_from_active_list(page);
-			else
-				del_page_from_inactive_list(page);
-		}
+		if (TestClearPageLRU(page))
+			del_page_from_lru(page);
 		if (page_count(page) == 0)
 			pagevec_add(&pages_to_free, page);
 	}
@@ -182,8 +177,10 @@ void pagevec_deactivate_inactive(struct 
 			spin_lock_irq(&_pagemap_lru_lock);
 			lock_held = 1;
 		}
-		if (!PageActive(page) && PageLRU(page))
-			list_move(&page->lru, &inactive_list);
+		if (!PageActive(page) && PageLRU(page)) {
+			struct zone *zone = page_zone(page);
+			list_move(&page->lru, &zone->inactive_list);
+		}
 	}
 	if (lock_held)
 		spin_unlock_irq(&_pagemap_lru_lock);
@@ -224,10 +221,7 @@ void __pagevec_lru_del(struct pagevec *p
 
 		if (!TestClearPageLRU(page))
 			BUG();
-		if (PageActive(page))
-			del_page_from_active_list(page);
-		else
-			del_page_from_inactive_list(page);
+		del_page_from_lru(page);
 	}
 	spin_unlock_irq(&_pagemap_lru_lock);
 	pagevec_release(pvec);
--- 2.5.31/mm/vmscan.c~per-zone-lru	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/mm/vmscan.c	Sun Aug 11 00:21:00 2002
@@ -23,6 +23,7 @@
 #include <linux/writeback.h>
 #include <linux/suspend.h>
 #include <linux/buffer_head.h>		/* for try_to_release_page() */
+#include <linux/mm_inline.h>
 #include <linux/pagevec.h>
 
 #include <asm/rmap.h>
@@ -95,8 +96,7 @@ static inline int is_page_cache_freeable
 
 static /* inline */ int
 shrink_list(struct list_head *page_list, int nr_pages,
-		struct zone *classzone, unsigned int gfp_mask,
-		int priority, int *max_scan)
+		unsigned int gfp_mask, int priority, int *max_scan)
 {
 	struct address_space *mapping;
 	LIST_HEAD(ret_pages);
@@ -112,8 +112,6 @@ shrink_list(struct list_head *page_list,
 
 		page = list_entry(page_list->prev, struct page, lru);
 		list_del(&page->lru);
-		if (!memclass(page_zone(page), classzone))
-			goto keep;
 
 		if (TestSetPageLocked(page))
 			goto keep;
@@ -277,7 +275,7 @@ keep:
  * in the kernel (apart from the copy_*_user functions).
  */
 static /* inline */ int
-shrink_cache(int nr_pages, struct zone *classzone,
+shrink_cache(int nr_pages, struct zone *zone,
 		unsigned int gfp_mask, int priority, int max_scan)
 {
 	LIST_HEAD(page_list);
@@ -299,10 +297,12 @@ shrink_cache(int nr_pages, struct zone *
 		struct page *page;
 		int n = 0;
 
-		while (n < nr_to_process && !list_empty(&inactive_list)) {
-			page = list_entry(inactive_list.prev, struct page, lru);
+		while (n < nr_to_process && !list_empty(&zone->inactive_list)) {
+			page = list_entry(zone->inactive_list.prev,
+					struct page, lru);
 
-			prefetchw_prev_lru_page(page, &inactive_list, flags);
+			prefetchw_prev_lru_page(page,
+						&zone->inactive_list, flags);
 
 			if (!TestClearPageLRU(page))
 				BUG();
@@ -310,22 +310,22 @@ shrink_cache(int nr_pages, struct zone *
 			if (page_count(page) == 0) {
 				/* It is currently in pagevec_release() */
 				SetPageLRU(page);
-				list_add(&page->lru, &inactive_list);
+				list_add(&page->lru, &zone->inactive_list);
 				continue;
 			}
 			list_add(&page->lru, &page_list);
 			page_cache_get(page);
 			n++;
 		}
+		zone->nr_inactive -= n;
 		spin_unlock_irq(&_pagemap_lru_lock);
 
 		if (list_empty(&page_list))
 			goto done;
 
 		max_scan -= n;
-		mod_page_state(nr_inactive, -n);
 		KERNEL_STAT_ADD(pgscan, n);
-		nr_pages = shrink_list(&page_list, nr_pages, classzone,
+		nr_pages = shrink_list(&page_list, nr_pages,
 					gfp_mask, priority, &max_scan);
 
 		if (nr_pages <= 0 && list_empty(&page_list))
@@ -341,7 +341,7 @@ shrink_cache(int nr_pages, struct zone *
 				BUG();
 			list_del(&page->lru);
 			if (PageActive(page))
-				__add_page_to_active_list(page);
+				add_page_to_active_list(page);
 			else
 				add_page_to_inactive_list(page);
 			if (!pagevec_add(&pvec, page)) {
@@ -374,7 +374,8 @@ done:
  * The downside is that we have to touch page->count against each page.
  * But we had to alter page->flags anyway.
  */
-static /* inline */ void refill_inactive(const int nr_pages_in)
+static /* inline */ void
+refill_inactive_zone(struct zone *zone, const int nr_pages_in)
 {
 	int pgdeactivate = 0;
 	int nr_pages = nr_pages_in;
@@ -388,9 +389,9 @@ static /* inline */ void refill_inactive
 
 	lru_add_drain();
 	spin_lock_irq(&_pagemap_lru_lock);
-	while (nr_pages && !list_empty(&active_list)) {
-		page = list_entry(active_list.prev, struct page, lru);
-		prefetchw_prev_lru_page(page, &active_list, flags);
+	while (nr_pages && !list_empty(&zone->active_list)) {
+		page = list_entry(zone->active_list.prev, struct page, lru);
+		prefetchw_prev_lru_page(page, &zone->active_list, flags);
 		if (!TestClearPageLRU(page))
 			BUG();
 		page_cache_get(page);
@@ -423,7 +424,7 @@ static /* inline */ void refill_inactive
 			BUG();
 		if (!TestClearPageActive(page))
 			BUG();
-		list_move(&page->lru, &inactive_list);
+		list_move(&page->lru, &zone->inactive_list);
 		if (!pagevec_add(&pvec, page)) {
 			spin_unlock_irq(&_pagemap_lru_lock);
 			__pagevec_release(&pvec);
@@ -436,31 +437,30 @@ static /* inline */ void refill_inactive
 		if (TestSetPageLRU(page))
 			BUG();
 		BUG_ON(!PageActive(page));
-		list_move(&page->lru, &active_list);
+		list_move(&page->lru, &zone->active_list);
 		if (!pagevec_add(&pvec, page)) {
 			spin_unlock_irq(&_pagemap_lru_lock);
 			__pagevec_release(&pvec);
 			spin_lock_irq(&_pagemap_lru_lock);
 		}
 	}
+	zone->nr_active -= pgdeactivate;
+	zone->nr_inactive += pgdeactivate;
 	spin_unlock_irq(&_pagemap_lru_lock);
 	pagevec_release(&pvec);
 
-	mod_page_state(nr_active, -pgdeactivate);
-	mod_page_state(nr_inactive, pgdeactivate);
 	KERNEL_STAT_ADD(pgscan, nr_pages_in - nr_pages);
 	KERNEL_STAT_ADD(pgdeactivate, pgdeactivate);
 }
 
 static /* inline */ int
-shrink_caches(struct zone *classzone, int priority,
-		unsigned int gfp_mask, int nr_pages)
+shrink_zone(struct zone *zone, int priority,
+	unsigned int gfp_mask, int nr_pages)
 {
 	unsigned long ratio;
-	struct page_state ps;
 	int max_scan;
-	static atomic_t nr_to_refill = ATOMIC_INIT(0);
 
+	/* This is bogus for ZONE_HIGHMEM? */
 	if (kmem_cache_reap(gfp_mask) >= nr_pages)
   		return 0;
 
@@ -474,17 +474,16 @@ shrink_caches(struct zone *classzone, in
 	 * just to make sure that the kernel will slowly sift through the
 	 * active list.
 	 */
-	get_page_state(&ps);
-	ratio = (unsigned long)nr_pages * ps.nr_active /
-				((ps.nr_inactive | 1) * 2);
-	atomic_add(ratio+1, &nr_to_refill);
-	if (atomic_read(&nr_to_refill) > SWAP_CLUSTER_MAX) {
-		atomic_sub(SWAP_CLUSTER_MAX, &nr_to_refill);
-		refill_inactive(SWAP_CLUSTER_MAX);
+	ratio = (unsigned long)nr_pages * zone->nr_active /
+				((zone->nr_inactive | 1) * 2);
+	atomic_add(ratio+1, &zone->refill_counter);
+	if (atomic_read(&zone->refill_counter) > SWAP_CLUSTER_MAX) {
+		atomic_sub(SWAP_CLUSTER_MAX, &zone->refill_counter);
+		refill_inactive_zone(zone, SWAP_CLUSTER_MAX);
 	}
 
-	max_scan = ps.nr_inactive / priority;
-	nr_pages = shrink_cache(nr_pages, classzone,
+	max_scan = zone->nr_inactive / priority;
+	nr_pages = shrink_cache(nr_pages, zone,
 				gfp_mask, priority, max_scan);
 
 	if (nr_pages <= 0)
@@ -503,7 +502,30 @@ shrink_caches(struct zone *classzone, in
 	return nr_pages;
 }
 
-int try_to_free_pages(struct zone *classzone,
+static int
+shrink_caches(struct zone *classzone, int priority,
+		int gfp_mask, int nr_pages)
+{
+	struct zone *first_classzone;
+	struct zone *zone;
+
+	first_classzone = classzone->zone_pgdat->node_zones;
+	zone = classzone;
+	while (zone >= first_classzone) {
+		if (zone->free_pages <= zone->pages_high) {
+			nr_pages = shrink_zone(zone, priority,
+					gfp_mask, nr_pages);
+		}
+		zone--;
+	}
+	return nr_pages;
+}
+
+/*
+ * This is the main entry point to page reclaim.
+ */
+int
+try_to_free_pages(struct zone *classzone,
 		unsigned int gfp_mask, unsigned int order)
 {
 	int priority = DEF_PRIORITY;
@@ -512,15 +534,11 @@ int try_to_free_pages(struct zone *class
 	KERNEL_STAT_INC(pageoutrun);
 
 	do {
-		nr_pages = shrink_caches(classzone, priority, gfp_mask, nr_pages);
+		nr_pages = shrink_caches(classzone, priority,
+					gfp_mask, nr_pages);
 		if (nr_pages <= 0)
 			return 1;
 	} while (--priority);
-
-	/*
-	 * Hmm.. Cache shrink failed - time to kill something?
-	 * Mhwahahhaha! This is the part I really like. Giggle.
-	 */
 	out_of_memory();
 	return 0;
 }
--- 2.5.31/include/linux/page-flags.h~per-zone-lru	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/linux/page-flags.h	Sun Aug 11 00:21:00 2002
@@ -74,8 +74,6 @@ extern struct page_state {
 	unsigned long nr_dirty;
 	unsigned long nr_writeback;
 	unsigned long nr_pagecache;
-	unsigned long nr_active;	/* on active_list LRU */
-	unsigned long nr_inactive;	/* on inactive_list LRU */
 	unsigned long nr_page_table_pages;
 	unsigned long nr_reverse_maps;
 } ____cacheline_aligned_in_smp page_states[NR_CPUS];
--- 2.5.31/fs/proc/proc_misc.c~per-zone-lru	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/fs/proc/proc_misc.c	Sun Aug 11 00:20:35 2002
@@ -27,6 +27,7 @@
 #include <linux/ioport.h>
 #include <linux/config.h>
 #include <linux/mm.h>
+#include <linux/mmzone.h>
 #include <linux/pagemap.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
@@ -134,8 +135,12 @@ static int meminfo_read_proc(char *page,
 	struct sysinfo i;
 	int len, committed;
 	struct page_state ps;
+	unsigned long inactive;
+	unsigned long active;
 
 	get_page_state(&ps);
+	get_zone_counts(&active, &inactive);
+
 /*
  * display in kilobytes.
  */
@@ -171,8 +176,8 @@ static int meminfo_read_proc(char *page,
 		K(i.sharedram),
 		K(ps.nr_pagecache-swapper_space.nrpages),
 		K(swapper_space.nrpages),
-		K(ps.nr_active),
-		K(ps.nr_inactive),
+		K(active),
+		K(inactive),
 		K(i.totalhigh),
 		K(i.freehigh),
 		K(i.totalram-i.totalhigh),
--- 2.5.31/mm/filemap.c~per-zone-lru	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/mm/filemap.c	Sun Aug 11 00:21:00 2002
@@ -1158,14 +1158,15 @@ do_readahead(struct file *file, unsigned
 {
 	struct address_space *mapping = file->f_dentry->d_inode->i_mapping;
 	unsigned long max;
-	struct page_state ps;
+	unsigned long active;
+	unsigned long inactive;
 
 	if (!mapping || !mapping->a_ops || !mapping->a_ops->readpage)
 		return -EINVAL;
 
 	/* Limit it to a sane percentage of the inactive list.. */
-	get_page_state(&ps);
-	max = ps.nr_inactive / 2;
+	get_zone_counts(&active, &inactive);
+	max = inactive / 2;
 	if (nr > max)
 		nr = max;
 

.
