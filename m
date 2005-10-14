Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932562AbVJNCLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbVJNCLw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 22:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbVJNCLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 22:11:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:12224 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932562AbVJNCLu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 22:11:50 -0400
Subject: [RFC][PATCH 3/12] clocksource management code
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Frank Sorenson <frank@tuxrocks.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <dvhltc@us.ibm.com>
In-Reply-To: <1129255831.27168.29.camel@cog.beaverton.ibm.com>
References: <1129255182.27168.14.camel@cog.beaverton.ibm.com>
	 <1129255761.27168.26.camel@cog.beaverton.ibm.com>
	 <1129255831.27168.29.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 13 Oct 2005 19:11:46 -0700
Message-Id: <1129255906.27168.32.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch introduces the clocksource management infrastructure. A
clocksource is a driver-like architecture generic abstraction of a
freerunning counter. This patch defines the clocksource structure, and
provides management code for registering, selecting, accessing and
scaling clocksources. The clocksource structure is influenced by the
time_interpolator code, although I feel it has a cleaner interface and
avoids preserving system state in the clocksource structure.

Additionally, this patch includes the trivial jiffies clocksource, a
lowest common denominator clocksource, provided mainly for use as an
example.

This patch applies ontop of my part 2 of my ntp changes.

Since this patch provides the groundwork for the generic timeofday core,
it will not function without the generic timeofday patches to follow.


thanks
-john

 Documentation/kernel-parameters.txt |   11 +
 drivers/Makefile                    |    1 
 drivers/clocksource/Makefile        |    1 
 drivers/clocksource/jiffies.c       |   74 +++++++++
 include/linux/clocksource.h         |  269 ++++++++++++++++++++++++++++++++++
 kernel/clocksource.c                |  279 ++++++++++++++++++++++++++++++++++++
 6 files changed, 632 insertions(+), 3 deletions(-)

linux-2.6.14-rc4_timeofday-clocksource-core_B7.patch
============================================
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -52,6 +52,7 @@ restrictions referred to are that the re
 	MTD	MTD support is enabled.
 	NET	Appropriate network support is enabled.
 	NUMA	NUMA support is enabled.
+	GENERIC_TOD The generic timeofday code is enabled.
 	NFS	Appropriate NFS support is enabled.
 	OSS	OSS sound support is enabled.
 	PARIDE	The ParIDE subsystem is enabled.
@@ -323,9 +324,9 @@ running once the system is up.
 			Default value is set via a kernel config option.
 			Value can be changed at runtime via /selinux/checkreqprot.
  
- 	clock=		[BUGS=IA-32, HW] gettimeofday timesource override. 
-			Forces specified timesource (if avaliable) to be used
-			when calculating gettimeofday(). If specicified timesource
+ 	clock=		[BUGS=IA-32, HW] gettimeofday clocksource override. [Deprecated]
+			Forces specified clocksource (if avaliable) to be used
+			when calculating gettimeofday(). If specicified clocksource
 			is not avalible, it defaults to PIT. 
 			Format: { pit | tsc | cyclone | pmtmr }
 
@@ -1462,6 +1463,10 @@ running once the system is up.
 
 	time		Show timing data prefixed to each printk message line
 
+	clocksource=		[GENERIC_TOD] Override the default clocksource
+			Override the default clocksource and use the clocksource
+			with the name specified.
+
 	tipar.timeout=	[HW,PPT]
 			Set communications timeout in tenths of a second
 			(default 15).
