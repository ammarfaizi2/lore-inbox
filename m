Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946107AbWJSPTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946107AbWJSPTt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161453AbWJSPTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:19:49 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:58385 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1161452AbWJSPTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:19:44 -0400
Date: Thu, 19 Oct 2006 17:18:33 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/3] Remove gettimeoffset artefacts
In-Reply-To: <Pine.LNX.4.63.0610191640550.1920@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.63.0610191711540.1920@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0610191640550.1920@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove now unused gettimeoffset functions. The centrally called 
do_gettimeoffset() has disappeared, only a few arch-local users, which 
just use their internal specific functions.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

Signed-off-by: G. Liakhovetski <gl@dsa-ac.de>

diff -ur linux-2.6.18-rt6/arch/arm/common/time-acorn.c linux-2.6.18-rt6-rmdead/arch/arm/common/time-acorn.c
--- linux-2.6.18-rt6/arch/arm/common/time-acorn.c	2006-10-19 12:29:12.427094318 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/common/time-acorn.c	2006-10-19 14:29:12.059919944 +0200
@@ -24,41 +24,6 @@

  #include <asm/mach/time.h>

-unsigned long ioc_timer_gettimeoffset(void)
-{
-	unsigned int count1, count2, status;
-	long offset;
-
-	ioc_writeb (0, IOC_T0LATCH);
-	barrier ();
-	count1 = ioc_readb(IOC_T0CNTL) | (ioc_readb(IOC_T0CNTH) << 8);
-	barrier ();
-	status = ioc_readb(IOC_IRQREQA);
-	barrier ();
-	ioc_writeb (0, IOC_T0LATCH);
-	barrier ();
-	count2 = ioc_readb(IOC_T0CNTL) | (ioc_readb(IOC_T0CNTH) << 8);
-
-	offset = count2;
-	if (count2 < count1) {
-		/*
-		 * We have not had an interrupt between reading count1
-		 * and count2.
-		 */
-		if (status & (1 << 5))
-			offset -= LATCH;
-	} else if (count2 > count1) {
-		/*
-		 * We have just had another interrupt between reading
-		 * count1 and count2.
-		 */
-		offset -= LATCH;
-	}
-
-	offset = (LATCH - offset) * (tick_nsec / 1000);
-	return (offset + LATCH/2) / LATCH;
-}
-
  void __init ioctime_init(void)
  {
  	ioc_writeb(LATCH & 255, IOC_T0LTCHL);
@@ -92,6 +57,5 @@

  struct sys_timer ioc_timer = {
  	.init		= ioc_timer_init,
-	.offset		= ioc_timer_gettimeoffset,
  };

diff -ur linux-2.6.18-rt6/arch/arm/kernel/time.c linux-2.6.18-rt6-rmdead/arch/arm/kernel/time.c
--- linux-2.6.18-rt6/arch/arm/kernel/time.c	2006-10-19 12:29:12.431093450 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/kernel/time.c	2006-10-19 14:26:46.055617891 +0200
@@ -69,13 +69,6 @@
   */
  int (*set_rtc)(void);

-#ifdef CONFIG_IS_TICK_BASED
-static unsigned long dummy_gettimeoffset(void)
-{
-	return 0;
-}
-#endif
-
  /*
   * Scheduler clock - returns current time in nanosec units.
   * This is the default implementation.  Sub-architecture
@@ -415,10 +408,6 @@

  void __init time_init(void)
  {
-#ifdef CONFIG_IS_TICK_BASED
-	if (system_timer->offset == NULL)
-		system_timer->offset = dummy_gettimeoffset;
-#endif
  	system_timer->init();

  #ifdef CONFIG_NO_IDLE_HZ
diff -ur linux-2.6.18-rt6/arch/arm/mach-aaec2000/core.c linux-2.6.18-rt6-rmdead/arch/arm/mach-aaec2000/core.c
--- linux-2.6.18-rt6/arch/arm/mach-aaec2000/core.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-aaec2000/core.c	2006-10-19 15:07:23.693075170 +0200
@@ -108,23 +108,6 @@
  /*
   * Time keeping
   */
-/* IRQs are disabled before entering here from do_gettimeofday() */
-static unsigned long aaec2000_gettimeoffset(void)
-{
-	unsigned long ticks_to_match, elapsed, usec;
-
-	/* Get ticks before next timer match */
-	ticks_to_match = TIMER1_LOAD - TIMER1_VAL;
-
-	/* We need elapsed ticks since last match */
-	elapsed = LATCH - ticks_to_match;
-
-	/* Now, convert them to usec */
-	usec = (unsigned long)(elapsed * (tick_nsec / 1000))/LATCH;
-
-	return usec;
-}
-
  /* We enter here with IRQs enabled */
  static irqreturn_t
  aaec2000_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
@@ -166,7 +149,6 @@

  struct sys_timer aaec2000_timer = {
  	.init		= aaec2000_timer_init,
-	.offset		= aaec2000_gettimeoffset,
  };

  static struct clcd_panel mach_clcd_panel;
diff -ur linux-2.6.18-rt6/arch/arm/mach-at91rm9200/at91rm9200_time.c linux-2.6.18-rt6-rmdead/arch/arm/mach-at91rm9200/at91rm9200_time.c
--- linux-2.6.18-rt6/arch/arm/mach-at91rm9200/at91rm9200_time.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-at91rm9200/at91rm9200_time.c	2006-10-19 15:07:52.832737453 +0200
@@ -48,21 +48,6 @@
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
  static irqreturn_t at91rm9200_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
@@ -134,7 +119,6 @@

  struct sys_timer at91rm9200_timer = {
  	.init		= at91rm9200_timer_init,
-	.offset		= at91rm9200_gettimeoffset,
  	.suspend	= at91rm9200_timer_suspend,
  	.resume		= at91rm9200_timer_reset,
  };
diff -ur linux-2.6.18-rt6/arch/arm/mach-clps711x/time.c linux-2.6.18-rt6-rmdead/arch/arm/mach-clps711x/time.c
--- linux-2.6.18-rt6/arch/arm/mach-clps711x/time.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-clps711x/time.c	2006-10-19 14:43:49.398037996 +0200
@@ -32,19 +32,6 @@


  /*
- * gettimeoffset() returns time since last timer tick, in usecs.
- *
- * 'LATCH' is hwclock ticks (see CLOCK_TICK_RATE in timex.h) per jiffy.
- * 'tick' is usecs per jiffy.
- */
-static unsigned long clps711x_gettimeoffset(void)
-{
-	unsigned long hwticks;
-	hwticks = LATCH - (clps_readl(TC2D) & 0xffff);	/* since last underflow */
-	return (hwticks * (tick_nsec / 1000)) / LATCH;
-}
-
-/*
   * IRQ handler for the timer
   */
  static irqreturn_t
@@ -82,5 +69,4 @@

  struct sys_timer clps711x_timer = {
  	.init		= clps711x_timer_init,
-	.offset		= clps711x_gettimeoffset,
  };
diff -ur linux-2.6.18-rt6/arch/arm/mach-clps7500/core.c linux-2.6.18-rt6-rmdead/arch/arm/mach-clps7500/core.c
--- linux-2.6.18-rt6/arch/arm/mach-clps7500/core.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-clps7500/core.c	2006-10-19 14:44:12.426016118 +0200
@@ -289,7 +289,6 @@
  }

  extern void ioctime_init(void);
-extern unsigned long ioc_timer_gettimeoffset(void);

  static irqreturn_t
  clps7500_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
