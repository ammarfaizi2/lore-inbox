Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265590AbUGDMYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUGDMYU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 08:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265660AbUGDMYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 08:24:20 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:1448 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S265590AbUGDMXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 08:23:55 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: move O_LARGEFILE forcing to filp_open()
Date: Sun, 4 Jul 2004 14:22:56 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hugh@veritas.com
References: <20040704064122.GY21066@holomorphy.com>
In-Reply-To: <20040704064122.GY21066@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200407041422.57614.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sonntag, 4. Juli 2004 08:41, William Lee Irwin III wrote:
>                        sys_open() in turn calls filp_open(). So merely
> moving the forcing of the flag on 64-bit resolves this situation there,
> though not for 32-bit, whose solution is to appear in the sequel.

Unfortunately, this will also cause problems for 32-bit emulation, where
sys32_open currently calls filp_open without forcing O_LARGEFILE for
32 bit applications.
I also noticed that this behavior currently is not implemented on all
architectures, which in turn would need the patch below.

Maybe you can find a way to fix both problems.

	Arnd <><

 arch/ia64/ia32/ia32_entry.S         |    2 +-
 arch/ia64/ia32/sys_ia32.c           |   31 -------------------------------
 arch/mips/kernel/scall64-o32.S      |    2 +-
 arch/parisc/kernel/syscall_table.S  |    2 +-
 arch/ppc64/kernel/misc.S            |    2 +-
 arch/ppc64/kernel/sys_ppc32.c       |   31 -------------------------------
 arch/s390/kernel/compat_wrapper.S   |    2 +-
 arch/sparc64/kernel/sparc64_ksyms.c |    2 --
 arch/sparc64/kernel/sys32.S         |    2 +-
 arch/sparc64/kernel/sys_sparc32.c   |   32 --------------------------------
 arch/sparc64/kernel/sys_sunos32.c   |    4 +---
 arch/sparc64/solaris/fs.c           |    4 +---
 arch/x86_64/ia32/ia32entry.S        |    2 +-
 arch/x86_64/ia32/sys_ia32.c         |   24 ------------------------
 fs/compat.c                         |   31 +++++++++++++++++++++++++++++++
 include/linux/compat.h              |    4 ++++
 16 files changed, 44 insertions(+), 133 deletions(-)

===== arch/ia64/ia32/ia32_entry.S 1.39 vs edited =====
--- 1.39/arch/ia64/ia32/ia32_entry.S	Sun Jun 27 08:06:52 2004
+++ edited/arch/ia64/ia32/ia32_entry.S	Sun Jul  4 14:02:04 2004
@@ -213,7 +213,7 @@
 	data8 sys32_fork
 	data8 sys_read
 	data8 sys_write
-	data8 sys32_open	  /* 5 */
+	data8 compat_sys_open	  /* 5 */
 	data8 sys_close
 	data8 sys32_waitpid
 	data8 sys_creat
===== arch/ia64/ia32/sys_ia32.c 1.100 vs edited =====
--- 1.100/arch/ia64/ia32/sys_ia32.c	Sun Jun 27 08:06:52 2004
+++ edited/arch/ia64/ia32/sys_ia32.c	Sun Jul  4 13:28:46 2004
@@ -2450,37 +2450,6 @@
 	return ret;
 }
 
-/*
- * Exactly like fs/open.c:sys_open(), except that it doesn't set the O_LARGEFILE flag.
- */
-asmlinkage long
-sys32_open (const char * filename, int flags, int mode)
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
===== arch/mips/kernel/scall64-o32.S 1.6 vs edited =====
--- 1.6/arch/mips/kernel/scall64-o32.S	Sun Jun 27 08:06:52 2004
+++ edited/arch/mips/kernel/scall64-o32.S	Sun Jul  4 14:05:34 2004
@@ -263,7 +263,7 @@
 	sys	sys_fork	0
 	sys	sys_read	3
 	sys	sys_write	3
-	sys	sys_open	3			/* 4005 */
+	sys	compat_sys_open	3			/* 4005 */
 	sys	sys_close	1
 	sys	sys_waitpid	3
 	sys	sys_creat	2
===== arch/parisc/kernel/syscall_table.S 1.8 vs edited =====
--- 1.8/arch/parisc/kernel/syscall_table.S	Mon May 10 11:18:39 2004
+++ edited/arch/parisc/kernel/syscall_table.S	Sun Jul  4 14:03:36 2004
@@ -65,7 +65,7 @@
 	ENTRY_SAME(fork_wrapper)
 	ENTRY_SAME(read)
 	ENTRY_SAME(write)
-	ENTRY_SAME(open)		/* 5 */
+	ENTRY_COMP(open)		/* 5 */
 	ENTRY_SAME(close)
 	ENTRY_SAME(waitpid)
 	ENTRY_SAME(creat)
