Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262283AbSJAVqQ>; Tue, 1 Oct 2002 17:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262514AbSJAVqP>; Tue, 1 Oct 2002 17:46:15 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:43548 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S262283AbSJAVpc>; Tue, 1 Oct 2002 17:45:32 -0400
Date: Tue, 1 Oct 2002 22:51:47 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 6/9 highmem metadata 
In-Reply-To: <Pine.LNX.4.44.0210012240470.2602-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210012250490.2602-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wli suffered OOMs because tmpfs was allocating GFP_USER, for its
metadata pages.  This patch allocates them GFP_HIGHUSER (default
mapping->gfp_mask) and uses atomic kmaps to access (KM_USER0 for
upper levels, KM_USER1 for lowest level).  shmem_unuse_inode and
shmem_truncate rewritten alike to avoid repeated maps and unmaps
of the same page: cr's truncate was much more elegant,
but I couldn't quite see how to convert it.

I do wonder whether this patch is a bloat too far for tmpfs, and
even non-highmem configs will be penalised by page_address overhead
(perhaps a further patch could get over that).  There is an attractive
alternative (keep swp_entry_ts in the existing radix-tree, no metadata
pages at all), but we haven't worked out an unhacky interface to that.
For now at least, let's give tmpfs highmem metadata a spin.

--- tmpfs5/include/linux/shmem_fs.h	Tue Oct  1 19:49:14 2002
+++ tmpfs6/include/linux/shmem_fs.h	Tue Oct  1 19:49:19 2002
@@ -13,7 +13,7 @@
 	spinlock_t		lock;
 	unsigned long		next_index;
 	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
-	void		      **i_indirect; /* indirect blocks */
+	struct page	       *i_indirect; /* indirect blocks */
 	unsigned long		alloced;    /* data pages allocated to file */
 	unsigned long		swapped;    /* subtotal assigned to swap */
 	unsigned long		flags;
--- tmpfs5/mm/shmem.c	Tue Oct  1 19:49:14 2002
+++ tmpfs6/mm/shmem.c	Tue Oct  1 19:49:19 2002
@@ -37,9 +37,10 @@
 #define TMPFS_MAGIC	0x01021994
 
 #define ENTRIES_PER_PAGE (PAGE_CACHE_SIZE/sizeof(unsigned long))
+#define ENTRIES_PER_PAGEPAGE (ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
 #define BLOCKS_PER_PAGE  (PAGE_CACHE_SIZE/512)
 
-#define SHMEM_MAX_INDEX  (SHMEM_NR_DIRECT + ENTRIES_PER_PAGE * (ENTRIES_PER_PAGE/2) * (ENTRIES_PER_PAGE+1))
+#define SHMEM_MAX_INDEX  (SHMEM_NR_DIRECT + (ENTRIES_PER_PAGEPAGE/2) * (ENTRIES_PER_PAGE+1))
 #define SHMEM_MAX_BYTES  ((unsigned long long)SHMEM_MAX_INDEX << PAGE_CACHE_SHIFT)
 
 #define VM_ACCT(size)    (((size) + PAGE_CACHE_SIZE - 1) >> PAGE_SHIFT)
@@ -47,6 +48,51 @@
 /* Pretend that each entry is of this size in directory's i_size */
 #define BOGO_DIRENT_SIZE 20
 
