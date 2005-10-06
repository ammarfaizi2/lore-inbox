Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVJFOih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVJFOih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbVJFOig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:38:36 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:25350 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751039AbVJFOig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:38:36 -0400
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
CC: trond.myklebust@fys.uio.no
Subject: [RFC] atomic create+open
Message-Id: <E1ENWt1-000363-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 06 Oct 2005 16:38:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently it's impossible to implement a network filesystem that is

  a) served by an unprivileged userspace process

  b) supports "strange" open semantics, e.g.:

       open("foo", O_WRONLY | O_CREAT, 0400);

  c) not overly "hacky"

The basic problem is that because of a) permission checking cannot be
separated from the actual operations.

By the time the ->open method is called, the file has been created
with a read-only mode, and the server won't be able to open it in
write mode.

Several hacks come to mind for solving this, but these have severe
problems and are excluded.

One approach for solving this properly is to add a new atomic
create+open method to inode operations.  The prototype would be a
merger of ->create() and ->open, like this:

  int (*create_open) (struct inode *dir, struct dentry *dentry, int mode,
                      struct file *filp);

The below patch (against -mm) is a first try at implementing the VFS
part of this.  But at this stage I'm more interested in opinions about
the interface, rather than about the implementation.

A different approach is to extend the open_intents structure and allow
the filesystem to do the open from ->create(), but this is a much less
clean interface. Trond Myklebust has a patch that does this (no longer
applies):

  http://client.linux-nfs.org/Linux-2.6.x/2.6.12/linux-2.6.12-63-open_file_intents.dif

Comments about either solution are appreciated.

Thanks,
Miklos

Index: linux/fs/namei.c
===================================================================
--- linux.orig/fs/namei.c	2005-10-05 16:59:46.000000000 +0200
+++ linux/fs/namei.c	2005-10-06 15:18:18.000000000 +0200
@@ -28,6 +28,7 @@
 #include <linux/syscalls.h>
 #include <linux/mount.h>
 #include <linux/audit.h>
+#include <linux/file.h>
 #include <asm/namei.h>
 #include <asm/uaccess.h>
 
@@ -1394,6 +1395,91 @@ int may_open(struct nameidata *nd, int a
 	return 0;
 }
 
+static int vfs_create_open(struct inode *dir, struct dentry *dentry, int flag,
+			   int mode, struct nameidata *nd, struct file *f)
+{
+	struct inode *inode;
+	struct nameidata tmpnd;
+	int error = may_create(dir, dentry, nd);
+	if (error)
+		return error;
+
+	mode &= S_IALLUGO;
+	mode |= S_IFREG;
+	error = security_inode_create(dir, dentry, mode);
+	if (error)
+		return error;
+
+	f->f_mode = ((f->f_flags+1) & O_ACCMODE) | FMODE_LSEEK |
+				FMODE_PREAD | FMODE_PWRITE;
+
+	f->f_mapping = NULL;
+	f->f_dentry = dget(dentry);
+	f->f_vfsmnt = mntget(nd->mnt);
+	f->f_pos = 0;
+	f->f_op = NULL;
+	file_move(f, &dir->i_sb->s_files);
+
+	DQUOT_INIT(dir);
+	error = dir->i_op->create_open(dir, dentry, mode, f);
+	if (error)
+		goto out_dput;
+
+	fsnotify_create(dir, dentry->d_name.name);
+	inode = dentry->d_inode;
+	if (!f->f_mapping)
+		f->f_mapping = inode->i_mapping;
+	if (!f->f_op)
+		f->f_op = fops_get(inode->i_fop);
+
+	flag &= ~O_TRUNC;
+	tmpnd = *nd;
+	tmpnd.dentry = dentry;
+
+	/* Shouldn't fail, just go though the motions (security hook, ...) */
+	error = may_open(&tmpnd, 0, flag);
+	if (error)
+		goto out_release;
+
+	if (f->f_mode & FMODE_WRITE) {
+		/* Should not fail */
+		error = get_write_access(inode);
+		if (error)
+			goto out_release;
+	}
+
+	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
+
+	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
+
+	/* NB: we're sure to have correct a_ops only after f_op->open */
+	if (f->f_flags & O_DIRECT) {
+		if (!f->f_mapping->a_ops ||
+		    ((!f->f_mapping->a_ops->direct_IO) &&
+		    (!f->f_mapping->a_ops->get_xip_page))) {
+			error = -EINVAL;
+			goto out_put_write_access;
+		}
+	}
+	return 0;
+
+ out_put_write_access:
+	if (f->f_mode & FMODE_WRITE)
+		put_write_access(inode);
+ out_release:
+	if (f->f_op && f->f_op->release)
+		f->f_op->release(inode, f);
+
+	fops_put(f->f_op);
+	file_kill(f);
+ out_dput:
+	dput(f->f_dentry);
+	mntput(f->f_vfsmnt);
+	f->f_dentry = NULL;
+	f->f_vfsmnt = NULL;
+	return error;
+}
+
 /*
  *	open_namei()
  *
@@ -1408,7 +1494,8 @@ int may_open(struct nameidata *nd, int a
  * for symlinks (where the permissions are checked later).
  * SMP-safe
  */
