Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264206AbUDGWvy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 18:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264201AbUDGWvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 18:51:25 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:59573 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261231AbUDGWu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 18:50:56 -0400
Date: Thu, 8 Apr 2004 00:50:55 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: [Patch] BME, noatime and nodiratime II
Message-ID: <20040407225054.GA5067@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Andrew!

here is the updated patch, if Al is okay with it,
please consider for inclusion ...

quick overview:

 - adds the vfs mount flags propagation
 - fixes the /proc display and prepares it for later
   use by MNT_RDONLY and similar? 
 - implements noatime and nodiratime per mountpoint

TIA,
Herbert


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-2.6.5-atime2.diff"

diff -NurpP --minimal linux-2.6.5/fs/namespace.c linux-2.6.5-atime2/fs/namespace.c
--- linux-2.6.5/fs/namespace.c	2004-04-04 18:03:09.000000000 +0200
+++ linux-2.6.5-atime2/fs/namespace.c	2004-04-04 23:46:28.000000000 +0200
@@ -206,37 +206,40 @@ static int show_vfsmnt(struct seq_file *
 	struct vfsmount *mnt = v;
 	int err = 0;
 	static struct proc_fs_info {
-		int flag;
-		char *str;
+		int s_flag;
+		int mnt_flag;
+		char *set_str;
+		char *unset_str;
 	} fs_info[] = {
-		{ MS_SYNCHRONOUS, ",sync" },
-		{ MS_DIRSYNC, ",dirsync" },
-		{ MS_MANDLOCK, ",mand" },
-		{ MS_NOATIME, ",noatime" },
-		{ MS_NODIRATIME, ",nodiratime" },
-		{ 0, NULL }
-	};
-	static struct proc_fs_info mnt_info[] = {
-		{ MNT_NOSUID, ",nosuid" },
-		{ MNT_NODEV, ",nodev" },
-		{ MNT_NOEXEC, ",noexec" },
-		{ 0, NULL }
+		{ MS_RDONLY, 0, "ro", "rw" },
+		{ MS_SYNCHRONOUS, 0, ",sync", NULL },
+		{ MS_DIRSYNC, 0, ",dirsync", NULL },
+		{ MS_MANDLOCK, 0, ",mand", NULL },
+		{ MS_NOATIME, MNT_NOATIME, ",noatime", NULL },
+		{ MS_NODIRATIME, MNT_NODIRATIME, ",nodiratime", NULL },
+		{ 0, MNT_NOSUID, ",nosuid", NULL },
+		{ 0, MNT_NODEV, ",nodev", NULL },
+		{ 0, MNT_NOEXEC, ",noexec", NULL },
+		{ 0, 0, NULL, NULL }
 	};
-	struct proc_fs_info *fs_infop;
+	struct proc_fs_info *p;
+	unsigned long s_flags = mnt->mnt_sb->s_flags;
+	int mnt_flags = mnt->mnt_flags;
 
 	mangle(m, mnt->mnt_devname ? mnt->mnt_devname : "none");
 	seq_putc(m, ' ');
 	seq_path(m, mnt, mnt->mnt_root, " \t\n\\");
 	seq_putc(m, ' ');
 	mangle(m, mnt->mnt_sb->s_type->name);
-	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? " ro" : " rw");
-	for (fs_infop = fs_info; fs_infop->flag; fs_infop++) {
-		if (mnt->mnt_sb->s_flags & fs_infop->flag)
-			seq_puts(m, fs_infop->str);
-	}
-	for (fs_infop = mnt_info; fs_infop->flag; fs_infop++) {
-		if (mnt->mnt_flags & fs_infop->flag)
-			seq_puts(m, fs_infop->str);
+	seq_putc(m, ' ');
+	for (p = fs_info; (p->s_flag | p->mnt_flag) ; p++) {
+		if ((s_flags & p->s_flag) || (mnt_flags & p->mnt_flag)) {
+			if (p->set_str)
+				seq_puts(m, p->set_str);
+		} else {
+			if (p->unset_str)
+				seq_puts(m, p->unset_str);
+		}
 	}
 	if (mnt->mnt_sb->s_op->show_options)
 		err = mnt->mnt_sb->s_op->show_options(m, mnt);
@@ -522,11 +525,13 @@ out_unlock:
 /*
  * do loopback mount.
  */
-static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
+static int do_loopback(struct nameidata *nd, char *old_name, unsigned long flags, int mnt_flags)
 {
 	struct nameidata old_nd;
 	struct vfsmount *mnt = NULL;
+	int recurse = flags & MS_REC;
 	int err = mount_is_safe(nd);
+
 	if (err)
 		return err;
 	if (!old_name || !*old_name)
@@ -553,6 +558,7 @@ static int do_loopback(struct nameidata 
 			spin_unlock(&vfsmount_lock);
 		} else
 			mntput(mnt);
+		mnt->mnt_flags = mnt_flags;
 	}
 
 	up_write(&current->namespace->sem);
@@ -763,12 +769,18 @@ long do_mount(char * dev_name, char * di
 		((char *)data_page)[PAGE_SIZE - 1] = 0;
 
 	/* Separate the per-mountpoint flags */
+	if (flags & MS_RDONLY)
+		mnt_flags |= MNT_RDONLY;
 	if (flags & MS_NOSUID)
 		mnt_flags |= MNT_NOSUID;
 	if (flags & MS_NODEV)
 		mnt_flags |= MNT_NODEV;
 	if (flags & MS_NOEXEC)
 		mnt_flags |= MNT_NOEXEC;
+	if (flags & MS_NOATIME)
+		mnt_flags |= MNT_NOATIME;
+	if (flags & MS_NODIRATIME)
+		mnt_flags |= MNT_NODIRATIME;
 	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);
 
 	/* ... and get the mountpoint */
@@ -784,7 +796,7 @@ long do_mount(char * dev_name, char * di
 		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
 	else if (flags & MS_BIND)
-		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+		retval = do_loopback(&nd, dev_name, flags, mnt_flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
diff -NurpP --minimal linux-2.6.5/include/linux/fs.h linux-2.6.5-atime2/include/linux/fs.h
--- linux-2.6.5/include/linux/fs.h	2004-04-04 18:03:13.000000000 +0200
+++ linux-2.6.5-atime2/include/linux/fs.h	2004-04-04 23:54:10.000000000 +0200
@@ -19,6 +19,7 @@
 #include <linux/cache.h>
 #include <linux/radix-tree.h>
 #include <linux/kobject.h>
+#include <linux/mount.h>
 #include <asm/atomic.h>
 
 struct iovec;
@@ -916,8 +917,14 @@ static inline void mark_inode_dirty_sync
 
 static inline void touch_atime(struct vfsmount *mnt, struct dentry *dentry)
 {
-	/* per-mountpoint checks will go here */
-	update_atime(dentry->d_inode);
+	struct inode *inode = dentry->d_inode;
+
+	if (MNT_IS_NOATIME(mnt))
+		return;
+	if (S_ISDIR(inode->i_mode) && MNT_IS_NODIRATIME(mnt))
+		return;
+
+	update_atime(inode);
 }
 
 static inline void file_accessed(struct file *file)
diff -NurpP --minimal linux-2.6.5/include/linux/mount.h linux-2.6.5-atime2/include/linux/mount.h
--- linux-2.6.5/include/linux/mount.h	2004-03-11 03:55:22.000000000 +0100
+++ linux-2.6.5-atime2/include/linux/mount.h	2004-04-07 23:12:42.000000000 +0200
@@ -17,6 +17,9 @@
 #define MNT_NOSUID	1
 #define MNT_NODEV	2
 #define MNT_NOEXEC	4
+#define MNT_RDONLY	8
+#define MNT_NOATIME	16
+#define MNT_NODIRATIME	32
 
 struct vfsmount
 {
@@ -33,6 +36,10 @@ struct vfsmount
 	struct list_head mnt_list;
 };
 
+#define	MNT_IS_RDONLY(m)	((m)->mnt_flags & MNT_RDONLY)
+#define	MNT_IS_NOATIME(m)	((m)->mnt_flags & MNT_NOATIME)
+#define	MNT_IS_NODIRATIME(m)	((m)->mnt_flags & MNT_NODIRATIME)
+
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
 {
 	if (mnt)

--+QahgC5+KEYLbs62--
