Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318790AbSH1LrT>; Wed, 28 Aug 2002 07:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318794AbSH1Lqq>; Wed, 28 Aug 2002 07:46:46 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:19845 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S318790AbSH1Lp4>; Wed, 28 Aug 2002 07:45:56 -0400
Date: Wed, 28 Aug 2002 13:46:30 +0200
From: Dominik Brodowski <devel@brodo.de>
To: torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH][2.5.32] CPUfreq core (1/4)
Message-ID: <20020828134630.B19189@brodo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

CPUFreq core for 2.5.32
include/linux/cpufreq.h		CPUFreq header
include/linux/sysctl.h		/proc/sys/cpu/.../ enumeration
kernel/Makefile			add cpufreq.c if necessary
kernel/cpufreq.c		CPUFreq core
kernel/sysctl.c			/proc/sys/cpu/.../ enumeration
# unfortunately no #for() preprocessor call exists...

diff -ruN linux-2531orig/include/linux/cpufreq.h linux/include/linux/cpufre=
q.h
--- linux-2531orig/include/linux/cpufreq.h	Thu Jan  1 01:00:00 1970
+++ linux/include/linux/cpufreq.h	Wed Aug 28 10:11:50 2002
@@ -0,0 +1,142 @@
+/*
+ *  linux/include/linux/cpufreq.h
+ *
+ *  Copyright (C) 2001 Russell King
+ *            (C) 2002 Dominik Brodowski <devel@brodo.de>
+ *           =20
+ *
+ * $Id: cpufreq.h,v 1.13 2002/08/22 22:48:47 db Exp $
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
+void cpufreq_updateminmax(struct cpufreq_freqs *freq,=20
+			  unsigned int min,=20
+			  unsigned int max)
+{
+	if (freq->min < min)
+		freq->min =3D min;
+	if (freq->max > max)
+		freq->max =3D max;
+}
+
+/**
+ * cpufreq_scale - "old * mult / div" calculation for large values (32-bit=
-arch safe)
+ * @old:   old value
+ * @div:   divisor
+ * @mult:  multiplier
+ *
+ * Needed for loops_per_jiffy and similar calculations.  We do it=20
+ * this way to avoid math overflow on 32-bit machines.  This will
+ * become architecture dependent once high-resolution-timer is
+ * merged (or any other thing that introduces sc_math.h).
+ *
+ *    new =3D old * mult / div
+ */
+static inline unsigned long cpufreq_scale(unsigned long old, u_int div, u_=
int mult)
+{
+	unsigned long val, carry;
+
+	mult /=3D 100;
+	div  /=3D 100;
+        val   =3D (old / div) * mult;
+        carry =3D old % div;
+	carry =3D carry * mult / div;
+
+	return carry + val;
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
+typedef unsigned int (*cpufreq_verify_t)  (unsigned int cpu, unsigned int =
kHz);
+typedef void (*cpufreq_setspeed_t)        (unsigned int cpu, unsigned int =
kHz);
+
+struct cpufreq_driver {
+	struct cpufreq_freqs    *freq;=09
+	cpufreq_verify_t        validate;
+	cpufreq_setspeed_t      setspeed;
+	unsigned int		sync; /* synchronized frequencies */
+};
+
+#define CPUFREQ_SYNC            1 /* all CPUs need to run the same frequen=
cy */
+#define CPUFREQ_ASYNC           0 /* all CPUs can have different frequenci=
es */
+
+int cpufreq_register(struct cpufreq_driver *driver_data);
+int cpufreq_unregister(void);
+
+#endif
diff -ruN linux-2531orig/include/linux/sysctl.h linux/include/linux/sysctl.h
--- linux-2531orig/include/linux/sysctl.h	Wed Aug 28 10:01:01 2002
+++ linux/include/linux/sysctl.h	Wed Aug 28 10:13:03 2002
@@ -631,6 +631,78 @@
 	ABI_FAKE_UTSNAME=3D6,	/* fake target utsname information */
 };
