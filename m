Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSG1WAE>; Sun, 28 Jul 2002 18:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317362AbSG1WAD>; Sun, 28 Jul 2002 18:00:03 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:65189 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S317359AbSG1V7t>; Sun, 28 Jul 2002 17:59:49 -0400
Date: Mon, 29 Jul 2002 00:01:38 +0200
From: Dominik Brodowski <devel@brodo.de>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq core for 2.5.29
Message-ID: <20020729000138.A24665@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, lkml,

The following patch adds the cpufreq core code to 2.5.29. The 
cpufreq core offers a common interface to the CPU clock speed
features of both ARM and x86 CPUs.

For communication with user space, sysctl entries are placed in
/proc/sys/cpu/{0,1,...,NR_CPUS-1}/ .  Entries provided are:

	speed-min  (readonly)
	speed-max  (readonly)
	speed-sync (readonly - all CPUs need the same frequency,
	                       changes affect all CPUs)
	speed      (read/write)

In order for this code to be built, an architecture must define the
CONFIG_CPU_FREQ configuration symbol. The merged ARM code already
has the necessary configuration in place; the x86 specific parts 
will be sent once the core is merged.

Specifically on ARM CPUs, the core is especially important, since
various ARM system on a chip implementations derive peripheral clocks
from the CPU clock (eg, LCD controllers, SDRAM controllers, etc).
The core allows these peripherals to take action either prior and/or
after the actual CPU clock adjustment so we don't go out of tolerance.

Comments welcome; however please ensure that the cpufreq development
list at cpufreq@www.linux.org.uk receives a copy of all comments.


  Dominik


--- linux/kernel/Makefile.orig	Sun Jul 28 22:38:14 2002
+++ linux/kernel/Makefile	Sun Jul 28 22:38:44 2002
@@ -10,7 +10,7 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o
+		printk.o platform.o suspend.o cpufreq.o
 
 obj-y     = sched.o dma.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
@@ -21,6 +21,7 @@
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += ksyms.o
 obj-$(CONFIG_PM) += pm.o
+obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
 
