Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbVIIRQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbVIIRQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbVIIRQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:16:25 -0400
Received: from tim.rpsys.net ([194.106.48.114]:40880 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1030270AbVIIRQA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:16:00 -0400
Subject: [-mm patch 3/6] SharpSL: Abstract c7x0 specifics from Corgi
	Touchscreen driver
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 09 Sep 2005 18:15:38 +0100
Message-Id: <1126286139.8383.61.camel@localhost.localdomain>
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

Signed-Off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.13/drivers/input/touchscreen/corgi_ts.c
===================================================================
--- linux-2.6.13.orig/drivers/input/touchscreen/corgi_ts.c	2005-09-09 16:48:00.000000000 +0100
+++ linux-2.6.13/drivers/input/touchscreen/corgi_ts.c	2005-09-09 16:49:16.000000000 +0100
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
+	struct corgits_machinfo *machinfo;
 };
 
-#define STATUS_HSYNC		(GPLR(CORGI_GPIO_HSYNC) & GPIO_bit(CORGI_GPIO_HSYNC))
-
-#define SyncHS()	while((STATUS_HSYNC) == 0); while((STATUS_HSYNC) != 0);
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
 
-static unsigned long calc_waittime(void)
+static unsigned long calc_waittime(struct corgi_ts *corgi_ts)
 {
-	unsigned long hsync_len = w100fb_get_hsynclen(&corgifb_device.dev);
+	unsigned long hsync_len = corgi_ts->machinfo->get_hsync_len();
 
 	if (hsync_len)
 		return get_clk_frequency_khz(0)*1000/hsync_len;
@@ -79,7 +83,8 @@
 		return 0;
 }
 
-static int sync_receive_data_send_cmd(int doRecive, int doSend, unsigned int address, unsigned long wait_time)
+static int sync_receive_data_send_cmd(struct corgi_ts *corgi_ts, int doRecive, int doSend, 
+		unsigned int address, unsigned long wait_time)
 {
 	unsigned long timer1 = 0, timer2, pmnc = 0;
 	int pos = 0;
@@ -90,7 +95,7 @@
 			PMNC_SET(0x01);
 
 		/* polling HSync */
-		SyncHS();
+		corgi_ts->machinfo->wait_hsync();
 		/* get CCNT */
 		CCNT(timer1);
 	}
