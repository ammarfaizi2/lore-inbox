Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbVLPBHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbVLPBHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 20:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVLPBHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 20:07:54 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:35250 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751259AbVLPBH2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 20:07:28 -0500
Date: Thu, 15 Dec 2005 18:07:26 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, johnstul@us.ibm.com,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051216010726.19280.18643.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051216010700.19280.66934.sendpatchset@cog.beaverton.ibm.com>
References: <20051216010700.19280.66934.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 4/11] Time: Generic Timekeeping Infrastructure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Andrew,

This patch implements my generic timeofday framework. This common 
infrastructure is intended to be used by any arch to reduce code 
duplication, improve robustness in the face of late or lost ticks, and 
enable finer granularity timekeeping.

The major change with this code is that it allows timekeeping to be 
independent of the timer interrupt. This provides a linear mapping 
(ignoring ntp adjustments) between a hardware clocksource counter and 
the time of day. This allows for lost ticks or other software delays to 
not affect timekeeping.

Included below is timeofday.c (which includes all the time of day 
management and accessor functions), and minimal hooks into arch 
independent code. This patch does not remove the current timekeeping 
code, allowing architectures to move over when they are ready. 

This patch applies on top of my clocksource management patch.

The patch does nothing without at least minimal architecture specific 
hooks, and it should be able to be applied to a tree without affecting 
the existing code.

Andrew, please consider for inclusion into your tree.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 Documentation/timekeeping.txt   |  350 ++++++++++++++++++++
 drivers/char/hangcheck-timer.c  |    5 
 include/asm-generic/timeofday.h |   30 +
 include/linux/time.h            |   30 +
 include/linux/timeofday.h       |   46 ++
 include/linux/timex.h           |    2 
 include/sound/timer.h           |    1 
 init/main.c                     |    2 
 kernel/hrtimer.c                |    1 
 kernel/posix-timers.c           |    2 
 kernel/time.c                   |   17 
 kernel/time/Makefile            |    2 
 kernel/time/timeofday.c         |  685 ++++++++++++++++++++++++++++++++++++++++
 kernel/timer.c                  |    7 
 14 files changed, 1169 insertions(+), 11 deletions(-)

