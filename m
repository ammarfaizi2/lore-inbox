Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUGLVz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUGLVz1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 17:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUGLVz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 17:55:27 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:36172 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263761AbUGLVxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 17:53:33 -0400
Date: Mon, 12 Jul 2004 22:53:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rmaplock 4/6 mm lock ordering
In-Reply-To: <Pine.LNX.4.44.0407122248060.4005-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0407122252410.4005-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With page_map_lock out of the way, there's no need for page_referenced
and try_to_unmap to use trylocks - provided we switch anon_vma->lock and
mm->page_table_lock around in anon_vma_prepare.  Though I suppose it's
possible that we'll find that vmscan makes better progress with trylocks
than spinning - we're free to choose trylocks again if so.

Try to update the mm lock ordering documentation in filemap.c.
But I still find it confusing, and I've no idea of where to stop.
So add the mm lock ordering list I can understand to rmap.c.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

 mm/filemap.c |   15 ++++++----
 mm/rmap.c    |   82 ++++++++++++++++++++++++++++++++---------------------------
 2 files changed, 54 insertions(+), 43 deletions(-)

--- rmaplock3/mm/filemap.c	2004-07-09 10:53:46.000000000 +0100
+++ rmaplock4/mm/filemap.c	2004-07-12 18:20:48.023890560 +0100
@@ -60,7 +60,6 @@
  *      ->swap_list_lock
  *        ->swap_device_lock	(exclusive_swap_page, others)
  *          ->mapping->tree_lock
- *    ->page_map_lock()		(try_to_unmap_file)
  *
  *  ->i_sem
  *    ->i_mmap_lock		(truncate->unmap_mapping_range)
@@ -83,16 +82,20 @@
  *    ->sb_lock			(fs/fs-writeback.c)
  *    ->mapping->tree_lock	(__sync_single_inode)
  *
+ *  ->i_mmap_lock
+ *    ->anon_vma.lock		(vma_adjust)
+ *
+ *  ->anon_vma.lock
+ *    ->page_table_lock		(anon_vma_prepare and various)
+ *
  *  ->page_table_lock
  *    ->swap_device_lock	(try_to_unmap_one)
  *    ->private_lock		(try_to_unmap_one)
  *    ->tree_lock		(try_to_unmap_one)
  *    ->zone.lru_lock		(follow_page->mark_page_accessed)
- *    ->page_map_lock()		(page_add_anon_rmap)
- *      ->tree_lock		(page_remove_rmap->set_page_dirty)
- *      ->private_lock		(page_remove_rmap->set_page_dirty)
- *      ->inode_lock		(page_remove_rmap->set_page_dirty)
- *    ->anon_vma.lock		(anon_vma_prepare)
+ *    ->private_lock		(page_remove_rmap->set_page_dirty)
+ *    ->tree_lock		(page_remove_rmap->set_page_dirty)
+ *    ->inode_lock		(page_remove_rmap->set_page_dirty)
  *    ->inode_lock		(zap_pte_range->set_page_dirty)
  *    ->private_lock		(zap_pte_range->__set_page_dirty_buffers)
  *
--- rmaplock3/mm/rmap.c	2004-07-12 18:20:35.274828712 +0100
+++ rmaplock4/mm/rmap.c	2004-07-12 18:20:48.025890256 +0100
@@ -18,9 +18,30 @@
  */
 
 /*
- * Locking: see "Lock ordering" summary in filemap.c.
- * In swapout, page_map_lock is held on entry to page_referenced and
- * try_to_unmap, so they trylock for i_mmap_lock and page_table_lock.
+ * Lock ordering in mm:
+ *
+ * inode->i_sem	(while writing or truncating, not reading or faulting)
+ *   inode->i_alloc_sem
+ *
+ * When a page fault occurs in writing from user to file, down_read
+ * of mmap_sem nests within i_sem; in sys_msync, i_sem nests within
+ * down_read of mmap_sem; i_sem and down_write of mmap_sem are never
+ * taken together; in truncation, i_sem is taken outermost.
+ *
+ * mm->mmap_sem
+ *   page->flags PG_locked (lock_page)
+ *     mapping->i_mmap_lock
+ *       anon_vma->lock
+ *         mm->page_table_lock
+ *           zone->lru_lock (in mark_page_accessed)
+ *           swap_list_lock (in swap_free etc's swap_info_get)
+ *             swap_device_lock (in swap_duplicate, swap_info_get)
+ *             mapping->private_lock (in __set_page_dirty_buffers)
+ *             inode_lock (in set_page_dirty's __mark_inode_dirty)
+ *               sb_lock (within inode_lock in fs/fs-writeback.c)
+ *               mapping->tree_lock (widely used, in set_page_dirty,
+ *                         in arch-dependent flush_dcache_mmap_lock,
+ *                         within inode_lock in __sync_single_inode)
  */
 
 #include <linux/mm.h>
