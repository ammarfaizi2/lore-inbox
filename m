Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287193AbSA2XtG>; Tue, 29 Jan 2002 18:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbSA2Xr5>; Tue, 29 Jan 2002 18:47:57 -0500
Received: from rj.SGI.COM ([204.94.215.100]:52698 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S287344AbSA2XkS>;
	Tue, 29 Jan 2002 18:40:18 -0500
Date: Wed, 30 Jan 2002 10:40:04 +1100
From: Nathan Scott <nathans@sgi.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <ag@bestbits.at>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130104004.C81308@wobbly.melbourne.sgi.com>
In-Reply-To: <p73d6zshidj.fsf@oldwotan.suse.de> <Pine.LNX.4.33.0201291502460.1747-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201291502460.1747-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Jan 29, 2002 at 03:13:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Linus,

On Tue, Jan 29, 2002 at 03:13:14PM -0800, Linus Torvalds wrote:
> 
> On 30 Jan 2002, Andi Kleen wrote:
> > Does that answer your questions?
> > Would you look at a patch again?
> 
> That answers the specific questions about Al and Stephen.

Al had several (additional) issues with the original patch, but I
think we progressively worked through them - Al stopped suggesting
changes at one point anyway, and the level of abuse died away ;),
so I guess he became more satisfied with them.

> It does NOT address whether consensus has been reached in general, and
> whether people are happy. Is that the case?

I believe so - I know that the ext2/ext3 EA/ACL maintainer 
(AndreasG, CCd) is satisfied with the current patches, from
an XFS point of view they satisfy all our needs, and Anton
has chimed in saying this interface will work well for NTFS
EA support (Anton sent me patches and several suggestions as
well, which were included in the patch at the time).

> Also, obviously nobody actually took over maintainership of the patch,
> because equally obviously nobody has been pinging me about it. For some
> reason you seem to want _me_ to go out of my way to search for patches
> that are over a month old that I don't know whether they are valid or not,
> used or not, or even agreed upon or not.
> 
> But yes, it's so much easier to blame me.
> 

Not much point apportioning blame - its as much my fault - I
hadn't heard back from you at all since day 1, so figured you
were just not interested in this stuff, so I stopped sending.

