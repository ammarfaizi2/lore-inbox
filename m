Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbUJYBzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbUJYBzp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 21:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUJYBzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 21:55:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:16845 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261659AbUJYBws (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 21:52:48 -0400
Subject: [PATCH] ppc64: cleanup/split SMP code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 11:50:30 +1000
Message-Id: <1098669030.30012.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch depends at least on two previously posted ones (and not yet merged).

[PATCH] ppc64: Fix pSeries secondary CPU setup
[PATCH] ppc64: Rewrite the openpic driver

Splits arch/ppc64/kernel/smp.c into 3 different files, smp.c, pSeries_smp.c and
iSeries_smp.c, thus removing most of the #define mess in those files and making
it easier to add a new platform.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc64/kernel/pSeries_smp.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/ppc64/kernel/pSeries_smp.c	2004-10-25 11:29:38.804091696 +1000
@@ -0,0 +1,393 @@
+/*
+ * SMP support for pSeries machines.
+ *
+ * Dave Engebretsen, Peter Bergner, and
+ * Mike Corrigan {engebret|bergner|mikec}@us.ibm.com
+ *
+ * Plus various changes from other IBM teams...
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#undef DEBUG
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/cache.h>
+#include <linux/err.h>
+#include <linux/sysdev.h>
+#include <linux/cpu.h>
+
+#include <asm/ptrace.h>
+#include <asm/atomic.h>
+#include <asm/irq.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/smp.h>
+#include <asm/naca.h>
+#include <asm/paca.h>
+#include <asm/time.h>
+#include <asm/ppcdebug.h>
+#include <asm/machdep.h>
+#include <asm/xics.h>
+#include <asm/cputable.h>
+#include <asm/system.h>
+#include <asm/rtas.h>
+#include <asm/plpar_wrappers.h>
+
+#include "mpic.h"
+
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+extern void pseries_secondary_smp_init(unsigned long); 
+
+static void vpa_init(int cpu)
+{
+	unsigned long flags, pcpu = get_hard_smp_processor_id(cpu);
+
+	/* Register the Virtual Processor Area (VPA) */
+	flags = 1UL << (63 - 18);
+	register_vpa(flags, pcpu, __pa((unsigned long)&(paca[cpu].lppaca)));
+}
+
+
+/* Get state of physical CPU.
+ * Return codes:
+ *	0	- The processor is in the RTAS stopped state
+ *	1	- stop-self is in progress
+ *	2	- The processor is not in the RTAS stopped state
+ *	-1	- Hardware Error
+ *	-2	- Hardware Busy, Try again later.
+ */
+static int query_cpu_stopped(unsigned int pcpu)
+{
+	int cpu_status;
+	int status, qcss_tok;
+
+	qcss_tok = rtas_token("query-cpu-stopped-state");
+	if (qcss_tok == RTAS_UNKNOWN_SERVICE)
+		return -1;
+	status = rtas_call(qcss_tok, 1, 2, &cpu_status, pcpu);
+	if (status != 0) {
+		printk(KERN_ERR
+		       "RTAS query-cpu-stopped-state failed: %i\n", status);
+		return status;
+	}
+
+	return cpu_status;
+}
+
+
+#ifdef CONFIG_HOTPLUG_CPU
+
+int __cpu_disable(void)
+{
+	/* FIXME: go put this in a header somewhere */
+	extern void xics_migrate_irqs_away(void);
+
+	systemcfg->processorCount--;
+
+	/*fix boot_cpuid here*/
+	if (smp_processor_id() == boot_cpuid)
+		boot_cpuid = any_online_cpu(cpu_online_map);
+
+	/* FIXME: abstract this to not be platform specific later on */
+	xics_migrate_irqs_away();
+	return 0;
+}
+
+void __cpu_die(unsigned int cpu)
+{
+	int tries;
+	int cpu_status;
+	unsigned int pcpu = get_hard_smp_processor_id(cpu);
+
+	for (tries = 0; tries < 25; tries++) {
+		cpu_status = query_cpu_stopped(pcpu);
+		if (cpu_status == 0 || cpu_status == -1)
+			break;
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ/5);
+	}
+	if (cpu_status != 0) {
+		printk("Querying DEAD? cpu %i (%i) shows %i\n",
+		       cpu, pcpu, cpu_status);
+	}
+
+	/* Isolation and deallocation are definatly done by
+	 * drslot_chrp_cpu.  If they were not they would be
+	 * done here.  Change isolate state to Isolate and
+	 * change allocation-state to Unusable.
+	 */
+	paca[cpu].cpu_start = 0;
+}
+
+/* Search all cpu device nodes for an offline logical cpu.  If a
+ * device node has a "ibm,my-drc-index" property (meaning this is an
+ * LPAR), paranoid-check whether we own the cpu.  For each "thread"
+ * of a cpu, if it is offline and has the same hw index as before,
+ * grab that in preference.
+ */
+static unsigned int find_physical_cpu_to_start(unsigned int old_hwindex)
+{
+	struct device_node *np = NULL;
+	unsigned int best = -1U;
+
+	while ((np = of_find_node_by_type(np, "cpu"))) {
+		int nr_threads, len;
+		u32 *index = (u32 *)get_property(np, "ibm,my-drc-index", NULL);
+		u32 *tid = (u32 *)
+			get_property(np, "ibm,ppc-interrupt-server#s", &len);
+
+		if (!tid)
+			tid = (u32 *)get_property(np, "reg", &len);
+
+		if (!tid)
+			continue;
+
+		/* If there is a drc-index, make sure that we own
+		 * the cpu.
+		 */
+		if (index) {
+			int state;
+			int rc = rtas_get_sensor(9003, *index, &state);
+			if (rc != 0 || state != 1)
+				continue;
+		}
+
+		nr_threads = len / sizeof(u32);
+
+		while (nr_threads--) {
+			if (0 == query_cpu_stopped(tid[nr_threads])) {
+				best = tid[nr_threads];
+				if (best == old_hwindex)
+					goto out;
+			}
+		}
+	}
+out:
+	of_node_put(np);
+	return best;
+}
+
+/**
+ * smp_startup_cpu() - start the given cpu
+ *
+ * At boot time, there is nothing to do.  At run-time, call RTAS with
+ * the appropriate start location, if the cpu is in the RTAS stopped
+ * state.
+ *
+ * Returns:
+ *	0	- failure
+ *	1	- success
+ */
+static inline int __devinit smp_startup_cpu(unsigned int lcpu)
+{
+	int status;
+	unsigned long start_here = __pa((u32)*((unsigned long *)
+					       pseries_secondary_smp_init));
+	unsigned int pcpu;
+
+	/* At boot time the cpus are already spinning in hold
+	 * loops, so nothing to do. */
+ 	if (system_state < SYSTEM_RUNNING)
+		return 1;
+
+	pcpu = find_physical_cpu_to_start(get_hard_smp_processor_id(lcpu));
+	if (pcpu == -1U) {
+		printk(KERN_INFO "No more cpus available, failing\n");
+		return 0;
+	}
+
+	/* Fixup atomic count: it exited inside IRQ handler. */
+	paca[lcpu].__current->thread_info->preempt_count	= 0;
+
+	/* At boot this is done in prom.c. */
+	paca[lcpu].hw_cpu_id = pcpu;
+
+	status = rtas_call(rtas_token("start-cpu"), 3, 1, NULL,
+			   pcpu, start_here, lcpu);
+	if (status != 0) {
+		printk(KERN_ERR "start-cpu failed: %i\n", status);
+		return 0;
+	}
+	return 1;
+}
+#else /* ... CONFIG_HOTPLUG_CPU */
+static inline int __devinit smp_startup_cpu(unsigned int lcpu)
+{
+	return 1;
+}
+#endif /* CONFIG_HOTPLUG_CPU */
+
+static inline void smp_xics_do_message(int cpu, int msg)
+{
+	set_bit(msg, &xics_ipi_message[cpu].value);
+	mb();
+	xics_cause_IPI(cpu);
+}
+
+static void smp_xics_message_pass(int target, int msg)
+{
+	unsigned int i;
+
+	if (target < NR_CPUS) {
+		smp_xics_do_message(target, msg);
+	} else {
+		for_each_online_cpu(i) {
+			if (target == MSG_ALL_BUT_SELF
+			    && i == smp_processor_id())
+				continue;
+			smp_xics_do_message(i, msg);
+		}
+	}
+}
+
+extern void xics_request_IPIs(void);
+
+static int __init smp_xics_probe(void)
+{
+	xics_request_IPIs();
+
+	return cpus_weight(cpu_possible_map);
+}
+
+static void __devinit smp_xics_setup_cpu(int cpu)
+{
+	if (cpu != boot_cpuid)
+		xics_setup_cpu();
+}
+
+static spinlock_t timebase_lock = SPIN_LOCK_UNLOCKED;
+static unsigned long timebase = 0;
+
+static void __devinit pSeries_give_timebase(void)
+{
+	spin_lock(&timebase_lock);
+	rtas_call(rtas_token("freeze-time-base"), 0, 1, NULL);
+	timebase = get_tb();
+	spin_unlock(&timebase_lock);
+
+	while (timebase)
+		barrier();
+	rtas_call(rtas_token("thaw-time-base"), 0, 1, NULL);
+}
+
+static void __devinit pSeries_take_timebase(void)
+{
+	while (!timebase)
+		barrier();
+	spin_lock(&timebase_lock);
+	set_tb(timebase >> 32, timebase & 0xffffffff);
+	timebase = 0;
+	spin_unlock(&timebase_lock);
+}
+
+static void __devinit pSeries_late_setup_cpu(int cpu)
+{
+	extern unsigned int default_distrib_server;
+
+	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
+		vpa_init(cpu); 
+	}
+
+#ifdef CONFIG_IRQ_ALL_CPUS
+	/* Put the calling processor into the GIQ.  This is really only
+	 * necessary from a secondary thread as the OF start-cpu interface
+	 * performs this function for us on primary threads.
+	 */
+	/* TODO: 9005 is #defined in rtas-proc.c -- move to a header */
+	rtas_set_indicator(9005, default_distrib_server, 1);
+#endif
+}
+
+
+void __devinit smp_pSeries_kick_cpu(int nr)
+{
+	BUG_ON(nr < 0 || nr >= NR_CPUS);
+
+	if (!smp_startup_cpu(nr))
+		return;
+
+	/*
+	 * The processor is currently spinning, waiting for the
+	 * cpu_start field to become non-zero After we set cpu_start,
+	 * the processor will continue on to secondary_start
+	 */
+	paca[nr].cpu_start = 1;
+}
+
+static struct smp_ops_t pSeries_mpic_smp_ops = {
+	.message_pass	= smp_mpic_message_pass,
+	.probe		= smp_mpic_probe,
+	.kick_cpu	= smp_pSeries_kick_cpu,
+	.setup_cpu	= smp_mpic_setup_cpu,
+	.late_setup_cpu	= pSeries_late_setup_cpu,
+};
+
+static struct smp_ops_t pSeries_xics_smp_ops = {
+	.message_pass	= smp_xics_message_pass,
+	.probe		= smp_xics_probe,
+	.kick_cpu	= smp_pSeries_kick_cpu,
+	.setup_cpu	= smp_xics_setup_cpu,
+	.late_setup_cpu	= pSeries_late_setup_cpu,
+};
+
+/* This is called very early */
+void __init smp_init_pSeries(void)
+{
+	int ret, i;
+
+	DBG(" -> smp_init_pSeries()\n");
+
+	if (naca->interrupt_controller == IC_OPEN_PIC)
+		smp_ops = &pSeries_mpic_smp_ops;
+	else
+		smp_ops = &pSeries_xics_smp_ops;
+
+	/* Start secondary threads on SMT systems; primary threads
+	 * are already in the running state.
+	 */
+	for_each_present_cpu(i) {
+		if (query_cpu_stopped(get_hard_smp_processor_id(i)) == 0) {
+			printk("%16.16x : starting thread\n", i);
+			DBG("%16.16x : starting thread\n", i);
+			rtas_call(rtas_token("start-cpu"), 3, 1, &ret,
+				  get_hard_smp_processor_id(i),
+				  __pa((u32)*((unsigned long *)
+					      pseries_secondary_smp_init)),
+				  i);
+		}
+	}
+
+	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR)
+		vpa_init(boot_cpuid);
+
+	/* Non-lpar has additional take/give timebase */
+	if (systemcfg->platform == PLATFORM_PSERIES) {
+		smp_ops->give_timebase = pSeries_give_timebase;
+		smp_ops->take_timebase = pSeries_take_timebase;
+	}
+
+
+	DBG(" <- smp_init_pSeries()\n");
+}
+
Index: linux-work/arch/ppc64/kernel/smp.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/smp.c	2004-10-25 10:24:50.000000000 +1000
+++ linux-work/arch/ppc64/kernel/smp.c	2004-10-25 11:29:38.849084856 +1000
@@ -43,19 +43,14 @@
 #include <asm/smp.h>
 #include <asm/naca.h>
 #include <asm/paca.h>
