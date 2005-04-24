Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262382AbVDXUIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262382AbVDXUIs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 16:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbVDXUIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 16:08:47 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:22681 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262382AbVDXUIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 16:08:31 -0400
To: linux-fsdevel@vger.kernel.org, hch@infradead.org
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] private mounts
Message-Id: <E1DPnOn-0000T0-00@localhost>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 24 Apr 2005 22:08:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This simple patch adds support for private (or invisible) mounts.  The
rationale is to allow mounts to be private for a user but still in the
global namespace.

An immediate user of this would be FUSE, which currently achieves the
hiding of data with inode->permission(), which is less elegant.

Christoph, I'm specially interested in your opinion, since you were so
strongly opposed to the current solution in FUSE.

Performance measurements indicate that the overhead is about 2% of the
time spent following mounts, or 6ns per-mount on a 533 Celeron.

This patch does:

 - add new mount flag: MS_PRIVATE / MNT_PRIVATE
 - add new member in struct vfsmount: mnt_uid
 - if MNT_PRIVATE is set, set mnt_uid to current->fsuid in
   do_add_mount() and do_remount()
 - in clone_mnt() copy mnt_uid to the new mount
 - in lookup_mnt() while looping through the hash chain for the
   mountpoint, check if the mount is "visible" for this process, and
   skip it if not

Comments are appreciated.  If there are no vetoes agains the patch, I
think it's suitable for -mm.

Thanks,
Miklos

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

diff -rup orig/linux-2.6.11/fs/namespace.c linux-2.6.11/fs/namespace.c
--- orig/linux-2.6.11/fs/namespace.c	2005-03-04 23:18:48.000000000 +0100
+++ linux-2.6.11/fs/namespace.c	2005-04-24 12:44:41.000000000 +0200
@@ -81,6 +81,15 @@ void free_vfsmnt(struct vfsmount *mnt)
 }
 
 /*
+ * Check if this mount should be skipped or not
+ */
+static inline int mnt_visible(struct vfsmount *mnt)
+{
+	return !(mnt->mnt_flags & MNT_PRIVATE) ||
+		mnt->mnt_uid == current->fsuid;
+}
+
+/*
  * Now, lookup_mnt increments the ref count before returning
  * the vfsmount struct.
  */
@@ -97,7 +106,8 @@ struct vfsmount *lookup_mnt(struct vfsmo
 		if (tmp == head)
 			break;
 		p = list_entry(tmp, struct vfsmount, mnt_hash);
-		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry) {
+		if (p->mnt_parent == mnt && p->mnt_mountpoint == dentry &&
+		    mnt_visible(p)) {
 			found = mntget(p);
 			break;
 		}
@@ -155,6 +165,7 @@ clone_mnt(struct vfsmount *old, struct d
 
 	if (mnt) {
 		mnt->mnt_flags = old->mnt_flags;
+		mnt->mnt_uid = old->mnt_uid;
 		atomic_inc(&sb->s_active);
 		mnt->mnt_sb = sb;
 		mnt->mnt_root = dget(root);
@@ -234,6 +245,7 @@ static int show_vfsmnt(struct seq_file *
 		{ MNT_NOSUID, ",nosuid" },
 		{ MNT_NODEV, ",nodev" },
 		{ MNT_NOEXEC, ",noexec" },
+		{ MNT_PRIVATE, ",private" },
 		{ 0, NULL }
 	};
 	struct proc_fs_info *fs_infop;
@@ -252,6 +264,8 @@ static int show_vfsmnt(struct seq_file *
 		if (mnt->mnt_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
 	}
+	if (mnt->mnt_flags & MNT_PRIVATE)
+		seq_printf(m, ",mnt_uid=%u", mnt->mnt_uid);
 	if (mnt->mnt_sb->s_op->show_options)
 		err = mnt->mnt_sb->s_op->show_options(m, mnt);
 	seq_puts(m, " 0 0\n");
@@ -684,8 +698,11 @@ static int do_remount(struct nameidata *
 
 	down_write(&sb->s_umount);
 	err = do_remount_sb(sb, flags, data, 0);
-	if (!err)
+	if (!err) {
 		nd->mnt->mnt_flags=mnt_flags;
+		if (mnt_flags & MNT_PRIVATE)
+			nd->mnt->mnt_uid = current->fsuid;
+	}
 	up_write(&sb->s_umount);
 	if (!err)
 		security_sb_post_remount(nd->mnt, flags, data);
@@ -807,6 +824,8 @@ int do_add_mount(struct vfsmount *newmnt
 		goto unlock;
 
 	newmnt->mnt_flags = mnt_flags;
+	if (mnt_flags & MNT_PRIVATE)
+		newmnt->mnt_uid = current->fsuid;
 	err = graft_tree(newmnt, nd);
 
 	if (err == 0 && fslist) {
@@ -1033,7 +1052,9 @@ long do_mount(char * dev_name, char * di
 		mnt_flags |= MNT_NODEV;
 	if (flags & MS_NOEXEC)
 		mnt_flags |= MNT_NOEXEC;
-	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_ACTIVE);
+	if (flags & MS_PRIVATE)
+		mnt_flags |= MNT_PRIVATE;
+	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV|MS_PRIVATE|MS_ACTIVE);
 
 	/* ... and get the mountpoint */
 	retval = path_lookup(dir_name, LOOKUP_FOLLOW, &nd);
diff -rup orig/linux-2.6.11/include/linux/fs.h linux-2.6.11/include/linux/fs.h
--- orig/linux-2.6.11/include/linux/fs.h	2005-03-04 23:19:05.000000000 +0100
+++ linux-2.6.11/include/linux/fs.h	2005-04-24 10:23:33.000000000 +0200
@@ -96,6 +96,7 @@ extern int dir_notify_enable;
 #define MS_REMOUNT	32	/* Alter flags of a mounted FS */
 #define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
 #define MS_DIRSYNC	128	/* Directory modifications are synchronous */
+#define MS_PRIVATE	256	/* Make this mount invisible to other users */
 #define MS_NOATIME	1024	/* Do not update access times. */
 #define MS_NODIRATIME	2048	/* Do not update directory access times */
 #define MS_BIND		4096
diff -rup orig/linux-2.6.11/include/linux/mount.h linux-2.6.11/include/linux/mount.h
--- orig/linux-2.6.11/include/linux/mount.h	2004-12-25 11:52:55.000000000 +0100
+++ linux-2.6.11/include/linux/mount.h	2005-04-24 10:24:29.000000000 +0200
@@ -19,6 +19,7 @@
 #define MNT_NOSUID	1
 #define MNT_NODEV	2
 #define MNT_NOEXEC	4
+#define MNT_PRIVATE	8
 
 struct vfsmount
 {
@@ -31,6 +32,7 @@ struct vfsmount
 	struct list_head mnt_child;	/* and going through their mnt_child */
 	atomic_t mnt_count;
 	int mnt_flags;
+	uid_t mnt_uid;
 	int mnt_expiry_mark;		/* true if marked for expiry */
 	char *mnt_devname;		/* Name of device e.g. /dev/dsk/hda1 */
 	struct list_head mnt_list;
