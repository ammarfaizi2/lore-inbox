Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262118AbVG0JyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbVG0JyL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 05:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVG0JyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 05:54:11 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27321 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262134AbVG0Jxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 05:53:37 -0400
Date: Wed, 27 Jul 2005 11:53:24 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu, linux-kernel@vger.kernel.org
Subject: [patch] Support powering sharp zaurus sl-5500 LCD up and down
Message-ID: <20050727095324.GE4270@elf.ucw.cz>
References: <20050727092613.GA4713@elf.ucw.cz> <20050727023754.6846f3a2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050727023754.6846f3a2.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for powering Zaurus's video up and down. PDA
without screen is kind of useless, so it is quite important... I'll
have to figure out how to really control the frontlight, because LCD
without that is quite hard to read.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_LCD_CLASS_DEVICE)     += lcd.o
 obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE) += backlight.o
 obj-$(CONFIG_BACKLIGHT_CORGI)	+= corgi_bl.o
+obj-$(CONFIG_SHARP_LOCOMO)	+= locomolcd.o
diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
new file mode 100644
--- /dev/null
+++ b/drivers/video/backlight/locomolcd.c
@@ -0,0 +1,157 @@
+/*
+ * Backlight control code for Sharp Zaurus SL-5500
+ *
+ * Copyright 2005 John Lenz <lenz@cs.wisc.edu>
+ * Maintainer: Pavel Machek <pavel@suse.cz> (unless John wants to :-)
+ * GPL v2
+ *
+ * This driver assumes single CPU. That's okay, because collie is
+ * slightly old hardware, and noone is going to retrofit second CPU to
+ * old PDA.
+ */
+
+/* LCD power functions */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+
+#include <asm/hardware/locomo.h>
+#include <asm/irq.h>
+
+#ifdef CONFIG_SA1100_COLLIE
+#include <asm/arch/collie.h>
+#else
+#include <asm/arch/poodle.h>
+#endif
+
+extern void (*sa1100fb_lcd_power)(int on);
+
+static struct locomo_dev *locomolcd_dev = NULL;
+
+static void locomolcd_on(int comadj)
+{
+	locomo_gpio_set_dir(locomolcd_dev, LOCOMO_GPIO_LCD_VSHA_ON, 0);
+	locomo_gpio_write(locomolcd_dev, LOCOMO_GPIO_LCD_VSHA_ON, 1);
+	mdelay(2);
+	
+	locomo_gpio_set_dir(locomolcd_dev, LOCOMO_GPIO_LCD_VSHD_ON, 0);
+	locomo_gpio_write(locomolcd_dev, LOCOMO_GPIO_LCD_VSHD_ON, 1);
+	mdelay(2);
+
+	locomo_m62332_senddata(locomolcd_dev, comadj, 0);
+	mdelay(5);
+	
+	locomo_gpio_set_dir(locomolcd_dev, LOCOMO_GPIO_LCD_VEE_ON, 0);
+	locomo_gpio_write(locomolcd_dev, LOCOMO_GPIO_LCD_VEE_ON, 1);
+	mdelay(10);
+
+	/* TFTCRST | CPSOUT=0 | CPSEN */
+	locomo_writel(0x01, locomolcd_dev->mapbase + LOCOMO_TC);
+
+	/* Set CPSD */
+	locomo_writel(6, locomolcd_dev->mapbase + LOCOMO_CPSD);
+
+	/* TFTCRST | CPSOUT=0 | CPSEN */
+	locomo_writel((0x04 | 0x01), locomolcd_dev->mapbase + LOCOMO_TC);
+	mdelay(10);
+
+	locomo_gpio_set_dir(locomolcd_dev, LOCOMO_GPIO_LCD_MOD, 0);
+	locomo_gpio_write(locomolcd_dev, LOCOMO_GPIO_LCD_MOD, 1);
+}
+
+static void locomolcd_off(int comadj)
+{
+	/* TFTCRST=1 | CPSOUT=1 | CPSEN = 0 */
+	locomo_writel(0x06, locomolcd_dev->mapbase + LOCOMO_TC);
+	mdelay(1);
+
+	locomo_gpio_write(locomolcd_dev, LOCOMO_GPIO_LCD_VSHA_ON, 0);
+	mdelay(110);
+
+	locomo_gpio_write(locomolcd_dev, LOCOMO_GPIO_LCD_VEE_ON, 0);
+	mdelay(700);
+
+	/* TFTCRST=0 | CPSOUT=0 | CPSEN = 0 */
+	locomo_writel(0, locomolcd_dev->mapbase + LOCOMO_TC); 
+	locomo_gpio_write(locomolcd_dev, LOCOMO_GPIO_LCD_MOD, 0);
+	locomo_gpio_write(locomolcd_dev, LOCOMO_GPIO_LCD_VSHD_ON, 0);
+}
+
+void locomolcd_power(int on)
+{
+	int comadj = 118;
+	unsigned long flags;
+	
+	local_irq_save(flags);
+	
+	if (!locomolcd_dev) {
+		local_irq_restore(flags);
+		return;
+	}
+
+	/* read comadj */
+#ifdef CONFIG_MACH_POODLE
+	comadj = 118;
+#else
+	comadj = 128;
+#endif
+
+	if (on)
+		locomolcd_on(comadj);
+	else
+		locomolcd_off(comadj);
+
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(locomolcd_power);
+
+static int poodle_lcd_probe(struct locomo_dev *dev)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	locomolcd_dev = dev;
+
+	/* the poodle_lcd_power function is called for the first time
+	 * from fs_initcall, which is before locomo is activated.
+	 * We need to recall poodle_lcd_power here*/
+#ifdef CONFIG_MACH_POODLE
+	locomolcd_power(1);
+#endif
+	local_irq_restore(flags);
+	return 0;
+}
+
+static int poodle_lcd_remove(struct locomo_dev *dev)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	locomolcd_dev = NULL;
+	local_irq_restore(flags);
+	return 0;
+}
+
+static struct locomo_driver poodle_lcd_driver = {
+	.drv = {
+		.name = "locomo-backlight",
+	},
+	.devid	= LOCOMO_DEVID_BACKLIGHT,
+	.probe	= poodle_lcd_probe,
+	.remove	= poodle_lcd_remove,
+};
+
+static int __init poodle_lcd_init(void)
+{
+	int ret = locomo_driver_register(&poodle_lcd_driver);
+	if (ret) return ret;
+	
+#ifdef CONFIG_SA1100_COLLIE
+	sa1100fb_lcd_power = locomolcd_power;
+#endif
+	return 0;
+}
+device_initcall(poodle_lcd_init);
+

-- 
teflon -- maybe it is a trademark, but it should not be.
