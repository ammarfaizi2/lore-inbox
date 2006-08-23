Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWHWITe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWHWITe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 04:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWHWISg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 04:18:36 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:18173 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932396AbWHWIRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 04:17:07 -0400
Date: Wed, 23 Aug 2006 01:06:08 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200608230806.k7N8689P000540@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 17/18] 2.6.17.9 perfmon2 patch for review: modified x86_64 files
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

include/asm-x86_64/hw_irq.h:
	- define PMU interrupt vector

include/asm-x86_64/irq.h:
	- update FIRST_SYSTEM_VECTOR

include/asm-x86_64/thread_info.h:
	- add TIF_PERFMON which is used for PMU context switching in __switch_to()

include/asm-x86_64/unistd.h:
	- add new system calls


	
diff -urp linux-2.6.17.9.base/arch/x86_64/Kconfig linux-2.6.17.9/arch/x86_64/Kconfig
--- linux-2.6.17.9.base/arch/x86_64/Kconfig	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/arch/x86_64/Kconfig	2006-08-21 03:37:46.000000000 -0700
@@ -503,6 +503,8 @@ config REORDER
          optimal TLB usage. If you have pretty much any version of binutils, 
 	 this can increase your kernel build time by roughly one minute.
 
+source "arch/x86_64/perfmon/Kconfig"
+
 endmenu
 
 #
Only in linux-2.6.17.9/arch/x86_64: Kconfig.orig
diff -urp linux-2.6.17.9.base/arch/x86_64/Makefile linux-2.6.17.9/arch/x86_64/Makefile
--- linux-2.6.17.9.base/arch/x86_64/Makefile	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/arch/x86_64/Makefile	2006-08-21 03:37:46.000000000 -0700
@@ -65,6 +65,7 @@ core-y					+= arch/x86_64/kernel/ \
 					   arch/x86_64/crypto/
 core-$(CONFIG_IA32_EMULATION)		+= arch/x86_64/ia32/
 drivers-$(CONFIG_PCI)			+= arch/x86_64/pci/
+drivers-$(CONFIG_PERFMON)		+= arch/x86_64/perfmon/
 drivers-$(CONFIG_OPROFILE)		+= arch/x86_64/oprofile/
 
 boot := arch/x86_64/boot
diff -urp linux-2.6.17.9.base/arch/x86_64/ia32/ia32entry.S linux-2.6.17.9/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.17.9.base/arch/x86_64/ia32/ia32entry.S	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/arch/x86_64/ia32/ia32entry.S	2006-08-21 03:37:46.000000000 -0700
@@ -696,4 +696,17 @@ ia32_sys_call_table:
 	.quad sys_sync_file_range
 	.quad sys_tee
 	.quad compat_sys_vmsplice
+	.quad sys_pfm_create_context
+	.quad sys_pfm_write_pmcs
+	.quad sys_pfm_write_pmds
+	.quad sys_pfm_read_pmds		/* 320 */
+	.quad sys_pfm_load_context
+	.quad sys_pfm_start
+	.quad sys_pfm_stop
+	.quad sys_pfm_restart
+	.quad sys_pfm_create_evtsets	/* 325 */
+	.quad sys_pfm_getinfo_evtsets
+	.quad sys_pfm_delete_evtsets
+	.quad sys_pfm_unload_context
+
 ia32_syscall_end:		
