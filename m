Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVAaWt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVAaWt4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 17:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVAaWt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 17:49:56 -0500
Received: from peabody.ximian.com ([130.57.169.10]:48528 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261380AbVAaWrm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 17:47:42 -0500
Subject: [patch] generic notification layer
From: Robert Love <rml@novell.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050124121729.GA29392@infradead.org>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050124121729.GA29392@infradead.org>
Content-Type: text/plain
Date: Mon, 31 Jan 2005 17:42:38 -0500
Message-Id: <1107211358.4019.36.camel@betsy.boston.ximian.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-24 at 12:17 +0000, Christoph Hellwig wrote:

> Haven't had time to look at the current implementation, but the in-kernel
> interface is still horrible as it duplicates the dnotify calls all over the
> place, using IN_FOO instead of DN_FOO.  Please add a layer of notify_foo
> wrappers that calls into both.

Hi, Christoph!

I went ahead and wrote a generic notification layer, wrapping inotify,
dnotify, and some related work behind nice, clean interfaces such as
"fsnotify_move()".

The patch is a net gain of -125 lines ignoring the new
<linux/fsnotify.h>, so it does remove a bit of code from fs/, which is
nice.

Compile tested, but not yet booted.  Find an interdiff below, so you can
get an idea of the interfaces, at least.

If this is really an issue for you, I think that this should be a step
in the right direction.

Best,

	Robert Love


Signed-off-by: Robert Love <rml@novell.com>

diff -u linux/fs/attr.c linux/fs/attr.c
--- linux/fs/attr.c	2005-01-18 16:11:08.000000000 -0500
+++ linux/fs/attr.c	2005-01-31 15:52:37.756482208 -0500
@@ -10,8 +10,7 @@
 #include <linux/mm.h>
 #include <linux/string.h>
 #include <linux/smp_lock.h>
-#include <linux/dnotify.h>
-#include <linux/inotify.h>
+#include <linux/fsnotify.h>
 #include <linux/fcntl.h>
 #include <linux/quotaops.h>
 #include <linux/security.h>
@@ -106,51 +105,6 @@
 }
 EXPORT_SYMBOL(inode_setattr);
 
-void setattr_mask (unsigned int ia_valid, int *dn_mask, u32 *in_mask)
-{
-	int dnmask;
-	u32 inmask;
-
-	inmask = 0;
-	dnmask = 0;
-
-	if (!dn_mask || !in_mask) {
-		return;
-	}
-        if (ia_valid & ATTR_UID) {
-                inmask |= IN_ATTRIB;
-		dnmask |= DN_ATTRIB;
-	}
-        if (ia_valid & ATTR_GID) {
-                inmask |= IN_ATTRIB;
-		dnmask |= DN_ATTRIB;
-	}
-        if (ia_valid & ATTR_SIZE) {
-                inmask |= IN_MODIFY;
-		dnmask |= DN_MODIFY;
-	}
-        /* both times implies a utime(s) call */
-        if ((ia_valid & (ATTR_ATIME|ATTR_MTIME)) == (ATTR_ATIME|ATTR_MTIME)) {
-                inmask |= IN_ATTRIB;
-		dnmask |= DN_ATTRIB;
-	}
-        else if (ia_valid & ATTR_ATIME) {
-                inmask |= IN_ACCESS;
-		dnmask |= DN_ACCESS;
-	}
-        else if (ia_valid & ATTR_MTIME) {
-                inmask |= IN_MODIFY;
-		dnmask |= DN_MODIFY;
-	}
-        if (ia_valid & ATTR_MODE) {
-                inmask |= IN_ATTRIB;
-		dnmask |= DN_ATTRIB;
-	}
-
-	*in_mask = inmask;
-	*dn_mask = dnmask;
-}
-
 int notify_change(struct dentry * dentry, struct iattr * attr)
 {
 	struct inode *inode = dentry->d_inode;
@@ -206,21 +160,10 @@
 				error = inode_setattr(inode, attr);
 		}
 	}
-	if (!error) {
-		int dn_mask;
-		u32 in_mask;
 
-		setattr_mask (ia_valid, &dn_mask, &in_mask);
+	if (!error)
+		fsnotify_change(dentry, ia_valid);
 
-		if (dn_mask)
-			dnotify_parent(dentry, dn_mask);
-		if (in_mask) {
-			inotify_inode_queue_event(dentry->d_inode, in_mask, 0,
-						  NULL);
-			inotify_dentry_parent_queue_event(dentry, in_mask, 0,
-							  dentry->d_name.name);
-		}
-	}
 	return error;
 }
 
