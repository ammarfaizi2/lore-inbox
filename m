Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292245AbSBOWhx>; Fri, 15 Feb 2002 17:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292237AbSBOWhC>; Fri, 15 Feb 2002 17:37:02 -0500
Received: from gateway2.ensim.com ([65.164.64.250]:44816 "EHLO
	nasdaq.ms.ensim.com") by vger.kernel.org with ESMTP
	id <S292244AbSBOWfB>; Fri, 15 Feb 2002 17:35:01 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0
From: Paul Menage <pmenage@ensim.com>
To: Alexander Viro <viro@math.psu.edu>, Hanna Linder <hannal@us.ibm.com>
cc: pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Combine path_init()/path_walk() into path_lookup()
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 15 Feb 2002 14:34:52 -0800
Message-Id: <E16bqwO-0004HH-00@pmenage-dt.ensim.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds an inline function, path_lookup(), which simply calls
path_init() and, if necessary, path_walk(). It also converts about 40
existing uses of path_init()/path_walk() to use path_lookup(). This
amounts to purely a source code change, since the inline function does
exactly what the original callers did anyway.

This is obviously similar to part of Hanna's patch reducing the amount
of reference counting performed during lookups. It extracts the
path_init()/path_walk() combination, which is orthogonal to (and much
less contentious than) the actual fast-path lookup itself. It also uses
the name path_lookup(), rather than Hanna's choice of path_init_walk().

It's made against 2.2.18-rc1, but mostly applies to 2.5.x (excluding 
some changes in namespace.c) with lots of offsets. Apart from the hunk 
adding the path_lookup() function, each hunk is independent of the 
others.

 fs/exec.c              |    3 +--
 fs/intermezzo/presto.c |    8 +-------
 fs/intermezzo/vfs.c    |   30 ++++++++++--------------------
 fs/namei.c             |   36 ++++++++++++------------------------
 fs/namespace.c         |   24 ++++++++----------------
 fs/nfsd/export.c       |    6 ++----
 fs/open.c              |    3 +--
 fs/super.c             |    3 +--
 include/linux/fs.h     |    8 ++++++++
 net/unix/af_unix.c     |    6 ++----
 10 files changed, 46 insertions(+), 81 deletions(-)

Paul


diff -Naur ../linux-2.4.18-rc1/fs/exec.c ./fs/exec.c
--- ../linux-2.4.18-rc1/fs/exec.c	Fri Dec 21 09:41:55 2001
+++ ./fs/exec.c	Thu Feb 14 18:54:14 2002
@@ -343,8 +343,7 @@
 	struct file *file;
 	int err = 0;
 
