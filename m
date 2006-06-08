Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWFHS1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWFHS1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 14:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWFHS1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 14:27:12 -0400
Received: from deeprooted.net ([216.254.16.51]:12723 "EHLO paris.internal.net")
	by vger.kernel.org with ESMTP id S964860AbWFHS1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 14:27:10 -0400
Subject: Re: 2.6.17-rc6-rt1
From: Kevin Hilman <khilman@deeprooted.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>, Deepak Saxena <dsaxena@plexity.net>
In-Reply-To: <20060607211455.GA6132@elte.hu>
References: <20060607211455.GA6132@elte.hu>
Content-Type: multipart/mixed; boundary="=-rLB9s+ulyGe5BEQhQhjb"
Organization: Deep Root Systems
Date: Thu, 08 Jun 2006 11:27:09 -0700
Message-Id: <1149791229.6348.19.camel@vence.internal.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rLB9s+ulyGe5BEQhQhjb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-06-07 at 23:14 +0200, Ingo Molnar wrote:
> i have released the 2.6.17-rc6-rt1 tree, which can be downloaded from 
> the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/

Here's a couple of fixes/updates:

1) Fix for arm-generic-timeofday.patch which doesn't compile against
2.6.17-rc6

2) Add clocksource for arch/arm/mach-ixp4xx

Also, I notice both asm-arm/timeofday.h and asm-ia64/timeofday.h simply
include asm-generic/timeofday.h which doesn't exist.  Should the former
be removed also?

Kevin 



--=-rLB9s+ulyGe5BEQhQhjb
Content-Disposition: attachment; filename=arm-generic-timeofday-fixups.patch
Content-Type: text/x-patch; name=arm-generic-timeofday-fixups.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: ixp4xx/arch/arm/kernel/time.c
===================================================================
--- ixp4xx.orig/arch/arm/kernel/time.c
+++ ixp4xx/arch/arm/kernel/time.c
@@ -28,7 +28,6 @@
 #include <linux/profile.h>
 #include <linux/sysdev.h>
 #include <linux/timer.h>
-#include <linux/timeofday.h>
 
 #include <asm/leds.h>
 #include <asm/thread_info.h>

--=-rLB9s+ulyGe5BEQhQhjb
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
@@ -256,16 +257,6 @@ static unsigned volatile last_jiffy_time
 
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
@@ -300,8 +291,6 @@ static void __init ixp4xx_timer_init(voi
 	/* Setup the Timer counter value */
 	*IXP4XX_OSRT1 = (LATCH & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE;
 
-	/* Reset time-stamp counter */
-	*IXP4XX_OSTS = 0;
 	last_jiffy_time = 0;
 
 	/* Connect the interrupt handler and enable the interrupt */
@@ -310,7 +299,6 @@ static void __init ixp4xx_timer_init(voi
 
 struct sys_timer ixp4xx_timer = {
 	.init		= ixp4xx_timer_init,
-	.offset		= ixp4xx_gettimeoffset,
 };
 
 static struct resource ixp46x_i2c_resources[] = {
@@ -366,3 +354,30 @@ void __init ixp4xx_sys_init(void)
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
+	clocksource_register(&clocksource_ixp4xx);
+
+	return 0;
+}
+
+device_initcall(ixp4xx_clocksource_init);

--=-rLB9s+ulyGe5BEQhQhjb--

