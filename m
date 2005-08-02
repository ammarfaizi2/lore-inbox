Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVHBVKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVHBVKH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVHBVHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:07:37 -0400
Received: from crl-mail-dmz.crl.hpl.hp.com ([192.58.210.9]:59623 "EHLO
	crl-mailb.crl.dec.com") by vger.kernel.org with ESMTP
	id S261778AbVHBVF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:05:27 -0400
From: <jamey@crl.dec.com>
To: linux-kernel@vger.kernel.org
Subject: [Patch 2/3] framebuffer driver for MQ11xx graphics chip
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <20050802192045.93983B49DB@lspace.crl.dec.com>
Date: Tue,  2 Aug 2005 15:20:45 -0400 (EDT)
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-HPLC-MailScanner: Found to be clean
X-HPLC-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.541,
	required 5, BAYES_00 -4.90, DOMAIN_BODY 2.20, NO_REAL_NAME 0.16)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a framebuffer driver for MQ11xx system-on-chip
graphics chip.  This chip is used in several non-PCI ARM and MIPS
platforms such as the iPAQ H5550.  This driver depends on the overall
platform_device driver for the chip.


Signed-off-by: Jamey Hicks <jamey@handhelds.org>
Signed-off-by: Andrew Zabolotny <anpaza@mail.ru>

---
commit d6631d9e21df12578ae5e7a2878b7e7132cfa28c
tree 76cce5a7824b24b384451e1100df26cecd45691e
parent d1144b4da9a00634c14dfed3a56f8491749b9f01
author <jamey@lspace.crl.dec.com> Tue, 02 Aug 2005 11:26:23 -0400
committer <jamey@lspace.crl.dec.com> Tue, 02 Aug 2005 11:26:23 -0400

 drivers/video/Kconfig    |   17 ++
 drivers/video/Makefile   |    1 
 drivers/video/mq1100fb.c |  497 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 515 insertions(+), 0 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1438,6 +1438,23 @@ config FB_PXA
 
 	  If unsure, say N.
 
+config FB_MQ1100
+	tristate "MQ1100/32/68/78/88 framebuffer support"
+	depends on FB && PLATFORM_MQ11XX
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
+	help
+	  This is a framebuffer device for the MediaQ 1100/32/68/78/88
+	  LCD controllers (http://www.mediaq.com) found in some PDAs
+	  (these include: iPAQ 5400, Axim X5, iPAQ 221x).
+
+	  This driver handles only the LCD controller apect of the MediaQ;
+	  other functions are handled in respective drivers.
+	  See <http://www.linux-fbdev.org/> for information
+	  on framebuffer devices.
+
 config FB_W100
 	tristate "W100 frame buffer support"
 	depends on FB && PXA_SHARPSL
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_FB_GBE)              += gbe
 obj-$(CONFIG_FB_CIRRUS)		  += cirrusfb.o
 obj-$(CONFIG_FB_ASILIANT)	  += asiliantfb.o
 obj-$(CONFIG_FB_PXA)		  += pxafb.o
+obj-$(CONFIG_FB_MQ1100)		  += mq1100fb.o
 obj-$(CONFIG_FB_W100)		  += w100fb.o
 obj-$(CONFIG_FB_AU1100)		  += au1100fb.o fbgen.o
 obj-$(CONFIG_FB_PMAG_AA)	  += pmag-aa-fb.o
