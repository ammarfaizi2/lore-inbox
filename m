Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263902AbTJOSVm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbTJOSVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:21:42 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:62430 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S263902AbTJOSVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:21:35 -0400
Date: Wed, 15 Oct 2003 19:21:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Rohland <cr@sap.com>, <rathamahata@php4.ru>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 3/7 swapoff/truncate race
In-Reply-To: <Pine.LNX.4.44.0310151915590.5350-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0310151919540.5350-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 July, Sergey S. Kostyliov <rathamahata@php4.ru> reported a tmpfs
BUG_ON(inode->i_blocks) during swapoff: my last version of the fix to
swapoff/truncate race was inadequate, since I_FREEING might get set or
i_size be reduced (from another cpu) the instant after it's tested here.

So revert to the previous version of the fix, shmem_truncate calling
truncate_inode_pages again, if pages still left in cache; but avoid the
recall in usual cases of partial truncation, by having a "pagein" flag
to indicate when recall might be necessary.  (Since those flags already
use VM_ACCOUNT and VM_LOCKED, must redefine another VM_flag for this.)
Sergey and 2.4-aa have run fine with this for a couple of months.

--- tmpfs2/mm/shmem.c	2003-10-15 15:38:41.336892568 +0100
+++ tmpfs3/mm/shmem.c	2003-10-15 15:38:52.342219504 +0100
@@ -52,6 +52,9 @@
 
 #define VM_ACCT(size)    (PAGE_CACHE_ALIGN(size) >> PAGE_SHIFT)
 
+/* info->flags needs a VM_flag to handle swapoff/truncate races efficiently */
+#define SHMEM_PAGEIN	 VM_READ
+
 /* Pretend that each entry is of this size in directory's i_size */
 #define BOGO_DIRENT_SIZE 20
 
@@ -490,6 +493,16 @@
 	}
 done2:
 	BUG_ON(info->swapped > info->next_index);
+	if (inode->i_mapping->nrpages && (info->flags & SHMEM_PAGEIN)) {
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
@@ -524,6 +537,19 @@
 					attr->ia_size>>PAGE_CACHE_SHIFT,
 						&page, SGP_READ);
 			}
+			/*
+			 * Reset SHMEM_PAGEIN flag so that shmem_truncate can
+			 * detect if any pages might have been added to cache
+			 * after truncate_inode_pages.  But we needn't bother
+			 * if it's being fully truncated to zero-length: the
+			 * nrpages check is efficient enough in that case.
+			 */
+			if (attr->ia_size) {
+				struct shmem_inode_info *info = SHMEM_I(inode);
+				spin_lock(&info->lock);
+				info->flags &= ~SHMEM_PAGEIN;
+				spin_unlock(&info->lock);
+			}
 		}
 	}
 
@@ -638,14 +664,10 @@
 found:
 	idx += offset;
 	inode = &info->vfs_inode;
-
-	/* Racing against delete or truncate? Must leave out of page cache */
-	limit = (inode->i_state & I_FREEING)? 0:
-		(i_size_read(inode) + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
-
-	if (idx >= limit ||
-	    move_from_swap_cache(page, idx, inode->i_mapping) == 0)
+	if (move_from_swap_cache(page, idx, inode->i_mapping) == 0) {
+		info->flags |= SHMEM_PAGEIN;
 		shmem_swp_set(info, ptr + offset, 0);
+	}
 	shmem_swp_unmap(ptr);
 	spin_unlock(&info->lock);
 	/*
@@ -653,7 +675,7 @@
 	 * try_to_unuse will skip over mms, then reincrement count.
 	 */
 	swap_free(entry);
-	return idx < limit;
+	return 1;
 }
 
 /*

