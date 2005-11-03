Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751259AbVKCWNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbVKCWNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbVKCWNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:13:22 -0500
Received: from gamail.ccur.com ([66.10.137.10]:41663 "EHLO gamail.ccur.com")
	by vger.kernel.org with ESMTP id S1751259AbVKCWNV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:13:21 -0500
Subject: Re: 2.6.14-rc4-rt7 - [PATCH] improved boot time TSC synchronization
From: Jim Houston <jim.houston@ccur.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: George Anzinger <george@mvista.com>, john stultz <johnstul@us.ibm.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU, William Weston <weston@lysdexia.org>
In-Reply-To: <20051026082800.GB28660@elte.hu>
References: <1129852531.5227.4.camel@cmn3.stanford.edu>
	 <20051021080504.GA5088@elte.hu> <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <20051022035851.GC12751@elte.hu>
	 <1130182121.4983.7.camel@cmn3.stanford.edu>
	 <1130182717.4637.2.camel@cmn3.stanford.edu>
	 <1130183199.27168.296.camel@cog.beaverton.ibm.com>
	 <20051025154440.GA12149@elte.hu>
	 <1130264218.27168.320.camel@cog.beaverton.ibm.com>
	 <435E91AA.7080900@mvista.com>  <20051026082800.GB28660@elte.hu>
Content-Type: text/plain
Organization: Concurrent Computer Corp.
Message-Id: <1131055990.3145.172.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 03 Nov 2005 17:13:10 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Nov 2005 22:13:14.0245 (UTC) FILETIME=[C8D31B50:01C5E0C3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-26 at 04:28, Ingo Molnar wrote:

> The box where i have these small TSC inconsistencies shows that it's the 
> bootup synchronization of TSCs that failed to be 100% accurate. Even a 2 
> usecs error in synchronization can show up as a time-warp - regardless 
> of whether we keep per-CPU TSC offsets or whether we clear these offsets 
> back to 0. So it is not a solution to do another type of synchronization 
> dance. The only solution is to fix the boot-time synchronization (where 
> the hardware keeps TSCs synchronized all the time), or to switch TSCs 
> off where this is not possible.
> 
> 	Ingo

Hi Ingo, Everyone,

I adapted the IA-64 ITC synchronization code to synchronize the
TSC for i386 and posted a patch in Jan 2003.  It is here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=104273559400918&w=2

I'm including a version updated to linux-2.6.13.

The existing i386 code trys to synchronize all of the processors
at once.  It sets a global flag and expects all of the processors
to notice it change at the same time.  All of the processors see
a cache invalidate on the bus but then they have to queue up and
do a read cycle.  This results in s systematic error where each
additional cpu is delayed by the time it takes to arbitrate the
bus and complete the read.

The IA-64 code works with pairs of processors and uses a feedback
loop to compensate for the bus latency and the overhead of adjusting
the ITC.

Andi Kleen has recently done the same work for x86_64.

Jim Houston - Concurrent Computer Corp.

--- linux-2.6.13/arch/i386/kernel/smpboot.c.0	2005-10-25 16:01:53.000000000 -0400
+++ linux-2.6.13/arch/i386/kernel/smpboot.c	2005-11-03 16:41:12.000000000 -0500
@@ -211,141 +211,231 @@
 }
 
 /*
- * TSC synchronization.
- *
- * We first check whether all CPUs have their TSC's synchronized,
- * then we print a warning if not, and always resync.
+ * TSC synchronization based on ia64 itc synchronization code.  Synchronize
+ * pairs of processors rahter than tring to synchronize all of the processors
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
+#define MASTER	0
+#define SLAVE	(SMP_CACHE_BYTES/sizeof(long))
 
-#define NR_LOOPS 5
+#define NUM_ROUNDS	64	/* magic value */
+#define NUM_ITERS	5	/* likewise */
 
