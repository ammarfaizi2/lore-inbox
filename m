Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030415AbWGMVsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030415AbWGMVsV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 17:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030416AbWGMVsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 17:48:21 -0400
Received: from deeprooted.net ([216.254.16.51]:64407 "EHLO paris.internal.net")
	by vger.kernel.org with ESMTP id S1030415AbWGMVsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 17:48:20 -0400
Subject: Re: [PATCH] 2.6.17-rt add clockevent to ixp4xx
From: Kevin Hilman <khilman@deeprooted.net>
To: Milan Svoboda <msvoboda@ra.rockwell.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de
In-Reply-To: <44B62624.30908@ra.rockwell.com>
References: <44B62624.30908@ra.rockwell.com>
Content-Type: multipart/mixed; boundary="=-tg78+QU4gQU6BscLuEqA"
Organization: Deep Root Systems
Date: Thu, 13 Jul 2006 16:48:18 -0500
Message-Id: <1152827298.24456.35.camel@vence.internal.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tg78+QU4gQU6BscLuEqA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2006-07-13 at 10:53 +0000, Milan Svoboda wrote:

> there are patches that enable clock event on ixp4xx platform. This should
> enable high resolution timers... Option for hrtimers in menuconfig is 
> also enabled.

Milan,

I've also done a clockevent driver for ixp4xx and it looks pretty much
like yours.  I've been waiting to submit as Thomas has recently reworked
the clockevent layer a bit in his -hrt-dyntick patchset.

Here are a couple comments on your patchset

 - since you've registered the clockevent with CAP_TICK, both the 
arch interrupt handler and the clockevent handler are handling the tick
and calling do_timer().  While I don't think this will negatively affect
timekeeping, it's unncessary overhead.

 - why the addition of clockevent_hz2mult()? since shift is 32, you
could use existing div_sc32()

The attached patch is a combination of my patch and yours and addresses
my comments above.  I simply removed the CLOCK_CAP_TICK and removed your
clockevent_hz2mult() and used div_sc32().

Also, below are a few runs of the nanosleep_jitter test that comes with
the sourceforge HRT test suite.  Something strange is that with the
nanosleep_jitter test, I only see max sleeps of ~300-400 usec but with
your test I see max sleeps up to 1.3 msec.

Kevin

root@ixp425:/kjh# gcc -DCLOCK_REALTIME_HR=CLOCK_REALTIME
nanosleep_jitter.c -lposixtime
root@ixp425:/kjh# ./a.out
Doing 10 iterations of sleeping for 50 micro seconds 1000 times
Total time for each iteration should be 0.050000 seconds.
Iteration iter time (secs)           min sleep max sleep
  0        0.075580  0.075575 0.000075    0.000084
  1        0.075526  0.075521 0.000074    0.000082
  2        0.075529  0.075525 0.000074    0.000082
  3        0.075518  0.075514 0.000074    0.000082
  4        0.075526  0.075521 0.000075    0.000082
  5        0.075525  0.075521 0.000074    0.000082
  6        0.075526  0.075521 0.000074    0.000082
  7        0.075519  0.075514 0.000074    0.000082
  8        0.075526  0.075522 0.000075    0.000082
  9        0.244572  0.244564 0.000074    0.000316
root@ixp425:/kjh# ./a.out
Doing 10 iterations of sleeping for 50 micro seconds 1000 times
Total time for each iteration should be 0.050000 seconds.
Iteration iter time (secs)           min sleep max sleep
  0        0.075644  0.075639 0.000075    0.000083
  1        0.075527  0.075523 0.000075    0.000082
  2        0.075518  0.075514 0.000074    0.000082
  3        0.075525  0.075521 0.000075    0.000082
  4        0.075530  0.075525 0.000074    0.000082
  5        0.075526  0.075521 0.000074    0.000082
  6        0.075518  0.075514 0.000074    0.000082
  7        0.075526  0.075521 0.000075    0.000082
  8        0.075526  0.075521 0.000074    0.000082
  9        0.147196  0.147187 0.000074    0.000311
