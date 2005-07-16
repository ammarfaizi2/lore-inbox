Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262169AbVGPD35@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbVGPD35 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263108AbVGPD1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 23:27:09 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:21164 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262185AbVGPDZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 23:25:48 -0400
Subject: [RFC][PATCH 1/6] new timeofday core subsystem
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>, frank@tuxrocks.com,
       benh@kernel.crashing.org, Nishanth Aravamudan <nacc@us.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 20:25:26 -0700
Message-Id: <1121484326.28999.3.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

	I've been busy splitting out the NTP changes from the core timeofday
patch, in order to reduce the patch size and avoid any features vs
cleanups confusion. Hopefully this will lead to a more productive
discussion of the proposed changes.

However with OLS upon us, I figured I resend this out to just sync up
with others who have been testing my patches. Unfortunately it is still
a fairly large chunk of code, but I do intend to split this up more and
address the 64bit issues brought up the last time I sent this out. But
this will have to do for now since I'll unlikely be sending any patches
next week.

In the rush in preparing for OLS I really haven't had a chance to test
this beyond compiling it, so tread lightly. 

Now that that is out of the way, here is the patch:

With the goal to simplify, streamline and consolidate the time-of-day
infrastructure, I propose the following common implementation across all
arches. This will allow generic bugs to be fixed once, reduce code
duplication, and with many architectures sharing the same time source,
this allows drivers to be written once for multiple architectures.
Additionally it will better delineate the lines between the soft-timer
subsystem and the time-of-day subsystem, opening the door for more
flexible and better soft-timer management. 

Features of this design:
========================

o Splits time of day management from timer interrupts
o Consolidates a large amount of code
o Generic algorithms which use time-source drivers chosen at runtime
o More consistent and readable code

For another description on the rework, see here:
http://lwn.net/Articles/120850/ (Many thanks to the LWN team for that
easy to understand writeup!)

This patch implements the architecture independent portion of the new
time of day subsystem. Included below is timeofday.c (which includes all
the time of day management and accessor functions), timesource.c (for
timesource specific management functions), interface definition .h
files, the example jiffies timesource (lowest common denominator time
source, mainly for use as example code) and minimal hooks into arch
independent code.

This patch applies ontop of my timeofday-ntp cleanup patchset.

The patch does nothing without at least minimal architecture specific
hooks (i386, x86-64 and other architecture examples to follow), and it
should be able to be applied to a tree without affecting the existing
code.

Finally I'd like to thank the following people who have contributed
ideas, criticism, testing and code that has helped shape this work:

	George Anzinger, Nish Aravamudan, Max Asbock, Dominik Brodowski, Darren
Hart, Christoph Lameter, Matt Mackal, Keith Mannthey, Martin
Schwidefsky, Frank Sorenson, Ulrich Windl, Darrick Wong, Roman Zippel
and any others whom I've accidentally forgotten.


thanks
-john


linux-2.6.13-rc3_timeofday-core_B4.patch
============================================
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -52,6 +52,7 @@ restrictions referred to are that the re
 	MTD	MTD support is enabled.
 	NET	Appropriate network support is enabled.
 	NUMA	NUMA support is enabled.
+	NEW_TOD The new timeofday code is enabled.
 	NFS	Appropriate NFS support is enabled.
 	OSS	OSS sound support is enabled.
 	PARIDE	The ParIDE subsystem is enabled.
@@ -309,7 +310,7 @@ running once the system is up.
 			Default value is set via a kernel config option.
 			Value can be changed at runtime via /selinux/checkreqprot.
  
- 	clock=		[BUGS=IA-32, HW] gettimeofday timesource override. 
+ 	clock=		[BUGS=IA-32, HW] gettimeofday timesource override. [Deprecated]
 			Forces specified timesource (if avaliable) to be used
 			when calculating gettimeofday(). If specicified timesource
 			is not avalible, it defaults to PIT. 
@@ -1442,6 +1443,10 @@ running once the system is up.
 
 	time		Show timing data prefixed to each printk message line
 
+	timesource=		[NEW_TOD] Override the default timesource
+			Override the default timesource and use the timesource
+			with the name specified.
+
 	tipar.timeout=	[HW,PPT]
 			Set communications timeout in tenths of a second
 			(default 15).
