Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310112AbSCAU7K>; Fri, 1 Mar 2002 15:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293757AbSCAU6w>; Fri, 1 Mar 2002 15:58:52 -0500
Received: from www.transvirtual.com ([206.14.214.140]:48395 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S310112AbSCAU6a>; Fri, 1 Mar 2002 15:58:30 -0500
Date: Fri, 1 Mar 2002 12:58:15 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: davej@suse.de
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] vesafb.c ported to new api.
Message-ID: <Pine.LNX.4.10.10203011252140.32332-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Give this patch a try. It is against 2.5.5-dj2. 

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

diff -urN -X /home/jsimmons/dontdiff linux-2.5.5-dj2/drivers/video/fbgen.c linux/drivers/video/fbgen.c
--- linux-2.5.5-dj2/drivers/video/fbgen.c	Tue Feb 26 16:04:26 2002
+++ linux/drivers/video/fbgen.c	Fri Mar  1 12:53:56 2002
@@ -427,9 +427,9 @@
 	display->ypanstep = info->fix.ypanstep;
     	display->ywrapstep = info->fix.ywrapstep;
     	display->line_length = info->fix.line_length;
-	if (info->fbops->fb_blank || info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
+	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR ||
 	    info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
-		display->can_soft_blank = 1;
+		display->can_soft_blank = info->fbops->fb_blank ? 1 : 0;
 		display->dispsw_data = NULL;
 	} else {
 		display->can_soft_blank = 0;
@@ -444,12 +444,15 @@
 	if (con < 0 || info->var.activate & FB_ACTIVATE_ALL)
 		info->disp->var = info->var;	
 
+	if (!info->var.accel_flags) {
+		display->scrollmode = SCROLL_YREDRAW;		
 #ifdef FBCON_HAS_ACCEL
-	if (info->var.accel_flags & FB_ACCELF_TEXT) {
+	} else {
+		display->scrollmode = SCROLL_YNOMOVE;
 		display->dispsw = &fbcon_accel;
 		return;
-	}
 #endif
+	}
 
 	switch (info->var.bits_per_pixel)
 	{
diff -urN -X /home/jsimmons/dontdiff linux-2.5.5-dj2/drivers/video/vesafb.c linux/drivers/video/vesafb.c
--- linux-2.5.5-dj2/drivers/video/vesafb.c	Tue Feb 26 16:04:27 2002
+++ linux/drivers/video/vesafb.c	Fri Mar  1 13:35:37 2002
@@ -26,37 +26,12 @@
 #include <asm/mtrr.h>
 
 #include <video/fbcon.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
-#include <video/fbcon-cfb24.h>
-#include <video/fbcon-cfb32.h>
-#include <video/fbcon-mac.h>
 
 #define dac_reg	(0x3c8)
 #define dac_val	(0x3c9)
 
 /* --------------------------------------------------------------------- */
 
-/*
- * card parameters
- */
-
-/* card */
-unsigned long video_base; /* physical addr */
-int   video_size;
-
-/* mode */
-static int  video_bpp;
-static int  video_width;
-static int  video_height;
-static int  video_height_virtual;
-static int  video_type = FB_TYPE_PACKED_PIXELS;
-static int  video_visual;
-static int  video_linelength;
-static int  video_cmap_len;
-
-/* --------------------------------------------------------------------- */
-
 static struct fb_var_screeninfo vesafb_defined = {
 	0,0,0,0,	/* W,H, W, H (virtual) load xres,xres_virtual*/
 	0,0,		/* virtual -> visible no offset */
@@ -76,20 +51,14 @@
 	{0,0,0,0,0,0}
 };
 
+static struct fb_fix_screeninfo vesafb_fix = {
+    "VESA VGA", (unsigned long) NULL, 0, FB_TYPE_PACKED_PIXELS, 0,
+    FB_VISUAL_PSEUDOCOLOR, 0, 0, 0, 0, (unsigned long) NULL, 0, FB_ACCEL_NONE
+};
+
 static struct display disp;
 static struct fb_info fb_info;
-static struct { u_short blue, green, red, pad; } palette[256];
-static union {
-#ifdef FBCON_HAS_CFB16
-    u16 cfb16[16];
-#endif
-#ifdef FBCON_HAS_CFB24
-    u32 cfb24[16];
-#endif
-#ifdef FBCON_HAS_CFB32
-    u32 cfb32[16];
-#endif
-} fbcon_cmap;
+static u32 pseudo_palette[17];
 
 static int             inverse   = 0;
 static int             mtrr      = 0;
@@ -100,8 +69,6 @@
 static void            (*pmi_start)(void);
 static void            (*pmi_pal)(void);
 
-static struct display_switch vesafb_sw;
-
 /* --------------------------------------------------------------------- */
 
 static int vesafb_pan_display(struct fb_var_screeninfo *var, int con,
@@ -118,7 +85,7 @@
 	if ((ypan==1) && var->yoffset+var->yres > var->yres_virtual)
 		return -EINVAL;
 
-	offset = (var->yoffset * video_linelength + var->xoffset) / 4;
+	offset = (var->yoffset * info->fix.line_length + var->xoffset) / 4;
 
         __asm__ __volatile__(
                 "call *(%%edi)"
@@ -140,161 +107,6 @@
 	return 0;
 }
 
-static int vesafb_get_fix(struct fb_fix_screeninfo *fix, int con,
-			 struct fb_info *info)
-{
-	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id,"VESA VGA");
-
-	fix->smem_start=video_base;
-	fix->smem_len=video_size;
-	fix->type = video_type;
-	fix->visual = video_visual;
-	fix->xpanstep  = 0;
-	fix->ypanstep  = ypan     ? 1 : 0;
-	fix->ywrapstep = (ypan>1) ? 1 : 0;
-	fix->line_length=video_linelength;
-	return 0;
-}
-
-static int vesafb_get_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info)
-{
-	if(con==-1)
-		memcpy(var, &vesafb_defined, sizeof(struct fb_var_screeninfo));
-	else
-		*var=fb_display[con].var;
-	return 0;
-}
-
-static void vesafb_set_disp(int con)
-{
-	struct fb_fix_screeninfo fix;
-	struct display *display;
-	struct display_switch *sw;
-	
-	if (con >= 0)
-		display = &fb_display[con];
-	else
-		display = &disp;	/* used during initialization */
-
-	vesafb_get_fix(&fix, con, 0);
-
-	memset(display, 0, sizeof(struct display));
-	display->visual = fix.visual;
-	display->type = fix.type;
-	display->type_aux = fix.type_aux;
-	display->ypanstep = fix.ypanstep;
-	display->ywrapstep = fix.ywrapstep;
-	display->line_length = fix.line_length;
-	display->next_line = fix.line_length;
-	display->can_soft_blank = 0;
-	display->inverse = inverse;
-	vesafb_get_var(&display->var, -1, &fb_info);
-
-	switch (video_bpp) {
-#ifdef FBCON_HAS_CFB8
-	case 8:
-		sw = &fbcon_cfb8;
-		break;
-#endif
-#ifdef FBCON_HAS_CFB16
-	case 15:
-	case 16:
-		sw = &fbcon_cfb16;
-		display->dispsw_data = fbcon_cmap.cfb16;
-		break;
-#endif
-#ifdef FBCON_HAS_CFB24
-	case 24:
-		sw = &fbcon_cfb24;
-		display->dispsw_data = fbcon_cmap.cfb24;
-		break;
-#endif
-#ifdef FBCON_HAS_CFB32
-	case 32:
-		sw = &fbcon_cfb32;
-		display->dispsw_data = fbcon_cmap.cfb32;
-		break;
-#endif
-	default:
-#ifdef FBCON_HAS_MAC
-		sw = &fbcon_mac;
-		break;
-#else
-		sw = &fbcon_dummy;
-		return;
-#endif
-	}
-	memcpy(&vesafb_sw, sw, sizeof(*sw));
-	display->dispsw = &vesafb_sw;
-	if (!ypan) {
-		display->scrollmode = SCROLL_YREDRAW;
-		vesafb_sw.bmove = fbcon_redraw_bmove;
-	}
-}
-
-static int vesafb_set_var(struct fb_var_screeninfo *var, int con,
-			  struct fb_info *info)
-{
-	static int first = 1;
-
-	if (var->xres           != vesafb_defined.xres           ||
-	    var->yres           != vesafb_defined.yres           ||
-	    var->xres_virtual   != vesafb_defined.xres_virtual   ||
-	    var->yres_virtual   >  video_height_virtual          ||
-	    var->yres_virtual   <  video_height                  ||
-	    var->xoffset                                         ||
-	    var->bits_per_pixel != vesafb_defined.bits_per_pixel ||
-	    var->nonstd) {
-		if (first) {
-			printk(KERN_ERR "Vesafb does not support changing the video mode\n");
-			first = 0;
-		}
-		return -EINVAL;
-	}
-
-	if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_TEST)
-		return 0;
-
-	if (ypan) {
-		if (vesafb_defined.yres_virtual != var->yres_virtual) {
-			vesafb_defined.yres_virtual = var->yres_virtual;
-			if (con != -1) {
-				fb_display[con].var = vesafb_defined;
-				info->changevar(con);
-			}
-		}
-
-		if (var->yoffset != vesafb_defined.yoffset)
-			return vesafb_pan_display(var,con,info);
-		return 0;
-	}
-
-	if (var->yoffset)
-		return -EINVAL;
-	return 0;
-}
-
-static int vesa_getcolreg(unsigned regno, unsigned *red, unsigned *green,
-			  unsigned *blue, unsigned *transp,
-			  struct fb_info *fb_info)
-{
-	/*
-	 *  Read a single color register and split it into colors/transparent.
-	 *  Return != 0 for invalid regno.
-	 */
-
-	if (regno >= video_cmap_len)
-		return 1;
-
-	*red   = palette[regno].red;
-	*green = palette[regno].green;
-	*blue  = palette[regno].blue;
-	*transp = 0;
-	return 0;
-}
-
 #ifdef FBCON_HAS_CFB8
 
 static void vesa_setpalette(int regno, unsigned red, unsigned green, unsigned blue)
