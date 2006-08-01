Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWHBACk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWHBACk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 20:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWHBACj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 20:02:39 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:18641 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750766AbWHAXwv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:52:51 -0400
Subject: [PATCH 11/28] elevate writer count for chown and friends
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:48 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235248.0893CC0F@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


chown/chmod,etc... don't call permission in the same way
that the normal "open for write" calls do.  They still
write to the filesystem, so bump the write count during
these operations.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/open.c |   38 +++++++++++++++++++++++++++++++++-----
 1 files changed, 33 insertions(+), 5 deletions(-)

diff -puN fs/open.c~C-elevate-writers-chown-and-friends fs/open.c
--- lxc/fs/open.c~C-elevate-writers-chown-and-friends	2006-08-01 16:35:13.000000000 -0700
+++ lxc-dave/fs/open.c	2006-08-01 16:35:22.000000000 -0700
@@ -644,9 +644,12 @@ asmlinkage long sys_fchmod(unsigned int 
 	err = -EROFS;
 	if (IS_RDONLY(inode))
 		goto out_putf;
+	err = mnt_want_write(file->f_vfsmnt);
+	if (err)
+		goto out_putf;
 	err = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-		goto out_putf;
+		goto out_drop_write;
 	mutex_lock(&inode->i_mutex);
 	if (mode == (mode_t) -1)
 		mode = inode->i_mode;
@@ -655,6 +658,8 @@ asmlinkage long sys_fchmod(unsigned int 
 	err = notify_change(dentry, &newattrs);
 	mutex_unlock(&inode->i_mutex);
 
+out_drop_write:
+	mnt_drop_write(file->f_vfsmnt);
 out_putf:
 	fput(file);
 out:
@@ -674,13 +679,16 @@ asmlinkage long sys_fchmodat(int dfd, co
 		goto out;
 	inode = nd.dentry->d_inode;
 
+	error = mnt_want_write(nd.mnt);
+	if (error)
+		goto dput_and_out;
 	error = -EROFS;
 	if (IS_RDONLY(inode))
-		goto dput_and_out;
+		goto out_drop_write;
 
 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
-		goto dput_and_out;
+		goto out_drop_write;
 
 	mutex_lock(&inode->i_mutex);
 	if (mode == (mode_t) -1)
@@ -690,6 +698,8 @@ asmlinkage long sys_fchmodat(int dfd, co
 	error = notify_change(nd.dentry, &newattrs);
 	mutex_unlock(&inode->i_mutex);
 
+out_drop_write:
+	mnt_drop_write(nd.mnt);
 dput_and_out:
 	path_release(&nd);
 out:
@@ -715,7 +725,7 @@ static int chown_common(struct dentry * 
 	error = -EROFS;
 	if (IS_RDONLY(inode))
 		goto out;
-	error = -EPERM;
+ 	error = -EPERM;
 	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
 		goto out;
 	newattrs.ia_valid =  ATTR_CTIME;
@@ -744,7 +754,12 @@ asmlinkage long sys_chown(const char __u
 	error = user_path_walk(filename, &nd);
 	if (error)
 		goto out;
+	error = mnt_want_write(nd.mnt);
+	if (error)
+		goto out_release;
 	error = chown_common(nd.dentry, user, group);
+	mnt_drop_write(nd.mnt);
+out_release:
 	path_release(&nd);
 out:
 	return error;
@@ -764,7 +779,12 @@ asmlinkage long sys_fchownat(int dfd, co
 	error = __user_walk_fd(dfd, filename, follow, &nd);
 	if (error)
 		goto out;
+	error = mnt_want_write(nd.mnt);
+	if (error)
+		goto out_release;
 	error = chown_common(nd.dentry, user, group);
+	mnt_drop_write(nd.mnt);
+out_release:
 	path_release(&nd);
 out:
 	return error;
@@ -778,7 +798,11 @@ asmlinkage long sys_lchown(const char __
 	error = user_path_walk_link(filename, &nd);
 	if (error)
 		goto out;
+	error = mnt_want_write(nd.mnt);
+	if (error)
+		goto out_release;
 	error = chown_common(nd.dentry, user, group);
+out_release:
 	path_release(&nd);
 out:
 	return error;
@@ -794,10 +818,14 @@ asmlinkage long sys_fchown(unsigned int 
 	file = fget(fd);
 	if (!file)
 		goto out;
-
+	error = mnt_want_write(file->f_vfsmnt);
+	if (error)
+		goto out_fput;
 	dentry = file->f_dentry;
 	audit_inode(NULL, dentry->d_inode);
 	error = chown_common(dentry, user, group);
+	mnt_drop_write(file->f_vfsmnt);
+out_fput:
 	fput(file);
 out:
 	return error;
_