-#include <asm/iSeries/LparData.h>
-#include <asm/iSeries/HvCall.h>
-#include <asm/iSeries/HvCallCfg.h>
 #include <asm/time.h>
 #include <asm/ppcdebug.h>
 #include <asm/machdep.h>
-#include <asm/xics.h>
 #include <asm/cputable.h>
 #include <asm/system.h>
+#include <asm/abs_addr.h>
 
 #include "mpic.h"
-#include <asm/rtas.h>
-#include <asm/plpar_wrappers.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -89,110 +84,6 @@
 /* Low level assembly function used to backup CPU 0 state */
 extern void __save_cpu_setup(void);
 
-extern void pseries_secondary_smp_init(unsigned long); 
-
-#ifdef CONFIG_PPC_ISERIES
-static unsigned long iSeries_smp_message[NR_CPUS];
-
-void iSeries_smp_message_recv( struct pt_regs * regs )
-{
-	int cpu = smp_processor_id();
-	int msg;
-
-	if ( num_online_cpus() < 2 )
-		return;
-
-	for ( msg = 0; msg < 4; ++msg )
-		if ( test_and_clear_bit( msg, &iSeries_smp_message[cpu] ) )
-			smp_message_recv( msg, regs );
-}
-
-static inline void smp_iSeries_do_message(int cpu, int msg)
-{
-	set_bit(msg, &iSeries_smp_message[cpu]);
-	HvCall_sendIPI(&(paca[cpu]));
-}
-
-static void smp_iSeries_message_pass(int target, int msg)
-{
-	int i;
-
-	if (target < NR_CPUS)
-		smp_iSeries_do_message(target, msg);
-	else {
-		for_each_online_cpu(i) {
-			if (target == MSG_ALL_BUT_SELF
-			    && i == smp_processor_id())
-				continue;
-			smp_iSeries_do_message(i, msg);
-		}
-	}
-}
-
-static int smp_iSeries_numProcs(void)
-{
-	unsigned np, i;
-
-	np = 0;
-        for (i=0; i < NR_CPUS; ++i) {
-                if (paca[i].lppaca.xDynProcStatus < 2) {
-			cpu_set(i, cpu_possible_map);
-			cpu_set(i, cpu_present_map);
-                        ++np;
-                }
-        }
-	return np;
-}
-
-static int smp_iSeries_probe(void)
-{
-	unsigned i;
-	unsigned np = 0;
-
-	for (i=0; i < NR_CPUS; ++i) {
-		if (paca[i].lppaca.xDynProcStatus < 2) {
-			/*paca[i].active = 1;*/
-			++np;
-		}
-	}
-
-	return np;
-}
-
-static void smp_iSeries_kick_cpu(int nr)
-{
-	BUG_ON(nr < 0 || nr >= NR_CPUS);
-
-	/* Verify that our partition has a processor nr */
-	if (paca[nr].lppaca.xDynProcStatus >= 2)
-		return;
-
-	/* The processor is currently spinning, waiting
-	 * for the cpu_start field to become non-zero
-	 * After we set cpu_start, the processor will
-	 * continue on to secondary_start in iSeries_head.S
-	 */
-	paca[nr].cpu_start = 1;
-}
-
-static void __devinit smp_iSeries_setup_cpu(int nr)
-{
-}
-
-static struct smp_ops_t iSeries_smp_ops = {
-	.message_pass = smp_iSeries_message_pass,
-	.probe        = smp_iSeries_probe,
-	.kick_cpu     = smp_iSeries_kick_cpu,
-	.setup_cpu    = smp_iSeries_setup_cpu,
-};
-
-/* This is called very early. */
-void __init smp_init_iSeries(void)
-{
-	smp_ops = &iSeries_smp_ops;
-	systemcfg->processorCount	= smp_iSeries_numProcs();
-}
-#endif
 
 #ifdef CONFIG_PPC_MULTIPLATFORM
 void smp_mpic_message_pass(int target, int msg)
