Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264267AbTCXQqA>; Mon, 24 Mar 2003 11:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264333AbTCXQpU>; Mon, 24 Mar 2003 11:45:20 -0500
Received: from comtv.ru ([217.10.32.4]:24462 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S264267AbTCXQny>;
	Mon, 24 Mar 2003 11:43:54 -0500
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: [PATCH] concurrent block/inode allocation for EXT3
References: <20030323040439.7a432edb.akpm@digeo.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 24 Mar 2003 19:45:25 +0300
In-Reply-To: <20030323040439.7a432edb.akpm@digeo.com>
Message-ID: <m3llz490ii.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

this time, concurrent block/inode allocation for EXT3 against 2.5.65.
should be applied with ext2-concurrent-balloc because of ext2_set_bit_atomic()
and ext2_clear_bit_atomic().

to see real improvement, you should use 2.5.65-mm4 in which Andrew Morton pushed
BKL'es down into JBD.


1) each group has own spinlock, which is used for group counter
   modifications
2) sb->s_free_blocks_count isn't used any more.  ext2_statfs() and
   find_group_orlov() loop over groups to count free blocks
3) sb->s_free_blocks_count is recalculated at mount/umount/sync_super time
   in order to check consistency and to avoid fsck warnings
4) reserved blocks are distributed over last groups
5) ext3_new_block() tries to use non-reserved blocks and if it fails then
   tries to use reserved blocks
6) ext3_new_block() and ext3_free_blocks do not modify sb->s_free_blocks,
   therefore they do not call mark_buffer_dirty() for superblock's
   buffer_head. this should reduce I/O a bit



diff -puNr linux-2.5.65/fs/ext3/balloc.c edited/fs/ext3/balloc.c
--- linux-2.5.65/fs/ext3/balloc.c	Thu Feb 20 16:19:06 2003
+++ edited/fs/ext3/balloc.c	Mon Mar 24 16:17:40 2003
@@ -118,7 +118,6 @@ void ext3_free_blocks (handle_t *handle,
 		printk ("ext3_free_blocks: nonexistent device");
 		return;
 	}
