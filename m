Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315417AbSFAIms>; Sat, 1 Jun 2002 04:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316998AbSFAImF>; Sat, 1 Jun 2002 04:42:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54794 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316994AbSFAIkn>;
	Sat, 1 Jun 2002 04:40:43 -0400
Message-ID: <3CF88953.FDE854A6@zip.com.au>
Date: Sat, 01 Jun 2002 01:44:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, Hugh Dickins <hugh@veritas.com>
Subject: [patch 14/16] tmpfs bugfixes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



A patch from Hugh Dickins which fixes a couple of error-path leaks
related to tmpfs (I think).

Also fixes a yield()-inside-spinlock bug.

It also includes code to clear the final page outside i_size on
truncate.  tmpfs should be returning zeroes when a truncated file is
later expanded and it currently is not.

Hugh is taking care of the 2.4 fix for this.



=====================================

--- 2.5.19/mm/shmem.c~hugh	Sat Jun  1 01:18:13 2002
+++ 2.5.19-akpm/mm/shmem.c	Sat Jun  1 01:18:13 2002
@@ -52,6 +52,8 @@ LIST_HEAD (shmem_inodes);
 static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
 atomic_t shmem_nrpages = ATOMIC_INIT(0); /* Not used right now */
 
+static struct page *shmem_getpage_locked(struct shmem_inode_info *, struct inode *, unsigned long);
+
 #define BLOCKS_PER_PAGE (PAGE_CACHE_SIZE/512)
 
 /*
@@ -317,6 +319,7 @@ shmem_truncate_indirect(struct shmem_ino
 static void shmem_truncate (struct inode * inode)
 {
 	unsigned long index;
+	unsigned long partial;
 	unsigned long freed = 0;
 	struct shmem_inode_info * info = SHMEM_I(inode);
 
@@ -324,6 +327,28 @@ static void shmem_truncate (struct inode
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	spin_lock (&info->lock);
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	partial = inode->i_size & ~PAGE_CACHE_MASK;
+
+	if (partial) {
+		swp_entry_t *entry = shmem_swp_entry(info, index-1, 0);
+		struct page *page;
+		/*
+		 * This check is racy: it's faintly possible that page
+		 * was assigned to swap during truncate_inode_pages,
+		 * and now assigned to file; but better than nothing.
+		 */
+		if (!IS_ERR(entry) && entry->val) {
+			spin_unlock(&info->lock);
+			page = shmem_getpage_locked(info, inode, index-1);
+			if (!IS_ERR(page)) {
+				memclear_highpage_flush(page, partial,
+					PAGE_CACHE_SIZE - partial);
+				unlock_page(page);
+				page_cache_release(page);
+			}
+			spin_lock(&info->lock);
+		}
+	}
 
 	while (index < info->next_index) 
 		freed += shmem_truncate_indirect(info, index);
@@ -369,10 +394,10 @@ static int shmem_unuse_inode (struct shm
 	swp_entry_t *ptr;
 	unsigned long idx;
 	int offset;
+	struct inode *inode = NULL;
 
-	spin_lock (&info->lock);
-repeat:
 	idx = 0;
+	spin_lock (&info->lock);
 	offset = shmem_clear_swp (entry, info->i_direct, SHMEM_NR_DIRECT);
 	if (offset >= 0)
 		goto found;
@@ -389,20 +414,36 @@ repeat:
 	spin_unlock (&info->lock);
 	return 0;
 found:
-	if (!move_from_swap_cache (page, offset+idx, info->vfs_inode.i_mapping)) {
-		info->swapped--;
-		SetPageUptodate (page);
-		spin_unlock (&info->lock);
-		return 1;
+	idx += offset;
+	inode = igrab(&info->vfs_inode);
+	spin_unlock(&shmem_ilock);
+
+	while (inode && move_from_swap_cache(page, idx, inode->i_mapping)) {
+		/*
+		 * Yield for kswapd, and try again - but we're still
+		 * holding the page lock - ugh! fix this up later on.
+		 * Beware of inode being unlinked or truncated: just
+		 * leave try_to_unuse to delete_from_swap_cache if so.
+		 */
+		spin_unlock(&info->lock);
+		yield();
+		spin_lock(&info->lock);
+		ptr = shmem_swp_entry(info, idx, 0);
+		if (IS_ERR(ptr))
+			break;
 	}
 
-	/* Yield for kswapd, and try again */
-	yield();
-	goto repeat;
+	info->swapped--;
+	SetPageUptodate(page);
+	spin_unlock(&info->lock);
+	if (inode)
+		iput(inode);
+	return 1;
 }
 
 /*
- * unuse_shmem() search for an eventually swapped out shmem page.
+ * shmem_unuse() search for an eventually swapped out shmem page.
+ * Note shmem_unuse_inode drops shmem_ilock itself if successful.
  */
 void shmem_unuse(swp_entry_t entry, struct page *page)
 {
@@ -414,7 +455,7 @@ void shmem_unuse(swp_entry_t entry, stru
 		info = list_entry(p, struct shmem_inode_info, list);
 
 		if (shmem_unuse_inode(info, entry, page))
-			break;
+			return;
 	}
 	spin_unlock (&shmem_ilock);
 }
@@ -551,6 +592,7 @@ repeat:
 		error = move_from_swap_cache(page, idx, mapping);
 		if (error < 0) {
 			unlock_page(page);
+			page_cache_release(page);
 			return ERR_PTR(error);
 		}
 
@@ -576,11 +618,11 @@ repeat:
 		 * is enough to make this atomic. */
 		page = page_cache_alloc(mapping);
 		if (!page)
-			return ERR_PTR(-ENOMEM);
+			goto no_mem;
 		error = add_to_page_cache(page, mapping, idx);
 		if (error < 0) {
 			page_cache_release(page);
-			return ERR_PTR(-ENOMEM);
+			goto no_mem;
 		}
 		clear_highpage(page);
 		inode->i_blocks += BLOCKS_PER_PAGE;
@@ -589,6 +631,13 @@ repeat:
 	/* We have the page */
 	SetPageUptodate(page);
 	return page;
+
+no_mem:
+	spin_lock(&sbinfo->stat_lock);
+	sbinfo->free_blocks++;
+	spin_unlock(&sbinfo->stat_lock);
+	return ERR_PTR(-ENOMEM);
+
 no_space:
 	spin_unlock (&sbinfo->stat_lock);
 	return ERR_PTR(-ENOSPC);
@@ -1396,6 +1445,7 @@ static void destroy_inodecache(void)
 
 static struct address_space_operations shmem_aops = {
 	writepage:	shmem_writepage,
+	set_page_dirty:	__set_page_dirty_nobuffers,
 };
 
 static struct file_operations shmem_file_operations = {

-
