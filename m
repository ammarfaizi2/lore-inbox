Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbUBZEJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 23:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbUBZEJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 23:09:31 -0500
Received: from pxy7allmi.all.mi.charter.com ([24.247.15.58]:51688 "EHLO
	proxy7-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S262649AbUBZEJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 23:09:00 -0500
Message-ID: <403D721D.6030705@quark.didntduck.org>
Date: Wed, 25 Feb 2004 23:12:13 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040116
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Andrew Morton <akpm@osdl.org>, bgerst@didntduck.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Clean up sys_ioperm stubs
References: <403D5F32.4080805@quark.didntduck.org> <20040226030523.GE31035@parcelfarce.linux.theplanet.co.uk> <20040225191140.36288919.akpm@osdl.org> <20040226031553.GF31035@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040226031553.GF31035@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/mixed;
 boundary="------------050201030906070705030406"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050201030906070705030406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Feb 25, 2004 at 07:11:40PM -0800, Andrew Morton wrote:
> 
>>viro@parcelfarce.linux.theplanet.co.uk wrote:
>>
>>>On Wed, Feb 25, 2004 at 09:51:30PM -0500, Brian Gerst wrote:
>>>
>>>>Remove stubs for sys_ioperm for non-x86 arches, using sys_ni_syscall 
>>>>instead where applicable.
>>>
>>>I have better suggestion: make sys_ioperm() a cond_syscall().  Then kill
>>>its implementation on all platforms where it just returns -ENOSYS.
>>
>>Why is that better?  Sticking a pointer to the not-implemented-syscall into
>>the syscall table is pretty darn explicit.
> 
> 
> No chance of reuse.  BTW,
> #define __NR_ioperm	/* 101 */ <uncommented text>
> is asking for trouble.  You get the symbol defined (so that will fool any
> ifdef) and it expands to something completely bogus.
> 

cond_syscall() should be used for cases where a config option controls 
the syscall.  Support for sys_ioperm is unconditionally no for non-x86 
arches.

In practice, new syscalls are added to the end of the table, so reuse 
isn't a major issue.  I backed out the uncommened text with __NR_ioperm, 
but there are other examples of this in those files that I just copied. 
  An audit of unistd.h needs to be done.

--
				Brian Gerst

--------------050201030906070705030406
Content-Type: text/plain;
 name="ioperm-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ioperm-2"

diff -urN linux-bk/arch/h8300/kernel/syscalls.S linux/arch/h8300/kernel/syscalls.S
--- linux-bk/arch/h8300/kernel/syscalls.S	2003-12-17 21:58:38.000000000 -0500
+++ linux/arch/h8300/kernel/syscalls.S	2004-02-25 22:42:50.614012040 -0500
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
+++ linux/arch/h8300/kernel/sys_h8300.c	2004-02-25 22:42:50.614012040 -0500
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
+++ linux/arch/m68k/kernel/entry.S	2004-02-25 22:42:50.614012040 -0500
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
+++ linux/arch/m68k/kernel/sys_m68k.c	2004-02-25 22:42:50.678002312 -0500
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
+++ linux/arch/m68knommu/kernel/syscalltable.S	2004-02-25 22:42:50.678002312 -0500
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
+++ linux/arch/m68knommu/kernel/sys_m68k.c	2004-02-25 22:42:50.678002312 -0500
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
+++ linux/arch/parisc/kernel/sys_parisc.c	2004-02-25 22:42:50.725995016 -0500
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
+++ linux/arch/s390/kernel/syscalls.S	2004-02-25 22:42:50.726994864 -0500
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
+++ linux/arch/s390/kernel/sys_s390.c	2004-02-25 22:42:50.726994864 -0500
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
+++ linux/arch/sparc/kernel/setup.c	2004-02-25 22:42:50.727994712 -0500
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
+++ linux/arch/sparc64/kernel/setup.c	2004-02-25 22:42:50.757990152 -0500
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
+++ linux/arch/sparc64/kernel/sys_sparc32.c	2004-02-25 22:42:50.759989848 -0500
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
+++ linux/include/asm-h8300/unistd.h	2004-02-25 22:45:24.077682016 -0500
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
+++ linux/include/asm-m68k/unistd.h	2004-02-25 22:45:51.098574216 -0500
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
+++ linux/include/asm-m68knommu/unistd.h	2004-02-25 22:46:16.741675872 -0500
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
+++ linux/include/asm-parisc/unistd.h	2004-02-25 22:42:50.797984000 -0500
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
+++ linux/include/asm-s390/unistd.h	2004-02-25 22:42:50.828979000 -0500
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
+++ linux/include/asm-sparc/unistd.h	2004-02-25 22:42:50.829979000 -0500
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
+++ linux/include/asm-sparc64/unistd.h	2004-02-25 22:42:50.829979000 -0500
@@ -447,7 +447,6 @@
 				unsigned long addr, unsigned long len,
 				unsigned long prot, unsigned long flags,
 				unsigned long fd, unsigned long off);
-asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,

--------------050201030906070705030406--
