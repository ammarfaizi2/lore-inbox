Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268113AbUH1Wlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268113AbUH1Wlk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 18:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268077AbUH1WlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 18:41:08 -0400
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:14789 "EHLO
	honk1.physik.uni-konstanz.de") by vger.kernel.org with ESMTP
	id S268111AbUH1Wg6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 18:36:58 -0400
Date: Sun, 29 Aug 2004 00:32:45 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: rivafb broken again in 2.6.9-rc1
Message-ID: <20040828223245.GA3138@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The situation of rivafb was constantly improving on ppc since 2.6.7, but for
2.6.9-rc1 I have to revert the attached part to get it to work again (NV17).
Without this patch the display shows only colored vertical stripes and the
machine crashes.
Any ideas?
 -- Guido

--- linux-2.6.9-rc1.orig/drivers/video/riva/fbdev.c	2004-08-24 20:34:24.000000000 +0200
+++ linux-2.6.9-rc1/drivers/video/riva/fbdev.c	2004-08-29 00:22:24.049499448 +0200
@@ -203,6 +203,7 @@
  * ------------------------------------------------------------------------- */
 
 /* command line data, set in rivafb_setup() */
+static u32 pseudo_palette[17];
 static int flatpanel __initdata = -1; /* Autodetect later */
 static int forceCRTC __initdata = -1;
 #ifdef CONFIG_MTRR
