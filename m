Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262132AbTCYWJX>; Tue, 25 Mar 2003 17:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbTCYWIi>; Tue, 25 Mar 2003 17:08:38 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:63687 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S261461AbTCYWGn>; Tue, 25 Mar 2003 17:06:43 -0500
Date: Tue, 25 Mar 2003 22:19:47 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] swap 09/13 tmpfs truncation
In-Reply-To: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303252218500.12636-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent testing has shown that swapoff can sneak a page back into the
tmpfs page cache after truncate_inode_pages has cleaned it, before
shmem_truncate resets next_index to stop that: BUG_ON(inode->i_blocks)
in shmem_delete_inode.  So call truncate_inode_pages again to be safe.

--- swap08/mm/shmem.c	Sun Mar 23 10:30:15 2003
+++ swap09/mm/shmem.c	Tue Mar 25 20:44:24 2003
@@ -486,6 +486,16 @@
 	}
 done2:
 	BUG_ON(info->swapped > info->next_index);
+	if (inode->i_mapping->nrpages) {
+		/*
+		 * Call truncate_inode_pages again: racing shmem_unuse_inode
+		 * may have swizzled a page in from swap since vmtruncate or
+		 * generic_delete_inode did it, before we lowered next_index.
+		 */
+		spin_unlock(&info->lock);
+		truncate_inode_pages(inode->i_mapping, inode->i_size);
+		spin_lock(&info->lock);
+	}
 	shmem_recalc_inode(inode);
 	spin_unlock(&info->lock);
 }

