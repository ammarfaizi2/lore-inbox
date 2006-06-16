Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWFPXO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWFPXO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWFPXO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:14:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:12960 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932121AbWFPXMd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:12:33 -0400
Subject: [RFC][PATCH 20/20] honor r/w changes at do_remount() time
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 16 Jun 2006 16:12:28 -0700
References: <20060616231213.D4C5D6AF@localhost.localdomain>
In-Reply-To: <20060616231213.D4C5D6AF@localhost.localdomain>
Message-Id: <20060616231228.2107A2EE@localhost.localdomain>
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
 lxc-dave/include/linux/mount.h |    1 -
 3 files changed, 26 insertions(+), 4 deletions(-)

diff -puN fs/namespace.c~C-D8-actually-add-flags fs/namespace.c
--- lxc/fs/namespace.c~C-D8-actually-add-flags	2006-06-16 15:58:12.000000000 -0700
+++ lxc-dave/fs/namespace.c	2006-06-16 15:58:12.000000000 -0700
@@ -378,7 +378,10 @@ static int show_vfsmnt(struct seq_file *
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
@@ -947,6 +950,23 @@ out:
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
@@ -968,7 +988,10 @@ static int do_remount(struct nameidata *
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
--- lxc/fs/open.c~C-D8-actually-add-flags	2006-06-16 15:58:12.000000000 -0700
+++ lxc-dave/fs/open.c	2006-06-16 15:58:12.000000000 -0700
@@ -546,7 +546,7 @@ asmlinkage long sys_faccessat(int dfd, c
 	   special_file(nd.dentry->d_inode->i_mode))
 		goto out_path_release;
 
-	if(IS_RDONLY(nd.dentry->d_inode))
+	if(__mnt_is_readonly(nd.mnt) || IS_RDONLY(nd.dentry->d_inode))
 		res = -EROFS;
 
 out_path_release:
diff -puN include/linux/mount.h~C-D8-actually-add-flags include/linux/mount.h
--- lxc/include/linux/mount.h~C-D8-actually-add-flags	2006-06-16 15:58:12.000000000 -0700
+++ lxc-dave/include/linux/mount.h	2006-06-16 15:58:12.000000000 -0700
@@ -87,7 +87,6 @@ static inline void __mnt_make_writable(s
 	WARN_ON(atomic_read(&mnt->mnt_writers));
 	atomic_inc(&mnt->mnt_writers);
 }
-
 static inline int __mnt_is_readonly(struct vfsmount *mnt)
 {
 	return (atomic_read(&mnt->mnt_writers) == 0);
_
