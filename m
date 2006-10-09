Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932890AbWJIOQE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890AbWJIOQE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932879AbWJIOPe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:15:34 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:61695 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932890AbWJIOLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:11:33 -0400
Date: Mon, 9 Oct 2006 07:10:22 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EAMSQ026194@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 15/21] 2.6.18 perfmon2 : modified i386 files
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the modified i386 files


Modified files are as follows:

arch/i386/Kconfig:
	- add link to configuration menu in arch/i386/perfmon/Kconfig

arch/i386/Makefile:
	- add perfmon subdir

arch/i386/kernel/apic.c:
	- add hook to call pfm_handle_switch_timeout() on timer tick for timeout based
	  set multiplexing

arch/i386/kernel/i8259.c:
	- PMU interrupt vector gate initialization

arch/i386/kernel/process.c:
	- add hook in exit_thread() to cleanup perfmon2 context
	- add hook in copy_thread() to cleanup perfmon2 context in child (perfmon2 context
	  is never inherited)
	- add hook in __switch_to() for PMU state save/restore

arch/i386/kernel/signal.c:
	- add hook for extra work before kernel exit. Need to block a thread after a overflow with
	  user level notification. Also needed to do some bookeeeping, such as reset certain counters
	  and cleanup in some difficult corner cases

arch/i386/kernel/syscall_table.S:	
	- add new perfmon2 system calls

include/asm-i386/mach-default/entry_arch.h:
	- add pmu_interrupt stub

include/asm-i386/mach-default/irq_vectors.h:
	- define PMU interrupt vector

include/asm-i386/thread_info.h:
	- add TIF_PERFMON which is used for PMU context switching in __switch_to()

include/asm-i386/unistd.h:
	- add new system calls





diff -urp linux-2.6.18.base/arch/i386/Kconfig linux-2.6.18/arch/i386/Kconfig
--- linux-2.6.18.base/arch/i386/Kconfig	2006-09-21 23:45:09.000000000 -0700
+++ linux-2.6.18/arch/i386/Kconfig	2006-09-22 02:31:17.000000000 -0700
@@ -803,6 +803,8 @@ config COMPAT_VDSO
 
 	  If unsure, say Y.
 
+source "arch/i386/perfmon/Kconfig"
+
 endmenu
 
 config ARCH_ENABLE_MEMORY_HOTPLUG
diff -urp linux-2.6.18.base/arch/i386/Makefile linux-2.6.18/arch/i386/Makefile
--- linux-2.6.18.base/arch/i386/Makefile	2006-09-21 23:45:09.000000000 -0700
+++ linux-2.6.18/arch/i386/Makefile	2006-09-22 01:58:48.000000000 -0700
@@ -87,6 +87,7 @@ mflags-y += -Iinclude/asm-i386/mach-defa
 head-y := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 libs-y 					+= arch/i386/lib/
+core-$(CONFIG_PERFMON)			+= arch/i386/perfmon/
 core-y					+= arch/i386/kernel/ \
 					   arch/i386/mm/ \
 					   arch/i386/$(mcore-y)/ \
diff -urp linux-2.6.18.base/arch/i386/kernel/apic.c linux-2.6.18/arch/i386/kernel/apic.c
--- linux-2.6.18.base/arch/i386/kernel/apic.c	2006-09-21 23:50:46.000000000 -0700
+++ linux-2.6.18/arch/i386/kernel/apic.c	2006-09-22 01:58:48.000000000 -0700
@@ -26,6 +26,7 @@
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/perfmon.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -111,6 +112,9 @@ void __init apic_intr_init(void)
 #ifdef CONFIG_X86_MCE_P4THERMAL
 	set_intr_gate(THERMAL_APIC_VECTOR, thermal_interrupt);
 #endif
+#ifdef CONFIG_PERFMON
+	set_intr_gate(LOCAL_PERFMON_VECTOR, pmu_interrupt);
+#endif
 }
 
 /* Using APIC to generate smp_local_timer_interrupt? */
