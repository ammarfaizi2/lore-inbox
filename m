Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030353AbVLOCCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030353AbVLOCCn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 21:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030347AbVLOCCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 21:02:42 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:33992 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030296AbVLOCCL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 21:02:11 -0500
Date: Wed, 14 Dec 2005 19:01:59 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>, nikita@clusterfs.com,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       john stultz <johnstul@us.ibm.com>
Message-Id: <20051215020149.25589.85750.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051215020002.25589.55922.sendpatchset@cog.beaverton.ibm.com>
References: <20051215020002.25589.55922.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 13/13] Time: Generic Timekeeping Paraniod Debug Patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

	This patch provides paranoid checking of the timekeeping code. 
It is not intended to be submitted to mainline, but to allow developers 
and testers using the timeofday patches to better find or rule-out 
potential timekeeping problems.

thanks
-john

Signed-off-by: John Stultz <johnstul@us.ibm.com>

 arch/i386/kernel/tsc.c    |   36 +++++++++++++
 arch/x86_64/kernel/time.c |   26 +++++++++
 include/asm-generic/bug.h |   10 +++
 kernel/time/timeofday.c   |  127 +++++++++++++++++++++++++++++++++++++++++++++-
 lib/Kconfig.debug         |    5 +
 5 files changed, 202 insertions(+), 2 deletions(-)

linux-2.6.15-rc5_timeofday-paranoid-debug_B14.patch
============================================
diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
index d9004dc..380402f 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -309,6 +309,40 @@ core_initcall(cpufreq_tsc);
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
+#else /* CONFIG_PARANOID_GENERIC_TIME */
+
 static cycle_t read_tsc(void)
 {
 	cycle_t ret;
@@ -318,6 +352,8 @@ static cycle_t read_tsc(void)
 	return ret;
 }
 
+#endif /* CONFIG_PARANOID_GENERIC_TIME */
+
 static struct clocksource clocksource_tsc = {
 	.name			= "tsc",
 	.rating			= 300,
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index f04724f..03e0f23 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -1044,6 +1044,30 @@ static unsigned long current_tsc_khz = 0
 
 static int tsc_update_callback(void);
 
+#ifdef CONFIG_PARANOID_GENERIC_TIME
+/* This will hurt performance! */
+static DEFINE_SPINLOCK(checktsc_lock);
+static cycle_t last_tsc;
+
+static cycle_t read_tsc(void)
+{
+	unsigned long flags;
+	cycle_t ret;
+
+	spin_lock_irqsave(&checktsc_lock, flags);
+
+	rdtscll(ret);
+
+	if (ret < last_tsc)
+		printk("read_tsc: ACK! TSC went backward! Unsynced TSCs?\n");
+	last_tsc = ret;
+
+	spin_unlock_irqrestore(&checktsc_lock, flags);
+	return ret;
+}
+
+#else /* CONFIG_PARANOID_GENERIC_TIME */
+
 static cycle_t read_tsc(void)
 {
 	cycle_t ret;
@@ -1053,6 +1077,8 @@ static cycle_t read_tsc(void)
 	return ret;
 }
 
+#endif /* CONFIG_PARANOID_GENERIC_TIME */
+
 static cycle_t __vsyscall_fn vread_tsc(void* unused)
 {
 	cycle_t ret;
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 400c2b4..ffab419 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
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
diff --git a/kernel/time/timeofday.c b/kernel/time/timeofday.c
index 2aa595d..aa37e3d 100644
--- a/kernel/time/timeofday.c
+++ b/kernel/time/timeofday.c
@@ -122,6 +122,112 @@ static nsec_t suspend_start;
  */
 static struct timer_list timeofday_timer;
 
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
+	if (now.tv64 < prev.tv64) {
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
+	WARN_ON_ONCE(system_time.tv64 != timespec_to_ktime(mono_time_ts).tv64);
+	WARN_ON_ONCE(ktime_add(system_time, wall_time_offset).tv64 !=
+			timespec_to_ktime(wall_time_ts).tv64);
+	WARN_ON_ONCE(wall_time_offset.tv64 !=
+			timespec_to_ktime(monotonic_time_offset_ts).tv64);
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
+				printk("check_periodic_interval: "
+					"Long interval! %llu ns.\n",
+					ns_offset);
+				printk("		Something may "
+					"be blocking interrupts.\n");
+			}
+		}
+		if (ns_offset < (nsec_t)PERIODIC_INTERVAL_MS *1000000) {
+			static int warn_count = 10;
+			if (warn_count > 0) {
+				warn_count--;
+				printk("check_periodic_interval: "
+					"short interval! %llu ns.\n",
+					ns_offset);
+				printk("		bad calibration "
+					"or timers may be broken.\n");
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
@@ -188,7 +294,14 @@ static inline nsec_t __get_nsec_offset(v
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
@@ -269,6 +382,9 @@ ktime_t get_realtime_offset(void)
  */
 void get_monotonic_clock_ts(struct timespec *ts)
 {
+#ifdef CONFIG_PARANOID_GENERIC_TIME
+	ktime_t check = get_check_value();
+#endif
 	unsigned long seq;
 	nsec_t offset;
 
@@ -280,6 +396,7 @@ void get_monotonic_clock_ts(struct times
 	} while (read_seqretry(&system_time_lock, seq));
 
 	timespec_add_ns(ts, offset);
+	check_monotonic_clock_ts(check, *ts);
 }
 
 /**
@@ -362,7 +479,9 @@ int do_settimeofday(struct timespec *tv)
 	update_legacy_time_values();
 
 	write_sequnlock_irqrestore(&system_time_lock, flags);
-
+#ifdef CONFIG_PARANOID_GENERIC_TIME
+	printk("do_settimeofday() was called!\n");
+#endif
 	/* signal hrtimers about time change */
 	clock_was_set();
 
@@ -518,6 +637,7 @@ static void timeofday_periodic_hook(unsi
 
 	/* read time source & calc time since last call: */
 	cycle_now = read_clocksource(clock);
+	check_periodic_interval(cycle_now);
 	cycle_delta = (cycle_now - cycle_last) & clock->mask;
 
 	delta_nsec = cyc2ns_fixed_rem(ts_interval, &cycle_delta, &remainder);
@@ -562,6 +682,7 @@ static void timeofday_periodic_hook(unsi
 		ntp_adj = 0;
 		remainder = 0;
 		something_changed = 1;
+		check_periodic_interval(0);
 	}
 
 	/*
@@ -611,6 +732,8 @@ static void timeofday_periodic_hook(unsi
 
 	update_legacy_time_values();
 
+	verify_timekeeping_state();
+
 	write_sequnlock_irqrestore(&system_time_lock, flags);
 
 	/* notify the posix timers if wall_time_offset changed */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 156822e..da024c3 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -46,6 +46,11 @@ config LOG_BUF_SHIFT
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
