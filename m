Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266171AbUGATgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266171AbUGATgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 15:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266234AbUGATgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 15:36:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44747 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266171AbUGATgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 15:36:46 -0400
Date: Thu, 1 Jul 2004 14:01:36 -0400
Message-Id: <200407011801.i61I1aOs011976@redrum.boston.redhat.com>
From: Peter Martuccelli <peterm@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IA64 audit support
Cc: akpm@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is one of the audit tasks we talked about.  This patch adds 
ia64 support to the audit subsystem.  I have tested the ia64 audit 
support without any issues to report. The original patch was from
from Ray Lanza.  Requesting patch to be merged in the next version. 

Please CC me with any comments, problems, changes, etc.

Peter-


diffstat:
 arch/ia64/ia32/ia32_entry.S    |    8 ++++---
 arch/ia64/kernel/entry.S       |   10 +++++----
 arch/ia64/kernel/ivt.S         |    7 ++++--
 arch/ia64/kernel/ptrace.c      |   43 +++++++++++++++++++++++++++++++++++++++--
 include/asm-ia64/thread_info.h |    5 +++-
 init/Kconfig                   |    2 -
 6 files changed, 62 insertions(+), 13 deletions(-)

diff -Naurp linux-2.6.7-pristine/arch/ia64/ia32/ia32_entry.S linux-2.6.7/arch/ia64/ia32/ia32_entry.S
--- linux-2.6.7-pristine/arch/ia64/ia32/ia32_entry.S	2004-06-16 16:32:05.000000000 -0400
+++ linux-2.6.7/arch/ia64/ia32/ia32_entry.S	2004-06-16 16:34:10.000000000 -0400
@@ -110,7 +110,9 @@ GLOBAL_ENTRY(ia32_ret_from_clone)
 	ld4 r2=[r2]
 	;;
 	mov r8=0
-	tbit.nz p6,p0=r2,TIF_SYSCALL_TRACE
+	and r2=_TIF_SYSCALL_TRACEAUDIT,r2
+	;; 
+	cmp.ne p6,p0=r2,r0
 (p6)	br.cond.spnt .ia32_strace_check_retval
 	;;					// prevent RAW on r8
 END(ia32_ret_from_clone)
@@ -142,7 +144,7 @@ GLOBAL_ENTRY(ia32_trace_syscall)
 	adds r2=IA64_PT_REGS_R8_OFFSET+16,sp
 	;;
 	st8 [r2]=r3				// initialize return code to -ENOSYS
-	br.call.sptk.few rp=syscall_trace	// give parent a chance to catch syscall args
+	br.call.sptk.few rp=syscall_trace_enter	// give parent a chance to catch syscall args
 .ret2:	// Need to reload arguments (they may be changed by the tracing process)
 	adds r2=IA64_PT_REGS_R1_OFFSET+16,sp	// r2 = &pt_regs.r1
 	adds r3=IA64_PT_REGS_R13_OFFSET+16,sp	// r3 = &pt_regs.r13
@@ -170,7 +172,7 @@ GLOBAL_ENTRY(ia32_trace_syscall)
 	adds r2=IA64_PT_REGS_R8_OFFSET+16,sp	// r2 = &pt_regs.r8
 	;;
 	st8.spill [r2]=r8			// store return value in slot for r8
-	br.call.sptk.few rp=syscall_trace	// give parent a chance to catch return value
+	br.call.sptk.few rp=syscall_trace_leave	// give parent a chance to catch return value
 .ret4:	alloc r2=ar.pfs,0,0,0,0			// drop the syscall argument frame
 	br.cond.sptk.many ia64_leave_kernel
 END(ia32_trace_syscall)
