Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbWHAX6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbWHAX6J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWHAXx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:53:28 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:14284 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750786AbWHAXw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:52:59 -0400
Subject: [PATCH 22/28] elevate write count for do_utimes()
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:56 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235256.056B5D4D@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/open.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff -puN fs/open.c~C-elevate-writers-opens-part2-do_utimes fs/open.c
--- lxc/fs/open.c~C-elevate-writers-opens-part2-do_utimes	2006-08-01 16:35:29.000000000 -0700
+++ lxc-dave/fs/open.c	2006-08-01 16:35:29.000000000 -0700
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