The two patches which seemed to satisfy the most people are
below - they are unchanged from 2.5.0 but should apply to any
2.5.x tree (they are fairly non-intrusive and the system call
table hasn't changed since last time).  A complete userspace
implementation for both EAs and POSIX ACLs exists above these
interfaces.

cheers.

-- 
Nathan


[Patch #1: reserve syscall numbers]

diff -Naur 2.5.0-pristine/arch/i386/kernel/entry.S 2.5.0-reserved/arch/i386/kernel/entry.S
--- 2.5.0-pristine/arch/i386/kernel/entry.S	Sat Nov  3 12:18:49 2001
+++ 2.5.0-reserved/arch/i386/kernel/entry.S	Tue Dec  4 11:57:32 2001
@@ -622,6 +622,18 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* Reserved for Security */
 	.long SYMBOL_NAME(sys_gettid)
 	.long SYMBOL_NAME(sys_readahead)	/* 225 */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for setxattr */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for lsetxattr */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for fsetxattr */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for getxattr */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* 230 reserved for lgetxattr */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for fgetxattr */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for listxattr */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for llistxattr */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for flistxattr */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* 235 reserved for removexattr */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for lremovexattr */
+	.long SYMBOL_NAME(sys_ni_syscall)	/* reserved for fremovexattr */
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -Naur 2.5.0-pristine/include/asm-i386/unistd.h 2.5.0-reserved/include/asm-i386/unistd.h
--- 2.5.0-pristine/include/asm-i386/unistd.h	Thu Oct 18 03:03:03 2001
+++ 2.5.0-reserved/include/asm-i386/unistd.h	Tue Dec  4 11:58:21 2001
@@ -230,6 +230,18 @@
 #define __NR_security		223	/* syscall for security modules */
 #define __NR_gettid		224
 #define __NR_readahead		225
+#define __NR_setxattr		226
+#define __NR_lsetxattr		227
+#define __NR_fsetxattr		228
+#define __NR_getxattr		229
+#define __NR_lgetxattr		230
+#define __NR_fgetxattr		231
+#define __NR_listxattr		232
+#define __NR_llistxattr		233
+#define __NR_flistxattr		234
+#define __NR_removexattr	235
+#define __NR_lremovexattr	236
+#define __NR_fremovexattr	237
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 


[Patch #2: VFS implementation]

diff -Naur 2.5.0-pristine/arch/i386/kernel/entry.S 2.5.0-xattr/arch/i386/kernel/entry.S
--- 2.5.0-pristine/arch/i386/kernel/entry.S	Sat Nov  3 12:18:49 2001
+++ 2.5.0-xattr/arch/i386/kernel/entry.S	Thu Dec  6 12:59:47 2001
@@ -622,6 +622,18 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* Reserved for Security */
 	.long SYMBOL_NAME(sys_gettid)
 	.long SYMBOL_NAME(sys_readahead)	/* 225 */
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
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -Naur 2.5.0-pristine/fs/Makefile 2.5.0-xattr/fs/Makefile
--- 2.5.0-pristine/fs/Makefile	Tue Nov 13 04:34:16 2001
+++ 2.5.0-xattr/fs/Makefile	Thu Dec  6 12:59:47 2001
@@ -14,7 +14,7 @@
 		super.o block_dev.o char_dev.o stat.o exec.o pipe.o namei.o \
 		fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
-		filesystems.o namespace.o seq_file.o
+		filesystems.o namespace.o seq_file.o xattr.o
 
 ifeq ($(CONFIG_QUOTA),y)
 obj-y += dquot.o
diff -Naur 2.5.0-pristine/fs/xattr.c 2.5.0-xattr/fs/xattr.c
--- 2.5.0-pristine/fs/xattr.c	Thu Jan  1 10:00:00 1970
+++ 2.5.0-xattr/fs/xattr.c	Thu Dec  6 12:59:58 2001
@@ -0,0 +1,341 @@
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
+	if (copy_from_user(kname, name, XATTR_NAME_MAX))
+		return -EFAULT;
+	kname[XATTR_NAME_MAX] = '\0';
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
+static long
+getxattr(struct dentry *d, char *name, void *value, size_t size)
+{
+	int error;
+	void *kvalue;
+	char kname[XATTR_NAME_MAX + 1];
+
+	if (copy_from_user(kname, name, XATTR_NAME_MAX))
+		return -EFAULT;
+	kname[XATTR_NAME_MAX] = '\0';
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
+		if (copy_to_user(value, kvalue, size))
+			error = -EFAULT;
+	xattr_free(kvalue, size);
+	return error;
+}
+
+asmlinkage long
+sys_getxattr(char *path, char *name, void *value, size_t size)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk(path, &nd);
+	if (error)
+		return error;
+	error = getxattr(nd.dentry, name, value, size);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage long
+sys_lgetxattr(char *path, char *name, void *value, size_t size)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk_link(path, &nd);
+	if (error)
+		return error;
+	error = getxattr(nd.dentry, name, value, size);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage long
+sys_fgetxattr(int fd, char *name, void *value, size_t size)
+{
+	struct file *f;
+	int error = -EBADF;
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
+static long
+listxattr(struct dentry *d, char *list, size_t size)
+{
+	int error;
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
+		if (copy_to_user(list, klist, size))
+			error = -EFAULT;
+	xattr_free(klist, size);
+	return error;
+}
+
+asmlinkage long
+sys_listxattr(char *path, char *list, size_t size)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk(path, &nd);
+	if (error)
+		return error;
+	error = listxattr(nd.dentry, list, size);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage long
+sys_llistxattr(char *path, char *list, size_t size)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk_link(path, &nd);
+	if (error)
+		return error;
+	error = listxattr(nd.dentry, list, size);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage long
+sys_flistxattr(int fd, char *list, size_t size)
+{
+	struct file *f;
+	int error = -EBADF;
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
+	if (copy_from_user(kname, name, XATTR_NAME_MAX))
+		return -EFAULT;
+	kname[XATTR_NAME_MAX] = '\0';
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
diff -Naur 2.5.0-pristine/include/asm-i386/unistd.h 2.5.0-xattr/include/asm-i386/unistd.h
--- 2.5.0-pristine/include/asm-i386/unistd.h	Thu Oct 18 03:03:03 2001
+++ 2.5.0-xattr/include/asm-i386/unistd.h	Thu Dec  6 12:59:47 2001
@@ -230,6 +230,18 @@
 #define __NR_security		223	/* syscall for security modules */
 #define __NR_gettid		224
 #define __NR_readahead		225
+#define __NR_setxattr		226
+#define __NR_lsetxattr		227
+#define __NR_fsetxattr		228
+#define __NR_getxattr		229
+#define __NR_lgetxattr		230
+#define __NR_fgetxattr		231
+#define __NR_listxattr		232
+#define __NR_llistxattr		233
+#define __NR_flistxattr		234
+#define __NR_removexattr	235
+#define __NR_lremovexattr	236
+#define __NR_fremovexattr	237
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Naur 2.5.0-pristine/include/linux/fs.h 2.5.0-xattr/include/linux/fs.h
--- 2.5.0-pristine/include/linux/fs.h	Fri Nov 23 06:46:19 2001
+++ 2.5.0-xattr/include/linux/fs.h	Thu Dec  6 12:59:47 2001
@@ -851,6 +851,10 @@
 	int (*revalidate) (struct dentry *);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct dentry *, struct iattr *);
+	int (*setxattr) (struct dentry *, char *, void *, size_t, int);
+	int (*getxattr) (struct dentry *, char *, void *, size_t);
+	int (*listxattr) (struct dentry *, char *, size_t);
+	int (*removexattr) (struct dentry *, char *);
 };
 
 /*
diff -Naur 2.5.0-pristine/include/linux/limits.h 2.5.0-xattr/include/linux/limits.h
--- 2.5.0-pristine/include/linux/limits.h	Thu Jul 29 03:30:10 1999
+++ 2.5.0-xattr/include/linux/limits.h	Thu Dec  6 12:59:47 2001
@@ -13,6 +13,9 @@
 #define NAME_MAX         255	/* # chars in a file name */
 #define PATH_MAX        4095	/* # chars in a path name */
 #define PIPE_BUF        4096	/* # bytes in atomic write to a pipe */
+#define XATTR_NAME_MAX   255	/* # chars in an extended attribute name */
+#define XATTR_SIZE_MAX 65536	/* size of an extended attribute value (64k) */
+#define XATTR_LIST_MAX 65536	/* size of extended attribute namelist (64k) */
 
 #define RTSIG_MAX	  32
 
diff -Naur 2.5.0-pristine/include/linux/xattr.h 2.5.0-xattr/include/linux/xattr.h
--- 2.5.0-pristine/include/linux/xattr.h	Thu Jan  1 10:00:00 1970
+++ 2.5.0-xattr/include/linux/xattr.h	Thu Dec  6 12:59:47 2001
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


