Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUCKOaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 09:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbUCKO37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 09:29:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27349 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261357AbUCKO0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 09:26:02 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16464.30442.852919.24605@neuro.alephnull.com>
Date: Thu, 11 Mar 2004 09:25:46 -0500
From: Rik Faith <faith@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Light-weight Auditing Framework
X-Key: 7EB57214; 958B 394D AD29 257E 553F  E7C7 9F67 4BE0 7EB5 7214
X-Url: http://www.redhat.com/
X-Mailer: VM 7.17; XEmacs 21.4; Linux 2.4.22-1.2163.nptl (neuro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch against 2.6.4 that provides a low-overhead system-call
auditing framework for Linux that is usable by LSM components (e.g.,
SELinux).  This is an update of the patch discussed in this thread:
    http://marc.theaimsgroup.com/?t=107815888100001&r=1&w=2

In brief, it provides for netlink-based logging of audit records that
have been generated in other parts of the kernel (e.g., SELinux) as well
as the ability to audit system calls, either independently (using simple
filtering) or as a compliment to the audit record that another part of
the kernel generated.

The main goals were to provide system call auditing with 1) as low
overhead as possible, and 2) without duplicating functionality that is
already provided by SELinux (and/or other security infrastructures).
This framework will work "stand-alone", but is not designed to provide,
e.g., CAPP functionality without another security component in place.

This updated patch includes changes from feedback I have received,
including the ability to compile without CONFIG_NET (and better use of
tabs, so use -w if you diff against the older patch).

Please see http://people.redhat.com/faith/audit/ for an early example
user-space client (auditd-0.4.tar.gz) and instructions on how to try it.

My future intentions at the kernel level include improving filtering
(e.g., syscall personality/exit codes) and syscall support for more
architectures.  First, though, I'm going to work on documentation, a
(real) audit daemon, and patches for other user-space tools so that
people can play with the framework and understand how it can be used
with and without SELinux.



 arch/i386/kernel/entry.S         |    6 
 arch/i386/kernel/ptrace.c        |    9 
 arch/ppc64/kernel/entry.S        |   15 
 arch/ppc64/kernel/ptrace.c       |   27 -
 arch/x86_64/ia32/ia32entry.S     |   12 
 arch/x86_64/kernel/entry.S       |   21 
 arch/x86_64/kernel/ptrace.c      |   23 -
 fs/namei.c                       |   15 
 include/asm-i386/thread_info.h   |    5 
 include/asm-ppc64/thread_info.h  |    3 
 include/asm-x86_64/thread_info.h |    5 
 include/linux/audit.h            |  202 +++++++++
 include/linux/fs.h               |   14 
 include/linux/netlink.h          |    1 
 include/linux/sched.h            |    5 
 init/Kconfig                     |   20 
 kernel/Makefile                  |    2 
 kernel/audit.c                   |  813 ++++++++++++++++++++++++++++++++++++
 kernel/auditsc.c                 |  869 +++++++++++++++++++++++++++++++++++++++
 kernel/fork.c                    |   10 
 security/selinux/avc.c           |  158 ++-----
 security/selinux/include/avc.h   |    7 
 security/selinux/ss/services.c   |    2 
 23 files changed, 2108 insertions(+), 136 deletions(-)



diff -rupP --exclude-from=ignore linux-2.6.4-pristine/arch/i386/kernel/entry.S linux-2.6.4/arch/i386/kernel/entry.S
--- linux-2.6.4-pristine/arch/i386/kernel/entry.S	2004-03-10 21:55:24.000000000 -0500
+++ linux-2.6.4/arch/i386/kernel/entry.S	2004-03-11 00:05:53.000000000 -0500
@@ -264,7 +264,7 @@ sysenter_past_esp:
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 
-	testb $_TIF_SYSCALL_TRACE,TI_FLAGS(%ebp)
+	testb $_TIF_SYSCALL_T_OR_A,TI_FLAGS(%ebp)
 	jnz syscall_trace_entry
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
@@ -287,7 +287,7 @@ ENTRY(system_call)
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 					# system call tracing in operation
-	testb $_TIF_SYSCALL_TRACE,TI_FLAGS(%ebp)
+	testb $_TIF_SYSCALL_T_OR_A,TI_FLAGS(%ebp)
 	jnz syscall_trace_entry
 syscall_call:
 	call *sys_call_table(,%eax,4)
@@ -354,7 +354,7 @@ syscall_trace_entry:
 	# perform syscall exit tracing
 	ALIGN
 syscall_exit_work:
-	testb $_TIF_SYSCALL_TRACE, %cl
+	testb $_TIF_SYSCALL_T_OR_A, %cl
 	jz work_pending
 	sti				# could let do_syscall_trace() call
 					# schedule() instead
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/arch/i386/kernel/ptrace.c linux-2.6.4/arch/i386/kernel/ptrace.c
--- linux-2.6.4-pristine/arch/i386/kernel/ptrace.c	2004-03-10 21:55:24.000000000 -0500
+++ linux-2.6.4/arch/i386/kernel/ptrace.c	2004-03-11 00:45:57.000000000 -0500
@@ -14,6 +14,7 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/security.h>
+#include <linux/audit.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -524,6 +525,14 @@ out:
 __attribute__((regparm(3)))
 void do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
+	if (unlikely(current->audit_context)) {
+		if (!entryexit)
+			audit_syscall_entry(current, regs->orig_eax,
+					    regs->ebx);
+		else
+			audit_syscall_exit(current);
+	}
+
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;
 	if (!(current->ptrace & PT_PTRACED))
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/arch/ppc64/kernel/entry.S linux-2.6.4/arch/ppc64/kernel/entry.S
--- linux-2.6.4-pristine/arch/ppc64/kernel/entry.S	2004-03-10 21:55:21.000000000 -0500
+++ linux-2.6.4/arch/ppc64/kernel/entry.S	2004-03-11 00:05:53.000000000 -0500
@@ -95,7 +95,7 @@ _GLOBAL(DoSyscall)
 #endif /* SHOW_SYSCALLS */
 	clrrdi	r10,r1,THREAD_SHIFT
 	ld	r10,TI_FLAGS(r10)
-	andi.	r11,r10,_TIF_SYSCALL_TRACE
+	andi.	r11,r10,_TIF_SYSCALL_T_OR_A
 	bne-	50f
 	cmpli	0,r0,NR_syscalls
 	bge-	66f
@@ -151,7 +151,8 @@ _GLOBAL(ret_from_syscall_1)
 	b	22b
         
 /* Traced system call support */
-50:	bl	.do_syscall_trace
+50:	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.do_syscall_trace_enter
 	ld	r0,GPR0(r1)	/* Restore original registers */
 	ld	r3,GPR3(r1)
 	ld	r4,GPR4(r1)
@@ -201,7 +202,7 @@ _GLOBAL(ret_from_syscall_2)
 	oris	r10,r10,0x1000
 	std	r10,_CCR(r1)
 60:	std	r3,GPR3(r1)	/* Update return value */
-	bl	.do_syscall_trace
+	bl	.do_syscall_trace_leave
 	b	.ret_from_except
 66:	li	r3,ENOSYS
 	b	57b
@@ -234,14 +235,14 @@ _GLOBAL(ppc64_rt_sigreturn)
 
 80:	clrrdi	r4,r1,THREAD_SHIFT
 	ld	r4,TI_FLAGS(r4)
-	andi.	r4,r4,_TIF_SYSCALL_TRACE
+	andi.	r4,r4,_TIF_SYSCALL_T_OR_A
 	bne-	81f
 	cmpi	0,r3,0
 	bge	.ret_from_except
 	b	.ret_from_syscall_1
 81:	cmpi	0,r3,0
 	blt	.ret_from_syscall_2
-	bl	.do_syscall_trace
+	bl	.do_syscall_trace_leave
 	b	.ret_from_except
 
 /*
@@ -327,9 +328,9 @@ _GLOBAL(ret_from_fork)
 	bl	.schedule_tail
 	clrrdi	r4,r1,THREAD_SHIFT
 	ld	r4,TI_FLAGS(r4)
-	andi.	r4,r4,_TIF_SYSCALL_TRACE
+	andi.	r4,r4,_TIF_SYSCALL_T_OR_A
 	beq+	.ret_from_except
-	bl	.do_syscall_trace
+	bl	.do_syscall_trace_leave
 	b	.ret_from_except
 
 _GLOBAL(ret_from_except)
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/arch/ppc64/kernel/ptrace.c linux-2.6.4/arch/ppc64/kernel/ptrace.c
--- linux-2.6.4-pristine/arch/ppc64/kernel/ptrace.c	2004-03-10 21:55:43.000000000 -0500
+++ linux-2.6.4/arch/ppc64/kernel/ptrace.c	2004-03-11 00:05:53.000000000 -0500
@@ -26,6 +26,7 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/security.h>
+#include <linux/audit.h>
 
 #include <asm/uaccess.h>
 #include <asm/page.h>
@@ -286,12 +287,8 @@ out:
 	return ret;
 }
 
-void do_syscall_trace(void)
+static void do_syscall_trace(void)
 {
-	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-		return;
-	if (!(current->ptrace & PT_PTRACED))
-		return;
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
 	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
@@ -307,3 +304,23 @@ void do_syscall_trace(void)
 		current->exit_code = 0;
 	}
 }
+
+void do_syscall_trace_enter(struct pt_regs *regs)
+{
+	if (unlikely(current->audit_context))
+		audit_syscall_entry(current, regs->gpr[0], regs->gpr[3]);
+
+	if (test_thread_flag(TIF_SYSCALL_TRACE)
+	    && (current->ptrace & PT_PTRACED))
+		do_syscall_trace();
+}
+
+void do_syscall_trace_leave(void)
+{
+	if (unlikely(current->audit_context))
+		audit_syscall_exit(current);
+
+	if (test_thread_flag(TIF_SYSCALL_TRACE)
+	    && (current->ptrace & PT_PTRACED))
+		do_syscall_trace();
+}
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/arch/x86_64/ia32/ia32entry.S linux-2.6.4/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.4-pristine/arch/x86_64/ia32/ia32entry.S	2004-03-10 21:55:26.000000000 -0500
+++ linux-2.6.4/arch/x86_64/ia32/ia32entry.S	2004-03-11 00:05:53.000000000 -0500
@@ -69,8 +69,8 @@ ENTRY(ia32_cstar_target)
 	.quad 1b,cstar_badarg
 	.previous	
 	GET_THREAD_INFO(%r10)
-	bt  $TIF_SYSCALL_TRACE,threadinfo_flags(%r10)
-	jc  ia32_tracesys
+	testl  $_TIF_SYSCALL_T_OR_A,threadinfo_flags(%r10)
+	jnz  ia32_tracesys
 cstar_do_call:	
 	cmpl $IA32_NR_syscalls,%eax
 	jae  ia32_badsys
@@ -99,7 +99,7 @@ cstar_tracesys:	
 	SAVE_REST
 	movq $-ENOSYS,RAX(%rsp)	/* really needed? */
 	movq %rsp,%rdi        /* &pt_regs -> arg1 */
-	call syscall_trace
+	call syscall_trace_enter
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
 	jmp cstar_do_call
@@ -141,8 +141,8 @@ ENTRY(ia32_syscall)
 	   this could be a problem. */
 	SAVE_ARGS
 	GET_THREAD_INFO(%r10)
-	bt $TIF_SYSCALL_TRACE,threadinfo_flags(%r10)
-	jc ia32_tracesys
+	testl $_TIF_SYSCALL_T_OR_A,threadinfo_flags(%r10)
+	jnz ia32_tracesys
 ia32_do_syscall:	
 	cmpl $(IA32_NR_syscalls),%eax
 	jae  ia32_badsys
@@ -155,7 +155,7 @@ ia32_tracesys:			 
 	SAVE_REST
 	movq $-ENOSYS,RAX(%rsp)	/* really needed? */
 	movq %rsp,%rdi        /* &pt_regs -> arg1 */
-	call syscall_trace
+	call syscall_trace_enter
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
 	jmp ia32_do_syscall
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/arch/x86_64/kernel/entry.S linux-2.6.4/arch/x86_64/kernel/entry.S
--- linux-2.6.4-pristine/arch/x86_64/kernel/entry.S	2004-03-10 21:55:25.000000000 -0500
+++ linux-2.6.4/arch/x86_64/kernel/entry.S	2004-03-11 00:05:53.000000000 -0500
@@ -131,8 +131,8 @@ ENTRY(ret_from_fork)
 	CFI_DEFAULT_STACK
 	call schedule_tail
 	GET_THREAD_INFO(%rcx)
-	bt $TIF_SYSCALL_TRACE,threadinfo_flags(%rcx)
-	jc rff_trace
+	testl $_TIF_SYSCALL_T_OR_A,threadinfo_flags(%rcx)
+	jnz rff_trace
 rff_action:	
 	RESTORE_REST
 	testl $3,CS-ARGOFFSET(%rsp)	# from kernel_thread?
@@ -143,7 +143,7 @@ rff_action:	
 	jmp ret_from_sys_call
 rff_trace:
 	movq %rsp,%rdi
-	call syscall_trace
+	call syscall_trace_leave
 	GET_THREAD_INFO(%rcx)	
 	jmp rff_action
 	CFI_ENDPROC
@@ -185,8 +185,8 @@ ENTRY(system_call)
 	movq  %rax,ORIG_RAX-ARGOFFSET(%rsp) 
 	movq  %rcx,RIP-ARGOFFSET(%rsp)  
 	GET_THREAD_INFO(%rcx)
