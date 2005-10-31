Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbVJaVmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbVJaVmF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVJaVmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:42:00 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:60390 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964851AbVJaVl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:41:58 -0500
Date: Mon, 31 Oct 2005 22:42:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>, Dave Jones <davej@codemonkey.org.uk>
Subject: [patch] preempt-trace.patch
Message-ID: <20051031214202.GA17489@elte.hu>
References: <200510311606.36615.rjw@sisk.pl> <20051031113413.34a599cd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051031113413.34a599cd.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Well I can't find it.  Ingo, didn't you have a debug patch which would 
> help us identify where this atomic section started?

yes. Find below the preempt-trace.patch, updated and merged to 2.6.14.

Rafael, just enable CONFIG_DEBUG_PREEMPT and repeat the reproducer.

Works fine on x86 and x64, and should not break other architectures. Has 
been included in the -rt tree for quite some time.  It is certainly a 
useful debugging feature. Could we add this to -mm, with an focus on 
getting this upstream eventually?

	Ingo

-----
this implements the "non-preemptible section trace" feature, which 
prints out a "critical section nesting" trace after stackdumps.

sample output on x86:

 Call Trace:
  [<c0103db1>] show_stack+0x7a/0x90
  [<c0103f36>] show_registers+0x156/0x1ce
  [<c010412e>] die+0xe8/0x172
  [<c010422e>] do_trap+0x76/0xa3
  [<c01044fe>] do_invalid_op+0xa3/0xad
  [<c01039ef>] error_code+0x4f/0x54
  [<c0120be9>] test+0x8/0xa
  [<c0120c41>] sys_gettimeofday+0x56/0x74
  [<c0102eeb>] sysenter_past_esp+0x54/0x75
 ---------------------------
 | preempt count: 00000004 ]
 | 4 levels deep critical section nesting:
 -----------------------------------------
 .. [<c0120bbe>] .... test3+0xd/0xf
 .....[<c0120bc8>] ..   ( <= test2+0x8/0x21)
 .. [<c0120bbe>] .... test3+0xd/0xf
 .....[<c0120bcd>] ..   ( <= test2+0xd/0x21)
 .. [<c0120bd7>] .... test2+0x17/0x21
 .....[<c0120be9>] ..   ( <= test+0x8/0xa)
 .. [<c010407f>] .... die+0x39/0x172
 .....[<c010422e>] ..   ( <= do_trap+0x76/0xa3)

sample output on x64:


 Call Trace:<ffffffff8012373c>{sys32_gettimeofday+60} <ffffffff80122af3>{cstar_do_call+27}

 ---------------------------
 | preempt count: 00000002 ]
 | 2 level deep critical section nesting:
 ----------------------------------------
 .. [<ffffffff8012372d>] .... sys32_gettimeofday+0x2d/0x110
 .....[<ffffffff80122af3>] ..   ( <= cstar_do_call+0x1b/0x60)
 .. [<ffffffff80123737>] .... sys32_gettimeofday+0x37/0x110
 .....[<ffffffff80122af3>] ..   ( <= cstar_do_call+0x1b/0x60)


this feature is implemented via a low-overhead mechanism by keeping
the caller and caller-parent addresses for each disable_preempt()
call site, and printing it upon crashes. Note that every other
locking API is thus traced too, such as spinlocks, rwlocks, per-cpu
variables, etc. This feature is especially useful in identifying
leaked preemption counts, as the missing count is displayed as an
extra entry in the stack.

the feature is active when DEBUG_PREEMPT is enabled.

i've also cleaned up preemption-count debugging by moving the debug
functions out of sched.c into lib/preempt.c.

also, i have added preemption-counter-imbalance checks to the hardirq
and softirq processing codepaths. The behavior of preemption-counter
checks is now uniform: a warning is printed with all info we have at
that point, and the preemption counter is then restored to the old
value.

on x86 i have changed the 4KSTACKS feature to inherit the low bits of
the preemption-count across hardirq/softirq-context switching, so that
the preemption trace entries of interrupts do not overwrite process
level preemption trace entries.

boot- and functionality-tested on x86 and x64. Should work on all
architectures, but only x86 and x64 has been updated to print the
trace-stack out at stackdump time.  

