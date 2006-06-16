Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbWFPXSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWFPXSn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWFPXSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:18:41 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:58789 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751572AbWFPXMY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:12:24 -0400
Subject: [RFC][PATCH 08/20] sys_linkat(): elevate write count around vfs_link()
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 16 Jun 2006 16:12:19 -0700
References: <20060616231213.D4C5D6AF@localhost.localdomain>
In-Reply-To: <20060616231213.D4C5D6AF@localhost.localdomain>
Message-Id: <20060616231219.28C4D005@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN fs/namei.c~C-elevate-writers-vfs_link-part1 fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_link-part1	2006-06-16 15:58:04.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-16 15:58:04.000000000 -0700
@@ -2289,7 +2289,12 @@ asmlinkage long sys_linkat(int olddfd, c
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto out_unlock;
+	error = mnt_want_write(nd.mnt);
+	if (error)
+		goto out_dput;
 	error = vfs_link(old_nd.dentry, nd.dentry->d_inode, new_dentry);
+	mnt_drop_write(nd.mnt);
+out_dput:
 	dput(new_dentry);
 out_unlock:
 	mutex_unlock(&nd.dentry->d_inode->i_mutex);
_
