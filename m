Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVDDLij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVDDLij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 07:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVDDLij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 07:38:39 -0400
Received: from mx1.elte.hu ([157.181.1.137]:8926 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261222AbVDDLiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 07:38:04 -0400
Date: Mon, 4 Apr 2005 13:37:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Paul Jackson <pj@engr.sgi.com>, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Message-ID: <20050404113743.GA28994@elte.hu>
References: <20050403070415.GA18893@elte.hu> <200504040111.j341BUg31885@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <200504040111.j341BUg31885@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> Ingo Molnar wrote on Saturday, April 02, 2005 11:04 PM
> > the default on ia64 (32MB) was way too large and caused the search to
> > start from 64MB. That can take a _long_ time.
> >
> > i've attached a new patch with your changes included, and a couple of
> > new things added:
> >
> >  - removed the 32MB max_cache_size hack from ia64 - it should now fall
> >    back to the default 5MB and do a search from 10MB downwards. This
> >    should speed up the search.
> 
> The cache size information on ia64 is already available at the finger 
> tip. Here is a patch that I whipped up to set max_cache_size for ia64.

thanks - i've added this to my tree.

i've attached the latest snapshot. There are a number of changes in the 
patch: firstly, i changed the direction of the iteration to go from 
small sizes to larger sizes, and i added a method to detect the maximum.  

Furthermore, i tweaked the test some more to make it both faster and 
more reliable, and i cleaned up the code. (e.g. now we migrate via the 
scheduler, not via on_each_cpu().) The default patch should print enough 
debug information as-is.

I changed the workload too so potentially the detected values might be 
off from the ideal value on your box. The values detected on x86 are 
mostly unchanged, relative to previous patches.

	Ingo

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cache-hot-autodetect.patch"

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -47,6 +47,7 @@
 #include <linux/syscalls.h>
 #include <linux/times.h>
 #include <linux/acct.h>
+#include <linux/vmalloc.h>
 #include <asm/tlb.h>
 
 #include <asm/unistd.h>
@@ -4640,6 +4641,478 @@ void __devinit init_sched_build_groups(s
 }
 
 
+/*
+ * Self-tuning task migration cost measurement between source and target CPUs.
+ *
+ * This is done by measuring the cost of manipulating buffers of varying
+ * sizes. For a given buffer-size here are the steps that are taken:
+ *
+ * 1) the source CPU reads+dirties a shared buffer 
+ * 2) the target CPU reads+dirties the same shared buffer
+ *
+ * We measure how long they take, in the following 4 scenarios:
+ *
+ *  - source: CPU1, target: CPU2 | cost1
+ *  - source: CPU2, target: CPU1 | cost2
+ *  - source: CPU1, target: CPU1 | cost3
+ *  - source: CPU2, target: CPU2 | cost4
+ *
+ * We then calculate the cost3+cost4-cost1-cost2 difference - this is
+ * the cost of migration.
+ *
+ * We then start off from a small buffer-size and iterate up to larger
+ * buffer sizes, in 5% steps - measuring each buffer-size separately, and
+ * doing a maximum search for the cost. (The maximum cost for a migration
+ * normally occurs when the working set size is around the effective cache
+ * size.)
+ */
+#define SEARCH_SCOPE		2
+#define MIN_CACHE_SIZE		(64*1024U)
+#define DEFAULT_CACHE_SIZE	(5*1024*1024U)
+#define ITERATIONS		3
+#define SIZE_THRESH		130
+#define COST_THRESH		130
+
+/*
+ * The migration cost is a function of 'domain distance'. Domain
+ * distance is the number of steps a CPU has to iterate down its
+ * domain tree to share a domain with the other CPU. The farther
+ * two CPUs are from each other, the larger the distance gets.
+ *
+ * Note that we use the distance only to cache measurement results,
+ * the distance value is not used numerically otherwise. When two
+ * CPUs have the same distance it is assumed that the migration
+ * cost is the same. (this is a simplification but quite practical)
+ */
+#define MAX_DOMAIN_DISTANCE 32
+
+static __initdata unsigned long long migration_cost[MAX_DOMAIN_DISTANCE] =
+		{ -1LL , };
+
+/*
+ * Allow override of migration cost - in units of microseconds.
+ * E.g. migration_cost=1000,2000,3000 will set up a level-1 cost
+ * of 1 msec, level-2 cost of 2 msecs and level3 cost of 3 msecs:
+ */
+static int __init migration_cost_setup(char *str)
+{
+	int ints[MAX_DOMAIN_DISTANCE+1], i;
+
+	str = get_options(str, ARRAY_SIZE(ints), ints);
+
+	printk("#ints: %d\n", ints[0]);
+	for (i = 1; i <= ints[0]; i++) {
+		migration_cost[i-1] = (unsigned long long)ints[i]*1000;
+		printk("migration_cost[%d]: %Ld\n", i-1, migration_cost[i-1]);
+	}
+	return 1;
+}
+
+__setup ("migration_cost=", migration_cost_setup);
+
+/*
+ * Global multiplier (divisor) for migration-cutoff values,
+ * in percentiles. E.g. use a value of 150 to get 1.5 times
+ * longer cache-hot cutoff times.
+ *
+ * (We scale it from 100 to 128 to long long handling easier.)
+ */
+
+#define MIGRATION_FACTOR_SCALE 128
+
+static __initdata unsigned int migration_factor = MIGRATION_FACTOR_SCALE;
+
+static int __init setup_migration_factor(char *str)
+{
+	get_option(&str, &migration_factor);
+	migration_factor = migration_factor * MIGRATION_FACTOR_SCALE / 100;
+	return 1;
+}
+
+__setup("migration_factor=", setup_migration_factor);
+
+/*
+ * Estimated distance of two CPUs, measured via the number of domains
+ * we have to pass for the two CPUs to be in the same span:
+ */
+__init static unsigned long domain_distance(int cpu1, int cpu2)
+{
+	unsigned long distance = 0;
+	struct sched_domain *sd;
+
+	for_each_domain(cpu1, sd) {
+		WARN_ON(!cpu_isset(cpu1, sd->span));
+		if (cpu_isset(cpu2, sd->span))
+			return distance;
+		distance++;
+	}
+	if (distance >= MAX_DOMAIN_DISTANCE) {
+		WARN_ON(1);
+		distance = MAX_DOMAIN_DISTANCE-1;
+	}
+
+	return distance;
+}
+
+static __initdata unsigned int migration_debug = 1;
+
+static int __init setup_migration_debug(char *str)
+{
+	get_option(&str, &migration_debug);
+	return 1;
+}
+
+__setup("migration_debug=", setup_migration_debug);
+
+/*
+ * Maximum cache-size that the scheduler should try to measure.
+ * Architectures with larger caches should tune this up during
+ * bootup. Gets used in the domain-setup code (i.e. during SMP
+ * bootup).
+ */
+__initdata unsigned int max_cache_size;
+
+static int __init setup_max_cache_size(char *str)
+{
+	get_option(&str, &max_cache_size);
+	return 1;
+}
+
+__setup("max_cache_size=", setup_max_cache_size);
+
+/*
+ * Dirty a big buffer in a hard-to-predict (for the L2 cache) way. This
+ * is the operation that is timed, so we try to generate unpredictable
+ * cachemisses that still end up filling the L2 cache:
+ */
+__init static void touch_cache(void *__cache, unsigned long __size)
+{
+	unsigned long size = __size/sizeof(long), chunk1 = size/3,
+			chunk2 = 2*size/3;
+	unsigned long *cache = __cache;
+	int i;
+
+	for (i = 0; i < size/6; i += 8) {
+		switch (i % 6) {
+			case 0: cache[i]++;
+			case 1: cache[size-1-i]++;
+			case 2: cache[chunk1-i]++;
+			case 3: cache[chunk1+i]++;
+			case 4: cache[chunk2-i]++;
+			case 5: cache[chunk2+i]++;
+		}
+	}
+}
+
+/*
+ * Measure the cache-cost of one task migration. Returns in units of nsec.
+ */
+__init static unsigned long long measure_one(void *cache, unsigned long size,
+					     int source, int target)
+{
+	cpumask_t mask, saved_mask;
+	unsigned long long t0, t1, t2, t3, cost;
+
+	saved_mask = current->cpus_allowed;
+
+	/*
+	 * Migrate to the source CPU:
+	 */
+	mask = cpumask_of_cpu(source);
+	set_cpus_allowed(current, mask);
+	WARN_ON(smp_processor_id() != source);
+
+	/*
+	 * Dirty the working set:
+	 */
+	t0 = sched_clock();
+	touch_cache(cache, size);
+	t1 = sched_clock();
+
+	/*
+	 * Migrate to the target CPU, dirty the L2 cache and access
+	 * the shared buffer. (which represents the working set
+	 * of a migrated task.)
+	 */
+	mask = cpumask_of_cpu(target);
+	set_cpus_allowed(current, mask);
+	WARN_ON(smp_processor_id() != target);
+
+	t2 = sched_clock();
+	touch_cache(cache, size);
+	t3 = sched_clock();
+
+	cost = t2-t1 + t3-t2;
+
+	if (migration_debug >= 2)
+		printk("[%d->%d]: %8Ld %8Ld %8Ld => %10Ld.\n",
+			source, target, t1-t0, t2-t1, t3-t2, cost);
+
+	set_cpus_allowed(current, saved_mask);
+
+	return cost;
+}
+
+/*
+ * Measure a series of task migrations and return the average
+ * result. Since this code runs early during bootup the system
+ * is 'undisturbed' and the average latency makes sense.
+ *
+ * The algorithm in essence auto-detects the relevant cache-size,
+ * so it will properly detect different cachesizes for different
+ * cache-hierarchies, depending on how the CPUs are connected.
+ *
+ * Architectures can prime the upper limit of the search range via
+ * max_cache_size, otherwise the search range defaults to 20MB...64K.
+ */
+__init static unsigned long long
+measure_cost(int cpu1, int cpu2, void *cache, unsigned int size)
+{
+	unsigned long long cost1, cost2;
+	int i;
+
+	/*
+	 * Measure the migration cost of 'size' bytes, over an
+	 * average of 10 runs:
+	 *
+	 * (We perturb the cache size by a small (0..4k)
+	 *  value to compensate size/alignment related artifacts.
+	 *  We also subtract the cost of the operation done on
+	 *  the same CPU.)
+	 */
+	cost1 = 0;
+
+	/*
+	 * dry run, to make sure we start off cache-cold on cpu1,
+	 * and to get any vmalloc pagefaults in advance:
+	 */
+	measure_one(cache, size, cpu1, cpu2);
+	for (i = 0; i < ITERATIONS; i++)
+		cost1 += measure_one(cache, size - i*1024, cpu1, cpu2);
+
+	measure_one(cache, size, cpu2, cpu1);
+	for (i = 0; i < ITERATIONS; i++)
+		cost1 += measure_one(cache, size - i*1024, cpu2, cpu1);
+
+	/*
+	 * (We measure the non-migrating [cached] cost on both
+	 *  cpu1 and cpu2, to handle CPUs with different speeds)
+	 */
+	cost2 = 0;
+
+	measure_one(cache, size, cpu1, cpu1);
+	for (i = 0; i < ITERATIONS; i++)
+		cost2 += measure_one(cache, size - i*1024, cpu1, cpu1);
+
+	measure_one(cache, size, cpu2, cpu2);
+	for (i = 0; i < ITERATIONS; i++)
+		cost2 += measure_one(cache, size - i*1024, cpu2, cpu2);
+
+	/*
+	 * Get the per-iteration migration cost:
+	 */
+	do_div(cost1, 2*ITERATIONS);
+	do_div(cost2, 2*ITERATIONS);
+
+	return cost1 - cost2;
+}
+
+__init static unsigned long long measure_migration_cost(int cpu1, int cpu2)
+{
+	unsigned long long max_cost = 0, fluct = 0, avg_fluct = 0;
+	unsigned int max_size, size, size_found = 0;
+	long long cost = 0, prev_cost;
+	void *cache;
+
+	/*
+	 * Search from max_cache_size*5 down to 64K - the real relevant
+	 * cachesize has to lie somewhere inbetween.
+	 */
+	if (max_cache_size) {
+		max_size = max(max_cache_size * SEARCH_SCOPE, MIN_CACHE_SIZE);
+		size = max(max_cache_size / SEARCH_SCOPE, MIN_CACHE_SIZE);
+	} else {
+		/*
+		 * Since we have no estimation about the relevant
+		 * search range
+		 */
+		max_size = DEFAULT_CACHE_SIZE * SEARCH_SCOPE;
+		size = MIN_CACHE_SIZE;
+	}
+		
+	if (!cpu_online(cpu1) || !cpu_online(cpu2)) {
+		printk("cpu %d and %d not both online!\n", cpu1, cpu2);
+		return 0;
+	}
+
+	/*
+	 * Allocate the working set:
+	 */
+	cache = vmalloc(max_size);
+	if (!cache) {
+		printk("could not vmalloc %d bytes for cache!\n", 2*max_size);
+		return 1000000; // return 1 msec on very small boxen
+	}
+
+	while (size <= max_size) {
+		prev_cost = cost;
+		cost = measure_cost(cpu1, cpu2, cache, size);
+
+		/*
+		 * Update the max:
+		 */
+		if (cost > 0) {
+			if (max_cost < cost) {
+				max_cost = cost;
+				size_found = size;
+			}
+		}
+		/*
+		 * Calculate average fluctuation, we use this to prevent
+		 * noise from triggering an early break out of the loop:
+		 */
+		fluct = abs(cost - prev_cost);
+		avg_fluct = (avg_fluct + fluct)/2;
+
+		if (migration_debug)
+			printk("-> [%d][%d][%7d] %3ld.%ld [%3ld.%ld] (%ld): (%8Ld %8Ld)\n",
+				cpu1, cpu2, size,
+				(long)cost / 1000000,
+				((long)cost / 100000) % 10,
+				(long)max_cost / 1000000,
+				((long)max_cost / 100000) % 10,
+				domain_distance(cpu1, cpu2),
+				cost, avg_fluct);
+
+		/*
+		 * If we iterated at least 20% past the previous maximum,
+		 * and the cost has dropped by more than 20% already,
+		 * (taking fluctuations into account) then we assume to
+		 * have found the maximum and break out of the loop early:
+		 */
+		if (size_found && (size*100 > size_found*SIZE_THRESH))
+			if (cost+avg_fluct <= 0 ||
+				max_cost*100 > (cost+avg_fluct)*COST_THRESH) {
+
+				if (migration_debug)
+					printk("-> found max.\n");
+				break;
+			}
+		/*
+		 * Increase the cachesize in 5% steps:
+		 */
+		size = size * 20 / 19;
+	}
+
+	if (migration_debug)
+		printk("[%d][%d] working set size found: %d, cost: %Ld\n",
+			cpu1, cpu2, size_found, max_cost);
+
+	vfree(cache);
+
+	/*
+	 * A task is considered 'cache cold' if at least 2 times
+	 * the worst-case cost of migration has passed.
+	 *
+	 * (this limit is only listened to if the load-balancing
+	 * situation is 'nice' - if there is a large imbalance we
+	 * ignore it for the sake of CPU utilization and
+	 * processing fairness.)
+	 */
+	return 2 * max_cost * migration_factor / MIGRATION_FACTOR_SCALE;
+}
+
+void __devinit calibrate_migration_costs(void)
+{
+	int cpu1 = -1, cpu2 = -1, cpu;
+	struct sched_domain *sd;
+	unsigned long distance, max_distance = 0;
+	unsigned long long cost;
+	unsigned long flags, j0, j1;
+
+	local_irq_save(flags);
+	local_irq_enable();
+	j0 = jiffies;
+
+	/*
+	 * First pass - calculate the cacheflush times:
+	 */
+	for_each_online_cpu(cpu1) {
+		for_each_online_cpu(cpu2) {
+			if (cpu1 == cpu2)
+				continue;
+			distance = domain_distance(cpu1, cpu2);
+			max_distance = max(max_distance, distance);
+			/*
+			 * Do we have the result cached already?
+			 */
+			if (migration_cost[distance])
+				cost = migration_cost[distance];
+			else {
+				cost = measure_migration_cost(cpu1, cpu2);
+				migration_cost[distance] = cost;
+			}
+		}
+	}
+	/*
+	 * Second pass - update the sched domain hierarchy with
+	 * the new cache-hot-time estimations:
+	 */
+	for_each_online_cpu(cpu) {
+		distance = 0;
+		for_each_domain(cpu, sd) {
+			sd->cache_hot_time = migration_cost[distance];
+			distance++;
+		}
+	}
+	/*
+	 * Print the matrix:
+	 */
+	printk("---------------------\n");
+	printk("| migration cost matrix (max_cache_size: %d, cpu: %ld MHz):\n",
+			max_cache_size,
+#ifdef CONFIG_X86
+			cpu_khz/1000
+#else
+			-1L
+#endif
+		);
+	printk("---------------------\n");
+	printk("      ");
+	for_each_online_cpu(cpu1)
+		printk("    [%02d]", cpu1);
+	printk("\n");
+	for_each_online_cpu(cpu1) {
+		printk("[%02d]: ", cpu1);
+		for_each_online_cpu(cpu2) {
+			if (cpu1 == cpu2) {
+				printk("    -   ");
+				continue;
+			}
+			distance = domain_distance(cpu1, cpu2);
+			max_distance = max(max_distance, distance);
+			cost = migration_cost[distance];
+			printk(" %2ld.%ld(%ld)", (long)cost / 1000000,
+				((long)cost / 100000) % 10, distance);
+		}
+		printk("\n");
+	}
+	printk("--------------------------------\n");
+	printk("| cacheflush times [%ld]:", max_distance+1);
+	for (distance = 0; distance <= max_distance; distance++) {
+		cost = migration_cost[distance];
+		printk(" %ld.%ld (%Ld)", (long)cost / 1000000,
+			((long)cost / 100000) % 10, cost);
+	}
+	printk("\n");
+	j1 = jiffies;
+	printk("| calibration delay: %ld seconds\n", (j1-j0)/HZ);
+	printk("--------------------------------\n");
+
+	local_irq_restore(flags);
+}
+
+
 #ifdef ARCH_HAS_SCHED_DOMAIN
 extern void __devinit arch_init_sched_domains(void);
 extern void __devinit arch_destroy_sched_domains(void);
@@ -4820,6 +5293,10 @@ static void __devinit arch_init_sched_do
 #endif
 		cpu_attach_domain(sd, i);
 	}
