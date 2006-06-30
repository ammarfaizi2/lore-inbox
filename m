Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWF3AUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWF3AUt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWF3ATk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:19:40 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:47826 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964773AbWF3ATH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:19:07 -0400
Subject: [RFC][Update][Patch 14/16] 48bit super block (metadata) changes
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:19:05 -0700
Message-Id: <1151626746.6601.84.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-kernel and on-disk super block changes to support >32 bit blocks numbers.

Signed-Off-By: Laurent Vivier <Laurent.Vivier@bull.net>


---

 linux-2.6.17-ming/fs/ext3/balloc.c        |   52 ++++++++++++------
 linux-2.6.17-ming/fs/ext3/ialloc.c        |   10 ++-
 linux-2.6.17-ming/fs/ext3/inode.c         |    9 ++-
 linux-2.6.17-ming/fs/ext3/resize.c        |   25 +++++----
 linux-2.6.17-ming/fs/ext3/super.c         |   50 ++++++++++--------
 linux-2.6.17-ming/include/linux/ext3_fs.h |   83 +++++++++++++++++++++++++++++-
 6 files changed, 169 insertions(+), 60 deletions(-)

diff -puN fs/ext3/balloc.c~64bit-metadata fs/ext3/balloc.c
--- linux-2.6.17/fs/ext3/balloc.c~64bit-metadata	2006-06-28 16:47:14.234938045 -0700
+++ linux-2.6.17-ming/fs/ext3/balloc.c	2006-06-28 16:47:14.257935406 -0700
@@ -88,12 +88,16 @@ read_block_bitmap(struct super_block *sb
 	desc = ext3_get_group_desc (sb, block_group, NULL);
 	if (!desc)
 		goto error_out;
-	bh = sb_bread(sb, le32_to_cpu(desc->bg_block_bitmap));
+	bh = sb_bread(sb,
+		      EXT3_BLOCK_BITMAP(desc,
+			      ext3_group_first_block_no(sb, block_group)));
 	if (!bh)
 		ext3_error (sb, "read_block_bitmap",
 			    "Cannot read block bitmap - "
-			    "block_group = %d, block_bitmap = %u",
-			    block_group, le32_to_cpu(desc->bg_block_bitmap));
+			    "block_group = %d, block_bitmap = "E3FSBLK,
+			    block_group,
+			    EXT3_BLOCK_BITMAP(desc,
+			      ext3_group_first_block_no(sb, block_group)));
 error_out:
 	return bh;
 }
