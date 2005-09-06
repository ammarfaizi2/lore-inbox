Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVIFLyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVIFLyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 07:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964826AbVIFLyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 07:54:36 -0400
Received: from tim.rpsys.net ([194.106.48.114]:62615 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964827AbVIFLyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 07:54:18 -0400
Subject: [-mm patch 2/5] SharpSL: Add cxx00 support to the Corgi LCD driver
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 12:53:48 +0100
Message-Id: <1126007628.8338.127.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The same LCD is present on both the Sharp Zaurus c7x0 series and the
cxx00 but with different framebuffer drivers (w100fb vs. pxafb). This
patch adds support for the cxx00 series to the LCD driver. It also adds
some LCD to touchscreen interface logic needed by the touchscreen driver
to prevent interference problems, the idea being to keep all the ugly
code in one place leaving the drivers themselves clean. sharpsl.h is
used to provide the abstraction.

Signed-Off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/include/asm-arm/arch-pxa/sharpsl.h
===================================================================
--- linux-2.6.12.orig/include/asm-arm/arch-pxa/sharpsl.h	2005-08-26 11:06:27.000000000 +0100
+++ linux-2.6.12/include/asm-arm/arch-pxa/sharpsl.h	2005-08-27 20:02:57.000000000 +0100
@@ -10,3 +10,11 @@
 void corgi_ssp_lcdtg_send (unsigned char adrs, unsigned char data);
 void corgi_ssp_blduty_set(int duty);
 int corgi_ssp_max1111_get(unsigned long data);
+
+/*
+ * SharpSL LCD Driver 
+ */
+
+unsigned long corgi_get_hsync_len(void);
+void corgi_wait_hsync(void);
+
Index: linux-2.6.12/arch/arm/mach-pxa/corgi_lcd.c
===================================================================
--- linux-2.6.12.orig/arch/arm/mach-pxa/corgi_lcd.c	2005-08-26 11:05:51.000000000 +0100
+++ linux-2.6.12/arch/arm/mach-pxa/corgi_lcd.c	2005-08-27 20:03:39.000000000 +0100
@@ -1,10 +1,14 @@
 /*
  * linux/drivers/video/w100fb.c
  *
- * Corgi LCD Specific Code for ATI Imageon w100 (Wallaby)
+ * Corgi/Spitz LCD Specific Code 
  *
  * Copyright (C) 2005 Richard Purdie
  *
+ * Connectivity:
+ *   Corgi - LCD to ATI Imageon w100 (Wallaby)
+ *   Spitz - LCD to PXA Framebuffer
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -14,9 +18,16 @@
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
+#include <asm/mach-types.h>
+#include <asm/arch/akita.h>
 #include <asm/arch/corgi.h>
+#include <asm/arch/hardware.h>
+#include <asm/arch/pxa-regs.h>
+#include <asm/arch/sharpsl.h>
+#include <asm/arch/spitz.h>
+#include <asm/hardware/scoop.h>
 #include <asm/mach/sharpsl_param.h>
-#include <video/w100fb.h>
+#include "generic.h"
 
 #define RESCTL_ADRS     0x00
 #define PHACTRL_ADRS	0x01
@@ -132,10 +143,10 @@
 }
 
 /* Set Phase Adjuct */
-static void lcdtg_set_phadadj(struct w100fb_par *par)
+static void lcdtg_set_phadadj(int mode)
 {
 	int adj;
-	switch(par->xres) {
+	switch(mode) {
 		case 480:
 		case 640:
 			/* Setting for VGA */
@@ -159,7 +170,7 @@
 
 static int lcd_inited;
 
-static void lcdtg_hw_init(struct w100fb_par *par)
+static void lcdtg_hw_init(int mode)
 {
 	if (!lcd_inited) {
 		int comadj;
@@ -213,7 +224,7 @@
 		corgi_ssp_lcdtg_send(PICTRL_ADRS, 0);
 
 		/* Set Phase Adjuct */
-		lcdtg_set_phadadj(par);
+		lcdtg_set_phadadj(mode);
 
 		/* Initialize for Input Signals from ATI */
 		corgi_ssp_lcdtg_send(POLCTRL_ADRS, POLCTRL_SYNC_POL_RISE | POLCTRL_EN_POL_RISE
@@ -222,10 +233,10 @@
 
 		lcd_inited=1;
 	} else {
-		lcdtg_set_phadadj(par);
+		lcdtg_set_phadadj(mode);
 	}
 
-	switch(par->xres) {
+	switch(mode) {
 		case 480:
 		case 640:
 			/* Set Lcd Resolution (VGA) */
@@ -240,7 +251,7 @@
 	}
 }
 
-static void lcdtg_suspend(struct w100fb_par *par)
+static void lcdtg_suspend(void)
 {
 	/* 60Hz x 2 frame = 16.7msec x 2 = 33.4 msec */
 	mdelay(34);
@@ -274,15 +285,30 @@
 	lcd_inited = 0;
 }
 
-static struct w100_tg_info corgi_lcdtg_info = {
-	.change=lcdtg_hw_init,
-	.suspend=lcdtg_suspend,
-	.resume=lcdtg_hw_init,
-};
 
 /*
  * Corgi w100 Frame Buffer Device
  */
+#ifdef CONFIG_PXA_SHARP_C7xx
+
+#include <video/w100fb.h>
+
+static void w100_lcdtg_suspend(struct w100fb_par *par)
+{
+	lcdtg_suspend();
+}
+
+static void w100_lcdtg_init(struct w100fb_par *par)
+{
+	lcdtg_hw_init(par->xres);
+}
+
+
+static struct w100_tg_info corgi_lcdtg_info = {
+	.change=w100_lcdtg_init,
+	.suspend=w100_lcdtg_suspend,
+	.resume=w100_lcdtg_init,
+};
 
 static struct w100_mem_info corgi_fb_mem = {
 	.ext_cntl          = 0x00040003,
@@ -392,3 +418,52 @@
 	},
 
 };
+#endif
+
+
+/*
+ * Spitz PXA Frame Buffer Device
+ */
+#ifdef CONFIG_PXA_SHARP_Cxx00
+
+#include <asm/arch/pxafb.h>
+
+void spitz_lcd_power(int on) 
+{
+	if (on)
+		lcdtg_hw_init(480);
+	else
+		lcdtg_suspend();
+}
+
+#endif
+
+
+/*
+ * Corgi/Spitz Touchscreen to LCD interface
+ */
+unsigned long inline corgi_get_hsync_len(void) 
+{
+	if (machine_is_corgi() || machine_is_shepherd() || machine_is_husky()) {
+#ifdef CONFIG_PXA_SHARP_C7xx
+		return w100fb_get_hsynclen(&corgifb_device.dev);
+#endif
+	} else if (machine_is_spitz() || machine_is_akita() || machine_is_borzoi()) {
+#ifdef CONFIG_PXA_SHARP_Cxx00
+		return pxafb_get_hsync_time(&pxafb_device.dev);
+#endif
+	}
+	return 0;
+}
+
+#define SyncHS(x)   while((GPLR(x) & GPIO_bit(x)) == 0); while((GPLR(x) & GPIO_bit(x)) != 0);
+
+void inline corgi_wait_hsync(void) 
+{
+	if (machine_is_corgi() || machine_is_shepherd() || machine_is_husky()) {
+		SyncHS(CORGI_GPIO_HSYNC);
+	} else if (machine_is_spitz() || machine_is_akita() || machine_is_borzoi()) {
+		SyncHS(SPITZ_GPIO_HSYNC);
+	}
+}
+


