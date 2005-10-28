Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751432AbVJ1IA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbVJ1IA0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 04:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVJ1IAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 04:00:25 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:17855 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S1751432AbVJ1IAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 04:00:23 -0400
Reply-To: <jbowler@acm.org>
From: John Bowler <jbowler@acm.org>
To: "'Deepak Saxena'" <dsaxena@plexity.net>
Cc: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: [PATCH] 2.6.14: NSLU2 machine support
Date: Fri, 28 Oct 2005 00:50:22 -0700
Message-ID: <001501c5db94$40eca320$1001a8c0@kalmiopsis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the LinkSys NSLU2 running with
both big and little-endian kernels.  The LinkSys NSLU2 is
a cost engineered ARM, XScale 420 based system similar to
the the Intel IXDP425 evaluation board.  It uses the 
IXP4XX ARCH.

Building a kernel for the NSLU2 also requires the following
patches not in 2.6.14:

[PATCH] 2.6.14-rc3 ixp4xx_copy_from little endian/alignment
[PATCH] 2.6.14 include/asm-arm/arch-ixp4xx/timex.h: fix clockfrequency on NSLU2
[PATCH]: 2.6.14-rc5 arch-ixp4xx/system.h: ensure flash is readable before reboot

and for correct operation of little-endian kernels (not 
required for big-endian):

[PATCH] 2.6.14-rc3 ixp4xx AHB/PCI endianness fix
[PATCH]: 2.6.14-rc3 drives/mtd/redboot.c: recognise a foreign bytesex partition table

This patch is the combined work of nslu2-linux.org

Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
Signed-off-by: John Bowler <jbowler@acm.org>

--- linux-2.6.13/.pc/50-nslu2-arch.patch/arch/arm/boot/compressed/head.S	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13/arch/arm/boot/compressed/head.S	2005-10-26 15:23:39.646352497 -0700
@@ -37,6 +37,7 @@
     defined(CONFIG_ARCH_INTEGRATOR) || \
     defined(CONFIG_ARCH_PXA) || \
     defined(CONFIG_ARCH_IXP4XX) || \
+    defined(CONFIG_MACH_NSLU2) || \
     defined(CONFIG_ARCH_IXP2000) || \
     defined(CONFIG_ARCH_LH7A40X) || \
     defined(CONFIG_ARCH_OMAP)
--- linux-2.6.13/.pc/50-nslu2-arch.patch/arch/arm/mach-ixp4xx/Kconfig	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13/arch/arm/mach-ixp4xx/Kconfig	2005-10-26 15:23:39.646352497 -0700
@@ -43,6 +43,12 @@ config MACH_IXDP465
 	  IXDP465 Development Platform (Also known as BMP).
 	  For more information on this platform, see <file:Documentation/arm/IXP4xx>.
 
+config MACH_NSLU2
+       bool "NSLU2"
+       help
+         Say 'Y' here if you want your kernel to support Linksys's 
+         NSLU2 NAS device. For more information on this platform, 
+         see http://www.nslu2-linux.org
 
 #
 # IXCDP1100 is the exact same HW as IXDP425, but with a different machine 
--- linux-2.6.13/.pc/50-nslu2-arch.patch/arch/arm/mach-ixp4xx/Makefile	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13/arch/arm/mach-ixp4xx/Makefile	2005-10-26 15:23:39.646352497 -0700
@@ -8,4 +8,5 @@ obj-$(CONFIG_ARCH_IXDP4XX)	+= ixdp425-pc
 obj-$(CONFIG_MACH_IXDPG425)	+= ixdpg425-pci.o coyote-setup.o
 obj-$(CONFIG_ARCH_ADI_COYOTE)	+= coyote-pci.o coyote-setup.o
 obj-$(CONFIG_MACH_GTWX5715)	+= gtwx5715-pci.o gtwx5715-setup.o
+obj-$(CONFIG_MACH_NSLU2)	+= nslu2-pci.o nslu2-setup.o nslu2-power.o
 
