Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVHWUnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVHWUnz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVHWUny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:43:54 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:54533 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932389AbVHWUnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:43:53 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <E1E7fVJ-0006HK-00@dorka.pomaz.szeredi.hu> (message from Miklos
	Szeredi on Tue, 23 Aug 2005 22:36:17 +0200)
Subject: [PATCH 6/8] remove duplicated sys_open32() code from 64bit archs
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu> <E1E7fMD-0006En-00@dorka.pomaz.szeredi.hu> <E1E7fPj-0006Fq-00@dorka.pomaz.szeredi.hu> <E1E7fSd-0006Gr-00@dorka.pomaz.szeredi.hu> <E1E7fVJ-0006HK-00@dorka.pomaz.szeredi.hu>
Message-Id: <E1E7fcN-0006IR-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 23 Aug 2005 22:43:35 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

64 bit architectures all implement their own compatibility sys_open(),
when in fact the difference is simply not forcing the O_LARGEFILE
flag.  So use the a common function instead.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2005-08-23 21:00:01.000000000 +0200
+++ linux/include/linux/fs.h	2005-08-23 21:00:18.000000000 +0200
@@ -1286,6 +1286,7 @@ static inline int break_lease(struct ino
 /* fs/open.c */
 
 extern int do_truncate(struct dentry *, loff_t start);
+extern long do_sys_open(const char __user *filename, int flags, int mode);
 extern struct file *filp_open(const char *, int, int);
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, int);
 extern int filp_close(struct file *, fl_owner_t id);
