Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751881AbWJIONb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbWJIONb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932881AbWJIOLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:11:42 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:32241 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932882AbWJIOLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:11:19 -0400
Date: Mon, 9 Oct 2006 07:10:27 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EARCR026245@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 19/21] 2.6.18 perfmon2 : modified x86_64 files
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

arch/x86_64/kernel/signal.c:
	- add hook for extra work before kernel exit. Need to block a thread after a overflow with
	  user level notification. Also needed to do some bookeeeping, such as reset certain counters
	  and cleanup in some difficult corner cases

arch/x86_64/kernel/nmi.c:
	- when nmi watchdog is using a performance counter, it needs to share the PMU with perfmon.
	  This means that perfmon works with one less counters (AMD K8), and it must use the NMI
	  interrupt vector rather than a lower priority vector. In nmi_watchdog_tick() we need to check
	  if the NMI counter overflowed. If so, then this is a NMI watchdog event, otherwise, we forward
	  to perfmon. The current code does not work with Intel P4 (EM64T).

include/asm-x86_64/hw_irq.h:
	- define PMU interrupt vector

include/asm-x86_64/irq.h:
	- update FIRST_SYSTEM_VECTOR

include/asm-x86_64/thread_info.h:
	- add TIF_PERFMON which is used for PMU context switching in __switch_to()

include/asm-x86_64/unistd.h:
	- add new system calls


diff -urp linux-2.6.18.base/arch/x86_64/Kconfig linux-2.6.18/arch/x86_64/Kconfig
--- linux-2.6.18.base/arch/x86_64/Kconfig	2006-09-21 23:45:12.000000000 -0700
+++ linux-2.6.18/arch/x86_64/Kconfig	2006-09-22 01:58:48.000000000 -0700
@@ -540,6 +540,8 @@ config K8_NB
 	def_bool y
 	depends on AGP_AMD64 || IOMMU || (PCI && NUMA)
 
+source "arch/x86_64/perfmon/Kconfig"
+
 endmenu
 
 #
diff -urp linux-2.6.18.base/arch/x86_64/Makefile linux-2.6.18/arch/x86_64/Makefile
--- linux-2.6.18.base/arch/x86_64/Makefile	2006-09-21 23:45:12.000000000 -0700
+++ linux-2.6.18/arch/x86_64/Makefile	2006-09-22 01:58:48.000000000 -0700
@@ -67,6 +67,7 @@ core-y					+= arch/x86_64/kernel/ \
 					   arch/x86_64/crypto/
 core-$(CONFIG_IA32_EMULATION)		+= arch/x86_64/ia32/
 drivers-$(CONFIG_PCI)			+= arch/x86_64/pci/
+drivers-$(CONFIG_PERFMON)		+= arch/x86_64/perfmon/
 drivers-$(CONFIG_OPROFILE)		+= arch/x86_64/oprofile/
 
 boot := arch/x86_64/boot
diff -urp linux-2.6.18.base/arch/x86_64/ia32/ia32entry.S linux-2.6.18/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.18.base/arch/x86_64/ia32/ia32entry.S	2006-09-21 23:45:12.000000000 -0700
+++ linux-2.6.18/arch/x86_64/ia32/ia32entry.S	2006-09-22 02:24:26.000000000 -0700
@@ -713,4 +713,16 @@ ia32_sys_call_table:
 	.quad sys_tee
 	.quad compat_sys_vmsplice
 	.quad compat_sys_move_pages
-ia32_syscall_end:		
+ 	.quad sys_pfm_create_context
+ 	.quad sys_pfm_write_pmcs
+ 	.quad sys_pfm_write_pmds
+	.quad sys_pfm_read_pmds
+	.quad sys_pfm_load_context
+ 	.quad sys_pfm_start
+ 	.quad sys_pfm_stop
+ 	.quad sys_pfm_restart
+ 	.quad sys_pfm_create_evtsets
+ 	.quad sys_pfm_getinfo_evtsets
+ 	.quad sys_pfm_delete_evtsets
+ 	.quad sys_pfm_unload_context
+ia32_syscall_end:
diff -urp linux-2.6.18.base/arch/x86_64/kernel/apic.c linux-2.6.18/arch/x86_64/kernel/apic.c
--- linux-2.6.18.base/arch/x86_64/kernel/apic.c	2006-09-21 23:48:08.000000000 -0700
+++ linux-2.6.18/arch/x86_64/kernel/apic.c	2006-09-22 01:58:48.000000000 -0700
@@ -25,6 +25,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/module.h>
+#include <linux/perfmon.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -942,6 +943,7 @@ void setup_APIC_extened_lvt(unsigned cha
 void smp_local_timer_interrupt(struct pt_regs *regs)
 {
 	profile_tick(CPU_PROFILING, regs);
+ 	pfm_handle_switch_timeout();
 #ifdef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urp linux-2.6.18.base/arch/x86_64/kernel/entry.S linux-2.6.18/arch/x86_64/kernel/entry.S
--- linux-2.6.18.base/arch/x86_64/kernel/entry.S	2006-09-21 23:45:12.000000000 -0700
+++ linux-2.6.18/arch/x86_64/kernel/entry.S	2006-09-22 02:22:46.000000000 -0700
@@ -270,7 +270,7 @@ sysret_careful:
 sysret_signal:
 	TRACE_IRQS_ON
 	sti
-	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP),%edx
+	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP|_TIF_PERFMON_WORK),%edx
 	jz    1f
 
 	/* Really a signal */
