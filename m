Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbUBZCuz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 21:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbUBZCtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 21:49:32 -0500
Received: from pxy5allmi.all.mi.charter.com ([24.247.15.44]:56711 "EHLO
	proxy5-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S262609AbUBZCsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 21:48:41 -0500
Message-ID: <403D5F32.4080805@quark.didntduck.org>
Date: Wed, 25 Feb 2004 21:51:30 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Clean up sys_ioperm stubs
Content-Type: multipart/mixed;
 boundary="------------090206090308000304040106"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090206090308000304040106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Remove stubs for sys_ioperm for non-x86 arches, using sys_ni_syscall 
instead where applicable.

PS.  Can we nuke the KDADDIO etc. ioctls in drivers/char/vt_ioctl.c? 
They apparently were used by ancient versions of X, but nothing should 
be using them now, considering they are limited to the VGA ports only (I 
also checked svgalib).

--
				Brian Gerst

--------------090206090308000304040106
Content-Type: text/plain;
 name="ioperm-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioperm-1"

diff -urN linux-bk/arch/h8300/kernel/syscalls.S linux/arch/h8300/kernel/syscalls.S
--- linux-bk/arch/h8300/kernel/syscalls.S	2003-12-17 21:58:38.000000000 -0500
+++ linux/arch/h8300/kernel/syscalls.S	2004-02-25 14:49:55.000000000 -0500
@@ -116,7 +116,7 @@
 	.long SYMBOL_NAME(sys_ni_syscall)				/* old profil syscall holder */
 	.long SYMBOL_NAME(sys_statfs)
 	.long SYMBOL_NAME(sys_fstatfs)		/* 100 */
-	.long SYMBOL_NAME(sys_ioperm)
+	.long SYMBOL_NAME(sys_ni_syscall)	/* ioperm for i386 */
 	.long SYMBOL_NAME(sys_socketcall)
 	.long SYMBOL_NAME(sys_syslog)
 	.long SYMBOL_NAME(sys_setitimer)
diff -urN linux-bk/arch/h8300/kernel/sys_h8300.c linux/arch/h8300/kernel/sys_h8300.c
--- linux-bk/arch/h8300/kernel/sys_h8300.c	2004-02-25 14:24:13.000000000 -0500
+++ linux/arch/h8300/kernel/sys_h8300.c	2004-02-25 14:50:00.000000000 -0500
@@ -260,11 +260,6 @@
 	return -EINVAL;
 }
 
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on)
-{
-  return -ENOSYS;
-}
-
 /* sys_cacheflush -- no support.  */
 asmlinkage int
 sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
diff -urN linux-bk/arch/m68k/kernel/entry.S linux/arch/m68k/kernel/entry.S
--- linux-bk/arch/m68k/kernel/entry.S	2004-02-25 14:24:13.000000000 -0500
+++ linux/arch/m68k/kernel/entry.S	2004-02-25 14:47:31.000000000 -0500
@@ -528,7 +528,7 @@
 	.long sys_ni_syscall				/* old profil syscall holder */
 	.long sys_statfs
 	.long sys_fstatfs	/* 100 */
-	.long sys_ioperm
+	.long sys_ni_syscall				/* ioperm for i386 */
 	.long sys_socketcall
 	.long sys_syslog
 	.long sys_setitimer
diff -urN linux-bk/arch/m68k/kernel/sys_m68k.c linux/arch/m68k/kernel/sys_m68k.c
--- linux-bk/arch/m68k/kernel/sys_m68k.c	2004-02-25 14:24:13.000000000 -0500
+++ linux/arch/m68k/kernel/sys_m68k.c	2004-02-25 14:46:57.000000000 -0500
@@ -261,12 +261,6 @@
 	return -EINVAL;
 }
 
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on)
-{
-  return -ENOSYS;
-}
-
-
 /* Convert virtual (user) address VADDR to physical address PADDR */
 #define virt_to_phys_040(vaddr)						\
 ({									\
diff -urN linux-bk/arch/m68knommu/kernel/syscalltable.S linux/arch/m68knommu/kernel/syscalltable.S
--- linux-bk/arch/m68knommu/kernel/syscalltable.S	2003-12-17 21:57:58.000000000 -0500
+++ linux/arch/m68knommu/kernel/syscalltable.S	2004-02-25 14:45:12.000000000 -0500
@@ -120,7 +120,7 @@
 	.long sys_ni_syscall	/* old profil syscall holder */
 	.long sys_statfs
 	.long sys_fstatfs	/* 100 */
-	.long sys_ioperm
+	.long sys_ni_syscall	/* ioperm for i386 */
 	.long sys_socketcall
 	.long sys_syslog
 	.long sys_setitimer
diff -urN linux-bk/arch/m68knommu/kernel/sys_m68k.c linux/arch/m68knommu/kernel/sys_m68k.c
--- linux-bk/arch/m68knommu/kernel/sys_m68k.c	2004-02-25 14:24:13.000000000 -0500
+++ linux/arch/m68knommu/kernel/sys_m68k.c	2004-02-25 14:44:06.000000000 -0500
@@ -193,12 +193,6 @@
 	return -EINVAL;
 }
 
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on)
-{
-  return -ENOSYS;
-}
-
-
 /* sys_cacheflush -- flush (part of) the processor cache.  */
 asmlinkage int
 sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
