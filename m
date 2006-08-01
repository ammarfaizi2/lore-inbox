Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWHAXxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWHAXxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWHAXxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:53:17 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:22206 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750806AbWHAXxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:53:05 -0400
Subject: [PATCH 02/28] r/o bind mount prepwork: move open_namei()'s vfs_create()
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:41 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235241.D7516044@localhost.localdomain>
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
--- lxc/fs/namei.c~B-prepwork-cleanup-open_namei	2006-08-01 16:35:13.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-08-01 16:35:14.000000000 -0700
@@ -1587,6 +1587,24 @@ int may_open(struct nameidata *nd, int a
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
@@ -1668,18 +1686,10 @@ do_last:
 
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
