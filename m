Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313317AbSDOWOn>; Mon, 15 Apr 2002 18:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313318AbSDOWOn>; Mon, 15 Apr 2002 18:14:43 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:54023 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id <S313317AbSDOWOc>; Mon, 15 Apr 2002 18:14:32 -0400
Date: Mon, 15 Apr 2002 23:14:20 +0100
To: linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, ajoshi@unixbox.com
Subject: [PATCH] radeonfb ... again
Message-ID: <20020415221420.GA12057@berserk.demon.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
	ajoshi@unixbox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@berserk.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More "radeonfb" patch, still against 2.4.19-pre2.

* Remove palette hacks for soft cursor by copying "revc" method.
* Added "nostretch" option to disable stretching on DFPs.
* Fast console switch (don't change PLL unless we have to).
* Added module options.
* Other fixes and cleanups.

P.

diff -ur linux-2.4.19-pre2/drivers/video/radeon.h linux.pdh/drivers/video/radeon.h
--- linux-2.4.19-pre2/drivers/video/radeon.h	Sat Apr  6 16:34:27 2002
+++ linux.pdh/drivers/video/radeon.h	Thu Apr 11 23:57:10 2002
@@ -379,6 +379,7 @@
 #define SC_TOP_LEFT                            0x16EC  
 #define SC_BOTTOM_RIGHT                        0x16F0  
 #define SRC_SC_BOTTOM_RIGHT                    0x16F4  
+#define RB2D_DSTCACHE_MODE                     0x3428
 #define RB2D_DSTCACHE_CTLSTAT		       0x342C
 #define LVDS_GEN_CNTL			       0x02d0
 #define LVDS_PLL_CNTL			       0x02d4
@@ -395,6 +396,7 @@
 #define RADEON_BIOS_6_SCRATCH		       0x0028
 #define RADEON_BIOS_7_SCRATCH		       0x002c
 
+#define HDP_SOFT_RESET                             (1 << 26)
 
 #define CLK_PIN_CNTL                               0x0001
 #define PPLL_CNTL                                  0x0002
diff -ur linux-2.4.19-pre2/drivers/video/radeonfb.c linux.pdh/drivers/video/radeonfb.c
--- linux-2.4.19-pre2/drivers/video/radeonfb.c	Sat Apr  6 16:34:27 2002
+++ linux.pdh/drivers/video/radeonfb.c	Sun Apr 14 19:18:16 2002
@@ -22,6 +22,13 @@
  *
  *	Special thanks to ATI DevRel team for their hardware donations.
  *
+ * 	2002-04-xx	Added MTRR support. Fixed 8bpp acceleration. Added
+ * 			acceleration for 16/32bpp. Applied fix from XFree86
+ * 			for hard crash on accelerator reset. Fixed up the
+ * 			colour stuff. Made "ypan" work. Don't reload PLL
+ * 			unless pixel clock changes. Soft cursor improvements.
+ * 			Add module options. Various other fixes / cleanups.
+ * 			Peter Horton <pdh@colonel-panic.org>
  */
 
 
@@ -44,6 +51,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
+#include <asm/mtrr.h>
 
 #include <asm/io.h>
 #if defined(__powerpc__)
@@ -73,18 +81,22 @@
 #include <video/fbcon.h> 
 #include <video/fbcon-cfb8.h>
 #include <video/fbcon-cfb16.h>
-#include <video/fbcon-cfb24.h>
+/* #include <video/fbcon-cfb24.h> */
 #include <video/fbcon-cfb32.h>
 
 #include "radeon.h"
 
 
-#define DEBUG	0
+#define FIX_DEPTH_15		1
+
+#define DEBUG			0
+
+#define _RTRACE(f,a...)		do{printk(KERN_DEBUG "radeonfb: " f "\n", ##a);}while(0)
 
 #if DEBUG
-#define RTRACE		printk
+#define RTRACE(f,a...)		_RTRACE(f,##a)
 #else
-#define RTRACE		if(0) printk
+#define RTRACE(f,a...)
 #endif
 
 
@@ -261,6 +273,8 @@
 	u32 mmio_base;
 	u32 fb_base;
 
+	int mtrr_hdl;
+
 	struct pci_dev *pdev;
 
 	unsigned char *EDID;
@@ -270,13 +284,16 @@
 	int currcon;
 	struct display *currcon_display;
 
-	struct { u8 red, green, blue, pad; } palette[256];
+	u8 palette_red[256];
+	u8 palette_grn[256];
+	u8 palette_blu[256];
 
 	int chipset;
 	int video_ram;
 	u8 rev;
 	int pitch, bpp, depth;
 	int xres, yres, pixclock;
+	int ppixclock;
 
 	int use_default_var;
 	int got_dfpinfo;
@@ -299,17 +316,16 @@
 
 	struct ram_info ram;
 
+#if 0
         u32 hack_crtc_ext_cntl;
         u32 hack_crtc_v_sync_strt_wid;
+#endif
 
 #if defined(FBCON_HAS_CFB16) || defined(FBCON_HAS_CFB32)
         union {
 #if defined(FBCON_HAS_CFB16)
                 u_int16_t cfb16[16];
 #endif
-#if defined(FBCON_HAS_CFB24)
-                u_int32_t cfb24[16];
-#endif  
 #if defined(FBCON_HAS_CFB32)
                 u_int32_t cfb32[16];
 #endif  
@@ -474,17 +490,15 @@
 }
 
 
-static inline int var_to_depth(const struct fb_var_screeninfo *var)
+static __inline__ int var_to_depth(const struct fb_var_screeninfo *var)
 {
-	if (var->bits_per_pixel != 16)
-		return var->bits_per_pixel;
-	return (var->green.length == 6) ? 16 : 15;
+	return (var->bits_per_pixel == 16 && var->green.length == 5) ? 15 : var->bits_per_pixel;
 }
 
 
 static void _radeon_engine_reset(struct radeonfb_info *rinfo)
 {
-	u32 clock_cntl_index, mclk_cntl, rbbm_soft_reset;
+	u32 clock_cntl_index, mclk_cntl, rbbm_soft_reset, host_path_cntl;
 
 	radeon_engine_flush (rinfo);
 
@@ -498,6 +512,9 @@
 			   FORCEON_YCLKB |
 			   FORCEON_MC |
 			   FORCEON_AIC));
+
+	host_path_cntl = INREG(HOST_PATH_CNTL);
+
 	rbbm_soft_reset = INREG(RBBM_SOFT_RESET);
 
 	OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset |
@@ -507,8 +524,7 @@
 				SOFT_RESET_RE |
 				SOFT_RESET_PP |
 				SOFT_RESET_E2 |
-				SOFT_RESET_RB |
-				SOFT_RESET_HDP);
+				SOFT_RESET_RB);
 	INREG(RBBM_SOFT_RESET);
 	OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset & (u32)
 				~(SOFT_RESET_CP |
@@ -517,13 +533,16 @@
 				  SOFT_RESET_RE |
 				  SOFT_RESET_PP |
 				  SOFT_RESET_E2 |
-				  SOFT_RESET_RB |
-				  SOFT_RESET_HDP));
+				  SOFT_RESET_RB));
 	INREG(RBBM_SOFT_RESET);
 
-	OUTPLL(MCLK_CNTL, mclk_cntl);
-	OUTREG(CLOCK_CNTL_INDEX, clock_cntl_index);
+	OUTREG(HOST_PATH_CNTL, host_path_cntl | HDP_SOFT_RESET);
+	INREG(HOST_PATH_CNTL);
+	OUTREG(HOST_PATH_CNTL, host_path_cntl);
+
 	OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset);
+	OUTREG(CLOCK_CNTL_INDEX, clock_cntl_index);
+	OUTPLL(MCLK_CNTL, mclk_cntl);
 
 	return;
 }
@@ -531,6 +550,7 @@
 #define radeon_engine_reset()		_radeon_engine_reset(rinfo)
 
 
+#if 0
 static __inline__ u8 radeon_get_post_div_bitval(int post_div)
 {
         switch (post_div) {
@@ -552,6 +572,7 @@
                         return 0x02;
         }
 }
+#endif
 
 
 
@@ -592,16 +613,29 @@
  * globals
  */
         
-static char fontname[40] __initdata;
 static char *mode_option __initdata;
-static char noaccel __initdata = 0;
-static int panel_yres __initdata = 0;
-static char force_dfp __initdata = 0;
-static struct radeonfb_info *board_list = NULL;
+static struct radeonfb_info *board_list;
+
+char *font __initdata;
+int noaccel;
+int nofastsw;
+int fb16fix;
+int nostretch;
+int nomtrr __initdata;
+int panel_yres __initdata;
+int dfp __initdata;
 
 #ifdef FBCON_HAS_CFB8
 static struct display_switch fbcon_radeon8;
 #endif