+static inline struct page *shmem_dir_alloc(unsigned int gfp_mask)
+{
+	/*
+	 * The above definition of ENTRIES_PER_PAGE, and the use of
+	 * BLOCKS_PER_PAGE on indirect pages, assume PAGE_CACHE_SIZE:
+	 * might be reconsidered if it ever diverges from PAGE_SIZE.
+	 */
+	return alloc_pages(gfp_mask, PAGE_CACHE_SHIFT-PAGE_SHIFT);
+}
+
+static inline void shmem_dir_free(struct page *page)
+{
+	__free_pages(page, PAGE_CACHE_SHIFT-PAGE_SHIFT);
+}
+
+static struct page **shmem_dir_map(struct page *page)
+{
+	return (struct page **)kmap_atomic(page, KM_USER0);
+}
+
+static inline void shmem_dir_unmap(struct page **dir)
+{
+	kunmap_atomic(dir, KM_USER0);
+}
+
+static swp_entry_t *shmem_swp_map(struct page *page)
+{
+	/*
+	 * We have to avoid the unconditional inc_preempt_count()
+	 * in kmap_atomic(), since shmem_swp_unmap() will also be
+	 * applied to the low memory addresses within i_direct[].
+	 * PageHighMem and high_memory tests are good for all arches
+	 * and configs: highmem_start_page and FIXADDR_START are not.
+	 */
+	return PageHighMem(page)?
+		(swp_entry_t *)kmap_atomic(page, KM_USER1):
+		(swp_entry_t *)page_address(page);
+}
+
+static inline void shmem_swp_unmap(swp_entry_t *entry)
+{
+	if (entry >= (swp_entry_t *)high_memory)
+		kunmap_atomic(entry, KM_USER1);
+}
+
 static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
 {
 	return sb->u.generic_sbp;
@@ -116,8 +162,8 @@
  *         all zeros
  *
  * If there is no space allocated yet it will return NULL when
- * page is 0, else it will use the page for the needed block,
- * setting it to 0 on return to indicate that it has been used.
+ * page is NULL, else it will use the page for the needed block,
+ * setting it to NULL on return to indicate that it has been used.
  *
  * The swap vector is organized the following way:
  *
@@ -145,10 +191,11 @@
  * 	      	       +-> 48-51
  * 	      	       +-> 52-55
  */
-static swp_entry_t *shmem_swp_entry(struct shmem_inode_info *info, unsigned long index, unsigned long *page)
+static swp_entry_t *shmem_swp_entry(struct shmem_inode_info *info, unsigned long index, struct page **page)
 {
 	unsigned long offset;
-	void **dir;
+	struct page **dir;
+	struct page *subdir;
 
 	if (index >= info->next_index)
 		return NULL;
@@ -156,8 +203,8 @@
 		return info->i_direct+index;
 	if (!info->i_indirect) {
 		if (page) {
-			info->i_indirect = (void *) *page;
-			*page = 0;
+			info->i_indirect = *page;
+			*page = NULL;
 		}
 		return NULL;			/* need another page */
 	}
@@ -165,30 +212,37 @@
 	index -= SHMEM_NR_DIRECT;
 	offset = index % ENTRIES_PER_PAGE;
 	index /= ENTRIES_PER_PAGE;
-	dir = info->i_indirect + index;
+	dir = shmem_dir_map(info->i_indirect);
 
 	if (index >= ENTRIES_PER_PAGE/2) {
 		index -= ENTRIES_PER_PAGE/2;
-		dir = info->i_indirect + ENTRIES_PER_PAGE/2 
-			+ index/ENTRIES_PER_PAGE;
+		dir += ENTRIES_PER_PAGE/2 + index/ENTRIES_PER_PAGE;
 		index %= ENTRIES_PER_PAGE;
-		if (!*dir) {
+		subdir = *dir;
+		if (!subdir) {
 			if (page) {
-				*dir = (void *) *page;
-				*page = 0;
+				*dir = *page;
+				*page = NULL;
 			}
+			shmem_dir_unmap(dir);
 			return NULL;		/* need another page */
 		}
-		dir = ((void **)*dir) + index;
+		shmem_dir_unmap(dir);
+		dir = shmem_dir_map(subdir);
 	}
 
-	if (!*dir) {
-		if (!page || !*page)
+	dir += index;
+	subdir = *dir;
+	if (!subdir) {
+		if (!page || !(subdir = *page)) {
+			shmem_dir_unmap(dir);
 			return NULL;		/* need a page */
-		*dir = (void *) *page;
-		*page = 0;
+		}
+		*dir = subdir;
+		*page = NULL;
 	}
-	return ((swp_entry_t *)*dir) + offset;
+	shmem_dir_unmap(dir);
+	return shmem_swp_map(subdir) + offset;
 }
 
 /*
@@ -202,7 +256,7 @@
 {
 	struct inode *inode = &info->vfs_inode;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-	unsigned long page = 0;
+	struct page *page = NULL;
 	swp_entry_t *entry;
 
 	while (!(entry = shmem_swp_entry(info, index, &page))) {
@@ -226,7 +280,9 @@
 		spin_unlock(&sbinfo->stat_lock);
 
 		spin_unlock(&info->lock);
-		page = get_zeroed_page(GFP_USER);
+		page = shmem_dir_alloc(inode->i_mapping->gfp_mask);
+		if (page)
+			clear_highpage(page);
 		spin_lock(&info->lock);
 
 		if (!page) {
@@ -237,7 +293,7 @@
 	if (page) {
 		/* another task gave its page, or truncated the file */
 		shmem_free_block(inode);
-		free_page(page);
+		shmem_dir_free(page);
 	}
 	return entry;
 }
@@ -246,133 +302,138 @@
  * shmem_free_swp - free some swap entries in a directory
  *
  * @dir:   pointer to the directory
- * @count: number of entries to scan
+ * @edir:  pointer after last entry of the directory
  */
-static int shmem_free_swp(swp_entry_t *dir, unsigned int count)
+static int shmem_free_swp(swp_entry_t *dir, swp_entry_t *edir)
 {
-	swp_entry_t *ptr, entry;
+	swp_entry_t *ptr;
 	int freed = 0;
 
-	for (ptr = dir; ptr < dir + count; ptr++) {
-		if (!ptr->val)
-			continue;
-		entry = *ptr;
-		*ptr = (swp_entry_t){0};
-		freed++;
-		free_swap_and_cache(entry);
+	for (ptr = dir; ptr < edir; ptr++) {
+		if (ptr->val) {
+			free_swap_and_cache(*ptr);
+			*ptr = (swp_entry_t){0};
+			freed++;
+		}
 	}
 	return freed;
 }
 
-/*
- * shmem_truncate_direct - free the swap entries of a whole doubly
- *                         indirect block
- *
- * @info:	the info structure of the inode
- * @dir:	pointer to the pointer to the block
- * @start:	offset to start from (in pages)
- * @len:	how many pages are stored in this block
- *
- * Returns the number of freed swap entries.
- */
-static inline unsigned long
-shmem_truncate_direct(struct shmem_inode_info *info, swp_entry_t ***dir, unsigned long start, unsigned long len)
+static void shmem_truncate(struct inode *inode)
 {
-	swp_entry_t **last, **ptr;
-	unsigned long off, freed_swp, freed = 0;
-
-	last = *dir + (len + ENTRIES_PER_PAGE-1) / ENTRIES_PER_PAGE;
-	off = start % ENTRIES_PER_PAGE;
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	unsigned long idx;
+	unsigned long size;
+	unsigned long limit;
+	unsigned long stage;
+	struct page **dir;
+	struct page *subdir;
+	struct page *empty;
+	swp_entry_t *ptr;
+	int offset;
 
-	for (ptr = *dir + start/ENTRIES_PER_PAGE; ptr < last; ptr++, off = 0) {
-		if (!*ptr)
-			continue;
+	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
+	idx = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	if (idx >= info->next_index)
+		return;
 
-		if (info->swapped) {
-			freed_swp = shmem_free_swp(*ptr + off,
-						ENTRIES_PER_PAGE - off);
-			info->swapped -= freed_swp;
-			freed += freed_swp;
+	spin_lock(&info->lock);
+	limit = info->next_index;
+	info->next_index = idx;
+	if (info->swapped && idx < SHMEM_NR_DIRECT) {
+		ptr = info->i_direct;
+		size = limit;
+		if (size > SHMEM_NR_DIRECT)
+			size = SHMEM_NR_DIRECT;
+		info->swapped -= shmem_free_swp(ptr+idx, ptr+size);
+	}
+	if (!info->i_indirect)
+		goto done2;
+
+	BUG_ON(limit <= SHMEM_NR_DIRECT);
+	limit -= SHMEM_NR_DIRECT;
+	idx = (idx > SHMEM_NR_DIRECT)? (idx - SHMEM_NR_DIRECT): 0;
+	offset = idx % ENTRIES_PER_PAGE;
+	idx -= offset;
+
+	empty = NULL;
+	dir = shmem_dir_map(info->i_indirect);
+	stage = ENTRIES_PER_PAGEPAGE/2;
+	if (idx < ENTRIES_PER_PAGEPAGE/2)
+		dir += idx/ENTRIES_PER_PAGE;
+	else {
+		dir += ENTRIES_PER_PAGE/2;
+		dir += (idx - ENTRIES_PER_PAGEPAGE/2)/ENTRIES_PER_PAGEPAGE;
+		while (stage <= idx)
+			stage += ENTRIES_PER_PAGEPAGE;
+		if (*dir) {
+			subdir = *dir;
+			size = ((idx - ENTRIES_PER_PAGEPAGE/2) %
+				ENTRIES_PER_PAGEPAGE) / ENTRIES_PER_PAGE;
+			if (!size && !offset) {
+				empty = subdir;
+				*dir = NULL;
+			}
+			shmem_dir_unmap(dir);
+			dir = shmem_dir_map(subdir) + size;
+		} else {
+			offset = 0;
+			idx = stage;
 		}
+	}
 
-		if (!off) {
+	for (; idx < limit; idx += ENTRIES_PER_PAGE, dir++) {
+		if (unlikely(idx == stage)) {
+			shmem_dir_unmap(dir-1);
+			dir = shmem_dir_map(info->i_indirect) +
+			    ENTRIES_PER_PAGE/2 + idx/ENTRIES_PER_PAGEPAGE;
+			while (!*dir) {
+				dir++;
+				idx += ENTRIES_PER_PAGEPAGE;
+				if (idx >= limit)
+					goto done1;
+			}
+			stage = idx + ENTRIES_PER_PAGEPAGE;
+			subdir = *dir;
+			*dir = NULL;
+			shmem_dir_unmap(dir);
+			if (empty) {
+				shmem_dir_free(empty);
+				info->alloced++;
+			}
+			empty = subdir;
+			dir = shmem_dir_map(subdir);
+		}
+		subdir = *dir;
+		if (subdir) {
+			ptr = shmem_swp_map(subdir);
+			size = limit - idx;
+			if (size > ENTRIES_PER_PAGE)
+				size = ENTRIES_PER_PAGE;
+			info->swapped -= shmem_free_swp(ptr+offset, ptr+size);
+			shmem_swp_unmap(ptr);
+		}
+		if (offset)
+			offset = 0;
+		else if (subdir) {
+			*dir = NULL;
+			shmem_dir_free(subdir);
 			info->alloced++;
-			free_page((unsigned long) *ptr);
-			*ptr = 0;
 		}
 	}
-
-	if (!start) {
+done1:
+	shmem_dir_unmap(dir-1);
+	if (empty) {
+		shmem_dir_free(empty);
 		info->alloced++;
-		free_page((unsigned long) *dir);
-		*dir = 0;
-	}
-	return freed;
-}
-
-/*
- * shmem_truncate_indirect - truncate an inode
- *
- * @info:  the info structure of the inode
- * @index: the index to truncate
- *
- * This function locates the last doubly indirect block and calls
- * then shmem_truncate_direct to do the real work
- */
-static inline unsigned long
-shmem_truncate_indirect(struct shmem_inode_info *info, unsigned long index)
-{
-	swp_entry_t ***base;
-	unsigned long baseidx, len, start;
-	unsigned long max = info->next_index-1;
-	unsigned long freed;
-
-	if (max < SHMEM_NR_DIRECT) {
-		info->next_index = index;
-		if (!info->swapped)
-			return 0;
-		freed = shmem_free_swp(info->i_direct + index,
-					SHMEM_NR_DIRECT - index);
-		info->swapped -= freed;
-		return freed;
-	}
-
-	if (max < ENTRIES_PER_PAGE * ENTRIES_PER_PAGE/2 + SHMEM_NR_DIRECT) {
-		max -= SHMEM_NR_DIRECT;
-		base = (swp_entry_t ***) &info->i_indirect;
-		baseidx = SHMEM_NR_DIRECT;
-		len = max+1;
-	} else {
-		max -= ENTRIES_PER_PAGE*ENTRIES_PER_PAGE/2+SHMEM_NR_DIRECT;
-		if (max >= ENTRIES_PER_PAGE*ENTRIES_PER_PAGE*ENTRIES_PER_PAGE/2)
-			BUG();
-
-		baseidx = max & ~(ENTRIES_PER_PAGE*ENTRIES_PER_PAGE-1);
-		base = (swp_entry_t ***) info->i_indirect + ENTRIES_PER_PAGE/2 + baseidx/ENTRIES_PER_PAGE/ENTRIES_PER_PAGE ;
-		len = max - baseidx + 1;
-		baseidx += ENTRIES_PER_PAGE*ENTRIES_PER_PAGE/2+SHMEM_NR_DIRECT;
 	}
-
-	if (index > baseidx) {
-		info->next_index = index;
-		start = index - baseidx;
-	} else {
-		info->next_index = baseidx;
-		start = 0;
+	if (info->next_index <= SHMEM_NR_DIRECT) {
+		shmem_dir_free(info->i_indirect);
+		info->i_indirect = NULL;
+		info->alloced++;
 	}
-	return *base? shmem_truncate_direct(info, base, start, len): 0;
-}
-
-static void shmem_truncate(struct inode *inode)
-{
-	struct shmem_inode_info *info = SHMEM_I(inode);
-	unsigned long index;
-
-	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	spin_lock(&info->lock);
-	while (index < info->next_index)
-		(void) shmem_truncate_indirect(info, index);
+done2:
+	BUG_ON(info->swapped > info->next_index);
 	shmem_recalc_inode(inode);
 	spin_unlock(&info->lock);
 }
@@ -442,46 +503,81 @@
 	clear_inode(inode);
 }
 
-static inline int shmem_find_swp(swp_entry_t entry, swp_entry_t *ptr, swp_entry_t *eptr)
+static inline int shmem_find_swp(swp_entry_t entry, swp_entry_t *dir, swp_entry_t *edir)
 {
-	swp_entry_t *test;
+	swp_entry_t *ptr;
 
-	for (test = ptr; test < eptr; test++) {
-		if (test->val == entry.val)
-			return test - ptr;
+	for (ptr = dir; ptr < edir; ptr++) {
+		if (ptr->val == entry.val)
+			return ptr - dir;
 	}
 	return -1;
 }
 
 static int shmem_unuse_inode(struct shmem_inode_info *info, swp_entry_t entry, struct page *page)
 {
-	swp_entry_t *ptr;
 	unsigned long idx;
+	unsigned long size;
+	unsigned long limit;
+	unsigned long stage;
+	struct page **dir;
+	struct page *subdir;
+	swp_entry_t *ptr;
 	int offset;
 
 	idx = 0;
 	ptr = info->i_direct;
-	spin_lock (&info->lock);
-	offset = info->next_index;
-	if (offset > SHMEM_NR_DIRECT)
-		offset = SHMEM_NR_DIRECT;
-	offset = shmem_find_swp(entry, ptr, ptr + offset);
+	spin_lock(&info->lock);
+	limit = info->next_index;
+	size = limit;
+	if (size > SHMEM_NR_DIRECT)
+		size = SHMEM_NR_DIRECT;
+	offset = shmem_find_swp(entry, ptr, ptr+size);
 	if (offset >= 0)
 		goto found;
-
-	for (idx = SHMEM_NR_DIRECT; idx < info->next_index; 
-	     idx += ENTRIES_PER_PAGE) {
-		ptr = shmem_swp_entry(info, idx, NULL);
-		if (!ptr)
-			continue;
-		offset = info->next_index - idx;
-		if (offset > ENTRIES_PER_PAGE)
-			offset = ENTRIES_PER_PAGE;
-		offset = shmem_find_swp(entry, ptr, ptr + offset);
-		if (offset >= 0)
-			goto found;
+	if (!info->i_indirect)
+		goto lost2;
+	/* we might be racing with shmem_truncate */
+	if (limit <= SHMEM_NR_DIRECT)
+		goto lost2;
+
+	dir = shmem_dir_map(info->i_indirect);
+	stage = SHMEM_NR_DIRECT + ENTRIES_PER_PAGEPAGE/2;
+
+	for (idx = SHMEM_NR_DIRECT; idx < limit; idx += ENTRIES_PER_PAGE, dir++) {
+		if (unlikely(idx == stage)) {
+			shmem_dir_unmap(dir-1);
+			dir = shmem_dir_map(info->i_indirect) +
+			    ENTRIES_PER_PAGE/2 + idx/ENTRIES_PER_PAGEPAGE;
+			while (!*dir) {
+				dir++;
+				idx += ENTRIES_PER_PAGEPAGE;
+				if (idx >= limit)
+					goto lost1;
+			}
+			stage = idx + ENTRIES_PER_PAGEPAGE;
+			subdir = *dir;
+			shmem_dir_unmap(dir);
+			dir = shmem_dir_map(subdir);
+		}
+		subdir = *dir;
+		if (subdir) {
+			ptr = shmem_swp_map(subdir);
+			size = limit - idx;
+			if (size > ENTRIES_PER_PAGE)
+				size = ENTRIES_PER_PAGE;
+			offset = shmem_find_swp(entry, ptr, ptr+size);
+			if (offset >= 0) {
+				shmem_dir_unmap(dir);
+				goto found;
+			}
+			shmem_swp_unmap(ptr);
+		}
 	}
-	spin_unlock (&info->lock);
+lost1:
+	shmem_dir_unmap(dir-1);
+lost2:
+	spin_unlock(&info->lock);
 	return 0;
 found:
 	if (move_from_swap_cache(page, idx + offset,
@@ -489,6 +585,7 @@
 		ptr[offset] = (swp_entry_t) {0};
 		info->swapped--;
 	}
+	shmem_swp_unmap(ptr);
 	spin_unlock(&info->lock);
 	/*
 	 * Decrement swap count even when the entry is left behind:
@@ -561,11 +658,13 @@
 	if (!err) {
 		*entry = swap;
 		info->swapped++;
+		shmem_swp_unmap(entry);
 		spin_unlock(&info->lock);
 		unlock_page(page);
 		return 0;
 	}
 
+	shmem_swp_unmap(entry);
 	spin_unlock(&info->lock);
 	swap_free(swap);
 	return fail_writepage(page);
@@ -635,6 +734,7 @@
 		/* Look it up and read it in.. */
 		page = lookup_swap_cache(swap);
 		if (!page) {
+			shmem_swp_unmap(entry);
 			spin_unlock(&info->lock);
 			swapin_readahead(swap);
 			page = read_swap_cache_async(swap);
@@ -643,8 +743,11 @@
 				entry = shmem_swp_alloc(info, idx);
 				if (IS_ERR(entry))
 					error = PTR_ERR(entry);
-				else if (entry->val == swap.val)
-					error = -ENOMEM;
+				else {
+					if (entry->val == swap.val)
+						error = -ENOMEM;
+					shmem_swp_unmap(entry);
+				}
 				spin_unlock(&info->lock);
 				if (error)
 					return error;
@@ -657,12 +760,14 @@
 
 		/* We have to do this with page locked to prevent races */
 		if (TestSetPageLocked(page)) {
+			shmem_swp_unmap(entry);
 			spin_unlock(&info->lock);
 			wait_on_page_locked(page);
 			page_cache_release(page);
 			goto repeat;
 		}
 		if (PageWriteback(page)) {
+			shmem_swp_unmap(entry);
 			spin_unlock(&info->lock);
 			wait_on_page_writeback(page);
 			unlock_page(page);
@@ -673,6 +778,7 @@
 		error = PageUptodate(page)?
 			move_from_swap_cache(page, idx, mapping): -EIO;
 		if (error) {
+			shmem_swp_unmap(entry);
 			spin_unlock(&info->lock);
 			unlock_page(page);
 			page_cache_release(page);
@@ -681,9 +787,11 @@
 
 		*entry = (swp_entry_t) {0};
 		info->swapped--;
-		spin_unlock (&info->lock);
+		shmem_swp_unmap(entry);
+		spin_unlock(&info->lock);
 		swap_free(swap);
 	} else {
+		shmem_swp_unmap(entry);
 		spin_unlock(&info->lock);
 		sbinfo = SHMEM_SB(inode->i_sb);
 		spin_lock(&sbinfo->stat_lock);
@@ -705,7 +813,11 @@
 		entry = shmem_swp_alloc(info, idx);
 		if (IS_ERR(entry))
 			error = PTR_ERR(entry);
-		if (error || entry->val ||
+		else {
+			swap = *entry;
+			shmem_swp_unmap(entry);
+		}
+		if (error || swap.val ||
 		    add_to_page_cache_lru(page, mapping, idx) < 0) {
 			spin_unlock(&info->lock);
 			page_cache_release(page);
@@ -741,8 +853,10 @@
 	page = find_get_page(inode->i_mapping, idx);
 	if (!page) {
 		entry = shmem_swp_entry(info, idx, NULL);
-		if (entry)
+		if (entry) {
 			swap = *entry;
+			shmem_swp_unmap(entry);
+		}
 	}
 	spin_unlock(&info->lock);
 	if (swap.val) {

