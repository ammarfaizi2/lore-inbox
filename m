Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbTAUBMT>; Mon, 20 Jan 2003 20:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267345AbTAUBMT>; Mon, 20 Jan 2003 20:12:19 -0500
Received: from h00e098094f32.ne.client2.attbi.com ([24.60.234.83]:7049 "EHLO
	linux.local") by vger.kernel.org with ESMTP id <S267322AbTAUBME>;
	Mon, 20 Jan 2003 20:12:04 -0500
Date: Mon, 20 Jan 2003 20:21:04 -0500
Message-Id: <200301210121.h0L1L4p03536@linux.local>
From: Jim Houston <jim.houston@attbi.com>
To: shemminger@osdl.org, linux-kernel@vger.kernel.org,
       high-res-timers-discourse@lists.sourceforge.net
Subject: Re: [PATCH] improved boot time TSC synchronization
Reply-to: jim.houston@attbi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen Hemminger wrote:
> I want to incorporate and try out this patch, but it doesn't apply
> cleanly against 2.5.58.  Could you send a new one to me against 2.5.59

Hi Stephen

I'm sorry about the last patch.  This one should apply cleanly 
to linux-2.5.59.

Jim Houston - Concurrent Computer Corp.

--- linux-2.5.59.orig/arch/i386/kernel/smpboot.c	Mon Jan 20 20:02:02 2003
+++ linux-2.5.59/arch/i386/kernel/smpboot.c	Mon Jan 20 20:02:38 2003
@@ -169,169 +169,231 @@
 }
 
 /*
- * TSC synchronization.
- *
- * We first check wether all CPUs have their TSC's synchronized,
- * then we print a warning if not, and always resync.
+ * TSC synchronization based on ia64 itc synchronization code.  Synchronize
+ * pairs of processors rather than tring to synchronize all of the processors
+ * with a single event.  When several processors are all waiting for an 
+ * event they don't all see it at the same time.  The write will cause
+ * an invalidate on each processors cache and then they all scramble to
+ * re-read that cache line.
+ * 
+ * Writing the TSC resets the upper 32-bits, so we need to be careful
+ * that all of the cpus can be synchronized before we overflow the 
+ * 32-bit count.
  */
 
-static atomic_t tsc_start_flag = ATOMIC_INIT(0);
-static atomic_t tsc_count_start = ATOMIC_INIT(0);
-static atomic_t tsc_count_stop = ATOMIC_INIT(0);
-static unsigned long long tsc_values[NR_CPUS];
-
-#define NR_LOOPS 5
+#define MASTER	0
+#define SLAVE	(SMP_CACHE_BYTES/sizeof(long))
 
-extern unsigned long fast_gettimeoffset_quotient;
+#define NUM_ROUNDS	64	/* magic value */
+#define NUM_ITERS	5	/* likewise */
 
-/*
- * accurate 64-bit/32-bit division, expanded to 32-bit divisions and 64-bit
- * multiplication. Not terribly optimized but we need it at boot time only
- * anyway.
- *
- * result == a / b
- *	== (a1 + a2*(2^32)) / b
- *	== a1/b + a2*(2^32/b)
- *	== a1/b + a2*((2^32-1)/b) + a2/b + (a2*((2^32-1) % b))/b
- *		    ^---- (this multiplication can overflow)
- */
+static volatile unsigned long go[2*SLAVE] __cacheline_aligned;
+static volatile int current_slave = -1;
+static volatile int tsc_sync_complete = 0;
+static volatile int tsc_adj_latency = 0;
+static unsigned int max_rt = 0;
+static unsigned int max_delta = 0;
+
+#define DEBUG_TSC_SYNC	0
+#if DEBUG_TSC_SYNC
+struct tsc_sync_debug {
+	long rt;	/* roundtrip time */
+	long master;	/* master's timestamp */
+	long diff;	/* difference between midpoint and master's timestamp */
+	long lat;	/* estimate of tsc adjustment latency */
+} tsc_sync_debug[NUM_ROUNDS*NR_CPUS];
+#endif
 
-static unsigned long long __init div64 (unsigned long long a, unsigned long b0)
+void
+sync_master(void)
 {
-	unsigned int a1, a2;
-	unsigned long long res;
+	unsigned long  n, tsc, last_go_master;
 
-	a1 = ((unsigned int*)&a)[0];
-	a2 = ((unsigned int*)&a)[1];
-
-	res = a1/b0 +
-		(unsigned long long)a2 * (unsigned long long)(0xffffffff/b0) +
-		a2 / b0 +
-		(a2 * (0xffffffff % b0)) / b0;
-
-	return res;
+	last_go_master = 0;
+	while (1) {
+		while ((n = go[MASTER]) == last_go_master)
+			rep_nop();
+		if (n == ~0)
+			break;
+		rdtscl(tsc);
+		if (unlikely(!tsc))
+			tsc = 1;
+		go[SLAVE] = tsc;
+		last_go_master = n;
+	}
 }
 
