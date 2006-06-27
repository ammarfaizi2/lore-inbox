Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422649AbWF0WSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422649AbWF0WSJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422647AbWF0WPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:15:20 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:14241 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030471AbWF0WPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:15:00 -0400
Subject: [PATCH 18/20] do_rmdir(): elevate write count
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:55 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221455.482BD7C1@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Elevate the write count during the vfs_rmdir() call.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN fs/namei.c~C-rmdir1 fs/namei.c
--- lxc/fs/namei.c~C-rmdir1	2006-06-27 10:40:35.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-27 10:40:35.000000000 -0700
@@ -2078,7 +2078,12 @@ static long do_rmdir(int dfd, const char
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
