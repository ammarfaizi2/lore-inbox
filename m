Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263907AbTJOSXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263905AbTJOSXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:23:32 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:3847 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S263907AbTJOSXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:23:18 -0400
Date: Wed, 15 Oct 2003 19:23:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 5/7 writepage/truncate race
In-Reply-To: <Pine.LNX.4.44.0310151915590.5350-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0310151922371.5350-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If it's possible for a tmpfs page beyond i_size to remain in cache until
shmem_truncate repeats truncate_inode_pages, then shmem_writepage's
BUG_ON(index >= info->next_index) cannot be completely safe.  But it's a
useful check in a fragile area, so retain it when not in shmem_truncate.

--- tmpfs4/mm/shmem.c	2003-10-15 15:39:03.328549328 +0100
+++ tmpfs5/mm/shmem.c	2003-10-15 15:39:14.391867448 +0100
@@ -52,8 +52,9 @@
 
 #define VM_ACCT(size)    (PAGE_CACHE_ALIGN(size) >> PAGE_SHIFT)
 
-/* info->flags needs a VM_flag to handle pagein/truncate races efficiently */
+/* info->flags needs VM_flags to handle pagein/truncate races efficiently */
 #define SHMEM_PAGEIN	 VM_READ
+#define SHMEM_TRUNCATE	 VM_WRITE
 
 /* Pretend that each entry is of this size in directory's i_size */
 #define BOGO_DIRENT_SIZE 20
@@ -393,6 +394,7 @@
 		return;
 
 	spin_lock(&info->lock);
+	info->flags |= SHMEM_TRUNCATE;
 	limit = info->next_index;
 	info->next_index = idx;
 	if (info->swapped && idx < SHMEM_NR_DIRECT) {
@@ -505,6 +507,7 @@
 		truncate_inode_pages(inode->i_mapping, inode->i_size);
 		spin_lock(&info->lock);
 	}
+	info->flags &= ~SHMEM_TRUNCATE;
 	shmem_recalc_inode(inode);
 	spin_unlock(&info->lock);
 }
@@ -730,7 +733,10 @@
 
 	spin_lock(&info->lock);
 	shmem_recalc_inode(inode);
-	BUG_ON(index >= info->next_index);
+	if (index >= info->next_index) {
+		BUG_ON(!(info->flags & SHMEM_TRUNCATE));
+		goto unlock;
+	}
 	entry = shmem_swp_entry(info, index, NULL);
 	BUG_ON(!entry);
 	BUG_ON(entry->val);
@@ -744,6 +750,7 @@
 	}
 
 	shmem_swp_unmap(entry);
+unlock:
 	spin_unlock(&info->lock);
 	swap_free(swap);
 redirty:

