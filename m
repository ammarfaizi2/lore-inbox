Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313187AbSDOTxU>; Mon, 15 Apr 2002 15:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313189AbSDOTxT>; Mon, 15 Apr 2002 15:53:19 -0400
Received: from www.transvirtual.com ([206.14.214.140]:35340 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S313187AbSDOTxH>; Mon, 15 Apr 2002 15:53:07 -0400
Date: Mon, 15 Apr 2002 12:52:55 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Dave Jones <davej@suse.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.7-dj4
In-Reply-To: <20020414212115.A10316@suse.de>
Message-ID: <Pine.LNX.4.10.10204151251460.1204-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 2.5.7-dj4
> o   Sync up with 2.5.8pre2 & pre3.
>     | dropped cyber2000fb changes  (James, please check)

Done. Here are the fixes. 

P.S 

    Linus when are you going to accept the fbdev changes?

diff -urN -X /home/jsimmons/dontdiff linux-2.5.7-dj4/drivers/video/Config.in linux/drivers/video/Config.in
--- linux-2.5.7-dj4/drivers/video/Config.in	Mon Apr 15 10:46:50 2002
+++ linux/drivers/video/Config.in	Mon Apr 15 11:35:26 2002
@@ -382,7 +382,8 @@
       fi
       if [ "$CONFIG_FB_NEOMAGIC" = "y" -o "$CONFIG_FB_VESA" = "y" -o \
 	   "$CONFIG_FB_FM2" = "y" -o "$CONFIG_FB_HIT" = "y" -o \
-	   "$CONFIG_FB_HP300" = "y" -o "$CONFIG_FB_Q40" = "y" ]; then
+	   "$CONFIG_FB_HP300" = "y" -o "$CONFIG_FB_Q40" = "y" -o \
+	   "$CONFIG_FB_ANAKIN" = "y" ]; then
 	 define_tristate CONFIG_FBCON_ACCEL y
       else
 	 if [ "$CONFIG_FB_NEOMAGIC" = "m" ]; then
diff -urN -X /home/jsimmons/dontdiff linux-2.5.7-dj4/drivers/video/anakinfb.c linux/drivers/video/anakinfb.c
--- linux-2.5.7-dj4/drivers/video/anakinfb.c	Mon Apr 15 10:46:50 2002
+++ linux/drivers/video/anakinfb.c	Mon Apr 15 11:33:58 2002
@@ -24,23 +24,33 @@
 #include <video/fbcon-cfb16.h>
 
 static u16 colreg[16];
-static int currcon = 0;
 static struct fb_info fb_info;
 static struct display display;
 
-static int
-anakinfb_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
-			u_int *transp, struct fb_info *info)
-{
-	if (regno > 15)
-		return 1;
+static struct fb_var_screeninfo anakinfb_var = {
+	xres:		400,
+	yres:		234,
+	xres_virtual:	400,
+	yres_virtual:	234,
+	bits_per_pixel:	16,
+	red:		{ 11, 5, 0 },
+	green:		{  5, 6, 0 }, 
+	blue:		{  0, 5, 0 },
+        activate:       FB_ACTIVATE_NOW,
+        height:         -1,
+        width:          -1,
+        vmode:          FB_VMODE_NONINTERLACED,
+};
 
-	*red = colreg[regno] & 0xf800;
-	*green = colreg[regno] & 0x7e0 << 5;
-	*blue = colreg[regno] & 0x1f << 11;
-	*transp = 0;
-	return 0;
-}
+static struct fb_fix_screeninfo anakinfb_fix = {
+	id:		"AnakinFB",
+	smem_start:	VGA_START,
+	smem_len:	VGA_SIZE,
+	type:		FB_TYPE_PACKED_PIXELS,
+	visual:		FB_VISUAL_TRUECOLOR,
+	line_length:	400*2,
+	accel:		FB_ACCEL_NONE,
+};
 
 static int
 anakinfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
@@ -54,160 +64,40 @@
 	return 0;
 }
 
-static int
-anakinfb_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info)
-{
-	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id, "AnakinFB");
-	fix->smem_start = VGA_START;
-	fix->smem_len = VGA_SIZE;
-	fix->type = FB_TYPE_PACKED_PIXELS;
-	fix->type_aux = 0;
-	fix->visual = FB_VISUAL_TRUECOLOR;
-	fix->xpanstep = 0;
-	fix->ypanstep = 0;
-	fix->ywrapstep = 0;
-        fix->line_length = 400 * 2;
-	fix->accel = FB_ACCEL_NONE;
-	return 0;
-}
-        
-static int
-anakinfb_get_var(struct fb_var_screeninfo *var, int con, struct fb_info *info)
-{
-	memset(var, 0, sizeof(struct fb_var_screeninfo));
-	var->xres = 400;
-	var->yres = 234;
-	var->xres_virtual = 400;
-	var->yres_virtual = 234;
-	var->xoffset = 0;
-	var->yoffset = 0;
-	var->bits_per_pixel = 16;
-	var->grayscale = 0;
-	var->red.offset = 11;
-	var->red.length = 5;
-	var->green.offset = 5;
-	var->green.length = 6;
-	var->blue.offset = 0;
-	var->blue.length = 5;
-	var->transp.offset = 0;
-	var->transp.length = 0;
-	var->nonstd = 0;
-	var->activate = FB_ACTIVATE_NOW;
-	var->height = -1;
-	var->width = -1;
-	var->pixclock = 0;
-	var->left_margin = 0;
-	var->right_margin = 0;
-	var->upper_margin = 0;
-	var->lower_margin = 0;
-	var->hsync_len = 0;
-	var->vsync_len = 0;
-	var->sync = 0;
-	var->vmode = FB_VMODE_NONINTERLACED;
-	return 0;
-}
-
-static int
-anakinfb_set_var(struct fb_var_screeninfo *var, int con, struct fb_info *info)
-{
-	return -EINVAL;
-}
-
-static int
-anakinfb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-			struct fb_info *info)
-{
-	if (con == currcon)
-		return fb_get_cmap(cmap, kspc, anakinfb_getcolreg, info);
-	else if (fb_display[con].cmap.len)
-		fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
-	else
-		fb_copy_cmap(fb_default_cmap(16), cmap, kspc ? 0 : 2);
-	return 0;
-}
-
-static int
-anakinfb_set_cmap(struct fb_cmap *cmap, int kspc, int con,
-			struct fb_info *info)
-{
-	int err;
-
-	if (!fb_display[con].cmap.len) {
-		if ((err = fb_alloc_cmap(&fb_display[con].cmap, 16, 0)))
-			return err;
-	}
-	if (con == currcon)
-		return fb_set_cmap(cmap, kspc, anakinfb_setcolreg, info);
-	else
-		fb_copy_cmap(cmap, &fb_display[con].cmap, kspc ? 0 : 1);
-	return 0;
-}
-
-static int
-anakinfb_switch_con(int con, struct fb_info *info)
-{ 
-	currcon = con;
-	return 0;
-
-}
-
-static int
-anakinfb_updatevar(int con, struct fb_info *info)
-{
-	return 0;
-}
-
-static void
-anakinfb_blank(int blank, struct fb_info *info)
-{
-	/*
-	 * TODO: use I2C to blank/unblank the screen
-	 */
-}
-
 static struct fb_ops anakinfb_ops = {
 	owner:		THIS_MODULE,
-	fb_get_fix:	anakinfb_get_fix,
-	fb_get_var:	anakinfb_get_var,
-	fb_set_var:	anakinfb_set_var,
-	fb_get_cmap:	anakinfb_get_cmap,
-	fb_set_cmap:	anakinfb_set_cmap,
+	fb_get_fix:	gen_get_fix,
+	fb_get_var:	gen_get_var,
+	fb_set_var:	gen_set_var,
+	fb_get_cmap:	gen_get_cmap,
+	fb_set_cmap:	gen_set_cmap,
+	fb_setcolreg:	anakinfb_setcolreg,
+	fb_fillrect:	cfb_fillrect,
+	fb_copyarea:	cfb_copyarea,
+	fb_imageblit:	cfb_imageblit,
 };
 
 int __init
 anakinfb_init(void)
 {
 	memset(&fb_info, 0, sizeof(struct fb_info));
-	strcpy(fb_info.modename, "AnakinFB");
-	fb_info.node = -1;
+	memset(&display, 0, sizeof(struct display));
+
+	strcpy(fb_info.modename, anakinfb_fix.id);
+	fb_info.node = fb_info.currcon = -1;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;
 	fb_info.fbops = &anakinfb_ops;
+	fb_info.var = anakinfb_var;
+	fb_info.fix = anakinfb_fix;
 	fb_info.disp = &display;
 	strcpy(fb_info.fontname, "VGA8x16");
 	fb_info.changevar = NULL;
-	fb_info.switch_con = &anakinfb_switch_con;
-	fb_info.updatevar = &anakinfb_updatevar;
-	fb_info.blank = &anakinfb_blank;
+	fb_info.switch_con = gen_switch_con;
+	fb_info.updatevar = gen_update_var;
+	fb_info.screen_base = ioremap(VGA_START, VGA_SIZE);
 
-	memset(&display, 0, sizeof(struct display));
-	anakinfb_get_var(&display.var, 0, &fb_info);
-	display.screen_base = ioremap(VGA_START, VGA_SIZE);
-	display.visual = FB_VISUAL_TRUECOLOR;
-	display.type = FB_TYPE_PACKED_PIXELS;
-	display.type_aux = 0;
-	display.ypanstep = 0;
-	display.ywrapstep = 0;
-	display.line_length = 400 * 2;
-	display.can_soft_blank = 1;
-	display.inverse = 0;
-
-#ifdef FBCON_HAS_CFB16
-	display.dispsw = &fbcon_cfb16;
-	display.dispsw_data = colreg;
-#else
-	display.dispsw = &fbcon_dummy;
-#endif
+	fb_alloc_cmap(&fb_info.cmap, 16, 0);
+	gen_set_disp(-1, &fb_info);
 
 	if (register_framebuffer(&fb_info) < 0)
 		return -EINVAL;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.7-dj4/drivers/video/clps711xfb.c linux/drivers/video/clps711xfb.c
--- linux-2.5.7-dj4/drivers/video/clps711xfb.c	Mon Apr 15 10:46:50 2002
+++ linux/drivers/video/clps711xfb.c	Mon Apr 15 11:49:45 2002
@@ -36,10 +36,7 @@
 #include <asm/hardware/clps7111.h>
 #include <asm/arch/syspld.h>
 
-static struct clps7111fb_info {
-	struct fb_info		fb;
-	int			currcon;
-} *cfb;
+static struct fb_info *cfb;
 
 #define CMAP_SIZE	16
 
@@ -92,32 +89,6 @@
 }
 		    
 /*
- * Set the colormap
- */
-static int
-clps7111fb_set_cmap(struct fb_cmap *cmap, int kspc, int con,
-		    struct fb_info *info)
-{
-	struct clps7111fb_info *cfb = (struct clps7111fb_info *)info;
-	struct fb_cmap *dcmap = &fb_display[con].cmap;
-	int err = 0;
-
-	/* no colormap allocated? */
-	if (!dcmap->len)
-		err = fb_alloc_cmap(dcmap, CMAP_SIZE, 0);
-
-	if (!err && con == cfb->currcon) {
-		err = fb_set_cmap(cmap, kspc, clps7111fb_setcolreg, &cfb->fb);
-		dcmap = &cfb->fb.cmap;
-	}
-
-	if (!err)
-		fb_copy_cmap(cmap, dcmap, kspc ? 0 : 1);
-
-	return err;
-}
-
-/*
  *    Set the User Defined Part of the Display
  */
 static int
