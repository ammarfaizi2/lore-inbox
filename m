Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbTGIIdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 04:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265833AbTGIIdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 04:33:44 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:52906 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265823AbTGIIcb
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Wed, 9 Jul 2003 04:32:31 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16139.54921.640901.797268@laputa.namesys.com>
Date: Wed, 9 Jul 2003 12:47:05 +0400
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: [PATCH] 2/5 VM changes: skip-writepage.patch
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't call ->writepage from VM scanner when page is met for the first time
during scan.

New page flag PG_skipped is used for this. This flag is TestSet-ed just
before calling ->writepage and is cleaned when page enters inactive
list.

One can see this as "second chance" algorithm for the dirty pages on the
inactive list.

BSD does the same: src/sys/vm/vm_pageout.c:vm_pageout_scan(),
PG_WINATCFLS flag.

Reason behind this is that ->writepages() will perform more efficient writeout
than ->writepage(). Skipping of page can be conditioned on zone->pressure.

On the other hand, avoiding ->writepage() increases amount of scanning
performed by kswapd.

Results of copying 400M * 10 from ramfs to ext2 (512M of ram), averaged over 6
runs:

without patch:

           ELAPSED SYSTEM USER
TIME       255.649 42.734 5.403
DEVIATION   10.516  0.948 0.078

with patch:

TIME       158.847 51.059 5.590
DEVIATION    4.400  0.251 0.123





diff -puN mm/vmscan.c~skip-writepage mm/vmscan.c
--- i386/mm/vmscan.c~skip-writepage	Wed Jul  9 12:24:50 2003
+++ i386-god/mm/vmscan.c	Wed Jul  9 12:24:51 2003
@@ -232,6 +232,104 @@ static int may_write_to_queue(struct bac
 	return 0;
 }
 
+/* possible outcome of pageout() */
+typedef enum {
+	/* failed to write page out, page is locked */
+	PAGE_KEEP,
+	/* move page to the active list, page is locked */
+	PAGE_ACTIVATE,
+	/* page has been sent to the disk successfully, page is unlocked */
+	PAGE_SUCCESS,
+	/* page is clean and locked */
+	PAGE_CLEAN
+} pageout_t;
+
+
+/*
+ * Called by shrink_list() for each dirty page. Calls ->writepage().
+ */
+static pageout_t pageout(struct page *page)
+{
+	struct address_space *mapping = page->mapping;
+
+	/*
+	 * If the page is dirty, only perform writeback if that write will be
+	 * non-blocking.  To prevent this allocation from being stalled by
+	 * pagecache activity.  But note that there may be stalls if we need
+	 * to run get_block().  We could test PagePrivate for that.
+	 *
+	 * If this process is currently in generic_file_write() against this
+	 * page's queue, we can perform writeback even if that will block.
+	 *
+	 * If the page is swapcache, write it back even if that would block,
+	 * for some throttling. This happens by accident, because
+	 * swap_backing_dev_info is bust: it doesn't reflect the congestion
+	 * state of the swapdevs.  Easy to fix, if needed.  See
+	 * swapfile.c:page_queue_congested().
+	 */
+	if (!is_page_cache_freeable(page))
+		return PAGE_KEEP;
+	if (!mapping)
+		return PAGE_KEEP;
+	if (mapping->a_ops->writepage == NULL)
+		return PAGE_ACTIVATE;
+	if (!may_write_to_queue(mapping->backing_dev_info))
+		return PAGE_KEEP;
+	/*
+	 * Don't call ->writepage when page is met for the first time during
+	 * scanning. Reasons:
+	 *
+	 *     1. if memory pressure is not too high, skipping ->writepage()
+	 *     may avoid writing out page that will be re-dirtied (should not
+	 *     be too important, because scanning starts from the tail of
+	 *     inactive list, where pages are _supposed_ to be rarely used,
+	 *     but when under constant memory pressure, inactive list is
+	 *     rotated and so is more FIFO than LRU).
+	 *
+	 *     2. ->writepages() writes data more efficiently than
+	 *     ->writepage().
+	 */
+	if (!TestSetPageSkipped(page))
+		return PAGE_KEEP;
+	spin_lock(&mapping->page_lock);
+	if (test_clear_page_dirty(page)) {
+		int res;
+		int is_async = current_is_kswapd() || current_is_pdflush();
+
+		struct writeback_control wbc = {
+			.sync_mode = WB_SYNC_NONE,
+			.nr_to_write = SWAP_CLUSTER_MAX,
+			/*
+			 * synchronous page reclamation should be non blocking
+			 * for the reasons outlined in the comment above. But
+			 * in the asynchronous daemons blocking is ok.
+			 */
+			.nonblocking = !is_async,
+			.for_reclaim = 1 /* XXX not used */
+		};
+
+		list_move(&page->list, &mapping->locked_pages);
+		spin_unlock(&mapping->page_lock);
+
+		SetPageReclaim(page);
+		res = mapping->a_ops->writepage(page, &wbc);
+
+		if (res == WRITEPAGE_ACTIVATE) {
+			ClearPageReclaim(page);
+			return PAGE_ACTIVATE;
+		}
+		if (!PageWriteback(page)) {
+			/* synchronous write or broken a_ops? */
+			ClearPageReclaim(page);
+		}
+		return PAGE_SUCCESS;
+	}
+	spin_unlock(&mapping->page_lock);
+	return PAGE_CLEAN;
+}
+
+
+
 /*
  * shrink_list returns the number of reclaimed pages
  */