@@ -328,7 +332,7 @@ void ext3_free_blocks_sb(handle_t *handl
 	es = sbi->s_es;
 	if (block < le32_to_cpu(es->s_first_data_block) ||
 	    block + count < block ||
-	    block + count > le32_to_cpu(es->s_blocks_count)) {
+	    block + count > EXT3_BLOCKS_COUNT(es)) {
 		ext3_error (sb, "ext3_free_blocks",
 			    "Freeing blocks not in datazone - "
 			    "block = "E3FSBLK", count = %lu", block, count);
@@ -356,11 +360,19 @@ do_more:
 	if (!desc)
 		goto error_return;
 
-	if (in_range (le32_to_cpu(desc->bg_block_bitmap), block, count) ||
-	    in_range (le32_to_cpu(desc->bg_inode_bitmap), block, count) ||
-	    in_range (block, le32_to_cpu(desc->bg_inode_table),
+	if (in_range (EXT3_BLOCK_BITMAP(desc,
+				ext3_group_first_block_no(sb, block_group)),
+		      block, count) ||
+	    in_range (EXT3_INODE_BITMAP(desc,
+			    	ext3_group_first_block_no(sb, block_group)),
+		      block, count) ||
+	    in_range (block,
+		      EXT3_INODE_TABLE(desc,
+			      	ext3_group_first_block_no(sb, block_group)),
 		      sbi->s_itb_per_group) ||
-	    in_range (block + count - 1, le32_to_cpu(desc->bg_inode_table),
+	    in_range (block + count - 1,
+		      EXT3_INODE_TABLE(desc,
+			      	ext3_group_first_block_no(sb, block_group)),
 		      sbi->s_itb_per_group))
 		ext3_error (sb, "ext3_free_blocks",
 			    "Freeing blocks in system zones - "
@@ -1163,7 +1175,7 @@ static int ext3_has_free_blocks(struct e
 	ext3_fsblk_t free_blocks, root_blocks;
 
 	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
-	root_blocks = le32_to_cpu(sbi->s_es->s_r_blocks_count);
+	root_blocks = EXT3_R_BLOCKS_COUNT(sbi->s_es);
 	if (free_blocks < root_blocks + 1 && !capable(CAP_SYS_RESOURCE) &&
 		sbi->s_resuid != current->fsuid &&
 		(sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
@@ -1262,7 +1274,7 @@ ext3_fsblk_t ext3_new_blocks(handle_t *h
 	 * First, test whether the goal block is free.
 	 */
 	if (goal < le32_to_cpu(es->s_first_data_block) ||
-	    goal >= le32_to_cpu(es->s_blocks_count))
+	    goal >= EXT3_BLOCKS_COUNT(es))
 		goal = le32_to_cpu(es->s_first_data_block);
 	ext3_get_group_no_and_offset(sb, goal, &group_no, &grp_target_blk);
 	gdp = ext3_get_group_desc(sb, group_no, &gdp_bh);
@@ -1361,11 +1373,15 @@ allocated:
 
 	ret_block = grp_alloc_blk + ext3_group_first_block_no(sb, group_no);
 
-	if (in_range(le32_to_cpu(gdp->bg_block_bitmap), ret_block, num) ||
-	    in_range(le32_to_cpu(gdp->bg_inode_bitmap), ret_block, num) ||
-	    in_range(ret_block, le32_to_cpu(gdp->bg_inode_table),
+	if (in_range(EXT3_BLOCK_BITMAP(gdp, ext3_group_first_block_no(sb, group_no)),
+				ret_block, num) ||
+	    in_range(EXT3_BLOCK_BITMAP(gdp, ext3_group_first_block_no(sb, group_no)),
+		    		ret_block, num) ||
+	    in_range(ret_block, EXT3_INODE_TABLE(gdp,
+			    	ext3_group_first_block_no(sb, group_no)),
 		      EXT3_SB(sb)->s_itb_per_group) ||
-	    in_range(ret_block + num - 1, le32_to_cpu(gdp->bg_inode_table),
+	    in_range(ret_block + num - 1, EXT3_INODE_TABLE(gdp,
+			    ext3_group_first_block_no(sb, group_no)),
 		      EXT3_SB(sb)->s_itb_per_group))
 		ext3_error(sb, "ext3_new_block",
 			    "Allocating block in system zone - "
@@ -1404,11 +1420,11 @@ allocated:
 	jbd_unlock_bh_state(bitmap_bh);
 #endif
 
-	if (ret_block + num - 1 >= le32_to_cpu(es->s_blocks_count)) {
+	if (ret_block + num - 1 >= EXT3_BLOCKS_COUNT(es)) {
 		ext3_error(sb, "ext3_new_block",
-			    "block("E3FSBLK") >= blocks count(%d) - "
+			    "block("E3FSBLK") >= blocks count("E3FSBLK") - "
 			    "block_group = %lu, es == %p ", ret_block,
-			le32_to_cpu(es->s_blocks_count), group_no, es);
+			EXT3_BLOCKS_COUNT(es), group_no, es);
 		goto out;
 	}
 
@@ -1501,7 +1517,7 @@ ext3_fsblk_t ext3_count_free_blocks(stru
 	brelse(bitmap_bh);
 	printk("ext3_count_free_blocks: stored = "E3FSBLK
 		", computed = "E3FSBLK", "E3FSBLK"\n",
-	       le32_to_cpu(es->s_free_blocks_count),
+	       EXT3_FREE_BLOCKS_COUNT(es),
 		desc_count, bitmap_count);
 	return bitmap_count;
 #else
diff -puN fs/ext3/ialloc.c~64bit-metadata fs/ext3/ialloc.c
--- linux-2.6.17/fs/ext3/ialloc.c~64bit-metadata	2006-06-28 16:47:14.237937700 -0700
+++ linux-2.6.17-ming/fs/ext3/ialloc.c	2006-06-28 16:47:14.259935176 -0700
@@ -60,12 +60,14 @@ read_inode_bitmap(struct super_block * s
 	if (!desc)
 		goto error_out;
 
-	bh = sb_bread(sb, le32_to_cpu(desc->bg_inode_bitmap));
+	bh = sb_bread(sb, EXT3_INODE_BITMAP(desc,
+			      ext3_group_first_block_no(sb, block_group)));
 	if (!bh)
 		ext3_error(sb, "read_inode_bitmap",
 			    "Cannot read inode bitmap - "
-			    "block_group = %lu, inode_bitmap = %u",
-			    block_group, le32_to_cpu(desc->bg_inode_bitmap));
+			    "block_group = %lu, inode_bitmap = %llu",
+			    block_group, EXT3_INODE_BITMAP(desc,
+			      ext3_group_first_block_no(sb, block_group)));
 error_out:
 	return bh;
 }
@@ -304,7 +306,7 @@ static int find_group_orlov(struct super
 		goto fallback;
 	}
 
-	blocks_per_dir = le32_to_cpu(es->s_blocks_count) - freeb;
+	blocks_per_dir = EXT3_BLOCKS_COUNT(es) - freeb;
 	sector_div(blocks_per_dir, ndirs);
 
 	max_dirs = ndirs / ngroups + inodes_per_group / 16;
diff -puN fs/ext3/inode.c~64bit-metadata fs/ext3/inode.c
--- linux-2.6.17/fs/ext3/inode.c~64bit-metadata	2006-06-28 16:47:14.241937242 -0700
+++ linux-2.6.17-ming/fs/ext3/inode.c	2006-06-28 16:47:14.263934718 -0700
@@ -2433,8 +2433,9 @@ static ext3_fsblk_t ext3_get_inode_block
 	 */
 	offset = ((ino - 1) % EXT3_INODES_PER_GROUP(sb)) *
 		EXT3_INODE_SIZE(sb);
-	block = le32_to_cpu(gdp[desc].bg_inode_table) +
-		(offset >> EXT3_BLOCK_SIZE_BITS(sb));
+	block = EXT3_INODE_TABLE((gdp+desc),
+			ext3_group_first_block_no(sb, block_group)) +
+			(offset >> EXT3_BLOCK_SIZE_BITS(sb));
 
 	iloc->block_group = block_group;
 	iloc->offset = offset & (EXT3_BLOCK_SIZE(sb) - 1);
@@ -2501,7 +2502,9 @@ static int __ext3_get_inode_loc(struct i
 				goto make_io;
 
 			bitmap_bh = sb_getblk(inode->i_sb,
-					le32_to_cpu(desc->bg_inode_bitmap));
+				EXT3_INODE_BITMAP(desc,
+				     ext3_group_first_block_no(inode->i_sb,
+						     block_group)));
 			if (!bitmap_bh)
 				goto make_io;
 
diff -puN fs/ext3/resize.c~64bit-metadata fs/ext3/resize.c
--- linux-2.6.17/fs/ext3/resize.c~64bit-metadata	2006-06-28 16:47:14.245936783 -0700
+++ linux-2.6.17-ming/fs/ext3/resize.c	2006-06-28 16:47:14.266934373 -0700
@@ -27,7 +27,7 @@ static int verify_group_input(struct sup
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	struct ext3_super_block *es = sbi->s_es;
-	ext3_fsblk_t start = le32_to_cpu(es->s_blocks_count);
+	ext3_fsblk_t start = EXT3_BLOCKS_COUNT(es);
 	ext3_fsblk_t end = start + input->blocks_count;
 	unsigned group = input->group;
 	ext3_fsblk_t itend = input->inode_table + sbi->s_itb_per_group;
@@ -817,9 +817,12 @@ int ext3_group_add(struct super_block *s
 	/* Update group descriptor block for new group */
 	gdp = (struct ext3_group_desc *)primary->b_data + gdb_off;
 
-	gdp->bg_block_bitmap = cpu_to_le32(input->block_bitmap);
-	gdp->bg_inode_bitmap = cpu_to_le32(input->inode_bitmap);
-	gdp->bg_inode_table = cpu_to_le32(input->inode_table);
+	EXT3_BLOCK_BITMAP_SET(gdp, ext3_group_first_block_no(sb, gdb_num),
+				   input->block_bitmap); /* LV FIXME */
+	EXT3_INODE_BITMAP_SET(gdp, ext3_group_first_block_no(sb, gdb_num),
+			           input->inode_bitmap); /* LV FIXME */
+	EXT3_INODE_TABLE_SET(gdp, ext3_group_first_block_no(sb, gdb_num),
+			          input->inode_table); /* LV FIXME */
 	gdp->bg_free_blocks_count = cpu_to_le16(input->free_blocks_count);
 	gdp->bg_free_inodes_count = cpu_to_le16(EXT3_INODES_PER_GROUP(sb));
 
@@ -833,7 +836,7 @@ int ext3_group_add(struct super_block *s
 	 * blocks/inodes before the group is live won't actually let us
 	 * allocate the new space yet.
 	 */
-	es->s_blocks_count = cpu_to_le32(le32_to_cpu(es->s_blocks_count) +
+	EXT3_BLOCKS_COUNT_SET(es, EXT3_BLOCKS_COUNT(es) +
 		input->blocks_count);
 	es->s_inodes_count = cpu_to_le32(le32_to_cpu(es->s_inodes_count) +
 		EXT3_INODES_PER_GROUP(sb));
@@ -869,7 +872,7 @@ int ext3_group_add(struct super_block *s
 
 	/* Update the reserved block counts only once the new group is
 	 * active. */
-	es->s_r_blocks_count = cpu_to_le32(le32_to_cpu(es->s_r_blocks_count) +
+	EXT3_R_BLOCKS_COUNT_SET(es, EXT3_R_BLOCKS_COUNT(es) +
 		input->reserved_blocks);
 
 	/* Update the free space counts */
@@ -920,7 +923,7 @@ int ext3_group_extend(struct super_block
 	/* We don't need to worry about locking wrt other resizers just
 	 * yet: we're going to revalidate es->s_blocks_count after
 	 * taking lock_super() below. */
-	o_blocks_count = le32_to_cpu(es->s_blocks_count);
+	o_blocks_count = EXT3_BLOCKS_COUNT(es);
 	o_groups_count = EXT3_SB(sb)->s_groups_count;
 
 	if (test_opt(sb, DEBUG))
@@ -986,7 +989,7 @@ int ext3_group_extend(struct super_block
 	}
 
 	lock_super(sb);
-	if (o_blocks_count != le32_to_cpu(es->s_blocks_count)) {
+	if (o_blocks_count != EXT3_BLOCKS_COUNT(es)) {
 		ext3_warning(sb, __FUNCTION__,
 			     "multiple resizers run on filesystem!");
 		unlock_super(sb);
@@ -1002,7 +1005,7 @@ int ext3_group_extend(struct super_block
 		ext3_journal_stop(handle);
 		goto exit_put;
 	}
-	es->s_blocks_count = cpu_to_le32(o_blocks_count + add);
+	EXT3_BLOCKS_COUNT_SET(es, o_blocks_count + add);
 	ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
 	unlock_super(sb);
@@ -1014,8 +1017,8 @@ int ext3_group_extend(struct super_block
 	if ((err = ext3_journal_stop(handle)))
 		goto exit_put;
 	if (test_opt(sb, DEBUG))
-		printk(KERN_DEBUG "EXT3-fs: extended group to %u blocks\n",
-		       le32_to_cpu(es->s_blocks_count));
+		printk(KERN_DEBUG "EXT3-fs: extended group to %llu blocks\n",
+		       EXT3_BLOCKS_COUNT(es));
 	update_backups(sb, EXT3_SB(sb)->s_sbh->b_blocknr, (char *)es,
 		       sizeof(struct ext3_super_block));
 exit_put:
diff -puN fs/ext3/super.c~64bit-metadata fs/ext3/super.c
--- linux-2.6.17/fs/ext3/super.c~64bit-metadata	2006-06-28 16:47:14.248936438 -0700
+++ linux-2.6.17-ming/fs/ext3/super.c	2006-06-28 16:47:14.270933914 -0700
@@ -1151,44 +1151,48 @@ static int ext3_check_descriptors (struc
 		if ((i % EXT3_DESC_PER_BLOCK(sb)) == 0)
 			gdp = (struct ext3_group_desc *)
 					sbi->s_group_desc[desc_block++]->b_data;
-		if (le32_to_cpu(gdp->bg_block_bitmap) < block ||
-		    le32_to_cpu(gdp->bg_block_bitmap) >=
+		if (EXT3_BLOCK_BITMAP(gdp, ext3_group_first_block_no(sb, i)) <
+				block ||
+		    	EXT3_BLOCK_BITMAP(gdp, ext3_group_first_block_no(sb, i)) >=
 				block + EXT3_BLOCKS_PER_GROUP(sb))
 		{
 			ext3_error (sb, "ext3_check_descriptors",
 				    "Block bitmap for group %d"
 				    " not in group (block %lu)!",
 				    i, (unsigned long)
-					le32_to_cpu(gdp->bg_block_bitmap));
+					EXT3_BLOCK_BITMAP(gdp, ext3_group_first_block_no(sb, i)));
 			return 0;
 		}
-		if (le32_to_cpu(gdp->bg_inode_bitmap) < block ||
-		    le32_to_cpu(gdp->bg_inode_bitmap) >=
+		if (EXT3_INODE_BITMAP(gdp, ext3_group_first_block_no(sb, i)) <
+				block ||
+		    EXT3_INODE_BITMAP(gdp, ext3_group_first_block_no(sb, i)) >=
 				block + EXT3_BLOCKS_PER_GROUP(sb))
 		{
 			ext3_error (sb, "ext3_check_descriptors",
 				    "Inode bitmap for group %d"
 				    " not in group (block %lu)!",
 				    i, (unsigned long)
-					le32_to_cpu(gdp->bg_inode_bitmap));
+					EXT3_INODE_BITMAP(gdp, ext3_group_first_block_no(sb, i)));
 			return 0;
 		}
-		if (le32_to_cpu(gdp->bg_inode_table) < block ||
-		    le32_to_cpu(gdp->bg_inode_table) + sbi->s_itb_per_group >=
-		    block + EXT3_BLOCKS_PER_GROUP(sb))
+		if (EXT3_INODE_TABLE(gdp, ext3_group_first_block_no(sb, i)) <
+			block ||
+		    EXT3_INODE_TABLE(gdp, ext3_group_first_block_no(sb, i)) +
+							sbi->s_itb_per_group >=
+			block + EXT3_BLOCKS_PER_GROUP(sb))
 		{
 			ext3_error (sb, "ext3_check_descriptors",
 				    "Inode table for group %d"
 				    " not in group (block %lu)!",
 				    i, (unsigned long)
-					le32_to_cpu(gdp->bg_inode_table));
+					EXT3_INODE_TABLE(gdp, ext3_group_first_block_no(sb, i)));
 			return 0;
 		}
 		block += EXT3_BLOCKS_PER_GROUP(sb);
 		gdp++;
 	}
 
-	sbi->s_es->s_free_blocks_count=cpu_to_le32(ext3_count_free_blocks(sb));
+	EXT3_FREE_BLOCKS_COUNT_SET(sbi->s_es, ext3_count_free_blocks(sb));
 	sbi->s_es->s_free_inodes_count=cpu_to_le32(ext3_count_free_inodes(sb));
 	return 1;
 }
@@ -1365,6 +1369,7 @@ static int ext3_fill_super (struct super
 	int i;
 	int needs_recovery;
 	__le32 features;
+	__u64 blocks_count;
 
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
@@ -1575,7 +1580,7 @@ static int ext3_fill_super (struct super
 		goto failed_mount;
 	}
 
-	if (le32_to_cpu(es->s_blocks_count) >
+	if (EXT3_BLOCKS_COUNT(es) >
 		    (sector_t)(~0ULL) >> (sb->s_blocksize_bits - 9)) {
 		printk(KERN_ERR "EXT3-fs: filesystem on %s:"
 			" too large to mount safely\n", sb->s_id);
@@ -1587,10 +1592,11 @@ static int ext3_fill_super (struct super
 
 	if (EXT3_BLOCKS_PER_GROUP(sb) == 0)
 		goto cantfind_ext3;
-	sbi->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
-			       le32_to_cpu(es->s_first_data_block) +
-			       EXT3_BLOCKS_PER_GROUP(sb) - 1) /
-			      EXT3_BLOCKS_PER_GROUP(sb);
+	blocks_count = (EXT3_BLOCKS_COUNT(es) -
+			le32_to_cpu(es->s_first_data_block) +
+			EXT3_BLOCKS_PER_GROUP(sb) - 1);
+	do_div(blocks_count, EXT3_BLOCKS_PER_GROUP(sb));
+	sbi->s_groups_count = blocks_count;
 	db_count = (sbi->s_groups_count + EXT3_DESC_PER_BLOCK(sb) - 1) /
 		   EXT3_DESC_PER_BLOCK(sb);
 	sbi->s_group_desc = kmalloc(db_count * sizeof (struct buffer_head *),
@@ -1904,7 +1910,7 @@ static journal_t *ext3_get_dev_journal(s
 		goto out_bdev;
 	}
 
-	len = le32_to_cpu(es->s_blocks_count);
+	len = EXT3_BLOCKS_COUNT(es);
 	start = sb_block + 1;
 	brelse(bh);	/* we're done with the superblock */
 
@@ -2074,7 +2080,7 @@ static void ext3_commit_super (struct su
 	if (!sbh)
 		return;
 	es->s_wtime = cpu_to_le32(get_seconds());
-	es->s_free_blocks_count = cpu_to_le32(ext3_count_free_blocks(sb));
+	EXT3_FREE_BLOCKS_COUNT_SET(es, ext3_count_free_blocks(sb));
 	es->s_free_inodes_count = cpu_to_le32(ext3_count_free_inodes(sb));
 	BUFFER_TRACE(sbh, "marking dirty");
 	mark_buffer_dirty(sbh);
@@ -2267,7 +2273,7 @@ static int ext3_remount (struct super_bl
 	ext3_init_journal_params(sb, sbi->s_journal);
 
 	if ((*flags & MS_RDONLY) != (sb->s_flags & MS_RDONLY) ||
-		n_blocks_count > le32_to_cpu(es->s_blocks_count)) {
+		n_blocks_count > EXT3_BLOCKS_COUNT(es)) {
 		if (sbi->s_mount_opt & EXT3_MOUNT_ABORT) {
 			err = -EROFS;
 			goto restore_opts;
@@ -2388,10 +2394,10 @@ static int ext3_statfs (struct dentry * 
 
 	buf->f_type = EXT3_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
-	buf->f_blocks = le32_to_cpu(es->s_blocks_count) - overhead;
+	buf->f_blocks = EXT3_BLOCKS_COUNT(es) - overhead;
 	buf->f_bfree = percpu_counter_sum(&sbi->s_freeblocks_counter);
-	buf->f_bavail = buf->f_bfree - le32_to_cpu(es->s_r_blocks_count);
-	if (buf->f_bfree < le32_to_cpu(es->s_r_blocks_count))
+	buf->f_bavail = buf->f_bfree - EXT3_R_BLOCKS_COUNT(es);
+	if (buf->f_bfree < EXT3_R_BLOCKS_COUNT(es))
 		buf->f_bavail = 0;
 	buf->f_files = le32_to_cpu(es->s_inodes_count);
 	buf->f_ffree = percpu_counter_sum(&sbi->s_freeinodes_counter);
diff -puN include/linux/ext3_fs.h~64bit-metadata include/linux/ext3_fs.h
--- linux-2.6.17/include/linux/ext3_fs.h~64bit-metadata	2006-06-28 16:47:14.252935980 -0700
+++ linux-2.6.17-ming/include/linux/ext3_fs.h	2006-06-28 16:47:14.273933570 -0700
@@ -136,6 +136,54 @@ struct ext3_group_desc
 	__le32	bg_reserved[3];
 };
 
+static inline u32 EXT3_RELATIVE_ENCODE(ext3_fsblk_t group_base,
+				       ext3_fsblk_t fs_block)
+{
+	s32 gdp_block;
+
+	if (fs_block < (1ULL<<32) && group_base < (1ULL<<32))
+		return fs_block;
+
+	gdp_block = (fs_block - group_base);
+	BUG_ON ((group_base + gdp_block) != fs_block);
+
+	return gdp_block;
+}
+
+static inline ext3_fsblk_t EXT3_RELATIVE_DECODE(ext3_fsblk_t group_base,
+						u32 gdp_block)
+{
+	if (group_base >= (1ULL<<32))
+		return group_base + (s32) gdp_block;
+
+	if ((s32) gdp_block >= 0 && gdp_block < group_base &&
+		  group_base + gdp_block >= (1ULL<<32))
+		return group_base + gdp_block;
+
+	return gdp_block;
+}
+
+#define EXT3_BLOCK_BITMAP(bg, group_base)	\
+		EXT3_RELATIVE_DECODE(group_base, le32_to_cpu((bg)->bg_block_bitmap))
+#define EXT3_INODE_BITMAP(bg, group_base)	\
+		EXT3_RELATIVE_DECODE(group_base, le32_to_cpu((bg)->bg_inode_bitmap))
+#define EXT3_INODE_TABLE(bg, group_base)	\
+		EXT3_RELATIVE_DECODE(group_base, le32_to_cpu((bg)->bg_inode_table))
+
+#define EXT3_BLOCK_BITMAP_SET(bg, group_base, value)	\
+	do {(bg)->bg_block_bitmap = EXT3_RELATIVE_ENCODE(group_base, value);} while(0)
+#define EXT3_INODE_BITMAP_SET(bg, group_base, value)	\
+	do {(bg)->bg_inode_bitmap = EXT3_RELATIVE_ENCODE(group_base, value);} while(0)
+#define EXT3_INODE_TABLE_SET(bg, group_base, value)	\
+	do {(bg)->bg_inode_table = EXT3_RELATIVE_ENCODE(group_base, value);} while(0)
+
+#define EXT3_IS_USED_BLOCK_BITMAP(bg)	\
+	((bg)->bg_block_bitmap != 0)
+#define EXT3_IS_USED_INODE_BITMAP(bg)	\
+	((bg)->bg_inode_bitmap != 0)
+#define EXT3_IS_USED_INODE_TABLE(bg)	\
+	((bg)->bg_inode_table != 0)
+
 /*
  * Macro-instructions used to manage group descriptors
  */
@@ -483,9 +531,38 @@ struct ext3_super_block {
 	__u16	s_reserved_word_pad;
 	__le32	s_default_mount_opts;
 	__le32	s_first_meta_bg; 	/* First metablock block group */
-	__u32	s_reserved[190];	/* Padding to the end of the block */
+	/* 64bit support valid if EXT3_FEATURE_COMPAT_64BIT */
+	__le32	s_blocks_count_hi;	/* Blocks count */
+/*100*/	__le32	s_r_blocks_count_hi;	/* Reserved blocks count */
+	__le32	s_free_blocks_count_hi;	/* Free blocks count */
+	__u32	s_reserved[187];	/* Padding to the end of the block */
 };
 
+
+#define EXT3_BLOCKS_COUNT(s)	\
+	(ext3_fsblk_t)(((__u64)le32_to_cpu((s)->s_blocks_count_hi) << 32) |	\
+	 	(__u64)le32_to_cpu((s)->s_blocks_count))
+#define EXT3_BLOCKS_COUNT_SET(s,v)	do {				\
+	(s)->s_blocks_count = cpu_to_le32((v));				\
+	(s)->s_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
+} while (0)
+
+#define EXT3_R_BLOCKS_COUNT(s)	\
+	(ext3_fsblk_t)(((__u64)le32_to_cpu((s)->s_r_blocks_count_hi) << 32) |	\
+		 (__u64)le32_to_cpu((s)->s_r_blocks_count))
+#define EXT3_R_BLOCKS_COUNT_SET(s,v)	do {				\
+	(s)->s_r_blocks_count = cpu_to_le32((v));			\
+	(s)->s_r_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
+} while (0)
+
+#define EXT3_FREE_BLOCKS_COUNT(s)					\
+	(ext3_fsblk_t)(((__u64)le32_to_cpu((s)->s_free_blocks_count_hi) << 32) | \
+		 (__u64)le32_to_cpu((s)->s_free_blocks_count))
+#define EXT3_FREE_BLOCKS_COUNT_SET(s,v)	do {				\
+	(s)->s_free_blocks_count = cpu_to_le32((v));			\
+	(s)->s_free_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
+} while (0)
+
 #ifdef __KERNEL__
 #include <linux/ext3_fs_i.h>
 #include <linux/ext3_fs_sb.h>
@@ -559,6 +636,7 @@ static inline struct ext3_inode_info *EX
 #define EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER	0x0001
 #define EXT3_FEATURE_RO_COMPAT_LARGE_FILE	0x0002
 #define EXT3_FEATURE_RO_COMPAT_BTREE_DIR	0x0004
+#define EXT3_FEATURE_RO_COMPAT_64BIT		0x0010
 
 #define EXT3_FEATURE_INCOMPAT_COMPRESSION	0x0001
 #define EXT3_FEATURE_INCOMPAT_FILETYPE		0x0002
@@ -574,7 +652,8 @@ static inline struct ext3_inode_info *EX
 					 EXT3_FEATURE_INCOMPAT_EXTENTS)
 #define EXT3_FEATURE_RO_COMPAT_SUPP	(EXT3_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT3_FEATURE_RO_COMPAT_LARGE_FILE| \
-					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR)
+					 EXT3_FEATURE_RO_COMPAT_BTREE_DIR| \
+					 EXT3_FEATURE_RO_COMPAT_64BIT)
 
 /*
  * Default values for user and/or group using reserved blocks

_


