Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263043AbVCQMJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263043AbVCQMJR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 07:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbVCQLtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 06:49:45 -0500
Received: from ozlabs.org ([203.10.76.45]:42646 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263055AbVCQKqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 05:46:23 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16953.24629.421521.342310@cargo.ozlabs.ibm.com>
Date: Thu, 17 Mar 2005 21:47:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Nathan Lynch <ntl@pobox.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] PPC64 make cpu hotplug play well with maxcpus and smt-enabled
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows you to boot a pSeries system with maxcpus=x or
smt-enabled=off (or both) and bring up the offline cpus later from
userspace, assuming the kernel was built with CONFIG_HOTPLUG_CPU=y.

- Record cpus which were started from OF in a cpu map and use that
instead of system_state to decide how to start a cpu in
smp_startup_cpu.

- Change the smp bootup logic slightly so that the path for bringing
up secondary threads is exactly the same as hotplugging a cpu later
from userspace.

- Add a new function to smp_ops - cpu_bootable.  This is implemented
only by pSeries to filter out secondary threads during boot with
smt-enabled=off.  Another way this could be done is to change the
kick_cpu member to return int and we can check for this case in
smp_pSeries_kick_cpu.

- Remove the games we play with cpu_present_map and the
hard_smp_processor_id to handle smt-enabled=off, since they're now
unnecessary.

- Remove find_physical_cpu_to_start; assigning threads to logical
slots should be done at bootup and at DLPAR time, not during a cpu
online operation.

One caveat: you need up-to-date firmware on Power5 for the maxcpus
option to work on systems with more than one processor.  Otherwise
interrupts get misrouted, typically resulting in hangs or "unable to
find root filesystem" problems.

Tested on Power5 with and without CONFIG_HOTPLUG_CPU and with various
combinations of the maxcpus= and smt-enabled= parameters.

 arch/ppc64/kernel/pSeries_smp.c |  183 +++++++++++++++-------------------------
 arch/ppc64/kernel/setup.c       |   12 --
 arch/ppc64/kernel/smp.c         |   13 --
 include/asm-ppc64/machdep.h     |    1 
 4 files changed, 78 insertions(+), 131 deletions(-)

Signed-off-by: Nathan Lynch <ntl@pobox.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

Index: linux-2.6.11-bk5/arch/ppc64/kernel/pSeries_smp.c
===================================================================
--- linux-2.6.11-bk5.orig/arch/ppc64/kernel/pSeries_smp.c	2005-03-09 20:31:06.000000000 +0000
+++ linux-2.6.11-bk5/arch/ppc64/kernel/pSeries_smp.c	2005-03-09 20:32:55.000000000 +0000
@@ -54,8 +54,16 @@
 #define DBG(fmt...)
 #endif
 
+/*
+ * The primary thread of each non-boot processor is recorded here before
+ * smp init.
+ */
+static cpumask_t of_spin_map;
+
 extern void pSeries_secondary_smp_init(unsigned long);
 
+#ifdef CONFIG_HOTPLUG_CPU
+
 /* Get state of physical CPU.
  * Return codes:
  *	0	- The processor is in the RTAS stopped state
@@ -82,9 +90,6 @@ static int query_cpu_stopped(unsigned in
 	return cpu_status;
 }
 
-
-#ifdef CONFIG_HOTPLUG_CPU
-
 int pSeries_cpu_disable(void)
 {
 	systemcfg->processorCount--;
@@ -123,98 +128,6 @@ void pSeries_cpu_die(unsigned int cpu)
 	paca[cpu].cpu_start = 0;
 }
 
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
-			if (rc < 0 || state != 1)
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
-					       pSeries_secondary_smp_init));
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
-
 /*
  * Update cpu_present_map and paca(s) for a new cpu node.  The wrinkle
  * here is that a cpu device node may represent up to two logical cpus
@@ -335,12 +248,43 @@ static struct notifier_block pSeries_smp
 	.notifier_call = pSeries_smp_notifier,
 };
 
-#else /* ... CONFIG_HOTPLUG_CPU */
+#endif /* CONFIG_HOTPLUG_CPU */
+
+/**
+ * smp_startup_cpu() - start the given cpu
+ *
+ * At boot time, there is nothing to do for primary threads which were
+ * started from Open Firmware.  For anything else, call RTAS with the
+ * appropriate start location.
+ *
+ * Returns:
+ *	0	- failure
+ *	1	- success
+ */
 static inline int __devinit smp_startup_cpu(unsigned int lcpu)
 {
+	int status;
+	unsigned long start_here = __pa((u32)*((unsigned long *)
+					       pSeries_secondary_smp_init));
+	unsigned int pcpu;
+
+	if (cpu_isset(lcpu, of_spin_map))
+		/* Already started by OF and sitting in spin loop */
+		return 1;
+
+	pcpu = get_hard_smp_processor_id(lcpu);
+
+	/* Fixup atomic count: it exited inside IRQ handler. */
+	paca[lcpu].__current->thread_info->preempt_count	= 0;
+
+	status = rtas_call(rtas_token("start-cpu"), 3, 1, NULL,
+			   pcpu, start_here, lcpu);
+	if (status != 0) {
+		printk(KERN_ERR "start-cpu failed: %i\n", status);
+		return 0;
+	}
 	return 1;
 }
-#endif /* CONFIG_HOTPLUG_CPU */
 
 static inline void smp_xics_do_message(int cpu, int msg)
 {
@@ -380,6 +324,8 @@ static void __devinit smp_xics_setup_cpu
 	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR)
 		vpa_init(cpu);
 