+	/*
+	 * Tune cache-hot values:
+	 */
+	calibrate_migration_costs();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
--- linux/arch/ia64/kernel/domain.c.orig
+++ linux/arch/ia64/kernel/domain.c
@@ -358,6 +358,10 @@ next_sg:
 #endif
 		cpu_attach_domain(sd, i);
 	}
+	/*
+	 * Tune cache-hot values:
+	 */
+	calibrate_migration_costs();
 }
 
 void __devinit arch_destroy_sched_domains(void)
--- linux/arch/ia64/kernel/setup.c.orig
+++ linux/arch/ia64/kernel/setup.c
@@ -561,6 +561,7 @@ static void
 get_max_cacheline_size (void)
 {
 	unsigned long line_size, max = 1;
+	unsigned int cache_size = 0;
 	u64 l, levels, unique_caches;
         pal_cache_config_info_t cci;
         s64 status;
@@ -585,8 +586,11 @@ get_max_cacheline_size (void)
 		line_size = 1 << cci.pcci_line_size;
 		if (line_size > max)
 			max = line_size;
+		if (cache_size < cci.pcci_cache_size)
+			cache_size = cci.pcci_cache_size;
         }
   out:
+	max_cache_size = max(max_cache_size, cache_size);
 	if (max > ia64_max_cacheline_size)
 		ia64_max_cacheline_size = max;
 }