@@ -1191,6 +1195,8 @@ inline void smp_local_timer_interrupt(st
 	update_process_times(user_mode_vm(regs));
 #endif
 
+	pfm_handle_switch_timeout();
+
 	/*
 	 * We take the 'long' return path, and there every subsystem
 	 * grabs the apropriate locks (kernel lock/ irq lock).
diff -urp linux-2.6.18.base/arch/i386/kernel/cpu/common.c linux-2.6.18/arch/i386/kernel/cpu/common.c
--- linux-2.6.18.base/arch/i386/kernel/cpu/common.c	2006-09-21 23:45:09.000000000 -0700
+++ linux-2.6.18/arch/i386/kernel/cpu/common.c	2006-09-22 01:58:48.000000000 -0700
@@ -5,6 +5,7 @@
 #include <linux/module.h>
 #include <linux/percpu.h>
 #include <linux/bootmem.h>
+#include <linux/perfmon.h>
 #include <asm/semaphore.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
@@ -691,6 +692,8 @@ old_gdt:
 	current_thread_info()->status = 0;
 	clear_used_math();
 	mxcsr_feature_mask_init();
+
+	pfm_init_percpu();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff -urp linux-2.6.18.base/arch/i386/kernel/entry.S linux-2.6.18/arch/i386/kernel/entry.S
--- linux-2.6.18.base/arch/i386/kernel/entry.S	2006-09-21 23:45:09.000000000 -0700
+++ linux-2.6.18/arch/i386/kernel/entry.S	2006-09-22 01:58:48.000000000 -0700
@@ -430,7 +430,7 @@ ldt_ss:
 	ALIGN
 	RING0_PTREGS_FRAME		# can't unwind into user space anyway
 work_pending:
-	testb $_TIF_NEED_RESCHED, %cl
+	testw $(_TIF_NEED_RESCHED|_TIF_PERFMON_WORK), %cx
 	jz work_notifysig
 work_resched:
 	call schedule
diff -urp linux-2.6.18.base/arch/i386/kernel/i8259.c linux-2.6.18/arch/i386/kernel/i8259.c
--- linux-2.6.18.base/arch/i386/kernel/i8259.c	2006-09-21 23:45:09.000000000 -0700
+++ linux-2.6.18/arch/i386/kernel/i8259.c	2006-09-22 01:58:48.000000000 -0700
@@ -10,6 +10,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/bitops.h>
+#include <linux/perfmon.h>
 
 #include <asm/8253pit.h>
 #include <asm/atomic.h>
diff -urp linux-2.6.18.base/arch/i386/kernel/process.c linux-2.6.18/arch/i386/kernel/process.c
--- linux-2.6.18.base/arch/i386/kernel/process.c	2006-09-21 23:48:01.000000000 -0700
+++ linux-2.6.18/arch/i386/kernel/process.c	2006-09-25 07:16:32.000000000 -0700
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/perfmon.h>
 #include <linux/mc146818rtc.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
@@ -411,6 +412,7 @@ void exit_thread(void)
 		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 		put_cpu();
 	}
+	pfm_exit_thread(current);
 }
 
 void flush_thread(void)
@@ -463,6 +465,8 @@ int copy_thread(int nr, unsigned long cl
 	savesegment(fs,p->thread.fs);
 	savesegment(gs,p->thread.gs);
 
+ 	pfm_copy_thread(p);
+
 	tsk = current;
 	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
@@ -567,8 +571,9 @@ int dump_task_regs(struct task_struct *t
 	return 1;
 }
 
-static noinline void __switch_to_xtra(struct task_struct *next_p,
-				    struct tss_struct *tss)
+static noinline void __switch_to_xtra(struct task_struct *prev_p,
+				      struct task_struct *next_p,
+				      struct tss_struct *tss)
 {
 	struct thread_struct *next;
 
@@ -584,6 +589,10 @@ static noinline void __switch_to_xtra(st
 		set_debugreg(next->debugreg[7], 7);
 	}
 
+	if (test_tsk_thread_flag(next_p, TIF_PERFMON_CTXSW)
+	    || test_tsk_thread_flag(prev_p, TIF_PERFMON_CTXSW))
+		pfm_ctxsw(prev_p, next_p);
+
 	if (!test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
 		/*
 		 * Disable the bitmap via an invalid offset. We still cache
@@ -723,8 +732,8 @@ struct task_struct fastcall * __switch_t
 	 * Now maybe handle debug registers and/or IO bitmaps
 	 */
 	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW)
-	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)))
-		__switch_to_xtra(next_p, tss);
+	    || (task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW)))
+		__switch_to_xtra(prev_p, next_p, tss);
 
 	disable_tsc(prev_p, next_p);
 
