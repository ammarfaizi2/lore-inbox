Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWERQHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWERQHy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 12:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWERQHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 12:07:54 -0400
Received: from lea.cs.unibo.it ([130.136.1.101]:34494 "EHLO lea.cs.unibo.it")
	by vger.kernel.org with ESMTP id S1751369AbWERQHx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 12:07:53 -0400
Date: Thu, 18 May 2006 18:07:51 +0200
To: linux-kernel@vger.kernel.org
Cc: osd@cs.unibo.it
Subject: [PATCH] 3-ptrace_vm
Message-ID: <20060518160751.GD17498@cs.unibo.it>
References: <20060518155337.GA17498@cs.unibo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060518155337.GA17498@cs.unibo.it>
User-Agent: Mutt/1.5.6+20040907i
From: renzo@cs.unibo.it (Renzo Davoli)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PTRACE_SYSVM patch is a improvement for applications
that use ptrace() for creating virtual machines, like User Mode Linux
or UMview.

The concept is near to the SYSEMU patch introduced by UML: you can specify that
a system call should not be executed by the underlying kernel.

In PTRACE_SYSEMU there's a conceptual hole: you tell that _the_next_ system call
won't be called, but sometimes is important to decide whether the system
call has to be executed or not during the system call management, it is not
possible to decide in advance. 
User-Mode linux redefines all the system calls, but UM-ViewOS (for example)
aims to redefine only some of them and under specifical conditions.
(thus implementing Partial Virtual Machines).
In this case a VM monitor need to run the uncatched system calls in the 
ptraced process without any further interactions (which would be only a
waste of time).

Our patch is semantically much more general, in order to select between
different behavior: with SYSVM you can decide to skip both the execution of the
current system call and the upcall after the execution or just the
"after syscall" upcall.

We introduced PTRACE_SYSVM request, together with PTRACE_VM_SKIPCALL and
PTRACE_VM_SKIPEXIT options that are specified inside the third parameter 
of ptrace().
PTRACE_SYSVM is intended to be used instead of PTRACE_SYSCALL during the
upcall preceding the system call execution.

PTRACE_VM_SKIPCALL skips the system call execution (by the ptraced prrocess). 
PTRACE_VM_SKIPEXIT avoids the second upcall after the system call execution.

With the PTRACE_SYSVM support a ptracing process (usually the virtual machine
monitor for the ptraced process) can decide different behaviors:

** ptrace(PTRACE_SYSVM,pid,0,0): it is completely equivalent to
	ptrace(PTRACE_SYSCALL,pid,0,0)

** ptrace(PTRACE_SYSVM,pid,PT_VM_SKIPEXIT,0): the syscall is executed and the
results are returned to the process (pid). This is useful when the
ptracing process does not need to virtualize the call.

** ptrace(PTRACE_SYSVM,pid,PT_VM_SKIPCALL | PT_VM_SKIPEXIT,0): the syscall is
*not* executed nor there is a further upcall. This possibility is used when
the virtual machine need to virtualize the call, the return value, exit status
etc. should be loaded in the process address space before this call (maybe
using a PTRACE_MULTI call).

(In theory it is also possible to use a call like 
ptrace(PTRACE_SYSVM,pid,VM_SKIPCALL,0): in this case the system call is not
executed but a second upcall takes place anyway. This is useless as 
the second upcall takes place after the kernel has done nothing after the first
one.
We decided to use two flags for the sake of clearness and readability,
and given that we needed three different behaviors we needed two bits anyway).

That patch could completely replace PTRACE_SYSEMU: User Mode Linux could easily
use our patch in place of SYSEMU. 

The patch work on ppc, i386, and even um (usermodelinux) architecture.
It has given a good speedup to Umview (from some rough tests it seems up to 
1.8,1.85 on system call intensive programs like cp).

Signed-off-by: renzo davoli <renzo@cs.unibo.it>

diff -Naur linux-2.6.17-rc1-access/arch/i386/kernel/ptrace.c linux-2.6.17-rc1-pmulti-ptvm/arch/i386/kernel/ptrace.c
--- linux-2.6.17-rc1-access/arch/i386/kernel/ptrace.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-pmulti-ptvm/arch/i386/kernel/ptrace.c	2006-04-03 11:30:53.000000000 +0200
@@ -477,15 +477,26 @@
 		  }
 		  break;
 
