Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753727AbWKMAp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbWKMAp4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 19:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753730AbWKMAp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 19:45:56 -0500
Received: from dvhart.com ([64.146.134.43]:4316 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1753726AbWKMApz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 19:45:55 -0500
Message-ID: <4557BFD7.5010405@mbligh.org>
Date: Sun, 12 Nov 2006 16:44:07 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cmm@us.ibm.com,
       val_henson@linux.intel.com
Subject: [PATCH] Bring ext2 reservations code in line with latest ext3
References: <200611090841.kA98feVx010502@shell0.pdx.osdl.net>
In-Reply-To: <200611090841.kA98feVx010502@shell0.pdx.osdl.net>
Content-Type: multipart/mixed;
 boundary="------------040005000002060507040006"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040005000002060507040006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Did a pass through comparing the functions changed by the ext2
reservations patch to current ext3 code. Fixed up comments and
typedefs to match latest ext3 code.

Only thing left remaining was the error handling in
ext2_try_to_allocate_with_rsv, but it may be OK as is.

Signed-off-by: Martin J. Bligh <mbligh@google.com>



--------------040005000002060507040006
Content-Type: text/plain;
 name="2.6.18-ext2-mjb"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.6.18-ext2-mjb"

diff -aurpN -X /home/mbligh/.diff.exclude 2.6.18-ext2-akpm/fs/ext2/balloc.c 2.6.18-ext2-mjb/fs/ext2/balloc.c
--- 2.6.18-ext2-akpm/fs/ext2/balloc.c	2006-11-12 13:14:15.000000000 -0800
+++ 2.6.18-ext2-mjb/fs/ext2/balloc.c	2006-11-12 16:37:08.000000000 -0800
@@ -126,15 +126,22 @@ static void group_adjust_blocks(struct s
  * Operations include:
  * dump, find, add, remove, is_empty, find_next_reservable_window, etc.
  *
- * We use sorted double linked list for the per-filesystem reservation
- * window list. (like in vm_region).
+ * We use a red-black tree to represent per-filesystem reservation
+ * windows.
  *
- * Initially, we keep those small operations in the abstract functions,
- * so later if we need a better searching tree than double linked-list,
- * we could easily switch to that without changing too much
- * code.
  */
-#if 0
+
+/**
+ * __rsv_window_dump() -- Dump the filesystem block allocation reservation map
+ * @rb_root:		root of per-filesystem reservation rb tree
+ * @verbose:		verbose mode
+ * @fn:			function which wishes to dump the reservation map
+ *
+ * If verbose is turned on, it will print the whole block reservation
+ * windows(start, end). Otherwise, it will only print out the "bad" windows,
+ * those windows that overlap with their immediate neighbors.
+ */
+#if 1
 static void __rsv_window_dump(struct rb_root *root, int verbose,
 			      const char *fn)
 {
@@ -184,32 +191,51 @@ restart:
 #define rsv_window_dump(root, verbose) do {} while (0)
 #endif
 
+/**
+ * goal_in_my_reservation()
+ * @rsv:		inode's reservation window
+ * @grp_goal:		given goal block relative to the allocation block group
+ * @group:		the current allocation block group
+ * @sb:			filesystem super block
+ *
+ * Test if the given goal block (group relative) is within the file's
+ * own block reservation window range.
+ *
+ * If the reservation window is outside the goal allocation group, return 0;
+ * grp_goal (given goal block) could be -1, which means no specific
+ * goal block. In this case, always return 1.
+ * If the goal block is within the reservation window, return 1;
+ * otherwise, return 0;
+ */
 static int
-goal_in_my_reservation(struct ext2_reserve_window *rsv, int goal,
+goal_in_my_reservation(struct ext2_reserve_window *rsv, ext2_grpblk_t grp_goal,
 			unsigned int group, struct super_block * sb)
 {
-	unsigned long group_first_block, group_last_block;
+	ext2_fsblk_t group_first_block, group_last_block;
 
-	group_first_block = le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block) +
-				group * EXT2_BLOCKS_PER_GROUP(sb);
+	group_first_block = ext2_group_first_block_no(sb, group);
 	group_last_block = group_first_block + EXT2_BLOCKS_PER_GROUP(sb) - 1;
 
 	if ((rsv->_rsv_start > group_last_block) ||
 	    (rsv->_rsv_end < group_first_block))
 		return 0;
-	if ((goal >= 0) && ((goal + group_first_block < rsv->_rsv_start)
-		|| (goal + group_first_block > rsv->_rsv_end)))
+	if ((grp_goal >= 0) && ((grp_goal + group_first_block < rsv->_rsv_start)
+		|| (grp_goal + group_first_block > rsv->_rsv_end)))
 		return 0;
 	return 1;
 }
 
-/*
+/**
+ * search_reserve_window()
+ * @rb_root:		root of reservation tree
+ * @goal:		target allocation block
+ *
  * Find the reserved window which includes the goal, or the previous one
  * if the goal is not in any window.
  * Returns NULL if there are no windows or if all windows start after the goal.
  */
 static struct ext2_reserve_window_node *
-search_reserve_window(struct rb_root *root, unsigned long goal)
+search_reserve_window(struct rb_root *root, ext2_fsblk_t goal)
 {
 	struct rb_node *n = root->rb_node;
 	struct ext2_reserve_window_node *rsv;
@@ -240,12 +266,19 @@ search_reserve_window(struct rb_root *ro
 	return rsv;
 }
 
+/*
+ * ext2_rsv_window_add() -- Insert a window to the block reservation rb tree.
+ * @sb:			super block
+ * @rsv:		reservation window to add
+ *
+ * Must be called with rsv_lock held.
+ */
 void ext2_rsv_window_add(struct super_block *sb,
 		    struct ext2_reserve_window_node *rsv)
 {
 	struct rb_root *root = &EXT2_SB(sb)->s_rsv_window_root;
 	struct rb_node *node = &rsv->rsv_node;
-	unsigned int start = rsv->rsv_start;
+	ext2_fsblk_t start = rsv->rsv_start;
 
 	struct rb_node ** p = &root->rb_node;
 	struct rb_node * parent = NULL;
@@ -260,14 +293,25 @@ void ext2_rsv_window_add(struct super_bl
 			p = &(*p)->rb_left;
 		else if (start > this->rsv_end)
 			p = &(*p)->rb_right;
-		else
+		else {
+			rsv_window_dump(root, 1);
 			BUG();
+		}
 	}
 
 	rb_link_node(node, parent, p);
 	rb_insert_color(node, root);
 }
 
+/**
+ * rsv_window_remove() -- unlink a window from the reservation rb tree
+ * @sb:			super block
+ * @rsv:		reservation window to remove
+ *
+ * Mark the block reservation window as not allocated, and unlink it
+ * from the filesystem reservation window rb tree. Must be called with
+ * rsv_lock held.
+ */
 static void rsv_window_remove(struct super_block *sb,
 			      struct ext2_reserve_window_node *rsv)
 {
@@ -277,12 +321,39 @@ static void rsv_window_remove(struct sup
 	rb_erase(&rsv->rsv_node, &EXT2_SB(sb)->s_rsv_window_root);
 }
 
+/*
+ * rsv_is_empty() -- Check if the reservation window is allocated.
+ * @rsv:		given reservation window to check
+ *
+ * returns 1 if the end block is EXT3_RESERVE_WINDOW_NOT_ALLOCATED.
+ */
 static inline int rsv_is_empty(struct ext2_reserve_window *rsv)
 {
 	/* a valid reservation end block could not be 0 */
 	return (rsv->_rsv_end == EXT2_RESERVE_WINDOW_NOT_ALLOCATED);
 }
 
+/**
+ * ext2_init_block_alloc_info()
+ * @inode:		file inode structure
+ *
+ * Allocate and initialize the  reservation window structure, and
+ * link the window to the ext2 inode structure at last
+ *
+ * The reservation window structure is only dynamically allocated
+ * and linked to ext2 inode the first time the open file
+ * needs a new block. So, before every ext2_new_block(s) call, for
+ * regular files, we should check whether the reservation window
+ * structure exists or not. In the latter case, this function is called.
+ * Fail to do so will result in block reservation being turned off for that
+ * open file.
+ *
+ * This function is called from ext2_get_blocks_handle(), also called
+ * when setting the reservation window size through ioctl before the file
+ * is open for write (needs block allocation).
+ *
+ * Needs truncate_mutex protection prior to calling this function.
+ */
 void ext2_init_block_alloc_info(struct inode *inode)
 {
 	struct ext2_inode_info *ei = EXT2_I(inode);
@@ -312,6 +383,18 @@ void ext2_init_block_alloc_info(struct i
 	ei->i_block_alloc_info = block_i;
 }
 
+/**
+ * ext2_discard_reservation()
+ * @inode:		inode
+ *
+ * Discard(free) block reservation window on last file close, or truncate
+ * or at last iput().
+ *
+ * It is being called in three cases:
+ * 	ext2_release_file(): last writer closes the file
+ * 	ext2_clear_inode(): last iput(), when nobody links to this file.
+ * 	ext2_truncate(): when the block indirect map is about to change.
+ */
 void ext2_discard_reservation(struct inode *inode)
 {
 	struct ext2_inode_info *ei = EXT2_I(inode);
@@ -331,7 +414,12 @@ void ext2_discard_reservation(struct ino
 	}
 }
 
-/* Free given blocks, update quota and i_blocks field */
+/**
+ * ext2_free_blocks_sb() -- Free given blocks and update quota and i_blocks
+ * @inode:		inode
+ * @block:		start physcial block to free
+ * @count:		number of blocks to free
+ */
 void ext2_free_blocks (struct inode * inode, unsigned long block,
 		       unsigned long count)
 {
@@ -420,11 +508,21 @@ error_return:
 	DQUOT_FREE_BLOCK(inode, freed);
 }
 
-static int
-bitmap_search_next_usable_block(int start, struct buffer_head *bh,
-					int maxblocks)
+/**
+ * bitmap_search_next_usable_block()
+ * @start:		the starting block (group relative) of the search
+ * @bh:			bufferhead contains the block group bitmap
+ * @maxblocks:		the ending block (group relative) of the reservation
+ *
+ * The bitmap search --- search forward alternately through the actual
+ * bitmap on disk and the last-committed copy in journal, until we find a
+ * bit free in both bitmaps.
+ */
+static ext2_grpblk_t
+bitmap_search_next_usable_block(ext2_grpblk_t start, struct buffer_head *bh,
+					ext2_grpblk_t maxblocks)
 {
-	int next;
+	ext2_grpblk_t next;
 
 	next = ext2_find_next_zero_bit(bh->b_data, maxblocks, start);
 	if (next >= maxblocks)
@@ -432,16 +530,22 @@ bitmap_search_next_usable_block(int star
 	return next;
 }
 
-/*
+/**
+ * find_next_usable_block()
+ * @start:		the starting block (group relative) to find next
+ * 			allocatable block in bitmap.
+ * @bh:			bufferhead contains the block group bitmap
+ * @maxblocks:		the ending block (group relative) for the search
+ *
  * Find an allocatable block in a bitmap.  We perform the "most
  * appropriate allocation" algorithm of looking for a free block near
  * the initial goal; then for a free byte somewhere in the bitmap;
  * then for any free bit in the bitmap.
  */
-static int
+static ext2_grpblk_t
 find_next_usable_block(int start, struct buffer_head *bh, int maxblocks)
 {
-	int here, next;
+	ext2_grpblk_t here, next;
 	char *p, *r;
 
 	if (start > 0) {
@@ -453,7 +557,7 @@ find_next_usable_block(int start, struct
 		 * less than EXT2_BLOCKS_PER_GROUP. Aligning up to the
 		 * next 64-bit boundary is simple..
 		 */
-		int end_goal = (start + 63) & ~63;
+		ext2_grpblk_t end_goal = (start + 63) & ~63;
 		if (end_goal > maxblocks)
 			end_goal = maxblocks;
 		here = ext2_find_next_zero_bit(bh->b_data, end_goal, start);
@@ -478,22 +582,41 @@ find_next_usable_block(int start, struct
 }
 
 /*
+ * ext2_try_to_allocate()
+ * @sb:			superblock
+ * @handle:		handle to this transaction
+ * @group:		given allocation block group
+ * @bitmap_bh:		bufferhead holds the block bitmap
+ * @grp_goal:		given target block within the group
+ * @count:		target number of blocks to allocate
+ * @my_rsv:		reservation window
+ *
+ * Attempt to allocate blocks within a give range. Set the range of allocation
+ * first, then find the first free bit(s) from the bitmap (within the range),
+ * and at last, allocate the blocks by claiming the found free bit as allocated.
+ *
+ * To set the range of this allocation:
+ * 	if there is a reservation window, only try to allocate block(s)
+ * 	from the file's own reservation window;
+ * 	Otherwise, the allocation range starts from the give goal block, 
+ * 	ends at the block group's last block.
+ *
  * If we failed to allocate the desired block then we may end up crossing to a
  * new bitmap.
  */
 static int
 ext2_try_to_allocate(struct super_block *sb, int group,
-			struct buffer_head *bitmap_bh, int goal,
-			unsigned long *count, struct ext2_reserve_window *my_rsv)
+			struct buffer_head *bitmap_bh, ext2_grpblk_t grp_goal,
+			unsigned long *count,
+			struct ext2_reserve_window *my_rsv)
 {
-	int group_first_block, start, end;
+	ext2_fsblk_t group_first_block;
+       	ext2_grpblk_t start, end;
 	unsigned long num = 0;
 
 	/* we do allocation within the reservation window if we have a window */
 	if (my_rsv) {
-		group_first_block =
-			le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block) +
-			group * EXT2_BLOCKS_PER_GROUP(sb);
+		group_first_block = ext2_group_first_block_no(sb, group);
 		if (my_rsv->_rsv_start >= group_first_block)
 			start = my_rsv->_rsv_start - group_first_block;
 		else
@@ -503,13 +626,13 @@ ext2_try_to_allocate(struct super_block 
 		if (end > EXT2_BLOCKS_PER_GROUP(sb))
 			/* reservation window crosses group boundary */
 			end = EXT2_BLOCKS_PER_GROUP(sb);
-		if ((start <= goal) && (goal < end))
-			start = goal;
+		if ((start <= grp_goal) && (grp_goal < end))
+			start = grp_goal;
 		else
-			goal = -1;
+			grp_goal = -1;
 	} else {
-		if (goal > 0)
-			start = goal;
+		if (grp_goal > 0)
+			start = grp_goal;
 		else
 			start = 0;
 		end = EXT2_BLOCKS_PER_GROUP(sb);
@@ -518,41 +641,44 @@ ext2_try_to_allocate(struct super_block 
 	BUG_ON(start > EXT2_BLOCKS_PER_GROUP(sb));
 
 repeat:
-	if (goal < 0) {
-		goal = find_next_usable_block(start, bitmap_bh, end);
-		if (goal < 0)
+	if (grp_goal < 0) {
+		grp_goal = find_next_usable_block(start, bitmap_bh, end);
+		if (grp_goal < 0)
 			goto fail_access;
 		if (!my_rsv) {
 			int i;
 
-			for (i = 0; i < 7 && goal > start &&
-				     !ext2_test_bit(goal - 1, bitmap_bh->b_data);
-			     i++, goal--)
+			for (i = 0; i < 7 && grp_goal > start &&
+					!ext2_test_bit(grp_goal - 1,
+					     		bitmap_bh->b_data);
+			     		i++, grp_goal--)
 				;
 		}
 	}
-	start = goal;
+	start = grp_goal;
 
-	if (ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group), goal, bitmap_bh->b_data)) {
+	if (ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group), grp_goal,
+			       				bitmap_bh->b_data)) {
 		/*
 		 * The block was allocated by another thread, or it was
 		 * allocated and then freed by another thread
 		 */
 		start++;
-		goal++;
+		grp_goal++;
 		if (start >= end)
 			goto fail_access;
 		goto repeat;
 	}
 	num++;
-	goal++;
-	while (num < *count && goal < end
-		&& !ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group), goal, bitmap_bh->b_data)) {
+	grp_goal++;
+	while (num < *count && grp_goal < end
+		&& !ext2_set_bit_atomic(sb_bgl_lock(EXT2_SB(sb), group), 
+					grp_goal, bitmap_bh->b_data)) {
 		num++;
-		goal++;
+		grp_goal++;
 	}
 	*count = num;
-	return goal - num;
+	return grp_goal - num;
 fail_access:
 	*count = num;
 	return -1;
@@ -594,12 +720,13 @@ fail_access:
 static int find_next_reservable_window(
 				struct ext2_reserve_window_node *search_head,
 				struct ext2_reserve_window_node *my_rsv,
-				struct super_block * sb, int start_block,
-				int last_block)
+				struct super_block * sb,
+				ext2_fsblk_t start_block,
+				ext2_fsblk_t last_block)
 {
 	struct rb_node *next;
 	struct ext2_reserve_window_node *rsv, *prev;
-	int cur;
+	ext2_fsblk_t cur;
 	int size = my_rsv->rsv_goal_size;
 
 	/* TODO: make the start of the reservation window byte-aligned */
@@ -701,7 +828,7 @@ static int find_next_reservable_window(
  *
  *	@rsv: the reservation
  *
- *	@goal: The goal (group-relative).  It is where the search for a
+ *	@grp_goal: The goal (group-relative).  It is where the search for a
  *		free reservable space should start from.
  *		if we have a goal(goal >0 ), then start from there,
  *		no goal(goal = -1), we start from the first block
@@ -713,25 +840,24 @@ static int find_next_reservable_window(
  *
  */
 static int alloc_new_reservation(struct ext2_reserve_window_node *my_rsv,
-		int goal, struct super_block *sb,
+		ext2_grpblk_t grp_goal, struct super_block *sb,
 		unsigned int group, struct buffer_head *bitmap_bh)
 {
 	struct ext2_reserve_window_node *search_head;
-	int group_first_block, group_end_block, start_block;
-	int first_free_block;
+	ext2_fsblk_t group_first_block, group_end_block, start_block;
+	ext2_grpblk_t first_free_block;
 	struct rb_root *fs_rsv_root = &EXT2_SB(sb)->s_rsv_window_root;
 	unsigned long size;
 	int ret;
 	spinlock_t *rsv_lock = &EXT2_SB(sb)->s_rsv_window_lock;
 
-	group_first_block = le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block) +
-				group * EXT2_BLOCKS_PER_GROUP(sb);
-	group_end_block = group_first_block + EXT2_BLOCKS_PER_GROUP(sb) - 1;
+	group_first_block = ext2_group_first_block_no(sb, group);
+	group_end_block = group_first_block + (EXT2_BLOCKS_PER_GROUP(sb) - 1);
 
-	if (goal < 0)
+	if (grp_goal < 0)
 		start_block = group_first_block;
 	else
-		start_block = goal + group_first_block;
+		start_block = grp_goal + group_first_block;
 
 	size = my_rsv->rsv_goal_size;
 
@@ -758,9 +884,10 @@ static int alloc_new_reservation(struct 
 		if ((my_rsv->rsv_alloc_hit >
 		     (my_rsv->rsv_end - my_rsv->rsv_start + 1) / 2)) {
 			/*
-			 * if we previously allocation hit ration is greater than half
-			 * we double the size of reservation window next time
-			 * otherwise keep the same
+			 * if the previously allocation hit ratio is
+			 * greater than 1/2, then we double the size of
+			 * the reservation window the next time,
+			 * otherwise we keep the same size window
 			 */
 			size = size * 2;
 			if (size > EXT2_MAX_RESERVE_BLOCKS)
@@ -839,6 +966,23 @@ retry:
 	goto retry;
 }
 
+/**
+ * try_to_extend_reservation()
+ * @my_rsv:		given reservation window
+ * @sb:			super block
+ * @size:		the delta to extend
+ *
+ * Attempt to expand the reservation window large enough to have
+ * required number of free blocks
+ *
+ * Since ext2_try_to_allocate() will always allocate blocks within
+ * the reservation window range, if the window size is too small,
+ * multiple blocks allocation has to stop at the end of the reservation
+ * window. To make this more efficient, given the total number of
+ * blocks needed and the current size of the window, we try to
+ * expand the reservation window size if necessary on a best-effort
+ * basis before ext2_new_blocks() tries to allocate blocks.
+ */
 static void try_to_extend_reservation(struct ext2_reserve_window_node *my_rsv,
 			struct super_block *sb, int size)
 {
@@ -864,7 +1008,15 @@ static void try_to_extend_reservation(st
 	spin_unlock(rsv_lock);
 }
 
-/*
+/**
+ * ext2_try_to_allocate_with_rsv()
+ * @sb:			superblock
+ * @group:		given allocation block group
+ * @bitmap_bh:		bufferhead holds the block bitmap
+ * @grp_goal:		given target block within the group
+ * @count:		target number of blocks to allocate
+ * @my_rsv:		reservation window
+ *
  * This is the main function used to allocate a new block and its reservation
  * window.
  *
@@ -880,18 +1032,15 @@ static void try_to_extend_reservation(st
  * reservation), and there are lots of free blocks, but they are all
  * being reserved.
  *
- * We use a sorted double linked list for the per-filesystem reservation list.
- * The insert, remove and find a free space(non-reserved) operations for the
- * sorted double linked list should be fast.
- *
+ * We use a red-black tree for the per-filesystem reservation list.
  */
-static int
-ext2_try_to_allocate_with_rsv(struct super_block *sb, 
-			unsigned int group, struct buffer_head *bitmap_bh,
-			int goal, struct ext2_reserve_window_node * my_rsv,
+static ext2_grpblk_t
+ext2_try_to_allocate_with_rsv(struct super_block *sb, unsigned int group, 
+			struct buffer_head *bitmap_bh, ext2_grpblk_t grp_goal,
+			struct ext2_reserve_window_node * my_rsv,
 			unsigned long *count)
 {
-	unsigned long group_first_block;
+	ext2_fsblk_t group_first_block;
 	int ret = 0;
 	unsigned long num = *count;
 
@@ -903,16 +1052,15 @@ ext2_try_to_allocate_with_rsv(struct sup
 	 */
 	if (my_rsv == NULL ) {
 		return ext2_try_to_allocate(sb, group, bitmap_bh,
-						goal, count, NULL);
+						grp_goal, count, NULL);
 	}
 	/*
-	 * goal is a group relative block number (if there is a goal)
-	 * 0 < goal < EXT2_BLOCKS_PER_GROUP(sb)
+	 * grp_goal is a group relative block number (if there is a goal)
+	 * 0 < grp_goal < EXT2_BLOCKS_PER_GROUP(sb)
 	 * first block is a filesystem wide block number
 	 * first block is the block number of the first block in this group
 	 */
-	group_first_block = le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block) +
-			group * EXT2_BLOCKS_PER_GROUP(sb);
+	group_first_block = ext2_group_first_block_no(sb, group);
 
 	/*
 	 * Basically we will allocate a new block from inode's reservation
@@ -931,24 +1079,29 @@ ext2_try_to_allocate_with_rsv(struct sup
 	 */
 	while (1) {
 		if (rsv_is_empty(&my_rsv->rsv_window) || (ret < 0) ||
-			!goal_in_my_reservation(&my_rsv->rsv_window, goal, group, sb)) {
+			!goal_in_my_reservation(&my_rsv->rsv_window, grp_goal,
+								group, sb)) {
 			if (my_rsv->rsv_goal_size < *count)
 				my_rsv->rsv_goal_size = *count;
-			ret = alloc_new_reservation(my_rsv, goal, sb,
+			ret = alloc_new_reservation(my_rsv, grp_goal, sb,
 							group, bitmap_bh);
 			if (ret < 0)
 				break;			/* failed */
 
-			if (!goal_in_my_reservation(&my_rsv->rsv_window, goal, group, sb))
-				goal = -1;
-		} else if (goal > 0 && (my_rsv->rsv_end-goal+1) < *count)
+			if (!goal_in_my_reservation(&my_rsv->rsv_window,
+							grp_goal, group, sb))
+				grp_goal = -1;
+		} else if (grp_goal > 0 && 
+				(my_rsv->rsv_end - grp_goal + 1) < *count)
 			try_to_extend_reservation(my_rsv, sb,
-					*count-my_rsv->rsv_end + goal - 1);
+					*count-my_rsv->rsv_end + grp_goal - 1);
 
 		if ((my_rsv->rsv_start >= group_first_block + EXT2_BLOCKS_PER_GROUP(sb))
-		    || (my_rsv->rsv_end < group_first_block))
+		    || (my_rsv->rsv_end < group_first_block)) {
+			rsv_window_dump(&EXT2_SB(sb)->s_rsv_window_root, 1);
 			BUG();
-		ret = ext2_try_to_allocate(sb, group, bitmap_bh, goal,
+		}
+		ret = ext2_try_to_allocate(sb, group, bitmap_bh, grp_goal,
 					   &num, &my_rsv->rsv_window);
 		if (ret >= 0) {
 			my_rsv->rsv_alloc_hit += num;
@@ -960,9 +1113,15 @@ ext2_try_to_allocate_with_rsv(struct sup
 	return ret;
 }
 
+/**
+ * ext2_has_free_blocks()
+ * @sbi:		in-core super block structure.
+ *
+ * Check if filesystem has at least 1 free block available for allocation.
+ */
 static int ext2_has_free_blocks(struct ext2_sb_info *sbi)
 {
-	int free_blocks, root_blocks;
+	ext2_fsblk_t free_blocks, root_blocks;
 
 	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
 	root_blocks = le32_to_cpu(sbi->s_es->s_r_blocks_count);
@@ -975,6 +1134,12 @@ static int ext2_has_free_blocks(struct e
 }
 
 /*
+ * ext2_new_blocks() -- core block(s) allocation function
+ * @inode:		file inode
+ * @goal:		given target block(filesystem wide)
+ * @count:		target number of blocks to allocate
+ * @errp:		error code
+ *
  * ext2_new_blocks uses a goal block to assist allocation.  If the goal is
  * free, or there is a free block within 32 blocks of the goal, that block
  * is allocated.  Otherwise a forward search is made for a free block; within 
@@ -982,18 +1147,18 @@ static int ext2_has_free_blocks(struct e
  * bitmap, and then for any free bit if that fails.
  * This function also updates quota and i_blocks field.
  */
-int ext2_new_blocks(struct inode *inode, unsigned long goal,
+int ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
 		    unsigned long *count, int *errp)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *gdp_bh;
 	int group_no;
 	int goal_group;
-	int ret_block;
+	ext2_fsblk_t ret_block;		/* filesyetem-wide allocated block */
 	int bgi;			/* blockgroup iteration index */
 	int target_block;
 	int performed_allocation = 0;
-	int free_blocks;
+	ext2_grpblk_t free_blocks;	/* number of free blocks in a group */
 	struct super_block *sb;
 	struct ext2_group_desc *gdp;
 	struct ext2_super_block *es;
@@ -1104,6 +1269,9 @@ retry_alloc:
 		bitmap_bh = read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
 			goto io_error;
+		/*
+		 * try to allocate block(s) from this group, without a goal(-1).
+		 */
 		ret_block = ext2_try_to_allocate_with_rsv(sb, group_no,
 					bitmap_bh, -1, my_rsv, &num);
 		if (ret_block >= 0) 
@@ -1151,7 +1319,7 @@ allocated:
 
 	if (ret_block + num - 1 >= le32_to_cpu(es->s_blocks_count)) {
 		ext2_error(sb, "ext2_new_blocks",
-			    "block(%d) >= blocks count(%d) - "
+			    "block("E2FSBLK") >= blocks count(%d) - "
 			    "block_group = %d, es == %p ", ret_block,
 			le32_to_cpu(es->s_blocks_count), group_no, es);
 		goto out;
diff -aurpN -X /home/mbligh/.diff.exclude 2.6.18-ext2-akpm/fs/ext2/inode.c 2.6.18-ext2-mjb/fs/ext2/inode.c
--- 2.6.18-ext2-akpm/fs/ext2/inode.c	2006-11-12 13:14:09.000000000 -0800
+++ 2.6.18-ext2-mjb/fs/ext2/inode.c	2006-11-12 16:11:46.000000000 -0800
@@ -363,13 +363,13 @@ ext2_blks_to_allocate(Indirect * branch,
  *		direct blocks
  */
 static int ext2_alloc_blocks(struct inode *inode,
-			unsigned long goal, int indirect_blks, int blks,
-			unsigned long long new_blocks[4], int *err)
+			ext2_fsblk_t goal, int indirect_blks, int blks,
+			ext2_fsblk_t new_blocks[4], int *err)
 {
 	int target, i;
 	unsigned long count = 0;
 	int index = 0;
-	unsigned long current_block = 0;
+	ext2_fsblk_t current_block = 0;
 	int ret = 0;
 
 	/*
@@ -439,7 +439,7 @@ failed_out:
  */
 
 static int ext2_alloc_branch(struct inode *inode,
-			int indirect_blks, int *blks, unsigned long goal,
+			int indirect_blks, int *blks, ext2_fsblk_t goal,
 			int *offsets, Indirect *branch)
 {
 	int blocksize = inode->i_sb->s_blocksize;
@@ -447,8 +447,8 @@ static int ext2_alloc_branch(struct inod
 	int err = 0;
 	struct buffer_head *bh;
 	int num;
-	unsigned long long new_blocks[4];
-	unsigned long long current_block;
+	ext2_fsblk_t new_blocks[4];
+	ext2_fsblk_t current_block;
 
 	num = ext2_alloc_blocks(inode, goal, indirect_blks,
 				*blks, new_blocks, &err);
@@ -515,7 +515,7 @@ static void ext2_splice_branch(struct in
 {
 	int i;
 	struct ext2_block_alloc_info *block_i;
-	unsigned long current_block;
+	ext2_fsblk_t current_block;
 
 	block_i = EXT2_I(inode)->i_block_alloc_info;
 
@@ -583,13 +583,13 @@ int ext2_get_blocks(struct inode *inode,
 	int offsets[4];
 	Indirect chain[4];
 	Indirect *partial;
-	unsigned long goal;
+	ext2_fsblk_t goal;
 	int indirect_blks;
 	int blocks_to_boundary = 0;
 	int depth;
 	struct ext2_inode_info *ei = EXT2_I(inode);
 	int count = 0;
-	unsigned long first_block = 0;
+	ext2_fsblk_t first_block = 0;
 
 	depth = ext2_block_to_path(inode,iblock,offsets,&blocks_to_boundary);
 
@@ -605,7 +605,7 @@ reread:
 		count++;
 		/*map more blocks*/
 		while (count < maxblocks && count <= blocks_to_boundary) {
-			unsigned long blk;
+			ext2_fsblk_t blk;
 
 			if (!verify_chain(chain, partial)) {
 				/*
diff -aurpN -X /home/mbligh/.diff.exclude 2.6.18-ext2-akpm/include/linux/ext2_fs.h 2.6.18-ext2-mjb/include/linux/ext2_fs.h
--- 2.6.18-ext2-akpm/include/linux/ext2_fs.h	2006-11-04 14:56:36.000000000 -0800
+++ 2.6.18-ext2-mjb/include/linux/ext2_fs.h	2006-11-12 16:37:36.000000000 -0800
@@ -558,4 +558,11 @@ enum {
 #define EXT2_DIR_REC_LEN(name_len)	(((name_len) + 8 + EXT2_DIR_ROUND) & \
 					 ~EXT2_DIR_ROUND)
 
+static inline ext2_fsblk_t
+ext2_group_first_block_no(struct super_block *sb, unsigned long group_no)
+{
+	return group_no * (ext2_fsblk_t)EXT2_BLOCKS_PER_GROUP(sb) +
+		le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block);
+}
+
 #endif	/* _LINUX_EXT2_FS_H */
diff -aurpN -X /home/mbligh/.diff.exclude 2.6.18-ext2-akpm/include/linux/ext2_fs_sb.h 2.6.18-ext2-mjb/include/linux/ext2_fs_sb.h
--- 2.6.18-ext2-akpm/include/linux/ext2_fs_sb.h	2006-11-04 14:56:36.000000000 -0800
+++ 2.6.18-ext2-mjb/include/linux/ext2_fs_sb.h	2006-11-12 16:38:16.000000000 -0800
@@ -22,6 +22,14 @@
 
 /* XXX Here for now... not interested in restructing headers JUST now */
 
+/* data type for block offset of block group */
+typedef int ext2_grpblk_t;
+
+/* data type for filesystem-wide blocks number */
+typedef unsigned long ext2_fsblk_t;
+
+#define E2FSBLK "%lu"
+
 struct ext2_reserve_window {
 	__u32			_rsv_start;	/* First byte reserved */
 	__u32			_rsv_end;	/* Last byte reserved or 0 */

--------------040005000002060507040006--