@@ -382,7 +382,7 @@ int_very_careful:
 	jmp int_restore_rest
 	
 int_signal:
-	testl $(_TIF_NOTIFY_RESUME|_TIF_SIGPENDING|_TIF_SINGLESTEP),%edx
+	testl $(_TIF_NOTIFY_RESUME|_TIF_SIGPENDING|_TIF_SINGLESTEP|_TIF_PERFMON_WORK),%edx
 	jz 1f
 	movq %rsp,%rdi		# &ptregs -> arg1
 	xorl %esi,%esi		# oldset -> arg2
@@ -600,7 +600,7 @@ retint_careful:
 	jmp retint_check
 	
 retint_signal:
-	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP),%edx
+	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP|_TIF_PERFMON_WORK),%edx
 	jz    retint_swapgs
 	TRACE_IRQS_ON
 	sti
@@ -691,6 +691,10 @@ END(error_interrupt)
 ENTRY(spurious_interrupt)
 	apicinterrupt SPURIOUS_APIC_VECTOR,smp_spurious_interrupt
 END(spurious_interrupt)
+#ifdef CONFIG_PERFMON
+ENTRY(pmu_interrupt)
+	apicinterrupt LOCAL_PERFMON_VECTOR,smp_pmu_interrupt
+#endif
 #endif
 				
 /*
diff -urp linux-2.6.18.base/arch/x86_64/kernel/i8259.c linux-2.6.18/arch/x86_64/kernel/i8259.c
--- linux-2.6.18.base/arch/x86_64/kernel/i8259.c	2006-09-21 23:45:12.000000000 -0700
+++ linux-2.6.18/arch/x86_64/kernel/i8259.c	2006-09-25 08:49:39.000000000 -0700
@@ -12,6 +12,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/bitops.h>
+#include <linux/perfmon.h>
 
 #include <asm/acpi.h>
 #include <asm/atomic.h>
@@ -588,6 +589,11 @@ void __init init_IRQ(void)
 	/* IPI vectors for APIC spurious and error interrupts */
 	set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
 	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
