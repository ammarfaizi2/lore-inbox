Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272498AbTGZOdo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 10:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272541AbTGZOdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 10:33:44 -0400
Received: from amsfep14-int.chello.nl ([213.46.243.22]:2105 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S272498AbTGZOcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 10:32:23 -0400
Date: Sat, 26 Jul 2003 16:51:21 +0200
Message-Id: <200307261451.h6QEpL3q002255@callisto.of.borg>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Update valkyriefb driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the valkyriefb driver to the new API.  It compiles
OK, but I haven't been able to test it.  I have simplified the driver
quite a bit using the knowledge that there can only ever be one
valkyrie graphics adaptor in a system - it is the built-in graphics
adaptor on various ancient mac and powermac machines, and we access it
at a hard-coded address, so we can only handle one.
(from Paul Mackerras <paulus@samba.org> on lkml)

--- linux-2.6.x/drivers/video/valkyriefb.c	2003-04-25 22:01:04.000000000 +1000
+++ linux-m68k-2.6.x/drivers/video/valkyriefb.c	2003-05-19 10:58:52.000000000 +1000
@@ -66,15 +66,9 @@
 #endif
 #include <asm/pgtable.h>
 
-#include <video/fbcon.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
-#include <video/macmodes.h>
-
+#include "macmodes.h"
 #include "valkyriefb.h"
 
-static int can_soft_blank = 1;
-
 #ifdef CONFIG_MAC
 /* We don't yet have functions to read the PRAM... perhaps we can
    adapt them from the PPC code? */
@@ -84,27 +78,17 @@
 static int default_vmode = VMODE_NVRAM;
 static int default_cmode = CMODE_NVRAM;
 #endif
-static char fontname[40] __initdata = { 0 };
-
-static int switching = 0;
 
 struct fb_par_valkyrie {
 	int	vmode, cmode;
 	int	xres, yres;
 	int	vxres, vyres;
-	int	xoffset, yoffset;
+	struct valkyrie_regvals *init;
 };
 
 struct fb_info_valkyrie {
-	struct fb_info			info;
-	struct fb_fix_screeninfo	fix;
-	struct fb_var_screeninfo	var;
-	struct display			disp;
-	struct fb_par_valkyrie		par;
-	struct {
-	    __u8 red, green, blue;
-	}			palette[256];
-	
+	struct fb_info		info;
+	struct fb_par_valkyrie	par;
 	struct cmap_regs	*cmap_regs;
 	unsigned long		cmap_regs_phys;
 	
@@ -116,9 +100,8 @@
 	
 	int			sense;
 	unsigned long		total_vram;
-#ifdef FBCON_HAS_CFB16
-	u16 fbcon_cfb16_cmap[16];
-#endif
+
+	u32			pseudo_palette[16];
 };
 
 /*
@@ -127,10 +110,9 @@
 int valkyriefb_init(void);
 int valkyriefb_setup(char*);
 
-static int valkyrie_set_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info);
-static int valkyrie_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-			  struct fb_info *info);
+static int valkyriefb_check_var(struct fb_var_screeninfo *var,
+				struct fb_info *info);
+static int valkyriefb_set_par(struct fb_info *info);
 static int valkyriefb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			     u_int transp, struct fb_info *info);
 static int valkyriefb_blank(int blank_mode, struct fb_info *info);
@@ -138,136 +120,69 @@
 static int read_valkyrie_sense(struct fb_info_valkyrie *p);
 static inline int valkyrie_vram_reqd(int video_mode, int color_mode);
 static void set_valkyrie_clock(unsigned char *params);
-static void valkyrie_set_par(const struct fb_par_valkyrie *p, struct fb_info_valkyrie *info);
 static inline int valkyrie_par_to_var(struct fb_par_valkyrie *par, struct fb_var_screeninfo *var);
 static int valkyrie_var_to_par(struct fb_var_screeninfo *var,
 	struct fb_par_valkyrie *par, const struct fb_info *fb_info);
 
 static void valkyrie_init_info(struct fb_info *info, struct fb_info_valkyrie *p);
-static void valkyrie_par_to_display(struct fb_par_valkyrie *par,
-  struct display *disp, struct fb_fix_screeninfo *fix, struct fb_info_valkyrie *p);
-static void valkyrie_init_display(struct display *disp);
-static void valkyrie_par_to_fix(struct fb_par_valkyrie *par, struct fb_fix_screeninfo *fix,
-	struct fb_info_valkyrie *p);
+static void valkyrie_par_to_fix(struct fb_par_valkyrie *par, struct fb_fix_screeninfo *fix);
 static void valkyrie_init_fix(struct fb_fix_screeninfo *fix, struct fb_info_valkyrie *p);
 
 static struct fb_ops valkyriefb_ops = {
 	.owner =	THIS_MODULE,
-	.fb_set_var =	valkyrie_set_var,
-	.fb_get_cmap =	valkyrie_get_cmap,
-	.fb_set_cmap =	gen_set_cmap,
+	.fb_check_var =	valkyriefb_check_var,
+	.fb_set_par =	valkyriefb_set_par,
 	.fb_setcolreg =	valkyriefb_setcolreg,
 	.fb_blank =	valkyriefb_blank,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+	.fb_cursor	= soft_cursor,
 };
 
-static int valkyriefb_getcolreg(u_int regno, u_int *red, u_int *green,
-			     u_int *blue, u_int *transp, struct fb_info *info);
-
-/* Sets everything according to var */
-static int valkyrie_set_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info)
+/* Sets the video mode according to info->var */
+static int valkyriefb_set_par(struct fb_info *info)
 {
 	struct fb_info_valkyrie *p = (struct fb_info_valkyrie *) info;
-	struct display *disp;
-	struct fb_par_valkyrie par;
-	int depthchange, err;
+	volatile struct valkyrie_regs *valkyrie_regs = p->valkyrie_regs;
+	struct fb_par_valkyrie *par = info->par;
+	struct valkyrie_regvals	*init;
+	int err;
 
-	disp = (con >= 0) ? &fb_display[con] : &p->disp;
-	if ((err = valkyrie_var_to_par(var, &par, info))) {
-		 /* printk (KERN_ERR "Error in valkyrie_set_var, calling valkyrie_var_to_par: %d.\n", err); */
+	if ((err = valkyrie_var_to_par(&info->var, par, info)))
 		return err;
-	}
-	
-	if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW) {
-		/* printk(KERN_ERR "Not activating, in valkyrie_set_var.\n"); */
-		valkyrie_par_to_var(&par, var);
-		return 0;
-	}
 
