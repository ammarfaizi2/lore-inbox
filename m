Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVAXXOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVAXXOV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVAXXKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:10:36 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:6360 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261701AbVAXWvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:51:40 -0500
Subject: [RFC][PATCH] new timeofday core subsystem (v. A2)
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: tim@physik3.uni-rostock.de, george anzinger <george@mvista.com>,
       albert@users.sourceforge.net, Ulrich.Windl@rz.uni-regensburg.de,
       Christoph Lameter <clameter@sgi.com>, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max <amax@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>
Content-Type: text/plain
Date: Mon, 24 Jan 2005 14:51:29 -0800
Message-Id: <1106607089.30884.10.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	Here is a new release of my time of day proposal, which include ppc64
support as well as suspend/resume and cpufreq hooks. For basic summary
of my ideas, you can follow this link: http://lwn.net/Articles/100665/

	This patch implements the architecture independent portion of the time
of day subsystem. Included is timeofday.c (which includes all the time
of day management and accessor functions), ntp.c (which includes the ntp
scaling code, leapsecond processing, and ntp kernel state machine code),
timesource.c (for timesource specific management functions), interface
definition .h files, the example jiffies timesource (lowest common
denominator time source, mainly for use as example code) and minimal
hooks into arch independent code.

The patch does not function without minimal architecture specific hooks
(i386, x86-64, and ppc64 examples to follow), and it can be applied to a
tree without affecting the code.

New in this version:
o TIMESOURCE_CYCLES type
o __iomem labes and proper mmio access
o write_seqlock_irq -> writeseqlock_irqsave
o arch generic interface for for get_cmos_time() equivalents
o suspend/resume hooks for sleep/hibernate (lightly tested)
o timesource adjust_callback hook 

I look forward to your comments and feedback.

thanks
-john

linux-2.6.11-rc2_timeofday-core_A2.patch
========================================
diff -Nru a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile	2005-01-24 13:30:06 -08:00
+++ b/drivers/Makefile	2005-01-24 13:30:06 -08:00
@@ -63,3 +63,4 @@
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
+obj-$(CONFIG_NEWTOD)		+= timesource/
diff -Nru a/drivers/timesource/Makefile b/drivers/timesource/Makefile
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/Makefile	2005-01-24 13:30:06 -08:00
@@ -0,0 +1 @@
+obj-y += jiffies.o
diff -Nru a/drivers/timesource/jiffies.c b/drivers/timesource/jiffies.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/timesource/jiffies.c	2005-01-24 13:30:06 -08:00
@@ -0,0 +1,45 @@
+/*
+ * linux/drivers/timesource/jiffies.c
+ *
+ * Copyright (C) 2004 IBM
+ *
+ * This file contains the jiffies based time source.
+ *
+ */
+#include <linux/timesource.h>
+#include <linux/jiffies.h>
+#include <linux/init.h>
+
+/* The Jiffies based timesource is the lowest common
+ * denominator time source which should function on
+ * all systems. It has the same course resolution as
+ * the timer interrupt frequency HZ and it suffers
+ * inaccuracies caused by missed or lost timer
+ * interrupts and the inability for the timer
+ * interrupt hardware to accuratly tick at the
+ * requested HZ value. It is also not reccomended
+ * for "tick-less" systems.
+ */
+
+static cycle_t jiffies_read(void)
+{
+	cycle_t ret = get_jiffies_64();
+	return ret;
+}
+
+struct timesource_t timesource_jiffies = {
+	.name = "jiffies",
+	.priority = 0, /* lowest priority*/
+	.type = TIMESOURCE_FUNCTION,
+	.read_fnct = jiffies_read,
+	.mask = (cycle_t)~0,
+	.mult = NSEC_PER_SEC/HZ,
+	.shift = 0,
+};
+
+static int init_jiffies_timesource(void)
+{
+	register_timesource(&timesource_jiffies);
+	return 0;
+}
+module_init(init_jiffies_timesource);
diff -Nru a/include/linux/ntp.h b/include/linux/ntp.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/ntp.h	2005-01-24 13:30:06 -08:00
@@ -0,0 +1,22 @@
+/*	linux/include/linux/ntp.h
+ *
+ *	Copyright (C) 2003, 2004 IBM, John Stultz (johnstul@us.ibm.com)
+ *
+ *	This file contains time of day helper functions
+ */
+
+#ifndef _LINUX_NTP_H
+#define _LINUX_NTP_H
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+
+/* timeofday interfaces */
+nsec_t ntp_scale(nsec_t value);
+void ntp_advance(nsec_t value);
+int ntp_adjtimex(struct timex*);
+int ntp_leapsecond(struct timespec now);
+void ntp_clear(void);
+int get_ntp_status(void);
+
+#endif
diff -Nru a/include/linux/time.h b/include/linux/time.h
--- a/include/linux/time.h	2005-01-24 13:30:06 -08:00
+++ b/include/linux/time.h	2005-01-24 13:30:06 -08:00
@@ -27,6 +27,10 @@
 
 #ifdef __KERNEL__
 
+/* timeofday base types */
+typedef u64 nsec_t;
+typedef u64 cycle_t;
+
 /* Parameters used to convert the timespec values */
 #ifndef USEC_PER_SEC
 #define USEC_PER_SEC (1000000L)