linux-2.6.15-rc5_timeofday-core_B14.patch
============================================
diff --git a/Documentation/timekeeping.txt b/Documentation/timekeeping.txt
new file mode 100644
index 0000000..255fd56
--- /dev/null
+++ b/Documentation/timekeeping.txt
@@ -0,0 +1,350 @@
+How timekeeping works with CONFIG_GENERIC_TIME
+========================================================================
+
+The generic timekeeping code maintains and allows access to the systems
+understanding of how much time has passed from a certain point. However, in
+order to measure the passing of time, the generic timekeeping code relies on
+the clocksource abstraction. A clocksource abstracts a free running counter
+who's value increases at a known frequency.
+
+In the generic timekeeping code, we use a pointer to a selected clocksource to
+measure the passing of time.
+
+struct clocksource *clock
+
+The clocksource has some limitations however. Since its likely of fixed width,
+it will not increment forever and will overflow. In order to still properly
+keep time, we must occasionally accumulate an interval of time. In the generic
+timekeeping code, we accumulate the amount of time system the system booted
+into the value system_time, which keeps nanosecond resolution in a ktime_t
+storage.
+
+ktime_t system_time
+
+Since its likely your system has not been running continually since midnight on
+the 1st of January in 1970, we must provide an offset from that time in
+accordance with conventions. This only occasionally changed (via
+settimeofday()) offset is the wall_time_offset value, which is also stored as a
+ktime_t.
+
+ktime_t wall_time_offset
+
+
+Since we accumulate time in intervals, we need a base cycle value that we can
+use to generate an offset from the time value kept in system_time. We store
+this value in cycle_last.
+
+cycle_t cycle_last;
+
+
+Further since all clocks drift somewhat from each other, we use the adjustment
+values provided via adjtimex() to correct our clocksource frequency for each
+interval. This frequency adjustment value is stored in ntp_adj.
+
+long ntp_adj;
+
+Now that we've covered the core global variables for timekeeping, lets look at
+how we maintain these values.
+
+As stated above, we want to avoid the clocksource from overflowing on us, so we
+accumulate a time interval periodically. This periodic accumulation function is
+called timeofday_periodic_hook().  In simplified pseudo code, it logically is
+presented as:
+
+timeofday_periodic_hook():
+	cycle_now = read_clocksource(clock)
+	cycle_delta = (cycle_now - cycle_last) & clock->mask
+	nsec = cyc2ns(clock, cycle_delta, ntp_adj)
+	system_time += nsec
+	cycle_last = cycle_now
+
+	/* do other stuff */
+
+You can see we read the cycle value from the clocksource, calculate a cycle
+delta for the interval since we last called timeofday_periodic_hook(), convert
+that cycle delta to a nanosecond interval (for now ignore ntp_adj), add it to
+the system time and finally set our cycle_last value to cycle_now for the next
+interval. Using this simple algorithm we can correctly measure and record the
+passing of time.
+
+But just storing this info isn't very useful, we also want to make it available
+to be used elsewhere. So how do we provide a notion of how much time has passed
+inbetween calls to timeofday_periodic_hook()?
+
+First, lets create a function that calculates the time since the last call to
+timeofday_peridoic_hook().
+
+get_nsec_offset():
+	cycle_now = read_clocksource(clock)
+	cycle_delta = (cycle_now - cycle_last) & clock->mask
+	nsec = cyc2ns(clock, cycle_delta, ntp_adj)
+	return nsec
+
+Here you can see, we read the clocksource, calculate a cycle interval, and
+convert that to a nanosecond interval. Just like how it is done in
+timeofday_periodic_hook!
+
+Now lets use this function to provide the number of nanoseconds that the system
+has been running:
+
+do_monotonic_clock():
+	return system_time + get_nsec_offset()
+
+Here we trivially add the nanosecond offset since the last
+timeofday_periodic_hook() to the value of system_time which was stored at the
+last timeofday_periodic_hook().
+
+Note that since we use the same method to calculate time intervals, assuming
+each function is atomic and the clocksource functions as it should, time cannot
+go backward!
+
+Now to get the time of day using the standard convention:
+
+do_gettimeofday():
+	return do_monotonic_clock() + wall_time_offset
+
+We simply add the wall_time_offset, and we have the number of nanoseconds since
+1970 began!
+
+
+Of course, in real life, things are not so static. We have to handle a number
+of dynamic values that may change and affect timekeeping. In order to do these
+safely, we must only change values in-between intervals. This means the
+periodic_hook call must handle these changes.
+
+Since clocksources can be changed while the system is running, we need to check
+for and possibly switch to using new clocksources in the periodic_hook call.
+Further, clocksources may change their frequency. Since this must be done only
+at a safe point, we use the update_callback function pointer (for more details,
+see "How to write a clocksource driver" below), this too must be done
+in-between intervals in the periodic_hook call. Finally, since the ntp
+adjustment made in the cyc2ns conversion is not static, we need to update the
+ntp state machine and get a calculate a new adjustment value.
+
+This adds some extra pseudo code to the timeofday_periodic_hook function:
+
+timeofday_periodic_hook():
+	cycle_now = read_clocksource(clock)
+	cycle_delta = (cycle_now - cycle_last) & clock->mask
+	nsec = cyc2ns(clock, cycle_delta, ntp_adj)
+	system_time += nsec
+	cycle_last = cycle_now
+
+	next = get_next_clocksource()
+	if(next != clock):
+		cycle_last = read_clocksource(next)
+		clock = next
+
+	if(clock->update_callback):
+		clock->update_callback()
+
+	ntp_advance(nsec)
+	ppm = ntp_get_ppm_adjustment()
+	ntp_adj = ppm_to_mult_adj(clock, ppm)
+
+
+Unfortunately, the actual timeofday_periodic_hook code is not as simple as this
+pseudo code. For performance concerns, much has been done to pre-calculate
+values and use them repeatedly. Thus be aware that the code in timeofday.c is
+more complex, however the functional logic is the same.
+
+
+How to port an architecture to GENERIC_TIME
+========================================================================
+Porting an architecture to the GENERIC_TIME timekeeping code consists of moving
+a little bit of code around then deleting a fair amount. It is my hope that
+this will reduce the arch specific maintenance work around timekeeping.
+
+Porting an arch usually requires the following steps.
+
+1. Define CONFIG_GENERIC_TIME in the arches Kconfig
+2. Implementing the following functions
+	nsec_t read_persistent_clock(void)
+	void sync_persistent_clock(struct timespec ts)
+3. Removing all of the arch specific timekeeping code
+	do_gettimeofday()
+	do_settimeofday()
+	etc
+4. Implementing clocksource drivers
+	See "How to write a clocksource driver" for more details
+
+The exceptions to the above are:
+
+5.  If the arch is has no continuous clocksource
+	A) Implement 1-3 in the above list.
+	B) Define CONFIG_IS_TICK_BASED in arches Kconfig
+	C) Implement the "long arch_getoffset(void)" function
+
+6. If the arch supports vsyscall gettimeofday (see x86_64 for reference)
+	A) Implement 1-4 in the above list
+	B) Define GENERIC_TIME_VSYSCALL
+	C) Implement arch_update_vsyscall_gtod()
+	D) Implement vsyscall gettimeofday (similar to __get_realtime_clock_ts)
+	E) Implement vread functions for supported clocksources
+
+
+
+How to write a clocksource driver.
+========================================================================
+First, a quick summary of what a clocksource driver provides.
+
+Simply put, a clocksource is a abstraction of a free running increasing
+counter. The abstraction provides the minimal amount of info for that counter
+to be usable for timekeeping. Those required values are:
+	1. It's name
+	2. A rating value for selection priority
+	3. A read function pointer
+	4. A mask value for correct twos-complement subtraction
+	5. A mult and shift pair that approximate the counter frequency
+		mult/(2^shift) ~= nanoseconds per cycle
+
+Additionally, there are other optionally set values that allow for advanced
+functionality. Those values are:
+	6. The update_callback function.
+	7. The is_continuous flag.
+	8. The vread function pointer
+	9. The vdata pointer value
+
+
+Now lets go over these values in detail.
+
+1. Name.
+	The clocksource's name should be unique since it is used for both
+identification as well as for manually overriding the default clocksource
+selection. The name length must be shorter then 32 characters in order for it
+to be properly overrided.
+
+2. Rating value
+	This rating value is used as a priority value for clocksource
+selection. It has no direct connection to quality or physical properties of the
+clocksource, but is to be set and manipulated to guarantee that the best (by no
+specific metric) clocksource that will provide correct timekeeping is
+automatically selected. Rating suggestions can be found in
+include/linux/clocksource.h
+
+3. Read function pointer
+	This pointer should point to a function that returns an unsigned
+increasing cycle value from the clocksource. The value should have a coverage
+from zero to the maximum cycle value the clocksource can provide. This does not
+have to be direct hardware value and can also be a software counter. An example
+of a software counter is the jiffies clocksource.
+
+4. The mask value
+	This value should be the largest power of two that is smaller then the
+maximum cycle value. This allows twos complement subtraction to work on
+overflow boundary conditions if the max value is less then (cycle_t)-1. So for
+example, if we have a 16 bit counter (ie: one that loops to zero after
+0x0000FFFF), the mask would be 0xFFFF. So then when finding the cycle
+difference around a overflow, where now = 0x0013 and then = 0xFFEE, we can
+compute the cycle delta properly using the equation:
+	delta = (now - then)&mask
+	delta = (0x0013 - 0xFFEE) & 0xFFFF
+	delta = 0xFFFF0025 & 0xFFFF  /* note the unmasked negative value */
+	delta = 0x25
+
+5. The mult and shift pair
+	These 32bit values approximate the nanosecond per cycle frequency of
+the clocksource using the equation: mult/(2^shift). If you have a khz or hz
+frequency value, the mult value for a given shift value can be easily
+calculated using the  clocksource_hz2mult() and clocksource_khz2mult() helper
+functions. When selecting a shift value, it is important to be careful. Larger
+shift values give a finer precision in the cycle to nanosecond conversion and
+allows for more exact NTP adjustments.	However if you select too large a shift
+value, the resulting mult value might overflow a cycle_t * mult computation.
+
+
+So if you have a simple hardware counter that does not change frequency,
+filling in the above should be sufficient for a functional clocksource. But
+read on for details on implementing a more complex clocksource.
+
+6. The update_callback function pointer.
+	If this function pointer is non-NULL, it will be called every periodic
+hook when it is safe for the clocksource to change its state. This would be
+necessary in the case where the counter frequency changes, for example. One
+user of this  function pointer is the TSC clocksource. When the TSC frequency
+changes (which may occur if the cpu changes frequency) we need to notify the
+clocksource at a safe point where that state may change. Thus, if the TSC has
+changed frequency we set the new mult/shift values in the update_callback
+function.
+
+7. The is_continuous flag.
+	This flag variable (0 if false, 1 if true) denotes that the clocksource
+is continuous. This means that it is a purely hardware driven clocksource and
+is not dependent on any software code to run for it to increment properly. This
+denotation will be useful in the future when timer ticks may be disabled for
+long periods of time. Doing so using software clocksources, like the jiffies
+clocksource, would cause timekeeping problems.
+
+8. The vread function pointer.
+	This function pointer points to a user-space accessible function that
+reads the clocksource. This is used in userspace gettimeofday implementations
+to improve performance. See the x86-64 TSC clocksource implementation for an
+example.
+
+8. The vdata pointer.
+	This pointer is passed to the vread function pointer in a userspace
+gettimeofday implementation. Its usage is dependent on the vread
+implementation, but if the pointer points to data, that data must be readable
+from userspace.
+
+
+Now lets write a quick clocksource for an imaginary bit of hardware. Here are
+the specs:
+
+	A 32bit counter can be found at the MMIO address 0xFEEDF000. It runs at
+100Mhz. To enable it, the the low bit of the address 0xFEEDF0F0 must be set to
+one.
+
+So lets start out an empty cool-counter.c file, and define the clocksource.
+
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <asm/io.h>
+
+#define COOL_READ_PTR	0xFEEDF000
+#define COOL_START_PTR	0xFEEDF0F0
+
+static __iomem *cool_ptr = COOL_READ_PTR;
+
+struct clocksource clocksource_cool
+{
+	.name = "cool",
+	.rating = 200,		/* its a pretty decent clock */
+	.mask = 0xFFFFFFFF,	/* 32 bits */
+	.mult = 0,			/*to be computed */
+	.shift = 10,
+}
+
+
+Now let's write the read function:
+
+cycle_t cool_counter_read(void)
+{
+	cycle_t ret = readl(cool_ptr);
+	return ret;
+}
+
+Finally, lets write the init function:
+
+void cool_counter_init(void)
+{
+	__iomem *ptr = COOL_START_PTR;
+	u32 val;
+
+	/* start the counter */
+	val = readl(ptr);
+	val |= 0x1;
+	writel(val, ptr);
+
+	/* finish initializing the clocksource */
+	clocksource_cool.read = cool_counter_read;
+	clocksource_cool.mult = clocksource_khz2mult(100000,
+					clocksource_cool.shift);
+
+	/* register the clocksource */
+	register_clocksource(&clocksource_cool);
+}
+module_init(cool_counter_init);
+
+
+Now wasn't that easy!
diff --git a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
index 66e53dd..59d8c48 100644
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
+#ifndef CONFIG_GENERIC_TIME
 extern unsigned long long monotonic_clock(void);
 #else
