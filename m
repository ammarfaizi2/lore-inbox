Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265342AbSJRRSz>; Fri, 18 Oct 2002 13:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265341AbSJRRSR>; Fri, 18 Oct 2002 13:18:17 -0400
Received: from gateway.cinet.co.jp ([210.166.75.129]:36369 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265244AbSJRQvV>; Fri, 18 Oct 2002 12:51:21 -0400
Date: Sat, 19 Oct 2002 01:56:28 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET 6/25] add support for PC-9800 architecture (FB console)
Message-ID: <20021019015628.A1546@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 6/26 of patchset for add support NEC PC-9800 architecture,
against 2.5.43.

Summary:
 FB driver modules
  - add support for PC-9800 standard video card
  - add support multi-byte charactors. (2bytes japanese kanji only, now)

diffstat:
 drivers/video/Config.in   |    4 
 drivers/video/Makefile    |    4 
 drivers/video/egcfb.c     |  654 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/fbcon-egc.c |  681 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/video/fbcon.c     |  461 ++++++++++++++++++++++++++++++-
 drivers/video/fbmem.c     |   60 ++++
 include/video/fbcon-egc.h |   32 ++
 7 files changed, 1887 insertions(+), 9 deletions(-)

patch:
diff -urN linux/drivers/video/Config.in linux98/drivers/video/Config.in
--- linux/drivers/video/Config.in	Wed Jul 17 08:49:34 2002
+++ linux98/drivers/video/Config.in	Fri Jul 19 16:09:49 2002
@@ -95,10 +95,14 @@
       tristate '  TGA framebuffer support' CONFIG_FB_TGA
    fi
    if [ "$CONFIG_X86" = "y" ]; then
+     if [ "$CONFIG_PC9800" != "y" ]; then
       bool '  VESA VGA graphics console' CONFIG_FB_VESA
       tristate '  VGA 16-color graphics console' CONFIG_FB_VGA16
       tristate '  Hercules mono graphics console (EXPERIMENTAL)' CONFIG_FB_HGA
       define_bool CONFIG_VIDEO_SELECT y
+     else
+      tristate '  EGC 16-color graphics console' CONFIG_FB_EGC
+     fi
    fi
    if [ "$CONFIG_VISWS" = "y" ]; then
       tristate '  SGI Visual Workstation framebuffer support' CONFIG_FB_SGIVW
diff -urN linux/drivers/video/Makefile linux98/drivers/video/Makefile
--- linux/drivers/video/Makefile	Tue Oct  8 10:56:16 2002
+++ linux98/drivers/video/Makefile	Tue Oct  8 11:01:41 2002
@@ -10,7 +10,7 @@
 		   fbcon-iplan2p2.o fbcon-iplan2p4.o fbgen.o \
 		   fbcon-iplan2p8.o fbcon-vga-planes.o fbcon-cfb16.o \
 		   fbcon-cfb2.o fbcon-cfb24.o fbcon-cfb32.o fbcon-cfb4.o \
-		   fbcon-cfb8.o fbcon-mfb.o fbcon-hga.o
+		   fbcon-cfb8.o fbcon-mfb.o fbcon-egc.o fbcon-hga.o
 
 # Each configuration option enables a list of files.
 
@@ -19,6 +19,7 @@
 obj-$(CONFIG_PROM_CONSOLE)        += promcon.o promcon_tbl.o
 obj-$(CONFIG_STI_CONSOLE)         += sticon.o sticon-bmode.o sticore.o
 obj-$(CONFIG_VGA_CONSOLE)         += vgacon.o
+obj-$(CONFIG_GDC_CONSOLE)         += gdccon.o
 obj-$(CONFIG_MDA_CONSOLE)         += mdacon.o
 
 obj-$(CONFIG_FONT_SUN8x16)        += font_sun8x16.o
@@ -69,6 +70,7 @@
 obj-$(CONFIG_FB_TGA)              += tgafb.o
 obj-$(CONFIG_FB_VESA)             += vesafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o 
 obj-$(CONFIG_FB_VGA16)            += vga16fb.o fbcon-vga-planes.o
+obj-$(CONFIG_FB_EGC)              += egcfb.o fbcon-egc.o
 obj-$(CONFIG_FB_VIRGE)            += virgefb.o
 obj-$(CONFIG_FB_G364)             += g364fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_FM2)              += fm2fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
