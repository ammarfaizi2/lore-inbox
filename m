Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbSL0XqQ>; Fri, 27 Dec 2002 18:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265275AbSL0XqQ>; Fri, 27 Dec 2002 18:46:16 -0500
Received: from are.twiddle.net ([64.81.246.98]:38025 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S265249AbSL0XpR>;
	Fri, 27 Dec 2002 18:45:17 -0500
Date: Fri, 27 Dec 2002 15:53:22 -0800
From: Richard Henderson <rth@twiddle.net>
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [FB PATCH] tga update
Message-ID: <20021227155322.A3915@twiddle.net>
Mail-Followup-To: linux-fbdev-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If you do bk, please pull from 

	bk://are.twiddle.net/tga-2.5

That will get these two tga changesets, plus the three other
generic fb patchlets I've sent over the last couple of days.
Otherwise, there's the bare patches in the attached exports.

I realized after the fact that I committed these in the wrong
order for easily separating out, but I was pulling in bits
from three other trees into my sandbox, so it did make things
easier to have them committed.

Anyway, enough rambling.

This is a large-scale rewrite for the new FB API based on the
skeletonfb.c driver.  It's been tested on the ZLXp-E1 in my as200.
It's definitely a big improvement over not compiling.


r~

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=yyy

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.956, 2002-12-26 15:56:07-08:00, rth@are.twiddle.net
  [FB] First cut at updating tgafb to 2.5 fb api.  A large
  scale rewrite modeled off of skeletonfb.c.


 b/drivers/video/Makefile |    2 
 b/drivers/video/tgafb.c  | 1525 +++++++++++++++++++----------------------------
 b/include/video/tgafb.h  |  210 ++++++
 drivers/video/tgafb.h    |  199 ------
 4 files changed, 838 insertions, 1098 deletions


diff -Nru a/drivers/video/Makefile b/drivers/video/Makefile
--- a/drivers/video/Makefile	Fri Dec 27 15:42:56 2002
+++ b/drivers/video/Makefile	Fri Dec 27 15:42:56 2002
@@ -48,7 +48,7 @@
 obj-$(CONFIG_FB_CLGEN)            += clgenfb.o
 obj-$(CONFIG_FB_TRIDENT)	  += tridentfb.o
 obj-$(CONFIG_FB_S3TRIO)           += S3triofb.o
-obj-$(CONFIG_FB_TGA)              += tgafb.o
+obj-$(CONFIG_FB_TGA)              += tgafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_VESA)             += vesafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_VGA16)            += vga16fb.o cfbfillrect.o cfbcopyarea.o \
 	                             cfbimgblt.o vgastate.o 
diff -Nru a/drivers/video/tgafb.c b/drivers/video/tgafb.c
--- a/drivers/video/tgafb.c	Fri Dec 27 15:42:56 2002
+++ b/drivers/video/tgafb.c	Fri Dec 27 15:42:56 2002
@@ -2,10 +2,10 @@
  *  linux/drivers/video/tgafb.c -- DEC 21030 TGA frame buffer device
  *
  *	Copyright (C) 1999,2000 Martin Lucina, Tom Zerucha
- *  
+ *
  *  $Id: tgafb.c,v 1.12.2.3 2000/04/04 06:44:56 mato Exp $
  *
- *  This driver is partly based on the original TGA framebuffer device, which 
+ *  This driver is partly based on the original TGA framebuffer device, which
  *  was partly based on the original TGA console driver, which are
  *
  *	Copyright (C) 1997 Geert Uytterhoeven
@@ -28,982 +28,711 @@
  * KNOWN PROBLEMS/TO DO ==================================================== */
 
 #include <linux/module.h>
-#include <linux/sched.h>
 #include <linux/kernel.h>
+#include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/tty.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <linux/fb.h>
 #include <linux/init.h>
-#include <linux/pci.h>
+#include <linux/fb.h>
 #include <linux/selection.h>
-#include <linux/console.h>
+#include <linux/pci.h>
 #include <asm/io.h>
+#include <video/tgafb.h>
 
-#include <video/fbcon.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb32.h>
-#include "tgafb.h"
-
-
-    /*
-     *  Global declarations
-     */
-
-static struct tgafb_info fb_info;
-static struct tgafb_par current_par;
-static int current_par_valid = 0;
-static struct display disp;
-
-static char default_fontname[40] __initdata = { 0 };
-static struct fb_var_screeninfo default_var;
-static int default_var_valid = 0;
-
-static struct { u_char red, green, blue, pad; } palette[256];
-#ifdef FBCON_HAS_CFB32
-static u32 fbcon_cfb32_cmap[16];
-#endif
-
-
-    /*
-     *  Hardware presets
-     */
-
-static unsigned int fb_offset_presets[4] = {
-	TGA_8PLANE_FB_OFFSET,
-	TGA_24PLANE_FB_OFFSET,
-	0xffffffff,
-	TGA_24PLUSZ_FB_OFFSET
-};
 
-static unsigned int deep_presets[4] = {
-  0x00014000,
-  0x0001440d,
-  0xffffffff,
-  0x0001441d
-};
+/*
+ * Local functions.
+ */
 
-static unsigned int rasterop_presets[4] = {
-  0x00000003,
-  0x00000303,
-  0xffffffff,
-  0x00000303
-};
+static int tgafb_check_var(struct fb_var_screeninfo *, struct fb_info *);
+static int tgafb_set_par(struct fb_info *);
+static void tgafb_set_pll(struct tga_par *, int);
+static int tgafb_setcolreg(unsigned, unsigned, unsigned, unsigned,
+			   unsigned, struct fb_info *);
+static int tgafb_blank(int, struct fb_info *);
+static void tgafb_init_fix(struct fb_info *);
+static int tgafb_pci_register(struct pci_dev *, const struct pci_device_id *);
+#ifdef MODULE
+static void tgafb_pci_unregister(struct pci_dev *);
+#endif
 
-static unsigned int mode_presets[4] = {
-  0x00002000,
-  0x00002300,
-  0xffffffff,
-  0x00002300
-};
+static const char *mode_option = "640x480@60";
 
-static unsigned int base_addr_presets[4] = {
-  0x00000000,
-  0x00000001,
-  0xffffffff,
-  0x00000001
-};
 
+/*
+ *  Frame buffer operations
+ */
 
