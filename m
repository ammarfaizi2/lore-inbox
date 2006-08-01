Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWHBABO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWHBABO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 20:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWHAX74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:59:56 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:37846 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750771AbWHAXwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:52:53 -0400
Subject: [PATCH 14/28] sys_symlinkat() elevate write count around vfs_symlink()
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:50 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235250.6233B571@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN fs/namei.c~C-elevate-writers-vfs_symlink-part3 fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_symlink-part3	2006-08-01 16:35:23.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-08-01 16:35:24.000000000 -0700
@@ -2226,7 +2226,12 @@ asmlinkage long sys_symlinkat(const char
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
