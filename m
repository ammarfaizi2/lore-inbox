Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVDBO4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVDBO4D (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 09:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVDBOzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 09:55:52 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48071 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261530AbVDBOyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 09:54:10 -0500
Date: Sat, 2 Apr 2005 16:53:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch] sched: auto-tune migration costs [was: Re: Industry db benchmark result on recent 2.6 kernels]
Message-ID: <20050402145351.GA11601@elte.hu>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <200504020100.j3210fg04870@unix-os.sc.intel.com>
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


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> Ingo Molnar wrote on Thursday, March 31, 2005 8:52 PM
> > the current defaults for cache_hot_time are 10 msec for NUMA domains,
> > and 2.5 msec for SMP domains. Clearly too low for CPUs with 9MB cache.
> > Are you increasing cache_hot_time in your experiment? If that solves
> > most of the problem that would be an easy thing to fix for 2.6.12.
> 
> 
> Chen, Kenneth W wrote on Thursday, March 31, 2005 9:15 PM
> > Yes, we are increasing the number in our experiments.  It's in the queue
> > and I should have a result soon.
> 
> Hot of the press: bumping up cache_hot_time to 10ms on our db setup 
> brings 2.6.11 performance on par with 2.6.9.  Theory confirmed.

very good! Could you try the attached patch? (against BK-curr, but 
should apply to 2.6.12-rc1 too)

in this patch i've reworked the migration-tuning/auto-detection code in 
a number of ways, to solve various problems the first version of the 
code had.

the first problem was that detection time scaled with O(N^2), which is 
unacceptable on larger SMP and NUMA systems. To solve this:

- i've added a 'domain distance' function, which is used to cache 
  measurement results. Each distance is only measured once. This means 
  that e.g. on NUMA distances of 0, 1 and 2 might be measured, on HT 
  distances 0 and 1, and on SMP distance 0 is measured. The code walks 
  the domain tree to determine the distance, so it automatically follows 
  whatever hierarchy an architecture sets up. This cuts down on the boot 
  time significantly and removes the O(N^2) limit. The only assumption 
  is that migration costs can be expressed as a function of domain
  distance - this covers the overwhelming majority of existing systems, 
  and is a good guess even for more assymetric systems.

  [ people hacking systems that have assymetries that break this 
    assumption (e.g. different CPU speeds) should experiment a bit with 
    the cpu_distance() function. Adding a ->migration_distance factor to 
    the domain structure would be one possible solution - but lets first 
    see the problem systems, if they exist at all. Lets not overdesign. ]

another problem was that only a single cache-size was used for measuring 
the cost of migration, and most architectures didnt set that variable 
up. Furthermore, a single cache-size does not fit NUMA hierarchies with 
L3 caches and does not fit HT setups, where different CPUs will often 
have different 'effective cache sizes'. To solve this problem:

- instead of relying on a single cache-size provided by the platform and
  sticking to it, the code now auto-detects the 'effective migration 
  cost' between two measured CPUs, via iterating through a wide range of
  cachesizes. The code searches for the maximum migration cost, which
  occurs when the working set of the test-workload falls just below the
  'effective cache size'. I.e. real-life optimized search is done for
  the maximum migration cost, between two real CPUs.

  This, amongst other things, has the positive effect hat if e.g. two
  CPUs share a L2/L3 cache, a different (and accurate) migration cost
  will be found than between two CPUs on the same system that dont share
  any caches.

(the reliable measurement of migration costs is tricky - see the source
for details.)

furthermore i've added various boot-time options to override/tune
migration behavior.

firstly, there's a blanket override for autodetection:

	migration_cost=1000,2000,3000

will override the depth 0/1/2 values with 1msec/2msec/3msec values.

secondly, there's a global factor that can be used to increase (or
decrease) the autodetected values:

	migration_factor=120

will increase the autodetected values by 20%. This option is useful to
tune things in a workload-dependent way - e.g. if a workload is
cache-insensitive then CPU utilization can be maximized by specifying
migration_factor=0.

i've tested the autodetection code quite extensively on x86, on 3
different classes of systems: dual Celeron, dual HT P4, 8-way
P3/Xeon/2MB, and the autodetected values look pretty good:

Dual Celeron (128K L2 cache):

 ---------------------
 migration cost matrix (max_cache_size: 131072, cpu: 467 MHz):
 ---------------------
           [00]    [01]
 [00]:     -     1.7(1)
 [01]:   1.7(1)    -
 ---------------------
 cacheflush times [2]: 0.0 (0) 1.7 (1784008)
 ---------------------

