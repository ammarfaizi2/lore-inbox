Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312610AbSCZRxe>; Tue, 26 Mar 2002 12:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312605AbSCZRxZ>; Tue, 26 Mar 2002 12:53:25 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:56518 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S312604AbSCZRxR>; Tue, 26 Mar 2002 12:53:17 -0500
Date: Tue, 26 Mar 2002 09:54:07 -0800
From: Hanna Linder <hannal@us.ibm.com>
To: alan@lxorguk.ukuu.org.uk
cc: linux-kernel@vger.kernel.org, viro@math.psu.edu, hannal@us.ibm.com
Subject: [PATCH 2.4.19-pre3-ac6] path_lookup - simple precursor to fast_walk
Message-ID: <6920000.1017165247@w-hlinder.des>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a cleanup precursor to a fast_walk patch I wrote based on
suggestions from Al Viro to decrease cacheline bouncing of a global
reference counter during path lookup of dentries in the cache.
That patch has shown 50% reduction in BKL contention on an 8-way
SMP running dbench. Incidentally, it has also shown a 90% reduction in
dcache_lock contention on a 16-way NUMA-Q building the kernel.
Results and patch coming soon.

This patch included simply cleans up source code by changing the many calls
of the form: if(path_init) error = path_walk to one function path_lookup.
By wrapping path_init with path_lookup I will be able to control which
filesystems use the fast_walk mechanism.

Linus has already accepted this patch from Al Viro in 2.5.6, his comments:
<viro@math.psu.edu> (02/03/02 1.375.1.84)
	[PATCH] path_lookup()
	
		New helper:
	path_lookup(name, flags, nd)
	{
		int err = 0;
		if (path_init(name, flags, nd))
			err = path_walk(name, nd);
		return err;
	}
	
	Places doing that by hand converted to calling it.
	
	Actually, quite a few of them were doing equivalent of __user_walk()
	(getname() and if it was successful - call path_lookup() and putname()).
	Converted to calling __user_walk().


Please consider this patch for inclusion in your 2.4.19 tree.

Following is the linux-2.4.19-pre3-ac6 version. Also available at:
http://prdownloads.sf.net/lse/path_lookupA3-2.4.19-pre3-ac6.patch

Hanna Linder
hannal@us.ibm.com
IBM Linux Technology Center

--------
diff -Nru -X dontdiff linux-2.4.19-pre3-ac6/fs/exec.c linux-path_lookup/fs/exec.c
--- linux-2.4.19-pre3-ac6/fs/exec.c	Mon Mar 25 15:59:29 2002
+++ linux-path_lookup/fs/exec.c	Mon Mar 25 19:21:44 2002
@@ -351,8 +351,7 @@
 	struct file *file;
 	int err = 0;
 