@@ -331,7 +330,6 @@

  static struct sys_timer clps7500_timer = {
  	.init		= clps7500_timer_init,
-	.offset		= ioc_timer_gettimeoffset,
  };

  static struct plat_serial8250_port serial_platform_data[] = {
diff -ur linux-2.6.18-rt6/arch/arm/mach-ebsa110/core.c linux-2.6.18-rt6-rmdead/arch/arm/mach-ebsa110/core.c
--- linux-2.6.18-rt6/arch/arm/mach-ebsa110/core.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-ebsa110/core.c	2006-10-19 15:18:09.346791108 +0200
@@ -142,37 +142,6 @@
   */
  #define COUNT	((CLKBY7 + (HZ / 2)) / HZ)

-/*
- * Get the time offset from the system PIT.  Note that if we have missed an
- * interrupt, then the PIT counter will roll over (ie, be negative).
- * This actually works out to be convenient.
- */
-static unsigned long ebsa110_gettimeoffset(void)
-{
-	unsigned long offset, count;
-
-	__raw_writeb(0x40, PIT_CTRL);
-	count = __raw_readb(PIT_T1);
-	count |= __raw_readb(PIT_T1) << 8;
-
-	/*
-	 * If count > COUNT, make the number negative.
-	 */
-	if (count > COUNT)
-		count |= 0xffff0000;
-
-	offset = COUNT;
-	offset -= count;
-
-	/*
-	 * `offset' is in units of timer counts.  Convert
-	 * offset to units of microseconds.
-	 */
-	offset = offset * (1000000 / HZ) / COUNT;
-
-	return offset;
-}
-
  static irqreturn_t
  ebsa110_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
  {
@@ -220,7 +189,6 @@

  static struct sys_timer ebsa110_timer = {
  	.init		= ebsa110_timer_init,
-	.offset		= ebsa110_gettimeoffset,
  };

  static struct plat_serial8250_port serial_platform_data[] = {
diff -ur linux-2.6.18-rt6/arch/arm/mach-ep93xx/core.c linux-2.6.18-rt6-rmdead/arch/arm/mach-ep93xx/core.c
--- linux-2.6.18-rt6/arch/arm/mach-ep93xx/core.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-ep93xx/core.c	2006-10-19 14:45:44.727888699 +0200
@@ -133,19 +133,8 @@
  	setup_irq(IRQ_EP93XX_TIMER1, &ep93xx_timer_irq);
  }

-static unsigned long ep93xx_gettimeoffset(void)
-{
-	int offset;
-
-	offset = __raw_readl(EP93XX_TIMER4_VALUE_LOW) - last_jiffy_time;
-
-	/* Calculate (1000000 / 983040) * offset.  */
-	return offset + (53 * offset / 3072);
-}
-
  struct sys_timer ep93xx_timer = {
  	.init		= ep93xx_timer_init,
-	.offset		= ep93xx_gettimeoffset,
  };


diff -ur linux-2.6.18-rt6/arch/arm/mach-footbridge/dc21285-timer.c linux-2.6.18-rt6-rmdead/arch/arm/mach-footbridge/dc21285-timer.c
--- linux-2.6.18-rt6/arch/arm/mach-footbridge/dc21285-timer.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-footbridge/dc21285-timer.c	2006-10-19 14:46:09.807420250 +0200
@@ -20,13 +20,6 @@
   */
  static unsigned long timer1_latch;

-static unsigned long timer1_gettimeoffset (void)
-{
-	unsigned long value = timer1_latch - *CSR_TIMER1_VALUE;
-
-	return ((tick_nsec / 1000) * value) / timer1_latch;
-}
-
  static irqreturn_t
  timer1_interrupt(int irq, void *dev_id, struct pt_regs *regs)
  {
@@ -65,5 +58,4 @@

  struct sys_timer footbridge_timer = {
  	.init		= footbridge_timer_init,
-	.offset		= timer1_gettimeoffset,
  };
diff -ur linux-2.6.18-rt6/arch/arm/mach-footbridge/isa-timer.c linux-2.6.18-rt6-rmdead/arch/arm/mach-footbridge/isa-timer.c
--- linux-2.6.18-rt6/arch/arm/mach-footbridge/isa-timer.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-footbridge/isa-timer.c	2006-10-19 14:46:36.984494641 +0200
@@ -20,47 +20,6 @@
   */
  #define mSEC_10_from_14 ((14318180 + 100) / 200)

-static unsigned long isa_gettimeoffset(void)
-{
-	int count;
-
-	static int count_p = (mSEC_10_from_14/6);    /* for the first call after boot */
-	static unsigned long jiffies_p = 0;
-
-	/*
-	 * cache volatile jiffies temporarily; we have IRQs turned off. 
-	 */
-	unsigned long jiffies_t;
-
-	/* timer count may underflow right here */
-	outb_p(0x00, 0x43);	/* latch the count ASAP */
-
-	count = inb_p(0x40);	/* read the latched count */
-
-	/*
-	 * We do this guaranteed double memory access instead of a _p 
-	 * postfix in the previous port access. Wheee, hackady hack
-	 */
- 	jiffies_t = jiffies;
-
-	count |= inb_p(0x40) << 8;
-
-	/* Detect timer underflows.  If we haven't had a timer tick since 
-	   the last time we were called, and time is apparently going
-	   backwards, the counter must have wrapped during this routine. */
-	if ((jiffies_t == jiffies_p) && (count > count_p))
-		count -= (mSEC_10_from_14/6);
-	else
-		jiffies_p = jiffies_t;
-
-	count_p = count;
-
-	count = (((mSEC_10_from_14/6)-1) - count) * (tick_nsec / 1000);
-	count = (count + (mSEC_10_from_14/6)/2) / (mSEC_10_from_14/6);
-
-	return count;
-}
-
  static irqreturn_t
  isa_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
  {
@@ -91,5 +50,4 @@

  struct sys_timer isa_timer = {
  	.init		= isa_timer_init,
-	.offset		= isa_gettimeoffset,
  };
diff -ur linux-2.6.18-rt6/arch/arm/mach-h720x/common.c linux-2.6.18-rt6-rmdead/arch/arm/mach-h720x/common.c
--- linux-2.6.18-rt6/arch/arm/mach-h720x/common.c	2006-04-05 18:36:16.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-h720x/common.c	2006-10-19 14:47:16.012985340 +0200
@@ -42,15 +42,6 @@
  }

  /*
- * Return usecs since last timer reload
- * (timercount * (usecs perjiffie)) / (ticks per jiffie)
- */
-unsigned long h720x_gettimeoffset(void)
-{
-	return (CPU_REG (TIMER_VIRT, TM0_COUNT) * tick_usec) / LATCH;
-}
-
-/*
   * mask Global irq's
   */
  static void mask_global_irq (unsigned int irq )
diff -ur linux-2.6.18-rt6/arch/arm/mach-h720x/common.h linux-2.6.18-rt6-rmdead/arch/arm/mach-h720x/common.h
--- linux-2.6.18-rt6/arch/arm/mach-h720x/common.h	2006-04-05 18:00:47.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-h720x/common.h	2006-10-19 15:28:40.784692787 +0200
@@ -13,7 +13,6 @@
   *
   */

-extern unsigned long h720x_gettimeoffset(void);
  extern void __init h720x_init_irq (void);
  extern void __init h720x_map_io(void);

diff -ur linux-2.6.18-rt6/arch/arm/mach-h720x/cpu-h7201.c linux-2.6.18-rt6-rmdead/arch/arm/mach-h720x/cpu-h7201.c
--- linux-2.6.18-rt6/arch/arm/mach-h720x/cpu-h7201.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-h720x/cpu-h7201.c	2006-10-19 14:47:25.656882767 +0200
@@ -60,5 +60,4 @@

  struct sys_timer h7201_timer = {
  	.init		= h7201_init_time,
-	.offset		= h720x_gettimeoffset,
  };
diff -ur linux-2.6.18-rt6/arch/arm/mach-h720x/cpu-h7202.c linux-2.6.18-rt6-rmdead/arch/arm/mach-h720x/cpu-h7202.c
--- linux-2.6.18-rt6/arch/arm/mach-h720x/cpu-h7202.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-h720x/cpu-h7202.c	2006-10-19 14:47:33.310214197 +0200
@@ -190,7 +190,6 @@

  struct sys_timer h7202_timer = {
  	.init		= h7202_init_time,
-	.offset		= h720x_gettimeoffset,
  };

  void __init h7202_init_irq (void)
diff -ur linux-2.6.18-rt6/arch/arm/mach-imx/time.c linux-2.6.18-rt6-rmdead/arch/arm/mach-imx/time.c
--- linux-2.6.18-rt6/arch/arm/mach-imx/time.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-imx/time.c	2006-10-19 14:48:02.768791819 +0200
@@ -25,34 +25,6 @@
  #define TIMER_BASE IMX_TIM1_BASE

  /*
- * Returns number of us since last clock interrupt.  Note that interrupts
- * will have been disabled by do_gettimeoffset()
- */
-static unsigned long imx_gettimeoffset(void)
-{
-	unsigned long ticks;
-
-	/*
-	 * Get the current number of ticks.  Note that there is a race
-	 * condition between us reading the timer and checking for
-	 * an interrupt.  We get around this by ensuring that the
-	 * counter has not reloaded between our two reads.
-	 */
-	ticks = IMX_TCN(TIMER_BASE);
-
-	/*
-	 * Interrupt pending?  If so, we've reloaded once already.
-	 */
-	if (IMX_TSTAT(TIMER_BASE) & TSTAT_COMP)
-		ticks += LATCH;
-
-	/*
-	 * Convert the ticks to usecs
-	 */
-	return (1000000 / CLK32) * ticks;
-}
-
-/*
   * IRQ handler for the timer
   */
  static irqreturn_t
@@ -97,5 +69,4 @@

  struct sys_timer imx_timer = {
  	.init		= imx_timer_init,
-	.offset		= imx_gettimeoffset,
  };
diff -ur linux-2.6.18-rt6/arch/arm/mach-integrator/common.h linux-2.6.18-rt6-rmdead/arch/arm/mach-integrator/common.h
--- linux-2.6.18-rt6/arch/arm/mach-integrator/common.h	2006-04-05 18:00:47.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-integrator/common.h	2006-10-19 14:48:23.325310354 +0200
@@ -1,2 +1 @@
  extern void integrator_time_init(unsigned long, unsigned int);
-extern unsigned long integrator_gettimeoffset(void);
diff -ur linux-2.6.18-rt6/arch/arm/mach-integrator/core.c linux-2.6.18-rt6-rmdead/arch/arm/mach-integrator/core.c
--- linux-2.6.18-rt6/arch/arm/mach-integrator/core.c	2006-10-19 12:29:12.433093016 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-integrator/core.c	2006-10-19 14:48:44.981589253 +0200
@@ -207,44 +207,6 @@
  static unsigned long timer_reload;

  /*
- * Returns number of ms since last clock interrupt.  Note that interrupts
- * will have been disabled by do_gettimeoffset()
- */
-unsigned long integrator_gettimeoffset(void)
-{
-	unsigned long ticks1, ticks2, status;
-
-	/*
-	 * Get the current number of ticks.  Note that there is a race
-	 * condition between us reading the timer and checking for
-	 * an interrupt.  We get around this by ensuring that the
-	 * counter has not reloaded between our two reads.
-	 */
-	ticks2 = readl(TIMER1_VA_BASE + TIMER_VALUE) & 0xffff;
-	do {
-		ticks1 = ticks2;
-		status = __raw_readl(VA_IC_BASE + IRQ_RAW_STATUS);
-		ticks2 = readl(TIMER1_VA_BASE + TIMER_VALUE) & 0xffff;
-	} while (ticks2 > ticks1);
-
-	/*
-	 * Number of ticks since last interrupt.
-	 */
-	ticks1 = timer_reload - ticks2;
-
-	/*
-	 * Interrupt pending?  If so, we've reloaded once already.
-	 */
-	if (status & (1 << IRQ_TIMERINT1))
-		ticks1 += timer_reload;
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
  static irqreturn_t
diff -ur linux-2.6.18-rt6/arch/arm/mach-integrator/integrator_ap.c linux-2.6.18-rt6-rmdead/arch/arm/mach-integrator/integrator_ap.c
--- linux-2.6.18-rt6/arch/arm/mach-integrator/integrator_ap.c	2006-09-25 15:59:04.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-integrator/integrator_ap.c	2006-10-19 14:48:52.783888370 +0200
@@ -341,7 +341,6 @@

  static struct sys_timer ap_timer = {
  	.init		= ap_init_timer,
-	.offset		= integrator_gettimeoffset,
  };

  MACHINE_START(INTEGRATOR, "ARM-Integrator")
diff -ur linux-2.6.18-rt6/arch/arm/mach-integrator/integrator_cp.c linux-2.6.18-rt6-rmdead/arch/arm/mach-integrator/integrator_cp.c
--- linux-2.6.18-rt6/arch/arm/mach-integrator/integrator_cp.c	2006-09-25 15:59:04.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-integrator/integrator_cp.c	2006-10-19 14:48:59.831352054 +0200
@@ -575,7 +575,6 @@

  static struct sys_timer cp_timer = {
  	.init		= intcp_timer_init,
-	.offset		= integrator_gettimeoffset,
  };

  MACHINE_START(CINTEGRATOR, "ARM-IntegratorCP")
diff -ur linux-2.6.18-rt6/arch/arm/mach-iop3xx/iop321-time.c linux-2.6.18-rt6-rmdead/arch/arm/mach-iop3xx/iop321-time.c
--- linux-2.6.18-rt6/arch/arm/mach-iop3xx/iop321-time.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-iop3xx/iop321-time.c	2006-10-19 14:49:23.051290311 +0200
@@ -33,37 +33,6 @@
  	return LATCH - *IOP321_TU_TCR0;
  }

-static unsigned long iop321_gettimeoffset(void)
-{
-	unsigned long elapsed, usec;
-	u32 tisr1, tisr2;
-
-	/*
-	 * If an interrupt was pending before we read the timer,
-	 * we've already wrapped.  Factor this into the time.
-	 * If an interrupt was pending after we read the timer,
-	 * it may have wrapped between checking the interrupt
-	 * status and reading the timer.  Re-read the timer to
-	 * be sure its value is after the wrap.
-	 */
-
-	asm volatile("mrc p6, 0, %0, c6, c1, 0" : "=r" (tisr1));
-	elapsed = get_elapsed();
-	asm volatile("mrc p6, 0, %0, c6, c1, 0" : "=r" (tisr2));
-
-	if(tisr1 & 1)
-		elapsed += LATCH;
-	else if (tisr2 & 1)
-		elapsed = LATCH + get_elapsed();
-
-	/*
-	 * Now convert them to usec.
-	 */
-	usec = (unsigned long)(elapsed / (CLOCK_TICK_RATE/1000000));
-
-	return usec;
-}
-
  static irqreturn_t
  iop321_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
  {
@@ -104,5 +73,4 @@

  struct sys_timer iop321_timer = {
  	.init		= &iop321_timer_init,
-	.offset		= iop321_gettimeoffset,
  };
diff -ur linux-2.6.18-rt6/arch/arm/mach-iop3xx/iop331-time.c linux-2.6.18-rt6-rmdead/arch/arm/mach-iop3xx/iop331-time.c
--- linux-2.6.18-rt6/arch/arm/mach-iop3xx/iop331-time.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-iop3xx/iop331-time.c	2006-10-19 14:50:08.256436386 +0200
@@ -31,37 +31,6 @@
  	return LATCH - *IOP331_TU_TCR0;
  }

-static unsigned long iop331_gettimeoffset(void)
-{
-	unsigned long elapsed, usec;
-	u32 tisr1, tisr2;
-
-	/*
-	 * If an interrupt was pending before we read the timer,
-	 * we've already wrapped.  Factor this into the time.
-	 * If an interrupt was pending after we read the timer,
-	 * it may have wrapped between checking the interrupt
-	 * status and reading the timer.  Re-read the timer to
-	 * be sure its value is after the wrap.
-	 */
-
-	asm volatile("mrc p6, 0, %0, c6, c1, 0" : "=r" (tisr1));
-	elapsed = get_elapsed();
-	asm volatile("mrc p6, 0, %0, c6, c1, 0" : "=r" (tisr2));
-
-	if(tisr1 & 1)
-		elapsed += LATCH;
-	else if (tisr2 & 1)
-		elapsed = LATCH + get_elapsed();
-
-	/*
-	 * Now convert them to usec.
-	 */
-	usec = (unsigned long)(elapsed / (CLOCK_TICK_RATE/1000000));
-
-	return usec;
-}
-
  static irqreturn_t
  iop331_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
  {
@@ -102,5 +71,4 @@

  struct sys_timer iop331_timer = {
  	.init		= iop331_timer_init,
-	.offset		= iop331_gettimeoffset,
  };
diff -ur linux-2.6.18-rt6/arch/arm/mach-ixp2000/core.c linux-2.6.18-rt6-rmdead/arch/arm/mach-ixp2000/core.c
--- linux-2.6.18-rt6/arch/arm/mach-ixp2000/core.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-ixp2000/core.c	2006-10-19 14:50:35.495499009 +0200
@@ -195,15 +195,6 @@
  static unsigned next_jiffy_time;
  static volatile unsigned long *missing_jiffy_timer_csr;

-unsigned long ixp2000_gettimeoffset (void)
-{
- 	unsigned long offset;
-
-	offset = next_jiffy_time - *missing_jiffy_timer_csr;
-
-	return offset / ticks_per_usec;
-}
-
  static int ixp2000_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
  {
  	write_seqlock(&xtime_lock);
diff -ur linux-2.6.18-rt6/arch/arm/mach-ixp2000/enp2611.c linux-2.6.18-rt6-rmdead/arch/arm/mach-ixp2000/enp2611.c
--- linux-2.6.18-rt6/arch/arm/mach-ixp2000/enp2611.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-ixp2000/enp2611.c	2006-10-19 14:50:42.157047001 +0200
@@ -58,7 +58,6 @@

  static struct sys_timer enp2611_timer = {
  	.init		= enp2611_timer_init,
-	.offset		= ixp2000_gettimeoffset,
  };


diff -ur linux-2.6.18-rt6/arch/arm/mach-ixp2000/ixdp2400.c linux-2.6.18-rt6-rmdead/arch/arm/mach-ixp2000/ixdp2400.c
--- linux-2.6.18-rt6/arch/arm/mach-ixp2000/ixdp2400.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-ixp2000/ixdp2400.c	2006-10-19 14:50:54.847280960 +0200
@@ -57,7 +57,6 @@

  static struct sys_timer ixdp2400_timer = {
  	.init		= ixdp2400_timer_init,
-	.offset		= ixp2000_gettimeoffset,
  };

  /*************************************************************************
diff -ur linux-2.6.18-rt6/arch/arm/mach-ixp2000/ixdp2800.c linux-2.6.18-rt6-rmdead/arch/arm/mach-ixp2000/ixdp2800.c
--- linux-2.6.18-rt6/arch/arm/mach-ixp2000/ixdp2800.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-ixp2000/ixdp2800.c	2006-10-19 14:51:04.340211852 +0200
@@ -52,7 +52,6 @@

  static struct sys_timer ixdp2800_timer = {
  	.init		= ixdp2800_timer_init,
-	.offset		= ixp2000_gettimeoffset,
  };

  /*************************************************************************
diff -ur linux-2.6.18-rt6/arch/arm/mach-ixp2000/ixdp2x01.c linux-2.6.18-rt6-rmdead/arch/arm/mach-ixp2000/ixdp2x01.c
--- linux-2.6.18-rt6/arch/arm/mach-ixp2000/ixdp2x01.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-ixp2000/ixdp2x01.c	2006-10-19 14:51:15.971676656 +0200
@@ -240,7 +240,6 @@

  static struct sys_timer ixdp2x01_timer = {
  	.init		= ixdp2x01_timer_init,
-	.offset		= ixp2000_gettimeoffset,
  };

  /*************************************************************************
diff -ur linux-2.6.18-rt6/arch/arm/mach-ixp23xx/core.c linux-2.6.18-rt6-rmdead/arch/arm/mach-ixp23xx/core.c
--- linux-2.6.18-rt6/arch/arm/mach-ixp23xx/core.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-ixp23xx/core.c	2006-10-19 14:52:07.662410549 +0200
@@ -337,16 +337,6 @@

  static unsigned long next_jiffy_time;

-static unsigned long
-ixp23xx_gettimeoffset(void)
-{
-	unsigned long elapsed;
-
-	elapsed = *IXP23XX_TIMER_CONT - (next_jiffy_time - LATCH);
-
-	return elapsed / CLOCK_TICKS_PER_USEC;
-}
-
  static irqreturn_t
  ixp23xx_timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
  {
@@ -384,7 +374,6 @@

  struct sys_timer ixp23xx_timer = {
  	.init		= ixp23xx_init_timer,
-	.offset		= ixp23xx_gettimeoffset,
  };


diff -ur linux-2.6.18-rt6/arch/arm/mach-netx/time.c linux-2.6.18-rt6-rmdead/arch/arm/mach-netx/time.c
--- linux-2.6.18-rt6/arch/arm/mach-netx/time.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-netx/time.c	2006-10-19 14:52:33.803713256 +0200
@@ -26,15 +26,6 @@
  #include <asm/arch/netx-regs.h>

  /*
- * Returns number of us since last clock interrupt.  Note that interrupts
- * will have been disabled by do_gettimeoffset()
- */
-static unsigned long netx_gettimeoffset(void)
-{
-	return readl(NETX_GPIO_COUNTER_CURRENT(0)) / 100;
-}
-
-/*
   * IRQ handler for the timer
   */
  static irqreturn_t
@@ -84,5 +75,4 @@

  struct sys_timer netx_timer = {
  	.init           = netx_timer_init,
-	.offset         = netx_gettimeoffset,
  };
diff -ur linux-2.6.18-rt6/arch/arm/mach-omap1/time.c linux-2.6.18-rt6-rmdead/arch/arm/mach-omap1/time.c
--- linux-2.6.18-rt6/arch/arm/mach-omap1/time.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-omap1/time.c	2006-10-19 14:53:28.981688206 +0200
@@ -145,17 +145,6 @@
  static unsigned long omap_mpu_timer_last = 0;

  /*
- * Returns elapsed usecs since last system timer interrupt
- */
-static unsigned long omap_mpu_timer_gettimeoffset(void)
-{
-	unsigned long now = 0 - omap_mpu_timer_read(0);
-	unsigned long elapsed = now - omap_mpu_timer_last;
-
-	return omap_mpu_timer_ticks_to_usecs(elapsed);
-}
-
-/*
   * Elapsed time between interrupts is calculated using timer0.
   * Latency during the interrupt is calculated using timer1.
   * Both timer0 and timer1 are counting at 6MHz (P2 6.5MHz).
@@ -198,7 +187,6 @@
  static __init void omap_init_mpu_timer(void)
  {
  	set_cyc2ns_scale(MPU_TICKS_PER_SEC / 1000);
-	omap_timer.offset = omap_mpu_timer_gettimeoffset;
  	setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
  	setup_irq(INT_TIMER2, &omap_mpu_timer_irq);
  	omap_mpu_timer_start(0, 0xffffffff);
@@ -232,5 +220,4 @@

  struct sys_timer omap_timer = {
  	.init		= omap_timer_init,
-	.offset		= NULL,		/* Initialized later */
  };
diff -ur linux-2.6.18-rt6/arch/arm/mach-pnx4008/time.c linux-2.6.18-rt6-rmdead/arch/arm/mach-pnx4008/time.c
--- linux-2.6.18-rt6/arch/arm/mach-pnx4008/time.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-pnx4008/time.c	2006-10-19 15:19:56.104609385 +0200
@@ -34,18 +34,6 @@
  /*! Note: all timers are UPCOUNTING */

  /*!
- * Returns number of us since last clock interrupt.  Note that interrupts
- * will have been disabled by do_gettimeoffset()
- */
-static unsigned long pnx4008_gettimeoffset(void)
-{
-	u32 ticks_to_match =
-	    __raw_readl(HSTIM_MATCH0) - __raw_readl(HSTIM_COUNTER);
-	u32 elapsed = LATCH - ticks_to_match;
-	return (elapsed * (tick_nsec / 1000)) / LATCH;
-}
-
-/*!
   * IRQ handler for the timer
   */
  static irqreturn_t pnx4008_timer_interrupt(int irq, void *dev_id,
@@ -132,7 +120,6 @@

  struct sys_timer pnx4008_timer = {
  	.init = pnx4008_setup_timer,
-	.offset = pnx4008_gettimeoffset,
  	.suspend = pnx4008_timer_suspend,
  	.resume = pnx4008_timer_resume,
  };
diff -ur linux-2.6.18-rt6/arch/arm/mach-pxa/time.c linux-2.6.18-rt6-rmdead/arch/arm/mach-pxa/time.c
--- linux-2.6.18-rt6/arch/arm/mach-pxa/time.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-pxa/time.c	2006-10-19 14:54:32.606828929 +0200
@@ -48,27 +48,6 @@
  	return 0;
  }

-/* IRQs are disabled before entering here from do_gettimeofday() */
-static unsigned long pxa_gettimeoffset (void)
-{
-	long ticks_to_match, elapsed, usec;
-
-	/* Get ticks before next timer match */
-	ticks_to_match = OSMR0 - OSCR;
-
-	/* We need elapsed ticks since last match */
-	elapsed = LATCH - ticks_to_match;
-
-	/* don't get fooled by the workaround in pxa_timer_interrupt() */
-	if (elapsed <= 0)
-		return 0;
-
-	/* Now convert them to usec */
-	usec = (unsigned long)(elapsed * (tick_nsec / 1000))/LATCH;
-
-	return usec;
-}
-
  #ifdef CONFIG_NO_IDLE_HZ
  static unsigned long initial_match;
  static int match_posponed;
@@ -210,7 +189,6 @@
  	.init		= pxa_timer_init,
  	.suspend	= pxa_timer_suspend,
  	.resume		= pxa_timer_resume,
-	.offset		= pxa_gettimeoffset,
  #ifdef CONFIG_NO_IDLE_HZ
  	.dyn_tick	= &pxa_dyn_tick,
  #endif
diff -ur linux-2.6.18-rt6/arch/arm/mach-realview/core.c linux-2.6.18-rt6-rmdead/arch/arm/mach-realview/core.c
--- linux-2.6.18-rt6/arch/arm/mach-realview/core.c	2006-10-19 14:38:48.492672933 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-realview/core.c	2006-10-19 13:32:32.108305675 +0200
@@ -475,7 +475,7 @@
   * Returns number of ms since last clock interrupt.  Note that interrupts
   * will have been disabled by do_gettimeoffset()
   */
-static unsigned long realview_gettimeoffset(void)
+unsigned long realview_gettimeoffset(void)
  {
  	unsigned long ticks1, ticks2, status;

@@ -580,5 +580,4 @@

  struct sys_timer realview_timer = {
  	.init		= realview_timer_init,
-	.offset		= realview_gettimeoffset,
  };
diff -ur linux-2.6.18-rt6/arch/arm/mach-realview/CVS/Entries linux-2.6.18-rt6-rmdead/arch/arm/mach-realview/CVS/Entries
--- linux-2.6.18-rt6/arch/arm/mach-realview/CVS/Entries	2006-10-19 14:39:44.670417102 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-realview/CVS/Entries	2006-10-19 12:24:41.227974314 +0200
@@ -3,11 +3,11 @@
  /Makefile.boot/1.1.1.1/Wed Apr  5 16:36:16 2006/-ko/Tlinux-2_6_18
  /clock.c/1.1.1.2/Wed Apr  5 16:44:00 2006/-ko/Tlinux-2_6_18
  /clock.h/1.1.1.1/Wed Apr  5 16:36:16 2006/-ko/Tlinux-2_6_18
+/core.c/1.1.1.4/Tue Aug 15 07:21:18 2006/-ko/Tlinux-2_6_18
  /core.h/1.1.1.2/Wed Apr  5 16:44:00 2006/-ko/Tlinux-2_6_18
  /headsmp.S/1.1.1.1/Wed Apr  5 16:36:16 2006/-ko/Tlinux-2_6_18
  /hotplug.c/1.1.1.1/Wed Apr  5 16:36:16 2006/-ko/Tlinux-2_6_18
+/localtimer.c/1.1.1.2/Wed Apr  5 16:44:00 2006/-ko/Tlinux-2_6_18
  /platsmp.c/1.1.1.2/Wed Apr  5 16:44:00 2006/-ko/Tlinux-2_6_18
  /realview_eb.c/1.1.1.4/Tue Aug 15 07:21:18 2006/-ko/Tlinux-2_6_18
-/core.c/1.1.1.4/Thu Oct 19 12:38:48 2006/-ko/Tlinux-2_6_18
-/localtimer.c/1.1.1.2/Thu Oct 19 12:39:44 2006/-ko/Tlinux-2_6_18
  D
diff -ur linux-2.6.18-rt6/arch/arm/mach-realview/localtimer.c linux-2.6.18-rt6-rmdead/arch/arm/mach-realview/localtimer.c
--- linux-2.6.18-rt6/arch/arm/mach-realview/localtimer.c	2006-10-19 14:39:44.670417102 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-realview/localtimer.c	2006-10-19 15:21:12.397043382 +0200
@@ -27,6 +27,8 @@

  static unsigned long mpcore_timer_rate;

+extern unsigned long realview_gettimeoffset(void);
+
  /*
   * local_timer_ack: checks for a local timer interrupt.
   *
@@ -108,7 +110,7 @@
  	 *
  	 * so the multiply value will be less than 10^9 always.
  	 */
-	load = (system_timer->offset() * (mpcore_timer_rate / 10000)) / 100;
+	load = (realview_gettimeoffset() * (mpcore_timer_rate / 10000)) / 100;

  	/* Add on our offset to get the load value */
  	load = (load + offset) % (mpcore_timer_rate / HZ);
diff -ur linux-2.6.18-rt6/arch/arm/mach-s3c2410/time.c linux-2.6.18-rt6-rmdead/arch/arm/mach-s3c2410/time.c
--- linux-2.6.18-rt6/arch/arm/mach-s3c2410/time.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-s3c2410/time.c	2006-10-19 15:29:01.616175635 +0200
@@ -85,44 +85,6 @@
  	return res >> TIMER_USEC_SHIFT;
  }

-/***
- * Returns microsecond  since last clock interrupt.  Note that interrupts
- * will have been disabled by do_gettimeoffset()
- * IRQs are disabled before entering here from do_gettimeofday()
- */
-
-#define SRCPND_TIMER4 (1<<(IRQ_TIMER4 - IRQ_EINT0))
-
-static unsigned long s3c2410_gettimeoffset (void)
-{
-	unsigned long tdone;
-	unsigned long irqpend;
-	unsigned long tval;
-
-	/* work out how many ticks have gone since last timer interrupt */
-
-        tval =  __raw_readl(S3C2410_TCNTO(4));
-	tdone = timer_startval - tval;
-
-	/* check to see if there is an interrupt pending */
-
-	irqpend = __raw_readl(S3C2410_SRCPND);
-	if (irqpend & SRCPND_TIMER4) {
-		/* re-read the timer, and try and fix up for the missed
-		 * interrupt. Note, the interrupt may go off before the
-		 * timer has re-loaded from wrapping.
-		 */
-
-		tval =  __raw_readl(S3C2410_TCNTO(4));
-		tdone = timer_startval - tval;
-
-		if (tval != 0)
-			tdone += timer_startval;
-	}
-
-	return timer_ticks_to_usec(tdone);
-}
-

  /*
   * IRQ handler for the timer
@@ -257,6 +219,5 @@

  struct sys_timer s3c24xx_timer = {
  	.init		= s3c2410_timer_init,
-	.offset		= s3c2410_gettimeoffset,
  	.resume		= s3c2410_timer_setup
  };
diff -ur linux-2.6.18-rt6/arch/arm/mach-sa1100/time.c linux-2.6.18-rt6-rmdead/arch/arm/mach-sa1100/time.c
--- linux-2.6.18-rt6/arch/arm/mach-sa1100/time.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/mach-sa1100/time.c	2006-10-19 14:56:42.230621965 +0200
@@ -54,23 +54,6 @@
  	return 0;
  }

-/* IRQs are disabled before entering here from do_gettimeofday() */
-static unsigned long sa1100_gettimeoffset (void)
-{
-	unsigned long ticks_to_match, elapsed, usec;
-
-	/* Get ticks before next timer match */
-	ticks_to_match = OSMR0 - OSCR;
-
-	/* We need elapsed ticks since last match */
-	elapsed = LATCH - ticks_to_match;
-
-	/* Now convert them to usec */
-	usec = (unsigned long)(elapsed * (tick_nsec / 1000))/LATCH;
-
-	return usec;
-}
-
  #ifdef CONFIG_NO_IDLE_HZ
  static unsigned long initial_match;
  static int match_posponed;
@@ -205,7 +188,6 @@
  	.init		= sa1100_timer_init,
  	.suspend	= sa1100_timer_suspend,
  	.resume		= sa1100_timer_resume,
-	.offset		= sa1100_gettimeoffset,
  #ifdef CONFIG_NO_IDLE_HZ
  	.dyn_tick	= &sa1100_dyn_tick,
  #endif
diff -ur linux-2.6.18-rt6/arch/arm/plat-omap/timer32k.c linux-2.6.18-rt6-rmdead/arch/arm/plat-omap/timer32k.c
--- linux-2.6.18-rt6/arch/arm/plat-omap/timer32k.c	2006-08-15 09:21:18.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/arm/plat-omap/timer32k.c	2006-10-19 14:57:06.838267505 +0200
@@ -169,15 +169,6 @@
  static unsigned long omap_32k_last_tick = 0;

  /*
- * Returns elapsed usecs since last 32k timer interrupt
- */
-static unsigned long omap_32k_timer_gettimeoffset(void)
-{
-	unsigned long now = omap_32k_sync_timer_read();
-	return omap_32k_ticks_to_usecs(now - omap_32k_last_tick);
-}
-
-/*
   * Returns current time from boot in nsecs. It's OK for this to wrap
   * around for now, as it's just a relative time stamp.
   */
@@ -270,7 +261,6 @@

  	if (cpu_class_is_omap1())
  		setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
-	omap_timer.offset  = omap_32k_timer_gettimeoffset;
  	omap_32k_last_tick = omap_32k_sync_timer_read();

  #ifdef CONFIG_ARCH_OMAP2
diff -ur linux-2.6.18-rt6/arch/mips/au1000/common/time.c linux-2.6.18-rt6-rmdead/arch/mips/au1000/common/time.c
--- linux-2.6.18-rt6/arch/mips/au1000/common/time.c	2006-08-15 09:21:21.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/mips/au1000/common/time.c	2006-10-19 13:59:46.496298726 +0200
@@ -313,76 +313,6 @@
  	return r0;
  }

-static unsigned long do_fast_cp0_gettimeoffset(void)
-{
-	u32 count;
-	unsigned long res, tmp;
-	unsigned long r0;
-
-	/* Last jiffy when do_fast_gettimeoffset() was called. */
-	static unsigned long last_jiffies=0;
-	unsigned long quotient;
-
-	/*
-	 * Cached "1/(clocks per usec)*2^32" value.
-	 * It has to be recalculated once each jiffy.
-	 */
-	static unsigned long cached_quotient=0;
-
-	tmp = jiffies;
-
-	quotient = cached_quotient;
-
-	if (tmp && last_jiffies != tmp) {
-		last_jiffies = tmp;
-		if (last_jiffies != 0) {
-			r0 = div64_32(timerhi, timerlo, tmp);
-			quotient = div64_32(USECS_PER_JIFFY, USECS_PER_JIFFY_FRAC, r0);
-			cached_quotient = quotient;
-		}
-	}
-
-	/* Get last timer tick in absolute kernel time */
-	count = read_c0_count();
-
-	/* .. relative to previous jiffy (32 bits is enough) */
-	count -= timerlo;
-
-	__asm__("multu\t%1,%2\n\t"
-		"mfhi\t%0"
-		: "=r" (res)
-		: "r" (count), "r" (quotient)
-		: "hi", "lo", GCC_REG_ACCUM);
-
-	/*
-	 * Due to possible jiffies inconsistencies, we need to check
-	 * the result so that we'll get a timer that is monotonic.
-	 */
-	if (res >= USECS_PER_JIFFY)
-		res = USECS_PER_JIFFY-1;
-
-	return res;
-}
-
-#ifdef CONFIG_PM
-static unsigned long do_fast_pm_gettimeoffset(void)
-{
-	unsigned long pc0;
-	unsigned long offset;
-
-	pc0 = au_readl(SYS_TOYREAD);
-	au_sync();
-	offset = pc0 - last_pc0;
-	if (offset > 2*MATCH20_INC) {
-		printk("huge offset %x, last_pc0 %x last_match20 %x pc0 %x\n",
-				(unsigned)offset, (unsigned)last_pc0,
-				(unsigned)last_match20, (unsigned)pc0);
-	}
-	offset = (unsigned long)((offset * 305) / 10);
-	return offset;
-}
-#endif
-
  void __init plat_timer_setup(struct irqaction *irq)
  {
  	unsigned int est_freq;
@@ -420,7 +350,6 @@
  		unsigned int c0_status;

  		printk("WARNING: no 32KHz clock found.\n");
-		do_gettimeoffset = do_fast_cp0_gettimeoffset;

  		/* Ensure we get CPO_COUNTER interrupts.
  		*/
@@ -445,19 +374,10 @@
  		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_M20);
  		startup_match20_interrupt(counter0_irq);

-		do_gettimeoffset = do_fast_pm_gettimeoffset;
-
  		/* We can use the real 'wait' instruction.
  		*/
  		allow_au1k_wait = 1;
  	}
-
-#else
-	/* We have to do this here instead of in timer_init because
-	 * the generic code in arch/mips/kernel/time.c will write
-	 * over our function pointer.
-	 */
-	do_gettimeoffset = do_fast_cp0_gettimeoffset;
  #endif
  }

diff -ur linux-2.6.18-rt6/arch/mips/jmr3927/rbhma3100/setup.c linux-2.6.18-rt6-rmdead/arch/mips/jmr3927/rbhma3100/setup.c
--- linux-2.6.18-rt6/arch/mips/jmr3927/rbhma3100/setup.c	2006-08-15 09:21:21.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/mips/jmr3927/rbhma3100/setup.c	2006-10-19 15:31:43.797007590 +0200
@@ -183,12 +183,8 @@
  #endif
  }

