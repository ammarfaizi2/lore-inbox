Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293644AbSB1SGp>; Thu, 28 Feb 2002 13:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293643AbSB1SEA>; Thu, 28 Feb 2002 13:04:00 -0500
Received: from www.transvirtual.com ([206.14.214.140]:20744 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S293691AbSB1SBm>; Thu, 28 Feb 2002 13:01:42 -0500
Date: Thu, 28 Feb 2002 10:01:33 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: davej@suse.de
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] hpfb.c ported to fbdev api
Message-ID: <Pine.LNX.4.10.10202281000140.9321-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

  Since I don't have this hardware could someone test this driver. It is
against 2.5.5-dj2

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

--- linux-2.5.5-dj2/drivers/video/hpfb.c	Tue Feb 26 16:04:26 2002
+++ linux/drivers/video/hpfb.c	Thu Feb 28 10:55:18 2002
@@ -1,9 +1,6 @@
 /*
  *	HP300 Topcat framebuffer support (derived from macfb of all things)
  *	Phil Blundell <philb@gnu.org> 1998
- * 
- * Should this be moved to drivers/dio/video/ ? -- Peter Maydell
- * No! -- Jes
  */
 
 #include <linux/module.h>
@@ -22,16 +19,8 @@
 #include <asm/blinken.h>
 #include <asm/hwtest.h>
 
-#include <video/fbcon.h>
-#include <video/fbcon-mfb.h>
-#include <video/fbcon-cfb2.h>
-#include <video/fbcon-cfb4.h>
-#include <video/fbcon-cfb8.h>
-
-static struct display disp;
 static struct fb_info fb_info;
 
-unsigned long fb_start, fb_size = 1024*768, fb_line_length = 1024;
 unsigned long fb_regs;
 unsigned char fb_bitmask;
 
@@ -51,99 +40,41 @@
 #define WWIDTH		0x4102
 #define WMOVE		0x409c
 
+static struct fb_fix_screeninfo hpfb_fix __initdata = {
+    "HP300 Topcat", (unsigned long) NULL, 1024*768, FB_TYPE_PACKED_PIXELS, 0,
+    FB_VISUAL_PSEUDOCOLOR, 0, 0, 0, 1024, (unsigned long) NULL, 0, FB_ACCEL_NONE};
+
 static struct fb_var_screeninfo hpfb_defined = {
-	0,0,0,0,	/* W,H, W, H (virtual) load xres,xres_virtual*/
-	0,0,		/* virtual -> visible no offset */
-	0,		/* depth -> load bits_per_pixel */
-	0,		/* greyscale ? */
-	{0,2,0},	/* R */
-	{0,2,0},	/* G */
-	{0,2,0},	/* B */
-	{0,0,0},	/* transparency */
-	0,		/* standard pixel format */
+	1024,768,1024,768, 	/* W,H, W, H (virtual) load xres,xres_virtual*/
+	0,0,			/* virtual -> visible no offset */
+	1,			/* depth -> load bits_per_pixel */
+	0,			/* greyscale ? */
+	{0,2,0},		/* R */
+	{0,2,0},		/* G */
+	{0,2,0},		/* B */
+	{0,0,0},		/* transparency */
+	0,			/* standard pixel format */
 	FB_ACTIVATE_NOW,
-	274,195,	/* 14" monitor */
+	274,195,		/* 14" monitor */
 	FB_ACCEL_NONE,
 	0L,0L,0L,0L,0L,
-	0L,0L,0,	/* No sync info */
+	0L,0L,0,		/* No sync info */
 	FB_VMODE_NONINTERLACED,
 	{0,0,0,0,0,0}
 };
 
-struct hpfb_par
-{
-};
-
-struct hpfb_par current_par;
-
-static void hpfb_encode_var(struct fb_var_screeninfo *var, 
-				struct hpfb_par *par)
-{
-	int i=0;
-	var->xres=1024;
-	var->yres=768;
-	var->xres_virtual=1024;
-	var->yres_virtual=768;
-	var->xoffset=0;
-	var->yoffset=0;
-	var->bits_per_pixel = 1;
-	var->grayscale=0;
-	var->transp.offset=0;
-	var->transp.length=0;
-	var->transp.msb_right=0;
-	var->nonstd=0;
-	var->activate=0;
-	var->height= -1;
-	var->width= -1;
-	var->vmode=FB_VMODE_NONINTERLACED;
-	var->pixclock=0;
-	var->sync=0;
-	var->left_margin=0;
-	var->right_margin=0;
-	var->upper_margin=0;
-	var->lower_margin=0;
-	var->hsync_len=0;
-	var->vsync_len=0;
-	for(i=0;i<ARRAY_SIZE(var->reserved);i++)
-		var->reserved[i]=0;
-}
-
-static void hpfb_get_par(struct hpfb_par *par)
-{
-	*par=current_par;
-}
-
-static int fb_update_var(int con, struct fb_info *info)
-{
-	return 0;
-}
-
-static int do_fb_set_var(struct fb_var_screeninfo *var, int isactive)
-{
-	struct hpfb_par par;
-	
-	hpfb_get_par(&par);
-	hpfb_encode_var(var, &par);
-	return 0;
-}
-
-static int hpfb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-			  struct fb_info *info)
-{
-	return 0;
-}
+static struct display display;
 
 /*
- * Set a palette register. This may not work on all boards but only 
- * experimentation will tell.
+ * Set the palette.  This may not work on all boards but only experimentation 
+ * will tell.
  * XXX Doesn't work at all.
  */