-	lock_super (sb);
 	es = EXT3_SB(sb)->s_es;
 	if (block < le32_to_cpu(es->s_first_data_block) ||
 	    block + count < block ||
@@ -184,11 +183,6 @@ do_more:
 	if (err)
 		goto error_return;
 
-	BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "get_write_access");
-	err = ext3_journal_get_write_access(handle, EXT3_SB(sb)->s_sbh);
-	if (err)
-		goto error_return;
-
 	for (i = 0; i < count; i++) {
 		/*
 		 * An HJ special.  This is expensive...
@@ -208,18 +202,15 @@ do_more:
 		}
 #endif
 		BUFFER_TRACE(bitmap_bh, "clear bit");
-		if (!ext3_clear_bit (bit + i, bitmap_bh->b_data)) {
+		if (!ext3_clear_bit_atomic (&EXT3_SB(sb)->s_bgi[block_group].bg_balloc_lock,
+						bit + i, bitmap_bh->b_data)) {
 			ext3_error (sb, __FUNCTION__,
 				      "bit already cleared for block %lu", 
 				      block + i);
 			BUFFER_TRACE(bitmap_bh, "bit already cleared");
-		} else {
+		} else 
 			dquot_freed_blocks++;
-			gdp->bg_free_blocks_count =
-			  cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count)+1);
-			es->s_free_blocks_count =
-			  cpu_to_le32(le32_to_cpu(es->s_free_blocks_count)+1);
-		}
+
 		/* @@@ This prevents newly-allocated data from being
 		 * freed and then reallocated within the same
 		 * transaction. 
@@ -244,6 +235,11 @@ do_more:
 		ext3_set_bit(bit + i, bh2jh(bitmap_bh)->b_committed_data);
 	}
 
+	spin_lock(&EXT3_SB(sb)->s_bgi[block_group].bg_balloc_lock);
+	gdp->bg_free_blocks_count =
+		cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) + dquot_freed_blocks);
+	spin_unlock(&EXT3_SB(sb)->s_bgi[block_group].bg_balloc_lock);
+
 	/* We dirtied the bitmap block */
 	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
 	err = ext3_journal_dirty_metadata(handle, bitmap_bh);
@@ -253,11 +249,6 @@ do_more:
 	ret = ext3_journal_dirty_metadata(handle, gd_bh);
 	if (!err) err = ret;
 
-	/* And the superblock */
-	BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "dirtied superblock");
-	ret = ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
-	if (!err) err = ret;
-
 	if (overflow && !err) {
 		block += count;
 		count = overflow;
@@ -267,7 +258,6 @@ do_more:
 error_return:
 	brelse(bitmap_bh);
 	ext3_std_error(sb, err);
-	unlock_super(sb);
 	if (dquot_freed_blocks)
 		DQUOT_FREE_BLOCK(inode, dquot_freed_blocks);
 	return;
@@ -367,6 +357,61 @@ static int find_next_usable_block(int st
 	return -1;
 }
 
+
+int
+ext3_try_to_allocate(struct super_block *sb, handle_t *handle, int group,
+				struct buffer_head *bitmap_bh, int goal,
+				int *errp)
+{
+	int i, fatal = 0;
+
+	*errp = 0;
+
+	if (goal >= 0 && ext3_test_allocatable(goal, bitmap_bh))
+		goto got;
+
+repeat:
+	goal = find_next_usable_block(goal, bitmap_bh,
+				EXT3_BLOCKS_PER_GROUP(sb));
+	if (goal < 0) 
+		return -1;
+
+	for (i = 0;
+		i < 7 && goal > 0 && ext3_test_allocatable(goal - 1, bitmap_bh);
+		i++, goal--);
+
+got:
+	/* Make sure we use undo access for the bitmap, because it is
+	 * critical that we do the frozen_data COW on bitmap buffers in
+	 * all cases even if the buffer is in BJ_Forget state in the
+	 * committing transaction.  */
+	BUFFER_TRACE(bitmap_bh, "get undo access for marking new block");
+	fatal = ext3_journal_get_undo_access(handle, bitmap_bh);
+	if (fatal) {
+		*errp = fatal;
+		return -1;
+	}
+
+	if (ext3_set_bit_atomic(&EXT3_SB(sb)->s_bgi[group].bg_balloc_lock,
+				goal, bitmap_bh->b_data)) {
+		/* already allocated by concurrent thread -bzzz */
+		goal++;
+		if (goal >= EXT3_BLOCKS_PER_GROUP(sb))
+			return -1;
+		goto repeat;
+	}
+
+	BUFFER_TRACE(bitmap_bh, "journal_dirty_metadata for bitmap block");
+	fatal = ext3_journal_dirty_metadata(handle, bitmap_bh);
+	if (fatal) {
+		*errp = fatal;
+		return -1;
+	}
+
+	return goal;
+}
+
+
 /*
  * ext3_new_block uses a goal block to assist allocation.  If the goal is
  * free, or there is a free block within 32 blocks of the goal, that block
@@ -387,6 +432,7 @@ ext3_new_block(handle_t *handle, struct 
 	int target_block;			/* tmp */
 	int fatal = 0, err;
 	int performed_allocation = 0;
+	int free, use_reserve = 0;
 	struct super_block *sb;
 	struct ext3_group_desc *gdp;
 	struct ext3_super_block *es;
@@ -408,16 +454,7 @@ ext3_new_block(handle_t *handle, struct 
 		return 0;
 	}
 
-	lock_super(sb);
 	es = EXT3_SB(sb)->s_es;
-	if (le32_to_cpu(es->s_free_blocks_count) <=
-			le32_to_cpu(es->s_r_blocks_count) &&
-	    ((EXT3_SB(sb)->s_resuid != current->fsuid) &&
-	     (EXT3_SB(sb)->s_resgid == 0 ||
-	      !in_group_p(EXT3_SB(sb)->s_resgid)) && 
-	     !capable(CAP_SYS_RESOURCE)))
-		goto out;
-
 	ext3_debug("goal=%lu.\n", goal);
 
 	/*
@@ -431,40 +468,28 @@ ext3_new_block(handle_t *handle, struct 
 	gdp = ext3_get_group_desc(sb, group_no, &gdp_bh);
 	if (!gdp)
 		goto io_error;
-
-	if (le16_to_cpu(gdp->bg_free_blocks_count) > 0) {
+
+	free = le16_to_cpu(gdp->bg_free_blocks_count);
+	free -= EXT3_SB(sb)->s_bgi[group_no].bg_reserved;
+	if (free > 0) {
 		ret_block = ((goal - le32_to_cpu(es->s_first_data_block)) %
 				EXT3_BLOCKS_PER_GROUP(sb));
-#ifdef EXT3FS_DEBUG
-		if (ret_block)
-			goal_attempts++;
-#endif
 		bitmap_bh = read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
-			goto io_error;
-
-		ext3_debug("goal is at %d:%d.\n", group_no, ret_block);
-
-		if (ext3_test_allocatable(ret_block, bitmap_bh)) {
-#ifdef EXT3FS_DEBUG
-			goal_hits++;
-			ext3_debug("goal bit allocated.\n");
-#endif
-			goto got_block;
-		}
-
-		ret_block = find_next_usable_block(ret_block, bitmap_bh,
-				EXT3_BLOCKS_PER_GROUP(sb));
+			goto io_error;	
+		ret_block = ext3_try_to_allocate(sb, handle, group_no, bitmap_bh,
+						ret_block, &fatal);
+		if (fatal)
+			goto out;
 		if (ret_block >= 0)
-			goto search_back;
+			goto allocated;
 	}
-
-	ext3_debug("Bit not found in block group %d.\n", group_no);
-
+	
 	/*
 	 * Now search the rest of the groups.  We assume that 
 	 * i and gdp correctly point to the last group visited.
 	 */
+repeat:
 	for (bit = 0; bit < EXT3_SB(sb)->s_groups_count; bit++) {
 		group_no++;
 		if (group_no >= EXT3_SB(sb)->s_groups_count)
@@ -474,57 +499,47 @@ ext3_new_block(handle_t *handle, struct 
 			*errp = -EIO;
 			goto out;
 		}
-		if (le16_to_cpu(gdp->bg_free_blocks_count) > 0) {
-			brelse(bitmap_bh);
-			bitmap_bh = read_block_bitmap(sb, group_no);
-			if (!bitmap_bh)
-				goto io_error;
-			ret_block = find_next_usable_block(-1, bitmap_bh, 
-						   EXT3_BLOCKS_PER_GROUP(sb));
-			if (ret_block >= 0) 
-				goto search_back;
-		}
-	}
+		free = le16_to_cpu(gdp->bg_free_blocks_count);
+		if (!use_reserve) 
+			free -= EXT3_SB(sb)->s_bgi[group_no].bg_reserved;
+		if (free <= 0)
+			continue;
 
+		brelse(bitmap_bh);
+		bitmap_bh = read_block_bitmap(sb, group_no);
+		if (!bitmap_bh)
+			goto io_error;
+		ret_block = ext3_try_to_allocate(sb, handle, group_no,
+						bitmap_bh, -1, &fatal);
+		if (fatal)
+			goto out;
+		if (ret_block >= 0) 
+			goto allocated;
+	}
+
+	if (!use_reserve &&
+		(EXT3_SB(sb)->s_resuid == current->fsuid ||
+		  (EXT3_SB(sb)->s_resgid != 0 && in_group_p(EXT3_SB(sb)->s_resgid)) ||
+		  capable(CAP_SYS_RESOURCE))) {
+		use_reserve = 1;
+		group_no = 0;
+		goto repeat;
+	}
+
 	/* No space left on the device */