@@ -328,7 +140,7 @@
 
 static int vesafb_setcolreg(unsigned regno, unsigned red, unsigned green,
 			    unsigned blue, unsigned transp,
-			    struct fb_info *fb_info)
+			    struct fb_info *info)
 {
 	/*
 	 *  Set a single color register. The values supplied are
@@ -337,14 +149,10 @@
 	 *  != 0 for invalid regno.
 	 */
 	
-	if (regno >= video_cmap_len)
+	if (regno >= info->cmap.len)
 		return 1;
 
-	palette[regno].red   = red;
-	palette[regno].green = green;
-	palette[regno].blue  = blue;
-	
-	switch (video_bpp) {
+	switch (info->var.bits_per_pixel) {
 #ifdef FBCON_HAS_CFB8
 	case 8:
 		vesa_setpalette(regno,red,green,blue);
@@ -355,16 +163,16 @@
 	case 16:
 		if (vesafb_defined.red.offset == 10) {
 			/* 1:5:5:5 */
-			fbcon_cmap.cfb16[regno] =
-				((red   & 0xf800) >>  1) |
-				((green & 0xf800) >>  6) |
-				((blue  & 0xf800) >> 11);
+			((u16*) (info->pseudo_palette))[regno] =	
+					((red   & 0xf800) >>  1) |
+					((green & 0xf800) >>  6) |
+					((blue  & 0xf800) >> 11);
 		} else {
 			/* 0:5:6:5 */
-			fbcon_cmap.cfb16[regno] =
-				((red   & 0xf800)      ) |
-				((green & 0xfc00) >>  5) |
-				((blue  & 0xf800) >> 11);
+			((u16*) (info->pseudo_palette))[regno] =	
+					((red   & 0xf800)      ) |
+					((green & 0xfc00) >>  5) |
+					((blue  & 0xf800) >> 11);
 		}
 		break;
 #endif
@@ -373,7 +181,7 @@
 		red   >>= 8;
 		green >>= 8;
 		blue  >>= 8;
-		fbcon_cmap.cfb24[regno] =
+		((u32 *)(info->pseudo_palette))[regno] =
 			(red   << vesafb_defined.red.offset)   |
 			(green << vesafb_defined.green.offset) |
 			(blue  << vesafb_defined.blue.offset);
@@ -384,7 +192,7 @@
 		red   >>= 8;
 		green >>= 8;
 		blue  >>= 8;
-		fbcon_cmap.cfb32[regno] =
+		((u32 *)(info->pseudo_palette))[regno] =
 			(red   << vesafb_defined.red.offset)   |
 			(green << vesafb_defined.green.offset) |
 			(blue  << vesafb_defined.blue.offset);
@@ -394,26 +202,13 @@
     return 0;
 }
 
-static int vesafb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-			   struct fb_info *info)
-{
-	if (con == info->currcon) /* current console? */
-		return fb_get_cmap(cmap, kspc, vesa_getcolreg, info);
-	else if (fb_display[con].cmap.len) /* non default colormap? */
-		fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
-	else
-		fb_copy_cmap(fb_default_cmap(video_cmap_len),
-		     cmap, kspc ? 0 : 2);
-	return 0;
-}
-
 static struct fb_ops vesafb_ops = {
 	owner:		THIS_MODULE,
-	fb_get_fix:	vesafb_get_fix,
-	fb_get_var:	vesafb_get_var,
-	fb_set_var:	vesafb_set_var,
-	fb_get_cmap:	vesafb_get_cmap,
-	fb_set_cmap:	fbgen_set_cmap,
+	fb_get_fix:	gen_get_fix,
+	fb_get_var:	gen_get_var,
+	fb_set_var:	gen_set_var,
+	fb_get_cmap:	gen_get_cmap,
+	fb_set_cmap:	gen_set_cmap,
 	fb_setcolreg:	vesafb_setcolreg,
 	fb_pan_display:	vesafb_pan_display,
 };
@@ -450,59 +245,46 @@
 	return 0;
 }
 
