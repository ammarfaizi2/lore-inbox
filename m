Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbUCYRW4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263455AbUCYRW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:22:56 -0500
Received: from mail9.messagelabs.com ([194.205.110.133]:62443 "HELO
	mail9.messagelabs.com") by vger.kernel.org with SMTP
	id S263505AbUCYRNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 12:13:43 -0500
X-VirusChecked: Checked
X-Env-Sender: icampbell@arcom.com
X-Msg-Ref: server-8.tower-9.messagelabs.com!1080234812!6914189
X-StarScan-Version: 5.1.15; banners=arcom.com,-,-
Subject: Re: [PATCH] PXA255 LCD Driver
From: Ian Campbell <icampbell@arcom.com>
To: James Simmons <jsimmons@infradead.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0403192352050.14905-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0403192352050.14905-100000@phoenix.infradead.org>
Content-Type: multipart/mixed; boundary="=-oiWvGqK5ecqsOeXUcrPy"
Organization: Arcom Control Systems
Message-Id: <1080234819.31091.133.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 25 Mar 2004 17:13:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oiWvGqK5ecqsOeXUcrPy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi James and others,

I've been playing with trying to get something which uses fb_monspecs
put together. The patch is littered with FIXME, TODO and debugging cruft
but it seems to work for the two panels I have bothered to put in the
LCD DB. If the general approach is satisfactory for you I will look at
tidying it up and making everything work properly. I'm not sure about
the aesthetics physical_interface stuff in fb_monspecs but that can be
changed as you wish. Perhaps a ->type field + a union to cover
MONITOR/TFT/STN in a space efficient manner?? I'm not sure what sort of
API/ABI guarentees are being made for fb_monspecs and fb_videomode at
this time.

I couldn't find suitable places for a few settings. They are commented
in fb.h (and hardcoded for now in pxafb). The settings are the bit depth
and some color map stuff.

I'm not happy with the way the fb_videomode and the fb_monspecs are
separated in lcddb.c. I'm not sure if there is syntax in C to allow me
to put the pointer to fb_videomode inline in the fb_monspecs
declaration. Perhaps I will define a datatype fb_lcd_info which is
roughly the same as the commented out stuff in
include/asm-arm/arch-pxa/pxafb.h and have fb_lcd_lookup construct the
fb_monspec with dynamically allocated fb_videomode from that (which
might be best anyway, since other code looks like it might expect the
modedb to be dynamically allocated).

My only thought is that having done that, perhaps it makes sense to
dispense with the fb_monspecs stuff and have drivers use fb_lcd_info
directly. What does using fb_monspecs gain us over this scenario? 

Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been checked for all viruses by MessageLabs Virus Control Centre.
--=-oiWvGqK5ecqsOeXUcrPy
Content-Description: 
Content-Disposition: inline; filename=pxafb.patch
Content-Type: text/x-patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Index: linux-2.6-bkpxa/drivers/video/Makefile
===================================================================
--- linux-2.6-bkpxa.orig/drivers/video/Makefile	2004-03-24 10:39:26.000000000 +0000
+++ linux-2.6-bkpxa/drivers/video/Makefile	2004-03-25 15:36:02.000000000 +0000
@@ -88,4 +88,6 @@
 				      cfbfillrect.o
 obj-$(CONFIG_FB_LEO)               += leo.o sbuslib.o cfbimgblt.o cfbcopyarea.o \
 				      cfbfillrect.o
+obj-$(CONFIG_FB_PXA)		   += pxafb.o lcddb.o cfbimgblt.o cfbcopyarea.o cfbfillrect.o
+CFLAGS_pxafb.o = -DDEBUG
 
Index: linux-2.6-bkpxa/drivers/video/lcddb.c
===================================================================
--- linux-2.6-bkpxa.orig/drivers/video/lcddb.c	2004-03-24 10:32:56.000000000 +0000
+++ linux-2.6-bkpxa/drivers/video/lcddb.c	2004-03-25 16:04:09.000000000 +0000
@@ -0,0 +1,87 @@
+#include <linux/module.h>
+#include <linux/tty.h>
+#include <linux/fb.h>
+
+/* FIXME: move to Kconfig */
+#define CONFIG_BF_LCD_NL3224BC35
+#define CONFIG_BF_LCD_NL6448AC20
+
+#ifdef CONFIG_BF_LCD_NL3224BC35
+static struct fb_videomode mode_NL3224BC35 = {
+	.xres         = 320, .yres         = 240,
+	.pixclock     = 157500, 
+	.left_margin  = 7,   .right_margin = 13,
+	.upper_margin = 1,   .lower_margin = 1,
+	.hsync_len    = 63,  .vsync_len    = 20,
+	.sync         = 0,
+};
+#endif
+
+#ifdef CONFIG_BF_LCD_NL6448AC20
+static struct fb_videomode mode_NL6448AC20 = {
+	.xres         = 640, .yres         = 480,
+	.pixclock     = 39722, 
+	.left_margin  = 16,  .right_margin = 81,
+	.upper_margin = 12,  .lower_margin = 31,
+	.hsync_len    = 63,  .vsync_len    = 2,
+	.sync         = 0
+};
+#endif
+
+/* I don't know where to store the bit depth */
+struct fb_monspecs lcd_db[] = {
+#ifdef CONFIG_BF_LCD_NL3224BC35
+	/* NL3224BC35 */
+	/* geometry 320 240 320 240 16 */
+	/* timings 157500 7 13 1 1 63 20 */
+	{
+		.monitor = "NL3224BC35",
+		.input = FB_DISP_RGB,
+		.modedb_len = 1,
+		.modedb = &mode_NL3224BC35,
+		.physical_interface = FB_LCD_PHYS_KIND_TFT |
+		                      FB_LCD_PHYS_OUTEN_HIGH |
+		                      FB_LCD_PHYS_PIXPOL_FALLING,
+	},
+#endif
+
+#ifdef CONFIG_BF_LCD_NL6448AC20
+	/* NL6448AC20" */
+	/* geometry 640 480 640 480 16 */
+	/* timings 39722 16 81 12 31 63 2 */
+	{
+		/* where to store bit depth? */
+		.monitor = "NL6448AC20",
+		.input = FB_DISP_RGB,
+		.modedb_len = 1,
+		.modedb = &mode_NL6448AC20,
+		.physical_interface = FB_LCD_PHYS_KIND_TFT |
+		                      FB_LCD_PHYS_OUTEN_HIGH |
+		                      FB_LCD_PHYS_PIXPOL_FALLING,
+	},
+#endif
+
+};
+
+int fb_lcd_lookup(const char *name, struct fb_monspecs *monspec)
+{
+	int i;
+	printk("fb_lcd_lookup: Looking for %s: ", name);
+	for (i=0; i<ARRAY_SIZE(lcd_db); i++) {
+		if (strcmp(name,lcd_db[i].monitor)==0) {
+			/* perhaps 
+			   fb_destroy_mode_db(*monspec);
+			   *monspec = lcd_db[i];
+			   monspec->modedb = kmalloc;
+			   monspec->modedb[0] = lcd_db[i]
+			*/
+			*monspec = lcd_db[i];
+			printk("found\n");
+			return 0;
+		}
+	}
+	printk("not found\n");
+	return -EINVAL;
+}
+
+EXPORT_SYMBOL(fb_lcd_lookup);
Index: linux-2.6-bkpxa/drivers/video/pxafb.c
===================================================================
--- linux-2.6-bkpxa.orig/drivers/video/pxafb.c	2004-03-24 10:32:56.000000000 +0000
+++ linux-2.6-bkpxa/drivers/video/pxafb.c	2004-03-25 15:51:43.000000000 +0000
@@ -0,0 +1,1423 @@
+/*
+ *  linux/drivers/video/pxafb.c
+ *
+ *  Copyright (C) 1999 Eric A. Thomas.
+ *  Copyright (C) 2004 Jean-Frederic Clere.
+ *  Copyright (C) 2004 Ian Campbell.
+ *  Copyright (C) 2004 Jeff Lackey.
+ *   Based on acornfb.c Copyright (C) Russell King.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ *	        Intel PXA250/210 LCD Controller Frame Buffer Driver
+ *
+ * Please direct your questions and comments on this driver to the following
+ * email address:
+ *
+ *	linux-arm-kernel@lists.arm.linux.org.uk
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/fb.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/cpufreq.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/hardware.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/mach-types.h>
+#include <asm/uaccess.h>
+#include <asm/arch/bitfield.h>
+#include <asm/arch/pxafb.h>
+
+/*
+ * Complain if VAR is out of range.
+ */
+#define DEBUG_VAR 1
+
+#include "pxafb.h"
+
+/*
+ * Defining this is OK for consoles but it
+ * causes problems for windowing packages.
+ */
+#undef BLANKING_SET_PALETTE
+
+/* Bits which should not be set in machine configuration structures */
+#define LCCR0_INVALID_CONFIG_MASK (LCCR0_OUM|LCCR0_BM|LCCR0_QDM|LCCR0_DIS|LCCR0_EFM|LCCR0_IUM|LCCR0_SFM|LCCR0_LDM|LCCR0_ENB)
+#define LCCR3_INVALID_CONFIG_MASK (LCCR3_HSP|LCCR3_VSP|LCCR3_PCD|LCCR3_BPP)
+
+static void (*pxafb_backlight_power)(int);
+static void (*pxafb_lcd_power)(int);
+
+static int pxafb_activate_var(struct fb_var_screeninfo *var, struct pxafb_info *);
+static void set_ctrlr_state(struct pxafb_info *fbi, u_int state);
+
+#define PXAFB_OPTIONS_SIZE 256
+static char g_options[PXAFB_OPTIONS_SIZE] __initdata = "";
+
+static inline void pxafb_schedule_work(struct pxafb_info *fbi, u_int state)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	/*
+	 * We need to handle two requests being made at the same time.
+	 * There are two important cases:
+	 *  1. When we are changing VT (C_REENABLE) while unblanking (C_ENABLE)
+	 *     We must perform the unblanking, which will do our REENABLE for us.
+	 *  2. When we are blanking, but immediately unblank before we have
+	 *     blanked.  We do the "REENABLE" thing here as well, just to be sure.
+	 */
+	if (fbi->task_state == C_ENABLE && state == C_REENABLE)
+		state = (u_int) -1;
+	if (fbi->task_state == C_DISABLE && state == C_ENABLE)
+		state = C_REENABLE;
+
+	if (state != (u_int)-1) {
+		fbi->task_state = state;
+		schedule_work(&fbi->task);
+	}
+	local_irq_restore(flags);
+}
+
+static inline u_int chan_to_field(u_int chan, struct fb_bitfield *bf)
+{
+	chan &= 0xffff;
+	chan >>= 16 - bf->length;
+	return chan << bf->offset;
+}
+
+/*
+ * Convert bits-per-pixel to a hardware palette PBS value.
+ */
+static inline u_int palette_pbs(struct fb_var_screeninfo *var)
+{
+	int ret = 0;
+	switch (var->bits_per_pixel) {
+	case 4:  ret = 0 << 12;	break;
+	case 8:  ret = 1 << 12; break;
+	case 16: ret = 2 << 12; break;
+	}
+	return ret;
+}
+
+static int
+pxafb_setpalettereg(u_int regno, u_int red, u_int green, u_int blue,
+		       u_int trans, struct fb_info *info)
+{
+	struct pxafb_info *fbi = (struct pxafb_info *)info;
+	u_int val, ret = 1;
+
+	if (regno < fbi->palette_size) {
+		val  = ((red   >>  0) & 0xf800);
+		val |= ((green >>  5) & 0x07e0);
+		val |= ((blue  >> 11) & 0x001f);
+
+		if (regno == 0)
+			val |= palette_pbs(&fbi->fb.var);
+
+		fbi->palette_cpu[regno] = val;
+		ret = 0;
+	}
+	return ret;
+}
+
+static int
+pxafb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
+		   u_int trans, struct fb_info *info)
+{
+	struct pxafb_info *fbi = (struct pxafb_info *)info;
+	unsigned int val;
+	int ret = 1;
+
+	/*
+	 * If inverse mode was selected, invert all the colours
+	 * rather than the register number.  The register number
+	 * is what you poke into the framebuffer to produce the
+	 * colour you requested.
+	 */
+	if (fbi->cmap_inverse) {
+		red   = 0xffff - red;
+		green = 0xffff - green;
+		blue  = 0xffff - blue;
+	}
+
+	/*
+	 * If greyscale is true, then we convert the RGB value
+	 * to greyscale no matter what visual we are using.
+	 */
+	if (fbi->fb.var.grayscale)
+		red = green = blue = (19595 * red + 38470 * green +
+					7471 * blue) >> 16;
+
+	switch (fbi->fb.fix.visual) {
+	case FB_VISUAL_TRUECOLOR:
+		/*
+		 * 12 or 16-bit True Colour.  We encode the RGB value
+		 * according to the RGB bitfield information.
+		 */
+		if (regno <= 16) {
+			u32 *pal = fbi->fb.pseudo_palette;
+
+			val  = chan_to_field(red, &fbi->fb.var.red);
+			val |= chan_to_field(green, &fbi->fb.var.green);
+			val |= chan_to_field(blue, &fbi->fb.var.blue);
+
+			pal[regno] = val;
+			ret = 0;
+		}
+		break;
+
+	case FB_VISUAL_STATIC_PSEUDOCOLOR:
+	case FB_VISUAL_PSEUDOCOLOR:
+		ret = pxafb_setpalettereg(regno, red, green, blue, trans, info);
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ *  pxafb_bpp_to_lccr3():
+ *    Convert a bits per pixel value to the correct bit pattern for LCCR3
+ */
+static int pxafb_bpp_to_lccr3(struct fb_var_screeninfo *var)
+{
+        int ret = 0;
+        switch (var->bits_per_pixel) {
+        case 1:  ret = LCCR3_1BPP; break;
+        case 2:  ret = LCCR3_2BPP; break;
+        case 4:  ret = LCCR3_4BPP; break;
+        case 8:  ret = LCCR3_8BPP; break;
+        case 16: ret = LCCR3_16BPP; break;
+        }
+        return ret;
+}
+
+#ifdef CONFIG_CPU_FREQ
+/*
+ *  pxafb_display_dma_period()
+ *    Calculate the minimum period (in picoseconds) between two DMA
+ *    requests for the LCD controller.  If we hit this, it means we're
+ *    doing nothing but LCD DMA.
+ */
+static unsigned int pxafb_display_dma_period(struct fb_var_screeninfo *var)
+{
+       /*
+        * Period = pixclock * bits_per_byte * bytes_per_transfer
+        *              / memory_bits_per_pixel;
+        */
+       return var->pixclock * 8 * 16 / var->bits_per_pixel;
+}
+
+extern unsigned int get_clk_frequency_khz(int info);
+#endif
+
+/*
+ *  pxafb_check_var():
+ *    Get the video params out of 'var'. If a value doesn't fit, round it up,
+ *    if it's too big, return -EINVAL.
+ *
+ *    Round up in the following order: bits_per_pixel, xres,
+ *    yres, xres_virtual, yres_virtual, xoffset, yoffset, grayscale,
+ *    bitfields, horizontal timing, vertical timing.
+ */
+static int pxafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct pxafb_info *fbi = (struct pxafb_info *)info;
+
+	if (var->xres < MIN_XRES)
+		var->xres = MIN_XRES;
+	if (var->yres < MIN_YRES)
+		var->yres = MIN_YRES;
+	if (var->xres > fbi->max_xres)
+		var->xres = fbi->max_xres;
+	if (var->yres > fbi->max_yres)
+		var->yres = fbi->max_yres;
+	var->xres_virtual =
+		max(var->xres_virtual, var->xres);
+	var->yres_virtual =
+		max(var->yres_virtual, var->yres);
+
+
+	DPRINTK("var->bits_per_pixel=%d\n", var->bits_per_pixel);
+        /*
+	 * Setup the RGB parameters for this display.
+	 *
+	 * The pixel packing format is described on page 7-11 of the
+	 * PXA2XX Developer's Manual.
+         */
+	if ( var->bits_per_pixel == 16 ) {
+		var->red.offset   = 11; var->red.length   = 5;
+		var->green.offset = 5;  var->green.length = 6;
+		var->blue.offset  = 0;  var->blue.length  = 5;
+		var->transp.offset = var->transp.length = 0;
+	} else {
+		var->red.offset = var->green.offset = var->blue.offset = var->transp.offset = 0;  
+		var->red.length   = 8;
+		var->green.length = 8;
+		var->blue.length  = 8;
+		var->transp.length = 0;
+	}
+	
+#ifdef CONFIG_CPU_FREQ
+	DPRINTK("dma period = %d ps, clock = %d kHz\n",
+		pxafb_display_dma_period(var),
+		get_clk_frequency_khz(0));
+#endif
+
+	return 0;
+}
+
+static inline void pxafb_set_truecolor(u_int is_true_color)
+{
+	DPRINTK("true_color = %d\n", is_true_color);
+	// do your machine-specific setup if needed
+}
+
+/*
+ * pxafb_set_par():
+ *	Set the user defined part of the display for the specified console
+ */
+static int pxafb_set_par(struct fb_info *info)
+{
+	struct pxafb_info *fbi = (struct pxafb_info *)info;
+	struct fb_var_screeninfo *var = &info->var;
+	unsigned long palette_mem_size;
+
+	DPRINTK("set_par\n");
+
+	if (var->bits_per_pixel == 16)
+		fbi->fb.fix.visual = FB_VISUAL_TRUECOLOR;
+	else if (!fbi->cmap_static)
+		fbi->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR;
+	else {
+		/*
+		 * Some people have weird ideas about wanting static
+		 * pseudocolor maps.  I suspect their user space
+		 * applications are broken.
+		 */
+		fbi->fb.fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR;
+	}
+
+	fbi->fb.fix.line_length = var->xres_virtual *
+				  var->bits_per_pixel / 8;
+	fbi->palette_size = var->bits_per_pixel == 8 ? 256 : 16;
+
+	palette_mem_size = fbi->palette_size * sizeof(u16);
+
+	DPRINTK("palette_mem_size = 0x%08lx\n", (u_long) palette_mem_size);
+
+	fbi->palette_cpu = (u16 *)(fbi->map_cpu + PAGE_SIZE - palette_mem_size);
+	fbi->palette_dma = fbi->map_dma + PAGE_SIZE - palette_mem_size;
+
+	/*
+	 * Set (any) board control register to handle new color depth
+	 */
+	pxafb_set_truecolor(fbi->fb.fix.visual == FB_VISUAL_TRUECOLOR);
+
+	pxafb_activate_var(var, fbi);
+
+	return 0;
+}
+
+/*
+ * Formal definition of the VESA spec:
+ *  On
+ *  	This refers to the state of the display when it is in full operation
+ *  Stand-By
+ *  	This defines an optional operating state of minimal power reduction with
+ *  	the shortest recovery time
+ *  Suspend
+ *  	This refers to a level of power management in which substantial power
+ *  	reduction is achieved by the display.  The display can have a longer 
+ *  	recovery time from this state than from the Stand-by state
+ *  Off
+ *  	This indicates that the display is consuming the lowest level of power
+ *  	and is non-operational. Recovery from this state may optionally require
+ *  	the user to manually power on the monitor
+ *
+ *  Now, the fbdev driver adds an additional state, (blank), where they
+ *  turn off the video (maybe by colormap tricks), but don't mess with the
+ *  video itself: think of it semantically between on and Stand-By.
+ *
+ *  So here's what we should do in our fbdev blank routine:
+ *
+ *  	VESA_NO_BLANKING (mode 0)	Video on,  front/back light on
+ *  	VESA_VSYNC_SUSPEND (mode 1)  	Video on,  front/back light off
+ *  	VESA_HSYNC_SUSPEND (mode 2)  	Video on,  front/back light off
+ *  	VESA_POWERDOWN (mode 3)		Video off, front/back light off
+ *
+ *  This will match the matrox implementation.
+ */
+
+/*
+ * pxafb_blank():
+ *	Blank the display by setting all palette values to zero.  Note, the 
+ * 	12 and 16 bpp modes don't really use the palette, so this will not
+ *      blank the display in all modes.  
+ */
+static int pxafb_blank(int blank, struct fb_info *info)
+{
+	struct pxafb_info *fbi = (struct pxafb_info *)info;
+#if BLANKING_SET_PALETTE
+	int i;
+#endif
+
+	DPRINTK("pxafb_blank: blank=%d\n", blank);
+
+	switch (blank) {
+	case VESA_POWERDOWN:
+	case VESA_VSYNC_SUSPEND:
+	case VESA_HSYNC_SUSPEND:
+#if BLANKING_SET_PALETTE
+		// This is bad for windowing packages
+		if (fbi->fb.fix.visual == FB_VISUAL_PSEUDOCOLOR ||
+		    fbi->fb.fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
+			for (i = 0; i < fbi->palette_size; i++)
+				pxafb_setpalettereg(i, 0, 0, 0, 0, info);
+#endif
+		pxafb_schedule_work(fbi, C_DISABLE);
+		//TODO if (pxafb_blank_helper) pxafb_blank_helper(blank);
+		break;
+
+	case VESA_NO_BLANKING:
+		//TODO if (pxafb_blank_helper) pxafb_blank_helper(blank);
+#if BLANKING_SET_PALETTE
+		if (fbi->fb.fix.visual == FB_VISUAL_PSEUDOCOLOR ||
+		    fbi->fb.fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
+			fb_set_cmap(&fbi->fb.cmap, 1, info);
+#endif
+		pxafb_schedule_work(fbi, C_ENABLE);
+	}
+	return 0;
+}
+
+static struct fb_ops pxafb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_check_var	= pxafb_check_var,
+	.fb_set_par	= pxafb_set_par,
+	.fb_setcolreg	= pxafb_setcolreg,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+	.fb_blank	= pxafb_blank,
+	.fb_cursor	= soft_cursor,
+};
+
+/*
+ * Calculate the PCD value from the clock rate (in picoseconds).
+ * We take account of the PPCR clock setting.
+ * From PXA Developer's Manual:
+ *
+ *   PixelClock =      LCLK
+ *                -------------
+ *                2 ( PCD + 1 )
+ *
+ *   PCD =      LCLK
+ *         ------------- - 1
+ *         2(PixelClock)
+ *
+ * Where:
+ *   LCLK = LCD/Memory Clock
+ *   PCD = LCCR3[7:0]
+ *
+ * PixelClock here is in Hz while the pixclock argument given is the
+ * period in picoseconds. Hence PixelClock = 1 / ( pixclock * 10^-12 )
+ *
+ * The function get_lclk_frequency_10khz returns LCLK in units of
+ * 10khz. Calling the result of this function lclk gives us the
+ * following
+ *
+ *    PCD = (lclk * 10^4 ) * ( pixclock * 10^-12 )
+ *          -------------------------------------- - 1
+ *                          2
+ *
+ * Factoring the 10^4 and 10^-12 out gives 10^-8 == 1 / 100000000 as used below.
+ */
+static inline unsigned int get_pcd(unsigned int pixclock)
+{
+	unsigned long long pcd;
+
+	/* FIXME: Need to take into account Double Pixel Clock mode
+         * (DPC) bit? or perhaps set it based on the various clock
+         * speeds */
+	
+	pcd = (unsigned long long)get_lclk_frequency_10khz() * (unsigned long long)pixclock;
+	pcd /= 100000000 * 2;
+	/* no need for this, since we should subtract 1 anyway. they cancel */
+	/* pcd += 1; */ /* make up for integer math truncations */
+	return (unsigned int)pcd;
+}
+
+/*
+ * pxafb_activate_var():
+ *	Configures LCD Controller based on entries in var parameter.  Settings are      
+ *	only written to the controller if changes were made.  
+ */
+static int pxafb_activate_var(struct fb_var_screeninfo *var, struct pxafb_info *fbi)
+{
+	struct pxafb_lcd_reg new_regs;
+	u_long flags;
+	u_int pcd = get_pcd(var->pixclock);
+
+	DPRINTK("Configuring PXA LCD\n");
+
+	DPRINTK("var: xres=%d hslen=%d lm=%d rm=%d\n",
+		var->xres, var->hsync_len,
+		var->left_margin, var->right_margin);
+	DPRINTK("var: yres=%d vslen=%d um=%d bm=%d\n",
+		var->yres, var->vsync_len,
+		var->upper_margin, var->lower_margin);
+	DPRINTK("var: pixclock=%d pcd=%d\n", var->pixclock, pcd);
+
+#if DEBUG_VAR
+	if (var->xres < 16        || var->xres > 1024)
+		printk(KERN_ERR "%s: invalid xres %d\n",
+			fbi->fb.fix.id, var->xres);
+	switch(var->bits_per_pixel) {
+	case 1:
+	case 2:
+	case 4:
+	case 8:
+	case 16:
+		break;
+	default:
+		printk(KERN_ERR "%s: invalid bit depth %d\n", 
+		       fbi->fb.fix.id, var->bits_per_pixel);
+		break;
+	}
+	if (var->hsync_len < 1    || var->hsync_len > 64)
+		printk(KERN_ERR "%s: invalid hsync_len %d\n",
+			fbi->fb.fix.id, var->hsync_len);
+	if (var->left_margin < 1  || var->left_margin > 255)
+		printk(KERN_ERR "%s: invalid left_margin %d\n",
+			fbi->fb.fix.id, var->left_margin);
+	if (var->right_margin < 1 || var->right_margin > 255)
+		printk(KERN_ERR "%s: invalid right_margin %d\n",
+			fbi->fb.fix.id, var->right_margin);
+	if (var->yres < 1         || var->yres > 1024)
+		printk(KERN_ERR "%s: invalid yres %d\n",
+			fbi->fb.fix.id, var->yres);
+	if (var->vsync_len < 1    || var->vsync_len > 64)
+		printk(KERN_ERR "%s: invalid vsync_len %d\n",
+			fbi->fb.fix.id, var->vsync_len);
+	if (var->upper_margin < 0 || var->upper_margin > 255)
+		printk(KERN_ERR "%s: invalid upper_margin %d\n",
+			fbi->fb.fix.id, var->upper_margin);
+	if (var->lower_margin < 0 || var->lower_margin > 255)
+		printk(KERN_ERR "%s: invalid lower_margin %d\n",
+			fbi->fb.fix.id, var->lower_margin);
+#endif
+
+	new_regs.lccr0 = fbi->lccr0 | 
+		(LCCR0_LDM | LCCR0_SFM | LCCR0_IUM | LCCR0_EFM |
+                 LCCR0_QDM | LCCR0_BM  | LCCR0_OUM);
+	
+	new_regs.lccr1 =
+		LCCR1_DisWdth(var->xres) +
+		LCCR1_HorSnchWdth(var->hsync_len) +
+		LCCR1_BegLnDel(var->left_margin) +
+		LCCR1_EndLnDel(var->right_margin);
+		
+	new_regs.lccr2 =
+		LCCR2_DisHght(var->yres) +
+		LCCR2_VrtSnchWdth(var->vsync_len) +
+		LCCR2_BegFrmDel(var->upper_margin) +
+		LCCR2_EndFrmDel(var->lower_margin);
+
+#if defined(CONFIG_ARCH_LOOX600) || defined(CONFIG_ARCH_ADSBITSYX) || defined(CONFIG_ARCH_ADSAGX)
+#error "I don't want this"
+        new_regs.lccr3 = fbi->lccr3;
+#else
+	new_regs.lccr3 = fbi->lccr3 |
+		pxafb_bpp_to_lccr3(var) |
+		(var->sync & FB_SYNC_HOR_HIGH_ACT ? LCCR3_HorSnchH : LCCR3_HorSnchL) |
+		(var->sync & FB_SYNC_VERT_HIGH_ACT ? LCCR3_VrtSnchH : LCCR3_VrtSnchL);
+
+	if (pcd)
+		new_regs.lccr3 |= LCCR3_PixClkDiv(pcd);
+#endif
+
+	DPRINTK("nlccr0 = 0x%08x\n", new_regs.lccr0);
+	DPRINTK("nlccr1 = 0x%08x\n", new_regs.lccr1);
+	DPRINTK("nlccr2 = 0x%08x\n", new_regs.lccr2);
+	DPRINTK("nlccr3 = 0x%08x\n", new_regs.lccr3);
+
+	/* Update shadow copy atomically */
+	local_irq_save(flags);
+
+	/* setup dma descriptors */
+	fbi->dmadesc_fblow_cpu = (struct pxafb_dma_descriptor *)((unsigned int)fbi->palette_cpu - 3*16);
+	fbi->dmadesc_fbhigh_cpu = (struct pxafb_dma_descriptor *)((unsigned int)fbi->palette_cpu - 2*16);
+	fbi->dmadesc_palette_cpu = (struct pxafb_dma_descriptor *)((unsigned int)fbi->palette_cpu - 1*16);
+
+	fbi->dmadesc_fblow_dma = fbi->palette_dma - 3*16;
+	fbi->dmadesc_fbhigh_dma = fbi->palette_dma - 2*16;
+	fbi->dmadesc_palette_dma = fbi->palette_dma - 1*16;
+
+	#define BYTES_PER_PANEL ((fbi->lccr0 & LCCR0_SDS) == LCCR0_Dual ? \
+                                (var->xres * var->yres * var->bits_per_pixel / 8 / 2) : \
+                                (var->xres * var->yres * var->bits_per_pixel / 8))
+
+	/* populate descriptors */
+	fbi->dmadesc_fblow_cpu->fdadr = fbi->dmadesc_fblow_dma;
+	fbi->dmadesc_fblow_cpu->fsadr = fbi->screen_dma + BYTES_PER_PANEL;
+	fbi->dmadesc_fblow_cpu->fidr  = 0;
+	fbi->dmadesc_fblow_cpu->ldcmd = BYTES_PER_PANEL;
+
+	fbi->fdadr1 = fbi->dmadesc_fblow_dma; /* only used in dual-panel mode */
+		
+	fbi->dmadesc_fbhigh_cpu->fsadr = fbi->screen_dma;
+	fbi->dmadesc_fbhigh_cpu->fidr = 0;
+	fbi->dmadesc_fbhigh_cpu->ldcmd = BYTES_PER_PANEL;
+
+	fbi->dmadesc_palette_cpu->fsadr = fbi->palette_dma;
+	fbi->dmadesc_palette_cpu->fidr  = 0;
+	fbi->dmadesc_palette_cpu->ldcmd = (fbi->palette_size * 2) | LDCMD_PAL;
+
+	if( var->bits_per_pixel < 12)
+	{
+		/* assume any mode with <12 bpp is palette driven */
+		fbi->dmadesc_palette_cpu->fdadr = fbi->dmadesc_fbhigh_dma;
+		fbi->dmadesc_fbhigh_cpu->fdadr = fbi->dmadesc_palette_dma;
+		fbi->fdadr0 = fbi->dmadesc_palette_dma; /* flips back and forth between pal and fbhigh */
+	}
+	else
+	{
+		/* palette shouldn't be loaded in true-color mode */
+		fbi->dmadesc_fbhigh_cpu->fdadr = fbi->dmadesc_fbhigh_dma;
+		fbi->fdadr0 = fbi->dmadesc_fbhigh_dma; /* no pal just fbhigh */
+		/* init it to something, even though we won't be using it */
+		fbi->dmadesc_palette_cpu->fdadr = fbi->dmadesc_palette_dma;
+	}
+
+#if 0
+	DPRINTK("fbi->dmadesc_fblow_cpu = 0x%p\n", fbi->dmadesc_fblow_cpu);
+	DPRINTK("fbi->dmadesc_fbhigh_cpu = 0x%p\n", fbi->dmadesc_fbhigh_cpu);
+	DPRINTK("fbi->dmadesc_palette_cpu = 0x%p\n", fbi->dmadesc_palette_cpu);
+	DPRINTK("fbi->dmadesc_fblow_dma = 0x%x\n", fbi->dmadesc_fblow_dma);
+	DPRINTK("fbi->dmadesc_fbhigh_dma = 0x%x\n", fbi->dmadesc_fbhigh_dma);
+	DPRINTK("fbi->dmadesc_palette_dma = 0x%x\n", fbi->dmadesc_palette_dma);
+
+	DPRINTK("fbi->dmadesc_fblow_cpu->fdadr = 0x%x\n", fbi->dmadesc_fblow_cpu->fdadr);
+	DPRINTK("fbi->dmadesc_fbhigh_cpu->fdadr = 0x%x\n", fbi->dmadesc_fbhigh_cpu->fdadr);
+	DPRINTK("fbi->dmadesc_palette_cpu->fdadr = 0x%x\n", fbi->dmadesc_palette_cpu->fdadr);
+
+	DPRINTK("fbi->dmadesc_fblow_cpu->fsadr = 0x%x\n", fbi->dmadesc_fblow_cpu->fsadr);
+	DPRINTK("fbi->dmadesc_fbhigh_cpu->fsadr = 0x%x\n", fbi->dmadesc_fbhigh_cpu->fsadr);
+	DPRINTK("fbi->dmadesc_palette_cpu->fsadr = 0x%x\n", fbi->dmadesc_palette_cpu->fsadr);
+
+	DPRINTK("fbi->dmadesc_fblow_cpu->ldcmd = 0x%x\n", fbi->dmadesc_fblow_cpu->ldcmd);
+	DPRINTK("fbi->dmadesc_fbhigh_cpu->ldcmd = 0x%x\n", fbi->dmadesc_fbhigh_cpu->ldcmd);
+	DPRINTK("fbi->dmadesc_palette_cpu->ldcmd = 0x%x\n", fbi->dmadesc_palette_cpu->ldcmd);
+#endif
+	
+	fbi->reg_lccr0 = new_regs.lccr0;
+	fbi->reg_lccr1 = new_regs.lccr1;
+	fbi->reg_lccr2 = new_regs.lccr2;
+	fbi->reg_lccr3 = new_regs.lccr3;
+	local_irq_restore(flags);
+
+	/*
+	 * Only update the registers if the controller is enabled
+	 * and something has changed.
+	 */
+	if ((LCCR0  != fbi->reg_lccr0) || (LCCR1  != fbi->reg_lccr1) ||
+	    (LCCR2  != fbi->reg_lccr2) || (LCCR3  != fbi->reg_lccr3) ||
+	    (FDADR0 != fbi->fdadr0)    || (FDADR1 != fbi->fdadr1))
+		pxafb_schedule_work(fbi, C_REENABLE);
+
+	return 0;
+}
+
+/*
+ * NOTE!  The following functions are purely helpers for set_ctrlr_state.
+ * Do not call them directly; set_ctrlr_state does the correct serialisation
+ * to ensure that things happen in the right way 100% of time time.
+ *	-- rmk
+ */
+static inline void __pxafb_backlight_power(struct pxafb_info *fbi, int on)
+{
+	DPRINTK("backlight o%s\n", on ? "n" : "ff");
+
+ 	if (pxafb_backlight_power)
+ 		pxafb_backlight_power(on);
+}
+
+static inline void __pxafb_lcd_power(struct pxafb_info *fbi, int on)
+{
+	DPRINTK("LCD power o%s\n", on ? "n" : "ff");
+
+	if (pxafb_lcd_power)
+		pxafb_lcd_power(on);
+}
+
+static void pxafb_setup_gpio(struct pxafb_info *fbi)
+{
+        unsigned int lccr0 = fbi->lccr0;
+        
+	/*
+	 * setup is based on type of panel supported
+        */
+
+	/* 4 bit interface */
+	if ((lccr0 & LCCR0_CMS) == LCCR0_Mono && 
+	    (lccr0 & LCCR0_SDS) == LCCR0_Sngl && 
+	    (lccr0 & LCCR0_DPD) == LCCR0_4PixMono)
+	{
+		// bits 58-61
+		GPDR1 |= (0xf << 26);
+		GAFR1_U = (GAFR1_U & ~(0xff << 20)) | (0xaa << 20);
+
+		// bits 74-77
+		GPDR2 |= (0xf << 10);
+		GAFR2_L = (GAFR2_L & ~(0xff << 20)) | (0xaa << 20);
+	}
+
+	/* 8 bit interface */
+        else if (((lccr0 & LCCR0_CMS) == LCCR0_Mono && 
+		  ((lccr0 & LCCR0_SDS) == LCCR0_Dual || (lccr0 & LCCR0_DPD) == LCCR0_8PixMono)) ||
+                 ((lccr0 & LCCR0_CMS) == LCCR0_Color && 
+		  (lccr0 & LCCR0_PAS) == LCCR0_Pas && (lccr0 & LCCR0_SDS) == LCCR0_Sngl))
+	{
+		// bits 58-65
+		GPDR1 |= (0x3f << 26);
+		GPDR2 |= (0x3);
+
+		GAFR1_U = (GAFR1_U & ~(0xfff << 20)) | (0xaaa << 20);
+		GAFR2_L = (GAFR2_L & ~0xf) | (0xa);
+
+		// bits 74-77
+		GPDR2 |= (0xf << 10);
+		GAFR2_L = (GAFR2_L & ~(0xff << 20)) | (0xaa << 20);
+	}
+
+	/* 16 bit interface */
+	else if ((lccr0 & LCCR0_CMS) == LCCR0_Color && 
+		 ((lccr0 & LCCR0_SDS) == LCCR0_Dual || (lccr0 & LCCR0_PAS) == LCCR0_Act))
+	{
+		// bits 58-77
+		GPDR1 |= (0x3f << 26);
+		GPDR2 |= 0x00003fff;
+
+		GAFR1_U = (GAFR1_U & ~(0xfff << 20)) | (0xaaa << 20);
+		GAFR2_L = (GAFR2_L & 0xf0000000) | 0x0aaaaaaa;
+	}
+	
+	else {
+	        printk( KERN_ERR "pxafb_setup_gpio: unable to determine bits per pixel\n");
+        }	                                                                                                                                  
+}
+
+static void pxafb_enable_controller(struct pxafb_info *fbi)
+{
+	DPRINTK("Enabling LCD controller\n");
+	DPRINTK("fdadr0 0x%08x\n", (unsigned int) fbi->fdadr0);
+	DPRINTK("fdadr1 0x%08x\n", (unsigned int) fbi->fdadr1);
+	DPRINTK("reg_lccr0 0x%08x\n", (unsigned int) fbi->reg_lccr0);
+	DPRINTK("reg_lccr1 0x%08x\n", (unsigned int) fbi->reg_lccr1);
+	DPRINTK("reg_lccr2 0x%08x\n", (unsigned int) fbi->reg_lccr2);
+	DPRINTK("reg_lccr3 0x%08x\n", (unsigned int) fbi->reg_lccr3);
+
+	/* Sequence from 11.7.10 */
+	LCCR3 = fbi->reg_lccr3;
+	LCCR2 = fbi->reg_lccr2;
+	LCCR1 = fbi->reg_lccr1;
+	LCCR0 = fbi->reg_lccr0 & ~LCCR0_ENB;
+
+	FDADR0 = fbi->fdadr0;
+	FDADR1 = fbi->fdadr1;
+	LCCR0 |= LCCR0_ENB;
+
+	DPRINTK("FDADR0 0x%08x\n", (unsigned int) FDADR0);
+	DPRINTK("FDADR1 0x%08x\n", (unsigned int) FDADR1);
+	DPRINTK("LCCR0 0x%08x\n", (unsigned int) LCCR0);
+	DPRINTK("LCCR1 0x%08x\n", (unsigned int) LCCR1);
+	DPRINTK("LCCR2 0x%08x\n", (unsigned int) LCCR2);
+	DPRINTK("LCCR3 0x%08x\n", (unsigned int) LCCR3);
+}
+
+static void pxafb_disable_controller(struct pxafb_info *fbi)
+{
+	DECLARE_WAITQUEUE(wait, current);
+
+	DPRINTK("Disabling LCD controller\n");
+
+	add_wait_queue(&fbi->ctrlr_wait, &wait);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+
+	LCSR = 0xffffffff;	/* Clear LCD Status Register */
+	LCCR0 &= ~LCCR0_LDM;	/* Enable LCD Disable Done Interrupt */
+	//TODO?enable_irq(IRQ_LCD);  /* Enable LCD IRQ */
+	LCCR0 &= ~LCCR0_ENB;	/* Disable LCD Controller */
+
+	schedule_timeout(20 * HZ / 1000);
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&fbi->ctrlr_wait, &wait);
+}
+
+/*
+ *  pxafb_handle_irq: Handle 'LCD DONE' interrupts.
+ */
+static irqreturn_t pxafb_handle_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct pxafb_info *fbi = dev_id;
+	unsigned int lcsr = LCSR;
+
+	if (lcsr & LCSR_LDD) {
+		LCCR0 |= LCCR0_LDM;
+		wake_up(&fbi->ctrlr_wait);
+	}
+
+	LCSR = lcsr;
+	return IRQ_HANDLED;
+}
+
+/*
+ * This function must be called from task context only, since it will
+ * sleep when disabling the LCD controller, or if we get two contending
+ * processes trying to alter state.
+ */
+static void set_ctrlr_state(struct pxafb_info *fbi, u_int state)
+{
+	u_int old_state;
+
+	down(&fbi->ctrlr_sem);
+
+	old_state = fbi->state;
+
+	/*
+	 * Hack around fbcon initialisation.
+	 */
+	if (old_state == C_STARTUP && state == C_REENABLE)
+		state = C_ENABLE;
+
+	switch (state) {
+	case C_DISABLE_CLKCHANGE:
+		/*
+		 * Disable controller for clock change.  If the
+		 * controller is already disabled, then do nothing.
+		 */
+		if (old_state != C_DISABLE && old_state != C_DISABLE_PM) {
+			fbi->state = state;
+			//TODO __pxafb_lcd_power(fbi, 0);
+			pxafb_disable_controller(fbi);
+		}
+		break;
+
+	case C_DISABLE_PM:
+	case C_DISABLE:
+		/*
+		 * Disable controller
+		 */
+		if (old_state != C_DISABLE) {
+			fbi->state = state;
+			__pxafb_backlight_power(fbi, 0);
+			__pxafb_lcd_power(fbi, 0);
+			if (old_state != C_DISABLE_CLKCHANGE)
+				pxafb_disable_controller(fbi);
+		}
+		break;
+
+	case C_ENABLE_CLKCHANGE:
+		/*
+		 * Enable the controller after clock change.  Only
+		 * do this if we were disabled for the clock change.
+		 */
+		if (old_state == C_DISABLE_CLKCHANGE) {
+			fbi->state = C_ENABLE;
+			pxafb_enable_controller(fbi);
+			//TODO __pxafb_lcd_power(fbi, 1);
+		}
+		break;
+
+	case C_REENABLE:
+		/*
+		 * Re-enable the controller only if it was already
+		 * enabled.  This is so we reprogram the control
+		 * registers.
+		 */
+		if (old_state == C_ENABLE) {
+			pxafb_disable_controller(fbi);
+			pxafb_setup_gpio(fbi);
+			pxafb_enable_controller(fbi);
+		}
+		break;
+
+	case C_ENABLE_PM:
+		/*
+		 * Re-enable the controller after PM.  This is not
+		 * perfect - think about the case where we were doing
+		 * a clock change, and we suspended half-way through.
+		 */
+		if (old_state != C_DISABLE_PM)
+			break;
+		/* fall through */
+
+	case C_ENABLE:
+		/*
+		 * Power up the LCD screen, enable controller, and
+		 * turn on the backlight.
+		 */
+		if (old_state != C_ENABLE) {
+			fbi->state = C_ENABLE;
+			pxafb_setup_gpio(fbi);
+			pxafb_enable_controller(fbi);
+			__pxafb_lcd_power(fbi, 1);
+			__pxafb_backlight_power(fbi, 1);
+		}
+		break;
+	}
+	up(&fbi->ctrlr_sem);
+}
+
+/*
+ * Our LCD controller task (which is called when we blank or unblank)
+ * via keventd.
+ */
+static void pxafb_task(void *dummy)
+{
+	struct pxafb_info *fbi = dummy;
+	u_int state = xchg(&fbi->task_state, -1);
+
+	set_ctrlr_state(fbi, state);
+}
+
+#ifdef CONFIG_CPU_FREQ
+/*
+ * CPU clock speed change handler.  We need to adjust the LCD timing
+ * parameters when the CPU clock is adjusted by the power management
+ * subsystem.
+ *
+ * TODO: Determine why f->new != 10*get_lclk_frequency_10khz()
+ */
+static int
+pxafb_freq_transition(struct notifier_block *nb, unsigned long val, void *data)
+{
+	struct pxafb_info *fbi = TO_INF(nb, freq_transition);
+	//TODO struct cpufreq_freqs *f = data;
+	u_int pcd;
+
+	switch (val) {
+	case CPUFREQ_PRECHANGE:
+		set_ctrlr_state(fbi, C_DISABLE_CLKCHANGE);
+		break;
+
+	case CPUFREQ_POSTCHANGE:
+		pcd = get_pcd(fbi->fb.var.pixclock);
+		fbi->reg_lccr3 = (fbi->reg_lccr3 & ~0xff) | LCCR3_PixClkDiv(pcd);
+		set_ctrlr_state(fbi, C_ENABLE_CLKCHANGE);
+		break;
+	}
+	return 0;
+}
+
+static int
+pxafb_freq_policy(struct notifier_block *nb, unsigned long val, void *data)
+{
+	struct pxafb_info *fbi = TO_INF(nb, freq_policy);
+	struct fb_var_screeninfo *var = &fbi->fb.var;
+	struct cpufreq_policy *policy = data;
+
+	switch (val) {
+	case CPUFREQ_ADJUST:
+	case CPUFREQ_INCOMPATIBLE:
+		printk(KERN_DEBUG "min dma period: %d ps, "
+			"new clock %d kHz\n", pxafb_display_dma_period(var),
+			policy->max);
+		// TODO: fill in min/max values
+		break;
+#if 0
+	case CPUFREQ_NOTIFY:
+		printk(KERN_ERR "%s: got CPUFREQ_NOTIFY\n", __FUNCTION__);
+		do {} while(0);
+		/* todo: panic if min/max values aren't fulfilled 
+		 * [can't really happen unless there's a bug in the
+		 * CPU policy verification process *
+		 */
+		break;
+#endif
+	}
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PM
+/*
+ * Power management hooks.  Note that we won't be called from IRQ context,
+ * unlike the blank functions above, so we may sleep.
+ */
+static int pxafb_suspend(struct device *dev, u32 state, u32 level)
+{
+	struct pxafb_info *fbi = dev_get_drvdata(dev);
+
+	if (level == SUSPEND_DISABLE || level == SUSPEND_POWER_DOWN)
+		set_ctrlr_state(fbi, C_DISABLE_PM);
+	return 0;
+}
+
+static int pxafb_resume(struct device *dev, u32 level)
+{
+	struct pxafb_info *fbi = dev_get_drvdata(dev);
+
+	if (level == RESUME_ENABLE)
+		set_ctrlr_state(fbi, C_ENABLE_PM);
+	return 0;
+}
+#else
+#define pxafb_suspend	NULL
+#define pxafb_resume	NULL
+#endif
+
+/*
+ * pxafb_map_video_memory():
+ *      Allocates the DRAM memory for the frame buffer.  This buffer is  
+ *	remapped into a non-cached, non-buffered, memory region to  
+ *      allow palette and pixel writes to occur without flushing the 
+ *      cache.  Once this area is remapped, all virtual memory
+ *      access to the video memory should occur at the new region.
+ */
+static int __init pxafb_map_video_memory(struct pxafb_info *fbi)
+{
+	u_long palette_mem_size;
+	
+	/*
+	 * We reserve one page for the palette, plus the size
+	 * of the framebuffer.
+	 */
+	fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len + PAGE_SIZE);
+	fbi->map_cpu = consistent_alloc(GFP_KERNEL, fbi->map_size,
+					&fbi->map_dma, PTE_BUFFERABLE);
+
+	if (fbi->map_cpu) {
+		/* prevent initial garbage on screen */
+		memset(fbi->map_cpu, 0, fbi->map_size);
+		fbi->fb.screen_base = fbi->map_cpu + PAGE_SIZE;
+		fbi->screen_dma = fbi->map_dma + PAGE_SIZE;
+		fbi->fb.fix.smem_start = fbi->screen_dma;
+		
+		fbi->palette_size = fbi->fb.var.bits_per_pixel == 8 ? 256 : 16;
+		
+		palette_mem_size = fbi->palette_size * sizeof(u16);
+		DPRINTK("palette_mem_size = 0x%08lx\n", (u_long) palette_mem_size);
+		
+		fbi->palette_cpu = (u16 *)(fbi->map_cpu + PAGE_SIZE - palette_mem_size);
+		fbi->palette_dma = fbi->map_dma + PAGE_SIZE - palette_mem_size;
+	}
+
+	return fbi->map_cpu ? 0 : -ENOMEM;
+}
+
+/* static video mode */
+static struct fb_videomode videomode;
+
+/* This should move to lcddb.c. */
+static int __init pxafb_get_panel_info(struct device *dev, char *options, struct fb_monspecs *monspec)
+{
+	/* fixme -> to .h */
+	extern int fb_lcd_lookup(const char *name, struct fb_monspecs *monspec);
+
+        char *this_opt;
+	int err;
+
+	/* perhaps kmalloc */
+	monspec->modedb = &videomode;
+	monspec->modedb_len = 1;
+
+	/* FIXME: default from CONFIG_PXAFB_DEFAULT_PANEL or from platform data */
+	err = fb_lcd_lookup("NL3224BC35", monspec);
+
+        if (!options || !*options)
+                return err;
+
+	dev_dbg(dev, "options are \"%s\"\n", options ? options : "null");
+
+        while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!strncmp(this_opt, "panel:", 6) ) {
+			err = fb_lcd_lookup(this_opt+6, monspec);
+			printk("fb_lcd_lookup B returned %d\n", err);
+			if ( err < 0 ) {
+				dev_err(dev, "unknown panel type \"%s\". %d\n", this_opt+6, err);
+				return err;
+			}
+		} else if (!strncmp(this_opt, "mode:", 5)) {
+			printk("TODO: Parse mode(\"%s\"\n", this_opt+5);
+                } else if (!strncmp(this_opt, "pixclock:", 9)) {
+                        monspec->modedb[0].pixclock = simple_strtoul(this_opt+9, NULL, 0);
+			dev_info(dev, "override pixclock: %uld\n", monspec->modedb[0].pixclock);
+                } else if (!strncmp(this_opt, "left:", 5)) {
+                        monspec->modedb[0].left_margin = simple_strtoul(this_opt+5, NULL, 0);
+			dev_info(dev, "override left: %d\n", monspec->modedb[0].left_margin);
+                } else if (!strncmp(this_opt, "right:", 6)) {
+                        monspec->modedb[0].right_margin = simple_strtoul(this_opt+6, NULL, 0);
+			dev_info(dev, "override right: %d\n", monspec->modedb[0].right_margin);
+                } else if (!strncmp(this_opt, "upper:", 6)) {
+                        monspec->modedb[0].upper_margin = simple_strtoul(this_opt+6, NULL, 0);
+			dev_info(dev, "override upper: %d\n", monspec->modedb[0].upper_margin);
+                } else if (!strncmp(this_opt, "lower:", 6)) {
+                        monspec->modedb[0].lower_margin = simple_strtoul(this_opt+6, NULL, 0);
+			dev_info(dev, "override lower: %d\n", monspec->modedb[0].lower_margin);
+                } else if (!strncmp(this_opt, "hsynclen:", 9)) {
+                        monspec->modedb[0].hsync_len = simple_strtoul(this_opt+9, NULL, 0);
+			dev_info(dev, "override hsynclen: %d\n", monspec->modedb[0].hsync_len);
+                } else if (!strncmp(this_opt, "vsynclen:", 9)) {
+                        monspec->modedb[0].vsync_len = simple_strtoul(this_opt+9, NULL, 0);
+			dev_info(dev, "override vsynclen: %d\n", monspec->modedb[0].vsync_len);
+                } else if (!strncmp(this_opt, "hsync:", 6)) {
+                        if ( simple_strtoul(this_opt+6, NULL, 0) == 0 ) {
+				dev_info(dev, "override hsync: Active Low\n");
+				monspec->modedb[0].sync &= ~FB_SYNC_HOR_HIGH_ACT;
+			} else {
+				dev_info(dev, "override hsync: Active High\n");
+				monspec->modedb[0].sync |= FB_SYNC_HOR_HIGH_ACT;
+			}
+                } else if (!strncmp(this_opt, "vsync:", 6)) {
+                        if ( simple_strtoul(this_opt+6, NULL, 0) == 0 ) {
+				dev_info(dev, "override vsync: Active Low\n");
+				monspec->modedb[0].sync &= ~FB_SYNC_VERT_HIGH_ACT;
+			} else {
+				dev_info(dev, "override vsync: Active High\n");
+				monspec->modedb[0].sync |= FB_SYNC_VERT_HIGH_ACT;
+			}
+#if 0 /* TODO */
+                } else if (!strncmp(this_opt, "dpc:", 4)) {
+                        if ( simple_strtoul(this_opt+4, NULL, 0) == 0 ) {
+				dev_info(dev, "override double pixel clock: false\n");
+				inf->lccr3 &= ~LCCR3_DPC;
+			} else {
+				dev_info(dev, "override double pixel clock: true\n");
+				inf->lccr3 |= LCCR3_DPC;
+			}
+#endif
+                } else if (!strncmp(this_opt, "outputen:", 9)) {
+			monspec->physical_interface &= ~FB_LCD_PHYS_OUTEN;
+                        if ( simple_strtoul(this_opt+9, NULL, 0) == 0 ) {
+				dev_info(dev, "override output enable: active low\n");
+				monspec->physical_interface |= FB_LCD_PHYS_OUTEN_LOW;
+			} else {
+				dev_info(dev, "override output enable: active high\n");
+				monspec->physical_interface |= FB_LCD_PHYS_OUTEN_HIGH;
+			}
+                } else if (!strncmp(this_opt, "pixclockpol:", 12)) {
+			monspec->physical_interface &= ~FB_LCD_PHYS_PIXPOL;
+                        if ( simple_strtoul(this_opt+12, NULL, 0) == 0 ) {
+				dev_info(dev, "override pixel clock polarity: falling edge\n");
+				monspec->physical_interface |= FB_LCD_PHYS_PIXPOL_FALLING;
+			} else {
+				dev_info(dev, "override pixel clock polarity: rising edge\n");
+				monspec->physical_interface |= FB_LCD_PHYS_PIXPOL_RISING;
+			}
+                } else if (!strncmp(this_opt, "color", 5)) {
+			monspec->input = FB_DISP_RGB;
+                } else if (!strncmp(this_opt, "mono", 4)) {
+			monspec->input = FB_DISP_MONO;
+                } else if (!strncmp(this_opt, "active", 6)) {
+			monspec->physical_interface &= ~FB_LCD_PHYS_KIND;
+			monspec->physical_interface |= FB_LCD_PHYS_KIND_TFT;
+                } else if (!strncmp(this_opt, "passive", 7)) {
+			monspec->physical_interface &= ~FB_LCD_PHYS_KIND;
+			monspec->physical_interface |= FB_LCD_PHYS_KIND_STN;
+#if 0 /* TODO */
+                } else if (!strncmp(this_opt, "single", 6)) {
+			inf->lccr0 = (inf->lccr0 & ~LCCR0_SDS) | LCCR0_Sngl;
+                } else if (!strncmp(this_opt, "dual", 4)) {
+			inf->lccr0 = (inf->lccr0 & ~LCCR0_SDS) | LCCR0_Dual;
+                } else if (!strncmp(this_opt, "4pix", 4)) {
+			inf->lccr0 = (inf->lccr0 & ~LCCR0_DPD) | LCCR0_4PixMono;
+                } else if (!strncmp(this_opt, "8pix", 4)) {
+			inf->lccr0 = (inf->lccr0 & ~LCCR0_DPD) | LCCR0_8PixMono;
+#endif
+		} else {
+			dev_err(dev, "unknown option: %s\n", this_opt);
+			return -EINVAL;
+		}
+        }
+        return 0;
+}
+
+static void pxafb_apply_monspec(struct pxafb_info *fbi)
+{
+	const struct fb_monspecs *monspecs = &fbi->fb.monspecs;
+
+	fbi->lccr0 = 0;
+	switch ( monspecs->physical_interface & FB_LCD_PHYS_KIND ) {
+	case FB_LCD_PHYS_KIND_TFT: fbi->lccr0 |= LCCR0_Act; break;
+	case FB_LCD_PHYS_KIND_STN: fbi->lccr0 |= LCCR0_Pas; break;
+	}
+	switch ( monspecs->input ) {
+	case FB_DISP_MONO: fbi->lccr0 |= LCCR0_Mono; break;
+	case FB_DISP_RGB: fbi->lccr0 |= LCCR0_Color; break;
+	}
+	/* TODO: Single vs Dual, 4pix vs 8pix mono */
+
+	fbi->lccr3 = 0;
+	switch ( monspecs->physical_interface & FB_LCD_PHYS_OUTEN ) {
+	case FB_LCD_PHYS_OUTEN_HIGH: fbi->lccr3 |= LCCR3_OutEnH; break;
+	case FB_LCD_PHYS_OUTEN_LOW: fbi->lccr3 |= LCCR3_OutEnL; break;
+	}
+	switch ( monspecs->physical_interface & FB_LCD_PHYS_PIXPOL ) {
+	case FB_LCD_PHYS_PIXPOL_RISING: fbi->lccr3 |= LCCR3_PixRsEdg; break;
+	case FB_LCD_PHYS_PIXPOL_FALLING: fbi->lccr3 |= LCCR3_PixFlEdg; break;
+	}
+	/* TODO: ACbias and DPC */
+	fbi->lccr3 |= LCCR3_Acb(0xFF);
+}
+
+static struct pxafb_info * __init pxafb_init_fbinfo(struct device *dev)
+{
+	struct pxafb_info *fbi;
+	struct fb_videomode *mode;
+	void *addr;
+	int err;
+
+	/* Alloc the pxafb_info and pseudo_palette in one step */
+	fbi = kmalloc(sizeof(struct pxafb_info) + sizeof(u32) * 17, GFP_KERNEL);
+	if (!fbi)
+		return NULL;
+
+	memset(fbi, 0, sizeof(struct pxafb_info));
+
+	strcpy(fbi->fb.fix.id, PXA_NAME);
+
+	fbi->fb.fix.type	= FB_TYPE_PACKED_PIXELS;
+	fbi->fb.fix.type_aux	= 0;
+	fbi->fb.fix.xpanstep	= 0;
+	fbi->fb.fix.ypanstep	= 0;
+	fbi->fb.fix.ywrapstep	= 0;
+	fbi->fb.fix.accel	= FB_ACCEL_NONE;
+
+	fbi->fb.var.nonstd	= 0;
+	fbi->fb.var.activate	= FB_ACTIVATE_NOW;
+	fbi->fb.var.height	= -1;
+	fbi->fb.var.width	= -1;
+	fbi->fb.var.accel_flags	= 0;
+	fbi->fb.var.vmode	= FB_VMODE_NONINTERLACED;
+
+	fbi->fb.fbops		= &pxafb_ops;
+	fbi->fb.flags		= FBINFO_FLAG_DEFAULT;
+	fbi->fb.node		= -1;
+	
+	err = pxafb_get_panel_info(dev, g_options, &fbi->fb.monspecs);
+	printk("pxafb_get_panel_info returned %d\n", err);
+	if ( err < 0 ) {
+		printk("pxafb_get_panel_info failed. abort\n");
+		kfree(fbi);
+		return NULL;
+	}
+	mode = &fbi->fb.monspecs.modedb[0];
+
+	fbi->fb.currcon		= -1;
+
+	addr = fbi;
+	addr = addr + sizeof(struct pxafb_info);
+	fbi->fb.pseudo_palette	= addr;
+
+	fbi->max_xres			= mode->xres;
+	fbi->fb.var.xres		= mode->xres;
+	fbi->fb.var.xres_virtual	= mode->xres;
+	fbi->max_yres			= mode->yres;
+	fbi->fb.var.yres		= mode->yres;
+	fbi->fb.var.yres_virtual	= mode->yres;
+	fbi->max_bpp			= 16; //FIXME: inf->bpp;
+	fbi->fb.var.bits_per_pixel	= 16; //FIXME: inf->bpp;
+	fbi->fb.var.pixclock		= mode->pixclock;
+	fbi->fb.var.hsync_len		= mode->hsync_len;
+	fbi->fb.var.left_margin		= mode->left_margin;
+	fbi->fb.var.right_margin	= mode->right_margin;
+	fbi->fb.var.vsync_len		= mode->vsync_len;
+	fbi->fb.var.upper_margin	= mode->upper_margin;
+	fbi->fb.var.lower_margin	= mode->lower_margin;
+	fbi->fb.var.sync		= mode->sync;
+#if 0 // FIXME
+	fbi->fb.var.grayscale		= inf->cmap_greyscale;
+	fbi->cmap_inverse		= inf->cmap_inverse;
+	fbi->cmap_static		= inf->cmap_static;
+#endif
+
+	pxafb_apply_monspec(fbi);
+
+	fbi->state			= C_STARTUP;
+	fbi->task_state			= (u_char)-1;
+	fbi->fb.fix.smem_len		= fbi->max_xres * fbi->max_yres *
+					  fbi->max_bpp / 8;
+
+	init_waitqueue_head(&fbi->ctrlr_wait);
+	INIT_WORK(&fbi->task, pxafb_task, fbi);
+	init_MUTEX(&fbi->ctrlr_sem);
+
+	return fbi;
+}
+
+int __init pxafb_probe(struct device *dev)
+{
+	struct pxafb_info *fbi;
+	struct pxafb_mach_info *inf;
+	int ret;
+
+	dev_dbg(dev, "pxafb_probe\n");
+
+	inf = dev->platform_data;
+	ret = -ENOMEM;
+	fbi = NULL;
+	if (!inf)
+		goto failed;
+
+#if 0 
+	ret = pxafb_parse_options(dev, inf, g_options);
+	if ( ret < 0 )
+		goto failed;
+
+#ifdef DEBUG_VAR
+        /* Check for various illegal bit-combinations. Currently only
+	 * a warning is given. */
+ 
+        if ( inf->lccr0 & LCCR0_INVALID_CONFIG_MASK )
+                dev_warn(dev, "machine LCCR0 setting contains illegal bits: %08x\n",
+                        inf->lccr0 & LCCR0_INVALID_CONFIG_MASK);
+        if ( inf->lccr3 & LCCR3_INVALID_CONFIG_MASK )
+                dev_warn(dev, "machine LCCR3 setting contains illegal bits: %08x\n",
+                        inf->lccr3 & LCCR3_INVALID_CONFIG_MASK);
+
+/* FIXME: Most of this stuff could be converted to check the validity
+ * of the fb_monspecs stuff */
+        if ( inf->lccr0 & LCCR0_DPD &&
+             ( ( inf->lccr0 & LCCR0_PAS ) != LCCR0_Pas ||
+               ( inf->lccr0 & LCCR0_SDS ) != LCCR0_Sngl ||
+               ( inf->lccr0 & LCCR0_CMS ) != LCCR0_Mono ) )
+                dev_warn(dev, "Double Pixel Data (DPD) mode is only valid in passive mono"
+			 " single panel mode\n");
+        if ( (inf->lccr0 & LCCR0_PAS) == LCCR0_Act &&
+             ( inf->lccr0 & LCCR0_SDS ) == LCCR0_Dual )
+                dev_warn(dev, "Dual panel only valid in passive mode\n");
+        if ( (inf->lccr0 & LCCR0_PAS ) == LCCR0_Pas &&
+             (inf->upper_margin || inf->lower_margin) )
+                dev_warn(dev, "Upper and lower margins must be 0 in passive mode\n");
+#endif
+
+	dev_dbg(dev, "got a %dx%dx%d LCD\n",inf->xres, inf->yres, inf->bpp);
+	if (inf->xres == 0 || inf->yres == 0 || inf->bpp == 0) {
+		dev_err(dev, "Invalid resolution or bit depth\n");
+		ret = -EINVAL;
+		goto failed;
+	}
+#endif
+
+	pxafb_backlight_power = inf->pxafb_backlight_power;
+	pxafb_lcd_power = inf->pxafb_lcd_power;
+	fbi = pxafb_init_fbinfo(dev);
+	if (!fbi) {
+		dev_err(dev, "Failed to initialize framebuffer device\n");
+		ret = -ENOMEM; // only reason for pxafb_init_fbinfo to fail is kmalloc
+		goto failed;
+	}
+
+	/* Initialize video memory */
+	ret = pxafb_map_video_memory(fbi);
+	if (ret) {
+		dev_err(dev, "Failed to allocate video RAM: %d\n", ret);
+		ret = -ENOMEM;
+		goto failed;
+	}
+	/* enable LCD controller clock */
+	CKEN |= CKEN16_LCD;
+
+	ret = request_irq(IRQ_LCD, pxafb_handle_irq, SA_INTERRUPT, "LCD", fbi);
+	if (ret) {
+		dev_err(dev, "request_irq failed: %d\n", ret);
+		ret = -EBUSY;
+		goto failed;
+	}
+
+	/*
+	 * This makes sure that our colour bitfield
+	 * descriptors are correctly initialised.
+	 */
+	pxafb_check_var(&fbi->fb.var, &fbi->fb);
+	pxafb_set_par(&fbi->fb);
+
+	dev_set_drvdata(dev, fbi);
+
+	ret = register_framebuffer(&fbi->fb);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register framebuffer device: %d\n", ret);
+		goto failed;
+	}
+
+#ifdef CONFIG_PM
+	// TODO
+#endif
+
+#ifdef CONFIG_CPU_FREQ
+	fbi->freq_transition.notifier_call = pxafb_freq_transition;
+	fbi->freq_policy.notifier_call = pxafb_freq_policy;
+	cpufreq_register_notifier(&fbi->freq_transition, CPUFREQ_TRANSITION_NOTIFIER);
+	cpufreq_register_notifier(&fbi->freq_policy, CPUFREQ_POLICY_NOTIFIER);
+#endif
+
+	/*
+	 * Ok, now enable the LCD controller
+	 */
+	set_ctrlr_state(fbi, C_ENABLE);
+
+	return 0;
+
+failed:
+	dev_set_drvdata(dev, NULL);
+	if (fbi)
+		kfree(fbi);
+	return ret;
+}
+
+static struct device_driver pxafb_driver = {
+	.name		= "pxafb",
+	.bus		= &platform_bus_type,
+	.probe		= pxafb_probe,
+#ifdef CONFIG_PM
+	.suspend	= pxafb_suspend,
+	.resume		= pxafb_resume,
+#endif
+};
+
+int __devinit pxafb_init(void)
+{
+	return driver_register(&pxafb_driver);
+}
+
+#ifndef MODULE
+int __devinit pxafb_setup(char *options)
+{
+	long opsi = strlen(options);
+	
+	memcpy(g_options, options,
+	       ((opsi + 1) >
+		PXAFB_OPTIONS_SIZE) ? PXAFB_OPTIONS_SIZE : (opsi + 1));
+	g_options[PXAFB_OPTIONS_SIZE - 1] = 0;
+	
+	return 0;
+}
+#else
+module_init(pxafb_init);
+module_param_string(options, g_options, sizeof(g_options), 0);
+MODULE_PARM_DESC(options, "LCD parameters (see Documentation/fb/pxafb.txt)");
+#endif
+
+
+MODULE_DESCRIPTION("loadable framebuffer driver for PXA");
+MODULE_LICENSE("GPL");
Index: linux-2.6-bkpxa/drivers/video/pxafb.h
===================================================================
--- linux-2.6-bkpxa.orig/drivers/video/pxafb.h	2004-03-24 10:32:56.000000000 +0000
+++ linux-2.6-bkpxa/drivers/video/pxafb.h	2004-03-25 15:34:20.000000000 +0000
@@ -0,0 +1,125 @@
+/*
+ * linux/drivers/video/pxafb.h
+ *    -- Intel PXA250/210 LCD Controller Frame Buffer Device
+ *
+ *  Copyright (C) 1999 Eric A. Thomas
+ *   Based on acornfb.c Copyright (C) Russell King.
+ *
+ *  2001-08-03: Cliff Brake <cbrake@acclent.com>
+ *	 - ported SA1100 code to PXA
+ *  
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+/* Shadows for LCD controller registers */
+struct pxafb_lcd_reg {
+	unsigned int lccr0;
+	unsigned int lccr1;
+	unsigned int lccr2;
+	unsigned int lccr3;
+};
+
+/* PXA LCD DMA descriptor */
+struct pxafb_dma_descriptor {
+	unsigned int fdadr;
+	unsigned int fsadr;
+	unsigned int fidr;
+	unsigned int ldcmd;
+};
+
+struct pxafb_info {
+	struct fb_info		fb;
+
+	u_int			max_bpp;
+	u_int			max_xres;
+	u_int			max_yres;
+
+	/*
+	 * These are the addresses we mapped
+	 * the framebuffer memory region to.
+	 */
+	/* raw memory addresses */
+	dma_addr_t		map_dma;	/* physical */
+	u_char *		map_cpu;	/* virtual */
+	u_int			map_size;
+
+	/* addresses of pieces placed in raw buffer */
+	u_char *		screen_cpu;	/* virtual address of frame buffer */
+	dma_addr_t		screen_dma;	/* physical address of frame buffer */
+	u16 *			palette_cpu;	/* virtual address of palette memory */
+	dma_addr_t		palette_dma;	/* physical address of palette memory */
+	u_int			palette_size;
+
+	/* DMA descriptors */
+	struct pxafb_dma_descriptor * 	dmadesc_fblow_cpu;
+	dma_addr_t		dmadesc_fblow_dma;
+	struct pxafb_dma_descriptor * 	dmadesc_fbhigh_cpu;
+	dma_addr_t		dmadesc_fbhigh_dma;
+	struct pxafb_dma_descriptor *	dmadesc_palette_cpu;
+	dma_addr_t		dmadesc_palette_dma;
+
+	dma_addr_t		fdadr0;
+	dma_addr_t		fdadr1;
+
+	u_int			lccr0;
+	u_int			lccr3;
+	u_int			cmap_inverse:1,
+				cmap_static:1,
+				unused:30;
+
+	u_int			reg_lccr0;
+	u_int			reg_lccr1;
+	u_int			reg_lccr2;
+	u_int			reg_lccr3;
+
+	volatile u_char		state;
+	volatile u_char		task_state;
+	struct semaphore	ctrlr_sem;
+	wait_queue_head_t	ctrlr_wait;
+	struct work_struct	task;
+
+#ifdef CONFIG_PM
+	struct pm_dev		*pm;
+#endif
+#ifdef CONFIG_CPU_FREQ
+	struct notifier_block	freq_transition;
+	struct notifier_block	freq_policy;
+#endif
+};
+
+#define __type_entry(ptr,type,member) ((type *)((char *)(ptr)-offsetof(type,member)))
+
+#define TO_INF(ptr,member)	__type_entry(ptr,struct pxafb_info,member)
+
+/*
+ * These are the actions for set_ctrlr_state
+ */
+#define C_DISABLE		(0)
+#define C_ENABLE		(1)
+#define C_DISABLE_CLKCHANGE	(2)
+#define C_ENABLE_CLKCHANGE	(3)
+#define C_REENABLE		(4)
+#define C_DISABLE_PM		(5)
+#define C_ENABLE_PM		(6)
+#define C_STARTUP		(7)
+
+#define PXA_NAME	"PXA"
+
+/*
+ *  Debug macros 
+ */
+#if DEBUG
+#  define DPRINTK(fmt, args...)	printk("%s: " fmt, __FUNCTION__ , ## args)
+#else
+#  define DPRINTK(fmt, args...)
+#endif
+
+/*
+ * Minimum X and Y resolutions
+ */
+#define MIN_XRES	64
+#define MIN_YRES	64
+
+#endif
Index: linux-2.6-bkpxa/include/asm-arm/arch-pxa/pxafb.h
===================================================================
--- linux-2.6-bkpxa.orig/include/asm-arm/arch-pxa/pxafb.h	2004-03-24 10:32:56.000000000 +0000
+++ linux-2.6-bkpxa/include/asm-arm/arch-pxa/pxafb.h	2004-03-25 11:27:14.000000000 +0000
@@ -0,0 +1,69 @@
+/*
+ *  linux/include/asm-arm/arch-pxa/pxafb.h
+ *
+ *  Support for the xscale frame buffer.
+ *
+ *  Author:     Jean-Frederic Clere
+ *  Created:    Sep 22, 2003
+ *  Copyright:  jfclere@sinix.net
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+/*
+ * This structure describes the machine which we are running on.
+ * It is set in linux/arch/arm/mach-pxa/machine_name.c and used in the probe routine
+ * of linux/drivers/video/pxafb.c
+ */
+struct pxafb_mach_info {
+#if 0 /* FIXME: Remove once fb_monspecs conversion complete */
+	u_long		pixclock;
+
+	u_short		xres;
+	u_short		yres;
+
+	u_char		bpp;
+	u_char		hsync_len;
+	u_char		left_margin;
+	u_char		right_margin;
+
+	u_char		vsync_len;
+	u_char		upper_margin;
+	u_char		lower_margin;
+	u_char		sync;
+
+	u_int		cmap_greyscale:1,
+			cmap_inverse:1,
+			cmap_static:1,
+			unused:29;
+
+	/* The following should be defined in LCCR0
+	 *      LCCR0_Act or LCCR0_Pas          Active or Passive
+	 *      LCCR0_Sngl or LCCR0_Dual        Single/Dual panel
+	 *      LCCR0_Mono or LCCR0_Color       Mono/Color
+	 *      LCCR0_4PixMono or LCCR0_8PixMono (in mono single mode)
+	 *      LCCR0_DMADel(Tcpu) (optional)   DMA request delay
+	 *
+	 * The following should not be defined in LCCR0:
+	 *      LCCR0_OUM, LCCR0_BM, LCCR0_QDM, LCCR0_DIS, LCCR0_EFM
+	 *      LCCR0_IUM, LCCR0_SFM, LCCR0_LDM, LCCR0_ENB
+	 */
+	u_int		lccr0;
+	/* The following should be defined in LCCR3
+	 *      LCCR3_OutEnH or LCCR3_OutEnL    Output enable polarity
+	 *      LCCR3_PixRsEdg or LCCR3_PixFlEdg Pixel clock edge type
+	 *      LCCR3_Acb(X)                    AB Bias pin frequency
+	 *      LCCR3_DPC (optional)            Double Pixel Clock mode (untested)
+	 *
+	 * The following should not be defined in LCCR3
+	 *      LCCR3_HSP, LCCR3_VSP, LCCR0_Pcd(x), LCCR3_Bpp
+	 */
+	u_int		lccr3;
+#endif
+	void (*pxafb_backlight_power)(int);
+	void (*pxafb_lcd_power)(int);
+
+};
+void set_pxa_fb_info(struct pxafb_mach_info *hard_pxa_fb_info);
Index: linux-2.6-bkpxa/include/linux/fb.h
===================================================================
--- linux-2.6-bkpxa.orig/include/linux/fb.h	2004-03-15 11:09:41.000000000 +0000
+++ linux-2.6-bkpxa/include/linux/fb.h	2004-03-25 15:49:23.000000000 +0000
@@ -273,6 +273,21 @@
 	__u32 whitey;
 };
 
