Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262194AbTCMIh6>; Thu, 13 Mar 2003 03:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262196AbTCMIh6>; Thu, 13 Mar 2003 03:37:58 -0500
Received: from thunk.org ([140.239.227.29]:18874 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262194AbTCMIhy>;
	Thu, 13 Mar 2003 03:37:54 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: [PATCH] BUGFIX: Ext2/3 noatime and dirsync sometimes ignored
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E18tOO7-0000jf-00@think.thunk.org>
Date: Thu, 13 Mar 2003 03:48:31 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I recently noticed a bug in ext2/3; newly created inodes which inherit
the noatime flag from their containing directory do not respect noatime
until the inode is flushed from the inode cache and then re-read later.
This is because the code which checks the ext2 no-atime attribute and
then sets the S_NOATIME in inode->i_flags is present in
ext2_read_inode(), but not in ext2_new_inode().

I fixed this in 2.4, and then found an even worse bug in the 2.5 code;
the DIRSYNC flag is completely ignored *except* in the case where a
directory is newly created using mkdir and its parent directory has the
DIRSYNC flag.  S_DIRSYNC doesn't get set in the ext2_new_inode() or the
ext2_ioctl() paths (which is used by chattr).

This patch centralizes the code which translates the ext2 flags in the
raw ext2 inode to the appropriate flag values in inode->i_flags in a
single location.  This fixes the bug, makes things cleaner, and also
removes 30 lines of code and 128 bytes of compiled x86 text in the
bargain.

                                                - Ted


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
#
# This patch includes the following deltas:
#  fs/ext2/ext2.h          |    1 +
#  fs/ext2/ialloc.c        |    5 +----
#  fs/ext2/inode.c         |   26 ++++++++++++++++++--------
#  fs/ext2/ioctl.c         |   17 +----------------
#  fs/ext3/ialloc.c        |    5 +----
#  fs/ext3/inode.c         |   27 +++++++++++++++++++--------
#  fs/ext3/ioctl.c         |   17 +----------------
#  include/linux/ext3_fs.h |    1 +
#  8 files changed, 43 insertions(+), 56 deletions(-)
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/13	tytso@think.thunk.org	1.1101
# Centralize setting inode flags from the raw ext2/3 inode
# 
# This fixes a bug where the noatime flag not being honored in inodes
# which inherited noatime from their directory flag (at least not until
# inode was flushed out of the inode cache and then re-read into the inode
# cache later on), and also saves code because the common code has all been 
# factored out.
# 
# This also fixes an even worse bug with DIRSYNC; it was only being
# honored for newly created directories which inherited the DIRSYNC 
# attribute.  Pre-existing directories which were read using
# ext2_read_inode or which had the DIRSYNC attribute set via chattr
# did not have S_DIRSYNC set in inode->i_flags so the DIRSYNC attribute
# was getting ignored!
# --------------------------------------------
#
diff -Nru a/fs/ext2/ext2.h b/fs/ext2/ext2.h
--- a/fs/ext2/ext2.h	Thu Mar 13 03:39:59 2003
+++ b/fs/ext2/ext2.h	Thu Mar 13 03:39:59 2003
@@ -112,6 +112,7 @@
 extern void ext2_discard_prealloc (struct inode *);
 extern void ext2_truncate (struct inode *);
 extern int ext2_setattr (struct dentry *, struct iattr *);
+extern void ext2_set_inode_flags(struct inode *inode);
 
 /* ioctl.c */
 extern int ext2_ioctl (struct inode *, struct file *, unsigned int,
diff -Nru a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
--- a/fs/ext2/ialloc.c	Thu Mar 13 03:39:59 2003
+++ b/fs/ext2/ialloc.c	Thu Mar 13 03:39:59 2003
@@ -545,10 +545,7 @@
 	ei->i_prealloc_count = 0;
 	ei->i_dir_start_lookup = 0;
 	ei->i_state = EXT2_STATE_NEW;
-	if (ei->i_flags & EXT2_SYNC_FL)
-		inode->i_flags |= S_SYNC;
-	if (ei->i_flags & EXT2_DIRSYNC_FL)
-		inode->i_flags |= S_DIRSYNC;
+	ext2_set_inode_flags(inode);
 	inode->i_generation = EXT2_SB(sb)->s_next_generation++;
 	insert_inode_hash(inode);
 
diff -Nru a/fs/ext2/inode.c b/fs/ext2/inode.c
--- a/fs/ext2/inode.c	Thu Mar 13 03:39:59 2003
+++ b/fs/ext2/inode.c	Thu Mar 13 03:39:59 2003
@@ -1011,6 +1011,23 @@
 	return ERR_PTR(-EIO);
 }
 
+void ext2_set_inode_flags(struct inode *inode)
+{
+	unsigned int flags = EXT2_I(inode)->i_flags;
+
+	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
+	if (flags & EXT2_SYNC_FL)
+		inode->i_flags |= S_SYNC;
+	if (flags & EXT2_APPEND_FL)
+		inode->i_flags |= S_APPEND;
+	if (flags & EXT2_IMMUTABLE_FL)
+		inode->i_flags |= S_IMMUTABLE;
+	if (flags & EXT2_NOATIME_FL)
+		inode->i_flags |= S_NOATIME;
+	if (flags & EXT2_DIRSYNC_FL)
+		inode->i_flags |= S_DIRSYNC;
+}
+
 void ext2_read_inode (struct inode * inode)
 {
 	struct ext2_inode_info *ei = EXT2_I(inode);
@@ -1108,14 +1125,7 @@
 				   le32_to_cpu(raw_inode->i_block[0]));
 	}
 	brelse (bh);