diff -Naurp linux-2.6.7-pristine/arch/ia64/kernel/entry.S linux-2.6.7/arch/ia64/kernel/entry.S
--- linux-2.6.7-pristine/arch/ia64/kernel/entry.S	2004-06-16 16:32:05.000000000 -0400
+++ linux-2.6.7/arch/ia64/kernel/entry.S	2004-06-16 16:34:10.000000000 -0400
@@ -506,7 +506,7 @@ GLOBAL_ENTRY(ia64_trace_syscall)
 	;;
  	stf.spill [r16]=f10
  	stf.spill [r17]=f11
-	br.call.sptk.many rp=syscall_trace // give parent a chance to catch syscall args
+	br.call.sptk.many rp=syscall_trace_enter // give parent a chance to catch syscall args
 	adds r16=PT(F6)+16,sp
 	adds r17=PT(F7)+16,sp
 	;;
@@ -546,7 +546,7 @@ GLOBAL_ENTRY(ia64_trace_syscall)
 .strace_save_retval:
 .mem.offset 0,0; st8.spill [r2]=r8		// store return value in slot for r8
 .mem.offset 8,0; st8.spill [r3]=r10		// clear error indication in slot for r10
-	br.call.sptk.many rp=syscall_trace // give parent a chance to catch return value
+	br.call.sptk.many rp=syscall_trace_leave // give parent a chance to catch return value
 .ret3:	br.cond.sptk ia64_leave_syscall
 
 strace_error:
@@ -573,7 +573,7 @@ GLOBAL_ENTRY(ia64_strace_leave_kernel)
 	 */
 	nop.m 0
 	nop.i 0
-	br.call.sptk.many rp=syscall_trace // give parent a chance to catch return value
+	br.call.sptk.many rp=syscall_trace_leave // give parent a chance to catch return value
 }
 .ret4:	br.cond.sptk ia64_leave_kernel
 END(ia64_strace_leave_kernel)
@@ -599,7 +599,9 @@ GLOBAL_ENTRY(ia64_ret_from_clone)
 	ld4 r2=[r2]
 	;;
 	mov r8=0
-	tbit.nz p6,p0=r2,TIF_SYSCALL_TRACE
+	and r2=_TIF_SYSCALL_TRACEAUDIT,r2
+	;;
+	cmp.ne p6,p0=r2,r0
 (p6)	br.cond.spnt .strace_check_retval
 	;;					// added stop bits to prevent r8 dependency
 END(ia64_ret_from_clone)
diff -Naurp linux-2.6.7-pristine/arch/ia64/kernel/ivt.S linux-2.6.7/arch/ia64/kernel/ivt.S
--- linux-2.6.7-pristine/arch/ia64/kernel/ivt.S	2004-06-16 16:32:05.000000000 -0400
+++ linux-2.6.7/arch/ia64/kernel/ivt.S	2004-06-16 16:42:44.000000000 -0400
@@ -752,7 +752,9 @@ ENTRY(break_fault)
 	;;
 	ld4 r2=[r2]				// r2 = current_thread_info()->flags
 	;;
-	tbit.z p8,p0=r2,TIF_SYSCALL_TRACE
+	and r2=_TIF_SYSCALL_TRACEAUDIT,r2	// mask trace or audit
+	;; 
+	cmp.eq p8,p0=r2,r0
 	mov b6=r20
 	;;
 (p8)	br.call.sptk.many b6=b6			// ignore this return addr
@@ -1573,10 +1575,11 @@ ENTRY(dispatch_to_ia32_handler)
 	ld4 r2=[r2]		// r2 = current_thread_info()->flags
 	;;
 	ld8 r16=[r16]
-	tbit.z p8,p0=r2,TIF_SYSCALL_TRACE
+	and r2=_TIF_SYSCALL_TRACEAUDIT,r2	// mask trace or audit
 	;;
 	mov b6=r16
 	movl r15=ia32_ret_from_syscall
+	cmp.eq p8,p0=r2,r0
 	;;
 	mov rp=r15
 (p8)	br.call.sptk.many b6=b6
