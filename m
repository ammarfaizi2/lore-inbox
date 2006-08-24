Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030464AbWHXTnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbWHXTnT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 15:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWHXTnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 15:43:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15260 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030464AbWHXTnS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 15:43:18 -0400
Message-ID: <44EE0155.7080809@redhat.com>
Date: Thu, 24 Aug 2006 14:43:17 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] more ext3 16T overflow fixes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the changes in balloc.c are just cosmetic, as Andreas pointed out -
if they overflow they'll then underflow and things are fine.

5th hunk actually fixes an overflow problem.

Also check for potential overflows in inode & block counts when resizing.

Signed-off-by: Eric Sandeen <esandeen@redhat.com>

Index: linux-2.6.17/fs/ext3/balloc.c
===================================================================
--- linux-2.6.17.orig/fs/ext3/balloc.c
+++ linux-2.6.17/fs/ext3/balloc.c
@@ -168,7 +168,7 @@ goal_in_my_reservation(struct ext3_reser
 	ext3_fsblk_t group_first_block, group_last_block;
 
 	group_first_block = ext3_group_first_block_no(sb, group);
-	group_last_block = group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
+	group_last_block = group_first_block + (EXT3_BLOCKS_PER_GROUP(sb) - 1);
 
 	if ((rsv->_rsv_start > group_last_block) ||
 	    (rsv->_rsv_end < group_first_block))
@@ -897,7 +897,7 @@ static int alloc_new_reservation(struct 
 	spinlock_t *rsv_lock = &EXT3_SB(sb)->s_rsv_window_lock;
 
 	group_first_block = ext3_group_first_block_no(sb, group);
-	group_end_block = group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
+	group_end_block = group_first_block + (EXT3_BLOCKS_PER_GROUP(sb) - 1);
 
 	if (grp_goal < 0)
 		start_block = group_first_block;
@@ -1063,7 +1063,7 @@ ext3_try_to_allocate_with_rsv(struct sup
 			struct ext3_reserve_window_node * my_rsv,
 			unsigned long *count, int *errp)
 {
-	ext3_fsblk_t group_first_block;
+	ext3_fsblk_t group_first_block, group_last_block;
 	ext3_grpblk_t ret = 0;
 	int fatal;
 	unsigned long num = *count;
@@ -1100,6 +1100,7 @@ ext3_try_to_allocate_with_rsv(struct sup
 	 * first block is the block number of the first block in this group
 	 */
 	group_first_block = ext3_group_first_block_no(sb, group);
+	group_last_block = group_first_block + (EXT3_BLOCKS_PER_GROUP(sb) - 1);
 
 	/*
 	 * Basically we will allocate a new block from inode's reservation
@@ -1132,7 +1133,7 @@ ext3_try_to_allocate_with_rsv(struct sup
 			try_to_extend_reservation(my_rsv, sb,
 					*count-my_rsv->rsv_end + grp_goal - 1);
 
-		if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
+		if ((my_rsv->rsv_start > group_last_block)
 		    || (my_rsv->rsv_end < group_first_block))
 			BUG();
 		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, grp_goal,
Index: linux-2.6.17/fs/ext3/resize.c
===================================================================
--- linux-2.6.17.orig/fs/ext3/resize.c
+++ linux-2.6.17/fs/ext3/resize.c
@@ -730,6 +730,16 @@ int ext3_group_add(struct super_block *s
 		return -EPERM;
 	}
 
+	if (es->s_blocks_count + input->blocks_count < es->s_blocks_count) {
+		ext3_warning(sb, __FUNCTION__, "blocks_count overflow\n");
+		return -EINVAL;
+	}
+
+	if (es->s_inodes_count+EXT3_INODES_PER_GROUP(sb) < es->s_inodes_count) {
+		ext3_warning(sb, __FUNCTION__, "inodes_count overflow\n");
+		return -EINVAL;
+	}
+
 	if (reserved_gdb || gdb_off == 0) {
 		if (!EXT3_HAS_COMPAT_FEATURE(sb,
 					     EXT3_FEATURE_COMPAT_RESIZE_INODE)){
@@ -958,6 +968,11 @@ int ext3_group_extend(struct super_block
 
 	add = EXT3_BLOCKS_PER_GROUP(sb) - last;
 
+	if (o_blocks_count + add < o_blocks_count) {
+		ext3_warning(sb, __FUNCTION__, "blocks_count overflow");
+		return -EINVAL;
+	}
+
 	if (o_blocks_count + add > n_blocks_count)
 		add = n_blocks_count - o_blocks_count;
 


