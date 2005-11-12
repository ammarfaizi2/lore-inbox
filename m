Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751364AbVKLEwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbVKLEwi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 23:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVKLEwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 23:52:24 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:32674 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932073AbVKLEuU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 23:50:20 -0500
Date: Fri, 11 Nov 2005 21:50:18 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>
Message-Id: <20051112045017.8240.35860.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
References: <20051112044850.8240.91581.sendpatchset@cog.beaverton.ibm.com>
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

 arch/i386/Kconfig         |    3 +
 arch/i386/kernel/tsc.c    |   41 ++++++++++++++++
 arch/x86_64/Kconfig       |    3 +
 arch/x86_64/kernel/time.c |   49 +++++++++++++++++++
 kernel/time/timeofday.c   |  114 +++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 209 insertions(+), 1 deletion(-)

linux-2.6.14_timeofday-paranoid-debug_B10.patch
============================================
diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index 8408da2..716414e 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -18,6 +18,9 @@ config GENERIC_TIME
 	bool
 	default y
 
+config PARANOID_GENERIC_TIME
+	bool "Paraniod Timekeeping Checks"
+
 config SEMAPHORE_SLEEPERS
 	bool
 	default y
diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
index 3f9d1e8..73b2a03 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -313,6 +313,46 @@ core_initcall(cpufreq_tsc);
 static unsigned long current_tsc_khz = 0;
 static int tsc_update_callback(void);
 
+#ifdef CONFIG_PARANOID_GENERIC_TIME
+/* This will hurt performance! */
+DEFINE_SPINLOCK(checktsc_lock);
+cycle_t last_tsc;
+
+static cycle_t read_tsc(void)
+{
+	cycle_t ret;
+	unsigned long flags;
+	spin_lock_irqsave(&checktsc_lock, flags);
+
+	rdtscll(ret);
+
+	if(ret < last_tsc)
+		printk("read_tsc: ACK! TSC went backward! Unsynced TSCs?\n");
+	last_tsc = ret;
+
+	spin_unlock_irqrestore(&checktsc_lock, flags);
+	return ret;
+}
+
+static cycle_t read_tsc_c3(void)
+{
+	cycle_t ret;
+	unsigned long flags;
+	spin_lock_irqsave(&checktsc_lock, flags);
+
+	rdtscll(ret);
+	ret += tsc_read_c3_time();
+
+	if(ret < last_tsc)
+		printk("read_tsc_c3: ACK! TSC went backward! Unsynced TSCs?\n");
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
@@ -327,6 +367,7 @@ static cycle_t read_tsc_c3(void)
 	return ret + tsc_read_c3_time();
 }
 
