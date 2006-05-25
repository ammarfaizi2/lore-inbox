Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965139AbWEYMmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965139AbWEYMmr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbWEYMmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:42:47 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:42696 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965139AbWEYMmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:42:46 -0400
To: adilger@clusterfs.com, cmm@us.ibm.com, jitendra@linsyssoft.com
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][2/24]Other ext3 in-kernel block number type fix to support 2^32 blocks
Message-Id: <20060525214238sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Thu, 25 May 2006 21:42:38 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [2/24]  modify non block allocation code(ext3)
          - Modify non block allocation code to replace "int" type
            filesystem block number with "unsigned long".

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/balloc.c linux-2.6.17-rc4.tmp/fs/ext3/balloc.c
--- linux-2.6.17-rc4/fs/ext3/balloc.c	2006-05-25 16:29:51.583732194 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/balloc.c	2006-05-25 16:29:59.666739907 +0900
@@ -496,7 +496,7 @@ void ext3_free_blocks(handle_t *handle, 
 			unsigned long block, unsigned long count)
 {
 	struct super_block * sb;
-	int dquot_freed_blocks;
+	unsigned long dquot_freed_blocks;
 
 	sb = inode->i_sb;
 	if (!sb) {
@@ -1166,7 +1166,7 @@ out:
 
 static int ext3_has_free_blocks(struct ext3_sb_info *sbi)
 {
-	int free_blocks, root_blocks;
+	unsigned long free_blocks, root_blocks;
 
 	free_blocks = percpu_counter_read_positive(&sbi->s_freeblocks_counter);
 	root_blocks = le32_to_cpu(sbi->s_es->s_r_blocks_count);
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/ialloc.c linux-2.6.17-rc4.tmp/fs/ext3/ialloc.c
--- linux-2.6.17-rc4/fs/ext3/ialloc.c	2006-03-20 14:53:29.000000000 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/ialloc.c	2006-05-25 16:29:59.667716470 +0900
@@ -262,7 +262,7 @@ static int find_group_orlov(struct super
 	int ngroups = sbi->s_groups_count;
 	int inodes_per_group = EXT3_INODES_PER_GROUP(sb);
 	int freei, avefreei;
-	int freeb, avefreeb;
+	unsigned long freeb, avefreeb;
 	int blocks_per_dir, ndirs;
 	int max_debt, max_dirs, min_blocks, min_inodes;
 	int group = -1, i;
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/inode.c linux-2.6.17-rc4.tmp/fs/ext3/inode.c
--- linux-2.6.17-rc4/fs/ext3/inode.c	2006-05-25 16:18:35.855224846 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/inode.c	2006-05-25 16:29:59.669669595 +0900
@@ -62,7 +62,7 @@ static int ext3_inode_is_fast_symlink(st
  * still needs to be revoked.
  */
 int ext3_forget(handle_t *handle, int is_metadata, struct inode *inode,
-			struct buffer_head *bh, int blocknr)
+			struct buffer_head *bh, unsigned long blocknr)
 {
 	int err;
 
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/resize.c linux-2.6.17-rc4.tmp/fs/ext3/resize.c
--- linux-2.6.17-rc4/fs/ext3/resize.c	2006-05-25 16:18:35.857177971 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/resize.c	2006-05-25 16:29:59.670646157 +0900
@@ -992,10 +992,10 @@ int ext3_group_extend(struct super_block
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
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/fs/ext3/xattr.c linux-2.6.17-rc4.tmp/fs/ext3/xattr.c
--- linux-2.6.17-rc4/fs/ext3/xattr.c	2006-05-25 16:29:51.584708756 +0900
+++ linux-2.6.17-rc4.tmp/fs/ext3/xattr.c	2006-05-25 16:29:59.671622720 +0900
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
+			   "inode %ld: bad block %u", inode->i_ino,
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
+			   "inode %ld: bad block %u", inode->i_ino,
 			   EXT3_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -647,7 +647,7 @@ ext3_xattr_block_find(struct inode *inod
 			le32_to_cpu(BHDR(bs->bh)->h_refcount));
 		if (ext3_xattr_check_block(bs->bh)) {
 			ext3_error(sb, __FUNCTION__,
-				"inode %ld: bad block %d", inode->i_ino,
+				"inode %ld: bad block %u", inode->i_ino,
 				EXT3_I(inode)->i_file_acl);
 			error = -EIO;
 			goto cleanup;
@@ -847,7 +847,7 @@ cleanup_dquot:
 
 bad_block:
 	ext3_error(inode->i_sb, __FUNCTION__,
-		   "inode %ld: bad block %d", inode->i_ino,
+		   "inode %ld: bad block %u", inode->i_ino,
 		   EXT3_I(inode)->i_file_acl);
 	goto cleanup;
 
@@ -1076,14 +1076,14 @@ ext3_xattr_delete_inode(handle_t *handle
 	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
 	if (!bh) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			"inode %ld: block %d read error", inode->i_ino,
+			"inode %ld: block %u read error", inode->i_ino,
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
 	if (BHDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
 	    BHDR(bh)->h_blocks != cpu_to_le32(1)) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			"inode %ld: bad block %d", inode->i_ino,
+			"inode %ld: bad block %u", inode->i_ino,
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
diff -upNr -X linux-2.6.17-rc4/Documentation/dontdiff linux-2.6.17-rc4/include/linux/ext3_fs.h linux-2.6.17-rc4.tmp/include/linux/ext3_fs.h
--- linux-2.6.17-rc4/include/linux/ext3_fs.h	2006-05-25 16:29:51.585685319 +0900
+++ linux-2.6.17-rc4.tmp/include/linux/ext3_fs.h	2006-05-25 16:29:59.672599282 +0900
@@ -775,7 +775,7 @@ extern unsigned long ext3_count_free (st
 
 
 /* inode.c */
-int ext3_forget(handle_t *, int, struct inode *, struct buffer_head *, int);
+int ext3_forget(handle_t *, int, struct inode *, struct buffer_head *, unsigned long);
 struct buffer_head * ext3_getblk (handle_t *, struct inode *, long, int, int *);
 struct buffer_head * ext3_bread (handle_t *, struct inode *, int, int, int *);
 int ext3_get_blocks_handle(handle_t *handle, struct inode *inode,



