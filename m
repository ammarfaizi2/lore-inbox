Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269435AbUJFULq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269435AbUJFULq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269452AbUJFUKS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:10:18 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39364 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S269435AbUJFUDX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:03:23 -0400
Date: Wed, 6 Oct 2004 22:04:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>
Subject: Re: [patch] sched: auto-tuning task-migration
Message-ID: <20041006200439.GA15003@elte.hu>
References: <20041006132930.GA1814@elte.hu> <200410061749.i96Hn2606805@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410061749.i96Hn2606805@unix-os.sc.intel.com>
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

> Ran it on a similar system.  Below is the output.  Haven't tried to
> get a real benchmark run with 42 ms cache_hot_time.  I don't think it
> will get peak throughput as we already start tapering off at 12.5 ms.

> arch cache_decay_nsec: 10000000
> migration cost matrix (cache_size: 9437184, cpu: 1500 MHz):
>         [00]  [01]  [02]  [03]
> [00]:   50.2  42.8  42.9  42.8
> [01]:   42.9  50.2  42.1  42.9
> [02]:   42.9  42.9  50.2  42.8
> [03]:   42.9  42.9  42.9  50.2
> min_delta: 44785782
> using cache_decay nsec: 44785782 (42 msec)

could you try the replacement patch below - what results does it give?

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
@@ -4420,11 +4420,232 @@ __init static void init_sched_build_grou
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
+__init static void fill_cache(void *__cache, unsigned long __size)
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
+__init static void source_handler(void *__data)
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
+__init static void target_handler(void *__data)
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
+__init static unsigned long long measure_one(void *cache, unsigned long size,
+					     int source, int target)
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
+__initdata unsigned long sched_cache_size;
+
+/*
+ * Measure a series of task migrations and return the maximum
+ * result - the worst-case. Since this code runs early during
+ * bootup the system is 'undisturbed' and the maximum latency
+ * makes sense.
+ *
+ * As the working set we use 2.1 times the L2 cache size, this is
+ * chosen in such a nonsymmetric way so that fill_cache() doesnt
+ * iterate at power-of-2 boundaries (which might hit cache mapping
+ * artifacts and pessimise the results).
+ */
+__init static unsigned long long measure_cacheflush_time(int cpu1, int cpu2)
+{
+	unsigned long size = sched_cache_size*21/10;
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
+	 * A task is considered 'cache cold' if at least 2 times
+	 * the worst-case cost of migration has passed.
+	 * (this limit is only listened to if the load-balancing
+	 * situation is 'nice' - if there is a large imbalance we
+	 * ignore it for the sake of CPU utilization and
+	 * processing fairness.)
+	 *
+	 * (We use 2.1 times the L2 cachesize in our measurement,
+	 *  we keep this factor when returning.)
+	 */
+	return max;
+}
+
+__initdata static unsigned long long cache_decay_nsec;
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
