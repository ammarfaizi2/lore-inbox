Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWELQkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWELQkm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 12:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWELQkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 12:40:23 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:52395 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932151AbWELQkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 12:40:09 -0400
Date: Fri, 12 May 2006 09:33:48 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200605121633.k4CGXmKd027348@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 7/11] perfmon2 patch for review: modified i386 files
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the modified i386 files.




diff -ur linux-2.6.17-rc4.orig/arch/i386/Kconfig linux-2.6.17-rc4/arch/i386/Kconfig
--- linux-2.6.17-rc4.orig/arch/i386/Kconfig	2006-05-12 03:16:09.000000000 -0700
+++ linux-2.6.17-rc4/arch/i386/Kconfig	2006-05-12 03:18:52.000000000 -0700
@@ -763,6 +763,21 @@
 
 	  Say N.
 
+menu "Hardware Performance Monitoring support"
+
+config PERFMON
+  	bool "Perfmon2 performance monitoring interface"
+	select X86_LOCAL_APIC
+	default y
+  	help
+  	  include the perfmon2 performance monitoring interface
+ 	  in the kernel. See <http://www.hpl.hp.com/research/linux/perfmon> for
+ 	  more details. If you're unsure, say Y.
+ 
+source "arch/i386/perfmon/Kconfig"
+endmenu
+
+
 endmenu
 
 
diff -ur linux-2.6.17-rc4.orig/arch/i386/Makefile linux-2.6.17-rc4/arch/i386/Makefile
--- linux-2.6.17-rc4.orig/arch/i386/Makefile	2006-05-12 03:16:09.000000000 -0700
+++ linux-2.6.17-rc4/arch/i386/Makefile	2006-05-12 03:18:52.000000000 -0700
@@ -87,6 +87,7 @@
 head-y := arch/i386/kernel/head.o arch/i386/kernel/init_task.o
 
 libs-y 					+= arch/i386/lib/
+core-$(CONFIG_PERFMON)			+= arch/i386/perfmon/
 core-y					+= arch/i386/kernel/ \
 					   arch/i386/mm/ \
 					   arch/i386/$(mcore-y)/ \
diff -ur linux-2.6.17-rc4.orig/arch/i386/kernel/apic.c linux-2.6.17-rc4/arch/i386/kernel/apic.c
--- linux-2.6.17-rc4.orig/arch/i386/kernel/apic.c	2006-05-12 03:16:09.000000000 -0700
+++ linux-2.6.17-rc4/arch/i386/kernel/apic.c	2006-05-12 03:18:52.000000000 -0700
@@ -27,6 +27,7 @@
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/perfmon.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -1179,6 +1180,8 @@
 	update_process_times(user_mode_vm(regs));
 #endif
 
+	pfm_handle_switch_timeout();
+
 	/*
 	 * We take the 'long' return path, and there every subsystem
 	 * grabs the apropriate locks (kernel lock/ irq lock).
diff -ur linux-2.6.17-rc4.orig/arch/i386/kernel/entry.S linux-2.6.17-rc4/arch/i386/kernel/entry.S
--- linux-2.6.17-rc4.orig/arch/i386/kernel/entry.S	2006-05-12 03:16:09.000000000 -0700
+++ linux-2.6.17-rc4/arch/i386/kernel/entry.S	2006-05-12 03:18:52.000000000 -0700
@@ -436,6 +436,16 @@
 /* The include is where all of the SMP etc. interrupts come from */
 #include "entry_arch.h"
 
+#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PERFMON)
+ENTRY(pmu_interrupt)
+  	pushl $LOCAL_PERFMON_VECTOR-256
+  	SAVE_ALL
+  	pushl %esp
+ 	call pfm_intr_handler
+  	addl $4, %esp
+  	jmp ret_from_intr
+#endif
+
 ENTRY(divide_error)
 	pushl $0			# no error code
 	pushl $do_divide_error
