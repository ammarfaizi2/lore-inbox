Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422846AbWI3AGy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422846AbWI3AGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422845AbWI3AGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:06:51 -0400
Received: from www.osadl.org ([213.239.205.134]:23188 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1422839AbWI3AEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:04:11 -0400
Message-Id: <20060929234440.404341000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
Date: Fri, 29 Sep 2006 23:58:33 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: [patch 14/23] clockevents: drivers for i386
Content-Disposition: inline; filename=clockevents-i386.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

add clockevent drivers for i386: lapic (local) and PIT (global).
Update the timer IRQ to call into the PIT driver's event handler
and the lapic-timer IRQ to call into the lapic clockevent driver.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
--
 arch/i386/kernel/apic.c                  |   81 ++++++++++++++++++++++++-------
 arch/i386/kernel/i8253.c                 |   60 +++++++++++++++++++---
 arch/i386/kernel/time.c                  |   45 -----------------
 include/asm-i386/i8253.h                 |    1 
 include/asm-i386/mach-default/do_timer.h |    3 -
 5 files changed, 120 insertions(+), 70 deletions(-)

Index: linux-2.6.18-mm2/arch/i386/kernel/apic.c
===================================================================
--- linux-2.6.18-mm2.orig/arch/i386/kernel/apic.c	2006-09-30 01:41:11.000000000 +0200
+++ linux-2.6.18-mm2/arch/i386/kernel/apic.c	2006-09-30 01:41:18.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
+#include <linux/clockchips.h>
 #include <linux/module.h>
 
 #include <asm/atomic.h>
@@ -70,6 +71,23 @@ static inline void lapic_enable(void)
  */
 int apic_verbosity;
 
+static unsigned int calibration_result;
+
+static void lapic_next_event(unsigned long delta, struct clock_event *evt);
+static void lapic_timer_setup(int mode, struct clock_event *evt);
+
+static struct clock_event lapic_clockevent = {
+	.name = "lapic",
+	.capabilities = CLOCK_CAP_NEXTEVT | CLOCK_CAP_PROFILE
+#ifdef CONFIG_SMP
+			| CLOCK_CAP_UPDATE
+#endif
+	,
+	.shift = 32,
+	.set_mode = lapic_timer_setup,
+	.set_next_event = lapic_next_event,
+};
+static DEFINE_PER_CPU(struct clock_event, lapic_events);
 
 static void apic_pm_activate(void);
 
@@ -919,6 +937,11 @@ fake_ioapic_page:
  */
 
 /*
+ * FIXME: Move this to i8253.h. There is no need to keep the access to
+ * the PIT scattered all around the place -tglx
+ */
+
+/*
  * The timer chip is already set up at HZ interrupts per second here,
  * but we do not accept timer interrupts yet. We only allow the BP
  * to calibrate.
@@ -976,13 +999,15 @@ void (*wait_timer_tick)(void) __devinitd
 
 #define APIC_DIVISOR 16
 
-static void __setup_APIC_LVTT(unsigned int clocks)
+static void __setup_APIC_LVTT(unsigned int clocks, int oneshot)
 {
 	unsigned int lvtt_value, tmp_value, ver;
 	int cpu = smp_processor_id();
 
 	ver = GET_APIC_VERSION(apic_read(APIC_LVR));
-	lvtt_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
+	lvtt_value = LOCAL_TIMER_VECTOR;
+	if (!oneshot)
+		lvtt_value |= APIC_LVT_TIMER_PERIODIC;
 	if (!APIC_INTEGRATED(ver))
 		lvtt_value |= SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV);
 
@@ -999,23 +1024,31 @@ static void __setup_APIC_LVTT(unsigned i
 				& ~(APIC_TDR_DIV_1 | APIC_TDR_DIV_TMBASE))
 				| APIC_TDR_DIV_16);
 
-	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
+	if (!oneshot)
+		apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
+}
+
+static void lapic_next_event(unsigned long delta, struct clock_event *evt)
+{
+	apic_write_around(APIC_TMICT, delta);
 }
 
-static void __devinit setup_APIC_timer(unsigned int clocks)
+static void lapic_timer_setup(int mode, struct clock_event *evt)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
+	__setup_APIC_LVTT(calibration_result, mode != CLOCK_EVT_PERIODIC);
+	local_irq_restore(flags);
+}
 
-	/*
-	 * Wait for IRQ0's slice:
-	 */
-	wait_timer_tick();
+static void __devinit setup_APIC_timer(void)
+{
+	struct clock_event *levt = &__get_cpu_var(lapic_events);
 
-	__setup_APIC_LVTT(clocks);
+	memcpy(levt, &lapic_clockevent, sizeof(*levt));
 
-	local_irq_restore(flags);
+	register_local_clockevent(levt);
 }
 
 /*
@@ -1024,6 +1057,8 @@ static void __devinit setup_APIC_timer(u
  * to calibrate, since some later bootup code depends on getting
  * the first irq? Ugh.
  *
+ * TODO: Fix this rather than saying "Ugh" -tglx
+ *
  * We want to do the calibration only once since we
  * want to have local timer irqs syncron. CPUs connected
  * by the same APIC bus have the very same bus frequency.
@@ -1046,7 +1081,7 @@ static int __init calibrate_APIC_clock(v
 	 * value into the APIC clock, we just want to get the
 	 * counter running for calibration.
 	 */
-	__setup_APIC_LVTT(1000000000);
+	__setup_APIC_LVTT(1000000000, 0);
 
 	/*
 	 * The timer chip counts down to zero. Let's wait
@@ -1083,6 +1118,14 @@ static int __init calibrate_APIC_clock(v
 
 	result = (tt1-tt2)*APIC_DIVISOR/LOOPS;
 
+	/* Calculate the scaled math multiplication factor */
+	lapic_clockevent.mult = div_sc(tt1-tt2, TICK_NSEC * LOOPS, 32);
+	lapic_clockevent.max_delta_ns =
+		clockevent_delta2ns(0x7FFFFF, &lapic_clockevent);
+	printk("lapic max_delta_ns: %ld\n", lapic_clockevent.max_delta_ns);
+	lapic_clockevent.min_delta_ns =
+		clockevent_delta2ns(0xF, &lapic_clockevent);
+
 	if (cpu_has_tsc)
 		apic_printk(APIC_VERBOSE, "..... CPU clock speed is "
 			"%ld.%04ld MHz.\n",
@@ -1097,8 +1140,6 @@ static int __init calibrate_APIC_clock(v
 	return result;
 }
 
-static unsigned int calibration_result;
-
 void __init setup_boot_APIC_clock(void)
 {
 	unsigned long flags;
@@ -1111,14 +1152,14 @@ void __init setup_boot_APIC_clock(void)
 	/*
 	 * Now set up the timer for real.
 	 */
-	setup_APIC_timer(calibration_result);
+	setup_APIC_timer();
 
 	local_irq_restore(flags);
 }
 
 void __devinit setup_secondary_APIC_clock(void)
 {
-	setup_APIC_timer(calibration_result);
+	setup_APIC_timer();
 }
 
 void disable_APIC_timer(void)
@@ -1164,6 +1205,13 @@ void switch_APIC_timer_to_ipi(void *cpum
 	    !cpu_isset(cpu, timer_bcast_ipi)) {
 		disable_APIC_timer();
 		cpu_set(cpu, timer_bcast_ipi);
+#ifdef CONFIG_HIGH_RES_TIMERS
+		printk("Disabling NO_HZ and high resolution timers "
+		       "due to timer broadcasting\n");
+		for_each_possible_cpu(cpu)
+			per_cpu(lapic_events, cpu).capabilities &=
+				~CLOCK_CAP_NEXTEVT;
+#endif
 	}
 }
 EXPORT_SYMBOL(switch_APIC_timer_to_ipi);
@@ -1224,6 +1272,7 @@ inline void smp_local_timer_interrupt(st
 fastcall void smp_apic_timer_interrupt(struct pt_regs *regs)
 {
 	int cpu = smp_processor_id();
+	struct clock_event *evt = &per_cpu(lapic_events, cpu);
 
 	/*
 	 * the NMI deadlock-detector uses this.
@@ -1241,7 +1290,7 @@ fastcall void smp_apic_timer_interrupt(s
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
-	smp_local_timer_interrupt(regs);
+	evt->event_handler(regs);
 	irq_exit();
 }
 
Index: linux-2.6.18-mm2/arch/i386/kernel/i8253.c
===================================================================
--- linux-2.6.18-mm2.orig/arch/i386/kernel/i8253.c	2006-09-30 01:41:11.000000000 +0200
+++ linux-2.6.18-mm2/arch/i386/kernel/i8253.c	2006-09-30 01:41:18.000000000 +0200
@@ -2,7 +2,7 @@
  * i8253.c  8253/PIT functions
  *
  */
-#include <linux/clocksource.h>
+#include <linux/clockchips.h>
 #include <linux/spinlock.h>
 #include <linux/jiffies.h>
 #include <linux/sysdev.h>
@@ -19,19 +19,63 @@
 DEFINE_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
-void setup_pit_timer(void)
+static void init_pit_timer(int mode, struct clock_event *evt)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&i8253_lock, flags);
+
+	switch(mode) {
+	case CLOCK_EVT_PERIODIC:
+		/* binary, mode 2, LSB/MSB, ch 0 */
+		outb_p(0x34, PIT_MODE);
+		udelay(10);
+		outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
+		outb(LATCH >> 8 , PIT_CH0);	/* MSB */
+		break;
+
+	case CLOCK_EVT_ONESHOT:
+	case CLOCK_EVT_SHUTDOWN:
+		/* One shot setup */
+		outb_p(0x38, PIT_MODE);
+		udelay(10);
+		break;
+	}
+	spin_unlock_irqrestore(&i8253_lock, flags);
+}
+
+static void pit_next_event(unsigned long delta, struct clock_event *evt)
 {
 	unsigned long flags;
 
 	spin_lock_irqsave(&i8253_lock, flags);
-	outb_p(0x34,PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
-	udelay(10);
-	outb_p(LATCH & 0xff , PIT_CH0);	/* LSB */
-	udelay(10);
-	outb(LATCH >> 8 , PIT_CH0);	/* MSB */
+	outb_p(delta & 0xff , PIT_CH0);	/* LSB */
+	outb(delta >> 8 , PIT_CH0);	/* MSB */
 	spin_unlock_irqrestore(&i8253_lock, flags);
 }
 
+struct clock_event pit_clockevent = {
+	.name		= "pit",
+	.capabilities	= CLOCK_CAP_TICK | CLOCK_CAP_PROFILE | CLOCK_CAP_UPDATE
+#ifndef CONFIG_SMP
+			| CLOCK_CAP_NEXTEVT
+#endif
+	,
+	.set_mode	= init_pit_timer,
+	.set_next_event = pit_next_event,
+	.shift		= 32,
+};
+
+void setup_pit_timer(void)
+{
+	pit_clockevent.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC, 32);
+	pit_clockevent.max_delta_ns =
+		clockevent_delta2ns(0x7FFF, &pit_clockevent);
+	pit_clockevent.min_delta_ns =
+		clockevent_delta2ns(0xF, &pit_clockevent);
+	register_global_clockevent(&pit_clockevent);
+}
+
 /*
  * Since the PIT overflows every tick, its not very useful
  * to just read by itself. So use jiffies to emulate a free
@@ -46,7 +90,7 @@ static cycle_t pit_read(void)
 	static u32 old_jifs;
 
 	spin_lock_irqsave(&i8253_lock, flags);
-        /*
+	/*
 	 * Although our caller may have the read side of xtime_lock,
 	 * this is now a seqlock, and we are cheating in this routine
 	 * by having side effects on state that we cannot undo if
Index: linux-2.6.18-mm2/arch/i386/kernel/time.c
===================================================================
--- linux-2.6.18-mm2.orig/arch/i386/kernel/time.c	2006-09-30 01:41:15.000000000 +0200
+++ linux-2.6.18-mm2/arch/i386/kernel/time.c	2006-09-30 01:41:18.000000000 +0200
@@ -163,15 +163,6 @@ EXPORT_SYMBOL(profile_pc);
  */
 irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	/*
-	 * Here we are in the timer irq handler. We just have irqs locally
-	 * disabled but we don't know if the timer_bh is running on the other
-	 * CPU. We need to avoid to SMP race with it. NOTE: we don' t need
-	 * the irq version of write_lock because as just said we have irq
-	 * locally disabled. -arca
-	 */
-	write_seqlock(&xtime_lock);
-
 #ifdef CONFIG_X86_IO_APIC
 	if (timer_ack) {
 		/*
@@ -190,7 +181,6 @@ irqreturn_t timer_interrupt(int irq, voi
 
 	do_timer_interrupt_hook(regs);
 
-
 	if (MCA_bus) {
 		/* The PS/2 uses level-triggered interrupts.  You can't
 		turn them off, nor would you want to (any attempt to
@@ -205,8 +195,6 @@ irqreturn_t timer_interrupt(int irq, voi
 		outb_p( irq|0x80, 0x61 );	/* reset the IRQ */
 	}
 
-	write_sequnlock(&xtime_lock);
-
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (using_apic_timer)
 		smp_send_timer_broadcast_ipi(regs);
@@ -283,39 +271,6 @@ void notify_arch_cmos_timer(void)
 	mod_timer(&sync_cmos_timer, jiffies + 1);
 }
 