diff -urp linux-2.6.18.base/arch/i386/kernel/signal.c linux-2.6.18/arch/i386/kernel/signal.c
--- linux-2.6.18.base/arch/i386/kernel/signal.c	2006-09-21 23:45:09.000000000 -0700
+++ linux-2.6.18/arch/i386/kernel/signal.c	2006-09-22 01:58:48.000000000 -0700
@@ -21,6 +21,7 @@
 #include <linux/suspend.h>
 #include <linux/ptrace.h>
 #include <linux/elf.h>
+#include <linux/perfmon.h>
 #include <asm/processor.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
@@ -651,6 +652,9 @@ void do_notify_resume(struct pt_regs *re
 		clear_thread_flag(TIF_SINGLESTEP);
 	}
 
+	if (thread_info_flags & _TIF_PERFMON_WORK)
+ 		pfm_handle_work();
+
 	/* deal with pending signal delivery */
 	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK))
 		do_signal(regs);
diff -urp linux-2.6.18.base/arch/i386/kernel/smpboot.c linux-2.6.18/arch/i386/kernel/smpboot.c
--- linux-2.6.18.base/arch/i386/kernel/smpboot.c	2006-09-22 00:16:23.000000000 -0700
+++ linux-2.6.18/arch/i386/kernel/smpboot.c	2006-09-22 01:58:48.000000000 -0700
@@ -45,6 +45,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/percpu.h>
+#include <linux/perfmon.h>
 
 #include <linux/delay.h>
 #include <linux/mc146818rtc.h>
@@ -1383,6 +1384,7 @@ int __cpu_disable(void)
 
 	cpu_clear(cpu, map);
 	fixup_irqs(map);
+	pfm_cpu_disable();
 	/* It's now safe to remove this processor from the online map */
 	cpu_clear(cpu, cpu_online_map);
 	return 0;
diff -urp linux-2.6.18.base/arch/i386/kernel/syscall_table.S linux-2.6.18/arch/i386/kernel/syscall_table.S
--- linux-2.6.18.base/arch/i386/kernel/syscall_table.S	2006-09-21 23:45:09.000000000 -0700
+++ linux-2.6.18/arch/i386/kernel/syscall_table.S	2006-09-22 02:30:30.000000000 -0700
@@ -317,3 +317,15 @@ ENTRY(sys_call_table)
 	.long sys_tee			/* 315 */
 	.long sys_vmsplice
 	.long sys_move_pages