===== arch/ppc64/kernel/misc.S 1.83 vs edited =====
--- 1.83/arch/ppc64/kernel/misc.S	Sun Jun 27 08:06:53 2004
+++ edited/arch/ppc64/kernel/misc.S	Sun Jul  4 14:01:27 2004
@@ -612,7 +612,7 @@
 	.llong .ppc_fork
 	.llong .sys_read
 	.llong .sys_write
-	.llong .sys32_open		/* 5 */
+	.llong .compat_sys_open		/* 5 */
 	.llong .sys_close
 	.llong .sys32_waitpid
 	.llong .sys32_creat
===== arch/ppc64/kernel/sys_ppc32.c 1.95 vs edited =====
--- 1.95/arch/ppc64/kernel/sys_ppc32.c	Sun Jun 27 08:06:53 2004
+++ edited/arch/ppc64/kernel/sys_ppc32.c	Sun Jul  4 13:29:18 2004
@@ -905,37 +905,6 @@
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
===== arch/s390/kernel/compat_wrapper.S 1.16 vs edited =====
--- 1.16/arch/s390/kernel/compat_wrapper.S	Wed Jun  9 10:47:16 2004
+++ edited/arch/s390/kernel/compat_wrapper.S	Sun Jul  4 13:25:22 2004
@@ -32,7 +32,7 @@
 	llgtr	%r2,%r2			# const char *
 	lgfr	%r3,%r3			# int
 	lgfr	%r4,%r4			# int
-	jg	sys_open		# branch to system call
+	jg	compat_sys_open		# branch to system call
 
 	.globl  sys32_close_wrapper 
 sys32_close_wrapper:
===== arch/sparc64/kernel/sparc64_ksyms.c 1.70 vs edited =====
--- 1.70/arch/sparc64/kernel/sparc64_ksyms.c	Sun Jun 27 08:06:53 2004
+++ edited/arch/sparc64/kernel/sparc64_ksyms.c	Sun Jul  4 13:45:00 2004
@@ -89,7 +89,6 @@
 extern int svr4_setcontext(svr4_ucontext_t *uc, struct pt_regs *regs);
 extern int compat_sys_ioctl(unsigned int fd, unsigned int cmd, u32 arg);
 extern int (*handle_mathemu)(struct pt_regs *, struct fpustate *);
-extern long sparc32_open(const char * filename, int flags, int mode);
 extern int io_remap_page_range(struct vm_area_struct *vma, unsigned long from, unsigned long offset, unsigned long size, pgprot_t prot, int space);
 extern void (*prom_palette)(int);
 
@@ -328,7 +327,6 @@
 EXPORT_SYMBOL(svr4_getcontext);
 EXPORT_SYMBOL(svr4_setcontext);
 EXPORT_SYMBOL(compat_sys_ioctl);
-EXPORT_SYMBOL(sparc32_open);
 EXPORT_SYMBOL(sys_close);
 #endif
 
===== arch/sparc64/kernel/sys32.S 1.9 vs edited =====
--- 1.9/arch/sparc64/kernel/sys32.S	Thu Jun  3 23:51:21 2004
+++ edited/arch/sparc64/kernel/sys32.S	Sun Jul  4 13:45:12 2004
@@ -106,7 +106,7 @@
 SIGN2(sys32_kill, sys_kill, %o0, %o1)
 SIGN1(sys32_nice, sys_nice, %o0)
 SIGN1(sys32_lseek, sys_lseek, %o1)
-SIGN2(sys32_open, sparc32_open, %o1, %o2)
+SIGN2(sys32_open, compat_sys_open, %o1, %o2)
 SIGN1(sys32_readlink, sys_readlink, %o2)
 SIGN1(sys32_sched_get_priority_max, sys_sched_get_priority_max, %o0)
 SIGN1(sys32_sched_get_priority_min, sys_sched_get_priority_min, %o0)
===== arch/sparc64/kernel/sys_sparc32.c 1.102 vs edited =====
--- 1.102/arch/sparc64/kernel/sys_sparc32.c	Wed Jun  2 06:42:33 2004
+++ edited/arch/sparc64/kernel/sys_sparc32.c	Sun Jul  4 13:40:09 2004
@@ -1680,38 +1680,6 @@
 	return ret;
 }
 
-/* This is just a version for 32-bit applications which does
- * not force O_LARGEFILE on.
- */
-
-asmlinkage long sparc32_open(const char __user *filename,
-			     int flags, int mode)
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
 extern unsigned long do_mremap(unsigned long addr,
 	unsigned long old_len, unsigned long new_len,
 	unsigned long flags, unsigned long new_addr);
