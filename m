Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWFPXRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWFPXRw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbWFPXM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:12:29 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:47568 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751558AbWFPXMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:12:23 -0400
Subject: [RFC][PATCH 06/20] sys_symlinkat() elevate write count around vfs_symlink()
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 16 Jun 2006 16:12:18 -0700
References: <20060616231213.D4C5D6AF@localhost.localdomain>
In-Reply-To: <20060616231213.D4C5D6AF@localhost.localdomain>
Message-Id: <20060616231218.7A8B72FC@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN fs/namei.c~C-elevate-writers-vfs_symlink-part3 fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_symlink-part3	2006-06-16 15:58:02.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-16 15:58:02.000000000 -0700
@@ -2191,7 +2191,12 @@ asmlinkage long sys_symlinkat(const char
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
