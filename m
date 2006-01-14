Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWANWz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWANWz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWANWz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:55:57 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:30851 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751464AbWANWz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:55:56 -0500
Date: Sun, 15 Jan 2006 00:55:55 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] sh: Simple timer framework.
Message-ID: <20060114225555.GI4045@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060114225018.GB4045@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114225018.GB4045@linux-sh.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This builds on some of the clock framework code to support a simple
system timer interface.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/kernel/timers/Makefile    |    8 +
 arch/sh/kernel/timers/timer-tmu.c |  229 ++++++++++++++++++++++++++++++++++++++
 arch/sh/kernel/timers/timer.c     |   50 ++++++++
 include/asm-sh/timer.h            |   42 ++++++
 4 files changed, 329 insertions(+)

diff -urN -X exclude linux-2.6.15/arch/sh/kernel/timers/Makefile sh-2.6.15/arch/sh/kernel/timers/Makefile
--- linux-2.6.15/arch/sh/kernel/timers/Makefile	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/timers/Makefile	2006-01-04 00:15:28.000000000 +0200
@@ -0,0 +1,8 @@
+#
+# Makefile for the various Linux/SuperH timers
+#
+
+obj-y	:= timer.o
+
+obj-$(CONFIG_SH_TMU)		+= timer-tmu.o
+
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/timers/timer-tmu.c sh-2.6.15/arch/sh/kernel/timers/timer-tmu.c
--- linux-2.6.15/arch/sh/kernel/timers/timer-tmu.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/timers/timer-tmu.c	2006-01-04 00:15:28.000000000 +0200
@@ -0,0 +1,229 @@
+/*
+ * arch/sh/kernel/timers/timer-tmu.c - TMU Timer Support
+ *
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * TMU handling code hacked out of arch/sh/kernel/time.c
+ *
+ *  Copyright (C) 1999  Tetsuya Okada & Niibe Yutaka
+ *  Copyright (C) 2000  Philipp Rumpf <prumpf@tux.org>
+ *  Copyright (C) 2002, 2003, 2004  Paul Mundt
+ *  Copyright (C) 2002  M. R. Brown  <mrbrown@linux-sh.org>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/seqlock.h>
+#include <asm/timer.h>
+#include <asm/rtc.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/clock.h>
+
+#define TMU_TOCR_INIT	0x00
+#define TMU0_TCR_INIT	0x0020
+#define TMU_TSTR_INIT	1
+
+#define TMU0_TCR_CALIB	0x0000
+
+static DEFINE_SPINLOCK(tmu0_lock);
+
+static unsigned long tmu_timer_get_offset(void)
+{
+	int count;
+	unsigned long flags;
+
+	static int count_p = 0x7fffffff;    /* for the first call after boot */
+	static unsigned long jiffies_p = 0;
+
+	/*
+	 * cache volatile jiffies temporarily; we have IRQs turned off.
+	 */
+	unsigned long jiffies_t;
+
+	spin_lock_irqsave(&tmu0_lock, flags);
+	/* timer count may underflow right here */
+	count = ctrl_inl(TMU0_TCNT);	/* read the latched count */
+
+	jiffies_t = jiffies;
+
+	/*
+	 * avoiding timer inconsistencies (they are rare, but they happen)...
+	 * there is one kind of problem that must be avoided here:
+	 *  1. the timer counter underflows
+	 */
+
+	if (jiffies_t == jiffies_p) {
+		if (count > count_p) {
+			/* the nutcase */
+			if (ctrl_inw(TMU0_TCR) & 0x100) { /* Check UNF bit */
+				count -= LATCH;
+			} else {
+				printk("%s (): hardware timer problem?\n",
+				       __FUNCTION__);
+			}
+		}
+	} else
+		jiffies_p = jiffies_t;
+
+	count_p = count;
+	spin_unlock_irqrestore(&tmu0_lock, flags);
+
+	count = ((LATCH-1) - count) * TICK_SIZE;
+	count = (count + LATCH/2) / LATCH;
+
+	return count;
+}
+
+static irqreturn_t tmu_timer_interrupt(int irq, void *dev_id,
+				       struct pt_regs *regs)
+{
+	unsigned long timer_status;
+
+	/* Clear UNF bit */
+	timer_status = ctrl_inw(TMU0_TCR);
+	timer_status &= ~0x100;
+	ctrl_outw(timer_status, TMU0_TCR);
+
+	/*
+	 * Here we are in the timer irq handler. We just have irqs locally
+	 * disabled but we don't know if the timer_bh is running on the other
+	 * CPU. We need to avoid to SMP race with it. NOTE: we don' t need
+	 * the irq version of write_lock because as just said we have irq
+	 * locally disabled. -arca
+	 */
+	write_seqlock(&xtime_lock);
+	handle_timer_tick(regs);
+	write_sequnlock(&xtime_lock);
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction tmu_irq = {
+	.name		= "timer",
+	.handler	= tmu_timer_interrupt,
+	.flags		= SA_INTERRUPT,
+	.mask		= CPU_MASK_NONE,
+};
+
+/*
+ * Hah!  We'll see if this works (switching from usecs to nsecs).
+ */
+static unsigned long tmu_timer_get_frequency(void)
+{
+	u32 freq;
+	struct timespec ts1, ts2;
+	unsigned long diff_nsec;
+	unsigned long factor;
+
+	/* Setup the timer:  We don't want to generate interrupts, just
+	 * have it count down at its natural rate.
+	 */
+	ctrl_outb(0, TMU_TSTR);
+#if !defined(CONFIG_CPU_SUBTYPE_SH7300) && !defined(CONFIG_CPU_SUBTYPE_SH7760)
+	ctrl_outb(TMU_TOCR_INIT, TMU_TOCR);
+#endif
+	ctrl_outw(TMU0_TCR_CALIB, TMU0_TCR);
+	ctrl_outl(0xffffffff, TMU0_TCOR);
+	ctrl_outl(0xffffffff, TMU0_TCNT);
+
+	rtc_get_time(&ts2);
+
+	do {
+		rtc_get_time(&ts1);
+	} while (ts1.tv_nsec == ts2.tv_nsec && ts1.tv_sec == ts2.tv_sec);
+
+	/* actually start the timer */
+	ctrl_outb(TMU_TSTR_INIT, TMU_TSTR);
+
+	do {
+		rtc_get_time(&ts2);
+	} while (ts1.tv_nsec == ts2.tv_nsec && ts1.tv_sec == ts2.tv_sec);
+
+	freq = 0xffffffff - ctrl_inl(TMU0_TCNT);
+	if (ts2.tv_nsec < ts1.tv_nsec) {
+		ts2.tv_nsec += 1000000000;
+		ts2.tv_sec--;
+	}
+
+	diff_nsec = (ts2.tv_sec - ts1.tv_sec) * 1000000000 + (ts2.tv_nsec - ts1.tv_nsec);
+
+	/* this should work well if the RTC has a precision of n Hz, where
+	 * n is an integer.  I don't think we have to worry about the other
+	 * cases. */
+	factor = (1000000000 + diff_nsec/2) / diff_nsec;
+
+	if (factor * diff_nsec > 1100000000 ||
+	    factor * diff_nsec <  900000000)
+		panic("weird RTC (diff_nsec %ld)", diff_nsec);
+
+	return freq * factor;
+}
+
+static void tmu_clk_init(struct clk *clk)
+{
+	u8 divisor = TMU0_TCR_INIT & 0x7;
+	ctrl_outw(TMU0_TCR_INIT, TMU0_TCR);
+	clk->rate = clk->parent->rate / (4 << (divisor << 1));
+}
+
+static void tmu_clk_recalc(struct clk *clk)
+{
+	u8 divisor = ctrl_inw(TMU0_TCR) & 0x7;
+	clk->rate = clk->parent->rate / (4 << (divisor << 1));
+}
+
+static struct clk_ops tmu_clk_ops = {
+	.init		= tmu_clk_init,
+	.recalc		= tmu_clk_recalc,
+};
+
+static struct clk tmu0_clk = {
+	.name		= "tmu0_clk",
+	.ops		= &tmu_clk_ops,
+};
+
+static int tmu_timer_init(void)
+{
+	unsigned long interval;
+
+	setup_irq(TIMER_IRQ, &tmu_irq);
+
+	tmu0_clk.parent = clk_get("module_clk");
+
+	/* Start TMU0 */
+	ctrl_outb(0, TMU_TSTR);
+#if !defined(CONFIG_CPU_SUBTYPE_SH7300) && !defined(CONFIG_CPU_SUBTYPE_SH7760)
+	ctrl_outb(TMU_TOCR_INIT, TMU_TOCR);
+#endif
+
+	clk_register(&tmu0_clk);
+	clk_enable(&tmu0_clk);
+
+	interval = (clk_get_rate(&tmu0_clk) + HZ / 2) / HZ;
+	printk(KERN_INFO "Interval = %ld\n", interval);
+
+	ctrl_outl(interval, TMU0_TCOR);
+	ctrl_outl(interval, TMU0_TCNT);
+
+	ctrl_outb(TMU_TSTR_INIT, TMU_TSTR);
+
+	return 0;
+}
+
+struct sys_timer_ops tmu_timer_ops = {
+	.init		= tmu_timer_init,
+	.get_frequency	= tmu_timer_get_frequency,
+	.get_offset	= tmu_timer_get_offset,
+};
+
+struct sys_timer tmu_timer = {
+	.name	= "tmu",
+	.ops	= &tmu_timer_ops,
+};
+
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/timers/timer.c sh-2.6.15/arch/sh/kernel/timers/timer.c
--- linux-2.6.15/arch/sh/kernel/timers/timer.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/timers/timer.c	2006-01-04 00:15:28.000000000 +0200
@@ -0,0 +1,50 @@
+/*
+ * arch/sh/kernel/timers/timer.c - Common timer code
+ *
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/timer.h>
+#include <linux/string.h>
+#include <asm/timer.h>
+
+static struct sys_timer *sys_timers[] __initdata = {
+#ifdef CONFIG_SH_TMU
+	&tmu_timer,
+#endif
+	NULL,
+};
+
+static char timer_override[10] __initdata;
+static int __init timer_setup(char *str)
+{
+	if (str)
+		strlcpy(timer_override, str, sizeof(timer_override));
+	return 1;
+}
+__setup("timer=", timer_setup);
+
+struct sys_timer *get_sys_timer(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sys_timers); i++) {
+		struct sys_timer *t = sys_timers[i];
+
+		if (unlikely(!t))
+			break;
+		if (unlikely(timer_override[0]))
+			if ((strcmp(timer_override, t->name) != 0))
+				continue;
+		if (likely(t->ops->init() == 0))
+			return t;
+	}
+
+	return NULL;
+}
+

diff -urN -X exclude linux-2.6.15/include/asm-sh/timer.h sh-2.6.15/include/asm-sh/timer.h
--- linux-2.6.15/include/asm-sh/timer.h	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/include/asm-sh/timer.h	2006-01-04 00:15:30.000000000 +0200
@@ -0,0 +1,42 @@
+#ifndef __ASM_SH_TIMER_H
+#define __ASM_SH_TIMER_H
+
+#include <linux/sysdev.h>
+#include <asm/cpu/timer.h>
+
+struct sys_timer_ops {
+	int (*init)(void);
+	unsigned long (*get_offset)(void);
+	unsigned long (*get_frequency)(void);
+};
+
+struct sys_timer {
+	const char		*name;
+
+	struct sys_device	dev;
+	struct sys_timer_ops	*ops;
+};
+
+#define TICK_SIZE (tick_nsec / 1000)
+
+extern struct sys_timer tmu_timer;
+extern struct sys_timer *sys_timer;
+
+static inline unsigned long get_timer_offset(void)
+{
+	return sys_timer->ops->get_offset();
+}
+
+static inline unsigned long get_timer_frequency(void)
+{
+	return sys_timer->ops->get_frequency();
+}
+
+/* arch/sh/kernel/timers/timer.c */
+struct sys_timer *get_sys_timer(void);
+
+/* arch/sh/kernel/time.c */
+void handle_timer_tick(struct pt_regs *);
+
+#endif /* __ASM_SH_TIMER_H */
+
