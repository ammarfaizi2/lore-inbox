Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310806AbSCHKst>; Fri, 8 Mar 2002 05:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310807AbSCHKsk>; Fri, 8 Mar 2002 05:48:40 -0500
Received: from gateway2.ensim.com ([65.164.64.250]:38156 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S310806AbSCHKse>; Fri, 8 Mar 2002 05:48:34 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] More user-space path handling cleanups 
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org
In-Reply-To: Your message of "Fri, 08 Mar 2002 04:25:36 EST."
             <Pine.GSO.4.21.0203080424040.28257-100000@weyl.math.psu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Mar 2002 02:48:24 -0800
Message-Id: <E16jHvE-0005lk-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Broken.  __user_walk() frees the temporary name it had created, leaving
>nd->last.name pointing nowhere (BTW, that's how I fucked up in the first
>version of patch that went into -pre3).
>

Oops. I guess I was wondering why you'd missed some of the getname()/
path_lookup() instances. How about this one instead? It adds a function
getname_walk() that returns the temporary buffer if the lookup is
successful, or else frees the buffer and returns the error. Caller is
responsible for freeing the buffer if it is returned. (Could maybe use a
better name than getname_walk().)

namei.c |   66 +++++++++++++++++++++++++---------------------------------------
1 files changed, 26 insertions(+), 40 deletions(-)


--- linux-2.5.6-pre3/fs/namei.c	Thu Mar  7 17:12:11 2002
+++ linux-2.5.6-pre3.new/fs/namei.c	Fri Mar  8 02:29:47 2002
@@ -817,16 +817,27 @@
  * that namei follows links, while lnamei does not.
  * SMP-safe
  */
-int __user_walk(const char *name, unsigned flags, struct nameidata *nd)
+static inline char *getname_walk(const char *name, unsigned flags, struct nameidata *nd)
 {
 	char *tmp = getname(name);
-	int err = PTR_ERR(tmp);
 
 	if (!IS_ERR(tmp)) {
-		err = path_lookup(tmp, flags, nd);
-		putname(tmp);
+		int err = path_lookup(tmp, flags, nd);
+		if(err) {
+			putname(tmp);
+			tmp = ERR_PTR(err);
+		}
 	}
-	return err;
+	return tmp;
+}
+
+int __user_walk(const char *name, unsigned flags, struct nameidata *nd)
+{
+ 	char *tmp = getname_walk(name, flags, nd);
+	if(IS_ERR(tmp)) 
+		return PTR_ERR(tmp);
+	putname(tmp);
+	return 0;
 }
 
 /*
@@ -1265,13 +1276,10 @@
 
 	if (S_ISDIR(mode))
 		return -EPERM;
-	tmp = getname(filename);
+	tmp = getname_walk(filename, LOOKUP_PARENT, &nd);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-	error = path_lookup(tmp, LOOKUP_PARENT, &nd);
-	if (error)
-		goto out;
 	dentry = lookup_create(&nd, 0);
 	error = PTR_ERR(dentry);
 
@@ -1294,7 +1302,6 @@
 	}
 	up(&nd.dentry->d_inode->i_sem);
 	path_release(&nd);
-out:
 	putname(tmp);
 
 	return error;
@@ -1322,16 +1329,13 @@
 {
 	int error = 0;
 	char * tmp;
+	struct nameidata nd;
 
-	tmp = getname(pathname);
+	tmp = getname_walk(pathname, LOOKUP_PARENT, &nd);
 	error = PTR_ERR(tmp);
 	if (!IS_ERR(tmp)) {
 		struct dentry *dentry;
-		struct nameidata nd;
 
-		error = path_lookup(tmp, LOOKUP_PARENT, &nd);
-		if (error)
-			goto out;
 		dentry = lookup_create(&nd, 1);
 		error = PTR_ERR(dentry);
 		if (!IS_ERR(dentry)) {
@@ -1341,7 +1345,6 @@
 		}
 		up(&nd.dentry->d_inode->i_sem);
 		path_release(&nd);
-out:
 		putname(tmp);
 	}
 
@@ -1416,14 +1419,10 @@
 	struct dentry *dentry;
 	struct nameidata nd;
 
-	name = getname(pathname);
+	name = getname_walk(pathname, LOOKUP_PARENT, &nd);
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	error = path_lookup(name, LOOKUP_PARENT, &nd);
-	if (error)
-		goto exit;
-
 	switch(nd.last_type) {
 		case LAST_DOTDOT:
 			error = -ENOTEMPTY;
@@ -1445,7 +1444,6 @@
 	up(&nd.dentry->d_inode->i_sem);
 exit1:
 	path_release(&nd);
-exit:
 	putname(name);
 	return error;
 }
@@ -1487,13 +1485,10 @@
 	struct dentry *dentry;
 	struct nameidata nd;
 
-	name = getname(pathname);
+	name = getname_walk(pathname, LOOKUP_PARENT, &nd);
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	error = path_lookup(name, LOOKUP_PARENT, &nd);
-	if (error)
-		goto exit;
 	error = -EISDIR;
 	if (nd.last_type != LAST_NORM)
 		goto exit1;
@@ -1511,7 +1506,6 @@
 	up(&nd.dentry->d_inode->i_sem);
 exit1:
 	path_release(&nd);
-exit:
 	putname(name);
 
 	return error;
@@ -1544,19 +1538,16 @@
 	int error = 0;
 	char * from;
 	char * to;
+	struct nameidata nd;
 
 	from = getname(oldname);
 	if(IS_ERR(from))
 		return PTR_ERR(from);
-	to = getname(newname);
+	to = getname_walk(newname, LOOKUP_PARENT, &nd);
 	error = PTR_ERR(to);
 	if (!IS_ERR(to)) {
 		struct dentry *dentry;
-		struct nameidata nd;
 
-		error = path_lookup(to, LOOKUP_PARENT, &nd);
-		if (error)
-			goto out;
 		dentry = lookup_create(&nd, 0);
 		error = PTR_ERR(dentry);
 		if (!IS_ERR(dentry)) {
@@ -1565,7 +1556,6 @@
 		}
 		up(&nd.dentry->d_inode->i_sem);
 		path_release(&nd);
-out:
 		putname(to);
 	}
 	putname(from);
@@ -1622,19 +1612,16 @@
 	int error;
 	char * to;
 
-	to = getname(newname);
+	to = getname_walk(newname, LOOKUP_PARENT, &nd);
 	if (IS_ERR(to))
 		return PTR_ERR(to);
 
 	error = __user_walk(oldname, 0, &old_nd);
 	if (error)
 		goto exit;
-	error = path_lookup(to, LOOKUP_PARENT, &nd);
-	if (error)
-		goto out;
 	error = -EXDEV;
 	if (old_nd.mnt != nd.mnt)
-		goto out_release;
+		goto out;
 	new_dentry = lookup_create(&nd, 0);
 	error = PTR_ERR(new_dentry);
 	if (!IS_ERR(new_dentry)) {
@@ -1642,11 +1629,10 @@
 		dput(new_dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
-out_release:
-	path_release(&nd);
 out:
 	path_release(&old_nd);
 exit:
+	path_release(&nd);
 	putname(to);
 
 	return error;

