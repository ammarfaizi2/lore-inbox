Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbVLBD1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbVLBD1e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 22:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVLBD12
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 22:27:28 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:5330 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964839AbVLBD1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 22:27:24 -0500
Date: Thu, 1 Dec 2005 20:27:22 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051202032722.19357.37702.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051202032551.19357.51421.sendpatchset@cog.beaverton.ibm.com>
References: <20051202032551.19357.51421.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 13/13] Time: Generic Timekeeping Paraniod Debug Patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

	This patch provides paranoid checking of the timekeeping code. It is
not intended to be submitted to mainline, but to allow developers and
testers using the timeofday patches to better find or rule-out potential
timekeeping problems.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/i386/kernel/tsc.c    |   62 +++++++++++++++++++++++
 arch/x86_64/kernel/time.c |   47 +++++++++++++++++
 include/asm-generic/bug.h |   10 +++
 kernel/time/timeofday.c   |  124 +++++++++++++++++++++++++++++++++++++++++++++-
 lib/Kconfig.debug         |    5 +
 5 files changed, 245 insertions(+), 3 deletions(-)

linux-2.6.15-rc3-mm1_timeofday-paranoid-debug_B12.patch
==========================
diff -ruN tod-mm1/arch/i386/kernel/tsc.c tod-mm2/arch/i386/kernel/tsc.c
--- tod-mm1/arch/i386/kernel/tsc.c	2005-12-01 18:27:29.000000000 -0800
+++ tod-mm2/arch/i386/kernel/tsc.c	2005-12-01 18:28:12.000000000 -0800
@@ -328,6 +328,67 @@
 static unsigned long current_tsc_khz = 0;
 static int tsc_update_callback(void);
 
+#ifdef CONFIG_PARANOID_GENERIC_TIME
+/* This will hurt performance! */
+static DEFINE_SPINLOCK(checktsc_lock);
+static cycle_t last_tsc;
+
+static cycle_t read_tsc(void)
+{
+	static int once = 1;
+
+	unsigned long flags;
+	cycle_t ret;
+
+	spin_lock_irqsave(&checktsc_lock, flags);
+
+	rdtscll(ret);
+
+	if (once && ret < last_tsc) {
+		once = 0;
+		spin_unlock_irqrestore(&checktsc_lock, flags);
+		printk("BUG in read_tsc(): TSC went backward!\n");
+		if (num_online_cpus() > 1)
+			printk("... Unsynced TSCs?\n");
+		printk("... [ from %016Lx to %016Lx ]\n", last_tsc, ret);
+
+	} else {
+		last_tsc = ret;
+		spin_unlock_irqrestore(&checktsc_lock, flags);
+	}
+
+	return ret;
+}
+
+static cycle_t read_tsc_c3(void)
+{
+	static int once = 1;
+
+	unsigned long flags;
+	cycle_t ret;
+
+	spin_lock_irqsave(&checktsc_lock, flags);
+
+	rdtscll(ret);
+	ret += tsc_read_c3_time();
+
+	if (once && ret < last_tsc) {
+		once = 0;
+		spin_unlock_irqrestore(&checktsc_lock, flags);
+		printk("BUG in read_tsc_c3(): TSC went backward!\n");
+		if (num_online_cpus() > 1)
+			printk("... Unsynced TSCs?\n");
+		printk("... [ from %016Lx to %016Lx ]\n", last_tsc, ret);
+	} else {
+		last_tsc = ret;
+		spin_unlock_irqrestore(&checktsc_lock, flags);
+	}
+
+	return ret;
+}
+
+#else /* CONFIG_PARANOID_GENERIC_TIME */
+
 static cycle_t read_tsc(void)
 {
 	cycle_t ret;
@@ -346,6 +407,7 @@
 	return ret + tsc_read_c3_time();
 }
 