-int open_namei(const char * pathname, int flag, int mode, struct nameidata *nd)
+static int open_namei(const char * pathname, int flag, int mode,
+		      struct nameidata *nd, struct file *f)
 {
 	int acc_mode, error = 0;
 	struct path path;
@@ -1469,6 +1556,16 @@ do_last:
 	if (!path.dentry->d_inode) {
 		if (!IS_POSIXACL(dir->d_inode))
 			mode &= ~current->fs->umask;
+
+		if (dir->d_inode->i_op && dir->d_inode->i_op->create_open) {
+			error = vfs_create_open(dir->d_inode, path.dentry,
+						flag, mode, nd, f);
+			up(&dir->d_inode->i_sem);
+			dput(nd->dentry);
+			nd->dentry = path.dentry;
+			goto exit;
+		}
+
 		error = vfs_create(dir->d_inode, path.dentry, mode, nd);
 		up(&dir->d_inode->i_sem);
 		dput(nd->dentry);
@@ -1509,7 +1606,7 @@ ok:
 	error = may_open(nd, acc_mode, flag);
 	if (error)
 		goto exit;
-	return 0;
+	return __dentry_open(nd->dentry, nd->mnt, f);
 
 exit_dput:
 	dput_path(&path, nd);
@@ -1561,6 +1658,59 @@ do_link:
 	goto do_last;
 }
 
+/*
+ * Note that while the flag value (low two bits) for sys_open means:
+ *	00 - read-only
+ *	01 - write-only
+ *	10 - read-write
+ *	11 - special
+ * it is changed into
+ *	00 - no permissions needed
+ *	01 - read-permission
+ *	10 - write-permission
+ *	11 - read-write
+ * for the internal routines (ie open_namei()/follow_link() etc). 00 is
+ * used by symlinks.
+ */
+struct file *filp_open(const char * filename, int flags, int mode)
+{
+	int namei_flags, error;
+	struct nameidata nd;
+	struct file *f;
+	static int warned;
+
+	/*
+	 * Access mode of 3 had some old uses, that are probably not
+	 * applicable anymore.  For now just warn about deprecation.
+	 * Later it can be changed to return -EINVAL.
+	 */
+	if ((flags & O_ACCMODE) == 3 && warned < 5) {
+		warned++;
+		printk(KERN_WARNING "Warning: '%s' (pid=%i) uses deprecated "
+				"open flags, please report!\n",
+			current->comm, current->tgid);
+	}
+	namei_flags = flags;
+	if ((namei_flags+1) & O_ACCMODE)
+		namei_flags++;
+	if (namei_flags & O_TRUNC)
+		namei_flags |= 2;
+
+	error = -ENFILE;
+	f = get_empty_filp();
+	if (f == NULL)
+		return ERR_PTR(error);
+
+	f->f_flags = flags;
+	error = open_namei(filename, namei_flags, mode, &nd, f);
+	if (!error)
+		return f;
+
+	put_filp(f);
+	return ERR_PTR(error);
+}
+EXPORT_SYMBOL(filp_open);
+
 /**
  * lookup_create - lookup a dentry, creating it if it doesn't exist
  * @nd: nameidata info
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2005-10-05 16:59:46.000000000 +0200
+++ linux/include/linux/fs.h	2005-10-05 18:03:22.000000000 +0200
@@ -1002,6 +1002,8 @@ struct inode_operations {
 	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
 	ssize_t (*listxattr) (struct dentry *, char *, size_t);
 	int (*removexattr) (struct dentry *, const char *);
+	int (*create_open) (struct inode *, struct dentry *, int,
+			    struct file *);
 };
 
 struct seq_file;
@@ -1432,7 +1434,8 @@ static inline void allow_write_access(st
 }
 extern int do_pipe(int *);
 
-extern int open_namei(const char *, int, int, struct nameidata *);
+extern int __dentry_open(struct dentry *dentry, struct vfsmount *mnt,
+			 struct file *f);
 extern int may_open(struct nameidata *, int, int);
 
 extern int kernel_read(struct file *, unsigned long, char *, unsigned long);
Index: linux/fs/open.c
===================================================================
--- linux.orig/fs/open.c	2005-10-05 16:59:46.000000000 +0200
+++ linux/fs/open.c	2005-10-05 17:40:22.000000000 +0200
@@ -738,14 +738,12 @@ asmlinkage long sys_fchown(unsigned int 
 	return error;
 }
 
-static struct file *__dentry_open(struct dentry *dentry, struct vfsmount *mnt,
-					int flags, struct file *f)
+int __dentry_open(struct dentry *dentry, struct vfsmount *mnt, struct file *f)
 {
 	struct inode *inode;
 	int error;
 
-	f->f_flags = flags;
-	f->f_mode = ((flags+1) & O_ACCMODE) | FMODE_LSEEK |
+	f->f_mode = ((f->f_flags+1) & O_ACCMODE) | FMODE_LSEEK |
 				FMODE_PREAD | FMODE_PWRITE;
 	inode = dentry->d_inode;
 	if (f->f_mode & FMODE_WRITE) {
@@ -776,11 +774,11 @@ static struct file *__dentry_open(struct
 		    ((!f->f_mapping->a_ops->direct_IO) &&
 		    (!f->f_mapping->a_ops->get_xip_page))) {
 			fput(f);
-			f = ERR_PTR(-EINVAL);
+			return -EINVAL;
 		}
 	}
 
-	return f;
+	return 0;
 
 cleanup_all:
 	fops_put(f->f_op);
@@ -790,76 +788,29 @@ cleanup_all:
 	f->f_dentry = NULL;
 	f->f_vfsmnt = NULL;
 cleanup_file:
-	put_filp(f);
 	dput(dentry);
 	mntput(mnt);
-	return ERR_PTR(error);
+	return error;
 }
 
-/*
- * Note that while the flag value (low two bits) for sys_open means:
- *	00 - read-only
- *	01 - write-only
- *	10 - read-write
- *	11 - special
- * it is changed into
- *	00 - no permissions needed
- *	01 - read-permission
- *	10 - write-permission
- *	11 - read-write
- * for the internal routines (ie open_namei()/follow_link() etc). 00 is
- * used by symlinks.
- */
-struct file *filp_open(const char * filename, int flags, int mode)
+struct file *dentry_open(struct dentry *dentry, struct vfsmount *mnt, int flags)
 {
-	int namei_flags, error;
-	struct nameidata nd;
+	int error;
 	struct file *f;
-	static int warned;
-
-	/*
-	 * Access mode of 3 had some old uses, that are probably not
-	 * applicable anymore.  For now just warn about deprecation.
-	 * Later it can be changed to return -EINVAL.
-	 */
-	if ((flags & O_ACCMODE) == 3 && warned < 5) {
-		warned++;
-		printk(KERN_WARNING "Warning: '%s' (pid=%i) uses deprecated "
-				"open flags, please report!\n",
-			current->comm, current->tgid);
-	}
-	namei_flags = flags;
-	if ((namei_flags+1) & O_ACCMODE)
-		namei_flags++;
-	if (namei_flags & O_TRUNC)
-		namei_flags |= 2;
 
 	error = -ENFILE;
 	f = get_empty_filp();
 	if (f == NULL)
 		return ERR_PTR(error);
 
-	error = open_namei(filename, namei_flags, mode, &nd);
+	f->f_flags = flags;
+	error = __dentry_open(dentry, mnt, f);
 	if (!error)
-		return __dentry_open(nd.dentry, nd.mnt, flags, f);
+		return f;
 
 	put_filp(f);
 	return ERR_PTR(error);
 }
-EXPORT_SYMBOL(filp_open);
-
-struct file *dentry_open(struct dentry *dentry, struct vfsmount *mnt, int flags)
-{
-	int error;
-	struct file *f;
-
-	error = -ENFILE;
-	f = get_empty_filp();
-	if (f == NULL)
-		return ERR_PTR(error);
-
-	return __dentry_open(dentry, mnt, flags, f);
-}
 EXPORT_SYMBOL(dentry_open);
 
 /*