diff -urp linux-2.6.17.9.base/arch/x86_64/kernel/apic.c linux-2.6.17.9/arch/x86_64/kernel/apic.c
--- linux-2.6.17.9.base/arch/x86_64/kernel/apic.c	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/arch/x86_64/kernel/apic.c	2006-08-21 03:37:46.000000000 -0700
@@ -26,6 +26,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/module.h>
+#include <linux/perfmon.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -934,6 +935,7 @@ void setup_threshold_lvt(unsigned long l
 void smp_local_timer_interrupt(struct pt_regs *regs)
 {
 	profile_tick(CPU_PROFILING, regs);
+ 	pfm_handle_switch_timeout();
 #ifdef CONFIG_SMP
 	update_process_times(user_mode(regs));
 #endif
diff -urp linux-2.6.17.9.base/arch/x86_64/kernel/entry.S linux-2.6.17.9/arch/x86_64/kernel/entry.S
--- linux-2.6.17.9.base/arch/x86_64/kernel/entry.S	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/arch/x86_64/kernel/entry.S	2006-08-21 03:37:46.000000000 -0700
@@ -640,6 +640,11 @@ ENTRY(error_interrupt)
 
 ENTRY(spurious_interrupt)
 	apicinterrupt SPURIOUS_APIC_VECTOR,smp_spurious_interrupt
+
+#ifdef CONFIG_PERFMON
+ENTRY(pmu_interrupt)
+	apicinterrupt LOCAL_PERFMON_VECTOR,smp_pmu_interrupt
+#endif
 #endif
 				
 /*
diff -urp linux-2.6.17.9.base/arch/x86_64/kernel/i8259.c linux-2.6.17.9/arch/x86_64/kernel/i8259.c
--- linux-2.6.17.9.base/arch/x86_64/kernel/i8259.c	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/arch/x86_64/kernel/i8259.c	2006-08-21 03:37:46.000000000 -0700
@@ -13,6 +13,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/bitops.h>
+#include <linux/perfmon.h>
 
 #include <asm/acpi.h>
 #include <asm/atomic.h>
@@ -589,6 +590,8 @@ void __init init_IRQ(void)
 	/* IPI vectors for APIC spurious and error interrupts */
 	set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
 	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
+
+ 	pfm_vector_init();
 #endif
 
 	/*
diff -urp linux-2.6.17.9.base/arch/x86_64/kernel/process.c linux-2.6.17.9/arch/x86_64/kernel/process.c
--- linux-2.6.17.9.base/arch/x86_64/kernel/process.c	2006-08-21 03:33:27.000000000 -0700
+++ linux-2.6.17.9/arch/x86_64/kernel/process.c	2006-08-21 03:37:46.000000000 -0700
@@ -37,6 +37,7 @@
 #include <linux/random.h>
 #include <linux/notifier.h>
 #include <linux/kprobes.h>
+#include <linux/perfmon.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -359,6 +360,7 @@ void exit_thread(void)
 		t->io_bitmap_max = 0;
 		put_cpu();
 	}
+	pfm_exit_thread(me);
 }
 
 void flush_thread(void)
@@ -462,6 +464,8 @@ int copy_thread(int nr, unsigned long cl
 	asm("mov %%es,%0" : "=m" (p->thread.es));
 	asm("mov %%ds,%0" : "=m" (p->thread.ds));
 
+	pfm_copy_thread(p);
+
 	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.io_bitmap_ptr) {
@@ -532,6 +536,10 @@ static noinline void __switch_to_xtra(st
 		 */
 		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
 	}
+
+	if (test_tsk_thread_flag(next_p, TIF_PERFMON)
+	    || test_tsk_thread_flag(prev_p, TIF_PERFMON))
+		pfm_ctxsw(prev_p, next_p);
 }
 
 /*
@@ -620,13 +628,12 @@ __switch_to(struct task_struct *prev_p, 
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
diff -urp linux-2.6.17.9.base/arch/x86_64/kernel/signal.c linux-2.6.17.9/arch/x86_64/kernel/signal.c
--- linux-2.6.17.9.base/arch/x86_64/kernel/signal.c	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/arch/x86_64/kernel/signal.c	2006-08-21 03:37:46.000000000 -0700
@@ -24,6 +24,7 @@
 #include <linux/stddef.h>
 #include <linux/personality.h>
 #include <linux/compiler.h>
+#include <linux/perfmon.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -493,6 +494,8 @@ void do_notify_resume(struct pt_regs *re
 		clear_thread_flag(TIF_SINGLESTEP);
 	}
 
+	pfm_handle_work(current);
+
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs,oldset);
Only in linux-2.6.17.9/arch/x86_64: perfmon
diff -urp linux-2.6.17.9.base/include/asm-x86_64/hw_irq.h linux-2.6.17.9/include/asm-x86_64/hw_irq.h
--- linux-2.6.17.9.base/include/asm-x86_64/hw_irq.h	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/include/asm-x86_64/hw_irq.h	2006-08-21 03:37:46.000000000 -0700
@@ -67,6 +67,7 @@ struct hw_interrupt_type;
  * sources per level' errata.
  */
 #define LOCAL_TIMER_VECTOR	0xef
