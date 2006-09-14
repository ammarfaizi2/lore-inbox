Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbWINOfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbWINOfg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWINOf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:35:28 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:34760 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1750821AbWINOfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:35:13 -0400
Date: Thu, 14 Sep 2006 16:30:26 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [-mm patch 1/4] AVR32 MTD: Static Memory Controller driver
Message-ID: <20060914163026.49766346@cad-250-152.norway.atmel.com>
In-Reply-To: <20060914162926.6c117b36@cad-250-152.norway.atmel.com>
References: <20060914162926.6c117b36@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.0-rc2 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a simple API for configuring the static memory controller
along with an implementation for the Atmel HSMC.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 arch/avr32/mach-at32ap/Makefile     |    2 
 arch/avr32/mach-at32ap/at32ap7000.c |   10 ++
 arch/avr32/mach-at32ap/hsmc.c       |  164 ++++++++++++++++++++++++++++++++++
 arch/avr32/mach-at32ap/hsmc.h       |  169 ++++++++++++++++++++++++++++++++++++
 include/asm-avr32/arch-at32ap/smc.h |   60 ++++++++++++
 5 files changed, 404 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc2-mm1/arch/avr32/mach-at32ap/Makefile
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/avr32/mach-at32ap/Makefile	2006-08-01 16:16:07.000000000 +0200
+++ linux-2.6.18-rc2-mm1/arch/avr32/mach-at32ap/Makefile	2006-08-01 16:49:52.000000000 +0200
@@ -1,2 +1,2 @@
-obj-y				+= at32ap.o clock.o pio.o intc.o extint.o
+obj-y				+= at32ap.o clock.o pio.o intc.o extint.o hsmc.o
 obj-$(CONFIG_CPU_AT32AP7000)	+= at32ap7000.o
Index: linux-2.6.18-rc2-mm1/arch/avr32/mach-at32ap/at32ap7000.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/avr32/mach-at32ap/at32ap7000.c	2006-08-01 16:16:07.000000000 +0200
+++ linux-2.6.18-rc2-mm1/arch/avr32/mach-at32ap/at32ap7000.c	2006-08-01 16:49:52.000000000 +0200
@@ -450,6 +450,13 @@ static struct clk hramc_clk = {
 	.users		= 1,
 };
 