This feature has been part of the -rt tree for quite some time and was
very useful in debugging preempt-counter leaks, deadlock and lockup
situations.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 arch/i386/kernel/irq.c       |   28 +++++++++++
 arch/i386/kernel/traps.c     |    1 
 arch/x86_64/kernel/process.c |    2 
 arch/x86_64/kernel/traps.c   |   13 ++---
 include/asm-x86_64/proto.h   |    2 
 include/linux/sched.h        |   13 +++++
 kernel/exit.c                |    9 ++-
 kernel/irq/handle.c          |   17 +++++++
 kernel/sched.c               |   33 --------------
 kernel/softirq.c             |   17 +++++++
 kernel/timer.c               |   27 ++++++-----
 lib/Kconfig.debug            |    2 
 lib/Makefile                 |    2 
 lib/preempt.c                |  101 +++++++++++++++++++++++++++++++++++++++++++
 14 files changed, 211 insertions(+), 56 deletions(-)

Index: linux/arch/i386/kernel/irq.c
===================================================================
--- linux.orig/arch/i386/kernel/irq.c
+++ linux/arch/i386/kernel/irq.c
@@ -55,6 +55,9 @@ fastcall unsigned int do_IRQ(struct pt_r
 {	
 	/* high bits used in ret_from_ code */
 	int irq = regs->orig_eax & 0xff;
+#ifdef CONFIG_DEBUG_PREEMPT
+	u32 count = preempt_count() & PREEMPT_MASK;
+#endif
 #ifdef CONFIG_4KSTACKS
 	union irq_ctx *curctx, *irqctx;
 	u32 *isp;
@@ -95,6 +98,14 @@ fastcall unsigned int do_IRQ(struct pt_r
 		irqctx->tinfo.task = curctx->tinfo.task;
 		irqctx->tinfo.previous_esp = current_stack_pointer;
 
+		/*
+		 * Keep the preemption-count offset, so that the
+		 * process-level preemption-trace entries do not
+		 * get overwritten by the hardirq context:
+		 */
+#ifdef CONFIG_DEBUG_PREEMPT
+		irqctx->tinfo.preempt_count += count;
+#endif
 		asm volatile(
 			"       xchgl   %%ebx,%%esp      \n"
 			"       call    __do_IRQ         \n"
@@ -103,6 +114,9 @@ fastcall unsigned int do_IRQ(struct pt_r
 			:  "0" (irq),   "1" (regs),  "2" (isp)
 			: "memory", "cc", "ecx"
 		);
+#ifdef CONFIG_DEBUG_PREEMPT
+		irqctx->tinfo.preempt_count -= count;
+#endif
 	} else
 #endif
 		__do_IRQ(irq, regs);
@@ -165,6 +179,9 @@ extern asmlinkage void __do_softirq(void
 
 asmlinkage void do_softirq(void)
 {
+#ifdef CONFIG_DEBUG_PREEMPT
+	u32 count = preempt_count() & PREEMPT_MASK;
+#endif
 	unsigned long flags;
 	struct thread_info *curctx;
 	union irq_ctx *irqctx;
@@ -181,6 +198,14 @@ asmlinkage void do_softirq(void)
 		irqctx->tinfo.task = curctx->task;
 		irqctx->tinfo.previous_esp = current_stack_pointer;
 
+		/*
+		 * Keep the preemption-count offset, so that the
+		 * process-level preemption-trace entries do not
+		 * get overwritten by the softirq context:
+		 */
+#ifdef CONFIG_DEBUG_PREEMPT
+		irqctx->tinfo.preempt_count += count;
+#endif
 		/* build the stack frame on the softirq stack */
 		isp = (u32*) ((char*)irqctx + sizeof(*irqctx));
 
@@ -192,6 +217,9 @@ asmlinkage void do_softirq(void)
 			: "0"(isp)
 			: "memory", "cc", "edx", "ecx", "eax"
 		);
+#ifdef CONFIG_DEBUG_PREEMPT
+		irqctx->tinfo.preempt_count -= count;
+#endif
 	}
 
 	local_irq_restore(flags);
Index: linux/arch/i386/kernel/traps.c
===================================================================
--- linux.orig/arch/i386/kernel/traps.c
+++ linux/arch/i386/kernel/traps.c
@@ -163,6 +163,7 @@ void show_trace(struct task_struct *task
 			break;
 		printk(" =======================\n");
 	}
+	print_preempt_trace(task, task->thread_info->preempt_count);
 }
 
 void show_stack(struct task_struct *task, unsigned long *esp)
Index: linux/arch/x86_64/kernel/process.c
===================================================================
--- linux.orig/arch/x86_64/kernel/process.c
+++ linux/arch/x86_64/kernel/process.c
@@ -315,7 +315,7 @@ void show_regs(struct pt_regs *regs)
 {
 	printk("CPU %d:", smp_processor_id());
 	__show_regs(regs);
-	show_trace(&regs->rsp);
+	show_trace(current, &regs->rsp);
 }
 
 /*
Index: linux/arch/x86_64/kernel/traps.c
===================================================================
--- linux.orig/arch/x86_64/kernel/traps.c
+++ linux/arch/x86_64/kernel/traps.c
@@ -154,7 +154,7 @@ static unsigned long *in_exception_stack
  * severe exception (double fault, nmi, stack fault, debug, mce) hardware stack
  */
 
-void show_trace(unsigned long *stack)
+void show_trace(struct task_struct *task, unsigned long *stack)
 {
 	unsigned long addr;
 	const unsigned cpu = safe_smp_processor_id();
@@ -219,9 +219,10 @@ void show_trace(unsigned long *stack)
 	HANDLE_STACK (((long) stack & (THREAD_SIZE-1)) != 0);
 #undef HANDLE_STACK
 	printk("\n");
+	print_preempt_trace(task, task->thread_info->preempt_count);
 }
 
-void show_stack(struct task_struct *tsk, unsigned long * rsp)
+void show_stack(struct task_struct *task, unsigned long * rsp)
 {
 	unsigned long *stack;
 	int i;
@@ -233,8 +234,8 @@ void show_stack(struct task_struct *tsk,
 	// back trace for this cpu.
 
 	if (rsp == NULL) {
-		if (tsk)
-			rsp = (unsigned long *)tsk->thread.rsp;
+		if (task)
+			rsp = (unsigned long *)task->thread.rsp;
 		else
 			rsp = (unsigned long *)&rsp;
 	}
@@ -255,7 +256,7 @@ void show_stack(struct task_struct *tsk,
 		printk("%016lx ", *stack++);
 		touch_nmi_watchdog();
 	}
-	show_trace((unsigned long *)rsp);
+	show_trace(task, (unsigned long *)rsp);
 }
 
 /*
@@ -264,7 +265,7 @@ void show_stack(struct task_struct *tsk,
 void dump_stack(void)
 {
 	unsigned long dummy;
-	show_trace(&dummy);
+	show_trace(current, &dummy);
 }
 
 EXPORT_SYMBOL(dump_stack);
Index: linux/include/asm-x86_64/proto.h
===================================================================
--- linux.orig/include/asm-x86_64/proto.h
+++ linux/include/asm-x86_64/proto.h
@@ -65,7 +65,7 @@ extern unsigned long end_pfn_map; 
 
 extern cpumask_t cpu_initialized;
 
-extern void show_trace(unsigned long * rsp);
+extern void show_trace(struct task_struct *task, unsigned long * rsp);
 extern void show_registers(struct pt_regs *regs);
 
 extern void exception_table_check(void);
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h
+++ linux/include/linux/sched.h
@@ -592,6 +592,14 @@ extern void partition_sched_domains(cpum
 				    cpumask_t *partition2);
 #endif /* CONFIG_SMP */
 
+#ifdef CONFIG_DEBUG_PREEMPT
+# define MAX_PREEMPT_TRACE 25
+extern void print_preempt_trace(struct task_struct *task, u32 count);
+#else
+static inline void print_preempt_trace(struct task_struct *task, u32 count)
+{
+}
+#endif
 
 struct io_context;			/* See blkdev.h */
 void exit_io_context(void);
@@ -813,6 +821,11 @@ struct task_struct {
 	int cpuset_mems_generation;
 #endif
 	atomic_t fs_excl;	/* holding fs exclusive resources */
+
+#ifdef CONFIG_DEBUG_PREEMPT
+	void *preempt_off_caller[MAX_PREEMPT_TRACE];
+	void *preempt_off_parent[MAX_PREEMPT_TRACE];
+#endif
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c
+++ linux/kernel/exit.c
@@ -833,10 +833,11 @@ fastcall NORET_TYPE void do_exit(long co
  	tsk->it_prof_expires = cputime_zero;
 	tsk->it_sched_expires = 0;
 
-	if (unlikely(in_atomic()))
-		printk(KERN_INFO "note: %s[%d] exited with preempt_count %d\n",
-				current->comm, current->pid,
-				preempt_count());
+	if (unlikely(in_atomic())) {
+		printk(KERN_ERR "BUG: %s[%d] exited with nonzero preempt_count %d!\n",
+				tsk->comm, tsk->pid, preempt_count());
+		print_preempt_trace(tsk, preempt_count());
+	}
 
 	acct_update_integrals(tsk);
 	update_mem_hiwater(tsk);
Index: linux/kernel/irq/handle.c
===================================================================
--- linux.orig/kernel/irq/handle.c
+++ linux/kernel/irq/handle.c
@@ -85,7 +85,24 @@ fastcall int handle_IRQ_event(unsigned i
 		local_irq_enable();
 
 	do {
+#ifdef CONFIG_DEBUG_PREEMPT
+		u32 in_count = preempt_count(), out_count;
+#endif
 		ret = action->handler(irq, action->dev_id, regs);
+#ifdef CONFIG_DEBUG_PREEMPT
+		out_count = preempt_count();
+		if (in_count != out_count) {
+			printk(KERN_ERR "BUG: irq %d [%s] preempt-count "
+				"imbalance: in=%08x, out=%08x!\n",
+				irq, action->name, in_count, out_count);
+			print_preempt_trace(current, out_count);
+			/*
+			 * We already printed all the useful info,
+			 * fix up the preemption count now:
+			 */
+			preempt_count() = in_count;
+		}
+#endif
 		if (ret == IRQ_HANDLED)
 			status |= action->flags;
 		retval |= ret;
Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c
+++ linux/kernel/sched.c
@@ -47,6 +47,7 @@
 #include <linux/syscalls.h>
 #include <linux/times.h>
 #include <linux/acct.h>
+#include <linux/kallsyms.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -2809,38 +2810,6 @@ static inline int dependent_sleeper(int 
 }
 #endif
 
-#if defined(CONFIG_PREEMPT) && defined(CONFIG_DEBUG_PREEMPT)
-
-void fastcall add_preempt_count(int val)
-{
-	/*
-	 * Underflow?
-	 */
-	BUG_ON((preempt_count() < 0));
-	preempt_count() += val;
-	/*
-	 * Spinlock count overflowing soon?
-	 */
-	BUG_ON((preempt_count() & PREEMPT_MASK) >= PREEMPT_MASK-10);
-}
-EXPORT_SYMBOL(add_preempt_count);
-
-void fastcall sub_preempt_count(int val)
-{
-	/*
-	 * Underflow?
-	 */
-	BUG_ON(val > preempt_count());
-	/*
-	 * Is the spinlock portion underflowing?
-	 */
-	BUG_ON((val < PREEMPT_MASK) && !(preempt_count() & PREEMPT_MASK));
-	preempt_count() -= val;
-}
-EXPORT_SYMBOL(sub_preempt_count);
-
-#endif
-
 /*
  * schedule() is the main scheduler function.
  */
Index: linux/kernel/softirq.c
===================================================================
--- linux.orig/kernel/softirq.c
+++ linux/kernel/softirq.c
@@ -92,7 +92,24 @@ restart:
 
 	do {
 		if (pending & 1) {
+#ifdef CONFIG_DEBUG_PREEMPT
+			u32 in_count = preempt_count(), out_count;
+#endif
 			h->action(h);
+#ifdef CONFIG_DEBUG_PREEMPT
+			out_count = preempt_count();
+			if (in_count != out_count) {
+				printk(KERN_ERR "BUG: softirq %ld preempt-count"
+					" imbalance: in=%08x, out=%08x!\n",
+					(long)(h - softirq_vec),
+					in_count, out_count);
+				print_preempt_trace(current, out_count);
+				/*
+				 * Fix up the bad preemption count:
+				 */
+				preempt_count() = in_count;
+			}
+#endif
 			rcu_bh_qsctr_inc(cpu);
 		}
 		h++;
Index: linux/kernel/timer.c
===================================================================
--- linux.orig/kernel/timer.c
+++ linux/kernel/timer.c
@@ -33,6 +33,7 @@
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
 #include <linux/syscalls.h>
+#include <linux/kallsyms.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -480,6 +481,7 @@ static inline void __run_timers(tvec_bas
 		while (!list_empty(head)) {
 			void (*fn)(unsigned long);
 			unsigned long data;
+			int in_count, out_count;
 
 			timer = list_entry(head->next,struct timer_list,entry);
  			fn = timer->function;
@@ -488,17 +490,20 @@ static inline void __run_timers(tvec_bas
 			set_running_timer(base, timer);
 			detach_timer(timer, 1);
 			spin_unlock_irq(&base->t_base.lock);
-			{
-				int preempt_count = preempt_count();
-				fn(data);
-				if (preempt_count != preempt_count()) {
-					printk(KERN_WARNING "huh, entered %p "
-					       "with preempt_count %08x, exited"
-					       " with %08x?\n",
-					       fn, preempt_count,
-					       preempt_count());
-					BUG();
-				}
+
+			in_count = preempt_count();
+			fn(data);
+			out_count = preempt_count();
+			if (in_count != out_count) {
+				print_symbol(KERN_ERR "BUG: %s", (long)fn);
+				printk(KERN_ERR "(%p) preempt-count imbalance: "
+					"in=%08x, out=%08x!",
+					fn, in_count, out_count);
+				print_preempt_trace(current, out_count);
+				/*
+				 * Fix up the bad preemption count:
+				 */
+				preempt_count() = in_count;
 			}
 			spin_lock_irq(&base->t_base.lock);
 		}
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -88,6 +88,8 @@ config DEBUG_SLAB
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT
+	select FRAME_POINTER
+	select KALLSYMS_ALL
 	default y
 	help
 	  If you say Y here then the kernel will use a debug variant of the
Index: linux/lib/Makefile
===================================================================
--- linux.orig/lib/Makefile
+++ linux/lib/Makefile
@@ -22,7 +22,7 @@ lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) +=
 lib-$(CONFIG_SEMAPHORE_SLEEPERS) += semaphore-sleepers.o
 lib-$(CONFIG_GENERIC_FIND_NEXT_BIT) += find_next_bit.o
 obj-$(CONFIG_LOCK_KERNEL) += kernel_lock.o
-obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
+obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o preempt.o
 
 ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
   lib-y += dec_and_lock.o
Index: linux/lib/preempt.c
===================================================================
--- /dev/null
+++ linux/lib/preempt.c
@@ -0,0 +1,101 @@
+/*
+ * lib/preempt.c
+ *
+ * DEBUG_PREEMPT variant of add_preempt_count() and sub_preempt_count().
+ * Preemption tracing.
+ *
+ * (C) 2005 Ingo Molnar, Red Hat
+ */
+#include <linux/module.h>
+#include <linux/hardirq.h>
+#include <linux/kallsyms.h>
+
+/*
+ * Add a value to the preemption count, and check for overflows,
+ * underflows and maintain a small stack of callers that gets
+ * printed upon crashes.
+ */
+void fastcall add_preempt_count(int val)
+{
+	unsigned int count = preempt_count(), idx = count & PREEMPT_MASK;
+
+	/*
+	 * Underflow?
+	 */
+	BUG_ON(count < 0);
+
+	preempt_count() += val;
+
+	/*
+	 * Spinlock count overflowing soon?
+	 */
+	BUG_ON(idx >= PREEMPT_MASK-10);
+
+	/*
+	 * Maintain the per-task preemption-nesting stack (which
+	 * will be printed upon crashes). It's a low-overhead thing,
+	 * constant overhead per preempt-disable.
+	 */
+	if (idx < MAX_PREEMPT_TRACE) {
+		void *caller = __builtin_return_address(0), *parent = NULL;
+
+#ifdef CONFIG_FRAME_POINTER
+		parent = __builtin_return_address(1);
+		if (in_lock_functions((unsigned long)parent)) {
+			parent = __builtin_return_address(2);
+			if (in_lock_functions((unsigned long)parent))
+				parent = __builtin_return_address(3);
+		}
+#endif
+		current->preempt_off_caller[idx] = caller;
+		current->preempt_off_parent[idx] = parent;
+	}
+}
+EXPORT_SYMBOL(add_preempt_count);
+
+void fastcall sub_preempt_count(int val)
+{
+	unsigned int count = preempt_count();
+
+	/*
+	 * Underflow?
+	 */
+	BUG_ON(val > count);
+	/*
+	 * Is the spinlock portion underflowing?
+	 */
+	BUG_ON((val < PREEMPT_MASK) && !(count & PREEMPT_MASK));
+
+	preempt_count() -= val;
+}
+EXPORT_SYMBOL(sub_preempt_count);
+
+void print_preempt_trace(struct task_struct *task, u32 count)
+{
+	unsigned int i, idx = count & PREEMPT_MASK;
+
+	preempt_disable();
+
+	printk("---------------------------\n");
+	printk("| preempt count: %08x ]\n", count);
+	if (count) {
+		printk("| %d level deep critical section nesting:\n", idx);
+		printk("----------------------------------------\n");
+	} else
+		printk("---------------------------\n");
+	for (i = 0; i < idx; i++) {
+		printk(".. [<%p>] .... ", task->preempt_off_caller[i]);
+		print_symbol("%s\n", (long)task->preempt_off_caller[i]);
+		printk(".....[<%p>] ..   ( <= ",
+				task->preempt_off_parent[i]);
+		print_symbol("%s)\n", (long)task->preempt_off_parent[i]);
+		if (i == MAX_PREEMPT_TRACE-1) {
+			printk("[rest truncated, reached MAX_PREEMPT_TRACE]\n");
+			break;
+		}
+	}
+	printk("\n");
+
+	preempt_enable();
+}
+
