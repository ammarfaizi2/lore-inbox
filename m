Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271105AbTHGXHP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 19:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271106AbTHGXHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 19:07:15 -0400
Received: from dp.samba.org ([66.70.73.150]:14775 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S271105AbTHGXHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 19:07:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16178.56121.743989.77396@cargo.ozlabs.ibm.com>
Date: Fri, 8 Aug 2003 09:05:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2-mm5 working on ppc
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch gets 2.6.0-test2-mm5 to boot on my G3 powerbook.  The first
problem was that we had dev_t in struct stat, thus userland became
unhappy when dev_t changed size.

The second problem was that sys_mknod got changed to take an unsigned
int rather than a dev_t, but we were still calling it with a dev_t
argument in init/do_mounts.h and init/initramfs.c.  That might sorta
work on x86 but it doesn't on ppc.  My solution to that is to export
and use do_mknod instead.  Of course the do_mknod prototype should
really go in a header somewhere but I was too lazy to do that.

Paul.

diff -urN mm5-orig/include/asm-ppc/stat.h test25/include/asm-ppc/stat.h
--- mm5-orig/include/asm-ppc/stat.h	2002-11-18 06:53:57.000000000 +1100
+++ test25/include/asm-ppc/stat.h	2003-08-07 21:42:30.000000000 +1000
@@ -22,13 +22,13 @@
 #define STAT_HAVE_NSEC 1
 
 struct stat {
-	dev_t		st_dev;
+	unsigned int	st_dev;
 	ino_t		st_ino;
 	mode_t		st_mode;
 	nlink_t		st_nlink;
 	uid_t 		st_uid;
 	gid_t 		st_gid;
-	dev_t		st_rdev;
+	unsigned int	st_rdev;
 	off_t		st_size;
 	unsigned long  	st_blksize;
 	unsigned long  	st_blocks;
diff -urN mm5-orig/fs/namei.c test25/fs/namei.c
--- mm5-orig/fs/namei.c	2003-08-08 08:52:50.000000000 +1000
+++ test25/fs/namei.c	2003-08-08 08:53:48.000000000 +1000
@@ -1431,8 +1431,7 @@
 	return error;
 }
 
-static long
-do_mknod(const char __user *filename, int mode, dev_t dev)
+long do_mknod(const char __user *filename, int mode, dev_t dev)
 {
 	int error = 0;
 	char *tmp;
diff -urN mm5-orig/init/do_mounts.h test25/init/do_mounts.h
--- mm5-orig/init/do_mounts.h	2003-07-18 08:22:33.000000000 +1000
+++ test25/init/do_mounts.h	2003-08-08 08:28:57.000000000 +1000
@@ -10,7 +10,6 @@
 #include <linux/root_dev.h>
 
 asmlinkage long sys_unlink(const char *name);
-asmlinkage long sys_mknod(const char *name, int mode, dev_t dev);
 asmlinkage long sys_newstat(char * filename, struct stat * statbuf);
 asmlinkage long sys_ioctl(int fd, int cmd, unsigned long arg);
 asmlinkage long sys_mkdir(const char *name, int mode);
@@ -22,6 +21,7 @@
 				 unsigned long flags, void *data);
 asmlinkage long sys_umount(char *name, int flags);
 
+long  do_mknod(const char *name, int mode, dev_t dev);
 dev_t name_to_dev_t(char *name);
 void  change_floppy(char *fmt, ...);
 void  mount_block_root(char *name, int flags);
@@ -43,7 +43,7 @@
 static inline int create_dev(char *name, dev_t dev, char *devfs_name)
 {
 	sys_unlink(name);
-	return sys_mknod(name, S_IFBLK|0600, dev);
+	return do_mknod(name, S_IFBLK|0600, dev);
 }
 
 #endif
diff -urN mm5-orig/init/initramfs.c test25/init/initramfs.c
--- mm5-orig/init/initramfs.c	2002-11-19 13:20:08.000000000 +1100
+++ test25/init/initramfs.c	2003-08-08 08:29:25.000000000 +1000
@@ -24,7 +24,6 @@
 }
 
 asmlinkage long sys_mkdir(char *name, int mode);
-asmlinkage long sys_mknod(char *name, int mode, dev_t dev);
 asmlinkage long sys_symlink(char *old, char *new);
 asmlinkage long sys_link(char *old, char *new);
 asmlinkage long sys_write(int fd, const char *buf, size_t size);
@@ -33,6 +32,7 @@
 asmlinkage long sys_fchown(int fd, uid_t uid, gid_t gid);
 asmlinkage long sys_chmod(char *name, mode_t mode);
 asmlinkage long sys_fchmod(int fd, mode_t mode);
+long do_mknod(char *name, int mode, dev_t dev);
 
 /* link hash */
 
@@ -264,7 +264,7 @@
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
 		if (maybe_link() == 0) {
-			sys_mknod(collected, mode, rdev);
+			do_mknod(collected, mode, rdev);
 			sys_chown(collected, uid, gid);
 		}
 	} else
