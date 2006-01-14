Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWANWzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWANWzU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWANWzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:55:20 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:25219 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751361AbWANWzR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:55:17 -0500
Date: Sun, 15 Jan 2006 00:55:11 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] sh: Simplistic clock framework.
Message-ID: <20060114225511.GH4045@linux-sh.org>
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

This adds a relatively simplistic clock framework for sh. The initial
goal behind this is to clean up the arch/sh/kernel/time.c mess and to get
the CPU subtype-specific frequency setting and calculation code moved
somewhere more sensible.

This only deals with the core clocks at the moment, though it's trivial
for other drivers to define their own clocks as desired.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 arch/sh/boards/overdrive/Makefile      |    2 
 arch/sh/boards/overdrive/setup.c       |    6 
 arch/sh/boards/overdrive/time.c        |  119 -------
 arch/sh/kernel/cpu/clock.c             |  287 ++++++++++++++++++
 arch/sh/kernel/cpu/sh3/Makefile        |    7 
 arch/sh/kernel/cpu/sh3/clock-sh3.c     |   89 +++++
 arch/sh/kernel/cpu/sh3/clock-sh7300.c  |   78 ++++
 arch/sh/kernel/cpu/sh3/clock-sh7705.c  |   84 +++++
 arch/sh/kernel/cpu/sh3/clock-sh7709.c  |   96 ++++++
 arch/sh/kernel/cpu/sh4/Makefile        |   13 
 arch/sh/kernel/cpu/sh4/clock-sh4-202.c |  179 +++++++++++
 arch/sh/kernel/cpu/sh4/clock-sh4.c     |   80 +++++
 arch/sh/kernel/cpu/sh4/clock-sh73180.c |   81 +++++
 arch/sh/kernel/cpu/sh4/clock-sh7770.c  |   73 ++++
 arch/sh/kernel/cpu/sh4/clock-sh7780.c  |  126 ++++++++
 arch/sh/kernel/time.c                  |  518 ++-------------------------------
 include/asm-sh/clock.h                 |   61 +++
 include/asm-sh/cpu-sh4/freq.h          |    2 
 include/asm-sh/freq.h                  |   11 
 19 files changed, 1288 insertions(+), 624 deletions(-)

diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/clock.c sh-2.6.15/arch/sh/kernel/cpu/clock.c
--- linux-2.6.15/arch/sh/kernel/cpu/clock.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/clock.c	2006-01-04 00:15:27.000000000 +0200
@@ -0,0 +1,287 @@
+/*
+ * arch/sh/kernel/cpu/clock.c - SuperH clock framework
+ *
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * This clock framework is derived from the OMAP version by:
+ *
+ *	Copyright (C) 2004 Nokia Corporation
+ *	Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/list.h>
+#include <linux/kref.h>
+#include <linux/seq_file.h>
+#include <linux/err.h>
+#include <asm/clock.h>
+#include <asm/timer.h>
+
+static LIST_HEAD(clock_list);
+static DEFINE_SPINLOCK(clock_lock);
+static DECLARE_MUTEX(clock_list_sem);
+
+/*
+ * Each subtype is expected to define the init routines for these clocks,
+ * as each subtype (or processor family) will have these clocks at the
+ * very least. These are all provided through the CPG, which even some of
+ * the more quirky parts (such as ST40, SH4-202, etc.) still have.
+ *
+ * The processor-specific code is expected to register any additional
+ * clock sources that are of interest.
+ */
+static struct clk master_clk = {
+	.name		= "master_clk",
+	.flags		= CLK_ALWAYS_ENABLED | CLK_RATE_PROPAGATES,
+#ifdef CONFIG_SH_PCLK_FREQ_BOOL
+	.rate		= CONFIG_SH_PCLK_FREQ,
+#endif
+};
+
+static struct clk module_clk = {
+	.name		= "module_clk",
+	.parent		= &master_clk,
+	.flags		= CLK_ALWAYS_ENABLED | CLK_RATE_PROPAGATES,
+};
+
+static struct clk bus_clk = {
+	.name		= "bus_clk",
+	.parent		= &master_clk,
+	.flags		= CLK_ALWAYS_ENABLED | CLK_RATE_PROPAGATES,
+};
+
+static struct clk cpu_clk = {
+	.name		= "cpu_clk",
+	.parent		= &master_clk,
+	.flags		= CLK_ALWAYS_ENABLED,
+};
+
+/*
+ * The ordering of these clocks matters, do not change it.
+ */
+static struct clk *onchip_clocks[] = {
+	&master_clk,
+	&module_clk,
+	&bus_clk,
+	&cpu_clk,
+};
+
+static void propagate_rate(struct clk *clk)
+{
+	struct clk *clkp;
+
+	list_for_each_entry(clkp, &clock_list, node) {
+		if (likely(clkp->parent != clk))
+			continue;
+		if (likely(clkp->ops && clkp->ops->recalc))
+			clkp->ops->recalc(clkp);
+	}
+}
+
+int __clk_enable(struct clk *clk)
+{
+	/*
+	 * See if this is the first time we're enabling the clock, some
+	 * clocks that are always enabled still require "special"
+	 * initialization. This is especially true if the clock mode
+	 * changes and the clock needs to hunt for the proper set of
+	 * divisors to use before it can effectively recalc.
+	 */
+	if (unlikely(atomic_read(&clk->kref.refcount) == 1))
+		if (clk->ops && clk->ops->init)
+			clk->ops->init(clk);
+
+	if (clk->flags & CLK_ALWAYS_ENABLED)
+		return 0;
+
+	if (likely(clk->ops && clk->ops->enable))
+		clk->ops->enable(clk);
+
+	kref_get(&clk->kref);
+	return 0;
+}
+
+int clk_enable(struct clk *clk)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&clock_lock, flags);
+	ret = __clk_enable(clk);
+	spin_unlock_irqrestore(&clock_lock, flags);
+
+	return ret;
+}
+
+static void clk_kref_release(struct kref *kref)
+{
+	/* Nothing to do */
+}
+
+void __clk_disable(struct clk *clk)
+{
+	if (clk->flags & CLK_ALWAYS_ENABLED)
+		return;
+
+	kref_put(&clk->kref, clk_kref_release);
+}
+
+void clk_disable(struct clk *clk)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clock_lock, flags);
+	__clk_disable(clk);
+	spin_unlock_irqrestore(&clock_lock, flags);
+}
+
+int clk_register(struct clk *clk)
+{
+	down(&clock_list_sem);
+
+	list_add(&clk->node, &clock_list);
+	kref_init(&clk->kref);
+
+	up(&clock_list_sem);
+
+	return 0;
+}
+
+void clk_unregister(struct clk *clk)
+{
+	down(&clock_list_sem);
+	list_del(&clk->node);
+	up(&clock_list_sem);
+}
+
+inline unsigned long clk_get_rate(struct clk *clk)
+{
+	return clk->rate;
+}
+
+int clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	int ret = -EOPNOTSUPP;
+
+	if (likely(clk->ops && clk->ops->set_rate)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&clock_lock, flags);
+		ret = clk->ops->set_rate(clk, rate);
+		spin_unlock_irqrestore(&clock_lock, flags);
+	}
+
+	if (unlikely(clk->flags & CLK_RATE_PROPAGATES))
+		propagate_rate(clk);
+
+	return ret;
+}
+
+void clk_recalc_rate(struct clk *clk)
+{
+	if (likely(clk->ops && clk->ops->recalc)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&clock_lock, flags);
+		clk->ops->recalc(clk);
+		spin_unlock_irqrestore(&clock_lock, flags);
+	}
+
+	if (unlikely(clk->flags & CLK_RATE_PROPAGATES))
+		propagate_rate(clk);
+}
+
+struct clk *clk_get(const char *id)
+{
+	struct clk *p, *clk = ERR_PTR(-ENOENT);
+
+	down(&clock_list_sem);
+	list_for_each_entry(p, &clock_list, node) {
+		if (strcmp(id, p->name) == 0 && try_module_get(p->owner)) {
+			clk = p;
+			break;
+		}
+	}
+	up(&clock_list_sem);
+
+	return clk;
+}
+
+void clk_put(struct clk *clk)
+{
+	if (clk && !IS_ERR(clk))
+		module_put(clk->owner);
+}
+
+void __init __attribute__ ((weak))
+arch_init_clk_ops(struct clk_ops **ops, int type)
+{
+}
+
+int __init clk_init(void)
+{
+	int i, ret = 0;
+
+	if (unlikely(!master_clk.rate))
+		/*
+		 * NOTE: This will break if the default divisor has been
+		 * changed.
+		 *
+		 * No one should be changing the default on us however,
+		 * expect that a sane value for CONFIG_SH_PCLK_FREQ will
+		 * be defined in the event of a different divisor.
+		 */
+		master_clk.rate = get_timer_frequency() * 4;
+
+	for (i = 0; i < ARRAY_SIZE(onchip_clocks); i++) {
+		struct clk *clk = onchip_clocks[i];
+
+		arch_init_clk_ops(&clk->ops, i);
+		ret |= clk_register(clk);
+		clk_enable(clk);
+	}
+
+	/* Kick the child clocks.. */
+	propagate_rate(&master_clk);
+	propagate_rate(&bus_clk);
+
+	return ret;
+}
+
+int show_clocks(struct seq_file *m)
+{
+	struct clk *clk;
+
+	list_for_each_entry_reverse(clk, &clock_list, node) {
+		unsigned long rate = clk_get_rate(clk);
+
+		/*
+		 * Don't bother listing dummy clocks with no ancestry
+		 * that only support enable and disable ops.
+		 */
+		if (unlikely(!rate && !clk->parent))
+			continue;
+
+		seq_printf(m, "%-12s\t: %ld.%02ldMHz\n", clk->name,
+			   rate / 1000000, (rate % 1000000) / 10000);
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(clk_register);
+EXPORT_SYMBOL_GPL(clk_unregister);
+EXPORT_SYMBOL_GPL(clk_get);
+EXPORT_SYMBOL_GPL(clk_put);
+EXPORT_SYMBOL_GPL(clk_enable);
+EXPORT_SYMBOL_GPL(clk_disable);
+EXPORT_SYMBOL_GPL(__clk_enable);
+EXPORT_SYMBOL_GPL(__clk_disable);
+EXPORT_SYMBOL_GPL(clk_get_rate);
+EXPORT_SYMBOL_GPL(clk_set_rate);
+EXPORT_SYMBOL_GPL(clk_recalc_rate);

diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/sh3/Makefile sh-2.6.15/arch/sh/kernel/cpu/sh3/Makefile
--- linux-2.6.15/arch/sh/kernel/cpu/sh3/Makefile	2004-12-26 05:37:10.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/sh3/Makefile	2006-01-04 00:15:27.000000000 +0200
@@ -4,3 +4,10 @@
 
 obj-y	:= ex.o probe.o
 
+clock-$(CONFIG_CPU_SH3)			:= clock-sh3.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7300)	:= clock-sh7300.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7705)	:= clock-sh7705.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7709)	:= clock-sh7709.o
+
+obj-y	+= $(clock-y)
+
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh3.c sh-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh3.c
--- linux-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh3.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh3.c	2006-01-04 00:15:27.000000000 +0200
@@ -0,0 +1,89 @@
+/*
+ * arch/sh/kernel/cpu/sh3/clock-sh3.c
+ *
+ * Generic SH-3 support for the clock framework
+ *
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * FRQCR parsing hacked out of arch/sh/kernel/time.c
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
+#include <asm/clock.h>
+#include <asm/freq.h>
+#include <asm/io.h>
+
+static int stc_multipliers[] = { 1, 2, 3, 4, 6, 1, 1, 1 };
+static int ifc_divisors[]    = { 1, 2, 3, 4, 1, 1, 1, 1 };
+static int pfc_divisors[]    = { 1, 2, 3, 4, 6, 1, 1, 1 };
+
+static void master_clk_init(struct clk *clk)
+{
+	int frqcr = ctrl_inw(FRQCR);
+	int idx = ((frqcr & 0x2000) >> 11) | (frqcr & 0x0003);
+
+	clk->rate *= pfc_divisors[idx];
+}
+
+static struct clk_ops sh3_master_clk_ops = {
+	.init		= master_clk_init,
+};
+
+static void module_clk_recalc(struct clk *clk)
+{
+	int frqcr = ctrl_inw(FRQCR);
+	int idx = ((frqcr & 0x2000) >> 11) | (frqcr & 0x0003);
+
+	clk->rate = clk->parent->rate / pfc_divisors[idx];
+}
+
+static struct clk_ops sh3_module_clk_ops = {
+	.recalc		= module_clk_recalc,
+};
+
+static void bus_clk_recalc(struct clk *clk)
+{
+	int frqcr = ctrl_inw(FRQCR);
+	int idx = ((frqcr & 0x8000) >> 13) | ((frqcr & 0x0030) >> 4);
+
+	clk->rate = clk->parent->rate / stc_multipliers[idx];
+}
+
+static struct clk_ops sh3_bus_clk_ops = {
+	.recalc		= bus_clk_recalc,
+};
+
+static void cpu_clk_recalc(struct clk *clk)
+{
+	int frqcr = ctrl_inw(FRQCR);
+	int idx = ((frqcr & 0x4000) >> 12) | ((frqcr & 0x000c) >> 2);
+
+	clk->rate = clk->parent->rate / ifc_divisors[idx];
+}
+
+static struct clk_ops sh3_cpu_clk_ops = {
+	.recalc		= cpu_clk_recalc,
+};
+
+static struct clk_ops *sh3_clk_ops[] = {
+	&sh3_master_clk_ops,
+	&sh3_module_clk_ops,
+	&sh3_bus_clk_ops,
+	&sh3_cpu_clk_ops,
+};
+
+void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+{
+	if (idx < ARRAY_SIZE(sh3_clk_ops))
+		*ops = sh3_clk_ops[idx];
+}
+
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh7300.c sh-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh7300.c
--- linux-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh7300.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh7300.c	2006-01-04 00:15:27.000000000 +0200
@@ -0,0 +1,78 @@
+/*
+ * arch/sh/kernel/cpu/sh3/clock-sh7300.c
+ *
+ * SH7300 support for the clock framework
+ *
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * FRQCR parsing hacked out of arch/sh/kernel/time.c
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
+#include <asm/clock.h>
+#include <asm/freq.h>
+#include <asm/io.h>
+
+static int md_table[] = { 1, 2, 3, 4, 6, 8, 12 };
+
+static void master_clk_init(struct clk *clk)
+{
+	clk->rate *= md_table[ctrl_inw(FRQCR) & 0x0007];
+}
+
+static struct clk_ops sh7300_master_clk_ops = {
+	.init		= master_clk_init,
+};
+
+static void module_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inw(FRQCR) & 0x0007);
+	clk->rate = clk->parent->rate / md_table[idx];
+}
+
+static struct clk_ops sh7300_module_clk_ops = {
+	.recalc		= module_clk_recalc,
+};
+
+static void bus_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inw(FRQCR) & 0x0700) >> 8;
+	clk->rate = clk->parent->rate / md_table[idx];
+}
+
+static struct clk_ops sh7300_bus_clk_ops = {
+	.recalc		= bus_clk_recalc,
+};
+
+static void cpu_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inw(FRQCR) & 0x0070) >> 4;
+	clk->rate = clk->parent->rate / md_table[idx];
+}
+
+static struct clk_ops sh7300_cpu_clk_ops = {
+	.recalc		= cpu_clk_recalc,
+};
+
+static struct clk_ops *sh7300_clk_ops[] = {
+	&sh7300_master_clk_ops,
+	&sh7300_module_clk_ops,
+	&sh7300_bus_clk_ops,
+	&sh7300_cpu_clk_ops,
+};
+
+void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+{
+	if (idx < ARRAY_SIZE(sh7300_clk_ops))
+		*ops = sh7300_clk_ops[idx];
+}
+
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh7705.c sh-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh7705.c
--- linux-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh7705.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh7705.c	2006-01-04 00:15:27.000000000 +0200
@@ -0,0 +1,84 @@
+/*
+ * arch/sh/kernel/cpu/sh3/clock-sh7705.c
+ *
+ * SH7705 support for the clock framework
+ *
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * FRQCR parsing hacked out of arch/sh/kernel/time.c
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
+#include <asm/clock.h>
+#include <asm/freq.h>
+#include <asm/io.h>
+
+/*
+ * SH7705 uses the same divisors as the generic SH-3 case, it's just the
+ * FRQCR layout that is a bit different..
+ */
+static int stc_multipliers[] = { 1, 2, 3, 4, 6, 1, 1, 1 };
+static int ifc_divisors[]    = { 1, 2, 3, 4, 1, 1, 1, 1 };
+static int pfc_divisors[]    = { 1, 2, 3, 4, 6, 1, 1, 1 };
+
+static void master_clk_init(struct clk *clk)
+{
+	clk->rate *= pfc_divisors[ctrl_inw(FRQCR) & 0x0003];
+}
+
+static struct clk_ops sh7705_master_clk_ops = {
+	.init		= master_clk_init,
+};
+
+static void module_clk_recalc(struct clk *clk)
+{
+	int idx = ctrl_inw(FRQCR) & 0x0003;
+	clk->rate = clk->parent->rate / pfc_divisors[idx];
+}
+
+static struct clk_ops sh7705_module_clk_ops = {
+	.recalc		= module_clk_recalc,
+};
+
+static void bus_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inw(FRQCR) & 0x0300) >> 8;
+	clk->rate = clk->parent->rate / stc_multipliers[idx];
+}
+
+static struct clk_ops sh7705_bus_clk_ops = {
+	.recalc		= bus_clk_recalc,
+};
+
+static void cpu_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inw(FRQCR) & 0x0030) >> 4;
+	clk->rate = clk->parent->rate / ifc_divisors[idx];
+}
+
+static struct clk_ops sh7705_cpu_clk_ops = {
+	.recalc		= cpu_clk_recalc,
+};
+
+static struct clk_ops *sh7705_clk_ops[] = {
+	&sh7705_master_clk_ops,
+	&sh7705_module_clk_ops,
+	&sh7705_bus_clk_ops,
+	&sh7705_cpu_clk_ops,
+};
+
+void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+{
+	if (idx < ARRAY_SIZE(sh7705_clk_ops))
+		*ops = sh7705_clk_ops[idx];
+}
+
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh7709.c sh-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh7709.c
--- linux-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh7709.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/sh3/clock-sh7709.c	2006-01-04 00:15:27.000000000 +0200
@@ -0,0 +1,96 @@
+/*
+ * arch/sh/kernel/cpu/sh3/clock-sh7709.c
+ *
+ * SH7709 support for the clock framework
+ *
+ *  Copyright (C) 2005  Andriy Skulysh
+ *
+ * Based on arch/sh/kernel/cpu/sh3/clock-sh7705.c
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/clock.h>
+#include <asm/freq.h>
+#include <asm/io.h>
+
+static int stc_multipliers[] = { 1, 2, 4, 8, 3, 6, 1, 1 };
+static int ifc_divisors[]    = { 1, 2, 4, 1, 3, 1, 1, 1 };
+static int pfc_divisors[]    = { 1, 2, 4, 1, 3, 6, 1, 1 };
+
+static void set_bus_parent(struct clk *clk)
+{
+	struct clk *bus_clk = clk_get("bus_clk");
+	clk->parent = bus_clk;
+	clk_put(bus_clk);
+}
+
+static void master_clk_init(struct clk *clk)
+{
+	int frqcr = ctrl_inw(FRQCR);
+	int idx = ((frqcr & 0x2000) >> 11) | (frqcr & 0x0003);
+
+	clk->rate *= pfc_divisors[idx];
+}
+
+static struct clk_ops sh7709_master_clk_ops = {
+	.init		= master_clk_init,
+};
+
+static void module_clk_recalc(struct clk *clk)
+{
+	int frqcr = ctrl_inw(FRQCR);
+	int idx = ((frqcr & 0x2000) >> 11) | (frqcr & 0x0003);
+
+	clk->rate = clk->parent->rate / pfc_divisors[idx];
+}
+
+static struct clk_ops sh7709_module_clk_ops = {
+#ifdef CLOCK_MODE_0_1_2_7
+	.init		= set_bus_parent,
+#endif
+	.recalc		= module_clk_recalc,
+};
+
+static void bus_clk_recalc(struct clk *clk)
+{
+	int frqcr = ctrl_inw(FRQCR);
+	int idx = (frqcr & 0x0080) ?
+		((frqcr & 0x8000) >> 13) | ((frqcr & 0x0030) >> 4) : 1;
+
+	clk->rate = clk->parent->rate * stc_multipliers[idx];
+}
+
+static struct clk_ops sh7709_bus_clk_ops = {
+	.recalc		= bus_clk_recalc,
+};
+
+static void cpu_clk_recalc(struct clk *clk)
+{
+	int frqcr = ctrl_inw(FRQCR);
+	int idx = ((frqcr & 0x4000) >> 12) | ((frqcr & 0x000c) >> 2);
+
+	clk->rate = clk->parent->rate / ifc_divisors[idx];
+}
+
+static struct clk_ops sh7709_cpu_clk_ops = {
+	.init		= set_bus_parent,
+	.recalc		= cpu_clk_recalc,
+};
+
+static struct clk_ops *sh7709_clk_ops[] = {
+	&sh7709_master_clk_ops,
+	&sh7709_module_clk_ops,
+	&sh7709_bus_clk_ops,
+	&sh7709_cpu_clk_ops,
+};
+
+void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+{
+	if (idx < ARRAY_SIZE(sh7709_clk_ops))
+		*ops = sh7709_clk_ops[idx];
+}
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/sh4/Makefile sh-2.6.15/arch/sh/kernel/cpu/sh4/Makefile
--- linux-2.6.15/arch/sh/kernel/cpu/sh4/Makefile	2004-12-26 05:37:10.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/sh4/Makefile	2006-01-07 22:13:59.197144942 +0200
@@ -4,7 +4,16 @@
 
 obj-y	:= ex.o probe.o
 
-obj-$(CONFIG_SH_FPU)                    += fpu.o
-obj-$(CONFIG_CPU_SUBTYPE_ST40STB1)	+= irq_intc2.o
+obj-$(CONFIG_SH_FPU)                    += fpu.o
 obj-$(CONFIG_SH_STORE_QUEUES)		+= sq.o
 
+# Primary on-chip clocks (common)
+clock-$(CONFIG_CPU_SH4)			:= clock-sh4.o
+clock-$(CONFIG_CPU_SUBTYPE_SH73180)	:= clock-sh73180.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7770)	:= clock-sh7770.o
+clock-$(CONFIG_CPU_SUBTYPE_SH7780)	:= clock-sh7780.o
+
+# Additional clocks by subtype
+clock-$(CONFIG_CPU_SUBTYPE_SH4_202)	+= clock-sh4-202.o
+
+obj-y	+= $(clock-y)
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh4-202.c sh-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh4-202.c
--- linux-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh4-202.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh4-202.c	2006-01-04 00:15:27.000000000 +0200
@@ -0,0 +1,179 @@
+/*
+ * arch/sh/kernel/cpu/sh4/clock-sh4-202.c
+ *
+ * Additional SH4-202 support for the clock framework
+ *
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <asm/clock.h>
+#include <asm/freq.h>
+#include <asm/io.h>
+
+#define CPG2_FRQCR3	0xfe0a0018
+
+static int frqcr3_divisors[] = { 1, 2, 3, 4, 6, 8, 16 };
+static int frqcr3_values[]   = { 0, 1, 2, 3, 4, 5, 6  };
+
+static void emi_clk_recalc(struct clk *clk)
+{
+	int idx = ctrl_inl(CPG2_FRQCR3) & 0x0007;
+	clk->rate = clk->parent->rate / frqcr3_divisors[idx];
+}
+
+static inline int frqcr3_lookup(struct clk *clk, unsigned long rate)
+{
+	int divisor = clk->parent->rate / rate;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(frqcr3_divisors); i++)
+		if (frqcr3_divisors[i] == divisor)
+			return frqcr3_values[i];
+
+	/* Safe fallback */
+	return 5;
+}
+
+static struct clk_ops sh4202_emi_clk_ops = {
+	.recalc		= emi_clk_recalc,
+};
+
+static struct clk sh4202_emi_clk = {
+	.name		= "emi_clk",
+	.flags		= CLK_ALWAYS_ENABLED,
+	.ops		= &sh4202_emi_clk_ops,
+};
+
+static void femi_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inl(CPG2_FRQCR3) >> 3) & 0x0007;
+	clk->rate = clk->parent->rate / frqcr3_divisors[idx];
+}
+
+static struct clk_ops sh4202_femi_clk_ops = {
+	.recalc		= femi_clk_recalc,
+};
+
+static struct clk sh4202_femi_clk = {
+	.name		= "femi_clk",
+	.flags		= CLK_ALWAYS_ENABLED,
+	.ops		= &sh4202_femi_clk_ops,
+};
+
+static void shoc_clk_init(struct clk *clk)
+{
+	int i;
+
+	/*
+	 * For some reason, the shoc_clk seems to be set to some really
+	 * insane value at boot (values outside of the allowable frequency
+	 * range for instance). We deal with this by scaling it back down
+	 * to something sensible just in case.
+	 *
+	 * Start scaling from the high end down until we find something
+	 * that passes rate verification..
+	 */
+	for (i = 0; i < ARRAY_SIZE(frqcr3_divisors); i++) {
+		int divisor = frqcr3_divisors[i];
+
+		if (clk->ops->set_rate(clk, clk->parent->rate / divisor) == 0)
+			break;
+	}
+
+	WARN_ON(i == ARRAY_SIZE(frqcr3_divisors));	/* Undefined clock */
+}
+
+static void shoc_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inl(CPG2_FRQCR3) >> 6) & 0x0007;
+	clk->rate = clk->parent->rate / frqcr3_divisors[idx];
+}
+
+static int shoc_clk_verify_rate(struct clk *clk, unsigned long rate)
+{
+	struct clk *bclk = clk_get("bus_clk");
+	unsigned long bclk_rate = clk_get_rate(bclk);
+
+	clk_put(bclk);
+
+	if (rate > bclk_rate)
+		return 1;
+	if (rate > 66000000)
+		return 1;
+
+	return 0;
+}
+
+static int shoc_clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	unsigned long frqcr3;
+	unsigned int tmp;
+
+	/* Make sure we have something sensible to switch to */
+	if (shoc_clk_verify_rate(clk, rate) != 0)
+		return -EINVAL;
+
+	tmp = frqcr3_lookup(clk, rate);
+
+	frqcr3 = ctrl_inl(CPG2_FRQCR3);
+	frqcr3 &= ~(0x0007 << 6);
+	frqcr3 |= tmp << 6;
+	ctrl_outl(frqcr3, CPG2_FRQCR3);
+
+	clk->rate = clk->parent->rate / frqcr3_divisors[tmp];
+
+	return 0;
+}
+
+static struct clk_ops sh4202_shoc_clk_ops = {
+	.init		= shoc_clk_init,
+	.recalc		= shoc_clk_recalc,
+	.set_rate	= shoc_clk_set_rate,
+};
+
+static struct clk sh4202_shoc_clk = {
+	.name		= "shoc_clk",
+	.flags		= CLK_ALWAYS_ENABLED,
+	.ops		= &sh4202_shoc_clk_ops,
+};
+
+static struct clk *sh4202_onchip_clocks[] = {
+	&sh4202_emi_clk,
+	&sh4202_femi_clk,
+	&sh4202_shoc_clk,
+};
+
+static int __init sh4202_clk_init(void)
+{
+	struct clk *clk = clk_get("master_clk");
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sh4202_onchip_clocks); i++) {
+		struct clk *clkp = sh4202_onchip_clocks[i];
+
+		clkp->parent = clk;
+		clk_register(clkp);
+		clk_enable(clkp);
+	}
+
+	/*
+	 * Now that we have the rest of the clocks registered, we need to
+	 * force the parent clock to propagate so that these clocks will
+	 * automatically figure out their rate. We cheat by handing the
+	 * parent clock its current rate and forcing child propagation.
+	 */
+	clk_set_rate(clk, clk_get_rate(clk));
+
+	clk_put(clk);
+
+	return 0;
+}
+
+arch_initcall(sh4202_clk_init);
+
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh4.c sh-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh4.c
--- linux-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh4.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh4.c	2006-01-04 00:15:27.000000000 +0200
@@ -0,0 +1,80 @@
+/*
+ * arch/sh/kernel/cpu/sh4/clock-sh4.c
+ *
+ * Generic SH-4 support for the clock framework
+ *
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * FRQCR parsing hacked out of arch/sh/kernel/time.c
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
+#include <asm/clock.h>
+#include <asm/freq.h>
+#include <asm/io.h>
+
+static int ifc_divisors[] = { 1, 2, 3, 4, 6, 8, 1, 1 };
+#define bfc_divisors ifc_divisors	/* Same */
+static int pfc_divisors[] = { 2, 3, 4, 6, 8, 2, 2, 2 };
+
+static void master_clk_init(struct clk *clk)
+{
+	clk->rate *= pfc_divisors[ctrl_inw(FRQCR) & 0x0007];
+}
+
+static struct clk_ops sh4_master_clk_ops = {
+	.init		= master_clk_init,
+};
+
+static void module_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inw(FRQCR) & 0x0007);
+	clk->rate = clk->parent->rate / pfc_divisors[idx];
+}
+
+static struct clk_ops sh4_module_clk_ops = {
+	.recalc		= module_clk_recalc,
+};
+
+static void bus_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inw(FRQCR) >> 3) & 0x0007;
+	clk->rate = clk->parent->rate / bfc_divisors[idx];
+}
+
+static struct clk_ops sh4_bus_clk_ops = {
+	.recalc		= bus_clk_recalc,
+};
+
+static void cpu_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inw(FRQCR) >> 6) & 0x0007;
+	clk->rate = clk->parent->rate / ifc_divisors[idx];
+}
+
+static struct clk_ops sh4_cpu_clk_ops = {
+	.recalc		= cpu_clk_recalc,
+};
+
+static struct clk_ops *sh4_clk_ops[] = {
+	&sh4_master_clk_ops,
+	&sh4_module_clk_ops,
+	&sh4_bus_clk_ops,
+	&sh4_cpu_clk_ops,
+};
+
+void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+{
+	if (idx < ARRAY_SIZE(sh4_clk_ops))
+		*ops = sh4_clk_ops[idx];
+}
+
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh73180.c sh-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh73180.c
--- linux-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh73180.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh73180.c	2006-01-04 00:15:27.000000000 +0200
@@ -0,0 +1,81 @@
+/*
+ * arch/sh/kernel/cpu/sh4/clock-sh73180.c
+ *
+ * SH73180 support for the clock framework
+ *
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * FRQCR parsing hacked out of arch/sh/kernel/time.c
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
+#include <asm/clock.h>
+#include <asm/freq.h>
+#include <asm/io.h>
+
+/*
+ * SH73180 uses a common set of divisors, so this is quite simple..
+ */
+static int divisors[] = { 1, 2, 3, 4, 6, 8, 12, 16 };
+
+static void master_clk_init(struct clk *clk)
+{
+	clk->rate *= divisors[ctrl_inl(FRQCR) & 0x0007];
+}
+
+static struct clk_ops sh73180_master_clk_ops = {
+	.init		= master_clk_init,
+};
+
+static void module_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inl(FRQCR) & 0x0007);
+	clk->rate = clk->parent->rate / divisors[idx];
+}
+
+static struct clk_ops sh73180_module_clk_ops = {
+	.recalc		= module_clk_recalc,
+};
+
+static void bus_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inl(FRQCR) >> 12) & 0x0007;
+	clk->rate = clk->parent->rate / divisors[idx];
+}
+
+static struct clk_ops sh73180_bus_clk_ops = {
+	.recalc		= bus_clk_recalc,
+};
+
+static void cpu_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inl(FRQCR) >> 20) & 0x0007;
+	clk->rate = clk->parent->rate / divisors[idx];
+}
+
+static struct clk_ops sh73180_cpu_clk_ops = {
+	.recalc		= cpu_clk_recalc,
+};
+
+static struct clk_ops *sh73180_clk_ops[] = {
+	&sh73180_master_clk_ops,
+	&sh73180_module_clk_ops,
+	&sh73180_bus_clk_ops,
+	&sh73180_cpu_clk_ops,
+};
+
+void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+{
+	if (idx < ARRAY_SIZE(sh73180_clk_ops))
+		*ops = sh73180_clk_ops[idx];
+}
+
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh7770.c sh-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh7770.c
--- linux-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh7770.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh7770.c	2006-01-04 00:15:27.000000000 +0200
@@ -0,0 +1,73 @@
+/*
+ * arch/sh/kernel/cpu/sh4/clock-sh7770.c
+ *
+ * SH7770 support for the clock framework
+ *
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/clock.h>
+#include <asm/freq.h>
+#include <asm/io.h>
+
+static int ifc_divisors[] = { 1, 1, 1, 1, 1, 1, 1, 1 };
+static int bfc_divisors[] = { 1, 1, 1, 1, 1, 8,12, 1 };
+static int pfc_divisors[] = { 1, 8, 1,10,12,16, 1, 1 };
+
+static void master_clk_init(struct clk *clk)
+{
+	clk->rate *= pfc_divisors[(ctrl_inl(FRQCR) >> 28) & 0x000f];
+}
+
+static struct clk_ops sh7770_master_clk_ops = {
+	.init		= master_clk_init,
+};
+
+static void module_clk_recalc(struct clk *clk)
+{
+	int idx = ((ctrl_inl(FRQCR) >> 28) & 0x000f);
+	clk->rate = clk->parent->rate / pfc_divisors[idx];
+}
+
+static struct clk_ops sh7770_module_clk_ops = {
+	.recalc		= module_clk_recalc,
+};
+
+static void bus_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inl(FRQCR) & 0x000f);
+	clk->rate = clk->parent->rate / bfc_divisors[idx];
+}
+
+static struct clk_ops sh7770_bus_clk_ops = {
+	.recalc		= bus_clk_recalc,
+};
+
+static void cpu_clk_recalc(struct clk *clk)
+{
+	int idx = ((ctrl_inl(FRQCR) >> 24) & 0x000f);
+	clk->rate = clk->parent->rate / ifc_divisors[idx];
+}
+
+static struct clk_ops sh7770_cpu_clk_ops = {
+	.recalc		= cpu_clk_recalc,
+};
+
+static struct clk_ops *sh7770_clk_ops[] = {
+	&sh7770_master_clk_ops,
+	&sh7770_module_clk_ops,
+	&sh7770_bus_clk_ops,
+	&sh7770_cpu_clk_ops,
+};
+
+void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+{
+	if (idx < ARRAY_SIZE(sh7770_clk_ops))
+		*ops = sh7770_clk_ops[idx];
+}
+
diff -urN -X exclude linux-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh7780.c sh-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh7780.c
--- linux-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh7780.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/cpu/sh4/clock-sh7780.c	2006-01-04 00:15:27.000000000 +0200
@@ -0,0 +1,126 @@
+/*
+ * arch/sh/kernel/cpu/sh4/clock-sh7780.c
+ *
+ * SH7780 support for the clock framework
+ *
+ *  Copyright (C) 2005  Paul Mundt
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <asm/clock.h>
+#include <asm/freq.h>
+#include <asm/io.h>
+
+static int ifc_divisors[] = { 2, 4 };
+static int bfc_divisors[] = { 1, 1, 1, 8, 12, 16, 24, 1 };
+static int pfc_divisors[] = { 1, 24, 24, 1 };
+static int cfc_divisors[] = { 1, 1, 4, 1, 6, 1, 1, 1 };
+
+static void master_clk_init(struct clk *clk)
+{
+	clk->rate *= pfc_divisors[ctrl_inl(FRQCR) & 0x0003];
+}
+
+static struct clk_ops sh7780_master_clk_ops = {
+	.init		= master_clk_init,
+};
+
+static void module_clk_recalc(struct clk *clk)
+{
+	int idx = (ctrl_inl(FRQCR) & 0x0003);
+	clk->rate = clk->parent->rate / pfc_divisors[idx];
+}
+
+static struct clk_ops sh7780_module_clk_ops = {
+	.recalc		= module_clk_recalc,
+};
+
+static void bus_clk_recalc(struct clk *clk)
+{
+	int idx = ((ctrl_inl(FRQCR) >> 16) & 0x0007);
+	clk->rate = clk->parent->rate / bfc_divisors[idx];
+}
+
+static struct clk_ops sh7780_bus_clk_ops = {
+	.recalc		= bus_clk_recalc,
+};
+
+static void cpu_clk_recalc(struct clk *clk)
+{
+	int idx = ((ctrl_inl(FRQCR) >> 24) & 0x0001);
+	clk->rate = clk->parent->rate / ifc_divisors[idx];
+}
+
+static struct clk_ops sh7780_cpu_clk_ops = {
+	.recalc		= cpu_clk_recalc,
+};
+
+static struct clk_ops *sh7780_clk_ops[] = {
+	&sh7780_master_clk_ops,
+	&sh7780_module_clk_ops,
+	&sh7780_bus_clk_ops,
+	&sh7780_cpu_clk_ops,
+};
+
+void __init arch_init_clk_ops(struct clk_ops **ops, int idx)
+{
+	if (idx < ARRAY_SIZE(sh7780_clk_ops))
+		*ops = sh7780_clk_ops[idx];
+}
+
+static void shyway_clk_recalc(struct clk *clk)
+{
+	int idx = ((ctrl_inl(FRQCR) >> 20) & 0x0007);
+	clk->rate = clk->parent->rate / cfc_divisors[idx];
+}
+
+static struct clk_ops sh7780_shyway_clk_ops = {
+	.recalc		= shyway_clk_recalc,
+};
+
+static struct clk sh7780_shyway_clk = {
+	.name		= "shyway_clk",
+	.flags		= CLK_ALWAYS_ENABLED,
+	.ops		= &sh7780_shyway_clk_ops,
+};
+
+/*
+ * Additional SH7780-specific on-chip clocks that aren't already part of the
+ * clock framework
+ */
+static struct clk *sh7780_onchip_clocks[] = {
+	&sh7780_shyway_clk,
+};
+
+static int __init sh7780_clk_init(void)
+{
+	struct clk *clk = clk_get("master_clk");
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sh7780_onchip_clocks); i++) {
+		struct clk *clkp = sh7780_onchip_clocks[i];
+
+		clkp->parent = clk;
+		clk_register(clkp);
+		clk_enable(clkp);
+	}
+
+	/*
+	 * Now that we have the rest of the clocks registered, we need to
+	 * force the parent clock to propagate so that these clocks will
+	 * automatically figure out their rate. We cheat by handing the
+	 * parent clock its current rate and forcing child propagation.
+	 */
+	clk_set_rate(clk, clk_get_rate(clk));
+
+	clk_put(clk);
+
+	return 0;
+}
+
+arch_initcall(sh7780_clk_init);
+

