Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWHHNtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWHHNtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 09:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWHHNtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 09:49:31 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:30929 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S964878AbWHHNta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 09:49:30 -0400
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com,
       Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH] AVR32: Switch to generic timekeeping framework
Reply-To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Tue, 08 Aug 2006 15:47:52 +0200
Message-Id: <11550448722406-git-send-email-hskinnemoen@atmel.com>
X-Mailer: git-send-email 1.4.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define CONFIG_GENERIC_TIME and remove arch-specific versions of
do_{get,set}timeofday(). Define and use a clocksource based on the
AVR32 cycle counter.

Also clean up asm/timex.h a bit, including defining CLOCK_TICK_RATE
to a "good cheat value" borrowed from MIPS instead of the i8254 value
used by "everyone" else, which is really quite pointless on AVR32.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/Kconfig        |    4 +
 arch/avr32/kernel/time.c  |  172 +++++++++-------------------------------------
 include/asm-avr32/timex.h |   26 ++++--
 3 files changed, 59 insertions(+), 143 deletions(-)

Index: linux-2.6.18-rc3-mm2/arch/avr32/Kconfig
===================================================================
--- linux-2.6.18-rc3-mm2.orig/arch/avr32/Kconfig	2006-08-07 13:50:36.000000000 +0200
+++ linux-2.6.18-rc3-mm2/arch/avr32/Kconfig	2006-08-08 15:28:05.000000000 +0200
@@ -38,6 +38,10 @@ config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
 
+config GENERIC_TIME
+	bool
+	default y
+
 config RWSEM_XCHGADD_ALGORITHM
 	bool
 
Index: linux-2.6.18-rc3-mm2/arch/avr32/kernel/time.c
===================================================================
--- linux-2.6.18-rc3-mm2.orig/arch/avr32/kernel/time.c	2006-08-07 13:50:36.000000000 +0200
+++ linux-2.6.18-rc3-mm2/arch/avr32/kernel/time.c	2006-08-08 15:36:48.000000000 +0200
@@ -10,6 +10,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clocksource.h>
 #include <linux/time.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -25,9 +26,19 @@
 #include <asm/io.h>
 #include <asm/sections.h>
 
-extern unsigned long wall_jiffies;
+static cycle_t read_cycle_count(void)
+{
+	return (cycle_t)sysreg_read(COUNT);
+}
 
-#define USECS_PER_JIFFY (1000000 / HZ)
+static struct clocksource clocksource_avr32 = {
+	.name		= "avr32",
+	.rating		= 350,
+	.read		= read_cycle_count,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift		= 16,
+	.is_continuous	= 1,
+};
 
 /*
  * By default we provide the null RTC ops
@@ -45,9 +56,6 @@ static int null_rtc_set_time(unsigned lo
 static unsigned long (*rtc_get_time)(void) = null_rtc_get_time;
 static int (*rtc_set_time)(unsigned long) = null_rtc_set_time;
 
-/* usecs per counter cycle, shifted left by 32 bits */
-static unsigned int sll32_usecs_per_cycle;
-
 /* how many counter cycles in a jiffy? */
 static unsigned long cycles_per_jiffy;
 
@@ -57,7 +65,7 @@ static unsigned int timerhi, timerlo;
 /* the count value for the next timer interrupt */
 static unsigned int expirelo;
 
-static inline void avr32_timer_ack(void)
+static void avr32_timer_ack(void)
 {
 	unsigned int count;
 
@@ -78,7 +86,7 @@ static inline void avr32_timer_ack(void)
 	}
 }
 
-static inline unsigned int avr32_hpt_read(void)
+static unsigned int avr32_hpt_read(void)
 {
 	return sysreg_read(COUNT);
 }
@@ -92,7 +100,7 @@ static inline unsigned int avr32_hpt_rea
  * probably to make sure we don't get any timer interrupts while we
  * are messing with the counter.
  */
-static inline void avr32_hpt_init(unsigned int count)
+static void avr32_hpt_init(unsigned int count)
 {
 	count = sysreg_read(COUNT) - count;
 	expirelo = (count / cycles_per_jiffy + 1) * cycles_per_jiffy;
@@ -110,116 +118,6 @@ unsigned long long sched_clock(void)
 	return (unsigned long long)jiffies * (1000000000 / HZ);
 }
 