-unsigned long jmr3927_do_gettimeoffset(void);
-
  void __init plat_timer_setup(struct irqaction *irq)
  {
-	do_gettimeoffset = jmr3927_do_gettimeoffset;
-
  	jmr3927_tmrptr->cpra = JMR3927_TIMER_CLK / HZ;
  	jmr3927_tmrptr->itmr = TXx927_TMTITMR_TIIE | TXx927_TMTITMR_TZCE;
  	jmr3927_tmrptr->ccdr = JMR3927_TIMER_CCD;
@@ -200,34 +196,6 @@

  #define USECS_PER_JIFFY (1000000/HZ)

-unsigned long jmr3927_do_gettimeoffset(void)
-{
-       unsigned long count;
-       unsigned long res = 0;
-
-       /* MUST read TRR before TISR. */
-       count = jmr3927_tmrptr->trr;
-
-       if (jmr3927_tmrptr->tisr & TXx927_TMTISR_TIIS) {
-               /* timer interrupt is pending.  use Max value. */
-               res = USECS_PER_JIFFY - 1;
-       } else {
-               /* convert to usec */
-               /* res = count / (JMR3927_TIMER_CLK / 1000000); */
-               res = (count << 7) / ((JMR3927_TIMER_CLK << 7) / 1000000);
-
-               /*
-                * Due to possible jiffies inconsistencies, we need to check
-                * the result so that we'll get a timer that is monotonic.
-                */
-               if (res >= USECS_PER_JIFFY)
-                       res = USECS_PER_JIFFY-1;
-       }
-
-       return res;
-}
-
-
  //#undef DO_WRITE_THROUGH
  #define DO_WRITE_THROUGH
  #define DO_ENABLE_CACHE
diff -ur linux-2.6.18-rt6/arch/mips/kernel/time.c linux-2.6.18-rt6-rmdead/arch/mips/kernel/time.c
--- linux-2.6.18-rt6/arch/mips/kernel/time.c	2006-10-19 12:29:12.498078907 +0200
+++ linux-2.6.18-rt6-rmdead/arch/mips/kernel/time.c	2006-10-19 15:33:46.664364165 +0200
@@ -219,163 +219,11 @@
  void (*mips_hpt_init)(unsigned int);

  /*
- * Gettimeoffset routines.  These routines returns the time duration
- * since last timer interrupt in usecs.
- *
- * If the exact CPU counter frequency is known, use fixed_rate_gettimeoffset.
- * Otherwise use calibrate_gettimeoffset()
- *
- * If the CPU does not have the counter register, you can either supply
- * your own gettimeoffset() routine, or use null_gettimeoffset(), which
- * gives the same resolution as HZ.
- */
-
-static unsigned long null_gettimeoffset(void)
-{
-	return 0;
-}
-
-/* The function pointer to one of the gettimeoffset funcs.  */
-unsigned long (*do_gettimeoffset)(void) = null_gettimeoffset;
-
-static unsigned long fixed_rate_gettimeoffset(void)
-{
-	u32 count;
-	unsigned long res;
-
-	/* Get last timer tick in absolute kernel time */
-	count = mips_hpt_read();
-
-	/* .. relative to previous jiffy (32 bits is enough) */
-	count -= timerlo;
-
-	__asm__("multu	%1,%2"
-		: "=h" (res)
-		: "r" (count), "r" (sll32_usecs_per_cycle)
-		: "lo", GCC_REG_ACCUM);
-
-	/*
-	 * Due to possible jiffies inconsistencies, we need to check
-	 * the result so that we'll get a timer that is monotonic.
-	 */
-	if (res >= USECS_PER_JIFFY)
-		res = USECS_PER_JIFFY - 1;
-
-	return res;
-}
-
-
-/*
   * Cached "1/(clocks per usec) * 2^32" value.
   * It has to be recalculated once each jiffy.
   */
  static unsigned long cached_quotient;

-/* Last jiffy when calibrate_divXX_gettimeoffset() was called. */
-static unsigned long last_jiffies;
-
-/*
- * This is moved from dec/time.c:do_ioasic_gettimeoffset() by Maciej.
- */
-static unsigned long calibrate_div32_gettimeoffset(void)
-{
-	u32 count;
-	unsigned long res, tmp;
-	unsigned long quotient;
-
-	tmp = jiffies;
-
-	quotient = cached_quotient;
-
-	if (last_jiffies != tmp) {
-		last_jiffies = tmp;
-		if (last_jiffies != 0) {
-			unsigned long r0;
-			do_div64_32(r0, timerhi, timerlo, tmp);
-			do_div64_32(quotient, USECS_PER_JIFFY,
-				    USECS_PER_JIFFY_FRAC, r0);
-			cached_quotient = quotient;
-		}
-	}
-
-	/* Get last timer tick in absolute kernel time */
-	count = mips_hpt_read();
-
-	/* .. relative to previous jiffy (32 bits is enough) */
-	count -= timerlo;
-
-	__asm__("multu  %1,%2"
-		: "=h" (res)
-		: "r" (count), "r" (quotient)
-		: "lo", GCC_REG_ACCUM);
-
-	/*
-	 * Due to possible jiffies inconsistencies, we need to check
-	 * the result so that we'll get a timer that is monotonic.
-	 */
-	if (res >= USECS_PER_JIFFY)
-		res = USECS_PER_JIFFY - 1;
-
-	return res;
-}
-
-static unsigned long calibrate_div64_gettimeoffset(void)
-{
-	u32 count;
-	unsigned long res, tmp;
-	unsigned long quotient;
-
-	tmp = jiffies;
-
-	quotient = cached_quotient;
-
-	if (last_jiffies != tmp) {
-		last_jiffies = tmp;
-		if (last_jiffies) {
-			unsigned long r0;
-			__asm__(".set	push\n\t"
-				".set	mips3\n\t"
-				"lwu	%0,%3\n\t"
-				"dsll32	%1,%2,0\n\t"
-				"or	%1,%1,%0\n\t"
-				"ddivu	$0,%1,%4\n\t"
-				"mflo	%1\n\t"
-				"dsll32	%0,%5,0\n\t"
-				"or	%0,%0,%6\n\t"
-				"ddivu	$0,%0,%1\n\t"
-				"mflo	%0\n\t"
-				".set	pop"
-				: "=&r" (quotient), "=&r" (r0)
-				: "r" (timerhi), "m" (timerlo),
-				  "r" (tmp), "r" (USECS_PER_JIFFY),
-				  "r" (USECS_PER_JIFFY_FRAC)
-				: "hi", "lo", GCC_REG_ACCUM);
-			cached_quotient = quotient;
-		}
-	}
-
-	/* Get last timer tick in absolute kernel time */
-	count = mips_hpt_read();
-
-	/* .. relative to previous jiffy (32 bits is enough) */
-	count -= timerlo;
-
-	__asm__("multu	%1,%2"
-		: "=h" (res)
-		: "r" (count), "r" (quotient)
-		: "lo", GCC_REG_ACCUM);
-
-	/*
-	 * Due to possible jiffies inconsistencies, we need to check
-	 * the result so that we'll get a timer that is monotonic.
-	 */
-	if (res >= USECS_PER_JIFFY)
-		res = USECS_PER_JIFFY - 1;
-
-	return res;
-}
-
-
  /* last time when xtime and rtc are sync'ed up */
  static long last_rtc_update;

@@ -589,9 +437,8 @@
   *	    (only needed if you intended to use fixed_rate_gettimeoffset
   *	     or use cpu counter as timer interrupt source)
   * 2) setup xtime based on rtc_get_time().
