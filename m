Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293660AbSB1SdK>; Thu, 28 Feb 2002 13:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293624AbSB1SaQ>; Thu, 28 Feb 2002 13:30:16 -0500
Received: from www.transvirtual.com ([206.14.214.140]:43784 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S293646AbSB1S2T>; Thu, 28 Feb 2002 13:28:19 -0500
Date: Thu, 28 Feb 2002 10:28:12 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: davej@suse.de
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fm2fb ported to new fbdev api.
Message-ID: <Pine.LNX.4.10.10202281026451.9321-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please test this driver so I could included into the dj tree. It is
against 2.5.5-dj1. 

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/
--- linux-2.5.5-dj2/drivers/video/fm2fb.c	Tue Feb 26 16:04:26 2002
+++ linux/drivers/video/fm2fb.c	Thu Feb 28 11:23:44 2002
@@ -4,9 +4,11 @@
  *
  *	Copyright (C) 1998 Steffen A. Mork (mork@ls7.cs.uni-dortmund.de)
  *	Copyright (C) 1999 Geert Uytterhoeven
+ *      Copyright (C) 2001 James Simmons
  *
  *  Written for 2.0.x by Steffen A. Mork
  *  Ported to 2.1.x by Geert Uytterhoeven
+ *  Ported to new api by James Simmons
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License. See the file COPYING in the main directory of this archive for
@@ -18,12 +20,9 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/zorro.h>
-
 #include <asm/io.h>
 
 #include <video/fbcon.h>
-#include <video/fbcon-cfb32.h>
-
 
 /*
  *	Some technical notes:
@@ -117,7 +116,6 @@
  *
  */
 
-
 /*
  *	definitions
  */
@@ -130,29 +128,18 @@
 #define FRAMEMASTER_COMPL	4
 #define FRAMEMASTER_ROM		8
 
-
-struct FrameMaster_fb_par
-{
-	int xres;
-	int yres;
-	int bpp;
-	int pixclock;
-};
-
-static unsigned long fm2fb_mem_phys;
-static void *fm2fb_mem;
-static unsigned long fm2fb_reg_phys;
 static volatile unsigned char *fm2fb_reg;
 
-static struct display disp;
+#define arraysize(x)	(sizeof(x)/sizeof(*(x)))
+
 static struct fb_info fb_info;
-static struct { u_char red, green, blue, pad; } palette[16];
-#ifdef FBCON_HAS_CFB32
-static u32 fbcon_cfb32_cmap[16];
-#endif
+static u32 pseudo_palette[17];
+static struct display display;
 
-static struct fb_fix_screeninfo fb_fix;
-static struct fb_var_screeninfo fb_var;
+static struct fb_fix_screeninfo fb_fix __initdata = {
+    NULL, (unsigned long) NULL, FRAMEMASTER_REG, FB_TYPE_PACKED_PIXELS, 0,
+    FB_VISUAL_TRUECOLOR, 0, 0, 0, 768<<2, (unsigned long)NULL, 8, FB_ACCEL_NONE
+};
 
 static int fm2fb_mode __initdata = -1;
 
@@ -174,125 +161,55 @@
 	33333, 10, 102, 10, 5, 80, 34, FB_SYNC_COMP_HIGH_ACT, 0
     }
 };
-
-
+    
     /*
      *  Interface used by the world
      */
+int fm2fb_init(void);
 
-static int fm2fb_get_fix(struct fb_fix_screeninfo *fix, int con,
-			 struct fb_info *info);
-static int fm2fb_get_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info);
-static int fm2fb_set_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info);
-static int fm2fb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-			  struct fb_info *info);
 static int fm2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
-			   u_int transp, struct fb_info *info);
+                           u_int transp, struct fb_info *info);
 static int fm2fb_blank(int blank, struct fb_info *info);
 
-    /*
-     *  Interface to the low level console driver
-     */
-
-int fm2fb_init(void);
-static int fm2fbcon_switch(int con, struct fb_info *info);
-static int fm2fbcon_updatevar(int con, struct fb_info *info);
-
-    /*
-     *  Internal routines
-     */
-
-static int fm2fb_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
-			   u_int *transp, struct fb_info *info);
-
 static struct fb_ops fm2fb_ops = {
 	owner:		THIS_MODULE,
-	fb_get_fix:	fm2fb_get_fix,
-	fb_get_var:	fm2fb_get_var,
-	fb_set_var:	fm2fb_set_var,
-	fb_get_cmap:	fm2fb_get_cmap,
-	fb_set_cmap:	fbgen_set_cmap,
+	fb_get_fix:	gen_get_fix,
+	fb_get_var:	gen_get_var,
+	fb_set_var:	gen_set_var,
+	fb_get_cmap:	gen_get_cmap,
+	fb_set_cmap:	gen_set_cmap,
 	fb_setcolreg:	fm2fb_setcolreg,
-	fb_blank:	fm2fb_blank,
+	fb_blank:	fm2fb_blank,	
 };
 
     /*
-     *  Get the Fixed Part of the Display
+     *  Blank the display.
      */