+#ifdef FBCON_HAS_CFB16
+static struct display_switch fbcon_radeon16;
+static struct display_switch fbcon_radeon16_noaccel;
+#endif
+#ifdef FBCON_HAS_CFB32
+static struct display_switch fbcon_radeon32;
+static struct display_switch fbcon_radeon32_noaccel;
+#endif
 
 
 /*
@@ -686,6 +720,59 @@
 };
 
 
+int __init radeonfb_setup (char *options)
+{
+	static char *opts[] = {
+		"font:",
+		"noaccel",
+		"dfp",
+		"panel_yres:",
+		"nomtrr",
+		"fb16fix",
+		"nofastsw",
+		"nostretch",
+		NULL
+	};
+
+        char *this_opt, *value;
+	int idx;
+
+        if (!options || !*options)
+                return 0;
+ 
+	while ((this_opt = strsep (&options, ",")) != NULL) {
+
+		if (!*this_opt)
+			continue;
+
+		for (idx = 0; opts[idx] && strncmp(this_opt, opts[idx], strlen(opts[idx])); ++idx)
+			;
+		if (!opts[idx]) {
+			mode_option = this_opt;
+			continue;
+		}
+		value = this_opt + strlen(opts[idx]);
+
+		switch(idx) {
+
+			case 0:	font = value;	break;
+			case 1: noaccel = 1;	break;
+			case 2: dfp = 1;	break;
+
+			case 3:
+				panel_yres = simple_strtoul(value, NULL, 0);
+				break;
+
+			case 4: nomtrr = 1;	break;
+			case 5: fb16fix = 1;	break;
+			case 6: nofastsw = 1;	break;
+			case 7: nostretch = 1;	break;
+		}
+        }
+
+	return 0;
+}
+
 static struct pci_driver radeonfb_driver = {
 	name:		"radeonfb",
 	id_table:	radeonfb_pci_table,
@@ -696,6 +783,13 @@
 
 int __init radeonfb_init (void)
 {
+	/* XXX stop the module being unloaded. on my machine *
+	 * it causes a crash, and looking at the code it     *
+	 * doesn't restore PLL settings so the chances of it *
+	 * working are zero anyway                      :pdh */
+
+	MOD_DEC_USE_COUNT;
+
 	return pci_module_init (&radeonfb_driver);
 }
 
@@ -706,47 +800,12 @@
 }
 
 
-int __init radeonfb_setup (char *options)
-{
-        char *this_opt;
-
-        if (!options || !*options)
-                return 0;
- 
-	while ((this_opt = strsep (&options, ",")) != NULL) {
-		if (!*this_opt)
-			continue;
-                if (!strncmp (this_opt, "font:", 5)) {
-                        char *p;
-                        int i;
-        
-                        p = this_opt + 5;
-                        for (i=0; i<sizeof (fontname) - 1; i++)
-                                if (!*p || *p == ' ' || *p == ',')
-                                        break;
-                        memcpy(fontname, this_opt + 5, i);
-                } else if (!strncmp(this_opt, "noaccel", 7)) {
-			noaccel = 1;
-		} else if (!strncmp(this_opt, "dfp", 3)) {
-			force_dfp = 1;
-		} else if (!strncmp(this_opt, "panel_yres:", 11)) {
-			panel_yres = simple_strtoul((this_opt+11), NULL, 0);
-                } else
-			mode_option = this_opt;
-        }
-
-	return 0;
-}
-
 #ifdef MODULE
 module_init(radeonfb_init);
 module_exit(radeonfb_exit);
 #endif
 
 
-MODULE_AUTHOR("Ani Joshi");
-MODULE_DESCRIPTION("framebuffer driver for ATI Radeon chipset");
-MODULE_LICENSE("GPL");
 
 static int radeonfb_pci_register (struct pci_dev *pdev,
 				  const struct pci_device_id *ent)
@@ -755,7 +814,7 @@
 	u32 tmp;
 	int i, j;
 
-	RTRACE("radeonfb_pci_register BEGIN\n");
+	RTRACE("radeonfb_pci_register BEGIN");
 
 	rinfo = kmalloc (sizeof (struct radeonfb_info), GFP_KERNEL);
 	if (!rinfo) {
@@ -915,7 +974,7 @@
 	rinfo->bios_seg = radeon_find_rom(rinfo);
 	radeon_get_pllinfo(rinfo, rinfo->bios_seg);
 
-	RTRACE("radeonfb: probed %s %dk videoram\n", (rinfo->ram_type), (rinfo->video_ram/1024));
+	RTRACE("probed %s %dk videoram", (rinfo->ram_type), (rinfo->video_ram/1024));
 
 #if !defined(__powerpc__)
 	radeon_get_moninfo(rinfo);
@@ -960,9 +1019,6 @@
 		return -ENODEV;
 	}
 
-	/* XXX turn off accel for now, blts aren't working right */
-	noaccel = 1;
-
 	/* currcon not yet configured, will be set by first switch */
 	rinfo->currcon = -1;
 
@@ -977,9 +1033,9 @@
 	/* init palette */
 	for (i=0; i<16; i++) {
 		j = color_table[i];
-		rinfo->palette[i].red = default_red[j];
-		rinfo->palette[i].green = default_grn[j];
-		rinfo->palette[i].blue = default_blu[j];
+		rinfo->palette_red[i] = default_red[j];
+		rinfo->palette_grn[i] = default_grn[j];
+		rinfo->palette_blu[i] = default_blu[j];
 	}
 
 	pci_set_drvdata(pdev, rinfo);
@@ -998,10 +1054,16 @@
 		return -ENODEV;
 	}
 
+#ifdef CONFIG_MTRR
+	rinfo->mtrr_hdl = nomtrr ? -1 : mtrr_add(rinfo->fb_base_phys, rinfo->video_ram, MTRR_TYPE_WRCOMB, 1);
+#endif
+
+#if 0
 	if (!noaccel) {
 		/* initialize the engine */
 		radeon_engine_init (rinfo);
 	}
+#endif
 
 #ifdef CONFIG_PMAC_BACKLIGHT
 	if (rinfo->dviDisp_type == MT_LCD)
@@ -1029,7 +1091,7 @@
 			GET_MON_NAME(rinfo->crtDisp_type));
 	}
 
-	RTRACE("radeonfb_pci_register END\n");
+	RTRACE("radeonfb_pci_register END");
 
 	return 0;
 }
@@ -1044,8 +1106,16 @@
                 return;
  
 	/* restore original state */
+
+	/* XXX what about the PLL? :pdh */
+
         radeon_write_mode (rinfo, &rinfo->init_state);
  
+#ifdef CONFIG_MTRR
+	if(rinfo->mtrr_hdl >= 0)
+		mtrr_del(rinfo->mtrr_hdl, 0, 0);
+#endif
+
         unregister_framebuffer ((struct fb_info *) rinfo);
                 
         iounmap ((void*)rinfo->mmio_base);
@@ -1157,7 +1227,7 @@
         	rinfo->pll.ppll_min = pll.PCLK_min_freq;
         	rinfo->pll.ppll_max = pll.PCLK_max_freq;
 
-		printk("radeonfb: ref_clk=%d, ref_div=%d, xclk=%d from BIOS\n",
+		_RTRACE("ref_clk=%d, ref_div=%d, xclk=%d from BIOS",
 			rinfo->pll.ref_clk, rinfo->pll.ref_div, rinfo->pll.xclk);
 	} else {
 #ifdef CONFIG_ALL_PPC
@@ -1177,7 +1247,7 @@
 			rinfo->pll.ppll_min = 12000;
 			rinfo->pll.ppll_max = 35000;
 
-			printk("radeonfb: ref_clk=%d, ref_div=%d, xclk=%d from OF\n",
+			_RTRACE("ref_clk=%d, ref_div=%d, xclk=%d from OF",
 				rinfo->pll.ref_clk, rinfo->pll.ref_div, rinfo->pll.xclk);
 
 			return;
@@ -1212,7 +1282,7 @@
 				break;
 		}
 
-		printk("radeonfb: ref_clk=%d, ref_div=%d, xclk=%d defaults\n",
+		_RTRACE("ref_clk=%d, ref_div=%d, xclk=%d defaults",
 			rinfo->pll.ref_clk, rinfo->pll.ref_div, rinfo->pll.xclk);
 	}
 }
