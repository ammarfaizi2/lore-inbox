Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293354AbSCBRlA>; Sat, 2 Mar 2002 12:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293317AbSCBRku>; Sat, 2 Mar 2002 12:40:50 -0500
Received: from www.transvirtual.com ([206.14.214.140]:41233 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S293230AbSCBRka>; Sat, 2 Mar 2002 12:40:30 -0500
Date: Sat, 2 Mar 2002 09:40:18 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: davej@suse.de
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] hitfb ported to new api.
Message-ID: <Pine.LNX.4.10.10203020939140.28753-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!
  Please test this driver so it can be applied to the dave jones tree. 

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

--- linux-2.5.5-dj2/drivers/video/hitfb.c	Wed Feb 27 07:52:04 2002
+++ linux/drivers/video/hitfb.c	Sat Mar  2 10:34:58 2002
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/nubus.h>
 #include <linux/init.h>
+#include <linux/fb.h>
 
 #include <asm/machvec.h>
 #include <asm/uaccess.h>
@@ -28,343 +29,160 @@
 #include <asm/io.h>
 #include <asm/hd64461.h>
 
-#include <linux/fb.h>
-
 #include <video/fbcon.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
 
-
-struct hitfb_par
-{
-    int x, y;
-    int bpp;
+static struct fb_var_screeninfo hitfb_var __initdata = {
+	0, 0, 0, 0, 0, 0, 0, 0,
+	{0, 0, 0}, {0, 0, 0}, {0, 0, 0}, {0, 0, 0},
+	0, FB_ACTIVATE_NOW, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0,
+	0, FB_VMODE_NONINTERLACED
 };
 
-
-struct hitfb_info {
-    struct fb_info_gen gen;
-    struct display disp;
-    struct hitfb_par current_par;
-    struct fb_var_screeninfo default_var;
-    int current_par_valid;
-    unsigned long hit_videobase, hit_videosize;
-} fb_info = 
-    {},
-    {},
-    {},
-    {},
-    0, 0, 0,
-    {},
+static struct fb_fix_screeninfo hitfb_fix __initdata = {
+	"Hitachi HD64461",(unsigned long) NULL, 0, FB_TYPE_PACKED_PIXELS,
+	0, FB_VISUAL_TRUECOLOR, 0, 0, 0, 0, (unsigned long) NULL, 0, 
+	FB_ACCEL_NONE
 };
 
 static u16 pseudo_palette[17];
+struct fb_info fb_info;
 
-static void hitfb_set_par(const void *fb_par, struct fb_info_gen *info);
-static int hitfb_encode_var(struct fb_var_screeninfo *var, const void *fb_par,
-			    struct fb_info_gen *info);
-
-
-static void hitfb_detect(void)
-{
-    struct hitfb_par par;
-    unsigned short lcdclor, ldr3, ldvntr;
-
-    fb_info.hit_videobase = CONFIG_HD64461_IOBASE + 0x02000000;
-    fb_info.hit_videosize = (MACH_HP680 || MACH_HP690) ? 1024*1024 : 512*1024;
-
-    lcdclor = inw(HD64461_LCDCLOR);
-    ldvntr = inw(HD64461_LDVNTR);
-    ldr3 = inw(HD64461_LDR3);
-
-    switch(ldr3&15) {
-    default:
-    case 4:
-        par.bpp = 8;
-	par.x = lcdclor;
-	break;
-    case 8:
-        par.bpp = 16;
-	par.x = lcdclor/2;
-	break;
-    }
-
-    par.y = ldvntr+1;
-
-    hitfb_set_par(&par, NULL);
-    hitfb_encode_var(&fb_info.default_var, &par, NULL);
-}
-
-
-static int hitfb_encode_fix(struct fb_fix_screeninfo *fix, const void *fb_par,
-			     struct fb_info_gen *info)
+static int hitfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-    const struct hitfb_par *par = fb_par;
-
-    memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-
-    strcpy(fix->id, "Hitachi HD64461");
-    fix->smem_start = fb_info.hit_videobase;
-    fix->smem_len = fb_info.hit_videosize;
-    fix->type = FB_TYPE_PACKED_PIXELS;
-    fix->type_aux = 0;
-    fix->visual = (par->bpp == 8) ?
-	FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
-    fix->xpanstep = 0;
-    fix->ypanstep = 0;
-    fix->ywrapstep = 0;
-
-    switch(par->bpp) {
-    default:
-    case 8:
-	fix->line_length = par->x;
-	break;
-    case 16:
-	fix->line_length = par->x*2;
-	break;
-    }
-
-    return 0;
-}
+	var->xres_virtual = var->xres;
+	var->yres_virtual = var->yres;
 
