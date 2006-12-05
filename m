Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968168AbWLELKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968168AbWLELKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 06:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968141AbWLELKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 06:10:14 -0500
Received: from madara.hpl.hp.com ([192.6.19.124]:64915 "EHLO madara.hpl.hp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759945AbWLELJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 06:09:19 -0500
Date: Tue, 5 Dec 2006 03:07:20 -0800
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200612051107.kB5B7KMe017703@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 19/21] 2.6.19 perfmon2 : modified x86_64 files
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the modified x86_64 files.

The modified files are as follows:

arch/x86_64/Kconfig:
	- add link to configuration menu in arch/x86_64/perfmon/Kconfig

arch/x86_64/Makefile:
	- add perfmon subdir

arch/x86_64/ia32/ia32entry.S:
	- add system call entry points for 32-bit ABI
	
arch/x86_64/kernel/apic.c:
	- add hook to call pfm_handle_switch_timeout() on timer tick for timeout based
	  set multiplexing

arch/x86_64/kernel/entry.S:
	- add pmu_interrupt stub

arch/x86_64/kernel/i8259.c:
	- PMU interrupt vector gate initialization

arch/x86_64/kernel/process.c:
	- add hook in exit_thread() to cleanup perfmon2 context
	- add hook in copy_thread() to cleanup perfmon2 context in child (perfmon2 context
	  is never inherited)
	- add hook in __switch_to() for PMU state save/restore
	- split enter_idle() is two. Until we get to 2.6.20, we need to add enter_idle() to the tail
	  of each interrupt handler due to idle loops. The loops are gone in 2.6.20.

arch/x86_64/kernel/signal.c:
	- add hook for extra work before kernel exit. Need to block a thread after a overflow with
	  user level notification. Also needed to do some bookeeeping, such as reset certain counters
	  and cleanup in some difficult corner cases

arch/x86_64/kernel/nmi.c:
	- use PERFCTR1 for architected PERFMON to allow PEBS use on Core-base processors

include/asm-x86_64/hw_irq.h:
	- define PMU interrupt vector

include/asm-x86_64/irq.h:
	- update FIRST_SYSTEM_VECTOR

include/asm-x86_64/thread_info.h:
	- add TIF_PERFMON which is used for PMU context switching in __switch_to()

include/asm-x86_64/unistd.h:
	- add new system calls



diff --exclude=.git -urp linux-2.6.19.base/arch/x86_64/Kconfig linux-2.6.19/arch/x86_64/Kconfig
--- linux-2.6.19.base/arch/x86_64/Kconfig	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/arch/x86_64/Kconfig	2006-12-03 14:15:48.000000000 -0800
@@ -587,6 +587,8 @@ config K8_NB
 	def_bool y
 	depends on AGP_AMD64 || IOMMU || (PCI && NUMA)
 
+source "arch/x86_64/perfmon/Kconfig"
+
 endmenu
 
 #
diff --exclude=.git -urp linux-2.6.19.base/arch/x86_64/Makefile linux-2.6.19/arch/x86_64/Makefile
--- linux-2.6.19.base/arch/x86_64/Makefile	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/arch/x86_64/Makefile	2006-12-03 14:15:48.000000000 -0800
@@ -81,6 +81,7 @@ core-y					+= arch/x86_64/kernel/ \
 					   arch/x86_64/crypto/
 core-$(CONFIG_IA32_EMULATION)		+= arch/x86_64/ia32/
 drivers-$(CONFIG_PCI)			+= arch/x86_64/pci/
+drivers-$(CONFIG_PERFMON)		+= arch/x86_64/perfmon/
 drivers-$(CONFIG_OPROFILE)		+= arch/x86_64/oprofile/
 
 boot := arch/x86_64/boot
diff --exclude=.git -urp linux-2.6.19.base/arch/x86_64/ia32/ia32entry.S linux-2.6.19/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.19.base/arch/x86_64/ia32/ia32entry.S	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/arch/x86_64/ia32/ia32entry.S	2006-12-03 14:15:48.000000000 -0800
@@ -718,4 +718,16 @@ ia32_sys_call_table:
 	.quad compat_sys_vmsplice
 	.quad compat_sys_move_pages
 	.quad sys_getcpu
