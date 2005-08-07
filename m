Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751048AbVHGFOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbVHGFOp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 01:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbVHGFOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 01:14:45 -0400
Received: from mail23.syd.optusnet.com.au ([211.29.133.164]:57269 "EHLO
	mail23.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751033AbVHGFOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 01:14:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Adrian Bunk <bunk@stusta.de>
Subject: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 5
Date: Sun, 7 Aug 2005 15:12:21 +1000
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, vatsa@in.ibm.com, ck@vds.kolivas.org,
       tony@atomide.com, tuukka.tikkanen@elektrobit.com, george@mvista.com,
       Andrew Morton <akpm@osdl.org>
References: <200508031559.24704.kernel@kolivas.org> <200508060239.41646.kernel@kolivas.org> <20050806174739.GU4029@stusta.de>
In-Reply-To: <20050806174739.GU4029@stusta.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2gZ9Ce4qndIJvvK"
Message-Id: <200508071512.22668.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_2gZ9Ce4qndIJvvK
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Respin of the dynamic ticks patch for i386 by Tony Lindgen and Tuukka Tikkanen 
with further code cleanups. Are were there yet?

Cheers,
Con
---



--Boundary-00=_2gZ9Ce4qndIJvvK
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="2.6.13-rc5-dtck-5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="2.6.13-rc5-dtck-5.patch"

This is the dynamic ticks patch for i386 as written by Tony Lindgen 
<tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>,
and modified by Con Kolivas <kernel@kolivas.org>.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 arch/i386/Kconfig                   |   35 ++++
 arch/i386/kernel/Makefile           |    1
 arch/i386/kernel/apic.c             |   19 ++
 arch/i386/kernel/dyn-tick.c         |  150 +++++++++++++++++++
 arch/i386/kernel/irq.c              |    3
 arch/i386/kernel/process.c          |    3
 arch/i386/kernel/time.c             |    8 -
 arch/i386/kernel/timers/timer_pit.c |   38 +++++
 arch/i386/kernel/timers/timer_pm.c  |    4
 arch/i386/kernel/timers/timer_tsc.c |   29 ++-
 arch/i386/mach-default/setup.c      |   16 ++
 include/asm-i386/dyn-tick.h         |   93 ++++++++++++
 include/linux/dyn-tick.h            |   75 +++++++++
 kernel/Makefile                     |    1
 kernel/dyn-tick.c                   |  273 ++++++++++++++++++++++++++++++++++++
 15 files changed, 736 insertions(+), 12 deletions(-)

Index: linux-2.6.13-rc5-ck2/arch/i386/Kconfig
===================================================================
--- linux-2.6.13-rc5-ck2.orig/arch/i386/Kconfig	2005-08-07 13:07:12.000000000 +1000
+++ linux-2.6.13-rc5-ck2/arch/i386/Kconfig	2005-08-07 13:07:45.000000000 +1000
@@ -457,6 +457,41 @@ config HPET_EMULATE_RTC
 	bool "Provide RTC interrupt"
 	depends on HPET_TIMER && RTC=y
 
+config NO_IDLE_HZ
+	bool "Dynamic Tick Timer - Skip timer ticks during idle"
+	depends on EXPERIMENTAL
+	help
+	  This option enables support for skipping timer ticks when the
+	  processor is idle. During system load, timer is continuous.
+	  This option saves power, as it allows the system to stay in
+	  idle mode longer. Currently supported timers are ACPI PM
+	  timer, local APIC timer, and TSC timer. HPET timer is currently
+	  not supported.
+
+	  Note that you can disable dynamic tick timer either by
+	  passing dyntick=disable command line option, or via sysfs:
+
+	  # echo 0 > /sys/devices/system/dyn_tick/dyn_tick0/enable
+
+config DYN_TICK_USE_APIC
+	bool "Use APIC timer instead of PIT timer"
+	depends on NO_IDLE_HZ
+	help
+	  This option enables using APIC timer interrupt if your hardware
+	  supports it. APIC timer allows longer sleep periods compared
+	  to PIT timer, however on MOST recent hardware disabling the PIT
+	  timer also disables APIC timer interrupts, and the system won't
+	  run properly. Symptoms include slow system boot, and time running 
+	  slow.
+
+	  If unsure, do NOT enable this option.
+
+	  Note that you can disable apic usage by dynamic tick timer
+	  either by passing dyntick=noapic command line option, or via 
+	  sysfs:
+
+	  # echo 0 > /sys/devices/system/dyn_tick/dyn_tick0/useapic
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
Index: linux-2.6.13-rc5-ck2/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/apic.c	2005-08-07 13:07:12.000000000 +1000
+++ linux-2.6.13-rc5-ck2/arch/i386/kernel/apic.c	2005-08-07 13:07:45.000000000 +1000
@@ -27,6 +27,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/atomic.h>
 #include <asm/smp.h>
@@ -931,6 +932,8 @@ void (*wait_timer_tick)(void) __devinitd
 
 #define APIC_DIVISOR 16
 
+u32 apic_timer_val;
+
 static void __setup_APIC_LVTT(unsigned int clocks)
 {
 	unsigned int lvtt_value, tmp_value, ver;
@@ -949,7 +952,12 @@ static void __setup_APIC_LVTT(unsigned i
 				& ~(APIC_TDR_DIV_1 | APIC_TDR_DIV_TMBASE))
 				| APIC_TDR_DIV_16);
 
-	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
+	apic_timer_val = clocks / APIC_DIVISOR;
+
+	if (apic_timer_val)
+		set_dyn_tick_max_skip(apic_timer_val);
+
+	apic_write_around(APIC_TMICT, apic_timer_val);
 }
 
 static void __devinit setup_APIC_timer(unsigned int clocks)
