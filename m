Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbWEYMsj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbWEYMsj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbWEYMsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:48:39 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:62669 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965147AbWEYMsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:48:37 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][11/24]ext2 modify variables to exceed 2G
Message-Id: <20060525214830sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:48:30 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [11/24]  change the type of variables manipulating a block or an
           inode(ext2)
          - Change the type of 4byte variables manipulating a block or
            an inode from signed to unsigned.

          - Where an overflow occurs in process of operation, casting
            it to long long.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/balloc.c linux-2.6.17-rc4.tmp/fs/ext2/balloc.c
--- linux-2.6.17-rc4/fs/ext2/balloc.c	2006-05-25 16:31:59.468496252 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/balloc.c	2006-05-25 16:33:34.602284149 +0900
@@ -99,7 +99,7 @@ error_out:
  * Set sb->s_dirt here because the superblock was "logically" altered.  We
  * need to recalculate its free blocks count and flush it out.
  */
-static int reserve_blocks(struct super_block *sb, int count)
+static unsigned int reserve_blocks(struct super_block *sb, unsigned int count)
 {
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct ext2_super_block *es = sbi->s_es;
@@ -130,7 +130,7 @@ static int reserve_blocks(struct super_b
 	return count;
 }
 
-static void release_blocks(struct super_block *sb, int count)
+static void release_blocks(struct super_block *sb, unsigned int count)
 {
 	if (count) {
 		struct ext2_sb_info *sbi = EXT2_SB(sb);
@@ -140,8 +140,8 @@ static void release_blocks(struct super_
 	}
 }
 
-static int group_reserve_blocks(struct ext2_sb_info *sbi, int group_no,
-	struct ext2_group_desc *desc, struct buffer_head *bh, int count)
+static unsigned int group_reserve_blocks(struct ext2_sb_info *sbi, int group_no,
+	struct ext2_group_desc *desc, struct buffer_head *bh, unsigned int count)
 {
 	unsigned free_blocks;
 
@@ -159,7 +159,7 @@ static int group_reserve_blocks(struct e
 }
 
 static void group_release_blocks(struct super_block *sb, int group_no,
-	struct ext2_group_desc *desc, struct buffer_head *bh, int count)
+	struct ext2_group_desc *desc, struct buffer_head *bh, unsigned int count)
 {
 	if (count) {
 		struct ext2_sb_info *sbi = EXT2_SB(sb);
@@ -324,7 +324,7 @@ got_it:
  * bitmap, and then for any free bit if that fails.
  * This function also updates quota and i_blocks field.
  */
-int ext2_new_block(struct inode *inode, unsigned long goal,
+unsigned int ext2_new_block(struct inode *inode, unsigned long goal,
 			u32 *prealloc_count, u32 *prealloc_block, int *err)
 {
 	struct buffer_head *bitmap_bh = NULL;
@@ -333,8 +333,8 @@ int ext2_new_block(struct inode *inode, 
 	int group_no;			/* i */
 	int ret_block;			/* j */
 	int group_idx;			/* k */
-	int target_block;		/* tmp */
-	int block = 0;
+	unsigned int target_block;      /* tmp */
+	unsigned int block = 0;
 	struct super_block *sb = inode->i_sb;
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct ext2_super_block *es = sbi->s_es;
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/ext2.h linux-2.6.17-rc4.tmp/fs/ext2/ext2.h
--- linux-2.6.17-rc4/fs/ext2/ext2.h	2006-05-25 16:18:35.842529534 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/ext2.h	2006-05-25 16:33:34.602284149 +0900
@@ -91,7 +91,7 @@ static inline struct ext2_inode_info *EX
 /* balloc.c */
 extern int ext2_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
-extern int ext2_new_block (struct inode *, unsigned long,
+extern unsigned int ext2_new_block (struct inode *, unsigned long,
 			   __u32 *, __u32 *, int *);
 extern void ext2_free_blocks (struct inode *, unsigned long,
 			      unsigned long);
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/ialloc.c linux-2.6.17-rc4.tmp/fs/ext2/ialloc.c
--- linux-2.6.17-rc4/fs/ext2/ialloc.c	2006-05-25 16:31:09.390371866 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/ialloc.c	2006-05-25 16:33:34.603260712 +0900
@@ -276,12 +276,10 @@ static int find_group_orlov(struct super
 	struct ext2_super_block *es = sbi->s_es;
 	int ngroups = sbi->s_groups_count;
 	int inodes_per_group = EXT2_INODES_PER_GROUP(sb);
-	int freei;
+	unsigned long freei, free_blocks, ndirs;
 	int avefreei;
-	int free_blocks;
 	int avefreeb;
 	int blocks_per_dir;
-	int ndirs;
 	int max_debt, max_dirs, min_blocks, min_inodes;
 	int group = -1, i;
 	struct ext2_group_desc *desc;
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/inode.c linux-2.6.17-rc4.tmp/fs/ext2/inode.c
--- linux-2.6.17-rc4/fs/ext2/inode.c	2006-05-25 16:31:59.469472815 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/inode.c	2006-05-25 16:33:34.604237274 +0900
@@ -107,7 +107,7 @@ void ext2_discard_prealloc (struct inode
 #endif
 }
 
-static int ext2_alloc_block (struct inode * inode, unsigned long goal, int *err)
+static unsigned int ext2_alloc_block (struct inode * inode, unsigned long goal, int *err)
 {
 #ifdef EXT2FS_DEBUG
 	static unsigned long alloc_hits, alloc_attempts;
@@ -194,7 +194,7 @@ static inline int verify_chain(Indirect 
  */
 
 static int ext2_block_to_path(struct inode *inode,
-			long i_block, int offsets[4], int *boundary)
+			unsigned long i_block, int offsets[4], int *boundary)
 {
 	int ptrs = EXT2_ADDR_PER_BLOCK(inode->i_sb);
 	int ptrs_bits = EXT2_ADDR_PER_BLOCK_BITS(inode->i_sb);
@@ -363,7 +363,7 @@ static unsigned long ext2_find_near(stru
  */
 
 static inline int ext2_find_goal(struct inode *inode,
-				 long block,
+				 unsigned long block,
 				 Indirect chain[4],
 				 Indirect *partial,
 				 unsigned long *goal)
@@ -425,13 +425,13 @@ static int ext2_alloc_branch(struct inod
 	int n = 0;
 	int err;
 	int i;
-	int parent = ext2_alloc_block(inode, goal, &err);
+	unsigned int parent = ext2_alloc_block(inode, goal, &err);
 
 	branch[0].key = cpu_to_le32(parent);
 	if (parent) for (n = 1; n < num; n++) {
 		struct buffer_head *bh;
 		/* Allocate the next block */
-		int nr = ext2_alloc_block(inode, parent, &err);
+		unsigned int nr = ext2_alloc_block(inode, parent, &err);
 		if (!nr)
 			break;
 		branch[n].key = cpu_to_le32(nr);
@@ -489,7 +489,7 @@ static int ext2_alloc_branch(struct inod
  */
 
 static inline int ext2_splice_branch(struct inode *inode,
-				     long block,
+				     unsigned long block,
 				     Indirect chain[4],
 				     Indirect *where,
 				     int num)
@@ -905,7 +905,7 @@ void ext2_truncate (struct inode * inode
 	Indirect *partial;
 	__le32 nr = 0;
 	int n;
-	long iblock;
+	unsigned long iblock;
 	unsigned blocksize;
 
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/super.c linux-2.6.17-rc4.tmp/fs/ext2/super.c
--- linux-2.6.17-rc4/fs/ext2/super.c	2006-05-25 16:31:09.392324991 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/super.c	2006-05-25 16:33:34.605213837 +0900
@@ -31,6 +31,7 @@
 #include <linux/seq_file.h>
 #include <linux/mount.h>
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 #include "ext2.h"
 #include "xattr.h"
 #include "acl.h"
@@ -516,7 +517,7 @@ static int ext2_check_descriptors (struc
 		if ((i % EXT2_DESC_PER_BLOCK(sb)) == 0)
 			gdp = (struct ext2_group_desc *) sbi->s_group_desc[desc_block++]->b_data;
 		if (le32_to_cpu(gdp->bg_block_bitmap) < block ||
-		    le32_to_cpu(gdp->bg_block_bitmap) >= block + EXT2_BLOCKS_PER_GROUP(sb))
+		    le32_to_cpu(gdp->bg_block_bitmap) >= (unsigned long long)block + EXT2_BLOCKS_PER_GROUP(sb))
 		{
 			ext2_error (sb, "ext2_check_descriptors",
 				    "Block bitmap for group %d"
@@ -525,7 +526,7 @@ static int ext2_check_descriptors (struc
 			return 0;
 		}
 		if (le32_to_cpu(gdp->bg_inode_bitmap) < block ||
-		    le32_to_cpu(gdp->bg_inode_bitmap) >= block + EXT2_BLOCKS_PER_GROUP(sb))
+		    le32_to_cpu(gdp->bg_inode_bitmap) >= (unsigned long long)block + EXT2_BLOCKS_PER_GROUP(sb))
 		{
 			ext2_error (sb, "ext2_check_descriptors",
 				    "Inode bitmap for group %d"
@@ -535,7 +536,7 @@ static int ext2_check_descriptors (struc
 		}
 		if (le32_to_cpu(gdp->bg_inode_table) < block ||
 		    le32_to_cpu(gdp->bg_inode_table) + sbi->s_itb_per_group >=
-		    block + EXT2_BLOCKS_PER_GROUP(sb))
+		    (unsigned long long)block + EXT2_BLOCKS_PER_GROUP(sb))
 		{
 			ext2_error (sb, "ext2_check_descriptors",
 				    "Inode table for group %d"
@@ -609,6 +610,7 @@ static int ext2_fill_super(struct super_
 	int db_count;
 	int i, j;
 	__le32 features;
+	unsigned long long tmp_blocks;
 
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
@@ -823,10 +825,11 @@ static int ext2_fill_super(struct super_
 
 	if (EXT2_BLOCKS_PER_GROUP(sb) == 0)
 		goto cantfind_ext2;
-	sbi->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
-				        le32_to_cpu(es->s_first_data_block) +
-				       EXT2_BLOCKS_PER_GROUP(sb) - 1) /
-				       EXT2_BLOCKS_PER_GROUP(sb);
+	tmp_blocks = (le32_to_cpu(es->s_blocks_count) -
+		      le32_to_cpu(es->s_first_data_block) +
+		      (unsigned long long)EXT2_BLOCKS_PER_GROUP(sb) - 1);
+	do_div(tmp_blocks, EXT2_BLOCKS_PER_GROUP(sb));
+	sbi->s_groups_count = tmp_blocks;
 	db_count = (sbi->s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
 		   EXT2_DESC_PER_BLOCK(sb);
 	sbi->s_group_desc = kmalloc (db_count * sizeof (struct buffer_head *), GFP_KERNEL);
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/xattr.c linux-2.6.17-rc4.tmp/fs/ext2/xattr.c
--- linux-2.6.17-rc4/fs/ext2/xattr.c	2006-05-25 16:31:59.470449377 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/xattr.c	2006-05-25 16:33:34.606190399 +0900
@@ -664,11 +664,11 @@ ext2_xattr_set2(struct inode *inode, str
 			ext2_xattr_cache_insert(new_bh);
 		} else {
 			/* We need to allocate a new block */
-			int goal = le32_to_cpu(EXT2_SB(sb)->s_es->
+			unsigned int goal = le32_to_cpu(EXT2_SB(sb)->s_es->
 						           s_first_data_block) +
 				   EXT2_I(inode)->i_block_group *
 				   EXT2_BLOCKS_PER_GROUP(sb);
-			int block = ext2_new_block(inode, goal,
+			unsigned int block = ext2_new_block(inode, goal,
 						   NULL, NULL, &error);
 			if (error)
 				goto cleanup;
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext2/xip.c linux-2.6.17-rc4.tmp/fs/ext2/xip.c
--- linux-2.6.17-rc4/fs/ext2/xip.c	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext2/xip.c	2006-05-25 16:33:34.606190399 +0900
@@ -44,8 +44,8 @@ __ext2_get_sector(struct inode *inode, s
 	return rc;
 }
 
-int
-ext2_clear_xip_target(struct inode *inode, int block)
+unsigned int
+ext2_clear_xip_target(struct inode *inode, unsigned int block)
 {
 	sector_t sector = block * (PAGE_SIZE/512);
 	unsigned long data;



