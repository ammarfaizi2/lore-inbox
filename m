Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422673AbWF0WTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422673AbWF0WTx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422668AbWF0WTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:19:51 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:38583 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030448AbWF0WOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:14:53 -0400
Subject: [PATCH 06/20] sys_symlinkat() elevate write count around vfs_symlink()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:40 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221440.8FE87E49@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN fs/namei.c~C-elevate-writers-vfs_symlink-part3 fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_symlink-part3	2006-06-27 10:40:27.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-27 10:40:27.000000000 -0700
@@ -2213,7 +2213,12 @@ asmlinkage long sys_symlinkat(const char
 	if (IS_ERR(dentry))
 		goto out_unlock;
 
+	error = mnt_want_write(nd.mnt);
+	if (error)
+		goto out_dput;
 	error = vfs_symlink(nd.dentry->d_inode, dentry, from, S_IALLUGO);
+	mnt_drop_write(nd.mnt);
+out_dput:
 	dput(dentry);
 out_unlock:
 	mutex_unlock(&nd.dentry->d_inode->i_mutex);
_
