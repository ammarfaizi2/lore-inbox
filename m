Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbVHYRq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbVHYRq1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 13:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVHYRq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 13:46:27 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:60298 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1751356AbVHYRq0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 13:46:26 -0400
Subject: [PATCH][-mm] Generic VFS fallback for security xattrs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Christoph Hellwig <hch@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, James Morris <jmorris@namei.org>,
       Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 25 Aug 2005 13:43:23 -0400
Message-Id: <1124991803.3873.125.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies the VFS setxattr, getxattr, and listxattr code to
fall back to the security module for security xattrs if the filesystem
does not support xattrs natively.  This allows security modules to
export the incore inode security label information to userspace even
if the filesystem does not provide xattr storage, and eliminates the
need to individually patch various pseudo filesystem types to provide
such access.  The patch removes the existing xattr code from devpts
and tmpfs as it is then no longer needed.

The patch restructures the code flow slightly to reduce duplication
between the normal path and the fallback path, but this should only
have one user-visible side effect - a program may get -EACCES rather
than -EOPNOTSUPP if policy denied access but the filesystem didn't
support the operation anyway.  Note that the post_setxattr hook call
is not needed in the fallback case, as the inode_setsecurity hook call
handles the incore inode security state update directly.  In contrast,
we do call fsnotify in both cases.

Please include in -mm for wider testing prior to merging in 2.6.14.

---

 fs/Kconfig                 |   43 ----------------------
 fs/devpts/Makefile         |    1 
 fs/devpts/inode.c          |   21 -----------
 fs/devpts/xattr_security.c |   47 ------------------------
 fs/xattr.c                 |   80 +++++++++++++++++++++++++-----------------
 mm/shmem.c                 |   85 ---------------------------------------------
 6 files changed, 49 insertions(+), 228 deletions(-)

diff -X /home/sds/dontdiff -Nrup linux-2.6.13-rc6-mm2/fs/devpts/inode.c linux-2.6.13-rc6-mm2-xattr/fs/devpts/inode.c
--- linux-2.6.13-rc6-mm2/fs/devpts/inode.c	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-rc6-mm2-xattr/fs/devpts/inode.c	2005-08-24 07:57:51.000000000 -0400
@@ -18,28 +18,9 @@
 #include <linux/mount.h>
 #include <linux/tty.h>
 #include <linux/devpts_fs.h>
-#include <linux/xattr.h>
 
 #define DEVPTS_SUPER_MAGIC 0x1cd1
 
-extern struct xattr_handler devpts_xattr_security_handler;
-
-static struct xattr_handler *devpts_xattr_handlers[] = {
-#ifdef CONFIG_DEVPTS_FS_SECURITY
-	&devpts_xattr_security_handler,
-#endif
-	NULL
-};
-
-static struct inode_operations devpts_file_inode_operations = {
-#ifdef CONFIG_DEVPTS_FS_XATTR
-	.setxattr	= generic_setxattr,
-	.getxattr	= generic_getxattr,
-	.listxattr	= generic_listxattr,
-	.removexattr	= generic_removexattr,
-#endif
-};
-
 static struct vfsmount *devpts_mnt;
 static struct dentry *devpts_root;
 
