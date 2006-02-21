Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161396AbWBUGW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161396AbWBUGW6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 01:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbWBUGW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 01:22:26 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:35803 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161396AbWBUGVg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 01:21:36 -0500
Date: Mon, 20 Feb 2006 23:21:34 -0700
From: john stultz <johnstul@us.ibm.com>
To: akpm@osdl.org
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Message-Id: <20060221062133.13304.69898.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
References: <20060221062102.13304.81613.sendpatchset@cog.beaverton.ibm.com>
Subject: [-mm PATCH 5/11] Time: generic timekeeping infrastructure - remove nsec_t
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Removes nsec_t as suggested by Roman Zippel
Also removes cycle_t addition from timekeeping-infrastructure patch

Signed-off-by: John Stultz <johnstul@us.ibm.com>


Index: mm-merge/kernel/time/timeofday.c
===================================================================
--- mm-merge.orig/kernel/time/timeofday.c
+++ mm-merge/kernel/time/timeofday.c
@@ -114,7 +114,7 @@ static enum {
 	TIME_SUSPENDED
 } time_suspend_state = TIME_RUNNING;
 
-static nsec_t suspend_start;
+static s64 suspend_start;
 
 /* [Soft-Timers]
  * timeofday_timer:
@@ -155,10 +155,10 @@ static void update_legacy_time_values(vo
  * called. Returns the number of nanoseconds since the
  * last call to timeofday_periodic_hook() (adjusted by NTP scaling)
  */
-static inline nsec_t __get_nsec_offset(void)
+static inline s64 __get_nsec_offset(void)
 {
 	cycle_t cycle_now, cycle_delta;
-	nsec_t ns_offset;
+	s64 ns_offset;
 
 	/* read clocksource: */
 	cycle_now = read_clocksource(clock);
@@ -187,7 +187,7 @@ static inline nsec_t __get_nsec_offset(v
  */
 static ktime_t __get_monotonic_clock(void)
 {
-	nsec_t offset = __get_nsec_offset();
+	s64 offset = __get_nsec_offset();
 	return ktime_add_ns(system_time, offset);
 }
 
@@ -272,7 +272,7 @@ ktime_t get_realtime_offset(void)
 void get_monotonic_clock_ts(struct timespec *ts)
 {
 	unsigned long seq;
-	nsec_t offset;
+	s64 offset;
 
 	do {
 		seq = read_seqbegin(&system_time_lock);
@@ -294,7 +294,7 @@ void get_monotonic_clock_ts(struct times
 static inline void __get_realtime_clock_ts(struct timespec *ts)
 {
 	unsigned long seq;
-	nsec_t nsecs;
+	s64 nsecs;
 
 	do {
 		seq = read_seqbegin(&system_time_lock);
@@ -432,7 +439,7 @@ static int timeofday_suspend_hook(struct
  */
 static int timeofday_resume_hook(struct sys_device *dev)
 {
-	nsec_t suspend_end, suspend_time;
+	s64 suspend_end, suspend_time;
 	unsigned long flags;
 
 	write_seqlock_irqsave(&system_time_lock, flags);
@@ -506,7 +513,7 @@ static void timeofday_periodic_hook(unsi
 	unsigned long flags;
 
 	cycle_t cycle_now, cycle_delta;
-	nsec_t delta_nsec;
+	s64 delta_nsec;
 	static u64 remainder;
 
 	long leapsecond = 0;
@@ -517,7 +524,7 @@ static void timeofday_periodic_hook(unsi
 
 	int something_changed = 0;
 	struct clocksource old_clock;
-	static nsec_t second_check;
+	static s64 second_check;
 
 	write_seqlock_irqsave(&system_time_lock, flags);
 
Index: mm-merge/include/linux/time.h
===================================================================
--- mm-merge.orig/include/linux/time.h
+++ mm-merge/include/linux/time.h
@@ -27,9 +27,6 @@ struct timezone {
 
 #ifdef __KERNEL__
 
-/* timeofday base types */
-typedef u64 cycle_t;
-
 /* Parameters used to convert the timespec values: */
 #define MSEC_PER_SEC		1000L
 #define USEC_PER_SEC		1000000L
@@ -152,9 +149,9 @@ extern struct timeval ns_to_timeval(cons
 /**
  * timespec_add_ns - Adds nanoseconds to a timespec
  * @a:		pointer to timespec to be incremented
- * @ns:		the nanoseconds value to be added
+ * @ns:		unsigned nanoseconds value to be added
  */
-static inline void timespec_add_ns(struct timespec *a, nsec_t ns)
+static inline void timespec_add_ns(struct timespec *a, u64 ns)
 {
 	ns += a->tv_nsec;
 	while(unlikely(ns >= NSEC_PER_SEC)) {
Index: mm-merge/include/asm-generic/timeofday.h
===================================================================
--- mm-merge.orig/include/asm-generic/timeofday.h
+++ mm-merge/include/asm-generic/timeofday.h
@@ -15,7 +15,7 @@
 
 #ifdef CONFIG_GENERIC_TIME
 /* Required externs */
-extern nsec_t read_persistent_clock(void);
+extern s64 read_persistent_clock(void);
 extern void sync_persistent_clock(struct timespec ts);
 
 #ifdef CONFIG_GENERIC_TIME_VSYSCALL
Index: mm-merge/Documentation/timekeeping.txt
===================================================================
--- mm-merge.orig/Documentation/timekeeping.txt
+++ mm-merge/Documentation/timekeeping.txt
@@ -159,7 +159,7 @@ Porting an arch usually requires the fol
 
 1. Define CONFIG_GENERIC_TIME in the arches Kconfig
 2. Implementing the following functions
-	nsec_t read_persistent_clock(void)
+	s64 read_persistent_clock(void)
 	void sync_persistent_clock(struct timespec ts)
 3. Removing all of the arch specific timekeeping code
 	do_gettimeofday()
