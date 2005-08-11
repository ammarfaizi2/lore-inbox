Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVHKCRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVHKCRJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 22:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVHKCRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 22:17:09 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:52665 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932211AbVHKCRH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 22:17:07 -0400
Subject: [PATCH 2/9] Generic timekeeping core subsystem
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1123726463.32531.35.camel@cog.beaverton.ibm.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123726394.32531.33.camel@cog.beaverton.ibm.com>
	 <1123726463.32531.35.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 19:16:59 -0700
Message-Id: <1123726619.32531.38.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

This patch implements the architecture independent portion of the
generic time of day subsystem. Included below is timeofday.c (which
includes all the time of day management and accessor functions), and
minimal hooks into arch independent code.

This patch applies on top of my timesource managment patch.

The patch does nothing without at least minimal architecture specific
hooks (i386, x86-64 and other architecture examples to follow), and it
should be able to be applied to a tree without affecting the existing
code.

thanks
-john


linux-2.6.13-rc6_timeofday-core_B5.patch
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
+typedef u64 nsec_t;
+typedef u64 cycle_t;
+
 /* Parameters used to convert the timespec values */
 #ifndef USEC_PER_SEC
 #define USEC_PER_SEC (1000000L)
diff --git a/include/linux/timeofday.h b/include/linux/timeofday.h
new file mode 100644
--- /dev/null
+++ b/include/linux/timeofday.h
@@ -0,0 +1,58 @@
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
+extern nsec_t get_lowres_timestamp(void);
+extern nsec_t get_lowres_timeofday(void);
+extern nsec_t do_monotonic_clock(void);
+
+extern void do_gettimeofday(struct timeval *tv);
+extern void getnstimeofday(struct timespec *ts);
+extern int do_settimeofday(struct timespec *tv);
+
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
+#else /* CONFIG_GENERICTOD */
+#define timeofday_init()
+#endif /* CONFIG_GENERICTOD */
+#endif /* _LINUX_TIMEOFDAY_H */
diff --git a/include/linux/timex.h b/include/linux/timex.h
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -227,6 +227,8 @@ struct timex {
 extern unsigned long tick_usec;		/* USER_HZ period (usec) */
 extern unsigned long tick_nsec;		/* ACTHZ          period (nsec) */
 
+#ifndef CONFIG_GENERICTOD
+
 #ifdef CONFIG_TIME_INTERPOLATION
 
 #define TIME_SOURCE_CPU 0
@@ -281,6 +283,7 @@ time_interpolator_reset(void)
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
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -473,6 +474,7 @@ asmlinkage void __init start_kernel(void
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
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o ntp.o
 
+obj-$(CONFIG_GENERICTOD) += timeofday.o timesource.o
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -48,6 +48,8 @@
 #include <linux/jiffies.h>
 #include <linux/errno.h>
 
+#define NTP_DEBUG 0
+
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */
 
@@ -67,6 +69,7 @@ static long ntp_reftime;                
 
 /* Extra values */
 static int ntp_state    = TIME_OK;              /* leapsecond state */
+static long ntp_tick    = USEC_PER_SEC/USER_HZ; /* tick length */
 long ntp_adjtime_offset;
 static long ntp_next_adjtime_offset;
 
@@ -83,6 +86,14 @@ static seqlock_t ntp_lock = SEQLOCK_UNLO
 #define MAX_SINGLESHOT_ADJ 500 /* (ppm) */
 #define SEC_PER_DAY 86400
 
+/**
+ * ntp_advance - Periodic hook which increments NTP state machine
+ * interval_nsec: interval value used to increment the state machine
+ *
+ *  Periodic hook which increments NTP state machine by interval.
+ *
+ *  This is ntp_hardclock in the RFC.
+ */
 void ntp_advance(unsigned long interval_nsec)
 {
 	static unsigned long interval_sum = 0;
@@ -243,6 +254,9 @@ static int ntp_hardupdate(long offset, s
 		offset_ppm <<= (SHIFT_USEC - SHIFT_UPDATE);
 
 		ntp_freq += shiftR(offset_ppm, SHIFT_KH);
+#if NTP_DEBUG
+		printk("ntp->freq change: %ld\n",shiftR(offset_ppm, damping));
+#endif
 
 	} else if ((ntp_status & STA_PLL) && (interval < MAXSEC)) {
 		long damping, offset_ppm;
@@ -253,7 +267,14 @@ static int ntp_hardupdate(long offset, s
 
 		ntp_freq += shiftR(offset_ppm, damping);
 
+#if NTP_DEBUG
+		printk("ntp->freq change: %ld\n", shiftR(offset_ppm, damping));
+#endif
 	} else { /* calibration interval out of bounds (p. 12) */
+#if NTP_DEBUG
+		printk("ntp_hardupdate(): interval out of bounds: %ld status: 0x%x\n",
+				interval, ntp_status);
+#endif
 		ret = TIME_ERROR;
 	}
 
@@ -264,9 +285,9 @@ static int ntp_hardupdate(long offset, s
 	return ret;
 }
 
-
-/* adjtimex mainly allows reading (and writing, if superuser) of
- * kernel time-keeping variables. used by xntpd.
+/**
+ * ntp_adjtimex - Interface to change NTP state machine
+ * @txc: timex value passed to the kernel to be used
  */
 int ntp_adjtimex(struct timex *txc)
 {
@@ -315,6 +336,13 @@ int ntp_adjtimex(struct timex *txc)
 				||(txc->tick > 11000000/USER_HZ)))
 		return -EINVAL;
 
+#if NTP_DEBUG
+	if(txc->modes) {
+		printk("adjtimex: txc->offset: %ld    txc->freq: %ld\n",
+				txc->offset, txc->freq);
+	}
+#endif
+
 	write_seqlock_irqsave(&ntp_lock, flags);
 
 	result = ntp_state;       /* mostly `TIME_OK' */
@@ -355,9 +383,8 @@ int ntp_adjtimex(struct timex *txc)
 		tick_adj = ((USEC_PER_SEC + USER_HZ/2)/USER_HZ) - txc->tick;
 		/* multiply by user_hz to get usec/sec => ppm */
 		tick_adj *= USER_HZ;
-
-		tick_usec = txc->tick;
-		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
+		/* save txc->tick for future calls to adjtimex */
+		ntp_tick = txc->tick;
 	}
 
 	if ((ntp_status & (STA_UNSYNC|STA_CLOCKERR)) != 0)
@@ -376,7 +403,7 @@ int ntp_adjtimex(struct timex *txc)
 	txc->constant = ntp_constant;
 	txc->precision = ntp_precision;
 	txc->tolerance = ntp_tolerance;
-	txc->tick = tick_usec;
+	txc->tick = ntp_tick;
 
 	/* PPS is not implemented, so these are zero */
 	txc->ppsfreq = 0;
diff --git a/kernel/time.c b/kernel/time.c
--- a/kernel/time.c
+++ b/kernel/time.c
@@ -39,6 +39,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
+#include <linux/timeofday.h>
 
 /* 
  * The timezone where the local system is located.  Used as a default by some
@@ -129,6 +130,7 @@ asmlinkage long sys_gettimeofday(struct 
  * as real UNIX machines always do it. This avoids all headaches about
  * daylight saving times and warping kernel clocks.
  */
+#ifndef CONFIG_GENERICTOD
 static inline void warp_clock(void)
 {
 	write_seqlock_irq(&xtime_lock);
@@ -138,6 +140,18 @@ static inline void warp_clock(void)
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
@@ -308,6 +322,7 @@ struct timespec timespec_trunc(struct ti
 }
 EXPORT_SYMBOL(timespec_trunc);
 
+#ifndef CONFIG_GENERICTOD
 #ifdef CONFIG_TIME_INTERPOLATION
 void getnstimeofday (struct timespec *tv)
 {
@@ -391,6 +406,7 @@ void getnstimeofday(struct timespec *tv)
 	tv->tv_nsec = x.tv_usec * NSEC_PER_USEC;
 }
 #endif
+#endif /* !CONFIG_GENERICTOD */
 
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
diff --git a/kernel/timeofday.c b/kernel/timeofday.c
new file mode 100644
--- /dev/null
+++ b/kernel/timeofday.c
@@ -0,0 +1,548 @@
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
+#include <linux/ntp.h>
+#include <linux/timex.h>
+#include <linux/timer.h>
+#include <linux/module.h>
+#include <linux/sched.h> /* Needed for capable() */
+#include <linux/sysdev.h>
+#include <linux/jiffies.h>
+#include <asm/timeofday.h>
+
+#define TIME_DBG 0
+#define TIME_DBG_FREQ 60000
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
+/*[Cycle based variables]
+ * offset_base:
+ *     Value of the timesource at the last timeofday_periodic_hook()
+ *     (adjusted only minorly to account for rounded off cycles)
+ */
+static cycle_t offset_base;
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
+/**
+ * get_lowres_timestamp - Returns a low res timestamp
+ *
+ * Returns a low res timestamp w/ PERIODIC_INTERVAL_MS
+ * granularity. (ie: the value of system_time as
+ * calculated at the last invocation of
+ * timeofday_periodic_hook())
+ */
+nsec_t get_lowres_timestamp(void)
+{
+	nsec_t ret;
+	unsigned long seq;
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		ret = system_time;
+
+	} while (read_seqretry(&system_time_lock, seq));
+
+	return ret;
+}
+
+
+/**
+ * get_lowres_timeofday - Returns a low res time of day
+ *
+ * Returns a low res time of day, as calculated at the
+ * last invocation of timeofday_periodic_hook().
+ */
+nsec_t get_lowres_timeofday(void)
+{
+	nsec_t ret;
+	unsigned long seq;
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		ret = system_time + wall_time_offset;
+
+	} while (read_seqretry(&system_time_lock, seq));
+
+	return ret;
+}
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
+	xtime = ns_to_timespec(system_time + wall_time_offset);
+	wall_to_monotonic = ns_to_timespec(wall_time_offset);
+	set_normalized_timespec(&wall_to_monotonic,
+		-wall_to_monotonic.tv_sec, -wall_to_monotonic.tv_nsec);
+	/* We don't update jiffies here because it is its own time domain */
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+}
+
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
+	nsec_t ret, ns_offset;
+	cycle_t now, cycle_delta;
+
+	/* read timesource */
+	now = read_timesource(timesource);
+
+	/* calculate the delta since the last timeofday_periodic_hook */
+	cycle_delta = (now - offset_base) & timesource->mask;
+
+	/* convert to nanoseconds */
+	ns_offset = cyc2ns(timesource, ntp_adj, cycle_delta);
+
+	/* add result to system time */
+	ret = system_time + ns_offset;
+
+	return ret;
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
+/**
+ * __gettimeofday - Returns the timeofday in nsec_t.
+ *
+ * Private function. Returns the timeofday in nsec_t.
+ */
+static inline nsec_t __gettimeofday(void)
+{
+	nsec_t wall, sys;
+	unsigned long seq;
+
+	/* atomically read wall and sys time */
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		wall = wall_time_offset;
+		sys = __monotonic_clock();
+
+	} while (read_seqretry(&system_time_lock, seq));
+
+	return wall + sys;
+}
+
+
+/**
+ * getnstimeofday - Returns the time of day in a timespec
+ * @ts: pointer to the timespec to be set
+ *
+ * Returns the time of day in a timespec
+ * For consistency should be renamed
+ * later to do_getnstimeofday()
+ */
+void getnstimeofday(struct timespec *ts)
+{
+	*ts = ns_to_timespec(__gettimeofday());
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
+	*tv = ns_to_timeval(__gettimeofday());
+}
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
+	nsec_t newtime = timespec_to_ns(tv);
+
+	/* atomically adjust wall_time_offset & clear ntp state machine */
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	wall_time_offset = newtime - __monotonic_clock();
+	ntp_clear();
+
+	update_legacy_time_values();
+
+	arch_update_vsyscall_gtod(system_time + wall_time_offset, offset_base,
+							timesource, ntp_adj);
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
+static int timeofday_suspend_hook(struct sys_device *dev, u32 state)
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
+	nsec_t now, suspend_time;
+	unsigned long flags;
+
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	BUG_ON(time_suspend_state != TIME_SUSPENDED);
+
+	/* Read persistent clock to mark the end of
+	 * the suspend interval then rebase the
+	 * offset_base to current timesource value.
+	 * Again, time between these two calls will
+	 * not be accounted for and will show up as
+	 * time drift.
+	 */
+	now = read_persistent_clock();
+	offset_base = read_timesource(timesource);
+
+	suspend_time = now - suspend_start;
+
+	system_time += suspend_time;
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
+	cycle_t now, cycle_delta;
+	static u64 remainder;
+	nsec_t ns, ns_ntp;
+	long leapsecond;
+	struct timesource_t* next;
+	unsigned long flags;
+	u64 mult_adj;
+	int ppm;
+
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	/* read time source & calc time since last call*/
+	now = read_timesource(timesource);
+	cycle_delta = (now - offset_base) & timesource->mask;
+
+	/* convert cycles to ntp adjusted ns and save remainder */
+	ns_ntp = cyc2ns_rem(timesource, ntp_adj, cycle_delta, &remainder);
+
+	/* convert cycles to raw ns for ntp advance */
+	ns = cyc2ns(timesource, 0, cycle_delta);
+
+#if TIME_DBG
+	static int dbg=0;
+	if(!(dbg++%TIME_DBG_FREQ)){
+		printk(KERN_INFO "now: %lluc - then: %lluc = delta: %lluc -> %llu ns + %llu shift_ns (ntp_adj: %i)\n",
+			(unsigned long long)now, (unsigned long long)offset_base,
+			(unsigned long long)cycle_delta, (unsigned long long)ns,
+			(unsigned long long)remainder, ntp_adj);
+	}
+}
+#endif
+
+	/* update system_time */
+	system_time += ns_ntp;
+
+	/* reset the offset_base */
+	offset_base = now;
+
+	/* advance the ntp state machine by ns interval*/
+	ntp_advance((unsigned long)ns);
+
+	/* do ntp leap second processing*/
+	leapsecond = ntp_leapsecond(ns_to_timespec(system_time+wall_time_offset));
+	wall_time_offset += leapsecond * NSEC_PER_SEC;
+
+	/* sync the persistent clock */
+	if (ntp_synced())
+		sync_persistent_clock(ns_to_timespec(system_time + wall_time_offset));
+
+	/* if necessary, switch timesources */
+	next = get_next_timesource();
+	if (next != timesource) {
+		/* immediately set new offset_base */
+		offset_base = read_timesource(next);
+		/* swap timesources */
+		timesource = next;
+		printk(KERN_INFO "Time: %s timesource has been installed.\n",
+					timesource->name);
+		ntp_clear();
+		ntp_adj = 0;
+		remainder = 0;
+	}
+
+	/* now is a safe time, so allow timesource to adjust
+	 * itself (for example: to make cpufreq changes).
+	 */
+	if(timesource->update_callback)
+		timesource->update_callback();
+
+
+	/* Convert the signed ppm to timesource multiplier adjustment */
+	ppm = ntp_get_ppm_adjustment();
+	mult_adj = abs(ppm);
+	mult_adj = (mult_adj * timesource->mult)>>SHIFT_USEC;
+	mult_adj += 1000000/2; /* round for div*/
+	do_div(mult_adj, 1000000);
+	if (ppm < 0)
+		ntp_adj = -(int)mult_adj;
+	else
+		ntp_adj = (int)mult_adj;
+
+
+	update_legacy_time_values();
+
+	arch_update_vsyscall_gtod(system_time + wall_time_offset, offset_base,
+							timesource, ntp_adj);
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+
+	/* XXX - Do we need to call clock_was_set() here? */
+
+	/* Set us up to go off on the next interval */
+	mod_timer(&timeofday_timer,
+				jiffies + msecs_to_jiffies(PERIODIC_INTERVAL_MS));
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
+#if TIME_DBG
+	printk(KERN_INFO "timeofday_init: Starting up!\n");
+#endif
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	/* initialize the timesource variable */
+	timesource = get_next_timesource();
+
+	/* clear and initialize offsets */
+	offset_base = read_timesource(timesource);
+	wall_time_offset = read_persistent_clock();
+
+	/* clear NTP scaling factor & state machine */
+	ntp_adj = 0;
+	ntp_clear();
+
+	/* initialize legacy time values */
+	update_legacy_time_values();
+
+	arch_update_vsyscall_gtod(system_time + wall_time_offset, offset_base,
+							timesource, ntp_adj);
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+
+	/* Install timeofday_periodic_hook timer */
+	init_timer(&timeofday_timer);
+	timeofday_timer.function = timeofday_periodic_hook;
+	timeofday_timer.expires = jiffies + 1;
+	add_timer(&timeofday_timer);
+
+
+#if TIME_DBG
+	printk(KERN_INFO "timeofday_init: finished!\n");
+#endif
+	return;
+}
diff --git a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -599,6 +599,7 @@ struct timespec wall_to_monotonic __attr
 EXPORT_SYMBOL(xtime);
 
 
+#ifndef CONFIG_GENERICTOD
 /* in the NTP reference this is called "hardclock()" */
 static void update_wall_time_one_tick(void)
 {
@@ -641,6 +642,9 @@ static void update_wall_time(unsigned lo
 		}
 	} while (ticks);
 }
+#else /* !CONFIG_GENERICTOD */
+#define update_wall_time(x)
+#endif /* !CONFIG_GENERICTOD */
 
 /*
  * Called from the timer interrupt handler to charge one tick to the current 


