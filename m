Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313314AbSFBTfY>; Sun, 2 Jun 2002 15:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSFBTfX>; Sun, 2 Jun 2002 15:35:23 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:21508 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313314AbSFBTfR>; Sun, 2 Jun 2002 15:35:17 -0400
Date: Sun, 2 Jun 2002 20:35:10 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc: CPUfreq <cpufreq@www.linux.org.uk>
Subject: [PATCH] cpufreq core for 2.5
Message-ID: <20020602203510.A11542@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, lkml,

The following patch adds the cpufreq core code to 2.5.19 (and beyond).
The cpufreq core offers a common interface to the CPU clock speed
features of both ARM and x86 CPUs.  We offer a set of sysctl entries,
placed in /proc/sys/cpu/0 for communication with user space.  Entries
provided are:

	speed-min (readonly)
	speed-max (readonly)
	speed     (read/write)

In order for this code to be built, an architecture must define the
CONFIG_CPU_FREQ configuration symbol.  The merged ARM code already
has the necessary configuration in place; the x86 part will be sent
later with the x86 specific patch.

Specifically on ARM CPUs, the core is especially important, since
various ARM system on a chip implementations derive peripheral clocks
from the CPU clock (eg, LCD controllers, SDRAM controllers, etc).
The core allows these peripherals to take action either prior and/or
after the actual CPU clock adjustment so we don't go out of tolerance.

Comments welcome; however please ensure that the cpufreq development
list at cpufreq@www.linux.org.uk receives a copy of all comments.

 include/linux/cpufreq.h |   94 ++++++++
 kernel/Makefile         |    3
 kernel/cpufreq.c        |  536 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 632 insertions, 1 deletion

diff -urN orig/kernel/Makefile linux/kernel/Makefile
--- orig/kernel/Makefile	Sat May 25 23:13:54 2002
+++ linux/kernel/Makefile	Sat May 25 10:31:47 2002
@@ -10,7 +10,7 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o
+	      printk.o platform.o suspend.o cpufreq.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o info.o time.o softirq.o resource.o \
@@ -17,6 +17,7 @@
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o context.o futex.o platform.o
 
+obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
diff -urN orig/kernel/cpufreq.c linux/kernel/cpufreq.c
--- orig/kernel/cpufreq.c	Thu Jan  1 01:00:00 1970
+++ linux/kernel/cpufreq.c	Wed May  1 17:32:21 2002
@@ -0,0 +1,536 @@
+/*
+ *  linux/kernel/cpufreq.c
+ *
+ *  Copyright (C) 2001 Russell King
+ *
+ *  $Id: cpufreq.c,v 1.21 2002/04/30 20:09:57 db Exp $
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * CPU speed changing core functionality.  We provide the following
+ * services to the system:
+ *  - notifier lists to inform other code of the freq change both
+ *    before and after the freq change.
+ *  - the ability to change the freq speed
+ *
+ * ** You'll need to add CTL_CPU = 10 to include/linux/sysctl.h if
+ * it's not already present.
+ *
+ * When this appears in the kernel, the sysctl enums will move to
+ * include/linux/sysctl.h
+ */
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/cpufreq.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/fs.h>
+#include <linux/sysctl.h>
+
+#include <asm/semaphore.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+#include <linux/interrupt.h>	/* requires system.h */
+
+/*
+ * This list is for kernel code that needs to handle
+ * changes to devices when the CPU clock speed changes.
+ */
+static struct notifier_block *cpufreq_notifier_list;
+static DECLARE_MUTEX_LOCKED(cpufreq_sem);
+static unsigned long cpufreq_ref_loops;
+static unsigned int cpufreq_ref_freq;
+static int cpufreq_initialised;
+static unsigned int (*cpufreq_validatespeed)(unsigned int);
+static void (*cpufreq_setspeed)(unsigned int);
+
+#ifndef CONFIG_SMP
+static unsigned int __cpufreq_max;
+static unsigned int __cpufreq_min;
+static unsigned int __cpufreq_cur;
+#endif
+
+static unsigned long scale(unsigned long ref, u_int div, u_int mult)
+{
+	unsigned long new_jiffy_l, new_jiffy_h;
+
+	/*
+	 * Recalculate loops_per_jiffy.  We do it this way to
+	 * avoid math overflow on 32-bit machines.  Maybe we
+	 * should make this architecture dependent?  If you have
+	 * a better way of doing this, please replace!
+	 *
+	 *    new = old * mult / div
+	 */
+	new_jiffy_h = ref / div;
+	new_jiffy_l = (ref % div) / 100;
+	new_jiffy_h *= mult;
+	new_jiffy_l = new_jiffy_l * mult / div;
+
+	return new_jiffy_h + new_jiffy_l * 100;
+}
+
+/*
+ * cpufreq_max command line parameter.  Use:
+ *  cpufreq=59000-221000
+ * to set the CPU frequency to 59 to 221MHz.
+ */
+static int __init cpufreq_setup(char *str)
+{
+	unsigned int min, max;
+	int i;
+
+	min = 0;
+	max = simple_strtoul(str, &str, 0);
+	if (*str == '-') {
+		min = max;
+		max = simple_strtoul(str + 1, NULL, 0);
+	}
+
+	for (i = 0; i < smp_num_cpus; i++) {
+		cpufreq_max(i) = max;
+		cpufreq_min(i) = min;
+	}
+
+	return 1;
+}
+
+__setup("cpufreq=", cpufreq_setup);
+
+/**
+ *	cpufreq_register_notifier - register a driver with cpufreq
+ *	@nb: notifier function to register
+ *
+ *	Add a driver to the list of drivers that which to be notified about
+ *	CPU clock rate changes. The driver will be called three times on
+ *	clock change.
+ *
+ *	This function may sleep, and has the same return conditions as
+ *	notifier_chain_register.
+ */
+int cpufreq_register_notifier(struct notifier_block *nb)
+{
+	int ret;
+
+	down(&cpufreq_sem);
+	ret = notifier_chain_register(&cpufreq_notifier_list, nb);
+	up(&cpufreq_sem);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(cpufreq_register_notifier);
+
+/**
+ *	cpufreq_unregister_notifier - unregister a driver with cpufreq
+ *	@nb: notifier block to be unregistered
+ *
+ *	Remove a driver from the CPU frequency notifier lists.
+ *
+ *	This function may sleep, and has the same return conditions as
+ *	notifier_chain_unregister.
+ */
+int cpufreq_unregister_notifier(struct notifier_block *nb)
+{
+	int ret;
+
+	down(&cpufreq_sem);
+	ret = notifier_chain_unregister(&cpufreq_notifier_list, nb);
+	up(&cpufreq_sem);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(cpufreq_unregister_notifier);
+
+/*
+ * This notifier alters the system "loops_per_jiffy" for the clock
+ * speed change.  We ignore CPUFREQ_MINMAX here.
+ */
+static void adjust_jiffies(unsigned long val, struct cpufreq_info *ci)
+{
+	if ((val == CPUFREQ_PRECHANGE  && ci->old_freq < ci->new_freq) ||
+	    (val == CPUFREQ_POSTCHANGE && ci->old_freq > ci->new_freq))
+	    	loops_per_jiffy = scale(cpufreq_ref_loops, cpufreq_ref_freq,
+					ci->new_freq);
+}
+
+#ifdef CONFIG_PM
+/**
+ *	cpufreq_restore - restore the CPU clock frequency after resume
+ *
+ *	Restore the CPU clock frequency so that our idea of the current
+ *	frequency reflects the actual hardware.
+ */
+int cpufreq_restore(void)
+{
+	unsigned long old_cpus;
+	int cpu = smp_processor_id();
+	int ret;
+
+	if (!cpufreq_initialised)
+		panic("cpufreq_restore() called before initialisation!");
+	if (in_interrupt())
+		panic("cpufreq_restore() called from interrupt context!");
+
+	/*
+	 * Bind to the current CPU.
+	 */
+	old_cpus = current->cpus_allowed;
+	current->cpus_allowed = 1UL << cpu_logical_map(cpu);
+
+	down(&cpufreq_sem);
+
+	ret = -ENXIO;
+	if (cpufreq_setspeed) {
+		cpufreq_setspeed(cpufreq_current(cpu));
+		ret = 0;
+	}
+
+	up(&cpufreq_sem);
+
+	current->cpus_allowed = old_cpus;
+
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(cpufreq_restore);
+#endif
+
+/**
+ *	cpu_setfreq - change the CPU clock frequency.
+ *	@freq: frequency (in kHz) at which we should run.
+ *
+ *	Set the CPU clock frequency, informing all registered users of
+ *	the change. We bound the frequency according to the cpufreq_max
+ *	command line parameter, and the parameters the registered users
+ *	will allow.
+ *
+ *	This function must be called from process context, and on the
+ *	cpu that we wish to change the frequency of.
+ *
+ *	We return 0 if successful. (we are currently always successful).
+ */
+int cpufreq_set(unsigned int freq)
+{
+	unsigned long old_cpus;
+	struct cpufreq_info clkinfo;
+	struct cpufreq_minmax minmax;
+	int cpu = smp_processor_id();
+	int ret;
+
+	if (!cpufreq_initialised)
+		panic("cpufreq_set() called before initialisation!");
+	if (in_interrupt())
+		panic("cpufreq_set() called from interrupt context!");
+
+	/*
+	 * Bind to the current CPU.
+	 */
+	old_cpus = current->cpus_allowed;
+	current->cpus_allowed = 1UL << cpu_logical_map(cpu);
+
+	down(&cpufreq_sem);
+	ret = -ENXIO;
+	if (!cpufreq_setspeed || !cpufreq_validatespeed)
+		goto out;
+
+	/*
+	 * Don't allow the CPU to be clocked over the limit.
+	 */
+	minmax.min_freq = cpufreq_min(cpu);
+	minmax.max_freq = cpufreq_max(cpu);
+	minmax.cur_freq = cpufreq_current(cpu);
+	minmax.new_freq = freq;
+
+	/*
+	 * Find out what the registered devices will currently tolerate,
+	 * and limit the requested clock rate to these values.  Drivers
+	 * must not rely on the 'new_freq' value - it is only a guide.
+	 */
+	notifier_call_chain(&cpufreq_notifier_list, CPUFREQ_MINMAX, &minmax);
+	if (freq < minmax.min_freq)
+		freq = minmax.min_freq;
+	if (freq > minmax.max_freq)
+		freq = minmax.max_freq;
+
+	/*
+	 * Ask the CPU specific code to validate the speed.  If the speed
+	 * is not acceptable, make it acceptable.  Current policy is to
+	 * round the frequency down to the value the processor actually
+	 * supports.
+	 */
+	freq = cpufreq_validatespeed(freq);
+
+	if (cpufreq_current(cpu) != freq) {
+		clkinfo.old_freq = cpufreq_current(cpu);
+		clkinfo.new_freq = freq;
+
+		notifier_call_chain(&cpufreq_notifier_list, CPUFREQ_PRECHANGE,
+				    &clkinfo);
+
+		adjust_jiffies(CPUFREQ_PRECHANGE, &clkinfo);
+
+		/*
+		 * Actually set the CPU frequency.
+		 */
+		cpufreq_setspeed(freq);
+		cpufreq_current(cpu) = freq;
+		adjust_jiffies(CPUFREQ_POSTCHANGE, &clkinfo);
+
+		notifier_call_chain(&cpufreq_notifier_list, CPUFREQ_POSTCHANGE,
+				    &clkinfo);
+	}
+
+	ret = 0;
+
+ out:
+	up(&cpufreq_sem);
+
+	current->cpus_allowed = old_cpus;
+
+	return ret;
+}
+
+EXPORT_SYMBOL_GPL(cpufreq_set);
+
+/**
+ *	cpufreq_setmax - set the CPU to maximum frequency
+ *
+ *	Sets the CPU this function is executed on to maximum frequency.
+ */
+int cpufreq_setmax(void)
+{
+	return cpufreq_set(cpufreq_max(smp_processor_id()));
+}
+
+EXPORT_SYMBOL_GPL(cpufreq_setmax);
+
+/**
+ *	cpufreq_get - return the current CPU clock frequency in 1kHz
+ *	@cpu: cpu number to obtain frequency for
+ *
+ *	Returns the specified CPUs frequency in kHz.
+ */
+unsigned int cpufreq_get(int cpu)
+{
+	if (!cpufreq_initialised)
+		panic("cpufreq_get() called before initialisation!");
+	return cpufreq_current(cpu);
+}
+
+EXPORT_SYMBOL(cpufreq_get);
+
+#ifdef CONFIG_SYSCTL
+
+static int
+cpufreq_procctl(ctl_table *ctl, int write, struct file *filp,
+		void *buffer, size_t *lenp)
+{
+	char buf[16], *p;
+	int cpu = 0, len, left = *lenp;
+
+	if (!left || (filp->f_pos && !write)) {
+		*lenp = 0;
+		return 0;
+	}
+
+	if (write) {
+		unsigned int freq;
+
+		len = left;
+		if (left > sizeof(buf))
+			left = sizeof(buf);
+		if (copy_from_user(buf, buffer, left))
+			return -EFAULT;
+		buf[sizeof(buf) - 1] = '\0';
+
+		freq = simple_strtoul(buf, &p, 0);
+		cpufreq_set(freq);
+	} else {
+		len = sprintf(buf, "%d\n", cpufreq_get(cpu));
+		if (len > left)
+			len = left;
+		if (copy_to_user(buffer, buf, len))
+			return -EFAULT;
+	}
+
+	*lenp = len;
+	filp->f_pos += len;
+	return 0;
+}
+
+static int
+cpufreq_sysctl(ctl_table *table, int *name, int nlen,
+	       void *oldval, size_t *oldlenp,
+	       void *newval, size_t newlen, void **context)
+{
+	int cpu = 0;
+
+	if (oldval && oldlenp) {
+		size_t oldlen;
+
+		if (get_user(oldlen, oldlenp))
+			return -EFAULT;
+
+		if (oldlen != sizeof(unsigned int))
+			return -EINVAL;
+
+		if (put_user(cpufreq_get(cpu), (unsigned int *)oldval) ||
+		    put_user(sizeof(unsigned int), oldlenp))
+			return -EFAULT;
+	}
+	if (newval && newlen) {
+		unsigned int freq;
+
+		if (newlen != sizeof(unsigned int))
+			return -EINVAL;
+
+		if (get_user(freq, (unsigned int *)newval))
+			return -EFAULT;
+
+		cpufreq_set(freq);
+	}
+	return 1;
+}
+
+enum {
+	CPU_NR_FREQ_MAX = 1,
+	CPU_NR_FREQ_MIN = 2,
+	CPU_NR_FREQ = 3
+};
+
+static ctl_table ctl_cpu_vars[4] = {
+	{
+		ctl_name:	CPU_NR_FREQ_MAX,
+		procname:	"speed-max",
+		data:		&cpufreq_max(0),
+		maxlen:		sizeof(cpufreq_max(0)),
+		mode:		0444,
+		proc_handler:	proc_dointvec,
+	},
+	{
+		ctl_name:	CPU_NR_FREQ_MIN,
+		procname:	"speed-min",
+		data:		&cpufreq_min(0),
+		maxlen:		sizeof(cpufreq_min(0)),
+		mode:		0444,
+		proc_handler:	proc_dointvec,
+	},
+	{
+		ctl_name:	CPU_NR_FREQ,
+		procname:	"speed",
+		mode:		0644,
+		proc_handler:	cpufreq_procctl,
+		strategy:	cpufreq_sysctl,
+	},
+	{
+		ctl_name:	0,
+	}
+};
+
+enum {
+	CPU_NR = 1,
+};
+
+static ctl_table ctl_cpu_nr[2] = {
+	{
+		ctl_name:	CPU_NR,
+		procname:	"0",
+		mode:		0555,
+		child:		ctl_cpu_vars,
+	},
+	{
+		ctl_name:	0,
+	}
+};
+
+static ctl_table ctl_cpu[2] = {
+	{
+		ctl_name:	CTL_CPU,
+		procname:	"cpu",
+		mode:		0555,
+		child:		ctl_cpu_nr,
+	},
+	{
+		ctl_name:	0,
+	}
+};
+
+static inline void cpufreq_sysctl_init(void)
+{
+	register_sysctl_table(ctl_cpu, 0);
+}
+
+#else
+#define cpufreq_sysctl_init()
+#endif
+
+/**
+ *	cpufreq_setfunctions - Set CPU clock functions
+ *	@validate: pointer to validation function
+ *	@setspeed: pointer to setspeed function
+ */
+void
+cpufreq_setfunctions(unsigned int (*validate)(unsigned int),
+		     void (*setspeed)(unsigned int))
+{
+	down(&cpufreq_sem);
+	cpufreq_validatespeed = validate;
+	cpufreq_setspeed = setspeed;
+	up(&cpufreq_sem);
+}
+
+EXPORT_SYMBOL_GPL(cpufreq_setfunctions);
+
+/**
+ *	cpufreq_init - Initialise the cpufreq core
+ *	@freq: current CPU clock speed.
+ *	@min_freq: minimum CPU clock speed.
+ *	@max_freq: maximum CPU clock speed.
+ *
+ *	Initialise the cpufreq core. If the cpufreq_max command line
+ *	parameter has not been specified, we set the maximum clock rate
+ *	to the current CPU clock rate.
+ */
+void cpufreq_init(unsigned int freq,
+		  unsigned int min_freq,
+		  unsigned int max_freq)
+{
+	/*
+	 * If the user doesn't tell us their maximum frequency,
+	 * or if it is invalid, use the values determined 
+	 * by the cpufreq-arch-specific initialization functions.
+	 * The validatespeed code is responsible for limiting
+	 * this further.
+	 */
+	if (max_freq && ((cpufreq_max(0) == 0) || (cpufreq_max(0) > max_freq)))
+		cpufreq_max(0) = max_freq;
+	if (min_freq && ((cpufreq_min(0) == 0) || (cpufreq_min(0) < min_freq)))
+		cpufreq_min(0) = min_freq;
+
+	if (cpufreq_max(0) == 0)
+		cpufreq_max(0) = freq;
+
+	printk(KERN_INFO "CPU clock: %d.%03d MHz (%d.%03d-%d.%03d MHz)\n",
+		freq / 1000, freq % 1000,
+		cpufreq_min(0) / 1000, cpufreq_min(0) % 1000,
+		cpufreq_max(0) / 1000, cpufreq_max(0) % 1000);
+
+	cpufreq_ref_loops = loops_per_jiffy;
+	cpufreq_ref_freq = freq;
+	cpufreq_current(smp_processor_id()) = freq;
+
+	cpufreq_initialised = 1;
+	up(&cpufreq_sem);
+
+	cpufreq_sysctl_init();
+}
+
+EXPORT_SYMBOL_GPL(cpufreq_init);
diff -urN orig/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- orig/incldue/linux/cpufreq.h	Sat Apr 26 08:56:46 1997
+++ linux/include/linux/cpufreq.h	Wed May  1 17:32:20 2002
@@ -0,0 +1,94 @@
+/*
+ *  linux/include/linux/cpufreq.h
+ *
+ *  Copyright (C) 2001 Russell King
+ *
+ * $Id: cpufreq.h,v 1.6 2002/04/30 20:09:56 db Exp $
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef _LINUX_CPUFREQ_H
+#define _LINUX_CPUFREQ_H
+
+#include <linux/config.h>
+#include <linux/notifier.h>
+
+#ifndef CONFIG_SMP
+#define cpufreq_current(cpu)	((void)(cpu), __cpufreq_cur)
+#define cpufreq_max(cpu)	((void)(cpu), __cpufreq_max)
+#define cpufreq_min(cpu)	((void)(cpu), __cpufreq_min)
+#else
+/*
+ * Should be something like:
+ *
+ * typedef struct {
+ *	u_int current;
+ *	u_int max;
+ *	u_int min;
+ * } __cacheline_aligned cpufreq_info_t;
+ *
+ * static cpufreq_info_t cpufreq_info;
+ *
+ * #define cpufreq_current(cpu)	(cpufreq_info[cpu].current)
+ * #define cpufreq_max(cpu)	(cpufreq_info[cpu].max)
+ * #define cpufreq_min(cpu)	(cpufreq_info[cpu].min)
+ *
+ * Maybe we should find some other per-cpu structure to
+ * bury this in?
+ */
+#error fill in SMP version
+#endif
+
+struct cpufreq_info {
+	unsigned int old_freq;
+	unsigned int new_freq;
+};
+
+/*
+ * The max and min frequency rates that the registered device
+ * can tolerate.  Never set any element this structure directly -
+ * always use cpu_updateminmax.
+ */
+struct cpufreq_minmax {
+	unsigned int min_freq;
+	unsigned int max_freq;
+	unsigned int cur_freq;
+	unsigned int new_freq;
+};
+
+static inline
+void cpufreq_updateminmax(void *arg, unsigned int min, unsigned int max)
+{
+	struct cpufreq_minmax *minmax = arg;
+
+	if (minmax->min_freq < min)
+		minmax->min_freq = min;
+	if (minmax->max_freq > max)
+		minmax->max_freq = max;
+}
+
+#define CPUFREQ_MINMAX		(0)
+#define CPUFREQ_PRECHANGE	(1)
+#define CPUFREQ_POSTCHANGE	(2)
+
+int cpufreq_register_notifier(struct notifier_block *nb);
+int cpufreq_unregister_notifier(struct notifier_block *nb);
+
+int cpufreq_setmax(void);
+int cpufreq_restore(void);
+int cpufreq_set(unsigned int khz);
+unsigned int cpufreq_get(int cpu);
+
+/*
+ * These two functions are only available at init time.
+ */
+void cpufreq_init(unsigned int khz,
+		  unsigned int min_freq,
+		  unsigned int max_freq);
+
+void cpufreq_setfunctions(unsigned int (*validate)(unsigned int),
+			  void (*setspeed)(unsigned int));
+
+#endif

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

