Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279617AbRKOFLD>; Thu, 15 Nov 2001 00:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278911AbRKOFK6>; Thu, 15 Nov 2001 00:10:58 -0500
Received: from rj.sgi.com ([204.94.215.100]:53167 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S278800AbRKOFKi>;
	Thu, 15 Nov 2001 00:10:38 -0500
Date: Thu, 15 Nov 2001 16:08:53 +1100
From: Nathan Scott <nathans@sgi.com>
To: Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>
Cc: Andreas Gruenbacher <ag@bestbits.at>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: [RFC][PATCH] VFS interface for extended attributes
Message-ID: <20011115160853.N588010@wobbly.melbourne.sgi.com>
In-Reply-To: <Pine.LNX.4.21.0111121152410.14344-100000@moses.parsec.at> <Pine.GSO.4.21.0111121207530.21825-100000@weyl.math.psu.edu> <20011113062711.A1912@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011113062711.A1912@wotan.suse.de>; from ak@suse.de on Tue, Nov 13, 2001 at 06:27:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 06:27:11AM +0100, Andi Kleen wrote:
> On Mon, Nov 12, 2001 at 07:32:18PM -0500, Alexander Viro wrote:
> > Which means that converting permission() to vfsmount/dentry should be
> > done first.  And that's not hard to do.
>
> It's just messy as it will require changes in all file systems.
>
> > Sorry, folks, but idea of private extendable syscall table (per-filesystem,
> > no less) doesn't look like a good thing.  That's _the_ reason why ioctl()
> > is bad.
>
> Unless I'm badly misreading the patch the op switch() is fixed in VFS mapping
> to clearly defined inode operations. It is not extensible per filesystem.
> Arguably they could be split into individual syscalls, but it looks not more
> like cosmetics at this point.

hi Al,

Below is an initial attempt at an interface which doesn't have a
command parameter at all, instead using separate syscalls as Andi
has suggested - is this closer to what you had in mind?

To prevent an exponential increase in the number of syscalls used,
it uses a flag parameter to distinguish similar operations and also
to combine the follow-symlink-or-not cases - it now uses six system
calls instead of the original three.

It also moves the individual VFS extended attribute operations out
into a separate ops vector for a little more interface clarity, not
sure if thats better/worse.  The patch ignores the problem of using
dentry vs. inode for now.

Thanks for the suggestions - I'd be interested in any thoughts you
have on this one as well.

cheers.

--
Nathan


diff -Naur 2.4.14-pristine/arch/i386/kernel/entry.S 2.4.14-al/arch/i386/kernel/entry.S
--- 2.4.14-pristine/arch/i386/kernel/entry.S	Sat Nov  3 12:18:49 2001
+++ 2.4.14-al/arch/i386/kernel/entry.S	Tue Nov 13 15:54:55 2001
@@ -622,6 +622,12 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* Reserved for Security */
 	.long SYMBOL_NAME(sys_gettid)
 	.long SYMBOL_NAME(sys_readahead)	/* 225 */
+	.long SYMBOL_NAME(sys_setxattr)
+	.long SYMBOL_NAME(sys_fsetxattr)
+	.long SYMBOL_NAME(sys_getxattr)
+	.long SYMBOL_NAME(sys_fgetxattr)
+	.long SYMBOL_NAME(sys_listxattr)	/* 230 */
+	.long SYMBOL_NAME(sys_flistxattr)
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -Naur 2.4.14-pristine/fs/Makefile 2.4.14-al/fs/Makefile
--- 2.4.14-pristine/fs/Makefile	Tue Nov  6 08:40:59 2001
+++ 2.4.14-al/fs/Makefile	Fri Nov  9 15:27:42 2001
@@ -14,7 +14,7 @@
 		super.o block_dev.o char_dev.o stat.o exec.o pipe.o namei.o \
 		fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
-		filesystems.o namespace.o
+		filesystems.o namespace.o extattr.o
 
 ifeq ($(CONFIG_QUOTA),y)
 obj-y += dquot.o
diff -Naur 2.4.14-pristine/fs/extattr.c 2.4.14-al/fs/extattr.c
--- 2.4.14-pristine/fs/extattr.c	Thu Jan  1 10:00:00 1970
+++ 2.4.14-al/fs/extattr.c	Tue Nov 13 15:52:51 2001
@@ -0,0 +1,184 @@
+/*
+  File: fs/extattr.c
+
+  Extended attribute handling.
+ 
+  Copyright (C) 2001 by Andreas Gruenbacher <a.gruenbacher@computer.org>
+  Copyright (C) 2001 SGI - Silicon Graphics, Inc <linux-xfs@oss.sgi.com>
+ */
+
+#include <linux/mm.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/smp_lock.h>
+#include <linux/extattr.h>
+
+
+/*
+ * Extended attribute SET operations
+ */
+static long
+setxattr(struct inode *i, char *name, void *value, size_t size, int flags)
+{
+	struct xattr_operations *ops;
+	int error = -EOPNOTSUPP;
+
+	lock_kernel();
+	ops = i->i_xop;
+	if (ops) {
+		if (flags & EA_CREATE) {
+			if (ops->create)
+				error = ops->create(i, name, value, size);
+		}
+		else if (flags & EA_REPLACE) {
+			if (ops->replace)
+				error = ops->replace(i, name, value, size);
+		}
+		else if (flags & EA_REMOVE) {
+			if (ops->remove)
+				error = ops->remove(i, name);
+		}
+		else if (ops->set)
+			error = ops->set(i, name, value, size);
+	}
+	unlock_kernel();
+	return error;
+}
+
+asmlinkage long
+sys_setxattr(char *path, char *name, void *value, size_t size, int flags)
+{
+	struct nameidata nd;
+	int error;
+
+	error = (flags & EA_NOFOLLOW)?
+		user_path_walk_link(path, &nd):
+		user_path_walk(path, &nd);
+	if (error)
+		return error;
+	error = setxattr(nd.dentry->d_inode, name, value, size, flags);
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
+	error = setxattr(f->f_dentry->d_inode, name, value, size, flags);
+	fput(f);
+	return error;
+}
+
+
+/*
+ * Extended attribute GET operations
+ */
+static long
+getxattr(struct inode *i, char *name, void *value, size_t size, int flags)
+{
+	struct xattr_operations *ops;
+	int error = -EOPNOTSUPP;
+
+	lock_kernel();
+	ops = i->i_xop;
+	if (ops) {
+		if (flags & EA_SIZEONLY) {
+			if (ops->getsize)
+				error = ops->getsize(i, name);
+		}
+		else if (ops->get)
+			error = ops->get(i, name, value, size);
+	}
+	unlock_kernel();
+	return error;
+}
+
+asmlinkage long
+sys_getxattr(char *path, char *name, void *value, size_t size, int flags)
+{
+	struct nameidata nd;
+	int error;
+
+	error = (flags & EA_NOFOLLOW)?
+		user_path_walk_link(path, &nd):
+		user_path_walk(path, &nd);
+	if (error)
+		return error;
+	error = getxattr(nd.dentry->d_inode, name, value, size, flags);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage long
+sys_fgetxattr(int fd, char *name, void *value, size_t size, int flags)
+{
+	struct file *f;
+	int error = -EBADF;
+
+	f = fget(fd);
+	if (!f)
+		return error;
+	error = getxattr(f->f_dentry->d_inode, name, value, size, flags);
+	fput(f);
+	return error;
+}
+
+
+/*
+ * Extended attribute LIST operations
+ */
+static long
+listxattr(struct inode *i, char *name, void *value, size_t size, int flags)
+{
+	struct xattr_operations *ops;
+	int error = -EOPNOTSUPP;
+
+	lock_kernel();
+	ops = i->i_xop;
+	if (ops) {
+		if (flags & EA_SIZEONLY) {
+			if (ops->listsize)
+				error = ops->listsize(i, name);
+		}
+		else if (ops->list)
+			error = ops->list(i, name, value, size);
+	}
+	unlock_kernel();
+	return error;
+}
+
+asmlinkage long
+sys_listxattr(char *path, char *name, void *value, size_t size, int flags)
+{
+	struct nameidata nd;
+	int error;
+
+	error = (flags & EA_NOFOLLOW)?
+		user_path_walk_link(path, &nd):
+		user_path_walk(path, &nd);
+	if (error)
+		return error;
+	error = listxattr(nd.dentry->d_inode, name, value, size, flags);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage long
+sys_flistxattr(int fd, char *name, void *value, size_t size, int flags)
+{
+	struct file *f;
+	int error = -EBADF;
+
+	f = fget(fd);
+	if (!f)
+		return error;
+	error = listxattr(f->f_dentry->d_inode, name, value, size, flags);
+	fput(f);
+	return error;
+}
diff -Naur 2.4.14-pristine/fs/inode.c 2.4.14-al/fs/inode.c
--- 2.4.14-pristine/fs/inode.c	Sat Sep 29 11:03:48 2001
+++ 2.4.14-al/fs/inode.c	Tue Nov 13 16:11:15 2001
@@ -768,10 +768,12 @@
 {
 	static struct address_space_operations empty_aops;
 	static struct inode_operations empty_iops;
+	static struct xattr_operations empty_xops;
 	static struct file_operations empty_fops;
 	memset(&inode->u, 0, sizeof(inode->u));
 	inode->i_sock = 0;
 	inode->i_op = &empty_iops;
+	inode->i_xop = &empty_xops;
 	inode->i_fop = &empty_fops;
 	inode->i_nlink = 1;
 	atomic_set(&inode->i_writecount, 0);
diff -Naur 2.4.14-pristine/include/asm-i386/unistd.h 2.4.14-al/include/asm-i386/unistd.h
--- 2.4.14-pristine/include/asm-i386/unistd.h	Thu Oct 18 03:03:03 2001
+++ 2.4.14-al/include/asm-i386/unistd.h	Tue Nov 13 15:53:21 2001
@@ -230,6 +230,12 @@
 #define __NR_security		223	/* syscall for security modules */
 #define __NR_gettid		224
 #define __NR_readahead		225
+#define __NR_setxattr		226
+#define __NR_fsetxattr		227
+#define __NR_getxattr		228
+#define __NR_fgetxattr		229
+#define __NR_listxattr		230
+#define __NR_flistxattr		231
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Naur 2.4.14-pristine/include/linux/extattr.h 2.4.14-al/include/linux/extattr.h
--- 2.4.14-pristine/include/linux/extattr.h	Thu Jan  1 10:00:00 1970
+++ 2.4.14-al/include/linux/extattr.h	Tue Nov 13 15:43:08 2001
@@ -0,0 +1,18 @@
+/*
+  File: linux/extattr.h
+
+  Extended attributes handling.
+
+  Copyright (C) 2001 by Andreas Gruenbacher <a.gruenbacher@computer.org>
+  Copyright (C) 2001 SGI - Silicon Graphics, Inc <linux-xfs@oss.sgi.com>
+*/
+#ifndef _LINUX_EXTATTR_H
+#define _LINUX_EXTATTR_H
+
+#define EA_CREATE	0x0001	/* Set the value: fail if attr already exists */
+#define EA_REPLACE	0x0002	/* Set the value: fail if attr does not exist */
+#define EA_REMOVE	0x0004	/* Remove the named attribute entirely */
+#define EA_SIZEONLY	0x0008	/* Retrieve a buffer size don't write into it */
+#define EA_NOFOLLOW	0x0010	/* Don't follow symlinks when traversing path */
+
+#endif	/* _LINUX_EXTATTR_H */
diff -Naur 2.4.14-pristine/include/linux/fs.h 2.4.14-al/include/linux/fs.h
--- 2.4.14-pristine/include/linux/fs.h	Tue Nov  6 07:42:14 2001
+++ 2.4.14-al/include/linux/fs.h	Tue Nov 13 15:30:39 2001
@@ -444,6 +444,7 @@
 	struct semaphore	i_zombie;
 	struct inode_operations	*i_op;
 	struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
+	struct xattr_operations	*i_xop;
 	struct super_block	*i_sb;
 	wait_queue_head_t	i_wait;
 	struct file_lock	*i_flock;
@@ -840,6 +841,17 @@
 	int (*revalidate) (struct dentry *);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct dentry *, struct iattr *);
+};
+
+struct xattr_operations {
+	int (*create) (struct inode *, char *, void *, size_t);
+	int (*replace) (struct inode *, char *, void *, size_t);
+	int (*remove) (struct inode *, char *);
+	int (*set) (struct inode *, char *, void *, size_t);
+	int (*get) (struct inode *, char *, void *, size_t);
+	int (*getsize) (struct inode *, char *);
+	int (*list) (struct inode *, char *, void *, size_t);
+	int (*listsize) (struct inode *, char *);
 };
 
 /*