-static int vesafb_switch(int con, struct fb_info *info)
-{
-	/* Do we have to save the colormap? */
-	if (fb_display[info->currcon].cmap.len)
-		fb_get_cmap(&fb_display[info->currcon].cmap, 1, vesa_getcolreg,
-			    info);
-	
-	info->currcon = con;
-	/* Install new colormap */
-	do_install_cmap(con, info);
-	vesafb_update_var(con,info);
-	return 1;
-}
-
 int __init vesafb_init(void)
 {
-	int i,j;
+	int video_cmap_len;
+	int i;
 
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_VLFB)
 		return -ENXIO;
 
-	video_base          = screen_info.lfb_base;
-	video_bpp           = screen_info.lfb_depth;
-	if (15 == video_bpp)
-		video_bpp = 16;
-	video_width         = screen_info.lfb_width;
-	video_height        = screen_info.lfb_height;
-	video_linelength    = screen_info.lfb_linelength;
-	video_size          = screen_info.lfb_size * 65536;
-	video_visual = (video_bpp == 8) ?
+	vesafb_fix.smem_start = screen_info.lfb_base;
+	vesafb_defined.bits_per_pixel = screen_info.lfb_depth;
+	if (15 == vesafb_defined.bits_per_pixel)
+		vesafb_defined.bits_per_pixel = 16;
+	vesafb_defined.xres = screen_info.lfb_width;
+	vesafb_defined.yres = screen_info.lfb_height;
+	vesafb_fix.line_length = screen_info.lfb_linelength;
+	vesafb_fix.smem_len = screen_info.lfb_size * 65536;
+	vesafb_fix.visual   = (vesafb_defined.bits_per_pixel == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 
-	if (!request_mem_region(video_base, video_size, "vesafb")) {
+	if (!request_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len, "vesafb")) {
 		printk(KERN_WARNING
 		       "vesafb: abort, cannot reserve video memory at 0x%lx\n",
-			video_base);
+			vesafb_fix.smem_start);
 		/* We cannot make this fatal. Sometimes this comes from magic
 		   spaces our resource handlers simply don't know about */
 	}
 