--- linux-2.6.13/.pc/50-nslu2-arch.patch/arch/arm/mach-ixp4xx/nslu2-pci.c	2005-10-26 15:19:43.171472071 -0700
+++ linux-2.6.13/arch/arm/mach-ixp4xx/nslu2-pci.c	2005-10-26 15:23:39.646352497 -0700
@@ -0,0 +1,78 @@
+/*
+ * arch/arm/mach-ixp4xx/nslu2-pci.c
+ *
+ * NSLU2 board-level PCI initialization
+ *
+ * based on ixdp425-pci.c:
+ *	Copyright (C) 2002 Intel Corporation.
+ *	Copyright (C) 2003-2004 MontaVista Software, Inc.
+ *
+ * Maintainer: http://www.nslu2-linux.org/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+
+#include <asm/mach/pci.h>
+#include <asm/mach-types.h>
+
+void __init nslu2_pci_preinit(void)
+{
+	set_irq_type(IRQ_NSLU2_PCI_INTA, IRQT_LOW);
+	set_irq_type(IRQ_NSLU2_PCI_INTB, IRQT_LOW);
+	set_irq_type(IRQ_NSLU2_PCI_INTC, IRQT_LOW);
+
+	gpio_line_isr_clear(NSLU2_PCI_INTA_PIN);
+	gpio_line_isr_clear(NSLU2_PCI_INTB_PIN);
+	gpio_line_isr_clear(NSLU2_PCI_INTC_PIN);
+
+	/* INTD is not configured as GPIO is used
+	 * for the power input button.
+	 */
+
+	ixp4xx_pci_preinit();
+}
+
+static int __init nslu2_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
+{
+	static int pci_irq_table[NSLU2_PCI_IRQ_LINES] = {
+		IRQ_NSLU2_PCI_INTA,
+		IRQ_NSLU2_PCI_INTB,
+		IRQ_NSLU2_PCI_INTC,
+	};
+
+	int irq = -1;
+
+	if (slot >= 1 && slot <= NSLU2_PCI_MAX_DEV &&
+		pin >= 1 && pin <= NSLU2_PCI_IRQ_LINES) {
+			irq = pci_irq_table[
+				(slot + pin - 2) % NSLU2_PCI_IRQ_LINES];
+	}
+
+	return irq;
+}
+
+struct hw_pci __initdata nslu2_pci = {
+	.nr_controllers = 1,
+	.preinit	= nslu2_pci_preinit,
+	.swizzle	= pci_std_swizzle,
+	.setup		= ixp4xx_setup,
+	.scan		= ixp4xx_scan_bus,
+	.map_irq	= nslu2_map_irq,
+};
+
+int __init nslu2_pci_init(void) /* monkey see, monkey do */
+{
+	if (machine_is_nslu2())
+		pci_common_init(&nslu2_pci);
+
+	return 0;
+}
+
+subsys_initcall(nslu2_pci_init);
--- linux-2.6.13/.pc/50-nslu2-arch.patch/arch/arm/mach-ixp4xx/nslu2-power.c	2005-10-26 15:19:43.171472071 -0700
+++ linux-2.6.13/arch/arm/mach-ixp4xx/nslu2-power.c	2005-10-26 15:23:39.646352497 -0700
@@ -0,0 +1,92 @@
+/*
+ * arch/arm/mach-ixp4xx/nslu2-power.c
+ *
+ * NSLU2 Power/Reset driver
+ *
+ * Copyright (C) 2005 Tower Technologies
+ *
+ * based on nslu2-io.c  
+ *  Copyright (C) 2004 Karen Spearel
+ *
+ * Author: Alessandro Zummo <a.zummo@towertech.it>
+ * Maintainers: http://www.nslu2-linux.org/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/reboot.h>
+#include <linux/interrupt.h>
+
+#include <asm/mach-types.h>
+
+static irqreturn_t nslu2_power_handler(int irq, void *dev_id, struct pt_regs *regs)
+{
+	/* Signal init to do the ctrlaltdel action */
+	kill_proc(1, SIGINT, 1);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t nslu2_reset_handler(int irq, void *dev_id, struct pt_regs *regs)
+{
+	/* FIXME This doesn't reset the NSLU2. It powers it off.
+	 * Close enough, since reset is unreliable
+	 */
+
+	machine_power_off();
+
+	return IRQ_HANDLED;
+}
+
+static int __init nslu2_power_init(void)
+{
+	if (!(machine_is_nslu2()))
+		return 0;
+
+	printk(KERN_INFO "NSLU2: power/reset\n");
+
+	*IXP4XX_GPIO_GPISR = 0x20400000;	/* read the 2 irqs to clr */
+
+	set_irq_type(NSLU2_RB_IRQ, IRQT_LOW);
+	set_irq_type(NSLU2_PB_IRQ, IRQT_HIGH);
+
+	gpio_line_isr_clear(NSLU2_RB_GPIO);
+	gpio_line_isr_clear(NSLU2_PB_GPIO);
+
+	if (request_irq(NSLU2_RB_IRQ, &nslu2_reset_handler,
+		SA_INTERRUPT, "NSLU2 reset button", NULL) < 0) {
+
+		printk(KERN_DEBUG "Reset Button IRQ %d not available\n",
+			NSLU2_RB_IRQ);
+
+		return -EIO;
+	}
+
+	if (request_irq(NSLU2_PB_IRQ, &nslu2_power_handler,
+		SA_INTERRUPT, "NSLU2 power button", NULL) < 0) {
+
+		printk(KERN_DEBUG "Power Button IRQ %d not available\n",
+			NSLU2_PB_IRQ);
+
+		return -EIO;	
+	}
+
+	return 0;
+}
+
+static void __exit nslu2_power_exit(void)
+{
+	free_irq(NSLU2_RB_IRQ, NULL);
+	free_irq(NSLU2_PB_IRQ, NULL);
+}
+
+module_init(nslu2_power_init);
+module_exit(nslu2_power_exit);
+
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
+MODULE_DESCRIPTION("NSLU2 Power/Reset driver");
+MODULE_LICENSE("GPL");
--- linux-2.6.13/.pc/50-nslu2-arch.patch/arch/arm/mach-ixp4xx/nslu2-setup.c	2005-10-26 15:19:43.171472071 -0700
+++ linux-2.6.13/arch/arm/mach-ixp4xx/nslu2-setup.c	2005-10-26 15:23:39.646352497 -0700
@@ -0,0 +1,134 @@
+/*
+ * arch/arm/mach-ixp4xx/nslu2-setup.c
+ *
+ * NSLU2 board-setup
+ *
+ * based ixdp425-setup.c:
+ *      Copyright (C) 2003-2004 MontaVista Software, Inc.
+ *
+ * Author: Mark Rakes <mrakes at mac.com>
+ * Maintainers: http://www.nslu2-linux.org/
+ *
+ * Fixed missing init_time in MACHINE_START kas11 10/22/04
+ * Changed to conform to new style __init ixdp425 kas11 10/22/04 
+ */
+
+#include <linux/kernel.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/flash.h>
+
+static struct flash_platform_data nslu2_flash_data = {
+	.map_name		= "cfi_probe",
+	.width			= 2,
+};
+
+static struct resource nslu2_flash_resource = {
+	.start			= NSLU2_FLASH_BASE,
+	.end			= NSLU2_FLASH_BASE + NSLU2_FLASH_SIZE,
+	.flags			= IORESOURCE_MEM,
+};
+
+static struct platform_device nslu2_flash = {
+	.name			= "IXP4XX-Flash",
+	.id			= 0,
+	.dev.platform_data	= &nslu2_flash_data,
+	.num_resources		= 1,
+	.resource		= &nslu2_flash_resource,
+};
+
+static struct ixp4xx_i2c_pins nslu2_i2c_gpio_pins = {
+	.sda_pin		= NSLU2_SDA_PIN,
+	.scl_pin		= NSLU2_SCL_PIN,
+};
+
+static struct platform_device nslu2_i2c_controller = {
+	.name			= "IXP4XX-I2C",
+	.id			= 0,
+	.dev.platform_data	= &nslu2_i2c_gpio_pins,
+	.num_resources		= 0
+};
+
+static struct resource nslu2_uart_resources[] = {
+	{
+		.start		= IXP4XX_UART1_BASE_PHYS,
+		.end		= IXP4XX_UART1_BASE_PHYS + 0x0fff,
+		.flags		= IORESOURCE_MEM
+	},
+	{
+		.start		= IXP4XX_UART2_BASE_PHYS,
+		.end		= IXP4XX_UART2_BASE_PHYS + 0x0fff,
+		.flags		= IORESOURCE_MEM
+	}
+};
+
+static struct plat_serial8250_port nslu2_uart_data[] = {
+	{
+		.mapbase	= IXP4XX_UART1_BASE_PHYS,
+		.membase	= (char *)IXP4XX_UART1_BASE_VIRT + REG_OFFSET,
+		.irq		= IRQ_IXP4XX_UART1,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= IXP4XX_UART_XTAL,
+	},
+	{
+		.mapbase	= IXP4XX_UART2_BASE_PHYS,
+		.membase	= (char *)IXP4XX_UART2_BASE_VIRT + REG_OFFSET,
+		.irq		= IRQ_IXP4XX_UART2,
+		.flags		= UPF_BOOT_AUTOCONF,
+		.iotype		= UPIO_MEM,
+		.regshift	= 2,
+		.uartclk	= IXP4XX_UART_XTAL,
+	},
+	{ }
+};
+
+static struct platform_device nslu2_uart = {
+	.name			= "serial8250",
+	.id			= PLAT8250_DEV_PLATFORM,
+	.dev.platform_data	= nslu2_uart_data,
+	.num_resources		= 2,
+	.resource		= nslu2_uart_resources
+};
+
+static struct platform_device *nslu2_devices[] __initdata = {
+	&nslu2_i2c_controller,
+	&nslu2_flash,
+	&nslu2_uart
+};
+
+static void nslu2_power_off(void)
+{
+        /* This causes the box to drop the power and go dead. */
+
+	/* enable the pwr cntl gpio */
+	gpio_line_config(NSLU2_PO_GPIO, IXP4XX_GPIO_OUT);
+
+	/* do the deed */
+	gpio_line_set(NSLU2_PO_GPIO, IXP4XX_GPIO_HIGH);
+}
+
+static void __init nslu2_init(void)
+{
+	ixp4xx_sys_init();
+
+	pm_power_off = nslu2_power_off;
+
+	platform_add_devices(nslu2_devices, ARRAY_SIZE(nslu2_devices));
+}
+
+MACHINE_START(NSLU2, "Linksys NSLU2")
+	/* Maintainer: www.nslu2-linux.org */
+	.phys_ram	= PHYS_OFFSET,
+	.phys_io	= IXP4XX_PERIPHERAL_BASE_PHYS,
+	.io_pg_offst	= ((IXP4XX_PERIPHERAL_BASE_VIRT) >> 18) & 0xFFFC,
+	.boot_params	= 0x00000100,
+	.map_io		= ixp4xx_map_io,
+	.init_irq	= ixp4xx_init_irq, /* FIXME: all irq are off here */
+        .timer          = &ixp4xx_timer,
+	.init_machine	= nslu2_init,
+MACHINE_END
--- linux-2.6.13/.pc/50-nslu2-arch.patch/include/asm-arm/arch-ixp4xx/hardware.h	2005-10-26 15:19:37.451112111 -0700
+++ linux-2.6.13/include/asm-arm/arch-ixp4xx/hardware.h	2005-10-26 15:23:39.650352748 -0700
@@ -44,5 +44,6 @@ extern unsigned int processor_id;
 #include "ixdp425.h"
 #include "coyote.h"
 #include "prpmc1100.h"
