Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265466AbSJSBxB>; Fri, 18 Oct 2002 21:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265468AbSJSBxB>; Fri, 18 Oct 2002 21:53:01 -0400
Received: from thunk.org ([140.239.227.29]:5846 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S265466AbSJSBwz>;
	Fri, 18 Oct 2002 21:52:55 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Ext2/3 forward compatibility: inode size
From: tytso@mit.edu
Phone: (781) 391-3464
Message-Id: <E182itF-00017x-00@think.thunk.org>
Date: Fri, 18 Oct 2002 21:58:57 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch allows filesystems with expanded inodes to be mounted.
(compatibility feature flags will be used to control whether or not the
filesystem should be mounted in case the new inode fields will result in
compatibility issues).  This allows for future compatibility with newer
versions of ext2fs.  

Hopefully this and the dynamic resize forward compatibility patch can
get included for the 2.6 release.

						- Ted

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.818   -> 1.819  
#	     fs/ext2/inode.c	1.49    -> 1.50   
#	    fs/ext2/ialloc.c	1.23    -> 1.24   
#	     fs/ext2/super.c	1.35    -> 1.36   
#	     fs/ext3/inode.c	1.44    -> 1.45   
#	     fs/ext3/super.c	1.37    -> 1.38   
#	      fs/ext2/ext2.h	1.12    -> 1.13   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/18	tytso@snap.thunk.org	1.819
# Ext2/3 forward compatibility: inode size
# 
# This patch allows filesystems with expanded inodes to be mounted.
# (compatibility feature flags will be used to control whether or 
# not the filesystem should be mounted in case the new inode fields
# will result in compatibility issues).
# --------------------------------------------
#
diff -Nru a/fs/ext2/ext2.h b/fs/ext2/ext2.h
--- a/fs/ext2/ext2.h	Fri Oct 18 20:52:23 2002
+++ b/fs/ext2/ext2.h	Fri Oct 18 20:52:23 2002
@@ -10,6 +10,7 @@
 	__u32	i_faddr;
 	__u8	i_frag_no;
 	__u8	i_frag_size;
+	__u16	i_state;
 	__u32	i_file_acl;
 	__u32	i_dir_acl;
 	__u32	i_dtime;
@@ -26,6 +27,12 @@
 	rwlock_t i_meta_lock;
 	struct inode	vfs_inode;
 };
+
+/*
+ * Inode dynamic state flags
+ */
+#define EXT2_STATE_NEW			0x00000001 /* inode is newly created */
+
 
 /*
  * Function prototypes
diff -Nru a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
--- a/fs/ext2/ialloc.c	Fri Oct 18 20:52:22 2002
+++ b/fs/ext2/ialloc.c	Fri Oct 18 20:52:22 2002
@@ -394,6 +394,7 @@
 		inode->i_flags |= S_DIRSYNC;
 	inode->i_generation = EXT2_SB(sb)->s_next_generation++;
 	insert_inode_hash(inode);
+	ei->i_state = EXT2_STATE_NEW;
 
 	unlock_super(sb);
 	if(DQUOT_ALLOC_INODE(inode)) {
diff -Nru a/fs/ext2/inode.c b/fs/ext2/inode.c
--- a/fs/ext2/inode.c	Fri Oct 18 20:52:22 2002
+++ b/fs/ext2/inode.c	Fri Oct 18 20:52:22 2002
@@ -1028,6 +1028,7 @@
 		ei->i_dir_acl = le32_to_cpu(raw_inode->i_dir_acl);
 	ei->i_dtime = 0;
 	inode->i_generation = le32_to_cpu(raw_inode->i_generation);
+	ei->i_state = 0;
 	ei->i_next_alloc_block = 0;
 	ei->i_next_alloc_goal = 0;
 	ei->i_prealloc_count = 0;
@@ -1092,6 +1093,11 @@
 	if (IS_ERR(raw_inode))
  		return -EIO;
 
+	/* For fields not not tracking in the in-memory inode,
+	 * initialise them to zero for new inodes. */
+	if (ei->i_state & EXT2_STATE_NEW)
+		memset(raw_inode, 0, EXT2_SB(sb)->s_inode_size);
+
 	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
 	if (!(test_opt(sb, NO_UID32))) {
 		raw_inode->i_uid_low = cpu_to_le16(low_16_bits(uid));
@@ -1162,6 +1168,7 @@
 			err = -EIO;
 		}
 	}
+	ei->i_state &= ~EXT2_STATE_NEW;
 	brelse (bh);
 	return err;
 }
diff -Nru a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Fri Oct 18 20:52:22 2002
+++ b/fs/ext2/super.c	Fri Oct 18 20:52:22 2002
@@ -676,7 +676,9 @@
 	} else {
 		sbi->s_inode_size = le16_to_cpu(es->s_inode_size);
 		sbi->s_first_ino = le32_to_cpu(es->s_first_ino);
-		if (sbi->s_inode_size != EXT2_GOOD_OLD_INODE_SIZE) {
+		if ((sbi->s_inode_size < EXT2_GOOD_OLD_INODE_SIZE) ||
+		    (sbi->s_inode_size & (sbi->s_inode_size - 1)) ||
+		    (sbi->s_inode_size > blocksize)) {
 			printk ("EXT2-fs: unsupported inode size: %d\n",
 				sbi->s_inode_size);
 			goto failed_mount;
diff -Nru a/fs/ext3/inode.c b/fs/ext3/inode.c
--- a/fs/ext3/inode.c	Fri Oct 18 20:52:22 2002
+++ b/fs/ext3/inode.c	Fri Oct 18 20:52:23 2002
@@ -2340,6 +2340,11 @@
 		if (err)
 			goto out_brelse;
 	}
+	/* For fields not not tracking in the in-memory inode,
+	 * initialise them to zero for new inodes. */
+	if (ei->i_state & EXT3_STATE_NEW)
+		memset(raw_inode, 0, EXT3_SB(inode->i_sb)->s_inode_size);
+
 	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
 	if(!(test_opt(inode->i_sb, NO_UID32))) {
 		raw_inode->i_uid_low = cpu_to_le16(low_16_bits(inode->i_uid));
@@ -2377,15 +2382,6 @@
 	raw_inode->i_faddr = cpu_to_le32(ei->i_faddr);
 	raw_inode->i_frag = ei->i_frag_no;
 	raw_inode->i_fsize = ei->i_frag_size;
-#else
-	/* If we are not tracking these fields in the in-memory inode,
-	 * then preserve them on disk, but still initialise them to zero
-	 * for new inodes. */
-	if (ei->i_state & EXT3_STATE_NEW) {
-		raw_inode->i_faddr = 0;
-		raw_inode->i_frag = 0;
-		raw_inode->i_fsize = 0;
-	}
 #endif
 	raw_inode->i_file_acl = cpu_to_le32(ei->i_file_acl);
 	if (!S_ISREG(inode->i_mode)) {
diff -Nru a/fs/ext3/super.c b/fs/ext3/super.c
--- a/fs/ext3/super.c	Fri Oct 18 20:52:23 2002
+++ b/fs/ext3/super.c	Fri Oct 18 20:52:23 2002
@@ -1159,7 +1159,9 @@
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

