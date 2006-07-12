Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWGLSSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWGLSSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWGLSRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:17:49 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:9608 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932379AbWGLSR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:29 -0400
Subject: [RFC][PATCH 20/27] elevate write count for do_utimes()
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:24 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181724.7399B947@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/open.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff -puN fs/open.c~C-elevate-writers-opens-part2-do_utimes fs/open.c
--- lxc/fs/open.c~C-elevate-writers-opens-part2-do_utimes	2006-07-12 11:09:35.000000000 -0700
+++ lxc-dave/fs/open.c	2006-07-12 11:09:37.000000000 -0700
@@ -441,16 +441,19 @@ long do_utimes(int dfd, char __user *fil
 		goto out;
 	inode = nd.dentry->d_inode;
 
+	error = mnt_want_write(nd.mnt);
+	if (error)
+		goto dput_and_out;
 	error = -EROFS;
 	if (IS_RDONLY(inode))
-		goto dput_and_out;
+		goto mnt_drop_write_and_out;
 
 	/* Don't worry, the checks are done in inode_change_ok() */
 	newattrs.ia_valid = ATTR_CTIME | ATTR_MTIME | ATTR_ATIME;
 	if (times) {
 		error = -EPERM;
                 if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
-                        goto dput_and_out;
+			goto mnt_drop_write_and_out;
 
 		newattrs.ia_atime.tv_sec = times[0].tv_sec;
 		newattrs.ia_atime.tv_nsec = times[0].tv_usec * 1000;
@@ -460,15 +463,17 @@ long do_utimes(int dfd, char __user *fil
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
