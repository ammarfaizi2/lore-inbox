Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267510AbSLRWwS>; Wed, 18 Dec 2002 17:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267512AbSLRWwS>; Wed, 18 Dec 2002 17:52:18 -0500
Received: from dp.samba.org ([66.70.73.150]:14805 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267510AbSLRWv4>;
	Wed, 18 Dec 2002 17:51:56 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15872.64993.241381.820669@argo.ozlabs.ibm.com>
Date: Thu, 19 Dec 2002 09:59:45 +1100
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: [PATCH] update chipsfb.c to new API
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch which updates chipsfb.c to the new 2.5 framebuffer
API.  It simplifies the driver quite a bit, partly because the new API
is simpler and partly because the driver really can only handle one
65550 chip, since we access the chip via inb/outb to fixed I/O port
numbers.

I have tested it on a powerbook 3400, which has a C&T 65550 video chip
with 1MB of VRAM, and it seems to work just fine, at least in 8 bit
mode.  I guess I still need to add the pseudo_palette stuff for 16 bit
mode.  Unfortunately I can't test it under X at the moment because the
X server I have installed on the 3400 is Xpmac, which doesn't work any
more because the VC_GETMODE etc. ioctls have been removed.  The 3400
is an old and slow machine with a small hard disk and an old Linux/PPC
installation on it, and I don't really want to compile up XFree86 on
it.

Paul.

--- linux-2.5/drivers/video/chipsfb.c	2002-12-10 15:20:32.000000000 +1100
+++ pmac-2.5/drivers/video/chipsfb.c	2002-12-18 22:05:59.000000000 +1100
@@ -2,7 +2,7 @@
  *  drivers/video/chipsfb.c -- frame buffer device for
  *  Chips & Technologies 65550 chip.
  *
- *  Copyright (C) 1998 Paul Mackerras
+ *  Copyright (C) 1998-2002 Paul Mackerras
  *
  *  This file is derived from the Powermac "chips" driver:
  *  Copyright (C) 1997 Fabio Riccardi.
@@ -39,34 +39,11 @@
 #include <linux/pmu.h>
 #endif
 
-#include <video/fbcon.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
-#include <video/macmodes.h>
-
-struct fb_info_chips {
-	struct fb_info info;
-	struct fb_fix_screeninfo fix;
-	struct fb_var_screeninfo var;
-	struct display disp;
-	struct {
-		__u8 red, green, blue;
-	} palette[256];
-	struct pci_dev *pdev;
-	unsigned long frame_buffer_phys;
-	__u8 *frame_buffer;
-	unsigned long blitter_regs_phys;
-	__u32 *blitter_regs;
-	unsigned long blitter_data_phys;
-	__u8 *blitter_data;
-	struct fb_info_chips *next;
-#ifdef CONFIG_PMAC_PBOOK
-	unsigned char *save_framebuffer;
-#endif
-#ifdef FBCON_HAS_CFB16
-	u16 fbcon_cfb16_cmap[16];
-#endif
-};
+/*
+ * Since we access the display with inb/outb to fixed port numbers,
+ * we can only handle one 6555x chip.  -- paulus
+ */
+static struct fb_info chipsfb_info;
 
 #define write_ind(num, val, ap, dp)	do { \
 	outb((num), (ap)); outb((val), (dp)); \
@@ -98,9 +75,8 @@
 	inb(0x3da); read_ind(num, var, 0x3c0, 0x3c1); \
 } while (0)
 
-static struct fb_info_chips *all_chips;
-
 #ifdef CONFIG_PMAC_PBOOK
