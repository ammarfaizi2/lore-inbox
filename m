Return-Path: <linux-kernel-owner+w=401wt.eu-S964894AbWLMQJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWLMQJ2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 11:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWLMQJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 11:09:27 -0500
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8]:58101 "EHLO
	aeryn.fluff.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964894AbWLMQJY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 11:09:24 -0500
X-Greylist: delayed 1058 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 11:09:23 EST
Date: Wed, 13 Dec 2006 15:51:35 +0000
From: Ben Dooks <ben-fbdev@fluff.org>
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: SM501: core (mfd) driver
Message-ID: <20061213155134.GA10097@home.fluff.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is a proposed core driver for the Silicon Motion SM501
to support the block-specific drivers.

The patch provides support for either a platform or PCI attached
SM501, to initialise the core and then export new devices for the
function drivers to attach to.

Included in the patch is a set of register defines for most of the
blocks and the SM501 framebuffer.

For more information, there is a Documentation/SM501.txt which
explains the design decisions in the patch.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Vincent Sanders <vince@simtec.co.uk>

diff -urpN -X ../dontdiff linux-2.6.19/Documentation/SM501.txt linux-2.6.19-simtec1p9/Documentation/SM501.txt
--- linux-2.6.19/Documentation/SM501.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19-simtec1p9/Documentation/SM501.txt	2006-12-13 11:44:04.000000000 +0000
@@ -0,0 +1,58 @@
+			SM501 Driver
+			============
+
+Copyright 2006 Simtec Electronics
+
+Core
+----
+
+The core driver in drivers/mfd provides common services for the
+drivers which manage the specific hardware blocks. These services
+include locking for common registers, clock control and resource
+management.
+
+The core registers drivers for both PCI and generic bus based
+chips via the platform device and driver system.
+
+On detection of a device, the core initialises the chip (which may
+be specified by the platfrom data) and then exports the selected
+peripheral set as platform devices for the specific drivers.
+
+The core re-uses the platform device system as the platform device
+system provides enough features to support the drivers without the
+need to create a new bus-type and the associated code to go with it.
+
+
+Resources
+---------
+
+Each peripheral's view of the device is implicitly narrowed to the
+specific set of resources it requires in order to function correctly.
+
+The centralised memory allocation allows the driver to ensure that the
+maximum possible resource allocation can be made to the video subsystem
+as this is by-far the most resource-sensitive of the on-chip functions.
+
+The primary issue with memory allocation is that of moving the video
+buffers once a display mode is chosen. Indeed when a video mode change
+occurs the memory footprint of the video subsystem changes.
+
+Since Video memory is difficult to move without changing the display
+(unless sufficient contiguous memory can be provided for the old and new
+modes simultaneously) the video driver fully utilises the memory area
+given to it by aligning fb0 to the start of the area and fb1 to the end
+of it. Any memory left over in the middle is used for the acceleration
+functions, which are transient and thus their location is less critical
+as it can be moved.
+
+
+Configuration
+-------------
+
+The platform device driver uses a set of platform data to pass
+configurations through to the core and the subsidiary drivers
+so that there can be sujpport for more than one system carrying
+an SM501 built into a single kernel image.
+
+Currently the PCI driver assumes the manufacturer's reference
+design.
diff -urpN -X ../dontdiff linux-2.6.19/drivers/mfd/Kconfig linux-2.6.19-simtec1p9/drivers/mfd/Kconfig
--- linux-2.6.19/drivers/mfd/Kconfig	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19-simtec1p9/drivers/mfd/Kconfig	2006-12-06 00:12:24.000000000 +0000
@@ -2,6 +2,20 @@
 # Multifunction miscellaneous devices
 #
 
+menu "Multifunction device drivers"
+
+config MFD_SM501
+	tristate "Support for Silicon Motion SM501"
+	 ---help---
+	  This is the core driver for the Silicon motion SM501 multimedia 
+	  companion chip. This device is a multifunction device which may 
+	  provide numerous interfaces including USB host controller USB gadget,
+	  Asyncronous Serial ports, Audio functions and a dual display video 
+	  interface. The device may be connected by PCI or local bus with 
+	  varying functions enabled.
+
+endmenu
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff -urpN -X ../dontdiff linux-2.6.19/drivers/mfd/Makefile linux-2.6.19-simtec1p9/drivers/mfd/Makefile
--- linux-2.6.19/drivers/mfd/Makefile	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19-simtec1p9/drivers/mfd/Makefile	2006-12-06 00:12:24.000000000 +0000
@@ -2,6 +2,8 @@
 # Makefile for multifunction miscellaneous devices
 #
 
+obj-$(CONFIG_MFD_SM501)		+= sm501.o
+
 obj-$(CONFIG_MCP)		+= mcp-core.o
 obj-$(CONFIG_MCP_SA11X0)	+= mcp-sa11x0.o
 obj-$(CONFIG_MCP_UCB1200)	+= ucb1x00-core.o