@@ -134,19 +105,19 @@
 	if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
 		return -EINVAL;
 
-	if (cfb->fb.var.xres != var->xres)
+	if (info->var.xres != var->xres)
 		chgvar = 1;
-	if (cfb->fb.var.yres != var->yres)
+	if (info->var.yres != var->yres)
 		chgvar = 1;
-	if (cfb->fb.var.xres_virtual != var->xres_virtual)
+	if (info->var.xres_virtual != var->xres_virtual)
 		chgvar = 1;
-	if (cfb->fb.var.yres_virtual != var->yres_virtual)
+	if (info->var.yres_virtual != var->yres_virtual)
 		chgvar = 1;
-	if (cfb->fb.var.bits_per_pixel != var->bits_per_pixel)
+	if (info->var.bits_per_pixel != var->bits_per_pixel)
 		chgvar = 1;
 
 	if (con < 0) {
-		display = cfb->fb.disp;
+		display = info->disp;
 		chgvar = 0;
 	} else {
 		display = fb_display + con;
@@ -164,21 +135,21 @@
 	switch (var->bits_per_pixel) {
 #ifdef FBCON_HAS_MFB
 	case 1:
-		cfb->fb.fix.visual	= FB_VISUAL_MONO01;
+		info->fix.visual	= FB_VISUAL_MONO01;
 		display->dispsw		= &fbcon_mfb;
 		display->dispsw_data	= NULL;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB2
 	case 2:
-		cfb->fb.fix.visual	= FB_VISUAL_PSEUDOCOLOR;
+		info->fix.visual	= FB_VISUAL_PSEUDOCOLOR;
 		display->dispsw		= &fbcon_cfb2;
 		display->dispsw_data	= NULL;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB4
 	case 4:
-		cfb->fb.fix.visual	= FB_VISUAL_PSEUDOCOLOR;
+		info->fix.visual	= FB_VISUAL_PSEUDOCOLOR;
 		display->dispsw		= &fbcon_cfb4;
 		display->dispsw_data	= NULL;
 		break;
@@ -187,39 +158,38 @@
 		return -EINVAL;
 	}
 
-	display->next_line	= var->xres_virtual * var->bits_per_pixel / 8;
+	info->fix.line_length = var->xres_virtual * var->bits_per_pixel / 8;
 
-	cfb->fb.fix.line_length = display->next_line;
+	display->next_line = info->fix.line_length;
 
-	display->screen_base	= cfb->fb.screen_base;
-	display->line_length	= cfb->fb.fix.line_length;
-	display->visual		= cfb->fb.fix.visual;
-	display->type		= cfb->fb.fix.type;
-	display->type_aux	= cfb->fb.fix.type_aux;
-	display->ypanstep	= cfb->fb.fix.ypanstep;
-	display->ywrapstep	= cfb->fb.fix.ywrapstep;
+	display->line_length	= info->fix.line_length;
+	display->visual		= info->fix.visual;
+	display->type		= info->fix.type;
+	display->type_aux	= info->fix.type_aux;
+	display->ypanstep	= info->fix.ypanstep;
+	display->ywrapstep	= info->fix.ywrapstep;
 	display->can_soft_blank = 1;
 	display->inverse	= 0;
 
-	cfb->fb.var		= *var;
-	cfb->fb.var.activate	&= ~FB_ACTIVATE_ALL;
+	info->var		= *var;
+	info->var.activate	&= ~FB_ACTIVATE_ALL;
 
 	/*
 	 * Update the old var.  The fbcon drivers still use this.
 	 * Once they are using cfb->fb.var, this can be dropped.
 	 *                                      --rmk
 	 */
-	display->var		= cfb->fb.var;
+	display->var		= info->var;
 
 	/*
 	 * If we are setting all the virtual consoles, also set the
 	 * defaults used to create new consoles.
 	 */
 	if (var->activate & FB_ACTIVATE_ALL)
-		cfb->fb.disp->var = cfb->fb.var;
+		info->disp->var = info->var;
 
-	if (chgvar && info && cfb->fb.changevar)
-		cfb->fb.changevar(con);
+	if (chgvar && info && info->changevar)
+		info->changevar(con);
 
 	/*
 	 * LCDCON must only be changed while the LCD is disabled
@@ -236,95 +206,10 @@
 	clps_writel(lcdcon, LCDCON);
 	clps_writel(syscon | SYSCON1_LCDEN, SYSCON1);
 
-	fb_set_cmap(&cfb->fb.cmap, 1, clps7111fb_setcolreg, &cfb->fb);
-
-	return 0;
-}
-
-/*
- * Get the currently displayed virtual consoles colormap.
- */
-static int
-gen_get_cmap(struct fb_cmap *cmap, int kspc, int con, struct fb_info *info)
-{
-	fb_copy_cmap(&info->cmap, cmap, kspc ? 0 : 2);
-	return 0;
-}
-
-/*
- * Get the currently displayed virtual consoles fixed part of the display.
- */
-static int
-gen_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info)
-{
-	*fix = info->fix;
-	return 0;
-}
-
-/*
- * Get the current user defined part of the display.
- */
-static int
-gen_get_var(struct fb_var_screeninfo *var, int con, struct fb_info *info)
-{
-	*var = info->var;
-	return 0;
-}
-
-static struct fb_ops clps7111fb_ops = {
-	owner:		THIS_MODULE,
-	fb_set_var:	clps7111fb_set_var,
-	fb_set_cmap:	clps7111fb_set_cmap,
-	fb_get_fix:	gen_get_fix,
-	fb_get_var:	gen_get_var,
-	fb_get_cmap:	gen_get_cmap,
-};
-
-static int clps7111fb_switch(int con, struct fb_info *info)
-{
-	struct clps7111fb_info *cfb = (struct clps7111fb_info *)info;
-	struct display *disp;
-	struct fb_cmap *cmap;
-
-	if (cfb->currcon >= 0) {
-		disp = fb_display + cfb->currcon;
-
-		/*
-		 * Save the old colormap and video mode.
-		 */
-		disp->var = cfb->fb.var;
-		if (disp->cmap.len)
-			fb_copy_cmap(&cfb->fb.cmap, &disp->cmap, 0);
-	}
-
-	cfb->currcon = con;
-	disp = fb_display + con;
-
-	/*
-	 * Install the new colormap and change the video mode.  By default,
-	 * fbcon sets all the colormaps and video modes to the default
-	 * values at bootup.
-	 */
-	if (disp->cmap.len)
-		cmap = &disp->cmap;
-	else
-		cmap = fb_default_cmap(CMAP_SIZE);
-
-	fb_copy_cmap(cmap, &cfb->fb.cmap, 0);
-
-	cfb->fb.var = disp->var;
-	cfb->fb.var.activate = FB_ACTIVATE_NOW;
-
-	clps7111fb_set_var(&cfb->fb.var, con, &cfb->fb);
-
+	fb_set_cmap(info->cmap, 1, info);
 	return 0;
 }
 
-static int clps7111fb_updatevar(int con, struct fb_info *info)
-{
-	return -EINVAL;
-}
-
 static void clps7111fb_blank(int blank, struct fb_info *info)
 {
     	if (blank) {
@@ -371,6 +256,17 @@
 	}
 }
 
+static struct fb_ops clps7111fb_ops = {
+	owner:		THIS_MODULE,
+	fb_set_var:	clps7111fb_set_var,
+	fb_get_fix:	gen_get_fix,
+	fb_get_var:	gen_get_var,
+	fb_get_cmap:	gen_get_cmap,
+	fb_set_cmap:	gen_set_cmap,
+	fb_setcolreg:	clps7111fb_setcolreg,
+	fb_blank:	clps7111fb_blank,
+};
+
 static int 
 clps7111fb_proc_backlight_read(char *page, char **start, off_t off,
 		int count, int *eof, void *data)
@@ -421,7 +317,6 @@
 	return count;
 }
 
