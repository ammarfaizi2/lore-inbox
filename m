Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVBFS5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVBFS5w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 13:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVBFS5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 13:57:52 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:53520 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261284AbVBFSoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 13:44:54 -0500
Date: Sun, 6 Feb 2005 19:44:52 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] smp{,boot}.c cleanups
Message-ID: <20050206184451.GX3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups on several architectures:
- make some needlessly global code static
- remove the following write-only (except for printk's) variables:
  - cache_decay_ticks
  - smp_threads_ready
  - cacheflush_time

I've only tried the compilation on i386, but I hope all mistakes I made 
are on unimportant architectures.  ;-)

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

Except for a rediff in one place due to an unrelated context change,this 
patch was already sent on:
- 16 Jan 2005

 arch/alpha/kernel/smp.c              |   11 -----------
 arch/i386/kernel/smpboot.c           |   27 ++++++---------------------
 arch/i386/mach-voyager/voyager_smp.c |   12 ------------
 arch/ia64/kernel/smpboot.c           |   15 ---------------
 arch/m32r/kernel/smpboot.c           |    5 -----
 arch/mips/kernel/smp.c               |   20 +-------------------
 arch/parisc/kernel/smp.c             |    4 ----
 arch/ppc/kernel/smp.c                |    2 --
 arch/ppc64/kernel/smp.c              |    2 --
 arch/s390/kernel/smp.c               |    3 ---
 arch/sh/kernel/smp.c                 |    3 ---
 arch/sparc/kernel/smp.c              |    3 ---
 arch/sparc/kernel/sun4d_smp.c        |    1 -
 arch/sparc/kernel/sun4m_smp.c        |    1 -
 arch/sparc64/kernel/smp.c            |   27 +++------------------------
 arch/um/kernel/smp.c                 |    6 ------
 arch/x86_64/kernel/smpboot.c         |   25 ++-----------------------
 include/asm-alpha/timex.h            |    1 -
 include/asm-arm/timex.h              |    2 --
 include/asm-arm26/timex.h            |    2 --
 include/asm-i386/smp.h               |    3 ---
 include/asm-i386/timex.h             |    2 --
 include/asm-m32r/timex.h             |    2 --
 include/asm-mips/timex.h             |    1 -
 include/asm-parisc/timex.h           |    2 --
 include/asm-ppc/timex.h              |    2 --
 include/asm-s390/timex.h             |    2 --
 include/asm-sh/timex.h               |    2 --
 include/asm-sh64/timex.h             |    2 --
 include/asm-sparc/timex.h            |    1 -
 include/asm-um/timex.h               |    2 --
 include/asm-x86_64/timex.h           |    2 --
 include/linux/sched.h                |    1 -
 include/linux/smp.h                  |    6 ------
 init/main.c                          |    1 -
 35 files changed, 12 insertions(+), 191 deletions(-)

--- linux-2.6.11-rc1-mm1-full/include/linux/sched.h.old	2005-01-16 04:51:35.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/linux/sched.h	2005-01-16 04:51:41.000000000 +0100
@@ -174,7 +174,6 @@
 extern void trap_init(void);
 extern void update_process_times(int user);
 extern void scheduler_tick(void);
-extern unsigned long cache_decay_ticks;
 
 /* Attach to any functions which should be ignored in wchan output. */
 #define __sched		__attribute__((__section__(".sched.text")))
--- linux-2.6.11-rc1-mm1-full/arch/i386/kernel/smpboot.c.old	2005-01-16 04:51:49.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/kernel/smpboot.c	2005-01-16 05:12:49.000000000 +0100
@@ -80,9 +80,6 @@
 			{ [0 ... NR_CPUS-1] = 0xff };
 EXPORT_SYMBOL(x86_cpu_to_apicid);
 
-/* Set when the idlers are all forked */
-int smp_threads_ready;
-
 /*
  * Trampoline 80x86 program as an array.
  */
@@ -95,6 +92,8 @@
 /* State of each CPU. */
 DEFINE_PER_CPU(int, cpu_state) = { 0 };
 
+static void map_cpu_to_logical_apicid(void);
+
 /*
  * Currently trivial. Write the real->protected mode
  * bootstrap into the page concerned. The caller
@@ -325,7 +324,7 @@
 
 static atomic_t init_deasserted;
 
-void __init smp_callin(void)
+static void __init smp_callin(void)
 {
 	int cpuid, phys_id;
 	unsigned long timeout;
@@ -416,7 +415,7 @@
 		synchronize_tsc_ap();
 }
 
-int cpucount;
+static int cpucount;
 
 /*
  * Activate a secondary processor.
@@ -510,7 +509,7 @@
 
 u8 cpu_2_logical_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
-void map_cpu_to_logical_apicid(void)
+static void map_cpu_to_logical_apicid(void)
 {
 	int cpu = smp_processor_id();
 	int apicid = logical_smp_processor_id();
@@ -519,7 +518,7 @@
 	map_cpu_to_node(cpu, apicid_to_node(apicid));
 }
 
-void unmap_cpu_to_logical_apicid(int cpu)
+static void unmap_cpu_to_logical_apicid(int cpu)
 {
 	cpu_2_logical_apicid[cpu] = BAD_APICID;
 	unmap_cpu_to_node(cpu);
@@ -851,9 +850,6 @@
 	return boot_error;
 }
 
-cycles_t cacheflush_time;
-unsigned long cache_decay_ticks;
-
 static void smp_tune_scheduling (void)
 {
 	unsigned long cachesize;       /* kB   */
@@ -874,7 +870,6 @@
 		 * this basically disables processor-affinity
 		 * scheduling on SMP without a TSC.
 		 */
-		cacheflush_time = 0;
 		return;
 	} else {
 		cachesize = boot_cpu_data.x86_cache_size;
@@ -882,17 +877,7 @@
 			cachesize = 16; /* Pentiums, 2x8kB cache */
 			bandwidth = 100;
 		}
-
-		cacheflush_time = (cpu_khz>>10) * (cachesize<<10) / bandwidth;
 	}
-
-	cache_decay_ticks = (long)cacheflush_time/cpu_khz + 1;
-
-	printk("per-CPU timeslice cutoff: %ld.%02ld usecs.\n",
-		(long)cacheflush_time/(cpu_khz/1000),
-		((long)cacheflush_time*100/(cpu_khz/1000)) % 100);
-	printk("task migration cache decay timeout: %ld msecs.\n",
-		cache_decay_ticks);
 }
 
 /*
--- linux-2.6.11-rc1-mm1-full/arch/i386/mach-voyager/voyager_smp.c.old	2005-01-16 04:52:32.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/i386/mach-voyager/voyager_smp.c	2005-01-16 05:13:00.000000000 +0100
@@ -38,10 +38,6 @@
 /* CPU IRQ affinity -- set to all ones initially */
 static unsigned long cpu_irq_affinity[NR_CPUS] __cacheline_aligned = { [0 ... NR_CPUS-1]  = ~0UL };
 
-/* Set when the idlers are all forked - Set in main.c but not actually
- * used by any other parts of the kernel */
-int smp_threads_ready = 0;
-
 /* per CPU data structure (for /proc/cpuinfo et al), visible externally
  * indexed physically */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
@@ -82,14 +78,6 @@
  * by scheduler but indexed physically */
 cpumask_t phys_cpu_present_map = CPU_MASK_NONE;
 
-/* estimate of time used to flush the SMP-local cache - used in
- * processor affinity calculations */
-cycles_t cacheflush_time = 0;
-
-/* cache decay ticks for scheduler---a fairly useless quantity for the
-   voyager system with its odd affinity and huge L3 cache */
-unsigned long cache_decay_ticks = 20;
-
 
 /* The internal functions */
 static void send_CPI(__u32 cpuset, __u8 cpi);
--- linux-2.6.11-rc1-mm1-full/arch/sparc64/kernel/smp.c.old	2005-01-16 04:52:49.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/sparc64/kernel/smp.c	2005-01-16 05:00:39.000000000 +0100
@@ -1056,9 +1056,6 @@
 	prof_counter(boot_cpu_id) = prof_multiplier(boot_cpu_id) = 1;
 }
 
-cycles_t cacheflush_time;
-unsigned long cache_decay_ticks;
-
 extern unsigned long cheetah_tune_scheduling(void);
 
 static void __init smp_tune_scheduling(void)
@@ -1079,10 +1076,8 @@
 	 * of moving a process from one cpu to another).
 	 */
 	printk("SMP: Calibrating ecache flush... ");
-	if (tlb_type == cheetah || tlb_type == cheetah_plus) {
-		cacheflush_time = cheetah_tune_scheduling();
-		goto report;
-	}
+	if (tlb_type == cheetah || tlb_type == cheetah_plus)
+		return;
 
 	cpu_find_by_instance(0, &cpu_node, NULL);
 	ecache_size = prom_getintdefault(cpu_node,
@@ -1125,24 +1120,8 @@
 
 		raw = (tick2 - tick1);
 
-		/* Dampen it a little, considering two processes
-		 * sharing the cache and fitting.
-		 */
-		cacheflush_time = (raw - (raw >> 2));
-
 		free_pages(orig_flush_base, order);
-	} else {
-		cacheflush_time = ((ecache_size << 2) +
-				   (ecache_size << 1));
-	}
-report:
-	/* Convert ticks/sticks to jiffies. */
-	cache_decay_ticks = cacheflush_time / timer_tick_offset;
-	if (cache_decay_ticks < 1)
-		cache_decay_ticks = 1;
-
-	printk("Using heuristic of %ld cycles, %ld ticks.\n",
-	       cacheflush_time, cache_decay_ticks);
+	}
 }
 
 /* /proc/profile writes can call this, don't __init it please. */
--- linux-2.6.11-rc1-mm1-full/arch/sparc/kernel/smp.c.old	2005-01-16 04:54:30.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/sparc/kernel/smp.c	2005-01-16 05:13:20.000000000 +0100
@@ -36,15 +36,12 @@
 
 volatile int smp_processors_ready = 0;
 int smp_num_cpus = 1;
-int smp_threads_ready=0;
 volatile unsigned long cpu_callin_map[NR_CPUS] __initdata = {0,};
 unsigned char boot_cpu_id = 0;
 unsigned char boot_cpu_id4 = 0; /* boot_cpu_id << 2 */
 int smp_activated = 0;
 volatile int __cpu_number_map[NR_CPUS];
 volatile int __cpu_logical_map[NR_CPUS];
-cycles_t cacheflush_time = 0; /* XXX */
-unsigned long cache_decay_ticks = 100;
 
 cpumask_t cpu_online_map = CPU_MASK_NONE;
 cpumask_t phys_cpu_present_map = CPU_MASK_NONE;
--- linux-2.6.11-rc1-mm1-full/arch/mips/kernel/smp.c.old	2005-01-16 04:54:56.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/mips/kernel/smp.c	2005-01-16 05:01:23.000000000 +0100
@@ -47,9 +47,6 @@
 EXPORT_SYMBOL(phys_cpu_present_map);
 EXPORT_SYMBOL(cpu_online_map);
 
-cycles_t cacheflush_time;
-unsigned long cache_decay_ticks;
-
 static void smp_tune_scheduling (void)
 {
 	struct cache_desc *cd = &current_cpu_data.scache;
@@ -72,25 +69,10 @@
 	 *  L1 cache), on PIIs it's around 50-100 usecs, depending on
 	 *  the cache size)
 	 */
-	if (!cpu_khz) {
-		/*
-		 * This basically disables processor-affinity scheduling on SMP
-		 * without a cycle counter.  Currently all SMP capable MIPS
-		 * processors have a cycle counter.
-		 */
-		cacheflush_time = 0;
+	if (!cpu_khz)
 		return;
-	}
 
 	cachesize = cd->linesz * cd->sets * cd->ways;