diff -urN linux/drivers/video/egcfb.c linux98/drivers/video/egcfb.c
--- linux/drivers/video/egcfb.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/video/egcfb.c	Tue Sep  3 16:27:04 2002
@@ -0,0 +1,654 @@
+/*
+ * linux/drivers/video/egcfb.c -- EGC/GRCG framebuffer
+ *
+ * Copyright 1999 Satoshi YAMADA <slakichi@kmc.kyoto-u.ac.jp>
+ *
+ * Based on VGA framebuffer (C) 1999 Ben Pfaff <pfaffben@debian.org> ,
+ *				     Petr Vandrovec <VANDROVE@vc.cvut.cz>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details. 
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
+#include <linux/console.h>
+#include <linux/selection.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+
+#include <asm/io.h>
+
+#include <video/fbcon.h>
+#include <video/fbcon-egc.h>
+
+/* plane 0,1,2 */
+#define EGC_RGB_FB_PHYS 0xA8000
+#define EGC_RGB_FB_PHYS_LEN 0x18000
+/* plane 3 */
+#define EGC_E_FB_PHYS 0xE0000
+#define EGC_E_FB_PHYS_LEN 0x8000
+/* total (fix-info returns these value, but these are INVALID value!) */
+#define EGC_FB_PHYS 0xA8000
+#define EGC_FB_PHYS_LEN 0x20000
+
+#define EGCIO_GDC_CMD		0xa2
+#define EGCIO_GDC_PARAM		0xa0
+#define EGCIO_PL_NUM		0xa8
+#define EGCIO_PL_GREEN		0xaa
+#define EGCIO_PL_RED		0xac
+#define EGCIO_PL_BLUE		0xae
+#define EGCIO_SYNCCTRL		0x9a2
+
+#define EGCMEM_ISEGC		0x54d
+
+/* --------------------------------------------------------------------- */
+
+/*
+ * card parameters
+ */
+
+static struct fb_info	fb_info;	/* framebuffer info */
+static char *video_vbase[2];		/* VRAM base address in virtual */
+static int hasEGC;			/* This matchine has EGC?(1/0) */
+static int palette_blanked;		/* Blanked by Palette control */
+static int sync_blanked;		/* Blanked by APM control */
+
+
+/* --------------------------------------------------------------------- */
+
+/* default GDC parameters */
+#define EGC_FB_PIXCLOCK	 39708	/* 1/((margins+hsync_len+xres[pix])*(hsync[Hz])) */
+#define EGC_FB_MARGIN_LE 32	/* SYNC HBP 512>= ([P5(b5-b0)]+1)*8 >= 24 */
+#define EGC_FB_MARGIN_R	 32	/* SYNC HFP 512>= ([P4(b7-b2)]+1)*8 >= 16 */
+#define EGC_FB_MARGIN_U	 37	/* SYNC VBP 63 >= P8(b7-b2) >= 1 */
+#define EGC_FB_MARGIN_LO 2	/* SYNC VFP 63 >= P6(b5-b0) >= 1 */
+#define EGC_FB_HSYNC	 96	/* SYNC HS  512>= ([P3(b5-b0)]+1)*8 ,>=32 */
+#define EGC_FB_VSYNC	 2	/* SYNC VS  31 >= [P4(b1-b0)P3(b7-b5)] , >=1 */
+
+/*
+
+4+80+4+12+2=98*8=784pixels,70Hz
+
+37+400+2+2=441lines,31.48Hz
+
+*/
+
+static struct fb_var_screeninfo egcfb_defined = {
+	.xres		= 640,
+	.yres		= 400,
+	.xres_virtual	= 640,
+	.yres_virtual	= 400,
+	.xoffset	= 0,		/* virtual -> visible no offset */
+	.yoffset	= 0,
+	.bits_per_pixel	= 4,
+	.grayscale	= 0,		/* not greyscale but color */
+	.red		= {0, 0, 0},
+	.green		= {0, 0, 0},
+	.blue		= {0, 0, 0},
+	.transp		= {0, 0, 0},	/* transparency */
+	.nonstd		= 0,		/* standard pixel format */
+	.activate	= FB_ACTIVATE_NOW,
+	.height		= -1,
+	.width		= -1,
+	.accel_flags	= 0,
+	.pixclock	= EGC_FB_PIXCLOCK,
+	.left_margin	= EGC_FB_MARGIN_LE,
+	.right_margin	= EGC_FB_MARGIN_R,
+	.upper_margin	= EGC_FB_MARGIN_U,
+	.lower_margin	= EGC_FB_MARGIN_LO,
+	.hsync_len	= EGC_FB_HSYNC,
+	.vsync_len	= EGC_FB_VSYNC,
+	.sync		= 0,		/* No sync info */
+	.vmode = FB_VMODE_NONINTERLACED,
+};
+
+static struct fb_fix_screeninfo egcfb_fix __initdata = {
+	.id		= "egc",
+	.smem_start	= EGC_FB_PHYS,
+	.smem_len	= EGC_FB_PHYS_LEN,
+	.type		= FB_TYPE_VGA_PLANES,
+	.visual		= FB_VISUAL_PSEUDOCOLOR,
+	.xpanstep	= 8,
+	.ypanstep	= 1,
+	.ywrapstep	= 0,
+	.line_length	= 80,
+	.accel		= FB_ACCEL_NONE,
+};
+
+static struct display default_display;
+static struct {
+	u_short blue, green, red, transp;
+} palette[16];
+
+static spinlock_t egcfb_lock = SPIN_LOCK_UNLOCKED;
+
+/* --------------------------------------------------------------------- */
+
+static void egcfb_set_display(int con_num, struct fb_info *info)
+{
+	struct display *display;
+
+	if (con_num < 0)
+		display = &default_display;
+	else
+		display = fb_display + con_num;
+
+	display->can_soft_blank = 1;
+	display->inverse = 0;
+	display->dispsw = &fbcon_egc;
+	display->fb_info = info;
+	display->next_line = info->fix.line_length;
+	display->scrollmode = SCROLL_YREDRAW;
+}
+
+static int egcfb_check_var(const struct fb_var_screeninfo *var,
+			   const struct fb_info *info)
+{
+	if(var->xres != 640 || var->xres_virtual != 640)
+		return -EINVAL;
+	if(var->yres != 400 || var->yres_virtual != 400)
+		return -EINVAL;
+	if(var->xoffset != 0 || var->yoffset != 0)
+		return -EINVAL;
+	if(var->bits_per_pixel != 4)
+		return -EINVAL;
+	return 0;
+}
+
+static void egcfb_set_defaultvar(struct fb_var_screeninfo *var)
+{
+	unsigned long flags;
+
+	var->xres=var->xres_virtual=640;
+	var->yres=var->yres_virtual=400;
+	var->xoffset=var->yoffset=0;
+	var->bits_per_pixel=4;
+	var->grayscale=0;
+	var->red.length=var->green.length=var->blue.length=4;
+	var->red.offset=var->green.offset=var->blue.offset=0;
+	var->transp.length=var->transp.offset=0;
+	var->nonstd=0;
+	var->height=var->width=-1;
+	var->accel_flags=0;
+	var->left_margin=EGC_FB_MARGIN_LE;
+	var->right_margin=EGC_FB_MARGIN_R;
+	var->upper_margin=EGC_FB_MARGIN_U;
+	var->lower_margin=EGC_FB_MARGIN_LO;
+	var->hsync_len=EGC_FB_HSYNC;
+	var->vsync_len=EGC_FB_VSYNC;
+	var->sync=0;
+	var->vmode=FB_VMODE_NONINTERLACED;
+
+	spin_lock_irqsave(&egcfb_lock, flags);
+	outb_p(0x47,0xa2);
+	outb_p(80,0xa0);	/* pitch command */
+	outb_p(0x01,0x6a);
+	outb_p(0x00,0xa4);	/* show bank:0 */
+	outb_p(0x00,0xa6);	/* write bank:0 */
+	outb_p(0x0d,0xa2); /* Show Graphics */
+	outb_p(0x0c,0x62); /* Hide Text */
+	spin_unlock_irqrestore(&egcfb_lock, flags);
+}
+
+static int egcfb_set_varinfo(struct fb_var_screeninfo *var, int con_num,
+			       struct fb_info *info)
+{
+#if 0
+	struct display *display;
+#endif
+	int retval;
+
+#if 0
+	if (con < 0)
+		display = info->disp;
+	else
+		display = fb_display + con;
+#endif
+	retval = egcfb_check_var(var, info);
+	if (retval != 0)
+		return retval;
+	egcfb_set_defaultvar(var);
+	
+	if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_TEST)
+		return 0;
+
+#if 0
+	if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
+	/* Nothing to do. */
+	}
+#endif
+
+	return 0;
+}
+
+static int egcfb_get_palette(unsigned regno, unsigned *red, unsigned *green,
+			   unsigned *blue, unsigned *transp,
+			   struct fb_info *info)
+{
+	/*
+	 *  Read a single color register and split it into colors/transparent.
+	 *  Return != 0 for invalid regno.
+	 */
+
+	if (regno >= 16)
+		return 1;
+
+	*red   = palette[regno].red;
+	*green = palette[regno].green;
+	*blue  = palette[regno].blue;
+	*transp = 0;
+	return 0;
+}
+
+static __inline__ void egcfb_do_set_palette(int regno, unsigned red,
+						unsigned green, unsigned blue)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&egcfb_lock, flags);
+	outb_p(regno, EGCIO_PL_NUM);
+	outb_p(green >> 12, EGCIO_PL_GREEN);
+	outb_p(red   >> 12, EGCIO_PL_RED);
+	outb_p(blue  >> 12, EGCIO_PL_BLUE);
+	spin_unlock_irqrestore(&egcfb_lock, flags);
+}
+
+
+
+static int egcfb_set_palette(unsigned regno, unsigned red, unsigned green,
+			  unsigned blue, unsigned transp,
+			  struct fb_info *info)
+{
+	int gray;
+
+	if (regno >= 16)
+		return 1;
+
+	palette[regno].red   = red;
+	palette[regno].green = green;
+	palette[regno].blue  = blue;
+	
+	if (fb_info.currcon < 0)
+		gray = default_display.var.grayscale;
+	else
+		gray = fb_display[fb_info.currcon].var.grayscale;
+
+	if (gray)
+		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
+
+	egcfb_do_set_palette(regno, red, green, blue);
+	
+	return 0;
+}
+
+static void egcfb_set_palette_all(int con_num, struct fb_info *info)
+{
+	if (con_num != fb_info.currcon)
+		return;
+
+	if (fb_display[con_num].cmap.len)
+		fb_set_cmap(&fb_display[con_num].cmap, 1, info);
+	else
+		fb_set_cmap(fb_default_cmap(16), 1, info);
+}
+
+
+static int egcfb_get_colormap(struct fb_cmap *cmap, int kspc, int con_num,
+			    struct fb_info *info)
+{
+	if (con_num != fb_info.currcon)
+		return fb_get_cmap(cmap, kspc, egcfb_get_palette, info);
+	else if (fb_display[con_num].cmap.len)
+		fb_copy_cmap(&fb_display[con_num].cmap, cmap, kspc ? 0 : 2);
+	else
+		fb_copy_cmap(fb_default_cmap(16), cmap, kspc ? 0 : 2);
+
+	return 0;
+}
+
+static int egcfb_set_colormap(struct fb_cmap *cmap, int kspc, int con_num,
+			   struct fb_info *info)
+{
+	int err;
+
+	if (!fb_display[con_num].cmap.len) {	/* no colormap allocated? */
+		err = fb_alloc_cmap(&fb_display[con_num].cmap, 16, 0);
+		if (err)
+			return err;
+	}
+
+	if (con_num == fb_info.currcon) {
+		int retval = fb_set_cmap(cmap, kspc, info);
+		//if( retval == 0 )
+		//	fb_copy_cmap(cmap, &fb_display[fb_info.currcon].cmap, kspc ? 0 : 1);
+		return retval;
+	} else
+		fb_copy_cmap(cmap, &fb_display[con_num].cmap, kspc ? 0 : 1);
+
+	return 0;
+}
+
+static int egcfb_pan_display(struct fb_var_screeninfo *var, int con_num,
+			       struct fb_info *info) 
+{
+	if (var->xoffset + fb_display[con_num].var.xres
+			> fb_display[con_num].var.xres_virtual
+	    || var->yoffset + fb_display[con_num].var.yres
+			> fb_display[con_num].var.yres_virtual)
+		return -EINVAL;
+
+	/* must be xoffset=yoffset=0, so nothing to do. */
+	fb_display[con_num].var.xoffset = var->xoffset;
+	fb_display[con_num].var.yoffset = var->yoffset;
+	fb_display[con_num].var.vmode &= ~FB_VMODE_YWRAP;
+	return 0;
+}
+
+static int egcfb_mmap(struct fb_info *info, struct file *file,
+		      struct vm_area_struct * vma)
+{
+	/* based on fbmem.c - Copyright (C) 1994 Martin Schaller */
+	unsigned long start, len, off;
+	unsigned long vm_end, vm_start;
+	pgprot_t vm_prot;
+
+	off	 = vma->vm_pgoff << PAGE_SHIFT;
+	vm_start = vma->vm_start;
+	vm_end	 = vma->vm_end;
+
+	start = EGC_FB_PHYS;
+	len   = (start & ~PAGE_MASK) + EGC_FB_PHYS_LEN;
+	start &= PAGE_MASK;
+	len = (len + ~PAGE_MASK) & PAGE_MASK;
+
+	if (vm_end - vm_start + off > len)
+		return -EINVAL;
+
+	if (boot_cpu_data.x86 > 3)
+		pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
+
+	vm_prot = vma->vm_page_prot;
+
+	/* This is fake ;-) */
+	vma->vm_pgoff = ( off + start ) >> PAGE_SHIFT;
+
+	/* Plane 0,1,2 */
+	
+	start = EGC_RGB_FB_PHYS;
+	len   = (start & ~PAGE_MASK) + EGC_RGB_FB_PHYS_LEN;
+	start &= PAGE_MASK;
+	len = (len + ~PAGE_MASK) & PAGE_MASK;
+
+	if(off < len) {
+		if ((vm_end - vm_start + off) > len)
+			vm_end = (len - off) + vm_start;
+
+		if (io_remap_page_range(vma, vm_start, start + off,
+				     vm_end - vm_start, vma->vm_page_prot))
+			return -EAGAIN;
+
+		/* restore */
+		vm_end = vma->vm_end;
+	}
+	
+	/* Plane 3 (Extended) */
+	
+	start = EGC_E_FB_PHYS;
+	len   = (start & ~PAGE_MASK) + EGC_E_FB_PHYS_LEN;
+	start &= PAGE_MASK;
+	len = (len + ~PAGE_MASK) & PAGE_MASK;
+	
+	if (vm_end - vm_start + off > EGC_RGB_FB_PHYS_LEN) {
+		if (off < EGC_RGB_FB_PHYS_LEN) {
+			vm_start += (EGC_RGB_FB_PHYS_LEN - off);
+			off = 0;
+		} else
+			off -= EGC_RGB_FB_PHYS_LEN;
+
+		if ((vm_end - vm_start + off) > len)
+			/* mustn't be occured ... */
+			return -EINVAL;
+
+		if (io_remap_page_range(vma, vm_start, start + off,
+				     vm_end - vm_start, vma->vm_page_prot))
+			/* FIXME: don't re-remapped planes even if failed. */
+			return -EAGAIN;
+	}
+
+	return 0;
+
+}
+
+static void egcfb_sync_blank(struct fb_info *info, int mode)
+{
+	int sendcmd = 0;
+	unsigned long flags;
+
+	if ((mode & VESA_VSYNC_SUSPEND)
+			|| (sync_blanked & VESA_VSYNC_SUSPEND)) {
+		sync_blanked |= VESA_VSYNC_SUSPEND;
+		sendcmd |= 0x80;
+	}
+
+	if ((mode & VESA_HSYNC_SUSPEND)
+			|| (sync_blanked & VESA_HSYNC_SUSPEND)) {
+		sync_blanked |= VESA_HSYNC_SUSPEND;
+		sendcmd |= 0x40;
+	}
+
+	spin_lock_irqsave(&egcfb_lock, flags);
+	outb_p(sendcmd, EGCIO_SYNCCTRL);
+	spin_unlock_irqrestore(&egcfb_lock, flags);
+}
+
+static void egcfb_sync_unblank(struct fb_info *info)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&egcfb_lock, flags);
+	outb_p(0, EGCIO_SYNCCTRL);
+	spin_unlock_irqrestore(&egcfb_lock, flags);
+	sync_blanked = 0;
+}
+
+static void egcfb_pallete_blank(void)
+{
+	int i;
+	unsigned long flags;
+
+	for (i = 0; i < 16; i++) {
+		spin_lock_irqsave(&egcfb_lock, flags);
+		outb_p(i, EGCIO_PL_NUM);
+		outb_p(0, EGCIO_PL_GREEN);
+		outb_p(0, EGCIO_PL_RED);
+		outb_p(0, EGCIO_PL_BLUE);
+		spin_unlock_irqrestore(&egcfb_lock, flags);
+	}
+}
+
+/* 0 unblank, 1 blank, 2 no vsync, 3 no hsync, 4 off */
+static int egcfb_blank(int blank, struct fb_info *info)
+{
+	switch (blank) {
+	case 0:				/* Unblank */
+		if (sync_blanked) {
+			egcfb_sync_unblank(info);
+		}
+
+		if (palette_blanked) {
+			egcfb_set_palette_all(fb_info.currcon, info);
+			palette_blanked = 0;
+		}
+
+		break;
+
+	case 1:				/* blank */
+		egcfb_pallete_blank();
+		palette_blanked = 1;
+		break;
+
+	default:			/* VESA blanking */
+		egcfb_sync_blank(info, blank - 1);
+		break;
+	}
+
+	return 0;
+}
+
+static struct fb_ops egcfb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_set_var	= egcfb_set_varinfo,
+	.fb_get_cmap	= egcfb_get_colormap,
+	.fb_set_cmap	= egcfb_set_colormap,
+	.fb_setcolreg	= egcfb_set_palette,
+	.fb_blank	= egcfb_blank,
+	.fb_pan_display	= egcfb_pan_display,
+	.fb_mmap	= egcfb_mmap,
+};
+
+int egcfb_setup(char *options)
+{
+	char *this_opt;
+	
+	fb_info.fontname[0] = '\0';
+	
+	if (!options || !*options)
+		return 0;
+	
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
+
+		if (!strncmp(this_opt, "font:", 5))
+			strcpy(fb_info.fontname, this_opt + 5);
+	}
+
+	return 0;
+}
+
+/* on switching console ... */
+static int egcfb_switch(int con_num, struct fb_info *info)
+{
+	/* Do we have to save the colormap? */
+	if (fb_display[fb_info.currcon].cmap.len) {
+		fb_get_cmap(&fb_display[fb_info.currcon].cmap, 1,
+			    egcfb_get_palette, info);
+	}
+	
+	fb_info.currcon = con_num;
+	egcfb_set_defaultvar(&fb_display[con_num].var);
+	egcfb_set_display(con_num, info);
+	egcfb_set_palette_all(con_num, info);
+	return 1;
+}
+
+int __init egc_init(void)
+{
+	int i,j;
+
+	printk(KERN_DEBUG "egcfb: initializing\n");
+
+	if(!(isa_readb(0x054c) & (1 << 1))) {
+		printk(KERN_ERR "egcfb: this machine does not have GRCG, exiting\n");
+		return -EINVAL;
+	}
+
+	if(!(isa_readb(0x054c) & (1 << 2))) {
+		printk(KERN_ERR "egcfb: not 16-colors mode, exiting\n");
+		return -EINVAL;
+	}
+
+	if(!(isa_readb(0x054d) & (1 << 6))) {
+		printk(KERN_ERR "egcfb: this machine does not have EGC, exiting\n");
+		return -EINVAL;
+	}
+
+	video_vbase[0] = ioremap_nocache(EGC_RGB_FB_PHYS, EGC_RGB_FB_PHYS_LEN);
+	video_vbase[1] = ioremap_nocache(EGC_E_FB_PHYS, EGC_E_FB_PHYS_LEN);
+	printk(KERN_INFO "egcfb: mapped to 0x%p and 0x%p\n",
+	       video_vbase[0], video_vbase[1]);
+
+	hasEGC = (isa_readb(EGCMEM_ISEGC) & 0x40) ? 1 : 0;
+	palette_blanked = 0;
+	sync_blanked = 0;
+
+	egcfb_defined.red.length   = 4;
+	egcfb_defined.green.length = 4;
+	egcfb_defined.blue.length  = 4;
+	for (i = 0; i < 16; i++) {
+		j = color_table[i];
+		palette[i].red	 = default_red[j];
+		palette[i].green = default_grn[j];
+		palette[i].blue	 = default_blu[j];
+	}
+
+	default_display.var = egcfb_defined;
+
+	strcpy(fb_info.modename, egcfb_fix.id);
+	fb_info.changevar = NULL;
+	fb_info.node = NODEV;
+	fb_info.fbops = &egcfb_ops;
+	fb_info.var = egcfb_defined;
+	fb_info.fix = egcfb_fix;
+	fb_info.currcon = -1;
+	fb_info.screen_base = video_vbase[0];
+	fb_info.disp = &default_display;
+	fb_info.switch_con = egcfb_switch;
+	fb_info.updatevar = gen_update_var;
+	fb_info.flags = FBINFO_FLAG_DEFAULT;
+
+	fb_alloc_cmap(&fb_info.cmap, 16, 0);
+	egcfb_set_display(-1, &fb_info);
+
+	isa_writeb(isa_readb(0x054C) | 0x80, 0x054C);
+
+	if (register_framebuffer(&fb_info) < 0)
+		return -EINVAL;
+
+	printk(KERN_INFO "fb%d: %s frame buffer device\n",
+	       GET_FB_IDX(fb_info.node), fb_info.fix.id);
+
+	return 0;
+}
+
+#ifndef MODULE
+int __init egcfb_init(void)
+{
+    return egc_init();
+}
+
+#else /* MODULE */
+
+int init_module(void)
+{
+	return egc_init();
+}
+
+void cleanup_module(void)
+{
+	unregister_framebuffer(&fb_info);
+	iounmap(video_vbase[0]);
+	iounmap(video_vbase[1]);
+	__release_region(&ioport_resource, 0xa2, 1);
+}
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
+
diff -urN linux/drivers/video/fbcon-egc.c linux98/drivers/video/fbcon-egc.c
--- linux/drivers/video/fbcon-egc.c	Thu Jan  1 09:00:00 1970
+++ linux98/drivers/video/fbcon-egc.c	Mon Sep  2 17:03:11 2002
@@ -0,0 +1,681 @@
+/*
+ *  linux/drivers/video/fbcon-egc.c -- Low level frame buffer operations
+ *					      for EGC 
+ *
+ * Copyright (C) 1999,2000 Satoshi YAMADA <slakichi@kmc.kyoto-u.ac.jp>
+ *
+ * Based on fbcon-vga-planes.c (C) 1999 Ben Pfaff <pfaffben@debian.org>
+ *				    and Petr Vandrovec <VANDROVE@vc.cvut.cz>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file COPYING in the main directory of this
+ * archive for more details.	
+ */
+
+#include <linux/module.h>
+#include <linux/tty.h>
+#include <linux/console.h>
+#include <linux/string.h>
+#include <linux/fb.h>
+#include <linux/vt_buffer.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+#include <linux/wait.h>
+#include <linux/interrupt.h>
+
+#include <asm/io.h>
+
+#include <video/fbcon.h>
+#include <video/fbcon-egc.h>
+
+#define EGCIO_EGC_R0 0x4a0
+#define EGCIO_EGC_R1 0x4a2
+#define EGCIO_EGC_R2 0x4a4
+#define EGCIO_EGC_R3 0x4a6
+#define EGCIO_EGC_R4 0x4a8
+#define EGCIO_EGC_R5 0x4aa
+#define EGCIO_EGC_R6 0x4ac
+#define EGCIO_EGC_R7 0x4ae
+
+#define EGCIO_KANJI_SETMODE	0x68
+#define EGCIO_KANJI_CG_LOW	0xa1
+#define EGCIO_KANJI_CG_HI	0xa3
+#define EGCIO_KANJI_CG_LR	0xa5
+
+#define EGCRAM_KANJI_CG		0xa4000
+
+#define KANJI_ACCESS		0x0b
+#define KANJI_NORMAL		0x0a
+
+#define NUM_CACHE		16 /* must be 2,4,8,16... */
+
+typedef struct facecache_t
+{
+	u8  isenable;
+	u16 chardata;
+	u8  left[16];
+	u8  right[16];
+} facecache;
+
+facecache fcache_kanji[NUM_CACHE];
+int       fcache_kanji_lastuse = -1;
+facecache fcache_ank[256];
+u8	  fcache_num;
+
+static spinlock_t fbcon_egc_lock = SPIN_LOCK_UNLOCKED;
+DECLARE_WAIT_QUEUE_HEAD(fbcon_egc_irq_wait);
+static int vsync_irq = 0;
+
+static u8 *egc_load_facedata(struct display *p, u16 data)
+{
+	int i;
+	int t;
+	u8 kanji_high = (u8)(data & 0x007f);
+	u16 rdata[32];
+//	unsigned long flags;
+
+	if (!(data & 0xff00)) {
+/* debug		return p->fontdata + (data & 0xff) * (fontheight(p)); */
+		if (fcache_ank[(unsigned int)(data & 0xff)].isenable) {
+			return fcache_ank[(unsigned int)(data & 0xff)].left;
+		}
+
+		/* wait for vsync */
+//		spin_lock_irqsave(&fbcon_egc_lock, flags);
+		if (vsync_irq && !in_interrupt()) {
+			outb(0x00, 0x64);
+			interruptible_sleep_on(&fbcon_egc_irq_wait);
+//			spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+		} else {
+//			spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+			while (inb(0xa0) & 0x20);
+			while (!(inb(0xa0) & 0x20));
+		}
+
+//		spin_lock_irqsave(&fbcon_egc_lock, flags);
+		outb_p(KANJI_ACCESS, EGCIO_KANJI_SETMODE);
+		outb_p(0, EGCIO_KANJI_CG_LOW);
+		outb_p(data & 0xff, EGCIO_KANJI_CG_HI);
+		memcpy(rdata, phys_to_virt(EGCRAM_KANJI_CG), 32);
+//		spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+		for (i = 0; i < 16; i++) {
+			fcache_ank[(unsigned int)(data & 0xff)].left[i]
+				 = (u8)(rdata[i] >> 8);
+		}
+
+		fcache_ank[(unsigned int)(data & 0xff)].isenable = 1;
+		return fcache_ank[(unsigned int)(data & 0xff)].left;
+	}
+
+	for (i = 0; i < NUM_CACHE; i++) {
+		if (fcache_kanji[i].isenable
+		 && fcache_kanji[i].chardata == (data & 0xff7f)) {
+			fcache_kanji_lastuse = i;
+			return ((data & 0x80) ? fcache_kanji[i].right
+					      : fcache_kanji[i].left);
+		}
+	}
+
+	do {
+		t = fcache_num;
+		fcache_num = (fcache_num + 1) & (NUM_CACHE - 1);
+	} while (t == fcache_kanji_lastuse);
+
+	fcache_kanji[t].isenable = 0;
+	fcache_kanji[t].chardata = ( data & 0xff7f );
+
+	if( (kanji_high >=0x0c && kanji_high <= 0x0f) 
+	 || kanji_high == 0x56
+	 || (kanji_high >=0x59 && kanji_high <= 0x5c)) {
+//		spin_lock_irqsave(&fbcon_egc_lock, flags);
+		outb_p(KANJI_ACCESS, EGCIO_KANJI_SETMODE);
+		outb_p(( data >> 8 ) & 0x7f, EGCIO_KANJI_CG_LOW);
+		outb_p(kanji_high , EGCIO_KANJI_CG_HI);
+		/* read left */
+		outb_p(0x20, EGCIO_KANJI_CG_LR);
+		memcpy(rdata, phys_to_virt(EGCRAM_KANJI_CG), 32);
+		/* read right */
+		outb_p(KANJI_ACCESS, EGCIO_KANJI_SETMODE);
+		outb_p(( data >> 8 ) & 0x7f, EGCIO_KANJI_CG_LOW);
+		outb_p(0x00, EGCIO_KANJI_CG_LR);
+		memcpy(&rdata[16], phys_to_virt(EGCRAM_KANJI_CG), 32);
+		outb_p(KANJI_NORMAL, EGCIO_KANJI_SETMODE);
+//		spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+		for (i = 0; i < 16; i++) {
+			fcache_kanji[t].left[i] = (u8)(rdata[i] >> 8);
+			fcache_kanji[t].right[i] = (u8)(rdata[i+16] >> 8);
+		}
+
+	} else {
+		/* read L/R pattern */
+//		spin_lock_irqsave(&fbcon_egc_lock, flags);
+		outb_p(KANJI_ACCESS, EGCIO_KANJI_SETMODE);
+		outb_p((data >> 8) & 0x7f, EGCIO_KANJI_CG_LOW);
+		outb_p(kanji_high , EGCIO_KANJI_CG_HI);
+		memcpy(rdata, phys_to_virt(EGCRAM_KANJI_CG), 32);
+		outb_p(KANJI_NORMAL, EGCIO_KANJI_SETMODE);
+//		spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+		for (i = 0; i < 16; i++) {
+			fcache_kanji[t].left[i] = (u8)(rdata[i] & 0x00ff);
+			fcache_kanji[t].right[i] = (u8)(rdata[i] >> 8);
+		}
+
+	}
+
+	fcache_kanji[t].isenable = 1;
+	return ((data & 0x80) ? fcache_kanji[t].right : fcache_kanji[t].left);
+}
+
+/* ------------------------------ */
+//#define PC98_USE_VSYNC
+#ifdef PC98_USE_VSYNC
+static void fbcon_egc_interrupt(int irq, void *dev_id, struct pt_regs *regs)
+{
+	if (waitqueue_active(&fbcon_egc_irq_wait)) {
+		wake_up(&fbcon_egc_irq_wait);
+	}
+}
+#endif
+
+void fbcon_egc_setup(struct display *p)
+{
+#ifdef PC98_USE_VSYNC
+	if (vsync_irq)
+		return;
+	if (request_irq(2, fbcon_egc_interrupt, SA_INTERRUPT,
+		"CRT vsync", NULL))
+	{
+		printk("fbcon-egc: Unable to grab CRT-VSYNC interrupt IRQ2\n");
+	}
+	else {
+		vsync_irq = 2;
+		printk("fbcon-egc: grab CRT-VSYNC interrupt IRQ2\n");
+	}
+#endif
+}
+
+void fbcon_egc_bmove(struct display *p, int sy, int sx, int dy, int dx,
+		   int height, int width)
+{
+	u16 *src;
+	u16 *dest;
+	
+	int x;
+	int word_cnt;
+	unsigned long flags;
+
+	sy *= fontheight(p);
+	dy *= fontheight(p);
+	sx *= 8;
+	dx *= 8;
+	width *= 8;
+	height *= fontheight(p);
+
+	spin_lock_irqsave(&fbcon_egc_lock, flags);
+	outb(0xcf,0x7c);
+	isa_writeb(isa_readb(0x495)|0x80,0x0495);
+	outb(0x07,0x6a);	/* unprotected */
+	outb(0x05,0x6a);	/* EGC mode */
+	outb(0x06,0x6a);	/* protected */
+	outw(0xfff0,EGCIO_EGC_R0);
+	outw(0x00ff,EGCIO_EGC_R1);
+	outw(0xffff,EGCIO_EGC_R4);
+	outw(0x0000,EGCIO_EGC_R6);
+	outw(0x000f,EGCIO_EGC_R7);
+
+	outw(0x29F0,EGCIO_EGC_R2);
+//	spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+
+	if (dy < sy || (dy == sy && dx < sx)) {
+		/* forward */
+		int y;
+		u16 *save1;
+		u16 *save2;
+		src = (u16 *)(((unsigned long)p->fb_info->screen_base+(sx>>3)+
+			       sy * p->fb_info->fix.line_length) & (~1)) ;
+		dest = (u16 *)(((unsigned long)p->fb_info->screen_base+(dx>>3)+
+				dy * p->fb_info->fix.line_length) & (~1));
+		
+//		spin_lock_irqsave(&fbcon_egc_lock, flags);
+		outw((sx&0xf)|((dx&0xf)<<4),EGCIO_EGC_R6);
+//		spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+		word_cnt=((dx&0xf)+width+15)>>4;
+		if((sx&0xf) != (dx&0xf) && ((sx&0xf) > (dx&0xf) || 
+		(((sx&0xf)+width+15)>>4) > (((dx&0xf)+width+15)>>4))) {
+			word_cnt++;
+			dest=(u16 *)((unsigned long)dest-2);
+		}
+//		spin_lock_irqsave(&fbcon_egc_lock, flags);
+		outw(width-1,EGCIO_EGC_R7);
+//		spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+		for(y=0;y<height;y++) {
+			save1=src;
+			save2=dest;
+			for(x=0;x<word_cnt;x++) {
+				*dest=*src;
+				src=(u16 *)((unsigned long)src+2);
+				dest=(u16 *)((unsigned long)dest+2);
+			}
+			src=(u16 *)((unsigned long)save1+80);
+			dest=(u16 *)((unsigned long)save2+80);
+		}
+	} else {
+		/* backward */
+		int y;
+		int sb,db;
+		u16 *save1;
+		u16 *save2;
+		src  = (u16 *)(((unsigned long)p->fb_info->screen_base +
+				((sy+height-1) * p->fb_info->fix.line_length +
+				 ((sx+width-1)>>3))) & (~1));
+		dest = (u16 *)(((unsigned long)p->fb_info->screen_base +
+				((dy+height-1) * p->fb_info->fix.line_length +
+				 ((dx+width-1)>>3))) & (~1));
+//		spin_lock_irqsave(&fbcon_egc_lock, flags);
+		outw(width-1,EGCIO_EGC_R7);
+//		spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+
+		sb=((((sx+width)&0xf)-16)*(-1))&0xf;
+		db=((((dx+width)&0xf)-16)*(-1))&0xf;
+
+//		spin_lock_irqsave(&fbcon_egc_lock, flags);
+		outw(0x1000|(db<<4)|sb,EGCIO_EGC_R6);
+//		spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+		word_cnt=(db+width+15)>>4;
+
+		if (sb>db || (sb<db &&
+		   (sb+width+15)>>4 > (db+width+15)>>4)) {
+			word_cnt++;
+			dest=(u16 *)((unsigned long)dest+2);
+		}
+
+		for(y=0;y<height;y++) {
+			save1=src;
+			save2=dest;
+			for(x=0;x<word_cnt;x++) {
+				*dest=*src;
+				src=(u16 *)((unsigned long)src-2);
+				dest=(u16 *)((unsigned long)dest-2);
+			}
+			src=(u16 *)((unsigned long)save1-80);
+			dest=(u16 *)((unsigned long)save2-80);
+		}
+	}
+
+//	spin_lock_irqsave(&fbcon_egc_lock, flags);
+	outb(0x07,0x6a);	/* unprotected */
+	outb(0x04,0x6a);	/* GRCG mode */
+	outb(0x06,0x6a);	/* protected */
+	outb(0x00,0x7c);
+	isa_writeb(isa_readb(0x495)&0x7F,0x0495);
+	spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+}
+
+void fbcon_egc_clear(struct vc_data *conp, struct display *p,
+			    int sy, int sx, int height, int width)
+{
+	u16 *data;
+	int x;
+//	unsigned long flags;
+
+	sy *= fontheight(p);
+	height *= fontheight(p);
+	data = (u16 *)((unsigned long)p->fb_info->screen_base + 0x8000 + sx +
+		       sy * p->fb_info->fix.line_length);
+	data = (u16 *)((unsigned long)data & (~1));
+
+//	spin_lock_irqsave(&fbcon_egc_lock, flags);
+	outb(0xcf,0x7c);
+	isa_writeb(isa_readb(0x495)|0x80,0x0495);
+	outb(0x07,0x6a);	/* unprotected */
+	outb(0x05,0x6a);	/* EGC mode */
+	outb(0x06,0x6a);	/* protected */
+	outw(0xfff0,EGCIO_EGC_R0);
+	outw(0x00ff,EGCIO_EGC_R1);
+	outw(0xffff,EGCIO_EGC_R4);
+	outw(0x0000,EGCIO_EGC_R6);
+	outw(0x000f,EGCIO_EGC_R7);
+
+	/* egc_set_fgcolor */
+	outw(0x40ff, EGCIO_EGC_R1);
+	outw(conp ? (conp->vc_video_erase_attr>>4) & 0x0f : 0, EGCIO_EGC_R3);
+
+	outw(0x2cac,EGCIO_EGC_R2);
+//	spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+	while (height--) {
+		u16 *save=data;
+		/* first 8pixels */
+		if(sx&1) {
+			*data=0xff00;
+			data++;
+		}
+		for (x = 0; x < (width&(~1)) -1; x+=2) {
+			*data=0xffff;
+			data++;
+		}
+		/* last 8pixels */
+		if((sx+width)&1) {
+			*data=0x00ff;
+			data++;
+		}
+		/* to next line */
+		data = (u16 *)((unsigned long)save + p->fb_info->fix.line_length);
+	}
+
+//	spin_lock_irqsave(&fbcon_egc_lock, flags);
+	outb(0x07,0x6a);	/* unprotected */
+	outb(0x04,0x6a);	/* GRCG mode */
+	outb(0x06,0x6a);	/* protected */
+	outb(0x00,0x7c);
+	isa_writeb(isa_readb(0x495)&0x7F,0x0495);
+//	spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+}
+
+
+void fbcon_egc_putc(struct vc_data *conp, struct display *p, int ch, int yy, int xx)
+{
+	u16 *data;
+	u8 *fdata_s;
+	int fg;
+	int bg;
+	int isbold;
+	int isuline;
+	int y;
+	unsigned long flags;
+
+	data = (u16 *)((unsigned long)p->fb_info->screen_base + xx +
+			    yy * p->fb_info->fix.line_length * fontheight(p));
+	
+	fg = conp->vc_pc98_addbuf & 0x0f;
+	bg = (conp->vc_pc98_addbuf >> 4) & 0x0f;
+	isbold = conp->vc_pc98_addbuf & 0x100;
+	isuline = conp->vc_pc98_addbuf & 0x200;
+	data = (u16 *)((unsigned long)data & (~1));
+
+	spin_lock_irqsave(&fbcon_egc_lock, flags);
+	fdata_s = egc_load_facedata(p, ch);
+	outb(0xcf,0x7c);
+	isa_writeb(isa_readb(0x495)|0x80,0x0495);
+	outb(0x07,0x6a);	/* unprotected */
+	outb(0x05,0x6a);	/* EGC mode */
+	outb(0x06,0x6a);	/* protected */
+	outw(0xfff0,EGCIO_EGC_R0);
+	outw(0x00ff,EGCIO_EGC_R1);
+	outw(0xffff,EGCIO_EGC_R4);
+	outw(0x0000,EGCIO_EGC_R6);
+	outw(0x000f,EGCIO_EGC_R7);
+
+	outw(0x2cac,EGCIO_EGC_R2);
+//	spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+	/* write one character */
+	for (y = 0; y < fontheight(p); y++) {
+		u16 mask=(*(fdata_s+y))<<((xx&1)<<3);
+		if (isbold)
+			mask |= (mask << 1);
+		if ( y == fontheight(p) - 1 && isuline)
+			mask = (0xff) << ((xx&1)<<3) ;
+		/* egc_set_fgcolor */
+//		spin_lock_irqsave(&fbcon_egc_lock, flags);
+		outw(0x40ff, EGCIO_EGC_R1);
+		outw(fg, EGCIO_EGC_R3);
+//		spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+
+		*data = mask;
+		if(isbold && !(xx&2) && xx!=0 && *(fdata_s+y)&0x80) {
+			*(data-1) = 0x0100;
+		}
+		/* egc_set_fgcolor */
+//		spin_lock_irqsave(&fbcon_egc_lock, flags);
+		outw(0x40ff, EGCIO_EGC_R1);
+		outw(bg, EGCIO_EGC_R3);
+//		spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+
+		mask ^= 0xff<<((xx&1)<<3);
+		*data = mask;
+		data = (u16 *)((unsigned long)data + p->fb_info->fix.line_length);
+	}
+
+//	spin_lock_irqsave(&fbcon_egc_lock, flags);
+	outb(0x07,0x6a);	/* unprotected */
+	outb(0x04,0x6a);	/* GRCG mode */
+	outb(0x06,0x6a);	/* protected */
+	outb(0x00,0x7c);
+	isa_writeb(isa_readb(0x495)&0x7F,0x0495);
+	spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+}
+
+void fbcon_egc_putcs(struct vc_data *conp, struct display *p,
+			    const unsigned short *s,
+			    int count, int yy, int xx)
+{
+	u16 *data;
+	extern int	fbcon_softback_size;
+	int attr;
+	int fg;
+	int bg;
+	int isbold;
+	int isuline;
+	int n,y;
+	unsigned long flags;
+
+	data = (u16 *)((unsigned long)p->fb_info->screen_base +
+			    xx + yy * p->fb_info->fix.line_length * fontheight(p));
+	
+	attr = scr_readw((u16 *)((unsigned long)s +
+			((s >= conp->vc_screenbuf
+				&& (unsigned long)s <
+				(unsigned long)(conp->vc_screenbuf)
+				+ conp->vc_screenbuf_size) ?
+			conp->vc_screenbuf_size : fbcon_softback_size)));
+	fg = attr & 0x0f;
+	bg = ( attr >> 4) & 0x0f;
+	isbold = attr & 0x100;
+	isuline = attr & 0x200;
+	data = (u16 *)((unsigned long)data & ~1);
+
+	spin_lock_irqsave(&fbcon_egc_lock, flags);
+	outb(0xcf,0x7c);
+	isa_writeb(isa_readb(0x495)|0x80,0x0495);
+	outb(0x07,0x6a);	/* unprotected */
+	outb(0x05,0x6a);	/* EGC mode */
+	outb(0x06,0x6a);	/* protected */
+	outw(0xfff0,EGCIO_EGC_R0);
+	outw(0x00ff,EGCIO_EGC_R1);
+	outw(0xffff,EGCIO_EGC_R4);
+	outw(0x0000,EGCIO_EGC_R6);
+	outw(0x000f,EGCIO_EGC_R7);
+
+	outw(0x2cac,EGCIO_EGC_R2);
+//	spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+	if(xx & 1) {
+		/* write one character */
+		int c = scr_readw(s++);
+		u8 *fdata_s = egc_load_facedata(p, c);
+		for (y = 0; y < fontheight(p); y++) {
+			u16 mask=(*(fdata_s+y))<<8;
+			if (isbold)
+				mask |= (mask << 1);
+			if ( y == fontheight(p) - 1 && isuline)
+				mask = 0xff00 ;
+			/* egc_set_fgcolor */
+//			spin_lock_irqsave(&fbcon_egc_lock, flags);
+			outw(0x40ff, EGCIO_EGC_R1);
+			outw(fg, EGCIO_EGC_R3);
+//			spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+
+			*data = mask;
+			/* egc_set_fgcolor */
+//			spin_lock_irqsave(&fbcon_egc_lock, flags);
+			outw(0x40ff, EGCIO_EGC_R1);
+			outw(bg, EGCIO_EGC_R3);
+//			spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+
+			mask ^= 0xff00;
+			*data = mask;
+			data = (u16 *)((unsigned long)data + p->fb_info->fix.line_length);
+		}
+		data = (u16 *)((unsigned long)data + 2 -
+			       p->fb_info->fix.line_length * fontheight(p));
+		xx++;
+		count--;
+	}
+
+	for (n = 0; n < (count&(~1)) - 1 ; n += 2 ) {
+		int c,i;
+		u8 *fdata_s[2];
+		for(i=0;i<2;i++) {
+			c = scr_readw(s++);
+			fdata_s[i] = egc_load_facedata(p, c);
+		}
+		for (y = 0; y < fontheight(p); y++) {
+			u16 mask=((*(fdata_s[1]+y))<<8)|(*(fdata_s[0]+y));
+			if (isbold)
+				mask |= (((mask << 1) & 0xfeff)|(mask >> 15));
+			if ( y == fontheight(p) - 1 && isuline)
+				mask = 0xffff ;
+			/* egc_set_fgcolor */
+//			spin_lock_irqsave(&fbcon_egc_lock, flags);
+			outw(0x40ff, EGCIO_EGC_R1);
+			outw(fg, EGCIO_EGC_R3);
+//			spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+
+			*data = mask;
+			if (isbold && !(xx&2) && xx!=0
+			&&  *(fdata_s[0]+y)&0x80) {
+				*(data-1) = 0x0100;
+			}
+			/* egc_set_fgcolor */
+//			spin_lock_irqsave(&fbcon_egc_lock, flags);
+			outw(0x40ff, EGCIO_EGC_R1);
+			outw(bg, EGCIO_EGC_R3);
+//			spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+
+			mask ^= 0xffff;
+			*data = mask;
+			data = (u16 *)((unsigned long)data + p->fb_info->fix.line_length);
+		}
+		data = (u16 *)((unsigned long)data + 2 -
+			       p->fb_info->fix.line_length * fontheight(p));
+	}
+
+	if (count &1) {
+		/* write one character */
+		int c = scr_readw(s++);
+		u8 *fdata_s = egc_load_facedata(p, c);
+		for (y = 0; y < fontheight(p); y++) {
+			u16 mask=(*(fdata_s+y));
+			if (isbold)
+				mask |= (mask << 1);
+			if ( y == fontheight(p) - 1 && isuline)
+				mask = 0x00ff ;
+			mask &= 0x00ff;
+			/* egc_set_fgcolor */
+//			spin_lock_irqsave(&fbcon_egc_lock, flags);
+			outw(0x40ff, EGCIO_EGC_R1);
+			outw(fg, EGCIO_EGC_R3);
+//			spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+
+			if(isbold && !(xx&2) && xx!=0 && *(fdata_s+y)&0x80) {
+				*(data-1) = 0x0100;
+			}
+			*data = mask;
+			/* egc_set_fgcolor */
+//			spin_lock_irqsave(&fbcon_egc_lock, flags);
+			outw(0x40ff, EGCIO_EGC_R1);
+			outw(bg, EGCIO_EGC_R3);
+//			spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+
+			mask ^= 0xff;
+			*data = mask;
+			data = (u16 *)((unsigned long)data + p->fb_info->fix.line_length);
+		}
+	}
+
+//	spin_lock_irqsave(&fbcon_egc_lock, flags);
+	outb(0x07,0x6a);	/* unprotected */
+	outb(0x04,0x6a);	/* GRCG mode */
+	outb(0x06,0x6a);	/* protected */
+	outb(0x00,0x7c);
+	isa_writeb(isa_readb(0x495)&0x7F,0x0495);
+	spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+}
+
+void fbcon_egc_revc(struct display *p, int xx, int yy)
+{
+	u16 *data;
+	int y;
+//	unsigned long flags;
+
+	data = (u16 *)((unsigned long)p->fb_info->screen_base + xx + 0x8000 +
+			    yy * p->fb_info->fix.line_length * fontheight(p));
+	data = (u16 *)((unsigned long)data & (~1));
+
+//	spin_lock_irqsave(&fbcon_egc_lock, flags);
+	outb(0xcf,0x7c);
+	isa_writeb(isa_readb(0x495)|0x80,0x0495);
+	outb(0x07,0x6a);	/* unprotected */
+	outb(0x05,0x6a);	/* EGC mode */
+	outb(0x06,0x6a);	/* protected */
+	outw(0xfff0,EGCIO_EGC_R0);
+	outw(0x00ff,EGCIO_EGC_R1);
+	outw(0xffff,EGCIO_EGC_R4);
+	outw(0x0000,EGCIO_EGC_R6);
+	outw(0x000f,EGCIO_EGC_R7);
+
+	outw(0x2833, EGCIO_EGC_R2);
+	outw(0xff << ((xx & 1) << 3), EGCIO_EGC_R4);
+//	spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+	
+	for (y = 0; y < fontheight(p); y++) {
+		*data = 0xAAAA;
+		data = (u16 *)((unsigned long)data +p->fb_info->fix.line_length);
+	}
+
+//	spin_lock_irqsave(&fbcon_egc_lock, flags);
+	outb(0x07,0x6a);	/* unprotected */
+	outb(0x04,0x6a);	/* GRCG mode */
+	outb(0x06,0x6a);	/* protected */
+	outb(0x00,0x7c);
+	isa_writeb(isa_readb(0x495)&0x7F,0x0495);
+//	spin_unlock_irqrestore(&fbcon_egc_lock, flags);
+}
+
+struct display_switch fbcon_egc = {
+    fbcon_egc_setup, fbcon_egc_bmove, fbcon_egc_clear,
+    fbcon_egc_putc, fbcon_egc_putcs, fbcon_egc_revc,
+    NULL, NULL, NULL, FONTWIDTH(8)
+};
+
+#ifdef MODULE
+int init_module(void)
+{
+    return 0;
+}
+
+void cleanup_module(void)
+{
+	/* Nothing to do. */
+}
+#endif /* MODULE */
+
+
+    /*
+     *	Visible symbols for modules
+     */
+
+EXPORT_SYMBOL(fbcon_egc);
+EXPORT_SYMBOL(fbcon_egc_setup);
+EXPORT_SYMBOL(fbcon_egc_bmove);
+EXPORT_SYMBOL(fbcon_egc_clear);
+EXPORT_SYMBOL(fbcon_egc_putc);
+EXPORT_SYMBOL(fbcon_egc_putcs);
+EXPORT_SYMBOL(fbcon_egc_revc);
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-basic-offset: 8
+ * End:
+ */
+
diff -urN linux/drivers/video/fbcon.c linux98/drivers/video/fbcon.c
--- linux/drivers/video/fbcon.c	Sun Sep  1 07:04:50 2002
+++ linux98/drivers/video/fbcon.c	Mon Sep  2 15:23:26 2002
@@ -572,7 +572,11 @@
     if (con == fg_console && info->fix.type != FB_TYPE_TEXT) {   
 	if (fbcon_softback_size) {
 	    if (!softback_buf) {
+#ifndef CONFIG_PC9800
 		softback_buf = (unsigned long)kmalloc(fbcon_softback_size, GFP_KERNEL);
+#else
+		softback_buf = (unsigned long)kmalloc(fbcon_softback_size * 2, GFP_KERNEL);
+#endif
 		if (!softback_buf) {
     	            fbcon_softback_size = 0;
     	            softback_top = 0;
@@ -658,16 +662,35 @@
     	q = (unsigned short *)(conp->vc_origin + conp->vc_size_row * old_rows);
     	step = logo_lines * old_cols;
     	for (r = q - logo_lines * old_cols; r < q; r++)
+#ifndef CONFIG_PC9800
     	    if (scr_readw(r) != conp->vc_video_erase_char)
+#else
+	    if (scr_readw((unsigned short *)((unsigned long)r+conp->vc_screenbuf_size)) !=
+		conp->vc_video_erase_attr &&
+		scr_readw(r) != conp->vc_video_erase_char)
+#endif
     	    	break;
 	if (r != q && nr_rows >= old_rows + logo_lines) {
+#ifndef CONFIG_PC9800
     	    save = kmalloc(logo_lines * nr_cols * 2, GFP_KERNEL);
+#else
+	    save = kmalloc(logo_lines * nr_cols * 2 * 2, GFP_KERNEL);
+#endif
     	    if (save) {
     	        int i = old_cols < nr_cols ? old_cols : nr_cols;
     	    	scr_memsetw(save, conp->vc_video_erase_char, logo_lines * nr_cols * 2);
+#ifdef CONFIG_PC9800
+		scr_memsetw((u16 *)((unsigned long)save + logo_lines * nr_cols * 2),
+			     conp->vc_video_erase_attr, logo_lines * nr_cols * 2);
+#endif
     	    	r = q - step;
-    	    	for (cnt = 0; cnt < logo_lines; cnt++, r += i)
+    	    	for (cnt = 0; cnt < logo_lines; cnt++, r += i) {
     	    		scr_memcpyw(save + cnt * nr_cols, r, 2 * i);
+#ifdef CONFIG_PC9800
+			scr_memcpyw((unsigned short *)((unsigned long)(save + logo_lines * nr_cols * 2)) + cnt * nr_cols,
+					 (unsigned short *)((unsigned long)r + conp->vc_screenbuf_size), 2 * i);
+#endif
+		}
     	    	r = q;
     	    }
     	}
@@ -676,6 +699,14 @@
 	    r = q - step - old_cols;
     	    for (cnt = old_rows - logo_lines; cnt > 0; cnt--) {
     	    	scr_memcpyw(r + step, r, conp->vc_size_row);
+#ifdef CONFIG_PC9800
+		scr_memcpyw((unsigned short *)((unsigned long)r
+					       + conp->vc_screenbuf_size)
+			    + step,
+			    (unsigned short *)((unsigned long)r
+					       + conp->vc_screenbuf_size),
+			    conp->vc_size_row);
+#endif
     	    	r -= old_cols;
     	    }
     	    if (!save) {
@@ -686,6 +717,12 @@
     	scr_memsetw((unsigned short *)conp->vc_origin,
 		    conp->vc_video_erase_char, 
 		    conp->vc_size_row * logo_lines);
+#ifdef CONFIG_PC9800
+	scr_memsetw((unsigned short *)((unsigned long)conp->vc_origin
+				       + conp->vc_screenbuf_size),
+		    conp->vc_video_erase_attr, 
+		    conp->vc_size_row * logo_lines);
+#endif
     }
     
     /*
@@ -734,10 +771,25 @@
 	    if (p->dispsw->clear_margins)
 		p->dispsw->clear_margins(conp, p, 0);
 	    update_screen(con);
+#ifdef CONFIG_PC9800
+	    /* reset attributes because of incompatibility */
+	    scr_memsetw((unsigned short *)((unsigned long)conp->vc_origin
+					   + conp->vc_screenbuf_size),
+			0x07, conp->vc_size_row * logo_lines);
+	    /* and redraw once more */
+	    update_screen(con);
+#endif
 	}
 	if (save) {
     	    q = (unsigned short *)(conp->vc_origin + conp->vc_size_row * old_rows);
 	    scr_memcpyw(q, save, logo_lines * nr_cols * 2);
+#ifdef CONFIG_PC9800
+	    scr_memcpyw((unsigned short *)((unsigned long)q
+					   + conp->vc_screenbuf_size),
+			(unsigned short *)((unsigned long)save
+					   + logo_lines * nr_cols * 2),
+			logo_lines * nr_cols * 2);
+#endif
 	    conp->vc_y += logo_lines;
     	    conp->vc_pos += logo_lines * conp->vc_size_row;
     	    kfree(save);
@@ -1034,10 +1086,18 @@
     unsigned long n;
     int line = 0;
     int count = conp->vc_rows;
+#ifdef CONFIG_PC9800
+    int save_bufsiz = conp->vc_screenbuf_size;
+    int d_sb = 1;
+#endif
     
     d = (u16 *)softback_curr;
-    if (d == (u16 *)softback_in)
+    if (d == (u16 *)softback_in) {
 	d = (u16 *)conp->vc_origin;
+#ifdef CONFIG_PC9800
+	d_sb=0;
+#endif
+	}
     n = softback_curr + delta * conp->vc_size_row;
     softback_lines -= delta;
     if (delta < 0) {
@@ -1063,25 +1123,47 @@
 	    softback_lines = 0;
 	}
     }
-    if (n == softback_curr)
+    if (n == softback_curr) {
+#ifdef CONFIG_PC9800
+	conp->vc_screenbuf_size = save_bufsiz;
+#endif
     	return;
+	}
     softback_curr = n;
     s = (u16 *)softback_curr;
-    if (s == (u16 *)softback_in)
+#ifdef CONFIG_PC9800
+    conp->vc_screenbuf_size = fbcon_softback_size;
+#endif
+    if (s == (u16 *)softback_in) {
 	s = (u16 *)conp->vc_origin;
+#ifdef CONFIG_PC9800
+	conp->vc_screenbuf_size = save_bufsiz;
+#endif
+	}
     while (count--) {
 	unsigned short *start;
 	unsigned short *le;
 	unsigned short c;
 	int x = 0;
 	unsigned short attr = 1;
+#ifdef CONFIG_PC9800
+	unsigned short ca;
+#endif
 
 	start = s;
 	le = advance_row(s, 1);
 	do {
 	    c = scr_readw(s);
+#ifdef CONFIG_PC9800
+	    ca= scr_readw((unsigned short *)((unsigned long)s+conp->vc_screenbuf_size));
+#endif
+#ifndef CONFIG_PC9800
 	    if (attr != (c & 0xff00)) {
 		attr = c & 0xff00;
+#else
+	    if (attr != ca) {
+		attr = ca;
+#endif
 		if (s > start) {
 		    p->dispsw->putcs(conp, p, start, s - start,
 				     real_y(p, line), x);
@@ -1089,7 +1171,15 @@
 		    start = s;
 		}
 	    }
+#ifndef CONFIG_PC9800
 	    if (c == scr_readw(d)) {
+#else
+	    if (c == scr_readw(d)
+		&& ca == scr_readw((unsigned short *)
+				   ((unsigned long)d
+				    + (d_sb ? fbcon_softback_size
+				       : conp->vc_screenbuf_size)))) {
+#endif
 	    	if (s > start) {
 	    	    p->dispsw->putcs(conp, p, start, s - start,
 				     real_y(p, line), x);
@@ -1106,15 +1196,34 @@
 	if (s > start)
 	    p->dispsw->putcs(conp, p, start, s - start, real_y(p, line), x);
 	line++;
-	if (d == (u16 *)softback_end)
+	if (d == (u16 *)softback_end) {
 	    d = (u16 *)softback_buf;
-	if (d == (u16 *)softback_in)
+#ifdef CONFIG_PC9800
+	    d_sb = 1;
+#endif
+	}
+	if (d == (u16 *)softback_in) {
 	    d = (u16 *)conp->vc_origin;
-	if (s == (u16 *)softback_end)
+#ifdef CONFIG_PC9800
+	    d_sb = 0;
+#endif
+	}
+	if (s == (u16 *)softback_end) {
 	    s = (u16 *)softback_buf;
-	if (s == (u16 *)softback_in)
+#ifdef CONFIG_PC9800
+	    conp->vc_screenbuf_size = fbcon_softback_size;
+#endif
+	}
+	if (s == (u16 *)softback_in) {
 	    s = (u16 *)conp->vc_origin;
+#ifdef CONFIG_PC9800
+	    conp->vc_screenbuf_size = save_bufsiz;
+#endif
     }
+    }
+#ifdef CONFIG_PC9800
+    conp->vc_screenbuf_size = save_bufsiz;
+#endif
 }
 
 static void fbcon_redraw(struct vc_data *conp, struct display *p, 
@@ -1130,11 +1239,23 @@
 	unsigned short c;
 	int x = 0;
 	unsigned short attr = 1;
+#ifdef CONFIG_PC9800
+	unsigned short ca;
+#endif
 
 	do {
 	    c = scr_readw(s);
+#ifdef CONFIG_PC9800
+	    ca = scr_readw((unsigned short *)((unsigned long)s
+					      + conp->vc_screenbuf_size));
+#endif
+#ifndef CONFIG_PC9800
 	    if (attr != (c & 0xff00)) {
 		attr = c & 0xff00;
+#else
+	    if (attr != ca) {
+		attr = ca;
+#endif
 		if (s > start) {
 		    p->dispsw->putcs(conp, p, start, s - start,
 				     real_y(p, line), x);
@@ -1142,7 +1263,14 @@
 		    start = s;
 		}
 	    }
+#ifndef CONFIG_PC9800
 	    if (c == scr_readw(d)) {
+#else
+	    if (c == scr_readw(d)
+		&& ca == scr_readw((unsigned short *)
+				   ((unsigned long)d
+				    + conp->vc_screenbuf_size))) {
+#endif
 	    	if (s > start) {
 	    	    p->dispsw->putcs(conp, p, start, s - start,
 				     real_y(p, line), x);
@@ -1154,6 +1282,10 @@
 	    	}
 	    }
 	    scr_writew(c, d);
+#ifdef CONFIG_PC9800
+	    scr_writew(ca, (unsigned short *)((unsigned long)d
+					      + conp->vc_screenbuf_size));
+#endif
 	    console_conditional_schedule();
 	    s++;
 	    d++;
@@ -1231,18 +1363,37 @@
 	unsigned short c;
 	int x = dx;
 	unsigned short attr = 1;
+#ifdef CONFIG_PC9800
+	unsigned short ca;
+#endif
 
 	do {
 	    c = scr_readw(d);
+#ifdef CONFIG_PC9800
+	    ca = scr_readw((unsigned short *)((unsigned long)s
+					      + conp->vc_screenbuf_size));
+#endif
+#ifndef CONFIG_PC9800
 	    if (attr != (c & 0xff00)) {
 		attr = c & 0xff00;
+#else
+	    if (attr != ca) {
+		attr = ca;
+#endif
 		if (d > start) {
 		    p->dispsw->putcs(conp, p, start, d - start, dy, x);
 		    x += d - start;
 		    start = d;
 		}
 	    }
+#ifndef CONFIG_PC9800
 	    if (s >= ls && s < le && c == scr_readw(s)) {
+#else
+	    if (s >= ls && s < le && c == scr_readw(s)
+		&& ca == scr_readw((unsigned short *)
+				   ((unsigned long)d
+				    + conp->vc_screenbuf_size))) {
+#endif
 		if (d > start) {
 		    p->dispsw->putcs(conp, p, start, d - start, dy, x);
 		    x += d - start + 1;
@@ -1272,6 +1423,11 @@
 
     while (count) {
     	scr_memcpyw((u16 *)softback_in, p, conp->vc_size_row);
+#ifdef CONFIG_PC9800
+	scr_memcpyw((u16 *)((unsigned long)softback_in+fbcon_softback_size),
+		    (u16 *)((unsigned long)p+ conp->vc_screenbuf_size),
+		    conp->vc_size_row);
+#endif
     	count--;
     	p = advance_row(p, 1);
     	softback_in += conp->vc_size_row;
@@ -1367,6 +1523,14 @@
 		    	    conp->vc_size_row * (b-count)), 
 		    	    conp->vc_video_erase_char,
 		    	    conp->vc_size_row * count);
+#ifdef CONFIG_PC9800
+		scr_memsetw((unsigned short *)((unsigned long)conp->vc_origin
+					       + conp->vc_screenbuf_size
+					       + (conp->vc_size_row
+						  * (b - count))),
+			    conp->vc_video_erase_attr,
+			    conp->vc_size_row * count);
+#endif
 		return 1;
 	    }
 	    break;
@@ -1427,6 +1591,13 @@
 	    		    conp->vc_size_row * t), 
 	    		    conp->vc_video_erase_char,
 	    		    conp->vc_size_row * count);
+#ifdef CONFIG_PC9800
+		scr_memsetw((unsigned short *)((unsigned long)conp->vc_origin
+					       + conp->vc_screenbuf_size
+					       + conp->vc_size_row * t),
+			    conp->vc_video_erase_attr,
+			    conp->vc_size_row * count);
+#endif
 	    	return 1;
 	    }
     }
@@ -2015,6 +2186,7 @@
 static void fbcon_invert_region(struct vc_data *conp, u16 *p, int cnt)
 {
     while (cnt--) {
+#ifndef CONFIG_PC9800
 	u16 a = scr_readw(p);
 	if (!conp->vc_can_do_color)
 	    a ^= 0x0800;
@@ -2023,6 +2195,19 @@
 	else
 	    a = ((a) & 0x88ff) | (((a) & 0x7000) >> 4) | (((a) & 0x0700) << 4);
 	scr_writew(a, p++);
+#else
+	    u16 *attr;
+	    if (p >= conp->vc_screenbuf
+			&& (unsigned long)p <
+				(unsigned long)(conp->vc_screenbuf)
+					+ conp->vc_screenbuf_size)
+		attr = (u16 *)((unsigned long)p + conp->vc_screenbuf_size);
+	    else
+		attr = (u16 *)((unsigned long)p + fbcon_softback_size);
+
+	scr_writew(((*attr) & 0xff00) | (((*attr) & 0x00f0) >> 4) | (((*attr) & 0x000f) << 4), attr);
+	p++;
+#endif
 	if (p == (u16 *)softback_end)
 	    p = (u16 *)softback_buf;
 	if (p == (u16 *)softback_in)
@@ -2059,6 +2244,13 @@
     		    	p -= conp->vc_size_row;
     		    	q -= conp->vc_size_row;
     		    	scr_memcpyw((u16 *)q, (u16 *)p, conp->vc_size_row);
+#ifdef CONFIG_PC9800
+			scr_memcpyw((u16 *)((unsigned long)q
+					    + conp->vc_screenbuf_size),
+				    (u16 *)((unsigned long)p
+					    + fbcon_softback_size),
+				    conp->vc_size_row);
+#endif
     		    }
     		    softback_in = p;
     		    update_region(unit, conp->vc_origin, logo_lines * conp->vc_cols);
@@ -2411,6 +2603,7 @@
 	}
 #endif
 #if defined(CONFIG_FBCON_VGA_PLANES)
+#ifndef CONFIG_PC9800
 	if (depth == 4 && info->fix.type == FB_TYPE_VGA_PLANES) {
 		outb_p(1,0x3ce); outb_p(0xf,0x3cf);
 		outb_p(3,0x3ce); outb_p(0,0x3cf);
@@ -2441,6 +2634,220 @@
 		done = 1;
 	}
 #endif			
+#endif
+#if defined(CONFIG_PC9800)
+	if (depth == 4 && info->fix.type == FB_TYPE_VGA_PLANES) {
+		/*
+		 * for GRCG framebuffers (EGC not required)
+		 */
+		u8 pldata[4], cpudata, data;
+		int hi_lo = 0, ti;
+#if 1
+#if 0
+		/* mono-bmp */
+		static u16 egcfblogo[144] = {
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000,
+		0xF003, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000,
+		0x0C0C, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000,
+		0x2211, 0xF101, 0xC1C1, 0xC3F7, 0x0080,
+		0x0000, 0x0041, 0x0500, 0x00C7,
+		0x2121, 0x0201, 0x2122, 0x2404, 0x0040,
+		0x0000, 0x0040, 0x0600, 0x8028,
+		0x2041, 0x0481, 0x0114, 0x2804, 0x780E,
+		0xF01C, 0x7941, 0x4A14, 0x8028,
+		0x2041, 0xF481, 0x0104, 0xE8E7, 0x4411,
+		0x8822, 0x4541, 0x8A12, 0x0027,
+		0x0040, 0x0481, 0x0174, 0x2804, 0x4411,
+		0x8822, 0x4541, 0x0911, 0x80E8,
+		0x0040, 0x0481, 0x0114, 0x2804, 0x4411,
+		0x8822, 0x4541, 0x0811, 0x8028,
+		0x0120, 0x0201, 0x2122, 0x2404, 0x4451,
+		0x8822, 0x4541, 0x9232, 0x8028,
+		0x0210, 0xF101, 0xC1C1, 0xC307, 0x448E,
+		0x881C, 0x447D, 0x51D4, 0x00C7,
+		0x0C0C, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000,
+		0xF003, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+		0x0000, 0x0000, 0x0000, 0x0000,};
+#endif
+		static unsigned short kmc_logo_data[] /* __initlocaldata */ = {
+			0x0000, 0x0000, 0x8007, 0x0000, 0x0000, 0x0000,
+			0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+			0x0000, 0x0000, 0x800F, 0x0000, 0x0000, 0x0000,
+			0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+			0x0000, 0x0000, 0x800F, 0x0000, 0x0000, 0x0000,
+			0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+			0x0000, 0x3800, 0x801F, 0x0000, 0x0000, 0xC000,
+			0x0000, 0x0000, 0x0200, 0x0000, 0x0000,
+			0x0000, 0x7800, 0x803F, 0x0000, 0xF00F, 0xC000,
+			0x0000, 0x0000, 0x0400, 0x000F, 0x003E,
+			0x0000, 0xF800, 0x803F, 0x0000, 0x8001, 0x0000,
+			0x0000, 0x0000, 0x0400, 0xC031, 0x00C3,
+			0x0000, 0xF800, 0x807F, 0x0000, 0x8001, 0x0000,
+			0x0000, 0x0000, 0x0400, 0x4160, 0x8081,
+			0x0000, 0xF801, 0x80FF, 0x0000, 0x8001, 0x0000,
+			0x0000, 0x0000, 0x0800, 0x6140, 0x8081,
+			0x0000, 0xF903, 0x80FF, 0x0000, 0x8001, 0x0000,
+			0x0000, 0x0000, 0x0800, 0x31C0, 0x8081,
+			0x0000, 0xF903, 0x80FF, 0x0000, 0x8001, 0x0000,
+			0x0000, 0x0000, 0x0800, 0x31C0, 0x00C1,
+			0x0000, 0xFB07, 0x80F7, 0x0000, 0x8001, 0xC100,
+			0x1E8E, 0x7C1E, 0x107C, 0x30C0, 0x00E3,
+			0x0000, 0xFF0F, 0xC0F7, 0x0000, 0x8001, 0xC703,
+			0x06BF, 0x1806, 0x1030, 0x30C0, 0x0074,
+			0x1EFE, 0xBF0F, 0xF0E7, 0xFE03, 0x8001, 0xC100,
+			0x86E3, 0x0C06, 0x1020, 0x30E0, 0x0038,
+			0x1CFE, 0x3F1F, 0xE0C7, 0xFE01, 0x8001, 0xC100,
+			0x8681, 0x0E06, 0x2040, 0x3060, 0x003C,
+			0x1CFE, 0x3F3E, 0xE087, 0xFE00, 0x8001, 0xC100,
+			0x8681, 0x0606, 0x2080, 0x7030, 0x004E,
+			0x18FE, 0x3F3E, 0xC187, 0xFEE3, 0x8001, 0xC100,
+			0x8681, 0x0306, 0x2080, 0xA01F, 0x00C7,
+			0x10FE, 0x3F7C, 0xC307, 0xFEFF, 0x8001, 0xC100,
+			0x8681, 0x0106, 0x4080, 0x6100, 0x8083,
+			0x10FE, 0x00F8, 0xC307, 0xFEFF, 0x8001, 0xC100,
+			0x8681, 0x0206, 0x40C0, 0xC100, 0x8081,
+			0x00FE, 0x00F8, 0x8307, 0xFEFF, 0x8001, 0xC110,
+			0x8681, 0x0406, 0x4060, 0x8100, 0x8081,
+			0x00FE, 0x00F0, 0x8307, 0xFEFF, 0x8001, 0xC120,
+			0x8681, 0x0806, 0x8070, 0x8101, 0x8081,
+			0x10FE, 0x0060, 0xC307, 0xFEFF, 0x8001, 0xC120,
+			0x8781, 0x101E, 0x8038, 0x0006, 0x00C1,
+			0x18FE, 0x0040, 0xC107, 0xFEF3, 0x8001, 0xC1E0,
+			0x8381, 0xB0F7, 0x801C, 0x001C, 0x00C3,
+			0x18FE, 0x0000, 0xC007, 0xFE01, 0xFF0F, 0xF7C3,
+			0xE1E7, 0x78C6, 0x007F, 0x00F0, 0x003C,
+			0x1CFE, 0x0000, 0xE007, 0xFE01, 0x0000, 0x0000,
+			0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+			0x1EFE, 0x0000, 0xF007, 0xFE01, 0x0000, 0x0000,
+			0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+			0x1EFE, 0x0000, 0xFC07, 0xFE07, 0x0000, 0x0000,
+			0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+			0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+			0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
+			0x1CE0, 0x8001, 0x0F08, 0xE000, 0x0038, 0x1C00,
+			0x8007, 0x0CE0, 0x8003, 0x0848, 0x8008,
+			0x1290, 0x4002, 0x0808, 0x0001, 0x0010, 0x2000,
+			0x0004, 0x1290, 0x4002, 0x0848, 0x800D,
+			0x1CE0, 0x4002, 0x0E08, 0x0001, 0x0010, 0x1800,
+			0x0007, 0x1EE0, 0x8003, 0x0878, 0x800A,
+			0x1280, 0x4002, 0x0848, 0x0001, 0x0010, 0x0400,
+			0x0004, 0x1290, 0x0002, 0x0848, 0x8008,
+			0x1280, 0x8001, 0x0F30, 0xE000, 0x0010, 0x3800,
+			0x8007, 0x1290, 0x0002, 0x0848, 0x8008
+		};
+
+#endif
+		/* setup ; GRCG ON */
+		outb(0xc0, 0x7c);
+#if 1
+		/* Logo test :-) */
+		if (x == 0) {
+			int lg_start_x;
+			int lg_wd_x;
+			/* clearing by pal no.0 */
+			outb(0x00, 0x7e);
+			outb(0x00, 0x7e);
+			outb(0x00, 0x7e);
+			outb(0x00, 0x7e);
+			for (y1 = 0; y1 < LOGO_H; y1++) {
+				for (x1 = 0; x1 < 40; x1 ++) {
+				dst = fb + y1 * line + x1 * 2;
+				*((u16 *)dst) = 0xffff;
+				}
+			}
+			/* draw Linux/98 */
+			lg_start_x = num_online_cpus() * (LOGO_W + 8) - 8;
+			lg_wd_x = (lg_start_x + 15) >> 4;
+			if (lg_wd_x + 11 <= 40 && LOGO_H >= 32) {
+				int ptr = ((40 - lg_wd_x) + lg_wd_x * 2 - 11) / 2;
+				outb(0xff, 0x7e);
+				outb(0xff, 0x7e);
+				outb(0xff, 0x7e);
+				outb(0xff, 0x7e);
+				for (y1 = 0; y1 < 32; y1++) {
+					for (x1 = 0; x1 < 11; x1 ++) {
+					dst = fb + (y1 + (LOGO_H >> 1) - 16) * 
+					      line + ((x1 + ptr) * 2);
+					*((u16 *)dst) = kmc_logo_data[y1 * 11 + x1];
+					}
+				}
+			}
+#if 0
+			/* draw egc logo */
+			if (LOGO_H >= 16 && lg_wd_x + 9 <= 40) {
+				outb(0xff, 0x7e);
+				outb(0xff, 0x7e);
+				outb(0x00, 0x7e);
+				outb(0x00, 0x7e);
+				for (y1 = 0; y1 < 16; y1++) {
+					for (x1 = 0; x1 < 9; x1 ++) {
+					dst = fb + (y1) * 
+					      line + (line - 18 + x1 * 2) ;
+					*((u16 *)dst) = egcfblogo[y1 * 9 + x1];
+					}
+				}
+			}
+#endif
+		}
+#endif
+		/* Drawing Penguins... */
+		src = logo;
+		for (y1 = 0; y1 < LOGO_H; y1++) {
+			/* data stack */
+			cpudata = 0;
+			for (ti = 0; ti < 4; ti ++)
+				pldata[ti] = 0;
+			for (x1 = 0; x1 < LOGO_W; x1++) {
+				/* read data */
+				if (!hi_lo) {
+					data = *src >> 4;
+					hi_lo = 1;
+				} else {
+					data = *src & 0xf;
+					src ++;
+					hi_lo = 0;
+				}
+				cpudata |= 1 << (7 - ((x1 + x) & 7));
+				for (ti = 0; ti < 4; ti ++)
+					pldata[ti] |=
+					((data & (1 << ti)) ? (1):(0))
+						<< (7 - ((x1 + x) & 7));
+				if (((x1 + x) & 7) == 7 && cpudata) {
+					for (ti = 0; ti < 4; ti ++)
+						{
+						outb(pldata[ti], 0x7e);
+						pldata[ti] = 0;
+						}
+					dst = fb + y1 * line + ((x1 + x) >> 3);
+					*((char *)dst) = cpudata;
+					cpudata = 0;
+				}
+				/* end */
+			}
+		/* send last data */
+		       if (cpudata) {
+				for (ti = 0; ti < 4; ti ++)
+					outb(pldata[ti], 0x7e);
+				dst = fb + y1 * line + ((x1 + x) >> 3);
+				*dst = cpudata;
+				cpudata = 0;
+			}
+		}
+	/* GRCG OFF */
+	outb(0x00, 0x7c);
+	done = 1;
+	}
+#endif
     }
     
     if (p->fb_info->fbops->fb_rasterimg)
@@ -2452,6 +2859,41 @@
     return done ? (LOGO_H + fontheight(p) - 1) / fontheight(p) : 0 ;
 }
 
+#ifdef CONFIG_PC9800
+static u8 fbcon_attr_at(struct vc_data *con,u8 _color, u8 _intensity,
+			u8 _blink, u8 _underline, u8 _reverse)
+{
+#if 0
+	u8 a = _color;
+	if (_underline)
+		a = (a & 0xf0) | 0x0f;
+	else if (_intensity == 0)
+		a = (a & 0xf0) | 0x08;
+	if (_reverse)
+		a = ((a) & 0x88) | ((((a) >> 4) | ((a) << 4)) & 0x77);
+	if (_blink)
+		a ^= 0x80;
+	if (_intensity == 2)
+		a ^= 0x08;
+	return a;
+#else
+	u8 clr = _color;
+	con->vc_pc98_addbuf = 0;
+	if (_intensity > 0)
+		clr |= 0x08;
+	if (_intensity > 1)
+		con->vc_pc98_addbuf |= 0x01; /* bold */
+	if (_underline)
+		con->vc_pc98_addbuf |= 0x02; /* underline */
+	if (_blink)
+		clr |= 0x80;
+	if (_reverse)
+		clr = ((clr << 4) & 0xf0) | ((clr >> 4) & 0x0f);
+	return clr;
+#endif
+}
+#endif
+
 /*
  *  The console `switch' structure for the frame buffer based console
  */
@@ -2472,6 +2914,9 @@
     .con_set_palette = 	fbcon_set_palette,
     .con_scrolldelta = 	fbcon_scrolldelta,
     .con_set_origin = 	fbcon_set_origin,
+#ifdef CONFIG_PC9800
+    .con_build_attr =	fbcon_attr_at,
+#endif
     .con_invert_region = fbcon_invert_region,
     .con_screen_pos =	fbcon_screen_pos,
     .con_getxy =	fbcon_getxy,
diff -urN linux/drivers/video/fbmem.c linux98/drivers/video/fbmem.c
--- linux/drivers/video/fbmem.c	Sun Sep  1 07:04:45 2002
+++ linux98/drivers/video/fbmem.c	Mon Sep  2 15:19:37 2002
@@ -135,6 +135,8 @@
 extern void tx3912fb_setup(char*);
 extern int radeonfb_init(void);
 extern int radeonfb_setup(char*);
+extern int egcfb_init(void);
+extern int egcfb_setup(char*);
 extern int e1355fb_init(void);
 extern int e1355fb_setup(char*);
 extern int pvr2fb_init(void);
@@ -294,6 +296,9 @@
 #ifdef CONFIG_FB_SA1100
 	{ "sa1100", sa1100fb_init, NULL },
 #endif
+#ifdef CONFIG_FB_EGC
+	{ "egc", egcfb_init, egcfb_setup },
+#endif
 #ifdef CONFIG_FB_SUN3
 	{ "sun3", sun3fb_init, sun3fb_setup },
 #endif
@@ -397,6 +402,34 @@
 	if (!info || ! info->screen_base)
 		return -ENODEV;
 
+#ifdef CONFIG_PC9800
+	if (!strcmp(info->fix.id, "egc")) {
+		/* for PC-98x1 VRAM */
+		unsigned long total_copy_size = 0;
+		/* R,G,B plane */
+		if (p < 96*1024) {
+			unsigned long copy_size
+			    = count + p <= 96 * 1024 ? count : 96 * 1024 - p;
+			if (copy_to_user (buf, phys_to_virt(0xA8000+p),
+					  copy_size))
+				return -EFAULT;
+			count -= copy_size;
+			p += copy_size;
+			buf += copy_size;
+			total_copy_size += copy_size;
+		}
+		if(p >= 96*1024 && count > 0) {
+			unsigned long copy_size
+			    = count + p <= 128*1024 ? count : 128*1024 - p;
+			if (copy_to_user(buf,
+					  phys_to_virt(0xE0000 + p - 96*1024),
+					  copy_size))
+				return -EFAULT;
+			total_copy_size += copy_size;
+		}
+		return total_copy_size;
+	}
+#endif
 	if (p >= info->fix.smem_len)
 	    return 0;
 	if (count >= info->fix.smem_len)
@@ -436,6 +469,33 @@
 	    count = info->fix.smem_len - p;
 	    err = -ENOSPC;
 	}
+#ifdef CONFIG_PC9800
+	if (!strcmp(info->fix.id, "egc")) {
+		/* for PC-98x1 VRAM */
+		unsigned long total_copy_size = 0;
+		/* R,G,B plane */
+		if(p < 96*1024) {
+			unsigned long copy_size
+			    = count + p <= 96*1024 ? count : 96*1024 - p;
+			if (copy_from_user(phys_to_virt(0xA8000+p), buf,
+					    copy_size))
+				return -EFAULT;
+			count -= copy_size;
+			p += copy_size;
+			buf += copy_size;
+			total_copy_size += copy_size;
+		}
+		if(p >= 96*1024 && count > 0) {
+			unsigned long copy_size
+			    = count + p <= 128*1024 ? count : 128*1024 - p;
+			if (copy_from_user(phys_to_virt(0xE0000+p-96*1024),
+					    buf, copy_size))
+				return -EFAULT;
+			total_copy_size += copy_size;
+		}
+		return total_copy_size;
+	}
+#endif
 	if (count) {
 	    char *base_addr;
 
diff -urN linux/include/video/fbcon-egc.h linux98/include/video/fbcon-egc.h
--- linux/include/video/fbcon-egc.h	Thu Jan  1 09:00:00 1970
+++ linux98/include/video/fbcon-egc.h	Fri Aug 17 21:50:18 2001
@@ -0,0 +1,32 @@
+/*
+ *	FBcon low-level driver for EGC
+ */
+
+#ifndef _VIDEO_FBCON_EGC_H
+#define _VIDEO_FBCON_EGC_H
+
+#include <linux/config.h>
+
+#ifdef MODULE
+#if defined(CONFIG_FBCON_EGC) || defined(CONFIG_FBCON_EGC_MODULE)
+#define FBCON_HAS_EGC
+#endif
+#else
+#if defined(CONFIG_FBCON_EGC)
+#define FBCON_HAS_EGC
+#endif
+#endif
+
+extern struct display_switch fbcon_egc;
+extern void fbcon_egc_setup(struct display *p);
+extern void fbcon_egc_bmove(struct display *p, int sy, int sx, int dy, int dx,
+				   int height, int width);
+extern void fbcon_egc_clear(struct vc_data *conp, struct display *p, int sy,
+				   int sx, int height, int width);
+extern void fbcon_egc_putc(struct vc_data *conp, struct display *p, int c,
+				  int yy, int xx);
+extern void fbcon_egc_putcs(struct vc_data *conp, struct display *p,
+				   const unsigned short *s, int count, int yy, int xx);
+extern void fbcon_egc_revc(struct display *p, int xx, int yy);
+
+#endif /* _VIDEO_FBCON_EGC_H */