-
 int __init clps711xfb_init(void)
 {
 	int err = -ENOMEM;
@@ -435,31 +330,30 @@
 
 	cfb->currcon		= -1;
 
-	strcpy(cfb->fb.fix.id, "clps7111");
-	cfb->fb.screen_base	= (void *)PAGE_OFFSET;
-	cfb->fb.fix.smem_start	= PAGE_OFFSET;
-	cfb->fb.fix.smem_len	= 0x14000;
-	cfb->fb.fix.type	= FB_TYPE_PACKED_PIXELS;
-
-	cfb->fb.var.xres	 = 640;
-	cfb->fb.var.xres_virtual = 640;
-	cfb->fb.var.yres	 = 240;
-	cfb->fb.var.yres_virtual = 240;
-	cfb->fb.var.bits_per_pixel = 4;
-	cfb->fb.var.grayscale   = 1;
-	cfb->fb.var.activate	= FB_ACTIVATE_NOW;
-	cfb->fb.var.height	= -1;
-	cfb->fb.var.width	= -1;
-
-	cfb->fb.fbops		= &clps7111fb_ops;
-	cfb->fb.changevar	= NULL;
-	cfb->fb.switch_con	= clps7111fb_switch;
-	cfb->fb.updatevar	= clps7111fb_updatevar;
-	cfb->fb.blank		= clps7111fb_blank;
-	cfb->fb.flags		= FBINFO_FLAG_DEFAULT;
-	cfb->fb.disp		= (struct display *)(cfb + 1);
+	strcpy(cfb->fix.id, "clps7111");
+	cfb->screen_base	= (void *)PAGE_OFFSET;
+	cfb->fix.smem_start	= PAGE_OFFSET;
+	cfb->fix.smem_len	= 0x14000;
+	cfb->fix.type		= FB_TYPE_PACKED_PIXELS;
+
+	cfb->var.xres		= 640;
+	cfb->var.xres_virtual	= 640;
+	cfb->var.yres		= 240;
+	cfb->var.yres_virtual	= 240;
+	cfb->var.bits_per_pixel = 4;
+	cfb->var.grayscale	= 1;
+	cfb->var.activate	= FB_ACTIVATE_NOW;
+	cfb->var.height		= -1;
+	cfb->var.width		= -1;
+
+	cfb->fbops		= &clps7111fb_ops;
+	cfb->changevar		= NULL;
+	cfb->switch_con		= gen_switch;
+	cfb->updatevar		= gen_update_var;
+	cfb->flags		= FBINFO_FLAG_DEFAULT;
+	cfb->disp		= (struct display *)(cfb + 1);
 
-	fb_alloc_cmap(&cfb->fb.cmap, CMAP_SIZE, 0);
+	fb_alloc_cmap(&cfb->cmap, CMAP_SIZE, 0);
 
 	/* Register the /proc entries. */
 	clps7111fb_backlight_proc_entry = create_proc_entry("backlight", 0444,
@@ -498,15 +392,15 @@
 		clps_writeb(clps_readb(PDDR) | EDB_PD3_LCDBL, PDDR);
 	}
 
-	clps7111fb_set_var(&cfb->fb.var, -1, &cfb->fb);
-	err = register_framebuffer(&cfb->fb);
+	gen_set_var(&cfb->var, -1, &cfb);
+	err = register_framebuffer(&cfb);
 
 out:	return err;
 }
 
 static void __exit clps711xfb_exit(void)
 {
-	unregister_framebuffer(&cfb->fb);
+	unregister_framebuffer(&cfb);
 	kfree(cfb);
 
 	/*
diff -urN -X /home/jsimmons/dontdiff linux-2.5.7-dj4/drivers/video/cyber2000fb.c linux/drivers/video/cyber2000fb.c
--- linux-2.5.7-dj4/drivers/video/cyber2000fb.c	Mon Apr 15 10:46:50 2002
+++ linux/drivers/video/cyber2000fb.c	Mon Apr 15 12:23:26 2002
@@ -60,6 +60,7 @@
 struct cfb_info {
 	struct fb_info		fb;
 	struct display_switch	*dispsw;
+	struct display		*display;
 	struct pci_dev		*dev;
 	unsigned char 		*region;
 	unsigned char		*regs;
@@ -148,24 +149,24 @@
 	}
 }
 
-static void cyber2000_accel_setup(struct display *p)
+static void cyber2000_accel_setup(struct display *display)
 {
-	struct cfb_info *cfb = (struct cfb_info *)p->fb_info;
+	struct cfb_info *cfb = (struct cfb_info *)display->fb_info;
 
-	cfb->dispsw->setup(p);
+	cfb->dispsw->setup(display);
 }
 
 static void
-cyber2000_accel_bmove(struct display *p, int sy, int sx, int dy, int dx,
+cyber2000_accel_bmove(struct display *display, int sy, int sx, int dy, int dx,
 		      int height, int width)
 {
-	struct cfb_info *cfb = (struct cfb_info *)p->fb_info;
-	struct fb_var_screeninfo *var = &p->fb_info->var;
+	struct cfb_info *cfb = (struct cfb_info *)display->fb_info;
+	struct fb_var_screeninfo *var = &display->var;
 	u_long src, dst;
 	u_int fh, fw;
 	int cmd = CO_CMD_L_PATTERN_FGCOL;
 
-	fw    = fontwidth(p);
+	fw    = fontwidth(display);
 	sx    *= fw;
 	dx    *= fw;
 	width *= fw;
@@ -177,7 +178,7 @@
 		cmd |= CO_CMD_L_INC_LEFT;
 	}
 
-	fh     = fontheight(p);
+	fh     = fontheight(display);
 	sy     *= fh;
 	dy     *= fh;
 	height *= fh;
@@ -212,17 +213,17 @@
 }
 
 static void
-cyber2000_accel_clear(struct vc_data *conp, struct display *p, int sy, int sx,
-		      int height, int width)
+cyber2000_accel_clear(struct vc_data *conp, struct display *display, int sy,
+		      int sx, int height, int width)
 {
-	struct cfb_info *cfb = (struct cfb_info *)p->fb_info;
-	struct fb_var_screeninfo *var = &p->fb_info->var;
+	struct cfb_info *cfb = (struct cfb_info *)display->fb_info;
+	struct fb_var_screeninfo *var = &display->var;
 	u_long dst;
 	u_int fw, fh;
-	u32 bgx = attr_bgcol_ec(p, conp);
+	u32 bgx = attr_bgcol_ec(display, conp);
 
-	fw = fontwidth(p);
-	fh = fontheight(p);
+	fw = fontwidth(display);
+	fh = fontheight(display);
 
 	dst    = sx * fw + sy * var->xres_virtual * fh;
 	width  = width * fw - 1;
@@ -235,9 +236,8 @@
 	cyber2000fb_writew(height, CO_REG_HEIGHT,   cfb);
 
 	switch (var->bits_per_pixel) {
-	case 15:
 	case 16:
-		bgx = ((u16 *)p->dispsw_data)[bgx];
+		bgx = ((u16 *)display->dispsw_data)[bgx];
 	case 8:
 		cyber2000fb_writel(dst, CO_REG_DEST_PTR, cfb);
 		break;
@@ -245,7 +245,7 @@
 	case 24:
 		cyber2000fb_writel(dst * 3, CO_REG_DEST_PTR, cfb);
 		cyber2000fb_writeb(dst, CO_REG_X_PHASE, cfb);
-		bgx = ((u32 *)p->dispsw_data)[bgx];
+		bgx = ((u32 *)display->dispsw_data)[bgx];
 		break;
 	}
 
@@ -255,40 +255,40 @@
 }
 
 static void
-cyber2000_accel_putc(struct vc_data *conp, struct display *p, int c,
+cyber2000_accel_putc(struct vc_data *conp, struct display *display, int c,
 		     int yy, int xx)
 {
-	struct cfb_info *cfb = (struct cfb_info *)p->fb_info;
+	struct cfb_info *cfb = (struct cfb_info *)display->fb_info;
 
 	cyber2000_accel_wait(cfb);
-	cfb->dispsw->putc(conp, p, c, yy, xx);
+	cfb->dispsw->putc(conp, display, c, yy, xx);
 }
 
 static void
-cyber2000_accel_putcs(struct vc_data *conp, struct display *p,
+cyber2000_accel_putcs(struct vc_data *conp, struct display *display,
 		      const unsigned short *s, int count, int yy, int xx)
 {
-	struct cfb_info *cfb = (struct cfb_info *)p->fb_info;
+	struct cfb_info *cfb = (struct cfb_info *)display->fb_info;
 
 	cyber2000_accel_wait(cfb);
-	cfb->dispsw->putcs(conp, p, s, count, yy, xx);
+	cfb->dispsw->putcs(conp, display, s, count, yy, xx);
 }
 
-static void cyber2000_accel_revc(struct display *p, int xx, int yy)
+static void cyber2000_accel_revc(struct display *display, int xx, int yy)
 {
-	struct cfb_info *cfb = (struct cfb_info *)p->fb_info;
+	struct cfb_info *cfb = (struct cfb_info *)display->fb_info;
 
 	cyber2000_accel_wait(cfb);
-	cfb->dispsw->revc(p, xx, yy);
+	cfb->dispsw->revc(display, xx, yy);
 }
 
 static void
-cyber2000_accel_clear_margins(struct vc_data *conp, struct display *p,
+cyber2000_accel_clear_margins(struct vc_data *conp, struct display *display,
 			      int bottom_only)
 {
-	struct cfb_info *cfb = (struct cfb_info *)p->fb_info;
+	struct cfb_info *cfb = (struct cfb_info *)display->fb_info;
 
-	cfb->dispsw->clear_margins(conp, p, bottom_only);
+	cfb->dispsw->clear_margins(conp, display, bottom_only);
 }
 
 static struct display_switch fbcon_cyber_accel = {
@@ -310,6 +310,7 @@
 		      u_int transp, struct fb_info *info)
 {
 	struct cfb_info *cfb = (struct cfb_info *)info;
+	struct fb_var_screeninfo *var = &cfb->display->var;
 
 	if (regno >= NR_PALETTE)
 		return 1;
@@ -322,7 +323,7 @@
 	cfb->palette[regno].green = green;
 	cfb->palette[regno].blue  = blue;
 
-	switch (cfb->fb.var.bits_per_pixel) {
+	switch (var->bits_per_pixel) {
 #ifdef FBCON_HAS_CFB8
 	case 8:
 		cyber2000fb_writeb(regno, 0x3c8, cfb);
@@ -335,29 +336,29 @@
 #ifdef FBCON_HAS_CFB16
 	case 16:
 #ifndef CFB16_IS_CFB15
-		if (regno < 64) {
-			/* write green */
-			cyber2000fb_writeb(regno << 2, 0x3c8, cfb);
-			cyber2000fb_writeb(cfb->palette[regno >> 1].red, 0x3c9, cfb);
-			cyber2000fb_writeb(green, 0x3c9, cfb);
-			cyber2000fb_writeb(cfb->palette[regno >> 1].blue, 0x3c9, cfb);
-		}
-
-		if (regno < 32) {
-			/* write red,blue */
-			cyber2000fb_writeb(regno << 3, 0x3c8, cfb);
-			cyber2000fb_writeb(red, 0x3c9, cfb);
-			cyber2000fb_writeb(cfb->palette[regno << 1].green, 0x3c9, cfb);
-			cyber2000fb_writeb(blue, 0x3c9, cfb);
+		if (var->green.length == 6) {
+			if (regno < 64) {
+				/* write green */
+				cyber2000fb_writeb(regno << 2, 0x3c8, cfb);
+				cyber2000fb_writeb(cfb->palette[regno >> 1].red, 0x3c9, cfb);
+				cyber2000fb_writeb(green, 0x3c9, cfb);
+				cyber2000fb_writeb(cfb->palette[regno >> 1].blue, 0x3c9, cfb);
+			}
+
+			if (regno < 32) {
+				/* write red,blue */
+				cyber2000fb_writeb(regno << 3, 0x3c8, cfb);
+				cyber2000fb_writeb(red, 0x3c9, cfb);
+				cyber2000fb_writeb(cfb->palette[regno << 1].green, 0x3c9, cfb);
+				cyber2000fb_writeb(blue, 0x3c9, cfb);
+			}
+
+			if (regno < 16)
+				((u16 *)cfb->fb.pseudo_palette)[regno] =
+					regno | regno << 5 | regno << 11;
+			break;
 		}
-
-		if (regno < 16)
-			((u16 *)cfb->fb.pseudo_palette)[regno] =
-				regno | regno << 5 | regno << 11;
-		break;
 #endif
-
-	case 15:
 		if (regno < 32) {
 			cyber2000fb_writeb(regno << 3, 0x3c8, cfb);
 			cyber2000fb_writeb(red, 0x3c9, cfb);
@@ -397,7 +398,7 @@
 	 */
 	u_char	clock_mult;
 	u_char	clock_div;
-	u_char	visualid;
+	u_char	extseqmisc;
 	u_char	pixformat;
 	u_char	crtc_ofl;
 	u_char	crtc[19];
@@ -481,10 +482,10 @@
 	cyber2000fb_writeb(i, 0x3cf, cfb);
 
 	/* PLL registers */
-	cyber2000_grphw(DCLK_MULT, hw->clock_mult, cfb);
-	cyber2000_grphw(DCLK_DIV,  hw->clock_div, cfb);
-	cyber2000_grphw(MCLK_MULT, cfb->mclk_mult, cfb);
-	cyber2000_grphw(MCLK_DIV,  cfb->mclk_div, cfb);
+	cyber2000_grphw(EXT_DCLK_MULT, hw->clock_mult, cfb);
+	cyber2000_grphw(EXT_DCLK_DIV,  hw->clock_div, cfb);
+	cyber2000_grphw(EXT_MCLK_MULT, cfb->mclk_mult, cfb);
+	cyber2000_grphw(EXT_MCLK_DIV,  cfb->mclk_div, cfb);
 	cyber2000_grphw(0x90, 0x01, cfb);
 	cyber2000_grphw(0xb9, 0x80, cfb);
 	cyber2000_grphw(0xb9, 0x00, cfb);
@@ -501,10 +502,11 @@
 	cyber2000_grphw(0x14, hw->fetch, cfb);
 	cyber2000_grphw(0x15, ((hw->fetch >> 8) & 0x03) |
 			      ((hw->pitch >> 4) & 0x30), cfb);
-	cyber2000_grphw(0x77, hw->visualid, cfb);
+	cyber2000_grphw(EXT_SEQ_MISC, hw->extseqmisc, cfb);
 
-	/* make sure we stay in linear mode */
-	cyber2000_grphw(0x33, 0x0d, cfb);
+	cyber2000_grphw(EXT_BIU_MISC, EXT_BIU_MISC_LIN_ENABLE |
+				      EXT_BIU_MISC_COP_ENABLE |
+				      EXT_BIU_MISC_COP_BFC, cfb);
 
 	/*
 	 * Set up accelerator registers
@@ -519,9 +521,14 @@
 {
 	u_int base;
 
-	base = var->yoffset * var->xres_virtual + var->xoffset;
+	base = var->yoffset * var->xres_virtual * var->bits_per_pixel +
+		var->xoffset * var->bits_per_pixel;
 
-	base >>= 2;
+	/*
+	 * Convert to bytes and shift two extra bits because DAC
+	 * can only start on 4 byte aligned data.
+	 */
+	base >>= 5;
 
 	if (base >= 1 << 20)
 		return -EINVAL;
@@ -714,7 +721,7 @@
 	vco = ref_ps * best_div1 / best_mult;
 	if ((ref_ps == 40690) && (vco < 5556))
 		/* Set VFSEL when VCO > 180MHz (5.556 ps). */
-		hw->clock_div |= DCLK_DIV_VFSEL;
+		hw->clock_div |= EXT_DCLK_DIV_VFSEL;
 
 	return 0;
 }
@@ -738,31 +745,32 @@
 #ifdef FBCON_HAS_CFB8
 	case 8:	/* PSEUDOCOLOUR, 256 */
 		hw->pixformat		= PIXFORMAT_8BPP;
-		hw->visualid		= VISUALID_256;
+		hw->extseqmisc		= EXT_SEQ_MISC_8;
 		hw->pitch		= hw->width >> 3;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB16
-	case 16:/* DIRECTCOLOUR, 64k */
-#ifndef CFB16_IS_CFB15
+	case 16:
 		hw->pixformat		= PIXFORMAT_16BPP;
-		hw->visualid		= VISUALID_64K;
 		hw->pitch		= hw->width >> 2;
 		hw->palette_ctrl	|= 0x10;
-		break;
+
+#ifndef CFB16_IS_CFB15
+		/* DIRECTCOLOUR, 64k */
+		if (var->green.length == 6) {
+			hw->extseqmisc		= EXT_SEQ_MISC_16_RGB565;
+			break;
+		}
 #endif
-	case 15:/* DIRECTCOLOUR, 32k */
-		hw->pixformat		= PIXFORMAT_16BPP;
-		hw->visualid		= VISUALID_32K;
-		hw->pitch		= hw->width >> 2;
-		hw->palette_ctrl	|= 0x10;
+		/* DIRECTCOLOUR, 32k */
+		hw->extseqmisc		= EXT_SEQ_MISC_16_RGB555;
 		break;
 
 #endif
 #ifdef FBCON_HAS_CFB24
 	case 24:/* TRUECOLOUR, 16m */
 		hw->pixformat		= PIXFORMAT_24BPP;
-		hw->visualid		= VISUALID_16M;
+		hw->extseqmisc		= EXT_SEQ_MISC_24_RGB888;
 		hw->width		*= 3;
 		hw->pitch		= hw->width >> 3;
 		hw->palette_ctrl	|= 0x10;
@@ -807,8 +815,8 @@
 	 */
 	if (var->vmode & FB_VMODE_CONUPDATE) {
 		var->vmode |= FB_VMODE_YWRAP;
-		var->xoffset = cfb->fb.var.xoffset;
-		var->yoffset = cfb->fb.var.yoffset;
+		var->xoffset = cfb->display->var.xoffset;
+		var->yoffset = cfb->display->var.yoffset;
 	}
 
 	err = cyber2000fb_decode_var(var, (struct cfb_info *)info, &hw);
@@ -821,23 +829,26 @@
 	if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
 		return -EINVAL;
 
-	if (cfb->fb.var.xres != var->xres)
+	if (con < 0) {
+		display = cfb->fb.disp;
+		chgvar = 0;
+	} else {
+		display = fb_display + con;
+	}
+
+	if (display->var.xres != var->xres)
 		chgvar = 1;
-	if (cfb->fb.var.yres != var->yres)
+	if (display->var.yres != var->yres)
 		chgvar = 1;
-	if (cfb->fb.var.xres_virtual != var->xres_virtual)
+	if (display->var.xres_virtual != var->xres_virtual)
 		chgvar = 1;
-	if (cfb->fb.var.yres_virtual != var->yres_virtual)
+	if (display->var.yres_virtual != var->yres_virtual)
 		chgvar = 1;
-	if (cfb->fb.var.bits_per_pixel != var->bits_per_pixel)
+	if (display->var.bits_per_pixel != var->bits_per_pixel)
 		chgvar = 1;
 
-	if (con < 0) {
-		display = cfb->fb.disp;
+	if (con < 0)
 		chgvar = 0;
-	} else {
-		display = fb_display + con;
-	}
 
 	var->red.msb_right	= 0;
 	var->green.msb_right	= 0;
@@ -860,13 +871,10 @@
 		break;
 #endif
 #ifdef FBCON_HAS_CFB16
-	case 16:/* DIRECTCOLOUR, 64k */
-#ifndef CFB16_IS_CFB15
-		var->bits_per_pixel	= 15;
-		var->red.offset		= 11;
+	case 16:
+		var->bits_per_pixel	= 16;
 		var->red.length		= 5;
 		var->green.offset	= 5;
-		var->green.length	= 6;
 		var->blue.offset	= 0;
 		var->blue.length	= 5;
 
@@ -874,21 +882,18 @@
 		cfb->dispsw		= &fbcon_cfb16;
 		display->dispsw_data	= cfb->fb.pseudo_palette;
 		display->next_line	= var->xres_virtual * 2;
-		break;
+
+#ifndef CFB16_IS_CFB15
+		/* DIRECTCOLOUR, 64k */
+		if (var->green.length == 6) {
+			var->red.offset		= 11;
+			var->green.length	= 6;
+			break;
+		}
 #endif
-	case 15:/* DIRECTCOLOUR, 32k */
-		var->bits_per_pixel	= 15;
+		/* DIRECTCOLOUR, 32k */
 		var->red.offset		= 10;
-		var->red.length		= 5;
-		var->green.offset	= 5;
 		var->green.length	= 5;
-		var->blue.offset	= 0;
-		var->blue.length	= 5;
-
-		cfb->fb.fix.visual	= FB_VISUAL_DIRECTCOLOR;
-		cfb->dispsw		= &fbcon_cfb16;
-		display->dispsw_data	= cfb->fb.pseudo_palette;
-		display->next_line	= var->xres_virtual * 2;
 		break;
 #endif
 #ifdef FBCON_HAS_CFB24
@@ -928,23 +933,17 @@
 	display->ywrapstep	= cfb->fb.fix.ywrapstep;
 	display->can_soft_blank = 1;
 	display->inverse	= 0;
+	display->var		= *var;
+	display->var.activate	&= ~FB_ACTIVATE_ALL;
 
-	cfb->fb.var = *var;
-	cfb->fb.var.activate &= ~FB_ACTIVATE_ALL;
-
-	/*
-	 * Update the old var.  The fbcon drivers still use this.
-	 * Once they are using cfb->fb.var, this can be dropped.
-	 *					--rmk
-	 */
-	display->var = cfb->fb.var;
+	cfb->fb.var = display->var;
 
 	/*
 	 * If we are setting all the virtual consoles, also set the
 	 * defaults used to create new consoles.
 	 */
 	if (var->activate & FB_ACTIVATE_ALL)
-		cfb->fb.disp->var = cfb->fb.var;
+		cfb->fb.disp->var = display->var;
 
 	if (chgvar && info && cfb->fb.changevar)
 		cfb->fb.changevar(con);
@@ -974,18 +973,18 @@
 
 	if (var->xoffset > (var->xres_virtual - var->xres))
 		return -EINVAL;
-	if (y_bottom > cfb->fb.var.yres_virtual)
+	if (y_bottom > cfb->display->var.yres_virtual)
 		return -EINVAL;
 
 	if (cyber2000fb_update_start(cfb, var))
 		return -EINVAL;
 
-	cfb->fb.var.xoffset = var->xoffset;
-	cfb->fb.var.yoffset = var->yoffset;
+	cfb->display->var.xoffset = var->xoffset;
+	cfb->display->var.yoffset = var->yoffset;
 	if (var->vmode & FB_VMODE_YWRAP) {
-		cfb->fb.var.vmode |= FB_VMODE_YWRAP;
+		cfb->display->var.vmode |= FB_VMODE_YWRAP;
 	} else {
-		cfb->fb.var.vmode &= ~FB_VMODE_YWRAP;
+		cfb->display->var.vmode &= ~FB_VMODE_YWRAP;
 	}
 
 	return 0;
@@ -1005,56 +1004,13 @@
 	return cyber2000fb_update_start(cfb, &fb_display[con].var);
 }
 
