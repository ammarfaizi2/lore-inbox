Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265374AbUBPHCY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 02:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265384AbUBPHCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 02:02:24 -0500
Received: from gate.crashing.org ([63.228.1.57]:61343 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265374AbUBPHBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 02:01:47 -0500
Subject: Re: [PATCH] Update platinumfb driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <1076914615.6949.216.camel@gaston>
References: <1076914615.6949.216.camel@gaston>
Content-Type: text/plain
Message-Id: <1076914762.6958.218.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 17:59:23 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-16 at 17:56, Benjamin Herrenschmidt wrote:
> Hi !
> 
> This patch updates the PowerMac-only platinumfb driver to use
> the new mac-io device infrastructure. It also switch allocation
> to the new framebuffer_alloc/release and fix a couple of bugs.
> 
> I finally found the old hardware to really test it so please
> apply :)

Grrr... Here again I forgot the crappy fbdev initialisation stuff,
here's an updated patch.

diff -urN linux-2.5/drivers/video/platinumfb.c linuxppc-2.5-benh/drivers/video/platinumfb.c
--- linux-2.5/drivers/video/platinumfb.c	2004-01-22 11:20:31.000000000 +1100
+++ linuxppc-2.5-benh/drivers/video/platinumfb.c	2004-02-16 17:03:04.285218240 +1100
@@ -43,16 +43,13 @@
 static int default_vmode = VMODE_NVRAM;
 static int default_cmode = CMODE_NVRAM;
 