+	case PTRACE_SYSVM:
+		  if (addr == PTRACE_VM_TEST) {
+			  ret = PTRACE_VM_MASK;
+			  break;
+		  }
+
 	case PTRACE_SYSEMU: /* continue and stop at next syscall, which will not be executed */
 	case PTRACE_SYSCALL:	/* continue and stop at next (return from) syscall */
 	case PTRACE_CONT:	/* restart after signal. */
 		ret = -EIO;
 		if (!valid_signal(data))
 			break;
+		child->ptrace &= ~PT_VM_MASK;
 		if (request == PTRACE_SYSEMU) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_EMU);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		} else if (request == PTRACE_SYSVM) {
+			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
+			child->ptrace |= (addr & PTRACE_VM_MASK) << 28;
 		} else if (request == PTRACE_SYSCALL) {
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 			clear_tsk_thread_flag(child, TIF_SYSCALL_EMU);
@@ -690,6 +701,9 @@
 	if (!(current->ptrace & PT_PTRACED))
 		goto out;
 
+	if (entryexit && (current->ptrace & PT_VM_SKIPEXIT))
+		return 0;
+
 	/* If a process stops on the 1st tracepoint with SYSCALL_TRACE
 	 * and then is resumed with SYSEMU_SINGLESTEP, it will come in
 	 * here. We have to check this and return */
@@ -717,7 +731,7 @@
 		send_sig(current->exit_code, current, 1);
 		current->exit_code = 0;
 	}
-	ret = is_sysemu;
+	ret = (is_sysemu || (!entryexit && (current->ptrace & PT_VM_SKIPCALL)));
 out:
 	if (unlikely(current->audit_context) && !entryexit)
 		audit_syscall_entry(current, AUDIT_ARCH_I386, regs->orig_eax,
diff -Naur linux-2.6.17-rc1-access/arch/powerpc/kernel/entry_32.S linux-2.6.17-rc1-pmulti-ptvm/arch/powerpc/kernel/entry_32.S
--- linux-2.6.17-rc1-access/arch/powerpc/kernel/entry_32.S	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-pmulti-ptvm/arch/powerpc/kernel/entry_32.S	2006-04-03 11:30:53.000000000 +0200
@@ -279,6 +279,7 @@
 	stw	r0,_TRAP(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_syscall_trace_enter
+	mr	r10,r3
 	lwz	r0,GPR0(r1)	/* Restore original registers */
 	lwz	r3,GPR3(r1)
 	lwz	r4,GPR4(r1)
@@ -287,6 +288,8 @@
 	lwz	r7,GPR7(r1)
 	lwz	r8,GPR8(r1)
 	REST_NVGPRS(r1)
+	cmpwi	r10,0
+	bne-	ret_from_syscall
 	b	syscall_dotrace_cont
 
 syscall_exit_work:
diff -Naur linux-2.6.17-rc1-access/arch/powerpc/kernel/entry_64.S linux-2.6.17-rc1-pmulti-ptvm/arch/powerpc/kernel/entry_64.S
--- linux-2.6.17-rc1-access/arch/powerpc/kernel/entry_64.S	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-pmulti-ptvm/arch/powerpc/kernel/entry_64.S	2006-04-03 11:30:53.000000000 +0200
@@ -195,6 +195,7 @@
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_syscall_trace_enter
+	mr	r11,r3
 	ld	r0,GPR0(r1)	/* Restore original registers */
 	ld	r3,GPR3(r1)
 	ld	r4,GPR4(r1)
@@ -205,6 +206,8 @@
 	addi	r9,r1,STACK_FRAME_OVERHEAD
 	clrrdi	r10,r1,THREAD_SHIFT
 	ld	r10,TI_FLAGS(r10)
+	cmpwi	r11,0
+	bne-	syscall_exit
 	b	syscall_dotrace_cont
 
 syscall_enosys:
diff -Naur linux-2.6.17-rc1-access/arch/powerpc/kernel/ptrace.c linux-2.6.17-rc1-pmulti-ptvm/arch/powerpc/kernel/ptrace.c
--- linux-2.6.17-rc1-access/arch/powerpc/kernel/ptrace.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-pmulti-ptvm/arch/powerpc/kernel/ptrace.c	2006-04-03 11:30:53.000000000 +0200
@@ -338,15 +338,28 @@
 		break;
 	}
 
+	case PTRACE_SYSVM: 
+			     if (addr == PTRACE_VM_TEST) {
+				     ret = PTRACE_VM_MASK;
+				     break;
+			     }
+
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		ret = -EIO;
 		if (!valid_signal(data))
 			break;
-		if (request == PTRACE_SYSCALL)
-			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
-		else
+		child->ptrace &= ~PT_VM_MASK;
+		if (request == PTRACE_CONT)
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		else {
+			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			if (request == PTRACE_SYSVM) {
+				/* set PT_VM_SKIPCALL and PT_VM_SKIPEXIT by
+				 * one operation */
+				child->ptrace |= (addr & PTRACE_VM_MASK) << 28;
+			}
+		}
 		child->exit_code = data;
 		/* make sure the single step bit is not set. */
 		clear_single_step(child);
@@ -527,7 +540,7 @@
 	}
 }
 
