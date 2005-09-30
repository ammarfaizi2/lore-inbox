Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbVI3At5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVI3At5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVI3At5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:49:57 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:19092 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932510AbVI3Atz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:49:55 -0400
Subject: [RFC][PATCH 7/11] generic timeofday i386 arch specific changes,
	part 3
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1128041345.8195.321.camel@cog.beaverton.ibm.com>
References: <1128040851.8195.307.camel@cog.beaverton.ibm.com>
	 <1128040939.8195.310.camel@cog.beaverton.ibm.com>
	 <1128041052.8195.312.camel@cog.beaverton.ibm.com>
	 <1128041118.8195.314.camel@cog.beaverton.ibm.com>
	 <1128041188.8195.317.camel@cog.beaverton.ibm.com>
	 <1128041282.8195.319.camel@cog.beaverton.ibm.com>
	 <1128041345.8195.321.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 17:49:51 -0700
Message-Id: <1128041391.8195.323.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
		The conversion of i386 to use the generic timeofday subsystem has been
split into 6 parts. This patch, the third of six, reworks some of the
code in the new tsc.c file, adding some new interfaces and hooks to use
these new interfaces appropriately. 

It applies on top of my timeofday-arch-i386-part2 patch. This patch is
part the timeofday-arch-i386 patchset, so without the following parts it
is not expected to compile.
	
thanks
-john

 arch/i386/kernel/setup.c                    |    1 
 arch/i386/kernel/tsc.c                      |  192 ++++++++++++++--------------
 drivers/acpi/processor_idle.c               |    6 
 include/asm-i386/mach-default/mach_timer.h  |    4 
 include/asm-i386/mach-summit/mach_mpparse.h |    2 
 include/asm-i386/tsc.h                      |    6 
 6 files changed, 118 insertions(+), 93 deletions(-)

linux-2.6.14-rc2_timeofday-arch-i386-part3_B6.patch
============================================
diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -1612,6 +1612,7 @@ void __init setup_arch(char **cmdline_p)
 	conswitchp = &dummy_con;
 #endif
 #endif
+	tsc_init();
 }
 
 #include "setup_arch_post.h"
diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -5,11 +5,17 @@
  */
 
 #include <linux/init.h>
-#include <linux/timex.h>
 #include <linux/cpufreq.h>
+#include <asm/tsc.h>
 #include <asm/io.h>
 #include "mach_timer.h"
 
+/* On some systems the TSC frequency does not
+ * change with the cpu frequency. So we need
+ * an extra value to store the TSC freq
+ */
+unsigned int tsc_khz;
+
 int tsc_disable __initdata = 0;
 #ifndef CONFIG_X86_TSC
 /* disable flag for tsc.  Takes effect by clearing the TSC cpu flag
@@ -32,15 +38,42 @@ __setup("notsc", tsc_setup);
 
 int read_current_timer(unsigned long *timer_val)
 {
-	if (cur_timer->read_timer) {
-		*timer_val = cur_timer->read_timer();
+	if (!tsc_disable && cpu_khz) {
+		rdtscl(*timer_val);
 		return 0;
 	}
 	return -1;
 }
 
+/* Code to mark and check if the TSC is unstable
+ * due to cpufreq or due to unsynced TSCs
+ */
+static int tsc_unstable;
+int check_tsc_unstable(void)
+{
+	return tsc_unstable;
+}
+
+void mark_tsc_unstable(void)
+{
+	tsc_unstable = 1;
+}
+
+/* Code to compensate for C3 stalls */
+static u64 tsc_c3_offset;
+void tsc_c3_compensate(unsigned long usecs)
+{
+	u64 cycles = (usecs * tsc_khz)/1000;
+	tsc_c3_offset += cycles;
+}
+
+u64 tsc_read_c3_time(void)
+{
+	return tsc_c3_offset;
+}
 