-	bt    $TIF_SYSCALL_TRACE,threadinfo_flags(%rcx) 
-	jc    tracesys
+	testl $_TIF_SYSCALL_T_OR_A,threadinfo_flags(%rcx) 
+	jnz tracesys
 	cmpq $__NR_syscall_max,%rax
 	ja badsys
 	movq %r10,%rcx
@@ -244,7 +244,7 @@ tracesys:			 
 	movq $-ENOSYS,RAX(%rsp)
 	FIXUP_TOP_OF_STACK %rdi
 	movq %rsp,%rdi
-	call syscall_trace
+	call syscall_trace_enter
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
 	cmpq $__NR_syscall_max,%rax
@@ -254,7 +254,7 @@ tracesys:			 
 	movq %rax,RAX-ARGOFFSET(%rsp)
 1:	SAVE_REST
 	movq %rsp,%rdi
-	call syscall_trace
+	call syscall_trace_leave
 	RESTORE_TOP_OF_STACK %rbx
 	RESTORE_REST
 	jmp ret_from_sys_call
@@ -297,13 +297,14 @@ int_very_careful:
 	sti
 	SAVE_REST
 	/* Check for syscall exit trace */	
-	bt $TIF_SYSCALL_TRACE,%edx
-	jnc int_signal
+	testl $_TIF_SYSCALL_T_OR_A,%edx
+	jz int_signal
 	pushq %rdi
 	leaq 8(%rsp),%rdi	# &ptregs -> arg1	
-	call syscall_trace
+	call syscall_trace_leave
 	popq %rdi
 	btr  $TIF_SYSCALL_TRACE,%edi
+	btr  $TIF_SYSCALL_AUDIT,%edi
 	jmp int_restore_rest
 	
 int_signal:
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/arch/x86_64/kernel/ptrace.c linux-2.6.4/arch/x86_64/kernel/ptrace.c
--- linux-2.6.4-pristine/arch/x86_64/kernel/ptrace.c	2004-03-10 21:55:24.000000000 -0500
+++ linux-2.6.4/arch/x86_64/kernel/ptrace.c	2004-03-11 00:05:53.000000000 -0500
@@ -16,6 +16,7 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/security.h>
+#include <linux/audit.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -486,7 +487,7 @@ out:
 	return ret;
 }
 
-asmlinkage void syscall_trace(struct pt_regs *regs)
+static void syscall_trace(struct pt_regs *regs)
 {
 
 #if 0
@@ -513,3 +514,23 @@ asmlinkage void syscall_trace(struct pt_
 		current->exit_code = 0;
 	}
 }
+
+asmlinkage void syscall_trace_enter(struct pt_regs *regs)
+{
+	if (unlikely(current->audit_context))
+		audit_syscall_entry(current, regs->orig_rax, regs->rdi);
+
+	if (test_thread_flag(TIF_SYSCALL_TRACE)
+	    && (current->ptrace & PT_PTRACED))
+		syscall_trace(regs);
+}
+
+asmlinkage void syscall_trace_leave(struct pt_regs *regs)
+{
+	if (unlikely(current->audit_context))
+		audit_syscall_exit(current);
+	
+	if (test_thread_flag(TIF_SYSCALL_TRACE)
+	    && (current->ptrace & PT_PTRACED))
+		syscall_trace(regs);
+}
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/fs/namei.c linux-2.6.4/fs/namei.c
--- linux-2.6.4-pristine/fs/namei.c	2004-03-10 21:55:25.000000000 -0500
+++ linux-2.6.4/fs/namei.c	2004-03-11 01:05:20.000000000 -0500
@@ -26,6 +26,7 @@
 #include <linux/personality.h>
 #include <linux/security.h>
 #include <linux/mount.h>
+#include <linux/audit.h>
 #include <asm/namei.h>
 #include <asm/uaccess.h>
 
@@ -141,10 +142,12 @@ char * getname(const char __user * filen
 
 		result = tmp;
 		if (retval < 0) {
-			putname(tmp);
+			__putname(tmp);
 			result = ERR_PTR(retval);
 		}
 	}
+	if (unlikely(current->audit_context) && !IS_ERR(result) && result)
+		audit_getname(result);
 	return result;
 }
 
@@ -860,6 +863,8 @@ walk_init_root(const char *name, struct 
 
 int fastcall path_lookup(const char *name, unsigned int flags, struct nameidata *nd)
 {
+	int retval;
+
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags;
 
@@ -882,7 +887,13 @@ int fastcall path_lookup(const char *nam
 	}
 	read_unlock(&current->fs->lock);
 	current->total_link_count = 0;
-	return link_path_walk(name, nd);
+	retval = link_path_walk(name, nd);
+	if (unlikely(current->audit_context
+		     && nd && nd->dentry && nd->dentry->d_inode))
+		audit_inode(name,
+			    nd->dentry->d_inode->i_ino,
+			    nd->dentry->d_inode->i_rdev);
+	return retval;
 }
 
 /*
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/include/asm-i386/thread_info.h linux-2.6.4/include/asm-i386/thread_info.h
--- linux-2.6.4-pristine/include/asm-i386/thread_info.h	2004-03-10 21:55:22.000000000 -0500
+++ linux-2.6.4/include/asm-i386/thread_info.h	2004-03-11 00:05:53.000000000 -0500
@@ -133,6 +133,7 @@ static inline struct thread_info *curren
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
+#define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -141,9 +142,11 @@ static inline struct thread_info *curren
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_IRET		(1<<TIF_IRET)
+#define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
+#define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 
-#define _TIF_WORK_MASK		0x0000FFFE	/* work to do on interrupt/exception return */
+#define _TIF_WORK_MASK		0x0000FF7E	/* work to do on interrupt/exception return */
 #define _TIF_ALLWORK_MASK	0x0000FFFF	/* work to do on any return to u-space */
 
 /*
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/include/asm-ppc64/thread_info.h linux-2.6.4/include/asm-ppc64/thread_info.h
--- linux-2.6.4-pristine/include/asm-ppc64/thread_info.h	2004-03-10 21:55:22.000000000 -0500
+++ linux-2.6.4/include/asm-ppc64/thread_info.h	2004-03-11 00:05:53.000000000 -0500
@@ -97,6 +97,7 @@ static inline struct thread_info *curren
 #define TIF_32BIT		5	/* 32 bit binary */
 #define TIF_RUN_LIGHT		6	/* iSeries run light */
 #define TIF_ABI_PENDING		7	/* 32/64 bit switch needed */
+#define TIF_SYSCALL_AUDIT	8	/* syscall auditing active */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -107,6 +108,8 @@ static inline struct thread_info *curren
 #define _TIF_32BIT		(1<<TIF_32BIT)
 #define _TIF_RUN_LIGHT		(1<<TIF_RUN_LIGHT)
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
+#define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
+#define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
 
 #define _TIF_USER_WORK_MASK	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | \
 				 _TIF_NEED_RESCHED)
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/include/asm-x86_64/thread_info.h linux-2.6.4/include/asm-x86_64/thread_info.h
--- linux-2.6.4-pristine/include/asm-x86_64/thread_info.h	2004-03-10 21:55:36.000000000 -0500
+++ linux-2.6.4/include/asm-x86_64/thread_info.h	2004-03-11 00:05:53.000000000 -0500
@@ -102,6 +102,7 @@ static inline struct thread_info *stack_
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
 #define TIF_IRET		5	/* force IRET */
+#define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_IA32		17	/* 32bit process */ 
 #define TIF_FORK		18	/* ret_from_fork */
@@ -113,12 +114,14 @@ static inline struct thread_info *stack_
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_IRET		(1<<TIF_IRET)
+#define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
+#define _TIF_SYSCALL_T_OR_A	(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_IA32		(1<<TIF_IA32)
 #define _TIF_FORK		(1<<TIF_FORK)
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
 
-#define _TIF_WORK_MASK		0x0000FFFE	/* work to do on interrupt/exception return */
+#define _TIF_WORK_MASK		0x0000FF7E	/* work to do on interrupt/exception return */
 #define _TIF_ALLWORK_MASK	0x0000FFFF	/* work to do on any return to u-space */
 
 #define PREEMPT_ACTIVE     0x4000000
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/include/linux/audit.h linux-2.6.4/include/linux/audit.h
--- linux-2.6.4-pristine/include/linux/audit.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.4/include/linux/audit.h	2004-03-11 00:28:13.000000000 -0500
@@ -0,0 +1,202 @@
+/* audit.h -- Auditing support -*- linux-c -*-
+ * 
+ * Copyright 2003-2004 Red Hat Inc., Durham, North Carolina.
+ * All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Written by Rickard E. (Rik) Faith <faith@redhat.com>
+ * 
+ */
+
+#ifndef _LINUX_AUDIT_H_
+#define _LINUX_AUDIT_H_
+
+/* Request and reply types */
+#define AUDIT_GET      1000	/* Get status */
+#define AUDIT_SET      1001	/* Set status (enable/disable/auditd) */
+#define AUDIT_LIST     1002	/* List filtering rules */
+#define AUDIT_ADD      1003	/* Add filtering rule */
+#define AUDIT_DEL      1004	/* Delete filtering rule */
+#define AUDIT_USER     1005	/* Send a message from user-space */
+#define AUDIT_LOGIN    1006     /* Define the login id and informaiton */
+#define AUDIT_KERNEL   2000	/* Asynchronous audit record. NOT A REQUEST. */
+
+/* Rule flags */
+#define AUDIT_PER_TASK 0x01	/* Apply rule at task creation (not syscall) */
+#define AUDIT_AT_ENTRY 0x02	/* Apply rule at syscall entry */
+#define AUDIT_AT_EXIT  0x04	/* Apply rule at syscall exit */
+#define AUDIT_PREPEND  0x10	/* Prepend to front of list */
+
+/* Rule actions */
+#define AUDIT_NEVER    0	/* Do not build context if rule matches */
+#define AUDIT_POSSIBLE 1	/* Build context if rule matches  */
+#define AUDIT_ALWAYS   2	/* Generate audit record if rule matches */
+
+/* Rule structure sizes -- if these change, different AUDIT_ADD and
+ * AUDIT_LIST commands must be implemented. */
+#define AUDIT_MAX_FIELDS   64
+#define AUDIT_BITMASK_SIZE 64
+#define AUDIT_WORD(nr) ((__u32)((nr)/32))
+#define AUDIT_BIT(nr)  (1 << ((nr) - AUDIT_WORD(nr)*32))
+
+/* Rule fields */
+				/* These are useful when checking the
+				 * task structure at task creation time
+				 * (AUDIT_PER_TASK).  */
+#define AUDIT_PID	0
+#define AUDIT_UID	1
+#define AUDIT_EUID	2
+#define AUDIT_SUID	3
+#define AUDIT_FSUID	4
+#define AUDIT_GID	5
+#define AUDIT_EGID	6
+#define AUDIT_SGID	7
+#define AUDIT_FSGID	8
+#define AUDIT_LOGINUID	9
+
+				/* These are ONLY useful when checking
+				 * at syscall exit time (AUDIT_AT_EXIT). */
+#define AUDIT_DEVMAJOR	100
+#define AUDIT_DEVMINOR	101
+#define AUDIT_INODE	102
+#define AUDIT_EXIT	103
+#define AUDIT_NOTEXIT	104
+
+
+/* Status symbols */
+				/* Mask values */
+#define AUDIT_STATUS_ENABLED		0x0001
+#define AUDIT_STATUS_FAILURE		0x0002
+#define AUDIT_STATUS_PID		0x0004
+#define AUDIT_STATUS_RATE_LIMIT		0x0008
+#define AUDIT_STATUS_BACKLOG_LIMIT	0x0010
+				/* Failure-to-log actions */
+#define AUDIT_FAIL_SILENT	0
+#define AUDIT_FAIL_PRINTK	1
+#define AUDIT_FAIL_PANIC	2
+
+#ifndef __KERNEL__
+struct audit_message {
+	struct nlmsghdr nlh;
+	char		data[1200];
+};
+#endif
+
+struct audit_status {
+	__u32		mask;		/* Bit mask for valid entries */
+	__u32		enabled;	/* 1 = enabled, 0 = disbaled */
+	__u32		failure;	/* Failure-to-log action */
+	__u32		pid;		/* pid of auditd process */
+	__u32		rate_limit;	/* messages rate limit (per second) */
+	__u32		backlog_limit;	/* waiting messages limit */
+	__u32		lost;		/* messages lost */
+	__u32		backlog;	/* messages waiting in queue */
+};
+
+struct audit_login {
+	__u32		loginuid;
+	int		msglen;
+	char		msg[1024];
+};
+
+struct audit_rule {		/* for AUDIT_LIST, AUDIT_ADD, and AUDIT_DEL */
+	__u32		flags;	/* AUDIT_PER_{TASK,CALL}, AUDIT_PREPEND */
+	__u32		action;	/* AUDIT_NEVER, AUDIT_POSSIBLE, AUDIT_ALWAYS */
+	__u32		field_count;
+	__u32		mask[AUDIT_BITMASK_SIZE];
+	__u32		fields[AUDIT_MAX_FIELDS];
+	__u32		values[AUDIT_MAX_FIELDS];
+};
+
+#ifdef __KERNEL__
+
+#ifdef CONFIG_AUDIT
+struct audit_buffer;
+struct audit_context;
+#endif
+
+#ifdef CONFIG_AUDITSYSCALL
+/* These are defined in auditsc.c */
+				/* Public API */
+extern int  audit_alloc(struct task_struct *task);
+extern void audit_free(struct task_struct *task);
+extern void audit_syscall_entry(struct task_struct *task,
+				int major, int minor);
+extern void audit_syscall_exit(struct task_struct *task);
+extern void audit_getname(const char *name);
+extern void audit_putname(const char *name);
+extern void audit_inode(const char *name, unsigned long ino, dev_t rdev);
+
+				/* Private API (for audit.c only) */
+extern int  audit_receive_filter(int type, int pid, int uid, int seq,
+				 void *data);
+extern void audit_get_stamp(struct audit_context *ctx,
+			    struct timespec *t, int *serial);
+extern int  audit_set_loginuid(struct audit_context *ctx, uid_t loginuid);
+#else
+#define audit_alloc(t) ({ 0; })
+#define audit_free(t) do { ; } while (0)
+#define audit_syscall_entry(t,a,b) do { ; } while (0)
+#define audit_syscall_exit(t) do { ; } while (0)
+#define audit_getname(n) do { ; } while (0)
+#define audit_putname(n) do { ; } while (0)
+#define audit_inode(n,i,d) do { ; } while (0)
+#endif
+
+#ifdef CONFIG_AUDIT
+/* These are defined in audit.c */
+				/* Public API */
+extern void		    audit_log(struct audit_context *ctx,
+				      const char *fmt, ...)
+			    __attribute__((format(printf,2,3)));
+
+extern struct audit_buffer *audit_log_start(struct audit_context *ctx);
+extern void		    audit_log_format(struct audit_buffer *ab,
+					     const char *fmt, ...)
+			    __attribute__((format(printf,2,3)));
+extern void		    audit_log_end(struct audit_buffer *ab);
+extern void		    audit_log_end_fast(struct audit_buffer *ab);
+extern void		    audit_log_end_irq(struct audit_buffer *ab);
+extern void		    audit_log_d_path(struct audit_buffer *ab,
+					     const char *prefix,
+					     struct dentry *dentry,
+					     struct vfsmount *vfsmnt);
+extern int		    audit_set_rate_limit(int limit);
+extern int		    audit_set_backlog_limit(int limit);
+extern int		    audit_set_enabled(int state);
+extern int		    audit_set_failure(int state);
+
+				/* Private API (for auditsc.c only) */
+extern void		    audit_send_reply(int pid, int seq, int type,
+					     int done, int multi,
+					     void *payload, int size);
+extern void		    audit_log_lost(const char *message);
+#else
+#define audit_log(t,f,...) do { ; } while (0)
+#define audit_log_start(t) ({ NULL; })
+#define audit_log_vformat(b,f,a) do { ; } while (0)
+#define audit_log_format(b,f,...) do { ; } while (0)
+#define audit_log_end(b) do { ; } while (0)
+#define audit_log_end_fast(b) do { ; } while (0)
+#define audit_log_end_irq(b) do { ; } while (0)
+#define audit_log_d_path(b,p,d,v) do { ; } while (0)
+#define audit_set_rate_limit(l) do { ; } while (0)
+#define audit_set_backlog_limit(l) do { ; } while (0)
+#define audit_set_enabled(s) do { ; } while (0)
+#define audit_set_failure(s) do { ; } while (0)
+#endif
+#endif
+#endif
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/include/linux/fs.h linux-2.6.4/include/linux/fs.h
--- linux-2.6.4-pristine/include/linux/fs.h	2004-03-10 21:55:24.000000000 -0500
+++ linux-2.6.4/include/linux/fs.h	2004-03-11 00:45:56.000000000 -0500
@@ -20,6 +20,7 @@
 #include <linux/radix-tree.h>
 #include <linux/kobject.h>
 #include <asm/atomic.h>
