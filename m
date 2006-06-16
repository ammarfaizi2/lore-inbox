Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932100AbWFPXQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWFPXQo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751554AbWFPXQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:16:40 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:2016 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932100AbWFPXMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:12:31 -0400
Subject: [RFC][PATCH 17/20] elevate mnt writers for vfs_unlink() callers
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 16 Jun 2006 16:12:26 -0700
References: <20060616231213.D4C5D6AF@localhost.localdomain>
In-Reply-To: <20060616231213.D4C5D6AF@localhost.localdomain>
Message-Id: <20060616231226.33108E61@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c   |    4 ++++
 lxc-dave/ipc/mqueue.c |    5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff -puN fs/namei.c~C-elevate-writers-vfs_unlink fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_unlink	2006-06-16 15:58:10.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-16 15:58:10.000000000 -0700
@@ -2136,7 +2136,11 @@ static long do_unlinkat(int dfd, const c
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
--- lxc/ipc/mqueue.c~C-elevate-writers-vfs_unlink	2006-06-16 15:58:10.000000000 -0700
+++ lxc-dave/ipc/mqueue.c	2006-06-16 15:58:10.000000000 -0700
@@ -741,8 +741,11 @@ asmlinkage long sys_mq_unlink(const char
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
