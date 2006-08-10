Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWHJBVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWHJBVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030529AbWHJBVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:21:19 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:4020 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751438AbWHJBVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:21:15 -0400
Subject: [PATCH 3/9] support >32 bit ext4 filesystem block type in kernel
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 09 Aug 2006 18:21:00 -0700
Message-Id: <1155172860.3161.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Redefine ext4 in-kernel filesystem block type (ext4_fsblk_t) from unsigned
long to sector_t, to allow kernel to handle  >32 bit ext4 blocks.

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.18-rc4-ming/fs/ext4/balloc.c          |   22 +++++++-------------
 linux-2.6.18-rc4-ming/fs/ext4/ialloc.c          |   11 ++++++----
 linux-2.6.18-rc4-ming/fs/ext4/resize.c          |   13 +++++-------
 linux-2.6.18-rc4-ming/fs/ext4/super.c           |    8 +++----
 linux-2.6.18-rc4-ming/include/linux/ext4_fs.h   |   26 ++++++++++++++++++++++++
 linux-2.6.18-rc4-ming/include/linux/ext4_fs_i.h |    4 +--
 6 files changed, 53 insertions(+), 31 deletions(-)

diff -puN fs/ext4/balloc.c~ext4_fsblk_sector_t fs/ext4/balloc.c
--- linux-2.6.18-rc4/fs/ext4/balloc.c~ext4_fsblk_sector_t	2006-08-09 15:41:51.530285904 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/balloc.c	2006-08-09 15:41:51.553286090 -0700
@@ -37,7 +37,6 @@
 

 #define in_range(b, first, len)	((b) >= (first) && (b) <= (first) + (len) - 1)
-
 struct ext4_group_desc * ext4_get_group_desc(struct super_block * sb,
 					     unsigned int block_group,
 					     struct buffer_head ** bh)
