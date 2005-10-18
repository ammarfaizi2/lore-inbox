Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbVJRI1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbVJRI1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 04:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbVJRI1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 04:27:18 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:53765
	"EHLO x30.random") by vger.kernel.org with ESMTP id S1751471AbVJRI1Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 04:27:16 -0400
Date: Tue, 18 Oct 2005 10:26:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Chris Mason <mason@suse.com>
Subject: [PATCH] fix nr_unused accounting, and avoid recursing in iput with I_WILL_FREE set
Message-ID: <20051018082609.GC15717@x30.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

@@ -183,6 +183,7 @@ __sync_single_inode(struct inode *inode,
 			list_move(&inode->i_list, &inode_in_use);
 		} else {
 			list_move(&inode->i_list, &inode_unused);
+			inodes_stat.nr_unused++;
 		}
 	}
 	wake_up_inode(inode);

Are you sure the above diff is correct? It was added somewhere between
2.6.5 and 2.6.8. I think it's wrong.

The only way I can imagine the i_count to be zero in the above path, is
that I_WILL_FREE is set. And if I_WILL_FREE is set, then we must not
increase nr_unused. So I believe the above change is buggy and it will
definitely overstate the number of unused inodes and it should be backed
out.

Note that __writeback_single_inode before calling __sync_single_inode, can
drop the spinlock and we can have both the dirty and locked bitflags
clear here:

		spin_unlock(&inode_lock);
		__wait_on_inode(inode);
		iput(inode);
XXXXXXX
		spin_lock(&inode_lock);
	}
	use inode again here

a construct like the above makes zero sense from a reference counting
standpoint.

Either we don't ever use the inode again after the iput, or the
inode_lock should be taken _before_ executing the iput (i.e. a __iput
would be required). Taking the inode_lock after iput means the iget was
useless if we keep using the inode after the iput.

So the only chance the 2.6 was safe to call __writeback_single_inode
with the i_count == 0, is that I_WILL_FREE is set (I_WILL_FREE will
prevent the VM to free the inode in XXXXX).

Potentially calling the above iput with I_WILL_FREE was also wrong
because it would recurse in iput_final (the second mainline bug).

The below (untested) patch fixes the nr_unused accounting, avoids
recursing in iput when I_WILL_FREE is set and makes sure (with the
BUG_ON) that we don't corrupt memory and that all holders that don't set
I_WILL_FREE, keeps a reference on the inode!

Comments welcome, thanks.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

 fs-writeback.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6/fs/fs-writeback.c
--- linux-2.6/fs/fs-writeback.c.~1~	2005-07-28 17:08:53.000000000 +0200
+++ linux-2.6/fs/fs-writeback.c	2005-10-17 15:43:53.000000000 +0200
@@ -230,7 +230,6 @@ __sync_single_inode(struct inode *inode,
 			 * The inode is clean, unused
 			 */
 			list_move(&inode->i_list, &inode_unused);
-			inodes_stat.nr_unused++;
 		}
 	}
 	wake_up_inode(inode);
@@ -246,6 +245,8 @@ __writeback_single_inode(struct inode *i
 {
 	wait_queue_head_t *wqh;
 
+	BUG_ON(!atomic_read(&inode->i_count) ^ !!(inode->i_state & I_WILL_FREE));
+
 	if ((wbc->sync_mode != WB_SYNC_ALL) && (inode->i_state & I_LOCK)) {
 		list_move(&inode->i_list, &inode->i_sb->s_dirty);
 		return 0;
@@ -259,11 +260,9 @@ __writeback_single_inode(struct inode *i
 
 		wqh = bit_waitqueue(&inode->i_state, __I_LOCK);
 		do {
-			__iget(inode);
 			spin_unlock(&inode_lock);
 			__wait_on_bit(wqh, &wq, inode_wait,
 							TASK_UNINTERRUPTIBLE);
-			iput(inode);
 			spin_lock(&inode_lock);
 		} while (inode->i_state & I_LOCK);
 	}
