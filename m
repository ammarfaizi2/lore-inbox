Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVFRDH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVFRDH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 23:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVFRDH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 23:07:57 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:32991 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261837AbVFRDBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 23:01:41 -0400
Subject: [PATCH 4/6] new timeofday i386 arch specific changes, part 3 for
	-mm (v.B3)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, kernel-stuff@comcast.net, frank@tuxrocks.com
In-Reply-To: <1119063557.9663.6.camel@cog.beaverton.ibm.com>
References: <1119063400.9663.2.camel@cog.beaverton.ibm.com>
	 <1119063484.9663.4.camel@cog.beaverton.ibm.com>
	 <1119063557.9663.6.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 17 Jun 2005 20:01:29 -0700
Message-Id: <1119063690.9947.1.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, All,
	To hopefully improve the review-ability of my changes, I've split up my
arch-i386 patch into four chunks. This patch reworks some of the code in
the new tsc.c file. Additionally it adds some new interfaces and hooks
to use these new interfaces appropriately.  This patch also renames some
ACPI PM variables. 

It applies on top of my timeofday-arch-i386-part2_B3 patch. This patch
is part the timeofday-arch-i386 patchset, so without the following parts
it is not expected to compile.
	
Andrew, please consider for inclusion for testing into your tree.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

linux-2.6.12-rc6-mm1_timeofday-arch-i386-part3_B3.patch
=======================================================
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/acpi/boot.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/acpi/boot.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/acpi/boot.c	2005-06-17 19:32:40.000000000 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/acpi/boot.c	2005-06-17 19:34:48.010995694 -0700
@@ -607,7 +607,8 @@
 #endif
 
 #ifdef CONFIG_X86_PM_TIMER
-extern u32 pmtmr_ioport;
+u32 acpi_pmtmr_ioport;
+int acpi_pmtmr_buggy;
 #endif
 
 static int __init acpi_parse_fadt(unsigned long phys, unsigned long size)
@@ -638,13 +639,13 @@
 		if (fadt->xpm_tmr_blk.address_space_id != ACPI_ADR_SPACE_SYSTEM_IO)
 			return 0;
 
-		pmtmr_ioport = fadt->xpm_tmr_blk.address;
+		acpi_pmtmr_ioport = fadt->xpm_tmr_blk.address;
 	} else {
 		/* FADT rev. 1 */
-		pmtmr_ioport = fadt->V1_pm_tmr_blk;
+		acpi_pmtmr_ioport = fadt->V1_pm_tmr_blk;
 	}
-	if (pmtmr_ioport)
-		printk(KERN_INFO PREFIX "PM-Timer IO Port: %#x\n", pmtmr_ioport);
+	if (acpi_pmtmr_ioport)
+		printk(KERN_INFO PREFIX "PM-Timer IO Port: %#x\n", acpi_pmtmr_ioport);
 #endif
 	return 0;
 }
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/setup.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/setup.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/setup.c	2005-06-17 19:32:40.000000000 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/setup.c	2005-06-17 19:34:48.012995445 -0700
@@ -1610,6 +1610,7 @@
 	conswitchp = &dummy_con;
 #endif
 #endif
+	tsc_init();
 }
 
 #include "setup_arch_post.h"