-static int cyber2000fb_switch(int con, struct fb_info *info)
-{
-	struct cfb_info *cfb = (struct cfb_info *)info;
-	struct display *disp;
-	struct fb_cmap *cmap;
-
-	if (cfb->fb.currcon >= 0) {
-		disp = fb_display + cfb->fb.currcon;
-
-		/*
-		 * Save the old colormap and video mode.
-		 */
-		disp->var = cfb->fb.var;
-		if (disp->cmap.len)
-			fb_copy_cmap(&cfb->fb.cmap, &disp->cmap, 0);
-	}
-
-	cfb->fb.currcon = con;
-	disp = fb_display + con;
-
-	/*
-	 * Install the new colormap and change the video mode.  By default,
-	 * fbcon sets all the colormaps and video modes to the default
-	 * values at bootup.
-	 *
-	 * Really, we want to set the colourmap size depending on the
-	 * depth of the new video mode.  For now, we leave it at its
-	 * default 256 entry.
-	 */
-	if (disp->cmap.len)
-		cmap = &disp->cmap;
-	else
-		cmap = fb_default_cmap(1 << disp->var.bits_per_pixel);
-
-	fb_copy_cmap(cmap, &cfb->fb.cmap, 0);
-
-	cfb->fb.var = disp->var;
-	cfb->fb.var.activate = FB_ACTIVATE_NOW;
-
-	cyber2000fb_set_var(&cfb->fb.var, con, &cfb->fb);
-
-	return 0;
-}
-
 /*
  *    (Un)Blank the display.
  */
 static int cyber2000fb_blank(int blank, struct fb_info *info)
 {
 	struct cfb_info *cfb = (struct cfb_info *)info;
+	unsigned int sync = 0;
 	int i;
 
 	/*
@@ -1075,16 +1031,26 @@
      
 	switch (blank) {
 	case 4:	/* powerdown - both sync lines down */
-    		cyber2000_grphw(0x16, 0x05, cfb);
+		sync = EXT_SYNC_CTL_VS_0 | EXT_SYNC_CTL_HS_0;
 		break;	
 	case 3:	/* hsync off */
-    		cyber2000_grphw(0x16, 0x01, cfb);
+		sync = EXT_SYNC_CTL_VS_NORMAL | EXT_SYNC_CTL_HS_0;
 		break;	
 	case 2:	/* vsync off */
-    		cyber2000_grphw(0x16, 0x04, cfb);
-		break;	
+		sync = EXT_SYNC_CTL_VS_0 | EXT_SYNC_CTL_HS_NORMAL;
+		break;
+	case 1:	/* soft blank */
+		break;
+	default: /* unblank */
+		break;
+	}
+	cyber2000_grphw(EXT_SYNC_CTL, sync, cfb);
+
+	switch (blank) {
+	case 4:
+	case 3:
+	case 2:
 	case 1:	/* soft blank */
-		cyber2000_grphw(0x16, 0x00, cfb);
 		for (i = 0; i < NR_PALETTE; i++) {
 			cyber2000fb_writeb(i, 0x3c8, cfb);
 			cyber2000fb_writeb(0, 0x3c9, cfb);
@@ -1093,7 +1059,6 @@
 		}
 		break;
 	default: /* unblank */
-		cyber2000_grphw(0x16, 0x00, cfb);
 		for (i = 0; i < NR_PALETTE; i++) {
 			cyber2000fb_writeb(i, 0x3c8, cfb);
 			cyber2000fb_writeb(cfb->palette[i].red, 0x3c9, cfb);
@@ -1108,51 +1073,61 @@
 static struct fb_ops cyber2000fb_ops = {
 	owner:		THIS_MODULE,
 	fb_set_var:	cyber2000fb_set_var,
-	fb_set_cmap:	fbgen_set_cmap,
+	fb_setcolreg:	cyber2000fb_setcolreg,
 	fb_pan_display:	cyber2000fb_pan_display,
+	fb_blank:	cyber2000fb_blank,
 	fb_get_fix:	gen_get_fix,
 	fb_get_var:	gen_get_var,
 	fb_get_cmap:	gen_get_cmap,
-	fb_setcolreg:	cyber2000fb_setcolreg,
-	fb_blank:	cyber2000fb_blank,
+	fb_set_cmap:	gen_set_cmap,
 };
 
 /*
+ * This is the only "static" reference to the internal data structures
+ * of this driver.  It is here solely at the moment to support the other
+ * CyberPro modules external to this driver.
+ */
+static struct cfb_info		*int_cfb_info;
+
+/*
  * Enable access to the extended registers
  */
-static void cyber2000fb_enable_extregs(struct cfb_info *cfb)
+void cyber2000fb_enable_extregs(struct cfb_info *cfb)
 {
 	cfb->func_use_count += 1;
 
 	if (cfb->func_use_count == 1) {
 		int old;
 
-		old = cyber2000_grphr(FUNC_CTL, cfb);
-		cyber2000_grphw(FUNC_CTL, old | FUNC_CTL_EXTREGENBL, cfb);
+		old = cyber2000_grphr(EXT_FUNC_CTL, cfb);
+		old |= EXT_FUNC_CTL_EXTREGENBL;
+		cyber2000_grphw(EXT_FUNC_CTL, old, cfb);
 	}
 }
 
 /*
  * Disable access to the extended registers
  */
-static void cyber2000fb_disable_extregs(struct cfb_info *cfb)
+void cyber2000fb_disable_extregs(struct cfb_info *cfb)
 {
 	if (cfb->func_use_count == 1) {
 		int old;
 
-		old = cyber2000_grphr(FUNC_CTL, cfb);
-		cyber2000_grphw(FUNC_CTL, old & ~FUNC_CTL_EXTREGENBL, cfb);
+		old = cyber2000_grphr(EXT_FUNC_CTL, cfb);
+		old &= ~EXT_FUNC_CTL_EXTREGENBL;
+		cyber2000_grphw(EXT_FUNC_CTL, old, cfb);
 	}
 
-	cfb->func_use_count -= 1;
+	if (cfb->func_use_count == 0)
+		printk(KERN_ERR "disable_extregs: count = 0\n");
+	else
+		cfb->func_use_count -= 1;
 }
 
-/*
- * This is the only "static" reference to the internal data structures
- * of this driver.  It is here solely at the moment to support the other
- * CyberPro modules external to this driver.
- */
-static struct cfb_info		*int_cfb_info;
+void cyber2000fb_get_fb_var(struct cfb_info *cfb, struct fb_var_screeninfo *var)
+{
+	memcpy(var, &cfb->display->var, sizeof(struct fb_var_screeninfo));
+}
 
 /*
  * Attach a capture/tv driver to the core CyberX0X0 driver.
@@ -1186,6 +1161,9 @@
 
 EXPORT_SYMBOL(cyber2000fb_attach);
 EXPORT_SYMBOL(cyber2000fb_detach);
+EXPORT_SYMBOL(cyber2000fb_enable_extregs);
+EXPORT_SYMBOL(cyber2000fb_disable_extregs);
+EXPORT_SYMBOL(cyber2000fb_get_fb_var);
 
 /*
  * These parameters give
@@ -1207,143 +1185,60 @@
 };
 
 static char igs_regs[] __devinitdata = {
-					0x12, 0x00,	0x13, 0x00,
-					0x16, 0x00,
-			0x31, 0x00,	0x32, 0x00,
-	0x50, 0x00,	0x51, 0x00,	0x52, 0x00,	0x53, 0x00,
-	0x54, 0x00,	0x55, 0x00,	0x56, 0x00,	0x57, 0x01,
-	0x58, 0x00,	0x59, 0x00,	0x5a, 0x00,
-	0x70, 0x0b,					0x73, 0x30,
-	0x74, 0x0b,	0x75, 0x17,	0x76, 0x00,	0x7a, 0xc8
+	EXT_CRT_IRQ,		0,
+	EXT_CRT_TEST,		0,
+	EXT_SYNC_CTL,		0,
+	EXT_SEG_WRITE_PTR,	0,
+	EXT_SEG_READ_PTR,	0,
+	EXT_BIU_MISC,		EXT_BIU_MISC_LIN_ENABLE |
+				EXT_BIU_MISC_COP_ENABLE |
+				EXT_BIU_MISC_COP_BFC,
+	EXT_FUNC_CTL,		0,
+	CURS_H_START,		0,
+	CURS_H_START + 1,	0,
+	CURS_H_PRESET,		0,
+	CURS_V_START,		0,
+	CURS_V_START + 1,	0,
+	CURS_V_PRESET,		0,
+	CURS_CTL,		0,
+	EXT_ATTRIB_CTL,		EXT_ATTRIB_CTL_EXT,
+	EXT_OVERSCAN_RED,	0,
+	EXT_OVERSCAN_GREEN,	0,
+	EXT_OVERSCAN_BLUE,	0,
+
+	/* some of these are questionable when we have a BIOS */
+	EXT_MEM_CTL0,		EXT_MEM_CTL0_7CLK |
+				EXT_MEM_CTL0_RAS_1 |
+				EXT_MEM_CTL0_MULTCAS,
+	EXT_HIDDEN_CTL1,	0x30,
+	EXT_FIFO_CTL,		0x0b,
+	EXT_FIFO_CTL + 1,	0x17,
+	0x76,			0x00,
+	EXT_HIDDEN_CTL4,	0xc8
 };
 
 /*
- * We need to wake up the CyberPro, and make sure its in linear memory
- * mode.  Unfortunately, this is specific to the platform and card that
- * we are running on.
- *
- * On x86 and ARM, should we be initialising the CyberPro first via the
- * IO registers, and then the MMIO registers to catch all cases?  Can we
- * end up in the situation where the chip is in MMIO mode, but not awake
- * on an x86 system?
- *
- * Note that on the NetWinder, the firmware automatically detects the
- * type, width and size, and leaves this in extended registers 0x71 and
- * 0x72 for us.
+ * Initialise the CyberPro hardware.  On the CyberPro5XXXX,
+ * ensure that we're using the correct PLL (5XXX's may be
+ * programmed to use an additional set of PLLs.)
  */
-static inline void cyberpro_init_hw(struct cfb_info *cfb, int at_boot)
+static void cyberpro_init_hw(struct cfb_info *cfb)
 {
 	int i;
 
-	/*
-	 * Wake up the CyberPro.
-	 */
-#ifdef __sparc__
-#ifdef __sparc_v9__
-#error "You loose, consult DaveM."
-#else
-	/*
-	 * SPARC does not have an "outb" instruction, so we generate
-	 * I/O cycles storing into a reserved memory space at
-	 * physical address 0x3000000
-	 */
-	{
-		unsigned char *iop;
-
-		iop = ioremap(0x3000000, 0x5000);
-		if (iop == NULL) {
-			prom_printf("iga5000: cannot map I/O\n");
-			return -ENOMEM;
-		}
-
-		writeb(0x18, iop + 0x46e8);
-		writeb(0x01, iop + 0x102);
-		writeb(0x08, iop + 0x46e8);
-		writeb(0x33, iop + 0x3ce);
-		writeb(0x01, iop + 0x3cf);
-
-		iounmap((void *)iop);
-	}
-#endif
-
-	if (at_boot) {
-		/*
-		 * Use mclk from BIOS.  Only read this if we're
-		 * initialising this card for the first time.
-		 * FIXME: what about hotplug?
-		 */
-		cfb->mclk_mult = cyber2000_grphr(MCLK_MULT, cfb);
-		cfb->mclk_div  = cyber2000_grphr(MCLK_DIV, cfb);
-	}
-#endif
-#if defined(__i386__) || defined(__x86_64__) || defined(__mips__)
-	/*
-	 * x86 and MIPS are simple, we just do regular
-	 * outb's instead of cyber2000fb_writeb.
-	 */
-	outb(0x18, 0x46e8);
-	outb(0x01, 0x102);
-	outb(0x08, 0x46e8);
-	outb(0x33, 0x3ce);
-	outb(0x01, 0x3cf);
-
-	if (at_boot) {
-		/*
-		 * Use mclk from BIOS.  Only read this if we're
-		 * initialising this card for the first time.
-		 * FIXME: what about hotplug?
-		 */
-		cfb->mclk_mult = cyber2000_grphr(MCLK_MULT, cfb);
-		cfb->mclk_div  = cyber2000_grphr(MCLK_DIV, cfb);
-	}
-#endif
-#ifdef __arm__
-	cyber2000fb_writeb(0x18, 0x46e8, cfb);
-	cyber2000fb_writeb(0x01, 0x102, cfb);
-	cyber2000fb_writeb(0x08, 0x46e8, cfb);
-	cyber2000fb_writeb(0x33, 0x3ce, cfb);
-	cyber2000fb_writeb(0x01, 0x3cf, cfb);
-
-	/*
-	 * MCLK on the NetWinder and the Shark is fixed at 75MHz
-	 */
-	cfb->mclk_mult = 0xdb;
-	cfb->mclk_div  = 0x54;
-#endif
-
-	/*
-	 * Initialise the CyberPro
-	 */
 	for (i = 0; i < sizeof(igs_regs); i += 2)
 		cyber2000_grphw(igs_regs[i], igs_regs[i+1], cfb);
 
-	if (at_boot) {
-		/*
-		 * get the video RAM size and width from the VGA register.
-		 * This should have been already initialised by the BIOS,
-		 * but if it's garbage, claim default 1MB VRAM (woody)
-		 */
-		cfb->mem_ctl1 = cyber2000_grphr(MEM_CTL1, cfb);
-		cfb->mem_ctl2 = cyber2000_grphr(MEM_CTL2, cfb);
-	} else {
-		/*
-		 * Reprogram the MEM_CTL1 and MEM_CTL2 registers
-		 */
-		cyber2000_grphw(MEM_CTL1, cfb->mem_ctl1, cfb);
-		cyber2000_grphw(MEM_CTL2, cfb->mem_ctl2, cfb);
+	if (cfb->fb.fix.accel == FB_ACCEL_IGS_CYBER5000) {
+		unsigned char val;
+		cyber2000fb_writeb(0xba, 0x3ce, cfb);
+		val = cyber2000fb_readb(0x3cf, cfb) & 0x80;
+		cyber2000fb_writeb(val, 0x3cf, cfb);
 	}
-
-	/*
-	 * Ensure thatwe are using the correct PLL.
-	 * (CyberPro 5000's may be programmed to use
-	 * an additional set of PLLs.
-	 */
-	cyber2000fb_writeb(0xba, 0x3ce, cfb);
-	cyber2000fb_writeb(cyber2000fb_readb(0x3cf, cfb) & 0x80, 0x3cf, cfb);
 }
 
 static struct cfb_info * __devinit
-cyberpro_alloc_fb_info(struct pci_dev *dev, const struct pci_device_id *id, char *name)
+cyberpro_alloc_fb_info(unsigned int id, char *name)
 {
 	struct cfb_info *cfb;
 
@@ -1355,10 +1250,7 @@
 
 	memset(cfb, 0, sizeof(struct cfb_info) + sizeof(struct display));
 
-	cfb->fb.currcon		= -1;
-	cfb->dev		= dev;
-
-	if (id->driver_data == FB_ACCEL_IGS_CYBER5000)
+	if (id == ID_CYBERPRO_5000)
 		cfb->ref_ps	= 40690; // 24.576 MHz
 	else
 		cfb->ref_ps	= 69842; // 14.31818 MHz (69841?)
@@ -1367,7 +1259,7 @@
 	cfb->divisors[1]	= 2;
 	cfb->divisors[2]	= 4;
 
-	if (id->driver_data == FB_ACCEL_IGS_CYBER2000)
+	if (id == ID_CYBERPRO_2000)
 		cfb->divisors[3] = 8;
 	else
 		cfb->divisors[3] = 6;
@@ -1379,7 +1271,24 @@
 	cfb->fb.fix.xpanstep	= 0;
 	cfb->fb.fix.ypanstep	= 1;
 	cfb->fb.fix.ywrapstep	= 0;
-	cfb->fb.fix.accel	= id->driver_data;
+
+	switch (id) {
+	case ID_IGA_1682:
+		cfb->fb.fix.accel = 0;
+		break;
+
+	case ID_CYBERPRO_2000:
+		cfb->fb.fix.accel = FB_ACCEL_IGS_CYBER2000;
+		break;
+
+	case ID_CYBERPRO_2010:
+		cfb->fb.fix.accel = FB_ACCEL_IGS_CYBER2010;
+		break;
+
+	case ID_CYBERPRO_5000:
+		cfb->fb.fix.accel = FB_ACCEL_IGS_CYBER5000;
+		break;
+	}
 
 	cfb->fb.var.nonstd	= 0;
 	cfb->fb.var.activate	= FB_ACTIVATE_NOW;
@@ -1392,9 +1301,10 @@
 
 	cfb->fb.fbops		= &cyber2000fb_ops;
 	cfb->fb.changevar	= NULL;
-	cfb->fb.switch_con	= cyber2000fb_switch;
+	cfb->fb.switch_con	= gen_switch;
 	cfb->fb.updatevar	= cyber2000fb_updatevar;
 	cfb->fb.flags		= FBINFO_FLAG_DEFAULT;
+	cfb->fb.node		= NODEV;
 	cfb->fb.disp		= (struct display *)(cfb + 1);
 	cfb->fb.pseudo_palette	= (void *)(cfb->fb.disp + 1);
 
@@ -1443,55 +1353,43 @@
 	return 0;
 }
 
-static int __devinit
-cyberpro_probe(struct pci_dev *dev, const struct pci_device_id *id)
+/*
+ * The CyberPro chips can be placed on many different bus types.
+ * This probe function is common to all bus types.  The bus-specific
+ * probe function is expected to have:
+ *  - enabled access to the linear memory region
+ *  - memory mapped access to the registers
+ *  - initialised mem_ctl1 and mem_ctl2 appropriately.
+ */
+static int __devinit cyberpro_common_probe(struct cfb_info *cfb)
 {
-	struct cfb_info *cfb;
-	u_int h_sync, v_sync;
 	u_long smem_size;
-	char name[16];
+	u_int h_sync, v_sync;
 	int err;
 
-	sprintf(name, "CyberPro%4X", id->device);
-
-	err = pci_enable_device(dev);
-	if (err)
-		return err;
-
-	err = pci_request_regions(dev, name);
-	if (err)
-		return err;
-
-	err = -ENOMEM;
-	cfb = cyberpro_alloc_fb_info(dev, id, name);
-	if (!cfb)
-		goto failed_release;
-
-	cfb->region = ioremap(pci_resource_start(dev, 0),
-			      pci_resource_len(dev, 0));
-	if (!cfb->region)
-		goto failed_ioremap;
-
-	cfb->regs = cfb->region + MMIO_OFFSET;
-
-	cyberpro_init_hw(cfb, 1);
+	/*
+	 * Get the video RAM size and width from the VGA register.
+	 * This should have been already initialised by the BIOS,
+	 * but if it's garbage, claim default 1MB VRAM (woody)
+	 */
+	cfb->mem_ctl1 = cyber2000_grphr(EXT_MEM_CTL1, cfb);
+	cfb->mem_ctl2 = cyber2000_grphr(EXT_MEM_CTL2, cfb);
 
+	/*
+	 * Determine the size of the memory.
+	 */
 	switch (cfb->mem_ctl2 & MEM_CTL2_SIZE_MASK) {
 	case MEM_CTL2_SIZE_4MB:	smem_size = 0x00400000; break;
 	case MEM_CTL2_SIZE_2MB:	smem_size = 0x00200000; break;
+	case MEM_CTL2_SIZE_1MB: smem_size = 0x00100000; break;
 	default:		smem_size = 0x00100000; break;
 	}
 
-	/*
-	 * Hmm, we _need_ a portable way of finding the address for
-	 * the remap stuff, both for mmio and for smem.
-	 */
-	cfb->fb.fix.mmio_start = pci_resource_start(dev, 0) + MMIO_OFFSET;
-	cfb->fb.fix.smem_start = pci_resource_start(dev, 0);
-	cfb->fb.fix.mmio_len   = MMIO_SIZE;
 	cfb->fb.fix.smem_len   = smem_size;
+	cfb->fb.fix.mmio_len   = MMIO_SIZE;
 	cfb->fb.screen_base    = cfb->region;
 
+	err = -EINVAL;
 	if (!fb_find_mode(&cfb->fb.var, &cfb->fb, NULL, NULL, 0,
 	    		  &cyber2000fb_default_mode, 8)) {
 		printk("%s: no valid mode found\n", cfb->fb.fix.id);
@@ -1518,13 +1416,210 @@
 	v_sync = h_sync / (cfb->fb.var.yres + cfb->fb.var.upper_margin +
 		 cfb->fb.var.lower_margin + cfb->fb.var.vsync_len);
 
-	printk(KERN_INFO "%s: %dkB VRAM, using %dx%d, %d.%03dkHz, %dHz\n",
+	printk(KERN_INFO "%s: %dKiB VRAM, using %dx%d, %d.%03dkHz, %dHz\n",
 		cfb->fb.fix.id, cfb->fb.fix.smem_len >> 10,
 		cfb->fb.var.xres, cfb->fb.var.yres,
 		h_sync / 1000, h_sync % 1000, v_sync);
 
 	err = register_framebuffer(&cfb->fb);
-	if (err < 0)
+
+failed:
+	return err;
+}
+
+static void cyberpro_common_resume(struct cfb_info *cfb)
+{
+	cyberpro_init_hw(cfb);
+
+	/*
+	 * Reprogram the MEM_CTL1 and MEM_CTL2 registers
+	 */
+	cyber2000_grphw(EXT_MEM_CTL1, cfb->mem_ctl1, cfb);
+	cyber2000_grphw(EXT_MEM_CTL2, cfb->mem_ctl2, cfb);
+
+	/*
+	 * Restore the old video mode and the palette.
+	 * We also need to tell fbcon to redraw the console.
+	 */
+	cfb->fb.var.activate = FB_ACTIVATE_NOW;
+	cyber2000fb_set_var(&cfb->fb.var, -1, &cfb->fb);
+}
+
+#ifdef CONFIG_ARCH_SHARK
+
+#include <asm/arch/hardware.h>
+
+static int __devinit
+cyberpro_vl_probe(void)
+{
+	struct cfb_info *cfb;
+	int err = -ENOMEM;
+
+	if (!request_mem_region(FB_START,FB_SIZE,"CyberPro2010")) return err;
+
+	cfb = cyberpro_alloc_fb_info(ID_CYBERPRO_2010, "CyberPro2010");
+	if (!cfb)
+		goto failed_release;
+
+	cfb->dev = NULL;
+	cfb->region = ioremap(FB_START,FB_SIZE);
+	if (!cfb->region)
+		goto failed_ioremap;
+
+	cfb->regs = cfb->region + MMIO_OFFSET;
+	cfb->fb.fix.mmio_start = FB_START + MMIO_OFFSET;
+	cfb->fb.fix.smem_start = FB_START;
+
+	/*
+	 * Bring up the hardware.  This is expected to enable access
+	 * to the linear memory region, and allow access to the memory
+	 * mapped registers.  Also, mem_ctl1 and mem_ctl2 must be
+	 * initialised.
+	 */
+	cyber2000fb_writeb(0x18, 0x46e8, cfb);
+	cyber2000fb_writeb(0x01, 0x102, cfb);
+	cyber2000fb_writeb(0x08, 0x46e8, cfb);
+	cyber2000fb_writeb(EXT_BIU_MISC, 0x3ce, cfb);
+	cyber2000fb_writeb(EXT_BIU_MISC_LIN_ENABLE, 0x3cf, cfb);
+
+	cfb->mclk_mult = 0xdb;
+	cfb->mclk_div  = 0x54;
+
+	cyberpro_init_hw(cfb);
+
+	err = cyberpro_common_probe(cfb);
+	if (err)
+		goto failed;
+
+	if (int_cfb_info == NULL)
+		int_cfb_info = cfb;
+
+	return 0;
+
+failed:
+	iounmap(cfb->region);
+failed_ioremap:
+	cyberpro_free_fb_info(cfb);
+failed_release:
+	release_mem_region(FB_START,FB_SIZE);
+
+	return err;
+}
+#endif /* CONFIG_ARCH_SHARK */
+
+/*
+ * PCI specific support.
+ */
+#ifdef CONFIG_PCI
+/*
+ * We need to wake up the CyberPro, and make sure its in linear memory
+ * mode.  Unfortunately, this is specific to the platform and card that
+ * we are running on.
+ *
+ * On x86 and ARM, should we be initialising the CyberPro first via the
+ * IO registers, and then the MMIO registers to catch all cases?  Can we
+ * end up in the situation where the chip is in MMIO mode, but not awake
+ * on an x86 system?
+ */
+static int cyberpro_pci_enable_mmio(struct cfb_info *cfb)
+{
+#if defined(__sparc_v9__)
+#error "You loose, consult DaveM."
+#elif defined(__sparc__)
+	/*
+	 * SPARC does not have an "outb" instruction, so we generate
+	 * I/O cycles storing into a reserved memory space at
+	 * physical address 0x3000000
+	 */
+	unsigned char *iop;
+
+	iop = ioremap(0x3000000, 0x5000);
+	if (iop == NULL) {
+		prom_printf("iga5000: cannot map I/O\n");
+		return -ENOMEM;
+	}
+
+	writeb(0x18, iop + 0x46e8);
+	writeb(0x01, iop + 0x102);
+	writeb(0x08, iop + 0x46e8);
+	writeb(EXT_BIU_MISC, iop + 0x3ce);
+	writeb(EXT_BIU_MISC_LIN_ENABLE, iop + 0x3cf);
+
+	iounmap((void *)iop);
+#else
+	/*
+	 * Most other machine types are "normal", so
+	 * we use the standard IO-based wakeup.
+	 */
+	outb(0x18, 0x46e8);
+	outb(0x01, 0x102);
+	outb(0x08, 0x46e8);
+	outb(EXT_BIU_MISC, 0x3ce);
+	outb(EXT_BIU_MISC_LIN_ENABLE, 0x3cf);
+#endif
+	return 0;
+}
+
+static int __devinit
+cyberpro_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	struct cfb_info *cfb;
+	char name[16];
+	int err;
+
+	sprintf(name, "CyberPro%4X", id->device);
+
+	err = pci_enable_device(dev);
+	if (err)
+		return err;
+
+	err = pci_request_regions(dev, name);
+	if (err)
+		return err;
+
+	err = -ENOMEM;
+	cfb = cyberpro_alloc_fb_info(id->driver_data, name);
+	if (!cfb)
+		goto failed_release;
+
+	cfb->dev = dev;
+	cfb->region = ioremap(pci_resource_start(dev, 0),
+			      pci_resource_len(dev, 0));
+	if (!cfb->region)
+		goto failed_ioremap;
+
+	cfb->regs = cfb->region + MMIO_OFFSET;
+	cfb->fb.fix.mmio_start = pci_resource_start(dev, 0) + MMIO_OFFSET;
+	cfb->fb.fix.smem_start = pci_resource_start(dev, 0);
+
+	/*
+	 * Bring up the hardware.  This is expected to enable access
+	 * to the linear memory region, and allow access to the memory
+	 * mapped registers.  Also, mem_ctl1 and mem_ctl2 must be
+	 * initialised.
+	 */
+	err = cyberpro_pci_enable_mmio(cfb);
+	if (err)
+		goto failed;
+
+	/*
+	 * Use MCLK from BIOS. FIXME: what about hotplug?
+	 */
+#ifndef __arm__
+	cfb->mclk_mult = cyber2000_grphr(EXT_MCLK_MULT, cfb);
+	cfb->mclk_div  = cyber2000_grphr(EXT_MCLK_DIV, cfb);
+#else
+	/*
+	 * MCLK on the NetWinder and the Shark is fixed at 75MHz
+	 */
+	cfb->mclk_mult = 0xdb;
+	cfb->mclk_div  = 0x54;
+#endif
+
+	cyberpro_init_hw(cfb);
+
+	err = cyberpro_common_probe(cfb);
+	if (err)
 		goto failed;
 
 	/*
@@ -1546,7 +1641,7 @@
 	return err;
 }
 
-static void __devexit cyberpro_remove(struct pci_dev *dev)
+static void __devexit cyberpro_pci_remove(struct pci_dev *dev)
 {
 	struct cfb_info *cfb = pci_get_drvdata(dev);
 
@@ -1575,7 +1670,7 @@
 	}
 }
 
-static int cyberpro_suspend(struct pci_dev *dev, u32 state)
+static int cyberpro_pci_suspend(struct pci_dev *dev, u32 state)
 {
 	return 0;
 }
@@ -1583,42 +1678,42 @@
 /*
  * Re-initialise the CyberPro hardware
  */
-static int cyberpro_resume(struct pci_dev *dev)
+static int cyberpro_pci_resume(struct pci_dev *dev)
 {
 	struct cfb_info *cfb = pci_get_drvdata(dev);
 
 	if (cfb) {
-		cyberpro_init_hw(cfb, 0);
-
-		/*
-		 * Restore the old video mode and the palette.
-		 * We also need to tell fbcon to redraw the console.
-		 */
-		cfb->fb.var.activate = FB_ACTIVATE_NOW;
-		cyber2000fb_set_var(&cfb->fb.var, -1, &cfb->fb);
+		cyberpro_pci_enable_mmio(cfb);
+		cyberpro_common_resume(cfb);
 	}
 
 	return 0;
 }
 
 static struct pci_device_id cyberpro_pci_table[] __devinitdata = {
+// Not yet
+//	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_1682,
+//		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_IGA_1682 },
 	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_2000,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_IGS_CYBER2000 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_CYBERPRO_2000 },
 	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_2010,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_IGS_CYBER2010 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_CYBERPRO_2010 },
 	{ PCI_VENDOR_ID_INTERG, PCI_DEVICE_ID_INTERG_5000,
-		PCI_ANY_ID, PCI_ANY_ID, 0, 0, FB_ACCEL_IGS_CYBER5000 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, ID_CYBERPRO_5000 },
 	{ 0, }
 };
 
+MODULE_DEVICE_TABLE(pci,cyberpro_pci_table);
+
 static struct pci_driver cyberpro_driver = {
 	name:		"CyberPro",
-	probe:		cyberpro_probe,
-	remove:		__devexit_p(cyberpro_remove),
-	suspend:	cyberpro_suspend,
-	resume:		cyberpro_resume,
+	probe:		cyberpro_pci_probe,
+	remove:		__devexit_p(cyberpro_pci_remove),
+	suspend:	cyberpro_pci_suspend,
+	resume:		cyberpro_pci_resume,
 	id_table:	cyberpro_pci_table
 };
+#endif
 
 /*
  * I don't think we can use the "module_init" stuff here because
@@ -1627,7 +1722,19 @@
  */
 int __init cyber2000fb_init(void)
 {
-	return pci_module_init(&cyberpro_driver);
+	int ret = -1, err = -ENODEV;
+#ifdef CONFIG_ARCH_SHARK
+	err = cyberpro_vl_probe();
+	if (!err) {
+		ret = err;
+		MOD_INC_USE_COUNT;
+	}
+#endif
+	err = pci_module_init(&cyberpro_driver);
+	if (!err)
+		ret = err;
+
+	return ret ? err : 0;
 }
 
 static void __exit cyberpro_exit(void)
@@ -1642,5 +1749,4 @@
 
 MODULE_AUTHOR("Russell King");
 MODULE_DESCRIPTION("CyberPro 2000, 2010 and 5000 framebuffer driver");
-MODULE_DEVICE_TABLE(pci,cyberpro_pci_table);
 MODULE_LICENSE("GPL");
diff -urN -X /home/jsimmons/dontdiff linux-2.5.7-dj4/drivers/video/hgafb.c linux/drivers/video/hgafb.c
--- linux-2.5.7-dj4/drivers/video/hgafb.c	Mon Apr 15 10:46:50 2002
+++ linux/drivers/video/hgafb.c	Mon Apr 15 12:34:57 2002
@@ -387,44 +387,6 @@
  * ------------------------------------------------------------------------- */
 
 /**
- *	hga_get_fix - get the fixed part of the display
- *	@fix:struct fb_fix_screeninfo to fill in
- *	@con:unused
- *	@info:pointer to fb_info object containing info for current hga board
- *
- *	This wrapper function copies @info->fix to @fix.
- *	A zero is returned on success and %-EINVAL for failure.
- */
-
-int hga_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info)
-{
-	CHKINFO(-EINVAL);
-	DPRINTK("hga_get_fix: con:%d, info:%x, fb_info:%x\n", con, (unsigned)info, (unsigned)&fb_info);
-
-	*fix = info->fix;
-	return 0;
-}
-
-/**
- *	hga_get_var - get the user defined part of the display
- *	@var:struct fb_var_screeninfo to fill in
- *	@con:unused
- *	@info:pointer to fb_info object containing info for current hga board
- *
- *	This wrapper function copies @info->var to @var.
- *	A zero is returned on success and %-EINVAL for failure.
- */
-
-int hga_get_var(struct fb_var_screeninfo *var, int con, struct fb_info *info)
-{
-	CHKINFO(-EINVAL);
-	DPRINTK("hga_get_var: con:%d, info:%x, fb_info:%x\n", con, (unsigned)info, (unsigned)&fb_info);
-
-	*var = info->var;
-	return 0;
-}
-
-/**
  *	hga_set_var - set the user defined part of the display
  *	@var:new video mode
  *	@con:unused
@@ -462,77 +424,7 @@
 }
 
 /**
- *	hga_getcolreg - read color registers
- *	@regno:register index to read out
- *	@red:red value
- *	@green:green value
- *	@blue:blue value
- *	@transp:transparency value
- *	@info:unused
- *
- *	This callback function is used to read the color registers of a HGA
- *	board. Since we have only two fixed colors, RGB values are 0x0000 
- *	for register0 and 0xaaaa for register1.
- *	A zero is returned on success and 1 for failure.
- */
-
-static int hga_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
-			 u_int *transp, struct fb_info *info)
-{
-	if (regno == 0) {
-		*red = *green = *blue = 0x0000;
-		*transp = 0;
-	} else if (regno == 1) {
-		*red = *green = *blue = 0xaaaa;
-		*transp = 0;
-	} else
-		return 1;
-	return 0;
-}
-
-/**
- *	hga_get_cmap - get the colormap
- *	@cmap:struct fb_cmap to fill in
- *	@kspc:called from kernel space?
- *	@con:unused
- *	@info:pointer to fb_info object containing info for current hga board
- *
- *	This wrapper function passes it's input parameters to fb_get_cmap().
- *	Callback function hga_getcolreg() is used to read the color registers.
- */
-
-int hga_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-                 struct fb_info *info)
-{
-	CHKINFO(-EINVAL);
-	DPRINTK("hga_get_cmap: con:%d\n", con);
-	return fb_get_cmap(cmap, kspc, hga_getcolreg, info);
-}
-	
-/**
- *	hgafb_setcolreg - set color registers
- *	@regno:register index to set
- *	@red:red value, unused
- *	@green:green value, unused
- *	@blue:blue value, unused
- *	@transp:transparency value, unused
- *	@info:unused
- *
- *	This callback function is used to set the color registers of a HGA
- *	board. Since we have only two fixed colors only @regno is checked.
- *	A zero is returned on success and 1 for failure.
- */
-
-static int hgafb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
-			   u_int transp, struct fb_info *info)
-{
-	if (regno > 1)
-		return 1;
-	return 0;
-}
-
-/**
- *	hga_pan_display - pan or wrap the display
+ *	hgafb_pan_display - pan or wrap the display
  *	@var:contains new xoffset, yoffset and vmode values
  *	@con:unused
  *	@info:pointer to fb_info object containing info for current hga board
@@ -543,7 +435,7 @@
  *	A zero is returned on success and %-EINVAL for failure.
  */
 
