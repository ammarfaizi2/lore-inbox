Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269188AbUJFN3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269188AbUJFN3T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269132AbUJFN3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:29:15 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9654 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268356AbUJFN2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:28:11 -0400
Date: Wed, 6 Oct 2004 15:29:30 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Subject: [patch] sched: auto-tuning task-migration
Message-ID: <20041006132930.GA1814@elte.hu>
References: <200410060042.i960gn631637@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410060042.i960gn631637@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> Since we are talking about load balancing, we decided to measure
> various value for cache_hot_time variable to see how it affects app
> performance. We first establish baseline number with vanilla base
> kernel (default at 2.5ms), then sweep that variable up to 1000ms.  All
> of the experiments are done with Ingo's patch posted earlier.  Here
> are the result (test environment is 4-way SMP machine, 32 GB memory,
> 500 disks running industry standard db transaction processing
> workload):
> 
> cache_hot_time  | workload throughput
> --------------------------------------
>          2.5ms  - 100.0   (0% idle)
>          5ms    - 106.0   (0% idle)
>          10ms   - 112.5   (1% idle)
>          15ms   - 111.6   (3% idle)
>          25ms   - 111.1   (5% idle)
>          250ms  - 105.6   (7% idle)
>          1000ms - 105.4   (7% idle)

the following patch adds a new feature to the scheduler: during bootup
it measures migration costs and sets up cache_hot value accordingly.

The measurement is point-to-point, i.e. it can be used to measure the
migration costs in cache hierarchies - e.g. by NUMA setup code. The
patch prints out a matrix of migration costs between CPUs. 
(self-migration means pure cache dirtying cost)

Here are a couple of matrixes from testsystems:

A 2-way Celeron/128K box:

 arch cache_decay_nsec: 1000000
 migration cost matrix (cache_size: 131072, cpu: 467 MHz):
         [00]  [01]
 [00]:    9.6  12.0
 [01]:   12.2   9.8
 min_delta: 12586890
 using cache_decay nsec: 12586890 (12 msec)

a 2-way/4-way P4/512K HT box:

 arch cache_decay_nsec: 2000000
 migration cost matrix (cache_size: 524288, cpu: 2379 MHz):
         [00]  [01]  [02]  [03]
 [00]:    6.1   6.1   5.7   6.1
 [01]:    6.7   6.2   6.7   6.2
 [02]:    5.9   5.9   6.1   5.0
 [03]:    6.7   6.2   6.7   6.2
 min_delta: 6053016
 using cache_decay nsec: 6053016 (5 msec)

an 8-way P3/2MB Xeon box:

 arch cache_decay_nsec: 6000000
 migration cost matrix (cache_size: 2097152, cpu: 700 MHz):
         [00]  [01]  [02]  [03]  [04]  [05]  [06]  [07]
 [00]:   92.1 184.8 184.8 184.8 184.9  90.7  90.6  90.7
 [01]:  181.3  92.7  88.5  88.6  88.5 181.5 181.3 181.4
 [02]:  181.4  88.4  92.5  88.4  88.5 181.4 181.3 181.4
 [03]:  181.4  88.4  88.5  92.5  88.4 181.5 181.2 181.4
 [04]:  181.4  88.5  88.4  88.4  92.5 181.5 181.3 181.5
 [05]:   87.2 181.5 181.4 181.5 181.4  90.0  87.0  87.1
 [06]:   87.2 181.5 181.4 181.5 181.4  87.9  90.0  87.1
 [07]:   87.2 181.5 181.4 181.5 181.4  87.9  87.0  90.0
 min_delta: 91815564
 using cache_decay nsec: 91815564 (87 msec)

(btw., this matrix shows nicely the 0,5,6,7/1,2,3,4 grouping of quads in
this semi-NUMA 8-way box.)

could you try this patch on your testbox and send me the bootlog? How
close does this method get us to the 10 msec value you measured to be
close to the best value? The patch is against 2.6.9-rc3 + the last
cache_hot fixpatch you tried.

the patch contains comments that explain how migration costs are
measured.