-/* convert from cycles(64bits) => nanoseconds (64bits)
+/* Accellerators for sched_clock()
+ * convert from cycles(64bits) => nanoseconds (64bits)
  *  basic equation:
  *		ns = cycles / (freq / ns_per_sec)
  *		ns = cycles * (ns_per_sec / freq)
@@ -80,76 +113,54 @@ unsigned long long sched_clock(void)
 	 * synchronized across all CPUs.
 	 */
 #ifndef CONFIG_NUMA
-	if (!use_tsc)
+	if (!cpu_khz || check_tsc_unstable())
 #endif
 		/* no locking but a rare wrong value is not a big deal */
-		return jiffies_64 * (1000000000 / HZ);
+		return (jiffies_64 - INITIAL_JIFFIES) * (1000000000 / HZ);
 
 	/* Read the Time Stamp Counter */
 	rdtscll(this_offset);
+	this_offset += tsc_read_c3_time();
 
 	/* return the value in ns */
 	return cycles_2_ns(this_offset);
 }
 
-/* ------ Calibrate the TSC -------
- * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
- * Too much 64-bit arithmetic here to do this cleanly in C, and for
- * accuracy's sake we want to keep the overhead on the CTC speaker (channel 2)
- * output busy loop as low as possible. We avoid reading the CTC registers
- * directly because of the awkward 8-bit access mechanism of the 82C54
- * device.
- */
-
-#define CALIBRATE_TIME	(5 * 1000020/HZ)
 