+static unsigned char *save_framebuffer;
 int chips_sleep_notify(struct pmu_sleep_notifier *self, int when);
 static struct pmu_sleep_notifier chips_sleep_notifier = {
 	chips_sleep_notify, SLEEP_LEVEL_VIDEO,
@@ -112,58 +88,29 @@
  */
 int chips_init(void);
 
-static void chips_pci_init(struct pci_dev *dp);
-static int chips_get_fix(struct fb_fix_screeninfo *fix, int con,
-			 struct fb_info *info);
-static int chips_get_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info);
-static int chips_set_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info);
-static int chips_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-			  struct fb_info *info);
+static int chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *);
+static int chipsfb_check_var(struct fb_var_screeninfo *var,
+			     struct fb_info *info);
+static int chipsfb_set_par(struct fb_info *info);
 static int chipsfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			     u_int transp, struct fb_info *info);
 static int chipsfb_blank(int blank, struct fb_info *info);
 
 static struct fb_ops chipsfb_ops = {
-	.owner =	THIS_MODULE,
-	.fb_get_fix =	chips_get_fix,
-	.fb_get_var =	chips_get_var,
-	.fb_set_var =	chips_set_var,
-	.fb_get_cmap =	chips_get_cmap,
-	.fb_set_cmap =	gen_set_cmap,
-	.fb_setcolreg =	chipsfb_setcolreg,
-	.fb_blank =	chipsfb_blank,
-};
-
-static int chipsfb_getcolreg(u_int regno, u_int *red, u_int *green,
-			     u_int *blue, u_int *transp, struct fb_info *info);
-static void chips_set_bitdepth(struct fb_info_chips *p, struct display* disp, int con, int bpp);
-
-static int chips_get_fix(struct fb_fix_screeninfo *fix, int con,
-			 struct fb_info *info)
-{
-	struct fb_info_chips *cp = (struct fb_info_chips *) info;
-
-	*fix = cp->fix;
-	return 0;
-}
-
-static int chips_get_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info)
-{
-	struct fb_info_chips *cp = (struct fb_info_chips *) info;
-
-	*var = cp->var;
-	return 0;
-}
+	.owner		= THIS_MODULE,
+	.fb_check_var	= chipsfb_check_var,
+	.fb_set_par	= chipsfb_set_par,
+	.fb_setcolreg	= chipsfb_setcolreg,
+	.fb_blank	= chipsfb_blank,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+	.fb_cursor	= soft_cursor,
+};
 
-static int chips_set_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info)
+static int chipsfb_check_var(struct fb_var_screeninfo *var,
+			     struct fb_info *info)
 {
-	struct fb_info_chips *cp = (struct fb_info_chips *) info;
-	struct display *disp = (con >= 0)? &fb_display[con]: &cp->disp;
-
 	if (var->xres > 800 || var->yres > 600
 	    || var->xres_virtual > 800 || var->yres_virtual > 600
 	    || (var->bits_per_pixel != 8 && var->bits_per_pixel != 16)
@@ -171,198 +118,76 @@
 	    || (var->vmode & FB_VMODE_MASK) != FB_VMODE_NONINTERLACED)
 		return -EINVAL;
 
-	if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW &&
-		var->bits_per_pixel != disp->var.bits_per_pixel) {
-		chips_set_bitdepth(cp, disp, con, var->bits_per_pixel);
-	}
+	var->xres = var->xres_virtual = 800;
+	var->yres = var->yres_virtual = 600;
 
 	return 0;
 }
 
