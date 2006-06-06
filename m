Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWFFUFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWFFUFU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 16:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWFFUFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 16:05:19 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:10234 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1750789AbWFFUFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 16:05:19 -0400
Subject: Re: [patch-rt 0/2] Initial ARM generic-timeofday support
From: Kevin Hilman <khilman@mvista.com>
To: dsaxena@plexity.net
Cc: mingo@elte.hu, tglx@linutronix.de, johnstul@us.ibm.com, dwalker@mvista.com,
       james.perkins@windriver.com, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
In-Reply-To: <20060605222956.608067000@localhost.localdomain>
References: <20060605222956.608067000@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-2kPVA4pvc8+2pGN4SMku"
Organization: MontaVista Software, Inc.
Date: Tue, 06 Jun 2006 13:05:16 -0700
Message-Id: <1149624316.29864.48.camel@vence.internal.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2kPVA4pvc8+2pGN4SMku
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-06-05 at 15:29 -0700, dsaxena@plexity.net wrote:
> patchset (against -rt26, but should apply to newer patch) adds
> initial support for generic TOD on ARM. It is fairly simple and
> copletely rips out the existing TOD code in ARM, assuming that each
> sub-arch will either provide a clocksource or enable CONFIG_IS_TICK_BASED.
> Currently only Versatile is supported.

And here's a patch on top of the ARM support which adds a clocksource
for the ixp4xx platform.

Kevin


--=-2kPVA4pvc8+2pGN4SMku
Content-Disposition: attachment; filename=arm-ixp4xx-clocksource.patch
Content-Type: text/x-patch; name=arm-ixp4xx-clocksource.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Add a clocksource driver for the Intel IXP4xx platform allowing it to
use the generic time-of-day code.

Signed-off-by: Kevin Hilman <khilman@deeprooted.net>

Index: ixp4xx/arch/arm/mach-ixp4xx/common.c
===================================================================
--- ixp4xx.orig/arch/arm/mach-ixp4xx/common.c
+++ ixp4xx/arch/arm/mach-ixp4xx/common.c
@@ -27,6 +27,7 @@
 #include <linux/bitops.h>
 #include <linux/time.h>
 #include <linux/timex.h>
+#include <linux/clocksource.h>
 
 #include <asm/hardware.h>
 #include <asm/uaccess.h>
@@ -253,16 +254,6 @@ static unsigned volatile last_jiffy_time
 
 #define CLOCK_TICKS_PER_USEC	((CLOCK_TICK_RATE + USEC_PER_SEC/2) / USEC_PER_SEC)
 
-/* IRQs are disabled before entering here from do_gettimeofday() */
-static unsigned long ixp4xx_gettimeoffset(void)
-{
-	u32 elapsed;
-
-	elapsed = *IXP4XX_OSTS - last_jiffy_time;
-
-	return elapsed / CLOCK_TICKS_PER_USEC;
-}
-
 static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	write_seqlock(&xtime_lock);
@@ -297,8 +288,6 @@ static void __init ixp4xx_timer_init(voi
 	/* Setup the Timer counter value */
 	*IXP4XX_OSRT1 = (LATCH & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE;
 
-	/* Reset time-stamp counter */
-	*IXP4XX_OSTS = 0;
 	last_jiffy_time = 0;
 
 	/* Connect the interrupt handler and enable the interrupt */
@@ -307,7 +296,6 @@ static void __init ixp4xx_timer_init(voi
 
 struct sys_timer ixp4xx_timer = {
 	.init		= ixp4xx_timer_init,
-	.offset		= ixp4xx_gettimeoffset,
 };
 
 static struct resource ixp46x_i2c_resources[] = {
@@ -363,3 +351,30 @@ void __init ixp4xx_sys_init(void)
 			ixp4xx_exp_bus_size >> 20);
 }
 
+cycle_t ixp4xx_get_cycles(void)
+{
+	return *IXP4XX_OSTS;
+}
+
+static struct clocksource clocksource_ixp4xx = {
+	.name 		= "OSTS",
+	.rating		= 200,
+	.read		= ixp4xx_get_cycles,
+	.mask		= 0xFFFFFFFF,
+	.shift 		= 10,
+	.is_continuous 	= 1,
+};
+
+static int __init ixp4xx_clocksource_init(void)
+{
+	/* Reset time-stamp counter */
+	*IXP4XX_OSTS = 0;
+
+	clocksource_ixp4xx.mult =
+		clocksource_khz2mult(66660, clocksource_ixp4xx.shift);
+	register_clocksource(&clocksource_ixp4xx);
+
+	return 0;
+}
+
+device_initcall(ixp4xx_clocksource_init);

--=-2kPVA4pvc8+2pGN4SMku--