--- /dev/null	Sat May 12 19:23:16 2001
+++ linux/kernel/cpufreq.c	Fri Jul 19 00:23:31 2002
@@ -0,0 +1,723 @@
+/*
+ *  linux/kernel/cpufreq.c
+ *
+ *  Copyright (C) 2001 Russell King
+ *            (C) 2002 Dominik Brodowski <devel@brodo.de>
+ *
+ *  $Id: cpufreq.c,v 1.32 2002/07/18 22:23:31 db Exp $
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
+#include <linux/slab.h>
+
+#include <asm/semaphore.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+#include <linux/interrupt.h>	/* requires system.h */
+
+
+/*
+ * This list is for kernel code that needs to handle
+ * changes to devices when the CPU clock speed changes.
+ */
+static struct notifier_block    *cpufreq_notifier_list;
+static DECLARE_MUTEX            (cpufreq_notifier_sem);
+
+/*
+ * This is internal information about the actual transition
+ * driver.
+ */
+static struct cpufreq_driver   	*cpufreq_driver;
+static struct cpufreq_freqs	cpufreq_freq_limit;
+static DECLARE_MUTEX            (cpufreq_driver_sem);
+
+/*
+ * Some data for the CPUFreq core - loops_per_jiffy / frequency values at boot
+ */
+static unsigned long            cpufreq_ref_loops;
+static unsigned int             cpufreq_ref_freq;
+
+
+
+/**
+ * scale - "old * mult / div" calculation for large values (32-bit-arch safe)
+ * @old:   old value
+ * @div:   divisor
+ * @mult:  multiplier
+ *
+ * Needed for loops_per_jiffy calculation.  We do it this way to
+ * avoid math overflow on 32-bit machines.  Maybe we should make
+ * this architecture dependent?  If you have a better way of doing
+ * this, please replace!
+ *
+ *    new = old * mult / div
+ */
+static unsigned long scale(unsigned long old, u_int div, u_int mult)
+{
+	unsigned long low_part, high_part;
+
+	high_part  = old / div;
+	low_part   = (old % div) / 100;
+	high_part *= mult;
+	low_part   = low_part * mult / div;
+
+	return high_part + low_part * 100;
+}
+
+
+/**
+ * cpufreq_setup - cpufreq command line parameter parsing
+ *
+ * cpufreq command line parameter.  Use:
+ *  cpufreq=59000-221000
+ * to set the CPU frequency to 59 to 221MHz.
+ */
+static int __init cpufreq_setup(char *str)
+{
+	unsigned int min, max;
+
+	min = 0;
+	max = simple_strtoul(str, &str, 0);
+	if (*str == '-') {
+		min = max;
+		max = simple_strtoul(str + 1, NULL, 0);
+	}
+
+	down(&cpufreq_driver_sem);
+	cpufreq_freq_limit.max = max;
+	cpufreq_freq_limit.min = min;
+	up(&cpufreq_driver_sem);
+
+	return 1;
+}
+__setup("cpufreq=", cpufreq_setup);
+
+
+/**
+ * adjust_jiffies - adjust the system "loops_per_jiffy"
+ *
+ * This function alters the system "loops_per_jiffy" for the clock
+ * speed change.  We ignore CPUFREQ_DRIVER.MINMAX here.
+ */
+static void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
+{
+	if ((val == CPUFREQ_PRECHANGE  && ci->cur < ci->new) ||
+	    (val == CPUFREQ_POSTCHANGE && ci->cur > ci->new))
+	    	loops_per_jiffy = scale(cpufreq_ref_loops, cpufreq_ref_freq,
+					ci->new);
+}
+
+
+
+/*********************************************************************
+ *                      NOTIFIER LIST INTERFACE                      *
+ *********************************************************************/
+
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
+	down(&cpufreq_notifier_sem);
+	ret = notifier_chain_register(&cpufreq_notifier_list, nb);
+	up(&cpufreq_notifier_sem);
+
+	return ret;
+}
+EXPORT_SYMBOL(cpufreq_register_notifier);
+
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
+	down(&cpufreq_notifier_sem);
+	ret = notifier_chain_unregister(&cpufreq_notifier_list, nb);
+	up(&cpufreq_notifier_sem);
+
+	return ret;
+}
+EXPORT_SYMBOL(cpufreq_unregister_notifier);
+
+
+
+/*********************************************************************
+ *                     GET / SET PROCESSOR SPEED                     *
+ *********************************************************************/
+
+/**
+ *	cpu_setfreq - change the CPU clock frequency.
+ *	@freq: frequency (in kHz) at which we should run.
+ *
+ *	Set the CPU clock frequency, informing all registered users of
+ *	the change. We bound the frequency according to the cpufreq
+ *	command line parameter, information obtained from the cpufreq 
+ *      driver, and the parameters the registered users will allow.
+ *
+ *	This function must be called from process context.
+ *
+ *	We return 0 if successful, -EINVAL if no CPUFreq architecture
+ *      driver is registered, and -ENXIO if the driver is invalid.
+ */
+int cpufreq_set(unsigned int cpu, unsigned int freq)
+{
+	struct cpufreq_freqs cpufreq;
+	int ret;
+
+	if (in_interrupt())
+		panic("cpufreq_set() called from interrupt context!");
+
+	down(&cpufreq_driver_sem);
+	down(&cpufreq_notifier_sem);
+
+	if (!cpufreq_driver) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = -ENXIO;
+	if (!cpufreq_driver->setspeed || !cpufreq_driver->validate)
+		goto out;
+
+	/*
+	 * Don't allow the CPU to be clocked over the limit.
+	 */
+	if (cpufreq_driver->sync) {
+		cpufreq.cpu = CPUFREQ_ALL_CPUS;
+		cpu = 0;
+	} else {
+		if (cpu >= NR_CPUS) {
+			ret = -EINVAL;
+			goto out;
+		}
+		cpufreq.cpu = cpu;
+	}
+	cpufreq.min = cpufreq_driver->freq[cpu].min;
+	cpufreq.max = cpufreq_driver->freq[cpu].max;
+	cpufreq.cur = cpufreq_driver->freq[cpu].cur;
+	cpufreq.new = freq;
+
+
+	/*
+	 * Find out what the registered devices will currently tolerate,
+	 * and limit the requested clock rate to these values.  Drivers
+	 * must not rely on the 'new' value - it is only a guide.
+	 */
+	notifier_call_chain(&cpufreq_notifier_list, CPUFREQ_MINMAX, &cpufreq);
+
+	if (freq < cpufreq.min)
+		freq = cpufreq.min;
+	if (freq > cpufreq.max)
+		freq = cpufreq.max;
+
+	/*
+	 * Ask the CPU specific code to validate the speed.  If the speed
+	 * is not acceptable, make it acceptable.  Current policy is to
+	 * round the frequency down to the value the processor actually
+	 * supports.
+	 */
+	freq = cpufreq_driver->validate(cpu, freq);
+
+	if (cpufreq_driver->freq[cpu].cur != freq) {
+		cpufreq.cur = cpufreq_driver->freq[cpu].cur;
+		cpufreq.new = freq;
+
+		notifier_call_chain(&cpufreq_notifier_list, CPUFREQ_PRECHANGE,
+				    &cpufreq);
+
+		if (cpufreq_driver->sync)
+			adjust_jiffies(CPUFREQ_PRECHANGE, &cpufreq);
+		else
+			BUG();
+
+		/*
+		 * Actually set the CPU frequency.
+		 */
+		preempt_disable();
+		cpufreq_driver->setspeed(cpu, freq);
+		preempt_enable();
+		cpufreq_driver->freq[cpu].cur = freq;
+		adjust_jiffies(CPUFREQ_POSTCHANGE, &cpufreq);
+
+		notifier_call_chain(&cpufreq_notifier_list, CPUFREQ_POSTCHANGE,
+				    &cpufreq);
+
+		ret = 0;
+	}
+
+ out:
+	up(&cpufreq_notifier_sem);
+	up(&cpufreq_driver_sem);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cpufreq_set);
+
+
+/**
+ *	cpufreq_setmax - set the CPU to maximum frequency
+ *	@cpu: the CPU affected by this call
+ *
+ *	Sets the CPUs to maximum frequency.
+ */
+int cpufreq_setmax(unsigned int cpu)
+{
+	unsigned int max_freq = 0;
+
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver) {
+		up(&cpufreq_driver_sem);
+		return -EINVAL;
+	}
+	if (cpufreq_driver->sync)
+		max_freq = cpufreq_driver->freq->max;
+	else if (cpu < NR_CPUS)
+		max_freq = cpufreq_driver->freq[cpu].max;
+	
+	up(&cpufreq_driver_sem);
+	return cpufreq_set(cpu, max_freq);
+}
+EXPORT_SYMBOL_GPL(cpufreq_setmax);
+
+
+/**
+ *	cpufreq_get - get the CPU frequency in kHz (zero means failure)
+ *	@cpu: number of the CPU this inquiry is made for
+ *
+ *	Returns the CPU frequency in kHz or zero on failure.
+ */
+unsigned int cpufreq_get(unsigned int cpu)
+{
+	unsigned int current_freq = 0;
+
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver) {
+		up(&cpufreq_driver_sem);
+		return 0;
+	}
+	
+	if (cpufreq_driver->sync)
+		current_freq = cpufreq_driver->freq->cur;
+	else if (cpu < NR_CPUS)
+		current_freq = cpufreq_driver->freq[cpu].max;
+
+	up(&cpufreq_driver_sem);
+	return current_freq;
+}
+EXPORT_SYMBOL(cpufreq_get);
+
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
+	int ret = 0;
+
+	if (in_interrupt())
+		panic("cpufreq_restore() called from interrupt context!");
+
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver) {
+		up(&cpufreq_driver_sem);
+		return -EINVAL;
+	}
+	ret = -ENXIO;
+	if (cpufreq_driver->setspeed) {
+		if (cpufreq_driver->sync)
+			cpufreq_driver->setspeed(0, cpufreq_driver->freq->cur);
+		else {
+			int i;
+			for (i=0; i < NR_CPUS; i++)
+				cpufreq_driver->setspeed(i, cpufreq_driver->freq[i].cur);
+		}
+		ret = 0;
+	}
+
+	up(&cpufreq_driver_sem);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cpufreq_restore);
+#endif
+
+
+
+/*********************************************************************
+ *                         SYSCTL INTERFACE                          *
+ *********************************************************************/
+
+#ifdef CONFIG_SYSCTL
+
+struct ctl_table_header *cpufreq_sysctl_table;
+
+int
+cpufreq_procctl_min(ctl_table *ctl, int write, struct file *filp,
+		void *buffer, size_t *lenp)
+{
+	char buf[16];
+	int len, left = *lenp;
+	unsigned int printout = -1;
+
+	if (!left || write || filp->f_pos) {
+		*lenp = 0;
+		return 0;
+	}
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver)
+		printout = cpufreq_freq_limit.min;
+	else {
+		if (cpufreq_driver->sync)
+			printout = cpufreq_driver->freq->min;
+		else if (((int) ctl->extra1) < NR_CPUS)
+			printout = cpufreq_driver->freq[(int) ctl->extra1].min;
+	}
+	up(&cpufreq_driver_sem);
+	
+	len = sprintf(buf, "%d\n", printout);
+	if (len > left)
+		len = left;
+	if (copy_to_user(buffer, buf, len))
+		return -EFAULT;
+
+	*lenp = len;
+	filp->f_pos += len;
+	return 0;
+}
+
+
+int
+cpufreq_procctl_max(ctl_table *ctl, int write, struct file *filp,
+		void *buffer, size_t *lenp)
+{
+	char buf[16];
+	int len, left = *lenp;
+	unsigned int printout = -1;
+
+	if (!left || write || filp->f_pos) {
+		*lenp = 0;
+		return 0;
+	}
+	
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver)
+		printout = cpufreq_freq_limit.max;
+	else {
+		if (cpufreq_driver->sync)
+			printout = cpufreq_driver->freq->max;
+		else if (((int) ctl->extra1) < NR_CPUS)
+			printout = cpufreq_driver->freq[(int) ctl->extra1].max;
+	}
+	up(&cpufreq_driver_sem);
+
+	len = sprintf(buf, "%d\n", printout);
+	if (len > left)
+		len = left;
+	if (copy_to_user(buffer, buf, len))
+		return -EFAULT;
+
+	*lenp = len;
+	filp->f_pos += len;
+	return 0;
+}
+
+
+int
+cpufreq_procctl_sync(ctl_table *ctl, int write, struct file *filp,
+		void *buffer, size_t *lenp)
+{
+	char buf[16];
+	int len, left = *lenp;
+	unsigned int printout = 0;
+
+	if (!left || write || filp->f_pos) {
+		*lenp = 0;
+		return 0;
+	}
+	
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver)
+		printout = -1;
+	else 
+		printout = cpufreq_driver->sync;
+	up(&cpufreq_driver_sem);
+
+	len = sprintf(buf, "%d\n", printout);
+	if (len > left)
+		len = left;
+	if (copy_to_user(buffer, buf, len))
+		return -EFAULT;
+
+	*lenp = len;
+	filp->f_pos += len;
+	return 0;
+}
+
+
+int
+cpufreq_procctl(ctl_table *ctl, int write, struct file *filp,
+		void *buffer, size_t *lenp)
+{
+	char buf[16], *p;
+	int len, left = *lenp;
+ 	unsigned int cpu = 0;
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
+		down(&cpufreq_driver_sem);
+		if (!cpufreq_driver) {
+			up(&cpufreq_driver_sem);
+			return -EINVAL;
+		}
+		if (cpufreq_driver->sync)
+			cpu = CPUFREQ_ALL_CPUS;
+		else
+			cpu = (int) ctl->extra1;
+		up(&cpufreq_driver_sem);
+		cpufreq_set(cpu, freq);
+	} else {
+		down(&cpufreq_driver_sem);
+		if (!cpufreq_driver) {
+			up(&cpufreq_driver_sem);
+			return -EINVAL;
+		}
+		if (cpufreq_driver->sync)
+			cpu = CPUFREQ_ALL_CPUS;
+		else
+			cpu = (int) ctl->extra1;
+		up(&cpufreq_driver_sem);
+		
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
+int
+cpufreq_sysctl(ctl_table *table, int *name, int nlen,
+	       void *oldval, size_t *oldlenp,
+	       void *newval, size_t newlen, void **context)
+{
+	unsigned int cpu = 0;
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
+		down(&cpufreq_driver_sem);
+		if (!cpufreq_driver) {
+			up(&cpufreq_driver_sem);
+			return -EINVAL;
+		}
+		if (cpufreq_driver->sync)
+			cpu = CPUFREQ_ALL_CPUS;
+		else
+			cpu = (int) table->extra1;
+		up(&cpufreq_driver_sem);
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
+		down(&cpufreq_driver_sem);
+		if (!cpufreq_driver) {
+			up(&cpufreq_driver_sem);
+			return -EINVAL;
+		}
+		if (cpufreq_driver->sync)
+			cpu = CPUFREQ_ALL_CPUS;
+		else
+			cpu = (int) table->extra1;
+		up(&cpufreq_driver_sem);
+
+		cpufreq_set(cpu, freq);
+	}
+	return 1;
+}
+
+#endif
+
+
+
+
+/*********************************************************************
+ *               REGISTER / UNREGISTER CPUFREQ DRIVER                *
+ *********************************************************************/
+
+
+/**
+ * cpufreq_register - register a CPU Frequency driver
+ * @driver_data: A struct cpufreq_driver containing the values submitted by the CPU Frequency driver.
+ *
+ * driver_data should contain the following elements: 
+ * freq.min is the minimum frequency the CPU / the CPUs can be set to 
+ * (optional), freq.max is the maximum frequency (optional), freq.cur 
+ * is the current frequency, validate points to a function returning 
+ * the closest available CPU frequency, and setspeed points to a 
+ * function performing the actual transition.
+ *
+ * All other variables are currently ignored.
+ *
+ *
+ *   Registers a CPU Frequency driver to this core code. This code 
+ * returns zero on success, -EBUSY when another driver got here first
+ * (and isn't unregistered in the meantime). 
+ *
+ */
+int cpufreq_register(struct cpufreq_driver *driver_data)
+{
+	int i, j;
+
+	if (cpufreq_driver)
+		return -EBUSY;
+	
+	if (!driver_data || !driver_data->freq)
+		return -EINVAL;
+
+	down(&cpufreq_driver_sem);
+	
+	cpufreq_driver = driver_data;
+
+	/*
+	 * If the user doesn't tell us the maximum frequency,
+	 * or if it is invalid, use the values determined 
+	 * by the cpufreq-arch-specific initialization functions.
+	 * The validatespeed code is responsible for limiting
+	 * this further.
+	 */
+
+	if (cpufreq_driver->sync)
+		j = 1;
+	else
+		j = NR_CPUS;
+	for (i=0; i<j; i++) {
+		if (!cpufreq_driver->freq[i].max ||
+		    (cpufreq_freq_limit.max && 
+		     (cpufreq_freq_limit.max < cpufreq_driver->freq[i].max)))
+	     		cpufreq_driver->freq[i].max = cpufreq_freq_limit.max;
+		
+		if (!cpufreq_driver->freq[i].min ||
+		    (cpufreq_driver->freq[i].min < cpufreq_freq_limit.min))
+	    		cpufreq_driver->freq[i].min = cpufreq_freq_limit.min;
+	
+		if (cpufreq_driver->sync) {
+			cpufreq_ref_loops = loops_per_jiffy;
+			cpufreq_ref_freq = cpufreq_driver->freq->cur;
+		} else
+			BUG();
+	} 
+
+	printk(KERN_INFO "CPU clock: %d.%03d MHz (%d.%03d-%d.%03d MHz)\n",
+		cpufreq_driver->freq[0].cur / 1000, cpufreq_driver->freq[0].cur % 1000,
+		cpufreq_driver->freq[0].min / 1000, cpufreq_driver->freq[0].min % 1000,
+		cpufreq_driver->freq[0].max / 1000, cpufreq_driver->freq[0].max % 1000);
+
+	up(&cpufreq_driver_sem);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_register);
+
+
+/**
+ * cpufreq_unregister:
+ *
+ *    Unregister the current CPUFreq driver. Only call this if you have 
+ * the right to do so, i.e. if you have succeeded in initialising before!
+ * Returns zero if successful, and -EINVAL if the cpufreq_driver is
+ * currently not initialised.
+ */
+int cpufreq_unregister(void)
+{
+	down(&cpufreq_driver_sem);
+
+	if (!cpufreq_driver) {
+		up(&cpufreq_driver_sem);
+		return -EINVAL;
+	}
+
+	cpufreq_driver = NULL;
+
+	up(&cpufreq_driver_sem);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_unregister);
+
--- /dev/null	Sat May 12 19:23:16 2001
+++ linux/include/linux/cpufreq.h	Fri Jul 19 00:23:30 2002
@@ -0,0 +1,113 @@
+/*
+ *  linux/include/linux/cpufreq.h
+ *
+ *  Copyright (C) 2001 Russell King
+ *            (C) 2002 Dominik Brodowski <devel@brodo.de>
+ *            
+ *
+ * $Id: cpufreq.h,v 1.11 2002/07/18 22:23:30 db Exp $
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
+
+/* sysctl ctl_table entries */
+#define CTL_CPU_VARS_SPEED_MAX(cpunr) { \
+                ctl_name: CPU_NR_FREQ_MAX, \
+                procname: "speed-max", \
+                mode: 0444, \
+                proc_handler: cpufreq_procctl_max, \
+                extra1: (void*) (cpunr), }
+
+#define CTL_CPU_VARS_SPEED_MIN(cpunr) { \
+                ctl_name: CPU_NR_FREQ_MIN, \
+                procname: "speed-min", \
+                mode: 0444, \
+                proc_handler: cpufreq_procctl_min, \
+                extra1: (void*) (cpunr), }
+
+#define CTL_CPU_VARS_SPEED(cpunr) { \
+                ctl_name: CPU_NR_FREQ_MIN, \
+                procname: "speed", \
+                mode: 0644, \
+                proc_handler: cpufreq_procctl, \
+                strategy: cpufreq_sysctl, \
+                extra1: (void*) (cpunr), }
+
+#define CTL_CPU_VARS_SPEED_SYNC { \
+                ctl_name: CPU_NR_FREQ_SYNC, \
+                procname: "speed-sync", \
+                mode: 0444, \
+                proc_handler: cpufreq_procctl_sync }
+
+/* speed setting interface */
+
+int cpufreq_setmax(unsigned int cpu);
+int cpufreq_set(unsigned int cpu, unsigned int khz);
+unsigned int cpufreq_get(unsigned int cpu);
+
+#ifdef CONFIG_PM
+int cpufreq_restore(void);
+#endif
+
+
+/* notifier interface */
+
+/*
+ * The max and min frequency rates that the registered device
+ * can tolerate.  Never set any element this structure directly -
+ * always use cpufreq_updateminmax.
+ */
+struct cpufreq_freqs {
+	unsigned int cpu;
+	unsigned int min;
+	unsigned int max;
+	unsigned int cur;
+	unsigned int new;
+};
+
+static inline
+void cpufreq_updateminmax(struct cpufreq_freqs *freq, 
+			  unsigned int min, 
+			  unsigned int max)
+{
+	if (freq->min < min)
+		freq->min = min;
+	if (freq->max > max)
+		freq->max = max;
+}
+
+#define CPUFREQ_MINMAX		(0)
+#define CPUFREQ_PRECHANGE	(1)
+#define CPUFREQ_POSTCHANGE	(2)
+
+#define CPUFREQ_ALL_CPUS	(60000)
+
+int cpufreq_register_notifier(struct notifier_block *nb);
+int cpufreq_unregister_notifier(struct notifier_block *nb);
+
+
+
+/* cpufreq driver interface */
+
+typedef unsigned int (*cpufreq_verify_t)  (unsigned int cpu, unsigned int kHz);
+typedef void (*cpufreq_setspeed_t)        (unsigned int cpu, unsigned int kHz);
+
+struct cpufreq_driver {
+	struct cpufreq_freqs    *freq;	
+	cpufreq_verify_t        validate;
+	cpufreq_setspeed_t      setspeed;
+	unsigned int		sync; /* synchronized frequencies */
+};
+
+int cpufreq_register(struct cpufreq_driver *driver_data);
+int cpufreq_unregister(void);
+
+#endif
--- linux-original/include/linux/sysctl.h	Thu Jul 18 23:24:26 2002
+++ linux/include/linux/sysctl.h	Thu Jul 18 23:47:07 2002
@@ -648,6 +648,78 @@
 	ABI_FAKE_UTSNAME=6,	/* fake target utsname information */
 };
 