-static int chips_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-			  struct fb_info *info)
+static int chipsfb_set_par(struct fb_info *info)
 {
-	if (con == info->currcon)		/* current console? */
-		return fb_get_cmap(cmap, kspc, chipsfb_getcolreg, info);
-	if (fb_display[con].cmap.len)	/* non default colormap? */
-		fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
-	else {
-		int size = fb_display[con].var.bits_per_pixel == 16 ? 32 : 256;
-		fb_copy_cmap(fb_default_cmap(size), cmap, kspc ? 0 : 2);
+	if (info->var.bits_per_pixel == 16) {
+		write_cr(0x13, 200);		// Set line length (doublewords)
+		write_xr(0x81, 0x14);		// 15 bit (555) color mode
+		write_xr(0x82, 0x00);		// Disable palettes
+		write_xr(0x20, 0x10);		// 16 bit blitter mode
+
+		info->fix.line_length = 800*2;
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+
+		info->var.red.offset = 10;
+		info->var.green.offset = 5;
+		info->var.blue.offset = 0;
+		info->var.red.length = info->var.green.length =
+			info->var.blue.length = 5;
+		
+	} else {
+		/* p->var.bits_per_pixel == 8 */
+		write_cr(0x13, 100);		// Set line length (doublewords)
+		write_xr(0x81, 0x12);		// 8 bit color mode
+		write_xr(0x82, 0x08);		// Graphics gamma enable
+		write_xr(0x20, 0x00);		// 8 bit blitter mode
+
+		info->fix.line_length = 800;
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;		
+
+ 		info->var.red.offset = info->var.green.offset =
+			info->var.blue.offset = 0;
+		info->var.red.length = info->var.green.length =
+			info->var.blue.length = 8;
+		
 	}
 	return 0;
 }
 
-static int chipsfbcon_switch(int con, struct fb_info *info)
-{
-	struct fb_info_chips *p = (struct fb_info_chips *) info;
-	int new_bpp, old_bpp;
-
-	/* Do we have to save the colormap? */
-	if (fb_display[info->currcon].cmap.len)
-		fb_get_cmap(&fb_display[info->currcon].cmap, 1, chipsfb_getcolreg, info);
-
-	new_bpp = fb_display[con].var.bits_per_pixel;
-	old_bpp = fb_display[info->currcon].var.bits_per_pixel;
-	info->currcon = con;
-
-	if (new_bpp != old_bpp)
-		chips_set_bitdepth(p, &fb_display[con], con, new_bpp);
-	
-	do_install_cmap(con, info);
-	return 0;
-}
-
-static int chipsfb_updatevar(int con, struct fb_info *info)
-{
-	return 0;
-}
-
 static int chipsfb_blank(int blank, struct fb_info *info)
 {
-	struct fb_info_chips *p = (struct fb_info_chips *) info;
-	int i;
-
+#ifdef CONFIG_PMAC_BACKLIGHT
 	// used to disable backlight only for blank > 1, but it seems
 	// useful at blank = 1 too (saves battery, extends backlight life)
-	if (blank) {
-#ifdef CONFIG_PMAC_BACKLIGHT
-		set_backlight_enable(0);
-#endif /* CONFIG_PMAC_BACKLIGHT */
-		/* get the palette from the chip */
-		for (i = 0; i < 256; ++i) {
-			outb(i, 0x3c7);
-			udelay(1);
-			p->palette[i].red = inb(0x3c9);
-			p->palette[i].green = inb(0x3c9);
-			p->palette[i].blue = inb(0x3c9);
-		}
-		for (i = 0; i < 256; ++i) {
-			outb(i, 0x3c8);
-			udelay(1);
-			outb(0, 0x3c9);
-			outb(0, 0x3c9);
-			outb(0, 0x3c9);
-		}
-	} else {
-#ifdef CONFIG_PMAC_BACKLIGHT
-		set_backlight_enable(1);
+	set_backlight_enable(!blank);
 #endif /* CONFIG_PMAC_BACKLIGHT */
-		for (i = 0; i < 256; ++i) {
-			outb(i, 0x3c8);
-			udelay(1);
-			outb(p->palette[i].red, 0x3c9);
-			outb(p->palette[i].green, 0x3c9);
-			outb(p->palette[i].blue, 0x3c9);
-		}
-	}
-	return 0;
-}
-
-static int chipsfb_getcolreg(u_int regno, u_int *red, u_int *green,
-			     u_int *blue, u_int *transp, struct fb_info *info)
-{
-	struct fb_info_chips *p = (struct fb_info_chips *) info;
 
-	if (regno > 255)
-		return 1;
-	*red = (p->palette[regno].red<<8) | p->palette[regno].red;
-	*green = (p->palette[regno].green<<8) | p->palette[regno].green;
-	*blue = (p->palette[regno].blue<<8) | p->palette[regno].blue;
-	*transp = 0;
-	return 0;
+	return 1;	/* get fb_blank to set the colormap to all black */
 }
 
 static int chipsfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			     u_int transp, struct fb_info *info)
 {
-	struct fb_info_chips *p = (struct fb_info_chips *) info;
-
 	if (regno > 255)
 		return 1;
 	red >>= 8;
 	green >>= 8;
 	blue >>= 8;
-	p->palette[regno].red = red;
-	p->palette[regno].green = green;
-	p->palette[regno].blue = blue;
 	outb(regno, 0x3c8);
 	udelay(1);
 	outb(red, 0x3c9);
 	outb(green, 0x3c9);
 	outb(blue, 0x3c9);
 
-#ifdef FBCON_HAS_CFB16
-	if (regno < 16)
-		p->fbcon_cfb16_cmap[regno] = ((red & 0xf8) << 7)
-			| ((green & 0xf8) << 2) | ((blue & 0xf8) >> 3);
-#endif
-
 	return 0;
 }
 
