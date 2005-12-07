Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbVLGTbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVLGTbf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 14:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbVLGTbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 14:31:35 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:20707 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751391AbVLGTbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 14:31:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=lQ32nNI5E990L+kZ3VwbOCg/BAsWoe6FuV146IdboG56OD/awNbdn2IzaQubhddeZ/gLFdG/ylwHFwKRqmcPiR67h8OYWHto/bvTMEn9v5UyIYtjoWNp6gyFXHu8P62r44Qczfija6ua6mM3ZA0rSiNggEmH7iuA4lNd/OVgi7w=
Message-ID: <808c8e9d0512071131s42e98b1fi4c17a8ef1622ef76@mail.gmail.com>
Date: Wed, 7 Dec 2005 13:31:32 -0600
From: Ben Gardner <gardner.ben@gmail.com>
To: Adrian Bunk <bunk@stusta.de>
Subject: [PATCH 1/3] i386: CS5535 chip support - cpu
Cc: Andrew Morton <akpm@osdl.org>, lm-sensors <lm-sensors@lm-sensors.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051207181234.GF31922@stusta.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3897_10668896.1133983892904"
References: <808c8e9d0512070931k607cd7a9g404d131ded8c014b@mail.gmail.com>
	 <20051207181234.GF31922@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_3897_10668896.1133983892904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Configures the DIVIL component of the AMD CS5535 (Geode companion device).

This patch does the following:
 - verifies the existence of the CS5535 by checking the DIVIL signature
 - configures UART1 as a NS16550A
 - (optionally) enables UART2 and configures it as a NS16550A
 - (optionally) enables the SMBus/I2C interface

Signed-off-by: Ben Gardner <bgardner@wabtec.com>
---

Thanks for the feedback, Adrian.
Attached is a new patch with that error corrected.

Ben

On 12/7/05, Adrian Bunk <bunk@stusta.de> wrote:
> Please use CONFIG_CS5535_{SMB,UART2} in cs5535.c instead of setting
> EXTRA_CFLAGS.

------=_Part_3897_10668896.1133983892904
Content-Type: text/plain; name=cs5535-cpu.patch.txt; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cs5535-cpu.patch.txt"

 arch/i386/Kconfig         |   27 ++++++
 arch/i386/kernel/Makefile |    2 
 arch/i386/kernel/cs5535.c |  190 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)