-
-static int fm2fb_get_fix(struct fb_fix_screeninfo *fix, int con,
-			 struct fb_info *info)
+static int fm2fb_blank(int blank, struct fb_info *info)
 {
-    memcpy(fix, &fb_fix, sizeof(fb_fix));
-    return 0;
-}
+	unsigned char t = FRAMEMASTER_ROM;
 
-
-    /*
-     *  Get the User Defined Part of the Display
-     */
-
-static int fm2fb_get_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info)
-{
-    memcpy(var, &fb_var, sizeof(fb_var));
-    return 0;
+	if (!blank)
+		t |= FRAMEMASTER_ENABLE | FRAMEMASTER_NOLACE;
+	fm2fb_reg[0] = t;
 }
-
-
+    
     /*
-     *  Set the User Defined Part of the Display
+     *  Set a single color register. The values supplied are already
+     *  rounded down to the hardware's capabilities (according to the
+     *  entries in the var structure). Return != 0 for invalid regno.
      */
-
-static int fm2fb_set_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info)
+static int fm2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
+                         u_int transp, struct fb_info *info)
 {
-    struct display *display;
-    int oldbpp = -1, err;
-
-    if (con >= 0)
-	display = &fb_display[con];
-    else
-	display = &disp;	/* used during initialization */
-
-    if (var->xres > fb_var.xres || var->yres > fb_var.yres ||
-	var->xres_virtual > fb_var.xres_virtual ||
-	var->yres_virtual > fb_var.yres_virtual ||
-	var->bits_per_pixel > fb_var.bits_per_pixel ||
-	var->nonstd ||
-	(var->vmode & FB_VMODE_MASK) != FB_VMODE_NONINTERLACED)
-	return -EINVAL;
-    memcpy(var, &fb_var, sizeof(fb_var));
-
-    if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
-	oldbpp = display->var.bits_per_pixel;
-	display->var = *var;
-    }
-    if (oldbpp != var->bits_per_pixel) {
-	if ((err = fb_alloc_cmap(&display->cmap, 0, 0)))
-	    return err;
-	do_install_cmap(con, info);
-    }
-    return 0;
-}
-
+	if (regno > 15)
+		return 1;
+	red >>= 8;
+	green >>= 8;
+	blue >>= 8;
 
