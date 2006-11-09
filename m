Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424268AbWKIXnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424268AbWKIXnz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 18:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424244AbWKIXjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 18:39:37 -0500
Received: from www.osadl.org ([213.239.205.134]:925 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161871AbWKIXjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 18:39:13 -0500
Message-Id: <20061109233035.340517000@cruncher.tec.linutronix.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
Date: Thu, 09 Nov 2006 23:38:28 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Len Brown <lenb@kernel.org>, John Stultz <johnstul@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 11/19] i386: Rework local APIC calibration
Content-Disposition: inline; filename=i386-lapic-calibrate-timer.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The local apic timer calibration has two problem cases:

1. The calibration is based on readout of the PIT/HPET timer to detect 
the wrap of the periodic tick. It happens that a box gets stuck in the
calibration loop due to a PIT with a broken readout function.

2. CoreDuo boxen show a sporadic PIT runs too slow defect, which results
in a wrong lapic calibration. The PIT goes back to normal operation once
the lapic timer is switched to periodic mode.

Rework the code to address both problems:
- Make the calibration interrupt driven. This removes the wait_timer_tick
  magic hackery from lapic.c and time_hpet.c. The clockevents framework
  allows easy substitution of the global tick event handler for the
  calibration. This is more accurate than monitoring jiffies. At this
  point of the boot process, nothing disturbes the interrupt delivery, so
  the results are very accurate.

- Verify the calibration against the PM timer, when available by using the
  early access function. When the measured calibration period is outside
  of an one percent window, then the lapic timer calibration is adjusted
  to the pm timer result.

- Verify the calibration by running the lapic timer with the calibration
  handler. Disable lapic timer in case of deviation.

This also removes the "synchronization" of the local apic timer to the
global tick. This synchronization never worked, as there is no way to
synchronize PIT(HPET) and local APIC timer. The synchronization by waiting
for the tick just alignes the local APIC timer for the first events, but
later the events drift away due to the different clocks. Removing the
"sync" is just randomizing the asynchronous behaviour at setup time.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>

Index: linux-2.6.19-rc5-mm1/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/arch/i386/kernel/apic.c	2006-11-09 21:06:17.000000000 +0100
+++ linux-2.6.19-rc5-mm1/arch/i386/kernel/apic.c	2006-11-09 21:06:22.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
 #include <linux/clockchips.h>
+#include <linux/acpi_pmtmr.h>
 #include <linux/module.h>
 
 #include <asm/atomic.h>
@@ -163,64 +164,8 @@ int lapic_get_maxlvt(void)
  * Local APIC timer
  */
 
-/*
- * This part sets up the APIC 32 bit clock in LVTT1, with HZ interrupts
- * per second. We assume that the caller has already set up the local
- * APIC.
- *
- * The APIC timer is not exactly sync with the external timer chip, it
- * closely follows bus clocks.
- */
-
-/*
- * FIXME: Move this to i8253.h. There is no need to keep the access to
- * the PIT scattered all around the place -tglx
- */
-
-/*
- * The timer chip is already set up at HZ interrupts per second here,
- * but we do not accept timer interrupts yet. We only allow the BP
- * to calibrate.
- */
-static unsigned int __devinit get_8254_timer_count(void)
-{
-	unsigned long flags;
-
-	unsigned int count;
-
-	spin_lock_irqsave(&i8253_lock, flags);
-
-	outb_p(0x00, PIT_MODE);
-	count = inb_p(PIT_CH0);
-	count |= inb_p(PIT_CH0) << 8;
-
-	spin_unlock_irqrestore(&i8253_lock, flags);
-
-	return count;
-}
-
-/* next tick in 8254 can be caught by catching timer wraparound */
-static void __devinit wait_8254_wraparound(void)
-{
-	unsigned int curr_count, prev_count;
-
-	curr_count = get_8254_timer_count();
-	do {
-		prev_count = curr_count;
-		curr_count = get_8254_timer_count();
-
-		/* workaround for broken Mercury/Neptune */
-		if (prev_count >= curr_count + 0x100)
-			curr_count = get_8254_timer_count();
-
-	} while (prev_count >= curr_count);
-}
-
-/*
- * Default initialization for 8254 timers. If we use other timers like HPET,
- * we override this later
- */
-void (*wait_timer_tick)(void) __devinitdata = wait_8254_wraparound;
+/* Clock divisor is set to 16 */
+#define APIC_DIVISOR 16
 
 /*
  * This function sets up the local APIC timer, with a timeout of
@@ -232,9 +177,6 @@ void (*wait_timer_tick)(void) __devinitd
  * We do reads before writes even if unnecessary, to get around the
  * P5 APIC double write bug.
  */