--- linux/arch/i386/kernel/smpboot.c.orig
+++ linux/arch/i386/kernel/smpboot.c
@@ -873,6 +873,7 @@ static void smp_tune_scheduling (void)
 			cachesize = 16; /* Pentiums, 2x8kB cache */
 			bandwidth = 100;
 		}
+		max_cache_size = cachesize * 1024;
 	}
 }
 
--- linux/include/asm-ia64/topology.h.orig
+++ linux/include/asm-ia64/topology.h
@@ -51,7 +51,6 @@ void build_cpu_to_node_map(void);
 	.max_interval		= 320,			\
 	.busy_factor		= 320,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
@@ -73,7 +72,6 @@ void build_cpu_to_node_map(void);
 	.max_interval		= 320,			\
 	.busy_factor		= 320,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
--- linux/include/linux/topology.h.orig
+++ linux/include/linux/topology.h
@@ -86,7 +86,6 @@
 	.max_interval		= 2,			\
 	.busy_factor		= 8,			\
 	.imbalance_pct		= 110,			\
-	.cache_hot_time		= 0,			\
 	.cache_nice_tries	= 0,			\
 	.per_cpu_gain		= 25,			\
 	.flags			= SD_LOAD_BALANCE	\
@@ -112,7 +111,6 @@
 	.max_interval		= 4,			\
 	.busy_factor		= 64,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (5*1000000/2),	\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
