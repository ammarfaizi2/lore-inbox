Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265904AbUAEGSr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 01:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbUAEGSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 01:18:47 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:35999 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265904AbUAEGRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 01:17:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Karol Kozimor <sziwan@hell.org.pl>, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6.0-mm2] PM timer still has problems
Date: Mon, 5 Jan 2004 01:17:04 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       jw schultz <jw@pegasys.ws>
References: <20031230204831.GA17344@hell.org.pl> <20031230200249.107b56f0.akpm@osdl.org> <20040104004449.GA20647@hell.org.pl>
In-Reply-To: <20040104004449.GA20647@hell.org.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401050117.06681.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 January 2004 07:44 pm, Karol Kozimor wrote:
> Thus wrote Andrew Morton:
> > >  Booting with clock=pmtmr causes weird problems here (the system
> > >  complains that clock override failed and the bogomips loop
> > > produces bogus values). Below is the dmesg output as well as
> > > /proc/cpuinfo. I have CONFIG_X86_LOCAL_APIC=y and
> > > CONFIG_X86_PM_TIMER=y.
> >
> > Yup, thanks.  Several people have reported problems with the PM
> > timer. Unfortunately, everyone's symptoms seem to be different.
>
> Just for the record: I'm still getting those problems with
> 2.6.1-rc1-mm1. Best regards,

I threw a monkey wrench in timer code and came up with the patch below...
It is not intended for inclusion as is, just some work in progress.

I decided to go hpet way and use tsc in ACPI PM timer to do delay stuff
and monotonic clock. Plus there some code rearrangements, and stuff I grabbed
from the CPUFREQ list (Dominics + Li Shahoua P4 variable tsc info ), etc...
If there is an interest I can split the code into smaller chinks. For what
it worth I am running with ACPI PM timer, CPUFREQ (dynamically switching
frequency based on load) and Synaptics and everything is calm. Ntpd has also
stopped complaining about loosing sync...

Dmitry

===================================================================


ChangeSet@1.1583, 2004-01-05 00:38:31-05:00, dtor_core@ameritech.net
  Timers: convert ACPIT PM timer to use tsc to do delays and
          monotonic clock, code consolidations


 arch/i386/kernel/time.c                 |   51 ++++
 arch/i386/kernel/timers/common.c        |  283 +++++++++++++++++----------
 arch/i386/kernel/timers/timer.c         |    3 
 arch/i386/kernel/timers/timer_cyclone.c |   75 +++----
 arch/i386/kernel/timers/timer_hpet.c    |  196 ++++++++++++-------
 arch/i386/kernel/timers/timer_pm.c      |   67 +-----
 arch/i386/kernel/timers/timer_tsc.c     |  330 +-------------------------------
 include/asm-i386/timer.h                |    9 
 include/asm-i386/timer_common.h         |   70 ++++++
 9 files changed, 515 insertions(+), 569 deletions(-)


===================================================================



diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Mon Jan  5 00:47:14 2004
+++ b/arch/i386/kernel/time.c	Mon Jan  5 00:47:14 2004
@@ -45,6 +45,7 @@
 #include <linux/sysdev.h>
 #include <linux/bcd.h>
 #include <linux/efi.h>
+#include <linux/cpufreq.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -345,6 +346,8 @@
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
+	init_cpu_khz();
+
 	time_init_hook();
 }
 #endif
@@ -369,5 +372,53 @@
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
+	init_cpu_khz();
+	
 	time_init_hook();
 }
+
+#ifdef CONFIG_CPU_FREQ
+static unsigned int  ref_freq = 0;
+static unsigned long loops_per_jiffy_ref = 0;
+
+#ifndef CONFIG_SMP
+static unsigned long cpu_khz_ref = 0;
+#endif
+
+static int time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
+		       		 void *data)
+{
+	struct cpufreq_freqs *freq = data;
+
+	write_seqlock_irq(&xtime_lock);
+	if (!ref_freq) {
+		ref_freq = freq->old;
+		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
+#ifndef CONFIG_SMP
+		cpu_khz_ref = cpu_khz;
+#endif
+	}
+
+	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
+	    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
+		cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
+#ifndef CONFIG_SMP
+		if (cpu_khz)
+			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
+#endif
+	}
+	write_sequnlock_irq(&xtime_lock);
+
+	return 0;
+}
+
+static struct notifier_block time_cpufreq_notifier_block = {
+	.notifier_call	= time_cpufreq_notifier
+};
+
+static int __init cpufreq_time(void)
+{
+        return cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
+}
+core_initcall(cpufreq_time);
+#endif
diff -Nru a/arch/i386/kernel/timers/common.c b/arch/i386/kernel/timers/common.c
--- a/arch/i386/kernel/timers/common.c	Mon Jan  5 00:47:14 2004
+++ b/arch/i386/kernel/timers/common.c	Mon Jan  5 00:47:14 2004
@@ -5,13 +5,58 @@
 #include <linux/init.h>
 #include <linux/timex.h>
 #include <linux/errno.h>
+#include <linux/cpufreq.h>
 
 #include <asm/io.h>
 #include <asm/timer.h>
-#include <asm/hpet.h>
+#include <asm/timer_common.h>
 
 #include "mach_timer.h"
 
+unsigned long cyc2ns_scale;
+
+unsigned long __init tsc_2_quotient(unsigned long tsc_start[], unsigned long tsc_end[], 
+				    unsigned long calibrate_time)
+{
+	unsigned long tsc_delta_low, tsc_delta_high;
+	unsigned long result, remain;
+
+	/* we want to keep arguments intact */
+	tsc_delta_low = tsc_end[0];
+	tsc_delta_high = tsc_end[1];
+
+	/* 64-bit subtract - gcc just messes up with long longs */
+	__asm__("subl %2,%0\n\t"
+		"sbbl %3,%1"
+		:"=a" (tsc_delta_low), "=d" (tsc_delta_high)
+		:"g" (tsc_start[0]), "g" (tsc_start[1]),
+		 "0" (tsc_delta_low), "1" (tsc_delta_high));
+
+	/* Error: ECPUTOOFAST */
+	if (tsc_delta_high)
+		goto bad_calibration;
+
+	/* Error: ECPUTOOSLOW */
+	if (tsc_delta_low <= calibrate_time)
+		goto bad_calibration;
+
+	__asm__("divl %2"
+		:"=a" (result), "=d" (remain)
+		:"r" (tsc_delta_low), "0" (0), "1" (calibrate_time));
+
+	if (remain > (tsc_delta_low >> 1))
+		result++; /* rounding the result */
+
+	return result;
+
+bad_calibration:
+	/*
+	 * the CPU was so fast/slow that the quotient wouldn't fit in
+	 * 32 bits..
+	 */
+	return 0;
+}
+
 /* ------ Calibrate the TSC -------
  * Return 2^32 * (1 / (TSC clocks per usec)) for do_fast_gettimeoffset().
  * Too much 64-bit arithmetic here to do this cleanly in C, and for
@@ -20,140 +65,180 @@
  * directly because of the awkward 8-bit access mechanism of the 82C54
  * device.
  */
