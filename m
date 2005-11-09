Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030696AbVKITih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030696AbVKITih (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 14:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030700AbVKITig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 14:38:36 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:43104 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030696AbVKITig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 14:38:36 -0500
Message-ID: <43725227.5040605@sw.ru>
Date: Wed, 09 Nov 2005 22:46:47 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Andrey Savochkin" <saw@sawoct.com>
CC: Andrew Morton <akpm@osdl.org>, xemul@sw.ru, linux-kernel@vger.kernel.org,
       den@sw.ru
Subject: Re: [PATCH]: buddy allocator: ext3 failed to alloc with __GFP_NOFAIL
References: <4370ACB2.3000103@sw.ru>
In-Reply-To: <4370ACB2.3000103@sw.ru>
Content-Type: multipart/mixed;
 boundary="------------050508040206080106060909"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050508040206080106060909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

as Andrey Savochkin pointed to me, the previous patch is incorrect since 
makes allocations with PF_MEMALLOC to be always success for order <= 3 
which is not what we usually want.
I remade the patch to be more explicit about the issue - now it retries 
allocation _only_ if __GFP_NOFAIL is set.

------------- original comment below ------------------

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
         goto nopage;                <<<< HERE!!! FAIL...
}


So kswapd (which has PF_MEMALLOC flag) can fail to allocate memory even 
when it allocates it with __GFP_NOFAIL flag.

Signed-Off-By: Pavel Emelianov <xemul@sw.ru>
Signed-Off-By: Denis Lunev <den@sw.ru>
Signed-Off-By: Kirill Korotaev <dev@sw.ru>

The attached patch should fix the problem (against 2.6.14).

Kirill

--------------050508040206080106060909
Content-Type: text/plain;
 name="diff-alloc-nofail"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-alloc-nofail"

--- ./mm/page_alloc.c.alpg	2005-11-09 21:42:50.000000000 +0300
+++ ./mm/page_alloc.c	2005-11-09 21:44:22.000000000 +0300
@@ -870,6 +870,7 @@ zone_reclaim_retry:
 	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
 			&& !in_interrupt()) {
 		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
+nofail_alloc:
 			/* go through the zonelist yet again, ignoring mins */
 			for (i = 0; (z = zones[i]) != NULL; i++) {
 				if (!cpuset_zone_allowed(z, gfp_mask))
@@ -878,6 +879,10 @@ zone_reclaim_retry:
 				if (page)
 					goto got_pg;
 			}
+			if (gfp_mask & __GFP_NOFAIL) {
+				blk_congestion_wait(WRITE, HZ/50);
+				goto nofail_alloc;
+			}
 		}
 		goto nopage;
 	}

--------------050508040206080106060909--

