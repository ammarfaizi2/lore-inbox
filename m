Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVIFLyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVIFLyd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 07:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVIFLyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 07:54:11 -0400
Received: from tim.rpsys.net ([194.106.48.114]:62359 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964827AbVIFLyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 07:54:06 -0400
Subject: [-mm patch 1/5] SharpSL: Abstract c7x0 specifics from Corgi SSP
	driver
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 12:53:46 +0100
Message-Id: <1126007627.8338.126.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Separate out the Sharp Zaurus c7x0 series specific code from corgi_ssp.c
so that other models such as the cxx00's can share it. Create sharpsl.h
which will be used to abstract machine/model specifics. 

This enables the driver to be used by the Zaurus cxx00 series.

Signed-Off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/arch/arm/mach-pxa/corgi.c
===================================================================
--- linux-2.6.12.orig/arch/arm/mach-pxa/corgi.c	2005-08-26 11:06:27.000000000 +0100
+++ linux-2.6.12/arch/arm/mach-pxa/corgi.c	2005-08-27 20:03:45.000000000 +0100
@@ -41,6 +41,7 @@
 #include <asm/hardware/scoop.h>
 
 #include "generic.h"
+#include "sharpsl.h"
 
 
 /*
@@ -94,6 +95,16 @@
 	.id		= -1,
 };
 
+struct corgissp_machinfo corgi_ssp_machinfo = {
+	.port		= 1,
+	.cs_lcdcon	= CORGI_GPIO_LCDCON_CS,
+	.cs_ads7846	= CORGI_GPIO_ADS7846_CS,
+	.cs_max1111	= CORGI_GPIO_MAX1111_CS,
+	.clk_lcdcon	= 76,
+	.clk_ads7846	= 2,
+	.clk_max1111	= 8,
+};
+
 
 /*
  * Corgi Backlight Device
@@ -243,6 +254,8 @@
 
 static void __init corgi_init(void)
 {
+	corgi_ssp_set_machinfo(&corgi_ssp_machinfo);
+
 	pxa_gpio_mode(CORGI_GPIO_USB_PULLUP | GPIO_OUT);
  	pxa_set_udc_info(&udc_info);
 	pxa_set_mci_info(&corgi_mci_platform_data);
Index: linux-2.6.12/arch/arm/mach-pxa/corgi_ssp.c
===================================================================
--- linux-2.6.12.orig/arch/arm/mach-pxa/corgi_ssp.c	2005-08-26 11:05:52.000000000 +0100
+++ linux-2.6.12/arch/arm/mach-pxa/corgi_ssp.c	2005-08-27 13:23:42.000000000 +0100
@@ -1,7 +1,7 @@
 /*
  *  SSP control code for Sharp Corgi devices
  *
- *  Copyright (c) 2004 Richard Purdie
+ *  Copyright (c) 2004-2005 Richard Purdie
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
@@ -17,14 +17,16 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <asm/hardware.h>
+#include <asm/mach-types.h>
 
 #include <asm/arch/ssp.h>
-#include <asm/arch/corgi.h>
 #include <asm/arch/pxa-regs.h>
+#include "sharpsl.h"
 
 static DEFINE_SPINLOCK(corgi_ssp_lock);
 static struct ssp_dev corgi_ssp_dev;
 static struct ssp_state corgi_ssp_state;
+static struct corgissp_machinfo *ssp_machinfo;
 
 /*
  * There are three devices connected to the SSP interface:
@@ -48,12 +51,12 @@
 	unsigned long ret,flag;
 
 	spin_lock_irqsave(&corgi_ssp_lock, flag);
-	GPCR0 = GPIO_bit(CORGI_GPIO_ADS7846_CS);
+	GPCR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846);
 
 	ssp_write_word(&corgi_ssp_dev,data);
 	ret = ssp_read_word(&corgi_ssp_dev);
 
-	GPSR0 = GPIO_bit(CORGI_GPIO_ADS7846_CS);
+	GPSR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846);
 	spin_unlock_irqrestore(&corgi_ssp_lock, flag);
 
 	return ret;
@@ -66,12 +69,12 @@
 void corgi_ssp_ads7846_lock(void)
 {
 	spin_lock(&corgi_ssp_lock);
-	GPCR0 = GPIO_bit(CORGI_GPIO_ADS7846_CS);
+	GPCR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846);
 }
 
 void corgi_ssp_ads7846_unlock(void)
 {
-	GPSR0 = GPIO_bit(CORGI_GPIO_ADS7846_CS);
+	GPSR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846);
 	spin_unlock(&corgi_ssp_lock);
 }
 
@@ -97,23 +100,27 @@
  */
 unsigned long corgi_ssp_dac_put(ulong data)
 {
-	unsigned long flag;
+	unsigned long flag, sscr1 = SSCR1_SPH;
 
 	spin_lock_irqsave(&corgi_ssp_lock, flag);
-	GPCR0 = GPIO_bit(CORGI_GPIO_LCDCON_CS);
+
+	if (machine_is_spitz() || machine_is_akita() || machine_is_borzoi()) 
+		sscr1 = 0;
 
 	ssp_disable(&corgi_ssp_dev);
-	ssp_config(&corgi_ssp_dev, (SSCR0_Motorola | (SSCR0_DSS & 0x07 )), SSCR1_SPH, 0, SSCR0_SerClkDiv(76));
+	ssp_config(&corgi_ssp_dev, (SSCR0_Motorola | (SSCR0_DSS & 0x07 )), sscr1, 0, SSCR0_SerClkDiv(ssp_machinfo->clk_lcdcon));
 	ssp_enable(&corgi_ssp_dev);
 
+	GPCR(ssp_machinfo->cs_lcdcon) = GPIO_bit(ssp_machinfo->cs_lcdcon);
 	ssp_write_word(&corgi_ssp_dev,data);
 	/* Read null data back from device to prevent SSP overflow */
 	ssp_read_word(&corgi_ssp_dev);
+	GPSR(ssp_machinfo->cs_lcdcon) = GPIO_bit(ssp_machinfo->cs_lcdcon);
 
 	ssp_disable(&corgi_ssp_dev);
-	ssp_config(&corgi_ssp_dev, (SSCR0_National | (SSCR0_DSS & 0x0b )), 0, 0, SSCR0_SerClkDiv(2));
+	ssp_config(&corgi_ssp_dev, (SSCR0_National | (SSCR0_DSS & 0x0b )), 0, 0, SSCR0_SerClkDiv(ssp_machinfo->clk_ads7846));
 	ssp_enable(&corgi_ssp_dev);
-	GPSR0 = GPIO_bit(CORGI_GPIO_LCDCON_CS);
+	
 	spin_unlock_irqrestore(&corgi_ssp_lock, flag);
 
 	return 0;
@@ -141,9 +148,9 @@
 	int voltage,voltage1,voltage2;
 
 	spin_lock_irqsave(&corgi_ssp_lock, flag);
-	GPCR0 = GPIO_bit(CORGI_GPIO_MAX1111_CS);
+	GPCR(ssp_machinfo->cs_max1111) = GPIO_bit(ssp_machinfo->cs_max1111);
 	ssp_disable(&corgi_ssp_dev);
-	ssp_config(&corgi_ssp_dev, (SSCR0_Motorola | (SSCR0_DSS & 0x07 )), 0, 0, SSCR0_SerClkDiv(8));
+	ssp_config(&corgi_ssp_dev, (SSCR0_Motorola | (SSCR0_DSS & 0x07 )), 0, 0, SSCR0_SerClkDiv(ssp_machinfo->clk_max1111));
 	ssp_enable(&corgi_ssp_dev);
 
 	udelay(1);
@@ -161,9 +168,9 @@
 	voltage2=ssp_read_word(&corgi_ssp_dev);
 
 	ssp_disable(&corgi_ssp_dev);
-	ssp_config(&corgi_ssp_dev, (SSCR0_National | (SSCR0_DSS & 0x0b )), 0, 0, SSCR0_SerClkDiv(2));
+	ssp_config(&corgi_ssp_dev, (SSCR0_National | (SSCR0_DSS & 0x0b )), 0, 0, SSCR0_SerClkDiv(ssp_machinfo->clk_ads7846));
 	ssp_enable(&corgi_ssp_dev);
-	GPSR0 = GPIO_bit(CORGI_GPIO_MAX1111_CS);
+	GPSR(ssp_machinfo->cs_max1111) = GPIO_bit(ssp_machinfo->cs_max1111);
 	spin_unlock_irqrestore(&corgi_ssp_lock, flag);
 
 	if (voltage1 & 0xc0 || voltage2 & 0x3f)
@@ -179,25 +186,31 @@
 /*
  *  Support Routines
  */
-int __init corgi_ssp_probe(struct device *dev)
+
+void __init corgi_ssp_set_machinfo(struct corgissp_machinfo *machinfo)
+{
+	ssp_machinfo=machinfo;
+}
+
+static int __init corgi_ssp_probe(struct device *dev)
 {
 	int ret;
 
 	/* Chip Select - Disable All */
-	GPDR0 |= GPIO_bit(CORGI_GPIO_LCDCON_CS); /* output */
-	GPSR0 = GPIO_bit(CORGI_GPIO_LCDCON_CS);  /* High - Disable LCD Control/Timing Gen */
-	GPDR0 |= GPIO_bit(CORGI_GPIO_MAX1111_CS); /* output */
-	GPSR0 = GPIO_bit(CORGI_GPIO_MAX1111_CS);  /* High - Disable MAX1111*/
-	GPDR0 |= GPIO_bit(CORGI_GPIO_ADS7846_CS);  /* output */
-	GPSR0 = GPIO_bit(CORGI_GPIO_ADS7846_CS);   /* High - Disable ADS7846*/
+	GPDR(ssp_machinfo->cs_lcdcon) |= GPIO_bit(ssp_machinfo->cs_lcdcon); /* output */
+	GPSR(ssp_machinfo->cs_lcdcon) = GPIO_bit(ssp_machinfo->cs_lcdcon);  /* High - Disable LCD Control/Timing Gen */
+	GPDR(ssp_machinfo->cs_max1111) |= GPIO_bit(ssp_machinfo->cs_max1111); /* output */
+	GPSR(ssp_machinfo->cs_max1111) = GPIO_bit(ssp_machinfo->cs_max1111);  /* High - Disable MAX1111*/
+	GPDR(ssp_machinfo->cs_ads7846) |= GPIO_bit(ssp_machinfo->cs_ads7846);  /* output */
+	GPSR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846);   /* High - Disable ADS7846*/
 
-	ret=ssp_init(&corgi_ssp_dev,1);
+	ret=ssp_init(&corgi_ssp_dev,ssp_machinfo->port);
 
 	if (ret)
 		printk(KERN_ERR "Unable to register SSP handler!\n");
 	else {
 		ssp_disable(&corgi_ssp_dev);
-		ssp_config(&corgi_ssp_dev, (SSCR0_National | (SSCR0_DSS & 0x0b )), 0, 0, SSCR0_SerClkDiv(2));
+		ssp_config(&corgi_ssp_dev, (SSCR0_National | (SSCR0_DSS & 0x0b )), 0, 0, SSCR0_SerClkDiv(ssp_machinfo->clk_ads7846));
 		ssp_enable(&corgi_ssp_dev);
 	}
 
@@ -222,9 +235,9 @@
 static int corgi_ssp_resume(struct device *dev, u32 level)
 {
 	if (level == RESUME_POWER_ON) {
-		GPSR0 = GPIO_bit(CORGI_GPIO_LCDCON_CS);  /* High - Disable LCD Control/Timing Gen */
-		GPSR0 = GPIO_bit(CORGI_GPIO_MAX1111_CS); /* High - Disable MAX1111*/
-		GPSR0 = GPIO_bit(CORGI_GPIO_ADS7846_CS); /* High - Disable ADS7846*/
+		GPSR(ssp_machinfo->cs_lcdcon) = GPIO_bit(ssp_machinfo->cs_lcdcon);  /* High - Disable LCD Control/Timing Gen */
+		GPSR(ssp_machinfo->cs_max1111) = GPIO_bit(ssp_machinfo->cs_max1111); /* High - Disable MAX1111*/
+		GPSR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846); /* High - Disable ADS7846*/
 		ssp_restore_state(&corgi_ssp_dev,&corgi_ssp_state);
 		ssp_enable(&corgi_ssp_dev);
 	}
Index: linux-2.6.12/arch/arm/mach-pxa/sharpsl.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12/arch/arm/mach-pxa/sharpsl.h	2005-08-27 19:58:43.000000000 +0100
@@ -0,0 +1,16 @@
+/* 
+ * SharpSL SSP Driver
+ */
+
+struct corgissp_machinfo {
+	int port;
+	int cs_lcdcon;
+	int cs_ads7846;
+	int cs_max1111;
+	int clk_lcdcon;
+	int clk_ads7846;
+	int clk_max1111;
+};
+
+void corgi_ssp_set_machinfo(struct corgissp_machinfo *machinfo);
+
Index: linux-2.6.12/include/asm-arm/arch-pxa/corgi.h
===================================================================
--- linux-2.6.12.orig/include/asm-arm/arch-pxa/corgi.h	2005-08-26 11:05:52.000000000 +0100
+++ linux-2.6.12/include/asm-arm/arch-pxa/corgi.h	2005-08-27 19:57:45.000000000 +0100
@@ -106,17 +106,5 @@
 extern struct platform_device corgissp_device;
 extern struct platform_device corgifb_device;
 
-/*
- * External Functions
- */
-extern unsigned long corgi_ssp_ads7846_putget(unsigned long);
-extern unsigned long corgi_ssp_ads7846_get(void);
-extern void corgi_ssp_ads7846_put(unsigned long data);
-extern void corgi_ssp_ads7846_lock(void);
-extern void corgi_ssp_ads7846_unlock(void);
-extern void corgi_ssp_lcdtg_send (unsigned char adrs, unsigned char data);
-extern void corgi_ssp_blduty_set(int duty);
-extern int corgi_ssp_max1111_get(unsigned long data);
-
 #endif /* __ASM_ARCH_CORGI_H  */
 
Index: linux-2.6.12/include/asm-arm/arch-pxa/sharpsl.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.12/include/asm-arm/arch-pxa/sharpsl.h	2005-08-27 20:04:53.000000000 +0100
@@ -0,0 +1,12 @@
+/* 
+ * SharpSL SSP Driver
+ */
+
+unsigned long corgi_ssp_ads7846_putget(unsigned long);
+unsigned long corgi_ssp_ads7846_get(void);
+void corgi_ssp_ads7846_put(unsigned long data);
+void corgi_ssp_ads7846_lock(void);
+void corgi_ssp_ads7846_unlock(void);
+void corgi_ssp_lcdtg_send (unsigned char adrs, unsigned char data);
+void corgi_ssp_blduty_set(int duty);
+int corgi_ssp_max1111_get(unsigned long data);


