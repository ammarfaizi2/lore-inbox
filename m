Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932494AbVHYCyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbVHYCyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 22:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVHYCyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 22:54:04 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:761 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S932494AbVHYCyB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 22:54:01 -0400
Date: Wed, 24 Aug 2005 19:53:57 -0700
From: Todd Poynor <tpoynor@mvista.com>
To: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: PowerOP Take 2 1/3: ARM OMAP1 platform support
Message-ID: <20050825025357.GB28662@slurryseal.ddns.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PowerOP support for OMAP1 platforms.  Currently handles these power
parameters:

   dpllmult	DPLL_CTL reg PLL MULT bits
   dplldiv	DPLL_CTL reg PLL DIV bits
   armdiv	ARM_CKCTL reg ARMDIV bits
   dspdiv	ARM_CKCTL reg DSPDIV bits
   tcdiv	ARM_CKCTL reg TCDIV bits
   lowpwr	1 = assert ULPD LOW_PWR, voltage scale low

Other parameters such as DSPMMUDIV, LCDDIV, and ARM_PERDIV might also be
useful.

Example usage will be shown with a follow-on sysfs UI patch.

Index: linux-2.6.13-rc4/arch/arm/mach-omap1/powerop.c
===================================================================
--- /dev/null
+++ linux-2.6.13-rc4/arch/arm/mach-omap1/powerop.c
@@ -0,0 +1,157 @@
+/*
+ * PowerOP support for OMAP1
+ *
+ * Based on DPM OMAP code by Matthew Locke, Dmitry Chigirev, Vladimir
+ * Barinov, and Todd Poynor.
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+
+#include <asm/arch/powerop.h>
+#include <asm/hardware.h>
+#include <asm/arch/pm.h>
+
+/* ARM_CKCTL bit shifts */
+#define CKCTL_PERDIV_OFFSET	0
+#define CKCTL_LCDDIV_OFFSET	2
+#define CKCTL_ARMDIV_OFFSET	4
+#define CKCTL_DSPDIV_OFFSET	6
+#define CKCTL_TCDIV_OFFSET	8
+#define CKCTL_DSPMMUDIV_OFFSET	10
+
+#define DPLL_CTL_MASK	0xfe0
+
+#define ULPD_MIN_MAX_REG (1 << 11)
+#define ULPD_DVS_ENABLE  (1 << 10)
+#define ULPD_LOW_PWR_REQ (1 << 1)
+#define LOW_POWER (ULPD_MIN_MAX_REG | ULPD_DVS_ENABLE | ULPD_LOW_PWR_REQ | \
+		   ULPD_LOW_PWR_EN)
+
+int
+powerop_get_point(struct powerop_point *point)
+{
+	unsigned long flags;
+	int dpll_ctl, arm_cktl;
+
+	local_irq_save(flags);
+	dpll_ctl = omap_readw(DPLL_CTL);
+	arm_cktl = omap_readw(ARM_CKCTL);
+
+	point->dpllmult = dpll_ctl >> 7 & 0x1f;
+	point->dplldiv = dpll_ctl >> 5 & 0x3;
+	point->armdiv = arm_cktl >> CKCTL_ARMDIV_OFFSET & 0x3;
+	point->dspdiv = arm_cktl >> CKCTL_DSPDIV_OFFSET & 0x3;
+	point->tcdiv = arm_cktl >> CKCTL_TCDIV_OFFSET & 0x3;
+	point->lowpwr = (omap_readw(ULPD_POWER_CTRL) & (ULPD_LOW_PWR_REQ)) ?
+		1 : 0;
+	local_irq_restore(flags);
+	return 0;
+}
+
+static void scale_dpll(int dpll_ctl)
+{
+	int i;
+
+	omap_writew((omap_readw(DPLL_CTL) & ~DPLL_CTL_MASK) | dpll_ctl,
+		    DPLL_CTL);
+
+	for (i = 0; i < 0x1FF; i++)
+		nop();
+
+	/*
+	 * Wait for PLL relock.
+	 */
+
+	while ((omap_readw(DPLL_CTL) & 0x1) == 0);
+}
+
+static void set_low_pwr(int lowpwr)
+{
+	int cur_lowpwr;
+
+	if (lowpwr == -1)
+		return;
+
+	cur_lowpwr = (omap_readw(ULPD_POWER_CTRL) & (ULPD_LOW_PWR_REQ)) ?
+		1 : 0;
+
+	if (cur_lowpwr != lowpwr) {
+		if (lowpwr)
+			omap_writew(omap_readw(ULPD_POWER_CTRL) | LOW_POWER,
+				    ULPD_POWER_CTRL);
+		else
+			omap_writew(omap_readw(ULPD_POWER_CTRL) & ~LOW_POWER,
+				    ULPD_POWER_CTRL);
+	}
+}
+
+int
+powerop_set_point(struct powerop_point *point)
+{
+	int dpll_ctl = 0;
+	int dpll_mod = 0;
+	int arm_ctl = 0;
+	int arm_msk = 0;
+	int cur_dpll_ctl;
+	unsigned long flags;
+
+	if ((point->dpllmult != -1) && (point->dplldiv != -1)) {
+		dpll_ctl = (point->dpllmult << 7) |
+			(point->dplldiv << 5);
+		dpll_mod = 1;
+	}
+
+	if (point->armdiv != -1) {
+		arm_ctl |= (point->armdiv << CKCTL_ARMDIV_OFFSET);
+		arm_msk |= (3 << CKCTL_ARMDIV_OFFSET);
+	}
+
+	if (point->dspdiv != -1) {
+		arm_ctl |= (point->dspdiv << CKCTL_DSPDIV_OFFSET);
+		arm_msk |= (3 << CKCTL_DSPDIV_OFFSET);
+	}
+
+	if (point->tcdiv != -1) {
+		arm_ctl |= (point->tcdiv << CKCTL_TCDIV_OFFSET);
+		arm_msk |= (3 << CKCTL_TCDIV_OFFSET);
+	}
+
+	local_irq_save(flags);
+	cur_dpll_ctl = omap_readw(DPLL_CTL) & DPLL_CTL_MASK;
+
+	if (dpll_mod && (dpll_ctl < cur_dpll_ctl))
+		scale_dpll(dpll_ctl);
+
+	if (arm_msk != 0)
+		omap_writew((omap_readw(ARM_CKCTL) & ~arm_msk) | arm_ctl,
+			    ARM_CKCTL);
+
+	if (dpll_mod && (dpll_ctl > cur_dpll_ctl))
+		scale_dpll(dpll_ctl);
+
+	set_low_pwr(point->lowpwr);
+	local_irq_restore(flags);
+	return 0;
+}
+
+EXPORT_SYMBOL_GPL(powerop_get_point);
+EXPORT_SYMBOL_GPL(powerop_set_point);
+
+static int __init powerop_init(void)
+{
+	return 0;
+}
+
+static void __exit powerop_exit(void)
+{
+}
+
+module_init(powerop_init);
+module_exit(powerop_exit);
Index: linux-2.6.13-rc4/include/asm-arm/arch-omap/powerop.h
===================================================================
--- /dev/null
+++ linux-2.6.13-rc4/include/asm-arm/arch-omap/powerop.h
@@ -0,0 +1,27 @@
+/*
+ * PowerOP support for OMAP1
+ *
+ * Based on DPM OMAP code by Matthew Locke, Dmitry Chigirev, Vladimir
+ * Barinov, and Todd Poynor.
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __ASM_ARCH_OMAP_POWEROP_H
+#define __ASM_ARCH_OMAP_POWEROP_H
+
+/* -1 for any following fields indicates no change from current op */
+
+struct powerop_point {
+        int lowpwr;	/* 1 = assert ULPD DVS LOW_PWR */
+	int dpllmult;	/* DPLL_CTL PLL MULT 0..31 */
+	int dplldiv;	/* DPLL_CTL PLL DIV 0..3 */
+	int armdiv;	/* ARM_CKCTL ARMDIV 0..3 */
+	int dspdiv;	/* ARM_CKCTL DSPDIV 0..3 */
+	int tcdiv;	/* ARM_CKCTL TCDIV 0..3 */
+};
+
+#endif /* __ASM_ARCH_OMAP_POWEROP_H */
Index: linux-2.6.13-rc4/arch/arm/mach-omap1/Kconfig
===================================================================
--- linux-2.6.13-rc4.orig/arch/arm/mach-omap1/Kconfig
+++ linux-2.6.13-rc4/arch/arm/mach-omap1/Kconfig
@@ -152,3 +152,6 @@ config OMAP_ARM_30MHZ
 
 source "arch/arm/plat-omap/dsp/Kconfig"
 
