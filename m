Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262181AbTCMGvx>; Thu, 13 Mar 2003 01:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262184AbTCMGvx>; Thu, 13 Mar 2003 01:51:53 -0500
Received: from thunk.org ([140.239.227.29]:5818 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262181AbTCMGvt>;
	Thu, 13 Mar 2003 01:51:49 -0500
To: marcelo@conectiva.com.br
cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [PATCH 2.4.21pre5] Ext2/3: noatime ignored for newly created inodes
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E18tMjC-0000Tk-00@think.thunk.org>
Date: Thu, 13 Mar 2003 02:02:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I recently noticed a bug in ext2/3; newly created inodes which inherit
the noatime flag from their containing directory do not respect noatime
until the inode is flushed from the inode cache and then re-read later.
This is because the code which checks the ext2 no-atime attribute and
then sets the S_NOATIME in inode->i_flags is present in
ext2_read_inode(), but not in ext2_new_inode().  

This patch centralizes the code which translates the ext2 flags in the
raw ext2 inode to the appropriate flag values in inode->i_flags in a
single location.  This fixes the bug, and also removes 30 lines of code
and 128 bytes of compiled x86 text in the bargain.

						- Ted

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
#
# fs/ext2/ialloc.c        |    3 +--
# fs/ext2/inode.c         |   32 ++++++++++++++++---------------
# fs/ext2/ioctl.c         |   17 +----------------
# fs/ext3/ialloc.c        |    3 +--
# fs/ext3/inode.c         |   34 +++++++++++++++++--------------
# fs/ext3/ioctl.c         |   17 +----------------
# include/linux/ext2_fs.h |    1 +
# include/linux/ext3_fs.h |    1 +
# 8 files changed, 39 insertions(+), 69 deletions(-)
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/12	tytso@think.thunk.org	1.1016
# Centralize ext23->inode flags setting.
# 
# This fixes a bug where the noatime flag not being honored in inodes
# which inherited noatime from their directory flag (at least not until
# inode was flushed out of the inode cache and then re-read into the inode
# cache later on), and also saves code because the common code has all been 
# factored out.
# --------------------------------------------
#
diff -Nru a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
--- a/fs/ext2/ialloc.c	Thu Mar 13 00:37:19 2003
+++ b/fs/ext2/ialloc.c	Thu Mar 13 00:37:19 2003
@@ -548,8 +548,7 @@
 	if (S_ISLNK(mode))
 		inode->u.ext2_i.i_flags &= ~(EXT2_IMMUTABLE_FL|EXT2_APPEND_FL);
 	inode->u.ext2_i.i_block_group = group;
-	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL)
-		inode->i_flags |= S_SYNC;
+	ext2_set_inode_flags(inode);
 	insert_inode_hash(inode);
 	inode->i_generation = event++;
 	mark_inode_dirty(inode);
diff -Nru a/fs/ext2/inode.c b/fs/ext2/inode.c
--- a/fs/ext2/inode.c	Thu Mar 13 00:37:19 2003
+++ b/fs/ext2/inode.c	Thu Mar 13 00:37:19 2003
@@ -888,6 +888,21 @@
 	}
 }
 
+void ext2_set_inode_flags(struct inode *inode)
+{
+	unsigned int flags = inode->u.ext2_i.i_flags;
+
+	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME);
+	if (flags & EXT2_SYNC_FL)
+		inode->i_flags |= S_SYNC;
+	if (flags & EXT2_APPEND_FL)
+		inode->i_flags |= S_APPEND;
+	if (flags & EXT2_IMMUTABLE_FL)
+		inode->i_flags |= S_IMMUTABLE;
+	if (flags & EXT2_NOATIME_FL)
+		inode->i_flags |= S_NOATIME;
+}
+
 void ext2_read_inode (struct inode * inode)
 {
 	struct buffer_head * bh;
@@ -1009,22 +1024,7 @@
 				   le32_to_cpu(raw_inode->i_block[0]));
 	brelse (bh);
 	inode->i_attr_flags = 0;
-	if (inode->u.ext2_i.i_flags & EXT2_SYNC_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_SYNCRONOUS;
-		inode->i_flags |= S_SYNC;
-	}
-	if (inode->u.ext2_i.i_flags & EXT2_APPEND_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_APPEND;
-		inode->i_flags |= S_APPEND;
-	}
-	if (inode->u.ext2_i.i_flags & EXT2_IMMUTABLE_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_IMMUTABLE;
-		inode->i_flags |= S_IMMUTABLE;
-	}
-	if (inode->u.ext2_i.i_flags & EXT2_NOATIME_FL) {
-		inode->i_attr_flags |= ATTR_FLAG_NOATIME;
-		inode->i_flags |= S_NOATIME;
-	}
+	ext2_set_inode_flags(inode);
 	return;
 	
 bad_inode:
diff -Nru a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
--- a/fs/ext2/ioctl.c	Thu Mar 13 00:37:19 2003
+++ b/fs/ext2/ioctl.c	Thu Mar 13 00:37:19 2003
@@ -53,22 +53,7 @@
 		flags |= oldflags & ~EXT2_FL_USER_MODIFIABLE;
 		inode->u.ext2_i.i_flags = flags;
 
-		if (flags & EXT2_SYNC_FL)
-			inode->i_flags |= S_SYNC;
-		else
-			inode->i_flags &= ~S_SYNC;
-		if (flags & EXT2_APPEND_FL)
-			inode->i_flags |= S_APPEND;
-		else
-			inode->i_flags &= ~S_APPEND;
-		if (flags & EXT2_IMMUTABLE_FL)
-			inode->i_flags |= S_IMMUTABLE;
-		else
-			inode->i_flags &= ~S_IMMUTABLE;
-		if (flags & EXT2_NOATIME_FL)
-			inode->i_flags |= S_NOATIME;
-		else
-			inode->i_flags &= ~S_NOATIME;
+		ext2_set_inode_flags(inode);
 		inode->i_ctime = CURRENT_TIME;
 		mark_inode_dirty(inode);
 		return 0;
