Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbUJXPti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUJXPti (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbUJXPsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:48:21 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:34578 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261500AbUJXPmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:42:38 -0400
Date: Sun, 24 Oct 2004 16:42:14 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs truncate latency
Message-ID: <Pine.LNX.4.44.0410241639490.12023-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

High latency observed when deleting a large video file from tmpfs.

shmem_truncate held info->lock (easily dropped) and nested atomic
kmaps (more awkward to handle, since it's structured to keep them)
while scanning the many pages of its swap vector.  Now be prepared
to cond_resched every 64 ops (but scan an empty page in one go).

shmem_free_pages to free a linked list of empty swap vector pages at
the end (cond_resched every 64): could still free them one by one in
the main loop, but this foreshadows scalability changes - which will
want to use RCU on them, only freeing the pages after a grace period.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---
 mm/shmem.c |  180 +++++++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 118 insertions(+), 62 deletions(-)

--- 2.6.10-rc1/mm/shmem.c	2004-10-23 12:44:13.000000000 +0100
+++ linux/mm/shmem.c	2004-10-23 20:43:24.000000000 +0100
@@ -66,6 +66,9 @@
 #define SHMEM_PAGEIN	 VM_READ
 #define SHMEM_TRUNCATE	 VM_WRITE
 
+/* Definition to limit shmem_truncate's steps between cond_rescheds */
+#define LATENCY_LIMIT	 64
+
 /* Pretend that each entry is of this size in directory's i_size */
 #define BOGO_DIRENT_SIZE 20
 
@@ -188,13 +191,13 @@ static struct backing_dev_info shmem_bac
 static LIST_HEAD(shmem_swaplist);
 static spinlock_t shmem_swaplist_lock = SPIN_LOCK_UNLOCKED;
 
-static void shmem_free_block(struct inode *inode)
+static void shmem_free_blocks(struct inode *inode, long pages)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	if (sbinfo) {
 		spin_lock(&sbinfo->stat_lock);
-		sbinfo->free_blocks++;
-		inode->i_blocks -= BLOCKS_PER_PAGE;
+		sbinfo->free_blocks += pages;
+		inode->i_blocks -= pages*BLOCKS_PER_PAGE;
 		spin_unlock(&sbinfo->stat_lock);
 	}
 }
@@ -219,15 +222,9 @@ static void shmem_recalc_inode(struct in
 
 	freed = info->alloced - info->swapped - inode->i_mapping->nrpages;
 	if (freed > 0) {
-		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 		info->alloced -= freed;
 		shmem_unacct_blocks(info->flags, freed);
-		if (sbinfo) {
-			spin_lock(&sbinfo->stat_lock);
-			sbinfo->free_blocks += freed;
-			inode->i_blocks -= freed*BLOCKS_PER_PAGE;
-			spin_unlock(&sbinfo->stat_lock);
-		}
+		shmem_free_blocks(inode, freed);
 	}
 }
 
@@ -380,7 +377,7 @@ static swp_entry_t *shmem_swp_alloc(stru
 		spin_lock(&info->lock);
 
 		if (!page) {
-			shmem_free_block(inode);
+			shmem_free_blocks(inode, 1);
 			return ERR_PTR(-ENOMEM);
 		}
 		if (sgp != SGP_WRITE &&
@@ -393,7 +390,7 @@ static swp_entry_t *shmem_swp_alloc(stru
 	}
 	if (page) {
 		/* another task gave its page, or truncated the file */
-		shmem_free_block(inode);
+		shmem_free_blocks(inode, 1);
 		shmem_dir_free(page);
 	}
 	if (info->next_index <= index && !IS_ERR(entry))
@@ -422,6 +419,49 @@ static int shmem_free_swp(swp_entry_t *d
 	return freed;
 }
 
+static int shmem_map_and_free_swp(struct page *subdir,
+		int offset, int limit, struct page ***dir)
+{
+	swp_entry_t *ptr;
+	int freed = 0;
+
+	ptr = shmem_swp_map(subdir);
+	for (; offset < limit; offset += LATENCY_LIMIT) {
+		int size = limit - offset;
+		if (size > LATENCY_LIMIT)
+			size = LATENCY_LIMIT;
+		freed += shmem_free_swp(ptr+offset, ptr+offset+size);
+		if (need_resched()) {
+			shmem_swp_unmap(ptr);
+			if (*dir) {
+				shmem_dir_unmap(*dir);
+				*dir = NULL;
+			}
+			cond_resched();
+			ptr = shmem_swp_map(subdir);
+		}
+	}
+	shmem_swp_unmap(ptr);
+	return freed;
+}
+
+static void shmem_free_pages(struct list_head *next)
+{
+	struct page *page;
+	int freed = 0;
+
+	do {
+		page = container_of(next, struct page, lru);
+		next = next->next;
+		shmem_dir_free(page);
+		freed++;
+		if (freed >= LATENCY_LIMIT) {
+			cond_resched();
+			freed = 0;
+		}
+	} while (next);
+}
+
 static void shmem_truncate(struct inode *inode)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -429,10 +469,15 @@ static void shmem_truncate(struct inode 
 	unsigned long size;
 	unsigned long limit;
 	unsigned long stage;
+	unsigned long diroff;
 	struct page **dir;
+	struct page *topdir;
+	struct page *middir;
 	struct page *subdir;
-	struct page *empty;
 	swp_entry_t *ptr;
+	LIST_HEAD(pages_to_free);
+	long nr_pages_to_free = 0;
+	long nr_swaps_freed = 0;
 	int offset;
 	int freed;
 
@@ -445,14 +490,22 @@ static void shmem_truncate(struct inode 
 	info->flags |= SHMEM_TRUNCATE;
 	limit = info->next_index;
 	info->next_index = idx;
+	topdir = info->i_indirect;
+	if (topdir && idx <= SHMEM_NR_DIRECT) {
+		info->i_indirect = NULL;
+		nr_pages_to_free++;
+		list_add(&topdir->lru, &pages_to_free);
+	}
+	spin_unlock(&info->lock);
+
 	if (info->swapped && idx < SHMEM_NR_DIRECT) {
 		ptr = info->i_direct;
 		size = limit;
 		if (size > SHMEM_NR_DIRECT)
 			size = SHMEM_NR_DIRECT;
-		info->swapped -= shmem_free_swp(ptr+idx, ptr+size);
+		nr_swaps_freed = shmem_free_swp(ptr+idx, ptr+size);
 	}
-	if (!info->i_indirect)
+	if (!topdir)
 		goto done2;
 
 	BUG_ON(limit <= SHMEM_NR_DIRECT);
@@ -461,36 +514,38 @@ static void shmem_truncate(struct inode 
 	offset = idx % ENTRIES_PER_PAGE;
 	idx -= offset;
 
-	empty = NULL;
-	dir = shmem_dir_map(info->i_indirect);
+	dir = shmem_dir_map(topdir);
 	stage = ENTRIES_PER_PAGEPAGE/2;
-	if (idx < ENTRIES_PER_PAGEPAGE/2)
-		dir += idx/ENTRIES_PER_PAGE;
-	else {
+	if (idx < ENTRIES_PER_PAGEPAGE/2) {
+		middir = topdir;
+		diroff = idx/ENTRIES_PER_PAGE;
+	} else {
 		dir += ENTRIES_PER_PAGE/2;
 		dir += (idx - ENTRIES_PER_PAGEPAGE/2)/ENTRIES_PER_PAGEPAGE;
 		while (stage <= idx)
 			stage += ENTRIES_PER_PAGEPAGE;
+		middir = *dir;
 		if (*dir) {
-			subdir = *dir;
-			size = ((idx - ENTRIES_PER_PAGEPAGE/2) %
+			diroff = ((idx - ENTRIES_PER_PAGEPAGE/2) %
 				ENTRIES_PER_PAGEPAGE) / ENTRIES_PER_PAGE;
-			if (!size && !offset) {
-				empty = subdir;
+			if (!diroff && !offset) {
 				*dir = NULL;
+				nr_pages_to_free++;
+				list_add(&middir->lru, &pages_to_free);
 			}
 			shmem_dir_unmap(dir);
-			dir = shmem_dir_map(subdir) + size;
+			dir = shmem_dir_map(middir);
 		} else {
+			diroff = 0;
 			offset = 0;
 			idx = stage;
 		}
 	}
 
-	for (; idx < limit; idx += ENTRIES_PER_PAGE, dir++) {
+	for (; idx < limit; idx += ENTRIES_PER_PAGE, diroff++) {
 		if (unlikely(idx == stage)) {
-			shmem_dir_unmap(dir-1);
-			dir = shmem_dir_map(info->i_indirect) +
+			shmem_dir_unmap(dir);
+			dir = shmem_dir_map(topdir) +
 			    ENTRIES_PER_PAGE/2 + idx/ENTRIES_PER_PAGEPAGE;
 			while (!*dir) {
 				dir++;
@@ -499,50 +554,43 @@ static void shmem_truncate(struct inode 
 					goto done1;
 			}
 			stage = idx + ENTRIES_PER_PAGEPAGE;
-			subdir = *dir;
+			middir = *dir;
 			*dir = NULL;
+			nr_pages_to_free++;
+			list_add(&middir->lru, &pages_to_free);
 			shmem_dir_unmap(dir);
-			if (empty) {
-				shmem_dir_free(empty);
-				shmem_free_block(inode);
-			}
-			empty = subdir;
-			cond_resched_lock(&info->lock);
-			dir = shmem_dir_map(subdir);
+			cond_resched();
+			dir = shmem_dir_map(middir);
+			diroff = 0;
 		}
-		subdir = *dir;
+		subdir = dir[diroff];
 		if (subdir && subdir->nr_swapped) {
-			ptr = shmem_swp_map(subdir);
 			size = limit - idx;
 			if (size > ENTRIES_PER_PAGE)
 				size = ENTRIES_PER_PAGE;
-			freed = shmem_free_swp(ptr+offset, ptr+size);
-			shmem_swp_unmap(ptr);
-			info->swapped -= freed;
+			freed = shmem_map_and_free_swp(subdir,
+						offset, size, &dir);
+			if (!dir)
+				dir = shmem_dir_map(middir);
+			nr_swaps_freed += freed;
+			if (offset)
+				spin_lock(&info->lock);
 			subdir->nr_swapped -= freed;
+			if (offset)
+				spin_unlock(&info->lock);
 			BUG_ON(subdir->nr_swapped > offset);
 		}
 		if (offset)
 			offset = 0;
 		else if (subdir) {
-			*dir = NULL;
-			shmem_dir_free(subdir);
-			shmem_free_block(inode);
+			dir[diroff] = NULL;
+			nr_pages_to_free++;
+			list_add(&subdir->lru, &pages_to_free);
 		}
 	}
 done1:
-	shmem_dir_unmap(dir-1);
-	if (empty) {
-		shmem_dir_free(empty);
-		shmem_free_block(inode);
-	}
-	if (info->next_index <= SHMEM_NR_DIRECT) {
-		shmem_dir_free(info->i_indirect);
-		info->i_indirect = NULL;
-		shmem_free_block(inode);
-	}
+	shmem_dir_unmap(dir);
 done2:
-	BUG_ON(info->swapped > info->next_index);
 	if (inode->i_mapping->nrpages && (info->flags & SHMEM_PAGEIN)) {
 		/*
 		 * Call truncate_inode_pages again: racing shmem_unuse_inode
@@ -551,13 +599,24 @@ done2:
 		 * Also, though shmem_getpage checks i_size before adding to
 		 * cache, no recheck after: so fix the narrow window there too.
 		 */
-		spin_unlock(&info->lock);
 		truncate_inode_pages(inode->i_mapping, inode->i_size);
-		spin_lock(&info->lock);
 	}
+
+	spin_lock(&info->lock);
 	info->flags &= ~SHMEM_TRUNCATE;
+	info->swapped -= nr_swaps_freed;
+	if (nr_pages_to_free)
+		shmem_free_blocks(inode, nr_pages_to_free);
 	shmem_recalc_inode(inode);
 	spin_unlock(&info->lock);
+
+	/*
+	 * Empty swap vector directory pages to be freed?
+	 */
+	if (!list_empty(&pages_to_free)) {
+		pages_to_free.prev->next = NULL;
+		shmem_free_pages(pages_to_free.next);
+	}
 }
 
 static int shmem_notify_change(struct dentry *dentry, struct iattr *attr)
@@ -665,9 +724,6 @@ static int shmem_unuse_inode(struct shme
 	}
 	if (!info->i_indirect)
 		goto lost2;
-	/* we might be racing with shmem_truncate */
-	if (limit <= SHMEM_NR_DIRECT)
-		goto lost2;
 
 	dir = shmem_dir_map(info->i_indirect);
 	stage = SHMEM_NR_DIRECT + ENTRIES_PER_PAGEPAGE/2;
@@ -1050,7 +1106,7 @@ repeat:
 						    idx);
 			if (!filepage) {
 				shmem_unacct_blocks(info->flags, 1);
-				shmem_free_block(inode);
+				shmem_free_blocks(inode, 1);
 				error = -ENOMEM;
 				goto failed;
 			}
@@ -1068,7 +1124,7 @@ repeat:
 				spin_unlock(&info->lock);
 				page_cache_release(filepage);
 				shmem_unacct_blocks(info->flags, 1);
-				shmem_free_block(inode);
+				shmem_free_blocks(inode, 1);
 				filepage = NULL;
 				if (error)
 					goto failed;

