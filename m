Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264775AbSJaIXt>; Thu, 31 Oct 2002 03:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264784AbSJaIXB>; Thu, 31 Oct 2002 03:23:01 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:55267 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S264789AbSJaIWQ>;
	Thu, 31 Oct 2002 03:22:16 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [PATCH] 3/11  Ext2/3 Updates: Extended attributes, ACL, etc.
From: tytso@mit.edu
Message-Id: <E187Agz-0003bF-00@snap.thunk.org>
Date: Thu, 31 Oct 2002 03:28:41 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ext2/3 forward compatibility: inode size

This patch allows filesystems with expanded inodes to be mounted.
(compatibility feature flags will be used to control whether or not the
filesystem should be mounted in case the new inode fields will result in
compatibility issues).  This allows for future compatibility with newer
versions of ext2fs.

 ext2/ext2.h   |    7 +++++++
 ext2/ialloc.c |    1 +
 ext2/inode.c  |    7 +++++++
 ext2/super.c  |    4 +++-
 ext3/inode.c  |   14 +++++---------
 ext3/super.c  |    4 +++-
 6 files changed, 26 insertions(+), 11 deletions(-)

diff -Nru a/fs/ext2/ext2.h b/fs/ext2/ext2.h
--- a/fs/ext2/ext2.h	Thu Oct 31 02:39:05 2002
+++ b/fs/ext2/ext2.h	Thu Oct 31 02:39:05 2002
@@ -10,6 +10,7 @@
 	__u32	i_faddr;
 	__u8	i_frag_no;
 	__u8	i_frag_size;
+	__u16	i_state;
 	__u32	i_file_acl;
 	__u32	i_dir_acl;
 	__u32	i_dtime;
@@ -22,6 +23,12 @@
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
--- a/fs/ext2/ialloc.c	Thu Oct 31 02:39:05 2002
+++ b/fs/ext2/ialloc.c	Thu Oct 31 02:39:05 2002
@@ -386,6 +386,7 @@
 	ei->i_prealloc_block = 0;
 	ei->i_prealloc_count = 0;
 	ei->i_dir_start_lookup = 0;
+	ei->i_state = EXT2_STATE_NEW;
 	if (ei->i_flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
 	if (ei->i_flags & EXT2_DIRSYNC_FL)
diff -Nru a/fs/ext2/inode.c b/fs/ext2/inode.c
--- a/fs/ext2/inode.c	Thu Oct 31 02:39:05 2002
+++ b/fs/ext2/inode.c	Thu Oct 31 02:39:05 2002
@@ -1012,6 +1012,7 @@
 		ei->i_dir_acl = le32_to_cpu(raw_inode->i_dir_acl);
 	ei->i_dtime = 0;
 	inode->i_generation = le32_to_cpu(raw_inode->i_generation);
+	ei->i_state = 0;
 	ei->i_next_alloc_block = 0;
 	ei->i_next_alloc_goal = 0;
 	ei->i_prealloc_count = 0;
@@ -1076,6 +1077,11 @@
 	if (IS_ERR(raw_inode))
  		return -EIO;
 
+	/* For fields not not tracking in the in-memory inode,
+	 * initialise them to zero for new inodes. */
+	if (ei->i_state & EXT2_STATE_NEW)
+		memset(raw_inode, 0, EXT2_SB(sb)->s_inode_size);
+
 	if (ino == EXT2_ACL_IDX_INO || ino == EXT2_ACL_DATA_INO) {
 		ext2_error (sb, "ext2_write_inode", "bad inode number: %lu",
 			    (unsigned long) ino);
@@ -1152,6 +1158,7 @@
 			err = -EIO;
 		}
 	}
+	ei->i_state &= ~EXT2_STATE_NEW;
 	brelse (bh);
 	return err;
 }
diff -Nru a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	Thu Oct 31 02:39:05 2002
+++ b/fs/ext2/super.c	Thu Oct 31 02:39:05 2002
@@ -630,7 +630,9 @@
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
--- a/fs/ext3/inode.c	Thu Oct 31 02:39:05 2002
+++ b/fs/ext3/inode.c	Thu Oct 31 02:39:05 2002
@@ -2325,6 +2325,11 @@
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
@@ -2362,15 +2367,6 @@
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
--- a/fs/ext3/super.c	Thu Oct 31 02:39:05 2002
+++ b/fs/ext3/super.c	Thu Oct 31 02:39:05 2002
@@ -1109,7 +1109,9 @@
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