diff -u linux/fs/file_table.c linux/fs/file_table.c
--- linux/fs/file_table.c	2005-01-18 16:11:08.000000000 -0500
+++ linux/fs/file_table.c	2005-01-31 15:46:49.248463480 -0500
@@ -16,7 +16,7 @@
 #include <linux/eventpoll.h>
 #include <linux/mount.h>
 #include <linux/cdev.h>
-#include <linux/inotify.h>
+#include <linux/fsnotify.h>
 
 /* sysctl tunables... */
 struct files_stat_struct files_stat = {
@@ -121,12 +121,9 @@
 	struct dentry *dentry = file->f_dentry;
 	struct vfsmount *mnt = file->f_vfsmnt;
 	struct inode *inode = dentry->d_inode;
-	u32 mask;
 
 
-	mask = (file->f_mode & FMODE_WRITE) ? IN_CLOSE_WRITE : IN_CLOSE_NOWRITE;
-	inotify_dentry_parent_queue_event(dentry, mask, 0, dentry->d_name.name);
-	inotify_inode_queue_event(inode, mask, 0, NULL);
+	fsnotify_close(dentry, inode, file->f_mode, dentry->d_name.name);
 
 	might_sleep();
 	/*
diff -u linux/fs/namei.c linux/fs/namei.c
--- linux/fs/namei.c	2005-01-20 15:32:24.000000000 -0500
+++ linux/fs/namei.c	2005-01-31 17:24:21.870729656 -0500
@@ -21,8 +21,7 @@
 #include <linux/namei.h>
 #include <linux/quotaops.h>
 #include <linux/pagemap.h>
-#include <linux/dnotify.h>
-#include <linux/inotify.h>
+#include <linux/fsnotify.h>
 #include <linux/smp_lock.h>
 #include <linux/personality.h>
 #include <linux/security.h>
@@ -1242,9 +1241,7 @@
 	DQUOT_INIT(dir);
 	error = dir->i_op->create(dir, dentry, mode, nd);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
-		inotify_inode_queue_event(dir, IN_CREATE_FILE,
-				0, dentry->d_name.name);
+		fsnotify_create(dir, dentry->d_name.name);
 		security_inode_post_create(dir, dentry, mode);
 	}
 	return error;
@@ -1558,9 +1555,7 @@
 	DQUOT_INIT(dir);
 	error = dir->i_op->mknod(dir, dentry, mode, dev);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
-		inotify_inode_queue_event(dir, IN_CREATE_FILE, 0,
-				dentry->d_name.name);
+		fsnotify_create(dir, dentry->d_name.name);
 		security_inode_post_mknod(dir, dentry, mode, dev);
 	}
 	return error;
@@ -1633,9 +1628,7 @@
 	DQUOT_INIT(dir);
 	error = dir->i_op->mkdir(dir, dentry, mode);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
-		inotify_inode_queue_event(dir, IN_CREATE_SUBDIR, 0,
-				dentry->d_name.name);
+		fsnotify_mkdir(dir, dentry->d_name.name);
 		security_inode_post_mkdir(dir,dentry, mode);
 	}
 	return error;
@@ -1729,15 +1722,8 @@
 		}
 	}
 	up(&dentry->d_inode->i_sem);
-	if (!error) {
-		inode_dir_notify(dir, DN_DELETE);
-		inotify_inode_queue_event(dir, IN_DELETE_SUBDIR, 0,
-				dentry->d_name.name);
-		inotify_inode_queue_event(dentry->d_inode, IN_DELETE_SELF, 0,
-				NULL);
-		inotify_inode_is_dead (dentry->d_inode);
-		d_delete(dentry);
-	}
+	if (!error)
+		fsnotify_rmdir(dentry, dentry->d_inode, dir);
 	dput(dentry);
 
 	return error;
@@ -1807,15 +1793,9 @@
 	up(&dentry->d_inode->i_sem);
 
 	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
-	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
-		inode_dir_notify(dir, DN_DELETE);
-		inotify_inode_queue_event(dir, IN_DELETE_FILE, 0,
-				dentry->d_name.name);
-		inotify_inode_queue_event(dentry->d_inode, IN_DELETE_SELF, 0,
-				NULL);
-		inotify_inode_is_dead (dentry->d_inode);
-		d_delete(dentry);
-	}
+	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED))
+		fsnotify_unlink(dentry->d_inode, dir, dentry);
+
 	return error;
 }
 
@@ -1889,9 +1869,7 @@
 	DQUOT_INIT(dir);
 	error = dir->i_op->symlink(dir, dentry, oldname);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
-		inotify_inode_queue_event(dir, IN_CREATE_FILE, 0,
-				dentry->d_name.name);
+		fsnotify_create(dir, dentry->d_name.name);
 		security_inode_post_symlink(dir, dentry, oldname);
 	}
 	return error;
@@ -1964,9 +1942,7 @@
 	error = dir->i_op->link(old_dentry, dir, new_dentry);
 	up(&old_dentry->d_inode->i_sem);
 	if (!error) {
-		inode_dir_notify(dir, DN_CREATE);
-		inotify_inode_queue_event(dir, IN_CREATE_FILE, 0, 
-					new_dentry->d_name.name);
+		fsnotify_create(dir, new_dentry->d_name.name);
 		security_inode_post_link(old_dentry, dir, new_dentry);
 	}
 	return error;
@@ -2131,7 +2107,6 @@
 	int error;
 	int is_dir = S_ISDIR(old_dentry->d_inode->i_mode);
 	char *old_name;
-	u32 cookie;
 
 	if (old_dentry->d_inode == new_dentry->d_inode)
  		return 0;
@@ -2153,28 +2128,17 @@
 	DQUOT_INIT(old_dir);
 	DQUOT_INIT(new_dir);
 
-	old_name = inotify_oldname_init(old_dentry);
+	old_name = fsnotify_oldname_init(old_dentry);
 
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
-
-		cookie = inotify_get_cookie();
-
-		inotify_inode_queue_event(old_dir, IN_MOVED_FROM, cookie,
-					  old_name);
-		inotify_inode_queue_event(new_dir, IN_MOVED_TO, cookie,
-					  old_dentry->d_name.name);
+		const char *new_name = old_dentry->d_name.name;
+		fsnotify_move(old_dir, new_dir, old_name, new_name);
 	}
-	inotify_oldname_free(old_name);
+	fsnotify_oldname_free(old_name);
 
 	return error;
 }
diff -u linux/fs/open.c linux/fs/open.c
--- linux/fs/open.c	2005-01-18 16:11:08.000000000 -0500
+++ linux/fs/open.c	2005-01-31 16:28:33.478762608 -0500
@@ -10,8 +10,7 @@
 #include <linux/file.h>
 #include <linux/smp_lock.h>
 #include <linux/quotaops.h>
-#include <linux/dnotify.h>
-#include <linux/inotify.h>
+#include <linux/fsnotify.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/tty.h>
@@ -954,13 +953,13 @@
 		fd = get_unused_fd();
 		if (fd >= 0) {
 			struct file *f = filp_open(tmp, flags, mode);
+			struct dentry *dentry = f->f_dentry;
+
 			error = PTR_ERR(f);
 			if (IS_ERR(f))
 				goto out_error;
-			inotify_inode_queue_event(f->f_dentry->d_inode,
-					IN_OPEN, 0, NULL);
-			inotify_dentry_parent_queue_event(f->f_dentry, IN_OPEN,
-					0, f->f_dentry->d_name.name);
+			fsnotify_open(dentry, dentry->d_inode,
+				      dentry->d_name.name);
 			fd_install(fd, f);
 		}
 out:
@@ -1012,7 +1011,7 @@
 			retval = err;
 	}
 
-	dnotify_flush(filp, id);
+	fsnotify_flush(filp, id);
 	locks_remove_posix(filp, id);
 	fput(filp);
 	return retval;
diff -u linux/fs/read_write.c linux/fs/read_write.c
--- linux/fs/read_write.c	2005-01-18 16:11:08.000000000 -0500
+++ linux/fs/read_write.c	2005-01-31 16:35:05.270201256 -0500
@@ -10,8 +10,7 @@
 #include <linux/file.h>
 #include <linux/uio.h>
 #include <linux/smp_lock.h>
-#include <linux/dnotify.h>
-#include <linux/inotify.h>
+#include <linux/fsnotify.h>
 #include <linux/security.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
@@ -219,11 +218,8 @@
 				ret = do_sync_read(file, buf, count, pos);
 			if (ret > 0) {
 				struct dentry *dentry = file->f_dentry;
-				dnotify_parent(dentry, DN_ACCESS);
-				inotify_dentry_parent_queue_event(dentry,
-						IN_ACCESS, 0, dentry->d_name.name);
-				inotify_inode_queue_event(inode, IN_ACCESS, 0,
-						NULL);
+				fsnotify_access(dentry, inode,
+						dentry->d_name.name);
 			}
 		}
 	}
@@ -269,11 +265,8 @@
 				ret = do_sync_write(file, buf, count, pos);
 			if (ret > 0) {
 				struct dentry *dentry = file->f_dentry;
-				dnotify_parent(dentry, DN_MODIFY);
-				inotify_dentry_parent_queue_event(dentry,
-						IN_MODIFY, 0, dentry->d_name.name);
-				inotify_inode_queue_event(inode, IN_MODIFY, 0,
-						NULL);
+				fsnotify_modify(dentry, inode,
+						dentry->d_name.name);
 			}
 		}
 	}
@@ -508,12 +501,12 @@
 		kfree(iov);
 	if ((ret + (type == READ)) > 0) {
 		struct dentry *dentry = file->f_dentry;
-		dnotify_parent(dentry, (type == READ) ? DN_ACCESS : DN_MODIFY);
-		inotify_dentry_parent_queue_event(dentry,
-				(type == READ) ? IN_ACCESS : IN_MODIFY, 0,
-				dentry->d_name.name);
-		inotify_inode_queue_event (dentry->d_inode,
-				(type == READ) ? IN_ACCESS : IN_MODIFY, 0, NULL);
+		struct inode *inode = dentry->d_inode;
+
+		if (type == READ)
+			fsnotify_access(dentry, inode, dentry->d_name.name);
+		else
+			fsnotify_modify(dentry, inode, dentry->d_name.name);
 	}
 	return ret;
 }
diff -u linux/fs/super.c linux/fs/super.c
--- linux/fs/super.c	2005-01-18 16:11:08.000000000 -0500
+++ linux/fs/super.c	2005-01-31 14:53:38.828481040 -0500
@@ -37,9 +37,8 @@
 #include <linux/writeback.h>		/* for the emergency remount stuff */
 #include <linux/idr.h>
 #include <linux/kobject.h>
+#include <linux/fsnotify.h>
 #include <asm/uaccess.h>
-#include <linux/inotify.h>
-
 
 void get_filesystem(struct file_system_type *fs);
 void put_filesystem(struct file_system_type *fs);
@@ -228,7 +227,7 @@
 
 	if (root) {
 		sb->s_root = NULL;
-		inotify_super_block_umount(sb);
+		fsnotify_sb_umount(sb);
 		shrink_dcache_parent(root);
 		shrink_dcache_anon(&sb->s_anon);
 		dput(root);
diff -u linux/include/linux/inotify.h linux/include/linux/inotify.h
--- linux/include/linux/inotify.h	2005-01-18 16:11:12.000000000 -0500
+++ linux/include/linux/inotify.h	2005-01-31 17:22:43.129740568 -0500
@@ -84,23 +84,6 @@
 extern void inotify_super_block_umount(struct super_block *);
 extern void inotify_inode_is_dead(struct inode *);
 extern __u32 inotify_get_cookie(void);
-extern __u32 setattr_mask_inotify(unsigned int);
-
-/* this could be kstrdup if only we could add that to lib/string.c */
-static inline char * inotify_oldname_init(struct dentry *old_dentry)
-{
-	char *old_name;
-
-	old_name = kmalloc(strlen(old_dentry->d_name.name) + 1, GFP_KERNEL);
-	if (old_name)
-		strcpy(old_name, old_dentry->d_name.name);
-	return old_name;
-}
-
-static inline void inotify_oldname_free(const char *old_name)
-{
-	kfree(old_name);
-}
 
 #else
 
@@ -124,25 +107,11 @@
 {
 }
 
-static inline char * inotify_oldname_init(struct dentry *old_dentry)
-{
-	return NULL;
-}
-
 static inline __u32 inotify_get_cookie(void)
 {
 	return 0;
 }
 
-static inline void inotify_oldname_free(const char *old_name)
-{
-}
-
-static inline int setattr_mask_inotify(unsigned int ia_mask)
-{
-	return 0;
-}
-
 #endif	/* CONFIG_INOTIFY */
 
 #endif	/* __KERNEL __ */
only in patch2:
unchanged:
--- linux-2.6.10/fs/compat.c	2004-12-24 16:34:44.000000000 -0500
+++ linux/fs/compat.c	2005-01-31 17:08:03.561455272 -0500
@@ -1192,9 +1192,15 @@
 out:
 	if (iov != iovstack)
 		kfree(iov);
-	if ((ret + (type == READ)) > 0)
-		dnotify_parent(file->f_dentry,
-				(type == READ) ? DN_ACCESS : DN_MODIFY);
+	if ((ret + (type == READ)) > 0) {
+		struct dentry *dentry = file->f_dentry;
+		if (type == READ)
+			fsnotify_access(dentry, dentry->d_inode,
+					dentry->d_name.name);
+		else
+			fsnotify_modify(dentry, dentry->d_inode,
+					dentry->d_name.name);
+	}
 	return ret;
 }
 
only in patch2:
unchanged:
--- linux-2.6.10/include/linux/fsnotify.h	1969-12-31 19:00:00.000000000 -0500
+++ linux/include/linux/fsnotify.h	2005-01-31 17:24:54.486771264 -0500
@@ -0,0 +1,225 @@
+#ifndef _LINUX_FS_NOTIFY_H
+#define _LINUX_FS_NOTIFY_H
+
+/*
+ * include/linux/fs_notify.h - generic hooks for filesystem notification, to
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
+#include <linux/inotify.h>
+
+/*
+ * fsnotify_move - file old_name at old_dir was moved to new_name at new_dir
+ */
+static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
+				 const char *old_name, const char *new_name)
+{
+	u32 cookie;
+
+	if (old_dir == new_dir)
+		inode_dir_notify(old_dir, DN_RENAME);
+	else {
+		inode_dir_notify(old_dir, DN_DELETE);
+		inode_dir_notify(new_dir, DN_CREATE);
+	}
+
+	cookie = inotify_get_cookie();
+
+	inotify_inode_queue_event(old_dir, IN_MOVED_FROM, cookie, old_name);
+	inotify_inode_queue_event(new_dir, IN_MOVED_TO, cookie, new_name);
+}
+
+/*
+ * fsnotify_unlink - file was unlinked
+ */
+static inline void fsnotify_unlink(struct inode *inode, struct inode *dir,
+				   struct dentry *dentry)
+{
+	inode_dir_notify(dir, DN_DELETE);
+	inotify_inode_queue_event(dir, IN_DELETE_FILE, 0, dentry->d_name.name);
+	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL);
+
+	inotify_inode_is_dead(inode);
+	d_delete(dentry);
+}
+
+/*
+ * fsnotify_rmdir - directory was removed
+ */
+static inline void fsnotify_rmdir(struct dentry *dentry, struct inode *inode,
+				  struct inode *dir)
+{
+	inode_dir_notify(dir, DN_DELETE);
+	inotify_inode_queue_event(dir, IN_DELETE_SUBDIR,0,dentry->d_name.name);
+	inotify_inode_queue_event(inode, IN_DELETE_SELF, 0, NULL);
+
+	inotify_inode_is_dead(inode);
+	d_delete(dentry);
+}
+
+/*
+ * fsnotify_create - filename was linked in
+ */
+static inline void fsnotify_create(struct inode *inode, const char *filename)
+{
+	inode_dir_notify(inode, DN_CREATE);
+	inotify_inode_queue_event(inode, IN_CREATE_FILE, 0, filename);
+}
+
+/*
+ * fsnotify_mkdir - directory 'name' was created
+ */
+static inline void fsnotify_mkdir(struct inode *inode, const char *name)
+{
+	inode_dir_notify(inode, DN_CREATE);
+	inotify_inode_queue_event(inode, IN_CREATE_SUBDIR, 0, name);
+}
+
+/*
+ * fsnotify_access - file was read
+ */
+static inline void fsnotify_access(struct dentry *dentry, struct inode *inode,
+				   const char *filename)
+{
+	dnotify_parent(dentry, DN_ACCESS);
+	inotify_dentry_parent_queue_event(dentry, IN_ACCESS, 0,
+					  dentry->d_name.name);
+	inotify_inode_queue_event(inode, IN_ACCESS, 0, NULL);
+}
+
+/*
+ * fsnotify_modify - file was modified
+ */
+static inline void fsnotify_modify(struct dentry *dentry, struct inode *inode,
+				   const char *filename)
+{
+	dnotify_parent(dentry, DN_MODIFY);
+	inotify_dentry_parent_queue_event(dentry, IN_MODIFY, 0, filename);
+	inotify_inode_queue_event(inode, IN_MODIFY, 0, NULL);
+}
+
+/*
+ * fsnotify_open - file was opened
+ */
+static inline void fsnotify_open(struct dentry *dentry, struct inode *inode,
+				 const char *filename)
+{
+	inotify_inode_queue_event(inode, IN_OPEN, 0, NULL);
+	inotify_dentry_parent_queue_event(dentry, IN_OPEN, 0, filename);
+}
+
+/*
+ * fsnotify_close - file was closed
+ */
+static inline void fsnotify_close(struct dentry *dentry, struct inode *inode,
+				  mode_t mode, const char *filename)
+{
+	u32 mask;
+
+	mask = (mode & FMODE_WRITE) ? IN_CLOSE_WRITE : IN_CLOSE_NOWRITE;
+	inotify_dentry_parent_queue_event(dentry, mask, 0, filename);
+	inotify_inode_queue_event(inode, mask, 0, NULL);
+}
+
+/*
+ * fsnotify_change - notify_change event.  file was modified and/or metadata
+ * was changed.
+ */
+static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
+{
+	int dn_mask = 0;
+	u32 in_mask = 0;
+
+        if (ia_valid & ATTR_UID) {
+                in_mask |= IN_ATTRIB;
+		dn_mask |= DN_ATTRIB;
+	}
+        if (ia_valid & ATTR_GID) {
+                in_mask |= IN_ATTRIB;
+		dn_mask |= DN_ATTRIB;
+	}
+        if (ia_valid & ATTR_SIZE) {
+                in_mask |= IN_MODIFY;
+		dn_mask |= DN_MODIFY;
+	}
+        /* both times implies a utime(s) call */
+        if ((ia_valid & (ATTR_ATIME|ATTR_MTIME)) == (ATTR_ATIME|ATTR_MTIME)) {
+                in_mask |= IN_ATTRIB;
+		dn_mask |= DN_ATTRIB;
+	}
+        else if (ia_valid & ATTR_ATIME) {
+                in_mask |= IN_ACCESS;
+		dn_mask |= DN_ACCESS;
+	}
+        else if (ia_valid & ATTR_MTIME) {
+                in_mask |= IN_MODIFY;
+		dn_mask |= DN_MODIFY;
+	}
+        if (ia_valid & ATTR_MODE) {
+                in_mask |= IN_ATTRIB;
+		dn_mask |= DN_ATTRIB;
+	}
+
+	if (dn_mask)
+		dnotify_parent(dentry, dn_mask);
+	if (in_mask) {
+		inotify_inode_queue_event(dentry->d_inode, in_mask, 0, NULL);
+		inotify_dentry_parent_queue_event(dentry, in_mask, 0,
+						  dentry->d_name.name);
+	}
+}
+
+/*
+ * fsnotify_sb_umount - filesystem unmount
+ */
+static inline void fsnotify_sb_umount(struct super_block *sb)
+{
+	inotify_super_block_umount(sb);
+}
+
+/*
+ * fsnotify_flush - flush time!
+ */
+static inline void fsnotify_flush(struct file *filp, fl_owner_t id)
+{
+	dnotify_flush(filp, id);
+}
+
+#ifdef CONFIG_INOTIFY	/* inotify helpers */
+
+/*
+ * fsnotify_oldname_init - save off the old filename before we change it
+ *
+ * this could be kstrdup if only we could add that to lib/string.c
+ */
+static inline char * fsnotify_oldname_init(struct dentry *old_dentry)
+{
+	char *old_name;
+
+	old_name = kmalloc(strlen(old_dentry->d_name.name) + 1, GFP_KERNEL);
+	if (old_name)
+		strcpy(old_name, old_dentry->d_name.name);
+	return old_name;
+}
+
+/*
+ * fsnotify_oldname_free - free the name we got from fsnotify_oldname_init
+ */
+static inline void fsnotify_oldname_free(const char *old_name)
+{
+	kfree(old_name);
+}
+
+#endif	/* CONFIG_INOTIFY */
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _LINUX_FS_NOTIFY_H */