+#include "nslu2.h"
 
 #endif  /* _ASM_ARCH_HARDWARE_H */
--- linux-2.6.13/.pc/50-nslu2-arch.patch/include/asm-arm/arch-ixp4xx/irqs.h	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13/include/asm-arm/arch-ixp4xx/irqs.h	2005-10-26 15:23:39.650352748 -0700
@@ -93,4 +93,11 @@
 #define	IRQ_COYOTE_PCI_SLOT1	IRQ_IXP4XX_GPIO11
 #define	IRQ_COYOTE_IDE		IRQ_IXP4XX_GPIO5
 
+/*
+ * NSLU2 board IRQs
+ */
+#define        IRQ_NSLU2_PCI_INTA      IRQ_IXP4XX_GPIO11
+#define        IRQ_NSLU2_PCI_INTB      IRQ_IXP4XX_GPIO10
+#define        IRQ_NSLU2_PCI_INTC      IRQ_IXP4XX_GPIO9
+
 #endif
--- linux-2.6.13/.pc/50-nslu2-arch.patch/include/asm-arm/arch-ixp4xx/nslu2.h	2005-10-26 15:19:43.175472322 -0700
+++ linux-2.6.13/include/asm-arm/arch-ixp4xx/nslu2.h	2005-10-26 15:23:39.650352748 -0700
@@ -0,0 +1,96 @@
+/*
+ * include/asm-arm/arch-ixp4xx/nslu2.h
+ *
+ * NSLU2 platform specific definitions
+ *
+ * Author: Mark Rakes <mrakes AT mac.com>
+ * Maintainers: http://www.nslu2-linux.org
+ *
+ * based on ixdp425.h:
+ *	Copyright 2004 (c) MontaVista, Software, Inc.
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARCH_HARDWARE_H__
+#error "Do not include this directly, instead #include <asm/hardware.h>"
+#endif
+
+#define NSLU2_FLASH_BASE	IXP4XX_EXP_BUS_CS0_BASE_PHYS
+#define NSLU2_FLASH_SIZE	IXP4XX_EXP_BUS_CSX_REGION_SIZE
+
+#define NSLU2_SDA_PIN		7
+#define NSLU2_SCL_PIN		6
+
+/*
+ * NSLU2 PCI IRQs
+ */
+#define NSLU2_PCI_MAX_DEV	3
+#define NSLU2_PCI_IRQ_LINES	3
+
+
+/* PCI controller GPIO to IRQ pin mappings */
+#define NSLU2_PCI_INTA_PIN	11
+#define NSLU2_PCI_INTB_PIN	10
+#define NSLU2_PCI_INTC_PIN	9
+#define NSLU2_PCI_INTD_PIN	8
+
+
+/* NSLU2 Timer */
+#define NSLU2_FREQ 66000000
+#define NSLU2_CLOCK_TICK_RATE (((NSLU2_FREQ / HZ & ~IXP4XX_OST_RELOAD_MASK) + 1) * HZ)
+#define NSLU2_CLOCK_TICKS_PER_USEC ((NSLU2_CLOCK_TICK_RATE + USEC_PER_SEC/2) / USEC_PER_SEC)
+
+/* GPIO */
+
+#define NSLU2_GPIO0		0
+#define NSLU2_GPIO1		1
+#define NSLU2_GPIO2		2
+#define NSLU2_GPIO3		3
+#define NSLU2_GPIO4		4
+#define NSLU2_GPIO5		5
+#define NSLU2_GPIO6		6
+#define NSLU2_GPIO7		7
+#define NSLU2_GPIO8		8
+#define NSLU2_GPIO9		9
+#define NSLU2_GPIO10		10
+#define NSLU2_GPIO11		11
+#define NSLU2_GPIO12		12
+#define NSLU2_GPIO13		13
+#define NSLU2_GPIO14		14
+#define NSLU2_GPIO15		15
+
+/* Buttons */
+
+#define NSLU2_PB_GPIO		NSLU2_GPIO5
+#define NSLU2_PO_GPIO		NSLU2_GPIO8	/* power off */
+#define NSLU2_RB_GPIO		NSLU2_GPIO12
+
+#define NSLU2_PB_IRQ		IRQ_IXP4XX_GPIO5
+#define NSLU2_RB_IRQ		IRQ_IXP4XX_GPIO12
+
+#define NSLU2_PB_BM		(1L << NSLU2_PB_GPIO)
+#define NSLU2_PO_BM		(1L << NSLU2_PO_GPIO)
+#define NSLU2_RB_BM		(1L << NSLU2_RB_GPIO)
+
+/* Buzzer */
+
+#define NSLU2_GPIO_BUZZ		4
+#define NSLU2_BZ_BM		(1L << NSLU2_GPIO_BUZZ)
+/* LEDs */
+
+#define NSLU2_LED_RED		NSLU2_GPIO0
+#define NSLU2_LED_GRN		NSLU2_GPIO1
+
+#define NSLU2_LED_RED_BM	(1L << NSLU2_LED_RED)
+#define NSLU2_LED_GRN_BM	(1L << NSLU2_LED_GRN)
+
+#define NSLU2_LED_DISK1		NSLU2_GPIO2
+#define NSLU2_LED_DISK2		NSLU2_GPIO3
+
+#define NSLU2_LED_DISK1_BM	(1L << NSLU2_GPIO2)
+#define NSLU2_LED_DISK2_BM	(1L << NSLU2_GPIO3)
+
+