-
 #define CALIBRATE_TIME	(5 * 1000020/HZ)
 
 unsigned long __init calibrate_tsc(void)
 {
-	mach_prepare_counter();
+	unsigned long tsc_start[2], tsc_end[2];
+	unsigned long count;
 
-	{
-		unsigned long startlow, starthigh;
-		unsigned long endlow, endhigh;
-		unsigned long count;
-
-		rdtsc(startlow,starthigh);
-		mach_countup(&count);
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
-	}
+	mach_prepare_counter();
 
-	/*
-	 * The CTC wasn't reliable: we got a hit on the very first read,
-	 * or the CPU was so fast/slow that the quotient wouldn't fit in
-	 * 32 bits..
+	rdtsc(tsc_start[0], tsc_start[1]);
+	mach_countup(&count);
+	rdtsc(tsc_end[0], tsc_end[1]);
+
+	/* 
+	 * Error: ECTCNEVERSET
+	 * The CTC wasn't reliable: we got a hit on the very first read.
 	 */
-bad_ctc:
-	return 0;
+	if (count <= 1)
+		return 0;
+
+	return tsc_2_quotient(tsc_start, tsc_end, CALIBRATE_TIME);
 }
 
-#ifdef CONFIG_HPET_TIMER
-/* ------ Calibrate the TSC using HPET -------
- * Return 2^32 * (1 / (TSC clocks per usec)) for getting the CPU freq.
- * Second output is parameter 1 (when non NULL)
- * Set 2^32 * (1 / (tsc per HPET clk)) for delay_hpet().
- * calibrate_tsc() calibrates the processor TSC by comparing
- * it to the HPET timer of known frequency.
- * Too much 64-bit arithmetic here to do this cleanly in C
+int use_tsc;
+
+/* Number of usecs that the last interrupt was delayed */
+int tsc_delay_at_last_interrupt;
+
+unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
+unsigned long last_tsc_high; /* msb 32 bits of Time Stamp Counter */
+
+unsigned long long monotonic_base;
+seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
+
+/* Cached *multiplier* to convert TSC counts to microseconds.
+ * Equal to 2^32 * (1 / (clocks per usec) ).
  */
-#define CALIBRATE_CNT_HPET 	(5 * hpet_tick)
-#define CALIBRATE_TIME_HPET 	(5 * KERNEL_TICK_USEC)
+unsigned long tsc_quotient;
 
-unsigned long __init calibrate_tsc_hpet(unsigned long *tsc_hpet_quotient_ptr)
+unsigned long get_offset_tsc(void)
 {
-	unsigned long tsc_startlow, tsc_starthigh;
-	unsigned long tsc_endlow, tsc_endhigh;
-	unsigned long hpet_start, hpet_end;
-	unsigned long result, remain;
+	register unsigned long tsc_low, tsc_hi;
 
-	hpet_start = hpet_readl(HPET_COUNTER);
-	rdtsc(tsc_startlow, tsc_starthigh);
-	do {
-		hpet_end = hpet_readl(HPET_COUNTER);
-	} while ((hpet_end - hpet_start) < CALIBRATE_CNT_HPET);
-	rdtsc(tsc_endlow, tsc_endhigh);
+	/* Read the Time Stamp Counter */
 
-	/* 64-bit subtract - gcc just messes up with long longs */
-	__asm__("subl %2,%0\n\t"
-		"sbbl %3,%1"
-		:"=a" (tsc_endlow), "=d" (tsc_endhigh)
-		:"g" (tsc_startlow), "g" (tsc_starthigh),
-		 "0" (tsc_endlow), "1" (tsc_endhigh));
+	rdtsc(tsc_low, tsc_hi);
 
-	/* Error: ECPUTOOFAST */
-	if (tsc_endhigh)
-		goto bad_calibration;
+	/* .. relative to previous jiffy (32 bits is enough) */
+	tsc_low -= last_tsc_low;	/* tsc_low delta */
 
-	/* Error: ECPUTOOSLOW */
-	if (tsc_endlow <= CALIBRATE_TIME_HPET)
-		goto bad_calibration;
+	/* our adjusted time offset in microseconds */
+	return tsc_delay_at_last_interrupt + tsc_2_usecs(tsc_low);
+}
 
-	ASM_DIV64_REG(result, remain, tsc_endlow, 0, CALIBRATE_TIME_HPET);
-	if (remain > (tsc_endlow >> 1))
-		result++; /* rounding the result */
+unsigned long long monotonic_clock_tsc(void)
+{
+	unsigned long long last_offset, this_offset, base;
+	unsigned seq;
+	
+	/* atomically read monotonic base & last_offset */
+	do {
+		seq = read_seqbegin(&monotonic_lock);
+		last_offset = ((unsigned long long)last_tsc_high << 32) | last_tsc_low;
+		base = monotonic_base;
+	} while (read_seqretry(&monotonic_lock, seq));
 
-	if (tsc_hpet_quotient_ptr) {
-		unsigned long tsc_hpet_quotient;
+	/* Read the Time Stamp Counter */
+	rdtscll(this_offset);
 
-		ASM_DIV64_REG(tsc_hpet_quotient, remain, tsc_endlow, 0,
-			CALIBRATE_CNT_HPET);
-		if (remain > (tsc_endlow >> 1))
-			tsc_hpet_quotient++; /* rounding the result */
-		*tsc_hpet_quotient_ptr = tsc_hpet_quotient;
-	}
+	/* return the value in ns */
+	return base + cycles_2_ns(this_offset - last_offset);
+}
+
+void delay_tsc(unsigned long loops)
+{
+	unsigned long bclock, now;
+	
+	rdtscl(bclock);
+	do
+	{
+		rep_nop();
+		rdtscl(now);
+	} while (now - bclock < loops);
+}
+
+/*
+ * Scheduler clock - returns current time in nanosec units.
+ */
+unsigned long long sched_clock(void)
+{
+	unsigned long long this_offset;
 
-	return result;
-bad_calibration:
 	/*
-	 * the CPU was so fast/slow that the quotient wouldn't fit in
-	 * 32 bits..
+	 * In the NUMA case we dont use the TSC as they are not
+	 * synchronized across all CPUs.
 	 */
-	return 0;
-}
+#ifndef CONFIG_NUMA
+	if (!use_tsc)
 #endif