diff --git a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -65,3 +65,4 @@ obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-$(CONFIG_SGI_IOC4)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
+obj-$(CONFIG_NEWTOD)		+= timesource/
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
+#ifndef CONFIG_NEWTOD
 extern unsigned long long monotonic_clock(void);
 #else
+#define monotonic_clock() do_monotonic_clock()
+#endif
+#else
 static inline unsigned long long monotonic_clock(void)
 {
 # ifdef __s390__
diff --git a/drivers/timesource/Makefile b/drivers/timesource/Makefile
new file mode 100644
--- /dev/null
+++ b/drivers/timesource/Makefile
@@ -0,0 +1 @@
+obj-y += jiffies.o
diff --git a/drivers/timesource/jiffies.c b/drivers/timesource/jiffies.c
new file mode 100644
--- /dev/null
+++ b/drivers/timesource/jiffies.c
@@ -0,0 +1,69 @@
+/***********************************************************************
+* linux/drivers/timesource/jiffies.c
+*
+* This file contains the jiffies based time source.
+*
+* Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
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
+************************************************************************/
+#include <linux/timesource.h>
+#include <linux/jiffies.h>
+#include <linux/init.h>
+
+/* The Jiffies based timesource is the lowest common
+ * denominator time source which should function on
+ * all systems. It has the same coarse resolution as
+ * the timer interrupt frequency HZ and it suffers
+ * inaccuracies caused by missed or lost timer
+ * interrupts and the inability for the timer
+ * interrupt hardware to accuratly tick at the
+ * requested HZ value. It is also not reccomended
+ * for "tick-less" systems.
+ */
+#define NSEC_PER_JIFFY ((u32)((((u64)NSEC_PER_SEC)<<8)/ACTHZ))
+
+/* Since jiffies uses a simple NSEC_PER_JIFFY multiplier
+ * conversion, the .shift value could be zero. However
+ * this would make NTP adjustments impossible as they are
+ * in units of 1/2^.shift. Thus we use JIFFIES_SHIFT to
+ * shift both the nominator and denominator the same
+ * amount, and give ntp adjustments in units of 1/2^10
+ */
+#define JIFFIES_SHIFT 10
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
+	.mask = (cycle_t)-1,
+	.mult = NSEC_PER_JIFFY << JIFFIES_SHIFT, /* See above for details */
+	.shift = JIFFIES_SHIFT,
+};
+
+static int __init init_jiffies_timesource(void)
+{
+	register_timesource(&timesource_jiffies);
+	return 0;
+}
+module_init(init_jiffies_timesource);
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
+#ifdef CONFIG_NEWTOD
+
+/* Required externs */
+extern nsec_t read_persistent_clock(void);
+extern void sync_persistent_clock(struct timespec ts);
+
+#ifdef CONFIG_NEWTOD_VSYSCALL
+extern void arch_update_vsyscall_gtod(nsec_t wall_time, cycle_t offset_base,
+				struct timesource_t* timesource, int ntp_adj);
+#else
+#define arch_update_vsyscall_gtod(x,y,z,w) {}
+#endif /* CONFIG_NEWTOD_VSYSCALL */
+
+#endif /* CONFIG_NEWTOD */
+#endif
diff --git a/include/linux/ntp.h b/include/linux/ntp.h
--- a/include/linux/ntp.h
+++ b/include/linux/ntp.h
@@ -9,9 +9,6 @@
 #include <linux/time.h>
 #include <linux/timex.h>
 
-/* Required to safely shift negative values */
-#define shiftR(x,s) (x < 0) ? (-((-x) >> (s))) : ((x) >> (s))
-
 /* NTP state machine interfaces */
 void ntp_advance(unsigned long interval_nsec);
 int ntp_adjtimex(struct timex*);
@@ -20,8 +17,4 @@ void ntp_clear(void);
 int ntp_synced(void);
 long ntp_get_adjustment(void);
 
