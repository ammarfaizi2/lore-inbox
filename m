Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315406AbSGDXxX>; Thu, 4 Jul 2002 19:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSGDXvk>; Thu, 4 Jul 2002 19:51:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30477 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314835AbSGDXpc>;
	Thu, 4 Jul 2002 19:45:32 -0400
Message-ID: <3D24E011.D64A819@zip.com.au>
Date: Thu, 04 Jul 2002 16:53:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: [patch 4/27] Remove ext2's buffer_head cache
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Remove ext2's open-coded bitmap LRUs.  Core kernel does this for it now.


 fs/ext2/balloc.c           |  162 +++++++++++++------------------------------
 fs/ext2/ialloc.c           |  166 +++++++++++++++------------------------------
 fs/ext2/super.c            |   14 ---
 include/linux/ext2_fs_sb.h |   14 ---
 4 files changed, 107 insertions(+), 249 deletions(-)

--- 2.5.24/fs/ext2/balloc.c~ext2-lrus	Thu Jul  4 16:17:10 2002
+++ 2.5.24-akpm/fs/ext2/balloc.c	Thu Jul  4 16:17:10 2002
@@ -75,9 +75,8 @@ struct ext2_group_desc * ext2_get_group_
  *
  * Return buffer_head on success or NULL in case of failure.
  */
-
-static struct buffer_head *read_block_bitmap(struct super_block *sb,
-						unsigned int block_group)
+static struct buffer_head *
+read_block_bitmap(struct super_block *sb, unsigned int block_group)
 {
 	struct ext2_group_desc * desc;
 	struct buffer_head * bh = NULL;
@@ -95,78 +94,6 @@ error_out:
 	return bh;
 }
 
