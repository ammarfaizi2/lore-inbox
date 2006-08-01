Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbWHAX4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWHAX4u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWHAXx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:53:59 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:3025 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750812AbWHAXxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:53:49 -0400
Subject: [PATCH 26/28] do_rmdir(): elevate write count
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:59 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235259.425D1041@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Elevate the write count during the vfs_rmdir() call.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN fs/namei.c~C-rmdir1 fs/namei.c
--- lxc/fs/namei.c~C-rmdir1	2006-08-01 16:35:32.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-08-01 16:35:32.000000000 -0700
@@ -2091,7 +2091,12 @@ static long do_rmdir(int dfd, const char
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit2;
+	error = mnt_want_write(nd.mnt);
+	if (error)
+		goto exit3;
 	error = vfs_rmdir(nd.dentry->d_inode, dentry);
+	mnt_drop_write(nd.mnt);
+exit3:
 	dput(dentry);
 exit2:
 	mutex_unlock(&nd.dentry->d_inode->i_mutex);
_
