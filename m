Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUIEWpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUIEWpO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 18:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267326AbUIEWoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 18:44:46 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:38794 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267345AbUIEWlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 18:41:53 -0400
Date: Sun, 5 Sep 2004 23:41:37 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Brent Casavant <bcasavan@sgi.com>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] shmem: avoid the shmem_inodes list
In-Reply-To: <Pine.LNX.4.44.0409052331240.3218-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0409052340570.3218-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we're thinking about shmem scalability... isn't it silly that each
shmem object is added to the shmem_inodes list on creation, and removed
on deletion, yet the only use for that list is in swapoff (shmem_unuse)?

Call it shmem_swaplist; shmem_writepage add inode to swaplist when first
swap allocated (usually never); shmem_delete_inode remove inode from the
list after truncating (if called before, inode could be re-added to it).

Inode can remain on the swaplist after all its pages are swapped back
in, just be lazy about it; but if shmem_unuse finds swapped count now 0,
save itself time by then removing that inode from the swaplist.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 include/linux/shmem_fs.h |    2 +-
 mm/shmem.c               |   43 ++++++++++++++++++++++++-------------------
 2 files changed, 25 insertions(+), 20 deletions(-)

--- shmem4/include/linux/shmem_fs.h	2004-09-05 17:05:45.867559392 +0100
+++ shmem5/include/linux/shmem_fs.h	2004-09-05 17:06:30.192820928 +0100
@@ -17,7 +17,7 @@ struct shmem_inode_info {
 	struct shared_policy	policy;		/* NUMA memory alloc policy */
 	struct page		*i_indirect;	/* top indirect blocks page */
 	swp_entry_t		i_direct[SHMEM_NR_DIRECT]; /* first blocks */
-	struct list_head	list;		/* chain of all shmem inodes */
+	struct list_head	swaplist;	/* chain of maybes on swap */
 	struct inode		vfs_inode;
 };
 
--- shmem4/mm/shmem.c	2004-09-05 17:06:19.139501288 +0100
+++ shmem5/mm/shmem.c	2004-09-05 17:06:30.195820472 +0100
@@ -179,8 +179,8 @@ static struct backing_dev_info shmem_bac
 	.unplug_io_fn = default_unplug_io_fn,
 };
 
-static LIST_HEAD(shmem_inodes);
-static spinlock_t shmem_ilock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(shmem_swaplist);
+static spinlock_t shmem_swaplist_lock = SPIN_LOCK_UNLOCKED;
 
 static void shmem_free_block(struct inode *inode)
 {
@@ -604,12 +604,14 @@ static void shmem_delete_inode(struct in
 	struct shmem_inode_info *info = SHMEM_I(inode);
 
 	if (inode->i_op->truncate == shmem_truncate) {
-		spin_lock(&shmem_ilock);
-		list_del(&info->list);
-		spin_unlock(&shmem_ilock);
 		shmem_unacct_size(info->flags, inode->i_size);
 		inode->i_size = 0;
 		shmem_truncate(inode);
+		if (!list_empty(&info->swaplist)) {
+			spin_lock(&shmem_swaplist_lock);
+			list_del_init(&info->swaplist);
+			spin_unlock(&shmem_swaplist_lock);
+		}
 	}
 	if (sbinfo) {
 		BUG_ON(inode->i_blocks);
@@ -721,22 +723,23 @@ found:
  */
 int shmem_unuse(swp_entry_t entry, struct page *page)
 {
-	struct list_head *p;
+	struct list_head *p, *next;
 	struct shmem_inode_info *info;
 	int found = 0;
 
-	spin_lock(&shmem_ilock);
-	list_for_each(p, &shmem_inodes) {
-		info = list_entry(p, struct shmem_inode_info, list);
-
-		if (info->swapped && shmem_unuse_inode(info, entry, page)) {
+	spin_lock(&shmem_swaplist_lock);
+	list_for_each_safe(p, next, &shmem_swaplist) {
+		info = list_entry(p, struct shmem_inode_info, swaplist);
+		if (!info->swapped)
+			list_del_init(&info->swaplist);
+		else if (shmem_unuse_inode(info, entry, page)) {
 			/* move head to start search for next from here */
-			list_move_tail(&shmem_inodes, &info->list);
+			list_move_tail(&shmem_swaplist, &info->swaplist);
 			found = 1;
 			break;
 		}
 	}
-	spin_unlock(&shmem_ilock);
+	spin_unlock(&shmem_swaplist_lock);
 	return found;
 }
 
@@ -778,6 +781,12 @@ static int shmem_writepage(struct page *
 		shmem_swp_set(info, entry, swap.val);
 		shmem_swp_unmap(entry);
 		spin_unlock(&info->lock);
+		if (list_empty(&info->swaplist)) {
+			spin_lock(&shmem_swaplist_lock);
+			/* move instead of add in case we're racing */
+			list_move_tail(&info->swaplist, &shmem_swaplist);
+			spin_unlock(&shmem_swaplist_lock);
+		}
 		unlock_page(page);
 		return 0;
 	}
@@ -1226,6 +1235,8 @@ shmem_get_inode(struct super_block *sb, 
 		memset(info, 0, (char *)inode - (char *)info);
 		spin_lock_init(&info->lock);
  		mpol_shared_policy_init(&info->policy);
+		INIT_LIST_HEAD(&info->swaplist);
+
 		switch (mode & S_IFMT) {
 		default:
 			init_special_inode(inode, mode, dev);
@@ -1233,9 +1244,6 @@ shmem_get_inode(struct super_block *sb, 
 		case S_IFREG:
 			inode->i_op = &shmem_inode_operations;
 			inode->i_fop = &shmem_file_operations;
-			spin_lock(&shmem_ilock);
-			list_add_tail(&info->list, &shmem_inodes);
-			spin_unlock(&shmem_ilock);
 			break;
 		case S_IFDIR:
 			inode->i_nlink++;
@@ -1703,9 +1711,6 @@ static int shmem_symlink(struct inode *d
 			return error;
 		}
 		inode->i_op = &shmem_symlink_inode_operations;
-		spin_lock(&shmem_ilock);
-		list_add_tail(&info->list, &shmem_inodes);
-		spin_unlock(&shmem_ilock);
 		kaddr = kmap_atomic(page, KM_USER0);
 		memcpy(kaddr, symname, len);
 		kunmap_atomic(kaddr, KM_USER0);