+/* bit field for fb_monspecs->physical_interface */
+#define FB_LCD_PHYS_KIND	(1<<0) /* Type of panel: more than 1 bit?? */
+#define FB_LCD_PHYS_KIND_STN	(FB_LCD_PHYS_KIND*0)
+#define FB_LCD_PHYS_KIND_TFT	(FB_LCD_PHYS_KIND*1)
+
+#define FB_LCD_PHYS_OUTEN	(1<<1) /* Output enable polarity */
+#define FB_LCD_PHYS_OUTEN_LOW	(FB_LCD_PHYS_OUTEN*0)
+#define FB_LCD_PHYS_OUTEN_HIGH	(FB_LCD_PHYS_OUTEN*1)
+
+#define FB_LCD_PHYS_PIXPOL	(1<<2) /* Pixel clock polarity */
+#define FB_LCD_PHYS_PIXPOL_FALLING (FB_LCD_PHYS_PIXPOL*0)
+#define FB_LCD_PHYS_PIXPOL_RISING  (FB_LCD_PHYS_PIXPOL*1)
+
+/* TODO. For STN: Dual/Single, 4 or 8 bit mono, ACbias. */
+
 struct fb_monspecs {
 	struct fb_chroma chroma;
 	struct fb_videomode *modedb;	/* mode database */
@@ -301,6 +316,15 @@
 	__u8  revision;			/* ...and revision */
 	__u8  max_x;			/* Maximum horizontal size (cm) */
 	__u8  max_y;			/* Maximum vertical size (cm) */
+	__u32 physical_interface;	/* Physical interface properties */    
+	/* other things from the old pxafb_mach_info structure which I
+	 * can't figure out how to place here:
+	 *  - bpp/depth
+	 *  - cmap_greyscale
+	 *  - cmap_inverse
+	 *  - cmap_static
+	 */
+
 };
 
 #define FB_VBLANK_VBLANKING	0x001	/* currently in a vertical blank */

--=-oiWvGqK5ecqsOeXUcrPy--