- * 3) choose a appropriate gettimeoffset routine.
- * 4) calculate a couple of cached variables for later usage
- * 5) plat_timer_setup() -
+ * 3) calculate a couple of cached variables for later usage
+ * 4) plat_timer_setup() -
   *	a) (optional) over-write any choices made above by time_init().
   *	b) machine specific code should setup the timer irqaction.
   *	c) enable the timer interrupt
@@ -679,21 +526,6 @@
  			mips_hpt_read = c0_hpt_read;
  			mips_hpt_init = c0_hpt_init;
  		}
-
-		if (cpu_has_mips32r1 || cpu_has_mips32r2 ||
-		    (current_cpu_data.isa_level == MIPS_CPU_ISA_I) ||
-		    (current_cpu_data.isa_level == MIPS_CPU_ISA_II))
-			/*
-			 * We need to calibrate the counter but we don't have
-			 * 64-bit division.
-			 */
-			do_gettimeoffset = calibrate_div32_gettimeoffset;
-		else
-			/*
-			 * We need to calibrate the counter but we *do* have
-			 * 64-bit division.
-			 */
-			do_gettimeoffset = calibrate_div64_gettimeoffset;
  	} else {
  		/* We know counter frequency.  Or we can get it.  */
  		if (!mips_hpt_read) {
@@ -711,8 +543,6 @@
  		if (!mips_hpt_frequency)
  			mips_hpt_frequency = calibrate_hpt();

-		do_gettimeoffset = fixed_rate_gettimeoffset;
-
  		/* Calculate cache parameters.  */
  		cycles_per_jiffy = (mips_hpt_frequency + HZ / 2) / HZ;

diff -ur linux-2.6.18-rt6/arch/mips/sgi-ip27/ip27-timer.c linux-2.6.18-rt6-rmdead/arch/mips/sgi-ip27/ip27-timer.c
--- linux-2.6.18-rt6/arch/mips/sgi-ip27/ip27-timer.c	2006-08-15 09:21:22.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/mips/sgi-ip27/ip27-timer.c	2006-10-19 14:03:29.438886621 +0200
@@ -136,13 +136,6 @@
  	irq_exit();
  }

-unsigned long ip27_do_gettimeoffset(void)
-{
-	unsigned long ct_cur1;
-	ct_cur1 = REMOTE_HUB_L(cputonasid(0), PI_RT_COUNT) + CYCLES_PER_JIFFY;
-	return (ct_cur1 - ct_cur[0]) * NSEC_PER_CYCLE / 1000;
-}
-
  /* Includes for ioc3_init().  */
  #include <asm/sn/types.h>
  #include <asm/sn/sn0/addrs.h>
@@ -254,8 +247,6 @@
  {
  	xtime.tv_sec = get_m48t35_time();
  	xtime.tv_nsec = 0;
-
-	do_gettimeoffset = ip27_do_gettimeoffset;
  }

  void __init cpu_time_init(void)
diff -ur linux-2.6.18-rt6/arch/mips/sibyte/bcm1480/time.c linux-2.6.18-rt6-rmdead/arch/mips/sibyte/bcm1480/time.c
--- linux-2.6.18-rt6/arch/mips/sibyte/bcm1480/time.c	2006-08-15 09:21:22.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/mips/sibyte/bcm1480/time.c	2006-10-19 14:04:06.323875657 +0200
@@ -60,11 +60,6 @@
  		BUG();
  	}

