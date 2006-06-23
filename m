Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932954AbWFWJVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954AbWFWJVz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932952AbWFWJVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:21:52 -0400
Received: from palrel11.hp.com ([156.153.255.246]:62667 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S1751258AbWFWJU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:20:57 -0400
Date: Fri, 23 Jun 2006 02:13:10 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200606230913.k5N9DAOM032421@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] 2.6.17.1 perfmon2 patch for review: modified i386 files
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the modified i386 files




diff -urp linux-2.6.17.1.orig/arch/i386/Kconfig linux-2.6.17.1/arch/i386/Kconfig
--- linux-2.6.17.1.orig/arch/i386/Kconfig	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/i386/Kconfig	2006-06-21 04:22:51.000000000 -0700
@@ -762,6 +762,7 @@ config HOTPLUG_CPU
 	  enable suspend on SMP systems. CPUs can be controlled through
 	  /sys/devices/system/cpu.
 
+source "arch/i386/perfmon/Kconfig"
 
 endmenu
 
diff -urp linux-2.6.17.1.orig/arch/i386/Makefile linux-2.6.17.1/arch/i386/Makefile
--- linux-2.6.17.1.orig/arch/i386/Makefile	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/i386/Makefile	2006-06-21 04:22:51.000000000 -0700
@@ -87,6 +87,7 @@ mflags-y += -Iinclude/asm-i386/mach-defa
 head-y := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 libs-y 					+= arch/i386/lib/
+core-$(CONFIG_PERFMON)			+= arch/i386/perfmon/
 core-y					+= arch/i386/kernel/ \
 					   arch/i386/mm/ \
 					   arch/i386/$(mcore-y)/ \
diff -urp linux-2.6.17.1.orig/arch/i386/kernel/apic.c linux-2.6.17.1/arch/i386/kernel/apic.c
--- linux-2.6.17.1.orig/arch/i386/kernel/apic.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/i386/kernel/apic.c	2006-06-21 04:22:51.000000000 -0700
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
diff -urp linux-2.6.17.1.orig/arch/i386/kernel/i8259.c linux-2.6.17.1/arch/i386/kernel/i8259.c
--- linux-2.6.17.1.orig/arch/i386/kernel/i8259.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/i386/kernel/i8259.c	2006-06-21 04:22:51.000000000 -0700
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
diff -urp linux-2.6.17.1.orig/arch/i386/kernel/process.c linux-2.6.17.1/arch/i386/kernel/process.c
--- linux-2.6.17.1.orig/arch/i386/kernel/process.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/i386/kernel/process.c	2006-06-21 04:22:51.000000000 -0700
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
+	pfm_exit_thread(tsk);
 }
 
 void flush_thread(void)
@@ -431,6 +433,8 @@ int copy_thread(int nr, unsigned long cl
 	savesegment(fs,p->thread.fs);
 	savesegment(gs,p->thread.gs);
 
+ 	pfm_copy_thread(p, childregs);
+
 	tsk = current;
 	if (unlikely(NULL != tsk->thread.io_bitmap_ptr)) {
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
@@ -689,6 +693,8 @@ struct task_struct fastcall * __switch_t
 
 	disable_tsc(prev_p, next_p);
 
+ 	pfm_ctxswin(next_p);
+
 	return prev_p;
 }
 
diff -urp linux-2.6.17.1.orig/arch/i386/kernel/signal.c linux-2.6.17.1/arch/i386/kernel/signal.c
--- linux-2.6.17.1.orig/arch/i386/kernel/signal.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/i386/kernel/signal.c	2006-06-21 04:22:51.000000000 -0700
@@ -21,6 +21,7 @@
 #include <linux/suspend.h>
 #include <linux/ptrace.h>
 #include <linux/elf.h>
+#include <linux/perfmon.h>
 #include <asm/processor.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
@@ -651,6 +652,11 @@ void do_notify_resume(struct pt_regs *re
 		clear_thread_flag(TIF_SINGLESTEP);
 	}
 
+	/*
+ 	 * must be done before signals
+ 	 */
+ 	pfm_handle_work();
+
 	/* deal with pending signal delivery */
 	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_RESTORE_SIGMASK))
 		do_signal(regs);
diff -urp linux-2.6.17.1.orig/arch/i386/kernel/smp.c linux-2.6.17.1/arch/i386/kernel/smp.c
--- linux-2.6.17.1.orig/arch/i386/kernel/smp.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/i386/kernel/smp.c	2006-06-21 04:22:51.000000000 -0700
@@ -624,3 +624,69 @@ fastcall void smp_call_function_interrup
 	}
 }
 