diff -urN linux-bk/arch/parisc/kernel/sys_parisc.c linux/arch/parisc/kernel/sys_parisc.c
--- linux-bk/arch/parisc/kernel/sys_parisc.c	2004-02-25 14:24:14.000000000 -0500
+++ linux/arch/parisc/kernel/sys_parisc.c	2004-02-25 14:48:57.000000000 -0500
@@ -242,14 +242,6 @@
 	return sys_readahead(fd, (loff_t)high << 32 | low, count);
 }
 
-/*
- * This changes the io permissions bitmap in the current task.
- */
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on)
-{
-	return -ENOSYS;
-}
-
 asmlinkage unsigned long sys_alloc_hugepages(int key, unsigned long addr, unsigned long len, int prot, int flag)
 {
 	return -ENOMEM;
diff -urN linux-bk/arch/s390/kernel/syscalls.S linux/arch/s390/kernel/syscalls.S
--- linux-bk/arch/s390/kernel/syscalls.S	2004-02-15 00:41:41.000000000 -0500
+++ linux/arch/s390/kernel/syscalls.S	2004-02-25 14:52:13.000000000 -0500
@@ -109,7 +109,7 @@
 NI_SYSCALL							/* old profil syscall */
 SYSCALL(sys_statfs,sys_statfs,compat_sys_statfs_wrapper)
 SYSCALL(sys_fstatfs,sys_fstatfs,compat_sys_fstatfs_wrapper)	/* 100 */
-SYSCALL(sys_ioperm,sys_ni_syscall,sys_ni_syscall)
+NI_SYSCALL							/* ioperm for i386 */
 SYSCALL(sys_socketcall,sys_socketcall,compat_sys_socketcall_wrapper)
 SYSCALL(sys_syslog,sys_syslog,sys32_syslog_wrapper)
 SYSCALL(sys_setitimer,sys_setitimer,compat_sys_setitimer_wrapper)
diff -urN linux-bk/arch/s390/kernel/sys_s390.c linux/arch/s390/kernel/sys_s390.c
--- linux-bk/arch/s390/kernel/sys_s390.c	2004-02-25 14:24:14.000000000 -0500
+++ linux/arch/s390/kernel/sys_s390.c	2004-02-25 14:52:23.000000000 -0500
@@ -289,11 +289,6 @@
 	return error;
 }
 
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on)
-{
-	return -ENOSYS;
-}
-
 #else /* CONFIG_ARCH_S390X */
 
 asmlinkage int s390x_newuname(struct new_utsname * name)
diff -urN linux-bk/arch/sparc/kernel/setup.c linux/arch/sparc/kernel/setup.c
--- linux-bk/arch/sparc/kernel/setup.c	2004-02-25 14:24:14.000000000 -0500
+++ linux/arch/sparc/kernel/setup.c	2004-02-25 14:55:03.000000000 -0500
@@ -390,11 +390,6 @@
 }
 console_initcall(set_preferred_console);
 
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on)
-{
-	return -EIO;
-}
-
 extern char *sparc_cpu_type[];
 extern char *sparc_fpu_type[];
 
diff -urN linux-bk/arch/sparc64/kernel/setup.c linux/arch/sparc64/kernel/setup.c
--- linux-bk/arch/sparc64/kernel/setup.c	2004-02-25 14:24:14.000000000 -0500
+++ linux/arch/sparc64/kernel/setup.c	2004-02-25 14:53:46.000000000 -0500
@@ -603,11 +603,6 @@
 }
 console_initcall(set_preferred_console);
 
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on)
-{
-	return -EIO;
-}
-
 /* BUFFER is PAGE_SIZE bytes long. */
 
 extern char *sparc_cpu_type;
diff -urN linux-bk/arch/sparc64/kernel/sys_sparc32.c linux/arch/sparc64/kernel/sys_sparc32.c
--- linux-bk/arch/sparc64/kernel/sys_sparc32.c	2004-02-25 14:24:14.000000000 -0500
+++ linux/arch/sparc64/kernel/sys_sparc32.c	2004-02-25 14:53:39.000000000 -0500
@@ -282,11 +282,6 @@
 		 __put_user(i->tv_usec, &o->tv_usec)));
 }
 
-asmlinkage long sys32_ioperm(u32 from, u32 num, int on)
-{
-	return sys_ioperm((unsigned long)from, (unsigned long)num, on);
-}
-
 struct msgbuf32 { s32 mtype; char mtext[1]; };
 
 struct ipc_perm32
