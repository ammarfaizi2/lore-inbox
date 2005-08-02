Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261154AbVHBElq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbVHBElq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 00:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVHBElq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 00:41:46 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:4588 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261154AbVHBElo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 00:41:44 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: [patch] i386 dynamic ticks 2.6.13-rc4 (code reordered)
Date: Tue, 2 Aug 2005 14:43:55 +1000
User-Agent: KMail/1.8.1
Cc: tony@atomide.com, tuukka.tikkanen@elektrobit.com, ck@vds.kolivas.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Lov7CiRCsQqP7z8"
Message-Id: <200508021443.55429.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_Lov7CiRCsQqP7z8
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This is a code reordered version of the dynamic ticks patch from Tony Lindgen 
and Tuukka Tikkanen - sorry about spamming your mail boxes with this, but 
thanks for the code. There is significant renewed interest by the lkml 
audience for such a feature which is why I'm butchering your code (sorry 
again if you don't like me doing this). The only real difference between your 
code and this patch is moving the #ifdef'd code out of code paths and putting 
it into dyn-tick specific files. 

This has slightly more build fixes than the last one I posted and boots and 
runs fine on my laptop. So far at absolute idle it appears this pentiumM 1.7 
is claiming to have _25%_ more battery life. I'll need to investigate further 
to see the real power savings. 

My desktop pentium4 did not like the patch erroring with "bad gzip magic 
number" on boot for reasons that aren't obvious to me. This could be related 
to trying gcc 4.0.1 on that box whereas the laptop is on gcc 3.4.4 and is 
working fine.

Cheers,
Con

--Boundary-00=_Lov7CiRCsQqP7z8
Content-Type: text/x-diff;
  charset="us-ascii";
  name="2.6.13-rc4-dtck-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="2.6.13-rc4-dtck-2.patch"

Index: linux-2.6.13-rc4-ck1/arch/i386/Kconfig
===================================================================
--- linux-2.6.13-rc4-ck1.orig/arch/i386/Kconfig	2005-08-02 13:40:01.000000000 +1000
+++ linux-2.6.13-rc4-ck1/arch/i386/Kconfig	2005-08-02 13:40:51.000000000 +1000
@@ -457,6 +457,38 @@ config HPET_EMULATE_RTC
 	bool "Provide RTC interrupt"
 	depends on HPET_TIMER && RTC=y
 
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
+config DYN_TICK_USE_APIC
+	bool "Use APIC timer instead of PIT timer"
+	depends on NO_IDLE_HZ
+	help
+	  This option enables using APIC timer interrupt if your hardware
+	  supports it. APIC timer allows longer sleep periods compared
+	  to PIT timer.
+
+	  Note that on most recent hardware disabling PIT timer also
+	  disables APIC timer interrupts, and system won't run properly.
+	  Symptoms include slow system boot, and time running slow.
+
+	  If unsure, don't enable this option.
+
+	  Note that to you still need to pass dyntick=enable,forceapic
+	  command line option to use APIC timer.
+
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
Index: linux-2.6.13-rc4-ck1/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.13-rc4-ck1.orig/arch/i386/kernel/Makefile	2005-08-02 13:38:53.000000000 +1000
+++ linux-2.6.13-rc4-ck1/arch/i386/kernel/Makefile	2005-08-02 13:40:51.000000000 +1000
@@ -32,6 +32,7 @@ obj-$(CONFIG_MODULES)		+= module.o
 obj-y				+= sysenter.o vsyscall.o
 obj-$(CONFIG_ACPI_SRAT) 	+= srat.o
 obj-$(CONFIG_HPET_TIMER) 	+= time_hpet.o
+obj-$(CONFIG_NO_IDLE_HZ) 	+= dyn-tick.o
 obj-$(CONFIG_EFI) 		+= efi.o efi_stub.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