@@ -1222,7 +1292,7 @@
 {
 	unsigned int tmp;
 
-	if (force_dfp) {
+	if (dfp) {
 		rinfo->dviDisp_type = MT_DFP;
 		return;
 	}
@@ -1271,7 +1341,7 @@
 {
 #ifdef CONFIG_ALL_PPC
 	if (!radeon_get_EDID_OF(rinfo))
-		RTRACE("radeonfb: could not retrieve EDID from OF\n");
+		RTRACE("radeonfb: could not retrieve EDID from OF");
 #else
 	/* XXX use other methods later */
 #endif
@@ -1540,15 +1610,12 @@
 	radeon_engine_reset ();
 
 	radeon_fifo_wait (1);
-	OUTREG(DSTCACHE_MODE, 0);
-
-	/* XXX */
-	rinfo->pitch = ((rinfo->xres * (rinfo->bpp / 8) + 0x3f)) >> 6;
+	OUTREG(RB2D_DSTCACHE_MODE, 0);
 
 	radeon_fifo_wait (1);
 	temp = INREG(DEFAULT_PITCH_OFFSET);
 	OUTREG(DEFAULT_PITCH_OFFSET, ((temp & 0xc0000000) | 
-				      (rinfo->pitch << 0x16)));
+				      (rinfo->pitch << 16)));
 
 	radeon_fifo_wait (1);
 	OUTREGP(DP_DATATYPE, 0, ~HOST_BIG_ENDIAN_EN);
@@ -1589,6 +1656,8 @@
 static int __devinit radeon_set_fbinfo (struct radeonfb_info *rinfo)
 {
 	struct fb_info *info;
+	char *ptr;
+	int len;
 
 	info = &rinfo->info;
 
@@ -1597,13 +1666,21 @@
         info->flags = FBINFO_FLAG_DEFAULT;
         info->fbops = &radeon_fb_ops;
         info->display_fg = NULL;
-        strncpy (info->fontname, fontname, sizeof (info->fontname));
-        info->fontname[sizeof (info->fontname) - 1] = 0;
         info->changevar = NULL;
         info->switch_con = radeonfb_switch;
         info->updatevar = radeonfb_updatevar;
         info->blank = radeonfb_blank;
 
+	len = 0;
+	if(font) {
+		ptr = strchr(font, ',');
+		len = (ptr == NULL) ? strlen(font) : ptr - font;
+		if(len > sizeof(info->fontname) - 1)
+			len = sizeof(info->fontname) - 1;
+		memcpy(info->fontname, font, len);
+	}
+	info->fontname[len] = '\0';
+
         if (radeon_init_disp (rinfo) < 0)
                 return -1;   
 
@@ -1635,11 +1712,8 @@
 
         radeon_set_dispsw (rinfo, disp);
 
-	if (noaccel)
-	        disp->scrollmode = SCROLL_YREDRAW;
-	else
-		disp->scrollmode = 0;
-        
+	disp->scrollmode = noaccel ? SCROLL_YREDRAW : 0;
+
         rinfo->currcon_display = disp;
 
         if ((radeon_init_disp_var (rinfo)) < 0)
@@ -1665,13 +1739,15 @@
 	}
 	else
 #endif
-	if (rinfo->use_default_var)
+#ifndef MODULE
+	if (rinfo->use_default_var == 0)
+                fb_find_mode (&rinfo->disp.var, &rinfo->info, "640x480-8@60",
+                              NULL, 0, NULL, 0);
+	else
+#endif
 		/* We will use the modified default far */
 		rinfo->disp.var = radeonfb_default_var;
-	else
 
-                fb_find_mode (&rinfo->disp.var, &rinfo->info, "640x480-8@60",
-                              NULL, 0, NULL, 0);
 
 	if (noaccel)
 		rinfo->disp.var.accel_flags &= ~FB_ACCELF_TEXT;
@@ -1703,30 +1779,22 @@
         switch (disp->var.bits_per_pixel) {
 #ifdef FBCON_HAS_CFB8
                 case 8:
-                        disp->dispsw = &fbcon_cfb8;
+                        disp->dispsw = accel ? &fbcon_radeon8 : &fbcon_cfb8;
                         disp->visual = FB_VISUAL_PSEUDOCOLOR;
                         disp->line_length = disp->var.xres_virtual;
                         break;
 #endif
 #ifdef FBCON_HAS_CFB16
                 case 16:
-                        disp->dispsw = &fbcon_cfb16;
+                        disp->dispsw = accel ? &fbcon_radeon16 : &fbcon_radeon16_noaccel;
                         disp->dispsw_data = &rinfo->con_cmap.cfb16;
                         disp->visual = FB_VISUAL_DIRECTCOLOR;
                         disp->line_length = disp->var.xres_virtual * 2;
                         break;
 #endif  
-#ifdef FBCON_HAS_CFB32       
-                case 24:
-                        disp->dispsw = &fbcon_cfb24;
-                        disp->dispsw_data = &rinfo->con_cmap.cfb24;
-                        disp->visual = FB_VISUAL_DIRECTCOLOR;
-                        disp->line_length = disp->var.xres_virtual * 4;
-                        break;
-#endif
 #ifdef FBCON_HAS_CFB32
                 case 32:
-                        disp->dispsw = &fbcon_cfb32;
+                        disp->dispsw = accel ? &fbcon_radeon32 : &fbcon_radeon32_noaccel;
                         disp->dispsw_data = &rinfo->con_cmap.cfb32;
                         disp->visual = FB_VISUAL_DIRECTCOLOR;
                         disp->line_length = disp->var.xres_virtual * 4;
@@ -1736,8 +1804,8 @@
                         printk ("radeonfb: setting fbcon_dummy renderer\n");
                         disp->dispsw = &fbcon_dummy;
         }
-                
-        return;
+
+	disp->next_line = disp->line_length;
 }
                         
 
@@ -1759,6 +1827,7 @@
 
 
 
+#if 0
 static int radeonfb_do_maximize(struct radeonfb_info *rinfo,
                                 struct fb_var_screeninfo *var,
                                 struct fb_var_screeninfo *v,
@@ -1819,9 +1888,18 @@
                                 
         return 0;
 }
+#endif
                         
 
 
+static void set_palette_entry(struct radeonfb_info *rinfo, unsigned idx, unsigned red, unsigned grn, unsigned blu)
+{
+	OUTREG(PALETTE_INDEX, idx);
+	OUTREG(PALETTE_DATA, (red << 16) | (grn << 8) | blu);
+
+	udelay(1);	/* is this necessary ? */
+}
+
 /*
  * fb ops
  */
@@ -1844,7 +1922,7 @@
         fix->type_aux = disp->type_aux;
         fix->visual = disp->visual;
 
-        fix->xpanstep = 8;
+        fix->xpanstep = 0;
         fix->ypanstep = 1;
         fix->ywrapstep = 0;
         
@@ -1855,7 +1933,7 @@
 	if (noaccel)
 	        fix->accel = FB_ACCEL_NONE;
 	else
-		fix->accel = 40;	/* XXX */
+		fix->accel = FB_ACCEL_ATI_RADEON;
         
         return 0;
 }
@@ -1878,134 +1956,119 @@
                              struct fb_info *info)
 {
         struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
-        struct display *disp;
+        int accel, bytpp, pitch, mon, chgvar;
         struct fb_var_screeninfo v;
-        int nom, den, accel;
-        unsigned chgvar = 0;
+        struct display *disp;
 
         disp = (con < 0) ? rinfo->info.disp : &fb_display[con];
 
         accel = var->accel_flags & FB_ACCELF_TEXT;
 
-        if (con >= 0) {
-                chgvar = ((disp->var.xres != var->xres) ||
-                          (disp->var.yres != var->yres) ||
-                          (disp->var.xres_virtual != var->xres_virtual) ||
-                          (disp->var.yres_virtual != var->yres_virtual) ||
-                          (disp->var.bits_per_pixel != var->bits_per_pixel) ||
-                          memcmp (&disp->var.red, &var->red, sizeof (var->red)) ||
-                          memcmp (&disp->var.green, &var->green, sizeof (var->green)) ||
-                          memcmp (&disp->var.blue, &var->blue, sizeof (var->blue)));
-        }
+	/* XXX we should probably fixup 'var' in place rather than  *
+	 * fixing up a copy as FBIOPUT_VSCREENINFO goes to the      *
+	 * trouble of copying the structure back to user space :pdh */
 
         memcpy (&v, var, sizeof (v));
 
-        switch (v.bits_per_pixel) {
-		case 0 ... 8:
-			v.bits_per_pixel = 8;
-			break;
-		case 9 ... 16:
-			v.bits_per_pixel = 16;
-			break;
-		case 17 ... 24:
-			v.bits_per_pixel = 24;
-			break;
-		case 25 ... 32:
-			v.bits_per_pixel = 32;
-			break;
-		default:
-			return -EINVAL;
-	}
-
-	switch (var_to_depth(&v)) {
 #ifdef FBCON_HAS_CFB8
-                case 8:
-                        nom = den = 1;
-                        disp->line_length = v.xres_virtual;
-                        disp->visual = FB_VISUAL_PSEUDOCOLOR; 
-                        v.red.offset = v.green.offset = v.blue.offset = 0;
-                        v.red.length = v.green.length = v.blue.length = 8;
-                        v.transp.offset = v.transp.length = 0;
-                        break;
+	if(v.bits_per_pixel <= 8) {
+		v.bits_per_pixel = 8;
+		v.red.offset = v.green.offset = v.blue.offset = 0;
+		v.red.length = v.green.length = v.blue.length = 8;
+		v.transp.offset = v.transp.length = 0;
+	} else
 #endif
-                        
 #ifdef FBCON_HAS_CFB16
-		case 15:
-			nom = 2;
-			den = 1;
-			disp->line_length = v.xres_virtual * 2;
-			disp->visual = FB_VISUAL_DIRECTCOLOR;
-			v.red.offset = 10;
-			v.green.offset = 5;
-			v.red.offset = 0;
-			v.red.length = v.green.length = v.blue.length = 5;
-			v.transp.offset = v.transp.length = 0;
-			break;
-                case 16:
-                        nom = 2;
-                        den = 1;
-                        disp->line_length = v.xres_virtual * 2;
-                        disp->visual = FB_VISUAL_DIRECTCOLOR;
-                        v.red.offset = 11;
-                        v.green.offset = 5;
-                        v.blue.offset = 0;
-                        v.red.length = 5;
-                        v.green.length = 6;
-                        v.blue.length = 5;
-                        v.transp.offset = v.transp.length = 0;
-                        break;  
-#endif
-                        
-#ifdef FBCON_HAS_CFB24
-                case 24:
-                        nom = 4;
-                        den = 1;
-                        disp->line_length = v.xres_virtual * 3;
-                        disp->visual = FB_VISUAL_DIRECTCOLOR;
-                        v.red.offset = 16;
-                        v.green.offset = 8;
-                        v.blue.offset = 0;
-                        v.red.length = v.blue.length = v.green.length = 8;
-                        v.transp.offset = v.transp.length = 0;
-                        break;
+	if(v.bits_per_pixel <= 16) {
+#if FIX_DEPTH_15
+		if(v.bits_per_pixel < 16)
+			v.green.length = 5;
+#endif
+		if(v.green.length < 6)
+			v.green.length = 5;
+		else if(v.green.length > 6)
+			v.green.length = 6;
+		v.bits_per_pixel = 16;
+		v.red.offset = v.green.length + 5;
+		v.green.offset = 5;
+		v.blue.offset = 0;
+		v.red.length = 5;
+		v.blue.length = 5;
+		v.transp.offset = v.transp.length = 0;
+	} else
 #endif
 #ifdef FBCON_HAS_CFB32
-                case 32:
-                        nom = 4;
-                        den = 1;
-                        disp->line_length = v.xres_virtual * 4;
-                        disp->visual = FB_VISUAL_DIRECTCOLOR;
-                        v.red.offset = 16;
-                        v.green.offset = 8;
-                        v.blue.offset = 0;
-                        v.red.length = v.blue.length = v.green.length = 8;
-                        v.transp.offset = 24;
-                        v.transp.length = 8;
-                        break;
+	if(v.bits_per_pixel <= 32) {
+		v.bits_per_pixel = 32;
+		v.red.offset = 16;
+		v.green.offset = 8;
+		v.blue.offset = 0;
+		v.red.length = v.blue.length = v.green.length = 8;
+		/* v.transp.offset = 24; v.transp.length = 8; */
+		v.transp.offset = v.transp.length = 0;
+	} else
 #endif
-                default:
-                        printk ("radeonfb: mode %dx%dx%d rejected, color depth invalid\n",
-                                var->xres, var->yres, var->bits_per_pixel);
-                        return -EINVAL;
-        }
+		return -EINVAL;
+
+        v.red.msb_right = v.green.msb_right = v.blue.msb_right = v.transp.msb_right = 0;
+
+	mon = PRIMARY_MONITOR(rinfo);
+
+	if(mon == MT_LCD || mon == MT_DFP) {
+		if(v.xres > rinfo->panel_xres)
+			v.xres = rinfo->panel_xres;
+		if(v.yres > rinfo->panel_yres)
+			v.yres = rinfo->panel_yres;
+	}
+
+	if(v.xres > v.xres_virtual)
+		v.xres_virtual = v.xres;
+	if(v.yres > v.yres_virtual)
+		v.yres_virtual = v.yres;
+
+	/* XXX this is probably wrong for 24bpp, if we ever get it working :pdh */
+
+	bytpp = v.bits_per_pixel >> 3;
+
+	pitch = (v.xres_virtual * bytpp + 63) & ~63;
+
+	if(pitch >= 8192)
+		pitch = 8192 - 64;
+
+	v.xres_virtual = pitch / bytpp;
+
+	if(v.xres_virtual < v.xres)
+		v.xres = v.xres_virtual;
+	
+	v.yres_virtual = rinfo->video_ram / pitch;
+
+	/* XXX there is some limit here, I chose 8192 :pdh */
+
+	if(v.yres_virtual >= 8192)
+		v.yres_virtual = 8191;
+
+	if(v.yres_virtual < v.yres)
+		v.yres = v.yres_virtual;
 
+#if 0
         if (radeonfb_do_maximize(rinfo, var, &v, nom, den) < 0)
                 return -EINVAL;  
+#endif
                 
+	/* XXX we don't do X pan yet :pdh */
+
+	v.xoffset = 0;
+
         if (v.xoffset < 0)
                 v.xoffset = 0;
         if (v.yoffset < 0)
                 v.yoffset = 0;
          
         if (v.xoffset > v.xres_virtual - v.xres)
-                v.xoffset = v.xres_virtual - v.xres - 1;
+		v.xoffset = v.xres_virtual - v.xres;
                         
         if (v.yoffset > v.yres_virtual - v.yres)
-                v.yoffset = v.yres_virtual - v.yres - 1;
-         
-        v.red.msb_right = v.green.msb_right = v.blue.msb_right =
-                          v.transp.offset = v.transp.length =
-                          v.transp.msb_right = 0;
+		v.yoffset = v.yres_virtual - v.yres;
                         
         switch (v.activate & FB_ACTIVATE_MASK) {
                 case FB_ACTIVATE_TEST:
@@ -2016,17 +2079,29 @@
                 default:
                         return -EINVAL;
         }
-        
-        memcpy (&disp->var, &v, sizeof (v));
-        
-        if (chgvar) {     
-                radeon_set_dispsw(rinfo, disp);
 
-                if (noaccel)
-                        disp->scrollmode = SCROLL_YREDRAW;
-                else
-                        disp->scrollmode = 0;
-                
+        chgvar = (con >= 0 &&
+		(disp->var.xres != v.xres ||
+		disp->var.yres != v.yres ||
+		disp->var.xres_virtual != v.xres_virtual ||
+		disp->var.yres_virtual != v.yres_virtual ||
+		disp->var.bits_per_pixel != v.bits_per_pixel ||
+		memcmp (&disp->var.red, &v.red, sizeof (v.red)) ||
+		memcmp (&disp->var.green, &v.green, sizeof (v.green)) ||
+		memcmp (&disp->var.blue, &v.blue, sizeof (v.blue))));
+
+	memcpy (&disp->var, &v, sizeof (v));
+
+	if(chgvar) {
+
+		radeon_set_dispsw(rinfo, disp);
+
+		disp->scrollmode = noaccel ? SCROLL_YREDRAW : 0;
+
+		/* XXX needed by radeon_setcolreg() called fron ->changevar() :pdh */
+
+		rinfo->depth = var_to_depth(&v);
+
                 if (info && info->changevar)
                         info->changevar(con);
         }
@@ -2035,6 +2110,9 @@
                 
         do_install_cmap(con, info);
   
+	if(accel)
+		radeon_engine_init(rinfo);
+
         return 0;
 }
 
@@ -2093,6 +2171,8 @@
                                  struct fb_info *info)
 {
         struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
+
+#if 0
         u32 offset, xoffset, yoffset;
                 
         xoffset = (var->xoffset + 7) & ~7;
@@ -2105,7 +2185,18 @@
         offset = ((yoffset * var->xres + xoffset) * var->bits_per_pixel) >> 6;
          
         OUTREG(CRTC_OFFSET, offset);
+#endif
+
+	/* XXX no X pan for the moment, think about the accelerator :pdh */
+
+	if(var->xoffset)
+		return -EINVAL;
         
+	if(var->yoffset + var->yres > var->yres_virtual)
+		return -EINVAL;
+
+	OUTREG(CRTC_OFFSET, var->yoffset * rinfo->pitch);
+
         return 0;
 }
 
