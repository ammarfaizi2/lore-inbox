Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274133AbRISSZm>; Wed, 19 Sep 2001 14:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272341AbRISSZh>; Wed, 19 Sep 2001 14:25:37 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:41226 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S274133AbRISSZT>;
	Wed, 19 Sep 2001 14:25:19 -0400
Date: Wed, 19 Sep 2001 15:25:29 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH] fix page aging (2.4.9-ac12)
Message-ID: <Pine.LNX.4.33L.0109191454570.8191-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

No more mr. overcareful, obviously that doesn't work ;)

The attached patch fixes page aging by adopting an approximation
of the aging scheme used by Linux 2.0 and FreeBSD:

1) linear page aging, 3/1/5/64
2) large inactive_dirty list, which allows mapped pages to
3) try_to_swap_out() only swaps out pages when page->age==0
4) pages are being aged up and down consistently, with page
   table scanning being done at the same rate as scanning of
   the active list (that is, it takes the same time to scan
   all of both)
5) when we have excessive amounts of page cache or buffer
   cache, we bypass aging for these pages and directly
   deactivate them
6) only touch pages when we use them, not when we look them
   up in __find_page_nolock()
7) remove the temporary tunables for page aging and drop
   behind, we now use a known-good strategy anyway

The next item on my list is page_launder(), unbuffered mpg123
still skips once when I run fillmem (from quintela's test suite),
so I have something to fix.

[and before you ask, Linus' current tree kills fillmem instead
 of letting it run to completion, so I guess the status of the
 -ac VM isn't _that_ bad ;)]

Alan, could you apply this for the next -ac, please ?

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)


--- linux-2.4.9-ac12/fs/buffer.c.orig	Wed Sep 19 13:11:48 2001
+++ linux-2.4.9-ac12/fs/buffer.c	Wed Sep 19 13:12:00 2001
@@ -849,12 +849,6 @@
 	if (!PageError(page))
 		SetPageUptodate(page);

-	/*
-	 * Run the hooks that have to be done when a page I/O has completed.
-	 */
-	if (PageTestandClearDecrAfter(page))
-		atomic_dec(&nr_async_pages);
-
 	UnlockPage(page);

 	return;
--- linux-2.4.9-ac12/kernel/sysctl.c.orig	Wed Sep 19 13:10:36 2001
+++ linux-2.4.9-ac12/kernel/sysctl.c	Wed Sep 19 13:11:01 2001
@@ -280,12 +280,8 @@
 	&vm_min_readahead,sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_MAX_READAHEAD, "max-readahead",
 	&vm_max_readahead,sizeof(int), 0644, NULL, &proc_dointvec},
-	{VM_AGING_TACTIC, "page_aging_tactic",
-	 &vm_page_aging_tactic, sizeof(int), 0644, NULL, &proc_dointvec},
 	{VM_INACTIVE_TARGET, "static_inactive_target",
 	 &vm_static_inactive_target, sizeof(int), 0644, NULL, &proc_dointvec},
-	{VM_DROP_BEHIND, "drop_behind",
-	 &vm_drop_behind, sizeof(int), 0644, NULL, &proc_dointvec},
 	{0}
 };

--- linux-2.4.9-ac12/kernel/ksyms.c.orig	Wed Sep 19 13:43:08 2001
+++ linux-2.4.9-ac12/kernel/ksyms.c	Wed Sep 19 13:43:13 2001
@@ -490,7 +490,6 @@
 EXPORT_SYMBOL(sys_tz);
 EXPORT_SYMBOL(file_fsync);
 EXPORT_SYMBOL(clear_inode);
-EXPORT_SYMBOL(nr_async_pages);
 EXPORT_SYMBOL(___strtok);
 EXPORT_SYMBOL(init_special_inode);
 EXPORT_SYMBOL(read_ahead);
--- linux-2.4.9-ac12/mm/filemap.c.orig	Wed Sep 19 12:15:31 2001
+++ linux-2.4.9-ac12/mm/filemap.c	Wed Sep 19 14:09:20 2001
@@ -338,34 +338,6 @@
 	spin_unlock(&pagecache_lock);
 }