-static void __init synchronize_tsc_bp (void)
+/*
+ * Return the number of cycles by which our TSC differs from the TSC on
+ * the master (time-keeper) CPU.  A positive number indicates our TSC is
+ * ahead of the master, negative that it is behind.
+ */
+static inline long
+get_delta (long *rt, long *master)
 {
-	int i;
-	unsigned long long t0;
-	unsigned long long sum, avg;
-	long long delta;
-	unsigned long one_usec;
-	int buggy = 0;
+	unsigned long best_t0 = 0, best_t1 = ~0UL, best_tm = 0;
+	unsigned long tcenter, t0, t1, tm, last_go_slave;
+	long i;
+
+	last_go_slave = go[SLAVE];
+	for (i = 0; i < NUM_ITERS; ++i) {
+		rdtscl(t0);
+		go[MASTER] = i+1;
+		while ((tm = go[SLAVE]) == last_go_slave)
+			rep_nop();
+		rdtscl(t1);
+
+		if (t1 - t0 < best_t1 - best_t0)
+			best_t0 = t0, best_t1 = t1, best_tm = tm;
+		last_go_slave = tm;
+	}
 
-	printk("checking TSC synchronization across %u CPUs: ", num_booting_cpus());
+	*rt = best_t1 - best_t0;
+	*master = best_tm - best_t0;
 
-	one_usec = ((1<<30)/fast_gettimeoffset_quotient)*(1<<2);
+	/* average best_t0 and best_t1 without overflow: */
+	tcenter = (best_t0/2 + best_t1/2);
+	if (best_t0 % 2 + best_t1 % 2 == 2)
+		++tcenter;
+	return tcenter - best_tm;
+}
 
-	atomic_set(&tsc_start_flag, 1);
-	wmb();
+/*
+ * Synchronize TSC of the current (slave) CPU with the TSC of the MASTER CPU
+ * (normally the time-keeper CPU).  We use a closed loop to eliminate the
+ * possibility of unaccounted-for errors (such as getting a machine check in
+ * the middle of a calibration step).  The basic idea is for the slave to ask
+ * the master what TSC value it has and to read its own TSC before and after
+ * the master responds.  Each iteration gives us three
+ * timestamps:
+ *
+ *	slave		master
+ *
+ *	t0 ---\
+ *             ---\
+ *		   --->
+ *			tm
+ *		   /---
+ *	       /---
+ *	t1 <---
+ *
+ *
+ * The goal is to adjust the slave's TSC such that tm falls exactly half-way
+ * between t0 and t1.  If we achieve this, the clocks are synchronized provided
+ * the interconnect between the slave and the master is symmetric.  Even if the
+ * interconnect were asymmetric, we would still know that the synchronization
+ * error is smaller than the roundtrip latency (t0 - t1).
+ *
+ * When the interconnect is quiet and symmetric, this lets us synchronize the
+ * TSC to within one or two cycles.  However, we can only *guarantee* that the
+ * synchronization is accurate to within a round-trip time, which is typically
+ * in the range of several hundred cycles (e.g., ~500 cycles).  In practice,
+ * this means that the TSC's are usually almost perfectly synchronized, but we
+ * shouldn't assume that the accuracy is much better than half a micro second
+ * or so.
+ */
 
