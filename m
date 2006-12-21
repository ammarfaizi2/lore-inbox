Return-Path: <linux-kernel-owner+w=401wt.eu-S1422859AbWLUIgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422859AbWLUIgB (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422833AbWLUIgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:36:01 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:65192 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422859AbWLUIf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:35:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:from;
        b=oQVf8vMUM0VgCPf6B/gPnwOPLWiXqZb0xw3iVvvZ1Em5FbxTVwTOTZoqnWgOcp/ceIal2s6TS/zZ12oewNw+VK6gfJMbOJ8Fw9GVCORl5z4mTKqj7cbL30APAbj2deZGo76eo1oLFZeEoRrvTacjyk1HIzp7arzjofZJhHe1PvQ=
Message-ID: <458A476B.5040905@gmail.com>
Date: Thu, 21 Dec 2006 09:35:55 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH -rt 4/4] ARM: OMAP: Add clockevent driver for OMAP
Content-Type: multipart/mixed;
 boundary="------------000706030402080207090704"
From: Dirk Behme <dirk.behme@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000706030402080207090704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ARM: OMAP: Add clockevent driver for OMAP.

This is an update of the initial patch from Daniel Walker
and Kevin Hilman. Update to apply cleanly to 2.6.20-rc1 by
Dirk Behme.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------000706030402080207090704
Content-Type: text/plain;
 name="arm_omap_clockevents_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arm_omap_clockevents_patch.txt"

Index: linux-2.6.20-rc1/arch/arm/mach-omap1/time.c
===================================================================
--- linux-2.6.20-rc1.orig/arch/arm/mach-omap1/time.c
+++ linux-2.6.20-rc1/arch/arm/mach-omap1/time.c
@@ -42,6 +42,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -102,15 +103,33 @@ static inline unsigned long omap_mpu_tim
 	return timer->read_tim;
 }
 
-static inline void omap_mpu_timer_start(int nr, unsigned long load_val)
+static inline void omap_mpu_set_autoreset(int nr)
+{
+ 	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
+
+	timer->cntl = timer->cntl | MPU_TIMER_AR;
+}
+
+static inline void omap_mpu_remove_autoreset(int nr)
 {
 	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
 
+	timer->cntl = timer->cntl & ~MPU_TIMER_AR;
+}
+
+static inline void omap_mpu_timer_start(int nr, unsigned long load_val,
+					int autoreset)
+{
+	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
+	unsigned int timerflags = (MPU_TIMER_CLOCK_ENABLE | MPU_TIMER_ST);
+
+	if (autoreset) timerflags |= MPU_TIMER_AR;
+
 	timer->cntl = MPU_TIMER_CLOCK_ENABLE;
 	udelay(1);
 	timer->load_tim = load_val;
         udelay(1);
-	timer->cntl = (MPU_TIMER_CLOCK_ENABLE | MPU_TIMER_AR | MPU_TIMER_ST);
+	timer->cntl = timerflags;
 }
 
 /*
@@ -118,12 +137,39 @@ static inline void omap_mpu_timer_start(
  * MPU timer 1 ... count down to zero, interrupt, reload
  * ---------------------------------------------------------------------------
  */
+static void omap_mpu_set_next_event(unsigned long cycles,
+				    struct clock_event_device *evt)
+{
+	omap_mpu_timer_start(0, cycles, 0);
+}
+
+static void omap_mpu_set_mode(enum clock_event_mode mode,
+			      struct clock_event_device *evt)
+{
+	switch (mode) {
+	case CLOCK_EVT_PERIODIC:
+		omap_mpu_set_autoreset(0);
+		break;
+	case CLOCK_EVT_ONESHOT:
+		omap_mpu_remove_autoreset(0);
+		break;
+	case CLOCK_EVT_SHUTDOWN:
+		break;
+	}
+}
+
+static struct clock_event_device clockevent_mpu_timer1 = {
+	.name		= "mpu_timer1",
+	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
+			  CLOCK_CAP_UPDATE,
+	.shift		= 32,
+	.set_next_event	= omap_mpu_set_next_event,
+	.set_mode	= omap_mpu_set_mode,
+};
+
 static irqreturn_t omap_mpu_timer1_interrupt(int irq, void *dev_id)
 {
-	write_seqlock(&xtime_lock);
-	/* NOTE:  no lost-tick detection/handling! */
-	timer_tick();
-	write_sequnlock(&xtime_lock);
+	clockevent_mpu_timer1.event_handler();
 
 	return IRQ_HANDLED;
 }