Index: linux-2.6.15-rc5-mm1/arch/i386/kernel/cs5535.c
===================================================================
--- /dev/null
+++ linux-2.6.15-rc5-mm1/arch/i386/kernel/cs5535.c
@@ -0,0 +1,190 @@
+/**
+ * linux/arch/i386/kernel/cs5535.c
+ *
+ *  Copyright (c) 2005 Ben Gardner <bgardner@wabtec.com>
+ *
+ *  AMD CS5535 Companion Device support (AMD Geode processor).
+ *
+ *  This does early configuration of the UARTs, SMB port, and GPIO.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <asm/msr.h>
+#include <asm/io.h>
+
+
+#define NAME			"cs5535"
+
+MODULE_AUTHOR("Ben Gardner <bgardner@wabtec.com>");
+MODULE_DESCRIPTION("AMD CS5535 Driver");
+MODULE_LICENSE("GPL");
+
+/* GPIO base address (from MSR_LBAR_GPIO; MSR 5140000Ch, bits 15:0) */
+u32 cs5535_gpio_base;
+u32 cs5535_gpio_mask;
+EXPORT_SYMBOL(cs5535_gpio_base);
+EXPORT_SYMBOL(cs5535_gpio_mask);
+
+#define MSR_DIVIL_GLD_CAP	0x51400000
+#define DEVID_DIVIL		0x2DF0
+
+#define MSR_LBAR_SMB		0x5140000B
+#define MSR_LBAR_GPIO		0x5140000C
+
+#define MSR_UART1_CONF		0x5140003a
+#define MSR_UART2_CONF		0x5140003e
+
+#define MSR_DIVIL_LEG_IO	0x51400014
+#define MSR_DIVIL_BALL_OPT	0x51400015
+#define MSR_IRQ_MAPY_H		0x51400021
+
+struct gpio_reg_val {
+	u32 reg;
+	u32 val;
+};
+
+#ifdef CONFIG_CS5535_SMB
+static const struct gpio_reg_val gpio_smb[] __initdata =
+{
+	{ 0x04, 0x0000c000 },		/* enable OUTPUT */
+	{ 0x08, 0x0000c000 },		/* enable OpenDrain */
+	{ 0x10, 0x0000c000 },		/* enable OUT_AUX1 */
+	{ 0x14, 0xc0000000UL },		/* disable OUT_AUX2 */
+	{ 0x20, 0x0000c000 },		/* enable INPUT */
+	{ 0x34, 0x0000c000 },		/* enable IN_AUX1 */
+};
+#endif
+
+/* don't touch GPIO 3 & 4 unless UART2 is enabled */
+#ifdef CONFIG_CS5535_UART2
+#define RMSK	0x03180318
+#else
+#define RMSK	0x03000300
+#endif
+
+static const struct gpio_reg_val gpio_uarts[] __initdata =
+{
+	{ 0x00, 0x03180000 & RMSK },	/* output val */
+	{ 0x04, 0x02080110 & RMSK },	/* output enable */
+	{ 0x08, 0x02080110 & RMSK },	/* open-drain enable */
+	{ 0x0c, 0x03180000 & RMSK },	/* invert output */
+	{ 0x10, 0x02080110 & RMSK },	/* Out-Aux-1 */
+	{ 0x14, 0x03180000 & RMSK },	/* Out-Aux-2 */
+	{ 0x18, 0x03180000 & RMSK },	/* Pull-Up */
+	{ 0x1c, 0x03180000 & RMSK },	/* Pull-Down */
+	{ 0x20, 0x01100208 & RMSK },	/* Input enable */
+	{ 0x24, 0x03180000 & RMSK },	/* invert */
+	{ 0x28, 0x03180000 & RMSK },	/* filter */
+	{ 0x2c, 0x03180000 & RMSK },	/* event-count */
+	{ 0x34, 0x01100208 & RMSK },	/* in-aux1 */
+	{ 0x38, 0x03180000 & RMSK },	/* events */
+	{ 0x40, 0x03180000 & RMSK },	/* Input Pos Edge */
+	{ 0x44, 0x03180000 & RMSK },	/* Input Neg Edge */
+};
+
+static int __init init_cs5535_divil(void)
+{
+	u32 low32;
+	u32 high32;
+	int idx;
+
+	/* Check the DIVIL device ID for validation */
+	rdmsr(MSR_DIVIL_GLD_CAP, low32, high32);
+	if ((high32 != 0) || ((low32 >> 8) != DEVID_DIVIL)) {
+		printk(KERN_WARNING NAME ": DIVIL device not found\n");
+		return -ENODEV;
+	}
+
+	/* Grab the GPIO I/O range */
+	rdmsr(MSR_LBAR_GPIO, low32, high32);
+	cs5535_gpio_base = low32 & 0x0000ff00;
+
+	/* Check the mask and whether GPIO is enabled */
+	if (high32 != 0x0000f001) {
+		/* TODO: enable GPIO IO mappings via LBAR */
+		printk(KERN_WARNING NAME ": GPIO not enabled\n");
+		return -ENODEV;
+	}
+
+	/* GPIO pins 31-29,23 are reserved, 22-16 are used for LPC,
+	 * 9,8 are used for UART1 */
+	cs5535_gpio_mask =  ~0xe0ff0300UL;
+
+#ifdef CONFIG_CS5535_SMB
+	/* GPIO pins 14 & 15 are used for SMBus */
+	cs5535_gpio_mask &= ~0x0000c000UL;
+
+	/* Grab & reserve the SMB I/O range */
+	rdmsr(MSR_LBAR_SMB, low32, high32);
+
+	/* Check the mask and whether SMB is enabled */
+	if (high32 != 0x0000F001) {
+		/* TODO: enable SMB IO mappings via LBAR */
+		printk(KERN_WARNING NAME ": SMBus not enabled\n");
+		return -ENODEV;
+	}
+
+	/* Configure GPIO 14 & 15 to do SMB/ACB/I2C */
+	for (idx = 0; idx < ARRAY_SIZE(gpio_smb); idx++) {
+		outl(gpio_smb[idx].val,
+		     gpio_smb[idx].reg + cs5535_gpio_base);
+	}
+#endif	/* CS5535_SMB */
+
+	/* Configure GPIO to do UART1 and maybe UART2 */
+	for (idx = 0; idx < ARRAY_SIZE(gpio_uarts); idx++) {
+		outl(gpio_uarts[idx].val,
+		     gpio_uarts[idx].reg + cs5535_gpio_base);
+	}
+
+	/* Set UART1 base address to 0x3f8 */
+	rdmsr(MSR_DIVIL_LEG_IO, low32, high32);
+	low32 &= 0xfff8ffffUL;		/* UART1 base IO */
+	low32 |= 0x00070000;		/* 0x3F8 */
+	wrmsr(MSR_DIVIL_LEG_IO, low32, high32);
+
+	/* Set UART1 interrupt to 4 */
+	rdmsr(MSR_IRQ_MAPY_H, low32, high32);
+	low32 &= 0xf0ffffffUL;		/* UART1 is on MAPY-14 */
+	low32 |= 0x04000000;		/* IRQ 4 */
+	wrmsr(MSR_IRQ_MAPY_H, low32, high32);
+
+	/* Set up UART1 as a NS15560A */
+	wrmsr(MSR_UART1_CONF, 0x12, 0);
+
+#ifdef CONFIG_CS5535_UART2
+	/* GPIO pins 3 & 4 are used for UART2 */
+	cs5535_gpio_mask &= ~0x00000018UL;
+
+	/* Set UART2 base address to 0x2f8 */
+	rdmsr(MSR_DIVIL_LEG_IO, low32, high32);
+	low32 &= 0xff8fffffUL;		/* UART2 base IO */
+	low32 |= 0x00500000;		/* 0x2F8 */
+	wrmsr(MSR_DIVIL_LEG_IO, low32, high32);
+
+	/* Set UART1 interrupt to 3 */
+	rdmsr(MSR_IRQ_MAPY_H, low32, high32);
+	low32 &= 0x0fffffffUL;		/* UART2 is on MAPY-15 */
+	low32 |= 0x30000000;		/* IRQ 3 */
+	wrmsr(MSR_IRQ_MAPY_H, low32, high32);
+
+	/* Set up UART2 as a NS15560A */
+	wrmsr(MSR_UART2_CONF, 0x12, 0);
+#endif	/* CS5535_UART2 */
+
+	printk(KERN_INFO NAME ": GPIO=%#x Mask=%#x\n",
+	       cs5535_gpio_base, cs5535_gpio_mask);
+
+	return 0;
+}
+
+subsys_initcall(init_cs5535_divil);
+
Index: linux-2.6.15-rc5-mm1/arch/i386/Kconfig
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/i386/Kconfig
+++ linux-2.6.15-rc5-mm1/arch/i386/Kconfig
@@ -336,6 +336,33 @@ config I8K
 	  Say Y if you intend to run this kernel on a Dell Inspiron 8000.
 	  Say N otherwise.
 
