Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317611AbSIEP5U>; Thu, 5 Sep 2002 11:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317694AbSIEP5U>; Thu, 5 Sep 2002 11:57:20 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:49400 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S317611AbSIEP5H>; Thu, 5 Sep 2002 11:57:07 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 5 Sep 2002 09:59:01 -0600
To: Alexander Viro <viro@math.psu.edu>
Cc: Edgar Toernig <froese@gmx.de>, ptb@it.uc3m.es,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] intent-based lookup (was: mount flag "direct")
Message-ID: <20020905155900.GL7887@clusterfs.com>
Mail-Followup-To: Alexander Viro <viro@math.psu.edu>,
	Edgar Toernig <froese@gmx.de>, ptb@it.uc3m.es,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3D76D142.AFD9E991@gmx.de> <Pine.GSO.4.21.0209042342420.12135-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0209042342420.12135-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 04, 2002  23:58 -0400, Alexander Viro wrote:
> 	Making VFS aware of clustering (i.e. allowing filesystems to
> notice when we are trying to grab parent for some operation) _DOES_ make
> sense and at some point we will have to go through existing filesystems
> that attempt something of that kind and see what kind of interface would
> make sense.  Wanking about grand half-arsed schemes and plugging holes
> pointed to you with duct-tape and lots of handwaving, OTOH...

Al, have you looked at Peter's intent-based lookup code yet?  Trond
also expressed interest in something like this for NFS.

It essentially passes a bitflag with the intent of the lookup,
(e.g. create, mkdir, getattr, etc) so that you can optionally complete
the lookup and do the operation in one go.  The VFS patch to add
intent-based lookup (not for inclusion, just discussion) below.

Cheers, Andreas
============================
--- lum-pristine/include/linux/dcache.h	Thu Nov 22 14:46:18 2001
+++ lum/include/linux/dcache.h	Mon Aug 12 00:02:29 2002
@@ -6,6 +6,33 @@
 #include <asm/atomic.h>
 #include <linux/mount.h>
 
+#define IT_OPEN     (1)
+#define IT_CREAT    (1<<1)
+#define IT_MKDIR    (1<<2)
+#define IT_LINK     (1<<3)
+#define IT_SYMLINK  (1<<4)
+#define IT_UNLINK   (1<<5)
+#define IT_RMDIR    (1<<6)
+#define IT_RENAME   (1<<7)
+#define IT_RENAME2  (1<<8)
+#define IT_READDIR  (1<<9)
+#define IT_GETATTR  (1<<10)
+#define IT_SETATTR  (1<<11)
+#define IT_READLINK (1<<12)
+#define IT_MKNOD    (1<<13)
+#define IT_LOOKUP   (1<<14)
+
+struct lookup_intent {
+	int it_op;
+	int it_mode;
+	int it_disposition;
+	int it_status;
+	struct iattr *it_iattr;
+	__u64 it_lock_handle[2];
+	int it_lock_mode;
+	void *it_data;
+};
+
 /*
  * linux/include/linux/dcache.h
  *
@@ -78,6 +106,7 @@
 	unsigned long d_time;		/* used by d_revalidate */
 	struct dentry_operations  *d_op;
 	struct super_block * d_sb;	/* The root of the dentry tree */
+	struct lookup_intent *d_it;
 	unsigned long d_vfs_flags;
 	void * d_fsdata;		/* fs-specific data */
 	unsigned char d_iname[DNAME_INLINE_LEN]; /* small names */
@@ -91,6 +119,8 @@
 	int (*d_delete)(struct dentry *);
 	void (*d_release)(struct dentry *);
 	void (*d_iput)(struct dentry *, struct inode *);
+	int (*d_revalidate2)(struct dentry *, int, struct lookup_intent *);
+	void (*d_intent_release)(struct dentry *);
 };
 
 /* the dentry parameter passed to d_hash and d_compare is the parent
--- lum-pristine/include/linux/fs.h	Mon Aug 12 11:02:53 2002
+++ lum/include/linux/fs.h	Mon Aug 12 11:48:38 2002
@@ -536,6 +536,7 @@
 
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
+	struct lookup_intent    *f_intent;
 
 	/* preallocated helper kiobuf to speedup O_DIRECT */
 	struct kiobuf		*f_iobuf;
@@ -779,7 +780,9 @@
 extern int vfs_link(struct dentry *, struct inode *, struct dentry *);
 extern int vfs_rmdir(struct inode *, struct dentry *);
 extern int vfs_unlink(struct inode *, struct dentry *);
