Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315119AbSGDXuQ>; Thu, 4 Jul 2002 19:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315282AbSGDXtu>; Thu, 4 Jul 2002 19:49:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31757 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314885AbSGDXpj>;
	Thu, 4 Jul 2002 19:45:39 -0400
Message-ID: <3D24E017.223B6171@zip.com.au>
Date: Thu, 04 Jul 2002 16:53:59 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>, ext2-devel@lists.sourceforge.net
Subject: [patch 5/27] Remove ext3's buffer_head cache
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Removes ext3's open-coded inode and allocation bitmap LRUs.

This patch includes a cleanup to ext3_new_block().  The local variables
`bh', `bh2', `i', `j', `k' and `tmp' have been renamed to something
more palatable.




 fs/ext3/balloc.c           |  479 +++++++++++++--------------------------------
 fs/ext3/ialloc.c           |  243 +++++++---------------
 fs/ext3/super.c            |   12 -
 include/linux/ext3_fs_sb.h |   14 -
 4 files changed, 218 insertions(+), 530 deletions(-)

--- 2.5.24/fs/ext3/balloc.c~ext3-lrus	Thu Jul  4 16:17:11 2002
+++ 2.5.24-akpm/fs/ext3/balloc.c	Thu Jul  4 16:17:11 2002
@@ -76,192 +76,36 @@ struct ext3_group_desc * ext3_get_group_
  * Read the bitmap for a given block_group, reading into the specified 
  * slot in the superblock's bitmap cache.
  *
- * Return >=0 on success or a -ve error code.
+ * Return buffer_head on success or NULL in case of failure.
  */
-
-static int read_block_bitmap (struct super_block * sb,
-			       unsigned int block_group,
-			       unsigned long bitmap_nr)
+static struct buffer_head *
+read_block_bitmap(struct super_block *sb, unsigned int block_group)
 {
-	struct ext3_group_desc * gdp;
+	struct ext3_group_desc * desc;
 	struct buffer_head * bh = NULL;
-	int retval = -EIO;
 	
-	gdp = ext3_get_group_desc (sb, block_group, NULL);
-	if (!gdp)
+	desc = ext3_get_group_desc (sb, block_group, NULL);
+	if (!desc)
 		goto error_out;
-	retval = 0;
-	bh = sb_bread(sb, le32_to_cpu(gdp->bg_block_bitmap));
-	if (!bh) {
+	bh = sb_bread(sb, le32_to_cpu(desc->bg_block_bitmap));
+	if (!bh)
 		ext3_error (sb, "read_block_bitmap",
 			    "Cannot read block bitmap - "
 			    "block_group = %d, block_bitmap = %lu",
-			    block_group, (unsigned long) gdp->bg_block_bitmap);
-		retval = -EIO;
-	}
-	/*
-	 * On IO error, just leave a zero in the superblock's block pointer for
-	 * this group.  The IO will be retried next time.
-	 */
+			    block_group, (unsigned long) desc->bg_block_bitmap);
 error_out:
-	sb->u.ext3_sb.s_block_bitmap_number[bitmap_nr] = block_group;
-	sb->u.ext3_sb.s_block_bitmap[bitmap_nr] = bh;
-	return retval;
-}
-
-/*
- * load_block_bitmap loads the block bitmap for a blocks group
- *
- * It maintains a cache for the last bitmaps loaded.  This cache is managed
- * with a LRU algorithm.
- *
- * Notes:
- * 1/ There is one cache per mounted file system.
- * 2/ If the file system contains less than EXT3_MAX_GROUP_LOADED groups,
- *    this function reads the bitmap without maintaining a LRU cache.
- * 
- * Return the slot used to store the bitmap, or a -ve error code.
- */
-static int __load_block_bitmap (struct super_block * sb,
-			        unsigned int block_group)
-{
-	int i, j, retval = 0;
-	unsigned long block_bitmap_number;
-	struct buffer_head * block_bitmap;
-
-	if (block_group >= sb->u.ext3_sb.s_groups_count)
-		ext3_panic (sb, "load_block_bitmap",
-			    "block_group >= groups_count - "
-			    "block_group = %d, groups_count = %lu",
-			    block_group, sb->u.ext3_sb.s_groups_count);
-
-	if (sb->u.ext3_sb.s_groups_count <= EXT3_MAX_GROUP_LOADED) {
-		if (sb->u.ext3_sb.s_block_bitmap[block_group]) {
-			if (sb->u.ext3_sb.s_block_bitmap_number[block_group] ==
-			    block_group)
-				return block_group;
-			ext3_error (sb, "__load_block_bitmap",
-				    "block_group != block_bitmap_number");
-		}
-		retval = read_block_bitmap (sb, block_group, block_group);
-		if (retval < 0)
-			return retval;
-		return block_group;
-	}
-
-	for (i = 0; i < sb->u.ext3_sb.s_loaded_block_bitmaps &&
-		    sb->u.ext3_sb.s_block_bitmap_number[i] != block_group; i++)
-		;
-	if (i < sb->u.ext3_sb.s_loaded_block_bitmaps &&
-  	    sb->u.ext3_sb.s_block_bitmap_number[i] == block_group) {
-		block_bitmap_number = sb->u.ext3_sb.s_block_bitmap_number[i];
-		block_bitmap = sb->u.ext3_sb.s_block_bitmap[i];
-		for (j = i; j > 0; j--) {
-			sb->u.ext3_sb.s_block_bitmap_number[j] =
-				sb->u.ext3_sb.s_block_bitmap_number[j - 1];
-			sb->u.ext3_sb.s_block_bitmap[j] =
-				sb->u.ext3_sb.s_block_bitmap[j - 1];
-		}
-		sb->u.ext3_sb.s_block_bitmap_number[0] = block_bitmap_number;
-		sb->u.ext3_sb.s_block_bitmap[0] = block_bitmap;
-
-		/*
-		 * There's still one special case here --- if block_bitmap == 0
-		 * then our last attempt to read the bitmap failed and we have
-		 * just ended up caching that failure.  Try again to read it.
-		 */
-		if (!block_bitmap)
-			retval = read_block_bitmap (sb, block_group, 0);
-	} else {
-		if (sb->u.ext3_sb.s_loaded_block_bitmaps<EXT3_MAX_GROUP_LOADED)
-			sb->u.ext3_sb.s_loaded_block_bitmaps++;
-		else
-			brelse (sb->u.ext3_sb.s_block_bitmap
-					[EXT3_MAX_GROUP_LOADED - 1]);
-		for (j = sb->u.ext3_sb.s_loaded_block_bitmaps - 1;
-					j > 0;  j--) {
-			sb->u.ext3_sb.s_block_bitmap_number[j] =
-				sb->u.ext3_sb.s_block_bitmap_number[j - 1];
-			sb->u.ext3_sb.s_block_bitmap[j] =
-				sb->u.ext3_sb.s_block_bitmap[j - 1];
-		}
-		retval = read_block_bitmap (sb, block_group, 0);
-	}
-	return retval;
-}
-
-/*
- * Load the block bitmap for a given block group.  First of all do a couple
- * of fast lookups for common cases and then pass the request onto the guts
- * of the bitmap loader.
- *
- * Return the slot number of the group in the superblock bitmap cache's on
- * success, or a -ve error code.
- *
- * There is still one inconsistency here --- if the number of groups in this
- * filesystems is <= EXT3_MAX_GROUP_LOADED, then we have no way of 
- * differentiating between a group for which we have never performed a bitmap
- * IO request, and a group for which the last bitmap read request failed.
- */
-static inline int load_block_bitmap (struct super_block * sb,
-				     unsigned int block_group)
-{
-	int slot;
-	
-	/*
-	 * Do the lookup for the slot.  First of all, check if we're asking
-	 * for the same slot as last time, and did we succeed that last time?
-	 */
-	if (sb->u.ext3_sb.s_loaded_block_bitmaps > 0 &&
-	    sb->u.ext3_sb.s_block_bitmap_number[0] == block_group &&
-	    sb->u.ext3_sb.s_block_bitmap[0]) {
-		return 0;
-	}
-	/*
-	 * Or can we do a fast lookup based on a loaded group on a filesystem
-	 * small enough to be mapped directly into the superblock?
-	 */
-	else if (sb->u.ext3_sb.s_groups_count <= EXT3_MAX_GROUP_LOADED && 
-		 sb->u.ext3_sb.s_block_bitmap_number[block_group]==block_group
-			&& sb->u.ext3_sb.s_block_bitmap[block_group]) {
-		slot = block_group;
-	}
-	/*
-	 * If not, then do a full lookup for this block group.
-	 */
-	else {
-		slot = __load_block_bitmap (sb, block_group);
-	}
-
-	/*
-	 * <0 means we just got an error
-	 */
-	if (slot < 0)
-		return slot;
-	
-	/*
-	 * If it's a valid slot, we may still have cached a previous IO error,
-	 * in which case the bh in the superblock cache will be zero.
-	 */
-	if (!sb->u.ext3_sb.s_block_bitmap[slot])
-		return -EIO;
-	
-	/*
-	 * Must have been read in OK to get this far.
-	 */
-	return slot;
+	return bh;
 }
 
 /* Free given blocks, update quota and i_blocks field */
 void ext3_free_blocks (handle_t *handle, struct inode * inode,
 			unsigned long block, unsigned long count)
 {
-	struct buffer_head *bitmap_bh;
+	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *gd_bh;
 	unsigned long block_group;
 	unsigned long bit;
 	unsigned long i;
-	int bitmap_nr;
 	unsigned long overflow;
 	struct super_block * sb;
 	struct ext3_group_desc * gdp;
@@ -300,11 +144,10 @@ do_more:
 		overflow = bit + count - EXT3_BLOCKS_PER_GROUP(sb);
 		count -= overflow;
 	}
