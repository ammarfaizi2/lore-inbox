Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbVGUFaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbVGUFaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 01:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVGUF2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 01:28:06 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:12746 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261632AbVGUFZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 01:25:56 -0400
Date: Thu, 21 Jul 2005 07:25:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, Russell King <rmk@arm.linux.org.uk>, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [patch] Add suspend/resume support to locomo.c
Message-ID: <20050721052558.GD7849@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Lenz <lenz@cs.wisc.edu>

This adds low-level suspend/resume support to locomo.c. 

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -541,6 +541,103 @@ locomo_init_one_child(struct locomo *lch
 	return ret;
 }
 
+#ifdef CONFIG_PM
+
+struct locomo_save_data {
+	u16	LCM_GPO;
+	u16	LCM_SPICT;
+	u16	LCM_GPE;
+	u16	LCM_ASD;
+	u16	LCM_SPIMD;
+};
+
+static int locomo_suspend(struct device *dev, u32 pm_message_t, u32 level)
+{
+	struct locomo *lchip = dev_get_drvdata(dev);
+	struct locomo_save_data *save;
+	unsigned long flags;
+
+	if (level != SUSPEND_DISABLE)
+		return 0;
+
+	save = kmalloc(sizeof(struct locomo_save_data), GFP_KERNEL);
+	if (!save)
+		return -ENOMEM;
+
+	dev->power.saved_state = (void *) save;
+
+	spin_lock_irqsave(&lchip->lock, flags);
+
+	save->LCM_GPO     = locomo_readl(lchip->base + LOCOMO_GPO);	/* GPIO */
+	locomo_writel(0x00, lchip->base + LOCOMO_GPO);
+	save->LCM_SPICT   = locomo_readl(lchip->base + LOCOMO_SPICT);	/* SPI */
+	locomo_writel(0x40, lchip->base + LOCOMO_SPICT);
+	save->LCM_GPE     = locomo_readl(lchip->base + LOCOMO_GPE);	/* GPIO */
+	locomo_writel(0x00, lchip->base + LOCOMO_GPE);
+	save->LCM_ASD     = locomo_readl(lchip->base + LOCOMO_ASD);	/* ADSTART */
+	locomo_writel(0x00, lchip->base + LOCOMO_ASD);
+	save->LCM_SPIMD   = locomo_readl(lchip->base + LOCOMO_SPIMD);	/* SPI */
+	locomo_writel(0x3C14, lchip->base + LOCOMO_SPIMD);
+
+	locomo_writel(0x00, lchip->base + LOCOMO_PAIF);
+	locomo_writel(0x00, lchip->base + LOCOMO_DAC);
+	locomo_writel(0x00, lchip->base + LOCOMO_BACKLIGHT + LOCOMO_TC);
+
+	if ( (locomo_readl(lchip->base + LOCOMO_LED + LOCOMO_LPT0) & 0x88) && (locomo_readl(lchip->base + LOCOMO_LED + LOCOMO_LPT1) & 0x88) )
+		locomo_writel(0x00, lchip->base + LOCOMO_C32K); 	/* CLK32 off */
+	else
+		/* 18MHz already enabled, so no wait */
+		locomo_writel(0xc1, lchip->base + LOCOMO_C32K); 	/* CLK32 on */
+
+	locomo_writel(0x00, lchip->base + LOCOMO_TADC);		/* 18MHz clock off*/
+	locomo_writel(0x00, lchip->base + LOCOMO_AUDIO + LOCOMO_ACC);			/* 22MHz/24MHz clock off */
+	locomo_writel(0x00, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);			/* FL */
+
+	spin_unlock_irqrestore(&lchip->lock, flags);
+
+	return 0;
+}
+
+static int locomo_resume(struct device *dev, u32 level)
+{
+	struct locomo *lchip = dev_get_drvdata(dev);
+	struct locomo_save_data *save;
+	unsigned long r;
+	unsigned long flags;
+	
+	if (level != RESUME_ENABLE)
+		return 0;
+
+	save = (struct locomo_save_data *) dev->power.saved_state;
+	if (!save)
+		return 0;
+
+	spin_lock_irqsave(&lchip->lock, flags);
+
+	locomo_writel(save->LCM_GPO, lchip->base + LOCOMO_GPO);
+	locomo_writel(save->LCM_SPICT, lchip->base + LOCOMO_SPICT);
+	locomo_writel(save->LCM_GPE, lchip->base + LOCOMO_GPE);
+	locomo_writel(save->LCM_ASD, lchip->base + LOCOMO_ASD);
+	locomo_writel(save->LCM_SPIMD, lchip->base + LOCOMO_SPIMD);
+
+	locomo_writel(0x00, lchip->base + LOCOMO_C32K);
+	locomo_writel(0x90, lchip->base + LOCOMO_TADC);
+
+	locomo_writel(0, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KSC);
+	r = locomo_readl(lchip->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
+	r &= 0xFEFF;
+	locomo_writel(r, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KIC);
+	locomo_writel(0x1, lchip->base + LOCOMO_KEYBOARD + LOCOMO_KCMD);
+
+	spin_unlock_irqrestore(&lchip->lock, flags);
+
+	dev->power.saved_state = NULL;
+	kfree(save);
+
+	return 0;
+}
+#endif
+
 /**
  *	locomo_probe - probe for a single LoCoMo chip.
  *	@phys_addr: physical address of device.
@@ -707,6 +810,10 @@ static struct device_driver locomo_devic
 	.bus		= &platform_bus_type,
 	.probe		= locomo_probe,
 	.remove		= locomo_remove,
+#ifdef CONFIG_PM
+	.suspend	= locomo_suspend,
+	.resume		= locomo_resume,
+#endif
 };
 
 /*



-- 
teflon -- maybe it is a trademark, but it should not be.
