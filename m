Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262519AbSJAVsI>; Tue, 1 Oct 2002 17:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262279AbSJAVsI>; Tue, 1 Oct 2002 17:48:08 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:58923 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262514AbSJAVq7>; Tue, 1 Oct 2002 17:46:59 -0400
Date: Tue, 1 Oct 2002 22:53:14 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 7/9 shmem_swp_set nr_swapped
In-Reply-To: <Pine.LNX.4.44.0210012240470.2602-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210012251560.2602-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we're going to rely on struct page *s rather than virtual addresses
for the metadata pages, let's count nr_swapped in the private field:
these pages are only for storing swp_entry_ts, and need not be examined
at all when nr_swapped is zero.

--- tmpfs6/mm/shmem.c	Tue Oct  1 19:49:19 2002
+++ tmpfs7/mm/shmem.c	Tue Oct  1 19:49:24 2002
@@ -48,6 +48,9 @@
 /* Pretend that each entry is of this size in directory's i_size */
 #define BOGO_DIRENT_SIZE 20
 
+/* Keep swapped page count in private field of indirect struct page */
+#define nr_swapped		private
+
 static inline struct page *shmem_dir_alloc(unsigned int gfp_mask)
 {
 	/*
@@ -242,7 +245,27 @@
 		*page = NULL;
 	}
 	shmem_dir_unmap(dir);
-	return shmem_swp_map(subdir) + offset;
+
+	/*
+	 * With apologies... caller shmem_swp_alloc passes non-NULL
+	 * page (though perhaps NULL *page); and now we know that this
+	 * indirect page has been allocated, we can shortcut the final
+	 * kmap if we know it contains no swap entries, as is commonly
+	 * the case: return pointer to a 0 which doesn't need kmapping.
+	 */
+	return (page && !subdir->nr_swapped)?
+		(swp_entry_t *)&subdir->nr_swapped:
+		shmem_swp_map(subdir) + offset;
+}
+
+static void shmem_swp_set(struct shmem_inode_info *info, swp_entry_t *entry, unsigned long value)
+{
+	long incdec = value? 1: -1;
+
+	entry->val = value;
+	info->swapped += incdec;
+	if ((unsigned long)(entry - info->i_direct) >= SHMEM_NR_DIRECT)
+		kmap_atomic_to_page(entry)->nr_swapped += incdec;
 }
 
 /*
@@ -281,8 +304,10 @@
 
 		spin_unlock(&info->lock);
 		page = shmem_dir_alloc(inode->i_mapping->gfp_mask);
-		if (page)
+		if (page) {
 			clear_highpage(page);
+			page->nr_swapped = 0;
+		}
 		spin_lock(&info->lock);
 
 		if (!page) {
@@ -331,6 +356,7 @@
 	struct page *empty;
 	swp_entry_t *ptr;
 	int offset;
+	int freed;
 
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	idx = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
@@ -405,13 +431,16 @@
 			dir = shmem_dir_map(subdir);
 		}
 		subdir = *dir;
-		if (subdir) {
+		if (subdir && subdir->nr_swapped) {
 			ptr = shmem_swp_map(subdir);
 			size = limit - idx;
 			if (size > ENTRIES_PER_PAGE)
 				size = ENTRIES_PER_PAGE;
-			info->swapped -= shmem_free_swp(ptr+offset, ptr+size);
+			freed = shmem_free_swp(ptr+offset, ptr+size);
 			shmem_swp_unmap(ptr);
+			info->swapped -= freed;
+			subdir->nr_swapped -= freed;
+			BUG_ON(subdir->nr_swapped > offset);
 		}
 		if (offset)
 			offset = 0;
@@ -561,7 +590,7 @@
 			dir = shmem_dir_map(subdir);
 		}
 		subdir = *dir;
-		if (subdir) {
+		if (subdir && subdir->nr_swapped) {
 			ptr = shmem_swp_map(subdir);
 			size = limit - idx;
 			if (size > ENTRIES_PER_PAGE)
@@ -581,10 +610,8 @@
 	return 0;
 found:
 	if (move_from_swap_cache(page, idx + offset,
-			info->vfs_inode.i_mapping) == 0) {
-		ptr[offset] = (swp_entry_t) {0};
-		info->swapped--;
-	}
+			info->vfs_inode.i_mapping) == 0)
+		shmem_swp_set(info, ptr + offset, 0);
 	shmem_swp_unmap(ptr);
 	spin_unlock(&info->lock);
 	/*
@@ -624,7 +651,6 @@
  */
 static int shmem_writepage(struct page * page)
 {
-	int err;
 	struct shmem_inode_info *info;
 	swp_entry_t *entry, swap;
 	struct address_space *mapping;
@@ -654,10 +680,8 @@
 	if (entry->val)
 		BUG();
 
-	err = move_to_swap_cache(page, swap);
-	if (!err) {
-		*entry = swap;
-		info->swapped++;
+	if (move_to_swap_cache(page, swap) == 0) {
+		shmem_swp_set(info, entry, swap.val);
 		shmem_swp_unmap(entry);
 		spin_unlock(&info->lock);
 		unlock_page(page);
@@ -785,8 +809,7 @@
 			return error;
 		}
 
-		*entry = (swp_entry_t) {0};
-		info->swapped--;
+		shmem_swp_set(info, entry, 0);
 		shmem_swp_unmap(entry);
 		spin_unlock(&info->lock);
 		swap_free(swap);

