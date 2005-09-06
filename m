Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbVIFLyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVIFLyI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 07:54:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVIFLyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 07:54:08 -0400
Received: from tim.rpsys.net ([194.106.48.114]:61847 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S964825AbVIFLyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 07:54:03 -0400
Subject: [-mm patch 4/5] SharpSL: Abstract model specifics from Corgi
	Backlight driver
From: Richard Purdie <rpurdie@rpsys.net>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Content-Type: text/plain
Date: Tue, 06 Sep 2005 12:53:51 +0100
Message-Id: <1126007631.8338.129.camel@localhost.localdomain>
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

Index: linux-2.6.12/drivers/video/backlight/corgi_bl.c
===================================================================
--- linux-2.6.12.orig/drivers/video/backlight/corgi_bl.c	2005-08-28 10:01:39.000000000 +0100
+++ linux-2.6.12/drivers/video/backlight/corgi_bl.c	2005-08-28 17:45:17.000000000 +0100
@@ -19,10 +19,9 @@
 #include <linux/fb.h>
 #include <linux/backlight.h>
 
-#include <asm/arch-pxa/corgi.h>
-#include <asm/hardware/scoop.h>
+#include <asm/mach-types.h>
+#include <asm/arch/sharpsl.h>
 
-#define CORGI_MAX_INTENSITY 		0x3e
 #define CORGI_DEFAULT_INTENSITY		0x1f
 #define CORGI_LIMIT_MASK			0x0b
 
@@ -30,6 +29,7 @@
 static int current_intensity = 0;
 static int corgibl_limit = 0;
 static DEFINE_SPINLOCK(bl_lock);
+static struct backlight_properties corgibl_data;
 
 static void corgibl_send_intensity(int intensity)
 {
@@ -43,18 +43,10 @@
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
+	corgi_bl_set(intensity);
+
 	spin_unlock_irqrestore(&bl_lock, flags);
 }
 
@@ -113,8 +105,8 @@
 
 static int corgibl_set_intensity(struct backlight_device *bd, int intensity)
 {
-	if (intensity > CORGI_MAX_INTENSITY)
-		intensity = CORGI_MAX_INTENSITY;
+	if (intensity > corgibl_data.max_brightness)
+		intensity = corgibl_data.max_brightness;
 	corgibl_send_intensity(intensity);
 	current_intensity=intensity;
 	return 0;
@@ -141,7 +133,6 @@
 	.owner		= THIS_MODULE,
 	.get_power      = corgibl_get_power,
 	.set_power      = corgibl_set_power,
-	.max_brightness = CORGI_MAX_INTENSITY,
 	.get_brightness = corgibl_get_intensity,
 	.set_brightness = corgibl_set_intensity,
 };
@@ -150,12 +141,14 @@
 
 static int __init corgibl_probe(struct device *dev)
 {
+	corgibl_data.max_brightness=corgi_bl_max();
 	corgi_backlight_device = backlight_device_register ("corgi-bl",
 		NULL, &corgibl_data);
 	if (IS_ERR (corgi_backlight_device))
 		return PTR_ERR (corgi_backlight_device);
 
 	corgibl_set_intensity(NULL, CORGI_DEFAULT_INTENSITY);
+	corgibl_limit_intensity(0);
 
 	printk("Corgi Backlight Driver Initialized.\n");
 	return 0;
Index: linux-2.6.12/arch/arm/mach-pxa/corgi_lcd.c
===================================================================
--- linux-2.6.12.orig/arch/arm/mach-pxa/corgi_lcd.c	2005-08-28 10:01:51.000000000 +0100
+++ linux-2.6.12/arch/arm/mach-pxa/corgi_lcd.c	2005-08-28 17:19:28.000000000 +0100
@@ -467,3 +467,63 @@
 	}
 }
 
+
+/*
+ * Corgi/Spitz Backlight Power
+ */
+int corgi_bl_max(void)
+{
+	if (machine_is_corgi() || machine_is_shepherd() || machine_is_husky()) 
+		return 0x2e;
+	return 0x3e;
+}
+
+void corgi_bl_set(int intensity)
+{
+	if ((machine_is_corgi() || machine_is_shepherd() || machine_is_husky()) 
+			&& (intensity > 0x10))
+		intensity+=0x10;
+
+	/* Skip 0x20 as it will blank the display */
+	if (intensity >= 0x20)
+		intensity++;
+
+	/* Bits 0-4 are accessed via the SSP interface */
+	corgi_ssp_blduty_set(intensity & 0x1f);
+
+	if (machine_is_corgi() || machine_is_shepherd() || machine_is_husky()) {
+#ifdef CONFIG_PXA_SHARP_C7xx
+		/* Bit 5 is via SCOOP */
+		if (intensity & 0x0020)
+			set_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_BACKLIGHT_CONT);
+		else
+			reset_scoop_gpio(&corgiscoop_device.dev, CORGI_SCP_BACKLIGHT_CONT);
+#endif
+	} else if (machine_is_spitz() || machine_is_borzoi()) {
+#if defined(CONFIG_MACH_SPITZ) || defined(CONFIG_MACH_BORZOI)
+		/* Bit 5 is via SCOOP */
+		if (intensity & 0x0020)
+			reset_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_BACKLIGHT_CONT);
+		else
+			set_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_BACKLIGHT_CONT);
+
+		if (intensity) 
+			set_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_BACKLIGHT_ON);
+		else
+			reset_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_BACKLIGHT_ON);
+#endif
+	} else if (machine_is_akita()) {
+#ifdef CONFIG_MACH_AKITA
+		/* Bit 5 is via IO-Expander */
+		if (intensity & 0x0020)
+			akita_reset_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_BACKLIGHT_CONT);
+		else
+			akita_set_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_BACKLIGHT_CONT);
+
+		if (intensity) 
+			akita_set_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_BACKLIGHT_ON);
+		else
+			akita_reset_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_BACKLIGHT_ON);
+#endif
+	}
+}
Index: linux-2.6.12/include/asm-arm/arch-pxa/sharpsl.h
===================================================================
--- linux-2.6.12.orig/include/asm-arm/arch-pxa/sharpsl.h	2005-08-28 10:01:51.000000000 +0100
+++ linux-2.6.12/include/asm-arm/arch-pxa/sharpsl.h	2005-08-28 16:23:02.000000000 +0100
@@ -18,3 +18,9 @@
 unsigned long corgi_get_hsync_len(void);
 void corgi_wait_hsync(void);
 
+/* 
+ * SharpSL Backlight 
+ */
+
+int corgi_bl_max(void);
+void corgi_bl_set(int intensity);