-static void chips_set_bitdepth(struct fb_info_chips *p, struct display* disp, int con, int bpp)
-{
-	int err;
-	struct fb_fix_screeninfo* fix = &p->fix;
-	struct fb_var_screeninfo* var = &p->var;
-	
-	if (bpp == 16) {
-		if (con == p->info.currcon) {
-			write_cr(0x13, 200);		// Set line length (doublewords)
-			write_xr(0x81, 0x14);		// 15 bit (555) color mode
-			write_xr(0x82, 0x00);		// Disable palettes
-			write_xr(0x20, 0x10);		// 16 bit blitter mode
-		}
-
-		fix->line_length = 800*2;
-		fix->visual = FB_VISUAL_TRUECOLOR;
-
-		var->red.offset = 10;
-		var->green.offset = 5;
-		var->blue.offset = 0;
-		var->red.length = var->green.length = var->blue.length = 5;
-		
-#ifdef FBCON_HAS_CFB16
-		disp->dispsw = &fbcon_cfb16;
-		disp->dispsw_data = p->fbcon_cfb16_cmap;
-#else
-		disp->dispsw = &fbcon_dummy;
-#endif
-	} else if (bpp == 8) {
-		if (con == p->info.currcon) {
-			write_cr(0x13, 100);		// Set line length (doublewords)
-			write_xr(0x81, 0x12);		// 8 bit color mode
-			write_xr(0x82, 0x08);		// Graphics gamma enable
-			write_xr(0x20, 0x00);		// 8 bit blitter mode
-		}
-
-		fix->line_length = 800;
-		fix->visual = FB_VISUAL_PSEUDOCOLOR;		
-
- 		var->red.offset = var->green.offset = var->blue.offset = 0;
-		var->red.length = var->green.length = var->blue.length = 8;
-		
-#ifdef FBCON_HAS_CFB8
-		disp->dispsw = &fbcon_cfb8;
-#else
-		disp->dispsw = &fbcon_dummy;
-#endif
-	}
-
-	var->bits_per_pixel = bpp;
-	disp->line_length = p->fix.line_length;
-	disp->visual = fix->visual;
-	disp->var = *var;
-
-	if (p->info.changevar)
-		(*p->info.changevar)(con);
-
-	if ((err = fb_alloc_cmap(&disp->cmap, 0, 0)))
-		return;
-	do_install_cmap(con, (struct fb_info *)p);
-}
-
 struct chips_init_reg {
 	unsigned char addr;
 	unsigned char data;
@@ -473,7 +298,7 @@
 	{ 0xa8, 0x00 }
 };
 
-static void __init chips_hw_init(struct fb_info_chips *p)
+static void __init chips_hw_init(void)
 {
 	int i;
 
@@ -492,12 +317,12 @@
 		write_fr(chips_init_fr[i].addr, chips_init_fr[i].data);
 }
 
