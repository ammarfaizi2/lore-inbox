Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263283AbSJTJgu>; Sun, 20 Oct 2002 05:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263281AbSJTJfp>; Sun, 20 Oct 2002 05:35:45 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:10708 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S263283AbSJTJ3o>;
	Sun, 20 Oct 2002 05:29:44 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ext2/3 updates for 2.5.44 (8/11): core acl support 2
From: tytso@mit.edu
Message-Id: <E183CUu-0007Z4-00@snap.thunk.org>
Date: Sun, 20 Oct 2002 05:35:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/20	tytso@snap.thunk.org	1.817
# Port of 0.8.50 acl-ms-posixacl patch to 2.5
# 
# This patch (as well as the previous one) implements core ACL support
# which is needed for XFS as well as ext2/3 ACL support.  It causes umask
# handling to be skilled for inodes that contain POSIX acl's, so that the
# original mode information can be passed down to the low-level fs code,
# which will take care of handling the umask.
# --------------------------------------------
#
# fs/namei.c         |   13 ++++++++-----
# include/linux/fs.h |    2 ++
# 2 files changed, 10 insertions(+), 5 deletions(-)
#
diff -Nru a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Sun Oct 20 04:41:46 2002
+++ b/fs/namei.c	Sun Oct 20 04:41:46 2002
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
--- a/include/linux/fs.h	Sun Oct 20 04:41:46 2002
+++ b/include/linux/fs.h	Sun Oct 20 04:41:46 2002
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
 
