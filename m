Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315223AbSESTll>; Sun, 19 May 2002 15:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315091AbSESTlB>; Sun, 19 May 2002 15:41:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13828 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315210AbSESTjD>;
	Sun, 19 May 2002 15:39:03 -0400
Message-ID: <3CE8002E.7C9B70C0@zip.com.au>
Date: Sun, 19 May 2002 12:42:38 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 10/15] writeback tuning
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tune up the VM-based writeback a bit.

- Always use the multipage clustered-writeback function from within
  shrink_cache(), even if the page's mapping has a NULL ->vm_writeback().  So
  clustered writeback is turned on for all address_spaces, not just ext2.

  Subtle effect of this change: it is now the case that *all* writeback
  proceeds along the mapping->dirty_pages list.  The orderedness of the page
  LRUs no longer has an impact on disk scheduling.  So we only have one list
  to keep well-sorted rather than two, and churning pages around on the LRU
  will no longer damage write bandwidth - it's all up to the filesystem.

- Decrease the clustered writeback from 1024 pages(!) to 32 pages. 

  (1024 was a leftover from when this code was always dispatching writeback
  to a pdflush thread).

- Fix wakeup_bdflush() so that it actually does write something (duh).

  do_wp_page() needs to call balance_dirty_pages_ratelimited(), so we
  throttle mmap page-dirtiers in the same way as write(2) page-dirtiers. 
  This may make wakeup_bdflush() obsolete, but it doesn't hurt.

- Converts generic_vm_writeback() to directly call ->writeback_mapping(),
  rather that going through writeback_single_inode().  This prevents memory
  allocators from blocking on the inode's I_LOCK.  But it does mean that two
  processes can be writing pages from the same mapping at the same time.  If
  filesystems care about this (for layout reasons) then they should serialise
  in their ->writeback_mapping a_op.

  This means that memory-allocators will writeback only pages, not pages
  and inodes.  There are no locks in that writeback path (except for request
  queue exhaustion).  Reduces memory allocation latency.

- Implement new background_writeback function, which when kicked off
  will perform writeback until dirty memory falls below the background
  threshold.

- Put written-back pages onto the remote end of the page LRU.  It
  does this in the slow-and-stupid way at present.  pagemap_lru_lock
  stress-relief is planned...