+#endif /* CONFIG_PARANOID_GENERIC_TIME */
 
 static struct clocksource clocksource_tsc = {
 	.name = "tsc",
diff --git a/arch/x86_64/Kconfig b/arch/x86_64/Kconfig
index 19b113e..4d2be52 100644
--- a/arch/x86_64/Kconfig
+++ b/arch/x86_64/Kconfig
@@ -32,6 +32,9 @@ config GENERIC_TIME_VSYSCALL
        bool
        default y
 
+config PARANOID_GENERIC_TIME
+	bool "Paraniod Timekeeping Checks"
+
 config SEMAPHORE_SLEEPERS
 	bool
 	default y
diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
index 3a44861..376aa80 100644
--- a/arch/x86_64/kernel/time.c
+++ b/arch/x86_64/kernel/time.c
@@ -1051,6 +1051,53 @@ __setup("notsc", notsc_setup);
 static unsigned long current_tsc_khz = 0;
 static int tsc_update_callback(void);
 
+#ifdef CONFIG_PARANOID_GENERIC_TIME
+/* This will hurt performance! */
+DEFINE_SPINLOCK(checktsc_lock);
+cycle_t last_tsc;
+
+static cycle_t read_tsc(void)
+{
+	cycle_t ret;
+	unsigned long flags;
+	spin_lock_irqsave(&checktsc_lock, flags);
+
+	rdtscll(ret);
+
+	if(ret < last_tsc)
+		printk("read_tsc: ACK! TSC went backward! Unsynced TSCs?\n");
+	last_tsc = ret;
+
+	spin_unlock_irqrestore(&checktsc_lock, flags);
+	return ret;
+}
+
+static cycle_t __vsyscall_fn vread_tsc(void* unused)
+{
+	cycle_t ret;
+	rdtscll(ret);
+	return ret;
+}
+
+static cycle_t read_tsc_c3(void)
+{
+	cycle_t ret;
+	unsigned long flags;
+	spin_lock_irqsave(&checktsc_lock, flags);
+
+	rdtscll(ret);
+	ret += tsc_read_c3_time();
+
+	if(ret < last_tsc)
+		printk("read_tsc_c3: ACK! TSC went backward! Unsynced TSCs?\n");
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
@@ -1072,6 +1119,8 @@ static cycle_t read_tsc_c3(void)
 	return ret + tsc_read_c3_time();
 }
 
+#endif /* CONFIG_PARANOID_GENERIC_TIME */
+
 static struct clocksource clocksource_tsc = {
 	.name = "tsc",
 	.rating = 300,
diff --git a/kernel/time/timeofday.c b/kernel/time/timeofday.c
index 42ec5fc..ce3fd87 100644
--- a/kernel/time/timeofday.c
+++ b/kernel/time/timeofday.c
@@ -120,6 +120,108 @@ static nsec_t suspend_start;
  */
 struct ktimer timeofday_timer;
 
+
+#ifdef CONFIG_PARANOID_GENERIC_TIME
+/* This will hurt performance! */
+DEFINE_SPINLOCK(check_monotonic_lock);
+ktime_t last_monotonic_ktime;
+
+ktime_t get_check_value(void)
+{
+	ktime_t ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&check_monotonic_lock, flags);
+	ret = last_monotonic_ktime;
+	spin_unlock_irqrestore(&check_monotonic_lock, flags);
+	return ret;
+}
+
+void check_monotonic_clock(ktime_t prev, ktime_t now)
+{
+	unsigned long flags;
+
+	/* check for monotonic inconsistencies */
+	if(ktime_cmp(now, <, prev)) {
+		static int warn_count = 10;
+		if (warn_count > 0) {
+			warn_count--;
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
+/* timespec version */
+#define check_monotonic_clock_ts(prev, now) \
+	check_monotonic_clock(prev, timespec_to_ktime(now))
+
+/* Call holding atleast a readlock on system_time_lock */
+void verify_timekeeping_state(void)
+{
+	static int warn_count = 10;
+	if (warn_count <= 0)
+		return;
+	/* insure all the timespec and ktime values are consistent */
+	if (ktime_cmp(system_time, !=, timespec_to_ktime(mono_time_ts))) {
+		printk("verify_timekeeping_state: system_time != mono_time_ts\n");
+		warn_count--;
+	}
+
+	if (ktime_cmp(ktime_add(system_time, wall_time_offset), !=,
+					 timespec_to_ktime(wall_time_ts))) {
+		printk("verify_timekeeping_state: system_time + wall_time_offset "
+				"!= wall_time_ts\n");
+		warn_count--;
+	}
+
+	if (ktime_cmp(wall_time_offset, !=,
+					 timespec_to_ktime(monotonic_time_offset_ts))) {
+		printk("verify_timekeeping_state: wall_time_offset "
+				"!= monotonic_time_offset_ts\n");
+		warn_count--;
+	}
+}
+
+void check_periodic_interval(cycle_t now)
+{
+	static cycle_t last;
+	cycle_t delta;
+	nsec_t ns_offset;
+	if (last != 0 && now != 0) {
+		delta = (now - last)& clock->mask;
+
+		ns_offset = cyc2ns(clock, ntp_adj, delta);
+
+		if(ns_offset > (nsec_t)2*PERIODIC_INTERVAL_MS *1000000) {
+			static int warn_count = 10;
+			if (warn_count > 0) {
+				warn_count--;
+				printk("check_periodic_interval: Long interval! %llu.\n",
+								ns_offset);
+				printk("		Something may be blocking interrupts.\n");
+			}
+		}
+	}
+	last = now;
+}
+
+#else /* CONFIG_PARANOID_GENERIC_TIME */
+#define get_check_value(void) ktime_set(0,0) /* XXX can we optimize this out? */
+#define check_monotonic_clock(x,y) {}
+#define check_monotonic_clock_ts(x,ts)
+#define verify_timekeeping_state()
+#define check_periodic_interval(x)
+#endif /* CONFIG_PARANOID_GENERIC_TIME */
+
 /**
  * update_legacy_time_values - sync legacy time values
  *
@@ -184,8 +286,12 @@ static inline nsec_t __get_nsec_offset(v
  */
 static inline ktime_t __get_monotonic_clock(void)
 {
+	ktime_t ret;
+	ktime_t check = get_check_value();
 	nsec_t offset = __get_nsec_offset();
-	return ktime_add_ns(system_time, offset);
+	ret = ktime_add_ns(system_time, offset);
+	check_monotonic_clock(check,ret);
+	return ret;
 }
 
 /**
@@ -269,6 +375,7 @@ void get_monotonic_clock_ts(struct times
 {
 	unsigned long seq;
 	nsec_t offset;
+	ktime_t check = get_check_value();
 
 	do {
 		seq = read_seqbegin(&system_time_lock);
@@ -278,6 +385,7 @@ void get_monotonic_clock_ts(struct times
 	} while (read_seqretry(&system_time_lock, seq));
 
 	timespec_add_ns(ts, offset);
+	check_monotonic_clock_ts(check, *ts);
 }
 
 /**
@@ -518,6 +626,7 @@ static void timeofday_periodic_hook(void
 
 	/* read time source & calc time since last call*/
 	cycle_now = read_clocksource(clock);
+	check_periodic_interval(cycle_now);
 	cycle_delta = (cycle_now - cycle_last) & clock->mask;
 
 	delta_nsec = cyc2ns_fixed_rem(ts_interval, &cycle_delta, &remainder);
@@ -562,6 +671,7 @@ static void timeofday_periodic_hook(void
 		ntp_adj = 0;
 		remainder = 0;
 		something_changed = 1;
+		check_periodic_interval(0);
 	}
 
 	/* now is a safe time, so allow clocksource to adjust
@@ -609,6 +719,8 @@ static void timeofday_periodic_hook(void
 
 	update_legacy_time_values();
 
+	verify_timekeeping_state();
+
 	write_sequnlock_irqrestore(&system_time_lock, flags);
 
 	/* Set us up to go off on the next interval */
