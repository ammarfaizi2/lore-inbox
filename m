Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132148AbRBEQ0N>; Mon, 5 Feb 2001 11:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130937AbRBEQ0E>; Mon, 5 Feb 2001 11:26:04 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:59894 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S132148AbRBEQZ2>; Mon, 5 Feb 2001 11:25:28 -0500
Date: Mon, 5 Feb 2001 14:23:22 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: LA Walsh <law@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        Delta <birtl00@dmi.usherb.ca>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: System unresponsitive when copying HD/HD
In-Reply-To: <E14PMvB-0001Mq-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102051420250.1311-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Feb 2001, Alan Cox wrote:

> But try 2.4.1 before worrying too much. That fixed a lot of the
> block performance problems I was seeing (2.4.1 ruins the VM
> performance under paging loads but the I/O speed is fixed ;))

The patch below should fix the paging performance.

I haven't had a whole lot of time to test this (and I won't
have much time due to yet another LVM bug making my workstation
unusable under 2.4 ;(), but it seems to curb worst-case behaviour
during heavy swapping and IO load very fine.

On my home machine (64MB K6-2 500) I didn't manage to make my
mp3 skip while under both heavy paging load and heavy IO load
(using a few of the "standard" benchmark programs).

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/



--- linux-2.4.1/fs/buffer.c.orig	Tue Jan 30 18:13:19 2001
+++ linux-2.4.1/fs/buffer.c	Mon Feb  5 09:59:37 2001
@@ -1052,16 +1052,6 @@
 		return 0;
 	}
 
-	/*
-	 * If we are about to get low on free pages and
-	 * cleaning the inactive_dirty pages would help
-	 * fix this, wake up bdflush.
-	 */
-	shortage = free_shortage();
-	if (shortage && nr_inactive_dirty_pages > shortage &&
-			nr_inactive_dirty_pages > freepages.high)
-		return 0;
-
 	return -1;
 }
 
--- linux-2.4.1/mm/filemap.c.orig	Tue Jan 30 17:02:23 2001
+++ linux-2.4.1/mm/filemap.c	Tue Jan 30 17:25:29 2001
@@ -286,6 +286,34 @@
 	spin_unlock(&pagecache_lock);
 }
 
+/*
+ * This function is pretty much like __find_page_nolock(), but it only
+ * requires 2 arguments and doesn't mark the page as touched, making it
+ * ideal for ->writepage() clustering and other places where you don't
+ * want to mark the page referenced.
+ *
+ * The caller needs to hold the pagecache_lock.
+ */
+struct page * __find_page_simple(struct address_space *mapping, unsigned long index)
+{
+	struct page * page = *page_hash(mapping, index);
+	goto inside;
+
+	for (;;) {
+		page = page->next_hash;
+inside:
+		if (!page)
+			goto not_found;
+		if (page->mapping != mapping)
+			continue;
+		if (page->index == index)
+			break;
+	}
+
+not_found:
+	return page;
+}
+
 static inline struct page * __find_page_nolock(struct address_space *mapping, unsigned long offset, struct page *page)
 {
 	goto inside;
@@ -301,13 +329,14 @@
 			break;
 	}
 	/*
-	 * Touching the page may move it to the active list.
-	 * If we end up with too few inactive pages, we wake
-	 * up kswapd.
+	 * Mark the page referenced, moving inactive pages to the
+	 * active list.
 	 */
-	age_page_up(page);
-	if (inactive_shortage() > inactive_target / 2 && free_shortage())
-			wakeup_kswapd();
+	if (!PageActive(page))
+		activate_page(page);
+	else
+		SetPageReferenced(page);
+
 not_found:
 	return page;
 }
