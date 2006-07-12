Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbWGLSWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWGLSWz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWGLSVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:21:41 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:16572 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932362AbWGLSRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:24 -0400
Subject: [RFC][PATCH 12/27] sys_symlinkat() elevate write count around vfs_symlink()
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:18 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181718.5B0D2A0C@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN fs/namei.c~C-elevate-writers-vfs_symlink-part3 fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_symlink-part3	2006-07-12 11:09:27.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-07-12 11:09:29.000000000 -0700
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
