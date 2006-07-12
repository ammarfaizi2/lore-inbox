Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932412AbWGLSRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932412AbWGLSRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWGLSRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:17:44 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:13470 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932383AbWGLSRb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:31 -0400
Subject: [RFC][PATCH 23/27] elevate mnt writers for vfs_unlink() callers
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:26 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181726.56D469E0@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c   |    4 ++++
 lxc-dave/ipc/mqueue.c |    5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff -puN fs/namei.c~C-elevate-writers-vfs_unlink fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_unlink	2006-07-12 11:09:39.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-07-12 11:09:40.000000000 -0700
@@ -2158,7 +2158,11 @@ static long do_unlinkat(int dfd, const c
 		inode = dentry->d_inode;
 		if (inode)
 			atomic_inc(&inode->i_count);
+		error = mnt_want_write(nd.mnt);
+		if (error)
+			goto exit2;
 		error = vfs_unlink(nd.dentry->d_inode, dentry);
+		mnt_drop_write(nd.mnt);
 	exit2:
 		dput(dentry);
 	}
diff -puN ipc/mqueue.c~C-elevate-writers-vfs_unlink ipc/mqueue.c
--- lxc/ipc/mqueue.c~C-elevate-writers-vfs_unlink	2006-07-12 11:09:34.000000000 -0700
+++ lxc-dave/ipc/mqueue.c	2006-07-12 11:09:40.000000000 -0700
@@ -747,8 +747,11 @@ asmlinkage long sys_mq_unlink(const char
 	inode = dentry->d_inode;
 	if (inode)
 		atomic_inc(&inode->i_count);
-
+	err = mnt_want_write(mqueue_mnt);
+	if (err)
+		goto out_err;
 	err = vfs_unlink(dentry->d_parent->d_inode, dentry);
+	mnt_drop_write(mqueue_mnt);
 out_err:
 	dput(dentry);
 
_
