Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWHWISy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWHWISy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWHWISj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:18:39 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:18173 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932402AbWHWIRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:17:07 -0400
Date: Wed, 23 Aug 2006 01:06:04 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200608230806.k7N864u2000491@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 13/18] 2.6.17.9 perfmon2 patch for review: modified i386 files
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





diff -urp linux-2.6.17.9.base/arch/i386/Kconfig linux-2.6.17.9/arch/i386/Kconfig
--- linux-2.6.17.9.base/arch/i386/Kconfig	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/arch/i386/Kconfig	2006-08-21 03:37:45.000000000 -0700
@@ -762,6 +762,7 @@ config HOTPLUG_CPU
 	  enable suspend on SMP systems. CPUs can be controlled through
 	  /sys/devices/system/cpu.
 
+source "arch/i386/perfmon/Kconfig"
 
 endmenu
 
diff -urp linux-2.6.17.9.base/arch/i386/Makefile linux-2.6.17.9/arch/i386/Makefile
--- linux-2.6.17.9.base/arch/i386/Makefile	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/arch/i386/Makefile	2006-08-21 03:37:45.000000000 -0700
@@ -87,6 +87,7 @@ mflags-y += -Iinclude/asm-i386/mach-defa
 head-y := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 libs-y 					+= arch/i386/lib/
+core-$(CONFIG_PERFMON)			+= arch/i386/perfmon/
 core-y					+= arch/i386/kernel/ \
 					   arch/i386/mm/ \
 					   arch/i386/$(mcore-y)/ \
diff -urp linux-2.6.17.9.base/arch/i386/kernel/apic.c linux-2.6.17.9/arch/i386/kernel/apic.c
--- linux-2.6.17.9.base/arch/i386/kernel/apic.c	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/arch/i386/kernel/apic.c	2006-08-21 03:37:45.000000000 -0700
@@ -27,6 +27,7 @@
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/perfmon.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -1179,6 +1180,8 @@ inline void smp_local_timer_interrupt(st
 	update_process_times(user_mode_vm(regs));
 #endif
 
+	pfm_handle_switch_timeout();
+
 	/*
 	 * We take the 'long' return path, and there every subsystem
 	 * grabs the apropriate locks (kernel lock/ irq lock).
diff -urp linux-2.6.17.9.base/arch/i386/kernel/i8259.c linux-2.6.17.9/arch/i386/kernel/i8259.c
--- linux-2.6.17.9.base/arch/i386/kernel/i8259.c	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/arch/i386/kernel/i8259.c	2006-08-21 03:37:45.000000000 -0700
@@ -11,6 +11,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/bitops.h>
+#include <linux/perfmon.h>
 
 #include <asm/8253pit.h>
 #include <asm/atomic.h>
@@ -427,6 +428,8 @@ void __init init_IRQ(void)
 	 */
 	setup_pit_timer();
 
+ 	pfm_vector_init();
+
 	/*
 	 * External FPU? Set up irq13 if so, for
 	 * original braindamaged IBM FERR coupling.
diff -urp linux-2.6.17.9.base/arch/i386/kernel/process.c linux-2.6.17.9/arch/i386/kernel/process.c
--- linux-2.6.17.9.base/arch/i386/kernel/process.c	2006-08-21 03:33:27.000000000 -0700
+++ linux-2.6.17.9/arch/i386/kernel/process.c	2006-08-21 03:37:45.000000000 -0700
@@ -33,6 +33,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/perfmon.h>
 #include <linux/mc146818rtc.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
@@ -380,6 +381,7 @@ void exit_thread(void)
 		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 		put_cpu();
 	}
+	pfm_exit_thread(current);
 }
 
 void flush_thread(void)
@@ -432,6 +434,8 @@ int copy_thread(int nr, unsigned long cl
 	savesegment(fs,p->thread.fs);
 	savesegment(gs,p->thread.gs);
 
+ 	pfm_copy_thread(p);
+
 	tsk = current;
 	if (unlikely(test_tsk_thread_flag(tsk, TIF_IO_BITMAP))) {
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
@@ -536,8 +540,9 @@ int dump_task_regs(struct task_struct *t
 	return 1;
 }
 
-static noinline void __switch_to_xtra(struct task_struct *next_p,
-				    struct tss_struct *tss)
+static noinline void __switch_to_xtra(struct task_struct *prev_p,
+				      struct task_struct *next_p,
+				      struct tss_struct *tss)
 {
 	struct thread_struct *next;
 
@@ -553,6 +558,10 @@ static noinline void __switch_to_xtra(st
 		set_debugreg(next->debugreg[7], 7);
 	}
 
+	if (test_tsk_thread_flag(next_p, TIF_PERFMON)
+	    || test_tsk_thread_flag(prev_p, TIF_PERFMON))
+		pfm_ctxsw(prev_p, next_p);
+
 	if (!test_tsk_thread_flag(next_p, TIF_IO_BITMAP)) {
 		/*
 		 * Disable the bitmap via an invalid offset. We still cache
@@ -691,9 +700,9 @@ struct task_struct fastcall * __switch_t
 	/*
 	 * Now maybe reload the debug registers
 	 */
-	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
-	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
-		__switch_to_xtra(next_p, tss);
+	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW)
+ 	    || (task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW)))
+		__switch_to_xtra(prev_p, next_p, tss);
 
 	disable_tsc(prev_p, next_p);
 
