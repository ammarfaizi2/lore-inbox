Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbVKAW1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbVKAW1u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 17:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVKAW1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 17:27:50 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:59791 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751352AbVKAW1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 17:27:49 -0500
Subject: [RFC][PATCH 4/12] generic timeofday core subsystem
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1130884000.27168.462.camel@cog.beaverton.ibm.com>
References: <1130883795.27168.457.camel@cog.beaverton.ibm.com>
	 <1130883849.27168.458.camel@cog.beaverton.ibm.com>
	 <1130883935.27168.461.camel@cog.beaverton.ibm.com>
	 <1130884000.27168.462.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 14:27:44 -0800
Message-Id: <1130884065.27168.464.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

This patch implements my generic timeofday framework. This common
infrastructure is intended to be used by any arch to reduce code
duplication. Hopefully it will allow generic bugs to be fixed once. And
with many architectures sharing the same time source, this allows
drivers to be written once for multiple architectures. 

One major change with this code is that it delineate the lines between
the soft-timer subsystem and the time-of-day subsystem, allowing for a
1:1 mapping between a hardware clocksource counter and the time of day.
This allows for lost ticks or other software delays to not affect
timekeeping.

Included below is timeofday.c (which includes all the time of day
management and accessor functions), and minimal hooks into arch
independent code. This patch does not remove the current timekeeping
code, allowing architectures to move over when they are ready. 

This patch applies on top of my clocksource management patch.

The patch does nothing without at least minimal architecture specific
hooks (i386, x86-64 and other architecture examples to follow), and it
should be able to be applied to a tree without affecting the existing
code.

thanks
-john


 drivers/char/hangcheck-timer.c  |    5 
 include/asm-generic/timeofday.h |   29 +
 include/linux/time.h            |   27 +
 include/linux/timeofday.h       |   44 ++
 include/linux/timex.h           |    2 
 init/main.c                     |    2 
 kernel/ktimers.c                |    1 
 kernel/posix-timers.c           |    2 
 kernel/time.c                   |   17 +
 kernel/time/Makefile            |    2 
 kernel/time/timeofday.c         |  680 ++++++++++++++++++++++++++++++++++++++++
 kernel/timer.c                  |    6 
 12 files changed, 811 insertions(+), 6 deletions(-)

linux-2.6.14-rc5-mm1_timeofday-core_B9.patch
============================================
diff -ruN corefix1/drivers/char/hangcheck-timer.c corefix2/drivers/char/hangcheck-timer.c
--- corefix1/drivers/char/hangcheck-timer.c	2005-10-31 18:49:50.000000000 -0800
+++ corefix2/drivers/char/hangcheck-timer.c	2005-10-31 18:50:44.000000000 -0800
@@ -49,6 +49,7 @@
 #include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <linux/sysrq.h>
+#include <linux/timeofday.h>
 
 
 #define VERSION_STR "0.9.0"
@@ -130,8 +131,12 @@
 #endif
 
 #ifdef HAVE_MONOTONIC
+#ifndef CONFIG_GENERIC_TIME
 extern unsigned long long monotonic_clock(void);
 #else