+  	.quad sys_pfm_create_context
+  	.quad sys_pfm_write_pmcs
+  	.quad sys_pfm_write_pmds
+ 	.quad sys_pfm_read_pmds
+ 	.quad sys_pfm_load_context
+  	.quad sys_pfm_start
+  	.quad sys_pfm_stop
+  	.quad sys_pfm_restart
+  	.quad sys_pfm_create_evtsets
+  	.quad sys_pfm_getinfo_evtsets
+  	.quad sys_pfm_delete_evtsets
+  	.quad sys_pfm_unload_context
 ia32_syscall_end:		
diff --exclude=.git -urp linux-2.6.19.base/arch/x86_64/kernel/apic.c linux-2.6.19/arch/x86_64/kernel/apic.c
--- linux-2.6.19.base/arch/x86_64/kernel/apic.c	2006-12-03 14:24:40.000000000 -0800
+++ linux-2.6.19/arch/x86_64/kernel/apic.c	2006-12-03 14:15:48.000000000 -0800
@@ -25,6 +25,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/module.h>
+#include <linux/perfmon.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -888,6 +889,7 @@ void setup_APIC_extened_lvt(unsigned cha
 void smp_local_timer_interrupt(void)
 {
 	profile_tick(CPU_PROFILING);
+  	pfm_handle_switch_timeout();
 #ifdef CONFIG_SMP
 	update_process_times(user_mode(get_irq_regs()));
 #endif
diff --exclude=.git -urp linux-2.6.19.base/arch/x86_64/kernel/entry.S linux-2.6.19/arch/x86_64/kernel/entry.S
--- linux-2.6.19.base/arch/x86_64/kernel/entry.S	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/arch/x86_64/kernel/entry.S	2006-12-03 14:15:48.000000000 -0800
@@ -284,7 +284,7 @@ sysret_careful:
 sysret_signal:
 	TRACE_IRQS_ON
 	sti
-	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP),%edx
+	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP|_TIF_PERFMON_WORK),%edx
 	jz    1f
 
 	/* Really a signal */
@@ -399,7 +399,7 @@ int_very_careful:
 	jmp int_restore_rest
 	
 int_signal:
-	testl $(_TIF_NOTIFY_RESUME|_TIF_SIGPENDING|_TIF_SINGLESTEP),%edx
+	testl $(_TIF_NOTIFY_RESUME|_TIF_SIGPENDING|_TIF_SINGLESTEP|_TIF_PERFMON_WORK),%edx
 	jz 1f
 	movq %rsp,%rdi		# &ptregs -> arg1
 	xorl %esi,%esi		# oldset -> arg2
@@ -623,7 +623,7 @@ retint_careful:
 	jmp retint_check
 	
 retint_signal:
-	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP),%edx
+	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP|_TIF_PERFMON_WORK),%edx
 	jz    retint_swapgs
 	TRACE_IRQS_ON
 	sti
@@ -712,7 +712,12 @@ END(error_interrupt)
 ENTRY(spurious_interrupt)
 	apicinterrupt SPURIOUS_APIC_VECTOR,smp_spurious_interrupt
 END(spurious_interrupt)
-				
+
+#ifdef CONFIG_PERFMON
+ENTRY(pmu_interrupt)
+	apicinterrupt LOCAL_PERFMON_VECTOR,smp_pmu_interrupt
+#endif
+
 /*
  * Exception entry points.
  */ 		
diff --exclude=.git -urp linux-2.6.19.base/arch/x86_64/kernel/i8259.c linux-2.6.19/arch/x86_64/kernel/i8259.c
--- linux-2.6.19.base/arch/x86_64/kernel/i8259.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/arch/x86_64/kernel/i8259.c	2006-12-03 14:15:48.000000000 -0800
@@ -12,6 +12,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/bitops.h>
+#include <linux/perfmon.h>
 
 #include <asm/acpi.h>
 #include <asm/atomic.h>
@@ -551,7 +552,9 @@ void __init init_IRQ(void)
 	/* IPI vectors for APIC spurious and error interrupts */
 	set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
 	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
-
+#ifdef CONFIG_PERFMON
+	set_intr_gate(LOCAL_PERFMON_VECTOR, pmu_interrupt);
+#endif
 	/*
 	 * Set the clock to HZ Hz, we already have a valid
 	 * vector now:
diff --exclude=.git -urp linux-2.6.19.base/arch/x86_64/kernel/irq.c linux-2.6.19/arch/x86_64/kernel/irq.c
--- linux-2.6.19.base/arch/x86_64/kernel/irq.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/arch/x86_64/kernel/irq.c	2006-12-03 14:15:48.000000000 -0800
@@ -127,6 +127,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 	irq_exit();
 
 	set_irq_regs(old_regs);
+	enter_idle();
 	return 1;
 }
 
diff --exclude=.git -urp linux-2.6.19.base/arch/x86_64/kernel/nmi.c linux-2.6.19/arch/x86_64/kernel/nmi.c
--- linux-2.6.19.base/arch/x86_64/kernel/nmi.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/arch/x86_64/kernel/nmi.c	2006-12-04 07:45:45.000000000 -0800
@@ -271,7 +271,7 @@ int __init check_nmi_watchdog (void)
 		 * 32nd bit should be 1, for 33.. to be 1.
 		 * Find the appropriate nmi_hz
 		 */