+/* /proc/sys/cpu */
+enum {
+	CPU_NR   = 1,           /* compatibilty reasons */
+	CPU_NR_0 = 1,
+	CPU_NR_1 = 2,
+	CPU_NR_2 = 3,
+	CPU_NR_3 = 4,
+	CPU_NR_4 = 5,
+	CPU_NR_5 = 6,
+	CPU_NR_6 = 7,
+	CPU_NR_7 = 8,
+	CPU_NR_8 = 9,
+	CPU_NR_9 = 10,
+	CPU_NR_10 = 11,
+	CPU_NR_11 = 12,
+	CPU_NR_12 = 13,
+	CPU_NR_13 = 14,
+	CPU_NR_14 = 15,
+	CPU_NR_15 = 16,
+	CPU_NR_16 = 17,
+	CPU_NR_17 = 18,
+	CPU_NR_18 = 19,
+	CPU_NR_19 = 20,
+	CPU_NR_20 = 21,
+	CPU_NR_21 = 22,
+	CPU_NR_22 = 23,
+	CPU_NR_23 = 24,
+	CPU_NR_24 = 25,
+	CPU_NR_25 = 26,
+	CPU_NR_26 = 27,
+	CPU_NR_27 = 28,
+	CPU_NR_28 = 29,
+	CPU_NR_29 = 30,
+	CPU_NR_30 = 31,
+	CPU_NR_31 = 32,
+};
+
+/* /proc/sys/cpu/{0,1,...,(NR_CPUS-1)} */
+enum {
+	CPU_NR_FREQ_MAX = 1,
+	CPU_NR_FREQ_MIN = 2,
+	CPU_NR_FREQ = 3,
+	CPU_NR_FREQ_SYNC = 4
+};
+
+
+/* for the CPU enumeration we need some more definitions */
+/* include macros */
+#ifdef CONFIG_CPU_FREQ
+#include <linux/cpufreq.h>
+#define CTL_CPU_VARS_CPUFREQ(cpunr) CTL_CPU_VARS_SPEED_MAX(cpunr), \
+                                    CTL_CPU_VARS_SPEED_MIN(cpunr), \
+                                    CTL_CPU_VARS_SPEED(cpunr),  \
+                                    CTL_CPU_VARS_SPEED_SYNC, 
+#else
+#define CTL_CPU_VARS_CPUFREQ(cpunr)
+#endif
+
+/* one ctl_table_vars_{0,1,...,(NR_CPUS-1)} for each CPU - this is only the 
+ * macro for the definitions in kernel/sysctl.c */
+#define CTL_TABLE_CPU_VARS(cpunr) static ctl_table ctl_cpu_vars_##cpunr[] = {\
+                CTL_CPU_VARS_CPUFREQ(cpunr)\
+                { ctl_name: 0, }, }
+
+/* the ctl_table entry for each CPU - kernel/sysctl.c */
+#define CPU_ENUM(s) { \
+                ctl_name: (CPU_NR + s), \
+                procname: #s, \
+                mode: 0555, \
+                child: ctl_cpu_vars_##s }
+
+
 #ifdef __KERNEL__
 
 extern asmlinkage long sys_sysctl(struct __sysctl_args *);