-/*
- * This function is pretty much like __find_page_nolock(), but it only
- * requires 2 arguments and doesn't mark the page as touched, making it
- * ideal for ->writepage() clustering and other places where you don't
- * want to mark the page referenced.
- *
- * The caller needs to hold the pagecache_lock.
- */
-static struct page * FASTCALL(__find_page_simple(struct address_space *, unsigned long));
-static struct page * __find_page_simple(struct address_space *mapping, unsigned long index)
-{
-	struct page **next = page_hash(mapping, index);;
-
-	for (;;) {
-		struct page *page = *next;
-		if (!page)
-			break;
-		next = &page->next_hash;
-		if (page->mapping != mapping)
-			continue;
-		if (page->index != index)
-			continue;
-		return page;
-	}
-
-	return NULL;
-}
-
 static inline struct page * __find_page_nolock(struct address_space *mapping, unsigned long offset, struct page *page)
 {
 	goto inside;
@@ -380,21 +352,16 @@
 		if (page->index == offset)
 			break;
 	}
-	/*
-	 * Mark the page referenced so kswapd knows to up page->age
-	 * the next VM scan. Make sure to move inactive pages to the
-	 * active list so we don't get a nasty surprise when the pages
-	 * we thought were freeable aren't...
-	 */
-	if (PageActive(page))
-		SetPageReferenced(page);
-	else
-		activate_page(page);

 not_found:
 	return page;
 }

+static struct page * __find_page(struct address_space * mapping, unsigned long index)
+{
+	return __find_page_nolock(mapping, index, *page_hash(mapping,index));
+}
+
 /*
  * By the time this is called, the page is locked and
  * we don't have to worry about any races any more.
@@ -815,7 +782,6 @@
  *
  * Rik van Riel, 2000
  */
-int vm_drop_behind = 1;
 static void drop_behind(struct file * file, unsigned long index)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -823,10 +789,6 @@
 	struct page *page;
 	unsigned long start;

-	/* If drop-behind was disabled in /proc ... */
-	if (!vm_drop_behind)
-		return;
-
 	/* Nothing to drop-behind if we're on the first page. */
 	if (!index)
 		return;
@@ -844,8 +806,8 @@
 	 */
 	spin_lock(&pagecache_lock);
 	while (--index >= start) {
-		page = __find_page_simple(mapping, index);
-		if (!page)
+		page = __find_page(mapping, index);
+		if (!page || !PageActive(page))
 			break;
 		deactivate_page(page);
 	}
@@ -1174,6 +1136,7 @@
 			goto no_cached_page;
 found_page:
 		page_cache_get(page);
+		touch_page(page);
 		spin_unlock(&pagecache_lock);

 		if (!Page_Uptodate(page))
@@ -1558,6 +1521,7 @@
 		goto page_not_uptodate;

 success:
+	touch_page(page);
  	/*
 	 * Try read-ahead for sequential areas.
 	 */
@@ -2695,8 +2659,10 @@
 unlock:
 		/* Mark it unlocked again and drop the page.. */
 		UnlockPage(page);
-		if (deactivate && vm_drop_behind)
+		if (deactivate)
 			deactivate_page(page);
+		else
+			touch_page(page);
 		page_cache_release(page);

 		if (status < 0)
--- linux-2.4.9-ac12/mm/memory.c.orig	Wed Sep 19 12:15:31 2001
+++ linux-2.4.9-ac12/mm/memory.c	Wed Sep 19 13:38:23 2001
@@ -1078,10 +1078,6 @@
 	 */
 	num = valid_swaphandles(entry, &offset);
 	for (i = 0; i < num; offset++, i++) {
-		/* Don't block on I/O for read-ahead */
-		if (atomic_read(&nr_async_pages) >=
-		    pager_daemon.swap_cluster << page_cluster)
-			break;
 		/* Ok, do the async read-ahead now */
 		new_page = read_swap_cache_async(SWP_ENTRY(SWP_TYPE(entry), offset));
 		if (!new_page)
--- linux-2.4.9-ac12/mm/page_alloc.c.orig	Wed Sep 19 12:15:31 2001
+++ linux-2.4.9-ac12/mm/page_alloc.c	Wed Sep 19 13:12:14 2001
@@ -79,8 +79,6 @@
 		BUG();
 	if (PageLocked(page))
 		BUG();
-	if (PageDecrAfter(page))
-		BUG();
 	if (PageActive(page))
 		BUG();
 	if (PageInactiveDirty(page))
@@ -135,17 +133,6 @@
 	memlist_add_head(&(base + page_idx)->list, &area->free_list);

 	spin_unlock_irqrestore(&zone->lock, flags);
-
-	/*
-	 * We don't want to protect this variable from race conditions
-	 * since it's nothing important, but we do want to make sure
-	 * it never gets negative.
-	 */
-	{
-		int mp = memory_pressure-1;
-		if (mp > 0)
-			memory_pressure = mp;
-	}
 }

 #define MARK_USED(index, order, area) \
