Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262501AbSJGCsl>; Sun, 6 Oct 2002 22:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262502AbSJGCsl>; Sun, 6 Oct 2002 22:48:41 -0400
Received: from zok.sgi.com ([204.94.215.101]:48550 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S262501AbSJGCsk>;
	Sun, 6 Oct 2002 22:48:40 -0400
Date: Mon, 7 Oct 2002 12:53:30 +1000
From: Nathan Scott <nathans@sgi.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2][RESEND] Applying the umask in the VFS optionally
Message-ID: <20021007025330.GC700@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a patch based on Andreas' recent mail describing a stumbling
block in the VFS which prevents filesystems that wish to implement
POSIX ACLs from doing so.  Details here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102831541509385&w=2

The patch was discussed on fsdevel and lkml with no concerns raised,
just suggestions for minor tweaks (which have been incorporated).

cheers.

-- 
Nathan


 fs/namei.c         |   13 ++++++++-----
 include/linux/fs.h |    2 ++
 2 files changed, 10 insertions, 5 deletions

diff -Naur 2.5.40-pristine/fs/namei.c 2.5.40-posixacl/fs/namei.c
--- 2.5.40-pristine/fs/namei.c	2002-09-23 11:41:02.000000000 +1000
+++ 2.5.40-posixacl/fs/namei.c	2002-10-06 16:49:05.000000000 +1000
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
diff -Naur 2.5.40-pristine/include/linux/fs.h 2.5.40-posixacl/include/linux/fs.h
--- 2.5.40-pristine/include/linux/fs.h	2002-09-23 11:41:11.000000000 +1000
+++ 2.5.40-posixacl/include/linux/fs.h	2002-10-06 16:44:22.000000000 +1000
@@ -110,6 +110,7 @@
 #define MS_MOVE		8192
 #define MS_REC		16384
 #define MS_VERBOSE	32768
+#define MS_POSIXACL	65536	/* VFS does not apply the umask */
 #define MS_ACTIVE	(1<<30)
 #define MS_NOUSER	(1<<31)
 
@@ -164,6 +165,7 @@
 #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
 #define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))
 #define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
+#define IS_POSIXACL(inode)	__IS_FLG(inode, MS_POSIXACL)
 
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
 