@@ -1062,6 +1070,8 @@ void __init setup_boot_APIC_clock(void)
 	 */
 	setup_APIC_timer(calibration_result);
 
+	setup_dyn_tick_use_apic(calibration_result);
+
 	local_irq_enable();
 }
 
@@ -1200,6 +1210,13 @@ fastcall void smp_apic_timer_interrupt(s
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
+
+	/*
+	 * Check if we need to wake up PIT interrupt handler.
+	 * Otherwise just wake up local APIC timer.
+	 */
+	wakeup_pit_or_apic(cpu, regs);
+
 	smp_local_timer_interrupt(regs);
 	irq_exit();
 }
Index: linux-2.6.13-rc5-ck2/arch/i386/kernel/dyn-tick.c
===================================================================
--- linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/dyn-tick.c	2005-01-12 16:19:45.000000000 +1100
+++ linux-2.6.13-rc5-ck2/arch/i386/kernel/dyn-tick.c	2005-08-07 14:41:00.000000000 +1000
@@ -0,0 +1,150 @@
+/*
+ * linux/arch/i386/kernel/dyn-tick.c
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
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
+#include <asm/apic.h>
+
+static void arch_reprogram_timer(void)
+{
+	if (cpu_has_local_apic()) {
+		disable_pit_timer();
+		if (dyn_tick->state & DYN_TICK_TIMER_INT)
+			reprogram_apic_timer(dyn_tick->skip);
+	} else {
+		if (dyn_tick->state & DYN_TICK_TIMER_INT)
+			reprogram_pit_timer(dyn_tick->skip);
+		else
+			disable_pit_timer();
+	}
+}
+
+static struct dyn_tick_timer arch_dyn_tick_timer = {
+	.arch_reprogram_timer	= &arch_reprogram_timer,
+};
+
+static int __init dyn_tick_init(void)
+{
+	arch_dyn_tick_timer.arch_init = dyn_tick_arch_init;
+	dyn_tick_register(&arch_dyn_tick_timer);
+
+	return 0;
+}
+
+arch_initcall(dyn_tick_init);
+
+static unsigned long long last_tick;
+
+/*
+ * This interrupt handler updates the time based on number of jiffies skipped
+ * It would be somewhat more optimized to have a custom handler in each timer
+ * using hardware ticks instead of nanoseconds. Note that CONFIG_NO_IDLE_HZ
+ * currently disables timer fallback on skipped jiffies.
+ */
+static irqreturn_t dyn_tick_timer_interrupt(int irq, void *dev_id,
+				     struct pt_regs *regs)
+{
+	unsigned long flags;
+	volatile unsigned long long now;
+	unsigned int skipped = 0;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	now = cur_timer->monotonic_clock();
+	while (now - last_tick >= NS_TICK_LEN) {
+		last_tick += NS_TICK_LEN;
+		cur_timer->mark_offset();
+		do_timer_interrupt(irq, NULL, regs);
+		skipped++;
+	}
+	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING)) {
+		dyn_tick->skip = 1;
+		if (cpu_has_local_apic())
+			reprogram_apic_timer(dyn_tick->skip);
+		reprogram_pit_timer(dyn_tick->skip);
+		dyn_tick->state |= DYN_TICK_ENABLED;
+		dyn_tick->state &= ~DYN_TICK_SKIPPING;
+	}
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+int __init dyn_tick_arch_init(void)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	last_tick = cur_timer->monotonic_clock();
+	dyn_tick->skip = 1;
+	if (!(dyn_tick->state & DYN_TICK_USE_APIC) || !cpu_has_local_apic())
+		dyn_tick->max_skip = 0xffff / LATCH;	/* PIT timer length */
+	printk(KERN_INFO "dyn-tick: Maximum ticks to skip limited to %i\n",
+	       dyn_tick->max_skip);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	dyn_tick->interrupt = dyn_tick_timer_interrupt;
+	replace_timer_interrupt(dyn_tick->interrupt);
+
+	return 0;
+}
+
+/* Functions that need blank prototypes for !CONFIG_NO_IDLE_HZ below here */
+void set_dyn_tick_max_skip(u32 apic_timer_val)
+{
+	dyn_tick->max_skip = 0xffffff / apic_timer_val;
+}
+
+void setup_dyn_tick_use_apic(unsigned int calibration_result)
+{
+	if (calibration_result)
+		dyn_tick->state |= DYN_TICK_USE_APIC;
+	else
+		printk(KERN_INFO "dyn-tick: Cannot use local APIC\n");
+}
+
+void wakeup_pit_or_apic(int cpu, struct pt_regs *regs)
+{
+	unsigned long seq; 
+
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING)) {
+			if (dyn_tick->skip_cpu == cpu &&
+				dyn_tick->skip > DYN_TICK_MIN_SKIP)
+					dyn_tick->interrupt(99, NULL, regs);
+				else
+					reprogram_apic_timer(1);
+		}
+	} while (read_seqretry(&xtime_lock, seq));
+}
+
+void dyn_tick_interrupt(int irq, struct pt_regs *regs)
+{
+	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING) && irq)
+		dyn_tick->interrupt(irq, NULL, regs);
+}
+
+void dyn_tick_time_init(struct timer_opts *cur_timer)
+{
+	if (strncmp(cur_timer->name, "tsc", 3) == 0 ||
+	    strncmp(cur_timer->name, "pmtmr", 3) == 0) {
+		dyn_tick->state |= DYN_TICK_SUITABLE;
+		printk(KERN_INFO "dyn-tick: Found suitable timer: %s\n",
+		       cur_timer->name);
+	} else
+		printk(KERN_ERR "dyn-tick: Cannot use timer %s\n",
+		       cur_timer->name);
+}
Index: linux-2.6.13-rc5-ck2/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/irq.c	2005-08-07 13:07:12.000000000 +1000
+++ linux-2.6.13-rc5-ck2/arch/i386/kernel/irq.c	2005-08-07 13:07:45.000000000 +1000
@@ -18,6 +18,7 @@
 #include <linux/notifier.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <linux/dyn-tick.h>
 
 DEFINE_PER_CPU(irq_cpustat_t, irq_stat) ____cacheline_maxaligned_in_smp;
 EXPORT_PER_CPU_SYMBOL(irq_stat);
