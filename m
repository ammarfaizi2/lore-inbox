Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265165AbSJaD1w>; Wed, 30 Oct 2002 22:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265171AbSJaD1N>; Wed, 30 Oct 2002 22:27:13 -0500
Received: from nameservices.net ([208.234.25.16]:11185 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S265166AbSJaDVR>;
	Wed, 30 Oct 2002 22:21:17 -0500
Message-ID: <3DC0A42F.4D18656B@opersys.com>
Date: Wed, 30 Oct 2002 22:31:59 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] LTT for 2.5.44 10/10: ARM trace support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


D: This patch adds the bare-minimum ARM-specific low-level trace
D: statements.

diffstat:
 arch/arm/kernel/entry-common.S |   18 ++++++++
 arch/arm/kernel/irq.c          |    5 ++
 arch/arm/kernel/process.c      |    5 ++
 arch/arm/kernel/sys_arm.c      |    3 +
 arch/arm/kernel/traps.c        |   85 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/fault-common.c     |   15 +++++--
 include/asm-arm/trace.h        |   16 +++++++
 7 files changed, 144 insertions(+), 3 deletions(-)

diff -urpN linux-2.5.45/arch/arm/kernel/entry-common.S linux-2.5.45-ltt/arch/arm/kernel/entry-common.S
--- linux-2.5.45/arch/arm/kernel/entry-common.S	Wed Oct 30 19:41:34 2002
+++ linux-2.5.45-ltt/arch/arm/kernel/entry-common.S	Wed Oct 30 20:51:08 2002
@@ -35,6 +35,11 @@ ENTRY(__do_softirq)
  * stack.
  */
 ret_fast_syscall:
+#if (CONFIG_TRACE)
+	mov	r7, r0				@ save returned r0
+	bl	SYMBOL_NAME(trace_real_syscall_exit)
+	mov	r0, r7
+#endif
 	disable_irq r1				@ disable interrupts
 	ldr	r1, [tsk, #TI_FLAGS]
 	tst	r1, #_TIF_WORK_MASK
@@ -134,6 +139,16 @@ ENTRY(vector_swi)
 	mcr	p15, 0, ip, c1, c0		@ update control register
 #endif
 	enable_irq ip
+#if (CONFIG_TRACE)
+	/* zzz note that validity of scno is not yet checked.
+	 * zzz The visualizer checks it.
+	 */
+	add	r1, sp, #S_R0			@ pointer to regs
+	mov	r0, scno  		        @ syscall number
+	bl	SYMBOL_NAME(trace_real_syscall_entry)
+	add	r1, sp, #S_R0			@ pointer to regs
+	ldmia	r1, {r0 - r3}			@ have to reload r0 - r3
+#endif
 
 	str	r4, [sp, #-S_OFF]!		@ push fifth arg
 
@@ -174,6 +189,9 @@ __sys_trace:
 
 __sys_trace_return:
 	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
+#if (CONFIG_TRACE)
+	bl	SYMBOL_NAME(trace_real_syscall_exit)
+#endif
 	mov	r1, sp
 	mov	r0, #1				@ trace exit [IP = 1]
 	bl	syscall_trace
diff -urpN linux-2.5.45/arch/arm/kernel/irq.c linux-2.5.45-ltt/arch/arm/kernel/irq.c
--- linux-2.5.45/arch/arm/kernel/irq.c	Wed Oct 30 19:41:31 2002
+++ linux-2.5.45-ltt/arch/arm/kernel/irq.c	Wed Oct 30 20:51:08 2002
@@ -30,6 +30,7 @@
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/errno.h>
+#include <linux/trace.h>
 
 #include <asm/irq.h>
 #include <asm/system.h>
@@ -330,6 +331,8 @@ asmlinkage void asm_do_IRQ(int irq, stru
 {
 	struct irqdesc *desc = irq_desc + irq;
 
+	TRACE_IRQ_ENTRY(irq, !(user_mode(regs)));
+
 	/*
 	 * Some hardware gives randomly wrong interrupts.  Rather
 	 * than crashing, do something sensible.
@@ -342,6 +345,8 @@ asmlinkage void asm_do_IRQ(int irq, stru
 	desc->handle(irq, desc, regs);
 	spin_unlock(&irq_controller_lock);
 	irq_exit();
+
+	TRACE_IRQ_EXIT();
 }
 
 void __set_irq_handler(unsigned int irq, irq_handler_t handle, int is_chained)
diff -urpN linux-2.5.45/arch/arm/kernel/process.c linux-2.5.45-ltt/arch/arm/kernel/process.c
--- linux-2.5.45/arch/arm/kernel/process.c	Wed Oct 30 19:43:40 2002
+++ linux-2.5.45-ltt/arch/arm/kernel/process.c	Wed Oct 30 20:51:08 2002
@@ -24,6 +24,7 @@
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/trace.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -405,6 +406,10 @@ pid_t kernel_thread(int (*fn)(void *), v
         : "=r" (__ret)
         : "Ir" (flags), "I" (CLONE_VM), "r" (fn), "r" (arg)
 	: "r0", "r1", "lr");
+#if (CONFIG_TRACE)
+	if (__ret > 0)
+		TRACE_PROCESS(TRACE_EV_PROCESS_KTHREAD, __ret, (int) fn);
+#endif
 	return __ret;
 }
 
diff -urpN linux-2.5.45/arch/arm/kernel/sys_arm.c linux-2.5.45-ltt/arch/arm/kernel/sys_arm.c
--- linux-2.5.45/arch/arm/kernel/sys_arm.c	Wed Oct 30 19:42:19 2002
+++ linux-2.5.45-ltt/arch/arm/kernel/sys_arm.c	Wed Oct 30 20:51:08 2002
@@ -24,6 +24,7 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/utsname.h>
+#include <linux/trace.h>
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
@@ -167,6 +168,8 @@ asmlinkage int sys_ipc (uint call, int f
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
 
+	TRACE_IPC(TRACE_EV_IPC_CALL, call, first);
+
 	switch (call) {
 	case SEMOP:
 		return sys_semop (first, (struct sembuf *)ptr, second);
diff -urpN linux-2.5.45/arch/arm/kernel/traps.c linux-2.5.45-ltt/arch/arm/kernel/traps.c
--- linux-2.5.45/arch/arm/kernel/traps.c	Wed Oct 30 19:42:30 2002
+++ linux-2.5.45-ltt/arch/arm/kernel/traps.c	Wed Oct 30 20:51:08 2002
@@ -24,6 +24,7 @@
 #include <linux/elf.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/trace.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -179,6 +180,72 @@ void show_trace_task(struct task_struct 
 	c_backtrace(fp, 0x10);
 }
 
+#if (CONFIG_TRACE)
+asmlinkage void trace_real_syscall_entry(int scno,struct pt_regs * regs)
+{
+	int			depth = 0;
+	unsigned long           end_code;
+	unsigned long		*fp;			/* frame pointer */
+	unsigned long		lower_bound;
+	unsigned long		lr;			/* link register */
+	unsigned long		*prev_fp;
+	int			seek_depth;
+	unsigned long           start_code;
+	unsigned long           *start_stack;
+	trace_syscall_entry	trace_syscall_event;
+	unsigned long		upper_bound;
+	int			use_bounds;
+	int			use_depth;
+
+	trace_syscall_event.syscall_id = (uint8_t)scno;
+	trace_syscall_event.address    = instruction_pointer(regs);
+	
+	if (! (user_mode(regs) ))
+		goto trace_syscall_end;
+
+	if (trace_get_config(&use_depth,
+			     &use_bounds,
+			     &seek_depth,
+			     (void*)&lower_bound,
+			     (void*)&upper_bound) < 0)
+		goto trace_syscall_end;
+
+	if ((use_depth == 1) || (use_bounds == 1)) {
+		fp          = (unsigned long *)regs->ARM_fp;
+		end_code    = current->mm->end_code;
+		start_code  = current->mm->start_code;
+		start_stack = (unsigned long *)current->mm->start_stack;
+
+		while (!__get_user(lr, (unsigned long *)(fp - 1))) {
+			if ((lr > start_code) && (lr < end_code)) {
+				if (((use_depth == 1) && (depth >= seek_depth)) ||
+				    ((use_bounds == 1) && (lr > lower_bound) && (lr < upper_bound))) {
+					trace_syscall_event.address = lr;
+					goto trace_syscall_end;
+				} else {
+					depth++;
+				}
+			}
+
+			if ((__get_user((unsigned long)prev_fp, (fp - 3))) ||
+			    (prev_fp > start_stack) ||
+			    (prev_fp <= fp)) {
+				goto trace_syscall_end;
+			}
+			fp = prev_fp;
+		}
+	}
+
+trace_syscall_end:
+	trace_event(TRACE_EV_SYSCALL_ENTRY, &trace_syscall_event);
+}
+
+asmlinkage void trace_real_syscall_exit(void)
+{
+        trace_event(TRACE_EV_SYSCALL_EXIT, NULL);
+}
+#endif /* (CONFIG_TRACE) */
+
 spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
 
 /*
@@ -241,8 +308,12 @@ asmlinkage void do_undefinstr(struct pt_
 	info.si_code  = ILL_ILLOPC;
 	info.si_addr  = pc;
 
+	TRACE_TRAP_ENTRY(current->thread.trap_no, (uint32_t)pc);
+
 	force_sig_info(SIGILL, &info, current);
 
+	TRACE_TRAP_EXIT();
+
 	die_if_kernel("Oops - undefined instruction", regs, 0);
 }
 
@@ -265,8 +336,12 @@ asmlinkage void do_excpt(unsigned long a
 	info.si_code  = BUS_ADRERR;
 	info.si_addr  = (void *)address;
 
+	TRACE_TRAP_ENTRY(current->thread.trap_no, instruction_pointer(regs));
+
 	force_sig_info(SIGBUS, &info, current);
 
+	TRACE_TRAP_EXIT();
+
 	die_if_kernel("Oops - address exception", regs, mode);
 }
 #endif
@@ -446,7 +521,12 @@ asmlinkage int arm_syscall(int no, struc
 	info.si_addr  = (void *)instruction_pointer(regs) -
 			 (thumb_mode(regs) ? 2 : 4);
 
+       	TRACE_TRAP_ENTRY(1, (uint32_t)info.si_addr);	/* debug */
+
 	force_sig_info(SIGILL, &info, current);
+
+	TRACE_TRAP_EXIT();
+
 	die_if_kernel("Oops", regs, no);
 	return 0;
 }
@@ -480,7 +560,12 @@ baddataabort(int code, unsigned long ins
 	info.si_code  = ILL_ILLOPC;
 	info.si_addr  = (void *)addr;
 
+	TRACE_TRAP_ENTRY(18, addr);	/* machine check */
+
 	force_sig_info(SIGILL, &info, current);
+
+	TRACE_TRAP_EXIT();
+
 	die_if_kernel("unknown data abort code", regs, instr);
 }
 
diff -urpN linux-2.5.45/arch/arm/mm/fault-common.c linux-2.5.45-ltt/arch/arm/mm/fault-common.c
--- linux-2.5.45/arch/arm/mm/fault-common.c	Wed Oct 30 19:43:00 2002
+++ linux-2.5.45-ltt/arch/arm/mm/fault-common.c	Wed Oct 30 20:51:08 2002
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
+#include <linux/trace.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -253,6 +254,8 @@ int do_page_fault(unsigned long addr, un
 	if (in_interrupt() || !mm)
 		goto no_context;
 
+	TRACE_TRAP_ENTRY(14, instruction_pointer(regs));
+
 	down_read(&mm->mmap_sem);
 	fault = __do_page_fault(mm, addr, fsr, tsk);
 	up_read(&mm->mmap_sem);
@@ -260,8 +263,10 @@ int do_page_fault(unsigned long addr, un
 	/*
 	 * Handle the "normal" case first
 	 */
-	if (fault > 0)
-		return 0;
+	if (fault > 0) {
+		TRACE_TRAP_EXIT();
+ 		return 0;
+	}
 
 	/*
 	 * We had some memory, but were unable to
@@ -287,6 +292,7 @@ int do_page_fault(unsigned long addr, un
 	} else
 		__do_user_fault(tsk, addr, fsr, fault == -1 ?
 				SEGV_ACCERR : SEGV_MAPERR, regs);
+	TRACE_TRAP_EXIT();
 	return 0;
 
 
@@ -309,11 +315,14 @@ do_sigbus:
 #endif
 
 	/* Kernel mode? Handle exceptions or die */
-	if (user_mode(regs))
+	if (user_mode(regs)) {
+		TRACE_TRAP_EXIT();
 		return 0;
+	}
 
 no_context:
 	__do_kernel_fault(mm, addr, fsr, regs);
+	TRACE_TRAP_EXIT();
 	return 0;
 }
 
diff -urpN linux-2.5.45/include/asm-arm/trace.h linux-2.5.45-ltt/include/asm-arm/trace.h
--- linux-2.5.45/include/asm-arm/trace.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.45-ltt/include/asm-arm/trace.h	Wed Oct 30 20:51:13 2002
@@ -0,0 +1,16 @@
+/*
+ * linux/include/asm-arm/trace.h
+ *
+ * Copyright (C) 2002, Karim Yaghmour
+ *
+ * ARM definitions for tracing system
+ */
+
+#include <linux/trace.h>
+#include <asm-generic/trace.h>
+
+/* Current arch type */
+#define TRACE_ARCH_TYPE TRACE_ARCH_TYPE_ARM
+
+/* Current variant type */
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_NONE