@@ -2144,12 +2235,14 @@
                 do_install_cmap(con, info);
         }       
 
+#if 0
         /* XXX absurd hack for X to restore console */
         {   
 		OUTREGP(CRTC_EXT_CNTL, rinfo->hack_crtc_ext_cntl,
 			CRTC_HSYNC_DIS | CRTC_VSYNC_DIS | CRTC_DISPLAY_DIS);
                 OUTREG(CRTC_V_SYNC_STRT_WID, rinfo->hack_crtc_v_sync_strt_wid);
         }
+#endif
 
         return 0;
 }
@@ -2214,18 +2307,7 @@
 
 static int radeon_get_cmap_len (const struct fb_var_screeninfo *var)
 {
-        int rc = 256;            /* reasonable default */
-        
-        switch (var_to_depth(var)) {
-                case 15:
-                        rc = 32;
-                        break;
-		case 16:
-			rc = 64;
-			break;
-        }
-                
-        return rc;
+	return var->bits_per_pixel == 16 ? (var->green.length == 5 ? 32 : 64) : 256;
 }
 
 
@@ -2239,10 +2321,9 @@
 	if (regno > 255)
 		return 1;
      
- 	*red = (rinfo->palette[regno].red<<8) | rinfo->palette[regno].red; 
-    	*green = (rinfo->palette[regno].green<<8) | rinfo->palette[regno].green;
-    	*blue = (rinfo->palette[regno].blue<<8) | rinfo->palette[regno].blue;
-    	*transp = 0;
+ 	*red	= (unsigned) rinfo->palette_red[regno] << 8;
+    	*green	= (unsigned) rinfo->palette_grn[regno] << 8;
+    	*blue	= (unsigned) rinfo->palette_blu[regno] << 8;
 
 	return 0;
 }                            
@@ -2250,78 +2331,76 @@
 
 
 static int radeon_setcolreg (unsigned regno, unsigned red, unsigned green,
-                             unsigned blue, unsigned transp, struct fb_info *info)
+                             unsigned blue, unsigned alpha, struct fb_info *info)
 {
         struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
-	u32 pindex;
 
-	if (regno > 255)
+	if(regno > 255)
 		return 1;
 
-	red >>= 8;
-	green >>= 8;
-	blue >>= 8;
-	rinfo->palette[regno].red = red;
-	rinfo->palette[regno].green = green;
-	rinfo->palette[regno].blue = blue;
+	red	>>= 8;
+	green	>>= 8;
+	blue	>>= 8;
+	alpha	>>= 8;
+
+	rinfo->palette_red[regno] = red;
+	rinfo->palette_grn[regno] = green;
+	rinfo->palette_blu[regno] = blue;
 
-        /* default */
-        pindex = regno;
-        
-	if (rinfo->bpp == 16) {
-		pindex = regno * 8;
+#ifdef FBCON_HAS_CFB16
+	if(rinfo->depth == 15) {
 
-		if (rinfo->depth == 16 && regno > 63)
-			return 1;
-		if (rinfo->depth == 15 && regno > 31)
+		if(regno > 31)
 			return 1;
+		if(regno < 16)
+			rinfo->con_cmap.cfb16[regno] = (regno << 10) | (regno << 5) | regno;
+		regno <<= 3;
+
+	} else if(rinfo->depth == 16) {
+
+		if(fb16fix) {
+
+			/* this is just another format of 15 bit mode, the LSB of the   *
+			 * green pixel data is ignored. this is required for "fbtv" and *
+			 * other apps to work correctly at 16bpp, but it means you land *
+			 * up with a sick looking boot logo. the real fix is to run at  *
+			 * 15bpp when you want to use those apps                   :pdh */
+
+			if(regno > 31)
+				return 1;
+			if(regno < 16)
+				rinfo->con_cmap.cfb16[regno] = (regno << 11) | (regno << 6) | regno;
+			regno <<= 3;
+			set_palette_entry(rinfo, regno | 4, red, green, blue);
 
-		/* For 565, the green component is mixed one order below */
-		if (rinfo->depth == 16) {
-	                OUTREG(PALETTE_INDEX, pindex>>1);
-       	         	OUTREG(PALETTE_DATA, (rinfo->palette[regno>>1].red << 16) |
-                        	(green << 8) | (rinfo->palette[regno>>1].blue));
-                	green = rinfo->palette[regno<<1].green;
-        	}
-	}
-
-	if (rinfo->depth != 16 || regno < 32) {
-		OUTREG(PALETTE_INDEX, pindex);
-		OUTREG(PALETTE_DATA, (red << 16) | (green << 8) | blue);
-	}
+		} else {
 
- 	if (regno < 16) {
-        	switch (rinfo->depth) {
-#ifdef FBCON_HAS_CFB16
-		        case 15:
-        			rinfo->con_cmap.cfb16[regno] = (regno << 10) | (regno << 5) |
-				                       	 	  regno;   
-			        break;
-		        case 16:
-        			rinfo->con_cmap.cfb16[regno] = (regno << 11) | (regno << 5) |
-				                       	 	  regno;   
-			        break;
-#endif
-#ifdef FBCON_HAS_CFB24
-                        case 24:
-                                rinfo->con_cmap.cfb24[regno] = (regno << 16) | (regno << 8) | regno;
-                                break;
+			if(regno > 63)
+				return 1;
+			if(regno < 16)
+				rinfo->con_cmap.cfb16[regno] = (regno << 11) | (regno << 5) | regno;
+			set_palette_entry(rinfo, regno << 2, rinfo->palette_red[regno >> 1],
+				green, rinfo->palette_blu[regno >> 1]);
+			if(regno > 31)
+				return 0;
+			regno <<= 1;
+			green = rinfo->palette_grn[regno];
+			regno <<= 2;
+		}
+	} else
 #endif
 #ifdef FBCON_HAS_CFB32
-	        	case 32: {
-            			u32 i;    
-   
-  		       		i = (regno << 8) | regno;
-            			rinfo->con_cmap.cfb32[regno] = (i << 16) | i;
-		        	break;
-        		}
+	if(rinfo->depth == 32) {
+
+		if(regno < 16)
+			rinfo->con_cmap.cfb32[regno] = (regno << 16) | (regno << 8) | regno;
+	}
 #endif
-		}
-        }
-	return 0;
-}
 