diff -urN linux-bk/include/asm-h8300/unistd.h linux/include/asm-h8300/unistd.h
--- linux-bk/include/asm-h8300/unistd.h	2004-02-25 14:24:15.000000000 -0500
+++ linux/include/asm-h8300/unistd.h	2004-02-25 14:50:38.000000000 -0500
@@ -105,7 +105,7 @@
 #define __NR_profil		 98
 #define __NR_statfs		 99
 #define __NR_fstatfs		100
-#define __NR_ioperm		101
+#define __NR_ioperm		/* 101 */ not supported
 #define __NR_socketcall		102
 #define __NR_syslog		103
 #define __NR_setitimer		104
@@ -490,7 +490,6 @@
 			int dummy, ...);
 asmlinkage int sys_pipe(unsigned long *fildes);
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
diff -urN linux-bk/include/asm-m68k/unistd.h linux/include/asm-m68k/unistd.h
--- linux-bk/include/asm-m68k/unistd.h	2004-02-25 14:24:15.000000000 -0500
+++ linux/include/asm-m68k/unistd.h	2004-02-25 14:48:01.000000000 -0500
@@ -105,7 +105,7 @@
 #define __NR_profil		 98
 #define __NR_statfs		 99
 #define __NR_fstatfs		100
-#define __NR_ioperm		101
+#define __NR_ioperm		/* 101 */ not supported
 #define __NR_socketcall		102
 #define __NR_syslog		103
 #define __NR_setitimer		104
@@ -374,7 +374,6 @@
 asmlinkage int sys_execve(char *name, char **argv, char **envp);
 asmlinkage int sys_pipe(unsigned long *fildes);
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 struct pt_regs;
 int sys_request_irq(unsigned int,
 			irqreturn_t (*)(int, void *, struct pt_regs *),
diff -urN linux-bk/include/asm-m68knommu/unistd.h linux/include/asm-m68knommu/unistd.h
--- linux-bk/include/asm-m68knommu/unistd.h	2004-02-25 14:24:15.000000000 -0500
+++ linux/include/asm-m68knommu/unistd.h	2004-02-25 14:46:14.000000000 -0500
@@ -105,7 +105,7 @@
 #define __NR_profil		 98
 #define __NR_statfs		 99
 #define __NR_fstatfs		100
-#define __NR_ioperm		101
+#define __NR_ioperm		/* 101 */ not supported
 #define __NR_socketcall		102
 #define __NR_syslog		103
 #define __NR_setitimer		104
@@ -416,7 +416,6 @@
 asmlinkage int sys_execve(char *name, char **argv, char **envp);
 asmlinkage int sys_pipe(unsigned long *fildes);
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 struct pt_regs;
 int sys_request_irq(unsigned int,
 			irqreturn_t (*)(int, void *, struct pt_regs *),
diff -urN linux-bk/include/asm-parisc/unistd.h linux/include/asm-parisc/unistd.h
--- linux-bk/include/asm-parisc/unistd.h	2004-02-25 14:24:16.000000000 -0500
+++ linux/include/asm-parisc/unistd.h	2004-02-25 14:55:37.000000000 -0500
@@ -909,7 +909,6 @@
 int sys_vfork(struct pt_regs *regs);
 int sys_pipe(int *fildes);
 long sys_ptrace(long request, pid_t pid, long addr, long data);
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
diff -urN linux-bk/include/asm-s390/unistd.h linux/include/asm-s390/unistd.h
--- linux-bk/include/asm-s390/unistd.h	2004-02-25 14:24:16.000000000 -0500
+++ linux/include/asm-s390/unistd.h	2004-02-25 14:52:36.000000000 -0500
@@ -554,7 +554,6 @@
 #endif /* CONFIG_ARCH_S390X */
 asmlinkage __SYS_RETTYPE sys_pipe(unsigned long *fildes);
 asmlinkage int sys_ptrace(long request, long pid, long addr, long data);
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
diff -urN linux-bk/include/asm-sparc/unistd.h linux/include/asm-sparc/unistd.h
--- linux-bk/include/asm-sparc/unistd.h	2004-02-25 14:24:16.000000000 -0500
+++ linux/include/asm-sparc/unistd.h	2004-02-25 14:55:06.000000000 -0500
@@ -461,7 +461,6 @@
 				unsigned long addr, unsigned long len,
 				unsigned long prot, unsigned long flags,
 				unsigned long fd, unsigned long pgoff);
-asmlinkage int sys_ioperm(unsigned long from, unsigned long num, int on);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,
diff -urN linux-bk/include/asm-sparc64/unistd.h linux/include/asm-sparc64/unistd.h
--- linux-bk/include/asm-sparc64/unistd.h	2004-02-25 14:24:16.000000000 -0500
+++ linux/include/asm-sparc64/unistd.h	2004-02-25 14:53:57.000000000 -0500
@@ -447,7 +447,6 @@
 				unsigned long addr, unsigned long len,
 				unsigned long prot, unsigned long flags,
 				unsigned long fd, unsigned long off);
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,

--------------090206090308000304040106--