@@ -76,6 +77,8 @@ fastcall unsigned int do_IRQ(struct pt_r
 	}
 #endif
 
+	dyn_tick_interrupt(irq, regs);
+
 #ifdef CONFIG_4KSTACKS
 
 	curctx = (union irq_ctx *) current_thread_info();
Index: linux-2.6.13-rc5-ck2/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/Makefile	2005-08-07 13:07:12.000000000 +1000
+++ linux-2.6.13-rc5-ck2/arch/i386/kernel/Makefile	2005-08-07 13:07:45.000000000 +1000
@@ -32,6 +32,7 @@ obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
+obj-$(CONFIG_NO_IDLE_HZ) 	+= dyn-tick.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
Index: linux-2.6.13-rc5-ck2/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/process.c	2005-08-07 13:07:12.000000000 +1000
+++ linux-2.6.13-rc5-ck2/arch/i386/kernel/process.c	2005-08-07 13:07:45.000000000 +1000
@@ -39,6 +39,7 @@
 #include <linux/ptrace.h>
 #include <linux/random.h>
 #include <linux/kprobes.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -200,6 +201,8 @@ void cpu_idle(void)
 			if (cpu_is_offline(cpu))
 				play_dead();
 
+			dyn_tick_reprogram_timer();
+
 			__get_cpu_var(irq_stat).idle_timestamp = jiffies;
 			idle();
 		}
Index: linux-2.6.13-rc5-ck2/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/time.c	2005-08-07 13:07:12.000000000 +1000
+++ linux-2.6.13-rc5-ck2/arch/i386/kernel/time.c	2005-08-07 13:07:45.000000000 +1000
@@ -46,6 +46,7 @@
 #include <linux/bcd.h>
 #include <linux/efi.h>
 #include <linux/mca.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -252,8 +253,7 @@ EXPORT_SYMBOL(profile_pc);
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static inline void do_timer_interrupt(int irq, void *dev_id,
-					struct pt_regs *regs)
+void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
@@ -423,7 +423,7 @@ static struct sysdev_class timer_sysclas
 
 
 /* XXX this driverfs stuff should probably go elsewhere later -john */
