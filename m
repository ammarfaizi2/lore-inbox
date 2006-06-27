Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422656AbWF0WV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422656AbWF0WV1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422674AbWF0WT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:19:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:2218 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030445AbWF0WOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:14:52 -0400
Subject: [PATCH 08/20] sys_linkat(): elevate write count around vfs_link()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:47 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221447.159C953A@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN fs/namei.c~C-elevate-writers-vfs_link-part1 fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_link-part1	2006-06-27 10:40:28.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-27 10:40:28.000000000 -0700
@@ -2313,7 +2313,12 @@ asmlinkage long sys_linkat(int olddfd, c
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