-extern int vfs_rename(struct inode *, struct dentry *, struct inode *, struct dentry *);
+int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
+		struct inode *new_dir, struct dentry *new_dentry,
+		struct lookup_intent *it);
 
 /*
  * File types
@@ -840,6 +843,7 @@
 struct inode_operations {
 	int (*create) (struct inode *,struct dentry *,int);
 	struct dentry * (*lookup) (struct inode *,struct dentry *);
+	struct dentry * (*lookup2) (struct inode *,struct dentry *, struct lookup_intent *);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
 	int (*symlink) (struct inode *,struct dentry *,const char *);
@@ -986,7 +990,7 @@
 extern struct vfsmount *kern_mount(struct file_system_type *);
 extern int may_umount(struct vfsmount *);
 extern long do_mount(char *, char *, char *, unsigned long, void *);
-
+struct vfsmount *do_kern_mount(char *type, int flags, char *name, void *data);
 #define kern_umount mntput
 
 extern int vfs_statfs(struct super_block *, struct statfs *);
@@ -1307,6 +1311,7 @@
 extern loff_t default_llseek(struct file *file, loff_t offset, int origin);
 
 extern int FASTCALL(__user_walk(const char *, unsigned, struct nameidata *));
+extern int FASTCALL(__user_walk_it(const char *, unsigned, struct nameidata *, struct lookup_intent *it));
 extern int FASTCALL(path_init(const char *, unsigned, struct nameidata *));
 extern int FASTCALL(path_walk(const char *, struct nameidata *));
 extern int FASTCALL(link_path_walk(const char *, struct nameidata *));
@@ -1317,6 +1322,8 @@
 extern struct dentry * lookup_hash(struct qstr *, struct dentry *);
 #define user_path_walk(name,nd)	 __user_walk(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, nd)
 #define user_path_walk_link(name,nd) __user_walk(name, LOOKUP_POSITIVE, nd)
+#define user_path_walk_it(name,nd,it)  __user_walk_it(name, LOOKUP_FOLLOW|LOOKUP_POSITIVE, nd, it)
+#define user_path_walk_link_it(name,nd,it) __user_walk_it(name, LOOKUP_POSITIVE, nd, it)
 
 extern void iput(struct inode *);
 extern void force_delete(struct inode *);
--- lum-pristine/fs/dcache.c	Mon Feb 25 14:38:08 2002
+++ lum/fs/dcache.c	Thu Aug  1 18:07:35 2002
@@ -617,6 +617,7 @@
 	dentry->d_op = NULL;
 	dentry->d_fsdata = NULL;
 	dentry->d_mounted = 0;
+	dentry->d_it = NULL;
 	INIT_LIST_HEAD(&dentry->d_hash);
 	INIT_LIST_HEAD(&dentry->d_lru);
 	INIT_LIST_HEAD(&dentry->d_subdirs);
--- lum-pristine/fs/nfsd/vfs.c	Fri Dec 21 12:41:55 2001
+++ lum/fs/nfsd/vfs.c	Thu Aug  1 18:07:35 2002
@@ -1285,7 +1285,7 @@
 			err = nfserr_perm;
 	} else
 #endif
-	err = vfs_rename(fdir, odentry, tdir, ndentry);
+	err = vfs_rename(fdir, odentry, tdir, ndentry, NULL);
 	if (!err && EX_ISSYNC(tfhp->fh_export)) {
 		nfsd_sync_dir(tdentry);
 		nfsd_sync_dir(fdentry);
--- lum-pristine/fs/namei.c	Mon Feb 25 14:38:09 2002
+++ lum/fs/namei.c	Mon Aug 12 11:47:56 2002
@@ -94,6 +94,14 @@
  * XEmacs seems to be relying on it...
  */
 
+void intent_release(struct dentry *de)
+{
+	if (de->d_op && de->d_op->d_intent_release)
+		de->d_op->d_intent_release(de);
+	de->d_it = NULL;
+}
+
+
 /* In order to reduce some races, while at the same time doing additional
  * checking and hopefully speeding things up, we copy filenames to the
  * kernel data space before using them..
@@ -260,10 +268,19 @@
  * Internal lookup() using the new generic dcache.
  * SMP-safe
  */
-static struct dentry * cached_lookup(struct dentry * parent, struct qstr * name, int flags)
+static struct dentry *cached_lookup(struct dentry *parent, struct qstr *name,
+				    int flags, struct lookup_intent *it)
 {
 	struct dentry * dentry = d_lookup(parent, name);
 
+	if (dentry && dentry->d_op && dentry->d_op->d_revalidate2) {
+		if (!dentry->d_op->d_revalidate2(dentry, flags, it) &&
+		    !d_invalidate(dentry)) {
+			dput(dentry);
+			dentry = NULL;
+		}
+		return dentry;
+	} else
 	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
 		if (!dentry->d_op->d_revalidate(dentry, flags) && !d_invalidate(dentry)) {
 			dput(dentry);
@@ -281,7 +298,8 @@
  * make sure that nobody added the entry to the dcache in the meantime..
  * SMP-safe
  */
-static struct dentry * real_lookup(struct dentry * parent, struct qstr * name, int flags)
+static struct dentry *real_lookup(struct dentry *parent, struct qstr *name,
+				  int flags, struct lookup_intent *it)
 {
 	struct dentry * result;
 	struct inode *dir = parent->d_inode;
@@ -300,6 +318,9 @@
 		result = ERR_PTR(-ENOMEM);
 		if (dentry) {
 			lock_kernel();
-			result = dir->i_op->lookup(dir, dentry);
+			if (dir->i_op->lookup2)
+				result = dir->i_op->lookup2(dir, dentry, it);
+			else
+				result = dir->i_op->lookup(dir, dentry);
 			unlock_kernel();
 			if (result)
@@ -321,6 +342,12 @@
 			dput(result);
 			result = ERR_PTR(-ENOENT);
 		}
+	} else if (result->d_op && result->d_op->d_revalidate2) {
+		if (!result->d_op->d_revalidate2(result, flags, it) &&
+		    !d_invalidate(result)) {
+			dput(result);
+			result = ERR_PTR(-ENOENT);
+		}
 	}
 	return result;
 }
@@ -445,7 +472,8 @@
  *
  * We expect 'base' to be positive and a directory.
  */
-int link_path_walk(const char * name, struct nameidata *nd)
+int link_path_walk_it(const char *name, struct nameidata *nd,
+		      struct lookup_intent *it)
 {
 	struct dentry *dentry;
 	struct inode *inode;
@@ -518,9 +546,9 @@
 				break;
 		}
 		/* This does the actual lookups.. */
-		dentry = cached_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
+		dentry = cached_lookup(nd->dentry, &this, LOOKUP_CONTINUE, NULL);
 		if (!dentry) {
-			dentry = real_lookup(nd->dentry, &this, LOOKUP_CONTINUE);
+			dentry = real_lookup(nd->dentry, &this, LOOKUP_CONTINUE, NULL);
 			err = PTR_ERR(dentry);
 			if (IS_ERR(dentry))
 				break;
@@ -554,7 +582,7 @@
 			nd->dentry = dentry;
 		}
 		err = -ENOTDIR; 
-		if (!inode->i_op->lookup)
+		if (!inode->i_op->lookup && !inode->i_op->lookup2)
 			break;
 		continue;
 		/* here ends the main loop */
@@ -581,9 +609,9 @@
 			if (err < 0)
 				break;
 		}