-	if (path_init(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		err = path_walk(name, &nd);
+	err = path_lookup(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	file = ERR_PTR(err);
 	if (!err) {
 		inode = nd.dentry->d_inode;
diff -Naur ../linux-2.4.18-rc1/fs/intermezzo/presto.c ./fs/intermezzo/presto.c
--- ../linux-2.4.18-rc1/fs/intermezzo/presto.c	Thu Feb 14 18:23:07 2002
+++ ./fs/intermezzo/presto.c	Fri Feb 15 11:41:03 2002
@@ -33,7 +33,6 @@
 
 int presto_walk(const char *name, struct nameidata *nd)
 {
-        int err;
         /* we do not follow symlinks to support symlink operations 
            correctly. The vfs should always hand us resolved dentries
            so we should not be required to use LOOKUP_FOLLOW. At the
@@ -41,13 +40,8 @@
            resolved pathname and not the symlink. SHP
            XXX: This code implies that direct symlinks do not work. SHP
         */
-        unsigned int flags = LOOKUP_POSITIVE;
-
         ENTRY;
-        err = 0;
-        if (path_init(name, flags, nd)) 
-                err = path_walk(name, nd);
-        return err;
+        return path_lookup(name, LOOKUP_POSITIVE, nd);
 }
 
 
diff -Naur ../linux-2.4.18-rc1/fs/intermezzo/vfs.c ./fs/intermezzo/vfs.c
--- ../linux-2.4.18-rc1/fs/intermezzo/vfs.c	Thu Feb 14 18:23:07 2002
+++ ./fs/intermezzo/vfs.c	Thu Feb 14 18:54:14 2002
@@ -548,8 +548,7 @@
 
         /* this looks up the parent */
 //        if (path_init(pathname, LOOKUP_FOLLOW | LOOKUP_POSITIVE, &nd))
-        if (path_init(pathname,  LOOKUP_PARENT, &nd))
-                error = path_walk(pathname, &nd);
+        error = path_lookup(pathname,  LOOKUP_PARENT, &nd);
         if (error) {
 		EXIT;
                 goto exit;
@@ -696,12 +695,10 @@
                 struct nameidata nd, old_nd;
 
                 error = 0;
-                if (path_init(from, LOOKUP_POSITIVE, &old_nd))
-                        error = path_walk(from, &old_nd);
+                error = path_lookup(from, LOOKUP_POSITIVE, &old_nd);
                 if (error)
                         goto exit;
-                if (path_init(to, LOOKUP_PARENT, &nd))
-                        error = path_walk(to, &nd);
+                error = path_lookup(to, LOOKUP_PARENT, &nd);
                 if (error)
                         goto out;
                 error = -EXDEV;
@@ -852,8 +849,7 @@
         if(IS_ERR(name))
                 return PTR_ERR(name);
 
-        if (path_init(name, LOOKUP_PARENT, &nd))
-                error = path_walk(name, &nd);
+        error = path_lookup(name, LOOKUP_PARENT, &nd);
         if (error)
                 goto exit;
         error = -EISDIR;
@@ -1023,8 +1019,7 @@
                 goto exit_from;
         }
 
-        if (path_init(to, LOOKUP_PARENT, &nd)) 
-                error = path_walk(to, &nd);
+        error = path_lookup(to, LOOKUP_PARENT, &nd);
         if (error) {
                 EXIT;
                 goto exit_to;
@@ -1183,8 +1178,7 @@
                 return error;
         }
 
-        if (path_init(pathname, LOOKUP_PARENT, &nd))
-                error = path_walk(pathname, &nd);
+        error = path_lookup(pathname, LOOKUP_PARENT, &nd);
         if (error)
                 goto out_name;
 
@@ -1323,8 +1317,7 @@
         if(IS_ERR(name))
                 return PTR_ERR(name);
 
-        if (path_init(name, LOOKUP_PARENT, &nd))
-                error = path_walk(name, &nd);
+        error = path_lookup(name, LOOKUP_PARENT, &nd);
         if (error)
                 goto exit;
 
@@ -1484,8 +1477,7 @@
         if (IS_ERR(tmp))
                 return PTR_ERR(tmp);
 
-        if (path_init(tmp, LOOKUP_PARENT, &nd))
-                error = path_walk(tmp, &nd);
+        error = path_lookup(tmp, LOOKUP_PARENT, &nd);
         if (error)
                 goto out;
         dentry = lookup_create(&nd, 0);
@@ -1765,14 +1757,12 @@
 
         ENTRY;
 
-        if (path_init(oldname, LOOKUP_PARENT, &oldnd))
-                error = path_walk(oldname, &oldnd);
+        error = path_lookup(oldname, LOOKUP_PARENT, &oldnd);
 
         if (error)
                 goto exit;
 
-        if (path_init(newname, LOOKUP_PARENT, &newnd))
-                error = path_walk(newname, &newnd);
+        error = path_lookup(newname, LOOKUP_PARENT, &newnd);
         if (error)
                 goto exit1;
 
diff -Naur ../linux-2.4.18-rc1/fs/namei.c ./fs/namei.c
--- ../linux-2.4.18-rc1/fs/namei.c	Thu Feb 14 18:23:07 2002
+++ ./fs/namei.c	Thu Feb 14 18:54:14 2002
@@ -829,8 +829,7 @@
 	err = PTR_ERR(tmp);
 	if (!IS_ERR(tmp)) {
 		err = 0;
-		if (path_init(tmp, flags, nd))
-			err = path_walk(tmp, nd);
+		err = path_lookup(tmp, flags, nd);
 		putname(tmp);
 	}
 	return err;
@@ -984,8 +983,7 @@
 	 * The simplest case - just a plain lookup.
 	 */
 	if (!(flag & O_CREAT)) {
-		if (path_init(pathname, lookup_flags(flag), nd))
-			error = path_walk(pathname, nd);
+		error = path_lookup(pathname, lookup_flags(flag), nd);
 		if (error)
 			return error;
 		dentry = nd->dentry;
@@ -995,8 +993,7 @@
 	/*
 	 * Create - we need to know the parent.
 	 */
-	if (path_init(pathname, LOOKUP_PARENT, nd))
-		error = path_walk(pathname, nd);
+	error = path_lookup(pathname, LOOKUP_PARENT, nd);
 	if (error)
 		return error;
 
@@ -1248,8 +1245,7 @@
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-	if (path_init(tmp, LOOKUP_PARENT, &nd))
-		error = path_walk(tmp, &nd);
+	error = path_lookup(tmp, LOOKUP_PARENT, &nd);
 	if (error)
 		goto out;
 	dentry = lookup_create(&nd, 0);
@@ -1317,8 +1313,7 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		if (path_init(tmp, LOOKUP_PARENT, &nd))
-			error = path_walk(tmp, &nd);
+		error = path_lookup(tmp, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		dentry = lookup_create(&nd, 1);
@@ -1412,8 +1407,7 @@
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	if (path_init(name, LOOKUP_PARENT, &nd))
-		error = path_walk(name, &nd);
+	error = path_lookup(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
 
@@ -1481,8 +1475,7 @@
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	if (path_init(name, LOOKUP_PARENT, &nd))
-		error = path_walk(name, &nd);
+	error = path_lookup(name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
 	error = -EISDIR;
@@ -1553,8 +1546,7 @@
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		if (path_init(to, LOOKUP_PARENT, &nd))
-			error = path_walk(to, &nd);
+		error = path_lookup(to, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		dentry = lookup_create(&nd, 0);
@@ -1637,12 +1629,10 @@
 		struct nameidata nd, old_nd;
 
 		error = 0;
-		if (path_init(from, LOOKUP_POSITIVE, &old_nd))
-			error = path_walk(from, &old_nd);
+		error = path_lookup(from, LOOKUP_POSITIVE, &old_nd);
 		if (error)
 			goto exit;
-		if (path_init(to, LOOKUP_PARENT, &nd))
-			error = path_walk(to, &nd);
+		error = path_lookup(to, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		error = -EXDEV;
@@ -1842,14 +1832,12 @@
 	struct dentry * old_dentry, *new_dentry;
 	struct nameidata oldnd, newnd;
 
-	if (path_init(oldname, LOOKUP_PARENT, &oldnd))
-		error = path_walk(oldname, &oldnd);
+	error = path_lookup(oldname, LOOKUP_PARENT, &oldnd);
 
 	if (error)
 		goto exit;
 
-	if (path_init(newname, LOOKUP_PARENT, &newnd))
-		error = path_walk(newname, &newnd);
+	error = path_lookup(newname, LOOKUP_PARENT, &newnd);
 	if (error)
 		goto exit1;
 
diff -Naur ../linux-2.4.18-rc1/fs/namespace.c ./fs/namespace.c
--- ../linux-2.4.18-rc1/fs/namespace.c	Thu Feb 14 18:23:07 2002
+++ ./fs/namespace.c	Thu Feb 14 18:54:14 2002
@@ -375,8 +375,7 @@
 	if (IS_ERR(kname))
 		goto out;
 	retval = 0;
-	if (path_init(kname, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &nd))
-		retval = path_walk(kname, &nd);
+	retval = path_lookup(kname, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &nd);
 	putname(kname);
 	if (retval)
 		goto out;
@@ -505,8 +504,7 @@
 		return err;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	if (path_init(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd))
-		err = path_walk(old_name, &old_nd);
+	err = path_lookup(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
@@ -572,8 +570,7 @@
 		return -EPERM;
 	if (!old_name || !*old_name)
 		return -EINVAL;
-	if (path_init(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd))
-		err = path_walk(old_name, &old_nd);
+	err = path_lookup(old_name, LOOKUP_POSITIVE|LOOKUP_FOLLOW, &old_nd);
 	if (err)
 		return err;
 
@@ -730,8 +727,7 @@
 	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);
 
 	/* ... and get the mountpoint */
-	if (path_init(dir_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		retval = path_walk(dir_name, &nd);
+	retval = path_lookup(dir_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	if (retval)
 		return retval;
 
@@ -843,8 +839,7 @@
 	if (IS_ERR(name))
 		goto out0;
 	error = 0;
-	if (path_init(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd))
-		error = path_walk(name, &new_nd);
+	error = path_lookup(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &new_nd);
 	putname(name);
 	if (error)
 		goto out0;
@@ -857,8 +852,7 @@
 	if (IS_ERR(name))
 		goto out1;
 	error = 0;
-	if (path_init(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd))
-		error = path_walk(name, &old_nd);
+	error = path_lookup(name, LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY, &old_nd);
 	putname(name);
 	if (error)
 		goto out1;
@@ -1048,8 +1042,7 @@
 	old_rootmnt = mntget(current->fs->rootmnt);
 	read_unlock(&current->fs->lock);
 	/*  First unmount devfs if mounted  */
-	if (path_init("/dev", LOOKUP_FOLLOW|LOOKUP_POSITIVE, &devfs_nd))
-		error = path_walk("/dev", &devfs_nd);
+	error = path_lookup("/dev", LOOKUP_FOLLOW|LOOKUP_POSITIVE, &devfs_nd);
 	if (!error) {
 		if (devfs_nd.mnt->mnt_sb->s_magic == DEVFS_SUPER_MAGIC &&
 		    devfs_nd.dentry == devfs_nd.mnt->mnt_root) {
@@ -1072,8 +1065,7 @@
 	 * Get the new mount directory
 	 */
 	error = 0;
-	if (path_init(put_old, LOOKUP_FOLLOW|LOOKUP_POSITIVE|LOOKUP_DIRECTORY, &nd))
-		error = path_walk(put_old, &nd);
+	error = path_lookup(put_old, LOOKUP_FOLLOW|LOOKUP_POSITIVE|LOOKUP_DIRECTORY, &nd);
 	if (error) {
 		int blivet;
 		struct block_device *ramdisk = old_rootmnt->mnt_sb->s_bdev;
diff -Naur ../linux-2.4.18-rc1/fs/nfsd/export.c ./fs/nfsd/export.c
--- ../linux-2.4.18-rc1/fs/nfsd/export.c	Wed Oct  3 22:57:36 2001
+++ ./fs/nfsd/export.c	Thu Feb 14 18:57:51 2002
@@ -190,8 +190,7 @@
 
 	/* Look up the dentry */
 	err = 0;
-	if (path_init(nxp->ex_path, LOOKUP_POSITIVE, &nd))
-		err = path_walk(nxp->ex_path, &nd);
+	err = path_lookup(nxp->ex_path, LOOKUP_POSITIVE, &nd);
 	if (err)
 		goto out_unlock;
 
@@ -388,8 +387,7 @@
 
 	err = -EPERM;
 	if (path) {
-		if (path_init(path, LOOKUP_POSITIVE, &nd) &&
-		    path_walk(path, &nd)) {
+		if (path_lookup(path, LOOKUP_POSITIVE, &nd)) {
 			printk("nfsd: exp_rootfh path not found %s", path);
 			return err;
 		}
diff -Naur ../linux-2.4.18-rc1/fs/open.c ./fs/open.c
--- ../linux-2.4.18-rc1/fs/open.c	Fri Oct 12 13:48:42 2001
+++ ./fs/open.c	Thu Feb 14 18:54:14 2002
@@ -368,8 +368,7 @@
 		goto out;
 
 	error = 0;
-	if (path_init(name,LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY,&nd))
-		error = path_walk(name, &nd);
+	error = path_lookup(name,LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY,&nd);
 	putname(name);
 	if (error)
 		goto out;
diff -Naur ../linux-2.4.18-rc1/fs/super.c ./fs/super.c
--- ../linux-2.4.18-rc1/fs/super.c	Thu Feb 14 18:23:07 2002
+++ ./fs/super.c	Thu Feb 14 18:54:14 2002
@@ -625,8 +625,7 @@
 	/* What device it is? */
 	if (!dev_name || !*dev_name)
 		return ERR_PTR(-EINVAL);
-	if (path_init(dev_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd))
-		error = path_walk(dev_name, &nd);
+	error = path_lookup(dev_name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, &nd);
 	if (error)
 		return ERR_PTR(error);
 	inode = nd.dentry->d_inode;
diff -Naur ../linux-2.4.18-rc1/include/linux/fs.h ./include/linux/fs.h
--- ../linux-2.4.18-rc1/include/linux/fs.h	Thu Feb 14 18:23:08 2002
+++ ./include/linux/fs.h	Thu Feb 14 19:06:26 2002
@@ -1316,6 +1316,14 @@
 #define user_path_walk(name,nd)	 __user_walk(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, nd)
 #define user_path_walk_link(name,nd) __user_walk(name, LOOKUP_POSITIVE, nd)
 
+static inline int path_lookup(const char *name, unsigned int flags, struct nameidata *nd) {
+	int error = 0;
+	if(path_init(name, flags, nd)) {
+		error = path_walk(name, nd);
+	}
+	return error;
+}
+
 extern void iput(struct inode *);
 extern void force_delete(struct inode *);
 extern struct inode * igrab(struct inode *);
diff -Naur ../linux-2.4.18-rc1/net/unix/af_unix.c ./net/unix/af_unix.c
--- ../linux-2.4.18-rc1/net/unix/af_unix.c	Thu Feb 14 18:23:08 2002
+++ ./net/unix/af_unix.c	Thu Feb 14 18:54:14 2002
@@ -592,9 +592,8 @@
 	int err = 0;
 	
 	if (sunname->sun_path[0]) {
-		if (path_init(sunname->sun_path, 
-			      LOOKUP_POSITIVE|LOOKUP_FOLLOW, &nd))
-			err = path_walk(sunname->sun_path, &nd);
+		err = path_lookup(sunname->sun_path, 
+			      LOOKUP_POSITIVE|LOOKUP_FOLLOW, &nd);
 		if (err)
 			goto fail;
 		err = permission(nd.dentry->d_inode,MAY_WRITE);
@@ -679,8 +678,7 @@
 		 * Get the parent directory, calculate the hash for last
 		 * component.
 		 */
-		if (path_init(sunaddr->sun_path, LOOKUP_PARENT, &nd))
-			err = path_walk(sunaddr->sun_path, &nd);
+		err = path_lookup(sunaddr->sun_path, LOOKUP_PARENT, &nd);
 		if (err)
 			goto out_mknod_parent;
 		/*


