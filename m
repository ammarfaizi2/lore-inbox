Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263011AbVGIB34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbVGIB34 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 21:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVGIB2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 21:28:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263004AbVGIB2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 21:28:06 -0400
Date: Fri, 8 Jul 2005 18:26:57 -0700
From: Chris Wright <chrisw@osdl.org>
To: Robert Love <rml@novell.com>, ttb@tentacle.dhs.org
Cc: linux-kernel@vger.kernel.org, linux-audit@redhat.com,
       David Woodhouse <dwmw2@infradead.org>,
       "Timothy R. Chavez" <tinytim@us.ibm.com>
Subject: [RFC/PATCH 1/2] fsnotify
Message-ID: <20050709012657.GE19052@shell0.pdx.osdl.net>
References: <20050709012436.GD19052@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709012436.GD19052@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Add fsnotify as infrastructure for various fs notifcation schemes.
Move dnotify to fsnotify.


 fs/attr.c                |   33 +------------
 fs/compat.c              |   12 +++-
 fs/file_table.c          |    3 +
 fs/namei.c               |   30 ++++++-----
 fs/nfsd/vfs.c            |    6 +-
 fs/open.c                |    3 -
 fs/read_write.c          |   15 +++--
 fs/sysfs/file.c          |    7 --
 fs/xattr.c               |    5 +
 include/linux/dnotify.h  |  101 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h       |    1 
 include/linux/fsnotify.h |  118 +++++++++++++++++++++++++++++++++++++++++++++++
 12 files changed, 270 insertions(+), 64 deletions(-)

Index: linux-2.6.13-rc2-fsnotify-2/fs/attr.c
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/fs/attr.c
+++ linux-2.6.13-rc2-fsnotify-2/fs/attr.c
@@ -10,7 +10,7 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
-#include <linux/dnotify.h>
+#include <linux/fsnotify.h>
 #include <linux/fcntl.h>
 #include <linux/quotaops.h>
 #include <linux/security.h>
@@ -107,31 +107,8 @@ int inode_setattr(struct inode * inode, 
 out:
 	return error;
 }
-
 EXPORT_SYMBOL(inode_setattr);
 