+	cpu_clear(cpu, of_spin_map);
+
 	/*
 	 * Put the calling processor into the GIQ.  This is really only
 	 * necessary from a secondary thread as the OF start-cpu interface
@@ -429,6 +375,20 @@ static void __devinit smp_pSeries_kick_c
 	paca[nr].cpu_start = 1;
 }
 
+static int smp_pSeries_cpu_bootable(unsigned int nr)
+{
+	/* Special case - we inhibit secondary thread startup
+	 * during boot if the user requests it.  Odd-numbered
+	 * cpus are assumed to be secondary threads.
+	 */
+	if (system_state < SYSTEM_RUNNING &&
+	    cur_cpu_spec->cpu_features & CPU_FTR_SMT &&
+	    !smt_enabled_at_boot && nr % 2 != 0)
+		return 0;
+
+	return 1;
+}
+
 static struct smp_ops_t pSeries_mpic_smp_ops = {
 	.message_pass	= smp_mpic_message_pass,
 	.probe		= smp_mpic_probe,
@@ -441,12 +401,13 @@ static struct smp_ops_t pSeries_xics_smp
 	.probe		= smp_xics_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_xics_setup_cpu,
+	.cpu_bootable	= smp_pSeries_cpu_bootable,
 };
 
 /* This is called very early */
 void __init smp_init_pSeries(void)
 {
-	int ret, i;
+	int i;
 
 	DBG(" -> smp_init_pSeries()\n");
 
@@ -464,20 +425,20 @@ void __init smp_init_pSeries(void)
 		pSeries_reconfig_notifier_register(&pSeries_smp_nb);
 #endif
 
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
-					      pSeries_secondary_smp_init)),
-				  i);
+	/* Mark threads which are still spinning in hold loops. */
+	if (cur_cpu_spec->cpu_features & CPU_FTR_SMT)
+		for_each_present_cpu(i) {
+			if (i % 2 == 0)
+				/* 
+				 * Even-numbered logical cpus correspond to
+				 * primary threads.
+				 */
+				cpu_set(i, of_spin_map);
 		}
-	}
+	else
+		of_spin_map = cpu_present_map;
+
+	cpu_clear(boot_cpuid, of_spin_map);
 
 	/* Non-lpar has additional take/give timebase */
 	if (rtas_token("freeze-time-base") != RTAS_UNKNOWN_SERVICE) {
Index: linux-2.6.11-bk5/include/asm-ppc64/machdep.h
===================================================================
--- linux-2.6.11-bk5.orig/include/asm-ppc64/machdep.h	2005-03-09 20:30:34.000000000 +0000
+++ linux-2.6.11-bk5/include/asm-ppc64/machdep.h	2005-03-09 20:32:55.000000000 +0000
@@ -33,6 +33,7 @@ struct smp_ops_t {
 	int   (*cpu_enable)(unsigned int nr);
 	int   (*cpu_disable)(void);
 	void  (*cpu_die)(unsigned int nr);
+	int   (*cpu_bootable)(unsigned int nr);
 };
 #endif
 
Index: linux-2.6.11-bk5/arch/ppc64/kernel/smp.c
===================================================================
--- linux-2.6.11-bk5.orig/arch/ppc64/kernel/smp.c	2005-03-09 20:30:34.000000000 +0000
+++ linux-2.6.11-bk5/arch/ppc64/kernel/smp.c	2005-03-09 20:32:55.000000000 +0000
@@ -490,9 +490,8 @@ int __devinit __cpu_up(unsigned int cpu)
 	if (!cpu_enable(cpu))
 		return 0;
 
-	/* At boot, don't bother with non-present cpus -JSCHOPP */
-	if (system_state < SYSTEM_RUNNING && !cpu_present(cpu))
-		return -ENOENT;
+	if (smp_ops->cpu_bootable && !smp_ops->cpu_bootable(cpu))
+		return -EINVAL;
 
 	paca[cpu].default_decr = tb_ticks_per_jiffy / decr_overclock;
 
@@ -606,14 +605,6 @@ void __init smp_cpus_done(unsigned int m
 	smp_ops->setup_cpu(boot_cpuid);
 
 	set_cpus_allowed(current, old_mask);
-
-	/*
-	 * We know at boot the maximum number of cpus we can add to
-	 * a partition and set cpu_possible_map accordingly. cpu_present_map
-	 * needs to match for the hotplug code to allow us to hot add
-	 * any offline cpus.
-	 */
-	cpu_present_map = cpu_possible_map;
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
Index: linux-2.6.11-bk5/arch/ppc64/kernel/setup.c
===================================================================
--- linux-2.6.11-bk5.orig/arch/ppc64/kernel/setup.c	2005-03-09 20:30:34.000000000 +0000
+++ linux-2.6.11-bk5/arch/ppc64/kernel/setup.c	2005-03-09 20:32:55.000000000 +0000
@@ -269,15 +269,9 @@ static void __init setup_cpu_maps(void)
 		nthreads = len / sizeof(u32);
 
 		for (j = 0; j < nthreads && cpu < NR_CPUS; j++) {
-			/*
-			 * Only spin up secondary threads if SMT is enabled.
-			 * We must leave space in the logical map for the
-			 * threads.
-			 */
-			if (j == 0 || smt_enabled_at_boot) {
-				cpu_set(cpu, cpu_present_map);
-				set_hard_smp_processor_id(cpu, intserv[j]);
-			}
+			cpu_set(cpu, cpu_present_map);
+			set_hard_smp_processor_id(cpu, intserv[j]);
+
 			if (intserv[j] == boot_cpuid_phys)
 				swap_cpuid = cpu;
 			cpu_set(cpu, cpu_possible_map);
