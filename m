Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVDAGrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVDAGrH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 01:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVDAGrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 01:47:07 -0500
Received: from mx2.elte.hu ([157.181.151.9]:6558 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262374AbVDAGql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 01:46:41 -0500
Date: Fri, 1 Apr 2005 08:46:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, kenneth.w.chen@intel.com,
       torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Industry db benchmark result on recent 2.6 kernels
Message-ID: <20050401064611.GA26203@elte.hu>
References: <200503312214.j2VMEag23175@unix-os.sc.intel.com> <424C8956.7070108@yahoo.com.au> <20050331220526.3719ed7f.pj@engr.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20050331220526.3719ed7f.pj@engr.sgi.com>
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


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


* Paul Jackson <pj@engr.sgi.com> wrote:

> Nick wrote:
> > Ingo had a cool patch to estimate dirty => dirty cacheline transfer latency
> > ... Unfortunately ... and it is an O(cpus^2) operation.
> 
> Yes - a cool patch.

before we get into complexities, i'd like to see whether it solves Ken's 
performance problem. The attached patch (against BK-curr, but should 
apply to vanilla 2.6.12-rc1 too) adds the autodetection feature. (For 
ia64 i've hacked in a cachesize of 9MB for Ken's testsystem.)

boots fine on x86, and gives this on a 4-way box:

 Brought up 4 CPUs
 migration cost matrix (cache_size: 524288, cpu: 2379 MHz):
         [00]  [01]  [02]  [03]
 [00]:    1.3   1.3   1.4   1.2
 [01]:    1.5   1.3   1.3   1.5
 [02]:    1.5   1.3   1.3   1.5
 [03]:    1.3   1.3   1.3   1.3
 min_delta: 1351361
 using cache_decay nsec: 1351361 (1 msec)

which is a pretty reasonable estimate on that box. (fast P4s, small 
cache)

Ken, could you give it a go?

	Ingo

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cache-hot-autodetect-2.6.12-rc1-A0"

--- linux/kernel/sched.c.orig
+++ linux/kernel/sched.c
@@ -4699,6 +4699,232 @@ static void check_sibling_maps(void)
 #endif
 
 /*
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
+{
+	unsigned long size = __size/sizeof(long);
+	unsigned long *cache = __cache;
+	unsigned long data = 0xdeadbeef;
+	int i;
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
+unsigned long long cache_decay_nsec;
+
+void __devinit calibrate_cache_decay(void)
+{
+	int cpu1 = -1, cpu2 = -1;
+	unsigned long long min_delta = -1ULL;
+
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
+
+}
+
+/*
  * Set up scheduler domains and groups.  Callers must hold the hotplug lock.
  */
 static void __devinit arch_init_sched_domains(void)
@@ -4706,6 +4932,7 @@ static void __devinit arch_init_sched_do
 	int i;
 	cpumask_t cpu_default_map;
 
+	calibrate_cache_decay();
 #if defined(CONFIG_SCHED_SMT) && defined(CONFIG_NUMA)
 	check_sibling_maps();
 #endif
--- linux/arch/ia64/kernel/domain.c.orig
+++ linux/arch/ia64/kernel/domain.c
@@ -139,6 +139,9 @@ void __devinit arch_init_sched_domains(v
 	int i;
 	cpumask_t cpu_default_map;
 
+	sched_cache_size = 9*1024*1024; // hack for Kenneth
+	calibrate_cache_decay();
+
 	/*
 	 * Setup mask for cpus without special case scheduling requirements.
 	 * For now this just excludes isolated cpus, but could be used to
--- linux/arch/i386/kernel/smpboot.c.orig
+++ linux/arch/i386/kernel/smpboot.c
@@ -873,6 +873,7 @@ static void smp_tune_scheduling (void)
 			cachesize = 16; /* Pentiums, 2x8kB cache */
 			bandwidth = 100;
 		}
+		sched_cache_size = cachesize * 1024;
 	}
 }
 
--- linux/include/asm-ia64/topology.h.orig
+++ linux/include/asm-ia64/topology.h
@@ -51,7 +51,7 @@ void build_cpu_to_node_map(void);
 	.max_interval		= 320,			\
 	.busy_factor		= 320,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000000),		\
+	.cache_hot_time		= cache_decay_nsec,	\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
@@ -73,7 +73,7 @@ void build_cpu_to_node_map(void);
 	.max_interval		= 320,			\
 	.busy_factor		= 320,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000000),		\
+	.cache_hot_time		= cache_decay_nsec,	\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
--- linux/include/linux/topology.h.orig
+++ linux/include/linux/topology.h
@@ -61,6 +61,12 @@
 #endif
 
 /*
+ * total time penalty to migrate a typical application's cache contents
+ * from one CPU to another. Measured by the boot-time code.
+ */
+extern unsigned long long cache_decay_nsec;
+
+/*
  * Below are the 3 major initializers used in building sched_domains:
  * SD_SIBLING_INIT, for SMT domains
  * SD_CPU_INIT, for SMP domains
@@ -112,7 +118,7 @@
 	.max_interval		= 4,			\
 	.busy_factor		= 64,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (5*1000000/2),	\
+	.cache_hot_time		= cache_decay_nsec,	\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
--- linux/include/linux/sched.h.orig
+++ linux/include/linux/sched.h
@@ -527,7 +527,12 @@ extern cpumask_t cpu_isolated_map;
 extern void init_sched_build_groups(struct sched_group groups[],
 	                        cpumask_t span, int (*group_fn)(int cpu));
 extern void cpu_attach_domain(struct sched_domain *sd, int cpu);
+
 #endif /* ARCH_HAS_SCHED_DOMAIN */
+
+extern unsigned long sched_cache_size;
+extern void calibrate_cache_decay(void);
+
 #endif /* CONFIG_SMP */
 
 
--- linux/include/asm-i386/topology.h.orig
+++ linux/include/asm-i386/topology.h
@@ -75,7 +75,7 @@ static inline cpumask_t pcibus_to_cpumas
 	.max_interval		= 32,			\
 	.busy_factor		= 32,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000000),		\
+	.cache_hot_time		= cache_decay_nsec,	\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
--- linux/include/asm-ppc64/topology.h.orig
+++ linux/include/asm-ppc64/topology.h
@@ -46,7 +46,7 @@ static inline int node_to_first_cpu(int 
 	.max_interval		= 32,			\
 	.busy_factor		= 32,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000000),		\
+	.cache_hot_time		= cache_decay_nsec,	\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\
--- linux/include/asm-x86_64/topology.h.orig
+++ linux/include/asm-x86_64/topology.h
@@ -48,7 +48,7 @@ static inline cpumask_t __pcibus_to_cpum
 	.max_interval		= 32,			\
 	.busy_factor		= 32,			\
 	.imbalance_pct		= 125,			\
-	.cache_hot_time		= (10*1000000),		\
+	.cache_hot_time		= cache_decay_nsec,	\
 	.cache_nice_tries	= 1,			\
 	.per_cpu_gain		= 100,			\
 	.flags			= SD_LOAD_BALANCE	\

--u3/rZRmxL6MmkK24--
