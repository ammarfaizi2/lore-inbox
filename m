Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSJAVkP>; Tue, 1 Oct 2002 17:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262839AbSJAVkP>; Tue, 1 Oct 2002 17:40:15 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:60888 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S262838AbSJAVkM>; Tue, 1 Oct 2002 17:40:12 -0400
Date: Tue, 1 Oct 2002 22:46:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 2/9 partial shmem_holdpage 
In-Reply-To: <Pine.LNX.4.44.0210012240470.2602-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210012244550.2602-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The earlier partial truncation fix in shmem_truncate admits it is racy,
and I've now seen that (though perhaps more likely when mpage_writepages
was writing pages it shouldn't).  A cleaner fix is, not to repeat the
memclear in shmem_truncate, but to hold the partial page in memory
throughout truncation, by shmem_holdpage from shmem_notify_change.

--- tmpfs1/mm/shmem.c	Tue Oct  1 19:48:54 2002
+++ tmpfs2/mm/shmem.c	Tue Oct  1 19:48:59 2002
@@ -68,8 +68,6 @@
 static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
 atomic_t shmem_nrpages = ATOMIC_INIT(0); /* Not used right now */
 
-static struct page *shmem_getpage_locked(struct shmem_inode_info *, struct inode *, unsigned long);
-
 /*
  * shmem_recalc_inode - recalculate the size of an inode
  *
@@ -329,7 +327,6 @@
 static void shmem_truncate (struct inode * inode)
 {
 	unsigned long index;
-	unsigned long partial;
 	unsigned long freed = 0;
 	struct shmem_inode_info * info = SHMEM_I(inode);
 
@@ -337,29 +334,6 @@
 	inode->i_ctime = inode->i_mtime = CURRENT_TIME;
 	spin_lock (&info->lock);
 	index = (inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-	partial = inode->i_size & ~PAGE_CACHE_MASK;
-
-	if (partial) {
-		swp_entry_t *entry = shmem_swp_entry(info, index-1, 0);
-		struct page *page;
-		/*
-		 * This check is racy: it's faintly possible that page
-		 * was assigned to swap during truncate_inode_pages,
-		 * and now assigned to file; but better than nothing.
-		 */
-		if (!IS_ERR(entry) && entry->val) {
-			spin_unlock(&info->lock);
-			page = shmem_getpage_locked(info, inode, index-1);
-			if (!IS_ERR(page)) {
-				memclear_highpage_flush(page, partial,
-					PAGE_CACHE_SIZE - partial);
-				unlock_page(page);
-				page_cache_release(page);
-			}
-			spin_lock(&info->lock);
-		}
-	}
-
 	while (index < info->next_index) 
 		freed += shmem_truncate_indirect(info, index);
 
@@ -369,9 +343,11 @@
 	up(&info->sem);
 }
 
-static int shmem_notify_change(struct dentry * dentry, struct iattr *attr)
+static int shmem_notify_change(struct dentry *dentry, struct iattr *attr)
 {
+	static struct page *shmem_holdpage(struct inode *, unsigned long);
 	struct inode *inode = dentry->d_inode;
+	struct page *page = NULL;
 	long change = 0;
 	int error;
 
@@ -384,13 +360,27 @@
 		if (change > 0) {
 			if (!vm_enough_memory(change))
 				return -ENOMEM;
-		} else
+		} else if (attr->ia_size < inode->i_size) {
 			vm_unacct_memory(-change);
+			/*
+			 * If truncating down to a partial page, then
+			 * if that page is already allocated, hold it
+			 * in memory until the truncation is over, so
+			 * truncate_partial_page cannnot miss it were
+			 * it assigned to swap.
+			 */
+			if (attr->ia_size & (PAGE_CACHE_SIZE-1)) {
+				page = shmem_holdpage(inode,
+					attr->ia_size >> PAGE_CACHE_SHIFT);
+			}
+		}
 	}
 
 	error = inode_change_ok(inode, attr);
 	if (!error)
 		error = inode_setattr(inode, attr);
+	if (page)
+		page_cache_release(page);
 	if (error)
 		vm_unacct_memory(change);
 	return error;
@@ -729,6 +719,33 @@
 	return error;
 }
 
+static struct page *shmem_holdpage(struct inode *inode, unsigned long idx)
+{
+	struct shmem_inode_info *info = SHMEM_I(inode);
+	struct page *page;
+	swp_entry_t *entry;
+	swp_entry_t swap = {0};
+
+	/*
+	 * Somehow, it feels wrong for truncation down to cause any
+	 * allocation: so instead of a blind shmem_getpage, check that
+	 * the page has actually been instantiated before holding it.
+	 */
+	spin_lock(&info->lock);
+	page = find_get_page(inode->i_mapping, idx);
+	if (!page) {
+		entry = shmem_swp_entry(info, idx, 0);
+		if (!IS_ERR(entry))
+			swap = *entry;
+	}
+	spin_unlock(&info->lock);
+	if (swap.val) {
+		if (shmem_getpage(inode, idx, &page) < 0)
+			page = NULL;
+	}
+	return page;
+}
+
 struct page * shmem_nopage(struct vm_area_struct * vma, unsigned long address, int unused)
 {
 	struct page * page;

