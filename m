Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTJAAH5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 20:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbTJAAF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 20:05:58 -0400
Received: from hera.cwi.nl ([192.16.191.8]:53974 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261839AbTJAABc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 20:01:32 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 1 Oct 2003 02:01:23 +0200 (MEST)
Message-Id: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl>
To: torvalds@osdl.org
Subject: [PATCH] linuxabi
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Something we have talked about for a long time is
separating out from the kernel headers the parts
fit for inclusion in user space.

This is a very large project, and it will take a long
time, especially if we want the user space headers to
be a pleasure to look at, instead of just a cut-n-paste
copy of whatever we find in the current headers.

Some start is required, and the very first step is
making sure that you agree with the project.
Immediately following is the choice of directory names.

Below
  (i) a small textfile "linuxabi" describing the naming
(subdirectories linuxabi and linuxabi-alpha etc of include),
  (ii) the file linuxabi/mountflags.h with definitions for
MS_RDONLY and family,
  (iii) the file linux/mountflags.h that includes
linuxabi/mountflags.h and moreover defines things like
MS_RMT_MASK and IS_NOATIME(inode), and
  (iv) the patch on fs.h that removes these defines and
adds an include line.

Andries



diff -u --recursive --new-file -X /linux/dontdiff a/Documentation/linuxabi b/Documentation/linuxabi
--- a/Documentation/linuxabi	Thu Jan  1 01:00:00 1970
+++ b/Documentation/linuxabi	Wed Oct  1 00:37:45 2003
@@ -0,0 +1,18 @@
+The subdirectories  linuxabi  and  linuxabi-$ARCH 
+(linuxabi-alpha, linuxabi-arm, ...) of linux/include
+are meant for headers that are to be used both by the kernel
+and in user space. The symbolic link  linuxabi-arch
+points at  linuxabi-$ARCH  for the current architecture.
+
+Be careful not to pollute namespace.
+
+Typical material for such headers are manifest constants
+and structures used by the kernel-userspace interface.
+
+Make sure no symbolic types like dev_t, pid_t, ino_t and
+the like are used, but only explicit types like char and
+int, or even more explicit types like uint8_t and int64_t.
+
+These headers are "append-only", in the sense that Linux
+tries to keep supporting old interfaces.
+
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/fs.h b/include/linux/fs.h
--- a/include/linux/fs.h	Sun Sep 28 12:42:16 2003
+++ b/include/linux/fs.h	Wed Oct  1 01:40:04 2003
@@ -19,6 +19,7 @@
 #include <linux/cache.h>
 #include <linux/radix-tree.h>
 #include <linux/kobject.h>
+#include <linux/mountflags.h>
 #include <asm/atomic.h>
 
 struct iovec;
@@ -91,42 +92,8 @@
 #define FS_REQUIRES_DEV 1 
 #define FS_REVAL_DOT	16384	/* Check the paths ".", ".." for staleness */
 #define FS_ODD_RENAME	32768	/* Temporary stuff; will go away as soon
-				  * as nfs_rename() will be cleaned up
-				  */
-/*
- * These are the fs-independent mount-flags: up to 32 flags are supported
- */
-#define MS_RDONLY	 1	/* Mount read-only */
-#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
-#define MS_NODEV	 4	/* Disallow access to device special files */
-#define MS_NOEXEC	 8	/* Disallow program execution */
-#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
-#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
-#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
-#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
-#define MS_NOATIME	1024	/* Do not update access times. */
-#define MS_NODIRATIME	2048	/* Do not update directory access times */
-#define MS_BIND		4096
-#define MS_MOVE		8192
-#define MS_REC		16384
-#define MS_VERBOSE	32768
-#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
-#define MS_ONE_SECOND	(1<<17)	/* fs has 1 sec a/m/ctime resolution */
-#define MS_ACTIVE	(1<<30)
-#define MS_NOUSER	(1<<31)
-
-/*
- * Superblock flags that can be altered by MS_REMOUNT
- */
-#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_NOATIME|\
-			 MS_NODIRATIME)
-
-/*
- * Old magic mount flag and mask
- */
-#define MS_MGC_VAL 0xC0ED0000
-#define MS_MGC_MSK 0xffff0000
-
+				 * as nfs_rename() will be cleaned up
+				 */
 /* Inode flags - they have nothing to superblock flags now */
 
 #define S_SYNC		1	/* Writes are synced at once */
@@ -138,38 +105,12 @@
 #define S_NOQUOTA	64	/* Inode is not counted to quota */
 #define S_DIRSYNC	128	/* Directory modifications are synchronous */
 
-/*
- * Note that nosuid etc flags are inode-specific: setting some file-system
- * flags just means all the inodes inherit those flags by default. It might be
- * possible to override it selectively if you really wanted to with some
- * ioctl() that is not currently implemented.
- *
- * Exception: MS_RDONLY is always applied to the entire file system.
- *
- * Unfortunately, it is possible to change a filesystems flags with it mounted
- * with files in use.  This means that all of the inodes will not have their
- * i_flags updated.  Hence, i_flags no longer inherit the superblock mount
- * flags, so these have to be checked separately. -- rmk@arm.uk.linux.org
- */
-#define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))
-
-#define IS_RDONLY(inode) ((inode)->i_sb->s_flags & MS_RDONLY)
-#define IS_SYNC(inode)		(__IS_FLG(inode, MS_SYNCHRONOUS) || \
-					((inode)->i_flags & S_SYNC))
-#define IS_DIRSYNC(inode)	(__IS_FLG(inode, MS_SYNCHRONOUS|MS_DIRSYNC) || \
-					((inode)->i_flags & (S_SYNC|S_DIRSYNC)))
-#define IS_MANDLOCK(inode)	__IS_FLG(inode, MS_MANDLOCK)
-
 #define IS_QUOTAINIT(inode)	((inode)->i_flags & S_QUOTA)