diff -Nru a/include/linux/timeofday.h b/include/linux/timeofday.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/timeofday.h	2005-01-24 13:30:06 -08:00
@@ -0,0 +1,67 @@
+/*	linux/include/linux/timeofday.h
+ *
+ *	Copyright (C) 2003, 2004 IBM, John Stultz (johnstul@us.ibm.com)
+ *
+ *	This file contains the interface to the time of day subsystem
+ */
+#ifndef _LINUX_TIMEOFDAY_H
+#define _LINUX_TIMEOFDAY_H
+#include <linux/types.h>
+#include <linux/time.h>
+#include <asm/div64.h>
+
+#ifdef CONFIG_NEWTOD
+nsec_t get_lowres_timestamp(void);
+nsec_t get_lowres_timeofday(void);
+nsec_t do_monotonic_clock(void);
+
+
+void do_gettimeofday(struct timeval *tv);
+int do_settimeofday(struct timespec *tv);
+int do_adjtimex(struct timex *tx);
+
+void timeofday_suspend_hook(void);
+void timeofday_resume_hook(void);
+
+void timeofday_interrupt_hook(void);
+void timeofday_init(void);
+
+
+/* Helper functions */
+static inline struct timeval ns2timeval(nsec_t ns)
+{
+	struct timeval tv;
+	tv.tv_sec = div_long_long_rem(ns, NSEC_PER_SEC, &tv.tv_usec);
+	tv.tv_usec /= NSEC_PER_USEC;
+	return tv;
+}
+
+static inline struct timespec ns2timespec(nsec_t ns)
+{
+	struct timespec ts;
+	ts.tv_sec = div_long_long_rem(ns, NSEC_PER_SEC, &ts.tv_nsec);
+	return ts;
+}
+
+static inline u64 timespec2ns(struct timespec* ts)
+{
+	nsec_t ret;
+	ret = ((nsec_t)ts->tv_sec) * NSEC_PER_SEC;
+	ret += ts->tv_nsec;
+	return ret;
+}
+
+static inline nsec_t timeval2ns(struct timeval* tv)
+{
+	nsec_t ret;
+	ret = ((nsec_t)tv->tv_sec) * NSEC_PER_SEC;
+	ret += tv->tv_usec*NSEC_PER_USEC;
+	return ret;
+}
+#else /* CONFIG_NEWTOD */
+#define timeofday_suspend_hook()
+#define timeofday_resume_hook()
+#define timeofday_interrupt_hook()
+#define timeofday_init()
+#endif /* CONFIG_NEWTOD */
+#endif /* _LINUX_TIMEOFDAY_H */
diff -Nru a/include/linux/timesource.h b/include/linux/timesource.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/timesource.h	2005-01-24 13:30:06 -08:00
@@ -0,0 +1,101 @@
+/*	linux/include/linux/timesource.h
+ *
+ *	Copyright (C) 2003, 2004 IBM, John Stultz (johnstul@us.ibm.com)
+ *
+ *	This file contains the structure definitions for timesources.
+ *
+ *	If you are not a timesource, or the time of day code, you should
+ *	not be including this file!
+ */
+#ifndef _LINUX_TIMESORUCE_H
+#define _LINUX_TIMESORUCE_H
+
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <asm/io.h>
+#include <asm/div64.h>
+
+/* struct timesource_t:
+ *		Provides mostly state-free accessors to the underlying
+ *		hardware.
+ * name:		ptr to timesource name
+ * priority:		priority value for selection (higher is better)
+ * type:		defines timesource type
+ * @read_fnct:		returns a cycle value
+ * ptr:			ptr to MMIO'ed counter
+ * mask:		bitmask for two's complement
+ * 			subtraction of non 64 bit counters
+ * mult:		cycle to nanosecond multiplier
+ * shift: 		cycle to nanosecond divisor (power of two)
+ * @update_callback:	called when safe to alter timesource values
+ */
+struct timesource_t {
+	char* name;
+	int priority;
+	enum {
+		TIMESOURCE_FUNCTION,
+		TIMESOURCE_CYCLES,
+		TIMESOURCE_MMIO_32,
+		TIMESOURCE_MMIO_64
+	} type;
+	cycle_t (*read_fnct)(void);
+	void __iomem* mmio_ptr;
+	cycle_t mask;
+	u32 mult;
+	u32 shift;
+	void (*update_callback)(void);
+};
+
+/* XXX - this should go somewhere better! */
+#ifndef readq
+static unsigned long long __inline readq(void __iomem *addr)
+{
+	return readl(addr) | (((unsigned long long)readl(addr + 4)) << 32LL);
+}
+#endif
+
+
+/* read_timersource():
+ *		Uses the timesource to return the current cycle_t value
+ */
+static inline cycle_t read_timesource(struct timesource_t* ts)
+{
+	switch (ts->type) {
+	case TIMESOURCE_MMIO_32:
+		return (cycle_t)readl(ts->mmio_ptr);
+	case TIMESOURCE_MMIO_64:
+		return (cycle_t)readq(ts->mmio_ptr);
+	case TIMESOURCE_CYCLES:
+		return (cycle_t)get_cycles();
+	default:/* case: TIMESOURCE_FUNCTION */
+		return ts->read_fnct();
+	}
+}
+
+/* cyc2ns():
+ *		Uses the timesource to convert cycle_ts to nanoseconds.
+ *		If rem is not null, it stores the remainder of the
+ *		calculation there.
+ *
+ */
+static inline nsec_t cyc2ns(struct timesource_t* ts, cycle_t cycles, cycle_t* rem)
+{
+	u64 ret;
+	ret = (u64)cycles;
+	ret *= ts->mult;
+	if (rem) {
+		/* relax, we only calc remainders at interrupt time */
+		u64 remainder = ret & ((1 << ts->shift) -1);
+		do_div(remainder, ts->mult);
+		*rem = remainder;
+	}
+	ret >>= ts->shift;
+	return (nsec_t)ret;
+}
+
+/* used to install a new time source */
+void register_timesource(struct timesource_t*);
+struct timesource_t* get_next_timesource(void);
+
+#endif
diff -Nru a/init/main.c b/init/main.c
--- a/init/main.c	2005-01-24 13:30:06 -08:00
+++ b/init/main.c	2005-01-24 13:30:06 -08:00
@@ -46,6 +46,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/timeofday.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
@@ -463,6 +464,7 @@
 	pidhash_init();
 	init_timers();
 	softirq_init();