root@ixp425:/kjh# ./a.out
Doing 10 iterations of sleeping for 50 micro seconds 1000 times
Total time for each iteration should be 0.050000 seconds.
Iteration iter time (secs)           min sleep max sleep
  0        0.075588  0.075583 0.000075    0.000084
  1        0.075534  0.075529 0.000074    0.000082
  2        0.075537  0.075533 0.000074    0.000082
  3        0.075526  0.075522 0.000074    0.000082
  4        0.075533  0.075529 0.000075    0.000082
  5        0.075533  0.075529 0.000074    0.000082
  6        0.075594  0.075589 0.000074    0.000083
  7        0.075540  0.075535 0.000074    0.000086
  8        0.075539  0.075534 0.000075    0.000084
  9        0.075527  0.075522 0.000074    0.000083
root@ixp425:/kjh#





--=-tg78+QU4gQU6BscLuEqA
Content-Disposition: attachment; filename=arm-ixp4xx-clockevent2.patch
Content-Type: text/x-patch; name=arm-ixp4xx-clockevent2.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

ARM: Add HRT clockevent support for IXP4xx platform

Signed-off-by: Milan Svoboda <msvoboda@ra.rockwell.com>
Signed-off-by: Kevin Hilman <khilman@deeprooted.net>

Index: ixp4xx/arch/arm/mach-ixp4xx/common.c
===================================================================
--- ixp4xx.orig/arch/arm/mach-ixp4xx/common.c
+++ ixp4xx/arch/arm/mach-ixp4xx/common.c
@@ -28,6 +28,7 @@
 #include <linux/time.h>
 #include <linux/timex.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/hardware.h>
 #include <asm/uaccess.h>
@@ -256,15 +257,31 @@ void __init ixp4xx_init_irq(void)
 
 static unsigned volatile last_jiffy_time;
 
-#define CLOCK_TICKS_PER_USEC	((CLOCK_TICK_RATE + USEC_PER_SEC/2) / USEC_PER_SEC)
+#ifdef CONFIG_HIGH_RES_TIMERS
+static void ixp4xx_set_next_event(unsigned long evt, void *priv)
+{
+	*IXP4XX_OSRT1 = (evt & ~IXP4XX_OST_RELOAD_MASK) | IXP4XX_OST_ENABLE;
+}
+
+static struct clock_event clockevent_ixp4xx = {
+	.name		= "OSTS clock event interface",
+	.capabilities	= CLOCK_CAP_NEXTEVT |  CLOCK_HAS_IRQHANDLER,
+	.shift		= 32,
+	.set_next_event	= ixp4xx_set_next_event,
+};
+#endif
 
 static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	write_seqlock(&xtime_lock);
-
 	/* Clear Pending Interrupt by writing '1' to it */
 	*IXP4XX_OSST = IXP4XX_OSST_TIMER_1_PEND;
 
+#ifdef CONFIG_HIGH_RES_TIMERS
+	if (clockevent_ixp4xx.event_handler)
+		clockevent_ixp4xx.event_handler(regs, NULL);
+#endif
+	write_seqlock(&xtime_lock);
+
 	/*
 	 * Catch up with the real idea of time
 	 */
@@ -404,7 +421,7 @@ static struct clocksource clocksource_ix
 	.rating		= 200,
 	.read		= ixp4xx_get_cycles,
 	.mask		= 0xFFFFFFFF,
-	.shift 		= 10,
+	.shift 		= 20,
 	.is_continuous 	= 1,
 };
 
@@ -419,5 +436,19 @@ static int __init ixp4xx_clocksource_ini
 
 	return 0;
 }
-
 device_initcall(ixp4xx_clocksource_init);
+
+#ifdef CONFIG_HIGH_RES_TIMERS
+static int __init ixp4xx_clockevent_init(void)
+{
+	clockevent_ixp4xx.mult = div_sc32(FREQ, NSEC_PER_SEC);
+	clockevent_ixp4xx.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_ixp4xx);
+	clockevent_ixp4xx.min_delta_ns =
+		clockevent_delta2ns(0xf, &clockevent_ixp4xx);
+	setup_local_clockevent(&clockevent_ixp4xx, CPU_MASK_NONE);
+
+	return 0;
+}
+device_initcall(ixp4xx_clockevent_init);
+#endif

--=-tg78+QU4gQU6BscLuEqA--

