Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750760AbWC3Lqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWC3Lqr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 06:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWC3Lqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 06:46:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32742 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750760AbWC3Lqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 06:46:46 -0500
Date: Thu, 30 Mar 2006 13:46:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>, patches@arm.linux.org.uk
Subject: Hook collie frontlight into sysfs
Message-ID: <20060330114609.GA14505@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hook backlight handling into backlight subsystem, so that backlight is
controllable using /sys . I had to shuffle code around a bit in order
to avoid prototypes.

Signed-off-by: Pavel Machek <pavel@suse.cz>
PATCH FOLLOWS
KernelVersion: 2.6.16-git

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index a7dc137..8c53ebc 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -507,7 +507,7 @@ locomo_init_one_child(struct locomo *lch
 		goto out;
 	}
 
-	strncpy(dev->dev.bus_id,info->name,sizeof(dev->dev.bus_id));
+	strncpy(dev->dev.bus_id, info->name, sizeof(dev->dev.bus_id));
 	/*
 	 * If the parent device has a DMA mask associated with it,
 	 * propagate it down to the children.
@@ -629,21 +629,6 @@ static int locomo_resume(struct platform
 #endif
 
 
-#define LCM_ALC_EN	0x8000
-
-void frontlight_set(struct locomo *lchip, int duty, int vr, int bpwf)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&lchip->lock, flags);
-	locomo_writel(bpwf, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
-	udelay(100);
-	locomo_writel(duty, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
-	locomo_writel(bpwf | LCM_ALC_EN, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
-	spin_unlock_irqrestore(&lchip->lock, flags);
-}
-
-
 /**
  *	locomo_probe - probe for a single LoCoMo chip.
  *	@phys_addr: physical address of device.
@@ -698,14 +683,10 @@ __locomo_probe(struct device *me, struct
 			, lchip->base + LOCOMO_GPD);
 	locomo_writel(0, lchip->base + LOCOMO_GIE);
 
-	/* FrontLight */
+	/* Frontlight */
 	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
 	locomo_writel(0, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
 
-	/* Same constants can be used for collie and poodle
-	   (depending on CONFIG options in original sharp code)? */
-	frontlight_set(lchip, 163, 0, 148);
-
 	/* Longtime timer */
 	locomo_writel(0, lchip->base + LOCOMO_LTINT);
 	/* SPI */
@@ -749,7 +730,6 @@ __locomo_probe(struct device *me, struct
 
 	for (i = 0; i < ARRAY_SIZE(locomo_devices); i++)
 		locomo_init_one_child(lchip, &locomo_devices[i]);
-
 	return 0;
 
  out:
@@ -1063,6 +1043,25 @@ void locomo_m62332_senddata(struct locom
 }
 
 /*
+ *	Frontlight control
+ */
+
+static struct locomo *locomo_chip_driver(struct locomo_dev *ldev);
+
+void locomo_frontlight_set(struct locomo_dev *dev, int duty, int vr, int bpwf)
+{
+	unsigned long flags;
+	struct locomo *lchip = locomo_chip_driver(dev);
+
+	spin_lock_irqsave(&lchip->lock, flags);
+	locomo_writel(bpwf, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
+	udelay(100);
+	locomo_writel(duty, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
+	locomo_writel(bpwf | LOCOMO_ALC_EN, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
+	spin_unlock_irqrestore(&lchip->lock, flags);
+}
+
+/*
  *	LoCoMo "Register Access Bus."
  *
  *	We model this as a regular bus type, and hang devices directly
diff --git a/drivers/video/backlight/locomolcd.c b/drivers/video/backlight/locomolcd.c
index 60831bb..a95cd25 100644
--- a/drivers/video/backlight/locomolcd.c
+++ b/drivers/video/backlight/locomolcd.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/backlight.h>
 
 #include <asm/hardware/locomo.h>
 #include <asm/irq.h>
@@ -105,6 +106,38 @@ void locomolcd_power(int on)
 }
 EXPORT_SYMBOL(locomolcd_power);
 
+
+static int current_intensity;
+
+static int set_intensity(struct backlight_device *bd, int intensity)
+{
+	switch (intensity) {
+	/* AC and non-AC are handled differently, but produce same results in sharp code? */
+	case 0: locomo_frontlight_set(locomolcd_dev, 0, 0, 161); break;
+	case 1: locomo_frontlight_set(locomolcd_dev, 117, 0, 161); break;
+	case 2: locomo_frontlight_set(locomolcd_dev, 163, 0, 148); break;
+	case 3: locomo_frontlight_set(locomolcd_dev, 194, 0, 161); break;
+	case 4: locomo_frontlight_set(locomolcd_dev, 194, 1, 161); break;
+
+	default:
+		locomo_frontlight_set(locomolcd_dev, intensity, 0, 148); break;
+	}
+	current_intensity = intensity;
+	return 0;
+}
+
+static int get_intensity(struct backlight_device *bd)
+{
+	return current_intensity;
+}
+
+static struct backlight_properties locomobl_data = {
+	.owner		= THIS_MODULE,
+	.get_brightness = get_intensity,
+	.set_brightness = set_intensity,
+	.max_brightness = 5,
+};
+
 static int poodle_lcd_probe(struct locomo_dev *dev)
 {
 	unsigned long flags;
@@ -112,6 +145,9 @@ static int poodle_lcd_probe(struct locom
 	local_irq_save(flags);
 	locomolcd_dev = dev;
 
+	/* Set up frontlight so that screen is readable */
+	set_intensity(NULL, 2);
+
 	/* the poodle_lcd_power function is called for the first time
 	 * from fs_initcall, which is before locomo is activated.
 	 * We need to recall poodle_lcd_power here*/
@@ -147,8 +183,13 @@ static int __init poodle_lcd_init(void)
 
 #ifdef CONFIG_SA1100_COLLIE
 	sa1100fb_lcd_power = locomolcd_power;
+
+	backlight_device_register("collie-bl", NULL, &locomobl_data);
 #endif
 	return 0;
 }
 device_initcall(poodle_lcd_init);
 
+MODULE_AUTHOR("John Lenz <lenz@cs.wisc.edu>, Pavel Machek <pavel@suse.cz>");
+MODULE_DESCRIPTION("Collie LCD driver");
+MODULE_LICENSE("GPL");

--- a/include/asm-arm/hardware/locomo.h
+++ b/include/asm-arm/hardware/locomo.h
@@ -203,4 +203,7 @@ void locomo_gpio_write(struct locomo_dev
 /* M62332 control function */
 void locomo_m62332_senddata(struct locomo_dev *ldev, unsigned int dac_data, int channel);
 
+/* Frontlight control */
+void locomo_frontlight_set(struct locomo_dev *dev, int duty, int vr, int bpwf);
+
 #endif

-- 
Picture of sleeping (Linux) penguin wanted...