-		dentry = cached_lookup(nd->dentry, &this, 0);
+		dentry = cached_lookup(nd->dentry, &this, 0, it);
 		if (!dentry) {
-			dentry = real_lookup(nd->dentry, &this, 0);
+			dentry = real_lookup(nd->dentry, &this, 0, it);
 			err = PTR_ERR(dentry);
 			if (IS_ERR(dentry))
 				break;
@@ -607,7 +635,8 @@
 			goto no_inode;
 		if (lookup_flags & LOOKUP_DIRECTORY) {
 			err = -ENOTDIR; 
-			if (!inode->i_op || !inode->i_op->lookup)
+			if (!inode->i_op || (!inode->i_op->lookup &&
+					     !inode->i_op->lookup2))
 				break;
 		}
 		goto return_base;
@@ -626,6 +655,7 @@
 		else if (this.len == 2 && this.name[1] == '.')
 			nd->last_type = LAST_DOTDOT;
 return_base:
+		nd->dentry->d_it = it;
 		return 0;
 out_dput:
 		dput(dentry);
@@ -633,15 +663,29 @@
 	}
 	path_release(nd);
 return_err:
+	if (!err)
+		nd->dentry->d_it = it;
 	return err;
 }
 
+int link_path_walk(const char * name, struct nameidata *nd)
+{
+	return link_path_walk_it(name, nd, NULL);
+}
+
+int path_walk_it(const char * name, struct nameidata *nd, struct lookup_intent *it)
+{
+	current->total_link_count = 0;
+	return link_path_walk_it(name, nd, it);
+}
+
 int path_walk(const char * name, struct nameidata *nd)
 {
 	current->total_link_count = 0;
-	return link_path_walk(name, nd);
+	return link_path_walk_it(name, nd, NULL);
 }
 
+
 /* SMP-safe */
 /* returns 1 if everything is done */
 static int __emul_lookup_dentry(const char *name, struct nameidata *nd)
@@ -742,7 +786,8 @@
  * needs parent already locked. Doesn't follow mounts.
  * SMP-safe.
  */
-struct dentry * lookup_hash(struct qstr *name, struct dentry * base)
+struct dentry * lookup_hash_it(struct qstr *name, struct dentry * base,
+			       struct lookup_intent *it)
 {
 	struct dentry * dentry;
 	struct inode *inode;
@@ -765,13 +810,16 @@
 			goto out;
 	}
 
-	dentry = cached_lookup(base, name, 0);
+	dentry = cached_lookup(base, name, 0, it);
 	if (!dentry) {
 		struct dentry *new = d_alloc(base, name);
 		dentry = ERR_PTR(-ENOMEM);
 		if (!new)
 			goto out;
 		lock_kernel();
+		if (inode->i_op->lookup2)
+			dentry = inode->i_op->lookup2(inode, new, it);
+		else
 		dentry = inode->i_op->lookup(inode, new);
 		unlock_kernel();
 		if (!dentry)
@@ -783,6 +831,12 @@
 	return dentry;
 }
 
+struct dentry * lookup_hash(struct qstr *name, struct dentry * base)
+{
+	return lookup_hash_it(name, base, NULL);
+}
+
+
 /* SMP-safe */
 struct dentry * lookup_one_len(const char * name, struct dentry * base, int len)
 {
@@ -804,7 +858,7 @@
 	}
 	this.hash = end_name_hash(hash);
 
-	return lookup_hash(&this, base);
+	return lookup_hash_it(&this, base, NULL);
 access:
 	return ERR_PTR(-EACCES);
 }
@@ -836,6 +890,23 @@
 	return err;
 }
 
+int __user_walk_it(const char *name, unsigned flags, struct nameidata *nd,
+		   struct lookup_intent *it)
+{
+	char *tmp;
+	int err;
+
+	tmp = getname(name);
+	err = PTR_ERR(tmp);
+	if (!IS_ERR(tmp)) {
+		err = 0;
+		if (path_init(tmp, flags, nd))
+			err = path_walk_it(tmp, nd, it);
+		putname(tmp);
+	}
+	return err;
+}
+
 /*
  * It's inline, so penalty for filesystems that don't use sticky bit is
  * minimal.
@@ -970,7 +1041,8 @@
  * for symlinks (where the permissions are checked later).
  * SMP-safe
  */