-    /*
-     *  Predefined video modes
-     *  This is a subset of the standard VESA modes, recalculated from XFree86.
-     *
-     *  XXX Should we store these in terms of the encoded par structs? Even better,
-     *      fbcon should provide a general mechanism for doing something like this.
-     */
-
-static struct {
-    const char *name;
-    struct fb_var_screeninfo var;
-} tgafb_predefined[] __initdata = {
-    { "640x480-60", {
-	640, 480, 640, 480, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 39722, 40, 24, 32, 11, 96, 2,
-	0,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "800x600-56", {
-	800, 600, 800, 600, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 27777, 128, 24, 22, 1, 72, 2,
-	0,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "640x480-72", {
-	640, 480, 640, 480, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 31746, 144, 40, 30, 8, 40, 3,
-	0,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "800x600-60", {
-	800, 600, 800, 600, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 25000, 88, 40, 23, 1, 128, 4,
-	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "800x600-72", {
-	800, 600, 800, 600, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 20000, 64, 56, 23, 37, 120, 6,
-	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "1024x768-60", {
-	1024, 768, 1024, 768, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 15384, 168, 8, 29, 3, 144, 6,
-	0,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "1152x864-60", {
-	1152, 864, 1152, 864, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 11123, 208, 64, 16, 4, 256, 8,
-	0,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "1024x768-70", {
-	1024, 768, 1024, 768, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 13333, 144, 24, 29, 3, 136, 6,
-	0,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "1024x768-76", {
-	1024, 768, 1024, 768, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 11764, 208, 8, 36, 16, 120, 3,
-	0,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "1152x864-70", {
-	1152, 864, 1152, 864, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 10869, 106, 56, 20, 1, 160, 10,
-	0,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "1280x1024-61", {
-	1280, 1024, 1280, 1024, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 9090, 200, 48, 26, 1, 184, 3,
-	0,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "1024x768-85", {
-	1024, 768, 1024, 768, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 10111, 192, 32, 34, 14, 160, 6,
-	0,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "1280x1024-70", {
-	1280, 1024, 1280, 1024, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 7905, 224, 32, 28, 8, 160, 8,
-	0,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "1152x864-84", {
-	1152, 864, 1152, 864, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 7407, 184, 312, 32, 0, 128, 12,
-	0,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "1280x1024-76", {
-	1280, 1024, 1280, 1024, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 7407, 248, 32, 34, 3, 104, 3,
-	0,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "1280x1024-85", {
-	1280, 1024, 1280, 1024, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 6349, 224, 64, 44, 1, 160, 3,
-	0,
-	FB_VMODE_NONINTERLACED
-    }},
-
-    /* These are modes used by the two fixed-frequency monitors I have at home. 
-     * You may or may not find these useful.
-     */
-
-    { "WYSE1", {			/* 1280x1024 @ 72 Hz, 130 Mhz clock */
-	1280, 1024, 1280, 1024, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 7692, 192, 32, 47, 0, 192, 5,
-	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT,
-	FB_VMODE_NONINTERLACED
-    }},
-    { "IBM3", {				/* 1280x1024 @ 70 Hz, 120 Mhz clock */
-	1280, 1024, 1280, 1024, 0, 0, 0, 0,
-	{0, 8, 0}, {0, 8, 0}, {0, 8, 0}, {0, 0, 0},
-	0, 0, -1, -1, FB_ACCELF_TEXT, 8333, 192, 32, 47, 0, 192, 5,
-	0,
-	FB_VMODE_NONINTERLACED
-    }}
+static struct fb_ops tgafb_ops = {
+	.owner			= THIS_MODULE,
+	.fb_check_var		= tgafb_check_var,
+	.fb_set_par		= tgafb_set_par,
+	.fb_setcolreg		= tgafb_setcolreg,
+	.fb_blank		= tgafb_blank,
+	.fb_fillrect		= cfb_fillrect,
+	.fb_copyarea		= cfb_copyarea,
+	.fb_imageblit		= cfb_imageblit,
 };
 
-#define NUM_TOTAL_MODES    ARRAY_SIZE(tgafb_predefined)
-
 
-    /*
-     *  Interface used by the world
-     */
-
-static void tgafb_detect(void);
-static int tgafb_encode_fix(struct fb_fix_screeninfo *fix, const void *fb_par,
-		        struct fb_info_gen *info);
-static int tgafb_decode_var(const struct fb_var_screeninfo *var, void *fb_par,
-		        struct fb_info_gen *info);
-static int tgafb_encode_var(struct fb_var_screeninfo *var, const void *fb_par,
-		        struct fb_info_gen *info);
-static void tgafb_get_par(void *fb_par, struct fb_info_gen *info);
-static void tgafb_set_par(const void *fb_par, struct fb_info_gen *info);
-static int tgafb_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue, 
-		u_int *transp, struct fb_info *info);
-static int tgafb_setcolreg(u_int regno, u_int red, u_int green, u_int blue, 
-		u_int transp, struct fb_info *info);
-static int tgafb_blank(int blank, struct fb_info_gen *info);
-static void tgafb_set_disp(const void *fb_par, struct display *disp, 
-		struct fb_info_gen *info);
+/*
+ *  PCI registration operations
+ */
 
-#ifndef MODULE
-int tgafb_setup(char*);
-#endif
+static struct pci_device_id const tgafb_pci_table[] = {
+	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TGA, PCI_ANY_ID, PCI_ANY_ID,
+	  0, 0, 0 }
+};
 
-static void tgafb_set_pll(int f);
-#if 1
-static int tgafb_set_cmap(struct fb_cmap *cmap, int kspc, int con,
-			  struct fb_info *info);
-static void tgafb_update_palette(void);
-#endif
+static struct pci_driver tgafb_driver = {
+	.name			= "tgafb",
+	.id_table		= tgafb_pci_table,
+	.probe			= tgafb_pci_register,
+	.remove			= __devexit_p(tgafb_pci_unregister),
+};
 
 
-    /*
-     *  Chipset specific functions
-     */
+/**
+ *      tgafb_check_var - Optional function.  Validates a var passed in.
+ *      @var: frame buffer variable screen structure
+ *      @info: frame buffer structure that represents a single frame buffer
+ */
+static int
+tgafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct tga_par *par = (struct tga_par *)info->par;
 
+	if (par->tga_type == TGA_TYPE_8PLANE) {
+		if (var->bits_per_pixel > 8)
+			return -EINVAL;
+	} else {
+		if (var->bits_per_pixel > 32)
+			return -EINVAL;
+	}
 
-static void tgafb_detect(void)
-{
-    return;
+	if (var->xres_virtual != var->xres || var->yres_virtual != var->yres)
+		return -EINVAL;
+	if (var->nonstd)
+		return -EINVAL;
+	if (1000000000 / var->pixclock > TGA_PLL_MAX_FREQ)
+		return -EINVAL;
+	if ((var->vmode & FB_VMODE_MASK) != FB_VMODE_NONINTERLACED)
+		return -EINVAL;
+
+	return 0;
 }
 
-
-static int tgafb_encode_fix(struct fb_fix_screeninfo *fix, const void *fb_par,
-	struct fb_info_gen *info)
+/**
+ *      tgafb_set_par - Optional function.  Alters the hardware state.
+ *      @info: frame buffer structure that represents a single frame buffer
+ */
+static int
+tgafb_set_par(struct fb_info *info)
 {
-    struct tgafb_par *par = (struct tgafb_par *)fb_par;
+	static unsigned int const deep_presets[4] = {
+		0x00014000,
+		0x0001440d,
+		0xffffffff,
+		0x0001441d
+	};
+	static unsigned int const rasterop_presets[4] = {
+		0x00000003,
+		0x00000303,
+		0xffffffff,
+		0x00000303
+	};
+	static unsigned int const mode_presets[4] = {
+		0x00002000,
+		0x00002300,
+		0xffffffff,
+		0x00002300
+	};
+	static unsigned int const base_addr_presets[4] = {
+		0x00000000,
+		0x00000001,
+		0xffffffff,
+		0x00000001
+	};
+
+	struct tga_par *par = (struct tga_par *) info->par;
+	u32 htimings, vtimings, pll_freq;
+	u8 tga_type;
+	int i, j;
+
+	/* Encode video timings.  */
+	htimings = (((info->var.xres/4) & TGA_HORIZ_ACT_LSB)
+		    | (((info->var.xres/4) & 0x600 << 19) & TGA_HORIZ_ACT_MSB));
+	vtimings = (info->var.yres & TGA_VERT_ACTIVE);
+	htimings |= ((info->var.right_margin/4) << 9) & TGA_HORIZ_FP;
+	vtimings |= (info->var.lower_margin << 11) & TGA_VERT_FP;
+	htimings |= ((info->var.hsync_len/4) << 14) & TGA_HORIZ_SYNC;
+	vtimings |= (info->var.vsync_len << 16) & TGA_VERT_SYNC;
+	htimings |= ((info->var.left_margin/4) << 21) & TGA_HORIZ_BP;
+	vtimings |= (info->var.upper_margin << 22) & TGA_VERT_BP;
+
+	if (info->var.sync & FB_SYNC_HOR_HIGH_ACT)
+		htimings |= TGA_HORIZ_POLARITY;
+	if (info->var.sync & FB_SYNC_VERT_HIGH_ACT)
+		vtimings |= TGA_VERT_POLARITY;
+
+	par->htimings = htimings;
+	par->vtimings = vtimings;
+
+	par->sync_on_green = !!(info->var.sync & FB_SYNC_ON_GREEN);
+
+	/* Store other useful values in par.  */
+	par->xres = info->var.xres;
+	par->yres = info->var.yres;
+	par->pll_freq = pll_freq = 1000000000 / info->var.pixclock;
+	par->bits_per_pixel = info->var.bits_per_pixel;
+
+	tga_type = par->tga_type;
+
+	/* First, disable video.  */
+	TGA_WRITE_REG(par, TGA_VALID_VIDEO | TGA_VALID_BLANK, TGA_VALID_REG);
+
+	/* Write the DEEP register.  */
+	while (TGA_READ_REG(par, TGA_CMD_STAT_REG) & 1) /* wait for not busy */
+		continue;
+	mb();
+	TGA_WRITE_REG(par, deep_presets[tga_type], TGA_DEEP_REG);
+	while (TGA_READ_REG(par, TGA_CMD_STAT_REG) & 1) /* wait for not busy */
+		continue;
+	mb();
 
-    strcpy(fix->id, fb_info.gen.info.modename);
+	/* Write some more registers.  */
+	TGA_WRITE_REG(par, rasterop_presets[tga_type], TGA_RASTEROP_REG);
+	TGA_WRITE_REG(par, mode_presets[tga_type], TGA_MODE_REG);
+	TGA_WRITE_REG(par, base_addr_presets[tga_type], TGA_BASE_ADDR_REG);
+
+	/* Calculate & write the PLL.  */
+	tgafb_set_pll(par, pll_freq);
+
+	/* Write some more registers.  */
+	TGA_WRITE_REG(par, 0xffffffff, TGA_PLANEMASK_REG);
+	TGA_WRITE_REG(par, 0xffffffff, TGA_PIXELMASK_REG);
+	TGA_WRITE_REG(par, 0x12345678, TGA_BLOCK_COLOR0_REG);
+	TGA_WRITE_REG(par, 0x12345678, TGA_BLOCK_COLOR1_REG);
+
+	/* Init video timing regs.  */
+	TGA_WRITE_REG(par, htimings, TGA_HORIZ_REG);
+	TGA_WRITE_REG(par, vtimings, TGA_VERT_REG);
+
+	/* Initalise RAMDAC. */
+	if (tga_type == TGA_TYPE_8PLANE) {
+
+		/* Init BT485 RAMDAC registers.  */
+		BT485_WRITE(par, 0xa2 | (par->sync_on_green ? 0x8 : 0x0),
+			    BT485_CMD_0);
+		BT485_WRITE(par, 0x01, BT485_ADDR_PAL_WRITE);
+		BT485_WRITE(par, 0x14, BT485_CMD_3); /* cursor 64x64 */
+		BT485_WRITE(par, 0x40, BT485_CMD_1);
+		BT485_WRITE(par, 0x20, BT485_CMD_2); /* cursor off, for now */
+		BT485_WRITE(par, 0xff, BT485_PIXEL_MASK);
+
+		/* Fill palette registers.  */
+		BT485_WRITE(par, 0x00, BT485_ADDR_PAL_WRITE);
+		TGA_WRITE_REG(par, BT485_DATA_PAL, TGA_RAMDAC_SETUP_REG);
+
+		for (i = 0; i < 16; i++) {
+			j = color_table[i];
+			TGA_WRITE_REG(par, default_red[j]|(BT485_DATA_PAL<<8),
+				      TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, default_grn[j]|(BT485_DATA_PAL<<8),
+				      TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, default_blu[j]|(BT485_DATA_PAL<<8),
+				      TGA_RAMDAC_REG);
+		}
+		for (i = 0; i < 240*3; i += 4) {
+			TGA_WRITE_REG(par, 0x55|(BT485_DATA_PAL<<8),
+				      TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x00|(BT485_DATA_PAL<<8),
+				      TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x00|(BT485_DATA_PAL<<8),
+				      TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x00|(BT485_DATA_PAL<<8),
+				      TGA_RAMDAC_REG);
+		}
+
+	} else { /* 24-plane or 24plusZ */
+
+		/* Init BT463 registers.  */
+		BT463_WRITE(par, BT463_REG_ACC, BT463_CMD_REG_0, 0x40);
+		BT463_WRITE(par, BT463_REG_ACC, BT463_CMD_REG_1, 0x08);
+		BT463_WRITE(par, BT463_REG_ACC, BT463_CMD_REG_2,
+			    (par->sync_on_green ? 0x80 : 0x40));
+
+		BT463_WRITE(par, BT463_REG_ACC, BT463_READ_MASK_0, 0xff);
+		BT463_WRITE(par, BT463_REG_ACC, BT463_READ_MASK_1, 0xff);
+		BT463_WRITE(par, BT463_REG_ACC, BT463_READ_MASK_2, 0xff);
+		BT463_WRITE(par, BT463_REG_ACC, BT463_READ_MASK_3, 0x0f);
+
+		BT463_WRITE(par, BT463_REG_ACC, BT463_BLINK_MASK_0, 0x00);
+		BT463_WRITE(par, BT463_REG_ACC, BT463_BLINK_MASK_1, 0x00);
+		BT463_WRITE(par, BT463_REG_ACC, BT463_BLINK_MASK_2, 0x00);
+		BT463_WRITE(par, BT463_REG_ACC, BT463_BLINK_MASK_3, 0x00);
+
+		/* Fill the palette.  */
+		BT463_LOAD_ADDR(par, 0x0000);
+		TGA_WRITE_REG(par, BT463_PALETTE<<2, TGA_RAMDAC_REG);
+
+		for (i = 0; i < 16; i++) {
+			j = color_table[i];
+			TGA_WRITE_REG(par, default_red[j]|(BT463_PALETTE<<10),
+				      TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, default_grn[j]|(BT463_PALETTE<<10),
+				      TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, default_blu[j]|(BT463_PALETTE<<10),
+				      TGA_RAMDAC_REG);
+		}
+		for (i = 0; i < 512*3; i += 4) {
+			TGA_WRITE_REG(par, 0x55|(BT463_PALETTE<<10),
+				      TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x00|(BT463_PALETTE<<10),
+				      TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x00|(BT463_PALETTE<<10),
+				      TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x00|(BT463_PALETTE<<10),
+				      TGA_RAMDAC_REG);
+		}
+
+		/* Fill window type table after start of vertical retrace.  */
+		while (!(TGA_READ_REG(par, TGA_INTR_STAT_REG) & 0x01))
+			continue;
+		TGA_WRITE_REG(par, 0x01, TGA_INTR_STAT_REG);
+		mb();
+		while (!(TGA_READ_REG(par, TGA_INTR_STAT_REG) & 0x01))
+			continue;
+		TGA_WRITE_REG(par, 0x01, TGA_INTR_STAT_REG);
+
+		BT463_LOAD_ADDR(par, BT463_WINDOW_TYPE_BASE);
+		TGA_WRITE_REG(par, BT463_REG_ACC<<2, TGA_RAMDAC_SETUP_REG);
+
+		for (i = 0; i < 16; i++) {
+			TGA_WRITE_REG(par, 0x00|(BT463_REG_ACC<<10),
+				      TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x01|(BT463_REG_ACC<<10),
+				      TGA_RAMDAC_REG);
+			TGA_WRITE_REG(par, 0x80|(BT463_REG_ACC<<10),
+				      TGA_RAMDAC_REG);
+		}
 
-    fix->type = FB_TYPE_PACKED_PIXELS;
-    fix->type_aux = 0;
-    if (fb_info.tga_type == TGA_TYPE_8PLANE) {
-	fix->visual = FB_VISUAL_PSEUDOCOLOR;
-    } else {
-	fix->visual = FB_VISUAL_TRUECOLOR;
-    }
+	}
 
-    fix->line_length = par->xres * (par->bits_per_pixel >> 3);
-    fix->smem_start = fb_info.tga_fb_base;
-    fix->smem_len = fix->line_length * par->yres;
-    fix->mmio_start = fb_info.tga_regs_base;
-    fix->mmio_len = 0x1000;		/* Is this sufficient? */
-    fix->xpanstep = fix->ypanstep = fix->ywrapstep = 0;
-    fix->accel = FB_ACCEL_DEC_TGA;
+	/* Finally, enable video scan (and pray for the monitor... :-) */
+	TGA_WRITE_REG(par, TGA_VALID_VIDEO, TGA_VALID_REG);
 
-    return 0;
+	return 0;
 }
 
+#define DIFFCHECK(X)							  \
+do {									  \
+	if (m <= 0x3f) {						  \
+		int delta = f - (TGA_PLL_BASE_FREQ * (X)) / (r << shift); \
+		if (delta < 0)						  \
+			delta = -delta;					  \
+		if (delta < min_diff)					  \
+			min_diff = delta, vm = m, va = a, vr = r;	  \
+	}								  \
+} while (0)
+
+static void
+tgafb_set_pll(struct tga_par *par, int f)
+{
+	int n, shift, base, min_diff, target;
+	int r,a,m,vm = 34, va = 1, vr = 30;
+
+	for (r = 0 ; r < 12 ; r++)
+		TGA_WRITE_REG(par, !r, TGA_CLOCK_REG);
+
+	if (f > TGA_PLL_MAX_FREQ)
+		f = TGA_PLL_MAX_FREQ;
+
+	if (f >= TGA_PLL_MAX_FREQ / 2)
+		shift = 0;
+	else if (f >= TGA_PLL_MAX_FREQ / 4)
+		shift = 1;
+	else
+		shift = 2;
+
+	TGA_WRITE_REG(par, shift & 1, TGA_CLOCK_REG);
+	TGA_WRITE_REG(par, shift >> 1, TGA_CLOCK_REG);
 
-static int tgafb_decode_var(const struct fb_var_screeninfo *var, void *fb_par,
-	struct fb_info_gen *info)
-{
-    struct tgafb_par *par = (struct tgafb_par *)fb_par;
+	for (r = 0 ; r < 10 ; r++)
+		TGA_WRITE_REG(par, 0, TGA_CLOCK_REG);
 
-    /* round up some */
-    if (fb_info.tga_type == TGA_TYPE_8PLANE) {
-	if (var->bits_per_pixel > 8) {
-	    return -EINVAL;
+	if (f <= 120000) {
+		TGA_WRITE_REG(par, 0, TGA_CLOCK_REG);
+		TGA_WRITE_REG(par, 0, TGA_CLOCK_REG);
+	}
+	else if (f <= 200000) {
+		TGA_WRITE_REG(par, 1, TGA_CLOCK_REG);
+		TGA_WRITE_REG(par, 0, TGA_CLOCK_REG);
 	}
-	par->bits_per_pixel = 8;
-    } else {
-	if (var->bits_per_pixel > 32) {
-	    return -EINVAL;
+	else {
+		TGA_WRITE_REG(par, 0, TGA_CLOCK_REG);
+		TGA_WRITE_REG(par, 1, TGA_CLOCK_REG);
 	}
-	par->bits_per_pixel = 32;
-    }
 
-    /* check the values for sanity */
-    if (var->xres_virtual != var->xres ||
-	var->yres_virtual != var->yres ||
-	var->nonstd || (1000000000/var->pixclock) > TGA_PLL_MAX_FREQ ||
-	(var->vmode & FB_VMODE_MASK) != FB_VMODE_NONINTERLACED
-#if 0	/* fbmon not done.  uncomment for 2.5.x -brad */
-	|| !fbmon_valid_timings(var->pixclock, var->htotal, var->vtotal, info))
-#else
-	)
-#endif
-	return -EINVAL;
+	TGA_WRITE_REG(par, 1, TGA_CLOCK_REG);
+	TGA_WRITE_REG(par, 0, TGA_CLOCK_REG);
+	TGA_WRITE_REG(par, 0, TGA_CLOCK_REG);
+	TGA_WRITE_REG(par, 1, TGA_CLOCK_REG);
+	TGA_WRITE_REG(par, 0, TGA_CLOCK_REG);
+	TGA_WRITE_REG(par, 1, TGA_CLOCK_REG);
+
+	target = (f << shift) / TGA_PLL_BASE_FREQ;
+	min_diff = TGA_PLL_MAX_FREQ;
+
+	r = 7 / target;
+	if (!r) r = 1;
+
+	base = target * r;
+	while (base < 449) {
+		for (n = base < 7 ? 7 : base; n < base + target && n < 449; n++) {
+			m = ((n + 3) / 7) - 1;
+			a = 0;
+			DIFFCHECK((m + 1) * 7);
+			m++;
+			DIFFCHECK((m + 1) * 7);
+			m = (n / 6) - 1;
+			if ((a = n % 6))
+				DIFFCHECK(n);
+		}
+		r++;
+		base += target;
+	}
 
-    /* encode video timings */
-    par->htimings = ((var->xres/4) & TGA_HORIZ_ACT_LSB) | 
-	(((var->xres/4) & 0x600 << 19) & TGA_HORIZ_ACT_MSB);
-    par->vtimings = (var->yres & TGA_VERT_ACTIVE);
-    par->htimings |= ((var->right_margin/4) << 9) & TGA_HORIZ_FP;
-    par->vtimings |= (var->lower_margin << 11) & TGA_VERT_FP;
-    par->htimings |= ((var->hsync_len/4) << 14) & TGA_HORIZ_SYNC;
-    par->vtimings |= (var->vsync_len << 16) & TGA_VERT_SYNC;
-    par->htimings |= ((var->left_margin/4) << 21) & TGA_HORIZ_BP;
-    par->vtimings |= (var->upper_margin << 22) & TGA_VERT_BP;
-
-    if (var->sync & FB_SYNC_HOR_HIGH_ACT)
-	par->htimings |= TGA_HORIZ_POLARITY;
-    if (var->sync & FB_SYNC_VERT_HIGH_ACT)
-	par->vtimings |= TGA_VERT_POLARITY;
-    if (var->sync & FB_SYNC_ON_GREEN) {
-	par->sync_on_green = 1;
-    } else {
-	par->sync_on_green = 0;
-    }
-
-    /* store other useful values in par */
-    par->xres = var->xres; 
-    par->yres = var->yres;
-    par->pll_freq = 1000000000/var->pixclock;
-    par->bits_per_pixel = var->bits_per_pixel;
-
-    return 0;
-}
-
-
-static int tgafb_encode_var(struct fb_var_screeninfo *var, const void *fb_par,
-	struct fb_info_gen *info)
-{
-    struct tgafb_par *par = (struct tgafb_par *)fb_par;
-
-    /* decode video timings */
-    var->xres = ((par->htimings & TGA_HORIZ_ACT_LSB) | ((par->htimings & TGA_HORIZ_ACT_MSB) >> 19)) * 4;
-    var->yres = (par->vtimings & TGA_VERT_ACTIVE);
-    var->right_margin = ((par->htimings & TGA_HORIZ_FP) >> 9) * 4;
-    var->lower_margin = ((par->vtimings & TGA_VERT_FP) >> 11);
-    var->hsync_len = ((par->htimings & TGA_HORIZ_SYNC) >> 14) * 4;
-    var->vsync_len = ((par->vtimings & TGA_VERT_SYNC) >> 16);
-    var->left_margin = ((par->htimings & TGA_HORIZ_BP) >> 21) * 4;
-    var->upper_margin = ((par->vtimings & TGA_VERT_BP) >> 22);
-
-    if (par->htimings & TGA_HORIZ_POLARITY) 
-    	var->sync |= FB_SYNC_HOR_HIGH_ACT;
-    if (par->vtimings & TGA_VERT_POLARITY)
-    	var->sync |= FB_SYNC_VERT_HIGH_ACT;
-    if (par->sync_on_green == 1)
-	var->sync |= FB_SYNC_ON_GREEN;
-
-    var->xres_virtual = var->xres;
-    var->yres_virtual = var->yres;
-    var->xoffset = var->yoffset = 0;
-
-    /* depth-related */
-    if (fb_info.tga_type == TGA_TYPE_8PLANE) {
-	var->red.offset = 0;
-	var->green.offset = 0;
-	var->blue.offset = 0;
-    } else {
-	var->red.offset = 16;
-	var->green.offset = 8;
-	var->blue.offset = 0;
-    }
-    var->bits_per_pixel = par->bits_per_pixel;
-    var->grayscale = 0;
-    var->red.length = var->green.length = var->blue.length = 8;
-    var->red.msb_right = var->green.msb_right = var->blue.msb_right = 0;
-    var->transp.offset = var->transp.length = var->transp.msb_right = 0;
-
-    /* others */
-    var->xoffset = var->yoffset = 0;
-    var->pixclock = 1000000000/par->pll_freq;
-    var->nonstd = 0;
-    var->activate = 0;
-    var->height = var->width = -1;
-    var->accel_flags = 0;
-
-    return 0;
-}
-
-
-static void tgafb_get_par(void *fb_par, struct fb_info_gen *info)
-{
-    struct tgafb_par *par = (struct tgafb_par *)fb_par;
-
-    if (current_par_valid)
-	*par = current_par;
-    else {
-	if (fb_info.tga_type == TGA_TYPE_8PLANE)
-	    default_var.bits_per_pixel = 8;
-	else
-	    default_var.bits_per_pixel = 32;
+	vr--;
 
-	tgafb_decode_var(&default_var, par, info);
-    }
+	for (r = 0; r < 8; r++)
+		TGA_WRITE_REG(par, (vm >> r) & 1, TGA_CLOCK_REG);
+	for (r = 0; r < 8 ; r++)
+		TGA_WRITE_REG(par, (va >> r) & 1, TGA_CLOCK_REG);
+	for (r = 0; r < 7 ; r++)
+		TGA_WRITE_REG(par, (vr >> r) & 1, TGA_CLOCK_REG);
+	TGA_WRITE_REG(par, ((vr >> 7) & 1)|2, TGA_CLOCK_REG);
 }
 
 
-static void tgafb_set_par(const void *fb_par, struct fb_info_gen *info)
-{
-    int i, j;
-    struct tgafb_par *par = (struct tgafb_par *)fb_par;
-
-#if 0
-    /* XXX this will break console switching with X11, maybe I need to test KD_GRAPHICS? */
-    /* if current_par is valid, check to see if we need to change anything */
-    if (current_par_valid) {
-	if (!memcmp(par, &current_par, sizeof current_par)) {
-	    return;
+/**
+ *      tgafb_setcolreg - Optional function. Sets a color register.
+ *      @regno: boolean, 0 copy local, 1 get_user() function
+ *      @red: frame buffer colormap structure
+ *      @green: The green value which can be up to 16 bits wide
+ *      @blue:  The blue value which can be up to 16 bits wide.
+ *      @transp: If supported the alpha value which can be up to 16 bits wide.
+ *      @info: frame buffer info structure
+ */
+static int
+tgafb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue,
+		unsigned transp, struct fb_info *info)
+{
+	struct tga_par *par = (struct tga_par *) info->par;
+
+	if (regno > 255)
+		return 1;
+	red >>= 8;
+	green >>= 8;
+	blue >>= 8;
+
+	if (par->tga_type == TGA_TYPE_8PLANE) {
+		BT485_WRITE(par, regno, BT485_ADDR_PAL_WRITE);
+		TGA_WRITE_REG(par, BT485_DATA_PAL, TGA_RAMDAC_SETUP_REG);
+		TGA_WRITE_REG(par, red|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
+		TGA_WRITE_REG(par, green|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
+		TGA_WRITE_REG(par, blue|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
 	}
-    }
-#endif
-    current_par = *par;
-    current_par_valid = 1;
-
-    /* first, disable video */
-    TGA_WRITE_REG(TGA_VALID_VIDEO | TGA_VALID_BLANK, TGA_VALID_REG);
-    
-    /* write the DEEP register */
-    while (TGA_READ_REG(TGA_CMD_STAT_REG) & 1) /* wait for not busy */
-      continue;
-
-    mb();
-    TGA_WRITE_REG(deep_presets[fb_info.tga_type], TGA_DEEP_REG);
-    while (TGA_READ_REG(TGA_CMD_STAT_REG) & 1) /* wait for not busy */
-	continue;
-    mb();
-
-    /* write some more registers */
-    TGA_WRITE_REG(rasterop_presets[fb_info.tga_type], TGA_RASTEROP_REG);
-    TGA_WRITE_REG(mode_presets[fb_info.tga_type], TGA_MODE_REG);
-    TGA_WRITE_REG(base_addr_presets[fb_info.tga_type], TGA_BASE_ADDR_REG);
-
-    /* calculate & write the PLL */
-    tgafb_set_pll(par->pll_freq);
-
-    /* write some more registers */
-    TGA_WRITE_REG(0xffffffff, TGA_PLANEMASK_REG);
-    TGA_WRITE_REG(0xffffffff, TGA_PIXELMASK_REG);
-    TGA_WRITE_REG(0x12345678, TGA_BLOCK_COLOR0_REG);
-    TGA_WRITE_REG(0x12345678, TGA_BLOCK_COLOR1_REG);
-
-    /* init video timing regs */
-    TGA_WRITE_REG(par->htimings, TGA_HORIZ_REG);
-    TGA_WRITE_REG(par->vtimings, TGA_VERT_REG);
-
-    /* initalise RAMDAC */
-    if (fb_info.tga_type == TGA_TYPE_8PLANE) { 
-
-	/* init BT485 RAMDAC registers */
-	BT485_WRITE(0xa2 | (par->sync_on_green ? 0x8 : 0x0), BT485_CMD_0);
-	BT485_WRITE(0x01, BT485_ADDR_PAL_WRITE);
-	BT485_WRITE(0x14, BT485_CMD_3); /* cursor 64x64 */
-	BT485_WRITE(0x40, BT485_CMD_1);
-	BT485_WRITE(0x20, BT485_CMD_2); /* cursor off, for now */
-	BT485_WRITE(0xff, BT485_PIXEL_MASK);
-
-	/* fill palette registers */
-	BT485_WRITE(0x00, BT485_ADDR_PAL_WRITE);
-	TGA_WRITE_REG(BT485_DATA_PAL, TGA_RAMDAC_SETUP_REG);
-
-	for (i = 0; i < 16; i++) {
-	    j = color_table[i];
-	    TGA_WRITE_REG(default_red[j]|(BT485_DATA_PAL<<8), TGA_RAMDAC_REG);
-	    TGA_WRITE_REG(default_grn[j]|(BT485_DATA_PAL<<8), TGA_RAMDAC_REG);
-	    TGA_WRITE_REG(default_blu[j]|(BT485_DATA_PAL<<8), TGA_RAMDAC_REG);
-	    palette[i].red=default_red[j];
-	    palette[i].green=default_grn[j];
-	    palette[i].blue=default_blu[j];
-	}
-	for (i = 0; i < 240*3; i += 4) {
-	    TGA_WRITE_REG(0x55|(BT485_DATA_PAL<<8), TGA_RAMDAC_REG);
-	    TGA_WRITE_REG(0x00|(BT485_DATA_PAL<<8), TGA_RAMDAC_REG);
-	    TGA_WRITE_REG(0x00|(BT485_DATA_PAL<<8), TGA_RAMDAC_REG);
-	    TGA_WRITE_REG(0x00|(BT485_DATA_PAL<<8), TGA_RAMDAC_REG);
-	}	  
-
-    } else { /* 24-plane or 24plusZ */
-
-	/* init BT463 registers */
-	BT463_WRITE(BT463_REG_ACC, BT463_CMD_REG_0, 0x40);
-	BT463_WRITE(BT463_REG_ACC, BT463_CMD_REG_1, 0x08);
-	BT463_WRITE(BT463_REG_ACC, BT463_CMD_REG_2, 
-		(par->sync_on_green ? 0x80 : 0x40));
-
-	BT463_WRITE(BT463_REG_ACC, BT463_READ_MASK_0, 0xff);
-	BT463_WRITE(BT463_REG_ACC, BT463_READ_MASK_1, 0xff);
-	BT463_WRITE(BT463_REG_ACC, BT463_READ_MASK_2, 0xff);
-	BT463_WRITE(BT463_REG_ACC, BT463_READ_MASK_3, 0x0f);
-
-	BT463_WRITE(BT463_REG_ACC, BT463_BLINK_MASK_0, 0x00);
-	BT463_WRITE(BT463_REG_ACC, BT463_BLINK_MASK_1, 0x00);
-	BT463_WRITE(BT463_REG_ACC, BT463_BLINK_MASK_2, 0x00);
-	BT463_WRITE(BT463_REG_ACC, BT463_BLINK_MASK_3, 0x00);
-
-	/* fill the palette */
-	BT463_LOAD_ADDR(0x0000);
-	TGA_WRITE_REG((BT463_PALETTE<<2), TGA_RAMDAC_REG);
-
-	for (i = 0; i < 16; i++) {
-	    j = color_table[i];
-	    TGA_WRITE_REG(default_red[j]|(BT463_PALETTE<<10), TGA_RAMDAC_REG);
-	    TGA_WRITE_REG(default_grn[j]|(BT463_PALETTE<<10), TGA_RAMDAC_REG);
-	    TGA_WRITE_REG(default_blu[j]|(BT463_PALETTE<<10), TGA_RAMDAC_REG);
-	}
-	for (i = 0; i < 512*3; i += 4) {
-	    TGA_WRITE_REG(0x55|(BT463_PALETTE<<10), TGA_RAMDAC_REG);
-	    TGA_WRITE_REG(0x00|(BT463_PALETTE<<10), TGA_RAMDAC_REG);
-	    TGA_WRITE_REG(0x00|(BT463_PALETTE<<10), TGA_RAMDAC_REG);
-	    TGA_WRITE_REG(0x00|(BT463_PALETTE<<10), TGA_RAMDAC_REG);
-	}	  
-
-	/* fill window type table after start of vertical retrace */
-	while (!(TGA_READ_REG(TGA_INTR_STAT_REG) & 0x01))
-	    continue;
-	TGA_WRITE_REG(0x01, TGA_INTR_STAT_REG);
-	mb();
-	while (!(TGA_READ_REG(TGA_INTR_STAT_REG) & 0x01))
-	    continue;
-	TGA_WRITE_REG(0x01, TGA_INTR_STAT_REG);
-
-	BT463_LOAD_ADDR(BT463_WINDOW_TYPE_BASE);
-	TGA_WRITE_REG((BT463_REG_ACC<<2), TGA_RAMDAC_SETUP_REG);
-	
-	for (i = 0; i < 16; i++) {
-	    TGA_WRITE_REG(0x00|(BT463_REG_ACC<<10), TGA_RAMDAC_REG);
-	    TGA_WRITE_REG(0x01|(BT463_REG_ACC<<10), TGA_RAMDAC_REG);
-	    TGA_WRITE_REG(0x80|(BT463_REG_ACC<<10), TGA_RAMDAC_REG);
-	}
-   
-    }
-
-    /* finally, enable video scan
-	(and pray for the monitor... :-) */
-    TGA_WRITE_REG(TGA_VALID_VIDEO, TGA_VALID_REG);
-}
-
-
-#define DIFFCHECK(x) { if( m <= 0x3f ) { \
-      int delta = f - (TGA_PLL_BASE_FREQ * (x)) / (r << shift); \
-      if (delta < 0) delta = -delta; \
-      if (delta < min_diff) min_diff = delta, vm = m, va = a, vr = r; } }
-
-static void tgafb_set_pll(int f)
-{
-    int                 n, shift, base, min_diff, target;
-    int                 r,a,m,vm = 34, va = 1, vr = 30;
-
-    for( r = 0 ; r < 12 ; r++ )
-	TGA_WRITE_REG(!r, TGA_CLOCK_REG);
-
-    if (f > TGA_PLL_MAX_FREQ)
-	f = TGA_PLL_MAX_FREQ;
-
-    if (f >= TGA_PLL_MAX_FREQ / 2)
-	shift = 0;
-    else if (f >= TGA_PLL_MAX_FREQ / 4)
-	shift = 1;
-    else
-	shift = 2;
-
-    TGA_WRITE_REG(shift & 1, TGA_CLOCK_REG);
-    TGA_WRITE_REG(shift >> 1, TGA_CLOCK_REG);
-
-    for( r = 0 ; r < 10 ; r++ ) {
-	TGA_WRITE_REG(0, TGA_CLOCK_REG);
-    }
-
-    if (f <= 120000) {
-	TGA_WRITE_REG(0, TGA_CLOCK_REG);
-	TGA_WRITE_REG(0, TGA_CLOCK_REG);
-    }
-    else if (f <= 200000) {
-	TGA_WRITE_REG(1, TGA_CLOCK_REG);
-	TGA_WRITE_REG(0, TGA_CLOCK_REG);
-    }
-    else {
-	TGA_WRITE_REG(0, TGA_CLOCK_REG);
-	TGA_WRITE_REG(1, TGA_CLOCK_REG);
-    }
-
-    TGA_WRITE_REG(1, TGA_CLOCK_REG);
-    TGA_WRITE_REG(0, TGA_CLOCK_REG);
-    TGA_WRITE_REG(0, TGA_CLOCK_REG);
-    TGA_WRITE_REG(1, TGA_CLOCK_REG);
-    TGA_WRITE_REG(0, TGA_CLOCK_REG);
-    TGA_WRITE_REG(1, TGA_CLOCK_REG);
-
-    target = (f << shift) / TGA_PLL_BASE_FREQ;
-    min_diff = TGA_PLL_MAX_FREQ;
-
-    r = 7 / target;
-    if (!r)
-	r = 1;
-
-    base = target * r;
-    while (base < 449) {
-	for (n = base < 7 ? 7 : base ; n < base + target && n < 449; n++) {
-	m = ((n + 3) / 7) - 1;
-	a = 0;
-	DIFFCHECK((m + 1) * 7);
-	m++;
-	DIFFCHECK((m + 1) * 7);
-	m = (n / 6) - 1;
-	if( (a = n % 6))
-	    DIFFCHECK( n );
-	}
-	r++;
-	base += target;
-    }
-
-    vr--;
-
-    for( r=0; r<8 ; r++) {
-	TGA_WRITE_REG((vm >> r) & 1, TGA_CLOCK_REG);
-    }
-    for( r=0; r<8 ; r++) {
-	TGA_WRITE_REG((va >> r) & 1, TGA_CLOCK_REG);
-    }
-    for( r=0; r<7 ; r++) {
-	TGA_WRITE_REG((vr >> r) & 1, TGA_CLOCK_REG);
-    }
-    TGA_WRITE_REG(((vr >> 7) & 1)|2, TGA_CLOCK_REG);
-}
-
-
-static int tgafb_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
-                         u_int *transp, struct fb_info *info)
-{
-    if (regno > 255)
-	return 1;
-    *red = (palette[regno].red<<8) | palette[regno].red;
-    *green = (palette[regno].green<<8) | palette[regno].green;
-    *blue = (palette[regno].blue<<8) | palette[regno].blue;
-    *transp = 0;
-    return 0;
-}
-
-
-static int tgafb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
-                         u_int transp, struct fb_info *info)
-{
-    if (regno > 255)
-	return 1;
-    red >>= 8;
-    green >>= 8;
-    blue >>= 8;
-    palette[regno].red = red;
-    palette[regno].green = green;
-    palette[regno].blue = blue;
-
-#ifdef FBCON_HAS_CFB32
-    if (regno < 16 && fb_info.tga_type != TGA_TYPE_8PLANE)
-	fbcon_cfb32_cmap[regno] = (red << 16) | (green << 8) | blue;
-#endif
+	/* How to set a single color register on 24-plane cards?? */
 
-    if (fb_info.tga_type == TGA_TYPE_8PLANE) { 
-        BT485_WRITE(regno, BT485_ADDR_PAL_WRITE);
-        TGA_WRITE_REG(BT485_DATA_PAL, TGA_RAMDAC_SETUP_REG);
-        TGA_WRITE_REG(red|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
-        TGA_WRITE_REG(green|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
-        TGA_WRITE_REG(blue|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
-    }                                                    
-    /* How to set a single color register on 24-plane cards?? */
-
-    return 0;
-}
-
-#if 1
-    /*
-     *	FIXME: since I don't know how to set a single arbitrary color register
-     *  on 24-plane cards, all color palette registers have to be updated
-     */
-
-static int tgafb_set_cmap(struct fb_cmap *cmap, int kspc, int con,
-			  struct fb_info *info)
-{
-    int err;
-
-    if (!fb_display[con].cmap.len) {	/* no colormap allocated? */
-	if ((err = fb_alloc_cmap(&fb_display[con].cmap, 256, 0)))
-	    return err;
-    }
-    if (con == info->currcon) {		/* current console? */
-	err = fb_set_cmap(cmap, kspc, info);
-#if 1
-	if (fb_info.tga_type != TGA_TYPE_8PLANE)
-		tgafb_update_palette();
-#endif
-	return err;
-    } else
-	fb_copy_cmap(cmap, &fb_display[con].cmap, kspc ? 0 : 1);
-    return 0;
+	return 0;
 }
 
-static void tgafb_update_palette(void)
-{
-    int i;
 
-    BT463_LOAD_ADDR(0x0000);
-    TGA_WRITE_REG((BT463_PALETTE<<2), TGA_RAMDAC_REG);
+/**
+ *      tgafb_blank - Optional function.  Blanks the display.
+ *      @blank_mode: the blank mode we want.
+ *      @info: frame buffer structure that represents a single frame buffer
+ */
+static int
+tgafb_blank(int blank, struct fb_info *info)
+{
+	struct tga_par *par = (struct tga_par *) info->par;
+	u32 vhcr, vvcr, vvvr;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	vhcr = TGA_READ_REG(par, TGA_HORIZ_REG);
+	vvcr = TGA_READ_REG(par, TGA_VERT_REG);
+	vvvr = TGA_READ_REG(par, TGA_VALID_REG);
+	vvvr &= ~(TGA_VALID_VIDEO | TGA_VALID_BLANK);
+
+	switch (blank) {
+	case 0: /* Unblanking */
+		if (par->vesa_blanked) {
+			TGA_WRITE_REG(par, vhcr & 0xbfffffff, TGA_HORIZ_REG);
+			TGA_WRITE_REG(par, vvcr & 0xbfffffff, TGA_VERT_REG);
+			par->vesa_blanked = 0;
+		}
+		TGA_WRITE_REG(par, vvvr | TGA_VALID_VIDEO, TGA_VALID_REG);
+		break;
+
+	case 1: /* Normal blanking */
+		TGA_WRITE_REG(par, vvvr | TGA_VALID_VIDEO | TGA_VALID_BLANK,
+			      TGA_VALID_REG);
+		break;
+
+	case 2: /* VESA blank (vsync off) */
+		TGA_WRITE_REG(par, vvcr | 0x40000000, TGA_VERT_REG);
+		TGA_WRITE_REG(par, vvvr | TGA_VALID_BLANK, TGA_VALID_REG);
+		par->vesa_blanked = 1;
+		break;
+
+	case 3: /* VESA blank (hsync off) */
+		TGA_WRITE_REG(par, vhcr | 0x40000000, TGA_HORIZ_REG);
+		TGA_WRITE_REG(par, vvvr | TGA_VALID_BLANK, TGA_VALID_REG);
+		par->vesa_blanked = 1;
+		break;
+
+	case 4: /* Poweroff */
+		TGA_WRITE_REG(par, vhcr | 0x40000000, TGA_HORIZ_REG);
+		TGA_WRITE_REG(par, vvcr | 0x40000000, TGA_VERT_REG);
+		TGA_WRITE_REG(par, vvvr | TGA_VALID_BLANK, TGA_VALID_REG);
+		par->vesa_blanked = 1;
+		break;
+	}
 
-    for (i = 0; i < 256; i++) {
-	 TGA_WRITE_REG(palette[i].red|(BT463_PALETTE<<10), TGA_RAMDAC_REG);
-	 TGA_WRITE_REG(palette[i].green|(BT463_PALETTE<<10), TGA_RAMDAC_REG);
-	 TGA_WRITE_REG(palette[i].blue|(BT463_PALETTE<<10), TGA_RAMDAC_REG);
-    }
+	local_irq_restore(flags);
+	return 0;
 }
-#endif
 
 
-static int tgafb_blank(int blank, struct fb_info_gen *info)
-{
-    static int tga_vesa_blanked = 0;
-    u32 vhcr, vvcr, vvvr;
-    unsigned long flags;
-    
-    local_irq_save(flags);
-
-    vhcr = TGA_READ_REG(TGA_HORIZ_REG);
-    vvcr = TGA_READ_REG(TGA_VERT_REG);
-    vvvr = TGA_READ_REG(TGA_VALID_REG) & ~(TGA_VALID_VIDEO | TGA_VALID_BLANK);
-
-    switch (blank) {
-    case 0: /* Unblanking */
-        if (tga_vesa_blanked) {
-	   TGA_WRITE_REG(vhcr & 0xbfffffff, TGA_HORIZ_REG);
-	   TGA_WRITE_REG(vvcr & 0xbfffffff, TGA_VERT_REG);
-	   tga_vesa_blanked = 0;
-	}
- 	TGA_WRITE_REG(vvvr | TGA_VALID_VIDEO, TGA_VALID_REG);
-	break;
-
-    case 1: /* Normal blanking */
-	TGA_WRITE_REG(vvvr | TGA_VALID_VIDEO | TGA_VALID_BLANK, TGA_VALID_REG);
-	break;
-
-    case 2: /* VESA blank (vsync off) */
-	TGA_WRITE_REG(vvcr | 0x40000000, TGA_VERT_REG);
-	TGA_WRITE_REG(vvvr | TGA_VALID_BLANK, TGA_VALID_REG);
-	tga_vesa_blanked = 1;
-	break;
-
-    case 3: /* VESA blank (hsync off) */
-	TGA_WRITE_REG(vhcr | 0x40000000, TGA_HORIZ_REG);
-	TGA_WRITE_REG(vvvr | TGA_VALID_BLANK, TGA_VALID_REG);
-	tga_vesa_blanked = 1;
-	break;
-
-    case 4: /* Poweroff */
-	TGA_WRITE_REG(vhcr | 0x40000000, TGA_HORIZ_REG);
-	TGA_WRITE_REG(vvcr | 0x40000000, TGA_VERT_REG);
-	TGA_WRITE_REG(vvvr | TGA_VALID_BLANK, TGA_VALID_REG);
-	tga_vesa_blanked = 1;
-	break;
-    }
-
-    local_irq_restore(flags);
-    return 0;
-}
-
+/*
+ *  Initialisation
+ */
 
-static void tgafb_set_disp(const void *fb_par, struct display *disp,
-	struct fb_info_gen *info)
+static void
+tgafb_init_fix(struct fb_info *info)
 {
-    switch (fb_info.tga_type) {
-#ifdef FBCON_HAS_CFB8
+	struct tga_par *par = (struct tga_par *)info->par;
+	u8 tga_type = par->tga_type;
+	const char *tga_type_name;
+
+	switch (tga_type) {
 	case TGA_TYPE_8PLANE:
-	    disp->dispsw = &fbcon_cfb8;
-            break;
-#endif
-#ifdef FBCON_HAS_CFB32
-        case TGA_TYPE_24PLANE:
-        case TGA_TYPE_24PLUSZ:
-	    disp->dispsw = &fbcon_cfb32; 
-            disp->dispsw_data = &fbcon_cfb32_cmap;
-            break;
-#endif
-        default:
-            disp->dispsw = &fbcon_dummy;
-    }
+		tga_type_name = "Digital ZLXp-E1";
+		break;
+	case TGA_TYPE_24PLANE:
+		tga_type_name = "Digital ZLXp-E2";
+		break;
+	case TGA_TYPE_24PLUSZ:
+		tga_type_name = "Digital ZLXp-E3";
+		break;
+	default:
+		tga_type_name = "Unknown";
+		break;
+	}
 
-    disp->scrollmode = SCROLL_YREDRAW;
-}
+	strncpy(info->fix.id, tga_type_name, sizeof(info->fix.id) - 1);
+	info->fix.id[sizeof(info->fix.id)-1] = 0;
 
+	info->fix.type = FB_TYPE_PACKED_PIXELS;
+	info->fix.type_aux = 0;
+	info->fix.visual = (tga_type == TGA_TYPE_8PLANE
+			    ? FB_VISUAL_PSEUDOCOLOR
+			    : FB_VISUAL_TRUECOLOR);
+
+	info->fix.line_length = par->xres * (par->bits_per_pixel >> 3);
+	info->fix.smem_start = (size_t) par->tga_fb_base;
+	info->fix.smem_len = info->fix.line_length * par->yres;
+	info->fix.mmio_start = (size_t) par->tga_regs_base;
+	info->fix.mmio_len = 0x1000;		/* Is this sufficient? */
+
+	info->fix.xpanstep = 0;
+	info->fix.ypanstep = 0;
+	info->fix.ywrapstep = 0;
+
+	info->fix.accel = FB_ACCEL_DEC_TGA;
+}
+
+static __devinit int
+tgafb_pci_register(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	static unsigned int const fb_offset_presets[4] = {
+		TGA_8PLANE_FB_OFFSET,
+		TGA_24PLANE_FB_OFFSET,
+		0xffffffff,
+		TGA_24PLUSZ_FB_OFFSET
+	};
+
+	struct all_info {
+		struct fb_info info;
+		struct tga_par par;
+		u32 pseudo_palette[16];
+	} *all;
+
+	void *mem_base;
+	unsigned long bar0_start, bar0_len;
+	u8 tga_type;
+	int ret;
+
+	/* Enable device in PCI config.  */
+	if (pci_enable_device(pdev)) {
+		printk(KERN_ERR "tgafb: Cannot enable PCI device\n");
+		return -ENODEV;
+	}
 
-struct fbgen_hwswitch tgafb_hwswitch = {
-    tgafb_detect, tgafb_encode_fix, tgafb_decode_var, tgafb_encode_var, tgafb_get_par,
-    tgafb_set_par, tgafb_getcolreg, NULL, tgafb_blank, 
-    tgafb_set_disp
-};
+	/* Allocate the fb and par structures.  */
+	all = kmalloc(sizeof(*all), GFP_KERNEL);
+	if (!all) {
+		printk(KERN_ERR "tgafb: Cannot allocate memory\n");
+		return -ENOMEM;
+	}
+	memset(all, 0, sizeof(*all));
 
+	/* Request the mem regions.  */
+	bar0_start = pci_resource_start(pdev, 0);
+	bar0_len = pci_resource_len(pdev, 0);
+	ret = -ENODEV;
+	if (!request_mem_region (bar0_start, bar0_len, "tgafb")) {
+		printk(KERN_ERR "tgafb: cannot reserve FB region\n");
+		goto err0;
+	}
 
-    /*
-     *  Hardware Independent functions
-     */
+	/* Map the framebuffer.  */
+	mem_base = ioremap(bar0_start, bar0_len);
+	if (!mem_base) {
+		printk(KERN_ERR "tgafb: Cannot map MMIO\n");
+		goto err1;
+	}
 
+	/* Grab info about the card.  */
+	tga_type = (readl(mem_base) >> 12) & 0x0f;
+	all->par.pdev = pdev;
+	all->par.tga_mem_base = mem_base;
+	all->par.tga_fb_base = mem_base + fb_offset_presets[tga_type];
+	all->par.tga_regs_base = mem_base + TGA_REGS_OFFSET;
+	all->par.tga_type = tga_type;
+	pci_read_config_byte(pdev, PCI_REVISION_ID, &all->par.tga_chip_rev);
+
+	pci_set_drvdata(pdev, &all->info);
+
+	/* Setup framebuffer.  */
+	all->info.node = NODEV;
+	all->info.flags = FBINFO_FLAG_DEFAULT;
+	all->info.fbops = &tgafb_ops;
+	all->info.currcon = -1;
+	all->info.par = &all->par;
+	all->info.pseudo_palette = all->pseudo_palette;
+
+	/* This should give a reasonable default video mode.  */
+
+	ret = fb_find_mode(&all->info.var, &all->info, mode_option,
+			   NULL, 0, NULL,
+			   tga_type == TGA_TYPE_8PLANE ? 8 : 32);
+	if (ret == 0 || ret == 4) {
+		printk(KERN_ERR "tgafb: Could not find valid video mode\n");
+		ret = -EINVAL;
+		goto err1;
+	}
 
-    /* 
-     *  Frame buffer operations
-     */
+	if (fb_alloc_cmap(&all->info.cmap, 256, 0)) {
+		printk(KERN_ERR "tgafb: Could not allocate color map\n");
+		ret = -ENOMEM;
+		goto err1;
+	}
 
-static struct fb_ops tgafb_ops = {
-	.owner =	THIS_MODULE,
-	.fb_get_fix =	fbgen_get_fix,
-	.fb_get_var =	fbgen_get_var,
-	.fb_set_var =	fbgen_set_var,
-	.fb_get_cmap =	fbgen_get_cmap,
-	.fb_set_cmap =	tgafb_set_cmap,
-	.fb_setcolreg =	tgafb_setcolreg,
-	.fb_blank =	fbgen_blank,
-};
+	tgafb_set_par(&all->info);
+	tgafb_init_fix(&all->info);
 
+	if (register_framebuffer(&all->info) < 0) {
+		printk(KERN_ERR "tgafb: Could not register framebuffer\n");
+		ret = -EINVAL;
+		goto err1;
+	}
 
-#ifndef MODULE
-    /*
-     *  Setup
-     */
-
-int __init tgafb_setup(char *options) {
-    char *this_opt;
-    int i;
-    
-    if (options && *options) {
-    	while ((this_opt = strsep(&options, ",")) != NULL) {
-       	    if (!*this_opt) { continue; }
-        
-	    if (!strncmp(this_opt, "font:", 5)) {
-	     	strncpy(default_fontname, this_opt+5, sizeof default_fontname);
-	    }
-
-	    else if (!strncmp(this_opt, "mode:", 5)) {
-    		for (i = 0; i < NUM_TOTAL_MODES; i++) {
-    		    if (!strcmp(this_opt+5, tgafb_predefined[i].name))
-    			default_var = tgafb_predefined[i].var;
-		    	default_var_valid = 1;
-    		}
-    	    } 
-	    
-	    else {
-      		printk(KERN_ERR "tgafb: unknown parameter %s\n", this_opt);
-    	    }
-      	}
-    }
-    return 0;
+	printk(KERN_INFO "tgafb: DC21030 [TGA] detected, rev=0x%02x\n",
+	       all->par.tga_chip_rev);
+	printk(KERN_INFO "tgafb: at PCI bus %d, device %d, function %d\n",
+	       pdev->bus->number, PCI_SLOT(pdev->devfn),
+	       PCI_FUNC(pdev->devfn));
+	printk(KERN_INFO "fb%d: %s frame buffer device at 0x%lx\n",
+	       minor(all->info.node), all->info.fix.id, bar0_start);
+
+	return 0;
+
+ err1:
+	release_mem_region(bar0_start, bar0_len);
+ err0:
+	kfree(all);
+	return ret;
 }
-#endif
-
 
-    /*
-     *  Initialisation
-     */
-
-int __init tgafb_init(void)
-{
-    struct pci_dev *pdev;
-
-    pdev = pci_find_device(PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_DEC_TGA, NULL);
-    if (!pdev)
-	return -ENXIO;
-
-    /* divine board type */
-
-    fb_info.tga_mem_base = (unsigned long)ioremap(pdev->resource[0].start, 0);
-    fb_info.tga_type = (readl(fb_info.tga_mem_base) >> 12) & 0x0f;
-    fb_info.tga_regs_base = fb_info.tga_mem_base + TGA_REGS_OFFSET;
-    fb_info.tga_fb_base = (fb_info.tga_mem_base
-			   + fb_offset_presets[fb_info.tga_type]);
-    pci_read_config_byte(pdev, PCI_REVISION_ID, &fb_info.tga_chip_rev);
-
-    /* setup framebuffer */
-
-    fb_info.gen.info.node = NODEV;
-    fb_info.gen.info.flags = FBINFO_FLAG_DEFAULT;
-    fb_info.gen.info.fbops = &tgafb_ops;
-    fb_info.gen.info.screen_base = (char *)fb_info.tga_fb_base;
-    fb_info.gen.info.disp = &disp;
-    fb_info.gen.info.currcon = -1;	
-    fb_info.gen.info.changevar = NULL;
-    fb_info.gen.info.switch_con = &fbgen_switch;
-    fb_info.gen.info.updatevar = &fbgen_update_var;
-    strcpy(fb_info.gen.info.fontname, default_fontname);
-    fb_info.gen.parsize = sizeof (struct tgafb_par);
-    fb_info.gen.fbhw = &tgafb_hwswitch;
-    fb_info.gen.fbhw->detect();
-
-    printk (KERN_INFO "tgafb: DC21030 [TGA] detected, rev=0x%02x\n", fb_info.tga_chip_rev);
-    printk (KERN_INFO "tgafb: at PCI bus %d, device %d, function %d\n", 
-	    pdev->bus->number, PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
-	    
-    switch (fb_info.tga_type) 
-    { 
-	case TGA_TYPE_8PLANE:
-	    strcpy (fb_info.gen.info.modename,"Digital ZLXp-E1"); 
-	    break;
-
-	case TGA_TYPE_24PLANE:
-	    strcpy (fb_info.gen.info.modename,"Digital ZLXp-E2"); 
-	    break;
+int __init
+tgafb_init(void)
+{
+	return pci_module_init(&tgafb_driver);
+}
 
-	case TGA_TYPE_24PLUSZ:
-	    strcpy (fb_info.gen.info.modename,"Digital ZLXp-E3"); 
-	    break;
-    }
+#ifdef MODULE
+static void __exit
+tgafb_pci_unregister(struct pci_dev *pdev)
+{
+	struct fb_info *info = pci_get_drvdata(pdev);
+	struct tga_par *par = info->par;
 
-    /* This should give a reasonable default video mode */
+	if (!info)
+		return;
+	unregister_framebuffer(info);
+	iounmap(par->tga_mem_base);
+	release_mem_region(pci_resource_start(pdev, 0),
+			   pci_resource_len(pdev, 0));
+	kfree(info);
+}
 
-    if (!default_var_valid) {
-	default_var = tgafb_predefined[0].var;
-    }
-    fbgen_get_var(&disp.var, -1, &fb_info.gen.info);
-    disp.var.activate = FB_ACTIVATE_NOW;
-    fbgen_do_set_var(&disp.var, 1, &fb_info.gen);
-    fbgen_set_disp(-1, &fb_info.gen);
-    do_install_cmap(0, &fb_info.gen);
-    if (register_framebuffer(&fb_info.gen.info) < 0)
-	return -EINVAL;
-    printk(KERN_INFO "fb%d: %s frame buffer device at 0x%lx\n", 
-	    minor(fb_info.gen.info.node), fb_info.gen.info.modename, 
-	    pdev->resource[0].start);
-    return 0;
+static void __exit
+tgafb_exit(void)
+{
+	pci_unregister_driver(&tgafb_driver);
 }
+#endif /* MODULE */
 
+#ifndef MODULE
+int __init
+tgafb_setup(char *arg)
+{
+	char *this_opt;
 
-    /*
-     *  Cleanup
-     */
+	if (arg && *arg) {
+		while ((this_opt = strsep(&arg, ","))) {
+			if (!*this_opt)
+				continue;
+			if (!strncmp(this_opt, "mode:", 5))
+				mode_option = this_opt+5;
+			else
+				printk(KERN_ERR
+				       "tgafb: unknown parameter %s\n",
+				       this_opt);
+		}
+	}
 
-void __exit tgafb_cleanup(void)
-{
-    unregister_framebuffer(&fb_info.gen.info);
+	return 0;
 }
+#endif /* !MODULE */
 
-
-    /*
-     *  Modularisation
-     */
+/*
+ *  Modularisation
+ */
 
 #ifdef MODULE
-MODULE_LICENSE("GPL");
 module_init(tgafb_init);
+module_exit(tgafb_exit);
 #endif
 
-module_exit(tgafb_cleanup);
+MODULE_DESCRIPTION("framebuffer driver for TGA chipset");
+MODULE_LICENSE("GPL");
diff -Nru a/drivers/video/tgafb.h b/drivers/video/tgafb.h
--- a/drivers/video/tgafb.h	Fri Dec 27 15:42:56 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,199 +0,0 @@
-/*
- *  linux/drivers/video/tgafb.h -- DEC 21030 TGA frame buffer device
- *
- *  	Copyright (C) 1999,2000 Martin Lucina, Tom Zerucha
- *  
- *  $Id: tgafb.h,v 1.4.2.3 2000/04/04 06:44:56 mato Exp $
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License. See the file COPYING in the main directory of this archive for
- *  more details.
- */
-
-#ifndef TGAFB_H
-#define TGAFB_H
-
-    /*
-     * TGA hardware description (minimal)
-     */
-
-#define TGA_TYPE_8PLANE			0
-#define TGA_TYPE_24PLANE		1
-#define TGA_TYPE_24PLUSZ		3
-
-    /*
-     * Offsets within Memory Space
-     */
-
-#define	TGA_ROM_OFFSET			0x0000000
-#define	TGA_REGS_OFFSET			0x0100000
-#define	TGA_8PLANE_FB_OFFSET		0x0200000
-#define	TGA_24PLANE_FB_OFFSET		0x0804000
-#define	TGA_24PLUSZ_FB_OFFSET		0x1004000
-
-#define	TGA_PLANEMASK_REG		0x0028
-#define	TGA_MODE_REG			0x0030
-#define	TGA_RASTEROP_REG		0x0034
-#define	TGA_PIXELSHIFT_REG		0x0038
-#define	TGA_DEEP_REG			0x0050
-#define	TGA_PIXELMASK_REG		0x005c
-#define	TGA_CURSOR_BASE_REG		0x0060
-#define	TGA_HORIZ_REG			0x0064
-#define	TGA_VERT_REG			0x0068
-#define	TGA_BASE_ADDR_REG		0x006c
-#define	TGA_VALID_REG			0x0070
-#define	TGA_CURSOR_XY_REG		0x0074
-#define	TGA_INTR_STAT_REG		0x007c
-#define	TGA_RAMDAC_SETUP_REG		0x00c0
-#define	TGA_BLOCK_COLOR0_REG		0x0140
-#define	TGA_BLOCK_COLOR1_REG		0x0144
-#define	TGA_CLOCK_REG			0x01e8
-#define	TGA_RAMDAC_REG			0x01f0
-#define	TGA_CMD_STAT_REG		0x01f8
-
-
-    /* 
-     * useful defines for managing the registers
-     */
-
-#define TGA_HORIZ_ODD			0x80000000
-#define TGA_HORIZ_POLARITY		0x40000000
-#define TGA_HORIZ_ACT_MSB		0x30000000
-#define TGA_HORIZ_BP			0x0fe00000
-#define TGA_HORIZ_SYNC			0x001fc000
-#define TGA_HORIZ_FP			0x00007c00
-#define TGA_HORIZ_ACT_LSB		0x000001ff
-
-#define TGA_VERT_SE			0x80000000
-#define TGA_VERT_POLARITY		0x40000000
-#define TGA_VERT_RESERVED		0x30000000
-#define TGA_VERT_BP			0x0fc00000
-#define TGA_VERT_SYNC			0x003f0000
-#define TGA_VERT_FP			0x0000f800
-#define TGA_VERT_ACTIVE			0x000007ff
-
-#define TGA_VALID_VIDEO			0x01
-#define TGA_VALID_BLANK			0x02
-#define TGA_VALID_CURSOR		0x04
-
-
-    /*
-     * useful defines for managing the ICS1562 PLL clock
-     */
-
-#define TGA_PLL_BASE_FREQ 		14318		/* .18 */
-#define TGA_PLL_MAX_FREQ 		230000
-
-
-    /*
-     * useful defines for managing the BT485 on the 8-plane TGA
-     */
-
-#define	BT485_READ_BIT			0x01
-#define	BT485_WRITE_BIT			0x00
-
-#define	BT485_ADDR_PAL_WRITE		0x00
-#define	BT485_DATA_PAL			0x02
-#define	BT485_PIXEL_MASK		0x04
-#define	BT485_ADDR_PAL_READ		0x06
-#define	BT485_ADDR_CUR_WRITE		0x08
-#define	BT485_DATA_CUR			0x0a
-#define	BT485_CMD_0			0x0c
-#define	BT485_ADDR_CUR_READ		0x0e
-#define	BT485_CMD_1			0x10
-#define	BT485_CMD_2			0x12
-#define	BT485_STATUS			0x14
-#define	BT485_CMD_3			0x14
-#define	BT485_CUR_RAM			0x16
-#define	BT485_CUR_LOW_X			0x18
-#define	BT485_CUR_HIGH_X		0x1a
-#define	BT485_CUR_LOW_Y			0x1c
-#define	BT485_CUR_HIGH_Y		0x1e
-
-
-    /*
-     * useful defines for managing the BT463 on the 24-plane TGAs
-     */
-
-#define	BT463_ADDR_LO		0x0
-#define	BT463_ADDR_HI		0x1
-#define	BT463_REG_ACC		0x2
-#define	BT463_PALETTE		0x3
-
-#define	BT463_CUR_CLR_0		0x0100
-#define	BT463_CUR_CLR_1		0x0101
-
-#define	BT463_CMD_REG_0		0x0201
-#define	BT463_CMD_REG_1		0x0202
-#define	BT463_CMD_REG_2		0x0203
-
-#define	BT463_READ_MASK_0	0x0205
-#define	BT463_READ_MASK_1	0x0206
-#define	BT463_READ_MASK_2	0x0207
-#define	BT463_READ_MASK_3	0x0208
-
-#define	BT463_BLINK_MASK_0	0x0209
-#define	BT463_BLINK_MASK_1	0x020a
-#define	BT463_BLINK_MASK_2	0x020b
-#define	BT463_BLINK_MASK_3	0x020c
-
-#define	BT463_WINDOW_TYPE_BASE	0x0300
-
-
-    /*
-     * Macros for reading/writing TGA and RAMDAC registers
-     */
-
-#define TGA_WRITE_REG(v,r) \
-	{ writel((v), fb_info.tga_regs_base+(r)); mb(); }
-
-#define TGA_READ_REG(r) readl(fb_info.tga_regs_base+(r))
-
-#define BT485_WRITE(v,r) \
-	  TGA_WRITE_REG((r),TGA_RAMDAC_SETUP_REG);		\
-	  TGA_WRITE_REG(((v)&0xff)|((r)<<8),TGA_RAMDAC_REG);
-
-#define BT463_LOAD_ADDR(a) \
-	TGA_WRITE_REG(BT463_ADDR_LO<<2, TGA_RAMDAC_SETUP_REG); \
-	TGA_WRITE_REG((BT463_ADDR_LO<<10)|((a)&0xff), TGA_RAMDAC_REG); \
-	TGA_WRITE_REG(BT463_ADDR_HI<<2, TGA_RAMDAC_SETUP_REG); \
-	TGA_WRITE_REG((BT463_ADDR_HI<<10)|(((a)>>8)&0xff), TGA_RAMDAC_REG);
-
-#define BT463_WRITE(m,a,v) \
-	BT463_LOAD_ADDR((a)); \
-	TGA_WRITE_REG(((m)<<2),TGA_RAMDAC_SETUP_REG); \
-	TGA_WRITE_REG(((m)<<10)|((v)&0xff),TGA_RAMDAC_REG);
-
-
-    /*
-     *  This structure describes the board.
-     */
-
-struct tgafb_info {
-    /* Use the generic framebuffer ops */
-    struct fb_info_gen gen;
-
-    /* Device dependent information */
-    u8 tga_type;					/* TGA_TYPE_XXX */
-    u8 tga_chip_rev;					/* dc21030 revision */
-    u64 tga_mem_base;
-    u64 tga_fb_base;
-    u64 tga_regs_base;
-    struct fb_var_screeninfo default_var;		/* default video mode */
-};
-
-
-    /*
-     *  This structure uniquely defines a video mode.
-     */
-
-struct tgafb_par {
-    u32 xres, yres;				/* resolution in pixels */
-    u32 htimings;				/* horizontal timing register */
-    u32 vtimings;				/* vertical timing register */
-    u32 pll_freq;				/* pixclock in mhz */
-    u32 bits_per_pixel;				/* bits per pixel */
-    u32 sync_on_green;				/* set if sync is on green */
-};
-
-#endif /* TGAFB_H */
diff -Nru a/include/video/tgafb.h b/include/video/tgafb.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/video/tgafb.h	Fri Dec 27 15:42:56 2002
@@ -0,0 +1,210 @@
+/*
+ *  linux/drivers/video/tgafb.h -- DEC 21030 TGA frame buffer device
+ *
+ *  	Copyright (C) 1999,2000 Martin Lucina, Tom Zerucha
+ *  
+ *  $Id: tgafb.h,v 1.4.2.3 2000/04/04 06:44:56 mato Exp $
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive for
+ *  more details.
+ */
+
+#ifndef TGAFB_H
+#define TGAFB_H
+
+/*
+ * TGA hardware description (minimal)
+ */
+
+#define TGA_TYPE_8PLANE			0
+#define TGA_TYPE_24PLANE		1
+#define TGA_TYPE_24PLUSZ		3
+
+/*
+ * Offsets within Memory Space
+ */
+
+#define	TGA_ROM_OFFSET			0x0000000
+#define	TGA_REGS_OFFSET			0x0100000
+#define	TGA_8PLANE_FB_OFFSET		0x0200000
+#define	TGA_24PLANE_FB_OFFSET		0x0804000
+#define	TGA_24PLUSZ_FB_OFFSET		0x1004000
+
+#define	TGA_PLANEMASK_REG		0x0028
+#define	TGA_MODE_REG			0x0030
+#define	TGA_RASTEROP_REG		0x0034
+#define	TGA_PIXELSHIFT_REG		0x0038
+#define	TGA_DEEP_REG			0x0050
+#define	TGA_PIXELMASK_REG		0x005c
+#define	TGA_CURSOR_BASE_REG		0x0060
+#define	TGA_HORIZ_REG			0x0064
+#define	TGA_VERT_REG			0x0068
+#define	TGA_BASE_ADDR_REG		0x006c
+#define	TGA_VALID_REG			0x0070
+#define	TGA_CURSOR_XY_REG		0x0074
+#define	TGA_INTR_STAT_REG		0x007c
+#define	TGA_RAMDAC_SETUP_REG		0x00c0
+#define	TGA_BLOCK_COLOR0_REG		0x0140
+#define	TGA_BLOCK_COLOR1_REG		0x0144
+#define	TGA_CLOCK_REG			0x01e8
+#define	TGA_RAMDAC_REG			0x01f0
+#define	TGA_CMD_STAT_REG		0x01f8
+
+
+/* 
+ * Useful defines for managing the registers
+ */
+
+#define TGA_HORIZ_ODD			0x80000000
+#define TGA_HORIZ_POLARITY		0x40000000
+#define TGA_HORIZ_ACT_MSB		0x30000000
+#define TGA_HORIZ_BP			0x0fe00000
+#define TGA_HORIZ_SYNC			0x001fc000
+#define TGA_HORIZ_FP			0x00007c00
+#define TGA_HORIZ_ACT_LSB		0x000001ff
+
+#define TGA_VERT_SE			0x80000000
+#define TGA_VERT_POLARITY		0x40000000
+#define TGA_VERT_RESERVED		0x30000000
+#define TGA_VERT_BP			0x0fc00000
+#define TGA_VERT_SYNC			0x003f0000
+#define TGA_VERT_FP			0x0000f800
+#define TGA_VERT_ACTIVE			0x000007ff
+
+#define TGA_VALID_VIDEO			0x01
+#define TGA_VALID_BLANK			0x02
+#define TGA_VALID_CURSOR		0x04
+
+
+/*
+ * Useful defines for managing the ICS1562 PLL clock
+ */
+
+#define TGA_PLL_BASE_FREQ 		14318		/* .18 */
+#define TGA_PLL_MAX_FREQ 		230000
+
+
+/*
+ * Useful defines for managing the BT485 on the 8-plane TGA
+ */
+
+#define	BT485_READ_BIT			0x01
+#define	BT485_WRITE_BIT			0x00
+
+#define	BT485_ADDR_PAL_WRITE		0x00
+#define	BT485_DATA_PAL			0x02
+#define	BT485_PIXEL_MASK		0x04
+#define	BT485_ADDR_PAL_READ		0x06
+#define	BT485_ADDR_CUR_WRITE		0x08
+#define	BT485_DATA_CUR			0x0a
+#define	BT485_CMD_0			0x0c
+#define	BT485_ADDR_CUR_READ		0x0e
+#define	BT485_CMD_1			0x10
+#define	BT485_CMD_2			0x12
+#define	BT485_STATUS			0x14
+#define	BT485_CMD_3			0x14
+#define	BT485_CUR_RAM			0x16
+#define	BT485_CUR_LOW_X			0x18
+#define	BT485_CUR_HIGH_X		0x1a
+#define	BT485_CUR_LOW_Y			0x1c
+#define	BT485_CUR_HIGH_Y		0x1e
+
+
+/*
+ * Useful defines for managing the BT463 on the 24-plane TGAs
+ */
+
+#define	BT463_ADDR_LO		0x0
+#define	BT463_ADDR_HI		0x1
+#define	BT463_REG_ACC		0x2
+#define	BT463_PALETTE		0x3
+
+#define	BT463_CUR_CLR_0		0x0100
+#define	BT463_CUR_CLR_1		0x0101
+
+#define	BT463_CMD_REG_0		0x0201
+#define	BT463_CMD_REG_1		0x0202
+#define	BT463_CMD_REG_2		0x0203
+
+#define	BT463_READ_MASK_0	0x0205
+#define	BT463_READ_MASK_1	0x0206
+#define	BT463_READ_MASK_2	0x0207
+#define	BT463_READ_MASK_3	0x0208
+
+#define	BT463_BLINK_MASK_0	0x0209
+#define	BT463_BLINK_MASK_1	0x020a
+#define	BT463_BLINK_MASK_2	0x020b
+#define	BT463_BLINK_MASK_3	0x020c
+
+#define	BT463_WINDOW_TYPE_BASE	0x0300
+
+/*
+ * The framebuffer driver private data.
+ */
+
+struct tga_par {
+	/* PCI device.  */
+	struct pci_dev *pdev;
+
+	/* Device dependent information.  */
+	void *tga_mem_base;
+	void *tga_fb_base;
+	void *tga_regs_base;
+	u8 tga_type;				/* TGA_TYPE_XXX */
+	u8 tga_chip_rev;			/* dc21030 revision */
+
+	/* Remember blank mode.  */
+	u8 vesa_blanked;
+
+	/* Define the video mode.  */
+	u32 xres, yres;			/* resolution in pixels */
+	u32 htimings;			/* horizontal timing register */
+	u32 vtimings;			/* vertical timing register */
+	u32 pll_freq;			/* pixclock in mhz */
+	u32 bits_per_pixel;		/* bits per pixel */
+	u32 sync_on_green;		/* set if sync is on green */
+};
+
+
+/*
+ * Macros for reading/writing TGA and RAMDAC registers
+ */
+
+static inline void
+TGA_WRITE_REG(struct tga_par *par, u32 v, u32 r)
+{
+	writel(v, par->tga_regs_base +r);
+}
+
+static inline u32
+TGA_READ_REG(struct tga_par *par, u32 r)
+{
+	return readl(par->tga_regs_base +r);
+}
+
+static inline void
+BT485_WRITE(struct tga_par *par, u8 v, u8 r)
+{
+	TGA_WRITE_REG(par, r, TGA_RAMDAC_SETUP_REG);
+	TGA_WRITE_REG(par, v | (r << 8), TGA_RAMDAC_REG);
+}
+
+static inline void
+BT463_LOAD_ADDR(struct tga_par *par, u16 a)
+{
+	TGA_WRITE_REG(par, BT463_ADDR_LO<<2, TGA_RAMDAC_SETUP_REG);
+	TGA_WRITE_REG(par, (BT463_ADDR_LO<<10) | (a & 0xff), TGA_RAMDAC_REG);
+	TGA_WRITE_REG(par, BT463_ADDR_HI<<2, TGA_RAMDAC_SETUP_REG);
+	TGA_WRITE_REG(par, (BT463_ADDR_HI<<10) | (a >> 8), TGA_RAMDAC_REG);
+}
+
+static inline void
+BT463_WRITE(struct tga_par *par, u32 m, u16 a, u8 v)
+{
+	BT463_LOAD_ADDR(par, a);
+	TGA_WRITE_REG(par, m << 2, TGA_RAMDAC_SETUP_REG);
+	TGA_WRITE_REG(par, m << 10 | v, TGA_RAMDAC_REG);
+}
+
+#endif /* TGAFB_H */

===================================================================


This BitKeeper patch contains the following changesets:
1.956
## Wrapped with gzip_uu ##


begin 664 bkpatch3859
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
:CKS/>(+9.GG?"L+6./2:>_\#$-FU$.A?````
`
end

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=yyyy

You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.959, 2002-12-27 15:35:44-08:00, rth@are.twiddle.net
  [TGAFB] Minor bug fixes to obtain a working TGA console
  with the new FB API.


 tgafb.c |   31 +++++++++----------------------
 1 files changed, 9 insertions, 22 deletions


diff -Nru a/drivers/video/tgafb.c b/drivers/video/tgafb.c
--- a/drivers/video/tgafb.c	Fri Dec 27 15:43:57 2002
+++ b/drivers/video/tgafb.c	Fri Dec 27 15:43:57 2002
@@ -1,32 +1,16 @@
 /*
  *  linux/drivers/video/tgafb.c -- DEC 21030 TGA frame buffer device
  *
- *	Copyright (C) 1999,2000 Martin Lucina, Tom Zerucha
- *
- *  $Id: tgafb.c,v 1.12.2.3 2000/04/04 06:44:56 mato Exp $
- *
- *  This driver is partly based on the original TGA framebuffer device, which
- *  was partly based on the original TGA console driver, which are
- *
- *	Copyright (C) 1997 Geert Uytterhoeven
  *	Copyright (C) 1995 Jay Estabrook
+ *	Copyright (C) 1997 Geert Uytterhoeven
+ *	Copyright (C) 1999,2000 Martin Lucina, Tom Zerucha
+ *	Copyright (C) 2002 Richard Henderson
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for
  *  more details.
  */
 
-/* KNOWN PROBLEMS/TO DO ===================================================== *
- *
- *	- How to set a single color register on 24-plane cards?
- *
- *	- Hardware cursor/other text acceleration methods
- *
- *	- Some redraws can stall kernel for several seconds
- *	  [This should now be solved by the fast memmove() patch in 2.3.6]
- *
- * KNOWN PROBLEMS/TO DO ==================================================== */
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -76,6 +60,7 @@
 	.fb_fillrect		= cfb_fillrect,
 	.fb_copyarea		= cfb_copyarea,
 	.fb_imageblit		= cfb_imageblit,
+	.fb_cursor		= soft_cursor,
 };
 
 
@@ -446,8 +431,10 @@
 		TGA_WRITE_REG(par, red|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
 		TGA_WRITE_REG(par, green|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
 		TGA_WRITE_REG(par, blue|(BT485_DATA_PAL<<8),TGA_RAMDAC_REG);
+	} else if (regno < 16) {
+		u32 value = (red << 16) | (green << 8) | blue;
+		((u32 *)info->pseudo_palette)[regno] = value;
 	}
-	/* How to set a single color register on 24-plane cards?? */
 
 	return 0;
 }
@@ -594,6 +581,7 @@
 		return -ENOMEM;
 	}
 	memset(all, 0, sizeof(*all));
+	pci_set_drvdata(pdev, all);
 
 	/* Request the mem regions.  */
 	bar0_start = pci_resource_start(pdev, 0);
@@ -620,12 +608,11 @@
 	all->par.tga_type = tga_type;
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &all->par.tga_chip_rev);
 
-	pci_set_drvdata(pdev, &all->info);
-
 	/* Setup framebuffer.  */
 	all->info.node = NODEV;
 	all->info.flags = FBINFO_FLAG_DEFAULT;
 	all->info.fbops = &tgafb_ops;
+	all->info.screen_base = (char *) all->par.tga_fb_base;
 	all->info.currcon = -1;
 	all->info.par = &all->par;
 	all->info.pseudo_palette = all->pseudo_palette;

===================================================================


This BitKeeper patch contains the following changesets:
1.959
## Wrapped with gzip_uu ##


begin 664 bkpatch3904
M'XL(`+[E##X``[55[V\:1Q#]?/M7C)0OD)IC=^\7AX,5&R<.2J):;ORE4826
MO8$[^;@][2U0J]?_O7.X=1**'"5M`2'MS-NY-^\]Q#.X;="./>MR]@S>F,:-
M/671=[LBRTKT*W14OS&&ZL/<K'%(R.'%VZ%;J8'T(T;=:^5T#ENTS=@3?O!8
M<?<UCKV;5U>W[\YO&)M,8)JK:H6_H(/)A#ECMZK,FI?*Y:6I?&=5U:S1*5^;
M=?L(;27GDMZ12`(>Q:V(>9BT6F1"J%!@QF4XBD-&M%X>$#^8(:1,9$#?81M(
MF2;L$H2?1BEP.11R*!,0T3B(QF$XX*,QYW!D)/PD8,#9!?RWY*=,P\</5^>O
M+S[!^Z(R%A:;%2R+W["A)X%9.%54H&!G[%U1K8"@H$W5F!+IYJYP)':.4.$.
M7E_`^?7,9V\AD`$/V/5GT=G@.U^,<<79V3>6S6S1>3_<%AF:+A?+A:^_6#SD
M(FZ)2I"V<:B%7N@HC8-%&H?1,8F?F/?@8!#)E(YQD.PS=13^[7S]"]9'L_8D
MZU@&412F;11RSO>Y$\EA[&3Z5.Q2&$CYO^3N/,M@N9CKC6TH=[DQ=SY5N]]H
MW>`F,_-:E>@<`B6P0:=-:9&R2=A`#A9UW:&GJBRAUL6<`//,;C/E%*"R98'V
M[VE%M31^HRUB-5^H!KN(/KCX,PSL;O^AR%T?-_0'LGL9PHC-A(2`P7-O:NI[
M6ZQR![UI'T2:)G"%:!W<WM-R-C>XQ>HH,#TA,3F\5]:1!.\VNJC4"7PP:_@5
M[4;GZI^W.O7AIJ">S>`-5AGM8RIV*5(0@LV2$0CF^8^J>]X$&K-T?QU/V"P,
M1T3;^P.P;$CY)?1(],K`"Q!Q'WYGGK<))%`2-@B3KIG!BX=>"[U5IW%W'G7'
M!6%.Z4*OUUUYWN]\&)Q][6W_XW[\)YJUGWE*XD6<2,XH]!W7`V][=8;;$R#7
M^P2E=(-DLUCNUZ+BX.S0[(YDIP8]'_:`6EF?K)V3!EW_]//_B,Y1WS6;]83K
.988\TNQ/);,NNJ0&````
`
end

--n8g4imXOkfNTN/H1--