+#define monotonic_clock() ktime_to_ns(get_monotonic_clock())
+#endif
+#else
 static inline unsigned long long monotonic_clock(void)
 {
 # ifdef __s390__
diff --git a/include/asm-generic/timeofday.h b/include/asm-generic/timeofday.h
new file mode 100644
index 0000000..c3dbcd0
--- /dev/null
+++ b/include/asm-generic/timeofday.h
@@ -0,0 +1,30 @@
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
+
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
+# define arch_update_vsyscall_gtod(x,y,z,w) do { } while(0)
+#endif /* CONFIG_GENERIC_TIME_VSYSCALL */
+
+#endif /* CONFIG_GENERIC_TIME */
+#endif
diff --git a/include/linux/time.h b/include/linux/time.h
index 1201155..4dbd133 100644
--- a/include/linux/time.h
+++ b/include/linux/time.h
@@ -27,6 +27,10 @@ struct timezone {
 
 #ifdef __KERNEL__
 
+/* timeofday base types */
+typedef s64 nsec_t;
+typedef u64 cycle_t;
+
 /* Parameters used to convert the timespec values: */
 #define MSEC_PER_SEC		1000L
 #define USEC_PER_SEC		1000000L
@@ -50,12 +54,6 @@ extern void set_normalized_timespec(stru
 #define timespec_valid(ts) \
 	(((ts)->tv_sec >= 0) && (((unsigned) (ts)->tv_nsec) < NSEC_PER_SEC))
 
-/*
- * 64-bit nanosec type. Large enough to span 292+ years in nanosecond
- * resolution. Ought to be enough for a while.
- */
-typedef s64 nsec_t;
-
 extern struct timespec xtime;
 extern struct timespec wall_to_monotonic;
 extern seqlock_t xtime_lock;
@@ -79,8 +77,6 @@ struct itimerval;
 extern int do_setitimer(int which, struct itimerval *value,
 			struct itimerval *ovalue);
 extern int do_getitimer(int which, struct itimerval *value);
-extern void getnstimeofday(struct timespec *tv);
-extern void getnstimestamp(struct timespec *ts);
 
 extern struct timespec timespec_trunc(struct timespec t, unsigned gran);
 
@@ -125,6 +121,24 @@ extern struct timespec ns_to_timespec(co
  */
 extern struct timeval ns_to_timeval(const nsec_t nsec);
 
+static inline void normalize_timespec(struct timespec *ts)
+{
+	while (unlikely((unsigned long)ts->tv_nsec >= NSEC_PER_SEC)) {
+		ts->tv_nsec -= NSEC_PER_SEC;
+		ts->tv_sec++;
+	}
+}
+
+static inline void timespec_add_ns(struct timespec *a, nsec_t ns)
+{
+	while(unlikely(ns >= NSEC_PER_SEC)) {
+		ns -= NSEC_PER_SEC;
+		a->tv_sec++;
+	}
+	a->tv_nsec += ns;
+	normalize_timespec(a);
+}
+
 #endif /* __KERNEL__ */
 
 #define NFDBITS			__NFDBITS
diff --git a/include/linux/timeofday.h b/include/linux/timeofday.h
new file mode 100644
index 0000000..5222c4c
--- /dev/null
+++ b/include/linux/timeofday.h
@@ -0,0 +1,46 @@
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
+#define getnstimestamp(ts) get_monotonic_clock_ts(ts)
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
+extern void getnstimestamp(struct timespec *ts);
+#endif /* CONFIG_GENERIC_TIME */
+#endif /* _LINUX_TIMEOFDAY_H */
diff --git a/include/linux/timex.h b/include/linux/timex.h
index e35c683..91a7fd6 100644
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -310,6 +310,7 @@ extern int ntp_leapsecond(struct timespe
 	__x < 0 ? -(-__x >> __s) : __x >> __s;	\
 })
 
+#ifndef CONFIG_GENERIC_TIME
 
 #ifdef CONFIG_TIME_INTERPOLATION
 
@@ -365,6 +366,7 @@ time_interpolator_reset(void)
 }
 
 #endif /* !CONFIG_TIME_INTERPOLATION */
+#endif /* !CONFIG_GENERIC_TIME */
 
 #endif /* KERNEL */
 
diff --git a/include/sound/timer.h b/include/sound/timer.h
index b55f38a..6a31988 100644
--- a/include/sound/timer.h
+++ b/include/sound/timer.h
@@ -25,6 +25,7 @@
 
 #include <sound/asound.h>
 #include <linux/interrupt.h>
+#include <linux/timeofday.h>
 
 typedef enum sndrv_timer_class snd_timer_class_t;
 typedef enum sndrv_timer_slave_class snd_timer_slave_class_t;
diff --git a/init/main.c b/init/main.c
index 0d6475e..fd08b56 100644
--- a/init/main.c
+++ b/init/main.c
@@ -47,6 +47,7 @@
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
+#include <linux/timeofday.h>
 #include <net/sock.h>
 
 #include <asm/io.h>
@@ -489,6 +490,7 @@ asmlinkage void __init start_kernel(void
 	init_timers();
 	hrtimers_init();
 	softirq_init();
+	timeofday_init();
 	time_init();
 
 	/*
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index 3a08078..2db11ed 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -29,6 +29,7 @@
 #include <linux/percpu.h>
 #include <linux/hrtimer.h>
 #include <linux/notifier.h>
+#include <linux/timeofday.h>
 #include <linux/syscalls.h>
 #include <linux/interrupt.h>
 
diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
index 9e66e61..771f3a6 100644
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -34,7 +34,7 @@
 #include <linux/smp_lock.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
-#include <linux/time.h>
+#include <linux/timeofday.h>
 
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
diff --git a/kernel/time.c b/kernel/time.c
index 6529064..6db0113 100644
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
+#ifndef CONFIG_GENERIC_TIME
 static inline void warp_clock(void)
 {
 	write_seqlock_irq(&xtime_lock);
@@ -137,6 +139,18 @@ static inline void warp_clock(void)
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
@@ -479,6 +493,7 @@ struct timespec timespec_trunc(struct ti
 }
 EXPORT_SYMBOL(timespec_trunc);
 
+#ifndef CONFIG_GENERIC_TIME
 #ifdef CONFIG_TIME_INTERPOLATION
 void getnstimeofday (struct timespec *tv)
 {
@@ -586,6 +601,8 @@ void getnstimestamp(struct timespec *ts)
 }
 EXPORT_SYMBOL_GPL(getnstimestamp);
 
+#endif /* !CONFIG_GENERIC_TIME */
+
 /* Converts Gregorian date to seconds since 1970-01-01 00:00:00.
  * Assumes input in normal date format, i.e. 1980-12-31 23:59:59
  * => year=1980, mon=12, day=31, hour=23, min=59, sec=59.
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
index e1dfd8e..4bdb5e6 100644
--- a/kernel/time/Makefile
+++ b/kernel/time/Makefile
@@ -1 +1 @@
-obj-y += clocksource.o jiffies.o
+obj-y += clocksource.o jiffies.o timeofday.o
diff --git a/kernel/time/timeofday.c b/kernel/time/timeofday.c
new file mode 100644
index 0000000..2aa595d
--- /dev/null
+++ b/kernel/time/timeofday.c
@@ -0,0 +1,685 @@
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
+#include <linux/clocksource.h>
+#include <linux/timeofday.h>
+#include <linux/jiffies.h>
+#include <linux/sysdev.h>
+#include <linux/timer.h>
+#include <linux/module.h>
+#include <linux/ktime.h>
+#include <linux/timex.h>
+#include <linux/sched.h>
+
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
+ *	timespec holding the current wall time.
+ *	NOTE: clock_was_set() must be called when this value changes.
+ * mono_time_ts:
+ *	timespec holding the current monotonic time.
+ * monotonic_time_offset_ts:
+ *	timespec holding the difference between wall and monotonic time.
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
+ *	value of the current ntp adjustment, stored in
+ *	clocksource multiplier units.
+ */
+static int ntp_adj;
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
+static struct timer_list timeofday_timer;
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
+	/* read clocksource: */
+	cycle_now = read_clocksource(clock);
+
+	/* calculate the delta since the last timeofday_periodic_hook: */
+	cycle_delta = (cycle_now - cycle_last) & clock->mask;
+
+	/* convert to nanoseconds: */
+	ns_offset = cyc2ns(clock, ntp_adj, cycle_delta);
+
+	/*
+	 * special case for jiffies tick/offset based systems,
+	 * add arch-specific offset:
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
+ * @ts:		pointer to the timespec to be set
+ *
+ * Returns a timespec of nanoseconds since the system booted and
+ * store the result in the timespec variable pointed to by @ts
+ */
+void get_monotonic_clock_ts(struct timespec *ts)
+{
+	unsigned long seq;
+	nsec_t offset;
+
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		*ts = mono_time_ts;
+		offset = __get_nsec_offset();
+	} while (read_seqretry(&system_time_lock, seq));
+
+	timespec_add_ns(ts, offset);
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
+	nsec_t nsecs;
+
+	do {
+		seq = read_seqbegin(&system_time_lock);
+
+		*ts = wall_time_ts;
+		nsecs = __get_nsec_offset();
+
+	} while (read_seqretry(&system_time_lock, seq));
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
+void get_realtime_clock_ts(struct timespec *ts)
+{
+	__get_realtime_clock_ts(ts);
+}
+
+EXPORT_SYMBOL(get_realtime_clock_ts);
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
+
+/**
+ * do_settimeofday - Sets the time of day
+ * @tv:		pointer to the timespec variable containing the new time
+ *
+ * Sets the time of day to the new time and update NTP and notify hrtimers
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
+	wall_time_ts = ktime_to_timespec(ktime_add(system_time,
+						wall_time_offset));
+	monotonic_time_offset_ts = ktime_to_timespec(wall_time_offset);
+
+	ntp_clear();
+	update_legacy_time_values();
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
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
+ * __increment_system_time - Increments system time
+ * @delta:	nanosecond delta to add to the time variables
+ *
+ * Private helper that increments system_time and related
+ * timekeeping variables.
+ */
+static inline void __increment_system_time(nsec_t delta)
+{
+	system_time = ktime_add_ns(system_time, delta);
+	timespec_add_ns(&wall_time_ts, delta);
+	timespec_add_ns(&mono_time_ts, delta);
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
+	/*
+	 * First off, save suspend start time
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
+	/*
+	 * Read persistent clock to mark the end of
+	 * the suspend interval then rebase the
+	 * cycle_last to current clocksource value.
+	 * Again, time between these two calls will
+	 * not be accounted for and will show up as
+	 * time drift.
+	 */
+	suspend_end = read_persistent_clock();
+	cycle_last = read_clocksource(clock);
+
+	/* calculate suspend time and add it to system time: */
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
+	/* notify the posix timers if wall_time_offset changed */
+	clock_was_set();
+
+	return 0;
+}
+
+/* sysfs resume/suspend bits */
+static struct sysdev_class timeofday_sysclass = {
+	.resume		= timeofday_resume_hook,
+	.suspend	= timeofday_suspend_hook,
+	set_kset_name("timeofday"),
+};
+
+static struct sys_device device_timer = {
+	.id		= 0,
+	.cls		= &timeofday_sysclass,
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
+	long leapsecond = 0;
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
+	/* read time source & calc time since last call: */
+	cycle_now = read_clocksource(clock);
+	cycle_delta = (cycle_now - cycle_last) & clock->mask;
+
+	delta_nsec = cyc2ns_fixed_rem(ts_interval, &cycle_delta, &remainder);
+	cycle_last = (cycle_now - cycle_delta)&clock->mask;
+
+	/* update system_time:  */
+	__increment_system_time(delta_nsec);
+
+	/* advance the ntp state machine by ns interval: */
+	ntp_advance(delta_nsec);
+
+	/* only call ntp_leapsecond and ntp_sync once a sec:  */
+	second_check += delta_nsec;
+	if (second_check >= NSEC_PER_SEC) {
+		/* do ntp leap second processing: */
+		leapsecond = ntp_leapsecond(wall_time_ts);
+		if (leapsecond) {
+			wall_time_offset = ktime_add_ns(wall_time_offset,
+						leapsecond * NSEC_PER_SEC);
+			wall_time_ts.tv_sec += leapsecond;
+			monotonic_time_offset_ts.tv_sec += leapsecond;
+		}
+		/* sync the persistent clock: */
+		if (ntp_synced())
+			sync_persistent_clock(wall_time_ts);
+		second_check -= NSEC_PER_SEC;
+	}
+
+	/* if necessary, switch clocksources: */
+	next = get_next_clocksource();
+	if (next != clock) {
+		/* immediately set new cycle_last: */
+		cycle_last = read_clocksource(next);
+		/* update cycle_now to avoid problems in accumulation later: */
+		cycle_now = cycle_last;
+		/* swap clocksources: */
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
+	/*
+	 * now is a safe time, so allow clocksource to adjust
+	 * itself (for example: to make cpufreq changes):
+	 */
+	if (clock->update_callback) {
+		/*
+		 * since clocksource state might change,
+		 * keep a copy, but only if we've not
+		 * already changed timesources:
+		 */
+		if (!something_changed)
+			old_clock = *clock;
+		if (clock->update_callback()) {
+			remainder = 0;
+			something_changed = 1;
+		}
+	}
+
+	/* check for new PPM adjustment: */
+	ppm = ntp_get_ppm_adjustment();
+	if (ppm_last != ppm) {
+		/* make sure old_clock is set: */
+		if (!something_changed)
+			old_clock = *clock;
+		something_changed = 1;
+	}
+
+	/* if something changed, recalculate the ntp adjustment value: */
+	if (something_changed) {
+		/* accumulate current leftover cycles using old_clock: */
+		if (cycle_delta) {
+			delta_nsec = cyc2ns_rem(&old_clock, ntp_adj,
+						cycle_delta, &remainder);
+			cycle_last = cycle_now;
+			__increment_system_time(delta_nsec);
+			ntp_advance(delta_nsec);
+		}
+
+		/* recalculate the ntp adjustment and fixed interval values: */
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
+	/* notify the posix timers if wall_time_offset changed */
+	if (leapsecond)
+		clock_was_set();
+
+	/* set us up to go off on the next interval: */
+	mod_timer(&timeofday_timer,
+		jiffies + 1 + msecs_to_jiffies(PERIODIC_INTERVAL_MS));
+}
+
+/**
+ * timeofday_is_continuous - check to see if timekeeping is free running
+ */
+int timeofday_is_continuous(void)
+{
+	unsigned long seq;
+	int ret;
+
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
+	/* initialize the clock variable: */
+	clock = get_next_clocksource();
+
+	/* initialize cycle_last offset base: */
+	cycle_last = read_clocksource(clock);
+
+	/* initialize wall_time_offset to now: */
+	/* XXX - this should be something like ns_to_ktime() */
+	wall_time_offset = ktime_add_ns(wall_time_offset,
+					read_persistent_clock());
+
+	/* initialize timespec values: */
+	wall_time_ts = ktime_to_timespec(ktime_add(system_time,
+						wall_time_offset));
+	monotonic_time_offset_ts = ktime_to_timespec(wall_time_offset);
+
+	/* clear NTP scaling factor & state machine: */
+	ntp_adj = 0;
+	ntp_clear();
+	ts_interval = calculate_clocksource_interval(clock, ntp_adj,
+				INTERVAL_LEN);
+
+	/* initialize legacy time values: */
+	update_legacy_time_values();
+
+	write_sequnlock_irqrestore(&system_time_lock, flags);
+
+	/* install timeofday_periodic_hook timer: */
+	init_timer(&timeofday_timer);
+	timeofday_timer.function = timeofday_periodic_hook;
+	timeofday_timer.expires = jiffies + 1
+				+ msecs_to_jiffies(PERIODIC_INTERVAL_MS);
+	add_timer(&timeofday_timer);
+}
diff --git a/kernel/timer.c b/kernel/timer.c
index a543d54..8d10cd5 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -28,7 +28,7 @@
 #include <linux/swap.h>
 #include <linux/notifier.h>
 #include <linux/thread_info.h>
-#include <linux/time.h>
+#include <linux/timeofday.h>
 #include <linux/jiffies.h>
 #include <linux/posix-timers.h>
 #include <linux/cpu.h>
@@ -882,6 +882,10 @@ void ntp_advance(unsigned long interval_
 	write_sequnlock_irqrestore(&ntp_lock, flags);
 }
 
+#ifdef CONFIG_GENERIC_TIME
+# define update_wall_time(x) do { } while (0)
+#else
+
 /**
  * phase_advance - advance the phase
  *
@@ -957,6 +961,7 @@ static void update_wall_time(unsigned lo
 
 	} while (--ticks);
 }
+#endif /* !CONFIG_GENERIC_TIME */
 
 /*
  * Called from the timer interrupt handler to charge one tick to the current 