--- linux/include/linux/sched.h.orig
+++ linux/include/linux/sched.h
@@ -527,7 +527,17 @@ extern cpumask_t cpu_isolated_map;
 extern void init_sched_build_groups(struct sched_group groups[],
 	                        cpumask_t span, int (*group_fn)(int cpu));
 extern void cpu_attach_domain(struct sched_domain *sd, int cpu);
+
 #endif /* ARCH_HAS_SCHED_DOMAIN */
+
+/*
+ * Maximum cache size the migration-costs auto-tuning code will
+ * search from:
+ */
+extern unsigned int max_cache_size;
+
+extern void calibrate_migration_costs(void);
+
 #endif /* CONFIG_SMP */
 
 
--- linux/include/asm-i386/topology.h.orig
+++ linux/include/asm-i386/topology.h
@@ -75,7 +75,6 @@ static inline cpumask_t pcibus_to_cpumas
 	.max_interval		= 32,			\
 	.busy_factor		= 32,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
--- linux/include/asm-ppc64/topology.h.orig
+++ linux/include/asm-ppc64/topology.h
@@ -46,7 +46,6 @@ static inline int node_to_first_cpu(int 
 	.max_interval		= 32,			\
 	.busy_factor		= 32,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
--- linux/include/asm-x86_64/topology.h.orig
+++ linux/include/asm-x86_64/topology.h
@@ -48,7 +48,6 @@ static inline cpumask_t __pcibus_to_cpum
 	.max_interval		= 32,			\
 	.busy_factor		= 32,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000000),		\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
--- linux/include/asm-mips/mach-ip27/topology.h.orig
+++ linux/include/asm-mips/mach-ip27/topology.h
@@ -24,7 +24,6 @@ extern unsigned char __node_distances[MA
 	.max_interval		= 32,			\
 	.busy_factor		= 32,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000),		\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\

--HlL+5n6rz5pIUxbD--
