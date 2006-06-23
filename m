Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932955AbWFWJYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932955AbWFWJYJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 05:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWFWJVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 05:21:30 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:48538 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S932950AbWFWJVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 05:21:09 -0400
Date: Fri, 23 Jun 2006 02:13:14 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200606230913.k5N9DE54032471@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 17/17] 2.6.17.1 perfmon2 patch for review: modified x86_64 files
Cc: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the modified files for x86_64 (AMD and Intel EM64T).
diff -urp linux-2.6.17.1.orig/arch/x86_64/Kconfig linux-2.6.17.1/arch/x86_64/Kconfig
--- linux-2.6.17.1.orig/arch/x86_64/Kconfig	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/x86_64/Kconfig	2006-06-21 04:22:51.000000000 -0700
@@ -501,6 +501,8 @@ config REORDER
          optimal TLB usage. If you have pretty much any version of binutils, 
 	 this can increase your kernel build time by roughly one minute.
 
+source "arch/x86_64/perfmon/Kconfig"
+
 endmenu
 
 #
diff -urp linux-2.6.17.1.orig/arch/x86_64/Makefile linux-2.6.17.1/arch/x86_64/Makefile
--- linux-2.6.17.1.orig/arch/x86_64/Makefile	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/x86_64/Makefile	2006-06-21 04:22:51.000000000 -0700
@@ -65,6 +65,7 @@ core-y					+= arch/x86_64/kernel/ \
 					   arch/x86_64/crypto/
 core-$(CONFIG_IA32_EMULATION)		+= arch/x86_64/ia32/
 drivers-$(CONFIG_PCI)			+= arch/x86_64/pci/
+drivers-$(CONFIG_PERFMON)		+= arch/x86_64/perfmon/
 drivers-$(CONFIG_OPROFILE)		+= arch/x86_64/oprofile/
 
 boot := arch/x86_64/boot
diff -urp linux-2.6.17.1.orig/arch/x86_64/ia32/ia32entry.S linux-2.6.17.1/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.17.1.orig/arch/x86_64/ia32/ia32entry.S	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/x86_64/ia32/ia32entry.S	2006-06-21 04:22:51.000000000 -0700
@@ -696,4 +696,17 @@ ia32_sys_call_table:
 	.quad sys_sync_file_range
 	.quad sys_tee
 	.quad compat_sys_vmsplice
+   	.quad sys_pfm_create_context
+       	.quad sys_pfm_write_pmcs
+       	.quad sys_pfm_write_pmds
+       	.quad sys_pfm_read_pmds		/* 320 */
+       	.quad sys_pfm_load_context
+       	.quad sys_pfm_start
+       	.quad sys_pfm_stop
+       	.quad sys_pfm_restart
+       	.quad sys_pfm_create_evtsets	/* 325 */
+       	.quad sys_pfm_getinfo_evtsets
+       	.quad sys_pfm_delete_evtsets
+  	.quad sys_pfm_unload_context
+
 ia32_syscall_end:		
diff -urp linux-2.6.17.1.orig/arch/x86_64/kernel/apic.c linux-2.6.17.1/arch/x86_64/kernel/apic.c
--- linux-2.6.17.1.orig/arch/x86_64/kernel/apic.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/x86_64/kernel/apic.c	2006-06-21 04:22:51.000000000 -0700
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
diff -urp linux-2.6.17.1.orig/arch/x86_64/kernel/entry.S linux-2.6.17.1/arch/x86_64/kernel/entry.S
--- linux-2.6.17.1.orig/arch/x86_64/kernel/entry.S	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/x86_64/kernel/entry.S	2006-06-21 04:22:51.000000000 -0700
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
diff -urp linux-2.6.17.1.orig/arch/x86_64/kernel/i8259.c linux-2.6.17.1/arch/x86_64/kernel/i8259.c
--- linux-2.6.17.1.orig/arch/x86_64/kernel/i8259.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/x86_64/kernel/i8259.c	2006-06-21 04:22:51.000000000 -0700
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
diff -urp linux-2.6.17.1.orig/arch/x86_64/kernel/nmi.c linux-2.6.17.1/arch/x86_64/kernel/nmi.c
--- linux-2.6.17.1.orig/arch/x86_64/kernel/nmi.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/x86_64/kernel/nmi.c	2006-06-21 04:22:51.000000000 -0700
@@ -248,6 +248,7 @@ int reserve_lapic_nmi(void)
 	old_owner = lapic_nmi_owner;
 	lapic_nmi_owner |= LAPIC_NMI_RESERVED;
 	spin_unlock(&lapic_nmi_owner_lock);
+
 	if (old_owner & LAPIC_NMI_RESERVED)
 		return -EBUSY;
 	if (old_owner & LAPIC_NMI_WATCHDOG)
diff -urp linux-2.6.17.1.orig/arch/x86_64/kernel/process.c linux-2.6.17.1/arch/x86_64/kernel/process.c
--- linux-2.6.17.1.orig/arch/x86_64/kernel/process.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/x86_64/kernel/process.c	2006-06-21 04:22:51.000000000 -0700
@@ -37,6 +37,7 @@
 #include <linux/random.h>
 #include <linux/notifier.h>
 #include <linux/kprobes.h>
