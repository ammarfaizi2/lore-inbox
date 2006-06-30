Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933164AbWF3ARf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933164AbWF3ARf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933140AbWF3ARc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:17:32 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:6605 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S933119AbWF3ARS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:17:18 -0400
Subject: [RFC][Update][Patch 3/16]convert ext3_fsblk_t to sector_t to
	support >32 bit block in kernel
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org
Cc: ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 29 Jun 2006 17:17:15 -0700
Message-Id: <1151626635.6601.70.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Redefine ext3 in-kernel filesystem block type (ext3_fsblk_t) from unsigned
long to sector_t, to allow kernel to handle  >32 bit ext3 blocks.

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.17-ming/fs/ext3/balloc.c          |   22 ++++++++--------------
 linux-2.6.17-ming/fs/ext3/ialloc.c          |   11 +++++++----
 linux-2.6.17-ming/fs/ext3/resize.c          |   14 ++++++--------
 linux-2.6.17-ming/fs/ext3/super.c           |    8 ++++----
 linux-2.6.17-ming/include/linux/ext3_fs.h   |   26 ++++++++++++++++++++++++++
 linux-2.6.17-ming/include/linux/ext3_fs_i.h |    4 ++--
 6 files changed, 53 insertions(+), 32 deletions(-)

diff -puN fs/ext3/balloc.c~ext3_fsblk_sector_t fs/ext3/balloc.c
--- linux-2.6.17/fs/ext3/balloc.c~ext3_fsblk_sector_t	2006-06-28 16:46:36.057318618 -0700
+++ linux-2.6.17-ming/fs/ext3/balloc.c	2006-06-28 16:46:36.082315750 -0700
@@ -38,7 +38,6 @@
 
 
 #define in_range(b, first, len)	((b) >= (first) && (b) <= (first) + (len) - 1)
-
 struct ext3_group_desc * ext3_get_group_desc(struct super_block * sb,
 					     unsigned int block_group,
 					     struct buffer_head ** bh)