-int open_namei(const char * pathname, int flag, int mode, struct nameidata *nd)
+int open_namei_it(const char *pathname, int flag, int mode,
+		  struct nameidata *nd, struct lookup_intent *it)
 {
 	int acc_mode, error = 0;
 	struct inode *inode;
@@ -984,17 +1056,22 @@
 	 * The simplest case - just a plain lookup.
 	 */
 	if (!(flag & O_CREAT)) {
 		if (path_init(pathname, lookup_flags(flag), nd))
-			error = path_walk(pathname, nd);
+			error = path_walk_it(pathname, nd, it);
 		if (error)
 			return error;
 		dentry = nd->dentry;
+		dentry->d_it = it;
 		goto ok;
 	}
 
 	/*
 	 * Create - we need to know the parent.
 	 */
+	if (it) {
+		it->it_mode = mode;
+		it->it_op |= IT_CREAT;
+	}
 	if (path_init(pathname, LOOKUP_PARENT, nd))
 		error = path_walk(pathname, nd);
 	if (error)
@@ -1011,7 +1089,7 @@
 
 	dir = nd->dentry;
 	down(&dir->d_inode->i_sem);
-	dentry = lookup_hash(&nd->last, nd->dentry);
+	dentry = lookup_hash_it(&nd->last, nd->dentry, it);
 
 do_last:
 	error = PTR_ERR(dentry);
@@ -1020,6 +1098,8 @@
 		goto exit;
 	}
 
+	dentry->d_it = it;
+	dentry->d_it->it_mode = mode;
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode) {
 		error = vfs_create(dir->d_inode, dentry,
@@ -1139,8 +1219,10 @@
 	return 0;
 
 exit_dput:
+	intent_release(dentry);
 	dput(dentry);
 exit:
+	intent_release(nd->dentry);
 	path_release(nd);
 	return error;
 
@@ -1160,6 +1242,8 @@
 	 */
 	UPDATE_ATIME(dentry->d_inode);
 	error = dentry->d_inode->i_op->follow_link(dentry, nd);
+	if (error)
+		intent_release(dentry);
 	dput(dentry);
 	if (error)
 		return error;
@@ -1181,13 +1265,20 @@
 	}
 	dir = nd->dentry;
 	down(&dir->d_inode->i_sem);
-	dentry = lookup_hash(&nd->last, nd->dentry);
+	dentry = lookup_hash_it(&nd->last, nd->dentry, NULL);
 	putname(nd->last.name);
 	goto do_last;
 }
 
+int open_namei(const char *pathname, int flag, int mode, struct nameidata *nd)
+{
+	return open_namei_it(pathname, flag, mode, nd, NULL);
+}
+
+
 /* SMP-safe */