+	set_palette_entry(rinfo, regno, red, green, blue);
 
+	return 0;
+}
 
 static void radeon_save_state (struct radeonfb_info *rinfo,
                                struct radeon_regs *save)
@@ -2354,42 +2433,198 @@
 }
 
 
+static void calc_pll_regs(struct radeonfb_info *rinfo, struct radeon_regs *reg, u32 pixclock)
+{
+	static struct {
+		int divider;
+		int bitvalue;
+	} *post_div,
+	  post_divs[] = {
+		{ 1,  0 },
+		{ 2,  1 },
+		{ 4,  2 },
+		{ 8,  3 },
+		{ 3,  4 },
+		{ 16, 5 },
+		{ 6,  6 },
+		{ 12, 7 },
+		{ 0,  0 },
+	};
+	int freq;
+	
+	freq = 100000000 / pixclock;
+
+	if (freq > rinfo->pll.ppll_max)
+		freq = rinfo->pll.ppll_max;
+	if (freq*12 < rinfo->pll.ppll_min)
+		freq = rinfo->pll.ppll_min / 12;
+
+	for (post_div = &post_divs[0]; post_div->divider; ++post_div) {
+		rinfo->pll_output_freq = post_div->divider * freq;
+		if (rinfo->pll_output_freq >= rinfo->pll.ppll_min  &&
+		    rinfo->pll_output_freq <= rinfo->pll.ppll_max)
+			break;
+	}
+
+	rinfo->post_div = post_div->divider;
+	rinfo->fb_div = round_div(rinfo->pll.ref_div*rinfo->pll_output_freq,
+				  rinfo->pll.ref_clk);
+	reg->ppll_ref_div = rinfo->pll.ref_div;
+	reg->ppll_div_3 = rinfo->fb_div | (post_div->bitvalue << 16);
+
+	RTRACE("post div = 0x%x", rinfo->post_div);
+	RTRACE("fb_div = 0x%x", rinfo->fb_div);
+	RTRACE("ppll_div_3 = 0x%x", reg->ppll_div_3);
+}
+
+static void set_pll_regs(struct radeonfb_info *rinfo, struct radeon_regs *regs)
+{
+	if(!nofastsw && rinfo->pixclock == rinfo->ppixclock)
+		return;
+
+	while ((INREG(CLOCK_CNTL_INDEX) & PPLL_DIV_SEL_MASK) !=
+	       PPLL_DIV_SEL_MASK) {
+		OUTREGP(CLOCK_CNTL_INDEX, PPLL_DIV_SEL_MASK, 0xffff);
+	}
+
+	OUTPLLP(PPLL_CNTL, PPLL_RESET, 0xffff);
+
+	while ((INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK) !=
+	       (regs->ppll_ref_div & PPLL_REF_DIV_MASK)) {
+		OUTPLLP(PPLL_REF_DIV, regs->ppll_ref_div, ~PPLL_REF_DIV_MASK);
+	}
+
+	while ((INPLL(PPLL_DIV_3) & PPLL_FB3_DIV_MASK) !=
+	       (regs->ppll_div_3 & PPLL_FB3_DIV_MASK)) {
+		OUTPLLP(PPLL_DIV_3, regs->ppll_div_3, ~PPLL_FB3_DIV_MASK);
+	}
+
+	while ((INPLL(PPLL_DIV_3) & PPLL_POST3_DIV_MASK) !=
+	       (regs->ppll_div_3 & PPLL_POST3_DIV_MASK)) {
+		OUTPLLP(PPLL_DIV_3, regs->ppll_div_3, ~PPLL_POST3_DIV_MASK);
+	}
+
+	OUTPLL(HTOTAL_CNTL, 0);
+
+	OUTPLLP(PPLL_CNTL, 0, ~PPLL_RESET);
+}
+
+static void calc_dda_regs(struct radeonfb_info *rinfo, struct radeon_regs *regs)
+{
+        int xclk_freq, vclk_freq, xclk_per_trans, xclk_per_trans_precise;
+        int useable_precision, roff, ron;
+        int min_bits;
+
+	vclk_freq = round_div(rinfo->pll.ref_clk * rinfo->fb_div,
+			      rinfo->pll.ref_div * rinfo->post_div);
+	xclk_freq = rinfo->pll.xclk;
+
+	xclk_per_trans = round_div(xclk_freq * 128, vclk_freq * rinfo->bpp);
+
+	min_bits = min_bits_req(xclk_per_trans);
+	useable_precision = min_bits + 1;
+
+	xclk_per_trans_precise = round_div((xclk_freq * 128) << (11 - useable_precision),
+					   vclk_freq * rinfo->bpp);
+
+	ron = (4 * rinfo->ram.mb + 3 * _max(rinfo->ram.trcd - 2, 0) +
+	       2 * rinfo->ram.trp + rinfo->ram.twr + rinfo->ram.cl + rinfo->ram.tr2w +
+	       xclk_per_trans) << (11 - useable_precision);
+	roff = xclk_per_trans_precise * (32 - 4);
+
+	RTRACE("ron = %d, roff = %d", ron, roff);
+	RTRACE("vclk_freq = %d, per = %d", vclk_freq, xclk_per_trans_precise);
+
+	if ((ron + rinfo->ram.rloop) >= roff) {
+		printk("radeonfb: error ron out of range\n");
+		return;
+	}
+
+	regs->dda_config = (xclk_per_trans_precise |
+			      (useable_precision << 16) |
+			      (rinfo->ram.rloop << 20));
+	regs->dda_on_off = (ron << 16) | roff;
+}
+
+static void set_dda_regs(struct radeonfb_info *rinfo, struct radeon_regs *regs)
+{
+	OUTREG(DDA_CONFIG, regs->dda_config);
+	OUTREG(DDA_ON_OFF, regs->dda_on_off);
+}
+
+static void calc_stretch_regs(struct radeonfb_info *rinfo, struct radeon_regs *regs)
+{
+	unsigned int hRatio, vRatio;
+
+	regs->fp_horz_stretch = rinfo->init_state.fp_horz_stretch &
+		~(HORZ_STRETCH_BLEND | HORZ_STRETCH_ENABLE);
+
+	regs->fp_vert_stretch = rinfo->init_state.fp_vert_stretch &
+		~(VERT_STRETCH_BLEND | VERT_STRETCH_ENABLE);
+
+	if(nostretch)
+		return;
+
+	if (rinfo->xres != rinfo->panel_xres) {
+
+		regs->fp_horz_stretch = (((rinfo->panel_xres / 8) - 1)
+					   << HORZ_PANEL_SHIFT);
+
+		hRatio = round_div(rinfo->xres * HORZ_STRETCH_RATIO_MAX,
+				   rinfo->panel_xres);
+		regs->fp_horz_stretch = (((((unsigned long)hRatio) & HORZ_STRETCH_RATIO_MASK)) |
+					   (regs->fp_horz_stretch &
+					    (HORZ_PANEL_SIZE | HORZ_FP_LOOP_STRETCH |
+					     HORZ_AUTO_RATIO_INC)));
+		regs->fp_horz_stretch |= (HORZ_STRETCH_BLEND |
+					    HORZ_STRETCH_ENABLE);
+
+		regs->fp_horz_stretch &= ~HORZ_AUTO_RATIO;
+	}
+
+	if (rinfo->yres != rinfo->panel_yres) {
+
+		regs->fp_vert_stretch = ((rinfo->panel_yres - 1)
+					   << VERT_PANEL_SHIFT);
+		vRatio = round_div(rinfo->yres * VERT_STRETCH_RATIO_MAX,
+				   rinfo->panel_yres);
+		regs->fp_vert_stretch = (((((unsigned long)vRatio) & VERT_STRETCH_RATIO_MASK)) |
+					   (regs->fp_vert_stretch &
+					   (VERT_PANEL_SIZE | VERT_STRETCH_RESERVED)));
+		regs->fp_vert_stretch |= (VERT_STRETCH_BLEND |
+					    VERT_STRETCH_ENABLE);
+
+		regs->fp_vert_stretch &= ~VERT_AUTO_RATIO_EN;
+	}
+}
 
 static void radeon_load_video_mode (struct radeonfb_info *rinfo,
                                     struct fb_var_screeninfo *mode)
 {
 	struct radeon_regs newmode;
 	int hTotal, vTotal, hSyncStart, hSyncEnd,
-	    hSyncPol, vSyncStart, vSyncEnd, vSyncPol, cSync;
+	    vSyncStart, vSyncEnd;
 	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};
 	u8 hsync_fudge_fp[] = {2, 2, 0, 0, 5, 5};
