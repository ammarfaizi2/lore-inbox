Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422655AbWF0WTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422655AbWF0WTw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWF0WOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:14:46 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:49631 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030437AbWF0WOo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:14:44 -0400
Subject: [PATCH 02/20] r/o bind mount prepwork: move open_namei()'s vfs_create()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:37 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221437.9D01FB69@localhost.localdomain>
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

diff -puN fs/namei.c~C-prepwork-cleanup-open_namei fs/namei.c
--- lxc/fs/namei.c~C-prepwork-cleanup-open_namei	2006-06-27 10:40:24.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-27 10:40:24.000000000 -0700
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
