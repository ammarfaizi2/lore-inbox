Return-Path: <linux-kernel-owner+w=401wt.eu-S1422857AbWLUIfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422857AbWLUIfr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422830AbWLUIfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:35:47 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:65192 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422859AbWLUIfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:35:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:from;
        b=JIeRDGgNP+/wu1yz5E+GXtAK7TsVow5sDOix1oKINxLVStmWyhX2DGUZ25jMc9fr3aICalasU9K/JvtNxxHDFMUn3MRasRemqVgYDOun/9qSH/K1MFhsGe7Q3c5+OVyVpcABdZS1v+eqEP4kwfK0xFskpnTpjbVwyfW1hKxbzF8=
Message-ID: <458A475E.8080707@gmail.com>
Date: Thu, 21 Dec 2006 09:35:42 +0100
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH -rt 3/4] ARM: OMAP: Add clocksource driver for OMAP
Content-Type: multipart/mixed;
 boundary="------------060205010204060702050009"
From: Dirk Behme <dirk.behme@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060205010204060702050009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ARM: OMAP: Add clocksource driver for OMAP.

This is an update of

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3876/1

from Daniel Walker and Kevin Hilman.

Changes from Dirk Behme:

       - Apply cleanly to recent kernel (pt_regs change)
       - Move clocksource init to extra function. Can be called
         later by clocksource subsystem
       - Remove warning: 'omap_32k_timer_handler' defined but
not used
         when CONFIG_NO_IDLE_HZ isn't set.
       - Minor cleanups

Changes from David Brownell:

       - OMAP1, OMAP2: 32k clocksource is always available on
16xx and 24xx
       - OMAP1 MPU timer:
           * consult clock framework to determine xtal clock
           * bugfix sched_clock() low order bits
           * cleanup
       - Kconfig updates

Note that "MPU timer" still doesn't have lost tick support.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------060205010204060702050009
Content-Type: text/plain;
 name="arm_omap_clocksource_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arm_omap_clocksource_patch.txt"

Index: linux-2.6.20-rc1/arch/arm/Kconfig
===================================================================
--- linux-2.6.20-rc1.orig/arch/arm/Kconfig
+++ linux-2.6.20-rc1/arch/arm/Kconfig
@@ -340,6 +340,7 @@ config ARCH_LH7A40X
 
 config ARCH_OMAP
 	bool "TI OMAP"
+	select GENERIC_TIME
 	help
 	  Support for TI's OMAP platform (OMAP1 and OMAP2).
 
Index: linux-2.6.20-rc1/arch/arm/plat-omap/common.c
===================================================================
--- linux-2.6.20-rc1.orig/arch/arm/plat-omap/common.c
+++ linux-2.6.20-rc1/arch/arm/plat-omap/common.c
@@ -156,3 +156,53 @@ static int __init omap_add_serial_consol
 	return add_preferred_console("ttyS", line, opt);
 }
 console_initcall(omap_add_serial_console);