-	cacheflush_time = (cpu_khz>>10) * (cachesize<<10) / bandwidth;
-	cache_decay_ticks = (long)cacheflush_time/cpu_khz * HZ / 1000;
-
-	printk("per-CPU timeslice cutoff: %ld.%02ld usecs.\n",
-		(long)cacheflush_time/(cpu_khz/1000),
-		((long)cacheflush_time*100/(cpu_khz/1000)) % 100);
-	printk("task migration cache decay timeout: %ld msecs.\n",
-		(cache_decay_ticks + 1) * 1000 / HZ);
 }
 
 extern void __init calibrate_delay(void);
--- linux-2.6.11-rc1-mm1-full/arch/sh/kernel/smp.c.old	2005-01-16 04:55:16.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/sh/kernel/smp.c	2005-01-16 05:13:55.000000000 +0100
@@ -34,14 +34,12 @@
  * but is designed to be usable regardless if there's an MMU
  * present or not.
  */
-int smp_threads_ready = 0;
 struct sh_cpuinfo cpu_data[NR_CPUS];
 
 extern void per_cpu_trap_init(void);
 
 cpumask_t cpu_possible_map;
 cpumask_t cpu_online_map;
-unsigned long cache_decay_ticks = HZ / 100;
 static atomic_t cpus_booted = ATOMIC_INIT(0);
 
 /* These are defined by the board-specific code. */
@@ -129,7 +127,6 @@
 
 void __init smp_cpus_done(unsigned int max_cpus)
 {
-	smp_threads_ready = 1;
 	smp_mb();
 }
 
--- linux-2.6.11-rc1-mm1-full/arch/ia64/kernel/smpboot.c.old	2005-01-16 04:55:28.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/ia64/kernel/smpboot.c	2005-01-16 04:55:58.000000000 +0100
@@ -427,26 +427,12 @@
 {
 	int ticks;
 	get_option (&str, &ticks);
-	cache_decay_ticks = ticks;
 	return 1;
 }
 
 __setup("decay=", decay);
 
 /*
- * # of ticks an idle task is considered cache-hot.  Highly application-dependent.  There
- * are apps out there which are known to suffer significantly with values >= 4.
- */
-unsigned long cache_decay_ticks = 10;	/* equal to MIN_TIMESLICE */
-
-static void
-smp_tune_scheduling (void)
-{
-	printk(KERN_INFO "task migration cache decay timeout: %ld msecs.\n",
-	       (cache_decay_ticks + 1) * 1000 / HZ);
-}
-
-/*
  * Initialize the logical CPU number to SAPICID mapping
  */
 void __init
@@ -544,7 +530,6 @@
 	printk(KERN_INFO "Boot processor id 0x%x/0x%x\n", 0, boot_cpu_id);
 
 	current_thread_info()->cpu = 0;
-	smp_tune_scheduling();
 
 	/*
 	 * If SMP should be disabled, then really disable it!
--- linux-2.6.11-rc1-mm1-full/arch/alpha/kernel/smp.c.old	2005-01-16 04:56:07.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/alpha/kernel/smp.c	2005-01-16 05:01:39.000000000 +0100
@@ -78,8 +78,6 @@
 
 int smp_num_probed;		/* Internal processor count */
 int smp_num_cpus = 1;		/* Number that came online.  */
-cycles_t cacheflush_time;
-unsigned long cache_decay_ticks;
 
 extern void calibrate_delay(void);
 
@@ -217,15 +215,6 @@
 	}
 
 	freq = hwrpb->cycle_freq ? : est_cycle_freq;