-/* these variables cannot be made static just yet */
-extern int tickadj;
-extern long ntp_adjtime_offset;
-
 #endif
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
@@ -0,0 +1,59 @@
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
+#ifdef CONFIG_NEWTOD
+/* Public definitions */
+extern nsec_t get_lowres_timestamp(void);
+extern nsec_t get_lowres_timeofday(void);
+extern nsec_t do_monotonic_clock(void);
+
+extern void do_gettimeofday(struct timeval *tv);
+extern void getnstimeofday(struct timespec *ts);
+extern int do_settimeofday(struct timespec *tv);
+extern int do_adjtimex(struct timex *tx);
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
+#else /* CONFIG_NEWTOD */
+#define timeofday_init()
+#endif /* CONFIG_NEWTOD */
+#endif /* _LINUX_TIMEOFDAY_H */
diff --git a/include/linux/timesource.h b/include/linux/timesource.h
new file mode 100644
--- /dev/null
+++ b/include/linux/timesource.h
@@ -0,0 +1,172 @@
+/*  linux/include/linux/timesource.h
+ *
+ *  This file contains the structure definitions for timesources.
+ *
+ *  If you are not a timesource, or the time of day code, you should
+ *  not be including this file!
+ */
+#ifndef _LINUX_TIMESOURCE_H
+#define _LINUX_TIMESOURCE_H
+
+#include <linux/types.h>
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <asm/io.h>
+#include <asm/div64.h>
+
+/* struct timesource_t:
+ *      Provides mostly state-free accessors to the underlying hardware.
+ *
+ * name:                ptr to timesource name
+ * priority:            priority value for selection (higher is better)
+ *                      To avoid priority inflation the following
+ *                      list should give you a guide as to how
+ *                      to assign your timesource a priority
+ *                      1-99: Unfit for real use
+ *                          Only available for bootup and testing purposes.
+ *                      100-199: Base level usability.
+ *                          Functional for real use, but not desired.
+ *                      200-299: Good.
+ *                           A correct and usable timesource.
+ *                      300-399: Desired.
+ *                           A reasonably fast and accurate timesource.
+ *                      400-499: Perfect
+ *                           The ideal timesource. A must-use where available.
+ * type:                defines timesource type
+ * @read_fnct:          returns a cycle value
+ * ptr:                 ptr to MMIO'ed counter
+ * mask:                bitmask for two's complement
+ *                      subtraction of non 64 bit counters
+ * mult:                cycle to nanosecond multiplier
+ * shift:               cycle to nanosecond divisor (power of two)
+ * @update_callback:    called when safe to alter timesource values
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
+	void __iomem *mmio_ptr;
+	cycle_t mask;
+	u32 mult;
+	u32 shift;
+	void (*update_callback)(void);
+};
+
+
+/* Helper functions that converts a khz counter
+ * frequency to a timsource multiplier, given the
+ * timesource shift value
+ */
+static inline u32 timesource_khz2mult(u32 khz, u32 shift_constant)
+{
+	/*  khz = cyc/(Million ns)
+	 *  mult/2^shift  = ns/cyc
+	 *  mult = ns/cyc * 2^shift
+	 *  mult = 1Million/khz * 2^shift
+	 *  mult = 1000000 * 2^shift / khz
+	 *  mult = (1000000<<shift) / khz
+	 */
+	u64 tmp = ((u64)1000000) << shift_constant;
+	tmp += khz/2; /* round for do_div */
+	do_div(tmp, khz);
+	return (u32)tmp;
+}
+
+/* Helper functions that converts a hz counter
+ * frequency to a timsource multiplier, given the
+ * timesource shift value
+ */
+static inline u32 timesource_hz2mult(u32 hz, u32 shift_constant)
+{
+	/*  hz = cyc/(Billion ns)
+	 *  mult/2^shift  = ns/cyc
+	 *  mult = ns/cyc * 2^shift
+	 *  mult = 1Billion/hz * 2^shift
+	 *  mult = 1000000000 * 2^shift / hz
+	 *  mult = (1000000000<<shift) / hz
+	 */
+	u64 tmp = ((u64)1000000000) << shift_constant;
+	tmp += hz/2; /* round for do_div */
+	do_div(tmp, hz);
+	return (u32)tmp;
+}
+
+
+#ifndef readq
+/* Provide an a way to atomically read a u64 on a 32bit arch */
+static inline unsigned long long timesource_readq(void __iomem *addr)
+{
+	u32 low, high;
+	/* loop is required to make sure we get an atomic read */
+	do {
+		high = readl(addr+4);
+		low = readl(addr);
+	} while (high != readl(addr+4));
+
+	return low | (((unsigned long long)high) << 32LL);
+}
+#else
+#define timesource_readq(x) readq(x)
+#endif
+
+
+/* read_timesource():
+ *      Uses the timesource to return the current cycle_t value
+ */
+static inline cycle_t read_timesource(struct timesource_t *ts)
+{
+	switch (ts->type) {
+	case TIMESOURCE_MMIO_32:
+		return (cycle_t)readl(ts->mmio_ptr);
+	case TIMESOURCE_MMIO_64:
+		return (cycle_t)timesource_readq(ts->mmio_ptr);
+	case TIMESOURCE_CYCLES:
+		return (cycle_t)get_cycles();
+	default:/* case: TIMESOURCE_FUNCTION */
+		return ts->read_fnct();
+	}
+}
+
+/* cyc2ns():
+ *      Uses the timesource and ntp ajdustment interval to
+ *      convert cycle_ts to nanoseconds.
+ */
+static inline nsec_t cyc2ns(struct timesource_t *ts, int ntp_adj, cycle_t cycles)
+{
+	u64 ret;
+	ret = (u64)cycles;
+	ret *= (ts->mult + ntp_adj);
+	ret >>= ts->shift;
+	return (nsec_t)ret;
+}
+
+/* cyc2ns_rem():
+ *      Uses the timesource and ntp ajdustment interval to
+ *      convert cycle_ts to nanoseconds. Add in remainder portion
+ *      which is stored in ns<<ts->shift units and save the new
+ *      remainder off.
+ */
+static inline nsec_t cyc2ns_rem(struct timesource_t *ts, int ntp_adj, cycle_t cycles, u64* rem)
+{
+	u64 ret;
+	ret = (u64)cycles;
+	ret *= (ts->mult + ntp_adj);
+	if (rem) {
+		ret += *rem;
+		*rem = ret & ((1<<ts->shift)-1);
+	}
+	ret >>= ts->shift;
+	return (nsec_t)ret;
+}
+
+/* used to install a new time source */
+void register_timesource(struct timesource_t*);
+void reselect_timesource(void);
+struct timesource_t* get_next_timesource(void);
+#endif
diff --git a/include/linux/timex.h b/include/linux/timex.h
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -227,6 +227,8 @@ struct timex {
 extern unsigned long tick_usec;		/* USER_HZ period (usec) */
 extern unsigned long tick_nsec;		/* ACTHZ          period (nsec) */
 
+#ifndef CONFIG_NEWTOD
+
 #ifdef CONFIG_TIME_INTERPOLATION
 
 #define TIME_SOURCE_CPU 0
@@ -281,6 +283,7 @@ time_interpolator_reset(void)
 }
 
 #endif /* !CONFIG_TIME_INTERPOLATION */
