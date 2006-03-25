Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWCYNd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWCYNd4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 08:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWCYNd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 08:33:56 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:48067 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751395AbWCYNdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 08:33:55 -0500
To: pbadari@us.ibm.com
Cc: linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [PATCH 2/2] ext2/3: Support2^32-1blocks(e2fsprogs)
Message-Id: <20060325223358sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Sat, 25 Mar 2006 22:33:58 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>More information. I ran the test with "-onoreservation" thinking that
>the patch didn't address "reservation code" issues and I still ran
>into block allocation problems. Hope this helps.

As you said, the previous patches were broken because of my mailer,
and part of them would be rejected.
I'm re-sending them;  I have not changed them other than the mailer.
Could you try new patches and check what happened?
I have run fsx with these patches several times and the problems
weren't reproduced.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext2/balloc.c linux-2.6.16-rc6-4g/fs/e
xt2/balloc.c
--- linux-2.6.16-rc6.org/fs/ext2/balloc.c	2006-03-14 09:09:00.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/ext2/balloc.c	2006-03-14 09:29:01.000000000 +0900
@@ -99,14 +99,14 @@ error_out:
  * Set sb->s_dirt here because the superblock was "logically" altered.  We
  * need to recalculate its free blocks count and flush it out.
  */
-static int reserve_blocks(struct super_block *sb, int count)
+static unsigned int reserve_blocks(struct super_block *sb, unsigned int count)
 {
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct ext2_super_block *es = sbi->s_es;
-	unsigned free_blocks;
+	unsigned int free_blocks;
 	unsigned root_blocks;
 
-	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
+	free_blocks = percpu_llcounter_read_positive(&sbi->s_freeblocks_counter);
 	root_blocks = le32_to_cpu(es->s_r_blocks_count);
 
 	if (free_blocks < count)
@@ -125,23 +125,23 @@ static int reserve_blocks(struct super_b
 			return 0;
 	}
 
-	percpu_counter_mod(&sbi->s_freeblocks_counter, -count);
+	percpu_llcounter_mod(&sbi->s_freeblocks_counter, -count);
 	sb->s_dirt = 1;
 	return count;
 }
 
