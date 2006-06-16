Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWFPXSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWFPXSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWFPXSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:18:39 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:35236 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751583AbWFPXM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:12:29 -0400
Subject: [RFC][PATCH 14/20] elevate write count for do_utimes()
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 16 Jun 2006 16:12:24 -0700
References: <20060616231213.D4C5D6AF@localhost.localdomain>
In-Reply-To: <20060616231213.D4C5D6AF@localhost.localdomain>
Message-Id: <20060616231224.D9DF76C1@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/open.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff -puN fs/open.c~C-elevate-writers-opens-part2-do_utimes fs/open.c
--- lxc/fs/open.c~C-elevate-writers-opens-part2-do_utimes	2006-06-16 15:58:08.000000000 -0700
+++ lxc-dave/fs/open.c	2006-06-16 15:58:08.000000000 -0700
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