-int hga_pan_display(struct fb_var_screeninfo *var, int con,
+int hgafb_pan_display(struct fb_var_screeninfo *var, int con,
                     struct fb_info *info)
 {
 	CHKINFO(-EINVAL);
@@ -597,13 +489,12 @@
     
 static struct fb_ops hgafb_ops = {
 	owner:		THIS_MODULE,
-	fb_get_fix:	hga_get_fix,
-	fb_get_var:	hga_get_var,
+	fb_get_fix:	gen_get_fix,
+	fb_get_var:	gen_get_var,
 	fb_set_var:	hga_set_var,
-	fb_get_cmap:	hga_get_cmap,
-	fb_set_cmap:	fbgen_set_cmap,
-	fb_setcolreg:	hgafb_setcolreg,
-	fb_pan_display:	hga_pan_display,
+	fb_get_cmap:	gen_get_cmap,
+	fb_set_cmap:	gen_set_cmap,
+	fb_pan_display:	hgafb_pan_display,
 	fb_blank:	hgafb_blank,
 };
 		
@@ -659,24 +550,6 @@
 	return 0;
 }
 
-/**
- *	hgafbcon_updatevar - update the user defined part of the display
- *	@con:console to update or -1 when no consoles defined on this fb
- *	@info:pointer to fb_info object containing info for current hga board
- *
- *	This function is called when @var is changed by fbcon.c without calling 
- *	hga_set_var(). It usually means scrolling.  hga_pan_display() is called
- *	to update the hardware and @info->var.
- *	A zero is returned on success and %-EINVAL for failure.
- */
-
-static int hgafbcon_updatevar(int con, struct fb_info *info)
-{
-	CHKINFO(-EINVAL);
-	DPRINTK("hga_update_var: con:%d, info:%x, fb_info:%x\n", con, (unsigned)info, (unsigned)&fb_info);
-	return (con < 0) ? -EINVAL : hga_pan_display(&fb_display[con].var, con, info);
-}
-
 /* ------------------------------------------------------------------------- */
     
 	/*
@@ -703,7 +576,6 @@
 	hga_fix.smem_len = hga_vram_len;
 
 	disp.var = hga_default_var;
-/*	disp.cmap = ???; */
 	disp.visual = hga_fix.visual;
 	disp.type = hga_fix.type;
 	disp.type_aux = hga_fix.type_aux;
@@ -725,7 +597,6 @@
 	strcpy (fb_info.modename, hga_fix.id);
 	fb_info.node = NODEV;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;
-/*	fb_info.open = ??? */
 	fb_info.var = hga_default_var;
 	fb_info.fix = hga_fix;
 	fb_info.monspecs.hfmin = 0;
@@ -741,7 +612,7 @@
 	fb_info.currcon = -1;
 	fb_info.changevar = NULL;
 	fb_info.switch_con = hgafbcon_switch;
-	fb_info.updatevar = hgafbcon_updatevar;
+	fb_info.updatevar = gen_update_var;
 	fb_info.pseudo_palette = NULL; /* ??? */
 	fb_info.par = NULL;
 
diff -urN -X /home/jsimmons/dontdiff linux-2.5.7-dj4/drivers/video/hitfb.c linux/drivers/video/hitfb.c
--- linux-2.5.7-dj4/drivers/video/hitfb.c	Mon Apr 15 10:46:50 2002
+++ linux/drivers/video/hitfb.c	Mon Apr 15 11:32:52 2002
@@ -179,7 +179,7 @@
 	size = (fb_info.var.bits_per_pixel == 8) ? 256 : 16;
 	fb_alloc_cmap(&fb_info.cmap, size, 0); 	
 
-	gen_get_var(&fb_info.var, -1, &fb_info);
+	gen_set_var(&fb_info.var, -1, &fb_info);
     
 	if (register_framebuffer(&fb_info) < 0)
 		return -EINVAL;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.7-dj4/drivers/video/hpfb.c linux/drivers/video/hpfb.c
--- linux-2.5.7-dj4/drivers/video/hpfb.c	Mon Apr 15 10:46:50 2002
+++ linux/drivers/video/hpfb.c	Mon Apr 15 11:33:08 2002
@@ -173,7 +173,7 @@
         fb_info.updatevar	= gen_update_var;
 	fb_alloc_cmap(&fb_info.cmap, 256, 0);
 
-	gen_set_var(&fb_info.var, -1, &fb_info);
+	gen_set_disp(-1, &fb_info);
 
 	if (register_framebuffer(&fb_info) < 0)
 		return 1;
diff -urN -X /home/jsimmons/dontdiff linux-2.5.7-dj4/drivers/video/q40fb.c linux/drivers/video/q40fb.c
--- linux-2.5.7-dj4/drivers/video/q40fb.c	Mon Apr 15 10:46:51 2002
+++ linux/drivers/video/q40fb.c	Mon Apr 15 11:33:26 2002
@@ -126,7 +126,7 @@
 	fb_info.updatevar	= gen_update_var;
 	fb_alloc_cmap(&fb_info.cmap, 16, 0);
 
-        gen_set_var(&fb_info.var, -1, &fb_info);
+        gen_set_disp(-1, &fb_info);
 	
 	master_outb(3, DISPLAY_CONTROL_REG);
 

