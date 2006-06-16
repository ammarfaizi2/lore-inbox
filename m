Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWFPXMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWFPXMU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 19:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWFPXMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 19:12:20 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:5028 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751547AbWFPXMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 19:12:19 -0400
Subject: [RFC][PATCH 01/20] prepare for write access checks: collapse if()
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Fri, 16 Jun 2006 16:12:13 -0700
References: <20060616231213.D4C5D6AF@localhost.localdomain>
In-Reply-To: <20060616231213.D4C5D6AF@localhost.localdomain>
Message-Id: <20060616231213.6C11AC1F@localhost.localdomain>
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
 lxc-dave/fs/open.c  |   22 +++++++-----
 2 files changed, 64 insertions(+), 51 deletions(-)

diff -puN fs/namei.c~C-prepwork-collapse-ifs fs/namei.c
--- lxc/fs/namei.c~C-prepwork-collapse-ifs	2006-06-16 15:57:59.000000000 -0700
+++ lxc-dave/fs/namei.c	2006-06-16 15:57:59.000000000 -0700
@@ -1889,30 +1889,32 @@ asmlinkage long sys_mkdirat(int dfd, con
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
 
@@ -2011,10 +2013,11 @@ static long do_rmdir(int dfd, const char
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
@@ -2154,30 +2157,33 @@ asmlinkage long sys_symlinkat(const char
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
@@ -2261,10 +2267,11 @@ asmlinkage long sys_linkat(int olddfd, c
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
diff -puN fs/open.c~C-prepwork-collapse-ifs fs/open.c
--- lxc/fs/open.c~C-prepwork-collapse-ifs	2006-06-16 15:57:59.000000000 -0700
+++ lxc-dave/fs/open.c	2006-06-16 15:57:59.000000000 -0700
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
 
+	if(IS_RDONLY(nd.dentry->d_inode))
+		res = -EROFS;
+
+out_path_release:
+	path_release(&nd);
+out:
 	current->fsuid = old_fsuid;
 	current->fsgid = old_fsgid;
 	current->cap_effective = old_cap;
_
