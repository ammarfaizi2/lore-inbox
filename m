Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312731AbSCYWSo>; Mon, 25 Mar 2002 17:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312737AbSCYWSh>; Mon, 25 Mar 2002 17:18:37 -0500
Received: from zok.SGI.COM ([204.94.215.101]:4841 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S312731AbSCYWSd>;
	Mon, 25 Mar 2002 17:18:33 -0500
Date: Tue, 26 Mar 2002 09:18:13 +1100
From: Nathan Scott <nathans@sgi.com>
To: Kain <kain@kain.org>, Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] PPC syscalls for XFS
Message-ID: <20020326091813.J42289@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,

On Mon, Mar 25, 2002 at 07:10:32AM -0600, Kain wrote:
> 
> To whom it may concern, I'd like to get some PPC syscalls reserved for
> XFS xattr support, with syscalls #226-#237 to the xattr support; this is
> the same position and range that is used for these syscalls on i386.
> 

Syscall numbers already exist for PPC, see the 2.5 tree (the numbers
you've suggested are not the same, btw, so should not be used).  Also,
in case its unclear; use of 'x' in xattr stands for eXtended, not Xfs,
as your "Subject:" line suggests.

Marcelo - attached is the 2.4 backport of this again, it didn't seem
to make it into 2.4.19[-pre3/4], when last I forwarded it on.

cheers.

-- 
Nathan

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="xattr-2.4.19-pre4.patch"

diff -Naur pristine-2.4.19-pre4/Documentation/filesystems/Locking xattr-2.4.19-pre4/Documentation/filesystems/Locking
--- pristine-2.4.19-pre4/Documentation/filesystems/Locking	Tue Mar 26 08:42:01 2002
+++ xattr-2.4.19-pre4/Documentation/filesystems/Locking	Tue Mar 26 08:40:31 2002
@@ -45,6 +45,10 @@
 	int (*revalidate) (struct dentry *);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct dentry *, struct iattr *);
+	int (*setxattr) (struct dentry *, const char *, void *, size_t, int);
+	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
+	ssize_t (*listxattr) (struct dentry *, char *, size_t);
+	int (*removexattr) (struct dentry *, const char *);
 
 locking rules:
 	all may block
@@ -61,9 +65,13 @@
 follow_link:	no	no		no
 truncate:	yes	yes		no		(see below)
 setattr:	yes	if ATTR_SIZE	no
-permssion:	yes	no		no
+permission:	yes	no		no
 getattr:						(see below)
 revalidate:	no					(see below)
+setxattr:	yes	no		no
+getxattr:	yes	no		no
+listxattr:	yes	no		no
+removexattr:	yes	no		no
 	Additionally, ->rmdir() has i_zombie on victim and so does ->rename()
 in case when target exists and is a directory.
 	->rename() on directories has (per-superblock) ->s_vfs_rename_sem.
diff -Naur pristine-2.4.19-pre4/arch/i386/kernel/entry.S xattr-2.4.19-pre4/arch/i386/kernel/entry.S
--- pristine-2.4.19-pre4/arch/i386/kernel/entry.S	Tue Mar 26 08:42:01 2002
+++ xattr-2.4.19-pre4/arch/i386/kernel/entry.S	Tue Mar 26 08:40:31 2002
@@ -622,18 +622,18 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* Reserved for Security */
 	.long SYMBOL_NAME(sys_gettid)
 	.long SYMBOL_NAME(sys_readahead)	/* 225 */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for setxattr */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for lsetxattr */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for fsetxattr */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for getxattr */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* 230 reserved for lgetxattr */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for fgetxattr */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for listxattr */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for llistxattr */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for flistxattr */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* 235 reserved for removexattr */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for lremovexattr */
-	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for fremovexattr */
+	.long SYMBOL_NAME(sys_setxattr)
+	.long SYMBOL_NAME(sys_lsetxattr)
+	.long SYMBOL_NAME(sys_fsetxattr)
+	.long SYMBOL_NAME(sys_getxattr)
+	.long SYMBOL_NAME(sys_lgetxattr)	/* 230 */
+	.long SYMBOL_NAME(sys_fgetxattr)
+	.long SYMBOL_NAME(sys_listxattr)
+	.long SYMBOL_NAME(sys_llistxattr)
+	.long SYMBOL_NAME(sys_flistxattr)
+	.long SYMBOL_NAME(sys_removexattr)	/* 235 */
+	.long SYMBOL_NAME(sys_lremovexattr)
+	.long SYMBOL_NAME(sys_fremovexattr)
  	.long SYMBOL_NAME(sys_tkill)
 
 	.rept NR_syscalls-(.-sys_call_table)/4
