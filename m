Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932290AbWCRAkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbWCRAkh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 19:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932803AbWCRAkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 19:40:37 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:56270 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932290AbWCRAkM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 19:40:12 -0500
Date: Fri, 17 Mar 2006 17:40:09 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: john stultz <johnstul@us.ibm.com>, george@wildturkeyranch.net,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>
Message-Id: <20060318004008.32251.14013.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060318003955.32251.80532.sendpatchset@cog.beaverton.ibm.com>
References: <20060318003955.32251.80532.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 2/10] Time: Use clocksource infrastructure for update_wall_time
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch modifies the update_wall_time function so it 
increments time using the clocksource abstraction instead of jiffies. 
Since the only clocksource driver currently provided is the jiffies 
clocksource, this should result in no functional change. Additionally, 
a timekeeping_init and timekeeping_resume function has been added to 
initialize and maintain some of the new timekeping state.

Signed-off-by John Stultz <johnstul@us.ibm.com>

 include/linux/time.h |    2 +
 init/main.c          |    1 
 kernel/Makefile      |    1 
 kernel/timer.c       |   89 +++++++++++++++++++++++++++++++++++++++++++--------
 4 files changed, 80 insertions(+), 13 deletions(-)

linux-2.6.16-rc6_timeofday-core1_C0.patch
============================================
diff --git a/include/linux/time.h b/include/linux/time.h
index d9cdba5..84cfa7b 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -83,6 +83,8 @@ extern struct timespec xtime;
 extern struct timespec wall_to_monotonic;
 extern seqlock_t xtime_lock;
 
+void timekeeping_init(void);
+
 static inline unsigned long get_seconds(void)
 {
 	return xtime.tv_sec;
diff --git a/init/main.c b/init/main.c
index 4c194c4..b26d42d 100644
--- a/init/main.c
+++ b/init/main.c
@@ -486,6 +486,7 @@ asmlinkage void __init start_kernel(void
 	hrtimers_init();
 	softirq_init();
 	time_init();
+	timekeeping_init();
 
 	/*
 	 * HACK ALERT! This is early. We're enabling the console before
diff --git a/kernel/Makefile b/kernel/Makefile
index 4ae0fbd..219bbad 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -10,6 +10,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
 	    hrtimer.o
 
+obj-y += time/
 obj-$(CONFIG_DEBUG_MUTEXES) += mutex-debug.o
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
diff --git a/kernel/timer.c b/kernel/timer.c
index 2410c18..0725e40 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -803,24 +803,89 @@ u64 current_tick_length(void)
 	return ((u64) delta_nsec << (SHIFT_SCALE - 10)) + time_adj;
 }
 
+/* XXX - all of this timekeeping code should be later moved to time.c */
+#include <linux/clocksource.h>
+static struct clocksource *clock; /* pointer to current clocksource */
+static cycle_t last_clock_cycle;  /* cycle value at last update_wall_time */
 /*
- * Using a loop looks inefficient, but "ticks" is
- * usually just one (we shouldn't be losing ticks,
- * we're doing this this way mainly for interrupt
- * latency reasons, not because we think we'll
- * have lots of lost timer ticks
+ * timekeeping_init - Initializes the clocksource and common timekeeping values
  */
-static void update_wall_time(unsigned long ticks)
+void timekeeping_init(void)
 {
-	do {
-		ticks--;
+	unsigned long flags;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	clock = get_next_clocksource();
+	calculate_clocksource_interval(clock, tick_nsec);
+	last_clock_cycle = read_clocksource(clock);
+	ntp_clear();
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+}
+
+
+/*
+ * timekeeping_resume - Resumes the generic timekeeping subsystem.
+ * @dev:	unused
+ *
+ * This is for the generic clocksource timekeeping.
+ * xtime/wall_to_monotonic/jiffies/wall_jiffies/etc are
+ * still managed by arch specific suspend/resume code.
+ */
+static int timekeeping_resume(struct sys_device *dev)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	/* restart the last cycle value */
+	last_clock_cycle = read_clocksource(clock);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+	return 0;
+}
+
+/* sysfs resume/suspend bits for timekeeping */
+static struct sysdev_class timekeeping_sysclass = {
+	.resume		= timekeeping_resume,
+	set_kset_name("timekeeping"),
+};
+
+static struct sys_device device_timer = {
+	.id		= 0,
+	.cls		= &timekeeping_sysclass,
+};
+
+static int timekeeping_init_device(void)
+{
+	int error = sysdev_class_register(&timekeeping_sysclass);
+	if (!error)
+		error = sysdev_register(&device_timer);
+	return error;
+}
+
+device_initcall(timekeeping_init_device);
+
+/*
+ * update_wall_time - Uses the current clocksource to increment the wall time
+ *
+ * Called from the timer interrupt, must hold the xtime_lock.
+ */
+static void update_wall_time(void)
+{
+	cycle_t now, offset;
+
+	now = read_clocksource(clock);
+	offset = (now - last_clock_cycle)&clock->mask;
+
+	/* normally this loop will run just once, however in the
+	 * case of lost or late ticks, it will accumulate correctly.
+	 */
+	while (offset > clock->interval_cycles) {
 		update_wall_time_one_tick();
 		if (xtime.tv_nsec >= 1000000000) {
 			xtime.tv_nsec -= 1000000000;
 			xtime.tv_sec++;
 			second_overflow();
 		}
-	} while (ticks);
+	}
 }
 
 /*
@@ -925,10 +990,8 @@ static inline void update_times(void)
 	unsigned long ticks;
 
 	ticks = jiffies - wall_jiffies;
-	if (ticks) {
-		wall_jiffies += ticks;
-		update_wall_time(ticks);
-	}
+	wall_jiffies += ticks;
+	update_wall_time();
 	calc_load(ticks);
 }
   
