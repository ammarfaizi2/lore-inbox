Return-Path: <linux-kernel-owner+w=401wt.eu-S932778AbWLZUz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932778AbWLZUz0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 26 Dec 2006 15:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932782AbWLZUz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Dec 2006 15:55:26 -0500
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:29364 "HELO
	smtp103.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932778AbWLZUzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Dec 2006 15:55:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:Received:Date:From:To:Subject:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=k1HxkeblcW1uVvxSma1C3a2ireJr49TCRNpuNEkkhP6rWsUQ2MzPrTmn2vv3WA5SWkBa+73qeZlTiIjqDdBN8UmJZNDa410M0EKBHExDsBUCebVwBorQ/PMxtIvnCj56jpvBLEPc4iVU9Hx6iq31aZ/R0WeXGgCRh8f3zbxup2Q=  ;
X-YMail-OSG: JJ4ic6YVM1mwKPxbP3J8Cf8rDLec..yZcYnpYV0FEY.MuCHkaGV48sd6niJSHqrPtX5G5DezQWoefqqvmf6zGrGt.zGiLeHIjGNkTlZLqlYPaUegnmQxSg--
Date: Tue, 26 Dec 2006 12:55:22 -0800
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.20-rc2] ARM: AT91: clocksource for at91rm9200
Cc: steven.scholz@imc-berlin.de, tglx@linutronix.de, andrew@sanpeople.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20061226205523.039E31F9B43@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define a clocksource for the at91rm9200, switching it to use GENERIC_TIME.
(No clockevent support; this is against 2.6.20-rc code.)

Also, slightly streamline reads of the 32KHz counter; if we hit the update
window, we can now use 3 reads not 4.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
We've been asked to forward stuff to LKML not ARM or RT lists, so ...

 arch/arm/mach-at91rm9200/Kconfig           |    1 
 arch/arm/mach-at91rm9200/at91rm9200_time.c |   47 ++++++++++++++++-------------
 2 files changed, 28 insertions(+), 20 deletions(-)

NOTE: at91sam926x chips need other solutions.  The sam9263 will have two
RTTs; one could work like this 32K timer and the other can be the system's
battery-backed RTC.  Otherwise the best bet may be the counter/timer module,
currently not usable from mainstream Linux patchsets.  If the board doesn't 
need one module for external interfacing, two 16-bit timers can chain to be
a clocksource (I have example code) and the third could issue clockevents
with the same precision (base is multi-MHz vs 32K).

Index: at91/arch/arm/mach-at91rm9200/Kconfig
===================================================================
--- at91.orig/arch/arm/mach-at91rm9200/Kconfig	2006-12-26 12:15:56.000000000 -0800
+++ at91/arch/arm/mach-at91rm9200/Kconfig	2006-12-26 12:16:04.000000000 -0800
@@ -7,6 +7,7 @@ choice
 
 config ARCH_AT91RM9200
 	bool "AT91RM9200"
+	select GENERIC_TIME
 
 config ARCH_AT91SAM9260
 	bool "AT91SAM9260"
Index: at91/arch/arm/mach-at91rm9200/at91rm9200_time.c
===================================================================
--- at91.orig/arch/arm/mach-at91rm9200/at91rm9200_time.c	2006-12-26 12:07:36.000000000 -0800
+++ at91/arch/arm/mach-at91rm9200/at91rm9200_time.c	2006-12-26 12:16:04.000000000 -0800
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/time.h>
+#include <linux/clocksource.h>
 
 #include <asm/hardware.h>
 #include <asm/io.h>
@@ -38,33 +39,22 @@ static unsigned long last_crtr;
  * The ST_CRTR is updated asynchronously to the master clock.  It is therefore
  *  necessary to read it twice (with the same value) to ensure accuracy.
  */
-static inline unsigned long read_CRTR(void) {
+static inline unsigned long read_CRTR(void)
+{
 	unsigned long x1, x2;
 
-	do {
-		x1 = at91_sys_read(AT91_ST_CRTR);
+	x1 = at91_sys_read(AT91_ST_CRTR);
+	for (;;) {
 		x2 = at91_sys_read(AT91_ST_CRTR);
-	} while (x1 != x2);
+		if (x1 == x2)
+			break;
+		x1 = x2;
+	};
 
 	return x1;
 }
 
 /*
- * Returns number of microseconds since last timer interrupt.  Note that interrupts
- * will have been disabled by do_gettimeofday()
- *  'LATCH' is hwclock ticks (see CLOCK_TICK_RATE in timex.h) per jiffy.
- *  'tick' is usecs per jiffy (linux/timex.h).
- */
-static unsigned long at91rm9200_gettimeoffset(void)
-{
-	unsigned long elapsed;
-
-	elapsed = (read_CRTR() - last_crtr) & AT91_ST_ALMV;
-
-	return (unsigned long)(elapsed * (tick_nsec / 1000)) / LATCH;
-}
-
-/*
  * IRQ handler for the timer.
  */
 static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id)
@@ -91,6 +81,20 @@ static struct irqaction at91rm9200_timer
 	.handler	= at91rm9200_timer_interrupt
 };
 
+static cycle_t read_clk32k(void)
+{
+	return read_CRTR();
+}
+
+static struct clocksource clk32k = {
+	.name		= "32k_counter",
+	.rating		= 200,
+	.read		= read_clk32k,
+	.mask		= CLOCKSOURCE_MASK(20),
+	.shift		= 10,
+	.is_continuous	= 1,
+};
+
 void at91rm9200_timer_reset(void)
 {
 	last_crtr = 0;
@@ -125,6 +129,10 @@ void __init at91rm9200_timer_init(void)
 
 	/* Initialize and enable the timer interrupt */
 	at91rm9200_timer_reset();
+
+	/* register clocksource */
+	clk32k.mult = clocksource_hz2mult(32768, clk32k.shift);
+	clocksource_register(&clk32k);
 }
 
 #ifdef CONFIG_PM
@@ -139,7 +147,6 @@ static void at91rm9200_timer_suspend(voi
 
 struct sys_timer at91rm9200_timer = {
 	.init		= at91rm9200_timer_init,
-	.offset		= at91rm9200_gettimeoffset,
 	.suspend	= at91rm9200_timer_suspend,
 	.resume		= at91rm9200_timer_reset,
 };
