Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVI3ApY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVI3ApY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 20:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbVI3ApY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 20:45:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:63150 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932444AbVI3ApW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 20:45:22 -0400
Subject: [RFC][PATCH 3/11] timesource management code
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Darren Hart <dvhltc@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Frank Sorenson <frank@tuxrocks.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       George Anzinger <george@mvista.com>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1128041052.8195.312.camel@cog.beaverton.ibm.com>
References: <1128040851.8195.307.camel@cog.beaverton.ibm.com>
	 <1128040939.8195.310.camel@cog.beaverton.ibm.com>
	 <1128041052.8195.312.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 29 Sep 2005 17:45:18 -0700
Message-Id: <1128041118.8195.314.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
	This patch introduces the timesource management infrastructure. A
timesource is a driver-like architecture generic abstraction of a free
running counter. This patch defines the timesource structure, and
provides management code for registering, selecting, accessing and
scaling timesources. The timesource structure is influenced by the
time_interpolator code, although I feel it has a cleaner interface and
avoids preserving system state in the timesource structure.

Additionally, this patch includes the trivial jiffies timesource, a
lowest common denominator timesource, provided mainly for use as an
example.

This patch applies ontop of my ntp cleanup patchset.

Since this patch provides the groundwork for the generic timeofday core,
it will not function without the generic timeofday patches to follow.


thanks
-john

 Documentation/kernel-parameters.txt |    7 
 drivers/Makefile                    |    1 
 drivers/timesource/Makefile         |    1 
 drivers/timesource/jiffies.c        |   74 ++++++++++
 include/linux/timesource.h          |  172 +++++++++++++++++++++++
 kernel/timesource.c                 |  259 ++++++++++++++++++++++++++++++++++++
 6 files changed, 513 insertions(+), 1 deletion(-)

linux-2.6.14-rc2_timeofday-timesource-core_B6.patch
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
@@ -323,7 +324,7 @@ running once the system is up.
 			Default value is set via a kernel config option.
 			Value can be changed at runtime via /selinux/checkreqprot.
  
- 	clock=		[BUGS=IA-32, HW] gettimeofday timesource override. 
+ 	clock=		[BUGS=IA-32, HW] gettimeofday timesource override. [Deprecated]
 			Forces specified timesource (if avaliable) to be used
 			when calculating gettimeofday(). If specicified timesource
 			is not avalible, it defaults to PIT. 
@@ -1462,6 +1463,10 @@ running once the system is up.
 
 	time		Show timing data prefixed to each printk message line
 
+	timesource=		[GENERIC_TOD] Override the default timesource
+			Override the default timesource and use the timesource
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
+obj-$(CONFIG_GENERICTOD)		+= timesource/
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
@@ -0,0 +1,74 @@
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
+	int (*update_callback)(void);
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