diff -ur linux-2.6.17-rc4.orig/arch/i386/kernel/i8259.c linux-2.6.17-rc4/arch/i386/kernel/i8259.c
--- linux-2.6.17-rc4.orig/arch/i386/kernel/i8259.c	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.17-rc4/arch/i386/kernel/i8259.c	2006-05-12 03:18:52.000000000 -0700
@@ -11,6 +11,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/bitops.h>
+#include <linux/perfmon.h>
 
 #include <asm/8253pit.h>
 #include <asm/atomic.h>
@@ -427,6 +428,8 @@
 	 */
 	setup_pit_timer();
 
+ 	pfm_vector_init();
+
 	/*
 	 * External FPU? Set up irq13 if so, for
 	 * original braindamaged IBM FERR coupling.
diff -ur linux-2.6.17-rc4.orig/arch/i386/kernel/process.c linux-2.6.17-rc4/arch/i386/kernel/process.c
--- linux-2.6.17-rc4.orig/arch/i386/kernel/process.c	2006-05-12 03:16:09.000000000 -0700
+++ linux-2.6.17-rc4/arch/i386/kernel/process.c	2006-05-12 03:18:52.000000000 -0700
@@ -33,6 +33,7 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/perfmon.h>
 #include <linux/mc146818rtc.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
@@ -380,6 +381,7 @@
 		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 		put_cpu();
 	}
+	pfm_exit_thread(tsk);
 }
 
 void flush_thread(void)
@@ -431,6 +433,8 @@
 	savesegment(fs,p->thread.fs);
 	savesegment(gs,p->thread.gs);
 
+ 	pfm_copy_thread(p, childregs);
+
 	tsk = current;
 	if (unlikely(NULL != tsk->thread.io_bitmap_ptr)) {
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
@@ -689,6 +693,8 @@
 
 	disable_tsc(prev_p, next_p);
 
+ 	pfm_ctxswin(next_p);
+
 	return prev_p;
 }
 
diff -ur linux-2.6.17-rc4.orig/arch/i386/kernel/signal.c linux-2.6.17-rc4/arch/i386/kernel/signal.c
--- linux-2.6.17-rc4.orig/arch/i386/kernel/signal.c	2006-05-12 03:16:09.000000000 -0700
+++ linux-2.6.17-rc4/arch/i386/kernel/signal.c	2006-05-12 03:18:52.000000000 -0700
@@ -21,6 +21,7 @@
 #include <linux/suspend.h>
 #include <linux/ptrace.h>
 #include <linux/elf.h>
+#include <linux/perfmon.h>
 #include <asm/processor.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
@@ -651,6 +652,11 @@
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
diff -ur linux-2.6.17-rc4.orig/arch/i386/kernel/smp.c linux-2.6.17-rc4/arch/i386/kernel/smp.c
--- linux-2.6.17-rc4.orig/arch/i386/kernel/smp.c	2006-05-12 03:16:09.000000000 -0700
+++ linux-2.6.17-rc4/arch/i386/kernel/smp.c	2006-05-12 03:18:52.000000000 -0700
@@ -624,3 +624,69 @@
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
diff -ur linux-2.6.17-rc4.orig/arch/i386/kernel/syscall_table.S linux-2.6.17-rc4/arch/i386/kernel/syscall_table.S
--- linux-2.6.17-rc4.orig/arch/i386/kernel/syscall_table.S	2006-05-12 03:16:09.000000000 -0700
+++ linux-2.6.17-rc4/arch/i386/kernel/syscall_table.S	2006-05-12 03:18:52.000000000 -0700
@@ -315,3 +315,16 @@
 	.long sys_splice
 	.long sys_sync_file_range
 	.long sys_tee			/* 315 */