-
-static int hitfb_decode_var(const struct fb_var_screeninfo *var, void *fb_par,
-			     struct fb_info_gen *info)
-{
-    struct hitfb_par *par = fb_par;
-
-    par->x = var->xres;
-    par->y = var->yres;
-    par->bpp = var->bits_per_pixel;
-    return 0;
-}
-
-
-static int hitfb_encode_var(struct fb_var_screeninfo *var, const void *fb_par,
-			     struct fb_info_gen *info)
-{
-    const struct hitfb_par *par = fb_par;
-
-    memset(var, 0, sizeof(*var));
-
-    var->xres = par->x;
-    var->yres = par->y;
-    var->xres_virtual = var->xres;
-    var->yres_virtual = var->yres;
-    var->xoffset = 0;
-    var->yoffset = 0;
-    var->bits_per_pixel = par->bpp;
-    var->grayscale = 0;
-    var->transp.offset = 0;
-    var->transp.length = 0;
-    var->transp.msb_right = 0;
-    var->nonstd = 0;
-    var->activate = 0;
-    var->height = -1;
-    var->width = -1;
-    var->vmode = FB_VMODE_NONINTERLACED;
-    var->pixclock = 0;
-    var->sync = 0;
-    var->left_margin = 0;
-    var->right_margin = 0;
-    var->upper_margin = 0;
-    var->lower_margin = 0;
-    var->hsync_len = 0;
-    var->vsync_len = 0;
-
-    switch (var->bits_per_pixel) {
-
-	case 8:
-	    var->red.offset = 0;
-	    var->red.length = 8;
-	    var->green.offset = 0;
-	    var->green.length = 8;
-	    var->blue.offset = 0;
-	    var->blue.length = 8;
-	    var->transp.offset = 0;
-	    var->transp.length = 0;
-	    break;
-
-	case 16:	/* RGB 565 */
-	    var->red.offset = 11;
-	    var->red.length = 5;
-	    var->green.offset = 5;
-	    var->green.length = 6;
-	    var->blue.offset = 0;
-	    var->blue.length = 5;
-	    var->transp.offset = 0;
-	    var->transp.length = 0;
-	    break;
-    }
-
-    var->red.msb_right = 0;
-    var->green.msb_right = 0;
-    var->blue.msb_right = 0;
-    var->transp.msb_right = 0;
-
-    return 0;
+	switch (var->bits_per_pixel) {
+		case 8:
+			var->red.offset = 0;
+			var->red.length = 8;
+			var->green.offset = 0;
+			var->green.length = 8;
+			var->blue.offset = 0;
+			var->blue.length = 8;
+			var->transp.offset = 0;
+			var->transp.length = 0;
+			break;
+		case 16:	/* RGB 565 */
+			var->red.offset = 11;
+			var->red.length = 5;
+			var->green.offset = 5;
+			var->green.length = 6;
+			var->blue.offset = 0;
+			var->blue.length = 5;
+			var->transp.offset = 0;
+			var->transp.length = 0;
+			break;
+	}
+	return 0;
 }
 
-
-static void hitfb_get_par(void *par, struct fb_info_gen *info)
+static int hitfb_set_par(struct fb_info *info)
 {
-    *(struct hitfb_par *)par = fb_info.current_par;
-}
+	info->fix.visual = (info->var.bits_per_pixel == 8) ?
+		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 
-
-static void hitfb_set_par(const void *fb_par, struct fb_info_gen *info)
-{
-    const struct hitfb_par *par = fb_par;
-    fb_info.current_par = *par;
-    fb_info.current_par_valid = 1;
-}
-
-
-static int hitfb_getcolreg(unsigned regno, unsigned *red, unsigned *green,
-			   unsigned *blue, unsigned *transp,
-			   struct fb_info *info)
-{
-    if (regno > 255)
-	return 1;	
-
-    outw(regno<<8, HD64461_CPTRAR);
-    *red = inw(HD64461_CPTRDR)<<10;
-    *green = inw(HD64461_CPTRDR)<<10;
-    *blue = inw(HD64461_CPTRDR)<<10;
-    *transp = 0;
-    
-    return 0;
+	switch(info->var.bits_per_pixel) {
+		default:
+		case 8:
+			info->fix.line_length = info->var.xres;
+			break;
+		case 16:
+			info->fix.line_length = info->var.xres*2;
+			break;
+	}
+	return 0;
 }
 
