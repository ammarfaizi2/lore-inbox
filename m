Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316359AbSEZUiy>; Sun, 26 May 2002 16:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316380AbSEZUha>; Sun, 26 May 2002 16:37:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42768 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316388AbSEZUhN>;
	Sun, 26 May 2002 16:37:13 -0400
Message-ID: <3CF14834.7FF3E72E@zip.com.au>
Date: Sun, 26 May 2002 13:40:20 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 5/18] mark swapout pages PageWriteback()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pages which are under writeout to swap are locked, and not
PageWriteback().  So page allocators do not throttle against them in
shrink_caches().

This causes enormous list scans and general coma under really heavy
swapout loads.

One fix would be to teach shrink_cache() to wait on PG_locked for swap
pages.  The other approach is to set both PG_locked and PG_writeback
for swap pages so they can be handled in the same manner as file-backed
pages in shrink_cache().

This patch takes the latter approach.

=====================================

--- 2.5.18/fs/buffer.c~swap-writeback	Sat May 25 23:26:46 2002
+++ 2.5.18-akpm/fs/buffer.c	Sun May 26 00:50:20 2002
@@ -544,6 +544,14 @@ static void end_buffer_async_read(struct
 	 */
 	if (page_uptodate && !PageError(page))
 		SetPageUptodate(page);
+
+	/*
+	 * swap page handling is a bit hacky.  A standalone completion handler
+	 * for swapout pages would fix that up.  swapin can use this function.
+	 */
+	if (PageSwapCache(page) && PageWriteback(page))
+		end_page_writeback(page);
+
 	unlock_page(page);
 	return;
 
@@ -2271,6 +2279,9 @@ int brw_kiovec(int rw, int nr, struct ki
  * calls block_flushpage() under spinlock and hits a locked buffer, and
  * schedules under spinlock.   Another approach would be to teach
  * find_trylock_page() to also trylock the page's writeback flags.
+ *
+ * Swap pages are also marked PageWriteback when they are being written
+ * so that memory allocators will throttle on them.
  */
 int brw_page(int rw, struct page *page,
 		struct block_device *bdev, sector_t b[], int size)
@@ -2301,6 +2312,11 @@ int brw_page(int rw, struct page *page,
 		bh = bh->b_this_page;
 	} while (bh != head);
 
+	if (rw == WRITE) {
+		BUG_ON(PageWriteback(page));
+		SetPageWriteback(page);
+	}
+
 	/* Stage 2: start the IO */
 	do {
 		struct buffer_head *next = bh->b_this_page;
--- 2.5.18/mm/swap_state.c~swap-writeback	Sat May 25 23:26:46 2002
+++ 2.5.18-akpm/mm/swap_state.c	Sun May 26 00:50:19 2002
@@ -36,10 +36,8 @@ static int swap_writepage(struct page *p
  * swapper_space doesn't have a real inode, so it gets a special vm_writeback()
  * so we don't need swap special cases in generic_vm_writeback().
  *
- * FIXME: swap pages are locked, but not PageWriteback while under writeout.
- * This will confuse throttling in shrink_cache().  It may be advantageous to
- * set PG_writeback against swap pages while they're also locked.  Either that,
- * or special-case swap pages in shrink_cache().
+ * Swap pages are PageLocked and PageWriteback while under writeout so that
+ * memory allocators will throttle against them.
  */
 static int swap_vm_writeback(struct page *page, int *nr_to_write)
 {


-
