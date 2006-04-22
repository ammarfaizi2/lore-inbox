Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWDVBzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWDVBzA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 21:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWDVBzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 21:55:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:44240 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750839AbWDVBy7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 21:54:59 -0400
Subject: [PATCH] time: rename clocksource functions
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 18:54:55 -0700
Message-Id: <1145670895.20737.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
	This patch, suggested by Roman Zippel, changes clocksource functions to
use clocksource_xyz rather then xyz_clocksource to avoid polluting the
namespace.

This applies ontop of 2.6.17-rc1-mm3

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>


Index: mmmerge/include/linux/clocksource.h
===================================================================
--- mmmerge.orig/include/linux/clocksource.h	2006-04-17 15:08:59.000000000 -0700
+++ mmmerge/include/linux/clocksource.h	2006-04-17 15:08:59.000000000 -0700
@@ -118,12 +118,12 @@ static inline u32 clocksource_hz2mult(u3
 }
 
 /**
- * read_clocksource: - Access the clocksource's current cycle value
+ * clocksource_read: - Access the clocksource's current cycle value
  * @cs:		pointer to clocksource being read
  *
  * Uses the clocksource to return the current cycle_t value
  */
-static inline cycle_t read_clocksource(struct clocksource *cs)
+static inline cycle_t clocksource_read(struct clocksource *cs)
 {
 	return cs->read();
 }
@@ -145,7 +145,7 @@ static inline s64 cyc2ns(struct clocksou
 }
 
 /**
- * calculate_clocksource_interval - Calculates a clocksource interval struct
+ * clocksource_calculate_interval - Calculates a clocksource interval struct
  *
  * @c:		Pointer to clocksource.
  * @length_nsec: Desired interval length in nanoseconds.
@@ -155,7 +155,7 @@ static inline s64 cyc2ns(struct clocksou
  *
  * Unless you're the timekeeping code, you should not be using this!
  */