-static struct dentry *lookup_create(struct nameidata *nd, int is_dir)
+static struct dentry *lookup_create(struct nameidata *nd, int is_dir,
+				    struct lookup_intent *it)
 {
 	struct dentry *dentry;
 
@@ -1195,7 +1286,7 @@
 	dentry = ERR_PTR(-EEXIST);
 	if (nd->last_type != LAST_NORM)
 		goto fail;
-	dentry = lookup_hash(&nd->last, nd->dentry);
+	dentry = lookup_hash_it(&nd->last, nd->dentry, it);
 	if (IS_ERR(dentry))
 		goto fail;
 	if (!is_dir && nd->last.name[nd->last.len] && !dentry->d_inode)
@@ -1241,6 +1332,7 @@
 	char * tmp;
 	struct dentry * dentry;
 	struct nameidata nd;
+	struct lookup_intent it = { .it_op = IT_MKNOD, .it_mode = mode };
 
 	if (S_ISDIR(mode))
 		return -EPERM;
@@ -1252,11 +1344,12 @@
 		error = path_walk(tmp, &nd);
 	if (error)
 		goto out;
-	dentry = lookup_create(&nd, 0);
+	dentry = lookup_create(&nd, 0, &it);
 	error = PTR_ERR(dentry);
 
 	mode &= ~current->fs->umask;
 	if (!IS_ERR(dentry)) {
+		dentry->d_it = &it;
 		switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
 			error = vfs_create(nd.dentry->d_inode,dentry,mode);
@@ -1270,6 +1363,7 @@
 		default:
 			error = -EINVAL;
 		}
+		intent_release(dentry);
 		dput(dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
@@ -1310,6 +1404,7 @@
 {
 	int error = 0;
 	char * tmp;
+	struct lookup_intent it = { .it_op = IT_MKDIR, .it_mode = mode };
 
 	tmp = getname(pathname);
 	error = PTR_ERR(tmp);
@@ -1321,11 +1416,13 @@
 			error = path_walk(tmp, &nd);
 		if (error)
 			goto out;
-		dentry = lookup_create(&nd, 1);
+		dentry = lookup_create(&nd, 1, &it);
 		error = PTR_ERR(dentry);
 		if (!IS_ERR(dentry)) {
+			dentry->d_it = &it;
 			error = vfs_mkdir(nd.dentry->d_inode, dentry,
 					  mode & ~current->fs->umask);
+			intent_release(dentry);
 			dput(dentry);
 		}
 		up(&nd.dentry->d_inode->i_sem);
@@ -1407,6 +1504,7 @@
 	char * name;
 	struct dentry *dentry;
 	struct nameidata nd;
+	struct lookup_intent it = { .it_op = IT_RMDIR };
 
 	name = getname(pathname);
 	if(IS_ERR(name))
@@ -1429,10 +1527,12 @@
 			goto exit1;
 	}
 	down(&nd.dentry->d_inode->i_sem);
-	dentry = lookup_hash(&nd.last, nd.dentry);
+	dentry = lookup_hash_it(&nd.last, nd.dentry, &it);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
+		dentry->d_it = &it;
 		error = vfs_rmdir(nd.dentry->d_inode, dentry);
+		intent_release(dentry);
 		dput(dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
@@ -1476,6 +1576,7 @@
 	char * name;
 	struct dentry *dentry;
 	struct nameidata nd;
+	struct lookup_intent it = { .it_op = IT_UNLINK };
 
 	name = getname(pathname);
 	if(IS_ERR(name))
@@ -1489,14 +1590,16 @@
 	if (nd.last_type != LAST_NORM)
 		goto exit1;
 	down(&nd.dentry->d_inode->i_sem);
-	dentry = lookup_hash(&nd.last, nd.dentry);
+	dentry = lookup_hash_it(&nd.last, nd.dentry, &it);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
+		dentry->d_it = &it;
 		/* Why not before? Because we want correct error value */
 		if (nd.last.name[nd.last.len])
 			goto slashes;
 		error = vfs_unlink(nd.dentry->d_inode, dentry);
 	exit2:
+		intent_release(dentry);
 		dput(dentry);
 	}
 	up(&nd.dentry->d_inode->i_sem);
@@ -1543,6 +1646,7 @@
 	int error = 0;
 	char * from;
 	char * to;
+	struct lookup_intent it = { .it_op = IT_SYMLINK };
 
 	from = getname(oldname);
 	if(IS_ERR(from))
@@ -1557,10 +1661,13 @@
 			error = path_walk(to, &nd);
 		if (error)
 			goto out;
-		dentry = lookup_create(&nd, 0);
+		it.it_data = from;
+		dentry = lookup_create(&nd, 0, &it);
 		error = PTR_ERR(dentry);
 		if (!IS_ERR(dentry)) {
+			dentry->d_it = &it;
 			error = vfs_symlink(nd.dentry->d_inode, dentry, from);
+			intent_release(dentry);
 			dput(dentry);
 		}
 		up(&nd.dentry->d_inode->i_sem);
@@ -1626,6 +1732,7 @@
 	int error;
 	char * from;
 	char * to;
+	struct lookup_intent it = { .it_op = IT_LINK };
 
 	from = getname(oldname);
 	if(IS_ERR(from))
@@ -1648,10 +1755,12 @@
 		error = -EXDEV;
 		if (old_nd.mnt != nd.mnt)
 			goto out_release;
-		new_dentry = lookup_create(&nd, 0);
+		new_dentry = lookup_create(&nd, 0, &it);
 		error = PTR_ERR(new_dentry);
 		if (!IS_ERR(new_dentry)) {
+			new_dentry->d_it = &it;
 			error = vfs_link(old_nd.dentry, nd.dentry->d_inode, new_dentry);
+			intent_release(new_dentry);
 			dput(new_dentry);
 		}
 		up(&nd.dentry->d_inode->i_sem);
@@ -1694,7 +1803,8 @@
  *	   locking].
  */
 int vfs_rename_dir(struct inode *old_dir, struct dentry *old_dentry,
-	       struct inode *new_dir, struct dentry *new_dentry)
+		   struct inode *new_dir, struct dentry *new_dentry,
+		   struct lookup_intent *it)
 {
 	int error;
 	struct inode *target;
@@ -1748,12 +1858,14 @@
 	} else
 		double_down(&old_dir->i_zombie,
 			    &new_dir->i_zombie);
+	new_dentry->d_it = it;
 	if (IS_DEADDIR(old_dir)||IS_DEADDIR(new_dir))
 		error = -ENOENT;
 	else if (d_mountpoint(old_dentry)||d_mountpoint(new_dentry))
 		error = -EBUSY;
 	else 
 		error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
+	intent_release(new_dentry);
 	if (target) {
 		if (!error)
 			target->i_flags |= S_DEAD;
@@ -1775,7 +1887,8 @@
 }
 
 int vfs_rename_other(struct inode *old_dir, struct dentry *old_dentry,
-	       struct inode *new_dir, struct dentry *new_dentry)
+		     struct inode *new_dir, struct dentry *new_dentry,
+		     struct lookup_intent *it)
 {
 	int error;
 
@@ -1802,10 +1915,12 @@
 	DQUOT_INIT(old_dir);
 	DQUOT_INIT(new_dir);
 	double_down(&old_dir->i_zombie, &new_dir->i_zombie);
+	new_dentry->d_it = it;
 	if (d_mountpoint(old_dentry)||d_mountpoint(new_dentry))
 		error = -EBUSY;
 	else
 		error = old_dir->i_op->rename(old_dir, old_dentry, new_dir, new_dentry);
+	intent_release(new_dentry);
 	double_up(&old_dir->i_zombie, &new_dir->i_zombie);
 	if (error)
 		return error;
@@ -1817,13 +1932,14 @@
 }
 
 int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
