Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261515AbSJAVov>; Tue, 1 Oct 2002 17:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262279AbSJAVou>; Tue, 1 Oct 2002 17:44:50 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:4114 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S261515AbSJAVo3>; Tue, 1 Oct 2002 17:44:29 -0400
Date: Tue, 1 Oct 2002 22:50:43 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 5/9 shmem_free_block alloced 
In-Reply-To: <Pine.LNX.4.44.0210012240470.2602-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210012248521.2602-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm and wli each discovered unfortunate behaviour of dbench on tmpfs:
after tmpfs has reached its data memory limit, dbench continues to lseek
and write, and tmpfs carries on allocating unlimited metadata blocks to
accommodate the data it then refuses.  That particular behaviour could
be simply fixed by checking earlier; but I think tmpfs metablocks should
be subject to the memory limit, and included in df and du accounting.
Also, manipulate inode->i_blocks under lock, was missed before.

--- tmpfs4/include/linux/shmem_fs.h	Tue Oct  1 19:49:04 2002
+++ tmpfs5/include/linux/shmem_fs.h	Tue Oct  1 19:49:14 2002
@@ -14,7 +14,8 @@
 	unsigned long		next_index;
 	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
 	void		      **i_indirect; /* indirect blocks */
-	unsigned long		swapped;
+	unsigned long		alloced;    /* data pages allocated to file */
+	unsigned long		swapped;    /* subtotal assigned to swap */
 	unsigned long		flags;
 	struct list_head	list;
 	struct inode		vfs_inode;
--- tmpfs4/mm/shmem.c	Tue Oct  1 19:49:09 2002
+++ tmpfs5/mm/shmem.c	Tue Oct  1 19:49:14 2002
@@ -68,38 +68,42 @@
 static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
 atomic_t shmem_nrpages = ATOMIC_INIT(0); /* Not used right now */
 
+static void shmem_free_block(struct inode *inode)
+{
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+	spin_lock(&sbinfo->stat_lock);
+	sbinfo->free_blocks++;
+	inode->i_blocks -= BLOCKS_PER_PAGE;
+	spin_unlock(&sbinfo->stat_lock);
+}
+
 /*
  * shmem_recalc_inode - recalculate the size of an inode
  *
  * @inode: inode to recalc
- * @swap:  additional swap pages freed externally
  *
- * We have to calculate the free blocks since the mm can drop pages
- * behind our back
+ * We have to calculate the free blocks since the mm can drop
+ * undirtied hole pages behind our back.  Later we should be
+ * able to use the releasepage method to handle this better.
  *
- * But we know that normally
- * inodes->i_blocks/BLOCKS_PER_PAGE == 
- * 			inode->i_mapping->nrpages + info->swapped
- *
- * So the mm freed 
- * inodes->i_blocks/BLOCKS_PER_PAGE - 
- * 			(inode->i_mapping->nrpages + info->swapped)
+ * But normally   info->alloced == inode->i_mapping->nrpages + info->swapped
+ * So mm freed is info->alloced - (inode->i_mapping->nrpages + info->swapped)
  *
  * It has to be called with the spinlock held.
  */
-
 static void shmem_recalc_inode(struct inode * inode)
 {
-	unsigned long freed;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	long freed;
 
-	freed = (inode->i_blocks/BLOCKS_PER_PAGE) -
-		(inode->i_mapping->nrpages + SHMEM_I(inode)->swapped);
-	if (freed){
-		struct shmem_sb_info * sbinfo = SHMEM_SB(inode->i_sb);
-		inode->i_blocks -= freed*BLOCKS_PER_PAGE;
-		spin_lock (&sbinfo->stat_lock);
+	freed = info->alloced - info->swapped - inode->i_mapping->nrpages;
+	if (freed > 0) {
+		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+		info->alloced -= freed;
+		spin_lock(&sbinfo->stat_lock);
 		sbinfo->free_blocks += freed;
-		spin_unlock (&sbinfo->stat_lock);
+		inode->i_blocks -= freed*BLOCKS_PER_PAGE;
+		spin_unlock(&sbinfo->stat_lock);
 	}
 }
 
@@ -196,6 +200,8 @@
  */
 static swp_entry_t *shmem_swp_alloc(struct shmem_inode_info *info, unsigned long index)
 {
+	struct inode *inode = &info->vfs_inode;
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	unsigned long page = 0;
 	swp_entry_t *entry;
 
@@ -204,14 +210,33 @@
 			entry = ERR_PTR(-EFAULT);
 			break;
 		}
+
+		/*
+		 * Test free_blocks against 1 not 0, since we have 1 data
+		 * page (and perhaps indirect index pages) yet to allocate:
+		 * a waste to allocate index if we cannot allocate data.
+		 */
+		spin_lock(&sbinfo->stat_lock);
+		if (sbinfo->free_blocks <= 1) {
+			spin_unlock(&sbinfo->stat_lock);
+			return ERR_PTR(-ENOSPC);
+		}
+		sbinfo->free_blocks--;
+		inode->i_blocks += BLOCKS_PER_PAGE;
+		spin_unlock(&sbinfo->stat_lock);
+
 		spin_unlock(&info->lock);
 		page = get_zeroed_page(GFP_USER);
 		spin_lock(&info->lock);
-		if (!page)
+
+		if (!page) {
+			shmem_free_block(inode);
 			return ERR_PTR(-ENOMEM);
+		}
 	}
 	if (page) {
 		/* another task gave its page, or truncated the file */
+		shmem_free_block(inode);
 		free_page(page);
 	}
 	return entry;