-struct fb_par_platinum {
-	int	vmode, cmode;
-	int	xres, yres;
-	int	vxres, vyres;
-	int	xoffset, yoffset;
-};
-
 struct fb_info_platinum {
-	struct fb_info			info;
-	struct fb_par_platinum		par;
+	struct fb_info			*info;
+
+	int				vmode, cmode;
+	int				xres, yres;
+	int				vxres, vyres;
+	int				xoffset, yoffset;
 
 	struct {
 		__u8 red, green, blue;
@@ -89,23 +86,19 @@
  */
 
 static inline int platinum_vram_reqd(int video_mode, int color_mode);
-static int read_platinum_sense(struct fb_info_platinum *info);
-static void set_platinum_clock(struct fb_info_platinum *info);
-static void platinum_set_hardware(struct fb_info_platinum *info,
-				  const struct fb_par_platinum *par);
-static int platinum_par_to_var(struct fb_var_screeninfo *var,
-			       const struct fb_par_platinum *par,
-			       const struct fb_info_platinum *info);
-static int platinum_var_to_par(const struct fb_var_screeninfo *var,
-			       struct fb_par_platinum *par,
-			       const struct fb_info_platinum *info);
+static int read_platinum_sense(struct fb_info_platinum *pinfo);
+static void set_platinum_clock(struct fb_info_platinum *pinfo);
+static void platinum_set_hardware(struct fb_info_platinum *pinfo);
+static int platinum_var_to_par(struct fb_var_screeninfo *var,
+			       struct fb_info_platinum *pinfo,
+			       int check_only);
 
 /*
  * Interface used by the world
  */
 
-int platinum_init(void);
-int platinum_setup(char*);
+int platinumfb_init(void);
+int platinumfb_setup(char*);
 
 static struct fb_ops platinumfb_ops = {
 	.owner =	THIS_MODULE,
@@ -124,16 +117,7 @@
  */
 static int platinumfb_check_var (struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct fb_info_platinum *p = (struct fb_info_platinum *) info;
-	struct fb_par_platinum par;
-	int err;
-	
-	err = platinum_var_to_par(var, &par, p);
-	if (err)
-		return err;	
-	platinum_par_to_var(var, &par, p);
-
-	return 0;
+	return platinum_var_to_par(var, info->par, 1);
 }
 
 /*
@@ -141,27 +125,28 @@
  */
 static int platinumfb_set_par (struct fb_info *info)
 {
-	struct fb_info_platinum *p = (struct fb_info_platinum *) info;
+	struct fb_info_platinum *pinfo = info->par;
 	struct platinum_regvals *init;
-	struct fb_par_platinum par;
-	int err;
+	int err, offset = 0x20;
 
-	if((err = platinum_var_to_par(&info->var, &par, p))) {
+	if((err = platinum_var_to_par(&info->var, pinfo, 0))) {
 		printk (KERN_ERR "platinumfb_set_par: error calling"
 				 " platinum_var_to_par: %d.\n", err);
 		return err;
 	}
 
-	platinum_set_hardware(p, &par);
+	platinum_set_hardware(pinfo);
 
-	init = platinum_reg_init[p->par.vmode-1];
+	init = platinum_reg_init[pinfo->vmode-1];
 	
-	info->screen_base = (char *) p->frame_buffer + init->fb_offset + 0x20;
-	info->fix.smem_start = (p->frame_buffer_phys) + init->fb_offset + 0x20;
-	info->fix.visual = (p->par.cmode == CMODE_8) ?
+	if (pinfo->vmode == 13 && pinfo->cmode > 0)
+		offset = 0x10;
+	info->screen_base = (char *) pinfo->frame_buffer + init->fb_offset + offset;
+	info->fix.smem_start = (pinfo->frame_buffer_phys) + init->fb_offset + offset;
+	info->fix.visual = (pinfo->cmode == CMODE_8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
-	info->fix.line_length = vmode_attrs[p->par.vmode-1].hres * (1<<p->par.cmode) + 0x20;
-
+	info->fix.line_length = vmode_attrs[pinfo->vmode-1].hres * (1<<pinfo->cmode) + offset;
+	printk("line_length: %x\n", info->fix.line_length);
 	return 0;
 }
 
@@ -198,8 +183,8 @@
 static int platinumfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			      u_int transp, struct fb_info *info)
 {
-	struct fb_info_platinum *p = (struct fb_info_platinum *) info;
-	volatile struct cmap_regs *cmap_regs = p->cmap_regs;
+	struct fb_info_platinum *pinfo = info->par;
+	volatile struct cmap_regs *cmap_regs = pinfo->cmap_regs;
 
 	if (regno > 255)
 		return 1;
@@ -208,9 +193,9 @@
 	green >>= 8;
 	blue >>= 8;
 
-	p->palette[regno].red = red;
-	p->palette[regno].green = green;
-	p->palette[regno].blue = blue;
+	pinfo->palette[regno].red = red;
+	pinfo->palette[regno].green = green;
+	pinfo->palette[regno].blue = blue;
 
 	out_8(&cmap_regs->addr, regno);		/* tell clut what addr to fill	*/
 	out_8(&cmap_regs->lut, red);		/* send one color channel at	*/
@@ -220,7 +205,7 @@
 	if (regno < 16) {
 		int i;
 		u32 *pal = info->pseudo_palette;
-		switch (p->par.cmode) {
+		switch (pinfo->cmode) {
 		case CMODE_16:
 			pal[regno] = (regno << 10) | (regno << 5) | regno;
 			break;
@@ -245,23 +230,23 @@
 	out_8(&cmap_regs->d2, (d)); \
 }
 
-static void set_platinum_clock(struct fb_info_platinum *info)
+static void set_platinum_clock(struct fb_info_platinum *pinfo)
 {
-	volatile struct cmap_regs *cmap_regs = info->cmap_regs;
+	volatile struct cmap_regs *cmap_regs = pinfo->cmap_regs;
 	struct platinum_regvals	*init;
 
-	init = platinum_reg_init[info->par.vmode-1];
+	init = platinum_reg_init[pinfo->vmode-1];
 
 	STORE_D2(6, 0xc6);
 	out_8(&cmap_regs->addr,3+32);
 
 	if (in_8(&cmap_regs->d2) == 2) {
-		STORE_D2(7, init->clock_params[info->clktype][0]);
-		STORE_D2(8, init->clock_params[info->clktype][1]);
+		STORE_D2(7, init->clock_params[pinfo->clktype][0]);
+		STORE_D2(8, init->clock_params[pinfo->clktype][1]);
 		STORE_D2(3, 3);
 	} else {
-		STORE_D2(4, init->clock_params[info->clktype][0]);
-		STORE_D2(5, init->clock_params[info->clktype][1]);
+		STORE_D2(4, init->clock_params[pinfo->clktype][0]);
+		STORE_D2(5, init->clock_params[pinfo->clktype][1]);
 		STORE_D2(3, 2);
 	}
 
@@ -272,18 +257,16 @@
 
 /* Now how about actually saying, Make it so! */
 /* Some things in here probably don't need to be done each time. */
-static void platinum_set_hardware(struct fb_info_platinum *info, const struct fb_par_platinum *par)
+static void platinum_set_hardware(struct fb_info_platinum *pinfo)
 {
-	volatile struct platinum_regs	*platinum_regs = info->platinum_regs;
-	volatile struct cmap_regs	*cmap_regs = info->cmap_regs;
+	volatile struct platinum_regs	*platinum_regs = pinfo->platinum_regs;
+	volatile struct cmap_regs	*cmap_regs = pinfo->cmap_regs;
 	struct platinum_regvals		*init;
 	int				i;
 	int				vmode, cmode;
 	
-	info->par = *par;
-
-	vmode = par->vmode;
-	cmode = par->cmode;
+	vmode = pinfo->vmode;
+	cmode = pinfo->cmode;
 
 	init = platinum_reg_init[vmode - 1];
 
@@ -293,15 +276,15 @@
 	for (i = 0; i < 26; ++i)
 		out_be32(&platinum_regs->reg[i+32].r, init->regs[i]);
 
-	out_be32(&platinum_regs->reg[26+32].r, (info->total_vram == 0x100000 ?
+	out_be32(&platinum_regs->reg[26+32].r, (pinfo->total_vram == 0x100000 ?
 						init->offset[cmode] + 4 - cmode :
 						init->offset[cmode]));
-	out_be32(&platinum_regs->reg[16].r, (unsigned) info->frame_buffer_phys+init->fb_offset+0x10);
+	out_be32(&platinum_regs->reg[16].r, (unsigned) pinfo->frame_buffer_phys+init->fb_offset+0x10);
 	out_be32(&platinum_regs->reg[18].r, init->pitch[cmode]);
-	out_be32(&platinum_regs->reg[19].r, (info->total_vram == 0x100000 ?
+	out_be32(&platinum_regs->reg[19].r, (pinfo->total_vram == 0x100000 ?
 					     init->mode[cmode+1] :
 					     init->mode[cmode]));
-	out_be32(&platinum_regs->reg[20].r, (info->total_vram == 0x100000 ? 0x11 : 0x1011));
+	out_be32(&platinum_regs->reg[20].r, (pinfo->total_vram == 0x100000 ? 0x11 : 0x1011));
 	out_be32(&platinum_regs->reg[21].r, 0x100);
 	out_be32(&platinum_regs->reg[22].r, 1);
 	out_be32(&platinum_regs->reg[23].r, 1);
@@ -309,13 +292,13 @@
 	out_be32(&platinum_regs->reg[27].r, 0x235);
 	/* out_be32(&platinum_regs->reg[27].r, 0x2aa); */
 
-	STORE_D2(0, (info->total_vram == 0x100000 ?
+	STORE_D2(0, (pinfo->total_vram == 0x100000 ?
 		     init->dacula_ctrl[cmode] & 0xf :
 		     init->dacula_ctrl[cmode]));
 	STORE_D2(1, 4);
 	STORE_D2(2, 0);
 
-	set_platinum_clock(info);
+	set_platinum_clock(pinfo);
 
 	out_be32(&platinum_regs->reg[24].r, 0);	/* turn display on */
 }
@@ -323,24 +306,23 @@
 /*
  * Set misc info vars for this driver
  */
-static void __devinit platinum_init_info(struct fb_info *info, struct fb_info_platinum *p)
+static void __devinit platinum_init_info(struct fb_info *info, struct fb_info_platinum *pinfo)
 {
 	/* Fill fb_info */
-	info->par = &p->par;
 	info->fbops = &platinumfb_ops;
-	info->pseudo_palette = p->pseudo_palette;
+	info->pseudo_palette = pinfo->pseudo_palette;
         info->flags = FBINFO_FLAG_DEFAULT;
-	info->screen_base = (char *) p->frame_buffer + 0x20;
+	info->screen_base = (char *) pinfo->frame_buffer + 0x20;
 
 	fb_alloc_cmap(&info->cmap, 256, 0);
 
 	/* Fill fix common fields */
 	strcpy(info->fix.id, "platinum");
-	info->fix.mmio_start = p->platinum_regs_phys;
+	info->fix.mmio_start = pinfo->platinum_regs_phys;
 	info->fix.mmio_len = 0x1000;
 	info->fix.type = FB_TYPE_PACKED_PIXELS;
-	info->fix.smem_start = p->frame_buffer_phys + 0x20; /* will be updated later */
-	info->fix.smem_len = p->total_vram - 0x20;
+	info->fix.smem_start = pinfo->frame_buffer_phys + 0x20; /* will be updated later */
+	info->fix.smem_len = pinfo->total_vram - 0x20;
         info->fix.ywrapstep = 0;
 	info->fix.xpanstep = 0;
 	info->fix.ypanstep = 0;
@@ -349,13 +331,14 @@
 }
 
 
-static int __devinit platinum_init_fb(struct fb_info_platinum *p)
+static int __devinit platinum_init_fb(struct fb_info *info)
 {
+	struct fb_info_platinum *pinfo = info->par;
 	struct fb_var_screeninfo var;
 	int sense, rc;
 
-	sense = read_platinum_sense(p);
-	printk(KERN_INFO "Monitor sense value = 0x%x, ", sense);
+	sense = read_platinum_sense(pinfo);
+	printk(KERN_INFO "platinumfb: Monitor sense value = 0x%x, ", sense);
 
 	if (default_vmode == VMODE_NVRAM) {
 		default_vmode = nvram_read_byte(NV_VMODE);
@@ -375,10 +358,11 @@
 	/*
 	 * Reduce the pixel size if we don't have enough VRAM.
 	 */
-	while(default_cmode > CMODE_8 && platinum_vram_reqd(default_vmode, default_cmode) > p->total_vram)
+	while(default_cmode > CMODE_8 &&
+	      platinum_vram_reqd(default_vmode, default_cmode) > pinfo->total_vram)
 		default_cmode--;
 
-	printk("using video mode %d and color mode %d.\n", default_vmode, default_cmode);
+	printk("platinumfb:  Using video mode %d and color mode %d.\n", default_vmode, default_cmode);
 
 	/* Setup default var */
 	if (mac_vmode_to_var(default_vmode, default_cmode, &var) < 0) {
@@ -394,22 +378,21 @@
 	}
 
 	/* Initialize info structure */
-	platinum_init_info(&p->info, p);
+	platinum_init_info(info, pinfo);
 
 	/* Apply default var */
-	p->info.var = var;
+	info->var = var;
 	var.activate = FB_ACTIVATE_NOW;
-	rc = fb_set_var(&p->info, &var);
+	rc = fb_set_var(info, &var);
 	if (rc && (default_vmode != VMODE_640_480_60 || default_cmode != CMODE_8))
 		goto try_again;
 
 	/* Register with fbdev layer */
-	rc = register_framebuffer(&p->info);
+	rc = register_framebuffer(info);
 	if (rc < 0)
 		return rc;
 
-	printk(KERN_INFO "fb%d: platinum frame buffer device\n",
-	       p->info.node);
+	printk(KERN_INFO "fb%d: Apple Platinum frame buffer device\n", info->node);
 
 	return 0;
 }
@@ -445,12 +428,17 @@
 	return sense;
 }
 
-/* This routine takes a user-supplied var, and picks the best vmode/cmode from it. */
-static int platinum_var_to_par(const struct fb_var_screeninfo *var, 
-			       struct fb_par_platinum *par,
-			       const struct fb_info_platinum *info)
+/*
+ * This routine takes a user-supplied var, and picks the best vmode/cmode from it.
+ * It also updates the var structure to the actual mode data obtained
+ */
+static int platinum_var_to_par(struct fb_var_screeninfo *var, 
+			       struct fb_info_platinum *pinfo,
+			       int check_only)
 {
-	if(mac_var_to_vmode(var, &par->vmode, &par->cmode) != 0) {
+	int vmode, cmode;
+
+	if (mac_var_to_vmode(var, &vmode, &cmode) != 0) {
 		printk(KERN_ERR "platinum_var_to_par: mac_var_to_vmode unsuccessful.\n");
 		printk(KERN_ERR "platinum_var_to_par: var->xres = %d\n", var->xres);
 		printk(KERN_ERR "platinum_var_to_par: var->yres = %d\n", var->yres);
@@ -462,37 +450,39 @@
 		return -EINVAL;
 	}
 
-	if(!platinum_reg_init[par->vmode-1]) {
-		printk(KERN_ERR "platinum_var_to_par, vmode %d not valid.\n", par->vmode);
+	if (!platinum_reg_init[vmode-1]) {
+		printk(KERN_ERR "platinum_var_to_par, vmode %d not valid.\n", vmode);
 		return -EINVAL;
 	}
 
-	if (platinum_vram_reqd(par->vmode, par->cmode) > info->total_vram) {
-		printk(KERN_ERR "platinum_var_to_par, not enough ram for vmode %d, cmode %d.\n", par->vmode, par->cmode);
+	if (platinum_vram_reqd(vmode, cmode) > pinfo->total_vram) {
+		printk(KERN_ERR "platinum_var_to_par, not enough ram for vmode %d, cmode %d.\n", vmode, cmode);
 		return -EINVAL;
 	}
 
-	par->xres = vmode_attrs[par->vmode-1].hres;
-	par->yres = vmode_attrs[par->vmode-1].vres;
-	par->xoffset = 0;
-	par->yoffset = 0;
-	par->vxres = par->xres;
-	par->vyres = par->yres;
+	if (mac_vmode_to_var(vmode, cmode, var))
+		return -EINVAL;
+
+	if (check_only)
+		return 0;
+
+	pinfo->vmode = vmode;
+	pinfo->cmode = cmode;
+	pinfo->xres = vmode_attrs[vmode-1].hres;
+	pinfo->yres = vmode_attrs[vmode-1].vres;
+	pinfo->xoffset = 0;
+	pinfo->yoffset = 0;
+	pinfo->vxres = pinfo->xres;
+	pinfo->vyres = pinfo->yres;
 	
 	return 0;
 }
 
-static int platinum_par_to_var(struct fb_var_screeninfo *var,
-			       const struct fb_par_platinum *par,
-			       const struct fb_info_platinum *info)
-{
-	return mac_vmode_to_var(par->vmode, par->cmode, var);
-}
 
 /* 
  * Parse user speficied options (`video=platinumfb:')
  */
-int __init platinum_setup(char *options)
+int __init platinumfb_setup(char *options)
 {
 	char *this_opt;
 
@@ -536,7 +526,8 @@
 static int __devinit platinumfb_probe(struct of_device* odev, const struct of_match *match)
 {
 	struct device_node	*dp = odev->node;
-	struct fb_info_platinum	*info;
+	struct fb_info		*info;
+	struct fb_info_platinum	*pinfo;
 	unsigned long		addr, size;
 	volatile __u8		*fbuffer;
 	int			i, bank0, bank1, bank2, bank3, rc;
@@ -545,11 +536,12 @@
 		printk(KERN_ERR "expecting 2 address for platinum (got %d)", dp->n_addrs);
 		return -ENXIO;
 	}
+	printk(KERN_INFO "platinumfb: Found Apple Platinum video hardware\n");
 
-	info = kmalloc(sizeof(*info), GFP_ATOMIC);
-	if (info == 0)
+	info = framebuffer_alloc(sizeof(*pinfo), &odev->dev);
+	if (info == NULL)
 		return -ENOMEM;
-	memset(info, 0, sizeof(*info));
+	pinfo = info->par;
 
 	/* Map in frame buffer and registers */
 	for (i = 0; i < dp->n_addrs; ++i) {
@@ -557,31 +549,31 @@
 		size = dp->addrs[i].size;
 		/* Let's assume we can request either all or nothing */
 		if (!request_mem_region(addr, size, "platinumfb")) {
-			kfree(info);
+			framebuffer_release(info);
 			return -ENXIO;
 		}
 		if (size >= 0x400000) {
 			/* frame buffer - map only 4MB */
-			info->frame_buffer_phys = addr;
-			info->frame_buffer = __ioremap(addr, 0x400000, _PAGE_WRITETHRU);
-			info->base_frame_buffer = info->frame_buffer;
+			pinfo->frame_buffer_phys = addr;
+			pinfo->frame_buffer = __ioremap(addr, 0x400000, _PAGE_WRITETHRU);
+			pinfo->base_frame_buffer = pinfo->frame_buffer;
 		} else {
 			/* registers */
-			info->platinum_regs_phys = addr;
-			info->platinum_regs = ioremap(addr, size);
+			pinfo->platinum_regs_phys = addr;
+			pinfo->platinum_regs = ioremap(addr, size);
 		}
 	}
 
-	info->cmap_regs_phys = 0xf301b000;	/* XXX not in prom? */
-	request_mem_region(info->cmap_regs_phys, 0x1000, "platinumfb cmap");
-	info->cmap_regs = ioremap(info->cmap_regs_phys, 0x1000);
+	pinfo->cmap_regs_phys = 0xf301b000;	/* XXX not in prom? */
+	request_mem_region(pinfo->cmap_regs_phys, 0x1000, "platinumfb cmap");
+	pinfo->cmap_regs = ioremap(pinfo->cmap_regs_phys, 0x1000);
 
 	/* Grok total video ram */
-	out_be32(&info->platinum_regs->reg[16].r, (unsigned)info->frame_buffer_phys);
-	out_be32(&info->platinum_regs->reg[20].r, 0x1011);	/* select max vram */
-	out_be32(&info->platinum_regs->reg[24].r, 0);	/* switch in vram */
+	out_be32(&pinfo->platinum_regs->reg[16].r, (unsigned)pinfo->frame_buffer_phys);
+	out_be32(&pinfo->platinum_regs->reg[20].r, 0x1011);	/* select max vram */
+	out_be32(&pinfo->platinum_regs->reg[24].r, 0);	/* switch in vram */
 
-	fbuffer = info->base_frame_buffer;
+	fbuffer = pinfo->base_frame_buffer;
 	fbuffer[0x100000] = 0x34;
 	fbuffer[0x100008] = 0x0;
 	invalidate_cache(&fbuffer[0x100000]);
@@ -595,24 +587,27 @@
 	bank1 = fbuffer[0x100000] == 0x34;
 	bank2 = fbuffer[0x200000] == 0x56;
 	bank3 = fbuffer[0x300000] == 0x78;
-	info->total_vram = (bank0 + bank1 + bank2 + bank3) * 0x100000;
-	printk(KERN_INFO "Total VRAM = %dMB %d%d%d%d\n", (int) (info->total_vram / 1024 / 1024), bank3, bank2, bank1, bank0);
+	pinfo->total_vram = (bank0 + bank1 + bank2 + bank3) * 0x100000;
+	printk(KERN_INFO "platinumfb: Total VRAM = %dMB (%d%d%d%d)\n", (int) (pinfo->total_vram / 1024 / 1024),
+	       bank3, bank2, bank1, bank0);
 
 	/*
 	 * Try to determine whether we have an old or a new DACula.
 	 */
-	out_8(&info->cmap_regs->addr, 0x40);
-	info->dactype = in_8(&info->cmap_regs->d2);
-	switch (info->dactype) {
+	out_8(&pinfo->cmap_regs->addr, 0x40);
+	pinfo->dactype = in_8(&pinfo->cmap_regs->d2);
+	switch (pinfo->dactype) {
 	case 0x3c:
-		info->clktype = 1;
+		pinfo->clktype = 1;
+		printk(KERN_INFO "platinumfb: DACula type 0x3c\n");
 		break;
 	case 0x84:
-		info->clktype = 0;
+		pinfo->clktype = 0;
+		printk(KERN_INFO "platinumfb: DACula type 0x84\n");
 		break;
 	default:
-		info->clktype = 0;
-		printk(KERN_INFO "Unknown DACula type: %x\n", info->dactype);
+		pinfo->clktype = 0;
+		printk(KERN_INFO "platinumfb: Unknown DACula type: %x\n", pinfo->dactype);
 		break;
 	}
 	dev_set_drvdata(&odev->dev, info);
@@ -620,7 +615,7 @@
 	rc = platinum_init_fb(info);
 	if (rc != 0) {
 		dev_set_drvdata(&odev->dev, NULL);
-		kfree(info);
+		framebuffer_release(info);
 	}
 
 	return rc;
@@ -628,15 +623,13 @@
 
 static int __devexit platinumfb_remove(struct of_device* odev)
 {
-	struct fb_info_platinum	*pinfo = dev_get_drvdata(&odev->dev);
+	struct fb_info		*info = dev_get_drvdata(&odev->dev);
+	struct fb_info_platinum	*pinfo = info->par;
 	struct device_node *dp = odev->node;
 	unsigned long addr, size;
 	int i;
 	
-	if (!pinfo)
-		return 0;
-
-        unregister_framebuffer (&pinfo->info);
+        unregister_framebuffer (info);
 	
 	/* Unmap frame buffer and registers */
 	for (i = 0; i < dp->n_addrs; ++i) {
@@ -649,7 +642,7 @@
 	release_mem_region(pinfo->cmap_regs_phys, 0x1000);
 	iounmap((void *)pinfo->cmap_regs);
 
-	kfree(pinfo);
+	framebuffer_release(info);
 
 	return 0;
 }
@@ -672,14 +665,14 @@
 	.remove		= platinumfb_remove,
 };
 
-int __init platinum_init(void)
+int __init platinumfb_init(void)
 {
 	of_register_driver(&platinum_driver);
 
 	return 0;
 }
 
-void __exit platinum_exit(void)
+void __exit platinumfb_exit(void)
 {
 	of_unregister_driver(&platinum_driver);	
 }
@@ -688,6 +681,6 @@
 MODULE_DESCRIPTION("framebuffer driver for Apple Platinum video");
 
 #ifdef MODULE
-module_init(platinum_init);
-module_exit(platinum_exit);
+module_init(platinumfb_init);
+module_exit(platinumfb_exit);
 #endif
===== drivers/video/fbmem.c 1.87 vs edited =====
--- 1.87/drivers/video/fbmem.c	Sun Feb 15 21:43:42 2004
+++ edited/drivers/video/fbmem.c	Mon Feb 16 17:58:08 2004
@@ -103,6 +103,8 @@
 extern int matroxfb_init(void);
 extern int matroxfb_setup(char*);
 extern int hpfb_init(void);
+extern int platinumfb_init(void);
+extern int platinumfb_setup(char*);
 extern int control_init(void);
 extern int control_setup(char*);
 extern int platinum_init(void);
@@ -230,7 +232,7 @@
 	{ "controlfb", control_init, control_setup },
 #endif
 #ifdef CONFIG_FB_PLATINUM
-	{ "platinumfb", platinum_init, platinum_setup },
+	{ "platinumfb", platinumfb_init, platinumfb_setup },
 #endif
 #ifdef CONFIG_FB_VALKYRIE
 	{ "valkyriefb", valkyriefb_init, valkyriefb_setup },