-static void __init init_chips(struct fb_info_chips *p)
-{
-	int i;
-
-	strcpy(p->fix.id, "C&T 65550");
-	p->fix.smem_start = p->frame_buffer_phys;
+static struct fb_fix_screeninfo chipsfb_fix __initdata = {
+	.id =		"C&T 65550",
+	.type =		FB_TYPE_PACKED_PIXELS,
+	.visual =	FB_VISUAL_PSEUDOCOLOR,
+	.accel =	FB_ACCEL_NONE,
+	.line_length =	800,
 
 // FIXME: Assumes 1MB frame buffer, but 65550 supports 1MB or 2MB.
 // * "3500" PowerBook G3 (the original PB G3) has 2MB.
@@ -506,115 +331,75 @@
 //   for a second pair of DRAMs.  (Thanks, Apple!)
 // * 3400 has 1MB (I think).  Don't know if it's expandable.
 // -- Tim Seufert
-	p->fix.smem_len = 0x100000;	// 1MB
-	p->fix.type = FB_TYPE_PACKED_PIXELS;
-	p->fix.visual = FB_VISUAL_PSEUDOCOLOR;
-	p->fix.line_length = 800;
-
-	p->var.xres = 800;
-	p->var.yres = 600;
-	p->var.xres_virtual = 800;
-	p->var.yres_virtual = 600;
-	p->var.bits_per_pixel = 8;
-	p->var.red.length = p->var.green.length = p->var.blue.length = 8;
-	p->var.height = p->var.width = -1;
-	p->var.vmode = FB_VMODE_NONINTERLACED;
-	p->var.pixclock = 10000;
-	p->var.left_margin = p->var.right_margin = 16;
-	p->var.upper_margin = p->var.lower_margin = 16;
-	p->var.hsync_len = p->var.vsync_len = 8;
-
-	p->disp.var = p->var;
-	p->disp.cmap.red = NULL;
-	p->disp.cmap.green = NULL;
-	p->disp.cmap.blue = NULL;
-	p->disp.cmap.transp = NULL;
-	p->disp.visual = p->fix.visual;
-	p->disp.type = p->fix.type;
-	p->disp.type_aux = p->fix.type_aux;
-	p->disp.line_length = p->fix.line_length;
-	p->disp.can_soft_blank = 1;
-	p->disp.dispsw = &fbcon_cfb8;
-	p->disp.scrollmode = SCROLL_YREDRAW;
-
-	strcpy(p->info.modename, p->fix.id);
-	p->info.node = NODEV;
-	p->info.fbops = &chipsfb_ops;
-	p->info.screen_base = p->frame_buffer;
-	p->info.disp = &p->disp;
-	p->info.currcon = -1;
-	p->info.fontname[0] = 0;
-	p->info.changevar = NULL;
-	p->info.switch_con = &chipsfbcon_switch;
-	p->info.updatevar = &chipsfb_updatevar;
-	p->info.flags = FBINFO_FLAG_DEFAULT;
-
-	for (i = 0; i < 16; ++i) {
-		int j = color_table[i];
-		p->palette[i].red = default_red[j];
-		p->palette[i].green = default_grn[j];
-		p->palette[i].blue = default_blu[j];
-	}
+	.smem_len =	0x100000,	/* 1MB */
+};
 
-	if (register_framebuffer(&p->info) < 0) {
-		kfree(p);
-		return;
-	}
+static struct fb_var_screeninfo chipsfb_var __initdata = {
+	.xres = 800,
+	.yres = 600,
+	.xres_virtual = 800,
+	.yres_virtual = 600,
+	.bits_per_pixel = 8,
+	.red = { .length = 8 },
+	.green = { .length = 8 },
+	.blue = { .length = 8 },
+	.height = -1,
+	.width = -1,
+	.vmode = FB_VMODE_NONINTERLACED,
+	.pixclock = 10000,
+	.left_margin = 16,
+	.right_margin = 16,
+	.upper_margin = 16,
+	.lower_margin = 16,
+	.hsync_len = 8,
+	.vsync_len = 8,
+};
+
+static void __init init_chips(struct fb_info *p, unsigned long addr)
+{
+	p->fix = chipsfb_fix;
+	p->fix.smem_start = addr;
 
-	printk("fb%d: Chips 65550 frame buffer (%dK RAM detected)\n",
-		minor(p->info.node), p->fix.smem_len / 1024);
+	p->var = chipsfb_var;
 
-	chips_hw_init(p);
+	p->node = NODEV;
+	p->fbops = &chipsfb_ops;
+	p->flags = FBINFO_FLAG_DEFAULT;
 
-#ifdef CONFIG_PMAC_PBOOK
-	if (all_chips == NULL)
-		pmu_register_sleep_notifier(&chips_sleep_notifier);
-#endif /* CONFIG_PMAC_PBOOK */
-	p->next = all_chips;
-	all_chips = p;
-}
+	fb_alloc_cmap(&p->cmap, 256, 0);
 
-int __init chips_init(void)
-{
-	struct pci_dev *dp = NULL;
+	if (register_framebuffer(p) < 0) {
+		printk(KERN_ERR "C&T 65550 framebuffer failed to register\n");
+		return;
+	}
 
-	while ((dp = pci_find_device(PCI_VENDOR_ID_CT,
-				     PCI_DEVICE_ID_CT_65550, dp)) != NULL)
-		if ((dp->class >> 16) == PCI_BASE_CLASS_DISPLAY)
-			chips_pci_init(dp);
-	return all_chips? 0: -ENODEV;
+	printk(KERN_INFO "fb%d: Chips 65550 frame buffer (%dK RAM detected)\n",
+		minor(p->node), p->fix.smem_len / 1024);
+
+	chips_hw_init();
 }
 
-static void __init chips_pci_init(struct pci_dev *dp)
+static int __devinit
+chipsfb_pci_init(struct pci_dev *dp, const struct pci_device_id *ent)
 {
-	struct fb_info_chips *p;
+	struct fb_info *p = &chipsfb_info;
 	unsigned long addr, size;
 	unsigned short cmd;
 
 	if ((dp->resource[0].flags & IORESOURCE_MEM) == 0)
-		return;
-	addr = dp->resource[0].start;
-	size = dp->resource[0].end + 1 - addr;
+		return -ENODEV;
+	addr = pci_resource_start(dp, 0);
+	size = pci_resource_len(dp, 0);
 	if (addr == 0)
-		return;
-	p = kmalloc(sizeof(*p), GFP_ATOMIC);
-	if (p == 0)
-		return;
-	memset(p, 0, sizeof(*p));
-	if (!request_mem_region(addr, size, "chipsfb")) {
-		kfree(p);
-		return;
-	}
+		return -ENODEV;
+	if (p->screen_base != 0)
+		return -EBUSY;
+	if (!request_mem_region(addr, size, "chipsfb"))
+		return -EBUSY;
+
 #ifdef __BIG_ENDIAN
 	addr += 0x800000;	// Use big-endian aperture
 #endif
-	p->pdev = dp;
-	p->frame_buffer_phys = addr;
-	p->frame_buffer = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
-	p->blitter_regs_phys = addr + 0x400000;
-	p->blitter_regs = ioremap(addr + 0x400000, 0x1000);
-	p->blitter_data_phys = addr + 0x410000;
-	p->blitter_data = ioremap(addr + 0x410000, 0x10000);
 
 	/* we should use pci_enable_device here, but,
 	   the device doesn't declare its I/O ports in its BARs
@@ -623,15 +408,68 @@
 	cmd |= 3;	/* enable memory and IO space */
 	pci_write_config_word(dp, PCI_COMMAND, cmd);
 
-	/* Clear the entire framebuffer */
-	memset(p->frame_buffer, 0, 0x100000);
-
 #ifdef CONFIG_PMAC_BACKLIGHT
 	/* turn on the backlight */
 	set_backlight_enable(1);
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
-	init_chips(p);
+	p->screen_base = __ioremap(addr, 0x200000, _PAGE_NO_CACHE);
+	if (p->screen_base == NULL) {
+		release_mem_region(addr, size);
+		return -ENOMEM;
+	}
+
+	init_chips(p, addr);
+
+#ifdef CONFIG_PMAC_PBOOK
+	pmu_register_sleep_notifier(&chips_sleep_notifier);
+#endif /* CONFIG_PMAC_PBOOK */
+
+	/* Clear the entire framebuffer */
+	memset(p->screen_base, 0, 0x100000);
+
+	pci_set_drvdata(dp, p);
+	return 0;
+}
+
+static void __devexit chipsfb_remove(struct pci_dev *dp)
+{
+	struct fb_info *p = pci_get_drvdata(dp);
+
+	if (p != &chipsfb_info || p->screen_base == NULL)
+		return;
+	unregister_framebuffer(p);
+	iounmap(p->screen_base);
+	p->screen_base = NULL;
+	release_mem_region(pci_resource_start(dp, 0), pci_resource_len(dp, 0));
+
+#ifdef CONFIG_PMAC_PBOOK
+	pmu_unregister_sleep_notifier(&chips_sleep_notifier);
+#endif /* CONFIG_PMAC_PBOOK */
+}
+
+static struct pci_device_id chipsfb_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_CT, PCI_DEVICE_ID_CT_65550, PCI_ANY_ID, PCI_ANY_ID },
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(pci, chipsfb_pci_tbl);
+
+static struct pci_driver chipsfb_driver = {
+	.name =		"chipsfb",
+	.id_table =	chipsfb_pci_tbl,
+	.probe =	chipsfb_pci_init,
+	.remove =	__devexit_p(chipsfb_remove),
+};
+
+int __init chips_init(void)
+{
+	return pci_module_init(&chipsfb_driver);
+}
+
+static void __exit chipsfb_exit(void)
+{
+	pci_unregister_driver(&chipsfb_driver);
 }
 
 #ifdef CONFIG_PMAC_PBOOK