-
-	cacheflush_time = (freq / 1000000) * (on_chip_cache << 10) / bandwidth;
-	cache_decay_ticks = cacheflush_time / (freq / 1000) * HZ / 1000;
-
-	printk("per-CPU timeslice cutoff: %ld.%02ld usecs.\n",
-	       cacheflush_time/(freq/1000000),
-	       (cacheflush_time*100/(freq/1000000)) % 100);
-	printk("task migration cache decay timeout: %ld msecs.\n",
-	       (cache_decay_ticks + 1) * 1000 / HZ);
 }
 
 /* Wait until hwrpb->txrdy is clear for cpu.  Return -1 on timeout.  */
--- linux-2.6.11-rc1-mm1-full/arch/um/kernel/smp.c.old	2005-01-16 04:56:29.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/um/kernel/smp.c	2005-01-16 05:16:11.000000000 +0100
@@ -41,15 +41,9 @@
  */
 struct cpuinfo_um cpu_data[NR_CPUS];
 
-/* Set when the idlers are all forked */
-int smp_threads_ready = 0;
-
 /* A statistic, can be a little off */
 int num_reschedules_sent = 0;
 
-/* Small, random number, never changed */
-unsigned long cache_decay_ticks = 5;
-
 /* Not changed after boot */
 struct task_struct *idle_threads[NR_CPUS];
 
--- linux-2.6.11-rc1-mm1-full/arch/parisc/kernel/smp.c.old	2005-01-16 04:56:43.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/parisc/kernel/smp.c	2005-01-16 04:56:51.000000000 +0100
@@ -60,8 +60,6 @@
 
 static volatile int cpu_now_booting = 0;	/* track which CPU is booting */
 
-unsigned long cache_decay_ticks;	/* declared by include/linux/sched.h */
-
 static int parisc_max_cpus = 1;
 
 /* online cpus are ones that we've managed to bring up completely
@@ -583,8 +581,6 @@
 
 	cpu_set(bootstrap_processor, cpu_online_map);
 	cpu_set(bootstrap_processor, cpu_present_map);
-
-	cache_decay_ticks = HZ/100;	/* FIXME very rough.  */
 }
 
 
--- linux-2.6.11-rc1-mm1-full/arch/m32r/kernel/smpboot.c.old	2005-01-16 04:57:01.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/m32r/kernel/smpboot.c	2005-01-16 05:16:20.000000000 +0100
@@ -81,9 +81,6 @@
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_m32r cpu_data[NR_CPUS] __cacheline_aligned;
 
-/* Set when the idlers are all forked */
-int smp_threads_ready;
-
 static int cpucount;
 static cpumask_t smp_commenced_mask;
 
@@ -106,8 +103,6 @@
 
 static unsigned int calibration_result;
 
-unsigned long cache_decay_ticks = HZ / 100;
-
 /*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
 /* Function Prototypes                                                       */
 /*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
--- linux-2.6.11-rc1-mm1-full/arch/x86_64/kernel/smpboot.c.old	2005-01-16 04:57:14.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/x86_64/kernel/smpboot.c	2005-01-16 05:16:29.000000000 +0100
@@ -70,9 +70,6 @@
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_x86 cpu_data[NR_CPUS] __cacheline_aligned;
 
-/* Set when the idlers are all forked */
-int smp_threads_ready;
-
 cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
 
 /*
@@ -249,7 +246,7 @@
 
 static atomic_t init_deasserted;
 
-void __init smp_callin(void)
+static void __init smp_callin(void)
 {
 	int cpuid, phys_id;
 	unsigned long timeout;
@@ -338,7 +335,7 @@
 		synchronize_tsc_ap();
 }
 
-int cpucount;
+static int cpucount;
 
 /*
  * Activate a secondary processor.
@@ -661,9 +658,6 @@
 	}
 }
 
-cycles_t cacheflush_time;
-unsigned long cache_decay_ticks;
-
 static void smp_tune_scheduling (void)
 {
 	int cachesize;       /* kB   */
@@ -680,11 +674,6 @@
 	 */
 
 	if (!cpu_khz) {
-		/*
-		 * this basically disables processor-affinity
-		 * scheduling on SMP without a TSC.
-		 */
-		cacheflush_time = 0;
 		return;
 	} else {
 		cachesize = boot_cpu_data.x86_cache_size;
@@ -692,17 +681,7 @@
 			cachesize = 16; /* Pentiums, 2x8kB cache */
 			bandwidth = 100;
 		}