+
+#ifdef CONFIG_PERFMON
+	set_intr_gate(LOCAL_PERFMON_VECTOR, pmu_interrupt);
+#endif
+
 #endif
 
 	/*
diff -urp linux-2.6.18.base/arch/x86_64/kernel/nmi.c linux-2.6.18/arch/x86_64/kernel/nmi.c
--- linux-2.6.18.base/arch/x86_64/kernel/nmi.c	2006-09-21 23:45:12.000000000 -0700
+++ linux-2.6.18/arch/x86_64/kernel/nmi.c	2006-09-25 09:21:37.000000000 -0700
@@ -20,6 +20,7 @@
 #include <linux/nmi.h>
 #include <linux/sysctl.h>
 #include <linux/kprobes.h>
+#include <linux/perfmon.h>
 
 #include <asm/smp.h>
 #include <asm/nmi.h>
@@ -355,7 +356,7 @@ static void setup_k7_watchdog(void)
 	unsigned int evntsel;
 
 	nmi_perfctr_msr = MSR_K7_PERFCTR0;
-
+printk("NMI installed K7 mode\n");
 	for(i = 0; i < 4; ++i) {
 		/* Simulator may not support it */
 		if (checking_wrmsrl(MSR_K7_EVNTSEL0+i, 0UL)) {
@@ -531,6 +532,21 @@ void __kprobes nmi_watchdog_tick(struct 
 	int sum;
 	int touched = 0;
 
+#ifdef CONFIG_PERFMON
+	/*
+	 * check if real NMI watchdog or perfmon
+	 * We do this for K8 processors only at the moment
+	 */
+	if (nmi_perfctr_msr == MSR_K7_PERFCTR0) {
+		unsigned long val;
+		rdmsrl(nmi_perfctr_msr, val);
+		if (val & (1ULL<<47)) {
+			pfm_handle_nmi(regs);
+			return;
+		}
+	}
+#endif
+
 	sum = read_pda(apic_timer_irqs);
 	if (__get_cpu_var(nmi_touch)) {
 		__get_cpu_var(nmi_touch) = 0;
diff -urp linux-2.6.18.base/arch/x86_64/kernel/process.c linux-2.6.18/arch/x86_64/kernel/process.c
--- linux-2.6.18.base/arch/x86_64/kernel/process.c	2006-09-21 23:48:08.000000000 -0700
+++ linux-2.6.18/arch/x86_64/kernel/process.c	2006-09-22 01:58:48.000000000 -0700
@@ -36,6 +36,7 @@
 #include <linux/random.h>
 #include <linux/notifier.h>
 #include <linux/kprobes.h>
+#include <linux/perfmon.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -350,6 +351,7 @@ void exit_thread(void)
 		t->io_bitmap_max = 0;
 		put_cpu();
 	}
+	pfm_exit_thread(me);
 }
 
 void flush_thread(void)
@@ -456,6 +458,8 @@ int copy_thread(int nr, unsigned long cl
 	asm("mov %%es,%0" : "=m" (p->thread.es));
 	asm("mov %%ds,%0" : "=m" (p->thread.ds));
 
+	pfm_copy_thread(p);
+
 	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.io_bitmap_ptr) {
@@ -526,6 +530,10 @@ static noinline void __switch_to_xtra(st
 		 */
 		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
 	}
+
+	if (test_tsk_thread_flag(next_p, TIF_PERFMON_CTXSW)
+	    || test_tsk_thread_flag(prev_p, TIF_PERFMON_CTXSW))
+		pfm_ctxsw(prev_p, next_p);
 }
 
 /*
@@ -614,13 +622,12 @@ __switch_to(struct task_struct *prev_p, 
 	unlazy_fpu(prev_p);
 	write_pda(kernelstack,
 		  task_stack_page(next_p) + THREAD_SIZE - PDA_STACKOFFSET);
-
-	/*
-	 * Now maybe reload the debug registers and handle I/O bitmaps
-	 */
-	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
-	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
-		__switch_to_xtra(prev_p, next_p, tss);
+  	/*
+ 	 * Now maybe reload the debug registers and handle I/O bitmaps
+  	 */
+ 	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW)
+ 	    || (task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW)))
+ 		__switch_to_xtra(prev_p, next_p, tss);
 
 	return prev_p;
 }
diff -urp linux-2.6.18.base/arch/x86_64/kernel/setup64.c linux-2.6.18/arch/x86_64/kernel/setup64.c
--- linux-2.6.18.base/arch/x86_64/kernel/setup64.c	2006-09-21 23:45:12.000000000 -0700
+++ linux-2.6.18/arch/x86_64/kernel/setup64.c	2006-09-22 01:58:48.000000000 -0700
@@ -11,6 +11,7 @@
 #include <linux/bootmem.h>
 #include <linux/bitops.h>
 #include <linux/module.h>
+#include <linux/perfmon.h>
 #include <asm/bootsetup.h>
 #include <asm/pda.h>
 #include <asm/pgtable.h>
@@ -290,4 +291,6 @@ void __cpuinit cpu_init (void)
 	set_debugreg(0UL, 7);
 
 	fpu_init(); 
+
+	pfm_init_percpu();
 }
diff -urp linux-2.6.18.base/arch/x86_64/kernel/signal.c linux-2.6.18/arch/x86_64/kernel/signal.c
--- linux-2.6.18.base/arch/x86_64/kernel/signal.c	2006-09-21 23:45:12.000000000 -0700
+++ linux-2.6.18/arch/x86_64/kernel/signal.c	2006-09-22 01:58:48.000000000 -0700
@@ -22,6 +22,7 @@
 #include <linux/stddef.h>
 #include <linux/personality.h>
 #include <linux/compiler.h>
+#include <linux/perfmon.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -481,15 +482,17 @@ void do_notify_resume(struct pt_regs *re
 {
 #ifdef DEBUG_SIG
 	printk("do_notify_resume flags:%x rip:%lx rsp:%lx caller:%lx pending:%lx\n",
-	       thread_info_flags, regs->rip, regs->rsp, __builtin_return_address(0),signal_pending(current)); 
+			thread_info_flags, regs->rip, regs->rsp, __builtin_return_address(0),signal_pending(current)); 
 #endif
-	       
 	/* Pending single-step? */
 	if (thread_info_flags & _TIF_SINGLESTEP) {
 		regs->eflags |= TF_MASK;
 		clear_thread_flag(TIF_SINGLESTEP);
 	}
 