--- linux-original/kernel/sysctl.c	Thu Jul 18 23:24:57 2002
+++ linux/kernel/sysctl.c	Thu Jul 18 23:44:06 2002
@@ -93,6 +93,24 @@
 		  void *buffer, size_t *lenp);
 #endif
 
+#ifdef CONFIG_CPU_FREQ
+extern int cpufreq_sysctl(ctl_table *table, int *name, int nlen,
+	       void *oldval, size_t *oldlenp,
+	       void *newval, size_t newlen, void **context);
+extern int
+cpufreq_procctl(ctl_table *ctl, int write, struct file *filp,
+	       void *buffer, size_t *lenp);
+extern int
+cpufreq_procctl_max(ctl_table *ctl, int write, struct file *filp,
+	       void *buffer, size_t *lenp);
+extern int
+cpufreq_procctl_min(ctl_table *ctl, int write, struct file *filp,
+	       void *buffer, size_t *lenp);
+extern int
+cpufreq_procctl_sync(ctl_table *ctl, int write, struct file *filp,
+	       void *buffer, size_t *lenp);
+#endif
+
 #ifdef CONFIG_BSD_PROCESS_ACCT
 extern int acct_parm[];
 #endif
@@ -115,6 +133,7 @@
 static ctl_table fs_table[];
 static ctl_table debug_table[];
 static ctl_table dev_table[];
