Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129465AbQL0LBJ>; Wed, 27 Dec 2000 06:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129742AbQL0LBA>; Wed, 27 Dec 2000 06:01:00 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:45255 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129455AbQL0LAp>; Wed, 27 Dec 2000 06:00:45 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: [Patch] shmem_unuse race fix
From: Christoph Rohland <cr@sap.com>
Message-ID: <m3k88mb28v.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: 27 Dec 2000 11:32:35 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following patch (against clean test13-pre4) removes the races in
shmem_unuse. I changed inode.c to not lock the inode if there is no
write_inode function. So I can grab the inode while holding the
spinlock.

It also optimises the shmem_ftruncate behaviour.

BTW: The generic swapoff path itself has still races if a process is
paging in a page which is just freed on swap by try_to_unuse. It gives
'VM: bad swap entries' and worse. But this is not shmem
specific. Marcelo would you like to look into this?

Greetings
                Christoph

--- 4-13-4/fs/inode.c	Sun Dec 17 12:54:00 2000
+++ c/fs/inode.c	Wed Dec 27 11:02:59 2000
@@ -168,13 +168,6 @@
 		__wait_on_inode(inode);
 }
 
-
-static inline void write_inode(struct inode *inode, int sync)
-{
-	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->write_inode)
-		inode->i_sb->s_op->write_inode(inode, sync);
-}
-
 static inline void __iget(struct inode * inode)
 {
 	if (atomic_read(&inode->i_count)) {
@@ -202,16 +195,20 @@
 		list_add(&inode->i_list, atomic_read(&inode->i_count)
 							? &inode_in_use
 							: &inode_unused);
-		/* Set I_LOCK, reset I_DIRTY */
-		inode->i_state |= I_LOCK;
-		inode->i_state &= ~I_DIRTY;
-		spin_unlock(&inode_lock);
+		if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->write_inode) {
+                        /* Set I_LOCK, reset I_DIRTY */
+                        inode->i_state |= I_LOCK;
+                        inode->i_state &= ~I_DIRTY;
+                        spin_unlock(&inode_lock);
 
-		write_inode(inode, sync);
+                        inode->i_sb->s_op->write_inode(inode, sync);
 
-		spin_lock(&inode_lock);
-		inode->i_state &= ~I_LOCK;
-		wake_up(&inode->i_wait);
+                        spin_lock(&inode_lock);
+                        inode->i_state &= ~I_LOCK;
+                        wake_up(&inode->i_wait);
+                        return;
+                }
+                inode->i_state &= ~I_DIRTY;
 	}
 }
 
