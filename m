Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWGLSRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWGLSRq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWGLSRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:17:42 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:53920 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932384AbWGLSRc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:32 -0400
Subject: [RFC][PATCH 24/27] do_rmdir(): elevate write count
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:27 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181727.37FD4043@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Elevate the write count during the vfs_rmdir() call.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN fs/namei.c~C-rmdir1 fs/namei.c
--- lxc/fs/namei.c~C-rmdir1	2006-07-12 11:09:40.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-07-12 11:09:42.000000000 -0700
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
