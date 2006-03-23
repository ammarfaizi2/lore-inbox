Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWCWDGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWCWDGa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 22:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWCWDGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 22:06:30 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:56031 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932129AbWCWDGX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 22:06:23 -0500
Date: Wed, 22 Mar 2006 20:06:20 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       george@wildturkeyranch.net, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mackerras <paulus@samba.org>
Message-Id: <20060323030619.19338.49583.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
References: <20060323030547.19338.95102.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 5/10] Time: Introduce arch generic time accessors
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Introduces clocksource switching code and the arch generic time 
accessor functions that use the clocksource infrastructure.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 include/linux/time.h |   15 ++++
 kernel/time.c        |    2 
 kernel/timer.c       |  170 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 187 insertions(+)

linux-2.6.16_timeofday-core4_C1.patch
============================================
diff --git a/include/linux/time.h b/include/linux/time.h
index 84cfa7b..fc06884 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -107,6 +107,7 @@ extern int do_getitimer(int which, struc
 extern void getnstimeofday(struct timespec *tv);
 
 extern struct timespec timespec_trunc(struct timespec t, unsigned gran);
+extern int timekeeping_is_continuous(void);
 
 /**
  * timespec_to_ns - Convert timespec to nanoseconds
@@ -149,6 +150,20 @@ extern struct timespec ns_to_timespec(co
  */
 extern struct timeval ns_to_timeval(const nsec_t nsec);
 
+/**
+ * timespec_add_ns - Adds nanoseconds to a timespec
+ * @a:		pointer to timespec to be incremented
+ * @ns:		unsigned nanoseconds value to be added
+ */
+static inline void timespec_add_ns(struct timespec *a, u64 ns)
+{
+	ns += a->tv_nsec;
+	while(unlikely(ns >= NSEC_PER_SEC)) {
+		ns -= NSEC_PER_SEC;
+		a->tv_sec++;
+	}
+	a->tv_nsec = ns;
+}
 #endif /* __KERNEL__ */
 
 #define NFDBITS			__NFDBITS
diff --git a/kernel/time.c b/kernel/time.c
index 8045391..526fbdb 100644
--- a/kernel/time.c
+++ b/kernel/time.c
@@ -550,6 +550,7 @@ EXPORT_SYMBOL(do_gettimeofday);
 
 
 #else
+#ifndef CONFIG_GENERIC_TIME
 /*
  * Simulate gettimeofday using do_gettimeofday which only allows a timeval
  * and therefore only yields usec accuracy
@@ -564,6 +565,7 @@ void getnstimeofday(struct timespec *tv)
 }
 EXPORT_SYMBOL_GPL(getnstimeofday);
 #endif
+#endif
 
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
diff --git a/kernel/timer.c b/kernel/timer.c
index 339d52f..0c1e184 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -806,6 +806,169 @@ u64 current_tick_length(long shift)
 #include <linux/clocksource.h>
 static struct clocksource *clock; /* pointer to current clocksource */
 static cycle_t last_clock_cycle;  /* cycle value at last update_wall_time */
+
+#ifdef CONFIG_GENERIC_TIME
+/**
+ * __get_nsec_offset - Returns nanoseconds since last call to periodic_hook
+ *
+ * private function, must hold xtime_lock lock when being
+ * called. Returns the number of nanoseconds since the
+ * last call to update_wall_time() (adjusted by NTP scaling)
+ */
+static inline s64 __get_nsec_offset(void)
+{
+	cycle_t cycle_now, cycle_delta;
+	s64 ns_offset;
+
+	/* read clocksource: */
+	cycle_now = read_clocksource(clock);
+
+	/* calculate the delta since the last update_wall_time: */
+	cycle_delta = (cycle_now - last_clock_cycle) & clock->mask;
+
+	/* convert to nanoseconds: */
+	ns_offset = cyc2ns(clock, cycle_delta);
+
+	return ns_offset;
+}
+
+/**
+ * __get_realtime_clock_ts - Returns the time of day in a timespec
+ * @ts:		pointer to the timespec to be set
+ *
+ * Returns the time of day in a timespec. Used by
+ * do_gettimeofday() and get_realtime_clock_ts().
+ */
+static inline void __get_realtime_clock_ts(struct timespec *ts)
+{
+	unsigned long seq;
+	s64 nsecs;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+
+		*ts = xtime;
+		nsecs = __get_nsec_offset();
+
+	} while (read_seqretry(&xtime_lock, seq));
+
+	timespec_add_ns(ts, nsecs);
+}
+
+/**
+ * get_realtime_clock_ts - Returns the time of day in a timespec
+ * @ts:		pointer to the timespec to be set
+ *
+ * Returns the time of day in a timespec.
+ */
+void getnstimeofday(struct timespec *ts)
+{
+	__get_realtime_clock_ts(ts);
+}
+
+EXPORT_SYMBOL(getnstimeofday);
+
+/**
+ * do_gettimeofday - Returns the time of day in a timeval
+ * @tv:		pointer to the timeval to be set
+ *
+ * NOTE: Users should be converted to using get_realtime_clock_ts()
+ */
+void do_gettimeofday(struct timeval *tv)
+{
+	struct timespec now;
+
+	__get_realtime_clock_ts(&now);
+	tv->tv_sec = now.tv_sec;
+	tv->tv_usec = now.tv_nsec/1000;
+}
+
+EXPORT_SYMBOL(do_gettimeofday);
+/**
+ * do_settimeofday - Sets the time of day
+ * @tv:		pointer to the timespec variable containing the new time
+ *
+ * Sets the time of day to the new time and update NTP and notify hrtimers
+ */
+int do_settimeofday(struct timespec *tv)
+{
+	unsigned long flags;
+	time_t wtm_sec, sec = tv->tv_sec;
+	long wtm_nsec, nsec = tv->tv_nsec;
+
+	if ((unsigned long)tv->tv_nsec >= NSEC_PER_SEC)
+		return -EINVAL;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+
+	nsec -= __get_nsec_offset();
+
+	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
+	wtm_nsec = wall_to_monotonic.tv_nsec + (xtime.tv_nsec - nsec);
+
+	set_normalized_timespec(&xtime, sec, nsec);
+	set_normalized_timespec(&wall_to_monotonic, wtm_sec, wtm_nsec);
+
+	ntp_clear();
+
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	/* signal hrtimers about time change */
+	clock_was_set();
+
+	return 0;
+}
+
+EXPORT_SYMBOL(do_settimeofday);
+
+/**
+ * change_clocksource - Swaps clocksources if a new one is available
+ *
+ * Accumulates current time interval and initializes new clocksource
+ */
+static int change_clocksource(void)
+{
+	struct clocksource *new;
+	cycle_t now;
+	u64 nsec;
+	new = get_next_clocksource();
+	if (clock != new) {
+		now = read_clocksource(new);
+		nsec =  __get_nsec_offset();
+		timespec_add_ns(&xtime, nsec);
+
+		clock = new;
+		last_clock_cycle = now;
+		printk(KERN_INFO "Time: %s clocksource has been installed.\n",
+					clock->name);
+		return 1;
+	} else if (clock->update_callback) {
+		return clock->update_callback();
+	}
+	return 0;
+}
+#else
+#define change_clocksource() (0)
+#endif
+
+/**
+ * timeofday_is_continuous - check to see if timekeeping is free running
+ */
+int timekeeping_is_continuous(void)
+{
+	unsigned long seq;
+	int ret;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+
+		ret = clock->is_continuous;
+
+	} while (read_seqretry(&xtime_lock, seq));
+
+	return ret;
+}
+
 /*
  * timekeeping_init - Initializes the clocksource and common timekeeping values
  */
@@ -912,6 +1075,13 @@ static void update_wall_time(void)
 	/* store full nanoseconds into xtime */
 	xtime.tv_nsec = remainder_snsecs >> clock->shift;
 	remainder_snsecs -= (s64)xtime.tv_nsec << clock->shift;
+
+	/* check to see if there is a new clocksource to use */
+	if (change_clocksource()) {
+		error = 0;
+		remainder_snsecs = 0;
+		calculate_clocksource_interval(clock, tick_nsec);
+	}
 }
 
 /*
