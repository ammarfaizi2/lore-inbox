Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWH0X74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWH0X74 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 19:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWH0X7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 19:59:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:37339 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932316AbWH0X64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:58:56 -0400
Message-Id: <20060827215636.263883000@klappe.arndb.de>
References: <20060827214734.252316000@klappe.arndb.de>
Date: Sun, 27 Aug 2006 23:47:37 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au
Subject: [PATCH 3/7] provide kernel_execve on all architectures
Content-Disposition: inline; filename=kerne-execve2.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the new kernel_execve function on all architectures
that were using _syscall3() to implement execve.

The implementation uses code from the _syscall3 macros provided
in the unistd.h header file. I don't have cross-compilers for
any of these architectures, so the patch is untested with the
exception of i386.

Most architectures can probably implement this in a nicer way
in assembly or by combining it with the sys_execve implementation
itself, but this should do it for now.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-cg/arch/frv/kernel/sys_frv.c
===================================================================
--- linux-cg.orig/arch/frv/kernel/sys_frv.c	2006-08-27 21:36:06.000000000 +0200
+++ linux-cg/arch/frv/kernel/sys_frv.c	2006-08-27 21:36:52.000000000 +0200
@@ -212,3 +212,19 @@
 		return -ENOSYS;
 	}
 }
+
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	register unsigned long __scnum __asm__ ("gr7") = __NR_execve;
+	register unsigned long __sc0 __asm__ ("gr8") = (unsigned long) filename;
+	register unsigned long __sc1 __asm__ ("gr9") = (unsigned long) argv;
+	register unsigned long __sc2 __asm__ ("gr10") = (unsigned long) envp;
+	__asm__ __volatile__ ("tira gr0,#0"
+			      : "+r" (__sc0)
+			      : "r" (__scnum), "r" (__sc1), "r" (__sc2));
+	return __sc0;
+}
Index: linux-cg/arch/h8300/kernel/sys_h8300.c
===================================================================
--- linux-cg.orig/arch/h8300/kernel/sys_h8300.c	2006-08-27 21:36:06.000000000 +0200
+++ linux-cg/arch/h8300/kernel/sys_h8300.c	2006-08-27 21:36:52.000000000 +0200
@@ -280,3 +280,26 @@
                ((regs->pc)&0xffffff)-2,regs->orig_er0,regs->er1,regs->er2,regs->er3,regs->er0);
 }
 #endif
+
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	register long res __asm__("er0");
+	register const char * _a __asm__("er1") = filename;
+	register void *_b __asm__("er2") = argv;
+	register void *_c __asm__("er3") = envp;
+	__asm__ __volatile__ ("mov.l %1,er0\n\t"
+			"trapa	#0\n\t"
+			: "=r" (res)
+			: "g" (__NR_execve),
+			  "g" (_a),
+			  "g" (_b),
+			  "g" (_c)
+			: "cc", "memory");
+	return res;
+}
+
+
Index: linux-cg/arch/i386/kernel/sys_i386.c
===================================================================
--- linux-cg.orig/arch/i386/kernel/sys_i386.c	2006-08-27 21:36:06.000000000 +0200
+++ linux-cg/arch/i386/kernel/sys_i386.c	2006-08-27 21:36:52.000000000 +0200
@@ -243,3 +243,17 @@
 
 	return error;
 }
+
+
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	long __res;
+	asm volatile ("push %%ebx ; movl %2,%%ebx ; int $0x80 ; pop %%ebx"
+	: "=a" (__res)
+	: "0" (__NR_execve),"ri" (filename),"c" (argv), "d" (envp) : "memory");
+	return __res;
+}
Index: linux-cg/arch/m32r/kernel/sys_m32r.c
===================================================================
--- linux-cg.orig/arch/m32r/kernel/sys_m32r.c	2006-08-27 21:36:06.000000000 +0200
+++ linux-cg/arch/m32r/kernel/sys_m32r.c	2006-08-27 21:36:52.000000000 +0200
@@ -25,6 +25,8 @@
 #include <asm/cachectl.h>
 #include <asm/cacheflush.h>
 #include <asm/ipc.h>