@@ -238,213 +129,20 @@
 	mpic_setup_this_cpu();
 }
 
-#endif /* CONFIG_PPC_MULTIPLATFORM */
-
-#ifdef CONFIG_PPC_PSERIES
-
-/* Get state of physical CPU.
- * Return codes:
- *	0	- The processor is in the RTAS stopped state
- *	1	- stop-self is in progress
- *	2	- The processor is not in the RTAS stopped state
- *	-1	- Hardware Error
- *	-2	- Hardware Busy, Try again later.
- */
-int query_cpu_stopped(unsigned int pcpu)
-{
-	int cpu_status;
-	int status, qcss_tok;
-
-	DBG(" -> query_cpu_stopped(%d)\n", pcpu);
-	qcss_tok = rtas_token("query-cpu-stopped-state");
-	if (qcss_tok == RTAS_UNKNOWN_SERVICE)
-		return -1;
-	status = rtas_call(qcss_tok, 1, 2, &cpu_status, pcpu);
-	if (status != 0) {
-		printk(KERN_ERR
-		       "RTAS query-cpu-stopped-state failed: %i\n", status);
-		return status;
-	}
-
-	DBG(" <- query_cpu_stopped(), status: %d\n", cpu_status);
-
-	return cpu_status;
-}
-
-#ifdef CONFIG_HOTPLUG_CPU
-
-int __cpu_disable(void)
-{
-	/* FIXME: go put this in a header somewhere */
-	extern void xics_migrate_irqs_away(void);
-
-	systemcfg->processorCount--;
-
-	/*fix boot_cpuid here*/
-	if (smp_processor_id() == boot_cpuid)
-		boot_cpuid = any_online_cpu(cpu_online_map);
-
-	/* FIXME: abstract this to not be platform specific later on */
-	xics_migrate_irqs_away();
-	return 0;
-}
-
-void __cpu_die(unsigned int cpu)
-{
-	int tries;
-	int cpu_status;
-	unsigned int pcpu = get_hard_smp_processor_id(cpu);
-
-	for (tries = 0; tries < 25; tries++) {
-		cpu_status = query_cpu_stopped(pcpu);
-		if (cpu_status == 0 || cpu_status == -1)
-			break;
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		schedule_timeout(HZ/5);
-	}
-	if (cpu_status != 0) {
-		printk("Querying DEAD? cpu %i (%i) shows %i\n",
-		       cpu, pcpu, cpu_status);
-	}
-
-	/* Isolation and deallocation are definatly done by
-	 * drslot_chrp_cpu.  If they were not they would be
-	 * done here.  Change isolate state to Isolate and
-	 * change allocation-state to Unusable.
-	 */
-	paca[cpu].cpu_start = 0;
-
-	/* So we can recognize if it fails to come up next time. */
-	cpu_callin_map[cpu] = 0;
-}
-
-/* Kill this cpu */
-void cpu_die(void)
-{
-	local_irq_disable();
-	/* Some hardware requires clearing the CPPR, while other hardware does not
-	 * it is safe either way
-	 */
-	pSeriesLP_cppr_info(0, 0);
-	rtas_stop_self();
-	/* Should never get here... */
-	BUG();
-	for(;;);
-}
-
-/* Search all cpu device nodes for an offline logical cpu.  If a
- * device node has a "ibm,my-drc-index" property (meaning this is an
- * LPAR), paranoid-check whether we own the cpu.  For each "thread"
- * of a cpu, if it is offline and has the same hw index as before,
- * grab that in preference.
- */
-static unsigned int find_physical_cpu_to_start(unsigned int old_hwindex)
-{
-	struct device_node *np = NULL;
-	unsigned int best = -1U;
-
-	while ((np = of_find_node_by_type(np, "cpu"))) {
-		int nr_threads, len;
-		u32 *index = (u32 *)get_property(np, "ibm,my-drc-index", NULL);
-		u32 *tid = (u32 *)
-			get_property(np, "ibm,ppc-interrupt-server#s", &len);
-
-		if (!tid)
-			tid = (u32 *)get_property(np, "reg", &len);
-
-		if (!tid)
-			continue;
-
-		/* If there is a drc-index, make sure that we own
-		 * the cpu.
-		 */
-		if (index) {
-			int state;
-			int rc = rtas_get_sensor(9003, *index, &state);
-			if (rc != 0 || state != 1)
-				continue;
-		}
-
-		nr_threads = len / sizeof(u32);
-
-		while (nr_threads--) {
-			if (0 == query_cpu_stopped(tid[nr_threads])) {
-				best = tid[nr_threads];
-				if (best == old_hwindex)
-					goto out;
-			}
-		}
-	}
-out:
-	of_node_put(np);
-	return best;
-}
-
-/**
- * smp_startup_cpu() - start the given cpu
- *
- * At boot time, there is nothing to do.  At run-time, call RTAS with
- * the appropriate start location, if the cpu is in the RTAS stopped
- * state.
- *
- * Returns:
- *	0	- failure
- *	1	- success
- */
-static inline int __devinit smp_startup_cpu(unsigned int lcpu)
-{
-	int status;
-	unsigned long start_here = __pa((u32)*((unsigned long *)
-					       pseries_secondary_smp_init));
-	unsigned int pcpu;
-
-	/* At boot time the cpus are already spinning in hold
-	 * loops, so nothing to do. */
- 	if (system_state < SYSTEM_RUNNING)
-		return 1;
-
-	pcpu = find_physical_cpu_to_start(get_hard_smp_processor_id(lcpu));
-	if (pcpu == -1U) {
-		printk(KERN_INFO "No more cpus available, failing\n");
-		return 0;
-	}
-
-	/* Fixup atomic count: it exited inside IRQ handler. */
-	paca[lcpu].__current->thread_info->preempt_count	= 0;
-
-	/* At boot this is done in prom.c. */
-	paca[lcpu].hw_cpu_id = pcpu;
-
-	status = rtas_call(rtas_token("start-cpu"), 3, 1, NULL,
-			   pcpu, start_here, lcpu);
-	if (status != 0) {
-		printk(KERN_ERR "start-cpu failed: %i\n", status);
-		return 0;
-	}
-	return 1;
-}
-#else /* ... CONFIG_HOTPLUG_CPU */
-static inline int __devinit smp_startup_cpu(unsigned int lcpu)
-{
-	return 1;
-}
-#endif /* CONFIG_HOTPLUG_CPU */
-
-static void smp_pSeries_kick_cpu(int nr)
+void __devinit smp_generic_kick_cpu(int nr)
 {
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
-	if (!smp_startup_cpu(nr))
-		return;
-
 	/*
 	 * The processor is currently spinning, waiting for the
 	 * cpu_start field to become non-zero After we set cpu_start,
 	 * the processor will continue on to secondary_start
 	 */
 	paca[nr].cpu_start = 1;
+	mb();
 }