-	 	if (wd->perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0 &&
+	 	if (wd->perfctr_msr == MSR_ARCH_PERFMON_PERFCTR1 &&
 			((u64)cpu_khz * 1000) > 0x7fffffffULL) {
 			nmi_hz = ((u64)cpu_khz * 1000) / 0x7fffffffUL + 1;
 		}
@@ -613,8 +613,8 @@ static int setup_intel_arch_watchdog(voi
 	    (ebx & ARCH_PERFMON_UNHALTED_CORE_CYCLES_PRESENT))
 		goto fail;
 
-	perfctr_msr = MSR_ARCH_PERFMON_PERFCTR0;
-	evntsel_msr = MSR_ARCH_PERFMON_EVENTSEL0;
+	perfctr_msr = MSR_ARCH_PERFMON_PERFCTR1;
+	evntsel_msr = MSR_ARCH_PERFMON_EVENTSEL1;
 
 	if (!reserve_perfctr_nmi(perfctr_msr))
 		goto fail;
@@ -842,7 +842,7 @@ int __kprobes nmi_watchdog_tick(struct p
 				dummy &= ~P4_CCCR_OVF;
 	 			wrmsrl(wd->cccr_msr, dummy);
 	 			apic_write(APIC_LVTPC, APIC_DM_NMI);
-	 		} else if (wd->perfctr_msr == MSR_ARCH_PERFMON_PERFCTR0) {
+	 		} else if (wd->perfctr_msr == MSR_ARCH_PERFMON_PERFCTR1) {
 				/*
 				 * ArchPerfom/Core Duo needs to re-unmask
 				 * the apic vector
diff --exclude=.git -urp linux-2.6.19.base/arch/x86_64/kernel/process.c linux-2.6.19/arch/x86_64/kernel/process.c
--- linux-2.6.19.base/arch/x86_64/kernel/process.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/arch/x86_64/kernel/process.c	2006-12-03 14:15:48.000000000 -0800
@@ -36,6 +36,7 @@
 #include <linux/random.h>
 #include <linux/notifier.h>
 #include <linux/kprobes.h>
+#include <linux/perfmon.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -80,12 +81,22 @@ void idle_notifier_unregister(struct not
 }
 EXPORT_SYMBOL(idle_notifier_unregister);
 
-void enter_idle(void)
+static void __enter_idle(void)
 {
 	write_pda(isidle, 1);
 	atomic_notifier_call_chain(&idle_notifier, IDLE_START, NULL);
 }
 
+/* Called from interrupts to signify idle end */
+void enter_idle(void)
+{
+	/* idle loop has pid 0 */
+	if (current->pid)
+		return;
+	__enter_idle();
+}
+
+
 static void __exit_idle(void)
 {
 	if (test_and_clear_bit_pda(0, isidle) == 0)
@@ -219,7 +230,7 @@ void cpu_idle (void)
 				idle = default_idle;
 			if (cpu_is_offline(smp_processor_id()))
 				play_dead();
-			enter_idle();
+			__enter_idle();
 			idle();
 			/* In many cases the interrupt that ended idle
 			   has already called exit_idle. But some idle
@@ -370,6 +381,7 @@ void exit_thread(void)
 		t->io_bitmap_max = 0;
 		put_cpu();
 	}
+	pfm_exit_thread(me);
 }
 
 void flush_thread(void)
@@ -475,6 +487,8 @@ int copy_thread(int nr, unsigned long cl
 	asm("mov %%es,%0" : "=m" (p->thread.es));
 	asm("mov %%ds,%0" : "=m" (p->thread.ds));
 
+	pfm_copy_thread(p);
+
 	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.io_bitmap_ptr) {
@@ -545,6 +559,10 @@ static inline void __switch_to_xtra(stru
 		 */
 		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
 	}
+
+	if (test_tsk_thread_flag(next_p, TIF_PERFMON_CTXSW)
+	    || test_tsk_thread_flag(prev_p, TIF_PERFMON_CTXSW))
+		pfm_ctxsw(prev_p, next_p);
 }
 
 /*
@@ -649,7 +667,7 @@ __switch_to(struct task_struct *prev_p, 
 	 * Now maybe reload the debug registers and handle I/O bitmaps
 	 */
 	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
-	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
+  	    || (task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW))
 		__switch_to_xtra(prev_p, next_p, tss);
 
 	/* If the task has used fpu the last 5 timeslices, just do a full
diff --exclude=.git -urp linux-2.6.19.base/arch/x86_64/kernel/setup64.c linux-2.6.19/arch/x86_64/kernel/setup64.c
--- linux-2.6.19.base/arch/x86_64/kernel/setup64.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/arch/x86_64/kernel/setup64.c	2006-12-03 14:15:48.000000000 -0800
@@ -11,6 +11,7 @@
 #include <linux/bootmem.h>
 #include <linux/bitops.h>
 #include <linux/module.h>
+#include <linux/perfmon.h>
 #include <asm/bootsetup.h>
 #include <asm/pda.h>
 #include <asm/pgtable.h>
@@ -285,4 +286,6 @@ void __cpuinit cpu_init (void)
 	fpu_init(); 
 
 	raw_local_save_flags(kernel_eflags);
+
+ 	pfm_init_percpu();
 }
diff --exclude=.git -urp linux-2.6.19.base/arch/x86_64/kernel/signal.c linux-2.6.19/arch/x86_64/kernel/signal.c
--- linux-2.6.19.base/arch/x86_64/kernel/signal.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/arch/x86_64/kernel/signal.c	2006-12-03 14:15:48.000000000 -0800
@@ -22,6 +22,7 @@
 #include <linux/stddef.h>
 #include <linux/personality.h>
 #include <linux/compiler.h>
+#include <linux/perfmon.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -466,13 +467,16 @@ do_notify_resume(struct pt_regs *regs, v
 	printk("do_notify_resume flags:%x rip:%lx rsp:%lx caller:%lx pending:%lx\n",
 	       thread_info_flags, regs->rip, regs->rsp, __builtin_return_address(0),signal_pending(current)); 
 #endif
-	       
+
 	/* Pending single-step? */
 	if (thread_info_flags & _TIF_SINGLESTEP) {
 		regs->eflags |= TF_MASK;
 		clear_thread_flag(TIF_SINGLESTEP);
 	}
 