=20
+/* /proc/sys/cpu */
+enum {
+	CPU_NR   =3D 1,           /* compatibilty reasons */
+	CPU_NR_0 =3D 1,
+	CPU_NR_1 =3D 2,
+	CPU_NR_2 =3D 3,
+	CPU_NR_3 =3D 4,
+	CPU_NR_4 =3D 5,
+	CPU_NR_5 =3D 6,
+	CPU_NR_6 =3D 7,
+	CPU_NR_7 =3D 8,
+	CPU_NR_8 =3D 9,
+	CPU_NR_9 =3D 10,
+	CPU_NR_10 =3D 11,
+	CPU_NR_11 =3D 12,
+	CPU_NR_12 =3D 13,
+	CPU_NR_13 =3D 14,
+	CPU_NR_14 =3D 15,
+	CPU_NR_15 =3D 16,
+	CPU_NR_16 =3D 17,
+	CPU_NR_17 =3D 18,
+	CPU_NR_18 =3D 19,
+	CPU_NR_19 =3D 20,
+	CPU_NR_20 =3D 21,
+	CPU_NR_21 =3D 22,
+	CPU_NR_22 =3D 23,
+	CPU_NR_23 =3D 24,
+	CPU_NR_24 =3D 25,
+	CPU_NR_25 =3D 26,
+	CPU_NR_26 =3D 27,
+	CPU_NR_27 =3D 28,
+	CPU_NR_28 =3D 29,
+	CPU_NR_29 =3D 30,
+	CPU_NR_30 =3D 31,
+	CPU_NR_31 =3D 32,
+};
+
+/* /proc/sys/cpu/{0,1,...,(NR_CPUS-1)} */
+enum {
+	CPU_NR_FREQ_MAX =3D 1,
+	CPU_NR_FREQ_MIN =3D 2,
+	CPU_NR_FREQ =3D 3,
+	CPU_NR_FREQ_SYNC =3D 4
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
+                                    CTL_CPU_VARS_SPEED_SYNC,=20
+#else
+#define CTL_CPU_VARS_CPUFREQ(cpunr)
+#endif
+
+/* one ctl_table_vars_{0,1,...,(NR_CPUS-1)} for each CPU - this is only th=
e=20
+ * macro for the definitions in kernel/sysctl.c */
+#define CTL_TABLE_CPU_VARS(cpunr) static ctl_table ctl_cpu_vars_##cpunr[] =
=3D {\
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
=20
 extern asmlinkage long sys_sysctl(struct __sysctl_args *);
diff -ruN linux-2531orig/kernel/Makefile linux/kernel/Makefile
--- linux-2531orig/kernel/Makefile	Wed Aug 28 10:01:11 2002
+++ linux/kernel/Makefile	Wed Aug 28 10:19:20 2002
@@ -10,7 +10,7 @@
 O_TARGET :=3D kernel.o
=20
 export-objs =3D signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o=
 \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o cpufreq.o
=20
 obj-y     =3D sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
@@ -22,6 +22,7 @@
 obj-$(CONFIG_UID16) +=3D uid16.o
 obj-$(CONFIG_MODULES) +=3D ksyms.o
 obj-$(CONFIG_PM) +=3D pm.o
+obj-$(CONFIG_CPU_FREQ) +=3D cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) +=3D acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) +=3D suspend.o
=20
diff -ruN linux-2531orig/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-2531orig/kernel/cpufreq.c	Thu Jan  1 01:00:00 1970
+++ linux/kernel/cpufreq.c	Wed Aug 28 10:12:05 2002
@@ -0,0 +1,709 @@
+/*
+ *  linux/kernel/cpufreq.c
+ *
+ *  Copyright (C) 2001 Russell King
+ *            (C) 2002 Dominik Brodowski <devel@brodo.de>
+ *
+ *  $Id: cpufreq.c,v 1.33 2002/08/17 11:45:22 db Exp $
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
+ * Some data for the CPUFreq core - loops_per_jiffy / frequency values at =
boot
+ */
+static unsigned long            cpufreq_ref_loops;
+static unsigned int             cpufreq_ref_freq;
+
+
+
+
+
+/**
+ * cpufreq_setup - cpufreq command line parameter parsing
+ *
+ * cpufreq command line parameter.  Use:
+ *  cpufreq=3D59000-221000
+ * to set the CPU frequency to 59 to 221MHz.
+ */
+static int __init cpufreq_setup(char *str)
+{
+	unsigned int min, max;
+
+	min =3D 0;
+	max =3D simple_strtoul(str, &str, 0);
+	if (*str =3D=3D '-') {
+		min =3D max;
+		max =3D simple_strtoul(str + 1, NULL, 0);
+	}
+
+	down(&cpufreq_driver_sem);
+	cpufreq_freq_limit.max =3D max;
+	cpufreq_freq_limit.min =3D min;
+	up(&cpufreq_driver_sem);
+
+	return 1;
+}
+__setup("cpufreq=3D", cpufreq_setup);
+
+
+/**
+ * adjust_jiffies - adjust the system "loops_per_jiffy"
+ *
+ * This function alters the system "loops_per_jiffy" for the clock
+ * speed change. Note that loops_per_jiffy is only valid for the=20
+ * _fastest_ CPU. It is not meant to be an accurate value. Drivers
+ * should rely on ?delay() calls instead, architectures might have
+ * per-CPU loops_per_jiffy values.
+ */
+static void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
+{
+	/* adjust_jiffies is called with cpufreq_driver locked */
+	if ((val =3D=3D CPUFREQ_PRECHANGE  && ci->cur < ci->new) ||
+	    (val =3D=3D CPUFREQ_POSTCHANGE && ci->cur > ci->new)) {
+		if (cpufreq_driver->sync =3D=3D CPUFREQ_SYNC)
+			loops_per_jiffy =3D cpufreq_scale(cpufreq_ref_loops, cpufreq_ref_freq,
+							ci->new);
+		else {
+			int i;
+			unsigned int highest_freq =3D 0;
+			for (i=3D0;i<NR_CPUS;i++)
+				if (cpufreq_driver->freq[i].cur > highest_freq)
+					highest_freq =3D cpufreq_driver->freq[i].cur;
+			if (ci->new > highest_freq)
+				highest_freq =3D ci->new;
+			loops_per_jiffy =3D cpufreq_scale(cpufreq_ref_loops, cpufreq_ref_freq, =
highest_freq);
+		}
+	}
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
+	ret =3D notifier_chain_register(&cpufreq_notifier_list, nb);
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
+	ret =3D notifier_chain_unregister(&cpufreq_notifier_list, nb);
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
+ *	command line parameter, information obtained from the cpufreq=20
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
+		ret =3D -EINVAL;
+		goto out;
+	}
+
+	ret =3D -ENXIO;
+	if (!cpufreq_driver->setspeed || !cpufreq_driver->validate)
+		goto out;
+
+	/*
+	 * Don't allow the CPU to be clocked over the limit.
+	 */
+	if (cpufreq_driver->sync =3D=3D CPUFREQ_SYNC) {
+		cpufreq.cpu =3D CPUFREQ_ALL_CPUS;
+		cpu =3D 0;
+	} else {
+		if (cpu >=3D NR_CPUS) {
+			ret =3D -EINVAL;
+			goto out;
+		}
+		cpufreq.cpu =3D cpu;
+	}
+	cpufreq.min =3D cpufreq_driver->freq[cpu].min;
+	cpufreq.max =3D cpufreq_driver->freq[cpu].max;
+	cpufreq.cur =3D cpufreq_driver->freq[cpu].cur;
+	cpufreq.new =3D freq;
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
+		freq =3D cpufreq.min;
+	if (freq > cpufreq.max)
+		freq =3D cpufreq.max;
+
+	/*
+	 * Ask the CPU specific code to validate the speed.  If the speed
+	 * is not acceptable, make it acceptable.  Current policy is to
+	 * round the frequency down to the value the processor actually
+	 * supports.
+	 */
+	freq =3D cpufreq_driver->validate(cpu, freq);
+
+	if (cpufreq_driver->freq[cpu].cur !=3D freq) {
+		cpufreq.cur =3D cpufreq_driver->freq[cpu].cur;
+		cpufreq.new =3D freq;
+
+		notifier_call_chain(&cpufreq_notifier_list, CPUFREQ_PRECHANGE,
+				    &cpufreq);
+
+		adjust_jiffies(CPUFREQ_PRECHANGE, &cpufreq);
+
+		/*
+		 * Actually set the CPU frequency.
+		 */
+		preempt_disable();
+		cpufreq_driver->setspeed(cpu, freq);
+		preempt_enable();
+		cpufreq_driver->freq[cpu].cur =3D freq;
+		adjust_jiffies(CPUFREQ_POSTCHANGE, &cpufreq);
+
+		notifier_call_chain(&cpufreq_notifier_list, CPUFREQ_POSTCHANGE,
+				    &cpufreq);
+
+		ret =3D 0;
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
+	unsigned int max_freq =3D 0;
+
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver) {
+		up(&cpufreq_driver_sem);
+		return -EINVAL;
+	}
+	if (cpufreq_driver->sync =3D=3D CPUFREQ_SYNC)
+		max_freq =3D cpufreq_driver->freq->max;
+	else if (cpu < NR_CPUS)
+		max_freq =3D cpufreq_driver->freq[cpu].max;
+=09
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
+	unsigned int current_freq =3D 0;
+
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver) {
+		up(&cpufreq_driver_sem);
+		return 0;
+	}
+=09
+	if (cpufreq_driver->sync =3D=3D CPUFREQ_SYNC)
+		current_freq =3D cpufreq_driver->freq->cur;
+	else if (cpu < NR_CPUS)
+		current_freq =3D cpufreq_driver->freq[cpu].max;
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
+	int ret =3D 0;
+
+	if (in_interrupt())
+		panic("cpufreq_restore() called from interrupt context!");
+
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver) {
+		up(&cpufreq_driver_sem);
+		return -EINVAL;
+	}
+	ret =3D -ENXIO;
+	if (cpufreq_driver->setspeed) {
+		if (cpufreq_driver->sync =3D=3D CPUFREQ_SYNC)
+			cpufreq_driver->setspeed(0, cpufreq_driver->freq->cur);
+		else {
+			int i;
+			for (i=3D0; i < NR_CPUS; i++)
+				cpufreq_driver->setspeed(i, cpufreq_driver->freq[i].cur);
+		}
+		ret =3D 0;
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
+	int len, left =3D *lenp;
+	unsigned int printout =3D -1;
+
+	if (!left || write || filp->f_pos) {
+		*lenp =3D 0;
+		return 0;
+	}
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver)
+		printout =3D cpufreq_freq_limit.min;
+	else {
+		if (cpufreq_driver->sync =3D=3D CPUFREQ_SYNC)
+			printout =3D cpufreq_driver->freq->min;
+		else if (((int) ctl->extra1) < NR_CPUS)
+			printout =3D cpufreq_driver->freq[(int) ctl->extra1].min;
+	}
+	up(&cpufreq_driver_sem);
+=09
+	len =3D sprintf(buf, "%d\n", printout);
+	if (len > left)
+		len =3D left;
+	if (copy_to_user(buffer, buf, len))
+		return -EFAULT;
+
+	*lenp =3D len;
+	filp->f_pos +=3D len;
+	return 0;
+}
+
+
+int
+cpufreq_procctl_max(ctl_table *ctl, int write, struct file *filp,
+		void *buffer, size_t *lenp)
+{
+	char buf[16];
+	int len, left =3D *lenp;
+	unsigned int printout =3D -1;
+
+	if (!left || write || filp->f_pos) {
+		*lenp =3D 0;
+		return 0;
+	}
+=09
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver)
+		printout =3D cpufreq_freq_limit.max;
+	else {
+		if (cpufreq_driver->sync =3D=3D CPUFREQ_SYNC)
+			printout =3D cpufreq_driver->freq->max;
+		else if (((int) ctl->extra1) < NR_CPUS)
+			printout =3D cpufreq_driver->freq[(int) ctl->extra1].max;
+	}
+	up(&cpufreq_driver_sem);
+
+	len =3D sprintf(buf, "%d\n", printout);
+	if (len > left)
+		len =3D left;
+	if (copy_to_user(buffer, buf, len))
+		return -EFAULT;
+
+	*lenp =3D len;
+	filp->f_pos +=3D len;
+	return 0;
+}
+
+
+int
+cpufreq_procctl_sync(ctl_table *ctl, int write, struct file *filp,
+		void *buffer, size_t *lenp)
+{
+	char buf[16];
+	int len, left =3D *lenp;
+	unsigned int printout =3D 0;
+
+	if (!left || write || filp->f_pos) {
+		*lenp =3D 0;
+		return 0;
+	}
+=09
+	down(&cpufreq_driver_sem);
+	if (!cpufreq_driver)
+		printout =3D -1;
+	else=20
+		printout =3D cpufreq_driver->sync;
+	up(&cpufreq_driver_sem);
+
+	len =3D sprintf(buf, "%d\n", printout);
+	if (len > left)
+		len =3D left;
+	if (copy_to_user(buffer, buf, len))
+		return -EFAULT;
+
+	*lenp =3D len;
+	filp->f_pos +=3D len;
+	return 0;
+}
+
+
+int
+cpufreq_procctl(ctl_table *ctl, int write, struct file *filp,
+		void *buffer, size_t *lenp)
+{
+	char buf[16], *p;
+	int len, left =3D *lenp;
+ 	unsigned int cpu =3D 0;
+
+	if (!left || (filp->f_pos && !write)) {
+		*lenp =3D 0;
+		return 0;
+	}
+
+	if (write) {
+		unsigned int freq;
+
+		len =3D left;
+		if (left > sizeof(buf))
+			left =3D sizeof(buf);
+		if (copy_from_user(buf, buffer, left))
+			return -EFAULT;
+		buf[sizeof(buf) - 1] =3D '\0';
+
+		freq =3D simple_strtoul(buf, &p, 0);
+		down(&cpufreq_driver_sem);
+		if (!cpufreq_driver) {
+			up(&cpufreq_driver_sem);
+			return -EINVAL;
+		}
+		if (cpufreq_driver->sync =3D=3D CPUFREQ_SYNC)
+			cpu =3D CPUFREQ_ALL_CPUS;
+		else
+			cpu =3D (int) ctl->extra1;
+		up(&cpufreq_driver_sem);
+		cpufreq_set(cpu, freq);
+	} else {
+		down(&cpufreq_driver_sem);
+		if (!cpufreq_driver) {
+			up(&cpufreq_driver_sem);
+			return -EINVAL;
+		}
+		if (cpufreq_driver->sync =3D=3D CPUFREQ_SYNC)
+			cpu =3D CPUFREQ_ALL_CPUS;
+		else
+			cpu =3D (int) ctl->extra1;
+		up(&cpufreq_driver_sem);
+	=09
+		len =3D sprintf(buf, "%d\n", cpufreq_get(cpu));
+		if (len > left)
+			len =3D left;
+		if (copy_to_user(buffer, buf, len))
+			return -EFAULT;
+	}
+
+	*lenp =3D len;
+	filp->f_pos +=3D len;
+	return 0;
+}
+
+int
+cpufreq_sysctl(ctl_table *table, int *name, int nlen,
+	       void *oldval, size_t *oldlenp,
+	       void *newval, size_t newlen, void **context)
+{
+	unsigned int cpu =3D 0;
+
+	if (oldval && oldlenp) {
+		size_t oldlen;
+
+		if (get_user(oldlen, oldlenp))
+			return -EFAULT;
+
+		if (oldlen !=3D sizeof(unsigned int))
+			return -EINVAL;
+		=09
+		down(&cpufreq_driver_sem);
+		if (!cpufreq_driver) {
+			up(&cpufreq_driver_sem);
+			return -EINVAL;
+		}
+		if (cpufreq_driver->sync =3D=3D CPUFREQ_SYNC)
+			cpu =3D CPUFREQ_ALL_CPUS;
+		else
+			cpu =3D (int) table->extra1;
+		up(&cpufreq_driver_sem);
+	=09
+		if (put_user(cpufreq_get(cpu), (unsigned int *)oldval) ||
+		    put_user(sizeof(unsigned int), oldlenp))
+			return -EFAULT;
+	}
+	if (newval && newlen) {
+		unsigned int freq;
+
+		if (newlen !=3D sizeof(unsigned int))
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
+		if (cpufreq_driver->sync =3D=3D CPUFREQ_SYNC)
+			cpu =3D CPUFREQ_ALL_CPUS;
+		else
+			cpu =3D (int) table->extra1;
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
+ * @driver_data: A struct cpufreq_driver containing the values submitted b=
y the CPU Frequency driver.
+ *
+ * driver_data should contain the following elements:=20
+ * freq.min is the minimum frequency the CPU / the CPUs can be set to=20
+ * (optional), freq.max is the maximum frequency (optional), freq.cur=20
+ * is the current frequency, validate points to a function returning=20
+ * the closest available CPU frequency, and setspeed points to a=20
+ * function performing the actual transition.
+ *
+ * All other variables are currently ignored.
+ *
+ *
+ *   Registers a CPU Frequency driver to this core code. This code=20
+ * returns zero on success, -EBUSY when another driver got here first
+ * (and isn't unregistered in the meantime).=20
+ *
+ */
+int cpufreq_register(struct cpufreq_driver *driver_data)
+{
+	int i, j;
+
+	if (cpufreq_driver)
+		return -EBUSY;
+=09
+	if (!driver_data || !driver_data->freq)
+		return -EINVAL;
+
+	down(&cpufreq_driver_sem);
+=09
+	cpufreq_driver =3D driver_data;
+
+	/*
+	 * If the user doesn't tell us the maximum frequency,
+	 * or if it is invalid, use the values determined=20
+	 * by the cpufreq-arch-specific initialization functions.
+	 * The validatespeed code is responsible for limiting
+	 * this further.
+	 */
+
+	if (cpufreq_driver->sync =3D=3D CPUFREQ_SYNC)
+		j =3D 1;
+	else
+		j =3D NR_CPUS;
+	for (i=3D0; i<j; i++) {
+		if (!cpufreq_driver->freq[i].max ||
+		    (cpufreq_freq_limit.max &&=20
+		     (cpufreq_freq_limit.max < cpufreq_driver->freq[i].max)))
+	     		cpufreq_driver->freq[i].max =3D cpufreq_freq_limit.max;
+	=09
+		if (!cpufreq_driver->freq[i].min ||
+		    (cpufreq_driver->freq[i].min < cpufreq_freq_limit.min))
+	    		cpufreq_driver->freq[i].min =3D cpufreq_freq_limit.min;
+=09
+		cpufreq_ref_loops =3D loops_per_jiffy;
+		cpufreq_ref_freq =3D cpufreq_driver->freq->cur;
+	}=20
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
+ *    Unregister the current CPUFreq driver. Only call this if you have=20
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
+	cpufreq_driver =3D NULL;
+
+	up(&cpufreq_driver_sem);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_unregister);
+
diff -ruN linux-2531orig/kernel/sysctl.c linux/kernel/sysctl.c
--- linux-2531orig/kernel/sysctl.c	Wed Aug 28 10:01:11 2002
+++ linux/kernel/sysctl.c	Wed Aug 28 10:13:03 2002
@@ -93,6 +93,24 @@
 		  void *buffer, size_t *lenp);
 #endif
=20
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
=20
 /* /proc declarations: */
@@ -152,6 +171,7 @@
 	{CTL_FS, "fs", NULL, 0, 0555, fs_table},
 	{CTL_DEBUG, "debug", NULL, 0, 0555, debug_table},
         {CTL_DEV, "dev", NULL, 0, 0555, dev_table},
+	{CTL_CPU, "cpu", NULL, 0, 0555, cpu_table},
 	{0}
 };
=20
@@ -345,6 +365,212 @@
 static ctl_table dev_table[] =3D {
 	{0}
 }; =20
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
+static ctl_table cpu_table[NR_CPUS + 1] =3D {
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
=20
 extern void init_irq_proc (void);
=20

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iD8DBQE9bLgSZ8MDCHJbN8YRAoDDAJ0dRuUa/7zlAOkY4EmXaR9p3eRAkQCcCQ3b
d+NRwl1a+IDtWa6aHMKq3GM=
=lus2
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