+config CS5535
+	tristate "AMD CS5535 (Geode Companion Device) support"
+	help
+	  This provides basic support for the CS5535 Companion Chip for
+	  the AMD Geode processor.
+
+	  If you don't know what to do here, say N.
+
+config CS5535_SMB
+	bool "Enable CS5535 SMBus/Access.Bus/I2C"
+	depends on CS5535
+	default y
+	help
+	  Choosing this will configure the CS5535 GPIO pins 14 & 15 for SMB.
+	  Select I2C_CS5535 under i2c to build the SMB/I2C driver.
+
+	  Say Y if you intend to use the SMBus.
+
+config CS5535_UART2
+	bool "Enable UART2"
+	depends on CS5535
+	default y
+	help
+	  By default, CS5535 GPIO pins 3 & 4 are configured for DDC.
+
+	  Say Y to configure them as UART2 instead.
+
 config X86_REBOOTFIXUPS
 	bool "Enable X86 board specific fixups for reboot"
 	depends on X86
Index: linux-2.6.15-rc5-mm1/arch/i386/kernel/Makefile
===================================================================
--- linux-2.6.15-rc5-mm1.orig/arch/i386/kernel/Makefile
+++ linux-2.6.15-rc5-mm1/arch/i386/kernel/Makefile
@@ -42,6 +42,8 @@ EXTRA_AFLAGS   := -traditional
 
 obj-$(CONFIG_SCx200)		+= scx200.o
 
+obj-$(CONFIG_CS5535)		+= cs5535.o
+
 # vsyscall.o contains the vsyscall DSO images as __initdata.
 # We must build both images before we can assemble it.
 # Note: kbuild does not track this dependency due to usage of .incbin





------=_Part_3897_10668896.1133983892904--