-static struct sys_device device_timer = {
+struct sys_device device_timer = {
 	.id	= 0,
 	.cls	= &timer_sysclass,
 };
@@ -479,5 +479,7 @@ void __init time_init(void)
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
+	dyn_tick_time_init(cur_timer);
+
 	time_init_hook();
 }
Index: linux-2.6.13-rc5-ck2/arch/i386/kernel/timers/timer_pit.c
===================================================================
--- linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/timers/timer_pit.c	2005-08-07 13:07:12.000000000 +1000
+++ linux-2.6.13-rc5-ck2/arch/i386/kernel/timers/timer_pit.c	2005-08-07 13:07:45.000000000 +1000
@@ -148,6 +148,44 @@ static unsigned long get_offset_pit(void
 	return count;
 }
 
+/*
+ * REVISIT: Looks like on P3 APIC timer keeps running if PIT mode
+ *	    is changed. On P4, changing PIT mode seems to kill
+ *	    APIC timer interrupts. Same thing with disabling PIT
+ *	    interrupt.
+ */
+void disable_pit_timer(void)
+{
+	extern spinlock_t i8253_lock;
+	unsigned long flags;
+
+	spin_lock_irqsave(&i8253_lock, flags);
+	outb_p(0x32, PIT_MODE);		/* binary, mode 1, LSB/MSB, ch 0 */
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
+
+/*
+ * Reprograms the next timer interrupt
+ * PIT timer reprogramming code taken from APM code.
+ * Note that PIT timer is a 16-bit timer, which allows max
+ * skip of only few seconds.
+ */
+void reprogram_pit_timer(int jiffies_to_skip)
+{
+	int skip;
+	extern spinlock_t i8253_lock;
+	unsigned long flags;
+
+	skip = jiffies_to_skip * LATCH;
+	if (skip > 0xffff)
+		skip = 0xffff;
+
+	spin_lock_irqsave(&i8253_lock, flags);
+	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
+	outb_p(skip & 0xff, PIT_CH0);	/* LSB */
+	outb(skip >> 8, PIT_CH0);	/* MSB */
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
 
 /* tsc timer_opts struct */
 struct timer_opts timer_pit = {
Index: linux-2.6.13-rc5-ck2/arch/i386/kernel/timers/timer_pm.c
===================================================================
--- linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/timers/timer_pm.c	2005-08-07 13:07:12.000000000 +1000
+++ linux-2.6.13-rc5-ck2/arch/i386/kernel/timers/timer_pm.c	2005-08-07 13:07:45.000000000 +1000
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/dyn-tick.h>
 #include <asm/types.h>
 #include <asm/timer.h>
 #include <asm/smp.h>
@@ -168,6 +169,9 @@ static void mark_offset_pmtmr(void)
 	monotonic_base += delta * NSEC_PER_USEC;
 	write_sequnlock(&monotonic_lock);
 
+	if (dyn_tick_enabled())
+		return;
+
 	/* convert to ticks */
 	delta += offset_delay;
 	lost = delta / (USEC_PER_SEC / HZ);
Index: linux-2.6.13-rc5-ck2/arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- linux-2.6.13-rc5-ck2.orig/arch/i386/kernel/timers/timer_tsc.c	2005-08-07 13:07:12.000000000 +1000
+++ linux-2.6.13-rc5-ck2/arch/i386/kernel/timers/timer_tsc.c	2005-08-07 13:07:45.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/cpufreq.h>
 #include <linux/string.h>
 #include <linux/jiffies.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/timer.h>
 #include <asm/io.h>
@@ -166,10 +167,19 @@ static void delay_tsc(unsigned long loop
 	} while ((now-bclock) < loops);
 }
 
+/* update the monotonic base value */
+static inline void update_monotonic_base(unsigned long long last_offset)
+{
+	unsigned long long this_offset;
+
+	this_offset = ((unsigned long long)last_tsc_high << 32) | last_tsc_low;
+	monotonic_base += cycles_2_ns(this_offset - last_offset);
+}
+
 #ifdef CONFIG_HPET_TIMER
 static void mark_offset_tsc_hpet(void)
 {
-	unsigned long long this_offset, last_offset;
+	unsigned long long last_offset;
  	unsigned long offset, temp, hpet_current;
 
 	write_seqlock(&monotonic_lock);
@@ -197,9 +207,7 @@ static void mark_offset_tsc_hpet(void)
 	}
 	hpet_last = hpet_current;
 
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
+	update_monotonic_base(last_offset);
 	write_sequnlock(&monotonic_lock);
 
 	/* calculate delay_at_last_interrupt */
@@ -346,7 +354,7 @@ static void mark_offset_tsc(void)
 	int count;
 	int countmp;
 	static int count1 = 0;
-	unsigned long long this_offset, last_offset;
+	unsigned long long last_offset;
 	static int lost_count = 0;
 
 	write_seqlock(&monotonic_lock);
@@ -367,6 +375,12 @@ static void mark_offset_tsc(void)
 
 	rdtsc(last_tsc_low, last_tsc_high);
 
+	if (dyn_tick_enabled()) {
+		update_monotonic_base(last_offset);
+		write_sequnlock(&monotonic_lock);
+		return;
+	}
+
 	spin_lock(&i8253_lock);
 	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
 
@@ -434,9 +448,8 @@ static void mark_offset_tsc(void)
 			cpufreq_delayed_get();
 	} else
 		lost_count = 0;
-	/* update the monotonic base value */
-	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
-	monotonic_base += cycles_2_ns(this_offset - last_offset);
+
+	update_monotonic_base(last_offset);
 	write_sequnlock(&monotonic_lock);
 
 	/* calculate delay_at_last_interrupt */
Index: linux-2.6.13-rc5-ck2/arch/i386/mach-default/setup.c
===================================================================
--- linux-2.6.13-rc5-ck2.orig/arch/i386/mach-default/setup.c	2005-08-07 13:07:12.000000000 +1000
+++ linux-2.6.13-rc5-ck2/arch/i386/mach-default/setup.c	2005-08-07 13:07:45.000000000 +1000
@@ -93,6 +93,22 @@ void __init time_init_hook(void)
 	setup_irq(0, &irq0);
 }
 
