Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWBJP21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWBJP21 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 10:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWBJP21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 10:28:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6843 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932138AbWBJP20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 10:28:26 -0500
Date: Fri, 10 Feb 2006 10:28:15 -0500
From: Ulrich Drepper <drepper@redhat.com>
Message-Id: <200602101528.k1AFSFIg011658@devserv.devel.redhat.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: [PATCH] updated fstatat64 support
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since Christoph insist here's a patch changing newfstatat64 to fstatat64.

Signed-off-by: Ulrich Drepper <drepper@redhat.com>


--- linux-2.6.15.i686/arch/i386/kernel/syscall_table.S-at	2006-02-06 13:11:24.000000000 -0800
+++ linux-2.6.15.i686/arch/i386/kernel/syscall_table.S	2006-02-06 13:11:34.000000000 -0800
@@ -299,7 +299,7 @@
 	.long sys_mknodat
 	.long sys_fchownat
 	.long sys_futimesat
-	.long sys_newfstatat		/* 300 */
+	.long sys_fstatat64		/* 300 */
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
 
+asmlinkage long sys_fstatat64(int dfd, char __user *filename,
+			       struct stat64 __user *statbuf, int flag)
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
+#define __NR_fstatat64		300
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
+#define __NR_ia32_fstatat64		300
 #define __NR_ia32_unlinkat		301
 #define __NR_ia32_renameat		302
 #define __NR_ia32_linkat		303
--- linux-2.6.15.i686/include/linux/syscalls.h-at	2006-02-06 12:56:58.000000000 -0800
+++ linux-2.6.15.i686/include/linux/syscalls.h	2006-02-06 13:14:15.000000000 -0800
@@ -557,6 +557,8 @@
 			   int mode);
 asmlinkage long sys_newfstatat(int dfd, char __user *filename,
 			       struct stat __user *statbuf, int flag);
+asmlinkage long sys_fstatat64(int dfd, char __user *filename,
+			       struct stat64 __user *statbuf, int flag);
 asmlinkage long sys_readlinkat(int dfd, const char __user *path, char __user *buf,
 			       int bufsiz);
 asmlinkage long compat_sys_futimesat(unsigned int dfd, char __user *filename,
