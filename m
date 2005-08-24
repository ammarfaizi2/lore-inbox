Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVHXI7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVHXI7J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 04:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbVHXI7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 04:59:09 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:51724 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750775AbVHXI7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 04:59:08 -0400
To: arnd@arndb.de
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <200508232344.05666.arnd@arndb.de> (message from Arnd Bergmann on
	Tue, 23 Aug 2005 23:44:05 +0200)
Subject: Re: [PATCH 6/8] remove duplicated sys_open32() code from 64bit archs
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> <E1E7fVJ-0006HK-00@dorka.pomaz.szeredi.hu> <E1E7fcN-0006IR-00@dorka.pomaz.szeredi.hu> <200508232344.05666.arnd@arndb.de>
Message-Id: <E1E7r5c-00074Q-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 24 Aug 2005 10:58:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please don't leave the functions inside of the architecture specific code.
> The code is common enough to be shared, so just put a new compat_sys_open()
> function into fs/compat.c.

OK.  Done for x86_64, ia64, ppc64.  Sparc64 does magic things with
sparc32_open(), so I left it as it is.

> I'm also not sure wether s390, mips and/or parisc need to use the
> same function instead of the standard sys_open().

I have no idea.

Andrew, could you please apply this one?

Thanks,
Miklos
---

64 bit architectures all implement their own compatibility sys_open(),
when in fact the difference is simply not forcing the O_LARGEFILE
flag.  So use the a common function instead.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2005-08-23 14:56:06.000000000 +0200
+++ linux/include/linux/fs.h	2005-08-24 10:27:08.000000000 +0200
@@ -1287,6 +1287,7 @@ static inline int break_lease(struct ino
 /* fs/open.c */
 
 extern int do_truncate(struct dentry *, loff_t start);
+extern long do_sys_open(const char __user *filename, int flags, int mode);
 extern struct file *filp_open(const char *, int, int);
 extern struct file * dentry_open(struct dentry *, struct vfsmount *, int);
 extern int filp_close(struct file *, fl_owner_t id);
Index: linux/fs/open.c
===================================================================
--- linux.orig/fs/open.c	2005-08-23 14:36:20.000000000 +0200
+++ linux/fs/open.c	2005-08-24 10:30:33.000000000 +0200
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
--- linux.orig/arch/x86_64/ia32/sys_ia32.c	2005-08-23 14:36:20.000000000 +0200
+++ linux/arch/x86_64/ia32/sys_ia32.c	2005-08-24 10:29:50.000000000 +0200
@@ -969,32 +969,6 @@ long sys32_kill(int pid, int sig)
 	return sys_kill(pid, sig);
 }
  
-asmlinkage long sys32_open(const char __user * filename, int flags, int mode)
-{
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
-}
-
 extern asmlinkage long
 sys_timer_create(clockid_t which_clock,
 		 struct sigevent __user *timer_event_spec,
Index: linux/arch/ppc64/kernel/sys_ppc32.c
===================================================================
--- linux.orig/arch/ppc64/kernel/sys_ppc32.c	2005-08-23 14:36:20.000000000 +0200
+++ linux/arch/ppc64/kernel/sys_ppc32.c	2005-08-24 10:34:59.000000000 +0200
@@ -867,37 +867,6 @@ off_t ppc32_lseek(unsigned int fd, u32 o
 	return sys_lseek(fd, (int)offset, origin);
 }
 
-/*
- * This is just a version for 32-bit applications which does
- * not force O_LARGEFILE on.
- */
-asmlinkage long sys32_open(const char __user * filename, int flags, int mode)
-{
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
-}
-
 /* Note: it is necessary to treat bufsiz as an unsigned int,
  * with the corresponding cast to a signed int to insure that the 
  * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
Index: linux/arch/ia64/ia32/sys_ia32.c
===================================================================
--- linux.orig/arch/ia64/ia32/sys_ia32.c	2005-08-23 14:36:20.000000000 +0200
+++ linux/arch/ia64/ia32/sys_ia32.c	2005-08-24 10:38:19.000000000 +0200
@@ -2359,37 +2359,6 @@ sys32_brk (unsigned int brk)
 	return ret;
 }
 
-/*
- * Exactly like fs/open.c:sys_open(), except that it doesn't set the O_LARGEFILE flag.
- */
-asmlinkage long
-sys32_open (const char __user * filename, int flags, int mode)
-{
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
-}
-
 /* Structure for ia32 emulation on ia64 */
 struct epoll_event32
 {
Index: linux/arch/sparc64/kernel/sys_sparc32.c
===================================================================
--- linux.orig/arch/sparc64/kernel/sys_sparc32.c	2005-08-23 14:36:20.000000000 +0200
+++ linux/arch/sparc64/kernel/sys_sparc32.c	2005-08-23 14:56:06.000000000 +0200
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
Index: linux/arch/x86_64/ia32/ia32entry.S
===================================================================
--- linux.orig/arch/x86_64/ia32/ia32entry.S	2005-08-19 14:14:35.000000000 +0200
+++ linux/arch/x86_64/ia32/ia32entry.S	2005-08-24 10:28:42.000000000 +0200
@@ -298,7 +298,7 @@ ia32_sys_call_table:
 	.quad stub32_fork
 	.quad sys_read
 	.quad sys_write
-	.quad sys32_open		/* 5 */
+	.quad compat_sys_open		/* 5 */
 	.quad sys_close
 	.quad sys32_waitpid
 	.quad sys_creat
Index: linux/arch/ia64/ia32/ia32_entry.S
===================================================================
--- linux.orig/arch/ia64/ia32/ia32_entry.S	2005-06-24 13:21:28.000000000 +0200
+++ linux/arch/ia64/ia32/ia32_entry.S	2005-08-24 10:37:14.000000000 +0200
@@ -215,7 +215,7 @@ ia32_syscall_table:
 	data8 sys32_fork
 	data8 sys_read
 	data8 sys_write
-	data8 sys32_open	  /* 5 */
+	data8 compat_sys_open	  /* 5 */
 	data8 sys_close
 	data8 sys32_waitpid
 	data8 sys_creat
Index: linux/arch/ppc64/kernel/misc.S
===================================================================
--- linux.orig/arch/ppc64/kernel/misc.S	2005-08-19 14:14:33.000000000 +0200
+++ linux/arch/ppc64/kernel/misc.S	2005-08-24 10:36:11.000000000 +0200
@@ -859,7 +859,7 @@ _GLOBAL(sys_call_table32)
 	.llong .ppc_fork
 	.llong .sys_read
 	.llong .sys_write
-	.llong .sys32_open		/* 5 */
+	.llong .compat_sys_open		/* 5 */
 	.llong .sys_close
 	.llong .sys32_waitpid
 	.llong .sys32_creat
Index: linux/fs/compat.c
===================================================================
--- linux.orig/fs/compat.c	2005-08-24 10:40:44.000000000 +0200
+++ linux/fs/compat.c	2005-08-24 10:56:44.000000000 +0200
@@ -1277,6 +1277,16 @@ out:
 }
 
 /*
+ * Exactly like fs/open.c:sys_open(), except that it doesn't set the
+ * O_LARGEFILE flag.
+ */
+asmlinkage long
+compat_sys_open(const char __user *filename, int flags, int mode)
+{
+	return do_sys_open(filename, flags, mode);
+}
+
+/*
  * compat_count() counts the number of arguments/envelopes. It is basically
  * a copy of count() from fs/exec.c, except that it works with 32 bit argv
  * and envp pointers.