@@ -102,7 +83,6 @@ devpts_fill_super(struct super_block *s,
 	s->s_blocksize_bits = 10;
 	s->s_magic = DEVPTS_SUPER_MAGIC;
 	s->s_op = &devpts_sops;
-	s->s_xattr = devpts_xattr_handlers;
 	s->s_time_gran = 1;
 
 	inode = new_inode(s);
@@ -175,7 +155,6 @@ int devpts_pty_new(struct tty_struct *tt
 	inode->i_gid = config.setgid ? config.gid : current->fsgid;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	init_special_inode(inode, S_IFCHR|config.mode, device);
-	inode->i_op = &devpts_file_inode_operations;
 	inode->u.generic_ip = tty;
 
 	dentry = get_node(number);
diff -X /home/sds/dontdiff -Nrup linux-2.6.13-rc6-mm2/fs/devpts/Makefile linux-2.6.13-rc6-mm2-xattr/fs/devpts/Makefile
--- linux-2.6.13-rc6-mm2/fs/devpts/Makefile	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-rc6-mm2-xattr/fs/devpts/Makefile	2005-08-24 07:57:51.000000000 -0400
@@ -5,4 +5,3 @@
 obj-$(CONFIG_UNIX98_PTYS)		+= devpts.o
 
 devpts-$(CONFIG_UNIX98_PTYS)		:= inode.o
-devpts-$(CONFIG_DEVPTS_FS_SECURITY)	+= xattr_security.o
diff -X /home/sds/dontdiff -Nrup linux-2.6.13-rc6-mm2/fs/devpts/xattr_security.c linux-2.6.13-rc6-mm2-xattr/fs/devpts/xattr_security.c
--- linux-2.6.13-rc6-mm2/fs/devpts/xattr_security.c	2005-06-17 15:48:29.000000000 -0400
+++ linux-2.6.13-rc6-mm2-xattr/fs/devpts/xattr_security.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,47 +0,0 @@
-/*
- * Security xattr support for devpts.
- *
- * Author: Stephen Smalley <sds@epoch.ncsc.mil>
- * Copyright (c) 2004 Red Hat, Inc., James Morris <jmorris@redhat.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the Free
- * Software Foundation; either version 2 of the License, or (at your option)
- * any later version.
- */
-#include <linux/string.h>
-#include <linux/fs.h>
-#include <linux/security.h>
-#include <linux/xattr.h>
-
-static size_t
-devpts_xattr_security_list(struct inode *inode, char *list, size_t list_len,
-			   const char *name, size_t name_len)
-{
-	return security_inode_listsecurity(inode, list, list_len);
-}
-
-static int
-devpts_xattr_security_get(struct inode *inode, const char *name,
-			  void *buffer, size_t size)
-{
-	if (strcmp(name, "") == 0)
-		return -EINVAL;
-	return security_inode_getsecurity(inode, name, buffer, size);
-}
-
-static int
-devpts_xattr_security_set(struct inode *inode, const char *name,
-			  const void *value, size_t size, int flags)
-{
-	if (strcmp(name, "") == 0)
-		return -EINVAL;
-	return security_inode_setsecurity(inode, name, value, size, flags);
-}
-
-struct xattr_handler devpts_xattr_security_handler = {
-	.prefix	= XATTR_SECURITY_PREFIX,
-	.list	= devpts_xattr_security_list,
-	.get	= devpts_xattr_security_get,
-	.set	= devpts_xattr_security_set,
-};
diff -X /home/sds/dontdiff -Nrup linux-2.6.13-rc6-mm2/fs/Kconfig linux-2.6.13-rc6-mm2-xattr/fs/Kconfig
--- linux-2.6.13-rc6-mm2/fs/Kconfig	2005-08-24 07:53:59.000000000 -0400
+++ linux-2.6.13-rc6-mm2-xattr/fs/Kconfig	2005-08-24 07:57:51.000000000 -0400
@@ -827,28 +827,6 @@ config SYSFS
 
 	Designers of embedded systems may wish to say N here to conserve space.
 
-config DEVPTS_FS_XATTR
-	bool "/dev/pts Extended Attributes"
-	depends on UNIX98_PTYS
-	help
-	  Extended attributes are name:value pairs associated with inodes by
-	  the kernel or by users (see the attr(5) manual page, or visit
-	  <http://acl.bestbits.at/> for details).
-
-	  If unsure, say N.
-
-config DEVPTS_FS_SECURITY
-	bool "/dev/pts Security Labels"
-	depends on DEVPTS_FS_XATTR
-	help
-	  Security labels support alternative access control models
-	  implemented by security modules like SELinux.  This option
-	  enables an extended attribute handler for file security
-	  labels in the /dev/pts filesystem.
-
-	  If you are not using a security module that requires using
-	  extended attributes for file security labels, say N.
-
 config TMPFS
 	bool "Virtual memory file system support (former shm fs)"
 	help
@@ -861,27 +839,6 @@ config TMPFS
 
 	  See <file:Documentation/filesystems/tmpfs.txt> for details.
 
-config TMPFS_XATTR
-	bool "tmpfs Extended Attributes"
-	depends on TMPFS
-	help
-	  Extended attributes are name:value pairs associated with inodes by
-	  the kernel or by users (see the attr(5) manual page, or visit
-	  <http://acl.bestbits.at/> for details).
-
-	  If unsure, say N.
-
-config TMPFS_SECURITY
-	bool "tmpfs Security Labels"
-	depends on TMPFS_XATTR
-	help
-	  Security labels support alternative access control models
-	  implemented by security modules like SELinux.  This option
-	  enables an extended attribute handler for file security
-	  labels in the tmpfs filesystem.
-	  If you are not using a security module that requires using
-	  extended attributes for file security labels, say N.
-
 config HUGETLBFS
 	bool "HugeTLB file system support"
 	depends X86 || IA64 || PPC64 || SPARC64 || SUPERH || X86_64 || BROKEN
diff -X /home/sds/dontdiff -Nrup linux-2.6.13-rc6-mm2/fs/xattr.c linux-2.6.13-rc6-mm2-xattr/fs/xattr.c
--- linux-2.6.13-rc6-mm2/fs/xattr.c	2005-08-24 07:54:03.000000000 -0400
+++ linux-2.6.13-rc6-mm2-xattr/fs/xattr.c	2005-08-24 07:57:51.000000000 -0400
@@ -51,20 +51,29 @@ setxattr(struct dentry *d, char __user *
 		}
 	}
 
+	down(&d->d_inode->i_sem);
+	error = security_inode_setxattr(d, kname, kvalue, size, flags);
+	if (error)
+		goto out;
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->setxattr) {
-		down(&d->d_inode->i_sem);
-		error = security_inode_setxattr(d, kname, kvalue, size, flags);
-		if (error)
-			goto out;
-		error = d->d_inode->i_op->setxattr(d, kname, kvalue, size, flags);
+		error = d->d_inode->i_op->setxattr(d, kname, kvalue,
+						   size, flags);
 		if (!error) {
 			fsnotify_xattr(d);
-			security_inode_post_setxattr(d, kname, kvalue, size, flags);
+			security_inode_post_setxattr(d, kname, kvalue,
+						     size, flags);
 		}
-out:
-		up(&d->d_inode->i_sem);
+	} else if (!strncmp(kname, XATTR_SECURITY_PREFIX,
+			    sizeof XATTR_SECURITY_PREFIX - 1)) {
+		const char *suffix = kname + sizeof XATTR_SECURITY_PREFIX - 1;
+		error = security_inode_setsecurity(d->d_inode, suffix, kvalue,
+						   size, flags);
+		if (!error)
+			fsnotify_xattr(d);
 	}
+out:
+	up(&d->d_inode->i_sem);
 	if (kvalue)
 		kfree(kvalue);
 	return error;
@@ -139,20 +148,25 @@ getxattr(struct dentry *d, char __user *
 			return -ENOMEM;
 	}
 
+	error = security_inode_getxattr(d, kname);
+	if (error)
+		goto out;
 	error = -EOPNOTSUPP;
-	if (d->d_inode->i_op && d->d_inode->i_op->getxattr) {
-		error = security_inode_getxattr(d, kname);
-		if (error)
-			goto out;
+	if (d->d_inode->i_op && d->d_inode->i_op->getxattr)
 		error = d->d_inode->i_op->getxattr(d, kname, kvalue, size);
-		if (error > 0) {
-			if (size && copy_to_user(value, kvalue, error))
-				error = -EFAULT;
-		} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
-			/* The file system tried to returned a value bigger
-			   than XATTR_SIZE_MAX bytes. Not possible. */
-			error = -E2BIG;
-		}
+	else if (!strncmp(kname, XATTR_SECURITY_PREFIX,
+			  sizeof XATTR_SECURITY_PREFIX - 1)) {
+		const char *suffix = kname + sizeof XATTR_SECURITY_PREFIX - 1;
+		error = security_inode_getsecurity(d->d_inode, suffix, kvalue,
+						   size);
+	}
+	if (error > 0) {
+		if (size && copy_to_user(value, kvalue, error))
+			error = -EFAULT;
+	} else if (error == -ERANGE && size >= XATTR_SIZE_MAX) {
+		/* The file system tried to returned a value bigger
+		   than XATTR_SIZE_MAX bytes. Not possible. */
+		error = -E2BIG;
 	}
 out:
 	if (kvalue)
@@ -221,20 +235,24 @@ listxattr(struct dentry *d, char __user 
 			return -ENOMEM;
 	}
 
+	error = security_inode_listxattr(d);
+	if (error)
+		goto out;
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->listxattr) {
-		error = security_inode_listxattr(d);
-		if (error)
-			goto out;
 		error = d->d_inode->i_op->listxattr(d, klist, size);
-		if (error > 0) {
-			if (size && copy_to_user(list, klist, error))
-				error = -EFAULT;
-		} else if (error == -ERANGE && size >= XATTR_LIST_MAX) {
-			/* The file system tried to returned a list bigger
-			   than XATTR_LIST_MAX bytes. Not possible. */
-			error = -E2BIG;
-		}
+	} else {
+		error = security_inode_listsecurity(d->d_inode, klist, size);
+		if (size && error >= size)
+			error = -ERANGE;
+	}
+	if (error > 0) {
+		if (size && copy_to_user(list, klist, error))
+			error = -EFAULT;
+	} else if (error == -ERANGE && size >= XATTR_LIST_MAX) {
+		/* The file system tried to returned a list bigger
+		   than XATTR_LIST_MAX bytes. Not possible. */
+		error = -E2BIG;
 	}
 out:
 	if (klist)
diff -X /home/sds/dontdiff -Nrup linux-2.6.13-rc6-mm2/mm/shmem.c linux-2.6.13-rc6-mm2-xattr/mm/shmem.c
--- linux-2.6.13-rc6-mm2/mm/shmem.c	2005-08-24 07:54:05.000000000 -0400
+++ linux-2.6.13-rc6-mm2-xattr/mm/shmem.c	2005-08-24 07:57:52.000000000 -0400
@@ -45,7 +45,6 @@
 #include <linux/swapops.h>
 #include <linux/mempolicy.h>
 #include <linux/namei.h>
-#include <linux/xattr.h>
 #include <asm/uaccess.h>
 #include <asm/div64.h>
 #include <asm/pgtable.h>
@@ -179,7 +178,6 @@ static struct address_space_operations s
 static struct file_operations shmem_file_operations;
 static struct inode_operations shmem_inode_operations;
 static struct inode_operations shmem_dir_inode_operations;
-static struct inode_operations shmem_special_inode_operations;
 static struct vm_operations_struct shmem_vm_ops;
 
 static struct backing_dev_info shmem_backing_dev_info = {
@@ -1301,7 +1299,6 @@ shmem_get_inode(struct super_block *sb, 
 
 		switch (mode & S_IFMT) {
 		default:
-			inode->i_op = &shmem_special_inode_operations;
 			init_special_inode(inode, mode, dev);
 			break;
 		case S_IFREG:
@@ -1823,12 +1820,6 @@ static void shmem_put_link(struct dentry
 static struct inode_operations shmem_symlink_inline_operations = {
 	.readlink	= generic_readlink,
 	.follow_link	= shmem_follow_link_inline,
-#ifdef CONFIG_TMPFS_XATTR
-	.setxattr       = generic_setxattr,
-	.getxattr       = generic_getxattr,
-	.listxattr      = generic_listxattr,
-	.removexattr    = generic_removexattr,
-#endif
 };
 
 static struct inode_operations shmem_symlink_inode_operations = {
@@ -1836,12 +1827,6 @@ static struct inode_operations shmem_sym
 	.readlink	= generic_readlink,
 	.follow_link	= shmem_follow_link,
 	.put_link	= shmem_put_link,
-#ifdef CONFIG_TMPFS_XATTR
-	.setxattr       = generic_setxattr,
-	.getxattr       = generic_getxattr,
-	.listxattr      = generic_listxattr,
-	.removexattr    = generic_removexattr,
-#endif
 };
 
 static int shmem_parse_options(char *options, int *mode, uid_t *uid, gid_t *gid, unsigned long *blocks, unsigned long *inodes)
@@ -1961,12 +1946,6 @@ static void shmem_put_super(struct super
 	sb->s_fs_info = NULL;
 }
 
-#ifdef CONFIG_TMPFS_XATTR
-static struct xattr_handler *shmem_xattr_handlers[];
-#else
-#define shmem_xattr_handlers NULL
-#endif
-
 static int shmem_fill_super(struct super_block *sb,
 			    void *data, int silent)
 {
@@ -2017,7 +1996,6 @@ static int shmem_fill_super(struct super
 	sb->s_blocksize_bits = PAGE_CACHE_SHIFT;
 	sb->s_magic = TMPFS_MAGIC;
 	sb->s_op = &shmem_ops;
-	sb->s_xattr = shmem_xattr_handlers;
 
 	inode = shmem_get_inode(sb, S_IFDIR | mode, 0);
 	if (!inode)
@@ -2106,12 +2084,6 @@ static struct file_operations shmem_file
 static struct inode_operations shmem_inode_operations = {
 	.truncate	= shmem_truncate,
 	.setattr	= shmem_notify_change,
-#ifdef CONFIG_TMPFS_XATTR
-	.setxattr       = generic_setxattr,
-	.getxattr       = generic_getxattr,
-	.listxattr      = generic_listxattr,
-	.removexattr    = generic_removexattr,
-#endif
 };
 
 static struct inode_operations shmem_dir_inode_operations = {
@@ -2125,21 +2097,6 @@ static struct inode_operations shmem_dir
 	.rmdir		= shmem_rmdir,
 	.mknod		= shmem_mknod,
 	.rename		= shmem_rename,
-#ifdef CONFIG_TMPFS_XATTR
-	.setxattr       = generic_setxattr,
-	.getxattr       = generic_getxattr,
-	.listxattr      = generic_listxattr,
-	.removexattr    = generic_removexattr,
-#endif
-#endif
-};
-
-static struct inode_operations shmem_special_inode_operations = {
-#ifdef CONFIG_TMPFS_XATTR
-	.setxattr	= generic_setxattr,
-	.getxattr	= generic_getxattr,
-	.listxattr	= generic_listxattr,
-	.removexattr	= generic_removexattr,
 #endif
 };
 
@@ -2165,48 +2122,6 @@ static struct vm_operations_struct shmem
 };
 
 
-#ifdef CONFIG_TMPFS_SECURITY
-
-static size_t shmem_xattr_security_list(struct inode *inode, char *list, size_t list_len,
-					const char *name, size_t name_len)
-{
-	return security_inode_listsecurity(inode, list, list_len);
-}
-
-static int shmem_xattr_security_get(struct inode *inode, const char *name, void *buffer, size_t size)
-{
-	if (strcmp(name, "") == 0)
-		return -EINVAL;
-	return security_inode_getsecurity(inode, name, buffer, size);
-}
-
-static int shmem_xattr_security_set(struct inode *inode, const char *name, const void *value, size_t size, int flags)
-{
-	if (strcmp(name, "") == 0)
-		return -EINVAL;
-	return security_inode_setsecurity(inode, name, value, size, flags);
-}
-
-static struct xattr_handler shmem_xattr_security_handler = {
-	.prefix	= XATTR_SECURITY_PREFIX,
-	.list	= shmem_xattr_security_list,
-	.get	= shmem_xattr_security_get,
-	.set	= shmem_xattr_security_set,
-};
-
-#endif	/* CONFIG_TMPFS_SECURITY */
-
-#ifdef CONFIG_TMPFS_XATTR
-
-static struct xattr_handler *shmem_xattr_handlers[] = {
-#ifdef CONFIG_TMPFS_SECURITY
-	&shmem_xattr_security_handler,
-#endif
-	NULL
-};
-
-#endif	/* CONFIG_TMPFS_XATTR */
-
 static struct super_block *shmem_get_sb(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {

-- 
Stephen Smalley
National Security Agency