-
-#define APIC_DIVISOR 16
-
 static void __setup_APIC_LVTT(unsigned int clocks, int oneshot, int irqen)
 {
 	unsigned int lvtt_value, tmp_value;
@@ -312,112 +254,244 @@ static void __devinit setup_APIC_timer(v
 }
 
 /*
- * In this function we calibrate APIC bus clocks to the external
- * timer. Unfortunately we cannot use jiffies and the timer irq
- * to calibrate, since some later bootup code depends on getting
- * the first irq? Ugh.
+ * In this functions we calibrate APIC bus clocks to the external timer.
+ *
+ * We want to do the calibration only once since we want to have local timer
+ * irqs syncron. CPUs connected by the same APIC bus have the very same bus
+ * frequency.
  *
- * TODO: Fix this rather than saying "Ugh" -tglx
+ * This was previously done by reading the PIT/HPET and waiting for a wrap
+ * around to find out, that a tick has elapsed. I have a box, where the PIT
+ * readout is broken, so it never gets out of the wait loop again. This was
+ * also reported by others.
  *
- * We want to do the calibration only once since we
- * want to have local timer irqs syncron. CPUs connected
- * by the same APIC bus have the very same bus frequency.
- * And we want to have irqs off anyways, no accidental
- * APIC irq that way.
+ * Monitoring the jiffies value is inaccurate and the clockevents
+ * infrastructure allows us to do a simple substitution of the interrupt
+ * handler.
+ *
+ * The calibration routine also uses the pm_timer when possible, as the PIT
+ * happens to run way too slow (factor 2.3 on my VAIO CoreDuo, which goes
+ * back to normal later in the boot process).
  */
 
-static int __init calibrate_APIC_clock(void)
+#define LAPIC_CAL_LOOPS		(HZ/10)
+
+static __initdata volatile int lapic_cal_loops = -1;
+static __initdata long lapic_cal_t1, lapic_cal_t2;
+static __initdata unsigned long long lapic_cal_tsc1, lapic_cal_tsc2;
+static __initdata unsigned long lapic_cal_pm1, lapic_cal_pm2;
+static __initdata unsigned long lapic_cal_j1, lapic_cal_j2;
+
+/*
+ * Temporary interrupt handler.
+ */
+static void __init lapic_cal_handler(struct pt_regs *regs)
 {
-	unsigned long long t1 = 0, t2 = 0;
-	long tt1, tt2;
-	long result;
-	int i;
-	const int LOOPS = HZ/10;
+	unsigned long long tsc = 0;
+	long tapic = apic_read(APIC_TMCCT);
+	unsigned long pm = acpi_pm_read_early();
 
-	apic_printk(APIC_VERBOSE, "calibrating APIC timer ...\n");
+	if (cpu_has_tsc)
+		rdtscll(tsc);
 
-	/*
-	 * Put whatever arbitrary (but long enough) timeout
-	 * value into the APIC clock, we just want to get the
-	 * counter running for calibration.
-	 */
-	__setup_APIC_LVTT(1000000000, 0, 0);
+	switch (lapic_cal_loops++) {
+	case 0:
+		lapic_cal_t1 = tapic;
+		lapic_cal_tsc1 = tsc;
+		lapic_cal_pm1 = pm;
+		lapic_cal_j1 = jiffies;
+		break;
 
-	/*
-	 * The timer chip counts down to zero. Let's wait
-	 * for a wraparound to start exact measurement:
-	 * (the current tick might have been already half done)
-	 */
+	case LAPIC_CAL_LOOPS:
+		lapic_cal_t2 = tapic;
+		lapic_cal_tsc2 = tsc;
+		if (pm < lapic_cal_pm1)
+			pm += ACPI_PM_OVRRUN;
+		lapic_cal_pm2 = pm;
+		lapic_cal_j2 = jiffies;
+		break;
+	}
+}
 
-	wait_timer_tick();
+/*
+ * Setup the boot APIC
+ *
+ * Calibrate and verify the result.
+ */
+void __init setup_boot_APIC_clock(void)
+{
+	struct clock_event_device *levt = &__get_cpu_var(lapic_events);
+	const long pm_100ms = PMTMR_TICKS_PER_SEC/10;
+	const long pm_thresh = pm_100ms/100;
+	void (*real_handler)(struct pt_regs *regs);
+	unsigned long deltaj;
+	long delta, deltapm;
+	cpumask_t cpumask;
 
-	/*
-	 * We wrapped around just now. Let's start:
-	 */
-	if (cpu_has_tsc)
-		rdtscll(t1);
-	tt1 = apic_read(APIC_TMCCT);
+	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n"
+		    "calibrating APIC timer ...\n");
+
+	/* Register broadcast function */
+	clockevents_register_broadcast(lapic_timer_broadcast);
 
 	/*
-	 * Let's wait LOOPS wraprounds:
+	 * Enable the apic timer next event capability only for
+	 * SMP and on UP, when requested via commandline
 	 */
-	for (i = 0; i < LOOPS; i++)
-		wait_timer_tick();
+	if (num_possible_cpus() > 1 || enable_local_apic_timer)
+		lapic_clockevent.capabilities |= CLOCK_CAP_NEXTEVT;
 
-	tt2 = apic_read(APIC_TMCCT);
-	if (cpu_has_tsc)
-		rdtscll(t2);
+	local_irq_disable();
+
+	/* Replace the global interrupt handler */
+	real_handler = global_clock_event->event_handler;
+	global_clock_event->event_handler = lapic_cal_handler;
 
 	/*
-	 * The APIC bus clock counter is 32 bits only, it
-	 * might have overflown, but note that we use signed
-	 * longs, thus no extra care needed.
-	 *
-	 * underflown to be exact, as the timer counts down ;)
+	 * Setup the APIC counter to 1e9. There is no way the lapic
+	 * can underflow in the 100ms detection time frame
 	 */
+	__setup_APIC_LVTT(1000000000, 0, 0);
+
+	/* Let the interrupts run */
+	local_irq_enable();
+
+	while(lapic_cal_loops <= LAPIC_CAL_LOOPS);
+
+	local_irq_disable();
+
+	/* Restore the real event handler */
+	global_clock_event->event_handler = real_handler;
+
+	/* Build delta t1-t2 as apic timer counts down */
+	delta = lapic_cal_t1 - lapic_cal_t2;
+	apic_printk(APIC_VERBOSE, "... lapic delta = %ld\n", delta);
+
+	/* Check, if the PM timer is available */
+	deltapm = lapic_cal_pm2 - lapic_cal_pm1;
+	apic_printk(APIC_VERBOSE, "... PM timer delta = %ld\n", deltapm);
 
-	result = (tt1-tt2)*APIC_DIVISOR/LOOPS;
+	if (deltapm) {
+		unsigned long mult;
+		u64 res;
+
+		mult = clocksource_hz2mult(PMTMR_TICKS_PER_SEC, 22);
+
+		if (deltapm > (pm_100ms - pm_thresh) &&
+		    deltapm < (pm_100ms + pm_thresh)) {
+			apic_printk(APIC_VERBOSE, "... PM timer result ok\n");
+		} else {
+			res = (((u64) deltapm) *  mult) >> 22;
+			do_div(res, 1000000);
+			printk(KERN_WARNING "APIC calibration not consistent "
+			       "with PM Timer: %ldms instead of 100ms\n",
+			       (long)res);
+			/* Correct the lapic counter value */
+			res = (((u64) delta ) * pm_100ms);
+			do_div(res, deltapm);
+			printk(KERN_INFO "APIC delta adjusted to PM-Timer: "
+			       "%lu (%ld)\n", (unsigned long) res, delta);
+			delta = (long) res;
+		}
+	}
 
 	/* Calculate the scaled math multiplication factor */
-	lapic_clockevent.mult = div_sc(tt1-tt2, TICK_NSEC * LOOPS, 32);
+	lapic_clockevent.mult = div_sc(delta, TICK_NSEC * LAPIC_CAL_LOOPS, 32);
 	lapic_clockevent.max_delta_ns =
 		clockevent_delta2ns(0x7FFFFF, &lapic_clockevent);
 	lapic_clockevent.min_delta_ns =
 		clockevent_delta2ns(0xF, &lapic_clockevent);
 
-	apic_printk(APIC_VERBOSE, "..... tt1-tt2 %ld\n", tt1 - tt2);
+	calibration_result = (delta * APIC_DIVISOR) / LAPIC_CAL_LOOPS;
+
+	apic_printk(APIC_VERBOSE, "..... delta %ld\n", delta);
 	apic_printk(APIC_VERBOSE, "..... mult: %ld\n", lapic_clockevent.mult);
-	apic_printk(APIC_VERBOSE, "..... calibration result: %ld\n", result);
+	apic_printk(APIC_VERBOSE, "..... calibration result: %u\n",
+		    calibration_result);
 
-	if (cpu_has_tsc)
+	if (cpu_has_tsc) {
+		delta = (long)(lapic_cal_tsc2 - lapic_cal_tsc1);
 		apic_printk(APIC_VERBOSE, "..... CPU clock speed is "
-			"%ld.%04ld MHz.\n",
-			((long)(t2-t1)/LOOPS)/(1000000/HZ),
-			((long)(t2-t1)/LOOPS)%(1000000/HZ));
+			    "%ld.%04ld MHz.\n",
+			    (delta / LAPIC_CAL_LOOPS) / (1000000 / HZ),
+			    (delta / LAPIC_CAL_LOOPS) % (1000000 / HZ));
+	}
 
 	apic_printk(APIC_VERBOSE, "..... host bus clock speed is "
-		"%ld.%04ld MHz.\n",
-		result/(1000000/HZ),
-		result%(1000000/HZ));
+		    "%u.%04u MHz.\n",
+		    calibration_result / (1000000 / HZ),
+		    calibration_result % (1000000 / HZ));
 