-
-		cacheflush_time = (cpu_khz>>10) * (cachesize<<10) / bandwidth;
 	}
-
-	cache_decay_ticks = (long)cacheflush_time/cpu_khz * HZ / 1000;
-
-	printk(KERN_INFO "per-CPU timeslice cutoff: %ld.%02ld usecs.\n",
-		(long)cacheflush_time/(cpu_khz/1000),
-		((long)cacheflush_time*100/(cpu_khz/1000)) % 100);
-	printk(KERN_INFO "task migration cache decay timeout: %ld msecs.\n",
-		(cache_decay_ticks + 1) * 1000 / HZ);
 }
 
 /*
--- linux-2.6.11-rc1-mm1-full/arch/s390/kernel/smp.c.old	2005-01-16 04:57:31.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/s390/kernel/smp.c	2005-01-16 05:16:39.000000000 +0100
@@ -50,12 +50,9 @@
  */
 
 struct _lowcore *lowcore_ptr[NR_CPUS];
-cycles_t         cacheflush_time=0;
-int              smp_threads_ready=0;      /* Set when the idlers are all forked. */
 
 cpumask_t cpu_online_map;
 cpumask_t cpu_possible_map;
-unsigned long    cache_decay_ticks = 0;
 
 static struct task_struct *current_set[NR_CPUS];
 
--- linux-2.6.11-rc1-mm1-full/include/asm-mips/timex.h.old	2005-01-16 05:03:28.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-mips/timex.h	2005-01-16 05:03:32.000000000 +0100
@@ -45,7 +45,6 @@
  */
 
 typedef unsigned int cycles_t;