+	timeofday_init();
 	time_init();
 
 	/*
diff -Nru a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile	2005-01-24 13:30:06 -08:00
+++ b/kernel/Makefile	2005-01-24 13:30:06 -08:00
@@ -9,6 +9,7 @@
 	    rcupdate.o intermodule.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o
 
+obj-$(CONFIG_NEWTOD) += timeofday.o timesource.o ntp.o
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
diff -Nru a/kernel/ntp.c b/kernel/ntp.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/kernel/ntp.c	2005-01-24 13:30:06 -08:00
@@ -0,0 +1,554 @@
+/********************************************************************
+* linux/kernel/ntp.c
+*
+* NTP state machine and time scaling code.
+*
+* Copyright (C) 2004 IBM, John Stultz (johnstul@us.ibm.com)
+*
+* Portions rewritten from kernel/time.c and kernel/timer.c
+* Please see those files for original copyrights.
+*
+* Hopefully you should never have to understand or touch
+* any of the code below. but don't let that keep you from trying!
+*
+* This code is loosely based on David Mills' RFC 1589 and its
+* updates. Please see the following for more details:
+*  http://www.eecis.udel.edu/~mills/database/rfc/rfc1589.txt
+*  http://www.eecis.udel.edu/~mills/database/reports/kern/kernb.pdf
+*
+* NOTE:	To simplify the code, we do not implement any of
+* the PPS code, as the code that uses it never was merged.
+*					-johnstul@us.ibm.com
+*
+* Revision History:
+* 2004-09-02: A0
+*	o First pass sent to lkml for review.
+* 2004-12-07: A1
+*	o No changes, sent to lkml for review.
+*
+* TODO List:
+*	o More documentation
+*	o More testing
+*	o More optimization
+*********************************************************************/
+
+#include <linux/ntp.h>
+#include <linux/errno.h>
+#include <linux/sched.h> /* Needed for capable() */
+
+/* NTP scaling code
+ * Functions:
+ * ----------
+ * nsec_t ntp_scale(nsec_t value):
+ *		Scales the nsec_t vale using ntp kernel state
+ * void ntp_advance(nsec_t interval):
+ *		Increments the NTP state machine by interval time
+ * static int ntp_hardupdate(long offset, struct timeval tv)
+ *		ntp_adjtimex helper function
+ * int ntp_adjtimex(struct timex* tx):
+ *		Interface to adjust NTP state machine
+ * int ntp_leapsecond(struct timespec now)
+ *		Does NTP leapsecond processing. Returns number of
+ *		seconds current time should be adjusted by.
+ * void ntp_clear(void):
+ *		Clears the ntp kernel state
+ * int get_ntp_status(void):
+ *		returns ntp_status value
+ *
+ * Variables:
+ * ----------
+ * ntp kernel state variables:
+ *		See below for full list.
+ * ntp_lock:
+ *		Protects ntp kernel state variables
+ */
+
+
+
+/* Chapter 5: Kernel Variables [RFC 1589 pg. 28] */
+/* 5.1 Interface Variables */
+static int ntp_status		= STA_UNSYNC;		/* status */
+static long ntp_offset;					/* usec */
+static long ntp_constant	= 2;			/* ntp magic? */
+static long ntp_maxerror	= NTP_PHASE_LIMIT;	/* usec */
+static long ntp_esterror	= NTP_PHASE_LIMIT;	/* usec */
+static const long ntp_tolerance	= MAXFREQ;		/* shifted ppm */
+static const long ntp_precision	= 1;			/* constant */
+
+/* 5.2 Phase-Lock Loop Variables */
+static long ntp_freq;					/* shifted ppm */
+static long ntp_reftime;				/* sec */
+
+/* Extra values */
+static int ntp_state	= TIME_OK;		/* leapsecond state */
+static long ntp_tick	= USEC_PER_SEC/USER_HZ;	/* tick length */
+
+static s64 ss_offset_len;	/* SINGLESHOT offset adj interval (nsec)*/
+static long singleshot_adj;	/* +/- MAX_SINGLESHOT_ADJ (ppm)*/
+static long tick_adj; 		/* tx->tick adjustment (ppm) */
+static long offset_adj;		/* offset adjustment (ppm) */
+
+
+/* lock for the above variables */
+static seqlock_t ntp_lock = SEQLOCK_UNLOCKED;
+
+#define MILLION 1000000
+#define MAX_SINGLESHOT_ADJ 500 /* (ppm) */
+#define SEC_PER_DAY 86400
+
+/* Required to safely shift negative values */
+#define shiftR(x,s) (x < 0) ? (-((-x) >> (s))) : ((x) >> (s))
+
+/* nsec_t ntp_scale(nsec_t):
+ *	Scale the raw time interval to an NTP scaled value
+ *
+ *	This is done in three steps:
+ *	1. Tick adjustment.
+ *	2. Frequency adjustment.
+ *	3. Singleshot offset adjustment
+ *
+ *	The first two are done over the entire raw interval. While
+ *	the third is only done as long as the raw interval is less
+ *	then the singleshot offset length.
+ *
+ *	The basic equasion is:
+ *	raw = raw + ppm scaling
+ *
+ *	So while raw < ss_offset_len:
+ *	raw = raw + (raw*(tick_adj+freq_adj+ss_offset_adj))/MILLION
+ *
+ *	But when raw is > ss_offset_len:
+ *	raw = raw
+ *		+ (ss_offset_len*(tick_adj+freq_adj+ss_offset_adj))/MILLION
+ *		+ ((raw - ss_offset_len)*(tick_adj+freq_adj))/MILLION
+ *
+ * XXX - TODO:
+ *	o Get rid of nasty 64bit divides (try shifts)
+ *	o more comments!
+ */
+nsec_t ntp_scale(nsec_t raw)
+{
+	u64 ret = (u64)raw;
+	unsigned long seq;
+	u64 offset_len;
+	long freq_ppm, tick_ppm, ss_ppm, offset_ppm;
+
+	/* save off current kernel state */
+	do {
+		seq = read_seqbegin(&ntp_lock);
+
+		tick_ppm = tick_adj;
+		offset_ppm = offset_adj;
+		freq_ppm = shiftR(ntp_freq,SHIFT_USEC);
+		ss_ppm = singleshot_adj;
+		offset_len = (u64)ss_offset_len;
+
+	} while (read_seqretry(&ntp_lock, seq));
+
+
+	/* Due to sign issues, this is a bit ugly */
+	if (raw <= offset_len) {
+		/* calcluate total ppm */
+		long ppm = tick_ppm + freq_ppm + offset_ppm + ss_ppm;
+
+		/* use abs(ppm) to avoid sign issues w/ do_div */
+		u64 tmp = raw * abs(ppm);
+
+		/* XXX - try to replace this w/ a 64bit shift */
+		do_div(tmp, MILLION);
+
+		/* reapply the sign lost by using abs(ppm) */
+		if(ppm < 0)
+			ret -= tmp;
+		else
+			ret += tmp;
+
+	} else {
+		/* Only apply MAX_SINGLESHOT_ADJ for the ss_offset_len */
+		s64 v1 = offset_len*(tick_ppm + freq_ppm + offset_ppm + ss_ppm);
+		s64 v2 = (s64)(raw - offset_len)*(tick_ppm + freq_ppm+ offset_ppm);
+
+		s64 tmp = v1+v2;
+
+		/* use abs(tmp) to avoid sign issues w/ do_div */
+		u64 tmp2 = abs(tmp);
+
+		/* XXX - try to replace this w/ a 64bit shift */
+		do_div(tmp2,MILLION);
+
+		/* reapply the sign lost by using abs(tmp2) */
+		if(tmp < 0)
+			ret -= tmp2;
+		else
+			ret += tmp2;
+	}
+
+	return (nsec_t)ret;
+}
+
+/* void ntp_advance(nsec_t interval):
+ *	Periodic hook which increments NTP state machine by interval
+ *	This is ntp_hardclock in the RFC.
+ */
+void ntp_advance(nsec_t interval)
+{
+	static u64 interval_sum=0;
+	unsigned long flags;
+
+	/* inc interval sum */
+	interval_sum += interval;
+
+	write_seqlock_irqsave(&ntp_lock, flags);
+
+	/* decrement singleshot offset interval */
+	ss_offset_len =- interval;
+	if(ss_offset_len < 0) /* make sure it doesn't go negative */
+		ss_offset_len=0;
+
+	/* Do second overflow code */
+	while (interval_sum > NSEC_PER_SEC) {
+		/* XXX - I'd prefer to smoothly apply this math
+		 * at each call to ntp_advance() rather then each
+		 * second.
+		 */
+		long tmp;
+
+		/* Bump maxerror by ntp_tolerance */
+		ntp_maxerror += shiftR(ntp_tolerance, SHIFT_USEC);
+		if (ntp_maxerror > NTP_PHASE_LIMIT) {
+			ntp_maxerror = NTP_PHASE_LIMIT;
+			ntp_status |= STA_UNSYNC;
+		}
+
+		/* Calculate offset_adj for the next second */
+		tmp = ntp_offset;
+		if (!(ntp_status & STA_FLL))
+		    tmp = shiftR(tmp, SHIFT_KG + ntp_constant);
+
+		/* bound the adjustment to MAXPHASE/MINSEC */
+		if (tmp > (MAXPHASE / MINSEC) << SHIFT_UPDATE)
+		    tmp = (MAXPHASE / MINSEC) << SHIFT_UPDATE;
+		if (tmp < -(MAXPHASE / MINSEC) << SHIFT_UPDATE)
+		    tmp = -(MAXPHASE / MINSEC) << SHIFT_UPDATE;
+
+		offset_adj = shiftR(tmp, SHIFT_UPDATE); /* (usec/sec) = ppm */
+		ntp_offset -= tmp;
+
+		interval_sum -= NSEC_PER_SEC;
+	}
+
+/* XXX - if still needed do equiv code to switching time_next_adjust */
+
+	write_sequnlock_irqrestore(&ntp_lock, flags);
+
+}
+
+
+/* called only by ntp_adjtimex while holding ntp_lock */
+static int ntp_hardupdate(long offset, struct timeval tv)
+{
+	int ret;
+	long tmp, interval;
+
+	ret = 0;
+	if (!(ntp_status & STA_PLL))
+		return ret;
+
+	tmp = offset;
+	/* Make sure offset is bounded by MAXPHASE */
+	if (tmp > MAXPHASE)
+		tmp = MAXPHASE;
+	if (tmp < -MAXPHASE)
+		tmp = -MAXPHASE;
+
+	ntp_offset = tmp << SHIFT_UPDATE;
+
+    if ((ntp_status & STA_FREQHOLD) || (ntp_reftime == 0))
+		ntp_reftime = tv.tv_sec;
+
+	/* calculate seconds since last call to hardupdate */
+	interval = tv.tv_sec - ntp_reftime;
+	ntp_reftime = tv.tv_sec;
+
+	if ((ntp_status & STA_FLL) && (interval >= MINSEC)) {
+		long damping;
+		tmp = (offset / interval); /* ppm (usec/sec)*/
+
+		/* convert to shifted ppm, then apply damping factor */
+
+		/* calculate damping factor - XXX bigger comment!*/
+		damping = SHIFT_KH - SHIFT_USEC;
+
+		/* apply damping factor */
+		ntp_freq += shiftR(tmp,damping);
+
+		printk("ntp->freq change: %ld\n",shiftR(tmp,damping));
+
+	} else if ((ntp_status & STA_PLL) && (interval < MAXSEC)) {
+		long damping;
+		tmp = offset * interval; /* ppm XXX - not quite*/
+
+		/* calculate damping factor - XXX bigger comment!*/
+		damping = (2 * ntp_constant) + SHIFT_KF - SHIFT_USEC;
+
+		/* apply damping factor */
+		ntp_freq += shiftR(tmp,damping);
+
+		printk("ntp->freq change: %ld\n", shiftR(tmp,damping));
+
+	} else { /* interval out of bounds */
+		printk("interval out of bounds: %ld\n", interval);
+		ret = -1; /* TIME_ERROR */
+	}
+
+	/* bound ntp_freq */
+	if (ntp_freq > ntp_tolerance)
+		ntp_freq = ntp_tolerance;
+	if (ntp_freq < -ntp_tolerance)
+		ntp_freq = -ntp_tolerance;
+
+	return ret;
+}
+
+/* int ntp_adjtimex(struct timex* tx)
+ *	Interface to change NTP state machine
+ */
+int ntp_adjtimex(struct timex* tx)
+{
+	long save_offset;
+	int result;
+	unsigned long flags;
+
+/*=[Sanity checking]===============================*/
+	/* Check capabilities if we're trying to modify something */
+	if (tx->modes && !capable(CAP_SYS_TIME))
+		return -EPERM;
+
+	/* frequency adjustment limited to +/- MAXFREQ */
+	if ((tx->modes & ADJ_FREQUENCY)
+			&& (abs(tx->freq) > MAXFREQ))
+		return -EINVAL;
+
+	/* maxerror adjustment limited to NTP_PHASE_LIMIT */
+	if ((tx->modes & ADJ_MAXERROR)
+			&& (tx->maxerror < 0
+				|| tx->maxerror >= NTP_PHASE_LIMIT))
+		return -EINVAL;
+
+	/* esterror adjustment limited to NTP_PHASE_LIMIT */
+	if ((tx->modes & ADJ_ESTERROR)
+			&& (tx->esterror < 0
+				|| tx->esterror >= NTP_PHASE_LIMIT))
+		return -EINVAL;
+
+	/* constant adjustment must be positive */
+	if ((tx->modes & ADJ_TIMECONST)
+			&& (tx->constant < 0))
+		return -EINVAL;
+
+	/* Single shot mode can only be used by itself */
+	if (((tx->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
+			&& (tx->modes != ADJ_OFFSET_SINGLESHOT))
+		return -EINVAL;
+
+	/* offset adjustment limited to +/- MAXPHASE */
+	if ((tx->modes != ADJ_OFFSET_SINGLESHOT)
+			&& (tx->modes & ADJ_OFFSET)
+			&& (abs(tx->offset)>= MAXPHASE))
+		return -EINVAL;
+
+	/* tick adjustment limited to 10% */
+	if ((tx->modes & ADJ_TICK)
+			&& ((tx->tick < 900000/USER_HZ)
+				||(tx->tick > 11000000/USER_HZ)))
+		return -EINVAL;
+
+	/* dbg output XXX - yank me! */
+	if(tx->modes) {
+		printk("adjtimex: tx->offset: %ld    tx->freq: %ld\n",
+				tx->offset, tx->freq);
+	}
+
+/*=[Kernel input bits]==========================*/
+	write_seqlock_irqsave(&ntp_lock, flags);
+
+	result = ntp_state;
+
+	/* For ADJ_OFFSET_SINGLESHOT we must return the old offset */
+	save_offset = shiftR(ntp_offset, SHIFT_UPDATE);
+
+	/* Process input parameters */
+	if (tx->modes & ADJ_STATUS) {
+		ntp_status &=  STA_RONLY;
+		ntp_status |= tx->status & ~STA_RONLY;
+	}
+
+	if (tx->modes & ADJ_FREQUENCY)
+		ntp_freq = tx->freq;
+
+	if (tx->modes & ADJ_MAXERROR)
+		ntp_maxerror = tx->maxerror;
+
+	if (tx->modes & ADJ_ESTERROR)
+		ntp_esterror = tx->esterror;
+
+	if (tx->modes & ADJ_TIMECONST)
+		ntp_constant = tx->constant;
+
+	if (tx->modes & ADJ_OFFSET) {
+		if (tx->modes == ADJ_OFFSET_SINGLESHOT) {
+			if (tx->offset < 0)
+				singleshot_adj = -MAX_SINGLESHOT_ADJ;
+			else
+				singleshot_adj = MAX_SINGLESHOT_ADJ;
+			/* Calculate single shot offset interval:
+			 *
+			 *	len = offset/(+/-)MAX_SINGESHOT_ADJ
+			 *	len = abs(offset)/MAX_SINGESHOT_ADJ
+			 *	len = (abs(offset)*NSEC_PER_USEC)
+			 *			/(MAX_SINGESHOT_ADJ /NSEC_PER_SEC)
+			 *	len = (abs(offset)*NSEC_PER_USEC*NSEC_PER_SEC)/MAX_SINGESHOT_ADJ
+			 *	len = abs(offset)*NSEC_PER_SEC*(NSEC_PER_USEC/MAX_SINGESHOT_ADJ)
+			 */
+			ss_offset_len = abs(tx->offset);
+			ss_offset_len *= NSEC_PER_SEC * (NSEC_PER_USEC/MAX_SINGLESHOT_ADJ);
+		}
+		/* call hardupdate() */
+		if (ntp_hardupdate(tx->offset, tx->time))
+			result = TIME_ERROR;
+	}
+
+	if (tx->modes & ADJ_TICK) {
+		/* first calculate usec/user_tick offset */
+		tick_adj = (USEC_PER_SEC/USER_HZ) - tx->tick;
+		/* multiply by user_hz to get usec/sec => ppm */
+		tick_adj *= USER_HZ;
+		/* save tx->tick for future calls to adjtimex */
+		ntp_tick = tx->tick;
+	}
+
+	if ((ntp_status & (STA_UNSYNC|STA_CLOCKERR)) != 0 )
+		result = TIME_ERROR;
+
+/*=[Kernel output bits]================================*/
+	/* write kernel state to user timex values*/
+	if ((tx->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
+		tx->offset = save_offset;
+	else
+		tx->offset = shiftR(ntp_offset, SHIFT_UPDATE);
+
+	tx->freq = ntp_freq;
+	tx->maxerror = ntp_maxerror;
+	tx->esterror = ntp_esterror;
+	tx->status = ntp_status;
+	tx->constant = ntp_constant;
+	tx->precision = ntp_precision;
+	tx->tolerance = ntp_tolerance;
+
+	/* PPS is not implemented, so these are zero */
+	tx->ppsfreq	= /*XXX - Not Implemented!*/ 0;
+	tx->jitter	= /*XXX - Not Implemented!*/ 0;
+	tx->shift	= /*XXX - Not Implemented!*/ 0;
+	tx->stabil	= /*XXX - Not Implemented!*/ 0;
+	tx->jitcnt	= /*XXX - Not Implemented!*/ 0;
+	tx->calcnt	= /*XXX - Not Implemented!*/ 0;
+	tx->errcnt	= /*XXX - Not Implemented!*/ 0;
+	tx->stbcnt	= /*XXX - Not Implemented!*/ 0;
+
+	write_sequnlock_irqrestore(&ntp_lock, flags);
+
+	return result;
+}
+
+
+/* void ntp_leapsecond(struct timespec now):
+ *	NTP Leapsecnod processing code. Returns the number of
+ *	seconds (-1, 0, or 1) that should be added to the current
+ *	time to properly adjust for leapseconds.
+ */
+int ntp_leapsecond(struct timespec now)
+{
+	/*
+	 * Leap second processing. If in leap-insert state at
+	 * the end of the day, the system clock is set back one
+	 * second; if in leap-delete state, the system clock is
+	 * set ahead one second.
+	 */
+	static time_t leaptime = 0;
+
+	switch (ntp_state) {
+	case TIME_OK:
+		if (ntp_status & STA_INS) {
+			ntp_state = TIME_INS;
+			/* calculate end of today (23:59:59)*/
+			leaptime = now.tv_sec + SEC_PER_DAY - (now.tv_sec % SEC_PER_DAY) - 1;
+		}
+		else if (ntp_status & STA_DEL) {
+			ntp_state = TIME_DEL;
+			/* calculate end of today (23:59:59)*/
+			leaptime = now.tv_sec + SEC_PER_DAY - (now.tv_sec % SEC_PER_DAY) - 1;
+		}
+		break;
+
+	case TIME_INS:
+		/* Once we are at (or past) leaptime, insert the second */
+		if (now.tv_sec > leaptime) {
+			ntp_state = TIME_OOP;
+			printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");
+
+			return -1;
+		}
+		break;
+
+	case TIME_DEL:
+		/* Once we are at (or past) leaptime, delete the second */
+		if (now.tv_sec >= leaptime) {
+			ntp_state = TIME_WAIT;
+			printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");
+
+			return 1;
+		}
+		break;
+
+	case TIME_OOP:
+		/*  Wait for the end of the leap second*/
+		if (now.tv_sec > (leaptime + 1))
+			ntp_state = TIME_WAIT;
+		break;
+
+	case TIME_WAIT:
+		if (!(ntp_status & (STA_INS | STA_DEL)))
+			ntp_state = TIME_OK;
+	}
+
+	return 0;
+}
+
+/* void ntp_clear(void):
+ *	Clears the NTP state machine.
+ */
+void ntp_clear(void)
+{
+	unsigned long flags;
+	write_seqlock_irqsave(&ntp_lock, flags);
+
+	/* clear everything */
+	ntp_status |= STA_UNSYNC;
+	ntp_maxerror = NTP_PHASE_LIMIT;
+	ntp_esterror = NTP_PHASE_LIMIT;
+	ss_offset_len=0;
+	singleshot_adj=0;
+	tick_adj=0;
+	offset_adj =0;
+
+	write_sequnlock_irqrestore(&ntp_lock, flags);
+}
+
+/* int get_ntp_status(void):
+ *  Returns the NTP status.
+ */
+int get_ntp_status(void)
+{
+	return ntp_status;
+}
+
diff -Nru a/kernel/time.c b/kernel/time.c
--- a/kernel/time.c	2005-01-24 13:30:06 -08:00
+++ b/kernel/time.c	2005-01-24 13:30:06 -08:00
@@ -37,6 +37,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
+#include <linux/timeofday.h>
 
 /* 
  * The timezone where the local system is located.  Used as a default by some
@@ -218,6 +219,7 @@
 /* adjtimex mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
+#ifndef CONFIG_NEWTOD
 int do_adjtimex(struct timex *txc)
 {
         long ltemp, mtemp, save_adjust;
@@ -400,6 +402,7 @@
 	do_gettimeofday(&txc->time);
 	return(result);
 }
+#endif
 
 asmlinkage long sys_adjtimex(struct timex __user *txc_p)
 {
diff -Nru a/kernel/timeofday.c b/kernel/timeofday.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/kernel/timeofday.c	2005-01-24 13:30:06 -08:00
@@ -0,0 +1,436 @@
+/*********************************************************************
+* linux/kernel/timeofday.c
+*
+* Copyright (C) 2003, 2004 IBM, John Stultz (johnstul@us.ibm.com)
+*
+* This file contains the functions which access and manage
+* the system's time of day functionality.
+*
+* Revision History:
+* 2004-09-02:	A0
+*	o First pass sent to lkml for review.
+* 2004-12-07:	A1
+*	o Rework of timesource structure
+*	o Sent to lkml for review
+*
+* TODO List:
+*	o More testing
+**********************************************************************/
+
+#include <linux/timeofday.h>
+#include <linux/timesource.h>
+#include <linux/ntp.h>
+#include <linux/timex.h>
+
+/*XXX - remove later */
+#define TIME_DBG 1
+#define TIME_DBG_FREQ 120000
+
+/*[Nanosecond based variables]----------------
+ * system_time:
+ *	Monotonically increasing counter of the number of nanoseconds
+ *	since boot.
+ * wall_time_offset:
+ *	Offset added to system_time to provide accurate time-of-day
+ */
+static nsec_t system_time;
+static nsec_t wall_time_offset;
+
+
+/*[Cycle based variables]----------------
+ * offset_base:
+ *	Value of the timesource at the last clock_interrupt_hook()
+ *	(adjusted only minorly to account for rounded off cycles)
+ */
+static cycle_t offset_base;
+
+/*[Time source data]-------------------
+ * timesource:
+ *	current timesource pointer
+ */
+static struct timesource_t *timesource;
+
+/*[Locks]----------------------------
+ * system_time_lock:
+ *	generic lock for all locally scoped time values
+ */
+static seqlock_t system_time_lock = SEQLOCK_UNLOCKED;
+
+
+/*[Suspend/Resume info]-------------------
+ * time_suspend_state:
+ *		variable that keeps track of suspend state
+ * suspend_start:
+ *		start of the suspend call
+ */
+static enum { TIME_RUNNING, TIME_SUSPENDED } time_suspend_state = TIME_RUNNING;
+static nsec_t suspend_start;
+
+
+/* [XXX - Hacks]--------------------
+ *	Makes stuff compile
+ */
+extern nsec_t read_persistent_clock(void);
+extern void sync_persistent_clock(struct timespec ts);
+
+
+/* get_lowres_timestamp():
+ *		Returns a low res timestamp.
+ *		(ie: the value of system_time as  calculated at
+ *			the last invocation of clock_interrupt_hook() )
+ */
+nsec_t get_lowres_timestamp(void)
+{
+	nsec_t ret;
+	unsigned long seq;
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		/* quickly grab system_time*/
+		ret = system_time;
+
+	} while (read_seqretry(&system_time_lock, seq));
+
+	return ret;
+}
+
+
+/* get_lowres_timeofday():
+ *		Returns a low res time of day, as calculated at the
+ *		last invocation of clock_interrupt_hook()
+ */
+nsec_t get_lowres_timeofday(void)
+{
+	nsec_t ret;
+	unsigned long seq;
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		/* quickly calculate low-res time of day */
+		ret = system_time + wall_time_offset;
+
+	} while (read_seqretry(&system_time_lock, seq));
+
+	return ret;
+}
+
+
+/* __monotonic_clock():
+ *		private function, must hold system_time_lock lock when being
+ *		called. Returns the monotonically increasing number of
+ *		nanoseconds	since the system booted (adjusted by NTP scaling)
+ */
+static nsec_t __monotonic_clock(void)
+{
+	nsec_t ret, ns_offset;
+	cycle_t now, delta;
+
+	/* read timesource */
+	now = read_timesource(timesource);
+
+	/* calculate the delta since the last clock_interrupt */
+	delta = (now - offset_base) & timesource->mask;
+
+	/* convert to nanoseconds */
+	ns_offset = cyc2ns(timesource, delta, NULL);
+
+	/* apply the NTP scaling */
+	ns_offset = ntp_scale(ns_offset);
+
+	/* add result to system time */
+	ret = system_time + ns_offset;
+
+	return ret;
+}
+
+
+/* do_monotonic_clock():
+ *		Returns the monotonically increasing number of nanoseconds
+ *		since the system booted via __monotonic_clock()
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
+/* do_gettimeofday():
+ *		Returns the time of day
+ */
+void do_gettimeofday(struct timeval *tv)
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
+	/* add them and convert to timeval */
+	*tv = ns2timeval(wall+sys);
+}
+
+
+/* do_settimeofday():
+ *		Sets the time of day
+ */
+int do_settimeofday(struct timespec *tv)
+{
+	unsigned long flags;
+	/* convert timespec to ns */
+	nsec_t newtime = timespec2ns(tv);
+
+	/* atomically adjust wall_time_offset to the desired value */
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	wall_time_offset = newtime - __monotonic_clock();
+
+	/* clear NTP settings */
+	ntp_clear();
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+
+	return 0;
+}
+
+
+/* do_adjtimex:
+ *		Userspace NTP daemon's interface to the kernel NTP variables
+ */
+int do_adjtimex(struct timex *tx)
+{
+	do_gettimeofday(&tx->time); /* set timex->time*/
+								/* Note: We set tx->time first, */
+								/* because ntp_adjtimex uses it */
+
+	return ntp_adjtimex(tx);			/* call out to NTP code */
+}
+
+
+/* timeofday_suspend_hook():
+ *		This function allows the timeofday subsystem to
+ *		be shutdown for a period of time. Usefull when
+ *		going into suspend/hibernate mode. The code is
+ *		very similar to the first half of
+ *		timeofday_interrupt_hook().
+ */
+void timeofday_suspend_hook(void)
+{
+	cycle_t now, delta;
+	nsec_t ns, ntp_ns;
+	unsigned long flags;
+
+	write_seqlock_irqsave(&system_time_lock, flags);
+	if (time_suspend_state != TIME_RUNNING) {
+		printk("timeofday_suspend_hook: ACK! called while we're suspended!");
+		goto out;
+	}
+
+	/* First off, save suspend start time
+	 * then quickly read the time source.
+	 * These two calls hopefully occur quickly
+	 * because the difference will accumulate as
+	 * time drift on resume.
+	 */
+	suspend_start = read_persistent_clock();
+	now = read_timesource(timesource);
+
+	/* much like the first half of timeofday_interrupt_hook,
+	 * accumulate the current offset into system_time
+	 */
+	delta = (now - offset_base) & timesource->mask;
+	ns = cyc2ns(timesource, delta, NULL);
+	ntp_ns = ntp_scale(ns);
+	system_time += ntp_ns;
+
+	/* switch states */
+	time_suspend_state = TIME_SUSPENDED;
+
+out:
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+}
+
+
+/* timeofday_resume_hook():
+ *		This function resumes the timeofday subsystem
+ *		from a previous call to timeofday_suspend_hook.
+ */
+void timeofday_resume_hook(void)
+{
+	nsec_t now, suspend_time;
+	unsigned long flags;
+
+	write_seqlock_irqsave(&system_time_lock, flags);
+	if (time_suspend_state != TIME_SUSPENDED) {
+		printk("timeofday_resume_hook: ACK! called while we're not suspended!");
+		goto out;
+	}
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
+	/* calculate how long we were out for */
+	suspend_time = now - suspend_start;
+
+	/* update system_time */
+	system_time += suspend_time;
+
+	/* reset NTP state machine */
+	ntp_clear();
+
+	/* Set us back to running */
+	time_suspend_state = TIME_RUNNING;
+
+
+	/* finally, update legacy time values */
+	write_seqlock_irqsave(&xtime_lock, flags);
+	xtime = ns2timespec(system_time + wall_time_offset);
+	wall_to_monotonic = ns2timespec(wall_time_offset);
+	wall_to_monotonic.tv_sec = -wall_to_monotonic.tv_sec;
+	wall_to_monotonic.tv_nsec = -wall_to_monotonic.tv_nsec;
+	/* XXX - should jiffies be updated here? */
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+out:
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+}
+
+
+/* timeofday_interrupt_hook:
+ *		calculates the delta since the last interrupt,
+ *		updates system time and clears the offset.
+ *		likely called by timer_interrupt()
+ */
+void timeofday_interrupt_hook(void)
+{
+	cycle_t now, delta, remainder;
+	nsec_t ns, ntp_ns;
+	long leapsecond;
+	struct timesource_t* next;
+	unsigned long flags;
+
+	write_seqlock(&system_time_lock);
+
+	/* read time source */
+	now = read_timesource(timesource);
+
+	/* calculate cycle delta */
+	delta = (now - offset_base) & timesource->mask;
+
+	/* convert cycles to ns  and save remainder */
+	ns = cyc2ns(timesource, delta, &remainder);
+
+	/* apply NTP scaling factor for this tick */
+	ntp_ns = ntp_scale(ns);
+
+#if TIME_DBG /* XXX - remove later*/
+{
+	static int dbg=0;
+	if(!(dbg++%TIME_DBG_FREQ)){
+		printk("now: %lluc - then: %lluc = delta: %lluc -> %llu ns + %llu cyc (ntp: %lluc)\n",
+			(unsigned long long)now, (unsigned long long)offset_base,
+			(unsigned long long)delta, (unsigned long long)ns,
+			(unsigned long long)remainder, (unsigned long long)ntp_ns);
+	}
+}
+#endif
+	/* update system_time */
+	system_time += ntp_ns;
+
+	/* reset the offset_base */
+	offset_base = now;
+
+	/* subtract remainder to account for rounded off cycles */
+	offset_base = (offset_base - remainder) & timesource->mask;
+
+	/* advance the ntp state machine by ns*/
+	ntp_advance(ns);
+
+	/* do ntp leap second processing*/
+	leapsecond = ntp_leapsecond(ns2timespec(system_time+wall_time_offset));
+	wall_time_offset += leapsecond * NSEC_PER_SEC;
+
+	/* sync the persistent clock */
+	if (!(get_ntp_status() & STA_UNSYNC))
+		sync_persistent_clock(ns2timespec(system_time + wall_time_offset));
+
+	/* if necessary, switch timesources */
+	next = get_next_timesource();
+	if (next != timesource) {
+		/* immediately set new offset_base */
+		offset_base = read_timesource(next);
+		/* swap timesources */
+		timesource = next;
+		printk(KERN_INFO "Time: %s timesource has been installed\n",
+					timesource->name);
+	}
+
+	/* now is a safe time, so allow timesource to adjust
+	 * itself (for example: to make cpufreq changes).
+	 */
+	if(timesource->update_callback)
+		timesource->update_callback();
+
+	/* update legacy time values */
+	write_seqlock_irqsave(&xtime_lock, flags);
+	xtime = ns2timespec(system_time + wall_time_offset);
+	wall_to_monotonic = ns2timespec(wall_time_offset);
+	wall_to_monotonic.tv_sec = -wall_to_monotonic.tv_sec;
+	wall_to_monotonic.tv_nsec = -wall_to_monotonic.tv_nsec;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	write_sequnlock(&system_time_lock);
+}
+
+
+/* timeofday_init():
+ *		Initializes time variables
+ */
+void timeofday_init(void)
+{
+	unsigned long flags;
+#if TIME_DBG
+	printk("timeofday_init: Starting up!\n");
+#endif
+	write_seqlock_irqsave(&system_time_lock, flags);
+
+	/* initialize the timesource variable */
+	timesource = get_next_timesource();
+
+	/* clear and initialize offsets*/
+	offset_base = read_timesource(timesource);
+	wall_time_offset = read_persistent_clock();
+
+	/* clear NTP scaling factor*/
+	ntp_clear();
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+
+#if TIME_DBG
+	printk("timeofday_init: finished!\n");
+#endif
+	return;
+}
diff -Nru a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	2005-01-24 13:30:06 -08:00
+++ b/kernel/timer.c	2005-01-24 13:30:06 -08:00
@@ -575,6 +575,7 @@
 int tickadj = 500/HZ ? : 1;		/* microsecs */
 
 
+#ifndef CONFIG_NEWTOD
 /*
  * phase-lock loop variables
  */
@@ -805,6 +806,9 @@
 		}
 	} while (ticks);
 }