Index: linux/fs/open.c
===================================================================
--- linux.orig/fs/open.c	2005-08-23 20:25:54.000000000 +0200
+++ linux/fs/open.c	2005-08-23 21:00:18.000000000 +0200
@@ -938,16 +938,11 @@ void fastcall fd_install(unsigned int fd
 
 EXPORT_SYMBOL(fd_install);
 
-asmlinkage long sys_open(const char __user * filename, int flags, int mode)
+long do_sys_open(const char __user *filename, int flags, int mode)
 {
-	char * tmp;
-	int fd;
+	char *tmp = getname(filename);
+	int fd = PTR_ERR(tmp);
 
-	if (force_o_largefile())
-		flags |= O_LARGEFILE;
-
-	tmp = getname(filename);
-	fd = PTR_ERR(tmp);
 	if (!IS_ERR(tmp)) {
 		fd = get_unused_fd();
 		if (fd >= 0) {
@@ -964,6 +959,14 @@ asmlinkage long sys_open(const char __us
 	}
 	return fd;
 }
+
+asmlinkage long sys_open(const char __user *filename, int flags, int mode)
+{
+	if (force_o_largefile())
+		flags |= O_LARGEFILE;
+
+	return do_sys_open(filename, flags, mode);
+}
 EXPORT_SYMBOL_GPL(sys_open);
 
 #ifndef __alpha__
Index: linux/arch/x86_64/ia32/sys_ia32.c
===================================================================
--- linux.orig/arch/x86_64/ia32/sys_ia32.c	2005-08-23 20:22:33.000000000 +0200
+++ linux/arch/x86_64/ia32/sys_ia32.c	2005-08-23 21:00:19.000000000 +0200
@@ -971,28 +971,7 @@ long sys32_kill(int pid, int sig)
  
 asmlinkage long sys32_open(const char __user * filename, int flags, int mode)
 {
-	char * tmp;
-	int fd, error;
-
-	/* don't force O_LARGEFILE */
-	tmp = getname(filename);
-	fd = PTR_ERR(tmp);
-	if (!IS_ERR(tmp)) {
-		fd = get_unused_fd();
-		if (fd >= 0) {
-			struct file *f = filp_open(tmp, flags, mode);
-			error = PTR_ERR(f);
-			if (IS_ERR(f)) {
-				put_unused_fd(fd); 
-				fd = error;
-			} else {
-				fsnotify_open(f->f_dentry);
-				fd_install(fd, f);
-			}
-		}
-		putname(tmp);
-	}
-	return fd;
+	return do_sys_open(filename, flags, mode);
 }
 
 extern asmlinkage long
Index: linux/arch/ppc64/kernel/sys_ppc32.c
===================================================================
--- linux.orig/arch/ppc64/kernel/sys_ppc32.c	2005-08-23 20:22:31.000000000 +0200
+++ linux/arch/ppc64/kernel/sys_ppc32.c	2005-08-23 21:00:19.000000000 +0200
@@ -873,29 +873,7 @@ off_t ppc32_lseek(unsigned int fd, u32 o
  */
 asmlinkage long sys32_open(const char __user * filename, int flags, int mode)
 {
-	char * tmp;
-	int fd, error;
-
-	tmp = getname(filename);
-	fd = PTR_ERR(tmp);
-	if (!IS_ERR(tmp)) {
-		fd = get_unused_fd();
-		if (fd >= 0) {
-			struct file * f = filp_open(tmp, flags, mode);
-			error = PTR_ERR(f);
-			if (IS_ERR(f))
-				goto out_error;
-			fd_install(fd, f);
-		}
-out:
-		putname(tmp);
-	}
-	return fd;
-
-out_error:
-	put_unused_fd(fd);
-	fd = error;
-	goto out;
+	return do_sys_open(filename, flags, mode);
 }
 
 /* Note: it is necessary to treat bufsiz as an unsigned int,
Index: linux/arch/ia64/ia32/sys_ia32.c
===================================================================
--- linux.orig/arch/ia64/ia32/sys_ia32.c	2005-06-17 21:48:29.000000000 +0200
+++ linux/arch/ia64/ia32/sys_ia32.c	2005-08-23 21:00:19.000000000 +0200
@@ -2365,29 +2365,7 @@ sys32_brk (unsigned int brk)
 asmlinkage long
 sys32_open (const char __user * filename, int flags, int mode)
 {
-	char * tmp;
-	int fd, error;
-
-	tmp = getname(filename);
-	fd = PTR_ERR(tmp);
-	if (!IS_ERR(tmp)) {
-		fd = get_unused_fd();
-		if (fd >= 0) {
-			struct file *f = filp_open(tmp, flags, mode);
-			error = PTR_ERR(f);
-			if (IS_ERR(f))
-				goto out_error;
-			fd_install(fd, f);
-		}
-out:
-		putname(tmp);
-	}
-	return fd;
-
-out_error:
-	put_unused_fd(fd);
-	fd = error;
-	goto out;
+	return do_sys_open(filename, flags, mode);
 }
 
 /* Structure for ia32 emulation on ia64 */
Index: linux/arch/sparc64/kernel/sys_sparc32.c
===================================================================
--- linux.orig/arch/sparc64/kernel/sys_sparc32.c	2005-06-17 21:48:29.000000000 +0200
+++ linux/arch/sparc64/kernel/sys_sparc32.c	2005-08-23 21:00:19.000000000 +0200
@@ -1002,29 +1002,7 @@ asmlinkage long sys32_adjtimex(struct ti
 asmlinkage long sparc32_open(const char __user *filename,
 			     int flags, int mode)
 {
-	char * tmp;
-	int fd, error;
-
-	tmp = getname(filename);
-	fd = PTR_ERR(tmp);
-	if (!IS_ERR(tmp)) {
-		fd = get_unused_fd();
-		if (fd >= 0) {
-			struct file * f = filp_open(tmp, flags, mode);
-			error = PTR_ERR(f);
-			if (IS_ERR(f))
-				goto out_error;
-			fd_install(fd, f);
-		}
-out:
-		putname(tmp);
-	}
-	return fd;
-
-out_error:
-	put_unused_fd(fd);
-	fd = error;
-	goto out;
+	return do_sys_open(filename, flags, mode);
 }
 
 extern unsigned long do_mremap(unsigned long addr,