+config	POWEROP
+	bool "PowerOP Platform Core Power Management for OMAP1"
+	help
Index: linux-2.6.13-rc4/arch/arm/mach-omap1/Makefile
===================================================================
--- linux-2.6.13-rc4.orig/arch/arm/mach-omap1/Makefile
+++ linux-2.6.13-rc4/arch/arm/mach-omap1/Makefile
@@ -29,3 +29,4 @@ led-$(CONFIG_MACH_OMAP_PERSEUS2)	+= leds
 led-$(CONFIG_MACH_OMAP_OSK)		+= leds-osk.o
 obj-$(CONFIG_LEDS)			+= $(led-y)
 
+obj-$(CONFIG_POWEROP)			+= powerop.o
Index: linux-2.6.13-rc4/include/asm-arm/powerop.h
===================================================================
--- /dev/null
+++ linux-2.6.13-rc4/include/asm-arm/powerop.h
@@ -0,0 +1,18 @@
+/*
+ * PowerOP support for ARM
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __ASM_POWEROP_H
+#define __ASM_POWEROP_H
+
+#include <asm/arch/powerop.h>
+
+extern int powerop_get_point(struct powerop_point *point);
+extern int powerop_set_point(struct powerop_point *point);
+
+#endif /* __ASM_POWEROP_H */