+#define LOCAL_PERFMON_VECTOR	0xee
 
 /*
  * First APIC vector available to drivers: (vectors 0x30-0xee)
@@ -74,7 +75,7 @@ struct hw_interrupt_type;
  * levels. (0x80 is the syscall vector)
  */
 #define FIRST_DEVICE_VECTOR	0x31
-#define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in irq.h */
+#define FIRST_SYSTEM_VECTOR	0xee   /* duplicated in irq.h */
 
 
 #ifndef __ASSEMBLY__
diff -urp linux-2.6.17.9.base/include/asm-x86_64/irq.h linux-2.6.17.9/include/asm-x86_64/irq.h
--- linux-2.6.17.9.base/include/asm-x86_64/irq.h	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/include/asm-x86_64/irq.h	2006-08-21 03:37:46.000000000 -0700
@@ -29,7 +29,7 @@
  */
 #define NR_VECTORS 256
 
-#define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in hw_irq.h */
+#define FIRST_SYSTEM_VECTOR	0xee   /* duplicated in hw_irq.h */
 
 #ifdef CONFIG_PCI_MSI
 #define NR_IRQS FIRST_SYSTEM_VECTOR
Only in linux-2.6.17.9/include/asm-x86_64: perfmon.h
Only in linux-2.6.17.9/include/asm-x86_64: perfmon_em64t_pebs_smpl.h
diff -urp linux-2.6.17.9.base/include/asm-x86_64/thread_info.h linux-2.6.17.9/include/asm-x86_64/thread_info.h
--- linux-2.6.17.9.base/include/asm-x86_64/thread_info.h	2006-08-21 03:33:27.000000000 -0700
+++ linux-2.6.17.9/include/asm-x86_64/thread_info.h	2006-08-21 03:37:46.000000000 -0700
@@ -108,6 +108,7 @@ static inline struct thread_info *stack_
 #define TIF_MEMDIE		20
 #define TIF_DEBUG		21	/* uses debug registers */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
+#define TIF_PERFMON		23	/* uses perfmon */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
@@ -123,6 +124,7 @@ static inline struct thread_info *stack_
 #define _TIF_ABI_PENDING	(1<<TIF_ABI_PENDING)
 #define _TIF_DEBUG		(1<<TIF_DEBUG)
 #define _TIF_IO_BITMAP		(1<<TIF_IO_BITMAP)
+#define _TIF_PERFMON		(1<<TIF_PERFMON)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
@@ -131,7 +133,7 @@ static inline struct thread_info *stack_
 #define _TIF_ALLWORK_MASK (0x0000FFFF & ~_TIF_SECCOMP)
 
 /* flags to check in __switch_to() */
-#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP)
+#define _TIF_WORK_CTXSW (_TIF_DEBUG|_TIF_IO_BITMAP|_TIF_PERFMON)
 
 #define PREEMPT_ACTIVE     0x10000000
 
diff -urp linux-2.6.17.9.base/include/asm-x86_64/unistd.h linux-2.6.17.9/include/asm-x86_64/unistd.h
--- linux-2.6.17.9.base/include/asm-x86_64/unistd.h	2006-08-18 09:26:24.000000000 -0700
+++ linux-2.6.17.9/include/asm-x86_64/unistd.h	2006-08-21 03:37:46.000000000 -0700
@@ -617,8 +617,32 @@ __SYSCALL(__NR_tee, sys_tee)
 __SYSCALL(__NR_sync_file_range, sys_sync_file_range)
 #define __NR_vmsplice		278
 __SYSCALL(__NR_vmsplice, sys_vmsplice)
-
-#define __NR_syscall_max __NR_vmsplice
+#define __NR_pfm_create_context	279
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
+#define __NR_syscall_max __NR_pfm_unload_context
 
 #ifndef __NO_STUBS
 