+static struct resource smc0_resource[] = {
+	PBMEM(0xfff03400),
+};
+DEFINE_DEV(smc, 0);
+DEV_CLK(pclk, smc0, pbb, 13);
+DEV_CLK(mck, smc0, hsb, 0);
+
 static struct platform_device pdc_device = {
 	.name		= "pdc",
 	.id		= 0,
@@ -503,6 +510,7 @@ void __init at32_add_system_devices(void
 
 	platform_device_register(&at32_sm_device);
 	platform_device_register(&at32_intc0_device);
+	platform_device_register(&smc0_device);
 	platform_device_register(&pdc_device);
 
 	platform_device_register(&pio0_device);
@@ -796,6 +804,8 @@ struct clk *at32_clock_list[] = {
 	&at32_intc0_pclk,
 	&ebi_clk,
 	&hramc_clk,
+	&smc0_pclk,
+	&smc0_mck,
 	&pdc_hclk,
 	&pdc_pclk,
 	&pico_clk,
Index: linux-2.6.18-rc2-mm1/arch/avr32/mach-at32ap/hsmc.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc2-mm1/arch/avr32/mach-at32ap/hsmc.c	2006-08-01 16:49:52.000000000 +0200
@@ -0,0 +1,164 @@
+/*
+ * Static Memory Controller for AT32 chips
+ *
+ * Copyright (C) 2006 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#define DEBUG
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <asm/io.h>
+#include <asm/arch/smc.h>
+
+#include "hsmc.h"
+
+#define NR_CHIP_SELECTS 6
+
+struct hsmc {
+	void __iomem *regs;
+	struct clk *pclk;
+	struct clk *mck;
+};
+
+static struct hsmc *hsmc;
+
+int smc_set_configuration(int cs, const struct smc_config *config)
+{
+	unsigned long mul;
+	unsigned long offset;
+	u32 setup, pulse, cycle, mode;
+
+	if (!hsmc)
+		return -ENODEV;
+	if (cs >= NR_CHIP_SELECTS)
+		return -EINVAL;
+
+	/*
+	 * cycles = x / T = x * f
+	 *   = ((x * 1000000000) * ((f * 65536) / 1000000000)) / 65536
+	 *   = ((x * 1000000000) * (((f / 10000) * 65536) / 100000)) / 65536
+	 */
+	mul = (clk_get_rate(hsmc->mck) / 10000) << 16;
+	mul /= 100000;
+
+#define ns2cyc(x) ((((x) * mul) + 65535) >> 16)
+
+	setup = (HSMC_BF(NWE_SETUP, ns2cyc(config->nwe_setup))
+		 | HSMC_BF(NCS_WR_SETUP, ns2cyc(config->ncs_write_setup))
+		 | HSMC_BF(NRD_SETUP, ns2cyc(config->nrd_setup))
+		 | HSMC_BF(NCS_RD_SETUP, ns2cyc(config->ncs_read_setup)));
+	pulse = (HSMC_BF(NWE_PULSE, ns2cyc(config->nwe_pulse))
+		 | HSMC_BF(NCS_WR_PULSE, ns2cyc(config->ncs_write_pulse))
+		 | HSMC_BF(NRD_PULSE, ns2cyc(config->nrd_pulse))
+		 | HSMC_BF(NCS_RD_PULSE, ns2cyc(config->ncs_read_pulse)));
+	cycle = (HSMC_BF(NWE_CYCLE, ns2cyc(config->write_cycle))
+		 | HSMC_BF(NRD_CYCLE, ns2cyc(config->read_cycle)));
+
+	switch (config->bus_width) {
+	case 1:
+		mode = HSMC_BF(DBW, HSMC_DBW_8_BITS);
+		break;
+	case 2:
+		mode = HSMC_BF(DBW, HSMC_DBW_16_BITS);
+		break;
+	case 4:
+		mode = HSMC_BF(DBW, HSMC_DBW_32_BITS);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (config->nrd_controlled)
+		mode |= HSMC_BIT(READ_MODE);
+	if (config->nwe_controlled)
+		mode |= HSMC_BIT(WRITE_MODE);
+	if (config->byte_write)
+		mode |= HSMC_BIT(BAT);
+
+	pr_debug("smc cs%d: setup/%08x pulse/%08x cycle/%08x mode/%08x\n",
+		 cs, setup, pulse, cycle, mode);
+
+	offset = cs * 0x10;
+	hsmc_writel(hsmc, SETUP0 + offset, setup);
+	hsmc_writel(hsmc, PULSE0 + offset, pulse);
+	hsmc_writel(hsmc, CYCLE0 + offset, cycle);
+	hsmc_writel(hsmc, MODE0 + offset, mode);
+	hsmc_readl(hsmc, MODE0); /* I/O barrier */
+
+	return 0;
+}
+EXPORT_SYMBOL(smc_set_configuration);
+
+static int hsmc_probe(struct platform_device *pdev)
+{
+	struct resource *regs;
+	struct clk *pclk, *mck;
+	int ret;
+
+	if (hsmc)
+		return -EBUSY;
+
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs)
+		return -ENXIO;
+	pclk = clk_get(&pdev->dev, "pclk");
+	if (IS_ERR(pclk))
+		return PTR_ERR(pclk);
+	mck = clk_get(&pdev->dev, "mck");
+	if (IS_ERR(mck)) {
+		ret = PTR_ERR(mck);
+		goto out_put_pclk;
+	}
+
+	ret = -ENOMEM;
+	hsmc = kzalloc(sizeof(struct hsmc), GFP_KERNEL);
+	if (!hsmc)
+		goto out_put_clocks;
+
+	clk_enable(pclk);
+	clk_enable(mck);
+
+	hsmc->pclk = pclk;
+	hsmc->mck = mck;
+	hsmc->regs = ioremap(regs->start, regs->end - regs->start + 1);
+	if (!hsmc->regs)
+		goto out_disable_clocks;
+
+	dev_info(&pdev->dev, "Atmel Static Memory Controller at 0x%08lx\n",
+		 (unsigned long)regs->start);
+
+	platform_set_drvdata(pdev, hsmc);
+
+	return 0;
+
+out_disable_clocks:
+	clk_disable(mck);
+	clk_disable(pclk);
+	kfree(hsmc);
+out_put_clocks:
+	clk_put(mck);
+out_put_pclk:
+	clk_put(pclk);
+	hsmc = NULL;
+	return ret;
+}
+
+static struct platform_driver hsmc_driver = {
+	.probe		= hsmc_probe,
+	.driver		= {
+		.name	= "smc",
+	},
+};
+
+static int __init hsmc_init(void)
+{
+	return platform_driver_register(&hsmc_driver);
+}
+arch_initcall(hsmc_init);
Index: linux-2.6.18-rc2-mm1/arch/avr32/mach-at32ap/hsmc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc2-mm1/arch/avr32/mach-at32ap/hsmc.h	2006-08-01 16:49:52.000000000 +0200
@@ -0,0 +1,169 @@
+/*
+ * Register definitions for Atmel Static Memory Controller (SMC)
+ *
+ * Copyright (C) 2006 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_AVR32_HSMC_H__
+#define __ASM_AVR32_HSMC_H__
+
+/* HSMC register offsets */
+#define HSMC_SETUP0                            0x0000
+#define HSMC_PULSE0                            0x0004
+#define HSMC_CYCLE0                            0x0008
+#define HSMC_MODE0                             0x000c
+#define HSMC_SETUP1                            0x0010
+#define HSMC_PULSE1                            0x0014
+#define HSMC_CYCLE1                            0x0018
+#define HSMC_MODE1                             0x001c
+#define HSMC_SETUP2                            0x0020
+#define HSMC_PULSE2                            0x0024
+#define HSMC_CYCLE2                            0x0028
+#define HSMC_MODE2                             0x002c
+#define HSMC_SETUP3                            0x0030
+#define HSMC_PULSE3                            0x0034
+#define HSMC_CYCLE3                            0x0038
+#define HSMC_MODE3                             0x003c
+#define HSMC_SETUP4                            0x0040
+#define HSMC_PULSE4                            0x0044
+#define HSMC_CYCLE4                            0x0048
+#define HSMC_MODE4                             0x004c
+#define HSMC_SETUP5                            0x0050
+#define HSMC_PULSE5                            0x0054
+#define HSMC_CYCLE5                            0x0058
+#define HSMC_MODE5                             0x005c
+
+/* Bitfields in SETUP0 */
+#define HSMC_NWE_SETUP_OFFSET                  0
+#define HSMC_NWE_SETUP_SIZE                    6
+#define HSMC_NCS_WR_SETUP_OFFSET               8
+#define HSMC_NCS_WR_SETUP_SIZE                 6
+#define HSMC_NRD_SETUP_OFFSET                  16
+#define HSMC_NRD_SETUP_SIZE                    6
+#define HSMC_NCS_RD_SETUP_OFFSET               24
+#define HSMC_NCS_RD_SETUP_SIZE                 6
+
+/* Bitfields in PULSE0 */
+#define HSMC_NWE_PULSE_OFFSET                  0
+#define HSMC_NWE_PULSE_SIZE                    7
+#define HSMC_NCS_WR_PULSE_OFFSET               8
+#define HSMC_NCS_WR_PULSE_SIZE                 7
+#define HSMC_NRD_PULSE_OFFSET                  16
+#define HSMC_NRD_PULSE_SIZE                    7
+#define HSMC_NCS_RD_PULSE_OFFSET               24
+#define HSMC_NCS_RD_PULSE_SIZE                 7
+
+/* Bitfields in CYCLE0 */
+#define HSMC_NWE_CYCLE_OFFSET                  0
+#define HSMC_NWE_CYCLE_SIZE                    9
+#define HSMC_NRD_CYCLE_OFFSET                  16
+#define HSMC_NRD_CYCLE_SIZE                    9
+
+/* Bitfields in MODE0 */
+#define HSMC_READ_MODE_OFFSET                  0
+#define HSMC_READ_MODE_SIZE                    1
+#define HSMC_WRITE_MODE_OFFSET                 1
+#define HSMC_WRITE_MODE_SIZE                   1
+#define HSMC_EXNW_MODE_OFFSET                  4
+#define HSMC_EXNW_MODE_SIZE                    2
+#define HSMC_BAT_OFFSET                        8
+#define HSMC_BAT_SIZE                          1
+#define HSMC_DBW_OFFSET                        12
+#define HSMC_DBW_SIZE                          2
+#define HSMC_TDF_CYCLES_OFFSET                 16
+#define HSMC_TDF_CYCLES_SIZE                   4
+#define HSMC_TDF_MODE_OFFSET                   20
+#define HSMC_TDF_MODE_SIZE                     1
+#define HSMC_PMEN_OFFSET                       24
+#define HSMC_PMEN_SIZE                         1
+#define HSMC_PS_OFFSET                         28
+#define HSMC_PS_SIZE                           2
+
+/* Bitfields in SETUP1 */
+
+/* Bitfields in PULSE1 */
+
+/* Bitfields in CYCLE1 */
+
+/* Bitfields in MODE1 */
+#define HSMC_PD_OFFSET                         28
+#define HSMC_PD_SIZE                           2
+
+/* Bitfields in SETUP2 */
+
+/* Bitfields in PULSE2 */
+
+/* Bitfields in CYCLE2 */
+
+/* Bitfields in MODE2 */
+
+/* Bitfields in SETUP3 */
+
+/* Bitfields in PULSE3 */
+
+/* Bitfields in CYCLE3 */
+
+/* Bitfields in MODE3 */
+
+/* Bitfields in SETUP4 */
+
+/* Bitfields in PULSE4 */
+
+/* Bitfields in CYCLE4 */
+
+/* Bitfields in MODE4 */
+
+/* Bitfields in SETUP5 */
+
+/* Bitfields in PULSE5 */
+
+/* Bitfields in CYCLE5 */
+
+/* Bitfields in MODE5 */
+
+/* Constants for READ_MODE */
+#define HSMC_READ_MODE_NCS_CONTROLLED          0
+#define HSMC_READ_MODE_NRD_CONTROLLED          1
+
+/* Constants for WRITE_MODE */
+#define HSMC_WRITE_MODE_NCS_CONTROLLED         0
+#define HSMC_WRITE_MODE_NWE_CONTROLLED         1
+
+/* Constants for EXNW_MODE */
+#define HSMC_EXNW_MODE_DISABLED                0
+#define HSMC_EXNW_MODE_RESERVED                1
+#define HSMC_EXNW_MODE_FROZEN                  2
+#define HSMC_EXNW_MODE_READY                   3
+
+/* Constants for BAT */
+#define HSMC_BAT_BYTE_SELECT                   0
+#define HSMC_BAT_BYTE_WRITE                    1
+
+/* Constants for DBW */
+#define HSMC_DBW_8_BITS                        0
+#define HSMC_DBW_16_BITS                       1
+#define HSMC_DBW_32_BITS                       2
+
+/* Bit manipulation macros */
+#define HSMC_BIT(name)							\
+	(1 << HSMC_##name##_OFFSET)
+#define HSMC_BF(name,value)						\
+	(((value) & ((1 << HSMC_##name##_SIZE) - 1))			\
+	 << HSMC_##name##_OFFSET)
+#define HSMC_BFEXT(name,value)						\
+	(((value) >> HSMC_##name##_OFFSET)				\
+	 & ((1 << HSMC_##name##_SIZE) - 1))
+#define HSMC_BFINS(name,value,old)					\
+	(((old) & ~(((1 << HSMC_##name##_SIZE) - 1)			\
+		    << HSMC_##name##_OFFSET)) | HSMC_BF(name,value))
+
+/* Register access macros */
+#define hsmc_readl(port,reg)						\
+	readl((port)->regs + HSMC_##reg)
+#define hsmc_writel(port,reg,value)					\
+	writel((value), (port)->regs + HSMC_##reg)
+
+#endif /* __ASM_AVR32_HSMC_H__ */
Index: linux-2.6.18-rc2-mm1/include/asm-avr32/arch-at32ap/smc.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc2-mm1/include/asm-avr32/arch-at32ap/smc.h	2006-08-01 16:49:52.000000000 +0200
@@ -0,0 +1,60 @@
+/*
+ * Static Memory Controller for AT32 chips
+ *
+ * Copyright (C) 2006 Atmel Corporation
+ *
+ * Inspired by the OMAP2 General-Purpose Memory Controller interface
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ARCH_AT32AP_SMC_H
+#define __ARCH_AT32AP_SMC_H
+
+/*
+ * All timing parameters are in nanoseconds.
+ */
+struct smc_config {
+	/* Delay from address valid to assertion of given strobe */
+	u16		ncs_read_setup;
+	u16		nrd_setup;
+	u16		ncs_write_setup;
+	u16		nwe_setup;
+
+	/* Pulse length of given strobe */
+	u16		ncs_read_pulse;
+	u16		nrd_pulse;
+	u16		ncs_write_pulse;
+	u16		nwe_pulse;
+
+	/* Total cycle length of given operation */
+	u16		read_cycle;
+	u16		write_cycle;
+
+	/* Bus width in bytes */
+	u8		bus_width;
+
+	/*
+	 * 0: Data is sampled on rising edge of NCS
+	 * 1: Data is sampled on rising edge of NRD
+	 */
+	unsigned int	nrd_controlled:1;
+
+	/*
+	 * 0: Data is driven on falling edge of NCS
+	 * 1: Data is driven on falling edge of NWR
+	 */
+	unsigned int	nwe_controlled:1;
+
+	/*
+	 * 0: Byte select access type
+	 * 1: Byte write access type
+	 */
+	unsigned int	byte_write:1;
+};
+
+extern int smc_set_configuration(int cs, const struct smc_config *config);
+extern struct smc_config *smc_get_configuration(int cs);
+
+#endif /* __ARCH_AT32AP_SMC_H */
