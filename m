Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbVI3Aqi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVI3Aqi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:46:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbVI3Aqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:46:38 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:8868 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932447AbVI3Aqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:46:37 -0400
Subject: [PATCH 4/11] generic timeofday core subsystem
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1128041118.8195.314.camel@cog.beaverton.ibm.com>
References: <1128040851.8195.307.camel@cog.beaverton.ibm.com>
	 <1128040939.8195.310.camel@cog.beaverton.ibm.com>
	 <1128041052.8195.312.camel@cog.beaverton.ibm.com>
	 <1128041118.8195.314.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 17:46:28 -0700
Message-Id: <1128041188.8195.317.camel@cog.beaverton.ibm.com>
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
more direct mapping between a hardware timesource counter and the time
of day. This allows for lost ticks or other software delays to not
affect timekeeping.

Features of this design:
========================

o Splits time of day management from timer interrupts
o Consolidates a large amount of code
o Generic algorithms which use time-source drivers chosen at runtime
o More consistent and readable code

For an older description on the rework, see here:
http://lwn.net/Articles/120850/ (Many thanks to the LWN team for that
easy to understand writeup!)

This patch implements the architecture independent portion of the
generic time of day subsystem. Included below is timeofday.c (which
includes all the time of day management and accessor functions), and
minimal hooks into arch independent code. This patch does not remove the
current timekeeping code, allowing architectures to move over when they
are ready. 

This patch applies on top of my timesource management patch.

The patch does nothing without at least minimal architecture specific
hooks (i386, x86-64 and other architecture examples to follow), and it
should be able to be applied to a tree without affecting the existing
code.

Finally I'd like to thank the following people who have contributed
ideas, criticism, testing and code that has helped shape this work:

	George Anzinger, Nish Aravamudan, Max Asbock, Dominik Brodowski, Thomas
Gleixner Darren Hart, Christoph Lameter, Matt Mackal, Keith Mannthey,
Martin Schwidefsky, Frank Sorenson, Ulrich Windl, Darrick Wong, Roman
Zippel and any others whom I've accidentally forgotten.

thanks
-john


 drivers/char/hangcheck-timer.c  |    5 
 include/asm-generic/timeofday.h |   26 +
 include/linux/time.h            |    4 
 include/linux/timeofday.h       |   83 +++++
 include/linux/timex.h           |    2 
 init/main.c                     |    2 
 kernel/Makefile                 |    1 
 kernel/time.c                   |   40 ++
 kernel/timeofday.c              |  575 ++++++++++++++++++++++++++++++++++++++++
 kernel/timer.c                  |    4 
 10 files changed, 742 insertions(+)

linux-2.6.14-rc2_timeofday-core_B6.patch
============================================
diff --git a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
--- a/drivers/char/hangcheck-timer.c
+++ b/drivers/char/hangcheck-timer.c
@@ -49,6 +49,7 @@
 #include <linux/delay.h>
 #include <asm/uaccess.h>
 #include <linux/sysrq.h>
+#include <linux/timeofday.h>
 
 
 #define VERSION_STR "0.9.0"