+ 	.long sys_pfm_create_context
+ 	.long sys_pfm_write_pmcs
+ 	.long sys_pfm_write_pmds	/* 320 */
+ 	.long sys_pfm_read_pmds
+ 	.long sys_pfm_load_context
+ 	.long sys_pfm_start
+ 	.long sys_pfm_stop
+ 	.long sys_pfm_restart		/* 325 */
+ 	.long sys_pfm_create_evtsets
+ 	.long sys_pfm_getinfo_evtsets
+ 	.long sys_pfm_delete_evtsets
+ 	.long sys_pfm_unload_context
Only in linux-2.6.18/arch/i386: perfmon
diff -urp linux-2.6.18.base/include/asm-i386/mach-default/entry_arch.h linux-2.6.18/include/asm-i386/mach-default/entry_arch.h
--- linux-2.6.18.base/include/asm-i386/mach-default/entry_arch.h	2006-09-21 23:45:34.000000000 -0700
+++ linux-2.6.18/include/asm-i386/mach-default/entry_arch.h	2006-09-22 01:58:48.000000000 -0700
@@ -31,4 +31,8 @@ BUILD_INTERRUPT(spurious_interrupt,SPURI
 BUILD_INTERRUPT(thermal_interrupt,THERMAL_APIC_VECTOR)
 #endif
 
+#ifdef CONFIG_PERFMON
+BUILD_INTERRUPT(pmu_interrupt,LOCAL_PERFMON_VECTOR)
+#endif
+
 #endif
diff -urp linux-2.6.18.base/include/asm-i386/mach-default/irq_vectors.h linux-2.6.18/include/asm-i386/mach-default/irq_vectors.h
--- linux-2.6.18.base/include/asm-i386/mach-default/irq_vectors.h	2006-09-21 23:45:34.000000000 -0700
+++ linux-2.6.18/include/asm-i386/mach-default/irq_vectors.h	2006-09-22 01:58:48.000000000 -0700
@@ -56,6 +56,7 @@
  * sources per level' errata.
  */
 #define LOCAL_TIMER_VECTOR	0xef
+#define LOCAL_PERFMON_VECTOR	0xee
 
 /*
  * First APIC vector available to drivers: (vectors 0x30-0xee)
@@ -63,7 +64,7 @@
  * levels. (0x80 is the syscall vector)
  */
 #define FIRST_DEVICE_VECTOR	0x31
-#define FIRST_SYSTEM_VECTOR	0xef
+#define FIRST_SYSTEM_VECTOR	0xee
 
 #define TIMER_IRQ 0
 
Only in linux-2.6.18/include/asm-i386: perfmon.h
Only in linux-2.6.18/include/asm-i386: perfmon_p4_pebs_smpl.h
diff -urp linux-2.6.18.base/include/asm-i386/thread_info.h linux-2.6.18/include/asm-i386/thread_info.h
--- linux-2.6.18.base/include/asm-i386/thread_info.h	2006-09-22 01:38:10.000000000 -0700
+++ linux-2.6.18/include/asm-i386/thread_info.h	2006-09-22 02:54:53.000000000 -0700
@@ -139,9 +139,11 @@ static inline struct thread_info *curren
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_RESTORE_SIGMASK	9	/* restore signal mask in do_signal() */
+#define TIF_PERFMON_WORK	10	/* work for pfm_handle_work() */
 #define TIF_MEMDIE		16
 #define TIF_DEBUG		17	/* uses debug registers */
 #define TIF_IO_BITMAP		18	/* uses I/O bitmap */
+#define TIF_PERFMON_CTXSW	19	/* perfmon needs ctxsw calls */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -155,6 +157,8 @@ static inline struct thread_info *curren
 #define _TIF_RESTORE_SIGMASK	(1<<TIF_RESTORE_SIGMASK)
 #define _TIF_DEBUG		(1<<TIF_DEBUG)
 #define _TIF_IO_BITMAP		(1<<TIF_IO_BITMAP)
+#define _TIF_PERFMON_WORK	(1<<TIF_PERFMON_WORK)
+#define _TIF_PERFMON_CTXSW	(1<<TIF_PERFMON_CTXSW)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
@@ -164,7 +168,7 @@ static inline struct thread_info *curren
 #define _TIF_ALLWORK_MASK	(0x0000FFFF & ~_TIF_SECCOMP)
 
 /* flags to check in __switch_to() */
-#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP)
+#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP|_TIF_PERFMON_CTXSW)
 
 /*
  * Thread-synchronous status.
diff -urp linux-2.6.18.base/include/asm-i386/unistd.h linux-2.6.18/include/asm-i386/unistd.h
--- linux-2.6.18.base/include/asm-i386/unistd.h	2006-09-21 23:45:34.000000000 -0700
+++ linux-2.6.18/include/asm-i386/unistd.h	2006-09-22 02:17:02.000000000 -0700
@@ -323,10 +323,22 @@
 #define __NR_tee		315
 #define __NR_vmsplice		316
 #define __NR_move_pages		317
+#define __NR_pfm_create_context	318
+#define __NR_pfm_write_pmcs	(__NR_pfm_create_context+1)
+#define __NR_pfm_write_pmds	(__NR_pfm_create_context+2)
+#define __NR_pfm_read_pmds	(__NR_pfm_create_context+3)
+#define __NR_pfm_load_context	(__NR_pfm_create_context+4)
+#define __NR_pfm_start		(__NR_pfm_create_context+5)
+#define __NR_pfm_stop		(__NR_pfm_create_context+6)
+#define __NR_pfm_restart	(__NR_pfm_create_context+7)
+#define __NR_pfm_create_evtsets	(__NR_pfm_create_context+8)
+#define __NR_pfm_getinfo_evtsets (__NR_pfm_create_context+9)
+#define __NR_pfm_delete_evtsets (__NR_pfm_create_context+10)
+#define __NR_pfm_unload_context	(__NR_pfm_create_context+11)
 
 #ifdef __KERNEL__
 
-#define NR_syscalls 318
+#define NR_syscalls 329
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