@@ -287,11 +274,6 @@
 	zone_t **zone;
 	int direct_reclaim = 0;
 	struct page * page;
-
-	/*
-	 * Allocations put pressure on the VM subsystem.
-	 */
-	memory_pressure++;

 	/*
 	 * (If anyone calls gfp from interrupts nonatomically then it
--- linux-2.4.9-ac12/mm/page_io.c.orig	Wed Sep 19 12:15:31 2001
+++ linux-2.4.9-ac12/mm/page_io.c	Wed Sep 19 13:12:44 2001
@@ -43,11 +43,6 @@
 	struct inode *swapf = 0;
 	int wait = 0;

-	/* Don't allow too many pending pages in flight.. */
-	if ((rw == WRITE) && atomic_read(&nr_async_pages) >
-			pager_daemon.swap_cluster * (1 << page_cluster))
-		wait = 1;
-
 	if (rw == READ) {
 		ClearPageUptodate(page);
 		kstat.pswpin++;
@@ -75,10 +70,6 @@
 	} else {
 		return 0;
 	}
- 	if (!wait && rw == WRITE) {
- 		SetPageDecrAfter(page);
- 		atomic_inc(&nr_async_pages);
- 	}

  	/* block_size == PAGE_SIZE/zones_used */
  	brw_page(rw, page, dev, zones, block_size);
--- linux-2.4.9-ac12/mm/swap.c.orig	Wed Sep 19 12:15:31 2001
+++ linux-2.4.9-ac12/mm/swap.c	Wed Sep 19 13:17:20 2001
@@ -41,21 +41,6 @@
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;

