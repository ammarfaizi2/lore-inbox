Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318009AbSGREUJ>; Thu, 18 Jul 2002 00:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318005AbSGRETC>; Thu, 18 Jul 2002 00:19:02 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:6834 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318007AbSGRESn>;
	Thu, 18 Jul 2002 00:18:43 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] per-cpu patch 2/3
Date: Thu, 18 Jul 2002 13:48:10 +1000
Message-Id: <20020718042221.36D114479@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Given the ongoing races with smp_processor_id() and preempt, this
makes sense to me.  this_cpu() was too generic a name anyway.

Name: get_cpu_var patch
Author: Rusty Russell
Status: Cleanup

D: This makes introduces get_cpu_var() which gets a per-cpu variable
D: and disables preemption, and renames the (unsafe under preemption)
D: "this_cpu()" macro to __get_cpu_var().  It also deletes the
D: redundant definitions in linux/smp.h.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25/include/linux/percpu.h working-2.5.25-getcpu/include/linux/percpu.h
--- linux-2.5.25/include/linux/percpu.h	Mon Jun 24 00:53:24 2002
+++ working-2.5.25-getcpu/include/linux/percpu.h	Thu Jul 11 13:32:30 2002
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
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25/include/linux/smp.h working-2.5.25-getcpu/include/linux/smp.h
--- linux-2.5.25/include/linux/smp.h	Fri Jun 21 09:41:55 2002
+++ working-2.5.25-getcpu/include/linux/smp.h	Thu Jul 11 13:32:07 2002
@@ -89,10 +89,6 @@
 #define cpu_online_map				1
 #define cpu_online(cpu)				1
 #define num_online_cpus()			1
-#define __per_cpu_data
-#define per_cpu(var, cpu)			var
-#define this_cpu(var)				var
-
 #endif /* !SMP */
 
 #define get_cpu()	({ preempt_disable(); smp_processor_id(); })
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25/include/asm-ia64/percpu.h working-2.5.25-getcpu/include/asm-ia64/percpu.h
--- linux-2.5.25/include/asm-ia64/percpu.h	Tue Apr 23 11:39:38 2002
+++ working-2.5.25-getcpu/include/asm-ia64/percpu.h	Thu Jul 11 13:34:05 2002
@@ -17,7 +17,7 @@
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
 #define per_cpu(var, cpu)	(*(__typeof__(&(var))) ((void *) &(var) + __per_cpu_offset[cpu]))
-#define this_cpu(var)		(var)
+#define __get_cpu_var(var)	(var)
 
 #endif /* !__ASSEMBLY__ */
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25/include/asm-ia64/processor.h working-2.5.25-getcpu/include/asm-ia64/processor.h
--- linux-2.5.25/include/asm-ia64/processor.h	Fri Jun 21 09:41:55 2002
+++ working-2.5.25-getcpu/include/asm-ia64/processor.h	Thu Jul 11 13:33:26 2002
@@ -181,7 +181,7 @@
  * The "local" data pointer.  It points to the per-CPU data of the currently executing
  * CPU, much like "current" points to the per-task data of the currently executing task.
  */
-#define local_cpu_data		(&this_cpu(cpu_info))
+#define local_cpu_data		(&__get_cpu_var(cpu_info))
 #define cpu_data(cpu)		(&per_cpu(cpu_info, cpu))
 
 extern void identify_cpu (struct cpuinfo_ia64 *);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25/include/asm-x86_64/percpu.h working-2.5.25-getcpu/include/asm-x86_64/percpu.h
--- linux-2.5.25/include/asm-x86_64/percpu.h	Mon Jun 17 23:19:25 2002
+++ working-2.5.25-getcpu/include/asm-x86_64/percpu.h	Thu Jul 11 13:34:17 2002
@@ -4,7 +4,7 @@
 #include <asm/pda.h>
 
 /* var is in discarded region: offset to particular copy we want */
