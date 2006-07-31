Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbWGaTA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbWGaTA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 15:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030326AbWGaTAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 15:00:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:19089 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030327AbWGaTAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 15:00:24 -0400
Date: Mon, 31 Jul 2006 21:00:22 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] fix aty128_bl_set_power compile warning
Message-ID: <20060731190022.GA5190@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


drivers/video/aty/aty128fb.c:458: warning: 'aty128_bl_set_power' declared 'static' but never defined

Move the whole code block up and remove the static declaration.

Signed-off-by: Olaf Hering <olh@suse.de>

Index: linux-2.6.18-rc3/drivers/video/aty/aty128fb.c
===================================================================
--- linux-2.6.18-rc3.orig/drivers/video/aty/aty128fb.c
+++ linux-2.6.18-rc3/drivers/video/aty/aty128fb.c
@@ -455,7 +455,6 @@ static void do_wait_for_fifo(u16 entries
 static void wait_for_fifo(u16 entries, struct aty128fb_par *par);
 static void wait_for_idle(struct aty128fb_par *par);
 static u32 depth_to_dst(u32 depth);
-static void aty128_bl_set_power(struct fb_info *info, int power);
 
 #define BIOS_IN8(v)  	(readb(bios + (v)))
 #define BIOS_IN16(v) 	(readb(bios + (v)) | \
@@ -765,6 +764,208 @@ static u32 depth_to_dst(u32 depth)
 	return -EINVAL;
 }
 
