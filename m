Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWGLSRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWGLSRR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWGLSRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:17:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:57571 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932310AbWGLSRQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:16 -0400
Subject: [RFC][PATCH 02/27] r/o bind mount prepwork: move open_namei()'s vfs_create()
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:11 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181711.7CD44827@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The code around vfs_create() in open_namei() is getting a
bit too complex.  Right now, there is at least the reference
count on the dentry, and the i_mutex to worry about.  Soon,
we'll also have mnt_writecount.

So, break the vfs_create() call out of open_namei(), and
into a helper function.  This duplicates the call to
may_open(), but that isn't such a bad thing since the
arguments (acc_mode and flag) were being heavily massaged
anyway.

Later in the series, we'll add the mnt_writecount handling
around this new function call.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff -puN fs/namei.c~B-prepwork-cleanup-open_namei fs/namei.c
--- lxc/fs/namei.c~B-prepwork-cleanup-open_namei	2006-07-12 11:09:17.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-07-12 11:09:18.000000000 -0700
@@ -1580,6 +1580,24 @@ int may_open(struct nameidata *nd, int a
 	return 0;
 }
 
+static int open_namei_create(struct nameidata *nd, struct path *path,
+				int flag, int mode)
+{
+	int error;
+	struct dentry *dir = nd->dentry;
+
+	if (!IS_POSIXACL(dir->d_inode))
+		mode &= ~current->fs->umask;
+	error = vfs_create(dir->d_inode, path->dentry, mode, nd);
+	mutex_unlock(&dir->d_inode->i_mutex);
+	dput(nd->dentry);
+	nd->dentry = path->dentry;
+	if (error)
+		return error;
+	/* Don't check for write permission, don't truncate */
+	return may_open(nd, 0, flag & ~O_TRUNC);
+}
+
 /*
  *	open_namei()
  *
@@ -1661,18 +1679,10 @@ do_last:
 
 	/* Negative dentry, just create the file */
 	if (!path.dentry->d_inode) {
-		if (!IS_POSIXACL(dir->d_inode))
-			mode &= ~current->fs->umask;
-		error = vfs_create(dir->d_inode, path.dentry, mode, nd);
-		mutex_unlock(&dir->d_inode->i_mutex);
-		dput(nd->dentry);
-		nd->dentry = path.dentry;
+		error = open_namei_create(nd, &path, flag, mode);
 		if (error)
 			goto exit;
-		/* Don't check for write permission, don't truncate */
-		acc_mode = 0;
-		flag &= ~O_TRUNC;
-		goto ok;
+		return 0;
 	}
 
 	/*
_
