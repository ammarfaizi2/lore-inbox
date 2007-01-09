Return-Path: <linux-kernel-owner+w=401wt.eu-S1751271AbXAIKNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbXAIKNl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbXAIKNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:13:16 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:56565 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751269AbXAIKNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:13:10 -0500
Message-Id: <20070109101307.715996000@localhost.localdomain>
References: <20070109100957.259649000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 09 Jan 2007 11:10:00 +0100
From: s.hauer@pengutronix.de
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@elte.hu, Luotao Fu <lfu@pengutronix.de>,
       Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [patch 3/3] clockevent driver for arm/pxa2xx
Content-Disposition: inline; filename=clockevents-driver-for-arm-pxa.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clockevent driver for pxa systems. This patch also removes the pxa
dyntick support since it is not necessary anymore with generic dynamic
tick support

Signed-off-by: Luotao Fu <lfu@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

---
 arch/arm/mach-pxa/time.c |  106 ++++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 55 deletions(-)

Index: arch/arm/mach-pxa/time.c
===================================================================
--- a/arch/arm/mach-pxa/time.c.orig
+++ b/arch/arm/mach-pxa/time.c
@@ -19,6 +19,7 @@
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -29,6 +30,50 @@
 #include <asm/mach/time.h>
 #include <asm/arch/pxa-regs.h>
 
+static u32 clockevent_mode = 0;
+
+static void pxa_set_next_event(unsigned long evt,
+				  struct clock_event_device *unused)
+{
+	OSMR0 = OSCR + evt;
+}
+
+static void pxa_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
+{
+	switch (mode) {
+	case CLOCK_EVT_PERIODIC:
+	case CLOCK_EVT_ONESHOT:
+		OIER |= OIER_E0;
+		break;
+
+	case CLOCK_EVT_SHUTDOWN:
+		OIER &= ~OIER_E0;
+		return;
+	}
+	clockevent_mode = mode;
+}
+
+static struct clock_event_device clockevent_pxa = {
+	.name		= "pxa_timer1",
+	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
+			  CLOCK_CAP_UPDATE | CLOCK_CAP_PROFILE,
+	.shift		= 32,
+	.set_mode	= pxa_set_mode,
+	.set_next_event	= pxa_set_next_event,
+};
+
+static int __init pxa_clockevent_init(void)
+{
+	clockevent_pxa.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC,
+					clockevent_pxa.shift);
+	clockevent_pxa.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_pxa);
+	clockevent_pxa.min_delta_ns =
+		clockevent_delta2ns(0xf, &clockevent_pxa);
+	register_local_clockevent(&clockevent_pxa);
+
+	return 0;
+}
 
 static inline unsigned long pxa_get_rtc_time(void)
 {
@@ -49,25 +94,11 @@ static int pxa_set_rtc(void)
 	return 0;
 }
 
-#ifdef CONFIG_NO_IDLE_HZ
-static unsigned long initial_match;
-static int match_posponed;
-#endif
-
 static irqreturn_t
 pxa_timer_interrupt(int irq, void *dev_id)
 {
 	int next_match;
 
-	write_seqlock(&xtime_lock);
-
-#ifdef CONFIG_NO_IDLE_HZ
-	if (match_posponed) {
-		match_posponed = 0;
-		OSMR0 = initial_match;
-	}
-#endif
-
 	/* Loop until we get ahead of the free running timer.
 	 * This ensures an exact clock tick count and time accuracy.
 	 * Since IRQs are disabled at this point, coherence between
@@ -85,13 +116,15 @@ pxa_timer_interrupt(int irq, void *dev_i
 	 * exactly one tick period which should be a pretty rare event.
 	 */
 	do {
-		timer_tick();
+		clockevent_pxa.event_handler();
 		OSSR = OSSR_M0;  /* Clear match on timer 0 */
+
+		if (clockevent_mode != CLOCK_EVT_PERIODIC)
+			break;
+
 		next_match = (OSMR0 += LATCH);
 	} while( (signed long)(next_match - OSCR) <= 8 );
 
-	write_sequnlock(&xtime_lock);
-
 	return IRQ_HANDLED;
 }
 
@@ -141,44 +174,10 @@ static void __init pxa_timer_init(void)
 	clocksource_pxa.mult =
 		clocksource_hz2mult(CLOCK_TICK_RATE, clocksource_pxa.shift);
 	clocksource_register(&clocksource_pxa);
-}
-
-#ifdef CONFIG_NO_IDLE_HZ
-static int pxa_dyn_tick_enable_disable(void)
-{
-	/* nothing to do */
-	return 0;
-}
-
-static void pxa_dyn_tick_reprogram(unsigned long ticks)
-{
-	if (ticks > 1) {
-		initial_match = OSMR0;
-		OSMR0 = initial_match + ticks * LATCH;
-		match_posponed = 1;
-	}
-}
 
-static irqreturn_t
-pxa_dyn_tick_handler(int irq, void *dev_id)
-{
-	if (match_posponed) {
-		match_posponed = 0;
-		OSMR0 = initial_match;
-		if ( (signed long)(initial_match - OSCR) <= 8 )
-			return pxa_timer_interrupt(irq, dev_id);
-	}
-	return IRQ_NONE;
+	pxa_clockevent_init();
 }
 
-static struct dyn_tick_timer pxa_dyn_tick = {
-	.enable		= pxa_dyn_tick_enable_disable,
-	.disable	= pxa_dyn_tick_enable_disable,
-	.reprogram	= pxa_dyn_tick_reprogram,
-	.handler	= pxa_dyn_tick_handler,
-};
-#endif
-
 #ifdef CONFIG_PM
 static unsigned long osmr[4], oier;
 
@@ -213,7 +212,4 @@ struct sys_timer pxa_timer = {
 	.init		= pxa_timer_init,
 	.suspend	= pxa_timer_suspend,
 	.resume		= pxa_timer_resume,
-#ifdef CONFIG_NO_IDLE_HZ
-	.dyn_tick	= &pxa_dyn_tick,
-#endif
 };

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
