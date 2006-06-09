Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965292AbWFIQmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965292AbWFIQmZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 12:42:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965293AbWFIQmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 12:42:25 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:63819 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S965292AbWFIQmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 12:42:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:cc:message-id:date:from;
        b=decTQ7RIZh7tHQZ2PSEGrqU73EygN6QdjNQ/D4gA64lOUlF64KeQbsluQXPP2tYttqR7KhmlXpuzDHUp8yuBtCuV1z8wcvecj4S02MMzsbsbVxSCeWU/BOUY+f1JiV2uXvenQlsuggan9TSxYrb3Ze/0hRKdItCj28H3QDfxVS0=
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] vfs: support for COW files in sys_open
Cc: cspalletta@gmail.com, viro@zeniv.linux.org.uk
Message-Id: <20060609165321.66EEC118601@localhost.localdomain>
Date: Fri,  9 Jun 2006 12:53:21 -0400 (EDT)
From: carl <cspalletta@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giving the O_COW flag to open() will return a special error, if
IS_COW(inode) and write permissions are expressed or implied.  COW-aware
applications may set this flag and deal with this error according to
some user defined policy.  This will not change the semantics of any
existing application or affect any kernel user of open_namei(); nor does
it affect future applications unless they use O_COW.  Filesystem level
code is unimplemented except for an ext2 example.

Signed-off-by: Carl Spalletta <cspalletta@gmail.com>
---

 fs/namei.c                  |   17 +++++++++++++++++
 include/linux/fs.h          |    3 +++
 include/asm-generic/errno.h |    2 ++
 include/linux/ext2_fs.h     |    1 +
 fs/ext2/inode.c             |    2 ++
 5 files changed, 25 insertions(+)

--- a/fs/namei.c	2006-06-07 11:18:15.000000000 -0400
+++ b/fs/namei.c	2006-06-06 13:59:41.000000000 -0400
@@ -244,6 +244,11 @@ int permission(struct inode *inode, int 
 		 */
 		if (IS_IMMUTABLE(inode))
 			return -EACCES;
+		/*
+		 * COW-aware applications must set their own policy for this error
+		 */
+		if (mask & MAY_COW)
+			return -ECOW;
 	}
 
 
@@ -1485,6 +1490,12 @@ int may_open(struct nameidata *nd, int a
 	if (!inode)
 		return -ENOENT;
 
+	/*
+	 * Cleaner, and simplifies test in permission()
+	 */
+	if(!(IS_COW(inode)))
+		acc_mode &= ~MAY_COW;
+
 	if (S_ISLNK(inode->i_mode))
 		return -ELOOP;
 	
@@ -1583,6 +1594,12 @@ int open_namei(int dfd, const char *path
 	if (flag & O_TRUNC)
 		acc_mode |= MAY_WRITE;
 
+	/*
+	 * -ECOW will be propagated back to filp_open if MAY_WRITE && IS_COW
+	 */
+	if (flag & O_COW)
+		acc_mode |= MAY_COW;
+
 	/* Allow the LSM permission hook to distinguish append 
 	   access from general write access. */
 	if (flag & O_APPEND)
--- a/include/linux/fs.h	2006-06-07 11:19:08.000000000 -0400
+++ b/include/linux/fs.h	2006-06-06 13:16:34.000000000 -0400
@@ -56,6 +56,7 @@ extern int dir_notify_enable;
 #define MAY_WRITE 2
 #define MAY_READ 4
 #define MAY_APPEND 8
+#define MAY_COW 16
 
 #define FMODE_READ 1
 #define FMODE_WRITE 2
@@ -135,6 +136,7 @@ extern int dir_notify_enable;
 #define S_NOCMTIME	128	/* Do not update file c/mtime */
 #define S_SWAPFILE	256	/* Do not truncate: swapon got its bmaps */
 #define S_PRIVATE	512	/* Inode is fs-internal */
+#define S_COW		1024    /* open will fail if MAY_COW && MAY_WRITE */
 
 /*
  * Note that nosuid etc flags are inode-specific: setting some file-system
@@ -167,6 +169,7 @@ extern int dir_notify_enable;
 #define IS_NOCMTIME(inode)	((inode)->i_flags & S_NOCMTIME)
 #define IS_SWAPFILE(inode)	((inode)->i_flags & S_SWAPFILE)
 #define IS_PRIVATE(inode)	((inode)->i_flags & S_PRIVATE)
+#define IS_COW(inode)		((inode)->i_flags & S_COW)
 
 /* the read-only stuff doesn't really belong here, but any other place is
    probably as bad and I don't want to create yet another include file. */
--- a/include/asm-generic/errno.h	2006-06-07 11:19:09.000000000 -0400
+++ b/include/asm-generic/errno.h	2006-06-06 12:35:28.000000000 -0400
@@ -106,4 +106,6 @@
 #define	EOWNERDEAD	130	/* Owner died */
 #define	ENOTRECOVERABLE	131	/* State not recoverable */
 
+#define	ECOW		132	/* COW file opened with write permissions */
+
 #endif

--- a/include/linux/ext2_fs.h	2006-06-07 11:19:11.000000000 -0400
+++ b/include/linux/ext2_fs.h	2006-06-06 13:26:38.000000000 -0400
@@ -192,6 +192,7 @@ struct ext2_group_desc
 #define EXT2_NOTAIL_FL			0x00008000 /* file tail should not be merged */
 #define EXT2_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
 #define EXT2_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
+#define EXT2_COW_FL			0x00040000 /* Hint to COW-aware applications */
 #define EXT2_RESERVED_FL		0x80000000 /* reserved for ext2 lib */
 
 #define EXT2_FL_USER_VISIBLE		0x0003DFFF /* User visible flags */
--- a/fs/ext2/inode.c	2006-06-07 11:19:12.000000000 -0400
+++ b/fs/ext2/inode.c	2006-06-06 13:32:28.000000000 -0400
@@ -1065,6 +1065,8 @@ void ext2_set_inode_flags(struct inode *
 		inode->i_flags |= S_NOATIME;
 	if (flags & EXT2_DIRSYNC_FL)
 		inode->i_flags |= S_DIRSYNC;
+	if (flags & EXT2_COW_FL)
+		inode->i_flags |= S_COW;
 }
 
 void ext2_read_inode (struct inode * inode)