-	if (ei->i_flags & EXT2_SYNC_FL)
-		inode->i_flags |= S_SYNC;
-	if (ei->i_flags & EXT2_APPEND_FL)
-		inode->i_flags |= S_APPEND;
-	if (ei->i_flags & EXT2_IMMUTABLE_FL)
-		inode->i_flags |= S_IMMUTABLE;
-	if (ei->i_flags & EXT2_NOATIME_FL)
-		inode->i_flags |= S_NOATIME;
+	ext2_set_inode_flags(inode);
 	return;
 	
 bad_inode:
diff -Nru a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
--- a/fs/ext2/ioctl.c	Thu Mar 13 03:39:59 2003
+++ b/fs/ext2/ioctl.c	Thu Mar 13 03:39:59 2003
@@ -58,22 +58,7 @@
 		flags |= oldflags & ~EXT2_FL_USER_MODIFIABLE;
 		ei->i_flags = flags;
 
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
--- a/fs/ext3/ialloc.c	Thu Mar 13 03:39:59 2003
+++ b/fs/ext3/ialloc.c	Thu Mar 13 03:39:59 2003
@@ -568,10 +568,7 @@
 #endif
 	ei->i_block_group = group;
 	
-	if (ei->i_flags & EXT3_SYNC_FL)
-		inode->i_flags |= S_SYNC;
-	if (ei->i_flags & EXT3_DIRSYNC_FL)
-		inode->i_flags |= S_DIRSYNC;
+	ext3_set_inode_flags(inode);
 	if (IS_DIRSYNC(inode))
 		handle->h_sync = 1;
 	insert_inode_hash(inode);
diff -Nru a/fs/ext3/inode.c b/fs/ext3/inode.c
--- a/fs/ext3/inode.c	Thu Mar 13 03:39:59 2003
+++ b/fs/ext3/inode.c	Thu Mar 13 03:39:59 2003
@@ -2209,6 +2209,24 @@
 	return -EIO;
 }
 
+void ext3_set_inode_flags(struct inode *inode)
+{
+	unsigned int flags = EXT3_I(inode)->i_flags;
+
+	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
+	if (flags & EXT3_SYNC_FL)
+		inode->i_flags |= S_SYNC;
+	if (flags & EXT3_APPEND_FL)
+		inode->i_flags |= S_APPEND;
+	if (flags & EXT3_IMMUTABLE_FL)
+		inode->i_flags |= S_IMMUTABLE;
+	if (flags & EXT3_NOATIME_FL)
+		inode->i_flags |= S_NOATIME;
+	if (flags & EXT3_DIRSYNC_FL)
+		inode->i_flags |= S_DIRSYNC;
+}
+
+
 void ext3_read_inode(struct inode * inode)
 {
 	struct ext3_iloc iloc;
@@ -2320,14 +2338,7 @@
 		init_special_inode(inode, inode->i_mode,
 				   le32_to_cpu(iloc.raw_inode->i_block[0]));
 	}
-	if (ei->i_flags & EXT3_SYNC_FL)
-		inode->i_flags |= S_SYNC;
-	if (ei->i_flags & EXT3_APPEND_FL)
-		inode->i_flags |= S_APPEND;
-	if (ei->i_flags & EXT3_IMMUTABLE_FL)
-		inode->i_flags |= S_IMMUTABLE;
-	if (ei->i_flags & EXT3_NOATIME_FL)
-		inode->i_flags |= S_NOATIME;
+	ext3_set_inode_flags(inode);
 	return;
 	
 bad_inode:
diff -Nru a/fs/ext3/ioctl.c b/fs/ext3/ioctl.c
--- a/fs/ext3/ioctl.c	Thu Mar 13 03:39:59 2003
+++ b/fs/ext3/ioctl.c	Thu Mar 13 03:39:59 2003
@@ -85,22 +85,7 @@
 		flags |= oldflags & ~EXT3_FL_USER_MODIFIABLE;
 		ei->i_flags = flags;
 
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
diff -Nru a/include/linux/ext3_fs.h b/include/linux/ext3_fs.h
--- a/include/linux/ext3_fs.h	Thu Mar 13 03:39:59 2003
+++ b/include/linux/ext3_fs.h	Thu Mar 13 03:39:59 2003
@@ -730,6 +730,7 @@
 extern void ext3_dirty_inode(struct inode *);
 extern int ext3_change_inode_journal_flag(struct inode *, int);
 extern void ext3_truncate (struct inode *);
+extern void ext3_set_inode_flags(struct inode *);
 
 /* ioctl.c */
 extern int ext3_ioctl (struct inode *, struct file *, unsigned int,
