Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263750AbTDUB16 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 21:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbTDUB16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 21:27:58 -0400
Received: from hera.cwi.nl ([192.16.191.8]:39933 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263750AbTDUB14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 21:27:56 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 21 Apr 2003 03:39:56 +0200 (MEST)
Message-Id: <UTC200304210139.h3L1duq18832.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] mknod64 with major,minor
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A second version of mknod64 for i386.
There are no assumptions on the size of dev_t.

sys_mknod takes unsigned int (instead of dev_t)
sys_mknod64 takes two unsigned ints.

Andries

--------------------------------------------------
diff -u --recursive --new-file -X /linux/dontdiff a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Tue Mar 25 04:54:29 2003
+++ b/arch/i386/kernel/entry.S	Mon Apr 21 01:00:56 2003
@@ -852,6 +852,7 @@
  	.long sys_clock_gettime		/* 265 */
  	.long sys_clock_getres
  	.long sys_clock_nanosleep
+	.long sys_mknod64
  
  
 nr_syscalls=(.-sys_call_table)/4
diff -u --recursive --new-file -X /linux/dontdiff a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Sun Apr 20 12:59:32 2003
+++ b/fs/namei.c	Mon Apr 21 02:07:18 2003
@@ -1403,11 +1403,12 @@
 	return error;
 }
 
-asmlinkage long sys_mknod(const char __user * filename, int mode, dev_t dev)
+static long
+do_mknod(const char __user *filename, int mode, dev_t dev)
 {
 	int error = 0;
-	char * tmp;
-	struct dentry * dentry;
+	char *tmp;
+	struct dentry *dentry;
 	struct nameidata nd;
 
 	if (S_ISDIR(mode))
@@ -1448,6 +1449,27 @@
 	return error;
 }
 
+asmlinkage long
+sys_mknod(const char __user *filename, int mode, unsigned int devnr)
+{
+	dev_t dev = devnr;
+
+	if (dev != devnr)
+		return -EOVERFLOW;
+	return do_mknod(filename, mode, dev);
+}
+
+asmlinkage long
+sys_mknod64(const char __user *filename, int mode,
+	    unsigned int major, unsigned int minor)
+{
+	dev_t dev = MKDEV(major, minor);
+
+	if (MAJOR(dev) != major || MINOR(dev) != minor)
+		return -EOVERFLOW;
+	return do_mknod(filename, mode, dev);
+}
+
 int vfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	int error = may_create(dir, dentry);
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
--- a/include/asm-i386/unistd.h	Mon Feb 24 23:02:56 2003
+++ b/include/asm-i386/unistd.h	Mon Apr 21 01:01:48 2003
@@ -273,8 +273,9 @@
 #define __NR_clock_gettime	(__NR_timer_create+6)
 #define __NR_clock_getres	(__NR_timer_create+7)
 #define __NR_clock_nanosleep	(__NR_timer_create+8)
+#define	__NR_sys_mknod64	268
 
-#define NR_syscalls 268
+#define NR_syscalls 269
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