@@ -243,41 +268,42 @@
  * shmem_truncate_direct - free the swap entries of a whole doubly
  *                         indirect block
  *
+ * @info:	the info structure of the inode
  * @dir:	pointer to the pointer to the block
  * @start:	offset to start from (in pages)
  * @len:	how many pages are stored in this block
  *
  * Returns the number of freed swap entries.
  */
-
-static inline unsigned long 
-shmem_truncate_direct(swp_entry_t *** dir, unsigned long start, unsigned long len) {
+static inline unsigned long
+shmem_truncate_direct(struct shmem_inode_info *info, swp_entry_t ***dir, unsigned long start, unsigned long len)
+{
 	swp_entry_t **last, **ptr;
-	unsigned long off, freed = 0;
- 
-	if (!*dir)
-		return 0;
+	unsigned long off, freed_swp, freed = 0;
 
 	last = *dir + (len + ENTRIES_PER_PAGE-1) / ENTRIES_PER_PAGE;
 	off = start % ENTRIES_PER_PAGE;
 
-	for (ptr = *dir + start/ENTRIES_PER_PAGE; ptr < last; ptr++) {
-		if (!*ptr) {
-			off = 0;
+	for (ptr = *dir + start/ENTRIES_PER_PAGE; ptr < last; ptr++, off = 0) {
+		if (!*ptr)
 			continue;
+
+		if (info->swapped) {
+			freed_swp = shmem_free_swp(*ptr + off,
+						ENTRIES_PER_PAGE - off);
+			info->swapped -= freed_swp;
+			freed += freed_swp;
 		}
 
 		if (!off) {
-			freed += shmem_free_swp(*ptr, ENTRIES_PER_PAGE);
-			free_page ((unsigned long) *ptr);
+			info->alloced++;
+			free_page((unsigned long) *ptr);
 			*ptr = 0;
-		} else {
-			freed += shmem_free_swp(*ptr+off,ENTRIES_PER_PAGE-off);
-			off = 0;
 		}
 	}
-	
+
 	if (!start) {
+		info->alloced++;
 		free_page((unsigned long) *dir);
 		*dir = 0;
 	}
@@ -299,11 +325,16 @@
 	swp_entry_t ***base;
 	unsigned long baseidx, len, start;
 	unsigned long max = info->next_index-1;
+	unsigned long freed;
 
 	if (max < SHMEM_NR_DIRECT) {
 		info->next_index = index;
-		return shmem_free_swp(info->i_direct + index,
-				      SHMEM_NR_DIRECT - index);
+		if (!info->swapped)
+			return 0;
+		freed = shmem_free_swp(info->i_direct + index,
+					SHMEM_NR_DIRECT - index);
+		info->swapped -= freed;
+		return freed;
 	}
 
 	if (max < ENTRIES_PER_PAGE * ENTRIES_PER_PAGE/2 + SHMEM_NR_DIRECT) {
@@ -329,24 +360,21 @@
 		info->next_index = baseidx;
 		start = 0;
 	}
-	return shmem_truncate_direct(base, start, len);
+	return *base? shmem_truncate_direct(info, base, start, len): 0;
 }
 
-static void shmem_truncate (struct inode * inode)
+static void shmem_truncate(struct inode *inode)
 {
+	struct shmem_inode_info *info = SHMEM_I(inode);
 	unsigned long index;
-	unsigned long freed = 0;
-	struct shmem_inode_info * info = SHMEM_I(inode);
 
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	spin_lock (&info->lock);
-	while (index < info->next_index) 
-		freed += shmem_truncate_indirect(info, index);
-
-	info->swapped -= freed;
+	spin_lock(&info->lock);
+	while (index < info->next_index)
+		(void) shmem_truncate_indirect(info, index);
 	shmem_recalc_inode(inode);
-	spin_unlock (&info->lock);
+	spin_unlock(&info->lock);
 }
 
 static int shmem_notify_change(struct dentry *dentry, struct iattr *attr)
@@ -407,6 +435,7 @@
 		inode->i_size = 0;
 		shmem_truncate (inode);
 	}
+	BUG_ON(inode->i_blocks);
 	spin_lock (&sbinfo->stat_lock);
 	sbinfo->free_inodes++;
 	spin_unlock (&sbinfo->stat_lock);
@@ -663,13 +692,12 @@
 			return -ENOSPC;
 		}
 		sbinfo->free_blocks--;
+		inode->i_blocks += BLOCKS_PER_PAGE;
 		spin_unlock(&sbinfo->stat_lock);
 
 		page = page_cache_alloc(mapping);
 		if (!page) {
-			spin_lock(&sbinfo->stat_lock);
-			sbinfo->free_blocks++;
-			spin_unlock(&sbinfo->stat_lock);
+			shmem_free_block(inode);
 			return -ENOMEM;
 		}
 
@@ -681,16 +709,14 @@
 		    add_to_page_cache_lru(page, mapping, idx) < 0) {
 			spin_unlock(&info->lock);
 			page_cache_release(page);
-			spin_lock(&sbinfo->stat_lock);
-			sbinfo->free_blocks++;
-			spin_unlock(&sbinfo->stat_lock);
+			shmem_free_block(inode);
 			if (error)
 				return error;
 			goto repeat;
 		}
+		info->alloced++;
 		spin_unlock(&info->lock);
 		clear_highpage(page);
-		inode->i_blocks += BLOCKS_PER_PAGE;
 	}
 
 	/* We have the page */