diff -ruN linux-2.6.12-rc6-mm1/arch/i386/kernel/tsc.c linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/tsc.c
--- linux-2.6.12-rc6-mm1/arch/i386/kernel/tsc.c	2005-06-17 19:32:40.000000000 -0700
+++ linux-2.6.12-rc6-mm1-tod/arch/i386/kernel/tsc.c	2005-06-17 19:35:10.108247154 -0700
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
+unsigned long tsc_khz;
+
 int tsc_disable __initdata = 0;
 #ifndef CONFIG_X86_TSC
 /* disable flag for tsc.  Takes effect by clearing the TSC cpu flag
@@ -32,15 +38,43 @@
 
 int read_current_timer(unsigned long *timer_val)
 {
-	if (cur_timer->read_timer) {
-		*timer_val = cur_timer->read_timer();
+	if (!tsc_disable && cpu_khz) {
+		rdtscl(*timer_val);;
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
+
 
-/* convert from cycles(64bits) => nanoseconds (64bits)
+/* Accellerators for sched_clock()
+ * convert from cycles(64bits) => nanoseconds (64bits)
  *  basic equation:
  *		ns = cycles / (freq / ns_per_sec)
  *		ns = cycles * (ns_per_sec / freq)
@@ -80,76 +114,54 @@
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
@@ -158,11 +170,11 @@
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
@@ -173,25 +185,21 @@
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
+				cpu_khz / 1000, cpu_khz % 1000);
+
+	set_cyc2ns_scale(cpu_khz/1000);
 }
 
 
@@ -211,15 +219,15 @@
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
@@ -232,13 +240,11 @@
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
 
@@ -248,7 +254,6 @@
 		ref_freq = freq->old;
 		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
 #ifndef CONFIG_SMP
-		fast_gettimeoffset_ref = fast_gettimeoffset_quotient;
 		cpu_khz_ref = cpu_khz;
 #endif
 	}
@@ -258,16 +263,20 @@
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
@@ -289,10 +298,9 @@
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
diff -ruN linux-2.6.12-rc6-mm1/drivers/acpi/processor_idle.c linux-2.6.12-rc6-mm1-tod/drivers/acpi/processor_idle.c
--- linux-2.6.12-rc6-mm1/drivers/acpi/processor_idle.c	2005-06-17 19:32:40.000000000 -0700
+++ linux-2.6.12-rc6-mm1-tod/drivers/acpi/processor_idle.c	2005-06-17 19:34:48.026993704 -0700
@@ -162,6 +162,7 @@
 	return;
 }
 
+extern void tsc_c3_compensate(unsigned long usecs);
 
 static void acpi_processor_idle (void)
 {
@@ -309,6 +310,10 @@
 		t2 = inl(acpi_fadt.xpm_tmr_blk.address);
 		/* Enable bus master arbitration */
 		acpi_set_register(ACPI_BITREG_ARB_DISABLE, 0, ACPI_MTX_DO_NOT_LOCK);
+
+		/* compensate for TSC pause */
+		tsc_c3_compensate((((t2-t1)&0xFFFFFF)*286)>>10);
+
 		/* Re-enable interrupts */
 		local_irq_enable();
 		/* Compute time (ticks) that we were actually asleep */
diff -ruN linux-2.6.12-rc6-mm1/include/asm-i386/mach-default/mach_timer.h linux-2.6.12-rc6-mm1-tod/include/asm-i386/mach-default/mach_timer.h
--- linux-2.6.12-rc6-mm1/include/asm-i386/mach-default/mach_timer.h	2005-06-17 19:32:40.000000000 -0700
+++ linux-2.6.12-rc6-mm1-tod/include/asm-i386/mach-default/mach_timer.h	2005-06-17 19:34:48.000000000 -0700
@@ -15,7 +15,9 @@
 #ifndef _MACH_TIMER_H
 #define _MACH_TIMER_H
 