-
 static int hitfb_setcolreg(unsigned regno, unsigned red, unsigned green,
 			   unsigned blue, unsigned transp,
 			   struct fb_info *info)
 {
-    if (regno > 255)
-	return 1;
+	if (regno > 255)
+		return 1;
     
-    outw(regno<<8, HD64461_CPTWAR);
-    outw(red>>10, HD64461_CPTWDR);
-    outw(green>>10, HD64461_CPTWDR);
-    outw(blue>>10, HD64461_CPTWDR);
+	outw(regno << 8, HD64461_CPTWAR);
+	outw(red >> 10, HD64461_CPTWDR);
+	outw(green >> 10, HD64461_CPTWDR);
+	outw(blue >> 10, HD64461_CPTWDR);
     
-    if(regno<16) {
-	switch(fb_info.current_par.bpp) {
+	if (regno < 16) {
+		switch(info->var.bits_per_pixel) {
 #ifdef FBCON_HAS_CFB16
-	case 16:
-	    ((u16 *)(fb_info.gen.info.pseudo_palette))[regno] =
-		((red   & 0xf800)      ) |
-		((green & 0xfc00) >>  5) |
-		((blue  & 0xf800) >> 11);
-	    break;
+		case 16:
+			((u16 *)(info->pseudo_palette))[regno] =
+					((red   & 0xf800)      ) |
+					((green & 0xfc00) >>  5) |
+					((blue  & 0xf800) >> 11);
+			break;
 #endif
+		}
 	}
-    }
-
-    return 0;
-}
-
-
-static int hitfb_pan_display(const struct fb_var_screeninfo *var,
-			     struct fb_info_gen *info)
-{
-    if (!fb_info.current_par_valid)
-	return -EINVAL;
-
-    return 0;
-}
-
-
-static int hitfb_blank(int blank_mode, struct fb_info_gen *info)
-{
-    if (!fb_info.current_par_valid)
-	return 1;
-
-    return 0;
-}
-
-
-static void hitfb_set_disp(const void *fb_par, struct display *disp,
-			    struct fb_info_gen *info)
-{
-    const struct hitfb_par *par = fb_par;
-
-    disp->scrollmode = SCROLL_YREDRAW;
-
-    switch(((struct hitfb_par *)par)->bpp) {
-#ifdef FBCON_HAS_CFB8
-    case 8:
-	disp->dispsw = &fbcon_cfb8;
-	break;
-#endif
-#ifdef FBCON_HAS_CFB16
-    case 16:
-	disp->dispsw = &fbcon_cfb16;
-	disp->dispsw_data = fb_info.gen.info.pseudo_palette;
-	break;
-#endif
-    default:
-	disp->dispsw = &fbcon_dummy;
-    }
+	return 0;
 }
 
-
-struct fbgen_hwswitch hitfb_switch = {
-    hitfb_detect,
-    hitfb_encode_fix,
-    hitfb_decode_var,
-    hitfb_encode_var,
-    hitfb_get_par,
-    hitfb_set_par,
-    hitfb_getcolreg,
-    hitfb_pan_display,
-    hitfb_blank,
-    hitfb_set_disp
-};
-
-
 static struct fb_ops hitfb_ops = {
-    owner:		THIS_MODULE,
-    fb_get_fix:		fbgen_get_fix,
-    fb_get_var:		fbgen_get_var,
-    fb_set_var:		fbgen_set_var,
-    fb_get_cmap:	fbgen_get_cmap,
-    fb_set_cmap:	fbgen_set_cmap,
-    fb_setcolreg:	hitfb_setcolreg,
-    fb_pan_display:	fbgen_pan_display,
-    fb_blank:		fbgen_blank,
+	owner:		THIS_MODULE,
+	fb_get_fix:	gen_get_fix,
+	fb_get_var:	gen_get_var,
+	fb_set_var:	gen_set_var,
+	fb_get_cmap:	gen_get_cmap,
+	fb_set_cmap:	gen_set_cmap,
+	fb_check_var:	hitfb_check_var,
+	fb_set_par:	hitfb_set_par,
+	fb_setcolreg:	hitfb_setcolreg,
 };
 
-
 int __init hitfb_init(void)
 {
-    strcpy(fb_info.gen.info.modename, "Hitachi HD64461");
-    fb_info.gen.info.node = NODEV;
-    fb_info.gen.info.flags = FBINFO_FLAG_DEFAULT;
-    fb_info.gen.info.fbops = &hitfb_ops;
-    fb_info.gen.info.disp = &fb_info.disp;
-    fb_info.gen.info.pseudo_palette = pseudo_palette;	
-    fb_info.gen.info.changevar = NULL;
-    fb_info.gen.info.switch_con = &fbgen_switch;
-    fb_info.gen.info.updatevar = &fbgen_update_var;
-    fb_info.gen.parsize = sizeof(struct hitfb_par);
-    fb_info.gen.fbhw = &hitfb_switch;
-    fb_info.gen.fbhw->detect();
-    fb_info.gen.info.screen_base = (void *)fb_info.hit_videobase;
- 
-    fbgen_get_var(&fb_info.disp.var, -1, &fb_info.gen.info);
-    fb_info.disp.var.activate = FB_ACTIVATE_NOW;
-    fbgen_do_set_var(&fb_info.disp.var, 1, &fb_info.gen);
-    fbgen_set_disp(-1, &fb_info.gen);
-    do_install_cmap(0, &fb_info.gen.info);
-    
-    if(register_framebuffer(&fb_info.gen.info)<0) return -EINVAL;
-    
-    printk(KERN_INFO "fb%d: %s frame buffer device\n",
-	   GET_FB_IDX(fb_info.gen.info.node), fb_info.gen.info.modename);
-    
-    return 0;
+	unsigned short lcdclor, ldr3, ldvntr;
+
+	hitfb_fix.smem_start = CONFIG_HD64461_IOBASE + 0x02000000;
+	hitfb_fix.smem_len = (MACH_HP680 || MACH_HP690) ? 1024*1024 : 512*1024;
+
+	lcdclor = inw(HD64461_LCDCLOR);
+	ldvntr = inw(HD64461_LDVNTR);
+	ldr3 = inw(HD64461_LDR3);
+
+	switch (ldr3&15) {
+		default:
+		case 4:
+			hitfb_var.bits_per_pixel = 8;
+			hitfb_var.xres = lcdclor;
+			break;
+		case 8:
+			hitfb_var.bits_per_pixel = 16;
+			hitfb_var.xres = lcdclor/2;
+			break;
+	}
+	hitfb_var.yres = ldvntr+1;
+
+	fb_info.node		= NODEV;
+	fb_info.fbops 		= &hitfb_ops;
+	fb_info.var 		= hitfb_var;
+	fb_info.fix 		= hitfb_fix;
+	fb_info.pseudo_palette 	= pseudo_palette;	
+	fb_info.flags 		= FBINFO_FLAG_DEFAULT;
+    	
+	strcpy(fb_info.modename, fb_info.fix.id);
+	fb_info.currcon = -1;
+	fb_info.disp = &disp;
+	fb_info.changevar = NULL;
+	fb_info.switch_con = gen_switch;
+	fb_info.updatevar = gen_update_var;
+	fb_info.screen_base = (void *) hitfb_fix.smem_start;
+
+	size = (fb_info.var.bits_per_pixel == 8) ? 256 : 16;
+	fb_alloc_cmap(&fb_info.cmap, size, 0); 	
+
+	gen_get_var(&fb_info.var, -1, &fb_info);
+    
+	if (register_framebuffer(&fb_info) < 0)
+		return -EINVAL;
+    
+	printk(KERN_INFO "fb%d: %s frame buffer device\n",
+			GET_FB_IDX(fb_info.node), fb_info.fix.id);
+	return 0;
 }
 
 
@@ -387,7 +205,6 @@
   hitfb_cleanup(void);
 }
 #endif
-
 
 /*
  * Local variables:

