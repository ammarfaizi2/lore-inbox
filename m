Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932484AbWAFTFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932484AbWAFTFE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWAFTEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:04:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2981 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932483AbWAFTEf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:04:35 -0500
Date: Fri, 6 Jan 2006 14:04:29 -0500
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200601061904.k06J4T55027893@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] updated *at function patch
Cc: akpm@osdl.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/fs/compat.c b/fs/compat.c
index 8186341..2c22929 100644
--- a/fs/compat.c
+++ b/fs/compat.c
@@ -68,10 +68,10 @@ asmlinkage long compat_sys_utime(char __
 		tv[0].tv_usec = 0;
 		tv[1].tv_usec = 0;
 	}
-	return do_utimes(filename, t ? tv : NULL);
+	return do_utimes(AT_FDCWD, filename, t ? tv : NULL);
 }
 
-asmlinkage long compat_sys_utimes(char __user *filename, struct compat_timeval __user *t)
+asmlinkage long compat_sys_futimesat(int dfd, char __user *filename, struct compat_timeval __user *t)
 {
 	struct timeval tv[2];
 
@@ -82,14 +82,19 @@ asmlinkage long compat_sys_utimes(char _
 		    get_user(tv[1].tv_usec, &t[1].tv_usec))
 			return -EFAULT; 
 	} 
-	return do_utimes(filename, t ? tv : NULL);
+	return do_utimes(dfd, filename, t ? tv : NULL);
+}
+
+asmlinkage long compat_sys_utimes(char __user *filename, struct compat_timeval __user *t)
+{
+	return compat_sys_futimesat(AT_FDCWD, filename, t);
 }
 
 asmlinkage long compat_sys_newstat(char __user * filename,
 		struct compat_stat __user *statbuf)
 {
 	struct kstat stat;
-	int error = vfs_stat(filename, &stat);
+	int error = vfs_stat_fd(AT_FDCWD, filename, &stat);
 
 	if (!error)
 		error = cp_compat_stat(&stat, statbuf);
@@ -100,13 +105,34 @@ asmlinkage long compat_sys_newlstat(char
 		struct compat_stat __user *statbuf)
 {
 	struct kstat stat;
-	int error = vfs_lstat(filename, &stat);
+	int error = vfs_lstat_fd(AT_FDCWD, filename, &stat);
 
 	if (!error)
 		error = cp_compat_stat(&stat, statbuf);
 	return error;
 }
 
+asmlinkage long compat_sys_newfstatat(int dfd, char __user * filename,
+		struct compat_stat __user *statbuf, int flag)
+{
+	struct kstat stat;
+	int error = -EINVAL;
+
+	if ((flag & ~AT_SYMLINK_NOFOLLOW) != 0)
+		goto out;
+
+	if (flag & AT_SYMLINK_NOFOLLOW)
+		error = vfs_lstat_fd(dfd, filename, &stat);
+	else
+		error = vfs_stat_fd(dfd, filename, &stat);
+
+	if (!error)
+		error = cp_compat_stat(&stat, statbuf);
+
+out:
+	return error;
+}
+
 asmlinkage long compat_sys_newfstat(unsigned int fd,
 		struct compat_stat __user * statbuf)
 {
@@ -1276,7 +1302,17 @@ out:
 asmlinkage long
 compat_sys_open(const char __user *filename, int flags, int mode)
 {
-	return do_sys_open(filename, flags, mode);
+	return do_sys_open(AT_FDCWD, filename, flags, mode);
+}
+
+/*
+ * Exactly like fs/open.c:sys_openat(), except that it doesn't set the
+ * O_LARGEFILE flag.
+ */
+asmlinkage long
+compat_sys_openat(int dfd, const char __user *filename, int flags, int mode)
+{
+	return do_sys_open(dfd, filename, flags, mode);
 }
 
 /*
diff --git a/fs/exec.c b/fs/exec.c
index 22533cc..ab5b66a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -477,7 +477,7 @@ struct file *open_exec(const char *name)
 	int err;
 	struct file *file;
 
-	err = path_lookup_open(name, LOOKUP_FOLLOW, &nd, FMODE_READ);
+	err = path_lookup_open(AT_FDCWD, name, LOOKUP_FOLLOW, &nd, FMODE_READ);
 	file = ERR_PTR(err);
 
 	if (!err) {
diff --git a/fs/namei.c b/fs/namei.c
index 6dbbd42..1261e76 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -29,6 +29,8 @@
 #include <linux/mount.h>
 #include <linux/audit.h>
 #include <linux/file.h>
+#include <linux/fcntl.h>
+#include <linux/namei.h>
 #include <asm/namei.h>
 #include <asm/uaccess.h>
 
@@ -1062,7 +1064,7 @@ set_it:
 }
 
 /* Returns 0 and nd will be valid on success; Retuns error, otherwise. */
-int fastcall path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
+static int fastcall do_path_lookup(int dfd, const char *name, unsigned int flags, struct nameidata *nd)
 {
 	int retval = 0;
 
@@ -1082,9 +1084,37 @@ int fastcall path_lookup(const char *nam
 		}
 		nd->mnt = mntget(current->fs->rootmnt);
 		nd->dentry = dget(current->fs->root);
-	} else {
+	} else if (dfd == AT_FDCWD) {
 		nd->mnt = mntget(current->fs->pwdmnt);
 		nd->dentry = dget(current->fs->pwd);
+	} else {
+		struct file *file;
+		int fput_needed;
+		struct dentry *dentry;
+
+		file = fget_light(dfd, &fput_needed);
+		if (!file) {
+			retval = -EBADF;
+			goto out_fail;
+		}
+
+		dentry = file->f_dentry;
+
+		if (!S_ISDIR(dentry->d_inode->i_mode)) {
+			retval = -ENOTDIR;
+		out_fail2:
+			fput_light(file, fput_needed);
+			goto out_fail;
+		}
+
+		retval = file_permission(file, MAY_EXEC);
+		if (retval)
+			goto out_fail2;
+
+		nd->mnt = mntget(file->f_vfsmnt);
+		nd->dentry = dget(dentry);
+
+		fput_light(file, fput_needed);
 	}
 	read_unlock(&current->fs->lock);
 	current->total_link_count = 0;
@@ -1093,11 +1123,18 @@ out:
 	if (unlikely(current->audit_context
 		     && nd && nd->dentry && nd->dentry->d_inode))
 		audit_inode(name, nd->dentry->d_inode, flags);
+out_fail:
 	return retval;
 }
 
-static int __path_lookup_intent_open(const char *name, unsigned int lookup_flags,
-		struct nameidata *nd, int open_flags, int create_mode)
+int fastcall path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
+{
+	return do_path_lookup(AT_FDCWD, name, flags, nd);
+}
+
+static int __path_lookup_intent_open(int dfd, const char *name,
+		unsigned int lookup_flags, struct nameidata *nd,
+		int open_flags, int create_mode)
 {
 	struct file *filp = get_empty_filp();
 	int err;
@@ -1107,7 +1144,7 @@ static int __path_lookup_intent_open(con
 	nd->intent.open.file = filp;
 	nd->intent.open.flags = open_flags;
 	nd->intent.open.create_mode = create_mode;
-	err = path_lookup(name, lookup_flags|LOOKUP_OPEN, nd);
+	err = do_path_lookup(dfd, name, lookup_flags|LOOKUP_OPEN, nd);
 	if (IS_ERR(nd->intent.open.file)) {
 		if (err == 0) {
 			err = PTR_ERR(nd->intent.open.file);
@@ -1125,10 +1162,10 @@ static int __path_lookup_intent_open(con
  * @nd: pointer to nameidata
  * @open_flags: open intent flags
  */
-int path_lookup_open(const char *name, unsigned int lookup_flags,
+int path_lookup_open(int dfd, const char *name, unsigned int lookup_flags,
 		struct nameidata *nd, int open_flags)
 {
-	return __path_lookup_intent_open(name, lookup_flags, nd,
+	return __path_lookup_intent_open(dfd, name, lookup_flags, nd,
 			open_flags, 0);
 }
 
@@ -1140,12 +1177,12 @@ int path_lookup_open(const char *name, u
  * @open_flags: open intent flags
  * @create_mode: create intent flags
  */
-static int path_lookup_create(const char *name, unsigned int lookup_flags,
-			      struct nameidata *nd, int open_flags,
-			      int create_mode)
+static int path_lookup_create(int dfd, const char *name,
+			      unsigned int lookup_flags, struct nameidata *nd,
+			      int open_flags, int create_mode)
 {
-	return __path_lookup_intent_open(name, lookup_flags|LOOKUP_CREATE, nd,
-			open_flags, create_mode);
+	return __path_lookup_intent_open(dfd, name, lookup_flags|LOOKUP_CREATE,
+			nd, open_flags, create_mode);
 }
 
 int __user_path_lookup_open(const char __user *name, unsigned int lookup_flags,
@@ -1155,7 +1192,7 @@ int __user_path_lookup_open(const char _
 	int err = PTR_ERR(tmp);
 
 	if (!IS_ERR(tmp)) {
-		err = __path_lookup_intent_open(tmp, lookup_flags, nd, open_flags, 0);
+		err = __path_lookup_intent_open(AT_FDCWD, tmp, lookup_flags, nd, open_flags, 0);
 		putname(tmp);
 	}
 	return err;
@@ -1247,18 +1284,24 @@ access:
  * that namei follows links, while lnamei does not.
  * SMP-safe
  */
-int fastcall __user_walk(const char __user *name, unsigned flags, struct nameidata *nd)
+int fastcall __user_walk_fd(int dfd, const char __user *name, unsigned flags,
+			    struct nameidata *nd)
 {
 	char *tmp = getname(name);
 	int err = PTR_ERR(tmp);
 
 	if (!IS_ERR(tmp)) {
-		err = path_lookup(tmp, flags, nd);
+		err = do_path_lookup(dfd, tmp, flags, nd);
 		putname(tmp);
 	}
 	return err;
 }
 
+int fastcall __user_walk(const char __user *name, unsigned flags, struct nameidata *nd)
+{
+	return __user_walk_fd(AT_FDCWD, name, flags, nd);
+}
+
 /*
  * It's inline, so penalty for filesystems that don't use sticky bit is
  * minimal.
@@ -1517,7 +1560,8 @@ int may_open(struct nameidata *nd, int a
  * for symlinks (where the permissions are checked later).
  * SMP-safe
  */
-int open_namei(const char * pathname, int flag, int mode, struct nameidata *nd)
+int open_namei(int dfd, const char * pathname, int flag, int mode,
+	       struct nameidata *nd)
 {
 	int acc_mode, error;
 	struct path path;
@@ -1539,7 +1583,8 @@ int open_namei(const char * pathname, in
 	 * The simplest case - just a plain lookup.
 	 */
 	if (!(flag & O_CREAT)) {
-		error = path_lookup_open(pathname, lookup_flags(flag), nd, flag);
+		error = path_lookup_open(dfd, pathname, lookup_flags(flag),
+					 nd, flag);
 		if (error)
 			return error;
 		goto ok;
@@ -1548,7 +1593,7 @@ int open_namei(const char * pathname, in
 	/*
 	 * Create - we need to know the parent.
 	 */
-	error = path_lookup_create(pathname, LOOKUP_PARENT, nd, flag, mode);
+	error = path_lookup_create(dfd, pathname, LOOKUP_PARENT, nd, flag, mode);
 	if (error)
 		return error;
 
@@ -1743,7 +1788,8 @@ int vfs_mknod(struct inode *dir, struct 
 	return error;
 }
 
-asmlinkage long sys_mknod(const char __user * filename, int mode, unsigned dev)
+asmlinkage long sys_mknodat(int dfd, const char __user * filename, int mode,
+			    unsigned dev)
 {
 	int error = 0;
 	char * tmp;
@@ -1756,7 +1802,7 @@ asmlinkage long sys_mknod(const char __u
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-	error = path_lookup(tmp, LOOKUP_PARENT, &nd);
+	error = do_path_lookup(dfd, tmp, LOOKUP_PARENT, &nd);
 	if (error)
 		goto out;
 	dentry = lookup_create(&nd, 0);
@@ -1792,6 +1838,11 @@ out:
 	return error;
 }
 
+asmlinkage long sys_mknod(const char __user * filename, int mode, unsigned dev)
+{
+	return sys_mknodat(AT_FDCWD, filename, mode, dev);
+}
+
 int vfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	int error = may_create(dir, dentry, NULL);
@@ -1814,7 +1865,7 @@ int vfs_mkdir(struct inode *dir, struct 
 	return error;
 }
 
-asmlinkage long sys_mkdir(const char __user * pathname, int mode)
+asmlinkage long sys_mkdirat(int dfd, const char __user * pathname, int mode)
 {
 	int error = 0;
 	char * tmp;
@@ -1825,7 +1876,7 @@ asmlinkage long sys_mkdir(const char __u
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		error = path_lookup(tmp, LOOKUP_PARENT, &nd);
+		error = do_path_lookup(dfd, tmp, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		dentry = lookup_create(&nd, 1);
@@ -1845,6 +1896,11 @@ out:
 	return error;
 }
 
+asmlinkage long sys_mkdir(const char __user * pathname, int mode)
+{
+	return sys_mkdirat(AT_FDCWD, pathname, mode);
+}
+
 /*
  * We try to drop the dentry early: we should have
  * a usage count of 2 if we're the only user of this
@@ -1906,7 +1962,7 @@ int vfs_rmdir(struct inode *dir, struct 
 	return error;
 }
 
-asmlinkage long sys_rmdir(const char __user * pathname)
+static long do_rmdir(int dfd, const char __user * pathname)
 {
 	int error = 0;
 	char * name;
@@ -1917,7 +1973,7 @@ asmlinkage long sys_rmdir(const char __u
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	error = path_lookup(name, LOOKUP_PARENT, &nd);
+	error = do_path_lookup(dfd, name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
 
@@ -1947,6 +2003,11 @@ exit:
 	return error;
 }
 
+asmlinkage long sys_rmdir(const char __user * pathname)
+{
+	return do_rmdir(AT_FDCWD, pathname);
+}
+
 int vfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int error = may_delete(dir, dentry, 0);
@@ -1983,7 +2044,7 @@ int vfs_unlink(struct inode *dir, struct
  * writeout happening, and we don't want to prevent access to the directory
  * while waiting on the I/O.
  */
-asmlinkage long sys_unlink(const char __user * pathname)
+static long do_unlinkat(int dfd, const char __user * pathname)
 {
 	int error = 0;
 	char * name;
@@ -1995,7 +2056,7 @@ asmlinkage long sys_unlink(const char __
 	if(IS_ERR(name))
 		return PTR_ERR(name);
 
-	error = path_lookup(name, LOOKUP_PARENT, &nd);
+	error = do_path_lookup(dfd, name, LOOKUP_PARENT, &nd);
 	if (error)
 		goto exit;
 	error = -EISDIR;
@@ -2030,6 +2091,22 @@ slashes:
 	goto exit2;
 }
 
+asmlinkage long sys_unlinkat(int dfd, const char __user * pathname, int flag)
+{
+	if ((flag & ~AT_REMOVEDIR) != 0)
+		return -EINVAL;
+
+	if (flag & AT_REMOVEDIR)
+		return do_rmdir(dfd, pathname);
+
+	return do_unlinkat(dfd, pathname);
+}
+
+asmlinkage long sys_unlink(const char __user * pathname)
+{
+	return do_unlinkat(AT_FDCWD, pathname);
+}
+
 int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname, int mode)
 {
 	int error = may_create(dir, dentry, NULL);
@@ -2051,7 +2128,8 @@ int vfs_symlink(struct inode *dir, struc
 	return error;
 }
 
-asmlinkage long sys_symlink(const char __user * oldname, const char __user * newname)
+asmlinkage long sys_symlinkat(const char __user * oldname,
+			      int newdfd, const char __user * newname)
 {
 	int error = 0;
 	char * from;
@@ -2066,7 +2144,7 @@ asmlinkage long sys_symlink(const char _
 		struct dentry *dentry;
 		struct nameidata nd;
 
-		error = path_lookup(to, LOOKUP_PARENT, &nd);
+		error = do_path_lookup(newdfd, to, LOOKUP_PARENT, &nd);
 		if (error)
 			goto out;
 		dentry = lookup_create(&nd, 0);
@@ -2084,6 +2162,11 @@ out:
 	return error;
 }
 
+asmlinkage long sys_symlink(const char __user * oldname, const char __user * newname)
+{
+	return sys_symlinkat(oldname, AT_FDCWD, newname);
+}
+
 int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_dentry)
 {
 	struct inode *inode = old_dentry->d_inode;
@@ -2131,7 +2214,8 @@ int vfs_link(struct dentry *old_dentry, 
  * with linux 2.0, and to avoid hard-linking to directories
  * and other special files.  --ADM
  */
-asmlinkage long sys_link(const char __user * oldname, const char __user * newname)
+asmlinkage long sys_linkat(int olddfd, const char __user *oldname,
+			   int newdfd, const char __user *newname)
 {
 	struct dentry *new_dentry;
 	struct nameidata nd, old_nd;
@@ -2142,10 +2226,10 @@ asmlinkage long sys_link(const char __us
 	if (IS_ERR(to))
 		return PTR_ERR(to);
 
-	error = __user_walk(oldname, 0, &old_nd);
+	error = __user_walk_fd(olddfd, oldname, 0, &old_nd);
 	if (error)
 		goto exit;
-	error = path_lookup(to, LOOKUP_PARENT, &nd);
+	error = do_path_lookup(newdfd, to, LOOKUP_PARENT, &nd);
 	if (error)
 		goto out;
 	error = -EXDEV;
@@ -2168,6 +2252,11 @@ exit:
 	return error;
 }
 
+asmlinkage long sys_link(const char __user * oldname, const char __user * newname)
+{
+	return sys_linkat(AT_FDCWD, oldname, AT_FDCWD, newname);
+}
+
 /*
  * The worst of all namespace operations - renaming directory. "Perverted"
  * doesn't even start to describe it. Somebody in UCB had a heck of a trip...
@@ -2314,7 +2403,8 @@ int vfs_rename(struct inode *old_dir, st
 	return error;
 }
 
-static inline int do_rename(const char * oldname, const char * newname)
+static inline int do_rename(int olddfd, const char * oldname,
+			    int newdfd, const char * newname)
 {
 	int error = 0;
 	struct dentry * old_dir, * new_dir;
@@ -2322,11 +2412,11 @@ static inline int do_rename(const char *
 	struct dentry * trap;
 	struct nameidata oldnd, newnd;
 
-	error = path_lookup(oldname, LOOKUP_PARENT, &oldnd);
+	error = do_path_lookup(olddfd, oldname, LOOKUP_PARENT, &oldnd);
 	if (error)
 		goto exit;
 
-	error = path_lookup(newname, LOOKUP_PARENT, &newnd);
+	error = do_path_lookup(newdfd, newname, LOOKUP_PARENT, &newnd);
 	if (error)
 		goto exit1;
 
@@ -2390,7 +2480,8 @@ exit:
 	return error;
 }
 
-asmlinkage long sys_rename(const char __user * oldname, const char __user * newname)
+asmlinkage long sys_renameat(int olddfd, const char __user * oldname,
+			     int newdfd, const char __user * newname)
 {
 	int error;
 	char * from;
@@ -2402,13 +2493,18 @@ asmlinkage long sys_rename(const char __
 	to = getname(newname);
 	error = PTR_ERR(to);
 	if (!IS_ERR(to)) {
-		error = do_rename(from,to);
+		error = do_rename(olddfd, from, newdfd, to);
 		putname(to);
 	}
 	putname(from);
 	return error;
 }
 
+asmlinkage long sys_rename(const char __user * oldname, const char __user * newname)
+{
+	return sys_renameat(AT_FDCWD, oldname, AT_FDCWD, newname);
+}
+
 int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen, const char *link)
 {
 	int len;
@@ -2552,6 +2648,7 @@ struct inode_operations page_symlink_ino
 };
 
 EXPORT_SYMBOL(__user_walk);
+EXPORT_SYMBOL(__user_walk_fd);
 EXPORT_SYMBOL(follow_down);
 EXPORT_SYMBOL(follow_up);
 EXPORT_SYMBOL(get_write_access); /* binfmt_aout */
diff --git a/fs/open.c b/fs/open.c
index f53a5b9..5712b48 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -25,6 +25,7 @@
 #include <linux/pagemap.h>
 #include <linux/syscalls.h>
 #include <linux/rcupdate.h>
+#include <linux/fcntl.h>
 
 #include <asm/unistd.h>
 
@@ -381,7 +382,7 @@ asmlinkage long sys_utime(char __user * 
 
 		error = get_user(newattrs.ia_atime.tv_sec, &times->actime);
 		newattrs.ia_atime.tv_nsec = 0;
-		if (!error) 
+		if (!error)
 			error = get_user(newattrs.ia_mtime.tv_sec, &times->modtime);
 		newattrs.ia_mtime.tv_nsec = 0;
 		if (error)
@@ -412,14 +413,14 @@ out:
  * must be owner or have write permission.
  * Else, update from *times, must be owner or super user.
  */
-long do_utimes(char __user * filename, struct timeval * times)
+long do_utimes(int dfd, char __user * filename, struct timeval * times)
 {
 	int error;
 	struct nameidata nd;
 	struct inode * inode;
 	struct iattr newattrs;
 
-	error = user_path_walk(filename, &nd);
+	error = __user_walk_fd(dfd, filename, LOOKUP_FOLLOW, &nd);
 
 	if (error)
 		goto out;
@@ -459,13 +460,18 @@ out:
 	return error;
 }
 
-asmlinkage long sys_utimes(char __user * filename, struct timeval __user * utimes)
+asmlinkage long sys_futimesat(int dfd, char __user * filename, struct timeval __user * utimes)
 {
 	struct timeval times[2];
 
 	if (utimes && copy_from_user(&times, utimes, sizeof(times)))
 		return -EFAULT;
-	return do_utimes(filename, utimes ? times : NULL);
+	return do_utimes(dfd, filename, utimes ? times : NULL);
+}
+
+asmlinkage long sys_utimes(char __user * filename, struct timeval __user * utimes)
+{
+	return sys_futimesat(AT_FDCWD, filename, utimes);
 }
 
 
@@ -474,7 +480,7 @@ asmlinkage long sys_utimes(char __user *
  * We do this by temporarily clearing all FS-related capabilities and
  * switching the fsuid/fsgid around to the real ones.
  */
-asmlinkage long sys_access(const char __user * filename, int mode)
+asmlinkage long sys_faccessat(int dfd, const char __user * filename, int mode)
 {
 	struct nameidata nd;
 	int old_fsuid, old_fsgid;
@@ -504,7 +510,7 @@ asmlinkage long sys_access(const char __
 	else
 		current->cap_effective = current->cap_permitted;
 
-	res = __user_walk(filename, LOOKUP_FOLLOW|LOOKUP_ACCESS, &nd);
+	res = __user_walk_fd(dfd, filename, LOOKUP_FOLLOW|LOOKUP_ACCESS, &nd);
 	if (!res) {
 		res = vfs_permission(&nd, mode);
 		/* SuS v2 requires we report a read only fs too */
@@ -521,6 +527,11 @@ asmlinkage long sys_access(const char __
 	return res;
 }
 
+asmlinkage long sys_access(const char __user * filename, int mode)
+{
+	return sys_faccessat(AT_FDCWD, filename, mode);
+}
+
 asmlinkage long sys_chdir(const char __user * filename)
 {
 	struct nameidata nd;
@@ -633,14 +644,15 @@ out:
 	return err;
 }
 
-asmlinkage long sys_chmod(const char __user * filename, mode_t mode)
+asmlinkage long sys_fchmodat(int dfd, const char __user * filename,
+			     mode_t mode)
 {
 	struct nameidata nd;
 	struct inode * inode;
 	int error;
 	struct iattr newattrs;
 
-	error = user_path_walk(filename, &nd);
+	error = __user_walk_fd(dfd, filename, LOOKUP_FOLLOW, &nd);
 	if (error)
 		goto out;
 	inode = nd.dentry->d_inode;
@@ -667,6 +679,11 @@ out:
 	return error;
 }
 
+asmlinkage long sys_chmod(const char __user * filename, mode_t mode)
+{
+	return sys_fchmodat(AT_FDCWD, filename, mode);
+}
+
 static int chown_common(struct dentry * dentry, uid_t user, gid_t group)
 {
 	struct inode * inode;
@@ -715,6 +732,26 @@ asmlinkage long sys_chown(const char __u
 	return error;
 }
 
+asmlinkage long sys_fchownat(int dfd, const char __user *filename, uid_t user,
+			     gid_t group, int flag)
+{
+	struct nameidata nd;
+	int error = -EINVAL;
+	int follow;
+
+	if ((flag & ~AT_SYMLINK_NOFOLLOW) != 0)
+		goto out;
+
+	follow = (flag & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FOLLOW;
+	error = __user_walk_fd(dfd, filename, follow, &nd);
+	if (!error) {
+		error = chown_common(nd.dentry, user, group);
+		path_release(&nd);
+	}
+out:
+	return error;
+}
+
 asmlinkage long sys_lchown(const char __user * filename, uid_t user, gid_t group)
 {
 	struct nameidata nd;
@@ -818,7 +855,8 @@ cleanup_file:
  * for the internal routines (ie open_namei()/follow_link() etc). 00 is
  * used by symlinks.
  */
-struct file *filp_open(const char * filename, int flags, int mode)
+static struct file *do_filp_open(int dfd, const char * filename, int flags,
+				 int mode)
 {
 	int namei_flags, error;
 	struct nameidata nd;
@@ -827,12 +865,17 @@ struct file *filp_open(const char * file
 	if ((namei_flags+1) & O_ACCMODE)
 		namei_flags++;
 
-	error = open_namei(filename, namei_flags, mode, &nd);
+	error = open_namei(dfd, filename, namei_flags, mode, &nd);
 	if (!error)
 		return nameidata_to_filp(&nd, flags);
 
 	return ERR_PTR(error);
 }
+
+struct file *filp_open(const char * filename, int flags, int mode)
+{
+	return do_filp_open(AT_FDCWD, filename, flags, mode);
+}
 EXPORT_SYMBOL(filp_open);
 
 /**
@@ -989,7 +1032,7 @@ void fastcall put_unused_fd(unsigned int
 EXPORT_SYMBOL(put_unused_fd);
 
 /*
- * Install a file pointer in the fd array.  
+ * Install a file pointer in the fd array.
  *
  * The VFS is full of places where we drop the files lock between
  * setting the open_fds bitmap and installing the file in the file
@@ -1014,7 +1057,7 @@ void fastcall fd_install(unsigned int fd
 
 EXPORT_SYMBOL(fd_install);
 
-long do_sys_open(const char __user *filename, int flags, int mode)
+long do_sys_open(int dfd, const char __user *filename, int flags, int mode)
 {
 	char *tmp = getname(filename);
 	int fd = PTR_ERR(tmp);
@@ -1022,7 +1065,7 @@ long do_sys_open(const char __user *file
 	if (!IS_ERR(tmp)) {
 		fd = get_unused_fd();
 		if (fd >= 0) {
-			struct file *f = filp_open(tmp, flags, mode);
+			struct file *f = do_filp_open(dfd, tmp, flags, mode);
 			if (IS_ERR(f)) {
 				put_unused_fd(fd);
 				fd = PTR_ERR(f);
@@ -1041,10 +1084,20 @@ asmlinkage long sys_open(const char __us
 	if (force_o_largefile())
 		flags |= O_LARGEFILE;
 
-	return do_sys_open(filename, flags, mode);
+	return do_sys_open(AT_FDCWD, filename, flags, mode);
 }
 EXPORT_SYMBOL_GPL(sys_open);
 
+asmlinkage long sys_openat(int dfd, const char __user *filename, int flags,
+			   int mode)
+{
+	if (force_o_largefile())
+		flags |= O_LARGEFILE;
+
+	return do_sys_open(dfd, filename, flags, mode);
+}
+EXPORT_SYMBOL_GPL(sys_openat);
+
 #ifndef __alpha__
 
 /*
diff --git a/fs/stat.c b/fs/stat.c
index b8a0e51..c796731 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -63,12 +63,12 @@ int vfs_getattr(struct vfsmount *mnt, st
 
 EXPORT_SYMBOL(vfs_getattr);
 
-int vfs_stat(char __user *name, struct kstat *stat)
+int vfs_stat_fd(int dfd, char __user *name, struct kstat *stat)
 {
 	struct nameidata nd;
 	int error;
 
-	error = user_path_walk(name, &nd);
+	error = __user_walk_fd(dfd, name, LOOKUP_FOLLOW, &nd);
 	if (!error) {
 		error = vfs_getattr(nd.mnt, nd.dentry, stat);
 		path_release(&nd);
@@ -76,14 +76,19 @@ int vfs_stat(char __user *name, struct k
 	return error;
 }
 
+int vfs_stat(char __user *name, struct kstat *stat)
+{
+	return vfs_stat_fd(AT_FDCWD, name, stat);
+}
+
 EXPORT_SYMBOL(vfs_stat);
 
-int vfs_lstat(char __user *name, struct kstat *stat)
+int vfs_lstat_fd(int dfd, char __user *name, struct kstat *stat)
 {
 	struct nameidata nd;
 	int error;
 
-	error = user_path_walk_link(name, &nd);
+	error = __user_walk_fd(dfd, name, 0, &nd);
 	if (!error) {
 		error = vfs_getattr(nd.mnt, nd.dentry, stat);
 		path_release(&nd);
@@ -91,6 +96,11 @@ int vfs_lstat(char __user *name, struct 
 	return error;
 }
 
+int vfs_lstat(char __user *name, struct kstat *stat)
+{
+	return vfs_lstat_fd(AT_FDCWD, name, stat);
+}
+
 EXPORT_SYMBOL(vfs_lstat);
 
 int vfs_fstat(unsigned int fd, struct kstat *stat)
@@ -151,7 +161,7 @@ static int cp_old_stat(struct kstat *sta
 asmlinkage long sys_stat(char __user * filename, struct __old_kernel_stat __user * statbuf)
 {
 	struct kstat stat;
-	int error = vfs_stat(filename, &stat);
+	int error = vfs_stat_fd(AT_FDCWD, filename, &stat);
 
 	if (!error)
 		error = cp_old_stat(&stat, statbuf);
@@ -161,7 +171,7 @@ asmlinkage long sys_stat(char __user * f
 asmlinkage long sys_lstat(char __user * filename, struct __old_kernel_stat __user * statbuf)
 {
 	struct kstat stat;
-	int error = vfs_lstat(filename, &stat);
+	int error = vfs_lstat_fd(AT_FDCWD, filename, &stat);
 
 	if (!error)
 		error = cp_old_stat(&stat, statbuf);
@@ -232,7 +242,7 @@ static int cp_new_stat(struct kstat *sta
 asmlinkage long sys_newstat(char __user * filename, struct stat __user * statbuf)
 {
 	struct kstat stat;
-	int error = vfs_stat(filename, &stat);
+	int error = vfs_stat_fd(AT_FDCWD, filename, &stat);
 
 	if (!error)
 		error = cp_new_stat(&stat, statbuf);
@@ -242,13 +252,32 @@ asmlinkage long sys_newstat(char __user 
 asmlinkage long sys_newlstat(char __user * filename, struct stat __user * statbuf)
 {
 	struct kstat stat;
-	int error = vfs_lstat(filename, &stat);
+	int error = vfs_lstat_fd(AT_FDCWD, filename, &stat);
 
 	if (!error)
 		error = cp_new_stat(&stat, statbuf);
 
 	return error;
 }
+asmlinkage long sys_newfstatat(int dfd, char __user * filename, struct stat __user * statbuf, int flag)
+{
+	struct kstat stat;
+	int error = -EINVAL;
+
+	if ((flag & ~AT_SYMLINK_NOFOLLOW) != 0)
+		goto out;
+
+	if (flag & AT_SYMLINK_NOFOLLOW)
+		error = vfs_lstat_fd(dfd, filename, &stat);
+	else
+		error = vfs_stat_fd(dfd, filename, &stat);
+
+	if (!error)
+		error = cp_new_stat(&stat, statbuf);
+
+out:
+	return error;
+}
 asmlinkage long sys_newfstat(unsigned int fd, struct stat __user * statbuf)
 {
 	struct kstat stat;
@@ -260,7 +289,7 @@ asmlinkage long sys_newfstat(unsigned in
 	return error;
 }
 
-asmlinkage long sys_readlink(const char __user * path, char __user * buf, int bufsiz)
+asmlinkage long sys_readlinkat(int dfd, const char __user * path, char __user * buf, int bufsiz)
 {
 	struct nameidata nd;
 	int error;
@@ -268,7 +297,7 @@ asmlinkage long sys_readlink(const char 
 	if (bufsiz <= 0)
 		return -EINVAL;
 
-	error = user_path_walk_link(path, &nd);
+	error = __user_walk_fd(dfd, path, 0, &nd);
 	if (!error) {
 		struct inode * inode = nd.dentry->d_inode;
 
@@ -285,6 +314,11 @@ asmlinkage long sys_readlink(const char 
 	return error;
 }
 
+asmlinkage long sys_readlink(const char __user * path, char __user * buf, int bufsiz)
+{
+	return sys_readlinkat(AT_FDCWD, path, buf, bufsiz);
+}
+
 
 /* ---------- LFS-64 ----------- */
 #ifdef __ARCH_WANT_STAT64
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 8a7c821..c52a637 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -23,6 +23,13 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+#define AT_FDCWD		-100    /* Special value used to indicate
+                                           openat should use the current
+                                           working directory. */
+#define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
+#define AT_REMOVEDIR		0x200   /* Remove directory instead of
+                                           unlinking file.  */
+
 #ifdef __KERNEL__
 
 #ifndef force_o_largefile
diff --git a/include/linux/fs.h b/include/linux/fs.h
index cc35b6a..03ee005 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1314,7 +1314,8 @@ static inline int break_lease(struct ino
 /* fs/open.c */
 
 extern int do_truncate(struct dentry *, loff_t start, struct file *filp);
-extern long do_sys_open(const char __user *filename, int flags, int mode);
+extern long do_sys_open(int fdf, const char __user *filename, int flags,
+			int mode);
 extern struct file *filp_open(const char *, int, int);
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, int);
 extern int filp_close(struct file *, fl_owner_t id);
@@ -1442,7 +1443,7 @@ static inline void allow_write_access(st
 }
 extern int do_pipe(int *);
 
-extern int open_namei(const char *, int, int, struct nameidata *);
+extern int open_namei(int dfd, const char *, int, int, struct nameidata *);
 extern int may_open(struct nameidata *, int, int);
 
 extern int kernel_read(struct file *, unsigned long, char *, unsigned long);
@@ -1640,6 +1641,8 @@ extern int vfs_readdir(struct file *, fi
 
 extern int vfs_stat(char __user *, struct kstat *);
 extern int vfs_lstat(char __user *, struct kstat *);
+extern int vfs_stat_fd(int dfd, char __user *, struct kstat *);
+extern int vfs_lstat_fd(int dfd, char __user *, struct kstat *);
 extern int vfs_fstat(unsigned int, struct kstat *);
 
 extern int vfs_ioctl(struct file *, unsigned int, unsigned int, unsigned long);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 455660e..7967ec0 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -56,10 +56,11 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LA
 #define LOOKUP_ACCESS		(0x0400)
 
 extern int FASTCALL(__user_walk(const char __user *, unsigned, struct nameidata *));
+extern int FASTCALL(__user_walk_fd(int dfd, const char __user *, unsigned, struct nameidata *));
 #define user_path_walk(name,nd) \
-	__user_walk(name, LOOKUP_FOLLOW, nd)
+	__user_walk_fd(AT_FDCWD, name, LOOKUP_FOLLOW, nd)
 #define user_path_walk_link(name,nd) \
-	__user_walk(name, 0, nd)
+	__user_walk_fd(AT_FDCWD, name, 0, nd)
 extern int FASTCALL(path_lookup(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_walk(const char *, struct nameidata *));
 extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
@@ -67,7 +68,7 @@ extern void path_release(struct nameidat
 extern void path_release_on_umount(struct nameidata *);
 
 extern int __user_path_lookup_open(const char __user *, unsigned lookup_flags, struct nameidata *nd, int open_flags);
-extern int path_lookup_open(const char *, unsigned lookup_flags, struct nameidata *, int open_flags);
+extern int path_lookup_open(int dfd, const char *name, unsigned lookup_flags, struct nameidata *, int open_flags);
 extern struct file *lookup_instantiate_filp(struct nameidata *nd, struct dentry *dentry,
 		int (*open)(struct inode *, struct file *));
 extern struct file *nameidata_to_filp(struct nameidata *nd, int flags);
diff --git a/include/linux/time.h b/include/linux/time.h
index 797ccd8..0996cb0 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -90,7 +90,7 @@ extern int do_settimeofday(struct timesp
 extern int do_sys_settimeofday(struct timespec *tv, struct timezone *tz);
 extern void clock_was_set(void); // call when ever the clock is set
 extern int do_posix_clock_monotonic_gettime(struct timespec *tp);
-extern long do_utimes(char __user * filename, struct timeval * times);
+extern long do_utimes(int dfd, char __user * filename, struct timeval * times);
 struct itimerval;
 extern int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue);
 extern int do_getitimer(int which, struct itimerval *value);