-/* Taken from MIPS fixed_rate_gettimeoffset */
-static unsigned long do_gettimeoffset(void)
-{
-	unsigned long long tmp;
-	unsigned long res;
-	u32 count;
-
-	/* Get latest timer tick in absolute kernel time */
-	count = avr32_hpt_read();
-
-	/* ... relative to previous jiffy (32 bits is enough) */
-	count -= timerlo;
-
-	/* Divide by cycles_per_usec */
-	asm("mulu.d %0, %1, %2"
-	    : "=r"(tmp)
-	    : "r"(count), "r"(sll32_usecs_per_cycle));
-	res = tmp >> 32;
-
-	/*
-	 * Due to possible jiffies inconsistencies, we need to check
-	 * the result so that we'll get a timer that is monotonic.
-	 */
-	if (res >= USECS_PER_JIFFY)
-		res = USECS_PER_JIFFY - 1;
-
-	return res;
-}
-
-/* This one is taken from MIPS */
-void do_gettimeofday(struct timeval *tv)
-{
-	unsigned long seq;
-	unsigned long lost;
-	unsigned long usec, sec;
-	unsigned long max_ntp_tick = tick_usec - tickadj;
-
-	do {
-		seq = read_seqbegin(&xtime_lock);
-		usec = do_gettimeoffset();
-		lost = jiffies - wall_jiffies;
-
-		/*
-		 * If time_adjust is negative then NTP is slowing the
-		 * clock, so make sure not to go into next possible
-		 * interval. Better to lose some accuracy than have
-		 * time go backwards..
-		 */
-		if (unlikely(time_adjust < 0)) {
-			usec = min(usec, max_ntp_tick);
-
-			if (lost)
-				usec += lost * max_ntp_tick;
-		} else if (unlikely(lost)) {
-			usec += lost * tick_usec;
-		}
-
-		sec = xtime.tv_sec;
-		usec += xtime.tv_nsec / 1000;
-	} while (read_seqretry(&xtime_lock, seq));
-
-	while (usec >= 1000000) {
-		usec -= 1000000;
-		sec++;
-	}
-
-	tv->tv_sec = sec;
-	tv->tv_usec = usec;
-}
-
-EXPORT_SYMBOL(do_gettimeofday);
-
-int do_settimeofday(struct timespec *tv)
-{
-	time_t wtm_sec, sec = tv->tv_sec;
-	long wtm_nsec, nsec = tv->tv_nsec;
-
-	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
-		return -EINVAL;
-
-	write_seqlock_irq(&xtime_lock);
-
-	/*
-	 * This is revolting. We need to set "xtime" correctly.
-	 * However, the value in this location is the value at the
-	 * most recent update of wall time.  Discover what correction
-	 * gettimeofday() would have made, and undo it!
-	 */
-	nsec -= do_gettimeoffset() * NSEC_PER_USEC;
-	nsec -= (jiffies - wall_jiffies) * tick_nsec;
-
-	wtm_sec = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
-	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
-
-	set_normalized_timespec(&xtime, sec, nsec);
-	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
-
-	time_adjust = 0;
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
-
-	write_sequnlock_irq(&xtime_lock);
-	clock_was_set();
-
-	return 0;
-}
-
-EXPORT_SYMBOL(do_settimeofday);
-
 /*
  * local_timer_interrupt() does profiling and process accounting on a
  * per-CPU basis.
@@ -264,8 +162,6 @@ timer_interrupt(int irq, void *dev_id, s
 	return IRQ_HANDLED;
 }
 
-static unsigned int avr32_hpt_frequency;
-
 static struct irqaction timer_irqaction = {
 	.handler	= timer_interrupt,
 	.flags		= IRQF_DISABLED,
@@ -274,6 +170,7 @@ static struct irqaction timer_irqaction 
 
 void __init time_init(void)
 {
+	unsigned long mult, shift, count_hz;
 	int ret;
 
 	xtime.tv_sec = rtc_get_time();
@@ -286,22 +183,22 @@ void __init time_init(void)
 	       (unsigned long)sysreg_read(COUNT),
 	       (unsigned long)sysreg_read(COMPARE));
 
-	if (!avr32_hpt_frequency && boot_cpu_data.clk)
-		avr32_hpt_frequency = clk_get_rate(boot_cpu_data.clk);
-
-	if (avr32_hpt_frequency) {
-		cycles_per_jiffy = (avr32_hpt_frequency + HZ / 2) / HZ;
+	count_hz = clk_get_rate(boot_cpu_data.clk);
+	shift = clocksource_avr32.shift;
+	mult = clocksource_hz2mult(count_hz, shift);
+	clocksource_avr32.mult = mult;
+
+	printk("Cycle counter: mult=%lu, shift=%lu\n", mult, shift);
+
+	{
+		u64 tmp;
+
+		tmp = TICK_NSEC;
+		tmp <<= shift;
+		tmp += mult / 2;
+		do_div(tmp, mult);
 
-		/* 10^6 * 2^32 / avr32_hpt_frequency */
-		{
-			u64 tmp = 1000000ULL << 32;
-			do_div(tmp, avr32_hpt_frequency);
-			sll32_usecs_per_cycle = tmp;
-		}
-
-		printk("Using %u.%03u MHz high precision timer.\n",
-		       ((avr32_hpt_frequency + 500) / 1000) / 1000,
-		       ((avr32_hpt_frequency + 500) / 1000) % 1000);
+		cycles_per_jiffy = tmp;
 	}
 
 	/* This sets up the high precision timer for the first interrupt. */