@@ -514,7 +515,7 @@
 		       unsigned char *green, unsigned char *blue)
 {
 	
-	VGA_WR08(chip->PDIO, 0x3c7, regnum);
+	VGA_WR08(chip->PDIO, 0x3c8, regnum);
 	*red = VGA_RD08(chip->PDIO, 0x3c9);
 	*green = VGA_RD08(chip->PDIO, 0x3c9);
 	*blue = VGA_RD08(chip->PDIO, 0x3c9);
@@ -1006,7 +1007,7 @@
 			par->state.flags |= VGA_SAVE_CMAP;
 		save_vga(&par->state);
 #endif
-		riva_common_setup(par);
+
 		RivaGetConfig(&par->riva, par->Chipset);
 		/* vgaHWunlock() + riva unlock (0x7F) */
 		CRTCout(par, 0x11, 0xFF);
@@ -1043,8 +1044,7 @@
 
 static int rivafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	struct fb_videomode *mode;
-	struct riva_par *par = (struct riva_par *) info->par;
+	struct fb_monspecs *specs = &info->monspecs;
 	int nom, den;		/* translating from pixels->bytes */
 	int mode_valid = 0;
 	
@@ -1061,9 +1061,6 @@
 		/* fall through */
 	case 16:
 		var->bits_per_pixel = 16;
-		/* The Riva128 supports RGB555 only */
-		if (par->riva.Architecture == NV_ARCH_03)
-			var->green.length = 5;
 		if (var->green.length == 5) {
 			/* 0rrrrrgg gggbbbbb */
 			var->red.offset = 10;
@@ -1106,21 +1103,62 @@
 			mode_valid = 1;
 	}
 
-	/* calculate modeline if supported by monitor */
-	if (!mode_valid && info->monspecs.gtf) {
-		if (!fb_get_mode(FB_MAXTIMINGS, 0, var, info))
-			mode_valid = 1;
+	/* find best mode from modedb */
+	if (!mode_valid && specs->modedb_len) {
+		int i, best, best_refresh, best_x, best_y, diff_x, diff_y;
+
+		best_refresh = best = best_x = best_y = 0;
+		diff_x = diff_y = -1;
+
+		for (i = 0; i < specs->modedb_len; i++) {
+			if (var->xres <= specs->modedb[i].xres &&
+			    !(specs->modedb[i].flag & FB_MODE_IS_CALCULATED) &&
+			    specs->modedb[i].xres - var->xres < diff_x) {
+				best_x = specs->modedb[i].xres;
+				diff_x = best_x - var->xres;
+			}
+			if (!diff_x) break;
 	}
 
-	if (!mode_valid) {
-		mode = fb_find_best_mode(var, &info->monspecs.modelist);
-		if (mode) {
-			riva_update_var(var, mode);
+		if (diff_x != -1) {
+			for (i = 0; i < specs->modedb_len; i++) {
+				if (best_x == specs->modedb[i].xres &&
+				    var->yres <= specs->modedb[i].yres &&
+				    !(specs->modedb[i].flag &
+				      FB_MODE_IS_CALCULATED) &&
+				    specs->modedb[i].yres-var->yres < diff_y) {
+					best_y = specs->modedb[i].yres;
+					diff_y = best_y - var->yres;
+				}
+				if (!diff_y) break;
+			}
+		}
+
+		if (diff_y != -1) {
+			for (i = 0; i < specs->modedb_len; i++) {
+				if (best_x == specs->modedb[i].xres &&
+				    best_y == specs->modedb[i].yres &&
+				    !(specs->modedb[i].flag &
+				      FB_MODE_IS_CALCULATED) &&
+				    specs->modedb[i].refresh > best_refresh) {
+					best_refresh=specs->modedb[i].refresh;
+					best = i;
+				}
+			}
+		}
+
+		if (best_refresh) {
+			riva_update_var(var, &specs->modedb[best]);
 			mode_valid = 1;
 		}
 	}
 
-	if (!mode_valid && !list_empty(&info->monspecs.modelist))
+	/* calculate modeline if supported by monitor */
+	if (!mode_valid && info->monspecs.gtf) {
+		if (!fb_get_mode(FB_MAXTIMINGS, 0, var, info))
+			mode_valid = 1;
+	}
+	if (!mode_valid && info->monspecs.modedb_len)
 		return -EINVAL;
 
 	if (var->xres_virtual < var->xres)
@@ -1155,6 +1193,12 @@
 	struct riva_par *par = (struct riva_par *) info->par;
 
 	NVTRACE_ENTER();
+	riva_common_setup(par);
+	RivaGetConfig(&par->riva, par->Chipset);
+	/* vgaHWunlock() + riva unlock (0x7F) */
+	CRTCout(par, 0x11, 0xFF);
+	par->riva.LockUnlock(&par->riva, 0);
+
 	riva_load_video_mode(info);
 	riva_setup_accel(info);
 	
@@ -1162,7 +1206,6 @@
 	info->fix.line_length = (info->var.xres_virtual * (info->var.bits_per_pixel >> 3));
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
-
 	NVTRACE_LEAVE();
 	return 0;
 }
@@ -1291,31 +1334,6 @@
 		    (red * 77 + green * 151 + blue * 28) >> 8;
 	}
 
-	if (regno < 16 && info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
-		((u32 *) info->pseudo_palette)[regno] =
-			(regno << info->var.red.offset) |
-			(regno << info->var.green.offset) |
-			(regno << info->var.blue.offset);
-		/*
-		 * The Riva128 2D engine requires color information in
-		 * TrueColor format even if framebuffer is in DirectColor
-		 */
-		if (par->riva.Architecture == NV_ARCH_03) {
-			switch (info->var.bits_per_pixel) {
-			case 16:
-				par->palette[regno] = ((red & 0xf800) >> 1) |
-					((green & 0xf800) >> 6) |
-					((blue & 0xf800) >> 11);
-				break;
-			case 32:
-				par->palette[regno] = ((red & 0xff00) << 8) |
-					((green & 0xff00)) |
-					((blue & 0xff00) >> 8);
-				break;
-			}
-		}
-	}
-
 	switch (info->var.bits_per_pixel) {
 	case 8:
 		/* "transparent" stuff is completely ignored. */
@@ -1323,27 +1341,45 @@
 		break;
 	case 16:
 		if (info->var.green.length == 5) {
-			for (i = 0; i < 8; i++) {
+			if (regno < 16) {
+				/* 0rrrrrgg gggbbbbb */
+				((u32 *)info->pseudo_palette)[regno] =
+					((red & 0xf800) >> 1) |
+					((green & 0xf800) >> 6) |
+					((blue & 0xf800) >> 11);
+			}
+			for (i = 0; i < 8; i++) 
 				riva_wclut(chip, regno*8+i, red >> 8,
 					   green >> 8, blue >> 8);
-			}
 		} else {
 			u8 r, g, b;
 
+			if (regno < 16) {
+				/* rrrrrggg gggbbbbb */
+				((u32 *)info->pseudo_palette)[regno] =
+					((red & 0xf800) >> 0) |
+					((green & 0xf800) >> 5) |
+					((blue & 0xf800) >> 11);
+			}
 			if (regno < 32) {
 				for (i = 0; i < 8; i++) {
-					riva_wclut(chip, regno*8+i,
-						   red >> 8, green >> 8,
-						   blue >> 8);
+					riva_wclut(chip, regno*8+i, red >> 8, 
+						   green >> 8, blue >> 8);
 				}
 			}
-			riva_rclut(chip, regno*4, &r, &g, &b);
-			for (i = 0; i < 4; i++)
-				riva_wclut(chip, regno*4+i, r,
-					   green >> 8, b);
+			for (i = 0; i < 4; i++) {
+				riva_rclut(chip, regno*2+i, &r, &g, &b);
+				riva_wclut(chip, regno*4+i, r, green >> 8, b);
+			}
 		}
 		break;
 	case 32:
+		if (regno < 16) {
+			((u32 *)info->pseudo_palette)[regno] =
+				((red & 0xff00) << 8) |
+				((green & 0xff00)) | ((blue & 0xff00) >> 8);
+			
+		}
 		riva_wclut(chip, regno, red >> 8, green >> 8, blue >> 8);
 		break;
 	default:
@@ -1372,12 +1408,8 @@
 
 	if (info->var.bits_per_pixel == 8)
 		color = rect->color;
-	else {
-		if (par->riva.Architecture != NV_ARCH_03)
-			color = ((u32 *)info->pseudo_palette)[rect->color];
 		else
-			color = par->palette[rect->color];
-	}
+		color = ((u32 *)info->pseudo_palette)[rect->color];
 
 	switch (rect->rop) {
 	case ROP_XOR:
@@ -1473,17 +1505,15 @@
 		bgx = image->bg_color;
 		break;
 	case 16:
-	case 32:
-		if (par->riva.Architecture != NV_ARCH_03) {
 			fgx = ((u32 *)info->pseudo_palette)[image->fg_color];
 			bgx = ((u32 *)info->pseudo_palette)[image->bg_color];
-		} else {
-			fgx = par->palette[image->fg_color];
-			bgx = par->palette[image->bg_color];
-		}
 		if (info->var.green.length == 6)
 			convert_bgcolor_16(&bgx);	
 		break;
+	case 32:
+		fgx = ((u32 *)info->pseudo_palette)[image->fg_color];
+		bgx = ((u32 *)info->pseudo_palette)[image->bg_color];
+		break;
 	}
 
 	RIVA_FIFO_FREE(par->riva, Bitmap, 7);
@@ -1652,7 +1682,6 @@
 static int __devinit riva_set_fbinfo(struct fb_info *info)
 {
 	unsigned int cmap_len;
-	struct riva_par *par = (struct riva_par *) info->par;
 
 	NVTRACE_ENTER();
 	info->flags = FBINFO_DEFAULT
@@ -1665,8 +1694,7 @@
 	info->var = rivafb_default_var;
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
-
-	info->pseudo_palette = par->pseudo_palette;
+	info->pseudo_palette = pseudo_palette;
 
 	cmap_len = riva_get_cmap_len(&info->var);
 	fb_alloc_cmap(&info->cmap, cmap_len, 0);	
@@ -1713,28 +1741,7 @@
 }
 #endif /* CONFIG_PPC_OF */
 
-#ifdef CONFIG_FB_RIVA_I2C
-static int __devinit riva_get_EDID_i2c(struct fb_info *info)
-{
-	struct riva_par *par = (struct riva_par *) info->par;
-	int i;
-
-	NVTRACE_ENTER();
-	riva_create_i2c_busses(par);
-	for (i = par->bus; i >= 1; i--) {
-		riva_probe_i2c_connector(par, i, &par->EDID);
-		if (par->EDID) {
-			printk("rivafb: Found EDID Block from BUS %i\n", i);
-			break;
-		}
-	}
-	NVTRACE_LEAVE();
-	return (par->EDID) ? 1 : 0;
-}
-#endif /* CONFIG_FB_RIVA_I2C */
-
-static void __devinit riva_update_default_var(struct fb_var_screeninfo *var,
-					      struct fb_info *info)
+static void __devinit riva_update_default_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	struct fb_monspecs *specs = &info->monspecs;
 	struct fb_videomode modedb;
@@ -1770,13 +1777,28 @@
 
 static void __devinit riva_get_EDID(struct fb_info *info, struct pci_dev *pdev)
 {
+	struct riva_par *par;
+	int i;
+
 	NVTRACE_ENTER();
 #ifdef CONFIG_PPC_OF
 	if (!riva_get_EDID_OF(info, pdev))
 		printk("rivafb: could not retrieve EDID from OF\n");
-#elif CONFIG_FB_RIVA_I2C
-	if (!riva_get_EDID_i2c(info))
-		printk("rivafb: could not retrieve EDID from DDC/I2C\n");
+#else
+	/* XXX use other methods later */
+#ifdef CONFIG_FB_RIVA_I2C
+
+	par = (struct riva_par *) info->par;
+	riva_create_i2c_busses(par);
+	for (i = par->bus; i >= 1; i--) {
+		riva_probe_i2c_connector(par, i, &par->EDID);
+		if (par->EDID) {
+			printk("rivafb: Found EDID Block from BUS %i\n", i);
+			break;
+		}
+	}
+	riva_delete_i2c_busses(par);
+#endif
 #endif
 	NVTRACE_LEAVE();
 }
@@ -1788,8 +1810,6 @@
 	struct riva_par *par = (struct riva_par *) info->par;
 
 	fb_edid_to_monspecs(par->EDID, &info->monspecs);
-	fb_videomode_to_modelist(info->monspecs.modedb, info->monspecs.modedb_len,
-				 &info->monspecs.modelist);
 	riva_update_default_var(var, info);
 
 	/* if user specified flatpanel, we respect that */
@@ -1797,12 +1817,6 @@
 		par->FlatPanel = 1;
 }
 
-/* ------------------------------------------------------------------------- *
- *
- * PCI bus
- *
- * ------------------------------------------------------------------------- */
-
 static u32 __devinit riva_get_arch(struct pci_dev *pd)
 {
     	u32 arch = 0;
@@ -1841,6 +1855,12 @@
 	return arch;
 }
 
+/* ------------------------------------------------------------------------- *
+ *
+ * PCI bus
+ *
+ * ------------------------------------------------------------------------- */
+
 static int __devinit rivafb_probe(struct pci_dev *pd,
 			     	const struct pci_device_id *ent)
 {
@@ -1881,7 +1901,6 @@
 
 	default_par->Chipset = (pd->vendor << 16) | pd->device;
 	printk(KERN_INFO PFX "nVidia device/chipset %X\n",default_par->Chipset);
-	
 #ifdef CONFIG_PCI_NAMES
 	printk(KERN_INFO PFX "%s\n", pd->pretty_name);
 #endif
@@ -1959,6 +1978,7 @@
 
 	rivafb_fix.smem_len = riva_get_memlen(default_par) * 1024;
 	default_par->dclk_max = riva_get_maxdclk(default_par) * 1000;
+
 	info->screen_base = ioremap(rivafb_fix.smem_start,
 				    rivafb_fix.smem_len);
 	if (!info->screen_base) {
@@ -1991,10 +2011,6 @@
 		goto err_out_iounmap_fb;
 	}
 
-	fb_destroy_modedb(info->monspecs.modedb);
-	info->monspecs.modedb_len = 0;
-	info->monspecs.modedb = NULL;
-
 	if (register_framebuffer(info) < 0) {
 		printk(KERN_ERR PFX
 			"error registering riva framebuffer\n");
@@ -2018,10 +2034,10 @@
 	return 0;
 
 err_out_iounmap_fb:
+	iounmap(info->screen_base);
 #ifdef CONFIG_FB_RIVA_I2C
 	riva_delete_i2c_busses((struct riva_par *) info->par);
 #endif
-	iounmap(info->screen_base);
 err_out_free_base1:
 	if (default_par->riva.Architecture == NV_ARCH_03) 
 		iounmap((caddr_t)default_par->riva.PRAMIN);
@@ -2069,6 +2085,7 @@
 		iounmap((caddr_t)par->riva.PRAMIN);
 	pci_release_regions(pd);
 	pci_disable_device(pd);
+	fb_destroy_modedb(info->monspecs.modedb);
 	kfree(info->pixmap.addr);
 	kfree(par);
 	kfree(info);
