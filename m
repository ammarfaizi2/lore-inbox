Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTEWHO2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 03:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbTEWHO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 03:14:28 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:59274 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263932AbTEWHOV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 03:14:21 -0400
From: Rusty Russell <rusty@au1.ibm.com>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       David Mosberger-Tang <davidm@hpl.hp.com>
Subject: Re: [PATCH 4/3] Replace dynamic percpu implementation 
In-reply-to: Your message of "Thu, 22 May 2003 16:19:44 +0530."
             <20030522104944.GE27614@in.ibm.com> 
Date: Fri, 23 May 2003 17:23:15 +1000
Message-Id: <20030523072617.5CBAE18D58@ozlabs.au.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030522104944.GE27614@in.ibm.com> you write:
> On Thu, May 22, 2003 at 06:36:31PM +1000, Rusty Russell wrote:
> > If you're interested I can probably produce such a patch for x86...
> 
> Sure, it might help per-cpu data but will it cause performance
> regression elsewhere? (other users of smp_processor_id).  I can run it 
> through the same tests and find out.  Maybe it'll make good paper material 
> for later? ;)

OK, here's an x86-specific patch.  It boots for me.  I'm mainly
interested in the question of whether it increases static percpu
speed.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Put __per_cpu_offset in the thread struct, remove cpu
Author: Rusty Russell
Status: Tested on 2.5.69-bk15, dual x86

D: If we had an efficient kmalloc_percpu-equiv, and moved more structures
D: across to it (or to DECLARE_PER_CPU), it makes more sense to derive
D: smp_processor_id() from the per-cpu offset, rather than the other way
D: around.
D:
D: This patch is an x86-only hack to do just that, for benchmarking.
D: It introduces a new header, asm/task_cpu.h, because I couldn't
D: resolve the horrible header tangle any other way.

diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk15/arch/i386/kernel/i386_ksyms.c working-2.5.69-bk15-offset-uber-alles/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.69-bk15/arch/i386/kernel/i386_ksyms.c	2003-05-22 10:48:33.000000000 +1000
+++ working-2.5.69-bk15-offset-uber-alles/arch/i386/kernel/i386_ksyms.c	2003-05-23 16:13:53.000000000 +1000
@@ -152,6 +152,7 @@ EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(cpu_callout_map);
 EXPORT_SYMBOL_NOVERS(__write_lock_failed);
 EXPORT_SYMBOL_NOVERS(__read_lock_failed);
+EXPORT_PER_CPU_SYMBOL(__processor_id);
 
 /* Global SMP stuff */
 EXPORT_SYMBOL(synchronize_irq);
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk15/arch/i386/kernel/smpboot.c working-2.5.69-bk15-offset-uber-alles/arch/i386/kernel/smpboot.c
--- linux-2.5.69-bk15/arch/i386/kernel/smpboot.c	2003-05-22 10:48:33.000000000 +1000
+++ working-2.5.69-bk15-offset-uber-alles/arch/i386/kernel/smpboot.c	2003-05-23 16:12:27.000000000 +1000
@@ -49,6 +49,7 @@
 #include <asm/tlbflush.h>
 #include <asm/desc.h>
 #include <asm/arch_hooks.h>
+#include <asm/task_cpu.h>
 
 #include <mach_apic.h>
 #include <mach_wakecpu.h>