-	/*
-	 * I know, we want to use fb_display[con], but grab certain info
-	 * from p->var instead.
-	 */
-#define DIRTY(x) (p->var.x != var->x)
-	depthchange = DIRTY(bits_per_pixel);
-	/* adding "&& !DIRTY(pixclock)" corrects vmode-switching problems */
-	if(!DIRTY(xres) && !DIRTY(yres) && !DIRTY(xres_virtual) &&
-	   !DIRTY(yres_virtual) && !DIRTY(bits_per_pixel) && !DIRTY(pixclock)) {
-	   	valkyrie_par_to_var(&par, var);
-		p->var = disp->var = *var;
-		return 0;
-	}
+	valkyrie_par_to_fix(par, &info->fix);
 
-	p->par = par;
-	valkyrie_par_to_var(&par, var);
-	p->var = *var;
-	valkyrie_par_to_fix(&par, &p->fix, p);
-	valkyrie_par_to_display(&par, disp, &p->fix, p);
-	p->disp = *disp;
-	
-	if (info->changevar && !switching) {
-		/* Don't want to do this if just switching consoles. */
-		(*info->changevar)(con);
-	}
-	if (con == info->currcon)
-		valkyrie_set_par(&par, p);
-	if (depthchange)
-		if ((err = fb_alloc_cmap(&disp->cmap, 0, 0)))
-			return err;
-	if (depthchange || switching)
-		do_install_cmap(con, info);
-	return 0;
-}
+	/* Reset the valkyrie */
+	out_8(&valkyrie_regs->status.r, 0);
+	udelay(100);
 
