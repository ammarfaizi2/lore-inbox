Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281274AbRKLGXa>; Mon, 12 Nov 2001 01:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281275AbRKLGXW>; Mon, 12 Nov 2001 01:23:22 -0500
Received: from rj.sgi.com ([204.94.215.100]:62669 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S281272AbRKLGXF>;
	Mon, 12 Nov 2001 01:23:05 -0500
Date: Mon, 12 Nov 2001 17:21:13 +1100
From: Nathan Scott <nathans@sgi.com>
To: Al Viro <viro@math.psu.edu>, Andreas Gruenbacher <ag@bestbits.at>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
Subject: [RFC][PATCH] VFS interface for extended attributes
Message-ID: <20011112172113.A636371@wobbly.melbourne.sgi.com>
In-Reply-To: <3BECEEA2.4030408@hotmail.com> <5.1.0.14.2.20011112012026.02b3eda8@pop.cus.cam.ac.uk> <20011112142029.D583135@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011112142029.D583135@wobbly.melbourne.sgi.com>; from nathans@sgi.com on Mon, Nov 12, 2001 at 02:20:29PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 02:20:29PM +1100, Nathan Scott wrote:
> On Mon, Nov 12, 2001 at 01:57:28AM +0000, Anton Altaparmakov wrote:
> > At 09:08 10/11/2001, Tim R. wrote:
> > >I'm glad to see you guys are working on a common acl api for ext2/3 and xfs.
> > >I was just wondering if this api provided what would be needed for linux 
> > >to support NTFS's acls.
> > 
> > Comments/problems for NTFS with proposed EA/ACL API:
> > 
> > I think the API is good for extended attributes, no doubt. If we ever get 
> > round to implementing EAs in NTFS then I would be happy to use the API. It 
> > fully satisfies the needs of the NTFS EAs.
> 
> That's great to hear!  Thanks.
> ...
> I'll put out an initial attempt at some VFS code to sit behind
> this system call soon too.
> 

Al, folks,

Andreas and I have been looking at several different VFS mechanisms
for extended attributes, I've included the code for one below, and
we're keen to get a bit of feedback here as well.

We started off with the simplest mechanism, just passing everything
straight down into the filesystem.  I then played around with some
ways of separating out the different operations and then passing off
to the filesystem that way (see patch) to give the interface a more
rigid definition.  Andreas' original mechanism was alot like this,
except used NULLs in some field values instead of explicit flags to
distinguish similar operations - that's another approach.

Yet another way would be to have an ea_operations vector separate to
the inode_operations with an ea_operations pointer in struct inode,
enumerating each EA operation and doing away with the flags (in the
patch below) altogether.

Any suggestions/improvements?  The patch below is very much a work
in progress - it may even compile.

many thanks.

-- 
Nathan


diff -Naur 2.4.14-pristine/arch/i386/kernel/entry.S 2.4.14-explicit/arch/i386/kernel/entry.S
--- 2.4.14-pristine/arch/i386/kernel/entry.S	Sat Nov  3 12:18:49 2001
+++ 2.4.14-explicit/arch/i386/kernel/entry.S	Fri Nov  9 15:34:29 2001
@@ -622,6 +622,9 @@
 	.long SYMBOL_NAME(sys_ni_syscall)	/* Reserved for Security */
 	.long SYMBOL_NAME(sys_gettid)
 	.long SYMBOL_NAME(sys_readahead)	/* 225 */
+	.long SYMBOL_NAME(sys_extattr)
+	.long SYMBOL_NAME(sys_lextattr)
+	.long SYMBOL_NAME(sys_fextattr)
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long SYMBOL_NAME(sys_ni_syscall)
diff -Naur 2.4.14-pristine/fs/Makefile 2.4.14-explicit/fs/Makefile
--- 2.4.14-pristine/fs/Makefile	Tue Nov  6 08:40:59 2001
+++ 2.4.14-explicit/fs/Makefile	Fri Nov  9 15:27:42 2001
@@ -14,7 +14,7 @@
 		super.o block_dev.o char_dev.o stat.o exec.o pipe.o namei.o \
 		fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o iobuf.o dnotify.o \
-		filesystems.o namespace.o
+		filesystems.o namespace.o extattr.o
 
 ifeq ($(CONFIG_QUOTA),y)
 obj-y += dquot.o
diff -Naur 2.4.14-pristine/fs/extattr.c 2.4.14-explicit/fs/extattr.c
--- 2.4.14-pristine/fs/extattr.c	Thu Jan  1 10:00:00 1970
+++ 2.4.14-explicit/fs/extattr.c	Mon Nov 12 11:24:11 2001
@@ -0,0 +1,101 @@
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
+static long
+extattr_inode(struct inode *i, int cmd, char *name, void *value, size_t size)
+{
+	int error = -EOPNOTSUPP, flags = EA_FLAG_USER;
+
+	lock_kernel();
+	switch (cmd) {
+		case EA_SET:
+		case EA_CREATE:
+		case EA_REPLACE:
+		case EA_REMOVE:
+			if (!i->i_op->setxattr)
+				break;
+			if (cmd == EA_CREATE)
+				flags |= EA_FLAG_CREATE;
+			else if (cmd == EA_REPLACE)
+				flags |= EA_FLAG_REPLACE;
+			else if (cmd == EA_REMOVE)
+				flags |= EA_FLAG_REMOVE;
+			error = i->i_op->setxattr(i, name, value, size, flags);
+			break;
+
+		case EA_GETSIZE:
+			flags |= EA_FLAG_SZONLY;
+		case EA_GET:
+			if (!i->i_op->getxattr)
+				break;
+			error = i->i_op->getxattr(i, name, value, size, flags);
+			break;
+
+		case EA_LISTSIZE:
+			flags |= EA_FLAG_SZONLY;
+		case EA_LIST:
+			if (!i->i_op->listxattr)
+				break;
+			error = i->i_op->listxattr(i, name, value, size, flags);
+			break;
+
+		default:
+			error = -EINVAL;
+	}
+	unlock_kernel();
+	return error;
+}
+
+asmlinkage long
+sys_extattr(char *path, int cmd, char *name, void *value, size_t size)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk(path, &nd);
+	if (error)
+		return error;
+	error = extattr_inode(nd.dentry->d_inode, cmd, name, value, size);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage long
+sys_lextattr(char *path, int cmd, char *name, void *value, size_t size)
+{
+	struct nameidata nd;
+	int error;
+
+	error = user_path_walk_link(path, &nd);
+	if (error)
+		return error;
+	error = extattr_inode(nd.dentry->d_inode, cmd, name, value, size);
+	path_release(&nd);
+	return error;
+}
+
+asmlinkage long
+sys_fextattr(int fd, int cmd, char *name, void *value, size_t size)
+{
+	struct file *f;
+	int error = -EBADF;
+
+	f = fget(fd);
+	if (!f)
+		return error;
+	error = extattr_inode(f->f_dentry->d_inode, cmd, name, value, size);
+	fput(f);
+	return error;
+}
diff -Naur 2.4.14-pristine/include/asm-i386/unistd.h 2.4.14-explicit/include/asm-i386/unistd.h
--- 2.4.14-pristine/include/asm-i386/unistd.h	Thu Oct 18 03:03:03 2001
+++ 2.4.14-explicit/include/asm-i386/unistd.h	Fri Nov  9 15:37:08 2001
@@ -230,6 +230,9 @@
 #define __NR_security		223	/* syscall for security modules */
 #define __NR_gettid		224
 #define __NR_readahead		225
+#define __NR_extattr		226
+#define __NR_lextattr		227
+#define __NR_fextattr		228
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
diff -Naur 2.4.14-pristine/include/linux/extattr.h 2.4.14-explicit/include/linux/extattr.h
--- 2.4.14-pristine/include/linux/extattr.h	Thu Jan  1 10:00:00 1970
+++ 2.4.14-explicit/include/linux/extattr.h	Mon Nov 12 11:24:01 2001
@@ -0,0 +1,30 @@
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
+/* Operations */
+#define EA_SET		1	/* set the value, create attr where necessary */
+#define EA_CREATE	2	/* set the value, fail if attr already exists */
+#define EA_REPLACE	3	/* set the value, fail if attr does not exist */
+#define EA_REMOVE	4	/* remove the named attribute entirely */
+#define EA_GET		5	/* get the value for named attribute */
+#define EA_GETSIZE	6	/* size of value for named attribute */
+#define EA_LIST		7	/* get the list of attribute names */
+#define EA_LISTSIZE	8	/* size of list of attribute names */
+
+#ifdef __KERNEL__
+#define EA_FLAG_USER	0x0001
+#define EA_FLAG_SZONLY	0x0002
+#define EA_FLAG_CREATE	0x0004
+#define EA_FLAG_REPLACE	0x0008
+#define EA_FLAG_REMOVE	0x0010
+#endif
+
+#endif	/* _LINUX_EXTATTR_H */
diff -Naur 2.4.14-pristine/include/linux/fs.h 2.4.14-explicit/include/linux/fs.h
--- 2.4.14-pristine/include/linux/fs.h	Tue Nov  6 07:42:14 2001
+++ 2.4.14-explicit/include/linux/fs.h	Sat Nov 10 14:10:39 2001
@@ -840,6 +840,9 @@
 	int (*revalidate) (struct dentry *);
 	int (*setattr) (struct dentry *, struct iattr *);
 	int (*getattr) (struct dentry *, struct iattr *);
+	int (*setxattr) (struct inode *, char *, void *, size_t, int);
+	int (*getxattr) (struct inode *, char *, void *, size_t, int);
+	int (*listxattr) (struct inode *, char *, void *, size_t, int);
 };
 
 /*