diff -urN -X exclude linux-2.6.15/arch/sh/kernel/time.c sh-2.6.15/arch/sh/kernel/time.c
--- linux-2.6.15/arch/sh/kernel/time.c	2006-01-04 14:19:57.000000000 +0200
+++ sh-2.6.15/arch/sh/kernel/time.c	2006-01-04 00:15:28.000000000 +0200
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 1999  Tetsuya Okada & Niibe Yutaka
  *  Copyright (C) 2000  Philipp Rumpf <prumpf@tux.org>
- *  Copyright (C) 2002, 2003, 2004  Paul Mundt
+ *  Copyright (C) 2002, 2003, 2004, 2005  Paul Mundt
  *  Copyright (C) 2002  M. R. Brown  <mrbrown@linux-sh.org>
  *
  *  Some code taken from i386 version.
@@ -11,50 +11,21 @@
  */
 
 #include <linux/config.h>
-#include <linux/errno.h>
-#include <linux/module.h>
-#include <linux/sched.h>
 #include <linux/kernel.h>
-#include <linux/param.h>
-#include <linux/string.h>
-#include <linux/mm.h>
-#include <linux/interrupt.h>
-#include <linux/time.h>
-#include <linux/delay.h>
+#include <linux/module.h>
 #include <linux/init.h>
