Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266774AbUFYWiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266774AbUFYWiH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 18:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266783AbUFYWiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 18:38:07 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:14669 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266774AbUFYWhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 18:37:48 -0400
Date: Fri, 25 Jun 2004 23:37:38 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mm lock ordering summary
In-Reply-To: <Pine.LNX.4.44.0406252329540.19814-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0406252335410.19814-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update Lock ordering summary in filemap.c, mainly to place page_map_lock
and anon_vma->lock: more helpful to list them here than over in rmap.c.

I couldn't quite understand the earlier groupings, which rather obscure
the ordering: tried to bring them all into one sequence, but i_sem
versus read-write mmap_sem seemed to need spelling out.

Sorry, left out proc_lock and dcache_lock: they just don't belong here.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.7/mm/filemap.c	2004-06-16 06:20:39.000000000 +0100
+++ linux/mm/filemap.c	2004-06-25 22:19:41.669279672 +0100
@@ -55,41 +55,29 @@
 /*
  * Lock ordering:
  *
- *  ->i_mmap_lock		(vmtruncate)
- *    ->private_lock		(__free_pte->__set_page_dirty_buffers)
- *      ->swap_list_lock
- *        ->swap_device_lock	(exclusive_swap_page, others)
- *          ->mapping->tree_lock
- *
- *  ->i_sem
- *    ->i_mmap_lock		(truncate->unmap_mapping_range)
- *
- *  ->mmap_sem
- *    ->i_mmap_lock
- *      ->page_table_lock	(various places, mainly in mmap.c)
- *        ->mapping->tree_lock	(arch-dependent flush_dcache_mmap_lock)
- *
- *  ->mmap_sem
- *    ->lock_page		(access_process_vm)
- *
- *  ->mmap_sem
- *    ->i_sem			(msync)
- *
- *  ->i_sem
- *    ->i_alloc_sem             (various)
- *
- *  ->inode_lock
- *    ->sb_lock			(fs/fs-writeback.c)
- *    ->mapping->tree_lock	(__sync_single_inode)
- *
- *  ->page_table_lock
- *    ->swap_device_lock	(try_to_unmap_one)
- *    ->private_lock		(try_to_unmap_one)
- *    ->tree_lock		(try_to_unmap_one)
- *    ->zone.lru_lock		(follow_page->mark_page_accessed)
+ * inode->i_sem
+ *   inode->i_alloc_sem
  *
- *  ->task->proc_lock
- *    ->dcache_lock		(proc_pid_lookup)
+ * When a page fault occurs in writing from user to file, down_read
+ * of mmap_sem nests within i_sem; in sys_msync, i_sem nests within
+ * down_read of mmap_sem; i_sem and down_write of mmap_sem are never
+ * taken together; in truncation, i_sem is taken outermost.
+ *
+ * mm->mmap_sem
+ *   page->flags PG_locked (lock_page)
+ *     mapping->i_mmap_lock
+ *       mm->page_table_lock
+ *         swap_list_lock (in swap_free etc's swap_info_get)
+ *         zone->lru_lock (in mark_page_accessed)
+ *         page->flags PG_maplock (page_map_lock)
+ *           anon_vma->lock
+ *             swap_device_lock (in swap_duplicate, swap_info_get)
+ *             mapping->private_lock (in __set_page_dirty_buffers)
+ *             inode_lock (in set_page_dirty's __mark_inode_dirty)
+ *               sb_lock (within inode_lock in fs/fs-writeback.c)
+ *               mapping->tree_lock (widely used, in set_page_dirty,
+ *                         in arch-dependent flush_dcache_mmap_lock,
+ *                         within inode_lock in __sync_single_inode)
  */
 
 /*

