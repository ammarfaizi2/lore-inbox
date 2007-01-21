Return-Path: <linux-kernel-owner+w=401wt.eu-S1750937AbXAUABr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbXAUABr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 19:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbXAUABr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 19:01:47 -0500
Received: from av2.karneval.cz ([81.27.192.122]:40353 "EHLO av2.karneval.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbXAUABq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 19:01:46 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH query] arm: i.MX/MX1 clock event source
Date: Sun, 21 Jan 2007 01:01:26 +0100
User-Agent: KMail/1.9.4
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Sascha Hauer <s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701210101.27345.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas, Sascha and Ingo

please can you find some time to review next patch
  arm: i.MX/MX1 clock event source
which has been sent to you and to the ALKML at 2007-01-13.

http://thread.gmane.org/gmane.linux.ports.arm.kernel/29510/focus=29533

There seems to be some problems, because this patch has not been
accepted to patch-2.6.20-rc5-rt7.patch, but GENERIC_CLOCKEVENTS
are set already for i.MX and this results in a problems to run
RT kernel on this architecture.

 config ARCH_IMX
        bool "IMX"
+       select GENERIC_TIME
+       select GENERIC_CLOCKEVENTS


Thanks for review and your time

                Pavel

-------------------------------------------------------------------------------------
Subject: arm: i.MX/MX1 clock event source

Support clock event source based on i.MX general purpose
timer in free running timer mode.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>


 arch/arm/mach-imx/time.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

Index: linux-2.6.20-rc4/arch/arm/mach-imx/time.c
===================================================================
--- linux-2.6.20-rc4.orig/arch/arm/mach-imx/time.c
+++ linux-2.6.20-rc4/arch/arm/mach-imx/time.c
@@ -15,6 +15,9 @@
 #include <linux/irq.h>
 #include <linux/time.h>
 #include <linux/clocksource.h>
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+#include <linux/clockchips.h>
+#endif
 
 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -25,6 +28,11 @@
 /* Use timer 1 as system timer */
 #define TIMER_BASE IMX_TIM1_BASE
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+static struct clock_event_device clockevent_imx;
+static enum clock_event_mode clockevent_mode = CLOCK_EVT_PERIODIC;
+#endif
+
 static unsigned long evt_diff;
 
 /*
@@ -42,9 +50,16 @@ imx_timer_interrupt(int irq, void *dev_i
 	if (tstat & TSTAT_COMP) {
 		do {
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+			if (clockevent_imx.event_handler)
+				clockevent_imx.event_handler();
+			if  (likely(clockevent_mode != CLOCK_EVT_PERIODIC))
+				break;
+#else
 			write_seqlock(&xtime_lock);
 			timer_tick();
 			write_sequnlock(&xtime_lock);
+#endif
 			IMX_TCMP(TIMER_BASE) += evt_diff;
 
 		} while (unlikely((int32_t)(IMX_TCMP(TIMER_BASE)
@@ -99,11 +114,88 @@ static int __init imx_clocksource_init(v
 	return 0;
 }
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+
+static void imx_set_next_event(unsigned long evt,
+				  struct clock_event_device *unused)
+{
+	evt_diff = evt;
+	IMX_TCMP(TIMER_BASE) = IMX_TCN(TIMER_BASE) + evt;
+}
+
+static void imx_set_mode(enum clock_event_mode mode, struct clock_event_device *evt)
+{
+	unsigned long flags;
+
+	/*
+	 * The timer interrupt generation is disabled at least
+	 * for enough time to call imx_set_next_event()
+	 */
+	local_irq_save(flags);
+	/* Disable interrupt in GPT module */
+	IMX_TCTL(TIMER_BASE) &= ~TCTL_IRQEN;
+	if ((mode != CLOCK_EVT_PERIODIC) || (mode != clockevent_mode)) {
+		/* Set event time into far-far future */
+		IMX_TCMP(TIMER_BASE) = IMX_TCN(TIMER_BASE) - 3;
+		/* Clear pending interrupt */
+		IMX_TSTAT(TIMER_BASE) &= ~TSTAT_COMP;
+	}
+	/* Remember timer mode */
+	clockevent_mode = mode;
+	local_irq_restore(flags);
+
+	switch (mode) {
+	case CLOCK_EVT_PERIODIC:
+	case CLOCK_EVT_ONESHOT:
+		/*
+		 * Do not put overhead of interrupt enable/disable into
+		 * imx_set_next_event(), the core has about 4 minutes
+		 * to call imx_set_next_event() or shutdown clock after
+		 * mode switching
+		 */
+		local_irq_save(flags);
+		IMX_TCTL(TIMER_BASE) |= TCTL_IRQEN;
+		local_irq_restore(flags);
+		break;
+	case CLOCK_EVT_SHUTDOWN:
+		/* Left event sources disabled, no more interrupts appears */
+		break;
+	}
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
+#endif
+
+
 static void __init imx_timer_init(void)
 {
 	imx_timer_hardware_init();
 	imx_clocksource_init();
 
+#ifdef CONFIG_GENERIC_CLOCKEVENTS
+	imx_clockevent_init();
+#endif
+
 	/*
 	 * Make irqs happen for the system timer
 	 */