-static int valkyrie_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-			  struct fb_info *info)
-{
-	if (con == info->currcon)	{
-		/* current console? */
-		return fb_get_cmap(cmap, kspc, valkyriefb_getcolreg, info);
-	}
-	if (fb_display[con].cmap.len) { /* non default colormap? */
-		fb_copy_cmap(&fb_display[con].cmap, cmap, kspc? 0: 2);
-	}
-	else {
-		int size = fb_display[con].var.bits_per_pixel == 16 ? 32 : 256;
-		fb_copy_cmap(fb_default_cmap(size), cmap, kspc ? 0 : 2);
-	}
-	return 0;
-}
+	/* Initialize display timing registers */
+	init = par->init;
+	out_8(&valkyrie_regs->mode.r, init->mode | 0x80);
+	out_8(&valkyrie_regs->depth.r, par->cmode + 3);
+	set_valkyrie_clock(init->clock_params);
+	udelay(100);
 
-static int valkyriefb_switch(int con, struct fb_info *fb)
-{
-	struct fb_info_valkyrie *info = (struct fb_info_valkyrie *) fb;
-	struct fb_par_valkyrie par;
+	/* Turn on display */
+	out_8(&valkyrie_regs->mode.r, init->mode);
 
-	if (fb_display[fb->currcon].cmap.len)
-		fb_get_cmap(&fb_display[fb->currcon].cmap, 1, valkyriefb_getcolreg,
-			    fb);
-	fb->currcon = con;
-#if 1
-	valkyrie_var_to_par(&fb_display[fb->currcon].var, &par, fb);
-	valkyrie_set_par(&par, info);
-	do_install_cmap(con, fb);
-#else
-	/* I see no reason not to do this.  Minus info->changevar(). */
-	/* DOH.  This makes valkyrie_set_var compare, you guessed it, */
-	/* fb_display[con].var (first param), and fb_display[con].var! */
-	/* Perhaps I just fixed that... */
-	switching = 1;
-	valkyrie_set_var(&fb_display[con].var, con, info);
-	switching = 0;
-#endif
 	return 0;
 }
 
-static int valkyriefb_updatevar(int con, struct fb_info *info)
+static int
+valkyriefb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
+	int err;
+	struct fb_par_valkyrie par;
+
+	if ((err = valkyrie_var_to_par(var, &par, info)))
+		return err;
+	valkyrie_par_to_var(&par, var);
 	return 0;
 }
 
-static int valkyriefb_blank(int blank_mode, struct fb_info *info)
-{
 /*
  *  Blank the screen if blank_mode != 0, else unblank. If blank_mode == NULL
  *  then the caller blanks by setting the CLUT (Color Look Up Table) to all
@@ -278,48 +193,34 @@
  *    blank_mode == 3: suspend hsync
  *    blank_mode == 4: powerdown
  */
-	struct fb_info_valkyrie *p = (struct fb_info_valkyrie *) info;
-	struct valkyrie_regvals	*init;
-	unsigned char vmode;
-
-	if (p->disp.can_soft_blank
-	 && ((vmode = p->par.vmode) > 0)
-	 && (vmode <= VMODE_MAX)
-	 && ((init = valkyrie_reg_init[vmode - 1]) != NULL)) {
-		if (blank_mode)
-			--blank_mode;
-		switch (blank_mode) {
-		default:	/* unblank */
-			out_8(&p->valkyrie_regs->mode.r, init->mode);
-			break;
-		case VESA_VSYNC_SUSPEND:
-		case VESA_HSYNC_SUSPEND:
-			/*
-			 * [kps] Value extracted from MacOS. I don't know
-			 * whether this bit disables hsync or vsync, or
-			 * whether the hardware can do the other as well.
-			 */
-			out_8(&p->valkyrie_regs->mode.r, init->mode | 0x40);
-			break;
-		case VESA_POWERDOWN:
-			out_8(&p->valkyrie_regs->mode.r, 0x66);
-			break;
-		}
-	}
-	return 0;
-}
-
-static int valkyriefb_getcolreg(u_int regno, u_int *red, u_int *green,
-			     u_int *blue, u_int *transp, struct fb_info *info)
+static int valkyriefb_blank(int blank_mode, struct fb_info *info)
 {
 	struct fb_info_valkyrie *p = (struct fb_info_valkyrie *) info;
+	struct fb_par_valkyrie *par = info->par;
+	struct valkyrie_regvals	*init = par->init;
 
-	if (regno > 255)
+	if (init == NULL)
 		return 1;
-	*red = (p->palette[regno].red<<8) | p->palette[regno].red;
-	*green = (p->palette[regno].green<<8) | p->palette[regno].green;
-	*blue = (p->palette[regno].blue<<8) | p->palette[regno].blue;
 
+	switch (blank_mode) {
+	case 0:			/* unblank */
+		out_8(&p->valkyrie_regs->mode.r, init->mode);
+		break;
+	case 1:
+		return 1;	/* get caller to set CLUT to all black */
+	case VESA_VSYNC_SUSPEND+1:
+	case VESA_HSYNC_SUSPEND+1:
+		/*
+		 * [kps] Value extracted from MacOS. I don't know
+		 * whether this bit disables hsync or vsync, or
+		 * whether the hardware can do the other as well.
+		 */
+		out_8(&p->valkyrie_regs->mode.r, init->mode | 0x40);
+		break;
+	case VESA_POWERDOWN+1:
+		out_8(&p->valkyrie_regs->mode.r, 0x66);
+		break;
+	}
 	return 0;
 }
 