+/**
+ * replace_timer_interrupt - allow replacing timer interrupt handler
+ *
+ * Description:
+ *	Can be used to replace timer interrupt handler with a more optimized
+ *	handler. Used for enabling and disabling of CONFIG_NO_IDLE_HZ.
+ */
+void replace_timer_interrupt(void *new_handler)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	irq0.handler = new_handler;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+}
+
 #ifdef CONFIG_MCA
 /**
  * mca_nmi_hook - hook into MCA specific NMI chain
Index: linux-2.6.13-rc5-ck2/include/asm-i386/dyn-tick.h
===================================================================
--- linux-2.6.13-rc5-ck2.orig/include/asm-i386/dyn-tick.h	2005-01-12 16:19:45.000000000 +1100
+++ linux-2.6.13-rc5-ck2/include/asm-i386/dyn-tick.h	2005-08-07 14:47:00.000000000 +1000
@@ -0,0 +1,93 @@
+/*
+ * linux/include/asm-i386/dyn-tick.h
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _ASM_I386_DYN_TICK_H_
+#define _ASM_I386_DYN_TICK_H_
+
+#include <asm/apic.h>
+
+#ifdef CONFIG_NO_IDLE_HZ
+extern int dyn_tick_arch_init(void);
+extern void disable_pit_timer(void);
+extern void reprogram_pit_timer(int jiffies_to_skip);
+extern void replace_timer_interrupt(void *new_handler);
+extern void set_dyn_tick_max_skip(u32 apic_timer_val);
+extern void setup_dyn_tick_use_apic(unsigned int calibration_result);
+extern void wakeup_pit_or_apic(int cpu, struct pt_regs *regs);
+extern void dyn_tick_interrupt(int irq, struct pt_regs *regs);
+extern void dyn_tick_time_init(struct timer_opts *cur_timer);
+extern void do_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+extern u32 apic_timer_val;
+
+#if defined(CONFIG_DYN_TICK_USE_APIC)
+#define DYNTICK_APICABLE	1
+
+#if (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC))
+static inline int cpu_has_local_apic(void)
+{
+	return (dyn_tick->state & DYN_TICK_USE_APIC);
+}
+
+#else	/* (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC)) */
+static inline int cpu_has_local_apic(void)
+{
+	return 0;
+}
+#endif	/* (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC)) */
+
+#else	/*  defined(CONFIG_DYN_TICK_USE_APIC) */
+#define DYNTICK_APICABLE	0
+static inline int cpu_has_local_apic(void)
+{
+	return 0;
+}
+#endif	/*  defined(CONFIG_DYN_TICK_USE_APIC) */
+
+static inline void reprogram_apic_timer(unsigned int count)
+{
+#ifdef CONFIG_X86_LOCAL_APIC
+	unsigned long flags;
+
+	count *= apic_timer_val;
+	local_irq_save(flags);
+	apic_write_around(APIC_TMICT, count);
+	local_irq_restore(flags);
+#endif	/* CONFIG_X86_LOCAL_APIC */
+}
+
+#else /* CONFIG_NO_IDLE_HZ */
+static inline void set_dyn_tick_max_skip(u32 apic_timer_val)
+{
+}
+
+static inline void reprogram_apic_timer(unsigned int count)
+{
+}
+
+static inline void setup_dyn_tick_use_apic(unsigned int calibration_result)
+{
+}
+
+static inline void wakeup_pit_or_apic(int cpu, struct pt_regs *regs)
+{
+}
+
+static inline void dyn_tick_interrupt(int irq, struct pt_regs *regs)
+{
+}
+
+static inline void dyn_tick_time_init(struct timer_opts *cur_timer)
+{
+}
+#endif /* CONFIG_NO_IDLE_HZ */
+
+#endif /* _ASM_I386_DYN_TICK_H_ */
Index: linux-2.6.13-rc5-ck2/include/linux/dyn-tick.h
===================================================================
--- linux-2.6.13-rc5-ck2.orig/include/linux/dyn-tick.h	2005-01-12 16:19:45.000000000 +1100
+++ linux-2.6.13-rc5-ck2/include/linux/dyn-tick.h	2005-08-07 14:55:46.000000000 +1000
@@ -0,0 +1,75 @@
+/*
+ * linux/include/linux/dyn-tick.h
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
+ * Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _DYN_TICK_TIMER_H
+#define _DYN_TICK_TIMER_H
+
+#include <linux/interrupt.h>
+#include <asm/timer.h>
+
+#define DYN_TICK_APICABLE	(1 << 5)
+#define DYN_TICK_TIMER_INT	(1 << 4)
+#define DYN_TICK_USE_APIC	(1 << 3)
+#define DYN_TICK_SKIPPING	(1 << 2)
+#define DYN_TICK_ENABLED	(1 << 1)
+#define DYN_TICK_SUITABLE	(1 << 0)
+
+#define NS_TICK_LEN		((1 * 1000000000) / HZ)
+#define DYN_TICK_MIN_SKIP	2
+
+struct dyn_tick_state {
+	unsigned int state;		/* Current state */
+	int skip_cpu;			/* Skip handling processor */
+	unsigned long skip;		/* Ticks to skip */
+	unsigned int max_skip;		/* Max number of ticks to skip */
+	unsigned long irq_skip_mask;	/* Do not update time from these irqs */
+	irqreturn_t (*interrupt)(int, void *, struct pt_regs *);
+};
+
+struct dyn_tick_timer {
+	int (*arch_init) (void);
+	void (*arch_enable) (void);
+	void (*arch_disable) (void);
+	void (*arch_reprogram_timer) (void);
+};
+
+extern struct dyn_tick_state *dyn_tick;
+extern void dyn_tick_register(struct dyn_tick_timer *new_timer);
+
+#ifdef CONFIG_NO_IDLE_HZ
+extern unsigned long dyn_tick_reprogram_timer(void);
+
+static inline int dyn_tick_enabled(void)
+{
+	return (dyn_tick->state & DYN_TICK_ENABLED);
+}
+
+#else	/* CONFIG_NO_IDLE_HZ */
+static inline int arch_has_safe_halt(void)
+{
+	return 0;
+}
+
+static inline void dyn_tick_reprogram_timer(void)
+{
+}
+
+static inline int dyn_tick_enabled(void)
+{
+	return 0;
+}
+#endif	/* CONFIG_NO_IDLE_HZ */
+
+/* Pick up arch specific header */
+#include <asm/dyn-tick.h>
+
+#endif	/* _DYN_TICK_TIMER_H */
Index: linux-2.6.13-rc5-ck2/kernel/dyn-tick.c
===================================================================
--- linux-2.6.13-rc5-ck2.orig/kernel/dyn-tick.c	2005-01-12 16:19:45.000000000 +1100
+++ linux-2.6.13-rc5-ck2/kernel/dyn-tick.c	2005-08-07 14:48:37.000000000 +1000
@@ -0,0 +1,273 @@
+/*
+ * linux/kernel/dyn-tick.c
+ *
+ * Beginnings of generic dynamic tick timer support
+ *
+ * Copyright (C) 2004 Nokia Corporation
+ * Written by Tony Lindgen <tony@atomide.com> and
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
+#include <linux/sysdev.h>
+#include <linux/interrupt.h>
+#include <linux/cpumask.h>
+#include <linux/pm.h>
+#include <linux/dyn-tick.h>
+#include <asm/io.h>
+
+#include "io_ports.h"
+
+#define DYN_TICK_VERSION	"050610-1"
+#define DYN_TICK_IS_SET(x)	((dyn_tick->state & (x)) == (x))
+
+static struct dyn_tick_state dyn_tick_state;
+struct dyn_tick_state *dyn_tick = &dyn_tick_state;
+static struct dyn_tick_timer *dyn_tick_cfg;
+static cpumask_t dyn_cpu_map;
+
+/*
+ * Arch independent code needed to reprogram next timer interrupt.
+ * Gets called from cpu_idle() before entering idle loop. Note that
+ * we want to have all processors idle before reprogramming the
+ * next timer interrupt.
+ */
+unsigned long dyn_tick_reprogram_timer(void)
+{
+	int cpu;
+	unsigned long flags;
+	cpumask_t idle_cpus;
+	unsigned long next;
+
+	if (!DYN_TICK_IS_SET(DYN_TICK_ENABLED))
+		return 0;
+
+	/* Check if we are already skipping ticks and can idle other cpus */
+	if (DYN_TICK_IS_SET(DYN_TICK_SKIPPING)) {
+		if (cpu_has_local_apic())
+			reprogram_apic_timer(dyn_tick->skip);
+		return 0;
+	}
+
+	/* Check if we can start skipping ticks */
+	write_seqlock_irqsave(&xtime_lock, flags);
+	cpu = smp_processor_id();
+	cpu_set(cpu, dyn_cpu_map);
+	cpus_and(idle_cpus, dyn_cpu_map, cpu_online_map);
+	if (cpus_equal(idle_cpus, cpu_online_map)) {
+		next = next_timer_interrupt();
+		if (jiffies > next)
+			dyn_tick->skip = 1;
+		else
+			dyn_tick->skip = next_timer_interrupt() - jiffies;
+		if (dyn_tick->skip > DYN_TICK_MIN_SKIP) {
+			if (dyn_tick->skip > dyn_tick->max_skip)
+				dyn_tick->skip = dyn_tick->max_skip;
+
+			dyn_tick_cfg->arch_reprogram_timer();
+
+			dyn_tick->skip_cpu = cpu;
+			dyn_tick->state |= DYN_TICK_SKIPPING;
+		}
+		cpus_clear(dyn_cpu_map);
+	}
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return dyn_tick->skip;
+}
+
+void __init dyn_tick_register(struct dyn_tick_timer *arch_timer)
+{
+	dyn_tick_cfg = arch_timer;
+	printk(KERN_INFO "dyn-tick: Registering dynamic tick timer v%s\n",
+	       DYN_TICK_VERSION);
+}
+
+/*
+ * ---------------------------------------------------------------------------
+ * Command line options
+ * ---------------------------------------------------------------------------
+ */
+static int __initdata dyntick_autoenable = 1;
+static int __initdata dyntick_useapic = 1;
+
+/*
+ * dyntick=[disable],[noapic]
+ */ 
+static int __init dyntick_setup(char *options)
+{
+	if (!options)
+		return 0;
+
+	if (!strncmp(options, "disable", 6))
+		dyntick_autoenable = 0;
+
+	if (strstr(options, "noapic"))
+		dyntick_useapic = 0;
+
+	return 0;
+}
+
+__setup("dyntick=", dyntick_setup);
+
+/*
+ * ---------------------------------------------------------------------------
+ * Sysfs interface
+ * ---------------------------------------------------------------------------
+ */
+
+extern struct sys_device device_timer;
+
+static ssize_t show_dyn_tick_state(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf,
+		       "suitable:\t%i\n"
+		       "enabled:\t%i\n"
+		       "apic suitable:\t%i\n"
+		       "using APIC:\t%i\n",
+		       DYN_TICK_IS_SET(DYN_TICK_SUITABLE),
+		       DYN_TICK_IS_SET(DYN_TICK_ENABLED),
+		       DYN_TICK_IS_SET(DYN_TICK_APICABLE),
+		       DYN_TICK_IS_SET(DYN_TICK_USE_APIC));
+}
+
+static ssize_t show_dyn_tick_enable(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "enabled:\t%i\n",
+		DYN_TICK_IS_SET(DYN_TICK_ENABLED));
+}
+
+static ssize_t set_dyn_tick_enable(struct sys_device *dev, const char *buf,
+				size_t count)
+{
+	unsigned long flags;
+	unsigned int enable = simple_strtoul(buf, NULL, 2);
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	if (enable) {
+		if (dyn_tick_cfg->arch_enable)
+			dyn_tick_cfg->arch_enable();
+		dyn_tick->state |= DYN_TICK_ENABLED;
+	} else {
+		if (dyn_tick_cfg->arch_disable)
+			dyn_tick_cfg->arch_disable();
+		dyn_tick->state &= ~DYN_TICK_ENABLED;
+	}
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return count;
+}
+
+static ssize_t show_dyn_tick_useapic(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf, "using APIC:\t%i\n",
+		       DYN_TICK_IS_SET(DYN_TICK_USE_APIC));
+}
+
+static ssize_t set_dyn_tick_useapic(struct sys_device *dev, const char *buf,
+				    size_t count)
+{
+	unsigned long flags;
+	unsigned int enable = simple_strtoul(buf, NULL, 2);
+
+	if (!DYN_TICK_IS_SET(DYN_TICK_APICABLE))
+		goto out;
+	write_seqlock_irqsave(&xtime_lock, flags);
+	if (enable)
+		dyn_tick->state |= DYN_TICK_USE_APIC;
+	else
+		dyn_tick->state &= ~DYN_TICK_USE_APIC;
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+out:
+	return count;
+}
+
+static SYSDEV_ATTR(state, 0444, show_dyn_tick_state, NULL);
+static SYSDEV_ATTR(enable, 0644, show_dyn_tick_enable,
+		   set_dyn_tick_enable);
+static SYSDEV_ATTR(useapic, 0644, show_dyn_tick_useapic,
+		   set_dyn_tick_useapic);
+
+static struct sysdev_class dyn_tick_sysclass = {
+	set_kset_name("dyn_tick"),
+};
+
+static struct sys_device device_dyn_tick = {
+	.id = 0,
+	.cls = &dyn_tick_sysclass,
+};
+
+static int init_dyn_tick_sysfs(void)
+{
+	int error = 0;
+	if ((error = sysdev_class_register(&dyn_tick_sysclass)))
+		goto out;
+	if ((error = sysdev_register(&device_dyn_tick)))
+		goto out;
+	if ((error = sysdev_create_file(&device_dyn_tick, &attr_state)))
+		goto out;
+	if ((error = sysdev_create_file(&device_dyn_tick, &attr_enable)))
+		goto out;
+	error = sysdev_create_file(&device_dyn_tick, &attr_useapic);
+
+out:
+	return error;
+}
+
+device_initcall(init_dyn_tick_sysfs);
+
+/*
+ * ---------------------------------------------------------------------------
+ * Init functions
+ * ---------------------------------------------------------------------------
+ */
+
+static int __init dyn_tick_early_init(void)
+{
+	dyn_tick->state |= DYN_TICK_TIMER_INT;
+	return 0;
+}
+
+subsys_initcall(dyn_tick_early_init);
+
+/*
+ * We need to initialize dynamic tick after calibrate delay
+ */
+static int __init dyn_tick_late_init(void)
+{
+	int ret = 0;
+
+	if (dyn_tick_cfg == NULL || dyn_tick_cfg->arch_init == NULL ||
+	    !DYN_TICK_IS_SET(DYN_TICK_SUITABLE)) {
+		printk(KERN_ERR "dyn-tick: No suitable timer found\n");
+		return -ENODEV;
+	}
+
+	if (DYNTICK_APICABLE)
+		dyn_tick->state |= DYN_TICK_APICABLE;
+	if (!dyntick_useapic || !DYN_TICK_IS_SET(DYN_TICK_APICABLE))
+		dyn_tick->state &= ~DYN_TICK_USE_APIC;
+
+	if ((ret = dyn_tick_cfg->arch_init())) {
+		printk(KERN_ERR "dyn-tick: Init failed\n");
+		return -ENODEV;
+	}
+
+	if (!ret && dyntick_autoenable) {
+		dyn_tick->state |= DYN_TICK_ENABLED;
+		printk(KERN_INFO "dyn-tick: Timer using dynamic tick\n");
+	} else
+		printk(KERN_INFO "dyn-tick: Timer not enabled during boot\n");
+
+	return ret;
+}
+
+late_initcall(dyn_tick_late_init);
Index: linux-2.6.13-rc5-ck2/kernel/Makefile
===================================================================
--- linux-2.6.13-rc5-ck2.orig/kernel/Makefile	2005-08-07 13:07:12.000000000 +1000
+++ linux-2.6.13-rc5-ck2/kernel/Makefile	2005-08-07 13:07:45.000000000 +1000
@@ -30,6 +30,7 @@ obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
+obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is

--Boundary-00=_2gZ9Ce4qndIJvvK--