diff --git a/drivers/Makefile b/drivers/Makefile
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -67,3 +67,4 @@ obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-$(CONFIG_SGI_IOC4)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
+obj-$(CONFIG_GENERICTOD)		+= clocksource/
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
new file mode 100644
--- /dev/null
+++ b/drivers/clocksource/Makefile
@@ -0,0 +1 @@
+obj-y += jiffies.o
diff --git a/drivers/clocksource/jiffies.c b/drivers/clocksource/jiffies.c
new file mode 100644
--- /dev/null
+++ b/drivers/clocksource/jiffies.c
@@ -0,0 +1,74 @@
+/***********************************************************************
+* linux/drivers/clocksource/jiffies.c
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
+#define NSEC_PER_JIFFY ((u32)((((u64)NSEC_PER_SEC)<<8)/ACTHZ))
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
+#define JIFFIES_SHIFT 8
+
+static cycle_t jiffies_read(void)
+{
+	cycle_t ret = get_jiffies_64();
+	return ret;
+}
+
+struct clocksource clocksource_jiffies = {
+	.name = "jiffies",
+	.rating = 0, /* lowest rating*/
+	.type = CLOCKSOURCE_FUNCTION,
+	.read_fnct = jiffies_read,
+	.mask = (cycle_t)-1,
+	.mult = NSEC_PER_JIFFY << JIFFIES_SHIFT, /* See above for details */
+	.shift = JIFFIES_SHIFT,
+};
+
+static int __init init_jiffies_clocksource(void)
+{
+	register_clocksource(&clocksource_jiffies);
+	return 0;
+}
+module_init(init_jiffies_clocksource);
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
new file mode 100644
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
+#include <linux/time.h>
+#include <linux/timex.h>
+#include <linux/list.h>
+#include <asm/io.h>
+#include <asm/div64.h>
+
+/* struct clocksource:
+ *      Provides mostly state-free accessors to the underlying hardware.
+ *
+ * name:                ptr to clocksource name
+ * list:                list head for registration
+ * rating:              rating value for selection (higher is better)
+ *                      To avoid rating inflation the following
+ *                      list should give you a guide as to how
+ *                      to assign your clocksource a rating
+ *                      1-99: Unfit for real use
+ *                          Only available for bootup and testing purposes.
+ *                      100-199: Base level usability.
+ *                          Functional for real use, but not desired.
+ *                      200-299: Good.
+ *                           A correct and usable clocksource.
+ *                      300-399: Desired.
+ *                           A reasonably fast and accurate clocksource.
+ *                      400-499: Perfect
+ *                           The ideal clocksource. A must-use where available.
+ * type:                defines clocksource type
+ * @read_fnct:          returns a cycle value
+ * ptr:                 ptr to MMIO'ed counter
+ * mask:                bitmask for two's complement
+ *                      subtraction of non 64 bit counters
+ * mult:                cycle to nanosecond multiplier
+ * shift:               cycle to nanosecond divisor (power of two)
+ * @update_callback:    called when safe to alter clocksource values
+ */
+struct clocksource {
+	char* name;
+	struct list_head list;
+	int rating;
+	enum {
+		CLOCKSOURCE_FUNCTION,
+		CLOCKSOURCE_CYCLES,
+		CLOCKSOURCE_MMIO_32,
+		CLOCKSOURCE_MMIO_64
+	} type;
+	cycle_t (*read_fnct)(void);
+	void __iomem *mmio_ptr;
+	cycle_t mask;
+	u32 mult;
+	u32 shift;
+	int (*update_callback)(void);
+};
+
+
+/* Helper functions that converts a khz counter
+ * frequency to a timsource multiplier, given the
+ * clocksource shift value
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
+	tmp += khz/2; /* round for do_div */
+	do_div(tmp, khz);
+	return (u32)tmp;
+}
+
+/* Helper functions that converts a hz counter
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
+	tmp += hz/2; /* round for do_div */
+	do_div(tmp, hz);
+	return (u32)tmp;
+}
+
+
+#ifndef readq
+/* Provide an a way to atomically read a u64 on a 32bit arch */
+static inline unsigned long long clocksource_readq(void __iomem *addr)
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
+#define clocksource_readq(x) readq(x)
+#endif
+
+
+/* read_clocksource():
+ *      Uses the clocksource to return the current cycle_t value
+ */
+static inline cycle_t read_clocksource(struct clocksource *cs)
+{
+	switch (cs->type) {
+	case CLOCKSOURCE_MMIO_32:
+		return (cycle_t)readl(cs->mmio_ptr);
+	case CLOCKSOURCE_MMIO_64:
+		return (cycle_t)clocksource_readq(cs->mmio_ptr);
+	case CLOCKSOURCE_CYCLES:
+		return (cycle_t)get_cycles();
+	default:/* case: CLOCKSOURCE_FUNCTION */
+		return cs->read_fnct();
+	}
+}
+
+/* ppm_to_mult_adj():
+ *      Helper which converts a shifted ppm value to
+ *      clocksource mult_adj value,
+ *
+ *      XXX - this could use some optimization
+ */
+static inline int ppm_to_mult_adj(struct clocksource *cs, int ppm)
+{
+	u64 mult_adj;
+	int ret_adj;
+
+	/* The basic math is as follows:
+	 *     cyc * mult/2^shift * (1 + ppm/MILL) = scaled ns
+	 * We want to precalculate the ppm factor so it can be added
+	 * to the multiplyer saving the extra multiplication step.
+	 *     cyc * (mult/2^shift + (mult/2^shift) * (ppm/MILL)) =
+	 *     cyc * (mult/2^shift + (mult*ppm/MILL)/2^shift) =
+	 *     cyc * (mult + (mult*ppm/MILL))/2^shift =
+	 * Thus we want to calculate the value of:
+	 *     mult*ppm/MILL
+	 */
+ 	mult_adj = abs(ppm);
+	mult_adj = (mult_adj * cs->mult)>>SHIFT_USEC;
+	mult_adj += 1000000/2; /* round for div*/
+	do_div(mult_adj, 1000000);
+	if (ppm < 0)
+		ret_adj = -(int)mult_adj;
+	else
+		ret_adj = (int)mult_adj;
+	return ret_adj;
+}
+
+/* cyc2ns():
+ *      Uses the clocksource and ntp ajdustment interval to
+ *      convert cycle_ts to nanoseconds.
+ *
+ *      XXX - This could use some mult_lxl_ll() asm optimization
+ */
+static inline nsec_t cyc2ns(struct clocksource *cs, int ntp_adj, cycle_t cycles)
+{
+	u64 ret;
+	ret = (u64)cycles;
+	ret *= (cs->mult + ntp_adj);
+	ret >>= cs->shift;
+	return (nsec_t)ret;
+}
+
+/* cyc2ns_rem():
+ *      Uses the clocksource and ntp ajdustment interval to
+ *      convert cycle_t to nanoseconds. Add in remainder portion
+ *      which is stored in ns<<cs->shift units and save the new
+ *      remainder off.
+ *
+ *      XXX - This could use some mult_lxl_ll() asm optimization.
+ */
+static inline nsec_t cyc2ns_rem(struct clocksource *cs, int ntp_adj, cycle_t cycles, u64* rem)
+{
+	u64 ret;
+	ret = (u64)cycles;
+	ret *= (cs->mult + ntp_adj);
+	if (rem) {
+		ret += *rem;
+		*rem = ret & ((1<<cs->shift)-1);
+	}
+	ret >>= cs->shift;
+	return (nsec_t)ret;
+}
+
+/* Used for fixed interval conversions
+ */
+struct clocksource_interval {
+	cycle_t cycles;
+	nsec_t nsecs;
+	u64 remainder;
+	u64 remainder_ns_overflow;
+};
+
+/* cyc2ns_fixed_rem():
+ *      Uses a precalculated fixed cycle/nsec interval to
+ *      convert cycles to nanoseconds. Returns the unaccumulated
+ *      cycles in the cycles pointer as well as uses and updates
+ *      the value at the remainder pointer
+ *
+ */
+static inline nsec_t cyc2ns_fixed_rem(struct clocksource_interval interval, cycle_t *cycles, u64* rem)
+{
+	nsec_t delta_nsec = 0;
+	while(*cycles > interval.cycles) {
+		delta_nsec += interval.nsecs;
+		*cycles -= interval.cycles;
+		*rem += interval.remainder;
+		while(*rem > interval.remainder_ns_overflow) {
+			*rem -= interval.remainder_ns_overflow;
+			delta_nsec += 1;
+		}
+	}
+	return delta_nsec;
+}
+
+/* calculate_clocksource_interval():
+ *      Calculates a fixed cycle/nsec interval for a given
+ *      clocksource/adjustment pair and interval request.
+ */
+static inline struct clocksource_interval
+calculate_clocksource_interval(struct clocksource *c, long adj, unsigned long length_nsec)
+{
+	struct clocksource_interval ret;
+	u64 tmp;
+
+	/* XXX - All of this could use a whole lot of optimization */
+	tmp = length_nsec;
+	tmp <<= c->shift;
+	do_div(tmp, c->mult+adj);
+
+	ret.cycles = (cycle_t)tmp;
+	if(ret.cycles == 0)
+		ret.cycles = 1;
+
+	ret.remainder = 0;
+	ret.remainder_ns_overflow = 1 << c->shift;
+	ret.nsecs = cyc2ns_rem(c, adj, ret.cycles, &ret.remainder);
+
+	return ret;
+}
+
+
+/* used to install a new clocksource */
+void register_clocksource(struct clocksource*);
+void reselect_clocksource(void);
+struct clocksource* get_next_clocksource(void);
+#endif
diff --git a/kernel/clocksource.c b/kernel/clocksource.c
new file mode 100644
--- /dev/null
+++ b/kernel/clocksource.c
@@ -0,0 +1,279 @@
+/*********************************************************************
+* linux/kernel/clocksource.c
+*
+* This file contains the functions which manage clocksource drivers.
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
+*   o Allow clocksource drivers to be unregistered
+*   o get rid of clocksource_jiffies extern
+**********************************************************************/
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
+ *     currently selected clocksource. Initialized to clocksource_jiffies.
+ * next_clocksource:
+ *     pending next selected clocksource.
+ * clocksource_list:
+ *     linked list with the registered clocksources
+ * clocksource_lock:
+ *     protects manipulations to curr_clocksource and next_clocksource
+ *     and the clocksource_list
+ */
+static struct clocksource *curr_clocksource = &clocksource_jiffies;
+static struct clocksource *next_clocksource;
+static LIST_HEAD(clocksource_list);
+static seqlock_t clocksource_lock = SEQLOCK_UNLOCKED;
+
+static char override_name[32];
+
+
+/**
+ * get_next_clocksource - Returns the selected clocksource
+ *
+ */
+struct clocksource *get_next_clocksource(void)
+{
+	write_seqlock(&clocksource_lock);
+	if (next_clocksource) {
+		curr_clocksource = next_clocksource;
+		next_clocksource = NULL;
+	}
+	write_sequnlock(&clocksource_lock);
+
+	return curr_clocksource;
+}
+
+
+/**
+ * select_clocksource - Finds the best registered clocksource.
+ *
+ * Private function. Must have a writelock on clocksource_lock
+ * when called.
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
+		/* Check for override */
+		if (strlen(src->name) == strlen(override_name) &&
+		    !strcmp(src->name, override_name)) {
+			best = src;
+			break;
+		}
+		/* Pick the highest rating */
+		if (src->rating > best->rating)
+		 	best = src;
+	}
+	return best;
+}
+
+
+/*
+ * Check, if the clocksource is already registered
+ */
+static inline int is_registered_source(struct clocksource *c)
+{
+	struct list_head *tmp;
+	int len = strlen(c->name);
+
+	list_for_each(tmp, &clocksource_list) {
+		struct clocksource *src;
+
+		src = list_entry(tmp, struct clocksource, list);
+		if (strlen(src->name) == len &&	!strcmp(src->name, c->name))
+			return 1;
+	}
+	return 0;
+}
+
+
+/**
+ * register_clocksource - Used to install new clocksources
+ * @t: clocksource to be registered
+ *
+ */
+void register_clocksource(struct clocksource *c)
+{
+	write_seqlock(&clocksource_lock);
+
+	/* check if clocksource is already registered */
+	if (is_registered_source(c)) {
+		printk("register_clocksource: Cannot register %s. Already registered!",
+		       c->name);
+	} else {
+		list_add(&c->list, &clocksource_list);
+		/* select next clocksource */
+		next_clocksource = select_clocksource();
+	}
+	write_sequnlock(&clocksource_lock);
+}
+EXPORT_SYMBOL(register_clocksource);
+
+
+/**
+ * reselect_clocksource - Rescan list for next clocksource
+ *
+ * A quick helper function to be used if a clocksource
+ * changes its rating. Forces the clocksource list to
+ * be re-scaned for the best clocksource.
+ */
+void reselect_clocksource(void)
+{
+	write_seqlock(&clocksource_lock);
+	next_clocksource = select_clocksource();
+	write_sequnlock(&clocksource_lock);
+}
+
+
+/**
+ * sysfs_show_clocksources - sysfs interface for listing clocksource
+ * @dev: unused
+ * @buf: char buffer to be filled with clocksource list
+ *
+ * Provides sysfs interface for listing registered clocksources
+ */
+static ssize_t sysfs_show_clocksources(struct sys_device *dev, char *buf)
+{
+	char* curr = buf;
+	struct list_head *tmp;
+
+	write_seqlock(&clocksource_lock);
+
+	list_for_each(tmp, &clocksource_list) {
+		struct clocksource *src;
+
+		src = list_entry(tmp, struct clocksource, list);
+		/* Mark current clocksource w/ a star */
+		if (src == curr_clocksource)
+			curr += sprintf(curr, "*");
+		curr += sprintf(curr, "%s ", src->name);
+	}
+	write_sequnlock(&clocksource_lock);
+
+	curr += sprintf(curr, "\n");
+	return curr - buf;
+}
+
+
+/**
+ * sysfs_override_clocksource - interface for manually overriding clocksource
+ * @dev: unused
+ * @buf: name of override clocksource
+ *
+ *
+ *     Takes input from sysfs interface for manually overriding
+ *     the default clocksource selction
+ */
+static ssize_t sysfs_override_clocksource(struct sys_device *dev,
+			const char *buf, size_t count)
+{
+	/* Strings from sysfs write are not 0 terminated ! */
+	if (count >= sizeof(override_name))
+		return -EINVAL;
+	/* Strip of \n */
+	if (buf[count-1] == '\n')
+		count--;
+	if (count < 1)
+		return -EINVAL;
+
+	write_seqlock(&clocksource_lock);
+
+	/* copy the name given */
+	memcpy(override_name, buf, count);
+	override_name[count] = 0;
+
+	/* try to select it */
+	next_clocksource = select_clocksource();
+
+	write_sequnlock(&clocksource_lock);
+	return count;
+}
+
+
+/* Sysfs setup bits:
+ */
+static SYSDEV_ATTR(clocksource, 0600, sysfs_show_clocksources, sysfs_override_clocksource);
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
+	if (!error) {
+		error = sysdev_register(&device_clocksource);
+		if (!error)
+			error = sysdev_create_file(&device_clocksource, &attr_clocksource);
+	}
+	return error;
+}
+device_initcall(init_clocksource_sysfs);
+
+
+/**
+ * boot_override_clocksource - boot clock override
+ * @str: override name
+ *
+ * Takes a clocksource= boot argument and uses it
+ * as the clocksource override name
+ */
+static int __init boot_override_clocksource(char* str)
+{
+	if (str)
+		strlcpy(override_name, str, sizeof(override_name));
+	return 1;
+}
+__setup("clocksource=", boot_override_clocksource);
+
+
+/**
+ * boot_override_clock - Compatibility layer for deprecated boot option
+ * @str: override name
+ *
+ * DEPRECATED! Takes a clock= boot argument and uses it
+ * as the clocksource override name
+ */
+static int __init boot_override_clock(char* str)
+{
+	printk("Warning! clock= boot option is deprecated.\n");
+	return boot_override_clocksource(str);
+}
+__setup("clock=", boot_override_clock);


