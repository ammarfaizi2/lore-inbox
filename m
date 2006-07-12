Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbWGLSW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWGLSW4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWGLSVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:21:37 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:15045 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932366AbWGLSRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:25 -0400
Subject: [RFC][PATCH 14/27] sys_linkat(): elevate write count around vfs_link()
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:19 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181719.2DB4F618@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN fs/namei.c~C-elevate-writers-vfs_link-part1 fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_link-part1	2006-07-12 11:09:29.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-07-12 11:09:31.000000000 -0700
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