diff -urpN -X ../dontdiff linux-2.6.19/drivers/mfd/sm501.c linux-2.6.19-simtec1p9/drivers/mfd/sm501.c
--- linux-2.6.19/drivers/mfd/sm501.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19-simtec1p9/drivers/mfd/sm501.c	2006-12-13 02:01:33.000000000 +0000
@@ -0,0 +1,1061 @@
+/* linux/drivers/mfd/sm501.c
+ *
+ * Copyright (C) 2006 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	Vincent Sanders <vince@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * SM501 MFD driver
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/serial_8250.h>
+
+#include <linux/sm501.h>
+#include <linux/sm501-regs.h>
+
+#include <asm/sizes.h>
+#include <asm/io.h>
+
+/* we need to work out why we cannot reserve these PCI regions */
+#define do_request_regions	(0)
+
+struct sm501_device {
+	struct list_head		list;
+	struct platform_device		pdev;
+};
+
+struct sm501_devdata {
+	spinlock_t			 reg_lock;
+	struct semaphore		 clock_lock;
+	struct list_head		 devices;
+
+	struct device			*dev;
+	struct resource			*io_res;
+	struct resource			*mem_res;
+	struct sm501_platdata		*platdata;
+	
+	int				 unit_power[20];
+	unsigned int			 pdev_id;
+	unsigned int			 irq;
+	void __iomem			*regs;
+};
+
+#ifdef CONFIG_DEBUG
+static unsigned int misc_div[] = {
+	[0]		= 1,
+	[1]		= 2,
+	[2]		= 4,
+	[3]		= 8,
+	[4]		= 16,
+	[5]		= 32,
+	[6]		= 64,
+	[7]		= 128,
+	[8]		= 3,
+	[9]		= 6,
+	[10]		= 12,
+	[11]		= 24,
+	[12]		= 48,
+	[13]		= 96,
+	[14]		= 192,
+	[15]		= 384,
+};
+
+static unsigned int px_div[] = {
+	[0]		= 1,
+	[1]		= 2,
+	[2]		= 4,
+	[3]		= 8,
+	[4]		= 16,
+	[5]		= 32,
+	[6]		= 64,
+	[7]		= 128,
+	[8]		= 3,
+	[9]		= 6,
+	[10]	        = 12,
+	[11]		= 24,
+	[12]		= 48,
+	[13]		= 96,
+	[14]		= 192,
+	[15]		= 384,
+	[16]		= 5,
+	[17]		= 10,
+	[18]		= 20,
+	[19]		= 40,
+	[20]		= 80,
+	[21]		= 160,
+	[22]		= 320,
+	[23]		= 604,
+};
+#endif
+
+#define decode_div(val, lshft, selbit, mask, dtab) \
+	((((val) & (selbit)) ? pll2 : 288 * MHZ) / dtab[(((val) >> (lshft)) & (mask))])
+
+#define MHZ (1000 * 1000)
+
+#define fmt_freq(x) ((x) / MHZ), ((x) % MHZ), (x)
+
+#ifdef CONFIG_DEBUG
+
+/* sm501_dump_clk
+ *
+ * Print out the current clock configuration for the device 
+*/
+
+static void sm501_dump_clk(struct sm501_devdata *sm)
+{
+	unsigned long misct = readl(sm->regs + SM501_MISC_TIMING);
+	unsigned long pm0 = readl(sm->regs + SM501_POWER_MODE_0_CLOCK);
+	unsigned long pm1 = readl(sm->regs + SM501_POWER_MODE_1_CLOCK);
+	unsigned long pmc = readl(sm->regs + SM501_POWER_MODE_CONTROL);
+	unsigned long sdclk0, sdclk1;
+	unsigned long pll2 = 0;
+
+	switch (misct & 0x30) {
+	case 0x00:
+		pll2 = 336 * MHZ;
+		break;
+	case 0x10:
+		pll2 = 288 * MHZ;
+		break;
+	case 0x20:
+		pll2 = 240 * MHZ;
+		break;
+	case 0x30:
+		pll2 = 192 * MHZ;
+		break;
+	}
+
+	sdclk0 = (misct & (1<<12)) ? pll2 : 288 * MHZ;
+	sdclk0 /= misc_div[((misct >> 8) & 0xf)];
+
+	sdclk1 = (misct & (1<<20)) ? pll2 : 288 * MHZ;
+	sdclk1 /= misc_div[((misct >> 16) & 0xf)];
+
+	dev_dbg(sm->dev, "MISCT=%08lx, PM0=%08lx, PM1=%08lx\n",
+		misct, pm0, pm1);
+	
+	dev_dbg(sm->dev, "PLL2 = %ld.%ld MHz (%ld), SDCLK0=%08lx, SDCLK1=%08lx\n",
+		fmt_freq(pll2), sdclk0, sdclk1);
+
+	dev_dbg(sm->dev, "SDRAM: PM0=%ld, PM1=%ld\n", sdclk0, sdclk1);
+
+	dev_dbg(sm->dev, "PM0[%c]: "
+		 "P2 %ld.%ld MHz (%ld), V2 %ld.%ld (%ld), "
+		 "M %ld.%ld (%ld), MX1 %ld.%ld (%ld)\n",
+		 (pmc & 3 ) == 0 ? '*' : '-',
+		 fmt_freq(decode_div(pm0, 24, 1<<29, 31, px_div)),
+		 fmt_freq(decode_div(pm0, 16, 1<<20, 15, misc_div)),
+		 fmt_freq(decode_div(pm0, 8,  1<<12, 15, misc_div)),
+		 fmt_freq(decode_div(pm0, 0,  1<<4,  15, misc_div)));
+
+	dev_dbg(sm->dev, "PM1[%c]: "
+		"P2 %ld.%ld MHz (%ld), V2 %ld.%ld (%ld), "
+		"M %ld.%ld (%ld), MX1 %ld.%ld (%ld)\n",
+		(pmc & 3 ) == 1 ? '*' : '-',
+		fmt_freq(decode_div(pm1, 24, 1<<29, 31, px_div)),
+		fmt_freq(decode_div(pm1, 16, 1<<20, 15, misc_div)),
+		fmt_freq(decode_div(pm1, 8,  1<<12, 15, misc_div)),
+		fmt_freq(decode_div(pm1, 0,  1<<4,  15, misc_div)));
+}
+#else
+static void sm501_dump_clk(struct sm501_devdata *sm)
+{
+}
+#endif
+
+/* sm501_misc_control
+ *
+ * alters the misceleneous control parameters
+*/
+
+int sm501_misc_control(struct device *dev,
+		       unsigned long set, unsigned long clear)
+{
+	struct sm501_devdata *sm = dev_get_drvdata(dev);
+	unsigned long misc = readl(sm->regs + SM501_MISC_CONTROL);
+	unsigned long to;
+	
+	to = (misc & ~clear) | set;
+
+	if (to != misc) {	
+		writel(to, sm->regs + SM501_MISC_CONTROL);
+		dev_dbg(sm->dev, "MISC_CONTROL %08lx\n", misc);
+	}
+
+	return to;
+}
+
+EXPORT_SYMBOL_GPL(sm501_misc_control);
+
+/* sm501_modify_reg
+ *
+ * Modify a register in the SM501 which may be shared with other
+ * drivers.
+*/
+
+unsigned long sm501_modify_reg(struct device *dev,
+			       unsigned long reg,
+			       unsigned long set,
+			       unsigned long clear)
+{
+	struct sm501_devdata *sm = dev_get_drvdata(dev);
+	unsigned long data;
+	unsigned long save;
+
+	spin_lock_irqsave(&sm->reg_lock, save);
+
+	data = readl(sm->regs + reg);
+	data |= set;
+	data &= ~clear;
+	writel(data, sm->regs + reg);
+       
+	spin_unlock_irqrestore(&sm->reg_lock, save);
+
+	return data;
+}
+
+EXPORT_SYMBOL_GPL(sm501_modify_reg);
+
+unsigned long sm501_gpio_get(struct device *dev,
+			     unsigned long gpio)
+{
+	struct sm501_devdata *sm = dev_get_drvdata(dev);
+	unsigned long result;
+	unsigned long reg;
+
+	reg = (gpio > 32) ? SM501_GPIO_DATA_HIGH : SM501_GPIO_DATA_LOW;
+	result = readl(sm->regs + reg);
+
+	result >>= (gpio & 31);
+	return result & 1UL;
+}
+
+EXPORT_SYMBOL_GPL(sm501_gpio_get);
+
+void sm501_gpio_set(struct device *dev,
+		    unsigned long gpio,
+		    unsigned int to,
+		    unsigned int dir)
+{
+	struct sm501_devdata *sm = dev_get_drvdata(dev);
+
+	unsigned long bit = 1 << (gpio & 31);
+	unsigned long base;
+	unsigned long save;
+	unsigned long val;
+
+	base = (gpio > 32) ? SM501_GPIO_DATA_HIGH : SM501_GPIO_DATA_LOW;
+	base += SM501_GPIO;
+
+	spin_lock_irqsave(&sm->reg_lock, save);
+
+	val = readl(sm->regs + base);
+	if (to)
+		val |= bit;
+	else
+		val &= ~bit;
+	writel(val, sm->regs + base);
+
+	val = readl(sm->regs + SM501_GPIO_DDR_LOW);
+	if (dir)
+		val |= bit;
+	else
+		val &= ~bit;
+	writel(val, sm->regs + SM501_GPIO_DDR_LOW);
+
+	spin_unlock_irqrestore(&sm->reg_lock, save);
+
+}
+
+EXPORT_SYMBOL_GPL(sm501_gpio_set);
+
+
+/* sm501_unit_power
+ *
+ * alters the power active gate to set specific units on or off
+ */
+
+int sm501_unit_power(struct device *dev, unsigned int unit, unsigned int to)
+{
+	struct sm501_devdata *sm = dev_get_drvdata(dev);
+	unsigned long mode = readl(sm->regs + SM501_POWER_MODE_CONTROL);
+	unsigned long gate = readl(sm->regs + SM501_CURRENT_GATE);
+	unsigned long clock = readl(sm->regs + SM501_CURRENT_CLOCK);
+
+	mode &= 3;		/* get current power mode */
+
+	down(&sm->clock_lock);
+
+	if (unit > ARRAY_SIZE(sm->unit_power)) {
+		dev_err(dev, "bad unit %d passed to %s\n", unit, __FUNCTION__);
+		goto already;
+	}
+
+	if (to == 0 && sm->unit_power[unit] == 0) {
+		dev_err(sm->dev, "unit %d is already shutdown\n", unit);
+		goto already;
+	}
+
+	sm->unit_power[unit] += to ? 1 : -1;
+	to = sm->unit_power[unit] ? 1 : 0;
+
+	if (to) {
+		if (gate & (1 << unit))
+			goto already;
+		gate |= (1 << unit);
+	} else {
+		if (!(gate & (1 << unit)))
+			goto already;
+		gate &= ~(1 << unit);
+	}
+
+	switch (mode) {
+	case 1:
+		writel(gate, sm->regs + SM501_POWER_MODE_0_GATE);
+		writel(clock, sm->regs + SM501_POWER_MODE_0_CLOCK);
+		mode = 0;
+		break;
+	case 2:
+	case 0:
+		writel(gate, sm->regs + SM501_POWER_MODE_1_GATE);
+		writel(clock, sm->regs + SM501_POWER_MODE_1_CLOCK);
+		mode = 1;
+		break;
+
+	default:
+		return -1;
+	}
+
+	writel(mode, sm->regs + SM501_POWER_MODE_CONTROL);
+
+	dev_dbg(sm->dev, "gate %08lx, clock %08lx, mode %08lx\n",
+		gate, clock, mode);
+
+	msleep(16);
+
+ already:
+	up(&sm->clock_lock);
+	return gate;
+}
+
+EXPORT_SYMBOL_GPL(sm501_unit_power);
+
+
+/* Perform a rounded division. */
+static long sm501fb_round_div(long num, long denom)
+{
+        /* n / d + 1 / 2 = (2n + d) / 2d */
+        return (2 * num + denom) / (2 * denom);
+}
+
+/* clock value structure. */
+struct sm501_clock {
+	unsigned long mclk;
+	int divider;
+	int shift;
+};
+
+/* sm501_select_clock
+ *
+ * selects nearest discrete clock frequency the SM501 can achive
+ *   the maximum divisor is 3 or 5
+ */
+static unsigned long sm501_select_clock(unsigned long freq,
+					struct sm501_clock *clock,
+					int max_div)
+{
+	unsigned long mclk;
+	int divider;
+	int shift;
+	long diff;
+	long best_diff = 999999999;
+
+	/* Try 288MHz and 336MHz clocks. */
+	for (mclk = 288000000; mclk <= 336000000; mclk += 48000000) {
+		/* try dividers 1 and 3 for CRT and for panel,
+		   try divider 5 for panel only.*/
+
+		for (divider = 1; divider <= max_div; divider += 2) {
+			/* try all 8 shift values.*/
+			for (shift = 0; shift < 8; shift++) {
+				/* Calculate difference to requested clock */
+				diff = sm501fb_round_div(mclk, divider << shift) - freq;
+				if (diff < 0)
+					diff = -diff;
+
+				/* If it is less than the current, use it */
+				if (diff < best_diff) {
+					best_diff = diff;
+
+					clock->mclk = mclk;
+					clock->divider = divider;
+					clock->shift = shift;
+				}
+			}
+		}
+	}
+
+	/* Return best clock. */
+	return clock->mclk / (clock->divider << clock->shift);
+}
+
+/* sm501_set_clock
+ *
+ * set one of the four clock sources to the closest available frequency to
+ *  the one specified
+ */
+unsigned long sm501_set_clock(struct device *dev,
+			      int clksrc,
+			      unsigned long req_freq)
+{
+	struct sm501_devdata *sm = dev_get_drvdata(dev);
+	unsigned long mode = readl(sm->regs + SM501_POWER_MODE_CONTROL);
+	unsigned long gate = readl(sm->regs + SM501_CURRENT_GATE);
+	unsigned long clock = readl(sm->regs + SM501_CURRENT_CLOCK);
+	unsigned char reg;
+	unsigned long sm501_freq; /* the actual frequency acheived */
+
+	struct sm501_clock to;
+
+	/* find achivable discrete frequency and setup register value
+	 * accordingly, V2XCLK, MCLK and M1XCLK are the same P2XCLK
+	 * has an extra bit for the divider */
+
+	switch (clksrc) {
+	case SM501_CLOCK_P2XCLK:
+		/* This clock is divided in half so to achive the
+		 * requested frequency the value must be multiplied by
+		 * 2. This clock also has an additional pre divisor */
+
+		sm501_freq = (sm501_select_clock(2 * req_freq, &to, 5) / 2);
+		reg=to.shift & 0x07;/* bottom 3 bits are shift */
+		if (to.divider == 3)
+			reg |= 0x08; /* /3 divider required */
+		else if (to.divider == 5)
+			reg |= 0x10; /* /5 divider required */
+		if (to.mclk != 288000000)
+			reg |= 0x20; /* which mclk pll is source */
+		break;
+
+	case SM501_CLOCK_V2XCLK:
+		/* This clock is divided in half so to achive the
+		 * requested frequency the value must be multiplied by 2. */
+
+		sm501_freq = (sm501_select_clock(2 * req_freq, &to, 3) / 2);
+		reg=to.shift & 0x07;	/* bottom 3 bits are shift */
+		if (to.divider == 3)
+			reg |= 0x08;	/* /3 divider required */
+		if (to.mclk != 288000000)
+			reg |= 0x10;	/* which mclk pll is source */
+		break;
+
+	case SM501_CLOCK_MCLK:
+	case SM501_CLOCK_M1XCLK:
+		/* These clocks are the same and not further divided */
+
+		sm501_freq = sm501_select_clock( req_freq, &to, 3);
+		reg=to.shift & 0x07;	/* bottom 3 bits are shift */
+		if (to.divider == 3)
+			reg |= 0x08;	/* /3 divider required */
+		if (to.mclk != 288000000)
+			reg |= 0x10;	/* which mclk pll is source */
+		break;
+
+	default:
+		return 0; /* this is bad */
+	}
+
+	clock = clock & ~(0xFF << clksrc);
+	clock |= reg<<clksrc;
+
+	mode &= 3;	/* find current mode */
+
+	switch (mode) {
+	case 1:
+		writel(gate, sm->regs + SM501_POWER_MODE_0_GATE);
+		writel(clock, sm->regs + SM501_POWER_MODE_0_CLOCK);
+		mode = 0;
+		break;
+	case 2:
+	case 0:
+		writel(gate, sm->regs + SM501_POWER_MODE_1_GATE);
+		writel(clock, sm->regs + SM501_POWER_MODE_1_CLOCK);
+		mode = 1;
+		break;
+
+	default:
+		return -1;
+	}
+
+	writel(mode, sm->regs + SM501_POWER_MODE_CONTROL);
+
+	dev_info(sm->dev, "gate %08lx, clock %08lx, mode %08lx\n",
+		 gate, clock, mode);
+
+	msleep(16);
+	sm501_dump_clk(sm);
+
+	return sm501_freq;
+}
+
+EXPORT_SYMBOL_GPL(sm501_set_clock);
+
+/* sm501_find_clock
+ *
+ * finds the closest available frequency for a given clock
+*/
+
+unsigned long sm501_find_clock(int clksrc,
+			       unsigned long req_freq)
+{
+	unsigned long sm501_freq; /* the frequency achiveable by the 501 */
+	struct sm501_clock to;
+
+	switch (clksrc) {
+	case SM501_CLOCK_P2XCLK:
+		sm501_freq = (sm501_select_clock(2 * req_freq, &to, 5) / 2);
+		break;
+
+	case SM501_CLOCK_V2XCLK:
+		sm501_freq = (sm501_select_clock(2 * req_freq, &to, 3) / 2);
+		break;
+
+	case SM501_CLOCK_MCLK:
+	case SM501_CLOCK_M1XCLK:
+		sm501_freq = sm501_select_clock(req_freq, &to, 3);
+		break;
+
+	default:
+		sm501_freq = 0;		/* error */
+	}
+
+	return sm501_freq;
+}
+
+EXPORT_SYMBOL_GPL(sm501_find_clock);
+
+/* sm501_null_release
+ *
+ * A release function for the platform devices we create to keep the
+ * driver core happy, and stop any crashed when the devices are removed
+*/
+
+static void sm501_null_release(struct device *dev)
+{
+}
+
+/* sm501_create_subdev
+ *
+ * Create a skeleton platform device with resources for passing to a
+ * sub-driver
+*/
+
+static struct platform_device *
+sm501_create_subdev(struct sm501_devdata *sm,
+		    char *name, unsigned int res_count)
+{
+	struct sm501_device *smdev;
+
+	smdev = kzalloc(sizeof(struct sm501_device) +
+			sizeof(struct resource) * res_count, GFP_KERNEL);
+	if (!smdev)
+		return NULL;
+
+	smdev->pdev.dev.release = sm501_null_release;
+
+	smdev->pdev.name = name;
+	smdev->pdev.id = sm->pdev_id;
+	smdev->pdev.resource = (struct resource *)(smdev+1);
+	smdev->pdev.num_resources = res_count;
+
+	smdev->pdev.dev.parent = sm->dev;
+
+	return &smdev->pdev;
+}
+
+static struct sm501_device *to_sm_device(struct platform_device *pdev)
+{
+	return container_of(pdev, struct sm501_device, pdev);
+}
+
+/* sm501_register_device
+ *
+ * Register a platform device created with sm501_create_subdev()
+*/
+
+static int sm501_register_device(struct sm501_devdata *sm,
+				 struct platform_device *pdev)
+{
+	struct sm501_device *smdev = to_sm_device(pdev);
+	int ptr;
+	int ret;
+
+	for (ptr = 0; ptr < pdev->num_resources; ptr++) {
+		printk("%s[%d] flags %08lx: %08zx..%08zx\n",
+		       pdev->name, ptr,
+		       pdev->resource[ptr].flags,
+		       pdev->resource[ptr].start,
+		       pdev->resource[ptr].end);
+	}
+	
+	ret = platform_device_register(pdev);
+
+	if (ret > 0)
+		list_add_tail(&smdev->list, &sm->devices);
+	else
+		dev_err(sm->dev, "error registering %s (%d)\n",
+			pdev->name, ret);
+
+	return ret;
+}
+
+/* sm501_create_subio
+ *
+ * Fill in an IO resource for a sub device
+*/
+
+static void sm501_create_subio(struct sm501_devdata *sm,
+			       struct resource *res,
+			       unsigned long offs,
+			       unsigned long size)
+{
+	res->flags = IORESOURCE_MEM;
+	res->parent = sm->io_res;
+	res->start = sm->io_res->start + offs;
+	res->end = res->start + size - 1;
+}
+
+/* sm501_create_mem
+ *
+ * Fill in an MEM resource for a sub device
+*/
+
+static void sm501_create_mem(struct sm501_devdata *sm,
+			     struct resource *res,
+			     unsigned long *offs,
+			     unsigned long size)
+{
+	*offs -= size;		/* adjust memory size */
+
+	res->flags = IORESOURCE_MEM;
+	res->parent = sm->mem_res;
+	res->start = sm->mem_res->start + *offs;
+	res->end = res->start + size - 1;
+}
+
+/* sm501_create_irq
+ *
+ * Fill in an IRQ resource for a sub device
+*/
+
+static void sm501_create_irq(struct sm501_devdata *sm,
+			     struct resource *res)
+{
+	res->flags = IORESOURCE_IRQ;
+	res->parent = NULL;
+	res->start = res->end = sm->irq;
+}
+
+static int sm501_register_usbhost(struct sm501_devdata *sm,
+				  unsigned long *mem_avail)
+{
+	struct platform_device *pdev;
+
+	pdev = sm501_create_subdev(sm, "sm501-usb", 3);
+	if (!pdev)
+		return -ENOMEM;
+
+	sm501_create_subio(sm, &pdev->resource[0], 0x40000, 0x20000);
+	sm501_create_mem(sm, &pdev->resource[1], mem_avail, SZ_256K);
+	sm501_create_irq(sm, &pdev->resource[2]);
+
+	return sm501_register_device(sm, pdev);
+}
+
+static int sm501_register_display(struct sm501_devdata *sm,
+				  unsigned long *mem_avail)
+{
+	struct platform_device *pdev;
+
+	pdev = sm501_create_subdev(sm, "sm501-fb", 4);
+	if (!pdev)
+		return -ENOMEM;
+
+	sm501_create_subio(sm, &pdev->resource[0], 0x80000, 0x10000);
+	sm501_create_subio(sm, &pdev->resource[1], 0x100000, 0x50000);
+	sm501_create_mem(sm, &pdev->resource[2], mem_avail, *mem_avail);
+	sm501_create_irq(sm, &pdev->resource[3]);
+
+	return sm501_register_device(sm, pdev);
+}
+
+/* sm501_dbg_regs
+ *
+ * Debug attribute to attach to parent device to show core registers
+*/
+
+static ssize_t sm501_dbg_regs(struct device *dev,
+			      struct device_attribute *attr, char *buff)
+{
+	struct sm501_devdata *sm = dev_get_drvdata(dev)	;
+	unsigned int reg;
+	char *ptr = buff;
+	int ret;
+
+	for (reg = 0x00; reg < 0x70; reg += 4) {
+		ret = sprintf(ptr, "%08x = %08x\n",
+			      reg, readl(sm->regs + reg));
+		ptr += ret;
+	}
+
+	return ptr - buff;
+}
+
+
+static DEVICE_ATTR(dbg_regs, 0666, sm501_dbg_regs, NULL);
+
+/* sm501_init_reg
+ * 
+ * Helper function for the init code to setup a register 
+*/
+
+static inline void sm501_init_reg(struct sm501_devdata *sm,
+				  unsigned long reg,
+				  struct sm501_reg_init *r)
+{
+	unsigned long tmp;
+
+	tmp = readl(sm->regs + reg);
+	tmp |= r->set;
+	tmp &= ~r->mask;
+	writel(tmp, sm->regs + reg);
+}
+
+/* sm501_init_regs
+ *
+ * Setup core register values 
+*/
+
+static void sm501_init_regs(struct sm501_devdata *sm,
+			    struct sm501_initdata *init)
+{
+	sm501_misc_control(sm->dev, 
+			   init->misc_control.set,
+			   init->misc_control.mask);
+
+	sm501_init_reg(sm, SM501_MISC_TIMING, &init->misc_timing);
+	sm501_init_reg(sm, SM501_GPIO31_0_CONTROL, &init->gpio_low);
+	sm501_init_reg(sm, SM501_GPIO63_32_CONTROL, &init->gpio_high);
+}
+
+static unsigned int sm501_mem_local[] = {
+	[0]	= SZ_4M,
+	[1]	= SZ_8M,
+	[2]	= SZ_16M,
+	[3]	= SZ_32M,
+	[4]	= SZ_64M,
+	[5]	= SZ_2M,
+};
+
+/* sm501_init_dev
+ *
+ * Common init code for an SM501
+*/
+
+static int sm501_init_dev(struct sm501_devdata *sm)
+{
+	unsigned long mem_avail;
+	unsigned long dramctrl;
+	int ret;
+
+	dramctrl = readl(sm->regs + SM501_DRAM_CONTROL);
+
+	mem_avail = sm501_mem_local[(dramctrl >> 13) & 0x7];
+
+	dev_info(sm->dev, "SM501 At %p,%p: Version %08x, %ld Mb, IRQ %d\n",
+		 NULL, sm->regs, readl(sm->regs + SM501_DEVICEID),
+		 mem_avail >> 20, sm->irq);
+
+	dev_info(sm->dev, "CurrentGate      %08x\n", readl(sm->regs+0x38));
+	dev_info(sm->dev, "CurrentClock     %08x\n", readl(sm->regs+0x3c));
+	dev_info(sm->dev, "PowerModeControl %08x\n", readl(sm->regs+0x54));
+
+	ret = device_create_file(sm->dev, &dev_attr_dbg_regs);
+	if (ret)
+		dev_err(sm->dev, "failed to create debug regs file\n");
+
+	sm501_dump_clk(sm);
+
+	/* check to see if we have some device initialisation */
+
+	if (sm->platdata) {
+		struct sm501_platdata *pdata = sm->platdata;
+
+		if (pdata->init) {
+			sm501_init_regs(sm, sm->platdata->init);
+
+			if (pdata->init->devices & SM501_USE_USB_HOST)
+				sm501_register_usbhost(sm, &mem_avail);
+		}
+	}
+
+	/* always create a framebuffer */
+	sm501_register_display(sm, &mem_avail);
+
+	return 0;
+}
+
+static int sm501_plat_probe(struct platform_device *dev)
+{
+	struct sm501_devdata *sm;
+	int err;
+
+	sm = kzalloc(sizeof(struct sm501_devdata), GFP_KERNEL);
+	if (sm == NULL) {
+		dev_err(&dev->dev, "no memory for device data\n");
+		err = -ENOMEM;
+		goto err1;
+	}
+
+	sema_init(&sm->clock_lock, 1);
+	spin_lock_init(&sm->reg_lock);
+
+	sm->dev = &dev->dev;
+	sm->pdev_id = dev->id;
+	sm->irq = platform_get_irq(dev, 0);
+	sm->io_res = platform_get_resource(dev, IORESOURCE_MEM, 1);
+	sm->mem_res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	sm->platdata = dev->dev.platform_data;
+
+	if (sm->irq < 0) {
+		dev_err(&dev->dev, "failed to get resources\n");
+		err = sm->irq;
+		goto err_res;
+	}
+
+	if (sm->io_res == NULL || sm->mem_res == NULL) {
+		dev_err(&dev->dev, "failed to get resources\n");
+		err = -ENOENT;
+		goto err_res;
+	}
+
+	platform_set_drvdata(dev, sm);
+
+	sm->regs = ioremap(sm->io_res->start,
+			   (sm->io_res->end - sm->io_res->start) - 1);
+
+	if (sm->regs == NULL) {
+		dev_err(&dev->dev, "cannot remap registers\n");
+		err = -EIO;
+		goto err_res;
+	}
+
+	return sm501_init_dev(sm);
+
+ err_res:
+	kfree(sm);
+ err1:
+	return err;
+
+}
+
+/* Initialisation data for PCI devices */
+
+static struct sm501_initdata sm501_pci_initdata = {
+	.gpio_high	= {
+		.set	= 0x3F000000,		/* 24bit panel */
+		.mask	= 0x0,
+	},
+	.misc_timing	= {
+		.set	= 0x010100,		/* SDRAM timing */
+		.mask	= 0x1F1F00,
+	},
+	.misc_control	= {
+		.set	= SM501_MISC_PNL_24BIT,
+		.mask	= 0,
+	},
+
+	.devices	= SM501_USE_ALL,
+	.mclk		= 100 * MHZ,
+	.m1xclk		= 160 * MHZ,
+};
+
+static struct sm501_platdata sm501_pci_platdata = {
+	.init		= &sm501_pci_initdata,
+};
+
+static int sm501_pci_probe(struct pci_dev *dev,
+			   const struct pci_device_id *id)
+{
+	struct sm501_devdata *sm;
+	int err;
+
+	sm = kzalloc(sizeof(struct sm501_devdata), GFP_KERNEL);
+	if (sm == NULL) {
+		dev_err(&dev->dev, "no memory for device data\n");
+		err = -ENOMEM;
+		goto err1;
+	}
+
+	/* set a default set of platform data */
+	dev->dev.platform_data = sm->platdata = &sm501_pci_platdata;
+
+	sm->dev = &dev->dev;
+	sm->irq = dev->irq;
+
+	/* set a hopefully unique id for our child platform devices */
+	sm->pdev_id = 32 + dev->devfn;
+
+	pci_set_drvdata(dev, sm);
+
+	err = pci_enable_device(dev);
+	if (err) {
+		dev_err(&dev->dev, "cannot enable device\n");
+		goto err2;
+	}
+
+	/* check our resources */
+
+	if (!(pci_resource_flags(dev, 0) & IORESOURCE_MEM)) {
+		dev_err(&dev->dev, "region #0 is not memory?\n");
+		err = -EINVAL;
+		goto err3;
+	}
+
+	if (!(pci_resource_flags(dev, 1) & IORESOURCE_MEM)) {
+		dev_err(&dev->dev, "region #1 is not memory?\n");
+		err = -EINVAL;
+		goto err3;
+	}
+
+	/* reserve our io regions */
+
+	if (do_request_regions) {
+		err = pci_request_regions(dev, "sm501");
+		if (err) {
+			dev_err(&dev->dev, "cannot get regions\n");
+			goto err3;
+		}
+	}
+
+	sm->io_res = &dev->resource[1];
+	sm->mem_res = &dev->resource[0];
+
+	sm->regs = ioremap(pci_resource_start(dev, 1),
+			   pci_resource_len(dev, 1));
+
+	if (sm->regs == NULL) {
+		dev_err(&dev->dev, "cannot remap registers\n");
+		err = -EIO;
+		goto err4;
+	}
+
+	sm501_init_dev(sm);
+	return 0;
+
+ err4:
+	if (do_request_regions)
+		pci_release_regions(dev);
+ err3:
+	pci_disable_device(dev);
+ err2:
+	pci_set_drvdata(dev, NULL);
+	kfree(sm);
+ err1:
+	return err;
+}
+
+static void sm501_remove_sub(struct sm501_devdata *sm,
+			     struct sm501_device *smdev)
+{
+	list_del(&smdev->list);
+	platform_device_unregister(&smdev->pdev);
+}
+
+static void sm501_dev_remove(struct sm501_devdata *sm)
+{
+	struct sm501_device *smdev, *tmp;
+
+	list_for_each_entry_safe(smdev, tmp, &sm->devices, list)
+		sm501_remove_sub(sm, smdev);
+
+	device_remove_file(sm->dev, &dev_attr_dbg_regs);
+}
+
+static void sm501_pci_remove(struct pci_dev *dev)
+{
+	struct sm501_devdata *sm = pci_get_drvdata(dev);
+
+	sm501_dev_remove(sm);
+	iounmap(sm->regs);
+
+	if (do_request_regions)
+		pci_release_regions(dev);
+
+	pci_set_drvdata(dev, NULL);
+	pci_disable_device(dev);
+}
+
+static int sm501_plat_remove(struct platform_device *dev)
+{
+	struct sm501_devdata *sm = platform_get_drvdata(dev);
+
+	sm501_dev_remove(sm);
+	iounmap(sm->regs);
+
+	return 0;
+}
+
+static struct pci_device_id sm501_pci_tbl[] = {
+	{ 0x126f, 0x0501, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, sm501_pci_tbl);
+
+static struct pci_driver sm501_pci_drv = {
+	.name		= "sm501",
+	.id_table	= sm501_pci_tbl,
+	.probe		= sm501_pci_probe,
+	.remove		= sm501_pci_remove,
+};
+
+static struct platform_driver sm501_plat_drv = {
+	.driver		= {
+		.name	= "sm501",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sm501_plat_probe,
+	.remove		= sm501_plat_remove,
+};
+
+static int __init sm501_base_init(void)
+{
+	platform_driver_register(&sm501_plat_drv);
+	return pci_module_init(&sm501_pci_drv);
+}
+
+static void __exit sm501_base_exit(void)
+{
+	platform_driver_unregister(&sm501_plat_drv);
+	pci_unregister_driver(&sm501_pci_drv);
+}
+
+module_init(sm501_base_init);
+module_exit(sm501_base_exit);
+
+MODULE_DESCRIPTION("SM501 Core Driver");
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>, Vincent Sanders");
+MODULE_LICENSE("GPL v2");
diff -urpN -X ../dontdiff linux-2.6.19/include/linux/sm501-regs.h linux-2.6.19-simtec1p9/include/linux/sm501-regs.h
--- linux-2.6.19/include/linux/sm501-regs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19-simtec1p9/include/linux/sm501-regs.h	2006-12-07 15:58:14.000000000 +0000
@@ -0,0 +1,284 @@
+/* sm501-regs.h
+ *
+ * Copyright 2006 Simtec Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Silicon Motion SM501 register definitions
+*/
+
+/* System Configuration area */
+/* System config base */
+#define SM501_SYS_CONFIG		(0x000000)
+
+/* config 1 */
+#define SM501_SYSTEM_CONTROL 		(0x000000)
+#define SM501_MISC_CONTROL		(0x000004)
+
+#define SM501_MISC_BUS_SH		(0x0)
+#define SM501_MISC_BUS_PCI		(0x1)
+#define SM501_MISC_BUS_XSCALE		(0x2)
+#define SM501_MISC_BUS_NEC		(0x6)
+#define SM501_MISC_BUS_MASK		(0x7)
+
+#define SM501_MISC_VR_62MB		(1<<3)
+#define SM501_MISC_CDR_RESET		(1<<7)
+#define SM501_MISC_USB_LB		(1<<8)
+#define SM501_MISC_USB_SLAVE		(1<<9)
+#define SM501_MISC_BL_1			(1<<10)
+#define SM501_MISC_MC			(1<<11)
+#define SM501_MISC_DAC_POWER		(1<<12)
+#define SM501_MISC_IRQ_INVERT		(1<<16)
+#define SM501_MISC_SH			(1<<17)
+
+#define SM501_MISC_HOLD_EMPTY		(0<<18)
+#define SM501_MISC_HOLD_8		(1<<18)
+#define SM501_MISC_HOLD_16		(2<<18)
+#define SM501_MISC_HOLD_24		(3<<18)
+#define SM501_MISC_HOLD_32		(4<<18)
+#define SM501_MISC_HOLD_MASK		(7<<18)
+
+#define SM501_MISC_FREQ_12		(1<<24)
+#define SM501_MISC_PNL_24BIT		(1<<25)
+#define SM501_MISC_8051_LE		(1<<26)
+
+
+
+#define SM501_GPIO31_0_CONTROL		(0x000008)
+#define SM501_GPIO63_32_CONTROL		(0x00000C)
+#define SM501_DRAM_CONTROL		(0x000010)
+
+/* command list */
+#define SM501_ARBTRTN_CONTROL		(0x000014)
+
+/* command list */
+#define SM501_COMMAND_LIST_STATUS	(0x000024)
+
+/* interrupt debug */
+#define SM501_RAW_IRQ_STATUS		(0x000028)
+#define SM501_RAW_IRQ_CLEAR		(0x000028)
+#define SM501_IRQ_STATUS		(0x00002C)
+#define SM501_IRQ_MASK			(0x000030)
+#define SM501_DEBUG_CONTROL		(0x000034)
+
+/* power management */
+#define SM501_CURRENT_GATE		(0x000038)
+#define SM501_CURRENT_CLOCK		(0x00003C)
+#define SM501_POWER_MODE_0_GATE		(0x000040)
+#define SM501_POWER_MODE_0_CLOCK	(0x000044)
+#define SM501_POWER_MODE_1_GATE		(0x000048)
+#define SM501_POWER_MODE_1_CLOCK	(0x00004C)
+#define SM501_SLEEP_MODE_GATE		(0x000050)
+#define SM501_POWER_MODE_CONTROL	(0x000054)
+
+/* power gates for units within the 501 */
+#define SM501_GATE_HOST			(0)
+#define SM501_GATE_MEMORY		(1)
+#define SM501_GATE_DISPLAY		(2)
+#define SM501_GATE_2D_ENGINE		(3)
+#define SM501_GATE_CSC			(4)
+#define SM501_GATE_ZVPORT		(5)
+#define SM501_GATE_GPIO			(6)
+#define SM501_GATE_UART0		(7)
+#define SM501_GATE_UART1		(8)
+#define SM501_GATE_SSP			(10)
+#define SM501_GATE_USB_HOST		(11)
+#define SM501_GATE_USB_GADGET		(12)
+#define SM501_GATE_UCONTROLLER		(17)
+#define SM501_GATE_AC97			(18)
+
+/* panel clock */
+#define SM501_CLOCK_P2XCLK		(24)
+/* crt clock */
+#define SM501_CLOCK_V2XCLK		(16)
+/* main clock */
+#define SM501_CLOCK_MCLK		(8)
+/* SDRAM controller clock */
+#define SM501_CLOCK_M1XCLK		(0)
+
+/* config 2 */
+#define SM501_PCI_MASTER_BASE		(0x000058)
+#define SM501_ENDIAN_CONTROL		(0x00005C)
+#define SM501_DEVICEID			(0x000060)
+/* 0x050100A0 */
+
+#define SM501_PLLCLOCK_COUNT		(0x000064)
+#define SM501_MISC_TIMING		(0x000068)
+#define SM501_CURRENT_SDRAM_CLOCK	(0x00006C)
+
+/* GPIO base */
+#define SM501_GPIO			(0x010000)
+#define SM501_GPIO_DATA_LOW		(0x00)
+#define SM501_GPIO_DATA_HIGH		(0x04)
+#define SM501_GPIO_DDR_LOW		(0x08)
+#define SM501_GPIO_DDR_HIGH		(0x0C)
+#define SM501_GPIO_IRQ_SETUP		(0x10)
+#define SM501_GPIO_IRQ_STATUS		(0x14)
+#define SM501_GPIO_IRQ_RESET		(0x14)
+
+/* I2C controller base */
+#define SM501_I2C			(0x010040)
+#define SM501_I2C_BYTE_COUNT		(0x00)
+#define SM501_I2C_CONTROL		(0x01)
+#define SM501_I2C_STATUS		(0x02)
+#define SM501_I2C_RESET			(0x02)
+#define SM501_I2C_SLAVE_ADDRESS		(0x03)
+#define SM501_I2C_DATA			(0x04)
+
+/* SSP base */
+#define SM501_SSP			(0x020000)
+
+/* Uart 0 base */
+#define SM501_UART0			(0x030000)
+
+/* Uart 1 base */
+#define SM501_UART1			(0x030020)
+
+/* USB host port base */
+#define SM501_USB_HOST			(0x040000)
+
+/* USB slave/gadget base */
+#define SM501_USB_GADGET		(0x060000)
+
+/* USB slave/gadget data port base */
+#define SM501_USB_GADGET_DATA		(0x070000)
+
+/* Display contoller/video engine base */
+#define SM501_DC			(0x080000)
+#define SM501_DC_PANEL_CONTROL		(0x000)
+#define SM501_DC_PANEL_PANNING_CONTROL	(0x004)
+#define SM501_DC_PANEL_COLOR_KEY	(0x008)
+#define SM501_DC_PANEL_FB_ADDR		(0x00C)
+#define SM501_DC_PANEL_FB_OFFSET	(0x010)
+#define SM501_DC_PANEL_FB_WIDTH		(0x014)
+#define SM501_DC_PANEL_FB_HEIGHT	(0x018)
+#define SM501_DC_PANEL_TL_LOC		(0x01C)
+#define SM501_DC_PANEL_BR_LOC		(0x020)
+#define SM501_DC_PANEL_H_TOT		(0x024)
+#define SM501_DC_PANEL_H_SYNC		(0x028)
+#define SM501_DC_PANEL_V_TOT		(0x02C)
+#define SM501_DC_PANEL_V_SYNC		(0x030)
+#define SM501_DC_PANEL_CUR_LINE		(0x034)
+
+#define SM501_DC_VIDEO_CONTROL		(0x040)
+#define SM501_DC_VIDEO_FB0_ADDR		(0x044)
+#define SM501_DC_VIDEO_FB_WIDTH		(0x048)
+#define SM501_DC_VIDEO_FB0_LAST_ADDR	(0x04C)
+#define SM501_DC_VIDEO_TL_LOC		(0x050)
+#define SM501_DC_VIDEO_BR_LOC		(0x054)
+#define SM501_DC_VIDEO_SCALE		(0x058)
+#define SM501_DC_VIDEO_INIT_SCALE	(0x05C)
+#define SM501_DC_VIDEO_YUV_CONSTANTS	(0x060)
+#define SM501_DC_VIDEO_FB1_ADDR		(0x064)
+#define SM501_DC_VIDEO_FB1_LAST_ADDR	(0x068)
+
+#define SM501_DC_VIDEO_ALPHA_CONTROL	(0x080)
+#define SM501_DC_VIDEO_ALPHA_FB_ADDR	(0x084)
+#define SM501_DC_VIDEO_ALPHA_FB_OFFSET	(0x088)
+#define SM501_DC_VIDEO_ALPHA_FB_LAST_ADDR	(0x08C)
+#define SM501_DC_VIDEO_ALPHA_TL_LOC	(0x090)
+#define SM501_DC_VIDEO_ALPHA_BR_LOC	(0x094)
+#define SM501_DC_VIDEO_ALPHA_SCALE	(0x098)
+#define SM501_DC_VIDEO_ALPHA_INIT_SCALE	(0x09C)
+#define SM501_DC_VIDEO_ALPHA_CHROMA_KEY	(0x0A0)
+#define SM501_DC_VIDEO_ALPHA_COLOR_LOOKUP	(0x0A4)
+
+
+#define SM501_DC_PANEL_HWC_ADDR		(0x0F0)
+#define SM501_DC_PANEL_HWC_LOC		(0x0F4)
+#define SM501_DC_PANEL_HWC_COLOR_1_2	(0x0F8)
+#define SM501_DC_PANEL_HWC_COLOR_3	(0x0FC)
+
+#define SM501_OFF_HWC_ADDR		(0x00)
+#define SM501_OFF_HWC_LOC		(0x04)
+#define SM501_OFF_HWC_COLOR_1_2		(0x08)
+#define SM501_OFF_HWC_COLOR_3		(0x0C)
+
+#define SM501_DC_ALPHA_CONTROL		(0x100)
+#define SM501_DC_ALPHA_FB_ADDR		(0x104)
+#define SM501_DC_ALPHA_FB_OFFSET	(0x108)
+#define SM501_DC_ALPHA_TL_LOC		(0x10C)
+#define SM501_DC_ALPHA_BR_LOC		(0x110)
+#define SM501_DC_ALPHA_CHROMA_KEY	(0x114)
+#define SM501_DC_ALPHA_COLOR_LOOKUP	(0x118)
+
+#define SM501_DC_CRT_CONTROL		(0x200)
+#define SM501_DC_CRT_FB_ADDR		(0x204)
+#define SM501_DC_CRT_FB_OFFSET		(0x208)
+#define SM501_DC_CRT_H_TOT		(0x20C)
+#define SM501_DC_CRT_H_SYNC		(0x210)
+#define SM501_DC_CRT_V_TOT		(0x214)
+#define SM501_DC_CRT_V_SYNC		(0x218)
+#define SM501_DC_CRT_SIGNATURE_ANALYZER	(0x21C)
+#define SM501_DC_CRT_CUR_LINE		(0x220)
+#define SM501_DC_CRT_MONITOR_DETECT	(0x224)
+
+#define SM501_DC_CRT_HWC_ADDR		(0x230)
+#define SM501_DC_CRT_HWC_LOC		(0x234)
+#define SM501_DC_CRT_HWC_COLOR_1_2	(0x238)
+#define SM501_DC_CRT_HWC_COLOR_3	(0x23C)
+
+#define SM501_DC_PANEL_PALETTE		(0x400)
+
+#define SM501_DC_VIDEO_PALETTE		(0x800)
+
+#define SM501_DC_CRT_PALETTE		(0xC00)
+
+/* Zoom Video port base */
+#define SM501_ZVPORT			(0x090000)
+
+/* AC97/I2S base */
+#define SM501_AC97			(0x0A0000)
+
+/* 8051 micro controller base */
+#define SM501_UCONTROLLER		(0x0B0000)
+
+/* 8051 micro controller SRAM base */
+#define SM501_UCONTROLLER_SRAM		(0x0C0000)
+
+/* DMA base */
+#define SM501_DMA			(0x0D0000)
+
+/* 2d engine base */
+#define SM501_2D_ENGINE			(0x100000)
+#define SM501_2D_SOURCE			(0x00)
+#define SM501_2D_DESTINATION		(0x04)
+#define SM501_2D_DIMENSION		(0x08)
+#define SM501_2D_CONTROL		(0x0C)
+#define SM501_2D_PITCH			(0x10)
+#define SM501_2D_FOREGROUND		(0x14)
+#define SM501_2D_BACKGROUND		(0x18)
+#define SM501_2D_STRETCH		(0x1C)
+#define SM501_2D_COLOR_COMPARE		(0x20)
+#define SM501_2D_COLOR_COMPARE_MASK 	(0x24)
+#define SM501_2D_MASK			(0x28)
+#define SM501_2D_CLIP_TL		(0x2C)
+#define SM501_2D_CLIP_BR		(0x30)
+#define SM501_2D_MONO_PATTERN_LOW	(0x34)
+#define SM501_2D_MONO_PATTERN_HIGH	(0x38)
+#define SM501_2D_WINDOW_WIDTH		(0x3C)
+#define SM501_2D_SOURCE_BASE		(0x40)
+#define SM501_2D_DESTINATION_BASE	(0x44)
+#define SM501_2D_ALPHA			(0x48)
+#define SM501_2D_WRAP			(0x4C)
+#define SM501_2D_STATUS			(0x50)
+
+#define SM501_CSC_Y_SOURCE_BASE		(0xC8)
+#define SM501_CSC_CONSTANTS		(0xCC)
+#define SM501_CSC_Y_SOURCE_X		(0xD0)
+#define SM501_CSC_Y_SOURCE_Y		(0xD4)
+#define SM501_CSC_U_SOURCE_BASE		(0xD8)
+#define SM501_CSC_V_SOURCE_BASE		(0xDC)
+#define SM501_CSC_SOURCE_DIMENSION	(0xE0)
+#define SM501_CSC_SOURCE_PITCH		(0xE4)
+#define SM501_CSC_DESTINATION		(0xE8)
+#define SM501_CSC_DESTINATION_DIMENSION	(0xEC)
+#define SM501_CSC_DESTINATION_PITCH	(0xF0)
+#define SM501_CSC_SCALE_FACTOR		(0xF4)
+#define SM501_CSC_DESTINATION_BASE	(0xF8)
+#define SM501_CSC_CONTROL		(0xFC)
+
+/* 2d engine data port base */
+#define SM501_2D_ENGINE_DATA		(0x110000)
diff -urpN -X ../dontdiff linux-2.6.19/include/linux/sm501.h linux-2.6.19-simtec1p9/include/linux/sm501.h
--- linux-2.6.19/include/linux/sm501.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19-simtec1p9/include/linux/sm501.h	2006-12-13 01:54:26.000000000 +0000
@@ -0,0 +1,152 @@
+/* include/linux/sm501.h
+ *
+ * Copyright (c) 2006 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	Vincent Sanders <vince@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+extern int sm501_unit_power(struct device *dev,
+			    unsigned int unit, unsigned int to);
+
+extern unsigned long sm501_set_clock(struct device *dev,
+				     int clksrc, unsigned long freq);
+
+extern unsigned long sm501_find_clock(int clksrc, unsigned long req_freq);
+
+/* sm501_misc_control
+ *
+ * Modify the SM501's MISC_CONTROL register
+*/
+
+extern int sm501_misc_control(struct device *dev,
+			      unsigned long set, unsigned long clear);
+
+/* sm501_modify_reg
+ *
+ * Modify a register in the SM501 which may be shared with other
+ * drivers.
+*/
+
+extern unsigned long sm501_modify_reg(struct device *dev,
+				      unsigned long reg,
+				      unsigned long set,
+				      unsigned long clear);
+
+/* sm501_gpio_set
+ *
+ * set the state of the given GPIO line
+*/
+
+extern void sm501_gpio_set(struct device *dev,
+			   unsigned long gpio,
+			   unsigned int to,
+			   unsigned int dir);
+
+/* sm501_gpio_get
+ *
+ * get the state of the given GPIO line
+*/
+
+extern unsigned long sm501_gpio_get(struct device *dev,
+				    unsigned long gpio);
+
+
+/* Platform data definitions */
+
+struct sm501_platdata_fbsub {
+	struct fb_mode		*def_mode;
+	unsigned long		 max_mem;
+};
+
+/* sm501_platdata_fb
+ *
+ * configuration data for the framebuffer driver
+*/
+
+struct sm501_platdata_fb {
+	struct sm501_platdata_fbsub	*fb_crt;
+	struct sm501_platdata_fbsub	*fb_pnl;
+};
+
+/* gpio i2c */
+
+struct sm501_platdata_gpio_i2c {
+	unsigned int		pin_sda;
+	unsigned int		pin_scl;
+};
+
+/* sm501_initdata
+ *
+ * use for initialising values that may not have been setup
+ * before the driver is loaded.
+*/
+
+struct sm501_reg_init {
+	unsigned long		set;
+	unsigned long		mask;
+};
+
+#define SM501_USE_USB_HOST	(1<<0)
+#define SM501_USE_USB_SLAVE	(1<<1)
+#define SM501_USE_SSP0		(1<<2)
+#define SM501_USE_SSP1		(1<<3)
+#define SM501_USE_UART0		(1<<4)
+#define SM501_USE_UART1		(1<<5)
+#define SM501_USE_FBACCEL	(1<<6)
+#define SM501_USE_AC97		(1<<7)
+#define SM501_USE_I2S		(1<<8)
+
+#define SM501_USE_ALL		(0xffffffff)
+
+struct sm501_initdata {
+	struct sm501_reg_init	gpio_low;
+	struct sm501_reg_init	gpio_high;
+	struct sm501_reg_init	misc_timing;
+	struct sm501_reg_init	misc_control;
+
+	unsigned long		devices;
+	unsigned long		mclk;		/* non-zero to modify */
+	unsigned long		m1xclk;		/* non-zero to modify */
+};
+
+/* sm501_init_gpio
+ *
+ * default gpio settings
+*/
+
+struct sm501_init_gpio {
+	struct sm501_reg_init	gpio_data_low;
+	struct sm501_reg_init	gpio_data_high;
+	struct sm501_reg_init	gpio_ddr_low;
+	struct sm501_reg_init	gpio_ddr_high;
+};
+
+/* sm501_platdata
+ *
+ * This is passed with the platform device to allow the board
+ * to control the behaviour of the SM501 driver(s) which attach
+ * to the device.
+ *
+*/
+
+struct sm501_platdata {
+	struct sm501_initdata		*init;
+	struct sm501_init_gpio		*init_gpiop;
+	struct sm501_platdata_fb	*fb;
+
+	struct sm501_platdata_gpio_i2c	*gpio_i2c;
+	unsigned int			 gpio_i2c_nr;
+};

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sm501-mfd.patch"

diff -urpN -X ../dontdiff linux-2.6.19/Documentation/SM501.txt linux-2.6.19-simtec1p9/Documentation/SM501.txt
--- linux-2.6.19/Documentation/SM501.txt	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19-simtec1p9/Documentation/SM501.txt	2006-12-13 11:44:04.000000000 +0000
@@ -0,0 +1,58 @@
+			SM501 Driver
+			============
+
+Copyright 2006 Simtec Electronics
+
+Core
+----
+
+The core driver in drivers/mfd provides common services for the
+drivers which manage the specific hardware blocks. These services
+include locking for common registers, clock control and resource
+management.
+
+The core registers drivers for both PCI and generic bus based
+chips via the platform device and driver system.
+
+On detection of a device, the core initialises the chip (which may
+be specified by the platfrom data) and then exports the selected
+peripheral set as platform devices for the specific drivers.
+
+The core re-uses the platform device system as the platform device
+system provides enough features to support the drivers without the
+need to create a new bus-type and the associated code to go with it.
+
+
+Resources
+---------
+
+Each peripheral's view of the device is implicitly narrowed to the
+specific set of resources it requires in order to function correctly.
+
+The centralised memory allocation allows the driver to ensure that the
+maximum possible resource allocation can be made to the video subsystem
+as this is by-far the most resource-sensitive of the on-chip functions.
+
+The primary issue with memory allocation is that of moving the video
+buffers once a display mode is chosen. Indeed when a video mode change
+occurs the memory footprint of the video subsystem changes.
+
+Since Video memory is difficult to move without changing the display
+(unless sufficient contiguous memory can be provided for the old and new
+modes simultaneously) the video driver fully utilises the memory area
+given to it by aligning fb0 to the start of the area and fb1 to the end
+of it. Any memory left over in the middle is used for the acceleration
+functions, which are transient and thus their location is less critical
+as it can be moved.
+
+
+Configuration
+-------------
+
+The platform device driver uses a set of platform data to pass
+configurations through to the core and the subsidiary drivers
+so that there can be sujpport for more than one system carrying
+an SM501 built into a single kernel image.
+
+Currently the PCI driver assumes the manufacturer's reference
+design.
diff -urpN -X ../dontdiff linux-2.6.19/drivers/mfd/Kconfig linux-2.6.19-simtec1p9/drivers/mfd/Kconfig
--- linux-2.6.19/drivers/mfd/Kconfig	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19-simtec1p9/drivers/mfd/Kconfig	2006-12-06 00:12:24.000000000 +0000
@@ -2,6 +2,20 @@
 # Multifunction miscellaneous devices
 #
 
+menu "Multifunction device drivers"
+
+config MFD_SM501
+	tristate "Support for Silicon Motion SM501"
+	 ---help---
+	  This is the core driver for the Silicon motion SM501 multimedia 
+	  companion chip. This device is a multifunction device which may 
+	  provide numerous interfaces including USB host controller USB gadget,
+	  Asyncronous Serial ports, Audio functions and a dual display video 
+	  interface. The device may be connected by PCI or local bus with 
+	  varying functions enabled.
+
+endmenu
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff -urpN -X ../dontdiff linux-2.6.19/drivers/mfd/Makefile linux-2.6.19-simtec1p9/drivers/mfd/Makefile
--- linux-2.6.19/drivers/mfd/Makefile	2006-11-29 21:57:37.000000000 +0000
+++ linux-2.6.19-simtec1p9/drivers/mfd/Makefile	2006-12-06 00:12:24.000000000 +0000
@@ -2,6 +2,8 @@
 # Makefile for multifunction miscellaneous devices
 #
 
+obj-$(CONFIG_MFD_SM501)		+= sm501.o
+
 obj-$(CONFIG_MCP)		+= mcp-core.o
 obj-$(CONFIG_MCP_SA11X0)	+= mcp-sa11x0.o
 obj-$(CONFIG_MCP_UCB1200)	+= ucb1x00-core.o
diff -urpN -X ../dontdiff linux-2.6.19/drivers/mfd/sm501.c linux-2.6.19-simtec1p9/drivers/mfd/sm501.c
--- linux-2.6.19/drivers/mfd/sm501.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19-simtec1p9/drivers/mfd/sm501.c	2006-12-13 02:01:33.000000000 +0000
@@ -0,0 +1,1061 @@
+/* linux/drivers/mfd/sm501.c
+ *
+ * Copyright (C) 2006 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	Vincent Sanders <vince@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * SM501 MFD driver
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
+#include <linux/serial_8250.h>
+
+#include <linux/sm501.h>
+#include <linux/sm501-regs.h>
+
+#include <asm/sizes.h>
+#include <asm/io.h>
+
+/* we need to work out why we cannot reserve these PCI regions */
+#define do_request_regions	(0)
+
+struct sm501_device {
+	struct list_head		list;
+	struct platform_device		pdev;
+};
+
+struct sm501_devdata {
+	spinlock_t			 reg_lock;
+	struct semaphore		 clock_lock;
+	struct list_head		 devices;
+
+	struct device			*dev;
+	struct resource			*io_res;
+	struct resource			*mem_res;
+	struct sm501_platdata		*platdata;
+	
+	int				 unit_power[20];
+	unsigned int			 pdev_id;
+	unsigned int			 irq;
+	void __iomem			*regs;
+};
+
+#ifdef CONFIG_DEBUG
+static unsigned int misc_div[] = {
+	[0]		= 1,
+	[1]		= 2,
+	[2]		= 4,
+	[3]		= 8,
+	[4]		= 16,
+	[5]		= 32,
+	[6]		= 64,
+	[7]		= 128,
+	[8]		= 3,
+	[9]		= 6,
+	[10]		= 12,
+	[11]		= 24,
+	[12]		= 48,
+	[13]		= 96,
+	[14]		= 192,
+	[15]		= 384,
+};
+
+static unsigned int px_div[] = {
+	[0]		= 1,
+	[1]		= 2,
+	[2]		= 4,
+	[3]		= 8,
+	[4]		= 16,
+	[5]		= 32,
+	[6]		= 64,
+	[7]		= 128,
+	[8]		= 3,
+	[9]		= 6,
+	[10]	        = 12,
+	[11]		= 24,
+	[12]		= 48,
+	[13]		= 96,
+	[14]		= 192,
+	[15]		= 384,
+	[16]		= 5,
+	[17]		= 10,
+	[18]		= 20,
+	[19]		= 40,
+	[20]		= 80,
+	[21]		= 160,
+	[22]		= 320,
+	[23]		= 604,
+};
+#endif
+
+#define decode_div(val, lshft, selbit, mask, dtab) \
+	((((val) & (selbit)) ? pll2 : 288 * MHZ) / dtab[(((val) >> (lshft)) & (mask))])
+
+#define MHZ (1000 * 1000)
+
+#define fmt_freq(x) ((x) / MHZ), ((x) % MHZ), (x)
+
+#ifdef CONFIG_DEBUG
+
+/* sm501_dump_clk
+ *
+ * Print out the current clock configuration for the device 
+*/
+
+static void sm501_dump_clk(struct sm501_devdata *sm)
+{
+	unsigned long misct = readl(sm->regs + SM501_MISC_TIMING);
+	unsigned long pm0 = readl(sm->regs + SM501_POWER_MODE_0_CLOCK);
+	unsigned long pm1 = readl(sm->regs + SM501_POWER_MODE_1_CLOCK);
+	unsigned long pmc = readl(sm->regs + SM501_POWER_MODE_CONTROL);
+	unsigned long sdclk0, sdclk1;
+	unsigned long pll2 = 0;
+
+	switch (misct & 0x30) {
+	case 0x00:
+		pll2 = 336 * MHZ;
+		break;
+	case 0x10:
+		pll2 = 288 * MHZ;
+		break;
+	case 0x20:
+		pll2 = 240 * MHZ;
+		break;
+	case 0x30:
+		pll2 = 192 * MHZ;
+		break;
+	}
+
+	sdclk0 = (misct & (1<<12)) ? pll2 : 288 * MHZ;
+	sdclk0 /= misc_div[((misct >> 8) & 0xf)];
+
+	sdclk1 = (misct & (1<<20)) ? pll2 : 288 * MHZ;
+	sdclk1 /= misc_div[((misct >> 16) & 0xf)];
+
+	dev_dbg(sm->dev, "MISCT=%08lx, PM0=%08lx, PM1=%08lx\n",
+		misct, pm0, pm1);
+	
+	dev_dbg(sm->dev, "PLL2 = %ld.%ld MHz (%ld), SDCLK0=%08lx, SDCLK1=%08lx\n",
+		fmt_freq(pll2), sdclk0, sdclk1);
+
+	dev_dbg(sm->dev, "SDRAM: PM0=%ld, PM1=%ld\n", sdclk0, sdclk1);
+
+	dev_dbg(sm->dev, "PM0[%c]: "
+		 "P2 %ld.%ld MHz (%ld), V2 %ld.%ld (%ld), "
+		 "M %ld.%ld (%ld), MX1 %ld.%ld (%ld)\n",
+		 (pmc & 3 ) == 0 ? '*' : '-',
+		 fmt_freq(decode_div(pm0, 24, 1<<29, 31, px_div)),
+		 fmt_freq(decode_div(pm0, 16, 1<<20, 15, misc_div)),
+		 fmt_freq(decode_div(pm0, 8,  1<<12, 15, misc_div)),
+		 fmt_freq(decode_div(pm0, 0,  1<<4,  15, misc_div)));
+
+	dev_dbg(sm->dev, "PM1[%c]: "
+		"P2 %ld.%ld MHz (%ld), V2 %ld.%ld (%ld), "
+		"M %ld.%ld (%ld), MX1 %ld.%ld (%ld)\n",
+		(pmc & 3 ) == 1 ? '*' : '-',
+		fmt_freq(decode_div(pm1, 24, 1<<29, 31, px_div)),
+		fmt_freq(decode_div(pm1, 16, 1<<20, 15, misc_div)),
+		fmt_freq(decode_div(pm1, 8,  1<<12, 15, misc_div)),
+		fmt_freq(decode_div(pm1, 0,  1<<4,  15, misc_div)));
+}
+#else
+static void sm501_dump_clk(struct sm501_devdata *sm)
+{
+}
+#endif
+
+/* sm501_misc_control
+ *
+ * alters the misceleneous control parameters
+*/
+
+int sm501_misc_control(struct device *dev,
+		       unsigned long set, unsigned long clear)
+{
+	struct sm501_devdata *sm = dev_get_drvdata(dev);
+	unsigned long misc = readl(sm->regs + SM501_MISC_CONTROL);
+	unsigned long to;
+	
+	to = (misc & ~clear) | set;
+
+	if (to != misc) {	
+		writel(to, sm->regs + SM501_MISC_CONTROL);
+		dev_dbg(sm->dev, "MISC_CONTROL %08lx\n", misc);
+	}
+
+	return to;
+}
+
+EXPORT_SYMBOL_GPL(sm501_misc_control);
+
+/* sm501_modify_reg
+ *
+ * Modify a register in the SM501 which may be shared with other
+ * drivers.
+*/
+
+unsigned long sm501_modify_reg(struct device *dev,
+			       unsigned long reg,
+			       unsigned long set,
+			       unsigned long clear)
+{
+	struct sm501_devdata *sm = dev_get_drvdata(dev);
+	unsigned long data;
+	unsigned long save;
+
+	spin_lock_irqsave(&sm->reg_lock, save);
+
+	data = readl(sm->regs + reg);
+	data |= set;
+	data &= ~clear;
+	writel(data, sm->regs + reg);
+       
+	spin_unlock_irqrestore(&sm->reg_lock, save);
+
+	return data;
+}
+
+EXPORT_SYMBOL_GPL(sm501_modify_reg);
+
+unsigned long sm501_gpio_get(struct device *dev,
+			     unsigned long gpio)
+{
+	struct sm501_devdata *sm = dev_get_drvdata(dev);
+	unsigned long result;
+	unsigned long reg;
+
+	reg = (gpio > 32) ? SM501_GPIO_DATA_HIGH : SM501_GPIO_DATA_LOW;
+	result = readl(sm->regs + reg);
+
+	result >>= (gpio & 31);
+	return result & 1UL;
+}
+
+EXPORT_SYMBOL_GPL(sm501_gpio_get);
+
+void sm501_gpio_set(struct device *dev,
+		    unsigned long gpio,
+		    unsigned int to,
+		    unsigned int dir)
+{
+	struct sm501_devdata *sm = dev_get_drvdata(dev);
+
+	unsigned long bit = 1 << (gpio & 31);
+	unsigned long base;
+	unsigned long save;
+	unsigned long val;
+
+	base = (gpio > 32) ? SM501_GPIO_DATA_HIGH : SM501_GPIO_DATA_LOW;
+	base += SM501_GPIO;
+
+	spin_lock_irqsave(&sm->reg_lock, save);
+
+	val = readl(sm->regs + base);
+	if (to)
+		val |= bit;
+	else
+		val &= ~bit;
+	writel(val, sm->regs + base);
+
+	val = readl(sm->regs + SM501_GPIO_DDR_LOW);
+	if (dir)
+		val |= bit;
+	else
+		val &= ~bit;
+	writel(val, sm->regs + SM501_GPIO_DDR_LOW);
+
+	spin_unlock_irqrestore(&sm->reg_lock, save);
+
+}
+
+EXPORT_SYMBOL_GPL(sm501_gpio_set);
+
+
+/* sm501_unit_power
+ *
+ * alters the power active gate to set specific units on or off
+ */
+
+int sm501_unit_power(struct device *dev, unsigned int unit, unsigned int to)
+{
+	struct sm501_devdata *sm = dev_get_drvdata(dev);
+	unsigned long mode = readl(sm->regs + SM501_POWER_MODE_CONTROL);
+	unsigned long gate = readl(sm->regs + SM501_CURRENT_GATE);
+	unsigned long clock = readl(sm->regs + SM501_CURRENT_CLOCK);
+
+	mode &= 3;		/* get current power mode */
+
+	down(&sm->clock_lock);
+
+	if (unit > ARRAY_SIZE(sm->unit_power)) {
+		dev_err(dev, "bad unit %d passed to %s\n", unit, __FUNCTION__);
+		goto already;
+	}
+
+	if (to == 0 && sm->unit_power[unit] == 0) {
+		dev_err(sm->dev, "unit %d is already shutdown\n", unit);
+		goto already;
+	}
+
+	sm->unit_power[unit] += to ? 1 : -1;
+	to = sm->unit_power[unit] ? 1 : 0;
+
+	if (to) {
+		if (gate & (1 << unit))
+			goto already;
+		gate |= (1 << unit);
+	} else {
+		if (!(gate & (1 << unit)))
+			goto already;
+		gate &= ~(1 << unit);
+	}
+
+	switch (mode) {
+	case 1:
+		writel(gate, sm->regs + SM501_POWER_MODE_0_GATE);
+		writel(clock, sm->regs + SM501_POWER_MODE_0_CLOCK);
+		mode = 0;
+		break;
+	case 2:
+	case 0:
+		writel(gate, sm->regs + SM501_POWER_MODE_1_GATE);
+		writel(clock, sm->regs + SM501_POWER_MODE_1_CLOCK);
+		mode = 1;
+		break;
+
+	default:
+		return -1;
+	}
+
+	writel(mode, sm->regs + SM501_POWER_MODE_CONTROL);
+
+	dev_dbg(sm->dev, "gate %08lx, clock %08lx, mode %08lx\n",
+		gate, clock, mode);
+
+	msleep(16);
+
+ already:
+	up(&sm->clock_lock);
+	return gate;
+}
+
+EXPORT_SYMBOL_GPL(sm501_unit_power);
+
+
+/* Perform a rounded division. */
+static long sm501fb_round_div(long num, long denom)
+{
+        /* n / d + 1 / 2 = (2n + d) / 2d */
+        return (2 * num + denom) / (2 * denom);
+}
+
+/* clock value structure. */
+struct sm501_clock {
+	unsigned long mclk;
+	int divider;
+	int shift;
+};
+
+/* sm501_select_clock
+ *
+ * selects nearest discrete clock frequency the SM501 can achive
+ *   the maximum divisor is 3 or 5
+ */
+static unsigned long sm501_select_clock(unsigned long freq,
+					struct sm501_clock *clock,
+					int max_div)
+{
+	unsigned long mclk;
+	int divider;
+	int shift;
+	long diff;
+	long best_diff = 999999999;
+
+	/* Try 288MHz and 336MHz clocks. */
+	for (mclk = 288000000; mclk <= 336000000; mclk += 48000000) {
+		/* try dividers 1 and 3 for CRT and for panel,
+		   try divider 5 for panel only.*/
+
+		for (divider = 1; divider <= max_div; divider += 2) {
+			/* try all 8 shift values.*/
+			for (shift = 0; shift < 8; shift++) {
+				/* Calculate difference to requested clock */
+				diff = sm501fb_round_div(mclk, divider << shift) - freq;
+				if (diff < 0)
+					diff = -diff;
+
+				/* If it is less than the current, use it */
+				if (diff < best_diff) {
+					best_diff = diff;
+
+					clock->mclk = mclk;
+					clock->divider = divider;
+					clock->shift = shift;
+				}
+			}
+		}
+	}
+
+	/* Return best clock. */
+	return clock->mclk / (clock->divider << clock->shift);
+}
+
+/* sm501_set_clock
+ *
+ * set one of the four clock sources to the closest available frequency to
+ *  the one specified
+ */
+unsigned long sm501_set_clock(struct device *dev,
+			      int clksrc,
+			      unsigned long req_freq)
+{
+	struct sm501_devdata *sm = dev_get_drvdata(dev);
+	unsigned long mode = readl(sm->regs + SM501_POWER_MODE_CONTROL);
+	unsigned long gate = readl(sm->regs + SM501_CURRENT_GATE);
+	unsigned long clock = readl(sm->regs + SM501_CURRENT_CLOCK);
+	unsigned char reg;
+	unsigned long sm501_freq; /* the actual frequency acheived */
+
+	struct sm501_clock to;
+
+	/* find achivable discrete frequency and setup register value
+	 * accordingly, V2XCLK, MCLK and M1XCLK are the same P2XCLK
+	 * has an extra bit for the divider */
+
+	switch (clksrc) {
+	case SM501_CLOCK_P2XCLK:
+		/* This clock is divided in half so to achive the
+		 * requested frequency the value must be multiplied by
+		 * 2. This clock also has an additional pre divisor */
+
+		sm501_freq = (sm501_select_clock(2 * req_freq, &to, 5) / 2);
+		reg=to.shift & 0x07;/* bottom 3 bits are shift */
+		if (to.divider == 3)
+			reg |= 0x08; /* /3 divider required */
+		else if (to.divider == 5)
+			reg |= 0x10; /* /5 divider required */
+		if (to.mclk != 288000000)
+			reg |= 0x20; /* which mclk pll is source */
+		break;
+
+	case SM501_CLOCK_V2XCLK:
+		/* This clock is divided in half so to achive the
+		 * requested frequency the value must be multiplied by 2. */
+
+		sm501_freq = (sm501_select_clock(2 * req_freq, &to, 3) / 2);
+		reg=to.shift & 0x07;	/* bottom 3 bits are shift */
+		if (to.divider == 3)
+			reg |= 0x08;	/* /3 divider required */
+		if (to.mclk != 288000000)
+			reg |= 0x10;	/* which mclk pll is source */
+		break;
+
+	case SM501_CLOCK_MCLK:
+	case SM501_CLOCK_M1XCLK:
+		/* These clocks are the same and not further divided */
+
+		sm501_freq = sm501_select_clock( req_freq, &to, 3);
+		reg=to.shift & 0x07;	/* bottom 3 bits are shift */
+		if (to.divider == 3)
+			reg |= 0x08;	/* /3 divider required */
+		if (to.mclk != 288000000)
+			reg |= 0x10;	/* which mclk pll is source */
+		break;
+
+	default:
+		return 0; /* this is bad */
+	}
+
+	clock = clock & ~(0xFF << clksrc);
+	clock |= reg<<clksrc;
+
+	mode &= 3;	/* find current mode */
+
+	switch (mode) {
+	case 1:
+		writel(gate, sm->regs + SM501_POWER_MODE_0_GATE);
+		writel(clock, sm->regs + SM501_POWER_MODE_0_CLOCK);
+		mode = 0;
+		break;
+	case 2:
+	case 0:
+		writel(gate, sm->regs + SM501_POWER_MODE_1_GATE);
+		writel(clock, sm->regs + SM501_POWER_MODE_1_CLOCK);
+		mode = 1;
+		break;
+
+	default:
+		return -1;
+	}
+
+	writel(mode, sm->regs + SM501_POWER_MODE_CONTROL);
+
+	dev_info(sm->dev, "gate %08lx, clock %08lx, mode %08lx\n",
+		 gate, clock, mode);
+
+	msleep(16);
+	sm501_dump_clk(sm);
+
+	return sm501_freq;
+}
+
+EXPORT_SYMBOL_GPL(sm501_set_clock);
+
+/* sm501_find_clock
+ *
+ * finds the closest available frequency for a given clock
+*/
+
+unsigned long sm501_find_clock(int clksrc,
+			       unsigned long req_freq)
+{
+	unsigned long sm501_freq; /* the frequency achiveable by the 501 */
+	struct sm501_clock to;
+
+	switch (clksrc) {
+	case SM501_CLOCK_P2XCLK:
+		sm501_freq = (sm501_select_clock(2 * req_freq, &to, 5) / 2);
+		break;
+
+	case SM501_CLOCK_V2XCLK:
+		sm501_freq = (sm501_select_clock(2 * req_freq, &to, 3) / 2);
+		break;
+
+	case SM501_CLOCK_MCLK:
+	case SM501_CLOCK_M1XCLK:
+		sm501_freq = sm501_select_clock(req_freq, &to, 3);
+		break;
+
+	default:
+		sm501_freq = 0;		/* error */
+	}
+
+	return sm501_freq;
+}
+
+EXPORT_SYMBOL_GPL(sm501_find_clock);
+
+/* sm501_null_release
+ *
+ * A release function for the platform devices we create to keep the
+ * driver core happy, and stop any crashed when the devices are removed
+*/
+
+static void sm501_null_release(struct device *dev)
+{
+}
+
+/* sm501_create_subdev
+ *
+ * Create a skeleton platform device with resources for passing to a
+ * sub-driver
+*/
+
+static struct platform_device *
+sm501_create_subdev(struct sm501_devdata *sm,
+		    char *name, unsigned int res_count)
+{
+	struct sm501_device *smdev;
+
+	smdev = kzalloc(sizeof(struct sm501_device) +
+			sizeof(struct resource) * res_count, GFP_KERNEL);
+	if (!smdev)
+		return NULL;
+
+	smdev->pdev.dev.release = sm501_null_release;
+
+	smdev->pdev.name = name;
+	smdev->pdev.id = sm->pdev_id;
+	smdev->pdev.resource = (struct resource *)(smdev+1);
+	smdev->pdev.num_resources = res_count;
+
+	smdev->pdev.dev.parent = sm->dev;
+
+	return &smdev->pdev;
+}
+
+static struct sm501_device *to_sm_device(struct platform_device *pdev)
+{
+	return container_of(pdev, struct sm501_device, pdev);
+}
+
+/* sm501_register_device
+ *
+ * Register a platform device created with sm501_create_subdev()
+*/
+
+static int sm501_register_device(struct sm501_devdata *sm,
+				 struct platform_device *pdev)
+{
+	struct sm501_device *smdev = to_sm_device(pdev);
+	int ptr;
+	int ret;
+
+	for (ptr = 0; ptr < pdev->num_resources; ptr++) {
+		printk("%s[%d] flags %08lx: %08zx..%08zx\n",
+		       pdev->name, ptr,
+		       pdev->resource[ptr].flags,
+		       pdev->resource[ptr].start,
+		       pdev->resource[ptr].end);
+	}
+	
+	ret = platform_device_register(pdev);
+
+	if (ret > 0)
+		list_add_tail(&smdev->list, &sm->devices);
+	else
+		dev_err(sm->dev, "error registering %s (%d)\n",
+			pdev->name, ret);
+
+	return ret;
+}
+
+/* sm501_create_subio
+ *
+ * Fill in an IO resource for a sub device
+*/
+
+static void sm501_create_subio(struct sm501_devdata *sm,
+			       struct resource *res,
+			       unsigned long offs,
+			       unsigned long size)
+{
+	res->flags = IORESOURCE_MEM;
+	res->parent = sm->io_res;
+	res->start = sm->io_res->start + offs;
+	res->end = res->start + size - 1;
+}
+
+/* sm501_create_mem
+ *
+ * Fill in an MEM resource for a sub device
+*/
+
+static void sm501_create_mem(struct sm501_devdata *sm,
+			     struct resource *res,
+			     unsigned long *offs,
+			     unsigned long size)
+{
+	*offs -= size;		/* adjust memory size */
+
+	res->flags = IORESOURCE_MEM;
+	res->parent = sm->mem_res;
+	res->start = sm->mem_res->start + *offs;
+	res->end = res->start + size - 1;
+}
+
+/* sm501_create_irq
+ *
+ * Fill in an IRQ resource for a sub device
+*/
+
+static void sm501_create_irq(struct sm501_devdata *sm,
+			     struct resource *res)
+{
+	res->flags = IORESOURCE_IRQ;
+	res->parent = NULL;
+	res->start = res->end = sm->irq;
+}
+
+static int sm501_register_usbhost(struct sm501_devdata *sm,
+				  unsigned long *mem_avail)
+{
+	struct platform_device *pdev;
+
+	pdev = sm501_create_subdev(sm, "sm501-usb", 3);
+	if (!pdev)
+		return -ENOMEM;
+
+	sm501_create_subio(sm, &pdev->resource[0], 0x40000, 0x20000);
+	sm501_create_mem(sm, &pdev->resource[1], mem_avail, SZ_256K);
+	sm501_create_irq(sm, &pdev->resource[2]);
+
+	return sm501_register_device(sm, pdev);
+}
+
+static int sm501_register_display(struct sm501_devdata *sm,
+				  unsigned long *mem_avail)
+{
+	struct platform_device *pdev;
+
+	pdev = sm501_create_subdev(sm, "sm501-fb", 4);
+	if (!pdev)
+		return -ENOMEM;
+
+	sm501_create_subio(sm, &pdev->resource[0], 0x80000, 0x10000);
+	sm501_create_subio(sm, &pdev->resource[1], 0x100000, 0x50000);
+	sm501_create_mem(sm, &pdev->resource[2], mem_avail, *mem_avail);
+	sm501_create_irq(sm, &pdev->resource[3]);
+
+	return sm501_register_device(sm, pdev);
+}
+
+/* sm501_dbg_regs
+ *
+ * Debug attribute to attach to parent device to show core registers
+*/
+
+static ssize_t sm501_dbg_regs(struct device *dev,
+			      struct device_attribute *attr, char *buff)
+{
+	struct sm501_devdata *sm = dev_get_drvdata(dev)	;
+	unsigned int reg;
+	char *ptr = buff;
+	int ret;
+
+	for (reg = 0x00; reg < 0x70; reg += 4) {
+		ret = sprintf(ptr, "%08x = %08x\n",
+			      reg, readl(sm->regs + reg));
+		ptr += ret;
+	}
+
+	return ptr - buff;
+}
+
+
+static DEVICE_ATTR(dbg_regs, 0666, sm501_dbg_regs, NULL);
+
+/* sm501_init_reg
+ * 
+ * Helper function for the init code to setup a register 
+*/
+
+static inline void sm501_init_reg(struct sm501_devdata *sm,
+				  unsigned long reg,
+				  struct sm501_reg_init *r)
+{
+	unsigned long tmp;
+
+	tmp = readl(sm->regs + reg);
+	tmp |= r->set;
+	tmp &= ~r->mask;
+	writel(tmp, sm->regs + reg);
+}
+
+/* sm501_init_regs
+ *
+ * Setup core register values 
+*/
+
+static void sm501_init_regs(struct sm501_devdata *sm,
+			    struct sm501_initdata *init)
+{
+	sm501_misc_control(sm->dev, 
+			   init->misc_control.set,
+			   init->misc_control.mask);
+
+	sm501_init_reg(sm, SM501_MISC_TIMING, &init->misc_timing);
+	sm501_init_reg(sm, SM501_GPIO31_0_CONTROL, &init->gpio_low);
+	sm501_init_reg(sm, SM501_GPIO63_32_CONTROL, &init->gpio_high);
+}
+
+static unsigned int sm501_mem_local[] = {
+	[0]	= SZ_4M,
+	[1]	= SZ_8M,
+	[2]	= SZ_16M,
+	[3]	= SZ_32M,
+	[4]	= SZ_64M,
+	[5]	= SZ_2M,
+};
+
+/* sm501_init_dev
+ *
+ * Common init code for an SM501
+*/
+
+static int sm501_init_dev(struct sm501_devdata *sm)
+{
+	unsigned long mem_avail;
+	unsigned long dramctrl;
+	int ret;
+
+	dramctrl = readl(sm->regs + SM501_DRAM_CONTROL);
+
+	mem_avail = sm501_mem_local[(dramctrl >> 13) & 0x7];
+
+	dev_info(sm->dev, "SM501 At %p,%p: Version %08x, %ld Mb, IRQ %d\n",
+		 NULL, sm->regs, readl(sm->regs + SM501_DEVICEID),
+		 mem_avail >> 20, sm->irq);
+
+	dev_info(sm->dev, "CurrentGate      %08x\n", readl(sm->regs+0x38));
+	dev_info(sm->dev, "CurrentClock     %08x\n", readl(sm->regs+0x3c));
+	dev_info(sm->dev, "PowerModeControl %08x\n", readl(sm->regs+0x54));
+
+	ret = device_create_file(sm->dev, &dev_attr_dbg_regs);
+	if (ret)
+		dev_err(sm->dev, "failed to create debug regs file\n");
+
+	sm501_dump_clk(sm);
+
+	/* check to see if we have some device initialisation */
+
+	if (sm->platdata) {
+		struct sm501_platdata *pdata = sm->platdata;
+
+		if (pdata->init) {
+			sm501_init_regs(sm, sm->platdata->init);
+
+			if (pdata->init->devices & SM501_USE_USB_HOST)
+				sm501_register_usbhost(sm, &mem_avail);
+		}
+	}
+
+	/* always create a framebuffer */
+	sm501_register_display(sm, &mem_avail);
+
+	return 0;
+}
+
+static int sm501_plat_probe(struct platform_device *dev)
+{
+	struct sm501_devdata *sm;
+	int err;
+
+	sm = kzalloc(sizeof(struct sm501_devdata), GFP_KERNEL);
+	if (sm == NULL) {
+		dev_err(&dev->dev, "no memory for device data\n");
+		err = -ENOMEM;
+		goto err1;
+	}
+
+	sema_init(&sm->clock_lock, 1);
+	spin_lock_init(&sm->reg_lock);
+
+	sm->dev = &dev->dev;
+	sm->pdev_id = dev->id;
+	sm->irq = platform_get_irq(dev, 0);
+	sm->io_res = platform_get_resource(dev, IORESOURCE_MEM, 1);
+	sm->mem_res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	sm->platdata = dev->dev.platform_data;
+
+	if (sm->irq < 0) {
+		dev_err(&dev->dev, "failed to get resources\n");
+		err = sm->irq;
+		goto err_res;
+	}
+
+	if (sm->io_res == NULL || sm->mem_res == NULL) {
+		dev_err(&dev->dev, "failed to get resources\n");
+		err = -ENOENT;
+		goto err_res;
+	}
+
+	platform_set_drvdata(dev, sm);
+
+	sm->regs = ioremap(sm->io_res->start,
+			   (sm->io_res->end - sm->io_res->start) - 1);
+
+	if (sm->regs == NULL) {
+		dev_err(&dev->dev, "cannot remap registers\n");
+		err = -EIO;
+		goto err_res;
+	}
+
+	return sm501_init_dev(sm);
+
+ err_res:
+	kfree(sm);
+ err1:
+	return err;
+
+}
+
+/* Initialisation data for PCI devices */
+
+static struct sm501_initdata sm501_pci_initdata = {
+	.gpio_high	= {
+		.set	= 0x3F000000,		/* 24bit panel */
+		.mask	= 0x0,
+	},
+	.misc_timing	= {
+		.set	= 0x010100,		/* SDRAM timing */
+		.mask	= 0x1F1F00,
+	},
+	.misc_control	= {
+		.set	= SM501_MISC_PNL_24BIT,
+		.mask	= 0,
+	},
+
+	.devices	= SM501_USE_ALL,
+	.mclk		= 100 * MHZ,
+	.m1xclk		= 160 * MHZ,
+};
+
+static struct sm501_platdata sm501_pci_platdata = {
+	.init		= &sm501_pci_initdata,
+};
+
+static int sm501_pci_probe(struct pci_dev *dev,
+			   const struct pci_device_id *id)
+{
+	struct sm501_devdata *sm;
+	int err;
+
+	sm = kzalloc(sizeof(struct sm501_devdata), GFP_KERNEL);
+	if (sm == NULL) {
+		dev_err(&dev->dev, "no memory for device data\n");
+		err = -ENOMEM;
+		goto err1;
+	}
+
+	/* set a default set of platform data */
+	dev->dev.platform_data = sm->platdata = &sm501_pci_platdata;
+
+	sm->dev = &dev->dev;
+	sm->irq = dev->irq;
+
+	/* set a hopefully unique id for our child platform devices */
+	sm->pdev_id = 32 + dev->devfn;
+
+	pci_set_drvdata(dev, sm);
+
+	err = pci_enable_device(dev);
+	if (err) {
+		dev_err(&dev->dev, "cannot enable device\n");
+		goto err2;
+	}
+
+	/* check our resources */
+
+	if (!(pci_resource_flags(dev, 0) & IORESOURCE_MEM)) {
+		dev_err(&dev->dev, "region #0 is not memory?\n");
+		err = -EINVAL;
+		goto err3;
+	}
+
+	if (!(pci_resource_flags(dev, 1) & IORESOURCE_MEM)) {
+		dev_err(&dev->dev, "region #1 is not memory?\n");
+		err = -EINVAL;
+		goto err3;
+	}
+
+	/* reserve our io regions */
+
+	if (do_request_regions) {
+		err = pci_request_regions(dev, "sm501");
+		if (err) {
+			dev_err(&dev->dev, "cannot get regions\n");
+			goto err3;
+		}
+	}
+
+	sm->io_res = &dev->resource[1];
+	sm->mem_res = &dev->resource[0];
+
+	sm->regs = ioremap(pci_resource_start(dev, 1),
+			   pci_resource_len(dev, 1));
+
+	if (sm->regs == NULL) {
+		dev_err(&dev->dev, "cannot remap registers\n");
+		err = -EIO;
+		goto err4;
+	}
+
+	sm501_init_dev(sm);
+	return 0;
+
+ err4:
+	if (do_request_regions)
+		pci_release_regions(dev);
+ err3:
+	pci_disable_device(dev);
+ err2:
+	pci_set_drvdata(dev, NULL);
+	kfree(sm);
+ err1:
+	return err;
+}
+
+static void sm501_remove_sub(struct sm501_devdata *sm,
+			     struct sm501_device *smdev)
+{
+	list_del(&smdev->list);
+	platform_device_unregister(&smdev->pdev);
+}
+
+static void sm501_dev_remove(struct sm501_devdata *sm)
+{
+	struct sm501_device *smdev, *tmp;
+
+	list_for_each_entry_safe(smdev, tmp, &sm->devices, list)
+		sm501_remove_sub(sm, smdev);
+
+	device_remove_file(sm->dev, &dev_attr_dbg_regs);
+}
+
+static void sm501_pci_remove(struct pci_dev *dev)
+{
+	struct sm501_devdata *sm = pci_get_drvdata(dev);
+
+	sm501_dev_remove(sm);
+	iounmap(sm->regs);
+
+	if (do_request_regions)
+		pci_release_regions(dev);
+
+	pci_set_drvdata(dev, NULL);
+	pci_disable_device(dev);
+}
+
+static int sm501_plat_remove(struct platform_device *dev)
+{
+	struct sm501_devdata *sm = platform_get_drvdata(dev);
+
+	sm501_dev_remove(sm);
+	iounmap(sm->regs);
+
+	return 0;
+}
+
+static struct pci_device_id sm501_pci_tbl[] = {
+	{ 0x126f, 0x0501, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0, },
+};
+
+MODULE_DEVICE_TABLE(pci, sm501_pci_tbl);
+
+static struct pci_driver sm501_pci_drv = {
+	.name		= "sm501",
+	.id_table	= sm501_pci_tbl,
+	.probe		= sm501_pci_probe,
+	.remove		= sm501_pci_remove,
+};
+
+static struct platform_driver sm501_plat_drv = {
+	.driver		= {
+		.name	= "sm501",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= sm501_plat_probe,
+	.remove		= sm501_plat_remove,
+};
+
+static int __init sm501_base_init(void)
+{
+	platform_driver_register(&sm501_plat_drv);
+	return pci_module_init(&sm501_pci_drv);
+}
+
+static void __exit sm501_base_exit(void)
+{
+	platform_driver_unregister(&sm501_plat_drv);
+	pci_unregister_driver(&sm501_pci_drv);
+}
+
+module_init(sm501_base_init);
+module_exit(sm501_base_exit);
+
+MODULE_DESCRIPTION("SM501 Core Driver");
+MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>, Vincent Sanders");
+MODULE_LICENSE("GPL v2");
diff -urpN -X ../dontdiff linux-2.6.19/include/linux/sm501-regs.h linux-2.6.19-simtec1p9/include/linux/sm501-regs.h
--- linux-2.6.19/include/linux/sm501-regs.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19-simtec1p9/include/linux/sm501-regs.h	2006-12-07 15:58:14.000000000 +0000
@@ -0,0 +1,284 @@
+/* sm501-regs.h
+ *
+ * Copyright 2006 Simtec Electronics
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Silicon Motion SM501 register definitions
+*/
+
+/* System Configuration area */
+/* System config base */
+#define SM501_SYS_CONFIG		(0x000000)
+
+/* config 1 */
+#define SM501_SYSTEM_CONTROL 		(0x000000)
+#define SM501_MISC_CONTROL		(0x000004)
+
+#define SM501_MISC_BUS_SH		(0x0)
+#define SM501_MISC_BUS_PCI		(0x1)
+#define SM501_MISC_BUS_XSCALE		(0x2)
+#define SM501_MISC_BUS_NEC		(0x6)
+#define SM501_MISC_BUS_MASK		(0x7)
+
+#define SM501_MISC_VR_62MB		(1<<3)
+#define SM501_MISC_CDR_RESET		(1<<7)
+#define SM501_MISC_USB_LB		(1<<8)
+#define SM501_MISC_USB_SLAVE		(1<<9)
+#define SM501_MISC_BL_1			(1<<10)
+#define SM501_MISC_MC			(1<<11)
+#define SM501_MISC_DAC_POWER		(1<<12)
+#define SM501_MISC_IRQ_INVERT		(1<<16)
+#define SM501_MISC_SH			(1<<17)
+
+#define SM501_MISC_HOLD_EMPTY		(0<<18)
+#define SM501_MISC_HOLD_8		(1<<18)
+#define SM501_MISC_HOLD_16		(2<<18)
+#define SM501_MISC_HOLD_24		(3<<18)
+#define SM501_MISC_HOLD_32		(4<<18)
+#define SM501_MISC_HOLD_MASK		(7<<18)
+
+#define SM501_MISC_FREQ_12		(1<<24)
+#define SM501_MISC_PNL_24BIT		(1<<25)
+#define SM501_MISC_8051_LE		(1<<26)
+
+
+
+#define SM501_GPIO31_0_CONTROL		(0x000008)
+#define SM501_GPIO63_32_CONTROL		(0x00000C)
+#define SM501_DRAM_CONTROL		(0x000010)
+
+/* command list */
+#define SM501_ARBTRTN_CONTROL		(0x000014)
+
+/* command list */
+#define SM501_COMMAND_LIST_STATUS	(0x000024)
+
+/* interrupt debug */
+#define SM501_RAW_IRQ_STATUS		(0x000028)
+#define SM501_RAW_IRQ_CLEAR		(0x000028)
+#define SM501_IRQ_STATUS		(0x00002C)
+#define SM501_IRQ_MASK			(0x000030)
+#define SM501_DEBUG_CONTROL		(0x000034)
+
+/* power management */
+#define SM501_CURRENT_GATE		(0x000038)
+#define SM501_CURRENT_CLOCK		(0x00003C)
+#define SM501_POWER_MODE_0_GATE		(0x000040)
+#define SM501_POWER_MODE_0_CLOCK	(0x000044)
+#define SM501_POWER_MODE_1_GATE		(0x000048)
+#define SM501_POWER_MODE_1_CLOCK	(0x00004C)
+#define SM501_SLEEP_MODE_GATE		(0x000050)
+#define SM501_POWER_MODE_CONTROL	(0x000054)
+
+/* power gates for units within the 501 */
+#define SM501_GATE_HOST			(0)
+#define SM501_GATE_MEMORY		(1)
+#define SM501_GATE_DISPLAY		(2)
+#define SM501_GATE_2D_ENGINE		(3)
+#define SM501_GATE_CSC			(4)
+#define SM501_GATE_ZVPORT		(5)
+#define SM501_GATE_GPIO			(6)
+#define SM501_GATE_UART0		(7)
+#define SM501_GATE_UART1		(8)
+#define SM501_GATE_SSP			(10)
+#define SM501_GATE_USB_HOST		(11)
+#define SM501_GATE_USB_GADGET		(12)
+#define SM501_GATE_UCONTROLLER		(17)
+#define SM501_GATE_AC97			(18)
+
+/* panel clock */
+#define SM501_CLOCK_P2XCLK		(24)
+/* crt clock */
+#define SM501_CLOCK_V2XCLK		(16)
+/* main clock */
+#define SM501_CLOCK_MCLK		(8)
+/* SDRAM controller clock */
+#define SM501_CLOCK_M1XCLK		(0)
+
+/* config 2 */
+#define SM501_PCI_MASTER_BASE		(0x000058)
+#define SM501_ENDIAN_CONTROL		(0x00005C)
+#define SM501_DEVICEID			(0x000060)
+/* 0x050100A0 */
+
+#define SM501_PLLCLOCK_COUNT		(0x000064)
+#define SM501_MISC_TIMING		(0x000068)
+#define SM501_CURRENT_SDRAM_CLOCK	(0x00006C)
+
+/* GPIO base */
+#define SM501_GPIO			(0x010000)
+#define SM501_GPIO_DATA_LOW		(0x00)
+#define SM501_GPIO_DATA_HIGH		(0x04)
+#define SM501_GPIO_DDR_LOW		(0x08)
+#define SM501_GPIO_DDR_HIGH		(0x0C)
+#define SM501_GPIO_IRQ_SETUP		(0x10)
+#define SM501_GPIO_IRQ_STATUS		(0x14)
+#define SM501_GPIO_IRQ_RESET		(0x14)
+
+/* I2C controller base */
+#define SM501_I2C			(0x010040)
+#define SM501_I2C_BYTE_COUNT		(0x00)
+#define SM501_I2C_CONTROL		(0x01)
+#define SM501_I2C_STATUS		(0x02)
+#define SM501_I2C_RESET			(0x02)
+#define SM501_I2C_SLAVE_ADDRESS		(0x03)
+#define SM501_I2C_DATA			(0x04)
+
+/* SSP base */
+#define SM501_SSP			(0x020000)
+
+/* Uart 0 base */
+#define SM501_UART0			(0x030000)
+
+/* Uart 1 base */
+#define SM501_UART1			(0x030020)
+
+/* USB host port base */
+#define SM501_USB_HOST			(0x040000)
+
+/* USB slave/gadget base */
+#define SM501_USB_GADGET		(0x060000)
+
+/* USB slave/gadget data port base */
+#define SM501_USB_GADGET_DATA		(0x070000)
+
+/* Display contoller/video engine base */
+#define SM501_DC			(0x080000)
+#define SM501_DC_PANEL_CONTROL		(0x000)
+#define SM501_DC_PANEL_PANNING_CONTROL	(0x004)
+#define SM501_DC_PANEL_COLOR_KEY	(0x008)
+#define SM501_DC_PANEL_FB_ADDR		(0x00C)
+#define SM501_DC_PANEL_FB_OFFSET	(0x010)
+#define SM501_DC_PANEL_FB_WIDTH		(0x014)
+#define SM501_DC_PANEL_FB_HEIGHT	(0x018)
+#define SM501_DC_PANEL_TL_LOC		(0x01C)
+#define SM501_DC_PANEL_BR_LOC		(0x020)
+#define SM501_DC_PANEL_H_TOT		(0x024)
+#define SM501_DC_PANEL_H_SYNC		(0x028)
+#define SM501_DC_PANEL_V_TOT		(0x02C)
+#define SM501_DC_PANEL_V_SYNC		(0x030)
+#define SM501_DC_PANEL_CUR_LINE		(0x034)
+
+#define SM501_DC_VIDEO_CONTROL		(0x040)
+#define SM501_DC_VIDEO_FB0_ADDR		(0x044)
+#define SM501_DC_VIDEO_FB_WIDTH		(0x048)
+#define SM501_DC_VIDEO_FB0_LAST_ADDR	(0x04C)
+#define SM501_DC_VIDEO_TL_LOC		(0x050)
+#define SM501_DC_VIDEO_BR_LOC		(0x054)
+#define SM501_DC_VIDEO_SCALE		(0x058)
+#define SM501_DC_VIDEO_INIT_SCALE	(0x05C)
+#define SM501_DC_VIDEO_YUV_CONSTANTS	(0x060)
+#define SM501_DC_VIDEO_FB1_ADDR		(0x064)
+#define SM501_DC_VIDEO_FB1_LAST_ADDR	(0x068)
+
+#define SM501_DC_VIDEO_ALPHA_CONTROL	(0x080)
+#define SM501_DC_VIDEO_ALPHA_FB_ADDR	(0x084)
+#define SM501_DC_VIDEO_ALPHA_FB_OFFSET	(0x088)
+#define SM501_DC_VIDEO_ALPHA_FB_LAST_ADDR	(0x08C)
+#define SM501_DC_VIDEO_ALPHA_TL_LOC	(0x090)
+#define SM501_DC_VIDEO_ALPHA_BR_LOC	(0x094)
+#define SM501_DC_VIDEO_ALPHA_SCALE	(0x098)
+#define SM501_DC_VIDEO_ALPHA_INIT_SCALE	(0x09C)
+#define SM501_DC_VIDEO_ALPHA_CHROMA_KEY	(0x0A0)
+#define SM501_DC_VIDEO_ALPHA_COLOR_LOOKUP	(0x0A4)
+
+
+#define SM501_DC_PANEL_HWC_ADDR		(0x0F0)
+#define SM501_DC_PANEL_HWC_LOC		(0x0F4)
+#define SM501_DC_PANEL_HWC_COLOR_1_2	(0x0F8)
+#define SM501_DC_PANEL_HWC_COLOR_3	(0x0FC)
+
+#define SM501_OFF_HWC_ADDR		(0x00)
+#define SM501_OFF_HWC_LOC		(0x04)
+#define SM501_OFF_HWC_COLOR_1_2		(0x08)
+#define SM501_OFF_HWC_COLOR_3		(0x0C)
+
+#define SM501_DC_ALPHA_CONTROL		(0x100)
+#define SM501_DC_ALPHA_FB_ADDR		(0x104)
+#define SM501_DC_ALPHA_FB_OFFSET	(0x108)
+#define SM501_DC_ALPHA_TL_LOC		(0x10C)
+#define SM501_DC_ALPHA_BR_LOC		(0x110)
+#define SM501_DC_ALPHA_CHROMA_KEY	(0x114)
+#define SM501_DC_ALPHA_COLOR_LOOKUP	(0x118)
+
+#define SM501_DC_CRT_CONTROL		(0x200)
+#define SM501_DC_CRT_FB_ADDR		(0x204)
+#define SM501_DC_CRT_FB_OFFSET		(0x208)
+#define SM501_DC_CRT_H_TOT		(0x20C)
+#define SM501_DC_CRT_H_SYNC		(0x210)
+#define SM501_DC_CRT_V_TOT		(0x214)
+#define SM501_DC_CRT_V_SYNC		(0x218)
+#define SM501_DC_CRT_SIGNATURE_ANALYZER	(0x21C)
+#define SM501_DC_CRT_CUR_LINE		(0x220)
+#define SM501_DC_CRT_MONITOR_DETECT	(0x224)
+
+#define SM501_DC_CRT_HWC_ADDR		(0x230)
+#define SM501_DC_CRT_HWC_LOC		(0x234)
+#define SM501_DC_CRT_HWC_COLOR_1_2	(0x238)
+#define SM501_DC_CRT_HWC_COLOR_3	(0x23C)
+
+#define SM501_DC_PANEL_PALETTE		(0x400)
+
+#define SM501_DC_VIDEO_PALETTE		(0x800)
+
+#define SM501_DC_CRT_PALETTE		(0xC00)
+
+/* Zoom Video port base */
+#define SM501_ZVPORT			(0x090000)
+
+/* AC97/I2S base */
+#define SM501_AC97			(0x0A0000)
+
+/* 8051 micro controller base */
+#define SM501_UCONTROLLER		(0x0B0000)
+
+/* 8051 micro controller SRAM base */
+#define SM501_UCONTROLLER_SRAM		(0x0C0000)
+
+/* DMA base */
+#define SM501_DMA			(0x0D0000)
+
+/* 2d engine base */
+#define SM501_2D_ENGINE			(0x100000)
+#define SM501_2D_SOURCE			(0x00)
+#define SM501_2D_DESTINATION		(0x04)
+#define SM501_2D_DIMENSION		(0x08)
+#define SM501_2D_CONTROL		(0x0C)
+#define SM501_2D_PITCH			(0x10)
+#define SM501_2D_FOREGROUND		(0x14)
+#define SM501_2D_BACKGROUND		(0x18)
+#define SM501_2D_STRETCH		(0x1C)
+#define SM501_2D_COLOR_COMPARE		(0x20)
+#define SM501_2D_COLOR_COMPARE_MASK 	(0x24)
+#define SM501_2D_MASK			(0x28)
+#define SM501_2D_CLIP_TL		(0x2C)
+#define SM501_2D_CLIP_BR		(0x30)
+#define SM501_2D_MONO_PATTERN_LOW	(0x34)
+#define SM501_2D_MONO_PATTERN_HIGH	(0x38)
+#define SM501_2D_WINDOW_WIDTH		(0x3C)
+#define SM501_2D_SOURCE_BASE		(0x40)
+#define SM501_2D_DESTINATION_BASE	(0x44)
+#define SM501_2D_ALPHA			(0x48)
+#define SM501_2D_WRAP			(0x4C)
+#define SM501_2D_STATUS			(0x50)
+
+#define SM501_CSC_Y_SOURCE_BASE		(0xC8)
+#define SM501_CSC_CONSTANTS		(0xCC)
+#define SM501_CSC_Y_SOURCE_X		(0xD0)
+#define SM501_CSC_Y_SOURCE_Y		(0xD4)
+#define SM501_CSC_U_SOURCE_BASE		(0xD8)
+#define SM501_CSC_V_SOURCE_BASE		(0xDC)
+#define SM501_CSC_SOURCE_DIMENSION	(0xE0)
+#define SM501_CSC_SOURCE_PITCH		(0xE4)
+#define SM501_CSC_DESTINATION		(0xE8)
+#define SM501_CSC_DESTINATION_DIMENSION	(0xEC)
+#define SM501_CSC_DESTINATION_PITCH	(0xF0)
+#define SM501_CSC_SCALE_FACTOR		(0xF4)
+#define SM501_CSC_DESTINATION_BASE	(0xF8)
+#define SM501_CSC_CONTROL		(0xFC)
+
+/* 2d engine data port base */
+#define SM501_2D_ENGINE_DATA		(0x110000)
diff -urpN -X ../dontdiff linux-2.6.19/include/linux/sm501.h linux-2.6.19-simtec1p9/include/linux/sm501.h
--- linux-2.6.19/include/linux/sm501.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.19-simtec1p9/include/linux/sm501.h	2006-12-13 01:54:26.000000000 +0000
@@ -0,0 +1,152 @@
+/* include/linux/sm501.h
+ *
+ * Copyright (c) 2006 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	Vincent Sanders <vince@simtec.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+*/
+
+extern int sm501_unit_power(struct device *dev,
+			    unsigned int unit, unsigned int to);
+
+extern unsigned long sm501_set_clock(struct device *dev,
+				     int clksrc, unsigned long freq);
+
+extern unsigned long sm501_find_clock(int clksrc, unsigned long req_freq);
+
+/* sm501_misc_control
+ *
+ * Modify the SM501's MISC_CONTROL register
+*/
+
+extern int sm501_misc_control(struct device *dev,
+			      unsigned long set, unsigned long clear);
+
+/* sm501_modify_reg
+ *
+ * Modify a register in the SM501 which may be shared with other
+ * drivers.
+*/
+
+extern unsigned long sm501_modify_reg(struct device *dev,
+				      unsigned long reg,
+				      unsigned long set,
+				      unsigned long clear);
+
+/* sm501_gpio_set
+ *
+ * set the state of the given GPIO line
+*/
+
+extern void sm501_gpio_set(struct device *dev,
+			   unsigned long gpio,
+			   unsigned int to,
+			   unsigned int dir);
+
+/* sm501_gpio_get
+ *
+ * get the state of the given GPIO line
+*/
+
+extern unsigned long sm501_gpio_get(struct device *dev,
+				    unsigned long gpio);
+
+
+/* Platform data definitions */
+
+struct sm501_platdata_fbsub {
+	struct fb_mode		*def_mode;
+	unsigned long		 max_mem;
+};
+
+/* sm501_platdata_fb
+ *
+ * configuration data for the framebuffer driver
+*/
+
+struct sm501_platdata_fb {
+	struct sm501_platdata_fbsub	*fb_crt;
+	struct sm501_platdata_fbsub	*fb_pnl;
+};
+
+/* gpio i2c */
+
+struct sm501_platdata_gpio_i2c {
+	unsigned int		pin_sda;
+	unsigned int		pin_scl;
+};
+
+/* sm501_initdata
+ *
+ * use for initialising values that may not have been setup
+ * before the driver is loaded.
+*/
+
+struct sm501_reg_init {
+	unsigned long		set;
+	unsigned long		mask;
+};
+
+#define SM501_USE_USB_HOST	(1<<0)
+#define SM501_USE_USB_SLAVE	(1<<1)
+#define SM501_USE_SSP0		(1<<2)
+#define SM501_USE_SSP1		(1<<3)
+#define SM501_USE_UART0		(1<<4)
+#define SM501_USE_UART1		(1<<5)
+#define SM501_USE_FBACCEL	(1<<6)
+#define SM501_USE_AC97		(1<<7)
+#define SM501_USE_I2S		(1<<8)
+
+#define SM501_USE_ALL		(0xffffffff)
+
+struct sm501_initdata {
+	struct sm501_reg_init	gpio_low;
+	struct sm501_reg_init	gpio_high;
+	struct sm501_reg_init	misc_timing;
+	struct sm501_reg_init	misc_control;
+
+	unsigned long		devices;
+	unsigned long		mclk;		/* non-zero to modify */
+	unsigned long		m1xclk;		/* non-zero to modify */
+};
+
+/* sm501_init_gpio
+ *
+ * default gpio settings
+*/
+
+struct sm501_init_gpio {
+	struct sm501_reg_init	gpio_data_low;
+	struct sm501_reg_init	gpio_data_high;
+	struct sm501_reg_init	gpio_ddr_low;
+	struct sm501_reg_init	gpio_ddr_high;
+};
+
+/* sm501_platdata
+ *
+ * This is passed with the platform device to allow the board
+ * to control the behaviour of the SM501 driver(s) which attach
+ * to the device.
+ *
+*/
+
+struct sm501_platdata {
+	struct sm501_initdata		*init;
+	struct sm501_init_gpio		*init_gpiop;
+	struct sm501_platdata_fb	*fb;
+
+	struct sm501_platdata_gpio_i2c	*gpio_i2c;
+	unsigned int			 gpio_i2c_nr;
+};

--ikeVEW9yuYc//A+q--
