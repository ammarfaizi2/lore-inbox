Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277083AbRJDCSH>; Wed, 3 Oct 2001 22:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277084AbRJDCRt>; Wed, 3 Oct 2001 22:17:49 -0400
Received: from gateway2.ensim.com ([65.164.64.250]:17680 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S277083AbRJDCRh>; Wed, 3 Oct 2001 22:17:37 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Alexander Viro <viro@math.psu.edu>, torvalds@transmeta.com,
        alan@redhat.com
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Cleanup LOOKUP_PARENT handling in fs/namei.c
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_4353093320"
Date: Wed, 03 Oct 2001 19:17:20 -0700
Message-Id: <E15oy4e-0006T2-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_4353093320
Content-Type: text/plain; charset=us-ascii


The attached patch (against 2.4.10) adds a user_path_walk_parent() macro
in fs.h, and uses it to clean up some repetitive code in fs/namei.c.
Basically, variations on the sequence:

tmp = getname(path)
if(!IS_ERR(tmp)) {
	if(!path_init(tmp, LOOKUP_PARENT, &nd))
		error = path_walk(tmp, &nd);
	if(!error) {
		error = do_stuff_with_parentdir();
		path_release(&nd);
	}
	putname(tmp);
}

are replaced with:

error = user_path_walk_parent(path, &nd);
if(!error) {
	error = do_stuff_with_parentdir();
	path_release(&nd);
}

Paul


--==_Exmh_4353093320
Content-Type: text/plain ; name="patch"; charset=us-ascii
Content-Description: patch
Content-Disposition: attachment; filename="patch"

--- linux.orig/include/linux/fs.h	Sun Sep 23 10:31:02 2001
+++ linux/include/linux/fs.h	Wed Oct  3 09:37:19 2001
@@ -1297,6 +1297,7 @@
 extern struct dentry * lookup_hash(struct qstr *, struct dentry *);
 #define user_path_walk(name,nd)	 __user_walk(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, nd)
 #define user_path_walk_link(name,nd) __user_walk(name, LOOKUP_POSITIVE, nd)
+#define user_path_walk_parent(name, nd) __user_walk(name, LOOKUP_PARENT, nd)
 
 extern void iput(struct inode *);
 extern void force_delete(struct inode *);
--- linux.orig/fs/namei.c	Tue Sep 18 11:01:47 2001
+++ linux/fs/namei.c	Wed Oct  3 14:11:18 2001
@@ -1216,18 +1216,13 @@
 asmlinkage long sys_mknod(const char * filename, int mode, dev_t dev)
 {
 	int error = 0;
-	char * tmp;
 	struct dentry * dentry;
 	struct nameidata nd;
 
 	if (S_ISDIR(mode))
 		return -EPERM;
-	tmp = getname(filename);
-	if (IS_ERR(tmp))
-		return PTR_ERR(tmp);
 
-	if (path_init(tmp, LOOKUP_PARENT, &nd))
-		error = path_walk(tmp, &nd);
+	error = user_path_walk_parent(filename, &nd);
 	if (error)
 		goto out;
 	dentry = lookup_create(&nd, 0);
@@ -1253,7 +1248,6 @@
 	up(&nd.dentry->d_inode->i_sem);
 	path_release(&nd);
 out:
-	putname(tmp);
 
 	return error;
 }
@@ -1287,30 +1281,21 @@
 asmlinkage long sys_mkdir(const char * pathname, int mode)
 {
 	int error = 0;
-	char * tmp;
-
-	tmp = getname(pathname);
-	error = PTR_ERR(tmp);
-	if (!IS_ERR(tmp)) {
-		struct dentry *dentry;
-		struct nameidata nd;
-
-		if (path_init(tmp, LOOKUP_PARENT, &nd))
-			error = path_walk(tmp, &nd);
-		if (error)
-			goto out;
-		dentry = lookup_create(&nd, 1);
-		error = PTR_ERR(dentry);
-		if (!IS_ERR(dentry)) {
-			error = vfs_mkdir(nd.dentry->d_inode, dentry,
-					  mode & ~current->fs->umask);
-			dput(dentry);
-		}
-		up(&nd.dentry->d_inode->i_sem);
-		path_release(&nd);
-out:
-		putname(tmp);
+	struct dentry *dentry;
+	struct nameidata nd;
+	error = user_path_walk_parent(pathname, &nd);
+	if (error)
+		goto out;
+	dentry = lookup_create(&nd, 1);
+	error = PTR_ERR(dentry);
+	if (!IS_ERR(dentry)) {
+		error = vfs_mkdir(nd.dentry->d_inode, dentry,
+				  mode & ~current->fs->umask);
+		dput(dentry);
 	}
+	up(&nd.dentry->d_inode->i_sem);
+	path_release(&nd);
+out:
 
 	return error;
 }
@@ -1382,29 +1367,23 @@
 asmlinkage long sys_rmdir(const char * pathname)
 {
 	int error = 0;
-	char * name;
 	struct dentry *dentry;
 	struct nameidata nd;
 
-	name = getname(pathname);
-	if(IS_ERR(name))
-		return PTR_ERR(name);
-
-	if (path_init(name, LOOKUP_PARENT, &nd))
-		error = path_walk(name, &nd);
+	error = user_path_walk_parent(pathname, &nd);
 	if (error)
 		goto exit;
 
 	switch(nd.last_type) {
 		case LAST_DOTDOT:
 			error = -ENOTEMPTY;
-			goto exit1;
+			goto exit_release;
 		case LAST_DOT:
 			error = -EINVAL;
-			goto exit1;
+			goto exit_release;
 		case LAST_ROOT:
 			error = -EBUSY;
-			goto exit1;
+			goto exit_release;
 	}
 	down(&nd.dentry->d_inode->i_sem);
 	dentry = lookup_hash(&nd.last, nd.dentry);
@@ -1414,10 +1393,9 @@
 		dput(dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
-exit1:
+exit_release:
 	path_release(&nd);
 exit:
-	putname(name);
 	return error;
 }
 
@@ -1451,21 +1429,15 @@
 asmlinkage long sys_unlink(const char * pathname)
 {
 	int error = 0;
-	char * name;
 	struct dentry *dentry;
 	struct nameidata nd;
 
-	name = getname(pathname);
-	if(IS_ERR(name))
-		return PTR_ERR(name);
-
-	if (path_init(name, LOOKUP_PARENT, &nd))
-		error = path_walk(name, &nd);
+	error = user_path_walk_parent(pathname, &nd);
 	if (error)
 		goto exit;
 	error = -EISDIR;
 	if (nd.last_type != LAST_NORM)
-		goto exit1;
+		goto exit_path_release;
 	down(&nd.dentry->d_inode->i_sem);
 	dentry = lookup_hash(&nd.last, nd.dentry);
 	error = PTR_ERR(dentry);
@@ -1474,21 +1446,20 @@
 		if (nd.last.name[nd.last.len])
 			goto slashes;
 		error = vfs_unlink(nd.dentry->d_inode, dentry);
-	exit2:
+	exit_dput:
 		dput(dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
-exit1:
+exit_path_release:
 	path_release(&nd);
 exit:
-	putname(name);
 
 	return error;
 
 slashes:
 	error = !dentry->d_inode ? -ENOENT :
 		S_ISDIR(dentry->d_inode->i_mode) ? -EISDIR : -ENOTDIR;
-	goto exit2;
+	goto exit_dput;
 }
 
 int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
@@ -1518,35 +1489,34 @@
 
 asmlinkage long sys_symlink(const char * oldname, const char * newname)
 {
-	int error = 0;
+	int error;
 	char * from;
-	char * to;
+	struct dentry *dentry;
+	struct nameidata nd;
 
 	from = getname(oldname);
-	if(IS_ERR(from))
-		return PTR_ERR(from);
-	to = getname(newname);
-	error = PTR_ERR(to);
-	if (!IS_ERR(to)) {
-		struct dentry *dentry;
-		struct nameidata nd;
-
-		if (path_init(to, LOOKUP_PARENT, &nd))
-			error = path_walk(to, &nd);
-		if (error)
-			goto out;
-		dentry = lookup_create(&nd, 0);
-		error = PTR_ERR(dentry);
-		if (!IS_ERR(dentry)) {
-			error = vfs_symlink(nd.dentry->d_inode, dentry, from);
-			dput(dentry);
-		}
-		up(&nd.dentry->d_inode->i_sem);
-		path_release(&nd);
-out:
-		putname(to);
+	if(IS_ERR(from)) {
+		error = PTR_ERR(from);
+		goto out;
 	}
+	
+	error = user_path_walk_parent(newname, &nd);
+	if (error)
+		goto out_putname;
+
+	dentry = lookup_create(&nd, 0);
+	error = PTR_ERR(dentry);
+	if (!IS_ERR(dentry)) {
+		error = vfs_symlink(nd.dentry->d_inode, dentry, from);
+		dput(dentry);
+	}
+	up(&nd.dentry->d_inode->i_sem);
+	path_release(&nd);
+
+ out_putname:
 	putname(from);
+
+ out:
 	return error;
 }
 
@@ -1602,46 +1572,34 @@
 asmlinkage long sys_link(const char * oldname, const char * newname)
 {
 	int error;
-	char * from;
-	char * to;
+	struct dentry *new_dentry;
+	struct nameidata nd, old_nd;
 
-	from = getname(oldname);
-	if(IS_ERR(from))
-		return PTR_ERR(from);
-	to = getname(newname);
-	error = PTR_ERR(to);
-	if (!IS_ERR(to)) {
-		struct dentry *new_dentry;
-		struct nameidata nd, old_nd;
-
-		error = 0;
-		if (path_init(from, LOOKUP_POSITIVE, &old_nd))
-			error = path_walk(from, &old_nd);
-		if (error)
-			goto exit;
-		if (path_init(to, LOOKUP_PARENT, &nd))
-			error = path_walk(to, &nd);
-		if (error)
-			goto out;
-		error = -EXDEV;
-		if (old_nd.mnt != nd.mnt)
-			goto out_release;
-		new_dentry = lookup_create(&nd, 0);
-		error = PTR_ERR(new_dentry);
-		if (!IS_ERR(new_dentry)) {
-			error = vfs_link(old_nd.dentry, nd.dentry->d_inode, new_dentry);
-			dput(new_dentry);
-		}
-		up(&nd.dentry->d_inode->i_sem);
-out_release:
-		path_release(&nd);
-out:
-		path_release(&old_nd);
-exit:
-		putname(to);
+	error = user_path_walk_link(oldname, &old_nd);
+	if (error)
+		goto out;
+	error = user_path_walk_parent(newname, &nd);
+	if (error)
+		goto out_release_old;
+	error = -EXDEV;
+	if (old_nd.mnt != nd.mnt)
+		goto out_release_both;
+
+	new_dentry = lookup_create(&nd, 0);
+	error = PTR_ERR(new_dentry);
+	if (!IS_ERR(new_dentry)) {
+		error = vfs_link(old_nd.dentry, nd.dentry->d_inode, new_dentry);
+		dput(new_dentry);
 	}
-	putname(from);
+	up(&nd.dentry->d_inode->i_sem);
+
+out_release_both:
+	path_release(&nd);
+
+out_release_old:
+	path_release(&old_nd);
 
+out:
 	return error;
 }
 

--==_Exmh_4353093320--