-	if (!cpu) {
-		/* Use our own gettimeoffset() routine */
-		do_gettimeoffset = bcm1480_gettimeoffset;
-	}
-
  	bcm1480_mask_irq(cpu, irq);

  	/* Map the timer interrupt to ip[4] of this cpu */
@@ -122,17 +117,3 @@
  		ll_local_timer_interrupt(irq, regs);
  	}
  }
-
-/*
- * We use our own do_gettimeoffset() instead of the generic one,
- * because the generic one does not work for SMP case.
- * In addition, since we use general timer 0 for system time,
- * we can get accurate intra-jiffy offset without calibration.
- */
-unsigned long bcm1480_gettimeoffset(void)
-{
-	unsigned long count =
-		__raw_readq(IOADDR(A_SCD_TIMER_REGISTER(0, R_SCD_TIMER_CNT)));
-
-	return 1000000/HZ - count;
-}
diff -ur linux-2.6.18-rt6/arch/ppc/amiga/config.c linux-2.6.18-rt6-rmdead/arch/ppc/amiga/config.c
--- linux-2.6.18-rt6/arch/ppc/amiga/config.c	2006-08-15 09:21:23.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/arch/ppc/amiga/config.c	2006-10-19 14:07:36.695187370 +0200
@@ -82,7 +82,6 @@
  static void amiga_get_model(char *model);
  static int amiga_get_hardware_list(char *buffer);
  /* amiga specific timer functions */
