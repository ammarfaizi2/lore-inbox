Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWANWns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWANWns (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 17:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbWANWns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 17:43:48 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:62081 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S1751332AbWANWnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 17:43:47 -0500
Date: Sun, 15 Jan 2006 00:43:44 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] video: hp680 backlight driver.
Message-ID: <20060114224344.GA4045@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andriy Skulysh <askulysh@image.kiev.ua>

This adds support for the hp680 backlight, as found
in the hp6xx series of sh devices.

Signed-off-by: Andriy Skulysh <askulysh@image.kiev.ua>
Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 drivers/video/backlight/Kconfig    |    8 +
 drivers/video/backlight/Makefile   |    1 
 drivers/video/backlight/hp680_bl.c |  189 +++++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+)

diff -urN -X exclude linux-2.6.15/drivers/video/backlight/Kconfig sh-2.6.15/drivers/video/backlight/Kconfig
--- linux-2.6.15/drivers/video/backlight/Kconfig	2005-06-20 22:36:44.000000000 +0300
+++ sh-2.6.15/drivers/video/backlight/Kconfig	2006-01-04 00:15:29.000000000 +0200
@@ -50,3 +50,11 @@
 	  If you have a Sharp Zaurus SL-C7xx, say y to enable the
 	  backlight driver.
 
+config BACKLIGHT_HP680
+	tristate "HP Jornada 680 Backlight Driver"
+	depends on BACKLIGHT_DEVICE && SH_HP6XX
+	default y
+	help
+	  If you have a HP Jornada 680, say y to enable the
+	  backlight driver.
+
diff -urN -X exclude linux-2.6.15/drivers/video/backlight/Makefile sh-2.6.15/drivers/video/backlight/Makefile
--- linux-2.6.15/drivers/video/backlight/Makefile	2005-11-12 20:17:54.000000000 +0200
+++ sh-2.6.15/drivers/video/backlight/Makefile	2006-01-04 00:15:29.000000000 +0200
@@ -3,4 +3,5 @@
 obj-$(CONFIG_LCD_CLASS_DEVICE)     += lcd.o
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += backlight.o
 obj-$(CONFIG_BACKLIGHT_CORGI)	+= corgi_bl.o
+obj-$(CONFIG_BACKLIGHT_HP680)	+= hp680_bl.o
 obj-$(CONFIG_SHARP_LOCOMO)	+= locomolcd.o