-void do_syscall_trace_enter(struct pt_regs *regs)
+int do_syscall_trace_enter(struct pt_regs *regs)
 {
 #ifdef CONFIG_PPC64
 	secure_computing(regs->gpr[0]);
@@ -547,6 +560,7 @@
 				    regs->gpr[0],
 				    regs->gpr[3], regs->gpr[4],
 				    regs->gpr[5], regs->gpr[6]);
+	return (current->ptrace & PT_VM_SKIPCALL);
 }
 
 void do_syscall_trace_leave(struct pt_regs *regs)
@@ -562,7 +576,8 @@
 
 	if ((test_thread_flag(TIF_SYSCALL_TRACE)
 	     || test_thread_flag(TIF_SINGLESTEP))
-	    && (current->ptrace & PT_PTRACED))
+	    && (current->ptrace & PT_PTRACED) && 
+	    ((current->ptrace & PT_VM_SKIPEXIT)==0))
 		do_syscall_trace();
 }
 
diff -Naur linux-2.6.17-rc1-access/arch/ppc/kernel/entry.S linux-2.6.17-rc1-pmulti-ptvm/arch/ppc/kernel/entry.S
--- linux-2.6.17-rc1-access/arch/ppc/kernel/entry.S	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-pmulti-ptvm/arch/ppc/kernel/entry.S	2006-04-03 11:30:53.000000000 +0200
@@ -279,6 +279,7 @@
 	stw	r0,TRAP(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_syscall_trace_enter
+	mr	r10,r3
 	lwz	r0,GPR0(r1)	/* Restore original registers */
 	lwz	r3,GPR3(r1)
 	lwz	r4,GPR4(r1)
@@ -287,6 +288,8 @@
 	lwz	r7,GPR7(r1)
 	lwz	r8,GPR8(r1)
 	REST_NVGPRS(r1)
+	cmpwi	r10,0
+	bne-	ret_from_syscall
 	b	syscall_dotrace_cont
 
 syscall_exit_work:
diff -Naur linux-2.6.17-rc1-access/arch/um/drivers/ubd_kern.c linux-2.6.17-rc1-pmulti-ptvm/arch/um/drivers/ubd_kern.c
--- linux-2.6.17-rc1-access/arch/um/drivers/ubd_kern.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-pmulti-ptvm/arch/um/drivers/ubd_kern.c	2006-04-03 11:30:53.000000000 +0200
@@ -1064,6 +1064,7 @@
 				       "errno = %d\n", -n);
 		}
 	}
+	return 0;
 }
 
 static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
diff -Naur linux-2.6.17-rc1-access/arch/um/include/kern_util.h linux-2.6.17-rc1-pmulti-ptvm/arch/um/include/kern_util.h
--- linux-2.6.17-rc1-access/arch/um/include/kern_util.h	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-pmulti-ptvm/arch/um/include/kern_util.h	2006-04-03 11:30:53.000000000 +0200
@@ -70,7 +70,7 @@
 extern void paging_init(void);
 extern void init_flush_vm(void);
 extern void *syscall_sp(void *t);
-extern void syscall_trace(union uml_pt_regs *regs, int entryexit);
+extern int syscall_trace(union uml_pt_regs *regs, int entryexit);
 extern int hz(void);
 extern void uml_idle_timer(void);
 extern unsigned int do_IRQ(int irq, union uml_pt_regs *regs);
diff -Naur linux-2.6.17-rc1-access/arch/um/kernel/ptrace.c linux-2.6.17-rc1-pmulti-ptvm/arch/um/kernel/ptrace.c
--- linux-2.6.17-rc1-access/arch/um/kernel/ptrace.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-pmulti-ptvm/arch/um/kernel/ptrace.c	2006-04-03 11:30:53.000000000 +0200
@@ -82,6 +82,12 @@
                 ret = poke_user(child, addr, data);
                 break;
 
