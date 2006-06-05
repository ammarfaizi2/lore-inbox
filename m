Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750705AbWFEWlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWFEWlx (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 18:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWFEWlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 18:41:53 -0400
Received: from sccrmhc14.comcast.net ([204.127.200.84]:10912 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1750705AbWFEWlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 18:41:52 -0400
Message-Id: <20060605224438.054796000@localhost.localdomain>
References: <20060605222956.608067000@localhost.localdomain>
Date: Mon, 05 Jun 2006 15:29:57 -0700
From: dsaxena@plexity.net
To: mingo@elte.hu, tglx@linutronix.de, johnstul@us.ibm.com
Cc: dwalker@mvista.com, james.perkins@windriver.com,
        linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, khilman@mvista.com,
        Deepak Saxena <dsaxena@plexity.net>
Subject: [patch-rt 1/2] Remove existing time code from ARM architecture
Content-Disposition: inline; filename=arm-generic-timeofday.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes do_gettimeofday(), do_setttimeofday() and associated
time functions from ARM so that it can use the generic time-of-day code.
Each sub-arch must explicitly enable CONFIG_IS_TICK_BASED if it does
not have continous timer source.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


Index: linux-2.6-rt/arch/arm/Kconfig
===================================================================
--- linux-2.6-rt.orig/arch/arm/Kconfig
+++ linux-2.6-rt/arch/arm/Kconfig
@@ -46,6 +46,10 @@ config MCA
 	  <file:Documentation/mca.txt> (and especially the web page given
 	  there) before attempting to build an MCA bus kernel.
 
+config GENERIC_TIME
+	bool
+	default y
+
 config GENERIC_HARDIRQS
 	bool
 	default y
Index: linux-2.6-rt/arch/arm/kernel/time.c
===================================================================
--- linux-2.6-rt.orig/arch/arm/kernel/time.c
+++ linux-2.6-rt/arch/arm/kernel/time.c
@@ -28,6 +28,7 @@
 #include <linux/profile.h>
 #include <linux/sysdev.h>
 #include <linux/timer.h>
+#include <linux/timeofday.h>
 
 #include <asm/leds.h>
 #include <asm/thread_info.h>
@@ -70,10 +71,12 @@ EXPORT_SYMBOL(profile_pc);
  */
 int (*set_rtc)(void);
 
+#ifdef CONFIG_IS_TICK_BASED
 static unsigned long dummy_gettimeoffset(void)
 {
 	return 0;
 }
+#endif
 
 /*
  * Scheduler clock - returns current time in nanosec units.
@@ -85,34 +88,18 @@ unsigned long long __attribute__((weak))
 	return (unsigned long long)jiffies * (1000000000 / HZ);
 }
 
-static unsigned long next_rtc_update;
-
 /*
- * If we have an externally synchronized linux clock, then update
- * CMOS clock accordingly every ~11 minutes.  set_rtc() has to be
- * called as close as possible to 500 ms before the new second
- * starts.
+ * TODO: Merge this with generic RTC layer
  */
-static inline void do_set_rtc(void)
+s64 read_persistent_clock(void)
 {
-	if (!ntp_synced() || set_rtc == NULL)
-		return;
-
-	if (next_rtc_update &&
-	    time_before((unsigned long)xtime.tv_sec, next_rtc_update))
-		return;
-
-	if (xtime.tv_nsec < 500000000 - ((unsigned) tick_nsec >> 1) &&
-	    xtime.tv_nsec >= 500000000 + ((unsigned) tick_nsec >> 1))
-		return;
+	return 0; /* XXX - do something here! */
+}
 
-	if (set_rtc())
-		/*
-		 * rtc update failed.  Try again in 60s
-		 */
-		next_rtc_update = xtime.tv_sec + 60;
-	else
-		next_rtc_update = xtime.tv_sec + 660;
+void sync_persistent_clock(struct timespec ts)
+{
+	if (set_rtc)
+		set_rtc();
 }
 
 #ifdef CONFIG_LEDS
@@ -231,66 +218,6 @@ static inline void do_leds(void)
 #define	do_leds()
 #endif
 
-void do_gettimeofday(struct timeval *tv)
-{
-	unsigned long flags;
-	unsigned long seq;
-	unsigned long usec, sec, lost;
-
-	do {
-		seq = read_seqbegin_irqsave(&xtime_lock, flags);
-		usec = system_timer->offset();
-
-		lost = jiffies - wall_jiffies;
-		if (lost)
-			usec += lost * USECS_PER_JIFFY;
-
-		sec = xtime.tv_sec;
-		usec += xtime.tv_nsec / 1000;
-	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
-
-	/* usec may have gone up a lot: be safe */
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
-	/*
-	 * This is revolting. We need to set "xtime" correctly. However, the
-	 * value in this location is the value at the most recent update of
-	 * wall time.  Discover what correction gettimeofday() would have
-	 * done, and then undo it!
-	 */
-	nsec -= system_timer->offset() * NSEC_PER_USEC;
-	nsec -= (jiffies - wall_jiffies) * TICK_NSEC;
-
-	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
-	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
-
-	set_normalized_timespec(&xtime, sec, nsec);
-	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
-
-	ntp_clear();
-	write_sequnlock_irq(&xtime_lock);
-	clock_was_set();
-	return 0;
-}
-
 EXPORT_SYMBOL(do_settimeofday);
 
 /**
@@ -333,11 +260,8 @@ void timer_tick(struct pt_regs *regs)
 {
 	profile_tick(CPU_PROFILING, regs);
 	do_leds();
-	do_set_rtc();
 	do_timer(regs);
-#ifndef CONFIG_SMP
 	update_process_times(user_mode(regs));
-#endif
 }
 
 #ifdef CONFIG_PM
@@ -496,8 +420,10 @@ device_initcall(timer_init_sysfs);
 
 void __init time_init(void)
 {
+#ifdef CONFIG_IS_TICK_BASED
 	if (system_timer->offset == NULL)
 		system_timer->offset = dummy_gettimeoffset;
+#endif
 	system_timer->init();
 }
 
Index: linux-2.6-rt/include/asm-arm/timeofday.h
===================================================================
--- /dev/null
+++ linux-2.6-rt/include/asm-arm/timeofday.h
@@ -0,0 +1,4 @@
+#ifndef _ASM_ARM_TIMEOFDAY_H
+#define _ASM_ARM_TIMEOFDAY_H
+#include <asm-generic/timeofday.h>
+#endif
Index: linux-2.6-rt/include/asm-arm/mach/time.h
===================================================================
--- linux-2.6-rt.orig/include/asm-arm/mach/time.h
+++ linux-2.6-rt/include/asm-arm/mach/time.h
@@ -38,7 +38,10 @@ struct sys_timer {
 	void			(*init)(void);
 	void			(*suspend)(void);
 	void			(*resume)(void);
+
+#ifdef CONFIG_IS_TICK_BASED
 	unsigned long		(*offset)(void);
+#endif
 
 #ifdef CONFIG_NO_IDLE_HZ
 	struct dyn_tick_timer	*dyn_tick;

--
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertold Brecht