here the slow memory subsystem dominates system performance, and even
though caches are small, the migration cost is 1.7 msecs.

Dual HT P4 (512K L2 cache):

 ---------------------
 migration cost matrix (max_cache_size: 524288, cpu: 2379 MHz):
 ---------------------
           [00]    [01]    [02]    [03]
 [00]:     -     0.4(1)  0.0(0)  0.4(1)
 [01]:   0.4(1)    -     0.4(1)  0.0(0)
 [02]:   0.0(0)  0.4(1)    -     0.4(1)
 [03]:   0.4(1)  0.0(0)  0.4(1)    -
 ---------------------
 cacheflush times [2]: 0.0 (33900) 0.4 (448514)
 ---------------------


here it can be seen that there is no migration cost between two HT 
siblings (CPU#0/2 and CPU#1/3 are separate physical CPUs). A fast memory 
system makes inter-physical-CPU migration pretty cheap: 0.4 msecs.

8-way P3/Xeon [2MB L2 cache]:

 ---------------------
 migration cost matrix (max_cache_size: 2097152, cpu: 700 MHz):
 ---------------------
           [00]    [01]    [02]    [03]    [04]    [05]    [06]    [07]
 [00]:     -    19.2(1) 19.2(1) 19.2(1) 19.2(1) 19.2(1) 19.2(1) 19.2(1)
 [01]:  19.2(1)    -    19.2(1) 19.2(1) 19.2(1) 19.2(1) 19.2(1) 19.2(1)
 [02]:  19.2(1) 19.2(1)    -    19.2(1) 19.2(1) 19.2(1) 19.2(1) 19.2(1)
 [03]:  19.2(1) 19.2(1) 19.2(1)    -    19.2(1) 19.2(1) 19.2(1) 19.2(1)
 [04]:  19.2(1) 19.2(1) 19.2(1) 19.2(1)    -    19.2(1) 19.2(1) 19.2(1)
 [05]:  19.2(1) 19.2(1) 19.2(1) 19.2(1) 19.2(1)    -    19.2(1) 19.2(1)
 [06]:  19.2(1) 19.2(1) 19.2(1) 19.2(1) 19.2(1) 19.2(1)    -    19.2(1)
 [07]:  19.2(1) 19.2(1) 19.2(1) 19.2(1) 19.2(1) 19.2(1) 19.2(1)    -
 ---------------------
 cacheflush times [2]: 0.0 (0) 19.2 (19281756)
 ---------------------

this one has huge caches and a relatively slow memory subsystem - so the 
migration cost is 19 msecs.

in theory the code should work fine on ia64 as well, and i'm very 
curious what kind of default migration costs the code measures there ...

	Ingo

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cache-hot-autodetect.patch"

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -4699,6 +4699,400 @@ static void check_sibling_maps(void)
 #endif
 
 /*
+ * Self-tuning task migration cost measurement between source and target CPUs.
+ *
+ * This is done by measuring the cost of manipulating buffers of varying
+ * sizes. For a given buffer-size here are the steps that are taken:
+ *
+ * 1) the source CPU reads a big buffer to flush caches
+ * 2) the source CPU reads+dirties a shared buffer 
+ * 3) the target CPU reads+dirties the same shared buffer
+ * 4) the target CPU reads a big buffer to flush caches
+ *
+ * We measure how long steps #2 and #3 take (step #1 and #4 is not
+ * measured), in the following 4 scenarios:
+ *
+ *  - source: CPU1, target: CPU2 | cost1
+ *  - source: CPU2, target: CPU1 | cost2
+ *  - source: CPU1, target: CPU1 | cost3
+ *  - source: CPU2, target: CPU2 | cost4
+ *
+ * We then calculate the cost3+cost4-cost1-cost2 difference - this is
+ * the cost of migration.
+ *
+ * We then start off from a large buffer-size and iterate down to smaller
+ * buffer sizes, in 5% steps - measuring each buffer-size separately, and
+ * do a maximum search for the cost. The maximum cost for a migration
+ * occurs when the working set is just below the effective cache size.
+ */
+
+
+/*
+ * Flush the cache by reading a big buffer. (We want all writeback
+ * activities to subside. Works only if cache size is larger than
+ * 2*size, but that is good enough as the biggest migration effect
+ * is around cachesize size.)
+ */
+__init static void read_cache(void *__cache, unsigned long __size)
+{
+	unsigned long size = __size/sizeof(long);
+	unsigned long *cache = __cache;
+	volatile unsigned long data;
+	int i;
+
+	for (i = 0; i < 2*size; i += 4)
+		data = cache[i];
+}
+
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
+	for (i = 0; i < size/6; i += 4) {
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
+struct flush_data {
+	unsigned long source, target;
+	void (*fn)(void *, unsigned long);
+	void *cache;
+	unsigned long size;
+	unsigned long long delta;
+};
+
+/*
+ * Dirty L2 on the source CPU:
+ */
+__init static void source_handler(void *__data)
+{
+	struct flush_data *data = __data;
+
+	if (smp_processor_id() != data->source)
+		return;
+
+	/*
+	 * Make sure the cache is quiet on this CPU,
+	 * before starting measurement:
+	 */
+	read_cache(data->cache, data->size);
+
+	data->delta = sched_clock();
+	touch_cache(data->cache, data->size);
+}
+
+/*
+ * Dirty the L2 cache on this CPU and then access the shared
+ * buffer. (which represents the working set of the migrated task.)
+ */
+__init static void target_handler(void *__data)
+{
+	struct flush_data *data = __data;
+
+	if (smp_processor_id() != data->target)
+		return;
+
+	touch_cache(data->cache, data->size);
+	data->delta = sched_clock() - data->delta;
+	/*
+	 * Make sure the cache is quiet, so that it does not interfere
+	 * with the next run on this CPU:
+	 */
+	read_cache(data->cache, data->size);
+}
+
+/*
+ * Measure the cache-cost of one task migration. Returns in units of nsec.
+ */
+__init static unsigned long long measure_one(void *cache, unsigned long size,
+					     int source, int target)
+{
+	struct flush_data data;
+
+	data.source = source;
+	data.target = target;
+	data.size = size;
+	data.cache = cache;
+
+	if (on_each_cpu(source_handler, &data, 1, 1) != 0) {
+		printk("measure_one: timed out waiting for other CPUs\n");
+		return -1;
+	}
+	if (on_each_cpu(target_handler, &data, 1, 1) != 0) {
+		printk("measure_one: timed out waiting for other CPUs\n");
+		return -1;
+	}
+
+	return data.delta;
+}
+
+/*
+ * Maximum cache-size that the scheduler should try to measure.
+ * Architectures with larger caches should tune this up during
+ * bootup. Gets used in the domain-setup code (i.e. during SMP
+ * bootup).
+ */
+__initdata unsigned long max_cache_size;
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
+static __initdata unsigned long long migration_cost[MAX_DOMAIN_DISTANCE];
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
+__init static unsigned long cpu_distance(int cpu1, int cpu2)
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
+#define SEARCH_SCOPE		2
+#define MIN_CACHE_SIZE		(64*1024UL)
+#define DEFAULT_CACHE_SIZE	(8*1024*1024UL)
+#define ITERATIONS		4
+
+__init static unsigned long long measure_cacheflush_time(int cpu1, int cpu2)
+{
+	unsigned long long cost = 0, cost1 = 0, cost2 = 0;
+	unsigned long size;
+	void *cache;
+	int i;
+
+	/*
+	 * Search from max_cache_size*5 down to 64K - the real relevant
+	 * cachesize has to lie somewhere inbetween.
+	 */
+	if (max_cache_size)
+		size = max(max_cache_size * SEARCH_SCOPE, MIN_CACHE_SIZE);
+	else
+		/*
+		 * Since we have no estimation about the relevant
+		 * search range
+		 */
+		size = DEFAULT_CACHE_SIZE * SEARCH_SCOPE;
+		
+	if (!cpu_online(cpu1) || !cpu_online(cpu2)) {
+		printk("cpu %d and %d not both online!\n", cpu1, cpu2);
+		return 0;
+	}
+	/*
+	 * We allocate 2*size so that read_cache() can access a
+	 * larger buffer:
+	 */
+	cache = vmalloc(2*size);
+	if (!cache) {
+		printk("could not vmalloc %ld bytes for cache!\n", 2*size);
+		return 1000000; // return 1 msec on very small boxen
+	}
+	memset(cache, 0, 2*size);
+
+	while (size >= MIN_CACHE_SIZE) {
+		/*
+		 * Measure the migration cost of 'size' bytes, over an
+		 * average of 10 runs:
+		 *
+		 * (We perturb the cache size by a small (0..4k)
+		 *  value to compensate size/alignment related artifacts.
+		 *  We also subtract the cost of the operation done on
+		 *  the same CPU.)
+		 */
+		cost1 = 0;
+		for (i = 0; i < ITERATIONS; i++) {
+			cost1 += measure_one(cache, size - i*1024, cpu1, cpu2);
+			cost1 += measure_one(cache, size - i*1024, cpu2, cpu1);
+		}
+
+		cost2 = 0;
+		for (i = 0; i < ITERATIONS; i++) {
+			cost2 += measure_one(cache, size - i*1024, cpu1, cpu1);
+			cost2 += measure_one(cache, size - i*1024, cpu2, cpu2);
+		}
+		if (cost1 > cost2)
+			cost = max(cost, cost1 - cost2);
+		/*
+		 * Iterate down the cachesize (in a non-power-of-2
+		 * way to avoid artifacts) in 5% decrements:
+		 */
+		size = size * 19 / 20;
+	}
+	/*
+	 * Get the per-iteration migration cost:
+	 */
+	do_div(cost, 2*ITERATIONS);
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
+	return 2 * cost * migration_factor / MIGRATION_FACTOR_SCALE;
+}
+
+void __devinit calibrate_cache_decay(void)
+{
+	int cpu1 = -1, cpu2 = -1, cpu;
+	struct sched_domain *sd;
+	unsigned long distance, max_distance = 0;
+	unsigned long long cost;
+
+	printk("---------------------\n");
+	printk("migration cost matrix (max_cache_size: %ld, cpu: %ld MHz):\n",
+		max_cache_size, cpu_khz/1000);
+	printk("---------------------\n");
+	printk("      ");
+	for_each_online_cpu(cpu1)
+		printk("    [%02d]", cpu1);
+	printk("\n");
+	/*
+	 * First pass - calculate the cacheflush times:
+	 */
+	for_each_online_cpu(cpu1) {
+		printk("[%02d]: ", cpu1);
+		for_each_online_cpu(cpu2) {
+			if (cpu1 == cpu2) {
+				printk("    -   ");
+				continue;
+			}
+			distance = cpu_distance(cpu1, cpu2);
+			max_distance = max(max_distance, distance);
+			/*
+			 * Do we have the result cached already?
+			 */
+			if (migration_cost[distance])
+				cost = migration_cost[distance];
+			else {
+				cost = measure_cacheflush_time(cpu1, cpu2);
+				migration_cost[distance] = cost;
+			}
+			printk(" %2ld.%ld(%ld)", (long)cost / 1000000,
+				((long)cost / 100000) % 10, distance);
+		}
+		printk("\n");
+	}
+	printk("---------------------\n");
+	printk("cacheflush times [%ld]:", max_distance+1);
+	for (distance = 0; distance <= max_distance; distance++) {
+		cost = migration_cost[distance];
+		printk(" %ld.%ld (%Ld)", (long)cost / 1000000,
+			((long)cost / 100000) % 10, cost);
+	}
+	printk("\n");
+	printk("---------------------\n");
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
+}
+
+/*
  * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
  */
 static void __devinit arch_init_sched_domains(void)
@@ -4820,6 +5214,10 @@ static void __devinit arch_init_sched_do
 #endif
 		cpu_attach_domain(sd, i);
 	}
+	/*
+	 * Tune cache-hot values:
+	 */
+	calibrate_cache_decay();
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
--- linux/arch/ia64/kernel/domain.c.orig
+++ linux/arch/ia64/kernel/domain.c
@@ -358,6 +358,11 @@ next_sg:
 #endif
 		cpu_attach_domain(sd, i);
 	}
+	/*
+	 * Tune cache-hot values:
+	 */
+	max_cache_size = 32*1024*1024;
+	calibrate_cache_decay();
 }
 
 void __devinit arch_destroy_sched_domains(void)
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
@@ -112,7 +112,6 @@
 	.max_interval		= 4,			\
 	.busy_factor		= 64,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (5*1000000/2),	\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
--- linux/include/linux/sched.h.orig
+++ linux/include/linux/sched.h
@@ -527,7 +527,15 @@ extern cpumask_t cpu_isolated_map;
 extern void init_sched_build_groups(struct sched_group groups[],
 	                        cpumask_t span, int (*group_fn)(int cpu));
 extern void cpu_attach_domain(struct sched_domain *sd, int cpu);
+
 #endif /* ARCH_HAS_SCHED_DOMAIN */
+
+/*
+ * Maximum cache size the auto-tuning code will search:
+ */
+extern unsigned long max_cache_size;
+extern void calibrate_cache_decay(void);
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

--ReaqsoxgOBHFXBhH--