-static inline void calculate_clocksource_interval(struct clocksource *c,
+static inline void clocksource_calculate_interval(struct clocksource *c,
 						unsigned long length_nsec)
 {
 	u64 tmp;
@@ -272,8 +272,8 @@ static inline s64 make_ntp_adj(struct cl
 
 
 /* used to install a new clocksource */
-int register_clocksource(struct clocksource*);
-void reselect_clocksource(void);
-struct clocksource* get_next_clocksource(void);
+int clocksource_register(struct clocksource*);
+void clocksource_reselect(void);
+struct clocksource* clocksource_get_next(void);
 
 #endif /* _LINUX_CLOCKSOURCE_H */
Index: mmmerge/kernel/time/clocksource.c
===================================================================
--- mmmerge.orig/kernel/time/clocksource.c	2006-04-17 15:08:59.000000000 -0700
+++ mmmerge/kernel/time/clocksource.c	2006-04-17 15:08:59.000000000 -0700
@@ -65,10 +65,10 @@ static int __init clocksource_done_booti
 late_initcall(clocksource_done_booting);
 
 /**
- * get_next_clocksource - Returns the selected clocksource
+ * clocksource_get_next - Returns the selected clocksource
  *
  */
-struct clocksource *get_next_clocksource(void)
+struct clocksource *clocksource_get_next(void)
 {
 	unsigned long flags;
 
@@ -142,12 +142,12 @@ static int is_registered_source(struct c
 }
 
 /**
- * register_clocksource - Used to install new clocksources
+ * clocksource_register - Used to install new clocksources
  * @t:		clocksource to be registered
  *
  * Returns -EBUSY if registration fails, zero otherwise.
  */
-int register_clocksource(struct clocksource *c)
+int clocksource_register(struct clocksource *c)
 {
 	int ret = 0;
 	unsigned long flags;
@@ -168,16 +168,16 @@ int register_clocksource(struct clocksou
 	return ret;
 }
 
-EXPORT_SYMBOL(register_clocksource);
+EXPORT_SYMBOL(clocksource_register);
 
 /**
- * reselect_clocksource - Rescan list for next clocksource
+ * clocksource_reselect - Rescan list for next clocksource
  *
  * A quick helper function to be used if a clocksource changes its
  * rating. Forces the clocksource list to be re-scaned for the best
  * clocksource.
  */
-void reselect_clocksource(void)
+void clocksource_reselect(void)
 {
 	unsigned long flags;
 
@@ -186,6 +186,7 @@ void reselect_clocksource(void)
 	spin_unlock_irqrestore(&clocksource_lock, flags);
 }
 
+EXPORT_SYMBOL(clocksource_reselect);
 /**
  * sysfs_show_current_clocksources - sysfs interface for current clocksource
  * @dev:	unused
Index: mmmerge/kernel/time/jiffies.c
===================================================================
--- mmmerge.orig/kernel/time/jiffies.c	2006-04-17 15:08:59.000000000 -0700
+++ mmmerge/kernel/time/jiffies.c	2006-04-17 15:08:59.000000000 -0700
@@ -67,7 +67,7 @@ struct clocksource clocksource_jiffies =
 
 static int __init init_jiffies_clocksource(void)
 {
-	return register_clocksource(&clocksource_jiffies);
+	return clocksource_register(&clocksource_jiffies);
 }
 
 module_init(init_jiffies_clocksource);
Index: mmmerge/arch/i386/kernel/tsc.c
===================================================================
--- mmmerge.orig/arch/i386/kernel/tsc.c	2006-04-17 15:08:59.000000000 -0700
+++ mmmerge/arch/i386/kernel/tsc.c	2006-04-17 15:08:59.000000000 -0700
@@ -351,7 +351,7 @@ static int tsc_update_callback(void)
 	/* check to see if we should switch to the safe clocksource: */
 	if (clocksource_tsc.rating != 50 && check_tsc_unstable()) {
 		clocksource_tsc.rating = 50;
-		reselect_clocksource();
+		clocksource_reselect();
 		change = 1;
 	}
 
@@ -469,7 +469,7 @@ static int __init init_tsc_clocksource(v
 			jiffies + msecs_to_jiffies(TSC_FREQ_CHECK_INTERVAL);
 		add_timer(&verfiy_tsc_freq_timer);
 
-		return register_clocksource(&clocksource_tsc);
+		return clocksource_register(&clocksource_tsc);
 	}
 
 	return 0;
Index: mmmerge/arch/i386/kernel/i8253.c
===================================================================
--- mmmerge.orig/arch/i386/kernel/i8253.c	2006-04-17 15:08:59.000000000 -0700
+++ mmmerge/arch/i386/kernel/i8253.c	2006-04-17 15:08:59.000000000 -0700
@@ -80,6 +80,6 @@ static int __init init_pit_clocksource(v
 		return 0;
 
 	clocksource_pit.mult = clocksource_hz2mult(CLOCK_TICK_RATE, 20);
-	return register_clocksource(&clocksource_pit);
+	return clocksource_register(&clocksource_pit);
 }
 module_init(init_pit_clocksource);
Index: mmmerge/drivers/clocksource/acpi_pm.c
===================================================================
--- mmmerge.orig/drivers/clocksource/acpi_pm.c	2006-04-17 15:08:59.000000000 -0700
+++ mmmerge/drivers/clocksource/acpi_pm.c	2006-04-17 15:08:59.000000000 -0700
@@ -171,7 +171,7 @@ static int __init init_acpi_pm_clocksour
 	return -ENODEV;
 
 pm_good:
-	return register_clocksource(&clocksource_acpi_pm);
+	return clocksource_register(&clocksource_acpi_pm);
 }
 
 module_init(init_acpi_pm_clocksource);
Index: mmmerge/kernel/timer.c
===================================================================
--- mmmerge.orig/kernel/timer.c	2006-04-17 15:08:59.000000000 -0700
+++ mmmerge/kernel/timer.c	2006-04-17 15:12:37.000000000 -0700
@@ -797,7 +797,7 @@ static inline s64 __get_nsec_offset(void
 	s64 ns_offset;
 
 	/* read clocksource: */
-	cycle_now = read_clocksource(clock);
+	cycle_now = clocksource_read(clock);
 
 	/* calculate the delta since the last update_wall_time: */
 	cycle_delta = (cycle_now - last_clock_cycle) & clock->mask;
@@ -832,7 +832,7 @@ static inline void __get_realtime_clock_
 }
 
 /**
- * get_realtime_clock_ts - Returns the time of day in a timespec
+ * getnstimeofday - Returns the time of day in a timespec
  * @ts:		pointer to the timespec to be set
  *
  * Returns the time of day in a timespec.
@@ -907,9 +907,9 @@ static int change_clocksource(void)
 	struct clocksource *new;
 	cycle_t now;
 	u64 nsec;
-	new = get_next_clocksource();
+	new = clocksource_get_next();
 	if (clock != new) {
-		now = read_clocksource(new);
+		now = clocksource_read(new);
 		nsec =  __get_nsec_offset();
 		timespec_add_ns(&xtime, nsec);
 
@@ -953,9 +953,9 @@ void __init timekeeping_init(void)
 	unsigned long flags;
 
 	write_seqlock_irqsave(&xtime_lock, flags);
-	clock = get_next_clocksource();
-	calculate_clocksource_interval(clock, tick_nsec);
-	last_clock_cycle = read_clocksource(clock);
+	clock = clocksource_get_next();
+	clocksource_calculate_interval(clock, tick_nsec);
+	last_clock_cycle = clocksource_read(clock);
 	ntp_clear();
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 }
@@ -975,7 +975,7 @@ static int timekeeping_resume(struct sys
 
 	write_seqlock_irqsave(&xtime_lock, flags);
 	/* restart the last cycle value */
-	last_clock_cycle = read_clocksource(clock);
+	last_clock_cycle = clocksource_read(clock);
 	write_sequnlock_irqrestore(&xtime_lock, flags);
 	return 0;
 }
@@ -1015,7 +1015,7 @@ static void update_wall_time(void)
 	snsecs_per_sec = (s64)NSEC_PER_SEC << clock->shift;
 	remainder_snsecs += (s64)xtime.tv_nsec << clock->shift;
 
-	now = read_clocksource(clock);
+	now = clocksource_read(clock);
 	offset = (now - last_clock_cycle)&clock->mask;
 
 	/* normally this loop will run just once, however in the
@@ -1056,7 +1056,7 @@ static void update_wall_time(void)
 	if (change_clocksource()) {
 		error = 0;
 		remainder_snsecs = 0;
-		calculate_clocksource_interval(clock, tick_nsec);
+		clocksource_calculate_interval(clock, tick_nsec);
 	}
 }
 
Index: mmmerge/arch/i386/kernel/hpet.c
===================================================================
--- mmmerge.orig/arch/i386/kernel/hpet.c	2006-04-17 15:08:59.000000000 -0700
+++ mmmerge/arch/i386/kernel/hpet.c	2006-04-17 15:08:59.000000000 -0700
@@ -61,7 +61,7 @@ static int __init init_hpet_clocksource(
 	do_div(tmp, FSEC_PER_NSEC);
 	clocksource_hpet.mult = (u32)tmp;
 
-	return register_clocksource(&clocksource_hpet);
+	return clocksource_register(&clocksource_hpet);
 }
 
 module_init(init_hpet_clocksource);
Index: mmmerge/drivers/clocksource/cyclone.c
===================================================================
--- mmmerge.orig/drivers/clocksource/cyclone.c	2006-04-17 15:08:59.000000000 -0700
+++ mmmerge/drivers/clocksource/cyclone.c	2006-04-17 15:08:59.000000000 -0700
@@ -113,7 +113,7 @@ static int __init init_cyclone_clocksour
 	clocksource_cyclone.mult = clocksource_hz2mult(CYCLONE_TIMER_FREQ,
 						clocksource_cyclone.shift);
 
-	return register_clocksource(&clocksource_cyclone);
+	return clocksource_register(&clocksource_cyclone);
 }
 
 module_init(init_cyclone_clocksource);


