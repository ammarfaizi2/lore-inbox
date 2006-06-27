Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422646AbWF0WPO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422646AbWF0WPO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWF0WPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:15:13 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:22689 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030473AbWF0WPC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:15:02 -0400
Subject: [PATCH 20/20] honor r/w changes at do_remount() time
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:57 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221457.04ADBF71@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Originally from: Herbert Poetzl <herbert@13thfloor.at>

This is the core of the read-only bind mount patch set.

Note that this does _not_ add a "ro" option directly to
the bind mount operation.  If you require such a mount,
you must first do the bind, then follow it up with a
'mount -o remount,ro' operation.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namespace.c        |   27 +++++++++++++++++++++++++--
 lxc-dave/fs/open.c             |    2 +-
 lxc-dave/include/linux/mount.h |   19 +++++++++++++++++++
 3 files changed, 45 insertions(+), 3 deletions(-)

diff -puN fs/namespace.c~C-D8-actually-add-flags fs/namespace.c
--- lxc/fs/namespace.c~C-D8-actually-add-flags	2006-06-27 10:40:36.000000000 -0700
+++ lxc-dave/fs/namespace.c	2006-06-27 10:40:36.000000000 -0700
@@ -387,7 +387,10 @@ static int show_vfsmnt(struct seq_file *
 	seq_path(m, mnt, mnt->mnt_root, " \t\n\\");
 	seq_putc(m, ' ');
 	mangle(m, mnt->mnt_sb->s_type->name);
-	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? " ro" : " rw");
+	if ((mnt->mnt_sb->s_flags & MS_RDONLY) || __mnt_is_readonly(mnt))
+		seq_puts(m, " ro");
+	else
+		seq_puts(m, " rw");
 	for (fs_infop = fs_info; fs_infop->flag; fs_infop++) {
 		if (mnt->mnt_sb->s_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
@@ -956,6 +959,23 @@ out:
 	return err;
 }
 
+static int change_mount_flags(struct vfsmount *mnt, int ms_flags)
+{
+	int error = 0;
+	int readonly_request = 0;
+
+	if (ms_flags & MS_RDONLY)
+		readonly_request = 1;
+	if (readonly_request == __mnt_is_readonly(mnt))
+		return 0;
+
+	if (readonly_request)
+		error = mnt_make_readonly(mnt);
+	else
+		__mnt_make_writable(mnt);
+	return error;
+}
+
 /*
  * change filesystem flags. dir should be a physical root of filesystem.
  * If you've mounted a non-root directory somewhere and want to do remount
@@ -977,7 +997,10 @@ static int do_remount(struct nameidata *
 		return -EINVAL;
 
 	down_write(&sb->s_umount);
-	err = do_remount_sb(sb, flags, data, 0);
+	if (flags & MS_BIND)
+		err = change_mount_flags(nd->mnt, flags);
+	else
+		err = do_remount_sb(sb, flags, data, 0);
 	if (!err)
 		nd->mnt->mnt_flags = mnt_flags;
 	up_write(&sb->s_umount);
diff -puN fs/open.c~C-D8-actually-add-flags fs/open.c
--- lxc/fs/open.c~C-D8-actually-add-flags	2006-06-27 10:40:36.000000000 -0700
+++ lxc-dave/fs/open.c	2006-06-27 10:40:36.000000000 -0700
@@ -546,7 +546,7 @@ asmlinkage long sys_faccessat(int dfd, c
 	   special_file(nd.dentry->d_inode->i_mode))
 		goto out_path_release;
 
-	if(IS_RDONLY(nd.dentry->d_inode))
+	if(mnt_is_readonly(nd.mnt) || IS_RDONLY(nd.dentry->d_inode))
 		res = -EROFS;
 
 out_path_release:
diff -puN include/linux/mount.h~C-D8-actually-add-flags include/linux/mount.h
--- lxc/include/linux/mount.h~C-D8-actually-add-flags	2006-06-27 10:40:36.000000000 -0700
+++ lxc-dave/include/linux/mount.h	2006-06-27 10:40:36.000000000 -0700
@@ -98,6 +98,25 @@ static inline int __mnt_is_readonly(stru
 	return (atomic_read(&mnt->mnt_writers) == 0);
 }
 
+/*
+ * This needs to get a consistent look at mnt_writers.
+ * Without the lock, it can race against mnt_make_readonly()
+ * and mistake a temporarily decremented mnt_writers
+ * for a real read-only mount.
+ *
+ * Note: this is never suitable if you need to perform any
+ * write *operations* on the mount, only as a snapshot.
+ */
+static inline int mnt_is_readonly(struct vfsmount *mnt)
+{
+	int ret;
+
+	down_read(&mnt->mnt_sb->s_umount);
+	ret = __mnt_is_readonly(mnt);
+	up_read(&mnt->mnt_sb->s_umount);
+	return ret;
+}
+
 static inline int mnt_want_write(struct vfsmount *mnt)
 {
 	int ret = 0;
_