+	if (thread_info_flags & _TIF_PERFMON_WORK)
+		pfm_handle_work();
+
 	/* deal with pending signal delivery */
 	if (thread_info_flags & (_TIF_SIGPENDING|_TIF_RESTORE_SIGMASK))
 		do_signal(regs);
diff --exclude=.git -urp linux-2.6.19.base/arch/x86_64/kernel/smpboot.c linux-2.6.19/arch/x86_64/kernel/smpboot.c
--- linux-2.6.19.base/arch/x86_64/kernel/smpboot.c	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/arch/x86_64/kernel/smpboot.c	2006-12-03 14:15:48.000000000 -0800
@@ -49,6 +49,7 @@
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
 #include <linux/smp.h>
+#include <linux/perfmon.h>
 
 #include <asm/mtrr.h>
 #include <asm/pgalloc.h>
@@ -1255,6 +1256,7 @@ int __cpu_disable(void)
 	spin_unlock(&vector_lock);
 	remove_cpu_from_maps();
 	fixup_irqs(cpu_online_map);
+	pfm_cpu_disable();
 	return 0;
 }
 
Only in linux-2.6.19/arch/x86_64: perfmon
diff --exclude=.git -urp linux-2.6.19.base/include/asm-x86_64/hw_irq.h linux-2.6.19/include/asm-x86_64/hw_irq.h
--- linux-2.6.19.base/include/asm-x86_64/hw_irq.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/include/asm-x86_64/hw_irq.h	2006-12-03 14:15:48.000000000 -0800
@@ -63,6 +63,7 @@
  * sources per level' errata.
  */
 #define LOCAL_TIMER_VECTOR	0xef