@@ -311,6 +208,11 @@ void __init time_init(void)
 	       (unsigned long)sysreg_read(COUNT),
 	       (unsigned long)sysreg_read(COMPARE));
 
+	ret = clocksource_register(&clocksource_avr32);
+	if (ret)
+		printk(KERN_ERR
+		       "timer: could not register clocksource: %d\n", ret);
+
 	ret = setup_irq(0, &timer_irqaction);
 	if (ret)
 		printk("timer: could not request IRQ 0: %d\n", ret);
Index: linux-2.6.18-rc3-mm2/include/asm-avr32/timex.h
===================================================================
--- linux-2.6.18-rc3-mm2.orig/include/asm-avr32/timex.h	2006-08-07 13:50:36.000000000 +0200
+++ linux-2.6.18-rc3-mm2/include/asm-avr32/timex.h	2006-08-08 15:36:48.000000000 +0200
@@ -8,17 +8,27 @@
 #ifndef __ASM_AVR32_TIMEX_H
 #define __ASM_AVR32_TIMEX_H
 
-/* FIXME: I really have no idea... */
-#define CLOCK_TICK_RATE		1193180	/* Underlying HZ */
-#define CLOCK_TICK_FACTOR	20	/* Factor of both 1000000 and CLOCK_TICK_RATE */
-#define FINETUNE ((((((long)LATCH * HZ - CLOCK_TICK_RATE) << SHIFT_HZ) * \
-		   (1000000/CLOCK_TICK_FACTOR) / (CLOCK_TICK_RATE/CLOCK_TICK_FACTOR)) \
-		  << (SHIFT_SCALE-SHIFT_HZ)) / HZ)
+/*
+ * This is the frequency of the timer used for Linux's timer interrupt.
+ * The value should be defined as accurate as possible or under certain
+ * circumstances Linux timekeeping might become inaccurate or fail.
+ *
+ * For many system the exact clockrate of the timer isn't known but due to
+ * the way this value is used we can get away with a wrong value as long
+ * as this value is:
+ *
+ *  - a multiple of HZ
+ *  - a divisor of the actual rate
+ *
+ * 500000 is a good such cheat value.
+ *
+ * The obscure number 1193182 is the same as used by the original i8254
+ * time in legacy PC hardware; the chip is never found in AVR32 systems.
+ */
+#define CLOCK_TICK_RATE		500000	/* Underlying HZ */
 
 typedef unsigned long cycles_t;
 
-extern cycles_t cacheflush_time;
-
 static inline cycles_t get_cycles (void)
 {
 	return 0;