-
-static int hpfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
-                          u_int transp, struct fb_info *info)
+static int hpfb_setcolreg(unsigned regno, unsigned red, unsigned green,
+                           unsigned blue, unsigned transp,
+                           struct fb_info *info)
 {
 	while (readw(fb_regs + 0x6002) & 0x4) udelay(1);
-	
 	writew(0, fb_regs + 0x60f0);
 	writew(regno, fb_regs + 0x60b8);
 	writew(red, fb_regs + 0x60b2);
@@ -155,111 +86,28 @@
 	return 0;
 }
 
-static int hpfb_get_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info)
-{
-	struct hpfb_par par;
-	if(con==-1)
-	{
-		hpfb_get_par(&par);
-		hpfb_encode_var(var, &par);
-	}
-	else
-		*var=fb_display[con].var;
-	return 0;
-}
-
-static int hpfb_set_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info)
-{
-	int err;
-	
-	if ((err=do_fb_set_var(var, 1)))
-		return err;
-	return 0;
-}
-
-static void hpfb_encode_fix(struct fb_fix_screeninfo *fix, 
-				struct hpfb_par *par)
-{
-	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id, "HP300 Topcat");
-
-	/*
-	 * X works, but screen wraps ... 
-	 */
-	fix->smem_start=fb_start;
-	fix->smem_len=fb_size;
-	fix->type = FB_TYPE_PACKED_PIXELS;
-	fix->visual = FB_VISUAL_PSEUDOCOLOR;
-	fix->xpanstep=0;
-	fix->ypanstep=0;
-	fix->ywrapstep=0;
-	fix->line_length=fb_line_length;
-}
-
-static int hpfb_get_fix(struct fb_fix_screeninfo *fix, int con,
-			 struct fb_info *info)
-{
-	struct hpfb_par par;
-	hpfb_get_par(&par);
-	hpfb_encode_fix(fix, &par);
-	return 0;
-}
-
-static void topcat_blit(int x0, int y0, int x1, int y1, int w, int h)
+void hpfb_copyarea(struct fb_info *info, struct fb_copyarea *area) 
 {
 	while (readb(fb_regs + BUSY) & fb_bitmask);
 	writeb(0x3, fb_regs + WMRR);
-	writew(x0, fb_regs + SOURCE_X);
-	writew(y0, fb_regs + SOURCE_Y);
-	writew(x1, fb_regs + DEST_X);
-	writew(y1, fb_regs + DEST_Y);
-	writew(h, fb_regs + WHEIGHT);
-	writew(w, fb_regs + WWIDTH);
+	writew(area->sx, fb_regs + SOURCE_X);
+	writew(area->sy, fb_regs + SOURCE_Y);
+	writew(area->dx, fb_regs + DEST_X);
+	writew(area->dy, fb_regs + DEST_Y);
+	writew(area->height, fb_regs + WHEIGHT);
+	writew(area->width, fb_regs + WWIDTH);
 	writeb(fb_bitmask, fb_regs + WMOVE);
 }
 
-static int hpfb_switch(int con, struct fb_info *info)
-{
-	do_fb_set_var(&fb_display[con].var,1);
-	info->currcon=con;
-	return 0;
-}
-
-static void hpfb_set_disp(int con)
-{
-	struct fb_fix_screeninfo fix;
-	struct display *display;
-	
-	if (con >= 0)
-		display = &fb_display[con];
-	else
-		display = &disp;	/* used during initialization */
-
-	hpfb_get_fix(&fix, con, 0);
-
-	display->visual = fix.visual;
-	display->type = fix.type;
-	display->type_aux = fix.type_aux;
-	display->ypanstep = fix.ypanstep;
-	display->ywrapstep = fix.ywrapstep;
-	display->line_length = fix.line_length;
-	display->next_line = fix.line_length;
-	display->can_soft_blank = 0;
-	display->inverse = 0;
-
-	display->dispsw = &fbcon_cfb8;
-}
-
 static struct fb_ops hpfb_ops = {
 	owner:		THIS_MODULE,
-	fb_get_fix:	hpfb_get_fix,
-	fb_get_var:	hpfb_get_var,
-	fb_set_var:	hpfb_set_var,
-	fb_get_cmap:	hpfb_get_cmap,
-	fb_set_cmap:	fbgen_set_cmap,
+	fb_get_fix:	gen_get_fix,
+	fb_get_var:	gen_get_var,
+	fb_set_var:	gen_set_var,
+	fb_get_cmap:	gen_get_cmap,
+	fb_set_cmap:	gen_set_cmap,
 	fb_setcolreg:	hpfb_setcolreg,
+	fb_copyarea:	hpfb_copyarea,
 };
 
 #define TOPCAT_FBOMSB	0x5d
