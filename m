Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262663AbVF3LoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262663AbVF3LoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 07:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262944AbVF3LoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 07:44:08 -0400
Received: from petasus.ims.intel.com ([62.118.80.130]:61151 "EHLO
	petasus.ims.intel.com") by vger.kernel.org with ESMTP
	id S262663AbVF3Lnt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 07:43:49 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: [patch 1/] timers: tsc using for cpu scheduling
Date: Thu, 30 Jun 2005 15:43:46 +0400
Message-ID: <6EDC9204B3704C4C8522539D5C1185E5019D060F@mssmsx403.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [patch 1/] timers: tsc using for cpu scheduling
thread-index: AcV9aPlYfhei4KAVRJim5XMgVQ55cg==
From: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Jun 2005 11:43:47.0425 (UTC) FILETIME=[F9FF3510:01C57D68]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

		Patch for using TSC but not PMT in cpu scheduler.

	It was noted that under high memory load the process which
generates a lot page faults does not lose own priority at all if
processor has Power Management Timer (PMT) and for this reason Linux
uses jiffies_64 for process priority calculation instead of Time Stamp
Clock (TSC). As a result time is measured with 1000000 nsec granularity:
				if (!use_tsc)
					return jiffies_64 * (1000000000
/ HZ);
	If process regularly uses processor much less than 1 msec
scheduler does not see processor using by this process and does not
decrease priority of process as it is performed on platforms which have
not PMT or PMT using is suppressed in .config file. The "list of timers,
ordered by preference" in linux kernel dictates to use Power Management
timer, if it is on processor and measure process run time in
milliseconds (jiffies) actually but not in nanoseconds. As a result the
process which provoke to memory threshing and bad cpu and cash using has
much higher priority than regular interactive process. You can see that
cpu using time grows (it is measured by other way - not by function
sched_clock()) but priority is not bring down and the process is
considered as high priority interactive one.
It is known that TSC is incorrect according to astronomical real time as
a result of PM throttling. But for scheduler purposes the value of work
executed for each process but not real time spent on cpu makes sense.
The scheduler actually does not consider process run time as a real
time: it uses division of variable run_time  on CURRENT_BONUS before
comparison it with sleep average time:
			run_time /= CURRENT_BONUS;
			task->sleep_avg -= run_time;
	So run_time is not a real time but some measure of cpu work
which is performed for current process and we have the right and have to
use TSC for scheduler purpose if TSC is there on processor and does
function. Proposed patch makes corresponding modifications. The
multiplier value which is used for converting TSC ticks to nanoseconds
in function cycles_2_ns() may be corrected when cpu frequency is changed
and so scheduler will use ajusted time.  But it is not necessarily if we
agree to measure processor work but not processor time for scheduling.
If CPU clock speed is variable (PM throttling) it is more correctly to
use TSC for processor work performed for each process measuring.
If PMT and jiffies is used for scheduler, some times run_time will be
increased by 1,000,000 nanoseconds if between begin and end scheduler
time marks the variable jiffies_64 is increased. It seams that run_time
will be correct on average. It is not so because the events 'mark begin
run' and 'jiffies increase' are not independent. They are very
dependant. Task gets CPU just after jiffies modification.
The patch for using TSC in sched_clock() function is divided on two
parts: first part moves duplicated code lines from  timer_tsc.c and
timer_hpet.c to common.c. Second patch deletes global variable use_tsc;
makes function sched_clock() to use TSC only. . Now the variable
cyc2ns_scale may be used instead of use_tsc because this variable is not
0 if kernel had tested TSC successfully.

	Patch moves duplicated code lines from  timer_tsc.c and
timer_hpet.c to common.c:

--- a/arch/i386/kernel/timers/common.c	2005-06-14 15:35:20.000000000
+0400
+++ b/arch/i386/kernel/timers/common.c	2005-06-16 18:39:03.000000000
+0400
@@ -138,6 +138,32 @@
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
 
 /* calculate cpu_khz */
 void init_cpu_khz(void)
@@ -156,6 +182,7 @@
 	                	"0" (eax), "1" (edx));
 				printk("Detected %lu.%03lu MHz
processor.\n", cpu_khz / 1000, cpu_khz % 1000);
 			}
+			set_cyc2ns_scale(cpu_khz/1000);
 		}
 	}
 }
--- a/arch/i386/kernel/timers/timer_hpet.c	2005-06-14
15:35:20.000000000 +0400
+++ b/arch/i386/kernel/timers/timer_hpet.c	2005-06-16
17:04:20.000000000 +0400
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
--- a/arch/i386/kernel/timers/timer_tsc.c	2005-06-14
15:35:20.000000000 +0400
+++ b/arch/i386/kernel/timers/timer_tsc.c	2005-06-16
18:46:40.000000000 +0400
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

Patch for using TSC in cpu scheduler:
--- a/arch/i386/kernel/timers/common.c	2005-06-20 15:34:10.000000000
+0400
+++ b/arch/i386/kernel/timers/common.c	2005-06-20 16:42:13.000000000
+0400
@@ -164,6 +164,16 @@
 {
 	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
 }
+/*
+ * Scheduler clock - returns current time in nanosec units.
+ */
+unsigned long long sched_clock(void)
+{
+	unsigned long long this_offset;
+
+	rdtscll(this_offset);
+	return cycles_2_ns(this_offset);
+}
 
 /* calculate cpu_khz */
 void init_cpu_khz(void)
--- a/arch/i386/kernel/timers/timer_tsc.c	2005-06-20
15:34:10.000000000 +0400
+++ b/arch/i386/kernel/timers/timer_tsc.c	2005-06-20
16:47:50.000000000 +0400
@@ -37,7 +37,6 @@
 
 extern spinlock_t i8253_lock;
 
-static int use_tsc;
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
 
@@ -103,30 +102,6 @@
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
@@ -256,7 +231,7 @@
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
@@ -492,7 +467,6 @@
 
 		if (tsc_quotient) {
 			fast_gettimeoffset_quotient = tsc_quotient;
-			use_tsc = 1;
 			/*
 			 *	We could be more selective here I
suspect
 			 *	and just enable this for the next intel
chips ?

Leonid Ananiev
leonid.i.ananiev@intel.com
