Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310756AbSCHJVc>; Fri, 8 Mar 2002 04:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310758AbSCHJVX>; Fri, 8 Mar 2002 04:21:23 -0500
Received: from gateway2.ensim.com ([65.164.64.250]:12050 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S310756AbSCHJVO>; Fri, 8 Mar 2002 04:21:14 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Alexander Viro <viro@math.psu.edu>
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: [PATCH] More user-space path handling cleanups
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Mar 2002 01:21:04 -0800
Message-Id: <E16jGYi-0005dq-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch (against 2.5.6-pre3) replaces a few instances of the
getname()/path_lookup() combination with __user_walk(), in the same vein
as some of the changes accompanying the path_lookup() patch that was
included in 2.5.6-pre3.

namei.c |   60 +++++++++++-------------------------------------------------
1 files changed, 11 insertions(+), 49 deletions(-)


diff -aur linux-2.5.6-pre3/fs/namei.c linux-2.5.6-pre3.new/fs/namei.c
--- linux-2.5.6-pre3/fs/namei.c	Thu Mar  7 17:12:11 2002
+++ linux-2.5.6-pre3.new/fs/namei.c	Thu Mar  7 17:24:51 2002
@@ -1259,17 +1259,12 @@
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
-
-	error = path_lookup(tmp, LOOKUP_PARENT, &nd);
+	error = __user_walk(filename, LOOKUP_PARENT, &nd);
 	if (error)
 		goto out;
 	dentry = lookup_create(&nd, 0);
@@ -1295,7 +1290,6 @@
 	up(&nd.dentry->d_inode->i_sem);
 	path_release(&nd);
 out:
-	putname(tmp);
 
 	return error;
 }
@@ -1321,17 +1315,11 @@
 asmlinkage long sys_mkdir(const char * pathname, int mode)
 {
 	int error = 0;
-	char * tmp;
-
-	tmp = getname(pathname);
-	error = PTR_ERR(tmp);
-	if (!IS_ERR(tmp)) {
+	struct nameidata nd;
+	error = __user_walk(pathname, LOOKUP_PARENT, &nd);
+	if (!error) {
 		struct dentry *dentry;
-		struct nameidata nd;
 
-		error = path_lookup(tmp, LOOKUP_PARENT, &nd);
-		if (error)
-			goto out;
 		dentry = lookup_create(&nd, 1);
 		error = PTR_ERR(dentry);
 		if (!IS_ERR(dentry)) {
@@ -1341,8 +1329,6 @@
 		}
 		up(&nd.dentry->d_inode->i_sem);
 		path_release(&nd);
-out:
-		putname(tmp);
 	}
 
 	return error;
@@ -1412,15 +1398,10 @@
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
-	error = path_lookup(name, LOOKUP_PARENT, &nd);
+	error = __user_walk(pathname, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
 
@@ -1446,7 +1427,6 @@
 exit1:
 	path_release(&nd);
 exit:
-	putname(name);
 	return error;
 }
 
@@ -1483,15 +1463,10 @@
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
-	error = path_lookup(name, LOOKUP_PARENT, &nd);
+	error = __user_walk(pathname, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
 	error = -EISDIR;
@@ -1512,7 +1487,6 @@
 exit1:
 	path_release(&nd);
 exit:
-	putname(name);
 
 	return error;
 
@@ -1543,20 +1517,16 @@
 {
 	int error = 0;
 	char * from;
-	char * to;
+	struct nameidata nd;
 
 	from = getname(oldname);
 	if(IS_ERR(from))
 		return PTR_ERR(from);
-	to = getname(newname);
-	error = PTR_ERR(to);
-	if (!IS_ERR(to)) {
+
+	error = __user_walk(newname, LOOKUP_PARENT, &nd);
+	if(!error) {
 		struct dentry *dentry;
-		struct nameidata nd;
 
-		error = path_lookup(to, LOOKUP_PARENT, &nd);
-		if (error)
-			goto out;
 		dentry = lookup_create(&nd, 0);
 		error = PTR_ERR(dentry);
 		if (!IS_ERR(dentry)) {
@@ -1565,8 +1535,6 @@
 		}
 		up(&nd.dentry->d_inode->i_sem);
 		path_release(&nd);
-out:
-		putname(to);
 	}
 	putname(from);
 	return error;
@@ -1620,16 +1588,11 @@
 	struct dentry *new_dentry;
 	struct nameidata nd, old_nd;
 	int error;
-	char * to;
-
-	to = getname(newname);
-	if (IS_ERR(to))
-		return PTR_ERR(to);
 
 	error = __user_walk(oldname, 0, &old_nd);
 	if (error)
 		goto exit;
-	error = path_lookup(to, LOOKUP_PARENT, &nd);
+	error = __user_walk(newname, LOOKUP_PARENT, &nd);
 	if (error)
 		goto out;
 	error = -EXDEV;
@@ -1647,7 +1610,6 @@
 out:
 	path_release(&old_nd);
 exit:
-	putname(to);
 
 	return error;
 }