+#include <asm/syscall.h>
+#include <asm/unistd.h>
 
 /*
  * sys_tas() - test-and-set
@@ -223,3 +225,21 @@
 	return -ENOSYS;
 }
 
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	register long __scno __asm__ ("r7") = __NR_execve;
+	register long __arg3 __asm__ ("r2") = (long)(envp);
+	register long __arg2 __asm__ ("r1") = (long)(argv);
+	register long __res __asm__ ("r0") = (long)(filename);
+	__asm__ __volatile__ (
+		"trap #" SYSCALL_VECTOR "|| nop"
+		: "=r" (__res)
+		: "r" (__scno), "0" (__res), "r" (__arg2),
+			"r" (__arg3)
+		: "memory");
+	return __res;
+}
Index: linux-cg/arch/m68k/kernel/sys_m68k.c
===================================================================
--- linux-cg.orig/arch/m68k/kernel/sys_m68k.c	2006-08-27 21:36:06.000000000 +0200
+++ linux-cg/arch/m68k/kernel/sys_m68k.c	2006-08-27 21:36:52.000000000 +0200
@@ -663,3 +663,18 @@
 {
 	return PAGE_SIZE;
 }
+
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	register long __res asm ("%d0") = __NR_execve;
+	register long __a asm ("%d1") = (long)(filename);
+	register long __b asm ("%d2") = (long)(argv);
+	register long __c asm ("%d3") = (long)(envp);
+	asm volatile ("trap  #0" : "+d" (__res)
+			: "d" (__a), "d" (__b), "d" (__c));
+	return __res;
+}
Index: linux-cg/arch/m68knommu/kernel/sys_m68k.c
===================================================================
--- linux-cg.orig/arch/m68knommu/kernel/sys_m68k.c	2006-08-27 21:36:06.000000000 +0200
+++ linux-cg/arch/m68knommu/kernel/sys_m68k.c	2006-08-27 21:36:52.000000000 +0200
@@ -206,3 +206,17 @@
 	return PAGE_SIZE;
 }
 
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	register long __res asm ("%d0") = __NR_execve;
+	register long __a asm ("%d1") = (long)(filename);
+	register long __b asm ("%d2") = (long)(argv);
+	register long __c asm ("%d3") = (long)(envp);
+	asm volatile ("trap  #0" : "+d" (__res)
+			: "d" (__a), "d" (__b), "d" (__c));
+	return __res;
+}
Index: linux-cg/arch/mips/kernel/syscall.c
===================================================================
--- linux-cg.orig/arch/mips/kernel/syscall.c	2006-08-27 21:36:06.000000000 +0200
+++ linux-cg/arch/mips/kernel/syscall.c	2006-08-27 21:36:52.000000000 +0200
@@ -399,3 +399,27 @@
 {
 	do_exit(SIGSEGV);
 }
+
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	register unsigned long __a0 asm("$4") = (unsigned long) filename;
+	register unsigned long __a1 asm("$5") = (unsigned long) argv;
+	register unsigned long __a2 asm("$6") = (unsigned long) envp;
+	register unsigned long __a3 asm("$7");
+	unsigned long __v0;
+	__asm__ volatile (
+	".set\tnoreorder\n\t"
+	"li\t$2, %5\t\t\t# " #name "\n\t"
+	"syscall\n\t"
+	"move\t%0, $2\n\t"
+	".set\treorder"
+	: "=&r" (__v0), "=r" (__a3)
+	: "r" (__a0), "r" (__a1), "r" (__a2), "i" (__NR_execve)
+	: "$2", "$8", "$9", "$10", "$11", "$12", "$13", "$14", "$15", "$24",
+	  "memory");
+	return __v0;
+}
Index: linux-cg/arch/s390/kernel/sys_s390.c
===================================================================
--- linux-cg.orig/arch/s390/kernel/sys_s390.c	2006-08-27 21:36:06.000000000 +0200
+++ linux-cg/arch/s390/kernel/sys_s390.c	2006-08-27 21:36:52.000000000 +0200
@@ -266,3 +266,21 @@
 	return sys_fadvise64_64(a.fd, a.offset, a.len, a.advice);
 }
 
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	register const char *__arg1 asm("2") = filename;
+	register void *__arg2 asm("3") = argv;
+	register void *__arg3 asm("4") = envp;
+	register long __svcres asm("2");
+	asm volatile ("svc %b1"
+		: "=d" (__svcres)
+		: "i" (__NR_execve),
+		  "0" (__arg1),
+		  "d" (__arg2),
+		  "d" (__arg3) : "1", "cc", "memory");
+	return __svcres;
+}
Index: linux-cg/arch/sh/kernel/sys_sh.c
===================================================================
--- linux-cg.orig/arch/sh/kernel/sys_sh.c	2006-08-27 21:36:06.000000000 +0200
+++ linux-cg/arch/sh/kernel/sys_sh.c	2006-08-27 21:36:52.000000000 +0200
@@ -295,3 +295,19 @@
 				(u64)len0 << 32 | len1,	advice);
 #endif
 }
+
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	register long __sc0 __asm__ ("r3") = __NR_execve;
+	register long __sc4 __asm__ ("r4") = (long) filename;
+	register long __sc5 __asm__ ("r5") = (long) argv;
+	register long __sc6 __asm__ ("r6") = (long) envp;
+	__asm__ __volatile__ ("trapa	#0x13" : "=z" (__sc0)
+			: "0" (__sc0), "r" (__sc4), "r" (__sc5), "r" (__sc6)
+			: "memory");
+	return __sc0;
+}
Index: linux-cg/arch/sh64/kernel/sys_sh64.c
===================================================================
--- linux-cg.orig/arch/sh64/kernel/sys_sh64.c	2006-08-27 21:36:06.000000000 +0200
+++ linux-cg/arch/sh64/kernel/sys_sh64.c	2006-08-27 21:36:52.000000000 +0200
@@ -283,3 +283,21 @@
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
+
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	register unsigned long __sc0 __asm__ ("r9") = ((0x13 << 16) | __NR_execve);
+	register unsigned long __sc2 __asm__ ("r2") = (unsigned long) filename;
+	register unsigned long __sc3 __asm__ ("r3") = (unsigned long) argv;
+	register unsigned long __sc4 __asm__ ("r4") = (unsigned long) envp;
+	__asm__ __volatile__ ("trapa	%1 !\t\t\t execve(%2,%3,%4)"
+	: "=r" (__sc0)
+	: "r" (__sc0), "r" (__sc2), "r" (__sc3), "r" (__sc4) );
+	__asm__ __volatile__ ("!dummy	%0 %1 %2 %3"
+	: : "r" (__sc0), "r" (__sc2), "r" (__sc3), "r" (__sc4) : "memory");
+	return __sc0;
+}
Index: linux-cg/arch/sparc/kernel/sys_sparc.c
===================================================================
--- linux-cg.orig/arch/sparc/kernel/sys_sparc.c	2006-08-27 21:36:06.000000000 +0200
+++ linux-cg/arch/sparc/kernel/sys_sparc.c	2006-08-27 21:36:52.000000000 +0200
@@ -483,3 +483,25 @@
 	up_read(&uts_sem);
 	return err;
 }
+
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	long __res;
+	register long __g1 __asm__ ("g1") = __NR_execve;
+	register long __o0 __asm__ ("o0") = (long)(filename);
+	register long __o1 __asm__ ("o1") = (long)(argv);
+	register long __o2 __asm__ ("o2") = (long)(envp);
+	asm volatile ("t 0x10\n\t"
+		      "bcc 1f\n\t"
+		      "mov %%o0, %0\n\t"
+		      "sub %%g0, %%o0, %0\n\t"
+		      "1:\n\t"
+		      : "=r" (__res), "=&r" (__o0)
+		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__g1)
+		      : "cc");
+	return __res;
+}
Index: linux-cg/arch/sparc64/kernel/sys_sparc.c
===================================================================
--- linux-cg.orig/arch/sparc64/kernel/sys_sparc.c	2006-08-27 21:36:06.000000000 +0200
+++ linux-cg/arch/sparc64/kernel/sys_sparc.c	2006-08-27 21:36:52.000000000 +0200
@@ -957,3 +957,23 @@
 	};
 	return err;
 }
+
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	long __res;
+	register long __g1 __asm__ ("g1") = __NR_execve;
+	register long __o0 __asm__ ("o0") = (long)(filename);
+	register long __o1 __asm__ ("o1") = (long)(argv);
+	register long __o2 __asm__ ("o2") = (long)(envp);
+	asm volatile ("t 0x6d\n\t"
+		      "sub %%g0, %%o0, %0\n\t"
+		      "movcc %%xcc, %%o0, %0\n\t"
+		      : "=r" (__res), "=&r" (__o0)
+		      : "1" (__o0), "r" (__o1), "r" (__o2), "r" (__g1)
+		      : "cc");
+	return __res;
+}
Index: linux-cg/arch/v850/kernel/syscalls.c
===================================================================
--- linux-cg.orig/arch/v850/kernel/syscalls.c	2006-08-27 21:36:06.000000000 +0200
+++ linux-cg/arch/v850/kernel/syscalls.c	2006-08-27 21:36:52.000000000 +0200
@@ -194,3 +194,22 @@
 out:
 	return err;
 }
+
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	register char *__a __asm__ ("r6") = filename;
+	register void *__b __asm__ ("r7") = argv;
+	register void *__c __asm__ ("r8") = envp;
+	register unsigned long __syscall __asm__ ("r12") = __NR_execve;
+	register unsigned long __ret __asm__ ("r10");
+	__asm__ __volatile__ ("trap 0"
+			: "=r" (__ret), "=r" (__syscall)
+			: "1" (__syscall), "r" (__a), "r" (__b), "r" (__c)
+			: "r1", "r5", "r11", "r13", "r14",
+			  "r15", "r16", "r17", "r18", "r19");
+	return __ret;
+}
Index: linux-cg/arch/xtensa/kernel/syscalls.c
===================================================================
--- linux-cg.orig/arch/xtensa/kernel/syscalls.c	2006-08-27 21:36:06.000000000 +0200
+++ linux-cg/arch/xtensa/kernel/syscalls.c	2006-08-27 21:36:52.000000000 +0200
@@ -266,3 +266,23 @@
 	regs->areg[2] = res;
 	do_syscall_trace();
 }
+
+/*
+ * Do a system call from kernel instead of calling sys_execve so we
+ * end up with proper pt_regs.
+ */
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	long __res;
+	asm volatile (
+		"  mov   a5, %2 \n"
+		"  mov   a4, %4 \n"
+		"  mov   a3, %3 \n"
+		"  movi  a2, %1 \n"
+		"  syscall      \n"
+		"  mov   %0, a2 \n"
+		: "=a" (__res)
+		: "i" (__NR_execve), "a" (filename), "a" (argv), "a" (envp)
+		: "a2", "a3", "a4", "a5");
+	return __res;
+}

--