Index: linux-2.6.13-rc4-ck1/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.13-rc4-ck1.orig/arch/i386/kernel/apic.c	2005-08-02 13:38:53.000000000 +1000
+++ linux-2.6.13-rc4-ck1/arch/i386/kernel/apic.c	2005-08-02 13:40:51.000000000 +1000
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
+	apic_timer_val = clocks/APIC_DIVISOR;
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
Index: linux-2.6.13-rc4-ck1/arch/i386/kernel/dyn-tick.c
===================================================================
--- linux-2.6.13-rc4-ck1.orig/arch/i386/kernel/dyn-tick.c	2005-08-02 13:54:45.000000000 +1000
+++ linux-2.6.13-rc4-ck1/arch/i386/kernel/dyn-tick.c	2005-08-02 13:40:51.000000000 +1000
@@ -0,0 +1,164 @@
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
+#ifdef CONFIG_X86_LOCAL_APIC
+void reprogram_apic_timer(unsigned int count)
+{
+	unsigned long flags;
+
+	count *= apic_timer_val;
+	local_irq_save(flags);
+	apic_write_around(APIC_TMICT, count);
+	local_irq_restore(flags);
+}
+#else
+void reprogram_apic_timer(unsigned int count)
+{
+}
+
+#endif
+
+void arch_reprogram_timer(void)
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
+int __init dyn_tick_init(void)
+{
+	arch_dyn_tick_timer.arch_init = dyn_tick_arch_init;
+	dyn_tick_register(&arch_dyn_tick_timer);
+
+	return 0;
+}
+arch_initcall(dyn_tick_init);
+
+static unsigned long long last_tick;
+
+/*
+ * This interrupt handler updates the time based on number of jiffies skipped
+ * It would be somewhat more optimized to have a customa handler in each timer
+ * using hardware ticks instead of nanoseconds. Note that CONFIG_NO_IDLE_HZ
+ * currently disables timer fallback on skipped jiffies.
+ */
+irqreturn_t dyn_tick_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
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
+		dyn_tick->max_skip = 0xffff/LATCH;	/* PIT timer length */
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
+inline void set_dyn_tick_max_skip(u32 apic_timer_val)
+{
+	dyn_tick->max_skip = 0xffffff / apic_timer_val;
+}
+
+inline void setup_dyn_tick_use_apic(unsigned int calibration_result)
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
+			if (dyn_tick->skip_cpu == cpu && dyn_tick->skip > DYN_TICK_MIN_SKIP)
+				dyn_tick->interrupt(99, NULL, regs);
+			else
+				reprogram_apic_timer(1);
+		}
+	} while (read_seqretry(&xtime_lock, seq));
+}
+
+void dyn_tick_interrupt(int irq, struct pt_regs *regs)
+{
+	if (dyn_tick->state & (DYN_TICK_ENABLED | DYN_TICK_SKIPPING) && irq != 0)
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
Index: linux-2.6.13-rc4-ck1/arch/i386/kernel/irq.c
===================================================================
--- linux-2.6.13-rc4-ck1.orig/arch/i386/kernel/irq.c	2005-08-02 13:38:53.000000000 +1000
+++ linux-2.6.13-rc4-ck1/arch/i386/kernel/irq.c	2005-08-02 13:40:51.000000000 +1000
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
Index: linux-2.6.13-rc4-ck1/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.13-rc4-ck1.orig/arch/i386/kernel/process.c	2005-08-02 13:38:53.000000000 +1000
+++ linux-2.6.13-rc4-ck1/arch/i386/kernel/process.c	2005-08-02 13:40:51.000000000 +1000
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
Index: linux-2.6.13-rc4-ck1/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.13-rc4-ck1.orig/arch/i386/kernel/time.c	2005-08-02 13:38:53.000000000 +1000
+++ linux-2.6.13-rc4-ck1/arch/i386/kernel/time.c	2005-08-02 13:46:18.000000000 +1000
@@ -46,6 +46,7 @@
 #include <linux/bcd.h>
 #include <linux/efi.h>
 #include <linux/mca.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/io.h>
 #include <asm/smp.h>
@@ -252,7 +253,7 @@ EXPORT_SYMBOL(profile_pc);
  * timer_interrupt() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static inline void do_timer_interrupt(int irq, void *dev_id,
+inline void do_timer_interrupt(int irq, void *dev_id,
 					struct pt_regs *regs)
 {
 #ifdef CONFIG_X86_IO_APIC
@@ -423,7 +424,7 @@ static struct sysdev_class timer_sysclas
 
 
 /* XXX this driverfs stuff should probably go elsewhere later -john */
-static struct sys_device device_timer = {
+struct sys_device device_timer = {
 	.id	= 0,
 	.cls	= &timer_sysclass,
 };
@@ -479,5 +480,7 @@ void __init time_init(void)
 	cur_timer = select_timer();
 	printk(KERN_INFO "Using %s for high-res timesource\n",cur_timer->name);
 
+	dyn_tick_time_init(cur_timer);
+
 	time_init_hook();
 }
Index: linux-2.6.13-rc4-ck1/arch/i386/kernel/timers/timer_pit.c
===================================================================
--- linux-2.6.13-rc4-ck1.orig/arch/i386/kernel/timers/timer_pit.c	2005-08-02 13:38:53.000000000 +1000
+++ linux-2.6.13-rc4-ck1/arch/i386/kernel/timers/timer_pit.c	2005-08-02 13:40:51.000000000 +1000
@@ -148,6 +148,43 @@ static unsigned long get_offset_pit(void
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
Index: linux-2.6.13-rc4-ck1/arch/i386/kernel/timers/timer_pm.c
===================================================================
--- linux-2.6.13-rc4-ck1.orig/arch/i386/kernel/timers/timer_pm.c	2005-08-02 13:38:53.000000000 +1000
+++ linux-2.6.13-rc4-ck1/arch/i386/kernel/timers/timer_pm.c	2005-08-02 13:40:51.000000000 +1000
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
Index: linux-2.6.13-rc4-ck1/arch/i386/kernel/timers/timer_tsc.c
===================================================================
--- linux-2.6.13-rc4-ck1.orig/arch/i386/kernel/timers/timer_tsc.c	2005-08-02 13:38:53.000000000 +1000
+++ linux-2.6.13-rc4-ck1/arch/i386/kernel/timers/timer_tsc.c	2005-08-02 13:40:51.000000000 +1000
@@ -14,6 +14,7 @@
 #include <linux/cpufreq.h>
 #include <linux/string.h>
 #include <linux/jiffies.h>
+#include <linux/dyn-tick.h>
 
 #include <asm/timer.h>
 #include <asm/io.h>
@@ -367,6 +368,9 @@ static void mark_offset_tsc(void)
 
 	rdtsc(last_tsc_low, last_tsc_high);
 
+	if (dyn_tick_enabled())
+		goto monotonic_base;
+
 	spin_lock(&i8253_lock);
 	outb_p(0x00, PIT_MODE);     /* latch the count ASAP */
 
@@ -434,11 +438,17 @@ static void mark_offset_tsc(void)
 			cpufreq_delayed_get();
 	} else
 		lost_count = 0;
+
+ monotonic_base:
+
 	/* update the monotonic base value */
 	this_offset = ((unsigned long long)last_tsc_high<<32)|last_tsc_low;
 	monotonic_base += cycles_2_ns(this_offset - last_offset);
 	write_sequnlock(&monotonic_lock);
 
+	if (dyn_tick_enabled())
+		return;
+
 	/* calculate delay_at_last_interrupt */
 	count = ((LATCH-1) - count) * TICK_SIZE;
 	delay_at_last_interrupt = (count + LATCH/2) / LATCH;
Index: linux-2.6.13-rc4-ck1/arch/i386/mach-default/setup.c
===================================================================
--- linux-2.6.13-rc4-ck1.orig/arch/i386/mach-default/setup.c	2005-08-02 13:38:53.000000000 +1000
+++ linux-2.6.13-rc4-ck1/arch/i386/mach-default/setup.c	2005-08-02 13:40:51.000000000 +1000
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
+void replace_timer_interrupt(void * new_handler)
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
Index: linux-2.6.13-rc4-ck1/include/asm-i386/dyn-tick.h
===================================================================
--- linux-2.6.13-rc4-ck1.orig/include/asm-i386/dyn-tick.h	2005-08-02 13:54:45.000000000 +1000
+++ linux-2.6.13-rc4-ck1/include/asm-i386/dyn-tick.h	2005-08-02 13:43:46.000000000 +1000
@@ -0,0 +1,66 @@
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
+#ifdef CONFIG_NO_IDLE_HZ
+extern int dyn_tick_arch_init(void);
+extern void disable_pit_timer(void);
+extern void reprogram_pit_timer(int jiffies_to_skip);
+extern void reprogram_apic_timer(unsigned int count);
+extern void replace_timer_interrupt(void * new_handler);
+
+extern void set_dyn_tick_max_skip(u32 apic_timer_val);
+extern void setup_dyn_tick_use_apic(unsigned int calibration_result);
+extern void wakeup_pit_or_apic(int cpu, struct pt_regs *regs);
+extern void dyn_tick_interrupt(int irq, struct pt_regs *regs);
+extern void dyn_tick_time_init(struct timer_opts *cur_timer);
+extern void do_timer_interrupt(int irq, void *dev_id,
+					struct pt_regs *regs);
+
+extern irqreturn_t dyn_tick_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+extern int __init dyn_tick_arch_init(void);
+extern u32 apic_timer_val;
+
+#if defined(CONFIG_DYN_TICK_USE_APIC) && (defined(CONFIG_SMP) || defined(CONFIG_X86_UP_APIC))
+#define cpu_has_local_apic()	(dyn_tick->state & DYN_TICK_USE_APIC)
+#else
+#define cpu_has_local_apic()	0
+#endif
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
+#endif /* _ASM_I386_DYN_TICK_H_ */
Index: linux-2.6.13-rc4-ck1/include/linux/dyn-tick.h
===================================================================
--- linux-2.6.13-rc4-ck1.orig/include/linux/dyn-tick.h	2005-08-02 13:54:45.000000000 +1000
+++ linux-2.6.13-rc4-ck1/include/linux/dyn-tick.h	2005-08-02 13:40:51.000000000 +1000
@@ -0,0 +1,66 @@
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
+#define DYN_TICK_TIMER_INT	(1 << 4)
+#define DYN_TICK_USE_APIC	(1 << 3)
+#define DYN_TICK_SKIPPING	(1 << 2)
+#define DYN_TICK_ENABLED	(1 << 1)
+#define DYN_TICK_SUITABLE	(1 << 0)
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
+extern struct dyn_tick_state * dyn_tick;
+extern void dyn_tick_register(struct dyn_tick_timer * new_timer);
+
+#define NS_TICK_LEN		((1 * 1000000000)/HZ)
+#define DYN_TICK_MIN_SKIP	2
+
+
+#ifdef CONFIG_NO_IDLE_HZ
+
+extern unsigned long dyn_tick_reprogram_timer(void);
+
+#define dyn_tick_enabled()		(dyn_tick->state & DYN_TICK_ENABLED)
+
+#else
+
+#define arch_has_safe_halt()		0
+#define dyn_tick_reprogram_timer()	do {} while (0)
+#define dyn_tick_enabled()		0
+
+#endif	/* CONFIG_NO_IDLE_HZ */
+
+
+/* Pick up arch specific header */
+#include <asm/dyn-tick.h>
+
+#endif	/* _DYN_TICK_TIMER_H */
Index: linux-2.6.13-rc4-ck1/kernel/Makefile
===================================================================
--- linux-2.6.13-rc4-ck1.orig/kernel/Makefile	2005-08-02 13:38:57.000000000 +1000
+++ linux-2.6.13-rc4-ck1/kernel/Makefile	2005-08-02 13:40:51.000000000 +1000
@@ -30,6 +30,7 @@ obj-$(CONFIG_SYSFS) += ksysfs.o
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
+obj-$(CONFIG_NO_IDLE_HZ) += dyn-tick.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
Index: linux-2.6.13-rc4-ck1/kernel/dyn-tick.c
===================================================================
--- linux-2.6.13-rc4-ck1.orig/kernel/dyn-tick.c	2005-08-02 13:54:45.000000000 +1000
+++ linux-2.6.13-rc4-ck1/kernel/dyn-tick.c	2005-08-02 14:26:42.000000000 +1000
@@ -0,0 +1,212 @@
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
+
+struct dyn_tick_state dyn_tick_state;
+struct dyn_tick_state * dyn_tick = &dyn_tick_state;
+struct dyn_tick_timer * dyn_tick_cfg;
+static cpumask_t dyn_cpu_map;
+
+/*
+ * Arch independed code needed to reprogram next timer interrupt.
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
+	if (!(dyn_tick->state & DYN_TICK_ENABLED))
+		return 0;
+
+	/* Check if we are already skipping ticks and can idle other cpus */
+	if (dyn_tick->state & DYN_TICK_SKIPPING) {
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
+void __init dyn_tick_register(struct dyn_tick_timer * arch_timer)
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
+static int __initdata dyntick_autoenable = 0;
+static int __initdata dyntick_useapic = 0;
+
+/*
+ * dyntick=[enable|disable],[forceapic]
+ */ 
+static int __init dyntick_setup(char *options)
+{
+	if (!options)
+		return 0;
+
+	if (!strncmp(options, "enable", 6)) 
+		dyntick_autoenable = 1;
+
+	if (strstr(options, "forceapic"))
+		dyntick_useapic = 1;
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
+#define DYN_TICK_IS_SET(x)	((dyn_tick->state & (x)) == (x))
+
+static ssize_t show_dyn_tick_state(struct sys_device *dev, char *buf)
+{
+	return sprintf(buf,
+		       "suitable:\t%i\n"
+		       "enabled:\t%i\n"
+		       "using APIC:\t%i\n",
+		       DYN_TICK_IS_SET(DYN_TICK_SUITABLE),
+		       DYN_TICK_IS_SET(DYN_TICK_ENABLED),
+		       DYN_TICK_IS_SET(DYN_TICK_USE_APIC));
+}
+
+static ssize_t set_dyn_tick_state(struct sys_device *dev, const char * buf,
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
+static SYSDEV_ATTR(dyn_tick_state, 0644, show_dyn_tick_state,
+		   set_dyn_tick_state);
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
+	    !(dyn_tick->state & DYN_TICK_SUITABLE)) {
+		printk(KERN_ERR "dyn-tick: No suitable timer found\n");
+		return -ENODEV;
+	}
+
+	if (!dyntick_useapic)
+		dyn_tick->state &= ~DYN_TICK_USE_APIC;
+
+	ret = dyn_tick_cfg->arch_init();
+	if (ret != 0) {
+		printk(KERN_ERR "dyn-tick: Init failed\n");
+		return -ENODEV;
+	}
+
+	ret = sysdev_create_file(&device_timer, &attr_dyn_tick_state);
+
+	if (ret == 0 && dyntick_autoenable) {
+		dyn_tick->state |= DYN_TICK_ENABLED;
+		printk(KERN_INFO "dyn-tick: Timer using dynamic tick\n");
+	} else
+		printk(KERN_INFO "dyn-tick: Timer not enabled during boot\n");
+
+	return ret;
+}
+
+late_initcall(dyn_tick_late_init);

--Boundary-00=_Lov7CiRCsQqP7z8--