-static unsigned long amiga_gettimeoffset (void);
  static void a3000_gettod (int *, int *, int *, int *, int *, int *);
  static void a2000_gettod (int *, int *, int *, int *, int *, int *);
  static int amiga_hwclk (int, struct hwclk_time *);
@@ -389,7 +388,6 @@
  #endif
    mach_get_model       = amiga_get_model;
    mach_get_hardware_list = amiga_get_hardware_list;
-  mach_gettimeoffset   = amiga_gettimeoffset;
    if (AMIGAHW_PRESENT(A3000_CLK)){
      mach_gettod  = a3000_gettod;
      rtc_resource.name = "A3000 RTC";
@@ -494,35 +492,6 @@

  extern unsigned char cia_get_irq_mask(unsigned int irq);

-/* This is always executed with interrupts disabled.  */
-static unsigned long amiga_gettimeoffset (void)
-{
-	unsigned short hi, lo, hi2;
-	unsigned long ticks, offset = 0;
-
-	/* read CIA B timer A current value */
-	hi  = ciab.tahi;
-	lo  = ciab.talo;
-	hi2 = ciab.tahi;
-
-	if (hi != hi2) {
-		lo = ciab.talo;
-		hi = hi2;
-	}
-
-	ticks = hi << 8 | lo;
-
-	if (ticks > jiffy_ticks / 2)
-		/* check for pending interrupt */
-		if (cia_get_irq_mask(IRQ_AMIGA_CIAB) & CIA_ICR_TA)
-			offset = 10000;
-
-	ticks = jiffy_ticks - ticks;
-	ticks = (10000 * ticks) / jiffy_ticks;
-
-	return ticks + offset;
-}
-
  static void a3000_gettod (int *yearp, int *monp, int *dayp,
  			  int *hourp, int *minp, int *secp)
  {
diff -ur linux-2.6.18-rt6/arch/ppc/platforms/apus_setup.c linux-2.6.18-rt6-rmdead/arch/ppc/platforms/apus_setup.c
--- linux-2.6.18-rt6/arch/ppc/platforms/apus_setup.c	2006-10-19 12:29:12.522073698 +0200
+++ linux-2.6.18-rt6-rmdead/arch/ppc/platforms/apus_setup.c	2006-10-19 14:07:54.462328850 +0200
@@ -46,7 +46,6 @@
  int (*mach_get_irq_list) (struct seq_file *, void *) = NULL;
  void (*mach_process_int) (int, struct pt_regs *) = NULL;
  /* machine dependent timer functions */
-unsigned long (*mach_gettimeoffset) (void);
  void (*mach_gettod) (int*, int*, int*, int*, int*, int*);
  int (*mach_hwclk) (int, struct hwclk_time*) = NULL;
  int (*mach_set_clock_mmss) (unsigned long) = NULL;
diff -ur linux-2.6.18-rt6/include/asm-arm/arch-ixp2000/platform.h linux-2.6.18-rt6-rmdead/include/asm-arm/arch-ixp2000/platform.h
--- linux-2.6.18-rt6/include/asm-arm/arch-ixp2000/platform.h	2006-04-05 18:36:31.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/include/asm-arm/arch-ixp2000/platform.h	2006-10-19 14:09:48.372591243 +0200
@@ -122,7 +122,6 @@
  void ixp2000_uart_init(void);
  void ixp2000_init_irq(void);
  void ixp2000_init_time(unsigned long);
-unsigned long ixp2000_gettimeoffset(void);

  struct pci_sys_data;

diff -ur linux-2.6.18-rt6/include/asm-arm/mach/time.h linux-2.6.18-rt6-rmdead/include/asm-arm/mach/time.h
--- linux-2.6.18-rt6/include/asm-arm/mach/time.h	2006-10-19 12:29:12.632049822 +0200
+++ linux-2.6.18-rt6-rmdead/include/asm-arm/mach/time.h	2006-10-19 13:35:07.016653879 +0200
@@ -28,10 +28,6 @@
   *   Resume the kernel jiffy timer source, if necessary.  This
   *   is called with interrupts disabled before any normal devices
   *   are resumed.  If no action is required, set this to NULL.
- * - offset
- *   Return the timer offset in microseconds since the last timer
- *   interrupt.  Note: this must take account of any unprocessed
- *   timer interrupt which may be pending.
   */
  struct sys_timer {
  	struct sys_device	dev;
@@ -39,10 +35,6 @@
  	void			(*suspend)(void);
  	void			(*resume)(void);

-#ifdef CONFIG_IS_TICK_BASED
-	unsigned long		(*offset)(void);
-#endif
-
  #ifdef CONFIG_NO_IDLE_HZ
  	struct dyn_tick_timer	*dyn_tick;
  #endif
diff -ur linux-2.6.18-rt6/include/asm-i386/mach-default/do_timer.h linux-2.6.18-rt6-rmdead/include/asm-i386/mach-default/do_timer.h
--- linux-2.6.18-rt6/include/asm-i386/mach-default/do_timer.h	2006-10-19 12:29:12.638048520 +0200
+++ linux-2.6.18-rt6-rmdead/include/asm-i386/mach-default/do_timer.h	2006-10-19 14:11:03.998168305 +0200
@@ -65,7 +65,7 @@

  		count -= 256;
  #else
-		printk("do_slow_gettimeoffset(): hardware timer problem?\n");
+		printk("do_timer_overflow(): hardware timer problem?\n");
  #endif
  	}
  	return count;
diff -ur linux-2.6.18-rt6/include/asm-i386/mach-visws/do_timer.h linux-2.6.18-rt6-rmdead/include/asm-i386/mach-visws/do_timer.h
--- linux-2.6.18-rt6/include/asm-i386/mach-visws/do_timer.h	2006-10-19 12:29:12.639048303 +0200
+++ linux-2.6.18-rt6-rmdead/include/asm-i386/mach-visws/do_timer.h	2006-10-19 14:12:31.833094415 +0200
@@ -50,7 +50,7 @@
  		 */
  		count -= LATCH;
  	} else {
-		printk("do_slow_gettimeoffset(): hardware timer problem?\n");
+		printk("do_timer_overflow(): hardware timer problem?\n");
  	}
  	return count;
  }