-#include <linux/smp.h>
 #include <linux/profile.h>
-
-#include <asm/processor.h>
-#include <asm/uaccess.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/delay.h>
-#include <asm/machvec.h>
+#include <asm/clock.h>
 #include <asm/rtc.h>
-#include <asm/freq.h>
-#include <asm/cpu/timer.h>
-#ifdef CONFIG_SH_KGDB
+#include <asm/timer.h>
 #include <asm/kgdb.h>
-#endif
-
-#include <linux/timex.h>
-#include <linux/irq.h>
-
-#define TMU_TOCR_INIT	0x00
-#define TMU0_TCR_INIT	0x0020
-#define TMU_TSTR_INIT	1
-
-#define TMU0_TCR_CALIB	0x0000
-
-#ifdef CONFIG_CPU_SUBTYPE_ST40STB1
-#define CLOCKGEN_MEMCLKCR 0xbb040038
-#define MEMCLKCR_RATIO_MASK 0x7
-#endif /* CONFIG_CPU_SUBTYPE_ST40STB1 */
 
 extern unsigned long wall_jiffies;
-#define TICK_SIZE (tick_nsec / 1000)
-DEFINE_SPINLOCK(tmu0_lock);
+struct sys_timer *sys_timer;
+
+/* Move this somewhere more sensible.. */
+DEFINE_SPINLOCK(rtc_lock);
+EXPORT_SYMBOL(rtc_lock);
 
 /* XXX: Can we initialize this in a routine somewhere?  Dreamcast doesn't want
  * these routines anywhere... */