@@ -130,8 +131,12 @@ __setup("hcheck_dump_tasks", hangcheck_p
 #endif
 
 #ifdef HAVE_MONOTONIC
+#ifndef CONFIG_GENERICTOD
 extern unsigned long long monotonic_clock(void);
 #else
+#define monotonic_clock() do_monotonic_clock()
+#endif
+#else
 static inline unsigned long long monotonic_clock(void)
 {
 # ifdef __s390__
diff --git a/include/asm-generic/timeofday.h b/include/asm-generic/timeofday.h
new file mode 100644
--- /dev/null
+++ b/include/asm-generic/timeofday.h
@@ -0,0 +1,26 @@
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
+#include <asm/div64.h>
+#ifdef CONFIG_GENERICTOD
+
+/* Required externs */
+extern nsec_t read_persistent_clock(void);
+extern void sync_persistent_clock(struct timespec ts);
+
+#ifdef CONFIG_GENERICTOD_VSYSCALL
+extern void arch_update_vsyscall_gtod(nsec_t wall_time, cycle_t offset_base,
+				struct timesource_t* timesource, int ntp_adj);
+#else
+#define arch_update_vsyscall_gtod(x,y,z,w) {}
+#endif /* CONFIG_GENERICTOD_VSYSCALL */
+
+#endif /* CONFIG_GENERICTOD */
+#endif
diff --git a/include/linux/time.h b/include/linux/time.h
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -27,6 +27,10 @@ struct timezone {
 
 #ifdef __KERNEL__
 
+/* timeofday base types */
+typedef s64 nsec_t;
+typedef unsigned long cycle_t;
+
 /* Parameters used to convert the timespec values */
 #define MSEC_PER_SEC (1000L)
 #define USEC_PER_SEC (1000000L)
diff --git a/include/linux/timeofday.h b/include/linux/timeofday.h
new file mode 100644
--- /dev/null
+++ b/include/linux/timeofday.h
@@ -0,0 +1,83 @@
+/*  linux/include/linux/timeofday.h
+ *
+ *  This file contains the interface to the time of day subsystem
+ */
+#ifndef _LINUX_TIMEOFDAY_H
+#define _LINUX_TIMEOFDAY_H
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <asm/div64.h>
+
+#ifdef CONFIG_GENERICTOD
+/* Public definitions */
+extern nsec_t do_monotonic_clock(void);
+extern void do_gettimeofday(struct timeval *tv);
+extern void getnstimeofday(struct timespec *ts);
+extern int do_settimeofday(struct timespec *tv);
+extern void timeofday_init(void);
+
+/* Inline helper functions */
+static inline struct timeval ns_to_timeval(nsec_t ns)
+{
+	struct timeval tv;
+	tv.tv_sec = div_long_long_rem(ns, NSEC_PER_SEC, &tv.tv_usec);
+	tv.tv_usec = (tv.tv_usec + NSEC_PER_USEC/2) / NSEC_PER_USEC;
+	return tv;
+}
+
+static inline struct timespec ns_to_timespec(nsec_t ns)
+{
+	struct timespec ts;
+	ts.tv_sec = div_long_long_rem(ns, NSEC_PER_SEC, &ts.tv_nsec);
+	return ts;
+}
+
+static inline nsec_t timespec_to_ns(struct timespec* ts)
+{
+	nsec_t ret;
+	ret = ((nsec_t)ts->tv_sec) * NSEC_PER_SEC;
+	ret += ts->tv_nsec;
+	return ret;
+}
+
+static inline nsec_t timeval_to_ns(struct timeval* tv)
+{
+	nsec_t ret;
+	ret = ((nsec_t)tv->tv_sec) * NSEC_PER_SEC;
+	ret += tv->tv_usec * NSEC_PER_USEC;
+	return ret;
+}
+
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
+		normalize_timespec(&a);
+		ns -= NSEC_PER_SEC;
+		a.tv_nsec += NSEC_PER_SEC;
+	}
+	a.tv_nsec += ns;
+	normalize_timespec(&a);
+
+	return a;
+}
+
+
+#ifndef ARCH_IS_TICK_BASED
+#define arch_getoffset() (0)
+#else
+extern nsec_t arch_getoffset(void);
+#endif
+
+#else /* CONFIG_GENERICTOD */
+#define timeofday_init()
+#endif /* CONFIG_GENERICTOD */
+#endif /* _LINUX_TIMEOFDAY_H */
diff --git a/include/linux/timex.h b/include/linux/timex.h
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -313,6 +313,7 @@ int ntp_leapsecond(struct timespec now);
 	__x < 0 ? -(-__x >> __s) : __x >> __s;	\
 })
 
+#ifndef CONFIG_GENERICTOD
 
 #ifdef CONFIG_TIME_INTERPOLATION
 
@@ -368,6 +369,7 @@ time_interpolator_reset(void)
 }
 
 #endif /* !CONFIG_TIME_INTERPOLATION */
+#endif /* !CONFIG_GENERICTOD */
 
 #endif /* KERNEL */
 
diff --git a/init/main.c b/init/main.c
--- a/init/main.c
+++ b/init/main.c
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/timeofday.h>
 #include <net/sock.h>
 
 #include <asm/io.h>
