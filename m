Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293203AbSHWUg3>; Fri, 23 Aug 2002 16:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293680AbSHWUg3>; Fri, 23 Aug 2002 16:36:29 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:50834 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S293203AbSHWUgY>; Fri, 23 Aug 2002 16:36:24 -0400
Date: Fri, 23 Aug 2002 13:44:03 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: marcelo@conectiva.com.br
cc: hch@infradead.org, linux-kernel@vger.kernel.org,
       Hanna Linder <hannal@us.ibm.com>
Subject: [PATCH] path_lookup for 2.4.20-pre4
Message-ID: <43070000.1030135443@w-hlinder>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch cleans up vfs path lookup code by combining
path_init and path_walk into one function. This patch has 
not changed since Alan Cox included it in 2.4.19-pre5-ac2. 
I have ported it to 2.4.20-pre4.

Hanna

----------
diff -Nru -Xdontdiff linux-2.4.20-pre4/fs/exec.c linux-path_lookup/fs/exec.c
--- linux-2.4.20-pre4/fs/exec.c	Fri Aug 23 13:30:18 2002
+++ linux-path_lookup/fs/exec.c	Fri Aug 23 13:27:33 2002
@@ -364,8 +364,7 @@
 	struct file *file;
 	int err = 0;
 
-	if (path_init(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		err = path_walk(name, &nd);
+	err = path_lookup(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	file = ERR_PTR(err);
 	if (!err) {
 		inode = nd.dentry->d_inode;
diff -Nru -Xdontdiff linux-2.4.20-pre4/fs/namei.c linux-path_lookup/fs/namei.c
--- linux-2.4.20-pre4/fs/namei.c	Fri Aug  2 17:39:45 2002
+++ linux-path_lookup/fs/namei.c	Fri Aug 23 13:27:33 2002
@@ -739,6 +739,16 @@
 }
 
 /* SMP-safe */
+int path_lookup(const char *path, unsigned flags, struct nameidata *nd)
+{
+	int error = 0;
+	if (path_init(path, flags, nd))
+		error = path_walk(path, nd);
+	return error;
+}
+
+
+/* SMP-safe */
 int path_init(const char *name, unsigned int flags, struct nameidata *nd)
 {
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
@@ -844,8 +854,7 @@
 	err = PTR_ERR(tmp);
 	if (!IS_ERR(tmp)) {
 		err = 0;
-		if (path_init(tmp, flags, nd))
-			err = path_walk(tmp, nd);
+		err = path_lookup(tmp, flags, nd);
 		putname(tmp);
 	}
 	return err;
@@ -1001,8 +1010,7 @@
 	 * The simplest case - just a plain lookup.
 	 */
 	if (!(flag & O_CREAT)) {
-		if (path_init(pathname, lookup_flags(flag), nd))
-			error = path_walk(pathname, nd);
+		error = path_lookup(pathname, lookup_flags(flag), nd);
 		if (error)
 			return error;
 		dentry = nd->dentry;
@@ -1012,8 +1020,7 @@
 	/*
 	 * Create - we need to know the parent.
 	 */
-	if (path_init(pathname, LOOKUP_PARENT, nd))
-		error = path_walk(pathname, nd);
+	error = path_lookup(pathname, LOOKUP_PARENT, nd);
 	if (error)
 		return error;
 
@@ -1265,8 +1272,7 @@
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-	if (path_init(tmp, LOOKUP_PARENT, &nd))
-		error = path_walk(tmp, &nd);
+	error = path_lookup(tmp, LOOKUP_PARENT, &nd);
 	if (error)
 		goto out;
 	dentry = lookup_create(&nd, 0);
@@ -1334,8 +1340,7 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		if (path_init(tmp, LOOKUP_PARENT, &nd))
-			error = path_walk(tmp, &nd);
+		error = path_lookup(tmp, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		dentry = lookup_create(&nd, 1);
@@ -1431,8 +1436,7 @@
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	if (path_init(name, LOOKUP_PARENT, &nd))
-		error = path_walk(name, &nd);
+	error = path_lookup(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
 
@@ -1500,8 +1504,7 @@
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	if (path_init(name, LOOKUP_PARENT, &nd))
-		error = path_walk(name, &nd);
+	error = path_lookup(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
 	error = -EISDIR;
@@ -1572,8 +1575,7 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		if (path_init(to, LOOKUP_PARENT, &nd))
-			error = path_walk(to, &nd);
+		error = path_lookup(to, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		dentry = lookup_create(&nd, 0);
@@ -1643,25 +1645,18 @@
 asmlinkage long sys_link(const char * oldname, const char * newname)
 {
 	int error;
-	char * from;
 	char * to;
 
-	from = getname(oldname);
-	if(IS_ERR(from))
-		return PTR_ERR(from);
 	to = getname(newname);
 	error = PTR_ERR(to);
 	if (!IS_ERR(to)) {
 		struct dentry *new_dentry;
 		struct nameidata nd, old_nd;
 
-		error = 0;
-		if (path_init(from, LOOKUP_POSITIVE, &old_nd))
-			error = path_walk(from, &old_nd);
+		error = __user_walk(oldname, LOOKUP_POSITIVE, &old_nd);
 		if (error)
 			goto exit;
-		if (path_init(to, LOOKUP_PARENT, &nd))
-			error = path_walk(to, &nd);
+		error = path_lookup(to, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		error = -EXDEV;
@@ -1681,8 +1676,6 @@
 exit:
 		putname(to);
 	}
-	putname(from);
-
 	return error;
 }
 
@@ -1859,14 +1852,11 @@
 	struct dentry * old_dentry, *new_dentry;
 	struct nameidata oldnd, newnd;
 
-	if (path_init(oldname, LOOKUP_PARENT, &oldnd))
-		error = path_walk(oldname, &oldnd);
-
+	error = path_lookup(oldname, LOOKUP_PARENT, &oldnd);
 	if (error)
 		goto exit;
 
-	if (path_init(newname, LOOKUP_PARENT, &newnd))
-		error = path_walk(newname, &newnd);
+	error = path_lookup(newname, LOOKUP_PARENT, &newnd);
 	if (error)
 		goto exit1;
 
diff -Nru -Xdontdiff linux-2.4.20-pre4/fs/namespace.c linux-path_lookup/fs/namespace.c
--- linux-2.4.20-pre4/fs/namespace.c	Fri Aug 23 13:30:19 2002
+++ linux-path_lookup/fs/namespace.c	Fri Aug 23 13:27:33 2002
@@ -361,17 +361,9 @@
 asmlinkage long sys_umount(char * name, int flags)
 {
 	struct nameidata nd;
-	char *kname;
 	int retval;
 
-	kname = getname(name);
-	retval = PTR_ERR(kname);
-	if (IS_ERR(kname))
-		goto out;
-	retval = 0;
-	if (path_init(kname, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &nd))
-		retval = path_walk(kname, &nd);
-	putname(kname);
+	retval = __user_walk(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &nd);
 	if (retval)
 		goto out;
 	retval = -EINVAL;
@@ -498,8 +490,7 @@
 		return err;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	if (path_init(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd))
-		err = path_walk(old_name, &old_nd);
+	err = path_lookup(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
@@ -565,8 +556,7 @@
 		return -EPERM;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	if (path_init(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd))
-		err = path_walk(old_name, &old_nd);
+	err = path_lookup(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
@@ -732,8 +722,7 @@
 	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);
 
 	/* ... and get the mountpoint */
-	if (path_init(dir_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		retval = path_walk(dir_name, &nd);
+	retval = path_lookup(dir_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	if (retval)
 		return retval;
 
@@ -912,7 +901,6 @@
 {
 	struct vfsmount *tmp;
 	struct nameidata new_nd, old_nd, parent_nd, root_parent, user_nd;
-	char *name;
 	int error;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -920,28 +908,14 @@
 
 	lock_kernel();
 
-	name = getname(new_root);
-	error = PTR_ERR(name);
-	if (IS_ERR(name))
-		goto out0;
-	error = 0;
-	if (path_init(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd))
-		error = path_walk(name, &new_nd);
-	putname(name);
+	error = __user_walk(new_root, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd);
 	if (error)
 		goto out0;
 	error = -EINVAL;
 	if (!check_mnt(new_nd.mnt))
 		goto out1;
 
-	name = getname(put_old);
-	error = PTR_ERR(name);
-	if (IS_ERR(name))
-		goto out1;
-	error = 0;
-	if (path_init(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd))
-		error = path_walk(name, &old_nd);
-	putname(name);
+	error = __user_walk(put_old, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd);
 	if (error)
 		goto out1;
 
diff -Nru -Xdontdiff linux-2.4.20-pre4/fs/open.c linux-path_lookup/fs/open.c
--- linux-2.4.20-pre4/fs/open.c	Fri Aug  2 17:39:45 2002
+++ linux-path_lookup/fs/open.c	Fri Aug 23 13:27:33 2002
@@ -385,17 +385,8 @@
 {
 	int error;
 	struct nameidata nd;
-	char *name;
 
-	name = getname(filename);
-	error = PTR_ERR(name);
-	if (IS_ERR(name))
-		goto out;
-
-	error = 0;
-	if (path_init(name,LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY,&nd))
-		error = path_walk(name, &nd);
-	putname(name);
+	error = __user_walk(filename,LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY,&nd);
 	if (error)
 		goto out;
 
@@ -445,17 +436,9 @@
 {
 	int error;
 	struct nameidata nd;
-	char *name;
-
-	name = getname(filename);
-	error = PTR_ERR(name);
-	if (IS_ERR(name))
-		goto out;
 
-	path_init(name, LOOKUP_POSITIVE | LOOKUP_FOLLOW |
+	error = __user_walk(filename, LOOKUP_POSITIVE | LOOKUP_FOLLOW |
 		      LOOKUP_DIRECTORY | LOOKUP_NOALT, &nd);
-	error = path_walk(name, &nd);	
-	putname(name);
 	if (error)
 		goto out;
 
diff -Nru -Xdontdiff linux-2.4.20-pre4/fs/super.c linux-path_lookup/fs/super.c
--- linux-2.4.20-pre4/fs/super.c	Fri Aug  2 17:39:45 2002
+++ linux-path_lookup/fs/super.c	Fri Aug 23 13:27:33 2002
@@ -659,8 +659,7 @@
 	/* What device it is? */
 	if (!dev_name || !*dev_name)
 		return ERR_PTR(-EINVAL);
-	if (path_init(dev_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		error = path_walk(dev_name, &nd);
+	error = path_lookup(dev_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	if (error)
 		return ERR_PTR(error);
 	inode = nd.dentry->d_inode;
diff -Nru -Xdontdiff linux-2.4.20-pre4/include/linux/fs.h linux-path_lookup/include/linux/fs.h
--- linux-2.4.20-pre4/include/linux/fs.h	Fri Aug 23 13:30:25 2002
+++ linux-path_lookup/include/linux/fs.h	Fri Aug 23 13:27:33 2002
@@ -1329,6 +1329,7 @@
 extern int FASTCALL(__user_walk(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_init(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_walk(const char *, struct nameidata *));
+extern int FASTCALL(path_lookup(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
 extern void path_release(struct nameidata *);
 extern int follow_down(struct vfsmount **, struct dentry **);