-	if (path_init(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		err = path_walk(name, &nd);
+	err = path_lookup(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	file = ERR_PTR(err);
 	if (!err) {
 		inode = nd.dentry->d_inode;
diff -Nru -X dontdiff linux-2.4.19-pre3-ac6/fs/namei.c linux-path_lookup/fs/namei.c
--- linux-2.4.19-pre3-ac6/fs/namei.c	Mon Mar 25 15:57:36 2002
+++ linux-path_lookup/fs/namei.c	Mon Mar 25 19:21:44 2002
@@ -726,6 +726,16 @@
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
@@ -831,8 +841,7 @@
 	err = PTR_ERR(tmp);
 	if (!IS_ERR(tmp)) {
 		err = 0;
-		if (path_init(tmp, flags, nd))
-			err = path_walk(tmp, nd);
+		err = path_lookup(tmp, flags, nd);
 		putname(tmp);
 	}
 	return err;
@@ -986,8 +995,7 @@
 	 * The simplest case - just a plain lookup.
 	 */
 	if (!(flag & O_CREAT)) {
-		if (path_init(pathname, lookup_flags(flag), nd))
-			error = path_walk(pathname, nd);
+		error = path_lookup(pathname, lookup_flags(flag), nd);
 		if (error)
 			return error;
 		dentry = nd->dentry;
@@ -997,8 +1005,7 @@
 	/*
 	 * Create - we need to know the parent.
 	 */
-	if (path_init(pathname, LOOKUP_PARENT, nd))
-		error = path_walk(pathname, nd);
+	error = path_lookup(pathname, LOOKUP_PARENT, nd);
 	if (error)
 		return error;
 
@@ -1250,8 +1257,7 @@
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-	if (path_init(tmp, LOOKUP_PARENT, &nd))
-		error = path_walk(tmp, &nd);
+	error = path_lookup(tmp, LOOKUP_PARENT, &nd);
 	if (error)
 		goto out;
 	dentry = lookup_create(&nd, 0);
@@ -1319,8 +1325,7 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		if (path_init(tmp, LOOKUP_PARENT, &nd))
-			error = path_walk(tmp, &nd);
+		error = path_lookup(tmp, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		dentry = lookup_create(&nd, 1);
@@ -1414,8 +1419,7 @@
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	if (path_init(name, LOOKUP_PARENT, &nd))
-		error = path_walk(name, &nd);
+	error = path_lookup(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
 
@@ -1483,8 +1487,7 @@
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	if (path_init(name, LOOKUP_PARENT, &nd))
-		error = path_walk(name, &nd);
+	error = path_lookup(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
 	error = -EISDIR;
@@ -1555,8 +1558,7 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		if (path_init(to, LOOKUP_PARENT, &nd))
-			error = path_walk(to, &nd);
+		error = path_lookup(to, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		dentry = lookup_create(&nd, 0);
@@ -1626,25 +1628,18 @@
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
@@ -1664,8 +1659,6 @@
 exit:
 		putname(to);
 	}
-	putname(from);
-
 	return error;
 }
 
@@ -1844,14 +1837,11 @@
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
 
diff -Nru -X dontdiff linux-2.4.19-pre3-ac6/fs/namespace.c linux-path_lookup/fs/namespace.c
--- linux-2.4.19-pre3-ac6/fs/namespace.c	Mon Mar 25 15:59:31 2002
+++ linux-path_lookup/fs/namespace.c	Mon Mar 25 19:21:47 2002
@@ -364,17 +364,9 @@
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
@@ -501,8 +493,7 @@
 		return err;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	if (path_init(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd))
-		err = path_walk(old_name, &old_nd);
+	err = path_lookup(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
@@ -568,8 +559,7 @@
 		return -EPERM;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	if (path_init(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd))
-		err = path_walk(old_name, &old_nd);
+	err = path_lookup(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
@@ -726,8 +716,7 @@
 	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);
 
 	/* ... and get the mountpoint */
-	if (path_init(dir_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		retval = path_walk(dir_name, &nd);
+	retval = path_lookup(dir_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	if (retval)
 		return retval;
 
@@ -826,7 +815,6 @@
 {
 	struct vfsmount *tmp;
 	struct nameidata new_nd, old_nd, parent_nd, root_parent, user_nd;
-	char *name;
 	int error;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -834,28 +822,14 @@
 
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
 
diff -Nru -X dontdiff linux-2.4.19-pre3-ac6/fs/open.c linux-path_lookup/fs/open.c
--- linux-2.4.19-pre3-ac6/fs/open.c	Mon Mar 25 15:59:32 2002
+++ linux-path_lookup/fs/open.c	Mon Mar 25 19:21:44 2002
@@ -384,17 +384,8 @@
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
 
@@ -444,17 +435,9 @@
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
 
diff -Nru -X dontdiff linux-2.4.19-pre3-ac6/fs/super.c linux-path_lookup/fs/super.c
--- linux-2.4.19-pre3-ac6/fs/super.c	Mon Mar 25 15:59:33 2002
+++ linux-path_lookup/fs/super.c	Mon Mar 25 19:21:44 2002
@@ -575,8 +575,7 @@
 	/* What device it is? */
 	if (!dev_name || !*dev_name)
 		return ERR_PTR(-EINVAL);
-	if (path_init(dev_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		error = path_walk(dev_name, &nd);
+	error = path_lookup(dev_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	if (error)
 		return ERR_PTR(error);
 	inode = nd.dentry->d_inode;
diff -Nru -X dontdiff linux-2.4.19-pre3-ac6/include/linux/fs.h linux-path_lookup/include/linux/fs.h
--- linux-2.4.19-pre3-ac6/include/linux/fs.h	Mon Mar 25 15:59:37 2002
+++ linux-path_lookup/include/linux/fs.h	Mon Mar 25 19:21:48 2002
@@ -1348,6 +1348,7 @@
 extern int FASTCALL(__user_walk(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_init(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_walk(const char *, struct nameidata *));
+extern int FASTCALL(path_lookup(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
 extern void path_release(struct nameidata *);
 extern int follow_down(struct vfsmount **, struct dentry **);