@@ -272,7 +120,7 @@
 	fboff = (readb(base + TOPCAT_FBOMSB) << 8) 
 		| readb(base + TOPCAT_FBOLSB);
 
-	fb_start = 0xf0000000 | (readb(base + fboff) << 16);
+	hpfb_fix.smem_start = 0xf0000000 | (readb(base + fboff) << 16);
 	fb_regs = base;
 
 #if 0
@@ -284,17 +132,6 @@
 	writeb(0, base+0x4516);
 	writeb(0x90, base+0x4206);
 #endif
-
-	/*
-	 *	Fill in the available video resolution
-	 */
-	 
-	hpfb_defined.xres = 1024;
-	hpfb_defined.yres = 768;
-	hpfb_defined.xres_virtual = 1024;
-	hpfb_defined.yres_virtual = 768;
-	hpfb_defined.bits_per_pixel = 8;
-
 	/* 
 	 *	Give the hardware a bit of a prod and work out how many bits per
 	 *	pixel are supported.
@@ -302,8 +139,8 @@
 	
 	writeb(0xff, base + TC_WEN);
 	writeb(0xff, base + TC_FBEN);
-	writeb(0xff, fb_start);
-	fb_bitmask = readb(fb_start);
+	writeb(0xff, hpfb_fix.smem_start);
+	fb_bitmask = readb(hpfb_fix.smem_start);
 
 	/*
 	 *	Enable reading/writing of all the planes.
@@ -316,23 +153,25 @@
 	/*
 	 *	Let there be consoles..
 	 */
-	strcpy(fb_info.modename, "Topcat");
-	fb_info.changevar = NULL;
-	fb_info.node = NODEV;
+	fb_info.node  = NODEV;
 	fb_info.fbops = &hpfb_ops;
-	fb_info.screen_base = fb_start;
-	fb_info.disp = &disp;
-	fb_info.switch_con = &hpfb_switch;
-	fb_info.updatevar = &fb_update_var;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;
-	do_fb_set_var(&hpfb_defined, 1);
+	fb_info.var   = hpfb_defined;
+	fb_info.fix   = hpfb_fix;
+	fb_info.screen_base = hpfb_fix.smem_start;
+
+	/* The below feilds will go away !!!! */
+	fb_info.currcon		= -1;
+        strcpy(fb_info.modename, fb_info.fix.id);
+        fb_info.disp		= &display;
+        fb_info.switch_con	= gen_switch;
+        fb_info.updatevar	= gen_update_var;
+	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
-	hpfb_get_var(&disp.var, -1, &fb_info);
-	hpfb_set_disp(-1);
+	gen_set_var(&fb_info.var, -1, &fb_info);
 
 	if (register_framebuffer(&fb_info) < 0)
 		return 1;
-
 	return 0;
 }
 
@@ -362,29 +201,25 @@
 	 */
 #define INTFBADDR 0xf0560000
 
-	if (hwreg_present((void *)INTFBADDR) && (DIO_ID(INTFBADDR) == DIO_ID_FBUFFER)
-		&& topcat_sid_ok(sid = DIO_SECID(INTFBADDR)))
-	{
+	if (hwreg_present((void *)INTFBADDR) && 
+	   (DIO_ID(INTFBADDR) == DIO_ID_FBUFFER) &&
+	    topcat_sid_ok(sid = DIO_SECID(INTFBADDR))) {
 		printk("Internal Topcat found (secondary id %02x)\n", sid); 
 		hpfb_init_one(INTFBADDR);
-	}
-	else
-	{
+	} else {
 		int sc = dio_find(DIO_ID_FBUFFER);
-		if (sc)
-		{
+
+		if (sc) {
 			unsigned long addr = (unsigned long)dio_scodetoviraddr(sc);
 			unsigned int sid = DIO_SECID(addr);
 
-			if (topcat_sid_ok(sid))
-			{
+			if (topcat_sid_ok(sid)) {
 				printk("Topcat found at DIO select code %02x "
-				       "(secondary id %02x)\n", sc, sid);
+					"(secondary id %02x)\n", sc, sid);
 				hpfb_init_one(addr);
 			}
 		}
 	}
-
 	return 0;
 }
 

