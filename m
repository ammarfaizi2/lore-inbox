Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVC0FXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVC0FXP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 00:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVC0FXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 00:23:15 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:21349
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261227AbVC0FW4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 00:22:56 -0500
Date: Sat, 26 Mar 2005 23:49:38 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: seccomp for ppc64
Message-ID: <20050326224938.GC4053@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch against 12-rc1 adds seccomp to the ppc64 arch. I tested it
successfully with the seccomp_test. I didn't bother to change the
syscall exit not to check for TIF_SECCOMP, in theory that bit could be
optimized but it's an optimization in the slow path, and current code is
a bit simpler. I also verified it still compiles and works fine on x86
and x86-64.

Instead of the TIF_32BIT redefine, if you want to change x86-64 to use
TIF_32BIT too (instead of TIF_IA32), let me know.

Thanks.

Signed-off-by: Andrea Arcangeli <andrea@cpushare.com>

--- 2.6.12/arch/ppc64/Kconfig	2005-03-25 05:13:26.000000000 +0100
+++ 2.6.12-seccomp-1/arch/ppc64/Kconfig	2005-03-26 16:38:06.000000000 +0100
@@ -273,6 +273,23 @@ config LPARCFG
 	Provide system capacity information via human readable
 	<key word>=<value> pairs through a /proc/ppc64/lparcfg interface.
 
+config SECCOMP
+	bool "Enable seccomp to safely compute untrusted bytecode"
+	depends on PROC_FS
+	default y
+	help
+	  This kernel feature is useful for number crunching applications
+	  that may need to compute untrusted bytecode during their
+	  execution. By using pipes or other transports made available to
+	  the process as file descriptors supporting the read/write
+	  syscalls, it's possible to isolate those applications in
+	  their own address space using seccomp. Once seccomp is
+	  enabled via /proc/<pid>/seccomp, it cannot be disabled
+	  and the task is only allowed to execute a few safe syscalls
+	  defined by each seccomp mode.
+
+	  If unsure, say Y. Only embedded should say N here.
+
 endmenu
 
 
--- 2.6.12/arch/ppc64/kernel/ptrace.c	2005-03-08 01:01:12.000000000 +0100
+++ 2.6.12-seccomp-1/arch/ppc64/kernel/ptrace.c	2005-03-26 16:33:12.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/user.h>
 #include <linux/security.h>
 #include <linux/audit.h>
+#include <linux/seccomp.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -303,6 +304,8 @@ static void do_syscall_trace(void)
 
 void do_syscall_trace_enter(struct pt_regs *regs)
 {
+	secure_computing(regs->gpr[0]);
+
 	if (unlikely(current->audit_context))
 		audit_syscall_entry(current, regs->gpr[0],
 				    regs->gpr[3], regs->gpr[4],
--- 2.6.12/include/asm-i386/seccomp.h	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.12-seccomp-1/include/asm-i386/seccomp.h	2005-03-26 18:40:35.000000000 +0100
@@ -0,0 +1,16 @@
+#ifndef _ASM_SECCOMP_H
+
+#include <linux/thread_info.h>
+
+#ifdef TIF_32BIT
+#error "unexpected TIF_32BIT on i386"
+#endif
+
+#include <linux/unistd.h>
+
+#define __NR_seccomp_read __NR_read
+#define __NR_seccomp_write __NR_write
+#define __NR_seccomp_exit __NR_exit
+#define __NR_seccomp_sigreturn __NR_sigreturn
+
+#endif /* _ASM_SECCOMP_H */
--- 2.6.12/include/asm-ppc64/seccomp.h	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.12-seccomp-1/include/asm-ppc64/seccomp.h	2005-03-26 18:41:01.000000000 +0100
@@ -0,0 +1,21 @@
+#ifndef _ASM_SECCOMP_H
+
+#include <linux/thread_info.h> /* already defines TIF_32BIT */
+
+#ifndef TIF_32BIT
+#error "unexpected TIF_32BIT on ppc64"
+#endif
+
+#include <linux/unistd.h>
+
+#define __NR_seccomp_read __NR_read
+#define __NR_seccomp_write __NR_write
+#define __NR_seccomp_exit __NR_exit
+#define __NR_seccomp_sigreturn __NR_rt_sigreturn
+
+#define __NR_seccomp_read_32 __NR_read
+#define __NR_seccomp_write_32 __NR_write
+#define __NR_seccomp_exit_32 __NR_exit
+#define __NR_seccomp_sigreturn_32 __NR_sigreturn
+
+#endif /* _ASM_SECCOMP_H */
--- 2.6.12/include/asm-ppc64/thread_info.h	2005-03-08 01:02:24.000000000 +0100
+++ 2.6.12-seccomp-1/include/asm-ppc64/thread_info.h	2005-03-26 16:31:15.000000000 +0100
@@ -101,6 +101,7 @@ static inline struct thread_info *curren
 #define TIF_SYSCALL_AUDIT	8	/* syscall auditing active */
 #define TIF_SINGLESTEP		9	/* singlestepping active */
 #define TIF_MEMDIE		10
+#define TIF_SECCOMP		11	/* secure computing */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -113,7 +114,8 @@ static inline struct thread_info *curren
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
-#define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
+#define _TIF_SECCOMP		(1<<TIF_SECCOMP)
+#define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP)
 
 #define _TIF_USER_WORK_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | \
 				 _TIF_NEED_RESCHED)
--- 2.6.12/include/asm-x86_64/seccomp.h	1970-01-01 01:00:00.000000000 +0100
+++ 2.6.12-seccomp-1/include/asm-x86_64/seccomp.h	2005-03-26 18:54:18.000000000 +0100
@@ -0,0 +1,24 @@
+#ifndef _ASM_SECCOMP_H
+
+#include <linux/thread_info.h>
+
+#ifdef TIF_32BIT
+#error "unexpected TIF_32BIT on x86_64"
+#else
+#define TIF_32BIT TIF_IA32
+#endif
+
+#include <linux/unistd.h>
+#include <asm/ia32_unistd.h>
+
+#define __NR_seccomp_read __NR_read
+#define __NR_seccomp_write __NR_write
+#define __NR_seccomp_exit __NR_exit
+#define __NR_seccomp_sigreturn __NR_rt_sigreturn
+
+#define __NR_seccomp_read_32 __NR_ia32_read
+#define __NR_seccomp_write_32 __NR_ia32_write
+#define __NR_seccomp_exit_32 __NR_ia32_exit
+#define __NR_seccomp_sigreturn_32 __NR_ia32_sigreturn
+
+#endif /* _ASM_SECCOMP_H */
--- 2.6.12/include/asm-x86_64/unistd.h	2005-03-25 05:13:28.000000000 +0100
+++ 2.6.12-seccomp-1/include/asm-x86_64/unistd.h	2005-03-26 19:30:09.000000000 +0100
@@ -774,7 +774,7 @@ asmlinkage long sys_pipe(int *fildes);
 
 asmlinkage long sys_ptrace(long request, long pid,
 				unsigned long addr, long data);
-asmlinkage long sys_iopl(unsigned int level, struct pt_regs regs);
+asmlinkage long sys_iopl(unsigned int level, struct pt_regs *regs);
 asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int turn_on);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