+static void __init
+synchronize_tsc_ap (void)
+{
+	long i, delta, adj, adjust_latency, n_rounds;
+	unsigned long rt, master_time_stamp,  tsc;
+#if DEBUG_TSC_SYNC
+	struct tsc_sync_debug *t =
+		 &tsc_sync_debug[smp_processor_id() * NUM_ROUNDS];
+#endif
+	
 	/*
-	 * We loop a few times to get a primed instruction cache,
-	 * then the last pass is more or less synchronized and
-	 * the BP and APs set their cycle counters to zero all at
-	 * once. This reduces the chance of having random offsets
-	 * between the processors, and guarantees that the maximum
-	 * delay between the cycle counters is never bigger than
-	 * the latency of information-passing (cachelines) between
-	 * two CPUs.
+	 * Wait for our turn to synchronize with the boot processor.
 	 */
-	for (i = 0; i < NR_LOOPS; i++) {
-		/*
-		 * all APs synchronize but they loop on '== num_cpus'
-		 */
-		while (atomic_read(&tsc_count_start) != num_booting_cpus()-1)
-			mb();
-		atomic_set(&tsc_count_stop, 0);
-		wmb();
-		/*
-		 * this lets the APs save their current TSC:
-		 */
-		atomic_inc(&tsc_count_start);
-
-		rdtscll(tsc_values[smp_processor_id()]);
-		/*
-		 * We clear the TSC in the last loop:
-		 */
-		if (i == NR_LOOPS-1)
-			write_tsc(0, 0);
-
-		/*
-		 * Wait for all APs to leave the synchronization point:
-		 */
-		while (atomic_read(&tsc_count_stop) != num_booting_cpus()-1)
-			mb();
-		atomic_set(&tsc_count_start, 0);
-		wmb();
-		atomic_inc(&tsc_count_stop);
+	while (current_slave != smp_processor_id())
+		rep_nop();
+	adjust_latency = tsc_adj_latency;
+
+	go[SLAVE] = 0;
+	go[MASTER] = 0;
+	write_tsc(0,0);
+	for (i = 0; i < NUM_ROUNDS; ++i) {
+		delta = get_delta(&rt, &master_time_stamp);
+		if (delta == 0)
+			break;
+
+		if (i > 0) 
+			adjust_latency += -delta;
+		adj = -delta + adjust_latency/8;
+		rdtscl(tsc);
+		write_tsc(tsc + adj, 0);
+#if DEBUG_TSC_SYNC
+		t[i].rt = rt;
+		t[i].master = master_time_stamp;
+		t[i].diff = delta;
+		t[i].lat = adjust_latency/8;
+#endif
 	}
+	n_rounds = i;
+	go[MASTER] = ~0;
 
-	sum = 0;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (test_bit(i, &cpu_callout_map)) {
-			t0 = tsc_values[i];
-			sum += t0;
-		}
-	}
-	avg = div64(sum, num_booting_cpus());
-
-	sum = 0;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!test_bit(i, &cpu_callout_map))
-			continue;
-		delta = tsc_values[i] - avg;
-		if (delta < 0)
-			delta = -delta;
-		/*
-		 * We report bigger than 2 microseconds clock differences.
-		 */
-		if (delta > 2*one_usec) {
-			long realdelta;
-			if (!buggy) {
-				buggy = 1;
-				printk("\n");
-			}
-			realdelta = div64(delta, one_usec);
-			if (tsc_values[i] < avg)
-				realdelta = -realdelta;
-
-			printk("BIOS BUG: CPU#%d improperly initialized, has %ld usecs TSC skew! FIXED.\n", i, realdelta);
-		}
-
-		sum += delta;
-	}
-	if (!buggy)
-		printk("passed.\n");
-		;
+#if (DEBUG_TSC_SYNC == 2)
+	for (i = 0; i < n_rounds; ++i)
+		printk("rt=%5ld master=%5ld diff=%5ld adjlat=%5ld\n",
+		       t[i].rt, t[i].master, t[i].diff, t[i].lat);
+
+	printk("CPU %d: synchronized TSC (last diff %ld cycles, maxerr %lu cycles)\n",
+	       smp_processor_id(), delta, rt);
+	
+	printk("It took %d rounds\n", n_rounds);
+#endif
+	if (rt > max_rt)
+		max_rt = rt;
+	if (delta < 0)
+		delta = -delta;
+	if (delta > max_delta)
+		max_delta = delta;
+	tsc_adj_latency = adjust_latency;
+	current_slave = -1;
+	while (!tsc_sync_complete)
+		rep_nop();
 }
 
-static void __init synchronize_tsc_ap (void)
-{
-	int i;
+/*
+ * The boot processor set its own TSC to zero and then gives each 
+ * slave processor the chance to synchronize itself.
+ */
 
-	/*
-	 * Not every cpu is online at the time
-	 * this gets called, so we first wait for the BP to
-	 * finish SMP initialization:
-	 */
-	while (!atomic_read(&tsc_start_flag)) mb();
+static void __init synchronize_tsc_bp (void)
+{
+	unsigned int tsc_low, tsc_high, error;
+	int cpu;
 
-	for (i = 0; i < NR_LOOPS; i++) {
-		atomic_inc(&tsc_count_start);
-		while (atomic_read(&tsc_count_start) != num_booting_cpus())
-			mb();
-
-		rdtscll(tsc_values[smp_processor_id()]);
-		if (i == NR_LOOPS-1)
-			write_tsc(0, 0);
+	printk("start TSC synchronization\n");
+	write_tsc(0, 0);
 
-		atomic_inc(&tsc_count_stop);
-		while (atomic_read(&tsc_count_stop) != num_booting_cpus()) mb();
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (!(cpu_callin_map & (1<<cpu)))
+			continue;
+		if (cpu == smp_processor_id())
+			continue;
+		go[MASTER] = 0;
+		current_slave = cpu;
+		sync_master();
+		while (current_slave != -1)
+			rep_nop();
+	}
+	rdtsc(tsc_low, tsc_high);
+	if (tsc_high)
+		printk("TSC overflowed during synchronization\n");
+	else 
+		printk("TSC synchronization complete max_delta=%d cycles\n",
+			max_delta);
+	if (max_rt < 4293) {
+		error = (max_rt * 1000000)/cpu_khz;
+		printk("TSC sync round-trip time %d.%03d microseconds\n",
+			error/1000, error%1000);
+	} else {
+		printk("TSC sync round-trip time %d cycles\n", max_rt);
 	}
+	tsc_sync_complete = 1;
 }
-#undef NR_LOOPS
 
 extern void calibrate_delay(void);
 
