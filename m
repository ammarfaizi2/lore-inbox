Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbVFHHLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVFHHLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 03:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbVFHHLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 03:11:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31472 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262127AbVFHHIt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 03:08:49 -0400
Subject: [PATCH] local_irq_disable removal
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: linux-kernel@vger.kernel.org
Cc: mingo@elte.hu, sdietrich@mvista.com
Content-Type: text/plain
Organization: MontaVista
Date: Wed, 08 Jun 2005 00:08:38 -0700
Message-Id: <1118214519.4759.17.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduction:

        The current Real-Time patch from Ingo Molnar significantly
modifies several kernel subsystems. One such system is the 
interrupt handling system. With the current Real Time Linux kernel,
interrupts are deferred and scheduled inside of threads. This 
means most interrupts are delayed , and are run along with all other
threads and user space processes. The result of this is that a minimal
amount of code runs in actual interrupt context. The code executing in
interrupt context only unblocks, (wakes-up) interrupt threads, and then
immediately returns to process context.


        Usually a driver that implements an interrupt handler, along
with system calls or IO controls, would need to disable interrupts to
stop the interrupt handler from running. In this type of driver you must
disable interrupts to have control over when the interrupt runs, which
is essential to serialize data access in the driver. However, this type
of paradigm changes in the face of threaded interrupt handlers.

Theory:

        The interrupt in thread model changes the driver paradigm that I
describe above in one fundamental way, the interrupt handler 
no longer runs in interrupt context. With this one change it is still
possible to stop the interrupt handler from running by disabling 
interrupts. Which is what the current real time patch does. Since
interrupt handlers are now threads, to stop an interrupt handler from
running one must only disable preemption.

Implementation:

        I've written code that removes 70% all interrupt disable
sections in the current real time kernel. These interrupt disable 
sections are replaced with a special preempt disable section. Since an
interrupt disable section implicitly disables preemption, there 
should be no increase in preemption latency due to this change. 

        There is still a need for interrupt disable sections. I've
reassigned local_irq_disable() as hard_local_irq_disable() . One 
would now run this "hard" macro to disable interrupts, with the older
non-hard types re-factored to disable preemption.
 
        Since only a small stub of code runs in interrupt context, we
only need to protect the data structures accessed by that small 
piece of code. This included all of the interrupt handling subsystem. It
also included parts of the scheduler that are used to change 
the process state.

        An intended side effect of this implementation is that if a user
designates an interrupt handler with the flag SA_NODELAY , then that
interrupt should have a very low latency characteristic. Currently the
timer is the only SA_NODELAY interrupt.

Results:

        Config option |         Number of cli's
        PREEMPT                 1138 (0% removal)
        PREEMPT_RT              224  (80% removal)
        RT_IRQ_DISABLE          69   (94% removal)

        PREEMPT_RT displays a significant reduction over plain PREEMPT
due to the fact that mutex converted spinlocks no longer disable
interrupts. However, PREEMPT_RT doesn't give a fixed number of 
interrupt disable sections in the kernel. In HARD_RT there is a fixed
number of interrupt disable sections and it further reduces the 
total to 30% of PREEMPT_RT (or %6 of PREEMPT).

        With a fixed number of interrupt disable sections we can give a
set worst case interrupt latency. This holds no matter what drivers, or
system config is used. The one current exception relates to the
xtime_lock. This exception is because this lock is used in the timer
interrupt which is not in a thread.

        This is a work in progress , and is still volatile. It is not
tested fully on SMP. Raw spinlocks no longer disable interrupts, and it
is unclear what the SMP impact is. So please test on SMP. The irq_trace
feature could cause hangs if it's used in the wrong places, so be
careful. IRQ latency and latency tracing have been modified, but still
require some testing.

        This patch applies on top of the RT patch provided by Ingo
Molnar. There is to much instability after 0.7.47-19 , so my patch is
recommend on this version.

You may download the -19 RT patch from the following location,

http://people.redhat.com/~mingo/realtime-preempt/older/realtime-preempt-2.6.12-rc6-V0.7.47-19

Future work:

        As described above , there are only a few areas that need a true
interrupt disable. It would now be possible to measure all interrupt
disable sections in every kernel when this feature is turned on. 
A definition like this would allow the biggest interrupt disable section
to be defined exactly. Once these sections are defined we would then be
able to optimize each one, producing ever decrease interrupt latency.

        Another optimization to this system would be to produce a method
so that local_irq_disable only prevents interrupt threads from running,
instead of the current method of preventing all threads and processes
from running. The biggest problem in doing this is the balance of the
average size of an interrupt disable section vs. the length of time it
takes to soft disable/enable. 

Thanks to Sven Dietrich

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.11/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6.11.orig/arch/i386/kernel/entry.S	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/arch/i386/kernel/entry.S	2005-06-08 00:35:30.000000000 +0000
@@ -331,6 +331,9 @@ work_pending:
 work_resched:
 	cli
 	call __schedule
+#ifdef CONFIG_RT_IRQ_DISABLE
+	call local_irq_enable_noresched
+#endif
 					# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
Index: linux-2.6.11/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.11.orig/arch/i386/kernel/process.c	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/arch/i386/kernel/process.c	2005-06-08 06:29:52.000000000 +0000
@@ -96,13 +96,13 @@ EXPORT_SYMBOL(enable_hlt);
 void default_idle(void)
 {
 	if (!hlt_counter && boot_cpu_data.hlt_works_ok) {
-		local_irq_disable();
+		hard_local_irq_disable();
 		if (!need_resched())
-			safe_halt();
+			hard_safe_halt();
 		else
-			local_irq_enable();
+			hard_local_irq_enable();
 	} else {
-		local_irq_enable();
+		hard_local_irq_enable();
 		cpu_relax();
 	}
 }
@@ -149,6 +149,9 @@ void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
+#ifdef CONFIG_RT_IRQ_DISABLE
+			BUG_ON(hard_irqs_disabled());
+#endif
 		while (!need_resched()) {
 			void (*idle)(void);
 
@@ -165,7 +168,9 @@ void cpu_idle (void)
 			stop_critical_timing();
 			idle();
 		}
+		hard_local_irq_disable();
 		__schedule();
+		hard_local_irq_enable();
 	}
 }
 