diff --git a/drivers/video/mq1100fb.c b/drivers/video/mq1100fb.c
new file mode 100644
--- /dev/null
+++ b/drivers/video/mq1100fb.c
@@ -0,0 +1,497 @@
+/*
+ * linux/drivers/mq1100fb.c
+ *
+ * Copyright © 2003 Keith Packard
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ *	    MediaQ 1100/32/68/78/88 LCD Controller Frame Buffer Driver
+ *
+ * Please direct your questions and comments on this driver to the following
+ * email address:
+ *
+ *	keithp@keithp.com
+ *
+ * ChangeLog
+ *
+ * 2003-12-06: Andrew Zabolotny <zap@homelink.ru>
+ *      - Modified to use the MediaQ SoC base driver to allow
+ *        sharing of other MediaQ subdevices with other drivers.
+ * 2003-05-18: <keithp@keithp.com>
+ *	- Ported from PCI development board to ARM H5400
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/notifier.h>
+#include <../drivers/platform/mq11xx.h>
+
+#if 0
+#  define debug(s, args...) printk (KERN_INFO s, ##args)
+#else
+#  define debug(s, args...)
+#endif
+#define debug_func(s, args...) debug ("%s: " s, __FUNCTION__, ##args)
+
+#define MQ_Rotate_0	1
+#define MQ_Rotate_90	2
+#define MQ_Rotate_180	4
+#define MQ_Rotate_270	8
+
+#define MQ_Reflect_X	16
+#define MQ_Reflect_Y	32
+
+struct mq1100fb_rgb {
+	unsigned char red,green,blue,transp;
+};
+
+struct mq1100fb_info {
+	/* Framebuffer info */
+	struct fb_info fb;
+	/* The link to the base SoC driver */
+	struct mediaq11xx_base *base;
+	/* The RGB palette */
+	struct mq1100fb_rgb palette[256];
+	/* Notifier block */
+	struct notifier_block notify;
+	/* Framebuffer offset inside MediaQ RAM */
+	u32 fb_addr, fb_size;
+	/* The pseudo-palette */
+	u32 pseudo_pal[16];
+	/* Device instance number (0-7) */
+	u8 inst;
+	/* Combination of MQ_Rotate_XXX bits */
+	u8 rotation;
+	/* 1 if device is active, 0 if poweroff */
+	unsigned active:1;
+	/* 1 if initialization is complete, 0 while it is deferred */
+	unsigned initcomplete:1;
+	/* 1 if power is enabled to the MEDIAQ_11XX_FB_DEVICE_ID subdevice */
+	unsigned poweron:1;
+};
+#define to_mq1100fb_info(n) container_of(n, struct mq1100fb_info, fb)
+
+#define MAX_MQFB_INSTANCES 8
+
+static int ppm [MAX_MQFB_INSTANCES];
+MODULE_PARM(ppm, "i");
+MODULE_PARM_DESC(ppm, "LCD pixel density in pixels per meter");
+
+/* ------------------- chipset specific functions -------------------------- */
+
+static void mq1100fb_power (struct mq1100fb_info *info, int val)
+{
+	debug_func ("val:%d\n", val);
+
+	info->active = (val == 0) ? 1 : 0;
+
+	if (info->active != info->poweron) {
+		info->poweron = info->active;
+		info->base->set_power (info->base, MEDIAQ_11XX_FB_DEVICE_ID,
+				       info->active);
+	}
+}
+
+static void mq1100fb_update_screeninfo (struct mq1100fb_info *info, int ppm)
+{
+	u32 control = info->base->regs->GC.control;
+	u32 horizontal_width = info->base->regs->GC.horizontal_window;
+	u32 vertical_height = info->base->regs->GC.vertical_window;
+	u32 window_stride = info->base->regs->GC.window_stride;
+	int stride;
+
+	debug_func ("ppm:%d\n", ppm);
+
+	info->fb.var.grayscale = 0;
+
+	switch (control & MQ_GC_DEPTH) {
+	case MQ_GC_DEPTH_PSEUDO_1:
+		info->fb.var.bits_per_pixel = 1;
+		info->fb.fix.visual = FB_VISUAL_MONO01;
+		break;
+	case MQ_GC_DEPTH_PSEUDO_2:
+		info->fb.var.bits_per_pixel = 2;
+		info->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	case MQ_GC_DEPTH_PSEUDO_4:
+		info->fb.var.bits_per_pixel = 4;
+		info->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	case MQ_GC_DEPTH_PSEUDO_8:
+		info->fb.var.bits_per_pixel = 8;
+		info->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	case MQ_GC_DEPTH_GRAY_1:
+		info->fb.var.bits_per_pixel = 1;
+		info->fb.var.grayscale = 1;
+		info->fb.fix.visual = FB_VISUAL_MONO01;
+		break;
+	case MQ_GC_DEPTH_GRAY_2:
+		info->fb.var.bits_per_pixel = 2;
+		info->fb.var.grayscale = 1;
+		info->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	case MQ_GC_DEPTH_GRAY_4:
+		info->fb.var.bits_per_pixel = 4;
+		info->fb.var.grayscale = 1;
+		info->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	case MQ_GC_DEPTH_GRAY_8:
+		info->fb.var.bits_per_pixel = 8;
+		info->fb.var.grayscale = 1;
+		info->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	case MQ_GC_DEPTH_TRUE_16:
+		info->fb.var.bits_per_pixel = 16;
+		info->fb.fix.visual = FB_VISUAL_TRUECOLOR;
+		break;
+	}
+
+	info->fb.var.xres = info->fb.var.xres_virtual =
+		((horizontal_width & MQ_GC_HORIZONTAL_WINDOW_WIDTH) >> 16) + 1;
+	info->fb.var.yres = info->fb.var.yres_virtual =
+		((vertical_height & MQ_GC_VERTICAL_WINDOW_HEIGHT) >> 16) + 1;
+	stride = (short)window_stride;
+	info->fb.fix.line_length = (stride < 0) ? -stride : stride;
+
+	switch (control & (MQ_GC_X_SCANNING_DIRECTION|MQ_GC_LINE_SCANNING_DIRECTION)) {
+	case 0:
+		if (stride >= 0)
+			info->rotation = MQ_Rotate_0; /* 000 */
+		else
+			info->rotation |= MQ_Rotate_0 | MQ_Reflect_Y; /* 010 */
+		break;
+	case MQ_GC_X_SCANNING_DIRECTION:
+		if (stride >= 0)
+			info->rotation = MQ_Rotate_0 | MQ_Reflect_X; /* 001 */
+		else
+			info->rotation = MQ_Rotate_180; /* 011 */
+		break;
+	case MQ_GC_LINE_SCANNING_DIRECTION:
+		if (stride >= 0)
+			info->rotation = MQ_Rotate_90 | MQ_Reflect_X; /* 100 */
+		else
+			info->rotation = MQ_Rotate_90; /* 110 */
+		break;
+	case MQ_GC_LINE_SCANNING_DIRECTION|MQ_GC_X_SCANNING_DIRECTION:
+		if (stride >= 0)
+			info->rotation = MQ_Rotate_270; /* 101 */
+		else
+			info->rotation = MQ_Rotate_270 | MQ_Reflect_X; /* 111 */
+		break;
+	}
+
+	info->fb.var.width = info->fb.var.xres * 1000 / ppm;
+	info->fb.var.height = info->fb.var.yres * 1000 / ppm;
+}
+
+/*
+ *  mq1100fb_check_var():
+ *    Round up in the following order: bits_per_pixel, xres,
+ *    yres, xres_virtual, yres_virtual, xoffset, yoffset, grayscale,
+ *    bitfields, horizontal timing, vertical timing.
+ */
+static int mq1100fb_check_var(struct fb_var_screeninfo *var,
+			      struct fb_info *fbinfo)
+{
+	debug_func ("\n");
+
+	switch (var->bits_per_pixel) {
+	case 8:
+		var->red.offset = 0;
+		var->green.offset = 0;
+		var->blue.offset = 0;
+		var->red.length = 6;
+		var->green.length = 6;
+		var->blue.length = 6;
+		break;
+	case 16:
+		var->red.offset = 11;
+		var->green.offset = 5;
+		var->blue.offset = 0;
+		var->red.length = 5;
+		var->green.length = 6;
+		var->blue.length = 5;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mq1100fb_set_par(struct fb_info *fbinfo)
+{
+	struct mq1100fb_info *info = to_mq1100fb_info(fbinfo);
+
+	debug_func ("\n");
+
+	if (!info->active)
+		/* Enable the LCD controller */
+		mq1100fb_power (info, 0);
+
+	return 0;
+}
+
+static int mq1100fb_setcolreg(unsigned regno, unsigned red, unsigned green,
+			      unsigned blue, unsigned transp,
+			      struct fb_info *fbinfo)
+{
+	struct mq1100fb_info *info = to_mq1100fb_info(fbinfo);
+	int bpp, m = 0;
+
+	debug_func ("color:%d rgba:%d/%d/%d/%d\n",
+		    regno, red>>8, green>>8, blue>>8, transp>>8);
+
+	bpp = info->fb.var.bits_per_pixel;
+	m = (bpp <= 8) ? (1 << bpp) : 256;
+	if (regno >= m) {
+		debug ("regno %d out of range (max %d)\n", regno, m);
+		return -EINVAL;
+	}
+
+	info->palette[regno].red = red;
+	info->palette[regno].green = green;
+	info->palette[regno].blue = blue;
+	info->palette[regno].transp = transp;
+
+	switch (bpp) {
+	case 8:
+		break;
+	case 16:
+		/* RGB 565 */
+		info->pseudo_pal[regno] = ((red & 0xF800) |
+					   ((green & 0xFC00) >> 5) |
+					   ((blue & 0xF800) >> 11));
+		break;
+	}
+
+	return 0;
+}
+
+static int mq1100fb_pan_display(struct fb_var_screeninfo *var,
+				struct fb_info *fbinfo)
+{
+	debug_func ("\n");
+	/*
+	 *  Pan (or wrap, depending on the `vmode' field) the display using the
+	 *  `xoffset' and `yoffset' fields of the `var' structure.
+	 *  If the values don't fit, return -EINVAL.
+	 */
+
+	/* ... */
+	return 0;
+}
+
+static void mq1100fb_rotate (struct fb_info *fbinfo, int angle)
+{
+	/* For now it is not implemented but mq1100 fully
+	 * supports display rotation.
+	 */
+	debug_func ("\n");
+}
+
+static int mq1100fb_blank(int blank_mode, struct fb_info *fbinfo)
+{
+	struct mq1100fb_info *info = to_mq1100fb_info(fbinfo);
+
+	debug_func ("blank_mode:%d\n", blank_mode);
+
+	/*
+	 *  Blank the screen if blank_mode != 0, else unblank. If blank == NULL
+	 *  then the caller blanks by setting the CLUT (Color Look Up Table) to all
+	 *  black. Return 0 if blanking succeeded, != 0 if un-/blanking failed due
+	 *  to e.g. a video mode which doesn't support it. Implements VESA suspend
+	 *  and powerdown modes on hardware that supports disabling hsync/vsync:
+	 *    blank_mode == 2: suspend vsync
+	 *    blank_mode == 3: suspend hsync
+	 *    blank_mode == 4: powerdown
+	 */
+
+	mq1100fb_power (info, blank_mode);
+
+	return 0;
+}
+
+/* ------------ Interfaces to hardware functions ------------ */
+
+static struct fb_ops mq1100fb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_check_var	= mq1100fb_check_var,
+	.fb_set_par	= mq1100fb_set_par,
+	.fb_setcolreg	= mq1100fb_setcolreg,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+	.fb_blank	= mq1100fb_blank,
+	.fb_pan_display	= mq1100fb_pan_display,
+	.fb_rotate	= mq1100fb_rotate,
+	.fb_cursor	= soft_cursor
+};
+
+static struct fb_bitfield def_rgb [3] = {
+	{ 11, 5, 0 },   /* red */
+	{  5, 6, 0 },   /* green */
+	{  0, 5, 0 },   /* blue */
+};
+
+static int mq1100fb_finish_init (struct mq1100fb_info *info)
+{
+        int err;
+	int inst_ppm = ppm [info->inst];
+	if (!inst_ppm)
+		inst_ppm = 4210;
+
+	debug_func ("\n");
+
+	info->fb.var.red   = def_rgb [0];
+	info->fb.var.green = def_rgb [1];
+	info->fb.var.blue  = def_rgb [2];
+	info->fb.var.activate = FB_ACTIVATE_NOW;
+
+	strcpy (info->fb.fix.id, "mq1100");
+	info->fb.fix.type = FB_TYPE_PACKED_PIXELS;
+	info->fb.fix.type_aux = 0;
+	info->fb.fix.xpanstep = info->fb.fix.ypanstep = 0;
+	info->fb.fix.ywrapstep = 0;
+	info->fb.fix.accel = FB_ACCEL_NONE;
+
+	info->fb.screen_base = info->base->gfxram;
+	info->fb.pseudo_palette = &info->pseudo_pal;
+	info->fb.fbops = &mq1100fb_ops;
+
+	mq1100fb_update_screeninfo (info, inst_ppm);
+
+	info->fb_size = info->fb.fix.line_length * info->fb.var.yres_virtual;
+	info->fb_addr = info->base->alloc (info->base, info->fb_size, 1);
+
+	if (info->fb_addr == (u32)-1) {
+		err = -ENOMEM;
+		printk (KERN_ERR "Cannot allocate %u bytes in MediaQ internal RAM for framebuffer\n",
+			info->fb_size);
+error:		kfree (info);
+		return err;
+	}
+
+	//info->fb.fix.mmio_start = info->base->paddr_regs;
+	//info->fb.fix.mmio_len = MQ11xx_REG_SIZE;
+	info->fb.fix.smem_start = info->base->paddr_gfxram + info->fb_addr;
+	info->fb.fix.smem_len = info->fb_size;
+
+	/* Program framebuffer start address */
+	info->base->regs->GC.window_start_address = info->fb_addr;
+
+	if ((err = register_framebuffer(&info->fb)) < 0) {
+		printk (KERN_ERR "Could not register mq1100 framebuffer\n");
+		info->base->free (info->base, info->fb_addr, info->fb_size);
+		goto error;
+	}
+
+	info->initcomplete = 1;
+
+	/* Clear the screen in the case we don't use fbcon */
+	memset (info->base->gfxram + info->fb_addr, 0, info->fb_size);
+
+	debug ("frame buffer device %dx%d-%dbpp\n",
+	       info->fb.var.xres, info->fb.var.yres, info->fb.var.bits_per_pixel);
+        return 0;
+}
+
+static int mq1100fb_probe (struct device *dev, struct mediaq11xx_base *base)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct mq1100fb_info *info;
+
+	info = kmalloc (sizeof (struct mq1100fb_info), GFP_KERNEL);
+	memset (info, 0, sizeof (struct mq1100fb_info));
+	info->base = base;
+        info->inst = pdev->id;
+
+	dev_set_drvdata (dev, info);
+
+	/* Turn on the power to the MediaQ chip */
+	mq1100fb_power (info, 0);
+	mq1100fb_finish_init (info);
+
+	return 0;
+}
+
+static int mq1100fb_platform_probe (struct device *dev)
+{
+	debug_func ("\n");
+	return mq1100fb_probe (dev, (struct mediaq11xx_base *)dev->platform_data);
+}
+
+static int mq1100fb_platform_remove (struct device *dev)
+{
+	struct mq1100fb_info *info =
+		(struct mq1100fb_info *)dev_get_drvdata (dev);
+
+	debug_func ("\n");
+
+	if (info->active) {
+		mq1100fb_power (info, 4);
+		unregister_framebuffer (&info->fb);
+		info->base->free (info->base, info->fb_addr, info->fb_size);
+	}
+
+	return 0;
+}
+
+static int mq1100fb_platform_suspend (struct device *dev, u32 state, u32 level)
+{
+	struct mq1100fb_info *info =
+		(struct mq1100fb_info *)dev_get_drvdata (dev);
+
+	debug_func ("\n");
+
+	mq1100fb_power (info, 4);
+
+	return 0;
+}
+
+static int mq1100fb_platform_resume (struct device *dev, u32 level)
+{
+	struct mq1100fb_info *info =
+		(struct mq1100fb_info *)dev_get_drvdata (dev);
+
+	debug_func ("\n");
+
+	mq1100fb_power (info, 0);
+
+	return 0;
+}
+
+/* We need the framebuffer subdevice */
+struct device_driver mq1100fb_device_driver = {
+	.name     = "mq11xx_fb",
+	.bus	  = &platform_bus_type,
+	.probe    = mq1100fb_platform_probe,
+	.remove   = mq1100fb_platform_remove,
+	.suspend  = mq1100fb_platform_suspend,
+	.resume   = mq1100fb_platform_resume
+};
+
+static int __init mq1100fb_init(void)
+{
+	return driver_register (&mq1100fb_device_driver);
+}
+
+static void __exit mq1100fb_exit(void)
+{
+	driver_unregister (&mq1100fb_device_driver);
+}
+
+module_init(mq1100fb_init);
+module_exit(mq1100fb_exit);
+
+MODULE_AUTHOR("Keith Packard <keithp@keithp.com>");
+MODULE_DESCRIPTION("Framebuffer driver for MediaQ 1100/32/68/78/88 chips");
+MODULE_LICENSE("GPL");
