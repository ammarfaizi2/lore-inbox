Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265427AbUAAV67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 16:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265453AbUAAV66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 16:58:58 -0500
Received: from thunk.org ([140.239.227.29]:65442 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S265427AbUAAVvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 16:51:50 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [PATCH] [2.4.24-pre3] 4/5  EXT2/3 Updates
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1AcAiu-0000Lc-BL@thunk.org>
Date: Thu, 01 Jan 2004 16:51:20 -0500
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1359  -> 1.1360 
#	     fs/ext2/inode.c	1.20    -> 1.21   
#	include/linux/ext2_fs_i.h	1.4     -> 1.5    
#	    fs/ext2/ialloc.c	1.10    -> 1.11   
#	     fs/ext2/super.c	1.10    -> 1.11   
#	     fs/ext3/inode.c	1.17    -> 1.18   
#	     fs/ext3/super.c	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/01	tytso@think.thunk.org	1.1360
# Apply 4106-tytso-inode-expand-7.patch
# 
# This patch allows filesystems with expanded inodes to be mounted.
# (compatibility feature flags will be used to control whether or not the
# filesystem should be mounted in case the new inode fields will result in
# compatibility issues).  This allows for future compatibility with newer
# versions of ext2fs.
# --------------------------------------------
#
diff -Nru a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
--- a/fs/ext2/ialloc.c	Thu Jan  1 16:29:21 2004
+++ b/fs/ext2/ialloc.c	Thu Jan  1 16:29:21 2004
@@ -385,7 +385,7 @@
 	inode->i_blksize = PAGE_SIZE;	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
-	inode->u.ext2_i.i_new_inode = 1;
+	inode->u.ext2_i.i_state = EXT2_STATE_NEW;
 	inode->u.ext2_i.i_flags = dir->u.ext2_i.i_flags & ~EXT2_BTREE_FL;
 	if (S_ISLNK(mode))
 		inode->u.ext2_i.i_flags &= ~(EXT2_IMMUTABLE_FL|EXT2_APPEND_FL);
diff -Nru a/fs/ext2/inode.c b/fs/ext2/inode.c
--- a/fs/ext2/inode.c	Thu Jan  1 16:29:21 2004
+++ b/fs/ext2/inode.c	Thu Jan  1 16:29:21 2004
@@ -992,6 +992,7 @@
 	else
 		inode->u.ext2_i.i_dir_acl = le32_to_cpu(raw_inode->i_dir_acl);
 	inode->i_generation = le32_to_cpu(raw_inode->i_generation);
+ 	inode->u.ext2_i.i_state = 0;
 	inode->u.ext2_i.i_prealloc_count = 0;
 	inode->u.ext2_i.i_block_group = block_group;
 
@@ -1083,6 +1084,11 @@
 	offset &= EXT2_BLOCK_SIZE(inode->i_sb) - 1;
 	raw_inode = (struct ext2_inode *) (bh->b_data + offset);
 
+	/* For fields not tracked in the in-memory inode,
+	 * initialise them to zero for new inodes. */
+	if (inode->u.ext2_i.i_state & EXT2_STATE_NEW)
+		memset(raw_inode, 0, EXT2_SB(inode->i_sb)->s_inode_size);
+
 	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
 	if(!(test_opt(inode->i_sb, NO_UID32))) {
 		raw_inode->i_uid_low = cpu_to_le16(low_16_bits(inode->i_uid));
@@ -1155,6 +1161,7 @@
 			err = -EIO;
 		}
 	}
+	inode->u.ext2_i.i_state &= ~EXT2_STATE_NEW;
 	brelse (bh);
 	return err;
 }