@@ -735,7 +764,6 @@
 {
 	struct inode *inode = file->f_dentry->d_inode;
 	struct address_space *mapping = inode->i_mapping;
-	struct page **hash;
 	struct page *page;
 	unsigned long start;
 
@@ -756,8 +784,7 @@
 	 */
 	spin_lock(&pagecache_lock);
 	while (--index >= start) {
-		hash = page_hash(mapping, index);
-		page = __find_page_nolock(mapping, index, *hash);
+		page = __find_page_simple(mapping, index);
 		if (!page)
 			break;
 		deactivate_page(page);
--- linux-2.4.1/mm/page_alloc.c.orig	Tue Jan 30 17:02:23 2001
+++ linux-2.4.1/mm/page_alloc.c	Tue Jan 30 17:54:10 2001
@@ -299,21 +299,6 @@
 			!(current->flags & PF_MEMALLOC))
 		direct_reclaim = 1;
 
-	/*
-	 * If we are about to get low on free pages and we also have
-	 * an inactive page shortage, wake up kswapd.
-	 */
-	if (inactive_shortage() > inactive_target / 2 && free_shortage())
-		wakeup_kswapd();
-	/*
-	 * If we are about to get low on free pages and cleaning
-	 * the inactive_dirty pages would fix the situation,
-	 * wake up bdflush.
-	 */
-	else if (free_shortage() && nr_inactive_dirty_pages > free_shortage()
-			&& nr_inactive_dirty_pages >= freepages.high)
-		wakeup_bdflush(0);
-
 try_again:
 	/*
 	 * First, see if we have any zones with lots of free memory.
--- linux-2.4.1/mm/page_io.c.orig	Tue Jan 30 17:02:23 2001
+++ linux-2.4.1/mm/page_io.c	Tue Jan 30 18:44:11 2001
@@ -42,11 +42,6 @@
 	int block_size;
 	struct inode *swapf = 0;
 
-	/* Don't allow too many pending pages in flight.. */
-	if ((rw == WRITE) && atomic_read(&nr_async_pages) >
-			pager_daemon.swap_cluster * (1 << page_cluster))
-		wait = 1;
-
 	if (rw == READ) {
 		ClearPageUptodate(page);
 		kstat.pswpin++;
--- linux-2.4.1/mm/vmscan.c.orig	Tue Jan 30 17:02:23 2001
+++ linux-2.4.1/mm/vmscan.c	Mon Feb  5 12:20:12 2001
@@ -280,7 +280,7 @@
 		retval = swap_out_mm(mm, swap_amount(mm));
 
 	/* Then, look at the other mm's */
-	counter = mmlist_nr >> priority;
+	counter = (mmlist_nr << SWAP_SHIFT) >> priority;
 	do {
 		struct list_head *p;
 
@@ -412,14 +412,17 @@
  *
  * This code is heavily inspired by the FreeBSD source code. Thanks
  * go out to Matthew Dillon.
+ *
+ * XXX: restrict number of pageouts in flight...
  */
-#define MAX_LAUNDER 		(4 * (1 << page_cluster))
-int page_launder(int gfp_mask, int sync)
+#define MAX_LAUNDER 		(1 << page_cluster)
+int page_launder(int gfp_mask, int user)
 {
-	int launder_loop, maxscan, cleaned_pages, maxlaunder;
-	int can_get_io_locks;
+	int launder_loop, maxscan, flushed_pages, freed_pages, maxlaunder;
+	int can_get_io_locks, sync, target, shortage;
 	struct list_head * page_lru;
 	struct page * page;
+	struct zone_struct * zone;
 
 	/*
 	 * We can only grab the IO locks (eg. for flushing dirty
@@ -427,9 +430,13 @@
 	 */
 	can_get_io_locks = gfp_mask & __GFP_IO;
 
+	target = free_shortage();
+
+	sync = 0;
 	launder_loop = 0;
 	maxlaunder = 0;
-	cleaned_pages = 0;
+	flushed_pages = 0;
+	freed_pages = 0;
 
 dirty_page_rescan:
 	spin_lock(&pagemap_lru_lock);
@@ -437,13 +444,14 @@
 	while ((page_lru = inactive_dirty_list.prev) != &inactive_dirty_list &&
 				maxscan-- > 0) {
 		page = list_entry(page_lru, struct page, lru);
+		zone = page->zone;
 
 		/* Wrong page on list?! (list corruption, should not happen) */
 		if (!PageInactiveDirty(page)) {
 			printk("VM: page_launder, wrong page on list.\n");
 			list_del(page_lru);
 			nr_inactive_dirty_pages--;
-			page->zone->inactive_dirty_pages--;
+			zone->inactive_dirty_pages--;
 			continue;
 		}
 
@@ -457,10 +465,26 @@
 		}
 
 		/*
+		 * Disk IO is really expensive, so we make sure we
+		 * don't do more work than needed.
+		 * Note that clean pages from zones with enough free
+		 * pages still get recycled and dirty pages from these
+		 * zones can get flushed due to IO clustering.
+		 */
+		if (freed_pages + flushed_pages > target && !free_shortage())
+			break;
+		if (launder_loop && !maxlaunder)
+			break;
+		if (launder_loop && zone->inactive_clean_pages +
+				zone->free_pages > zone->pages_high)
+			goto skip_page;
+
+		/*
 		 * The page is locked. IO in progress?
 		 * Move it to the back of the list.
 		 */
 		if (TryLockPage(page)) {
+skip_page:
 			list_del(page_lru);
 			list_add(page_lru, &inactive_dirty_list);
 			continue;
@@ -490,6 +514,7 @@
 			spin_unlock(&pagemap_lru_lock);
 
 			writepage(page);
+			flushed_pages++;
 			page_cache_release(page);
 
 			/* And re-start the thing.. */
@@ -508,7 +533,6 @@
 		 */
 		if (page->buffers) {
 			int wait, clearedbuf;
-			int freed_page = 0;
 			/*
 			 * Since we might be doing disk IO, we have to
 			 * drop the spinlock and take an extra reference
@@ -539,12 +563,12 @@
 			/* The buffers were not freed. */
 			if (!clearedbuf) {
 				add_page_to_inactive_dirty_list(page);
+				flushed_pages++;
 
 			/* The page was only in the buffer cache. */
 			} else if (!page->mapping) {
 				atomic_dec(&buffermem_pages);
-				freed_page = 1;
-				cleaned_pages++;
+				freed_pages++;
 
 			/* The page has more users besides the cache and us. */
 			} else if (page_count(page) > 2) {
@@ -553,7 +577,7 @@
 			/* OK, we "created" a freeable page. */
 			} else /* page->mapping && page_count(page) == 2 */ {
 				add_page_to_inactive_clean_list(page);
-				cleaned_pages++;
+				freed_pages++;
 			}
 
 			/*
@@ -564,13 +588,6 @@
 			UnlockPage(page);
 			page_cache_release(page);
 
-			/* 
-			 * If we're freeing buffer cache pages, stop when
-			 * we've got enough free memory.
-			 */
-			if (freed_page && !free_shortage())
-				break;
-			continue;
 		} else if (page->mapping && !PageDirty(page)) {
 			/*
 			 * If a page had an extra reference in
@@ -581,7 +598,8 @@
 			del_page_from_inactive_dirty_list(page);
 			add_page_to_inactive_clean_list(page);
 			UnlockPage(page);
-			cleaned_pages++;
+			freed_pages++;
+
 		} else {
 page_active:
 			/*
@@ -607,20 +625,49 @@
 	 * loads, flush out the dirty pages before we have to wait on
 	 * IO.
 	 */
-	if (can_get_io_locks && !launder_loop && free_shortage()) {
+	shortage = free_shortage();
+	if (can_get_io_locks && !launder_loop && shortage) {
 		launder_loop = 1;
-		/* If we cleaned pages, never do synchronous IO. */
-		if (cleaned_pages)
-			sync = 0;
-		/* We only do a few "out of order" flushes. */
-		maxlaunder = MAX_LAUNDER;
-		/* Kflushd takes care of the rest. */
-		wakeup_bdflush(0);
+
+		/* 
+		 * User programs can run page_launder() in parallel so
+		 * we only flush a few pages at a time to avoid big IO
+		 * storms.   Kswapd, OTOH, is expected usually keep up
+		 * with the paging load in the system and doesn't have
+		 * the IO storm problem, so it just flushes all pages
+		 * needed to fix the free shortage.
+		 *
+		 * XXX: keep track of nr_async_pages like the old swap
+		 * code did?
+		 */
+		if (user)
+			maxlaunder = MAX_LAUNDER;
+		else
+			maxlaunder = shortage;
+
+		/*
+		 * If we are called by a user program, we need to free
+		 * some pages. If we couldn't, we'll do the last page IO
+		 * synchronously to be sure 
+		 */
+		if (user && !freed_pages)
+			sync = 1;
+
 		goto dirty_page_rescan;
 	}
 
-	/* Return the number of pages moved to the inactive_clean list. */
-	return cleaned_pages;
+	/*
+	 * We have to make sure the data is actually written to
+	 * the disk now, otherwise we'll never get enough clean
+	 * pages and the system will keep queueing dirty pages
+	 * for flushing.
+	 */
+	run_task_queue(&tq_disk);
+
+	/*
+	 * Return the amount of pages we freed or made freeable.
+	 */
+	return freed_pages + flushed_pages;
 }
 
 /**
@@ -631,12 +678,12 @@
  * This function will scan a portion of the active list to find
  * unused pages, those pages will then be moved to the inactive list.
  */
-int refill_inactive_scan(unsigned int priority, int oneshot)
+int refill_inactive_scan(int priority, int target)
 {
 	struct list_head * page_lru;
 	struct page * page;
 	int maxscan, page_active = 0;
-	int ret = 0;
+	int nr_deactivated = 0;
 
 	/* Take the lock while messing with the list... */
 	spin_lock(&pagemap_lru_lock);
@@ -668,31 +715,38 @@
 			 *
 			 * SUBTLE: we can have buffer pages with count 1.
 			 */
-			if (page->age == 0 && page_count(page) <=
-						(page->buffers ? 2 : 1)) {
-				deactivate_page_nolock(page);
-				page_active = 0;
+			if (page->age == 0) {
+				int maxcount = (page->buffers ? 2 : 1);
+				if (page_count(page) <= maxcount) {
+					deactivate_page_nolock(page);
+					page_active = 0;
+				} else {
+					/* Page still in somebody's RSS? */
+					page_active = 1;
+					/* XXX: should we call swap_out() if
+					 * this happens too often ? */
+				}
 			} else {
 				page_active = 1;
 			}
 		}
 		/*
 		 * If the page is still on the active list, move it
-		 * to the other end of the list. Otherwise it was
-		 * deactivated by age_page_down and we exit successfully.
+		 * to the end of the list. Otherwise we successfully
+		 * deactivated a page.
 		 */
 		if (page_active || PageActive(page)) {
 			list_del(page_lru);
 			list_add(page_lru, &active_list);
 		} else {
-			ret = 1;
-			if (oneshot)
+			nr_deactivated++;
+			if (nr_deactivated >= target)
 				break;
 		}
 	}
 	spin_unlock(&pagemap_lru_lock);
 
-	return ret;
+	return nr_deactivated;
 }
 
 /*
@@ -704,7 +758,7 @@
 	pg_data_t *pgdat = pgdat_list;
 	int sum = 0;
 	int freeable = nr_free_pages() + nr_inactive_clean_pages();
-	int freetarget = freepages.high + inactive_target / 3;
+	int freetarget = freepages.high;
 
 	/* Are we low on free pages globally? */
 	if (freeable < freetarget)
@@ -772,38 +826,46 @@
 }
 
 /*
- * We need to make the locks finer granularity, but right
- * now we need this so that we can do page allocations
- * without holding the kernel lock etc.
+ * Refill_inactive is the function used to scan and age the pages in
+ * the processes and the active pages, and to move little-used pages
+ * to the inactive list.
  *
- * We want to try to free "count" pages, and we want to 
- * cluster them so that we get good swap-out behaviour.
+ * When called by kswapd, we try to just deactivate as many pages as
+ * needed. This makes it easy for kswapd to keep up with memory
+ * demand.
  *
- * OTOH, if we're a user process (and not kswapd), we
- * really care about latency. In that case we don't try
- * to free too many pages.
+ * However, when we are called by a user process we have to limit the
+ * amount of work done. This way the process can do its allocation and
+ * continue with its real work sooner. It also helps balancing when we
+ * have multiple processes in try_to_free_pages simultaneously.
  */
 #define DEF_PRIORITY (6)
 static int refill_inactive(unsigned int gfp_mask, int user)
 {
 	int count, start_count, maxtry;
 
-	count = inactive_shortage() + free_shortage();
-	if (user)
+	if (user) {
+		/* user process */
 		count = (1 << page_cluster);
-	start_count = count;
+		maxtry = 6;
+	} else {
+		/* kswapd */
+		count = inactive_shortage() + free_shortage();
+		maxtry = 1 << DEF_PRIORITY;
+	}
 
-	maxtry = 6;
+	start_count = count;
 	do {
 		if (current->need_resched) {
 			__set_current_state(TASK_RUNNING);
 			schedule();
+			if (!inactive_shortage())
+				return 1;
 		}
 
-		while (refill_inactive_scan(DEF_PRIORITY, 1)) {
-			if (--count <= 0)
-				goto done;
-		}
+		count -= refill_inactive_scan(DEF_PRIORITY, count);
+		if (--count <= 0)
+			goto done;
 
 		/* If refill_inactive_scan failed, try to page stuff out.. */
 		swap_out(DEF_PRIORITY, gfp_mask);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
