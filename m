Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbVLMR5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVLMR5L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 12:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVLMR5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 12:57:11 -0500
Received: from verein.lst.de ([213.95.11.210]:40403 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S932451AbVLMR5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 12:57:05 -0500
Date: Tue, 13 Dec 2005 18:56:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] per-mount noatime and nodiratime
Message-ID: <20051213175659.GF17130@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00,UPPERCASE_25_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Turn noatime and nodiratime into per-mount instead of per-sb flags.

After all the preparations this is a rather trivial patch, touch_atime
and nfs need to be changed to check the new location (and I've killed
the IS_NOATIME/IS_NODIRATIME macros that were only used by touch_atime
while we were at it), and the mount/remount code needed small changes
to treat it correctly.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6.15-rc5/fs/inode.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/inode.c	2005-12-12 18:51:16.000000000 +0100
+++ linux-2.6.15-rc5/fs/inode.c	2005-12-13 12:13:30.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/cdev.h>
 #include <linux/bootmem.h>
 #include <linux/inotify.h>
+#include <linux/mount.h>
 
 /*
  * This is needed for the following functions:
@@ -1189,14 +1190,14 @@
 	struct inode *inode = dentry->d_inode;
 	struct timespec now;
 
-	/* per-mountpoint checks will go here */
-	if (IS_NOATIME(inode))
-		return;
-	if (IS_NODIRATIME(inode) && S_ISDIR(inode->i_mode))
-		return;
 	if (IS_RDONLY(inode))
 		return;
 
+	if ((inode->i_flags & S_NOATIME) ||
+	    (mnt->mnt_flags & MNT_NOATIME) ||
+	    ((mnt->mnt_flags & MNT_NODIRATIME) && S_ISDIR(inode->i_mode)))
+		return;
+
 	now = current_fs_time(inode->i_sb);
 	if (!timespec_equal(&inode->i_atime, &now)) {
 		inode->i_atime = now;
Index: linux-2.6.15-rc5/fs/namespace.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/namespace.c	2005-12-12 18:51:16.000000000 +0100
+++ linux-2.6.15-rc5/fs/namespace.c	2005-12-13 12:01:01.000000000 +0100
@@ -355,14 +355,14 @@
 		{ MS_SYNCHRONOUS, ",sync" },
 		{ MS_DIRSYNC, ",dirsync" },
 		{ MS_MANDLOCK, ",mand" },
-		{ MS_NOATIME, ",noatime" },
-		{ MS_NODIRATIME, ",nodiratime" },
 		{ 0, NULL }
 	};
 	static struct proc_fs_info mnt_info[] = {
 		{ MNT_NOSUID, ",nosuid" },
 		{ MNT_NODEV, ",nodev" },
 		{ MNT_NOEXEC, ",noexec" },
+		{ MNT_NOATIME, ",noatime" },
+		{ MNT_NODIRATIME, ",nodiratime" },
 		{ 0, NULL }
 	};
 	struct proc_fs_info *fs_infop;
@@ -1286,7 +1286,13 @@
 		mnt_flags |= MNT_NODEV;
 	if (flags & MS_NOEXEC)
 		mnt_flags |= MNT_NOEXEC;
-	flags &= ~(MS_NOSUID | MS_NOEXEC | MS_NODEV | MS_ACTIVE);
+	if (flags & MS_NOATIME)
+		mnt_flags |= MNT_NOATIME;
+	if (flags & MS_NODIRATIME)
+		mnt_flags |= MNT_NODIRATIME;
+
+	flags &= ~(MS_NOSUID | MS_NOEXEC | MS_NODEV | MS_ACTIVE |
+		   MS_NOATIME | MS_NODIRATIME);
 
 	/* ... and get the mountpoint */
 	retval = path_lookup(dir_name, LOOKUP_FOLLOW, &nd);
Index: linux-2.6.15-rc5/fs/nfs/inode.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/nfs/inode.c	2005-12-13 11:00:57.000000000 +0100
+++ linux-2.6.15-rc5/fs/nfs/inode.c	2005-12-13 11:50:51.000000000 +0100
@@ -936,10 +936,10 @@
 	int need_atime = NFS_I(inode)->cache_validity & NFS_INO_INVALID_ATIME;
 	int err;
 
-	if (__IS_FLG(inode, MS_NOATIME))
-		need_atime = 0;
-	else if (__IS_FLG(inode, MS_NODIRATIME) && S_ISDIR(inode->i_mode))
+	if ((mnt->mnt_flags & MNT_NOATIME) ||
+	    ((mnt->mnt_flags & MNT_NODIRATIME) && S_ISDIR(inode->i_mode)))
 		need_atime = 0;
+
 	/* We may force a getattr if the user cares about atime */
 	if (need_atime)
 		err = __nfs_revalidate_inode(NFS_SERVER(inode), inode);
Index: linux-2.6.15-rc5/fs/super.c
===================================================================
--- linux-2.6.15-rc5.orig/fs/super.c	2005-12-13 11:27:14.000000000 +0100
+++ linux-2.6.15-rc5/fs/super.c	2005-12-13 12:06:00.000000000 +0100
@@ -830,9 +830,9 @@
 	mnt->mnt_parent = mnt;
 
 	if (type->fs_flags & FS_NOATIME)
-		sb->s_flags |= MS_NOATIME;
+		mnt->mnt_flags |= MNT_NOATIME;
 	if (type->fs_flags & FS_NODIRATIME)
-		sb->s_flags |= MS_NODIRATIME;
+		mnt->mnt_flags |= MNT_NODIRATIME;
 
 	up_write(&sb->s_umount);
 	free_secdata(secdata);
Index: linux-2.6.15-rc5/include/linux/fs.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/fs.h	2005-12-13 11:12:05.000000000 +0100
+++ linux-2.6.15-rc5/include/linux/fs.h	2005-12-13 12:05:24.000000000 +0100
@@ -116,8 +116,7 @@
 /*
  * Superblock flags that can be altered by MS_REMOUNT
  */
-#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_NOATIME|\
-			 MS_NODIRATIME)
+#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK)
 
 /*
  * Old magic mount flag and mask
@@ -163,8 +162,6 @@
 #define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
 #define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
 #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
-#define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))
-#define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
 #define IS_POSIXACL(inode)	__IS_FLG(inode, MS_POSIXACL)
 
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
Index: linux-2.6.15-rc5/include/linux/mount.h
===================================================================
--- linux-2.6.15-rc5.orig/include/linux/mount.h	2005-12-12 18:51:18.000000000 +0100
+++ linux-2.6.15-rc5/include/linux/mount.h	2005-12-13 11:57:49.000000000 +0100
@@ -20,8 +20,11 @@
 #define MNT_NOSUID	0x01
 #define MNT_NODEV	0x02
 #define MNT_NOEXEC	0x04
-#define MNT_SHARED	0x10	/* if the vfsmount is a shared mount */
-#define MNT_UNBINDABLE	0x20	/* if the vfsmount is a unbindable mount */
+#define MNT_NOATIME	0x08
+#define MNT_NODIRATIME	0x10
+
+#define MNT_SHARED	0x1000	/* if the vfsmount is a shared mount */
+#define MNT_UNBINDABLE	0x2000	/* if the vfsmount is a unbindable mount */
 
 #define MNT_PNODE_MASK	(MNT_SHARED | MNT_UNBINDABLE)
 
