Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWHBABQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWHBABQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 20:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWHAX7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:59:53 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:26312 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750777AbWHAXwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:52:55 -0400
Subject: [PATCH 16/28] sys_linkat(): elevate write count around vfs_link()
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:52 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235252.777964C5@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN fs/namei.c~C-elevate-writers-vfs_link-part1 fs/namei.c
--- lxc/fs/namei.c~C-elevate-writers-vfs_link-part1	2006-08-01 16:35:24.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-08-01 16:35:25.000000000 -0700
@@ -2326,7 +2326,12 @@ asmlinkage long sys_linkat(int olddfd, c
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