-static void release_blocks(struct super_block *sb, int count)
+static void release_blocks(struct super_block *sb, unsigned int count)
 {
 	if (count) {
 		struct ext2_sb_info *sbi = EXT2_SB(sb);
 
-		percpu_counter_mod(&sbi->s_freeblocks_counter, count);
+		percpu_llcounter_mod(&sbi->s_freeblocks_counter, count);
 		sb->s_dirt = 1;
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
+	unsigned int target_block;	/* tmp */
+	unsigned int block = 0;
 	struct super_block *sb = inode->i_sb;
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct ext2_super_block *es = sbi->s_es;
@@ -447,7 +447,6 @@ retry:
 		group_alloc = 0;
 		goto retry;
 	}
-
 got_block:
 	ext2_debug("using block group %d(%d)\n",
 		group_no, desc->bg_free_blocks_count);
@@ -465,7 +464,7 @@ got_block:
 
 	if (target_block >= le32_to_cpu(es->s_blocks_count)) {
 		ext2_error (sb, "ext2_new_block",
-			    "block(%d) >= blocks count(%d) - "
+			    "block(%d) >= blocks count(%u) - "
 			    "block_group = %d, es == %p ", ret_block,
 			le32_to_cpu(es->s_blocks_count), group_no, es);
 		goto io_error;
@@ -504,7 +503,7 @@ got_block:
 	if (sb->s_flags & MS_SYNCHRONOUS)
 		sync_dirty_buffer(bitmap_bh);
 
-	ext2_debug ("allocating block %d. ", block);
+	ext2_debug ("allocating block %u. ", block);
 
 	*err = 0;
 out_release:
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext2/ext2.h linux-2.6.16-rc6-4g/fs/ext
2/ext2.h
--- linux-2.6.16-rc6.org/fs/ext2/ext2.h	2006-03-14 09:09:00.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/ext2/ext2.h	2006-03-14 09:29:01.000000000 +0900
@@ -91,7 +91,7 @@ static inline struct ext2_inode_info *EX
 /* balloc.c */
 extern int ext2_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
-extern int ext2_new_block (struct inode *, unsigned long,
+extern unsigned int ext2_new_block (struct inode *, unsigned long,
 			   __u32 *, __u32 *, int *);
 extern void ext2_free_blocks (struct inode *, unsigned long,
 			      unsigned long);
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext2/ialloc.c linux-2.6.16-rc6-4g/fs/e
xt2/ialloc.c
--- linux-2.6.16-rc6.org/fs/ext2/ialloc.c	2006-03-14 09:09:00.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/ext2/ialloc.c	2006-03-14 09:29:01.000000000 +0900
@@ -83,7 +83,7 @@ static void ext2_release_inode(struct su
 			cpu_to_le16(le16_to_cpu(desc->bg_used_dirs_count) - 1);
 	spin_unlock(sb_bgl_lock(EXT2_SB(sb), group));
 	if (dir)
-		percpu_counter_dec(&EXT2_SB(sb)->s_dirs_counter);
+		percpu_llcounter_dec(&EXT2_SB(sb)->s_dirs_counter);
 	sb->s_dirt = 1;
 	mark_buffer_dirty(bh);
 }
@@ -276,22 +276,20 @@ static int find_group_orlov(struct super
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
 	struct buffer_head *bh;
 
-	freei = percpu_counter_read_positive(&sbi->s_freeinodes_counter);
+	freei = percpu_llcounter_read_positive(&sbi->s_freeinodes_counter);
 	avefreei = freei / ngroups;
-	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
+	free_blocks = percpu_llcounter_read_positive(&sbi->s_freeblocks_counter);
 	avefreeb = free_blocks / ngroups;
-	ndirs = percpu_counter_read_positive(&sbi->s_dirs_counter);
+	ndirs = percpu_llcounter_read_positive(&sbi->s_dirs_counter);
 
 	if ((parent == sb->s_root->d_inode) ||
 	    (EXT2_I(parent)->i_flags & EXT2_TOPDIR_FL)) {
@@ -328,7 +326,7 @@ static int find_group_orlov(struct super
 	}
 
 	if (ndirs == 0)
-		ndirs = 1;	/* percpu_counters are approximate... */
+		ndirs = 1;	/* percpu_llcounters are approximate... */
 
 	blocks_per_dir = (le32_to_cpu(es->s_blocks_count)-free_blocks) / ndirs;
 
@@ -543,9 +541,9 @@ got:
 		goto fail;
 	}
 
-	percpu_counter_mod(&sbi->s_freeinodes_counter, -1);
+	percpu_llcounter_mod(&sbi->s_freeinodes_counter, -1);
 	if (S_ISDIR(mode))
-		percpu_counter_inc(&sbi->s_dirs_counter);
+		percpu_llcounter_inc(&sbi->s_dirs_counter);
 
 	spin_lock(sb_bgl_lock(sbi, group));
 	gdp->bg_free_inodes_count =
@@ -670,7 +668,7 @@ unsigned long ext2_count_free_inodes (st
 	}
 	brelse(bitmap_bh);
 	printk("ext2_count_free_inodes: stored = %lu, computed = %lu, %lu\n",
-		percpu_counter_read(&EXT2_SB(sb)->s_freeinodes_counter),
+		percpu_llcounter_read(&EXT2_SB(sb)->s_freeinodes_counter),
 		desc_count, bitmap_count);
 	unlock_super(sb);
 	return desc_count;
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext2/inode.c linux-2.6.16-rc6-4g/fs/ex
t2/inode.c
--- linux-2.6.16-rc6.org/fs/ext2/inode.c	2006-03-14 09:09:00.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/ext2/inode.c	2006-03-15 21:16:51.000000000 +0900
@@ -107,7 +107,7 @@ void ext2_discard_prealloc (struct inode
 #endif
 }
 
-static int ext2_alloc_block (struct inode * inode, unsigned long goal, int *err)
+static unsigned int ext2_alloc_block (struct inode * inode, unsigned int goal, int *err)
 {
 #ifdef EXT2FS_DEBUG
 	static unsigned long alloc_hits, alloc_attempts;
@@ -193,8 +193,8 @@ static inline int verify_chain(Indirect 
  * get there at all.
  */
 
-static int ext2_block_to_path(struct inode *inode,
-			long i_block, int offsets[4], int *boundary)
+static int ext2_block_to_path(struct inode *inode, unsigned long i_block, 
+				unsigned int offsets[4], int *boundary)
 {
 	int ptrs = EXT2_ADDR_PER_BLOCK(inode->i_sb);
 	int ptrs_bits = EXT2_ADDR_PER_BLOCK_BITS(inode->i_sb);
@@ -263,7 +263,7 @@ static int ext2_block_to_path(struct ino
  */
 static Indirect *ext2_get_branch(struct inode *inode,
 				 int depth,
-				 int *offsets,
+				 unsigned int *offsets,
 				 Indirect chain[4],
 				 int *err)
 {
@@ -363,7 +363,7 @@ static unsigned long ext2_find_near(stru
  */
 
 static inline int ext2_find_goal(struct inode *inode,
-				 long block,
+				 unsigned long block,
 				 Indirect chain[4],
 				 Indirect *partial,
 				 unsigned long *goal)
@@ -418,20 +418,20 @@ static inline int ext2_find_goal(struct 
 static int ext2_alloc_branch(struct inode *inode,
 			     int num,
 			     unsigned long goal,
-			     int *offsets,
+			     unsigned int *offsets,
 			     Indirect *branch)
 {
 	int blocksize = inode->i_sb->s_blocksize;
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
@@ -547,7 +547,7 @@ changed:
 int ext2_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
 {
 	int err = -EIO;
-	int offsets[4];
+	unsigned int offsets[4];
 	Indirect chain[4];
 	Indirect *partial;
 	unsigned long goal;
@@ -776,7 +776,7 @@ static inline int all_zeroes(__le32 *p, 
 
 static Indirect *ext2_find_shared(struct inode *inode,
 				int depth,
-				int offsets[4],
+				unsigned int offsets[4],
 				Indirect chain[4],
 				__le32 *top)
 {
@@ -892,7 +892,7 @@ static void ext2_free_branches(struct in
 			 */ 
 			if (!bh) {
 				ext2_error(inode->i_sb, "ext2_free_branches",
-					"Read failure, inode=%ld, block=%ld",
+					"Read failure, inode=%lu, block=%lu",
 					inode->i_ino, nr);
 				continue;
 			}
@@ -912,12 +912,12 @@ void ext2_truncate (struct inode * inode
 {
 	__le32 *i_data = EXT2_I(inode)->i_data;
 	int addr_per_block = EXT2_ADDR_PER_BLOCK(inode->i_sb);
-	int offsets[4];
+	unsigned int offsets[4];
 	Indirect chain[4];
 	Indirect *partial;
 	__le32 nr = 0;
 	int n;
-	long iblock;
+	unsigned long iblock;
 	unsigned blocksize;
 
 	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext2/super.c linux-2.6.16-rc6-4g/fs/ex
t2/super.c
--- linux-2.6.16-rc6.org/fs/ext2/super.c	2006-03-14 09:09:00.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/ext2/super.c	2006-03-14 09:29:01.000000000 +0900
@@ -126,9 +126,9 @@ static void ext2_put_super (struct super
 			brelse (sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
 	kfree(sbi->s_debts);
-	percpu_counter_destroy(&sbi->s_freeblocks_counter);
-	percpu_counter_destroy(&sbi->s_freeinodes_counter);
-	percpu_counter_destroy(&sbi->s_dirs_counter);
+	percpu_llcounter_destroy(&sbi->s_freeblocks_counter);
+	percpu_llcounter_destroy(&sbi->s_freeinodes_counter);
+	percpu_llcounter_destroy(&sbi->s_dirs_counter);
 	brelse (sbi->s_sbh);
 	sb->s_fs_info = NULL;
 	kfree(sbi);
@@ -836,9 +836,9 @@ static int ext2_fill_super(struct super_
 		printk ("EXT2-fs: not enough memory\n");
 		goto failed_mount;
 	}
-	percpu_counter_init(&sbi->s_freeblocks_counter);
-	percpu_counter_init(&sbi->s_freeinodes_counter);
-	percpu_counter_init(&sbi->s_dirs_counter);
+	percpu_llcounter_init(&sbi->s_freeblocks_counter);
+	percpu_llcounter_init(&sbi->s_freeinodes_counter);
+	percpu_llcounter_init(&sbi->s_dirs_counter);
 	bgl_lock_init(&sbi->s_blockgroup_lock);
 	sbi->s_debts = kmalloc(sbi->s_groups_count * sizeof(*sbi->s_debts),
 			       GFP_KERNEL);
@@ -888,11 +888,11 @@ static int ext2_fill_super(struct super_
 		ext2_warning(sb, __FUNCTION__,
 			"mounting ext3 filesystem as ext2");
 	ext2_setup_super (sb, es, sb->s_flags & MS_RDONLY);
-	percpu_counter_mod(&sbi->s_freeblocks_counter,
+	percpu_llcounter_mod(&sbi->s_freeblocks_counter,
 				ext2_count_free_blocks(sb));
-	percpu_counter_mod(&sbi->s_freeinodes_counter,
+	percpu_llcounter_mod(&sbi->s_freeinodes_counter,
 				ext2_count_free_inodes(sb));
-	percpu_counter_mod(&sbi->s_dirs_counter,
+	percpu_llcounter_mod(&sbi->s_dirs_counter,
 				ext2_count_dirs(sb));
 	return 0;
 
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext2/xattr.c linux-2.6.16-rc6-4g/fs/ex
t2/xattr.c
--- linux-2.6.16-rc6.org/fs/ext2/xattr.c	2006-03-14 09:09:00.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/ext2/xattr.c	2006-03-14 09:29:01.000000000 +0900
@@ -71,7 +71,7 @@
 
 #ifdef EXT2_XATTR_DEBUG
 # define ea_idebug(inode, f...) do { \
-		printk(KERN_DEBUG "inode %s:%ld: ", \
+		printk(KERN_DEBUG "inode %s:%lu: ", \
 			inode->i_sb->s_id, inode->i_ino); \
 		printk(f); \
 		printk("\n"); \
@@ -164,7 +164,7 @@ ext2_xattr_get(struct inode *inode, int 
 	error = -ENODATA;
 	if (!EXT2_I(inode)->i_file_acl)
 		goto cleanup;
-	ea_idebug(inode, "reading block %d", EXT2_I(inode)->i_file_acl);
+	ea_idebug(inode, "reading block %u", EXT2_I(inode)->i_file_acl);
 	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
 	error = -EIO;
 	if (!bh)
@@ -175,7 +175,7 @@ ext2_xattr_get(struct inode *inode, int 
 	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
 bad_block:	ext2_error(inode->i_sb, "ext2_xattr_get",
-			"inode %ld: bad block %d", inode->i_ino,
+			"inode %lu: bad block %u", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -264,7 +264,7 @@ ext2_xattr_list(struct inode *inode, cha
 	error = 0;
 	if (!EXT2_I(inode)->i_file_acl)
 		goto cleanup;
-	ea_idebug(inode, "reading block %d", EXT2_I(inode)->i_file_acl);
+	ea_idebug(inode, "reading block %u", EXT2_I(inode)->i_file_acl);
 	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
 	error = -EIO;
 	if (!bh)
@@ -275,7 +275,7 @@ ext2_xattr_list(struct inode *inode, cha
 	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
 bad_block:	ext2_error(inode->i_sb, "ext2_xattr_list",
-			"inode %ld: bad block %d", inode->i_ino,
+			"inode %lu: bad block %u", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -411,7 +411,7 @@ ext2_xattr_set(struct inode *inode, int 
 		if (header->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 		    header->h_blocks != cpu_to_le32(1)) {
 bad_block:		ext2_error(sb, "ext2_xattr_set",
-				"inode %ld: bad block %d", inode->i_ino, 
+				"inode %lu: bad block %u", inode->i_ino,
 				   EXT2_I(inode)->i_file_acl);
 			error = -EIO;
 			goto cleanup;
@@ -664,15 +664,15 @@ ext2_xattr_set2(struct inode *inode, str
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
-			ea_idebug(inode, "creating block %d", block);
+			ea_idebug(inode, "creating block %u", block);
 
 			new_bh = sb_getblk(sb, block);
 			if (!new_bh) {
@@ -772,7 +772,7 @@ ext2_xattr_delete_inode(struct inode *in
 	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
 	if (!bh) {
 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
-			"inode %ld: block %d read error", inode->i_ino,
+			"inode %lu: block %u read error", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		goto cleanup;
 	}
@@ -780,7 +780,7 @@ ext2_xattr_delete_inode(struct inode *in
 	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
-			"inode %ld: bad block %d", inode->i_ino,
+			"inode %lu: bad block %u", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		goto cleanup;
 	}
@@ -931,13 +931,13 @@ again:
 		bh = sb_bread(inode->i_sb, ce->e_block);
 		if (!bh) {
 			ext2_error(inode->i_sb, "ext2_xattr_cache_find",
-				"inode %ld: block %ld read error",
+				"inode %lu: block %lu read error",
 				inode->i_ino, (unsigned long) ce->e_block);
 		} else {
 			lock_buffer(bh);
 			if (le32_to_cpu(HDR(bh)->h_refcount) >
 				   EXT2_XATTR_REFCOUNT_MAX) {
-				ea_idebug(inode, "block %ld refcount %d>%d",
+				ea_idebug(inode, "block %lu refcount %d>%d",
 					  (unsigned long) ce->e_block,
 					  le32_to_cpu(HDR(bh)->h_refcount),
 					  EXT2_XATTR_REFCOUNT_MAX);
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext2/xip.c linux-2.6.16-rc6-4g/fs/ext2
/xip.c
--- linux-2.6.16-rc6.org/fs/ext2/xip.c	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/ext2/xip.c	2006-03-14 09:29:01.000000000 +0900
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
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext3/balloc.c linux-2.6.16-rc6-4g/fs/e
xt3/balloc.c
--- linux-2.6.16-rc6.org/fs/ext3/balloc.c	2006-03-14 09:09:00.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/ext3/balloc.c	2006-03-14 09:29:01.000000000 +0900
@@ -36,7 +36,6 @@
  * when a file system is mounted (see ext3_read_super).
  */
 
-
 #define in_range(b, first, len)	((b) >= (first) && (b) <= (first) + (len) - 1)
 
 struct ext3_group_desc * ext3_get_group_desc(struct super_block * sb,
@@ -467,7 +466,7 @@ do_more:
 		cpu_to_le16(le16_to_cpu(desc->bg_free_blocks_count) +
 			group_freed);
 	spin_unlock(sb_bgl_lock(sbi, block_group));
-	percpu_counter_mod(&sbi->s_freeblocks_counter, count);
+	percpu_llcounter_mod(&sbi->s_freeblocks_counter, count);
 
 	/* We dirtied the bitmap block */
 	BUFFER_TRACE(bitmap_bh, "dirtied bitmap block");
@@ -1118,9 +1117,10 @@ out:
 
 static int ext3_has_free_blocks(struct ext3_sb_info *sbi)
 {
-	int free_blocks, root_blocks;
+	unsigned long free_blocks;
+	int  root_blocks;
 
-	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
+	free_blocks = percpu_llcounter_read_positive(&sbi->s_freeblocks_counter);
 	root_blocks = le32_to_cpu(sbi->s_es->s_r_blocks_count);
 	if (free_blocks < root_blocks + 1 && !capable(CAP_SYS_RESOURCE) &&
 		sbi->s_resuid != current->fsuid &&
@@ -1154,19 +1154,20 @@ int ext3_should_retry_alloc(struct super
  * bitmap, and then for any free bit if that fails.
  * This function also updates quota and i_blocks field.
  */
-int ext3_new_block(handle_t *handle, struct inode *inode,
+unsigned int ext3_new_block(handle_t *handle, struct inode *inode,
 			unsigned long goal, int *errp)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *gdp_bh;
 	int group_no;
 	int goal_group;
-	int ret_block;
+	unsigned int ret_block;
 	int bgi;			/* blockgroup iteration index */
-	int target_block;
+	unsigned int target_block;
 	int fatal = 0, err;
 	int performed_allocation = 0;
 	int free_blocks;
+	int group_block;
 	struct super_block *sb;
 	struct ext3_group_desc *gdp;
 	struct ext3_super_block *es;
@@ -1238,17 +1239,19 @@ retry:
 		my_rsv = NULL;
 
 	if (free_blocks > 0) {
-		ret_block = ((goal - le32_to_cpu(es->s_first_data_block)) %
+		group_block = ((goal - le32_to_cpu(es->s_first_data_block)) %
 				EXT3_BLOCKS_PER_GROUP(sb));
 		bitmap_bh = read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
 			goto io_error;
-		ret_block = ext3_try_to_allocate_with_rsv(sb, handle, group_no,
-					bitmap_bh, ret_block, my_rsv, &fatal);
+		group_block = ext3_try_to_allocate_with_rsv(sb, handle, group_no,
+					bitmap_bh, group_block, my_rsv, &fatal);
 		if (fatal)
 			goto out;
-		if (ret_block >= 0)
+		if (group_block >= 0) {
+			ret_block = group_block;
 			goto allocated;
+		}
 	}
 
 	ngroups = EXT3_SB(sb)->s_groups_count;
@@ -1280,12 +1283,14 @@ retry:
 		bitmap_bh = read_block_bitmap(sb, group_no);
 		if (!bitmap_bh)
 			goto io_error;
-		ret_block = ext3_try_to_allocate_with_rsv(sb, handle, group_no,
+		group_block = ext3_try_to_allocate_with_rsv(sb, handle, group_no,
 					bitmap_bh, -1, my_rsv, &fatal);
 		if (fatal)
 			goto out;
-		if (ret_block >= 0) 
+		if (group_block >= 0) {
+			ret_block = group_block;
 			goto allocated;
+		}
 	}
 	/*
 	 * We may end up a bogus ealier ENOSPC error due to
@@ -1347,7 +1352,7 @@ allocated:
 				"b_committed_data\n", __FUNCTION__);
 		}
 	}
-	ext3_debug("found bit %d\n", ret_block);
+	ext3_debug("found bit %u\n", ret_block);
 	spin_unlock(sb_bgl_lock(sbi, group_no));
 	jbd_unlock_bh_state(bitmap_bh);
 #endif
@@ -1357,8 +1362,8 @@ allocated:
 
 	if (ret_block >= le32_to_cpu(es->s_blocks_count)) {
 		ext3_error(sb, "ext3_new_block",
-			    "block(%d) >= blocks count(%d) - "
-			    "block_group = %d, es == %p ", ret_block,
+			    "block(%u) >= blocks count(%u) - "
+			    "block_group = %u, es == %p ", ret_block,
 			le32_to_cpu(es->s_blocks_count), group_no, es);
 		goto out;
 	}
@@ -1368,14 +1373,14 @@ allocated:
 	 * list of some description.  We don't know in advance whether
 	 * the caller wants to use it as metadata or data.
 	 */
-	ext3_debug("allocating block %d. Goal hits %d of %d.\n",
+	ext3_debug("allocating block %u. Goal hits %d of %d.\n",
 			ret_block, goal_hits, goal_attempts);
 
 	spin_lock(sb_bgl_lock(sbi, group_no));
 	gdp->bg_free_blocks_count =
 			cpu_to_le16(le16_to_cpu(gdp->bg_free_blocks_count) - 1);
 	spin_unlock(sb_bgl_lock(sbi, group_no));
-	percpu_counter_mod(&sbi->s_freeblocks_counter, -1);
+	percpu_llcounter_mod(&sbi->s_freeblocks_counter, -1);
 
 	BUFFER_TRACE(gdp_bh, "journal_dirty_metadata for group descriptor");
 	err = ext3_journal_dirty_metadata(handle, gdp_bh);
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext3/ialloc.c linux-2.6.16-rc6-4g/fs/e
xt3/ialloc.c
--- linux-2.6.16-rc6.org/fs/ext3/ialloc.c	2006-03-14 09:09:00.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/ext3/ialloc.c	2006-03-14 09:29:01.000000000 +0900
@@ -170,9 +170,9 @@ void ext3_free_inode (handle_t *handle, 
 				gdp->bg_used_dirs_count = cpu_to_le16(
 				  le16_to_cpu(gdp->bg_used_dirs_count) - 1);
 			spin_unlock(sb_bgl_lock(sbi, block_group));
-			percpu_counter_inc(&sbi->s_freeinodes_counter);
+			percpu_llcounter_inc(&sbi->s_freeinodes_counter);
 			if (is_directory)
-				percpu_counter_dec(&sbi->s_dirs_counter);
+				percpu_llcounter_dec(&sbi->s_dirs_counter);
 
 		}
 		BUFFER_TRACE(bh2, "call ext3_journal_dirty_metadata");
@@ -202,12 +202,13 @@ error_return:
 static int find_group_dir(struct super_block *sb, struct inode *parent)
 {
 	int ngroups = EXT3_SB(sb)->s_groups_count;
-	int freei, avefreei;
+	unsigned long freei;
+	int avefreei;
 	struct ext3_group_desc *desc, *best_desc = NULL;
 	struct buffer_head *bh;
 	int group, best_group = -1;
 
-	freei = percpu_counter_read_positive(&EXT3_SB(sb)->s_freeinodes_counter);
+	freei = percpu_llcounter_read_positive(&EXT3_SB(sb)->s_freeinodes_counter);
 	avefreei = freei / ngroups;
 
 	for (group = 0; group < ngroups; group++) {
@@ -261,19 +262,20 @@ static int find_group_orlov(struct super
 	struct ext3_super_block *es = sbi->s_es;
 	int ngroups = sbi->s_groups_count;
 	int inodes_per_group = EXT3_INODES_PER_GROUP(sb);
-	int freei, avefreei;
-	int freeb, avefreeb;
-	int blocks_per_dir, ndirs;
+	unsigned long freei, freeb, ndirs;
+	int avefreei;
+	int avefreeb;
+	int blocks_per_dir;
 	int max_debt, max_dirs, min_blocks, min_inodes;
 	int group = -1, i;
 	struct ext3_group_desc *desc;
 	struct buffer_head *bh;
 
-	freei = percpu_counter_read_positive(&sbi->s_freeinodes_counter);
+	freei = percpu_llcounter_read_positive(&sbi->s_freeinodes_counter);
 	avefreei = freei / ngroups;
-	freeb = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
+	freeb = percpu_llcounter_read_positive(&sbi->s_freeblocks_counter);
 	avefreeb = freeb / ngroups;
-	ndirs = percpu_counter_read_positive(&sbi->s_dirs_counter);
+	ndirs = percpu_llcounter_read_positive(&sbi->s_dirs_counter);
 
 	if ((parent == sb->s_root->d_inode) ||
 	    (EXT3_I(parent)->i_flags & EXT3_TOPDIR_FL)) {
@@ -539,9 +541,9 @@ got:
 	err = ext3_journal_dirty_metadata(handle, bh2);
 	if (err) goto fail;
 
-	percpu_counter_dec(&sbi->s_freeinodes_counter);
+	percpu_llcounter_dec(&sbi->s_freeinodes_counter);
 	if (S_ISDIR(mode))
-		percpu_counter_inc(&sbi->s_dirs_counter);
+		percpu_llcounter_inc(&sbi->s_dirs_counter);
 	sb->s_dirt = 1;
 
 	inode->i_uid = current->fsuid;
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext3/inode.c linux-2.6.16-rc6-4g/fs/ex
t3/inode.c
--- linux-2.6.16-rc6.org/fs/ext3/inode.c	2006-03-14 09:09:00.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/ext3/inode.c	2006-03-14 09:29:01.000000000 +0900
@@ -64,7 +64,7 @@ static inline int ext3_inode_is_fast_sym
 
 int ext3_forget(handle_t *handle, int is_metadata,
 		       struct inode *inode, struct buffer_head *bh,
-		       int blocknr)
+		       unsigned int blocknr)
 {
 	int err;
 
@@ -235,10 +235,10 @@ no_delete:
 	clear_inode(inode);	/* We must guarantee clearing of inode... */
 }
 
-static int ext3_alloc_block (handle_t *handle,
-			struct inode * inode, unsigned long goal, int *err)
+static unsigned int ext3_alloc_block (handle_t *handle,
+			struct inode * inode, unsigned int goal, int *err)
 {
-	unsigned long result;
+	unsigned int result;
 
 	result = ext3_new_block(handle, inode, goal, err);
 	return result;
@@ -296,7 +296,7 @@ static inline int verify_chain(Indirect 
  */
 
 static int ext3_block_to_path(struct inode *inode,
-			long i_block, int offsets[4], int *boundary)
+			unsigned long i_block, unsigned int offsets[4], int *boundary)
 {
 	int ptrs = EXT3_ADDR_PER_BLOCK(inode->i_sb);
 	int ptrs_bits = EXT3_ADDR_PER_BLOCK_BITS(inode->i_sb);
@@ -363,7 +363,7 @@ static int ext3_block_to_path(struct ino
  *	or when it reads all @depth-1 indirect blocks successfully and finds
  *	the whole chain, all way to the data (returns %NULL, *err == 0).
  */
-static Indirect *ext3_get_branch(struct inode *inode, int depth, int *offsets,
+static Indirect *ext3_get_branch(struct inode *inode, int depth, unsigned int *offsets,
 				 Indirect chain[4], int *err)
 {
 	struct super_block *sb = inode->i_sb;
@@ -460,7 +460,7 @@ static unsigned long ext3_find_near(stru
  *	stores it in *@goal and returns zero.
  */
 
-static unsigned long ext3_find_goal(struct inode *inode, long block,
+static unsigned long ext3_find_goal(struct inode *inode, unsigned long block,
 		Indirect chain[4], Indirect *partial)
 {
 	struct ext3_block_alloc_info *block_i =  EXT3_I(inode)->i_block_alloc_info;
@@ -505,21 +505,21 @@ static unsigned long ext3_find_goal(stru
 static int ext3_alloc_branch(handle_t *handle, struct inode *inode,
 			     int num,
 			     unsigned long goal,
-			     int *offsets,
+			     unsigned int *offsets,
 			     Indirect *branch)
 {
 	int blocksize = inode->i_sb->s_blocksize;
 	int n = 0, keys = 0;
 	int err = 0;
 	int i;
-	int parent = ext3_alloc_block(handle, inode, goal, &err);
+	unsigned int parent = ext3_alloc_block(handle, inode, goal, &err);
 
 	branch[0].key = cpu_to_le32(parent);
 	if (parent) {
 		for (n = 1; n < num; n++) {
 			struct buffer_head *bh;
 			/* Allocate the next block */
-			int nr = ext3_alloc_block(handle, inode, parent, &err);
+			unsigned int nr = ext3_alloc_block(handle, inode, parent, &err);
 			if (!nr)
 				break;
 			branch[n].key = cpu_to_le32(nr);
@@ -585,7 +585,7 @@ static int ext3_alloc_branch(handle_t *h
  *	chain to new block and return 0.
  */
 
-static int ext3_splice_branch(handle_t *handle, struct inode *inode, long block,
+static int ext3_splice_branch(handle_t *handle, struct inode *inode, unsigned long block,
 			      Indirect chain[4], Indirect *where, int num)
 {
 	int i;
@@ -676,7 +676,7 @@ ext3_get_block_handle(handle_t *handle, 
 		struct buffer_head *bh_result, int create, int extend_disksize)
 {
 	int err = -EIO;
-	int offsets[4];
+	unsigned int offsets[4];
 	Indirect chain[4];
 	Indirect *partial;
 	unsigned long goal;
@@ -852,7 +852,7 @@ get_block:
  * `handle' can be NULL if create is zero
  */
 struct buffer_head *ext3_getblk(handle_t *handle, struct inode * inode,
-				long block, int create, int * errp)
+				unsigned long block, int create, int * errp)
 {
 	struct buffer_head dummy;
 	int fatal = 0, err;
@@ -907,7 +907,7 @@ err:
 }
 
 struct buffer_head *ext3_bread(handle_t *handle, struct inode * inode,
-			       int block, int create, int *err)
+			       unsigned int block, int create, int *err)
 {
 	struct buffer_head * bh;
 
@@ -1754,7 +1754,7 @@ static inline int all_zeroes(__le32 *p, 
 
 static Indirect *ext3_find_shared(struct inode *inode,
 				int depth,
-				int offsets[4],
+				unsigned int offsets[4],
 				Indirect chain[4],
 				__le32 *top)
 {
@@ -1967,7 +1967,7 @@ static void ext3_free_branches(handle_t 
 			 */
 			if (!bh) {
 				ext3_error(inode->i_sb, "ext3_free_branches",
-					   "Read failure, inode=%ld, block=%ld",
+					   "Read failure, inode=%lu, block=%lu",
 					   inode->i_ino, nr);
 				continue;
 			}
@@ -2084,12 +2084,12 @@ void ext3_truncate(struct inode * inode)
 	__le32 *i_data = ei->i_data;
 	int addr_per_block = EXT3_ADDR_PER_BLOCK(inode->i_sb);
 	struct address_space *mapping = inode->i_mapping;
-	int offsets[4];
+	unsigned int offsets[4];
 	Indirect chain[4];
 	Indirect *partial;
 	__le32 nr = 0;
 	int n;
-	long last_block;
+	unsigned long last_block;
 	unsigned blocksize = inode->i_sb->s_blocksize;
 	struct page *page;
 
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext3/namei.c linux-2.6.16-rc6-4g/fs/ex
t3/namei.c
--- linux-2.6.16-rc6.org/fs/ext3/namei.c	2006-03-14 09:09:00.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/ext3/namei.c	2006-03-14 09:29:01.000000000 +0900
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
@@ -1910,8 +1911,8 @@ int ext3_orphan_add(handle_t *handle, st
 	if (!err)
 		list_add(&EXT3_I(inode)->i_orphan, &EXT3_SB(sb)->s_orphan);
 
-	jbd_debug(4, "superblock will point to %ld\n", inode->i_ino);
-	jbd_debug(4, "orphan inode %ld will point to %d\n",
+	jbd_debug(4, "superblock will point to %lu\n", inode->i_ino);
+	jbd_debug(4, "orphan inode %lu will point to %d\n",
 			inode->i_ino, NEXT_ORPHAN(inode));
 out_unlock:
 	unlock_super(sb);
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext3/resize.c linux-2.6.16-rc6-4g/fs/e
xt3/resize.c
--- linux-2.6.16-rc6.org/fs/ext3/resize.c	2006-03-14 09:09:00.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/ext3/resize.c	2006-03-14 09:29:01.000000000 +0900
@@ -37,7 +37,7 @@ static int verify_group_input(struct sup
 		 le16_to_cpu(es->s_reserved_gdt_blocks)) : 0;
 	unsigned metaend = start + overhead;
 	struct buffer_head *bh = NULL;
-	int free_blocks_count;
+	long long free_blocks_count;
 	int err = -EINVAL;
 
 	input->free_blocks_count = free_blocks_count =
@@ -45,7 +45,7 @@ static int verify_group_input(struct sup
 
 	if (test_opt(sb, DEBUG))
 		printk(KERN_DEBUG "EXT3-fs: adding %s group %u: %u blocks "
-		       "(%d free, %u reserved)\n",
+		       "(%lld free, %u reserved)\n",
 		       ext3_bg_has_super(sb, input->group) ? "normal" :
 		       "no-super", input->group, input->blocks_count,
 		       free_blocks_count, input->reserved_blocks);
@@ -138,14 +138,14 @@ static struct buffer_head *bclean(handle
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
 
-	ext3_debug("mark end bits +%d through +%d used\n", start_bit, end_bit);
+	ext3_debug("mark end bits +%u through +%u used\n", start_bit, end_bit);
 	for (i = start_bit; i < ((start_bit + 7) & ~7UL); i++)
 		ext3_set_bit(i, bitmap);
 	if (i < end_bit)
@@ -340,7 +340,7 @@ static int verify_reserved_gdb(struct su
 	while ((grp = ext3_list_backups(sb, &three, &five, &seven)) < end) {
 		if (le32_to_cpu(*p++) != grp * EXT3_BLOCKS_PER_GROUP(sb) + blk){
 			ext3_warning(sb, __FUNCTION__,
-				     "reserved GDT %ld missing grp %d (%ld)",
+				     "reserved GDT %ld missing grp %d (%lu)",
 				     blk, grp,
 				     grp * EXT3_BLOCKS_PER_GROUP(sb) + blk);
 			return -EINVAL;
@@ -619,7 +619,7 @@ exit_free:
  * at this time.  The resize which changed s_groups_count will backup again.
  */
 static void update_backups(struct super_block *sb,
-			   int blk_off, char *data, int size)
+			   unsigned int blk_off, char *data, int size)
 {
 	struct ext3_sb_info *sbi = EXT3_SB(sb);
 	const unsigned long last = sbi->s_groups_count;
@@ -869,9 +869,9 @@ int ext3_group_add(struct super_block *s
 		input->reserved_blocks);
 
 	/* Update the free space counts */
-	percpu_counter_mod(&sbi->s_freeblocks_counter,
+	percpu_llcounter_mod(&sbi->s_freeblocks_counter,
 			   input->free_blocks_count);
-	percpu_counter_mod(&sbi->s_freeinodes_counter,
+	percpu_llcounter_mod(&sbi->s_freeinodes_counter,
 			   EXT3_INODES_PER_GROUP(sb));
 
 	ext3_journal_dirty_metadata(handle, sbi->s_sbh);
@@ -990,10 +990,10 @@ int ext3_group_extend(struct super_block
 	ext3_journal_dirty_metadata(handle, EXT3_SB(sb)->s_sbh);
 	sb->s_dirt = 1;
 	unlock_super(sb);
-	ext3_debug("freeing blocks %ld through %ld\n", o_blocks_count,
+	ext3_debug("freeing blocks %lu through %lu\n", o_blocks_count,
 		   o_blocks_count + add);
 	ext3_free_blocks_sb(handle, sb, o_blocks_count, add, &freed_blocks);
-	ext3_debug("freed blocks %ld through %ld\n", o_blocks_count,
+	ext3_debug("freed blocks %lu through %lu\n", o_blocks_count,
 		   o_blocks_count + add);
 	if ((err = ext3_journal_stop(handle)))
 		goto exit_put;
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext3/super.c linux-2.6.16-rc6-4g/fs/ex
t3/super.c
--- linux-2.6.16-rc6.org/fs/ext3/super.c	2006-03-14 09:09:00.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/ext3/super.c	2006-03-14 09:29:01.000000000 +0900
@@ -377,7 +377,7 @@ static void dump_orphan_list(struct supe
 	list_for_each(l, &sbi->s_orphan) {
 		struct inode *inode = orphan_list_entry(l);
 		printk(KERN_ERR "  "
-		       "inode %s:%ld at %p: mode %o, nlink %d, next %d\n",
+		       "inode %s:%lu at %p: mode %o, nlink %d, next %d\n",
 		       inode->i_sb->s_id, inode->i_ino, inode,
 		       inode->i_mode, inode->i_nlink, 
 		       NEXT_ORPHAN(inode));
@@ -403,9 +403,9 @@ static void ext3_put_super (struct super
 	for (i = 0; i < sbi->s_gdb_count; i++)
 		brelse(sbi->s_group_desc[i]);
 	kfree(sbi->s_group_desc);
-	percpu_counter_destroy(&sbi->s_freeblocks_counter);
-	percpu_counter_destroy(&sbi->s_freeinodes_counter);
-	percpu_counter_destroy(&sbi->s_dirs_counter);
+	percpu_llcounter_destroy(&sbi->s_freeblocks_counter);
+	percpu_llcounter_destroy(&sbi->s_freeinodes_counter);
+	percpu_llcounter_destroy(&sbi->s_dirs_counter);
 	brelse(sbi->s_sbh);
 #ifdef CONFIG_QUOTA
 	for (i = 0; i < MAXQUOTAS; i++)
@@ -1253,17 +1253,17 @@ static void ext3_orphan_cleanup (struct 
 		DQUOT_INIT(inode);
 		if (inode->i_nlink) {
 			printk(KERN_DEBUG
-				"%s: truncating inode %ld to %Ld bytes\n",
+				"%s: truncating inode %lu to %Ld bytes\n",
 				__FUNCTION__, inode->i_ino, inode->i_size);
-			jbd_debug(2, "truncating inode %ld to %Ld bytes\n",
+			jbd_debug(2, "truncating inode %lu to %Ld bytes\n",
 				  inode->i_ino, inode->i_size);
 			ext3_truncate(inode);
 			nr_truncates++;
 		} else {
 			printk(KERN_DEBUG
-				"%s: deleting unreferenced inode %ld\n",
+				"%s: deleting unreferenced inode %lu\n",
 				__FUNCTION__, inode->i_ino);
-			jbd_debug(2, "deleting unreferenced inode %ld\n",
+			jbd_debug(2, "deleting unreferenced inode %lu\n",
 				  inode->i_ino);
 			nr_orphans++;
 		}
@@ -1578,9 +1578,9 @@ static int ext3_fill_super (struct super
 		goto failed_mount;
 	}
 
-	percpu_counter_init(&sbi->s_freeblocks_counter);
-	percpu_counter_init(&sbi->s_freeinodes_counter);
-	percpu_counter_init(&sbi->s_dirs_counter);
+	percpu_llcounter_init(&sbi->s_freeblocks_counter);
+	percpu_llcounter_init(&sbi->s_freeinodes_counter);
+	percpu_llcounter_init(&sbi->s_dirs_counter);
 	bgl_lock_init(&sbi->s_blockgroup_lock);
 
 	for (i = 0; i < db_count; i++) {
@@ -1728,11 +1728,11 @@ static int ext3_fill_super (struct super
 		test_opt(sb,DATA_FLAGS) == EXT3_MOUNT_ORDERED_DATA ? "ordered":
 		"writeback");
 
-	percpu_counter_mod(&sbi->s_freeblocks_counter,
+	percpu_llcounter_mod(&sbi->s_freeblocks_counter,
 		ext3_count_free_blocks(sb));
-	percpu_counter_mod(&sbi->s_freeinodes_counter,
+	percpu_llcounter_mod(&sbi->s_freeinodes_counter,
 		ext3_count_free_inodes(sb));
-	percpu_counter_mod(&sbi->s_dirs_counter,
+	percpu_llcounter_mod(&sbi->s_dirs_counter,
 		ext3_count_dirs(sb));
 
 	lock_kernel();
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/ext3/xattr.c linux-2.6.16-rc6-4g/fs/ex
t3/xattr.c
--- linux-2.6.16-rc6.org/fs/ext3/xattr.c	2006-03-14 09:09:00.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/ext3/xattr.c	2006-03-14 09:29:01.000000000 +0900
@@ -75,7 +75,7 @@
 
 #ifdef EXT3_XATTR_DEBUG
 # define ea_idebug(inode, f...) do { \
-		printk(KERN_DEBUG "inode %s:%ld: ", \
+		printk(KERN_DEBUG "inode %s:%lu: ", \
 			inode->i_sb->s_id, inode->i_ino); \
 		printk(f); \
 		printk("\n"); \
@@ -225,7 +225,7 @@ ext3_xattr_block_get(struct inode *inode
 	error = -ENODATA;
 	if (!EXT3_I(inode)->i_file_acl)
 		goto cleanup;
-	ea_idebug(inode, "reading block %d", EXT3_I(inode)->i_file_acl);
+	ea_idebug(inode, "reading block %u", EXT3_I(inode)->i_file_acl);
 	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
 	if (!bh)
 		goto cleanup;
@@ -233,7 +233,7 @@ ext3_xattr_block_get(struct inode *inode
 		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
 	if (ext3_xattr_check_block(bh)) {
 bad_block:	ext3_error(inode->i_sb, __FUNCTION__,
-			   "inode %ld: bad block %d", inode->i_ino,
+			   "inode %lu: bad block %u", inode->i_ino,
 			   EXT3_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -366,7 +366,7 @@ ext3_xattr_block_list(struct inode *inod
 	error = 0;
 	if (!EXT3_I(inode)->i_file_acl)
 		goto cleanup;
-	ea_idebug(inode, "reading block %d", EXT3_I(inode)->i_file_acl);
+	ea_idebug(inode, "reading block %u", EXT3_I(inode)->i_file_acl);
 	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
 	error = -EIO;
 	if (!bh)
@@ -375,7 +375,7 @@ ext3_xattr_block_list(struct inode *inod
 		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
 	if (ext3_xattr_check_block(bh)) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			   "inode %ld: bad block %d", inode->i_ino,
+			   "inode %lu: bad block %u", inode->i_ino,
 			   EXT3_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -647,7 +647,7 @@ ext3_xattr_block_find(struct inode *inod
 			le32_to_cpu(BHDR(bs->bh)->h_refcount));
 		if (ext3_xattr_check_block(bs->bh)) {
 			ext3_error(sb, __FUNCTION__,
-				"inode %ld: bad block %d", inode->i_ino,
+				"inode %lu: bad block %u", inode->i_ino,
 				EXT3_I(inode)->i_file_acl);
 			error = -EIO;
 			goto cleanup;
@@ -792,14 +792,14 @@ inserted:
 			get_bh(new_bh);
 		} else {
 			/* We need to allocate a new block */
-			int goal = le32_to_cpu(
+			unsigned int goal = le32_to_cpu(
 					EXT3_SB(sb)->s_es->s_first_data_block) +
 				EXT3_I(inode)->i_block_group *
 				EXT3_BLOCKS_PER_GROUP(sb);
-			int block = ext3_new_block(handle, inode, goal, &error);
+			unsigned int block = ext3_new_block(handle, inode, goal, &error);
 			if (error)
 				goto cleanup;
-			ea_idebug(inode, "creating block %d", block);
+			ea_idebug(inode, "creating block %u", block);
 
 			new_bh = sb_getblk(sb, block);
 			if (!new_bh) {
@@ -847,7 +847,7 @@ cleanup_dquot:
 
 bad_block:
 	ext3_error(inode->i_sb, __FUNCTION__,
-		   "inode %ld: bad block %d", inode->i_ino,
+		   "inode %lu: bad block %u", inode->i_ino,
 		   EXT3_I(inode)->i_file_acl);
 	goto cleanup;
 
@@ -1076,14 +1076,14 @@ ext3_xattr_delete_inode(handle_t *handle
 	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
 	if (!bh) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			"inode %ld: block %d read error", inode->i_ino,
+			"inode %lu: block %u read error", inode->i_ino,
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
 	if (BHDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
 	    BHDR(bh)->h_blocks != cpu_to_le32(1)) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			"inode %ld: bad block %d", inode->i_ino,
+			"inode %lu: bad block %u", inode->i_ino,
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
@@ -1210,11 +1210,11 @@ again:
 		bh = sb_bread(inode->i_sb, ce->e_block);
 		if (!bh) {
 			ext3_error(inode->i_sb, __FUNCTION__,
-				"inode %ld: block %ld read error",
+				"inode %lu: block %lu read error",
 				inode->i_ino, (unsigned long) ce->e_block);
 		} else if (le32_to_cpu(BHDR(bh)->h_refcount) >=
 				EXT3_XATTR_REFCOUNT_MAX) {
-			ea_idebug(inode, "block %ld refcount %d>=%d",
+			ea_idebug(inode, "block %lu refcount %d>=%d",
 				  (unsigned long) ce->e_block,
 				  le32_to_cpu(BHDR(bh)->h_refcount),
 					  EXT3_XATTR_REFCOUNT_MAX);
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/fs/jbd/journal.c linux-2.6.16-rc6-4g/fs/j
bd/journal.c
--- linux-2.6.16-rc6.org/fs/jbd/journal.c	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.16-rc6-4g/fs/jbd/journal.c	2006-03-14 09:29:01.000000000 +0900
@@ -761,7 +761,7 @@ journal_t * journal_init_inode (struct i
 	journal->j_dev = journal->j_fs_dev = inode->i_sb->s_bdev;
 	journal->j_inode = inode;
 	jbd_debug(1,
-		  "journal %p: inode %s/%ld, size %Ld, bits %d, blksize %ld\n",
+		  "journal %p: inode %s/%u, size %Ld, bits %d, blksize %ld\n",
 		  journal, inode->i_sb->s_id, inode->i_ino, 
 		  (long long) inode->i_size,
 		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/include/linux/ext2_fs_sb.h linux-2.6.16-r
c6-4g/include/linux/ext2_fs_sb.h
--- linux-2.6.16-rc6.org/include/linux/ext2_fs_sb.h	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.16-rc6-4g/include/linux/ext2_fs_sb.h	2006-03-14 12:06:21.000000000 +0900
@@ -17,7 +17,7 @@
 #define _LINUX_EXT2_FS_SB
 
 #include <linux/blockgroup_lock.h>
-#include <linux/percpu_counter.h>
+#include <linux/percpu_llcounter.h>
 
 /*
  * second extended-fs super-block data in memory
@@ -49,9 +49,9 @@ struct ext2_sb_info {
 	u32 s_next_generation;
 	unsigned long s_dir_count;
 	u8 *s_debts;
-	struct percpu_counter s_freeblocks_counter;
-	struct percpu_counter s_freeinodes_counter;
-	struct percpu_counter s_dirs_counter;
+	struct percpu_llcounter s_freeblocks_counter;
+	struct percpu_llcounter s_freeinodes_counter;
+	struct percpu_llcounter s_dirs_counter;
 	struct blockgroup_lock s_blockgroup_lock;
 };
 
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/include/linux/ext3_fs.h linux-2.6.16-rc6-
4g/include/linux/ext3_fs.h
--- linux-2.6.16-rc6.org/include/linux/ext3_fs.h	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.16-rc6-4g/include/linux/ext3_fs.h	2006-03-14 09:29:01.000000000 +0900
@@ -731,7 +731,7 @@ struct dir_private_info {
 /* balloc.c */
 extern int ext3_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext3_bg_num_gdb(struct super_block *sb, int group);
-extern int ext3_new_block (handle_t *, struct inode *, unsigned long, int *);
+extern unsigned int ext3_new_block (handle_t *, struct inode *, unsigned long, int *);
 extern void ext3_free_blocks (handle_t *, struct inode *, unsigned long,
 			      unsigned long);
 extern void ext3_free_blocks_sb (handle_t *, struct super_block *,
@@ -761,7 +761,6 @@ extern int ext3_sync_file (struct file *
 extern int ext3fs_dirhash(const char *name, int len, struct
 			  dx_hash_info *hinfo);
 
-/* ialloc.c */
 extern struct inode * ext3_new_inode (handle_t *, struct inode *, int);
 extern void ext3_free_inode (handle_t *, struct inode *);
 extern struct inode * ext3_orphan_get (struct super_block *, unsigned long);
@@ -772,9 +771,9 @@ extern unsigned long ext3_count_free (st
 
 
 /* inode.c */
-extern int ext3_forget(handle_t *, int, struct inode *, struct buffer_head *, int);
-extern struct buffer_head * ext3_getblk (handle_t *, struct inode *, long, int, int *);
-extern struct buffer_head * ext3_bread (handle_t *, struct inode *, int, int, int *);
+extern int ext3_forget(handle_t *, int, struct inode *, struct buffer_head *, unsigned int);
+extern struct buffer_head * ext3_getblk (handle_t *, struct inode *, unsigned long, int, int *);
+extern struct buffer_head * ext3_bread (handle_t *, struct inode *, unsigned int, int, int *);
 
 extern void ext3_read_inode (struct inode *);
 extern int  ext3_write_inode (struct inode *, int);
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/include/linux/ext3_fs_sb.h linux-2.6.16-r
c6-4g/include/linux/ext3_fs_sb.h
--- linux-2.6.16-rc6.org/include/linux/ext3_fs_sb.h	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.16-rc6-4g/include/linux/ext3_fs_sb.h	2006-03-14 12:06:35.000000000 +0900
@@ -20,7 +20,7 @@
 #include <linux/timer.h>
 #include <linux/wait.h>
 #include <linux/blockgroup_lock.h>
-#include <linux/percpu_counter.h>
+#include <linux/percpu_llcounter.h>
 #endif
 #include <linux/rbtree.h>
 
@@ -54,9 +54,9 @@ struct ext3_sb_info {
 	u32 s_next_generation;
 	u32 s_hash_seed[4];
 	int s_def_hash_version;
-	struct percpu_counter s_freeblocks_counter;
-	struct percpu_counter s_freeinodes_counter;
-	struct percpu_counter s_dirs_counter;
+	struct percpu_llcounter s_freeblocks_counter;
+	struct percpu_llcounter s_freeinodes_counter;
+	struct percpu_llcounter s_dirs_counter;
 	struct blockgroup_lock s_blockgroup_lock;
 
 	/* root of the per fs reservation window tree */
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/include/linux/percpu_llcounter.h linux-2.
6.16-rc6-4g/include/linux/percpu_llcounter.h
--- linux-2.6.16-rc6.org/include/linux/percpu_llcounter.h	1970-01-01 09:00:00.000000000 +0900
+++ linux-2.6.16-rc6-4g/include/linux/percpu_llcounter.h	2006-03-14 13:50:54.000000000 +0900
@@ -0,0 +1,113 @@
+#ifndef _LINUX_LLPERCPU_COUNTER_H
+#define _LINUX_LLPERCPU_COUNTER_H
+/*
+ * A simple "approximate counter" for use in ext2 and ext3 superblocks.
+ *
+ * WARNING: these things are HUGE.  4 kbytes per counter on 32-way P4.
+ */
+
+#include <linux/config.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+#include <linux/percpu.h>
+
+#ifdef CONFIG_SMP
+
+struct percpu_llcounter {
+	spinlock_t lock;
+	long long count;
+	long long *counters;
+};
+
+#if NR_CPUS >= 16
+#define FBC_BATCH	(NR_CPUS*2)
+#else
+#define FBC_BATCH	(NR_CPUS*4)
+#endif
+
+static inline void percpu_llcounter_init(struct percpu_llcounter *fbc)
+{
+	spin_lock_init(&fbc->lock);
+	fbc->count = 0;
+	fbc->counters = alloc_percpu(long long);
+}
+
+static inline void percpu_llcounter_destroy(struct percpu_llcounter *fbc)
+{
+	free_percpu(fbc->counters);
+}
+
+void percpu_llcounter_mod(struct percpu_llcounter *fbc, long long amount);
+long long percpu_llcounter_sum(struct percpu_llcounter *fbc);
+
+static inline long long percpu_llcounter_read(struct percpu_llcounter *fbc)
+{
+	return fbc->count;
+}
+
+/*
+ * It is possible for the percpu_llcounter_read() to return a small negative
+ * number for some counter which should never be negative.
+ */
+static inline long long percpu_llcounter_read_positive(struct percpu_llcounter *fbc)
+{
+	long long ret = fbc->count;
+
+	barrier();		/* Prevent reloads of fbc->count */
+	if (ret > 0)
+		return ret;
+	return 1;
+}
+
+#else
+
+struct percpu_llcounter {
+	long long count;
+};
+
+static inline void percpu_llcounter_init(struct percpu_llcounter *fbc)
+{
+	fbc->count = 0;
+}
+
+static inline void percpu_llcounter_destroy(struct percpu_llcounter *fbc)
+{
+}
+
+static inline void
+percpu_llcounter_mod(struct percpu_llcounter *fbc, long long amount)
+{
+	preempt_disable();
+	fbc->count += amount;
+	preempt_enable();
+}
+
+static inline long long percpu_llcounter_read(struct percpu_llcounter *fbc)
+{
+	return fbc->count;
+}
+
+static inline long long percpu_llcounter_read_positive(struct percpu_llcounter *fbc)
+{
+	return fbc->count;
+}
+
+static inline long long percpu_llcounter_sum(struct percpu_llcounter *fbc)
+{
+	return percpu_llcounter_read_positive(fbc);
+}
+
+#endif	/* CONFIG_SMP */
+
+static inline void percpu_llcounter_inc(struct percpu_llcounter *fbc)
+{
+	percpu_llcounter_mod(fbc, 1);
+}
+
+static inline void percpu_llcounter_dec(struct percpu_llcounter *fbc)
+{
+	percpu_llcounter_mod(fbc, -1);
+}
+
+#endif /* _LINUX_LLPERCPU_COUNTER_H */
diff -uprN -X linux-2.6.16-rc6.org/Documentation/dontdiff linux-2.6.16-rc6.org/mm/swap.c linux-2.6.16-rc6-4g/mm/swap.c
--- linux-2.6.16-rc6.org/mm/swap.c	2006-03-14 09:09:07.000000000 +0900
+++ linux-2.6.16-rc6-4g/mm/swap.c	2006-03-14 13:47:18.000000000 +0900
@@ -26,6 +26,7 @@
 #include <linux/buffer_head.h>	/* for try_to_release_page() */
 #include <linux/module.h>
 #include <linux/percpu_counter.h>
+#include <linux/percpu_llcounter.h>
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
@@ -498,6 +499,27 @@ void percpu_counter_mod(struct percpu_co
 }
 EXPORT_SYMBOL(percpu_counter_mod);
 
+void percpu_llcounter_mod(struct percpu_llcounter *fbc, long long amount)
+{
+	long long count;
+	long long *pcount;
+	int cpu = get_cpu();
+
+	pcount = per_cpu_ptr(fbc->counters, cpu);
+	count = *pcount + amount;
+	if (count >= FBC_BATCH || count <= -FBC_BATCH) {
+		spin_lock(&fbc->lock);
+		fbc->count += count;
+		*pcount = 0;
+		spin_unlock(&fbc->lock);
+	} else {
+		*pcount = count;
+	}
+	put_cpu();
+}
+EXPORT_SYMBOL(percpu_llcounter_mod);
+
+
 /*
  * Add up all the per-cpu counts, return the result.  This is a more accurate
  * but much slower version of percpu_counter_read_positive()
@@ -517,6 +539,26 @@ long percpu_counter_sum(struct percpu_co
 	return ret < 0 ? 0 : ret;
 }
 EXPORT_SYMBOL(percpu_counter_sum);
+
+/*
+ * Add up all the per-cpu counts, return the result.  This is a more accurate
+ * but much slower version of percpu_llcounter_read_positive()
+ */
+long long percpu_llcounter_sum(struct percpu_llcounter *fbc)
+{
+	long long ret;
+	int cpu;
+
+	spin_lock(&fbc->lock);
+	ret = fbc->count;
+	for_each_cpu(cpu) {
+		long long *pcount = per_cpu_ptr(fbc->counters, cpu);
+		ret += *pcount;
+	}
+	spin_unlock(&fbc->lock);
+	return ret < 0 ? 0 : ret;
+}
+EXPORT_SYMBOL(percpu_llcounter_sum);
 #endif
 
 /*