(NOTE: sched_cache_size is only filled in for x86 at the moment, so if
you have another architecture then please add those two lines to that
architecture's smpboot.c.)

this is only the first release of the patch - obviously we cannot print
such a matrix for 1024 CPUs. But this should be good enough for testing
purposes.

	Ingo

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -388,7 +388,7 @@ struct sched_domain {
 	.max_interval		= 4,			\
 	.busy_factor		= 64,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (5*1000000/2),	\
+	.cache_hot_time		= cache_decay_nsec,	\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_BALANCE_NEWIDLE	\
@@ -410,7 +410,7 @@ struct sched_domain {
 	.max_interval		= 32,			\
 	.busy_factor		= 32,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000000),		\
+	.cache_hot_time		= cache_decay_nsec,	\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_BALANCE_EXEC	\
@@ -4420,11 +4420,233 @@ __init static void init_sched_build_grou
 	last->next = first;
 }
 
-__init static void arch_init_sched_domains(void)
+/*
+ * Task migration cost measurement between source and target CPUs.
+ *
+ * This is done by measuring the worst-case cost. Here are the
+ * steps that are taken:
+ *
+ * 1) the source CPU dirties its L2 cache with a shared buffer
+ * 2) the target CPU dirties its L2 cache with a local buffer
+ * 3) the target CPU dirties the shared buffer
+ *
+ * We measure the time step #3 takes - this is the cost of migrating
+ * a cache-hot task that has a large, dirty dataset in the L2 cache,
+ * to another CPU.
+ */
+
+
+/*
+ * Dirty a big buffer in a hard-to-predict (for the L2 cache) way. This
+ * is the operation that is timed, so we try to generate unpredictable
+ * cachemisses that still end up filling the L2 cache:
+ */
+static void fill_cache(void *__cache, unsigned long __size)
 {
+	unsigned long size = __size/sizeof(long);
+	unsigned long *cache = __cache;
+	unsigned long data = 0xdeadbeef;
 	int i;
+
+	for (i = 0; i < size/4; i++) {
+		if ((i & 3) == 0)
+			cache[i] = data;
+		if ((i & 3) == 1)
+			cache[size-1-i] = data;
+		if ((i & 3) == 2)
+			cache[size/2-i] = data;
+		if ((i & 3) == 3)
+			cache[size/2+i] = data;
+	}
+}
+
+struct flush_data {
+	unsigned long source, target;
+	void (*fn)(void *, unsigned long);
+	void *cache;
+	void *local_cache;
+	unsigned long size;
+	unsigned long long delta;
+};
+
+/*
+ * Dirty L2 on the source CPU:
+ */
+static void source_handler(void *__data)
+{
+	struct flush_data *data = __data;
+
+	if (smp_processor_id() != data->source)
+		return;
+
+	memset(data->cache, 0, data->size);
+}
+
+/*
+ * Dirty the L2 cache on this CPU and then access the shared
+ * buffer. (which represents the working set of the migrated task.)
+ */
+static void target_handler(void *__data)
+{
+	struct flush_data *data = __data;
+	unsigned long long t0, t1;
+	unsigned long flags;
+
+	if (smp_processor_id() != data->target)
+		return;
+
+	memset(data->local_cache, 0, data->size);
+	local_irq_save(flags);
+	t0 = sched_clock();
+	fill_cache(data->cache, data->size);
+	t1 = sched_clock();
+	local_irq_restore(flags);
+
+	data->delta = t1 - t0;
+}
+
+/*
+ * Measure the cache-cost of one task migration:
+ */
+static unsigned long long measure_one(void *cache, unsigned long size,
+				      int source, int target)
+{
+	struct flush_data data;
+	unsigned long flags;
+	void *local_cache;
+
+	local_cache = vmalloc(size);
+	if (!local_cache) {
+		printk("couldnt allocate local cache ...\n");
+		return 0;
+	}
+	memset(local_cache, 0, size);
+
+	local_irq_save(flags);
+	local_irq_enable();
+
+	data.source = source;
+	data.target = target;
+	data.size = size;
+	data.cache = cache;
+	data.local_cache = local_cache;
+
+	if (on_each_cpu(source_handler, &data, 1, 1) != 0) {
+		printk("measure_one: timed out waiting for other CPUs\n");
+		local_irq_restore(flags);
+		return -1;
+	}
+	if (on_each_cpu(target_handler, &data, 1, 1) != 0) {
+		printk("measure_one: timed out waiting for other CPUs\n");
+		local_irq_restore(flags);
+		return -1;
+	}
+
+	vfree(local_cache);
+
+	return data.delta;
+}
+
+unsigned long sched_cache_size;
+
+/*
+ * Measure a series of task migrations and return the maximum
+ * result - the worst-case. Since this code runs early during
+ * bootup the system is 'undisturbed' and the maximum latency
+ * makes sense.
+ *
+ * As the working set we use 1.66 times the L2 cache size, this is
+ * chosen in such a nonsymmetric way so that fill_cache() doesnt
+ * iterate at power-of-2 boundaries (which might hit cache mapping
+ * artifacts and pessimise the results).
+ */
+static __init unsigned long long measure_cacheflush_time(int cpu1, int cpu2)
+{
+	unsigned long size = sched_cache_size*5/3;
+	unsigned long long delta, max = 0;
+	void *cache;
+	int i;
+
+	if (!size) {
+		printk("arch has not set cachesize - using default.\n");
+		return 0;
+	}
+	if (!cpu_online(cpu1) || !cpu_online(cpu2)) {
+		printk("cpu %d and %d not both online!\n", cpu1, cpu2);
+		return 0;
+	}
+	cache = vmalloc(size);
+	if (!cache) {
+		printk("could not vmalloc %ld bytes for cache!\n", size);
+		return 0;
+	}
+	memset(cache, 0, size);
+	for (i = 0; i < 20; i++) {
+		delta = measure_one(cache, size, cpu1, cpu2);
+		if (delta > max)
+			max = delta;
+	}
+
+	vfree(cache);
+
+	/*
+	 * A task is considered 'cache cold' if at least 10 times
+	 * the cost of migration has passed. I.e. in the rare and
+	 * absolutely worst-case we should see a 10% degradation
+	 * due to migration. (this limit is only listened to if the
+	 * load-balancing situation is 'nice' - if there is a large
+	 * imbalance we ignore it for the sake of CPU utilization and
+	 * processing fairness.)
+	 *
+	 * (We use 5/3 times the L2 cachesize in our measurement,
+	 *  hence factor 6 here: 10 == 6*5/3.)
+	 */
+	return max * 6;
+}
+
+static unsigned long long cache_decay_nsec;
+
+__init static void arch_init_sched_domains(void)
+{
+	int i, cpu1 = -1, cpu2 = -1;
+	unsigned long long min_delta = -1ULL;
+
 	cpumask_t cpu_default_map;
 
+	printk("arch cache_decay_nsec: %ld\n", cache_decay_ticks*1000000);
+	printk("migration cost matrix (cache_size: %ld, cpu: %ld MHz):\n",
+		sched_cache_size, cpu_khz/1000);
+	printk("      ");
+	for (cpu1 = 0; cpu1 < NR_CPUS; cpu1++) {
+		if (!cpu_online(cpu1))
+			continue;
+		printk("  [%02d]", cpu1);
+	}
+	printk("\n");
+	for (cpu1 = 0; cpu1 < NR_CPUS; cpu1++) {
+		if (!cpu_online(cpu1))
+			continue;
+		printk("[%02d]: ", cpu1);
+		for (cpu2 = 0; cpu2 < NR_CPUS; cpu2++) {
+			unsigned long long delta;
+
+			if (!cpu_online(cpu2))
+				continue;
+			delta = measure_cacheflush_time(cpu1, cpu2);
+			
+			printk(" %3Ld.%ld", delta >> 20,
+				(((long)delta >> 10) / 102) % 10);
+			if ((cpu1 != cpu2) && (delta < min_delta))
+				min_delta = delta;
+		}
+		printk("\n");
+	}
+	printk("min_delta: %Ld\n", min_delta);
+	if (min_delta != -1ULL)
+		cache_decay_nsec = min_delta;
+	printk("using cache_decay nsec: %Ld (%Ld msec)\n",
+		cache_decay_nsec, cache_decay_nsec >> 20);
+
 	/*
 	 * Setup mask for cpus without special case scheduling requirements.
 	 * For now this just excludes isolated cpus, but could be used to
--- linux/arch/i386/kernel/smpboot.c.orig
+++ linux/arch/i386/kernel/smpboot.c
@@ -849,6 +849,8 @@ static int __init do_boot_cpu(int apicid
 cycles_t cacheflush_time;
 unsigned long cache_decay_ticks;
 
+extern unsigned long sched_cache_size;
+
 static void smp_tune_scheduling (void)
 {
 	unsigned long cachesize;       /* kB   */
@@ -879,6 +881,7 @@ static void smp_tune_scheduling (void)
 		}
 
 		cacheflush_time = (cpu_khz>>10) * (cachesize<<10) / bandwidth;
+		sched_cache_size = cachesize * 1024;
 	}
 
 	cache_decay_ticks = (long)cacheflush_time/cpu_khz + 1;
