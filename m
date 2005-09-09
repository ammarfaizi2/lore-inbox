Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbVIIRP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbVIIRP4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 13:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030269AbVIIRPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 13:15:55 -0400
Received: from tim.rpsys.net ([194.106.48.114]:37296 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1030268AbVIIRPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 13:15:55 -0400
Subject: [-mm patch 4/6] SharpSL: Abstract model specifics from Corgi
	Backlight driver
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 09 Sep 2005 18:15:40 +0100
Message-Id: <1126286140.8383.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Separate out the Sharp Zaurus c7x0 series specific code from the Corgi
backlight driver. Abstract model/machine specific functions to
corgi_lcd.c via sharpsl.h 

This enables the driver to be used by the Zaurus cxx00 series.

Signed-Off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.13/drivers/video/backlight/corgi_bl.c
===================================================================
--- linux-2.6.13.orig/drivers/video/backlight/corgi_bl.c	2005-09-09 15:54:24.000000000 +0100
+++ linux-2.6.13/drivers/video/backlight/corgi_bl.c	2005-09-09 15:57:33.000000000 +0100
@@ -19,17 +19,18 @@
 #include <linux/fb.h>
 #include <linux/backlight.h>
 
-#include <asm/arch-pxa/corgi.h>
-#include <asm/hardware/scoop.h>
+#include <asm/mach-types.h>
+#include <asm/arch/sharpsl.h>
 
-#define CORGI_MAX_INTENSITY 		0x3e
 #define CORGI_DEFAULT_INTENSITY		0x1f
-#define CORGI_LIMIT_MASK			0x0b
+#define CORGI_LIMIT_MASK		0x0b
 
 static int corgibl_powermode = FB_BLANK_UNBLANK;
 static int current_intensity = 0;
 static int corgibl_limit = 0;
+static void (*corgibl_mach_set_intensity)(int intensity);
 static DEFINE_SPINLOCK(bl_lock);
+static struct backlight_properties corgibl_data;
 
 static void corgibl_send_intensity(int intensity)
 {
@@ -43,18 +44,10 @@
 			intensity &= CORGI_LIMIT_MASK;
 	}
 
-	/* Skip 0x20 as it will blank the display */
-	if (intensity >= 0x20)
-		intensity++;
-
 	spin_lock_irqsave(&bl_lock, flags);
-	/* Bits 0-4 are accessed via the SSP interface */
-	corgi_ssp_blduty_set(intensity & 0x1f);
-	/* Bit 5 is via SCOOP */
-	if (intensity & 0x0020)
-		set_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_BACKLIGHT_CONT);
-	else
-		reset_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_BACKLIGHT_CONT);
+
+	corgibl_mach_set_intensity(intensity);
+
 	spin_unlock_irqrestore(&bl_lock, flags);
 }
 
@@ -113,8 +106,8 @@
 
 static int corgibl_set_intensity(struct backlight_device *bd, int intensity)
 {
-	if (intensity > CORGI_MAX_INTENSITY)
-		intensity = CORGI_MAX_INTENSITY;
+	if (intensity > corgibl_data.max_brightness)
+		intensity = corgibl_data.max_brightness;
 	corgibl_send_intensity(intensity);
 	current_intensity=intensity;
 	return 0;
@@ -141,7 +134,6 @@
 	.owner		= THIS_MODULE,
 	.get_power      = corgibl_get_power,
 	.set_power      = corgibl_set_power,
-	.max_brightness = CORGI_MAX_INTENSITY,
 	.get_brightness = corgibl_get_intensity,
 	.set_brightness = corgibl_set_intensity,
 };
@@ -150,12 +142,18 @@
 
 static int __init corgibl_probe(struct device *dev)
 {
+	struct corgibl_machinfo *machinfo = dev->platform_data;
+
+	corgibl_data.max_brightness = machinfo->max_intensity;
+	corgibl_mach_set_intensity = machinfo->set_bl_intensity;
+
 	corgi_backlight_device = backlight_device_register ("corgi-bl",
 		NULL, &corgibl_data);
 	if (IS_ERR (corgi_backlight_device))
 		return PTR_ERR (corgi_backlight_device);
 
 	corgibl_set_intensity(NULL, CORGI_DEFAULT_INTENSITY);
+	corgibl_limit_intensity(0);
 
 	printk("Corgi Backlight Driver Initialized.\n");
 	return 0;
Index: linux-2.6.13/arch/arm/mach-pxa/corgi_lcd.c
===================================================================
--- linux-2.6.13.orig/arch/arm/mach-pxa/corgi_lcd.c	2005-09-09 15:54:24.000000000 +0100
+++ linux-2.6.13/arch/arm/mach-pxa/corgi_lcd.c	2005-09-09 15:55:11.000000000 +0100
@@ -497,3 +497,68 @@
 	sharpsl_wait_sync(SPITZ_GPIO_HSYNC);
 }
 #endif