+#endif /* CONFIG_PARANOID_GENERIC_TIME */
 
 static struct clocksource clocksource_tsc = {
 	.name			= "tsc",
diff -ruN tod-mm1/arch/x86_64/kernel/time.c tod-mm2/arch/x86_64/kernel/time.c
--- tod-mm1/arch/x86_64/kernel/time.c	2005-12-01 18:28:04.000000000 -0800
+++ tod-mm2/arch/x86_64/kernel/time.c	2005-12-01 18:28:12.000000000 -0800
@@ -1054,16 +1054,50 @@
 
 static int tsc_update_callback(void);
 
+#ifdef CONFIG_PARANOID_GENERIC_TIME
+/* This will hurt performance! */
+static DEFINE_SPINLOCK(checktsc_lock);
+static cycle_t last_tsc;
+
 static cycle_t read_tsc(void)
 {
+	unsigned long flags;
 	cycle_t ret;
 
+	spin_lock_irqsave(&checktsc_lock, flags);
+
 	rdtscll(ret);
 
+	if (ret < last_tsc)
+		printk("read_tsc: ACK! TSC went backward! Unsynced TSCs?\n");
+	last_tsc = ret;
+
+	spin_unlock_irqrestore(&checktsc_lock, flags);
 	return ret;
 }
 
-static cycle_t __vsyscall_fn vread_tsc(void* unused)
+static cycle_t read_tsc_c3(void)
+{
+	unsigned long flags;
+	cycle_t ret;
+
+	spin_lock_irqsave(&checktsc_lock, flags);
+
+	rdtscll(ret);
+	ret += tsc_read_c3_time();
+
+	if (ret < last_tsc)
+		printk("read_tsc_c3: ACK! TSC went backward! Unsynced TSCs?\n");
+	last_tsc = ret;
+
+	spin_unlock_irqrestore(&checktsc_lock, flags);
+
+	return ret;
+}
+
+#else /* CONFIG_PARANOID_GENERIC_TIME */
+
+static cycle_t read_tsc(void)
 {
 	cycle_t ret;
 
@@ -1081,6 +1115,17 @@
 	return ret + tsc_read_c3_time();
 }
 
+#endif /* CONFIG_PARANOID_GENERIC_TIME */
+
+static cycle_t __vsyscall_fn vread_tsc(void* unused)
+{
+	cycle_t ret;
+
+	rdtscll(ret);
+
+	return ret;
+}
+
 static struct clocksource clocksource_tsc = {
 	.name			= "tsc",
 	.rating			= 300,
diff -ruN tod-mm1/include/asm-generic/bug.h tod-mm2/include/asm-generic/bug.h
--- tod-mm1/include/asm-generic/bug.h	2005-12-01 18:13:31.000000000 -0800
+++ tod-mm2/include/asm-generic/bug.h	2005-12-01 18:28:12.000000000 -0800
@@ -39,4 +39,14 @@
 #endif
 #endif
 
+#define WARN_ON_ONCE(condition)		\
+do {					\
+	static int warn_once = 1;	\
+					\
+	if (condition) {		\
+		warn_once = 0;		\
+		WARN_ON(1);		\
+	}				\
+} while (0);
+
 #endif
diff -ruN tod-mm1/kernel/time/timeofday.c tod-mm2/kernel/time/timeofday.c
--- tod-mm1/kernel/time/timeofday.c	2005-12-01 18:23:10.000000000 -0800
+++ tod-mm2/kernel/time/timeofday.c	2005-12-01 18:28:12.000000000 -0800
@@ -121,6 +121,109 @@
  */
 static struct ktimer timeofday_timer;
 
+
+#ifdef CONFIG_PARANOID_GENERIC_TIME
+/* This will hurt performance! */
+static DEFINE_SPINLOCK(check_monotonic_lock);
+static ktime_t last_monotonic_ktime;
+
+static ktime_t get_check_value(void)
+{
+	unsigned long flags;
+	ktime_t ret;
+
+	spin_lock_irqsave(&check_monotonic_lock, flags);
+	ret = last_monotonic_ktime;
+	spin_unlock_irqrestore(&check_monotonic_lock, flags);
+
+	return ret;
+}
+
+static void check_monotonic_clock(ktime_t prev, ktime_t now)
+{
+	unsigned long flags;
+
+	/* check for monotonic inconsistencies */
+	if (ktime_cmp(now, <, prev)) {
+		static int warn = 1;
+
+		if (warn) {
+			warn = 0;
+
+			printk("check_monotonic_clock: monotonic inconsistency"
+					" detected!\n");
+			printk("	from %16Lx (%llu) to %16Lx (%llu).\n",
+					ktime_to_ns(prev),
+					ktime_to_ns(prev),
+					ktime_to_ns(now),
+					ktime_to_ns(now));
+			WARN_ON(1);
+		}
+	}
+	spin_lock_irqsave(&check_monotonic_lock, flags);
+	last_monotonic_ktime = now;
+	spin_unlock_irqrestore(&check_monotonic_lock, flags);
+}
+
+/* timespec version */
+#define check_monotonic_clock_ts(prev, now) \
+	check_monotonic_clock(prev, timespec_to_ktime(now))
+
+/* Call holding atleast a readlock on system_time_lock */
+void verify_timekeeping_state(void)
+{
+	/* ensure all the timespec and ktime values are consistent: */
+	WARN_ON_ONCE(ktime_cmp(system_time, !=,
+			timespec_to_ktime(mono_time_ts)));
+	WARN_ON_ONCE(ktime_cmp(ktime_add(system_time, wall_time_offset), !=,
+			timespec_to_ktime(wall_time_ts)));
+	WARN_ON_ONCE(ktime_cmp(wall_time_offset, !=,
+			timespec_to_ktime(monotonic_time_offset_ts)));
+}
+
+static void check_periodic_interval(cycle_t now)
+{
+	static cycle_t last;
+
+	cycle_t delta;
+	nsec_t ns_offset;
+
+	if (last != 0 && now != 0) {
+		delta = (now - last)& clock->mask;
+
+		ns_offset = cyc2ns(clock, ntp_adj, delta);
+
+		if (ns_offset > (nsec_t)2*PERIODIC_INTERVAL_MS *1000000) {
+			static int warn_count = 10;
+			if (warn_count > 0) {
+				warn_count--;
+				printk("check_periodic_interval: Long interval! %llu.\n",
+								ns_offset);
+				printk("		Something may be blocking interrupts.\n");
+			}
+		}
+		if (ns_offset < (nsec_t)PERIODIC_INTERVAL_MS *1000000) {
+			static int warn_count = 10;
+			if (warn_count > 0) {
+				warn_count--;
+				printk("check_periodic_interval: short interval! %llu.\n",
+								ns_offset);
+				printk("		bad calibration or ktimers may be broken.\n");
+			}
+		}
+	}
+	last = now;
+}
+
+#else /* CONFIG_PARANOID_GENERIC_TIME */
+  /* XXX can we optimize this out? */
+# define get_check_value(void)		ktime_set(0,0)
+# define check_monotonic_clock(x,y)	do { } while (0)
+# define check_monotonic_clock_ts(x,ts)	do { } while (0)
+# define verify_timekeeping_state()	do { } while (0)
+# define check_periodic_interval(x)	do { } while (0)
+#endif /* CONFIG_PARANOID_GENERIC_TIME */
+
 /**
  * update_legacy_time_values - sync legacy time values
  *
@@ -187,7 +290,14 @@
 static inline ktime_t __get_monotonic_clock(void)
 {
 	nsec_t offset = __get_nsec_offset();
-	return ktime_add_ns(system_time, offset);
+#ifdef CONFIG_PARANOID_GENERIC_TIME
+	ktime_t check = get_check_value();
+#endif
+	ktime_t ret;
+
+	ret = ktime_add_ns(system_time, offset);
+	check_monotonic_clock(check,ret);
+	return ret;
 }
 
 /**
@@ -268,6 +378,9 @@
  */
 void get_monotonic_clock_ts(struct timespec *ts)
 {
+#ifdef CONFIG_PARANOID_GENERIC_TIME
+	ktime_t check = get_check_value();
+#endif
 	unsigned long seq;
 	nsec_t offset;
 
@@ -279,6 +392,7 @@
 	} while (read_seqretry(&system_time_lock, seq));
 
 	timespec_add_ns(ts, offset);
+	check_monotonic_clock_ts(check, *ts);
 }
 
 /**
@@ -361,7 +475,9 @@
 	update_legacy_time_values();
 
 	write_sequnlock_irqrestore(&system_time_lock, flags);
-
+#ifdef CONFIG_PARANOID_GENERIC_TIME
+	printk("do_settimeofday() was called!\n");
+#endif
 	/* signal ktimers about time change */
 	clock_was_set();
 
@@ -518,6 +634,7 @@
 
 	/* read time source & calc time since last call: */
 	cycle_now = read_clocksource(clock);
+	check_periodic_interval(cycle_now);
 	cycle_delta = (cycle_now - cycle_last) & clock->mask;
 
 	delta_nsec = cyc2ns_fixed_rem(ts_interval, &cycle_delta, &remainder);
@@ -562,6 +679,7 @@
 		ntp_adj = 0;
 		remainder = 0;
 		something_changed = 1;
+		check_periodic_interval(0);
 	}
 
 	/*
@@ -611,6 +729,8 @@
 
 	update_legacy_time_values();
 
+	verify_timekeeping_state();
+
 	write_sequnlock_irqrestore(&system_time_lock, flags);
 
 	/* set us up to go off on the next interval: */
diff -ruN tod-mm1/lib/Kconfig.debug tod-mm2/lib/Kconfig.debug
--- tod-mm1/lib/Kconfig.debug	2005-12-01 18:13:40.000000000 -0800
+++ tod-mm2/lib/Kconfig.debug	2005-12-01 18:28:12.000000000 -0800
@@ -46,6 +46,11 @@
 		     13 =>  8 KB
 		     12 =>  4 KB
 
+config PARANOID_GENERIC_TIME
+	default y
+	depends on GENERIC_TIME
+	bool "Paraniod Timekeeping Checks"
+
 config DETECT_SOFTLOCKUP
 	bool "Detect Soft Lockups"
 	depends on DEBUG_KERNEL