-unsigned long calibrate_tsc(void)
+static unsigned long calculate_cpu_khz(void)
 {
-	mach_prepare_counter();
-
-	{
-		unsigned long startlow, starthigh;
-		unsigned long endlow, endhigh;
-		unsigned long count;
-
-		rdtsc(startlow,starthigh);
+	unsigned long long start, end;
+	unsigned long count;
+	u64 delta64;
+	int i;
+	/* run 3 times to ensure the cache is warm */
+	for(i=0; i<3; i++) {
+		mach_prepare_counter();
+		rdtscll(start);
 		mach_countup(&count);
-		rdtsc(endlow,endhigh);
-
-
-		/* Error: ECTCNEVERSET */
-		if (count <= 1)
-			goto bad_ctc;
-
-		/* 64-bit subtract - gcc just messes up with long longs */
-		__asm__("subl %2,%0\n\t"
-			"sbbl %3,%1"
-			:"=a" (endlow), "=d" (endhigh)
-			:"g" (startlow), "g" (starthigh),
-			 "0" (endlow), "1" (endhigh));
-
-		/* Error: ECPUTOOFAST */
-		if (endhigh)
-			goto bad_ctc;
-
-		/* Error: ECPUTOOSLOW */
-		if (endlow <= CALIBRATE_TIME)
-			goto bad_ctc;
-
-		__asm__("divl %2"
-			:"=a" (endlow), "=d" (endhigh)
-			:"r" (endlow), "0" (0), "1" (CALIBRATE_TIME));
-
-		return endlow;
+		rdtscll(end);
 	}
-
-	/*
+	/* Error: ECTCNEVERSET
 	 * The CTC wasn't reliable: we got a hit on the very first read,
 	 * or the CPU was so fast/slow that the quotient wouldn't fit in
 	 * 32 bits..
 	 */
-bad_ctc:
-	return 0;
+	if (count <= 1)
+		return 0;
+
+	delta64 = end - start;
+
+	/* cpu freq too fast */
+	if(delta64 > (1ULL<<32))
+		return 0;
+	/* cpu freq too slow */
+	if (delta64 <= CALIBRATE_TIME_MSEC)
+		return 0;
+
+	delta64 += CALIBRATE_TIME_MSEC/2; /* round for do_div */
+	do_div(delta64,CALIBRATE_TIME_MSEC);
+
+	return (unsigned long)delta64;
 }
 
 int recalibrate_cpu_khz(void)
@@ -158,11 +169,11 @@ int recalibrate_cpu_khz(void)
 	unsigned long cpu_khz_old = cpu_khz;
 
 	if (cpu_has_tsc) {
-		init_cpu_khz();
+		cpu_khz = calculate_cpu_khz();
+		tsc_khz = cpu_khz;
 		cpu_data[0].loops_per_jiffy =
-		    cpufreq_scale(cpu_data[0].loops_per_jiffy,
-			          cpu_khz_old,
-				  cpu_khz);
+			cpufreq_scale(cpu_data[0].loops_per_jiffy,
+					cpu_khz_old, cpu_khz);
 		return 0;
 	} else
 		return -ENODEV;
@@ -173,25 +184,22 @@ int recalibrate_cpu_khz(void)
 EXPORT_SYMBOL(recalibrate_cpu_khz);
 
 
-/* calculate cpu_khz */
-void init_cpu_khz(void)
+void tsc_init(void)
 {
-	if (cpu_has_tsc) {
-		unsigned long tsc_quotient = calibrate_tsc();
-		if (tsc_quotient) {
-			/* report CPU clock rate in Hz.
-			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
-			 * clock/second. Our precision is about 100 ppm.
-			 */
-			{	unsigned long eax=0, edx=1000;
-				__asm__("divl %2"
-		       		:"=a" (cpu_khz), "=d" (edx)
-        	       		:"r" (tsc_quotient),
-	                	"0" (eax), "1" (edx));
-				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
-			}
-		}
-	}
+	if(!cpu_has_tsc || tsc_disable)
+		return;
+
+	cpu_khz = calculate_cpu_khz();
+	tsc_khz = cpu_khz;
+
+	if (!cpu_khz)
+		return;
+
+	printk("Detected %lu.%03lu MHz processor.\n",
+				(unsigned long)cpu_khz / 1000, 
+				(unsigned long)cpu_khz % 1000);
+
+	set_cyc2ns_scale(cpu_khz/1000);
 }
 
 
@@ -211,15 +219,15 @@ static void handle_cpufreq_delayed_get(v
 	cpufreq_delayed_issched = 0;
 }
 
-/* if we notice lost ticks, schedule a call to cpufreq_get() as it tries
+/* if we notice cpufreq oddness, schedule a call to cpufreq_get() as it tries
  * to verify the CPU frequency the timing core thinks the CPU is running
  * at is still correct.
  */
-void cpufreq_delayed_get(void)
+static inline void cpufreq_delayed_get(void)
 {
 	if (cpufreq_init && !cpufreq_delayed_issched) {
 		cpufreq_delayed_issched = 1;
-		printk(KERN_DEBUG "Losing some ticks... checking if CPU frequency changed.\n");
+		printk(KERN_DEBUG "Checking if CPU frequency changed.\n");
 		schedule_work(&cpufreq_delayed_get_work);
 	}
 }
@@ -232,13 +240,11 @@ static unsigned int  ref_freq = 0;
 static unsigned long loops_per_jiffy_ref = 0;
 
 #ifndef CONFIG_SMP
-static unsigned long fast_gettimeoffset_ref = 0;
 static unsigned long cpu_khz_ref = 0;
 #endif
 
-static int
-time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
-		       void *data)
+static int time_cpufreq_notifier(struct notifier_block *nb,
+		unsigned long val, void *data)
 {
 	struct cpufreq_freqs *freq = data;
 
@@ -248,7 +254,6 @@ time_cpufreq_notifier(struct notifier_bl
 		ref_freq = freq->old;
 		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
 #ifndef CONFIG_SMP
-		fast_gettimeoffset_ref = fast_gettimeoffset_quotient;
 		cpu_khz_ref = cpu_khz;
 #endif
 	}
@@ -258,16 +263,20 @@ time_cpufreq_notifier(struct notifier_bl
 	    (val == CPUFREQ_RESUMECHANGE)) {
 		if (!(freq->flags & CPUFREQ_CONST_LOOPS))
 			cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
+
+		if (cpu_khz) {
 #ifndef CONFIG_SMP
-		if (cpu_khz)
 			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
-		if (use_tsc) {
+#endif
 			if (!(freq->flags & CPUFREQ_CONST_LOOPS)) {
-				fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
+				tsc_khz = cpu_khz;
 				set_cyc2ns_scale(cpu_khz/1000);
+				/* TSC based sched_clock turns
+				 * to junk w/ cpufreq
+				 */
+				mark_tsc_unstable();
 			}
 		}
-#endif
 	}
 
 	if (val != CPUFREQ_RESUMECHANGE)
@@ -289,10 +298,9 @@ static int __init cpufreq_tsc(void)
 					CPUFREQ_TRANSITION_NOTIFIER);
 	if (!ret)
 		cpufreq_init = 1;
+
 	return ret;
 }
 core_initcall(cpufreq_tsc);
 
