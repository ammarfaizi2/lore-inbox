Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWHAXx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWHAXx0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWHAXxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:53:23 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:23248 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750790AbWHAXxB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:53:01 -0400
Subject: [PATCH 25/28] elevate mnt writers for vfs_unlink() callers
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:59 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235259.01AA957F@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c   |    4 ++++
 lxc-dave/ipc/mqueue.c |    5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff -puN fs/namei.c~C-elevate-writers-vfs_unlink fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_unlink	2006-08-01 16:35:31.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-08-01 16:35:32.000000000 -0700
@@ -2171,7 +2171,11 @@ static long do_unlinkat(int dfd, const c
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
--- lxc/ipc/mqueue.c~C-elevate-writers-vfs_unlink	2006-08-01 16:35:28.000000000 -0700
+++ lxc-dave/ipc/mqueue.c	2006-08-01 16:35:32.000000000 -0700
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