@@ -328,16 +229,13 @@
 {
 	struct fb_info_valkyrie *p = (struct fb_info_valkyrie *) info;
 	volatile struct cmap_regs *cmap_regs = p->cmap_regs;
-
+	struct fb_par_valkyrie *par = info->par;
 
 	if (regno > 255)
 		return 1;
 	red >>= 8;
 	green >>= 8;
 	blue >>= 8;
-	p->palette[regno].red = red;
-	p->palette[regno].green = green;
-	p->palette[regno].blue = blue;
 
 	/* tell clut which address to fill */
 	out_8(&p->cmap_regs->addr, regno);
@@ -347,11 +245,9 @@
 	out_8(&cmap_regs->lut, green);
 	out_8(&cmap_regs->lut, blue);
 
-	if (regno < 16) {
-#ifdef FBCON_HAS_CFB16
-		p->fbcon_cfb16_cmap[regno] = (regno << 10) | (regno << 5) | regno;
-#endif
-	}
+	if (regno < 16 && par->cmode == CMODE_16)
+		((u32 *)info->pseudo_palette)[regno] =
+			(regno << 10) | (regno << 5) | regno;
 
 	return 0;
 }
@@ -359,10 +255,11 @@
 static int valkyrie_vram_reqd(int video_mode, int color_mode)
 {
 	int pitch;
+	struct valkyrie_regvals *init = valkyrie_reg_init[video_mode-1];
 	
-	if ((pitch = valkyrie_reg_init[video_mode-1]->pitch[color_mode]) == 0)
-		pitch = 2 * valkyrie_reg_init[video_mode-1]->pitch[0];
-	return valkyrie_reg_init[video_mode-1]->vres * pitch;
+	if ((pitch = init->pitch[color_mode]) == 0)
+		pitch = 2 * init->pitch[0];
+	return init->vres * pitch;
 }
 
 static void set_valkyrie_clock(unsigned char *params)
@@ -380,14 +277,10 @@
 #endif
 }
 
