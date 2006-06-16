Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbWFPXRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbWFPXRP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWFPXQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:16:37 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:57529 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932101AbWFPXMb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:12:31 -0400
Subject: [RFC][PATCH 18/20] do_rmdir(): elevate write count
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 16 Jun 2006 16:12:27 -0700
References: <20060616231213.D4C5D6AF@localhost.localdomain>
In-Reply-To: <20060616231213.D4C5D6AF@localhost.localdomain>
Message-Id: <20060616231227.E78A5649@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Elevate the write count during the vfs_rmdir() call.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN fs/namei.c~C-rmdir1 fs/namei.c
--- lxc/fs/namei.c~C-rmdir1	2006-06-16 15:58:10.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-16 15:58:10.000000000 -0700
@@ -2056,7 +2056,12 @@ static long do_rmdir(int dfd, const char
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