===== arch/sparc64/kernel/sys_sunos32.c 1.44 vs edited =====
--- 1.44/arch/sparc64/kernel/sys_sunos32.c	Sat Jun  5 01:39:21 2004
+++ edited/arch/sparc64/kernel/sys_sunos32.c	Sun Jul  4 13:46:41 2004
@@ -1175,13 +1175,11 @@
 	return rval;
 }
 
-extern asmlinkage long sparc32_open(const char * filename, int flags, int mode);
-
 asmlinkage int sunos_open(u32 fname, int flags, int mode)
 {
 	const char *filename = (const char *)(long)fname;
 
-	return sparc32_open(filename, flags, mode);
+	return compat_sys_open(filename, flags, mode);
 }
 
 #define SUNOS_EWOULDBLOCK 35
===== arch/sparc64/solaris/fs.c 1.19 vs edited =====
--- 1.19/arch/sparc64/solaris/fs.c	Tue Sep 23 06:16:30 2003
+++ edited/arch/sparc64/solaris/fs.c	Sun Jul  4 13:47:14 2004
@@ -525,8 +525,6 @@
 	return error;
 }
 
-extern asmlinkage long sparc32_open(const char * filename, int flags, int mode);
-
 asmlinkage int solaris_open(u32 fname, int flags, u32 mode)
 {
 	const char *filename = (const char *)(long)fname;
@@ -542,7 +540,7 @@
 	if (flags & 0x800) fl |= O_NOCTTY;
 	flags = fl;
 
-	return sparc32_open(filename, flags, mode);
+	return compat_sys_open(filename, flags, mode);
 }
 
 #define SOL_F_SETLK	6
===== arch/x86_64/ia32/ia32entry.S 1.37 vs edited =====
--- 1.37/arch/x86_64/ia32/ia32entry.S	Sun Jun 27 08:07:31 2004
+++ edited/arch/x86_64/ia32/ia32entry.S	Sun Jul  4 13:29:25 2004
@@ -310,7 +310,7 @@
 	.quad stub32_fork
 	.quad sys_read
 	.quad sys_write
-	.quad sys32_open		/* 5 */
+	.quad compat_sys_open		/* 5 */
 	.quad sys_close
 	.quad sys32_waitpid
 	.quad sys_creat
===== arch/x86_64/ia32/sys_ia32.c 1.62 vs edited =====
--- 1.62/arch/x86_64/ia32/sys_ia32.c	Sun May 30 21:56:26 2004
+++ edited/arch/x86_64/ia32/sys_ia32.c	Sun Jul  4 13:30:31 2004
@@ -1249,30 +1249,6 @@
 	return ret;
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
-			if (unlikely(IS_ERR(f))) {
-				put_unused_fd(fd); 
-				fd = error;
-			} else
-				fd_install(fd, f);
-		}
-		putname(tmp);
-	}
-	return fd;
-}
-
 struct sigevent32 { 
 	u32 sigev_value;
 	u32 sigev_signo; 
===== fs/compat.c 1.32 vs edited =====
--- 1.32/fs/compat.c	Sun Jun 27 08:07:46 2004
+++ edited/fs/compat.c	Sun Jul  4 13:24:42 2004
@@ -143,6 +143,37 @@
 }
 
 /*
+ * Exactly like fs/open.c:sys_open(), except that it doesn't set the O_LARGEFILE flag.
+ */
+asmlinkage long
+compat_sys_open(const char __user * filename, int flags, int mode)
+{
+	char * tmp;
+	int fd, error;
+
+	tmp = getname(filename);
+	fd = PTR_ERR(tmp);
+	if (!IS_ERR(tmp)) {
+		fd = get_unused_fd();
+		if (fd >= 0) {
+			struct file *f = filp_open(tmp, flags, mode);
+			error = PTR_ERR(f);
+			if (IS_ERR(f))
+				goto out_error;
+			fd_install(fd, f);
+		}
+out:
+		putname(tmp);
+	}
+	return fd;
+
+out_error:
+	put_unused_fd(fd);
+	fd = error;
+	goto out;
+}
+
+/*
  * The following statfs calls are copies of code from fs/open.c and
  * should be checked against those from time to time
  */
===== include/linux/compat.h 1.24 vs edited =====
--- 1.24/include/linux/compat.h	Sat May 29 11:13:12 2004
+++ edited/include/linux/compat.h	Sun Jul  4 13:52:43 2004
@@ -130,5 +130,9 @@
 		compat_ulong_t __user *outp, compat_ulong_t __user *exp,
 		struct compat_timeval __user *tvp);
 
+asmlinkage long compat_sys_open(const char __user * filename,
+				int flags, int mode);
+
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
