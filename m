Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030692AbWAJX1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030692AbWAJX1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030688AbWAJX1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:27:00 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:56813 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030684AbWAJX0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:26:50 -0500
Subject: [PATCH 5/5] ext3-get-blocks: Adjust reservation window size for
	mblocks
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: hch@lst.de, pbadari@us.ibm.com, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 10 Jan 2006 15:26:48 -0800
Message-Id: <1136935608.4901.46.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Last part of the multiple blocks allocation patch which optimize the block reservation
and the multiple block allocation: with the knowledge of the total number of blocks
ahead, set or adjust the reservation window size properly (based on the number of blocks
needed) before block allocation happens: if there isn't any reservation yet, make sure
the reservation window equals to or greater than the number of blocks needed, before create
an reservation window; if a reservation window is already exists, try to extends the window
size to match the number of blocks to allocate.  This could increase the possibility of
completing multiple blocks allocation in a single request, as blocks are only allocated in
the range of the inode's reservation window.

Signed-off-by: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.15-ming/fs/ext3/balloc.c |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletion(-)

diff -puN fs/ext3/balloc.c~ext3-extend-reservation fs/ext3/balloc.c
--- linux-2.6.15/fs/ext3/balloc.c~ext3-extend-reservation	2006-01-10 14:18:18.462384575 -0800
+++ linux-2.6.15-ming/fs/ext3/balloc.c	2006-01-10 14:18:18.467383991 -0800
@@ -1012,6 +1012,31 @@ retry:
 	goto retry;
 }
 
+static void try_to_extend_reservation(struct ext3_reserve_window_node *my_rsv,
+			struct super_block *sb, int size)
+{
+	struct ext3_reserve_window_node *next_rsv;
+	struct rb_node *next;
+	spinlock_t *rsv_lock = &EXT3_SB(sb)->s_rsv_window_lock;
+
+	if (!spin_trylock(rsv_lock))
+		return;
+
+	next = rb_next(&my_rsv->rsv_node);
+
+	if (!next)
+		my_rsv->rsv_end += size;
+	else {
+		next_rsv = list_entry(next, struct ext3_reserve_window_node, rsv_node);
+
+		if ((next_rsv->rsv_start - my_rsv->rsv_end -1) >= size)
+			my_rsv->rsv_end += size;
+		else
+			my_rsv->rsv_end = next_rsv->rsv_start -1 ;
+	}
+	spin_unlock(rsv_lock);
+}
+
 /*
  * This is the main function used to allocate a new block and its reservation
  * window.
@@ -1096,6 +1121,8 @@ ext3_try_to_allocate_with_rsv(struct sup
 	while (1) {
 		if (rsv_is_empty(&my_rsv->rsv_window) || (ret < 0) ||
 			!goal_in_my_reservation(&my_rsv->rsv_window, goal, group, sb)) {
+			if (my_rsv->rsv_goal_size < *count)
+				my_rsv->rsv_goal_size = *count;
 			ret = alloc_new_reservation(my_rsv, goal, sb,
 							group, bitmap_bh);
 			if (ret < 0)
@@ -1103,7 +1130,10 @@ ext3_try_to_allocate_with_rsv(struct sup
 
 			if (!goal_in_my_reservation(&my_rsv->rsv_window, goal, group, sb))
 				goal = -1;
-		}
+		} else if (goal > 0 && (my_rsv->rsv_end-goal+1) < *count)
+			try_to_extend_reservation(my_rsv, sb,
+					*count-my_rsv->rsv_end+goal-1);
+
 		if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
 		    || (my_rsv->rsv_end < group_first_block))
 			BUG();

_