@@ -947,7 +948,6 @@ static void __init smp_boot_cpus(unsigne
 
 	boot_cpu_logical_apicid = logical_smp_processor_id();
 
-	current_thread_info()->cpu = 0;
 	smp_tune_scheduling();
 
 	/*
@@ -1129,6 +1130,38 @@ void __devinit smp_prepare_boot_cpu(void
 	set_bit(smp_processor_id(), &cpu_callout_map);
 }
 
+DEFINE_PER_CPU(u32, __processor_id);
+unsigned long __per_cpu_offset[NR_CPUS];
+
+void __init setup_per_cpu_areas(void)
+{
+	unsigned long size, i;
+	char *ptr;
+	/* Created by linker magic */
+	extern char __per_cpu_start[], __per_cpu_end[];
+
+	/* Copy section for each CPU (we discard the original) */
+	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
+	if (!size)
+		return;
+
+	ptr = alloc_bootmem(size * NR_CPUS);
+
+	for (i = 0; i < NR_CPUS; i++, ptr += size) {
+		__per_cpu_offset[i] = ptr - __per_cpu_start;
+		memcpy(ptr, __per_cpu_start, size);
+	}
+
+	/* Now, setup per-cpu stuff so smp_processor_id() will work when
+	 * we boot other CPUs */
+	for (i = 0; i < NR_CPUS; i++)
+		per_cpu(__processor_id, i) = i;
+
+	/* Our pcpuoff points into the original .data.percpu section:
+	   that will vanish, so fixup now. */
+	set_task_cpu(current, smp_processor_id());
+}
+
 int __devinit __cpu_up(unsigned int cpu)
 {
 	/* This only works at boot for x86.  See "rewrite" above. */
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk15/fs/proc/array.c working-2.5.69-bk15-offset-uber-alles/fs/proc/array.c
--- linux-2.5.69-bk15/fs/proc/array.c	2003-05-05 12:37:09.000000000 +1000
+++ working-2.5.69-bk15-offset-uber-alles/fs/proc/array.c	2003-05-23 16:00:42.000000000 +1000
@@ -78,6 +78,7 @@
 #include <asm/pgtable.h>
 #include <asm/io.h>
 #include <asm/processor.h>
+#include <asm/task_cpu.h>
 
 /* Gcc optimizes away "strlen(x)" for constant x */
 #define ADDBUF(buffer, string) \
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk15/include/asm-i386/percpu.h working-2.5.69-bk15-offset-uber-alles/include/asm-i386/percpu.h
--- linux-2.5.69-bk15/include/asm-i386/percpu.h	2003-01-02 12:00:21.000000000 +1100
+++ working-2.5.69-bk15-offset-uber-alles/include/asm-i386/percpu.h	2003-05-23 16:05:22.000000000 +1000
@@ -1,6 +1,40 @@
 #ifndef __ARCH_I386_PERCPU__
 #define __ARCH_I386_PERCPU__
 
-#include <asm-generic/percpu.h>
+#include <linux/compiler.h>
+
+#ifdef CONFIG_SMP
+
+extern void setup_per_cpu_areas(void);
+extern unsigned long __per_cpu_offset[NR_CPUS];
+
+/* Separate out the type, so (int[3], foo) works. */
+#ifndef MODULE
+#define DEFINE_PER_CPU(type, name) \
+    __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
+#endif
+
+/* var is in discarded region: offset to particular copy we want */
+#define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
+#define __get_cpu_var(var) \
+	(*RELOC_HIDE(&var##__per_cpu, current_thread_info()->pcpuoff))
+
+#else /* ! SMP */
+
+/* Can't define per-cpu variables in modules.  Sorry --RR */
+#ifndef MODULE
+#define DEFINE_PER_CPU(type, name) \
+    __typeof__(type) name##__per_cpu
+#endif
+
+#define per_cpu(var, cpu)			((void)cpu, var##__per_cpu)
+#define __get_cpu_var(var)			var##__per_cpu
+
+#endif	/* SMP */
+
+#define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
+
+#define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
+#define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)
 
 #endif /* __ARCH_I386_PERCPU__ */
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk15/include/asm-i386/smp.h working-2.5.69-bk15-offset-uber-alles/include/asm-i386/smp.h
--- linux-2.5.69-bk15/include/asm-i386/smp.h	2003-05-22 10:49:07.000000000 +1000
+++ working-2.5.69-bk15-offset-uber-alles/include/asm-i386/smp.h	2003-05-23 16:02:53.000000000 +1000
@@ -8,6 +8,7 @@
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/threads.h>
+#include <asm/percpu.h>
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -53,7 +54,8 @@ extern void zap_low_mappings (void);
  * from the initial startup. We map APIC_BASE very early in page_setup(),
  * so this is correct in the x86 case.
  */
-#define smp_processor_id() (current_thread_info()->cpu)
+DECLARE_PER_CPU(u32, __processor_id);
+#define smp_processor_id() __get_cpu_var(__processor_id)
 
 extern volatile unsigned long cpu_callout_map;
 
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk15/include/asm-i386/task_cpu.h working-2.5.69-bk15-offset-uber-alles/include/asm-i386/task_cpu.h
--- linux-2.5.69-bk15/include/asm-i386/task_cpu.h	1970-01-01 10:00:00.000000000 +1000
+++ working-2.5.69-bk15-offset-uber-alles/include/asm-i386/task_cpu.h	2003-05-23 16:02:41.000000000 +1000
@@ -0,0 +1,17 @@
+#ifndef _ASM_I386_TASK_CPU_H
+#define _ASM_I386_TASK_CPU_H
+#include <linux/percpu.h>
+#include <linux/sched.h>
+
+static inline unsigned int task_cpu(struct task_struct *p)
+{
+	return (*RELOC_HIDE(&__processor_id__per_cpu,
+			    p->thread_info->pcpuoff));
+}
+
+static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
+{
+	/* CPU is derived.  We need to set the per-cpu offset. */
+	p->thread_info->pcpuoff = __per_cpu_offset[cpu];
+}
+#endif
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk15/include/asm-i386/thread_info.h working-2.5.69-bk15-offset-uber-alles/include/asm-i386/thread_info.h
--- linux-2.5.69-bk15/include/asm-i386/thread_info.h	2003-03-18 12:21:39.000000000 +1100
+++ working-2.5.69-bk15-offset-uber-alles/include/asm-i386/thread_info.h	2003-05-23 15:54:14.000000000 +1000
@@ -26,7 +26,7 @@ struct thread_info {
 	struct exec_domain	*exec_domain;	/* execution domain */
 	unsigned long		flags;		/* low level flags */
 	unsigned long		status;		/* thread-synchronous flags */
-	__u32			cpu;		/* current CPU */
+	unsigned long		pcpuoff;	/* per-cpu offset */
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
 
 	mm_segment_t		addr_limit;	/* thread address space:
@@ -45,7 +45,7 @@ struct thread_info {
 #define TI_EXEC_DOMAIN	0x00000004
 #define TI_FLAGS	0x00000008
 #define TI_STATUS	0x0000000C
-#define TI_CPU		0x00000010
+#define TI_PCPUOFF	0x00000010
 #define TI_PRE_COUNT	0x00000014
 #define TI_ADDR_LIMIT	0x00000018
 #define TI_RESTART_BLOCK 0x000001C
@@ -66,7 +66,7 @@ struct thread_info {
 	.task		= &tsk,			\
 	.exec_domain	= &default_exec_domain,	\
 	.flags		= 0,			\
-	.cpu		= 0,			\
+	.pcpuoff	= 0,			\
 	.preempt_count	= 1,			\
 	.addr_limit	= KERNEL_DS,		\
 	.restart_block = {			\
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk15/include/linux/sched.h working-2.5.69-bk15-offset-uber-alles/include/linux/sched.h
--- linux-2.5.69-bk15/include/linux/sched.h	2003-05-22 10:49:18.000000000 +1000
+++ working-2.5.69-bk15-offset-uber-alles/include/linux/sched.h	2003-05-23 15:38:53.000000000 +1000
@@ -813,20 +813,7 @@ extern void signal_wake_up(struct task_s
 /*
  * Wrappers for p->thread_info->cpu access. No-op on UP.
  */
-#ifdef CONFIG_SMP
-
-static inline unsigned int task_cpu(struct task_struct *p)
-{
-	return p->thread_info->cpu;
-}
-
-static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
-{
-	p->thread_info->cpu = cpu;
-}
-
-#else
-
+#ifndef CONFIG_SMP
 static inline unsigned int task_cpu(struct task_struct *p)
 {
 	return 0;
diff -urNp --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.69-bk15/kernel/sched.c working-2.5.69-bk15-offset-uber-alles/kernel/sched.c
--- linux-2.5.69-bk15/kernel/sched.c	2003-05-22 10:49:22.000000000 +1000
+++ working-2.5.69-bk15-offset-uber-alles/kernel/sched.c	2003-05-23 16:03:55.000000000 +1000
@@ -32,6 +32,7 @@
 #include <linux/delay.h>
 #include <linux/timer.h>
 #include <linux/rcupdate.h>
+#include <asm/task_cpu.h>
 
 #ifdef CONFIG_NUMA
 #define cpu_to_node_mask(cpu) node_to_cpumask(cpu_to_node(cpu))
@@ -1312,7 +1313,7 @@ pick_next_task:
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
-	RCU_qsctr(prev->thread_info->cpu)++;
+	RCU_qsctr(task_cpu(prev))++;
 
 	if (likely(prev != next)) {
 		rq->nr_switches++;