+static ctl_table cpu_table[];
 extern ctl_table random_table[];
 
 /* /proc declarations: */
@@ -152,6 +171,7 @@
 	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
 	{CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
         {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
+	{CTL_CPU, "cpu", NULL, 0, 0555, cpu_table},
 	{0}
 };
 
@@ -344,6 +364,212 @@
 static ctl_table dev_table[] = {
 	{0}
 };  
+
+
+/* ctl_table ctl_cpu_vars_{0,1,...,(NR_CPUS-1)} */
+/* due to NR_CPUS tweaking, a lot of if/endifs are required, sorry */
+        CTL_TABLE_CPU_VARS(0);
+#if NR_CPUS > 1
+	CTL_TABLE_CPU_VARS(1);
+#endif
+#if NR_CPUS > 2
+	CTL_TABLE_CPU_VARS(2);
+#endif
+#if NR_CPUS > 3
+	CTL_TABLE_CPU_VARS(3);
+#endif
+#if NR_CPUS > 4
+	CTL_TABLE_CPU_VARS(4);
+#endif
+#if NR_CPUS > 5
+	CTL_TABLE_CPU_VARS(5);
+#endif
+#if NR_CPUS > 6
+	CTL_TABLE_CPU_VARS(6);
+#endif
+#if NR_CPUS > 7
+	CTL_TABLE_CPU_VARS(7);
+#endif
+#if NR_CPUS > 8
+	CTL_TABLE_CPU_VARS(8);
+#endif
+#if NR_CPUS > 9
+	CTL_TABLE_CPU_VARS(9);
+#endif
+#if NR_CPUS > 10
+	CTL_TABLE_CPU_VARS(10);
+#endif
+#if NR_CPUS > 11
+	CTL_TABLE_CPU_VARS(11);
+#endif
+#if NR_CPUS > 12
+	CTL_TABLE_CPU_VARS(12);
+#endif
+#if NR_CPUS > 13
+	CTL_TABLE_CPU_VARS(13);
+#endif
+#if NR_CPUS > 14
+	CTL_TABLE_CPU_VARS(14);
+#endif
+#if NR_CPUS > 15
+	CTL_TABLE_CPU_VARS(15);
+#endif
+#if NR_CPUS > 16
+	CTL_TABLE_CPU_VARS(16);
+#endif
+#if NR_CPUS > 17
+	CTL_TABLE_CPU_VARS(17);
+#endif
+#if NR_CPUS > 18
+	CTL_TABLE_CPU_VARS(18);
+#endif
+#if NR_CPUS > 19
+	CTL_TABLE_CPU_VARS(19);
+#endif
+#if NR_CPUS > 20
+	CTL_TABLE_CPU_VARS(20);
+#endif
+#if NR_CPUS > 21
+	CTL_TABLE_CPU_VARS(21);
+#endif
+#if NR_CPUS > 22
+	CTL_TABLE_CPU_VARS(22);
+#endif
+#if NR_CPUS > 23
+	CTL_TABLE_CPU_VARS(23);
+#endif
+#if NR_CPUS > 24
+	CTL_TABLE_CPU_VARS(24);
+#endif
+#if NR_CPUS > 25
+	CTL_TABLE_CPU_VARS(25);
+#endif
+#if NR_CPUS > 26
+	CTL_TABLE_CPU_VARS(26);
+#endif
+#if NR_CPUS > 27
+	CTL_TABLE_CPU_VARS(27);
+#endif
+#if NR_CPUS > 28
+	CTL_TABLE_CPU_VARS(28);
+#endif
+#if NR_CPUS > 29
+	CTL_TABLE_CPU_VARS(29);
+#endif
+#if NR_CPUS > 30
+	CTL_TABLE_CPU_VARS(30);
+#endif
+#if NR_CPUS > 31
+	CTL_TABLE_CPU_VARS(31);
+#endif
+#if NR_CPUS > 32
+#error please extend CPU enumeration
+#endif
+
+/* due to NR_CPUS tweaking, a lot of if/endifs are required, sorry */
+static ctl_table cpu_table[NR_CPUS + 1] = {
+	CPU_ENUM(0),
+#if NR_CPUS > 1
+	CPU_ENUM(1),
+#endif
+#if NR_CPUS > 2
+	CPU_ENUM(2),
+#endif
+#if NR_CPUS > 3
+	CPU_ENUM(3),
+#endif
+#if NR_CPUS > 4
+	CPU_ENUM(4),
+#endif
+#if NR_CPUS > 5
+	CPU_ENUM(5),
+#endif
+#if NR_CPUS > 6
+	CPU_ENUM(6),
+#endif
+#if NR_CPUS > 7
+	CPU_ENUM(7),
+#endif
+#if NR_CPUS > 8
+	CPU_ENUM(8),
+#endif
+#if NR_CPUS > 9
+	CPU_ENUM(9),
+#endif
+#if NR_CPUS > 10
+	CPU_ENUM(10),
+#endif
+#if NR_CPUS > 11
+	CPU_ENUM(11),
+#endif
+#if NR_CPUS > 12
+	CPU_ENUM(12),
+#endif
+#if NR_CPUS > 13
+	CPU_ENUM(13),
+#endif
+#if NR_CPUS > 14
+	CPU_ENUM(14),
+#endif
+#if NR_CPUS > 15
+	CPU_ENUM(15),
+#endif
+#if NR_CPUS > 16
+	CPU_ENUM(16),
+#endif
+#if NR_CPUS > 17
+	CPU_ENUM(17),
+#endif
+#if NR_CPUS > 18
+	CPU_ENUM(18),
+#endif
+#if NR_CPUS > 19
+	CPU_ENUM(19),
+#endif
+#if NR_CPUS > 20
+	CPU_ENUM(20),
+#endif
+#if NR_CPUS > 21
+	CPU_ENUM(21),
+#endif
+#if NR_CPUS > 22
+	CPU_ENUM(22),
+#endif
+#if NR_CPUS > 23
+	CPU_ENUM(23),
+#endif
+#if NR_CPUS > 24
+	CPU_ENUM(24),
+#endif
+#if NR_CPUS > 25
+	CPU_ENUM(25),
+#endif
+#if NR_CPUS > 26
+	CPU_ENUM(26),
+#endif
+#if NR_CPUS > 27
+	CPU_ENUM(27),
+#endif
+#if NR_CPUS > 28
+	CPU_ENUM(28),
+#endif
+#if NR_CPUS > 29
+	CPU_ENUM(29),
+#endif
+#if NR_CPUS > 30
+	CPU_ENUM(30),
+#endif
+#if NR_CPUS > 31
+	CPU_ENUM(31),
+#endif
+#if NR_CPUS > 32
+#error please extend CPU enumeration
+#endif
+	{
+		ctl_name:	0,
+	}
+};
+
 
 extern void init_irq_proc (void);
 
--- /dev/null	Sat May 12 19:23:16 2001
+++ linux/Documentation/cpufreq	Sat Jul 20 00:12:08 2002
@@ -0,0 +1,303 @@
+     CPU frequency and voltage scaling code in the Linux(TM) kernel
+
+
+		         L i n u x    C P U F r e q
+
+
+
+
+		    Dominik Brodowski  <devel@brodo.de>
+		     David Kimdon <dwhedon@debian.org>
+
+
+
+   Clock scaling allows you to change the clock speed of the CPUs on the
+    fly. This is a nice method to save battery power, because the lower
+            the clock speed, the less power the CPU consumes.
+
+
+
+Contents:
+---------
+1.  Supported architectures
+2.  User interface
+2.1   Sample script for command line interface
+3.  CPUFreq core and interfaces
+3.1   General information
+3.2   CPUFreq notifiers
+3.3   CPUFreq architecture drivers
+4.  Mailing list and Links
+
+
+
+1. Supported architectures
+==========================
+
+Some architectures detect the lowest and highest possible speed
+settings, while others rely on user information on this. For the
+latter, a boot parameter is required. For the former, you can specify
+a boot parameter to set limits on the speed settings which may occur. 
+The boot parameter has the following syntax:
+
+     cpufreq=minspeed-maxspeed
+
+with both minspeed and maxspeed given in kHz. To set the lower
+limit to 59 MHz and the upper limit to 221 MHz, specify:
+
+      cpufreq=59000-221000
+
+Check the "Speed Limits Detection" information below on whether
+the driver detects the lowest and highest allowed speed setting
+automatically.
+
+
+ARM Integrator:
+    SA 1100, SA1110
+--------------------------------
+    Speed Limits Detection: On Integrators, the minimum speed is set
+    and the maximum speed has to be specified using the boot
+    parameter. On SA11x0s, the frequencies are fixed (59 - 287 MHz)
+
+
+AMD Elan:
+    SC400, SC410
+--------------------------------
+    Speed Limits Detection: Not implemented. You need to specify the
+    minimum and maximum frequency in the boot parameter (see above).
+
+
+
+2. User Interface
+=================
+
+CPUFreq uses a "sysctl" interface which is located in 
+	/proc/sys/cpu/0/
+	/proc/sys/cpu/1/ ...	(SMP only)
+
+In these directories, you will find four files of importance for
+CPUFreq: speed-max, speed-min, speed-sync and speed: 
+
+speed		    shows the current CPU frequency in kHz, 
+speed-min	    the minimum supported CPU frequency, and
+speed-max	    the maximum supported CPU frequency.
+speed-sync	    is one if all CPUs need to run on the same clock
+			frequency, else zero.
+
+Please note that you might have to specify the speed limits as a boot
+parameter depending on the architecture (see above).
+
+
+To change the CPU frequency, "echo" the desired CPU frequency (in kHz)
+to speed. For example, to set the CPU speed to the lowest/highest
+allowed frequency do:
+
+root@notebook:# cat /proc/sys/cpu/0/speed-min > /proc/sys/cpu/0/speed
+root@notebook:# cat /proc/sys/cpu/0/speed-max > /proc/sys/cpu/0/speed
+
+
+2.1   Sample script for command line interface
+**********************************************
+
+
+Michael Ossmann <mike@ossmann.com> has written a small command line
+interface for the infinitely lazy.
+
+#!/bin/bash
+#
+# /usr/local/bin/freq
+#   simple command line interface to cpufreq
+
+[ -n "$1" ] && case "$1" in
+  "min" )
+    # set frequency to minimum
+    cat /proc/sys/cpu/0/speed-min >/proc/sys/cpu/0/speed
+    ;;
+  "max" )
+    # set frequency to maximum
+    cat /proc/sys/cpu/0/speed-max >/proc/sys/cpu/0/speed
+    ;;
+  * )
+    echo "Usage: $0 [min|max]"
+    echo "  min: set frequency to minimum and display new frequency"
+    echo "  max: set frequency to maximum and display new frequency"
+    echo "  no options: display current frequency"
+    exit 1
+    ;;
+esac
+
+# display current frequency
+cat /proc/sys/cpu/0/speed
+exit 0
+
+
+
+3.  CPUFreq core and interfaces
+===============================
+
+3.1   General information
+*************************
+
+The CPUFreq core code is located in linux/kernel/cpufreq.c. This
+cpufreq code offers a standardized interface for the CPUFreq
+architecture drivers (those pieces of code that do the actual
+frequency transition), as well as to "notifiers". These are device
+drivers or other part of the kernel that need to be informed of
+frequency changes (like timing code) or even need to force certain
+speed limits (like LCD drivers on ARM architecture). Additionally, the
+kernel "constant" loops_per_jiffy is updated on frequency changes
+here.
+
+
+3.2   CPUFreq notifiers
+***********************
+
+CPUFreq notifiers conform to the standard kernel notifier interface.
+See linux/include/linux/notifier.h for details on notifiers.
+
+The second argument to a CPUFreq notifier is the phase of the
+transition. 
+
+The third argument, a void *pointer, points to a struct cpufreq_freqs
+consisting of five values: cpu, min, max, cur and new.  min and max 
+are the minimum and maximum frequency rates that the device can 
+tolerate. cur is the current/old speed.  new is the new speed, but 
+might only be valid during the CPUFREQ_PRECHANGE or 
+CPUFREQ_POSTCHANGE phases. And cpu is either the number of the 
+affected CPU or CPUFREQ_ALL_CPUS when all CPUs are affected.
+
+Each CPUFreq notifier is called three times for a speed transition :
+
+    1. In preparation for a speed transition the kernel calls the
+    notifier with a phase of CPUFREQ_MINMAX in order to determine a
+    valid new frequency.  At this point the notifier updates the min
+    and max values to the limits the protected device / kernel code
+    needs.  Please note: Never update these values directly, use
+    cpufreq_updateminmax() instead.
+
+    2. Right before the transition the notifier is called with a phase
+    of CPUFREQ_PRECHANGE. 
+
+    3. Right after the transition the notifier is called with a phase
+    of CPUFREQ_POSTCHANGE.
+
+For the CPUFREQ_PRECHANGE and CPUFREQ_POSTCHANGE phases the notifier
+updates all internal (e.g. device driver) states which depend on the
+CPU frequency.
+
+
+3.3   CPUFreq architecture drivers
+**********************************
+
+CPUFreq architecture drivers are the pieces of kernel code that
+actually perform CPU frequency transitions. These need to be
+initialized separately (separate initcalls), and may be
+modularized. They interact with the CPUFreq core in the following way:
+
+
+cpufreq_register()
+------------------
+cpufreq_register registers an arch driver to the CPUFreq core. Please
+note that only one arch driver may be registered at any time. -EBUSY
+is returned when an arch driver is already registered. The argument to
+cpufreq_register, struct cpufreq_driver *driver, is described later.
+
+
+cpufreq_unregister()
+--------------------
+cpufreq_unregister unregisters an arch driver, e.g. on module
+unloading. Please note that there is no check done that this is called
+from the driver which actually registered itself to the core, so
+please only call this function when you are sure the arch driver got
+registered correctly before.
+
+
+struct cpufreq_driver
+----------------
+On initialization, the arch driver is supposed to pass a pointer
+to a struct cpufreq_driver *cpufreq_driver consistng of the following
+entries:
+
+cpufreq_verify_t validate: This is a pointer to a function with the
+following definition: 
+     unsigned int validating_function (unsigned int cpu,
+				       unsigned int kHz). 
+It is called right before a transition occurs. The proposed new
+speed setting is passed as an argument in kHz; the validating code
+should verify this is a valid speed setting which is currently
+supported by the CPU. It shall return the closest valid CPU frequency
+in kHz.
+
+cpufreq_setspeed_t setspeed: This is a pointer to a function with the
+following definition: 
+     void setspeed_function (unsigned int cpu, unsigned int kHz). 
+This function shall perform the transition to the new CPU frequency 
+given as argument in kHz. Note that this argument is exactly the same
+as the one returned by cpufreq_verify_t validate.
+
+unsigned int snyc: one if all CPUs need to run on the same core frequency
+all the time, or zero if asynchronous frequencies are possible. 
+
+struct cpufreq_freqs *freq: if (sync==1) this must point to one struct
+cpufreq_freqs, if (sync==0) it must point to an array of NR_CPUS struct
+cpufreq_freqs. Each struct cpufreq_freq consists of the following entries:
+
+unsigned int freq->cur: The current CPU core frequency. Note that this
+is a requirement while the next two entries are optional.
+
+unsigned int freq.min (optional): The minimum CPU core frequency this
+CPU supports. This value may be limited further by the
+cpufreq_verify_t validate function, and so this value should be the
+minimum core frequency allowed "theoretically" on this system in this
+configuration.
+
+
+unsigned int freq.max (optional): The maximum CPU core frequency this
+CPU supports. This value may be limited further by the
+cpufreq_verify_t validate function, and so this value should be the
+maximum core frequency allowed "theoretically" on this system in this
+configuration.
+
+
+Some Requirements to CPUFreq architecture drivers
+-------------------------------------------------
+* Only call cpufreq_register() when the ability to switch CPU
+  frequencies is _verified_ or can't be missing
+* cpufreq_unregister() may only be called if cpufreq_register() has
+  been successfully(!) called before.
+* kfree() the struct cpufreq_driver only after the call to 
+  cpufreq_unregister(), except cpufreq_register() failed.
+* Be aware that there is currently no error management in the
+  setspeed() code in the CPUFreq core. So only call yourself a
+  cpufreq_driver if you are really a working cpufreq_driver!
+
+
+
+4.  Mailing list and Links
+**************************
+
+
+Mailing List
+------------
+There is a CPU frequency changing CVS commit and general list where
+you can report bugs, problems or submit patches. To post a message,
+send an email to cpufreq@www.linux.org.uk, to subscribe go to
+http://www.linux.org.uk/mailman/listinfo/cpufreq. Previous post to the
+mailing list are available to subscribers at
+http://www.linux.org.uk/mailman/private/cpufreq/.
+
+
+Links
+-----
+the FTP archives:
+* ftp://ftp.linux.org.uk/pub/linux/cpufreq/
+
+how to access the CVS repository:
+* http://www.arm.linux.org.uk/cvs/
+
+the CPUFreq Mailing list:
+* http://www.linux.org.uk/mailman/listinfo/cpufreq
+
+Clock and voltage scaling for the SA-1100:
+* http://www.lart.tudelft.nl/projects/scaling
+
+CPUFreq project homepage
+* http://www.brodo.de/cpufreq/

