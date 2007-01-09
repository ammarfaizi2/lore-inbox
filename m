Return-Path: <linux-kernel-owner+w=401wt.eu-S1751266AbXAIKNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbXAIKNM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbXAIKNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:13:12 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:56561 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751266AbXAIKNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:13:09 -0500
Message-Id: <20070109101306.898321000@localhost.localdomain>
References: <20070109100957.259649000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 09 Jan 2007 11:09:58 +0100
From: s.hauer@pengutronix.de
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@elte.hu, Luotao Fu <lfu@pengutronix.de>,
       Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [patch 1/3] clockevent driver for arm/imx
Content-Disposition: inline; filename=clockevents-driver-for-arm-imx.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clockevent driver for i.MX systems.

Signed-off-by: Luotao Fu <lfu@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

---
 arch/arm/mach-imx/time.c |   71 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 59 insertions(+), 12 deletions(-)

Index: arch/arm/mach-imx/time.c
===================================================================
--- a/arch/arm/mach-imx/time.c.orig
+++ b/arch/arm/mach-imx/time.c
@@ -15,6 +15,7 @@
 #include <linux/irq.h>
 #include <linux/time.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -25,7 +26,52 @@
 /* Use timer 1 as system timer */
 #define TIMER_BASE IMX_TIM1_BASE
 
-static unsigned long evt_diff;
+enum clock_event_mode clockevent_mode = 0;
+
+static void imx_set_next_event(unsigned long evt,
+			       struct clock_event_device *unused)
+{
+	IMX_TCMP(IMX_TIM1_BASE) = IMX_TCN(IMX_TIM1_BASE) + evt;
+}
+
+static void imx_set_mode(enum clock_event_mode mode,
+			 struct clock_event_device *evt)
+{
+	switch (mode) {
+	case CLOCK_EVT_PERIODIC:
+	case CLOCK_EVT_ONESHOT:
+		IMX_TCTL(TIMER_BASE) |= TCTL_IRQEN;
+		break;
+
+	case CLOCK_EVT_SHUTDOWN:
+		IMX_TCTL(TIMER_BASE) &= ~TCTL_IRQEN;
+		return;
+	}
+
+	clockevent_mode = mode;
+}
+
+static struct clock_event_device clockevent_imx = {
+	.name		= "imx_timer1",
+	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
+			  CLOCK_CAP_UPDATE | CLOCK_CAP_PROFILE,
+	.shift		= 32,
+	.set_mode	= imx_set_mode,
+	.set_next_event	= imx_set_next_event,
+};
+
+static int __init imx_clockevent_init(void)
+{
+	clockevent_imx.mult = div_sc(imx_get_perclk1(), NSEC_PER_SEC,
+					clockevent_imx.shift);
+	clockevent_imx.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_imx);
+	clockevent_imx.min_delta_ns =
+		clockevent_delta2ns(0xf, &clockevent_imx);
+	register_local_clockevent(&clockevent_imx);
+
+	return 0;
+}
 
 /*
  * IRQ handler for the timer
@@ -42,10 +88,12 @@ imx_timer_interrupt(int irq, void *dev_i
 	if (tstat & TSTAT_COMP) {
 		do {
 
-			write_seqlock(&xtime_lock);
-			timer_tick();
-			write_sequnlock(&xtime_lock);
-			IMX_TCMP(TIMER_BASE) += evt_diff;
+			clockevent_imx.event_handler();
+
+			if (clockevent_mode != CLOCK_EVT_PERIODIC)
+				break;
+
+			IMX_TCMP(TIMER_BASE) += LATCH;
 
 		} while (unlikely((int32_t)(IMX_TCMP(TIMER_BASE)
 					- IMX_TCN(TIMER_BASE)) < 0));
@@ -70,10 +118,8 @@ static void __init imx_timer_hardware_in
 	 */
 	IMX_TCTL(TIMER_BASE) = 0;
 	IMX_TPRER(TIMER_BASE) = 0;
-	IMX_TCMP(TIMER_BASE) = LATCH - 1;
-
-	IMX_TCTL(TIMER_BASE) = TCTL_FRR | TCTL_CLK_PCLK1 | TCTL_IRQEN | TCTL_TEN;
-	evt_diff = LATCH;
+	IMX_TCMP(TIMER_BASE) = LATCH;
+	IMX_TCTL(TIMER_BASE) = TCTL_FRR | TCTL_CLK_PCLK1 | TCTL_TEN | TCTL_IRQEN;
 }
 
 cycle_t imx_get_cycles(void)
@@ -82,12 +128,12 @@ cycle_t imx_get_cycles(void)
 }
 
 static struct clocksource clocksource_imx = {
-	.name 		= "imx_timer1",
+	.name		= "imx_timer1",
 	.rating		= 200,
 	.read		= imx_get_cycles,
 	.mask		= 0xFFFFFFFF,
-	.shift 		= 20,
-	.is_continuous 	= 1,
+	.shift		= 20,
+	.is_continuous	= 1,
 };
 
 static int __init imx_clocksource_init(void)
@@ -103,6 +149,7 @@ static void __init imx_timer_init(void)
 {
 	imx_timer_hardware_init();
 	imx_clocksource_init();
+	imx_clockevent_init();
 
 	/*
 	 * Make irqs happen for the system timer

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