-	bitmap_nr = load_block_bitmap (sb, block_group);
-	if (bitmap_nr < 0)
+	brelse(bitmap_bh);
+	bitmap_bh = read_block_bitmap(sb, block_group);
+	if (!bitmap_bh)
 		goto error_return;
-	
-	bitmap_bh = sb->u.ext3_sb.s_block_bitmap[bitmap_nr];
 	gdp = ext3_get_group_desc (sb, block_group, &gd_bh);
 	if (!gdp)
 		goto error_return;
@@ -421,6 +264,7 @@ do_more:
 	}
 	sb->s_dirt = 1;
 error_return:
+	brelse(bitmap_bh);
 	ext3_std_error(sb, err);
 	unlock_super(sb);
 	if (dquot_freed_blocks)
@@ -530,29 +374,28 @@ static int find_next_usable_block(int st
  * bitmap, and then for any free bit if that fails.
  * This function also updates quota and i_blocks field.
  */
-int ext3_new_block (handle_t *handle, struct inode * inode,
-		unsigned long goal, u32 * prealloc_count,
-		u32 * prealloc_block, int * errp)
-{
-	struct buffer_head * bh, *bhtmp;
-	struct buffer_head * bh2;
-#if 0
-	char * p, * r;
-#endif
-	int i, j, k, tmp, alloctmp;
-	int bitmap_nr;
+int
+ext3_new_block(handle_t *handle, struct inode *inode, unsigned long goal,
+		u32 *prealloc_count, u32 *prealloc_block, int *errp)
+{
+	struct buffer_head *bitmap_bh = NULL;	/* bh */
+	struct buffer_head *gdp_bh;		/* bh2 */
+	int group_no;				/* i */
+	int ret_block;				/* j */
+	int bit;				/* k */
+	int target_block;			/* tmp */
 	int fatal = 0, err;
 	int performed_allocation = 0;
-	struct super_block * sb;
-	struct ext3_group_desc * gdp;
-	struct ext3_super_block * es;
+	struct super_block *sb;
+	struct ext3_group_desc *gdp;
+	struct ext3_super_block *es;
 #ifdef EXT3FS_DEBUG
 	static int goal_hits = 0, goal_attempts = 0;
 #endif
 	*errp = -ENOSPC;
 	sb = inode->i_sb;
 	if (!sb) {
-		printk ("ext3_new_block: nonexistent device");
+		printk("ext3_new_block: nonexistent device");
 		return 0;
 	}
 
@@ -564,17 +407,17 @@ int ext3_new_block (handle_t *handle, st
 		return 0;
 	}
 
-	lock_super (sb);
+	lock_super(sb);
 	es = sb->u.ext3_sb.s_es;
 	if (le32_to_cpu(es->s_free_blocks_count) <=
 			le32_to_cpu(es->s_r_blocks_count) &&
 	    ((sb->u.ext3_sb.s_resuid != current->fsuid) &&
 	     (sb->u.ext3_sb.s_resgid == 0 ||
-	      !in_group_p (sb->u.ext3_sb.s_resgid)) && 
+	      !in_group_p(sb->u.ext3_sb.s_resgid)) && 
 	     !capable(CAP_SYS_RESOURCE)))
 		goto out;
 
-	ext3_debug ("goal=%lu.\n", goal);
+	ext3_debug("goal=%lu.\n", goal);
 
 	/*
 	 * First, test whether the goal block is free.
@@ -582,64 +425,62 @@ int ext3_new_block (handle_t *handle, st
 	if (goal < le32_to_cpu(es->s_first_data_block) ||
 	    goal >= le32_to_cpu(es->s_blocks_count))
 		goal = le32_to_cpu(es->s_first_data_block);
-	i = (goal - le32_to_cpu(es->s_first_data_block)) /
+	group_no = (goal - le32_to_cpu(es->s_first_data_block)) /
 			EXT3_BLOCKS_PER_GROUP(sb);
-	gdp = ext3_get_group_desc (sb, i, &bh2);
+	gdp = ext3_get_group_desc(sb, group_no, &gdp_bh);
 	if (!gdp)
 		goto io_error;
 
 	if (le16_to_cpu(gdp->bg_free_blocks_count) > 0) {
-		j = ((goal - le32_to_cpu(es->s_first_data_block)) %
+		ret_block = ((goal - le32_to_cpu(es->s_first_data_block)) %
 				EXT3_BLOCKS_PER_GROUP(sb));
 #ifdef EXT3FS_DEBUG
-		if (j)
+		if (ret_block)
 			goal_attempts++;
 #endif
-		bitmap_nr = load_block_bitmap (sb, i);
-		if (bitmap_nr < 0)
+		bitmap_bh = read_block_bitmap(sb, group_no);
+		if (!bitmap_bh)
 			goto io_error;
-		
-		bh = sb->u.ext3_sb.s_block_bitmap[bitmap_nr];
 
-		ext3_debug ("goal is at %d:%d.\n", i, j);
+		ext3_debug("goal is at %d:%d.\n", group_no, ret_block);
 
-		if (ext3_test_allocatable(j, bh)) {
+		if (ext3_test_allocatable(ret_block, bitmap_bh)) {
 #ifdef EXT3FS_DEBUG
 			goal_hits++;
-			ext3_debug ("goal bit allocated.\n");
+			ext3_debug("goal bit allocated.\n");
 #endif
 			goto got_block;
 		}
 
-		j = find_next_usable_block(j, bh, EXT3_BLOCKS_PER_GROUP(sb));
-		if (j >= 0)
+		ret_block = find_next_usable_block(ret_block, bitmap_bh,
+				EXT3_BLOCKS_PER_GROUP(sb));
+		if (ret_block >= 0)
 			goto search_back;
 	}
 
-	ext3_debug ("Bit not found in block group %d.\n", i);
+	ext3_debug("Bit not found in block group %d.\n", group_no);
 
 	/*
 	 * Now search the rest of the groups.  We assume that 
 	 * i and gdp correctly point to the last group visited.
 	 */
-	for (k = 0; k < sb->u.ext3_sb.s_groups_count; k++) {
-		i++;
-		if (i >= sb->u.ext3_sb.s_groups_count)
-			i = 0;
-		gdp = ext3_get_group_desc (sb, i, &bh2);
+	for (bit = 0; bit < sb->u.ext3_sb.s_groups_count; bit++) {
+		group_no++;
+		if (group_no >= sb->u.ext3_sb.s_groups_count)
+			group_no = 0;
+		gdp = ext3_get_group_desc(sb, group_no, &gdp_bh);
 		if (!gdp) {
 			*errp = -EIO;
 			goto out;
 		}
 		if (le16_to_cpu(gdp->bg_free_blocks_count) > 0) {
-			bitmap_nr = load_block_bitmap (sb, i);
-			if (bitmap_nr < 0)
+			brelse(bitmap_bh);
+			bitmap_bh = read_block_bitmap(sb, group_no);
+			if (!bitmap_bh)
 				goto io_error;
-	
-			bh = sb->u.ext3_sb.s_block_bitmap[bitmap_nr];
-			j = find_next_usable_block(-1, bh, 
+			ret_block = find_next_usable_block(-1, bitmap_bh, 
 						   EXT3_BLOCKS_PER_GROUP(sb));
-			if (j >= 0) 
+			if (ret_block >= 0) 
 				goto search_back;
 		}
 	}
@@ -653,47 +494,51 @@ search_back:
 	 * bitmap.  Now search backwards up to 7 bits to find the
 	 * start of this group of free blocks.
 	 */
-	for (	k = 0;
-		k < 7 && j > 0 && ext3_test_allocatable(j - 1, bh);
-		k++, j--)
+	for (	bit = 0;
+		bit < 7 && ret_block > 0 &&
+			ext3_test_allocatable(ret_block - 1, bitmap_bh);
+		bit++, ret_block--)
 		;
 	
 got_block:
 
-	ext3_debug ("using block group %d(%d)\n", i, gdp->bg_free_blocks_count);
+	ext3_debug("using block group %d(%d)\n", i, gdp->bg_free_blocks_count);
 
 	/* Make sure we use undo access for the bitmap, because it is
            critical that we do the frozen_data COW on bitmap buffers in
            all cases even if the buffer is in BJ_Forget state in the
            committing transaction.  */
-	BUFFER_TRACE(bh, "get undo access for marking new block");
-	fatal = ext3_journal_get_undo_access(handle, bh);
-	if (fatal) goto out;
-	
-	BUFFER_TRACE(bh2, "get_write_access");
-	fatal = ext3_journal_get_write_access(handle, bh2);
-	if (fatal) goto out;
+	BUFFER_TRACE(bitmap_bh, "get undo access for marking new block");
+	fatal = ext3_journal_get_undo_access(handle, bitmap_bh);
+	if (fatal)
+		goto out;
+	
+	BUFFER_TRACE(gdp_bh, "get_write_access");
+	fatal = ext3_journal_get_write_access(handle, gdp_bh);
+	if (fatal)
+		goto out;
 
 	BUFFER_TRACE(sb->u.ext3_sb.s_sbh, "get_write_access");
 	fatal = ext3_journal_get_write_access(handle, sb->u.ext3_sb.s_sbh);
-	if (fatal) goto out;
+	if (fatal)
+		goto out;
 
-	tmp = j + i * EXT3_BLOCKS_PER_GROUP(sb)
+	target_block = ret_block + group_no * EXT3_BLOCKS_PER_GROUP(sb)
 				+ le32_to_cpu(es->s_first_data_block);
 
-	if (tmp == le32_to_cpu(gdp->bg_block_bitmap) ||
-	    tmp == le32_to_cpu(gdp->bg_inode_bitmap) ||
-	    in_range (tmp, le32_to_cpu(gdp->bg_inode_table),
+	if (target_block == le32_to_cpu(gdp->bg_block_bitmap) ||
+	    target_block == le32_to_cpu(gdp->bg_inode_bitmap) ||
+	    in_range(target_block, le32_to_cpu(gdp->bg_inode_table),
 		      sb->u.ext3_sb.s_itb_per_group))
-		ext3_error (sb, "ext3_new_block",
+		ext3_error(sb, "ext3_new_block",
 			    "Allocating block in system zone - "
-			    "block = %u", tmp);
+			    "block = %u", target_block);
 
 	/* The superblock lock should guard against anybody else beating
 	 * us to this point! */
-	J_ASSERT_BH(bh, !ext3_test_bit(j, bh->b_data));
-	BUFFER_TRACE(bh, "setting bitmap bit");
-	ext3_set_bit(j, bh->b_data);
+	J_ASSERT_BH(bitmap_bh, !ext3_test_bit(ret_block, bitmap_bh->b_data));
+	BUFFER_TRACE(bitmap_bh, "setting bitmap bit");
+	ext3_set_bit(ret_block, bitmap_bh->b_data);
 	performed_allocation = 1;
 
 #ifdef CONFIG_JBD_DEBUG
@@ -701,80 +546,33 @@ got_block:
 		struct buffer_head *debug_bh;
 
 		/* Record bitmap buffer state in the newly allocated block */
-		debug_bh = sb_find_get_block(sb, tmp);
+		debug_bh = sb_find_get_block(sb, target_block);
 		if (debug_bh) {
 			BUFFER_TRACE(debug_bh, "state when allocated");
-			BUFFER_TRACE2(debug_bh, bh, "bitmap state");
+			BUFFER_TRACE2(debug_bh, bitmap_bh, "bitmap state");
 			brelse(debug_bh);
 		}
 	}
 #endif
-	if (buffer_jbd(bh) && bh2jh(bh)->b_committed_data)
-		J_ASSERT_BH(bh, !ext3_test_bit(j, bh2jh(bh)->b_committed_data));
-	bhtmp = bh;
-	alloctmp = j;
-
-	ext3_debug ("found bit %d\n", j);
-
-	/*
-	 * Do block preallocation now if required.
-	 */
-#ifdef EXT3_PREALLOCATE
-	/*
-	 * akpm: this is not enabled for ext3.  Need to use
-	 * ext3_test_allocatable()
-	 */
-	/* Writer: ->i_prealloc* */
-	if (prealloc_count && !*prealloc_count) {
-		int	prealloc_goal;
-		unsigned long next_block = tmp + 1;
-
-		prealloc_goal = es->s_prealloc_blocks ?
-			es->s_prealloc_blocks : EXT3_DEFAULT_PREALLOC_BLOCKS;
-
-		*prealloc_block = next_block;
-		/* Writer: end */
-		for (k = 1;
-		     k < prealloc_goal && (j + k) < EXT3_BLOCKS_PER_GROUP(sb);
-		     k++, next_block++) {
-			if (DQUOT_PREALLOC_BLOCK(inode, 1))
-				break;
-			/* Writer: ->i_prealloc* */
-			if (*prealloc_block + *prealloc_count != next_block ||
-			    ext3_set_bit (j + k, bh->b_data)) {
-				/* Writer: end */
-				DQUOT_FREE_BLOCK(inode, 1);
- 				break;
-			}
-			(*prealloc_count)++;
-			/* Writer: end */
-		}	
-		/*
-		 * As soon as we go for per-group spinlocks we'll need these
-		 * done inside the loop above.
-		 */
-		gdp->bg_free_blocks_count =
-			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) -
-			       (k - 1));
-		es->s_free_blocks_count =
-			cpu_to_le32(le32_to_cpu(es->s_free_blocks_count) -
-			       (k - 1));
-		ext3_debug ("Preallocated a further %lu bits.\n",
-			       (k - 1));
-	}
-#endif
+	if (buffer_jbd(bitmap_bh) && bh2jh(bitmap_bh)->b_committed_data)
+		J_ASSERT_BH(bitmap_bh,
+			!ext3_test_bit(ret_block,
+					bh2jh(bitmap_bh)->b_committed_data));
+	ext3_debug("found bit %d\n", ret_block);
 
-	j = tmp;
+	/* ret_block was blockgroup-relative.  Now it becomes fs-relative */
+	ret_block = target_block;
 
-	BUFFER_TRACE(bh, "journal_dirty_metadata for bitmap block");
-	err = ext3_journal_dirty_metadata(handle, bh);
-	if (!fatal) fatal = err;
+	BUFFER_TRACE(bitmap_bh, "journal_dirty_metadata for bitmap block");
+	err = ext3_journal_dirty_metadata(handle, bitmap_bh);
+	if (!fatal)
+		fatal = err;
 	
-	if (j >= le32_to_cpu(es->s_blocks_count)) {
-		ext3_error (sb, "ext3_new_block",
+	if (ret_block >= le32_to_cpu(es->s_blocks_count)) {
+		ext3_error(sb, "ext3_new_block",
 			    "block(%d) >= blocks count(%d) - "
-			    "block_group = %d, es == %p ",j,
-			le32_to_cpu(es->s_blocks_count), i, es);
+			    "block_group = %d, es == %p ", ret_block,
+			le32_to_cpu(es->s_blocks_count), group_no, es);
 		goto out;
 	}
 
@@ -783,30 +581,33 @@ got_block:
 	 * list of some description.  We don't know in advance whether
 	 * the caller wants to use it as metadata or data.
 	 */
-
-	ext3_debug ("allocating block %d. "
-		    "Goal hits %d of %d.\n", j, goal_hits, goal_attempts);
+	ext3_debug("allocating block %d. Goal hits %d of %d.\n",
+			ret_block, goal_hits, goal_attempts);
 
 	gdp->bg_free_blocks_count =
 			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) - 1);
 	es->s_free_blocks_count =
 			cpu_to_le32(le32_to_cpu(es->s_free_blocks_count) - 1);
 
-	BUFFER_TRACE(bh2, "journal_dirty_metadata for group descriptor");
-	err = ext3_journal_dirty_metadata(handle, bh2);
-	if (!fatal) fatal = err;
-	
-	BUFFER_TRACE(bh, "journal_dirty_metadata for superblock");
+	BUFFER_TRACE(gdp_bh, "journal_dirty_metadata for group descriptor");
+	err = ext3_journal_dirty_metadata(handle, gdp_bh);
+	if (!fatal)
+		fatal = err;
+
+	BUFFER_TRACE(sb->u.ext3_sb.s_sbh,
+			"journal_dirty_metadata for superblock");
 	err = ext3_journal_dirty_metadata(handle, sb->u.ext3_sb.s_sbh);
-	if (!fatal) fatal = err;
+	if (!fatal)
+		fatal = err;
 
 	sb->s_dirt = 1;
 	if (fatal)
 		goto out;
 
-	unlock_super (sb);
+	unlock_super(sb);
 	*errp = 0;
-	return j;
+	brelse(bitmap_bh);
+	return ret_block;
 	
 io_error:
 	*errp = -EIO;
@@ -815,55 +616,57 @@ out:
 		*errp = fatal;
 		ext3_std_error(sb, fatal);
 	}
-	unlock_super (sb);
+	unlock_super(sb);
 	/*
 	 * Undo the block allocation
 	 */
 	if (!performed_allocation)
 		DQUOT_FREE_BLOCK(inode, 1);
+	brelse(bitmap_bh);
 	return 0;
 	
 }
 