-/*
- * load_block_bitmap loads the block bitmap for a blocks group
- *
- * It maintains a cache for the last bitmaps loaded.  This cache is managed
- * with a LRU algorithm.
- *
- * Notes:
- * 1/ There is one cache per mounted file system.
- * 2/ If the file system contains less than EXT2_MAX_GROUP_LOADED groups,
- *    this function reads the bitmap without maintaining a LRU cache.
- * 
- * Return the buffer_head of the bitmap or ERR_PTR(-ve).
- */
-static struct buffer_head *load_block_bitmap(struct super_block * sb,
-						unsigned int block_group)
-{
-	struct ext2_sb_info *sbi = EXT2_SB(sb);
-	int i, slot = 0;
-	struct buffer_head *bh = sbi->s_block_bitmap[0];
-
-	if (block_group >= sbi->s_groups_count)
-		ext2_panic (sb, "load_block_bitmap",
-			    "block_group >= groups_count - "
-			    "block_group = %d, groups_count = %lu",
-			    block_group, sbi->s_groups_count);
-	
-	/*
-	 * Do the lookup for the slot.  First of all, check if we're asking
-	 * for the same slot as last time, and did we succeed that last time?
-	 */
-	if (sbi->s_loaded_block_bitmaps > 0 &&
-	    sbi->s_block_bitmap_number[0] == block_group && bh)
-		goto found;
-
-	if (sbi->s_groups_count <= EXT2_MAX_GROUP_LOADED) {
-		slot = block_group;
-		bh = sbi->s_block_bitmap[slot];
-		if (!bh)
-			goto read_it;
-		if (sbi->s_block_bitmap_number[slot] == slot)
-			goto found;
-		ext2_panic (sb, "load_block_bitmap",
-			    "block_group != block_bitmap_number");
-	}
-
-	bh = NULL;
-	for (i = 0; i < sbi->s_loaded_block_bitmaps &&
-		    sbi->s_block_bitmap_number[i] != block_group; i++)
-		;
-	if (i < sbi->s_loaded_block_bitmaps)
-		bh = sbi->s_block_bitmap[i];
-	else if (sbi->s_loaded_block_bitmaps < EXT2_MAX_GROUP_LOADED)
-		sbi->s_loaded_block_bitmaps++;
-	else
-		brelse (sbi->s_block_bitmap[--i]);
-
-	while (i--) {
-		sbi->s_block_bitmap_number[i+1] = sbi->s_block_bitmap_number[i];
-		sbi->s_block_bitmap[i+1] = sbi->s_block_bitmap[i];
-	}
-
-read_it:
-	if (!bh)
-		bh = read_block_bitmap(sb, block_group);
-	sbi->s_block_bitmap_number[slot] = block_group;
-	sbi->s_block_bitmap[slot] = bh;
-	if (!bh)
-		return ERR_PTR(-EIO);
-found:
-	return bh;
-}
-
 static inline int reserve_blocks(struct super_block *sb, int count)
 {
 	struct ext2_sb_info * sbi = EXT2_SB(sb);
@@ -238,7 +165,7 @@ static inline void group_release_blocks(
 void ext2_free_blocks (struct inode * inode, unsigned long block,
 		       unsigned long count)
 {
-	struct buffer_head * bh;
+	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head * bh2;
 	unsigned long block_group;
 	unsigned long bit;
@@ -275,8 +202,9 @@ do_more:
 		overflow = bit + count - EXT2_BLOCKS_PER_GROUP(sb);
 		count -= overflow;
 	}
-	bh = load_block_bitmap (sb, block_group);
-	if (IS_ERR(bh))
+	brelse(bitmap_bh);
+	bitmap_bh = read_block_bitmap(sb, block_group);
+	if (!bitmap_bh)
 		goto error_return;
 
 	desc = ext2_get_group_desc (sb, block_group, &bh2);
@@ -295,7 +223,7 @@ do_more:
 			    block, count);
 
 	for (i = 0, group_freed = 0; i < count; i++) {
-		if (!ext2_clear_bit (bit + i, bh->b_data))
+		if (!ext2_clear_bit(bit + i, bitmap_bh->b_data))
 			ext2_error (sb, "ext2_free_blocks",
 				      "bit already cleared for block %lu",
 				      block + i);
@@ -303,10 +231,10 @@ do_more:
 			group_freed++;
 	}
 
-	mark_buffer_dirty(bh);
+	mark_buffer_dirty(bitmap_bh);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ll_rw_block (WRITE, 1, &bh);
-		wait_on_buffer (bh);
+		ll_rw_block(WRITE, 1, &bitmap_bh);
+		wait_on_buffer(bitmap_bh);
 	}
 
 	group_release_blocks(desc, bh2, group_freed);
@@ -318,6 +246,7 @@ do_more:
 		goto do_more;
 	}
 error_return:
+	brelse(bitmap_bh);
 	release_blocks(sb, freed);
 	unlock_super (sb);
 	DQUOT_FREE_BLOCK(inode, freed);