+#define LOCAL_PERFMON_VECTOR	0xee
 
 /*
  * First APIC vector available to drivers: (vectors 0x30-0xee)
Only in linux-2.6.19/include/asm-x86_64: perfmon.h
Only in linux-2.6.19/include/asm-x86_64: perfmon_pebs_smpl.h
diff --exclude=.git -urp linux-2.6.19.base/include/asm-x86_64/thread_info.h linux-2.6.19/include/asm-x86_64/thread_info.h
--- linux-2.6.19.base/include/asm-x86_64/thread_info.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/include/asm-x86_64/thread_info.h	2006-12-03 14:15:48.000000000 -0800
@@ -115,6 +115,7 @@ static inline struct thread_info *stack_
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal */
+#define TIF_PERFMON_WORK	10	/* work for pfm_handle_work() */
 /* 16 free */
 #define TIF_IA32		17	/* 32bit process */ 
 #define TIF_FORK		18	/* ret_from_fork */
@@ -122,6 +123,7 @@ static inline struct thread_info *stack_
 #define TIF_MEMDIE		20
 #define TIF_DEBUG		21	/* uses debug registers */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
+#define TIF_PERFMON_CTXSW	23	/* perfmon needs ctxsw calls */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -137,6 +139,8 @@ static inline struct thread_info *stack_
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
 #define _TIF_DEBUG		(1<<TIF_DEBUG)
 #define _TIF_IO_BITMAP		(1<<TIF_IO_BITMAP)
+#define _TIF_PERFMON_WORK	(1<<TIF_PERFMON_WORK)
+#define _TIF_PERFMON_CTXSW	(1<<TIF_PERFMON_CTXSW)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
@@ -145,7 +149,7 @@ static inline struct thread_info *stack_
 #define _TIF_ALLWORK_MASK (0x0000FFFF & ~_TIF_SECCOMP)
 
 /* flags to check in __switch_to() */
-#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP)
+#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP|_TIF_PERFMON_CTXSW)
 
 #define PREEMPT_ACTIVE     0x10000000
 
diff --exclude=.git -urp linux-2.6.19.base/include/asm-x86_64/unistd.h linux-2.6.19/include/asm-x86_64/unistd.h
--- linux-2.6.19.base/include/asm-x86_64/unistd.h	2006-11-29 13:57:37.000000000 -0800
+++ linux-2.6.19/include/asm-x86_64/unistd.h	2006-12-03 14:15:48.000000000 -0800
@@ -619,8 +619,32 @@ __SYSCALL(__NR_sync_file_range, sys_sync
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
 #define __NR_move_pages		279
 __SYSCALL(__NR_move_pages, sys_move_pages)
+#define __NR_pfm_create_context	280
+__SYSCALL(__NR_pfm_create_context, sys_pfm_create_context)
+#define __NR_pfm_write_pmcs	(__NR_pfm_create_context+1)
+__SYSCALL(__NR_pfm_write_pmcs, sys_pfm_write_pmcs)
+#define __NR_pfm_write_pmds	(__NR_pfm_create_context+2)
+__SYSCALL(__NR_pfm_write_pmds, sys_pfm_write_pmds)
+#define __NR_pfm_read_pmds	(__NR_pfm_create_context+3)
+__SYSCALL(__NR_pfm_read_pmds, sys_pfm_read_pmds)
+#define __NR_pfm_load_context	(__NR_pfm_create_context+4)
+__SYSCALL(__NR_pfm_load_context, sys_pfm_load_context)
+#define __NR_pfm_start		(__NR_pfm_create_context+5)
+__SYSCALL(__NR_pfm_start, sys_pfm_start)
+#define __NR_pfm_stop		(__NR_pfm_create_context+6)
+__SYSCALL(__NR_pfm_stop, sys_pfm_stop)
+#define __NR_pfm_restart	(__NR_pfm_create_context+7)
+__SYSCALL(__NR_pfm_restart, sys_pfm_restart)
+#define __NR_pfm_create_evtsets	(__NR_pfm_create_context+8)
+__SYSCALL(__NR_pfm_create_evtsets, sys_pfm_create_evtsets)
+#define __NR_pfm_getinfo_evtsets (__NR_pfm_create_context+9)
+__SYSCALL(__NR_pfm_getinfo_evtsets, sys_pfm_getinfo_evtsets)
+#define __NR_pfm_delete_evtsets (__NR_pfm_create_context+10)
+__SYSCALL(__NR_pfm_delete_evtsets, sys_pfm_delete_evtsets)
+#define __NR_pfm_unload_context	(__NR_pfm_create_context+11)
+__SYSCALL(__NR_pfm_unload_context, sys_pfm_unload_context)
 
-#define __NR_syscall_max __NR_move_pages
+#define __NR_syscall_max __NR_pfm_unload_context
 
 #ifdef __KERNEL__
 #include <linux/err.h>