@@ -139,9 +185,19 @@ static __init void omap_init_mpu_timer(u
 	set_cyc2ns_scale(rate / 1000);
 
 	setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
-	omap_mpu_timer_start(0, (rate / HZ) - 1);
+	omap_mpu_timer_start(0, (rate / HZ) - 1, 1);
+
+	clockevent_mpu_timer1.mult = div_sc(rate, NSEC_PER_SEC,
+					    clockevent_mpu_timer1.shift);
+	clockevent_mpu_timer1.max_delta_ns =
+		clockevent_delta2ns(-1, &clockevent_mpu_timer1);
+	clockevent_mpu_timer1.min_delta_ns =
+		clockevent_delta2ns(1, &clockevent_mpu_timer1);
+
+        register_global_clockevent(&clockevent_mpu_timer1);
 }
 
+
 /*
  * ---------------------------------------------------------------------------
  * MPU timer 2 ... free running 32-bit clock source and scheduler clock
@@ -185,7 +241,7 @@ static void __init omap_init_clocksource
 		= clocksource_khz2mult(rate/1000, clocksource_mpu.shift);
 
 	setup_irq(INT_TIMER2, &omap_mpu_timer2_irq);
-	omap_mpu_timer_start(1, ~0);
+	omap_mpu_timer_start(1, ~0, 1);
 
 	if (clocksource_register(&clocksource_mpu))
 		printk(err, clocksource_mpu.name);
Index: linux-2.6.20-rc1/arch/arm/plat-omap/Kconfig
===================================================================
--- linux-2.6.20-rc1.orig/arch/arm/plat-omap/Kconfig
+++ linux-2.6.20-rc1/arch/arm/plat-omap/Kconfig
@@ -11,6 +11,7 @@ choice
 
 config ARCH_OMAP1
 	bool "TI OMAP1"
+	select GENERIC_CLOCKEVENTS
 
 config ARCH_OMAP2
 	bool "TI OMAP2"
Index: linux-2.6.20-rc1/arch/arm/plat-omap/timer32k.c
===================================================================
--- linux-2.6.20-rc1.orig/arch/arm/plat-omap/timer32k.c
+++ linux-2.6.20-rc1/arch/arm/plat-omap/timer32k.c
@@ -43,6 +43,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -81,13 +82,13 @@ struct sys_timer omap_timer;
 #define OMAP1_32K_TIMER_TVR		0x00
 #define OMAP1_32K_TIMER_TCR		0x04
 
-#define OMAP_32K_TICKS_PER_HZ		(32768 / HZ)
+#define OMAP_32K_TICKS_PER_SEC		(32768)
 
 /*
  * TRM says 1 / HZ = ( TVR + 1) / 32768, so TRV = (32768 / HZ) - 1
  * so with HZ = 128, TVR = 255.
  */
-#define OMAP_32K_TIMER_TICK_PERIOD	((32768 / HZ) - 1)
+#define OMAP_32K_TIMER_TICK_PERIOD	((OMAP_32K_TICKS_PER_SEC / HZ) - 1)
 
 #define JIFFIES_TO_HW_TICKS(nr_jiffies, clock_rate)			\
 				(((nr_jiffies) * (clock_rate)) / HZ)
@@ -143,6 +144,49 @@ static inline void omap_32k_timer_ack_ir
 
 #endif
 