@@ -340,10 +339,7 @@ void ext3_free_blocks_sb(handle_t *handl
 
 do_more:
 	overflow = 0;
-	block_group = (block - le32_to_cpu(es->s_first_data_block)) /
-		      EXT3_BLOCKS_PER_GROUP(sb);
-	bit = (block - le32_to_cpu(es->s_first_data_block)) %
-		      EXT3_BLOCKS_PER_GROUP(sb);
+	ext3_get_group_no_and_offset(sb, block, &block_group, &bit);
 	/*
 	 * Check to see if we are freeing blocks across a group
 	 * boundary.
@@ -1205,7 +1201,7 @@ ext3_fsblk_t ext3_new_blocks(handle_t *h
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *gdp_bh;
-	int group_no;
+	unsigned long group_no;
 	int goal_group;
 	ext3_grpblk_t grp_target_blk;	/* blockgroup relative goal block */
 	ext3_grpblk_t grp_alloc_blk;	/* blockgroup-relative allocated block*/
@@ -1268,8 +1264,7 @@ ext3_fsblk_t ext3_new_blocks(handle_t *h
 	if (goal < le32_to_cpu(es->s_first_data_block) ||
 	    goal >= le32_to_cpu(es->s_blocks_count))
 		goal = le32_to_cpu(es->s_first_data_block);
-	group_no = (goal - le32_to_cpu(es->s_first_data_block)) /
-			EXT3_BLOCKS_PER_GROUP(sb);
+	ext3_get_group_no_and_offset(sb, goal, &group_no, &grp_target_blk);
 	gdp = ext3_get_group_desc(sb, group_no, &gdp_bh);
 	if (!gdp)
 		goto io_error;
@@ -1286,8 +1281,6 @@ retry:
 		my_rsv = NULL;
 
 	if (free_blocks > 0) {
-		grp_target_blk = ((goal - le32_to_cpu(es->s_first_data_block)) %
-				EXT3_BLOCKS_PER_GROUP(sb));
 		bitmap_bh = read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
 			goto io_error;
@@ -1414,7 +1407,7 @@ allocated:
 	if (ret_block + num - 1 >= le32_to_cpu(es->s_blocks_count)) {
 		ext3_error(sb, "ext3_new_block",
 			    "block("E3FSBLK") >= blocks count(%d) - "
-			    "block_group = %d, es == %p ", ret_block,
+			    "block_group = %lu, es == %p ", ret_block,
 			le32_to_cpu(es->s_blocks_count), group_no, es);
 		goto out;
 	}
@@ -1528,9 +1521,10 @@ ext3_fsblk_t ext3_count_free_blocks(stru
 static inline int
 block_in_use(ext3_fsblk_t block, struct super_block *sb, unsigned char *map)
 {
-	return ext3_test_bit ((block -
-		le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block)) %
-			 EXT3_BLOCKS_PER_GROUP(sb), map);
+	ext3_grpblk_t offset;
+
+	ext3_get_group_no_and_offset(sb, block, NULL, &offset);
+	return ext3_test_bit (offset, map);
 }
 
 static inline int test_root(int a, int b)
diff -puN fs/ext3/ialloc.c~ext3_fsblk_sector_t fs/ext3/ialloc.c
--- linux-2.6.17/fs/ext3/ialloc.c~ext3_fsblk_sector_t	2006-06-28 16:46:36.060318274 -0700
+++ linux-2.6.17-ming/fs/ext3/ialloc.c	2006-06-28 16:46:36.084315520 -0700
@@ -23,7 +23,7 @@
 #include <linux/buffer_head.h>
 #include <linux/random.h>
 #include <linux/bitops.h>
-
+#include <linux/blkdev.h>
 #include <asm/byteorder.h>
 
 #include "xattr.h"
@@ -274,7 +274,8 @@ static int find_group_orlov(struct super
 	freei = percpu_counter_read_positive(&sbi->s_freeinodes_counter);
 	avefreei = freei / ngroups;
 	freeb = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
-	avefreeb = freeb / ngroups;
+	avefreeb = freeb;
+	sector_div(avefreeb, ngroups);
 	ndirs = percpu_counter_read_positive(&sbi->s_dirs_counter);
 
 	if ((parent == sb->s_root->d_inode) ||
@@ -303,13 +304,15 @@ static int find_group_orlov(struct super
 		goto fallback;
 	}
 
-	blocks_per_dir = (le32_to_cpu(es->s_blocks_count) - freeb) / ndirs;
+	blocks_per_dir = le32_to_cpu(es->s_blocks_count) - freeb;
+	sector_div(blocks_per_dir, ndirs);
 
 	max_dirs = ndirs / ngroups + inodes_per_group / 16;
 	min_inodes = avefreei - inodes_per_group / 4;
 	min_blocks = avefreeb - EXT3_BLOCKS_PER_GROUP(sb) / 4;
 
-	max_debt = EXT3_BLOCKS_PER_GROUP(sb) / max(blocks_per_dir, (ext3_fsblk_t)BLOCK_COST);
+	max_debt = EXT3_BLOCKS_PER_GROUP(sb);
+	sector_div(max_debt, max(blocks_per_dir, (ext3_fsblk_t)BLOCK_COST));
 	if (max_debt * INODE_COST > inodes_per_group)
 		max_debt = inodes_per_group / INODE_COST;
 	if (max_debt > 255)
diff -puN fs/ext3/resize.c~ext3_fsblk_sector_t fs/ext3/resize.c
--- linux-2.6.17/fs/ext3/resize.c~ext3_fsblk_sector_t	2006-06-28 16:46:36.065317700 -0700
+++ linux-2.6.17-ming/fs/ext3/resize.c	2006-06-28 16:46:36.086315291 -0700
@@ -15,7 +15,6 @@
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
 #include <linux/ext3_jbd.h>
-
 #include <linux/errno.h>
 #include <linux/slab.h>
 
@@ -37,7 +36,7 @@ static int verify_group_input(struct sup
 		 le16_to_cpu(es->s_reserved_gdt_blocks)) : 0;
 	ext3_fsblk_t metaend = start + overhead;
 	struct buffer_head *bh = NULL;
-	ext3_grpblk_t free_blocks_count;
+	ext3_grpblk_t free_blocks_count, offset;
 	int err = -EINVAL;
 
 	input->free_blocks_count = free_blocks_count =
@@ -50,13 +49,13 @@ static int verify_group_input(struct sup
 		       "no-super", input->group, input->blocks_count,
 		       free_blocks_count, input->reserved_blocks);
 
+	ext3_get_group_no_and_offset(sb, start, NULL, &offset);
 	if (group != sbi->s_groups_count)
 		ext3_warning(sb, __FUNCTION__,
 			     "Cannot add at group %u (only %lu groups)",
 			     input->group, sbi->s_groups_count);
-	else if ((start - le32_to_cpu(es->s_first_data_block)) %
-		 EXT3_BLOCKS_PER_GROUP(sb))
-		ext3_warning(sb, __FUNCTION__, "Last group not full");
+	else if (offset != 0)
+			ext3_warning(sb, __FUNCTION__, "Last group not full");
 	else if (input->reserved_blocks > input->blocks_count / 5)
 		ext3_warning(sb, __FUNCTION__, "Reserved blocks too high (%u)",
 			     input->reserved_blocks);
@@ -933,7 +932,7 @@ int ext3_group_extend(struct super_block
 
 	if (n_blocks_count > (sector_t)(~0ULL) >> (sb->s_blocksize_bits - 9)) {
 		printk(KERN_ERR "EXT3-fs: filesystem on %s:"
-			" too large to resize to %lu blocks safely\n",
+			" too large to resize to "E3FSBLK" blocks safely\n",
 			sb->s_id, n_blocks_count);
 		if (sizeof(sector_t) < 8)
 			ext3_warning(sb, __FUNCTION__,
@@ -948,8 +947,7 @@ int ext3_group_extend(struct super_block
 	}
 
 	/* Handle the remaining blocks in the last group only. */
-	last = (o_blocks_count - le32_to_cpu(es->s_first_data_block)) %
-		EXT3_BLOCKS_PER_GROUP(sb);
+	ext3_get_group_no_and_offset(sb, o_blocks_count, NULL, &last);
 
 	if (last == 0) {
 		ext3_warning(sb, __FUNCTION__,
diff -puN fs/ext3/super.c~ext3_fsblk_sector_t fs/ext3/super.c
--- linux-2.6.17/fs/ext3/super.c~ext3_fsblk_sector_t	2006-06-28 16:46:36.069317241 -0700
+++ linux-2.6.17-ming/fs/ext3/super.c	2006-06-28 16:46:36.090314832 -0700
@@ -1388,8 +1388,8 @@ static int ext3_fill_super (struct super
 	 * block sizes.  We need to calculate the offset from buffer start.
 	 */
 	if (blocksize != EXT3_MIN_BLOCK_SIZE) {
-		logic_sb_block = (sb_block * EXT3_MIN_BLOCK_SIZE) / blocksize;
-		offset = (sb_block * EXT3_MIN_BLOCK_SIZE) % blocksize;
+		logic_sb_block = sb_block * EXT3_MIN_BLOCK_SIZE;
+		offset = sector_div(logic_sb_block, blocksize);
 	} else {
 		logic_sb_block = sb_block;
 	}
@@ -1494,8 +1494,8 @@ static int ext3_fill_super (struct super
 
 		brelse (bh);
 		sb_set_blocksize(sb, blocksize);
-		logic_sb_block = (sb_block * EXT3_MIN_BLOCK_SIZE) / blocksize;
-		offset = (sb_block * EXT3_MIN_BLOCK_SIZE) % blocksize;
+		logic_sb_block = sb_block * EXT3_MIN_BLOCK_SIZE;
+		offset = sector_div(logic_sb_block, blocksize);
 		bh = sb_bread(sb, logic_sb_block);
 		if (!bh) {
 			printk(KERN_ERR 
diff -puN include/linux/ext3_fs.h~ext3_fsblk_sector_t include/linux/ext3_fs.h
--- linux-2.6.17/include/linux/ext3_fs.h~ext3_fsblk_sector_t	2006-06-28 16:46:36.073316783 -0700
+++ linux-2.6.17-ming/include/linux/ext3_fs.h	2006-06-28 16:46:36.092314603 -0700
@@ -17,6 +17,7 @@
 #define _LINUX_EXT3_FS_H
 
 #include <linux/types.h>
+#include <linux/blkdev.h>
 
 /*
  * The second extended filesystem constants/structures
@@ -728,6 +729,27 @@ ext3_group_first_block_no(struct super_b
 #define ERR_BAD_DX_DIR	-75000
 
 /*
+ * This function calculate the block group number and offset,
+ * given a block number
+ */
+
+static inline void ext3_get_group_no_and_offset(struct super_block * sb,
+                                ext3_fsblk_t blocknr, unsigned long* blockgrpp,
+                                ext3_grpblk_t *offsetp)
+{
+        struct ext3_super_block *es = EXT3_SB(sb)->s_es;
+	ext3_grpblk_t offset;
+
+        blocknr = blocknr - le32_to_cpu(es->s_first_data_block);
+        offset = sector_div(blocknr, EXT3_BLOCKS_PER_GROUP(sb));
+	if (offsetp)
+		*offsetp = offset;
+	if (blockgrpp)
+	        *blockgrpp = blocknr;
+
+}
+
+/*
  * Function prototypes
  */
 
@@ -740,6 +762,10 @@ ext3_group_first_block_no(struct super_b
 # define NORET_AND     noreturn,
 
 /* balloc.c */
+extern unsigned int ext3_block_group(struct super_block *sb,
+			ext3_fsblk_t blocknr);
+extern ext3_grpblk_t ext3_block_group_offset(struct super_block *sb,
+			ext3_fsblk_t blocknr);
 extern int ext3_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext3_bg_num_gdb(struct super_block *sb, int group);
 extern ext3_fsblk_t ext3_new_block (handle_t *handle, struct inode *inode,
diff -puN include/linux/ext3_fs_i.h~ext3_fsblk_sector_t include/linux/ext3_fs_i.h
--- linux-2.6.17/include/linux/ext3_fs_i.h~ext3_fsblk_sector_t	2006-06-28 16:46:36.077316324 -0700
+++ linux-2.6.17-ming/include/linux/ext3_fs_i.h	2006-06-28 16:46:36.093314488 -0700
@@ -25,9 +25,9 @@
 typedef int ext3_grpblk_t;
 
 /* data type for filesystem-wide blocks number */
-typedef unsigned long ext3_fsblk_t;
+typedef sector_t ext3_fsblk_t;
 
-#define E3FSBLK "%lu"
+#define E3FSBLK SECTOR_FMT
 
 struct ext3_reserve_window {
 	ext3_fsblk_t	_rsv_start;	/* First byte reserved */

_