-#endif /* CONFIG_PPC_PSERIES */
+
+#endif /* CONFIG_PPC_MULTIPLATFORM */
 
 static void __init smp_space_timers(unsigned int max_cpus)
 {
@@ -461,136 +159,6 @@
 	}
 }
 
-#ifdef CONFIG_PPC_PSERIES
-static void vpa_init(int cpu)
-{
-	unsigned long flags, pcpu = get_hard_smp_processor_id(cpu);
-
-	/* Register the Virtual Processor Area (VPA) */
-	flags = 1UL << (63 - 18);
-	register_vpa(flags, pcpu, __pa((unsigned long)&(paca[cpu].lppaca)));
-}
-
-static inline void smp_xics_do_message(int cpu, int msg)
-{
-	set_bit(msg, &xics_ipi_message[cpu].value);
-	mb();
-	xics_cause_IPI(cpu);
-}
-
-static void smp_xics_message_pass(int target, int msg)
-{
-	unsigned int i;
-
-	if (target < NR_CPUS) {
-		smp_xics_do_message(target, msg);
-	} else {
-		for_each_online_cpu(i) {
-			if (target == MSG_ALL_BUT_SELF
-			    && i == smp_processor_id())
-				continue;
-			smp_xics_do_message(i, msg);
-		}
-	}
-}
-
-extern void xics_request_IPIs(void);
-
-static int __init smp_xics_probe(void)
-{
-#ifdef CONFIG_SMP
-	xics_request_IPIs();
-#endif
-
-	return cpus_weight(cpu_possible_map);
-}
-
-static void __devinit smp_xics_setup_cpu(int cpu)
-{
-	if (cpu != boot_cpuid)
-		xics_setup_cpu();
-}
-
-static spinlock_t timebase_lock = SPIN_LOCK_UNLOCKED;
-static unsigned long timebase = 0;
-
-static void __devinit pSeries_give_timebase(void)
-{
-	spin_lock(&timebase_lock);
-	rtas_call(rtas_token("freeze-time-base"), 0, 1, NULL);
-	timebase = get_tb();
-	spin_unlock(&timebase_lock);
-
-	while (timebase)
-		barrier();
-	rtas_call(rtas_token("thaw-time-base"), 0, 1, NULL);
-}
-
-static void __devinit pSeries_take_timebase(void)
-{
-	while (!timebase)
-		barrier();
-	spin_lock(&timebase_lock);
-	set_tb(timebase >> 32, timebase & 0xffffffff);
-	timebase = 0;
-	spin_unlock(&timebase_lock);
-}
-
-static struct smp_ops_t pSeries_mpic_smp_ops = {
-	.message_pass	= smp_mpic_message_pass,
-	.probe		= smp_mpic_probe,
-	.kick_cpu	= smp_pSeries_kick_cpu,
-	.setup_cpu	= smp_mpic_setup_cpu,
-};
-
-static struct smp_ops_t pSeries_xics_smp_ops = {
-	.message_pass	= smp_xics_message_pass,
-	.probe		= smp_xics_probe,
-	.kick_cpu	= smp_pSeries_kick_cpu,
-	.setup_cpu	= smp_xics_setup_cpu,
-};
-
-/* This is called very early */
-void __init smp_init_pSeries(void)
-{
-	int ret, i;
-
-	DBG(" -> smp_init_pSeries()\n");
-
-	if (naca->interrupt_controller == IC_OPEN_PIC)
-		smp_ops = &pSeries_mpic_smp_ops;
-	else
-		smp_ops = &pSeries_xics_smp_ops;
-
-	/* Start secondary threads on SMT systems; primary threads
-	 * are already in the running state.
-	 */
-	for_each_present_cpu(i) {
-		if (query_cpu_stopped(get_hard_smp_processor_id(i)) == 0) {
-			printk("%16.16x : starting thread\n", i);
-			DBG("%16.16x : starting thread\n", i);
-			rtas_call(rtas_token("start-cpu"), 3, 1, &ret,
-				  get_hard_smp_processor_id(i),
-				  __pa((u32)*((unsigned long *)
-					      pseries_secondary_smp_init)),
-				  i);
-		}
-	}
-
-	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR)
-		vpa_init(boot_cpuid);
-
-	/* Non-lpar has additional take/give timebase */
-	if (systemcfg->platform == PLATFORM_PSERIES) {
-		smp_ops->give_timebase = pSeries_give_timebase;
-		smp_ops->take_timebase = pSeries_take_timebase;
-	}
-
-
-	DBG(" <- smp_init_pSeries()\n");
-}
-#endif /* CONFIG_PPC_PSERIES */
-
 void smp_local_timer_interrupt(struct pt_regs * regs)
 {
 	update_process_times(user_mode(regs));
@@ -813,6 +381,8 @@
 {
 	unsigned int cpu;
 
+	DBG("smp_prepare_cpus\n");
+
 	/* 
 	 * setup_cpu may need to be called on the boot cpu. We havent
 	 * spun any cpus up but lets be paranoid.
@@ -877,6 +447,11 @@
 		paca[cpu].stab_real = virt_to_abs(tmp);
 	}
 
+	/* Make sure callin-map entry is 0 (can be leftover a CPU
+	 * hotplug
+	 */
+	cpu_callin_map[cpu] = 0;
+
 	/* The information for processor bringup must
 	 * be written out to main store before we release
 	 * the processor.
@@ -884,6 +459,7 @@
 	mb();
 
 	/* wake up cpus */
+	DBG("smp: kicking cpu %d\n", cpu);
 	smp_ops->kick_cpu(cpu);
 
 	/*
@@ -923,7 +499,7 @@
 	return 0;
 }
 
-extern unsigned int default_distrib_server;
+
 /* Activate a secondary processor. */
 int __devinit start_secondary(void *unused)
 {
@@ -940,20 +516,8 @@
 	if (smp_ops->take_timebase)
 		smp_ops->take_timebase();
 
-#ifdef CONFIG_PPC_PSERIES
-	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
-		vpa_init(cpu); 
-	}
-
-#ifdef CONFIG_IRQ_ALL_CPUS
-	/* Put the calling processor into the GIQ.  This is really only
-	 * necessary from a secondary thread as the OF start-cpu interface
-	 * performs this function for us on primary threads.
-	 */
-	/* TODO: 9005 is #defined in rtas-proc.c -- move to a header */
-	rtas_set_indicator(9005, default_distrib_server, 1);
-#endif
-#endif
+	if (smp_ops->late_setup_cpu)
+		smp_ops->late_setup_cpu(cpu);
 
 	spin_lock(&call_lock);
 	cpu_set(cpu, cpu_online_map);
Index: linux-work/include/asm-ppc64/machdep.h
===================================================================
--- linux-work.orig/include/asm-ppc64/machdep.h	2004-10-25 10:24:50.000000000 +1000
+++ linux-work/include/asm-ppc64/machdep.h	2004-10-25 11:29:38.890078624 +1000
@@ -28,6 +28,7 @@
 	int   (*probe)(void);
 	void  (*kick_cpu)(int nr);
 	void  (*setup_cpu)(int nr);
+	void  (*late_setup_cpu)(int nr);
 	void  (*take_timebase)(void);
 	void  (*give_timebase)(void);
 };
@@ -86,6 +87,7 @@
 	void		(*power_off)(void);
 	void		(*halt)(void);
 	void		(*panic)(char *str);
+	void		(*cpu_die)(void);
 
 	int		(*set_rtc_time)(struct rtc_time *);
 	void		(*get_rtc_time)(struct rtc_time *);
Index: linux-work/include/asm-ppc64/smp.h
===================================================================
--- linux-work.orig/include/asm-ppc64/smp.h	2004-10-25 10:24:50.000000000 +1000
+++ linux-work/include/asm-ppc64/smp.h	2004-10-25 11:29:38.894078016 +1000
@@ -28,6 +28,8 @@
 
 extern int boot_cpuid;
 
+extern void cpu_die(void) __attribute__((noreturn));
+
 #ifdef CONFIG_SMP
 
 extern void smp_send_debugger_break(int cpu);
@@ -57,9 +59,7 @@
 
 extern int __cpu_disable(void);
 extern void __cpu_die(unsigned int cpu);
-extern void cpu_die(void) __attribute__((noreturn));
-extern int query_cpu_stopped(unsigned int pcpu);
-#endif /* !(CONFIG_SMP) */
+#endif /* CONFIG_SMP */
 
 #define get_hard_smp_processor_id(CPU) (paca[(CPU)].hw_cpu_id)
 #define set_hard_smp_processor_id(CPU, VAL) \
@@ -70,6 +70,12 @@
 extern int smp_mpic_probe(void);
 extern void smp_mpic_setup_cpu(int cpu);
 extern void smp_mpic_message_pass(int target, int msg);
+extern void smp_generic_kick_cpu(int nr);
+
+extern void smp_generic_give_timebase(void);
+extern void smp_generic_take_timebase(void);
+
+extern struct smp_ops_t *smp_ops;
 
 #endif /* __ASSEMBLY__ */
 
Index: linux-work/arch/ppc64/kernel/iSeries_smp.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/ppc64/kernel/iSeries_smp.c	2004-10-25 11:29:38.896077712 +1000
@@ -0,0 +1,151 @@
+/*
+ * SMP support for iSeries machines.
+ *
+ * Dave Engebretsen, Peter Bergner, and
+ * Mike Corrigan {engebret|bergner|mikec}@us.ibm.com
+ *
+ * Plus various changes from other IBM teams...
+ *
+ *      This program is free software; you can redistribute it and/or
+ *      modify it under the terms of the GNU General Public License
+ *      as published by the Free Software Foundation; either version
+ *      2 of the License, or (at your option) any later version.
+ */
+
+#undef DEBUG
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/smp_lock.h>
+#include <linux/interrupt.h>
+#include <linux/kernel_stat.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/cache.h>
+#include <linux/err.h>
+#include <linux/sysdev.h>
+#include <linux/cpu.h>
+
+#include <asm/ptrace.h>
+#include <asm/atomic.h>
+#include <asm/irq.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/io.h>
+#include <asm/smp.h>
+#include <asm/naca.h>
+#include <asm/paca.h>
+#include <asm/iSeries/LparData.h>
+#include <asm/iSeries/HvCall.h>
+#include <asm/iSeries/HvCallCfg.h>
+#include <asm/time.h>
+#include <asm/ppcdebug.h>
+#include <asm/machdep.h>
+#include <asm/cputable.h>
+#include <asm/system.h>
+
+static unsigned long iSeries_smp_message[NR_CPUS];
+
+void iSeries_smp_message_recv( struct pt_regs * regs )
+{
+	int cpu = smp_processor_id();
+	int msg;
+
+	if ( num_online_cpus() < 2 )
+		return;
+
+	for ( msg = 0; msg < 4; ++msg )
+		if ( test_and_clear_bit( msg, &iSeries_smp_message[cpu] ) )
+			smp_message_recv( msg, regs );
+}
+
+static inline void smp_iSeries_do_message(int cpu, int msg)
+{
+	set_bit(msg, &iSeries_smp_message[cpu]);
+	HvCall_sendIPI(&(paca[cpu]));
+}
+
+static void smp_iSeries_message_pass(int target, int msg)
+{
+	int i;
+
+	if (target < NR_CPUS)
+		smp_iSeries_do_message(target, msg);
+	else {
+		for_each_online_cpu(i) {
+			if (target == MSG_ALL_BUT_SELF
+			    && i == smp_processor_id())
+				continue;
+			smp_iSeries_do_message(i, msg);
+		}
+	}
+}
+
+static int smp_iSeries_numProcs(void)
+{
+	unsigned np, i;
+
+	np = 0;
+        for (i=0; i < NR_CPUS; ++i) {
+                if (paca[i].lppaca.xDynProcStatus < 2) {
+			cpu_set(i, cpu_possible_map);
+			cpu_set(i, cpu_present_map);
+                        ++np;
+                }
+        }
+	return np;
+}
+
+static int smp_iSeries_probe(void)
+{
+	unsigned i;
+	unsigned np = 0;
+
+	for (i=0; i < NR_CPUS; ++i) {
+		if (paca[i].lppaca.xDynProcStatus < 2) {
+			/*paca[i].active = 1;*/
+			++np;
+		}
+	}
+
+	return np;
+}
+
+static void smp_iSeries_kick_cpu(int nr)
+{
+	BUG_ON(nr < 0 || nr >= NR_CPUS);
+
+	/* Verify that our partition has a processor nr */
+	if (paca[nr].lppaca.xDynProcStatus >= 2)
+		return;
+
+	/* The processor is currently spinning, waiting
+	 * for the cpu_start field to become non-zero
+	 * After we set cpu_start, the processor will
+	 * continue on to secondary_start in iSeries_head.S
+	 */
+	paca[nr].cpu_start = 1;
+}
+
+static void __devinit smp_iSeries_setup_cpu(int nr)
+{
+}
+
+static struct smp_ops_t iSeries_smp_ops = {
+	.message_pass = smp_iSeries_message_pass,
+	.probe        = smp_iSeries_probe,
+	.kick_cpu     = smp_iSeries_kick_cpu,
+	.setup_cpu    = smp_iSeries_setup_cpu,
+};
+
+/* This is called very early. */
+void __init smp_init_iSeries(void)
+{
+	smp_ops = &iSeries_smp_ops;
+	systemcfg->processorCount	= smp_iSeries_numProcs();
+}
+
Index: linux-work/arch/ppc64/kernel/pmac_smp.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pmac_smp.c	2004-10-25 10:24:50.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pmac_smp.c	2004-10-25 11:29:38.909075736 +1000
@@ -21,6 +21,9 @@
  *  as published by the Free Software Foundation; either version
  *  2 of the License, or (at your option) any later version.
  */
+
+#undef DEBUG
+
 #include <linux/config.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -51,6 +54,11 @@
 
 #include "mpic.h"
 
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
+#else
+#define DBG(fmt...)
+#endif
 
 extern void pmac_secondary_start_1(void);
 extern void pmac_secondary_start_2(void);
@@ -102,15 +110,16 @@
 	 *   b .pmac_secondary_start - KERNELBASE
 	 */
 	switch(nr) {
-		case 1:
-			new_vector = (unsigned long)pmac_secondary_start_1;
-			break;
-		case 2:
-			new_vector = (unsigned long)pmac_secondary_start_2;
-			break;
-		case 3:
-			new_vector = (unsigned long)pmac_secondary_start_3;
-			break;
+	case 1:
+		new_vector = (unsigned long)pmac_secondary_start_1;
+		break;
+	case 2:
+		new_vector = (unsigned long)pmac_secondary_start_2;
+		break;			
+	case 3:
+	default:
+		new_vector = (unsigned long)pmac_secondary_start_3;
+		break;
 	}
 	*vector = 0x48000002 + (new_vector - KERNELBASE);
 
@@ -149,13 +158,10 @@
 		 */
 		if (num_online_cpus() < 2)		
 			g5_phy_disable_cpu1();
-		if (ppc_md.progress) ppc_md.progress("core99_setup_cpu 0 done", 0x349);
+		if (ppc_md.progress) ppc_md.progress("smp_core99_setup_cpu 0 done", 0x349);
 	}
 }
 