diff -uNr 4-13-4/include/linux/shmem_fs.h c/include/linux/shmem_fs.h
--- 4-13-4/include/linux/shmem_fs.h	Fri Dec 22 10:05:38 2000
+++ c/include/linux/shmem_fs.h	Tue Dec 26 18:52:29 2000
@@ -19,6 +19,7 @@
 
 struct shmem_inode_info {
 	spinlock_t	lock;
+	unsigned long	max_index;
 	swp_entry_t	i_direct[SHMEM_NR_DIRECT]; /* for the first blocks */
 	swp_entry_t   **i_indirect; /* doubly indirect blocks */
 	unsigned long	swapped;
diff -uNr 4-13-4/mm/shmem.c c/mm/shmem.c
--- 4-13-4/mm/shmem.c	Fri Dec 22 10:05:38 2000
+++ c/mm/shmem.c	Tue Dec 26 20:00:32 2000
@@ -51,11 +51,16 @@
 
 static swp_entry_t * shmem_swp_entry (struct shmem_inode_info *info, unsigned long index) 
 {
+	unsigned long offset;
+
 	if (index < SHMEM_NR_DIRECT)
 		return info->i_direct+index;
 
 	index -= SHMEM_NR_DIRECT;
-	if (index >= ENTRIES_PER_PAGE*ENTRIES_PER_PAGE)
+	offset = index % ENTRIES_PER_PAGE;
+	index /= ENTRIES_PER_PAGE;
+
+	if (index >= ENTRIES_PER_PAGE)
 		return NULL;
 
 	if (!info->i_indirect) {
@@ -63,13 +68,13 @@
 		if (!info->i_indirect)
 			return NULL;
 	}
-	if(!(info->i_indirect[index/ENTRIES_PER_PAGE])) {
-		info->i_indirect[index/ENTRIES_PER_PAGE] = (swp_entry_t *) get_zeroed_page(GFP_USER);
-		if (!info->i_indirect[index/ENTRIES_PER_PAGE])
+	if(!(info->i_indirect[index])) {
+		info->i_indirect[index] = (swp_entry_t *) get_zeroed_page(GFP_USER);
+		if (!info->i_indirect[index])
 			return NULL;
 	}
 	
-	return info->i_indirect[index/ENTRIES_PER_PAGE]+index%ENTRIES_PER_PAGE;
+	return info->i_indirect[index]+offset;
 }
 
 static int shmem_free_swp(swp_entry_t *dir, unsigned int count)
@@ -99,7 +104,6 @@
  * @dir:	pointer to swp_entries 
  * @size:	number of entries in dir
  * @start:	offset to start from
- * @inode:	inode for statistics
  * @freed:	counter for freed pages
  *
  * It frees the swap entries from dir+start til dir+size
@@ -109,7 +113,7 @@
 
 static unsigned long 
 shmem_truncate_part (swp_entry_t * dir, unsigned long size, 
-		     unsigned long start, struct inode * inode, unsigned long *freed) {
+		     unsigned long start, unsigned long *freed) {
 	if (start > size)
 		return start - size;
 	if (dir)
@@ -121,21 +125,27 @@
 static void shmem_truncate (struct inode * inode)
 {
 	int clear_base;
-	unsigned long start;
+	unsigned long index, start;
 	unsigned long mmfreed, freed = 0;
-	swp_entry_t **base, **ptr;
+	swp_entry_t **base, **ptr, **last;
 	struct shmem_inode_info * info = &inode->u.shmem_i;
 
 	spin_lock (&info->lock);
-	start = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	if (index >= info->max_index) {
+		info->max_index = index;
+		spin_unlock (&info->lock);
+		return;
+	}
 
-	start = shmem_truncate_part (info->i_direct, SHMEM_NR_DIRECT, start, inode, &freed);
+	start = shmem_truncate_part (info->i_direct, SHMEM_NR_DIRECT, index, &freed);
 
 	if (!(base = info->i_indirect))
-		goto out;;
+		goto out;
 
 	clear_base = 1;
-	for (ptr = base; ptr < base + ENTRIES_PER_PAGE; ptr++) {
+	last = base + ((info->max_index - SHMEM_NR_DIRECT + ENTRIES_PER_PAGE - 1) / ENTRIES_PER_PAGE);
+	for (ptr = base; ptr < last; ptr++) {
 		if (!start) {
 			if (!*ptr)
 				continue;
@@ -145,16 +155,16 @@
 			continue;
 		}
 		clear_base = 0;
-		start = shmem_truncate_part (*ptr, ENTRIES_PER_PAGE, start, inode, &freed);
+		start = shmem_truncate_part (*ptr, ENTRIES_PER_PAGE, start, &freed);
 	}
 
-	if (!clear_base) 
-		goto out;
-
-	free_page ((unsigned long)base);
-	info->i_indirect = 0;
+	if (clear_base) {
+		free_page ((unsigned long)base);
+		info->i_indirect = 0;
+	}
 
 out:
+	info->max_index = index;
 
 	/*
 	 * We have to calculate the free blocks since we do not know
@@ -181,14 +191,14 @@
 {
 	struct shmem_sb_info *info = &inode->i_sb->u.shmem_sb;
 
-	spin_lock (&shmem_ilock);
-	list_del (&inode->u.shmem_i.list);
-	spin_unlock (&shmem_ilock);
 	inode->i_size = 0;
 	shmem_truncate (inode);
 	spin_lock (&info->stat_lock);
 	info->free_inodes++;
 	spin_unlock (&info->stat_lock);
+	spin_lock (&shmem_ilock);
+	list_del (&inode->u.shmem_i.list);
+	spin_unlock (&shmem_ilock);
 	clear_inode(inode);
 }
 
@@ -215,21 +225,23 @@
 	info = &((struct inode *)page->mapping->host)->u.shmem_i;
 	if (info->locked)
 		return 1;
+	spin_lock(&info->lock);
 	swap = __get_swap_page(2);
-	if (!swap.val)
+	if (!swap.val) {
+		spin_unlock(&info->lock);
 		return 1;
+	}
 
-	spin_lock(&info->lock);
-	entry = shmem_swp_entry (info, page->index);
+	entry = shmem_swp_entry(info, page->index);
 	if (!entry)	/* this had been allocted on page allocation */
 		BUG();
 	error = -EAGAIN;
 	if (entry->val) {
-                __swap_free(swap, 2);
+		__swap_free(swap, 2);
 		goto out;
-        }
+	}
 
-        *entry = swap;
+	*entry = swap;
 	error = 0;
 	/* Remove the from the page cache */
 	lru_cache_del(page);
@@ -756,21 +768,21 @@
 	return -1;
 }
 
-static int shmem_unuse_inode (struct inode *inode, swp_entry_t entry, struct page *page)
+static inline int shmem_unuse_inode (struct shmem_inode_info *info, struct address_space *mapping, swp_entry_t entry, struct page *page)
 {
 	swp_entry_t **base, **ptr;
 	unsigned long idx;
 	int offset;
 	
 	idx = 0;
-	if ((offset = shmem_clear_swp (entry, inode->u.shmem_i.i_direct, SHMEM_NR_DIRECT)) >= 0)
+	if ((offset = shmem_clear_swp (entry,info->i_direct, SHMEM_NR_DIRECT)) >= 0)
 		goto found;
 
 	idx = SHMEM_NR_DIRECT;
-	if (!(base = inode->u.shmem_i.i_indirect))
+	if (!(base = info->i_indirect))
 		return 0;
 
-	for (ptr = base; ptr < base + ENTRIES_PER_PAGE; ptr++) {
+	for (ptr = base; idx <= info->max_index; ptr++) {
 		if (*ptr &&
 		    (offset = shmem_clear_swp (entry, *ptr, ENTRIES_PER_PAGE)) >= 0)
 			goto found;
@@ -778,35 +790,71 @@
 	}
 	return 0;
 found:
-	delete_from_swap_cache (page);
-	add_to_page_cache (page, inode->i_mapping, idx);
+	if (PageSwapCache(page))
+		BUG();
+	add_to_page_cache (page, mapping, offset + idx);
 	SetPageDirty (page);
 	SetPageUptodate (page);
 	UnlockPage (page);
-	spin_lock (&inode->u.shmem_i.lock);
-	inode->u.shmem_i.swapped--;
-	spin_unlock (&inode->u.shmem_i.lock);
+	info->swapped--;
 	return 1;
 }
 
+static struct inode * grab_next_inode(struct list_head **listp)
+{
+	struct inode *inode;
+
+	for (*listp = (*listp)->next; *listp != &shmem_inodes; *listp = (*listp)->next) {
+		inode = list_entry(*listp, struct inode, u.shmem_i.list);
+
+		if (igrab(inode))
+			return inode;
+	}
+
+	return NULL;
+}
+
 /*
- * unuse_shmem() search for an eventually swapped out shmem page.
+ * shmem_unuse() search for an eventually swapped out shmem page.
  */
 void shmem_unuse(swp_entry_t entry, struct page *page)
 {
-	struct list_head *p;
-	struct inode * inode;
+	struct list_head *p = &shmem_inodes;
+	struct inode * inode, *next_inode = NULL;
+	struct shmem_inode_info *info;
+	int ret;
 
-	spin_lock (&shmem_ilock);
-	list_for_each(p, &shmem_inodes) {
-		inode = list_entry(p, struct inode, u.shmem_i.list);
+	/*
+	 * This is tricky:
+	 *
+	 * - We cannot use a semaphore for the list since delete will
+	 *   revert the lock order.
+	 * - We need to get the inode semaphore since the swap cache
+	 *   has no atomic actions for getting an entry
+	 * - We cannot drop the inode while holding the lock
+	 *
+	 * So we grab the current inode and the next one to make sure
+	 * that the next pointer inthe list is valid.
+	 */
 
-		if (shmem_unuse_inode(inode, entry, page))
+	spin_lock(&shmem_ilock);
+	for(inode = grab_next_inode(&p); inode; inode = next_inode) {
+		next_inode = grab_next_inode(&p);
+		info = &inode->u.shmem_i;
+		spin_unlock(&shmem_ilock);
+		down(&inode->i_sem);
+		spin_lock (&info->lock);
+		ret = shmem_unuse_inode(info, inode->i_mapping, entry, page);
+		spin_unlock (&info->lock);
+		up(&inode->i_sem);
+		iput (inode);
+		spin_lock(&shmem_ilock);
+		if (ret)
 			break;
 	}
 	spin_unlock (&shmem_ilock);
+	iput(next_inode);
 }
-
 
 /*
  * shmem_file_setup - get an unlinked file living in shmem fs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
