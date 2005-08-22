Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbVHVXIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVHVXIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 19:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVHVXIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 19:08:48 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:64143 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932359AbVHVXIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 19:08:20 -0400
Date: Mon, 22 Aug 2005 02:57:49 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill smp_tune_scheduling()
Message-ID: <20050822005749.GG5726@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since all remaining smp_tune_scheduling()'s are now empty (except for 
the useless setting of function-local variables), we can completely 
remove them.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/smpboot.c           |   31 ---------------------------
 arch/i386/mach-voyager/voyager_smp.c |    4 ---
 arch/m32r/kernel/smpboot.c           |    8 ------
 arch/mips/kernel/smp.c               |   29 -------------------------
 4 files changed, 72 deletions(-)

--- linux-2.6.12-rc2-mm1-full/arch/mips/kernel/smp.c.old	2005-04-05 16:53:13.000000000 +0200
+++ linux-2.6.12-rc2-mm1-full/arch/mips/kernel/smp.c	2005-04-05 16:53:35.000000000 +0200
@@ -46,34 +46,6 @@
 EXPORT_SYMBOL(phys_cpu_present_map);
 EXPORT_SYMBOL(cpu_online_map);
 
-static void smp_tune_scheduling (void)
-{
-	struct cache_desc *cd = &current_cpu_data.scache;
-	unsigned long cachesize;       /* kB   */
-	unsigned long bandwidth = 350; /* MB/s */
-	unsigned long cpu_khz;
-
-	/*
-	 * Crude estimate until we actually meassure ...
-	 */
-	cpu_khz = loops_per_jiffy * 2 * HZ / 1000;
-
-	/*
-	 * Rough estimation for SMP scheduling, this is the number of
-	 * cycles it takes for a fully memory-limited process to flush
-	 * the SMP-local cache.
-	 *
-	 * (For a P5 this pretty much means we will choose another idle
-	 *  CPU almost always at wakeup time (this is due to the small
-	 *  L1 cache), on PIIs it's around 50-100 usecs, depending on
-	 *  the cache size)
-	 */
-	if (!cpu_khz)
-		return;
-
-	cachesize = cd->linesz * cd->sets * cd->ways;
-}
-
 extern void __init calibrate_delay(void);
 extern ATTRIB_NORET void cpu_idle(void);
 
@@ -217,7 +189,6 @@
 	cpu_data[0].udelay_val = loops_per_jiffy;
 	init_new_context(current, &init_mm);
 	current_thread_info()->cpu = 0;
-	smp_tune_scheduling();
 	prom_prepare_cpus(max_cpus);
 }
 
--- linux-2.6.12-rc2-mm1-full/arch/i386/mach-voyager/voyager_smp.c.old	2005-04-05 16:54:07.000000000 +0200
+++ linux-2.6.12-rc2-mm1-full/arch/i386/mach-voyager/voyager_smp.c	2005-04-05 16:54:22.000000000 +0200
@@ -688,10 +688,6 @@
 	 * schedule at the moment */
 	//global_irq_holder = boot_cpu_id;
 
-	/* FIXME: Need to do something about this but currently only works
-	 * on CPUs with a tsc which none of mine have. 
-	smp_tune_scheduling();
-	 */
 	smp_store_cpu_info(boot_cpu_id);
 	printk("CPU%d: ", boot_cpu_id);
 	print_cpu_info(&cpu_data[boot_cpu_id]);
--- linux-2.6.12-rc2-mm1-full/arch/m32r/kernel/smpboot.c.old	2005-04-05 16:54:30.000000000 +0200
+++ linux-2.6.12-rc2-mm1-full/arch/m32r/kernel/smpboot.c	2005-04-05 16:54:42.000000000 +0200
@@ -109,7 +109,6 @@
 
 void smp_prepare_boot_cpu(void);
 void smp_prepare_cpus(unsigned int);
-static void smp_tune_scheduling(void);
 static void init_ipi_lock(void);
 static void do_boot_cpu(int);
 int __cpu_up(unsigned int);
@@ -185,7 +184,6 @@
 	 * Setup boot CPU information
 	 */
 	smp_store_cpu_info(0); /* Final full version of the data */
-	smp_tune_scheduling();
 
 	/*
 	 * If SMP should be disabled, then really disable it!
@@ -229,11 +227,6 @@
 	Dprintk("Boot done.\n");
 }
 
-static void __init smp_tune_scheduling(void)
-{
-	/* Nothing to do. */
-}
-
 /*
  * init_ipi_lock : Initialize IPI locks.
  */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--- linux-2.6.13-rc6-mm1-modular/arch/i386/kernel/smpboot.c.old	2005-08-22 02:55:50.000000000 +0200
+++ linux-2.6.13-rc6-mm1-modular/arch/i386/kernel/smpboot.c	2005-08-22 02:56:08.000000000 +0200
@@ -1034,36 +1034,6 @@
 }
 #endif
 
-static void smp_tune_scheduling (void)
-{
-	unsigned long cachesize;       /* kB   */
-	unsigned long bandwidth = 350; /* MB/s */
-	/*
-	 * Rough estimation for SMP scheduling, this is the number of
-	 * cycles it takes for a fully memory-limited process to flush
-	 * the SMP-local cache.
-	 *
-	 * (For a P5 this pretty much means we will choose another idle
-	 *  CPU almost always at wakeup time (this is due to the small
-	 *  L1 cache), on PIIs it's around 50-100 usecs, depending on
-	 *  the cache size)
-	 */
-
-	if (!cpu_khz) {
-		/*
-		 * this basically disables processor-affinity
-		 * scheduling on SMP without a TSC.
-		 */
-		return;
-	} else {
-		cachesize = boot_cpu_data.x86_cache_size;
-		if (cachesize == -1) {
-			cachesize = 16; /* Pentiums, 2x8kB cache */
-			bandwidth = 100;
-		}
-	}
-}
-
 /*
  * Cycle through the processors sending APIC IPIs to boot each.
  */
@@ -1092,7 +1062,6 @@
 	x86_cpu_to_apicid[0] = boot_cpu_physical_apicid;
 
 	current_thread_info()->cpu = 0;
-	smp_tune_scheduling();
 	cpus_clear(cpu_sibling_map[0]);
 	cpu_set(0, cpu_sibling_map[0]);
 