+#else /* CONFIG_NEWTOD */
+#define update_wall_time(x)
+#endif /* CONFIG_NEWTOD */
 
 /*
  * Called from the timer interrupt handler to charge one tick to the current 
diff -Nru a/kernel/timesource.c b/kernel/timesource.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/kernel/timesource.c	2005-01-24 13:30:06 -08:00
@@ -0,0 +1,71 @@
+/*********************************************************************
+* linux/kernel/timesource.c
+*
+* Copyright (C) 2004 IBM, John Stultz (johnstul@us.ibm.com)
+*
+* This file contains the functions which manage
+* timesource drivers.
+*
+* Revision History:
+* 2004-12-07:	A1
+*	o Rework of timesource structure
+*	o Sent to lkml for review
+*
+* TODO List:
+*	o Allow timesource drivers to be registered and unregistered
+*	o Keep list of all currently registered timesources
+*	o Use "clock=xyz" boot option for selection overrides.
+*	o sysfs interface for manually choosing timesources
+*	o get rid of timesource_jiffies extern
+**********************************************************************/
+
+#include <linux/timesource.h>
+
+/*[Timesource internal variables]---------
+ * curr_timesource:
+ *	currently selected timesource. Initialized to timesource_jiffies.
+ * next_timesource:
+ *	pending next selected timesource.
+ * timesource_lock:
+ *	protects manipulations to curr_timesource and next_timesource
+ */
+/* XXX - Need to have a better way for initializing curr_timesource */
+extern struct timesource_t timesource_jiffies;
+static struct timesource_t *curr_timesource = &timesource_jiffies;
+static struct timesource_t *next_timesource;
+static seqlock_t timesource_lock = SEQLOCK_UNLOCKED;
+
+
+/* register_timesource():
+ *		Used to install a new timesource
+ */
+void register_timesource(struct timesource_t* t)
+{
+	write_seqlock(&timesource_lock);
+
+	/* XXX - check override */
+
+	/* if next_timesource has been set, make sure we beat that one too */
+	if (next_timesource) {
+		if (t->priority > next_timesource->priority)
+			next_timesource = t;
+	} else if(t->priority > curr_timesource->priority)
+		next_timesource = t;
+
+	write_sequnlock(&timesource_lock);
+}
+
+/* get_next_timesource():
+ *		Returns the selected timesource
+ */
+struct timesource_t* get_next_timesource(void)
+{
+	write_seqlock(&timesource_lock);
+	if (next_timesource) {
+		curr_timesource = next_timesource;
+		next_timesource = NULL;
+	}
+	write_sequnlock(&timesource_lock);
+
+	return curr_timesource;
+}