diff -urN -X exclude linux-2.6.15/drivers/video/backlight/hp680_bl.c sh-2.6.15/drivers/video/backlight/hp680_bl.c
--- linux-2.6.15/drivers/video/backlight/hp680_bl.c	1970-01-01 02:00:00.000000000 +0200
+++ sh-2.6.15/drivers/video/backlight/hp680_bl.c	2006-01-04 00:15:29.000000000 +0200
@@ -0,0 +1,189 @@
+/*
+ *  Backlight Driver for HP Jornada 680
+ *
+ *  Copyright (c) 2005 Andriy Skulysh 
+ *
+ *  Based on Sharp's Corgi Backlight Driver
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/spinlock.h>
+#include <linux/fb.h>
+#include <linux/backlight.h>
+
+#include <asm/cpu/dac.h>
+#include <asm/hp6xx/hp6xx.h>
+#include <asm/hd64461/hd64461.h>
+
+#define HP680_MAX_INTENSITY 255
+#define HP680_DEFAULT_INTENSITY 10
+
+static int hp680bl_powermode = FB_BLANK_UNBLANK;
+static int current_intensity = 0;
+static spinlock_t bl_lock = SPIN_LOCK_UNLOCKED;
+
+static void hp680bl_send_intensity(int intensity)
+{
+	unsigned long flags;
+
+	if (hp680bl_powermode != FB_BLANK_UNBLANK)
+		intensity = 0;
+
+	spin_lock_irqsave(&bl_lock, flags);
+	sh_dac_output(255-(u8)intensity, DAC_LCD_BRIGHTNESS);
+	spin_unlock_irqrestore(&bl_lock, flags);
+}
+
+static void hp680bl_blank(int blank)
+{
+	u16 v;
+	
+	switch(blank) {
+
+	case FB_BLANK_NORMAL:
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
+	case FB_BLANK_POWERDOWN:
+		if (hp680bl_powermode == FB_BLANK_UNBLANK) {
+			hp680bl_send_intensity(0);
+			hp680bl_powermode = blank;
+			sh_dac_disable(DAC_LCD_BRIGHTNESS);
+			v = inw(HD64461_GPBDR);
+			v |= HD64461_GPBDR_LCDOFF;
+			outw(v, HD64461_GPBDR);
+		}
+		break;
+	case FB_BLANK_UNBLANK:
+		if (hp680bl_powermode != FB_BLANK_UNBLANK) {
+			sh_dac_enable(DAC_LCD_BRIGHTNESS);
+			v = inw(HD64461_GPBDR);
+			v &= ~HD64461_GPBDR_LCDOFF;
+			outw(v, HD64461_GPBDR);
+			hp680bl_powermode = blank;
+			hp680bl_send_intensity(current_intensity);
+		}
+		break;
+	}
+}
+
+#ifdef CONFIG_PM
+static int hp680bl_suspend(struct device *dev, pm_message_t state, u32 level)
+{
+	if (level == SUSPEND_POWER_DOWN)
+		hp680bl_blank(FB_BLANK_POWERDOWN);
+	return 0;
+}
+
+static int hp680bl_resume(struct device *dev, u32 level)
+{
+	if (level == RESUME_POWER_ON)
+		hp680bl_blank(FB_BLANK_UNBLANK);
+	return 0;
+}
+#else
+#define hp680bl_suspend	NULL
+#define hp680bl_resume	NULL
+#endif
+
+
+static int hp680bl_set_power(struct backlight_device *bd, int state)
+{
+	hp680bl_blank(state);
+	return 0;
+}
+
+static int hp680bl_get_power(struct backlight_device *bd)
+{
+	return hp680bl_powermode;
+}
+
+static int hp680bl_set_intensity(struct backlight_device *bd, int intensity)
+{
+	if (intensity > HP680_MAX_INTENSITY)
+		intensity = HP680_MAX_INTENSITY;
+	hp680bl_send_intensity(intensity);
+	current_intensity = intensity;
+	return 0;
+}
+
+static int hp680bl_get_intensity(struct backlight_device *bd)
+{
+	return current_intensity;
+}
+
+static struct backlight_properties hp680bl_data = {
+	.owner		= THIS_MODULE,
+	.get_power      = hp680bl_get_power,
+	.set_power      = hp680bl_set_power,
+	.max_brightness = HP680_MAX_INTENSITY,
+	.get_brightness = hp680bl_get_intensity,
+	.set_brightness = hp680bl_set_intensity,
+};
+
+static struct backlight_device *hp680_backlight_device;
+
+static int __init hp680bl_probe(struct device *dev)
+{
+	hp680_backlight_device = backlight_device_register ("hp680-bl",
+		NULL, &hp680bl_data);
+	if (IS_ERR (hp680_backlight_device))
+		return PTR_ERR (hp680_backlight_device);
+
+	hp680bl_set_intensity(NULL, HP680_DEFAULT_INTENSITY);
+
+	return 0;
+}
+
+static int hp680bl_remove(struct device *dev)
+{
+	backlight_device_unregister(hp680_backlight_device);
+
+	return 0;
+}
+
+static struct device_driver hp680bl_driver = {
+	.name		= "hp680-bl",
+	.bus		= &platform_bus_type,
+	.probe		= hp680bl_probe,
+	.remove		= hp680bl_remove,
+	.suspend	= hp680bl_suspend,
+	.resume		= hp680bl_resume,
+};
+
+static struct platform_device hp680bl_device = {
+	.name	= "hp680-bl",
+	.id	= -1,
+};
+
+static int __init hp680bl_init(void)
+{
+	int ret;
+	
+	ret=driver_register(&hp680bl_driver);
+	if (!ret) {
+		ret = platform_device_register(&hp680bl_device);
+		if (ret)
+			driver_unregister(&hp680bl_driver);
+	}
+	return ret;
+}
+
+static void __exit hp680bl_exit(void)
+{
+	platform_device_unregister(&hp680bl_device);
+ 	driver_unregister(&hp680bl_driver);
+}
+
+module_init(hp680bl_init);
+module_exit(hp680bl_exit);
+
+MODULE_AUTHOR("Andriy Skulysh <askulysh@image.kiev.ua>");
+MODULE_DESCRIPTION("HP Jornada 680 Backlight Driver");
+MODULE_LICENSE("GPL");