@@ -66,98 +37,14 @@
 int (*rtc_set_time)(const time_t);
 #endif
 
-#if defined(CONFIG_CPU_SUBTYPE_SH7300)
-static int md_table[] = { 1, 2, 3, 4, 6, 8, 12 };
-#endif
-#if defined(CONFIG_CPU_SH3)
-static int stc_multipliers[] = { 1, 2, 3, 4, 6, 1, 1, 1 };
-static int stc_values[]      = { 0, 1, 4, 2, 5, 0, 0, 0 };
-#define bfc_divisors stc_multipliers
-#define bfc_values stc_values
-static int ifc_divisors[]    = { 1, 2, 3, 4, 1, 1, 1, 1 };
-static int ifc_values[]      = { 0, 1, 4, 2, 0, 0, 0, 0 };
-static int pfc_divisors[]    = { 1, 2, 3, 4, 6, 1, 1, 1 };
-static int pfc_values[]      = { 0, 1, 4, 2, 5, 0, 0, 0 };
-#elif defined(CONFIG_CPU_SH4)
-#if defined(CONFIG_CPU_SUBTYPE_SH73180)
-static int ifc_divisors[] = { 1, 2, 3, 4, 6, 8, 12, 16 };
-static int ifc_values[] = { 0, 1, 2, 3, 4, 5, 6, 7 };
-#define bfc_divisors ifc_divisors	/* Same */
-#define bfc_values ifc_values
-#define pfc_divisors ifc_divisors	/* Same */
-#define pfc_values ifc_values
-#else
-static int ifc_divisors[] = { 1, 2, 3, 4, 6, 8, 1, 1 };
-static int ifc_values[]   = { 0, 1, 2, 3, 0, 4, 0, 5 };
-#define bfc_divisors ifc_divisors	/* Same */
-#define bfc_values ifc_values
-static int pfc_divisors[] = { 2, 3, 4, 6, 8, 2, 2, 2 };
-static int pfc_values[]   = { 0, 0, 1, 2, 0, 3, 0, 4 };
-#endif
-#else
-#error "Unknown ifc/bfc/pfc/stc values for this processor"
-#endif
-
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
-unsigned long long sched_clock(void)
+unsigned long long __attribute__ ((weak)) sched_clock(void)
 {
 	return (unsigned long long)jiffies * (1000000000 / HZ);
 }
 