+		return (unsigned long long)get_jiffies_64() * (1000000000 / HZ);
+
+	/* Read the Time Stamp Counter */
+	rdtscll(this_offset);
+
+	/* return the value in ns */
+	return cycles_2_ns(this_offset);
+}
+
+/*-----------------------------------------------------------------*/
 
 /* calculate cpu_khz */
 void __init init_cpu_khz(void)
 {
+	unsigned long eax=0, edx=1000;
+
 	if (cpu_has_tsc) {
-		unsigned long tsc_quotient = calibrate_tsc();
+		if (!tsc_quotient)
+			tsc_quotient = calibrate_tsc();
 		if (tsc_quotient) {
 			/* report CPU clock rate in Hz.
 			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
 			 * clock/second. Our precision is about 100 ppm.
 			 */
-			{	unsigned long eax=0, edx=1000;
-				__asm__("divl %2"
+			__asm__("divl %2"
 		       		:"=a" (cpu_khz), "=d" (edx)
         	       		:"r" (tsc_quotient),
 	                	"0" (eax), "1" (edx));
-				printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
-			}
+			printk("Detected %lu.%03lu MHz processor.\n", cpu_khz / 1000, cpu_khz % 1000);
+			set_cyc2ns_scale(cpu_khz / 1000);
 		}
 	}
 }
+
+#ifdef CONFIG_CPU_FREQ
+static unsigned int  ref_freq;
+static unsigned long tsc_quotient_ref;
+static unsigned long cpu_khz_ref;
+
+static int tsc_cpufreq_notifier(struct notifier_block *nb, unsigned long val, void *data)
+{
+        struct cpufreq_freqs *freq = data;
+        unsigned long new_cpu_khz;
+
+        write_seqlock_irq(&xtime_lock);
+        if (!ref_freq) {
+                ref_freq = freq->old;
+		tsc_quotient_ref = tsc_quotient;
+                cpu_khz_ref = cpu_khz;
+        }
+
+        if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
+            (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
+		tsc_quotient = cpufreq_scale(tsc_quotient_ref, freq->new, ref_freq);
+		new_cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
+		set_cyc2ns_scale(new_cpu_khz / 1000);
+        }
+        write_sequnlock_irq(&xtime_lock);
+        return 0;
+}
+
+static struct notifier_block tsc_cpufreq_notifier_block = {
+        .notifier_call  = tsc_cpufreq_notifier
+};
+
+static int __init cpufreq_tsc(void)
+{
+	if (!use_tsc || !tsc_quotient)
+		return 0;
+
+	/* P4 and above CPU TSC freq doesn't change when CPU frequency changes*/
+	if (boot_cpu_data.x86 >= 15 && boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		return 0;
+
+	return cpufreq_register_notifier(&tsc_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
+}
+core_initcall(cpufreq_tsc);
+#endif
diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	Mon Jan  5 00:47:14 2004
+++ b/arch/i386/kernel/timers/timer.c	Mon Jan  5 00:47:14 2004
@@ -22,6 +22,9 @@
 #ifdef CONFIG_X86_PM_TIMER
 	&timer_pmtmr,
 #endif
+#ifdef CONFIG_HPET_TIMER
+	&timer_tsc_hpet,
+#endif
 	&timer_tsc,
 	&timer_pit,
 	NULL,
diff -Nru a/arch/i386/kernel/timers/timer_cyclone.c b/arch/i386/kernel/timers/timer_cyclone.c
--- a/arch/i386/kernel/timers/timer_cyclone.c	Mon Jan  5 00:47:14 2004
+++ b/arch/i386/kernel/timers/timer_cyclone.c	Mon Jan  5 00:47:14 2004
@@ -14,6 +14,7 @@
 #include <linux/jiffies.h>
 
 #include <asm/timer.h>
+#include <asm/timer_common.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
 #include <asm/fixmap.h>
@@ -34,8 +35,6 @@
 static u32* volatile cyclone_timer;	/* Cyclone MPMC0 register */
 static u32 last_cyclone_low;
 static u32 last_cyclone_high;
-static unsigned long long monotonic_base;
-static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
 
 /* helper macro to atomically read both cyclone counter registers */
 #define read_cyclone_counter(low,high) \
@@ -55,7 +54,7 @@
 	last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
 	
 	spin_lock(&i8253_lock);
-	read_cyclone_counter(last_cyclone_low,last_cyclone_high);
+	read_cyclone_counter(last_cyclone_low, last_cyclone_high);
 
 	/* read values for delay_at_last_interrupt */
 	outb_p(0x00, 0x43);     /* latch the count ASAP */
@@ -66,12 +65,12 @@
 
 	/* lost tick compensation */
 	delta = last_cyclone_low - delta;	
-	delta /= (CYCLONE_TIMER_FREQ/1000000);
+	delta /= CYCLONE_TIMER_FREQ / 1000000;
 	delta += delay_at_last_interrupt;
-	lost = delta/(1000000/HZ);
-	delay = delta%(1000000/HZ);
+	lost = delta / (USEC_PER_SEC / HZ);
+	delay = delta % (USEC_PER_SEC / HZ);
 	if (lost >= 2)
-		jiffies_64 += lost-1;
+		jiffies_64 += lost - 1;
 	
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
@@ -95,7 +94,7 @@
 {
 	u32 offset;
 
-	if(!cyclone_timer)
+	if (!cyclone_timer)
 		return delay_at_last_interrupt;
 
 	/* Read the cyclone timer */
@@ -122,17 +121,17 @@
 	/* atomically read monotonic base & last_offset */
 	do {
 		seq = read_seqbegin(&monotonic_lock);
-		last_offset = ((unsigned long long)last_cyclone_high<<32)|last_cyclone_low;
+		last_offset = ((unsigned long long)last_cyclone_high << 32) | last_cyclone_low;
 		base = monotonic_base;
 	} while (read_seqretry(&monotonic_lock, seq));
 
 
 	/* Read the cyclone counter */
-	read_cyclone_counter(now_low,now_high);
-	this_offset = ((unsigned long long)now_high<<32)|now_low;
+	read_cyclone_counter(now_low, now_high);
+	this_offset = ((unsigned long long)now_high << 32) | now_low;
 
 	/* convert to nanoseconds */
-	ret = base + ((this_offset - last_offset)&CYCLONE_TIMER_MASK);
+	ret = base + ((this_offset - last_offset) & CYCLONE_TIMER_MASK);
 	return ret * (1000000000 / CYCLONE_TIMER_FREQ);
 }
 
@@ -145,67 +144,67 @@
 	int i;
 	
 	/* check clock override */
-	if (override[0] && strncmp(override,"cyclone",7))
-			return -ENODEV;
+	if (override[0] && strncmp(override, "cyclone", 7))
+		return -ENODEV;
 
 	/*make sure we're on a summit box*/
-	if(!use_cyclone) return -ENODEV; 
+	if (!use_cyclone) return -ENODEV; 
 	
 	printk(KERN_INFO "Summit chipset: Starting Cyclone Counter.\n");
 
 	/* find base address */
-	pageaddr = (CYCLONE_CBAR_ADDR)&PAGE_MASK;
-	offset = (CYCLONE_CBAR_ADDR)&(~PAGE_MASK);
+	pageaddr = (CYCLONE_CBAR_ADDR) & PAGE_MASK;
+	offset = (CYCLONE_CBAR_ADDR) & (~PAGE_MASK);
 	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
 	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
-	if(!reg){
+	if (!reg) {
 		printk(KERN_ERR "Summit chipset: Could not find valid CBAR register.\n");
 		return -ENODEV;
 	}
 	base = *reg;	
-	if(!base){
+	if (!base) {
 		printk(KERN_ERR "Summit chipset: Could not find valid CBAR value.\n");
 		return -ENODEV;
 	}
 	
 	/* setup PMCC */
-	pageaddr = (base + CYCLONE_PMCC_OFFSET)&PAGE_MASK;
-	offset = (base + CYCLONE_PMCC_OFFSET)&(~PAGE_MASK);
+	pageaddr = (base + CYCLONE_PMCC_OFFSET) & PAGE_MASK;
+	offset = (base + CYCLONE_PMCC_OFFSET) & (~PAGE_MASK);
 	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
 	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
-	if(!reg){
+	if (!reg) {
 		printk(KERN_ERR "Summit chipset: Could not find valid PMCC register.\n");
 		return -ENODEV;
 	}
 	reg[0] = 0x00000001;
 
 	/* setup MPCS */
-	pageaddr = (base + CYCLONE_MPCS_OFFSET)&PAGE_MASK;
-	offset = (base + CYCLONE_MPCS_OFFSET)&(~PAGE_MASK);
+	pageaddr = (base + CYCLONE_MPCS_OFFSET) & PAGE_MASK;
+	offset = (base + CYCLONE_MPCS_OFFSET) & (~PAGE_MASK);
 	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
 	reg = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
-	if(!reg){
+	if (!reg) {
 		printk(KERN_ERR "Summit chipset: Could not find valid MPCS register.\n");
 		return -ENODEV;
 	}
 	reg[0] = 0x00000001;
 
 	/* map in cyclone_timer */
-	pageaddr = (base + CYCLONE_MPMC_OFFSET)&PAGE_MASK;
-	offset = (base + CYCLONE_MPMC_OFFSET)&(~PAGE_MASK);
+	pageaddr = (base + CYCLONE_MPMC_OFFSET) & PAGE_MASK;
+	offset = (base + CYCLONE_MPMC_OFFSET) & (~PAGE_MASK);
 	set_fixmap_nocache(FIX_CYCLONE_TIMER, pageaddr);
 	cyclone_timer = (u32*)(fix_to_virt(FIX_CYCLONE_TIMER) + offset);
-	if(!cyclone_timer){
+	if (!cyclone_timer) {
 		printk(KERN_ERR "Summit chipset: Could not find valid MPMC register.\n");
 		return -ENODEV;
 	}
 
 	/*quick test to make sure its ticking*/
-	for(i=0; i<3; i++){
+	for (i = 0; i < 3; i++) {
 		u32 old = cyclone_timer[0];
 		int stall = 100;
-		while(stall--) barrier();
-		if(cyclone_timer[0] == old){
+		while (stall--) barrier();
+		if (cyclone_timer[0] == old) {
 			printk(KERN_ERR "Summit chipset: Counter not counting! DISABLED\n");
 			cyclone_timer = 0;
 			return -ENODEV;
@@ -222,22 +221,22 @@
 static void delay_cyclone(unsigned long loops)
 {
 	unsigned long bclock, now;
-	if(!cyclone_timer)
+	if (!cyclone_timer)
 		return;
 	bclock = cyclone_timer[0];
 	do {
 		rep_nop();
 		now = cyclone_timer[0];
-	} while ((now-bclock) < loops);
+	} while (now - bclock < loops);
 }
 /************************************************************/
 
 /* cyclone timer_opts struct */
 struct timer_opts timer_cyclone = {
-	.name = "cyclone",
-	.init = init_cyclone, 
-	.mark_offset = mark_offset_cyclone, 
-	.get_offset = get_offset_cyclone,
+	.name = 		"cyclone",
+	.init = 		init_cyclone, 
+	.mark_offset = 		mark_offset_cyclone, 
+	.get_offset = 		get_offset_cyclone,
 	.monotonic_clock =	monotonic_clock_cyclone,
-	.delay = delay_cyclone,
+	.delay = 		delay_cyclone,
 };
diff -Nru a/arch/i386/kernel/timers/timer_hpet.c b/arch/i386/kernel/timers/timer_hpet.c
--- a/arch/i386/kernel/timers/timer_hpet.c	Mon Jan  5 00:47:14 2004
+++ b/arch/i386/kernel/timers/timer_hpet.c	Mon Jan  5 00:47:14 2004
@@ -17,42 +17,11 @@
 #include "io_ports.h"
 #include "mach_timer.h"
 #include <asm/hpet.h>
+#include <asm/timer_common.h>
 
 static unsigned long hpet_usec_quotient;	/* convert hpet clks to usec */
 static unsigned long tsc_hpet_quotient;		/* convert tsc to hpet clks */
 static unsigned long hpet_last; 	/* hpet counter value at last tick*/
-static unsigned long last_tsc_low;	/* lsb 32 bits of Time Stamp Counter */
-static unsigned long last_tsc_high; 	/* msb 32 bits of Time Stamp Counter */
-static unsigned long long monotonic_base;
-static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
-
-/* convert from cycles(64bits) => nanoseconds (64bits)
- *  basic equation:
- *		ns = cycles / (freq / ns_per_sec)
- *		ns = cycles * (ns_per_sec / freq)
- *		ns = cycles * (10^9 / (cpu_mhz * 10^6))
- *		ns = cycles * (10^3 / cpu_mhz)
- *
- *	Then we use scaling math (suggested by george@mvista.com) to get:
- *		ns = cycles * (10^3 * SC / cpu_mhz) / SC
- *		ns = cycles * cyc2ns_scale / SC
- *
- *	And since SC is a constant power of two, we can convert the div
- *  into a shift.
- *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
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
 
 static unsigned long long monotonic_clock_hpet(void)
 {
@@ -98,24 +67,69 @@
 
 static void mark_offset_hpet(void)
 {
-	unsigned long long this_offset, last_offset;
+	unsigned long long last_offset;
 	unsigned long offset;
 
 	write_seqlock(&monotonic_lock);
-	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+	last_offset = ((unsigned long long)last_tsc_high << 32) | last_tsc_low;
 	rdtsc(last_tsc_low, last_tsc_high);
 
 	offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
-	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))) {
+	if (unlikely(offset - hpet_last > hpet_tick && hpet_last != 0)) {
 		int lost_ticks = (offset - hpet_last) / hpet_tick;
 		jiffies_64 += lost_ticks;
 	}
 	hpet_last = offset;
 
 	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
+	tsc_update_monotonic_base(last_offset);
+	write_sequnlock(&monotonic_lock);
+}
+
+static void mark_offset_tsc_hpet(void)
+{
+	unsigned long long last_offset;
+ 	unsigned long offset, temp, hpet_current;
+
+	write_seqlock(&monotonic_lock);
+	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
+	/*
+	 * It is important that these two operations happen almost at
+	 * the same time. We do the RDTSC stuff first, since it's
+	 * faster. To avoid any inconsistencies, we need interrupts
+	 * disabled locally.
+	 */
+	/*
+	 * Interrupts are just disabled locally since the timer irq
+	 * has the SA_INTERRUPT flag set. -arca
+	 */
+	/* read Pentium cycle counter */
+
+	hpet_current = hpet_readl(HPET_COUNTER);
+	rdtsc(last_tsc_low, last_tsc_high);
+
+	/* lost tick compensation */
+	offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
+	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))) {
+		int lost_ticks = (offset - hpet_last) / hpet_tick;
+		jiffies_64 += lost_ticks;
+	}
+	hpet_last = hpet_current;
+
+	tsc_update_monotonic_base(last_offset);
 	write_sequnlock(&monotonic_lock);
+
+	/* calculate delay_at_last_interrupt */
+	/*
+	 * Time offset = (hpet delta) * ( usecs per HPET clock )
+	 *             = (hpet delta) * ( usecs per tick / HPET clocks per tick)
+	 *             = (hpet delta) * ( hpet_usec_quotient ) / (2^32)
+	 * Where,
+	 * hpet_usec_quotient = (2^32 * usecs per tick)/HPET clocks per tick
+	 */
+	tsc_delay_at_last_interrupt = hpet_current - offset;
+	ASM_MUL64_REG(temp, tsc_delay_at_last_interrupt,
+			hpet_usec_quotient, tsc_delay_at_last_interrupt);
 }
 
 void delay_hpet(unsigned long loops)
@@ -130,48 +144,96 @@
 	do {
 		rep_nop();
 		hpet_end = hpet_readl(HPET_COUNTER);
-	} while ((hpet_end - hpet_start) < (loops));
+	} while (hpet_end - hpet_start < loops);
 }
 
-static int __init init_hpet(char* override)
+static unsigned long calculate_tick_quotient(unsigned long tick)
 {
 	unsigned long result, remain;
 
+	/*
+	 * Math to calculate tick to usec multiplier
+	 * Look for the comments at get_offset_hpet()
+	 */
+	ASM_DIV64_REG(result, remain, tick, 0, KERNEL_TICK_USEC);
+	if (remain > (tick >> 1))
+		result++; /* rounding the result */
+
+	return  result;
+}
+
+/* ------ Calibrate the TSC using HPET -------
+ * Return 2^32 * (1 / (TSC clocks per usec)) for getting the CPU freq.
+ * Second output is parameter 1 (when non NULL)
+ * Set 2^32 * (1 / (tsc per HPET clk)) for delay_hpet().
+ * calibrate_tsc() calibrates the processor TSC by comparing
+ * it to the HPET timer of known frequency.
+ * Too much 64-bit arithmetic here to do this cleanly in C
+ */
+#define CALIBRATE_CNT_HPET 	(5 * hpet_tick)
+#define CALIBRATE_TIME_HPET 	(5 * KERNEL_TICK_USEC)
+
+unsigned long __init calibrate_tsc_hpet(unsigned long *tsc_hpet_quotient_ptr)
+{
+	unsigned long tsc_start[2], tsc_end[2];
+	unsigned long hpet_start, hpet_end;
+	unsigned long result;
+
+	hpet_start = hpet_readl(HPET_COUNTER);
+	rdtsc(tsc_start[0], tsc_start[1]);
+	do {
+		hpet_end = hpet_readl(HPET_COUNTER);
+	} while ((hpet_end - hpet_start) < CALIBRATE_CNT_HPET);
+	rdtsc(tsc_end[0], tsc_end[1]);
+
+	result = tsc_2_quotient(tsc_start, tsc_end, CALIBRATE_TIME_HPET);
+
+	if (result && tsc_hpet_quotient_ptr) 
+		*tsc_hpet_quotient_ptr = tsc_2_quotient(tsc_start, tsc_end, CALIBRATE_CNT_HPET);
+
+	return result;
+}
+
+static int __init init_hpet(char* override)
+{
 	/* check clock override */
-	if (override[0] && strncmp(override,"hpet",4))
+	if (override[0] && strncmp(override, "hpet", 4))
 		return -ENODEV;
 
 	if (!is_hpet_enabled())
 		return -ENODEV;
 
+	hpet_usec_quotient = calculate_tick_quotient(hpet_tick);
+
 	printk("Using HPET for gettimeofday\n");
+	if (cpu_has_tsc)
+		tsc_quotient = calibrate_tsc_hpet(&tsc_hpet_quotient);
+
+	return 0;
+}
+
+static int __init init_tsc_hpet(char* override)
+{
+	if (!is_hpet_enabled())
+		return -ENODEV;
+
+	/* check clock override */
+	if (override[0] && strncmp(override, "tsc-hpet", 8))
+		printk(KERN_ERR "Warning: clock= override failed. Defaulting to tsc-hpet\n");
+
+	hpet_usec_quotient = calculate_tick_quotient(hpet_tick);
+
 	if (cpu_has_tsc) {
-		unsigned long tsc_quotient = calibrate_tsc_hpet(&tsc_hpet_quotient);
+		printk("Using TSC for gettimeofday\n");
+		tsc_quotient = calibrate_tsc_hpet(NULL);
+
 		if (tsc_quotient) {
-			/* report CPU clock rate in Hz.
-			 * The formula is (10^6 * 2^32) / (2^32 * 1 / (clocks/us)) =
-			 * clock/second. Our precision is about 100 ppm.
-			 */
-			{	unsigned long eax=0, edx=1000;
-				ASM_DIV64_REG(cpu_khz, edx, tsc_quotient,
-						eax, edx);
-				printk("Detected %lu.%03lu MHz processor.\n",
-					cpu_khz / 1000, cpu_khz % 1000);
-			}
-			set_cyc2ns_scale(cpu_khz/1000);
+			use_tsc = 1;
+			return 0;
 		}
 	}
 
-	/*
-	 * Math to calculate hpet to usec multiplier
-	 * Look for the comments at get_offset_hpet()
-	 */
-	ASM_DIV64_REG(result, remain, hpet_tick, 0, KERNEL_TICK_USEC);
-	if (remain > (hpet_tick >> 1))
-		result++; /* rounding the result */
-	hpet_usec_quotient = result;
-
-	return 0;
+	return -ENODEV;
 }
 
 /************************************************************/
@@ -184,4 +246,14 @@
 	.get_offset =		get_offset_hpet,
 	.monotonic_clock =	monotonic_clock_hpet,
 	.delay = 		delay_hpet,
+};
+
+/* tsc-hpet timer_opts struct */
+struct timer_opts timer_tsc_hpet = {
+	.name = 		"tsc-hpet",
+	.init =			init_tsc_hpet,
+	.mark_offset =		mark_offset_tsc_hpet,
+	.get_offset = 		get_offset_tsc,
+	.monotonic_clock =	monotonic_clock_tsc,
+	.delay = 		delay_tsc,
 };
diff -Nru a/arch/i386/kernel/timers/timer_pm.c b/arch/i386/kernel/timers/timer_pm.c
--- a/arch/i386/kernel/timers/timer_pm.c	Mon Jan  5 00:47:14 2004
+++ b/arch/i386/kernel/timers/timer_pm.c	Mon Jan  5 00:47:14 2004
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <asm/types.h>
 #include <asm/timer.h>
+#include <asm/timer_common.h>
 #include <asm/smp.h>
 #include <asm/io.h>
 #include <asm/arch_hooks.h>
@@ -27,14 +28,10 @@
  * in arch/i386/acpi/boot.c */
 u32 pmtmr_ioport = 0;
 
-
 /* value of the Power timer at last timer interrupt */
 static u32 offset_tick;
 static u32 offset_delay;
 
-static unsigned long long monotonic_base;
-static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
-
 #define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
 
 static int init_pmtmr(char* override)
@@ -51,7 +48,7 @@
 	/* "verify" this timing source */
 	value1 = inl(pmtmr_ioport);
 	value1 &= ACPI_PM_MASK;
-	for (i=0; i < 10000; i++) {
+	for (i = 0; i < 10000; i++) {
 		value2 = inl(pmtmr_ioport);
 		value2 &= ACPI_PM_MASK;
 		if (value2 == value1)
@@ -67,7 +64,6 @@
 	return -ENODEV;
 
 pm_good:
-	init_cpu_khz();
 	return 0;
 }
 
@@ -91,13 +87,16 @@
 static void mark_offset_pmtmr(void)
 {
 	u32 lost, delta, last_offset;
+	unsigned long long last_tsc_offset;
 	static int first_run = 1;
 
 	write_seqlock(&monotonic_lock);
 
+	last_tsc_offset = ((unsigned long long) last_tsc_high << 32) | last_tsc_low;
 	last_offset = offset_tick;
-	offset_tick = inl(pmtmr_ioport);
-	offset_tick &= ACPI_PM_MASK; /* limit it to 24 bits */
+
+	rdtsc(last_tsc_low, last_tsc_high);
+	offset_tick = inl(pmtmr_ioport) & ACPI_PM_MASK;
 
 	/* calculate tick interval */
 	delta = likely(last_offset < offset_tick) ?
@@ -107,7 +106,7 @@
 	delta = cyc2us(delta);
 
 	/* update the monotonic base value */
-	monotonic_base += delta * NSEC_PER_USEC;
+	tsc_update_monotonic_base(last_tsc_offset);
 	write_sequnlock(&monotonic_lock);
 
 	/* convert to ticks */
@@ -121,53 +120,12 @@
 
 	/* don't calculate delay for first run,
 	   or if we've got less then a tick */
-	if (first_run || (lost < 1)) {
+	if (first_run || lost < 1) {
 		first_run = 0;
 		offset_delay = 0;
 	}
 }
 
-
-static unsigned long long monotonic_clock_pmtmr(void)
-{
-	u32 last_offset, this_offset;
-	unsigned long long base, ret;
-	unsigned seq;
-
-
-	/* atomically read monotonic base & last_offset */
-	do {
-		seq = read_seqbegin(&monotonic_lock);
-		last_offset = offset_tick;
-		base = monotonic_base;
-	} while (read_seqretry(&monotonic_lock, seq));
-
-	/* Read the pmtmr */
-	this_offset =  inl(pmtmr_ioport) & ACPI_PM_MASK;
-
-	/* convert to nanoseconds */
-	ret = (this_offset - last_offset) & ACPI_PM_MASK;
-	ret = base + (cyc2us(ret)*NSEC_PER_USEC);
-	return ret;
-}
-
-/*
- * copied from delay_pit
- */
-static void delay_pmtmr(unsigned long loops)
-{
-	int d0;
-	__asm__ __volatile__(
-		"\tjmp 1f\n"
-		".align 16\n"
-		"1:\tjmp 2f\n"
-		".align 16\n"
-		"2:\tdecl %0\n\tjns 2b"
-		:"=&a" (d0)
-		:"0" (loops));
-}
-
-
 /*
  * get the offset (in microseconds) from the last call to mark_offset()
  *	- Called holding a reader xtime_lock
@@ -185,16 +143,15 @@
 }
 
 
-/* acpi timer_opts struct */
+/* acpi timer_opts struct1 */
 struct timer_opts timer_pmtmr = {
 	.name			= "acpi_pm_timer",
 	.init 			= init_pmtmr,
 	.mark_offset		= mark_offset_pmtmr,
 	.get_offset		= get_offset_pmtmr,
-	.monotonic_clock 	= monotonic_clock_pmtmr,
-	.delay 			= delay_pmtmr,
+	.monotonic_clock 	= monotonic_clock_tsc,
+	.delay 			= delay_tsc,
 };
-
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
diff -Nru a/arch/i386/kernel/timers/timer_tsc.c b/arch/i386/kernel/timers/timer_tsc.c
--- a/arch/i386/kernel/timers/timer_tsc.c	Mon Jan  5 00:47:14 2004
+++ b/arch/i386/kernel/timers/timer_tsc.c	Mon Jan  5 00:47:14 2004
@@ -7,7 +7,6 @@
 #include <linux/init.h>
 #include <linux/timex.h>
 #include <linux/errno.h>
-#include <linux/cpufreq.h>
 #include <linux/string.h>
 #include <linux/jiffies.h>
 
@@ -19,145 +18,22 @@
 #include "io_ports.h"
 #include "mach_timer.h"
 
-#include <asm/hpet.h>
-
-#ifdef CONFIG_HPET_TIMER
-static unsigned long hpet_usec_quotient;
-static unsigned long hpet_last;
-struct timer_opts timer_tsc;
-#endif
+#include <asm/timer_common.h>
 
 int tsc_disable __initdata = 0;
 
 extern spinlock_t i8253_lock;
 
-static int use_tsc;
-/* Number of usecs that the last interrupt was delayed */
-static int delay_at_last_interrupt;
-
-static unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
-static unsigned long last_tsc_high; /* msb 32 bits of Time Stamp Counter */
-static unsigned long long monotonic_base;
-static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
-
-/* convert from cycles(64bits) => nanoseconds (64bits)
- *  basic equation:
- *		ns = cycles / (freq / ns_per_sec)
- *		ns = cycles * (ns_per_sec / freq)
- *		ns = cycles * (10^9 / (cpu_mhz * 10^6))
- *		ns = cycles * (10^3 / cpu_mhz)
- *
- *	Then we use scaling math (suggested by george@mvista.com) to get:
- *		ns = cycles * (10^3 * SC / cpu_mhz) / SC
- *		ns = cycles * cyc2ns_scale / SC
- *
- *	And since SC is a constant power of two, we can convert the div
- *  into a shift.   
- *			-johnstul@us.ibm.com "math is hard, lets go shopping!"
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
-
 static int count2; /* counter for mark_offset_tsc() */
 
-/* Cached *multiplier* to convert TSC counts to microseconds.
- * (see the equation below).
- * Equal to 2^32 * (1 / (clocks per usec) ).
- * Initialized in time_init.
- */
-static unsigned long fast_gettimeoffset_quotient;
-
-static unsigned long get_offset_tsc(void)
-{
-	register unsigned long eax, edx;
-
-	/* Read the Time Stamp Counter */
-
-	rdtsc(eax,edx);
-
-	/* .. relative to previous jiffy (32 bits is enough) */
-	eax -= last_tsc_low;	/* tsc_low delta */
-
-	/*
-         * Time offset = (tsc_low delta) * fast_gettimeoffset_quotient
-         *             = (tsc_low delta) * (usecs_per_clock)
-         *             = (tsc_low delta) * (usecs_per_jiffy / clocks_per_jiffy)
-	 *
-	 * Using a mull instead of a divl saves up to 31 clock cycles
-	 * in the critical path.
-         */
-
-	__asm__("mull %2"
-		:"=a" (eax), "=d" (edx)
-		:"rm" (fast_gettimeoffset_quotient),
-		 "0" (eax));
-
-	/* our adjusted time offset in microseconds */
-	return delay_at_last_interrupt + edx;
-}
-
-static unsigned long long monotonic_clock_tsc(void)
-{
-	unsigned long long last_offset, this_offset, base;
-	unsigned seq;
-	
-	/* atomically read monotonic base & last_offset */
-	do {
-		seq = read_seqbegin(&monotonic_lock);
-		last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-		base = monotonic_base;
-	} while (read_seqretry(&monotonic_lock, seq));
-
-	/* Read the Time Stamp Counter */
-	rdtscll(this_offset);
-
-	/* return the value in ns */
-	return base + cycles_2_ns(this_offset - last_offset);
-}
-
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
-		return (unsigned long long)get_jiffies_64() * (1000000000 / HZ);
-
-	/* Read the Time Stamp Counter */
-	rdtscll(this_offset);
-
-	/* return the value in ns */
-	return cycles_2_ns(this_offset);
-}
-
-
 static void mark_offset_tsc(void)
 {
-	unsigned long lost,delay;
+	unsigned long lost, delay;
 	unsigned long delta = last_tsc_low;
 	int count;
 	int countmp;
 	static int count1 = 0;
-	unsigned long long this_offset, last_offset;
+	unsigned long long last_offset;
 	static int lost_count = 0;
 	
 	write_seqlock(&monotonic_lock);
@@ -212,21 +88,11 @@
 	}
 
 	/* lost tick compensation */
-	delta = last_tsc_low - delta;
-	{
-		register unsigned long eax, edx;
-		eax = delta;
-		__asm__("mull %2"
-		:"=a" (eax), "=d" (edx)
-		:"rm" (fast_gettimeoffset_quotient),
-		 "0" (eax));
-		delta = edx;
-	}
-	delta += delay_at_last_interrupt;
-	lost = delta/(1000000/HZ);
-	delay = delta%(1000000/HZ);
+	delta = tsc_2_usecs(last_tsc_low - delta) + tsc_delay_at_last_interrupt;
+	lost = delta / (USEC_PER_SEC / HZ);
+	delay = delta % (USEC_PER_SEC / HZ);
 	if (lost >= 2) {
-		jiffies_64 += lost-1;
+		jiffies_64 += lost - 1;
 
 		/* sanity check to ensure we're not always losing ticks */
 		if (lost_count++ > 100) {
@@ -238,146 +104,28 @@
 		}
 	} else
 		lost_count = 0;
+
 	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
+	tsc_update_monotonic_base(last_offset);
 	write_sequnlock(&monotonic_lock);
 
-	/* calculate delay_at_last_interrupt */
+	/* calculate tsc_delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
-	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
+	tsc_delay_at_last_interrupt = (count + LATCH/2) / LATCH;
 
 	/* catch corner case where tick rollover occured 
 	 * between tsc and pit reads (as noted when 
 	 * usec delta is > 90% # of usecs/tick)
 	 */
-	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
+	if (lost && abs(delay - tsc_delay_at_last_interrupt) > (900000/HZ))
 		jiffies_64++;
 }
 
-static void delay_tsc(unsigned long loops)
-{
-	unsigned long bclock, now;
-	
-	rdtscl(bclock);
-	do
-	{
-		rep_nop();
-		rdtscl(now);
-	} while ((now-bclock) < loops);
-}
-
-#ifdef CONFIG_HPET_TIMER
-static void mark_offset_tsc_hpet(void)
-{
-	unsigned long long this_offset, last_offset;
- 	unsigned long offset, temp, hpet_current;
-
-	write_seqlock(&monotonic_lock);
-	last_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	/*
-	 * It is important that these two operations happen almost at
-	 * the same time. We do the RDTSC stuff first, since it's
-	 * faster. To avoid any inconsistencies, we need interrupts
-	 * disabled locally.
-	 */
-	/*
-	 * Interrupts are just disabled locally since the timer irq
-	 * has the SA_INTERRUPT flag set. -arca
-	 */
-	/* read Pentium cycle counter */
-
-	hpet_current = hpet_readl(HPET_COUNTER);
-	rdtsc(last_tsc_low, last_tsc_high);
-
-	/* lost tick compensation */
-	offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
-	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))) {
-		int lost_ticks = (offset - hpet_last) / hpet_tick;
-		jiffies_64 += lost_ticks;
-	}
-	hpet_last = hpet_current;
-
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
-	write_sequnlock(&monotonic_lock);
-
-	/* calculate delay_at_last_interrupt */
-	/*
-	 * Time offset = (hpet delta) * ( usecs per HPET clock )
-	 *             = (hpet delta) * ( usecs per tick / HPET clocks per tick)
-	 *             = (hpet delta) * ( hpet_usec_quotient ) / (2^32)
-	 * Where,
-	 * hpet_usec_quotient = (2^32 * usecs per tick)/HPET clocks per tick
-	 */
-	delay_at_last_interrupt = hpet_current - offset;
-	ASM_MUL64_REG(temp, delay_at_last_interrupt,
-			hpet_usec_quotient, delay_at_last_interrupt);
-}
-#endif
-
-#ifdef CONFIG_CPU_FREQ
-static unsigned int  ref_freq = 0;
-static unsigned long loops_per_jiffy_ref = 0;
-
-#ifndef CONFIG_SMP
-static unsigned long fast_gettimeoffset_ref = 0;
-static unsigned long cpu_khz_ref = 0;
-#endif
-
-static int
-time_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
-		       void *data)
-{
-	struct cpufreq_freqs *freq = data;
-
-	write_seqlock_irq(&xtime_lock);
-	if (!ref_freq) {
-		ref_freq = freq->old;
-		loops_per_jiffy_ref = cpu_data[freq->cpu].loops_per_jiffy;
-#ifndef CONFIG_SMP
-		fast_gettimeoffset_ref = fast_gettimeoffset_quotient;
-		cpu_khz_ref = cpu_khz;
-#endif
-	}
-
-	if ((val == CPUFREQ_PRECHANGE  && freq->old < freq->new) ||
-	    (val == CPUFREQ_POSTCHANGE && freq->old > freq->new)) {
-		cpu_data[freq->cpu].loops_per_jiffy = cpufreq_scale(loops_per_jiffy_ref, ref_freq, freq->new);
-#ifndef CONFIG_SMP
-		if (use_tsc) {
-			fast_gettimeoffset_quotient = cpufreq_scale(fast_gettimeoffset_ref, freq->new, ref_freq);
-			cpu_khz = cpufreq_scale(cpu_khz_ref, ref_freq, freq->new);
-			set_cyc2ns_scale(cpu_khz/1000);
-		}
-#endif
-	}
-	write_sequnlock_irq(&xtime_lock);
-
-	return 0;
-}
-
-static struct notifier_block time_cpufreq_notifier_block = {
-	.notifier_call	= time_cpufreq_notifier
-};
-#endif
-
-
 static int __init init_tsc(char* override)
 {
-
 	/* check clock override */
-	if (override[0] && strncmp(override,"tsc",3)) {
-#ifdef CONFIG_HPET_TIMER
-		if (is_hpet_enabled()) {
-			printk(KERN_ERR "Warning: clock= override failed. Defaulting to tsc\n");
-		} else
-#endif
-		{
-			return -ENODEV;
-		}
-	}
+	if (override[0] && strncmp(override, "tsc", 3)) 
+		return -ENODEV;
 
 	/*
 	 * If we have APM enabled or the CPU clock speed is variable
@@ -404,55 +152,17 @@
  	 *	moaned if you have the only one in the world - you fix it!
  	 */
  
-#ifdef CONFIG_CPU_FREQ
-	cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
-#endif
-
 	count2 = LATCH; /* initialize counter for mark_offset_tsc() */
 
 	if (cpu_has_tsc) {
-		unsigned long tsc_quotient;
-#ifdef CONFIG_HPET_TIMER
-		if (is_hpet_enabled()){
-			unsigned long result, remain;
-			printk("Using TSC for gettimeofday\n");
-			tsc_quotient = calibrate_tsc_hpet(NULL);
-			timer_tsc.mark_offset = &mark_offset_tsc_hpet;
-			/*
-			 * Math to calculate hpet to usec multiplier
-			 * Look for the comments at get_offset_tsc_hpet()
-			 */
-			ASM_DIV64_REG(result, remain, hpet_tick,
-					0, KERNEL_TICK_USEC);
-			if (remain > (hpet_tick >> 1))
-				result++; /* rounding the result */
-
-			hpet_usec_quotient = result;
-		} else
-#endif
-		{
-			tsc_quotient = calibrate_tsc();
-		}
+		tsc_quotient = calibrate_tsc();
 
 		if (tsc_quotient) {
-			fast_gettimeoffset_quotient = tsc_quotient;
 			use_tsc = 1;
 			/*
 			 *	We could be more selective here I suspect
 			 *	and just enable this for the next intel chips ?
 			 */
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
-			set_cyc2ns_scale(cpu_khz/1000);
 			return 0;
 		}
 	}
@@ -483,10 +193,10 @@
 
 /* tsc timer_opts struct */
 struct timer_opts timer_tsc = {
-	.name = 	"tsc",
-	.init =		init_tsc,
-	.mark_offset =	mark_offset_tsc, 
-	.get_offset =	get_offset_tsc,
+	.name = 		"tsc",
+	.init =			init_tsc,
+	.mark_offset =		mark_offset_tsc, 
+	.get_offset =		get_offset_tsc,
 	.monotonic_clock =	monotonic_clock_tsc,
-	.delay = delay_tsc,
+	.delay = 		delay_tsc,
 };
diff -Nru a/include/asm-i386/timer.h b/include/asm-i386/timer.h
--- a/include/asm-i386/timer.h	Mon Jan  5 00:47:14 2004
+++ b/include/asm-i386/timer.h	Mon Jan  5 00:47:14 2004
@@ -24,6 +24,8 @@
 extern struct timer_opts* select_timer(void);
 extern void clock_fallback(void);
 
+extern void init_cpu_khz(void);
+
 /* Modifiers for buggy PIT handling */
 
 extern int pit_latch_buggy;
@@ -38,15 +40,12 @@
 #ifdef CONFIG_X86_CYCLONE_TIMER
 extern struct timer_opts timer_cyclone;
 #endif
-
-extern unsigned long calibrate_tsc(void);
-extern void init_cpu_khz(void);
 #ifdef CONFIG_HPET_TIMER
 extern struct timer_opts timer_hpet;
-extern unsigned long calibrate_tsc_hpet(unsigned long *tsc_hpet_quotient_ptr);
+extern struct timer_opts timer_tsc_hpet;
 #endif
-
 #ifdef CONFIG_X86_PM_TIMER
 extern struct timer_opts timer_pmtmr;
 #endif
+
 #endif
diff -Nru a/include/asm-i386/timer_common.h b/include/asm-i386/timer_common.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-i386/timer_common.h	Mon Jan  5 00:47:14 2004
@@ -0,0 +1,70 @@
+#ifndef _ASMi386_TIMER_COMMON_H
+#define _ASMi386_TIMER_COMMON_H
+
+extern int tsc_delay_at_last_interrupt;
+
+extern unsigned long last_tsc_low; /* lsb 32 bits of Time Stamp Counter */
+extern unsigned long last_tsc_high; /* msb 32 bits of Time Stamp Counter */
+
+extern unsigned long tsc_quotient; /* Cached *multiplier* to convert TSC counts to microseconds. */
+
+extern int use_tsc; /* tsc has been validated and is allowed to use */
+
+extern unsigned long long monotonic_base;
+extern seqlock_t monotonic_lock;
+
+extern unsigned long calibrate_tsc(void);
+extern unsigned long get_offset_tsc(void);
+extern unsigned long long monotonic_clock_tsc(void);
+extern void delay_tsc(unsigned long loops);
+
+extern unsigned long tsc_2_quotient(unsigned long[], unsigned long[], unsigned long);
+
+/* convert from cycles(64bits) => nanoseconds (64bits)
+ *  basic equation:
+ *              ns = cycles / (freq / ns_per_sec)
+ *              ns = cycles * (ns_per_sec / freq)
+ *              ns = cycles * (10^9 / (cpu_mhz * 10^6))
+ *              ns = cycles * (10^3 / cpu_mhz)
+ *
+ *      Then we use scaling math (suggested by george@mvista.com) to get:
+ *              ns = cycles * (10^3 * SC / cpu_mhz) / SC
+ *              ns = cycles * cyc2ns_scale / SC
+ *
+ *      And since SC is a constant power of two, we can convert the div
+ *  into a shift.
+ *                      -johnstul@us.ibm.com "math is hard, lets go shopping!"
+ */
+extern unsigned long cyc2ns_scale;
+#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
+
+static __inline__ void set_cyc2ns_scale(unsigned long cpu_mhz)
+{
+        cyc2ns_scale = (1000 << CYC2NS_SCALE_FACTOR)/cpu_mhz;
+}
+
+static __inline__ unsigned long long cycles_2_ns(unsigned long long cyc)
+{
+        return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
+}
+
+static __inline__ unsigned long tsc_2_usecs(unsigned long tsc)
+{
+	register unsigned long usecs;
+
+	__asm__("mull %2"
+		:"=a" (tsc), "=d" (usecs)
+                :"rm" (tsc_quotient), "0" (tsc));
+
+	return usecs;
+}
+
+static __inline__ void tsc_update_monotonic_base(unsigned long long last_offset)
+{
+	unsigned long long this_offset;
+
+	this_offset = ((unsigned long long)last_tsc_high << 32) | last_tsc_low;
+	monotonic_base += cycles_2_ns(this_offset - last_offset);
+}
+
+#endif