+	*errp = -ENOSPC;
 	goto out;
 
-search_back:
-	/* 
-	 * We have succeeded in finding a free byte in the block
-	 * bitmap.  Now search backwards up to 7 bits to find the
-	 * start of this group of free blocks.
-	 */
-	for (	bit = 0;
-		bit < 7 && ret_block > 0 &&
-			ext3_test_allocatable(ret_block - 1, bitmap_bh);
-		bit++, ret_block--)
-		;
-	
-got_block:
+allocated:
 
 	ext3_debug("using block group %d(%d)\n",
 			group_no, gdp->bg_free_blocks_count);
 
-	/* Make sure we use undo access for the bitmap, because it is
-           critical that we do the frozen_data COW on bitmap buffers in
-           all cases even if the buffer is in BJ_Forget state in the
-           committing transaction.  */
-	BUFFER_TRACE(bitmap_bh, "get undo access for marking new block");
-	fatal = ext3_journal_get_undo_access(handle, bitmap_bh);
-	if (fatal)
-		goto out;
-	
 	BUFFER_TRACE(gdp_bh, "get_write_access");
 	fatal = ext3_journal_get_write_access(handle, gdp_bh);
 	if (fatal)
 		goto out;
 
-	BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "get_write_access");
-	fatal = ext3_journal_get_write_access(handle, EXT3_SB(sb)->s_sbh);
-	if (fatal)
-		goto out;
-
 	target_block = ret_block + group_no * EXT3_BLOCKS_PER_GROUP(sb)
 				+ le32_to_cpu(es->s_first_data_block);
 
