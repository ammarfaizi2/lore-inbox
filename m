Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWGLSRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWGLSRi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWGLSRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:17:38 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:25246 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932388AbWGLSRe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:34 -0400
Subject: [RFC][PATCH 27/27] honor r/w changes at do_remount() time
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:29 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181729.9A552320@localhost.localdomain>
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

 lxc-dave/fs/namespace.c |   28 ++++++++++++++++++++++++----
 lxc-dave/fs/open.c      |    2 +-
 2 files changed, 25 insertions(+), 5 deletions(-)

diff -puN fs/namespace.c~C-D8-actually-add-flags fs/namespace.c
--- lxc/fs/namespace.c~C-D8-actually-add-flags	2006-07-12 11:09:44.000000000 -0700
+++ lxc-dave/fs/namespace.c	2006-07-12 11:09:45.000000000 -0700
@@ -381,6 +381,7 @@ static int show_vfsmnt(struct seq_file *
 		char *set_str;
 		char *unset_str;
 	} fs_info[] = {
+		{ MS_RDONLY, MNT_READONLY, "ro", "rw" },
 		{ MS_SYNCHRONOUS, 0, ",sync", NULL },
 		{ MS_DIRSYNC, 0, ",dirsync", NULL },
 		{ MS_MANDLOCK, 0, ",mand", NULL },
@@ -396,17 +397,16 @@ static int show_vfsmnt(struct seq_file *
 	seq_path(m, mnt, mnt->mnt_root, " \t\n\\");
 	seq_putc(m, ' ');
 	mangle(m, mnt->mnt_sb->s_type->name);
-	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? " ro" : " rw");
+	seq_putc(m, ' ');
 	for (i = 0; i < ARRAY_SIZE(fs_info); i++) {
 		struct proc_fs_info *fs_infop = &fs_info[i];
 		char *str = NULL;
 		if ((mnt->mnt_sb->s_flags & fs_infop->s_flag) ||
-		    mnt_flag_set(mnt, fs_infop->mnt_flag))
+		    (mnt->mnt_flags & fs_infop->mnt_flag))
 			str = fs_infop->set_str;
 		else
 			str = fs_infop->unset_str;
 
-		if (mnt->mnt_flags & fs_infop->flag)
 		if (str)
 			seq_puts(m, str);
 	}
@@ -1024,6 +1024,23 @@ out:
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
+		__mnt_unmake_readonly(mnt);
+	return error;
+}
+
 /*
  * change filesystem flags. dir should be a physical root of filesystem.
  * If you've mounted a non-root directory somewhere and want to do remount
@@ -1045,7 +1062,10 @@ static int do_remount(struct nameidata *
 		return -EINVAL;
 
 	down_write(&sb->s_umount);
-	err = do_remount_sb(sb, flags, data, 0);
+	if (flags & MS_BIND)
+		err = change_mount_flags(nd->mnt, flags);
+	else
+		err = do_remount_sb(sb, flags, data, 0);
 	if (!(sb->s_flags & MS_RDONLY))
 		mnt_flags |= MNT_SB_WRITABLE;
 	if (!err)
diff -puN fs/open.c~C-D8-actually-add-flags fs/open.c
--- lxc/fs/open.c~C-D8-actually-add-flags	2006-07-12 11:09:38.000000000 -0700
+++ lxc-dave/fs/open.c	2006-07-12 11:09:45.000000000 -0700
@@ -546,7 +546,7 @@ asmlinkage long sys_faccessat(int dfd, c
 	   special_file(nd.dentry->d_inode->i_mode))
 		goto out_path_release;
 
-	if(IS_RDONLY(nd.dentry->d_inode))
+	if(__mnt_is_readonly(nd.mnt) || IS_RDONLY(nd.dentry->d_inode))
 		res = -EROFS;
 
 out_path_release:
_
