Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750718AbWFEWmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWFEWmU (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 18:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWFEWmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 18:42:19 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:20900 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750718AbWFEWl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 18:41:57 -0400
Message-Id: <20060605224438.617881000@localhost.localdomain>
References: <20060605222956.608067000@localhost.localdomain>
Date: Mon, 05 Jun 2006 15:29:58 -0700
From: dsaxena@plexity.net
To: mingo@elte.hu, tglx@linutronix.de, johnstul@us.ibm.com
Cc: dwalker@mvista.com, james.perkins@windriver.com,
        linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk, khilman@mvista.com,
        Deepak Saxena <dsaxena@plexity.net>
Subject: [patch-rt 2/2] Add clocksource driver for Versatile board
Content-Disposition: inline; filename=arm-versatile-hrt.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a clocksource driver for the ARM versatile board,
allowing it to use the generic time-of-day code.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>


Index: linux-2.6-rt/arch/arm/mach-versatile/core.c
===================================================================
--- linux-2.6-rt.orig/arch/arm/mach-versatile/core.c
+++ linux-2.6-rt/arch/arm/mach-versatile/core.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/amba/bus.h>
 #include <linux/amba/clcd.h>
+#include <linux/clockchips.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -815,46 +816,6 @@ void __init versatile_init(void)
 #endif
 
 /*
- * Returns number of ms since last clock interrupt.  Note that interrupts
- * will have been disabled by do_gettimeoffset()
- */
-static unsigned long versatile_gettimeoffset(void)
-{
-	unsigned long ticks1, ticks2, status;
-
-	/*
-	 * Get the current number of ticks.  Note that there is a race
-	 * condition between us reading the timer and checking for
-	 * an interrupt.  We get around this by ensuring that the
-	 * counter has not reloaded between our two reads.
-	 */
-	ticks2 = readl(TIMER0_VA_BASE + TIMER_VALUE) & 0xffff;
-	do {
-		ticks1 = ticks2;
-		status = __raw_readl(VA_IC_BASE + VIC_RAW_STATUS);
-		ticks2 = readl(TIMER0_VA_BASE + TIMER_VALUE) & 0xffff;
-	} while (ticks2 > ticks1);
-
-	/*
-	 * Number of ticks since last interrupt.
-	 */
-	ticks1 = TIMER_RELOAD - ticks2;
-
-	/*
-	 * Interrupt pending?  If so, we've reloaded once already.
-	 *
-	 * FIXME: Need to check this is effectively timer 0 that expires
-	 */
-	if (status & IRQMASK_TIMERINT0_1)
-		ticks1 += TIMER_RELOAD;
-
-	/*
-	 * Convert the ticks to usecs
-	 */
-	return TICKS2USECS(ticks1);
-}
-
-/*
  * IRQ handler for the timer
  */
 static irqreturn_t versatile_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
@@ -917,5 +878,36 @@ static void __init versatile_timer_init(
 
 struct sys_timer versatile_timer = {
 	.init		= versatile_timer_init,
-	.offset		= versatile_gettimeoffset,
 };
+
+cycle_t versatile_get_cycles(void)
+{
+	return ~readl(TIMER3_VA_BASE + TIMER_VALUE);
+}
+
+static struct clocksource clocksource_versatile = {
+	.name 		= "timer3",
+	.rating		= 200,
+	.read		= versatile_get_cycles,
+	.mask		= 0xFFFFFFFF,
+	.shift 		= 10,
+	.is_continuous 	= 1,
+};
+
+static int __init versatile_clocksource_init(void)
+{
+	writel(0, TIMER3_VA_BASE + TIMER_CTRL);
+	writel(0xffffffff, TIMER3_VA_BASE + TIMER_LOAD);
+	writel(0xffffffff, TIMER3_VA_BASE + TIMER_VALUE);
+	writel(TIMER_CTRL_32BIT | TIMER_CTRL_ENABLE | TIMER_CTRL_PERIODIC,
+	       TIMER3_VA_BASE + TIMER_CTRL);
+
+	clocksource_versatile.mult =
+		clocksource_khz2mult(1000, clocksource_versatile.shift);
+	register_clocksource(&clocksource_versatile);
+
+	return 0;
+}
+
+device_initcall(versatile_clocksource_init);
+

--
Deepak Saxena - dsaxena@plexity.net - http://www.plexity.net

In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertold Brecht