-int setattr_mask(unsigned int ia_valid)
-{
-	unsigned long dn_mask = 0;
-
-	if (ia_valid & ATTR_UID)
-		dn_mask |= DN_ATTRIB;
-	if (ia_valid & ATTR_GID)
-		dn_mask |= DN_ATTRIB;
-	if (ia_valid & ATTR_SIZE)
-		dn_mask |= DN_MODIFY;
-	/* both times implies a utime(s) call */
-	if ((ia_valid & (ATTR_ATIME|ATTR_MTIME)) == (ATTR_ATIME|ATTR_MTIME))
-		dn_mask |= DN_ATTRIB;
-	else if (ia_valid & ATTR_ATIME)
-		dn_mask |= DN_ACCESS;
-	else if (ia_valid & ATTR_MTIME)
-		dn_mask |= DN_MODIFY;
-	if (ia_valid & ATTR_MODE)
-		dn_mask |= DN_ATTRIB;
-	return dn_mask;
-}
-
 int notify_change(struct dentry * dentry, struct iattr * attr)
 {
 	struct inode *inode = dentry->d_inode;
@@ -197,11 +174,9 @@ int notify_change(struct dentry * dentry
 	if (ia_valid & ATTR_SIZE)
 		up_write(&dentry->d_inode->i_alloc_sem);
 
-	if (!error) {
-		unsigned long dn_mask = setattr_mask(ia_valid);
-		if (dn_mask)
-			dnotify_parent(dentry, dn_mask);
-	}
+	if (!error)
+		fsnotify_change(dentry, ia_valid);
+
 	return error;
 }
 
Index: linux-2.6.13-rc2-fsnotify-2/fs/compat.c
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/fs/compat.c
+++ linux-2.6.13-rc2-fsnotify-2/fs/compat.c
@@ -37,7 +37,7 @@
 #include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/dirent.h>
-#include <linux/dnotify.h>
+#include <linux/fsnotify.h>
 #include <linux/highuid.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
@@ -1307,9 +1307,13 @@ static ssize_t compat_do_readv_writev(in
 out:
 	if (iov != iovstack)
 		kfree(iov);
-	if ((ret + (type == READ)) > 0)
-		dnotify_parent(file->f_dentry,
-				(type == READ) ? DN_ACCESS : DN_MODIFY);
+	if ((ret + (type == READ)) > 0) {
+		struct dentry *dentry = file->f_dentry;
+		if (type == READ)
+			fsnotify_access(dentry);
+		else
+			fsnotify_modify(dentry);
+	}
 	return ret;
 }
 
Index: linux-2.6.13-rc2-fsnotify-2/fs/file_table.c
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/fs/file_table.c
+++ linux-2.6.13-rc2-fsnotify-2/fs/file_table.c
@@ -16,6 +16,7 @@
 #include <linux/eventpoll.h>
 #include <linux/mount.h>
 #include <linux/cdev.h>
+#include <linux/fsnotify.h>
 
 /* sysctl tunables... */
 struct files_stat_struct files_stat = {
@@ -126,6 +127,8 @@ void fastcall __fput(struct file *file)
 	struct inode *inode = dentry->d_inode;
 
 	might_sleep();
+
+	fsnotify_close(file);
 	/*
 	 * The function eventpoll_release() should be the first called
 	 * in the file cleanup chain.
Index: linux-2.6.13-rc2-fsnotify-2/fs/namei.c
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/fs/namei.c
+++ linux-2.6.13-rc2-fsnotify-2/fs/namei.c
@@ -21,7 +21,7 @@
 #include <linux/namei.h>
 #include <linux/quotaops.h>
 #include <linux/pagemap.h>
-#include <linux/dnotify.h>
+#include <linux/fsnotify.h>
 #include <linux/smp_lock.h>
 #include <linux/personality.h>
 #include <linux/security.h>
@@ -1312,7 +1312,7 @@ int vfs_create(struct inode *dir, struct
 	DQUOT_INIT(dir);
 	error = dir->i_op->create(dir, dentry, mode, nd);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
+		fsnotify_create(dir, dentry->d_name.name);
 		security_inode_post_create(dir, dentry, mode);
 	}
 	return error;
@@ -1637,7 +1637,7 @@ int vfs_mknod(struct inode *dir, struct 
 	DQUOT_INIT(dir);
 	error = dir->i_op->mknod(dir, dentry, mode, dev);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
+		fsnotify_create(dir, dentry->d_name.name);
 		security_inode_post_mknod(dir, dentry, mode, dev);
 	}
 	return error;
@@ -1710,7 +1710,7 @@ int vfs_mkdir(struct inode *dir, struct 
 	DQUOT_INIT(dir);
 	error = dir->i_op->mkdir(dir, dentry, mode);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
+		fsnotify_mkdir(dir, dentry->d_name.name);
 		security_inode_post_mkdir(dir,dentry, mode);
 	}
 	return error;
@@ -1801,7 +1801,7 @@ int vfs_rmdir(struct inode *dir, struct 
 	}
 	up(&dentry->d_inode->i_sem);
 	if (!error) {
-		inode_dir_notify(dir, DN_DELETE);
+		fsnotify_rmdir(dentry, dentry->d_inode, dir);
 		d_delete(dentry);
 	}
 	dput(dentry);
@@ -1874,9 +1874,10 @@ int vfs_unlink(struct inode *dir, struct
 
 	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
 	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
+		fsnotify_unlink(dentry, dir);
 		d_delete(dentry);
-		inode_dir_notify(dir, DN_DELETE);
 	}
+
 	return error;
 }
 
@@ -1950,7 +1951,7 @@ int vfs_symlink(struct inode *dir, struc
 	DQUOT_INIT(dir);
 	error = dir->i_op->symlink(dir, dentry, oldname);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
+		fsnotify_create(dir, dentry->d_name.name);
 		security_inode_post_symlink(dir, dentry, oldname);
 	}
 	return error;
@@ -2023,7 +2024,7 @@ int vfs_link(struct dentry *old_dentry, 
 	error = dir->i_op->link(old_dentry, dir, new_dentry);
 	up(&old_dentry->d_inode->i_sem);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
+		fsnotify_create(dir, new_dentry->d_name.name);
 		security_inode_post_link(old_dentry, dir, new_dentry);
 	}
 	return error;
@@ -2187,6 +2188,7 @@ int vfs_rename(struct inode *old_dir, st
 {
 	int error;
 	int is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
+	const char *old_name;
 
 	if (old_dentry->d_inode == new_dentry->d_inode)
  		return 0;
@@ -2208,18 +2210,18 @@ int vfs_rename(struct inode *old_dir, st
 	DQUOT_INIT(old_dir);
 	DQUOT_INIT(new_dir);
 
+	old_name = fsnotify_oldname_init(old_dentry->d_name.name);
+
 	if (is_dir)
 		error = vfs_rename_dir(old_dir,old_dentry,new_dir,new_dentry);
 	else
 		error = vfs_rename_other(old_dir,old_dentry,new_dir,new_dentry);
 	if (!error) {
-		if (old_dir == new_dir)
-			inode_dir_notify(old_dir, DN_RENAME);
-		else {
-			inode_dir_notify(old_dir, DN_DELETE);
-			inode_dir_notify(new_dir, DN_CREATE);
-		}
+		const char *new_name = old_dentry->d_name.name;
+		fsnotify_move(old_dir, new_dir, old_name, new_name, is_dir);
 	}
+	fsnotify_oldname_free(old_name);
+
 	return error;
 }
 
Index: linux-2.6.13-rc2-fsnotify-2/fs/nfsd/vfs.c
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/fs/nfsd/vfs.c
+++ linux-2.6.13-rc2-fsnotify-2/fs/nfsd/vfs.c
@@ -45,7 +45,7 @@
 #endif /* CONFIG_NFSD_V3 */
 #include <linux/nfsd/nfsfh.h>
 #include <linux/quotaops.h>
-#include <linux/dnotify.h>
+#include <linux/fsnotify.h>
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
 #ifdef CONFIG_NFSD_V4
@@ -860,7 +860,7 @@ nfsd_vfs_read(struct svc_rqst *rqstp, st
 		nfsdstats.io_read += err;
 		*count = err;
 		err = 0;
-		dnotify_parent(file->f_dentry, DN_ACCESS);
+		fsnotify_access(file->f_dentry);
 	} else 
 		err = nfserrno(err);
 out:
@@ -916,7 +916,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, s
 	set_fs(oldfs);
 	if (err >= 0) {
 		nfsdstats.io_write += cnt;
-		dnotify_parent(file->f_dentry, DN_MODIFY);
+		fsnotify_modify(file->f_dentry);
 	}
 
 	/* clear setuid/setgid flag after write */
Index: linux-2.6.13-rc2-fsnotify-2/fs/open.c
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/fs/open.c
+++ linux-2.6.13-rc2-fsnotify-2/fs/open.c
@@ -10,7 +10,7 @@
 #include <linux/file.h>
 #include <linux/smp_lock.h>
 #include <linux/quotaops.h>
-#include <linux/dnotify.h>
+#include <linux/fsnotify.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/tty.h>
@@ -951,6 +951,7 @@ asmlinkage long sys_open(const char __us
 				put_unused_fd(fd);
 				fd = PTR_ERR(f);
 			} else {
+				fsnotify_open(f->f_dentry);
 				fd_install(fd, f);
 			}
 		}
Index: linux-2.6.13-rc2-fsnotify-2/fs/read_write.c
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/fs/read_write.c
+++ linux-2.6.13-rc2-fsnotify-2/fs/read_write.c
@@ -10,7 +10,7 @@
 #include <linux/file.h>
 #include <linux/uio.h>
 #include <linux/smp_lock.h>
-#include <linux/dnotify.h>
+#include <linux/fsnotify.h>
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
@@ -252,7 +252,7 @@ ssize_t vfs_read(struct file *file, char
 			else
 				ret = do_sync_read(file, buf, count, pos);
 			if (ret > 0) {
-				dnotify_parent(file->f_dentry, DN_ACCESS);
+				fsnotify_access(file->f_dentry);
 				current->rchar += ret;
 			}
 			current->syscr++;
@@ -303,7 +303,7 @@ ssize_t vfs_write(struct file *file, con
 			else
 				ret = do_sync_write(file, buf, count, pos);
 			if (ret > 0) {
-				dnotify_parent(file->f_dentry, DN_MODIFY);
+				fsnotify_modify(file->f_dentry);
 				current->wchar += ret;
 			}
 			current->syscw++;
@@ -539,9 +539,12 @@ static ssize_t do_readv_writev(int type,
 out:
 	if (iov != iovstack)
 		kfree(iov);
-	if ((ret + (type == READ)) > 0)
-		dnotify_parent(file->f_dentry,
-				(type == READ) ? DN_ACCESS : DN_MODIFY);
+	if ((ret + (type == READ)) > 0) {
+		if (type == READ)
+			fsnotify_access(file->f_dentry);
+		else
+			fsnotify_modify(file->f_dentry);
+	}
 	return ret;
 Efault:
 	ret = -EFAULT;
Index: linux-2.6.13-rc2-fsnotify-2/fs/sysfs/file.c
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/fs/sysfs/file.c
+++ linux-2.6.13-rc2-fsnotify-2/fs/sysfs/file.c
@@ -3,7 +3,7 @@
  */
 
 #include <linux/module.h>
-#include <linux/dnotify.h>
+#include <linux/fsnotify.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
 #include <asm/uaccess.h>
@@ -391,9 +391,6 @@ int sysfs_create_file(struct kobject * k
  * sysfs_update_file - update the modified timestamp on an object attribute.
  * @kobj: object we're acting for.
  * @attr: attribute descriptor.
- *
- * Also call dnotify for the dentry, which lots of userspace programs
- * use.
  */
 int sysfs_update_file(struct kobject * kobj, const struct attribute * attr)
 {
@@ -408,7 +405,7 @@ int sysfs_update_file(struct kobject * k
 		if (victim->d_inode && 
 		    (victim->d_parent->d_inode == dir->d_inode)) {
 			victim->d_inode->i_mtime = CURRENT_TIME;
-			dnotify_parent(victim, DN_MODIFY);
+			fsnotify_modify(victim);
 
 			/**
 			 * Drop reference from initial sysfs_get_dentry().
Index: linux-2.6.13-rc2-fsnotify-2/fs/xattr.c
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/fs/xattr.c
+++ linux-2.6.13-rc2-fsnotify-2/fs/xattr.c
@@ -16,6 +16,7 @@
 #include <linux/security.h>
 #include <linux/syscalls.h>
 #include <linux/module.h>
+#include <linux/fsnotify.h>
 #include <asm/uaccess.h>
 
 /*
@@ -57,8 +58,10 @@ setxattr(struct dentry *d, char __user *
 		if (error)
 			goto out;
 		error = d->d_inode->i_op->setxattr(d, kname, kvalue, size, flags);
-		if (!error)
+		if (!error) {
+			fsnotify_xattr(d);
 			security_inode_post_setxattr(d, kname, kvalue, size, flags);
+		}
 out:
 		up(&d->d_inode->i_sem);
 	}
Index: linux-2.6.13-rc2-fsnotify-2/include/linux/fs.h
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/include/linux/fs.h
+++ linux-2.6.13-rc2-fsnotify-2/include/linux/fs.h
@@ -1393,7 +1393,6 @@ extern void emergency_remount(void);
 extern int do_remount_sb(struct super_block *sb, int flags,
 			 void *data, int force);
 extern sector_t bmap(struct inode *, sector_t);
-extern int setattr_mask(unsigned int);
 extern int notify_change(struct dentry *, struct iattr *);
 extern int permission(struct inode *, int, struct nameidata *);
 extern int generic_permission(struct inode *, int,
Index: linux-2.6.13-rc2-fsnotify-2/include/linux/fsnotify.h
===================================================================
--- /dev/null
+++ linux-2.6.13-rc2-fsnotify-2/include/linux/fsnotify.h
@@ -0,0 +1,118 @@
+#ifndef _LINUX_FS_NOTIFY_H
+#define _LINUX_FS_NOTIFY_H
+
+/*
+ * include/linux/fsnotify.h - generic hooks for filesystem notification, to
+ * reduce in-source duplication from both dnotify and inotify.
+ *
+ * We don't compile any of this away in some complicated menagerie of ifdefs.
+ * Instead, we rely on the code inside to optimize away as needed.
+ *
+ * (C) Copyright 2005 Robert Love
+ */
+
+#ifdef __KERNEL__
+
+#include <linux/dnotify.h>
+
+/*
+ * fsnotify_move - file old_name at old_dir was moved to new_name at new_dir
+ */
+static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
+				 const char *old_name, const char *new_name,
+				 int isdir)
+{
+	dnotify_move(old_dir, new_dir, old_name, new_name, isdir);
+}
+
+/*
+ * fsnotify_unlink - file was unlinked
+ */
+static inline void fsnotify_unlink(struct dentry *dentry, struct inode *dir)
+{
+	dnotify_unlink(dentry, dir);
+}
+
+/*
+ * fsnotify_rmdir - directory was removed
+ */
+static inline void fsnotify_rmdir(struct dentry *dentry, struct inode *inode,
+				  struct inode *dir)
+{
+	dnotify_rmdir(dentry, inode, dir);
+}
+
+/*
+ * fsnotify_create - 'name' was linked in
+ */
+static inline void fsnotify_create(struct inode *inode, const char *name)
+{
+	dnotify_create(inode, name);
+}
+
+/*
+ * fsnotify_mkdir - directory 'name' was created
+ */
+static inline void fsnotify_mkdir(struct inode *inode, const char *name)
+{
+	dnotify_mkdir(inode, name);
+}
+
+/*
+ * fsnotify_access - file was read
+ */
+static inline void fsnotify_access(struct dentry *dentry)
+{
+	dnotify_access(dentry);
+}
+
+/*
+ * fsnotify_modify - file was modified
+ */
+static inline void fsnotify_modify(struct dentry *dentry)
+{
+	dnotify_modify(dentry);
+}
+
+/*
+ * fsnotify_open - file was opened
+ */
+static inline void fsnotify_open(struct dentry *dentry)
+{
+}
+
+/*
+ * fsnotify_close - file was closed
+ */
+static inline void fsnotify_close(struct file *file)
+{
+}
+
+/*
+ * fsnotify_xattr - extended attributes were changed
+ */
+static inline void fsnotify_xattr(struct dentry *dentry)
+{
+}
+
+/*
+ * fsnotify_change - notify_change event.  file was modified and/or metadata
+ * was changed.
+ */
+static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
+{
+	dnotify_change(dentry, ia_valid);
+}
+
+static inline const char *fsnotify_oldname_init(const char *name)
+{
+	return NULL;
+}
+
+static inline void fsnotify_oldname_free(const char *old_name)
+{
+}
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _LINUX_FS_NOTIFY_H */
Index: linux-2.6.13-rc2-fsnotify-2/include/linux/dnotify.h
===================================================================
--- linux-2.6.13-rc2-fsnotify-2.orig/include/linux/dnotify.h
+++ linux-2.6.13-rc2-fsnotify-2/include/linux/dnotify.h
@@ -33,8 +33,109 @@ static inline void inode_dir_notify(stru
 		__inode_dir_notify(inode, event);
 }
 
+static inline void dnotify_move(struct inode *old_dir, struct inode *new_dir,
+				 const char *old_name, const char *new_name,
+				 int isdir)
+{
+	if (old_dir == new_dir)
+		inode_dir_notify(old_dir, DN_RENAME);
+	else {
+		inode_dir_notify(old_dir, DN_DELETE);
+		inode_dir_notify(new_dir, DN_CREATE);
+	}
+}
+
+static inline void dnotify_unlink(struct dentry *dentry, struct inode *dir)
+{
+	inode_dir_notify(dir, DN_DELETE);
+}
+
+static inline void dnotify_rmdir(struct dentry *dentry, struct inode *inode,
+				  struct inode *dir)
+{
+	inode_dir_notify(dir, DN_DELETE);
+}
+
+static inline void dnotify_create(struct inode *inode, const char *name)
+{
+	inode_dir_notify(inode, DN_CREATE);
+}
+
+static inline void dnotify_mkdir(struct inode *inode, const char *name)
+{
+	inode_dir_notify(inode, DN_CREATE);
+}
+
+static inline void dnotify_access(struct dentry *dentry)
+{
+	dnotify_parent(dentry, DN_ACCESS);
+}
+
+static inline void dnotify_modify(struct dentry *dentry)
+{
+	dnotify_parent(dentry, DN_MODIFY);
+}
+
+static inline void dnotify_change(struct dentry *dentry, unsigned int ia_valid)
+{
+	int dn_mask = 0;
+
+	if (ia_valid & ATTR_UID)
+		dn_mask |= DN_ATTRIB;
+	if (ia_valid & ATTR_GID)
+		dn_mask |= DN_ATTRIB;
+	if (ia_valid & ATTR_SIZE)
+		dn_mask |= DN_MODIFY;
+	/* both times implies a utime(s) call */
+	if ((ia_valid & (ATTR_ATIME | ATTR_MTIME)) == (ATTR_ATIME | ATTR_MTIME))
+		dn_mask |= DN_ATTRIB;
+	else if (ia_valid & ATTR_ATIME)
+		dn_mask |= DN_ACCESS;
+	else if (ia_valid & ATTR_MTIME)
+		dn_mask |= DN_MODIFY;
+	if (ia_valid & ATTR_MODE)
+		dn_mask |= DN_ATTRIB;
+
+	if (dn_mask)
+		dnotify_parent(dentry, dn_mask);
+}
 #else
 
+static inline void dnotify_move(struct inode *old_dir, struct inode *new_dir,
+				 const char *old_name, const char *new_name,
+				 int isdir)
+{
+}
+
+static inline void dnotify_unlink(struct dentry *dentry, struct inode *dir)
+{
+}
+
+static inline void dnotify_rmdir(struct dentry *dentry, struct inode *inode,
+				  struct inode *dir)
+{
+}
+
+static inline void dnotify_create(struct inode *inode, const char *name)
+{
+}
+
+static inline void dnotify_mkdir(struct inode *inode, const char *name)
+{
+}
+
+static inline void dnotify_access(struct dentry *dentry)
+{
+}
+
+static inline void dnotify_modify(struct dentry *dentry)
+{
+}
+
+static inline void dnotify_change(struct dentry *dentry, unsigned int ia_valid)
+{
+}
+
 static inline void __inode_dir_notify(struct inode *inode, unsigned long event)
 {
 }