- Remove the funny writeback_unused_inodes() stuff from prune_icache(). 
  Writeback from wakeup_bdflush() and the `kupdate' function now just
  naturally cleanses the oldest inodes so we don't need to do anything
  there.

- Dirty memory balancing is still using magic numbers: "after you
  dirtied your 1,000th page, go write 1,500".  Obviously, this needs
  more work.


=====================================

--- 2.5.16/mm/vmscan.c~vm-writeback	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/mm/vmscan.c	Sun May 19 12:02:55 2002
@@ -458,35 +458,20 @@ static int shrink_cache(int nr_pages, zo
 			 * pinned it and after the I/O to the page is finished,
 			 * so the direct writes to the page cannot get lost.
 			 */
-			struct address_space_operations *a_ops;
 			int (*writeback)(struct page *, int *);
-			int (*writepage)(struct page *);
+			const int nr_pages = SWAP_CLUSTER_MAX;
+			int nr_to_write = nr_pages;
 
-			/*
-			 * There's no guarantee that writeback() will actually
-			 * start I/O against *this* page.  Which is broken if we're
-			 * trying to free memory in a particular zone.  FIXME.
-			 */
-			a_ops = mapping->a_ops;
-			writeback = a_ops->vm_writeback;
-			writepage = a_ops->writepage;
-			if (writeback || writepage) {
-				SetPageLaunder(page);
-				page_cache_get(page);
-				spin_unlock(&pagemap_lru_lock);
-				ClearPageDirty(page);
-
-				if (writeback) {
-					int nr_to_write = WRITEOUT_PAGES;
-					writeback(page, &nr_to_write);
-				} else {
-					writepage(page);
-				}
-				page_cache_release(page);
-
-				spin_lock(&pagemap_lru_lock);
-				continue;
-			}
+			writeback = mapping->a_ops->vm_writeback;
+			if (writeback == NULL)
+				writeback = generic_vm_writeback;
+			page_cache_get(page);
+			spin_unlock(&pagemap_lru_lock);
+			(*writeback)(page, &nr_to_write);
+			max_scan -= (nr_pages - nr_to_write);
+			page_cache_release(page);
+			spin_lock(&pagemap_lru_lock);
+			continue;
 		}
 
 		/*
@@ -648,6 +633,8 @@ static int shrink_caches(zone_t * classz
 	if (nr_pages <= 0)
 		return 0;
 
+	wakeup_bdflush();
+
 	shrink_dcache_memory(priority, gfp_mask);
 
 	/* After shrinking the dcache, get rid of unused inodes too .. */
--- 2.5.16/mm/page-writeback.c~vm-writeback	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/mm/page-writeback.c	Sun May 19 12:02:55 2002
@@ -23,6 +23,14 @@
 #include <linux/backing-dev.h>
 
 /*
+ * The maximum number of pages to writeout in a single bdflush/kupdate
+ * operation.  We do this so we don't hold I_LOCK against an inode for
+ * enormous amounts of time, which would block a userspace task which has
+ * been forced to throttle against that inode.
+ */
+#define MAX_WRITEBACK_PAGES	1024
+
+/*
  * Memory thresholds, in percentages
  * FIXME: expose these via /proc or whatever.
  */
@@ -42,6 +50,8 @@ static int dirty_async_ratio = 50;
  */
 static int dirty_sync_ratio = 60;
 
+static void background_writeout(unsigned long unused);
+
 /*
  * balance_dirty_pages() must be called by processes which are
  * generating dirty data.  It looks at the number of dirty pages
@@ -54,15 +64,16 @@ static int dirty_sync_ratio = 60;
  * - Does nothing at all.
  *
  * balance_dirty_pages() can sleep.
+ *
+ * FIXME: WB_SYNC_LAST doesn't actually work.  It waits on the last dirty
+ * inode on the superblock list.  It should wait when nr_to_write is
+ * exhausted.  Doesn't seem to matter.
  */
 void balance_dirty_pages(struct address_space *mapping)
 {
 	const int tot = nr_free_pagecache_pages();
 	struct page_state ps;
-	int background_thresh;
-	int async_thresh;
-	int sync_thresh;
-	int wake_pdflush = 0;
+	int background_thresh, async_thresh, sync_thresh;
 	unsigned long dirty_and_writeback;
 
 	get_page_state(&ps);
@@ -77,27 +88,27 @@ void balance_dirty_pages(struct address_
 
 		writeback_unlocked_inodes(&nr_to_write, WB_SYNC_LAST, NULL);
 		get_page_state(&ps);
-		dirty_and_writeback = ps.nr_dirty + ps.nr_writeback;
-		wake_pdflush = 1;
 	} else if (dirty_and_writeback > async_thresh) {
 		int nr_to_write = 1500;
 
 		writeback_unlocked_inodes(&nr_to_write, WB_SYNC_NONE, NULL);
-	} else if (dirty_and_writeback > background_thresh) {
-		wake_pdflush = 1;
+		get_page_state(&ps);
 	}
 
-	if (wake_pdflush && !writeback_in_progress(mapping->backing_dev_info)) {
-		if (dirty_and_writeback > async_thresh) {
-			pdflush_flush(dirty_and_writeback - async_thresh);
-			yield();
-		}
-	}
+	if (!writeback_in_progress(mapping->backing_dev_info) &&
+				ps.nr_dirty > background_thresh)
+		pdflush_operation(background_writeout, 0);
 }
 
-/*
- * Front-end to balance_dirty_pages - just to make sure it's not called
- * too often.
+/**
+ * balance_dirty_pages_ratelimited - balance dirty memory state
+ * @mapping - address_space which was dirtied
+ *
+ * Processes which are dirtying memory should call in here once for each page
+ * which was newly dirtied.  The function will periodically check the system's
+ * dirty state and will initiate writeback if needed.
+ *
+ * balance_dirty_pages_ratelimited() may sleep.
  */
 void balance_dirty_pages_ratelimited(struct address_space *mapping)
 {
@@ -118,39 +129,38 @@ void balance_dirty_pages_ratelimited(str
 }
 
 /*
- * Here are some applications of the pdflush thread pool
- */
-
-/*
- * Start heavy writeback of everything.  This is the analogue of the old
- * wakeup_bdflush().  Returns zero if a thread was successfully launched.
- *
- * Is passed in the number of pages to write.
- *
- * We yield, to allow page allocators to perform their I/O against large files.
+ * writeback at least _min_pages, and keep writing until the amount of dirty
+ * memory is less than the background threshold, or until we're all clean.
  */
-
-static void pdflush_bdflush(unsigned long arg)
+static void background_writeout(unsigned long _min_pages)
 {
-	int nr_pages = arg;
-
-	CHECK_EMERGENCY_SYNC
+	const int tot = nr_free_pagecache_pages();
+	const int background_thresh = (dirty_background_ratio * tot) / 100;
+	long min_pages = _min_pages;
+	int nr_to_write;
 
-	while (nr_pages) {
-		int nr_to_write = WRITEOUT_PAGES;
+	do {
+		struct page_state ps;
 
-		if (nr_to_write > nr_pages)
-			nr_to_write = nr_pages;
-		nr_pages -= nr_to_write;
+		get_page_state(&ps);
+		if (ps.nr_dirty < background_thresh && min_pages <= 0)
+			break;
+		nr_to_write = MAX_WRITEBACK_PAGES;
 		writeback_unlocked_inodes(&nr_to_write, WB_SYNC_NONE, NULL);
-		yield();
-	}
+		min_pages -= MAX_WRITEBACK_PAGES - nr_to_write;
+	} while (nr_to_write <= 0);
 	run_task_queue(&tq_disk);
 }
 
-int pdflush_flush(unsigned long nr_pages)
+/*
+ * Start heavy writeback of everything.
+ */
+void wakeup_bdflush(void)
 {
-	return pdflush_operation(pdflush_bdflush, nr_pages);
+	struct page_state ps;
+
+	get_page_state(&ps);
+	pdflush_operation(background_writeout, ps.nr_dirty);
 }
 
 /*
@@ -174,43 +184,41 @@ static struct timer_list wb_timer;
  * just walks the superblock inode list, writing back any inodes which are
  * older than a specific point in time.
  *
- * We also limit the number of pages which are written out, to avoid writing
- * huge amounts of data against a single file, which would cause memory
- * allocators to block for too long.
+ * Try to run once per wb_writeback_jifs jiffies.  But if a writeback event
+ * takes longer than a wb_writeback_jifs interval, then leave a one-second
+ * gap.
+ *
+ * older_than_this takes precedence over nr_to_write.  So we'll only write back
+ * all dirty pages if they are all attached to "old" mappings.
  */
 static void wb_kupdate(unsigned long arg)
 {
-	unsigned long oldest_jif = jiffies - 30*HZ;
+	unsigned long oldest_jif;
+	unsigned long start_jif;
+	unsigned long next_jif;
 	struct page_state ps;
-	int total_to_write;
 	int nr_to_write;
 
 	sync_supers();
-
 	get_page_state(&ps);
 
-	total_to_write = ps.nr_dirty / 6;
-	if (total_to_write < 16384) {
-		total_to_write = 16384;
-		if (total_to_write > ps.nr_dirty)
-			total_to_write = ps.nr_dirty;
-	}
-	while (total_to_write > 0) {
-		nr_to_write = total_to_write;
-		if (nr_to_write > WRITEOUT_PAGES)
-			nr_to_write = WRITEOUT_PAGES;
-		total_to_write -= nr_to_write;
-		writeback_unlocked_inodes(&nr_to_write,
-				WB_SYNC_NONE, &oldest_jif);
-		yield();
-	}
+	oldest_jif = jiffies - 30*HZ;
+	start_jif = jiffies;
+	next_jif = start_jif + wb_writeback_jifs;
+	nr_to_write = ps.nr_dirty;
+	writeback_unlocked_inodes(&nr_to_write, WB_SYNC_NONE, &oldest_jif);
 	run_task_queue(&tq_disk);
-	mod_timer(&wb_timer, jiffies + wb_writeback_jifs);
+	yield();
+
+	if (time_before(next_jif, jiffies + HZ))
+		next_jif = jiffies + HZ;
+	mod_timer(&wb_timer, next_jif);
 }
 
 static void wb_timer_fn(unsigned long unused)
 {
-	pdflush_operation(wb_kupdate, 0);
+	if (pdflush_operation(wb_kupdate, 0) < 0)
+		mod_timer(&wb_timer, jiffies + HZ);
 }
 
 static int __init wb_timer_init(void)
@@ -225,23 +233,42 @@ static int __init wb_timer_init(void)
 module_init(wb_timer_init);
 
 /*
- * FIXME: PG_launder gets cleared by accident.
+ * A library function, which implements the vm_writeback a_op.  It's fairly
+ * lame at this time.  The idea is: the VM wants to liberate this page,
+ * so we pass the page to the address_space and give the fs the opportunity
+ * to write out lots of pages around this one.  It allows extent-based
+ * filesytems to do intelligent things.  It lets delayed-allocate filesystems
+ * perform better file layout.  It lets the address_space opportunistically
+ * write back disk-contiguous pages which are in other zones.
+ *
+ * FIXME: the VM wants to start I/O against *this* page.  Because its zone
+ * is under pressure.  But this function may start writeout against a
+ * totally different set of pages.  Unlikely to be a huge problem, but if it
+ * is, we could just writepage the page if it is still (PageDirty &&
+ * !PageWriteback) (See below).
+ *
+ * Another option is to just reposition page->mapping->dirty_pages so we
+ * *know* that the page will be written.  That will work fine, but seems
+ * unpleasant.  (If the page is not for-sure on ->dirty_pages we're dead).
+ * Plus it assumes that the address_space is performing writeback in
+ * ->dirty_pages order.
+ *
+ * So.  The proper fix is to leave the page locked-and-dirty and to pass
+ * it all the way down.
  */
-static int writeback_mapping(struct page *page, int *nr_to_write)
+int generic_vm_writeback(struct page *page, int *nr_to_write)
 {
 	struct inode *inode = page->mapping->host;
 
-	SetPageDirty(page);
-
 	/*
-	 * We don't own this inode, so we don't want the address_space
-	 * vanishing while writeback is walking the list
+	 * We don't own this inode, and we don't want the address_space
+	 * vanishing while writeback is walking its pages.
 	 */
 	inode = igrab(inode);
 	unlock_page(page);
 
 	if (inode) {
-		writeback_single_inode(inode, 0, nr_to_write);
+		writeback_mapping(inode->i_mapping, nr_to_write);
 
 		/*
 		 * This iput() will internally call ext2_discard_prealloc(),
@@ -251,23 +278,18 @@ static int writeback_mapping(struct page
 		 * Just a waste of cycles.
 		 */
 		iput(inode);
+#if 0
+		if (!PageWriteback(page) && PageDirty(page)) {
+			lock_page(page);
+			if (!PageWriteback(page) && TestClearPageDirty(page))
+				page->mapping->a_ops->writepage(page);
+			else
+				unlock_page(page);
+		}
+#endif
 	}
 	return 0;
 }
-
-/*
- * A library function, which implements the vm_writeback a_op.  It's fairly
- * lame at this time.  The idea is: the VM wants to liberate this page,
- * so we pass the page to the address_space and give the fs the opportunity
- * to write out lots of pages around this one.  It allows extent-based
- * filesytems to do intelligent things.  It lets delayed-allocate filesystems
- * perform better file layout.  It lets the address_space opportunistically
- * write back disk-contiguous pages which are in other zones.
- */
-int generic_vm_writeback(struct page *page, int *nr_to_write)
-{
-	return writeback_mapping(page, nr_to_write);
-}
 EXPORT_SYMBOL(generic_vm_writeback);
 
 /**
@@ -278,8 +300,7 @@ EXPORT_SYMBOL(generic_vm_writeback);
  * @nr_to_write: subtract the number of written pages from *@nr_to_write
  *
  * This is a library function, which implements the writeback_mapping()
- * address_space_operation for filesystems which are using multipage BIO
- * writeback.
+ * address_space_operation.
  *
  * (The next two paragraphs refer to code which isn't here yet, but they
  *  explain the presence of address_space.io_pages)
@@ -309,10 +330,10 @@ EXPORT_SYMBOL(generic_vm_writeback);
  */
 int generic_writeback_mapping(struct address_space *mapping, int *nr_to_write)
 {
+	int (*writepage)(struct page *) = mapping->a_ops->writepage;
 	int ret = 0;
 	int done = 0;
 	int err;
-	int (*writepage)(struct page *) = mapping->a_ops->writepage;
 
 	write_lock(&mapping->page_lock);
 
@@ -336,23 +357,29 @@ int generic_writeback_mapping(struct add
 			continue;
 		}
 		list_add(&page->list, &mapping->locked_pages);
-
 		page_cache_get(page);
 		write_unlock(&mapping->page_lock);
-
 		lock_page(page);
 
-		if (TestClearPageDirty(page)) {
+		/* It may have been removed from swapcache: check ->mapping */
+		if (page->mapping && TestClearPageDirty(page) &&
+					!PageWriteback(page)) {
+			/* FIXME: batch this up */
+			if (!PageActive(page) && PageLRU(page)) {
+				spin_lock(&pagemap_lru_lock);
+				if (!PageActive(page) && PageLRU(page)) {
+					list_del(&page->lru);
+					list_add(&page->lru, &inactive_list);
+				}
+				spin_unlock(&pagemap_lru_lock);
+			}
 			if (current->flags & PF_MEMALLOC)
 				SetPageLaunder(page);
 			err = writepage(page);
 			if (!ret)
 				ret = err;
-			if (nr_to_write) {
-				--(*nr_to_write);
-				if (*nr_to_write <= 0)
-					done = 1;
-			}
+			if (nr_to_write && --(*nr_to_write) <= 0)
+				done = 1;
 		} else {
 			unlock_page(page);
 		}
@@ -372,14 +399,20 @@ int generic_writeback_mapping(struct add
 }
 EXPORT_SYMBOL(generic_writeback_mapping);
 
+int writeback_mapping(struct address_space *mapping, int *nr_to_write)
+{
+	if (mapping->a_ops->writeback_mapping)
+		return mapping->a_ops->writeback_mapping(mapping, nr_to_write);
+	return generic_writeback_mapping(mapping, nr_to_write);
+}
+
 /**
  * write_one_page - write out a single page and optionally wait on I/O
  *
  * @page - the page to write
  * @wait - if true, wait on writeout
  *
- * The page must be locked by the caller and will come unlocked when I/O
- * completes.
+ * The page must be locked by the caller and will be unlocked upon return.
  *
  * write_one_page() returns a negative error code if I/O failed.
  */
--- 2.5.16/include/linux/writeback.h~vm-writeback	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/include/linux/writeback.h	Sun May 19 12:02:57 2002
@@ -46,17 +46,9 @@ static inline void wait_on_inode(struct 
 /*
  * mm/page-writeback.c
  */
-/*
- * How much data to write out at a time in various places.  This isn't
- * really very important - it's just here to prevent any thread from
- * locking an inode for too long and blocking other threads which wish
- * to write the same file for allocation throttling purposes.
- */
-#define WRITEOUT_PAGES	((4096 * 1024) / PAGE_CACHE_SIZE)
-
 void balance_dirty_pages(struct address_space *mapping);
 void balance_dirty_pages_ratelimited(struct address_space *mapping);
-int pdflush_flush(unsigned long nr_pages);
 int pdflush_operation(void (*fn)(unsigned long), unsigned long arg0);
+int writeback_mapping(struct address_space *mapping, int *nr_to_write);
 
 #endif		/* WRITEBACK_H */
--- 2.5.16/fs/buffer.c~vm-writeback	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/fs/buffer.c	Sun May 19 12:02:57 2002
@@ -2408,11 +2408,6 @@ asmlinkage long sys_bdflush(int func, lo
 	return 0;
 }
 
-void wakeup_bdflush(void)
-{
- 	pdflush_flush(0);
-}
-
 /*
  * Buffer-head allocation
  */
--- 2.5.16/mm/swap_state.c~vm-writeback	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/mm/swap_state.c	Sun May 19 11:49:48 2002
@@ -31,7 +31,25 @@ static int swap_writepage(struct page *p
 	return 0;
 }
 
+/*
+ * swapper_space doesn't have a real inode, so it gets a special vm_writeback()
+ * so we don't need swap special cases in generic_vm_writeback().
+ *
+ * FIXME: swap pages are locked, but not PageWriteback while under writeout.
+ * This will confuse throttling in shrink_cache().  It may be advantageous to
+ * set PG_writeback against swap pages while they're also locked.  Either that,
+ * or special-case swap pages in shrink_cache().
+ */
+static int swap_vm_writeback(struct page *page, int *nr_to_write)
+{
+	struct address_space *mapping = page->mapping;
+
+	unlock_page(page);
+	return generic_writeback_mapping(mapping, nr_to_write);
+}
+
 static struct address_space_operations swap_aops = {
+	vm_writeback: swap_vm_writeback,
 	writepage: swap_writepage,
 	sync_page: block_sync_page,
 };
--- 2.5.16/mm/filemap.c~vm-writeback	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/mm/filemap.c	Sun May 19 12:02:55 2002
@@ -453,9 +453,7 @@ EXPORT_SYMBOL(fail_writepage);
  */
 int filemap_fdatawrite(struct address_space *mapping)
 {
-	if (mapping->a_ops->writeback_mapping)
-		return mapping->a_ops->writeback_mapping(mapping, NULL);
-	return generic_writeback_mapping(mapping, NULL);
+	return writeback_mapping(mapping, NULL);
 }
 
 /**
--- 2.5.16/fs/inode.c~vm-writeback	Sun May 19 11:49:48 2002
+++ 2.5.16-akpm/fs/inode.c	Sun May 19 12:02:57 2002
@@ -402,14 +402,6 @@ void prune_icache(int goal)
 	spin_unlock(&inode_lock);
 
 	dispose_list(freeable);
-
-	/* 
-	 * If we didn't free enough clean inodes then schedule writeback of
-	 * the dirty inodes.  We cannot do it from here or we're either
-	 * synchronously dogslow or we deadlock with oom.
-	 */
-	if (goal)
-		pdflush_operation(try_to_writeback_unused_inodes, 0);
 }
 
 /*

-