@@ -109,7 +114,7 @@
 			CCNT(timer2);
 			if (timer2-timer1 > wait_time) {
 				/* too slow - timeout, try again */
-				SyncHS();
+				corgi_ts->machinfo->wait_hsync();
 				/* get OSCR */
 				CCNT(timer1);
 				/* Wait after HSync */
@@ -133,23 +138,23 @@
 	/* critical section */
 	local_irq_save(flags);
 	corgi_ssp_ads7846_lock();
-	wait_time=calc_waittime();
+	wait_time = calc_waittime(corgi_ts);
 
 	/* Y-axis */
-	sync_receive_data_send_cmd(0, 1, 1u, wait_time);
+	sync_receive_data_send_cmd(corgi_ts, 0, 1, 1u, wait_time);
 
 	/* Y-axis */
-	sync_receive_data_send_cmd(1, 1, 1u, wait_time);
+	sync_receive_data_send_cmd(corgi_ts, 1, 1, 1u, wait_time);
 
 	/* X-axis */
-	y = sync_receive_data_send_cmd(1, 1, 5u, wait_time);
+	y = sync_receive_data_send_cmd(corgi_ts, 1, 1, 5u, wait_time);
 
 	/* Z1 */
-	x = sync_receive_data_send_cmd(1, 1, 3u, wait_time);
+	x = sync_receive_data_send_cmd(corgi_ts, 1, 1, 3u, wait_time);
 
 	/* Z2 */
-	z1 = sync_receive_data_send_cmd(1, 1, 4u, wait_time);
-	z2 = sync_receive_data_send_cmd(1, 0, 4u, wait_time);
+	z1 = sync_receive_data_send_cmd(corgi_ts, 1, 1, 4u, wait_time);
+	z2 = sync_receive_data_send_cmd(corgi_ts, 1, 0, 4u, wait_time);
 
 	/* Power-Down Enable */
 	corgi_ssp_ads7846_put((1u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
@@ -189,9 +194,9 @@
 
 static void ts_interrupt_main(struct corgi_ts *corgi_ts, int isTimer, struct pt_regs *regs)
 {
-	if ((GPLR(CORGI_GPIO_TP_INT) & GPIO_bit(CORGI_GPIO_TP_INT)) == 0) {
+	if ((GPLR(IRQ_TO_GPIO(corgi_ts->irq_gpio)) & GPIO_bit(IRQ_TO_GPIO(corgi_ts->irq_gpio))) == 0) {
 		/* Disable Interrupt */
-		set_irq_type(CORGI_IRQ_GPIO_TP_INT, IRQT_NOEDGE);
+		set_irq_type(corgi_ts->irq_gpio, IRQT_NOEDGE);
 		if (read_xydata(corgi_ts)) {
 			corgi_ts->pendown = 1;
 			new_data(corgi_ts, regs);
@@ -210,7 +215,7 @@
 		}
 
 		/* Enable Falling Edge */
-		set_irq_type(CORGI_IRQ_GPIO_TP_INT, IRQT_FALLING);
+		set_irq_type(corgi_ts->irq_gpio, IRQT_FALLING);
 		corgi_ts->pendown = 0;
 	}
 }
@@ -254,7 +259,7 @@
 
 		corgi_ssp_ads7846_putget((4u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
 		/* Enable Falling Edge */
-		set_irq_type(CORGI_IRQ_GPIO_TP_INT, IRQT_FALLING);
+		set_irq_type(corgi_ts->irq_gpio, IRQT_FALLING);
 		corgi_ts->power_mode = PWR_MODE_ACTIVE;
 	}
 	return 0;
@@ -267,6 +272,7 @@
 static int __init corgits_probe(struct device *dev)
 {
 	struct corgi_ts *corgi_ts;
+	struct platform_device *pdev = to_platform_device(dev);
 
 	if (!(corgi_ts = kmalloc(sizeof(struct corgi_ts), GFP_KERNEL)))
 		return -ENOMEM;
@@ -275,6 +281,14 @@
 
 	memset(corgi_ts, 0, sizeof(struct corgi_ts));
 
+	corgi_ts->machinfo = dev->platform_data;
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
@@ -293,8 +307,7 @@
 	corgi_ts->input.id.product = 0x0002;
 	corgi_ts->input.id.version = 0x0100;
 
-	pxa_gpio_mode(CORGI_GPIO_TP_INT | GPIO_IN);
-	pxa_gpio_mode(CORGI_GPIO_HSYNC | GPIO_IN);
+	pxa_gpio_mode(IRQ_TO_GPIO(corgi_ts->irq_gpio) | GPIO_IN);
 
 	/* Initiaize ADS7846 Difference Reference mode */
 	corgi_ssp_ads7846_putget((1u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
@@ -313,14 +326,14 @@
 	input_register_device(&corgi_ts->input);
 	corgi_ts->power_mode = PWR_MODE_ACTIVE;
 
-	if (request_irq(CORGI_IRQ_GPIO_TP_INT, ts_interrupt, SA_INTERRUPT, "ts", corgi_ts)) {
+	if (request_irq(corgi_ts->irq_gpio, ts_interrupt, SA_INTERRUPT, "ts", corgi_ts)) {
 		input_unregister_device(&corgi_ts->input);
 		kfree(corgi_ts);
 		return -EBUSY;
 	}
 
 	/* Enable Falling Edge */
-	set_irq_type(CORGI_IRQ_GPIO_TP_INT, IRQT_FALLING);
+	set_irq_type(corgi_ts->irq_gpio, IRQT_FALLING);
 
 	printk(KERN_INFO "input: Corgi Touchscreen Registered\n");
 
@@ -331,8 +344,9 @@
 {
 	struct corgi_ts *corgi_ts = dev_get_drvdata(dev);
 
-	free_irq(CORGI_IRQ_GPIO_TP_INT, NULL);
+	free_irq(corgi_ts->irq_gpio, NULL);
 	del_timer_sync(&corgi_ts->timer);
+	corgi_ts->machinfo->put_hsync();
 	input_unregister_device(&corgi_ts->input);
 	kfree(corgi_ts);
 	return 0;
Index: linux-2.6.13/drivers/input/touchscreen/Kconfig
===================================================================
--- linux-2.6.13.orig/drivers/input/touchscreen/Kconfig	2005-09-09 16:48:00.000000000 +0100
+++ linux-2.6.13/drivers/input/touchscreen/Kconfig	2005-09-09 17:00:33.000000000 +0100
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
Index: linux-2.6.13/arch/arm/mach-pxa/corgi.c
===================================================================
--- linux-2.6.13.orig/arch/arm/mach-pxa/corgi.c	2005-09-09 16:48:00.000000000 +0100
+++ linux-2.6.13/arch/arm/mach-pxa/corgi.c	2005-09-09 17:03:11.000000000 +0100
@@ -130,12 +130,29 @@
 /*
  * Corgi Touch Screen Device
  */
+static struct resource corgits_resources[] = {
+	[0] = {
+		.start		= CORGI_IRQ_GPIO_TP_INT,
+		.end		= CORGI_IRQ_GPIO_TP_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct corgits_machinfo  corgi_ts_machinfo = {
+	.get_hsync_len   = corgi_get_hsync_len,
+	.put_hsync       = corgi_put_hsync,
+	.wait_hsync      = corgi_wait_hsync,
+};
+
 static struct platform_device corgits_device = {
 	.name		= "corgi-ts",
 	.dev		= {
  		.parent = &corgissp_device.dev,
+		.platform_data	= &corgi_ts_machinfo,
 	},
 	.id		= -1,
+	.num_resources	= ARRAY_SIZE(corgits_resources),
+	.resource	= corgits_resources,
 };
 
 
@@ -257,6 +274,7 @@
 	corgi_ssp_set_machinfo(&corgi_ssp_machinfo);
 
 	pxa_gpio_mode(CORGI_GPIO_USB_PULLUP | GPIO_OUT);
+	pxa_gpio_mode(CORGI_GPIO_HSYNC | GPIO_IN);
  	pxa_set_udc_info(&udc_info);
 	pxa_set_mci_info(&corgi_mci_platform_data);
 
Index: linux-2.6.13/include/video/w100fb.h
===================================================================
--- linux-2.6.13.orig/include/video/w100fb.h	2005-09-09 16:48:00.000000000 +0100
+++ linux-2.6.13/include/video/w100fb.h	2005-09-09 16:49:16.000000000 +0100
@@ -19,6 +19,7 @@
 
 unsigned long w100fb_gpio_read(int port);
 void w100fb_gpio_write(int port, unsigned long value);
+unsigned long w100fb_get_hsynclen(struct device *dev);
 
 /* LCD Specific Routines and Config */
 struct w100_tg_info {


