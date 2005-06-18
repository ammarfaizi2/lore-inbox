Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbVFREI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbVFREI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 00:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVFREI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 00:08:27 -0400
Received: from [220.248.27.114] ([220.248.27.114]:2265 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S261351AbVFREHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 00:07:16 -0400
Date: Sat, 18 Jun 2005 11:34:19 +0800
From: hugang@soulinfo.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Jonathan Corbet <corbet@lwn.net>, Pavel Machek <pavel@ucw.cz>,
       Bernard Blackham <b-lkml@blackham.com.au>,
       Christian Hesse <mail@earthworm.de>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, benh@kernel.crashing.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050610-1
Message-ID: <20050618033419.GA6476@hugang.soulinfo.com>
References: <20050602013641.GL21597@atomide.com> <200506021030.50585.mail@earthworm.de> <20050602174219.GC21363@atomide.com> <20050603223758.GA2227@elf.ucw.cz> <20050610041706.GC18103@atomide.com> <20050610091515.GH4173@elf.ucw.cz> <20050610151707.GB7858@atomide.com> <20050610221501.GB7575@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050610221501.GB7575@atomide.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2005 at 03:15:01PM -0700, Tony Lindgren wrote:
> Hi all,
> 
> Here's yet another version with more clean-up:
> 
> - Got rid of ifdefs for skipping timer calibration; Skipping is
>   now done based on dyn_tick_enaled() instead.
> 
> - Clean-up fixes as suggested by Pavel Machek.
> 
> Cheers,
> 
> Tony

I'm try to port it powerpc, Here is a patch.

 Port Dynamic Tick Timer to new platform is easy. :)
  1) Find the reprogram timer interface.
  2) do a hook in the idle function.

That worked on my PowerBookG4 12'.

 arch/ppc/Kconfig           |   15 ++++++++
 arch/ppc/kernel/Makefile   |    1 
 arch/ppc/kernel/dyn-tick.c |   43 ++++++++++++++++++++++++
 arch/ppc/kernel/idle.c     |    4 +-
 arch/ppc/kernel/time.c     |   80 ++++++++++++++++++++++++++++++++++++++++++---
 include/asm-ppc/dyn-tick.h |   22 ++++++++++++
 kernel/Makefile            |    1 
 kernel/dyn-tick.c          |   39 ++++++++++++++++-----
 8 files changed, 190 insertions(+), 15 deletions(-)

Index: 2.6.11.9/arch/ppc/Kconfig
===================================================================
--- 2.6.11.9.orig/arch/ppc/Kconfig
+++ 2.6.11.9/arch/ppc/Kconfig
@@ -230,6 +230,21 @@ config PPC601_SYNC_FIX
 source arch/ppc/platforms/4xx/Kconfig
 source arch/ppc/platforms/85xx/Kconfig
 
+config NO_IDLE_HZ
+	bool "Dynamic Tick Timer - Skip timer ticks during idle"
+	help
+	  This option enables support for skipping timer ticks when the
+	  processor is idle. During system load, timer is continuous.
+	  This option saves power, as it allows the system to stay in
+	  idle mode longer. Currently supported timers are ACPI PM
+	  timer, local APIC timer, and TSC timer. HPET timer is currently
+	  not supported.
+
+	  Note that you need to enable dynamic tick timer either by
+	  passing dyntick=enable command line option, or via sysfs:
+
+	  # echo 1 > /sys/devices/system/timer/timer0/dyn_tick_state
+
 config PPC64BRIDGE
 	bool
 	depends on POWER3 || POWER4
Index: 2.6.11.9/arch/ppc/kernel/Makefile
===================================================================
--- 2.6.11.9.orig/arch/ppc/kernel/Makefile
+++ 2.6.11.9/arch/ppc/kernel/Makefile
@@ -30,3 +30,4 @@ ifndef CONFIG_MATH_EMULATION
 obj-$(CONFIG_8xx)		+= softemu8xx.o
 endif
 