@@ -536,11 +551,6 @@ got_block:
 			    "Allocating block in system zone - "
 			    "block = %u", target_block);
 
-	/* The superblock lock should guard against anybody else beating
-	 * us to this point! */
-	J_ASSERT_BH(bitmap_bh, !ext3_test_bit(ret_block, bitmap_bh->b_data));
-	BUFFER_TRACE(bitmap_bh, "setting bitmap bit");
-	ext3_set_bit(ret_block, bitmap_bh->b_data);
 	performed_allocation = 1;
 
 #ifdef CONFIG_JBD_DEBUG
@@ -556,20 +566,11 @@ got_block:
 		}
 	}
 #endif
-	if (buffer_jbd(bitmap_bh) && bh2jh(bitmap_bh)->b_committed_data)
-		J_ASSERT_BH(bitmap_bh,
-			!ext3_test_bit(ret_block,
-					bh2jh(bitmap_bh)->b_committed_data));
 	ext3_debug("found bit %d\n", ret_block);
 
 	/* ret_block was blockgroup-relative.  Now it becomes fs-relative */
 	ret_block = target_block;
 
-	BUFFER_TRACE(bitmap_bh, "journal_dirty_metadata for bitmap block");
-	err = ext3_journal_dirty_metadata(handle, bitmap_bh);
-	if (!fatal)
-		fatal = err;
-	
 	if (ret_block >= le32_to_cpu(es->s_blocks_count)) {
 		ext3_error(sb, "ext3_new_block",
 			    "block(%d) >= blocks count(%d) - "
@@ -586,27 +587,20 @@ got_block:
 	ext3_debug("allocating block %d. Goal hits %d of %d.\n",
 			ret_block, goal_hits, goal_attempts);
 
+	spin_lock(&EXT3_SB(sb)->s_bgi[group_no].bg_balloc_lock);
 	gdp->bg_free_blocks_count =
 			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) - 1);
-	es->s_free_blocks_count =
-			cpu_to_le32(le32_to_cpu(es->s_free_blocks_count) - 1);
+	spin_unlock(&EXT3_SB(sb)->s_bgi[group_no].bg_balloc_lock);
 
 	BUFFER_TRACE(gdp_bh, "journal_dirty_metadata for group descriptor");
 	err = ext3_journal_dirty_metadata(handle, gdp_bh);
 	if (!fatal)
 		fatal = err;
 
-	BUFFER_TRACE(EXT3_SB(sb)->s_sbh,
-			"journal_dirty_metadata for superblock");
-	err = ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
-	if (!fatal)
-		fatal = err;
-
 	sb->s_dirt = 1;
 	if (fatal)
 		goto out;
 
-	unlock_super(sb);
 	*errp = 0;
 	brelse(bitmap_bh);
 	return ret_block;
@@ -618,7 +612,6 @@ out:
 		*errp = fatal;
 		ext3_std_error(sb, fatal);
 	}
-	unlock_super(sb);
 	/*
 	 * Undo the block allocation
 	 */
