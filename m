Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWGLSYI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWGLSYI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWGLSRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:17:19 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:22980 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932317AbWGLSRQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:16 -0400
Subject: [RFC][PATCH 01/27] prepare for write access checks: collapse if()
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:10 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181710.8DD9E8B2@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We're shortly going to be adding a bunch more permission
checks in these functions.  That requires adding either a
bunch of new if() conditions, or some gotos.  This patch
collapses existing if()s and uses gotos instead to
prepare for the upcoming changes.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/namei.c |   93 +++++++++++++++++++++++++++-------------------------
 lxc-dave/fs/open.c  |   64 ++++++++++++++++++++---------------
 2 files changed, 87 insertions(+), 70 deletions(-)

diff -puN fs/namei.c~B-prepwork-collapse-ifs fs/namei.c
--- lxc/fs/namei.c~B-prepwork-collapse-ifs	2006-07-12 11:11:30.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-07-12 11:15:13.000000000 -0700
@@ -1911,30 +1911,32 @@ asmlinkage long sys_mkdirat(int dfd, con
 {
 	int error = 0;
 	char * tmp;
+	struct dentry *dentry;
+	struct nameidata nd;
 
 	tmp = getname(pathname);
 	error = PTR_ERR(tmp);
-	if (!IS_ERR(tmp)) {
-		struct dentry *dentry;
-		struct nameidata nd;
+	if (IS_ERR(tmp))
+		goto out_err;
 
-		error = do_path_lookup(dfd, tmp, LOOKUP_PARENT, &nd);
-		if (error)
-			goto out;
-		dentry = lookup_create(&nd, 1);
-		error = PTR_ERR(dentry);
-		if (!IS_ERR(dentry)) {
-			if (!IS_POSIXACL(nd.dentry->d_inode))
-				mode &= ~current->fs->umask;
-			error = vfs_mkdir(nd.dentry->d_inode, dentry, mode);
-			dput(dentry);
-		}
-		mutex_unlock(&nd.dentry->d_inode->i_mutex);
-		path_release(&nd);
-out:
-		putname(tmp);
-	}
+	error = do_path_lookup(dfd, tmp, LOOKUP_PARENT, &nd);
+	if (error)
+		goto out;
+	dentry = lookup_create(&nd, 1);
+	error = PTR_ERR(dentry);
+	if (IS_ERR(dentry))
+		goto out_unlock;
 
+	if (!IS_POSIXACL(nd.dentry->d_inode))
+		mode &= ~current->fs->umask;
+	error = vfs_mkdir(nd.dentry->d_inode, dentry, mode);
+	dput(dentry);
+out_unlock:
+	mutex_unlock(&nd.dentry->d_inode->i_mutex);
+	path_release(&nd);
+out:
+	putname(tmp);
+out_err:
 	return error;
 }
 
@@ -2033,10 +2035,11 @@ static long do_rmdir(int dfd, const char
 	mutex_lock_nested(&nd.dentry->d_inode->i_mutex, I_MUTEX_PARENT);
 	dentry = lookup_hash(&nd);
 	error = PTR_ERR(dentry);
-	if (!IS_ERR(dentry)) {
-		error = vfs_rmdir(nd.dentry->d_inode, dentry);
-		dput(dentry);
-	}
+	if (IS_ERR(dentry))
+		goto exit2;
+	error = vfs_rmdir(nd.dentry->d_inode, dentry);
+	dput(dentry);
+exit2:
 	mutex_unlock(&nd.dentry->d_inode->i_mutex);
 exit1:
 	path_release(&nd);
@@ -2176,30 +2179,33 @@ asmlinkage long sys_symlinkat(const char
 	int error = 0;
 	char * from;
 	char * to;
+	struct dentry *dentry;
+	struct nameidata nd;
 
 	from = getname(oldname);
 	if(IS_ERR(from))
 		return PTR_ERR(from);
 	to = getname(newname);
 	error = PTR_ERR(to);
-	if (!IS_ERR(to)) {
-		struct dentry *dentry;
-		struct nameidata nd;
+	if (IS_ERR(to))
+		goto out_putname;
 
-		error = do_path_lookup(newdfd, to, LOOKUP_PARENT, &nd);
-		if (error)
-			goto out;
-		dentry = lookup_create(&nd, 0);
-		error = PTR_ERR(dentry);
-		if (!IS_ERR(dentry)) {
-			error = vfs_symlink(nd.dentry->d_inode, dentry, from, S_IALLUGO);
-			dput(dentry);
-		}
-		mutex_unlock(&nd.dentry->d_inode->i_mutex);
-		path_release(&nd);
+	error = do_path_lookup(newdfd, to, LOOKUP_PARENT, &nd);
+	if (error)
+		goto out;
+	dentry = lookup_create(&nd, 0);
+	error = PTR_ERR(dentry);
+	if (IS_ERR(dentry))
+		goto out_unlock;
+
+	error = vfs_symlink(nd.dentry->d_inode, dentry, from, S_IALLUGO);
+	dput(dentry);
+out_unlock:
+	mutex_unlock(&nd.dentry->d_inode->i_mutex);
+	path_release(&nd);
 out:
-		putname(to);
-	}
+	putname(to);
+out_putname:
 	putname(from);
 	return error;
 }
@@ -2285,10 +2291,11 @@ asmlinkage long sys_linkat(int olddfd, c
 		goto out_release;
 	new_dentry = lookup_create(&nd, 0);
 	error = PTR_ERR(new_dentry);
-	if (!IS_ERR(new_dentry)) {
-		error = vfs_link(old_nd.dentry, nd.dentry->d_inode, new_dentry);
-		dput(new_dentry);
-	}
+	if (IS_ERR(new_dentry))
+		goto out_unlock;
+	error = vfs_link(old_nd.dentry, nd.dentry->d_inode, new_dentry);
+	dput(new_dentry);
+out_unlock:
 	mutex_unlock(&nd.dentry->d_inode->i_mutex);
 out_release:
 	path_release(&nd);
diff -puN fs/open.c~B-prepwork-collapse-ifs fs/open.c
--- lxc/fs/open.c~B-prepwork-collapse-ifs	2006-07-12 11:11:30.000000000 -0700
+++ lxc-dave/fs/open.c	2006-07-12 11:15:13.000000000 -0700
@@ -520,15 +520,21 @@ asmlinkage long sys_faccessat(int dfd, c
 		current->cap_effective = current->cap_permitted;
 
 	res = __user_walk_fd(dfd, filename, LOOKUP_FOLLOW|LOOKUP_ACCESS, &nd);
-	if (!res) {
-		res = vfs_permission(&nd, mode);
-		/* SuS v2 requires we report a read only fs too */
-		if(!res && (mode & S_IWOTH) && IS_RDONLY(nd.dentry->d_inode)
-		   && !special_file(nd.dentry->d_inode->i_mode))
-			res = -EROFS;
-		path_release(&nd);
-	}
+	if (res)
+		goto out;
+
+	res = vfs_permission(&nd, mode);
+	/* SuS v2 requires we report a read only fs too */
+	if(res || !(mode & S_IWOTH) ||
+	   special_file(nd.dentry->d_inode->i_mode))
+		goto out_path_release;
+
+	if(IS_RDONLY(nd.dentry->d_inode))
+		res = -EROFS;
 
+out_path_release:
+	path_release(&nd);
+out:
 	current->fsuid = old_fsuid;
 	current->fsgid = old_fsgid;
 	current->cap_effective = old_cap;
@@ -736,10 +742,11 @@ asmlinkage long sys_chown(const char __u
 	int error;
 
 	error = user_path_walk(filename, &nd);
-	if (!error) {
-		error = chown_common(nd.dentry, user, group);
-		path_release(&nd);
-	}
+	if (error)
+		goto out;
+	error = chown_common(nd.dentry, user, group);
+	path_release(&nd);
+out:
 	return error;
 }
 
@@ -755,10 +762,10 @@ asmlinkage long sys_fchownat(int dfd, co
 
 	follow = (flag & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
 	error = __user_walk_fd(dfd, filename, follow, &nd);
-	if (!error) {
-		error = chown_common(nd.dentry, user, group);
-		path_release(&nd);
-	}
+	if (error)
+		goto out;
+	error = chown_common(nd.dentry, user, group);
+	path_release(&nd);
 out:
 	return error;
 }
@@ -769,10 +776,11 @@ asmlinkage long sys_lchown(const char __
 	int error;
 
 	error = user_path_walk_link(filename, &nd);
-	if (!error) {
-		error = chown_common(nd.dentry, user, group);
-		path_release(&nd);
-	}
+	if (error)
+		goto out;
+	error = chown_common(nd.dentry, user, group);
+	path_release(&nd);
+out:
 	return error;
 }
 
@@ -781,15 +789,17 @@ asmlinkage long sys_fchown(unsigned int 
 {
 	struct file * file;
 	int error = -EBADF;
+	struct dentry * dentry;
 
 	file = fget(fd);
-	if (file) {
-		struct dentry * dentry;
-		dentry = file->f_dentry;
-		audit_inode(NULL, dentry->d_inode);
-		error = chown_common(dentry, user, group);
-		fput(file);
-	}
+	if (!file)
+		goto out;
+
+	dentry = file->f_dentry;
+	audit_inode(NULL, dentry->d_inode);
+	error = chown_common(dentry, user, group);
+	fput(file);
+out:
 	return error;
 }
 
_
