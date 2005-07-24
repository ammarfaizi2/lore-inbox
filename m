Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVGXEwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVGXEwK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 00:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVGXEwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 00:52:10 -0400
Received: from petasus.ims.intel.com ([62.118.80.130]:3972 "EHLO
	petasus.ims.intel.com") by vger.kernel.org with ESMTP
	id S261293AbVGXEwI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 00:52:08 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [patch 1/] timers: tsc using for cpu scheduling
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Sun, 24 Jul 2005 08:51:56 +0400
Message-ID: <6694B22B6436BC43B429958787E454980D6B48@mssmsx402nb>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/] timers: tsc using for cpu scheduling
Thread-Index: AcWBzAO5na7nAD/yTdqTweWHV7GOdQNNS66Q
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: "lkml" <linux-kernel@vger.kernel.org>, "john stultz" <johnstul@us.ibm.com>
Cc: "Dominik Brodowski" <linux@dominikbrodowski.de>,
       "Semenikhin, Sergey V" <sergey.v.semenikhin@intel.com>
X-OriginalArrivalTime: 24 Jul 2005 04:51:57.0266 (UTC) FILETIME=[6B822B20:01C5900B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I should underline that patch deal with the alternative which timer to
use for task priority calculation when both TSC and PMT function.

You writes
> it will need some additional documentation and its likely you don't
want
> to use the cycles_2_ns() functions.

	It is not need any additional documentation because using CPU
time as a measure of CPU work for scheduling is described in the Linux
kernel books. But when PMT was added in computers it was nominated for
scheduling time measurement because TSC may miss 2-3 clocks during CPU
frequency variation. But in that frequency variation period instruction
ticks are missed as well as TSC ticks. So TSC using is more correct in
this case. My patch returns only to original way scheduling time
calculation.

	About NUMA Chen Kenneth gives argument:
> It is safe to use cpu local rdtsc since the scheduler will never
consume > > two timestamps taken from two different cpus.

I have added a comment in the patched source code according to your
recommends:
+ * It is not recommended to use this function for other than scheduler
purposes
+ * when time marks may be get on different cpus or cpu frequency is
varied.

You write
> As it was written it would have broken NUMAQ and other systems that do
> not have usable TSCs (ie: i386/i486).

According to documentation TSC presents in IA32 any computer. But:
	 *	NOTE: this doesn't yet handle SMP 486 machines where
only
 	 *	some CPU's have a TSC. Thats never worked and nobody has
 	 *	moaned if you have the only one in the world - you fix
it!
- says  arch/i386/kernel/timers/timer_tsc.c

You are right. It is good to save check and I restored it:
+	if (!cyc2ns_scale)
+		return jiffies_64 * (1000000000 / HZ);

The patch:

diff -ur a/arch/i386/kernel/timers/common.c
b/arch/i386/kernel/timers/common.c
--- a/arch/i386/kernel/timers/common.c	2005-06-17 23:48:29.000000000
+0400
+++ b/arch/i386/kernel/timers/common.c	2005-07-17 23:02:16.000000000
+0400
@@ -138,6 +138,48 @@
 	return 0;
 }
 #endif
+/* convert from cycles(64bits) => nanoseconds (64bits)
+ *  basic equation:
+ *		ns = cycles / (freq / ns_per_sec)
+ *		ns = cycles * (ns_per_sec / freq)
+ *		ns = cycles * (10^9 / (cpu_mhz * 10^6))
+ *		ns = cycles * (10^3 / cpu_mhz)
+ *
+ *	Then we use scaling math (suggested by george@mvista.com) to
get:
+ *		ns = cycles * (10^3 * SC / cpu_mhz) / SC
+ *		ns = cycles * cyc2ns_scale / SC
+ *
+ *	And since SC is a constant power of two, we can convert the div
+ *  into a shift.   
+ *			-johnstul@us.ibm.com "math is hard, lets go
shopping!"
+ */
+unsigned long cyc2ns_scale; 
+#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
+
+inline void set_cyc2ns_scale(unsigned long cpu_mhz)
+{
+	cyc2ns_scale = (1000 << CYC2NS_SCALE_FACTOR)/cpu_mhz;
+}
+inline unsigned long long cycles_2_ns(unsigned long long cyc)
+{
+	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
+}
+/*
+ * Scheduler clock - returns current time in nanosec units.
+ * It is not recommended to use this function for other than scheduler
purposes
+ * when time marks may be get on different cpus or cpu frequency is
varied.
+ */
+unsigned long long sched_clock(void)
+{
+	unsigned long long this_offset;
+
+	if (!cyc2ns_scale)
+		/* no locking but a rare wrong value is not a big deal
*/
+		return jiffies_64 * (1000000000 / HZ);
+
+	rdtscll(this_offset);
+	return cycles_2_ns(this_offset);
+}
 
 /* calculate cpu_khz */
 void init_cpu_khz(void)
