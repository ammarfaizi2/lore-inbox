Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314553AbSHHFNk>; Thu, 8 Aug 2002 01:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315200AbSHHFNj>; Thu, 8 Aug 2002 01:13:39 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:33167 "EHLO
	lists.samba.org") by vger.kernel.org with ESMTP id <S314553AbSHHFNf>;
	Thu, 8 Aug 2002 01:13:35 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Matthew Wilcox <willy@debian.org>, torvalds@transmeta.com
Cc: "David S. Miller" <davem@redhat.com>, george@mvista.com,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: softirq parameters 
In-reply-to: Your message of "Wed, 07 Aug 2002 19:23:14 +0100."
             <20020807192314.H24631@parcelfarce.linux.theplanet.co.uk> 
Date: Thu, 08 Aug 2002 15:13:02 +1000
Message-Id: <20020808051907.F279F4141@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020807192314.H24631@parcelfarce.linux.theplanet.co.uk> you write:
> So what we want is something more like:
> 
> struct softnet_data softnet_data __per_cpu_data = { NULL };
> 
>                 do {
>                         if (pending & 1)
>                                 h->action(this_cpu(h->data));
>                         h++;
>                         pending >>= 1;
>                 } while (pending);

Yep, a trivial change, but a nice one.

Of course, per-cpu changes needed first.  Linus?

Descriptions moved up here:

Name: get_cpu_var patch
Author: Rusty Russell
Status: Cleanup

D: This makes introduces get_cpu_var()/put_cpu_var() which gets a
D: per-cpu variable and disables preemption, and renames the (unsafe
D: under preemption) "this_cpu()" macro to __get_cpu_var().  It also
D: deletes the redundant definitions in linux/smp.h.

Name: Export __per_cpu_offset so modules can use per-cpu data.
Author: Rusty Russell
Status: Trivial

D: As per Andrew Morton's request.

Name: DECLARE_PER_CPU/DEFINE_PER_CPU patch
Author: Rusty Russell
Status: Cleanup
Depends: Misc/get-percpu.patch.gz Misc/percpu-export.patch.gz

