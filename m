Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030467AbWHXTnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030467AbWHXTnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 15:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWHXTnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 15:43:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24220 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030468AbWHXTnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 15:43:32 -0400
Message-ID: <44EE015E.8040904@redhat.com>
Date: Thu, 24 Aug 2006 14:43:26 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ext3 inode numbers are unsigned long
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is primarily format string fixes, with changes to ialloc.c where large
inode counts could overflow, and also pass around journal_inum as an unsigned
long, just to be pedantic about it....

Signed-off-by: Eric Sandeen <esandeen@redhat.com>

Index: linux-2.6.17/fs/ext3/ialloc.c
===================================================================
--- linux-2.6.17.orig/fs/ext3/ialloc.c
+++ linux-2.6.17/fs/ext3/ialloc.c
@@ -202,7 +202,7 @@ error_return:
 static int find_group_dir(struct super_block *sb, struct inode *parent)
 {
 	int ngroups = EXT3_SB(sb)->s_groups_count;
-	int freei, avefreei;
+	unsigned long freei, avefreei;
 	struct ext3_group_desc *desc, *best_desc = NULL;
 	struct buffer_head *bh;
 	int group, best_group = -1;
@@ -261,10 +261,10 @@ static int find_group_orlov(struct super
 	struct ext3_super_block *es = sbi->s_es;
 	int ngroups = sbi->s_groups_count;
 	int inodes_per_group = EXT3_INODES_PER_GROUP(sb);
-	int freei, avefreei;
+	unsigned long freei, avefreei;
 	ext3_fsblk_t freeb, avefreeb;
 	ext3_fsblk_t blocks_per_dir;
-	int ndirs;
+	unsigned long ndirs;
 	int max_debt, max_dirs, min_inodes;
 	ext3_grpblk_t min_blocks;
 	int group = -1, i;
Index: linux-2.6.17/fs/ext3/super.c
===================================================================
--- linux-2.6.17.orig/fs/ext3/super.c
+++ linux-2.6.17/fs/ext3/super.c
@@ -45,7 +45,7 @@
 static int ext3_load_journal(struct super_block *, struct ext3_super_block *,
 			     unsigned long journal_devnum);
 static int ext3_create_journal(struct super_block *, struct ext3_super_block *,
-			       int);
+			       unsigned long);
 static void ext3_commit_super (struct super_block * sb,
 			       struct ext3_super_block * es,
 			       int sync);
@@ -376,7 +376,7 @@ static void dump_orphan_list(struct supe
 	list_for_each(l, &sbi->s_orphan) {
 		struct inode *inode = orphan_list_entry(l);
 		printk(KERN_ERR "  "
-		       "inode %s:%ld at %p: mode %o, nlink %d, next %d\n",
+		       "inode %s:%lu at %p: mode %o, nlink %d, next %d\n",
 		       inode->i_sb->s_id, inode->i_ino, inode,
 		       inode->i_mode, inode->i_nlink, 
 		       NEXT_ORPHAN(inode));
@@ -1264,17 +1264,17 @@ static void ext3_orphan_cleanup (struct 
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
@@ -1802,7 +1802,8 @@ static void ext3_init_journal_params(str
 	spin_unlock(&journal->j_state_lock);
 }
 
-static journal_t *ext3_get_journal(struct super_block *sb, int journal_inum)
+static journal_t *ext3_get_journal(struct super_block *sb,
+				   unsigned long journal_inum)
 {
 	struct inode *journal_inode;
 	journal_t *journal;
@@ -1937,7 +1938,7 @@ static int ext3_load_journal(struct supe
 			     unsigned long journal_devnum)
 {
 	journal_t *journal;
-	int journal_inum = le32_to_cpu(es->s_journal_inum);
+	unsigned long journal_inum = le32_to_cpu(es->s_journal_inum);
 	dev_t journal_dev;
 	int err = 0;
 	int really_read_only;
@@ -2023,7 +2024,7 @@ static int ext3_load_journal(struct supe
 
 static int ext3_create_journal(struct super_block * sb,
 			       struct ext3_super_block * es,
-			       int journal_inum)
+			       unsigned long journal_inum)
 {
 	journal_t *journal;
 
@@ -2036,7 +2037,7 @@ static int ext3_create_journal(struct su
 	if (!(journal = ext3_get_journal(sb, journal_inum)))
 		return -EINVAL;
 
-	printk(KERN_INFO "EXT3-fs: creating new journal on inode %d\n",
+	printk(KERN_INFO "EXT3-fs: creating new journal on inode %lu\n",
 	       journal_inum);
 
 	if (journal_create(journal)) {
Index: linux-2.6.17/fs/ext3/inode.c
===================================================================
--- linux-2.6.17.orig/fs/ext3/inode.c
+++ linux-2.6.17/fs/ext3/inode.c
@@ -2112,7 +2112,7 @@ static void ext3_free_branches(handle_t 
 			 */
 			if (!bh) {
 				ext3_error(inode->i_sb, "ext3_free_branches",
-					   "Read failure, inode=%ld, block="E3FSBLK,
+					   "Read failure, inode=%lu, block="E3FSBLK,
 					   inode->i_ino, nr);
 				continue;
 			}
Index: linux-2.6.17/fs/ext3/namei.c
===================================================================
--- linux-2.6.17.orig/fs/ext3/namei.c
+++ linux-2.6.17/fs/ext3/namei.c
@@ -1919,8 +1919,8 @@ int ext3_orphan_add(handle_t *handle, st
 	if (!err)
 		list_add(&EXT3_I(inode)->i_orphan, &EXT3_SB(sb)->s_orphan);
 
-	jbd_debug(4, "superblock will point to %ld\n", inode->i_ino);
-	jbd_debug(4, "orphan inode %ld will point to %d\n",
+	jbd_debug(4, "superblock will point to %lu\n", inode->i_ino);
+	jbd_debug(4, "orphan inode %lu will point to %d\n",
 			inode->i_ino, NEXT_ORPHAN(inode));
 out_unlock:
 	unlock_super(sb);
Index: linux-2.6.17/fs/ext3/xattr.c
===================================================================
--- linux-2.6.17.orig/fs/ext3/xattr.c
+++ linux-2.6.17/fs/ext3/xattr.c
@@ -75,7 +75,7 @@
 
 #ifdef EXT3_XATTR_DEBUG
 # define ea_idebug(inode, f...) do { \
-		printk(KERN_DEBUG "inode %s:%ld: ", \
+		printk(KERN_DEBUG "inode %s:%lu: ", \
 			inode->i_sb->s_id, inode->i_ino); \
 		printk(f); \
 		printk("\n"); \
@@ -233,7 +233,7 @@ ext3_xattr_block_get(struct inode *inode
 		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
 	if (ext3_xattr_check_block(bh)) {
 bad_block:	ext3_error(inode->i_sb, __FUNCTION__,
-			   "inode %ld: bad block "E3FSBLK, inode->i_ino,
+			   "inode %lu: bad block "E3FSBLK, inode->i_ino,
 			   EXT3_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -375,7 +375,7 @@ ext3_xattr_block_list(struct inode *inod
 		atomic_read(&(bh->b_count)), le32_to_cpu(BHDR(bh)->h_refcount));
 	if (ext3_xattr_check_block(bh)) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			   "inode %ld: bad block "E3FSBLK, inode->i_ino,
+			   "inode %lu: bad block "E3FSBLK, inode->i_ino,
 			   EXT3_I(inode)->i_file_acl);
 		error = -EIO;
 		goto cleanup;
@@ -647,7 +647,7 @@ ext3_xattr_block_find(struct inode *inod
 			le32_to_cpu(BHDR(bs->bh)->h_refcount));
 		if (ext3_xattr_check_block(bs->bh)) {
 			ext3_error(sb, __FUNCTION__,
-				"inode %ld: bad block "E3FSBLK, inode->i_ino,
+				"inode %lu: bad block "E3FSBLK, inode->i_ino,
 				EXT3_I(inode)->i_file_acl);
 			error = -EIO;
 			goto cleanup;
@@ -848,7 +848,7 @@ cleanup_dquot:
 
 bad_block:
 	ext3_error(inode->i_sb, __FUNCTION__,
-		   "inode %ld: bad block "E3FSBLK, inode->i_ino,
+		   "inode %lu: bad block "E3FSBLK, inode->i_ino,
 		   EXT3_I(inode)->i_file_acl);
 	goto cleanup;
 
@@ -1077,14 +1077,14 @@ ext3_xattr_delete_inode(handle_t *handle
 	bh = sb_bread(inode->i_sb, EXT3_I(inode)->i_file_acl);
 	if (!bh) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			"inode %ld: block "E3FSBLK" read error", inode->i_ino,
+			"inode %lu: block "E3FSBLK" read error", inode->i_ino,
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
 	if (BHDR(bh)->h_magic != cpu_to_le32(EXT3_XATTR_MAGIC) ||
 	    BHDR(bh)->h_blocks != cpu_to_le32(1)) {
 		ext3_error(inode->i_sb, __FUNCTION__,
-			"inode %ld: bad block "E3FSBLK, inode->i_ino,
+			"inode %lu: bad block "E3FSBLK, inode->i_ino,
 			EXT3_I(inode)->i_file_acl);
 		goto cleanup;
 	}
@@ -1211,7 +1211,7 @@ again:
 		bh = sb_bread(inode->i_sb, ce->e_block);
 		if (!bh) {
 			ext3_error(inode->i_sb, __FUNCTION__,
-				"inode %ld: block %lu read error",
+				"inode %lu: block %lu read error",
 				inode->i_ino, (unsigned long) ce->e_block);
 		} else if (le32_to_cpu(BHDR(bh)->h_refcount) >=
 				EXT3_XATTR_REFCOUNT_MAX) {