+#include <linux/audit.h>
 
 struct iovec;
 struct nameidata;
@@ -1128,7 +1129,18 @@ extern char * getname(const char __user 
 extern void vfs_caches_init(unsigned long);
 
 #define __getname()	kmem_cache_alloc(names_cachep, SLAB_KERNEL)
-#define putname(name)	kmem_cache_free(names_cachep, (void *)(name))
+#define __putname(name) kmem_cache_free(names_cachep, (void *)(name))
+#ifndef CONFIG_AUDITSYSCALL
+#define putname(name)   __putname(name)
+#else
+#define putname(name)							\
+	do {								\
+		if (unlikely(current->audit_context))			\
+			audit_putname(name);				\
+		else							\
+			__putname(name);				\
+	} while (0)
+#endif
 
 extern int register_blkdev(unsigned int, const char *);
 extern int unregister_blkdev(unsigned int, const char *);
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/include/linux/netlink.h linux-2.6.4/include/linux/netlink.h
--- linux-2.6.4-pristine/include/linux/netlink.h	2004-03-10 21:55:43.000000000 -0500
+++ linux-2.6.4/include/linux/netlink.h	2004-03-11 00:05:53.000000000 -0500
@@ -13,6 +13,7 @@
 #define NETLINK_XFRM		6	/* ipsec */
 #define NETLINK_SELINUX		7	/* SELinux event notifications */
 #define NETLINK_ARPD		8
+#define NETLINK_AUDIT		9	/* auditing */
 #define NETLINK_ROUTE6		11	/* af_inet6 route comm channel */
 #define NETLINK_IP6_FW		13
 #define NETLINK_DNRTMSG		14	/* DECnet routing messages */
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/include/linux/sched.h linux-2.6.4/include/linux/sched.h
--- linux-2.6.4-pristine/include/linux/sched.h	2004-03-10 21:55:22.000000000 -0500
+++ linux-2.6.4/include/linux/sched.h	2004-03-11 00:45:56.000000000 -0500
@@ -358,6 +358,8 @@ int set_current_groups(struct group_info
     ((gi)->blocks[(i)/NGROUPS_PER_BLOCK][(i)%NGROUPS_PER_BLOCK])
 
 
+struct audit_context;		/* See audit.c */
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
@@ -467,7 +469,8 @@ struct task_struct {
 	sigset_t *notifier_mask;
 	
 	void *security;
-
+	struct audit_context *audit_context;
+	
 /* Thread group tracking */
    	u32 parent_exec_id;
    	u32 self_exec_id;
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/init/Kconfig linux-2.6.4/init/Kconfig
--- linux-2.6.4-pristine/init/Kconfig	2004-03-10 21:55:43.000000000 -0500
+++ linux-2.6.4/init/Kconfig	2004-03-11 00:05:53.000000000 -0500
@@ -120,6 +120,26 @@ config SYSCTL
 	  building a kernel for install/rescue disks or your system is very
 	  limited in memory.
 
+config AUDIT
+	bool "Auditing support"
+	default y if SECURITY_SELINUX
+	default n
+	help
+	  Enable auditing infrastructure that can be used with another
+	  kernel subsystem, such as SELinux (which requires this for
+	  logging of avc messages output).  Does not do system-call
+	  auditing without CONFIG_AUDITSYSCALL.
+
+config AUDITSYSCALL
+	bool "Enable system-call auditing support"
+	depends on AUDIT && (X86 || PPC64)
+	default y if SECURITY_SELINUX
+	default n
+	help
+	  Enable low-overhead system-call auditing infrastructure that
+	  can be used independently or with another kernel subsystem,
+	  such as SELinux.
+
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
 	range 12 20
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/kernel/audit.c linux-2.6.4/kernel/audit.c
--- linux-2.6.4-pristine/kernel/audit.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.4/kernel/audit.c	2004-03-11 00:28:14.000000000 -0500
@@ -0,0 +1,813 @@
+/* audit.c -- Auditing support -*- linux-c -*-
+ * Gateway between the kernel (e.g., selinux) and the user-space audit daemon.
+ * System-call specific features have moved to auditsc.c
+ * 
+ * Copyright 2003-2004 Red Hat Inc., Durham, North Carolina.
+ * All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Written by Rickard E. (Rik) Faith <faith@redhat.com>
+ *
+ * Goals: 1) Integrate fully with SELinux.
+ *	  2) Minimal run-time overhead:
+ *	     a) Minimal when syscall auditing is disabled (audit_enable=0).
+ *	     b) Small when syscall auditing is enabled and no audit record
+ *		is generated (defer as much work as possible to record
+ *		generation time):
+ *		i) context is allocated,
+ *		ii) names from getname are stored without a copy, and
+ *		iii) inode information stored from path_lookup.
+ *	  3) Ability to disable syscall auditing at boot time (audit=0).
+ *	  4) Usable by other parts of the kernel (if audit_log* is called,
+ *	     then a syscall record will be generated automatically for the
+ *	     current syscall).
+ *	  5) Netlink interface to user-space.
+ *	  6) Support low-overhead kernel-based filtering to minimize the
+ *	     information that must be passed to user-space.
+ *
+ * Example user-space utilities: http://people.redhat.com/faith/audit/
+ */
+
+#include <linux/init.h>
+#include <asm/atomic.h>
+#include <asm/types.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+
+#include <linux/audit.h>
+
+#include <net/sock.h>
+#include <linux/skbuff.h>
+#include <linux/netlink.h>
+
+/* No auditing will take place until audit_initialized != 0.
+ * (Initialization happens after skb_init is called.) */
+static int	audit_initialized;
+
+/* No syscall auditing will take place unless audit_enabled != 0. */
+int		audit_enabled;
+
+/* Default state when kernel boots without any parameters. */
+static int	audit_default;
+
+/* If auditing cannot proceed, audit_failure selects what happens. */
+static int	audit_failure = AUDIT_FAIL_PRINTK;
+
+/* If audit records are to be written to the netlink socket, audit_pid
+ * contains the (non-zero) pid. */
+static int	audit_pid;
+
+/* If audit_limit is non-zero, limit the rate of sending audit records
+ * to that number per second.  This prevents DoS attacks, but results in
+ * audit records being dropped. */
+static int	audit_rate_limit;
+
+/* Number of outstanding audit_buffers allowed. */
+static int	audit_backlog_limit = 64;
+static atomic_t	audit_backlog	    = ATOMIC_INIT(0);
+
+/* Records can be lost in several ways:
+   0) [suppressed in audit_alloc]
+   1) out of memory in audit_log_start [kmalloc of struct audit_buffer]
+   2) out of memory in audit_log_move [alloc_skb]
+   3) suppressed due to audit_rate_limit
+   4) suppressed due to audit_backlog_limit
+*/
+static atomic_t    audit_lost = ATOMIC_INIT(0);
+
+/* The netlink socket. */
+static struct sock *audit_sock;
+
+/* There are two lists of audit buffers.  The txlist contains audit
+ * buffers that cannot be sent immediately to the netlink device because
+ * we are in an irq context (these are sent later in a tasklet).
+ *
+ * The second list is a list of pre-allocated audit buffers (if more
+ * than AUDIT_MAXFREE are in use, the audit buffer is freed instead of
+ * being placed on the freelist). */
+static spinlock_t  audit_txlist_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t  audit_freelist_lock = SPIN_LOCK_UNLOCKED;
+static int	   audit_freelist_count = 0;
+static LIST_HEAD(audit_txlist);
+static LIST_HEAD(audit_freelist);
+
+/* There are three lists of rules -- one to search at task creation
+ * time, one to search at syscall entry time, and another to search at
+ * syscall exit time. */
+static LIST_HEAD(audit_tsklist);
+static LIST_HEAD(audit_entlist);
+static LIST_HEAD(audit_extlist);
+
+/* AUDIT_BUFSIZ is the size of the temporary buffer used for formatting
+ * audit records.  Since printk uses a 1024 byte buffer, this buffer
+ * should be at least that large. */
+#define AUDIT_BUFSIZ 1024
+
+/* AUDIT_MAXFREE is the number of empty audit_buffers we keep on the
+ * audit_freelist.  Doing so eliminates many kmalloc/kfree calls. */
+#define AUDIT_MAXFREE  (2*NR_CPUS)
+
+/* The audit_buffer is used when formatting an audit record.  The caller
+ * locks briefly to get the record off the freelist or to allocate the
+ * buffer, and locks briefly to send the buffer to the netlink layer or
+ * to place it on a transmit queue.  Multiple audit_buffers can be in
+ * use simultaneously. */
+struct audit_buffer {
+	struct list_head     list;
+	struct sk_buff_head  sklist;	/* formatted skbs ready to send */
+	struct audit_context *ctx;	/* NULL or associated context */
+	int		     len;	/* used area of tmp */
+	char		     tmp[AUDIT_BUFSIZ];
+
+				/* Pointer to header and contents */
+	struct nlmsghdr      *nlh;
+	int		     total;
+	int		     type;
+	int		     pid;
+	int		     count; /* Times requeued */
+};
+
+struct audit_entry {
+	struct list_head  list;
+	struct audit_rule rule;
+};
+
+static void audit_panic(const char *message)
+{
+	switch (audit_failure)
+	{
+	case AUDIT_FAIL_SILENT:
+		break;
+	case AUDIT_FAIL_PRINTK:
+		printk(KERN_ERR "audit: %s\n", message);
+		break;
+	case AUDIT_FAIL_PANIC:
+		panic(message);
+		break;
+	}
+}
+
+static inline int audit_rate_check(void)
+{
+	static unsigned long	last_check = 0;
+	static int		messages   = 0;
+	static spinlock_t	lock	   = SPIN_LOCK_UNLOCKED;
+	unsigned long		flags;
+	unsigned long		now;
+	unsigned long		elapsed;
+	int			retval	   = 0;
+	
+	if (!audit_rate_limit) return 1;
+
+	spin_lock_irqsave(&lock, flags);
+	if (++messages < audit_rate_limit) {
+		retval = 1;
+	} else {
+		now     = jiffies;
+		elapsed = now - last_check;
+		if (elapsed > HZ) {
+			last_check = now;
+			messages   = 0;
+			retval     = 1;
+		}
+	}
+	spin_unlock_irqrestore(&lock, flags);
+
+	return retval;
+}
+
+/* Emit at least 1 message per second, even if audit_rate_check is
+ * throttling. */
+void audit_log_lost(const char *message)
+{
+	static unsigned long	last_msg = 0;
+	static spinlock_t	lock     = SPIN_LOCK_UNLOCKED;
+	unsigned long		flags;
+	unsigned long		now;
+	int			print;
+
+	atomic_inc(&audit_lost);
+
+	print = (audit_failure == AUDIT_FAIL_PANIC || !audit_rate_limit);
+
+	if (!print) {
+		spin_lock_irqsave(&lock, flags);
+		now = jiffies;
+		if (now - last_msg > HZ) {
+			print = 1;
+			last_msg = now;
+		}
+		spin_unlock_irqrestore(&lock, flags);
+	}
+
+	if (print) {
+		printk(KERN_WARNING
+		       "audit: audit_lost=%d audit_backlog=%d"
+		       " audit_rate_limit=%d audit_backlog_limit=%d\n",
+		       atomic_read(&audit_lost),
+		       atomic_read(&audit_backlog),
+		       audit_rate_limit,
+		       audit_backlog_limit);
+		audit_panic(message);
+	}
+	
+}
+
+int audit_set_rate_limit(int limit)
+{
+	int old		 = audit_rate_limit;
+	audit_rate_limit = limit;
+	audit_log(current->audit_context, "audit_rate_limit=%d old=%d",
+		  audit_rate_limit, old);
+	return old;
+}
+
+int audit_set_backlog_limit(int limit)
+{
+	int old		 = audit_backlog_limit;
+	audit_backlog_limit = limit;
+	audit_log(current->audit_context, "audit_backlog_limit=%d old=%d",
+		  audit_backlog_limit, old);
+	return old;
+}
+
+int audit_set_enabled(int state)
+{
+	int old		 = audit_enabled;
+	if (state != 0 && state != 1)
+		return -EINVAL;
+	audit_enabled = state;
+	audit_log(current->audit_context, "audit_enabled=%d old=%d",
+		  audit_enabled, old);
+	return old;
+}
+
+int audit_set_failure(int state)
+{
+	int old		 = audit_failure;
+	if (state != AUDIT_FAIL_SILENT
+	    && state != AUDIT_FAIL_PRINTK
+	    && state != AUDIT_FAIL_PANIC)
+		return -EINVAL;
+	audit_failure = state;
+	audit_log(current->audit_context, "audit_failure=%d old=%d",
+		  audit_failure, old);
+	return old;
+}
+
+#ifdef CONFIG_NET
+void audit_send_reply(int pid, int seq, int type, int done, int multi,
+		      void *payload, int size)
+{
+	struct sk_buff	*skb;
+	struct nlmsghdr	*nlh;
+	int		len = NLMSG_SPACE(size);
+	void		*data;
+	int		flags = multi ? NLM_F_MULTI : 0;
+	int		t     = done  ? NLMSG_DONE  : type;
+
+	skb = alloc_skb(len, GFP_KERNEL);
+	if (!skb)
+		goto nlmsg_failure;
+
+	nlh		 = NLMSG_PUT(skb, pid, seq, t, len - sizeof(*nlh));
+	nlh->nlmsg_flags = flags;
+	data		 = NLMSG_DATA(nlh);
+	memcpy(data, payload, size);
+	netlink_unicast(audit_sock, skb, pid, MSG_DONTWAIT);
+	return;
+
+nlmsg_failure:			/* Used by NLMSG_PUT */
+	if (skb)
+		kfree_skb(skb);
+}
+
+static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
+{
+	u32			uid, pid, seq;
+	void			*data;
+	struct audit_status	*status_get, status_set;
+	struct audit_login	*login;
+	int			err = 0;
+	struct audit_buffer	*ab;
+	
+	pid  = NETLINK_CREDS(skb)->pid;
+	uid  = NETLINK_CREDS(skb)->uid;
+	seq  = nlh->nlmsg_seq;
+	data = NLMSG_DATA(nlh);
+
+	switch (nlh->nlmsg_type) {
+	case AUDIT_GET:
+		status_set.enabled	 = audit_enabled;
+		status_set.failure	 = audit_failure;
+		status_set.pid		 = audit_pid;
+		status_set.rate_limit	 = audit_rate_limit;
+		status_set.backlog_limit = audit_backlog_limit;
+		status_set.lost		 = atomic_read(&audit_lost);
+		status_set.backlog	 = atomic_read(&audit_backlog);
+		audit_send_reply(pid, seq, AUDIT_GET, 0, 0,
+				 &status_set, sizeof(status_set));
+		break;
+	case AUDIT_SET:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		status_get   = (struct audit_status *)data;
+		if (status_get->mask & AUDIT_STATUS_ENABLED) {
+			err = audit_set_enabled(status_get->enabled);
+			if (err < 0) return err;
+		}
+		if (status_get->mask & AUDIT_STATUS_FAILURE) {
+			err = audit_set_failure(status_get->failure);
+			if (err < 0) return err;
+		}
+		if (status_get->mask & AUDIT_STATUS_PID) {
+			int old   = audit_pid;
+			audit_pid = status_get->pid;
+			audit_log(current->audit_context,
+				  "audit_pid=%d old=%d", audit_pid, old);
+		}
+		if (status_get->mask & AUDIT_STATUS_RATE_LIMIT)
+			audit_set_rate_limit(status_get->rate_limit);
+		if (status_get->mask & AUDIT_STATUS_BACKLOG_LIMIT)
+			audit_set_backlog_limit(status_get->backlog_limit);
+		break;
+	case AUDIT_USER:
+		ab = audit_log_start(NULL);
+		if (!ab)
+			break;	/* audit_panic has been called */
+		audit_log_format(ab,
+				 "user pid=%d uid=%d length=%d msg='%.1024s'",
+				 pid, uid,
+				 (int)(nlh->nlmsg_len
+				       - ((char *)data - (char *)nlh)),
+				 (char *)data);
+		ab->type = AUDIT_USER;
+		ab->pid  = pid;
+		audit_log_end(ab);
+		break;
+	case AUDIT_LOGIN:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		login = (struct audit_login *)data;
+		ab = audit_log_start(NULL);
+		if (ab) {
+			audit_log_format(ab, "login pid=%d uid=%d loginuid=%d"
+					 " length=%d msg='%.1024s'",
+					 pid, uid,
+					 login->loginuid,
+					 login->msglen,
+					 login->msg);
+			ab->type = AUDIT_LOGIN;
+			ab->pid  = pid;
+			audit_log_end(ab);
+		}
+#ifdef CONFIG_AUDITSYSCALL
+		err = audit_set_loginuid(current->audit_context,
+					 login->loginuid);
+#endif
+		break;
+	case AUDIT_LIST:
+	case AUDIT_ADD:
+	case AUDIT_DEL:
+#ifdef CONFIG_AUDITSYSCALL
+		err = audit_receive_filter(nlh->nlmsg_type, pid, uid, seq,
+					   data);
+#else
+		err = -EOPNOTSUPP;
+#endif
+		break;
+	default:
+		err = -EINVAL;
+		break;
+	}
+
+	return err < 0 ? err : 0;
+}
+
+/* Get message from skb (based on rtnetlink_rcv_skb).  Each message is
+ * processed by audit_receive_msg.  Malformed skbs with wrong length are
+ * discarded silently.  */
+static int audit_receive_skb(struct sk_buff *skb)
+{
+	int		err;
+	struct nlmsghdr	*nlh;
+	u32		rlen;
+
+	while (skb->len >= NLMSG_SPACE(0)) {
+		nlh = (struct nlmsghdr *)skb->data;
+		if (nlh->nlmsg_len < sizeof(*nlh) || skb->len < nlh->nlmsg_len)
+			return 0;
+		rlen = NLMSG_ALIGN(nlh->nlmsg_len);
+		if (rlen > skb->len)
+			rlen = skb->len;
+		if ((err = audit_receive_msg(skb, nlh))) {
+			netlink_ack(skb, nlh, -err);
+		} else if (nlh->nlmsg_flags & NLM_F_ACK)
+			netlink_ack(skb, nlh, 0);
+		skb_pull(skb, rlen);
+	}
+	return 0;
+}
+
+/* Receive messages from netlink socket. */
+static void audit_receive(struct sock *sk, int length)
+{
+	struct sk_buff  *skb;
+
+				/* FIXME: this must not cause starvation */
+	while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
+		if (audit_receive_skb(skb) && skb->len)
+			skb_queue_head(&sk->sk_receive_queue, skb);
+		else
+			kfree_skb(skb);
+	}
+}
+
+/* Move data from tmp buffer into an skb.  This is an extra copy, and
+ * that is unfortunate.  However, the copy will only occur when a record
+ * is being written to user space, which is already a high-overhead
+ * operation.  (Elimination of the copy is possible, for example, by
+ * writing directly into a pre-allocated skb, at the cost of wasting
+ * memory. */ 
+static void audit_log_move(struct audit_buffer *ab)
+{
+	struct sk_buff	*skb;
+	char		*start;
+	int		extra = ab->nlh ? 0 : NLMSG_SPACE(0);
+
+	skb = skb_peek(&ab->sklist);
+	if (!skb || skb_tailroom(skb) <= ab->len + extra) {
+		skb = alloc_skb(2 * ab->len + extra, GFP_ATOMIC);
+		if (!skb) {
+			ab->len = 0; /* Lose information in ab->tmp */
+			audit_log_lost("out of memory in audit_log_move");
+			return;
+		}
+		__skb_queue_tail(&ab->sklist, skb);
+		if (!ab->nlh)
+			ab->nlh = (struct nlmsghdr *)skb_put(skb,
+							     NLMSG_SPACE(0));
+	}
+	start = skb_put(skb, ab->len);
+	memcpy(start, ab->tmp, ab->len);
+	ab->len = 0;
+}
+
+/* Iterate over the skbuff in the audit_buffer, sending their contents
+ * to user space. */
+static inline void audit_log_drain(struct audit_buffer *ab)
+{
+	struct sk_buff *skb;
+	
+	while ((skb = skb_dequeue(&ab->sklist))) {
+		int retval = 0;
+
+		if (audit_pid) {
+			if (ab->nlh) {
+				ab->nlh->nlmsg_len   = ab->total;
+				ab->nlh->nlmsg_type  = ab->type;
+				ab->nlh->nlmsg_flags = 0;
+				ab->nlh->nlmsg_seq   = 0;
+				ab->nlh->nlmsg_pid   = ab->pid;
+			}
+			skb_get(skb); /* because netlink_* frees */
+			retval = netlink_unicast(audit_sock, skb, audit_pid,
+						 MSG_DONTWAIT);
+		}
+		if (retval == -EAGAIN && ab->count < 5) {
+			++ab->count;
+			audit_log_end_irq(ab);
+			return;
+		}
+		if (retval < 0) {
+			if (retval == -ECONNREFUSED) {
+				printk(KERN_ERR
+				       "audit: *NO* daemon at audit_pid=%d\n",
+				       audit_pid);
+				audit_pid = 0;
+			} else
+				audit_log_lost("netlink socket too busy");
+		}
+		if (!audit_pid) { /* No daemon */
+			int offset = ab->nlh ? NLMSG_SPACE(0) : 0;
+			int len    = skb->len - offset;
+			printk(KERN_ERR "%*.*s\n",
+			       len, len, skb->data + offset);
+		}
+		kfree_skb(skb);
+		ab->nlh = NULL;
+	}
+}
+
+/* Initialize audit support at boot time. */
+int __init audit_init(void)
+{
+	printk(KERN_INFO "audit: initializing netlink socket (%s)\n",
+	       audit_default ? "enabled" : "disabled");
+	audit_sock = netlink_kernel_create(NETLINK_AUDIT, audit_receive);
+	if (!audit_sock)
+		audit_panic("cannot initialize netlink socket");
+
+	audit_initialized = 1;
+	audit_enabled = audit_default;
+	audit_log(NULL, "initialized");
+	return 0;
+}
+
+#else
+/* Without CONFIG_NET, we have no skbuffs.  For now, print what we have
+ * in the buffer. */
+static void audit_log_move(struct audit_buffer *ab)
+{
+	printk(KERN_ERR "%*.*s\n", ab->len, ab->len, ab->tmp);
+	ab->len = 0;
+}
+
+static inline void audit_log_drain(struct audit_buffer *ab)
+{
+}
+
+/* Initialize audit support at boot time. */
+int __init audit_init(void)
+{
+	printk(KERN_INFO "audit: initializing WITHOUT netlink support\n");
+	audit_sock = NULL;
+	audit_pid  = 0;
+
+	audit_initialized = 1;
+	audit_enabled = audit_default;
+	audit_log(NULL, "initialized");
+	return 0;
+}
+#endif
+
+__initcall(audit_init);
+
+/* Process kernel command-line parameter at boot time.  audit=0 or audit=1. */
+static int __init audit_enable(char *str)
+{
+	audit_default = !!simple_strtol(str, NULL, 0);
+	printk(KERN_INFO "audit: %s%s\n",
+	       audit_default ? "enabled" : "disabled",
+	       audit_initialized ? "" : " (after initialization)");
+	if (audit_initialized)
+		audit_enabled = audit_default;
+	return 0;
+}
+
+__setup("audit=", audit_enable);
+
+
+/* Obtain an audit buffer.  This routine does locking to obtain the
+ * audit buffer, but then no locking is required for calls to
+ * audit_log_*format.  If the tsk is a task that is currently in a
+ * syscall, then the syscall is marked as auditable and an audit record
+ * will be written at syscall exit.  If there is no associated task, tsk
+ * should be NULL. */
+struct audit_buffer *audit_log_start(struct audit_context *ctx)
+{
+	struct audit_buffer	*ab	= NULL;
+	unsigned long		flags;
+	struct timespec		t;
+	int			serial	= 0;
+
+	if (!audit_initialized)
+		return NULL;
+
+	if (audit_backlog_limit
+	    && atomic_read(&audit_backlog) > audit_backlog_limit) {
+		if (audit_rate_check())
+			printk(KERN_WARNING
+			       "audit: audit_backlog=%d > "
+			       "audit_backlog_limit=%d\n",
+			       atomic_read(&audit_backlog),
+			       audit_backlog_limit);
+		audit_log_lost("backlog limit exceeded");
+		return NULL;
+	}
+
+	spin_lock_irqsave(&audit_freelist_lock, flags);
+	if (!list_empty(&audit_freelist)) {
+		ab = list_entry(audit_freelist.next,
+				struct audit_buffer, list);
+		list_del(&ab->list);
+		--audit_freelist_count;
+	}
+	spin_unlock_irqrestore(&audit_freelist_lock, flags);
+	
+	if (!ab)
+		ab = kmalloc(sizeof(*ab), GFP_ATOMIC);
+	if (!ab)
+		audit_log_lost("audit: out of memory in audit_log_start");
+	if (!ab)
+		return NULL;
+
+	atomic_inc(&audit_backlog);
+	skb_queue_head_init(&ab->sklist);
+
+	ab->ctx   = ctx;
+	ab->len   = 0;
+	ab->nlh   = NULL;
+	ab->total = 0;
+	ab->type  = AUDIT_KERNEL;
+	ab->pid   = 0;
+	ab->count = 0;
+
+#ifdef CONFIG_AUDITSYSCALL
+	if (ab->ctx)
+		audit_get_stamp(ab->ctx, &t, &serial);
+	else
+#endif
+		t = CURRENT_TIME;
+
+	audit_log_format(ab, "audit(%lu.%03lu:%u): ",
+			 t.tv_sec, t.tv_nsec/1000000, serial);
+	return ab;
+}
+
+
+/* Format an audit message into the audit buffer.  If there isn't enough
+ * room in the audit buffer, more room will be allocated and vsnprint
+ * will be called a second time.  Currently, we assume that a printk
+ * can't format message larger than 1024 bytes, so we don't either. */ 
+static void audit_log_vformat(struct audit_buffer *ab, const char *fmt,
+			      va_list args)
+{
+	int len, avail;
+
+	if (!ab)
+		return;
+
+	avail = sizeof(ab->tmp) - ab->len;
+	if (avail <= 0) {
+		audit_log_move(ab);
+		avail = sizeof(ab->tmp) - ab->len;
+	}
+	len   = vsnprintf(ab->tmp + ab->len, avail, fmt, args);
+	if (len >= avail) {
+		/* The printk buffer is 1024 bytes long, so if we get
+		 * here and AUDIT_BUFSIZ is at least 1024, then we can
+		 * log everything that printk could have logged. */
+		audit_log_move(ab);
+		avail = sizeof(ab->tmp) - ab->len;
+		len   = vsnprintf(ab->tmp + ab->len, avail, fmt, args);
+	}
+	ab->len   += (len < avail) ? len : avail;
+	ab->total += (len < avail) ? len : avail;
+}
+
+/* Format a message into the audit buffer.  All the work is done in
+ * audit_log_vformat. */
+void audit_log_format(struct audit_buffer *ab, const char *fmt, ...)
+{
+	va_list args;
+
+	if (!ab)
+		return;
+	va_start(args, fmt);
+	audit_log_vformat(ab, fmt, args);
+	va_end(args);
+}
+
+/* This is a helper-function to print the d_path without using a static
+ * buffer or allocating another buffer in addition to the one in
+ * audit_buffer. */
+void audit_log_d_path(struct audit_buffer *ab, const char *prefix,
+		      struct dentry *dentry, struct vfsmount *vfsmnt)
+{
+	char *p;
+	int  len, avail;
+	
+	if (prefix) audit_log_format(ab, " %s", prefix);
+
+	if (ab->len > 128)
+		audit_log_move(ab);
+	avail = sizeof(ab->tmp) - ab->len;
+	p = d_path(dentry, vfsmnt, ab->tmp + ab->len, avail);
+	if (p == ERR_PTR(-ENAMETOOLONG)) {
+		/* FIXME: can we save some information here? */
+		audit_log_format(ab, "<toolong>");
+	} else {
+				/* path isn't at start of buffer */
+		len	   = (ab->tmp + sizeof(ab->tmp) - 1) - p;
+		memmove(ab->tmp + ab->len, p, len);
+		ab->len   += len;
+		ab->total += len;
+	}
+}
+
+/* Remove queued messages from the audit_txlist and send them to userspace. */
+static void audit_tasklet_handler(unsigned long arg)
+{
+	LIST_HEAD(list);
+	struct audit_buffer *ab;
+	unsigned long	    flags;
+
+	spin_lock_irqsave(&audit_txlist_lock, flags);
+	list_splice_init(&audit_txlist, &list);
+	spin_unlock_irqrestore(&audit_txlist_lock, flags);
+	
+	while (!list_empty(&list)) {
+		ab = list_entry(list.next, struct audit_buffer, list);
+		list_del(&ab->list);
+		audit_log_end_fast(ab);
+	}
+}
+
+static DECLARE_TASKLET(audit_tasklet, audit_tasklet_handler, 0);
+
+/* The netlink_* functions cannot be called inside an irq context, so
+ * the audit buffer is places on a queue and a tasklet is scheduled to
+ * remove them from the queue outside the irq context.  May be called in
+ * any context. */
+void audit_log_end_irq(struct audit_buffer *ab)
+{
+	unsigned long flags;
+
+	if (!ab)
+		return;
+	spin_lock_irqsave(&audit_txlist_lock, flags);
+	list_add_tail(&ab->list, &audit_txlist);
+	spin_unlock_irqrestore(&audit_txlist_lock, flags);
+
+	tasklet_schedule(&audit_tasklet);
+}
+
+/* Send the message in the audit buffer directly to user space.  May not
+ * be called in an irq context. */
+void audit_log_end_fast(struct audit_buffer *ab)
+{
+	unsigned long flags;
+
+	BUG_ON(in_irq());
+	if (!ab)
+		return;
+	if (!audit_rate_check()) {
+		audit_log_lost("rate limit exceeded");
+	} else {
+		audit_log_move(ab);
+		audit_log_drain(ab);
+	}
+
+	atomic_dec(&audit_backlog);
+	spin_lock_irqsave(&audit_freelist_lock, flags);
+	if (++audit_freelist_count > AUDIT_MAXFREE)
+		kfree(ab);
+	else
+		list_add(&ab->list, &audit_freelist);
+	spin_unlock_irqrestore(&audit_freelist_lock, flags);
+}
+
+/* Send or queue the message in the audit buffer, depending on the
+ * current context.  (A convenience function that may be called in any
+ * context.) */
+void audit_log_end(struct audit_buffer *ab)
+{
+	if (in_irq())
+		audit_log_end_irq(ab);
+	else
+		audit_log_end_fast(ab);
+}
+
+/* Log an audit record.  This is a convenience function that calls
+ * audit_log_start, audit_log_vformat, and audit_log_end.  It may be
+ * called in any context. */
+void audit_log(struct audit_context *ctx, const char *fmt, ...)
+{
+	struct audit_buffer *ab;
+	va_list args;
+
+	ab = audit_log_start(ctx);
+	if (ab) {
+		va_start(args, fmt);
+		audit_log_vformat(ab, fmt, args);
+		va_end(args);
+		audit_log_end(ab);
+	}
+}
+
+EXPORT_SYMBOL_GPL(audit_set_rate_limit);
+EXPORT_SYMBOL_GPL(audit_set_backlog_limit);
+EXPORT_SYMBOL_GPL(audit_set_enabled);
+EXPORT_SYMBOL_GPL(audit_set_failure);
+
+EXPORT_SYMBOL_GPL(audit_log_start);
+EXPORT_SYMBOL_GPL(audit_log_format);
+EXPORT_SYMBOL_GPL(audit_log_end_irq);
+EXPORT_SYMBOL_GPL(audit_log_end_fast);
+EXPORT_SYMBOL_GPL(audit_log_end);
+EXPORT_SYMBOL_GPL(audit_log);
+EXPORT_SYMBOL_GPL(audit_log_d_path);
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/kernel/auditsc.c linux-2.6.4/kernel/auditsc.c
--- linux-2.6.4-pristine/kernel/auditsc.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.4/kernel/auditsc.c	2004-03-11 00:28:13.000000000 -0500
@@ -0,0 +1,869 @@
+/* auditsc.c -- System-call auditing support -*- linux-c -*-
+ * Handles all system-call specific auditing features.
+ * 
+ * Copyright 2003-2004 Red Hat Inc., Durham, North Carolina.
+ * All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Written by Rickard E. (Rik) Faith <faith@redhat.com>
+ * 
+ * Many of the ideas implemented here are from Stephen C. Tweedie,
+ * especially the idea of avoiding a copy by using getname.
+ *
+ * The method for actual interception of syscall entry and exit (not in
+ * this file -- see entry.S) is based on a GPL'd patch written by
+ * okir@suse.de and Copyright 2003 SuSE Linux AG.
+ *
+ */
+
+#include <linux/init.h>
+#include <asm/atomic.h>
+#include <asm/types.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+
+#include <linux/audit.h>
+#include <linux/time.h>
+#include <asm/unistd.h>
+
+/* 0 = no checking
+   1 = put_count checking
+   2 = verbose put_count checking
+*/
+#define AUDIT_DEBUG 0
+
+/* No syscall auditing will take place unless audit_enabled != 0. */
+extern int audit_enabled;
+
+/* AUDIT_NAMES is the number of slots we reserve in the audit_context
+ * for saving names from getname(). */
+#define AUDIT_NAMES    20
+
+/* AUDIT_NAMES_RESERVED is the number of slots we reserve in the
+ * audit_context from being used for nameless inodes from
+ * path_lookup. */
+#define AUDIT_NAMES_RESERVED 7
+
+/* At task start time, the audit_state is set in the audit_context using
+   a per-task filter.  At syscall entry, the audit_state is augmented by
+   the syscall filter. */
+enum audit_state {
+	AUDIT_DISABLED,		/* Do not create per-task audit_context.
+				 * No syscall-specific audit records can
+				 * be generated. */
+	AUDIT_SETUP_CONTEXT,	/* Create the per-task audit_context,
+				 * but don't necessarily fill it in at
+				 * syscall entry time (i.e., filter
+				 * instead). */
+	AUDIT_BUILD_CONTEXT,	/* Create the per-task audit_context,
+				 * and always fill it in at syscall
+				 * entry time.  This makes a full
+				 * syscall record available if some
+				 * other part of the kernel decides it
+				 * should be recorded. */
+	AUDIT_RECORD_CONTEXT	/* Create the per-task audit_context,
+				 * always fill it in at syscall entry
+				 * time, and always write out the audit
+				 * record at syscall exit time.  */
+};
+
+/* When fs/namei.c:getname() is called, we store the pointer in name and
+ * we don't let putname() free it (instead we free all of the saved
+ * pointers at syscall exit time).
+ *
+ * Further, in fs/namei.c:path_lookup() we store the inode and device. */
+struct audit_names {
+	const char	*name;
+	unsigned long	ino;
+	dev_t		rdev;
+};
+
+/* The per-task audit context. */
+struct audit_context {
+	int		    in_syscall;	/* 1 if task is in a syscall */
+	enum audit_state    state;
+	unsigned int	    serial;     /* serial number for record */
+	struct timespec	    ctime;      /* time of syscall entry */
+	uid_t		    loginuid;   /* login uid (identity) */
+	int		    major;      /* syscall number */
+	int		    minor;      /* function for multiplex syscalls */
+	int		    auditable;  /* 1 if record should be written */
+	int		    name_count;
+	struct audit_names  names[AUDIT_NAMES];
+	struct audit_context *previous; /* For nested syscalls */
+
+				/* Save things to print about task_struct */
+	pid_t		    pid;
+	uid_t		    uid, euid, suid, fsuid;
+	gid_t		    gid, egid, sgid, fsgid;
+
+#if AUDIT_DEBUG
+	int		    put_count;
+	int		    ino_count;
+#endif
+};
+
+				/* Public API */
+/* There are three lists of rules -- one to search at task creation
+ * time, one to search at syscall entry time, and another to search at
+ * syscall exit time. */
+static LIST_HEAD(audit_tsklist);
+static LIST_HEAD(audit_entlist);
+static LIST_HEAD(audit_extlist);
+
+struct audit_entry {
+	struct list_head  list;
+	struct rcu_head   rcu;
+	struct audit_rule rule;
+};
+
+/* Check to see if two rules are identical.  It is called from
+ * audit_del_rule during AUDIT_DEL. */
+static int audit_compare_rule(struct audit_rule *a, struct audit_rule *b)
+{
+	int i;
+
+	if (a->flags != b->flags)
+		return 1;
+	
+	if (a->action != b->action)
+		return 1;
+	
+	if (a->field_count != b->field_count)
+		return 1;
+	
+	for (i = 0; i < a->field_count; i++) {
+		if (a->fields[i] != b->fields[i]
+		    || a->values[i] != b->values[i])
+			return 1;
+	}
+
+	for (i = 0; i < AUDIT_BITMASK_SIZE; i++)
+		if (a->mask[i] != b->mask[i])
+			return 1;
+
+	return 0;
+}
+
+static inline int audit_add_rule(struct audit_entry *entry,
+				 struct list_head *list)
+{
+	if (entry->rule.flags & AUDIT_PREPEND) {
+		entry->rule.flags &= ~AUDIT_PREPEND;
+		list_add_rcu(&entry->list, list);
+	} else {
+		list_add_tail_rcu(&entry->list, list);
+	}
+	return 0;
+}
+
+static void audit_free_rule(void *arg)
+{
+	kfree(arg);
+}
+
+static inline int audit_del_rule(struct audit_rule *rule,
+				 struct list_head *list)
+{
+	struct audit_entry  *e;
+
+	list_for_each_entry_rcu(e, list, list) {
+		if (!audit_compare_rule(rule, &e->rule)) {
+			list_del_rcu(&e->list);
+			call_rcu(&e->rcu, audit_free_rule, e);
+			return 0;
+		}
+	}
+	return -EFAULT;		/* No matching rule */
+}
+
+#ifdef CONFIG_NET
+/* Copy rule from user-space to kernel-space.  Called during
+ * AUDIT_ADD. */
+static int audit_copy_rule(struct audit_rule *d, struct audit_rule *s)
+{
+	int i;
+
+	if (s->action != AUDIT_NEVER
+	    && s->action != AUDIT_POSSIBLE
+	    && s->action != AUDIT_ALWAYS)
+		return -1;
+	if (s->field_count < 0 || s->field_count > AUDIT_MAX_FIELDS)
+		return -1;
+	
+	d->flags	= s->flags;
+	d->action	= s->action;
+	d->field_count	= s->field_count;
+	for (i = 0; i < d->field_count; i++) {
+		d->fields[i] = s->fields[i];
+		d->values[i] = s->values[i];
+	}
+	for (i = 0; i < AUDIT_BITMASK_SIZE; i++) d->mask[i] = s->mask[i];
+	return 0;
+}
+
+int audit_receive_filter(int type, int pid, int uid, int seq, void *data)
+{
+	u32		   flags;
+	struct audit_entry *entry;
+	int		   err = 0;
+	
+	switch (type) {
+	case AUDIT_LIST:
+		list_for_each_entry_rcu(entry, &audit_tsklist, list)
+			audit_send_reply(pid, seq, AUDIT_LIST, 0, 1,
+					 &entry->rule, sizeof(entry->rule));
+		list_for_each_entry_rcu(entry, &audit_entlist, list)
+			audit_send_reply(pid, seq, AUDIT_LIST, 0, 1,
+					 &entry->rule, sizeof(entry->rule));
+		list_for_each_entry_rcu(entry, &audit_extlist, list)
+			audit_send_reply(pid, seq, AUDIT_LIST, 0, 1,
+					 &entry->rule, sizeof(entry->rule));
+		audit_send_reply(pid, seq, AUDIT_LIST, 1, 1, NULL, 0);
+		break;
+	case AUDIT_ADD:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (!(entry = kmalloc(sizeof(*entry), GFP_KERNEL)))
+			return -ENOMEM;
+		if (audit_copy_rule(&entry->rule, data)) {
+			kfree(entry);
+			return -EINVAL;
+		}
+		flags = entry->rule.flags;
+		if (!err && (flags & AUDIT_PER_TASK))
+			err = audit_add_rule(entry, &audit_tsklist);
+		if (!err && (flags & AUDIT_AT_ENTRY))
+			err = audit_add_rule(entry, &audit_entlist);
+		if (!err && (flags & AUDIT_AT_EXIT))
+			err = audit_add_rule(entry, &audit_extlist);
+		break;
+	case AUDIT_DEL:
+		flags =((struct audit_rule *)data)->flags;
+		if (!err && (flags & AUDIT_PER_TASK))
+			err = audit_del_rule(data, &audit_tsklist);
+		if (!err && (flags & AUDIT_AT_ENTRY))
+			err = audit_del_rule(data, &audit_entlist);
+		if (!err && (flags & AUDIT_AT_EXIT))
+			err = audit_del_rule(data, &audit_extlist);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return err;
+}
+#endif
+
+/* Compare a task_struct with an audit_rule.  Return 1 on match, 0
+ * otherwise. */
+static int audit_filter_rules(struct task_struct *tsk,
+			      struct audit_rule *rule,
+			      struct audit_context *ctx,
+			      enum audit_state *state)
+{
+	int i, j;
+	int found;
+
+	for (i = 0; i < rule->field_count; i++) {
+		u32 value = rule->values[i];
+		
+		switch (rule->fields[i]) {
+		case AUDIT_PID:
+			if (tsk->pid   != value)
+				return 0;
+			break;
+		case AUDIT_UID:
+			if (tsk->uid   != value)
+				return 0;
+			break;
+		case AUDIT_EUID:
+			if (tsk->euid  != value)
+				return 0;
+			break;
+		case AUDIT_SUID:
+			if (tsk->suid  != value)
+				return 0;
+			break;
+		case AUDIT_FSUID:
+			if (tsk->fsuid != value)
+				return 0;
+			break;
+		case AUDIT_GID:
+			if (tsk->gid   != value)
+				return 0;
+			break;
+		case AUDIT_EGID:
+			if (tsk->egid  != value)
+				return 0;
+			break;
+		case AUDIT_SGID:
+			if (tsk->sgid  != value)
+				return 0;
+			break;
+		case AUDIT_FSGID:
+			if (tsk->fsgid != value)
+				return 0;
+			break;
+		case AUDIT_EXIT:
+			if (tsk->exit_code!=value)
+				return 0;
+			break;
+		case AUDIT_NOTEXIT:
+			if (tsk->exit_code==value)
+				return 0;
+			break;
+		case AUDIT_DEVMAJOR:
+			if (!ctx)
+				return 0;
+			found = 0;
+			for (j = 0; !found && j < ctx->name_count; j++) {
+				if (MAJOR(ctx->names[j].rdev) == value)
+					++found;
+			}
+			if (!found)
+				return 0;
+			break;
+		case AUDIT_DEVMINOR:
+			if (!ctx)
+				return 0;
+			found = 0;
+			for (j = 0; !found && j < ctx->name_count; j++) {
+				if (MINOR(ctx->names[j].rdev) == value)
+					++found;
+			}
+			if (!found)
+				return 0;
+			break;
+		case AUDIT_INODE:
+			if (!ctx)
+				return 0;
+			found = 0;
+			for (j = 0; !found && j < ctx->name_count; j++) {
+				if (ctx->names[j].ino == value)
+					++found;
+			}
+			if (!found)
+				return 0;
+			break;
+		case AUDIT_LOGINUID:
+			if (!ctx || ctx->loginuid != value)
+				return 0;
+			break;
+		}
+	}
+	switch (rule->action) {
+	case AUDIT_NEVER:    *state = AUDIT_DISABLED;	    break;
+	case AUDIT_POSSIBLE: *state = AUDIT_BUILD_CONTEXT;  break;
+	case AUDIT_ALWAYS:   *state = AUDIT_RECORD_CONTEXT; break;
+	}
+	return 1;
+}
+
+/* At process creation time, we can determine if system-call auditing is
+ * completely disabled for this task.  Since we only have the task
+ * structure at this point, we can only check uid and gid.
+ */
+static enum audit_state audit_filter_task(struct task_struct *tsk)
+{
+	struct audit_entry *e;
+	enum audit_state   state;
+	
+	list_for_each_entry_rcu(e, &audit_tsklist, list) {
+		if (audit_filter_rules(tsk, &e->rule, NULL, &state))
+			return state;
+	}
+	return AUDIT_BUILD_CONTEXT;
+}
+
+/* At syscall entry and exit time, this filter is called if the
+ * audit_state is not low enough that auditing cannot take place, but is
+ * also not high enough that we already know we have to write and audit
+ * record (i.e., the state is AUDIT_SETUP_CONTEXT or  AUDIT_BUILD_CONTEXT).
+ */
+static enum audit_state audit_filter_syscall(struct task_struct *tsk,
+					     struct audit_context *ctx,
+					     struct list_head *list)
+{
+	struct audit_entry *e;
+	enum audit_state   state;
+	int		   word = AUDIT_WORD(ctx->major);
+	int		   bit  = AUDIT_BIT(ctx->major);
+	
+	list_for_each_entry_rcu(e, list, list) {
+		if ((e->rule.mask[word] & bit) == bit
+ 		    && audit_filter_rules(tsk, &e->rule, ctx, &state))
+			return state;
+	}
+	return AUDIT_BUILD_CONTEXT;
+}
+
+/* This should be called with task_lock() held. */
+static inline struct audit_context *audit_get_context(struct task_struct *tsk)
+{
+	struct audit_context *context = tsk->audit_context;
+
+	if (likely(!context))
+		return NULL;
+	if (context->in_syscall && !context->auditable) {
+		enum audit_state state;
+		state = audit_filter_syscall(tsk, context, &audit_extlist);
+		if (state == AUDIT_RECORD_CONTEXT)
+			context->auditable = 1;
+	}
+
+	context->pid = tsk->pid;
+	context->uid = tsk->uid;
+	context->gid = tsk->gid;
+	context->euid = tsk->euid;
+	context->suid = tsk->suid;
+	context->fsuid = tsk->fsuid;
+	context->egid = tsk->egid;
+	context->sgid = tsk->sgid;
+	context->fsgid = tsk->fsgid;
+	tsk->audit_context = NULL;
+	return context;
+}
+
+static inline void audit_free_names(struct audit_context *context)
+{
+	int i;
+
+#if AUDIT_DEBUG == 2
+	if (context->auditable
+	    ||context->put_count + context->ino_count != context->name_count) {
+		printk(KERN_ERR "audit.c:%d(:%d): major=%d in_syscall=%d"
+		       " name_count=%d put_count=%d"
+		       " ino_count=%d [NOT freeing]\n",
+		       __LINE__,
+		       context->serial, context->major, context->in_syscall,
+		       context->name_count, context->put_count,
+		       context->ino_count);
+		for (i = 0; i < context->name_count; i++)
+			printk(KERN_ERR "names[%d] = %p = %s\n", i,
+			       context->names[i].name,
+			       context->names[i].name);
+		dump_stack();
+		return;
+	}
+#endif
+#if AUDIT_DEBUG
+	context->put_count  = 0;
+	context->ino_count  = 0;
+#endif
+
+	for (i = 0; i < context->name_count; i++)
+		if (context->names[i].name)
+			__putname(context->names[i].name);
+	context->name_count = 0;
+}
+
+static inline void audit_zero_context(struct audit_context *context,
+				      enum audit_state state)
+{
+	uid_t loginuid = context->loginuid;
+	
+	memset(context, 0, sizeof(*context));
+	context->state      = state;
+	context->loginuid   = loginuid;
+}
+
+static inline struct audit_context *audit_alloc_context(enum audit_state state)
+{
+	struct audit_context *context;
+
+	if (!(context = kmalloc(sizeof(*context), GFP_KERNEL)))
+		return NULL;
+	audit_zero_context(context, state);
+	return context;
+}
+
+/* Filter on the task information and allocate a per-task audit context
+ * if necessary.  Doing so turns on system call auditing for the
+ * specified task.  This is called from copy_process, so no lock is
+ * needed. */
+int audit_alloc(struct task_struct *tsk)
+{
+	struct audit_context *context;
+	enum audit_state     state;
+
+	if (likely(!audit_enabled))
+		return 0; /* Return if not auditing. */
+
+	state = audit_filter_task(tsk);
+	if (likely(state == AUDIT_DISABLED))
+		return 0;
+	
+	if (!(context = audit_alloc_context(state))) {
+		audit_log_lost("out of memory in audit_alloc");
+		return -ENOMEM;
+	}
+
+				/* Preserve login uid */
+	context->loginuid = -1;
+	if (tsk->audit_context)
+		context->loginuid = tsk->audit_context->loginuid;
+
+	tsk->audit_context  = context;
+	set_tsk_thread_flag(tsk, TIF_SYSCALL_AUDIT);
+	return 0;
+}
+
+static inline void audit_free_context(struct audit_context *context)
+{
+	struct audit_context *previous;
+	int		     count = 0;
+
+	do {
+		previous = context->previous;
+		if (previous || (count &&  count < 10)) {
+			++count;
+			printk(KERN_ERR "audit(:%d): major=%d name_count=%d:"
+			       " freeing multiple contexts (%d)\n",
+			       context->serial, context->major,
+			       context->name_count, count);
+		}
+		audit_free_names(context);
+		kfree(context);
+		context  = previous;
+	} while (context);
+	if (count >= 10)
+		printk(KERN_ERR "audit: freed %d contexts\n", count);
+}
+
+static void audit_log_exit(struct audit_context *context)
+{
+	int i;
+
+	audit_log(context,
+		  "syscall=%d,0x%x items=%d"
+		  " pid=%d loginuid=%d uid=%d gid=%d"
+		  " euid=%d suid=%d fsuid=%d"
+		  " egid=%d sgid=%d fsgid=%d",
+		  context->major,
+		  context->minor,
+		  context->name_count,
+		  context->pid,
+		  context->loginuid,
+		  context->uid,
+		  context->gid,
+		  context->euid, context->suid, context->fsuid,
+		  context->egid, context->sgid, context->fsgid);
+	for (i = 0; i < context->name_count; i++) {
+		struct audit_buffer  *ab = audit_log_start(context);
+		if (!ab)
+			continue; /* audit_panic has been called */
+		audit_log_format(ab, "item=%d", i);
+		if (context->names[i].name)
+			audit_log_format(ab, " name=%s",
+					 context->names[i].name);
+		if (context->names[i].ino != (unsigned long)-1)
+			audit_log_format(ab, " inode=%lu",
+					 context->names[i].ino);
+		/* FIXME: should use format_dev_t, but ab structure is
+		 * opaque. */
+		if (context->names[i].rdev != -1)
+			audit_log_format(ab, " dev=%02x:%02x",
+					 MAJOR(context->names[i].rdev),
+					 MINOR(context->names[i].rdev));
+		audit_log_end(ab);
+	}
+}
+
+/* Free a per-task audit context.  Called from copy_process and
+ * __put_task_struct. */
+void audit_free(struct task_struct *tsk)
+{
+	struct audit_context *context;
+
+	task_lock(tsk);
+	context = audit_get_context(tsk);
+	task_unlock(tsk);
+		
+	if (likely(!context))
+		return;
+
+	/* Check for system calls that do not go through the exit
+	 * function (e.g., exit_group), then free context block. */
+	if (context->in_syscall && context->auditable)
+		audit_log_exit(context);
+
+	audit_free_context(context);
+}
+
+/* Compute a serial number for the audit record.  Audit records are
+ * written to user-space as soon as they are generated, so a complete
+ * audit record may be written in several pieces.  The timestamp of the
+ * record and this serial number are used by the user-space daemon to
+ * determine which pieces belong to the same audit record.  The
+ * (timestamp,serial) tuple is unique for each syscall and is live from
+ * syscall entry to syscall exit.
+ *
+ * Atomic values are only guaranteed to be 24-bit, so we count down.
+ *
+ * NOTE: Another possibility is to store the formatted records off the
+ * audit context (for those records that have a context), and emit them
+ * all at syscall exit.  However, this could delay the reporting of
+ * significant errors until syscall exit (or never, if the system
+ * halts). */
+static inline unsigned int audit_serial(void)
+{
+	static atomic_t serial = ATOMIC_INIT(0xffffff);
+	unsigned int a, b;
+
+	do {
+		a = atomic_read(&serial);
+		if (atomic_dec_and_test(&serial))
+			atomic_set(&serial, 0xffffff);
+		b = atomic_read(&serial);
+	} while (b != a - 1);
+
+	return 0xffffff - b;
+}
+
+/* Fill in audit context at syscall entry.  This only happens if the
+ * audit context was created when the task was created and the state or
+ * filters demand the audit context be built.  If the state from the
+ * per-task filter or from the per-syscall filter is AUDIT_RECORD_CONTEXT,
+ * then the record will be written at syscall exit time (otherwise, it
+ * will only be written if another part of the kernel requests that it
+ * be written). */
+void audit_syscall_entry(struct task_struct *tsk, int major, int minor)
+{
+	struct audit_context *context = tsk->audit_context;
+	enum audit_state     state;
+
+	BUG_ON(!context);
+
+	/* This happens only on certain architectures that make system
+	 * calls in kernel_thread via the entry.S interface, instead of
+	 * with direct calls.  (If you are porting to a new
+	 * architecture, hitting this condition can indicate that you
+	 * got the _exit/_leave calls backward in entry.S.)
+	 *
+	 * i386     no
+	 * x86_64   no
+	 * ppc64    yes (see arch/ppc64/kernel/misc.S)
+	 *
+	 * This also happens with vm86 emulation in a non-nested manner
+	 * (entries without exits), so this case must be caught.
+	 */
+	if (context->in_syscall) {
+		struct audit_context *newctx;
+
+#if defined(__NR_vm86) && defined(__NR_vm86old)
+		/* vm86 mode should only be entered once */
+		if (major == __NR_vm86 || major == __NR_vm86old)
+			return;
+#endif
+#if AUDIT_DEBUG
+		printk(KERN_ERR
+		       "audit(:%d) pid=%d in syscall=%d;"
+		       " entering syscall=%d\n",
+		       context->serial, tsk->pid, context->major, major);
+#endif
+		newctx = audit_alloc_context(context->state);
+		if (newctx) {
+			newctx->previous   = context;
+			context		   = newctx;
+			tsk->audit_context = newctx;
+		} else	{
+			/* If we can't alloc a new context, the best we
+			 * can do is to leak memory (any pending putname
+			 * will be lost).  The only other alternative is
+			 * to abandon auditing. */
+			audit_zero_context(context, context->state);
+		}
+	}
+	BUG_ON(context->in_syscall || context->name_count);
+
+	if (!audit_enabled)
+		return;
+
+	context->major      = major;
+	context->minor      = minor; /* Only valid for some calls */
+
+	state = context->state;
+	if (state == AUDIT_SETUP_CONTEXT || state == AUDIT_BUILD_CONTEXT)
+		state = audit_filter_syscall(tsk, context, &audit_entlist);
+	if (likely(state == AUDIT_DISABLED))
+		return;
+
+	context->serial     = audit_serial();
+	context->ctime      = CURRENT_TIME;
+	context->in_syscall = 1;
+	context->auditable  = !!(state == AUDIT_RECORD_CONTEXT);
+}
+
+/* Tear down after system call.  If the audit context has been marked as
+ * auditable (either because of the AUDIT_RECORD_CONTEXT state from
+ * filtering, or because some other part of the kernel write an audit
+ * message), then write out the syscall information.  In call cases,
+ * free the names stored from getname(). */
+void audit_syscall_exit(struct task_struct *tsk)
+{
+	struct audit_context *context;
+
+	get_task_struct(tsk);
+	task_lock(tsk);
+	context = audit_get_context(tsk);
+	task_unlock(tsk);
+
+	/* Not having a context here is ok, since the parent may have
+	 * called __put_task_struct. */
+	if (likely(!context))
+		return;
+
+	if (context->in_syscall && context->auditable)
+		audit_log_exit(context);
+	
+	context->in_syscall = 0;
+	context->auditable  = 0;
+	if (context->previous) {
+		struct audit_context *new_context = context->previous;
+		context->previous  = NULL;
+		audit_free_context(context);
+		tsk->audit_context = new_context;
+	} else {
+		audit_free_names(context);
+		audit_zero_context(context, context->state);
+		tsk->audit_context = context;
+	}
+	put_task_struct(tsk);
+}
+
+/* Add a name to the list.  Called from fs/namei.c:getname(). */
+void audit_getname(const char *name)
+{
+	struct audit_context *context = current->audit_context;
+
+	BUG_ON(!context);
+	if (!context->in_syscall) {
+#if AUDIT_DEBUG == 2
+		printk(KERN_ERR "audit.c:%d(:%d): ignoring getname(%p)\n",
+		       __LINE__, context->serial, name);
+		dump_stack();
+#endif
+		return;
+	}
+	BUG_ON(context->name_count >= AUDIT_NAMES);
+	context->names[context->name_count].name = name;
+	context->names[context->name_count].ino  = (unsigned long)-1;
+	context->names[context->name_count].rdev = -1;
+	++context->name_count;
+}
+
+/* Intercept a putname request.  Called from
+ * include/linux/fs.h:putname().  If we have stored the name from
+ * getname in the audit context, then we delay the putname until syscall
+ * exit. */
+void audit_putname(const char *name)
+{
+	struct audit_context *context = current->audit_context;
+
+	BUG_ON(!context);
+	if (!context->in_syscall) {
+#if AUDIT_DEBUG == 2
+		printk(KERN_ERR "audit.c:%d(:%d): __putname(%p)\n",
+		       __LINE__, context->serial, name);
+		if (context->name_count) {
+			int i;
+			for (i = 0; i < context->name_count; i++)
+				printk(KERN_ERR "name[%d] = %p = %s\n", i,
+				       context->names[i].name,
+				       context->names[i].name);
+		}
+#endif		
+		__putname(name);
+	}
+#if AUDIT_DEBUG
+	else {
+		++context->put_count;
+		if (context->put_count > context->name_count) {
+			printk(KERN_ERR "audit.c:%d(:%d): major=%d"
+			       " in_syscall=%d putname(%p) name_count=%d"
+			       " put_count=%d\n",
+			       __LINE__,
+			       context->serial, context->major,
+			       context->in_syscall, name, context->name_count,
+			       context->put_count);
+			dump_stack();
+		}
+	}
+#endif
+}
+
+/* Store the inode and device from a lookup.  Called from
+ * fs/namei.c:path_lookup(). */
+void audit_inode(const char *name, unsigned long ino, dev_t rdev)
+{
+	int idx;
+	struct audit_context *context = current->audit_context;
+	
+	if (context->name_count
+	    && context->names[context->name_count-1].name
+	    && context->names[context->name_count-1].name == name)
+		idx = context->name_count - 1;
+	else if (context->name_count > 1
+		 && context->names[context->name_count-2].name
+		 && context->names[context->name_count-2].name == name)
+		idx = context->name_count - 2;
+	else {
+		/* FIXME: how much do we care about inodes that have no
+		 * associated name? */
+		if (context->name_count >= AUDIT_NAMES - AUDIT_NAMES_RESERVED)
+			return;
+		idx = context->name_count++;
+		context->names[idx].name = NULL;
+#if AUDIT_DEBUG
+		++context->ino_count;
+#endif
+	}
+	context->names[idx].ino  = ino;
+	context->names[idx].rdev = rdev;
+}
+
+void audit_get_stamp(struct audit_context *ctx,
+		     struct timespec *t, int *serial)
+{
+	if (ctx) {
+		t->tv_sec  = ctx->ctime.tv_sec;
+		t->tv_nsec = ctx->ctime.tv_nsec;
+		*serial    = ctx->serial;
+		ctx->auditable = 1;
+	} else {
+		*t      = CURRENT_TIME;
+		*serial = 0;
+	}
+}
+
+int audit_set_loginuid(struct audit_context *ctx, uid_t loginuid)
+{
+	if (ctx) {
+		if (loginuid < 0)
+			return -EINVAL;
+		ctx->loginuid = loginuid;
+	}
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(audit_alloc);
+EXPORT_SYMBOL_GPL(audit_free);
+EXPORT_SYMBOL_GPL(audit_syscall_entry);
+EXPORT_SYMBOL_GPL(audit_syscall_exit);
+EXPORT_SYMBOL_GPL(audit_getname);
+EXPORT_SYMBOL_GPL(audit_putname);
+EXPORT_SYMBOL_GPL(audit_inode);
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/kernel/fork.c linux-2.6.4/kernel/fork.c
--- linux-2.6.4-pristine/kernel/fork.c	2004-03-10 21:55:22.000000000 -0500
+++ linux-2.6.4/kernel/fork.c	2004-03-11 00:42:25.000000000 -0500
@@ -31,6 +31,7 @@
 #include <linux/futex.h>
 #include <linux/ptrace.h>
 #include <linux/mount.h>
+#include <linux/audit.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -85,6 +86,8 @@ void __put_task_struct(struct task_struc
 	WARN_ON(atomic_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
+	if (unlikely(tsk->audit_context))
+		audit_free(tsk);
 	security_task_free(tsk);
 	free_uid(tsk->user);
 	put_group_info(tsk->group_info);
@@ -945,13 +948,16 @@ struct task_struct *copy_process(unsigne
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
 	p->io_context = NULL;
+	p->audit_context = NULL;
 
 	retval = -ENOMEM;
 	if ((retval = security_task_alloc(p)))
 		goto bad_fork_cleanup;
+	if ((retval = audit_alloc(p)))
+		goto bad_fork_cleanup_security;
 	/* copy all the process information */
 	if ((retval = copy_semundo(clone_flags, p)))
-		goto bad_fork_cleanup_security;
+		goto bad_fork_cleanup_audit;
 	if ((retval = copy_files(clone_flags, p)))
 		goto bad_fork_cleanup_semundo;
 	if ((retval = copy_fs(clone_flags, p)))
@@ -1086,6 +1092,8 @@ bad_fork_cleanup_files:
 	exit_files(p); /* blocking */
 bad_fork_cleanup_semundo:
 	exit_sem(p);
+bad_fork_cleanup_audit:
+	audit_free(p);
 bad_fork_cleanup_security:
 	security_task_free(p);
 bad_fork_cleanup:
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/kernel/Makefile linux-2.6.4/kernel/Makefile
--- linux-2.6.4-pristine/kernel/Makefile	2004-03-10 21:55:23.000000000 -0500
+++ linux-2.6.4/kernel/Makefile	2004-03-11 00:05:53.000000000 -0500
@@ -21,6 +21,8 @@ obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
 obj-$(CONFIG_STOP_MACHINE) += stop_machine.o
+obj-$(CONFIG_AUDIT) += audit.o
+obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/security/selinux/avc.c linux-2.6.4/security/selinux/avc.c
--- linux-2.6.4-pristine/security/selinux/avc.c	2004-03-10 21:55:37.000000000 -0500
+++ linux-2.6.4/security/selinux/avc.c	2004-03-11 01:06:51.000000000 -0500
@@ -22,6 +22,7 @@
 #include <linux/un.h>
 #include <net/af_unix.h>
 #include <linux/ip.h>
+#include <linux/audit.h>
 #include "avc.h"
 #include "avc_ss.h"
 #include "class_to_string.h"
@@ -66,14 +67,10 @@ struct avc_callback_node {
 };
 
 static spinlock_t avc_lock = SPIN_LOCK_UNLOCKED;
-static spinlock_t avc_log_lock = SPIN_LOCK_UNLOCKED;
 static struct avc_node *avc_node_freelist = NULL;
 static struct avc_cache avc_cache;
-static char *avc_audit_buffer = NULL;
 static unsigned avc_cache_stats[AVC_NSTATS];
 static struct avc_callback_node *avc_callbacks = NULL;
-static unsigned int avc_log_level = 4; /* default:  KERN_WARNING */
-static char avc_level_string[4] = "< >";
 
 static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
 {
@@ -85,14 +82,14 @@ static inline int avc_hash(u32 ssid, u32
  * @tclass: target security class
  * @av: access vector
  */
-void avc_dump_av(u16 tclass, u32 av)
+void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av)
 {
 	char **common_pts = 0;
 	u32 common_base = 0;
 	int i, i2, perm;
 
 	if (av == 0) {
-		printk(" null");
+		audit_log_format(ab, " null");
 		return;
 	}
 
@@ -104,12 +101,12 @@ void avc_dump_av(u16 tclass, u32 av)
 		}
 	}
 
-	printk(" {");
+	audit_log_format(ab, " {");
 	i = 0;
 	perm = 1;
 	while (perm < common_base) {
 		if (perm & av)
-			printk(" %s", common_pts[i]);
+			audit_log_format(ab, " %s", common_pts[i]);
 		i++;
 		perm <<= 1;
 	}
@@ -122,13 +119,14 @@ void avc_dump_av(u16 tclass, u32 av)
 					break;
 			}
 			if (i2 < ARRAY_SIZE(av_perm_to_string))
-				printk(" %s", av_perm_to_string[i2].name);
+				audit_log_format(ab, " %s",
+						 av_perm_to_string[i2].name);
 		}
 		i++;
 		perm <<= 1;
 	}
 
-	printk(" }");
+	audit_log_format(ab, " }");
 }
 
 /**
@@ -137,7 +135,7 @@ void avc_dump_av(u16 tclass, u32 av)
  * @tsid: target security identifier
  * @tclass: target security class
  */
-void avc_dump_query(u32 ssid, u32 tsid, u16 tclass)
+void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tclass)
 {
 	int rc;
 	char *scontext;
@@ -145,20 +143,20 @@ void avc_dump_query(u32 ssid, u32 tsid, 
 
  	rc = security_sid_to_context(ssid, &scontext, &scontext_len);
 	if (rc)
-		printk("ssid=%d", ssid);
+		audit_log_format(ab, "ssid=%d", ssid);
 	else {
-		printk("scontext=%s", scontext);
+		audit_log_format(ab, "scontext=%s", scontext);
 		kfree(scontext);
 	}
 
 	rc = security_sid_to_context(tsid, &scontext, &scontext_len);
 	if (rc)
-		printk(" tsid=%d", tsid);
+		audit_log_format(ab, " tsid=%d", tsid);
 	else {
-		printk(" tcontext=%s", scontext);
+		audit_log_format(ab, " tcontext=%s", scontext);
 		kfree(scontext);
 	}
-	printk(" tclass=%s", class_to_string[tclass]);
+	audit_log_format(ab, " tclass=%s", class_to_string[tclass]);
 }
 
 /**
@@ -192,11 +190,7 @@ void __init avc_init(void)
 		avc_node_freelist = new;
 	}
 
-	avc_audit_buffer = (char *)__get_free_page(GFP_ATOMIC);
-	if (!avc_audit_buffer)
-		panic("AVC:  unable to allocate audit buffer\n");
-
-	avc_level_string[1] = '0' + avc_log_level;
+	audit_log(current->audit_context, "AVC INITIALIZED\n");
 }
 
 #if 0
@@ -418,12 +412,13 @@ out:
 	return rc;
 }
 
-static inline void avc_print_ipv4_addr(u32 addr, u16 port, char *name1, char *name2)
+static inline void avc_print_ipv4_addr(struct audit_buffer *ab, u32 addr,
+				       u16 port, char *name1, char *name2)
 {
 	if (addr)
-		printk(" %s=%d.%d.%d.%d", name1, NIPQUAD(addr));
+		audit_log_format(ab, " %s=%d.%d.%d.%d", name1, NIPQUAD(addr));
 	if (port)
-		printk(" %s=%d", name2, ntohs(port));
+		audit_log_format(ab, " %s=%d", name2, ntohs(port));
 }
 
 /*
@@ -503,9 +498,8 @@ void avc_audit(u32 ssid, u32 tsid,
 {
 	struct task_struct *tsk = current;
 	struct inode *inode = NULL;
-	char *p;
 	u32 denied, audited;
-	unsigned long flags;
+	struct audit_buffer *ab;
 
 	denied = requested & ~avd->allowed;
 	if (denied) {
@@ -523,19 +517,18 @@ void avc_audit(u32 ssid, u32 tsid,
 	if (!check_avc_ratelimit())
 		return;
 
-	/* prevent overlapping printks */
-	spin_lock_irqsave(&avc_log_lock,flags);
-
-	printk("%s\n", avc_level_string);
-	printk("%savc:  %s ", avc_level_string, denied ? "denied" : "granted");
-	avc_dump_av(tclass,audited);
-	printk(" for ");
+	ab = audit_log_start(current->audit_context);
+	if (!ab)
+		return;		/* audit_panic has been called */
+	audit_log_format(ab, "avc:  %s ", denied ? "denied" : "granted");
+	avc_dump_av(ab, tclass,audited);
+	audit_log_format(ab, " for ");
 	if (a && a->tsk)
 		tsk = a->tsk;
 	if (tsk && tsk->pid) {
 		struct mm_struct *mm;
 		struct vm_area_struct *vma;
-		printk(" pid=%d", tsk->pid);
+		audit_log_format(ab, " pid=%d", tsk->pid);
 		if (tsk == current)
 			mm = current->mm;
 		else
@@ -546,11 +539,9 @@ void avc_audit(u32 ssid, u32 tsid,
 				while (vma) {
 					if ((vma->vm_flags & VM_EXECUTABLE) &&
 					    vma->vm_file) {
-						p = d_path(vma->vm_file->f_dentry,
-							   vma->vm_file->f_vfsmnt,
-							   avc_audit_buffer,
-							   PAGE_SIZE);
-						printk(" exe=%s", p);
+						audit_log_d_path(ab, "exe=",
+								 vma->vm_file->f_dentry,
+								 vma->vm_file->f_vfsmnt);
 						break;
 					}
 					vma = vma->vm_next;
@@ -560,29 +551,25 @@ void avc_audit(u32 ssid, u32 tsid,
 			if (tsk != current)
 				mmput(mm);
 		} else {
-			printk(" comm=%s", tsk->comm);
+			audit_log_format(ab, " comm=%s", tsk->comm);
 		}
 	}
 	if (a) {
 		switch (a->type) {
 		case AVC_AUDIT_DATA_IPC:
-			printk(" key=%d", a->u.ipc_id);
+			audit_log_format(ab, " key=%d", a->u.ipc_id);
 			break;
 		case AVC_AUDIT_DATA_CAP:
-			printk(" capability=%d", a->u.cap);
+			audit_log_format(ab, " capability=%d", a->u.cap);
 			break;
 		case AVC_AUDIT_DATA_FS:
 			if (a->u.fs.dentry) {
 				struct dentry *dentry = a->u.fs.dentry;
 				if (a->u.fs.mnt) {
-					p = d_path(dentry,
-						   a->u.fs.mnt,
-						   avc_audit_buffer,
-						   PAGE_SIZE);
-					if (p)
-						printk(" path=%s", p);
+					audit_log_d_path(ab, "path=", dentry, a->u.fs.mnt);
 				} else {
-					printk(" name=%s", dentry->d_name.name);
+					audit_log_format(ab, " name=%s",
+							 dentry->d_name.name);
 				}
 				inode = dentry->d_inode;
 			} else if (a->u.fs.inode) {
@@ -590,13 +577,15 @@ void avc_audit(u32 ssid, u32 tsid,
 				inode = a->u.fs.inode;
 				dentry = d_find_alias(inode);
 				if (dentry) {
-					printk(" name=%s", dentry->d_name.name);
+					audit_log_format(ab, " name=%s",
+							 dentry->d_name.name);
 					dput(dentry);
 				}
 			}
 			if (inode)
-				printk(" dev=%s ino=%ld",
-				       inode->i_sb->s_id, inode->i_ino);
+				audit_log_format(ab, " dev=%s ino=%ld",
+						 inode->i_sb->s_id,
+						 inode->i_ino);
 			break;
 		case AVC_AUDIT_DATA_NET:
 			if (a->u.net.sk) {
@@ -607,53 +596,45 @@ void avc_audit(u32 ssid, u32 tsid,
 				switch (sk->sk_family) {
 				case AF_INET:
 					inet = inet_sk(sk);
-					avc_print_ipv4_addr(inet->rcv_saddr,
-					                    inet->sport,
-					                    "laddr", "lport");
-					avc_print_ipv4_addr(inet->daddr,
-					                    inet->dport,
-					                    "faddr", "fport");
+					avc_print_ipv4_addr(ab, inet->rcv_saddr,
+							    inet->sport,
+							    "laddr", "lport");
+					avc_print_ipv4_addr(ab, inet->daddr,
+							    inet->dport,
+							    "faddr", "fport");
 					break;
 				case AF_UNIX:
 					u = unix_sk(sk);
 					if (u->dentry) {
-						p = d_path(u->dentry,
-							   u->mnt,
-							   avc_audit_buffer,
-							   PAGE_SIZE);
-						printk(" path=%s", p);
+						audit_log_d_path(ab, "path=",
+								 u->dentry, u->mnt);
 					} else if (u->addr) {
-						p = avc_audit_buffer;
-						memcpy(p,
-						       u->addr->name->sun_path,
-						       u->addr->len-sizeof(short));
-						if (*p == 0) {
-							*p = '@';
-							p += u->addr->len-sizeof(short);
-							*p = 0;
-						}
-						printk(" path=%s",
-						       avc_audit_buffer);
+						int len = u->addr->len-sizeof(short);
+						char *p = &u->addr->name->sun_path[0];
+						if (*p)
+							audit_log_format(ab, "path=%*.*s",
+									 len, len, p);
+						else
+							audit_log_format(ab, "path=@%*.*s",
+									 len-1, len-1, p+1);
 					}
 					break;
 				}
 			}
 			
-			avc_print_ipv4_addr(a->u.net.saddr, a->u.net.sport,
-			                    "saddr", "src");
-			avc_print_ipv4_addr(a->u.net.daddr, a->u.net.dport,
-			                    "daddr", "dest");
+			avc_print_ipv4_addr(ab, a->u.net.saddr, a->u.net.sport,
+					    "saddr", "src");
+			avc_print_ipv4_addr(ab, a->u.net.daddr, a->u.net.dport,
+					    "daddr", "dest");
 
 			if (a->u.net.netif)
-				printk(" netif=%s", a->u.net.netif);
+				audit_log_format(ab, " netif=%s", a->u.net.netif);
 			break;
 		}
 	}
-	printk(" ");
-	avc_dump_query(ssid, tsid, tclass);
-	printk("\n");
-
-	spin_unlock_irqrestore(&avc_log_lock,flags);
+	audit_log_format(ab, " ");
+	avc_dump_query(ab, ssid, tsid, tclass);
+	audit_log_end(ab);
 }
 
 /**
@@ -1083,13 +1064,4 @@ int avc_has_perm(u32 ssid, u32 tsid, u16
 	return rc;
 }
 
-static int __init avc_log_level_setup(char *str)
-{
-	avc_log_level = simple_strtol(str, NULL, 0);
-	if (avc_log_level > 7)
-		avc_log_level = 7;
-	return 1;
-}
-
-__setup("avc_log_level=", avc_log_level_setup);
 
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/security/selinux/include/avc.h linux-2.6.4/security/selinux/include/avc.h
--- linux-2.6.4-pristine/security/selinux/include/avc.h	2004-03-10 21:55:23.000000000 -0500
+++ linux-2.6.4/security/selinux/include/avc.h	2004-03-11 00:05:53.000000000 -0500
@@ -114,9 +114,10 @@ static inline void avc_cache_stats_add(i
 /*
  * AVC display support
  */
-void avc_dump_av(u16 tclass, u32 av);
-void avc_dump_query(u32 ssid, u32 tsid, u16 tclass);
-void avc_dump_cache(char *tag);
+struct audit_buffer;
+void avc_dump_av(struct audit_buffer *ab, u16 tclass, u32 av);
+void avc_dump_query(struct audit_buffer *ab, u32 ssid, u32 tsid, u16 tclass);
+void avc_dump_cache(struct audit_buffer *ab, char *tag);
 
 /*
  * AVC operations
diff -rupP --exclude-from=ignore linux-2.6.4-pristine/security/selinux/ss/services.c linux-2.6.4/security/selinux/ss/services.c
--- linux-2.6.4-pristine/security/selinux/ss/services.c	2004-03-10 21:55:44.000000000 -0500
+++ linux-2.6.4/security/selinux/ss/services.c	2004-03-11 00:05:53.000000000 -0500
@@ -386,7 +386,7 @@ int security_sid_to_context(u32 sid, cha
 			char *scontextp;
 
 			*scontext_len = strlen(initial_sid_to_string[sid]) + 1;
-			scontextp = kmalloc(*scontext_len,GFP_KERNEL);
+			scontextp = kmalloc(*scontext_len,GFP_ATOMIC);
 			strcpy(scontextp, initial_sid_to_string[sid]);
 			*scontext = scontextp;
 			goto out;