-	return result;
-}
 
-void __init setup_boot_APIC_clock(void)
-{
-	unsigned long flags;
-	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n");
-	using_apic_timer = 1;
-
-	local_irq_save(flags);
+	apic_printk(APIC_VERBOSE, "... verify APIC timer\n");
 
-	calibration_result = calibrate_APIC_clock();
 	/*
-	 * Now set up the timer for real.
+	 * Start LAPIC timer and verify that the calculated factor is correct
 	 */
 	setup_APIC_timer();
 
-	local_irq_restore(flags);
+	/* Replace the lapic interrupt handler */
+	real_handler = levt->event_handler;
+	levt->event_handler = lapic_cal_handler;
+	lapic_cal_loops = -1;
+
+	/* Let the interrupts run */
+	local_irq_enable();
+
+	while(lapic_cal_loops <= LAPIC_CAL_LOOPS);
+
+	local_irq_disable();
+
+	/* Restore the real event handler */
+	levt->event_handler = real_handler;
+
+	local_irq_enable();
+
+	/* Jiffies delta */
+	deltaj = lapic_cal_j2 - lapic_cal_j1;
+	apic_printk(APIC_VERBOSE, "... jiffies delta = %lu\n", deltaj);
+
+	/* Check, if the PM timer is available */
+	deltapm = lapic_cal_pm2 - lapic_cal_pm1;
+	apic_printk(APIC_VERBOSE, "... PM timer delta = %ld\n", deltapm);
+
+	if (deltapm) {
+		if (deltapm > (pm_100ms - pm_thresh) &&
+		    deltapm < (pm_100ms + pm_thresh)) {
+			apic_printk(APIC_VERBOSE, "... PM timer result ok\n");
+			/* Check, if the jiffies result is consistent */
+			if (deltaj < LAPIC_CAL_LOOPS-2 ||
+			    deltaj > LAPIC_CAL_LOOPS+2) {
+				/*
+				 * Not sure, what we can do about this one.
+				 * When high resultion timers are active
+				 * and the lapic timer does not stop in C3
+				 * we are fine. Otherwise more trouble might
+				 * be waiting. -- tglx
+				 */
+				printk(KERN_WARNING "Global event device %s "
+				       "has wrong frequency "
+				       "(%lu ticks instead of %d)\n",
+				       global_clock_event->name, deltaj,
+				       LAPIC_CAL_LOOPS);
+			}
+			return;
+		}
+	} else {
+		/* Check, if the jiffies result is consistent */
+		if (deltaj >= LAPIC_CAL_LOOPS-2 &&
+		    deltaj <= LAPIC_CAL_LOOPS+2) {
+			apic_printk(APIC_VERBOSE, "... jiffies result ok\n");
+			return;
+		}
+	}
+
+	printk(KERN_WARNING
+	       "APIC timer disabled due to verification failure.\n");
+	local_irq_disable();
+	cpumask = cpumask_of_cpu(smp_processor_id());
+	switch_APIC_timer_to_ipi(&cpumask);
+	local_irq_enable();
 }
 
 void __devinit setup_secondary_APIC_clock(void)