diff -Naurp linux-2.6.7-pristine/arch/ia64/kernel/ptrace.c linux-2.6.7/arch/ia64/kernel/ptrace.c
--- linux-2.6.7-pristine/arch/ia64/kernel/ptrace.c	2004-06-16 16:32:05.000000000 -0400
+++ linux-2.6.7/arch/ia64/kernel/ptrace.c	2004-06-16 16:34:10.000000000 -0400
@@ -1447,9 +1447,8 @@ sys_ptrace (long request, pid_t pid, uns
 	return ret;
 }
 
-/* "asmlinkage" so the input arguments are preserved... */
 
-asmlinkage void
+void
 syscall_trace (void)
 {
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
@@ -1472,3 +1471,43 @@ syscall_trace (void)
 		current->exit_code = 0;
 	}
 }
+
+/* "asmlinkage" so the input arguments are preserved... */
+
+asmlinkage void 
+syscall_trace_enter (long arg0, long arg1, long arg2, long arg3,
+	  long arg4, long arg5, long arg6, long arg7, long stack)
+{
+	struct pt_regs *regs = (struct pt_regs *) &stack;
+	long syscall;
+	unsigned long 	psr = regs->cr_ipsr;	/* process status word */
+
+	if (unlikely(current->audit_context)) {
+		if (psr & IA64_PSR_IS) 
+			syscall = regs->r1;
+		else
+			syscall = regs->r15;
+
+		audit_syscall_entry(current, syscall, arg0, arg1, arg2, arg3);
+	}
+
+	if (test_thread_flag(TIF_SYSCALL_TRACE)
+	    && (current->ptrace & PT_PTRACED))
+		syscall_trace();
+}
+
+/* "asmlinkage" so the input arguments are preserved... */
+
+asmlinkage void 
+syscall_trace_leave (long arg0, long arg1, long arg2, long arg3,
+	  long arg4, long arg5, long arg6, long arg7, long stack)
+{
+	struct pt_regs *regs = (struct pt_regs *) &stack;
+
+	if (unlikely(current->audit_context))
+		audit_syscall_exit(current, regs->r8);
+
+	if (test_thread_flag(TIF_SYSCALL_TRACE)
+	    && (current->ptrace & PT_PTRACED))
+		syscall_trace();
+}
diff -Naurp linux-2.6.7-pristine/include/asm-ia64/thread_info.h linux-2.6.7/include/asm-ia64/thread_info.h
--- linux-2.6.7-pristine/include/asm-ia64/thread_info.h	2004-06-16 16:32:09.000000000 -0400
+++ linux-2.6.7/include/asm-ia64/thread_info.h	2004-06-16 16:34:10.000000000 -0400
@@ -73,12 +73,15 @@ struct thread_info {
 #define TIF_SIGPENDING		1	/* signal pending */
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
 #define TIF_SYSCALL_TRACE	3	/* syscall trace active */
+#define TIF_SYSCALL_AUDIT	4	/* syscall auditing active */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 
 #define TIF_WORK_MASK		0x7	/* like TIF_ALLWORK_BITS but sans TIF_SYSCALL_TRACE */
-#define TIF_ALLWORK_MASK	0xf	/* bits 0..3 are "work to do on user-return" bits */
+#define TIF_ALLWORK_MASK	0x1f	/* bits 0..4 are "work to do on user-return" bits */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
+#define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
+#define _TIF_SYSCALL_TRACEAUDIT	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
diff -Naurp linux-2.6.7-pristine/init/Kconfig linux-2.6.7/init/Kconfig
--- linux-2.6.7-pristine/init/Kconfig	2004-06-16 16:33:52.000000000 -0400
+++ linux-2.6.7/init/Kconfig	2004-06-16 16:34:10.000000000 -0400
@@ -149,7 +149,7 @@ config AUDIT
 
 config AUDITSYSCALL
 	bool "Enable system-call auditing support"
-	depends on AUDIT && (X86 || PPC64 || ARCH_S390)
+	depends on AUDIT && (X86 || PPC64 || ARCH_S390 || IA64)
 	default y if SECURITY_SELINUX
 	default n
 	help