+
+
+/*
+ * 32KHz clocksource ... always available, on pretty most chips except
+ * OMAP 730 and 1510.  Other timers could be used as clocksources, with
+ * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
+ * but systems won't necessarily want to spend resources that way.
+ */
+
+#if defined(CONFIG_ARCH_OMAP16XX)
+#define TIMER_32K_SYNCHRONIZED		0xfffbc410
+#elif defined(CONFIG_ARCH_OMAP24XX)
+#define TIMER_32K_SYNCHRONIZED		0x48004010
+#endif
+
+#ifdef	TIMER_32K_SYNCHRONIZED
+
+#include <linux/clocksource.h>
+
+static cycle_t omap_32k_read(void)
+{
+	return omap_readl(TIMER_32K_SYNCHRONIZED);
+}
+
+static struct clocksource clocksource_32k = {
+	.name		= "32k_counter",
+	.rating		= 250,
+	.read		= omap_32k_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift		= 10,
+	.is_continuous	= 1,
+};
+
+static int __init omap_init_clocksource_32k(void)
+{
+	static char err[] __initdata = KERN_ERR
+			"%s: can't register clocksource!\n";
+
+	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
+		clocksource_32k.mult = clocksource_hz2mult(32768,
+					    clocksource_32k.shift);
+
+		if (clocksource_register(&clocksource_32k))
+			printk(err, clocksource_32k.name);
+	}
+	return 0;
+}
+arch_initcall(omap_init_clocksource_32k);
+
+#endif	/* TIMER_32K_SYNCHRONIZED */
Index: linux-2.6.20-rc1/arch/arm/plat-omap/timer32k.c
===================================================================
--- linux-2.6.20-rc1.orig/arch/arm/plat-omap/timer32k.c
+++ linux-2.6.20-rc1/arch/arm/plat-omap/timer32k.c
@@ -42,6 +42,7 @@
 #include <linux/spinlock.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/clocksource.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -171,15 +172,6 @@ omap_32k_ticks_to_nsecs(unsigned long ti
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
@@ -217,11 +209,6 @@ static inline irqreturn_t _omap_32k_time
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t omap_32k_timer_handler(int irq, void *dev_id)
-{
-	return _omap_32k_timer_interrupt(irq, dev_id);
-}
-
 static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
 {
 	unsigned long flags;
@@ -234,6 +221,7 @@ static irqreturn_t omap_32k_timer_interr
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
+
 /*
  * Programs the next timer interrupt needed. Called when dynamic tick is
  * enabled, and to reprogram the ticks to skip from pm_idle. Note that
@@ -269,6 +257,22 @@ static int omap_32k_timer_disable_dyn_ti
 	return 0;
 }
 
+static irqreturn_t omap_32k_timer_handler(int irq, void *dev_id)
+{
+	unsigned long now;
+
+	now = omap_32k_sync_timer_read();
+
+	/* Don't bother reprogramming timer if last tick was before next
+	 * jiffie. We will get another interrupt when previously programmed
+	 * timer expires. This cuts down interrupt load quite a bit.
+	 */
+	if (now - omap_32k_last_tick < OMAP_32K_TICKS_PER_HZ)
+		return IRQ_HANDLED;
+
+	return _omap_32k_timer_interrupt(irq, dev_id);
+}
+
 static struct dyn_tick_timer omap_dyn_tick_timer = {
 	.enable		= omap_32k_timer_enable_dyn_tick,
 	.disable	= omap_32k_timer_disable_dyn_tick,
@@ -291,7 +295,6 @@ static __init void omap_init_32k_timer(v
 
 	if (cpu_class_is_omap1())
 		setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
-	omap_timer.offset  = omap_32k_timer_gettimeoffset;
 	omap_32k_last_tick = omap_32k_sync_timer_read();
 
 #ifdef CONFIG_ARCH_OMAP2
@@ -326,5 +329,4 @@ static void __init omap_timer_init(void)
 
 struct sys_timer omap_timer = {
 	.init		= omap_timer_init,
-	.offset		= NULL,		/* Initialized later */
 };
Index: linux-2.6.20-rc1/arch/arm/mach-omap1/time.c
===================================================================
--- linux-2.6.20-rc1.orig/arch/arm/mach-omap1/time.c
+++ linux-2.6.20-rc1/arch/arm/mach-omap1/time.c
@@ -39,6 +39,9 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/clocksource.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -48,13 +51,7 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
-struct sys_timer omap_timer;
 
-/*
- * ---------------------------------------------------------------------------
- * MPU timer
- * ---------------------------------------------------------------------------
- */
 #define OMAP_MPU_TIMER_BASE		OMAP_MPU_TIMER1_BASE
 #define OMAP_MPU_TIMER_OFFSET		0x100
 
@@ -88,21 +85,6 @@ static inline unsigned long long cycles_
 	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
 }
 
-/*
- * MPU_TICKS_PER_SEC must be an even number, otherwise machinecycles_to_usecs
- * will break. On P2, the timer count rate is 6.5 MHz after programming PTV
- * with 0. This divides the 13MHz input by 2, and is undocumented.
- */
-#if defined(CONFIG_MACH_OMAP_PERSEUS2) || defined(CONFIG_MACH_OMAP_FSAMPLE)
-/* REVISIT: This ifdef construct should be replaced by a query to clock
- * framework to see if timer base frequency is 12.0, 13.0 or 19.2 MHz.
- */
-#define MPU_TICKS_PER_SEC		(13000000 / 2)
-#else
-#define MPU_TICKS_PER_SEC		(12000000 / 2)
-#endif
-
-#define MPU_TIMER_TICK_PERIOD		((MPU_TICKS_PER_SEC / HZ) - 1)
 
 typedef struct {
 	u32 cntl;			/* CNTL_TIMER, R/W */
@@ -131,87 +113,94 @@ static inline void omap_mpu_timer_start(
 	timer->cntl = (MPU_TIMER_CLOCK_ENABLE | MPU_TIMER_AR | MPU_TIMER_ST);
 }
 
-unsigned long omap_mpu_timer_ticks_to_usecs(unsigned long nr_ticks)
+/*
+ * ---------------------------------------------------------------------------
+ * MPU timer 1 ... count down to zero, interrupt, reload
+ * ---------------------------------------------------------------------------
+ */
+static irqreturn_t omap_mpu_timer1_interrupt(int irq, void *dev_id)
 {
-	unsigned long long nsec;
+	write_seqlock(&xtime_lock);
+	/* NOTE:  no lost-tick detection/handling! */
+	timer_tick();
+	write_sequnlock(&xtime_lock);
 
-	nsec = cycles_2_ns((unsigned long long)nr_ticks);
-	return (unsigned long)nsec / 1000;
+	return IRQ_HANDLED;
 }
 
-/*
- * Last processed system timer interrupt
- */
-static unsigned long omap_mpu_timer_last = 0;
+static struct irqaction omap_mpu_timer1_irq = {
+	.name		= "mpu_timer1",
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.handler	= omap_mpu_timer1_interrupt,
+};
 
-/*
- * Returns elapsed usecs since last system timer interrupt
- */
-static unsigned long omap_mpu_timer_gettimeoffset(void)
+static __init void omap_init_mpu_timer(unsigned long rate)
 {
-	unsigned long now = 0 - omap_mpu_timer_read(0);
-	unsigned long elapsed = now - omap_mpu_timer_last;
+	set_cyc2ns_scale(rate / 1000);
 
-	return omap_mpu_timer_ticks_to_usecs(elapsed);
+	setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
+	omap_mpu_timer_start(0, (rate / HZ) - 1);
 }
 
 /*
- * Elapsed time between interrupts is calculated using timer0.
- * Latency during the interrupt is calculated using timer1.
- * Both timer0 and timer1 are counting at 6MHz (P2 6.5MHz).
+ * ---------------------------------------------------------------------------
+ * MPU timer 2 ... free running 32-bit clock source and scheduler clock
+ * ---------------------------------------------------------------------------
  */
-static irqreturn_t omap_mpu_timer_interrupt(int irq, void *dev_id)
-{
-	unsigned long now, latency;
 
-	write_seqlock(&xtime_lock);
-	now = 0 - omap_mpu_timer_read(0);
-	latency = MPU_TICKS_PER_SEC / HZ - omap_mpu_timer_read(1);
-	omap_mpu_timer_last = now - latency;
-	timer_tick();
-	write_sequnlock(&xtime_lock);
+static unsigned long omap_mpu_timer2_overflows;
 
+static irqreturn_t omap_mpu_timer2_interrupt(int irq, void *dev_id)
+{
+	omap_mpu_timer2_overflows++;
 	return IRQ_HANDLED;
 }
 
-static struct irqaction omap_mpu_timer_irq = {
-	.name		= "mpu timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
-	.handler	= omap_mpu_timer_interrupt,
+static struct irqaction omap_mpu_timer2_irq = {
+	.name		= "mpu_timer2",
+	.flags		= IRQF_DISABLED,
+	.handler	= omap_mpu_timer2_interrupt,
 };
 
-static unsigned long omap_mpu_timer1_overflows;
-static irqreturn_t omap_mpu_timer1_interrupt(int irq, void *dev_id)
+static cycle_t mpu_read(void)
 {
-	omap_mpu_timer1_overflows++;
-	return IRQ_HANDLED;
+	return ~omap_mpu_timer_read(1);
 }
 
-static struct irqaction omap_mpu_timer1_irq = {
-	.name		= "mpu timer1 overflow",
-	.flags		= IRQF_DISABLED,
-	.handler	= omap_mpu_timer1_interrupt,
+static struct clocksource clocksource_mpu = {
+	.name		= "mpu_timer2",
+	.rating		= 300,
+	.read		= mpu_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift		= 24,
+	.is_continuous	= 1,
 };
 
-static __init void omap_init_mpu_timer(void)
+static void __init omap_init_clocksource(unsigned long rate)
 {
-	set_cyc2ns_scale(MPU_TICKS_PER_SEC / 1000);
-	omap_timer.offset = omap_mpu_timer_gettimeoffset;
-	setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
-	setup_irq(INT_TIMER2, &omap_mpu_timer_irq);
-	omap_mpu_timer_start(0, 0xffffffff);
-	omap_mpu_timer_start(1, MPU_TIMER_TICK_PERIOD);
+	static char err[] __initdata = KERN_ERR
+			"%s: can't register clocksource!\n";
+
+	clocksource_mpu.mult
+		= clocksource_khz2mult(rate/1000, clocksource_mpu.shift);
+
+	setup_irq(INT_TIMER2, &omap_mpu_timer2_irq);
+	omap_mpu_timer_start(1, ~0);
+
+	if (clocksource_register(&clocksource_mpu))
+		printk(err, clocksource_mpu.name);
 }
 
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
 unsigned long long sched_clock(void)
 {
-	unsigned long ticks = 0 - omap_mpu_timer_read(0);
+	unsigned long ticks = 0 - omap_mpu_timer_read(1);
 	unsigned long long ticks64;
 
-	ticks64 = omap_mpu_timer1_overflows;
+	ticks64 = omap_mpu_timer2_overflows;
 	ticks64 <<= 32;
 	ticks64 |= ticks;
 
@@ -225,10 +214,21 @@ unsigned long long sched_clock(void)
  */
 static void __init omap_timer_init(void)
 {
-	omap_init_mpu_timer();
+	struct clk	*ck_ref = clk_get(NULL, "ck_ref");
+	unsigned long	rate;
+
+	BUG_ON(IS_ERR(ck_ref));
+
+	rate = clk_get_rate(ck_ref);
+	clk_put(ck_ref);
+
+	/* PTV = 0 */
+	rate /= 2;
+
+	omap_init_mpu_timer(rate);
+	omap_init_clocksource(rate);
 }
 
 struct sys_timer omap_timer = {
 	.init		= omap_timer_init,
-	.offset		= NULL,		/* Initialized later */
 };


--------------060205010204060702050009--
