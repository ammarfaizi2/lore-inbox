Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWGDTXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWGDTXb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 15:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWGDTXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 15:23:31 -0400
Received: from khc.piap.pl ([195.187.100.11]:9138 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932347AbWGDTXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 15:23:30 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] Cirrus Logic framebuffer I2C support
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 04 Jul 2006 21:23:28 +0200
Message-ID: <m3mzbpdvin.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The attached patch adds I2C support to Cirrus Logic framebuffer driver.
Only "I2C adapter" is supported, it's not used for DDC purposes.
Tested with an old Intel R440LX machine against ST M24512 I2C EEPROM
connected to VGA DDC signals.

Currently works with "Alpine" chips only (CL-GD543x and 544x).

I've done it for my tests but don't know why should I keep it private.

Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4587087..b50825d 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -133,6 +133,12 @@ config FB_CIRRUS
 	  Say N unless you have such a graphics board or plan to get one
 	  before you next recompile the kernel.
 
+config FB_CIRRUS_I2C
+	bool "   Enable I2C adapter driver"
+	depends on FB_CIRRUS
+	help
+	  This enables I2C support for Cirrus Logic boards.
+
 config FB_PM2
 	tristate "Permedia2 support"
 	depends on FB && ((AMIGA && BROKEN) || PCI)
diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 1103010..b72e3de 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -48,6 +48,8 @@ #include <linux/delay.h>
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/selection.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
 #include <asm/pgtable.h>
 
 #ifdef CONFIG_ZORRO
@@ -406,7 +408,11 @@ struct cirrusfb_info {
 
 	u32	pseudo_palette[16];
 	struct { u8 red, green, blue, pad; } palette[256];
-
+#ifdef CONFIG_FB_CIRRUS_I2C
+	int i2c_used;
+	struct i2c_adapter alpine_ops;
+	struct i2c_algo_bit_data bit_alpine_data;
+#endif
 #ifdef CONFIG_ZORRO
 	struct zorro_dev *zdev;
 #endif
@@ -2298,6 +2304,38 @@ static int cirrusfb_set_fbinfo(struct ci
 	return 0;
 }
 
+#ifdef CONFIG_FB_CIRRUS_I2C
+static void alpine_setsda(void *ptr, int state)
+{
+	struct cirrusfb_info *cinfo = ptr;
+	u8 reg = vga_rseq(cinfo->regbase, 0x08) & ~2;
+	if (state)
+		reg |= 2;
+	vga_wseq(cinfo->regbase, 0x08, reg);
+}
+
+static void alpine_setscl(void *ptr, int state)
+{
+	struct cirrusfb_info *cinfo = ptr;
+	u8 reg = vga_rseq(cinfo->regbase, 0x08) & ~1;
+	if (state)
+		reg |= 1;
+	vga_wseq(cinfo->regbase, 0x08, reg);
+}
+
+static int alpine_getsda(void *ptr)
+{
+	struct cirrusfb_info *cinfo = ptr;
+	return !!(vga_rseq(cinfo->regbase, 0x08) & 0x80);
+}
+
+static int alpine_getscl(void *ptr)
+{
+	struct cirrusfb_info *cinfo = ptr;
+	return !!(vga_rseq(cinfo->regbase, 0x08) & 0x04);
+}
+#endif
+
 static int cirrusfb_register(struct cirrusfb_info *cinfo)
 {
 	struct fb_info *info;
@@ -2337,6 +2375,33 @@ static int cirrusfb_register(struct cirr
 		goto err_dealloc_cmap;
 	}
 
+#ifdef CONFIG_FB_CIRRUS_I2C
+	cinfo->i2c_used = 0;
+	if (cinfo->btype == BT_ALPINE || cinfo->btype == BT_PICASSO4) {
+		vga_wseq(cinfo->regbase, 0x08, 0x41); /* DDC mode: SCL */
+		vga_wseq(cinfo->regbase, 0x08, 0x43); /* DDC mode: SCL + SDA */
+		cinfo->bit_alpine_data.setsda = alpine_setsda;
+		cinfo->bit_alpine_data.setscl = alpine_setscl;
+		cinfo->bit_alpine_data.getsda = alpine_getsda;
+		cinfo->bit_alpine_data.getscl = alpine_getscl;
+		cinfo->bit_alpine_data.udelay = 5;
+		cinfo->bit_alpine_data.mdelay = 1;
+		cinfo->bit_alpine_data.timeout = HZ;
+		cinfo->bit_alpine_data.data = cinfo;
+		cinfo->alpine_ops.owner = THIS_MODULE;
+		cinfo->alpine_ops.id = I2C_HW_B_LP;
+		cinfo->alpine_ops.algo_data = &cinfo->bit_alpine_data;
+		strlcpy(cinfo->alpine_ops.name,
+			"Cirrus Logic Alpine DDC I2C adapter", I2C_NAME_SIZE);
+		if (!(err = i2c_bit_add_bus(&cinfo->alpine_ops))) {
+			printk(KERN_DEBUG "Initialized Alpine I2C adapter\n");
+			cinfo->i2c_used = 1;
+		} else
+			printk(KERN_WARNING "Unable to initialize Alpine I2C"
+			       "adapter (result = %i)\n", err);
+	}
+#endif
+
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
 
@@ -2352,6 +2417,10 @@ static void __devexit cirrusfb_cleanup (
 	struct cirrusfb_info *cinfo = info->par;
 	DPRINTK ("ENTER\n");
 
+#ifdef CONFIG_FB_CIRRUS_I2C
+	if (cinfo->i2c_used)
+		i2c_bit_del_bus(&cinfo->alpine_ops);
+#endif
 	switch_monitor (cinfo, 0);
 
 	unregister_framebuffer (info);
