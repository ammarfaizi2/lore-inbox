Return-Path: <linux-kernel-owner+w=401wt.eu-S1751270AbXAIKNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbXAIKNl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbXAIKNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:13:14 -0500
Received: from metis.extern.pengutronix.de ([83.236.181.26]:56563 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751267AbXAIKNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:13:09 -0500
Message-Id: <20070109101307.192369000@localhost.localdomain>
References: <20070109100957.259649000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 09 Jan 2007 11:09:59 +0100
From: s.hauer@pengutronix.de
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@elte.hu, Luotao Fu <lfu@pengutronix.de>,
       Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [patch 2/3] clockevent driver for arm/netx
Content-Disposition: inline; filename=clockevents-driver-for-arm-netx.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clockevent driver for netx systems

Signed-off-by: Luotao Fu <lfu@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

---
 arch/arm/mach-netx/time.c |   80 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 16 deletions(-)

Index: arch/arm/mach-netx/time.c
===================================================================
--- a/arch/arm/mach-netx/time.c.orig
+++ b/arch/arm/mach-netx/time.c
@@ -21,27 +21,65 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
 #include <asm/mach/time.h>
 #include <asm/arch/netx-regs.h>
 
+static void netx_set_next_event(unsigned long evt,
+				  struct clock_event_device *unused)
+{
+	writel(0 - evt, NETX_GPIO_COUNTER_CURRENT(0));
+}
+
+static void netx_set_mode(enum clock_event_mode mode,
+			  struct clock_event_device *evt)
+{
+	u32 tmode = NETX_GPIO_COUNTER_CTRL_IRQ_EN | NETX_GPIO_COUNTER_CTRL_RUN;
+
+	/* disable timer */
+	writel( 0, NETX_GPIO_COUNTER_CTRL(0));
+
+	switch(mode) {
+	case CLOCK_EVT_PERIODIC:
+		/* Set timer period  */
+		writel(LATCH, NETX_GPIO_COUNTER_MAX(0));
+		tmode |= NETX_GPIO_COUNTER_CTRL_RST_EN;
+		break;
+
+	case CLOCK_EVT_ONESHOT:
+		writel(0, NETX_GPIO_COUNTER_MAX(0));
+		break;
+
+	case CLOCK_EVT_SHUTDOWN:
+		return;
+	}
+
+	writel(tmode, NETX_GPIO_COUNTER_CTRL(0));
+}
+
+static struct clock_event_device clockevent_netx = {
+	.name		= "netx_timer1",
+	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
+			  CLOCK_CAP_UPDATE | CLOCK_CAP_PROFILE,
+	.shift		= 32,
+	.set_mode	= netx_set_mode,
+	.set_next_event	= netx_set_next_event,
+};
+
 /*
  * IRQ handler for the timer
  */
 static irqreturn_t
 netx_timer_interrupt(int irq, void *dev_id)
 {
-	write_seqlock(&xtime_lock);
-
-	timer_tick();
-
-	write_sequnlock(&xtime_lock);
-
 	/* acknowledge interrupt */
 	writel(COUNTER_BIT(0), NETX_GPIO_IRQ);
 
+	clockevent_netx.event_handler();
+
 	return IRQ_HANDLED;
 }
 
@@ -57,12 +95,12 @@ cycle_t netx_get_cycles(void)
 }
 
 static struct clocksource clocksource_netx = {
-	.name 		= "netx_timer",
+	.name		= "netx_timer",
 	.rating		= 200,
 	.read		= netx_get_cycles,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.shift 		= 20,
-	.is_continuous 	= 1,
+	.shift		= 20,
+	.is_continuous	= 1,
 };
 
 /*
@@ -81,24 +119,34 @@ static void __init netx_timer_init(void)
 	/* acknowledge interrupt */
 	writel(COUNTER_BIT(0), NETX_GPIO_IRQ);
 
-	/* Enable the interrupt in the specific timer register and start timer */
+	/* Enable the interrupt in the specific timer register and
+	 * start timer
+	 */
 	writel(COUNTER_BIT(0), NETX_GPIO_IRQ_ENABLE);
 	writel(NETX_GPIO_COUNTER_CTRL_IRQ_EN | NETX_GPIO_COUNTER_CTRL_RUN,
-		NETX_GPIO_COUNTER_CTRL(0));
+	       NETX_GPIO_COUNTER_CTRL(0));
 
 	setup_irq(NETX_IRQ_TIMER0, &netx_timer_irq);
 
 	/* Setup timer one for clocksource */
-        writel(0, NETX_GPIO_COUNTER_CTRL(1));
-        writel(0, NETX_GPIO_COUNTER_CURRENT(1));
-        writel(0xFFFFFFFF, NETX_GPIO_COUNTER_MAX(1));
+	writel(0, NETX_GPIO_COUNTER_CTRL(1));
+	writel(0, NETX_GPIO_COUNTER_CURRENT(1));
+	writel(0xFFFFFFFF, NETX_GPIO_COUNTER_MAX(1));
 
-        writel(NETX_GPIO_COUNTER_CTRL_RUN,
-                NETX_GPIO_COUNTER_CTRL(1));
+	writel(NETX_GPIO_COUNTER_CTRL_RUN,
+	       NETX_GPIO_COUNTER_CTRL(1));
 
 	clocksource_netx.mult =
 		clocksource_hz2mult(CLOCK_TICK_RATE, clocksource_netx.shift);
 	clocksource_register(&clocksource_netx);
+
+	clockevent_netx.mult = div_sc(CLOCK_TICK_RATE, NSEC_PER_SEC,
+					clockevent_netx.shift);
+	clockevent_netx.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_netx);
+	clockevent_netx.min_delta_ns =
+		clockevent_delta2ns(0xf, &clockevent_netx);
+	register_local_clockevent(&clockevent_netx);
 }
 
 struct sys_timer netx_timer = {

--
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
