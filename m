Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWF3GjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWF3GjO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 02:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWF3GjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 02:39:13 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:63978 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751173AbWF3GjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 02:39:10 -0400
To: jitendra@linsyssoft.com, adilger@clusterfs.com, cmm@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [RFC][PATCH 2/3] add ext2_grpblk_t for group relative blocks
Message-Id: <20060630153905sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Fri, 30 Jun 2006 15:39:05 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 2/3] ext2_grpblk_t.patch
This patch converts ext2 group relative blocks to ext2_grpblk_t.

Signed-off-by: Takashi Sato <sho@tnes.nec.co.jp>
---
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/fs/ext2/balloc.c linux-2.6.17.tmp/fs/ext2/balloc.c
--- linux-2.6.17/fs/ext2/balloc.c	2006-06-29 21:26:30.000000000 +0900
+++ linux-2.6.17.tmp/fs/ext2/balloc.c	2006-06-29 21:26:49.000000000 +0900
@@ -140,10 +140,10 @@ static void release_blocks(struct super_
 	}
 }
 
-static int group_reserve_blocks(struct ext2_sb_info *sbi, int group_no,
-	struct ext2_group_desc *desc, struct buffer_head *bh, int count)
+static ext2_grpblk_t group_reserve_blocks(struct ext2_sb_info *sbi, int group_no,
+	struct ext2_group_desc *desc, struct buffer_head *bh, ext2_grpblk_t count)
 {
-	unsigned free_blocks;
+	ext2_grpblk_t free_blocks;
 
 	if (!desc->bg_free_blocks_count)
 		return 0;
@@ -159,11 +159,11 @@ static int group_reserve_blocks(struct e
 }
 
 static void group_release_blocks(struct super_block *sb, int group_no,
-	struct ext2_group_desc *desc, struct buffer_head *bh, int count)
+	struct ext2_group_desc *desc, struct buffer_head *bh, ext2_grpblk_t count)
 {
 	if (count) {
 		struct ext2_sb_info *sbi = EXT2_SB(sb);
-		unsigned free_blocks;
+		ext2_grpblk_t free_blocks;
 
 		spin_lock(sb_bgl_lock(sbi, group_no));
 		free_blocks = le16_to_cpu(desc->bg_free_blocks_count);
@@ -181,15 +181,15 @@ void ext2_free_blocks (struct inode * in
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head * bh2;
 	unsigned long block_group;
-	unsigned long bit;
-	unsigned long i;
+	ext2_grpblk_t bit;
+	ext2_grpblk_t i;
 	ext2_fsblk_t overflow;
 	struct super_block * sb = inode->i_sb;
 	struct ext2_sb_info * sbi = EXT2_SB(sb);
 	struct ext2_group_desc * desc;
 	struct ext2_super_block * es = sbi->s_es;
 	ext2_fsblk_t freed = 0;
-	unsigned group_freed;
+	ext2_grpblk_t group_freed;
 
 	if (block < le32_to_cpu(es->s_first_data_block) ||
 	    block + count < block ||
@@ -264,9 +264,9 @@ error_return:
 	DQUOT_FREE_BLOCK(inode, freed);
 }
 
-static int grab_block(spinlock_t *lock, char *map, unsigned size, int goal)
+static int grab_block(spinlock_t *lock, char *map, ext2_grpblk_t size, ext2_grpblk_t goal)
 {
-	int k;
+	ext2_grpblk_t k;
 	char *p, *r;
 
 	if (!ext2_test_bit(goal, map))
@@ -332,16 +332,16 @@ ext2_fsblk_t ext2_new_block(struct inode
 	struct buffer_head *gdp_bh;	/* bh2 */
 	struct ext2_group_desc *desc;
 	int group_no;			/* i */
-	int ret_block;			/* j */
+	ext2_grpblk_t ret_block;	/* j */
 	int group_idx;			/* k */
-	ext2_fsblk_t target_block;		/* tmp */
+	ext2_fsblk_t target_block;	/* tmp */
 	ext2_fsblk_t block = 0;
 	struct super_block *sb = inode->i_sb;
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct ext2_super_block *es = sbi->s_es;
-	unsigned group_size = EXT2_BLOCKS_PER_GROUP(sb);
+	ext2_grpblk_t group_size = EXT2_BLOCKS_PER_GROUP(sb);
 	unsigned prealloc_goal = es->s_prealloc_blocks;
-	unsigned group_alloc = 0;
+	ext2_grpblk_t group_alloc = 0;
 	ext2_fsblk_t es_alloc, dq_alloc;
 	int nr_scanned_groups;
 
@@ -390,7 +390,7 @@ ext2_fsblk_t ext2_new_block(struct inode
 		if (!bitmap_bh)
 			goto io_error;
 		
-		ext2_debug("goal is at %d:%d.\n", group_no, ret_block);
+		ext2_debug("goal is at %d:%ld.\n", group_no, ret_block);
 
 		ret_block = grab_block(sb_bgl_lock(sbi, group_no),
 				bitmap_bh->b_data, group_size, ret_block);
@@ -467,7 +467,7 @@ got_block:
 
 	if (target_block >= le32_to_cpu(es->s_blocks_count)) {
 		ext2_error (sb, "ext2_new_block",
-			    "block(%d) >= blocks count(%d) - "
+			    "block(%ld) >= blocks count(%d) - "
 			    "block_group = %d, es == %p ", ret_block,
 			le32_to_cpu(es->s_blocks_count), group_no, es);
 		goto io_error;
@@ -475,7 +475,7 @@ got_block:
 	block = target_block;
 
 	/* OK, we _had_ allocated something */
-	ext2_debug("found bit %d\n", ret_block);
+	ext2_debug("found bit %ld\n", ret_block);
 
 	dq_alloc--;
 	es_alloc--;
@@ -530,7 +530,7 @@ ext2_fsblk_t ext2_count_free_blocks (str
 	int i;
 #ifdef EXT2FS_DEBUG
 	ext2_fsblk_t bitmap_count;
-	unsigned long x;
+	ext2_grpblk_t x;
 	struct ext2_super_block *es;
 
 	lock_super (sb);
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/fs/ext2/ialloc.c linux-2.6.17.tmp/fs/ext2/ialloc.c
--- linux-2.6.17/fs/ext2/ialloc.c	2006-06-29 21:26:30.000000000 +0900
+++ linux-2.6.17.tmp/fs/ext2/ialloc.c	2006-06-29 21:26:49.000000000 +0900
@@ -279,7 +279,7 @@ static int find_group_orlov(struct super
 	int freei;
 	int avefreei;
 	ext2_fsblk_t free_blocks;
-	int avefreeb;
+	ext2_grpblk_t avefreeb;
 	int blocks_per_dir;
 	int ndirs;
 	int max_debt, max_dirs, min_blocks, min_inodes;
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/fs/ext2/inode.c linux-2.6.17.tmp/fs/ext2/inode.c
--- linux-2.6.17/fs/ext2/inode.c	2006-06-29 21:26:30.000000000 +0900
+++ linux-2.6.17.tmp/fs/ext2/inode.c	2006-06-29 21:26:49.000000000 +0900
@@ -327,7 +327,7 @@ static unsigned long ext2_find_near(stru
 	__le32 *start = ind->bh ? (__le32 *) ind->bh->b_data : ei->i_data;
 	__le32 *p;
 	ext2_fsblk_t bg_start;
-	unsigned long colour;
+	ext2_grpblk_t colour;
 
 	/* Try to find previous block */
 	for (p = ind->p - 1; p >= start; p--)
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/include/linux/ext2_fs_sb.h linux-2.6.17.tmp/include/linux/ext2_fs_sb.h
--- linux-2.6.17/include/linux/ext2_fs_sb.h	2006-06-29 21:26:30.000000000 +0900
+++ linux-2.6.17.tmp/include/linux/ext2_fs_sb.h	2006-06-29 21:26:49.000000000 +0900
@@ -20,6 +20,7 @@
 #include <linux/percpu_counter.h>
 
 typedef unsigned long ext2_fsblk_t;
+typedef long ext2_grpblk_t;
 
 /*
  * second extended-fs super-block data in memory
@@ -29,7 +30,7 @@ struct ext2_sb_info {
 	unsigned long s_frags_per_block;/* Number of fragments per block */
 	unsigned long s_inodes_per_block;/* Number of inodes per block */
 	unsigned long s_frags_per_group;/* Number of fragments in a group */
-	unsigned long s_blocks_per_group;/* Number of blocks in a group */
+	ext2_grpblk_t s_blocks_per_group;/* Number of blocks in a group */
 	unsigned long s_inodes_per_group;/* Number of inodes in a group */
 	unsigned long s_itb_per_group;	/* Number of inode table blocks per group */
 	unsigned long s_gdb_count;	/* Number of group descriptor blocks */

