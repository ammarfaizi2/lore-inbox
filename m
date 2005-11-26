Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbVKZOxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbVKZOxX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 09:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVKZOxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 09:53:23 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:57556 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964785AbVKZOxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 09:53:19 -0500
Date: Sat, 26 Nov 2005 15:53:20 +0100
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Darren Hart <dvhltc@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       George Anzinger <george@mvista.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/13] Time: Clocksource Infrastructure
Message-ID: <20051126145320.GE12999@elte.hu>
References: <20051122013515.18537.76463.sendpatchset@cog.beaverton.ibm.com> <20051122013535.18537.28613.sendpatchset@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122013535.18537.28613.sendpatchset@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- clean up timeofday-clocksource-core.patch

Signed-off-by: Ingo Molnar <mingo@elte.hu>

 Documentation/kernel-parameters.txt |    2 
 include/linux/clocksource.h         |   43 ++++---
 kernel/time/clocksource.c           |   80 +++++++-------
 kernel/time/jiffies.c               |   23 ++--
 kernel/time/timeofday.c             |  195 +++++++++++++++++-------------------
 5 files changed, 179 insertions(+), 164 deletions(-)

Index: linux/Documentation/kernel-parameters.txt
===================================================================
--- linux.orig/Documentation/kernel-parameters.txt
+++ linux/Documentation/kernel-parameters.txt
@@ -330,7 +330,7 @@ running once the system is up.
 			Value can be changed at runtime via
 				/selinux/checkreqprot.
 
- 	clock=		[BUGS=IA-32, HW] gettimeofday clocksource override.
+	clock=		[BUGS=IA-32, HW] gettimeofday clocksource override.
 			[Deprecated]
 			Forces specified clocksource (if avaliable) to be used
 			when calculating gettimeofday(). If specified
Index: linux/include/linux/clocksource.h
===================================================================
--- linux.orig/include/linux/clocksource.h
+++ linux/include/linux/clocksource.h
@@ -9,11 +9,11 @@
 #define _LINUX_CLOCKSOURCE_H
 
 #include <linux/types.h>
-#include <linux/time.h>
 #include <linux/timex.h>
+#include <linux/time.h>
 #include <linux/list.h>
-#include <asm/io.h>
 #include <asm/div64.h>
