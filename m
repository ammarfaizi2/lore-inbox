Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbWCRAkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWCRAkG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 19:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932290AbWCRAkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 19:40:06 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:21450 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932295AbWCRAkE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 19:40:04 -0500
Date: Fri, 17 Mar 2006 17:40:02 -0700
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: john stultz <johnstul@us.ibm.com>, george@wildturkeyranch.net,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>, Ingo Molnar <mingo@elte.hu>
Message-Id: <20060318004002.32251.89529.sendpatchset@cog.beaverton.ibm.com>
In-Reply-To: <20060318003955.32251.80532.sendpatchset@cog.beaverton.ibm.com>
References: <20060318003955.32251.80532.sendpatchset@cog.beaverton.ibm.com>
Subject: [PATCH 1/10] Time: Clocksource Infrastructure
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This introduces the clocksource management infrastructure. A 
clocksource is a driver-like architecture generic abstraction of a 
free-running counter. This code defines the clocksource structure, and 
provides management code for registering, selecting, accessing and 
scaling clocksources.

Additionally, this includes the trivial jiffies clocksource, a lowest 
common denominator clocksource, provided mainly for use as an example.

Signed-off-by: John Stultz <johnstul@us.ibm.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Paul Mundt <lethal@linux-sh.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: John Stultz <johnstul@us.ibm.com>

 Documentation/kernel-parameters.txt |   14 +
 include/linux/clocksource.h         |  269 ++++++++++++++++++++++++++++
 kernel/time/Makefile                |    1 
 kernel/time/clocksource.c           |  343 ++++++++++++++++++++++++++++++++++++
 kernel/time/jiffies.c               |   73 +++++++
 5 files changed, 696 insertions(+), 4 deletions(-)

linux-2.6.16-rc6_timeofday-clocksource-core_C0.patch
============================================
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index fc99075..bf5b337 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -52,6 +52,7 @@ restrictions referred to are that the re
 	MTD	MTD support is enabled.
 	NET	Appropriate network support is enabled.
 	NUMA	NUMA support is enabled.
+	GENERIC_TIME The generic timeofday code is enabled.
 	NFS	Appropriate NFS support is enabled.
 	OSS	OSS sound support is enabled.
 	PARIDE	The ParIDE subsystem is enabled.
@@ -329,10 +330,11 @@ running once the system is up.
 			Value can be changed at runtime via
 				/selinux/checkreqprot.
 
- 	clock=		[BUGS=IA-32,HW] gettimeofday timesource override.
-			Forces specified timesource (if avaliable) to be used
-			when calculating gettimeofday(). If specicified
-			timesource is not avalible, it defaults to PIT.
+	clock=		[BUGS=IA-32, HW] gettimeofday clocksource override.
+			[Deprecated]
+			Forces specified clocksource (if avaliable) to be used
+			when calculating gettimeofday(). If specified
+			clocksource is not avalible, it defaults to PIT.
 			Format: { pit | tsc | cyclone | pmtmr }
 
 	disable_8254_timer
@@ -1579,6 +1581,10 @@ running once the system is up.
 
 	time		Show timing data prefixed to each printk message line
 