-	       struct inode *new_dir, struct dentry *new_dentry)
+	       struct inode *new_dir, struct dentry *new_dentry,
+	       struct lookup_intent *it)
 {
 	int error;
 	if (S_ISDIR(old_dentry->d_inode->i_mode))
-		error = vfs_rename_dir(old_dir,old_dentry,new_dir,new_dentry);
+		error = vfs_rename_dir(old_dir,old_dentry,new_dir,new_dentry,it);
 	else
-		error = vfs_rename_other(old_dir,old_dentry,new_dir,new_dentry);
+		error = vfs_rename_other(old_dir,old_dentry,new_dir,new_dentry,it);
 	if (!error) {
 		if (old_dir == new_dir)
 			inode_dir_notify(old_dir, DN_RENAME);
@@ -1840,6 +1956,7 @@
 	int error = 0;
 	struct dentry * old_dir, * new_dir;
 	struct dentry * old_dentry, *new_dentry;
+	struct lookup_intent it = { .it_op = IT_RENAME };
 	struct nameidata oldnd, newnd;
 
 	if (path_init(oldname, LOOKUP_PARENT, &oldnd))
@@ -1868,7 +1985,7 @@
 
 	double_lock(new_dir, old_dir);
 
-	old_dentry = lookup_hash(&oldnd.last, old_dir);
+	old_dentry = lookup_hash_it(&oldnd.last, old_dir, &it);
 	error = PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
 		goto exit3;
@@ -1884,18 +2003,21 @@
 		if (newnd.last.name[newnd.last.len])
 			goto exit4;
 	}
-	new_dentry = lookup_hash(&newnd.last, new_dir);
+	it.it_op = IT_RENAME2;
+	new_dentry = lookup_hash_it(&newnd.last, new_dir, &it);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto exit4;
 
 	lock_kernel();
 	error = vfs_rename(old_dir->d_inode, old_dentry,
-				   new_dir->d_inode, new_dentry);
+				   new_dir->d_inode, new_dentry, &it);
 	unlock_kernel();
 
+	intent_release(new_dentry);
 	dput(new_dentry);
 exit4:
+	intent_release(old_dentry);
 	dput(old_dentry);
 exit3:
 	double_up(&new_dir->d_inode->i_sem, &old_dir->d_inode->i_sem);
--- lum-pristine/fs/open.c	Fri Oct 12 16:48:42 2001
+++ lum/fs/open.c	Sun Aug 11 15:26:29 2002
@@ -19,6 +19,9 @@
 #include <asm/uaccess.h>
 
 #define special_file(m) (S_ISCHR(m)||S_ISBLK(m)||S_ISFIFO(m)||S_ISSOCK(m))
+extern int path_walk_it(const char *name, struct nameidata *nd,
+			struct lookup_intent *it);
+extern void intent_release(struct dentry *de);
 
 int vfs_statfs(struct super_block *sb, struct statfs *buf)
 {
@@ -94,14 +97,16 @@
 	struct nameidata nd;
 	struct inode * inode;
 	int error;
+	struct lookup_intent it = { .it_op = IT_SETATTR };
 
 	error = -EINVAL;
 	if (length < 0)	/* sorry, but loff_t says... */
 		goto out;
 
-	error = user_path_walk(path, &nd);
+	error = user_path_walk_it(path, &nd, &it);
 	if (error)
 		goto out;
+	nd.dentry->d_it = &it;
 	inode = nd.dentry->d_inode;
 
 	/* For directories it's -EISDIR, for other non-regulars - -EINVAL */
@@ -144,6 +149,7 @@
 	put_write_access(inode);
 
 dput_and_out:
+	intent_release(nd.dentry);
 	path_release(&nd);
 out:
 	return error;
@@ -235,10 +241,12 @@
 	struct nameidata nd;
 	struct inode * inode;
 	struct iattr newattrs;
+	struct lookup_intent it = { .it_op = IT_SETATTR };
 
-	error = user_path_walk(filename, &nd);
+	error = user_path_walk_it(filename, &nd, &it);
 	if (error)
 		goto out;
+	nd.dentry->d_it = &it;
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
@@ -262,6 +270,7 @@
 	}
 	error = notify_change(nd.dentry, &newattrs);
 dput_and_out:
+	intent_release(nd.dentry);
 	path_release(&nd);
 out:
 	return error;
@@ -279,11 +288,13 @@
 	struct nameidata nd;
 	struct inode * inode;
 	struct iattr newattrs;
+	struct lookup_intent it = { .it_op = IT_SETATTR };
 
-	error = user_path_walk(filename, &nd);
+	error = user_path_walk_it(filename, &nd, &it);
 
 	if (error)
 		goto out;
+	nd.dentry->d_it = &it;
 	inode = nd.dentry->d_inode;
 
 	error = -EROFS;
@@ -306,6 +317,7 @@
 	}
 	error = notify_change(nd.dentry, &newattrs);
 dput_and_out:
+	intent_release(nd.dentry);
 	path_release(&nd);
 out:
 	return error;
@@ -322,6 +334,7 @@
 	int old_fsuid, old_fsgid;
 	kernel_cap_t old_cap;
 	int res;
+	struct lookup_intent it = { .it_op = IT_GETATTR };
 
 	if (mode & ~S_IRWXO)	/* where's F_OK, X_OK, W_OK, R_OK? */
 		return -EINVAL;
@@ -339,13 +352,14 @@
 	else
 		current->cap_effective = current->cap_permitted;
 
-	res = user_path_walk(filename, &nd);
+	res = user_path_walk_it(filename, &nd, &it);
 	if (!res) {
 		res = permission(nd.dentry->d_inode, mode);
 		/* SuS v2 requires we report a read only fs too */
 		if(!res && (mode & S_IWOTH) && IS_RDONLY(nd.dentry->d_inode)
 		   && !special_file(nd.dentry->d_inode->i_mode))
 			res = -EROFS;
+		intent_release(nd.dentry);
 		path_release(&nd);
 	}
 