-        fb_info.screen_base = ioremap(video_base, video_size);
+        fb_info.screen_base = ioremap(vesafb_fix.smem_start, vesafb_fix.smem_len);
 	if (!fb_info.screen_base) {
-		release_mem_region(video_base, video_size);
+		release_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len);
 		printk(KERN_ERR
 		       "vesafb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
-			video_size, video_base);
+			vesafb_fix.smem_len, vesafb_fix.smem_start);
 		return -EIO;
 	}
 
 	printk(KERN_INFO "vesafb: framebuffer at 0x%lx, mapped to 0x%p, size %dk\n",
-	       video_base, fb_info.screen_base, video_size/1024);
+	       vesafb_fix.smem_start, fb_info.screen_base, vesafb_fix.smem_len/1024);
 	printk(KERN_INFO "vesafb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
-	       video_width, video_height, video_bpp, video_linelength, screen_info.pages);
+	       vesafb_defined.xres, vesafb_defined.yres, vesafb_defined.bits_per_pixel, vesafb_fix.line_length, screen_info.pages);
 
 	if (screen_info.vesapm_seg) {
 		printk(KERN_INFO "vesafb: protected mode interface info at %04x:%04x\n",
@@ -535,32 +317,27 @@
 		}
 	}
 
-	vesafb_defined.xres=video_width;
-	vesafb_defined.yres=video_height;
-	vesafb_defined.xres_virtual=video_width;
-	vesafb_defined.yres_virtual=video_size / video_linelength;
-	vesafb_defined.bits_per_pixel=video_bpp;
-
-	if (ypan && vesafb_defined.yres_virtual > video_height) {
+	vesafb_defined.xres_virtual = vesafb_defined.xres;
+	vesafb_defined.yres_virtual = vesafb_fix.smem_len / vesafb_fix.line_length;
+	if (ypan && vesafb_defined.yres_virtual > vesafb_defined.yres) {
 		printk(KERN_INFO "vesafb: scrolling: %s using protected mode interface, yres_virtual=%d\n",
 		       (ypan > 1) ? "ywrap" : "ypan",vesafb_defined.yres_virtual);
 	} else {
 		printk(KERN_INFO "vesafb: scrolling: redraw\n");
-		vesafb_defined.yres_virtual = video_height;
+		vesafb_defined.yres_virtual = vesafb_defined.yres;
 		ypan = 0;
 	}
-	video_height_virtual = vesafb_defined.yres_virtual;
-
+	
 	/* some dummy values for timing to make fbset happy */
-	vesafb_defined.pixclock     = 10000000 / video_width * 1000 / video_height;
-	vesafb_defined.left_margin  = (video_width / 8) & 0xf8;
+	vesafb_defined.pixclock     = 10000000 / vesafb_defined.xres * 1000 / vesafb_defined.yres;
+	vesafb_defined.left_margin  = (vesafb_defined.xres / 8) & 0xf8;
 	vesafb_defined.right_margin = 32;
 	vesafb_defined.upper_margin = 16;
 	vesafb_defined.lower_margin = 4;
-	vesafb_defined.hsync_len    = (video_width / 8) & 0xf8;
+	vesafb_defined.hsync_len    = (vesafb_defined.xres / 8) & 0xf8;
 	vesafb_defined.vsync_len    = 4;
 
-	if (video_bpp > 8) {
+	if (vesafb_defined.bits_per_pixel > 8) {
 		vesafb_defined.red.offset    = screen_info.red_pos;
 		vesafb_defined.red.length    = screen_info.red_size;
 		vesafb_defined.green.offset  = screen_info.green_pos;
@@ -584,46 +361,48 @@
 		vesafb_defined.red.length   = 6;
 		vesafb_defined.green.length = 6;
 		vesafb_defined.blue.length  = 6;
-		for(i = 0; i < 16; i++) {
-			j = color_table[i];
-			palette[i].red   = default_red[j];
-			palette[i].green = default_grn[j];
-			palette[i].blue  = default_blu[j];
-		}
 		video_cmap_len = 256;
 	}
 
+	vesafb_fix.ypanstep  = ypan     ? 1 : 0;
+	vesafb_fix.ywrapstep = (ypan>1) ? 1 : 0;
+
 	/* request failure does not faze us, as vgacon probably has this
 	 * region already (FIXME) */
 	request_region(0x3c0, 32, "vesafb");
 
 	if (mtrr) {
-		int temp_size = video_size;
+		int temp_size = vesafb_fix.smem_len;
 		/* Find the largest power-of-two */
 		while (temp_size & (temp_size - 1))
                 	temp_size &= (temp_size - 1);
                         
                 /* Try and find a power of two to add */
-		while (temp_size && mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB, 1)==-EINVAL) {
+		while (temp_size && mtrr_add(vesafb_fix.smem_start, temp_size, MTRR_TYPE_WRCOMB, 1)==-EINVAL) {
 			temp_size >>= 1;
 		}
 	}
 	
-	strcpy(fb_info.modename, "VESA VGA");
+	strcpy(fb_info.modename, vesafb_fix.id);
 	fb_info.changevar = NULL;
 	fb_info.node = NODEV;
 	fb_info.fbops = &vesafb_ops;
-	fb_info.disp=&disp;
-	fb_info.switch_con=&vesafb_switch;
-	fb_info.updatevar=&vesafb_update_var;
+	fb_info.var = vesafb_defined;
+	fb_info.fix = vesafb_fix;
+	fb_info.disp = &disp;
+	fb_info.switch_con = gen_switch;
+	fb_info.updatevar = &vesafb_update_var;
+	fb_info.pseudo_palette = pseudo_palette;
 	fb_info.flags=FBINFO_FLAG_DEFAULT;
-	vesafb_set_disp(-1);
+
+	fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
+	gen_set_disp(-1, &fb_info);
 
 	if (register_framebuffer(&fb_info)<0)
 		return -EINVAL;
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n",
-	       GET_FB_IDX(fb_info.node), fb_info.modename);
+	       GET_FB_IDX(fb_info.node), fb_info.fix.id);
 	return 0;
 }
 

