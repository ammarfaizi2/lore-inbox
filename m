Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbWD0Hc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWD0Hc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 03:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWD0Hc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 03:32:27 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:51120 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932398AbWD0HcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 03:32:25 -0400
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][14/21]e2fsprogs modify variables to exceed 2G
Message-Id: <20060427163213sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 27 Apr 2006 16:32:13 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [14/21] change the type of variables for a block or an inode
          - Change the type of 4byte variables manipulating a block or
            an inode from signed to unsigned.

          - Cast the type of operation in which an overflow occurs to
            long long.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr e2fsprogs-1.39.org/e2fsck/pass1.c e2fsprogs-1.39.tmp/e2fsck/pass1.c
--- e2fsprogs-1.39.org/e2fsck/pass1.c	2006-03-19 11:33:56.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/pass1.c	2006-04-27 13:08:49.000000000 +0900
@@ -1893,6 +1893,7 @@ static void new_table_block(e2fsck_t ctx
 	int		i;
 	char		*buf;
 	struct problem_context	pctx;
+	blk64_t         last_block;
 
 	clear_problem_context(&pctx);
 
@@ -1900,8 +1901,11 @@ static void new_table_block(e2fsck_t ctx
 	pctx.blk = old_block;
 	pctx.str = name;
 
-	pctx.errcode = ext2fs_get_free_blocks(fs, first_block,
-			first_block + fs->super->s_blocks_per_group,
+	last_block = (blk64_t) first_block + fs->super->s_blocks_per_group - 1;
+	if (last_block >= fs->super->s_blocks_count)
+		last_block = fs->super->s_blocks_count - 1;
+
+	pctx.errcode = ext2fs_get_free_blocks(fs, first_block, last_block,
 					num, ctx->block_found_map, new_block);
 	if (pctx.errcode) {
 		pctx.num = num;
diff -upNr e2fsprogs-1.39.org/e2fsck/pass5.c e2fsprogs-1.39.tmp/e2fsck/pass5.c
--- e2fsprogs-1.39.org/e2fsck/pass5.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/pass5.c	2006-04-27 13:16:05.000000000 +0900
@@ -502,13 +502,13 @@ static void check_inode_end(e2fsck_t ctx
 static void check_block_end(e2fsck_t ctx)
 {
 	ext2_filsys fs = ctx->fs;
-	blk_t	end, save_blocks_count, i;
+	blk64_t	end, save_blocks_count, i;
 	struct problem_context	pctx;
 
 	clear_problem_context(&pctx);
 
 	end = fs->block_map->start +
-		(EXT2_BLOCKS_PER_GROUP(fs->super) * fs->group_desc_count) - 1;
+		((blk64_t)EXT2_BLOCKS_PER_GROUP(fs->super) * fs->group_desc_count) - 1;
 	pctx.errcode = ext2fs_fudge_block_bitmap_end(fs->block_map, end,
 						     &save_blocks_count);
 	if (pctx.errcode) {
diff -upNr e2fsprogs-1.39.org/lib/ext2fs/alloc.c e2fsprogs-1.39.tmp/lib/ext2fs/alloc.c
--- e2fsprogs-1.39.org/lib/ext2fs/alloc.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/alloc.c	2006-04-27 13:08:49.000000000 +0900
@@ -159,15 +159,15 @@ errcode_t ext2fs_get_free_blocks(ext2_fi
 		finish = start;
 	if (!num)
 		num = 1;
+	if (b+num-1 >= fs->super->s_blocks_count)
+		b = fs->super->s_first_data_block;
 	do {
-		if (b+num-1 > fs->super->s_blocks_count)
-			b = fs->super->s_first_data_block;
 		if (ext2fs_fast_test_block_bitmap_range(map, b, num)) {
 			*ret = b;
 			return 0;
 		}
 		b++;
-	} while (b != finish);
+	} while (b <= finish);
 	return EXT2_ET_BLOCK_ALLOC_FAIL;
 }
 
diff -upNr e2fsprogs-1.39.org/lib/ext2fs/alloc_tables.c e2fsprogs-1.39.tmp/lib/ext2fs/alloc_tables.c
--- e2fsprogs-1.39.org/lib/ext2fs/alloc_tables.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/alloc_tables.c	2006-04-27 13:08:49.000000000 +0900
@@ -31,13 +31,14 @@ errcode_t ext2fs_allocate_group_table(ex
 				      ext2fs_block_bitmap bmap)
 {
 	errcode_t	retval;
-	blk_t		group_blk, start_blk, last_blk, new_blk, blk;
+	blk_t           group_blk, new_blk, blk;
+	blk64_t         start_blk, last_blk;
 	int		j;
 
 	group_blk = fs->super->s_first_data_block +
 		(group * fs->super->s_blocks_per_group);
 	
-	last_blk = group_blk + fs->super->s_blocks_per_group;
+	last_blk = (blk64_t) group_blk + fs->super->s_blocks_per_group - 1;
 	if (last_blk >= fs->super->s_blocks_count)
 		last_blk = fs->super->s_blocks_count - 1;
 
@@ -48,9 +49,9 @@ errcode_t ext2fs_allocate_group_table(ex
 	 * Allocate the block and inode bitmaps, if necessary
 	 */
 	if (fs->stride) {
-		start_blk = group_blk + fs->inode_blocks_per_group;
+		start_blk = (blk64_t) group_blk + fs->inode_blocks_per_group;
 		start_blk += ((fs->stride * group) %
-			      (last_blk - start_blk));
+			      (last_blk - start_blk + 1));
 		if (start_blk > last_blk)
 			start_blk = group_blk;
 	} else
diff -upNr e2fsprogs-1.39.org/lib/ext2fs/check_desc.c e2fsprogs-1.39.tmp/lib/ext2fs/check_desc.c
--- e2fsprogs-1.39.org/lib/ext2fs/check_desc.c	2005-09-06 18:40:14.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/check_desc.c	2006-04-27 13:08:49.000000000 +0900
@@ -33,12 +33,12 @@ errcode_t ext2fs_check_desc(ext2_filsys 
 {
 	dgrp_t i;
 	blk_t block = fs->super->s_first_data_block;
-	blk_t next;
+	blk64_t next;
 
 	EXT2_CHECK_MAGIC(fs, EXT2_ET_MAGIC_EXT2FS_FILSYS);
 
 	for (i = 0; i < fs->group_desc_count; i++) {
-		next = block + fs->super->s_blocks_per_group;
+		next = (blk64_t) block + fs->super->s_blocks_per_group;
 		/*
 		 * Check to make sure block bitmap for group is
 		 * located within the group.
diff -upNr e2fsprogs-1.39.org/lib/ext2fs/ext2fs.h e2fsprogs-1.39.tmp/lib/ext2fs/ext2fs.h
--- e2fsprogs-1.39.org/lib/ext2fs/ext2fs.h	2006-03-19 08:58:00.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/ext2fs.h	2006-04-27 13:08:49.000000000 +0900
@@ -72,6 +72,7 @@ extern "C" {
 
 typedef __u32		ext2_ino_t;
 typedef __u32		blk_t;
+typedef __u64		blk64_t;
 typedef __u32		dgrp_t;
 typedef __u32		ext2_off_t;
 typedef __s64		e2_blkcnt_t;
diff -upNr e2fsprogs-1.39.org/lib/ext2fs/initialize.c e2fsprogs-1.39.tmp/lib/ext2fs/initialize.c
--- e2fsprogs-1.39.org/lib/ext2fs/initialize.c	2006-03-19 08:59:47.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/initialize.c	2006-04-27 13:08:49.000000000 +0900
@@ -77,7 +77,7 @@ static unsigned int calc_reserved_gdt_bl
 	 */
 	if (sb->s_blocks_count < max_blocks / 1024)
 		max_blocks = sb->s_blocks_count * 1024;
-	rsv_groups = (max_blocks - sb->s_first_data_block + bpg - 1) / bpg;
+	rsv_groups = ((blk64_t)max_blocks - sb->s_first_data_block + bpg - 1) / bpg;
 	rsv_gdb = (rsv_groups + gdpb - 1) / gdpb - fs->desc_blocks;
 	if (rsv_gdb > EXT2_ADDR_PER_BLOCK(sb))
 		rsv_gdb = EXT2_ADDR_PER_BLOCK(sb);
@@ -205,7 +205,7 @@ errcode_t ext2fs_initialize(const char *
 	}
 
 retry:
-	fs->group_desc_count = (super->s_blocks_count -
+	fs->group_desc_count = ((blk64_t) super->s_blocks_count -
 				super->s_first_data_block +
 				EXT2_BLOCKS_PER_GROUP(super) - 1)
 		/ EXT2_BLOCKS_PER_GROUP(super);
@@ -233,7 +233,7 @@ retry:
 	 * should be.  But make sure that we don't allocate more than
 	 * one bitmap's worth of inodes each group.
 	 */
-	ipg = (super->s_inodes_count + fs->group_desc_count - 1) /
+	ipg = ((__u64) super->s_inodes_count + fs->group_desc_count - 1) /
 		fs->group_desc_count;
 	if (ipg > fs->blocksize * 8) {
 		if (super->s_blocks_per_group >= 256) {
@@ -250,8 +250,9 @@ retry:
 	if (ipg > (unsigned) EXT2_MAX_INODES_PER_GROUP(super))
 		ipg = EXT2_MAX_INODES_PER_GROUP(super);
 
+ipg_try:
 	super->s_inodes_per_group = ipg;
-	if (super->s_inodes_count > ipg * fs->group_desc_count)
+	if (super->s_inodes_count > (__u64) ipg * fs->group_desc_count)
 		super->s_inodes_count = ipg * fs->group_desc_count;
 
 	/*
@@ -277,6 +278,11 @@ retry:
 				       EXT2_BLOCK_SIZE(super) - 1) /
 				      EXT2_BLOCK_SIZE(super));
 
+	if ((__u64) super->s_inodes_per_group * fs->group_desc_count > ~0U) {
+		ipg--;
+		goto ipg_try;
+	}
+
 	/*
 	 * adjust inode count to reflect the adjusted inodes_per_group
 	 */
diff -upNr e2fsprogs-1.39.org/lib/ext2fs/openfs.c e2fsprogs-1.39.tmp/lib/ext2fs/openfs.c
--- e2fsprogs-1.39.org/lib/ext2fs/openfs.c	2006-03-18 12:56:25.000000000 +0900
+++ e2fsprogs-1.39.tmp/lib/ext2fs/openfs.c	2006-04-27 13:08:49.000000000 +0900
@@ -258,7 +258,7 @@ errcode_t ext2fs_open2(const char *name,
 		retval = EXT2_ET_CORRUPT_SUPERBLOCK;
 		goto cleanup;
 	}
-	fs->group_desc_count = (fs->super->s_blocks_count -
+	fs->group_desc_count = ((blk64_t) fs->super->s_blocks_count -
 				fs->super->s_first_data_block +
 				blocks_per_group - 1) / blocks_per_group;
 	fs->desc_blocks = (fs->group_desc_count +
diff -upNr e2fsprogs-1.39.org/misc/mke2fs.c e2fsprogs-1.39.tmp/misc/mke2fs.c
--- e2fsprogs-1.39.org/misc/mke2fs.c	2006-04-27 13:08:42.000000000 +0900
+++ e2fsprogs-1.39.tmp/misc/mke2fs.c	2006-04-27 13:08:49.000000000 +0900
@@ -780,11 +780,11 @@ static void parse_extended_opts(struct e
 			if (!bpg)
 				bpg = blocksize * 8;
 			gdpb = blocksize / sizeof(struct ext2_group_desc);
-			group_desc_count = (param->s_blocks_count +
+			group_desc_count = ((blk64_t) param->s_blocks_count +
 					    bpg - 1) / bpg;
 			desc_blocks = (group_desc_count +
 				       gdpb - 1) / gdpb;
-			rsv_groups = (resize + bpg - 1) / bpg;
+			rsv_groups = ((blk64_t) resize + bpg - 1) / bpg;
 			rsv_gdb = (rsv_groups + gdpb - 1) / gdpb - 
 				desc_blocks;
 			if (rsv_gdb > (int) EXT2_ADDR_PER_BLOCK(param))
@@ -855,7 +855,7 @@ static void PRS(int argc, char *argv[])
 	double		reserved_ratio = 5.0;
 	int		sector_size = 0;
 	int		show_version_only = 0;
-	ext2_ino_t	num_inodes = 0;
+	__u64		num_inodes = 0;
 	errcode_t	retval;
 	char *		oldpath = getenv("PATH");
 	char *		extended_opts = 0;
@@ -1221,7 +1221,7 @@ static void PRS(int argc, char *argv[])
 	}
 
 	if (!fs_type) {
-		int megs = fs_param.s_blocks_count * 
+		int megs = (blk64_t) fs_param.s_blocks_count * 
 			(EXT2_BLOCK_SIZE(&fs_param) / 1024) / 1024;
 
 		if (megs <= 3)
@@ -1390,6 +1390,22 @@ static void PRS(int argc, char *argv[])
 		fs_param.s_inode_size = inode_size;
 	}
 
+	/* inodes safty check */
+	if (num_inodes == 0) {
+		__u64 n;
+
+		n = (blk64_t) fs_param.s_blocks_count * blocksize / inode_ratio;
+		if (n > ~0U) {
+			com_err(program_name, 0,
+				_("inodes_count must be less than 4G!"));
+			exit(1);
+		}
+	} else if (num_inodes > ~0U) {
+		com_err(program_name, 0,
+			_("inodes_count must be less than 4G!"));
+		exit(1);
+	}
+
 	/*
 	 * Calculate number of inodes based on the inode ratio
 	 */
@@ -1400,7 +1416,7 @@ static void PRS(int argc, char *argv[])
 	/*
 	 * Calculate number of blocks to reserve
 	 */
-	fs_param.s_r_blocks_count = (fs_param.s_blocks_count * reserved_ratio)
+	fs_param.s_r_blocks_count = ((blk64_t) fs_param.s_blocks_count * reserved_ratio)
 		/ 100;
 }
 
diff -upNr e2fsprogs-1.39.org/resize/resize2fs.c e2fsprogs-1.39.tmp/resize/resize2fs.c
--- e2fsprogs-1.39.org/resize/resize2fs.c	2006-03-19 11:34:00.000000000 +0900
+++ e2fsprogs-1.39.tmp/resize/resize2fs.c	2006-04-27 13:14:02.000000000 +0900
@@ -181,7 +181,7 @@ errcode_t adjust_fs_info(ext2_filsys fs,
 	int		overhead = 0;
 	int		rem;
 	blk_t		blk, group_block;
-	ext2_ino_t	real_end;
+	blk64_t		real_end;
 	int		adj, old_numblocks, numblocks, adjblocks;
 	unsigned long	i, j, old_desc_blocks, max_group;
 	unsigned int	meta_bg, meta_bg_size;
@@ -190,7 +190,7 @@ errcode_t adjust_fs_info(ext2_filsys fs,
 	fs->super->s_blocks_count = new_size;
 
 retry:
-	fs->group_desc_count = (fs->super->s_blocks_count -
+	fs->group_desc_count = ((blk64_t) fs->super->s_blocks_count -
 				fs->super->s_first_data_block +
 				EXT2_BLOCKS_PER_GROUP(fs->super) - 1)
 		/ EXT2_BLOCKS_PER_GROUP(fs->super);
@@ -225,6 +225,13 @@ retry:
 		fs->super->s_blocks_count -= rem;
 		goto retry;
 	}
+
+	if ((__u64) fs->super->s_inodes_per_group * fs->group_desc_count > ~0U)
+	{
+		fprintf(stderr, _("inodes_count must be less than 4G!\n"));
+		return EXT2_ET_TOO_MANY_INODES;
+	}
+
 	/*
 	 * Adjust the number of inodes
 	 */
@@ -245,9 +252,9 @@ retry:
 	/*
 	 * Adjust the number of reserved blocks
 	 */
-	blk = old_fs->super->s_r_blocks_count * 100 /
+	blk = (blk64_t) old_fs->super->s_r_blocks_count * 100 /
 		old_fs->super->s_blocks_count;
-	fs->super->s_r_blocks_count = ((fs->super->s_blocks_count * blk)
+	fs->super->s_r_blocks_count = (((blk64_t) fs->super->s_blocks_count * blk)
 				       / 100);
 
 	/*
@@ -258,7 +265,7 @@ retry:
 					    fs->inode_map);
 	if (retval) goto errout;
 	
-	real_end = ((EXT2_BLOCKS_PER_GROUP(fs->super)
+	real_end = (((blk64_t)EXT2_BLOCKS_PER_GROUP(fs->super)
 		     * fs->group_desc_count)) - 1 +
 			     fs->super->s_first_data_block;
 	retval = ext2fs_resize_block_bitmap(fs->super->s_blocks_count-1,