+#include <linux/perfmon.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -358,6 +359,7 @@ void exit_thread(void)
 		t->io_bitmap_max = 0;
 		put_cpu();
 	}
+	pfm_exit_thread(me);
 }
 
 void flush_thread(void)
@@ -459,6 +461,8 @@ int copy_thread(int nr, unsigned long cl
 	asm("mov %%es,%0" : "=m" (p->thread.es));
 	asm("mov %%ds,%0" : "=m" (p->thread.ds));
 
+	pfm_copy_thread(p, childregs);
+
 	if (unlikely(me->thread.io_bitmap_ptr != NULL)) { 
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.io_bitmap_ptr) {
@@ -482,6 +486,8 @@ int copy_thread(int nr, unsigned long cl
 		if (err) 
 			goto out;
 	}
+
+
 	err = 0;
 out:
 	if (err && p->thread.io_bitmap_ptr) {
@@ -615,6 +621,7 @@ __switch_to(struct task_struct *prev_p, 
 			memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
 		}
 	}
+	pfm_ctxswin(next_p);
 
 	return prev_p;
 }
diff -urp linux-2.6.17.1.orig/arch/x86_64/kernel/signal.c linux-2.6.17.1/arch/x86_64/kernel/signal.c
--- linux-2.6.17.1.orig/arch/x86_64/kernel/signal.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/x86_64/kernel/signal.c	2006-06-21 04:22:51.000000000 -0700
@@ -24,6 +24,7 @@
 #include <linux/stddef.h>
 #include <linux/personality.h>
 #include <linux/compiler.h>
+#include <linux/perfmon.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/i387.h>
@@ -492,6 +493,10 @@ void do_notify_resume(struct pt_regs *re
 		regs->eflags |= TF_MASK;
 		clear_thread_flag(TIF_SINGLESTEP);
 	}
+	/*
+	 * must be done before signals
+	 */
+	pfm_handle_work();
 
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
diff -urp linux-2.6.17.1.orig/arch/x86_64/kernel/x8664_ksyms.c linux-2.6.17.1/arch/x86_64/kernel/x8664_ksyms.c
--- linux-2.6.17.1.orig/arch/x86_64/kernel/x8664_ksyms.c	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/arch/x86_64/kernel/x8664_ksyms.c	2006-06-21 04:22:51.000000000 -0700
@@ -95,6 +95,7 @@ EXPORT_SYMBOL(__write_lock_failed);
 EXPORT_SYMBOL(__read_lock_failed);
 
 EXPORT_SYMBOL(smp_call_function);
+EXPORT_SYMBOL(smp_call_function_single);
 EXPORT_SYMBOL(cpu_callout_map);
 #endif
 
Only in linux-2.6.17.1/arch/x86_64: perfmon
diff -urp linux-2.6.17.1.orig/include/asm-x86_64/hw_irq.h linux-2.6.17.1/include/asm-x86_64/hw_irq.h
--- linux-2.6.17.1.orig/include/asm-x86_64/hw_irq.h	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/include/asm-x86_64/hw_irq.h	2006-06-21 04:22:51.000000000 -0700
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
diff -urp linux-2.6.17.1.orig/include/asm-x86_64/irq.h linux-2.6.17.1/include/asm-x86_64/irq.h
--- linux-2.6.17.1.orig/include/asm-x86_64/irq.h	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/include/asm-x86_64/irq.h	2006-06-21 04:22:51.000000000 -0700
@@ -29,7 +29,7 @@
  */
 #define NR_VECTORS 256
 
-#define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in hw_irq.h */
+#define FIRST_SYSTEM_VECTOR	0xee   /* duplicated in hw_irq.h */
 
 #ifdef CONFIG_PCI_MSI
 #define NR_IRQS FIRST_SYSTEM_VECTOR
Only in linux-2.6.17.1/include/asm-x86_64: perfmon.h
Only in linux-2.6.17.1/include/asm-x86_64: perfmon_em64t_pebs_smpl.h
diff -urp linux-2.6.17.1.orig/include/asm-x86_64/system.h linux-2.6.17.1/include/asm-x86_64/system.h
--- linux-2.6.17.1.orig/include/asm-x86_64/system.h	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/include/asm-x86_64/system.h	2006-06-21 04:22:51.000000000 -0700
@@ -27,6 +27,7 @@
 	,"rcx","rbx","rdx","r8","r9","r10","r11","r12","r13","r14","r15"
 
 #define switch_to(prev,next,last) \
+	pfm_ctxswout(prev);							  \
 	asm volatile(SAVE_CONTEXT						    \
 		     "movq %%rsp,%P[threadrsp](%[prev])\n\t" /* save RSP */	  \
 		     "movq %P[threadrsp](%[next]),%%rsp\n\t" /* restore RSP */	  \
diff -urp linux-2.6.17.1.orig/include/asm-x86_64/unistd.h linux-2.6.17.1/include/asm-x86_64/unistd.h
--- linux-2.6.17.1.orig/include/asm-x86_64/unistd.h	2006-06-20 02:31:55.000000000 -0700
+++ linux-2.6.17.1/include/asm-x86_64/unistd.h	2006-06-21 04:22:51.000000000 -0700
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
 
