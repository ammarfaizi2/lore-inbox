Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWAPVmr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWAPVmr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 16:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWAPVmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 16:42:47 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:8112 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750765AbWAPVmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 16:42:46 -0500
Subject: Re: first bisection results in -mm3 [was: Re: 2.6.15-mm2: reiser3
	oops on suspend and more (bonus oops shot!)]
From: john stultz <johnstul@us.ibm.com>
To: Mattia Dongili <malattia@linux.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060116204057.GC3639@inferi.kami.home>
References: <20060110235554.GA3527@inferi.kami.home>
	 <20060110170037.4a614245.akpm@osdl.org> <20060111100016.GC2574@elf.ucw.cz>
	 <20060110235554.GA3527@inferi.kami.home>
	 <20060110170037.4a614245.akpm@osdl.org>
	 <20060111184027.GB4735@inferi.kami.home>
	 <20060112220825.GA3490@inferi.kami.home>
	 <1137108362.2890.141.camel@cog.beaverton.ibm.com>
	 <20060114120816.GA3554@inferi.kami.home>
	 <1137442582.27699.12.camel@cog.beaverton.ibm.com>
	 <20060116204057.GC3639@inferi.kami.home>
Content-Type: text/plain
Date: Mon, 16 Jan 2006 13:42:43 -0800
Message-Id: <1137447763.27699.27.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-16 at 21:40 +0100, Mattia Dongili wrote:
> On Mon, Jan 16, 2006 at 12:16:21PM -0800, john stultz wrote:
> > On Sat, 2006-01-14 at 13:08 +0100, Mattia Dongili wrote:
> > > On Thu, Jan 12, 2006 at 03:26:01PM -0800, john stultz wrote:
> [...]
> > > > Few things to try (independently):
> > > > 1. Does booting w/ idle=poll change the behavior?
> > > 
> > > yes, no more stalls
> > 
> > Ok, this points to the TSC is changing frequency (likely due to C3
> > halting). 
> 
> humm... no C3 state here :) did you mean this C3?
> # cat /proc/acpi/processor/CPU0/power
> active state:            C2
> max_cstate:              C8
> bus master activity:     00000000
> states:
>     C1:                  type[C1] promotion[C2] demotion[--] latency[000] usage[00007790]
>    *C2:                  type[C2] promotion[--] demotion[C1] latency[010] usage[02310093]

Hrmm. Interesting. I'm not aware of C2 causing TSC stalls. This may be
in part why we don't disable the TSC earlier.


> > > > 2. Does booting w/ clocksource=jiffies change the behavior?
> > > 
> > > yes, same as above
> > 
> > Ok, good, interrupts are getting there at the right frequency.
> > 
> > > > 3. After booting up, run: 
> > > >    echo tsc > /sys/devices/system/clocksource/clocksource0/current_clocksource
> > > >    And check that the system keeps accurate time.
> > > 
> > > didn't try as there seems to be no problem in timekeeping
> > 
> > Well, it would have re-inforced the TSC being the issue, but I'm fairly
> > confident that that is the case.
> 
> Now that filesystem problems have gone I have longer uptimes. OhOhOh,
> very funnny, echoing tsc into the mentioned sysfs entry makes the clock
> almost completely stop:
> # date
> Mon Jan 16 21:29:26 CET 2006
> now count with me 1..2..3..4..5
> # date
> Mon Jan 16 21:29:27 CET 2006
> 
> I'd say the time is far from being accurate.

Ok, as I thought. Although 5:1 seems a bit large for cpufreq scaling. It
does appear that the TSC is halting. 


> > My theory: The stalls are due to the TSC frequency not being consistent
> > for the small window at boot between when it is installed and when the
> > ACPI PM clocksource is installed.
> 
> seems you're right, issuing a 'sleep 1' takes ages before it returns and
> it's exactely where the boot process got stuck.
> 
> > I'll try to narrow that window down a bit and see if that doesn't
> > resolve the issue.
> 
> I'll be happy to test new patches if necessary (I'm running -mm4)

Below is a patch that should provide a bit more debug info. If you
could, boot up w/ it (be sure to enable CONFIG_PARANOID_GENERIC_TIME)
and send me your dmesg.

thanks
-john


diff --git a/arch/i386/kernel/tsc.c b/arch/i386/kernel/tsc.c
index cab2546..5291722 100644
--- a/arch/i386/kernel/tsc.c
+++ b/arch/i386/kernel/tsc.c
@@ -61,6 +61,15 @@ static inline int check_tsc_unstable(voi
 
 void mark_tsc_unstable(void)
 {
+#ifdef CONFIG_PARANOID_GENERIC_TIME
+	/* give a clue as to why the TSC is unstable */
+	static int warncount=0;
+	if(warncount < 10) {
+		warncount++;
+		printk("TSC: Marked unstable\n");
+		dump_stack();
+	}
+#endif
 	tsc_unstable = 1;
 }
 EXPORT_SYMBOL_GPL(mark_tsc_unstable);
@@ -317,15 +326,62 @@ core_initcall(cpufreq_tsc);
 static unsigned long current_tsc_khz = 0;
 static int tsc_update_callback(void);
 
+#ifdef CONFIG_PARANOID_GENERIC_TIME
+/* This will hurt performance! */
+static DEFINE_SPINLOCK(checktsc_lock);
+static cycle_t last_tsc;
+
 static cycle_t read_tsc(void)
 {
+	static int once = 1;
+
+	unsigned long flags;
 	cycle_t ret;
 
+	spin_lock_irqsave(&checktsc_lock, flags);
+
 	rdtscll(ret);
 
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
 	return ret;
 }
 
+static struct clocksource clocksource_tsc;
+
+void tsc_print_debuginfo(void)
+{
+	printk("TSC clocksource: %lu khz, rating=%lu mult=%lu shift=%lu\n",
+		current_tsc_khz, clocksource_tsc.rating,
+		clocksource_tsc.mult, clocksource_tsc.shift);
+}
+
+#else /* CONFIG_PARANOID_GENERIC_TIME */
+
+
+static cycle_t read_tsc(void)
+{
+	cycle_t ret;
+
+	rdtscll(ret);
+
+	return ret;
+}
+
+#define tsc_print_debuginfo()
+#endif /* CONFIG_PARANOID_GENERIC_TIME */
+
 static struct clocksource clocksource_tsc = {
 	.name			= "tsc",
 	.rating			= 300,
@@ -341,6 +397,10 @@ static int tsc_update_callback(void)
 {
 	int change = 0;
 
+	static int dbug_count;
+	if (!(dbug_count++ % 1000))
+		tsc_print_debuginfo();
+
 	/* check to see if we should switch to the safe clocksource: */
 	if (clocksource_tsc.rating != 50 && check_tsc_unstable()) {
 		clocksource_tsc.rating = 50;
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
index 300a8ce..4be96a8 100644
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
 static ktime_t __get_monotonic_clock(void)
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
index a314e66..3616828 100644
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