diff -urp linux-2.6.17.9.base/arch/i386/kernel/signal.c linux-2.6.17.9/arch/i386/kernel/signal.c
--- linux-2.6.17.9.base/arch/i386/kernel/signal.c	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/arch/i386/kernel/signal.c	2006-08-21 03:37:45.000000000 -0700
@@ -21,6 +21,7 @@
 #include <linux/suspend.h>
 #include <linux/ptrace.h>
 #include <linux/elf.h>
+#include <linux/perfmon.h>
 #include <asm/processor.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
@@ -651,6 +652,8 @@ void do_notify_resume(struct pt_regs *re
 		clear_thread_flag(TIF_SINGLESTEP);
 	}
 
+ 	pfm_handle_work(current);
+
 	/* deal with pending signal delivery */
 	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK))
 		do_signal(regs);
diff -urp linux-2.6.17.9.base/arch/i386/kernel/syscall_table.S linux-2.6.17.9/arch/i386/kernel/syscall_table.S
--- linux-2.6.17.9.base/arch/i386/kernel/syscall_table.S	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/arch/i386/kernel/syscall_table.S	2006-08-21 03:37:45.000000000 -0700
@@ -316,3 +316,15 @@ ENTRY(sys_call_table)
 	.long sys_sync_file_range
 	.long sys_tee			/* 315 */
 	.long sys_vmsplice
+	.long sys_pfm_create_context
+	.long sys_pfm_write_pmcs
+	.long sys_pfm_write_pmds
+	.long sys_pfm_read_pmds		/* 320 */
+	.long sys_pfm_load_context
+	.long sys_pfm_start
+	.long sys_pfm_stop
+	.long sys_pfm_restart
+	.long sys_pfm_create_evtsets	/* 325 */
+	.long sys_pfm_getinfo_evtsets
+	.long sys_pfm_delete_evtsets
+	.long sys_pfm_unload_context
Only in linux-2.6.17.9/arch/i386: perfmon
diff -urp linux-2.6.17.9.base/include/asm-i386/mach-default/entry_arch.h linux-2.6.17.9/include/asm-i386/mach-default/entry_arch.h
--- linux-2.6.17.9.base/include/asm-i386/mach-default/entry_arch.h	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/include/asm-i386/mach-default/entry_arch.h	2006-08-21 03:37:45.000000000 -0700
@@ -31,4 +31,8 @@ BUILD_INTERRUPT(spurious_interrupt,SPURI
 BUILD_INTERRUPT(thermal_interrupt,THERMAL_APIC_VECTOR)
 #endif
 
+#ifdef CONFIG_PERFMON
+BUILD_INTERRUPT(pmu_interrupt,LOCAL_PERFMON_VECTOR)
+#endif
+
 #endif
diff -urp linux-2.6.17.9.base/include/asm-i386/mach-default/irq_vectors.h linux-2.6.17.9/include/asm-i386/mach-default/irq_vectors.h
--- linux-2.6.17.9.base/include/asm-i386/mach-default/irq_vectors.h	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/include/asm-i386/mach-default/irq_vectors.h	2006-08-21 03:37:45.000000000 -0700
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
 
Only in linux-2.6.17.9/include/asm-i386: perfmon.h
Only in linux-2.6.17.9/include/asm-i386: perfmon_p4_pebs_smpl.h
diff -urp linux-2.6.17.9.base/include/asm-i386/thread_info.h linux-2.6.17.9/include/asm-i386/thread_info.h
--- linux-2.6.17.9.base/include/asm-i386/thread_info.h	2006-08-21 03:33:27.000000000 -0700
+++ linux-2.6.17.9/include/asm-i386/thread_info.h	2006-08-21 03:37:45.000000000 -0700
@@ -145,6 +145,7 @@ register unsigned long current_stack_poi
 #define TIF_MEMDIE		17
 #define TIF_DEBUG		18	/* uses debug registers */
 #define TIF_IO_BITMAP		19	/* uses I/O bitmap */
+#define TIF_PERFMON		20	/* uses perfmon */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -159,6 +160,7 @@ register unsigned long current_stack_poi
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 #define _TIF_DEBUG		(1<<TIF_DEBUG)
 #define _TIF_IO_BITMAP		(1<<TIF_IO_BITMAP)
+#define _TIF_PERFMON		(1<<TIF_PERFMON)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
@@ -168,7 +170,7 @@ register unsigned long current_stack_poi
 #define _TIF_ALLWORK_MASK	(0x0000FFFF & ~_TIF_SECCOMP)
 
 /* flags to check in __switch_to() */
-#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP)
+#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP|_TIF_PERFMON)
 
 /*
  * Thread-synchronous status.
diff -urp linux-2.6.17.9.base/include/asm-i386/unistd.h linux-2.6.17.9/include/asm-i386/unistd.h
--- linux-2.6.17.9.base/include/asm-i386/unistd.h	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/include/asm-i386/unistd.h	2006-08-21 03:37:45.000000000 -0700
@@ -322,8 +322,19 @@
 #define __NR_sync_file_range	314
 #define __NR_tee		315
 #define __NR_vmsplice		316
+#define __NR_pfm_create_context	317
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
 
-#define NR_syscalls 317
+#define NR_syscalls 328
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
