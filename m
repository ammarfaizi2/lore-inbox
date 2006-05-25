Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965133AbWEYMrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbWEYMrT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbWEYMrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:47:19 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:61607 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965133AbWEYMrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:47:17 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][10/24]ext3 modify variables to exceed 2G
Message-Id: <20060525214709sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:47:09 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [10/24]  change the type of variables manipulating a block or an
          inode(ext3)
          - Change the type of 4byte variables manipulating a block or
            an inode from signed to unsigned.

          - Where an overflow occurs in process of operation, casting
            it to long long.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/balloc.c linux-2.6.17-rc4.tmp/fs/ext3/balloc.c
--- linux-2.6.17-rc4/fs/ext3/balloc.c	2006-05-25 16:31:37.086660589 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/balloc.c	2006-05-25 16:33:10.304432884 +0900
@@ -1135,7 +1135,7 @@ ext3_try_to_allocate_with_rsv(struct sup
 			try_to_extend_reservation(my_rsv, sb,
 					*count-my_rsv->rsv_end + goal - 1);
 
-		if ((my_rsv->rsv_start >= group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
+		if ((my_rsv->rsv_start >= (unsigned long long)group_first_block + EXT3_BLOCKS_PER_GROUP(sb))
 		    || (my_rsv->rsv_end < group_first_block))
 			BUG();
 		ret = ext3_try_to_allocate(sb, handle, group, bitmap_bh, goal,
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/ialloc.c linux-2.6.17-rc4.tmp/fs/ext3/ialloc.c
--- linux-2.6.17-rc4/fs/ext3/ialloc.c	2006-05-25 16:30:41.544669082 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/ialloc.c	2006-05-25 16:33:10.305409447 +0900
@@ -202,7 +202,8 @@ error_return:
 static int find_group_dir(struct super_block *sb, struct inode *parent)
 {
 	int ngroups = EXT3_SB(sb)->s_groups_count;
-	int freei, avefreei;
+	unsigned long freei;
+	int avefreei;
 	struct ext3_group_desc *desc, *best_desc = NULL;
 	struct buffer_head *bh;
 	int group, best_group = -1;
@@ -261,9 +262,9 @@ static int find_group_orlov(struct super
 	struct ext3_super_block *es = sbi->s_es;
 	int ngroups = sbi->s_groups_count;
 	int inodes_per_group = EXT3_INODES_PER_GROUP(sb);
-	int freei, avefreei;
-	unsigned long freeb, avefreeb;
-	int blocks_per_dir, ndirs;
+	int avefreei;
+	unsigned long freeb, avefreeb, freei, ndirs;
+	int blocks_per_dir;
 	int max_debt, max_dirs, min_blocks, min_inodes;
 	int group = -1, i;
 	struct ext3_group_desc *desc;
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/inode.c linux-2.6.17-rc4.tmp/fs/ext3/inode.c
--- linux-2.6.17-rc4/fs/ext3/inode.c	2006-05-25 16:31:37.088613714 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/inode.c	2006-05-25 16:33:10.307362572 +0900
@@ -284,7 +284,7 @@ static int verify_chain(Indirect *from, 
  */
 
 static int ext3_block_to_path(struct inode *inode,
-			long i_block, int offsets[4], int *boundary)
+			unsigned long i_block, int offsets[4], int *boundary)
 {
 	int ptrs = EXT3_ADDR_PER_BLOCK(inode->i_sb);
 	int ptrs_bits = EXT3_ADDR_PER_BLOCK_BITS(inode->i_sb);
@@ -448,7 +448,7 @@ static unsigned long ext3_find_near(stru
  *	stores it in *@goal and returns zero.
  */
 
-static unsigned long ext3_find_goal(struct inode *inode, long block,
+static unsigned long ext3_find_goal(struct inode *inode, unsigned long block,
 		Indirect chain[4], Indirect *partial)
 {
 	struct ext3_block_alloc_info *block_i;
@@ -515,7 +515,7 @@ static int ext3_blks_to_allocate(Indirec
  *	@blks:	on return it will store the total number of allocated
  *		direct blocks
  */
-static int ext3_alloc_blocks(handle_t *handle, struct inode *inode,
+static unsigned int ext3_alloc_blocks(handle_t *handle, struct inode *inode,
 			unsigned long goal, int indirect_blks, int blks,
 			unsigned long long new_blocks[4], int *err)
 {
@@ -599,7 +599,7 @@ static int ext3_alloc_branch(handle_t *h
 	int i, n = 0;
 	int err = 0;
 	struct buffer_head *bh;
-	int num;
+	unsigned int num;
 	unsigned long long new_blocks[4];
 	unsigned long long current_block;
 
@@ -683,7 +683,7 @@ failed:
  * chain to new block and return 0.
  */
 static int ext3_splice_branch(handle_t *handle, struct inode *inode,
-			long block, Indirect *where, int num, int blks)
+			unsigned long block, Indirect *where, int num, int blks)
 {
 	int i;
 	int err = 0;
@@ -998,7 +998,7 @@ get_block:
  * `handle' can be NULL if create is zero
  */
 struct buffer_head *ext3_getblk(handle_t *handle, struct inode *inode,
-				long block, int create, int *errp)
+				unsigned long block, int create, int *errp)
 {
 	struct buffer_head dummy;
 	int fatal = 0, err;
@@ -1062,7 +1062,7 @@ err:
 }
 
 struct buffer_head *ext3_bread(handle_t *handle, struct inode *inode,
-			       int block, int create, int *err)
+			       unsigned int block, int create, int *err)
 {
 	struct buffer_head * bh;
 
@@ -2234,7 +2234,7 @@ void ext3_truncate(struct inode *inode)
 	Indirect *partial;
 	__le32 nr = 0;
 	int n;
-	long last_block;
+	unsigned long last_block;
 	unsigned blocksize = inode->i_sb->s_blocksize;
 	struct page *page;
 
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/namei.c linux-2.6.17-rc4.tmp/fs/ext3/namei.c
--- linux-2.6.17-rc4/fs/ext3/namei.c	2006-05-25 16:31:37.089590276 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/namei.c	2006-05-25 16:33:10.308339134 +0900
@@ -816,7 +816,8 @@ static struct buffer_head * ext3_find_en
 	int ra_ptr = 0;		/* Current index into readahead
 				   buffer */
 	int num = 0;
-	int nblocks, i, err;
+	unsigned int nblocks;
+	int i, err;
 	struct inode *dir = dentry->d_parent->d_inode;
 	int namelen;
 	const u8 *name;
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/resize.c linux-2.6.17-rc4.tmp/fs/ext3/resize.c
--- linux-2.6.17-rc4/fs/ext3/resize.c	2006-05-25 16:31:37.090566839 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/resize.c	2006-05-25 16:33:10.309315697 +0900
@@ -37,7 +37,7 @@ static int verify_group_input(struct sup
 		 le16_to_cpu(es->s_reserved_gdt_blocks)) : 0;
 	unsigned metaend = start + overhead;
 	struct buffer_head *bh = NULL;
-	int free_blocks_count;
+	long long free_blocks_count;
 	int err = -EINVAL;
 
 	input->free_blocks_count = free_blocks_count =
@@ -138,9 +138,9 @@ static struct buffer_head *bclean(handle
  * need to use it within a single byte (to ensure we get endianness right).
  * We can use memset for the rest of the bitmap as there are no other users.
  */
-static void mark_bitmap_end(int start_bit, int end_bit, char *bitmap)
+static void mark_bitmap_end(unsigned int start_bit, unsigned int end_bit, char *bitmap)
 {
-	int i;
+	unsigned int i;
 
 	if (start_bit >= end_bit)
 		return;
@@ -619,7 +619,7 @@ exit_free:
  * at this time.  The resize which changed s_groups_count will backup again.
  */
 static void update_backups(struct super_block *sb,
-			   int blk_off, char *data, int size)
+			   unsigned int blk_off, char *data, int size)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	const unsigned long last = sbi->s_groups_count;
@@ -726,6 +726,18 @@ int ext3_group_add(struct super_block *s
 		return -EPERM;
 	}
 
+	if (((unsigned long long)es->s_blocks_count + input->blocks_count) > ~0U) {
+		ext3_warning(sb, __FUNCTION__,
+			     "blocks_count must be less than 4G!");  
+		return -EPERM;
+	}
+
+	if (((unsigned long long)es->s_inodes_count + EXT3_INODES_PER_GROUP(sb)) > ~0U) {
+		ext3_warning(sb, __FUNCTION__,
+			     "inodes_count must be less than 4G!");
+		return -EPERM;
+	}
+
 	if (reserved_gdb || gdb_off == 0) {
 		if (!EXT3_HAS_COMPAT_FEATURE(sb,
 					     EXT3_FEATURE_COMPAT_RESIZE_INODE)){
@@ -944,6 +956,12 @@ int ext3_group_extend(struct super_block
 
 	add = EXT3_BLOCKS_PER_GROUP(sb) - last;
 
+	if (((unsigned long long)o_blocks_count + add) > ~0U) {
+		ext3_warning(sb, __FUNCTION__,
+			     "blocks_count must be less than 4G!");
+		return -EPERM;
+	}
+
 	if (o_blocks_count + add > n_blocks_count)
 		add = n_blocks_count - o_blocks_count;
 
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/super.c linux-2.6.17-rc4.tmp/fs/ext3/super.c
--- linux-2.6.17-rc4/fs/ext3/super.c	2006-05-25 16:31:37.092519964 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/super.c	2006-05-25 16:33:10.311268822 +0900
@@ -38,6 +38,7 @@
 #include <linux/seq_file.h>
 
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 #include "xattr.h"
 #include "acl.h"
@@ -1141,7 +1142,7 @@ static int ext3_check_descriptors (struc
 					sbi->s_group_desc[desc_block++]->b_data;
 		if (le32_to_cpu(gdp->bg_block_bitmap) < block ||
 		    le32_to_cpu(gdp->bg_block_bitmap) >=
-				block + EXT3_BLOCKS_PER_GROUP(sb))
+				(unsigned long long)block + EXT3_BLOCKS_PER_GROUP(sb))
 		{
 			ext3_error (sb, "ext3_check_descriptors",
 				    "Block bitmap for group %d"
@@ -1152,7 +1153,7 @@ static int ext3_check_descriptors (struc
 		}
 		if (le32_to_cpu(gdp->bg_inode_bitmap) < block ||
 		    le32_to_cpu(gdp->bg_inode_bitmap) >=
-				block + EXT3_BLOCKS_PER_GROUP(sb))
+				(unsigned long long)block + EXT3_BLOCKS_PER_GROUP(sb))
 		{
 			ext3_error (sb, "ext3_check_descriptors",
 				    "Inode bitmap for group %d"
@@ -1163,7 +1164,7 @@ static int ext3_check_descriptors (struc
 		}
 		if (le32_to_cpu(gdp->bg_inode_table) < block ||
 		    le32_to_cpu(gdp->bg_inode_table) + sbi->s_itb_per_group >=
-		    block + EXT3_BLOCKS_PER_GROUP(sb))
+		    (unsigned long long)block + EXT3_BLOCKS_PER_GROUP(sb))
 		{
 			ext3_error (sb, "ext3_check_descriptors",
 				    "Inode table for group %d"
@@ -1354,6 +1355,7 @@ static int ext3_fill_super (struct super
 	int i;
 	int needs_recovery;
 	__le32 features;
+	unsigned long long tmp_blocks;
 
 	sbi = kmalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
@@ -1566,10 +1568,11 @@ static int ext3_fill_super (struct super
 
 	if (EXT3_BLOCKS_PER_GROUP(sb) == 0)
 		goto cantfind_ext3;
-	sbi->s_groups_count = (le32_to_cpu(es->s_blocks_count) -
-			       le32_to_cpu(es->s_first_data_block) +
-			       EXT3_BLOCKS_PER_GROUP(sb) - 1) /
-			      EXT3_BLOCKS_PER_GROUP(sb);
+	tmp_blocks = (le32_to_cpu(es->s_blocks_count) -
+		      le32_to_cpu(es->s_first_data_block) +
+		      (unsigned long long)EXT3_BLOCKS_PER_GROUP(sb) - 1);
+	do_div(tmp_blocks, EXT3_BLOCKS_PER_GROUP(sb));
+	sbi->s_groups_count = tmp_blocks;
 	db_count = (sbi->s_groups_count + EXT3_DESC_PER_BLOCK(sb) - 1) /
 		   EXT3_DESC_PER_BLOCK(sb);
 	sbi->s_group_desc = kmalloc(db_count * sizeof (struct buffer_head *),
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/include/linux/ext3_fs.h linux-2.6.17-rc4.tmp/include/linux/ext3_fs.h
--- linux-2.6.17-rc4/include/linux/ext3_fs.h	2006-05-25 16:30:19.458731852 +0900
+++ linux-2.6.17-rc4.tmp/include/linux/ext3_fs.h	2006-05-25 16:33:10.312245384 +0900
@@ -776,8 +776,8 @@ extern unsigned long ext3_count_free (st
 
 /* inode.c */
 int ext3_forget(handle_t *, int, struct inode *, struct buffer_head *, unsigned long);
-struct buffer_head * ext3_getblk (handle_t *, struct inode *, long, int, int *);
-struct buffer_head * ext3_bread (handle_t *, struct inode *, int, int, int *);
+struct buffer_head * ext3_getblk (handle_t *, struct inode *, unsigned long, int, int *);
+struct buffer_head * ext3_bread (handle_t *, struct inode *, unsigned int, int, int *);
 int ext3_get_blocks_handle(handle_t *handle, struct inode *inode,
 	sector_t iblock, unsigned long maxblocks, struct buffer_head *bh_result,
 	int create, int extend_disksize);