+#define monotonic_clock() ktime_to_ns(get_monotonic_clock())
+#endif
+#else
 static inline unsigned long long monotonic_clock(void)
 {
 # ifdef __s390__
diff -ruN corefix1/include/asm-generic/timeofday.h corefix2/include/asm-generic/timeofday.h
--- corefix1/include/asm-generic/timeofday.h	1969-12-31 16:00:00.000000000 -0800
+++ corefix2/include/asm-generic/timeofday.h	2005-10-31 18:50:44.000000000 -0800
@@ -0,0 +1,29 @@
+/*  linux/include/asm-generic/timeofday.h
+ *
+ *  This file contains the asm-generic interface
+ *  to the arch specific calls used by the time of day subsystem
+ */
+#ifndef _ASM_GENERIC_TIMEOFDAY_H
+#define _ASM_GENERIC_TIMEOFDAY_H
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <linux/timeofday.h>
+#include <linux/clocksource.h>
+
+#include <asm/div64.h>
+#ifdef CONFIG_GENERIC_TIME
+/* Required externs */
+extern nsec_t read_persistent_clock(void);
+extern void sync_persistent_clock(struct timespec ts);
+
+#ifdef CONFIG_GENERIC_TIME_VSYSCALL
+extern void arch_update_vsyscall_gtod(struct timespec wall_time,
+				cycle_t offset_base, struct clocksource* clock,
+				int ntp_adj);
+#else
+#define arch_update_vsyscall_gtod(x,y,z,w) {}
+#endif /* CONFIG_GENERIC_TIME_VSYSCALL */
+
+#endif /* CONFIG_GENERIC_TIME */
+#endif
diff -ruN corefix1/include/linux/time.h corefix2/include/linux/time.h
--- corefix1/include/linux/time.h	2005-10-31 18:49:52.000000000 -0800
+++ corefix2/include/linux/time.h	2005-10-31 18:50:44.000000000 -0800
@@ -28,6 +28,10 @@
 
 #ifdef __KERNEL__
 
+/* timeofday base types */
+typedef s64 nsec_t;
+typedef u64 cycle_t;
+
 /* Parameters used to convert the timespec values */
 #define MSEC_PER_SEC (1000L)
 #define USEC_PER_SEC (1000000L)
@@ -42,8 +46,6 @@
 #define timespec_valid(ts) \
 (((ts)->tv_sec >= 0) && (((unsigned) (ts)->tv_nsec) < NSEC_PER_SEC))
 
-typedef s64 nsec_t;
-
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
  * => year=1980, mon=12, day=31, hour=23, min=59, sec=59.
@@ -99,7 +101,6 @@
 struct itimerval;
 extern int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue);
 extern int do_getitimer(int which, struct itimerval *value);
-extern void getnstimeofday (struct timespec *tv);
 
 extern struct timespec timespec_trunc(struct timespec t, unsigned gran);
 
@@ -183,6 +184,26 @@
 	return tv;
 }
 
+static inline void normalize_timespec(struct timespec *ts)
+{
+	while ((unsigned long)ts->tv_nsec > NSEC_PER_SEC) {
+		ts->tv_nsec -= NSEC_PER_SEC;
+		ts->tv_sec++;
+	}
+}
+
+static inline struct timespec timespec_add_ns(struct timespec a, nsec_t ns)
+{
+	while(ns > NSEC_PER_SEC) {
+		ns -= NSEC_PER_SEC;
+		a.tv_sec++;
+	}
+	a.tv_nsec += ns;
+	normalize_timespec(&a);
+
+	return a;
+}
+
 #endif /* __KERNEL__ */
 
 #define NFDBITS			__NFDBITS
diff -ruN corefix1/include/linux/timeofday.h corefix2/include/linux/timeofday.h
--- corefix1/include/linux/timeofday.h	1969-12-31 16:00:00.000000000 -0800
+++ corefix2/include/linux/timeofday.h	2005-10-31 18:50:44.000000000 -0800
@@ -0,0 +1,44 @@
+/*  linux/include/linux/timeofday.h
+ *
+ *  This file contains the interface to the time of day subsystem
+ */
+#ifndef _LINUX_TIMEOFDAY_H
+#define _LINUX_TIMEOFDAY_H
+#include <linux/calc64.h>
+#include <linux/types.h>
+#include <linux/ktime.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+
+#ifdef CONFIG_GENERIC_TIME
+
+/* Kernel internal interfaces */
+extern ktime_t get_monotonic_clock(void);
+extern ktime_t get_realtime_clock(void);
+extern ktime_t get_realtime_offset(void);
+
+/* Timepsec based interfaces for user space functionality */
+extern void get_realtime_clock_ts(struct timespec *ts);
+extern void get_monotonic_clock_ts(struct timespec *ts);
+
+/* legacy timeofday interfaces*/
+#define getnstimeofday(ts) get_realtime_clock_ts(ts)
+extern void getnstimeofday(struct timespec *ts);
+extern void do_gettimeofday(struct timeval *tv);
+extern int do_settimeofday(struct timespec *ts);
+
+/* Internal functions */
+extern int timeofday_is_continuous(void);
+extern void timeofday_init(void);
+
+#ifndef CONFIG_IS_TICK_BASED
+#define arch_getoffset() (0)
+#else
+extern unsigned long arch_getoffset(void);
+#endif
+
+#else /* CONFIG_GENERIC_TIME */
+#define timeofday_init()
+extern void getnstimeofday(struct timespec *ts);
+#endif /* CONFIG_GENERIC_TIME */
+#endif /* _LINUX_TIMEOFDAY_H */
diff -ruN corefix1/include/linux/timex.h corefix2/include/linux/timex.h
--- corefix1/include/linux/timex.h	2005-10-31 18:50:11.000000000 -0800
+++ corefix2/include/linux/timex.h	2005-10-31 18:50:44.000000000 -0800
@@ -313,6 +313,7 @@
 	__x < 0 ? -(-__x >> __s) : __x >> __s;	\
 })
 