+	.long sys_vmsplice
+      	.long sys_pfm_create_context
+       	.long sys_pfm_write_pmcs
+       	.long sys_pfm_write_pmds
+       	.long sys_pfm_read_pmds		/* 320 */
+       	.long sys_pfm_load_context
+       	.long sys_pfm_start
+       	.long sys_pfm_stop
+       	.long sys_pfm_restart
+       	.long sys_pfm_create_evtsets	/* 325 */
+       	.long sys_pfm_getinfo_evtsets
+       	.long sys_pfm_delete_evtsets
+ 	.long sys_pfm_unload_context
diff -ur linux-2.6.17-rc4.orig/include/asm-i386/mach-default/irq_vectors.h linux-2.6.17-rc4/include/asm-i386/mach-default/irq_vectors.h
--- linux-2.6.17-rc4.orig/include/asm-i386/mach-default/irq_vectors.h	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.17-rc4/include/asm-i386/mach-default/irq_vectors.h	2006-05-12 03:18:52.000000000 -0700
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
 
diff -ur linux-2.6.17-rc4.orig/include/asm-i386/processor.h linux-2.6.17-rc4/include/asm-i386/processor.h
--- linux-2.6.17-rc4.orig/include/asm-i386/processor.h	2006-05-12 03:16:14.000000000 -0700
+++ linux-2.6.17-rc4/include/asm-i386/processor.h	2006-05-12 03:18:52.000000000 -0700
@@ -432,6 +432,7 @@
 	 */
 	unsigned long io_bitmap_max;
 	struct thread_struct *io_bitmap_owner;
+
 	/*
 	 * pads the TSS to be cacheline-aligned (size is 0x100)
 	 */
@@ -469,6 +470,7 @@
  	unsigned long	iopl;
 /* max allowed port in the bitmap, in bytes: */
 	unsigned long	io_bitmap_max;
+ 	void *pfm_context;
 };
 
 #define INIT_THREAD  {							\
diff -ur linux-2.6.17-rc4.orig/include/asm-i386/smp.h linux-2.6.17-rc4/include/asm-i386/smp.h
--- linux-2.6.17-rc4.orig/include/asm-i386/smp.h	2006-03-19 21:53:29.000000000 -0800
+++ linux-2.6.17-rc4/include/asm-i386/smp.h	2006-05-12 03:18:52.000000000 -0700
@@ -41,7 +41,8 @@
 extern void zap_low_mappings (void);
 extern void lock_ipi_call_lock(void);
 extern void unlock_ipi_call_lock(void);
-
+extern int smp_call_function_single(int cpuid, void (*func) (void *info),
+				void *info, int retry, int wait);
 #define MAX_APICID 256
 extern u8 x86_cpu_to_apicid[];
 
diff -ur linux-2.6.17-rc4.orig/include/asm-i386/system.h linux-2.6.17-rc4/include/asm-i386/system.h
--- linux-2.6.17-rc4.orig/include/asm-i386/system.h	2006-05-12 03:16:14.000000000 -0700
+++ linux-2.6.17-rc4/include/asm-i386/system.h	2006-05-12 03:18:52.000000000 -0700
@@ -14,6 +14,7 @@
 
 #define switch_to(prev,next,last) do {					\
 	unsigned long esi,edi;						\
+	pfm_ctxswout(prev);						\
 	asm volatile("pushl %%ebp\n\t"					\
 		     "movl %%esp,%0\n\t"	/* save ESP */		\
 		     "movl %5,%%esp\n\t"	/* restore ESP */	\
diff -ur linux-2.6.17-rc4.orig/include/asm-i386/unistd.h linux-2.6.17-rc4/include/asm-i386/unistd.h
--- linux-2.6.17-rc4.orig/include/asm-i386/unistd.h	2006-05-12 03:16:14.000000000 -0700
+++ linux-2.6.17-rc4/include/asm-i386/unistd.h	2006-05-12 03:18:52.000000000 -0700
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
+#define NR_syscalls 329
 
 /*
  * user-visible error numbers are in the range -1 - -128: see
