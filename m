Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030597AbVLWSDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030597AbVLWSDl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 13:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbVLWSDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 13:03:41 -0500
Received: from verein.lst.de ([213.95.11.210]:42631 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1030591AbVLWSDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 13:03:40 -0500
Date: Fri, 23 Dec 2005 19:03:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] per-mountpoint noatime/nodiratime
Message-ID: <20051223180333.GA4842@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New version of the per-mount noatime patch to address Al's dislike of
the FS_NOATIME/FS_NODIRATIME flags and the nfs NULL vfsmount problem.

We now still obey MS_NOATIME/MS_NODIRATIME in s_flags, but the only
way to set those is from ->get_sb / ->remount_fs.  touch_atime deals
with a NULL vfsmount fine now.

I'm currently on chistmas vacation and didn't want to run -mm on my
laptop, so this patch is against current mainline plus the following
patches from -mm that are requirements for this work:

 replace-inode_update_time-with-file_update_time.patch
 replace-inode_update_time-with-file_update_time-comments.patch
 replace-inode_update_time-with-file_update_time-switch-ntfs-to-touch_atime.patch
 switch-autofs4-to-touch_atime.patch
 remove-update_atime.patch
 ntfs-remove-superflous-ms_noatime-ms_nodiratime-assignments.patch
 9p-remove-superflous-ms_nodiratime-assignment.patch
 git-xfs.patch
 remove-ms_noatime-mirroring-inside-xfs.patch

Andew, I think it should apply against -mm if you remove the following
patches from the previous per-mountpoint no-atime series:

 introduce-fs_noatime-and-fs_nodiratime-flags.patch
 fs_noatime-for-ocfs.patch
 per-mount-noatime-and-nodiratime.patch

And now the actual patch and changelog for git:

--
From: Christoph Hellwig <hch@lst.de>

Turn noatime and nodiratime into per-mount instead of per-sb flags.

After all the preparations this is a rather trivial patch.  The mount code
needs to treat the two options as per-mount instead of per-superblock,
and touch_atime needs to be changed to check the new MNT_ flags in addition
to the MS_ flags that are kept for filesystems that are always
noatime/nodiratime but not user settable anymore.  Besides that core
code only nfs needed an update because it's leaving atime updates to the
server and thus sets the S_NOATIME flag on every inode, but needs to
know whether it's a real noatime mount for an getattr optimization.

While we're at it I've killed the IS_NOATIME/IS_NODIRATIME macros that were
only used by touch_atime.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/fs/inode.c
===================================================================
--- linux-2.6.orig/fs/inode.c	2005-12-22 19:35:06.000000000 +0100
+++ linux-2.6/fs/inode.c	2005-12-23 11:09:23.000000000 +0100
@@ -22,6 +22,7 @@
 #include <linux/cdev.h>
 #include <linux/bootmem.h>
 #include <linux/inotify.h>
+#include <linux/mount.h>
 
 /*
  * This is needed for the following functions:
@@ -1189,12 +1190,20 @@
 	struct inode *inode = dentry->d_inode;
 	struct timespec now;
 
-	/* per-mountpoint checks will go here */
-	if (IS_NOATIME(inode))
+	if (IS_RDONLY(inode))
 		return;
-	if (IS_NODIRATIME(inode) && S_ISDIR(inode->i_mode))
+
+	if ((inode->i_flags & S_NOATIME) ||
+	    (inode->i_sb->s_flags & MS_NOATIME) ||
+	    ((inode->i_sb->s_flags & MS_NODIRATIME) && S_ISDIR(inode->i_mode)))
 		return;
-	if (IS_RDONLY(inode))
+
+	/*
+	 * We may have a NULL vfsmount when coming from NFSD
+	 */
+	if (mnt &&
+	    ((mnt->mnt_flags & MNT_NOATIME) ||
+	     ((mnt->mnt_flags & MNT_NODIRATIME) && S_ISDIR(inode->i_mode))))
 		return;
 
 	now = current_fs_time(inode->i_sb);
Index: linux-2.6/fs/namespace.c
===================================================================
--- linux-2.6.orig/fs/namespace.c	2005-11-10 01:26:32.000000000 +0100
+++ linux-2.6/fs/namespace.c	2005-12-22 19:35:30.000000000 +0100
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
Index: linux-2.6/fs/nfs/inode.c
===================================================================
--- linux-2.6.orig/fs/nfs/inode.c	2005-12-22 19:26:06.000000000 +0100
+++ linux-2.6/fs/nfs/inode.c	2005-12-23 12:13:43.000000000 +0100
@@ -958,11 +958,19 @@
 	int need_atime = NFS_I(inode)->cache_validity & NFS_INO_INVALID_ATIME;
 	int err;
 
-	if (__IS_FLG(inode, MS_NOATIME))
-		need_atime = 0;
-	else if (__IS_FLG(inode, MS_NODIRATIME) && S_ISDIR(inode->i_mode))
+	/*
+	 * We may force a getattr if the user cares about atime.
+	 *
+	 * Note that we only have to check the vfsmount flags here:
+	 *  - NFS always sets S_NOATIME by so checking it would give a
+	 *    bogus result
+	 *  - NFS never sets MS_NOATIME or MS_NODIRATIME so there is
+	 *    no point in checking those.
+	 */
+ 	if ((mnt->mnt_flags & MNT_NOATIME) ||
+ 	    ((mnt->mnt_flags & MNT_NODIRATIME) && S_ISDIR(inode->i_mode)))
 		need_atime = 0;
-	/* We may force a getattr if the user cares about atime */
+
 	if (need_atime)
 		err = __nfs_revalidate_inode(NFS_SERVER(inode), inode);
 	else
Index: linux-2.6/include/linux/fs.h
===================================================================
--- linux-2.6.orig/include/linux/fs.h	2005-12-22 19:35:06.000000000 +0100
+++ linux-2.6/include/linux/fs.h	2005-12-22 19:35:31.000000000 +0100
@@ -115,8 +115,7 @@
 /*
  * Superblock flags that can be altered by MS_REMOUNT
  */
-#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_NOATIME|\
-			 MS_NODIRATIME)
+#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK)
 
 /*
  * Old magic mount flag and mask
@@ -162,8 +161,6 @@
 #define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
 #define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
 #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
-#define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))
-#define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
 #define IS_POSIXACL(inode)	__IS_FLG(inode, MS_POSIXACL)
 
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
Index: linux-2.6/include/linux/mount.h
===================================================================
--- linux-2.6.orig/include/linux/mount.h	2005-11-12 04:41:47.000000000 +0100
+++ linux-2.6/include/linux/mount.h	2005-12-22 19:37:22.000000000 +0100
@@ -20,9 +20,12 @@
 #define MNT_NOSUID	0x01
 #define MNT_NODEV	0x02
 #define MNT_NOEXEC	0x04
-#define MNT_SHARED	0x10	/* if the vfsmount is a shared mount */
-#define MNT_UNBINDABLE	0x20	/* if the vfsmount is a unbindable mount */
-#define MNT_PNODE_MASK	0x30	/* propogation flag mask */
+#define MNT_NOATIME	0x08
+#define MNT_NODIRATIME	0x10
+
+#define MNT_SHARED	0x1000	/* if the vfsmount is a shared mount */
+#define MNT_UNBINDABLE	0x2000	/* if the vfsmount is a unbindable mount */
+#define MNT_PNODE_MASK	0x3000	/* propogation flag mask */
 
 struct vfsmount {
 	struct list_head mnt_hash;
