Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262277AbVAJOiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262277AbVAJOiS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 09:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVAJOiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 09:38:18 -0500
Received: from ozlabs.org ([203.10.76.45]:17820 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262277AbVAJOg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 09:36:58 -0500
Date: Tue, 11 Jan 2005 01:35:36 +1100
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: interrupt code cleanup
Message-ID: <20050110143536.GV14239@krispykreme.ozlabs.ibm.com>
References: <20050110133838.GT14239@krispykreme.ozlabs.ibm.com> <20050110134120.GU14239@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050110134120.GU14239@krispykreme.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- Move some function prototypes into header files.
- Remove late_setup_cpu, put the set indicator and vpa init into xics
  probe instead
- rtas-proc was doing weird stuff with the 9005 indicator. Get rid of
  it.
- Dont open code the set_indicator call in the hotplug code

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/pSeries_smp.c~debug_gqirm arch/ppc64/kernel/pSeries_smp.c
--- foobar2/arch/ppc64/kernel/pSeries_smp.c~debug_gqirm	2005-01-11 00:01:23.800169185 +1100
+++ foobar2-anton/arch/ppc64/kernel/pSeries_smp.c	2005-01-11 00:01:23.862164456 +1100
@@ -19,9 +19,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
-#include <linux/smp_lock.h>
 #include <linux/interrupt.h>
-#include <linux/kernel_stat.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
@@ -40,7 +38,6 @@
 #include <asm/smp.h>
 #include <asm/paca.h>
 #include <asm/time.h>
-#include <asm/ppcdebug.h>
 #include <asm/machdep.h>
 #include <asm/xics.h>
 #include <asm/cputable.h>
@@ -89,9 +86,6 @@ static int query_cpu_stopped(unsigned in
 
 int __cpu_disable(void)
 {
-	/* FIXME: go put this in a header somewhere */
-	extern void xics_migrate_irqs_away(void);
-
 	systemcfg->processorCount--;
 
 	/*fix boot_cpuid here*/
@@ -250,8 +244,6 @@ static void smp_xics_message_pass(int ta
 	}
 }
 
-extern void xics_request_IPIs(void);
-
 static int __init smp_xics_probe(void)
 {
 	xics_request_IPIs();
@@ -263,6 +255,18 @@ static void __devinit smp_xics_setup_cpu
 {
 	if (cpu != boot_cpuid)
 		xics_setup_cpu();
+
+	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR)
+		vpa_init(cpu);
+
+#ifdef CONFIG_IRQ_ALL_CPUS
+	/*
+	 * Put the calling processor into the GIQ.  This is really only
+	 * necessary from a secondary thread as the OF start-cpu interface
+	 * performs this function for us on primary threads.
+	 */
+	rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE, default_distrib_server, 1);
+#endif
 }
 
 static spinlock_t timebase_lock = SPIN_LOCK_UNLOCKED;
@@ -290,26 +294,7 @@ static void __devinit pSeries_take_timeb
 	spin_unlock(&timebase_lock);
 }
 
-static void __devinit pSeries_late_setup_cpu(int cpu)
-{
-	extern unsigned int default_distrib_server;
-
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
-}
-
-
-void __devinit smp_pSeries_kick_cpu(int nr)
+static void __devinit smp_pSeries_kick_cpu(int nr)
 {
 	BUG_ON(nr < 0 || nr >= NR_CPUS);
 
@@ -329,7 +314,6 @@ static struct smp_ops_t pSeries_mpic_smp
 	.probe		= smp_mpic_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_mpic_setup_cpu,
-	.late_setup_cpu	= pSeries_late_setup_cpu,
 };
 
 static struct smp_ops_t pSeries_xics_smp_ops = {
@@ -337,7 +321,6 @@ static struct smp_ops_t pSeries_xics_smp
 	.probe		= smp_xics_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_xics_setup_cpu,
-	.late_setup_cpu	= pSeries_late_setup_cpu,
 };
 
 /* This is called very early */
@@ -367,9 +350,6 @@ void __init smp_init_pSeries(void)
 		}
 	}
 