+#ifndef CONFIG_GENERIC_TIME
 
 #ifdef CONFIG_TIME_INTERPOLATION
 
@@ -368,6 +369,7 @@
 }
 
 #endif /* !CONFIG_TIME_INTERPOLATION */
+#endif /* !CONFIG_GENERIC_TIME */
 
 #endif /* KERNEL */
 
diff -ruN corefix1/init/main.c corefix2/init/main.c
--- corefix1/init/main.c	2005-10-31 18:49:52.000000000 -0800
+++ corefix2/init/main.c	2005-10-31 18:50:44.000000000 -0800
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/timeofday.h>
 #include <net/sock.h>
 
 #include <asm/io.h>
@@ -478,6 +479,7 @@
 	init_timers();
 	ktimers_init();
 	softirq_init();
+	timeofday_init();
 	time_init();
 
 	/*
diff -ruN corefix1/kernel/ktimers.c corefix2/kernel/ktimers.c
--- corefix1/kernel/ktimers.c	2005-10-31 18:49:52.000000000 -0800
+++ corefix2/kernel/ktimers.c	2005-10-31 18:50:44.000000000 -0800
@@ -30,6 +30,7 @@
 #include <linux/percpu.h>
 #include <linux/notifier.h>
 #include <linux/syscalls.h>
+#include <linux/timeofday.h>
 #include <linux/interrupt.h>
 
 #include <asm/uaccess.h>
diff -ruN corefix1/kernel/posix-timers.c corefix2/kernel/posix-timers.c
--- corefix1/kernel/posix-timers.c	2005-10-31 18:49:52.000000000 -0800
+++ corefix2/kernel/posix-timers.c	2005-10-31 18:50:44.000000000 -0800
@@ -34,7 +34,7 @@
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
-#include <linux/time.h>
+#include <linux/timeofday.h>
 
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
diff -ruN corefix1/kernel/time/Makefile corefix2/kernel/time/Makefile
--- corefix1/kernel/time/Makefile	2005-10-31 18:50:17.000000000 -0800
+++ corefix2/kernel/time/Makefile	2005-10-31 18:50:44.000000000 -0800
@@ -1 +1 @@
-obj-y += clocksource.o jiffies.o
+obj-y += clocksource.o jiffies.o timeofday.o
diff -ruN corefix1/kernel/time/timeofday.c corefix2/kernel/time/timeofday.c
--- corefix1/kernel/time/timeofday.c	1969-12-31 16:00:00.000000000 -0800
+++ corefix2/kernel/time/timeofday.c	2005-10-31 18:51:46.000000000 -0800
@@ -0,0 +1,680 @@
+/*
+ * linux/kernel/time/timeofday.c
+ *
+ * This file contains the functions which access and manage
+ * the system's time of day functionality.
+ *
+ * Copyright (C) 2003, 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * TODO WishList:
+ *   o See XXX's below.
+ */
+
+#include <linux/timeofday.h>
+#include <linux/clocksource.h>
+#include <linux/ktime.h>
+#include <linux/timex.h>
+#include <linux/timer.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/sysdev.h>
+#include <linux/jiffies.h>
+#include <asm/timeofday.h>
+
+/* Periodic hook interval */
+#define PERIODIC_INTERVAL_MS 50
+
+/* [ktime_t based variables]
+ * system_time:
+ *	Monotonically increasing counter of the number of nanoseconds
+ *	since boot.
+ * wall_time_offset:
+ *	Offset added to system_time to provide accurate time-of-day
+ */
+static ktime_t system_time;
+static ktime_t wall_time_offset;
+
+/* [timespec based variables]
+ * These variables mirror teh ktime_t based variables to avoid
+ * performance issues in the userspace syscall paths.
+ *
+ * wall_time_ts:
+ * 	timespec holding the current wall time.
+ * mono_time_ts:
+ * 	timespec holding the current monotonic time.
+ * monotonic_time_offset_ts:
+ * 	timespec holding the difference between wall and monotonic time.
+ */
+static struct timespec wall_time_ts;
+static struct timespec mono_time_ts;
+static struct timespec monotonic_time_offset_ts;
+
+/* [cycle based variables]
+ * cycle_last:
+ *	Value of the clocksource at the last timeofday_periodic_hook()
+ *	(adjusted only minorly to account for rounded off cycles)
+ */
+static cycle_t cycle_last;
+
+/* [clocksource_interval variables]
+ * ts_interval:
+ *	This clocksource_interval is used in the fixed interval
+ *	cycles to nanosecond calculation.
+ * INTERVAL_LEN:
+ *	This constant is the requested fixed interval period
+ *	in nanoseconds.
+ */
+struct clocksource_interval ts_interval;
+#define INTERVAL_LEN ((PERIODIC_INTERVAL_MS-1)*1000000)
+
+/* [clocksource data]
+ * clock:
+ *	current clocksource pointer
+ */
+static struct clocksource *clock;
+
+/* [NTP adjustment]
+ * ntp_adj:
+ * 	value of the current ntp adjustment, stored in
+ *	clocksource multiplier units.
+ */
+int ntp_adj;
+
+/* [locks]
+ * system_time_lock:
+ *	generic lock for all locally scoped time values
+ */
+static seqlock_t system_time_lock = SEQLOCK_UNLOCKED;
+
+
+/* [suspend/resume info]
+ * time_suspend_state:
+ *	variable that keeps track of suspend state
+ * suspend_start:
+ *	start of the suspend call
+ */
+static enum {
+	TIME_RUNNING,
+	TIME_SUSPENDED
+} time_suspend_state = TIME_RUNNING;
+
+static nsec_t suspend_start;
+
+/* [Soft-Timers]
+ * timeofday_timer:
+ *	soft-timer used to call timeofday_periodic_hook()
+ */
+struct timer_list timeofday_timer;
+
+/**
+ * update_legacy_time_values - sync legacy time values
+ *
+ * This function is necessary for a smooth transition to the
+ * new timekeeping code. When all the xtime/wall_to_monotonic
+ * users are converted this function can be removed.
+ *
+ * system_time_lock must be held by the caller
+ */
+static void update_legacy_time_values(void)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+
+	xtime = wall_time_ts;
+	set_normalized_timespec(&wall_to_monotonic,
+		-monotonic_time_offset_ts.tv_sec,
+		-monotonic_time_offset_ts.tv_nsec);
+
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	/* since time state has changed, notify vsyscall code */
+	arch_update_vsyscall_gtod(wall_time_ts, cycle_last, clock, ntp_adj);
+}
+
+/**
+ * __get_nsec_offset - Returns nanoseconds since last call to periodic_hook
+ *
+ * private function, must hold system_time_lock lock when being
+ * called. Returns the number of nanoseconds since the
+ * last call to timeofday_periodic_hook() (adjusted by NTP scaling)
+ */
+static inline nsec_t __get_nsec_offset(void)
+{
+	cycle_t cycle_now, cycle_delta;
+	nsec_t ns_offset;
+
+	/* read clocksource */
+	cycle_now = read_clocksource(clock);
+
+	/* calculate the delta since the last timeofday_periodic_hook */
+	cycle_delta = (cycle_now - cycle_last) & clock->mask;
+
+	/* convert to nanoseconds */
+	ns_offset = cyc2ns(clock, ntp_adj, cycle_delta);
+
+	/* Special case for jiffies tick/offset based systems
+	 * add arch specific offset
+	 */
+	ns_offset += arch_getoffset();
+
+	return ns_offset;
+}
+
+/**
+ * __get_monotonic_clock - Returns monotonically increasing nanoseconds
+ *
+ * private function, must hold system_time_lock lock when being
+ * called. Returns the monotonically increasing number of
+ * nanoseconds since the system booted (adjusted by NTP scaling)
+ */
+static inline ktime_t __get_monotonic_clock(void)
+{
+	nsec_t offset = __get_nsec_offset();
+	return ktime_add_ns(system_time, offset);
+}
+
+/**
+ * get_monotonic_clock - Returns monotonic time in ktime_t format
+ *
+ * Returns the monotonically increasing number of nanoseconds
+ * since the system booted via __monotonic_clock()
+ */
+ktime_t get_monotonic_clock(void)
+{
+	unsigned long seq;
+	ktime_t ret;
+
+	/* atomically read __get_monotonic_clock() */
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		ret = __get_monotonic_clock();
+
+	} while (read_seqretry(&system_time_lock, seq));
+
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(get_monotonic_clock);
+
+/**
+ * get_realtime_clock - Returns the timeofday in ktime_t format
+ *
+ * Returns the wall time in ktime_t format. The resolution
+ * is nanoseconds
+ */
+ktime_t get_realtime_clock(void)
+{
+	unsigned long seq;
+	ktime_t ret;
+
+	/* atomically read __get_monotonic_clock() */
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		ret = __get_monotonic_clock();
+		ret = ktime_add(ret, wall_time_offset);
+
+	} while (read_seqretry(&system_time_lock, seq));
+
+	return ret;
+}
+
+/**
+ * get_realtime_offset - Returns the offset of realtime clock
+ *
+ * Returns the number of nanoseconds in ktime_t storage format which
+ * represents the offset of the realtime clock to the the monotonic clock
+ */
+ktime_t get_realtime_offset(void)
+{
+	unsigned long seq;
+	ktime_t ret;
+
+	/* atomically read wall_time_offset */
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		ret = wall_time_offset;
+
+	} while (read_seqretry(&system_time_lock, seq));
+
+	return ret;
+}
+
+/**
+ * get_monotonic_clock_ts - Returns monotonic time in timespec format
+ *
+ * @ts:		pointer to the timespec to be set
+ *
+ * Returns a timespec of nanoseconds since the system booted and
+ * store the result in the timespec variable pointed to by @ts
+ */
+void get_monotonic_clock_ts(struct timespec *ts)
+{
+	unsigned long seq;
+	struct timespec mono_ts;
+	nsec_t offset;
+
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		mono_ts = mono_time_ts;
+		offset = __get_nsec_offset();
+	} while (read_seqretry(&system_time_lock, seq));
+
+	*ts = timespec_add_ns(mono_ts, offset);
+}
+
+/**
+ * __get_realtime_clock_ts - Returns the time of day in a timespec
+ *
+ * @ts:		pointer to the timespec to be set
+ *
+ * Returns the time of day in a timespec. Used by
+ * do_gettimeofday() and get_realtime_clock_ts().
+ *
+ */
+static inline void __get_realtime_clock_ts(struct timespec *ts)
+{
+	struct timespec now_ts;
+	unsigned long seq;
+	nsec_t nsecs;
+
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		now_ts = wall_time_ts;
+		nsecs = __get_nsec_offset();
+
+	} while (read_seqretry(&system_time_lock, seq));
+
+	*ts = timespec_add_ns(now_ts, nsecs);
+}
+
+/**
+ * get_realtime_clock_ts - Returns the time of day in a timespec
+ * @ts:		pointer to the timespec to be set
+ *
+ * Returns the time of day in a timespec.
+ */
+void get_realtime_clock_ts(struct timespec *ts)
+{
+	__get_realtime_clock_ts(ts);
+}
+
+EXPORT_SYMBOL(get_realtime_clock_ts);
+
+
+/**
+ * do_gettimeofday - Returns the time of day in a timeval
+ * @tv:		pointer to the timeval to be set
+ *
+ * NOTE: Users should be converted to using get_realtime_clock_ts()
+ */
+void do_gettimeofday(struct timeval *tv)
+{
+	struct timespec now_ts;
+	__get_realtime_clock_ts(&now_ts);
+	tv->tv_sec = now_ts.tv_sec;
+	tv->tv_usec = now_ts.tv_nsec/1000;
+}
+
+EXPORT_SYMBOL(do_gettimeofday);
+
+/**
+ * do_settimeofday - Sets the time of day
+ * @tv:		pointer to the timespec variable containing the new time
+ *
+ * Sets the time of day to the new time and update NTP and notify ktimers
+ */
+int do_settimeofday(struct timespec *tv)
+{
+	unsigned long flags;
+	ktime_t newtime;
+
+	newtime = timespec_to_ktime(*tv);
+
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	/* calculate the new offset from the monotonic clock */
+	wall_time_offset = ktime_sub(newtime, __get_monotonic_clock());
+
+	/* update the internal timespec variables */
+	wall_time_ts = ktime_to_timespec(
+				ktime_add(system_time, wall_time_offset));
+	monotonic_time_offset_ts = ktime_to_timespec(wall_time_offset);
+
+	ntp_clear();
+	update_legacy_time_values();
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+
+	/* signal ktimers about time change */
+	clock_was_set();
+
+	return 0;
+}
+
+EXPORT_SYMBOL(do_settimeofday);
+
+/**
+ * __increment_system_time - Increments system time
+ * @delta:	nanosecond delta to add to the time variables
+ *
+ * Private helper that increments system_time and related
+ * timekeeping variables.
+ */
+static inline void __increment_system_time(nsec_t delta)
+{
+	system_time = ktime_add_ns(system_time, delta);
+	wall_time_ts = timespec_add_ns(wall_time_ts, delta);
+	mono_time_ts = timespec_add_ns(mono_time_ts, delta);
+}
+
+/**
+ * timeofday_suspend_hook - allows the timeofday subsystem to be shutdown
+ * @dev:	unused
+ * @state:	unused
+ *
+ * This function allows the timeofday subsystem to be shutdown for a period
+ * of time. Called when going into suspend/hibernate mode.
+ */
+static int timeofday_suspend_hook(struct sys_device *dev, pm_message_t state)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	BUG_ON(time_suspend_state != TIME_RUNNING);
+
+	/* First off, save suspend start time
+	 * then quickly accumulate the current nsec offset.
+	 * These two calls hopefully occur quickly
+	 * because the difference between reads will
+	 * accumulate as time drift on resume.
+	 */
+	suspend_start = read_persistent_clock();
+	__increment_system_time(__get_nsec_offset());
+
+	time_suspend_state = TIME_SUSPENDED;
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+
+	return 0;
+}
+
+/**
+ * timeofday_resume_hook - Resumes the timeofday subsystem.
+ * @dev:	unused
+ *
+ * This function resumes the timeofday subsystem from a previous call
+ * to timeofday_suspend_hook.
+ */
+static int timeofday_resume_hook(struct sys_device *dev)
+{
+	nsec_t suspend_end, suspend_time;
+	unsigned long flags;
+
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	BUG_ON(time_suspend_state != TIME_SUSPENDED);
+
+	/* Read persistent clock to mark the end of
+	 * the suspend interval then rebase the
+	 * cycle_last to current clocksource value.
+	 * Again, time between these two calls will
+	 * not be accounted for and will show up as
+	 * time drift.
+	 */
+	suspend_end = read_persistent_clock();
+	cycle_last = read_clocksource(clock);
+
+	/* calculate suspend time and add it to system time */
+	suspend_time = suspend_end - suspend_start;
+	__increment_system_time(suspend_time);
+
+	ntp_clear();
+
+	time_suspend_state = TIME_RUNNING;
+
+	update_legacy_time_values();
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+
+	/* inform ktimers about time change */
+	clock_was_set();
+
+	return 0;
+}
+
+/* sysfs resume/suspend bits */
+static struct sysdev_class timeofday_sysclass = {
+	.resume = timeofday_resume_hook,
+	.suspend = timeofday_suspend_hook,
+	set_kset_name("timeofday"),
+};
+
+static struct sys_device device_timer = {
+	.id	= 0,
+	.cls	= &timeofday_sysclass,
+};
+
+static int timeofday_init_device(void)
+{
+	int error = sysdev_class_register(&timeofday_sysclass);
+
+	if (!error)
+		error = sysdev_register(&device_timer);
+
+	return error;
+}
+
+device_initcall(timeofday_init_device);
+
+
+/**
+ * timeofday_periodic_hook - Does periodic update of timekeeping values.
+ * @unused:	unused value
+ *
+ * Calculates the delta since the last call, updates system time and
+ * clears the offset.
+ *
+ * Called via timeofday_timer.
+ */
+static void timeofday_periodic_hook(unsigned long unused)
+{
+	unsigned long flags;
+
+	cycle_t cycle_now, cycle_delta;
+	nsec_t delta_nsec;
+	static u64 remainder;
+
+	long leapsecond;
+	struct clocksource* next;
+
+	int ppm;
+	static int ppm_last;
+
+	int something_changed = 0;
+	struct clocksource old_clock;
+	static nsec_t second_check;
+
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	/* read time source & calc time since last call*/
+	cycle_now = read_clocksource(clock);
+	cycle_delta = (cycle_now - cycle_last) & clock->mask;
+
+	delta_nsec = cyc2ns_fixed_rem(ts_interval, &cycle_delta, &remainder);
+	cycle_last = (cycle_now - cycle_delta)&clock->mask;
+
+	/* update system_time */
+	__increment_system_time(delta_nsec);
+
+	/* advance the ntp state machine by ns interval*/
+	ntp_advance(delta_nsec);
+
+	/* Only call ntp_leapsecond and ntp_sync once a sec */
+	second_check += delta_nsec;
+	if (second_check > NSEC_PER_SEC) {
+		/* do ntp leap second processing*/
+		leapsecond = ntp_leapsecond(wall_time_ts);
+		if (leapsecond) {
+			wall_time_offset = ktime_add_ns(wall_time_offset,
+				 		leapsecond * NSEC_PER_SEC);
+			wall_time_ts.tv_sec += leapsecond;
+			monotonic_time_offset_ts.tv_sec += leapsecond;
+		}
+		/* sync the persistent clock */
+		if (ntp_synced())
+			sync_persistent_clock(wall_time_ts);
+		second_check -= NSEC_PER_SEC;
+	}
+
+	/* if necessary, switch clocksources */
+	next = get_next_clocksource();
+	if (next != clock) {
+		/* immediately set new cycle_last */
+		cycle_last = read_clocksource(next);
+		/* update cycle_now to avoid problems in accumulation later */
+		cycle_now = cycle_last;
+		/* swap clocksources */
+		old_clock = *clock;
+		clock = next;
+		printk(KERN_INFO "Time: %s clocksource has been installed.\n",
+					clock->name);
+		ntp_clear();
+		ntp_adj = 0;
+		remainder = 0;
+		something_changed = 1;
+	}
+
+	/* now is a safe time, so allow clocksource to adjust
+	 * itself (for example: to make cpufreq changes).
+	 */
+	if (clock->update_callback) {
+		/* since clocksource state might change,
+		 * keep a copy, but only if we've not
+		 * already changed timesources
+		 */
+		if (!something_changed)
+			old_clock = *clock;
+		if (clock->update_callback()) {
+			remainder = 0;
+			something_changed = 1;
+		}
+	}
+
+	/* check for new PPM adjustment */
+	ppm = ntp_get_ppm_adjustment();
+	if (ppm_last != ppm) {
+		/* make sure old_clock is set */
+		if (!something_changed)
+			old_clock = *clock;
+		something_changed = 1;
+	}
+
+	/* if something changed, recalculate the ntp adjustment value */
+	if (something_changed) {
+		/* accumulate current leftover cycles using old_clock */
+		if (cycle_delta) {
+			delta_nsec = cyc2ns_rem(&old_clock, ntp_adj,
+						cycle_delta, &remainder);
+			cycle_last = cycle_now;
+			__increment_system_time(delta_nsec);
+			ntp_advance(delta_nsec);
+		}
+
+		/* recalculate the ntp adjustment and fixed interval values */
+		ppm_last = ppm;
+		ntp_adj = ppm_to_mult_adj(clock, ppm);
+		ts_interval = calculate_clocksource_interval(clock, ntp_adj,
+					INTERVAL_LEN);
+	}
+
+	update_legacy_time_values();
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+
+	/* Set us up to go off on the next interval */
+	mod_timer(&timeofday_timer,
+		jiffies + msecs_to_jiffies(PERIODIC_INTERVAL_MS));
+}
+
+/**
+ * timeofday_is_continuous - check to see if timekeeping is free running
+ *
+ */
+int timeofday_is_continuous(void)
+{
+	unsigned long seq;
+	int ret;
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		ret = clock->is_continuous;
+
+	} while (read_seqretry(&system_time_lock, seq));
+
+	return ret;
+}
+
+/**
+ * timeofday_init - Initializes time variables
+ */
+void __init timeofday_init(void)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	/* initialize the clock variable */
+	clock = get_next_clocksource();
+
+	/* initialize cycle_last offset base */
+	cycle_last = read_clocksource(clock);
+
+	/* initialize wall_time_offset to now*/
+	/* XXX - this should be something like ns_to_ktime() */
+	wall_time_offset = ktime_add_ns(wall_time_offset,
+					read_persistent_clock());
+
+	/* initialize timespec values */
+	wall_time_ts = ktime_to_timespec(
+				ktime_add(system_time, wall_time_offset));
+	monotonic_time_offset_ts = ktime_to_timespec(wall_time_offset);
+
+
+	/* clear NTP scaling factor & state machine */
+	ntp_adj = 0;
+	ntp_clear();
+	ts_interval = calculate_clocksource_interval(clock, ntp_adj,
+				INTERVAL_LEN);
+
+	/* initialize legacy time values */
+	update_legacy_time_values();
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+
+	/* Install timeofday_periodic_hook timer */
+	init_timer(&timeofday_timer);
+	timeofday_timer.function = timeofday_periodic_hook;
+	timeofday_timer.expires = jiffies + 1;
+	add_timer(&timeofday_timer);
+}
diff -ruN corefix1/kernel/time.c corefix2/kernel/time.c
--- corefix1/kernel/time.c	2005-10-31 18:50:11.000000000 -0800
+++ corefix2/kernel/time.c	2005-10-31 18:50:44.000000000 -0800
@@ -38,6 +38,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
+#include <linux/timeofday.h>
 
 /* 
  * The timezone where the local system is located.  Used as a default by some
@@ -128,6 +129,7 @@
  * as real UNIX machines always do it. This avoids all headaches about
  * daylight saving times and warping kernel clocks.
  */