+/*
+ * this function sends a 'generic call function' IPI to one other CPU
+ * in the system.
+ *
+ * cpu is a standard Linux logical CPU number.
+ */
+static void
+__smp_call_function_single(int cpu, void (*func) (void *info), void *info,
+				int nonatomic, int wait)
+{
+	struct call_data_struct data;
+	int cpus = 1;
+  
+	data.func = func;
+	data.info = info;
+	atomic_set(&data.started, 0);
+	data.wait = wait;
+	if (wait)
+		atomic_set(&data.finished, 0);
+
+	call_data = &data;
+	wmb();
+	/* Send a message to all other CPUs and wait for them to respond */
+	send_IPI_mask(cpumask_of_cpu(cpu), CALL_FUNCTION_VECTOR);
+
+	/* Wait for response */
+	while (atomic_read(&data.started) != cpus)
+		cpu_relax();
+
+	if (!wait)
+		return;
+
+	while (atomic_read(&data.finished) != cpus)
+		cpu_relax();
+}
+
+/*
+ * smp_call_function_single - Run a function on another CPU
+ * @func: The function to run. This must be fast and non-blocking.
+ * @info: An arbitrary pointer to pass to the function.
+ * @nonatomic: Currently unused.
+ * @wait: If true, wait until function has completed on other CPUs.
+ *
+ * Retrurns 0 on success, else a negative status code.
+ *
+ * Does not return until the remote CPU is nearly ready to execute <func>
+ * or is or has executed.
+ */
+
+int smp_call_function_single (int cpu, void (*func) (void *info), void *info,
+	int nonatomic, int wait)
+{
+	/* prevent preemption and reschedule on another processor */
+	int me = get_cpu();
+	if (cpu == me) {
+		WARN_ON(1);
+		put_cpu();
+		return -EBUSY;
+	}
+	spin_lock_bh(&call_lock);
+	__smp_call_function_single(cpu, func, info, nonatomic, wait);
+	spin_unlock_bh(&call_lock);
+	put_cpu();
+	return 0;
+}
+EXPORT_SYMBOL(smp_call_function_single);
diff -urp linux-2.6.17.1.orig/arch/i386/kernel/syscall_table.S linux-2.6.17.1/arch/i386/kernel/syscall_table.S
--- linux-2.6.17.1.orig/arch/i386/kernel/syscall_table.S	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/i386/kernel/syscall_table.S	2006-06-21 04:22:51.000000000 -0700
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
Only in linux-2.6.17.1/arch/i386: perfmon
diff -urp linux-2.6.17.1.orig/include/asm-i386/mach-default/entry_arch.h linux-2.6.17.1/include/asm-i386/mach-default/entry_arch.h
--- linux-2.6.17.1.orig/include/asm-i386/mach-default/entry_arch.h	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/include/asm-i386/mach-default/entry_arch.h	2006-06-21 04:22:51.000000000 -0700
@@ -31,4 +31,8 @@ BUILD_INTERRUPT(spurious_interrupt,SPURI
 BUILD_INTERRUPT(thermal_interrupt,THERMAL_APIC_VECTOR)
 #endif
 
+#ifdef CONFIG_PERFMON
+BUILD_INTERRUPT(pmu_interrupt,LOCAL_PERFMON_VECTOR)
+#endif
+
 #endif
diff -urp linux-2.6.17.1.orig/include/asm-i386/mach-default/irq_vectors.h linux-2.6.17.1/include/asm-i386/mach-default/irq_vectors.h
--- linux-2.6.17.1.orig/include/asm-i386/mach-default/irq_vectors.h	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/include/asm-i386/mach-default/irq_vectors.h	2006-06-21 04:22:51.000000000 -0700
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
 
Only in linux-2.6.17.1/include/asm-i386: perfmon.h
Only in linux-2.6.17.1/include/asm-i386: perfmon_p4_pebs_smpl.h
diff -urp linux-2.6.17.1.orig/include/asm-i386/processor.h linux-2.6.17.1/include/asm-i386/processor.h
--- linux-2.6.17.1.orig/include/asm-i386/processor.h	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/include/asm-i386/processor.h	2006-06-21 04:22:51.000000000 -0700
@@ -432,6 +432,7 @@ struct tss_struct {
 	 */
 	unsigned long io_bitmap_max;
 	struct thread_struct *io_bitmap_owner;
+
 	/*
 	 * pads the TSS to be cacheline-aligned (size is 0x100)
 	 */
@@ -469,6 +470,7 @@ struct thread_struct {
  	unsigned long	iopl;
 /* max allowed port in the bitmap, in bytes: */
 	unsigned long	io_bitmap_max;
+ 	void *pfm_context;
 };
 
 #define INIT_THREAD  {							\
diff -urp linux-2.6.17.1.orig/include/asm-i386/smp.h linux-2.6.17.1/include/asm-i386/smp.h
--- linux-2.6.17.1.orig/include/asm-i386/smp.h	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/include/asm-i386/smp.h	2006-06-21 04:22:51.000000000 -0700
@@ -41,7 +41,8 @@ extern void (*mtrr_hook) (void);
 extern void zap_low_mappings (void);
 extern void lock_ipi_call_lock(void);
 extern void unlock_ipi_call_lock(void);
-
+extern int smp_call_function_single(int cpuid, void (*func) (void *info),
+				void *info, int retry, int wait);
 #define MAX_APICID 256
 extern u8 x86_cpu_to_apicid[];
 
diff -urp linux-2.6.17.1.orig/include/asm-i386/system.h linux-2.6.17.1/include/asm-i386/system.h
--- linux-2.6.17.1.orig/include/asm-i386/system.h	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/include/asm-i386/system.h	2006-06-21 04:22:51.000000000 -0700
@@ -14,6 +14,7 @@ extern struct task_struct * FASTCALL(__s
 
 #define switch_to(prev,next,last) do {					\
 	unsigned long esi,edi;						\
+	pfm_ctxswout(prev);						\
 	asm volatile("pushl %%ebp\n\t"					\
 		     "movl %%esp,%0\n\t"	/* save ESP */		\
 		     "movl %5,%%esp\n\t"	/* restore ESP */	\
diff -urp linux-2.6.17.1.orig/include/asm-i386/unistd.h linux-2.6.17.1/include/asm-i386/unistd.h
--- linux-2.6.17.1.orig/include/asm-i386/unistd.h	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/include/asm-i386/unistd.h	2006-06-21 04:22:51.000000000 -0700
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