+	if (thread_info_flags & _TIF_PERFMON_WORK)
+		pfm_handle_work();
+
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs,oldset);
diff -urp linux-2.6.18.base/arch/x86_64/kernel/smpboot.c linux-2.6.18/arch/x86_64/kernel/smpboot.c
--- linux-2.6.18.base/arch/x86_64/kernel/smpboot.c	2006-09-22 00:15:10.000000000 -0700
+++ linux-2.6.18/arch/x86_64/kernel/smpboot.c	2006-09-22 02:57:05.000000000 -0700
@@ -46,6 +46,7 @@
 #include <linux/bootmem.h>
 #include <linux/thread_info.h>
 #include <linux/module.h>
+#include <linux/perfmon.h>
 
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
@@ -1275,6 +1276,7 @@ int __cpu_disable(void)
 	cpu_clear(cpu, cpu_online_map);
 	remove_cpu_from_maps();
 	fixup_irqs(cpu_online_map);
+	pfm_cpu_disable();
 	return 0;
 }
 
@@ -1315,3 +1317,4 @@ void __cpu_die(unsigned int cpu)
 	BUG();
 }
 #endif /* CONFIG_HOTPLUG_CPU */
+
Only in linux-2.6.18/arch/x86_64: perfmon
diff -urp linux-2.6.18.base/include/asm-x86_64/hw_irq.h linux-2.6.18/include/asm-x86_64/hw_irq.h
--- linux-2.6.18.base/include/asm-x86_64/hw_irq.h	2006-09-21 23:45:38.000000000 -0700
+++ linux-2.6.18/include/asm-x86_64/hw_irq.h	2006-09-22 01:58:48.000000000 -0700
@@ -64,6 +64,7 @@ struct hw_interrupt_type;
  * sources per level' errata.
  */
 #define LOCAL_TIMER_VECTOR	0xef
+#define LOCAL_PERFMON_VECTOR	0xee
 
 /*
  * First APIC vector available to drivers: (vectors 0x30-0xee)
Only in linux-2.6.18/include/asm-x86_64: perfmon.h
Only in linux-2.6.18/include/asm-x86_64: perfmon_p4_pebs_smpl.h
diff -urp linux-2.6.18.base/include/asm-x86_64/thread_info.h linux-2.6.18/include/asm-x86_64/thread_info.h
--- linux-2.6.18.base/include/asm-x86_64/thread_info.h	2006-09-21 23:48:08.000000000 -0700
+++ linux-2.6.18/include/asm-x86_64/thread_info.h	2006-09-22 02:01:55.000000000 -0700
@@ -114,6 +114,7 @@ static inline struct thread_info *stack_
 #define TIF_IRET		5	/* force IRET */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
+#define TIF_PERFMON_WORK	9	/* work for pfm_handle_work() */
 /* 16 free */
 #define TIF_IA32		17	/* 32bit process */ 
 #define TIF_FORK		18	/* ret_from_fork */
@@ -121,6 +122,7 @@ static inline struct thread_info *stack_
 #define TIF_MEMDIE		20
 #define TIF_DEBUG		21	/* uses debug registers */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
+#define TIF_PERFMON_CTXSW	23	/* perfmon needs ctxsw calls */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -135,6 +137,8 @@ static inline struct thread_info *stack_
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
 #define _TIF_DEBUG		(1<<TIF_DEBUG)
 #define _TIF_IO_BITMAP		(1<<TIF_IO_BITMAP)
+#define _TIF_PERFMON_WORK	(1<<TIF_PERFMON_WORK)
+#define _TIF_PERFMON_CTXSW	(1<<TIF_PERFMON_CTXSW)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
@@ -143,7 +147,7 @@ static inline struct thread_info *stack_
 #define _TIF_ALLWORK_MASK (0x0000FFFF & ~_TIF_SECCOMP)
 
 /* flags to check in __switch_to() */
-#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP)
+#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP|_TIF_PERFMON_CTXSW)
 
 #define PREEMPT_ACTIVE     0x10000000
 
diff -urp linux-2.6.18.base/include/asm-x86_64/unistd.h linux-2.6.18/include/asm-x86_64/unistd.h
--- linux-2.6.18.base/include/asm-x86_64/unistd.h	2006-09-21 23:45:38.000000000 -0700
+++ linux-2.6.18/include/asm-x86_64/unistd.h	2006-09-22 02:00:55.000000000 -0700
@@ -619,10 +619,34 @@ __SYSCALL(__NR_sync_file_range, sys_sync
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
 #define __NR_move_pages		279
 __SYSCALL(__NR_move_pages, sys_move_pages)
-
+#define __NR_pfm_create_context	280
+ __SYSCALL(__NR_pfm_create_context, sys_pfm_create_context)
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
+  
 #ifdef __KERNEL__
 
-#define __NR_syscall_max __NR_move_pages
+#define __NR_syscall_max __NR_pfm_unload_context
 
 #ifndef __NO_STUBS
 
