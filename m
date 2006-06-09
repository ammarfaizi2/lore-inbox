Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbWFIBWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWFIBWJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 21:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWFIBWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 21:22:08 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:34524 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S965082AbWFIBWA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 21:22:00 -0400
Subject: [RFC 4/13] extents and 48bit ext3: convert ext3 filesystem blocks
	to ext3_fsblk_t
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 08 Jun 2006 18:21:58 -0700
Message-Id: <1149816118.4066.66.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert the rest of all unsigned long type in-kernel filesystem
blocks to ext3_fsblk_t, and replace the printk format string
respondingly.

Signed-Off-By: Mingming Cao <cmm@us.ibm.com>


---

 linux-2.6.16-ming/fs/ext3/balloc.c          |   29 ++++++--------
 linux-2.6.16-ming/fs/ext3/inode.c           |   55 ++++++++++++++--------------
 linux-2.6.16-ming/fs/ext3/ioctl.c           |    2 -
 linux-2.6.16-ming/fs/ext3/resize.c          |   34 +++++++++--------
 linux-2.6.16-ming/fs/ext3/super.c           |   33 ++++++++--------
 linux-2.6.16-ming/fs/ext3/xattr.c           |   12 +++---
 linux-2.6.16-ming/include/linux/ext3_fs.h   |   12 +++++-
 linux-2.6.16-ming/include/linux/ext3_fs_i.h |    8 ++--
 8 files changed, 97 insertions(+), 88 deletions(-)