-static void __init synchronize_tsc_bp (void)
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
+
+void
+sync_master(void)
 {
-	int i;
-	unsigned long long t0;
-	unsigned long long sum, avg;
-	long long delta;
-	unsigned int one_usec;
-	int buggy = 0;
+	unsigned long  n, tsc, last_go_master;
 
-	printk(KERN_INFO "checking TSC synchronization across %u CPUs: ", num_booting_cpus());
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
+}
 
-	/* convert from kcyc/sec to cyc/usec */
-	one_usec = cpu_khz / 1000;
+/*
+ * Return the number of cycles by which our TSC differs from the TSC on
+ * the master (time-keeper) CPU.  A positive number indicates our TSC is
+ * ahead of the master, negative that it is behind.
+ */
+static inline long
+get_delta (long *rt, long *master)
+{
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
+
+	*rt = best_t1 - best_t0;
+	*master = best_tm - best_t0;
+
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
+	while (current_slave != smp_processor_id())
+		rep_nop();
+	adjust_latency = tsc_adj_latency;
 
-		/*
-		 * Wait for all APs to leave the synchronization point:
-		 */
-		while (atomic_read(&tsc_count_stop) != num_booting_cpus()-1)
-			mb();
-		atomic_set(&tsc_count_start, 0);
-		wmb();
-		atomic_inc(&tsc_count_stop);
-	}
+	go[SLAVE] = 0;
+	go[MASTER] = 0;
+	write_tsc(0,0);
+	for (i = 0; i < NUM_ROUNDS; ++i) {
+		delta = get_delta(&rt, &master_time_stamp);
+		if (delta == 0)
+			break;
 
-	sum = 0;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (cpu_isset(i, cpu_callout_map)) {
-			t0 = tsc_values[i];
-			sum += t0;
-		}
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
-	avg = sum;
-	do_div(avg, num_booting_cpus());
+	n_rounds = i;
+	go[MASTER] = ~0;
 
-	sum = 0;
-	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_isset(i, cpu_callout_map))
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
-			realdelta = delta;
-			do_div(realdelta, one_usec);
-			if (tsc_values[i] < avg)
-				realdelta = -realdelta;
-
-			printk(KERN_INFO "CPU#%d had %ld usecs TSC skew, fixed it up.\n", i, realdelta);
-		}
+#if (DEBUG_TSC_SYNC == 2)
+	for (i = 0; i < n_rounds; ++i)
+		printk("rt=%5ld master=%5ld diff=%5ld adjlat=%5ld\n",
+		       t[i].rt, t[i].master, t[i].diff, t[i].lat);
 
-		sum += delta;
-	}
-	if (!buggy)
-		printk("passed.\n");
+	printk("CPU %d: synchronized TSC (last diff %ld cycles, maxerr %lu cycles)\n",
+	       smp_processor_id(), delta, rt);
+	
+	printk("It took %ld rounds\n", n_rounds);
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
-
-	/*
-	 * Not every cpu is online at the time
-	 * this gets called, so we first wait for the BP to
-	 * finish SMP initialization:
-	 */
-	while (!atomic_read(&tsc_start_flag)) mb();
+/*
+ * The boot processor set its own TSC to zero and then gives each 
+ * slave processor the chance to synchronize itself.
+ */
 
-	for (i = 0; i < NR_LOOPS; i++) {
-		atomic_inc(&tsc_count_start);
-		while (atomic_read(&tsc_count_start) != num_booting_cpus())
-			mb();
+static void __init synchronize_tsc_bp (void)
+{
+	unsigned int tsc_low, tsc_high, error;
+	int cpu;
 
-		rdtscll(tsc_values[smp_processor_id()]);
-		if (i == NR_LOOPS-1)
-			write_tsc(0, 0);
+	printk("start TSC synchronization\n");
+	write_tsc(0, 0);
 
-		atomic_inc(&tsc_count_stop);
-		while (atomic_read(&tsc_count_stop) != num_booting_cpus()) mb();
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (!cpu_isset(cpu, cpu_callout_map))
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
 



