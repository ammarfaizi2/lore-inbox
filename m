Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbTJOSWk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263903AbTJOSWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:22:40 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:17395 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S263904AbTJOSWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:22:33 -0400
Date: Wed, 15 Oct 2003 19:22:28 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] tmpfs 4/7 getpage/truncate race
In-Reply-To: <Pine.LNX.4.44.0310151915590.5350-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0310151921370.5350-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Extend use of that SHMEM_PAGEIN flag to where shmem_getpage adds a page
to the cache.  It couldn't have caused a BUG_ON(inode->i_blocks), but if
i_size is reduced (from another cpu) the instant after shmem_swp_alloc
checks it, shmem_getpage could insert a page into the cache just after
truncate_inode_pages has passed through cleaning it, leaving stale data
(which may mysteriously reappear if the file is later extended).

Easily fixed for tmpfs, using the mechanism just added for swapoff; and
probably more important there, since its read from swap can insert non-0
data.  But is there not a similar issue, a tiny window, in filemap.c?
if truncate_inode_pages comes in between checking i_size and adding new
page to cache.  Not worth getting excited, but something to beware of.

--- tmpfs3/mm/shmem.c	2003-10-15 15:38:52.342219504 +0100
+++ tmpfs4/mm/shmem.c	2003-10-15 15:39:03.328549328 +0100
@@ -52,7 +52,7 @@
 
 #define VM_ACCT(size)    (PAGE_CACHE_ALIGN(size) >> PAGE_SHIFT)
 
-/* info->flags needs a VM_flag to handle swapoff/truncate races efficiently */
+/* info->flags needs a VM_flag to handle pagein/truncate races efficiently */
 #define SHMEM_PAGEIN	 VM_READ
 
 /* Pretend that each entry is of this size in directory's i_size */
@@ -498,6 +498,8 @@
 		 * Call truncate_inode_pages again: racing shmem_unuse_inode
 		 * may have swizzled a page in from swap since vmtruncate or
 		 * generic_delete_inode did it, before we lowered next_index.
+		 * Also, though shmem_getpage checks i_size before adding to
+		 * cache, no recheck after: so fix the narrow window there too.
 		 */
 		spin_unlock(&info->lock);
 		truncate_inode_pages(inode->i_mapping, inode->i_size);
@@ -863,6 +865,7 @@
 			swap_free(swap);
 		} else if (!(error = move_from_swap_cache(
 				swappage, idx, mapping))) {
+			info->flags |= SHMEM_PAGEIN;
 			shmem_swp_set(info, entry, 0);
 			shmem_swp_unmap(entry);
 			spin_unlock(&info->lock);
@@ -932,6 +935,7 @@
 					goto failed;
 				goto repeat;
 			}
+			info->flags |= SHMEM_PAGEIN;
 		}
 
 		info->alloced++;

