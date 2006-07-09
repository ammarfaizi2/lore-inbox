Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161129AbWGIUh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbWGIUh1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbWGIUh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:37:27 -0400
Received: from khc.piap.pl ([195.187.100.11]:4272 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1161129AbWGIUh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:37:26 -0400
To: Jean Delvare <khali@linux-fr.org>
Cc: "Antonino A. Daplas" <adaplas@pol.net>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>
	<20060705165255.ab7f1b83.khali@linux-fr.org>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 09 Jul 2006 22:37:22 +0200
In-Reply-To: <20060705165255.ab7f1b83.khali@linux-fr.org> (Jean Delvare's message of "Wed, 5 Jul 2006 16:52:55 +0200")
Message-ID: <m3bqryv7jx.fsf_-_@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've attached the second version of the Cirrus Logic I2C patch.
Supersedes:
cirrus-logic-framebuffer-i2c-support.patch
cirrus-logic-framebuffer-i2c-support-fix.patch

Created against current Linus' tree.
Thanks.

Signed-off-by: Krzysztof Halasa <khc@pm.waw.pl>

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3badb48..1ab794e 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -137,6 +137,13 @@ config FB_CIRRUS
 	  Say N unless you have such a graphics board or plan to get one
 	  before you next recompile the kernel.
 
+config FB_CIRRUS_I2C
+	bool "Enable Cirrus Logic I2C support"
+	depends on FB_CIRRUS && I2C && I2C_ALGOBIT
+	help
+	  This enables I2C support for Cirrus Logic boards. Currently only
+	  Alpine chips (CL-GD543x and 544x) are supported.
+
 config FB_PM2
 	tristate "Permedia2 support"
 	depends on FB && ((AMIGA && BROKEN) || PCI)
diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 7355da0..d06cd7b 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -64,6 +64,10 @@ #define isPReP (machine_is(prep))
 #else
 #define isPReP 0
 #endif
+#ifdef CONFIG_FB_CIRRUS_I2C
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#endif
 
 #include "video/vga.h"
 #include "video/cirrus.h"
@@ -406,6 +410,11 @@ struct cirrusfb_info {
 	u32	pseudo_palette[16];
 	struct { u8 red, green, blue, pad; } palette[256];
 
+#ifdef CONFIG_FB_CIRRUS_I2C
+	int i2c_used;
+	struct i2c_adapter cirrus_ops;
+	struct i2c_algo_bit_data bit_cirrus_data;
+#endif
 #ifdef CONFIG_ZORRO
 	struct zorro_dev *zdev;
 #endif
@@ -2296,6 +2305,38 @@ static int cirrusfb_set_fbinfo(struct ci
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
@@ -2335,6 +2376,36 @@ static int cirrusfb_register(struct cirr
 		goto err_dealloc_cmap;
 	}
 
+#ifdef CONFIG_FB_CIRRUS_I2C
+	cinfo->i2c_used = 0;
+	if (cinfo->btype == BT_ALPINE || cinfo->btype == BT_PICASSO4) {
+		vga_wseq(cinfo->regbase, 0x08, 0x41); /* DDC mode: SCL */
+		vga_wseq(cinfo->regbase, 0x08, 0x43); /* DDC mode: SCL + SDA */
+		cinfo->bit_cirrus_data.setsda = alpine_setsda;
+		cinfo->bit_cirrus_data.setscl = alpine_setscl;
+		cinfo->bit_cirrus_data.getsda = alpine_getsda;
+		cinfo->bit_cirrus_data.getscl = alpine_getscl;
+		cinfo->bit_cirrus_data.udelay = 5;
+		cinfo->bit_cirrus_data.mdelay = 1;
+		cinfo->bit_cirrus_data.timeout = HZ;
+		cinfo->bit_cirrus_data.data = cinfo;
+		cinfo->cirrus_ops.owner = THIS_MODULE;
+		cinfo->cirrus_ops.id = I2C_HW_B_CIRRUS;
+		cinfo->cirrus_ops.class = I2C_CLASS_DDC;
+		cinfo->cirrus_ops.algo_data = &cinfo->bit_cirrus_data;
+		cinfo->cirrus_ops.dev.parent = info->device;
+		strlcpy(cinfo->cirrus_ops.name, "Cirrus Logic DDC I2C adapter",
+			I2C_NAME_SIZE);
+		if (!(err = i2c_bit_add_bus(&cinfo->cirrus_ops))) {
+			printk(KERN_DEBUG "Initialized Cirrus Logic I2C"
+			       " adapter\n");
+			cinfo->i2c_used = 1;
+		} else
+			printk(KERN_WARNING "Unable to initialize Cirrus"
+			       " Logic I2C adapter (result = %i)\n", err);
+	}
+#endif
+
 	DPRINTK ("EXIT, returning 0\n");
 	return 0;
 
@@ -2350,6 +2421,10 @@ static void __devexit cirrusfb_cleanup (
 	struct cirrusfb_info *cinfo = info->par;
 	DPRINTK ("ENTER\n");
 
+#ifdef CONFIG_FB_CIRRUS_I2C
+	if (cinfo->i2c_used)
+		i2c_bit_del_bus(&cinfo->cirrus_ops);
+#endif
 	switch_monitor (cinfo, 0);
 
 	unregister_framebuffer (info);
diff --git a/include/linux/i2c-id.h b/include/linux/i2c-id.h
index 21338bb..e54c6e3 100644
--- a/include/linux/i2c-id.h
+++ b/include/linux/i2c-id.h
@@ -192,6 +192,7 @@ #define I2C_HW_B_SAVAGE		0x01001d /* sav
 #define I2C_HW_B_RADEON		0x01001e /* radeon framebuffer driver */
 #define I2C_HW_B_EM28XX		0x01001f /* em28xx video capture cards */
 #define I2C_HW_B_CX2341X	0x010020 /* Conexant CX2341X MPEG encoder cards */
+#define I2C_HW_B_CIRRUS		0x010021 /* Cirrus Logic framebuffer driver */
 
 /* --- PCF 8584 based algorithms					*/
 #define I2C_HW_P_LP		0x020000 /* Parallel port interface */