@@ -384,7 +313,7 @@ got_it:
 int ext2_new_block (struct inode * inode, unsigned long goal,
     u32 * prealloc_count, u32 * prealloc_block, int * err)
 {
-	struct buffer_head *bh;
+	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *bh2;
 	struct ext2_group_desc *desc;
 	int i, j, k, tmp;
@@ -431,13 +360,14 @@ int ext2_new_block (struct inode * inode
 	group_alloc = group_reserve_blocks(desc, bh2, es_alloc);
 	if (group_alloc) {
 		j = ((goal - le32_to_cpu(es->s_first_data_block)) % group_size);
-		bh = load_block_bitmap (sb, i);
-		if (IS_ERR(bh))
+		brelse(bitmap_bh);
+		bitmap_bh = read_block_bitmap(sb, i);
+		if (!bitmap_bh)
 			goto io_error;
 		
 		ext2_debug ("goal is at %d:%d.\n", i, j);
 
-		j = grab_block(bh->b_data, group_size, j);
+		j = grab_block(bitmap_bh->b_data, group_size, j);
 		if (j >= 0)
 			goto got_block;
 		group_release_blocks(desc, bh2, group_alloc);
@@ -461,11 +391,12 @@ int ext2_new_block (struct inode * inode
 	}
 	if (k >= sbi->s_groups_count)
 		goto out_release;
-	bh = load_block_bitmap (sb, i);
-	if (IS_ERR(bh))
+	brelse(bitmap_bh);
+	bitmap_bh = read_block_bitmap(sb, i);
+	if (!bitmap_bh)
 		goto io_error;
 	
-	j = grab_block(bh->b_data, group_size, 0);
+	j = grab_block(bitmap_bh->b_data, group_size, 0);
 	if (j < 0) {
 		ext2_error (sb, "ext2_new_block",
 			    "Free blocks count corrupted for block group %d", i);
@@ -510,7 +441,7 @@ got_block:
 		unsigned n;
 
 		for (n = 0; n < group_alloc && ++j < group_size; n++) {
-			if (ext2_set_bit (j, bh->b_data))
+			if (ext2_set_bit(j, bitmap_bh->b_data))
  				break;
 		}
 		*prealloc_block = block + 1;
@@ -521,10 +452,10 @@ got_block:
 	}
 	write_unlock(&EXT2_I(inode)->i_meta_lock);
 
-	mark_buffer_dirty(bh);
+	mark_buffer_dirty(bitmap_bh);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ll_rw_block (WRITE, 1, &bh);
-		wait_on_buffer (bh);
+		ll_rw_block(WRITE, 1, &bitmap_bh);
+		wait_on_buffer(bitmap_bh);
 	}
 
 	ext2_debug ("allocating block %d. ", block);
@@ -537,6 +468,7 @@ out_unlock:
 	unlock_super (sb);
 	DQUOT_FREE_BLOCK(inode, dq_alloc);
 out:
+	brelse(bitmap_bh);
 	return block;
 
 io_error:
@@ -558,19 +490,20 @@ unsigned long ext2_count_free_blocks (st
 	bitmap_count = 0;
 	desc = NULL;
 	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
-		struct buffer_head *bh;
+		struct buffer_head *bitmap_bh;
 		desc = ext2_get_group_desc (sb, i, NULL);
 		if (!desc)
 			continue;
 		desc_count += le16_to_cpu(desc->bg_free_blocks_count);
-		bh = load_block_bitmap (sb, i);
-		if (IS_ERR(bh))
+		bitmap_bh = read_block_bitmap(sb, i);
+		if (!bitmap_bh)
 			continue;
 		
-		x = ext2_count_free (bh, sb->s_blocksize);
+		x = ext2_count_free(bitmap_bh, sb->s_blocksize);
 		printk ("group %d: stored = %d, counted = %lu\n",
 			i, le16_to_cpu(desc->bg_free_blocks_count), x);
 		bitmap_count += x;
+		brelse(bitmap_bh);
 	}
 	printk("ext2_count_free_blocks: stored = %lu, computed = %lu, %lu\n",
 	       le32_to_cpu(es->s_free_blocks_count), desc_count, bitmap_count);
@@ -645,7 +578,7 @@ unsigned long ext2_bg_num_gdb(struct sup
 /* Called at mount-time, super-block is locked */
 void ext2_check_blocks_bitmap (struct super_block * sb)
 {
-	struct buffer_head * bh;
+	struct buffer_head *bitmap_bh = NULL;
 	struct ext2_super_block * es;
 	unsigned long desc_count, bitmap_count, x, j;
 	unsigned long desc_blocks;
@@ -661,38 +594,43 @@ void ext2_check_blocks_bitmap (struct su
 		if (!desc)
 			continue;
 		desc_count += le16_to_cpu(desc->bg_free_blocks_count);
-		bh = load_block_bitmap (sb, i);
-		if (IS_ERR(bh))
+		brelse(bitmap_bh);
+		bitmap_bh = read_block_bitmap(sb, i);
+		if (!bitmap_bh)
 			continue;
 
-		if (ext2_bg_has_super(sb, i) && !ext2_test_bit(0, bh->b_data))
+		if (ext2_bg_has_super(sb, i) &&
+				!ext2_test_bit(0, bitmap_bh->b_data))
 			ext2_error(sb, __FUNCTION__,
 				   "Superblock in group %d is marked free", i);
 
 		desc_blocks = ext2_bg_num_gdb(sb, i);
 		for (j = 0; j < desc_blocks; j++)
-			if (!ext2_test_bit(j + 1, bh->b_data))
+			if (!ext2_test_bit(j + 1, bitmap_bh->b_data))
 				ext2_error(sb, __FUNCTION__,
 					   "Descriptor block #%ld in group "
 					   "%d is marked free", j, i);
 
-		if (!block_in_use (le32_to_cpu(desc->bg_block_bitmap), sb, bh->b_data))
-			ext2_error (sb, "ext2_check_blocks_bitmap",
+		if (!block_in_use(le32_to_cpu(desc->bg_block_bitmap),
+					sb, bitmap_bh->b_data))
+			ext2_error(sb, "ext2_check_blocks_bitmap",
 				    "Block bitmap for group %d is marked free",
 				    i);
 
-		if (!block_in_use (le32_to_cpu(desc->bg_inode_bitmap), sb, bh->b_data))
-			ext2_error (sb, "ext2_check_blocks_bitmap",
+		if (!block_in_use(le32_to_cpu(desc->bg_inode_bitmap),
+					sb, bitmap_bh->b_data))
+			ext2_error(sb, "ext2_check_blocks_bitmap",
 				    "Inode bitmap for group %d is marked free",
 				    i);
 
 		for (j = 0; j < EXT2_SB(sb)->s_itb_per_group; j++)
-			if (!block_in_use (le32_to_cpu(desc->bg_inode_table) + j, sb, bh->b_data))
+			if (!block_in_use(le32_to_cpu(desc->bg_inode_table) + j,
+						sb, bitmap_bh->b_data))
 				ext2_error (sb, "ext2_check_blocks_bitmap",
 					    "Block #%ld of the inode table in "
 					    "group %d is marked free", j, i);
 
-		x = ext2_count_free (bh, sb->s_blocksize);
+		x = ext2_count_free(bitmap_bh, sb->s_blocksize);
 		if (le16_to_cpu(desc->bg_free_blocks_count) != x)
 			ext2_error (sb, "ext2_check_blocks_bitmap",
 				    "Wrong free blocks count for group %d, "
@@ -702,8 +640,10 @@ void ext2_check_blocks_bitmap (struct su
 	}
 	if (le32_to_cpu(es->s_free_blocks_count) != bitmap_count)
 		ext2_error (sb, "ext2_check_blocks_bitmap",
-			    "Wrong free blocks count in super block, "
-			    "stored = %lu, counted = %lu",
-			    (unsigned long) le32_to_cpu(es->s_free_blocks_count), bitmap_count);
+			"Wrong free blocks count in super block, "
+			"stored = %lu, counted = %lu",
+			(unsigned long)le32_to_cpu(es->s_free_blocks_count),
+			bitmap_count);
+	brelse(bitmap_bh);
 }
 #endif
--- 2.5.24/include/linux/ext2_fs_sb.h~ext2-lrus	Thu Jul  4 16:17:10 2002
+++ 2.5.24-akpm/include/linux/ext2_fs_sb.h	Thu Jul  4 16:17:10 2002
@@ -17,14 +17,6 @@
 #define _LINUX_EXT2_FS_SB
 
 /*
- * The following is not needed anymore since the descriptors buffer
- * heads are now dynamically allocated
- */
-/* #define EXT2_MAX_GROUP_DESC	8 */
-
-#define EXT2_MAX_GROUP_LOADED	8
-
-/*
  * second extended-fs super-block data in memory
  */
 struct ext2_sb_info {
@@ -41,12 +33,6 @@ struct ext2_sb_info {
 	struct buffer_head * s_sbh;	/* Buffer containing the super block */
 	struct ext2_super_block * s_es;	/* Pointer to the super block in the buffer */
 	struct buffer_head ** s_group_desc;
-	unsigned short s_loaded_inode_bitmaps;
-	unsigned short s_loaded_block_bitmaps;
-	unsigned long s_inode_bitmap_number[EXT2_MAX_GROUP_LOADED];
-	struct buffer_head * s_inode_bitmap[EXT2_MAX_GROUP_LOADED];
-	unsigned long s_block_bitmap_number[EXT2_MAX_GROUP_LOADED];
-	struct buffer_head * s_block_bitmap[EXT2_MAX_GROUP_LOADED];
 	unsigned long  s_mount_opt;
 	uid_t s_resuid;
 	gid_t s_resgid;
--- 2.5.24/fs/ext2/super.c~ext2-lrus	Thu Jul  4 16:17:10 2002
+++ 2.5.24-akpm/fs/ext2/super.c	Thu Jul  4 16:17:10 2002
@@ -142,12 +142,6 @@ static void ext2_put_super (struct super
 		if (sbi->s_group_desc[i])
 			brelse (sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
-	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++)
-		if (sbi->s_inode_bitmap[i])
-			brelse (sbi->s_inode_bitmap[i]);
-	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++)
-		if (sbi->s_block_bitmap[i])
-			brelse (sbi->s_block_bitmap[i]);
 	brelse (sbi->s_sbh);
 	sb->u.generic_sbp = NULL;
 	kfree(sbi);
@@ -686,14 +680,6 @@ static int ext2_fill_super(struct super_
 		db_count = i;
 		goto failed_mount2;
 	}
-	for (i = 0; i < EXT2_MAX_GROUP_LOADED; i++) {
-		sbi->s_inode_bitmap_number[i] = 0;
-		sbi->s_inode_bitmap[i] = NULL;
-		sbi->s_block_bitmap_number[i] = 0;
-		sbi->s_block_bitmap[i] = NULL;
-	}
-	sbi->s_loaded_inode_bitmaps = 0;
-	sbi->s_loaded_block_bitmaps = 0;
 	sbi->s_gdb_count = db_count;
 	get_random_bytes(&sbi->s_next_generation, sizeof(u32));
 	/*
--- 2.5.24/fs/ext2/ialloc.c~ext2-lrus	Thu Jul  4 16:17:10 2002
+++ 2.5.24-akpm/fs/ext2/ialloc.c	Thu Jul  4 16:17:10 2002
@@ -30,8 +30,7 @@
  *
  * The file system contains group descriptors which are located after the
  * super block.  Each descriptor contains the number of the bitmap block and
- * the free blocks count in the block.  The descriptors are loaded in memory
- * when a file system is mounted (see ext2_read_super).
+ * the free blocks count in the block.
  */
 
 
@@ -41,8 +40,8 @@
  *
  * Return buffer_head of bitmap on success or NULL.
  */
-static struct buffer_head *read_inode_bitmap (struct super_block * sb,
-					       unsigned long block_group)
+static struct buffer_head *
+read_inode_bitmap(struct super_block * sb, unsigned long block_group)
 {
 	struct ext2_group_desc *desc;
 	struct buffer_head *bh = NULL;
@@ -53,7 +52,7 @@ static struct buffer_head *read_inode_bi
 
 	bh = sb_bread(sb, le32_to_cpu(desc->bg_inode_bitmap));
 	if (!bh)
-		ext2_error (sb, "read_inode_bitmap",
+		ext2_error(sb, "read_inode_bitmap",
 			    "Cannot read inode bitmap - "
 			    "block_group = %lu, inode_bitmap = %lu",
 			    block_group, (unsigned long) desc->bg_inode_bitmap);
@@ -62,75 +61,6 @@ error_out:
 }
 
 /*
- * load_inode_bitmap loads the inode bitmap for a blocks group
- *
- * It maintains a cache for the last bitmaps loaded.  This cache is managed
- * with a LRU algorithm.
- *
- * Notes:
- * 1/ There is one cache per mounted file system.
- * 2/ If the file system contains less than EXT2_MAX_GROUP_LOADED groups,
- *    this function reads the bitmap without maintaining a LRU cache.
- * 
- * Return the buffer_head of the bitmap or the ERR_PTR(error)
- */
-static struct buffer_head *load_inode_bitmap (struct super_block * sb,
-					      unsigned int block_group)
-{
-	int i, slot = 0;
-	struct ext2_sb_info *sbi = EXT2_SB(sb);
-	struct buffer_head *bh = sbi->s_inode_bitmap[0];
-
-	if (block_group >= sbi->s_groups_count)
-		ext2_panic (sb, "load_inode_bitmap",
-			    "block_group >= groups_count - "
-			    "block_group = %d, groups_count = %lu",
-			     block_group, sbi->s_groups_count);
-
-	if (sbi->s_loaded_inode_bitmaps > 0 &&
-	    sbi->s_inode_bitmap_number[0] == block_group && bh)
-		goto found;
-
-	if (sbi->s_groups_count <= EXT2_MAX_GROUP_LOADED) {
-		slot = block_group;
-		bh = sbi->s_inode_bitmap[slot];
-		if (!bh)
-			goto read_it;
-		if (sbi->s_inode_bitmap_number[slot] == slot)
-			goto found;
-		ext2_panic (sb, "load_inode_bitmap",
-			    "block_group != inode_bitmap_number");
-	}
-
-	bh = NULL;
-	for (i = 0; i < sbi->s_loaded_inode_bitmaps &&
-		    sbi->s_inode_bitmap_number[i] != block_group;
-	     i++)
-		;
-	if (i < sbi->s_loaded_inode_bitmaps)
-		bh = sbi->s_inode_bitmap[i];
-	else if (sbi->s_loaded_inode_bitmaps < EXT2_MAX_GROUP_LOADED)
-		sbi->s_loaded_inode_bitmaps++;
-	else
-		brelse (sbi->s_inode_bitmap[--i]);
-
-	while (i--) {
-		sbi->s_inode_bitmap_number[i+1] = sbi->s_inode_bitmap_number[i];
-		sbi->s_inode_bitmap[i+1] = sbi->s_inode_bitmap[i];
-	}
-
-read_it:
-	if (!bh)
-		bh = read_inode_bitmap (sb, block_group);
-	sbi->s_inode_bitmap_number[slot] = block_group;
-	sbi->s_inode_bitmap[slot] = bh;
-	if (!bh)
-		return ERR_PTR(-EIO);
-found:
-	return bh;
-}
-
-/*
  * NOTE! When we get the inode, we're the only people
  * that have access to it, and as such there are no
  * race conditions we have to worry about. The inode
@@ -151,8 +81,8 @@ void ext2_free_inode (struct inode * ino
 	struct super_block * sb = inode->i_sb;
 	int is_directory;
 	unsigned long ino;
-	struct buffer_head * bh;
-	struct buffer_head * bh2;
+	struct buffer_head *bitmap_bh = NULL;
+	struct buffer_head *bh2;
 	unsigned long block_group;
 	unsigned long bit;
 	struct ext2_group_desc * desc;
@@ -186,12 +116,13 @@ void ext2_free_inode (struct inode * ino
 	}
 	block_group = (ino - 1) / EXT2_INODES_PER_GROUP(sb);
 	bit = (ino - 1) % EXT2_INODES_PER_GROUP(sb);
-	bh = load_inode_bitmap (sb, block_group);
-	if (IS_ERR(bh))
+	brelse(bitmap_bh);
+	bitmap_bh = read_inode_bitmap(sb, block_group);
+	if (!bitmap_bh)
 		goto error_return;
 
 	/* Ok, now we can actually update the inode bitmaps.. */
-	if (!ext2_clear_bit (bit, bh->b_data))
+	if (!ext2_clear_bit(bit, bitmap_bh->b_data))
 		ext2_error (sb, "ext2_free_inode",
 			      "bit already cleared for inode %lu", ino);
 	else {
@@ -208,13 +139,14 @@ void ext2_free_inode (struct inode * ino
 			cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) + 1);
 		mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
 	}
-	mark_buffer_dirty(bh);
+	mark_buffer_dirty(bitmap_bh);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ll_rw_block (WRITE, 1, &bh);
-		wait_on_buffer (bh);
+		ll_rw_block(WRITE, 1, &bitmap_bh);
+		wait_on_buffer(bitmap_bh);
 	}
 	sb->s_dirt = 1;
 error_return:
+	brelse(bitmap_bh);
 	unlock_super (sb);
 }
 
@@ -351,9 +283,9 @@ found:
 
 struct inode * ext2_new_inode(struct inode * dir, int mode)
 {
-	struct super_block * sb;
-	struct buffer_head * bh;
-	struct buffer_head * bh2;
+	struct super_block *sb;
+	struct buffer_head *bitmap_bh = NULL;
+	struct buffer_head *bh2;
 	int group, i;
 	ino_t ino;
 	struct inode * inode;
@@ -361,6 +293,7 @@ struct inode * ext2_new_inode(struct ino
 	struct ext2_super_block * es;
 	struct ext2_inode_info *ei;
 	int err;
+	struct inode *ret;
 
 	sb = dir->i_sb;
 	inode = new_inode(sb);
@@ -381,20 +314,21 @@ repeat:
 		goto fail;
 
 	err = -EIO;
-	bh = load_inode_bitmap (sb, group);
-	if (IS_ERR(bh))
+	brelse(bitmap_bh);
+	bitmap_bh = read_inode_bitmap(sb, group);
+	if (!bitmap_bh)
 		goto fail2;
 
-	i = ext2_find_first_zero_bit ((unsigned long *) bh->b_data,
+	i = ext2_find_first_zero_bit((unsigned long *)bitmap_bh->b_data,
 				      EXT2_INODES_PER_GROUP(sb));
 	if (i >= EXT2_INODES_PER_GROUP(sb))
 		goto bad_count;
-	ext2_set_bit (i, bh->b_data);
+	ext2_set_bit(i, bitmap_bh->b_data);
 
-	mark_buffer_dirty(bh);
+	mark_buffer_dirty(bitmap_bh);
 	if (sb->s_flags & MS_SYNCHRONOUS) {
-		ll_rw_block (WRITE, 1, &bh);
-		wait_on_buffer (bh);
+		ll_rw_block(WRITE, 1, &bitmap_bh);
+		wait_on_buffer(bitmap_bh);
 	}
 
 	ino = group * EXT2_INODES_PER_GROUP(sb) + i + 1;
@@ -452,17 +386,19 @@ repeat:
 	insert_inode_hash(inode);
 	mark_inode_dirty(inode);
 
-	unlock_super (sb);
+	unlock_super(sb);
+	ret = inode;
 	if(DQUOT_ALLOC_INODE(inode)) {
 		DQUOT_DROP(inode);
 		inode->i_flags |= S_NOQUOTA;
 		inode->i_nlink = 0;
 		iput(inode);
-		return ERR_PTR(-EDQUOT);
+		ret = ERR_PTR(-EDQUOT);
+	} else {
+		ext2_debug("allocating inode %lu\n", inode->i_ino);
+		ext2_preread_inode(inode);
 	}
-	ext2_debug ("allocating inode %lu\n", inode->i_ino);
-	ext2_preread_inode(inode);
-	return inode;
+	goto out;
 
 fail2:
 	desc = ext2_get_group_desc (sb, group, &bh2);
@@ -476,7 +412,8 @@ fail:
 	unlock_super(sb);
 	make_bad_inode(inode);
 	iput(inode);
-	return ERR_PTR(err);
+	ret = ERR_PTR(err);
+	goto out;
 
 bad_count:
 	ext2_error (sb, "ext2_new_inode",
@@ -491,6 +428,9 @@ bad_count:
 	desc->bg_free_inodes_count = 0;
 	mark_buffer_dirty(bh2);
 	goto repeat;
+out:
+	brelse(bitmap_bh);
+	return ret;
 }
 
 unsigned long ext2_count_free_inodes (struct super_block * sb)
@@ -498,30 +438,33 @@ unsigned long ext2_count_free_inodes (st
 #ifdef EXT2FS_DEBUG
 	struct ext2_super_block * es;
 	unsigned long desc_count = 0, bitmap_count = 0;
+	struct buffer_head *bitmap_bh = NULL;
 	int i;
 
 	lock_super (sb);
 	es = EXT2_SB(sb)->s_es;
 	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
-		struct ext2_group_desc *desc = ext2_get_group_desc (sb, i, NULL);
-		struct buffer_head *bh;
+		struct ext2_group_desc *desc;
 		unsigned x;
 
+		desc = ext2_get_group_desc (sb, i, NULL);
 		if (!desc)
 			continue;
 		desc_count += le16_to_cpu(desc->bg_free_inodes_count);
-		bh = load_inode_bitmap (sb, i);
-		if (IS_ERR(bh))
+		brelse(bitmap_bh);
+		bitmap_bh = read_inode_bitmap(sb, i);
+		if (!bitmap_bh)
 			continue;
 
-		x = ext2_count_free (bh, EXT2_INODES_PER_GROUP(sb) / 8);
+		x = ext2_count_free(bitmap_bh, EXT2_INODES_PER_GROUP(sb) / 8);
 		printk ("group %d: stored = %d, counted = %lu\n",
 			i, le16_to_cpu(desc->bg_free_inodes_count), x);
 		bitmap_count += x;
 	}
+	brelse(bitmap_bh);
 	printk("ext2_count_free_inodes: stored = %lu, computed = %lu, %lu\n",
 		le32_to_cpu(es->s_free_inodes_count), desc_count, bitmap_count);
-	unlock_super (sb);
+	unlock_super(sb);
 	return desc_count;
 #else
 	return le32_to_cpu(EXT2_SB(sb)->s_es->s_free_inodes_count);
@@ -534,21 +477,23 @@ void ext2_check_inodes_bitmap (struct su
 {
 	struct ext2_super_block * es = EXT2_SB(sb)->s_es;
 	unsigned long desc_count = 0, bitmap_count = 0;
+	struct buffer_head *bitmap_bh = NULL;
 	int i;
 
 	for (i = 0; i < EXT2_SB(sb)->s_groups_count; i++) {
-		struct ext2_group_desc *desc = ext2_get_group_desc(sb, i, NULL);
-		struct buffer_head *bh;
+		struct ext2_group_desc *desc;
 		unsigned x;
 
+		desc = ext2_get_group_desc(sb, i, NULL);
 		if (!desc)
 			continue;
 		desc_count += le16_to_cpu(desc->bg_free_inodes_count);
-		bh = load_inode_bitmap (sb, i);
-		if (IS_ERR(bh))
+		brelse(bitmap_bh);
+		bitmap_bh = read_inode_bitmap(sb, i);
+		if (!bitmap_bh)
 			continue;
 		
-		x = ext2_count_free (bh, EXT2_INODES_PER_GROUP(sb) / 8);
+		x = ext2_count_free(bitmap_bh, EXT2_INODES_PER_GROUP(sb) / 8);
 		if (le16_to_cpu(desc->bg_free_inodes_count) != x)
 			ext2_error (sb, "ext2_check_inodes_bitmap",
 				    "Wrong free inodes count in group %d, "
@@ -556,8 +501,9 @@ void ext2_check_inodes_bitmap (struct su
 				    le16_to_cpu(desc->bg_free_inodes_count), x);
 		bitmap_count += x;
 	}
+	brelse(bitmap_bh);
 	if (le32_to_cpu(es->s_free_inodes_count) != bitmap_count)
-		ext2_error (sb, "ext2_check_inodes_bitmap",
+		ext2_error(sb, "ext2_check_inodes_bitmap",
 			    "Wrong free inodes count in super block, "
 			    "stored = %lu, counted = %lu",
 			    (unsigned long)le32_to_cpu(es->s_free_inodes_count),

-