@@ -361,6 +375,7 @@
 	int error;
 	struct nameidata nd;
 	char *name;
+	struct lookup_intent it = { .it_op = IT_GETATTR };
 
 	name = getname(filename);
 	error = PTR_ERR(name);
@@ -369,11 +384,12 @@
 
 	error = 0;
 	if (path_init(name,LOOKUP_POSITIVE|LOOKUP_FOLLOW|LOOKUP_DIRECTORY,&nd))
-		error = path_walk(name, &nd);
+		error = path_walk_it(name, &nd, &it);
 	putname(name);
 	if (error)
 		goto out;
 
+	nd.dentry->d_it = &it;
 	error = permission(nd.dentry->d_inode,MAY_EXEC);
 	if (error)
 		goto dput_and_out;
@@ -381,6 +397,7 @@
 	set_fs_pwd(current->fs, nd.mnt, nd.dentry);
 
 dput_and_out:
+	intent_release(nd.dentry);
 	path_release(&nd);
 out:
 	return error;
@@ -421,6 +438,7 @@
 	int error;
 	struct nameidata nd;
 	char *name;
+	struct lookup_intent it = { .it_op = IT_GETATTR };
 
 	name = getname(filename);
 	error = PTR_ERR(name);
@@ -429,11 +447,12 @@
 
 	path_init(name, LOOKUP_POSITIVE | LOOKUP_FOLLOW |
 		      LOOKUP_DIRECTORY | LOOKUP_NOALT, &nd);
-	error = path_walk(name, &nd);	
+	error = path_walk_it(name, &nd, &it);
 	putname(name);
 	if (error)
 		goto out;
 
+	nd.dentry->d_it = &it;
 	error = permission(nd.dentry->d_inode,MAY_EXEC);
 	if (error)
 		goto dput_and_out;
@@ -446,6 +465,7 @@
 	set_fs_altroot();
 	error = 0;
 dput_and_out:
+	intent_release(nd.dentry);
 	path_release(&nd);
 out:
 	return error;
@@ -490,12 +510,14 @@
 	struct inode * inode;
 	int error;
 	struct iattr newattrs;
+	struct lookup_intent it = { .it_op = IT_SETATTR };
 
-	error = user_path_walk(filename, &nd);
+	error = user_path_walk_it(filename, &nd, &it);
 	if (error)
 		goto out;
 	inode = nd.dentry->d_inode;
 
+	nd.dentry->d_it = &it;
 	error = -EROFS;
 	if (IS_RDONLY(inode))
 		goto dput_and_out;
@@ -511,6 +532,7 @@
 	error = notify_change(nd.dentry, &newattrs);
 
 dput_and_out:
+	intent_release(nd.dentry);
 	path_release(&nd);
 out:
 	return error;
