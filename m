Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261718AbSJQDUz>; Wed, 16 Oct 2002 23:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261675AbSJQDRC>; Wed, 16 Oct 2002 23:17:02 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:57272 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S261677AbSJQDOM>;
	Wed, 16 Oct 2002 23:14:12 -0400
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: [PATCH 2/5] Posix ACL support for ext 2/3 filesystems
From: tytso@mit.edu
Message-Id: <E1821Cj-0004Ar-00@snap.thunk.org>
Date: Wed, 16 Oct 2002 23:20:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch (as well as the previous one) implements core ACL support
which is needed for XFS as well as ext2/3 ACL support.  It causes umask
handling to be skilled for inodes that contain POSIX acl's, so that the
original mode information can be passed down to the low-level fs code,
which will take care of handling the umask.

This patch has been requested by the JFS team as well.  Linus, please
apply.

                                                        - Ted

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.798   -> 1.799  
#	  include/linux/fs.h	1.172   -> 1.173  
#	          fs/namei.c	1.56    -> 1.57   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/16	tytso@snap.thunk.org	1.799
# Port of 0.8.50 acl-ms-posixacl patch to 2.5
# 
# This patch (as well as the previous one) implements core ACL support
# which is needed for XFS as well as ext2/3 ACL support.  It causes umask
# handling to be skilled for inodes that contain POSIX acl's, so that the
# original mode information can be passed down to the low-level fs code,
# which will take care of handling the umask.
# --------------------------------------------
#
diff -Nru a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Wed Oct 16 22:54:37 2002
+++ b/fs/namei.c	Wed Oct 16 22:54:37 2002
@@ -1279,8 +1279,9 @@
 
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode) {
-		error = vfs_create(dir->d_inode, dentry,
-				   mode & ~current->fs->umask);
+		if (!IS_POSIXACL(dir->d_inode))
+			mode &= ~current->fs->umask;
+		error = vfs_create(dir->d_inode, dentry, mode);
 		up(&dir->d_inode->i_sem);
 		dput(nd->dentry);
 		nd->dentry = dentry;
@@ -1442,7 +1443,8 @@
 	dentry = lookup_create(&nd, 0);
 	error = PTR_ERR(dentry);
 
-	mode &= ~current->fs->umask;
+	if (!IS_POSIXACL(nd.dentry->d_inode))
+		mode &= ~current->fs->umask;
 	if (!IS_ERR(dentry)) {
 		switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
@@ -1508,8 +1510,9 @@
 		dentry = lookup_create(&nd, 1);
 		error = PTR_ERR(dentry);
 		if (!IS_ERR(dentry)) {
-			error = vfs_mkdir(nd.dentry->d_inode, dentry,
-					  mode & ~current->fs->umask);
+			if (!IS_POSIXACL(nd.dentry->d_inode))
+				mode &= ~current->fs->umask;
+			error = vfs_mkdir(nd.dentry->d_inode, dentry, mode);
 			dput(dentry);
 		}
 		up(&nd.dentry->d_inode->i_sem);
diff -Nru a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Wed Oct 16 22:54:37 2002
+++ b/include/linux/fs.h	Wed Oct 16 22:54:37 2002
@@ -110,6 +110,7 @@
 #define MS_MOVE		8192
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
@@ -164,6 +165,7 @@
 #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
 #define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))
 #define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
+#define IS_POSIXACL(inode)	__IS_FLG(inode, MS_POSIXACL)
 
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
 
