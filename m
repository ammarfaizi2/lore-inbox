Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWH3XWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWH3XWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751636AbWH3XWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:22:18 -0400
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:21694 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1751629AbWH3XWR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:22:17 -0400
Date: Wed, 30 Aug 2006 19:22:14 -0400
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>
Cc: ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: [PATCH 9/16] LTTng : Linux Trace Toolkit Next Generation 0.5.95, kernel 2.6.17
Message-ID: <20060830232214.GJ17079@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_Krystal-15661-1156980134-0001-2"
Content-Disposition: inline
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 19:18:38 up 7 days, 20:27,  9 users,  load average: 1.03, 0.66, 0.38
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_Krystal-15661-1156980134-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

9- LTTng architecture dependant instrumentation : ARM
patch-2.6.17-lttng-0.5.95-instrumentation-arm.diff

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 

--=_Krystal-15661-1156980134-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch-2.6.17-lttng-0.5.95-instrumentation-arm.diff"

--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -21,6 +21,11 @@ #include "entry-header.S"
  * stack.
  */
 ret_fast_syscall:
+#ifdef CONFIG_LTT
+	mov r7, r0				@ save returned r0
+	bl  trace_real_syscall_exit
+	mov r0, r7
+#endif
 	disable_irq				@ disable interrupts
 	ldr	r1, [tsk, #TI_FLAGS]
 	tst	r1, #_TIF_WORK_MASK
@@ -178,6 +183,19 @@ #ifdef CONFIG_ALIGNMENT_TRAP
 	mcr	p15, 0, ip, c1, c0		@ update control register
 #endif
 	enable_irq
+#ifdef CONFIG_LTT
+
+	mov	r0, scno		@ syscall number
+	tst	r0, #0x000f0000		@ Is this an ARM specific syscall
+	orrne	r0, r0, #0x400		@ if so offset the number by 1024
+	bic     r0, r0, #0xff000000	@ mask off SWI op-code and other syscall offsets
+	bic     r0, r0, #0x00ff0000
+
+	add	r1, sp, #S_R0		@ pointer to regs
+	bl	trace_real_syscall_entry
+	add	r1, sp, #S_R0		@ pointer to regs
+	ldmia	r1, {r0 - r3}		@ have to reload r0 - r3
+#endif
 
 	get_thread_info tsk
 	adr	tbl, sys_call_table		@ load syscall table pointer
@@ -233,6 +251,9 @@ __sys_trace:
 
 __sys_trace_return:
 	str	r0, [sp, #S_R0 + S_OFF]!	@ save returned r0
+#ifdef CONFIG_LTT
+	bl	trace_real_syscall_exit
+#endif
 	mov	r2, scno
 	mov	r1, sp
 	mov	r0, #1				@ trace exit [IP = 1]
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 2d5896b..984ea6e 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -1,13 +1,13 @@
 /*
- *  linux/arch/arm/kernel/calls.S
+ *	linux/arch/arm/kernel/calls.S
  *
- *  Copyright (C) 1995-2005 Russell King
+ *	Copyright (C) 1995-2005 Russell King
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- *  This file is included thrice in entry-common.S
+ *	This file is included thrice in entry-common.S
  */
 /* 0 */		CALL(sys_restart_syscall)
 		CALL(sys_exit)
@@ -331,6 +331,8 @@
 		CALL(sys_mbind)
 /* 320 */	CALL(sys_get_mempolicy)
 		CALL(sys_set_mempolicy)
+		CALL(sys_ltt_trace_generic)
+		CALL(sys_ltt_register_generic)
 #ifndef syscalls_counted
 .equ syscalls_padding, ((NR_syscalls + 3) & ~3) - NR_syscalls
 #define syscalls_counted
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index dbcb11a..bd5c326 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -35,6 +35,8 @@ #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/errno.h>
 #include <linux/list.h>
+#include <linux/ltt/ltt-facility-kernel.h>
+#include <linux/ltt/ltt-facility-statedump.h>
 #include <linux/kallsyms.h>
 #include <linux/proc_fs.h>
 
@@ -225,6 +227,24 @@ void disable_irq_wake(unsigned int irq)
 }
 EXPORT_SYMBOL(disable_irq_wake);
 
+/* Defined here because of dependency on statically-defined lock & irq_desc */
+int ltt_enumerate_interrupts(void)
+{
+	unsigned int i;
+	unsigned long flags = 0;
+
+	for(i=0; i<NR_IRQS; i++) {
+		struct irqaction * action;
+		spin_lock_irqsave(&irq_controller_lock, flags);
+		for (action=irq_desc[i].action; action; action = action->next)
+			trace_statedump_enumerate_interrupts(
+							"", action->name, i);
+		spin_unlock_irqrestore(&irq_controller_lock, flags);
+	}
+	return 0;
+}
+EXPORT_SYMBOL(ltt_enumerate_interrupts);
+
 int show_interrupts(struct seq_file *p, void *v)
 {
 	int i = *(loff_t *) v, cpu;
@@ -542,6 +562,8 @@ asmlinkage void asm_do_IRQ(unsigned int 
 {
 	struct irqdesc *desc = irq_desc + irq;
 
+	trace_kernel_irq_entry(irq, !(user_mode(regs)));
+
 	/*
 	 * Some hardware gives randomly wrong interrupts.  Rather
 	 * than crashing, do something sensible.
@@ -563,6 +585,8 @@ asmlinkage void asm_do_IRQ(unsigned int 
 
 	spin_unlock(&irq_controller_lock);
 	irq_exit();
+
+	trace_kernel_irq_exit();
 }
 
 void __set_irq_handler(unsigned int irq, irq_handler_t handle, int is_chained)
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 7df6e1a..2c21dec 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -28,6 +28,7 @@ #include <linux/kallsyms.h>
 #include <linux/init.h>
 #include <linux/cpu.h>
 #include <linux/elfcore.h>
+#include <linux/ltt/ltt-facility-process.h>
 
 #include <asm/leds.h>
 #include <asm/processor.h>
@@ -452,6 +453,7 @@ asm(	".section .text\n"
 pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags)
 {
 	struct pt_regs regs;
+	long pid;
 
 	memset(&regs, 0, sizeof(regs));
 
@@ -461,7 +463,12 @@ pid_t kernel_thread(int (*fn)(void *), v
 	regs.ARM_pc = (unsigned long)kernel_thread_helper;
 	regs.ARM_cpsr = SVC_MODE;
 
-	return do_fork(flags|CLONE_VM|CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
+	pid = do_fork(flags|CLONE_VM|CLONE_UNTRACED, 0, &regs, 0, NULL, NULL);
+#ifdef CONFIG_LTT
+	if(pid >= 0)
+		trace_process_kernel_thread(pid, fn);
+#endif
+	return pid;
 }
 EXPORT_SYMBOL(kernel_thread);
 
diff --git a/arch/arm/kernel/sys_arm.c b/arch/arm/kernel/sys_arm.c
index 8170af4..bfa24f4 100644
--- a/arch/arm/kernel/sys_arm.c
+++ b/arch/arm/kernel/sys_arm.c
@@ -26,6 +26,7 @@ #include <linux/mman.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/utsname.h>
+#include <linux/ltt/ltt-facility-ipc.h>
 
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
@@ -161,6 +162,8 @@ asmlinkage int sys_ipc(uint call, int fi
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;
 
+	trace_ipc_call(call, first);
+
 	switch (call) {
 	case SEMOP:
 		return sys_semtimedop (first, (struct sembuf __user *)ptr, second, NULL);
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index d6bd435..c0a9e16 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -32,6 +32,7 @@ #include <linux/timer.h>
 #include <asm/leds.h>
 #include <asm/thread_info.h>
 #include <asm/mach/time.h>
+#include <asm/ltt.h>
 
 /*
  * Our system timer.
@@ -335,6 +336,9 @@ void timer_tick(struct pt_regs *regs)
 	do_leds();
 	do_set_rtc();
 	do_timer(regs);
+#ifdef CONFIG_LTT
+	ltt_reset_timestamp();
+#endif
 #ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 35230a0..c045394 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -21,6 +21,8 @@ #include <linux/ptrace.h>
 #include <linux/kallsyms.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/ltt/ltt-facility-kernel.h>
+#include <linux/ltt-core.h>
 
 #include <asm/atomic.h>
 #include <asm/cacheflush.h>
@@ -28,6 +30,7 @@ #include <asm/system.h>
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
 #include <asm/traps.h>
+#include <asm/ltt/ltt-facility-kernel_arch_arm.h>
 
 #include "ptrace.h"
 #include "signal.h"
@@ -198,6 +201,20 @@ void show_stack(struct task_struct *tsk,
 	barrier();
 }
 
+#ifdef CONFIG_LTT
+asmlinkage void trace_real_syscall_entry(int scno, struct pt_regs * regs)
+{
+	void *address = (void *) instruction_pointer(regs);
+
+	trace_kernel_arch_syscall_entry((enum lttng_syscall_name)scno, address);
+}
+
+asmlinkage void trace_real_syscall_exit(void)
+{
+	trace_kernel_arch_syscall_exit();
+}
+#endif /* CONFIG_LTT */
+
 static void __die(const char *str, int err, struct thread_info *thread, struct pt_regs *regs)
 {
 	struct task_struct *tsk = thread->task;
@@ -249,7 +266,12 @@ void notify_die(const char *str, struct 
 		current->thread.error_code = err;
 		current->thread.trap_no = trap;
 
+		trace_kernel_trap_entry(current->thread.trap_no, (void*)info->si_addr);		
+		
 		force_sig_info(info->si_signo, info, current);
+
+		trace_kernel_trap_exit();
+		
 	} else {
 		die(str, regs, err);
 	}
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 8dfa305..4297838 100644

--=_Krystal-15661-1156980134-0001-2--
