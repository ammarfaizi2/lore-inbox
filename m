Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030457AbWEZFBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030457AbWEZFBy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 01:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbWEZFBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 01:01:54 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:34002 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030444AbWEZFBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 01:01:52 -0400
Subject: [PATCH 1/2]ext3_fsblk_t: filesystem, group blocks and bug fixes
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 25 May 2006 22:01:12 -0700
Message-Id: <1148619673.5855.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Patch 1]ext3_fsblk_t, ext3_grpblk_t and type fixes.
	defines ext3_fsblk_t and ext3_grpblk_t, and the printk format string
	for filesystem wide blocks.
	
	This patch classifies all block group relative blocks, and
	ext3_fsblk_t blocks occurs in the same function where used to
	be confusing before. Also include kernel bug fixes for filesystem
	wide in-kernel block variables. There are some fileystem wide
	blocks are treated as int/unsigned int type in the kernel currently,
	especially in ext3 block allocation and reservation code. 
	This patch fixed those bugs by converting those variables to
	ext3_fsblk_t(unsigned long) type.

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>

---

 linux-2.6.17-rc4-ming/fs/ext3/balloc.c          |  215 ++++++++++++------------
 linux-2.6.17-rc4-ming/fs/ext3/ialloc.c          |   10 -
 linux-2.6.17-rc4-ming/fs/ext3/inode.c           |    2 
 linux-2.6.17-rc4-ming/fs/ext3/resize.c          |   43 ++--
 linux-2.6.17-rc4-ming/fs/ext3/super.c           |    2 
 linux-2.6.17-rc4-ming/fs/ext3/xattr.c           |   27 +--
 linux-2.6.17-rc4-ming/include/linux/ext3_fs.h   |   19 +-
 linux-2.6.17-rc4-ming/include/linux/ext3_fs_i.h |    8 
 8 files changed, 177 insertions(+), 149 deletions(-)

diff -puN include/linux/ext3_fs_i.h~ext3_fsblk_t_fixes include/linux/ext3_fs_i.h
--- linux-2.6.17-rc4/include/linux/ext3_fs_i.h~ext3_fsblk_t_fixes	2006-05-25 20:40:13.072585164 -0700
+++ linux-2.6.17-rc4-ming/include/linux/ext3_fs_i.h	2006-05-25 20:40:13.096582397 -0700
@@ -21,6 +21,14 @@
 #include <linux/seqlock.h>
 #include <linux/mutex.h>
 