-#else /* CONFIG_CPU_FREQ */
-void cpufreq_delayed_get(void) { return; }
 #endif
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -166,6 +166,7 @@ acpi_processor_power_activate(struct acp
 	return;
 }
 
+extern void tsc_c3_compensate(unsigned long usecs);
 static atomic_t c3_cpu_count;
 
 static void acpi_processor_idle(void)
@@ -334,6 +335,11 @@ static void acpi_processor_idle(void)
 					  ACPI_MTX_DO_NOT_LOCK);
 		}
 
+#ifdef CONFIG_GENERICTOD
+		/* compensate for TSC pause */
+		tsc_c3_compensate((((t2-t1)&0xFFFFFF)*286)>>10);
+#endif
+
 		/* Re-enable interrupts */
 		local_irq_enable();
 		/* Compute time (ticks) that we were actually asleep */
diff --git a/include/asm-i386/mach-default/mach_timer.h b/include/asm-i386/mach-default/mach_timer.h
--- a/include/asm-i386/mach-default/mach_timer.h
+++ b/include/asm-i386/mach-default/mach_timer.h
@@ -15,7 +15,9 @@
 #ifndef _MACH_TIMER_H
 #define _MACH_TIMER_H
 
-#define CALIBRATE_LATCH	(5 * LATCH)
+#define CALIBRATE_TIME_MSEC 30 /* 30 msecs */
+#define CALIBRATE_LATCH	\
+	((CLOCK_TICK_RATE * CALIBRATE_TIME_MSEC + 1000/2)/1000)
 
 static inline void mach_prepare_counter(void)
 {
diff --git a/include/asm-i386/mach-summit/mach_mpparse.h b/include/asm-i386/mach-summit/mach_mpparse.h
--- a/include/asm-i386/mach-summit/mach_mpparse.h
+++ b/include/asm-i386/mach-summit/mach_mpparse.h
@@ -30,6 +30,7 @@ static inline int mps_oem_check(struct m
 			(!strncmp(productid, "VIGIL SMP", 9) 
 			 || !strncmp(productid, "EXA", 3)
 			 || !strncmp(productid, "RUTHLESS SMP", 12))){
+		mark_tsc_unstable();
 		use_cyclone = 1; /*enable cyclone-timer*/
 		setup_summit();
 		usb_early_handoff = 1;
@@ -44,6 +45,7 @@ static inline int acpi_madt_oem_check(ch
 	if (!strncmp(oem_id, "IBM", 3) &&
 	    (!strncmp(oem_table_id, "SERVIGIL", 8)
 	     || !strncmp(oem_table_id, "EXA", 3))){
+		mark_tsc_unstable();
 		use_cyclone = 1; /*enable cyclone-timer*/
 		setup_summit();
 		usb_early_handoff = 1;
diff --git a/include/asm-i386/tsc.h b/include/asm-i386/tsc.h
--- a/include/asm-i386/tsc.h
+++ b/include/asm-i386/tsc.h
@@ -41,4 +41,10 @@ static inline cycles_t get_cycles (void)
 }
 
 extern unsigned int cpu_khz;
+extern unsigned int tsc_khz;
+extern void tsc_init(void);
+void tsc_c3_compensate(unsigned long usecs);
+u64 tsc_read_c3_time(void);
+extern int check_tsc_unstable(void);
+extern void mark_tsc_unstable(void);
 #endif