+#ifndef CONFIG_GENERIC_TIME
 static inline void warp_clock(void)
 {
 	write_seqlock_irq(&xtime_lock);
@@ -137,6 +139,18 @@
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 }
+#else /* !CONFIG_GENERIC_TIME */
+/* XXX - this is somewhat cracked out and should
+         be checked  -johnstul@us.ibm.com
+*/
+static inline void warp_clock(void)
+{
+	struct timespec ts;
+	getnstimeofday(&ts);
+	ts.tv_sec += sys_tz.tz_minuteswest * 60;
+	do_settimeofday(&ts);
+}
+#endif /* !CONFIG_GENERIC_TIME */
 
 /*
  * In case for some reason the CMOS clock has not already been running
@@ -481,6 +495,7 @@
 }
 EXPORT_SYMBOL(timespec_trunc);
 
+#ifndef CONFIG_GENERIC_TIME
 #ifdef CONFIG_TIME_INTERPOLATION
 void getnstimeofday (struct timespec *tv)
 {
@@ -565,6 +580,8 @@
 EXPORT_SYMBOL_GPL(getnstimeofday);
 #endif
 
+#endif /* !CONFIG_GENERIC_TIME */
+
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
 {
diff -ruN corefix1/kernel/timer.c corefix2/kernel/timer.c
--- corefix1/kernel/timer.c	2005-10-31 18:50:11.000000000 -0800
+++ corefix2/kernel/timer.c	2005-10-31 18:50:44.000000000 -0800
@@ -28,7 +28,7 @@
 #include <linux/swap.h>
 #include <linux/notifier.h>
 #include <linux/thread_info.h>
-#include <linux/time.h>
+#include <linux/timeofday.h>
 #include <linux/jiffies.h>
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
@@ -879,6 +879,7 @@
 
 }
 
+#ifndef CONFIG_GENERIC_TIME
 /*
  * Using a loop looks inefficient, but "ticks" is
  * usually just one (we shouldn't be losing ticks,
@@ -931,6 +932,9 @@
 
 	} while (ticks);
 }
+#else /* !CONFIG_GENERIC_TIME */
+#define update_wall_time(x)
+#endif /* !CONFIG_GENERIC_TIME */
 
 /*
  * Called from the timer interrupt handler to charge one tick to the current 