diff -ur linux-2.6.18-rt6/include/asm-mips/sibyte/sb1250.h linux-2.6.18-rt6-rmdead/include/asm-mips/sibyte/sb1250.h
--- linux-2.6.18-rt6/include/asm-mips/sibyte/sb1250.h	2006-04-05 18:44:17.000000000 +0200
+++ linux-2.6.18-rt6-rmdead/include/asm-mips/sibyte/sb1250.h	2006-10-19 14:14:19.154789479 +0200
@@ -52,7 +52,6 @@
  extern void sb1250_smp_finish(void);

  extern void bcm1480_time_init(void);
-extern unsigned long bcm1480_gettimeoffset(void);
  extern void bcm1480_mask_irq(int cpu, int irq);
  extern void bcm1480_unmask_irq(int cpu, int irq);
  extern void bcm1480_smp_finish(void);
diff -ur linux-2.6.18-rt6/include/asm-mips/time.h linux-2.6.18-rt6-rmdead/include/asm-mips/time.h
--- linux-2.6.18-rt6/include/asm-mips/time.h	2006-10-19 12:29:12.654045047 +0200
+++ linux-2.6.18-rt6-rmdead/include/asm-mips/time.h	2006-10-19 14:14:00.579822990 +0200
@@ -58,13 +58,6 @@
  extern void to_tm(unsigned long tim, struct rtc_time *tm);

  /*
- * do_gettimeoffset(). By default, this func pointer points to
- * do_null_gettimeoffset(), which leads to the same resolution as HZ.
- * Higher resolution versions are available, which give ~1us resolution.
- */
-extern unsigned long (*do_gettimeoffset)(void);
-
-/*
   * high-level timer interrupt routines.
   */
  extern irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs);
diff -ur linux-2.6.18-rt6/include/asm-x86_64/proto.h linux-2.6.18-rt6-rmdead/include/asm-x86_64/proto.h
--- linux-2.6.18-rt6/include/asm-x86_64/proto.h	2006-10-19 12:29:12.662043310 +0200
+++ linux-2.6.18-rt6-rmdead/include/asm-x86_64/proto.h	2006-10-19 14:15:52.360550392 +0200
@@ -41,7 +41,6 @@
  extern int pmtimer_mark_offset(void);
  extern void pmtimer_resume(void);
  extern void pmtimer_wait(unsigned);
-extern unsigned int do_gettimeoffset_pm(void);
  #ifdef CONFIG_X86_PM_TIMER
  extern u32 pmtmr_ioport;
  #else