@@ -156,6 +198,7 @@
 	                	"0" (eax), "1" (edx));
 				printk("Detected %lu.%03lu MHz
processor.\n", cpu_khz / 1000, cpu_khz % 1000);
 			}
+			set_cyc2ns_scale(cpu_khz/1000);
 		}
 	}
 }
diff -ur a/arch/i386/kernel/timers/timer_hpet.c
b/arch/i386/kernel/timers/timer_hpet.c
--- a/arch/i386/kernel/timers/timer_hpet.c	2005-06-17
23:48:29.000000000 +0400
+++ b/arch/i386/kernel/timers/timer_hpet.c	2005-07-17
22:28:00.000000000 +0400
@@ -26,34 +26,6 @@
 static unsigned long long monotonic_base;
 static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
 
-/* convert from cycles(64bits) => nanoseconds (64bits)
- *  basic equation:
- *		ns = cycles / (freq / ns_per_sec)
- *		ns = cycles * (ns_per_sec / freq)
- *		ns = cycles * (10^9 / (cpu_mhz * 10^6))
- *		ns = cycles * (10^3 / cpu_mhz)
- *
- *	Then we use scaling math (suggested by george@mvista.com) to
get:
- *		ns = cycles * (10^3 * SC / cpu_mhz) / SC
- *		ns = cycles * cyc2ns_scale / SC
- *
- *	And since SC is a constant power of two, we can convert the div
- *  into a shift.
- *			-johnstul@us.ibm.com "math is hard, lets go
shopping!"
- */
-static unsigned long cyc2ns_scale;
-#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
-
-static inline void set_cyc2ns_scale(unsigned long cpu_mhz)
-{
-	cyc2ns_scale = (1000 << CYC2NS_SCALE_FACTOR)/cpu_mhz;
-}
-
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
-{
-	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
-}
-
 static unsigned long long monotonic_clock_hpet(void)
 {
 	unsigned long long last_offset, this_offset, base;
diff -ur a/arch/i386/kernel/timers/timer_tsc.c
b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	2005-06-17
23:48:29.000000000 +0400
+++ b/arch/i386/kernel/timers/timer_tsc.c	2005-07-17
22:28:00.000000000 +0400
@@ -37,7 +37,6 @@
 
 extern spinlock_t i8253_lock;
 
-static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
@@ -46,34 +45,6 @@
 static unsigned long long monotonic_base;
 static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
 
-/* convert from cycles(64bits) => nanoseconds (64bits)
- *  basic equation:
- *		ns = cycles / (freq / ns_per_sec)
- *		ns = cycles * (ns_per_sec / freq)
- *		ns = cycles * (10^9 / (cpu_mhz * 10^6))
- *		ns = cycles * (10^3 / cpu_mhz)
- *
- *	Then we use scaling math (suggested by george@mvista.com) to
get:
- *		ns = cycles * (10^3 * SC / cpu_mhz) / SC
- *		ns = cycles * cyc2ns_scale / SC
- *
- *	And since SC is a constant power of two, we can convert the div
- *  into a shift.   
- *			-johnstul@us.ibm.com "math is hard, lets go
shopping!"
- */
-static unsigned long cyc2ns_scale; 
-#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
-
-static inline void set_cyc2ns_scale(unsigned long cpu_mhz)
-{
-	cyc2ns_scale = (1000 << CYC2NS_SCALE_FACTOR)/cpu_mhz;
-}
-
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
-{
-	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
-}
-
 static int count2; /* counter for mark_offset_tsc() */
 
 /* Cached *multiplier* to convert TSC counts to microseconds.
@@ -131,30 +102,6 @@
 	return base + cycles_2_ns(this_offset - last_offset);
 }
 
-/*
- * Scheduler clock - returns current time in nanosec units.
- */
-unsigned long long sched_clock(void)
-{
-	unsigned long long this_offset;
-
-	/*
-	 * In the NUMA case we dont use the TSC as they are not
-	 * synchronized across all CPUs.
-	 */
-#ifndef CONFIG_NUMA
-	if (!use_tsc)
-#endif
-		/* no locking but a rare wrong value is not a big deal
*/
-		return jiffies_64 * (1000000000 / HZ);
-
-	/* Read the Time Stamp Counter */
-	rdtscll(this_offset);
-
-	/* return the value in ns */
-	return cycles_2_ns(this_offset);
-}
-
 static void delay_tsc(unsigned long loops)
 {
 	unsigned long bclock, now;
@@ -284,7 +231,7 @@
 #ifndef CONFIG_SMP
 		if (cpu_khz)
 			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq,
freq->new);
-		if (use_tsc) {
+		if (cyc2ns_scale) {
 			if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
 				fast_gettimeoffset_quotient =
cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
 				set_cyc2ns_scale(cpu_khz/1000);
@@ -520,7 +467,6 @@
 
 		if (tsc_quotient) {
 			fast_gettimeoffset_quotient = tsc_quotient;
-			use_tsc = 1;
 			/*
 			 *	We could be more selective here I
suspect
 			 *	and just enable this for the next intel
chips ?



-----Original Message-----
From: john stultz [mailto:johnstul@us.ibm.com] 
Sent: Wednesday, July 06, 2005 5:43 AM
To: Ananiev, Leonid I
Cc: lkml; Dominik Brodowski; Semenikhin, Sergey V
Subject: RE: [patch 1/] timers: tsc using for cpu scheduling

On Tue, 2005-07-05 at 21:08 +0400, Ananiev, Leonid I wrote:
> 	Not only page faults may increase process priority. Someone can
> write two threads with mutexes so that each thread will spent much
less
> than 1 msec for calculations on cpu than lock-unlock mutexes and yield
> cpu to brother which wait mutex unlock and will do the same. Both
> threads will have high priority according to other threads during
> infinite time. The scheduler will not see the time spent by both
> considered threads on cpu.

Oh, I don't doubt there is a problem. I'm just asking if using the TSC
is really the only way to properly ding the process? 

I'm not a scheduler guy, so forgive my ignorance, but since the TSC may
not be available everywhere, might there be an alternative way to ding
the process? Surely something is keeping track of how many pagefaults a
process causes. Maybe a counter of how many times it has switched off
the cpu within the current tick? Couldn't these values be used as
scheduler weights?

I realize that ideally having super a fine grained notion of how much
cputime every process has had executing would be great. But it isn't
possible everywhere, so what can we do instead?

> 	The cpu scheduler does not need in real time value. It is need
> the number of cpu clocks spent for considered task/thread for priority
> calculation. It is not need to modify TSC tick rate for cpu
scheduling.

The problem is that some CPUs give you time, others give you work, and
sometimes those values are related. If you really want to re-define
sched_clock so that it gives you some vague work-unit instead of
nanoseconds, then that's fine, but it will need some additional
documentation and its likely you don't want to use the cycles_2_ns()
functions.

I don't really care too much about changes to sched_clock() as its
always been a special case interface just for the scheduler. I just want
it documented well enough so others don't think its a valid timekeeping
interface.


> 	The TSC can be used for priority calculation in NUMA because we
> do not compare TSCs of different cpu's. 

If you can guarantee that, then great! I know that was the original
intention, but some folks had problems with it which resulting in the
conditional #if NUMA code.


> > there are other cases where the TSC cannot be used for
> > sched_clock, such as on systems that do not have TSCs...
> 
> > You're patch removes any fallback for the case where the TSC cannot
be
> used.
> No. Now there is two global kernel values: cyc2ns_scale and use_tsc.
> We may say that
>  	use_tsc = (cyc2ns_scale != 0);
> Now instead of 
>  'if (use_tsc) than ...'
> 					I propose to write
>  'if ((cyc2ns_scale != 0) than...'


That's fine if its what you propose, I just didn't see it in your patch.
As it was written it would have broken NUMAQ and other systems that do
not have usable TSCs (ie: i386/i486).

> > This I don't agree with because there are situations where we cannot
> use
> the TSC.
> 
> The patch says that if there are PMT and TSC timers concurrently than
> Linux will use TSC for CPU scheduler priority calculatin.
> 1 millisecond jiffies on the base of PMT were used patch in Linux
before
> this. So user can see that if CPU has TSC it is worst than CPU which
has
> not TSC because Linux choose slightly more precise but exactly 1000000
> times more gross variant in this case.

Try re-spinning the patch to address the above issues and I'll happily
review it again. I just want to make sure the issue is addressed
properly and doesn't break other systems.

thanks
-john