+static void omap_32k_timer_set_next_event(unsigned long cycles,
+				    struct clock_event_device *evt)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	omap_32k_timer_stop();
+	omap_32k_timer_start(cycles);
+	local_irq_restore(flags);
+}
+
+static void omap_32k_timer_set_mode(enum clock_event_mode mode,
+			      struct clock_event_device *evt)
+{
+	static int periodic_requests = 0;
+
+	switch (mode) {
+	case CLOCK_EVT_ONESHOT:
+		/* 32k timer does not have one-shot support in hardware.
+		 * instead, wet just to a stop in the next_event hook,
+		 * and dont support PERIODIC */
+		break;
+	case CLOCK_EVT_PERIODIC:
+		if (periodic_requests)
+			printk(KERN_ERR "32k-timer: CLOCK_EVT_PERIODIC "
+			       "is not supported.\n");
+		periodic_requests++;
+		break;
+	case CLOCK_EVT_SHUTDOWN:
+		omap_32k_timer_stop();
+		break;
+	}
+}
+
+static struct clock_event_device clockevent_32k_timer = {
+	.name		= "32k-timer",
+	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
+			  CLOCK_CAP_UPDATE,
+	.shift		= 32,
+	.set_next_event	= omap_32k_timer_set_next_event,
+	.set_mode	= omap_32k_timer_set_mode,
+};
+
 /*
  * The 32KHz synchronized timer is an additional timer on 16xx.
  * It is always running.
@@ -180,107 +224,15 @@ unsigned long long sched_clock(void)
 	return omap_32k_ticks_to_nsecs(omap_32k_sync_timer_read());
 }
 
-/*
- * Timer interrupt for 32KHz timer. When dynamic tick is enabled, this
- * function is also called from other interrupts to remove latency
- * issues with dynamic tick. In the dynamic tick case, we need to lock
- * with irqsave.
- */
-static inline irqreturn_t _omap_32k_timer_interrupt(int irq, void *dev_id)
-{
-	unsigned long now;
-
-	omap_32k_timer_ack_irq();
-	now = omap_32k_sync_timer_read();
-
-	while ((signed long)(now - omap_32k_last_tick)
-						>= OMAP_32K_TICKS_PER_HZ) {
-		omap_32k_last_tick += OMAP_32K_TICKS_PER_HZ;
-		timer_tick();
-	}
-
-	/* Restart timer so we don't drift off due to modulo or dynamic tick.
-	 * By default we program the next timer to be continuous to avoid
-	 * latencies during high system load. During dynamic tick operation the
-	 * continuous timer can be overridden from pm_idle to be longer.
-	 */
-	omap_32k_timer_start(omap_32k_last_tick + OMAP_32K_TICKS_PER_HZ - now);
-
-	return IRQ_HANDLED;
-}
-
 static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
 {
-	unsigned long flags;
+	omap_32k_timer_ack_irq();
 
-	write_seqlock_irqsave(&xtime_lock, flags);
-	_omap_32k_timer_interrupt(irq, dev_id);
-	write_sequnlock_irqrestore(&xtime_lock, flags);
+	clockevent_32k_timer.event_handler();
 
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_NO_IDLE_HZ
-
-/*
- * Programs the next timer interrupt needed. Called when dynamic tick is
- * enabled, and to reprogram the ticks to skip from pm_idle. Note that
- * we can keep the timer continuous, and don't need to set it to run in
- * one-shot mode. This is because the timer will get reprogrammed again
- * after next interrupt.
- */
-void omap_32k_timer_reprogram(unsigned long next_tick)
-{
-	unsigned long ticks = JIFFIES_TO_HW_TICKS(next_tick, 32768) + 1;
-	unsigned long now = omap_32k_sync_timer_read();
-	unsigned long idled = now - omap_32k_last_tick;
-
-	if (idled + 1 < ticks)
-		ticks -= idled;
-	else
-		ticks = 1;
-	omap_32k_timer_start(ticks);
-}
-
-static struct irqaction omap_32k_timer_irq;
-extern struct timer_update_handler timer_update;
-
-static int omap_32k_timer_enable_dyn_tick(void)
-{
-	/* No need to reprogram timer, just use the next interrupt */
-	return 0;
-}
-
-static int omap_32k_timer_disable_dyn_tick(void)
-{
-	omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
-	return 0;
-}
-
-static irqreturn_t omap_32k_timer_handler(int irq, void *dev_id)
-{
-	unsigned long now;
-
-	now = omap_32k_sync_timer_read();
-
-	/* Don't bother reprogramming timer if last tick was before next
-	 * jiffie. We will get another interrupt when previously programmed
-	 * timer expires. This cuts down interrupt load quite a bit.
-	 */
-	if (now - omap_32k_last_tick < OMAP_32K_TICKS_PER_HZ)
-		return IRQ_HANDLED;
-
-	return _omap_32k_timer_interrupt(irq, dev_id);
-}
-
-static struct dyn_tick_timer omap_dyn_tick_timer = {
-	.enable		= omap_32k_timer_enable_dyn_tick,
-	.disable	= omap_32k_timer_disable_dyn_tick,
-	.reprogram	= omap_32k_timer_reprogram,
-	.handler	= omap_32k_timer_handler,
-};
-#endif	/* CONFIG_NO_IDLE_HZ */
-
 static struct irqaction omap_32k_timer_irq = {
 	.name		= "32KHz timer",
 	.flags		= IRQF_DISABLED | IRQF_TIMER,
@@ -289,10 +241,6 @@ static struct irqaction omap_32k_timer_i
 
 static __init void omap_init_32k_timer(void)
 {
-#ifdef CONFIG_NO_IDLE_HZ
-	omap_timer.dyn_tick = &omap_dyn_tick_timer;
-#endif
-
 	if (cpu_class_is_omap1())
 		setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
 	omap_32k_last_tick = omap_32k_sync_timer_read();
@@ -312,6 +260,16 @@ static __init void omap_init_32k_timer(v
 #endif
 
 	omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
+
+	clockevent_32k_timer.mult = div_sc(OMAP_32K_TICKS_PER_SEC,
+					   NSEC_PER_SEC,
+					   clockevent_32k_timer.shift);
+	clockevent_32k_timer.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_32k_timer);
+	clockevent_32k_timer.min_delta_ns =
+		clockevent_delta2ns(1, &clockevent_32k_timer);
+
+	register_global_clockevent(&clockevent_32k_timer);
 }
 
 /*


--------------000706030402080207090704--