@@ -313,62 +411,24 @@ shrink_list(struct list_head *page_list,
 		pte_chain_unlock(page);
 
 		/*
-		 * If the page is dirty, only perform writeback if that write
-		 * will be non-blocking.  To prevent this allocation from being
-		 * stalled by pagecache activity.  But note that there may be
-		 * stalls if we need to run get_block().  We could test
-		 * PagePrivate for that.
-		 *
-		 * If this process is currently in generic_file_write() against
-		 * this page's queue, we can perform writeback even if that
-		 * will block.
-		 *
-		 * If the page is swapcache, write it back even if that would
-		 * block, for some throttling. This happens by accident, because
-		 * swap_backing_dev_info is bust: it doesn't reflect the
-		 * congestion state of the swapdevs.  Easy to fix, if needed.
-		 * See swapfile.c:page_queue_congested().
-		 */
-		if (PageDirty(page)) {
-			if (!is_page_cache_freeable(page))
-				goto keep_locked;
-			if (!mapping)
-				goto keep_locked;
-			if (mapping->a_ops->writepage == NULL)
-				goto activate_locked;
-			if (!may_enter_fs)
-				goto keep_locked;
-			if (!may_write_to_queue(mapping->backing_dev_info))
-				goto keep_locked;
-			spin_lock(&mapping->page_lock);
-			if (test_clear_page_dirty(page)) {
-				int res;
-				struct writeback_control wbc = {
-					.sync_mode = WB_SYNC_NONE,
-					.nr_to_write = SWAP_CLUSTER_MAX,
-					.nonblocking = 1,
-					.for_reclaim = 1,
-				};
-
-				list_move(&page->list, &mapping->locked_pages);
-				spin_unlock(&mapping->page_lock);
-
-				SetPageReclaim(page);
-				res = mapping->a_ops->writepage(page, &wbc);
-
-				if (res == WRITEPAGE_ACTIVATE) {
-					ClearPageReclaim(page);
-					goto activate_locked;
-				}
-				if (!PageWriteback(page)) {
-					/* synchronous write or broken a_ops? */
-					ClearPageReclaim(page);
-				}
-				goto keep;
+		 * if calls to file system are allowed and @page is dirty, try
+		 * to send it to the disk. If !may_enter_fs, try to
+		 * ->releasepage() below anyway.
+ 		 */
+		if (may_enter_fs && PageDirty(page)) {
+			switch (pageout(page)) {
+			case PAGE_KEEP:
+ 				goto keep_locked;
+			case PAGE_ACTIVATE:
+ 				goto activate_locked;
+			case PAGE_SUCCESS:
+ 				goto keep;
+			case PAGE_CLEAN:
+				;
 			}
-			spin_unlock(&mapping->page_lock);
 		}
 
+
 		/*
 		 * If the page has buffers, try to free the buffer mappings
 		 * associated with this page. If we succeed we try to free
@@ -679,6 +739,7 @@ refill_inactive_zone(struct zone *zone, 
 		if (!TestClearPageActive(page))
 			BUG();
 		list_move(&page->lru, &zone->inactive_list);
+		ClearPageSkipped(page);
 		pgmoved++;
 		if (!pagevec_add(&pvec, page)) {
 			zone->nr_inactive += pgmoved;
diff -puN include/linux/mm_inline.h~skip-writepage include/linux/mm_inline.h
--- i386/include/linux/mm_inline.h~skip-writepage	Wed Jul  9 12:24:51 2003
+++ i386-god/include/linux/mm_inline.h	Wed Jul  9 12:24:51 2003
@@ -10,6 +10,7 @@ static inline void
 add_page_to_inactive_list(struct zone *zone, struct page *page)
 {
 	list_add(&page->lru, &zone->inactive_list);
+	ClearPageSkipped(page);
 	zone->nr_inactive++;
 }
 
diff -puN include/linux/page-flags.h~skip-writepage include/linux/page-flags.h
--- i386/include/linux/page-flags.h~skip-writepage	Wed Jul  9 12:24:51 2003
+++ i386-god/include/linux/page-flags.h	Wed Jul  9 12:24:51 2003
@@ -75,6 +75,7 @@
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */
+#define PG_skipped		20	/* ->writepage() was skipped on this page */
 
 
 /*
@@ -302,6 +303,12 @@ extern void get_full_page_state(struct p
 #define SetPageCompound(page)	set_bit(PG_compound, &(page)->flags)
 #define ClearPageCompound(page)	clear_bit(PG_compound, &(page)->flags)
 
+#define PageSkipped(page)	test_bit(PG_skipped, &(page)->flags)
+#define SetPageSkipped(page)	set_bit(PG_skipped, &(page)->flags)
+#define TestSetPageSkipped(page)	test_and_set_bit(PG_skipped, &(page)->flags)
+#define ClearPageSkipped(page)		clear_bit(PG_skipped, &(page)->flags)
+#define TestClearPageSkipped(page)	test_and_clear_bit(PG_skipped, &(page)->flags)
+
 /*
  * The PageSwapCache predicate doesn't use a PG_flag at this time,
  * but it may again do so one day.

_