-	u32 dotClock = 1000000000 / mode->pixclock,
-	    sync, h_sync_pol, v_sync_pol;
-	int freq = dotClock / 10;  /* x 100 */
-        int xclk_freq, vclk_freq, xclk_per_trans, xclk_per_trans_precise;
-        int useable_precision, roff, ron;
-        int min_bits, format = 0;
+	u32 h_sync_pol, v_sync_pol;
+        int format = 0;
 	int hsync_start, hsync_fudge, bytpp, hsync_wid, vsync_wid;
 	int primary_mon = PRIMARY_MONITOR(rinfo);
 	int depth = var_to_depth(mode);
 
+	bytpp = mode->bits_per_pixel >> 3;
 	rinfo->xres = mode->xres;
 	rinfo->yres = mode->yres;
+	rinfo->pitch = mode->xres_virtual * bytpp;
+	rinfo->ppixclock = rinfo->pixclock;
 	rinfo->pixclock = mode->pixclock;
 
-	hSyncStart = mode->xres + mode->right_margin;
-	hSyncEnd = hSyncStart + mode->hsync_len;
-	hTotal = hSyncEnd + mode->left_margin;
-
-	vSyncStart = mode->yres + mode->lower_margin;
-	vSyncEnd = vSyncStart + mode->vsync_len;
-	vTotal = vSyncEnd + mode->upper_margin;
+	format = radeon_get_dstbpp(depth);
+
+	newmode.crtc_gen_cntl = CRTC_EXT_DISP_EN | CRTC_EN |
+				(format << 8);
 
 	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
-		if (rinfo->panel_xres < mode->xres)
-			rinfo->xres = mode->xres = rinfo->panel_xres;
-		if (rinfo->panel_yres < mode->yres)
-			rinfo->yres = mode->yres = rinfo->panel_yres;
 
 		hTotal = mode->xres + rinfo->hblank;
 		hSyncStart = mode->xres + rinfo->hOver_plus;
@@ -2398,15 +2633,34 @@
 		vTotal = mode->yres + rinfo->vblank;
 		vSyncStart = mode->yres + rinfo->vOver_plus;
 		vSyncEnd = vSyncStart + rinfo->vSync_width;
+
+		hsync_fudge = hsync_fudge_fp[format - 1];
+
+		newmode.crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN;
+		newmode.crtc_gen_cntl &= ~(CRTC_DBL_SCAN_EN |
+					   CRTC_INTERLACE_EN);
+
+	} else {
+
+		hSyncStart = mode->xres + mode->right_margin;
+		hSyncEnd = hSyncStart + mode->hsync_len;
+		hTotal = hSyncEnd + mode->left_margin;
+
+		vSyncStart = mode->yres + mode->lower_margin;
+		vSyncEnd = vSyncStart + mode->vsync_len;
+		vTotal = vSyncEnd + mode->upper_margin;
+
+		hsync_fudge = hsync_adj_tab[format - 1];
+
+		newmode.crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN |
+					CRTC_CRT_ON;
 	}
 
-	sync = mode->sync;
-	h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
-	v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
+	hsync_start = hSyncStart - 8 + hsync_fudge;
 
-	RTRACE("hStart = %d, hEnd = %d, hTotal = %d\n",
+	RTRACE("hStart = %d, hEnd = %d, hTotal = %d",
 		hSyncStart, hSyncEnd, hTotal);
-	RTRACE("vStart = %d, vEnd = %d, vTotal = %d\n",
+	RTRACE("vStart = %d, vEnd = %d, vTotal = %d",
 		vSyncStart, vSyncEnd, vTotal);
 
 	hsync_wid = (hSyncEnd - hSyncStart) / 8;
@@ -2421,32 +2675,10 @@
 	else if (vsync_wid > 0x1f)	/* max */
 		vsync_wid = 0x1f;
 
-	hSyncPol = mode->sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
-	vSyncPol = mode->sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
+	h_sync_pol = mode->sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
+	v_sync_pol = mode->sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
 
-	cSync = mode->sync & FB_SYNC_COMP_HIGH_ACT ? (1 << 4) : 0;
-
-	format = radeon_get_dstbpp(depth);
-	bytpp = mode->bits_per_pixel >> 3;
-
-	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD))
-		hsync_fudge = hsync_fudge_fp[format-1];
-	else
-		hsync_fudge = hsync_adj_tab[format-1];
-
-	hsync_start = hSyncStart - 8 + hsync_fudge;
-
-	newmode.crtc_gen_cntl = CRTC_EXT_DISP_EN | CRTC_EN |
-				(format << 8);
-
-	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
-		newmode.crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN;
-		newmode.crtc_gen_cntl &= ~(CRTC_DBL_SCAN_EN |
-					   CRTC_INTERLACE_EN);
-	} else {
-		newmode.crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN |
-					CRTC_CRT_ON;
-	}
+	/* cSync = mode->sync & FB_SYNC_COMP_HIGH_ACT ? (1 << 4) : 0; */
 
 	newmode.dac_cntl = /* INREG(DAC_CNTL) | */ DAC_MASK_ALL | DAC_VGA_ADR_EN |
 			   DAC_8BIT_EN;
@@ -2463,7 +2695,7 @@
 	newmode.crtc_v_sync_strt_wid = (((vSyncStart - 1) & 0xfff) |
 					 (vsync_wid << 16) | (v_sync_pol  << 23));
 
-	newmode.crtc_pitch = (mode->xres >> 3);
+	newmode.crtc_pitch = mode->xres_virtual >> 3;
 	newmode.crtc_pitch |= (newmode.crtc_pitch << 16);
 
 #if defined(__BIG_ENDIAN)
@@ -2479,12 +2711,9 @@
 	}
 #endif
 