+#include <asm/io.h>
 
 /**
  * struct clocksource - hardware abstraction for a free running counter
@@ -47,7 +47,7 @@
  * @vdata:		vsyscall data value passed to read function
  */
 struct clocksource {
-	char* name;
+	char *name;
 	struct list_head list;
 	int rating;
 	cycle_t (*read)(void);
@@ -56,8 +56,8 @@ struct clocksource {
 	u32 shift;
 	int (*update_callback)(void);
 	int is_continuous;
-	cycle_t (*vread)(void*);
-	void* vdata;
+	cycle_t (*vread)(void *);
+	void *vdata;
 };
 
 
@@ -79,8 +79,10 @@ static inline u32 clocksource_khz2mult(u
 	 *  mult = (1000000<<shift) / khz
 	 */
 	u64 tmp = ((u64)1000000) << shift_constant;
+
 	tmp += khz/2; /* round for do_div */
 	do_div(tmp, khz);
+
 	return (u32)tmp;
 }
 
@@ -103,8 +105,10 @@ static inline u32 clocksource_hz2mult(u3
 	 *  mult = (1000000000<<shift) / hz
 	 */
 	u64 tmp = ((u64)1000000000) << shift_constant;
+
 	tmp += hz/2; /* round for do_div */
 	do_div(tmp, hz);
+
 	return (u32)tmp;
 }
 
@@ -143,7 +147,7 @@ static inline int ppm_to_mult_adj(struct
 	 * Thus we want to calculate the value of:
 	 *     mult*ppm/MILL
 	 */
- 	mult_adj = abs(ppm);
+	mult_adj = abs(ppm);
 	mult_adj = (mult_adj * cs->mult)>>SHIFT_USEC;
 	mult_adj += 1000000/2; /* round for div*/
 	do_div(mult_adj, 1000000);
@@ -151,6 +155,7 @@ static inline int ppm_to_mult_adj(struct
 		ret_adj = -(int)mult_adj;
 	else
 		ret_adj = (int)mult_adj;
+
 	return ret_adj;
 }
 
@@ -166,10 +171,11 @@ static inline int ppm_to_mult_adj(struct
  */
 static inline nsec_t cyc2ns(struct clocksource *cs, int ntp_adj, cycle_t cycles)
 {
-	u64 ret;
-	ret = (u64)cycles;
+	u64 ret = (u64)cycles;
+
 	ret *= (cs->mult + ntp_adj);
 	ret >>= cs->shift;
+
 	return (nsec_t)ret;
 }
 
@@ -186,16 +192,18 @@ static inline nsec_t cyc2ns(struct clock
  *
  * XXX - This could use some mult_lxl_ll() asm optimization.
  */
-static inline nsec_t cyc2ns_rem(struct clocksource *cs, int ntp_adj, cycle_t cycles, u64* rem)
+static inline nsec_t cyc2ns_rem(struct clocksource *cs, int ntp_adj,
+				cycle_t cycles, u64* rem)
 {
-	u64 ret;
-	ret = (u64)cycles;
+	u64 ret = (u64)cycles;
+
 	ret *= (cs->mult + ntp_adj);
 	if (rem) {
 		ret += *rem;
 		*rem = ret & ((1<<cs->shift)-1);
 	}
 	ret >>= cs->shift;
+
 	return (nsec_t)ret;
 }
 
@@ -235,7 +243,7 @@ struct clocksource_interval {
  */
 static inline struct clocksource_interval
 calculate_clocksource_interval(struct clocksource *c, long adj,
-				unsigned long length_nsec)
+			       unsigned long length_nsec)
 {
 	struct clocksource_interval ret;
 	u64 tmp;
@@ -270,10 +278,12 @@ calculate_clocksource_interval(struct cl
  *
  * Unless you're the timeofday_periodic_hook, you should not be using this!
  */
-static inline nsec_t cyc2ns_fixed_rem(struct clocksource_interval interval, cycle_t *cycles, u64* rem)
+static inline nsec_t cyc2ns_fixed_rem(struct clocksource_interval interval,
+				      cycle_t *cycles, u64* rem)
 {
 	nsec_t delta_nsec = 0;
-	while(*cycles > interval.cycles) {
+
+	while (*cycles > interval.cycles) {
 		delta_nsec += interval.nsecs;
 		*cycles -= interval.cycles;
 		*rem += interval.remainder;
@@ -282,12 +292,13 @@ static inline nsec_t cyc2ns_fixed_rem(st
 			delta_nsec += 1;
 		}
 	}
+
 	return delta_nsec;
 }
 
-
 /* used to install a new clocksource */
 void register_clocksource(struct clocksource*);
 void reselect_clocksource(void);
 struct clocksource* get_next_clocksource(void);
-#endif
+
+#endif /* _LINUX_CLOCKSOURCE_H */
Index: linux/kernel/time/clocksource.c
===================================================================
--- linux.orig/kernel/time/clocksource.c
+++ linux/kernel/time/clocksource.c
@@ -48,14 +48,13 @@ extern struct clocksource clocksource_ji
 static struct clocksource *curr_clocksource = &clocksource_jiffies;
 static struct clocksource *next_clocksource;
 static LIST_HEAD(clocksource_list);
+/* TODO: why a seqlock? It's only write-locked, so should be a spinlock. */
 static seqlock_t clocksource_lock = SEQLOCK_UNLOCKED;
 
 static char override_name[32];
 
-
 /**
  * get_next_clocksource - Returns the selected clocksource
- *
  */
 struct clocksource *get_next_clocksource(void)
 {
@@ -69,7 +68,6 @@ struct clocksource *get_next_clocksource
 	return curr_clocksource;
 }
 
-
 /**
  * select_clocksource - Finds the best registered clocksource.
  *
@@ -88,20 +86,20 @@ static struct clocksource *select_clocks
 		if (!best)
 			best = src;
 
-		/* Check for override */
+		/* check for override: */
 		if (strlen(src->name) == strlen(override_name) &&
 		    !strcmp(src->name, override_name)) {
 			best = src;
 			break;
 		}
-		/* Pick the highest rating */
+		/* pick the highest rating: */
 		if (src->rating > best->rating)
 		 	best = src;
 	}
+
 	return best;
 }
 
-
 /**
  * is_registered_source - Checks if clocksource is registered
  * @c:		pointer to a clocksource
@@ -112,8 +110,8 @@ static struct clocksource *select_clocks
  */
 static inline int is_registered_source(struct clocksource *c)
 {
-	struct list_head *tmp;
 	int len = strlen(c->name);
+	struct list_head *tmp;
 
 	list_for_each(tmp, &clocksource_list) {
 		struct clocksource *src;
@@ -122,14 +120,13 @@ static inline int is_registered_source(s
 		if (strlen(src->name) == len &&	!strcmp(src->name, c->name))
 			return 1;
 	}
+
 	return 0;
 }
 
-
 /**
  * register_clocksource - Used to install new clocksources
  * @t:		clocksource to be registered
- *
  */
 void register_clocksource(struct clocksource *c)
 {
@@ -146,8 +143,8 @@ void register_clocksource(struct clockso
 	}
 	write_sequnlock(&clocksource_lock);
 }
-EXPORT_SYMBOL(register_clocksource);
 
+EXPORT_SYMBOL(register_clocksource);
 
 /**
  * reselect_clocksource - Rescan list for next clocksource
@@ -163,24 +160,24 @@ void reselect_clocksource(void)
 	write_sequnlock(&clocksource_lock);
 }
 
-
 /**
  * sysfs_show_current_clocksources - sysfs interface for current clocksource
  * @dev:	unused
  * @buf:	char buffer to be filled with clocksource list
  *
- * Provides sysfs interface for listing current clocksource
+ * Provides sysfs interface for listing current clocksource.
  */
-static ssize_t sysfs_show_current_clocksources(struct sys_device *dev,
-			char *buf)
+static ssize_t
+sysfs_show_current_clocksources(struct sys_device *dev, char *buf)
 {
-	char* curr = buf;
+	char *curr = buf;
 
 	write_seqlock(&clocksource_lock);
 	curr += sprintf(curr, "%s ", curr_clocksource->name);
 	write_sequnlock(&clocksource_lock);
 
 	curr += sprintf(curr, "\n");
+
 	return curr - buf;
 }
 
@@ -191,15 +188,16 @@ static ssize_t sysfs_show_current_clocks
  * @count:	length of buffer
  *
  * Takes input from sysfs interface for manually overriding the default
- * clocksource selction
+ * clocksource selction.
  */
 static ssize_t sysfs_override_clocksource(struct sys_device *dev,
-			const char *buf, size_t count)
+					  const char *buf, size_t count)
 {
-	/* Strings from sysfs write are not 0 terminated ! */
+	/* strings from sysfs write are not 0 terminated! */
 	if (count >= sizeof(override_name))
 		return -EINVAL;
-	/* Strip of \n */
+
+	/* strip of \n: */
 	if (buf[count-1] == '\n')
 		count--;
 	if (count < 1)
@@ -207,14 +205,15 @@ static ssize_t sysfs_override_clocksourc
 
 	write_seqlock(&clocksource_lock);
 
-	/* copy the name given */
+	/* copy the name given: */
 	memcpy(override_name, buf, count);
 	override_name[count] = 0;
 
-	/* try to select it */
+	/* try to select it: */
 	next_clocksource = select_clocksource();
 
 	write_sequnlock(&clocksource_lock);
+
 	return count;
 }
 
@@ -225,25 +224,28 @@ static ssize_t sysfs_override_clocksourc
  *
  * Provides sysfs interface for listing registered clocksources
  */
-static ssize_t sysfs_show_available_clocksources(struct sys_device *dev,
-			char *buf)
+static ssize_t
+sysfs_show_available_clocksources(struct sys_device *dev, char *buf)
 {
-	char* curr = buf;
 	struct list_head *tmp;
+	char *curr = buf;
 
 	write_seqlock(&clocksource_lock);
 	list_for_each(tmp, &clocksource_list) {
 		struct clocksource *src;
+
 		src = list_entry(tmp, struct clocksource, list);
 		curr += sprintf(curr, "%s ", src->name);
 	}
 	write_sequnlock(&clocksource_lock);
 
 	curr += sprintf(curr, "\n");
+
 	return curr - buf;
 }
 
-/* Sysfs setup bits:
+/*
+ * Sysfs setup bits:
  */
 static SYSDEV_ATTR(current_clocksource, 0600, sysfs_show_current_clocksources,
 			sysfs_override_clocksource);
@@ -263,28 +265,28 @@ static struct sys_device device_clocksou
 static int init_clocksource_sysfs(void)
 {
 	int error = sysdev_class_register(&clocksource_sysclass);
-	if (!error) {
+
+	if (!error)
 		error = sysdev_register(&device_clocksource);
-		if (!error)
-			error = sysdev_create_file(
-					&device_clocksource,
-					&attr_current_clocksource);
-		if (!error)
-			error = sysdev_create_file(
-					&device_clocksource,
-					&attr_available_clocksource);
-	}
+	if (!error)
+		error = sysdev_create_file(
+				&device_clocksource,
+				&attr_current_clocksource);
+	if (!error)
+		error = sysdev_create_file(
+				&device_clocksource,
+				&attr_available_clocksource);
 	return error;
 }
-device_initcall(init_clocksource_sysfs);
 
+device_initcall(init_clocksource_sysfs);
 
 /**
  * boot_override_clocksource - boot clock override
  * @str:	override name
  *
  * Takes a clocksource= boot argument and uses it
- * as the clocksource override name
+ * as the clocksource override name.
  */
 static int __init boot_override_clocksource(char* str)
 {
@@ -292,8 +294,8 @@ static int __init boot_override_clocksou
 		strlcpy(override_name, str, sizeof(override_name));
 	return 1;
 }
-__setup("clocksource=", boot_override_clocksource);
 
+__setup("clocksource=", boot_override_clocksource);
 
 /**
  * boot_override_clock - Compatibility layer for deprecated boot option
@@ -305,6 +307,8 @@ __setup("clocksource=", boot_override_cl
 static int __init boot_override_clock(char* str)
 {
 	printk("Warning! clock= boot option is deprecated.\n");
+
 	return boot_override_clocksource(str);
 }
+
 __setup("clock=", boot_override_clock);
Index: linux/kernel/time/jiffies.c
===================================================================
--- linux.orig/kernel/time/jiffies.c
+++ linux/kernel/time/jiffies.c
@@ -34,7 +34,7 @@
  * requested HZ value. It is also not reccomended
  * for "tick-less" systems.
  */
-#define NSEC_PER_JIFFY ((u32)((((u64)NSEC_PER_SEC)<<8)/ACTHZ))
+#define NSEC_PER_JIFFY	((u32)((((u64)NSEC_PER_SEC)<<8)/ACTHZ))
 
 /* Since jiffies uses a simple NSEC_PER_JIFFY multiplier
  * conversion, the .shift value could be zero. However
@@ -48,27 +48,28 @@
  * HZ shrinks, so values greater then 8 overflow 32bits when
  * HZ=100.
  */
-#define JIFFIES_SHIFT 8
+#define JIFFIES_SHIFT	8
 
 static cycle_t jiffies_read(void)
 {
-	cycle_t ret = get_jiffies_64();
-	return ret;
+	return (cycle_t) get_jiffies_64();
 }
 
 struct clocksource clocksource_jiffies = {
-	.name = "jiffies",
-	.rating = 0, /* lowest rating*/
-	.read = jiffies_read,
-	.mask = (cycle_t)-1,
-	.mult = NSEC_PER_JIFFY << JIFFIES_SHIFT, /* See above for details */
-	.shift = JIFFIES_SHIFT,
-	.is_continuous = 0,  /* tick based, not free running */
+	.name		= "jiffies",
+	.rating		= 0, /* lowest rating*/
+	.read		= jiffies_read,
+	.mask		= (cycle_t)-1,
+	.mult		= NSEC_PER_JIFFY << JIFFIES_SHIFT, /* details above */
+	.shift		= JIFFIES_SHIFT,
+	.is_continuous	= 0, /* tick based, not free running */
 };
 
 static int __init init_jiffies_clocksource(void)
 {
 	register_clocksource(&clocksource_jiffies);
+
 	return 0;
 }
+
 module_init(init_jiffies_clocksource);
Index: linux/kernel/time/timeofday.c
===================================================================
--- linux.orig/kernel/time/timeofday.c
+++ linux/kernel/time/timeofday.c
@@ -24,15 +24,16 @@
  *   o See XXX's below.
  */
 
-#include <linux/timeofday.h>
 #include <linux/clocksource.h>
-#include <linux/ktime.h>
-#include <linux/timex.h>
+#include <linux/timeofday.h>
+#include <linux/jiffies.h>
+#include <linux/sysdev.h>
 #include <linux/ktimer.h>
 #include <linux/module.h>
+#include <linux/ktime.h>
+#include <linux/timex.h>
 #include <linux/sched.h>
-#include <linux/sysdev.h>
-#include <linux/jiffies.h>
+
 #include <asm/timeofday.h>
 
 /* Periodic hook interval */
@@ -53,11 +54,11 @@ static ktime_t wall_time_offset;
  * performance issues in the userspace syscall paths.
  *
  * wall_time_ts:
- * 	timespec holding the current wall time.
+ *	timespec holding the current wall time.
  * mono_time_ts:
- * 	timespec holding the current monotonic time.
+ *	timespec holding the current monotonic time.
  * monotonic_time_offset_ts:
- * 	timespec holding the difference between wall and monotonic time.
+ *	timespec holding the difference between wall and monotonic time.
  */
 static struct timespec wall_time_ts;
 static struct timespec mono_time_ts;
@@ -89,7 +90,7 @@ static struct clocksource *clock;
 
 /* [NTP adjustment]
  * ntp_adj:
- * 	value of the current ntp adjustment, stored in
+ *	value of the current ntp adjustment, stored in
  *	clocksource multiplier units.
  */
 int ntp_adj;
@@ -123,29 +124,32 @@ struct ktimer timeofday_timer;
 
 #ifdef CONFIG_PARANOID_GENERIC_TIME
 /* This will hurt performance! */
-DEFINE_SPINLOCK(check_monotonic_lock);
-ktime_t last_monotonic_ktime;
+static DEFINE_SPINLOCK(check_monotonic_lock);
+static ktime_t last_monotonic_ktime;
 
-ktime_t get_check_value(void)
+static ktime_t get_check_value(void)
 {
-	ktime_t ret;
 	unsigned long flags;
+	ktime_t ret;
 
 	spin_lock_irqsave(&check_monotonic_lock, flags);
 	ret = last_monotonic_ktime;
 	spin_unlock_irqrestore(&check_monotonic_lock, flags);
+
 	return ret;
 }
 
-void check_monotonic_clock(ktime_t prev, ktime_t now)
+static void check_monotonic_clock(ktime_t prev, ktime_t now)
 {
 	unsigned long flags;
 
 	/* check for monotonic inconsistencies */
-	if(ktime_cmp(now, <, prev)) {
-		static int warn_count = 1;
-		if (warn_count > 0) {
-			warn_count--;
+	if (ktime_cmp(now, <, prev)) {
+		static int warn = 1;
+
+		if (warn) {
+			warn = 0;
+
 			printk("check_monotonic_clock: monotonic inconsistency"
 					" detected!\n");
 			printk("	from %16Lx (%llu) to %16Lx (%llu).\n",
@@ -160,6 +164,7 @@ void check_monotonic_clock(ktime_t prev,
 	last_monotonic_ktime = now;
 	spin_unlock_irqrestore(&check_monotonic_lock, flags);
 }
+
 /* timespec version */
 #define check_monotonic_clock_ts(prev, now) \
 	check_monotonic_clock(prev, timespec_to_ktime(now))
@@ -167,41 +172,28 @@ void check_monotonic_clock(ktime_t prev,
 /* Call holding atleast a readlock on system_time_lock */
 void verify_timekeeping_state(void)
 {
-	static int warn_count = 1;
-	if (warn_count <= 0)
-		return;
-	/* insure all the timespec and ktime values are consistent */
-	if (ktime_cmp(system_time, !=, timespec_to_ktime(mono_time_ts))) {
-		printk("verify_timekeeping_state: system_time != mono_time_ts\n");
-		warn_count--;
-	}
-
-	if (ktime_cmp(ktime_add(system_time, wall_time_offset), !=,
-					 timespec_to_ktime(wall_time_ts))) {
-		printk("verify_timekeeping_state: system_time + wall_time_offset "
-				"!= wall_time_ts\n");
-		warn_count--;
-	}
-
-	if (ktime_cmp(wall_time_offset, !=,
-					 timespec_to_ktime(monotonic_time_offset_ts))) {
-		printk("verify_timekeeping_state: wall_time_offset "
-				"!= monotonic_time_offset_ts\n");
-		warn_count--;
-	}
+	/* ensure all the timespec and ktime values are consistent: */
+	WARN_ON_ONCE(ktime_cmp(system_time, !=,
+			timespec_to_ktime(mono_time_ts)));
+	WARN_ON_ONCE(ktime_cmp(ktime_add(system_time, wall_time_offset), !=,
+			timespec_to_ktime(wall_time_ts)));
+	WARN_ON_ONCE(ktime_cmp(wall_time_offset, !=,
+			timespec_to_ktime(monotonic_time_offset_ts)));
 }
 
-void check_periodic_interval(cycle_t now)
+static void check_periodic_interval(cycle_t now)
 {
 	static cycle_t last;
+
 	cycle_t delta;
 	nsec_t ns_offset;
+
 	if (last != 0 && now != 0) {
 		delta = (now - last)& clock->mask;
 
 		ns_offset = cyc2ns(clock, ntp_adj, delta);
 
-		if(ns_offset > (nsec_t)2*PERIODIC_INTERVAL_MS *1000000) {
+		if (ns_offset > (nsec_t)2*PERIODIC_INTERVAL_MS *1000000) {
 			static int warn_count = 10;
 			if (warn_count > 0) {
 				warn_count--;
@@ -210,7 +202,7 @@ void check_periodic_interval(cycle_t now
 				printk("		Something may be blocking interrupts.\n");
 			}
 		}
-		if(ns_offset < (nsec_t)PERIODIC_INTERVAL_MS *1000000) {
+		if (ns_offset < (nsec_t)PERIODIC_INTERVAL_MS *1000000) {
 			static int warn_count = 10;
 			if (warn_count > 0) {
 				warn_count--;
@@ -224,11 +216,12 @@ void check_periodic_interval(cycle_t now
 }
 
 #else /* CONFIG_PARANOID_GENERIC_TIME */
-#define get_check_value(void) ktime_set(0,0) /* XXX can we optimize this out? */
-#define check_monotonic_clock(x,y) {}
-#define check_monotonic_clock_ts(x,ts)
-#define verify_timekeeping_state()
-#define check_periodic_interval(x)
+  /* XXX can we optimize this out? */
+# define get_check_value(void)		ktime_set(0,0)
+# define check_monotonic_clock(x,y)	do { } while (0)
+# define check_monotonic_clock_ts(x,ts)	do { } while (0)
+# define verify_timekeeping_state()	do { } while (0)
+# define check_periodic_interval(x)	do { } while (0)
 #endif /* CONFIG_PARANOID_GENERIC_TIME */
 
 /**
@@ -269,17 +262,18 @@ static inline nsec_t __get_nsec_offset(v
 	cycle_t cycle_now, cycle_delta;
 	nsec_t ns_offset;
 
-	/* read clocksource */
+	/* read clocksource: */
 	cycle_now = read_clocksource(clock);
 
-	/* calculate the delta since the last timeofday_periodic_hook */
+	/* calculate the delta since the last timeofday_periodic_hook: */
 	cycle_delta = (cycle_now - cycle_last) & clock->mask;
 
-	/* convert to nanoseconds */
+	/* convert to nanoseconds: */
 	ns_offset = cyc2ns(clock, ntp_adj, cycle_delta);
 
-	/* Special case for jiffies tick/offset based systems
-	 * add arch specific offset
+	/*
+	 * special case for jiffies tick/offset based systems,
+	 * add arch-specific offset:
 	 */
 	ns_offset += arch_getoffset();
 
@@ -295,14 +289,15 @@ static inline nsec_t __get_nsec_offset(v
  */
 static inline ktime_t __get_monotonic_clock(void)
 {
-	ktime_t ret;
+	nsec_t offset = __get_nsec_offset();
 #ifdef CONFIG_PARANOID_GENERIC_TIME
 	ktime_t check = get_check_value();
 #endif
-	nsec_t offset = __get_nsec_offset();
+	ktime_t ret;
 	
 	ret = ktime_add_ns(system_time, offset);
 	check_monotonic_clock(check,ret);
+
 	return ret;
 }
 
@@ -385,11 +380,12 @@ ktime_t get_realtime_offset(void)
  */
 void get_monotonic_clock_ts(struct timespec *ts)
 {
-	unsigned long seq;
-	nsec_t offset;
 #ifdef CONFIG_PARANOID_GENERIC_TIME
 	ktime_t check = get_check_value();
 #endif
+	unsigned long seq;
+	nsec_t offset;
+
 	do {
 		seq = read_seqbegin(&system_time_lock);
 
@@ -448,10 +444,11 @@ EXPORT_SYMBOL(get_realtime_clock_ts);
  */
 void do_gettimeofday(struct timeval *tv)
 {
-	struct timespec now_ts;
-	__get_realtime_clock_ts(&now_ts);
-	tv->tv_sec = now_ts.tv_sec;
-	tv->tv_usec = now_ts.tv_nsec/1000;
+	struct timespec now;
+
+	__get_realtime_clock_ts(&now);
+	tv->tv_sec = now.tv_sec;
+	tv->tv_usec = now.tv_nsec/1000;
 }
 
 EXPORT_SYMBOL(do_gettimeofday);
@@ -524,7 +521,8 @@ static int timeofday_suspend_hook(struct
 
 	BUG_ON(time_suspend_state != TIME_RUNNING);
 
-	/* First off, save suspend start time
+	/*
+	 * First off, save suspend start time
 	 * then quickly accumulate the current nsec offset.
 	 * These two calls hopefully occur quickly
 	 * because the difference between reads will
@@ -556,7 +554,8 @@ static int timeofday_resume_hook(struct 
 
 	BUG_ON(time_suspend_state != TIME_SUSPENDED);
 
-	/* Read persistent clock to mark the end of
+	/*
+	 * Read persistent clock to mark the end of
 	 * the suspend interval then rebase the
 	 * cycle_last to current clocksource value.
 	 * Again, time between these two calls will
@@ -566,7 +565,7 @@ static int timeofday_resume_hook(struct 
 	suspend_end = read_persistent_clock();
 	cycle_last = read_clocksource(clock);
 
-	/* calculate suspend time and add it to system time */
+	/* calculate suspend time and add it to system time: */
 	suspend_time = suspend_end - suspend_start;
 	__increment_system_time(suspend_time);
 
@@ -578,7 +577,7 @@ static int timeofday_resume_hook(struct 
 
 	write_sequnlock_irqrestore(&system_time_lock, flags);
 
-	/* inform ktimers about time change */
+	/* inform ktimers about time change: */
 	clock_was_set();
 
 	return 0;
@@ -586,14 +585,14 @@ static int timeofday_resume_hook(struct 
 
 /* sysfs resume/suspend bits */
 static struct sysdev_class timeofday_sysclass = {
-	.resume = timeofday_resume_hook,
-	.suspend = timeofday_suspend_hook,
+	.resume		= timeofday_resume_hook,
+	.suspend	= timeofday_suspend_hook,
 	set_kset_name("timeofday"),
 };
 
 static struct sys_device device_timer = {
-	.id	= 0,
-	.cls	= &timeofday_sysclass,
+	.id		= 0,
+	.cls		= &timeofday_sysclass,
 };
 
 static int timeofday_init_device(void)
@@ -639,7 +638,7 @@ static void timeofday_periodic_hook(void
 
 	write_seqlock_irqsave(&system_time_lock, flags);
 
-	/* read time source & calc time since last call*/
+	/* read time source & calc time since last call: */
 	cycle_now = read_clocksource(clock);
 	check_periodic_interval(cycle_now);
 	cycle_delta = (cycle_now - cycle_last) & clock->mask;
@@ -647,37 +646,37 @@ static void timeofday_periodic_hook(void
 	delta_nsec = cyc2ns_fixed_rem(ts_interval, &cycle_delta, &remainder);
 	cycle_last = (cycle_now - cycle_delta)&clock->mask;
 
-	/* update system_time */
+	/* update system_time:  */
 	__increment_system_time(delta_nsec);
 
-	/* advance the ntp state machine by ns interval*/
+	/* advance the ntp state machine by ns interval: */
 	ntp_advance(delta_nsec);
 
-	/* Only call ntp_leapsecond and ntp_sync once a sec */
+	/* only call ntp_leapsecond and ntp_sync once a sec:  */
 	second_check += delta_nsec;
 	if (second_check >= NSEC_PER_SEC) {
-		/* do ntp leap second processing*/
+		/* do ntp leap second processing: */
 		leapsecond = ntp_leapsecond(wall_time_ts);
 		if (leapsecond) {
 			wall_time_offset = ktime_add_ns(wall_time_offset,
-				 		leapsecond * NSEC_PER_SEC);
+						leapsecond * NSEC_PER_SEC);
 			wall_time_ts.tv_sec += leapsecond;
 			monotonic_time_offset_ts.tv_sec += leapsecond;
 		}
-		/* sync the persistent clock */
+		/* sync the persistent clock: */
 		if (ntp_synced())
 			sync_persistent_clock(wall_time_ts);
 		second_check -= NSEC_PER_SEC;
 	}
 
-	/* if necessary, switch clocksources */
+	/* if necessary, switch clocksources: */
 	next = get_next_clocksource();
 	if (next != clock) {
-		/* immediately set new cycle_last */
+		/* immediately set new cycle_last: */
 		cycle_last = read_clocksource(next);
-		/* update cycle_now to avoid problems in accumulation later */
+		/* update cycle_now to avoid problems in accumulation later: */
 		cycle_now = cycle_last;
-		/* swap clocksources */
+		/* swap clocksources: */
 		old_clock = *clock;
 		clock = next;
 		printk(KERN_INFO "Time: %s clocksource has been installed.\n",
@@ -689,13 +688,14 @@ static void timeofday_periodic_hook(void
 		check_periodic_interval(0);
 	}
 
-	/* now is a safe time, so allow clocksource to adjust
-	 * itself (for example: to make cpufreq changes).
+	/*
+	 * now is a safe time, so allow clocksource to adjust
+	 * itself (for example: to make cpufreq changes):
 	 */
 	if (clock->update_callback) {
 		/* since clocksource state might change,
 		 * keep a copy, but only if we've not
-		 * already changed timesources
+		 * already changed timesources:
 		 */
 		if (!something_changed)
 			old_clock = *clock;
@@ -705,18 +705,18 @@ static void timeofday_periodic_hook(void
 		}
 	}
 
-	/* check for new PPM adjustment */
+	/* check for new PPM adjustment: */
 	ppm = ntp_get_ppm_adjustment();
 	if (ppm_last != ppm) {
-		/* make sure old_clock is set */
+		/* make sure old_clock is set: */
 		if (!something_changed)
 			old_clock = *clock;
 		something_changed = 1;
 	}
 
-	/* if something changed, recalculate the ntp adjustment value */
+	/* if something changed, recalculate the ntp adjustment value: */
 	if (something_changed) {
-		/* accumulate current leftover cycles using old_clock */
+		/* accumulate current leftover cycles using old_clock: */
 		if (cycle_delta) {
 			delta_nsec = cyc2ns_rem(&old_clock, ntp_adj,
 						cycle_delta, &remainder);
@@ -725,7 +725,7 @@ static void timeofday_periodic_hook(void
 			ntp_advance(delta_nsec);
 		}
 
-		/* recalculate the ntp adjustment and fixed interval values */
+		/* recalculate the ntp adjustment and fixed interval values: */
 		ppm_last = ppm;
 		ntp_adj = ppm_to_mult_adj(clock, ppm);
 		ts_interval = calculate_clocksource_interval(clock, ntp_adj,
@@ -738,19 +738,19 @@ static void timeofday_periodic_hook(void
 
 	write_sequnlock_irqrestore(&system_time_lock, flags);
 
-	/* Set us up to go off on the next interval */
+	/* set us up to go off on the next interval: */
 	expire_time = ktime_set(0, PERIODIC_INTERVAL_MS*1000000);
 	ktimer_start(&timeofday_timer, &expire_time, KTIMER_REL);
 }
 
 /**
  * timeofday_is_continuous - check to see if timekeeping is free running
- *
  */
 int timeofday_is_continuous(void)
 {
 	unsigned long seq;
 	int ret;
+
 	do {
 		seq = read_seqbegin(&system_time_lock);
 
@@ -771,35 +771,34 @@ void __init timeofday_init(void)
 
 	write_seqlock_irqsave(&system_time_lock, flags);
 
-	/* initialize the clock variable */
+	/* initialize the clock variable: */
 	clock = get_next_clocksource();
 
-	/* initialize cycle_last offset base */
+	/* initialize cycle_last offset base: */
 	cycle_last = read_clocksource(clock);
 
-	/* initialize wall_time_offset to now*/
+	/* initialize wall_time_offset to now: */
 	/* XXX - this should be something like ns_to_ktime() */
 	wall_time_offset = ktime_add_ns(wall_time_offset,
 					read_persistent_clock());
 
-	/* initialize timespec values */
+	/* initialize timespec values: */
 	ktime_to_timespec(&wall_time_ts,
 				ktime_add(system_time, wall_time_offset));
 	ktime_to_timespec(&monotonic_time_offset_ts, wall_time_offset);
 
-
-	/* clear NTP scaling factor & state machine */
+	/* clear NTP scaling factor & state machine: */
 	ntp_adj = 0;
 	ntp_clear();
 	ts_interval = calculate_clocksource_interval(clock, ntp_adj,
 				INTERVAL_LEN);
 
-	/* initialize legacy time values */
+	/* initialize legacy time values: */
 	update_legacy_time_values();
 
 	write_sequnlock_irqrestore(&system_time_lock, flags);
 
-	/* Install timeofday_periodic_hook timer */
+	/* install timeofday_periodic_hook timer: */
 	ktimer_init(&timeofday_timer);
 	expire_time = ktime_set(0, PERIODIC_INTERVAL_MS*1000000);
 	timeofday_timer.function = timeofday_periodic_hook;
