Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbVIFLya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbVIFLya (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 07:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVIFLyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 07:54:09 -0400
Received: from tim.rpsys.net ([194.106.48.114]:62103 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964826AbVIFLyF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 07:54:05 -0400
Subject: [-mm patch 3/5] SharpSL: Abstract c7x0 specifics from Corgi
	Touchscreen driver
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 12:53:50 +0100
Message-Id: <1126007630.8338.128.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Separate out the Sharp Zaurus c7x0 series specific code from the Corgi
Touchscreen driver. Use the new functions in corgi_lcd.c via sharpsl.h
for hsync handling and pass the IRQ as a platform device resource. Move
a function prototype into the w100fb header file where it belongs.

This enables the driver to be used by the Zaurus cxx00 series.

Index: linux-2.6.12/drivers/input/touchscreen/corgi_ts.c
===================================================================
--- linux-2.6.12.orig/drivers/input/touchscreen/corgi_ts.c	2005-08-26 11:07:37.000000000 +0100
+++ linux-2.6.12/drivers/input/touchscreen/corgi_ts.c	2005-08-26 11:08:49.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- *  Touchscreen driver for Sharp Corgi models (SL-C7xx)
+ *  Touchscreen driver for Sharp SL-C7xx and SL-Cxx00 models
  *
  *  Copyright (c) 2004-2005 Richard Purdie
  *
@@ -19,7 +19,7 @@
 #include <linux/slab.h>
 #include <asm/irq.h>
 
-#include <asm/arch/corgi.h>
+#include <asm/arch/sharpsl.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/pxa-regs.h>
 
@@ -47,15 +47,20 @@
 	struct ts_event tc;
 	int pendown;
 	int power_mode;
+	int irq_gpio;
 };
 
-#define STATUS_HSYNC		(GPLR(CORGI_GPIO_HSYNC) & GPIO_bit(CORGI_GPIO_HSYNC))
-
-#define SyncHS()	while((STATUS_HSYNC) == 0); while((STATUS_HSYNC) != 0);
+#define SyncHS()	corgi_wait_hsync();
+#ifdef CONFIG_PXA25x
 #define CCNT(a)		asm volatile ("mrc p14, 0, %0, C1, C0, 0" : "=r"(a))
 #define PMNC_GET(x)	asm volatile ("mrc p14, 0, %0, C0, C0, 0" : "=r"(x))
 #define PMNC_SET(x)	asm volatile ("mcr p14, 0, %0, C0, C0, 0" : : "r"(x))
-
+#endif
+#ifdef CONFIG_PXA27x
+#define CCNT(a)		asm volatile ("mrc p14, 0, %0, C1, C1, 0" : "=r"(a))
+#define PMNC_GET(x)	asm volatile ("mrc p14, 0, %0, C0, C1, 0" : "=r"(x))
+#define PMNC_SET(x)	asm volatile ("mcr p14, 0, %0, C0, C1, 0" : : "r"(x))
+#endif
 
 /* ADS7846 Touch Screen Controller bit definitions */
 #define ADSCTRL_PD0		(1u << 0)	/* PD0 */
@@ -66,12 +71,11 @@
 #define ADSCTRL_STS		(1u << 7)	/* Start Bit */
 
 /* External Functions */
-extern unsigned long w100fb_get_hsynclen(struct device *dev);
 extern unsigned int get_clk_frequency_khz(int info);
 
 static unsigned long calc_waittime(void)
 {
-	unsigned long hsync_len = w100fb_get_hsynclen(&corgifb_device.dev);
+	unsigned long hsync_len = corgi_get_hsync_len();
 
 	if (hsync_len)
 		return get_clk_frequency_khz(0)*1000/hsync_len;
@@ -189,9 +193,9 @@
 
 static void ts_interrupt_main(struct corgi_ts *corgi_ts, int isTimer, struct pt_regs *regs)
 {
-	if ((GPLR(CORGI_GPIO_TP_INT) & GPIO_bit(CORGI_GPIO_TP_INT)) == 0) {
+	if ((GPLR(corgi_ts->irq_gpio) & GPIO_bit(corgi_ts->irq_gpio)) == 0) {
 		/* Disable Interrupt */
-		set_irq_type(CORGI_IRQ_GPIO_TP_INT, IRQT_NOEDGE);
+		set_irq_type(IRQ_GPIO(corgi_ts->irq_gpio), IRQT_NOEDGE);
 		if (read_xydata(corgi_ts)) {
 			corgi_ts->pendown = 1;
 			new_data(corgi_ts, regs);
@@ -210,7 +214,7 @@
 		}
 
 		/* Enable Falling Edge */
-		set_irq_type(CORGI_IRQ_GPIO_TP_INT, IRQT_FALLING);
+		set_irq_type(IRQ_GPIO(corgi_ts->irq_gpio), IRQT_FALLING);
 		corgi_ts->pendown = 0;
 	}
 }
@@ -254,7 +258,7 @@
 
 		corgi_ssp_ads7846_putget((4u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
 		/* Enable Falling Edge */
-		set_irq_type(CORGI_IRQ_GPIO_TP_INT, IRQT_FALLING);
+		set_irq_type(IRQ_GPIO(corgi_ts->irq_gpio), IRQT_FALLING);
 		corgi_ts->power_mode = PWR_MODE_ACTIVE;
 	}
 	return 0;
@@ -267,6 +271,7 @@
 static int __init corgits_probe(struct device *dev)
 {
 	struct corgi_ts *corgi_ts;
+	struct platform_device *pdev = to_platform_device(dev);
 
 	if (!(corgi_ts = kmalloc(sizeof(struct corgi_ts), GFP_KERNEL)))
 		return -ENOMEM;
@@ -275,6 +280,13 @@
 
 	memset(corgi_ts, 0, sizeof(struct corgi_ts));
 
+	corgi_ts->irq_gpio = platform_get_irq(pdev, 0);
+
+	if (corgi_ts->irq_gpio < 0) {
+		kfree(corgi_ts);
+		return -ENODEV;
+	}
+
 	init_input_dev(&corgi_ts->input);
 	corgi_ts->input.evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);
 	corgi_ts->input.keybit[LONG(BTN_TOUCH)] = BIT(BTN_TOUCH);
@@ -293,8 +305,7 @@
 	corgi_ts->input.id.product = 0x0002;
 	corgi_ts->input.id.version = 0x0100;
 
-	pxa_gpio_mode(CORGI_GPIO_TP_INT | GPIO_IN);
-	pxa_gpio_mode(CORGI_GPIO_HSYNC | GPIO_IN);
+	pxa_gpio_mode(corgi_ts->irq_gpio | GPIO_IN);
 
 	/* Initiaize ADS7846 Difference Reference mode */
 	corgi_ssp_ads7846_putget((1u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
@@ -313,14 +324,14 @@
 	input_register_device(&corgi_ts->input);
 	corgi_ts->power_mode = PWR_MODE_ACTIVE;
 
-	if (request_irq(CORGI_IRQ_GPIO_TP_INT, ts_interrupt, SA_INTERRUPT, "ts", corgi_ts)) {
+	if (request_irq(IRQ_GPIO(corgi_ts->irq_gpio), ts_interrupt, SA_INTERRUPT, "ts", corgi_ts)) {
 		input_unregister_device(&corgi_ts->input);
 		kfree(corgi_ts);
 		return -EBUSY;
 	}
 
 	/* Enable Falling Edge */
-	set_irq_type(CORGI_IRQ_GPIO_TP_INT, IRQT_FALLING);
+	set_irq_type(IRQ_GPIO(corgi_ts->irq_gpio), IRQT_FALLING);
 
 	printk(KERN_INFO "input: Corgi Touchscreen Registered\n");
 
@@ -331,7 +342,7 @@
 {
 	struct corgi_ts *corgi_ts = dev_get_drvdata(dev);
 
-	free_irq(CORGI_IRQ_GPIO_TP_INT, NULL);
+	free_irq(IRQ_GPIO(corgi_ts->irq_gpio), NULL);
 	del_timer_sync(&corgi_ts->timer);
 	input_unregister_device(&corgi_ts->input);
 	kfree(corgi_ts);
Index: linux-2.6.12/drivers/input/touchscreen/Kconfig
===================================================================
--- linux-2.6.12.orig/drivers/input/touchscreen/Kconfig	2005-08-26 11:07:37.000000000 +0100
+++ linux-2.6.12/drivers/input/touchscreen/Kconfig	2005-08-26 11:08:49.000000000 +0100
@@ -24,17 +24,17 @@
 	  module will be called h3600_ts_input.
 
 config TOUCHSCREEN_CORGI
-	tristate "Corgi touchscreen (for Sharp SL-C7xx)"
+	tristate "SharpSL (Corgi and Spitz series) touchscreen driver"
 	depends on PXA_SHARPSL
 	default y	
 	help
 	  Say Y here to enable the driver for the touchscreen on the 
-	  Sharp SL-C7xx series of PDAs.
+	  Sharp SL-C7xx and SL-Cxx00 series of PDAs.
 
 	  If unsure, say N.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called ads7846_ts.
+	  module will be called corgi_ts.
 
 config TOUCHSCREEN_GUNZE
 	tristate "Gunze AHL-51S touchscreen"
Index: linux-2.6.12/arch/arm/mach-pxa/corgi.c
===================================================================
--- linux-2.6.12.orig/arch/arm/mach-pxa/corgi.c	2005-08-26 11:07:37.000000000 +0100
+++ linux-2.6.12/arch/arm/mach-pxa/corgi.c	2005-08-26 11:09:08.000000000 +0100
@@ -130,12 +130,22 @@
 /*
  * Corgi Touch Screen Device
  */
+static struct resource corgits_resources[] = {
+	[0] = {
+		.start		= CORGI_GPIO_TP_INT,
+		.end		= CORGI_GPIO_TP_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
 static struct platform_device corgits_device = {
 	.name		= "corgi-ts",
 	.dev		= {
  		.parent = &corgissp_device.dev,
 	},
 	.id		= -1,
+	.num_resources	= ARRAY_SIZE(corgits_resources),
+	.resource	= corgits_resources,
 };
 
 
@@ -257,6 +267,7 @@
 	corgi_ssp_set_machinfo(&corgi_ssp_machinfo);
 
 	pxa_gpio_mode(CORGI_GPIO_USB_PULLUP | GPIO_OUT);
+	pxa_gpio_mode(CORGI_GPIO_HSYNC | GPIO_IN);
  	pxa_set_udc_info(&udc_info);
 	pxa_set_mci_info(&corgi_mci_platform_data);
 
Index: linux-2.6.12/include/video/w100fb.h
===================================================================
--- linux-2.6.12.orig/include/video/w100fb.h	2005-08-26 11:07:37.000000000 +0100
+++ linux-2.6.12/include/video/w100fb.h	2005-08-26 11:08:49.000000000 +0100
@@ -19,6 +19,7 @@
 
 unsigned long w100fb_gpio_read(int port);
 void w100fb_gpio_write(int port, unsigned long value);
+unsigned long w100fb_get_hsynclen(struct device *dev);
 
 /* LCD Specific Routines and Config */
 struct w100_tg_info {


