Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbWEYMkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWEYMkV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965137AbWEYMkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:40:21 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:27041 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965134AbWEYMkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:40:20 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][1/24]ext3 block allocation/reservation fixes to support 2^32 blocks
Message-Id: <20060525214011sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:40:11 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [1/24]  modify around the block allocation code(ext3)
          - Modify around the ext3 block allocation code to replace
            "int" type filesystem block number with "unsigned long".

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/balloc.c linux-2.6.17-rc4.tmp/fs/ext3/balloc.c
--- linux-2.6.17-rc4/fs/ext3/balloc.c	2006-05-25 16:18:35.848388909 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/balloc.c	2006-05-25 16:27:50.071038370 +0900
@@ -223,7 +223,7 @@ void ext3_rsv_window_add(struct super_bl
 {
 	struct rb_root *root = &EXT3_SB(sb)->s_rsv_window_root;
 	struct rb_node *node = &rsv->rsv_node;
-	unsigned int start = rsv->rsv_start;
+	unsigned long start = rsv->rsv_start;
 
 	struct rb_node ** p = &root->rb_node;
 	struct rb_node * parent = NULL;
@@ -656,7 +656,8 @@ ext3_try_to_allocate(struct super_block 
 			struct buffer_head *bitmap_bh, int goal,
 			unsigned long *count, struct ext3_reserve_window *my_rsv)
 {
-	int group_first_block, start, end;
+	unsigned long group_first_block;
+	int start, end;
 	unsigned long num = 0;
 
 	/* we do allocation within the reservation window if we have a window */
@@ -766,12 +767,13 @@ fail_access:
 static int find_next_reservable_window(
 				struct ext3_reserve_window_node *search_head,
 				struct ext3_reserve_window_node *my_rsv,
-				struct super_block * sb, int start_block,
-				int last_block)
+				struct super_block * sb,
+				unsigned long start_block,
+				unsigned long last_block)
 {
 	struct rb_node *next;
 	struct ext3_reserve_window_node *rsv, *prev;
-	int cur;
+	unsigned long cur;
 	int size = my_rsv->rsv_goal_size;
 
 	/* TODO: make the start of the reservation window byte-aligned */
@@ -889,8 +891,8 @@ static int alloc_new_reservation(struct 
 		unsigned int group, struct buffer_head *bitmap_bh)
 {
 	struct ext3_reserve_window_node *search_head;
-	int group_first_block, group_end_block, start_block;
-	int first_free_block;
+	unsigned long group_first_block, group_end_block, start_block;
+	unsigned long first_free_block;
 	struct rb_root *fs_rsv_root = &EXT3_SB(sb)->s_rsv_window_root;
 	unsigned long size;
 	int ret;
@@ -1200,16 +1202,17 @@ int ext3_should_retry_alloc(struct super
  * bitmap, and then for any free bit if that fails.
  * This function also updates quota and i_blocks field.
  */
-int ext3_new_blocks(handle_t *handle, struct inode *inode,
+unsigned long ext3_new_blocks(handle_t *handle, struct inode *inode,
 			unsigned long goal, unsigned long *count, int *errp)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *gdp_bh;
 	int group_no;
 	int goal_group;
-	int ret_block;
+	int group_target_blk;
+	int group_allocated_blk;
+	unsigned long ret_block;
 	int bgi;			/* blockgroup iteration index */
-	int target_block;
 	int fatal = 0, err;
 	int performed_allocation = 0;
 	int free_blocks;
@@ -1285,16 +1288,17 @@ retry:
 		my_rsv = NULL;
 
 	if (free_blocks > 0) {
-		ret_block = ((goal - le32_to_cpu(es->s_first_data_block)) %
+		group_target_blk = ((goal - le32_to_cpu(es->s_first_data_block)) %
 				EXT3_BLOCKS_PER_GROUP(sb));
 		bitmap_bh = read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
 			goto io_error;
-		ret_block = ext3_try_to_allocate_with_rsv(sb, handle, group_no,
-					bitmap_bh, ret_block, my_rsv, &num, &fatal);
+		group_allocated_blk = ext3_try_to_allocate_with_rsv(sb, handle,
+					 group_no, bitmap_bh,
+					group_target_blk, my_rsv, &num, &fatal);
 		if (fatal)
 			goto out;
-		if (ret_block >= 0)
+		if (group_allocated_blk >= 0)
 			goto allocated;
 	}
 
@@ -1327,11 +1331,12 @@ retry:
 		bitmap_bh = read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
 			goto io_error;
-		ret_block = ext3_try_to_allocate_with_rsv(sb, handle, group_no,
+		group_allocated_blk = ext3_try_to_allocate_with_rsv(sb, handle,
+					group_no,
 					bitmap_bh, -1, my_rsv, &num, &fatal);
 		if (fatal)
 			goto out;
-		if (ret_block >= 0) 
+		if (group_allocated_blk >= 0)
 			goto allocated;
 	}
 	/*
@@ -1360,18 +1365,19 @@ allocated:
 	if (fatal)
 		goto out;
 
-	target_block = ret_block + group_no * EXT3_BLOCKS_PER_GROUP(sb)
+	ret_block = group_allocated_blk + group_no *
+				EXT3_BLOCKS_PER_GROUP(sb)
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
+			    "blocks from %lu, length %lu", ret_block, num);
 
 	performed_allocation = 1;
 
@@ -1380,7 +1386,7 @@ allocated:
 		struct buffer_head *debug_bh;
 
 		/* Record bitmap buffer state in the newly allocated block */
-		debug_bh = sb_find_get_block(sb, target_block);
+		debug_bh = sb_find_get_block(sb, ret_block);
 		if (debug_bh) {
 			BUFFER_TRACE(debug_bh, "state when allocated");
 			BUFFER_TRACE2(debug_bh, bitmap_bh, "bitmap state");
@@ -1393,24 +1399,21 @@ allocated:
 		int i;
 
 		for (i = 0; i < num; i++) {
-			if (ext3_test_bit(ret_block,
+			if (ext3_test_bit(group_allocated_blk,
 					bh2jh(bitmap_bh)->b_committed_data)) {
 				printk("%s: block was unexpectedly set in "
 					"b_committed_data\n", __FUNCTION__);
 			}
 		}
 	}
-	ext3_debug("found bit %d\n", ret_block);
+	ext3_debug("found bit %d\n", group_allocated_blk);
 	spin_unlock(sb_bgl_lock(sbi, group_no));
 	jbd_unlock_bh_state(bitmap_bh);
 #endif
 
-	/* ret_block was blockgroup-relative.  Now it becomes fs-relative */
-	ret_block = target_block;
-
 	if (ret_block + num - 1 >= le32_to_cpu(es->s_blocks_count)) {
 		ext3_error(sb, "ext3_new_block",
-			    "block(%d) >= blocks count(%d) - "
+			    "block(%lu) >= blocks count(%d) - "
 			    "block_group = %d, es == %p ", ret_block,
 			le32_to_cpu(es->s_blocks_count), group_no, es);
 		goto out;
@@ -1421,8 +1424,8 @@ allocated:
 	 * list of some description.  We don't know in advance whether
 	 * the caller wants to use it as metadata or data.
 	 */
-	ext3_debug("allocating block %d. Goal hits %d of %d.\n",
-			ret_block, goal_hits, goal_attempts);
+	ext3_debug("allocating block %lu. Goal hits %d of %d.\n",
+		ret_block, goal_hits, goal_attempts);
 
 	spin_lock(sb_bgl_lock(sbi, group_no));
 	gdp->bg_free_blocks_count =
@@ -1461,7 +1464,7 @@ out:
 	return 0;
 }
 
-int ext3_new_block(handle_t *handle, struct inode *inode,
+unsigned long ext3_new_block(handle_t *handle, struct inode *inode,
 			unsigned long goal, int *errp)
 {
 	unsigned long count = 1;
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/xattr.c linux-2.6.17-rc4.tmp/fs/ext3/xattr.c
--- linux-2.6.17-rc4/fs/ext3/xattr.c	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/xattr.c	2006-05-25 16:27:50.072014932 +0900
@@ -792,14 +792,14 @@ inserted:
 			get_bh(new_bh);
 		} else {
 			/* We need to allocate a new block */
-			int goal = le32_to_cpu(
+			unsigned long goal = le32_to_cpu(
 					EXT3_SB(sb)->s_es->s_first_data_block) +
 				EXT3_I(inode)->i_block_group *
 				EXT3_BLOCKS_PER_GROUP(sb);
-			int block = ext3_new_block(handle, inode, goal, &error);
+			unsigned long block = ext3_new_block(handle, inode, goal, &error);
 			if (error)
 				goto cleanup;
-			ea_idebug(inode, "creating block %d", block);
+			ea_idebug(inode, "creating block %lu", block);
 
 			new_bh = sb_getblk(sb, block);
 			if (!new_bh) {
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/include/linux/ext3_fs.h linux-2.6.17-rc4.tmp/include/linux/ext3_fs.h
--- linux-2.6.17-rc4/include/linux/ext3_fs.h	2006-05-25 16:18:36.584717025 +0900
+++ linux-2.6.17-rc4.tmp/include/linux/ext3_fs.h	2006-05-25 16:27:50.072014932 +0900
@@ -732,8 +732,8 @@ struct dir_private_info {
 /* balloc.c */
 extern int ext3_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext3_bg_num_gdb(struct super_block *sb, int group);
-extern int ext3_new_block (handle_t *, struct inode *, unsigned long, int *);
-extern int ext3_new_blocks (handle_t *, struct inode *, unsigned long,
+extern unsigned long ext3_new_block (handle_t *, struct inode *, unsigned long, int *);
+extern unsigned long ext3_new_blocks (handle_t *, struct inode *, unsigned long,
 			unsigned long *, int *);
 extern void ext3_free_blocks (handle_t *, struct inode *, unsigned long,
 			      unsigned long);