-extern cycles_t cacheflush_time;
 
 static inline cycles_t get_cycles (void)
 {
--- linux-2.6.11-rc1-mm1-full/include/asm-parisc/timex.h.old	2005-01-16 05:03:47.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-parisc/timex.h	2005-01-16 05:03:51.000000000 +0100
@@ -12,8 +12,6 @@
 
 typedef unsigned long cycles_t;
 
-extern cycles_t cacheflush_time;
-
 static inline cycles_t get_cycles (void)
 {
 	return mfctl(16);
--- linux-2.6.11-rc1-mm1-full/include/asm-x86_64/timex.h.old	2005-01-16 05:03:59.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-x86_64/timex.h	2005-01-16 05:04:02.000000000 +0100
@@ -16,8 +16,6 @@
 
 typedef unsigned long long cycles_t;
 
-extern cycles_t cacheflush_time;
-
 static inline cycles_t get_cycles (void)
 {
 	unsigned long long ret;
--- linux-2.6.11-rc1-mm1-full/include/asm-arm/timex.h.old	2005-01-16 05:04:10.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-arm/timex.h	2005-01-16 05:04:13.000000000 +0100
@@ -16,8 +16,6 @@
 
 typedef unsigned long cycles_t;
 
-extern cycles_t cacheflush_time;
-
 static inline cycles_t get_cycles (void)
 {
 	return 0;
--- linux-2.6.11-rc1-mm1-full/include/asm-ppc/timex.h.old	2005-01-16 05:04:21.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-ppc/timex.h	2005-01-16 05:04:24.000000000 +0100
@@ -19,8 +19,6 @@
  * Currently only used on SMP.
  */
 
-extern cycles_t cacheflush_time;
-
 static inline cycles_t get_cycles(void)
 {
 	cycles_t ret = 0;
--- linux-2.6.11-rc1-mm1-full/include/asm-um/timex.h.old	2005-01-16 05:04:32.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-um/timex.h	2005-01-16 05:04:36.000000000 +0100
@@ -3,8 +3,6 @@
 
 typedef unsigned long cycles_t;
 
-#define cacheflush_time (0)
-
 static inline cycles_t get_cycles (void)
 {
 	return 0;
--- linux-2.6.11-rc1-mm1-full/include/asm-alpha/timex.h.old	2005-01-16 05:04:45.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-alpha/timex.h	2005-01-16 05:04:54.000000000 +0100
@@ -20,7 +20,6 @@
  */
 
 typedef unsigned int cycles_t;
-extern cycles_t cacheflush_time;
 
 static inline cycles_t get_cycles (void)
 {
--- linux-2.6.11-rc1-mm1-full/include/asm-sh64/timex.h.old	2005-01-16 05:05:01.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-sh64/timex.h	2005-01-16 05:05:04.000000000 +0100
@@ -23,8 +23,6 @@
 
 typedef unsigned long cycles_t;
 
-extern cycles_t cacheflush_time;
-
 static __inline__ cycles_t get_cycles (void)
 {
 	return 0;
--- linux-2.6.11-rc1-mm1-full/include/asm-sparc/timex.h.old	2005-01-16 05:05:15.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-sparc/timex.h	2005-01-16 05:05:23.000000000 +0100
@@ -10,7 +10,6 @@
 
 /* XXX Maybe do something better at some point... -DaveM */
 typedef unsigned long cycles_t;
-extern cycles_t cacheflush_time;
 #define get_cycles()	(0)
 
 #endif
--- linux-2.6.11-rc1-mm1-full/include/asm-m32r/timex.h.old	2005-01-16 05:05:32.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-m32r/timex.h	2005-01-16 05:05:50.000000000 +0100
@@ -25,8 +25,6 @@
 
 typedef unsigned long long cycles_t;
 
-extern cycles_t cacheflush_time;
-
 static __inline__ cycles_t get_cycles (void)
 {
 	return 0;
--- linux-2.6.11-rc1-mm1-full/include/asm-i386/timex.h.old	2005-01-16 05:06:00.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-i386/timex.h	2005-01-16 05:06:07.000000000 +0100
@@ -32,8 +32,6 @@
  */
 typedef unsigned long long cycles_t;
 
-extern cycles_t cacheflush_time;
-
 static inline cycles_t get_cycles (void)
 {
 	unsigned long long ret=0;
--- linux-2.6.11-rc1-mm1-full/include/asm-s390/timex.h.old	2005-01-16 05:06:15.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-s390/timex.h	2005-01-16 05:06:19.000000000 +0100
@@ -15,8 +15,6 @@
 
 typedef unsigned long long cycles_t;
 
-extern cycles_t cacheflush_time;
-
 static inline cycles_t get_cycles(void)
 {
 	cycles_t cycles;
--- linux-2.6.11-rc1-mm1-full/include/asm-arm26/timex.h.old	2005-01-16 05:06:34.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-arm26/timex.h	2005-01-16 05:06:40.000000000 +0100
@@ -21,8 +21,6 @@
 
 typedef unsigned long cycles_t;
 
-extern cycles_t cacheflush_time;
-
 static inline cycles_t get_cycles (void)
 {
 	return 0;
--- linux-2.6.11-rc1-mm1-full/include/asm-sh/timex.h.old	2005-01-16 05:06:47.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-sh/timex.h	2005-01-16 05:06:51.000000000 +0100
@@ -10,8 +10,6 @@
 
 typedef unsigned long long cycles_t;
 
-extern cycles_t cacheflush_time;
-
 static __inline__ cycles_t get_cycles (void)
 {
 	return 0;
--- linux-2.6.11-rc1-mm1-full/include/asm-i386/smp.h.old	2005-01-16 05:09:03.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/asm-i386/smp.h	2005-01-16 05:09:10.000000000 +0100
@@ -62,9 +62,6 @@
 	return cpus_weight(cpu_callout_map);
 }
 
-extern void map_cpu_to_logical_apicid(void);
-extern void unmap_cpu_to_logical_apicid(int cpu);
-
 #ifdef CONFIG_X86_LOCAL_APIC
 
 #ifdef APIC_DEFINITION
--- linux-2.6.11-rc1-mm1-full/arch/sparc/kernel/sun4d_smp.c.old	2005-01-16 05:13:05.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/sparc/kernel/sun4d_smp.c	2005-01-16 05:13:12.000000000 +0100
@@ -45,7 +45,6 @@
 extern volatile int smp_processors_ready;
 extern int smp_num_cpus;
 static int smp_highest_cpu;
-extern int smp_threads_ready;
 extern volatile unsigned long cpu_callin_map[NR_CPUS];
 extern struct cpuinfo_sparc cpu_data[NR_CPUS];
 extern unsigned char boot_cpu_id;
--- linux-2.6.11-rc1-mm1-full/arch/sparc/kernel/sun4m_smp.c.old	2005-01-16 05:13:28.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/sparc/kernel/sun4m_smp.c	2005-01-16 05:13:32.000000000 +0100
@@ -41,7 +41,6 @@
 
 extern volatile int smp_processors_ready;
 extern int smp_num_cpus;
-extern int smp_threads_ready;
 extern volatile unsigned long cpu_callin_map[NR_CPUS];
 extern unsigned char boot_cpu_id;
 extern int smp_activated;
--- linux-2.6.11-rc1-mm1-full/include/linux/smp.h.old	2005-01-16 05:16:49.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/include/linux/smp.h	2005-01-16 05:17:07.000000000 +0100
@@ -71,11 +71,6 @@
 	return ret;
 }
 
-/*
- * True once the per process idle is forked
- */
-extern int smp_threads_ready;
-
 #define MSG_ALL_BUT_SELF	0x8000	/* Assume <32768 CPU's */
 #define MSG_ALL			0x8001
 
@@ -102,7 +97,6 @@
 # define smp_processor_id()			0
 #endif
 #define hard_smp_processor_id()			0
-#define smp_threads_ready			1
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 #define on_each_cpu(func,info,retry,wait)	({ func(info); 0; })
 static inline void smp_send_reschedule(int cpu) { }
--- linux-2.6.11-rc1-mm1-full/init/main.c.old	2005-01-16 05:17:14.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/init/main.c	2005-01-16 05:17:22.000000000 +0100
@@ -353,7 +353,6 @@
 #if 0
 	/* Get other processors into their bootup holding patterns. */
 
-	smp_threads_ready=1;
 	smp_commence();
 #endif
 }
--- linux-2.6.11-rc1-mm1-full/arch/ppc64/kernel/smp.c.old	2005-01-16 07:21:45.000000000 +0100
+++ linux-2.6.11-rc1-mm1-full/arch/ppc64/kernel/smp.c	2005-01-16 07:21:58.000000000 +0100
@@ -53,8 +53,6 @@
 #define DBG(fmt...)
 #endif
 
-int smp_threads_ready;
-
 cpumask_t cpu_possible_map = CPU_MASK_NONE;
 cpumask_t cpu_online_map = CPU_MASK_NONE;
 cpumask_t cpu_sibling_map[NR_CPUS] = { [0 ... NR_CPUS-1] = CPU_MASK_NONE };

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--- linux-2.6.11-rc3-mm1-full/arch/ppc/kernel/smp.c.old	2005-02-06 16:23:16.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/arch/ppc/kernel/smp.c	2005-02-06 16:23:38.000000000 +0100
@@ -35,14 +35,12 @@
 #include <asm/tlbflush.h>
 #include <asm/xmon.h>
 
-int smp_threads_ready;
 volatile int smp_commenced;
 int smp_tb_synchronized;
 struct cpuinfo_PPC cpu_data[NR_CPUS];
 struct klock_info_struct klock_info = { KLOCK_CLEAR, 0 };
 atomic_t ipi_recv;
 atomic_t ipi_sent;
-unsigned long cache_decay_ticks = HZ/100;
 cpumask_t cpu_online_map;
 cpumask_t cpu_possible_map;
 int smp_hw_index[NR_CPUS];
