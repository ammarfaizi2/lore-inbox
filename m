Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268058AbUIGNL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268058AbUIGNL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 09:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268054AbUIGNJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 09:09:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33741 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268028AbUIGNDA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 09:03:00 -0400
Date: Tue, 7 Sep 2004 14:02:48 +0100
Message-Id: <200409071302.i87D2mWa030937@sisko.scot.redhat.com>
From: Stephen Tweedie <sct@redhat.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Mingming Cao <cmm@us.ibm.com>, pbadari@us.ibm.com,
       Ram Pai <linuxram@us.ibm.com>
Cc: Stephen Tweedie <sct@redhat.com>
Subject: [Patch 6/6]: ext3 reservations: SMP-protect the reservation during allocation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a race in the existing reservations code: while we are
allocating from a reservation, another thread may be discarding the
fd's existing reservation as part of a separate allocation.

To avoid locking the reservation during the bitmap search for a free
block, we just take a temporary copy of the existing reservation
during that search.  To minimise the cost, we use a seqlock to protect
the per-filp reservation, using a seqlock read when taking the
temporary copy and locking for write only when taking out a new
reservation.

Fixes http://bugme.osdl.org/show_bug.cgi?id=3171

Signed-off-by: Stephen Tweedie <sct@redhat.com>

--- linux-2.6.9-rc1-mm4/fs/ext3/balloc.c.=K0005=.orig
+++ linux-2.6.9-rc1-mm4/fs/ext3/balloc.c
@@ -250,7 +250,7 @@ static void rsv_window_remove(struct sup
 {
 	rsv->rsv_start = 0;
 	rsv->rsv_end = 0;
-	rsv->rsv_alloc_hit = 0;
+	atomic_set(&rsv->rsv_alloc_hit, 0);
 	rb_erase(&rsv->rsv_node, &EXT3_SB(sb)->s_rsv_window_root);
 }
 
@@ -856,7 +856,8 @@ static int alloc_new_reservation(struct 
 		if (my_rsv->rsv_end + 1 > start_block)
 			start_block = my_rsv->rsv_end + 1;
 		search_head = my_rsv;
-		if ((my_rsv->rsv_alloc_hit > (my_rsv->rsv_end - my_rsv->rsv_start + 1) / 2)) {
+		if ((atomic_read(&my_rsv->rsv_alloc_hit) > 
+		     (my_rsv->rsv_end - my_rsv->rsv_start + 1) / 2)) {
 			/*
 			 * if we previously allocation hit ration is greater than half
 			 * we double the size of reservation window next time
@@ -1035,27 +1036,39 @@ ext3_try_to_allocate_with_rsv(struct sup
 	 * then we could go to allocate from the reservation window directly.
 	 */
 	while (1) {
-		if (rsv_is_empty(&my_rsv->rsv_window) || (ret < 0) ||
-			!goal_in_my_reservation(&my_rsv->rsv_window, 
-						goal, group, sb)) {
+		struct reserve_window rsv_copy;
+		unsigned int seq;
+		
+		do {
+			seq = read_seqbegin(&my_rsv->rsv_seqlock);
+			rsv_copy._rsv_start = my_rsv->rsv_start;
+			rsv_copy._rsv_end = my_rsv->rsv_end;
+		} while (read_seqretry(&my_rsv->rsv_seqlock, seq));
+
+		if (rsv_is_empty(&rsv_copy) || (ret < 0) ||
+			!goal_in_my_reservation(&rsv_copy, goal, group, sb)) {
 			spin_lock(rsv_lock);
+			write_seqlock(&my_rsv->rsv_seqlock);
 			ret = alloc_new_reservation(my_rsv, goal, sb,
 							group, bitmap_bh);
+			rsv_copy._rsv_start = my_rsv->rsv_start;
+			rsv_copy._rsv_end = my_rsv->rsv_end;
+			write_sequnlock(&my_rsv->rsv_seqlock);
 			spin_unlock(rsv_lock);
 			if (ret < 0)
 				break;			/* failed */
 
-			if (!goal_in_my_reservation(&my_rsv->rsv_window,
-						    goal, group, sb))
+			if (!goal_in_my_reservation(&rsv_copy, goal, group, sb))
 				goal = -1;
 		}
-		if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
-			|| (my_rsv->rsv_end < group_first_block))
+		if ((rsv_copy._rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
+		    || (rsv_copy._rsv_end < group_first_block))
 			BUG();
 		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal,
-					   &my_rsv->rsv_window);
+					   &rsv_copy);
 		if (ret >= 0) {
-			my_rsv->rsv_alloc_hit++;
+			if (!read_seqretry(&my_rsv->rsv_seqlock, seq))
+				atomic_inc(&my_rsv->rsv_alloc_hit);
 			break;				/* succeed */
 		}
 	}
--- linux-2.6.9-rc1-mm4/fs/ext3/ialloc.c.=K0005=.orig
+++ linux-2.6.9-rc1-mm4/fs/ext3/ialloc.c
@@ -585,7 +585,8 @@ got:
 	ei->i_rsv_window.rsv_start = 0;
 	ei->i_rsv_window.rsv_end = 0;
 	atomic_set(&ei->i_rsv_window.rsv_goal_size, EXT3_DEFAULT_RESERVE_BLOCKS);
-	ei->i_rsv_window.rsv_alloc_hit = 0;
+	atomic_set(&ei->i_rsv_window.rsv_alloc_hit, 0);
+	seqlock_init(&ei->i_rsv_window.rsv_seqlock);
 	ei->i_block_group = group;
 
 	ext3_set_inode_flags(inode);
--- linux-2.6.9-rc1-mm4/fs/ext3/inode.c.=K0005=.orig
+++ linux-2.6.9-rc1-mm4/fs/ext3/inode.c
@@ -2463,6 +2463,7 @@ void ext3_read_inode(struct inode * inod
 	ei->i_rsv_window.rsv_start = 0;
 	ei->i_rsv_window.rsv_end= 0;
 	atomic_set(&ei->i_rsv_window.rsv_goal_size, EXT3_DEFAULT_RESERVE_BLOCKS);
+	seqlock_init(&ei->i_rsv_window.rsv_seqlock);
 	/*
 	 * NOTE! The in-memory inode i_data array is in little-endian order
 	 * even on big-endian machines: we do NOT byteswap the block numbers!
--- linux-2.6.9-rc1-mm4/fs/ext3/super.c.=K0005=.orig
+++ linux-2.6.9-rc1-mm4/fs/ext3/super.c
@@ -1495,7 +1495,7 @@ static int ext3_fill_super (struct super
 	 * _much_ simpler. */
 	sbi->s_rsv_window_head.rsv_start = 0;
 	sbi->s_rsv_window_head.rsv_end = 0;
-	sbi->s_rsv_window_head.rsv_alloc_hit = 0;
+	atomic_set(&sbi->s_rsv_window_head.rsv_alloc_hit, 0);
 	atomic_set(&sbi->s_rsv_window_head.rsv_goal_size, 0);
 	rsv_window_add(sb, &sbi->s_rsv_window_head);
 	
--- linux-2.6.9-rc1-mm4/include/linux/ext3_fs_i.h.=K0005=.orig
+++ linux-2.6.9-rc1-mm4/include/linux/ext3_fs_i.h
@@ -18,6 +18,7 @@
 
 #include <linux/rwsem.h>
 #include <linux/rbtree.h>
+#include <linux/seqlock.h>
 
 struct reserve_window {
 	__u32			_rsv_start;	/* First byte reserved */
@@ -27,7 +28,8 @@ struct reserve_window {
 struct reserve_window_node {
 	struct rb_node	 	rsv_node;
 	atomic_t		rsv_goal_size;
-	__u32			rsv_alloc_hit;
+	atomic_t		rsv_alloc_hit;
+	seqlock_t		rsv_seqlock;
 	struct reserve_window	rsv_window;
 };
 
