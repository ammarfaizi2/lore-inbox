Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276470AbSIVFkb>; Sun, 22 Sep 2002 01:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276430AbSIVFjr>; Sun, 22 Sep 2002 01:39:47 -0400
Received: from nameservices.net ([208.234.25.16]:43975 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S276470AbSIVFg4>;
	Sun, 22 Sep 2002 01:36:56 -0400
Message-ID: <3D8D58E0.2E7CD4D6@opersys.com>
Date: Sun, 22 Sep 2002 01:45:04 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
CC: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] LTT for 2.5.38 9/9: ARM trace support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds ARM trace support. Syscall slow path trace not
yet added.

Here are the file modifications:
 arch/arm/config.in             |    2
 arch/arm/kernel/entry-common.S |   18 ++++++++
 arch/arm/kernel/irq.c          |    5 ++
 arch/arm/kernel/process.c      |    5 ++
 arch/arm/kernel/sys_arm.c      |    3 +
 arch/arm/kernel/traps.c        |   85 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/fault-common.c     |   15 +++++--
 include/asm-arm/trace.h        |   15 +++++++
 8 files changed, 145 insertions, 3 deletions    

diff -urpN linux-2.5.38/arch/arm/config.in linux-2.5.38-ltt/arch/arm/config.in
--- linux-2.5.38/arch/arm/config.in	Sun Sep 22 00:25:03 2002
+++ linux-2.5.38-ltt/arch/arm/config.in	Sun Sep 22 00:51:51 2002
@@ -655,6 +655,8 @@ source drivers/usb/Config.in
 
 source net/bluetooth/Config.in
 
+source drivers/trace/Config.in
+
 mainmenu_option next_comment
 comment 'Kernel hacking'
 
diff -urpN linux-2.5.38/arch/arm/kernel/entry-common.S linux-2.5.38-ltt/arch/arm/kernel/entry-common.S
--- linux-2.5.38/arch/arm/kernel/entry-common.S	Sun Sep 22 00:24:58 2002
+++ linux-2.5.38-ltt/arch/arm/kernel/entry-common.S	Sun Sep 22 00:51:51 2002
@@ -35,6 +35,11 @@ ENTRY(__do_softirq)
  * stack.
  */
 ret_fast_syscall:
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
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
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
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
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+	bl	SYMBOL_NAME(trace_real_syscall_exit)
+#endif
 	mov	r1, sp
 	mov	r0, #1				@ trace exit [IP = 1]
 	bl	syscall_trace
diff -urpN linux-2.5.38/arch/arm/kernel/irq.c linux-2.5.38-ltt/arch/arm/kernel/irq.c
--- linux-2.5.38/arch/arm/kernel/irq.c	Sun Sep 22 00:24:57 2002
+++ linux-2.5.38-ltt/arch/arm/kernel/irq.c	Sun Sep 22 00:51:51 2002
@@ -30,6 +30,7 @@
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/errno.h>
+#include <linux/trace.h>
 
 #include <asm/irq.h>
 #include <asm/system.h>