-#define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
 #define IS_APPEND(inode)	((inode)->i_flags & S_APPEND)
 #define IS_IMMUTABLE(inode)	((inode)->i_flags & S_IMMUTABLE)
-#define IS_NOATIME(inode)	(__IS_FLG(inode, MS_NOATIME) || ((inode)->i_flags & S_NOATIME))
-#define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
-#define IS_POSIXACL(inode)	__IS_FLG(inode, MS_POSIXACL)
-#define IS_ONE_SECOND(inode)	__IS_FLG(inode, MS_ONE_SECOND)
-
 #define IS_DEADDIR(inode)	((inode)->i_flags & S_DEAD)
+#define IS_NOQUOTA(inode)	((inode)->i_flags & S_NOQUOTA)
+
 
 /* the read-only stuff doesn't really belong here, but any other place is
    probably as bad and I don't want to create yet another include file. */
diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/mountflags.h b/include/linux/mountflags.h
--- a/include/linux/mountflags.h	Thu Jan  1 01:00:00 1970
+++ b/include/linux/mountflags.h	Wed Oct  1 01:41:42 2003
@@ -0,0 +1,40 @@
+#ifndef _LINUX_MOUNTFLAGS_H
+#define _LINUX_MOUNTFLAGS_H
+
+#include <linuxabi/mountflags.h>
+
+/*
+ * Superblock flags that can be altered by MS_REMOUNT
+ */
+#define MS_RMT_MASK	(MS_RDONLY|MS_SYNCHRONOUS|MS_MANDLOCK|MS_NOATIME|\
+			 MS_NODIRATIME)
+
+/*
+ * Note that nosuid etc flags are inode-specific: setting some file-system
+ * flags just means all the inodes inherit those flags by default. It might be
+ * possible to override it selectively if you really wanted to with some
+ * ioctl() that is not currently implemented.
+ *
+ * Exception: MS_RDONLY is always applied to the entire file system.
+ *
+ * Unfortunately, it is possible to change a filesystems flags with it mounted
+ * with files in use.  This means that all of the inodes will not have their
+ * i_flags updated.  Hence, i_flags no longer inherit the superblock mount
+ * flags, so these have to be checked separately. -- rmk@arm.uk.linux.org
+ */
+#define __IS_FLG(inode,flg) ((inode)->i_sb->s_flags & (flg))
+
+#define IS_RDONLY(inode)        __IS_FLG(inode, MS_RDONLY)
+#define IS_MANDLOCK(inode)	__IS_FLG(inode, MS_MANDLOCK)
+#define IS_NODIRATIME(inode)	__IS_FLG(inode, MS_NODIRATIME)
+#define IS_POSIXACL(inode)	__IS_FLG(inode, MS_POSIXACL)
+#define IS_ONE_SECOND(inode)	__IS_FLG(inode, MS_ONE_SECOND)
+
+#define IS_SYNC(inode)	       (__IS_FLG(inode, MS_SYNCHRONOUS) || \
+				       ((inode)->i_flags & S_SYNC))
+#define IS_DIRSYNC(inode)      (__IS_FLG(inode, MS_SYNCHRONOUS|MS_DIRSYNC) || \
+				       ((inode)->i_flags & (S_SYNC|S_DIRSYNC)))
+#define IS_NOATIME(inode)      (__IS_FLG(inode, MS_NOATIME) || \
+				       ((inode)->i_flags & S_NOATIME))
+
+#endif /* _LINUX_MOUNTFLAGS_H */
diff -u --recursive --new-file -X /linux/dontdiff a/include/linuxabi/mountflags.h b/include/linuxabi/mountflags.h
--- a/include/linuxabi/mountflags.h	Thu Jan  1 01:00:00 1970
+++ b/include/linuxabi/mountflags.h	Wed Oct  1 00:40:50 2003
@@ -0,0 +1,32 @@
+#ifndef _LINUXABI_MOUNTFLAGS_H
+#define _LINUXABI_MOUNTFLAGS_H
+
+/*
+ * These are the fs-independent mount-flags: up to 32 flags are supported
+ */
+#define MS_RDONLY	 1	/* Mount read-only */
+#define MS_NOSUID	 2	/* Ignore suid and sgid bits */
+#define MS_NODEV	 4	/* Disallow access to device special files */
+#define MS_NOEXEC	 8	/* Disallow program execution */
+#define MS_SYNCHRONOUS	16	/* Writes are synced at once */
+#define MS_REMOUNT	32	/* Alter flags of a mounted FS */
+#define MS_MANDLOCK	64	/* Allow mandatory locks on an FS */
+#define MS_DIRSYNC	128	/* Directory modifications are synchronous */
+#define MS_NOATIME	1024	/* Do not update access times. */
+#define MS_NODIRATIME	2048	/* Do not update directory access times */
+#define MS_BIND		4096
+#define MS_MOVE		8192
+#define MS_REC		16384
+#define MS_VERBOSE	32768
+#define MS_POSIXACL	(1<<16)	/* VFS does not apply the umask */
+#define MS_ONE_SECOND	(1<<17)	/* fs has 1 sec a/m/ctime resolution */
+#define MS_ACTIVE	(1<<30)
+#define MS_NOUSER	(1<<31)
+
+/*
+ * Old magic mount flag and mask
+ */
+#define MS_MGC_VAL 0xC0ED0000
+#define MS_MGC_MSK 0xffff0000
+
+#endif /* _LINUXABI_MOUNTFLAGS_H */