Index: linux-2.6.11/arch/i386/kernel/signal.c
===================================================================
--- linux-2.6.11.orig/arch/i386/kernel/signal.c	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/arch/i386/kernel/signal.c	2005-06-08 00:44:00.000000000 +0000
@@ -597,7 +597,7 @@ int fastcall do_signal(struct pt_regs *r
 	/*
 	 * Fully-preemptible kernel does not need interrupts disabled:
 	 */
-	local_irq_enable();
+	hard_local_irq_enable();
 	preempt_check_resched();
 #endif
 	/*
Index: linux-2.6.11/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.11.orig/arch/i386/kernel/traps.c	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/arch/i386/kernel/traps.c	2005-06-08 00:45:11.000000000 +0000
@@ -376,7 +376,7 @@ static void do_trap(int trapnr, int sign
 		goto kernel_trap;
 
 #ifdef CONFIG_PREEMPT_RT
-	local_irq_enable();
+	hard_local_irq_enable();
 	preempt_check_resched();
 #endif
 
@@ -508,7 +508,7 @@ fastcall void do_general_protection(stru
 	return;
 
 gp_in_vm86:
-	local_irq_enable();
+	hard_local_irq_enable();
 	handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
 	return;
 
@@ -705,7 +705,7 @@ fastcall void do_debug(struct pt_regs * 
 		return;
 	/* It's safe to allow irq's after DR6 has been saved */
 	if (regs->eflags & X86_EFLAGS_IF)
-		local_irq_enable();
+		hard_local_irq_enable();
 
 	/* Mask out spurious debug traps due to lazy DR7 setting */
 	if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3)) {
Index: linux-2.6.11/arch/i386/mm/fault.c
===================================================================
--- linux-2.6.11.orig/arch/i386/mm/fault.c	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/arch/i386/mm/fault.c	2005-06-08 00:35:30.000000000 +0000
@@ -232,7 +232,7 @@ fastcall notrace void do_page_fault(stru
 		return;
 	/* It's safe to allow irq's after cr2 has been saved */
 	if (regs->eflags & (X86_EFLAGS_IF|VM_MASK))
-		local_irq_enable();
+		hard_local_irq_enable();
 
 	tsk = current;
 
Index: linux-2.6.11/include/asm-i386/system.h
===================================================================
--- linux-2.6.11.orig/include/asm-i386/system.h	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/include/asm-i386/system.h	2005-06-08 00:35:30.000000000 +0000
@@ -450,28 +450,70 @@ struct alt_instr { 
 # define trace_irqs_on()		do { } while (0)
 #endif
 
+#ifdef CONFIG_RT_IRQ_DISABLE
+extern void local_irq_enable(void);
+extern void local_irq_enable_noresched(void);
+extern void local_irq_disable(void);
+extern void local_irq_restore(unsigned long);
+extern unsigned long irqs_disabled(void);
+extern unsigned long irqs_disabled_flags(unsigned long);
+extern unsigned int ___local_save_flags(void);
+extern void irq_trace_enable(void);
+extern void irq_trace_disable(void);
+
+#define local_save_flags(x) ({ x = ___local_save_flags(); x;})
+#define local_irq_save(x) ({ local_save_flags(x); local_irq_disable(); x;})
+#define safe_halt()	do { local_irq_enable(); __asm__ __volatile__("hlt": : :"memory"); } while (0)
+
+/* Force the softstate to follow the hard state */
+#define hard_local_save_flags(x)	_hard_local_save_flags(x)
+#define hard_local_irq_enable()		do { local_irq_enable_noresched(); _hard_local_irq_enable(); } while(0)
+#define hard_local_irq_disable()	do { _hard_local_irq_disable(); local_irq_disable(); } while(0)
+#define hard_local_irq_save(x)		do { _hard_local_irq_save(x); } while(0)
+#define hard_local_irq_restore(x)		do { _hard_local_irq_restore(x); } while (0)
+#define hard_safe_halt()			do { local_irq_enable(); _hard_safe_halt(); } while (0)
+#else
+
+#define hard_local_save_flags		_hard_local_save_flags
+#define hard_local_irq_enable		_hard_local_irq_enable
+#define hard_local_irq_disable		_hard_local_irq_disable
+#define hard_local_irq_save		_hard_local_irq_save
+#define hard_local_irq_restore		_hard_local_irq_restore
+#define hard_safe_halt			_hard_safe_halt
+
+#define local_irq_enable_noresched _hard_local_irq_enable
+#define local_save_flags	_hard_local_save_flags
+#define local_irq_enable	_hard_local_irq_enable 
+#define local_irq_disable	_hard_local_irq_disable 
+#define local_irq_save		_hard_local_irq_save
+#define local_irq_restore	_hard_local_irq_restore
+#define irqs_disabled		hard_irqs_disabled
+#define irqs_disabled_flags	hard_irqs_disabled_flags
+#define safe_halt		hard_safe_halt
+#endif
+
 /* interrupt control.. */
-#define local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
-#define local_irq_restore(x) 	do { typecheck(unsigned long,x); if (irqs_disabled_flags(x)) trace_irqs_on(); else trace_irqs_on(); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
-#define local_irq_disable() 	do { __asm__ __volatile__("cli": : :"memory"); trace_irqs_off(); } while (0)
-#define local_irq_enable()	do { trace_irqs_on(); __asm__ __volatile__("sti": : :"memory"); } while (0)
+#define _hard_local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
+#define _hard_local_irq_restore(x) 	do { typecheck(unsigned long,x); if (hard_irqs_disabled_flags(x)) trace_irqs_on(); else trace_irqs_on(); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
+#define _hard_local_irq_disable() 	do { __asm__ __volatile__("cli": : :"memory"); trace_irqs_off(); } while (0)
+#define _hard_local_irq_enable()	do { trace_irqs_on(); __asm__ __volatile__("sti": : :"memory"); } while (0)
 /* used in the idle loop; sti takes one instruction cycle to complete */
-#define safe_halt()		do { trace_irqs_on(); __asm__ __volatile__("sti; hlt": : :"memory"); } while (0)
+#define _hard_safe_halt()		do { trace_irqs_on(); __asm__ __volatile__("sti; hlt": : :"memory"); } while (0)
 
-#define irqs_disabled_flags(flags)	\
+#define hard_irqs_disabled_flags(flags)	\
 ({					\
 	!(flags & (1<<9));		\
 })
 
-#define irqs_disabled()			\
+#define hard_irqs_disabled()			\
 ({					\
 	unsigned long flags;		\
-	local_save_flags(flags);	\
-	irqs_disabled_flags(flags);	\
+	hard_local_save_flags(flags);	\
+	hard_irqs_disabled_flags(flags);	\
 })
 
 /* For spinlocks etc */
-#define local_irq_save(x)	do { __asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory"); trace_irqs_off(); } while (0)
+#define _hard_local_irq_save(x)	do { __asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory"); trace_irqs_off(); } while (0)
 
 /*
  * disable hlt during certain critical i/o operations
Index: linux-2.6.11/include/linux/hardirq.h
===================================================================
--- linux-2.6.11.orig/include/linux/hardirq.h	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/include/linux/hardirq.h	2005-06-08 00:48:03.000000000 +0000
@@ -25,6 +25,9 @@
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 
+#define IRQSOFF_BITS	1 
+#define PREEMPTACTIVE_BITS	1 
+
 #ifndef HARDIRQ_BITS
 #define HARDIRQ_BITS	12
 /*
@@ -40,16 +43,22 @@
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
+#define PREEMPTACTIVE_SHIFT	(HARDIRQ_SHIFT + HARDIRQ_BITS)
+#define IRQSOFF_SHIFT 		(PREEMPTACTIVE_SHIFT + PREEMPTACTIVE_BITS)
+
 #define __IRQ_MASK(x)	((1UL << (x))-1)
 
 #define PREEMPT_MASK	(__IRQ_MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
 #define SOFTIRQ_MASK	(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
 #define HARDIRQ_MASK	(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
 
+#define IRQSOFF_MASK	(__IRQ_MASK(IRQSOFF_BITS) << IRQSOFF_SHIFT)
+
 #define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
 #define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
 #define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
 
+#define IRQSOFF_OFFSET        (1UL << IRQSOFF_SHIFT)
 #if PREEMPT_ACTIVE < (1 << (HARDIRQ_SHIFT + HARDIRQ_BITS))
 #error PREEMPT_ACTIVE is too low!
 #endif
@@ -58,6 +67,8 @@
 #define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
 #define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
 
+#define irqs_off()	(preempt_count() & IRQSOFF_MASK)
+
 /*
  * Are we doing bottom half or hardware interrupt processing?
  * Are we in a softirq context? Interrupt context?
@@ -69,9 +80,9 @@
 #if defined(CONFIG_PREEMPT) && \
 	!defined(CONFIG_PREEMPT_BKL) && \
 		!defined(CONFIG_PREEMPT_RT)
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != kernel_locked())
+# define in_atomic()	((preempt_count() & ~(PREEMPT_ACTIVE|IRQSOFF_OFFSET)) != kernel_locked())
 #else
-# define in_atomic()	((preempt_count() & ~PREEMPT_ACTIVE) != 0)
+# define in_atomic()	((preempt_count() & ~(PREEMPT_ACTIVE|IRQSOFF_OFFSET)) != 0)
 #endif
 
 #ifdef CONFIG_PREEMPT
Index: linux-2.6.11/include/linux/sched.h
===================================================================
--- linux-2.6.11.orig/include/linux/sched.h	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/include/linux/sched.h	2005-06-08 00:35:30.000000000 +0000
@@ -839,6 +839,9 @@ struct task_struct {
 	unsigned long preempt_trace_eip[MAX_PREEMPT_TRACE];
 	unsigned long preempt_trace_parent_eip[MAX_PREEMPT_TRACE];
 #endif
+	unsigned long last_irq_disable[2];
+	unsigned long last_irq_enable[2];
+
 
 	/* realtime bits */
 	struct list_head delayed_put;
Index: linux-2.6.11/include/linux/seqlock.h
===================================================================
--- linux-2.6.11.orig/include/linux/seqlock.h	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/include/linux/seqlock.h	2005-06-08 00:35:30.000000000 +0000
@@ -305,26 +305,26 @@ do {								\
  * Possible sw/hw IRQ protected versions of the interfaces.
  */
 #define write_seqlock_irqsave(lock, flags)				\
-	do { PICK_IRQOP2(local_irq_save, flags, lock); write_seqlock(lock); } while (0)
+	do { PICK_IRQOP2(hard_local_irq_save, flags, lock); write_seqlock(lock); } while (0)
 #define write_seqlock_irq(lock)						\
-	do { PICK_IRQOP(local_irq_disable, lock); write_seqlock(lock); } while (0)
+	do { PICK_IRQOP(hard_local_irq_disable, lock); write_seqlock(lock); } while (0)
 #define write_seqlock_bh(lock)						\
         do { PICK_IRQOP(local_bh_disable, lock); write_seqlock(lock); } while (0)
 
 #define write_sequnlock_irqrestore(lock, flags)				\
-	do { write_sequnlock(lock); PICK_IRQOP2(local_irq_restore, flags, lock); preempt_check_resched(); } while(0)
+	do { write_sequnlock(lock); PICK_IRQOP2(hard_local_irq_restore, flags, lock); preempt_check_resched(); } while(0)
 #define write_sequnlock_irq(lock)					\
-	do { write_sequnlock(lock); PICK_IRQOP(local_irq_enable, lock); preempt_check_resched(); } while(0)
+	do { write_sequnlock(lock); PICK_IRQOP(hard_local_irq_enable, lock); preempt_check_resched(); } while(0)
 #define write_sequnlock_bh(lock)					\
 	do { write_sequnlock(lock); PICK_IRQOP(local_bh_enable, lock); } while(0)
 
 #define read_seqbegin_irqsave(lock, flags)				\
-	({ PICK_IRQOP2(local_irq_save, flags, lock); read_seqbegin(lock); })
+	({ PICK_IRQOP2(hard_local_irq_save, flags, lock); read_seqbegin(lock); })
 
 #define read_seqretry_irqrestore(lock, iv, flags)			\
 	({								\
 		int ret = read_seqretry(lock, iv);			\
-		PICK_IRQOP2(local_irq_restore, flags, lock);		\
+		PICK_IRQOP2(hard_local_irq_restore, flags, lock);		\
 		preempt_check_resched(); 				\
 		ret;							\
 	})
Index: linux-2.6.11/include/linux/spinlock.h
===================================================================
--- linux-2.6.11.orig/include/linux/spinlock.h	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/include/linux/spinlock.h	2005-06-08 00:35:30.000000000 +0000
@@ -244,7 +244,7 @@ typedef struct {
 ({ \
 	local_irq_disable(); preempt_disable(); \
 	__raw_spin_trylock(lock) ? \
-	1 : ({ __preempt_enable_no_resched(); local_irq_enable(); preempt_check_resched(); 0; }); \
+	1 : ({ __preempt_enable_no_resched(); local_irq_enable_noresched(); preempt_check_resched(); 0; }); \
 })
 
 #define _raw_spin_trylock_irqsave(lock, flags) \
@@ -384,7 +384,7 @@ do { \
 do { \
 	__raw_spin_unlock(lock); \
 	__preempt_enable_no_resched(); \
-	local_irq_enable(); \
+	local_irq_enable_noresched(); \
 	preempt_check_resched(); \
 	__release(lock); \
 } while (0)
@@ -427,7 +427,7 @@ do { \
 do { \
 	__raw_read_unlock(lock);\
 	__preempt_enable_no_resched(); \
-	local_irq_enable();	\
+	local_irq_enable_noresched();	\
 	preempt_check_resched(); \
 	__release(lock); \
 } while (0)
@@ -444,7 +444,7 @@ do { \
 do { \
 	__raw_write_unlock(lock);\
 	__preempt_enable_no_resched(); \
-	local_irq_enable();	\
+	local_irq_enable_noresched();	\
 	preempt_check_resched(); \
 	__release(lock); \
 } while (0)
Index: linux-2.6.11/init/main.c
===================================================================
--- linux-2.6.11.orig/init/main.c	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/init/main.c	2005-06-08 00:51:57.000000000 +0000
@@ -428,6 +428,14 @@ asmlinkage void __init start_kernel(void
 {
 	char * command_line;
 	extern struct kernel_param __start___param[], __stop___param[];
+#ifdef CONFIG_RT_IRQ_DISABLE
+	/* 
+ 	 * Force the soft IRQ state to mimic the hard state until
+	 * we finish boot-up.
+	 */
+	local_irq_disable();
+#endif
+
 /*
  * Interrupts are still disabled. Do necessary setups, then
  * enable them
@@ -456,6 +464,13 @@ asmlinkage void __init start_kernel(void
 	 * fragile until we cpu_idle() for the first time.
 	 */
 	preempt_disable();
+#ifdef CONFIG_RT_IRQ_DISABLE
+	/*
+	 * Reset the irqs off flag after sched_init resets the preempt_count.
+	 */
+	local_irq_disable();
+#endif
+
 	build_all_zonelists();
 	page_alloc_init();
 	early_init_hardirqs();
@@ -482,7 +497,12 @@ asmlinkage void __init start_kernel(void
 	if (panic_later)
 		panic(panic_later, panic_param);
 	profile_init();
-	local_irq_enable();
+
+	/*
+	 * Soft IRQ state will be enabled with the hard state.
+	 */
+	hard_local_irq_enable();
+
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&
 			initrd_start < min_low_pfn << PAGE_SHIFT) {
@@ -526,6 +546,9 @@ asmlinkage void __init start_kernel(void
 
 	acpi_early_init(); /* before LAPIC and SMP init */
 
+#ifdef CONFIG_RT_IRQ_DISABLE
+	WARN_ON(hard_irqs_disabled());
+#endif
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
 }
@@ -568,6 +591,12 @@ static void __init do_initcalls(void)
 			msg = "disabled interrupts";
 			local_irq_enable();
 		}
+#ifdef CONFIG_RT_IRQ_DISABLE
+		if (hard_irqs_disabled()) {
+			msg = "disabled hard interrupts";
+			hard_local_irq_enable();
+		}
+#endif
 		if (msg) {
 			printk(KERN_WARNING "error in initcall at 0x%p: "
 				"returned with %s\n", *call, msg);
@@ -708,6 +737,9 @@ static int init(void * unused)
 	 * The Bourne shell can be used instead of init if we are 
 	 * trying to recover a really broken machine.
 	 */
+#ifdef CONFIG_RT_IRQ_DISABLE
+	WARN_ON(hard_irqs_disabled());
+#endif
 
 	if (execute_command)
 		run_init_process(execute_command);
Index: linux-2.6.11/kernel/Makefile
===================================================================
--- linux-2.6.11.orig/kernel/Makefile	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/kernel/Makefile	2005-06-08 00:35:30.000000000 +0000
@@ -10,6 +10,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
 
 obj-$(CONFIG_PREEMPT_RT) += rt.o
+obj-$(CONFIG_RT_IRQ_DISABLE) += irqs-off.o
 
 obj-$(CONFIG_DEBUG_PREEMPT) += latency.o
 obj-$(CONFIG_LATENCY_TIMING) += latency.o
Index: linux-2.6.11/kernel/exit.c
===================================================================
--- linux-2.6.11.orig/kernel/exit.c	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/kernel/exit.c	2005-06-08 00:35:30.000000000 +0000
@@ -844,7 +844,7 @@ fastcall NORET_TYPE void do_exit(long co
 	check_no_held_locks(tsk);
 	/* PF_DEAD causes final put_task_struct after we schedule. */
 again:
-	local_irq_disable();
+	hard_local_irq_disable();
 	tsk->flags |= PF_DEAD;
 	__schedule();
 	printk(KERN_ERR "BUG: dead task %s:%d back from the grave!\n",
Index: linux-2.6.11/kernel/irq/autoprobe.c
===================================================================
--- linux-2.6.11.orig/kernel/irq/autoprobe.c	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/kernel/irq/autoprobe.c	2005-06-08 00:35:30.000000000 +0000
@@ -39,10 +39,12 @@ unsigned long probe_irq_on(void)
 	for (i = NR_IRQS-1; i > 0; i--) {
 		desc = irq_desc + i;
 
-		spin_lock_irq(&desc->lock);
+		hard_local_irq_disable();
+		spin_lock(&desc->lock);
 		if (!irq_desc[i].action)
 			irq_desc[i].handler->startup(i);
-		spin_unlock_irq(&desc->lock);
+		spin_unlock(&desc->lock);
+		hard_local_irq_enable();
 	}
 
 	/*
@@ -58,13 +60,15 @@ unsigned long probe_irq_on(void)
 	for (i = NR_IRQS-1; i > 0; i--) {
 		desc = irq_desc + i;
 
-		spin_lock_irq(&desc->lock);
+		hard_local_irq_disable();
+		spin_lock(&desc->lock);
 		if (!desc->action) {
 			desc->status |= IRQ_AUTODETECT | IRQ_WAITING;
 			if (desc->handler->startup(i))
 				desc->status |= IRQ_PENDING;
 		}
-		spin_unlock_irq(&desc->lock);
+		spin_unlock(&desc->lock);
+		hard_local_irq_enable();
 	}
 
 	/*
@@ -80,7 +84,8 @@ unsigned long probe_irq_on(void)
 		irq_desc_t *desc = irq_desc + i;
 		unsigned int status;
 
-		spin_lock_irq(&desc->lock);
+		hard_local_irq_disable();
+		spin_lock(&desc->lock);
 		status = desc->status;
 
 		if (status & IRQ_AUTODETECT) {
@@ -92,7 +97,8 @@ unsigned long probe_irq_on(void)
 				if (i < 32)
 					val |= 1 << i;
 		}
-		spin_unlock_irq(&desc->lock);
+		spin_unlock(&desc->lock);
+		hard_local_irq_enable();
 	}
 
 	return val;
@@ -122,7 +128,8 @@ unsigned int probe_irq_mask(unsigned lon
 		irq_desc_t *desc = irq_desc + i;
 		unsigned int status;
 
-		spin_lock_irq(&desc->lock);
+		hard_local_irq_disable();
+		spin_lock(&desc->lock);
 		status = desc->status;
 
 		if (status & IRQ_AUTODETECT) {
@@ -132,7 +139,8 @@ unsigned int probe_irq_mask(unsigned lon
 			desc->status = status & ~IRQ_AUTODETECT;
 			desc->handler->shutdown(i);
 		}
-		spin_unlock_irq(&desc->lock);
+		spin_unlock(&desc->lock);
+		hard_local_irq_enable();
 	}
 	up(&probe_sem);
 
@@ -165,7 +173,8 @@ int probe_irq_off(unsigned long val)
 		irq_desc_t *desc = irq_desc + i;
 		unsigned int status;
 
-		spin_lock_irq(&desc->lock);
+		hard_local_irq_disable();
+		spin_lock(&desc->lock);
 		status = desc->status;
 
 		if (status & IRQ_AUTODETECT) {
@@ -177,7 +186,8 @@ int probe_irq_off(unsigned long val)
 			desc->status = status & ~IRQ_AUTODETECT;
 			desc->handler->shutdown(i);
 		}
-		spin_unlock_irq(&desc->lock);
+		spin_unlock(&desc->lock);
+		hard_local_irq_enable();
 	}
 	up(&probe_sem);
 
Index: linux-2.6.11/kernel/irq/handle.c
===================================================================
--- linux-2.6.11.orig/kernel/irq/handle.c	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/kernel/irq/handle.c	2005-06-08 00:35:30.000000000 +0000
@@ -113,7 +113,7 @@ fastcall int handle_IRQ_event(unsigned i
 	 * IRQ handlers:
 	 */
 	if (!hardirq_count() || !(action->flags & SA_INTERRUPT))
-		local_irq_enable();
+		hard_local_irq_enable();
 
 	do {
 		unsigned int preempt_count = preempt_count();
@@ -133,10 +133,10 @@ fastcall int handle_IRQ_event(unsigned i
 	} while (action);
 
 	if (status & SA_SAMPLE_RANDOM) {
-		local_irq_enable();
+		hard_local_irq_enable();
 		add_interrupt_randomness(irq);
 	}
-	local_irq_disable();
+	hard_local_irq_disable();
 
 	return retval;
 }
@@ -157,6 +157,10 @@ fastcall notrace unsigned int __do_IRQ(u
 	struct irqaction * action;
 	unsigned int status;
 
+#ifdef CONFIG_RT_IRQ_DISABLE
+	unsigned long flags;
+	local_irq_save(flags);
+#endif
 	kstat_this_cpu.irqs[irq]++;
 	if (desc->status & IRQ_PER_CPU) {
 		irqreturn_t action_ret;
@@ -241,6 +245,9 @@ out:
 out_no_end:
 	spin_unlock(&desc->lock);
 
+#ifdef CONFIG_RT_IRQ_DISABLE
+	local_irq_restore(flags);
+#endif
 	return 1;
 }
 
Index: linux-2.6.11/kernel/irq/manage.c
===================================================================
--- linux-2.6.11.orig/kernel/irq/manage.c	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/kernel/irq/manage.c	2005-06-08 00:55:05.000000000 +0000
@@ -59,13 +59,15 @@ void disable_irq_nosync(unsigned int irq
 {
 	irq_desc_t *desc = irq_desc + irq;
 	unsigned long flags;
-
-	spin_lock_irqsave(&desc->lock, flags);
+	
+	_hard_local_irq_save(flags);
+	spin_lock(&desc->lock);
 	if (!desc->depth++) {
 		desc->status |= IRQ_DISABLED;
 		desc->handler->disable(irq);
 	}
-	spin_unlock_irqrestore(&desc->lock, flags);
+	spin_unlock(&desc->lock);
+	_hard_local_irq_restore(flags);
 }
 
 EXPORT_SYMBOL(disable_irq_nosync);
@@ -108,7 +110,8 @@ void enable_irq(unsigned int irq)
 	irq_desc_t *desc = irq_desc + irq;
 	unsigned long flags;
 
-	spin_lock_irqsave(&desc->lock, flags);
+	_hard_local_irq_save(flags);
+	spin_lock(&desc->lock);
 	switch (desc->depth) {
 	case 0:
 		WARN_ON(1);
@@ -127,7 +130,8 @@ void enable_irq(unsigned int irq)
 	default:
 		desc->depth--;
 	}
-	spin_unlock_irqrestore(&desc->lock, flags);
+	spin_unlock(&desc->lock);
+	_hard_local_irq_restore(flags);
 }
 
 EXPORT_SYMBOL(enable_irq);
@@ -203,7 +207,8 @@ int setup_irq(unsigned int irq, struct i
 	/*
 	 * The following block of code has to be executed atomically
 	 */
-	spin_lock_irqsave(&desc->lock,flags);
+	_hard_local_irq_save(flags);
+	spin_lock(&desc->lock);
 	p = &desc->action;
 	if ((old = *p) != NULL) {
 		/* Can't share interrupts unless both agree to */
@@ -236,7 +241,8 @@ int setup_irq(unsigned int irq, struct i
 		else
 			desc->handler->enable(irq);
 	}
-	spin_unlock_irqrestore(&desc->lock,flags);
+	spin_unlock(&desc->lock);
+	_hard_local_irq_restore(flags);
 
 	new->irq = irq;
 	register_irq_proc(irq);
@@ -270,7 +276,8 @@ void free_irq(unsigned int irq, void *de
 		return;
 
 	desc = irq_desc + irq;
-	spin_lock_irqsave(&desc->lock,flags);
+	_hard_local_irq_save(flags);
+	spin_lock(&desc->lock);
 	p = &desc->action;
 	for (;;) {
 		struct irqaction * action = *p;
@@ -292,7 +299,8 @@ void free_irq(unsigned int irq, void *de
 					desc->handler->disable(irq);
 			}
 			recalculate_desc_flags(desc);
-			spin_unlock_irqrestore(&desc->lock,flags);
+			spin_unlock(&desc->lock);
+			_hard_local_irq_restore(flags);
 			unregister_handler_proc(irq, action);
 
 			/* Make sure it's not being used on another CPU */
@@ -301,7 +309,8 @@ void free_irq(unsigned int irq, void *de
 			return;
 		}
 		printk(KERN_ERR "Trying to free free IRQ%d\n",irq);
-		spin_unlock_irqrestore(&desc->lock,flags);
+		spin_unlock(&desc->lock);
+		_hard_local_irq_restore(flags);
 		return;
 	}
 }
@@ -409,7 +418,7 @@ static void do_hardirq(struct irq_desc *
 	struct irqaction * action;
 	unsigned int irq = desc - irq_desc;
 
-	local_irq_disable();
+	hard_local_irq_disable();
 
 	if (desc->status & IRQ_INPROGRESS) {
 		action = desc->action;
@@ -420,9 +429,10 @@ static void do_hardirq(struct irq_desc *
 			if (action) {
 				spin_unlock(&desc->lock);
 				action_ret = handle_IRQ_event(irq, NULL,action);
-				local_irq_enable();
+				hard_local_irq_enable();
 				cond_resched_all();
-				spin_lock_irq(&desc->lock);
+				hard_local_irq_disable();
+				spin_lock(&desc->lock);
 			}
 			if (!noirqdebug)
 				note_interrupt(irq, desc, action_ret);
@@ -438,7 +448,7 @@ static void do_hardirq(struct irq_desc *
 		desc->handler->end(irq);
 		spin_unlock(&desc->lock);
 	}
-	local_irq_enable();
+	hard_local_irq_enable();
 	if (waitqueue_active(&desc->wait_for_handler))
 		wake_up(&desc->wait_for_handler);
 }
@@ -474,7 +484,7 @@ static int do_irqd(void * __desc)
 		do_hardirq(desc);
 		cond_resched_all();
 		__do_softirq();
-		local_irq_enable();
+		hard_local_irq_enable();
 #ifdef CONFIG_SMP
 		/*
 		 * Did IRQ affinities change?
Index: linux-2.6.11/kernel/irqs-off.c
===================================================================
--- linux-2.6.11.orig/kernel/irqs-off.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.11/kernel/irqs-off.c	2005-06-08 01:05:41.000000000 +0000
@@ -0,0 +1,99 @@
+/*
+ * kernel/irqs-off.c 
+ *
+ * IRQ soft state managment 
+ *
+ * Author: Daniel Walker <dwalker@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/hardirq.h>
+#include <linux/preempt.h>
+#include <linux/kallsyms.h>
+
+#include <linux/module.h>
+#include <asm/system.h>
+
+static int irq_trace;
+
+void irq_trace_enable(void) { irq_trace = 1; }
+void irq_trace_disable(void) { irq_trace = 0; }
+
+unsigned int ___local_save_flags()
+{
+	return irqs_off();
+}                                                                                                                        
+EXPORT_SYMBOL(___local_save_flags);
+
+void local_irq_enable_noresched(void)
+{
+	if (irq_trace) {
+		current->last_irq_enable[0] = (unsigned long)__builtin_return_address(0);
+		//current->last_irq_enable[1] = (unsigned long)__builtin_return_address(1);
+	}
+
+	if (irqs_off()) sub_preempt_count(IRQSOFF_OFFSET);
+}
+EXPORT_SYMBOL(local_irq_enable_noresched);
+
+void local_irq_enable(void)
+{
+	if (irq_trace) {
+		current->last_irq_enable[0] = (unsigned long)__builtin_return_address(0);
+		//current->last_irq_enable[1] = (unsigned long)__builtin_return_address(1);
+	}
+	if (irqs_off()) sub_preempt_count(IRQSOFF_OFFSET);
+
+	//local_irq_enable_noresched();
+	preempt_check_resched(); 
+}
+EXPORT_SYMBOL(local_irq_enable);
+
+void local_irq_disable(void) 
+{
+	if (irq_trace) {
+		current->last_irq_disable[0] = (unsigned long)__builtin_return_address(0);
+		//current->last_irq_disable[1] = (unsigned long)__builtin_return_address(1);
+	}
+	if (!irqs_off()) add_preempt_count(IRQSOFF_OFFSET);
+}
+EXPORT_SYMBOL(local_irq_disable);
+
+unsigned long irqs_disabled_flags(unsigned long flags)
+{
+	return (flags & IRQSOFF_MASK);	
+}
+EXPORT_SYMBOL(irqs_disabled_flags);
+
+void local_irq_restore(unsigned long flags)
+{
+	if (!irqs_disabled_flags(flags)) local_irq_enable();
+}
+EXPORT_SYMBOL(local_irq_restore);
+
+unsigned long irqs_disabled(void)
+{
+	return irqs_off();
+}
+EXPORT_SYMBOL(irqs_disabled);
+
+void print_irq_traces(struct task_struct *task)
+{
+	printk("Soft state access: (%s)\n", (hard_irqs_disabled()) ? "Hard disabled" : "Not disabled");
+	printk(".. [<%08lx>] .... ", task->last_irq_disable[0]);
+	print_symbol("%s\n", task->last_irq_disable[0]);
+	printk(".....[<%08lx>] ..   ( <= ",
+				task->last_irq_disable[1]);
+	print_symbol("%s)\n", task->last_irq_disable[1]);
+
+	printk(".. [<%08lx>] .... ", task->last_irq_enable[0]);
+	print_symbol("%s\n", task->last_irq_enable[0]);
+	printk(".....[<%08lx>] ..   ( <= ",
+				task->last_irq_enable[1]);
+	print_symbol("%s)\n", task->last_irq_enable[1]);
+	printk("\n");
+}
Index: linux-2.6.11/kernel/latency.c
===================================================================
--- linux-2.6.11.orig/kernel/latency.c	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/kernel/latency.c	2005-06-08 01:05:34.000000000 +0000
@@ -108,12 +108,15 @@ enum trace_flag_type
 	TRACE_FLAG_NEED_RESCHED		= 0x02,
 	TRACE_FLAG_HARDIRQ		= 0x04,
 	TRACE_FLAG_SOFTIRQ		= 0x08,
+#ifdef CONFIG_RT_IRQ_DISABLE
+	TRACE_FLAG_IRQS_HARD_OFF	= 0x16,
+#endif
 };
 
 
 #ifdef CONFIG_LATENCY_TRACE
 
-#define MAX_TRACE (unsigned long)(4096-1)
+#define MAX_TRACE (unsigned long)(8192-1)
 
 #define CMDLINE_BYTES 16
 
@@ -263,6 +266,9 @@ ____trace(int cpu, enum trace_type type,
 		entry->cpu = cpu;
 #endif
 		entry->flags = (irqs_disabled() ? TRACE_FLAG_IRQS_OFF : 0) |
+#ifdef CONFIG_RT_IRQ_DISABLE
+			(hard_irqs_disabled() ? TRACE_FLAG_IRQS_HARD_OFF : 0)|
+#endif
 			((pc & HARDIRQ_MASK) ? TRACE_FLAG_HARDIRQ : 0) |
 			((pc & SOFTIRQ_MASK) ? TRACE_FLAG_SOFTIRQ : 0) |
 			(_need_resched() ? TRACE_FLAG_NEED_RESCHED : 0);
@@ -724,7 +730,12 @@ print_generic(struct seq_file *m, struct
 	seq_printf(m, "%8.8s-%-5d ", pid_to_cmdline(entry->pid), entry->pid);
 	seq_printf(m, "%d", entry->cpu);
 	seq_printf(m, "%c%c",
-		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' : '.',
+		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
+#ifdef CONFIG_RT_IRQ_DISABLE
+		(entry->flags & TRACE_FLAG_IRQS_HARD_OFF) ? 'D' : '.',
+#else
+		'.',
+#endif
 		(entry->flags & TRACE_FLAG_NEED_RESCHED) ? 'n' : '.');
 
 	hardirq = entry->flags & TRACE_FLAG_HARDIRQ;
@@ -1212,9 +1223,9 @@ void notrace trace_irqs_off_lowlevel(voi
 {
 	unsigned long flags;
 
-	local_save_flags(flags);
+	hard_local_save_flags(flags);
 
-	if (!irqs_off_preempt_count() && irqs_disabled_flags(flags))
+	if (!irqs_off_preempt_count() && hard_irqs_disabled_flags(flags))
 		__start_critical_timing(CALLER_ADDR0, 0);
 }
 
@@ -1222,9 +1233,9 @@ void notrace trace_irqs_off(void)
 {
 	unsigned long flags;
 
-	local_save_flags(flags);
+	hard_local_save_flags(flags);
 
-	if (!irqs_off_preempt_count() && irqs_disabled_flags(flags))
+	if (!irqs_off_preempt_count() && hard_irqs_disabled_flags(flags))
 		__start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
 
@@ -1234,9 +1245,9 @@ void notrace trace_irqs_on(void)
 {
 	unsigned long flags;
 
-	local_save_flags(flags);
+	hard_local_save_flags(flags);
 
-	if (!irqs_off_preempt_count() && irqs_disabled_flags(flags))
+	if (!irqs_off_preempt_count() && hard_irqs_disabled_flags(flags))
 		__stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
 
@@ -1633,8 +1644,13 @@ static void print_entry(struct trace_ent
 	printk("%-5d ", entry->pid);
 
 	printk("%c%c",
-		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' : '.',
-		(entry->flags & TRACE_FLAG_NEED_RESCHED) ? 'n' : '.');
+		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
+#ifdef CONFIG_RT_IRQ_DISABLE
+		(entry->flags & TRACE_FLAG_IRQS_HARD_OFF) ? 'D' : '.',
+#else
+		'.',
+#endif
+ 		(entry->flags & TRACE_FLAG_NEED_RESCHED) ? 'n' : '.');
 
 	hardirq = entry->flags & TRACE_FLAG_HARDIRQ;
 	softirq = entry->flags & TRACE_FLAG_SOFTIRQ;
Index: linux-2.6.11/kernel/printk.c
===================================================================
--- linux-2.6.11.orig/kernel/printk.c	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/kernel/printk.c	2005-06-08 00:35:30.000000000 +0000
@@ -529,7 +529,8 @@ asmlinkage int vprintk(const char *fmt, 
 		zap_locks();
 
 	/* This stops the holder of console_sem just where we want him */
-	spin_lock_irqsave(&logbuf_lock, flags);
+	local_irq_save(flags);
+	spin_lock(&logbuf_lock);
 
 	/* Emit the output into the temporary buffer */
 	printed_len = vscnprintf(printk_buf, sizeof(printk_buf), fmt, args);
@@ -599,16 +600,18 @@ asmlinkage int vprintk(const char *fmt, 
 		 * CPU until it is officially up.  We shouldn't be calling into
 		 * random console drivers on a CPU which doesn't exist yet..
 		 */
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		spin_unlock(&logbuf_lock);
+		local_irq_restore(flags);
 		goto out;
 	}
-	if (!down_trylock(&console_sem)) {
+	if (!in_interrupt() && !down_trylock(&console_sem)) {
 		console_locked = 1;
 		/*
 		 * We own the drivers.  We can drop the spinlock and let
 		 * release_console_sem() print the text
 		 */
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		spin_unlock(&logbuf_lock);
+		local_irq_restore(flags);
 		console_may_schedule = 0;
 		release_console_sem();
 	} else {
@@ -617,7 +620,8 @@ asmlinkage int vprintk(const char *fmt, 
 		 * allows the semaphore holder to proceed and to call the
 		 * console drivers with the output which we just produced.
 		 */
-		spin_unlock_irqrestore(&logbuf_lock, flags);
+		spin_unlock(&logbuf_lock);
+		local_irq_restore(flags);
 	}
 out:
 	return printed_len;
@@ -750,7 +754,7 @@ void release_console_sem(void)
 	 * case only.
 	 */
 #ifdef CONFIG_PREEMPT_RT
-	if (!in_atomic() && !irqs_disabled())
+	if (!in_atomic() && !irqs_disabled() && !hard_irqs_disabled())
 #endif
 	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait))
 		wake_up_interruptible(&log_wait);
Index: linux-2.6.11/kernel/sched.c
===================================================================
--- linux-2.6.11.orig/kernel/sched.c	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/kernel/sched.c	2005-06-08 06:06:37.000000000 +0000
@@ -307,11 +307,12 @@ static inline runqueue_t *task_rq_lock(t
 	struct runqueue *rq;
 
 repeat_lock_task:
-	local_irq_save(*flags);
+	hard_local_irq_save(*flags);
 	rq = task_rq(p);
 	spin_lock(&rq->lock);
 	if (unlikely(rq != task_rq(p))) {
-		spin_unlock_irqrestore(&rq->lock, *flags);
+		spin_unlock(&rq->lock);
+		hard_local_irq_restore(*flags);
 		goto repeat_lock_task;
 	}
 	return rq;
@@ -320,7 +321,8 @@ repeat_lock_task:
 static inline void task_rq_unlock(runqueue_t *rq, unsigned long *flags)
 	__releases(rq->lock)
 {
-	spin_unlock_irqrestore(&rq->lock, *flags);
+	spin_unlock(&rq->lock);
+	hard_local_irq_restore(*flags);
 }
 
 #ifdef CONFIG_SCHEDSTATS
@@ -426,7 +428,7 @@ static inline runqueue_t *this_rq_lock(v
 {
 	runqueue_t *rq;
 
-	local_irq_disable();
+	hard_local_irq_disable();
 	rq = this_rq();
 	spin_lock(&rq->lock);
 
@@ -1213,9 +1215,10 @@ out:
 	 */
 	if (_need_resched() && !irqs_disabled_flags(flags) && !preempt_count())
 		preempt_schedule_irq();
-	local_irq_restore(flags);
+	hard_local_irq_restore(flags);
 #else
-	spin_unlock_irqrestore(&rq->lock, flags);
+	spin_unlock(&rq->lock);
+	hard_local_irq_restore(flags);
 #endif
 	/* no need to check for preempt here - we just handled it */
 
@@ -1289,7 +1292,7 @@ void fastcall sched_fork(task_t *p)
 	 * total amount of pending timeslices in the system doesn't change,
 	 * resulting in more scheduling fairness.
 	 */
-	local_irq_disable();
+	hard_local_irq_disable();
 	p->time_slice = (current->time_slice + 1) >> 1;
 	/*
 	 * The remainder of the first timeslice might be recovered by
@@ -1307,10 +1310,10 @@ void fastcall sched_fork(task_t *p)
 		current->time_slice = 1;
 		preempt_disable();
 		scheduler_tick();
-		local_irq_enable();
+		hard_local_irq_enable();
 		preempt_enable();
 	} else
-		local_irq_enable();
+		hard_local_irq_enable();
 }
 
 /*
@@ -1496,7 +1499,7 @@ asmlinkage void schedule_tail(task_t *pr
 	preempt_disable(); // TODO: move this to fork setup
 	finish_task_switch(prev);
 	__preempt_enable_no_resched();
-	local_irq_enable();
+	hard_local_irq_enable();
 	preempt_check_resched();
 
 	if (current->set_child_tid)
@@ -2623,7 +2626,7 @@ void scheduler_tick(void)
 	task_t *p = current;
 	unsigned long long now = sched_clock();
 
-	BUG_ON(!irqs_disabled());
+	BUG_ON(!hard_irqs_disabled());
 
 	update_cpu_clock(p, rq, now);
 
@@ -2938,7 +2941,8 @@ void __sched __schedule(void)
 	run_time /= (CURRENT_BONUS(prev) ? : 1);
 
 	cpu = smp_processor_id();
-	spin_lock_irq(&rq->lock);
+	hard_local_irq_disable();
+	spin_lock(&rq->lock);
 
 	switch_count = &prev->nvcsw; // TODO: temporary - to see it in vmstat
 	if ((prev->state & ~TASK_RUNNING_MUTEX) &&
@@ -3078,7 +3082,7 @@ asmlinkage void __sched schedule(void)
 	/*
 	 * Test if we have interrupts disabled.
 	 */
-	if (unlikely(irqs_disabled())) {
+	if (unlikely(irqs_disabled() || hard_irqs_disabled())) {
 		stop_trace();
 		printk(KERN_ERR "BUG: scheduling with irqs disabled: "
 			"%s/0x%08x/%d\n",
@@ -3096,7 +3100,7 @@ asmlinkage void __sched schedule(void)
 	do {
 		__schedule();
 	} while (unlikely(test_thread_flag(TIF_NEED_RESCHED)));
-	local_irq_enable(); // TODO: do sti; ret
+	hard_local_irq_enable(); // TODO: do sti; ret
 }
 
 EXPORT_SYMBOL(schedule);
@@ -3166,11 +3170,11 @@ asmlinkage void __sched preempt_schedule
 	 * If there is a non-zero preempt_count or interrupts are disabled,
 	 * we do not want to preempt the current task.  Just return..
 	 */
-	if (unlikely(ti->preempt_count || irqs_disabled()))
+	if (unlikely(ti->preempt_count || irqs_disabled() || hard_irqs_disabled()))
 		return;
 
 need_resched:
-	local_irq_disable();
+	hard_local_irq_disable();
 	add_preempt_count(PREEMPT_ACTIVE);
 	/*
 	 * We keep the big kernel semaphore locked, but we
@@ -3189,7 +3193,7 @@ need_resched:
 	barrier();
 	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
 		goto need_resched;
-	local_irq_enable();
+	hard_local_irq_enable();
 }
 
 EXPORT_SYMBOL(preempt_schedule);
@@ -3217,6 +3221,9 @@ asmlinkage void __sched preempt_schedule
 		return;
 
 need_resched:
+#ifdef CONFIG_RT_IRQ_DISABLE
+	hard_local_irq_disable();
+#endif
 	add_preempt_count(PREEMPT_ACTIVE);
 	/*
 	 * We keep the big kernel semaphore locked, but we
@@ -3228,7 +3235,12 @@ need_resched:
 	task->lock_depth = -1;
 #endif
 	__schedule();
-	local_irq_disable();
+
+	_hard_local_irq_disable();
+#ifdef CONFIG_RT_IRQ_DISABLE
+	local_irq_enable_noresched();
+#endif
+
 #ifdef CONFIG_PREEMPT_BKL
 	task->lock_depth = saved_lock_depth;
 #endif
@@ -4160,7 +4172,7 @@ asmlinkage long sys_sched_yield(void)
 	__preempt_enable_no_resched();
 
 	__schedule();
-	local_irq_enable();
+	hard_local_irq_enable();
 	preempt_check_resched();
 
 	return 0;
@@ -4173,11 +4185,11 @@ static void __cond_resched(void)
 	if (preempt_count() & PREEMPT_ACTIVE)
 		return;
 	do {
-		local_irq_disable();
+		hard_local_irq_disable();
 		add_preempt_count(PREEMPT_ACTIVE);
 		__schedule();
 	} while (need_resched());
-	local_irq_enable();
+	hard_local_irq_enable();
 }
 
 int __sched cond_resched(void)
Index: linux-2.6.11/kernel/timer.c
===================================================================
--- linux-2.6.11.orig/kernel/timer.c	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/kernel/timer.c	2005-06-08 01:09:15.000000000 +0000
@@ -437,9 +437,10 @@ static int cascade(tvec_base_t *base, tv
 static inline void __run_timers(tvec_base_t *base)
 {
 	struct timer_list *timer;
+	unsigned long jiffies_sample = jiffies;
 
 	spin_lock_irq(&base->lock);
-	while (time_after_eq(jiffies, base->timer_jiffies)) {
+	while (time_after_eq(jiffies_sample, base->timer_jiffies)) {
 		struct list_head work_list = LIST_HEAD_INIT(work_list);
 		struct list_head *head = &work_list;
  		int index = base->timer_jiffies & TVR_MASK;
Index: linux-2.6.11/lib/Kconfig.RT
===================================================================
--- linux-2.6.11.orig/lib/Kconfig.RT	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/lib/Kconfig.RT	2005-06-08 06:56:35.000000000 +0000
@@ -81,6 +81,25 @@ config PREEMPT_RT
 
 endchoice
 
+config RT_IRQ_DISABLE
+	bool "Real-Time IRQ Disable"
+	default y
+	depends on PREEMPT_RT
+	help
+	  This option will remove all local_irq_enable() and
+	  local_irq_disable() calls and replace them with soft
+	  versions. This will decrease the frequency that
+	  interrupt are disabled.
+
+	  All interrupts that are flagged with SA_NODELAY are
+	  considered hard interrupts. This option will force
+	  SA_NODELAY interrupts to run even when they normally
+	  wouldn't be enabled.
+
+	  Select this if you plan to use Linux in an 
+	  embedded enviorment that needs low interrupt
+	  latency.
+
 config PREEMPT
 	bool
 	default y
Index: linux-2.6.11/lib/kernel_lock.c
===================================================================
--- linux-2.6.11.orig/lib/kernel_lock.c	2005-06-08 00:33:21.000000000 +0000
+++ linux-2.6.11/lib/kernel_lock.c	2005-06-08 00:35:30.000000000 +0000
@@ -98,7 +98,8 @@ int __lockfunc __reacquire_kernel_lock(v
 	struct task_struct *task = current;
 	int saved_lock_depth = task->lock_depth;
 
-	local_irq_enable();
+	hard_local_irq_enable();
+
 	BUG_ON(saved_lock_depth < 0);
 
 	task->lock_depth = -1;
@@ -107,8 +108,8 @@ int __lockfunc __reacquire_kernel_lock(v
 
 	task->lock_depth = saved_lock_depth;
 
-	local_irq_disable();
-
+	hard_local_irq_disable();
+	
 	return 0;
 }
 