-static int timer_resume(struct sys_device *dev)
-{
-#ifdef CONFIG_HPET_TIMER
-	if (is_hpet_enabled())
-		hpet_reenable();
-#endif
-	setup_pit_timer();
-
-	return 0;
-}
-
-static struct sysdev_class timer_sysclass = {
-	.resume = timer_resume,
-	set_kset_name("timer"),
-};
-
-
-/* XXX this driverfs stuff should probably go elsewhere later -john */
-static struct sys_device device_timer = {
-	.id	= 0,
-	.cls	= &timer_sysclass,
-};
-
-static int time_init_device(void)
-{
-	int error = sysdev_class_register(&timer_sysclass);
-	if (!error)
-		error = sysdev_register(&device_timer);
-	return error;
-}
-
-device_initcall(time_init_device);
-
 #ifdef CONFIG_HPET_TIMER
 extern void (*late_time_init)(void);
 /* Duplicate of time_init() below, with hpet_enable part added */
Index: linux-2.6.18-mm2/include/asm-i386/i8253.h
===================================================================
--- linux-2.6.18-mm2.orig/include/asm-i386/i8253.h	2006-09-30 01:41:11.000000000 +0200
+++ linux-2.6.18-mm2/include/asm-i386/i8253.h	2006-09-30 01:41:18.000000000 +0200
@@ -2,5 +2,6 @@
 #define __ASM_I8253_H__
 
 extern spinlock_t i8253_lock;
+extern struct clock_event pit_clockevent;
 
 #endif	/* __ASM_I8253_H__ */
Index: linux-2.6.18-mm2/include/asm-i386/mach-default/do_timer.h
===================================================================
--- linux-2.6.18-mm2.orig/include/asm-i386/mach-default/do_timer.h	2006-09-30 01:41:11.000000000 +0200
+++ linux-2.6.18-mm2/include/asm-i386/mach-default/do_timer.h	2006-09-30 01:41:18.000000000 +0200
@@ -1,7 +1,8 @@
 /* defines for inline arch setup functions */
-
+#include <linux/clockchips.h>
 #include <asm/apic.h>
 #include <asm/i8259.h>
+#include <asm/i8253.h>
 
 /**
  * do_timer_interrupt_hook - hook into timer tick

--