@@ -486,6 +487,7 @@ asmlinkage void __init start_kernel(void
 	pidhash_init();
 	init_timers();
 	softirq_init();
+	timeofday_init();
 	time_init();
 
 	/*
diff --git a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -9,6 +9,7 @@ obj-y     = sched.o fork.o exec_domain.o
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
 
+obj-$(CONFIG_GENERICTOD) += timeofday.o timesource.o
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
diff --git a/kernel/time.c b/kernel/time.c
--- a/kernel/time.c
+++ b/kernel/time.c
@@ -38,6 +38,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
+#include <linux/timeofday.h>
 
 /* 
  * The timezone where the local system is located.  Used as a default by some
@@ -128,6 +129,7 @@ asmlinkage long sys_gettimeofday(struct 
  * as real UNIX machines always do it. This avoids all headaches about
  * daylight saving times and warping kernel clocks.
  */
+#ifndef CONFIG_GENERICTOD
 static inline void warp_clock(void)
 {
 	write_seqlock_irq(&xtime_lock);
@@ -137,6 +139,18 @@ static inline void warp_clock(void)
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 }
+#else /* !CONFIG_GENERICTOD */
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
+#endif /* !CONFIG_GENERICTOD */
 
 /*
  * In case for some reason the CMOS clock has not already been running
@@ -481,6 +495,7 @@ struct timespec timespec_trunc(struct ti
 }
 EXPORT_SYMBOL(timespec_trunc);
 
+#ifndef CONFIG_GENERICTOD
 #ifdef CONFIG_TIME_INTERPOLATION
 void getnstimeofday (struct timespec *tv)
 {
@@ -564,6 +579,31 @@ void getnstimeofday(struct timespec *tv)
 }
 #endif
 
+/**
+ * do_monotonic_clock - Returns monotonically increasing nanoseconds
+ *
+ * Returns the monotonically increasing number of nanoseconds
+ * since the system booted.
+ */
+nsec_t do_monotonic_clock(void)
+{
+	struct timespec ts, mo;
+	unsigned int seq;
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		getnstimeofday(&ts);
+		mo = wall_to_monotonic;
+	} while(read_seqretry(&xtime_lock, seq));
+
+	ts.tv_sec += mo.tv_sec;
+	ts.tv_nsec += mo.tv_nsec;
+
+	return ((u64)ts.tv_sec * NSEC_PER_SEC) + ts.tv_nsec;
+}
+
+#endif /* !CONFIG_GENERICTOD */
+
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
 {
diff --git a/kernel/timeofday.c b/kernel/timeofday.c
new file mode 100644
--- /dev/null
+++ b/kernel/timeofday.c
@@ -0,0 +1,575 @@
+/*********************************************************************
+* linux/kernel/timeofday.c
+*
+* This file contains the functions which access and manage
+* the system's time of day functionality.
+*
+* Copyright (C) 2003, 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
+*
+* This program is free software; you can redistribute it and/or modify
+* it under the terms of the GNU General Public License as published by
+* the Free Software Foundation; either version 2 of the License, or
+* (at your option) any later version.
+*
+* This program is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+* GNU General Public License for more details.
+*
+* You should have received a copy of the GNU General Public License
+* along with this program; if not, write to the Free Software
+* Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*
+* TODO WishList:
+*   o See XXX's below.
+**********************************************************************/
+
+#include <linux/timeofday.h>
+#include <linux/timesource.h>
+#include <linux/timex.h>
+#include <linux/timer.h>
+#include <linux/module.h>
+#include <linux/sched.h> /* Needed for capable() */
+#include <linux/sysdev.h>
+#include <linux/jiffies.h>
+#include <asm/timeofday.h>
+
+/* only run periodic_hook every 50ms */
+#define PERIODIC_INTERVAL_MS 50
+
+/*[Nanosecond based variables]
+ * system_time:
+ *     Monotonically increasing counter of the number of nanoseconds
+ *     since boot.
+ * wall_time_offset:
+ *     Offset added to system_time to provide accurate time-of-day
+ */
+static nsec_t system_time;
+static nsec_t wall_time_offset;
+
+/*[timespec based variables]
+ * wall_time_ts:
+ *     Timespec holding the current wall time. This is redundent
+ *     but necessary because we have both nsec_t and timespec
+ *     interfaces and the conversion between is costly.
+ * monotonic_time_offset_ts:
+ *     Timespec used to keep wall_to_monotonic synced. Hopefully
+ *     could be removed once wall_to_monotonic is killed.
+ */
+static struct timespec wall_time_ts;
+static struct timespec monotonic_time_offset_ts;
+
+/*[Cycle based variables]
+ * cycle_last:
+ *     Value of the timesource at the last timeofday_periodic_hook()
+ *     (adjusted only minorly to account for rounded off cycles)
+ */
+static cycle_t cycle_last;
+
+/* Used for fixed interval conversions
+ *    XXX - this is ugly here, can we clean it up
+ *    or find a better home for it?
+ */
+#define INTERVAL_LEN 1000000
+static struct interval_t {
+	cycle_t cycles;
+	nsec_t nsecs;
+	u64 remainder;
+} interval;
+
+static struct interval_t calculate_interval(struct timesource_t *t,
+							long adj, unsigned long length_nsec)
+{
+	struct interval_t ret;
+	u64 tmp;
+
+	tmp = length_nsec;
+	tmp <<= t->shift;
+	do_div(tmp, t->mult+adj);
+
+	ret.cycles = (cycle_t)tmp;
+	if(ret.cycles == 0)
+		ret.cycles = 1;
+
+	ret.nsecs = cyc2ns(t, adj, ret.cycles);
+
+	return ret;
+}
+
+/*[Time source data]
+ * timesource:
+ *     current timesource pointer
+ */
+static struct timesource_t *timesource;
+
+/*[NTP adjustment]
+ * ntp_adj:
+ *     value of the current ntp adjustment,
+ *     stored in timesource multiplier units.
+ */
+int ntp_adj;
+
+/*[Locks]
+ * system_time_lock:
+ *     generic lock for all locally scoped time values
+ */
+static seqlock_t system_time_lock = SEQLOCK_UNLOCKED;
+
+
+/*[Suspend/Resume info]
+ * time_suspend_state:
+ *     variable that keeps track of suspend state
+ * suspend_start:
+ *     start of the suspend call
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
+ *     soft-timer used to call timeofday_periodic_hook()
+ */
+struct timer_list timeofday_timer;
+
+
+/* [Functions]
+ */
+
+
+/**
+ * update_legacy_time_values - Used to sync legacy time values
+ *
+ * Private function. Used to sync legacy time values to
+ * current timeofday. Assumes we have the system_time_lock.
+ * Hopefully someday this function can be removed.
+ */
+static void update_legacy_time_values(void)
+{
+	unsigned long flags;
+	write_seqlock_irqsave(&xtime_lock, flags);
+	xtime = wall_time_ts;
+	wall_to_monotonic = monotonic_time_offset_ts;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	/* since time state has changed, notify vsyscall code */
+	arch_update_vsyscall_gtod(system_time + wall_time_offset, cycle_last,
+							timesource, ntp_adj);
+}
+
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
+	nsec_t ns_offset;
+	cycle_t cycle_now, cycle_delta;
+
+	/* read timesource */
+	cycle_now = read_timesource(timesource);
+
+	/* calculate the delta since the last timeofday_periodic_hook */
+	cycle_delta = (cycle_now - cycle_last) & timesource->mask;
+
+	/* convert to nanoseconds */
+	ns_offset = cyc2ns(timesource, ntp_adj, cycle_delta);
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
+ * __monotonic_clock - Returns monotonically increasing nanoseconds
+ *
+ * private function, must hold system_time_lock lock when being
+ * called. Returns the monotonically increasing number of
+ * nanoseconds since the system booted (adjusted by NTP scaling)
+ */
+static inline nsec_t __monotonic_clock(void)
+{
+	return system_time + __get_nsec_offset();
+}
+
+
+/**
+ * do_monotonic_clock - Returns monotonically increasing nanoseconds
+ *
+ * Returns the monotonically increasing number of nanoseconds
+ * since the system booted via __monotonic_clock()
+ */
+nsec_t do_monotonic_clock(void)
+{
+	nsec_t ret;
+	unsigned long seq;
+
+	/* atomically read __monotonic_clock() */
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		ret = __monotonic_clock();
+
+	} while (read_seqretry(&system_time_lock, seq));
+
+	return ret;
+}
+
+
+
+/**
+ * getnstimeofday - Returns the time of day in a timespec
+ * @ts: pointer to the timespec to be set
+ *
+ * Returns the time of day in a timespec
+ * XXX - For consistency should be renamed
+ * later to do_getnstimeofday()
+ */
+void getnstimeofday(struct timespec *ts)
+{
+	struct timespec now_ts;
+	nsec_t nsecs;
+	unsigned long seq;
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
+EXPORT_SYMBOL(getnstimeofday);
+
+
+/**
+ * do_gettimeofday - Returns the time of day in a timeval
+ * @tv: pointer to the timeval to be set
+ *
+ */
+void do_gettimeofday(struct timeval *tv)
+{
+	struct timespec now_ts;
+	getnstimeofday(&now_ts);
+	tv->tv_sec = now_ts.tv_sec;
+	tv->tv_usec = now_ts.tv_nsec/1000;
+}
+
+EXPORT_SYMBOL(do_gettimeofday);
+
+
+/**
+ * do_settimeofday - Sets the time of day
+ * @tv: pointer to the timespec that will be used to set the time
+ *
+ */
+int do_settimeofday(struct timespec *tv)
+{
+	unsigned long flags;
+	nsec_t newtime;
+
+	newtime = timespec_to_ns(tv);
+
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	wall_time_offset = newtime - __monotonic_clock();
+
+	wall_time_ts = ns_to_timespec(system_time + wall_time_offset);
+
+	monotonic_time_offset_ts = ns_to_timespec(wall_time_offset);
+	set_normalized_timespec(&monotonic_time_offset_ts,
+		-monotonic_time_offset_ts.tv_sec, -monotonic_time_offset_ts.tv_nsec);
+
+	ntp_clear();
+
+	update_legacy_time_values();
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+
+	/* signal posix-timers about time change */
+	clock_was_set();
+
+	return 0;
+}
+EXPORT_SYMBOL(do_settimeofday);
+
+
+/**
+ * timeofday_suspend_hook - allows the timeofday subsystem to be shutdown
+ * @dev: unused
+ * state: unused
+ *
+ * This function allows the timeofday subsystem to
+ * be shutdown for a period of time. Usefull when
+ * going into suspend/hibernate mode. The code is
+ * very similar to the first half of
+ * timeofday_periodic_hook().
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
+	 * then quickly call __monotonic_clock.
+	 * These two calls hopefully occur quickly
+	 * because the difference between reads will
+	 * accumulate as time drift on resume.
+	 */
+	suspend_start = read_persistent_clock();
+	system_time = __monotonic_clock();
+
+	time_suspend_state = TIME_SUSPENDED;
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+	return 0;
+}
+
+
+/**
+ * timeofday_resume_hook - Resumes the timeofday subsystem.
+ * @dev: unused
+ *
+ * This function resumes the timeofday subsystem
+ * from a previous call to timeofday_suspend_hook.
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
+	 * cycle_last to current timesource value.
+	 * Again, time between these two calls will
+	 * not be accounted for and will show up as
+	 * time drift.
+	 */
+	suspend_end = read_persistent_clock();
+	cycle_last = read_timesource(timesource);
+
+	suspend_time = suspend_end - suspend_start;
+
+	system_time += suspend_time;
+	wall_time_ts = ns_to_timespec(system_time + wall_time_offset);
+
+	ntp_clear();
+
+	time_suspend_state = TIME_RUNNING;
+
+	update_legacy_time_values();
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+
+	/* signal posix-timers about time change */
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
+static struct sys_device device_timer = {
+	.id	= 0,
+	.cls	= &timeofday_sysclass,
+};
+static int timeofday_init_device(void)
+{
+	int error = sysdev_class_register(&timeofday_sysclass);
+	if (!error)
+		error = sysdev_register(&device_timer);
+	return error;
+}
+device_initcall(timeofday_init_device);
+
+/**
+ * timeofday_periodic_hook - Does periodic update of timekeeping values.
+ * unused: unused
+ *
+ * Calculates the delta since the last call,
+ * updates system time and clears the offset.
+ *
+ * Called via timeofday_timer.
+ */
+static void timeofday_periodic_hook(unsigned long unused)
+{
+	unsigned long flags;
+
+	cycle_t cycle_now, cycle_delta;
+	nsec_t delta_nsec = 0;
+	static u64 remainder;
+
+	long leapsecond;
+	struct timesource_t* next;
+
+	int ppm;
+	static int ppm_last;
+
+	int something_changed = 0;
+	struct timesource_t old_timesource;
+
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	/* read time source & calc time since last call*/
+	cycle_now = read_timesource(timesource);
+	cycle_delta = (cycle_now - cycle_last) & timesource->mask;
+
+	/* update system_time */
+	while(cycle_delta > interval.cycles) {
+		delta_nsec += interval.nsecs;
+		cycle_delta -= interval.cycles;
+		cycle_last += interval.cycles;
+		/* XXX - Don't forget remainder accounting */
+	}
+	system_time += delta_nsec;
+	wall_time_ts = timespec_add_ns(wall_time_ts, delta_nsec);
+
+	cycle_last &= timesource->mask;
+
+	/* advance the ntp state machine by ns interval*/
+	ntp_advance(delta_nsec);
+
+	/* do ntp leap second processing*/
+	leapsecond = ntp_leapsecond(wall_time_ts);
+	if (leapsecond) {
+		wall_time_offset += leapsecond * NSEC_PER_SEC;
+		wall_time_ts.tv_sec += leapsecond;
+		monotonic_time_offset_ts.tv_sec -= leapsecond;
+	}
+
+	/* sync the persistent clock */
+	if (ntp_synced())
+		sync_persistent_clock(wall_time_ts);
+
+	/* if necessary, switch timesources */
+	next = get_next_timesource();
+	if (next != timesource) {
+		/* immediately set new cycle_last */
+		cycle_last = read_timesource(next);
+		cycle_now = cycle_last;
+		/* swap timesources */
+		old_timesource = *timesource;
+		timesource = next;
+		printk(KERN_INFO "Time: %s timesource has been installed.\n",
+					timesource->name);
+		ntp_clear();
+		ntp_adj = 0;
+		remainder = 0;
+		something_changed = 1;
+	}
+
+	/* now is a safe time, so allow timesource to adjust
+	 * itself (for example: to make cpufreq changes).
+	 */
+	if(timesource->update_callback) {
+		/* since timesource state might change, keep a copy */
+		old_timesource = *timesource;
+		if(timesource->update_callback())
+			something_changed = 1;
+	}
+
+	/* check for new PPM adjustment */
+	ppm = ntp_get_ppm_adjustment();
+	if (ppm_last != ppm) {
+		old_timesource = *timesource;
+		something_changed = 1;
+	}
+
+	/* if something changed, recalculate the ntp adjustment value */
+	if (something_changed) {
+		u64 mult_adj;
+
+		/* accumulate the current leftover cycles using old_timesoruce */
+		if (cycle_delta) {
+			delta_nsec = cyc2ns(&old_timesource, ntp_adj, cycle_delta);
+			system_time += delta_nsec;
+			wall_time_ts = timespec_add_ns(wall_time_ts, delta_nsec);
+			ntp_advance(delta_nsec);
+			cycle_last = cycle_now;
+		}
+
+		/* XXX - we can probably optimize most of this away */
+		ppm_last = ppm;
+		mult_adj = abs(ppm);
+		mult_adj = (mult_adj * timesource->mult)>>SHIFT_USEC;
+		mult_adj += 1000000/2; /* round for div*/
+		do_div(mult_adj, 1000000);
+		if (ppm < 0)
+			ntp_adj = -(int)mult_adj;
+		else
+			ntp_adj = (int)mult_adj;
+
+		interval = calculate_interval(timesource, ntp_adj, INTERVAL_LEN);
+	}
+
+	update_legacy_time_values();
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+
+	/* Set us up to go off on the next interval */
+	mod_timer(&timeofday_timer,
+			jiffies + msecs_to_jiffies(PERIODIC_INTERVAL_MS));
+}
+
+
+/**
+ * timeofday_init - Initializes time variables
+ *
+ */
+void __init timeofday_init(void)
+{
+	unsigned long flags;
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	/* initialize the timesource variable */
+	timesource = get_next_timesource();
+
+	/* clear and initialize offsets */
+	cycle_last = read_timesource(timesource);
+	wall_time_offset = read_persistent_clock();
+	wall_time_ts = ns_to_timespec(system_time + wall_time_offset);
+	monotonic_time_offset_ts = ns_to_timespec(wall_time_offset);
+	set_normalized_timespec(&monotonic_time_offset_ts,
+		-monotonic_time_offset_ts.tv_sec, -monotonic_time_offset_ts.tv_nsec);
+
+	/* clear NTP scaling factor & state machine */
+	ntp_adj = 0;
+	ntp_clear();
+	interval = calculate_interval(timesource, ntp_adj, INTERVAL_LEN);
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
+
+	return;
+}
diff --git a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -839,6 +839,7 @@ void ntp_advance(unsigned long interval_
 
 }
 
+#ifndef CONFIG_GENERICTOD
 /*
  * Using a loop looks inefficient, but "ticks" is
  * usually just one (we shouldn't be losing ticks,
@@ -890,6 +891,9 @@ static void update_wall_time(unsigned lo
 
 	} while (ticks);
 }
+#else /* !CONFIG_GENERICTOD */
+#define update_wall_time(x)
+#endif /* !CONFIG_GENERICTOD */
 
 /*
  * Called from the timer interrupt handler to charge one tick to the current 


