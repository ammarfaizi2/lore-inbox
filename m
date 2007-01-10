Return-Path: <linux-kernel-owner+w=401wt.eu-S965015AbXAJSGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965015AbXAJSGL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 13:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbXAJSGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 13:06:11 -0500
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]:47596 "EHLO
	pug.o-hand.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965015AbXAJSGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 13:06:09 -0500
Subject: [PATCH 4/4] swap: Simplify shmem_unuse() usage
From: Richard Purdie <richard@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 18:06:07 +0000
Message-Id: <1168452367.5801.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify shmem_unuse_inode() removing a confusing optimisation which
requires the caller to call swap_duplicate if the shmem_unuse() call
doesn't succeed.

Based on a patch by Nick Piggin and some of my own changes as discussed
on LKML. 

Signed-off-by: Richard Purdie <rpurdie@openedhand.com>

---
 mm/shmem.c    |   12 +++++-------
 mm/swapfile.c |   23 ++---------------------
 2 files changed, 7 insertions(+), 28 deletions(-)

Index: git/mm/shmem.c
===================================================================
--- git.orig/mm/shmem.c	2007-01-10 16:45:28.000000000 +0000
+++ git/mm/shmem.c	2007-01-10 16:55:59.000000000 +0000
@@ -734,7 +734,7 @@ static int shmem_unuse_inode(struct shme
 	struct page **dir;
 	struct page *subdir;
 	swp_entry_t *ptr;
-	int offset;
+	int offset, moved;
 
 	idx = 0;
 	ptr = info->i_direct;
@@ -792,17 +792,15 @@ lost2:
 found:
 	idx += offset;
 	inode = &info->vfs_inode;
-	if (move_from_swap_cache(page, idx, inode->i_mapping) == 0) {
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
-	swap_free(entry, page);
+	if (moved)
+		swap_free(entry, page);
 	return 1;
 }
 
Index: git/mm/swapfile.c
===================================================================
--- git.orig/mm/swapfile.c	2007-01-10 16:53:59.000000000 +0000
+++ git/mm/swapfile.c	2007-01-10 16:56:28.000000000 +0000
@@ -689,15 +689,6 @@ void try_to_unuse_page_entry(struct page
 	if (!shmem_unuse(entry, page)) {
 		try_to_unuse_anon(entry, page);
 		delete_from_swap_cache(page);
-	} else if (PageSwapCache(page)) {
-		/*
-		 * shmem_unuse deleted a swappage from the swap cache, but the
-		 * move to filepage failed so it left swappage in cache and
-		 * lowered its swap count to pass quickly through the loops in
-		 * try_to_unuse(). We must reincrement the count to try again
-		 * later (ick).
-		 */
-		swap_duplicate(entry);
 	}
 }
 
@@ -922,12 +913,6 @@ static int try_to_unuse(unsigned int typ
 		 * read from disk into another page.  Splitting into two
 		 * pages would be incorrect if swap supported "shared
 		 * private" pages, but they are handled by tmpfs files.
-		 *
-		 * Note shmem_unuse already deleted a swappage from
-		 * the swap cache, unless the move to filepage failed:
-		 * in which case it left swappage in cache, lowered its
-		 * swap count to pass quickly through the loops above,
-		 * and now we must reincrement count to try again later.
 		 */
 		if ((*swap_map > 1) && PageDirty(page) && PageSwapCache(page)) {
 			struct writeback_control wbc = {
@@ -938,12 +923,8 @@ static int try_to_unuse(unsigned int typ
 			lock_page(page);
 			wait_on_page_writeback(page);
 		}
-		if (PageSwapCache(page)) {
-			if (shmem)
-				swap_duplicate(entry);
-			else
-				delete_from_swap_cache(page);
-		}
+		if (PageSwapCache(page) && !shmem)
+			delete_from_swap_cache(page);
 
 		/*
 		 * So we could skip searching mms once swap count went