-extern void smp_generic_give_timebase(void);
-extern void smp_generic_take_timebase(void);
-
 struct smp_ops_t core99_smp_ops __pmacdata = {
 	.message_pass	= smp_mpic_message_pass,
 	.probe		= smp_core99_probe,
Index: linux-work/arch/ppc64/kernel/pSeries_setup.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/pSeries_setup.c	2004-10-25 10:24:50.000000000 +1000
+++ linux-work/arch/ppc64/kernel/pSeries_setup.c	2004-10-25 11:29:38.911075432 +1000
@@ -321,6 +321,20 @@
 	}
 }
 
+static void pSeries_cpu_die(void)
+{
+	local_irq_disable();
+	/* Some hardware requires clearing the CPPR, while other hardware does not
+	 * it is safe either way
+	 */
+	pSeriesLP_cppr_info(0, 0);
+	rtas_stop_self();
+	/* Should never get here... */
+	BUG();
+	for(;;);
+}
+
+
 /*
  * Early initialization.  Relocation is on but do not reference unbolted pages
  */
@@ -588,6 +602,7 @@
 	.power_off		= rtas_power_off,
 	.halt			= rtas_halt,
 	.panic			= rtas_os_term,
+	.cpu_die		= pSeries_cpu_die,
 	.get_boot_time		= pSeries_get_boot_time,
 	.get_rtc_time		= pSeries_get_rtc_time,
 	.set_rtc_time		= pSeries_set_rtc_time,
Index: linux-work/arch/ppc64/kernel/setup.c
===================================================================
--- linux-work.orig/arch/ppc64/kernel/setup.c	2004-10-25 10:24:50.000000000 +1000
+++ linux-work/arch/ppc64/kernel/setup.c	2004-10-25 11:29:38.923073608 +1000
@@ -1308,3 +1308,10 @@
 early_param("xmon", early_xmon);
 #endif
 
+void cpu_die(void)
+{
+	if (ppc_md.cpu_die)
+		ppc_md.cpu_die();
+	local_irq_disable();
+	for (;;);
+}
Index: linux-work/arch/ppc64/kernel/Makefile
===================================================================
--- linux-work.orig/arch/ppc64/kernel/Makefile	2004-10-25 10:24:50.000000000 +1000
+++ linux-work/arch/ppc64/kernel/Makefile	2004-10-25 11:29:38.932072240 +1000
@@ -53,6 +53,8 @@
 
 ifdef CONFIG_SMP
 obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o smp-tbsync.o
+obj-$(CONFIG_PPC_ISERIES)	+= iSeries_smp.o
+obj-$(CONFIG_PPC_PSERIES)	+= pSeries_smp.o
 endif
 
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o