+#endif /* !CONFIG_NEWTOD */
 
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
@@ -474,6 +475,7 @@ asmlinkage void __init start_kernel(void
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
 
+obj-$(CONFIG_NEWTOD) += timeofday.o timesource.o ntp.o
 obj-$(CONFIG_FUTEX) += futex.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -45,11 +45,9 @@
 
 #include <linux/kernel.h>
 #include <linux/ntp.h>
-#include <linux/jiffies.h>
 #include <linux/errno.h>
 
-/* Don't completely fail for HZ > 500.  */
-int tickadj = 500/HZ ? : 1;		/* microsecs */
+#define NTP_DEBUG 0
 
 /* Chapter 5: Kernel Variables [RFC 1589 pg. 28] */
 /* 5.1 Interface Variables */
@@ -67,8 +65,7 @@ static long ntp_reftime;                
 
 /* Extra values */
 static int ntp_state    = TIME_OK;              /* leapsecond state */
-long ntp_adjtime_offset;
-static long ntp_next_adjtime_offset;
+static long ntp_tick    = USEC_PER_SEC/USER_HZ; /* tick length */
 
 static long singleshot_adj; /* +/- MAX_SINGLESHOT_ADJ (ppm)*/
 static long tick_adj;       /* txc->tick adjustment (ppm) */
@@ -82,6 +79,17 @@ static seqlock_t ntp_lock = SEQLOCK_UNLO
 #define MAX_SINGLESHOT_ADJ 500 /* (ppm) */
 #define SEC_PER_DAY 86400
 
+/* Required to safely shift negative values */
+#define shiftR(x,s) (x < 0) ? (-((-x) >> (s))) : ((x) >> (s))
+
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
@@ -137,11 +145,13 @@ void ntp_advance(unsigned long interval_
 	shifted_ppm_sum += ntp_freq; /* already shifted by SHIFT_USEC */
 	shifted_ppm_sum += ss_adj << SHIFT_USEC;
 
-	/* Changes by adjtime() do not take effect till next tick. */
-	if (ntp_next_adjtime_offset != 0) {
-		ntp_adjtime_offset = ntp_next_adjtime_offset;
-		ntp_next_adjtime_offset = 0;
-	}
+#if NTP_DEBUG
+{
+	static int dbg = 0;
+	if(!(dbg++%300000))
+		printk("tick_adj(%d) + offset_adj(%d) + ntp_freq(%d) + ss_adj(%d) = ppm_sum(%d)\n", tick_adj, offset_adj, shiftR(ntp_freq,SHIFT_USEC), ss_adj, ppm_sum);
+}
+#endif
 	write_sequnlock_irqrestore(&ntp_lock, flags);
 
 }
@@ -170,6 +180,7 @@ static int ntp_hardupdate(long offset, s
 	/* Make sure offset is bounded by MAXPHASE */
 	current_offset = min(current_offset, MAXPHASE);
 	current_offset = max(current_offset, -MAXPHASE);
+
 	ntp_offset = current_offset << SHIFT_UPDATE;
 
 	if (ntp_status & STA_FREQHOLD || ntp_reftime == 0)
@@ -188,9 +199,13 @@ static int ntp_hardupdate(long offset, s
 		long offset_ppm;
 
 		offset_ppm = ntp_offset / interval;
+
 		offset_ppm <<= (SHIFT_USEC - SHIFT_UPDATE);
 
 		ntp_freq += shiftR(offset_ppm, SHIFT_KH);
+#if NTP_DEBUG
+		printk("ntp->freq change: %ld\n",shiftR(offset_ppm, damping));
+#endif
 
 	} else if ((ntp_status & STA_PLL) && (interval < MAXSEC)) {
 		long damping, offset_ppm;
@@ -201,7 +216,14 @@ static int ntp_hardupdate(long offset, s
 
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
 
@@ -212,13 +234,13 @@ static int ntp_hardupdate(long offset, s
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
-	long save_adjust;
+	long save_offset;
 	int result;
 	unsigned long flags;
 
@@ -263,15 +285,21 @@ int ntp_adjtimex(struct timex *txc)
 				||(txc->tick > 11000000/USER_HZ)))
 		return -EINVAL;
 
-	write_seqlock_irqsave(&ntp_lock, flags);
+#if NTP_DEBUG
+	if(txc->modes) {
+		printk("adjtimex: txc->offset: %ld    txc->freq: %ld\n",
+				txc->offset, txc->freq);
+	}
+#endif
 
-	result = ntp_state;       /* mostly `TIME_OK' */
+	write_seqlock_irqsave(&ntp_lock, flags);
 
-	/* Save for later - semantics of adjtime is to return old value */
-	save_adjust = ntp_next_adjtime_offset ? ntp_next_adjtime_offset : ntp_adjtime_offset;
+	result = ntp_state;
 
-	/* If there are input parameters, then process them */
+	/* For ADJ_OFFSET_SINGLESHOT we must return the old offset */
+	save_offset = shiftR(ntp_offset, SHIFT_UPDATE);
 
+	/* Process input parameters */
 	if (txc->modes & ADJ_STATUS)	/* only set allowed bits */
 		ntp_status = (txc->status & ~STA_RONLY) |
 				(ntp_status & STA_RONLY);
@@ -289,12 +317,9 @@ int ntp_adjtimex(struct timex *txc)
 		ntp_constant = txc->constant;
 
 	if (txc->modes & ADJ_OFFSET) {
-		if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
-			/* adjtime() is independent from ntp_adjtime() */
-			if ((ntp_next_adjtime_offset = txc->offset) == 0)
-				ntp_adjtime_offset = 0;
+		if (txc->modes == ADJ_OFFSET_SINGLESHOT)
 			singleshot_adj = txc->offset;
-		} else if (ntp_hardupdate(txc->offset, txc->time))
+		else if (ntp_hardupdate(txc->offset, txc->time))
 			result = TIME_ERROR;
 	}
 
@@ -303,9 +328,8 @@ int ntp_adjtimex(struct timex *txc)
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
@@ -313,7 +337,7 @@ int ntp_adjtimex(struct timex *txc)
 
 	/* write kernel state to user timex values*/
 	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
-		txc->offset = save_adjust;
+		txc->offset = save_offset;
 	else
 		txc->offset = shiftR(ntp_offset, SHIFT_UPDATE);
 
@@ -324,7 +348,7 @@ int ntp_adjtimex(struct timex *txc)
 	txc->constant = ntp_constant;
 	txc->precision = ntp_precision;
 	txc->tolerance = ntp_tolerance;
-	txc->tick = tick_usec;
+	txc->tick = ntp_tick;
 
 	/* PPS is not implemented, so these are zero */
 	txc->ppsfreq = 0;
@@ -417,7 +441,6 @@ void ntp_clear(void)
 	unsigned long flags;
 	write_seqlock_irqsave(&ntp_lock, flags);
 
-	ntp_next_adjtime_offset = 0;		/* stop active adjtime() */
 	ntp_status |= STA_UNSYNC;
 	ntp_maxerror = NTP_PHASE_LIMIT;
 	ntp_esterror = NTP_PHASE_LIMIT;
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
+#ifndef CONFIG_NEWTOD
 inline static void warp_clock(void)
 {
 	write_seqlock_irq(&xtime_lock);
@@ -138,6 +140,18 @@ inline static void warp_clock(void)
 	write_sequnlock_irq(&xtime_lock);
 	clock_was_set();
 }
+#else /* !CONFIG_NEWTOD */
+/* XXX - this is somewhat cracked out and should
+         be checked  -johnstul@us.ibm.com
+*/
+inline static void warp_clock(void)
+{
+	struct timespec ts;
+	getnstimeofday(&ts);
+	ts.tv_sec += sys_tz.tz_minuteswest * 60;
+	do_settimeofday(&ts);
+}
+#endif /* !CONFIG_NEWTOD */
 
 /*
  * In case for some reason the CMOS clock has not already been running
@@ -214,6 +228,7 @@ void __attribute__ ((weak)) notify_arch_
 /* adjtimex mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
+#ifndef CONFIG_NEWTOD
 int do_adjtimex(struct timex *txc)
 {
 	int result;
@@ -232,6 +247,7 @@ int do_adjtimex(struct timex *txc)
 	notify_arch_cmos_timer();
 	return(result);
 }
+#endif /* !CONFIG_NEWTOD */
 
 asmlinkage long sys_adjtimex(struct timex __user *txc_p)
 {
@@ -378,6 +394,7 @@ EXPORT_SYMBOL(do_gettimeofday);
 
 
 #else
+#ifndef CONFIG_NEWTOD
 /*
  * Simulate gettimeofday using do_gettimeofday which only allows a timeval
  * and therefore only yields usec accuracy
@@ -390,6 +407,7 @@ void getnstimeofday(struct timespec *tv)
 	tv->tv_sec = x.tv_sec;
 	tv->tv_nsec = x.tv_usec * NSEC_PER_USEC;
 }
+#endif /* !CONFIG_NEWTOD */
 #endif
 
 #if (BITS_PER_LONG < 64)
diff --git a/kernel/timeofday.c b/kernel/timeofday.c
new file mode 100644
--- /dev/null
+++ b/kernel/timeofday.c
@@ -0,0 +1,568 @@
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
+ * do_adjtimex - interface to the kernel NTP variables
+ * @tx: pointer to the timex value that will be used
+ *
+ * Userspace NTP daemon's interface to the kernel NTP variables
+ */
+int do_adjtimex(struct timex *tx)
+{
+	if (tx->modes && !capable(CAP_SYS_TIME))
+		return -EPERM;
+
+	/* Note: We set tx->time first,
+	 * because ntp_adjtimex uses it
+	 */
+	do_gettimeofday(&tx->time);
+
+	return ntp_adjtimex(tx);
+}
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
+	ppm = ntp_get_adjustment();
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
@@ -598,6 +598,7 @@ struct timespec wall_to_monotonic __attr
 
 EXPORT_SYMBOL(xtime);
 
+#ifndef CONFIG_NEWTOD
 /* in the NTP reference this is called "hardclock()" */
 static void update_wall_time_one_tick(void)
 {
@@ -645,6 +646,9 @@ static void update_wall_time(unsigned lo
 		}
 	} while (ticks);
 }
+#else /* !CONFIG_NEWTOD */
+#define update_wall_time(x)
+#endif /* !CONFIG_NEWTOD */
 
 /*
  * Called from the timer interrupt handler to charge one tick to the current 
diff --git a/kernel/timesource.c b/kernel/timesource.c
new file mode 100644
--- /dev/null
+++ b/kernel/timesource.c
@@ -0,0 +1,259 @@
+/*********************************************************************
+* linux/kernel/timesource.c
+*
+* This file contains the functions which manage timesource drivers.
+*
+* Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
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
+*   o Allow timesource drivers to be unregistered
+*   o get rid of timesource_jiffies extern
+**********************************************************************/
+
+#include <linux/timesource.h>
+#include <linux/sysdev.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#define MAX_TIMESOURCES 10
+
+
+/* XXX - Would like a better way for initializing curr_timesource */
+extern struct timesource_t timesource_jiffies;
+
+/*[Timesource internal variables]---------
+ * curr_timesource:
+ *     currently selected timesource. Initialized to timesource_jiffies.
+ * next_timesource:
+ *     pending next selected timesource.
+ * timesource_list:
+ *     array of pointers pointing to registered timesources
+ * timesource_list_counter:
+ *     value which counts the number of registered timesources
+ * timesource_lock:
+ *     protects manipulations to curr_timesource and next_timesource
+ *     and the timesource_list
+ */
+static struct timesource_t *curr_timesource = &timesource_jiffies;
+static struct timesource_t *next_timesource;
+static struct timesource_t *timesource_list[MAX_TIMESOURCES];
+static int timesource_list_counter;
+static seqlock_t timesource_lock = SEQLOCK_UNLOCKED;
+
+static char override_name[32];
+
+/**
+ * get_next_timesource - Returns the selected timesource
+ *
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
+
+/**
+ * select_timesource - Finds the best registered timesource.
+ *
+ * Private function. Must have a writelock on timesource_lock
+ * when called.
+ */
+static struct timesource_t* select_timesource(void)
+{
+	struct timesource_t* best = timesource_list[0];
+	int i;
+
+	for (i=0; i < timesource_list_counter; i++) {
+		/* Check for override */
+		if ((override_name[0] != 0) &&
+			(strlen(override_name)
+				== strlen(timesource_list[i]->name)) &&
+			(!strncmp(timesource_list[i]->name, override_name,
+				 strlen(override_name)))) {
+			best = timesource_list[i];
+			break;
+		}
+		/* Pick the highest priority */
+		if (timesource_list[i]->priority > best->priority)
+		 	best = timesource_list[i];
+	}
+	return best;
+}
+
+/**
+ * register_timesource - Used to install new timesources
+ * @t: timesource to be registered
+ *
+ */
+void register_timesource(struct timesource_t* t)
+{
+	char* error_msg = 0;
+	int i;
+	write_seqlock(&timesource_lock);
+
+	/* check if timesource is already registered */
+	for (i=0; i < timesource_list_counter; i++)
+		if (!strncmp(timesource_list[i]->name, t->name, strlen(t->name))){
+			error_msg = "Already registered!";
+			break;
+		}
+
+	/* check that the list isn't full */
+	if (timesource_list_counter >= MAX_TIMESOURCES)
+		error_msg = "Too many timesources!";
+
+	if(!error_msg)
+		timesource_list[timesource_list_counter++] = t;
+	else
+		printk("register_timesource: Cannot register %s. %s\n",
+					t->name, error_msg);
+
+	/* select next timesource */
+	next_timesource = select_timesource();
+
+	write_sequnlock(&timesource_lock);
+}
+EXPORT_SYMBOL(register_timesource);
+
+
+/**
+ * reselect_timesource - Rescan list for next timesource
+ *
+ * A quick helper function to be used if a timesource
+ * changes its priority. Forces the timesource list to
+ * be re-scaned for the best timesource.
+ */
+void reselect_timesource(void)
+{
+	write_seqlock(&timesource_lock);
+	next_timesource = select_timesource();
+	write_sequnlock(&timesource_lock);
+}
+
+/**
+ * sysfs_show_timesources - sysfs interface for listing timesource
+ * @dev: unused
+ * @buf: char buffer to be filled with timesource list
+ *
+ * Provides sysfs interface for listing registered timesources
+ */
+static ssize_t sysfs_show_timesources(struct sys_device *dev, char *buf)
+{
+	int i;
+	char* curr = buf;
+	write_seqlock(&timesource_lock);
+	for(i=0; i < timesource_list_counter; i++) {
+		/* Mark current timesource w/ a star */
+		if (timesource_list[i] == curr_timesource)
+			curr += sprintf(curr, "*");
+		curr += sprintf(curr, "%s ",timesource_list[i]->name);
+	}
+	write_sequnlock(&timesource_lock);
+
+	curr += sprintf(curr, "\n");
+	return curr - buf;
+}
+
+/**
+ * sysfs_override_timesource - interface for manually overriding timesource
+ * @dev: unused
+ * @buf: name of override timesource
+ *
+ *
+ *     Takes input from sysfs interface for manually overriding
+ *     the default timesource selction
+ */
+static ssize_t sysfs_override_timesource(struct sys_device *dev,
+			const char *buf, size_t count)
+{
+	/* check to avoid underflow later */
+	if (strlen(buf) == 0)
+		return count;
+
+	write_seqlock(&timesource_lock);
+
+	/* copy the name given */
+	strncpy(override_name, buf, strlen(buf)-1);
+	override_name[strlen(buf)-1] = 0;
+
+	/* see if we can find it */
+	next_timesource = select_timesource();
+
+	write_sequnlock(&timesource_lock);
+	return count;
+}
+
+/* Sysfs setup bits:
+ */
+static SYSDEV_ATTR(timesource, 0600, sysfs_show_timesources, sysfs_override_timesource);
+
+static struct sysdev_class timesource_sysclass = {
+	set_kset_name("timesource"),
+};
+
+static struct sys_device device_timesource = {
+	.id	= 0,
+	.cls	= &timesource_sysclass,
+};
+
+static int init_timesource_sysfs(void)
+{
+	int error = sysdev_class_register(&timesource_sysclass);
+	if (!error) {
+		error = sysdev_register(&device_timesource);
+		if (!error)
+			error = sysdev_create_file(&device_timesource, &attr_timesource);
+	}
+	return error;
+}
+device_initcall(init_timesource_sysfs);
+
+
+/**
+ * boot_override_timesource - boot time override
+ * @str: override name
+ *
+ * Takes a timesource= boot argument and uses it
+ * as the timesource override name
+ */
+static int __init boot_override_timesource(char* str)
+{
+	if (str)
+		strlcpy(override_name, str, sizeof(override_name));
+	return 1;
+}
+__setup("timesource=", boot_override_timesource);
+
+/**
+ * boot_override_clock - Compatibility layer for deprecated boot option
+ * @str: override name
+ *
+ * DEPRECATED! Takes a clock= boot argument and uses it
+ * as the timesource override name
+ */
+static int __init boot_override_clock(char* str)
+{
+	printk("Warning! clock= boot option is deprecated.\n");
+	return boot_override_timesource(str);
+}
+__setup("clock=", boot_override_clock);