-#define this_cpu(var)     (*RELOC_HIDE(&var, read_pda(cpudata_offset)))
+#define __get_cpu_var(var)     (*RELOC_HIDE(&var, read_pda(cpudata_offset)))
 #define per_cpu(var, cpu) (*RELOC_HIDE(&var, per_cpu_pda[cpu]))
 
 void setup_per_cpu_areas(void);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25/arch/ia64/kernel/perfmon.c working-2.5.25-getcpu/arch/ia64/kernel/perfmon.c
--- linux-2.5.25/arch/ia64/kernel/perfmon.c	Thu Jun 20 01:28:47 2002
+++ working-2.5.25-getcpu/arch/ia64/kernel/perfmon.c	Thu Jul 11 13:35:08 2002
@@ -1762,7 +1762,7 @@
 		ia64_srlz_i();
 
 #ifdef CONFIG_SMP
-		this_cpu(pfm_dcr_pp)  = 0;
+		__get_cpu_var(pfm_dcr_pp)  = 0;
 #else
 		pfm_tasklist_toggle_pp(0);
 #endif
@@ -2163,7 +2163,7 @@
 	if (ctx->ctx_fl_system) {
 		
 #ifdef CONFIG_SMP
-		this_cpu(pfm_dcr_pp)  = 1;
+		__get_cpu_var(pfm_dcr_pp)  = 1;
 #else
 		pfm_tasklist_toggle_pp(1);
 #endif
@@ -2218,8 +2218,8 @@
 		ia64_srlz_i();
 
 #ifdef CONFIG_SMP
-		this_cpu(pfm_syst_wide) = 1;
-		this_cpu(pfm_dcr_pp)    = 0;
+		__get_cpu_var(pfm_syst_wide) = 1;
+		__get_cpu_var(pfm_dcr_pp)    = 0;
 #endif
 	} else {
 		/*
@@ -2973,9 +2973,9 @@
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
@@ -3045,7 +3045,7 @@
 	/*
 	 * propagate the value of the dcr_pp bit to the psr
 	 */
-	ia64_psr(regs)->pp = mode ? this_cpu(pfm_dcr_pp) : 0;
+	ia64_psr(regs)->pp = mode ? __get_cpu_var(pfm_dcr_pp) : 0;
 }
 #endif
 
@@ -3539,8 +3539,8 @@
 		ia64_srlz_i();
 
 #ifdef CONFIG_SMP
-		this_cpu(pfm_syst_wide) = 0;
-		this_cpu(pfm_dcr_pp)    = 0;
+		__get_cpu_var(pfm_syst_wide) = 0;
+		__get_cpu_var(pfm_dcr_pp)    = 0;
 #else
 		pfm_tasklist_toggle_pp(0);
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25/arch/ia64/kernel/process.c working-2.5.25-getcpu/arch/ia64/kernel/process.c
--- linux-2.5.25/arch/ia64/kernel/process.c	Thu May 30 10:00:47 2002
+++ working-2.5.25-getcpu/arch/ia64/kernel/process.c	Thu Jul 11 13:35:21 2002
@@ -194,7 +194,7 @@
 		pfm_save_regs(task);
 
 # ifdef CONFIG_SMP
-	if (this_cpu(pfm_syst_wide))
+	if (__get_cpu_var(pfm_syst_wide))
 		pfm_syst_wide_update_task(task, 0);
 # endif
 #endif
@@ -216,7 +216,7 @@
 		pfm_load_regs(task);
 
 # ifdef CONFIG_SMP