+
+/*
+ * Corgi/Spitz Backlight Power
+ */
+#ifdef CONFIG_PXA_SHARP_C7xx
+void corgi_bl_set_intensity(int intensity)
+{
+	if (intensity > 0x10)
+		intensity += 0x10;
+
+	/* Bits 0-4 are accessed via the SSP interface */
+	corgi_ssp_blduty_set(intensity & 0x1f);
+
+	/* Bit 5 is via SCOOP */
+	if (intensity & 0x0020)
+		set_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_BACKLIGHT_CONT);
+	else
+		reset_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_BACKLIGHT_CONT);
+}
+#endif
+
+
+#if defined(CONFIG_MACH_SPITZ) || defined(CONFIG_MACH_BORZOI)
+void spitz_bl_set_intensity(int intensity)
+{
+	if (intensity > 0x10)
+		intensity += 0x10;
+
+	/* Bits 0-4 are accessed via the SSP interface */
+	corgi_ssp_blduty_set(intensity & 0x1f);
+
+	/* Bit 5 is via SCOOP */
+	if (intensity & 0x0020)
+		reset_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_BACKLIGHT_CONT);
+	else
+		set_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_BACKLIGHT_CONT);
+
+	if (intensity)
+		set_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_BACKLIGHT_ON);
+	else
+		reset_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_BACKLIGHT_ON);
+}
+#endif
+
+#ifdef CONFIG_MACH_AKITA
+void akita_bl_set_intensity(int intensity)
+{
+	if (intensity > 0x10)
+		intensity += 0x10;
+
+	/* Bits 0-4 are accessed via the SSP interface */
+	corgi_ssp_blduty_set(intensity & 0x1f);
+
+	/* Bit 5 is via IO-Expander */
+	if (intensity & 0x0020)
+		akita_reset_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_BACKLIGHT_CONT);
+	else
+		akita_set_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_BACKLIGHT_CONT);
+
+	if (intensity)
+		akita_set_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_BACKLIGHT_ON);
+	else
+		akita_reset_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_BACKLIGHT_ON);
+}
+#endif
Index: linux-2.6.13/include/asm-arm/arch-pxa/sharpsl.h
===================================================================
--- linux-2.6.13.orig/include/asm-arm/arch-pxa/sharpsl.h	2005-09-09 15:54:24.000000000 +0100
+++ linux-2.6.13/include/asm-arm/arch-pxa/sharpsl.h	2005-09-09 15:55:11.000000000 +0100
@@ -20,3 +20,13 @@
 	void (*put_hsync)(void);
 	void (*wait_hsync)(void);
 };
+
+/*
+ * SharpSL Backlight
+ */
+
+struct corgibl_machinfo {
+	int max_intensity;
+	void (*set_bl_intensity)(int intensity);
+};
+
Index: linux-2.6.13/arch/arm/mach-pxa/corgi.c
===================================================================
--- linux-2.6.13.orig/arch/arm/mach-pxa/corgi.c	2005-09-09 15:55:11.000000000 +0100
+++ linux-2.6.13/arch/arm/mach-pxa/corgi.c	2005-09-09 15:57:37.000000000 +0100
@@ -109,10 +109,16 @@
 /*
  * Corgi Backlight Device
  */
+static struct corgibl_machinfo corgi_bl_machinfo = {
+	.max_intensity = 0x2f,
+	.set_bl_intensity = corgi_bl_set_intensity,
+};
+
 static struct platform_device corgibl_device = {
 	.name		= "corgi-bl",
 	.dev		= {
  		.parent = &corgifb_device.dev,
+		.platform_data	= &corgi_bl_machinfo,
 	},
 	.id		= -1,
 };
Index: linux-2.6.13/arch/arm/mach-pxa/sharpsl.h
===================================================================
--- linux-2.6.13.orig/arch/arm/mach-pxa/sharpsl.h	2005-09-09 15:54:49.000000000 +0100
+++ linux-2.6.13/arch/arm/mach-pxa/sharpsl.h	2005-09-09 15:57:37.000000000 +0100
@@ -23,6 +23,14 @@
 void akita_bl_set_intensity(int intensity);
 
 /*
+ * SharpSL Backlight 
+ */
+
+void corgi_bl_set_intensity(int intensity);
+void spitz_bl_set_intensity(int intensity);
+void akita_bl_set_intensity(int intensity);
+
+/*
  * SharpSL Touchscreen Driver
  */
 