diff -Nru a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Thu Jan  1 16:29:21 2004
+++ b/fs/ext2/super.c	Thu Jan  1 16:29:21 2004
@@ -544,14 +544,16 @@
 	}
 
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV) {
-		sb->u.ext2_sb.s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
-		sb->u.ext2_sb.s_first_ino = EXT2_GOOD_OLD_FIRST_INO;
+		sbi->s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
+		sbi->s_first_ino = EXT2_GOOD_OLD_FIRST_INO;
 	} else {
-		sb->u.ext2_sb.s_inode_size = le16_to_cpu(es->s_inode_size);
-		sb->u.ext2_sb.s_first_ino = le32_to_cpu(es->s_first_ino);
-		if (sb->u.ext2_sb.s_inode_size != EXT2_GOOD_OLD_INODE_SIZE) {
+		sbi->s_inode_size = le16_to_cpu(es->s_inode_size);
+		sbi->s_first_ino = le32_to_cpu(es->s_first_ino);
+		if ((sbi->s_inode_size < EXT2_GOOD_OLD_INODE_SIZE) ||
+		    (sbi->s_inode_size & (sbi->s_inode_size - 1)) ||
+		    (sbi->s_inode_size > blocksize)) {
 			printk ("EXT2-fs: unsupported inode size: %d\n",
-				sb->u.ext2_sb.s_inode_size);
+				sbi->s_inode_size);
 			goto failed_mount;
 		}
 	}
diff -Nru a/fs/ext3/inode.c b/fs/ext3/inode.c
--- a/fs/ext3/inode.c	Thu Jan  1 16:29:21 2004
+++ b/fs/ext3/inode.c	Thu Jan  1 16:29:21 2004
@@ -2222,6 +2222,11 @@
 		if (err)
 			goto out_brelse;
 	}
+	/* For fields not not tracking in the in-memory inode,
+	 * initialise them to zero for new inodes. */
+	if (EXT3_I(inode)->i_state & EXT3_STATE_NEW)
+		memset(raw_inode, 0, EXT3_SB(inode->i_sb)->s_inode_size);
+
 	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
 	if(!(test_opt(inode->i_sb, NO_UID32))) {
 		raw_inode->i_uid_low = cpu_to_le16(low_16_bits(inode->i_uid));
@@ -2259,15 +2264,6 @@
 	raw_inode->i_faddr = cpu_to_le32(inode->u.ext3_i.i_faddr);
 	raw_inode->i_frag = inode->u.ext3_i.i_frag_no;
 	raw_inode->i_fsize = inode->u.ext3_i.i_frag_size;
-#else
-	/* If we are not tracking these fields in the in-memory inode,
-	 * then preserve them on disk, but still initialise them to zero
-	 * for new inodes. */
-	if (EXT3_I(inode)->i_state & EXT3_STATE_NEW) {
-		raw_inode->i_faddr = 0;
-		raw_inode->i_frag = 0;
-		raw_inode->i_fsize = 0;
-	}
 #endif
 	raw_inode->i_file_acl = cpu_to_le32(inode->u.ext3_i.i_file_acl);
 	if (!S_ISREG(inode->i_mode)) {
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Thu Jan  1 16:29:21 2004
+++ b/fs/ext3/super.c	Thu Jan  1 16:29:21 2004
@@ -1062,7 +1062,9 @@
 	} else {
 		sbi->s_inode_size = le16_to_cpu(es->s_inode_size);
 		sbi->s_first_ino = le32_to_cpu(es->s_first_ino);
-		if (sbi->s_inode_size != EXT3_GOOD_OLD_INODE_SIZE) {
+		if ((sbi->s_inode_size < EXT3_GOOD_OLD_INODE_SIZE) ||
+		    (sbi->s_inode_size & (sbi->s_inode_size - 1)) ||
+		    (sbi->s_inode_size > blocksize)) {
 			printk (KERN_ERR
 				"EXT3-fs: unsupported inode size: %d\n",
 				sbi->s_inode_size);
diff -Nru a/include/linux/ext2_fs_i.h b/include/linux/ext2_fs_i.h
--- a/include/linux/ext2_fs_i.h	Thu Jan  1 16:29:21 2004
+++ b/include/linux/ext2_fs_i.h	Thu Jan  1 16:29:21 2004
@@ -25,6 +25,7 @@
 	__u32	i_faddr;
 	__u8	i_frag_no;
 	__u8	i_frag_size;
+	__u16	i_state;
 	__u32	i_file_acl;
 	__u32	i_dir_acl;
 	__u32	i_dtime;
@@ -34,7 +35,11 @@
 	__u32	i_prealloc_block;
 	__u32	i_prealloc_count;
 	__u32	i_dir_start_lookup;
-	int	i_new_inode:1;	/* Is a freshly allocated inode */
 };
+
+/*
+ * Inode dynamic state flags
+ */
+#define EXT2_STATE_NEW			0x00000001 /* inode is newly created */
 
 #endif	/* _LINUX_EXT2_FS_I */
