Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWHAX6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWHAX6i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWHAXxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:53:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:18633 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750789AbWHAXxE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:53:04 -0400
Subject: [PATCH 28/28] honor r/w changes at do_remount() time
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:53:01 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235301.EBB58619@localhost.localdomain>
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

 lxc-dave/fs/namespace.c |   24 ++++++++++++++++++++++--
 lxc-dave/fs/open.c      |    2 +-
 2 files changed, 23 insertions(+), 3 deletions(-)

diff -puN fs/namespace.c~C-D8-actually-add-flags fs/namespace.c
--- lxc/fs/namespace.c~C-D8-actually-add-flags	2006-08-01 16:35:26.000000000 -0700
+++ lxc-dave/fs/namespace.c	2006-08-01 16:35:34.000000000 -0700
@@ -391,7 +391,7 @@ static int show_vfsmnt(struct seq_file *
 	seq_path(m, mnt, mnt->mnt_root, " \t\n\\");
 	seq_putc(m, ' ');
 	mangle(m, mnt->mnt_sb->s_type->name);
-	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? " ro" : " rw");
+	seq_puts(m, __mnt_is_readonly(mnt) ? " ro" : " rw");
 	for (fs_infop = fs_info; fs_infop->flag; fs_infop++) {
 		if (mnt->mnt_sb->s_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
@@ -1014,6 +1014,23 @@ out:
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
@@ -1035,7 +1052,10 @@ static int do_remount(struct nameidata *
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
--- lxc/fs/open.c~C-D8-actually-add-flags	2006-08-01 16:35:30.000000000 -0700
+++ lxc-dave/fs/open.c	2006-08-01 16:35:34.000000000 -0700
@@ -546,7 +546,7 @@ asmlinkage long sys_faccessat(int dfd, c
 	   special_file(nd.dentry->d_inode->i_mode))
 		goto out_path_release;
 
-	if(IS_RDONLY(nd.dentry->d_inode))
+	if(__mnt_is_readonly(nd.mnt) || IS_RDONLY(nd.dentry->d_inode))
 		res = -EROFS;
 
 out_path_release:
_