-static void __init init_valkyrie(struct fb_info_valkyrie *p)
+static void __init valkyrie_choose_mode(struct fb_info_valkyrie *p)
 {
-	struct fb_par_valkyrie *par = &p->par;
-	struct fb_var_screeninfo var;
-	int j, k;
-
 	p->sense = read_valkyrie_sense(p);
-	printk(KERN_INFO "Monitor sense value = 0x%x, ", p->sense);
+	printk(KERN_INFO "Monitor sense value = 0x%x\n", p->sense);
 
 	/* Try to pick a video mode out of NVRAM if we have one. */
 #ifndef CONFIG_MAC
@@ -409,80 +302,22 @@
 #endif
 
 	/*
-	 * Reduce the pixel size if we don't have enough VRAM or bandwitdh.
+	 * Reduce the pixel size if we don't have enough VRAM or bandwidth.
 	 */
-	if (default_cmode < CMODE_8
-	 || default_cmode > CMODE_16
-	 || valkyrie_reg_init[default_vmode-1]->pitch[default_cmode] == 0
-	 || valkyrie_vram_reqd(default_vmode, default_cmode) > p->total_vram)
+	if (default_cmode < CMODE_8 || default_cmode > CMODE_16
+	    || valkyrie_reg_init[default_vmode-1]->pitch[default_cmode] == 0
+	    || valkyrie_vram_reqd(default_vmode, default_cmode) > p->total_vram)
 		default_cmode = CMODE_8;
-	
-	printk(KERN_INFO "using video mode %d and color mode %d.\n", default_vmode, default_cmode);
 
-	mac_vmode_to_var(default_vmode, default_cmode, &var);
-	if (valkyrie_var_to_par(&var, par, &p->info)) {
-	    printk(KERN_ERR "valkyriefb: can't set default video mode\n");
-	    return ;
-	}
-	
-	valkyrie_init_fix(&p->fix, p);
-	valkyrie_par_to_fix(&p->par, &p->fix, p);
-	valkyrie_par_to_var(&p->par, &p->var);
-	valkyrie_init_display(&p->disp);
-	valkyrie_par_to_display(&p->par, &p->disp, &p->fix, p);
-	valkyrie_init_info(&p->info, p);
-
-	/* Initialize colormap */
-	for (j = 0; j < 16; j++) {
-		k = color_table[j];
-		p->palette[j].red = default_red[k];
-		p->palette[j].green = default_grn[k];
-		p->palette[j].blue = default_blu[k];
-	}
-	
-	valkyrie_set_var (&var, -1, &p->info);
-
-	if (register_framebuffer(&p->info) < 0) {
-		kfree(p);
-		return;
-	}
-	
-	printk(KERN_INFO "fb%d: valkyrie frame buffer device\n", p->info.node);	
-}
-
-static void valkyrie_set_par(const struct fb_par_valkyrie *par,
-			     struct fb_info_valkyrie *p)
-{
-	struct valkyrie_regvals	*init;
-	volatile struct valkyrie_regs *valkyrie_regs = p->valkyrie_regs;
-	int vmode, cmode;
-	
-	vmode = par->vmode;
-	cmode = par->cmode;
-	
-	if (vmode <= 0
-	 || vmode > VMODE_MAX
-	 || (init = valkyrie_reg_init[vmode - 1]) == NULL)
-		panic("valkyrie: display mode %d not supported", vmode);
-
-	/* Reset the valkyrie */
-	out_8(&valkyrie_regs->status.r, 0);
-	udelay(100);
-
-	/* Initialize display timing registers */
-	out_8(&valkyrie_regs->mode.r, init->mode | 0x80);
-	out_8(&valkyrie_regs->depth.r, cmode + 3);
-	set_valkyrie_clock(init->clock_params);
-	udelay(100);
-
-	/* Turn on display */
-	out_8(&valkyrie_regs->mode.r, init->mode);
+	printk(KERN_INFO "using video mode %d and color mode %d.\n",
+	       default_vmode, default_cmode);
 }
 
 int __init valkyriefb_init(void)
 {
 	struct fb_info_valkyrie	*p;
 	unsigned long frame_buffer_phys, cmap_regs_phys, flags;
+	int err;
 
 #ifdef CONFIG_MAC
 	if (!MACH_IS_MAC)
@@ -503,10 +338,11 @@
 	if (dp == 0)
 		return 0;
 
-	if(dp->n_addrs != 1) {
-		printk(KERN_ERR "expecting 1 address for valkyrie (got %d)", dp->n_addrs);
+	if (dp->n_addrs != 1) {
+		printk(KERN_ERR "expecting 1 address for valkyrie (got %d)\n",
+		       dp->n_addrs);
 		return 0;
-	}	
+	}
 
 	frame_buffer_phys = dp->addrs[0].address;
 	cmap_regs_phys = dp->addrs[0].address+0x304000;
@@ -515,7 +351,7 @@
 
 	p = kmalloc(sizeof(*p), GFP_ATOMIC);
 	if (p == 0)
-		return 0;
+		return -ENOMEM;
 	memset(p, 0, sizeof(*p));
 
 	/* Map in frame buffer and registers */
@@ -524,14 +360,42 @@
 		return 0;
 	}
 	p->total_vram = 0x100000;
-	p->frame_buffer_phys  = frame_buffer_phys;
+	p->frame_buffer_phys = frame_buffer_phys;
 	p->frame_buffer = __ioremap(frame_buffer_phys, p->total_vram, flags);
 	p->cmap_regs_phys = cmap_regs_phys;
 	p->cmap_regs = ioremap(p->cmap_regs_phys, 0x1000);
 	p->valkyrie_regs_phys = cmap_regs_phys+0x6000;
 	p->valkyrie_regs = ioremap(p->valkyrie_regs_phys, 0x1000);