diff -Nru a/fs/ext3/ialloc.c b/fs/ext3/ialloc.c
--- a/fs/ext3/ialloc.c	Thu Mar 13 00:37:19 2003
+++ b/fs/ext3/ialloc.c	Thu Mar 13 00:37:19 2003
@@ -652,8 +652,7 @@
 #endif
 	inode->u.ext3_i.i_block_group = group;
 	
-	if (inode->u.ext3_i.i_flags & EXT3_SYNC_FL)
-		inode->i_flags |= S_SYNC;
+	ext3_set_inode_flags(inode);
 	if (IS_SYNC(inode))
 		handle->h_sync = 1;
 	insert_inode_hash(inode);
diff -Nru a/fs/ext3/inode.c b/fs/ext3/inode.c
--- a/fs/ext3/inode.c	Thu Mar 13 00:37:19 2003
+++ b/fs/ext3/inode.c	Thu Mar 13 00:37:19 2003
@@ -2061,6 +2061,22 @@
 	return -EIO;
 }
 
+void ext3_set_inode_flags(struct inode *inode)
+{
+	unsigned int flags = inode->u.ext3_i.i_flags;
+
+	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME);
+	if (flags & EXT3_SYNC_FL)
+		inode->i_flags |= S_SYNC;
+	if (flags & EXT3_APPEND_FL)
+		inode->i_flags |= S_APPEND;
+	if (flags & EXT3_IMMUTABLE_FL)
+		inode->i_flags |= S_IMMUTABLE;
+	if (flags & EXT3_NOATIME_FL)
+		inode->i_flags |= S_NOATIME;
+}
+
+
 void ext3_read_inode(struct inode * inode)
 {
 	struct ext3_iloc iloc;
@@ -2158,23 +2174,7 @@
 	} else 
 		init_special_inode(inode, inode->i_mode,
 				   le32_to_cpu(iloc.raw_inode->i_block[0]));
-	/* inode->i_attr_flags = 0;				unused */
-	if (inode->u.ext3_i.i_flags & EXT3_SYNC_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_SYNCRONOUS; unused */
-		inode->i_flags |= S_SYNC;
-	}
-	if (inode->u.ext3_i.i_flags & EXT3_APPEND_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_APPEND;	unused */
-		inode->i_flags |= S_APPEND;
-	}
-	if (inode->u.ext3_i.i_flags & EXT3_IMMUTABLE_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_IMMUTABLE;	unused */
-		inode->i_flags |= S_IMMUTABLE;
-	}
-	if (inode->u.ext3_i.i_flags & EXT3_NOATIME_FL) {
-		/* inode->i_attr_flags |= ATTR_FLAG_NOATIME;	unused */
-		inode->i_flags |= S_NOATIME;
-	}
+	ext3_set_inode_flags(inode);
 	return;
 	
 bad_inode:
diff -Nru a/fs/ext3/ioctl.c b/fs/ext3/ioctl.c
--- a/fs/ext3/ioctl.c	Thu Mar 13 00:37:19 2003
+++ b/fs/ext3/ioctl.c	Thu Mar 13 00:37:19 2003
@@ -81,22 +81,7 @@
 		flags |= oldflags & ~EXT3_FL_USER_MODIFIABLE;
 		inode->u.ext3_i.i_flags = flags;
 
-		if (flags & EXT3_SYNC_FL)
-			inode->i_flags |= S_SYNC;
-		else
-			inode->i_flags &= ~S_SYNC;
-		if (flags & EXT3_APPEND_FL)
-			inode->i_flags |= S_APPEND;
-		else
-			inode->i_flags &= ~S_APPEND;
-		if (flags & EXT3_IMMUTABLE_FL)
-			inode->i_flags |= S_IMMUTABLE;
-		else
-			inode->i_flags &= ~S_IMMUTABLE;
-		if (flags & EXT3_NOATIME_FL)
-			inode->i_flags |= S_NOATIME;
-		else
-			inode->i_flags &= ~S_NOATIME;
+		ext3_set_inode_flags(inode);
 		inode->i_ctime = CURRENT_TIME;
 
 		err = ext3_mark_iloc_dirty(handle, inode, &iloc);
diff -Nru a/include/linux/ext2_fs.h b/include/linux/ext2_fs.h
--- a/include/linux/ext2_fs.h	Thu Mar 13 00:37:19 2003
+++ b/include/linux/ext2_fs.h	Thu Mar 13 00:37:19 2003
@@ -613,6 +613,7 @@
 extern int ext2_sync_inode (struct inode *);
 extern void ext2_discard_prealloc (struct inode *);
 extern void ext2_truncate (struct inode *);
+extern void ext2_set_inode_flags(struct inode *inode);
 
 /* ioctl.c */
 extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
diff -Nru a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
--- a/include/linux/ext3_fs.h	Thu Mar 13 00:37:19 2003
+++ b/include/linux/ext3_fs.h	Thu Mar 13 00:37:19 2003
@@ -731,6 +731,7 @@
 extern void ext3_dirty_inode(struct inode *);
 extern int ext3_change_inode_journal_flag(struct inode *, int);
 extern void ext3_truncate (struct inode *);
+extern void ext3_set_inode_flags(struct inode *);
 
 /* ioctl.c */
 extern int ext3_ioctl (struct inode *, struct file *, unsigned int,

