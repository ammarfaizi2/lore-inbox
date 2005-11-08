Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbVKHNja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbVKHNja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965188AbVKHNja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:39:30 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:14973 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S965186AbVKHNj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:39:29 -0500
Message-ID: <4370ACB2.3000103@sw.ru>
Date: Tue, 08 Nov 2005 16:48:34 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, xemul@sw.ru, linux-kernel@vger.kernel.org,
       st@sw.ru
Subject: [PATCH]: buddy allocator: ext3 failed to alloc with __GFP_NOFAIL
Content-Type: multipart/mixed;
 boundary="------------030305080309050603030307"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030305080309050603030307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Andrew,

we had the following ext3 problems once during stress testing (on 2.6.8):
-----------------------------------------------------------------
journal_get_undo_access: No memory for committed data
ext3_free_blocks: aborting transaction: Out of memory in 
__ext3_journal_get_undo_access<2>EXT3-fs error (device hda7) in 
ext3_free_blocks: Out of memory
Aborting journal on device hda7.
EXT3-fs error (device hda7) in ext3_ordered_commit_write: IO failure
ext3_abort called.
EXT3-fs abort (device hda7): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only
ext3_free_blocks: aborting transaction: Journal has aborted in 
__ext3_journal_get_undo_access<2>EXT3-fs error (device hda7) in 
ext3_free_blocks: Journal has aborted
ext3_reserve_inode_write: aborting transaction: Journal has aborted in 
__ext3_journal_get_write_access<2>EXT3-fs error (device hda7) in 
ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device hda7) in ext3_truncate: Out of memory
ext3_reserve_inode_write: aborting transaction: Journal has aborted in 
__ext3_journal_get_write_access<2>EXT3-fs error (device hda7) in 
ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device hda7) in ext3_orphan_del: Journal has aborted
ext3_reserve_inode_write: aborting transaction: Journal has aborted in 
__ext3_journal_get_write_access<2>EXT3-fs error (device hda7) in 
ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device hda7) in ext3_delete_inode: Out of memory
__journal_remove_journal_head: freeing b_committed_data
..................
------------------------------------------------------------------

As it is seen from the messages journal_get_undo_access() failed to 
allocate some memory with jbd_kmalloc(), which in turn called kmalloc() 
with __GFP_NOFAIL flag.

How could it happen?
The only possible reason for this we suppose is a piece of code in 
__alloc_pages():

if ((p->flags & (PF_MEMALLOC | PF_MEMDIE)) && !in_interrupt()) {
         /* go through the zonelist yet again, ignoring mins */
         for (i = 0; zones[i] != NULL; i++) {
                 struct zone *z = zones[i];

                 page = buffered_rmqueue(z, order, gfp_mask);
                 if (page) {
                         zone_statistics(zonelist, z);
                         goto got_pg;
                 }
         }
         goto nopage;				<<<< HERE!!! FAIL...
}


So kswapd (which has PF_MEMALLOC flag) can fail to allocate memory even 
when it allocates it with __GFP_NOFAIL flag.

Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
Signed-Off-By: Denis Lunev <den@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@sw.ru>

The attached patch should fix the problem (against 2.6.14).

Kirill

--------------030305080309050603030307
Content-Type: text/plain;
 name="diff-alloc-nofail"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-alloc-nofail"

--- ./mm/page_alloc.c.mmreb	2005-10-28 04:02:08.000000000 +0400
+++ ./mm/page_alloc.c	2005-11-08 16:32:36.000000000 +0300
@@ -867,6 +867,7 @@ zone_reclaim_retry:
 
 	/* This allocation should allow future memory freeing. */
 
+rebalance:
 	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
 			&& !in_interrupt()) {
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
@@ -879,14 +880,13 @@ zone_reclaim_retry:
 					goto got_pg;
 			}
 		}
-		goto nopage;
+		goto empty;
 	}
 
 	/* Atomic allocations - we can't balance anything */
 	if (!wait)
 		goto nopage;
 
-rebalance:
 	cond_resched();
 
 	/* We now go into synchronous reclaim */
@@ -946,6 +946,7 @@ rebalance:
 	 * In this implementation, __GFP_REPEAT means __GFP_NOFAIL for order
 	 * <= 3, but that may not be true in other implementations.
 	 */
+empty:
 	do_retry = 0;
 	if (!(gfp_mask & __GFP_NORETRY)) {
 		if ((order <= 3) || (gfp_mask & __GFP_REPEAT))

--------------030305080309050603030307--

