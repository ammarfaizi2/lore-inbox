Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262837AbSJAVlj>; Tue, 1 Oct 2002 17:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262525AbSJAVlj>; Tue, 1 Oct 2002 17:41:39 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:22249 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S262837AbSJAVla>; Tue, 1 Oct 2002 17:41:30 -0400
Date: Tue, 1 Oct 2002 22:47:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 3/9 remove info->sem
In-Reply-To: <Pine.LNX.4.44.0210012240470.2602-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210012246360.2602-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Between inode->i_sem and info->lock comes info->sem; but it doesn't
guard thoroughly against the difficult races (truncate during read),
and serializes reads from tmpfs unlike other filesystems.  I'd prefer
to work with just i_sem and info->lock, backtracking when necessary
(when another task allocates block or metablock at the same time).

(I am not satisfied with the locked setting of next_index at the
start of shmem_getpage_locked: it's one lock hold too many, and
it doesn't really fix races against truncate better than before:
another patch in a later batch will resolve that.)

--- tmpfs2/include/linux/shmem_fs.h	Thu Aug  1 23:58:33 2002
+++ tmpfs3/include/linux/shmem_fs.h	Tue Oct  1 19:49:04 2002
@@ -11,7 +11,6 @@
 
 struct shmem_inode_info {
 	spinlock_t		lock;
-	struct semaphore 	sem;
 	unsigned long		next_index;
 	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
 	void		      **i_indirect; /* indirect blocks */
--- tmpfs2/mm/shmem.c	Tue Oct  1 19:48:59 2002
+++ tmpfs3/mm/shmem.c	Tue Oct  1 19:49:04 2002
@@ -111,11 +111,9 @@
  * @page:  optional page to add to the structure. Has to be preset to
  *         all zeros
  *
- * If there is no space allocated yet it will return -ENOMEM when
- * page == 0 else it will use the page for the needed block.
- *
- * returns -EFBIG if the index is too big.
- *
+ * If there is no space allocated yet it will return NULL when
+ * page is 0, else it will use the page for the needed block,
+ * setting it to 0 on return to indicate that it has been used.
  *
  * The swap vector is organized the following way:
  *
@@ -143,70 +141,80 @@
  * 	      	       +-> 48-51
  * 	      	       +-> 52-55
  */
-static swp_entry_t * shmem_swp_entry (struct shmem_inode_info *info, unsigned long index, unsigned long page) 
+static swp_entry_t *shmem_swp_entry(struct shmem_inode_info *info, unsigned long index, unsigned long *page)
 {
 	unsigned long offset;
 	void **dir;
 
+	if (index >= info->next_index)
+		return NULL;
 	if (index < SHMEM_NR_DIRECT)
 		return info->i_direct+index;
+	if (!info->i_indirect) {
+		if (page) {
+			info->i_indirect = (void *) *page;
+			*page = 0;
+		}
+		return NULL;			/* need another page */
+	}
 
 	index -= SHMEM_NR_DIRECT;
 	offset = index % ENTRIES_PER_PAGE;
 	index /= ENTRIES_PER_PAGE;
-
-	if (!info->i_indirect) {
-		info->i_indirect = (void *) page;
-		return ERR_PTR(-ENOMEM);
-	}
-
 	dir = info->i_indirect + index;
+
 	if (index >= ENTRIES_PER_PAGE/2) {
 		index -= ENTRIES_PER_PAGE/2;
 		dir = info->i_indirect + ENTRIES_PER_PAGE/2 
 			+ index/ENTRIES_PER_PAGE;
 		index %= ENTRIES_PER_PAGE;
-
-		if(!*dir) {
-			*dir = (void *) page;
-			/* We return since we will need another page
-                           in the next step */
-			return ERR_PTR(-ENOMEM);
+		if (!*dir) {
+			if (page) {
+				*dir = (void *) *page;
+				*page = 0;
+			}
+			return NULL;		/* need another page */
 		}
 		dir = ((void **)*dir) + index;
 	}
+
 	if (!*dir) {
-		if (!page)
-			return ERR_PTR(-ENOMEM);
-		*dir = (void *)page;
+		if (!page || !*page)
+			return NULL;		/* need a page */
+		*dir = (void *) *page;
+		*page = 0;
 	}
 	return ((swp_entry_t *)*dir) + offset;
 }
 
 /*
- * shmem_alloc_entry - get the position of the swap entry for the
- *                     page. If it does not exist allocate the entry
+ * shmem_swp_alloc - get the position of the swap entry for the page.
+ *                   If it does not exist allocate the entry.
  *
  * @info:	info structure for the inode
  * @index:	index of the page to find
  */
-static inline swp_entry_t * shmem_alloc_entry (struct shmem_inode_info *info, unsigned long index)
+static swp_entry_t *shmem_swp_alloc(struct shmem_inode_info *info, unsigned long index)
 {
 	unsigned long page = 0;
-	swp_entry_t * res;
-
-	if (index >= SHMEM_MAX_INDEX)
-		return ERR_PTR(-EFBIG);
-
-	if (info->next_index <= index)
-		info->next_index = index + 1;
+	swp_entry_t *entry;
 
-	while ((res = shmem_swp_entry(info,index,page)) == ERR_PTR(-ENOMEM)) {
+	while (!(entry = shmem_swp_entry(info, index, &page))) {
+		if (index >= info->next_index) {
+			entry = ERR_PTR(-EFAULT);
+			break;
+		}
+		spin_unlock(&info->lock);
 		page = get_zeroed_page(GFP_USER);
+		spin_lock(&info->lock);
 		if (!page)
-			break;
+			return ERR_PTR(-ENOMEM);
+	}
+	if (page) {
+		/* another task gave its page, or truncated the file */
+		free_page(page);
 	}
-	return res;
+	return entry;
 }
 
 /*
@@ -330,17 +338,15 @@
 	unsigned long freed = 0;
 	struct shmem_inode_info * info = SHMEM_I(inode);
 
-	down(&info->sem);
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
-	spin_lock (&info->lock);
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	spin_lock (&info->lock);
 	while (index < info->next_index) 
 		freed += shmem_truncate_indirect(info, index);
 
 	info->swapped -= freed;
 	shmem_recalc_inode(inode);
 	spin_unlock (&info->lock);
-	up(&info->sem);
 }
 
 static int shmem_notify_change(struct dentry *dentry, struct iattr *attr)
@@ -436,8 +442,8 @@
 
 	for (idx = SHMEM_NR_DIRECT; idx < info->next_index; 
 	     idx += ENTRIES_PER_PAGE) {
-		ptr = shmem_swp_entry(info, idx, 0);
-		if (IS_ERR(ptr))
+		ptr = shmem_swp_entry(info, idx, NULL);
+		if (!ptr)
 			continue;
 		offset = info->next_index - idx;
 		if (offset > ENTRIES_PER_PAGE)
@@ -519,10 +525,10 @@
 		return fail_writepage(page);
 
 	spin_lock(&info->lock);
-	entry = shmem_swp_entry(info, index, 0);
-	if (IS_ERR(entry))	/* this had been allocated on page allocation */
-		BUG();
 	shmem_recalc_inode(inode);
+	entry = shmem_swp_entry(info, index, NULL);
+	if (!entry)
+		BUG();
 	if (entry->val)
 		BUG();
 
@@ -570,61 +576,68 @@
 	struct shmem_sb_info *sbinfo;
 	struct page *page;
 	swp_entry_t *entry;
-	int error;
+	swp_entry_t swap;
+	int error = 0;
+
+	if (idx >= SHMEM_MAX_INDEX)
+		return ERR_PTR(-EFBIG);
+
+	/*
+	 * When writing, i_sem is held against truncation and other
+	 * writing, so next_index will remain as set here; but when
+	 * reading, idx must always be checked against next_index
+	 * after sleeping, lest truncation occurred meanwhile.
+	 */
+	spin_lock(&info->lock);
+	if (info->next_index <= idx)
+		info->next_index = idx + 1;
+	spin_unlock(&info->lock);
 
 repeat:
 	page = find_lock_page(mapping, idx);
 	if (page)
 		return page;
 
-	entry = shmem_alloc_entry (info, idx);
-	if (IS_ERR(entry))
+	spin_lock(&info->lock);
+	shmem_recalc_inode(inode);
+	entry = shmem_swp_alloc(info, idx);
+	if (IS_ERR(entry)) {
+		spin_unlock(&info->lock);
 		return (void *)entry;
-
-	spin_lock (&info->lock);
-	
-	/* The shmem_alloc_entry() call may have blocked, and
-	 * shmem_writepage may have been moving a page between the page
-	 * cache and swap cache.  We need to recheck the page cache
-	 * under the protection of the info->lock spinlock. */
-
-	page = find_get_page(mapping, idx);
-	if (page) {
-		if (TestSetPageLocked(page))
-			goto wait_retry;
-		spin_unlock (&info->lock);
-		return page;
 	}
-	
-	shmem_recalc_inode(inode);
-	if (entry->val) {
+	swap = *entry;
+
+	if (swap.val) {
 		/* Look it up and read it in.. */
-		page = lookup_swap_cache(*entry);
+		page = lookup_swap_cache(swap);
 		if (!page) {
-			swp_entry_t swap = *entry;
-			spin_unlock (&info->lock);
-			swapin_readahead(*entry);
-			page = read_swap_cache_async(*entry);
+			spin_unlock(&info->lock);
+			swapin_readahead(swap);
+			page = read_swap_cache_async(swap);
 			if (!page) {
-				if (entry->val != swap.val)
-					goto repeat;
-				return ERR_PTR(-ENOMEM);
+				spin_lock(&info->lock);
+				entry = shmem_swp_alloc(info, idx);
+				if (IS_ERR(entry))
+					error = PTR_ERR(entry);
+				else if (entry->val == swap.val)
+					error = -ENOMEM;
+				spin_unlock(&info->lock);
+				if (error)
+					return ERR_PTR(error);
+				goto repeat;
 			}
 			wait_on_page_locked(page);
-			if (!PageUptodate(page) && entry->val == swap.val) {
-				page_cache_release(page);
-				return ERR_PTR(-EIO);
-			}
-			
-			/* Too bad we can't trust this page, because we
-			 * dropped the info->lock spinlock */
 			page_cache_release(page);
 			goto repeat;
 		}
 
 		/* We have to do this with page locked to prevent races */
-		if (TestSetPageLocked(page))
-			goto wait_retry;
+		if (TestSetPageLocked(page)) {
+			spin_unlock(&info->lock);
+			wait_on_page_locked(page);
+			page_cache_release(page);
+			goto repeat;
+		}
 		if (PageWriteback(page)) {
 			spin_unlock(&info->lock);
 			wait_on_page_writeback(page);
@@ -632,42 +645,55 @@
 			page_cache_release(page);
 			goto repeat;
 		}
-		error = move_from_swap_cache(page, idx, mapping);
-		if (error < 0) {
+
+		error = PageUptodate(page)?
+			move_from_swap_cache(page, idx, mapping): -EIO;
+		if (error) {
 			spin_unlock(&info->lock);
 			unlock_page(page);
 			page_cache_release(page);
 			return ERR_PTR(error);
 		}
 
-		swap_free(*entry);
 		*entry = (swp_entry_t) {0};
 		info->swapped--;
 		spin_unlock (&info->lock);
+		swap_free(swap);
 	} else {
+		spin_unlock(&info->lock);
 		sbinfo = SHMEM_SB(inode->i_sb);
-		spin_unlock (&info->lock);
-		spin_lock (&sbinfo->stat_lock);
-		if (sbinfo->free_blocks == 0)
-			goto no_space;
+		spin_lock(&sbinfo->stat_lock);
+		if (sbinfo->free_blocks == 0) {
+			spin_unlock(&sbinfo->stat_lock);
+			return ERR_PTR(-ENOSPC);
+		}
 		sbinfo->free_blocks--;
-		spin_unlock (&sbinfo->stat_lock);
+		spin_unlock(&sbinfo->stat_lock);
 
-		/* Ok, get a new page.  We don't have to worry about the
-		 * info->lock spinlock here: we cannot race against
-		 * shm_writepage because we have already verified that
-		 * there is no page present either in memory or in the
-		 * swap cache, so we are guaranteed to be populating a
-		 * new shm entry.  The inode semaphore we already hold
-		 * is enough to make this atomic. */
 		page = page_cache_alloc(mapping);
-		if (!page)
-			goto no_mem;
-		error = add_to_page_cache_lru(page, mapping, idx);
-		if (error < 0) {
+		if (!page) {
+			spin_lock(&sbinfo->stat_lock);
+			sbinfo->free_blocks++;
+			spin_unlock(&sbinfo->stat_lock);
+			return ERR_PTR(-ENOMEM);
+		}
+
+		spin_lock(&info->lock);
+		entry = shmem_swp_alloc(info, idx);
+		if (IS_ERR(entry))
+			error = PTR_ERR(entry);
+		if (error || entry->val ||
+		    add_to_page_cache_lru(page, mapping, idx) < 0) {
+			spin_unlock(&info->lock);
 			page_cache_release(page);
-			goto no_mem;
+			spin_lock(&sbinfo->stat_lock);
+			sbinfo->free_blocks++;
+			spin_unlock(&sbinfo->stat_lock);
+			if (error)
+				return ERR_PTR(error);
+			goto repeat;
 		}
+		spin_unlock(&info->lock);
 		clear_highpage(page);
 		inode->i_blocks += BLOCKS_PER_PAGE;
 	}
@@ -675,22 +701,6 @@
 	/* We have the page */
 	SetPageUptodate(page);
 	return page;
-
-no_mem:
-	spin_lock(&sbinfo->stat_lock);
-	sbinfo->free_blocks++;
-	spin_unlock(&sbinfo->stat_lock);
-	return ERR_PTR(-ENOMEM);
-
-no_space:
-	spin_unlock (&sbinfo->stat_lock);
-	return ERR_PTR(-ENOSPC);
-
-wait_retry:
-	spin_unlock(&info->lock);
-	wait_on_page_locked(page);
-	page_cache_release(page);
-	goto repeat;
 }
 
 static int shmem_getpage(struct inode * inode, unsigned long idx, struct page **ptr)
@@ -698,7 +708,6 @@
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	int error;
 
-	down (&info->sem);
 	*ptr = ERR_PTR(-EFAULT);
 	if (inode->i_size <= (loff_t) idx * PAGE_CACHE_SIZE)
 		goto failed;
@@ -708,10 +717,8 @@
 		goto failed;
 
 	unlock_page(*ptr);
-	up (&info->sem);
 	return 0;
 failed:
-	up (&info->sem);
 	error = PTR_ERR(*ptr);
 	*ptr = NOPAGE_SIGBUS;
 	if (error == -ENOMEM)
@@ -734,8 +741,8 @@
 	spin_lock(&info->lock);
 	page = find_get_page(inode->i_mapping, idx);
 	if (!page) {
-		entry = shmem_swp_entry(info, idx, 0);
-		if (!IS_ERR(entry))
+		entry = shmem_swp_entry(info, idx, NULL);
+		if (entry)
 			swap = *entry;
 	}
 	spin_unlock(&info->lock);
@@ -814,12 +821,8 @@
 		inode->i_mapping->backing_dev_info = &shmem_backing_dev_info;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		info = SHMEM_I(inode);
-		spin_lock_init (&info->lock);
-		sema_init (&info->sem, 1);
-		info->next_index = 0;
-		memset (info->i_direct, 0, sizeof(info->i_direct));
-		info->i_indirect = NULL;
-		info->swapped = 0;
+		memset(info, 0, (char *)inode - (char *)info);
+		spin_lock_init(&info->lock);
 		info->flags = VM_ACCOUNT;
 		switch (mode & S_IFMT) {
 		default:
@@ -971,9 +974,7 @@
 		}
 
 		info = SHMEM_I(inode);
-		down (&info->sem);
 		page = shmem_getpage_locked(info, inode, index);
-		up (&info->sem);
 
 		status = PTR_ERR(page);
 		if (IS_ERR(page))
@@ -1041,17 +1042,33 @@
 		end_index = inode->i_size >> PAGE_CACHE_SHIFT;
 		if (index > end_index)
 			break;
-		nr = PAGE_CACHE_SIZE;
 		if (index == end_index) {
 			nr = inode->i_size & ~PAGE_CACHE_MASK;
 			if (nr <= offset)
 				break;
 		}
 
-		nr = nr - offset;
-
-		if ((desc->error = shmem_getpage(inode, index, &page)))
+		desc->error = shmem_getpage(inode, index, &page);
+		if (desc->error) {
+			if (desc->error == -EFAULT)
+				desc->error = 0;
 			break;
+		}
+
+		/*
+		 * We must evaluate after, since reads (unlike writes)
+		 * are called without i_sem protection against truncate
+		 */
+		nr = PAGE_CACHE_SIZE;
+		end_index = inode->i_size >> PAGE_CACHE_SHIFT;
+		if (index == end_index) {
+			nr = inode->i_size & ~PAGE_CACHE_MASK;
+			if (nr <= offset) {
+				page_cache_release(page);
+				break;
+			}
+		}
+		nr -= offset;
 
 		if (!list_empty(&mapping->i_mmap_shared))
 			flush_dcache_page(page);
@@ -1279,10 +1296,8 @@
 			iput(inode);
 			return -ENOMEM;
 		}
-		down(&info->sem);
 		page = shmem_getpage_locked(info, inode, 0);
 		if (IS_ERR(page)) {
-			up(&info->sem);
 			vm_unacct_memory(VM_ACCT(1));
 			iput(inode);
 			return PTR_ERR(page);
@@ -1297,7 +1312,6 @@
 		set_page_dirty(page);
 		unlock_page(page);
 		page_cache_release(page);
-		up(&info->sem);
 	}
 	dir->i_size += BOGO_DIRENT_SIZE;
 	dir->i_ctime = dir->i_mtime = CURRENT_TIME;

