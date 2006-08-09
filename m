Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWHIQ6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWHIQ6i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 12:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWHIQ5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 12:57:36 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:54199 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750876AbWHIQ5f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 12:57:35 -0400
Subject: [PATCH 1/6] prepare for write access checks: collapse if()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 09 Aug 2006 09:57:30 -0700
References: <20060809165729.FE36B262@localhost.localdomain>
In-Reply-To: <20060809165729.FE36B262@localhost.localdomain>
Message-Id: <20060809165730.0F7D9814@localhost.localdomain>
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

diff -puN fs/namei.c~B1-prepwork-collapse-ifs fs/namei.c
--- lxc/fs/namei.c~B1-prepwork-collapse-ifs	2006-08-06 03:21:02.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-08-08 09:18:49.000000000 -0700
@@ -1926,30 +1926,32 @@ asmlinkage long sys_mkdirat(int dfd, con
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
 
@@ -2048,10 +2050,11 @@ static long do_rmdir(int dfd, const char
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
@@ -2191,30 +2194,33 @@ asmlinkage long sys_symlinkat(const char
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
@@ -2300,10 +2306,11 @@ asmlinkage long sys_linkat(int olddfd, c
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
diff -puN fs/open.c~B1-prepwork-collapse-ifs fs/open.c
--- lxc/fs/open.c~B1-prepwork-collapse-ifs	2006-08-06 03:21:03.000000000 -0700
+++ lxc-dave/fs/open.c	2006-08-08 09:18:49.000000000 -0700
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
@@ -737,10 +743,11 @@ asmlinkage long sys_chown(const char __u
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
 
@@ -756,10 +763,10 @@ asmlinkage long sys_fchownat(int dfd, co
 
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
@@ -770,10 +777,11 @@ asmlinkage long sys_lchown(const char __
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
 
@@ -782,15 +790,17 @@ asmlinkage long sys_fchown(unsigned int 
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