+	case PTRACE_SYSVM:
+		if (addr == PTRACE_VM_TEST) {
+			ret = PTRACE_VM_MASK;
+			break;
+		}
+
 	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
 	case PTRACE_CONT: { /* restart after signal. */
 		ret = -EIO;
@@ -89,11 +95,17 @@
 			break;
 
                 set_singlestepping(child, 0);
-		if (request == PTRACE_SYSCALL) {
-			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+		child->ptrace &= ~PT_VM_MASK;
+		if (request == PTRACE_CONT) {
+			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		}
 		else {
-			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+			if (request == PTRACE_SYSVM) {
+				/* set PT_VM_SKIPCALL and PT_VM_SKIPEXIT by
+				 * one operation */
+				child->ptrace |= (addr & PTRACE_VM_MASK) << 28;
+			} 
 		}
 		child->exit_code = data;
 		wake_up_process(child);
@@ -268,7 +280,7 @@
 /* XXX Check PT_DTRACE vs TIF_SINGLESTEP for singlestepping check and
  * PT_PTRACED vs TIF_SYSCALL_TRACE for syscall tracing check
  */
-void syscall_trace(union uml_pt_regs *regs, int entryexit)
+int syscall_trace(union uml_pt_regs *regs, int entryexit)
 {
 	int is_singlestep = (current->ptrace & PT_DTRACE) && entryexit;
 	int tracesysgood;
@@ -292,10 +304,13 @@
 		send_sigtrap(current, regs, 0);
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-		return;
+		return 0;
 
 	if (!(current->ptrace & PT_PTRACED))
-		return;
+		return 0;
+
+	if (entryexit && (current->ptrace & PT_VM_SKIPEXIT))
+		return 0;
 
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
@@ -313,4 +328,8 @@
 		send_sig(current->exit_code, current, 1);
 		current->exit_code = 0;
 	}
+	if (!entryexit && (current->ptrace & PT_VM_SKIPCALL))
+		return 1;
+	else
+		return 0;
 }
diff -Naur linux-2.6.17-rc1-access/arch/um/kernel/skas/syscall.c linux-2.6.17-rc1-pmulti-ptvm/arch/um/kernel/skas/syscall.c
--- linux-2.6.17-rc1-access/arch/um/kernel/skas/syscall.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-pmulti-ptvm/arch/um/kernel/skas/syscall.c	2006-04-03 11:30:53.000000000 +0200
@@ -18,12 +18,13 @@
 	struct pt_regs *regs = container_of(r, struct pt_regs, regs);
 	long result;
 	int syscall;
+	int skip_call;
 #ifdef UML_CONFIG_SYSCALL_DEBUG
   	int index;
 
   	index = record_syscall_start(UPT_SYSCALL_NR(r));
 #endif
-	syscall_trace(r, 0);
+	skip_call=syscall_trace(r, 0);
 
 	current->thread.nsyscalls++;
 	nsyscalls++;
@@ -36,12 +37,14 @@
 	 *     gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)
 	 * in case it's a compiler bug.
 	 */
+	if (skip_call == 0) {
 	syscall = UPT_SYSCALL_NR(r);
 	if((syscall >= NR_syscalls) || (syscall < 0))
 		result = -ENOSYS;
 	else result = EXECUTE_SYSCALL(syscall, regs);
 
 	REGS_SET_SYSCALL_RETURN(r->skas.regs, result);
+	}
 
 	syscall_trace(r, 1);
 #ifdef UML_CONFIG_SYSCALL_DEBUG
diff -Naur linux-2.6.17-rc1-access/arch/um/kernel/tt/syscall_kern.c linux-2.6.17-rc1-pmulti-ptvm/arch/um/kernel/tt/syscall_kern.c
--- linux-2.6.17-rc1-access/arch/um/kernel/tt/syscall_kern.c	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-pmulti-ptvm/arch/um/kernel/tt/syscall_kern.c	2006-04-03 11:30:53.000000000 +0200
@@ -21,6 +21,7 @@
 	void *sc;
 	long result;
 	int syscall;
+	int skip_call;
 #ifdef CONFIG_SYSCALL_DEBUG
 	int index;
 #endif
@@ -33,11 +34,13 @@
 	index = record_syscall_start(syscall);
 #endif
 
-	syscall_trace(&regs->regs, 0);
+	skip_call=syscall_trace(&regs->regs, 0);
 
 	current->thread.nsyscalls++;
 	nsyscalls++;
 