-	if (this_cpu(pfm_syst_wide)) pfm_syst_wide_update_task(task, 1);
+	if (__get_cpu_var(pfm_syst_wide)) pfm_syst_wide_update_task(task, 1);
 # endif
 #endif
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25/arch/ia64/kernel/smp.c working-2.5.25-getcpu/arch/ia64/kernel/smp.c
--- linux-2.5.25/arch/ia64/kernel/smp.c	Thu Jun 20 01:28:47 2002
+++ working-2.5.25-getcpu/arch/ia64/kernel/smp.c	Thu Jul 11 13:35:39 2002
@@ -99,7 +99,7 @@
 handle_IPI (int irq, void *dev_id, struct pt_regs *regs)
 {
 	int this_cpu = smp_processor_id();
-	unsigned long *pending_ipis = &this_cpu(ipi_operation);
+	unsigned long *pending_ipis = &__get_cpu_var(ipi_operation);
 	unsigned long ops;
 
 	/* Count this now; we may make a call that never returns. */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25/include/asm-generic/percpu.h working-2.5.25-getcpu/include/asm-generic/percpu.h
--- linux-2.5.25/include/asm-generic/percpu.h	Mon Apr 15 11:47:44 2002
+++ working-2.5.25-getcpu/include/asm-generic/percpu.h	Thu Jul 11 13:32:42 2002
@@ -8,6 +8,6 @@
 
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*RELOC_HIDE(&var, __per_cpu_offset[cpu]))
-#define this_cpu(var) per_cpu(var, smp_processor_id())
+#define __get_cpu_var(var) per_cpu(var, smp_processor_id())
 
 #endif /* _ASM_GENERIC_PERCPU_H_ */
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.25/kernel/softirq.c working-2.5.25-getcpu/kernel/softirq.c
--- linux-2.5.25/kernel/softirq.c	Sun Jul  7 02:12:24 2002
+++ working-2.5.25-getcpu/kernel/softirq.c	Thu Jul 11 13:31:26 2002
@@ -162,8 +162,8 @@
 	unsigned long flags;
 
 	local_irq_save(flags);
-	t->next = this_cpu(tasklet_vec).list;
-	this_cpu(tasklet_vec).list = t;
+	t->next = __get_cpu_var(tasklet_vec).list;
+	__get_cpu_var(tasklet_vec).list = t;
 	cpu_raise_softirq(smp_processor_id(), TASKLET_SOFTIRQ);
 	local_irq_restore(flags);
 }
@@ -173,8 +173,8 @@
 	unsigned long flags;
 
 	local_irq_save(flags);
-	t->next = this_cpu(tasklet_hi_vec).list;
-	this_cpu(tasklet_hi_vec).list = t;
+	t->next = __get_cpu_var(tasklet_hi_vec).list;
+	__get_cpu_var(tasklet_hi_vec).list = t;
 	cpu_raise_softirq(smp_processor_id(), HI_SOFTIRQ);
 	local_irq_restore(flags);
 }
@@ -184,8 +184,8 @@
 	struct tasklet_struct *list;
 
 	local_irq_disable();
-	list = this_cpu(tasklet_vec).list;
-	this_cpu(tasklet_vec).list = NULL;
+	list = __get_cpu_var(tasklet_vec).list;
+	__get_cpu_var(tasklet_vec).list = NULL;
 	local_irq_enable();
 
 	while (list) {
@@ -205,8 +205,8 @@
 		}
 
 		local_irq_disable();
-		t->next = this_cpu(tasklet_vec).list;
-		this_cpu(tasklet_vec).list = t;
+		t->next = __get_cpu_var(tasklet_vec).list;
+		__get_cpu_var(tasklet_vec).list = t;
 		__cpu_raise_softirq(smp_processor_id(), TASKLET_SOFTIRQ);
 		local_irq_enable();
 	}
@@ -217,8 +217,8 @@
 	struct tasklet_struct *list;
 
 	local_irq_disable();
-	list = this_cpu(tasklet_hi_vec).list;
-	this_cpu(tasklet_hi_vec).list = NULL;
+	list = __get_cpu_var(tasklet_hi_vec).list;
+	__get_cpu_var(tasklet_hi_vec).list = NULL;
 	local_irq_enable();
 
 	while (list) {
@@ -238,8 +238,8 @@
 		}
 
 		local_irq_disable();
-		t->next = this_cpu(tasklet_hi_vec).list;
-		this_cpu(tasklet_hi_vec).list = t;
+		t->next = __get_cpu_var(tasklet_hi_vec).list;
+		__get_cpu_var(tasklet_hi_vec).list = t;
 		__cpu_raise_softirq(smp_processor_id(), HI_SOFTIRQ);
 		local_irq_enable();
 	}

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