+	clocksource=	[GENERIC_TIME] Override the default clocksource
+			Override the default clocksource and use the clocksource
+			with the name specified.
+
 	tipar.timeout=	[HW,PPT]
 			Set communications timeout in tenths of a second
 			(default 15).
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
new file mode 100644
index 0000000..c213dee
--- /dev/null
+++ b/include/linux/clocksource.h
@@ -0,0 +1,269 @@
+/*  linux/include/linux/clocksource.h
+ *
+ *  This file contains the structure definitions for clocksources.
+ *
+ *  If you are not a clocksource, or the time of day code, you should
+ *  not be including this file!
+ */
+#ifndef _LINUX_CLOCKSOURCE_H
+#define _LINUX_CLOCKSOURCE_H
+
+#include <linux/types.h>
+#include <linux/timex.h>
+#include <linux/time.h>
+#include <linux/list.h>
+#include <asm/div64.h>
+#include <asm/io.h>
+
+/* clocksource cycle base type */
+typedef u64 cycle_t;
+
+/**
+ * struct clocksource - hardware abstraction for a free running counter
+ *	Provides mostly state-free accessors to the underlying hardware.
+ *
+ * @name:		ptr to clocksource name
+ * @list:		list head for registration
+ * @rating:		rating value for selection (higher is better)
+ *			To avoid rating inflation the following
+ *			list should give you a guide as to how
+ *			to assign your clocksource a rating
+ *			1-99: Unfit for real use
+ *				Only available for bootup and testing purposes.
+ *			100-199: Base level usability.
+ *				Functional for real use, but not desired.
+ *			200-299: Good.
+ *				A correct and usable clocksource.
+ *			300-399: Desired.
+ *				A reasonably fast and accurate clocksource.
+ *			400-499: Perfect
+ *				The ideal clocksource. A must-use where
+ *				available.
+ * @read:		returns a cycle value
+ * @mask:		bitmask for two's complement
+ *			subtraction of non 64 bit counters
+ * @mult:		cycle to nanosecond multiplier
+ * @shift:		cycle to nanosecond divisor (power of two)
+ * @update_callback:	called when safe to alter clocksource values
+ * @is_continuous:	defines if clocksource is free-running.
+ * @vread:		vsyscall read function
+ * @vdata:		vsyscall data value passed to read function
+ * @interval_cycles:	Used internally by timekeeping core, please ignore.
+ * @interval_snsecs:	Used internally by timekeeping core, please ignore.
+ */
+struct clocksource {
+	char *name;
+	struct list_head list;
+	int rating;
+	cycle_t (*read)(void);
+	cycle_t mask;
+	u32 mult;
+	u32 shift;
+	int (*update_callback)(void);
+	int is_continuous;
+	cycle_t (*vread)(void *);
+	void *vdata;
+
+	/* timekeeping specific data, ignore */
+	cycle_t interval_cycles;
+	u64 interval_snsecs;
+};
+
+
+/**
+ * clocksource_khz2mult - calculates mult from khz and shift
+ * @khz:		Clocksource frequency in KHz
+ * @shift_constant:	Clocksource shift factor
+ *
+ * Helper functions that converts a khz counter frequency to a timsource
+ * multiplier, given the clocksource shift value
+ */
+static inline u32 clocksource_khz2mult(u32 khz, u32 shift_constant)
+{
+	/*  khz = cyc/(Million ns)
+	 *  mult/2^shift  = ns/cyc
+	 *  mult = ns/cyc * 2^shift
+	 *  mult = 1Million/khz * 2^shift
+	 *  mult = 1000000 * 2^shift / khz
+	 *  mult = (1000000<<shift) / khz
+	 */
+	u64 tmp = ((u64)1000000) << shift_constant;
+
+	tmp += khz/2; /* round for do_div */
+	do_div(tmp, khz);
+
+	return (u32)tmp;
+}
+
+/**
+ * clocksource_hz2mult - calculates mult from hz and shift
+ * @hz:			Clocksource frequency in Hz
+ * @shift_constant:	Clocksource shift factor
+ *
+ * Helper functions that converts a hz counter
+ * frequency to a timsource multiplier, given the
+ * clocksource shift value
+ */
+static inline u32 clocksource_hz2mult(u32 hz, u32 shift_constant)
+{
+	/*  hz = cyc/(Billion ns)
+	 *  mult/2^shift  = ns/cyc
+	 *  mult = ns/cyc * 2^shift
+	 *  mult = 1Billion/hz * 2^shift
+	 *  mult = 1000000000 * 2^shift / hz
+	 *  mult = (1000000000<<shift) / hz
+	 */
+	u64 tmp = ((u64)1000000000) << shift_constant;
+
+	tmp += hz/2; /* round for do_div */
+	do_div(tmp, hz);
+
+	return (u32)tmp;
+}
+
+/**
+ * read_clocksource: - Access the clocksource's current cycle value
+ * @cs:		pointer to clocksource being read
+ *
+ * Uses the clocksource to return the current cycle_t value
+ */
+static inline cycle_t read_clocksource(struct clocksource *cs)
+{
+	return cs->read();
+}
+
+/**
+ * cyc2ns - converts clocksource cycles to nanoseconds
+ * @cs:		Pointer to clocksource
+ * @cycles:	Cycles
+ *
+ * Uses the clocksource and ntp ajdustment to convert cycle_ts to nanoseconds.
+ *
+ * XXX - This could use some mult_lxl_ll() asm optimization
+ */
+static inline s64 cyc2ns(struct clocksource *cs, cycle_t cycles)
+{
+	u64 ret = (u64)cycles;
+	ret = (ret * cs->mult) >> cs->shift;
+	return ret;
+}
+
+/**
+ * cyc2ns_rem - converts clocksource cycles to nanoseconds w/ remainder
+ * @cs:		Pointer to clocksource
+ * @ntp_adj:	Multiplier adjustment value
+ * @cycles:	Cycles
+ * @rem:	Remainder
+ *
+ * Uses the clocksource and ntp ajdustment interval to convert cycle_t to
+ * nanoseconds. Add in remainder portion which is stored in (ns<<cs->shift)
+ * units and save the new remainder off.
+ *
+ * XXX - This could use some mult_lxl_ll() asm optimization.
+ */
+static inline s64 cyc2ns_rem(struct clocksource *cs, cycle_t cycles,
+					u64* rem)
+{
+	u64 ret = (u64)cycles * cs->mult;
+	if (rem) {
+		ret += *rem;
+		*rem = ret & ((1<<cs->shift)-1);
+	}
+	ret >>= cs->shift;
+
+	return ret;
+}
+
+
+/**
+ * calculate_clocksource_interval - Calculates a clocksource interval struct
+ *
+ * @c:		Pointer to clocksource.
+ * @adj:	Multiplyer adjustment.
+ * @length_nsec: Desired interval length in nanoseconds.
+ *
+ * Calculates a fixed cycle/nsec interval for a given clocksource/adjustment
+ * pair and interval request.
+ *
+ * Unless you're the timekeeping code, you should not be using this!
+ */
+static inline void calculate_clocksource_interval(struct clocksource *c,
+						unsigned long length_nsec)
+{
+	u64 tmp;
+
+	/* XXX - All of this could use a whole lot of optimization */
+	tmp = length_nsec;
+	tmp <<= c->shift;
+	tmp += c->mult/2;
+	do_div(tmp, c->mult);
+
+	c->interval_cycles = (cycle_t)tmp;
+	if(c->interval_cycles == 0)
+		c->interval_cycles = 1;
+
+	c->interval_snsecs = (u64)c->interval_cycles * c->mult;
+}
+
+
+static inline s64 snsec2nsec_rem(u64 snsec, u32 shift, u64* rem)
+{
+	s64 ret = snsec >> shift;
+	if(rem)
+		*rem = snsec & ((1<<shift)-1);
+	return ret;
+}
+
+
+/* XXX - This needs a comment */
+static inline int error_aproximation(u64 error, u64 unit)
+{
+	static int saved_adj = 0;
+	u64 adjusted_unit = unit << saved_adj;
+
+	if (error > (adjusted_unit * 2)) {
+		/* large error, so increment the adjustment factor */
+		saved_adj++;
+	} else if (error > adjusted_unit) {
+		/* just right, don't touch it */
+	} else if (saved_adj) {
+		/* small error, so drop the adjustment factor */
+		saved_adj--;
+		return 0;
+	}
+
+	return saved_adj;
+}
+/* XXX - this needs better comments */
+static inline s64 make_ntp_adj(struct clocksource *clock,
+				cycles_t cycles_delta, s64* error)
+{
+	s64 ret = 0;
+	/* check NTP error */
+	if (*error  > ((s64)clock->interval_cycles+1)/2) {
+		int adj_factor = error_aproximation(*error,
+					clock->interval_cycles);
+		clock->mult += 1 << adj_factor;
+		clock->interval_snsecs += clock->interval_cycles << adj_factor;
+		ret =  -(cycles_delta << adj_factor);
+		*error -= (clock->interval_cycles << adj_factor);
+		/* XXX adj error for cycle_delta offset? */
+	} else if ((-(*error))  > ((s64)clock->interval_cycles+1)/2) {
+		int adj_factor = error_aproximation(-(*error),
+					clock->interval_cycles);
+		clock->mult -= 1 << adj_factor;
+		clock->interval_snsecs -= clock->interval_cycles << adj_factor;
+		ret =  cycles_delta << adj_factor;
+		*error += (clock->interval_cycles << adj_factor);
+		/* XXX adj error for cycle_delta offset? */
+	}
+	return ret;
+}
+
+
+/* used to install a new clocksource */
+int register_clocksource(struct clocksource*);
+void reselect_clocksource(void);
+struct clocksource* get_next_clocksource(void);
+
+#endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/kernel/time/Makefile b/kernel/time/Makefile
new file mode 100644
index 0000000..e1dfd8e
--- /dev/null
+++ b/kernel/time/Makefile
@@ -0,0 +1 @@
+obj-y += clocksource.o jiffies.o
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
new file mode 100644
index 0000000..954a61f
--- /dev/null
+++ b/kernel/time/clocksource.c
@@ -0,0 +1,343 @@
+/*
+ * linux/kernel/time/clocksource.c
+ *
+ * This file contains the functions which manage clocksource drivers.
+ *
+ * Copyright (C) 2004, 2005 IBM, John Stultz (johnstul@us.ibm.com)
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
+ *   o Allow clocksource drivers to be unregistered
+ *   o get rid of clocksource_jiffies extern
+ */
+
+#include <linux/clocksource.h>
+#include <linux/sysdev.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+/* XXX - Would like a better way for initializing curr_clocksource */
+extern struct clocksource clocksource_jiffies;
+
+/*[Clocksource internal variables]---------
+ * curr_clocksource:
+ *	currently selected clocksource. Initialized to clocksource_jiffies.
+ * next_clocksource:
+ *	pending next selected clocksource.
+ * clocksource_list:
+ *	linked list with the registered clocksources
+ * clocksource_lock:
+ *	protects manipulations to curr_clocksource and next_clocksource
+ *	and the clocksource_list
+ * override_name:
+ *	Name of the user-specified clocksource.
+ */
+static struct clocksource *curr_clocksource = &clocksource_jiffies;
+static struct clocksource *next_clocksource;
+static LIST_HEAD(clocksource_list);
+static DEFINE_SPINLOCK(clocksource_lock);
+static char override_name[32];
+static int finished_booting;
+
+/* clocksource_done_booting - Called near the end of bootup
+ *
+ * Hack to avoid lots of clocksource churn at boot time
+ */
+static int clocksource_done_booting(void)
+{
+	finished_booting = 1;
+	return 0;
+}
+
+late_initcall(clocksource_done_booting);
+
+/**
+ * get_next_clocksource - Returns the selected clocksource
+ *
+ */
+struct clocksource *get_next_clocksource(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clocksource_lock, flags);
+	if (next_clocksource && finished_booting) {
+		curr_clocksource = next_clocksource;
+		next_clocksource = NULL;
+	}
+	spin_unlock_irqrestore(&clocksource_lock, flags);
+
+	return curr_clocksource;
+}
+
+/**
+ * select_clocksource - Finds the best registered clocksource.
+ *
+ * Private function. Must hold clocksource_lock when called.
+ *
+ * Looks through the list of registered clocksources, returning
+ * the one with the highest rating value. If there is a clocksource
+ * name that matches the override string, it returns that clocksource.
+ */
+static struct clocksource *select_clocksource(void)
+{
+	struct clocksource *best = NULL;
+	struct list_head *tmp;
+
+	list_for_each(tmp, &clocksource_list) {
+		struct clocksource *src;
+
+		src = list_entry(tmp, struct clocksource, list);
+		if (!best)
+			best = src;
+
+		/* check for override: */
+		if (strlen(src->name) == strlen(override_name) &&
+		    !strcmp(src->name, override_name)) {
+			best = src;
+			break;
+		}
+		/* pick the highest rating: */
+		if (src->rating > best->rating)
+		 	best = src;
+	}
+
+	return best;
+}
+
+/**
+ * is_registered_source - Checks if clocksource is registered
+ * @c:		pointer to a clocksource
+ *
+ * Private helper function. Must hold clocksource_lock when called.
+ *
+ * Returns one if the clocksource is already registered, zero otherwise.
+ */
+static int is_registered_source(struct clocksource *c)
+{
+	int len = strlen(c->name);
+	struct list_head *tmp;
+
+	list_for_each(tmp, &clocksource_list) {
+		struct clocksource *src;
+
+		src = list_entry(tmp, struct clocksource, list);
+		if (strlen(src->name) == len &&	!strcmp(src->name, c->name))
+			return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * register_clocksource - Used to install new clocksources
+ * @t:		clocksource to be registered
+ *
+ * Returns -EBUSY if registration fails, zero otherwise.
+ */
+int register_clocksource(struct clocksource *c)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&clocksource_lock, flags);
+	/* check if clocksource is already registered */
+	if (is_registered_source(c)) {
+		printk("register_clocksource: Cannot register %s. "
+			"Already registered!", c->name);
+		ret = -EBUSY;
+	} else {
+		/* register it */
+ 		list_add(&c->list, &clocksource_list);
+		/* scan the registered clocksources, and pick the best one */
+		next_clocksource = select_clocksource();
+	}
+	spin_unlock_irqrestore(&clocksource_lock, flags);
+	return ret;
+}
+
+EXPORT_SYMBOL(register_clocksource);
+
+/**
+ * reselect_clocksource - Rescan list for next clocksource
+ *
+ * A quick helper function to be used if a clocksource changes its
+ * rating. Forces the clocksource list to be re-scaned for the best
+ * clocksource.
+ */
+void reselect_clocksource(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clocksource_lock, flags);
+	next_clocksource = select_clocksource();
+	spin_unlock_irqrestore(&clocksource_lock, flags);
+}
+
+/**
+ * sysfs_show_current_clocksources - sysfs interface for current clocksource
+ * @dev:	unused
+ * @buf:	char buffer to be filled with clocksource list
+ *
+ * Provides sysfs interface for listing current clocksource.
+ */
+static ssize_t
+sysfs_show_current_clocksources(struct sys_device *dev, char *buf)
+{
+	char *curr = buf;
+
+	spin_lock_irq(&clocksource_lock);
+	curr += sprintf(curr, "%s ", curr_clocksource->name);
+	spin_unlock_irq(&clocksource_lock);
+
+	curr += sprintf(curr, "\n");
+
+	return curr - buf;
+}
+
+/**
+ * sysfs_override_clocksource - interface for manually overriding clocksource
+ * @dev:	unused
+ * @buf:	name of override clocksource
+ * @count:	length of buffer
+ *
+ * Takes input from sysfs interface for manually overriding the default
+ * clocksource selction.
+ */
+static ssize_t sysfs_override_clocksource(struct sys_device *dev,
+					  const char *buf, size_t count)
+{
+	size_t ret = count;
+	/* strings from sysfs write are not 0 terminated! */
+	if (count >= sizeof(override_name))
+		return -EINVAL;
+
+	/* strip of \n: */
+	if (buf[count-1] == '\n')
+		count--;
+	if (count < 1)
+		return -EINVAL;
+
+	spin_lock_irq(&clocksource_lock);
+
+	/* copy the name given: */
+	memcpy(override_name, buf, count);
+	override_name[count] = 0;
+
+	/* try to select it: */
+	next_clocksource = select_clocksource();
+
+	spin_unlock_irq(&clocksource_lock);
+
+	return ret;
+}
+
+/**
+ * sysfs_show_available_clocksources - sysfs interface for listing clocksource
+ * @dev:	unused
+ * @buf:	char buffer to be filled with clocksource list
+ *
+ * Provides sysfs interface for listing registered clocksources
+ */
+static ssize_t
+sysfs_show_available_clocksources(struct sys_device *dev, char *buf)
+{
+	struct list_head *tmp;
+	char *curr = buf;
+
+	spin_lock_irq(&clocksource_lock);
+	list_for_each(tmp, &clocksource_list) {
+		struct clocksource *src;
+
+		src = list_entry(tmp, struct clocksource, list);
+		curr += sprintf(curr, "%s ", src->name);
+	}
+	spin_unlock_irq(&clocksource_lock);
+
+	curr += sprintf(curr, "\n");
+
+	return curr - buf;
+}
+
+/*
+ * Sysfs setup bits:
+ */
+static SYSDEV_ATTR(current_clocksource, 0600, sysfs_show_current_clocksources,
+			sysfs_override_clocksource);
+
+static SYSDEV_ATTR(available_clocksource, 0600,
+			sysfs_show_available_clocksources, NULL);
+
+static struct sysdev_class clocksource_sysclass = {
+	set_kset_name("clocksource"),
+};
+
+static struct sys_device device_clocksource = {
+	.id	= 0,
+	.cls	= &clocksource_sysclass,
+};
+
+static int init_clocksource_sysfs(void)
+{
+	int error = sysdev_class_register(&clocksource_sysclass);
+
+	if (!error)
+		error = sysdev_register(&device_clocksource);
+	if (!error)
+		error = sysdev_create_file(
+				&device_clocksource,
+				&attr_current_clocksource);
+	if (!error)
+		error = sysdev_create_file(
+				&device_clocksource,
+				&attr_available_clocksource);
+	return error;
+}
+
+device_initcall(init_clocksource_sysfs);
+
+/**
+ * boot_override_clocksource - boot clock override
+ * @str:	override name
+ *
+ * Takes a clocksource= boot argument and uses it
+ * as the clocksource override name.
+ */
+static int __init boot_override_clocksource(char* str)
+{
+	spin_lock_irq(&clocksource_lock);
+	if (str)
+		strlcpy(override_name, str, sizeof(override_name));
+	spin_unlock_irq(&clocksource_lock);
+	return 1;
+}
+
+__setup("clocksource=", boot_override_clocksource);
+
+/**
+ * boot_override_clock - Compatibility layer for deprecated boot option
+ * @str:	override name
+ *
+ * DEPRECATED! Takes a clock= boot argument and uses it
+ * as the clocksource override name
+ */
+static int __init boot_override_clock(char* str)
+{
+	printk("Warning! clock= boot option is deprecated.\n");
+
+	return boot_override_clocksource(str);
+}
+
+__setup("clock=", boot_override_clock);
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
new file mode 100644
index 0000000..1fe8376
--- /dev/null
+++ b/kernel/time/jiffies.c
@@ -0,0 +1,73 @@
+/***********************************************************************
+* linux/kernel/time/jiffies.c
+*
+* This file contains the jiffies based clocksource.
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
+#include <linux/clocksource.h>
+#include <linux/jiffies.h>
+#include <linux/init.h>
+
+/* The Jiffies based clocksource is the lowest common
+ * denominator clock source which should function on
+ * all systems. It has the same coarse resolution as
+ * the timer interrupt frequency HZ and it suffers
+ * inaccuracies caused by missed or lost timer
+ * interrupts and the inability for the timer
+ * interrupt hardware to accuratly tick at the
+ * requested HZ value. It is also not reccomended
+ * for "tick-less" systems.
+ */
+#define NSEC_PER_JIFFY	((u32)((((u64)NSEC_PER_SEC)<<8)/ACTHZ))
+
+/* Since jiffies uses a simple NSEC_PER_JIFFY multiplier
+ * conversion, the .shift value could be zero. However
+ * this would make NTP adjustments impossible as they are
+ * in units of 1/2^.shift. Thus we use JIFFIES_SHIFT to
+ * shift both the nominator and denominator the same
+ * amount, and give ntp adjustments in units of 1/2^8
+ *
+ * The value 8 is somewhat carefully chosen, as anything
+ * larger can result in overflows. NSEC_PER_JIFFY grows as
+ * HZ shrinks, so values greater then 8 overflow 32bits when
+ * HZ=100.
+ */
+#define JIFFIES_SHIFT	8
+
+static cycle_t jiffies_read(void)
+{
+	return (cycle_t) jiffies;
+}
+
+struct clocksource clocksource_jiffies = {
+	.name		= "jiffies",
+	.rating		= 0, /* lowest rating*/
+	.read		= jiffies_read,
+	.mask		= 0xffffffff, /*32bits*/
+	.mult		= NSEC_PER_JIFFY << JIFFIES_SHIFT, /* details above */
+	.shift		= JIFFIES_SHIFT,
+	.is_continuous	= 0, /* tick based, not free running */
+};
+
+static int __init init_jiffies_clocksource(void)
+{
+	return register_clocksource(&clocksource_jiffies);
+}
+
+module_init(init_jiffies_clocksource);
