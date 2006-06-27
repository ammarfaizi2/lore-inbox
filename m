Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030474AbWF0WPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030474AbWF0WPM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030475AbWF0WPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:15:11 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:36526 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030474AbWF0WPD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:15:03 -0400
Subject: [PATCH 17/20] elevate mnt writers for vfs_unlink() callers
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:54 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221454.AC12A311@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c   |    4 ++++
 lxc-dave/ipc/mqueue.c |    5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff -puN fs/namei.c~C-elevate-writers-vfs_unlink fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_unlink	2006-06-27 10:40:34.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-27 10:40:34.000000000 -0700
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
--- lxc/ipc/mqueue.c~C-elevate-writers-vfs_unlink	2006-06-27 10:40:34.000000000 -0700
+++ lxc-dave/ipc/mqueue.c	2006-06-27 10:40:34.000000000 -0700
@@ -748,8 +748,11 @@ asmlinkage long sys_mq_unlink(const char
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