diff -Naur pristine-2.4.19-pre4/fs/Makefile xattr-2.4.19-pre4/fs/Makefile
--- pristine-2.4.19-pre4/fs/Makefile	Tue Feb 26 07:15:53 2002
+++ xattr-2.4.19-pre4/fs/Makefile	Tue Mar 26 08:40:31 2002
@@ -14,7 +14,7 @@
 		super.o block_dev.o char_dev.o stat.o exec.o pipe.o namei.o \
 		fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
-		filesystems.o namespace.o seq_file.o
+		filesystems.o namespace.o seq_file.o xattr.o
 
 ifeq ($(CONFIG_QUOTA),y)
 obj-y += dquot.o
diff -Naur pristine-2.4.19-pre4/fs/xattr.c xattr-2.4.19-pre4/fs/xattr.c
--- pristine-2.4.19-pre4/fs/xattr.c	Thu Jan  1 10:00:00 1970
+++ xattr-2.4.19-pre4/fs/xattr.c	Tue Mar 26 08:40:31 2002
@@ -0,0 +1,347 @@
+/*
+  File: fs/xattr.c
+
+  Extended attribute handling.
+
+  Copyright (C) 2001 by Andreas Gruenbacher <a.gruenbacher@computer.org>
+  Copyright (C) 2001 SGI - Silicon Graphics, Inc <linux-xfs@oss.sgi.com>
+ */
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/smp_lock.h>
+#include <linux/file.h>
+#include <linux/xattr.h>
+#include <asm/uaccess.h>
+
+/*
+ * Extended attribute memory allocation wrappers, originally
+ * based on the Intermezzo PRESTO_ALLOC/PRESTO_FREE macros.
+ * The vmalloc use here is very uncommon - extended attributes
+ * are supposed to be small chunks of metadata, and it is quite
+ * unusual to have very many extended attributes, so lists tend
+ * to be quite short as well.  The 64K upper limit is derived
+ * from the extended attribute size limit used by XFS.
+ * Intentionally allow zero @size for value/list size requests.
+ */
+static void *
+xattr_alloc(size_t size, size_t limit)
+{
+	void *ptr;
+
+	if (size > limit)
+		return ERR_PTR(-E2BIG);
+
+	if (!size)	/* size request, no buffer is needed */
+		return NULL;
+	else if (size <= PAGE_SIZE)
+		ptr = kmalloc((unsigned long) size, GFP_KERNEL);
+	else
+		ptr = vmalloc((unsigned long) size);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+	return ptr;
+}
+
+static void
+xattr_free(void *ptr, size_t size)
+{
+	if (!size)	/* size request, no buffer was needed */
+		return;
+	else if (size <= PAGE_SIZE)
+		kfree(ptr);
+	else
+		vfree(ptr);
+}
+
+/*
+ * Extended attribute SET operations
+ */
+static long
+setxattr(struct dentry *d, char *name, void *value, size_t size, int flags)
+{
+	int error;
+	void *kvalue;
+	char kname[XATTR_NAME_MAX + 1];
+
+	if (flags & ~(XATTR_CREATE|XATTR_REPLACE))
+		return -EINVAL;
+
+	error = strncpy_from_user(kname, name, sizeof(kname));
+	if (error == 0 || error == sizeof(kname))
+		error = -ERANGE;
+	if (error < 0)
+		return error;
+
+	kvalue = xattr_alloc(size, XATTR_SIZE_MAX);
+	if (IS_ERR(kvalue))
+		return PTR_ERR(kvalue);
+
+	if (size > 0 && copy_from_user(kvalue, value, size)) {
+		xattr_free(kvalue, size);
+		return -EFAULT;
+	}
+
+	error = -EOPNOTSUPP;
+	if (d->d_inode->i_op && d->d_inode->i_op->setxattr) {
+		lock_kernel();
+		error = d->d_inode->i_op->setxattr(d, kname, kvalue, size, flags);
+		unlock_kernel();
+	}
+
+	xattr_free(kvalue, size);
+	return error;
+}
+
+asmlinkage long
+sys_setxattr(char *path, char *name, void *value, size_t size, int flags)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk(path, &nd);
+	if (error)
+		return error;
+	error = setxattr(nd.dentry, name, value, size, flags);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage long
+sys_lsetxattr(char *path, char *name, void *value, size_t size, int flags)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk_link(path, &nd);
+	if (error)
+		return error;
+	error = setxattr(nd.dentry, name, value, size, flags);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage long
+sys_fsetxattr(int fd, char *name, void *value, size_t size, int flags)
+{
+	struct file *f;
+	int error = -EBADF;
+
+	f = fget(fd);
+	if (!f)
+		return error;
+	error = setxattr(f->f_dentry, name, value, size, flags);
+	fput(f);
+	return error;
+}
+
+/*
+ * Extended attribute GET operations
+ */
+static ssize_t
+getxattr(struct dentry *d, char *name, void *value, size_t size)
+{
+	ssize_t error;
+	void *kvalue;
+	char kname[XATTR_NAME_MAX + 1];
+
+	error = strncpy_from_user(kname, name, sizeof(kname));
+	if (error == 0 || error == sizeof(kname))
+		error = -ERANGE;
+	if (error < 0)
+		return error;
+
+	kvalue = xattr_alloc(size, XATTR_SIZE_MAX);
+	if (IS_ERR(kvalue))
+		return PTR_ERR(kvalue);
+
+	error = -EOPNOTSUPP;
+	if (d->d_inode->i_op && d->d_inode->i_op->getxattr) {
+		lock_kernel();
+		error = d->d_inode->i_op->getxattr(d, kname, kvalue, size);
+		unlock_kernel();
+	}
+
+	if (kvalue && error > 0)
+		if (copy_to_user(value, kvalue, error))
+			error = -EFAULT;
+	xattr_free(kvalue, size);
+	return error;
+}
+
+asmlinkage ssize_t
+sys_getxattr(char *path, char *name, void *value, size_t size)
+{
+	struct nameidata nd;
+	ssize_t error;
+
+	error = user_path_walk(path, &nd);
+	if (error)
+		return error;
+	error = getxattr(nd.dentry, name, value, size);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage ssize_t
+sys_lgetxattr(char *path, char *name, void *value, size_t size)
+{
+	struct nameidata nd;
+	ssize_t error;
+
+	error = user_path_walk_link(path, &nd);
+	if (error)
+		return error;
+	error = getxattr(nd.dentry, name, value, size);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage ssize_t
+sys_fgetxattr(int fd, char *name, void *value, size_t size)
+{
+	struct file *f;
+	ssize_t error = -EBADF;
+
+	f = fget(fd);
+	if (!f)
+		return error;
+	error = getxattr(f->f_dentry, name, value, size);
+	fput(f);
+	return error;
+}
+
+/*
+ * Extended attribute LIST operations
+ */
+static ssize_t
+listxattr(struct dentry *d, char *list, size_t size)
+{
+	ssize_t error;
+	char *klist;
+
+	klist = (char *)xattr_alloc(size, XATTR_LIST_MAX);
+	if (IS_ERR(klist))
+		return PTR_ERR(klist);
+
+	error = -EOPNOTSUPP;
+	if (d->d_inode->i_op && d->d_inode->i_op->listxattr) {
+		lock_kernel();
+		error = d->d_inode->i_op->listxattr(d, klist, size);
+		unlock_kernel();
+	}
+
+	if (klist && error > 0)
+		if (copy_to_user(list, klist, error))
+			error = -EFAULT;
+	xattr_free(klist, size);
+	return error;
+}
+
+asmlinkage ssize_t
+sys_listxattr(char *path, char *list, size_t size)
+{
+	struct nameidata nd;
+	ssize_t error;
+
+	error = user_path_walk(path, &nd);
+	if (error)
+		return error;
+	error = listxattr(nd.dentry, list, size);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage ssize_t
+sys_llistxattr(char *path, char *list, size_t size)
+{
+	struct nameidata nd;
+	ssize_t error;
+
+	error = user_path_walk_link(path, &nd);
+	if (error)
+		return error;
+	error = listxattr(nd.dentry, list, size);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage ssize_t
+sys_flistxattr(int fd, char *list, size_t size)
+{
+	struct file *f;
+	ssize_t error = -EBADF;
+
+	f = fget(fd);
+	if (!f)
+		return error;
+	error = listxattr(f->f_dentry, list, size);
+	fput(f);
+	return error;
+}
+
+/*
+ * Extended attribute REMOVE operations
+ */
+static long
+removexattr(struct dentry *d, char *name)
+{
+	int error;
+	char kname[XATTR_NAME_MAX + 1];
+
+	error = strncpy_from_user(kname, name, sizeof(kname));
+	if (error == 0 || error == sizeof(kname))
+		error = -ERANGE;
+	if (error < 0)
+		return error;
+
+	error = -EOPNOTSUPP;
+	if (d->d_inode->i_op && d->d_inode->i_op->removexattr) {
+		lock_kernel();
+		error = d->d_inode->i_op->removexattr(d, kname);
+		unlock_kernel();
+	}
+	return error;
+}
+
+asmlinkage long
+sys_removexattr(char *path, char *name)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk(path, &nd);
+	if (error)
+		return error;
+	error = removexattr(nd.dentry, name);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage long
+sys_lremovexattr(char *path, char *name)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk_link(path, &nd);
+	if (error)
+		return error;
+	error = removexattr(nd.dentry, name);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage long
+sys_fremovexattr(int fd, char *name)
+{
+	struct file *f;
+	int error = -EBADF;
+
+	f = fget(fd);
+	if (!f)
+		return error;
+	error = removexattr(f->f_dentry, name);
+	fput(f);
+	return error;
+}
diff -Naur pristine-2.4.19-pre4/include/linux/fs.h xattr-2.4.19-pre4/include/linux/fs.h
--- pristine-2.4.19-pre4/include/linux/fs.h	Tue Mar 26 08:42:06 2002
+++ xattr-2.4.19-pre4/include/linux/fs.h	Tue Mar 26 08:40:31 2002
@@ -861,6 +861,10 @@
 	int (*revalidate) (struct dentry *);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct dentry *, struct iattr *);
+	int (*setxattr) (struct dentry *, const char *, void *, size_t, int);
+	ssize_t (*getxattr) (struct dentry *, const char *, void *, size_t);
+	ssize_t (*listxattr) (struct dentry *, char *, size_t);
+	int (*removexattr) (struct dentry *, const char *);
 };
 
 struct seq_file;
diff -Naur pristine-2.4.19-pre4/include/linux/limits.h xattr-2.4.19-pre4/include/linux/limits.h
--- pristine-2.4.19-pre4/include/linux/limits.h	Tue Feb 26 07:16:05 2002
+++ xattr-2.4.19-pre4/include/linux/limits.h	Tue Mar 26 08:40:31 2002
@@ -13,6 +13,9 @@
 #define NAME_MAX         255	/* # chars in a file name */
 #define PATH_MAX        4096	/* # chars in a path name including nul */
 #define PIPE_BUF        4096	/* # bytes in atomic write to a pipe */
+#define XATTR_NAME_MAX   255	/* # chars in an extended attribute name */
+#define XATTR_SIZE_MAX 65536   /* size of an extended attribute value (64k) */
+#define XATTR_LIST_MAX 65536   /* size of extended attribute namelist (64k) */
 
 #define RTSIG_MAX	  32
 
diff -Naur pristine-2.4.19-pre4/include/linux/xattr.h xattr-2.4.19-pre4/include/linux/xattr.h
--- pristine-2.4.19-pre4/include/linux/xattr.h	Thu Jan  1 10:00:00 1970
+++ xattr-2.4.19-pre4/include/linux/xattr.h	Tue Mar 26 08:40:31 2002
@@ -0,0 +1,15 @@
+/*
+  File: linux/xattr.h
+
+  Extended attributes handling.
+
+  Copyright (C) 2001 by Andreas Gruenbacher <a.gruenbacher@computer.org>
+  Copyright (C) 2001 SGI - Silicon Graphics, Inc <linux-xfs@oss.sgi.com>
+*/
+#ifndef _LINUX_XATTR_H
+#define _LINUX_XATTR_H
+
+#define XATTR_CREATE	0x1	/* set value, fail if attr already exists */
+#define XATTR_REPLACE	0x2	/* set value, fail if attr does not exist */
+
+#endif	/* _LINUX_XATTR_H */

--M9NhX3UHpAaciwkO--