-/*
- * This variable contains the amount of page steals the system
- * is doing, averaged over a minute. We use this to determine how
- * many inactive pages we should have.
- *
- * In reclaim_page and __alloc_pages: memory_pressure++
- * In __free_pages_ok: memory_pressure--
- * In recalculate_vm_stats the value is decayed (once a second)
- */
-int memory_pressure;
-
-/* We track the number of pages currently being asynchronously swapped
-   out, so that we don't try to swap TOO many pages out at once */
-atomic_t nr_async_pages = ATOMIC_INIT(0);
-
 buffer_mem_t buffer_mem = {
 	2,	/* minimum percent buffer */
 	10,	/* borrow percent buffer */
@@ -64,7 +49,7 @@

 buffer_mem_t page_cache = {
 	2,	/* minimum percent page cache */
-	15,	/* borrow percent page cache */
+	50,	/* borrow percent page cache */
 	75	/* maximum */
 };

@@ -88,22 +73,12 @@
 void deactivate_page_nolock(struct page * page)
 {
 	/*
-	 * One for the cache, one for the extra reference the
-	 * caller has and (maybe) one for the buffers.
-	 *
-	 * This isn't perfect, but works for just about everything.
-	 * Besides, as long as we don't move unfreeable pages to the
-	 * inactive_clean list it doesn't need to be perfect...
-	 */
-	int maxcount = (page->buffers ? 3 : 2);
-	page->age = 0;
-	ClearPageReferenced(page);
-
-	/*
 	 * Don't touch it if it's not on the active list.
 	 * (some pages aren't on any list at all)
 	 */
-	if (PageActive(page) && page_count(page) <= maxcount && !page_ramdisk(page)) {
+	if (PageActive(page) && !page_ramdisk(page)) {
+		page->age = 0;
+		ClearPageReferenced(page);
 		del_page_from_active_list(page);
 		add_page_to_inactive_dirty_list(page);
 	}
@@ -195,22 +170,6 @@
 	spin_lock(&pagemap_lru_lock);
 	__lru_cache_del(page);
 	spin_unlock(&pagemap_lru_lock);
-}
-
-/**
- * recalculate_vm_stats - recalculate VM statistics
- *
- * This function should be called once a second to recalculate
- * some useful statistics the VM subsystem uses to determine
- * its behaviour.
- */
-void recalculate_vm_stats(void)
-{
-	/*
-	 * Substract one second worth of memory_pressure from
-	 * memory_pressure.
-	 */
-	memory_pressure -= (memory_pressure >> INACTIVE_SHIFT);
 }

 /*
--- linux-2.4.9-ac12/mm/swap_state.c.orig	Wed Sep 19 12:15:31 2001
+++ linux-2.4.9-ac12/mm/swap_state.c	Wed Sep 19 14:04:07 2001
@@ -183,10 +183,12 @@
 	 * the swap cache at this moment.  find_lock_page would prevent
 	 * that, but no need to change: we _have_ got the right page.
 	 */
+	if (found) {
+		touch_page(found);
 #ifdef SWAP_CACHE_INFO
-	if (found)
 		swap_cache_find_success++;
 #endif
+	}
 	return found;
 }

--- linux-2.4.9-ac12/mm/vmscan.c.orig	Wed Sep 19 12:15:31 2001
+++ linux-2.4.9-ac12/mm/vmscan.c	Wed Sep 19 13:52:57 2001
@@ -26,70 +26,21 @@

 int vm_static_inactive_target;

-/*
- * Helper functions for page aging. You can tune the page
- * aging policy in /proc/sys/vm/page_aging_tactic.
- *
- * These tunable is here mainly for the VM developers to
- * do tests with. Some documentation can be found at:
- *
- * http://linux-mm.org/wiki/moin.cgi/PageAging
- */
-#define	PAGE_AGE_NULL		0
-#define PAGE_AGE_SINGLEBIT	1
-#define	PAGE_AGE_EXPDOWN	2
-#define	PAGE_AGE_LINEAR		3
-#define PAGE_AGE_EXPUP		4
-
-/*
- * We don't know if this is a good default, but it's what
- * all the 2.4 kernels have been using up to now.
- */
-int vm_page_aging_tactic = PAGE_AGE_EXPDOWN;
-
 static inline void age_page_up(struct page *page)
 {
-	unsigned long age;
-	switch (vm_page_aging_tactic) {
-		case PAGE_AGE_NULL:
-			page->age = 0;
-			break;
-		case PAGE_AGE_EXPUP:
-			age = page->age;
-			age *= 2;
-			if (!age)
-				age = 1;
-			goto max_age_check;
-		case PAGE_AGE_SINGLEBIT:
-		case PAGE_AGE_EXPDOWN:
-		case PAGE_AGE_LINEAR:
-		default:
-			age = page->age + PAGE_AGE_ADV;
-max_age_check:
-			if (age > PAGE_AGE_MAX)
-				age = PAGE_AGE_MAX;
-			page->age = age;
-			break;
-	}
+	unsigned long age = page->age;
+	age += PAGE_AGE_ADV;
+	if (age > PAGE_AGE_MAX)
+		age = PAGE_AGE_MAX;
+	page->age = age;
 }

 static inline void age_page_down(struct page *page)
 {
-	switch (vm_page_aging_tactic) {
-		case PAGE_AGE_LINEAR:
-		case PAGE_AGE_EXPUP:
-			if (page->age)
-				page->age -= PAGE_AGE_DECL;
-			break;
-		case PAGE_AGE_EXPDOWN:
-		default:
-			page->age /= 2;
-			break;
-		case PAGE_AGE_NULL:
-		case PAGE_AGE_SINGLEBIT:
-			page->age = 0;
-			break;
-	}
+	unsigned long age = page->age;
+	if (age > 0)
+		age -= PAGE_AGE_DECL;
+	page->age = age;
 }

 /*
@@ -120,6 +71,29 @@
 }

 /*
+ * In general, page aging can balance the various uses of memory
+ * nicely, but sometimes the caches have so much activity that
+ * they push out other things and influence system behaviour in
+ * a bad way.  If we have too much of a certain cache, we just
+ * bypass page aging and drop cache pages a bit faster.
+ */
+static inline int too_many_buffers(void)
+{
+	int bufferpages = atomic_read(&buffermem_pages);
+	int limit = num_physpages * buffer_mem.borrow_percent / 100;
+
+	return bufferpages > limit;
+}
+
+static inline int pagecache_too_large(void)
+{
+	int pagecache = atomic_read(&page_cache_size) - swapper_space.nrpages;
+	int limit = num_physpages * page_cache.borrow_percent / 100;
+
+	return pagecache > limit;
+}
+
+/*
  * The swap-out function returns 1 if it successfully
  * scanned all the pages it was asked to (`count').
  * It returns zero if it couldn't do anything,
@@ -134,6 +108,23 @@
 	pte_t pte;
 	swp_entry_t entry;

+	/* Don't look at this pte if it's been accessed recently. */
+	if (ptep_test_and_clear_young(page_table)) {
+		age_page_up(page);
+		return;
+	}
+
+	/*
+	 * If the page is on the active list, page aging is done in
+	 * refill_inactive_scan(), anonymous pages are aged here.
+	 * This is done so heavily shared pages (think libc.so)
+	 * don't get punished heavily while they are still in use.
+	 * The alternative would be to put anonymous pages on the
+	 * active list too, but that increases complexity (for now).
+	 */
+	if (!PageActive(page))
+		age_page_down(page);
+
 	/*
 	 * If we have plenty inactive pages on this
 	 * zone, skip it.
@@ -141,12 +132,11 @@
 	if (zone_inactive_plenty(page->zone))
 		return;

-	/* Don't look at this pte if it's been accessed recently. */
-	if (ptep_test_and_clear_young(page_table)) {
-		age_page_up(page);
-		if (vm_page_aging_tactic != PAGE_AGE_NULL)
-			return;
-	}
+	/*
+	 * Don't swap out a page which is still in use.
+	 */
+	if (page->age > 0)
+		return;

 	if (TryLockPage(page))
 		return;
@@ -363,7 +353,6 @@
 	return !count;
 }

