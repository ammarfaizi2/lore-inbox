Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316794AbSFQGv4>; Mon, 17 Jun 2002 02:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316782AbSFQGuA>; Mon, 17 Jun 2002 02:50:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23054 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316775AbSFQGsb>;
	Mon, 17 Jun 2002 02:48:31 -0400
Message-ID: <3D0D8731.1FC1A061@zip.com.au>
Date: Sun, 16 Jun 2002 23:52:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Hugh Dickins <hugh@veritas.com>
Subject: [patch 9/19] leave swapcache pages unlocked during writeout
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Convert swap pages so that they are PageWriteback and !PageLocked while
under writeout, like all other block-backed pages.  (Network
filesystems aren't doing this yet - their pages are still locked while
under writeout)



--- 2.5.22/mm/swapfile.c~swap-pages-unlocked	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/mm/swapfile.c	Sun Jun 16 23:22:47 2002
@@ -298,6 +298,8 @@ int remove_exclusive_swap_page(struct pa
 		BUG();
 	if (!PageSwapCache(page))
 		return 0;
+	if (PageWriteback(page))
+		return 0;
 	if (page_count(page) - !!PagePrivate(page) != 2) /* 2: us + cache */
 		return 0;
 
@@ -311,7 +313,8 @@ int remove_exclusive_swap_page(struct pa
 	if (p->swap_map[swp_offset(entry)] == 1) {
 		/* Recheck the page count with the pagecache lock held.. */
 		write_lock(&swapper_space.page_lock);
-		if (page_count(page) - !!PagePrivate(page) == 2) {
+		if ((page_count(page) - !!page_has_buffers(page) == 2) &&
+					!PageWriteback(page)) {
 			__delete_from_swap_cache(page);
 			/*
 			 * NOTE: if/when swap gets buffer/page coherency
@@ -326,7 +329,6 @@ int remove_exclusive_swap_page(struct pa
 	swap_info_put(p);
 
 	if (retval) {
-		BUG_ON(PageWriteback(page));
 		if (page_has_buffers(page) && !try_to_free_buffers(page))
 			BUG();
 		swap_free(entry);
@@ -352,9 +354,12 @@ void free_swap_and_cache(swp_entry_t ent
 		swap_info_put(p);
 	}
 	if (page) {
+		int one_user;
+
 		page_cache_get(page);
+		one_user = (page_count(page) - !!page_has_buffers(page) == 2);
 		/* Only cache user (+us), or swap space full? Free it! */
-		if (page_count(page) - !!PagePrivate(page) == 2 || vm_swap_full()) {
+		if (!PageWriteback(page) && (one_user || vm_swap_full())) {
 			delete_from_swap_cache(page);
 			SetPageDirty(page);
 		}
@@ -606,6 +611,7 @@ static int try_to_unuse(unsigned int typ
 		wait_on_page_locked(page);
 		wait_on_page_writeback(page);
 		lock_page(page);
+		wait_on_page_writeback(page);
 
 		/*
 		 * Remove all references to entry, without blocking.
@@ -688,8 +694,10 @@ static int try_to_unuse(unsigned int typ
 			rw_swap_page(WRITE, page);
 			lock_page(page);
 		}
-		if (PageSwapCache(page))
+		if (PageSwapCache(page)) {
+			wait_on_page_writeback(page);
 			delete_from_swap_cache(page);
+		}
 
 		/*
 		 * So we could skip searching mms once swap count went
--- 2.5.22/mm/swap_state.c~swap-pages-unlocked	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/mm/swap_state.c	Sun Jun 16 23:22:47 2002
@@ -131,10 +131,9 @@ int add_to_swap_cache(struct page *page,
  */
 void __delete_from_swap_cache(struct page *page)
 {
-	if (!PageLocked(page))
-		BUG();
-	if (!PageSwapCache(page))
-		BUG();
+	BUG_ON(!PageLocked(page));
+	BUG_ON(!PageSwapCache(page));
+	BUG_ON(PageWriteback(page));
 	ClearPageDirty(page);
 	__remove_inode_page(page);
 	INC_CACHE_INFO(del_total);
--- 2.5.22/mm/shmem.c~swap-pages-unlocked	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/mm/shmem.c	Sun Jun 16 22:50:18 2002
@@ -426,15 +426,22 @@ found:
 	swap_free(entry);
 	ptr[offset] = (swp_entry_t) {0};
 
-	while (inode && move_from_swap_cache(page, idx, inode->i_mapping)) {
+	while (inode && (PageWriteback(page) ||
+			move_from_swap_cache(page, idx, inode->i_mapping))) {
 		/*
 		 * Yield for kswapd, and try again - but we're still
 		 * holding the page lock - ugh! fix this up later on.
 		 * Beware of inode being unlinked or truncated: just
 		 * leave try_to_unuse to delete_from_swap_cache if so.
+		 *
+		 * AKPM: We now wait on writeback too.  Note that it's
+		 * the page lock which prevents new writeback from starting.
 		 */
 		spin_unlock(&info->lock);
-		yield();
+		if (PageWriteback(page))
+			wait_on_page_writeback(page);
+		else
+			yield();
 		spin_lock(&info->lock);
 		ptr = shmem_swp_entry(info, idx, 0);
 		if (IS_ERR(ptr))
@@ -594,9 +601,14 @@ repeat:
 		}
 
 		/* We have to do this with page locked to prevent races */
-		if (TestSetPageLocked(page)) 
+		if (TestSetPageLocked(page))
 			goto wait_retry;
-
+		if (PageWriteback(page)) {
+			spin_unlock(&info->lock);
+			wait_on_page_writeback(page);
+			unlock_page(page);
+			goto repeat;
+		}
 		error = move_from_swap_cache(page, idx, mapping);
 		if (error < 0) {
 			unlock_page(page);
@@ -651,7 +663,7 @@ no_space:
 	return ERR_PTR(-ENOSPC);
 
 wait_retry:
-	spin_unlock (&info->lock);
+	spin_unlock(&info->lock);
 	wait_on_page_locked(page);
 	page_cache_release(page);
 	goto repeat;
--- 2.5.22/fs/buffer.c~swap-pages-unlocked	Sun Jun 16 22:50:18 2002
+++ 2.5.22-akpm/fs/buffer.c	Sun Jun 16 23:22:47 2002
@@ -542,14 +542,6 @@ static void end_buffer_async_read(struct
 	 */
 	if (page_uptodate && !PageError(page))
 		SetPageUptodate(page);
-
-	/*
-	 * swap page handling is a bit hacky.  A standalone completion handler
-	 * for swapout pages would fix that up.  swapin can use this function.
-	 */
-	if (PageSwapCache(page) && PageWriteback(page))
-		end_page_writeback(page);
-
 	unlock_page(page);
 	return;
 
@@ -559,8 +551,9 @@ still_busy:
 }
 
 /*
- * Completion handler for block_write_full_page() - pages which are unlocked
- * during I/O, and which have PageWriteback cleared upon I/O completion.
+ * Completion handler for block_write_full_page() and for brw_page() - pages
+ * which are unlocked during I/O, and which have PageWriteback cleared
+ * upon I/O completion.
  */
 static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
 {
@@ -2283,16 +2276,6 @@ int brw_kiovec(int rw, int nr, struct ki
  *
  * FIXME: we need a swapper_inode->get_block function to remove
  *        some of the bmap kludges and interface ugliness here.
- *
- * NOTE: unlike file pages, swap pages are locked while under writeout.
- * This is to throttle processes which reuse their swapcache pages while
- * they are under writeout, and to ensure that there is no I/O going on
- * when the page has been successfully locked.  Functions such as
- * free_swap_and_cache() need to guarantee that there is no I/O in progress
- * because they will be freeing up swap blocks, which may then be reused.
- *
- * Swap pages are also marked PageWriteback when they are being written
- * so that memory allocators will throttle on them.
  */
 int brw_page(int rw, struct page *page,
 		struct block_device *bdev, sector_t b[], int size)
@@ -2314,18 +2297,17 @@ int brw_page(int rw, struct page *page,
 		if (rw == WRITE) {
 			set_buffer_uptodate(bh);
 			clear_buffer_dirty(bh);
+			mark_buffer_async_write(bh);
+		} else {
+			mark_buffer_async_read(bh);
 		}
-		/*
-		 * Swap pages are locked during writeout, so use
-		 * buffer_async_read in strange ways.
-		 */
-		mark_buffer_async_read(bh);
 		bh = bh->b_this_page;
 	} while (bh != head);
 
 	if (rw == WRITE) {
 		BUG_ON(PageWriteback(page));
 		SetPageWriteback(page);
+		unlock_page(page);
 	}
 
 	/* Stage 2: start the IO */

-
