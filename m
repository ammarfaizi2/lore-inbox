Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWFTNhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWFTNhY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 09:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWFTNhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 09:37:24 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:18395
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1750874AbWFTNhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 09:37:23 -0400
Message-ID: <4497FA12.8090708@ed-soft.at>
Date: Tue, 20 Jun 2006 15:37:22 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] New Framebuffer for Intel based Macs
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------080800080606010206030803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080800080606010206030803
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

This patch add a new framebuffer driver for the Intel Based macs.
This framebuffer is needed when booting from EFI to get something
out the box ;)

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>

--------------080800080606010206030803
Content-Type: text/x-patch;
 name="imacfb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="imacfb.patch"

diff -uNr linux-2.6.17.orig/drivers/video/imacfb.c linux-2.6.17/drivers/video/imacfb.c
--- linux-2.6.17.orig/drivers/video/imacfb.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17/drivers/video/imacfb.c	2006-06-18 11:46:13.000000000 +0200
@@ -0,0 +1,436 @@
+/*
+ * framebuffer driver for Intel Based Mac's
+ *
+ * (c) 2006 Edgar Hucek <gimli@dark-green.com>
+ * Original vesa driver written by Gerd Knorr <kraxel@goldbach.in-berlin.de>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+
+#include <video/vga.h>
+#include <asm/io.h>
+#include <asm/mtrr.h>
+
+#define dac_reg	(0x3c8)
+#define dac_val	(0x3c9)
+
+typedef enum _MAC_TAPE {
+	M_I17,
+	M_I20,
+	M_MINI,
+	M_MACBOOK,
+	M_NEW
+} MAC_TAPE;
+
+/* --------------------------------------------------------------------- */
+
+static struct fb_var_screeninfo imacfb_defined __initdata = {
+      	.activate	= FB_ACTIVATE_NOW,
+	.height		= -1,
+	.width		= -1,
+	.right_margin	= 32,
+	.upper_margin	= 16,
+	.lower_margin	= 4,
+	.vsync_len	= 4,
+	.vmode		= FB_VMODE_NONINTERLACED,
+};
+
+static struct fb_fix_screeninfo imacfb_fix __initdata = {
+	.id	= "IMAC VGA",
+	.type	= FB_TYPE_PACKED_PIXELS,
+	.accel	= FB_ACCEL_NONE,
+};
+
+static int             inverse   = 0;
+static int             mtrr      = 0; /* disable mtrr */
+static int	       vram_remap __initdata = 0; /* Set amount of memory to be used */
+static int	       vram_total __initdata = 0; /* Set total amount of memory */
+static int             depth;
+static int             model = M_NEW;
+static int             manual_height = 0;
+static int             manual_width = 0;
+
+/* --------------------------------------------------------------------- */
+
+static int imacfb_setcolreg(unsigned regno, unsigned red, unsigned green,
+			    unsigned blue, unsigned transp,
+			    struct fb_info *info)
+{
+	/*
+	 *  Set a single color register. The values supplied are
+	 *  already rounded down to the hardware's capabilities
+	 *  (according to the entries in the `var' structure). Return
+	 *  != 0 for invalid regno.
+	 */
+	
+	if (regno >= info->cmap.len)
+		return 1;
+
+	if (regno < 16 && info->var.bits_per_pixel != 8) {
+		switch (info->var.bits_per_pixel) {
+		case 16:
+			if (info->var.red.offset == 10) {
+				/* 1:5:5:5 */
+				((u32*) (info->pseudo_palette))[regno] =
+					((red   & 0xf800) >>  1) |
+					((green & 0xf800) >>  6) |
+					((blue  & 0xf800) >> 11);
+			} else {
+				/* 0:5:6:5 */
+				((u32*) (info->pseudo_palette))[regno] =
+					((red   & 0xf800)      ) |
+					((green & 0xfc00) >>  5) |
+					((blue  & 0xf800) >> 11);
+			}
+			break;
+		case 24:
+		case 32:
+			red   >>= 8;
+			green >>= 8;
+			blue  >>= 8;
+			((u32 *)(info->pseudo_palette))[regno] =
+				(red   << info->var.red.offset)   |
+				(green << info->var.green.offset) |
+				(blue  << info->var.blue.offset);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static struct fb_ops imacfb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_setcolreg	= imacfb_setcolreg,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+};
+
+static int __init imacfb_setup(char *options)
+{
+	char *this_opt;
+	
+	if (!options || !*options)
+		return 0;
+	
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt) continue;
+		
+		if (! strcmp(this_opt, "inverse"))
+			inverse=1;
+		else if (! strncmp(this_opt, "mtrr:", 5))
+			mtrr = simple_strtoul(this_opt+5, NULL, 0);
+		else if (! strcmp(this_opt, "nomtrr"))
+			mtrr=0;
+		else if (! strncmp(this_opt, "vtotal:", 7))
+			vram_total = simple_strtoul(this_opt+7, NULL, 0);
+		else if (! strncmp(this_opt, "vremap:", 7))
+			vram_remap = simple_strtoul(this_opt+7, NULL, 0);
+		else if (! strcmp(this_opt, "i17"))
+			model = M_I17;
+		else if (! strcmp(this_opt, "i20"))
+			model = M_I20;
+		else if (! strcmp(this_opt, "mini"))
+			model = M_MINI;
+		else if (! strcmp(this_opt, "macbook"))
+			model = M_MACBOOK;
+		else if (! strncmp(this_opt, "height:", 7))
+			manual_height = simple_strtoul(this_opt+7, NULL, 0);
+		else if (! strncmp(this_opt, "width:", 6))
+			manual_width = simple_strtoul(this_opt+6, NULL, 0);
+	}
+	return 0;
+}
+
+#define	DEFAULT_FB_MEM	1024*1024*16
+
+static int __init imacfb_probe(struct platform_device *dev)
+{
+	struct fb_info *info;
+	int err;
+	unsigned int size_vmode;
+	unsigned int size_remap;
+	unsigned int size_total;
+
+	screen_info.lfb_depth = 32;
+	screen_info.lfb_size = DEFAULT_FB_MEM / 0x10000;
+	screen_info.pages=1;
+	screen_info.blue_size = 8;
+	screen_info.blue_pos = 0;
+	screen_info.green_size = 8;
+	screen_info.green_pos = 8;
+	screen_info.red_size = 8;
+	screen_info.red_pos = 16;
+	screen_info.rsvd_size = 8;
+	screen_info.rsvd_pos = 24;
+
+	switch(model) {
+		case M_I17:
+			screen_info.lfb_width = 1440;
+			screen_info.lfb_height = 900;
+			screen_info.lfb_linelength = 1472 * 4;
+			screen_info.lfb_base = 0x80010000;
+			break;
+		case M_NEW:
+		case M_I20:
+			screen_info.lfb_width = 1680;
+			screen_info.lfb_height = 1050;
+			screen_info.lfb_linelength = 1728 * 4;
+			screen_info.lfb_base = 0x80010000;
+			break;
+		case M_MINI:
+			screen_info.lfb_width = 1024;
+			screen_info.lfb_height = 768;
+			screen_info.lfb_linelength = 2048 * 4;
+			screen_info.lfb_base = 0x80000000;
+			break;
+		case M_MACBOOK:
+			screen_info.lfb_width = 1280;
+			screen_info.lfb_height = 800;
+			screen_info.lfb_linelength = 2048 * 4;
+			screen_info.lfb_base = 0x80000000;
+			break;
+ 	}
+
+	/* if the user wants to manually specify height/width,
+	   we will override the defaults */
+	/* TODO: eventually get auto-detection working */
+	if(manual_height > 0)
+		screen_info.lfb_height = manual_height;
+	if(manual_width > 0)
+		screen_info.lfb_width = manual_width;
+
+	/*
+	static void *videomemory;
+	static u_long videomemorysize = (64*1024*1024);
+	videomemory = ioremap(0x80000000,videomemorysize);
+	memset(videomemory, 0x99, videomemorysize);
+	*/
+
+	imacfb_fix.smem_start = screen_info.lfb_base;
+	imacfb_defined.bits_per_pixel = screen_info.lfb_depth;
+	if (15 == imacfb_defined.bits_per_pixel)
+		imacfb_defined.bits_per_pixel = 16;
+	imacfb_defined.xres = screen_info.lfb_width;
+	imacfb_defined.yres = screen_info.lfb_height;
+	imacfb_fix.line_length = screen_info.lfb_linelength;
+	imacfb_fix.visual   = (imacfb_defined.bits_per_pixel == 8) ?
+		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
+
+	/*   size_vmode -- that is the amount of memory needed for the
+	 *                 used video mode, i.e. the minimum amount of
+	 *                 memory we need. */
+	size_vmode = imacfb_defined.yres * imacfb_fix.line_length;
+
+	/*   size_total -- all video memory we have. Used for mtrr
+	 *                 entries, ressource allocation and bounds
+	 *                 checking. */
+	size_total = screen_info.lfb_size * 65536;
+	if (vram_total)
+		size_total = vram_total * 1024 * 1024;
+	if (size_total < size_vmode)
+		size_total = size_vmode;
+
+	/*   size_remap -- the amount of video memory we are going to
+	 *                 use for imacfb.  With modern cards it is no
+	 *                 option to simply use size_total as that
+	 *                 wastes plenty of kernel address space. */
+	size_remap  = size_vmode * 2;
+	if (vram_remap)
+		size_remap = vram_remap * 1024 * 1024;
+	if (size_remap < size_vmode)
+		size_remap = size_vmode;
+	if (size_remap > size_total)
+		size_remap = size_total;
+	imacfb_fix.smem_len = size_remap;
+
+#ifndef __i386__
+	screen_info.imacpm_seg = 0;
+#endif
+
+	if (!request_mem_region(imacfb_fix.smem_start, size_total, "imacfb")) {
+		printk(KERN_WARNING
+		       "imacfb: cannot reserve video memory at 0x%lx\n",
+			imacfb_fix.smem_start);
+		/* We cannot make this fatal. Sometimes this comes from magic
+		   spaces our resource handlers simply don't know about */
+	}
+
+	info = framebuffer_alloc(sizeof(u32) * 256, &dev->dev);
+	if (!info) {
+		release_mem_region(imacfb_fix.smem_start, size_total);
+		return -ENOMEM;
+	}
+	info->pseudo_palette = info->par;
+	info->par = NULL;
+
+	info->screen_base = ioremap(imacfb_fix.smem_start, imacfb_fix.smem_len);
+	if (!info->screen_base) {
+		printk(KERN_ERR
+		       "imacfb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
+			imacfb_fix.smem_len, imacfb_fix.smem_start);
+		err = -EIO;
+		goto err;
+	}
+
+	printk(KERN_INFO "imacfb: framebuffer at 0x%lx, mapped to 0x%p, "
+	       "using %dk, total %dk\n",
+	       imacfb_fix.smem_start, info->screen_base,
+	       size_remap/1024, size_total/1024);
+	printk(KERN_INFO "imacfb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
+	       imacfb_defined.xres, imacfb_defined.yres, imacfb_defined.bits_per_pixel, imacfb_fix.line_length, screen_info.pages);
+
+	imacfb_defined.xres_virtual = imacfb_defined.xres;
+	imacfb_defined.yres_virtual = imacfb_fix.smem_len / imacfb_fix.line_length;
+	printk(KERN_INFO "imacfb: scrolling: redraw\n");
+	imacfb_defined.yres_virtual = imacfb_defined.yres;
+
+	/* some dummy values for timing to make fbset happy */
+	imacfb_defined.pixclock     = 10000000 / imacfb_defined.xres * 1000 / imacfb_defined.yres;
+	imacfb_defined.left_margin  = (imacfb_defined.xres / 8) & 0xf8;
+	imacfb_defined.hsync_len    = (imacfb_defined.xres / 8) & 0xf8;
+	
+	imacfb_defined.red.offset    = screen_info.red_pos;
+	imacfb_defined.red.length    = screen_info.red_size;
+	imacfb_defined.green.offset  = screen_info.green_pos;
+	imacfb_defined.green.length  = screen_info.green_size;
+	imacfb_defined.blue.offset   = screen_info.blue_pos;
+	imacfb_defined.blue.length   = screen_info.blue_size;
+	imacfb_defined.transp.offset = screen_info.rsvd_pos;
+	imacfb_defined.transp.length = screen_info.rsvd_size;
+
+	if (imacfb_defined.bits_per_pixel <= 8) {
+		depth = imacfb_defined.green.length;
+		imacfb_defined.red.length =
+		imacfb_defined.green.length =
+		imacfb_defined.blue.length =
+		imacfb_defined.bits_per_pixel;
+	}
+
+	printk(KERN_INFO "imacfb: %s: "
+	       "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
+	       (imacfb_defined.bits_per_pixel > 8) ?
+	       "Truecolor" : "Pseudocolor",
+	       screen_info.rsvd_size,
+	       screen_info.red_size,
+	       screen_info.green_size,
+	       screen_info.blue_size,
+	       screen_info.rsvd_pos,
+	       screen_info.red_pos,
+	       screen_info.green_pos,
+	       screen_info.blue_pos);
+
+	imacfb_fix.ypanstep  = 0;
+	imacfb_fix.ywrapstep = 0;
+
+	/* request failure does not faze us, as vgacon probably has this
+	 * region already (FIXME) */
+	request_region(0x3c0, 32, "imacfb");
+
+#ifdef CONFIG_MTRR
+	if (mtrr) {
+		unsigned int temp_size = size_total;
+		unsigned int type = 0;
+
+		switch (mtrr) {
+		case 1:
+			type = MTRR_TYPE_UNCACHABLE;
+			break;
+		case 2:
+			type = MTRR_TYPE_WRBACK;
+			break;
+		case 3:
+			type = MTRR_TYPE_WRCOMB;
+			break;
+		case 4:
+			type = MTRR_TYPE_WRTHROUGH;
+			break;
+		default:
+			type = 0;
+			break;
+		}
+
+		if (type) {
+			int rc;
+
+			/* Find the largest power-of-two */
+			while (temp_size & (temp_size - 1))
+				temp_size &= (temp_size - 1);
+
+			/* Try and find a power of two to add */
+			do {
+				rc = mtrr_add(imacfb_fix.smem_start, temp_size,
+					      type, 1);
+				temp_size >>= 1;
+			} while (temp_size >= PAGE_SIZE && rc == -EINVAL);
+		}
+	}
+#endif
+	
+	info->fbops = &imacfb_ops;
+	info->var = imacfb_defined;
+	info->fix = imacfb_fix;
+	info->flags = FBINFO_FLAG_DEFAULT;
+
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
+		err = -ENOMEM;
+		goto err;
+	}
+	if (register_framebuffer(info)<0) {
+		err = -EINVAL;
+		fb_dealloc_cmap(&info->cmap);
+		goto err;
+	}
+	printk(KERN_INFO "fb%d: %s frame buffer device\n",
+	       info->node, info->fix.id);
+	return 0;
+err:
+	framebuffer_release(info);
+	release_mem_region(imacfb_fix.smem_start, size_total);
+	return err;
+}
+
+static struct platform_driver imacfb_driver = {
+	.probe	= imacfb_probe,
+	.driver	= {
+		.name	= "imacfb",
+	},
+};
+
+static struct platform_device imacfb_device = {
+	.name	= "imacfb",
+};
+
+static int __init imacfb_init(void)
+{
+	int ret;
+	char *option = NULL;
+
+	/* ignore error return of fb_get_options */
+	fb_get_options("imacfb", &option);
+	imacfb_setup(option);
+	ret = platform_driver_register(&imacfb_driver);
+
+	if (!ret) {
+		ret = platform_device_register(&imacfb_device);
+		if (ret)
+			platform_driver_unregister(&imacfb_driver);
+	}
+	return ret;
+}
+module_init(imacfb_init);
+
+MODULE_LICENSE("GPL");
diff -uNr linux-2.6.17.orig/drivers/video/Kconfig linux-2.6.17/drivers/video/Kconfig
--- linux-2.6.17.orig/drivers/video/Kconfig	2006-06-18 11:45:31.000000000 +0200
+++ linux-2.6.17/drivers/video/Kconfig	2006-06-18 11:46:03.000000000 +0200
@@ -483,6 +483,15 @@
 	  You will get a boot time penguin logo at no additional cost. Please
 	  read <file:Documentation/fb/vesafb.txt>. If unsure, say Y.
 
+config FB_IMAC
+	bool "Intel Based Macs FB"
+	depends on (FB = y) && X86
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the frame buffer device driver for the Inel Based Mac's
+
 config VIDEO_SELECT
 	bool
 	depends on FB_VESA
diff -uNr linux-2.6.17.orig/drivers/video/Makefile linux-2.6.17/drivers/video/Makefile
--- linux-2.6.17.orig/drivers/video/Makefile	2006-06-18 11:45:31.000000000 +0200
+++ linux-2.6.17/drivers/video/Makefile	2006-06-18 11:46:03.000000000 +0200
@@ -97,6 +97,7 @@
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_VESA)             += vesafb.o
+obj-$(CONFIG_FB_IMAC)             += imacfb.o
 obj-$(CONFIG_FB_VGA16)            += vga16fb.o vgastate.o
 obj-$(CONFIG_FB_OF)               += offb.o
 

--------------080800080606010206030803--
