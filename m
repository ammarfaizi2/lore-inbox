Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTFJQoy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 12:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263503AbTFJQoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 12:44:54 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:29139 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S263496AbTFJQow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 12:44:52 -0400
Date: Tue, 10 Jun 2003 18:00:54 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 2/3 swapoff-truncate race
In-Reply-To: <Pine.LNX.4.44.0306101757150.2432-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0306101759050.2432-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dissatisfied with earlier fix to race where swapoff sneaks page into
tmpfs page cache after truncate_inode_pages cleaned it: calling it a
second time can be too heavy, instead fix shmem_unuse_inode to check
i_size.  (Actually, one part of this fix is in the previous patch:
shmem_file_write now has a hold on the page when it raises i_size.)

--- tmpfs1/mm/shmem.c	Fri Jun  6 19:20:21 2003
+++ tmpfs2/mm/shmem.c	Fri Jun  6 19:24:34 2003
@@ -488,16 +488,6 @@
 	}
 done2:
 	BUG_ON(info->swapped > info->next_index);
-	if (inode->i_mapping->nrpages) {
-		/*
-		 * Call truncate_inode_pages again: racing shmem_unuse_inode
-		 * may have swizzled a page in from swap since vmtruncate or
-		 * generic_delete_inode did it, before we lowered next_index.
-		 */
-		spin_unlock(&info->lock);
-		truncate_inode_pages(inode->i_mapping, inode->i_size);
-		spin_lock(&info->lock);
-	}
 	shmem_recalc_inode(inode);
 	spin_unlock(&info->lock);
 }
@@ -579,6 +569,7 @@
 
 static int shmem_unuse_inode(struct shmem_inode_info *info, swp_entry_t entry, struct page *page)
 {
+	struct inode *inode;
 	unsigned long idx;
 	unsigned long size;
 	unsigned long limit;
@@ -643,8 +634,15 @@
 	spin_unlock(&info->lock);
 	return 0;
 found:
-	if (move_from_swap_cache(page, idx + offset,
-			info->vfs_inode.i_mapping) == 0)
+	idx += offset;
+	inode = &info->vfs_inode;
+
+	/* Racing against delete or truncate? Must leave out of page cache */
+	limit = (inode->i_state & I_FREEING)? 0:
+		(inode->i_size + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+
+	if (idx >= limit ||
+	    move_from_swap_cache(page, idx, inode->i_mapping) == 0)
 		shmem_swp_set(info, ptr + offset, 0);
 	shmem_swp_unmap(ptr);
 	spin_unlock(&info->lock);
@@ -653,7 +651,7 @@
 	 * try_to_unuse will skip over mms, then reincrement count.
 	 */
 	swap_free(entry);
-	return 1;
+	return idx < limit;
 }
 
 /*