D: This old __per_cpu_data define wasn't enough if an arch wants to
D: use the gcc __thread prefix (thread local storage), which needs to
D: go *before* the type in the definition.  So we have to go for a
D: DECLARE macro, and while we're there, separate DECLARE and DEFINE,
D: as definitions of per-cpu data cannot live in modules.  This also
D: means that accidental direct references to per-cpu variables will
D: be caught at compile time.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29.11839/arch/ia64/kernel/perfmon.c linux-2.5.29.11839.updated/arch/ia64/kernel/perfmon.c
--- linux-2.5.29.11839/arch/ia64/kernel/perfmon.c	Thu Jun 20 01:28:47 2002
+++ linux-2.5.29.11839.updated/arch/ia64/kernel/perfmon.c	Sat Jul 27 17:35:00 2002
@@ -1762,7 +1762,7 @@ pfm_stop(struct task_struct *task, pfm_c
 		ia64_srlz_i();
 
 #ifdef CONFIG_SMP
-		this_cpu(pfm_dcr_pp)  = 0;
+		__get_cpu_var(pfm_dcr_pp)  = 0;
 #else
 		pfm_tasklist_toggle_pp(0);
 #endif
@@ -2163,7 +2163,7 @@ pfm_start(struct task_struct *task, pfm_
 	if (ctx->ctx_fl_system) {
 		
 #ifdef CONFIG_SMP
-		this_cpu(pfm_dcr_pp)  = 1;
+		__get_cpu_var(pfm_dcr_pp)  = 1;
 #else
 		pfm_tasklist_toggle_pp(1);
 #endif
@@ -2218,8 +2218,8 @@ pfm_enable(struct task_struct *task, pfm
 		ia64_srlz_i();
 
 #ifdef CONFIG_SMP
-		this_cpu(pfm_syst_wide) = 1;
-		this_cpu(pfm_dcr_pp)    = 0;
+		__get_cpu_var(pfm_syst_wide) = 1;
+		__get_cpu_var(pfm_dcr_pp)    = 0;
 #endif
 	} else {
		/*
@@ -2973,9 +2973,9 @@ perfmon_proc_info(char *page)
 	p += sprintf(p, "CPU%d syst_wide   : %d\n"
 			"CPU%d dcr_pp      : %d\n", 
 			smp_processor_id(), 
-			this_cpu(pfm_syst_wide), 
+			__get_cpu_var(pfm_syst_wide), 
 			smp_processor_id(), 
-			this_cpu(pfm_dcr_pp));
+			__get_cpu_var(pfm_dcr_pp));
 #endif
 
 	LOCK_PFS();
@@ -3045,7 +3045,7 @@ pfm_syst_wide_update_task(struct task_st
 	/*
 	 * propagate the value of the dcr_pp bit to the psr
 	 */
-	ia64_psr(regs)->pp = mode ? this_cpu(pfm_dcr_pp) : 0;
+	ia64_psr(regs)->pp = mode ? __get_cpu_var(pfm_dcr_pp) : 0;
 }
 #endif
 
@@ -3539,8 +3539,8 @@ pfm_flush_regs (struct task_struct *task
 		ia64_srlz_i();
 
 #ifdef CONFIG_SMP
-		this_cpu(pfm_syst_wide) = 0;
-		this_cpu(pfm_dcr_pp)    = 0;
+		__get_cpu_var(pfm_syst_wide) = 0;
+		__get_cpu_var(pfm_dcr_pp)    = 0;
 #else
 		pfm_tasklist_toggle_pp(0);
 #endif
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29.11839/arch/ia64/kernel/process.c linux-2.5.29.11839.updated/arch/ia64/kernel/process.c
--- linux-2.5.29.11839/arch/ia64/kernel/process.c	Thu May 30 10:00:47 2002
+++ linux-2.5.29.11839.updated/arch/ia64/kernel/process.c	Sat Jul 27 17:35:00 2002
@@ -194,7 +194,7 @@ ia64_save_extra (struct task_struct *tas
 		pfm_save_regs(task);
 
 # ifdef CONFIG_SMP
-	if (this_cpu(pfm_syst_wide))
+	if (__get_cpu_var(pfm_syst_wide))
 		pfm_syst_wide_update_task(task, 0);
 # endif
 #endif
@@ -216,7 +216,7 @@ ia64_load_extra (struct task_struct *tas
 		pfm_load_regs(task);
 
 # ifdef CONFIG_SMP
-	if (this_cpu(pfm_syst_wide)) pfm_syst_wide_update_task(task, 1);
+	if (__get_cpu_var(pfm_syst_wide)) pfm_syst_wide_update_task(task, 1);
 # endif
 #endif
 
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29.11839/arch/ia64/kernel/smp.c linux-2.5.29.11839.updated/arch/ia64/kernel/smp.c
--- linux-2.5.29.11839/arch/ia64/kernel/smp.c	Thu Jul 25 10:13:01 2002
+++ linux-2.5.29.11839.updated/arch/ia64/kernel/smp.c	Sat Jul 27 17:35:00 2002
@@ -99,7 +99,7 @@ void
 handle_IPI (int irq, void *dev_id, struct pt_regs *regs)
 {
 	int this_cpu = smp_processor_id();
-	unsigned long *pending_ipis = &this_cpu(ipi_operation);
+	unsigned long *pending_ipis = &__get_cpu_var(ipi_operation);
 	unsigned long ops;
 
 	/* Count this now; we may make a call that never returns. */
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29.11839/include/asm-generic/percpu.h linux-2.5.29.11839.updated/include/asm-generic/percpu.h
--- linux-2.5.29.11839/include/asm-generic/percpu.h	Mon Apr 15 11:47:44 2002
+++ linux-2.5.29.11839.updated/include/asm-generic/percpu.h	Sat Jul 27 17:35:00 2002
@@ -8,6 +8,6 @@ extern unsigned long __per_cpu_offset[NR
 
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&var, __per_cpu_offset[cpu]))
-#define this_cpu(var) per_cpu(var, smp_processor_id())
+#define __get_cpu_var(var) per_cpu(var, smp_processor_id())
 
 #endif /* _ASM_GENERIC_PERCPU_H_ */
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29.11839/include/asm-ia64/percpu.h linux-2.5.29.11839.updated/include/asm-ia64/percpu.h
--- linux-2.5.29.11839/include/asm-ia64/percpu.h	Tue Apr 23 11:39:38 2002
+++ linux-2.5.29.11839.updated/include/asm-ia64/percpu.h	Sat Jul 27 17:35:00 2002
@@ -17,7 +17,7 @@
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
 #define per_cpu(var, cpu)	(*(__typeof__(&(var))) ((void *) &(var) + __per_cpu_offset[cpu]))
-#define this_cpu(var)		(var)
+#define __get_cpu_var(var)	(var)
 
 #endif /* !__ASSEMBLY__ */
 
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29.11839/include/asm-ia64/processor.h linux-2.5.29.11839.updated/include/asm-ia64/processor.h
--- linux-2.5.29.11839/include/asm-ia64/processor.h	Fri Jun 21 09:41:55 2002
+++ linux-2.5.29.11839.updated/include/asm-ia64/processor.h	Sat Jul 27 17:35:00 2002
@@ -181,7 +181,7 @@ extern struct cpuinfo_ia64 {
  * The "local" data pointer.  It points to the per-CPU data of the currently executing
  * CPU, much like "current" points to the per-task data of the currently executing task.
  */
-#define local_cpu_data		(&this_cpu(cpu_info))
+#define local_cpu_data		(&__get_cpu_var(cpu_info))
 #define cpu_data(cpu)		(&per_cpu(cpu_info, cpu))
 
 extern void identify_cpu (struct cpuinfo_ia64 *);
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29.11839/include/asm-x86_64/percpu.h linux-2.5.29.11839.updated/include/asm-x86_64/percpu.h
--- linux-2.5.29.11839/include/asm-x86_64/percpu.h	Mon Jun 17 23:19:25 2002
+++ linux-2.5.29.11839.updated/include/asm-x86_64/percpu.h	Sat Jul 27 17:35:00 2002
@@ -4,7 +4,7 @@
 #include <asm/pda.h>
 
 /* var is in discarded region: offset to particular copy we want */
-#define this_cpu(var)     (*RELOC_HIDE(&var, read_pda(cpudata_offset)))
+#define __get_cpu_var(var)     (*RELOC_HIDE(&var, read_pda(cpudata_offset)))
 #define per_cpu(var, cpu) (*RELOC_HIDE(&var, per_cpu_pda[cpu]))
 
 void setup_per_cpu_areas(void);
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29.11839/include/linux/percpu.h linux-2.5.29.11839.updated/include/linux/percpu.h
--- linux-2.5.29.11839/include/linux/percpu.h	Mon Jun 24 00:53:24 2002
+++ linux-2.5.29.11839.updated/include/linux/percpu.h	Sat Jul 27 17:35:00 2002
@@ -8,7 +8,9 @@
 #else
 #define __per_cpu_data
 #define per_cpu(var, cpu)			var
-#define this_cpu(var)				var
+#define __get_cpu_var(var)			var
 #endif
 
+#define get_cpu_var(var) ({ preempt_disable(); __get_cpu_var(var); })
+#define put_cpu_var(var) preempt_enable()
 #endif /* __LINUX_PERCPU_H */
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29.11839/include/linux/smp.h linux-2.5.29.11839.updated/include/linux/smp.h
--- linux-2.5.29.11839/include/linux/smp.h	Sat Jul 27 15:24:39 2002
+++ linux-2.5.29.11839.updated/include/linux/smp.h	Sat Jul 27 17:35:30 2002
@@ -96,9 +96,6 @@ static inline void smp_send_reschedule_a
 #define cpu_online_map				1
 #define cpu_online(cpu)				({ cpu; 1; })
 #define num_online_cpus()			1
-#define __per_cpu_data
-#define per_cpu(var, cpu)			var
-#define this_cpu(var)				var
 
 /* Need to know about CPUs going up/down? */
 #define register_cpu_notifier(nb) 0
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.29.11839/kernel/softirq.c linux-2.5.29.11839.updated/kernel/softirq.c
--- linux-2.5.29.11839/kernel/softirq.c	Sat Jul 27 16:07:05 2002
+++ linux-2.5.29.11839.updated/kernel/softirq.c	Sat Jul 27 17:35:00 2002
@@ -159,8 +159,8 @@ void __tasklet_schedule(struct tasklet_s
 	unsigned long flags;
 
 	local_irq_save(flags);
-	t->next = this_cpu(tasklet_vec).list;
-	this_cpu(tasklet_vec).list = t;
+	t->next = __get_cpu_var(tasklet_vec).list;
+	__get_cpu_var(tasklet_vec).list = t;
 	cpu_raise_softirq(smp_processor_id(), TASKLET_SOFTIRQ);
 	local_irq_restore(flags);
 }
@@ -170,8 +170,8 @@ void __tasklet_hi_schedule(struct taskle
 	unsigned long flags;
 
 	local_irq_save(flags);
-	t->next = this_cpu(tasklet_hi_vec).list;
-	this_cpu(tasklet_hi_vec).list = t;
+	t->next = __get_cpu_var(tasklet_hi_vec).list;
+	__get_cpu_var(tasklet_hi_vec).list = t;
 	cpu_raise_softirq(smp_processor_id(), HI_SOFTIRQ);
 	local_irq_restore(flags);
 }
@@ -181,8 +181,8 @@ static void tasklet_action(struct softir
 	struct tasklet_struct *list;
 
 	local_irq_disable();
-	list = this_cpu(tasklet_vec).list;
-	this_cpu(tasklet_vec).list = NULL;
+	list = __get_cpu_var(tasklet_vec).list;
+	__get_cpu_var(tasklet_vec).list = NULL;
 	local_irq_enable();
 
 	while (list) {
@@ -202,8 +202,8 @@ static void tasklet_action(struct softir
 		}
 
 		local_irq_disable();
-		t->next = this_cpu(tasklet_vec).list;
-		this_cpu(tasklet_vec).list = t;
+		t->next = __get_cpu_var(tasklet_vec).list;
+		__get_cpu_var(tasklet_vec).list = t;
 		__cpu_raise_softirq(smp_processor_id(), TASKLET_SOFTIRQ);
 		local_irq_enable();
 	}
@@ -214,8 +214,8 @@ static void tasklet_hi_action(struct sof
 	struct tasklet_struct *list;
 
 	local_irq_disable();
-	list = this_cpu(tasklet_hi_vec).list;
-	this_cpu(tasklet_hi_vec).list = NULL;
+	list = __get_cpu_var(tasklet_hi_vec).list;
+	__get_cpu_var(tasklet_hi_vec).list = NULL;
 	local_irq_enable();
 
 	while (list) {
@@ -235,8 +235,8 @@ static void tasklet_hi_action(struct sof
 		}
 
 		local_irq_disable();
-		t->next = this_cpu(tasklet_hi_vec).list;
-		this_cpu(tasklet_hi_vec).list = t;
+		t->next = __get_cpu_var(tasklet_hi_vec).list;
+		__get_cpu_var(tasklet_hi_vec).list = t;
 		__cpu_raise_softirq(smp_processor_id(), HI_SOFTIRQ);
 		local_irq_enable();
 	}

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25/kernel/ksyms.c working-2.5.25-percpu/kernel/ksyms.c
--- linux-2.5.25/kernel/ksyms.c	Sun Jul  7 02:12:24 2002
+++ working-2.5.25-percpu/kernel/ksyms.c	Fri Jul 12 16:03:47 2002
@@ -50,6 +50,7 @@
 #include <linux/namei.h>
 #include <linux/buffer_head.h>
 #include <linux/root_dev.h>
+#include <linux/percpu.h>
 #include <asm/checksum.h>
 
 #if defined(CONFIG_PROC_FS)
@@ -597,3 +598,6 @@
 
 EXPORT_SYMBOL(tasklist_lock);
 EXPORT_SYMBOL(pidhash);
+#if defined(CONFIG_SMP) && defined(__GENERIC_PER_CPU)
+EXPORT_SYMBOL(__per_cpu_offset);
+#endif

diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.23931/arch/ia64/kernel/perfmon.c linux-2.5.28.23931.updated/arch/ia64/kernel/perfmon.c
--- linux-2.5.28.23931/arch/ia64/kernel/perfmon.c	Thu Jul 25 11:49:11 2002
+++ linux-2.5.28.23931.updated/arch/ia64/kernel/perfmon.c	Thu Jul 25 12:07:54 2002
@@ -369,8 +369,8 @@ static pmu_config_t	pmu_conf; 	/* PMU co
 static pfm_session_t	pfm_sessions;	/* global sessions information */
 static struct proc_dir_entry *perfmon_dir; /* for debug only */
 static pfm_stats_t	pfm_stats;
-int __per_cpu_data pfm_syst_wide;
-static int __per_cpu_data pfm_dcr_pp;
+DEFINE_PER_CPU(int, pfm_syst_wide);
+static DEFINE_PER_CPU(int, pfm_dcr_pp);
 
 /* sysctl() controls */
 static pfm_sysctl_t pfm_sysctl;
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.23931/arch/ia64/kernel/setup.c linux-2.5.28.23931.updated/arch/ia64/kernel/setup.c
--- linux-2.5.28.23931/arch/ia64/kernel/setup.c	Thu May 30 10:00:47 2002
+++ linux-2.5.28.23931.updated/arch/ia64/kernel/setup.c	Thu Jul 25 12:08:02 2002
@@ -58,7 +58,7 @@ extern char _end;
 unsigned long __per_cpu_offset[NR_CPUS];
 #endif
 
-struct cpuinfo_ia64 cpu_info __per_cpu_data;
+DECLARE_PER_CPU(struct cpuinfo_ia64, cpu_info);
 
 unsigned long ia64_phys_stacked_size_p8;
 unsigned long ia64_cycles_per_usec;
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.23931/arch/ia64/kernel/smp.c linux-2.5.28.23931.updated/arch/ia64/kernel/smp.c
--- linux-2.5.28.23931/arch/ia64/kernel/smp.c	Thu Jul 25 11:49:11 2002
+++ linux-2.5.28.23931.updated/arch/ia64/kernel/smp.c	Thu Jul 25 12:08:08 2002
@@ -80,7 +80,7 @@ static volatile struct call_data_struct 
 #define IPI_CPU_STOP		1
 
 /* This needs to be cacheline aligned because it is written to by *other* CPUs.  */
-static __u64 ipi_operation __per_cpu_data ____cacheline_aligned;
+static DECLARE_PER_CPU(__u64, ipi_operation) ____cacheline_aligned;
 
 static void
 stop_this_cpu (void)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.23931/include/asm-generic/percpu.h linux-2.5.28.23931.updated/include/asm-generic/percpu.h
--- linux-2.5.28.23931/include/asm-generic/percpu.h	Thu Jul 25 11:49:11 2002
+++ linux-2.5.28.23931.updated/include/asm-generic/percpu.h	Thu Jul 25 12:01:29 2002
@@ -1,13 +1,34 @@
 #ifndef _ASM_GENERIC_PERCPU_H_
 #define _ASM_GENERIC_PERCPU_H_
+#include <linux/compiler.h>
 
 #define __GENERIC_PER_CPU
-#include <linux/compiler.h>
+#ifdef CONFIG_SMP
 
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
+/* Separate out the type, so (int[3], foo) works. */
+#ifndef MODULE
+#define DEFINE_PER_CPU(type, name) \
+    __attribute__((__section__(".percpu"))) __typeof__(type) name##__per_cpu
+#endif
+
 /* var is in discarded region: offset to particular copy we want */
-#define per_cpu(var, cpu) (*RELOC_HIDE(&var, __per_cpu_offset[cpu]))
+#define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
+
+#else /* ! SMP */
+
+/* Can't define per-cpu variables in modules.  Sorry --RR */
+#ifndef MODULE
+#define DEFINE_PER_CPU(type, name) \
+    __typeof__(type) name##__per_cpu
+#endif
+
+#define per_cpu(var, cpu)			var##__per_cpu
+#define __get_cpu_var(var)			var##__per_cpu
+#endif
+
+#define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
 
 #endif /* _ASM_GENERIC_PERCPU_H_ */
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.23931/include/asm-ia64/percpu.h linux-2.5.28.23931.updated/include/asm-ia64/percpu.h
--- linux-2.5.28.23931/include/asm-ia64/percpu.h	Thu Jul 25 11:49:10 2002
+++ linux-2.5.28.23931.updated/include/asm-ia64/percpu.h	Thu Jul 25 12:04:06 2002
@@ -8,7 +8,7 @@
 
 #ifdef __ASSEMBLY__
 
-#define THIS_CPU(var)	(var)	/* use this to mark accesses to per-CPU variables... */
+#define THIS_CPU(var)	(var##__per_cpu)	/* use this to mark accesses to per-CPU variables... */
 
 #else /* !__ASSEMBLY__ */
 
@@ -16,8 +16,14 @@
 
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
-#define per_cpu(var, cpu)	(*(__typeof__(&(var))) ((void *) &(var) + __per_cpu_offset[cpu]))
-#define __get_cpu_var(var)	(var)
+#ifndef MODULE
+#define DEFINE_PER_CPU(type, name) \
+    __attribute__((__section__(".data.percpu"))) __typeof__(type) name##__per_cpu
+#endif
+#define DECLARE_PER_CPU(type, name) extern __typeof__(type) name##__per_cpu
+
+#define per_cpu(var, cpu) (*RELOC_HIDE(&var##__per_cpu, __per_cpu_offset[cpu]))
+#define __get_cpu_var(var)	(var##__per_cpu)
 
 #endif /* !__ASSEMBLY__ */
 
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.23931/include/asm-ia64/processor.h linux-2.5.28.23931.updated/include/asm-ia64/processor.h
--- linux-2.5.28.23931/include/asm-ia64/processor.h	Thu Jul 25 11:49:10 2002
+++ linux-2.5.28.23931.updated/include/asm-ia64/processor.h	Thu Jul 25 12:06:55 2002
@@ -134,7 +134,7 @@ struct ia64_psr {
  * CPU type, hardware bug flags, and per-CPU state.  Frequently used
  * state comes earlier:
  */
-extern struct cpuinfo_ia64 {
+struct cpuinfo_ia64 {
 	/* irq_stat must be 64-bit aligned */
 	union {
 		struct {
@@ -175,7 +175,9 @@ extern struct cpuinfo_ia64 {
 	__u64 prof_counter;
 	__u64 prof_multiplier;
 #endif
-} cpu_info __per_cpu_data;
+};
+
+DECLARE_PER_CPU(struct cpuinfo_ia64, cpu_info);
 
 /*
  * The "local" data pointer.  It points to the per-CPU data of the currently executing
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.23931/include/linux/percpu.h linux-2.5.28.23931.updated/include/linux/percpu.h
--- linux-2.5.28.23931/include/linux/percpu.h	Thu Jul 25 11:49:10 2002
+++ linux-2.5.28.23931.updated/include/linux/percpu.h	Thu Jul 25 11:49:28 2002
@@ -1,16 +1,9 @@
 #ifndef __LINUX_PERCPU_H
 #define __LINUX_PERCPU_H
-#include <linux/config.h>
-
-#ifdef CONFIG_SMP
-#define __per_cpu_data	__attribute__((section(".data.percpu")))
+#include <linux/spinlock.h> /* For preempt_disable() */
 #include <asm/percpu.h>
-#else
-#define __per_cpu_data
-#define per_cpu(var, cpu)			var
-#define __get_cpu_var(var)			var
-#endif
 
 #define get_cpu_var(var) ({ preempt_disable(); __get_cpu_var(var); })
 #define put_cpu_var(var) preempt_enable()
+
 #endif /* __LINUX_PERCPU_H */
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.28.23931/kernel/softirq.c linux-2.5.28.23931.updated/kernel/softirq.c
--- linux-2.5.28.23931/kernel/softirq.c	Thu Jul 25 11:49:11 2002
+++ linux-2.5.28.23931.updated/kernel/softirq.c	Thu Jul 25 12:05:55 2002
@@ -150,8 +150,8 @@ struct tasklet_head
 
 /* Some compilers disobey section attribute on statics when not
    initialized -- RR */
-static struct tasklet_head tasklet_vec __per_cpu_data = { NULL };
-static struct tasklet_head tasklet_hi_vec __per_cpu_data = { NULL };
+static DEFINE_PER_CPU(struct tasklet_head, tasklet_vec) = { NULL };
+static DEFINE_PER_CPU(struct tasklet_head, tasklet_hi_vec) = { NULL };
 
 void __tasklet_schedule(struct tasklet_struct *t)
 {
