Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbVKGUtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbVKGUtU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbVKGUtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:49:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:12307 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932370AbVKGUtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:49:19 -0500
Date: Mon, 7 Nov 2005 21:49:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill smp_tune_scheduling()
Message-ID: <20051107204918.GS3847@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since all remaining smp_tune_scheduling()'s are now empty (except for
the useless setting of function-local variables), we can completely
remove them.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 2 Nov 2005

 arch/i386/kernel/smpboot.c           |   31 ---------------------------
 arch/i386/mach-voyager/voyager_smp.c |    4 ---
 arch/m32r/kernel/smpboot.c           |    7 ------
 arch/mips/kernel/smp.c               |   28 ------------------------
 4 files changed, 70 deletions(-)

--- linux-2.6.14-rc5-mm1-full-2.95/arch/i386/kernel/smpboot.c.old	2005-11-02 02:57:42.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full-2.95/arch/i386/kernel/smpboot.c	2005-11-02 02:57:54.000000000 +0100
@@ -1062,40 +1062,10 @@
 	unlock_cpu_hotplug();
 	return ret;
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
 
 static int boot_cpu_logical_apicid;
@@ -1129,11 +1099,10 @@
 
 	boot_cpu_logical_apicid = logical_smp_processor_id();
 	x86_cpu_to_apicid[0] = boot_cpu_physical_apicid;
 
 	current_thread_info()->cpu = 0;
-	smp_tune_scheduling();
 
 	set_cpu_sibling_map(0);
 
 	map_cpu_to_logical_apicid();
 
--- linux-2.6.14-rc5-mm1-full-2.95/arch/i386/mach-voyager/voyager_smp.c.old	2005-11-02 02:58:03.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full-2.95/arch/i386/mach-voyager/voyager_smp.c	2005-11-02 02:58:15.000000000 +0100
@@ -697,14 +697,10 @@
 	voyager_extended_cpus = 1;
 	/* Remove the global_irq_holder setting, it triggers a BUG() on
 	 * schedule at the moment */
 	//global_irq_holder = boot_cpu_id;
 
-	/* FIXME: Need to do something about this but currently only works
-	 * on CPUs with a tsc which none of mine have. 
-	smp_tune_scheduling();
-	 */
 	smp_store_cpu_info(boot_cpu_id);
 	printk("CPU%d: ", boot_cpu_id);
 	print_cpu_info(&cpu_data[boot_cpu_id]);
 
 	if(is_cpu_quad()) {
--- linux-2.6.14-rc5-mm1-full-2.95/arch/m32r/kernel/smpboot.c.old	2005-11-02 02:58:23.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full-2.95/arch/m32r/kernel/smpboot.c	2005-11-02 02:58:34.000000000 +0100
@@ -108,11 +108,10 @@
 /* Function Prototypes                                                       */
 /*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
 
 void smp_prepare_boot_cpu(void);
 void smp_prepare_cpus(unsigned int);
-static void smp_tune_scheduling(void);
 static void init_ipi_lock(void);
 static void do_boot_cpu(int);
 int __cpu_up(unsigned int);
 void smp_cpus_done(unsigned int);
 
@@ -184,11 +183,10 @@
 
 	/*
 	 * Setup boot CPU information
 	 */
 	smp_store_cpu_info(0); /* Final full version of the data */
-	smp_tune_scheduling();
 
 	/*
 	 * If SMP should be disabled, then really disable it!
 	 */
 	if (!max_cpus) {
@@ -228,15 +226,10 @@
 
 smp_done:
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
 static void __init init_ipi_lock(void)
 {
--- linux-2.6.14-rc5-mm1-full-2.95/arch/mips/kernel/smp.c.old	2005-11-02 02:58:44.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full-2.95/arch/mips/kernel/smp.c	2005-11-02 02:58:53.000000000 +0100
@@ -44,37 +44,10 @@
 int __cpu_logical_map[NR_CPUS];		/* Map logical to physical */
 
 EXPORT_SYMBOL(phys_cpu_present_map);
 EXPORT_SYMBOL(cpu_online_map);
 
-static void smp_tune_scheduling (void)
-{
-	struct cache_desc *cd = &current_cpu_data.scache;
-	unsigned long cachesize;       /* kB   */
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
 
 /*
  * First C code run on the secondary CPUs after being started up by
@@ -232,11 +205,10 @@
 /* called from main before smp_init() */
 void __init smp_prepare_cpus(unsigned int max_cpus)
 {
 	init_new_context(current, &init_mm);
 	current_thread_info()->cpu = 0;
-	smp_tune_scheduling();
 	prom_prepare_cpus(max_cpus);
 }
 
 /* preload SMP state for boot cpu */
 void __devinit smp_prepare_boot_cpu(void)