-	init_valkyrie(p);
+	err = -ENOMEM;
+	if (p->frame_buffer == NULL || p->cmap_regs == NULL
+	    || p->valkyrie_regs == NULL) {
+		printk(KERN_ERR "valkyriefb: couldn't map resources\n");
+		goto out_free;
+	}
+
+	valkyrie_choose_mode(p);
+	mac_vmode_to_var(default_vmode, default_cmode, &p->info.var);
+	valkyrie_init_info(&p->info, p);
+	valkyrie_init_fix(&p->info.fix, p);
+	if (valkyriefb_set_par(&p->info))
+		/* "can't happen" */
+		printk(KERN_ERR "valkyriefb: can't set default video mode\n");
+
+	if ((err = register_framebuffer(&p->info)) != 0)
+		goto out_free;
+
+	printk(KERN_INFO "fb%d: valkyrie frame buffer device\n", p->info.node);
 	return 0;
+
+ out_free:
+	if (p->frame_buffer)
+		iounmap(p->frame_buffer);
+	if (p->cmap_regs)
+		iounmap(p->cmap_regs);
+	if (p->valkyrie_regs)
+		iounmap(p->valkyrie_regs);
+	kfree(p);
+	return err;
 }
 
 /*
@@ -541,22 +405,22 @@
 {
 	int sense, in;
 
-    out_8(&p->valkyrie_regs->msense.r, 0);   /* release all lines */
-    __delay(20000);
-    sense = ((in = in_8(&p->valkyrie_regs->msense.r)) & 0x70) << 4;
-    /* drive each sense line low in turn and collect the other 2 */
-    out_8(&p->valkyrie_regs->msense.r, 4);   /* drive A low */
-    __delay(20000);
-    sense |= ((in = in_8(&p->valkyrie_regs->msense.r)) & 0x30);
-    out_8(&p->valkyrie_regs->msense.r, 2);   /* drive B low */
-    __delay(20000);
-    sense |= ((in = in_8(&p->valkyrie_regs->msense.r)) & 0x40) >> 3;
+	out_8(&p->valkyrie_regs->msense.r, 0);   /* release all lines */
+	__delay(20000);
+	sense = ((in = in_8(&p->valkyrie_regs->msense.r)) & 0x70) << 4;
+	/* drive each sense line low in turn and collect the other 2 */
+	out_8(&p->valkyrie_regs->msense.r, 4);   /* drive A low */
+	__delay(20000);
+	sense |= ((in = in_8(&p->valkyrie_regs->msense.r)) & 0x30);
+	out_8(&p->valkyrie_regs->msense.r, 2);   /* drive B low */
+	__delay(20000);
+	sense |= ((in = in_8(&p->valkyrie_regs->msense.r)) & 0x40) >> 3;
 	sense |= (in & 0x10) >> 2;
-    out_8(&p->valkyrie_regs->msense.r, 1);   /* drive C low */
-    __delay(20000);
-    sense |= ((in = in_8(&p->valkyrie_regs->msense.r)) & 0x60) >> 5;
+	out_8(&p->valkyrie_regs->msense.r, 1);   /* drive C low */
+	__delay(20000);
+	sense |= ((in = in_8(&p->valkyrie_regs->msense.r)) & 0x60) >> 5;
 
-    out_8(&p->valkyrie_regs->msense.r, 7);
+	out_8(&p->valkyrie_regs->msense.r, 7);
 
 	return sense;
 }
@@ -565,8 +429,6 @@
  * This routine takes a user-supplied var,
  * and picks the best vmode/cmode from it.
  */
-static int valkyrie_var_to_par(struct fb_var_screeninfo *var,
-	struct fb_par_valkyrie *par, const struct fb_info *fb_info)
 
 /* [bkn] I did a major overhaul of this function.
  *
@@ -589,55 +451,56 @@
  * good start...
  */
 
