Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbRDNIqV>; Sat, 14 Apr 2001 04:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131317AbRDNIqM>; Sat, 14 Apr 2001 04:46:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:13841 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131307AbRDNIp7>; Sat, 14 Apr 2001 04:45:59 -0400
Date: Sat, 14 Apr 2001 04:04:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: linux-mm@kvack.org
Cc: lkml <linux-kernel@vger.kernel.org>,
        Daniel Phillips <phillips@innominate.de>,
        Rik van Riel <riel@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>
Subject: [PATCH] prune_icache() changes 
Message-ID: <Pine.LNX.4.21.0104121549340.3152-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

The following patch should fix the OOM deadlock condition caused by
prune_icache(), and improve its performance significantly.

The OOM deadlock can happen because prune_icache() tries to sync _all_
dirty inodes (under PF_MEMALLOC) on the system before trying to free a
portion of the clean unused inodes.

The patch also changes prune_icache() to free clean inodes first, and then
sync _unused_ ones if needed. In case (nr_free_pages < freepages.low) the
code writes one inode synchronously and returns (to avoid the OOM
deadlock).

Patch against 2.4.4-pre1. 

Comments are welcome. 


--- fs/inode.c~	Thu Apr 12 21:16:35 2001
+++ fs/inode.c	Thu Apr 12 21:49:56 2001
@@ -13,6 +13,8 @@
 #include <linux/quotaops.h>
 #include <linux/slab.h>
 #include <linux/cache.h>
+#include <linux/swap.h>
+#include <linux/swapctl.h>
 
 /*
  * New inode.c implementation.
@@ -197,6 +199,34 @@
 	inodes_stat.nr_unused--;
 }
 
+static inline void __sync_one(struct inode *inode, int sync)
+{
+	unsigned dirty;
+
+	list_del(&inode->i_list);
+	list_add(&inode->i_list, atomic_read(&inode->i_count)
+						? &inode_in_use
+						: &inode_unused);
+
+	/* Set I_LOCK, reset I_DIRTY */
+	dirty = inode->i_state & I_DIRTY;
+	inode->i_state |= I_LOCK;
+	inode->i_state &= ~I_DIRTY;
+	spin_unlock(&inode_lock);
+
+	filemap_fdatasync(inode->i_mapping);
+
+	/* Don't write the inode if only I_DIRTY_PAGES was set */
+	if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
+		write_inode(inode, sync);
+
+	filemap_fdatawait(inode->i_mapping);
+
+	spin_lock(&inode_lock);
+	inode->i_state &= ~I_LOCK;
+	wake_up(&inode->i_wait);
+}
+
 static inline void sync_one(struct inode *inode, int sync)
 {
 	if (inode->i_state & I_LOCK) {
@@ -206,29 +236,7 @@
 		iput(inode);
 		spin_lock(&inode_lock);
 	} else {
-		unsigned dirty;
-
-		list_del(&inode->i_list);
-		list_add(&inode->i_list, atomic_read(&inode->i_count)
-							? &inode_in_use
-							: &inode_unused);
-		/* Set I_LOCK, reset I_DIRTY */
-		dirty = inode->i_state & I_DIRTY;
-		inode->i_state |= I_LOCK;
-		inode->i_state &= ~I_DIRTY;
-		spin_unlock(&inode_lock);
-
-		filemap_fdatasync(inode->i_mapping);
-
-		/* Don't write the inode if only I_DIRTY_PAGES was set */
-		if (dirty & (I_DIRTY_SYNC | I_DIRTY_DATASYNC))
-			write_inode(inode, sync);
-
-		filemap_fdatawait(inode->i_mapping);
-
-		spin_lock(&inode_lock);
-		inode->i_state &= ~I_LOCK;
-		wake_up(&inode->i_wait);
+		__sync_one(inode, sync);
 	}
 }
 
@@ -236,10 +244,42 @@
 {
 	struct list_head * tmp;
 
-	while ((tmp = head->prev) != head)
+	while ((tmp = head->prev) != head) 
 		sync_one(list_entry(tmp, struct inode, i_list), 0);
 }
 
+static inline int try_to_sync_unused_list(struct list_head *head)
+{
+	struct list_head *tmp = head;
+	struct inode *inode;
+
+	while ((tmp = tmp->prev) != head) {
+		inode = list_entry(tmp, struct inode, i_list);
+
+		if (!(inode->i_state & I_LOCK) 
+				&& !atomic_read(&inode->i_count)) {
+			/* 
+			 * We're under PF_MEMALLOC here, and syncing the 
+			 * inode may have to allocate memory. To avoid
+			 * running into a OOM deadlock, we write one 
+			 * inode synchronously and stop syncing in case 
+			 * we're under freepages.low
+			 */
+
+			int sync = nr_free_pages() < freepages.low;
+			__sync_one(inode, sync);
+			if (sync) 
+				return 0;
+			/* 
+			 * __sync_one moved the inode to another list,
+			 * so we have to start looking from the list head.
+			 */
+			tmp = head;
+		}
+	}
+	return 1;
+}
+
 /**
  *	sync_inodes
  *	@dev: device to sync the inodes from.
@@ -273,13 +313,14 @@
 /*
  * Called with the spinlock already held..
  */
-static void sync_all_inodes(void)
+static void try_to_sync_unused_inodes(void)
 {
 	struct super_block * sb = sb_entry(super_blocks.next);
 	for (; sb != sb_entry(&super_blocks); sb = sb_entry(sb->s_list.next)) {
 		if (!sb->s_dev)
 			continue;
-		sync_list(&sb->s_dirty);
+		if (!try_to_sync_unused_list(&sb->s_dirty))
+			break;
 	}
 }
 
@@ -506,13 +547,12 @@
 {
 	LIST_HEAD(list);
 	struct list_head *entry, *freeable = &list;
-	int count = 0;
+	int count = 0, synced = 0;
 	struct inode * inode;
 
 	spin_lock(&inode_lock);
-	/* go simple and safe syncing everything before starting */
-	sync_all_inodes();
 
+free_unused:
 	entry = inode_unused.prev;
 	while (entry != &inode_unused)
 	{
@@ -539,6 +579,20 @@
 	spin_unlock(&inode_lock);
 
 	dispose_list(freeable);
+
+	/* 
+	 * If we freed enough clean inodes, avoid writing 
+	 * dirty ones. Also giveup if we already tried to
+	 * sync dirty inodes.
+	 */
+	if (!goal || synced)
+		return;
+	
+	synced = 1;
+
+	spin_lock(&inode_lock);
+	try_to_sync_unused_inodes();
+	goto free_unused;
 }
 
 void shrink_icache_memory(int priority, int gfp_mask)


