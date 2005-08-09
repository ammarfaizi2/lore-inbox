Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVHICyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVHICyW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 22:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVHICyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 22:54:22 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:50165 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932423AbVHICyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 22:54:21 -0400
Date: Mon, 8 Aug 2005 19:54:19 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org,
       cpufreq@lists.linux.org.uk
Subject: PowerOP 2/3: Intel Centrino support
Message-ID: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minimal PowerOP support for Intel Enhanced Speedstep "Centrino"
notebooks.  These systems run at an operating point comprised of a cpu
frequency and a core voltage.  The voltage could be set from the values
recommended in the datasheets if left unspecified (-1) in the operating
point, as cpufreq does.


Index: linux-2.6.12/arch/i386/Kconfig
===================================================================
--- linux-2.6.12.orig/arch/i386/Kconfig	2005-08-02 23:39:05.000000000 +0000
+++ linux-2.6.12/arch/i386/Kconfig	2005-08-03 01:11:21.000000000 +0000
@@ -1098,6 +1098,7 @@
 endmenu
 
 source "arch/i386/kernel/cpu/cpufreq/Kconfig"
+source "arch/i386/kernel/cpu/powerop/Kconfig"
 
 endmenu
 
Index: linux-2.6.12/arch/i386/kernel/cpu/Makefile
===================================================================
--- linux-2.6.12.orig/arch/i386/kernel/cpu/Makefile	2005-08-02 23:39:05.000000000 +0000
+++ linux-2.6.12/arch/i386/kernel/cpu/Makefile	2005-08-03 01:11:21.000000000 +0000
@@ -17,3 +17,4 @@
 
 obj-$(CONFIG_MTRR)	+= 	mtrr/
 obj-$(CONFIG_CPU_FREQ)	+=	cpufreq/