+/* Backlight */
+#ifdef CONFIG_FB_ATY128_BACKLIGHT
+#define MAX_LEVEL 0xFF
+
+static struct backlight_properties aty128_bl_data;
+
+/* Call with fb_info->bl_mutex held */
+static int aty128_bl_get_level_brightness(struct aty128fb_par *par,
+		int level)
+{
+	struct fb_info *info = pci_get_drvdata(par->pdev);
+	int atylevel;
+
+	/* Get and convert the value */
+	atylevel = MAX_LEVEL -
+		(info->bl_curve[level] * FB_BACKLIGHT_MAX / MAX_LEVEL);
+
+	if (atylevel < 0)
+		atylevel = 0;
+	else if (atylevel > MAX_LEVEL)
+		atylevel = MAX_LEVEL;
+
+	return atylevel;
+}
+
+/* We turn off the LCD completely instead of just dimming the backlight.
+ * This provides greater power saving and the display is useless without
+ * backlight anyway
+ */
+#define BACKLIGHT_LVDS_OFF
+/* That one prevents proper CRT output with LCD off */
+#undef BACKLIGHT_DAC_OFF
+
+/* Call with fb_info->bl_mutex held */
+static int __aty128_bl_update_status(struct backlight_device *bd)
+{
+	struct aty128fb_par *par = class_get_devdata(&bd->class_dev);
+	unsigned int reg = aty_ld_le32(LVDS_GEN_CNTL);
+	int level;
+
+	if (bd->props->power != FB_BLANK_UNBLANK ||
+	    bd->props->fb_blank != FB_BLANK_UNBLANK ||
+	    !par->lcd_on)
+		level = 0;
+	else
+		level = bd->props->brightness;
+
+	reg |= LVDS_BL_MOD_EN | LVDS_BLON;
+	if (level > 0) {
+		reg |= LVDS_DIGION;
+		if (!(reg & LVDS_ON)) {
+			reg &= ~LVDS_BLON;
+			aty_st_le32(LVDS_GEN_CNTL, reg);
+			aty_ld_le32(LVDS_GEN_CNTL);
+			mdelay(10);
+			reg |= LVDS_BLON;
+			aty_st_le32(LVDS_GEN_CNTL, reg);
+		}
+		reg &= ~LVDS_BL_MOD_LEVEL_MASK;
+		reg |= (aty128_bl_get_level_brightness(par, level) << LVDS_BL_MOD_LEVEL_SHIFT);
+#ifdef BACKLIGHT_LVDS_OFF
+		reg |= LVDS_ON | LVDS_EN;
+		reg &= ~LVDS_DISPLAY_DIS;
+#endif
+		aty_st_le32(LVDS_GEN_CNTL, reg);
+#ifdef BACKLIGHT_DAC_OFF
+		aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) & (~DAC_PDWN));
+#endif
+	} else {
+		reg &= ~LVDS_BL_MOD_LEVEL_MASK;
+		reg |= (aty128_bl_get_level_brightness(par, 0) << LVDS_BL_MOD_LEVEL_SHIFT);
+#ifdef BACKLIGHT_LVDS_OFF
+		reg |= LVDS_DISPLAY_DIS;
+		aty_st_le32(LVDS_GEN_CNTL, reg);
+		aty_ld_le32(LVDS_GEN_CNTL);
+		udelay(10);
+		reg &= ~(LVDS_ON | LVDS_EN | LVDS_BLON | LVDS_DIGION);
+#endif
+		aty_st_le32(LVDS_GEN_CNTL, reg);
+#ifdef BACKLIGHT_DAC_OFF
+		aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) | DAC_PDWN);
+#endif
+	}
+
+	return 0;
+}
+
+static int aty128_bl_update_status(struct backlight_device *bd)
+{
+	struct aty128fb_par *par = class_get_devdata(&bd->class_dev);
+	struct fb_info *info = pci_get_drvdata(par->pdev);
+	int ret;
+
+	mutex_lock(&info->bl_mutex);
+	ret = __aty128_bl_update_status(bd);
+	mutex_unlock(&info->bl_mutex);
+
+	return ret;
+}
+
+static int aty128_bl_get_brightness(struct backlight_device *bd)
+{
+	return bd->props->brightness;
+}
+
+static struct backlight_properties aty128_bl_data = {
+	.owner		= THIS_MODULE,
+	.get_brightness	= aty128_bl_get_brightness,
+	.update_status	= aty128_bl_update_status,
+	.max_brightness	= (FB_BACKLIGHT_LEVELS - 1),
+};
+
+static void aty128_bl_set_power(struct fb_info *info, int power)
+{
+	mutex_lock(&info->bl_mutex);
+	up(&info->bl_dev->sem);
+	info->bl_dev->props->power = power;
+	__aty128_bl_update_status(info->bl_dev);
+	down(&info->bl_dev->sem);
+	mutex_unlock(&info->bl_mutex);
+}
+
+static void aty128_bl_init(struct aty128fb_par *par)
+{
+	struct fb_info *info = pci_get_drvdata(par->pdev);
+	struct backlight_device *bd;
+	char name[12];
+
+	/* Could be extended to Rage128Pro LVDS output too */
+	if (par->chip_gen != rage_M3)
+		return;
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+	if (!pmac_has_backlight_type("ati"))
+		return;
+#endif
+
+	snprintf(name, sizeof(name), "aty128bl%d", info->node);
+
+	bd = backlight_device_register(name, par, &aty128_bl_data);
+	if (IS_ERR(bd)) {
+		info->bl_dev = NULL;
+		printk("aty128: Backlight registration failed\n");
+		goto error;
+	}
+
+	mutex_lock(&info->bl_mutex);
+	info->bl_dev = bd;
+	fb_bl_default_curve(info, 0,
+		 63 * FB_BACKLIGHT_MAX / MAX_LEVEL,
+		219 * FB_BACKLIGHT_MAX / MAX_LEVEL);
+	mutex_unlock(&info->bl_mutex);
+
+	up(&bd->sem);
+	bd->props->brightness = aty128_bl_data.max_brightness;
+	bd->props->power = FB_BLANK_UNBLANK;
+	bd->props->update_status(bd);
+	down(&bd->sem);
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+	mutex_lock(&pmac_backlight_mutex);
+	if (!pmac_backlight)
+		pmac_backlight = bd;
+	mutex_unlock(&pmac_backlight_mutex);
+#endif
+
+	printk("aty128: Backlight initialized (%s)\n", name);
+
+	return;
+
+error:
+	return;
+}
+
+static void aty128_bl_exit(struct aty128fb_par *par)
+{
+	struct fb_info *info = pci_get_drvdata(par->pdev);
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+	mutex_lock(&pmac_backlight_mutex);
+#endif
+
+	mutex_lock(&info->bl_mutex);
+	if (info->bl_dev) {
+#ifdef CONFIG_PMAC_BACKLIGHT
+		if (pmac_backlight == info->bl_dev)
+			pmac_backlight = NULL;
+#endif
+
+		backlight_device_unregister(info->bl_dev);
+		info->bl_dev = NULL;
+
+		printk("aty128: Backlight unloaded\n");
+	}
+	mutex_unlock(&info->bl_mutex);
+
+#ifdef CONFIG_PMAC_BACKLIGHT
+	mutex_unlock(&pmac_backlight_mutex);
+#endif
+}
+#endif /* CONFIG_FB_ATY128_BACKLIGHT */
+
 /*
  * PLL informations retreival
  */