+obj-$(CONFIG_NO_IDLE_HZ)    += dyn-tick.o
Index: 2.6.11.9/arch/ppc/kernel/dyn-tick.c
===================================================================
--- /dev/null
+++ 2.6.11.9/arch/ppc/kernel/dyn-tick.c
@@ -0,0 +1,43 @@
+/*
+ * linux/arch/ppc/kernel/dyn-tick.c
+ *
+ * Copyright (C) 2005 Beijing Soul
+ * Written by Hu Gang <hugang@soulinfo.com> and 
+ * Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/version.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/dyn-tick.h>
+
+void arch_reprogram_timer(void)
+{
+	if (dyn_tick->state & DYN_TICK_TIMER_INT)
+		reprogram_tb_timer(dyn_tick->skip);
+	else
+		disable_tb_timer();
+}
+
+static struct dyn_tick_timer arch_dyn_tick_timer = {
+	.arch_reprogram_timer   = &arch_reprogram_timer,
+};
+
+int __init dyn_tick_init(void)
+{
+	arch_dyn_tick_timer.arch_init = dyn_tick_arch_init;
+	dyn_tick_register(&arch_dyn_tick_timer);
+
+//	dyn_tick->state |= DYN_TICK_DEBUG;
+	dyn_tick->state |= DYN_TICK_SUITABLE;
+
+	return 0;
+}
+arch_initcall(dyn_tick_init);
Index: 2.6.11.9/arch/ppc/kernel/idle.c
===================================================================
--- 2.6.11.9.orig/arch/ppc/kernel/idle.c
+++ 2.6.11.9/arch/ppc/kernel/idle.c
@@ -22,6 +22,7 @@
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/sysctl.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -39,6 +40,7 @@ void default_idle(void)
 	powersave = ppc_md.power_save;
 
 	if (!need_resched()) {
+		dyn_tick_reprogram_timer();
 		if (powersave != NULL)
 			powersave();
 #ifdef CONFIG_SMP
@@ -59,7 +61,7 @@ void default_idle(void)
  */
 void cpu_idle(void)
 {
-	for (;;)
+	for (;;) 
 		if (ppc_md.idle != NULL)
 			ppc_md.idle();
 		else
Index: 2.6.11.9/arch/ppc/kernel/time.c
===================================================================
--- 2.6.11.9.orig/arch/ppc/kernel/time.c
+++ 2.6.11.9/arch/ppc/kernel/time.c
@@ -57,6 +57,7 @@
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/profile.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/segment.h>
 #include <asm/io.h>
@@ -126,15 +127,11 @@ EXPORT_SYMBOL(profile_pc);
  * with interrupts disabled.
  * We set it up to overflow again in 1/HZ seconds.
  */
-void timer_interrupt(struct pt_regs * regs)
+static void do_timer_interrupt(struct pt_regs * regs)
 {
 	int next_dec;
 	unsigned long cpu = smp_processor_id();
 	unsigned jiffy_stamp = last_jiffy_stamp(cpu);
-	extern void do_IRQ(struct pt_regs *);
-
-	if (atomic_read(&ppc_n_lost_interrupts) != 0)
-		do_IRQ(regs);
 
 	irq_enter();
 
@@ -190,6 +187,23 @@ void timer_interrupt(struct pt_regs * re
 	irq_exit();
 }
 
+static void (*timer_interrupt_func)(struct pt_regs * regs) = NULL;
+
+void timer_interrupt(struct pt_regs * regs)
+{
+	extern void do_IRQ(struct pt_regs *);
+
+	if (atomic_read(&ppc_n_lost_interrupts) != 0)
+		do_IRQ(regs);
+	
+	if (timer_interrupt_func) {
+		timer_interrupt_func(regs);
+		return;
+	}
+	
+	do_timer_interrupt(regs);
+}
+
 /*
  * This version of gettimeofday has microsecond resolution.
  */
@@ -281,7 +295,63 @@ int do_settimeofday(struct timespec *tv)
 }
 
 EXPORT_SYMBOL(do_settimeofday);
+#ifdef CONFIG_NO_IDLE_HZ
+void reprogram_tb_timer(int jiffies_to_skip)
+{
+	set_dec(tb_ticks_per_jiffy * jiffies_to_skip/* + get_dec()*/);
+}
+void disable_tb_timer(void)
+{
+	printk("FIXME: disable_tb_timer\n");
+}
+
+static inline void tb_get_tick(unsigned long long *val)
+{
+	*val = (get_tbl() | ((unsigned long long)get_tbu()<<32));
+}
+
+static unsigned long long last_tick;
+
+static void dyn_tick_timer_interrupt(struct pt_regs *regs)
+{
+	unsigned long long now;
+	int skipped = 0;
+
+	tb_get_tick(&now);
 
+	while (now - last_tick >= NS_TICK_LEN) {
+		last_tick += NS_TICK_LEN;
+		skipped ++;
+	}
+	if (skipped && (dyn_tick->state & DYN_TICK_DEBUG)) {
+		printk("p %d\n", skipped);
+	}
+
+	do_timer_interrupt(regs);
+
+	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING)) {
+		dyn_tick->state |= DYN_TICK_ENABLED;
+		dyn_tick->state &= ~DYN_TICK_SKIPPING;
+	}
+}
+
+int __init dyn_tick_arch_init(void)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	tb_get_tick(&last_tick);
+	dyn_tick->skip = 1;
+	dyn_tick->max_skip = 0xffff;
+	printk(KERN_INFO "dyn-tick: Maximum ticks to skip limited to %i, %llx\n",
+			dyn_tick->max_skip, last_tick);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	timer_interrupt_func = dyn_tick_timer_interrupt;
+	
+	return 0;
+}
+#endif
 /* This function is only called on the boot processor */
 void __init time_init(void)
 {
Index: 2.6.11.9/include/asm-ppc/dyn-tick.h
===================================================================
--- /dev/null
+++ 2.6.11.9/include/asm-ppc/dyn-tick.h
@@ -0,0 +1,22 @@
+/*
+ * linux/include/asm-ppc/dyn-tick.h
+ *
+ * Copyright (C) 2005 Beijing Soul 
+ * Written by Hu Gang <hugang@soulinfo.com> and 
+ * Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+#ifndef _ASM_PPC_DYN_TICK_H_
+#define _ASM_PPC_DYN_TICK_H_
+
+#define cpu_has_local_apic()	0
+#define reprogram_apic_timer(x)	do {} while (0)
+
+extern int dyn_tick_arch_init(void);
+
+#endif
Index: 2.6.11.9/kernel/Makefile
===================================================================
--- 2.6.11.9.orig/kernel/Makefile
+++ 2.6.11.9/kernel/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_AUDITSYSCALL) += auditsc.o
 obj-$(CONFIG_KPROBES) += kprobes.o
 obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
+obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: 2.6.11.9/kernel/dyn-tick.c
===================================================================
--- 2.6.11.9.orig/kernel/dyn-tick.c
+++ 2.6.11.9/kernel/dyn-tick.c
@@ -24,7 +24,9 @@
 #include <linux/dyn-tick.h>
 #include <asm/io.h>
 
+#ifdef CONFIG_X86
 #include "io_ports.h"
+#endif
 
 #define DYN_TICK_VERSION	"050610-1"
 
@@ -47,9 +49,9 @@ unsigned long dyn_tick_reprogram_timer(v
 	unsigned long next;
 
 	if (dyn_tick->state & DYN_TICK_DEBUG)
-		printk("i");
-	
-	if (!(dyn_tick->state & DYN_TICK_ENABLED))
+		printk("i, %d\n", dyn_tick->skip);
+
+	if (!(dyn_tick->state & DYN_TICK_ENABLED)) 
 		return 0;
 
 	/* Check if we are already skipping ticks and can idle other cpus */
@@ -67,8 +69,9 @@ unsigned long dyn_tick_reprogram_timer(v
 	if (cpus_equal(idle_cpus, cpu_online_map)) {
 		next = next_timer_interrupt();
 		if (jiffies > next) {
-			//printk("Too late? next: %lu jiffies: %lu\n",
-			//       next, jjiffies);
+			if (dyn_tick->state & DYN_TICK_DEBUG)
+				printk("Too late? next: %lu jiffies: %lu\n",
+					next, jiffies);
 			dyn_tick->skip = 1;
 		} else
 			dyn_tick->skip = next_timer_interrupt() - jiffies;
@@ -121,15 +124,31 @@ static int __init dyntick_setup(char *op
 }
 
 __setup("dyntick=", dyntick_setup);
-
+#ifndef CONFIG_X86
 /*
  * ---------------------------------------------------------------------------
  * Sysfs interface
  * ---------------------------------------------------------------------------
  */
-
+static struct sysdev_class timer_sysclass = {
+	set_kset_name("timer"),
+};
+
+struct sys_device device_timer = {
+	.id = 0,
+	.cls = &timer_sysclass,
+};
+
+static int time_init_device(void)
+{
+	int error = sysdev_class_register(&timer_sysclass);
+	if (!error)
+		error = sysdev_register(&device_timer);
+	return error;
+}
+#else
 extern struct sys_device device_timer;
-
+#endif
 #define DYN_TICK_IS_SET(x)	((dyn_tick->state & (x)) == (x))
 
 static ssize_t show_dyn_tick_state(struct sys_device *dev, char *buf)
@@ -239,7 +258,9 @@ static SYSDEV_ATTR(dyn_tick_dbg, 0644, s
 static int __init dyn_tick_late_init(void)
 {
 	int ret = 0;
-
+#ifndef CONFIG_X86
+	time_init_device();
+#endif
 	if (dyn_tick_cfg == NULL || dyn_tick_cfg->arch_init == NULL ||
 	    !(dyn_tick->state & DYN_TICK_SUITABLE)) {
 		printk(KERN_ERR "dyn-tick: No suitable timer found\n");

-- 
Hu Gang       .-.
              /v\
             // \\ 
Linux User  /(   )\  [204016]
GPG Key ID   ^^-^^   http://soulinfo.com/~hugang/hugang.asc