+obj-$(CONFIG_POWEROP)	+=	powerop/
Index: linux-2.6.12/arch/i386/kernel/cpu/powerop/Kconfig
===================================================================
--- linux-2.6.12.orig/arch/i386/kernel/cpu/powerop/Kconfig	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12/arch/i386/kernel/cpu/powerop/Kconfig	2005-08-03 01:11:21.000000000 +0000
@@ -0,0 +1,6 @@
+source "drivers/powerop/Kconfig"
+
+config POWEROP_CENTRINO
+       tristate "PowerOP for Intel Centrino Enhanced Speedstep"
+       depends on POWEROP
+       default n
Index: linux-2.6.12/arch/i386/kernel/cpu/powerop/Makefile
===================================================================
--- linux-2.6.12.orig/arch/i386/kernel/cpu/powerop/Makefile	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12/arch/i386/kernel/cpu/powerop/Makefile	2005-08-03 01:11:21.000000000 +0000
@@ -0,0 +1,2 @@
+obj-$(CONFIG_POWEROP_CENTRINO)	+=	powerop-centrino.o
+
Index: linux-2.6.12/arch/i386/kernel/cpu/powerop/powerop-centrino.c
===================================================================
--- linux-2.6.12.orig/arch/i386/kernel/cpu/powerop/powerop-centrino.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12/arch/i386/kernel/cpu/powerop/powerop-centrino.c	2005-08-03 06:41:37.000000000 +0000
@@ -0,0 +1,160 @@
+/*
+ * PowerOP support for Intel Enhanced Speedstep "Centrino" platforms.
+ *
+ * Based heavily on speedstep-centrino.c of cpufreq Copyright (c) 2003
+ * by Jeremy Fitzhardinge <jeremy@goop.org>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/powerop.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+#include <linux/slab.h>
+
+#include <asm/msr.h>
+#include <asm/processor.h>
+#include <asm/cpufeature.h>
+
+static int
+powerop_centrino_get_point(struct powerop_point *point)
+{
+	unsigned l, h;
+	unsigned cpu_freq;
+
+	rdmsr(MSR_IA32_PERF_STATUS, l, h);
+	if (unlikely((cpu_freq = ((l >> 8) & 0xff) * 100) == 0)) {
+		/*
+		 * On some CPUs, we can see transient MSR values (which are
+		 * not present in _PSS), while CPU is doing some automatic
+		 * P-state transition (like TM2). Get the last freq set 
+		 * in PERF_CTL.
+		 */
+		rdmsr(MSR_IA32_PERF_CTL, l, h);
+		cpu_freq = ((l >> 8) & 0xff) * 100;
+	}
+
+	point->param[POWEROP_CPU + smp_processor_id()] = cpu_freq;
+	point->param[POWEROP_V + smp_processor_id()] = ((l & 0xff) * 16) + 700;
+	return 0;
+}
+
+static int
+powerop_centrino_set_point(struct powerop_point *point)
+{
+	unsigned int msr = 0, oldmsr, h, mask = 0;
+
+	if (point->param[POWEROP_CPU + smp_processor_id()] != -1) {
+		msr |= (point->param[POWEROP_CPU + smp_processor_id()]/100)
+			<< 8;
+		mask |= 0xff00;
+	}
+
+	if (point->param[POWEROP_V + smp_processor_id()] != -1) {
+		msr |= ((point->param[POWEROP_V + smp_processor_id()] - 700)
+			/ 16);
+		mask |= 0xff;
+	}
+
+	rdmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+
+	if (msr == (oldmsr & mask))
+		return 0;
+
+	/* all but 16 LSB are "reserved", so treat them with
+	   care */
+	oldmsr &= ~mask;
+	msr &= mask;
+	oldmsr |= msr;
+	
+	wrmsr(MSR_IA32_PERF_CTL, oldmsr, h);
+	return 0;
+}
+
+#ifdef CONFIG_POWEROP_SYSFS
+static char *powerop_param_names[POWEROP_DRIVER_MAX_PARAMS];
+
+static int __init powerop_centrino_sysfs_init(void)
+{
+	int i;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (! (powerop_param_names[POWEROP_CPU + i] = 
+		       kmalloc(5 + i / 10, GFP_KERNEL)) ||
+		    ! (powerop_param_names[POWEROP_V + i] = 
+		       kmalloc(3 + i / 10, GFP_KERNEL)))
+			goto nomem;
+
+		sprintf(powerop_param_names[POWEROP_CPU + i], "cpu%d", i);
+		sprintf(powerop_param_names[POWEROP_V + i], "v%d", i);
+	}
+
+	return 0;
+
+nomem:
+	printk(KERN_ERR "power-centrino malloc failed\n");
+
+	for (i = 0; i < NR_CPUS; i++) {
+		kfree(powerop_param_names[POWEROP_CPU + i]);
+		kfree(powerop_param_names[POWEROP_V + i]);
+	}
+
+	return -ENOMEM;
+}
+#else
+static int __init powerop_centrino_sysfs_init(void)
+{
+	return 0;
+}
+#endif
+
+static struct powerop_driver power_driver_centrino = {
+	.name		= "centrino",
+	.nr_params	= POWEROP_DRIVER_MAX_PARAMS,
+#ifdef CONFIG_POWEROP_SYSFS
+	.param_names    = powerop_param_names,
+#endif
+	.get_point	= powerop_centrino_get_point,
+	.set_point	= powerop_centrino_set_point,
+};
+
+static int __init powerop_centrino_init(void)
+{
+	struct cpuinfo_x86 *cpu = cpu_data;
+	unsigned l, h;
+
+	if (!cpu_has(cpu, X86_FEATURE_EST))
+		return -ENODEV;
+
+	/* Check to see if Enhanced SpeedStep is enabled, and try to
+	   enable it if not. */
+	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+		
+	if (!(l & (1<<16))) {
+		l |= (1<<16);
+		wrmsr(MSR_IA32_MISC_ENABLE, l, h);
+		
+		/* check to see if it stuck */
+		rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+		if (!(l & (1<<16))) {
+			printk(KERN_INFO "PowerOP: Couldn't enable Enhanced SpeedStep\n");
+			return -ENODEV;
+		}
+	}
+	
+	return powerop_centrino_sysfs_init() || 
+		powerop_driver_register(&power_driver_centrino);
+}
+
+static void __exit powerop_centrino_exit(void)
+{
+	powerop_driver_unregister(&power_driver_centrino);
+}
+
+module_init(powerop_centrino_init);
+module_exit(powerop_centrino_exit);
Index: linux-2.6.12/include/asm-i386/powerop-centrino.h
===================================================================
--- linux-2.6.12.orig/include/asm-i386/powerop-centrino.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12/include/asm-i386/powerop-centrino.h	2005-08-03 01:24:16.000000000 +0000
@@ -0,0 +1,20 @@
+/*
+ * PowerOP support for Intel Enhanced Speedstep "Centrino" platforms.
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __ASM_POWEROP_CENTRINO_H__
+#define __ASM_POWEROP_CENTRINO_H__
+
+#include <linux/threads.h>
+
+#define POWEROP_CPU		0	/* CPU freq in MHz*/
+#define POWEROP_V		NR_CPUS /* core voltage */
+
+#define POWEROP_DRIVER_MAX_PARAMS	2*NR_CPUS	/* max # params */
+
+#endif /* __ASM_POWEROP_CENTRINO_H__ */
Index: linux-2.6.12/include/asm-i386/powerop.h
===================================================================
--- linux-2.6.12.orig/include/asm-i386/powerop.h	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12/include/asm-i386/powerop.h	2005-08-03 01:23:03.000000000 +0000
@@ -0,0 +1,19 @@
+/*
+ * PowerOP support for i386 platforms.
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __ASM_POWEROP_H__
+#define __ASM_POWEROP_H__
+
+#include <linux/config.h>
+
+#ifdef CONFIG_POWEROP_CENTRINO
+#include <asm/powerop-centrino.h>
+#endif
+
+#endif /* __ASM_POWEROP_H__ */
