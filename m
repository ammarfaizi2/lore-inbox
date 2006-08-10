Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030564AbWHJBXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030564AbWHJBXW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030552AbWHJBWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:22:51 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:35508 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030548AbWHJBWi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:22:38 -0400
Subject: [PATCH 9/9]ext4 super block changes for >32 bit blocks numbers
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 09 Aug 2006 18:22:25 -0700
Message-Id: <1155172945.3161.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-kernel and on-disk super block changes to support >32 bit blocks numbers.


Signed-Off-By: Laurent Vivier <Laurent.Vivier@bull.net>


---

 linux-2.6.18-rc4-ming/fs/ext4/balloc.c        |   52 +++++++++-----
 linux-2.6.18-rc4-ming/fs/ext4/ialloc.c        |   10 +-
 linux-2.6.18-rc4-ming/fs/ext4/inode.c         |    9 +-
 linux-2.6.18-rc4-ming/fs/ext4/resize.c        |   25 +++----
 linux-2.6.18-rc4-ming/fs/ext4/super.c         |   50 +++++++-------
 linux-2.6.18-rc4-ming/include/linux/ext4_fs.h |   92 ++++++++++++++++++++++++--
 6 files changed, 175 insertions(+), 63 deletions(-)

diff -puN fs/ext4/balloc.c~64bit-metadata fs/ext4/balloc.c
--- linux-2.6.18-rc4/fs/ext4/balloc.c~64bit-metadata	2006-08-09 15:42:08.511423402 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/balloc.c	2006-08-09 15:42:08.534423588 -0700
@@ -87,12 +87,16 @@ read_block_bitmap(struct super_block *sb
 	desc = ext4_get_group_desc (sb, block_group, NULL);
 	if (!desc)
 		goto error_out;
-	bh = sb_bread(sb, le32_to_cpu(desc->bg_block_bitmap));
+	bh = sb_bread(sb,
+		      EXT4_BLOCK_BITMAP(desc,
+			      ext4_group_first_block_no(sb, block_group)));
 	if (!bh)
 		ext4_error (sb, "read_block_bitmap",
 			    "Cannot read block bitmap - "
-			    "block_group = %d, block_bitmap = %u",
-			    block_group, le32_to_cpu(desc->bg_block_bitmap));
+			    "block_group = %d, block_bitmap = "E3FSBLK,
+			    block_group,
+			    EXT4_BLOCK_BITMAP(desc,
+			      ext4_group_first_block_no(sb, block_group)));
 error_out:
 	return bh;
 }