diff -puN fs/ext3/balloc.c~ext3_convert_blks_to_fsblk_t fs/ext3/balloc.c
--- linux-2.6.16/fs/ext3/balloc.c~ext3_convert_blks_to_fsblk_t	2006-06-07 15:43:17.000000000 -0700
+++ linux-2.6.16-ming/fs/ext3/balloc.c	2006-06-08 16:49:57.494951296 -0700
@@ -168,8 +168,7 @@ goal_in_my_reservation(struct ext3_reser
 {
 	ext3_fsblk_t group_first_block, group_last_block;
 
-	group_first_block = le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) +
-				group * EXT3_BLOCKS_PER_GROUP(sb);
+	group_first_block = ext3_group_first_block_no(sb, group);
 	group_last_block = group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
 
 	if ((rsv->_rsv_start > group_last_block) ||
@@ -664,9 +663,7 @@ ext3_try_to_allocate(struct super_block 
 
 	/* we do allocation within the reservation window if we have a window */
 	if (my_rsv) {
-		group_first_block =
-			le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) +
-			group * EXT3_BLOCKS_PER_GROUP(sb);
+		group_first_block = ext3_group_first_block_no(sb, group);
 		if (my_rsv->_rsv_start >= group_first_block)
 			start = my_rsv->_rsv_start - group_first_block;
 		else
@@ -900,8 +897,7 @@ static int alloc_new_reservation(struct 
 	int ret;
 	spinlock_t *rsv_lock = &EXT3_SB(sb)->s_rsv_window_lock;
 
-	group_first_block = le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) +
-				group * EXT3_BLOCKS_PER_GROUP(sb);
+	group_first_block = ext3_group_first_block_no(sb, group);
 	group_end_block = group_first_block + EXT3_BLOCKS_PER_GROUP(sb) - 1;
 
 	if (grp_goal < 0)
@@ -1104,8 +1100,7 @@ ext3_try_to_allocate_with_rsv(struct sup
 	 * first block is a filesystem wide block number
 	 * first block is the block number of the first block in this group
 	 */
-	group_first_block = le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block) +
-			group * EXT3_BLOCKS_PER_GROUP(sb);
+	group_first_block = ext3_group_first_block_no(sb, group);
 
 	/*
 	 * Basically we will allocate a new block from inode's reservation
@@ -1371,8 +1366,7 @@ allocated:
 	if (fatal)
 		goto out;
 
-	ret_block = grp_alloc_blk + group_no * EXT3_BLOCKS_PER_GROUP(sb)
-				+ le32_to_cpu(es->s_first_data_block);
+	ret_block = grp_alloc_blk + ext3_group_first_block_no(sb, group_no);
 
 	if (in_range(le32_to_cpu(gdp->bg_block_bitmap), ret_block, num) ||
 	    in_range(le32_to_cpu(gdp->bg_inode_bitmap), ret_block, num) ||
@@ -1478,15 +1472,16 @@ ext3_fsblk_t ext3_new_block(handle_t *ha
 	return ext3_new_blocks(handle, inode, goal, &count, errp);
 }
 
-unsigned long ext3_count_free_blocks(struct super_block *sb)
+ext3_fsblk_t ext3_count_free_blocks(struct super_block *sb)
 {
-	unsigned long desc_count;
+	ext3_fsblk_t desc_count;
 	struct ext3_group_desc *gdp;
 	int i;
 	unsigned long ngroups = EXT3_SB(sb)->s_groups_count;
 #ifdef EXT3FS_DEBUG
 	struct ext3_super_block *es;
-	unsigned long bitmap_count, x;
+	ext3_fsblk_t bitmap_count;
+	unsigned long x;
 	struct buffer_head *bitmap_bh = NULL;
 
 	es = EXT3_SB(sb)->s_es;
@@ -1511,8 +1506,10 @@ unsigned long ext3_count_free_blocks(str
 		bitmap_count += x;
 	}
 	brelse(bitmap_bh);
-	printk("ext3_count_free_blocks: stored = %u, computed = %lu, %lu\n",
-	       le32_to_cpu(es->s_free_blocks_count), desc_count, bitmap_count);
+	printk("ext3_count_free_blocks: stored = "E3FSBLK
+		", computed = "E3FSBLK", "E3FSBLK"\n",
+	       le32_to_cpu(es->s_free_blocks_count),
+		desc_count, bitmap_count);
 	return bitmap_count;
 #else
 	desc_count = 0;
diff -puN fs/ext3/inode.c~ext3_convert_blks_to_fsblk_t fs/ext3/inode.c
--- linux-2.6.16/fs/ext3/inode.c~ext3_convert_blks_to_fsblk_t	2006-06-07 15:43:17.000000000 -0700
+++ linux-2.6.16-ming/fs/ext3/inode.c	2006-06-08 16:49:48.790941336 -0700
@@ -407,13 +407,13 @@ no_block:
  *
  *	Caller must make sure that @ind is valid and will stay that way.
  */
-static unsigned long ext3_find_near(struct inode *inode, Indirect *ind)
+static ext3_fsblk_t ext3_find_near(struct inode *inode, Indirect *ind)
 {
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	__le32 *start = ind->bh ? (__le32*) ind->bh->b_data : ei->i_data;
 	__le32 *p;
-	unsigned long bg_start;
-	unsigned long colour;
+	ext3_fsblk_t bg_start;
+	ext3_grpblk_t colour;
 
 	/* Try to find previous block */
 	for (p = ind->p - 1; p >= start; p--) {
@@ -429,8 +429,7 @@ static unsigned long ext3_find_near(stru
 	 * It is going to be referred to from the inode itself? OK, just put it
 	 * into the same cylinder group then.
 	 */
-	bg_start = (ei->i_block_group * EXT3_BLOCKS_PER_GROUP(inode->i_sb)) +
-		le32_to_cpu(EXT3_SB(inode->i_sb)->s_es->s_first_data_block);
+	bg_start = ext3_group_first_block_no(inode->i_sb, ei->i_block_group);
 	colour = (current->pid % 16) *
 			(EXT3_BLOCKS_PER_GROUP(inode->i_sb) / 16);
 	return bg_start + colour;
@@ -448,7 +447,7 @@ static unsigned long ext3_find_near(stru
  *	stores it in *@goal and returns zero.
  */
 
-static unsigned long ext3_find_goal(struct inode *inode, long block,
+static ext3_fsblk_t ext3_find_goal(struct inode *inode, long block,
 		Indirect chain[4], Indirect *partial)
 {
 	struct ext3_block_alloc_info *block_i;
@@ -516,13 +515,13 @@ static int ext3_blks_to_allocate(Indirec
  *		direct blocks
  */
 static int ext3_alloc_blocks(handle_t *handle, struct inode *inode,
-			unsigned long goal, int indirect_blks, int blks,
-			unsigned long long new_blocks[4], int *err)
+			ext3_fsblk_t goal, int indirect_blks, int blks,
+			ext3_fsblk_t new_blocks[4], int *err)
 {
 	int target, i;
 	unsigned long count = 0;
 	int index = 0;
-	unsigned long current_block = 0;
+	ext3_fsblk_t current_block = 0;
 	int ret = 0;
 
 	/*
@@ -592,7 +591,7 @@ failed_out:
  *	as described above and return 0.
  */
 static int ext3_alloc_branch(handle_t *handle, struct inode *inode,
-			int indirect_blks, int *blks, unsigned long goal,
+			int indirect_blks, int *blks, ext3_fsblk_t goal,
 			int *offsets, Indirect *branch)
 {
 	int blocksize = inode->i_sb->s_blocksize;
@@ -600,8 +599,8 @@ static int ext3_alloc_branch(handle_t *h
 	int err = 0;
 	struct buffer_head *bh;
 	int num;
-	unsigned long long new_blocks[4];
-	unsigned long long current_block;
+	ext3_fsblk_t new_blocks[4];
+	ext3_fsblk_t current_block;
 
 	num = ext3_alloc_blocks(handle, inode, goal, indirect_blks,
 				*blks, new_blocks, &err);
@@ -688,7 +687,7 @@ static int ext3_splice_branch(handle_t *
 	int i;
 	int err = 0;
 	struct ext3_block_alloc_info *block_i;
-	unsigned long current_block;
+	ext3_fsblk_t current_block;
 
 	block_i = EXT3_I(inode)->i_block_alloc_info;
 	/*
@@ -795,13 +794,13 @@ int ext3_get_blocks_handle(handle_t *han
 	int offsets[4];
 	Indirect chain[4];
 	Indirect *partial;
-	unsigned long goal;
+	ext3_fsblk_t goal;
 	int indirect_blks;
 	int blocks_to_boundary = 0;
 	int depth;
 	struct ext3_inode_info *ei = EXT3_I(inode);
 	int count = 0;
-	unsigned long first_block = 0;
+	ext3_fsblk_t first_block = 0;
 
 
 	J_ASSERT(handle != NULL || create == 0);
@@ -819,7 +818,7 @@ int ext3_get_blocks_handle(handle_t *han
 		count++;
 		/*map more blocks*/
 		while (count < maxblocks && count <= blocks_to_boundary) {
-			unsigned long blk;
+			ext3_fsblk_t blk;
 
 			if (!verify_chain(chain, partial)) {
 				/*
@@ -1759,7 +1758,7 @@ void ext3_set_aops(struct inode *inode)
 static int ext3_block_truncate_page(handle_t *handle, struct page *page,
 		struct address_space *mapping, loff_t from)
 {
-	unsigned long index = from >> PAGE_CACHE_SHIFT;
+	ext3_fsblk_t index = from >> PAGE_CACHE_SHIFT;
 	unsigned offset = from & (PAGE_CACHE_SIZE-1);
 	unsigned blocksize, iblock, length, pos;
 	struct inode *inode = mapping->host;
@@ -1960,7 +1959,7 @@ no_top:
  * than `count' because there can be holes in there.
  */
 static void ext3_clear_blocks(handle_t *handle, struct inode *inode,
-		struct buffer_head *bh, unsigned long block_to_free,
+		struct buffer_head *bh, ext3_fsblk_t block_to_free,
 		unsigned long count, __le32 *first, __le32 *last)
 {
 	__le32 *p;
@@ -2022,12 +2021,12 @@ static void ext3_free_data(handle_t *han
 			   struct buffer_head *this_bh,
 			   __le32 *first, __le32 *last)
 {
-	unsigned long block_to_free = 0;    /* Starting block # of a run */
+	ext3_fsblk_t block_to_free = 0;    /* Starting block # of a run */
 	unsigned long count = 0;	    /* Number of blocks in the run */ 
 	__le32 *block_to_free_p = NULL;	    /* Pointer into inode/ind
 					       corresponding to
 					       block_to_free */
-	unsigned long nr;		    /* Current block # */
+	ext3_fsblk_t nr;		    /* Current block # */
 	__le32 *p;			    /* Pointer into inode/ind
 					       for current block */
 	int err;
@@ -2089,7 +2088,7 @@ static void ext3_free_branches(handle_t 
 			       struct buffer_head *parent_bh,
 			       __le32 *first, __le32 *last, int depth)
 {
-	unsigned long nr;
+	ext3_fsblk_t nr;
 	__le32 *p;
 
 	if (is_handle_aborted(handle))
@@ -2113,7 +2112,7 @@ static void ext3_free_branches(handle_t 
 			 */
 			if (!bh) {
 				ext3_error(inode->i_sb, "ext3_free_branches",
-					   "Read failure, inode=%ld, block=%ld",
+					   "Read failure, inode=%ld, block="E3FSBLK,
 					   inode->i_ino, nr);
 				continue;
 			}
@@ -2394,11 +2393,12 @@ out_stop:
 	ext3_journal_stop(handle);
 }
 
-static unsigned long ext3_get_inode_block(struct super_block *sb,
+static ext3_fsblk_t ext3_get_inode_block(struct super_block *sb,
 		unsigned long ino, struct ext3_iloc *iloc)
 {
 	unsigned long desc, group_desc, block_group;
-	unsigned long offset, block;
+	unsigned long offset;
+	ext3_fsblk_t block;
 	struct buffer_head *bh;
 	struct ext3_group_desc * gdp;
 
@@ -2448,7 +2448,7 @@ static unsigned long ext3_get_inode_bloc
 static int __ext3_get_inode_loc(struct inode *inode,
 				struct ext3_iloc *iloc, int in_mem)
 {
-	unsigned long block;
+	ext3_fsblk_t block;
 	struct buffer_head *bh;
 
 	block = ext3_get_inode_block(inode->i_sb, inode->i_ino, iloc);
@@ -2459,7 +2459,8 @@ static int __ext3_get_inode_loc(struct i
 	if (!bh) {
 		ext3_error (inode->i_sb, "ext3_get_inode_loc",
 				"unable to read inode block - "
-				"inode=%lu, block=%lu", inode->i_ino, block);
+				"inode=%lu, block="E3FSBLK,
+				 inode->i_ino, block);
 		return -EIO;
 	}
 	if (!buffer_uptodate(bh)) {
@@ -2540,7 +2541,7 @@ make_io:
 		if (!buffer_uptodate(bh)) {
 			ext3_error(inode->i_sb, "ext3_get_inode_loc",
 					"unable to read inode block - "
-					"inode=%lu, block=%lu",
+					"inode=%lu, block="E3FSBLK,
 					inode->i_ino, block);
 			brelse(bh);
 			return -EIO;
diff -puN fs/ext3/ioctl.c~ext3_convert_blks_to_fsblk_t fs/ext3/ioctl.c
--- linux-2.6.16/fs/ext3/ioctl.c~ext3_convert_blks_to_fsblk_t	2006-06-07 15:43:17.000000000 -0700
+++ linux-2.6.16-ming/fs/ext3/ioctl.c	2006-06-08 16:49:48.791941223 -0700
@@ -204,7 +204,7 @@ flags_err:
 		return 0;
 	}
 	case EXT3_IOC_GROUP_EXTEND: {
-		unsigned long n_blocks_count;
+		ext3_fsblk_t n_blocks_count;
 		struct super_block *sb = inode->i_sb;
 		int err;
 
diff -puN fs/ext3/resize.c~ext3_convert_blks_to_fsblk_t fs/ext3/resize.c
--- linux-2.6.16/fs/ext3/resize.c~ext3_convert_blks_to_fsblk_t	2006-06-07 15:43:17.000000000 -0700
+++ linux-2.6.16-ming/fs/ext3/resize.c	2006-06-08 16:49:57.498950841 -0700
@@ -116,7 +116,7 @@ static int verify_group_input(struct sup
 }
 
 static struct buffer_head *bclean(handle_t *handle, struct super_block *sb,
-				  unsigned long blk)
+				  ext3_fsblk_t blk)
 {
 	struct buffer_head *bh;
 	int err;
@@ -167,14 +167,13 @@ static int setup_new_group_blocks(struct
 				  struct ext3_new_group_data *input)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
-	unsigned long start = input->group * sbi->s_blocks_per_group +
-		le32_to_cpu(sbi->s_es->s_first_data_block);
+	ext3_fsblk_t start = ext3_group_first_block_no(sb, input->group);
 	int reserved_gdb = ext3_bg_has_super(sb, input->group) ?
 		le16_to_cpu(sbi->s_es->s_reserved_gdt_blocks) : 0;
 	unsigned long gdblocks = ext3_bg_num_gdb(sb, input->group);
 	struct buffer_head *bh;
 	handle_t *handle;
-	unsigned long block;
+	ext3_fsblk_t block;
 	ext3_grpblk_t bit;
 	int i;
 	int err = 0, err2;
@@ -332,7 +331,7 @@ static unsigned ext3_list_backups(struct
 static int verify_reserved_gdb(struct super_block *sb,
 			       struct buffer_head *primary)
 {
-	const unsigned long blk = primary->b_blocknr;
+	const ext3_fsblk_t blk = primary->b_blocknr;
 	const unsigned long end = EXT3_SB(sb)->s_groups_count;
 	unsigned three = 1;
 	unsigned five = 5;
@@ -344,7 +343,8 @@ static int verify_reserved_gdb(struct su
 	while ((grp = ext3_list_backups(sb, &three, &five, &seven)) < end) {
 		if (le32_to_cpu(*p++) != grp * EXT3_BLOCKS_PER_GROUP(sb) + blk){
 			ext3_warning(sb, __FUNCTION__,
-				     "reserved GDT %lu missing grp %d (%lu)",
+				     "reserved GDT "E3FSBLK
+				     " missing grp %d ("E3FSBLK")",
 				     blk, grp,
 				     grp * EXT3_BLOCKS_PER_GROUP(sb) + blk);
 			return -EINVAL;
@@ -376,7 +376,7 @@ static int add_new_gdb(handle_t *handle,
 	struct super_block *sb = inode->i_sb;
 	struct ext3_super_block *es = EXT3_SB(sb)->s_es;
 	unsigned long gdb_num = input->group / EXT3_DESC_PER_BLOCK(sb);
-	unsigned long gdblock = EXT3_SB(sb)->s_sbh->b_blocknr + 1 + gdb_num;
+	ext3_fsblk_t gdblock = EXT3_SB(sb)->s_sbh->b_blocknr + 1 + gdb_num;
 	struct buffer_head **o_group_desc, **n_group_desc;
 	struct buffer_head *dind;
 	int gdbackups;
@@ -421,7 +421,7 @@ static int add_new_gdb(handle_t *handle,
 	data = (__u32 *)dind->b_data;
 	if (le32_to_cpu(data[gdb_num % EXT3_ADDR_PER_BLOCK(sb)]) != gdblock) {
 		ext3_warning(sb, __FUNCTION__,
-			     "new group %u GDT block %lu not reserved",
+			     "new group %u GDT block "E3FSBLK" not reserved",
 			     input->group, gdblock);
 		err = -EINVAL;
 		goto exit_dind;
@@ -519,7 +519,7 @@ static int reserve_backup_gdb(handle_t *
 	struct buffer_head **primary;
 	struct buffer_head *dind;
 	struct ext3_iloc iloc;
-	unsigned long blk;
+	ext3_fsblk_t blk;
 	__u32 *data, *end;
 	int gdbackups = 0;
 	int res, i;
@@ -544,7 +544,8 @@ static int reserve_backup_gdb(handle_t *
 	for (res = 0; res < reserved_gdb; res++, blk++) {
 		if (le32_to_cpu(*data) != blk) {
 			ext3_warning(sb, __FUNCTION__,
-				     "reserved block %lu not at offset %ld",
+				     "reserved block "E3FSBLK
+				     " not at offset %ld",
 				     blk, (long)(data - (__u32 *)dind->b_data));
 			err = -EINVAL;
 			goto exit_bh;
@@ -906,9 +907,9 @@ exit_put:
  * GDT blocks are reserved to grow to the desired size.
  */
 int ext3_group_extend(struct super_block *sb, struct ext3_super_block *es,
-		      unsigned long n_blocks_count)
+		      ext3_fsblk_t n_blocks_count)
 {
-	unsigned long o_blocks_count;
+	ext3_fsblk_t o_blocks_count;
 	unsigned long o_groups_count;
 	ext3_grpblk_t last;
 	ext3_grpblk_t add;
@@ -924,7 +925,7 @@ int ext3_group_extend(struct super_block
 	o_groups_count = EXT3_SB(sb)->s_groups_count;
 
 	if (test_opt(sb, DEBUG))
-		printk(KERN_DEBUG "EXT3-fs: extending last group from %lu to %lu blocks\n",
+		printk(KERN_DEBUG "EXT3-fs: extending last group from "E3FSBLK" uto "E3FSBLK" blocks\n",
 		       o_blocks_count, n_blocks_count);
 
 	if (n_blocks_count == 0 || n_blocks_count == o_blocks_count)
@@ -963,7 +964,8 @@ int ext3_group_extend(struct super_block
 
 	if (o_blocks_count + add < n_blocks_count)
 		ext3_warning(sb, __FUNCTION__,
-			     "will only finish group (%lu blocks, %u new)",
+			     "will only finish group ("E3FSBLK
+			     " blocks, %u new)",
 			     o_blocks_count + add, add);
 
 	/* See if the device is actually as big as what was requested */
@@ -1006,10 +1008,10 @@ int ext3_group_extend(struct super_block
 	ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
 	unlock_super(sb);
-	ext3_debug("freeing blocks %lu through %lu\n", o_blocks_count,
+	ext3_debug("freeing blocks %lu through "E3FSBLK"\n", o_blocks_count,
 		   o_blocks_count + add);
 	ext3_free_blocks_sb(handle, sb, o_blocks_count, add, &freed_blocks);
-	ext3_debug("freed blocks %lu through %lu\n", o_blocks_count,
+	ext3_debug("freed blocks "E3FSBLK" through "E3FSBLK"\n", o_blocks_count,
 		   o_blocks_count + add);
 	if ((err = ext3_journal_stop(handle)))
 		goto exit_put;
diff -puN fs/ext3/super.c~ext3_convert_blks_to_fsblk_t fs/ext3/super.c
--- linux-2.6.16/fs/ext3/super.c~ext3_convert_blks_to_fsblk_t	2006-06-07 15:43:17.000000000 -0700
+++ linux-2.6.16-ming/fs/ext3/super.c	2006-06-08 16:49:57.502950386 -0700
@@ -688,14 +688,15 @@ static match_table_t tokens = {
 	{Opt_resize, "resize"},
 };
 
-static unsigned long get_sb_block(void **data)
+static ext3_fsblk_t get_sb_block(void **data)
 {
-	unsigned long 	sb_block;
+	ext3_fsblk_t 	sb_block;
 	char 		*options = (char *) *data;
 
 	if (!options || strncmp(options, "sb=", 3) != 0)
 		return 1;	/* Default location */
 	options += 3;
+	/*todo: use simple_strtoll with >32bit ext3 */
 	sb_block = simple_strtoul(options, &options, 0);
 	if (*options && *options != ',') {
 		printk("EXT3-fs: Invalid sb specification: %s\n",
@@ -710,7 +711,7 @@ static unsigned long get_sb_block(void *
 
 static int parse_options (char *options, struct super_block *sb,
 			  unsigned long *inum, unsigned long *journal_devnum,
-			  unsigned long *n_blocks_count, int is_remount)
+			  ext3_fsblk_t *n_blocks_count, int is_remount)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	char * p;
@@ -1127,7 +1128,7 @@ static int ext3_setup_super(struct super
 static int ext3_check_descriptors (struct super_block * sb)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
-	unsigned long block = le32_to_cpu(sbi->s_es->s_first_data_block);
+	ext3_fsblk_t block = le32_to_cpu(sbi->s_es->s_first_data_block);
 	struct ext3_group_desc * gdp = NULL;
 	int desc_block = 0;
 	int i;
@@ -1314,15 +1315,14 @@ static loff_t ext3_max_size(int bits)
 	return res;
 }
 
-static unsigned long descriptor_loc(struct super_block *sb,
-				    unsigned long logic_sb_block,
+static ext3_fsblk_t descriptor_loc(struct super_block *sb,
+				    ext3_fsblk_t logic_sb_block,
 				    int nr)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
-	unsigned long bg, first_data_block, first_meta_bg;
+	unsigned long bg, first_meta_bg;
 	int has_super = 0;
 
-	first_data_block = le32_to_cpu(sbi->s_es->s_first_data_block);
 	first_meta_bg = le32_to_cpu(sbi->s_es->s_first_meta_bg);
 
 	if (!EXT3_HAS_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_META_BG) ||
@@ -1331,7 +1331,7 @@ static unsigned long descriptor_loc(stru
 	bg = sbi->s_desc_per_block * nr;
 	if (ext3_bg_has_super(sb, bg))
 		has_super = 1;
-	return (first_data_block + has_super + (bg * sbi->s_blocks_per_group));
+	return (has_super + ext3_group_first_block_no(sb, bg));
 }
 
 
@@ -1340,9 +1340,9 @@ static int ext3_fill_super (struct super
 	struct buffer_head * bh;
 	struct ext3_super_block *es = NULL;
 	struct ext3_sb_info *sbi;
-	unsigned long block;
-	unsigned long sb_block = get_sb_block(&data);
-	unsigned long logic_sb_block;
+	ext3_fsblk_t block;
+	ext3_fsblk_t sb_block = get_sb_block(&data);
+	ext3_fsblk_t logic_sb_block;
 	unsigned long offset = 0;
 	unsigned long journal_inum = 0;
 	unsigned long journal_devnum = 0;
@@ -1603,6 +1603,7 @@ static int ext3_fill_super (struct super
 	}
 	if (!ext3_check_descriptors (sb)) {
 		printk (KERN_ERR "EXT3-fs: group descriptors corrupted !\n");
+
 		goto failed_mount2;
 	}
 	sbi->s_gdb_count = db_count;
@@ -1839,10 +1840,10 @@ static journal_t *ext3_get_dev_journal(s
 {
 	struct buffer_head * bh;
 	journal_t *journal;
-	int start;
+	ext3_fsblk_t start;
 	ext3_fsblk_t len;
 	int hblock, blocksize;
-	unsigned long sb_block;
+	ext3_fsblk_t sb_block;
 	unsigned long offset;
 	struct ext3_super_block * es;
 	struct block_device *bdev;
@@ -2215,7 +2216,7 @@ static int ext3_remount (struct super_bl
 {
 	struct ext3_super_block * es;
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
-	unsigned long n_blocks_count = 0;
+	ext3_fsblk_t n_blocks_count = 0;
 	unsigned long old_sb_flags;
 	struct ext3_mount_options old_opts;
 	int err;
@@ -2334,7 +2335,7 @@ static int ext3_statfs (struct super_blo
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	struct ext3_super_block *es = sbi->s_es;
-	unsigned long overhead;
+	ext3_fsblk_t overhead;
 	int i;
 
 	if (test_opt (sb, MINIX_DF))
diff -puN fs/ext3/xattr.c~ext3_convert_blks_to_fsblk_t fs/ext3/xattr.c
--- linux-2.6.16/fs/ext3/xattr.c~ext3_convert_blks_to_fsblk_t	2006-06-07 15:43:17.000000000 -0700
+++ linux-2.6.16-ming/fs/ext3/xattr.c	2006-06-07 15:43:17.000000000 -0700
@@ -233,7 +233,7 @@ ext3_xattr_block_get(struct inode *inode
 		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
 	if (ext3_xattr_check_block(bh)) {
 bad_block:	ext3_error(inode->i_sb, __FUNCTION__,
-			   "inode %ld: bad block %u", inode->i_ino,
+			   "inode %ld: bad block "E3FSBLK, inode->i_ino,
 			   EXT3_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -375,7 +375,7 @@ ext3_xattr_block_list(struct inode *inod
 		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
 	if (ext3_xattr_check_block(bh)) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			   "inode %ld: bad block %u", inode->i_ino,
+			   "inode %ld: bad block "E3FSBLK, inode->i_ino,
 			   EXT3_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -647,7 +647,7 @@ ext3_xattr_block_find(struct inode *inod
 			le32_to_cpu(BHDR(bs->bh)->h_refcount));
 		if (ext3_xattr_check_block(bs->bh)) {
 			ext3_error(sb, __FUNCTION__,
-				"inode %ld: bad block %u", inode->i_ino,
+				"inode %ld: bad block "E3FSBLK, inode->i_ino,
 				EXT3_I(inode)->i_file_acl);
 			error = -EIO;
 			goto cleanup;
@@ -848,7 +848,7 @@ cleanup_dquot:
 
 bad_block:
 	ext3_error(inode->i_sb, __FUNCTION__,
-		   "inode %ld: bad block %u", inode->i_ino,
+		   "inode %ld: bad block "E3FSBLK, inode->i_ino,
 		   EXT3_I(inode)->i_file_acl);
 	goto cleanup;
 
@@ -1077,14 +1077,14 @@ ext3_xattr_delete_inode(handle_t *handle
 	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
 	if (!bh) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			"inode %ld: block %u read error", inode->i_ino,
+			"inode %ld: block "E3FSBLK" read error", inode->i_ino,
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
 	if (BHDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
 	    BHDR(bh)->h_blocks != cpu_to_le32(1)) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			"inode %ld: bad block %u", inode->i_ino,
+			"inode %ld: bad block "E3FSBLK, inode->i_ino,
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
diff -puN include/linux/ext3_fs.h~ext3_convert_blks_to_fsblk_t include/linux/ext3_fs.h
--- linux-2.6.16/include/linux/ext3_fs.h~ext3_convert_blks_to_fsblk_t	2006-06-07 15:43:17.000000000 -0700
+++ linux-2.6.16-ming/include/linux/ext3_fs.h	2006-06-08 16:49:57.504950159 -0700
@@ -712,6 +712,14 @@ struct dir_private_info {
 	__u32		next_hash;
 };
 
+/* calculate the first block number of the group */
+static inline ext3_fsblk_t
+ext3_group_first_block_no(struct super_block *sb, unsigned long group_no)
+{
+	return group_no * (ext3_fsblk_t)EXT3_BLOCKS_PER_GROUP(sb) +
+		le32_to_cpu(EXT3_SB(sb)->s_es->s_first_data_block);
+}
+
 /*
  * Special error return code only used by dx_probe() and its callers.
  */
@@ -741,7 +749,7 @@ extern void ext3_free_blocks (handle_t *
 extern void ext3_free_blocks_sb (handle_t *handle, struct super_block *sb,
 				 ext3_fsblk_t block, unsigned long count,
 				unsigned long *pdquot_freed_blocks);
-extern unsigned long ext3_count_free_blocks (struct super_block *);
+extern ext3_fsblk_t ext3_count_free_blocks (struct super_block *);
 extern void ext3_check_blocks_bitmap (struct super_block *);
 extern struct ext3_group_desc * ext3_get_group_desc(struct super_block * sb,
 						    unsigned int block_group,
@@ -813,7 +821,7 @@ extern int ext3_group_add(struct super_b
 				struct ext3_new_group_data *input);
 extern int ext3_group_extend(struct super_block *sb,
 				struct ext3_super_block *es,
-				unsigned long n_blocks_count);
+				ext3_fsblk_t n_blocks_count);
 
 /* super.c */
 extern void ext3_error (struct super_block *, const char *, const char *, ...)
diff -puN include/linux/ext3_fs_i.h~ext3_convert_blks_to_fsblk_t include/linux/ext3_fs_i.h
--- linux-2.6.16/include/linux/ext3_fs_i.h~ext3_convert_blks_to_fsblk_t	2006-06-07 15:43:17.000000000 -0700
+++ linux-2.6.16-ming/include/linux/ext3_fs_i.h	2006-06-08 16:49:57.505950045 -0700
@@ -30,8 +30,8 @@ typedef unsigned long ext3_fsblk_t;
 #define E3FSBLK "%lu"
 
 struct ext3_reserve_window {
-	__u32			_rsv_start;	/* First byte reserved */
-	__u32			_rsv_end;	/* Last byte reserved or 0 */
+	ext3_fsblk_t	_rsv_start;	/* First byte reserved */
+	ext3_fsblk_t	_rsv_end;	/* Last byte reserved or 0 */
 };
 
 struct ext3_reserve_window_node {
@@ -58,7 +58,7 @@ struct ext3_block_alloc_info {
 	 * allocated to this file.  This give us the goal (target) for the next
 	 * allocation when we detect linearly ascending requests.
 	 */
-	__u32                   last_alloc_physical_block;
+	ext3_fsblk_t		last_alloc_physical_block;
 };
 
 #define rsv_start rsv_window._rsv_start
@@ -75,7 +75,7 @@ struct ext3_inode_info {
 	__u8	i_frag_no;
 	__u8	i_frag_size;
 #endif
-	__u32	i_file_acl;
+	ext3_fsblk_t	i_file_acl;
 	__u32	i_dir_acl;
 	__u32	i_dtime;
 

_