+static int valkyrie_var_to_par(struct fb_var_screeninfo *var,
+	struct fb_par_valkyrie *par, const struct fb_info *fb_info)
 {
-	int bpp = var->bits_per_pixel;
+	int vmode, cmode;
 	struct valkyrie_regvals *init;
 	struct fb_info_valkyrie *p = (struct fb_info_valkyrie *) fb_info;
 
-
-	if(mac_var_to_vmode(var, &par->vmode, &par->cmode) != 0) {
-		printk(KERN_ERR "valkyrie_var_to_par: %dx%dx%d unsuccessful.\n",var->xres,var->yres,var->bits_per_pixel);
+	if (mac_var_to_vmode(var, &vmode, &cmode) != 0) {
+		printk(KERN_ERR "valkyriefb: can't do %dx%dx%d.\n",
+		       var->xres, var->yres, var->bits_per_pixel);
 		return -EINVAL;
 	}
 
 	/* Check if we know about the wanted video mode */
-	if(!valkyrie_reg_init[par->vmode-1]) {
-		printk(KERN_ERR "valkyrie_var_to_par: vmode %d not valid.\n", par->vmode);
+	if (vmode < 1 || vmode > VMODE_MAX || !valkyrie_reg_init[vmode-1]) {
+		printk(KERN_ERR "valkyriefb: vmode %d not valid.\n", vmode);
 		return -EINVAL;
 	}
-
-	par->xres = var->xres;
-	par->yres = var->yres;
-	par->xoffset = 0;
-	par->yoffset = 0;
-	par->vxres = par->xres;
-	par->vyres = par->yres;
 	
-	if (var->xres_virtual > var->xres || var->yres_virtual > var->yres
-		|| var->xoffset != 0 || var->yoffset != 0) {
+	if (cmode != CMODE_8 && cmode != CMODE_16) {
+		printk(KERN_ERR "valkyriefb: cmode %d not valid.\n", cmode);
 		return -EINVAL;
 	}
 
-	if (bpp <= 8)
-		par->cmode = CMODE_8;
-	else if (bpp <= 16)
-		par->cmode = CMODE_16;
-	else {
-		printk(KERN_ERR "valkyrie_var_to_par: cmode %d not supported.\n", par->cmode);
+	if (var->xres_virtual > var->xres || var->yres_virtual > var->yres
+	    || var->xoffset != 0 || var->yoffset != 0) {
 		return -EINVAL;
 	}
 
-	init = valkyrie_reg_init[par->vmode-1];
-	if (init->pitch[par->cmode] == 0) {
-		printk(KERN_ERR "valkyrie_var_to_par: vmode %d does not support cmode %d.\n", par->vmode, par->cmode);
+	init = valkyrie_reg_init[vmode-1];
+	if (init->pitch[cmode] == 0) {
+		printk(KERN_ERR "valkyriefb: vmode %d does not support "
+		       "cmode %d.\n", vmode, cmode);
 		return -EINVAL;
 	}
 
-	if (valkyrie_vram_reqd(par->vmode, par->cmode) > p->total_vram) {
-		printk(KERN_ERR "valkyrie_var_to_par: not enough ram for vmode %d, cmode %d.\n", par->vmode, par->cmode);
+	if (valkyrie_vram_reqd(vmode, cmode) > p->total_vram) {
+		printk(KERN_ERR "valkyriefb: not enough ram for vmode %d, "
+		       "cmode %d.\n", vmode, cmode);
 		return -EINVAL;
 	}
 
+	par->vmode = vmode;
+	par->cmode = cmode;
+	par->init = init;
+	par->xres = var->xres;
+	par->yres = var->yres;
+	par->vxres = par->xres;
+	par->vyres = par->yres;
+
 	return 0;
 }
 
@@ -653,7 +516,9 @@
 	fix->mmio_start = p->valkyrie_regs_phys;
 	fix->mmio_len = sizeof(struct valkyrie_regs);
 	fix->type = FB_TYPE_PACKED_PIXELS;
-	
+	fix->smem_start = p->frame_buffer_phys + 0x1000;
+	fix->smem_len = p->total_vram;
+
 	fix->type_aux = 0;
 	fix->ywrapstep = 0;
 	fix->ypanstep = 0;
@@ -663,67 +528,23 @@
 
 /* Fix must already be inited above */
 static void valkyrie_par_to_fix(struct fb_par_valkyrie *par,
-	struct fb_fix_screeninfo *fix,
-	struct fb_info_valkyrie *p)
+	struct fb_fix_screeninfo *fix)
 {
-	fix->smem_start = p->frame_buffer_phys + 0x1000;
-#if 1
 	fix->smem_len = valkyrie_vram_reqd(par->vmode, par->cmode);
-#else
-	fix->smem_len = p->total_vram;
-#endif
 	fix->visual = (par->cmode == CMODE_8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 	fix->line_length = par->vxres << par->cmode;
 		/* ywrapstep, xpanstep, ypanstep */
 }
 
-static void valkyrie_init_display(struct display *disp)
-{
-	memset(disp, 0, sizeof(*disp));
-	disp->can_soft_blank = can_soft_blank;
-	disp->scrollmode = SCROLL_YREDRAW;
-}
-
-static void valkyrie_par_to_display(struct fb_par_valkyrie *par,
-  struct display *disp, struct fb_fix_screeninfo *fix, struct fb_info_valkyrie *p)
-{
-	disp->var = p->var;
-
-	if(disp->scrollmode != SCROLL_YREDRAW) {
-		printk(KERN_ERR "Scroll mode not YREDRAW in valkyrie_par_to_display\n");
-		disp->scrollmode = SCROLL_YREDRAW;
-	}
-	switch (par->cmode) {
-#ifdef FBCON_HAS_CFB8
-                case CMODE_8:
-                        disp->dispsw = &fbcon_cfb8;
-                        break;
-#endif
-#ifdef FBCON_HAS_CFB16
-                case CMODE_16:
-                        disp->dispsw = &fbcon_cfb16;
-                        disp->dispsw_data = p->fbcon_cfb16_cmap;
-                        break;
-#endif
-                default:
-                        disp->dispsw = &fbcon_dummy;
-                        break;
-        }
-}
-
 static void __init valkyrie_init_info(struct fb_info *info, struct fb_info_valkyrie *p)
 {
-	strcpy(info->modename, p->fix.id);
 	info->fbops = &valkyriefb_ops;
 	info->screen_base = (char *) p->frame_buffer + 0x1000;
-	info->disp = &p->disp;
-	info->currcon = -1;
-	strcpy(info->fontname, fontname);
-	info->changevar = NULL;
-	info->switch_con = &valkyriefb_switch;
-	info->updatevar = &valkyriefb_updatevar;
 	info->flags = FBINFO_FLAG_DEFAULT;
+	info->pseudo_palette = p->pseudo_palette;
+	fb_alloc_cmap(&info->cmap, 256, 0);
+	info->par = &p->par;
 }
 
 
@@ -738,41 +559,23 @@
 		return 0;
 
 	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!strncmp(this_opt, "font:", 5)) {
-			char *p;
-			int i;
-
-			p = this_opt + 5;
-			for (i = 0; i < sizeof(fontname) - 1; i++)
-				if (!*p || *p == ' ' || *p == ',')
-					break;
-			memcpy(fontname, this_opt + 5, i);
-			fontname[i] = 0;
-		}
-		else if (!strncmp(this_opt, "vmode:", 6)) {
+		if (!strncmp(this_opt, "vmode:", 6)) {
 	    		int vmode = simple_strtoul(this_opt+6, NULL, 0);
-	    	if (vmode > 0 && vmode <= VMODE_MAX)
+			if (vmode > 0 && vmode <= VMODE_MAX)
 				default_vmode = vmode;
 		}
 		else if (!strncmp(this_opt, "cmode:", 6)) {
 			int depth = simple_strtoul(this_opt+6, NULL, 0);
 			switch (depth) {
-			 case 8:
-			    default_cmode = CMODE_8;
-			    break;
-			 case 15:
-			 case 16:
-			    default_cmode = CMODE_16;
-			    break;
+			case 8:
+				default_cmode = CMODE_8;
+				break;
+			case 15:
+			case 16:
+				default_cmode = CMODE_16;
+				break;
 			}
 		}
-		/* XXX - remove these options once blanking has been tested */
-		else if (!strncmp(this_opt, "noblank", 7)) {
-			can_soft_blank = 0;
-		}
-		else if (!strncmp(this_opt, "blank", 5)) {
-			can_soft_blank = 1;
-		}
 	}
 	return 0;
 }

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