@@ -64,28 +85,32 @@ int anon_vma_prepare(struct vm_area_stru
 	might_sleep();
 	if (unlikely(!anon_vma)) {
 		struct mm_struct *mm = vma->vm_mm;
-		struct anon_vma *allocated = NULL;
+		struct anon_vma *allocated, *locked;
 
 		anon_vma = find_mergeable_anon_vma(vma);
-		if (!anon_vma) {
+		if (anon_vma) {
+			allocated = NULL;
+			locked = anon_vma;
+			spin_lock(&locked->lock);
+		} else {
 			anon_vma = anon_vma_alloc();
 			if (unlikely(!anon_vma))
 				return -ENOMEM;
 			allocated = anon_vma;
+			locked = NULL;
 		}
 
 		/* page_table_lock to protect against threads */
 		spin_lock(&mm->page_table_lock);
 		if (likely(!vma->anon_vma)) {
-			if (!allocated)
-				spin_lock(&anon_vma->lock);
 			vma->anon_vma = anon_vma;
 			list_add(&vma->anon_vma_node, &anon_vma->head);
-			if (!allocated)
-				spin_unlock(&anon_vma->lock);
 			allocated = NULL;
 		}
 		spin_unlock(&mm->page_table_lock);
+
+		if (locked)
+			spin_unlock(&locked->lock);
 		if (unlikely(allocated))
 			anon_vma_free(allocated);
 	}
@@ -225,8 +250,7 @@ static int page_referenced_one(struct pa
 	if (address == -EFAULT)
 		goto out;
 
-	if (!spin_trylock(&mm->page_table_lock))
-		goto out;
+	spin_lock(&mm->page_table_lock);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -287,9 +311,6 @@ static int page_referenced_anon(struct p
  * of references it found.
  *
  * This function is only called from page_referenced for object-based pages.
- *
- * The spinlock address_space->i_mmap_lock is tried.  If it can't be gotten,
- * assume a reference count of 0, so try_to_unmap will then have a go.
  */
 static int page_referenced_file(struct page *page)
 {
@@ -315,8 +336,7 @@ static int page_referenced_file(struct p
 	 */
 	BUG_ON(!PageLocked(page));
 
-	if (!spin_trylock(&mapping->i_mmap_lock))
-		return 0;
+	spin_lock(&mapping->i_mmap_lock);
 
 	/*
 	 * i_mmap_lock does not stabilize mapcount at all, but mapcount
@@ -468,8 +488,7 @@ static int try_to_unmap_one(struct page 
 	 * We need the page_table_lock to protect us from page faults,
 	 * munmap, fork, etc...
 	 */
-	if (!spin_trylock(&mm->page_table_lock))
-		goto out;
+	spin_lock(&mm->page_table_lock);
 
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
@@ -568,7 +587,7 @@ out:
 #define CLUSTER_SIZE	min(32*PAGE_SIZE, PMD_SIZE)
 #define CLUSTER_MASK	(~(CLUSTER_SIZE - 1))
 
-static int try_to_unmap_cluster(unsigned long cursor,
+static void try_to_unmap_cluster(unsigned long cursor,
 	unsigned int *mapcount, struct vm_area_struct *vma)
 {
 	struct mm_struct *mm = vma->vm_mm;
@@ -585,8 +604,7 @@ static int try_to_unmap_cluster(unsigned
 	 * We need the page_table_lock to protect us from page faults,
 	 * munmap, fork, etc...
 	 */
-	if (!spin_trylock(&mm->page_table_lock))
-		return SWAP_FAIL;
+	spin_lock(&mm->page_table_lock);
 
 	address = (vma->vm_start + cursor) & CLUSTER_MASK;
 	end = address + CLUSTER_SIZE;
@@ -643,7 +661,6 @@ static int try_to_unmap_cluster(unsigned
 
 out_unlock:
 	spin_unlock(&mm->page_table_lock);
-	return SWAP_AGAIN;
 }
 
 static int try_to_unmap_anon(struct page *page)
@@ -673,9 +690,6 @@ static int try_to_unmap_anon(struct page
  * contained in the address_space struct it points to.
  *
  * This function is only called from try_to_unmap for object-based pages.
- *
- * The spinlock address_space->i_mmap_lock is tried.  If it can't be gotten,
- * return a temporary error.
  */
 static int try_to_unmap_file(struct page *page)
 {
@@ -689,9 +703,7 @@ static int try_to_unmap_file(struct page
 	unsigned long max_nl_size = 0;
 	unsigned int mapcount;
 
-	if (!spin_trylock(&mapping->i_mmap_lock))
-		return ret;
-
+	spin_lock(&mapping->i_mmap_lock);
 	while ((vma = vma_prio_tree_next(vma, &mapping->i_mmap,
 					&iter, pgoff, pgoff)) != NULL) {
 		ret = try_to_unmap_one(page, vma);
@@ -714,8 +726,10 @@ static int try_to_unmap_file(struct page
 			max_nl_size = cursor;
 	}
 
-	if (max_nl_size == 0)	/* any nonlinears locked or reserved */
+	if (max_nl_size == 0) {	/* any nonlinears locked or reserved */
+		ret = SWAP_FAIL;
 		goto out;
+	}
 
 	/*
 	 * We don't try to search for this page in the nonlinear vmas,
@@ -742,19 +756,13 @@ static int try_to_unmap_file(struct page
 			while (vma->vm_mm->rss &&
 				cursor < max_nl_cursor &&
 				cursor < vma->vm_end - vma->vm_start) {
-				ret = try_to_unmap_cluster(
-						cursor, &mapcount, vma);
-				if (ret == SWAP_FAIL)
-					break;
+				try_to_unmap_cluster(cursor, &mapcount, vma);
 				cursor += CLUSTER_SIZE;
 				vma->vm_private_data = (void *) cursor;
 				if ((int)mapcount <= 0)
 					goto out;
 			}
-			if (ret != SWAP_FAIL)
-				vma->vm_private_data =
-					(void *) max_nl_cursor;
-			ret = SWAP_AGAIN;
+			vma->vm_private_data = (void *) max_nl_cursor;
 		}
 		cond_resched_lock(&mapping->i_mmap_lock);
 		max_nl_cursor += CLUSTER_SIZE;