-static unsigned long do_gettimeoffset(void)
-{
-	int count;
-	unsigned long flags;
-
-	static int count_p = 0x7fffffff;    /* for the first call after boot */
-	static unsigned long jiffies_p = 0;
-
-	/*
-	 * cache volatile jiffies temporarily; we have IRQs turned off.
-	 */
-	unsigned long jiffies_t;
-
-	spin_lock_irqsave(&tmu0_lock, flags);
-	/* timer count may underflow right here */
-	count = ctrl_inl(TMU0_TCNT);	/* read the latched count */
-
-	jiffies_t = jiffies;
-
-	/*
-	 * avoiding timer inconsistencies (they are rare, but they happen)...
-	 * there is one kind of problem that must be avoided here:
-	 *  1. the timer counter underflows
-	 */
-
-	if( jiffies_t == jiffies_p ) {
-		if( count > count_p ) {
-			/* the nutcase */
-
-			if(ctrl_inw(TMU0_TCR) & 0x100) { /* Check UNF bit */
-				/*
-				 * We cannot detect lost timer interrupts ...
-				 * well, that's why we call them lost, don't we? :)
-				 * [hmm, on the Pentium and Alpha we can ... sort of]
-				 */
-				count -= LATCH;
-			} else {
-				printk("do_slow_gettimeoffset(): hardware timer problem?\n");
-			}
-		}
-	} else
-		jiffies_p = jiffies_t;
-
-	count_p = count;
-	spin_unlock_irqrestore(&tmu0_lock, flags);
-
-	count = ((LATCH-1) - count) * TICK_SIZE;
-	count = (count + LATCH/2) / LATCH;
-
-	return count;
-}
-
 void do_gettimeofday(struct timeval *tv)
 {
 	unsigned long seq;
@@ -166,7 +53,7 @@
 
 	do {
 		seq = read_seqbegin(&xtime_lock);
-		usec = do_gettimeoffset();
+		usec = get_timer_offset();
 
 		lost = jiffies - wall_jiffies;
 		if (lost)
@@ -202,7 +89,7 @@
 	 * wall time.  Discover what correction gettimeofday() would have
 	 * made, and then undo it!
 	 */
-	nsec -= 1000 * (do_gettimeoffset() +
+	nsec -= 1000 * (get_timer_offset() +
 				(jiffies - wall_jiffies) * (1000000 / HZ));
 
 	wtm_sec  = wall_to_monotonic.tv_sec + (xtime.tv_sec - sec);
@@ -224,10 +111,10 @@
 static long last_rtc_update;
 
 /*
- * timer_interrupt() needs to keep up the real-time clock,
+ * handle_timer_tick() needs to keep up the real-time clock,
  * as well as call the "do_timer()" routine every clocktick
  */
-static inline void do_timer_interrupt(int irq, struct pt_regs *regs)
+void handle_timer_tick(struct pt_regs *regs)
 {
 	do_timer(regs);
 #ifndef CONFIG_SMP
@@ -252,337 +139,35 @@
 		if (rtc_set_time(xtime.tv_sec) == 0)
 			last_rtc_update = xtime.tv_sec;
 		else
-			last_rtc_update = xtime.tv_sec - 600; /* do it again in 60 s */
+			/* do it again in 60s */
+			last_rtc_update = xtime.tv_sec - 600;
 	}
 }
 
-/*
- * This is the same as the above, except we _also_ save the current
- * Time Stamp Counter value at the time of the timer interrupt, so that
- * we later on can estimate the time of day more exactly.
- */
-static irqreturn_t timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
-{
-	unsigned long timer_status;
-
-	/* Clear UNF bit */
-	timer_status = ctrl_inw(TMU0_TCR);
-	timer_status &= ~0x100;
-	ctrl_outw(timer_status, TMU0_TCR);
-
-	/*
-	 * Here we are in the timer irq handler. We just have irqs locally
-	 * disabled but we don't know if the timer_bh is running on the other
-	 * CPU. We need to avoid to SMP race with it. NOTE: we don' t need
-	 * the irq version of write_lock because as just said we have irq
-	 * locally disabled. -arca
-	 */
-	write_seqlock(&xtime_lock);
-	do_timer_interrupt(irq, regs);
-	write_sequnlock(&xtime_lock);
-
-	return IRQ_HANDLED;
-}
-
-/*
- * Hah!  We'll see if this works (switching from usecs to nsecs).
- */
-static unsigned int __init get_timer_frequency(void)
-{
-	u32 freq;
-	struct timespec ts1, ts2;
-	unsigned long diff_nsec;
-	unsigned long factor;
-
-	/* Setup the timer:  We don't want to generate interrupts, just
-	 * have it count down at its natural rate.
-	 */
-	ctrl_outb(0, TMU_TSTR);
-#if !defined(CONFIG_CPU_SUBTYPE_SH7300)
-	ctrl_outb(TMU_TOCR_INIT, TMU_TOCR);
-#endif
-	ctrl_outw(TMU0_TCR_CALIB, TMU0_TCR);
-	ctrl_outl(0xffffffff, TMU0_TCOR);
-	ctrl_outl(0xffffffff, TMU0_TCNT);
-
-	rtc_get_time(&ts2);
-
-	do {
-		rtc_get_time(&ts1);
-	} while (ts1.tv_nsec == ts2.tv_nsec && ts1.tv_sec == ts2.tv_sec);
-
-	/* actually start the timer */
-	ctrl_outb(TMU_TSTR_INIT, TMU_TSTR);
-
-	do {
-		rtc_get_time(&ts2);
-	} while (ts1.tv_nsec == ts2.tv_nsec && ts1.tv_sec == ts2.tv_sec);
-
-	freq = 0xffffffff - ctrl_inl(TMU0_TCNT);
-	if (ts2.tv_nsec < ts1.tv_nsec) {
-		ts2.tv_nsec += 1000000000;
-		ts2.tv_sec--;
-	}
-
-	diff_nsec = (ts2.tv_sec - ts1.tv_sec) * 1000000000 + (ts2.tv_nsec - ts1.tv_nsec);
-
-	/* this should work well if the RTC has a precision of n Hz, where
-	 * n is an integer.  I don't think we have to worry about the other
-	 * cases. */
-	factor = (1000000000 + diff_nsec/2) / diff_nsec;
-
-	if (factor * diff_nsec > 1100000000 ||
-	    factor * diff_nsec <  900000000)
-		panic("weird RTC (diff_nsec %ld)", diff_nsec);
-
-	return freq * factor;
-}
-
-void (*board_time_init)(void);
-void (*board_timer_setup)(struct irqaction *irq);
-
-static unsigned int sh_pclk_freq __initdata = CONFIG_SH_PCLK_FREQ;
-
-static int __init sh_pclk_setup(char *str)
-{
-        unsigned int freq;
-
-	if (get_option(&str, &freq))
-		sh_pclk_freq = freq;
-
-	return 1;
-}
-__setup("sh_pclk=", sh_pclk_setup);
-
-static struct irqaction irq0  = { timer_interrupt, SA_INTERRUPT, CPU_MASK_NONE, "timer", NULL, NULL};
-
-void get_current_frequency_divisors(unsigned int *ifc, unsigned int *bfc, unsigned int *pfc)
-{
-	unsigned int frqcr = ctrl_inw(FRQCR);
-
-#if defined(CONFIG_CPU_SH3)
-#if defined(CONFIG_CPU_SUBTYPE_SH7300)
-	*ifc = md_table[((frqcr & 0x0070) >> 4)];
-	*bfc = md_table[((frqcr & 0x0700) >> 8)];
-	*pfc = md_table[frqcr & 0x0007];
-#elif defined(CONFIG_CPU_SUBTYPE_SH7705)
-	*bfc = stc_multipliers[(frqcr & 0x0300) >> 8];
-	*ifc = ifc_divisors[(frqcr & 0x0030) >> 4];
-	*pfc = pfc_divisors[frqcr & 0x0003];
-#else
-	unsigned int tmp;
-
-	tmp  = (frqcr & 0x8000) >> 13;
-	tmp |= (frqcr & 0x0030) >>  4;
-	*bfc = stc_multipliers[tmp];
-	tmp  = (frqcr & 0x4000)  >> 12;
-	tmp |= (frqcr & 0x000c) >> 2;
-	*ifc = ifc_divisors[tmp];
-	tmp  = (frqcr & 0x2000) >> 11;
-	tmp |= frqcr & 0x0003;
-	*pfc = pfc_divisors[tmp];
-#endif
-#elif defined(CONFIG_CPU_SH4)
-#if defined(CONFIG_CPU_SUBTYPE_SH73180)
-	*ifc = ifc_divisors[(frqcr>> 20) & 0x0007];
-	*bfc = bfc_divisors[(frqcr>> 12) & 0x0007];
-	*pfc = pfc_divisors[frqcr & 0x0007];
-#else
-	*ifc = ifc_divisors[(frqcr >> 6) & 0x0007];
-	*bfc = bfc_divisors[(frqcr >> 3) & 0x0007];
-	*pfc = pfc_divisors[frqcr & 0x0007];
-#endif
-#endif
-}
-
-/*
- * This bit of ugliness builds up accessor routines to get at both
- * the divisors and the physical values.
- */
-#define _FREQ_TABLE(x) \
-	unsigned int get_##x##_divisor(unsigned int value)	\
-		{ return x##_divisors[value]; }			\
-								\
-	unsigned int get_##x##_value(unsigned int divisor)	\
-		{ return x##_values[(divisor - 1)]; }
-
-_FREQ_TABLE(ifc);
-_FREQ_TABLE(bfc);
-_FREQ_TABLE(pfc);
-
-#ifdef CONFIG_CPU_SUBTYPE_ST40STB1
-
-/*
- * The ST40 divisors are totally different so we set the cpu data
- * clocks using a different algorithm
- *
- * I've just plugged this from the 2.4 code
- *	- Alex Bennee <kernel-hacker@bennee.com>
- */
-#define CCN_PVR_CHIP_SHIFT 24
-#define CCN_PVR_CHIP_MASK  0xff
-#define CCN_PVR_CHIP_ST40STB1 0x4
-
-
-struct frqcr_data {
-	unsigned short frqcr;
-
-	struct {
-		unsigned char multiplier;
-		unsigned char divisor;
-	} factor[3];
+static struct sysdev_class timer_sysclass = {
+	set_kset_name("timer"),
 };
 
-static struct frqcr_data st40_frqcr_table[] = {
-	{ 0x000, {{1,1}, {1,1}, {1,2}}},
-	{ 0x002, {{1,1}, {1,1}, {1,4}}},
-	{ 0x004, {{1,1}, {1,1}, {1,8}}},
-	{ 0x008, {{1,1}, {1,2}, {1,2}}},
-	{ 0x00A, {{1,1}, {1,2}, {1,4}}},
-	{ 0x00C, {{1,1}, {1,2}, {1,8}}},
-	{ 0x011, {{1,1}, {2,3}, {1,6}}},
-	{ 0x013, {{1,1}, {2,3}, {1,3}}},
-	{ 0x01A, {{1,1}, {1,2}, {1,4}}},
-	{ 0x01C, {{1,1}, {1,2}, {1,8}}},
-	{ 0x023, {{1,1}, {2,3}, {1,3}}},
-	{ 0x02C, {{1,1}, {1,2}, {1,8}}},
-	{ 0x048, {{1,2}, {1,2}, {1,4}}},
-	{ 0x04A, {{1,2}, {1,2}, {1,6}}},
-	{ 0x04C, {{1,2}, {1,2}, {1,8}}},
-	{ 0x05A, {{1,2}, {1,3}, {1,6}}},
-	{ 0x05C, {{1,2}, {1,3}, {1,6}}},
-	{ 0x063, {{1,2}, {1,4}, {1,4}}},
-	{ 0x06C, {{1,2}, {1,4}, {1,8}}},
-	{ 0x091, {{1,3}, {1,3}, {1,6}}},
-	{ 0x093, {{1,3}, {1,3}, {1,6}}},
-	{ 0x0A3, {{1,3}, {1,6}, {1,6}}},
-	{ 0x0DA, {{1,4}, {1,4}, {1,8}}},
-	{ 0x0DC, {{1,4}, {1,4}, {1,8}}},
-	{ 0x0EC, {{1,4}, {1,8}, {1,8}}},
-	{ 0x123, {{1,4}, {1,4}, {1,8}}},
-	{ 0x16C, {{1,4}, {1,8}, {1,8}}},
-};
-
-struct memclk_data {
-	unsigned char multiplier;
-	unsigned char divisor;
-};
-
-static struct memclk_data st40_memclk_table[8] = {
-	{1,1},	// 000
-	{1,2},	// 001
-	{1,3},	// 010
-	{2,3},	// 011
-	{1,4},	// 100
-	{1,6},	// 101
-	{1,8},	// 110
-	{1,8}	// 111
-};
-
-static void st40_specific_time_init(unsigned int module_clock, unsigned short frqcr)
+static int __init timer_init_sysfs(void)
 {
-	unsigned int cpu_clock, master_clock, bus_clock, memory_clock;
-	struct frqcr_data *d;
-	int a;
-	unsigned long memclkcr;
-	struct memclk_data *e;
-
-	for (a = 0; a < ARRAY_SIZE(st40_frqcr_table); a++) {
-		d = &st40_frqcr_table[a];
-
-		if (d->frqcr == (frqcr & 0x1ff))
-			break;
-	}
-
-	if (a == ARRAY_SIZE(st40_frqcr_table)) {
-		d = st40_frqcr_table;
+	int ret = sysdev_class_register(&timer_sysclass);
+	if (ret != 0)
+		return ret;
 
-		printk("ERROR: Unrecognised FRQCR value (0x%x), "
-		       "using default multipliers\n", frqcr);
-	}
+	sys_timer->dev.cls = &timer_sysclass;
+	return sysdev_register(&sys_timer->dev);
+}
 
-	memclkcr = ctrl_inl(CLOCKGEN_MEMCLKCR);
-	e = &st40_memclk_table[memclkcr & MEMCLKCR_RATIO_MASK];
+device_initcall(timer_init_sysfs);
 
-	printk(KERN_INFO "Clock multipliers: CPU: %d/%d Bus: %d/%d "
-	       "Mem: %d/%d Periph: %d/%d\n",
-	       d->factor[0].multiplier, d->factor[0].divisor,
-	       d->factor[1].multiplier, d->factor[1].divisor,
-	       e->multiplier,           e->divisor,
-	       d->factor[2].multiplier, d->factor[2].divisor);
-
-	master_clock = module_clock * d->factor[2].divisor
-				    / d->factor[2].multiplier;
-	bus_clock    = master_clock * d->factor[1].multiplier
-				    / d->factor[1].divisor;
-	memory_clock = master_clock * e->multiplier
-				    / e->divisor;
-	cpu_clock    = master_clock * d->factor[0].multiplier
-				    / d->factor[0].divisor;
-
-	current_cpu_data.cpu_clock    = cpu_clock;
-	current_cpu_data.master_clock = master_clock;
-	current_cpu_data.bus_clock    = bus_clock;
-	current_cpu_data.memory_clock = memory_clock;
-	current_cpu_data.module_clock = module_clock;
-}
-#endif
+void (*board_time_init)(void);
 
 void __init time_init(void)
 {
-	unsigned int timer_freq = 0;
-	unsigned int ifc, pfc, bfc;
-	unsigned long interval;
-#ifdef CONFIG_CPU_SUBTYPE_ST40STB1
-	unsigned long pvr;
-	unsigned short frqcr;
-#endif
-
 	if (board_time_init)
 		board_time_init();
 
-	/*
-	 * If we don't have an RTC (such as with the SH7300), don't attempt to
-	 * probe the timer frequency. Rely on an either hardcoded peripheral
-	 * clock value, or on the sh_pclk command line option. Note that we
-	 * still need to have CONFIG_SH_PCLK_FREQ set in order for things like
-	 * CLOCK_TICK_RATE to be sane.
-	 */
-	current_cpu_data.module_clock = sh_pclk_freq;
-
-#ifdef CONFIG_SH_PCLK_CALC
-	/* XXX: Switch this over to a more generic test. */
-	{
-		unsigned int freq;
-
-		/*
-		 * If we've specified a peripheral clock frequency, and we have
-		 * an RTC, compare it against the autodetected value. Complain
-		 * if there's a mismatch.
-		 */
-		timer_freq = get_timer_frequency();
-		freq = timer_freq * 4;
-
-		if (sh_pclk_freq && (sh_pclk_freq/100*99 > freq || sh_pclk_freq/100*101 < freq)) {
-			printk(KERN_NOTICE "Calculated peripheral clock value "
-			       "%d differs from sh_pclk value %d, fixing..\n",
-			       freq, sh_pclk_freq);
-			current_cpu_data.module_clock = freq;
-		}
-	}
-#endif
-
-#ifdef CONFIG_CPU_SUBTYPE_ST40STB1
-	/* XXX: Update ST40 code to use board_time_init() */
-	pvr = ctrl_inl(CCN_PVR);
-	frqcr = ctrl_inw(FRQCR);
-	printk("time.c ST40 Probe: PVR %08lx, FRQCR %04hx\n", pvr, frqcr);
-
-	if (((pvr >> CCN_PVR_CHIP_SHIFT) & CCN_PVR_CHIP_MASK) == CCN_PVR_CHIP_ST40STB1)
-		st40_specific_time_init(current_cpu_data.module_clock, frqcr);
-	else
-#endif
-		get_current_frequency_divisors(&ifc, &bfc, &pfc);
+	clk_init();
 
 	if (rtc_get_time) {
 		rtc_get_time(&xtime);
@@ -594,51 +179,12 @@
         set_normalized_timespec(&wall_to_monotonic,
                                 -xtime.tv_sec, -xtime.tv_nsec);
 
-	if (board_timer_setup) {
-		board_timer_setup(&irq0);
-	} else {
-		setup_irq(TIMER_IRQ, &irq0);
-	}
-
 	/*
-	 * for ST40 chips the current_cpu_data should already be set
-	 * so not having valid pfc/bfc/ifc shouldn't be a problem
+	 * Find the timer to use as the system timer, it will be
+	 * initialized for us.
 	 */
-	if (!current_cpu_data.master_clock)
-		current_cpu_data.master_clock = current_cpu_data.module_clock * pfc;
-	if (!current_cpu_data.bus_clock)
-		current_cpu_data.bus_clock = current_cpu_data.master_clock / bfc;
-	if (!current_cpu_data.cpu_clock)
-		current_cpu_data.cpu_clock = current_cpu_data.master_clock / ifc;
-
-	printk("CPU clock: %d.%02dMHz\n",
-	       (current_cpu_data.cpu_clock / 1000000),
-	       (current_cpu_data.cpu_clock % 1000000)/10000);
-	printk("Bus clock: %d.%02dMHz\n",
-	       (current_cpu_data.bus_clock / 1000000),
-	       (current_cpu_data.bus_clock % 1000000)/10000);
-#ifdef CONFIG_CPU_SUBTYPE_ST40STB1
-	printk("Memory clock: %d.%02dMHz\n",
-	       (current_cpu_data.memory_clock / 1000000),
-	       (current_cpu_data.memory_clock % 1000000)/10000);
-#endif
-	printk("Module clock: %d.%02dMHz\n",
-	       (current_cpu_data.module_clock / 1000000),
-	       (current_cpu_data.module_clock % 1000000)/10000);
-
-	interval = (current_cpu_data.module_clock/4 + HZ/2) / HZ;
-
-	printk("Interval = %ld\n", interval);
-
-	/* Start TMU0 */
-	ctrl_outb(0, TMU_TSTR);
-#if !defined(CONFIG_CPU_SUBTYPE_SH7300)
-	ctrl_outb(TMU_TOCR_INIT, TMU_TOCR);
-#endif
-	ctrl_outw(TMU0_TCR_INIT, TMU0_TCR);
-	ctrl_outl(interval, TMU0_TCOR);
-	ctrl_outl(interval, TMU0_TCNT);
-	ctrl_outb(TMU_TSTR_INIT, TMU_TSTR);
+	sys_timer = get_sys_timer();
+	printk(KERN_INFO "Using %s for system timer\n", sys_timer->name);
 
 #if defined(CONFIG_SH_KGDB)
 	/*


diff -urN -X exclude linux-2.6.15/arch/sh/boards/overdrive/Makefile sh-2.6.15/arch/sh/boards/overdrive/Makefile
--- linux-2.6.15/arch/sh/boards/overdrive/Makefile	2004-07-15 22:21:13.000000000 +0300
+++ sh-2.6.15/arch/sh/boards/overdrive/Makefile	2006-01-04 00:15:26.000000000 +0200
@@ -2,7 +2,7 @@
 # Makefile for the STMicroelectronics Overdrive specific parts of the kernel
 #
 
-obj-y	 := mach.o setup.o io.o irq.o led.o time.o
+obj-y	 := mach.o setup.o io.o irq.o led.o
 
 obj-$(CONFIG_PCI) += fpga.o galileo.o pcidma.o
 
diff -urN -X exclude linux-2.6.15/arch/sh/boards/overdrive/setup.c sh-2.6.15/arch/sh/boards/overdrive/setup.c
--- linux-2.6.15/arch/sh/boards/overdrive/setup.c	2004-07-15 22:21:13.000000000 +0300
+++ sh-2.6.15/arch/sh/boards/overdrive/setup.c	2006-01-04 00:15:26.000000000 +0200
@@ -17,8 +17,6 @@
 #include <asm/overdrive/overdrive.h>
 #include <asm/overdrive/fpga.h>
 
-extern void od_time_init(void);
-
 const char *get_system_type(void)
 {
 	return "SH7750 Overdrive";
@@ -31,11 +29,9 @@
 {
 #ifdef CONFIG_PCI
 	init_overdrive_fpga();
-	galileo_init(); 
+	galileo_init();
 #endif
 
-	board_time_init = od_time_init;
-
         /* Enable RS232 receive buffers */
 	writel(0x1e, OVERDRIVE_CTRL);
 }
diff -urN -X exclude linux-2.6.15/arch/sh/boards/overdrive/time.c sh-2.6.15/arch/sh/boards/overdrive/time.c
--- linux-2.6.15/arch/sh/boards/overdrive/time.c	2004-07-15 22:21:13.000000000 +0300
+++ sh-2.6.15/arch/sh/boards/overdrive/time.c	1970-01-01 02:00:00.000000000 +0200
@@ -1,119 +0,0 @@
-/*
- * arch/sh/boards/overdrive/time.c
- *
- * Copyright (C) 2000 Stuart Menefy (stuart.menefy@st.com)
- * Copyright (C) 2002 Paul Mundt (lethal@chaoticdreams.org)
- *
- * May be copied or modified under the terms of the GNU General Public
- * License.  See linux/COPYING for more information.
- *
- * STMicroelectronics Overdrive Support.
- */
-
-void od_time_init(void)
-{
-	struct frqcr_data {
-		unsigned short frqcr;
-		struct {
-			unsigned char multiplier;
-			unsigned char divisor;
-		} factor[3];
-	};
-
-	static struct frqcr_data st40_frqcr_table[] = {		
-		{ 0x000, {{1,1}, {1,1}, {1,2}}},
-		{ 0x002, {{1,1}, {1,1}, {1,4}}},
-		{ 0x004, {{1,1}, {1,1}, {1,8}}},
-		{ 0x008, {{1,1}, {1,2}, {1,2}}},
-		{ 0x00A, {{1,1}, {1,2}, {1,4}}},
-		{ 0x00C, {{1,1}, {1,2}, {1,8}}},
-		{ 0x011, {{1,1}, {2,3}, {1,6}}},
-		{ 0x013, {{1,1}, {2,3}, {1,3}}},
-		{ 0x01A, {{1,1}, {1,2}, {1,4}}},
-		{ 0x01C, {{1,1}, {1,2}, {1,8}}},
-		{ 0x023, {{1,1}, {2,3}, {1,3}}},
-		{ 0x02C, {{1,1}, {1,2}, {1,8}}},
-		{ 0x048, {{1,2}, {1,2}, {1,4}}},
-		{ 0x04A, {{1,2}, {1,2}, {1,6}}},
-		{ 0x04C, {{1,2}, {1,2}, {1,8}}},
-		{ 0x05A, {{1,2}, {1,3}, {1,6}}},
-		{ 0x05C, {{1,2}, {1,3}, {1,6}}},
-		{ 0x063, {{1,2}, {1,4}, {1,4}}},
-		{ 0x06C, {{1,2}, {1,4}, {1,8}}},
-		{ 0x091, {{1,3}, {1,3}, {1,6}}},
-		{ 0x093, {{1,3}, {1,3}, {1,6}}},
-		{ 0x0A3, {{1,3}, {1,6}, {1,6}}},
-		{ 0x0DA, {{1,4}, {1,4}, {1,8}}},
-		{ 0x0DC, {{1,4}, {1,4}, {1,8}}},
-		{ 0x0EC, {{1,4}, {1,8}, {1,8}}},
-		{ 0x123, {{1,4}, {1,4}, {1,8}}},
-		{ 0x16C, {{1,4}, {1,8}, {1,8}}},
-	};
-
-	struct memclk_data {
-		unsigned char multiplier;
-		unsigned char divisor;
-	};
-	static struct memclk_data st40_memclk_table[8] = {
-		{1,1},	// 000
-		{1,2},	// 001
-		{1,3},	// 010
-		{2,3},	// 011
-		{1,4},	// 100
-		{1,6},	// 101
-		{1,8},	// 110
-		{1,8}	// 111
-	};
-
-	unsigned long pvr;
-
-	/* 
-	 * This should probably be moved into the SH3 probing code, and then
-	 * use the processor structure to determine which CPU we are running
-	 * on.
-	 */
-	pvr = ctrl_inl(CCN_PVR);
-	printk("PVR %08x\n", pvr);
-
-	if (((pvr >> CCN_PVR_CHIP_SHIFT) & CCN_PVR_CHIP_MASK) == CCN_PVR_CHIP_ST40STB1) {
-		/* 
-		 * Unfortunatly the STB1 FRQCR values are different from the
-		 * 7750 ones.
-		 */
-		struct frqcr_data *d;
-		int a;
-		unsigned long memclkcr;
-		struct memclk_data *e;
-
-		for (a=0; a<ARRAY_SIZE(st40_frqcr_table); a++) {
-			d = &st40_frqcr_table[a];
-			if (d->frqcr == (frqcr & 0x1ff))
-				break;
-		}
-		if (a == ARRAY_SIZE(st40_frqcr_table)) {
-			d = st40_frqcr_table;
-			printk("ERROR: Unrecognised FRQCR value, using default multipliers\n");
-		}
-
-		memclkcr = ctrl_inl(CLOCKGEN_MEMCLKCR);
-		e = &st40_memclk_table[memclkcr & MEMCLKCR_RATIO_MASK];
-
-		printk("Clock multipliers: CPU: %d/%d Bus: %d/%d Mem: %d/%d Periph: %d/%d\n",
-		       d->factor[0].multiplier, d->factor[0].divisor,
-		       d->factor[1].multiplier, d->factor[1].divisor,
-		       e->multiplier,           e->divisor,
-		       d->factor[2].multiplier, d->factor[2].divisor);
-		
-		current_cpu_data.master_clock = current_cpu_data.module_clock *
-						d->factor[2].divisor /
-						d->factor[2].multiplier;
-		current_cpu_data.bus_clock    = current_cpu_data.master_clock *
-						d->factor[1].multiplier /
-						d->factor[1].divisor;
-		current_cpu_data.memory_clock = current_cpu_data.master_clock *
-						e->multiplier / e->divisor;
-		current_cpu_data.cpu_clock    = current_cpu_data.master_clock *
-						d->factor[0].multiplier /
-						d->factor[0].divisor;
-}
-
diff -urN -X exclude linux-2.6.15/include/asm-sh/clock.h sh-2.6.15/include/asm-sh/clock.h
--- linux-2.6.15/include/asm-sh/clock.h	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/include/asm-sh/clock.h	2006-01-04 00:15:30.000000000 +0200
@@ -0,0 +1,61 @@
+#ifndef __ASM_SH_CLOCK_H
+#define __ASM_SH_CLOCK_H
+
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/seq_file.h>
+
+struct clk;
+
+struct clk_ops {
+	void (*init)(struct clk *clk);
+	void (*enable)(struct clk *clk);
+	void (*disable)(struct clk *clk);
+	void (*recalc)(struct clk *clk);
+	int (*set_rate)(struct clk *clk, unsigned long rate);
+};
+
+struct clk {
+	struct list_head	node;
+	const char		*name;
+
+	struct module		*owner;
+
+	struct clk		*parent;
+	struct clk_ops		*ops;
+
+	struct kref		kref;
+
+	unsigned long		rate;
+	unsigned long		flags;
+};
+
+#define CLK_ALWAYS_ENABLED	(1 << 0)
+#define CLK_RATE_PROPAGATES	(1 << 1)
+
+/* Should be defined by processor-specific code */
+void arch_init_clk_ops(struct clk_ops **, int type);
+
+/* arch/sh/kernel/cpu/clock.c */
+int clk_init(void);
+
+int __clk_enable(struct clk *);
+int clk_enable(struct clk *);
+
+void __clk_disable(struct clk *);
+void clk_disable(struct clk *);
+
+int clk_set_rate(struct clk *, unsigned long rate);
+unsigned long clk_get_rate(struct clk *);
+void clk_recalc_rate(struct clk *);
+
+struct clk *clk_get(const char *id);
+void clk_put(struct clk *);
+
+int clk_register(struct clk *);
+void clk_unregister(struct clk *);
+
+int show_clocks(struct seq_file *m);
+
+#endif /* __ASM_SH_CLOCK_H */
+
diff -urN -X exclude linux-2.6.15/include/asm-sh/cpu-sh4/freq.h sh-2.6.15/include/asm-sh/cpu-sh4/freq.h
--- linux-2.6.15/include/asm-sh/cpu-sh4/freq.h	2004-12-26 05:37:56.000000000 +0200
+++ sh-2.6.15/include/asm-sh/cpu-sh4/freq.h	2006-01-04 00:15:29.000000000 +0200
@@ -12,6 +12,8 @@
 
 #if defined(CONFIG_CPU_SUBTYPE_SH73180)
 #define FRQCR		        0xa4150000
+#elif defined(CONFIG_CPU_SUBTYPE_SH7780)
+#define	FRQCR			0xffc80000
 #else
 #define FRQCR			0xffc00000
 #endif


diff -urN -X exclude linux-2.6.15/include/asm-sh/freq.h sh-2.6.15/include/asm-sh/freq.h
--- linux-2.6.15/include/asm-sh/freq.h	2004-12-26 05:37:56.000000000 +0200
+++ sh-2.6.15/include/asm-sh/freq.h	2006-01-04 00:15:29.000000000 +0200
@@ -14,16 +14,5 @@
 
 #include <asm/cpu/freq.h>
 
-/* arch/sh/kernel/time.c */
-extern void get_current_frequency_divisors(unsigned int *ifc, unsigned int *pfc, unsigned int *bfc);
-
-extern unsigned int get_ifc_divisor(unsigned int value);
-extern unsigned int get_ifc_divisor(unsigned int value);
-extern unsigned int get_ifc_divisor(unsigned int value);
-
-extern unsigned int get_ifc_value(unsigned int divisor);
-extern unsigned int get_pfc_value(unsigned int divisor);
-extern unsigned int get_bfc_value(unsigned int divisor);
-
 #endif /* __KERNEL__ */
 #endif /* __ASM_SH_FREQ_H */