-unsigned long ext3_count_free_blocks (struct super_block * sb)
+unsigned long ext3_count_free_blocks(struct super_block *sb)
 {
 #ifdef EXT3FS_DEBUG
-	struct ext3_super_block * es;
+	struct ext3_super_block *es;
 	unsigned long desc_count, bitmap_count, x;
-	int bitmap_nr;
-	struct ext3_group_desc * gdp;
+	struct buffer_head *bitmap_bh = NULL;
+	struct ext3_group_desc *gdp;
 	int i;
 	
-	lock_super (sb);
+	lock_super(sb);
 	es = sb->u.ext3_sb.s_es;
 	desc_count = 0;
 	bitmap_count = 0;
 	gdp = NULL;
 	for (i = 0; i < sb->u.ext3_sb.s_groups_count; i++) {
-		gdp = ext3_get_group_desc (sb, i, NULL);
+		gdp = ext3_get_group_desc(sb, i, NULL);
 		if (!gdp)
 			continue;
 		desc_count += le16_to_cpu(gdp->bg_free_blocks_count);
-		bitmap_nr = load_block_bitmap (sb, i);
-		if (bitmap_nr < 0)
+		brelse(bitmap_bh);
+		bitmap_bh = read_block_bitmap(sb, i);
+		if (bitmap_bh == NULL)
 			continue;
 		
-		x = ext3_count_free (sb->u.ext3_sb.s_block_bitmap[bitmap_nr],
-				     sb->s_blocksize);
-		printk ("group %d: stored = %d, counted = %lu\n",
+		x = ext3_count_free(bitmap_bh, sb->s_blocksize);
+		printk("group %d: stored = %d, counted = %lu\n",
 			i, le16_to_cpu(gdp->bg_free_blocks_count), x);
 		bitmap_count += x;
 	}
+	brelse(bitmap_bh);
 	printk("ext3_count_free_blocks: stored = %lu, computed = %lu, %lu\n",
 	       le32_to_cpu(es->s_free_blocks_count), desc_count, bitmap_count);
-	unlock_super (sb);
+	unlock_super(sb);
 	return bitmap_count;
 #else
 	return le32_to_cpu(sb->u.ext3_sb.s_es->s_free_blocks_count);
 #endif
 }
 
-static inline int block_in_use (unsigned long block,
+static inline int block_in_use(unsigned long block,
 				struct super_block * sb,
 				unsigned char * map)
 {
@@ -928,12 +731,11 @@ unsigned long ext3_bg_num_gdb(struct sup
 /* Called at mount-time, super-block is locked */
 void ext3_check_blocks_bitmap (struct super_block * sb)
 {
-	struct buffer_head * bh;
-	struct ext3_super_block * es;
+	struct ext3_super_block *es;
 	unsigned long desc_count, bitmap_count, x, j;
 	unsigned long desc_blocks;
-	int bitmap_nr;
-	struct ext3_group_desc * gdp;
+	struct buffer_head *bitmap_bh = NULL;
+	struct ext3_group_desc *gdp;
 	int i;
 
 	es = sb->u.ext3_sb.s_es;
@@ -945,43 +747,43 @@ void ext3_check_blocks_bitmap (struct su
 		if (!gdp)
 			continue;
 		desc_count += le16_to_cpu(gdp->bg_free_blocks_count);
-		bitmap_nr = load_block_bitmap (sb, i);
-		if (bitmap_nr < 0)
+		brelse(bitmap_bh);
+		bitmap_bh = read_block_bitmap(sb, i);
+		if (bitmap_bh == NULL)
 			continue;
 
-		bh = EXT3_SB(sb)->s_block_bitmap[bitmap_nr];
-
-		if (ext3_bg_has_super(sb, i) && !ext3_test_bit(0, bh->b_data))
+		if (ext3_bg_has_super(sb, i) &&
+				!ext3_test_bit(0, bitmap_bh->b_data))
 			ext3_error(sb, __FUNCTION__,
 				   "Superblock in group %d is marked free", i);
 
 		desc_blocks = ext3_bg_num_gdb(sb, i);
 		for (j = 0; j < desc_blocks; j++)
-			if (!ext3_test_bit(j + 1, bh->b_data))
+			if (!ext3_test_bit(j + 1, bitmap_bh->b_data))
 				ext3_error(sb, __FUNCTION__,
 					   "Descriptor block #%ld in group "
 					   "%d is marked free", j, i);
 
 		if (!block_in_use (le32_to_cpu(gdp->bg_block_bitmap),
-						sb, bh->b_data))
+						sb, bitmap_bh->b_data))
 			ext3_error (sb, "ext3_check_blocks_bitmap",
 				    "Block bitmap for group %d is marked free",
 				    i);
 
 		if (!block_in_use (le32_to_cpu(gdp->bg_inode_bitmap),
-						sb, bh->b_data))
+						sb, bitmap_bh->b_data))
 			ext3_error (sb, "ext3_check_blocks_bitmap",
 				    "Inode bitmap for group %d is marked free",
 				    i);
 
 		for (j = 0; j < sb->u.ext3_sb.s_itb_per_group; j++)
 			if (!block_in_use (le32_to_cpu(gdp->bg_inode_table) + j,
-							sb, bh->b_data))
+							sb, bitmap_bh->b_data))
 				ext3_error (sb, "ext3_check_blocks_bitmap",
 					    "Block #%d of the inode table in "
 					    "group %d is marked free", j, i);
 
