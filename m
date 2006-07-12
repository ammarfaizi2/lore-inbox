Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWGLSSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWGLSSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWGLSRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:17:48 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:60901 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932380AbWGLSRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:30 -0400
Subject: [RFC][PATCH 21/27] elevate write count for do_sys_utime() and touch_atime()
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:24 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181724.4FB246B0@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/inode.c |    9 +++++++--
 lxc-dave/fs/open.c  |   16 +++++++++++-----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff -puN fs/inode.c~C-elevate-writers-opens-part2-do_sys_utime fs/inode.c
--- lxc/fs/inode.c~C-elevate-writers-opens-part2-do_sys_utime	2006-07-12 11:09:23.000000000 -0700
+++ lxc-dave/fs/inode.c	2006-07-12 11:09:38.000000000 -0700
@@ -1191,10 +1191,13 @@ void touch_atime(struct vfsmount *mnt, s
 	if (IS_RDONLY(inode))
 		return;
 
+	if (mnt_want_write(mnt))
+		return;
+
 	if ((inode->i_flags & S_NOATIME) ||
 	    (inode->i_sb->s_flags & MS_NOATIME) ||
 	    ((inode->i_sb->s_flags & MS_NODIRATIME) && S_ISDIR(inode->i_mode)))
-		return;
+		goto out;
 
 	/*
 	 * We may have a NULL vfsmount when coming from NFSD
@@ -1202,13 +1205,15 @@ void touch_atime(struct vfsmount *mnt, s
 	if (mnt &&
 	    ((mnt->mnt_flags & MNT_NOATIME) ||
 	     ((mnt->mnt_flags & MNT_NODIRATIME) && S_ISDIR(inode->i_mode))))
-		return;
+		goto out;
 
 	now = current_fs_time(inode->i_sb);
 	if (!timespec_equal(&inode->i_atime, &now)) {
 		inode->i_atime = now;
 		mark_inode_dirty_sync(inode);
 	}
+out:
+	mnt_drop_write(mnt);
 }
 
 EXPORT_SYMBOL(touch_atime);
diff -puN fs/open.c~C-elevate-writers-opens-part2-do_sys_utime fs/open.c
--- lxc/fs/open.c~C-elevate-writers-opens-part2-do_sys_utime	2006-07-12 11:09:37.000000000 -0700
+++ lxc-dave/fs/open.c	2006-07-12 11:09:38.000000000 -0700
@@ -384,16 +384,20 @@ asmlinkage long sys_utime(char __user * 
 		goto out;
 	inode = nd.dentry->d_inode;
 
+	error = mnt_want_write(nd.mnt);
+	if (error)
+		goto dput_and_out;
+
 	error = -EROFS;
 	if (IS_RDONLY(inode))
-		goto dput_and_out;
+		goto mnt_drop_write_and_out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
 	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
 	if (times) {
 		error = -EPERM;
 		if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
-			goto dput_and_out;
+			goto mnt_drop_write_and_out;
 
 		error = get_user(newattrs.ia_atime.tv_sec, &times->actime);
 		newattrs.ia_atime.tv_nsec = 0;
@@ -401,21 +405,23 @@ asmlinkage long sys_utime(char __user * 
 			error = get_user(newattrs.ia_mtime.tv_sec, &times->modtime);
 		newattrs.ia_mtime.tv_nsec = 0;
 		if (error)
-			goto dput_and_out;
+			goto mnt_drop_write_and_out;
 
 		newattrs.ia_valid |= ATTR_ATIME_SET | ATTR_MTIME_SET;
 	} else {
                 error = -EACCES;
                 if (IS_IMMUTABLE(inode))
-                        goto dput_and_out;
+			goto mnt_drop_write_and_out;
 
 		if (current->fsuid != inode->i_uid &&
 		    (error = vfs_permission(&nd, MAY_WRITE)) != 0)
-			goto dput_and_out;
+			goto mnt_drop_write_and_out;
 	}
 	mutex_lock(&inode->i_mutex);
 	error = notify_change(nd.dentry, &newattrs);
 	mutex_unlock(&inode->i_mutex);
+mnt_drop_write_and_out:
+	mnt_drop_write(nd.mnt);
 dput_and_out:
 	path_release(&nd);
 out:
_
