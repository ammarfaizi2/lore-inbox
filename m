Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbTDTS1m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263669AbTDTS1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:27:42 -0400
Received: from hera.cwi.nl ([192.16.191.8]:9147 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263661AbTDTS1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:27:33 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 20 Apr 2003 20:39:32 +0200 (MEST)
Message-Id: <UTC200304201839.h3KIdWk18226.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] new system call mknod64
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of the mknod arg from dev_t to unsigned int.
Add (for i386) mknod64.

diff -u --recursive --new-file -X /linux/dontdiff a/arch/i386/kernel/entry.S b/arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Tue Mar 25 04:54:29 2003
+++ b/arch/i386/kernel/entry.S	Sun Apr 20 19:13:34 2003
@@ -852,6 +852,7 @@
  	.long sys_clock_gettime		/* 265 */
  	.long sys_clock_getres
  	.long sys_clock_nanosleep
+	.long sys_mknod64
  
  
 nr_syscalls=(.-sys_call_table)/4
diff -u --recursive --new-file -X /linux/dontdiff a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Sun Apr 20 12:59:32 2003
+++ b/fs/namei.c	Sun Apr 20 19:13:34 2003
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
@@ -1448,6 +1449,19 @@
 	return error;
 }
 
+asmlinkage long
+sys_mknod(const char __user *filename, int mode, unsigned int dev)
+{
+	return do_mknod(filename, mode, dev);
+}
+
+asmlinkage long
+sys_mknod64(const char __user *filename, int mode,
+	    unsigned int devhi, unsigned int devlo)
+{
+	return do_mknod(filename, mode, ((u64) devhi << 32) + devlo);
+}
+
 int vfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	int error = may_create(dir, dentry);
@@ -2140,8 +2154,8 @@
 {
 	struct page * page;
 	struct address_space *mapping = dentry->d_inode->i_mapping;
-	page = read_cache_page(mapping, 0, (filler_t *)mapping->a_ops->readpage,
-				NULL);
+	page = read_cache_page(mapping, 0,
+			       (filler_t *)mapping->a_ops->readpage, NULL);
 	if (IS_ERR(page))
 		goto sync_fail;
 	wait_on_page_locked(page);
diff -u --recursive --new-file -X /linux/dontdiff a/include/asm-i386/unistd.h b/include/asm-i386/unistd.h
--- a/include/asm-i386/unistd.h	Mon Feb 24 23:02:56 2003
+++ b/include/asm-i386/unistd.h	Sun Apr 20 19:13:34 2003
@@ -273,8 +273,9 @@
 #define __NR_clock_gettime	(__NR_timer_create+6)
 #define __NR_clock_getres	(__NR_timer_create+7)
 #define __NR_clock_nanosleep	(__NR_timer_create+8)
+#define __NR_sys_mknod64	268
 
-#define NR_syscalls 268
+#define NR_syscalls 269
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