-		x = ext3_count_free (bh, sb->s_blocksize);
+		x = ext3_count_free(bitmap_bh, sb->s_blocksize);
 		if (le16_to_cpu(gdp->bg_free_blocks_count) != x)
 			ext3_error (sb, "ext3_check_blocks_bitmap",
 				    "Wrong free blocks count for group %d, "
@@ -989,6 +791,7 @@ void ext3_check_blocks_bitmap (struct su
 				    le16_to_cpu(gdp->bg_free_blocks_count), x);
 		bitmap_count += x;
 	}
+	brelse(bitmap_bh);
 	if (le32_to_cpu(es->s_free_blocks_count) != bitmap_count)
 		ext3_error (sb, "ext3_check_blocks_bitmap",
 			"Wrong free blocks count in super block, "
--- 2.5.24/include/linux/ext3_fs_sb.h~ext3-lrus	Thu Jul  4 16:17:11 2002
+++ 2.5.24-akpm/include/linux/ext3_fs_sb.h	Thu Jul  4 16:17:11 2002
@@ -22,14 +22,6 @@
 #endif
 
 /*
- * The following is not needed anymore since the descriptors buffer
- * heads are now dynamically allocated
- */
-/* #define EXT3_MAX_GROUP_DESC	8 */
-
-#define EXT3_MAX_GROUP_LOADED	8
-
-/*
  * third extended-fs super-block data in memory
  */
 struct ext3_sb_info {
@@ -46,12 +38,6 @@ struct ext3_sb_info {
 	struct buffer_head * s_sbh;	/* Buffer containing the super block */
 	struct ext3_super_block * s_es;	/* Pointer to the super block in the buffer */
 	struct buffer_head ** s_group_desc;
-	unsigned short s_loaded_inode_bitmaps;
-	unsigned short s_loaded_block_bitmaps;
-	unsigned long s_inode_bitmap_number[EXT3_MAX_GROUP_LOADED];
-	struct buffer_head * s_inode_bitmap[EXT3_MAX_GROUP_LOADED];
-	unsigned long s_block_bitmap_number[EXT3_MAX_GROUP_LOADED];
-	struct buffer_head * s_block_bitmap[EXT3_MAX_GROUP_LOADED];
 	unsigned long  s_mount_opt;
 	uid_t s_resuid;
 	gid_t s_resgid;
--- 2.5.24/fs/ext3/super.c~ext3-lrus	Thu Jul  4 16:17:11 2002
+++ 2.5.24-akpm/fs/ext3/super.c	Thu Jul  4 16:17:11 2002
@@ -417,10 +417,6 @@ void ext3_put_super (struct super_block 
 	for (i = 0; i < sbi->s_gdb_count; i++)
 		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
-	for (i = 0; i < EXT3_MAX_GROUP_LOADED; i++)
-		brelse(sbi->s_inode_bitmap[i]);
-	for (i = 0; i < EXT3_MAX_GROUP_LOADED; i++)
-		brelse(sbi->s_block_bitmap[i]);
 	brelse(sbi->s_sbh);
 
 	/* Debugging code just in case the in-memory inode orphan list
@@ -1150,14 +1146,6 @@ static int ext3_fill_super (struct super
 		printk (KERN_ERR "EXT3-fs: group descriptors corrupted !\n");
 		goto failed_mount2;
 	}
-	for (i = 0; i < EXT3_MAX_GROUP_LOADED; i++) {
-		sbi->s_inode_bitmap_number[i] = 0;
-		sbi->s_inode_bitmap[i] = NULL;
-		sbi->s_block_bitmap_number[i] = 0;
-		sbi->s_block_bitmap[i] = NULL;
-	}
-	sbi->s_loaded_inode_bitmaps = 0;
-	sbi->s_loaded_block_bitmaps = 0;
 	sbi->s_gdb_count = db_count;
 	/*
 	 * set up enough so that it can read an inode
--- 2.5.24/fs/ext3/ialloc.c~ext3-lrus	Thu Jul  4 16:17:11 2002
+++ 2.5.24-akpm/fs/ext3/ialloc.c	Thu Jul  4 16:17:11 2002
@@ -36,8 +36,7 @@
  *
  * The file system contains group descriptors which are located after the
  * super block.  Each descriptor contains the number of the bitmap block and
- * the free blocks count in the block.  The descriptors are loaded in memory
- * when a file system is mounted (see ext3_read_super).
+ * the free blocks count in the block.
  */
 
 
@@ -45,118 +44,26 @@
  * Read the inode allocation bitmap for a given block_group, reading
  * into the specified slot in the superblock's bitmap cache.
  *
- * Return >=0 on success or a -ve error code.
+ * Return buffer_head of bitmap on success or NULL.
  */
-static int read_inode_bitmap (struct super_block * sb,
-			       unsigned long block_group,
-			       unsigned int bitmap_nr)
+static struct buffer_head *
+read_inode_bitmap(struct super_block * sb, unsigned long block_group)
 {
-	struct ext3_group_desc * gdp;
-	struct buffer_head * bh = NULL;
-	int retval = 0;
+	struct ext3_group_desc *desc;
+	struct buffer_head *bh = NULL;
 
-	gdp = ext3_get_group_desc (sb, block_group, NULL);
-	if (!gdp) {
-		retval = -EIO;
+	desc = ext3_get_group_desc(sb, block_group, NULL);
+	if (!desc)
 		goto error_out;
-	}
-	bh = sb_bread(sb, le32_to_cpu(gdp->bg_inode_bitmap));
-	if (!bh) {
-		ext3_error (sb, "read_inode_bitmap",
+
+	bh = sb_bread(sb, le32_to_cpu(desc->bg_inode_bitmap));
+	if (!bh)
+		ext3_error(sb, "read_inode_bitmap",
 			    "Cannot read inode bitmap - "
 			    "block_group = %lu, inode_bitmap = %lu",
-			    block_group, (unsigned long) gdp->bg_inode_bitmap);
-		retval = -EIO;
-	}
-	/*
-	 * On IO error, just leave a zero in the superblock's block pointer for
-	 * this group.  The IO will be retried next time.
-	 */
+			    block_group, (unsigned long) desc->bg_inode_bitmap);
 error_out:
-	sb->u.ext3_sb.s_inode_bitmap_number[bitmap_nr] = block_group;
-	sb->u.ext3_sb.s_inode_bitmap[bitmap_nr] = bh;
-	return retval;
-}
-
-/*
- * load_inode_bitmap loads the inode bitmap for a blocks group
- *
- * It maintains a cache for the last bitmaps loaded.  This cache is managed
- * with a LRU algorithm.
- *
- * Notes:
- * 1/ There is one cache per mounted file system.
- * 2/ If the file system contains less than EXT3_MAX_GROUP_LOADED groups,
- *    this function reads the bitmap without maintaining a LRU cache.
- *
- * Return the slot used to store the bitmap, or a -ve error code.
- */
-static int load_inode_bitmap (struct super_block * sb,
-			      unsigned int block_group)
-{
-	struct ext3_sb_info *sbi = EXT3_SB(sb);
-	unsigned long inode_bitmap_number;
-	struct buffer_head * inode_bitmap;
-	int i, j, retval = 0;
-
-	if (block_group >= sbi->s_groups_count)
-		ext3_panic (sb, "load_inode_bitmap",
-			    "block_group >= groups_count - "
-			    "block_group = %d, groups_count = %lu",
-			    block_group, sbi->s_groups_count);
-	if (sbi->s_loaded_inode_bitmaps > 0 &&
-	    sbi->s_inode_bitmap_number[0] == block_group &&
-	    sbi->s_inode_bitmap[0] != NULL)
-		return 0;
-	if (sbi->s_groups_count <= EXT3_MAX_GROUP_LOADED) {
-		if (sbi->s_inode_bitmap[block_group]) {
-			if (sbi->s_inode_bitmap_number[block_group] !=
-						block_group)
-				ext3_panic(sb, "load_inode_bitmap",
-					"block_group != inode_bitmap_number");
-			return block_group;
-		}
-		retval = read_inode_bitmap(sb, block_group, block_group);
-		if (retval < 0)
-			return retval;
-		return block_group;
-	}
-
-	for (i = 0; i < sbi->s_loaded_inode_bitmaps &&
-		    sbi->s_inode_bitmap_number[i] != block_group; i++)
-		/* do nothing */;
-	if (i < sbi->s_loaded_inode_bitmaps &&
-	    sbi->s_inode_bitmap_number[i] == block_group) {
-		inode_bitmap_number = sbi->s_inode_bitmap_number[i];
-		inode_bitmap = sbi->s_inode_bitmap[i];
-		for (j = i; j > 0; j--) {
-			sbi->s_inode_bitmap_number[j] =
-				sbi->s_inode_bitmap_number[j - 1];
-			sbi->s_inode_bitmap[j] = sbi->s_inode_bitmap[j - 1];
-		}
-		sbi->s_inode_bitmap_number[0] = inode_bitmap_number;
-		sbi->s_inode_bitmap[0] = inode_bitmap;
-
-		/*
-		 * There's still one special case here --- if inode_bitmap == 0
-		 * then our last attempt to read the bitmap failed and we have
-		 * just ended up caching that failure.  Try again to read it.
-		 */
-		if (!inode_bitmap)
-			retval = read_inode_bitmap (sb, block_group, 0);
-	} else {
-		if (sbi->s_loaded_inode_bitmaps < EXT3_MAX_GROUP_LOADED)
-			sbi->s_loaded_inode_bitmaps++;
-		else
-			brelse(sbi->s_inode_bitmap[EXT3_MAX_GROUP_LOADED - 1]);
-		for (j = sbi->s_loaded_inode_bitmaps - 1; j > 0; j--) {
-			sbi->s_inode_bitmap_number[j] =
-				sbi->s_inode_bitmap_number[j - 1];
-			sbi->s_inode_bitmap[j] = sbi->s_inode_bitmap[j - 1];
-		}
-		retval = read_inode_bitmap (sb, block_group, 0);
-	}
-	return retval;
+	return bh;
 }
 
 /*
@@ -180,11 +87,10 @@ void ext3_free_inode (handle_t *handle, 
 	struct super_block * sb = inode->i_sb;
 	int is_directory;
 	unsigned long ino;
-	struct buffer_head * bh;
-	struct buffer_head * bh2;
+	struct buffer_head *bitmap_bh = NULL;
+	struct buffer_head *bh2;
 	unsigned long block_group;
 	unsigned long bit;
-	int bitmap_nr;
 	struct ext3_group_desc * gdp;
 	struct ext3_super_block * es;
 	int fatal = 0, err;
@@ -229,19 +135,17 @@ void ext3_free_inode (handle_t *handle, 
 	}
 	block_group = (ino - 1) / EXT3_INODES_PER_GROUP(sb);
 	bit = (ino - 1) % EXT3_INODES_PER_GROUP(sb);
-	bitmap_nr = load_inode_bitmap (sb, block_group);
-	if (bitmap_nr < 0)
+	bitmap_bh = read_inode_bitmap(sb, block_group);
+	if (!bitmap_bh)
 		goto error_return;
 
-	bh = sb->u.ext3_sb.s_inode_bitmap[bitmap_nr];
-
-	BUFFER_TRACE(bh, "get_write_access");
-	fatal = ext3_journal_get_write_access(handle, bh);
+	BUFFER_TRACE(bitmap_bh, "get_write_access");
+	fatal = ext3_journal_get_write_access(handle, bitmap_bh);
 	if (fatal)
 		goto error_return;
 
 	/* Ok, now we can actually update the inode bitmaps.. */
-	if (!ext3_clear_bit (bit, bh->b_data))
+	if (!ext3_clear_bit(bit, bitmap_bh->b_data))
 		ext3_error (sb, "ext3_free_inode",
 			      "bit already cleared for inode %lu", ino);
 	else {
@@ -272,12 +176,13 @@ void ext3_free_inode (handle_t *handle, 
 		err = ext3_journal_dirty_metadata(handle, sb->u.ext3_sb.s_sbh);
 		if (!fatal) fatal = err;
 	}
-	BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
-	err = ext3_journal_dirty_metadata(handle, bh);
+	BUFFER_TRACE(bitmap_bh, "call ext3_journal_dirty_metadata");
+	err = ext3_journal_dirty_metadata(handle, bitmap_bh);
 	if (!fatal)
 		fatal = err;
 	sb->s_dirt = 1;
 error_return:
+	brelse(bitmap_bh);
 	ext3_std_error(sb, fatal);
 	unlock_super(sb);
 }
@@ -292,20 +197,19 @@ error_return:
  * For other inodes, search forward from the parent directory's block
  * group to find a free inode.
  */
-struct inode * ext3_new_inode (handle_t *handle,
-				struct inode * dir, int mode)
+struct inode *ext3_new_inode(handle_t *handle, struct inode * dir, int mode)
 {
-	struct super_block * sb;
-	struct buffer_head * bh;
-	struct buffer_head * bh2;
+	struct super_block *sb;
+	struct buffer_head *bitmap_bh = NULL;
+	struct buffer_head *bh2;
 	int i, j, avefreei;
 	struct inode * inode;
-	int bitmap_nr;
 	struct ext3_group_desc * gdp;
 	struct ext3_group_desc * tmp;
 	struct ext3_super_block * es;
 	struct ext3_inode_info *ei;
 	int err = 0;
+	struct inode *ret;
 
 	/* Cannot create files in a deleted directory */
 	if (!dir || !dir->i_nlink)
@@ -392,26 +296,25 @@ repeat:
 		goto out;
 
 	err = -EIO;
-	bitmap_nr = load_inode_bitmap (sb, i);
-	if (bitmap_nr < 0)
+	brelse(bitmap_bh);
+	bitmap_bh = read_inode_bitmap(sb, i);
+	if (!bitmap_bh)
 		goto fail;
 
-	bh = sb->u.ext3_sb.s_inode_bitmap[bitmap_nr];
-
-	if ((j = ext3_find_first_zero_bit ((unsigned long *) bh->b_data,
+	if ((j = ext3_find_first_zero_bit((unsigned long *)bitmap_bh->b_data,
 				      EXT3_INODES_PER_GROUP(sb))) <
 	    EXT3_INODES_PER_GROUP(sb)) {
-		BUFFER_TRACE(bh, "get_write_access");
-		err = ext3_journal_get_write_access(handle, bh);
+		BUFFER_TRACE(bitmap_bh, "get_write_access");
+		err = ext3_journal_get_write_access(handle, bitmap_bh);
 		if (err) goto fail;
 		
-		if (ext3_set_bit (j, bh->b_data)) {
+		if (ext3_set_bit(j, bitmap_bh->b_data)) {
 			ext3_error (sb, "ext3_new_inode",
 				      "bit already set for inode %d", j);
 			goto repeat;
 		}
-		BUFFER_TRACE(bh, "call ext3_journal_dirty_metadata");
-		err = ext3_journal_dirty_metadata(handle, bh);
+		BUFFER_TRACE(bitmap_bh, "call ext3_journal_dirty_metadata");
+		err = ext3_journal_dirty_metadata(handle, bitmap_bh);
 		if (err) goto fail;
 	} else {
 		if (le16_to_cpu(gdp->bg_free_inodes_count) != 0) {
@@ -520,23 +423,27 @@ repeat:
 	err = ext3_mark_inode_dirty(handle, inode);
 	if (err) goto fail;
 	
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
+		ext3_debug("allocating inode %lu\n", inode->i_ino);
 	}
-	ext3_debug ("allocating inode %lu\n", inode->i_ino);
-	return inode;
-
+	goto really_out;
 fail:
 	ext3_std_error(sb, err);
 out:
 	unlock_super(sb);
 	iput(inode);
-	return ERR_PTR(err);
+	ret = ERR_PTR(err);
+really_out:
+	brelse(bitmap_bh);
+	return ret;
 }
 
 /* Verify that we are loading a valid orphan from disk */
@@ -545,36 +452,37 @@ struct inode *ext3_orphan_get (struct su
 	ino_t max_ino = le32_to_cpu(EXT3_SB(sb)->s_es->s_inodes_count);
 	unsigned long block_group;
 	int bit;
-	int bitmap_nr;
-	struct buffer_head *bh;
+	struct buffer_head *bitmap_bh = NULL;
 	struct inode *inode = NULL;
 	
 	/* Error cases - e2fsck has already cleaned up for us */
 	if (ino > max_ino) {
 		ext3_warning(sb, __FUNCTION__,
 			     "bad orphan ino %ld!  e2fsck was run?\n", ino);
-		return NULL;
+		goto out;
 	}
 
 	block_group = (ino - 1) / EXT3_INODES_PER_GROUP(sb);
 	bit = (ino - 1) % EXT3_INODES_PER_GROUP(sb);
-	if ((bitmap_nr = load_inode_bitmap(sb, block_group)) < 0 ||
-	    !(bh = EXT3_SB(sb)->s_inode_bitmap[bitmap_nr])) {
+	bitmap_bh = read_inode_bitmap(sb, block_group);
+	if (!bitmap_bh) {
 		ext3_warning(sb, __FUNCTION__,
 			     "inode bitmap error for orphan %ld\n", ino);
-		return NULL;
+		goto out;
 	}
 
 	/* Having the inode bit set should be a 100% indicator that this
 	 * is a valid orphan (no e2fsck run on fs).  Orphans also include
 	 * inodes that were being truncated, so we can't check i_nlink==0.
 	 */
-	if (!ext3_test_bit(bit, bh->b_data) || !(inode = iget(sb, ino)) ||
-	    is_bad_inode(inode) || NEXT_ORPHAN(inode) > max_ino) {
+	if (!ext3_test_bit(bit, bitmap_bh->b_data) ||
+			!(inode = iget(sb, ino)) || is_bad_inode(inode) ||
+			NEXT_ORPHAN(inode) > max_ino) {
 		ext3_warning(sb, __FUNCTION__,
 			     "bad orphan inode %ld!  e2fsck was run?\n", ino);
 		printk(KERN_NOTICE "ext3_test_bit(bit=%d, block=%ld) = %d\n",
-		       bit, bh->b_blocknr, ext3_test_bit(bit, bh->b_data));
+			bit, bitmap_bh->b_blocknr,
+			ext3_test_bit(bit, bitmap_bh->b_data));
 		printk(KERN_NOTICE "inode=%p\n", inode);
 		if (inode) {
 			printk(KERN_NOTICE "is_bad_inode(inode)=%d\n",
@@ -587,19 +495,20 @@ struct inode *ext3_orphan_get (struct su
 		if (inode && inode->i_nlink == 0)
 			inode->i_blocks = 0;
 		iput(inode);
-		return NULL;
+		inode = NULL;
 	}
-
+out:
+	brelse(bitmap_bh);
 	return inode;
 }
 
 unsigned long ext3_count_free_inodes (struct super_block * sb)
 {
 #ifdef EXT3FS_DEBUG
-	struct ext3_super_block * es;
+	struct ext3_super_block *es;
 	unsigned long desc_count, bitmap_count, x;
-	int bitmap_nr;
-	struct ext3_group_desc * gdp;
+	struct ext3_group_desc *gdp;
+	struct buffer_head *bitmap_bh = NULL;
 	int i;
 
 	lock_super (sb);
@@ -612,19 +521,20 @@ unsigned long ext3_count_free_inodes (st
 		if (!gdp)
 			continue;
 		desc_count += le16_to_cpu(gdp->bg_free_inodes_count);
-		bitmap_nr = load_inode_bitmap (sb, i);
-		if (bitmap_nr < 0)
+		brelse(bitmap_bh);
+		bitmap_bh = read_inode_bitmap(sb, i);
+		if (!bitmap_bh)
 			continue;
 
-		x = ext3_count_free (sb->u.ext3_sb.s_inode_bitmap[bitmap_nr],
-				     EXT3_INODES_PER_GROUP(sb) / 8);
-		printk ("group %d: stored = %d, counted = %lu\n",
+		x = ext3_count_free(bitmap_bh, EXT3_INODES_PER_GROUP(sb) / 8);
+		printk("group %d: stored = %d, counted = %lu\n",
 			i, le16_to_cpu(gdp->bg_free_inodes_count), x);
 		bitmap_count += x;
 	}
+	brelse(bitmap_bh);
 	printk("ext3_count_free_inodes: stored = %lu, computed = %lu, %lu\n",
 		le32_to_cpu(es->s_free_inodes_count), desc_count, bitmap_count);
-	unlock_super (sb);
+	unlock_super(sb);
 	return desc_count;
 #else
 	return le32_to_cpu(sb->u.ext3_sb.s_es->s_free_inodes_count);
@@ -637,7 +547,7 @@ void ext3_check_inodes_bitmap (struct su
 {
 	struct ext3_super_block * es;
 	unsigned long desc_count, bitmap_count, x;
-	int bitmap_nr;
+	struct buffer_head *bitmap_bh = NULL;
 	struct ext3_group_desc * gdp;
 	int i;
 
@@ -650,12 +560,12 @@ void ext3_check_inodes_bitmap (struct su
 		if (!gdp)
 			continue;
 		desc_count += le16_to_cpu(gdp->bg_free_inodes_count);
-		bitmap_nr = load_inode_bitmap (sb, i);
-		if (bitmap_nr < 0)
+		brelse(bitmap_bh);
+		bitmap_bh = read_inode_bitmap(sb, i);
+		if (!bitmap_bh)
 			continue;
 
-		x = ext3_count_free (sb->u.ext3_sb.s_inode_bitmap[bitmap_nr],
-				     EXT3_INODES_PER_GROUP(sb) / 8);
+		x = ext3_count_free(bitmap_bh, EXT3_INODES_PER_GROUP(sb) / 8);
 		if (le16_to_cpu(gdp->bg_free_inodes_count) != x)
 			ext3_error (sb, "ext3_check_inodes_bitmap",
 				    "Wrong free inodes count in group %d, "
@@ -663,6 +573,7 @@ void ext3_check_inodes_bitmap (struct su
 				    le16_to_cpu(gdp->bg_free_inodes_count), x);
 		bitmap_count += x;
 	}
+	brelse(bitmap_bh);
 	if (le32_to_cpu(es->s_free_inodes_count) != bitmap_count)
 		ext3_error (sb, "ext3_check_inodes_bitmap",
 			    "Wrong free inodes count in super block, "

-