@@ -339,10 +338,7 @@ void ext4_free_blocks_sb(handle_t *handl
 
 do_more:
 	overflow = 0;
-	block_group = (block - le32_to_cpu(es->s_first_data_block)) /
-		      EXT4_BLOCKS_PER_GROUP(sb);
-	bit = (block - le32_to_cpu(es->s_first_data_block)) %
-		      EXT4_BLOCKS_PER_GROUP(sb);
+	ext4_get_group_no_and_offset(sb, block, &block_group, &bit);
 	/*
 	 * Check to see if we are freeing blocks across a group
 	 * boundary.
@@ -1204,7 +1200,7 @@ ext4_fsblk_t ext4_new_blocks(handle_t *h
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *gdp_bh;
-	int group_no;
+	unsigned long group_no;
 	int goal_group;
 	ext4_grpblk_t grp_target_blk;	/* blockgroup relative goal block */
 	ext4_grpblk_t grp_alloc_blk;	/* blockgroup-relative allocated block*/
@@ -1267,8 +1263,7 @@ ext4_fsblk_t ext4_new_blocks(handle_t *h
 	if (goal < le32_to_cpu(es->s_first_data_block) ||
 	    goal >= le32_to_cpu(es->s_blocks_count))
 		goal = le32_to_cpu(es->s_first_data_block);
-	group_no = (goal - le32_to_cpu(es->s_first_data_block)) /
-			EXT4_BLOCKS_PER_GROUP(sb);
+	ext4_get_group_no_and_offset(sb, goal, &group_no, &grp_target_blk);
 	gdp = ext4_get_group_desc(sb, group_no, &gdp_bh);
 	if (!gdp)
 		goto io_error;
@@ -1285,8 +1280,6 @@ retry:
 		my_rsv = NULL;
 
 	if (free_blocks > 0) {
-		grp_target_blk = ((goal - le32_to_cpu(es->s_first_data_block)) %
-				EXT4_BLOCKS_PER_GROUP(sb));
 		bitmap_bh = read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
 			goto io_error;
@@ -1413,7 +1406,7 @@ allocated:
 	if (ret_block + num - 1 >= le32_to_cpu(es->s_blocks_count)) {
 		ext4_error(sb, "ext4_new_block",
 			    "block("E3FSBLK") >= blocks count(%d) - "
-			    "block_group = %d, es == %p ", ret_block,
+			    "block_group = %lu, es == %p ", ret_block,
 			le32_to_cpu(es->s_blocks_count), group_no, es);
 		goto out;
 	}
@@ -1527,9 +1520,10 @@ ext4_fsblk_t ext4_count_free_blocks(stru
 static inline int
 block_in_use(ext4_fsblk_t block, struct super_block *sb, unsigned char *map)
 {
-	return ext4_test_bit ((block -
-		le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block)) %
-			 EXT4_BLOCKS_PER_GROUP(sb), map);
+	ext4_grpblk_t offset;
+
+	ext4_get_group_no_and_offset(sb, block, NULL, &offset);
+	return ext4_test_bit (offset, map);
 }
 
 static inline int test_root(int a, int b)
diff -puN fs/ext4/ialloc.c~ext4_fsblk_sector_t fs/ext4/ialloc.c
--- linux-2.6.18-rc4/fs/ext4/ialloc.c~ext4_fsblk_sector_t	2006-08-09 15:41:51.533285928 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/ialloc.c	2006-08-09 15:41:51.554286098 -0700
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
 	min_blocks = avefreeb - EXT4_BLOCKS_PER_GROUP(sb) / 4;
 
-	max_debt = EXT4_BLOCKS_PER_GROUP(sb) / max(blocks_per_dir, (ext4_fsblk_t)BLOCK_COST);
+	max_debt = EXT4_BLOCKS_PER_GROUP(sb);
+	sector_div(max_debt, max(blocks_per_dir, (ext4_fsblk_t)BLOCK_COST));
 	if (max_debt * INODE_COST > inodes_per_group)
 		max_debt = inodes_per_group / INODE_COST;
 	if (max_debt > 255)
diff -puN fs/ext4/resize.c~ext4_fsblk_sector_t fs/ext4/resize.c
--- linux-2.6.18-rc4/fs/ext4/resize.c~ext4_fsblk_sector_t	2006-08-09 15:41:51.536285953 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/resize.c	2006-08-09 15:41:51.556286115 -0700
@@ -36,7 +36,7 @@ static int verify_group_input(struct sup
 		 le16_to_cpu(es->s_reserved_gdt_blocks)) : 0;
 	ext4_fsblk_t metaend = start + overhead;
 	struct buffer_head *bh = NULL;
-	ext4_grpblk_t free_blocks_count;
+	ext4_grpblk_t free_blocks_count, offset;
 	int err = -EINVAL;
 
 	input->free_blocks_count = free_blocks_count =
@@ -49,13 +49,13 @@ static int verify_group_input(struct sup
 		       "no-super", input->group, input->blocks_count,
 		       free_blocks_count, input->reserved_blocks);
 
+	ext4_get_group_no_and_offset(sb, start, NULL, &offset);
 	if (group != sbi->s_groups_count)
 		ext4_warning(sb, __FUNCTION__,
 			     "Cannot add at group %u (only %lu groups)",
 			     input->group, sbi->s_groups_count);
-	else if ((start - le32_to_cpu(es->s_first_data_block)) %
-		 EXT4_BLOCKS_PER_GROUP(sb))
-		ext4_warning(sb, __FUNCTION__, "Last group not full");
+	else if (offset != 0)
+			ext4_warning(sb, __FUNCTION__, "Last group not full");
 	else if (input->reserved_blocks > input->blocks_count / 5)
 		ext4_warning(sb, __FUNCTION__, "Reserved blocks too high (%u)",
 			     input->reserved_blocks);
@@ -932,7 +932,7 @@ int ext4_group_extend(struct super_block
 
 	if (n_blocks_count > (sector_t)(~0ULL) >> (sb->s_blocksize_bits - 9)) {
 		printk(KERN_ERR "EXT4-fs: filesystem on %s:"
-			" too large to resize to %lu blocks safely\n",
+			" too large to resize to "E3FSBLK" blocks safely\n",
 			sb->s_id, n_blocks_count);
 		if (sizeof(sector_t) < 8)
 			ext4_warning(sb, __FUNCTION__,
@@ -947,8 +947,7 @@ int ext4_group_extend(struct super_block
 	}
 
 	/* Handle the remaining blocks in the last group only. */
-	last = (o_blocks_count - le32_to_cpu(es->s_first_data_block)) %
-		EXT4_BLOCKS_PER_GROUP(sb);
+	ext4_get_group_no_and_offset(sb, o_blocks_count, NULL, &last);
 
 	if (last == 0) {
 		ext4_warning(sb, __FUNCTION__,
diff -puN fs/ext4/super.c~ext4_fsblk_sector_t fs/ext4/super.c
--- linux-2.6.18-rc4/fs/ext4/super.c~ext4_fsblk_sector_t	2006-08-09 15:41:51.541285993 -0700
+++ linux-2.6.18-rc4-ming/fs/ext4/super.c	2006-08-09 15:41:51.560286147 -0700
@@ -1387,8 +1387,8 @@ static int ext4_fill_super (struct super
 	 * block sizes.  We need to calculate the offset from buffer start.
 	 */
 	if (blocksize != EXT4_MIN_BLOCK_SIZE) {
-		logic_sb_block = (sb_block * EXT4_MIN_BLOCK_SIZE) / blocksize;
-		offset = (sb_block * EXT4_MIN_BLOCK_SIZE) % blocksize;
+		logic_sb_block = sb_block * EXT4_MIN_BLOCK_SIZE;
+		offset = sector_div(logic_sb_block, blocksize);
 	} else {
 		logic_sb_block = sb_block;
 	}
@@ -1493,8 +1493,8 @@ static int ext4_fill_super (struct super
 
 		brelse (bh);
 		sb_set_blocksize(sb, blocksize);
-		logic_sb_block = (sb_block * EXT4_MIN_BLOCK_SIZE) / blocksize;
-		offset = (sb_block * EXT4_MIN_BLOCK_SIZE) % blocksize;
+		logic_sb_block = sb_block * EXT4_MIN_BLOCK_SIZE;
+		offset = sector_div(logic_sb_block, blocksize);
 		bh = sb_bread(sb, logic_sb_block);
 		if (!bh) {
 			printk(KERN_ERR
diff -puN include/linux/ext4_fs.h~ext4_fsblk_sector_t include/linux/ext4_fs.h
--- linux-2.6.18-rc4/include/linux/ext4_fs.h~ext4_fsblk_sector_t	2006-08-09 15:41:51.544286018 -0700
+++ linux-2.6.18-rc4-ming/include/linux/ext4_fs.h	2006-08-09 15:41:51.564286179 -0700
@@ -17,6 +17,7 @@
 #define _LINUX_EXT4_FS_H
 
 #include <linux/types.h>
+#include <linux/blkdev.h>
 
 /*
  * The second extended filesystem constants/structures
@@ -728,6 +729,27 @@ ext4_group_first_block_no(struct super_b
 #define ERR_BAD_DX_DIR	-75000
 
 /*
+ * This function calculate the block group number and offset,
+ * given a block number
+ */
+
+static inline void ext4_get_group_no_and_offset(struct super_block * sb,
+                                ext4_fsblk_t blocknr, unsigned long* blockgrpp,
+                                ext4_grpblk_t *offsetp)
+{
+        struct ext4_super_block *es = EXT4_SB(sb)->s_es;
+	ext4_grpblk_t offset;
+
+        blocknr = blocknr - le32_to_cpu(es->s_first_data_block);
+        offset = sector_div(blocknr, EXT4_BLOCKS_PER_GROUP(sb));
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
 
@@ -740,6 +762,10 @@ ext4_group_first_block_no(struct super_b
 # define NORET_AND     noreturn,
 
 /* balloc.c */
+extern unsigned int ext4_block_group(struct super_block *sb,
+			ext4_fsblk_t blocknr);
+extern ext4_grpblk_t ext4_block_group_offset(struct super_block *sb,
+			ext4_fsblk_t blocknr);
 extern int ext4_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext4_bg_num_gdb(struct super_block *sb, int group);
 extern ext4_fsblk_t ext4_new_block (handle_t *handle, struct inode *inode,
diff -puN include/linux/ext4_fs_i.h~ext4_fsblk_sector_t include/linux/ext4_fs_i.h
--- linux-2.6.18-rc4/include/linux/ext4_fs_i.h~ext4_fsblk_sector_t	2006-08-09 15:41:51.548286050 -0700
+++ linux-2.6.18-rc4-ming/include/linux/ext4_fs_i.h	2006-08-09 15:41:51.564286179 -0700
@@ -25,9 +25,9 @@
 typedef int ext4_grpblk_t;
 
 /* data type for filesystem-wide blocks number */
-typedef unsigned long ext4_fsblk_t;
+typedef sector_t ext4_fsblk_t;
 
-#define E3FSBLK "%lu"
+#define E3FSBLK SECTOR_FMT
 
 struct ext4_reserve_window {
 	ext4_fsblk_t	_rsv_start;	/* First byte reserved */

_