--- 2.6.12/include/linux/seccomp.h	2005-03-25 05:13:28.000000000 +0100
+++ 2.6.12-seccomp-1/include/linux/seccomp.h	2005-03-26 23:30:59.000000000 +0100
@@ -8,6 +8,7 @@
 #define NR_SECCOMP_MODES 1
 
 #include <linux/thread_info.h>
+#include <asm/seccomp.h>
 
 typedef struct { int mode; } seccomp_t;
 
--- 2.6.12/kernel/seccomp.c	2005-03-25 05:13:28.000000000 +0100
+++ 2.6.12-seccomp-1/kernel/seccomp.c	2005-03-26 23:33:28.000000000 +0100
@@ -8,10 +8,6 @@
 
 #include <linux/seccomp.h>
 #include <linux/sched.h>
-#include <asm/unistd.h>
-#ifdef TIF_IA32
-#include <asm/ia32_unistd.h>
-#endif
 
 /* #define SECCOMP_DEBUG 1 */
 
@@ -21,27 +17,13 @@
  * to limit the stack allocations too.
  */
 static int mode1_syscalls[] = {
-	__NR_read, __NR_write, __NR_exit,
-	/*
-	 * Allow either sigreturn or rt_sigreturn, newer archs
-	 * like x86-64 only defines __NR_rt_sigreturn.
-	 */
-#ifdef __NR_sigreturn
-	__NR_sigreturn,
-#else
-	__NR_rt_sigreturn,
-#endif
+	__NR_seccomp_read, __NR_seccomp_write, __NR_seccomp_exit, __NR_seccomp_sigreturn,
 	0, /* null terminated */
 };
 
-#ifdef TIF_IA32
-static int mode1_syscalls_32bit[] = {
-	__NR_ia32_read, __NR_ia32_write, __NR_ia32_exit,
-	/*
-	 * Allow either sigreturn or rt_sigreturn, newer archs
-	 * like x86-64 only defines __NR_rt_sigreturn.
-	 */
-	__NR_ia32_sigreturn,
+#ifdef TIF_32BIT
+static int mode1_syscalls_32[] = {
+	__NR_seccomp_read_32, __NR_seccomp_write_32, __NR_seccomp_exit_32, __NR_seccomp_sigreturn_32,
 	0, /* null terminated */
 };
 #endif
@@ -54,9 +36,9 @@ void __secure_computing(int this_syscall
 	switch (mode) {
 	case 1:
 		syscall = mode1_syscalls;
-#ifdef TIF_IA32
-		if (test_thread_flag(TIF_IA32))
-			syscall = mode1_syscalls_32bit;
+#ifdef TIF_32BIT
+		if (test_thread_flag(TIF_32BIT))
+			syscall = mode1_syscalls_32;
 #endif
 		do {
 			if (*syscall == this_syscall)
