Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030589AbWBHUIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030589AbWBHUIq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbWBHUIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:08:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53215 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030589AbWBHUIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:08:44 -0500
Date: Wed, 8 Feb 2006 15:08:39 -0500
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200602082008.k18K8dqE026598@devserv.devel.redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] fstatat64 support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The *at patches introduced fstatat and, due to inusfficient research, I
used the newfstat functions generally as the guideline.  The result is
that on 32-bit platforms we don't have all the information needed to
implement fstatat64.

This patch modifies the code to pass up 64-bit information if
__ARCH_WANT_STAT64 is defined.  I renamed the syscall entry point to
make this clear.  Other archs will continue to use the existing code.
On x86-64 the compat code is implemented using a new sys32_ function.
this is what is done for the other stat syscalls as well.


This patch might break some other archs (those which define
__ARCH_WANT_STAT64 and which already wired up the syscall).  Yet
others might need changes to accomodate the compatibility mode.
I really don't want to do that work because all this stat handling
is a mess (more so in glibc, but the kernel is also affected).  It
should be done by the arch maintainers.  I'll provide some
stand-alone test shortly.  Those who are eager could compile glibc
and run 'make check' (no installation needed).


The patch below has been tested on x86 and x86-64.


Signed-off-by: Ulrich Drepper <drepper@redhat.com>


--- linux-2.6.15.i686/arch/i386/kernel/syscall_table.S-at	2006-02-06 13:11:24.000000000 -0800
+++ linux-2.6.15.i686/arch/i386/kernel/syscall_table.S	2006-02-06 13:11:34.000000000 -0800
@@ -299,7 +299,7 @@
 	.long sys_mknodat
 	.long sys_fchownat
 	.long sys_futimesat
-	.long sys_newfstatat		/* 300 */
+	.long sys_newfstatat64		/* 300 */
 	.long sys_unlinkat
 	.long sys_renameat
 	.long sys_linkat
--- linux-2.6.15.i686/arch/x86_64/ia32/ia32entry.S-at	2006-02-06 13:05:04.000000000 -0800
+++ linux-2.6.15.i686/arch/x86_64/ia32/ia32entry.S	2006-02-06 13:05:21.000000000 -0800
@@ -677,7 +677,7 @@
 	.quad sys_mknodat
 	.quad sys_fchownat
 	.quad compat_sys_futimesat
-	.quad compat_sys_newfstatat	/* 300 */
+	.quad sys32_fstatat		/* 300 */
 	.quad sys_unlinkat
 	.quad sys_renameat
 	.quad sys_linkat
--- linux-2.6.15.i686/arch/x86_64/ia32/sys_ia32.c-at	2006-02-06 13:05:37.000000000 -0800
+++ linux-2.6.15.i686/arch/x86_64/ia32/sys_ia32.c	2006-02-06 13:08:30.000000000 -0800
@@ -180,6 +180,28 @@
 	return ret;
 }
 
+asmlinkage long
+sys32_fstatat(unsigned int dfd, char __user *filename,
+	      struct stat64 __user* statbuf, int flag)
+{
+	struct kstat stat;
+	int error = -EINVAL;
+
+	if ((flag & ~AT_SYMLINK_NOFOLLOW) != 0)
+		goto out;
+
+	if (flag & AT_SYMLINK_NOFOLLOW)
+		error = vfs_lstat_fd(dfd, filename, &stat);
+	else
+		error = vfs_stat_fd(dfd, filename, &stat);
+
+	if (!error)
+		error = cp_stat64(statbuf, &stat);
+
+out:
+	return error;
+}
+
 /*
  * Linux/i386 didn't use to be able to handle more than
  * 4 system call parameters, so these system calls used a memory
--- linux-2.6.15.i686/fs/stat.c-at	2006-02-06 12:55:52.000000000 -0800
+++ linux-2.6.15.i686/fs/stat.c	2006-02-06 13:13:43.000000000 -0800
@@ -261,6 +261,7 @@
 	return error;
 }
 
+#ifndef __ARCH_WANT_STAT64
 asmlinkage long sys_newfstatat(int dfd, char __user *filename,
 				struct stat __user *statbuf, int flag)
 {
@@ -281,6 +282,7 @@
 out:
 	return error;
 }
+#endif
 
 asmlinkage long sys_newfstat(unsigned int fd, struct stat __user *statbuf)
 {
@@ -395,6 +397,26 @@
 	return error;
 }
 
+asmlinkage long sys_newfstatat64(int dfd, char __user *filename,
+				 struct stat64 __user *statbuf, int flag)
+{
+	struct kstat stat;
+	int error = -EINVAL;
+
+	if ((flag & ~AT_SYMLINK_NOFOLLOW) != 0)
+		goto out;
+
+	if (flag & AT_SYMLINK_NOFOLLOW)
+		error = vfs_lstat_fd(dfd, filename, &stat);
+	else
+		error = vfs_stat_fd(dfd, filename, &stat);
+
+	if (!error)
+		error = cp_new_stat64(&stat, statbuf);
+
+out:
+	return error;
+}
 #endif /* __ARCH_WANT_STAT64 */
 
 void inode_add_bytes(struct inode *inode, loff_t bytes)
--- linux-2.6.15.i686/include/asm-i386/unistd.h-at	2006-02-06 13:16:26.000000000 -0800
+++ linux-2.6.15.i686/include/asm-i386/unistd.h	2006-02-06 13:16:42.000000000 -0800
@@ -305,7 +305,7 @@
 #define __NR_mknodat		297
 #define __NR_fchownat		298
 #define __NR_futimesat		299
-#define __NR_newfstatat		300
+#define __NR_newfstatat64	300
 #define __NR_unlinkat		301
 #define __NR_renameat		302
 #define __NR_linkat		303
--- linux-2.6.15.i686/include/asm-x86_64/ia32_unistd.h-at	2006-02-06 13:16:51.000000000 -0800
+++ linux-2.6.15.i686/include/asm-x86_64/ia32_unistd.h	2006-02-06 13:17:00.000000000 -0800
@@ -305,7 +305,7 @@
 #define __NR_ia32_mknodat		297
 #define __NR_ia32_fchownat		298
 #define __NR_ia32_futimesat		299
-#define __NR_ia32_newfstatat		300
+#define __NR_ia32_newfstatat64		300
 #define __NR_ia32_unlinkat		301
 #define __NR_ia32_renameat		302
 #define __NR_ia32_linkat		303
--- linux-2.6.15.i686/include/linux/syscalls.h-at	2006-02-06 12:56:58.000000000 -0800
+++ linux-2.6.15.i686/include/linux/syscalls.h	2006-02-06 13:14:15.000000000 -0800
@@ -557,6 +557,8 @@
 			   int mode);
 asmlinkage long sys_newfstatat(int dfd, char __user *filename,
 			       struct stat __user *statbuf, int flag);
+asmlinkage long sys_newfstatat64(int dfd, char __user *filename,
+				 struct stat64 __user *statbuf, int flag);
 asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *buf,
 			       int bufsiz);
 asmlinkage long compat_sys_futimesat(unsigned int dfd, char __user *filename,