-#define SWAP_MM_SHIFT	4
 #define SWAP_SHIFT	5
 #define SWAP_MIN	8

@@ -392,7 +381,7 @@
 		retval = swap_out_mm(mm, swap_amount(mm));

 	/* Then, look at the other mm's */
-	counter = (mmlist_nr << SWAP_MM_SHIFT) >> priority;
+	counter = (mmlist_nr << SWAP_SHIFT) >> priority;
 	do {
 		spin_lock(&mmlist_lock);
 		mm = swap_mm;
@@ -490,7 +479,6 @@
 	goto out;

 found_page:
-	memory_pressure++;
 	del_page_from_inactive_clean_list(page);
 	UnlockPage(page);
 	page->age = PAGE_AGE_START;
@@ -591,7 +579,12 @@
 			continue;
 		}

-		/* Page is or was in use?  Move it to the active list. */
+		/*
+		 * If the page is or was in use, we move it to the active
+		 * list. Note that pages in use by processes can easily
+		 * end up here to be unmapped later, but we just don't
+		 * want them clogging up the inactive list.
+		 */
 		if ((PageReferenced(page) || page->age > 0 ||
 				page_count(page) > (1 + !!page->buffers) ||
 				page_ramdisk(page)) && !PageLocked(page)) {
@@ -608,7 +601,6 @@
 		 * one, we skip it since we cannot move it to the
 		 * inactive clean list --- we have to free it.
 		 */
-
 		if (zone_free_plenty(page->zone)) {
 			if (!page->mapping || page_dirty(page)) {
 				list_del(page_lru);
@@ -798,14 +790,11 @@
  * This function will scan a portion of the active list to find
  * unused pages, those pages will then be moved to the inactive list.
  */
-#define too_many_buffers (atomic_read(&buffermem_pages) > \
-		(num_physpages * buffer_mem.borrow_percent / 100))
 int refill_inactive_scan(unsigned int priority)
 {
 	struct list_head * page_lru;
 	struct page * page;
 	int maxscan = nr_active_pages >> priority;
-	int page_active = 0;
 	int nr_deactivated = 0;

 	/* Take the lock while messing with the list... */
@@ -826,33 +815,16 @@
 		 * plenty inactive pages.
 		 */
 		if (zone_inactive_plenty(page->zone)) {
-			page_active = 1;
 			goto skip_page;
 		}

 		/* Do aging on the pages. */
 		if (PageTestandClearReferenced(page)) {
 			age_page_up(page);
-			page_active = vm_page_aging_tactic; /* subtle */
 		} else {
 			age_page_down(page);
-			/*
-			 * Since we don't hold a reference on the page
-			 * ourselves, we have to do our test a bit more
-			 * strict then deactivate_page(). This is needed
-			 * since otherwise the system could hang shuffling
-			 * unfreeable pages from the active list to the
-			 * inactive_dirty list and back again...
-			 *
-			 * SUBTLE: we can have buffer pages with count 1.
-			 */
-			if (page->age == 0 && page_count(page) <=
-						(page->buffers ? 2 : 1)) {
+			if (!page->age)
 				deactivate_page_nolock(page);
-				page_active = 0;
-			} else {
-				page_active = 1;
-			}
 		}

 		/*
@@ -861,10 +833,16 @@
 		 * find to the inactive list. Eventually they'll
 		 * be reclaimed there...
 		 */
-		if (page->buffers && !page->mapping && too_many_buffers) {
+		if (page->buffers && !page->mapping && too_many_buffers())
+			deactivate_page_nolock(page);
+
+		/*
+		 * If the page cache is too large, we deactivate all
+		 * page cache pages which are not in use by a process.
+		 */
+		if (pagecache_too_large() && page->mapping &&
+				page_count(page) <= (page->buffers ? 2 : 1))
 			deactivate_page_nolock(page);
-			page_active = 0;
-		}

 		/*
 		 * If the page is still on the active list, move it
@@ -872,7 +850,7 @@
 		 * we have done enough work.
 		 */
 skip_page:
-		if (page_active || PageActive(page)) {
+		if (PageActive(page)) {
 			list_del(page_lru);
 			list_add(page_lru, &active_list);
 		} else {
@@ -1108,9 +1086,6 @@
 		/* Once a second ... */
 		if (time_after(jiffies, recalc + HZ)) {
 			recalc = jiffies;
-
-			/* Recalculate VM statistics. */
-			recalculate_vm_stats();

 			/* Do background page aging. */
 			refill_inactive_scan(DEF_PRIORITY);
--- linux-2.4.9-ac12/include/linux/mm.h.orig	Wed Sep 19 12:15:38 2001
+++ linux-2.4.9-ac12/include/linux/mm.h	Wed Sep 19 14:06:09 2001
@@ -278,7 +278,7 @@
 #define PG_referenced		 2
 #define PG_uptodate		 3
 #define PG_dirty		 4
-#define PG_decr_after		 5
+#define PG_unused_1		 5
 #define PG_active		 6
 #define PG_inactive_dirty	 7
 #define PG_slab			 8
@@ -332,9 +332,6 @@
 #define SetPageReferenced(page)	set_bit(PG_referenced, &(page)->flags)
 #define ClearPageReferenced(page)	clear_bit(PG_referenced, &(page)->flags)
 #define PageTestandClearReferenced(page)	test_and_clear_bit(PG_referenced, &(page)->flags)
-#define PageDecrAfter(page)	test_bit(PG_decr_after, &(page)->flags)
-#define SetPageDecrAfter(page)	set_bit(PG_decr_after, &(page)->flags)
-#define PageTestandClearDecrAfter(page)	test_and_clear_bit(PG_decr_after, &(page)->flags)
 #define PageSlab(page)		test_bit(PG_slab, &(page)->flags)
 #define PageSwapCache(page)	test_bit(PG_swap_cache, &(page)->flags)
 #define PageReserved(page)	test_bit(PG_reserved, &(page)->flags)
@@ -369,6 +366,20 @@

 #define SetPageReserved(page)		set_bit(PG_reserved, &(page)->flags)
 #define ClearPageReserved(page)		clear_bit(PG_reserved, &(page)->flags)
+
+/*
+ * Called whenever the VM references a page. We immediately reclaim
+ * the inactive clean pages because those are counted as freeable.
+ * We don't particularly care about the inactive dirty ones because
+ * we're never sure if those are freeable anyway.
+ */
+static inline void touch_page(struct page * page)
+{
+	if (PageInactiveClean(page))
+		activate_page(page);
+	else
+		SetPageReferenced(page);
+}

 /*
  * Error return values for the *_nopage functions
--- linux-2.4.9-ac12/include/linux/swap.h.orig	Wed Sep 19 12:15:41 2001
+++ linux-2.4.9-ac12/include/linux/swap.h	Wed Sep 19 13:55:54 2001
@@ -87,7 +87,6 @@
 extern unsigned int nr_free_buffer_pages(void);
 extern int nr_active_pages;
 extern int nr_inactive_dirty_pages;
-extern atomic_t nr_async_pages;
 extern struct address_space swapper_space;
 extern atomic_t page_cache_size;
 extern atomic_t buffermem_pages;
@@ -107,7 +106,6 @@
 struct zone_t;

 /* linux/mm/swap.c */
-extern int memory_pressure;
 extern void deactivate_page(struct page *);
 extern void deactivate_page_nolock(struct page *);
 extern void activate_page(struct page *);
@@ -115,7 +113,6 @@
 extern void lru_cache_add(struct page *);
 extern void __lru_cache_del(struct page *);
 extern void lru_cache_del(struct page *);
-extern void recalculate_vm_stats(void);
 extern void swap_setup(void);

 /* linux/mm/vmscan.c */
@@ -193,11 +190,10 @@
 extern spinlock_t pagemap_lru_lock;

 /*
- * Page aging defines.
- * Since we do exponential decay of the page age, we
- * can chose a fairly large maximum.
+ * Page aging defines. These seem to work great in FreeBSD,
+ * no need to reinvent the wheel.
  */
-#define PAGE_AGE_START 2
+#define PAGE_AGE_START 5
 #define PAGE_AGE_ADV 3
 #define PAGE_AGE_DECL 1
 #define PAGE_AGE_MAX 64
@@ -264,32 +260,17 @@
 }

 /*
- * In mm/swap.c::recalculate_vm_stats(), we substract
- * inactive_target from memory_pressure every second.
- * This means that memory_pressure is smoothed over
- * 64 (1 << INACTIVE_SHIFT) seconds.
- */
-#define INACTIVE_SHIFT 6
-
-/*
  * The target size for the inactive list, in pages.
  *
  * If the user specified a target in /proc/sys/vm/static_inactive_target
- * we use that, otherwise we calculate one second of page replacement
- * activity (memory pressure) capped to 1/4th of physical memory.
+ * we use that, otherwise we use 1/4th of physical memory.
  */
 static inline int inactive_target(void)
 {
-	int target;
-
 	if (vm_static_inactive_target)
 		return vm_static_inactive_target;

-	target = memory_pressure >> INACTIVE_SHIFT;
-	if (target > num_physpages / 4)
-		target = num_physpages / 4;
-
-	return target;
+	return num_physpages / 4;
 }

 /*
--- linux-2.4.9-ac12/include/linux/fs.h.orig	Wed Sep 19 13:46:07 2001
+++ linux-2.4.9-ac12/include/linux/fs.h	Wed Sep 19 13:46:43 2001
@@ -288,7 +288,7 @@

 extern void set_bh_page(struct buffer_head *bh, struct page *page, unsigned long offset);

-#define touch_buffer(bh)	SetPageReferenced(bh->b_page)
+#define touch_buffer(bh)	touch_page(bh->b_page)


 #include <linux/pipe_fs_i.h>