@@ -1683,208 +1884,6 @@ static int __devinit aty128fb_setup(char
 }
 #endif  /*  MODULE  */
 
-/* Backlight */
-#ifdef CONFIG_FB_ATY128_BACKLIGHT
-#define MAX_LEVEL 0xFF
-
-static struct backlight_properties aty128_bl_data;
-
-/* Call with fb_info->bl_mutex held */
-static int aty128_bl_get_level_brightness(struct aty128fb_par *par,
-		int level)
-{
-	struct fb_info *info = pci_get_drvdata(par->pdev);
-	int atylevel;
-
-	/* Get and convert the value */
-	atylevel = MAX_LEVEL -
-		(info->bl_curve[level] * FB_BACKLIGHT_MAX / MAX_LEVEL);
-
-	if (atylevel < 0)
-		atylevel = 0;
-	else if (atylevel > MAX_LEVEL)
-		atylevel = MAX_LEVEL;
-
-	return atylevel;
-}
-
-/* We turn off the LCD completely instead of just dimming the backlight.
- * This provides greater power saving and the display is useless without
- * backlight anyway
- */
-#define BACKLIGHT_LVDS_OFF
-/* That one prevents proper CRT output with LCD off */
-#undef BACKLIGHT_DAC_OFF
-
-/* Call with fb_info->bl_mutex held */
-static int __aty128_bl_update_status(struct backlight_device *bd)
-{
-	struct aty128fb_par *par = class_get_devdata(&bd->class_dev);
-	unsigned int reg = aty_ld_le32(LVDS_GEN_CNTL);
-	int level;
-
-	if (bd->props->power != FB_BLANK_UNBLANK ||
-	    bd->props->fb_blank != FB_BLANK_UNBLANK ||
-	    !par->lcd_on)
-		level = 0;
-	else
-		level = bd->props->brightness;
-
-	reg |= LVDS_BL_MOD_EN | LVDS_BLON;
-	if (level > 0) {
-		reg |= LVDS_DIGION;
-		if (!(reg & LVDS_ON)) {
-			reg &= ~LVDS_BLON;
-			aty_st_le32(LVDS_GEN_CNTL, reg);
-			aty_ld_le32(LVDS_GEN_CNTL);
-			mdelay(10);
-			reg |= LVDS_BLON;
-			aty_st_le32(LVDS_GEN_CNTL, reg);
-		}
-		reg &= ~LVDS_BL_MOD_LEVEL_MASK;
-		reg |= (aty128_bl_get_level_brightness(par, level) << LVDS_BL_MOD_LEVEL_SHIFT);
-#ifdef BACKLIGHT_LVDS_OFF
-		reg |= LVDS_ON | LVDS_EN;
-		reg &= ~LVDS_DISPLAY_DIS;
-#endif
-		aty_st_le32(LVDS_GEN_CNTL, reg);
-#ifdef BACKLIGHT_DAC_OFF
-		aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) & (~DAC_PDWN));
-#endif
-	} else {
-		reg &= ~LVDS_BL_MOD_LEVEL_MASK;
-		reg |= (aty128_bl_get_level_brightness(par, 0) << LVDS_BL_MOD_LEVEL_SHIFT);
-#ifdef BACKLIGHT_LVDS_OFF
-		reg |= LVDS_DISPLAY_DIS;
-		aty_st_le32(LVDS_GEN_CNTL, reg);
-		aty_ld_le32(LVDS_GEN_CNTL);
-		udelay(10);
-		reg &= ~(LVDS_ON | LVDS_EN | LVDS_BLON | LVDS_DIGION);
-#endif
-		aty_st_le32(LVDS_GEN_CNTL, reg);
-#ifdef BACKLIGHT_DAC_OFF
-		aty_st_le32(DAC_CNTL, aty_ld_le32(DAC_CNTL) | DAC_PDWN);
-#endif
-	}
-
-	return 0;
-}
-
-static int aty128_bl_update_status(struct backlight_device *bd)
-{
-	struct aty128fb_par *par = class_get_devdata(&bd->class_dev);
-	struct fb_info *info = pci_get_drvdata(par->pdev);
-	int ret;
-
-	mutex_lock(&info->bl_mutex);
-	ret = __aty128_bl_update_status(bd);
-	mutex_unlock(&info->bl_mutex);
-
-	return ret;
-}
-
-static int aty128_bl_get_brightness(struct backlight_device *bd)
-{
-	return bd->props->brightness;
-}
-
-static struct backlight_properties aty128_bl_data = {
-	.owner		= THIS_MODULE,
-	.get_brightness	= aty128_bl_get_brightness,
-	.update_status	= aty128_bl_update_status,
-	.max_brightness	= (FB_BACKLIGHT_LEVELS - 1),
-};
-
-static void aty128_bl_set_power(struct fb_info *info, int power)
-{
-	mutex_lock(&info->bl_mutex);
-	up(&info->bl_dev->sem);
-	info->bl_dev->props->power = power;
-	__aty128_bl_update_status(info->bl_dev);
-	down(&info->bl_dev->sem);
-	mutex_unlock(&info->bl_mutex);
-}
-
-static void aty128_bl_init(struct aty128fb_par *par)
-{
-	struct fb_info *info = pci_get_drvdata(par->pdev);
-	struct backlight_device *bd;
-	char name[12];
-
-	/* Could be extended to Rage128Pro LVDS output too */
-	if (par->chip_gen != rage_M3)
-		return;
-
-#ifdef CONFIG_PMAC_BACKLIGHT
-	if (!pmac_has_backlight_type("ati"))
-		return;
-#endif
-
-	snprintf(name, sizeof(name), "aty128bl%d", info->node);
-
-	bd = backlight_device_register(name, par, &aty128_bl_data);
-	if (IS_ERR(bd)) {
-		info->bl_dev = NULL;
-		printk("aty128: Backlight registration failed\n");
-		goto error;
-	}
-
-	mutex_lock(&info->bl_mutex);
-	info->bl_dev = bd;
-	fb_bl_default_curve(info, 0,
-		 63 * FB_BACKLIGHT_MAX / MAX_LEVEL,
-		219 * FB_BACKLIGHT_MAX / MAX_LEVEL);
-	mutex_unlock(&info->bl_mutex);
-
-	up(&bd->sem);
-	bd->props->brightness = aty128_bl_data.max_brightness;
-	bd->props->power = FB_BLANK_UNBLANK;
-	bd->props->update_status(bd);
-	down(&bd->sem);
-
-#ifdef CONFIG_PMAC_BACKLIGHT
-	mutex_lock(&pmac_backlight_mutex);
-	if (!pmac_backlight)
-		pmac_backlight = bd;
-	mutex_unlock(&pmac_backlight_mutex);
-#endif
-
-	printk("aty128: Backlight initialized (%s)\n", name);
-
-	return;
-
-error:
-	return;
-}
-
-static void aty128_bl_exit(struct aty128fb_par *par)
-{
-	struct fb_info *info = pci_get_drvdata(par->pdev);
-
-#ifdef CONFIG_PMAC_BACKLIGHT
-	mutex_lock(&pmac_backlight_mutex);
-#endif
-
-	mutex_lock(&info->bl_mutex);
-	if (info->bl_dev) {
-#ifdef CONFIG_PMAC_BACKLIGHT
-		if (pmac_backlight == info->bl_dev)
-			pmac_backlight = NULL;
-#endif
-
-		backlight_device_unregister(info->bl_dev);
-		info->bl_dev = NULL;
-
-		printk("aty128: Backlight unloaded\n");
-	}
-	mutex_unlock(&info->bl_mutex);
-
-#ifdef CONFIG_PMAC_BACKLIGHT
-	mutex_unlock(&pmac_backlight_mutex);
-#endif
-}
-#endif /* CONFIG_FB_ATY128_BACKLIGHT */
-
 /*
  *  Initialisation
  */