@@ -642,40 +480,37 @@
 int
 chips_sleep_notify(struct pmu_sleep_notifier *self, int when)
 {
-	struct fb_info_chips *p;
+	struct fb_info *p = &chipsfb_info;
+	int nb = p->var.yres * p->fix.line_length;
 
-	for (p = all_chips; p != NULL; p = p->next) {
-		int nb = p->var.yres * p->fix.line_length;
+	if (p->screen_base == NULL)
+		return PBOOK_SLEEP_OK;
 
-		switch (when) {
-		case PBOOK_SLEEP_REQUEST:
-			p->save_framebuffer = vmalloc(nb);
-			if (p->save_framebuffer == NULL)
-				return PBOOK_SLEEP_REFUSE;
-			break;
-		case PBOOK_SLEEP_REJECT:
-			if (p->save_framebuffer) {
-				vfree(p->save_framebuffer);
-				p->save_framebuffer = 0;
-			}
-			break;
-
-		case PBOOK_SLEEP_NOW:
-			chipsfb_blank(1, (struct fb_info *)p);
-			if (p->save_framebuffer)
-				memcpy(p->save_framebuffer,
-				       p->frame_buffer, nb);
-			break;
-		case PBOOK_WAKE:
-			if (p->save_framebuffer) {
-				memcpy(p->frame_buffer,
-				       p->save_framebuffer, nb);
-				vfree(p->save_framebuffer);
-				p->save_framebuffer = 0;
-			}
-			chipsfb_blank(0, (struct fb_info *)p);
-			break;
+	switch (when) {
+	case PBOOK_SLEEP_REQUEST:
+		save_framebuffer = vmalloc(nb);
+		if (save_framebuffer == NULL)
+			return PBOOK_SLEEP_REFUSE;
+		break;
+	case PBOOK_SLEEP_REJECT:
+		if (save_framebuffer) {
+			vfree(save_framebuffer);
+			save_framebuffer = 0;
+		}
+		break;
+	case PBOOK_SLEEP_NOW:
+		chipsfb_blank(1, p);
+		if (save_framebuffer)
+			memcpy(save_framebuffer, p->screen_base, nb);
+		break;
+	case PBOOK_WAKE:
+		if (save_framebuffer) {
+			memcpy(p->screen_base, save_framebuffer, nb);
+			vfree(save_framebuffer);
+			save_framebuffer = 0;
 		}
+		chipsfb_blank(0, p);
+		break;
 	}
 	return PBOOK_SLEEP_OK;
 }
