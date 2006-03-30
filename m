Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbWC3BkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWC3BkB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 20:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWC3BkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 20:40:01 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:11401 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751426AbWC3Bj6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 20:39:58 -0500
Subject: [RFC][PATCH 2/2]Other ext3 in-kernel block number type fix to
	support 2**32 block numbers
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Sato <sho@tnes.nec.co.jp>,
       Laurent Vivier <Laurent.Vivier@bull.net>, linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1143623605.5046.11.camel@openx2.frec.bull.fr>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
Content-Type: text/plain
Organization: IBM LTC
Date: Wed, 29 Mar 2006 17:39:51 -0800
Message-Id: <1143682791.4045.149.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This trivial patch fixed other places in ext3 code(non block allocation
part) to replace "int" type filesystem block number with "unsigned
long".


Signed-Off-By: Mingming Cao <cmm@us.ibm.com>

---

 linux-2.6.16-ming/fs/ext3/balloc.c        |    4 ++--
 linux-2.6.16-ming/fs/ext3/ialloc.c        |    2 +-
 linux-2.6.16-ming/fs/ext3/inode.c         |    2 +-
 linux-2.6.16-ming/fs/ext3/resize.c        |    4 ++--
 linux-2.6.16-ming/fs/ext3/xattr.c         |   16 ++++++++--------
 linux-2.6.16-ming/include/linux/ext3_fs.h |    2 +-
 6 files changed, 15 insertions(+), 15 deletions(-)

diff -puN fs/ext3/balloc.c~ext3_32bit_kernel_fix fs/ext3/balloc.c
--- linux-2.6.16/fs/ext3/balloc.c~ext3_32bit_kernel_fix	2006-03-24 21:32:32.000000000 -0800
+++ linux-2.6.16-ming/fs/ext3/balloc.c	2006-03-27 15:47:17.344404203 -0800
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
diff -puN fs/ext3/ialloc.c~ext3_32bit_kernel_fix fs/ext3/ialloc.c
--- linux-2.6.16/fs/ext3/ialloc.c~ext3_32bit_kernel_fix	2006-03-24 21:32:32.000000000 -0800
+++ linux-2.6.16-ming/fs/ext3/ialloc.c	2006-03-24 21:32:32.000000000 -0800
@@ -262,7 +262,7 @@ static int find_group_orlov(struct super
 	int ngroups = sbi->s_groups_count;
 	int inodes_per_group = EXT3_INODES_PER_GROUP(sb);
 	int freei, avefreei;
-	int freeb, avefreeb;
+	unsigned long freeb, avefreeb;
 	int blocks_per_dir, ndirs;
 	int max_debt, max_dirs, min_blocks, min_inodes;
 	int group = -1, i;
diff -puN fs/ext3/inode.c~ext3_32bit_kernel_fix fs/ext3/inode.c
--- linux-2.6.16/fs/ext3/inode.c~ext3_32bit_kernel_fix	2006-03-24 21:32:32.000000000 -0800
+++ linux-2.6.16-ming/fs/ext3/inode.c	2006-03-24 21:32:32.000000000 -0800
@@ -62,7 +62,7 @@ static int ext3_inode_is_fast_symlink(st
  * still needs to be revoked.
  */
 int ext3_forget(handle_t *handle, int is_metadata, struct inode *inode,
-			struct buffer_head *bh, int blocknr)
+			struct buffer_head *bh, unsigned long blocknr)
 {
 	int err;
 
diff -puN include/linux/ext3_fs.h~ext3_32bit_kernel_fix include/linux/ext3_fs.h
--- linux-2.6.16/include/linux/ext3_fs.h~ext3_32bit_kernel_fix	2006-03-24 21:32:32.000000000 -0800
+++ linux-2.6.16-ming/include/linux/ext3_fs.h	2006-03-24 21:32:32.000000000 -0800
@@ -775,7 +775,7 @@ extern unsigned long ext3_count_free (st
 
 
 /* inode.c */
-int ext3_forget(handle_t *, int, struct inode *, struct buffer_head *, int);
+int ext3_forget(handle_t *, int, struct inode *, struct buffer_head *, unsigned long);
 struct buffer_head * ext3_getblk (handle_t *, struct inode *, long, int, int *);
 struct buffer_head * ext3_bread (handle_t *, struct inode *, int, int, int *);
 int ext3_get_blocks_handle(handle_t *handle, struct inode *inode,
diff -puN fs/ext3/resize.c~ext3_32bit_kernel_fix fs/ext3/resize.c
--- linux-2.6.16/fs/ext3/resize.c~ext3_32bit_kernel_fix	2006-03-24 21:32:32.000000000 -0800
+++ linux-2.6.16-ming/fs/ext3/resize.c	2006-03-24 21:32:32.000000000 -0800
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
diff -puN fs/ext3/xattr.c~ext3_32bit_kernel_fix fs/ext3/xattr.c
--- linux-2.6.16/fs/ext3/xattr.c~ext3_32bit_kernel_fix	2006-03-24 21:32:32.000000000 -0800
+++ linux-2.6.16-ming/fs/ext3/xattr.c	2006-03-24 21:32:32.000000000 -0800
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

_