@@ -580,10 +602,13 @@
 {
 	struct nameidata nd;
 	int error;
+	struct lookup_intent it = { .it_op = IT_SETATTR };
 
-	error = user_path_walk(filename, &nd);
+	error = user_path_walk_it(filename, &nd, &it);
 	if (!error) {
+		nd.dentry->d_it = &it;
 		error = chown_common(nd.dentry, user, group);
+		intent_release(nd.dentry);
 		path_release(&nd);
 	}
 	return error;
@@ -593,10 +618,13 @@
 {
 	struct nameidata nd;
 	int error;
+	struct lookup_intent it = { .it_op = IT_SETATTR };
 
-	error = user_path_walk_link(filename, &nd);
+	error = user_path_walk_link_it(filename, &nd, &it);
 	if (!error) {
+		nd.dentry->d_it = &it;
 		error = chown_common(nd.dentry, user, group);
+		intent_release(nd.dentry);
 		path_release(&nd);
 	}
 	return error;
@@ -630,10 +658,16 @@
  * for the internal routines (ie open_namei()/follow_link() etc). 00 is
  * used by symlinks.
  */
+extern int open_namei_it(const char *filename, int namei_flags, int mode,
+			 struct nameidata *nd, struct lookup_intent *it);
+struct file *dentry_open_it(struct dentry *dentry, struct vfsmount *mnt,
+			    int flags, struct lookup_intent *it);
+
 struct file *filp_open(const char * filename, int flags, int mode)
 {
 	int namei_flags, error;
 	struct nameidata nd;
+	struct lookup_intent it = { .it_op = IT_OPEN };
 
 	namei_flags = flags;
 	if ((namei_flags+1) & O_ACCMODE)
@@ -641,14 +675,15 @@
 	if (namei_flags & O_TRUNC)
 		namei_flags |= 2;
 
-	error = open_namei(filename, namei_flags, mode, &nd);
-	if (!error)
-		return dentry_open(nd.dentry, nd.mnt, flags);
+	error = open_namei_it(filename, namei_flags, mode, &nd, &it);
+	if (error)
+		return ERR_PTR(error);
 
-	return ERR_PTR(error);
+	return dentry_open_it(nd.dentry, nd.mnt, flags, &it);
 }
 
-struct file *dentry_open(struct dentry *dentry, struct vfsmount *mnt, int flags)
+struct file *dentry_open_it(struct dentry *dentry, struct vfsmount *mnt,
+			    int flags, struct lookup_intent *it)
 {
 	struct file * f;
 	struct inode *inode;
@@ -691,6 +726,7 @@
 	}
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
+	intent_release(dentry);
 	return f;
 
 cleanup_all:
@@ -705,11 +741,17 @@
 cleanup_file:
 	put_filp(f);
 cleanup_dentry:
+	intent_release(dentry);
 	dput(dentry);
 	mntput(mnt);
 	return ERR_PTR(error);
 }
 
+struct file *dentry_open(struct dentry *dentry, struct vfsmount *mnt, int flags)
+{
+	return dentry_open_it(dentry, mnt, flags, NULL);
+}
+
 /*
  * Find an empty file descriptor entry, and mark it busy.
  */
--- lum-pristine/fs/stat.c	Thu Sep 13 19:04:43 2001
+++ lum/fs/stat.c	Mon Aug 12 00:04:39 2002
@@ -13,6 +13,7 @@
 
 #include <asm/uaccess.h>
 
+extern void intent_release(struct dentry *de);
 /*
  * Revalidate the inode. This is required for proper NFS attribute caching.
  */
@@ -135,13 +135,15 @@
 asmlinkage long sys_stat(char * filename, struct __old_kernel_stat * statbuf)
 {
 	struct nameidata nd;
+	struct lookup_intent it = { .it_op = IT_GETATTR };
 	int error;
 
-	error = user_path_walk(filename, &nd);
+	error = user_path_walk_it(filename, &nd, &it);
 	if (!error) {
 		error = do_revalidate(nd.dentry);
 		if (!error)
 			error = cp_old_stat(nd.dentry->d_inode, statbuf);
+		intent_release(nd.dentry);
 		path_release(&nd);
 	}
 	return error;
@@ -151,13 +153,15 @@
 asmlinkage long sys_newstat(char * filename, struct stat * statbuf)
 {
 	struct nameidata nd;
+	struct lookup_intent it = { .it_op = IT_GETATTR };
 	int error;
 
-	error = user_path_walk(filename, &nd);
+	error = user_path_walk_it(filename, &nd, &it);
 	if (!error) {
 		error = do_revalidate(nd.dentry);
 		if (!error)
 			error = cp_new_stat(nd.dentry->d_inode, statbuf);
+		intent_release(nd.dentry);
 		path_release(&nd);
 	}
 	return error;
@@ -172,13 +176,15 @@
 asmlinkage long sys_lstat(char * filename, struct __old_kernel_stat * statbuf)
 {
 	struct nameidata nd;
+	struct lookup_intent it = { .it_op = IT_GETATTR };
 	int error;
 
-	error = user_path_walk_link(filename, &nd);
+	error = user_path_walk_link_it(filename, &nd, &it);
 	if (!error) {
 		error = do_revalidate(nd.dentry);
 		if (!error)
 			error = cp_old_stat(nd.dentry->d_inode, statbuf);
+		intent_release(nd.dentry);
 		path_release(&nd);
 	}
 	return error;
@@ -189,13 +195,15 @@
 asmlinkage long sys_newlstat(char * filename, struct stat * statbuf)
 {
 	struct nameidata nd;
+	struct lookup_intent it = { .it_op = IT_GETATTR };
 	int error;
 
-	error = user_path_walk_link(filename, &nd);
+	error = user_path_walk_link_it(filename, &nd, &it);
 	if (!error) {
 		error = do_revalidate(nd.dentry);
 		if (!error)
 			error = cp_new_stat(nd.dentry->d_inode, statbuf);
+		intent_release(nd.dentry);
 		path_release(&nd);
 	}
 	return error;
@@ -247,20 +255,21 @@
 {
 	struct nameidata nd;
 	int error;
+	struct lookup_intent it = { .it_op = IT_READLINK };
 
 	if (bufsiz <= 0)
 		return -EINVAL;
 
-	error = user_path_walk_link(path, &nd);
+	error = user_path_walk_link_it(path, &nd, &it);
 	if (!error) {
 		struct inode * inode = nd.dentry->d_inode;
-
 		error = -EINVAL;
 		if (inode->i_op && inode->i_op->readlink &&
 		    !(error = do_revalidate(nd.dentry))) {
 			UPDATE_ATIME(inode);
 			error = inode->i_op->readlink(nd.dentry, buf, bufsiz);
 		}
+		intent_release(nd.dentry);
 		path_release(&nd);
 	}
 	return error;
@@ -333,12 +342,14 @@
 {
 	struct nameidata nd;
 	int error;
+	struct lookup_intent it = { .it_op = IT_GETATTR };
 
-	error = user_path_walk(filename, &nd);
+	error = user_path_walk_it(filename, &nd, &it);
 	if (!error) {
 		error = do_revalidate(nd.dentry);
 		if (!error)
 			error = cp_new_stat64(nd.dentry->d_inode, statbuf);
+		intent_release(nd.dentry);
 		path_release(&nd);
 	}
 	return error;
@@ -348,12 +359,14 @@
 {
 	struct nameidata nd;
 	int error;
+	struct lookup_intent it = { .it_op = IT_GETATTR };
 
-	error = user_path_walk_link(filename, &nd);
+	error = user_path_walk_link_it(filename, &nd, &it);
 	if (!error) {
 		error = do_revalidate(nd.dentry);
 		if (!error)
 			error = cp_new_stat64(nd.dentry->d_inode, statbuf);
+		intent_release(nd.dentry);
 		path_release(&nd);
 	}
 	return error;
@@ -363,6 +376,7 @@
 {
 	struct file * f;
 	int err = -EBADF;
+	struct lookup_intent it = { .it_op = IT_GETATTR };
 
 	f = fget(fd);
 	if (f) {
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