-	rinfo->pitch = ((mode->xres * ((mode->bits_per_pixel + 1) / 8) + 0x3f)
-			& ~(0x3f)) / 64;
-
-	RTRACE("h_total_disp = 0x%x\t   hsync_strt_wid = 0x%x\n",
+	RTRACE("h_total_disp = 0x%x  hsync_strt_wid = 0x%x",
 		newmode.crtc_h_total_disp, newmode.crtc_h_sync_strt_wid);
-	RTRACE("v_total_disp = 0x%x\t   vsync_strt_wid = 0x%x\n",
+	RTRACE("v_total_disp = 0x%x  vsync_strt_wid = 0x%x",
 		newmode.crtc_v_total_disp, newmode.crtc_v_sync_strt_wid);
 
 	newmode.xres = mode->xres;
@@ -2493,115 +2722,17 @@
 	rinfo->bpp = mode->bits_per_pixel;
 	rinfo->depth = depth;
 
+#if 0
 	rinfo->hack_crtc_ext_cntl = newmode.crtc_ext_cntl;
 	rinfo->hack_crtc_v_sync_strt_wid = newmode.crtc_v_sync_strt_wid;
+#endif
 
-	if (freq > rinfo->pll.ppll_max)
-		freq = rinfo->pll.ppll_max;
-	if (freq*12 < rinfo->pll.ppll_min)
-		freq = rinfo->pll.ppll_min / 12;
-
-	{
-		struct {
-			int divider;
-			int bitvalue;
-		} *post_div,
-		  post_divs[] = {
-			{ 1,  0 },
-			{ 2,  1 },
-			{ 4,  2 },
-			{ 8,  3 },
-			{ 3,  4 },
-			{ 16, 5 },
-			{ 6,  6 },
-			{ 12, 7 },
-			{ 0,  0 },
-		};
-
-		for (post_div = &post_divs[0]; post_div->divider; ++post_div) {
-			rinfo->pll_output_freq = post_div->divider * freq;
-			if (rinfo->pll_output_freq >= rinfo->pll.ppll_min  &&
-			    rinfo->pll_output_freq <= rinfo->pll.ppll_max)
-				break;
-		}
-
-		rinfo->post_div = post_div->divider;
-		rinfo->fb_div = round_div(rinfo->pll.ref_div*rinfo->pll_output_freq,
-					  rinfo->pll.ref_clk);
-		newmode.ppll_ref_div = rinfo->pll.ref_div;
-		newmode.ppll_div_3 = rinfo->fb_div | (post_div->bitvalue << 16);
-	}
-
-	RTRACE("post div = 0x%x\n", rinfo->post_div);
-	RTRACE("fb_div = 0x%x\n", rinfo->fb_div);
-	RTRACE("ppll_div_3 = 0x%x\n", newmode.ppll_div_3);
-
-	/* DDA */
-	vclk_freq = round_div(rinfo->pll.ref_clk * rinfo->fb_div,
-			      rinfo->pll.ref_div * rinfo->post_div);
-	xclk_freq = rinfo->pll.xclk;
-
-	xclk_per_trans = round_div(xclk_freq * 128, vclk_freq * mode->bits_per_pixel);
-
-	min_bits = min_bits_req(xclk_per_trans);
-	useable_precision = min_bits + 1;
-
-	xclk_per_trans_precise = round_div((xclk_freq * 128) << (11 - useable_precision),
-					   vclk_freq * mode->bits_per_pixel);
-
-	ron = (4 * rinfo->ram.mb + 3 * _max(rinfo->ram.trcd - 2, 0) +
-	       2 * rinfo->ram.trp + rinfo->ram.twr + rinfo->ram.cl + rinfo->ram.tr2w +
-	       xclk_per_trans) << (11 - useable_precision);
-	roff = xclk_per_trans_precise * (32 - 4);
-
-	RTRACE("ron = %d, roff = %d\n", ron, roff);
-	RTRACE("vclk_freq = %d, per = %d\n", vclk_freq, xclk_per_trans_precise);
-
-	if ((ron + rinfo->ram.rloop) >= roff) {
-		printk("radeonfb: error ron out of range\n");
-		return;
-	}
-
-	newmode.dda_config = (xclk_per_trans_precise |
-			      (useable_precision << 16) |
-			      (rinfo->ram.rloop << 20));
-	newmode.dda_on_off = (ron << 16) | roff;
+	calc_pll_regs(rinfo, &newmode,  rinfo->pixclock);
+	calc_dda_regs(rinfo, &newmode);
 
 	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
-		unsigned int hRatio, vRatio;
-
-		if (mode->xres > rinfo->panel_xres)
-			mode->xres = rinfo->panel_xres;
-		if (mode->yres > rinfo->panel_yres)
-			mode->yres = rinfo->panel_yres;
-
-		newmode.fp_horz_stretch = (((rinfo->panel_xres / 8) - 1)
-					   << HORZ_PANEL_SHIFT);
-		newmode.fp_vert_stretch = ((rinfo->panel_yres - 1)
-					   << VERT_PANEL_SHIFT);
 
-		if (mode->xres != rinfo->panel_xres) {
-			hRatio = round_div(mode->xres * HORZ_STRETCH_RATIO_MAX,
-					   rinfo->panel_xres);
-			newmode.fp_horz_stretch = (((((unsigned long)hRatio) & HORZ_STRETCH_RATIO_MASK)) |
-						   (newmode.fp_horz_stretch &
-						    (HORZ_PANEL_SIZE | HORZ_FP_LOOP_STRETCH |
-						     HORZ_AUTO_RATIO_INC)));
-			newmode.fp_horz_stretch |= (HORZ_STRETCH_BLEND |
-						    HORZ_STRETCH_ENABLE);
-		}
-		newmode.fp_horz_stretch &= ~HORZ_AUTO_RATIO;
-
-		if (mode->yres != rinfo->panel_yres) {
-				vRatio = round_div(mode->yres * VERT_STRETCH_RATIO_MAX,
-						   rinfo->panel_yres);
-				newmode.fp_vert_stretch = (((((unsigned long)vRatio) & VERT_STRETCH_RATIO_MASK)) |
-							   (newmode.fp_vert_stretch &
-							   (VERT_PANEL_SIZE | VERT_STRETCH_RESERVED)));
-				newmode.fp_vert_stretch |= (VERT_STRETCH_BLEND |
-							    VERT_STRETCH_ENABLE);
-		}
-		newmode.fp_vert_stretch &= ~VERT_AUTO_RATIO_EN;
+		calc_stretch_regs(rinfo, &newmode);
 
 		newmode.fp_gen_cntl = (rinfo->init_state.fp_gen_cntl & (u32)
 				       ~(FP_SEL_CRTC2 |
@@ -2622,14 +2753,21 @@
 		newmode.tmds_transmitter_cntl = rinfo->init_state.tmds_transmitter_cntl;
 
 		if (primary_mon == MT_LCD) {
+
 			newmode.lvds_gen_cntl |= (LVDS_ON | LVDS_BLON);
 			newmode.fp_gen_cntl &= ~(FP_FPON | FP_TMDS_EN);
+
 		} else {
-			/* DFP */
+
 			newmode.fp_gen_cntl |= (FP_FPON | FP_TMDS_EN);
+			newmode.crtc_ext_cntl &= ~CRTC_CRT_ON;
+
+			/* XXX one user's DFP won't work with this line in, and *
+			 * I notice XFree doesn't touch this register ...  :pdh */
+#if 0
 			newmode.tmds_transmitter_cntl = (TMDS_RAN_PAT_RST |
 							 ICHCSEL) & ~(TMDS_PLLRST);
-			newmode.crtc_ext_cntl &= ~CRTC_CRT_ON;
+#endif
 		}
 
 		newmode.fp_crtc_h_total_disp = newmode.crtc_h_total_disp;
@@ -2657,15 +2795,13 @@
 	int primary_mon = PRIMARY_MONITOR(rinfo);
 
 	/* blank screen */
-	OUTREGP(CRTC_EXT_CNTL, CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS | CRTC_HSYNC_DIS,
-		~(CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS | CRTC_HSYNC_DIS));
+	OUTREGP(CRTC_EXT_CNTL, mode->crtc_ext_cntl,
+		~(CRTC_HSYNC_DIS | CRTC_VSYNC_DIS | CRTC_DISPLAY_DIS));
 
 	for (i=0; i<9; i++)
 		OUTREG(common_regs[i].reg, common_regs[i].val);
 
 	OUTREG(CRTC_GEN_CNTL, mode->crtc_gen_cntl);
-	OUTREGP(CRTC_EXT_CNTL, mode->crtc_ext_cntl,
-		CRTC_HSYNC_DIS | CRTC_VSYNC_DIS | CRTC_DISPLAY_DIS);
 	OUTREGP(DAC_CNTL, mode->dac_cntl, DAC_RANGE_CNTL | DAC_BLANKING);
 	OUTREG(CRTC_H_TOTAL_DISP, mode->crtc_h_total_disp);
 	OUTREG(CRTC_H_SYNC_STRT_WID, mode->crtc_h_sync_strt_wid);
@@ -2679,34 +2815,8 @@
 	OUTREG(SURFACE_CNTL, mode->surface_cntl);
 #endif
 
-	while ((INREG(CLOCK_CNTL_INDEX) & PPLL_DIV_SEL_MASK) !=
-	       PPLL_DIV_SEL_MASK) {
-		OUTREGP(CLOCK_CNTL_INDEX, PPLL_DIV_SEL_MASK, 0xffff);
-	}
-
-	OUTPLLP(PPLL_CNTL, PPLL_RESET, 0xffff);
-
-	while ((INPLL(PPLL_REF_DIV) & PPLL_REF_DIV_MASK) !=
-	       (mode->ppll_ref_div & PPLL_REF_DIV_MASK)) {
-		OUTPLLP(PPLL_REF_DIV, mode->ppll_ref_div, ~PPLL_REF_DIV_MASK);
-	}
-
-	while ((INPLL(PPLL_DIV_3) & PPLL_FB3_DIV_MASK) !=
-	       (mode->ppll_div_3 & PPLL_FB3_DIV_MASK)) {
-		OUTPLLP(PPLL_DIV_3, mode->ppll_div_3, ~PPLL_FB3_DIV_MASK);
-	}
-
-	while ((INPLL(PPLL_DIV_3) & PPLL_POST3_DIV_MASK) !=
-	       (mode->ppll_div_3 & PPLL_POST3_DIV_MASK)) {
-		OUTPLLP(PPLL_DIV_3, mode->ppll_div_3, ~PPLL_POST3_DIV_MASK);
-	}
-
-	OUTPLL(HTOTAL_CNTL, 0);
-
-	OUTPLLP(PPLL_CNTL, 0, ~PPLL_RESET);
-
-	OUTREG(DDA_CONFIG, mode->dda_config);
-	OUTREG(DDA_ON_OFF, mode->dda_on_off);
+	set_pll_regs(rinfo, mode);
+	set_dda_regs(rinfo, mode);
 
 	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
 		OUTREG(FP_CRTC_H_TOTAL_DISP, mode->fp_crtc_h_total_disp);
@@ -2743,7 +2853,7 @@
 	}
 
 	/* unblank screen */
-	OUTREG8(CRTC_EXT_CNTL + 1, 0);
+	OUTREG(CRTC_EXT_CNTL, mode->crtc_ext_cntl);
 
 	return;
 }
@@ -2957,7 +3067,7 @@
 			       int dsty, int dstx, int height, int width)
 {
 	struct radeonfb_info *rinfo = (struct radeonfb_info *)(p->fb_info);
-	u32 dp_cntl = DST_LAST_PEL;
+	u32 dp_cntl;
 
 	srcx *= fontwidth(p);
 	srcy *= fontheight(p);
@@ -2966,6 +3076,8 @@
 	width *= fontwidth(p);
 	height *= fontheight(p);
 
+	dp_cntl = 0;
+
 	if (srcy < dsty) {
 		srcy += height - 1;
 		dsty += height - 1;
@@ -2989,25 +3101,14 @@
 	OUTREG(SRC_Y_X, (srcy << 16) | srcx);
 	OUTREG(DST_Y_X, (dsty << 16) | dstx);
 	OUTREG(DST_HEIGHT_WIDTH, (height << 16) | width);
+	
+	radeon_engine_idle();
 }
 
 
 
-static void fbcon_radeon_clear(struct vc_data *conp, struct display *p,
-			       int srcy, int srcx, int height, int width)
+static void fbcon_radeon_clear(struct radeonfb_info *rinfo, int srcy, int srcx, int height, int width, u32 clr)
 {
-	struct radeonfb_info *rinfo = (struct radeonfb_info *)(p->fb_info);
-	u32 clr;
-
-	clr = attr_bgcol_ec(p, conp);
-	clr |= (clr << 8);
-	clr |= (clr << 16);
-
-	srcx *= fontwidth(p);
-	srcy *= fontheight(p);
-	width *= fontwidth(p);
-	height *= fontheight(p);
-
 	radeon_fifo_wait(6);
 	OUTREG(DP_GUI_MASTER_CNTL, (rinfo->dp_gui_master_cntl |
 				    GMC_BRUSH_SOLID_COLOR |
@@ -3018,15 +3119,27 @@
 	OUTREG(DP_CNTL, (DST_X_LEFT_TO_RIGHT | DST_Y_TOP_TO_BOTTOM));
 	OUTREG(DST_Y_X, (srcy << 16) | srcx);
 	OUTREG(DST_WIDTH_HEIGHT, (width << 16) | height);
+
+	radeon_engine_idle();
 }
 
+#ifdef FBCON_HAS_CFB8
+static void fbcon_radeon8_clear(struct vc_data *conp, struct display *p,
+		int srcy, int srcx, int height, int width)
+{
+	u32 clr;
 
+	clr = attr_bgcol_ec(p, conp);
+	clr |= clr << 8;
+
+	fbcon_radeon_clear((struct radeonfb_info *) p->fb_info, srcy * fontheight(p), srcx * fontwidth(p),
+			height * fontheight(p), width * fontwidth(p), clr | (clr << 16));
+}
 
-#ifdef FBCON_HAS_CFB8
 static struct display_switch fbcon_radeon8 = {
 	setup:			fbcon_cfb8_setup,
 	bmove:			fbcon_radeon_bmove,
-	clear:			fbcon_radeon_clear,
+	clear:			fbcon_radeon8_clear,
 	putc:			fbcon_cfb8_putc,
 	putcs:			fbcon_cfb8_putcs,
 	revc:			fbcon_cfb8_revc,
@@ -3034,3 +3147,156 @@
 	fontwidthmask:		FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
+
+#ifdef FBCON_HAS_CFB16
+static void fbcon_radeon16_clear(struct vc_data *conp, struct display *p,
+		int srcy, int srcx, int height, int width)
+{
+	u32 clr;
+
+	clr = ((u16 *) p->dispsw_data)[attr_bgcol_ec(p, conp)];
+
+	fbcon_radeon_clear((struct radeonfb_info *) p->fb_info, srcy * fontheight(p), srcx * fontwidth(p),
+			height * fontheight(p), width * fontwidth(p), clr | (clr << 16));
+}
+
+void fbcon_radeon16_revc(struct display *p, int xx, int yy)
+{
+	u8 *dest;
+	u32 xor;
+	int bytes = p->next_line, rows;
+
+	xor = (p->var.green.length == 5 ? 0x3def3def : 0x79ef79ef);
+
+	dest = p->screen_base + yy * fontheight(p) * bytes + xx * fontwidth(p)*2;
+	for (rows = fontheight(p); rows--; dest += bytes) {
+		switch (fontwidth(p)) {
+		case 16:
+			fb_writel(fb_readl(dest+24) ^ xor, dest+24);
+			fb_writel(fb_readl(dest+28) ^ xor, dest+28);
+			/* FALL THROUGH */
+		case 12:
+			fb_writel(fb_readl(dest+16) ^ xor, dest+16);
+			fb_writel(fb_readl(dest+20) ^ xor, dest+20);
+			/* FALL THROUGH */
+		case 8:
+			fb_writel(fb_readl(dest+8) ^ xor, dest+8);
+			fb_writel(fb_readl(dest+12) ^ xor, dest+12);
+			/* FALL THROUGH */
+		case 4:
+			fb_writel(fb_readl(dest+0) ^ xor, dest+0);
+			fb_writel(fb_readl(dest+4) ^ xor, dest+4);
+		}
+	}
+}
+
+static struct display_switch fbcon_radeon16_noaccel = {
+	setup:			fbcon_cfb16_setup,
+	bmove:			fbcon_cfb16_bmove,
+	clear:			fbcon_cfb16_clear,
+	putc:			fbcon_cfb16_putc,
+	putcs:			fbcon_cfb16_putcs,
+	revc:			fbcon_radeon16_revc,
+	clear_margins:		fbcon_cfb16_clear_margins,
+	fontwidthmask:		FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+};
+
+static struct display_switch fbcon_radeon16 = {
+	setup:			fbcon_cfb16_setup,
+	bmove:			fbcon_radeon_bmove,
+	clear:			fbcon_radeon16_clear,
+	putc:			fbcon_cfb16_putc,
+	putcs:			fbcon_cfb16_putcs,
+	revc:			fbcon_radeon16_revc,
+	clear_margins:		fbcon_cfb16_clear_margins,
+	fontwidthmask:		FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+};
+#endif
+
+#ifdef FBCON_HAS_CFB32
+static void fbcon_radeon32_clear(struct vc_data *conp, struct display *p,
+		int srcy, int srcx, int height, int width)
+{
+	fbcon_radeon_clear((struct radeonfb_info *) p->fb_info, srcy * fontheight(p), srcx * fontwidth(p),
+			height * fontheight(p), width * fontwidth(p), ((u32 *) p->dispsw_data)[attr_bgcol_ec(p, conp)]);
+}
+
+void fbcon_radeon32_revc(struct display *p, int xx, int yy)
+{
+	u8 *dest;
+	int bytes = p->next_line, rows;
+
+	dest = p->screen_base + yy * fontheight(p) * bytes + xx * fontwidth(p) * 4;
+	for (rows = fontheight(p); rows--; dest += bytes) {
+		switch (fontwidth(p)) {
+		case 16:
+			fb_writel(fb_readl(dest+(4*12)) ^ 0x000f0f0f, dest+(4*12));
+			fb_writel(fb_readl(dest+(4*13)) ^ 0x000f0f0f, dest+(4*13));
+			fb_writel(fb_readl(dest+(4*14)) ^ 0x000f0f0f, dest+(4*14));
+			fb_writel(fb_readl(dest+(4*15)) ^ 0x000f0f0f, dest+(4*15));
+			/* FALL THROUGH */
+		case 12:
+			fb_writel(fb_readl(dest+(4*8)) ^ 0x000f0f0f, dest+(4*8));
+			fb_writel(fb_readl(dest+(4*9)) ^ 0x000f0f0f, dest+(4*9));
+			fb_writel(fb_readl(dest+(4*10)) ^ 0x000f0f0f, dest+(4*10));
+			fb_writel(fb_readl(dest+(4*11)) ^ 0x000f0f0f, dest+(4*11));
+			/* FALL THROUGH */
+		case 8:
+			fb_writel(fb_readl(dest+(4*4)) ^ 0x000f0f0f, dest+(4*4));
+			fb_writel(fb_readl(dest+(4*5)) ^ 0x000f0f0f, dest+(4*5));
+			fb_writel(fb_readl(dest+(4*6)) ^ 0x000f0f0f, dest+(4*6));
+			fb_writel(fb_readl(dest+(4*7)) ^ 0x000f0f0f, dest+(4*7));
+			/* FALL THROUGH */
+		case 4:
+			fb_writel(fb_readl(dest+(4*0)) ^ 0x000f0f0f, dest+(4*0));
+			fb_writel(fb_readl(dest+(4*1)) ^ 0x000f0f0f, dest+(4*1));
+			fb_writel(fb_readl(dest+(4*2)) ^ 0x000f0f0f, dest+(4*2));
+			fb_writel(fb_readl(dest+(4*3)) ^ 0x000f0f0f, dest+(4*3));
+		 	/* FALL THROUGH */
+		}
+	}
+}
+
+static struct display_switch fbcon_radeon32_noaccel = {
+	setup:			fbcon_cfb32_setup,
+	bmove:			fbcon_cfb32_bmove,
+	clear:			fbcon_cfb32_clear,
+	putc:			fbcon_cfb32_putc,
+	putcs:			fbcon_cfb32_putcs,
+	revc:			fbcon_radeon32_revc,
+	clear_margins:		fbcon_cfb32_clear_margins,
+	fontwidthmask:		FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+};
+
+static struct display_switch fbcon_radeon32 = {
+	setup:			fbcon_cfb32_setup,
+	bmove:			fbcon_radeon_bmove,
+	clear:			fbcon_radeon32_clear,
+	putc:			fbcon_cfb32_putc,
+	putcs:			fbcon_cfb32_putcs,
+	revc:			fbcon_radeon32_revc,
+	clear_margins:		fbcon_cfb32_clear_margins,
+	fontwidthmask:		FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+};
+#endif
+
+MODULE_AUTHOR("Ani Joshi");
+MODULE_DESCRIPTION("framebuffer driver for ATI Radeon chipset");
+MODULE_LICENSE("GPL");
+MODULE_PARM(font, "s");
+MODULE_PARM_DESC(font, "Selects display font");
+MODULE_PARM(noaccel, "i");
+MODULE_PARM_DESC(noaccel, "Disables use of accelerator engine");
+MODULE_PARM(nofastsw, "i");
+MODULE_PARM_DESC(nofastsw, "Always reset PLL on mode change");
+MODULE_PARM(fb16fix, "i");
+MODULE_PARM_DESC(fb16fix, "Fix 16bpp palette for fbtv and others");
+MODULE_PARM(nostretch, "i");
+MODULE_PARM_DESC(nostretch, "Disable stretching of modes to panel size");
+MODULE_PARM(nomtrr, "i");
+MODULE_PARM_DESC(nomtrr, "Disable use of MTRR");
+MODULE_PARM(panel_yres, "i");
+MODULE_PARM_DESC(panel_yres, "Specifies panel Y resolution");
+MODULE_PARM(dfp, "i");
+MODULE_PARM_DESC(dfp, "Force selection of DFP");
+
diff -ur linux-2.4.19-pre2/include/linux/fb.h linux.pdh/include/linux/fb.h
--- linux-2.4.19-pre2/include/linux/fb.h	Sat Apr  6 16:34:40 2002
+++ linux.pdh/include/linux/fb.h	Sun Apr 14 16:10:30 2002
@@ -94,6 +94,7 @@
 #define FB_ACCEL_IGS_CYBER5000	35	/* CyberPro 5000		*/
 #define FB_ACCEL_SIS_GLAMOUR    36	/* SiS 300/630/540              */
 #define FB_ACCEL_3DLABS_PERMEDIA3 37	/* 3Dlabs Permedia 3		*/
+#define FB_ACCEL_ATI_RADEON	38	/* ATI Radeon			*/
 
 struct fb_fix_screeninfo {
 	char id[16];			/* identification string eg "TT Builtin" */