+/* data type for block offset of block group */
+typedef int ext3_grpblk_t;
+
+/* data type for filesystem-wide blocks number */
+typedef unsigned long ext3_fsblk_t;
+
+#define E3FSBLK "%lu"
+
 struct ext3_reserve_window {
 	__u32			_rsv_start;	/* First byte reserved */
 	__u32			_rsv_end;	/* Last byte reserved or 0 */
diff -puN include/linux/ext3_fs.h~ext3_fsblk_t_fixes include/linux/ext3_fs.h
--- linux-2.6.17-rc4/include/linux/ext3_fs.h~ext3_fsblk_t_fixes	2006-05-25 20:40:13.069585510 -0700
+++ linux-2.6.17-rc4-ming/include/linux/ext3_fs.h	2006-05-25 20:40:13.106581244 -0700
@@ -732,13 +732,15 @@ struct dir_private_info {
 /* balloc.c */
 extern int ext3_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext3_bg_num_gdb(struct super_block *sb, int group);
-extern int ext3_new_block (handle_t *, struct inode *, unsigned long, int *);
-extern int ext3_new_blocks (handle_t *, struct inode *, unsigned long,
-			unsigned long *, int *);
-extern void ext3_free_blocks (handle_t *, struct inode *, unsigned long,
-			      unsigned long);
-extern void ext3_free_blocks_sb (handle_t *, struct super_block *,
-				 unsigned long, unsigned long, int *);
+extern ext3_fsblk_t ext3_new_block (handle_t *handle, struct inode *inode,
+			ext3_fsblk_t goal, int *errp);
+extern ext3_fsblk_t ext3_new_blocks (handle_t *handle, struct inode *inode,
+			ext3_fsblk_t goal, unsigned long *count, int *errp);
+extern void ext3_free_blocks (handle_t *handle, struct inode *inode,
+			ext3_fsblk_t block, unsigned long count);
+extern void ext3_free_blocks_sb (handle_t *handle, struct super_block *sb,
+				 ext3_fsblk_t block, unsigned long count,
+				unsigned long *pdquot_freed_blocks);
 extern unsigned long ext3_count_free_blocks (struct super_block *);
 extern void ext3_check_blocks_bitmap (struct super_block *);
 extern struct ext3_group_desc * ext3_get_group_desc(struct super_block * sb,
@@ -775,7 +777,8 @@ extern unsigned long ext3_count_free (st
 
 
 /* inode.c */
-int ext3_forget(handle_t *, int, struct inode *, struct buffer_head *, int);
+int ext3_forget(handle_t *handle, int is_metadata, struct inode *inode,
+		struct buffer_head *bh, ext3_fsblk_t blocknr);
 struct buffer_head * ext3_getblk (handle_t *, struct inode *, long, int, int *);
 struct buffer_head * ext3_bread (handle_t *, struct inode *, int, int, int *);
 int ext3_get_blocks_handle(handle_t *handle, struct inode *inode,
diff -puN fs/ext3/balloc.c~ext3_fsblk_t_fixes fs/ext3/balloc.c
--- linux-2.6.17-rc4/fs/ext3/balloc.c~ext3_fsblk_t_fixes	2006-05-25 20:40:13.076584703 -0700
+++ linux-2.6.17-rc4-ming/fs/ext3/balloc.c	2006-05-25 20:40:13.101581820 -0700
@@ -163,10 +163,10 @@ restart:
 #endif
 
 static int
-goal_in_my_reservation(struct ext3_reserve_window *rsv, int goal,
+goal_in_my_reservation(struct ext3_reserve_window *rsv, ext3_grpblk_t grp_goal,
 			unsigned int group, struct super_block * sb)
 {
-	unsigned long group_first_block, group_last_block;
+	ext3_fsblk_t group_first_block, group_last_block;
 
 	group_first_block = le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) +
 				group * EXT3_BLOCKS_PER_GROUP(sb);
@@ -175,8 +175,8 @@ goal_in_my_reservation(struct ext3_reser
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
@@ -187,7 +187,7 @@ goal_in_my_reservation(struct ext3_reser
  * Returns NULL if there are no windows or if all windows start after the goal.
  */
 static struct ext3_reserve_window_node *
-search_reserve_window(struct rb_root *root, unsigned long goal)
+search_reserve_window(struct rb_root *root, ext3_fsblk_t goal)
 {
 	struct rb_node *n = root->rb_node;
 	struct ext3_reserve_window_node *rsv;
@@ -223,7 +223,7 @@ void ext3_rsv_window_add(struct super_bl
 {
 	struct rb_root *root = &EXT3_SB(sb)->s_rsv_window_root;
 	struct rb_node *node = &rsv->rsv_node;
-	unsigned int start = rsv->rsv_start;
+	ext3_fsblk_t start = rsv->rsv_start;
 
 	struct rb_node ** p = &root->rb_node;
 	struct rb_node * parent = NULL;
@@ -310,20 +310,20 @@ void ext3_discard_reservation(struct ino
 
 /* Free given blocks, update quota and i_blocks field */
 void ext3_free_blocks_sb(handle_t *handle, struct super_block *sb,
-			 unsigned long block, unsigned long count,
-			 int *pdquot_freed_blocks)
+			 ext3_fsblk_t block, unsigned long count,
+			 unsigned long *pdquot_freed_blocks)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *gd_bh;
 	unsigned long block_group;
-	unsigned long bit;
+	ext3_grpblk_t bit;
 	unsigned long i;
 	unsigned long overflow;
 	struct ext3_group_desc * desc;
 	struct ext3_super_block * es;
 	struct ext3_sb_info *sbi;
 	int err = 0, ret;
-	unsigned group_freed;
+	ext3_grpblk_t group_freed;
 
 	*pdquot_freed_blocks = 0;
 	sbi = EXT3_SB(sb);
@@ -333,7 +333,7 @@ void ext3_free_blocks_sb(handle_t *handl
 	    block + count > le32_to_cpu(es->s_blocks_count)) {
 		ext3_error (sb, "ext3_free_blocks",
 			    "Freeing blocks not in datazone - "
-			    "block = %lu, count = %lu", block, count);
+			    "block = "E3FSBLK", count = %lu", block, count);
 		goto error_return;
 	}
 
@@ -369,7 +369,7 @@ do_more:
 		      sbi->s_itb_per_group))
 		ext3_error (sb, "ext3_free_blocks",
 			    "Freeing blocks in system zones - "
-			    "Block = %lu, count = %lu",
+			    "Block = "E3FSBLK", count = %lu",
 			    block, count);
 
 	/*
@@ -453,7 +453,8 @@ do_more:
 						bit + i, bitmap_bh->b_data)) {
 			jbd_unlock_bh_state(bitmap_bh);
 			ext3_error(sb, __FUNCTION__,
-				"bit already cleared for block %lu", block + i);
+				"bit already cleared for block "E3FSBLK,
+				 block + i);
 			jbd_lock_bh_state(bitmap_bh);
 			BUFFER_TRACE(bitmap_bh, "bit already cleared");
 		} else {
@@ -493,10 +494,10 @@ error_return:
 
 /* Free given blocks, update quota and i_blocks field */
 void ext3_free_blocks(handle_t *handle, struct inode *inode,
-			unsigned long block, unsigned long count)
+			ext3_fsblk_t block, unsigned long count)
 {
 	struct super_block * sb;
-	int dquot_freed_blocks;
+	unsigned long dquot_freed_blocks;
 
 	sb = inode->i_sb;
 	if (!sb) {
@@ -525,7 +526,7 @@ void ext3_free_blocks(handle_t *handle, 
  * data-writes at some point, and disable it for metadata allocations or
  * sync-data inodes.
  */
-static int ext3_test_allocatable(int nr, struct buffer_head *bh)
+static int ext3_test_allocatable(ext3_grpblk_t nr, struct buffer_head *bh)
 {
 	int ret;
 	struct journal_head *jh = bh2jh(bh);
@@ -542,11 +543,11 @@ static int ext3_test_allocatable(int nr,
 	return ret;
 }
 
-static int
-bitmap_search_next_usable_block(int start, struct buffer_head *bh,
-					int maxblocks)
+static ext3_grpblk_t
+bitmap_search_next_usable_block(ext3_grpblk_t start, struct buffer_head *bh,
+					ext3_grpblk_t maxblocks)
 {
-	int next;
+	ext3_grpblk_t next;
 	struct journal_head *jh = bh2jh(bh);
 
 	/*
@@ -576,10 +577,11 @@ bitmap_search_next_usable_block(int star
  * the initial goal; then for a free byte somewhere in the bitmap; then
  * for any free bit in the bitmap.
  */
-static int
-find_next_usable_block(int start, struct buffer_head *bh, int maxblocks)
+static ext3_grpblk_t
+find_next_usable_block(ext3_grpblk_t start, struct buffer_head *bh,
+			ext3_grpblk_t maxblocks)
 {
-	int here, next;
+	ext3_grpblk_t here, next;
 	char *p, *r;
 
 	if (start > 0) {
@@ -591,7 +593,7 @@ find_next_usable_block(int start, struct
 		 * less than EXT3_BLOCKS_PER_GROUP. Aligning up to the
 		 * next 64-bit boundary is simple..
 		 */
-		int end_goal = (start + 63) & ~63;
+		ext3_grpblk_t end_goal = (start + 63) & ~63;
 		if (end_goal > maxblocks)
 			end_goal = maxblocks;
 		here = ext3_find_next_zero_bit(bh->b_data, end_goal, start);
@@ -628,7 +630,7 @@ find_next_usable_block(int start, struct
  * zero (failure).
  */
 static inline int
-claim_block(spinlock_t *lock, int block, struct buffer_head *bh)
+claim_block(spinlock_t *lock, ext3_grpblk_t block, struct buffer_head *bh)
 {
 	struct journal_head *jh = bh2jh(bh);
 	int ret;
@@ -651,12 +653,13 @@ claim_block(spinlock_t *lock, int block,
  * new bitmap.  In that case we must release write access to the old one via
  * ext3_journal_release_buffer(), else we'll run out of credits.
  */
-static int
+static ext3_grpblk_t
 ext3_try_to_allocate(struct super_block *sb, handle_t *handle, int group,
-			struct buffer_head *bitmap_bh, int goal,
+			struct buffer_head *bitmap_bh, ext3_grpblk_t grp_goal,
 			unsigned long *count, struct ext3_reserve_window *my_rsv)
 {
-	int group_first_block, start, end;
+	ext3_fsblk_t group_first_block;
+	ext3_grpblk_t start, end;
 	unsigned long num = 0;
 
 	/* we do allocation within the reservation window if we have a window */
@@ -673,13 +676,13 @@ ext3_try_to_allocate(struct super_block 
 		if (end > EXT3_BLOCKS_PER_GROUP(sb))
 			/* reservation window crosses group boundary */
 			end = EXT3_BLOCKS_PER_GROUP(sb);
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
 		end = EXT3_BLOCKS_PER_GROUP(sb);
@@ -688,43 +691,43 @@ ext3_try_to_allocate(struct super_block 
 	BUG_ON(start > EXT3_BLOCKS_PER_GROUP(sb));
 
 repeat:
-	if (goal < 0 || !ext3_test_allocatable(goal, bitmap_bh)) {
-		goal = find_next_usable_block(start, bitmap_bh, end);
-		if (goal < 0)
+	if (grp_goal < 0 || !ext3_test_allocatable(grp_goal, bitmap_bh)) {
+		grp_goal = find_next_usable_block(start, bitmap_bh, end);
+		if (grp_goal < 0)
 			goto fail_access;
 		if (!my_rsv) {
 			int i;
 
-			for (i = 0; i < 7 && goal > start &&
-					ext3_test_allocatable(goal - 1,
+			for (i = 0; i < 7 && grp_goal > start &&
+					ext3_test_allocatable(grp_goal - 1,
 								bitmap_bh);
-					i++, goal--)
+					i++, grp_goal--)
 				;
 		}
 	}
-	start = goal;
+	start = grp_goal;
 
-	if (!claim_block(sb_bgl_lock(EXT3_SB(sb), group), goal, bitmap_bh)) {
+	if (!claim_block(sb_bgl_lock(EXT3_SB(sb), group), grp_goal, bitmap_bh)) {
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
-		&& ext3_test_allocatable(goal, bitmap_bh)
-		&& claim_block(sb_bgl_lock(EXT3_SB(sb), group), goal, bitmap_bh)) {
+	grp_goal++;
+	while (num < *count && grp_goal < end
+		&& ext3_test_allocatable(grp_goal, bitmap_bh)
+		&& claim_block(sb_bgl_lock(EXT3_SB(sb), group), grp_goal, bitmap_bh)) {
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
@@ -766,12 +769,13 @@ fail_access:
 static int find_next_reservable_window(
 				struct ext3_reserve_window_node *search_head,
 				struct ext3_reserve_window_node *my_rsv,
-				struct super_block * sb, int start_block,
-				int last_block)
+				struct super_block * sb,
+				ext3_fsblk_t start_block,
+				ext3_fsblk_t last_block)
 {
 	struct rb_node *next;
 	struct ext3_reserve_window_node *rsv, *prev;
-	int cur;
+	ext3_fsblk_t cur;
 	int size = my_rsv->rsv_goal_size;
 
 	/* TODO: make the start of the reservation window byte-aligned */
@@ -873,10 +877,10 @@ static int find_next_reservable_window(
  *
  *	@rsv: the reservation
  *
- *	@goal: The goal (group-relative).  It is where the search for a
+ *	@grp_goal: The goal (group-relative).  It is where the search for a
  *		free reservable space should start from.
- *		if we have a goal(goal >0 ), then start from there,
- *		no goal(goal = -1), we start from the first block
+ *		if we have a grp_goal(grp_goal >0 ), then start from there,
+ *		no grp_goal(grp_goal = -1), we start from the first block
  *		of the group.
  *
  *	@sb: the super block
@@ -885,12 +889,12 @@ static int find_next_reservable_window(
  *
  */
 static int alloc_new_reservation(struct ext3_reserve_window_node *my_rsv,
-		int goal, struct super_block *sb,
+		ext3_grpblk_t grp_goal, struct super_block *sb,
 		unsigned int group, struct buffer_head *bitmap_bh)
 {
 	struct ext3_reserve_window_node *search_head;
-	int group_first_block, group_end_block, start_block;
-	int first_free_block;
+	ext3_fsblk_t group_first_block, group_end_block, start_block;
+	ext3_grpblk_t first_free_block;
 	struct rb_root *fs_rsv_root = &EXT3_SB(sb)->s_rsv_window_root;
 	unsigned long size;
 	int ret;
@@ -900,10 +904,10 @@ static int alloc_new_reservation(struct 
 				group * EXT3_BLOCKS_PER_GROUP(sb);
 	group_end_block = group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
 
-	if (goal < 0)
+	if (grp_goal < 0)
 		start_block = group_first_block;
 	else
-		start_block = goal + group_first_block;
+		start_block = grp_goal + group_first_block;
 
 	size = my_rsv->rsv_goal_size;
 
@@ -1057,14 +1061,15 @@ static void try_to_extend_reservation(st
  * sorted double linked list should be fast.
  *
  */
-static int
+static ext3_grpblk_t
 ext3_try_to_allocate_with_rsv(struct super_block *sb, handle_t *handle,
 			unsigned int group, struct buffer_head *bitmap_bh,
-			int goal, struct ext3_reserve_window_node * my_rsv,
+			ext3_grpblk_t grp_goal,
+			struct ext3_reserve_window_node * my_rsv,
 			unsigned long *count, int *errp)
 {
-	unsigned long group_first_block;
-	int ret = 0;
+	ext3_fsblk_t group_first_block;
+	ext3_grpblk_t ret = 0;
 	int fatal;
 	unsigned long num = *count;
 
@@ -1090,12 +1095,12 @@ ext3_try_to_allocate_with_rsv(struct sup
 	 */
 	if (my_rsv == NULL ) {
 		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh,
-						goal, count, NULL);
+						grp_goal, count, NULL);
 		goto out;
 	}
 	/*
-	 * goal is a group relative block number (if there is a goal)
-	 * 0 < goal < EXT3_BLOCKS_PER_GROUP(sb)
+	 * grp_goal is a group relative block number (if there is a goal)
+	 * 0 < grp_goal < EXT3_BLOCKS_PER_GROUP(sb)
 	 * first block is a filesystem wide block number
 	 * first block is the block number of the first block in this group
 	 */
@@ -1119,24 +1124,24 @@ ext3_try_to_allocate_with_rsv(struct sup
 	 */
 	while (1) {
 		if (rsv_is_empty(&my_rsv->rsv_window) || (ret < 0) ||
-			!goal_in_my_reservation(&my_rsv->rsv_window, goal, group, sb)) {
+			!goal_in_my_reservation(&my_rsv->rsv_window, grp_goal, group, sb)) {
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
+			if (!goal_in_my_reservation(&my_rsv->rsv_window, grp_goal, group, sb))
+				grp_goal = -1;
+		} else if (grp_goal > 0 && (my_rsv->rsv_end-grp_goal+1) < *count)
 			try_to_extend_reservation(my_rsv, sb,
-					*count-my_rsv->rsv_end + goal - 1);
+					*count-my_rsv->rsv_end + grp_goal - 1);
 
 		if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
 		    || (my_rsv->rsv_end < group_first_block))
 			BUG();
-		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal,
+		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, grp_goal,
 					   &num, &my_rsv->rsv_window);
 		if (ret >= 0) {
 			my_rsv->rsv_alloc_hit += num;
@@ -1164,7 +1169,7 @@ out:
 
 static int ext3_has_free_blocks(struct ext3_sb_info *sbi)
 {
-	int free_blocks, root_blocks;
+	ext3_fsblk_t free_blocks, root_blocks;
 
 	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
 	root_blocks = le32_to_cpu(sbi->s_es->s_r_blocks_count);
@@ -1200,19 +1205,20 @@ int ext3_should_retry_alloc(struct super
  * bitmap, and then for any free bit if that fails.
  * This function also updates quota and i_blocks field.
  */
-int ext3_new_blocks(handle_t *handle, struct inode *inode,
-			unsigned long goal, unsigned long *count, int *errp)
+ext3_fsblk_t ext3_new_blocks(handle_t *handle, struct inode *inode,
+			ext3_fsblk_t goal, unsigned long *count, int *errp)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *gdp_bh;
 	int group_no;
 	int goal_group;
-	int ret_block;
+	ext3_grpblk_t grp_target_blk;	/* blockgroup relative goal block */
+	ext3_grpblk_t grp_alloc_blk;	/* blockgroup-relative allocated block*/
+	ext3_fsblk_t ret_block;		/* filesyetem-wide allocated block */
 	int bgi;			/* blockgroup iteration index */
-	int target_block;
 	int fatal = 0, err;
 	int performed_allocation = 0;
-	int free_blocks;
+	ext3_grpblk_t free_blocks;	/* number of free blocks in a group */
 	struct super_block *sb;
 	struct ext3_group_desc *gdp;
 	struct ext3_super_block *es;
@@ -1285,16 +1291,17 @@ retry:
 		my_rsv = NULL;
 
 	if (free_blocks > 0) {
-		ret_block = ((goal - le32_to_cpu(es->s_first_data_block)) %
+		grp_target_blk = ((goal - le32_to_cpu(es->s_first_data_block)) %
 				EXT3_BLOCKS_PER_GROUP(sb));
 		bitmap_bh = read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
 			goto io_error;
-		ret_block = ext3_try_to_allocate_with_rsv(sb, handle, group_no,
-					bitmap_bh, ret_block, my_rsv, &num, &fatal);
+		grp_alloc_blk = ext3_try_to_allocate_with_rsv(sb, handle,
+					group_no, bitmap_bh, grp_target_blk,
+					my_rsv,	&num, &fatal);
 		if (fatal)
 			goto out;
-		if (ret_block >= 0)
+		if (grp_alloc_blk >= 0)
 			goto allocated;
 	}
 
@@ -1327,11 +1334,15 @@ retry:
 		bitmap_bh = read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
 			goto io_error;
-		ret_block = ext3_try_to_allocate_with_rsv(sb, handle, group_no,
-					bitmap_bh, -1, my_rsv, &num, &fatal);
+		/*
+		 * try to allocate block(s) from this group, without a goal(-1).
+		 */
+		grp_alloc_blk = ext3_try_to_allocate_with_rsv(sb, handle,
+					group_no, bitmap_bh, -1, my_rsv,
+					&num, &fatal);
 		if (fatal)
 			goto out;
-		if (ret_block >= 0) 
+		if (grp_alloc_blk >= 0)
 			goto allocated;
 	}
 	/*
@@ -1360,18 +1371,19 @@ allocated:
 	if (fatal)
 		goto out;
 
-	target_block = ret_block + group_no * EXT3_BLOCKS_PER_GROUP(sb)
+	ret_block = grp_alloc_blk + group_no * EXT3_BLOCKS_PER_GROUP(sb)
 				+ le32_to_cpu(es->s_first_data_block);
 
-	if (in_range(le32_to_cpu(gdp->bg_block_bitmap), target_block, num) ||
-	    in_range(le32_to_cpu(gdp->bg_inode_bitmap), target_block, num) ||
-	    in_range(target_block, le32_to_cpu(gdp->bg_inode_table),
+	if (in_range(le32_to_cpu(gdp->bg_block_bitmap), ret_block, num) ||
+	    in_range(le32_to_cpu(gdp->bg_inode_bitmap), ret_block, num) ||
+	    in_range(ret_block, le32_to_cpu(gdp->bg_inode_table),
 		      EXT3_SB(sb)->s_itb_per_group) ||
-	    in_range(target_block + num - 1, le32_to_cpu(gdp->bg_inode_table),
+	    in_range(ret_block + num - 1, le32_to_cpu(gdp->bg_inode_table),
 		      EXT3_SB(sb)->s_itb_per_group))
 		ext3_error(sb, "ext3_new_block",
 			    "Allocating block in system zone - "
-			    "blocks from %u, length %lu", target_block, num);
+			    "blocks from "E3FSBLK", length %lu",
+			     ret_block, num);
 
 	performed_allocation = 1;
 
@@ -1380,7 +1392,7 @@ allocated:
 		struct buffer_head *debug_bh;
 
 		/* Record bitmap buffer state in the newly allocated block */
-		debug_bh = sb_find_get_block(sb, target_block);
+		debug_bh = sb_find_get_block(sb, ret_block);
 		if (debug_bh) {
 			BUFFER_TRACE(debug_bh, "state when allocated");
 			BUFFER_TRACE2(debug_bh, bitmap_bh, "bitmap state");
@@ -1393,24 +1405,21 @@ allocated:
 		int i;
 
 		for (i = 0; i < num; i++) {
-			if (ext3_test_bit(ret_block,
+			if (ext3_test_bit(grp_alloc_blk+i,
 					bh2jh(bitmap_bh)->b_committed_data)) {
 				printk("%s: block was unexpectedly set in "
 					"b_committed_data\n", __FUNCTION__);
 			}
 		}
 	}
-	ext3_debug("found bit %d\n", ret_block);
+	ext3_debug("found bit %d\n", grp_alloc_blk);
 	spin_unlock(sb_bgl_lock(sbi, group_no));
 	jbd_unlock_bh_state(bitmap_bh);
 #endif
 
-	/* ret_block was blockgroup-relative.  Now it becomes fs-relative */
-	ret_block = target_block;
-
 	if (ret_block + num - 1 >= le32_to_cpu(es->s_blocks_count)) {
 		ext3_error(sb, "ext3_new_block",
-			    "block(%d) >= blocks count(%d) - "
+			    "block("E3FSBLK") >= blocks count(%d) - "
 			    "block_group = %d, es == %p ", ret_block,
 			le32_to_cpu(es->s_blocks_count), group_no, es);
 		goto out;
@@ -1421,7 +1430,7 @@ allocated:
 	 * list of some description.  We don't know in advance whether
 	 * the caller wants to use it as metadata or data.
 	 */
-	ext3_debug("allocating block %d. Goal hits %d of %d.\n",
+	ext3_debug("allocating block %lu. Goal hits %d of %d.\n",
 			ret_block, goal_hits, goal_attempts);
 
 	spin_lock(sb_bgl_lock(sbi, group_no));
@@ -1461,8 +1470,8 @@ out:
 	return 0;
 }
 
-int ext3_new_block(handle_t *handle, struct inode *inode,
-			unsigned long goal, int *errp)
+ext3_fsblk_t ext3_new_block(handle_t *handle, struct inode *inode,
+			ext3_fsblk_t goal, int *errp)
 {
 	unsigned long count = 1;
 
@@ -1520,7 +1529,7 @@ unsigned long ext3_count_free_blocks(str
 }
 
 static inline int
-block_in_use(unsigned long block, struct super_block *sb, unsigned char *map)
+block_in_use(ext3_fsblk_t block, struct super_block *sb, unsigned char *map)
 {
 	return ext3_test_bit ((block -
 		le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block)) %
diff -puN fs/ext3/ialloc.c~ext3_fsblk_t_fixes fs/ext3/ialloc.c
--- linux-2.6.17-rc4/fs/ext3/ialloc.c~ext3_fsblk_t_fixes	2006-05-25 20:40:13.079584357 -0700
+++ linux-2.6.17-rc4-ming/fs/ext3/ialloc.c	2006-05-25 20:40:13.111580667 -0700
@@ -262,9 +262,11 @@ static int find_group_orlov(struct super
 	int ngroups = sbi->s_groups_count;
 	int inodes_per_group = EXT3_INODES_PER_GROUP(sb);
 	int freei, avefreei;
-	int freeb, avefreeb;
-	int blocks_per_dir, ndirs;
-	int max_debt, max_dirs, min_blocks, min_inodes;
+	ext3_fsblk_t freeb, avefreeb;
+	ext3_fsblk_t blocks_per_dir;
+	int ndirs;
+	int max_debt, max_dirs, min_inodes;
+	ext3_grpblk_t min_blocks;
 	int group = -1, i;
 	struct ext3_group_desc *desc;
 	struct buffer_head *bh;
@@ -307,7 +309,7 @@ static int find_group_orlov(struct super
 	min_inodes = avefreei - inodes_per_group / 4;
 	min_blocks = avefreeb - EXT3_BLOCKS_PER_GROUP(sb) / 4;
 
-	max_debt = EXT3_BLOCKS_PER_GROUP(sb) / max(blocks_per_dir, BLOCK_COST);
+	max_debt = EXT3_BLOCKS_PER_GROUP(sb) / max(blocks_per_dir, (ext3_fsblk_t)BLOCK_COST);
 	if (max_debt * INODE_COST > inodes_per_group)
 		max_debt = inodes_per_group / INODE_COST;
 	if (max_debt > 255)
diff -puN fs/ext3/inode.c~ext3_fsblk_t_fixes fs/ext3/inode.c
--- linux-2.6.17-rc4/fs/ext3/inode.c~ext3_fsblk_t_fixes	2006-05-25 20:40:13.083583896 -0700
+++ linux-2.6.17-rc4-ming/fs/ext3/inode.c	2006-05-25 20:40:13.116580090 -0700
@@ -62,7 +62,7 @@ static int ext3_inode_is_fast_symlink(st
  * still needs to be revoked.
  */
 int ext3_forget(handle_t *handle, int is_metadata, struct inode *inode,
-			struct buffer_head *bh, int blocknr)
+			struct buffer_head *bh, ext3_fsblk_t blocknr)
 {
 	int err;
 
diff -puN fs/ext3/resize.c~ext3_fsblk_t_fixes fs/ext3/resize.c
--- linux-2.6.17-rc4/fs/ext3/resize.c~ext3_fsblk_t_fixes	2006-05-25 20:40:13.086583550 -0700
+++ linux-2.6.17-rc4-ming/fs/ext3/resize.c	2006-05-25 20:40:13.108581013 -0700
@@ -28,16 +28,16 @@ static int verify_group_input(struct sup
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	struct ext3_super_block *es = sbi->s_es;
-	unsigned start = le32_to_cpu(es->s_blocks_count);
-	unsigned end = start + input->blocks_count;
+	ext3_fsblk_t start = le32_to_cpu(es->s_blocks_count);
+	ext3_fsblk_t end = start + input->blocks_count;
 	unsigned group = input->group;
-	unsigned itend = input->inode_table + sbi->s_itb_per_group;
+	ext3_fsblk_t itend = input->inode_table + sbi->s_itb_per_group;
 	unsigned overhead = ext3_bg_has_super(sb, group) ?
 		(1 + ext3_bg_num_gdb(sb, group) +
 		 le16_to_cpu(es->s_reserved_gdt_blocks)) : 0;
-	unsigned metaend = start + overhead;
+	ext3_fsblk_t metaend = start + overhead;
 	struct buffer_head *bh = NULL;
-	int free_blocks_count;
+	ext3_grpblk_t free_blocks_count;
 	int err = -EINVAL;
 
 	input->free_blocks_count = free_blocks_count =
@@ -64,7 +64,8 @@ static int verify_group_input(struct sup
 		ext3_warning(sb, __FUNCTION__, "Bad blocks count %u",
 			     input->blocks_count);
 	else if (!(bh = sb_bread(sb, end - 1)))
-		ext3_warning(sb, __FUNCTION__, "Cannot read last block (%u)",
+		ext3_warning(sb, __FUNCTION__,
+			     "Cannot read last block ("E3FSBLK")",
 			     end - 1);
 	else if (outside(input->block_bitmap, start, end))
 		ext3_warning(sb, __FUNCTION__,
@@ -77,7 +78,7 @@ static int verify_group_input(struct sup
 	else if (outside(input->inode_table, start, end) ||
 	         outside(itend - 1, start, end))
 		ext3_warning(sb, __FUNCTION__,
-			     "Inode table not in group (blocks %u-%u)",
+			     "Inode table not in group (blocks %u-"E3FSBLK")",
 			     input->inode_table, itend - 1);
 	else if (input->inode_bitmap == input->block_bitmap)
 		ext3_warning(sb, __FUNCTION__,
@@ -85,24 +86,27 @@ static int verify_group_input(struct sup
 			     input->block_bitmap);
 	else if (inside(input->block_bitmap, input->inode_table, itend))
 		ext3_warning(sb, __FUNCTION__,
-			     "Block bitmap (%u) in inode table (%u-%u)",
+			     "Block bitmap (%u) in inode table (%u-"E3FSBLK")",
 			     input->block_bitmap, input->inode_table, itend-1);
 	else if (inside(input->inode_bitmap, input->inode_table, itend))
 		ext3_warning(sb, __FUNCTION__,
-			     "Inode bitmap (%u) in inode table (%u-%u)",
+			     "Inode bitmap (%u) in inode table (%u-"E3FSBLK")",
 			     input->inode_bitmap, input->inode_table, itend-1);
 	else if (inside(input->block_bitmap, start, metaend))
 		ext3_warning(sb, __FUNCTION__,
-			     "Block bitmap (%u) in GDT table (%u-%u)",
+			     "Block bitmap (%u) in GDT table"
+			     " ("E3FSBLK"-"E3FSBLK")",
 			     input->block_bitmap, start, metaend - 1);
 	else if (inside(input->inode_bitmap, start, metaend))
 		ext3_warning(sb, __FUNCTION__,
-			     "Inode bitmap (%u) in GDT table (%u-%u)",
+			     "Inode bitmap (%u) in GDT table"
+			     " ("E3FSBLK"-"E3FSBLK")",
 			     input->inode_bitmap, start, metaend - 1);
 	else if (inside(input->inode_table, start, metaend) ||
 	         inside(itend - 1, start, metaend))
 		ext3_warning(sb, __FUNCTION__,
-			     "Inode table (%u-%u) overlaps GDT table (%u-%u)",
+			     "Inode table (%u-"E3FSBLK") overlaps"
+			     "GDT table ("E3FSBLK"-"E3FSBLK")",
 			     input->inode_table, itend - 1, start, metaend - 1);
 	else
 		err = 0;
@@ -171,7 +175,7 @@ static int setup_new_group_blocks(struct
 	struct buffer_head *bh;
 	handle_t *handle;
 	unsigned long block;
-	int bit;
+	ext3_grpblk_t bit;
 	int i;
 	int err = 0, err2;
 
@@ -340,7 +344,7 @@ static int verify_reserved_gdb(struct su
 	while ((grp = ext3_list_backups(sb, &three, &five, &seven)) < end) {
 		if (le32_to_cpu(*p++) != grp * EXT3_BLOCKS_PER_GROUP(sb) + blk){
 			ext3_warning(sb, __FUNCTION__,
-				     "reserved GDT %ld missing grp %d (%ld)",
+				     "reserved GDT %lu missing grp %d (%lu)",
 				     blk, grp,
 				     grp * EXT3_BLOCKS_PER_GROUP(sb) + blk);
 			return -EINVAL;
@@ -907,11 +911,12 @@ int ext3_group_extend(struct super_block
 {
 	unsigned long o_blocks_count;
 	unsigned long o_groups_count;
-	unsigned long last;
-	int add;
+	ext3_grpblk_t last;
+	ext3_grpblk_t add;
 	struct buffer_head * bh;
 	handle_t *handle;
-	int err, freed_blocks;
+	int err;
+	unsigned long freed_blocks;
 
 	/* We don't need to worry about locking wrt other resizers just
 	 * yet: we're going to revalidate es->s_blocks_count after
@@ -1002,10 +1007,10 @@ int ext3_group_extend(struct super_block
 	ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
 	unlock_super(sb);
-	ext3_debug("freeing blocks %ld through %ld\n", o_blocks_count,
+	ext3_debug("freeing blocks %lu through %lu\n", o_blocks_count,
 		   o_blocks_count + add);
 	ext3_free_blocks_sb(handle, sb, o_blocks_count, add, &freed_blocks);
-	ext3_debug("freed blocks %ld through %ld\n", o_blocks_count,
+	ext3_debug("freed blocks %lu through %lu\n", o_blocks_count,
 		   o_blocks_count + add);
 	if ((err = ext3_journal_stop(handle)))
 		goto exit_put;
diff -puN fs/ext3/super.c~ext3_fsblk_t_fixes fs/ext3/super.c
--- linux-2.6.17-rc4/fs/ext3/super.c~ext3_fsblk_t_fixes	2006-05-25 20:40:13.090583089 -0700
+++ linux-2.6.17-rc4-ming/fs/ext3/super.c	2006-05-25 20:40:13.119579744 -0700
@@ -1840,7 +1840,7 @@ static journal_t *ext3_get_dev_journal(s
 	struct buffer_head * bh;
 	journal_t *journal;
 	int start;
-	int len;
+	ext3_fsblk_t len;
 	int hblock, blocksize;
 	unsigned long sb_block;
 	unsigned long offset;
diff -puN fs/ext3/xattr.c~ext3_fsblk_t_fixes fs/ext3/xattr.c
--- linux-2.6.17-rc4/fs/ext3/xattr.c~ext3_fsblk_t_fixes	2006-05-25 20:40:13.093582743 -0700
+++ linux-2.6.17-rc4-ming/fs/ext3/xattr.c	2006-05-25 20:40:13.104581474 -0700
@@ -225,7 +225,7 @@ ext3_xattr_block_get(struct inode *inode
 	error = -ENODATA;
 	if (!EXT3_I(inode)->i_file_acl)
 		goto cleanup;
-	ea_idebug(inode, "reading block %d", EXT3_I(inode)->i_file_acl);
+	ea_idebug(inode, "reading block %u", EXT3_I(inode)->i_file_acl);
 	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
 	if (!bh)
 		goto cleanup;
@@ -233,7 +233,7 @@ ext3_xattr_block_get(struct inode *inode
 		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
 	if (ext3_xattr_check_block(bh)) {
 bad_block:	ext3_error(inode->i_sb, __FUNCTION__,
-			   "inode %ld: bad block %d", inode->i_ino,
+			   "inode %ld: bad block %u", inode->i_ino,
 			   EXT3_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -366,7 +366,7 @@ ext3_xattr_block_list(struct inode *inod
 	error = 0;
 	if (!EXT3_I(inode)->i_file_acl)
 		goto cleanup;
-	ea_idebug(inode, "reading block %d", EXT3_I(inode)->i_file_acl);
+	ea_idebug(inode, "reading block %u", EXT3_I(inode)->i_file_acl);
 	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
 	error = -EIO;
 	if (!bh)
@@ -375,7 +375,7 @@ ext3_xattr_block_list(struct inode *inod
 		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
 	if (ext3_xattr_check_block(bh)) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			   "inode %ld: bad block %d", inode->i_ino,
+			   "inode %ld: bad block %u", inode->i_ino,
 			   EXT3_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -647,7 +647,7 @@ ext3_xattr_block_find(struct inode *inod
 			le32_to_cpu(BHDR(bs->bh)->h_refcount));
 		if (ext3_xattr_check_block(bs->bh)) {
 			ext3_error(sb, __FUNCTION__,
-				"inode %ld: bad block %d", inode->i_ino,
+				"inode %ld: bad block %u", inode->i_ino,
 				EXT3_I(inode)->i_file_acl);
 			error = -EIO;
 			goto cleanup;
@@ -792,11 +792,12 @@ inserted:
 			get_bh(new_bh);
 		} else {
 			/* We need to allocate a new block */
-			int goal = le32_to_cpu(
+			ext3_fsblk_t goal = le32_to_cpu(
 					EXT3_SB(sb)->s_es->s_first_data_block) +
-				EXT3_I(inode)->i_block_group *
+				(ext3_fsblk_t)EXT3_I(inode)->i_block_group *
 				EXT3_BLOCKS_PER_GROUP(sb);
-			int block = ext3_new_block(handle, inode, goal, &error);
+			ext3_fsblk_t block = ext3_new_block(handle, inode,
+							goal, &error);
 			if (error)
 				goto cleanup;
 			ea_idebug(inode, "creating block %d", block);
@@ -847,7 +848,7 @@ cleanup_dquot:
 
 bad_block:
 	ext3_error(inode->i_sb, __FUNCTION__,
-		   "inode %ld: bad block %d", inode->i_ino,
+		   "inode %ld: bad block %u", inode->i_ino,
 		   EXT3_I(inode)->i_file_acl);
 	goto cleanup;
 
@@ -1076,14 +1077,14 @@ ext3_xattr_delete_inode(handle_t *handle
 	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
 	if (!bh) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			"inode %ld: block %d read error", inode->i_ino,
+			"inode %ld: block %u read error", inode->i_ino,
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
 	if (BHDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
 	    BHDR(bh)->h_blocks != cpu_to_le32(1)) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			"inode %ld: bad block %d", inode->i_ino,
+			"inode %ld: bad block %u", inode->i_ino,
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
@@ -1210,11 +1211,11 @@ again:
 		bh = sb_bread(inode->i_sb, ce->e_block);
 		if (!bh) {
 			ext3_error(inode->i_sb, __FUNCTION__,
-				"inode %ld: block %ld read error",
+				"inode %ld: block %lu read error",
 				inode->i_ino, (unsigned long) ce->e_block);
 		} else if (le32_to_cpu(BHDR(bh)->h_refcount) >=
 				EXT3_XATTR_REFCOUNT_MAX) {
-			ea_idebug(inode, "block %ld refcount %d>=%d",
+			ea_idebug(inode, "block %lu refcount %d>=%d",
 				  (unsigned long) ce->e_block,
 				  le32_to_cpu(BHDR(bh)->h_refcount),
 					  EXT3_XATTR_REFCOUNT_MAX);

_