@@ -631,12 +624,13 @@ out:
 
 unsigned long ext3_count_free_blocks(struct super_block *sb)
 {
+	unsigned long desc_count;
+	struct ext3_group_desc *gdp;
+	int i;
 #ifdef EXT3FS_DEBUG
 	struct ext3_super_block *es;
-	unsigned long desc_count, bitmap_count, x;
+	unsigned long bitmap_count, x;
 	struct buffer_head *bitmap_bh = NULL;
-	struct ext3_group_desc *gdp;
-	int i;
 	
 	lock_super(sb);
 	es = EXT3_SB(sb)->s_es;
@@ -664,7 +658,15 @@ unsigned long ext3_count_free_blocks(str
 	unlock_super(sb);
 	return bitmap_count;
 #else
-	return le32_to_cpu(EXT3_SB(sb)->s_es->s_free_blocks_count);
+	desc_count = 0;
+	for (i = 0; i < EXT3_SB(sb)->s_groups_count; i++) {
+		gdp = ext3_get_group_desc(sb, i, NULL);
+		if (!gdp)
+			continue;
+		desc_count += le16_to_cpu(gdp->bg_free_blocks_count);
+	}
+
+	return desc_count;
 #endif
 }
 
diff -puNr linux-2.5.65/fs/ext3/ialloc.c edited/fs/ext3/ialloc.c
--- linux-2.5.65/fs/ext3/ialloc.c	Tue Mar 18 14:13:37 2003
+++ edited/fs/ext3/ialloc.c	Mon Mar 24 14:52:09 2003
@@ -131,7 +131,6 @@ void ext3_free_inode (handle_t *handle, 
 	/* Do this BEFORE marking the inode not in use or returning an error */
 	clear_inode (inode);
 
-	lock_super (sb);
 	es = EXT3_SB(sb)->s_es;
 	if (ino < EXT3_FIRST_INO(sb) || ino > le32_to_cpu(es->s_inodes_count)) {
 		ext3_error (sb, "ext3_free_inode",
@@ -150,7 +149,8 @@ void ext3_free_inode (handle_t *handle, 
 		goto error_return;
 
 	/* Ok, now we can actually update the inode bitmaps.. */
-	if (!ext3_clear_bit(bit, bitmap_bh->b_data))
+	if (!ext3_clear_bit_atomic(&EXT3_SB(sb)->s_bgi[block_group].bg_ialloc_lock,
+					bit, bitmap_bh->b_data))
 		ext3_error (sb, "ext3_free_inode",
 			      "bit already cleared for inode %lu", ino);
 	else {
@@ -160,28 +160,18 @@ void ext3_free_inode (handle_t *handle, 
 		fatal = ext3_journal_get_write_access(handle, bh2);
 		if (fatal) goto error_return;
 
-		BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "get write access");
-		fatal = ext3_journal_get_write_access(handle, EXT3_SB(sb)->s_sbh);
-		if (fatal) goto error_return;
-
 		if (gdp) {
+			spin_lock(&EXT3_SB(sb)->s_bgi[block_group].bg_ialloc_lock);
 			gdp->bg_free_inodes_count = cpu_to_le16(
 				le16_to_cpu(gdp->bg_free_inodes_count) + 1);
-			if (is_directory) {
+			if (is_directory)
 				gdp->bg_used_dirs_count = cpu_to_le16(
 				  le16_to_cpu(gdp->bg_used_dirs_count) - 1);
-				EXT3_SB(sb)->s_dir_count--;
-			}
+			spin_unlock(&EXT3_SB(sb)->s_bgi[block_group].bg_ialloc_lock);
 		}
 		BUFFER_TRACE(bh2, "call ext3_journal_dirty_metadata");
 		err = ext3_journal_dirty_metadata(handle, bh2);
 		if (!fatal) fatal = err;
-		es->s_free_inodes_count =
-			cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) + 1);
-		BUFFER_TRACE(EXT3_SB(sb)->s_sbh,
-					"call ext3_journal_dirty_metadata");
-		err = ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
-		if (!fatal) fatal = err;
 	}
 	BUFFER_TRACE(bitmap_bh, "call ext3_journal_dirty_metadata");
 	err = ext3_journal_dirty_metadata(handle, bitmap_bh);
@@ -191,7 +181,6 @@ void ext3_free_inode (handle_t *handle, 
 error_return:
 	brelse(bitmap_bh);
 	ext3_std_error(sb, fatal);
-	unlock_super(sb);
 }
 
 /*
@@ -206,9 +195,8 @@ error_return:
  */
 static int find_group_dir(struct super_block *sb, struct inode *parent)
 {
-	struct ext3_super_block * es = EXT3_SB(sb)->s_es;
 	int ngroups = EXT3_SB(sb)->s_groups_count;
-	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
+	int avefreei = ext3_count_free_inodes(sb) / ngroups;
 	struct ext3_group_desc *desc, *best_desc = NULL;
 	struct buffer_head *bh;
 	int group, best_group = -1;
@@ -264,10 +252,12 @@ static int find_group_orlov(struct super
 	struct ext3_super_block *es = sbi->s_es;
 	int ngroups = sbi->s_groups_count;
 	int inodes_per_group = EXT3_INODES_PER_GROUP(sb);
-	int avefreei = le32_to_cpu(es->s_free_inodes_count) / ngroups;
-	int avefreeb = le32_to_cpu(es->s_free_blocks_count) / ngroups;
+	int freei = ext3_count_free_inodes(sb);
+	int avefreei = freei / ngroups;
+	int freeb = ext3_count_free_blocks(sb);
+	int avefreeb = freeb / ngroups;
 	int blocks_per_dir;
-	int ndirs = sbi->s_dir_count;
+	int ndirs = ext3_count_dirs(sb);
 	int max_debt, max_dirs, min_blocks, min_inodes;
 	int group = -1, i;
 	struct ext3_group_desc *desc;
@@ -319,7 +309,7 @@ static int find_group_orlov(struct super
 		desc = ext3_get_group_desc (sb, group, &bh);
 		if (!desc || !desc->bg_free_inodes_count)
 			continue;
-		if (sbi->s_debts[group] >= max_debt)
+		if (sbi->s_bgi[group].bg_debts >= max_debt)
 			continue;
 		if (le16_to_cpu(desc->bg_used_dirs_count) >= max_dirs)
 			continue;
@@ -435,7 +425,6 @@ struct inode *ext3_new_inode(handle_t *h
 		return ERR_PTR(-ENOMEM);
 	ei = EXT3_I(inode);
 
-	lock_super (sb);
 	es = EXT3_SB(sb)->s_es;
 repeat:
 	if (S_ISDIR(mode)) {
@@ -464,11 +453,9 @@ repeat:
 		err = ext3_journal_get_write_access(handle, bitmap_bh);
 		if (err) goto fail;
 
-		if (ext3_set_bit(ino, bitmap_bh->b_data)) {
-			ext3_error (sb, "ext3_new_inode",
-				      "bit already set for inode %lu", ino);
+		if (ext3_set_bit_atomic(&EXT3_SB(sb)->s_bgi[group].bg_ialloc_lock,
+					ino, bitmap_bh->b_data)) 
 			goto repeat;
-		}
 		BUFFER_TRACE(bitmap_bh, "call ext3_journal_dirty_metadata");
 		err = ext3_journal_dirty_metadata(handle, bitmap_bh);
 		if (err) goto fail;
@@ -504,26 +491,19 @@ repeat:
 	BUFFER_TRACE(bh2, "get_write_access");
 	err = ext3_journal_get_write_access(handle, bh2);
 	if (err) goto fail;
+	spin_lock(&EXT3_SB(sb)->s_bgi[group].bg_ialloc_lock);
 	gdp->bg_free_inodes_count =
 		cpu_to_le16(le16_to_cpu(gdp->bg_free_inodes_count) - 1);
 	if (S_ISDIR(mode)) {
 		gdp->bg_used_dirs_count =
 			cpu_to_le16(le16_to_cpu(gdp->bg_used_dirs_count) + 1);
-		EXT3_SB(sb)->s_dir_count++;
 	}
+	spin_unlock(&EXT3_SB(sb)->s_bgi[group].bg_ialloc_lock);
 	BUFFER_TRACE(bh2, "call ext3_journal_dirty_metadata");
 	err = ext3_journal_dirty_metadata(handle, bh2);
 	if (err) goto fail;
 	
-	BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "get_write_access");
-	err = ext3_journal_get_write_access(handle, EXT3_SB(sb)->s_sbh);
-	if (err) goto fail;
-	es->s_free_inodes_count =
-		cpu_to_le32(le32_to_cpu(es->s_free_inodes_count) - 1);
-	BUFFER_TRACE(EXT3_SB(sb)->s_sbh, "call ext3_journal_dirty_metadata");
-	err = ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
-	if (err) goto fail;
 
 	inode->i_uid = current->fsuid;
 	if (test_opt (sb, GRPID))
@@ -576,7 +556,6 @@ repeat:
 
 	ei->i_state = EXT3_STATE_NEW;
 
-	unlock_super(sb);
 	ret = inode;
 	if(DQUOT_ALLOC_INODE(inode)) {
 		DQUOT_DROP(inode);
@@ -600,7 +579,6 @@ repeat:
 fail:
 	ext3_std_error(sb, err);
 out:
-	unlock_super(sb);
 	iput(inode);
 	ret = ERR_PTR(err);
 really_out:
@@ -673,12 +651,13 @@ out:
 
 unsigned long ext3_count_free_inodes (struct super_block * sb)
 {
+	unsigned long desc_count;
+	struct ext3_group_desc *gdp;
+	int i;
 #ifdef EXT3FS_DEBUG
 	struct ext3_super_block *es;
-	unsigned long desc_count, bitmap_count, x;
-	struct ext3_group_desc *gdp;
+	unsigned long bitmap_count, x;
 	struct buffer_head *bitmap_bh = NULL;
-	int i;
 
 	lock_super (sb);
 	es = EXT3_SB(sb)->s_es;
@@ -706,7 +685,14 @@ unsigned long ext3_count_free_inodes (st
 	unlock_super(sb);
 	return desc_count;
 #else
-	return le32_to_cpu(EXT3_SB(sb)->s_es->s_free_inodes_count);
+	desc_count = 0;
+	for (i = 0; i < EXT3_SB(sb)->s_groups_count; i++) {
+		gdp = ext3_get_group_desc (sb, i, NULL);
+		if (!gdp)
+			continue;
+		desc_count += le16_to_cpu(gdp->bg_free_inodes_count);
+	}
+	return desc_count;
 #endif
 }
 
diff -puNr linux-2.5.65/fs/ext3/super.c edited/fs/ext3/super.c
--- linux-2.5.65/fs/ext3/super.c	Tue Mar 18 14:13:37 2003
+++ edited/fs/ext3/super.c	Mon Mar 24 16:10:00 2003
@@ -395,7 +395,7 @@ void ext3_put_super (struct super_block 
 	for (i = 0; i < sbi->s_gdb_count; i++)
 		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
-	kfree(sbi->s_debts);
+	kfree(sbi->s_bgi);
 	brelse(sbi->s_sbh);
 
 	/* Debugging code just in case the in-memory inode orphan list
@@ -832,6 +832,8 @@ static int ext3_check_descriptors (struc
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	unsigned long block = le32_to_cpu(sbi->s_es->s_first_data_block);
 	struct ext3_group_desc * gdp = NULL;
+	unsigned long total_free;
+	unsigned int reserved = le32_to_cpu(sbi->s_es->s_r_blocks_count);
 	int desc_block = 0;
 	int i;
 
@@ -878,6 +880,43 @@ static int ext3_check_descriptors (struc
 		block += EXT3_BLOCKS_PER_GROUP(sb);
 		gdp++;
 	}
+
+	total_free = ext3_count_free_blocks(sb);
+	if (total_free != le32_to_cpu(EXT3_SB(sb)->s_es->s_free_blocks_count)) {
+		printk("EXT3-fs: invalid s_free_blocks_count %u (real %lu)\n",
+				le32_to_cpu(EXT3_SB(sb)->s_es->s_free_blocks_count),
+				total_free);
+		EXT3_SB(sb)->s_es->s_free_blocks_count = cpu_to_le32(total_free);
+	}
+
+	/* distribute reserved blocks over groups -bzzz */
+	for(i = sbi->s_groups_count - 1; reserved && total_free && i >= 0; i--) {
+		int free;
+
+		gdp = ext3_get_group_desc (sb, i, NULL);
+		if (!gdp) {
+			ext3_error (sb, "ext3_check_descriptors",
+					"cant get descriptor for group %d", i);
+			return 0;
+		}
+
+		free = le16_to_cpu(gdp->bg_free_blocks_count);
+		if (free > reserved)
+			free = reserved;
+		sbi->s_bgi[i].bg_reserved = free;
+		reserved -= free;
+		total_free -= free;
+	}
+
+	total_free = ext3_count_free_inodes(sb);
+	if (total_free != le32_to_cpu(EXT3_SB(sb)->s_es->s_free_inodes_count)) {
+		printk("EXT3-fs: invalid s_free_inodes_count %u (real %lu)\n",
+			le32_to_cpu(EXT3_SB(sb)->s_es->s_free_inodes_count),
+			total_free);
+		EXT3_SB(sb)->s_es->s_free_inodes_count = cpu_to_le32(total_free);
+	}
+
+
 	return 1;
 }
 
@@ -1237,13 +1276,17 @@ static int ext3_fill_super (struct super
 		printk (KERN_ERR "EXT3-fs: not enough memory\n");
 		goto failed_mount;
 	}
-	sbi->s_debts = kmalloc(sbi->s_groups_count * sizeof(*sbi->s_debts),
+	sbi->s_bgi = kmalloc(sbi->s_groups_count * sizeof(struct ext3_bg_info),
 			GFP_KERNEL);
-	if (!sbi->s_debts) {
-		printk ("EXT3-fs: not enough memory\n");
+	if (!sbi->s_bgi) {
+		printk("EXT3-fs: not enough memory to allocate s_bgi\n");
 		goto failed_mount2;
 	}
-	memset(sbi->s_debts, 0, sbi->s_groups_count * sizeof(*sbi->s_debts));
+	memset(sbi->s_bgi, 0,  sbi->s_groups_count * sizeof(struct ext3_bg_info));
+	for (i = 0; i < sbi->s_groups_count; i++) {
+		spin_lock_init(&sbi->s_bgi[i].bg_balloc_lock);
+		spin_lock_init(&sbi->s_bgi[i].bg_ialloc_lock);
+	}
 	for (i = 0; i < db_count; i++) {
 		block = descriptor_loc(sb, logic_sb_block, i);
 		sbi->s_group_desc[i] = sb_bread(sb, block);
@@ -1259,7 +1302,6 @@ static int ext3_fill_super (struct super
 		goto failed_mount2;
 	}
 	sbi->s_gdb_count = db_count;
-	sbi->s_dir_count = ext3_count_dirs(sb);
 	/*
 	 * set up enough so that it can read an inode
 	 */
@@ -1361,8 +1403,8 @@ static int ext3_fill_super (struct super
 failed_mount3:
 	journal_destroy(sbi->s_journal);
 failed_mount2:
-	if (sbi->s_debts)
-		kfree(sbi->s_debts);
+	if (sbi->s_bgi)
+		kfree(sbi->s_bgi);
 	for (i = 0; i < db_count; i++)
 		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
@@ -1630,6 +1672,8 @@ static void ext3_commit_super (struct su
 	if (!sbh)
 		return;
 	es->s_wtime = cpu_to_le32(get_seconds());
+	es->s_free_blocks_count = cpu_to_le32(ext3_count_free_blocks(sb));
+	es->s_free_inodes_count = cpu_to_le32(ext3_count_free_inodes(sb));
 	BUFFER_TRACE(sbh, "marking dirty");
 	mark_buffer_dirty(sbh);
 	if (sync)
diff -puNr linux-2.5.65/include/linux/ext3_fs.h edited/include/linux/ext3_fs.h
--- linux-2.5.65/include/linux/ext3_fs.h	Tue Mar 18 14:13:37 2003
+++ edited/include/linux/ext3_fs.h	Mon Mar 24 14:52:09 2003
@@ -344,7 +344,9 @@ struct ext3_inode {
 #endif
 
 #define ext3_set_bit			ext2_set_bit
+#define ext3_set_bit_atomic		ext2_set_bit_atomic
 #define ext3_clear_bit			ext2_clear_bit
+#define ext3_clear_bit_atomic		ext2_clear_bit_atomic
 #define ext3_test_bit			ext2_test_bit
 #define ext3_find_first_zero_bit	ext2_find_first_zero_bit
 #define ext3_find_next_zero_bit		ext2_find_next_zero_bit
diff -puNr linux-2.5.65/include/linux/ext3_fs_sb.h edited/include/linux/ext3_fs_sb.h
--- linux-2.5.65/include/linux/ext3_fs_sb.h	Mon Nov 11 06:28:30 2002
+++ edited/include/linux/ext3_fs_sb.h	Mon Mar 24 16:10:21 2003
@@ -21,6 +21,13 @@
 #include <linux/wait.h>
 #endif
 
+struct ext3_bg_info {
+	u8 bg_debts;
+	spinlock_t bg_balloc_lock;
+	spinlock_t bg_ialloc_lock;
+	unsigned long bg_reserved;
+} ____cacheline_aligned_in_smp;
+
 /*
  * third extended-fs super-block data in memory
  */
@@ -50,8 +57,7 @@ struct ext3_sb_info {
 	u32 s_next_generation;
 	u32 s_hash_seed[4];
 	int s_def_hash_version;
-	unsigned long s_dir_count;
-	u8 *s_debts;
+	struct ext3_bg_info *s_bgi;
 
 	/* Journaling */
 	struct inode * s_journal_inode;