-#define CALIBRATE_LATCH	(5 * LATCH)
+#define CALIBRATE_TIME_MSEC 30 /* 30 msecs */
+#define CALIBRATE_LATCH	\
+	((CLOCK_TICK_RATE * CALIBRATE_TIME_MSEC + 1000/2)/1000)
 
 static inline void mach_prepare_counter(void)
 {
diff -ruN linux-2.6.12-rc6-mm1/include/asm-i386/mach-summit/mach_mpparse.h linux-2.6.12-rc6-mm1-tod/include/asm-i386/mach-summit/mach_mpparse.h
--- linux-2.6.12-rc6-mm1/include/asm-i386/mach-summit/mach_mpparse.h	2005-06-17 19:32:40.000000000 -0700
+++ linux-2.6.12-rc6-mm1-tod/include/asm-i386/mach-summit/mach_mpparse.h	2005-06-17 19:34:48.000000000 -0700
@@ -30,6 +30,7 @@
 			(!strncmp(productid, "VIGIL SMP", 9) 
 			 || !strncmp(productid, "EXA", 3)
 			 || !strncmp(productid, "RUTHLESS SMP", 12))){
+		mark_tsc_unstable();
 		use_cyclone = 1; /*enable cyclone-timer*/
 		setup_summit();
 		usb_early_handoff = 1;
@@ -44,6 +45,7 @@
 	if (!strncmp(oem_id, "IBM", 3) &&
 	    (!strncmp(oem_table_id, "SERVIGIL", 8)
 	     || !strncmp(oem_table_id, "EXA", 3))){
+		mark_tsc_unstable();
 		use_cyclone = 1; /*enable cyclone-timer*/
 		setup_summit();
 		usb_early_handoff = 1;
diff -ruN linux-2.6.12-rc6-mm1/include/asm-i386/timex.h linux-2.6.12-rc6-mm1-tod/include/asm-i386/timex.h
--- linux-2.6.12-rc6-mm1/include/asm-i386/timex.h	2005-06-17 19:32:40.000000000 -0700
+++ linux-2.6.12-rc6-mm1-tod/include/asm-i386/timex.h	2005-06-17 19:34:48.000000000 -0700
@@ -8,6 +8,7 @@
 
 #include <linux/config.h>
 #include <asm/processor.h>
+#include <asm/tsc.h>
 
 #ifdef CONFIG_X86_ELAN
 #  define CLOCK_TICK_RATE 1189200 /* AMD Elan has different frequency! */
@@ -16,39 +17,6 @@
 #endif
 
 
-/*
- * Standard way to access the cycle counter on i586+ CPUs.
- * Currently only used on SMP.
- *
- * If you really have a SMP machine with i486 chips or older,
- * compile for that, and this will just always return zero.
- * That's ok, it just means that the nicer scheduling heuristics
- * won't work for you.
- *
- * We only use the low 32 bits, and we'd simply better make sure
- * that we reschedule before that wraps. Scheduling at least every
- * four billion cycles just basically sounds like a good idea,
- * regardless of how fast the machine is. 
- */
-typedef unsigned long long cycles_t;
-
-static inline cycles_t get_cycles (void)
-{
-	unsigned long long ret=0;
-
-#ifndef CONFIG_X86_TSC
-	if (!cpu_has_tsc)
-		return 0;
-#endif
-
-#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
-	rdtscll(ret);
-#endif
-	return ret;
-}
-
-extern unsigned long cpu_khz;
-
 extern int read_current_timer(unsigned long *timer_value);
 #define ARCH_HAS_READ_CURRENT_TIMER	1
 
diff -ruN linux-2.6.12-rc6-mm1/include/asm-i386/tsc.h linux-2.6.12-rc6-mm1-tod/include/asm-i386/tsc.h
--- linux-2.6.12-rc6-mm1/include/asm-i386/tsc.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.12-rc6-mm1-tod/include/asm-i386/tsc.h	2005-06-17 19:34:48.000000000 -0700
@@ -0,0 +1,50 @@
+/*
+ * linux/include/asm-i386/tsc.h
+ *
+ * i386 TSC related functions
+ */
+#ifndef _ASM_i386_TSC_H
+#define _ASM_i386_TSC_H
+
+#include <linux/config.h>
+#include <asm/processor.h>
+
+/*
+ * Standard way to access the cycle counter on i586+ CPUs.
+ * Currently only used on SMP.
+ *
+ * If you really have a SMP machine with i486 chips or older,
+ * compile for that, and this will just always return zero.
+ * That's ok, it just means that the nicer scheduling heuristics
+ * won't work for you.
+ *
+ * We only use the low 32 bits, and we'd simply better make sure
+ * that we reschedule before that wraps. Scheduling at least every
+ * four billion cycles just basically sounds like a good idea,
+ * regardless of how fast the machine is.
+ */
+typedef unsigned long long cycles_t;
+
+static inline cycles_t get_cycles (void)
+{
+	unsigned long long ret=0;
+
+#ifndef CONFIG_X86_TSC
+	if (!cpu_has_tsc)
+		return 0;
+#endif
+
+#if defined(CONFIG_X86_GENERIC) || defined(CONFIG_X86_TSC)
+	rdtscll(ret);
+#endif
+	return ret;
+}
+
+extern unsigned long cpu_khz;
+extern unsigned long tsc_khz;
+extern void tsc_init(void);
+void tsc_c3_compensate(unsigned long usecs);
+u64 tsc_read_c3_time(void);
+extern int check_tsc_unstable(void);
+extern void mark_tsc_unstable(void);
+#endif


