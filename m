Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422660AbWF0WR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422660AbWF0WR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422650AbWF0WP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:15:28 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:7073 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030464AbWF0WO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:14:58 -0400
Subject: [PATCH 15/20] elevate write count for do_sys_utime() and touch_atime()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:53 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221453.B3E06F88@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/inode.c |    9 +++++++--
 lxc-dave/fs/open.c  |   16 +++++++++++-----
 2 files changed, 18 insertions(+), 7 deletions(-)

diff -puN fs/inode.c~C-elevate-writers-opens-part2-do_sys_utime fs/inode.c
--- lxc/fs/inode.c~C-elevate-writers-opens-part2-do_sys_utime	2006-06-27 10:40:33.000000000 -0700
+++ lxc-dave/fs/inode.c	2006-06-27 10:40:33.000000000 -0700
@@ -1187,10 +1187,13 @@ void touch_atime(struct vfsmount *mnt, s
 	if (IS_RDONLY(inode))
 		return;
 
+	if (!mnt_want_write(mnt))
+		return;
+
 	if ((inode->i_flags & S_NOATIME) ||
 	    (inode->i_sb->s_flags & MS_NOATIME) ||
 	    ((inode->i_sb->s_flags & MS_NODIRATIME) && S_ISDIR(inode->i_mode)))
-		return;
+		goto out;
 
 	/*
 	 * We may have a NULL vfsmount when coming from NFSD
@@ -1198,13 +1201,15 @@ void touch_atime(struct vfsmount *mnt, s
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
--- lxc/fs/open.c~C-elevate-writers-opens-part2-do_sys_utime	2006-06-27 10:40:33.000000000 -0700
+++ lxc-dave/fs/open.c	2006-06-27 10:40:33.000000000 -0700
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