+	if (skip_call == 0) {
+			
 	if((syscall >= NR_syscalls) || (syscall < 0))
 		result = -ENOSYS;
 	else result = EXECUTE_SYSCALL(syscall, regs);
@@ -49,6 +52,7 @@
 
 	SC_SET_SYSCALL_RETURN(sc, result);
 
+	}
 	syscall_trace(&regs->regs, 1);
 #ifdef CONFIG_SYSCALL_DEBUG
   	record_syscall_end(index, result);
diff -Naur linux-2.6.17-rc1-access/include/linux/ptrace.h linux-2.6.17-rc1-pmulti-ptvm/include/linux/ptrace.h
--- linux-2.6.17-rc1-access/include/linux/ptrace.h	2006-04-05 10:23:15.000000000 +0200
+++ linux-2.6.17-rc1-pmulti-ptvm/include/linux/ptrace.h	2006-04-04 08:59:36.000000000 +0200
@@ -1,6 +1,7 @@
 #ifndef _LINUX_PTRACE_H
 #define _LINUX_PTRACE_H
 /* ptrace.h */
+#include <linux/config.h>
 /* structs and defines to help the user use the ptrace system call. */
 
 /* has the defines to get at the registers. */
@@ -20,6 +21,7 @@
 #define PTRACE_DETACH		0x11
 
 #define PTRACE_SYSCALL		  24
+#define PTRACE_SYSVM		33
 
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
@@ -32,6 +34,10 @@
 #define PTRACE_POKECHARDATA     0x4302
 #define PTRACE_PEEKSTRINGDATA   0x4303
 
+#ifdef CONFIG_VIEWOS
+#define PTRACE_VIEWOS		0x4000
+#endif
+
 struct ptrace_multi {
 	long request;
 	long addr;
@@ -58,6 +64,18 @@
 #define PTRACE_EVENT_VFORK_DONE	5
 #define PTRACE_EVENT_EXIT	6
 
+/* options for PTRACE_SYSVM */
+#define PTRACE_VM_TEST		0x80000000
+#define PTRACE_VM_SKIPCALL	1
+#define PTRACE_VM_SKIPEXIT	2
+#define PTRACE_VM_MASK		0x00000003
+
+#ifdef CONFIG_VIEWOS
+/* options fpr PTRACE_VIEWOS */
+#define PT_VIEWOS_TEST		0x80000000
+#define PT_VIEWOS_MASK		0x00000000
+#endif
+
 #include <asm/ptrace.h>
 
 #ifdef __KERNEL__
@@ -77,6 +95,10 @@
 #define PT_TRACE_EXIT	0x00000200
 #define PT_ATTACHED	0x00000400	/* parent != real_parent */
 
+#define PT_VM_SKIPCALL  0x10000000
+#define PT_VM_SKIPEXIT  0x20000000
+#define PT_VM_MASK      0x30000000
+
 #define PT_TRACE_MASK	0x000003f4
 
 /* single stepping state bits (used on ARM and PA-RISC) */
diff -Naur linux-2.6.17-rc1-access/init/Kconfig linux-2.6.17-rc1-pmulti-ptvm/init/Kconfig
--- linux-2.6.17-rc1-access/init/Kconfig	2006-04-03 05:22:10.000000000 +0200
+++ linux-2.6.17-rc1-pmulti-ptvm/init/Kconfig	2006-04-03 11:30:53.000000000 +0200
@@ -225,6 +225,13 @@
 
 	  If unsure, say N.
 
+config VIEWOS
+	bool "ViewOS Support (EXPERIMENTAL)"
+	help
+	  This option will enable kernel support for ViewOS partial virtualization.
+
+	  Say N if unsure.
+
 source "usr/Kconfig"
 
 config UID16
diff -Naur linux-2.6.17-rc1-access/kernel/ptrace.c linux-2.6.17-rc1-pmulti-ptvm/kernel/ptrace.c
--- linux-2.6.17-rc1-access/kernel/ptrace.c	2006-04-05 10:23:15.000000000 +0200
+++ linux-2.6.17-rc1-pmulti-ptvm/kernel/ptrace.c	2006-04-03 11:30:53.000000000 +0200
@@ -310,7 +310,7 @@
 			if (string) {
 				for (offset=0;offset<bytes;offset++)
 					if (buf[offset]==0)
-						break;
+				break;
 				if (offset < bytes)
 					bytes=len=offset+1;
 		}
@@ -595,3 +595,7 @@
 	return ret;
 }
 #endif /* __ARCH_SYS_PTRACE */
+
+#ifdef CONFIG_VIEWOS
+#warning VIEWOS support not implemented yet
+#endif
