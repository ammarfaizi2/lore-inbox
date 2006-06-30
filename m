Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWF3Giw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWF3Giw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 02:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWF3Giw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 02:38:52 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:44797 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1751173AbWF3Giu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 02:38:50 -0400
To: jitendra@linsyssoft.com, adilger@clusterfs.com, cmm@us.ibm.com
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [RFC][PATCH 1/3] add ext2_fsblk_t for filesystem relative blocks
Message-Id: <20060630153829sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Fri, 30 Jun 2006 15:38:29 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/3] ext2_fsblk_t.patch
This patch converts ext2 filesystem relative blocks to ext2_fsblk_t.

Signed-off-by: Takashi Sato <sho@tnes.nec.co.jp>
---
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/fs/ext2/balloc.c linux-2.6.17.tmp/fs/ext2/balloc.c
--- linux-2.6.17/fs/ext2/balloc.c	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.tmp/fs/ext2/balloc.c	2006-06-29 21:24:37.000000000 +0900
@@ -103,8 +103,8 @@ static int reserve_blocks(struct super_b
 {
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct ext2_super_block *es = sbi->s_es;
-	unsigned free_blocks;
-	unsigned root_blocks;
+	ext2_fsblk_t free_blocks;
+	ext2_fsblk_t root_blocks;
 
 	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
 	root_blocks = le32_to_cpu(es->s_r_blocks_count);
@@ -175,20 +175,21 @@ static void group_release_blocks(struct 
 }
 
 /* Free given blocks, update quota and i_blocks field */
-void ext2_free_blocks (struct inode * inode, unsigned long block,
-		       unsigned long count)
+void ext2_free_blocks (struct inode * inode, ext2_fsblk_t block,
+		       ext2_fsblk_t count)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head * bh2;
 	unsigned long block_group;
 	unsigned long bit;
 	unsigned long i;
-	unsigned long overflow;
+	ext2_fsblk_t overflow;
 	struct super_block * sb = inode->i_sb;
 	struct ext2_sb_info * sbi = EXT2_SB(sb);
 	struct ext2_group_desc * desc;
 	struct ext2_super_block * es = sbi->s_es;
-	unsigned freed = 0, group_freed;
+	ext2_fsblk_t freed = 0;
+	unsigned group_freed;
 
 	if (block < le32_to_cpu(es->s_first_data_block) ||
 	    block + count < block ||
@@ -324,8 +325,8 @@ got_it:
  * bitmap, and then for any free bit if that fails.
  * This function also updates quota and i_blocks field.
  */
-int ext2_new_block(struct inode *inode, unsigned long goal,
-			u32 *prealloc_count, u32 *prealloc_block, int *err)
+ext2_fsblk_t ext2_new_block(struct inode *inode, ext2_fsblk_t goal,
+			ext2_fsblk_t *prealloc_count, ext2_fsblk_t *prealloc_block, int *err)
 {
 	struct buffer_head *bitmap_bh = NULL;
 	struct buffer_head *gdp_bh;	/* bh2 */
@@ -333,14 +334,15 @@ int ext2_new_block(struct inode *inode, 
 	int group_no;			/* i */
 	int ret_block;			/* j */
 	int group_idx;			/* k */
-	int target_block;		/* tmp */
-	int block = 0;
+	ext2_fsblk_t target_block;		/* tmp */
+	ext2_fsblk_t block = 0;
 	struct super_block *sb = inode->i_sb;
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
 	struct ext2_super_block *es = sbi->s_es;
 	unsigned group_size = EXT2_BLOCKS_PER_GROUP(sb);
 	unsigned prealloc_goal = es->s_prealloc_blocks;
-	unsigned group_alloc = 0, es_alloc, dq_alloc;
+	unsigned group_alloc = 0;
+	ext2_fsblk_t es_alloc, dq_alloc;
 	int nr_scanned_groups;
 
 	if (!prealloc_goal--)
@@ -461,7 +463,7 @@ got_block:
 		      sbi->s_itb_per_group))
 		ext2_error (sb, "ext2_new_block",
 			    "Allocating block in system zone - "
-			    "block = %u", target_block);
+			    "block = %lu", target_block);
 
 	if (target_block >= le32_to_cpu(es->s_blocks_count)) {
 		ext2_error (sb, "ext2_new_block",
@@ -504,7 +506,7 @@ got_block:
 	if (sb->s_flags & MS_SYNCHRONOUS)
 		sync_dirty_buffer(bitmap_bh);
 
-	ext2_debug ("allocating block %d. ", block);
+	ext2_debug ("allocating block %lu. ", block);
 
 	*err = 0;
 out_release:
@@ -521,13 +523,14 @@ io_error:
 	goto out_release;
 }
 
-unsigned long ext2_count_free_blocks (struct super_block * sb)
+ext2_fsblk_t ext2_count_free_blocks (struct super_block * sb)
 {
 	struct ext2_group_desc * desc;
-	unsigned long desc_count = 0;
+	ext2_fsblk_t desc_count = 0;
 	int i;
 #ifdef EXT2FS_DEBUG
-	unsigned long bitmap_count, x;
+	ext2_fsblk_t bitmap_count;
+	unsigned long x;
 	struct ext2_super_block *es;
 
 	lock_super (sb);
@@ -568,7 +571,7 @@ unsigned long ext2_count_free_blocks (st
 }
 
 static inline int
-block_in_use(unsigned long block, struct super_block *sb, unsigned char *map)
+block_in_use(ext2_fsblk_t block, struct super_block *sb, unsigned char *map)
 {
 	return ext2_test_bit ((block -
 		le32_to_cpu(EXT2_SB(sb)->s_es->s_first_data_block)) %
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/fs/ext2/ext2.h linux-2.6.17.tmp/fs/ext2/ext2.h
--- linux-2.6.17/fs/ext2/ext2.h	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.tmp/fs/ext2/ext2.h	2006-06-29 21:24:37.000000000 +0900
@@ -20,7 +20,7 @@ struct ext2_inode_info {
 	__u8	i_frag_no;
 	__u8	i_frag_size;
 	__u16	i_state;
-	__u32	i_file_acl;
+	ext2_fsblk_t	i_file_acl;
 	__u32	i_dir_acl;
 	__u32	i_dtime;
 
@@ -46,9 +46,9 @@ struct ext2_inode_info {
 	 * allocated to this file.  This give us the goal (target) for the next
 	 * allocation when we detect linearly ascending requests.
 	 */
-	__u32	i_next_alloc_goal;
-	__u32	i_prealloc_block;
-	__u32	i_prealloc_count;
+	ext2_fsblk_t	i_next_alloc_goal;
+	ext2_fsblk_t	i_prealloc_block;
+	ext2_fsblk_t	i_prealloc_count;
 	__u32	i_dir_start_lookup;
 #ifdef CONFIG_EXT2_FS_XATTR
 	/*
@@ -91,11 +91,11 @@ static inline struct ext2_inode_info *EX
 /* balloc.c */
 extern int ext2_bg_has_super(struct super_block *sb, int group);
 extern unsigned long ext2_bg_num_gdb(struct super_block *sb, int group);
-extern int ext2_new_block (struct inode *, unsigned long,
-			   __u32 *, __u32 *, int *);
-extern void ext2_free_blocks (struct inode *, unsigned long,
-			      unsigned long);
-extern unsigned long ext2_count_free_blocks (struct super_block *);
+extern ext2_fsblk_t ext2_new_block (struct inode *, ext2_fsblk_t,
+			   ext2_fsblk_t *, ext2_fsblk_t *, int *);
+extern void ext2_free_blocks (struct inode *, ext2_fsblk_t,
+			      ext2_fsblk_t);
+extern ext2_fsblk_t ext2_count_free_blocks (struct super_block *);
 extern unsigned long ext2_count_dirs (struct super_block *);
 extern void ext2_check_blocks_bitmap (struct super_block *);
 extern struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/fs/ext2/ialloc.c linux-2.6.17.tmp/fs/ext2/ialloc.c
--- linux-2.6.17/fs/ext2/ialloc.c	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.tmp/fs/ext2/ialloc.c	2006-06-29 21:24:37.000000000 +0900
@@ -177,7 +177,7 @@ static void ext2_preread_inode(struct in
 {
 	unsigned long block_group;
 	unsigned long offset;
-	unsigned long block;
+	ext2_fsblk_t block;
 	struct buffer_head *bh;
 	struct ext2_group_desc * gdp;
 	struct backing_dev_info *bdi;
@@ -278,7 +278,7 @@ static int find_group_orlov(struct super
 	int inodes_per_group = EXT2_INODES_PER_GROUP(sb);
 	int freei;
 	int avefreei;
-	int free_blocks;
+	ext2_fsblk_t free_blocks;
 	int avefreeb;
 	int blocks_per_dir;
 	int ndirs;
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/fs/ext2/inode.c linux-2.6.17.tmp/fs/ext2/inode.c
--- linux-2.6.17/fs/ext2/inode.c	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.tmp/fs/ext2/inode.c	2006-06-29 21:24:37.000000000 +0900
@@ -95,8 +95,8 @@ void ext2_discard_prealloc (struct inode
 	struct ext2_inode_info *ei = EXT2_I(inode);
 	write_lock(&ei->i_meta_lock);
 	if (ei->i_prealloc_count) {
-		unsigned short total = ei->i_prealloc_count;
-		unsigned long block = ei->i_prealloc_block;
+		ext2_fsblk_t total = ei->i_prealloc_count;
+		ext2_fsblk_t block = ei->i_prealloc_block;
 		ei->i_prealloc_count = 0;
 		ei->i_prealloc_block = 0;
 		write_unlock(&ei->i_meta_lock);
@@ -107,12 +107,12 @@ void ext2_discard_prealloc (struct inode
 #endif
 }
 
-static int ext2_alloc_block (struct inode * inode, unsigned long goal, int *err)
+static ext2_fsblk_t ext2_alloc_block (struct inode * inode, ext2_fsblk_t goal, int *err)
 {
 #ifdef EXT2FS_DEBUG
 	static unsigned long alloc_hits, alloc_attempts;
 #endif
-	unsigned long result;
+	ext2_fsblk_t result;
 
 
 #ifdef EXT2_PREALLOCATE
@@ -326,7 +326,7 @@ static unsigned long ext2_find_near(stru
 	struct ext2_inode_info *ei = EXT2_I(inode);
 	__le32 *start = ind->bh ? (__le32 *) ind->bh->b_data : ei->i_data;
 	__le32 *p;
-	unsigned long bg_start;
+	ext2_fsblk_t bg_start;
 	unsigned long colour;
 
 	/* Try to find previous block */
@@ -366,7 +366,7 @@ static inline int ext2_find_goal(struct 
 				 long block,
 				 Indirect chain[4],
 				 Indirect *partial,
-				 unsigned long *goal)
+				 ext2_fsblk_t *goal)
 {
 	struct ext2_inode_info *ei = EXT2_I(inode);
 	write_lock(&ei->i_meta_lock);
@@ -417,7 +417,7 @@ static inline int ext2_find_goal(struct 
 
 static int ext2_alloc_branch(struct inode *inode,
 			     int num,
-			     unsigned long goal,
+			     ext2_fsblk_t goal,
 			     int *offsets,
 			     Indirect *branch)
 {
@@ -425,13 +425,13 @@ static int ext2_alloc_branch(struct inod
 	int n = 0;
 	int err;
 	int i;
-	int parent = ext2_alloc_block(inode, goal, &err);
+	ext2_fsblk_t parent = ext2_alloc_block(inode, goal, &err);
 
 	branch[0].key = cpu_to_le32(parent);
 	if (parent) for (n = 1; n < num; n++) {
 		struct buffer_head *bh;
 		/* Allocate the next block */
-		int nr = ext2_alloc_block(inode, parent, &err);
+		ext2_fsblk_t nr = ext2_alloc_block(inode, parent, &err);
 		if (!nr)
 			break;
 		branch[n].key = cpu_to_le32(nr);
@@ -550,7 +550,7 @@ int ext2_get_block(struct inode *inode, 
 	int offsets[4];
 	Indirect chain[4];
 	Indirect *partial;
-	unsigned long goal;
+	ext2_fsblk_t goal;
 	int left;
 	int boundary = 0;
 	int depth = ext2_block_to_path(inode, iblock, offsets, &boundary);
@@ -823,8 +823,8 @@ no_top:
  */
 static inline void ext2_free_data(struct inode *inode, __le32 *p, __le32 *q)
 {
-	unsigned long block_to_free = 0, count = 0;
-	unsigned long nr;
+	ext2_fsblk_t block_to_free = 0, count = 0;
+	ext2_fsblk_t nr;
 
 	for ( ; p < q ; p++) {
 		nr = le32_to_cpu(*p);
@@ -864,7 +864,7 @@ static inline void ext2_free_data(struct
 static void ext2_free_branches(struct inode *inode, __le32 *p, __le32 *q, int depth)
 {
 	struct buffer_head * bh;
-	unsigned long nr;
+	ext2_fsblk_t nr;
 
 	if (depth--) {
 		int addr_per_block = EXT2_ADDR_PER_BLOCK(inode->i_sb);
@@ -1000,7 +1000,7 @@ static struct ext2_inode *ext2_get_inode
 {
 	struct buffer_head * bh;
 	unsigned long block_group;
-	unsigned long block;
+	ext2_fsblk_t block;
 	unsigned long offset;
 	struct ext2_group_desc * gdp;
 
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/fs/ext2/super.c linux-2.6.17.tmp/fs/ext2/super.c
--- linux-2.6.17/fs/ext2/super.c	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.tmp/fs/ext2/super.c	2006-06-29 21:24:37.000000000 +0900
@@ -261,9 +261,9 @@ static struct export_operations ext2_exp
 	.get_parent = ext2_get_parent,
 };
 
-static unsigned long get_sb_block(void **data)
+static ext2_fsblk_t get_sb_block(void **data)
 {
-	unsigned long 	sb_block;
+	ext2_fsblk_t 	sb_block;
 	char 		*options = (char *) *data;
 
 	if (!options || strncmp(options, "sb=", 3) != 0)
@@ -506,7 +506,7 @@ static int ext2_check_descriptors (struc
 	int i;
 	int desc_block = 0;
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
-	unsigned long block = le32_to_cpu(sbi->s_es->s_first_data_block);
+	ext2_fsblk_t block = le32_to_cpu(sbi->s_es->s_first_data_block);
 	struct ext2_group_desc * gdp = NULL;
 
 	ext2_debug ("Checking group descriptors");
@@ -574,12 +574,13 @@ static loff_t ext2_max_size(int bits)
 	return res;
 }
 
-static unsigned long descriptor_loc(struct super_block *sb,
-				    unsigned long logic_sb_block,
+static ext2_fsblk_t descriptor_loc(struct super_block *sb,
+				    ext2_fsblk_t logic_sb_block,
 				    int nr)
 {
 	struct ext2_sb_info *sbi = EXT2_SB(sb);
-	unsigned long bg, first_data_block, first_meta_bg;
+	unsigned long bg, first_meta_bg;
+	ext2_fsblk_t first_data_block;
 	int has_super = 0;
 	
 	first_data_block = le32_to_cpu(sbi->s_es->s_first_data_block);
@@ -600,9 +601,9 @@ static int ext2_fill_super(struct super_
 	struct ext2_sb_info * sbi;
 	struct ext2_super_block * es;
 	struct inode *root;
-	unsigned long block;
-	unsigned long sb_block = get_sb_block(&data);
-	unsigned long logic_sb_block;
+	ext2_fsblk_t block;
+	ext2_fsblk_t sb_block = get_sb_block(&data);
+	ext2_fsblk_t logic_sb_block;
 	unsigned long offset = 0;
 	unsigned long def_mount_opts;
 	int blocksize = BLOCK_SIZE;
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/fs/ext2/xattr.c linux-2.6.17.tmp/fs/ext2/xattr.c
--- linux-2.6.17/fs/ext2/xattr.c	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.tmp/fs/ext2/xattr.c	2006-06-29 21:24:37.000000000 +0900
@@ -175,7 +175,7 @@ ext2_xattr_get(struct inode *inode, int 
 	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
 bad_block:	ext2_error(inode->i_sb, "ext2_xattr_get",
-			"inode %ld: bad block %d", inode->i_ino,
+			"inode %ld: bad block %lu", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -275,7 +275,7 @@ ext2_xattr_list(struct inode *inode, cha
 	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
 bad_block:	ext2_error(inode->i_sb, "ext2_xattr_list",
-			"inode %ld: bad block %d", inode->i_ino,
+			"inode %ld: bad block %lu", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -411,7 +411,7 @@ ext2_xattr_set(struct inode *inode, int 
 		if (header->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 		    header->h_blocks != cpu_to_le32(1)) {
 bad_block:		ext2_error(sb, "ext2_xattr_set",
-				"inode %ld: bad block %d", inode->i_ino, 
+				"inode %ld: bad block %lu", inode->i_ino, 
 				   EXT2_I(inode)->i_file_acl);
 			error = -EIO;
 			goto cleanup;
@@ -664,11 +664,11 @@ ext2_xattr_set2(struct inode *inode, str
 			ext2_xattr_cache_insert(new_bh);
 		} else {
 			/* We need to allocate a new block */
-			int goal = le32_to_cpu(EXT2_SB(sb)->s_es->
+			ext2_fsblk_t goal = le32_to_cpu(EXT2_SB(sb)->s_es->
 						           s_first_data_block) +
 				   EXT2_I(inode)->i_block_group *
 				   EXT2_BLOCKS_PER_GROUP(sb);
-			int block = ext2_new_block(inode, goal,
+			ext2_fsblk_t block = ext2_new_block(inode, goal,
 						   NULL, NULL, &error);
 			if (error)
 				goto cleanup;
@@ -772,7 +772,7 @@ ext2_xattr_delete_inode(struct inode *in
 	bh = sb_bread(inode->i_sb, EXT2_I(inode)->i_file_acl);
 	if (!bh) {
 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
-			"inode %ld: block %d read error", inode->i_ino,
+			"inode %ld: block %lu read error", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		goto cleanup;
 	}
@@ -780,7 +780,7 @@ ext2_xattr_delete_inode(struct inode *in
 	if (HDR(bh)->h_magic != cpu_to_le32(EXT2_XATTR_MAGIC) ||
 	    HDR(bh)->h_blocks != cpu_to_le32(1)) {
 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
-			"inode %ld: bad block %d", inode->i_ino,
+			"inode %ld: bad block %lu", inode->i_ino,
 			EXT2_I(inode)->i_file_acl);
 		goto cleanup;
 	}
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/fs/ext2/xip.c linux-2.6.17.tmp/fs/ext2/xip.c
--- linux-2.6.17/fs/ext2/xip.c	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.tmp/fs/ext2/xip.c	2006-06-29 21:24:37.000000000 +0900
@@ -45,7 +45,7 @@ __ext2_get_sector(struct inode *inode, s
 }
 
 int
-ext2_clear_xip_target(struct inode *inode, int block)
+ext2_clear_xip_target(struct inode *inode, ext2_fsblk_t block)
 {
 	sector_t sector = block * (PAGE_SIZE/512);
 	unsigned long data;
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/fs/ext2/xip.h linux-2.6.17.tmp/fs/ext2/xip.h
--- linux-2.6.17/fs/ext2/xip.h	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.tmp/fs/ext2/xip.h	2006-06-29 21:24:37.000000000 +0900
@@ -7,7 +7,7 @@
 
 #ifdef CONFIG_EXT2_FS_XIP
 extern void ext2_xip_verify_sb (struct super_block *);
-extern int ext2_clear_xip_target (struct inode *, int);
+extern int ext2_clear_xip_target (struct inode *, ext2_fsblk_t);
 
 static inline int ext2_use_xip (struct super_block *sb)
 {
diff -upNr -X linux-2.6.17/Documentation/dontdiff linux-2.6.17/include/linux/ext2_fs_sb.h linux-2.6.17.tmp/include/linux/ext2_fs_sb.h
--- linux-2.6.17/include/linux/ext2_fs_sb.h	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.tmp/include/linux/ext2_fs_sb.h	2006-06-29 21:24:38.000000000 +0900
@@ -19,6 +19,8 @@
 #include <linux/blockgroup_lock.h>
 #include <linux/percpu_counter.h>
 
+typedef unsigned long ext2_fsblk_t;
+
 /*
  * second extended-fs super-block data in memory
  */

