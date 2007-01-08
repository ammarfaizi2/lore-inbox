Return-Path: <linux-kernel-owner+w=401wt.eu-S1161297AbXAHNth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161297AbXAHNth (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161303AbXAHNth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:49:37 -0500
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:53460 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161297AbXAHNta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:49:30 -0500
Subject: [PATCH 2/4] swap: Add ability to mark swap pages bad
From: Richard Purdie <richard@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 13:48:57 +0000
Message-Id: <1168264138.5605.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add swap_free_markbad(), equivalent to swap_free but marks the swap page
as bad. Update try_to_unuse_entry() and shmem_unuse() to call the new
function when working on pages with errors.

These patches are a based on a patch by Nick Piggin and some of my own
patches/bugfixes as discussed on LKML.

Signed-off-by: Richard Purdie <rpurdie@openedhand.com>

---
 include/linux/swap.h |    1 +
 mm/shmem.c           |   17 ++++++++++-------
 mm/swap_state.c      |    2 ++
 mm/swapfile.c        |   38 +++++++++++++++++++++++++++++---------
 4 files changed, 42 insertions(+), 16 deletions(-)

Index: git/include/linux/swap.h
===================================================================
--- git.orig/include/linux/swap.h	2007-01-07 21:39:26.000000000 +0000
+++ git/include/linux/swap.h	2007-01-08 11:39:36.000000000 +0000
@@ -244,6 +244,7 @@ extern swp_entry_t get_swap_page_of_type
 extern int swap_duplicate(swp_entry_t);
 extern int valid_swaphandles(swp_entry_t, unsigned long *);
 extern void swap_free(swp_entry_t);
+extern void swap_free_markbad(swp_entry_t);
 extern void free_swap_and_cache(swp_entry_t);
 extern int swap_type_of(dev_t, sector_t, struct block_device **);
 extern unsigned int count_swap_pages(int, int);
Index: git/mm/shmem.c
===================================================================
--- git.orig/mm/shmem.c	2007-01-07 21:39:29.000000000 +0000
+++ git/mm/shmem.c	2007-01-08 11:39:36.000000000 +0000
@@ -734,7 +734,7 @@ static int shmem_unuse_inode(struct shme
 	struct page **dir;
 	struct page *subdir;
 	swp_entry_t *ptr;
-	int offset;
+	int offset, moved, error;
 
 	idx = 0;
 	ptr = info->i_direct;
@@ -792,17 +792,20 @@ lost2:
 found:
 	idx += offset;
 	inode = &info->vfs_inode;
-	if (move_from_swap_cache(page, idx, inode->i_mapping) == 0) {
+	error = PageError(page);
+	moved = (move_from_swap_cache(page, idx, inode->i_mapping) == 0);
+	if (moved) {
 		info->flags |= SHMEM_PAGEIN;
 		shmem_swp_set(info, ptr + offset, 0);
 	}
 	shmem_swp_unmap(ptr);
 	spin_unlock(&info->lock);
-	/*
-	 * Decrement swap count even when the entry is left behind:
-	 * try_to_unuse will skip over mms, then reincrement count.
-	 */
-	swap_free(entry);
+	if (moved) {
+		if (!error)
+			swap_free(entry);
+		else
+			swap_free_markbad(entry);
+	}
 	return 1;
 }
 
Index: git/mm/swapfile.c
===================================================================
--- git.orig/mm/swapfile.c	2007-01-08 11:39:27.000000000 +0000
+++ git/mm/swapfile.c	2007-01-08 11:39:36.000000000 +0000
@@ -304,6 +304,23 @@ void swap_free(swp_entry_t entry)
 	}
 }
 
+void swap_free_markbad(swp_entry_t entry)
+{
+	struct swap_info_struct * p;
+
+	p = swap_info_get(entry);
+	if (p) {
+		unsigned long offset = swp_offset(entry);
+		if (swap_entry_free(p, offset) == 0) {
+			p->swap_map[offset] = SWAP_MAP_BAD;
+			p->pages--;
+			nr_swap_pages--;
+			total_swap_pages--;
+		}
+		spin_unlock(&swap_lock);
+	}
+}
+
 /*
  * How many references to page are currently swapped out?
  */
@@ -764,11 +781,6 @@ retry:
 	 * remains (rarer), it will be read from disk into another page.
 	 * Splitting into two pages would be incorrect if swap supported
 	 * "shared private" pages, but they are handled by tmpfs files.
-	 *
-	 * Note shmem_unuse already deleted a swappage from the swap cache,
-	 * unless the move to filepage failed: in which case it left swappage
-	 * in cache, lowered its swap count to pass quickly through the loops
-	 * above, and now we must reincrement count to try again later.
 	 */
 	if (PageSwapCache(page)) {
 		if ((*swap_map > 1) && PageDirty(page)) {
@@ -781,11 +793,19 @@ retry:
 			wait_on_page_writeback(page);
 			goto retry;
 		}
+		if (!shmem) {
+			int error = PageError(page);
 
-		if (shmem)
-			swap_duplicate(entry);
-		else
-			delete_from_swap_cache(page);
+			write_lock_irq(&swapper_space.tree_lock);
+			__delete_from_swap_cache(page);
+			write_unlock_irq(&swapper_space.tree_lock);
+			page_cache_release(page); /* the swapcache ref */
+
+			if (!error)
+				swap_free(entry);
+			else
+				swap_free_markbad(entry);
+		}
 	}
 
 	/*
Index: git/mm/swap_state.c
===================================================================
--- git.orig/mm/swap_state.c	2007-01-07 21:39:29.000000000 +0000
+++ git/mm/swap_state.c	2007-01-08 11:39:36.000000000 +0000
@@ -131,6 +131,8 @@ void __delete_from_swap_cache(struct pag
 	radix_tree_delete(&swapper_space.page_tree, page_private(page));
 	set_page_private(page, 0);
 	ClearPageSwapCache(page);
+	if (unlikely(PageError(page)))
+		ClearPageError(page);
 	total_swapcache_pages--;
 	__dec_zone_page_state(page, NR_FILE_PAGES);
 	INC_CACHE_INFO(del_total);