Index: linux-2.6.19-rc5-mm1/arch/i386/kernel/time_hpet.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/arch/i386/kernel/time_hpet.c	2006-11-09 20:55:35.000000000 +0100
+++ linux-2.6.19-rc5-mm1/arch/i386/kernel/time_hpet.c	2006-11-09 21:06:22.000000000 +0100
@@ -43,23 +43,6 @@ static void hpet_writel(unsigned long d,
 	writel(d, hpet_virt_address + a);
 }
 
-#ifdef CONFIG_X86_LOCAL_APIC
-/*
- * HPET counters dont wrap around on every tick. They just change the
- * comparator value and continue. Next tick can be caught by checking
- * for a change in the comparator value. Used in apic.c.
- */
-static void __devinit wait_hpet_tick(void)
-{
-	unsigned int start_cmp_val, end_cmp_val;
-
-	start_cmp_val = hpet_readl(HPET_T0_CMP);
-	do {
-		end_cmp_val = hpet_readl(HPET_T0_CMP);
-	} while (start_cmp_val == end_cmp_val);
-}
-#endif
-
 static int hpet_timer_stop_set_go(unsigned long tick)
 {
 	unsigned int cfg;
@@ -213,11 +196,6 @@ int __init hpet_enable(void)
 		hpet_alloc(&hd);
 	}
 #endif
-
-#ifdef CONFIG_X86_LOCAL_APIC
-	if (hpet_use_timer)
-		wait_timer_tick = wait_hpet_tick;
-#endif
 	return 0;
 }
 
Index: linux-2.6.19-rc5-mm1/include/asm-i386/apic.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/asm-i386/apic.h	2006-11-09 21:06:17.000000000 +0100
+++ linux-2.6.19-rc5-mm1/include/asm-i386/apic.h	2006-11-09 21:06:22.000000000 +0100
@@ -93,8 +93,6 @@ static inline void ack_APIC_irq(void)
 	apic_write_around(APIC_EOI, 0);
 }
 
-extern void (*wait_timer_tick)(void);
-
 extern int lapic_get_maxlvt(void);
 extern void clear_local_APIC(void);
 extern void connect_bsp_APIC (void);

--