-    /*
-     *  Get the Colormap
-     */
-
-static int fm2fb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-			  struct fb_info *info)
-{
-    if (con == info->currcon) /* current console? */
-	return fb_get_cmap(cmap, kspc, fm2fb_getcolreg, info);
-    else if (fb_display[con].cmap.len) /* non default colormap? */
-	fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
-    else
-	fb_copy_cmap(fb_default_cmap(256), cmap, kspc ? 0 : 2);
-    return 0;
+	((u32*)(info->pseudo_palette))[regno] = (red << 16) | (green << 8) | blue;
+	return 0;
 }
 
     /*
@@ -301,193 +218,87 @@
 
 int __init fm2fb_init(void)
 {
-    int is_fm;
-    struct zorro_dev *z = NULL;
-    unsigned long *ptr;
-    int x, y;
-
-    while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
-	if (z->id == ZORRO_PROD_BSC_FRAMEMASTER_II)
-	    is_fm = 1;
-	else if (z->id == ZORRO_PROD_HELFRICH_RAINBOW_II)
-	    is_fm = 0;
-	else
-	    continue;
-	if (!request_mem_region(z->resource.start, FRAMEMASTER_SIZE, "fm2fb"))
-	    continue;
-
-	/* assigning memory to kernel space */
-	fm2fb_mem_phys = z->resource.start;
-	fm2fb_mem  = ioremap(fm2fb_mem_phys, FRAMEMASTER_SIZE);
-	fm2fb_reg_phys = fm2fb_mem_phys+FRAMEMASTER_REG;
-	fm2fb_reg  = (unsigned char *)(fm2fb_mem+FRAMEMASTER_REG);
-
-	/* make EBU color bars on display */
-	ptr = (unsigned long *)fm2fb_mem;
-	for (y = 0; y < 576; y++) {
-	    for (x = 0; x < 96; x++) *ptr++ = 0xffffff;	/* white */
-	    for (x = 0; x < 96; x++) *ptr++ = 0xffff00;	/* yellow */
-	    for (x = 0; x < 96; x++) *ptr++ = 0x00ffff;	/* cyan */
-	    for (x = 0; x < 96; x++) *ptr++ = 0x00ff00;	/* green */
-	    for (x = 0; x < 96; x++) *ptr++ = 0xff00ff;	/* magenta */
-	    for (x = 0; x < 96; x++) *ptr++ = 0xff0000;	/* red */
-	    for (x = 0; x < 96; x++) *ptr++ = 0x0000ff;	/* blue */
-	    for (x = 0; x < 96; x++) *ptr++ = 0x000000;	/* black */
-	}
-	fm2fb_blank(0, NULL);
+	struct zorro_dev *z = NULL;
+	unsigned long *ptr;
+	int is_fm;
+	int x, y;
+
+	while ((z = zorro_find_device(ZORRO_WILDCARD, z))) {
+		if (z->id == ZORRO_PROD_BSC_FRAMEMASTER_II)
+			is_fm = 1;
+		else if (z->id == ZORRO_PROD_HELFRICH_RAINBOW_II)
+			is_fm = 0;
+		else
+			continue;
+		
+		if (!request_mem_region(z->resource.start, FRAMEMASTER_SIZE, "fm2fb"))
+			continue;
+
+		/* assigning memory to kernel space */
+		fb_fix.smem_start = z->resource.start;
+		fb_info.screen_base = ioremap(fb_fix.smem_start, FRAMEMASTER_SIZE);
+		fb_fix.mmio_start = fb_fix.smem_start + FRAMEMASTER_REG;
+		fm2fb_reg  = (unsigned char *)(fb_info.screen_base+FRAMEMASTER_REG);
+	
+		strcpy(fb_fix.id, is_fm ? "FrameMaster II" : "Rainbow II");
+
+		/* make EBU color bars on display */
+		ptr = (unsigned long *)fb_fix.smem_start;
+		for (y = 0; y < 576; y++) {
+			for (x = 0; x < 96; x++) *ptr++ = 0xffffff;/* white */
+			for (x = 0; x < 96; x++) *ptr++ = 0xffff00;/* yellow */
+			for (x = 0; x < 96; x++) *ptr++ = 0x00ffff;/* cyan */
+			for (x = 0; x < 96; x++) *ptr++ = 0x00ff00;/* green */
+			for (x = 0; x < 96; x++) *ptr++ = 0xff00ff;/* magenta */
+			for (x = 0; x < 96; x++) *ptr++ = 0xff0000;/* red */
+			for (x = 0; x < 96; x++) *ptr++ = 0x0000ff;/* blue */
+			for (x = 0; x < 96; x++) *ptr++ = 0x000000;/* black */
+		}
+		fm2fb_blank(0, NULL);
+
+		if (fm2fb_mode == -1)
+			fm2fb_mode = FM2FB_MODE_PAL;
+
+		strcpy(fb_info.modename, fb_fix.id);
+		fb_info.node = NODEV;
+		fb_info.fbops = &fm2fb_ops;
+		fb_info.var = fb_var_modes[fm2fb_mode];
+		fb_info.screen_base = (char *)fb_fix.smem_start;
+		fb_info.pseudo_palette = pseudo_palette;
+		fb_info.fix = fb_fix;
+		fb_info.flags = FBINFO_FLAG_DEFAULT;
+
+		/* The below feilds will go away !!!! */
+		fb_info.currcon		= -1;
+		strcpy(fb_info.modename, fb_info.fix.id);
+		fb_info.disp		= &display;
+		fb_info.switch_con	= gen_switch;
+		fb_info.updatevar	= gen_update_var;
+		fb_alloc_cmap(&fb_info.cmap, 16, 0);
 
-	if (fm2fb_mode == -1)
-	    fm2fb_mode = FM2FB_MODE_PAL;
+		gen_set_var(&fb_info.var, -1, &fb_info);
 
-	fb_var = fb_var_modes[fm2fb_mode];
+		if (register_framebuffer(&fb_info) < 0)
+			return -EINVAL;
 
-	strcpy(fb_fix.id, is_fm ? "FrameMaster II" : "Rainbow II");
-	fb_fix.smem_start = fm2fb_mem_phys;
-	fb_fix.smem_len = FRAMEMASTER_REG;
-	fb_fix.type = FB_TYPE_PACKED_PIXELS;
-	fb_fix.type_aux = 0;
-	fb_fix.visual = FB_VISUAL_TRUECOLOR;
-	fb_fix.line_length = 768<<2;
-	fb_fix.mmio_start = fm2fb_reg_phys;
-	fb_fix.mmio_len = 8;
-	fb_fix.accel = FB_ACCEL_NONE;
-
-	disp.var = fb_var;
-	disp.cmap.start = 0;
-	disp.cmap.len = 0;
-	disp.cmap.red = disp.cmap.green = disp.cmap.blue = disp.cmap.transp = NULL;
-	disp.screen_base = (char *)fm2fb_mem;
-	disp.visual = fb_fix.visual;
-	disp.type = fb_fix.type;
-	disp.type_aux = fb_fix.type_aux;
-	disp.ypanstep = 0;
-	disp.ywrapstep = 0;
-	disp.line_length = fb_fix.line_length;
-	disp.can_soft_blank = 1;
-	disp.inverse = 0;
-    #ifdef FBCON_HAS_CFB32
-	disp.dispsw = &fbcon_cfb32;
-	disp.dispsw_data = &fbcon_cfb32_cmap;
-    #else
-	disp.dispsw = &fbcon_dummy;
-    #endif
-	disp.scrollmode = SCROLL_YREDRAW;
-
-	strcpy(fb_info.modename, fb_fix.id);
-	fb_info.node = NODEV;
-	fb_info.fbops = &fm2fb_ops;
-	fb_info.disp = &disp;
-	fb_info.fontname[0] = '\0';
-	fb_info.changevar = NULL;
-	fb_info.switch_con = &fm2fbcon_switch;
-	fb_info.updatevar = &fm2fbcon_updatevar;
-	fb_info.flags = FBINFO_FLAG_DEFAULT;
-
-	fm2fb_set_var(&fb_var, -1, &fb_info);
-
-	if (register_framebuffer(&fb_info) < 0)
-	    return -EINVAL;
-
-	printk("fb%d: %s frame buffer device\n", GET_FB_IDX(fb_info.node),
-	       fb_fix.id);
-	return 0;
-    }
-    return -ENXIO;
+		printk("fb%d: %s frame buffer device\n", GET_FB_IDX(fb_info.node), fb_fix.id);
+		return 0;
+	}
+	return -ENXIO;
 }
 
 int __init fm2fb_setup(char *options)
 {
-    char *this_opt;
-
-    if (!options || !*options)
-	return 0;
-
-    while ((this_opt = strsep(&options, ",")) != NULL) {
-	if (!strncmp(this_opt, "pal", 3))
-	    fm2fb_mode = FM2FB_MODE_PAL;
-	else if (!strncmp(this_opt, "ntsc", 4))
-	    fm2fb_mode = FM2FB_MODE_NTSC;
-    }
-    return 0;
-}
-
-
-static int fm2fbcon_switch(int con, struct fb_info *info)
-{
-    /* Do we have to save the colormap? */
-    if (fb_display[info->currcon].cmap.len)
-	fb_get_cmap(&fb_display[info->currcon].cmap, 1, fm2fb_getcolreg, info);
-
-    info->currcon = con;
-    /* Install new colormap */
-    do_install_cmap(con, info);
-    return 0;
-}
-
-    /*
-     *  Update the `var' structure (called by fbcon.c)
-     */
-
-static int fm2fbcon_updatevar(int con, struct fb_info *info)
-{
-    /* Nothing */
-    return 0;
-}
-
-    /*
-     *  Blank the display.
-     */
-
-static int fm2fb_blank(int blank, struct fb_info *info)
-{
-    unsigned char t = FRAMEMASTER_ROM;
-
-    if (!blank)
-	t |= FRAMEMASTER_ENABLE | FRAMEMASTER_NOLACE;
-    fm2fb_reg[0] = t;
-    return 0;	
-}
-
-    /*
-     *  Read a single color register and split it into
-     *  colors/transparent. Return != 0 for invalid regno.
-     */
-
-static int fm2fb_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
-                         u_int *transp, struct fb_info *info)
-{
-    if (regno > 15)
-	return 1;
-    *red = (palette[regno].red<<8) | palette[regno].red;
-    *green = (palette[regno].green<<8) | palette[regno].green;
-    *blue = (palette[regno].blue<<8) | palette[regno].blue;
-    *transp = 0;
-    return 0;
-}
+	char *this_opt;
 
+	if (!options || !*options)
+		return 0;
 
-    /*
-     *  Set a single color register. The values supplied are already
-     *  rounded down to the hardware's capabilities (according to the
-     *  entries in the var structure). Return != 0 for invalid regno.
-     */
-
-static int fm2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
-                         u_int transp, struct fb_info *info)
-{
-    if (regno > 15)
-	return 1;
-    red >>= 8;
-    green >>= 8;
-    blue >>= 8;
-    palette[regno].red = red;
-    palette[regno].green = green;
-    palette[regno].blue = blue;
-
-#ifdef FBCON_HAS_CFB32
-    fbcon_cfb32_cmap[regno] = (red << 16) | (green << 8) | blue;
-#endif
-    return 0;
+	while ((this_opt = strsep(&options, ",")) != NULL) {	
+		if (!strncmp(this_opt, "pal", 3))
+			fm2fb_mode = FM2FB_MODE_PAL;
+		else if (!strncmp(this_opt, "ntsc", 4))
+			fm2fb_mode = FM2FB_MODE_NTSC;
+	}
+	return 0;
 }

MODULE_LICENSE("GPL");