@@ -327,7 +331,7 @@ void ext4_free_blocks_sb(handle_t *handl
 	es = sbi->s_es;
 	if (block < le32_to_cpu(es->s_first_data_block) ||
 	    block + count < block ||
-	    block + count > le32_to_cpu(es->s_blocks_count)) {
+	    block + count > EXT4_BLOCKS_COUNT(es)) {
 		ext4_error (sb, "ext4_free_blocks",
 			    "Freeing blocks not in datazone - "
 			    "block = "E3FSBLK", count = %lu", block, count);
@@ -355,11 +359,19 @@ do_more:
 	if (!desc)
 		goto error_return;
 
-	if (in_range (le32_to_cpu(desc->bg_block_bitmap), block, count) ||
-	    in_range (le32_to_cpu(desc->bg_inode_bitmap), block, count) ||
-	    in_range (block, le32_to_cpu(desc->bg_inode_table),
+	if (in_range (EXT4_BLOCK_BITMAP(desc,
+				ext4_group_first_block_no(sb, block_group)),
+		      block, count) ||
+	    in_range (EXT4_INODE_BITMAP(desc,
+			    	ext4_group_first_block_no(sb, block_group)),
+		      block, count) ||
+	    in_range (block,
+		      EXT4_INODE_TABLE(desc,
+			      	ext4_group_first_block_no(sb, block_group)),
 		      sbi->s_itb_per_group) ||
-	    in_range (block + count - 1, le32_to_cpu(desc->bg_inode_table),
+	    in_range (block + count - 1,
+		      EXT4_INODE_TABLE(desc,
+			      	ext4_group_first_block_no(sb, block_group)),
 		      sbi->s_itb_per_group))
 		ext4_error (sb, "ext4_free_blocks",
 			    "Freeing blocks in system zones - "
@@ -1162,7 +1174,7 @@ static int ext4_has_free_blocks(struct e
 	ext4_fsblk_t free_blocks, root_blocks;
 
 	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
-	root_blocks = le32_to_cpu(sbi->s_es->s_r_blocks_count);
+	root_blocks = EXT4_R_BLOCKS_COUNT(sbi->s_es);
 	if (free_blocks < root_blocks + 1 && !capable(CAP_SYS_RESOURCE) &&
 		sbi->s_resuid != current->fsuid &&
 		(sbi->s_resgid == 0 || !in_group_p (sbi->s_resgid))) {
@@ -1261,7 +1273,7 @@ ext4_fsblk_t ext4_new_blocks(handle_t *h
 	 * First, test whether the goal block is free.
 	 */
 	if (goal < le32_to_cpu(es->s_first_data_block) ||
-	    goal >= le32_to_cpu(es->s_blocks_count))
+	    goal >= EXT4_BLOCKS_COUNT(es))
 		goal = le32_to_cpu(es->s_first_data_block);
 	ext4_get_group_no_and_offset(sb, goal, &group_no, &grp_target_blk);
 	gdp = ext4_get_group_desc(sb, group_no, &gdp_bh);
@@ -1360,11 +1372,15 @@ allocated:
 
 	ret_block = grp_alloc_blk + ext4_group_first_block_no(sb, group_no);
 
-	if (in_range(le32_to_cpu(gdp->bg_block_bitmap), ret_block, num) ||
-	    in_range(le32_to_cpu(gdp->bg_inode_bitmap), ret_block, num) ||
-	    in_range(ret_block, le32_to_cpu(gdp->bg_inode_table),
+	if (in_range(EXT4_BLOCK_BITMAP(gdp, ext4_group_first_block_no(sb, group_no)),
+				ret_block, num) ||
+	    in_range(EXT4_BLOCK_BITMAP(gdp, ext4_group_first_block_no(sb, group_no)),
+		    		ret_block, num) ||
+	    in_range(ret_block, EXT4_INODE_TABLE(gdp,
+			    	ext4_group_first_block_no(sb, group_no)),
 		      EXT4_SB(sb)->s_itb_per_group) ||
-	    in_range(ret_block + num - 1, le32_to_cpu(gdp->bg_inode_table),
+	    in_range(ret_block + num - 1, EXT4_INODE_TABLE(gdp,
+			    ext4_group_first_block_no(sb, group_no)),
 		      EXT4_SB(sb)->s_itb_per_group))
 		ext4_error(sb, "ext4_new_block",
 			    "Allocating block in system zone - "
@@ -1403,11 +1419,11 @@ allocated:
 	jbd_unlock_bh_state(bitmap_bh);
 #endif
 
-	if (ret_block + num - 1 >= le32_to_cpu(es->s_blocks_count)) {
+	if (ret_block + num - 1 >= EXT4_BLOCKS_COUNT(es)) {
 		ext4_error(sb, "ext4_new_block",
-			    "block("E3FSBLK") >= blocks count(%d) - "
+			    "block("E3FSBLK") >= blocks count("E3FSBLK") - "
 			    "block_group = %lu, es == %p ", ret_block,
-			le32_to_cpu(es->s_blocks_count), group_no, es);
+			EXT4_BLOCKS_COUNT(es), group_no, es);
 		goto out;
 	}
 
@@ -1500,7 +1516,7 @@ ext4_fsblk_t ext4_count_free_blocks(stru
 	brelse(bitmap_bh);
 	printk("ext4_count_free_blocks: stored = "E3FSBLK
 		", computed = "E3FSBLK", "E3FSBLK"\n",
-	       le32_to_cpu(es->s_free_blocks_count),
+	       EXT4_FREE_BLOCKS_COUNT(es),
 		desc_count, bitmap_count);
 	return bitmap_count;
 #else
diff -puN fs/ext4/ialloc.c~64bit-metadata fs/ext4/ialloc.c
--- linux-2.6.18-rc4/fs/ext4/ialloc.c~64bit-metadata	2006-08-09 15:42:08.514423426 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/ialloc.c	2006-08-09 15:42:08.535423597 -0700
@@ -60,12 +60,14 @@ read_inode_bitmap(struct super_block * s
 	if (!desc)
 		goto error_out;
 
-	bh = sb_bread(sb, le32_to_cpu(desc->bg_inode_bitmap));
+	bh = sb_bread(sb, EXT4_INODE_BITMAP(desc,
+			      ext4_group_first_block_no(sb, block_group)));
 	if (!bh)
 		ext4_error(sb, "read_inode_bitmap",
 			    "Cannot read inode bitmap - "
-			    "block_group = %lu, inode_bitmap = %u",
-			    block_group, le32_to_cpu(desc->bg_inode_bitmap));
+			    "block_group = %lu, inode_bitmap = %llu",
+			    block_group, EXT4_INODE_BITMAP(desc,
+			      ext4_group_first_block_no(sb, block_group)));
 error_out:
 	return bh;
 }
@@ -304,7 +306,7 @@ static int find_group_orlov(struct super
 		goto fallback;
 	}
 
-	blocks_per_dir = le32_to_cpu(es->s_blocks_count) - freeb;
+	blocks_per_dir = EXT4_BLOCKS_COUNT(es) - freeb;
 	sector_div(blocks_per_dir, ndirs);
 
 	max_dirs = ndirs / ngroups + inodes_per_group / 16;
diff -puN fs/ext4/inode.c~64bit-metadata fs/ext4/inode.c
--- linux-2.6.18-rc4/fs/ext4/inode.c~64bit-metadata	2006-08-09 15:42:08.518423459 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/inode.c	2006-08-09 15:42:08.540423637 -0700
@@ -2433,8 +2433,9 @@ static ext4_fsblk_t ext4_get_inode_block
 	 */
 	offset = ((ino - 1) % EXT4_INODES_PER_GROUP(sb)) *
 		EXT4_INODE_SIZE(sb);
-	block = le32_to_cpu(gdp[desc].bg_inode_table) +
-		(offset >> EXT4_BLOCK_SIZE_BITS(sb));
+	block = EXT4_INODE_TABLE((gdp+desc),
+			ext4_group_first_block_no(sb, block_group)) +
+			(offset >> EXT4_BLOCK_SIZE_BITS(sb));
 
 	iloc->block_group = block_group;
 	iloc->offset = offset & (EXT4_BLOCK_SIZE(sb) - 1);
@@ -2501,7 +2502,9 @@ static int __ext4_get_inode_loc(struct i
 				goto make_io;
 
 			bitmap_bh = sb_getblk(inode->i_sb,
-					le32_to_cpu(desc->bg_inode_bitmap));
+				EXT4_INODE_BITMAP(desc,
+				     ext4_group_first_block_no(inode->i_sb,
+						     block_group)));
 			if (!bitmap_bh)
 				goto make_io;
 
diff -puN fs/ext4/resize.c~64bit-metadata fs/ext4/resize.c
--- linux-2.6.18-rc4/fs/ext4/resize.c~64bit-metadata	2006-08-09 15:42:08.521423483 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/resize.c	2006-08-09 15:42:08.543423661 -0700
@@ -27,7 +27,7 @@ static int verify_group_input(struct sup
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_super_block *es = sbi->s_es;
-	ext4_fsblk_t start = le32_to_cpu(es->s_blocks_count);
+	ext4_fsblk_t start = EXT4_BLOCKS_COUNT(es);
 	ext4_fsblk_t end = start + input->blocks_count;
 	unsigned group = input->group;
 	ext4_fsblk_t itend = input->inode_table + sbi->s_itb_per_group;
@@ -817,9 +817,12 @@ int ext4_group_add(struct super_block *s
 	/* Update group descriptor block for new group */
 	gdp = (struct ext4_group_desc *)primary->b_data + gdb_off;
 
-	gdp->bg_block_bitmap = cpu_to_le32(input->block_bitmap);
-	gdp->bg_inode_bitmap = cpu_to_le32(input->inode_bitmap);
-	gdp->bg_inode_table = cpu_to_le32(input->inode_table);
+	EXT4_BLOCK_BITMAP_SET(gdp, ext4_group_first_block_no(sb, gdb_num),
+				   input->block_bitmap); /* LV FIXME */
+	EXT4_INODE_BITMAP_SET(gdp, ext4_group_first_block_no(sb, gdb_num),
+			           input->inode_bitmap); /* LV FIXME */
+	EXT4_INODE_TABLE_SET(gdp, ext4_group_first_block_no(sb, gdb_num),
+			          input->inode_table); /* LV FIXME */
 	gdp->bg_free_blocks_count = cpu_to_le16(input->free_blocks_count);
 	gdp->bg_free_inodes_count = cpu_to_le16(EXT4_INODES_PER_GROUP(sb));
 
@@ -833,7 +836,7 @@ int ext4_group_add(struct super_block *s
 	 * blocks/inodes before the group is live won't actually let us
 	 * allocate the new space yet.
 	 */
-	es->s_blocks_count = cpu_to_le32(le32_to_cpu(es->s_blocks_count) +
+	EXT4_BLOCKS_COUNT_SET(es, EXT4_BLOCKS_COUNT(es) +
 		input->blocks_count);
 	es->s_inodes_count = cpu_to_le32(le32_to_cpu(es->s_inodes_count) +
 		EXT4_INODES_PER_GROUP(sb));
@@ -869,7 +872,7 @@ int ext4_group_add(struct super_block *s
 
 	/* Update the reserved block counts only once the new group is
 	 * active. */
-	es->s_r_blocks_count = cpu_to_le32(le32_to_cpu(es->s_r_blocks_count) +
+	EXT4_R_BLOCKS_COUNT_SET(es, EXT4_R_BLOCKS_COUNT(es) +
 		input->reserved_blocks);
 
 	/* Update the free space counts */
@@ -920,7 +923,7 @@ int ext4_group_extend(struct super_block
 	/* We don't need to worry about locking wrt other resizers just
 	 * yet: we're going to revalidate es->s_blocks_count after
 	 * taking lock_super() below. */
-	o_blocks_count = le32_to_cpu(es->s_blocks_count);
+	o_blocks_count = EXT4_BLOCKS_COUNT(es);
 	o_groups_count = EXT4_SB(sb)->s_groups_count;
 
 	if (test_opt(sb, DEBUG))
@@ -986,7 +989,7 @@ int ext4_group_extend(struct super_block
 	}
 
 	lock_super(sb);
-	if (o_blocks_count != le32_to_cpu(es->s_blocks_count)) {
+	if (o_blocks_count != EXT4_BLOCKS_COUNT(es)) {
 		ext4_warning(sb, __FUNCTION__,
 			     "multiple resizers run on filesystem!");
 		unlock_super(sb);
@@ -1002,7 +1005,7 @@ int ext4_group_extend(struct super_block
 		ext4_journal_stop(handle);
 		goto exit_put;
 	}
-	es->s_blocks_count = cpu_to_le32(o_blocks_count + add);
+	EXT4_BLOCKS_COUNT_SET(es, o_blocks_count + add);
 	ext4_journal_dirty_metadata(handle, EXT4_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
 	unlock_super(sb);
@@ -1014,8 +1017,8 @@ int ext4_group_extend(struct super_block
 	if ((err = ext4_journal_stop(handle)))
 		goto exit_put;
 	if (test_opt(sb, DEBUG))
-		printk(KERN_DEBUG "EXT4-fs: extended group to %u blocks\n",
-		       le32_to_cpu(es->s_blocks_count));
+		printk(KERN_DEBUG "EXT4-fs: extended group to %llu blocks\n",
+		       EXT4_BLOCKS_COUNT(es));
 	update_backups(sb, EXT4_SB(sb)->s_sbh->b_blocknr, (char *)es,
 		       sizeof(struct ext4_super_block));
 exit_put:
diff -puN fs/ext4/super.c~64bit-metadata fs/ext4/super.c
--- linux-2.6.18-rc4/fs/ext4/super.c~64bit-metadata	2006-08-09 15:42:08.525423516 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/super.c	2006-08-09 15:42:08.548423702 -0700
@@ -1150,44 +1150,48 @@ static int ext4_check_descriptors (struc
 		if ((i % EXT4_DESC_PER_BLOCK(sb)) == 0)
 			gdp = (struct ext4_group_desc *)
 					sbi->s_group_desc[desc_block++]->b_data;
-		if (le32_to_cpu(gdp->bg_block_bitmap) < block ||
-		    le32_to_cpu(gdp->bg_block_bitmap) >=
+		if (EXT4_BLOCK_BITMAP(gdp, ext4_group_first_block_no(sb, i)) <
+				block ||
+		    	EXT4_BLOCK_BITMAP(gdp, ext4_group_first_block_no(sb, i)) >=
 				block + EXT4_BLOCKS_PER_GROUP(sb))
 		{
 			ext4_error (sb, "ext4_check_descriptors",
 				    "Block bitmap for group %d"
 				    " not in group (block %lu)!",
 				    i, (unsigned long)
-					le32_to_cpu(gdp->bg_block_bitmap));
+					EXT4_BLOCK_BITMAP(gdp, ext4_group_first_block_no(sb, i)));
 			return 0;
 		}
-		if (le32_to_cpu(gdp->bg_inode_bitmap) < block ||
-		    le32_to_cpu(gdp->bg_inode_bitmap) >=
+		if (EXT4_INODE_BITMAP(gdp, ext4_group_first_block_no(sb, i)) <
+				block ||
+		    EXT4_INODE_BITMAP(gdp, ext4_group_first_block_no(sb, i)) >=
 				block + EXT4_BLOCKS_PER_GROUP(sb))
 		{
 			ext4_error (sb, "ext4_check_descriptors",
 				    "Inode bitmap for group %d"
 				    " not in group (block %lu)!",
 				    i, (unsigned long)
-					le32_to_cpu(gdp->bg_inode_bitmap));
+					EXT4_INODE_BITMAP(gdp, ext4_group_first_block_no(sb, i)));
 			return 0;
 		}
-		if (le32_to_cpu(gdp->bg_inode_table) < block ||
-		    le32_to_cpu(gdp->bg_inode_table) + sbi->s_itb_per_group >=
-		    block + EXT4_BLOCKS_PER_GROUP(sb))
+		if (EXT4_INODE_TABLE(gdp, ext4_group_first_block_no(sb, i)) <
+			block ||
+		    EXT4_INODE_TABLE(gdp, ext4_group_first_block_no(sb, i)) +
+							sbi->s_itb_per_group >=
+			block + EXT4_BLOCKS_PER_GROUP(sb))
 		{
 			ext4_error (sb, "ext4_check_descriptors",
 				    "Inode table for group %d"
 				    " not in group (block %lu)!",
 				    i, (unsigned long)
-					le32_to_cpu(gdp->bg_inode_table));
+					EXT4_INODE_TABLE(gdp, ext4_group_first_block_no(sb, i)));
 			return 0;
 		}
 		block += EXT4_BLOCKS_PER_GROUP(sb);
 		gdp++;
 	}
 
-	sbi->s_es->s_free_blocks_count=cpu_to_le32(ext4_count_free_blocks(sb));
+	EXT4_FREE_BLOCKS_COUNT_SET(sbi->s_es, ext4_count_free_blocks(sb));
 	sbi->s_es->s_free_inodes_count=cpu_to_le32(ext4_count_free_inodes(sb));
 	return 1;
 }
@@ -1364,6 +1368,7 @@ static int ext4_fill_super (struct super
 	int i;
 	int needs_recovery;
 	__le32 features;
+	__u64 blocks_count;
 
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
@@ -1574,7 +1579,7 @@ static int ext4_fill_super (struct super
 		goto failed_mount;
 	}
 
-	if (le32_to_cpu(es->s_blocks_count) >
+	if (EXT4_BLOCKS_COUNT(es) >
 		    (sector_t)(~0ULL) >> (sb->s_blocksize_bits - 9)) {
 		printk(KERN_ERR "EXT4-fs: filesystem on %s:"
 			" too large to mount safely\n", sb->s_id);
@@ -1586,10 +1591,11 @@ static int ext4_fill_super (struct super
 
 	if (EXT4_BLOCKS_PER_GROUP(sb) == 0)
 		goto cantfind_ext4;
-	sbi->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
-			       le32_to_cpu(es->s_first_data_block) +
-			       EXT4_BLOCKS_PER_GROUP(sb) - 1) /
-			      EXT4_BLOCKS_PER_GROUP(sb);
+	blocks_count = (EXT4_BLOCKS_COUNT(es) -
+			le32_to_cpu(es->s_first_data_block) +
+			EXT4_BLOCKS_PER_GROUP(sb) - 1);
+	do_div(blocks_count, EXT4_BLOCKS_PER_GROUP(sb));
+	sbi->s_groups_count = blocks_count;
 	db_count = (sbi->s_groups_count + EXT4_DESC_PER_BLOCK(sb) - 1) /
 		   EXT4_DESC_PER_BLOCK(sb);
 	sbi->s_group_desc = kmalloc(db_count * sizeof (struct buffer_head *),
@@ -1903,7 +1909,7 @@ static journal_t *ext4_get_dev_journal(s
 		goto out_bdev;
 	}
 
-	len = le32_to_cpu(es->s_blocks_count);
+	len = EXT4_BLOCKS_COUNT(es);
 	start = sb_block + 1;
 	brelse(bh);	/* we're done with the superblock */
 
@@ -2073,7 +2079,7 @@ static void ext4_commit_super (struct su
 	if (!sbh)
 		return;
 	es->s_wtime = cpu_to_le32(get_seconds());
-	es->s_free_blocks_count = cpu_to_le32(ext4_count_free_blocks(sb));
+	EXT4_FREE_BLOCKS_COUNT_SET(es, ext4_count_free_blocks(sb));
 	es->s_free_inodes_count = cpu_to_le32(ext4_count_free_inodes(sb));
 	BUFFER_TRACE(sbh, "marking dirty");
 	mark_buffer_dirty(sbh);
@@ -2266,7 +2272,7 @@ static int ext4_remount (struct super_bl
 	ext4_init_journal_params(sb, sbi->s_journal);
 
 	if ((*flags & MS_RDONLY) != (sb->s_flags & MS_RDONLY) ||
-		n_blocks_count > le32_to_cpu(es->s_blocks_count)) {
+		n_blocks_count > EXT4_BLOCKS_COUNT(es)) {
 		if (sbi->s_mount_opt & EXT4_MOUNT_ABORT) {
 			err = -EROFS;
 			goto restore_opts;
@@ -2387,10 +2393,10 @@ static int ext4_statfs (struct dentry * 
 
 	buf->f_type = EXT4_SUPER_MAGIC;
 	buf->f_bsize = sb->s_blocksize;
-	buf->f_blocks = le32_to_cpu(es->s_blocks_count) - overhead;
+	buf->f_blocks = EXT4_BLOCKS_COUNT(es) - overhead;
 	buf->f_bfree = percpu_counter_sum(&sbi->s_freeblocks_counter);
-	buf->f_bavail = buf->f_bfree - le32_to_cpu(es->s_r_blocks_count);
-	if (buf->f_bfree < le32_to_cpu(es->s_r_blocks_count))
+	buf->f_bavail = buf->f_bfree - EXT4_R_BLOCKS_COUNT(es);
+	if (buf->f_bfree < EXT4_R_BLOCKS_COUNT(es))
 		buf->f_bavail = 0;
 	buf->f_files = le32_to_cpu(es->s_inodes_count);
 	buf->f_ffree = percpu_counter_sum(&sbi->s_freeinodes_counter);
diff -puN include/linux/ext4_fs.h~64bit-metadata include/linux/ext4_fs.h
--- linux-2.6.18-rc4/include/linux/ext4_fs.h~64bit-metadata	2006-08-09 15:42:08.528423540 -0700
+++ linux-2.6.18-rc4-ming/include/linux/ext4_fs.h	2006-08-09 15:42:08.552423734 -0700
@@ -136,6 +136,57 @@ struct ext4_group_desc
 	__le32	bg_reserved[3];
 };
 
+#ifdef __KERNEL__
+#include <linux/ext4_fs_i.h>
+#include <linux/ext4_fs_sb.h>
+static inline u32 EXT4_RELATIVE_ENCODE(ext4_fsblk_t group_base,
+				       ext4_fsblk_t fs_block)
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
+static inline ext4_fsblk_t EXT4_RELATIVE_DECODE(ext4_fsblk_t group_base,
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
+#define EXT4_BLOCK_BITMAP(bg, group_base)	\
+		EXT4_RELATIVE_DECODE(group_base, le32_to_cpu((bg)->bg_block_bitmap))
+#define EXT4_INODE_BITMAP(bg, group_base)	\
+		EXT4_RELATIVE_DECODE(group_base, le32_to_cpu((bg)->bg_inode_bitmap))
+#define EXT4_INODE_TABLE(bg, group_base)	\
+		EXT4_RELATIVE_DECODE(group_base, le32_to_cpu((bg)->bg_inode_table))
+
+#define EXT4_BLOCK_BITMAP_SET(bg, group_base, value)	\
+	do {(bg)->bg_block_bitmap = EXT4_RELATIVE_ENCODE(group_base, value);} while(0)
+#define EXT4_INODE_BITMAP_SET(bg, group_base, value)	\
+	do {(bg)->bg_inode_bitmap = EXT4_RELATIVE_ENCODE(group_base, value);} while(0)
+#define EXT4_INODE_TABLE_SET(bg, group_base, value)	\
+	do {(bg)->bg_inode_table = EXT4_RELATIVE_ENCODE(group_base, value);} while(0)
+
+#define EXT4_IS_USED_BLOCK_BITMAP(bg)	\
+	((bg)->bg_block_bitmap != 0)
+#define EXT4_IS_USED_INODE_BITMAP(bg)	\
+	((bg)->bg_inode_bitmap != 0)
+#define EXT4_IS_USED_INODE_TABLE(bg)	\
+	((bg)->bg_inode_table != 0)
+#endif
 /*
  * Macro-instructions used to manage group descriptors
  */
@@ -481,14 +532,43 @@ struct ext4_super_block {
 	__u8	s_def_hash_version;	/* Default hash version to use */
 	__u8	s_reserved_char_pad;
 	__u16	s_reserved_word_pad;
-	__le32	s_default_mount_opts;
+/*100*/	__le32	s_default_mount_opts;
 	__le32	s_first_meta_bg; 	/* First metablock block group */
-	__u32	s_reserved[190];	/* Padding to the end of the block */
+	__le32	s_mkfs_time;		/* When the filesystem was created */
+	__le32	s_jnl_blocks[17]; 	/* Backup of the journal inode */
+	/* 64bit support valid if EXT4_FEATURE_COMPAT_64BIT */
+/*150*/	__le32	s_blocks_count_hi;	/* Blocks count */
+	__le32	s_r_blocks_count_hi;	/* Reserved blocks count */
+	__le32	s_free_blocks_count_hi;	/* Free blocks count */
+	__u32	s_reserved[169];	/* Padding to the end of the block */
 };
 
+
+#define EXT4_BLOCKS_COUNT(s)	\
+	(ext4_fsblk_t)(((__u64)le32_to_cpu((s)->s_blocks_count_hi) << 32) |	\
+	 	(__u64)le32_to_cpu((s)->s_blocks_count))
+#define EXT4_BLOCKS_COUNT_SET(s,v)	do {				\
+	(s)->s_blocks_count = cpu_to_le32((v));				\
+	(s)->s_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
+} while (0)
+
+#define EXT4_R_BLOCKS_COUNT(s)	\
+	(ext4_fsblk_t)(((__u64)le32_to_cpu((s)->s_r_blocks_count_hi) << 32) |	\
+		 (__u64)le32_to_cpu((s)->s_r_blocks_count))
+#define EXT4_R_BLOCKS_COUNT_SET(s,v)	do {				\
+	(s)->s_r_blocks_count = cpu_to_le32((v));			\
+	(s)->s_r_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
+} while (0)
+
+#define EXT4_FREE_BLOCKS_COUNT(s)					\
+	(ext4_fsblk_t)(((__u64)le32_to_cpu((s)->s_free_blocks_count_hi) << 32) | \
+		 (__u64)le32_to_cpu((s)->s_free_blocks_count))
+#define EXT4_FREE_BLOCKS_COUNT_SET(s,v)	do {				\
+	(s)->s_free_blocks_count = cpu_to_le32((v));			\
+	(s)->s_free_blocks_count_hi = cpu_to_le32(((__u64)(v)) >> 32);	\
+} while (0)
+
 #ifdef __KERNEL__
-#include <linux/ext4_fs_i.h>
-#include <linux/ext4_fs_sb.h>
 static inline struct ext4_sb_info * EXT4_SB(struct super_block *sb)
 {
 	return sb->s_fs_info;
@@ -566,12 +646,14 @@ static inline struct ext4_inode_info *EX
 #define EXT4_FEATURE_INCOMPAT_JOURNAL_DEV	0x0008 /* Journal device */
 #define EXT4_FEATURE_INCOMPAT_META_BG		0x0010
 #define EXT4_FEATURE_INCOMPAT_EXTENTS		0x0040 /* extents support */
+#define EXT4_FEATURE_INCOMPAT_64BIT		0x0080
 
 #define EXT4_FEATURE_COMPAT_SUPP	EXT2_FEATURE_COMPAT_EXT_ATTR
 #define EXT4_FEATURE_INCOMPAT_SUPP	(EXT4_FEATURE_INCOMPAT_FILETYPE| \
 					 EXT4_FEATURE_INCOMPAT_RECOVER| \
 					 EXT4_FEATURE_INCOMPAT_META_BG| \
-					 EXT4_FEATURE_INCOMPAT_EXTENTS)
+					 EXT4_FEATURE_INCOMPAT_EXTENTS| \
+					 EXT4_FEATURE_INCOMPAT_64BIT)
 #define EXT4_FEATURE_RO_COMPAT_SUPP	(EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER| \
 					 EXT4_FEATURE_RO_COMPAT_LARGE_FILE| \
 					 EXT4_FEATURE_RO_COMPAT_BTREE_DIR)

_