-	if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR)
-		vpa_init(boot_cpuid);
-
 	/* Non-lpar has additional take/give timebase */
 	if (rtas_token("freeze-time-base") != RTAS_UNKNOWN_SERVICE) {
 		smp_ops->give_timebase = pSeries_give_timebase;
diff -puN arch/ppc64/kernel/rtas-proc.c~debug_gqirm arch/ppc64/kernel/rtas-proc.c
--- foobar2/arch/ppc64/kernel/rtas-proc.c~debug_gqirm	2005-01-11 00:01:23.806168727 +1100
+++ foobar2-anton/arch/ppc64/kernel/rtas-proc.c	2005-01-11 00:01:23.873163617 +1100
@@ -52,7 +52,6 @@
 #define IBM_VOLTAGE		0x232a /* 9002 */
 #define IBM_DRCONNECTOR		0x232b /* 9003 */
 #define IBM_POWERSUPPLY		0x232c /* 9004 */
-#define IBM_INTQUEUE		0x232d /* 9005 */
 
 /* Status return values */
 #define SENSOR_CRITICAL_HIGH	13
@@ -107,7 +106,6 @@
 #define DR_ACTION		0x2329 /* 9001 */
 #define DR_INDICATOR		0x232a /* 9002 */
 /* 9003 - 9004: Vendor specific */
-#define GLOBAL_INTERRUPT_QUEUE	0x232d /* 9005 */
 /* 9006 - 9999: Vendor specific */
 
 /* other */
@@ -553,7 +551,6 @@ static void ppc_rtas_process_sensor(stru
 						"No current flow" };
 	const char * ibm_drconnector[]     = { "Empty", "Present", "Unusable", 
 						"Exchange" };
-	const char * ibm_intqueue[]        = { "Disabled", "Enabled" };
 
 	int have_strings = 0;
 	int num_states = 0;
@@ -665,15 +662,6 @@ static void ppc_rtas_process_sensor(stru
 		case IBM_POWERSUPPLY:
 			seq_printf(m, "Powersupply:\t");
 			break;
-		case IBM_INTQUEUE:
-			seq_printf(m, "Interrupt queue:\t");
-			num_states = sizeof(ibm_intqueue) / sizeof(char *);
-			if (state < num_states) {
-				seq_printf(m, "%s\t", 
-						ibm_intqueue[state]);
-				have_strings = 1;
-			}
-			break;
 		default:
 			seq_printf(m,  "Unknown sensor (type %d), ignoring it\n",
 					s->token);
diff -puN arch/ppc64/kernel/smp.c~debug_gqirm arch/ppc64/kernel/smp.c
--- foobar2/arch/ppc64/kernel/smp.c~debug_gqirm	2005-01-11 00:01:23.811168346 +1100
+++ foobar2-anton/arch/ppc64/kernel/smp.c	2005-01-11 00:01:48.100865839 +1100
@@ -22,9 +22,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
-#include <linux/smp_lock.h>
 #include <linux/interrupt.h>
-#include <linux/kernel_stat.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
@@ -38,12 +36,10 @@
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/smp.h>
 #include <asm/paca.h>
 #include <asm/time.h>
-#include <asm/ppcdebug.h>
 #include <asm/machdep.h>
 #include <asm/cputable.h>
 #include <asm/system.h>
@@ -58,7 +54,6 @@
 #endif
 
 int smp_threads_ready;
-unsigned long cache_decay_ticks;
 
 cpumask_t cpu_possible_map = CPU_MASK_NONE;
 cpumask_t cpu_online_map = CPU_MASK_NONE;
@@ -77,10 +72,6 @@ void smp_call_function_interrupt(void);
 
 int smt_enabled_at_boot = 1;
 
-/* Low level assembly function used to backup CPU 0 state */
-extern void __save_cpu_setup(void);
-
-
 #ifdef CONFIG_PPC_MULTIPLATFORM
 void smp_mpic_message_pass(int target, int msg)
 {
@@ -507,9 +498,6 @@ int __devinit start_secondary(void *unus
 	if (smp_ops->take_timebase)
 		smp_ops->take_timebase();
 
-	if (smp_ops->late_setup_cpu)
-		smp_ops->late_setup_cpu(cpu);
-
 	spin_lock(&call_lock);
 	cpu_set(cpu, cpu_online_map);
 	spin_unlock(&call_lock);
diff -puN arch/ppc64/kernel/xics.c~debug_gqirm arch/ppc64/kernel/xics.c
--- foobar2/arch/ppc64/kernel/xics.c~debug_gqirm	2005-01-11 00:01:23.817167888 +1100
+++ foobar2-anton/arch/ppc64/kernel/xics.c	2005-01-11 00:01:23.855164990 +1100
@@ -643,20 +643,16 @@ static void xics_set_affinity(unsigned i
 /* Interrupts are disabled. */
 void xics_migrate_irqs_away(void)
 {
-	int set_indicator = rtas_token("set-indicator");
-	const unsigned int giqs = 9005UL; /* Global Interrupt Queue Server */
-	int status = 0;
+	int status;
 	unsigned int irq, virq, cpu = smp_processor_id();
 
-	BUG_ON(set_indicator == RTAS_UNKNOWN_SERVICE);
-
 	/* Reject any interrupt that was queued to us... */
 	ops->cppr_info(cpu, 0);
 	iosync();
 
 	/* Refuse any new interrupts... */
-	rtas_call(set_indicator, 3, 1, &status, giqs,
-		  hard_smp_processor_id(), 0);
+	status = rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
+				    hard_smp_processor_id(), 0);
 	WARN_ON(status != 0);
 
 	/* Allow IPIs again... */
diff -puN include/asm-ppc64/machdep.h~debug_gqirm include/asm-ppc64/machdep.h
--- foobar2/include/asm-ppc64/machdep.h~debug_gqirm	2005-01-11 00:01:23.823167431 +1100
+++ foobar2-anton/include/asm-ppc64/machdep.h	2005-01-11 00:01:23.867164074 +1100
@@ -28,7 +28,6 @@ struct smp_ops_t {
 	int   (*probe)(void);
 	void  (*kick_cpu)(int nr);
 	void  (*setup_cpu)(int nr);
-	void  (*late_setup_cpu)(int nr);
 	void  (*take_timebase)(void);
 	void  (*give_timebase)(void);
 };
diff -puN include/asm-ppc64/rtas.h~debug_gqirm include/asm-ppc64/rtas.h
--- foobar2/include/asm-ppc64/rtas.h~debug_gqirm	2005-01-11 00:01:23.829166973 +1100
+++ foobar2-anton/include/asm-ppc64/rtas.h	2005-01-11 00:01:23.874163540 +1100
@@ -241,4 +241,6 @@ extern void rtas_stop_self(void);
 /* RMO buffer reserved for user-space RTAS use */
 extern unsigned long rtas_rmo_buf;
 
+#define GLOBAL_INTERRUPT_QUEUE 9005
+
 #endif /* _PPC64_RTAS_H */
diff -puN include/asm-ppc64/xics.h~debug_gqirm include/asm-ppc64/xics.h
--- foobar2/include/asm-ppc64/xics.h~debug_gqirm	2005-01-11 00:01:23.834166591 +1100
+++ foobar2-anton/include/asm-ppc64/xics.h	2005-01-11 00:01:23.868163998 +1100
@@ -18,6 +18,8 @@ void xics_init_IRQ(void);
 int xics_get_irq(struct pt_regs *);
 void xics_setup_cpu(void);
 void xics_cause_IPI(int cpu);
+void xics_request_IPIs(void);
+void xics_migrate_irqs_away(void);
 
 /* first argument is ignored for now*/
 void pSeriesLP_cppr_info(int n_cpu, u8 value);
@@ -28,4 +30,6 @@ struct xics_ipi_struct {
 
 extern struct xics_ipi_struct xics_ipi_message[NR_CPUS] __cacheline_aligned;
 
+extern unsigned int default_distrib_server;
+
 #endif /* _PPC64_KERNEL_XICS_H */
_