@@ -338,6 +339,8 @@ asmlinkage void asm_do_IRQ(int irq, stru
 {
 	struct irqdesc *desc = irq_desc + irq;
 
+	TRACE_IRQ_ENTRY(irq, !(user_mode(regs)));
+
 	/*
 	 * Some hardware gives randomly wrong interrupts.  Rather
 	 * than crashing, do something sensible.
@@ -348,6 +351,8 @@ asmlinkage void asm_do_IRQ(int irq, stru
 	spin_lock(&irq_controller_lock);
 	desc->handle(irq, desc, regs);
 	spin_unlock(&irq_controller_lock);
+
+	TRACE_IRQ_EXIT();
 
 	if (softirq_pending(smp_processor_id()))
 		do_softirq();
diff -urpN linux-2.5.38/arch/arm/kernel/process.c linux-2.5.38-ltt/arch/arm/kernel/process.c
--- linux-2.5.38/arch/arm/kernel/process.c	Sun Sep 22 00:25:18 2002
+++ linux-2.5.38-ltt/arch/arm/kernel/process.c	Sun Sep 22 00:51:51 2002
@@ -24,6 +24,7 @@
 #include <linux/reboot.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/trace.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -398,6 +399,10 @@ pid_t kernel_thread(int (*fn)(void *), v
         : "=r" (__ret)
         : "Ir" (flags), "I" (CLONE_VM), "r" (fn), "r" (arg)
 	: "r0", "r1", "lr");
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
+	if (__ret > 0)
+		TRACE_PROCESS(TRACE_EV_PROCESS_KTHREAD, __ret, (int) fn);
+#endif
 	return __ret;
 }
 
diff -urpN linux-2.5.38/arch/arm/kernel/sys_arm.c linux-2.5.38-ltt/arch/arm/kernel/sys_arm.c
--- linux-2.5.38/arch/arm/kernel/sys_arm.c	Sun Sep 22 00:25:03 2002
+++ linux-2.5.38-ltt/arch/arm/kernel/sys_arm.c	Sun Sep 22 00:51:51 2002
@@ -24,6 +24,7 @@
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/utsname.h>
+#include <linux/trace.h>
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
@@ -166,6 +167,8 @@ asmlinkage int sys_ipc (uint call, int f
 
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
+
+	TRACE_IPC(TRACE_EV_IPC_CALL, call, first);
 
 	switch (call) {
 	case SEMOP:
diff -urpN linux-2.5.38/arch/arm/kernel/traps.c linux-2.5.38-ltt/arch/arm/kernel/traps.c
--- linux-2.5.38/arch/arm/kernel/traps.c	Sun Sep 22 00:25:08 2002
+++ linux-2.5.38-ltt/arch/arm/kernel/traps.c	Sun Sep 22 00:51:51 2002
@@ -24,6 +24,7 @@
 #include <linux/elf.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/trace.h>
 
 #include <asm/atomic.h>
 #include <asm/io.h>
@@ -174,6 +175,72 @@ void show_trace_task(struct task_struct 
 	}
 }
 
+#if (CONFIG_TRACE || CONFIG_TRACE_MODULE)
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
+#endif /* (CONFIG_TRACE || CONFIG_TRACE_MODULE) */
+
 spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
 
 /*
@@ -236,8 +303,12 @@ asmlinkage void do_undefinstr(struct pt_
 	info.si_code  = ILL_ILLOPC;
 	info.si_addr  = pc;
 
+	TRACE_TRAP_ENTRY(current->thread.trap_no, (uint32_t)pc);
+
 	force_sig_info(SIGILL, &info, current);
 
+	TRACE_TRAP_EXIT();
+
 	die_if_kernel("Oops - undefined instruction", regs, 0);
 }
 
@@ -260,8 +331,12 @@ asmlinkage void do_excpt(unsigned long a
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
@@ -441,7 +516,12 @@ asmlinkage int arm_syscall(int no, struc
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
@@ -475,7 +555,12 @@ baddataabort(int code, unsigned long ins
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
 
diff -urpN linux-2.5.38/arch/arm/mm/fault-common.c linux-2.5.38-ltt/arch/arm/mm/fault-common.c
--- linux-2.5.38/arch/arm/mm/fault-common.c	Sun Sep 22 00:24:59 2002
+++ linux-2.5.38-ltt/arch/arm/mm/fault-common.c	Sun Sep 22 00:51:51 2002
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
 
diff -urpN linux-2.5.38/include/asm-arm/trace.h linux-2.5.38-ltt/include/asm-arm/trace.h
--- linux-2.5.38/include/asm-arm/trace.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.38-ltt/include/asm-arm/trace.h	Sun Sep 22 00:51:51 2002
@@ -0,0 +1,15 @@
+/*
+ * linux/include/asm-arm/trace.h
+ *
+ * Copyright (C) 2002, Karim Yaghmour
+ *
+ * ARM definitions for tracing system
+ */
+
+#include <linux/trace.h>
+
+/* Current arch type */
+#define TRACE_ARCH_TYPE TRACE_ARCH_TYPE_ARM
+
+/* Current variant type */
+#define TRACE_ARCH_VARIANT TRACE_ARCH_VARIANT_NONE
