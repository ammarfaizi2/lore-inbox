Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSDJANN>; Tue, 9 Apr 2002 20:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312256AbSDJANM>; Tue, 9 Apr 2002 20:13:12 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.93]:24850 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id <S312254AbSDJANF>; Tue, 9 Apr 2002 20:13:05 -0400
Date: Wed, 10 Apr 2002 01:12:49 +0100
To: linux-kernel@vger.kernel.org
Cc: phorton@bitbox.co.uk, benh@kernel.crashing.org, ajoshi@unixbox.com
Subject: [PATCH] Radeon frame buffer driver
Message-ID: <20020410001249.GA2010@berserk.demon.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org, phorton@bitbox.co.uk,
	benh@kernel.crashing.org, ajoshi@unixbox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@berserk.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another installment of the Radeon frame buffer driver patch (still
against 2.4.19-pre2).

* All colour modes > 8bpp are now DIRECTCOLOR (Geert inspired).

* Driver now uses 'ypan' to speed up scrolling even further.

* Fix CRTC pitch to match accelerator pitch (800x600x256 works again).

Driver seems okay now, plays nicely with X etc. etc. Please test if you
can

P.


diff -ur linux-2.4.19-pre2/drivers/video/radeon.h linux.pdh/drivers/video/radeon.h
--- linux-2.4.19-pre2/drivers/video/radeon.h	Sat Apr  6 16:34:27 2002
+++ linux.pdh/drivers/video/radeon.h	Tue Apr  9 06:40:43 2002
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
+++ linux.pdh/drivers/video/radeonfb.c	Wed Apr 10 00:07:53 2002
@@ -22,6 +22,13 @@
  *
  *	Special thanks to ATI DevRel team for their hardware donations.
  *
+ * 	2002-04-02	Added MTRR support. Fixed 8bpp acceleration. Added
+ * 			acceleration for 16/32bpp. Applied fix from XFree86
+ * 			for hard crash on accelerator reset. Fixed up the
+ * 			colour stuff. Peter Horton <pdh@colonel-panic.org>
+ * 	2002-04-10	Make ypan work. More colour fixes, all modes >8bpp
+ * 			now DIRECTCOLOR. Match up CRTC and accelerator
+ * 			pitch.
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
+#define _RTRACE(f,a...)		do{printk("radeonfb: " f "\n", ##a);}while(0)
 
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
@@ -299,17 +313,16 @@
 
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
@@ -474,17 +487,15 @@
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
 
@@ -498,6 +509,9 @@
 			   FORCEON_YCLKB |
 			   FORCEON_MC |
 			   FORCEON_AIC));
+
+	host_path_cntl = INREG(HOST_PATH_CNTL);
+
 	rbbm_soft_reset = INREG(RBBM_SOFT_RESET);
 
 	OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset |
@@ -507,8 +521,7 @@
 				SOFT_RESET_RE |
 				SOFT_RESET_PP |
 				SOFT_RESET_E2 |
-				SOFT_RESET_RB |
-				SOFT_RESET_HDP);
+				SOFT_RESET_RB);
 	INREG(RBBM_SOFT_RESET);
 	OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset & (u32)
 				~(SOFT_RESET_CP |
@@ -517,13 +530,16 @@
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
@@ -531,6 +547,7 @@
 #define radeon_engine_reset()		_radeon_engine_reset(rinfo)
 
 
+#if 0
 static __inline__ u8 radeon_get_post_div_bitval(int post_div)
 {
         switch (post_div) {
@@ -552,6 +569,7 @@
                         return 0x02;
         }
 }
+#endif
 
 
 
@@ -594,7 +612,9 @@
         
 static char fontname[40] __initdata;
 static char *mode_option __initdata;
-static char noaccel __initdata = 0;
+static char noaccel /*__initdata*/ = 0;
+static char fb16fix = 0;
+static char nomtrr __initdata = 0;
 static int panel_yres __initdata = 0;
 static char force_dfp __initdata = 0;
 static struct radeonfb_info *board_list = NULL;
@@ -602,6 +622,12 @@
 #ifdef FBCON_HAS_CFB8
 static struct display_switch fbcon_radeon8;
 #endif
+#ifdef FBCON_HAS_CFB16
+static struct display_switch fbcon_radeon16;
+#endif
+#ifdef FBCON_HAS_CFB32
+static struct display_switch fbcon_radeon32;
+#endif
 
 
 /*
@@ -731,6 +757,10 @@
 			force_dfp = 1;
 		} else if (!strncmp(this_opt, "panel_yres:", 11)) {
 			panel_yres = simple_strtoul((this_opt+11), NULL, 0);
+		} else if (!strncmp(this_opt, "nomtrr", 6)) {
+			nomtrr = 1;
+		} else if (!strncmp(this_opt, "fb16fix", 7)) {
+			fb16fix = 1;
                 } else
 			mode_option = this_opt;
         }
@@ -755,7 +785,7 @@
 	u32 tmp;
 	int i, j;
 
-	RTRACE("radeonfb_pci_register BEGIN\n");
+	RTRACE("radeonfb_pci_register BEGIN");
 
 	rinfo = kmalloc (sizeof (struct radeonfb_info), GFP_KERNEL);
 	if (!rinfo) {
@@ -915,7 +945,7 @@
 	rinfo->bios_seg = radeon_find_rom(rinfo);
 	radeon_get_pllinfo(rinfo, rinfo->bios_seg);
 
-	RTRACE("radeonfb: probed %s %dk videoram\n", (rinfo->ram_type), (rinfo->video_ram/1024));
+	RTRACE("probed %s %dk videoram", (rinfo->ram_type), (rinfo->video_ram/1024));
 
 #if !defined(__powerpc__)
 	radeon_get_moninfo(rinfo);
@@ -960,9 +990,6 @@
 		return -ENODEV;
 	}
 
-	/* XXX turn off accel for now, blts aren't working right */
-	noaccel = 1;
-
 	/* currcon not yet configured, will be set by first switch */
 	rinfo->currcon = -1;
 
@@ -998,6 +1025,12 @@
 		return -ENODEV;
 	}
 
+#ifdef CONFIG_MTRR
+	rinfo->mtrr_hdl = nomtrr ? -1 : mtrr_add(rinfo->fb_base_phys, rinfo->video_ram, MTRR_TYPE_WRCOMB, 1);
+#endif
+
+	/* XXX look at this re pitch :pdh */
+
 	if (!noaccel) {
 		/* initialize the engine */
 		radeon_engine_init (rinfo);
@@ -1029,7 +1062,7 @@
 			GET_MON_NAME(rinfo->crtDisp_type));
 	}
 
-	RTRACE("radeonfb_pci_register END\n");
+	RTRACE("radeonfb_pci_register END");
 
 	return 0;
 }
@@ -1046,6 +1079,11 @@
 	/* restore original state */
         radeon_write_mode (rinfo, &rinfo->init_state);
  
+#ifdef CONFIG_MTRR
+	if(rinfo->mtrr_hdl >= 0)
+		mtrr_del(rinfo->mtrr_hdl, 0, 0);
+#endif
+
         unregister_framebuffer ((struct fb_info *) rinfo);
                 
         iounmap ((void*)rinfo->mmio_base);
@@ -1157,7 +1195,7 @@
         	rinfo->pll.ppll_min = pll.PCLK_min_freq;
         	rinfo->pll.ppll_max = pll.PCLK_max_freq;
 
-		printk("radeonfb: ref_clk=%d, ref_div=%d, xclk=%d from BIOS\n",
+		_RTRACE("ref_clk=%d, ref_div=%d, xclk=%d from BIOS",
 			rinfo->pll.ref_clk, rinfo->pll.ref_div, rinfo->pll.xclk);
 	} else {
 #ifdef CONFIG_ALL_PPC
@@ -1177,7 +1215,7 @@
 			rinfo->pll.ppll_min = 12000;
 			rinfo->pll.ppll_max = 35000;
 
-			printk("radeonfb: ref_clk=%d, ref_div=%d, xclk=%d from OF\n",
+			_RTRACE("ref_clk=%d, ref_div=%d, xclk=%d from OF",
 				rinfo->pll.ref_clk, rinfo->pll.ref_div, rinfo->pll.xclk);
 
 			return;
@@ -1212,7 +1250,7 @@
 				break;
 		}
 
-		printk("radeonfb: ref_clk=%d, ref_div=%d, xclk=%d defaults\n",
+		_RTRACE("ref_clk=%d, ref_div=%d, xclk=%d defaults",
 			rinfo->pll.ref_clk, rinfo->pll.ref_div, rinfo->pll.xclk);
 	}
 }
@@ -1271,7 +1309,7 @@
 {
 #ifdef CONFIG_ALL_PPC
 	if (!radeon_get_EDID_OF(rinfo))
-		RTRACE("radeonfb: could not retrieve EDID from OF\n");
+		RTRACE("radeonfb: could not retrieve EDID from OF");
 #else
 	/* XXX use other methods later */
 #endif
@@ -1503,6 +1541,8 @@
 		rinfo->vSync_width = (unsigned short) ((tmp & FP_V_SYNC_WID_MASK) >>
 					FP_V_SYNC_WID_SHIFT);
 
+		/* XXX some more stuff needs to go here :pdh */
+
 		return 1;
 	}
 
@@ -1540,15 +1580,12 @@
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
@@ -1703,30 +1740,22 @@
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
+                        disp->dispsw = accel ? &fbcon_radeon16 : &fbcon_cfb16;
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
+                        disp->dispsw = accel ? &fbcon_radeon32 : &fbcon_cfb32;
                         disp->dispsw_data = &rinfo->con_cmap.cfb32;
                         disp->visual = FB_VISUAL_DIRECTCOLOR;
                         disp->line_length = disp->var.xres_virtual * 4;
@@ -1736,8 +1765,6 @@
                         printk ("radeonfb: setting fbcon_dummy renderer\n");
                         disp->dispsw = &fbcon_dummy;
         }
-                
-        return;
 }
                         
 
@@ -1759,6 +1786,7 @@
 
 
 
+#if 0
 static int radeonfb_do_maximize(struct radeonfb_info *rinfo,
                                 struct fb_var_screeninfo *var,
                                 struct fb_var_screeninfo *v,
@@ -1819,9 +1847,18 @@
                                 
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
@@ -1844,7 +1881,7 @@
         fix->type_aux = disp->type_aux;
         fix->visual = disp->visual;
 
-        fix->xpanstep = 8;
+        fix->xpanstep = 0;
         fix->ypanstep = 1;
         fix->ywrapstep = 0;
         
@@ -1855,7 +1892,7 @@
 	if (noaccel)
 	        fix->accel = FB_ACCEL_NONE;
 	else
-		fix->accel = 40;	/* XXX */
+		fix->accel = FB_ACCEL_ATI_RADEON;
         
         return 0;
 }
@@ -1880,7 +1917,7 @@
         struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
         struct display *disp;
         struct fb_var_screeninfo v;
-        int nom, den, accel;
+        int accel, bytpp, pitch;
         unsigned chgvar = 0;
 
         disp = (con < 0) ? rinfo->info.disp : &fb_display[con];
@@ -1903,110 +1940,97 @@
         switch (v.bits_per_pixel) {
 		case 0 ... 8:
 			v.bits_per_pixel = 8;
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
-#ifdef FBCON_HAS_CFB8
-                case 8:
-                        nom = den = 1;
-                        disp->line_length = v.xres_virtual;
-                        disp->visual = FB_VISUAL_PSEUDOCOLOR; 
                         v.red.offset = v.green.offset = v.blue.offset = 0;
                         v.red.length = v.green.length = v.blue.length = 8;
                         v.transp.offset = v.transp.length = 0;
-                        break;
-#endif
-                        
-#ifdef FBCON_HAS_CFB16
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
 			break;
-                case 16:
-                        nom = 2;
-                        den = 1;
-                        disp->line_length = v.xres_virtual * 2;
-                        disp->visual = FB_VISUAL_DIRECTCOLOR;
-                        v.red.offset = 11;
+		case 9 ... 16:
+#if FIX_DEPTH_15
+			if(v.bits_per_pixel < 16)
+				v.green.length = 5;
+#endif
+			if(v.green.length != 5 && v.green.length != 6)
+				v.green.length = 5;
+			v.bits_per_pixel = 16;
+                        v.red.offset = v.green.length + 5;
                         v.green.offset = 5;
                         v.blue.offset = 0;
                         v.red.length = 5;
-                        v.green.length = 6;
                         v.blue.length = 5;
                         v.transp.offset = v.transp.length = 0;
-                        break;  
-#endif
-                        
-#ifdef FBCON_HAS_CFB24
-                case 24:
-                        nom = 4;
-                        den = 1;
-                        disp->line_length = v.xres_virtual * 3;
-                        disp->visual = FB_VISUAL_DIRECTCOLOR;
+			break;
+		case 17 ... 32:
+			v.bits_per_pixel = 32;
                         v.red.offset = 16;
                         v.green.offset = 8;
                         v.blue.offset = 0;
                         v.red.length = v.blue.length = v.green.length = 8;
+                        /* v.transp.offset = 24; v.transp.length = 8; */
                         v.transp.offset = v.transp.length = 0;
-                        break;
-#endif
-#ifdef FBCON_HAS_CFB32
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
-#endif
-                default:
-                        printk ("radeonfb: mode %dx%dx%d rejected, color depth invalid\n",
-                                var->xres, var->yres, var->bits_per_pixel);
-                        return -EINVAL;
-        }
+			break;
+		default:
+			return -EINVAL;
+	}
+
+        v.red.msb_right = v.green.msb_right = v.blue.msb_right = v.transp.msb_right = 0;
+
+	bytpp = v.bits_per_pixel >> 3;
+
+	if(v.xres > v.xres_virtual)
+		v.xres_virtual = v.xres;
+	if(v.yres > v.yres_virtual)
+		v.yres_virtual = v.yres;
+
+	/* XXX this is probably wrong for 24bpp, if we ever get it working :pdh */
+
+	pitch = (v.xres_virtual * bytpp + 63) & ~63;
+
+	if(pitch >= 8192)
+		return -EINVAL;
+
+	v.xres_virtual = pitch / bytpp;
 
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
+
+#if 0
         if (radeonfb_do_maximize(rinfo, var, &v, nom, den) < 0)
                 return -EINVAL;  
+#endif
                 
+	if(v.xoffset)
+		return -EINVAL;
+
         if (v.xoffset < 0)
                 v.xoffset = 0;
         if (v.yoffset < 0)
                 v.yoffset = 0;
          
         if (v.xoffset > v.xres_virtual - v.xres)
-                v.xoffset = v.xres_virtual - v.xres - 1;
+		return -EINVAL;
                         
         if (v.yoffset > v.yres_virtual - v.yres)
-                v.yoffset = v.yres_virtual - v.yres - 1;
-         
-        v.red.msb_right = v.green.msb_right = v.blue.msb_right =
-                          v.transp.offset = v.transp.length =
-                          v.transp.msb_right = 0;
+		return -EINVAL;
                         
+	/* XXX this shouldn't be here :pdh */
+
+	disp->visual = (v.bits_per_pixel == 8 ? FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR);
+	disp->line_length = v.xres_virtual * bytpp;
+	disp->ypanstep = 1;
+	disp->ywrapstep = 0;
+	disp->var.yres_virtual = v.yres_virtual;
+
+
         switch (v.activate & FB_ACTIVATE_MASK) {
                 case FB_ACTIVATE_TEST:
                         return 0;
@@ -2018,15 +2042,13 @@
         }
         
         memcpy (&disp->var, &v, sizeof (v));
-        
+
         if (chgvar) {     
-                radeon_set_dispsw(rinfo, disp);
 
-                if (noaccel)
-                        disp->scrollmode = SCROLL_YREDRAW;
-                else
-                        disp->scrollmode = 0;
-                
+		disp->scrollmode = accel ? 0 : SCROLL_YREDRAW;
+
+		radeon_set_dispsw(rinfo, disp);
+
                 if (info && info->changevar)
                         info->changevar(con);
         }
@@ -2035,6 +2057,9 @@
                 
         do_install_cmap(con, info);
   
+	if(accel)
+		radeon_engine_init(rinfo);
+
         return 0;
 }
 
@@ -2093,6 +2118,8 @@
                                  struct fb_info *info)
 {
         struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
+
+#if 0
         u32 offset, xoffset, yoffset;
                 
         xoffset = (var->xoffset + 7) & ~7;
@@ -2105,7 +2132,18 @@
         offset = ((yoffset * var->xres + xoffset) * var->bits_per_pixel) >> 6;
          
         OUTREG(CRTC_OFFSET, offset);
+#endif
+
+	/* XXX no X pan for the moment :pdh */
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
 
@@ -2144,12 +2182,14 @@
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
@@ -2214,18 +2254,7 @@
 
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
+	return var->bits_per_pixel == 8 ? 256 : 16;
 }
 
 
@@ -2239,10 +2268,9 @@
 	if (regno > 255)
 		return 1;
      
- 	*red = (rinfo->palette[regno].red<<8) | rinfo->palette[regno].red; 
-    	*green = (rinfo->palette[regno].green<<8) | rinfo->palette[regno].green;
-    	*blue = (rinfo->palette[regno].blue<<8) | rinfo->palette[regno].blue;
-    	*transp = 0;
+ 	*red	= (unsigned) rinfo->palette[regno].red << 8;
+    	*green	= (unsigned) rinfo->palette[regno].green << 8;
+    	*blue	= (unsigned) rinfo->palette[regno].blue << 8;
 
 	return 0;
 }                            
@@ -2250,79 +2278,95 @@
 
 
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
+	rinfo->palette[regno].red	= red;
+	rinfo->palette[regno].green	= green;
+	rinfo->palette[regno].blue	= blue;
+
+	/* ugly hack so that the software cursor works */
+
+	if(regno == 0) {
+		switch(rinfo->depth) {
+
+			case 16:
+				radeon_setcolreg(63, ~0, ~0, ~0, 0, info);
+				/* */
 
-        /* default */
-        pindex = regno;
-        
-	if (rinfo->bpp == 16) {
-		pindex = regno * 8;
+			case 15:
+				radeon_setcolreg(31, ~0, ~0, ~0, 0, info);
+				break;
 
-		if (rinfo->depth == 16 && regno > 63)
-			return 1;
-		if (rinfo->depth == 15 && regno > 31)
-			return 1;
+			case 32:
+				radeon_setcolreg(255, ~0, ~0, ~0, 0, info);
+				break;
+		}
+	}
 
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
+	switch(rinfo->depth) {
+
+		case 15:
+			if(regno > 31)
+				return 1;
+			if(regno < 16)
+				rinfo->con_cmap.cfb16[regno] = (regno << 10) | (regno << 5) | regno;
+			regno <<= 3;
+			break;
+
+		case 16:
+
+			if(fb16fix) {
+
+				/* this is just another format of 15 bit mode, the LSB of the   *
+				 * green pixel data is ignored. this is required for "fbtv" and *
+				 * other apps to work correctly at 16bpp, but it means you land *
+				 * up with a sick looking boot logo. the real fix is to run at  *
+				 * 15bpp when you want to use those apps                   :pdh */
+
+				if(regno > 31)
+					return 1;
+				if(regno < 16)
+					rinfo->con_cmap.cfb16[regno] = (regno << 11) | (regno << 6) | regno;
+				regno <<= 3;
+				set_palette_entry(rinfo, regno | 4, red, green, blue);
+
+			} else {
+
+				if(regno > 63)
+					return 1;
+				if(regno < 16)
+					rinfo->con_cmap.cfb16[regno] = (regno << 11) | (regno << 5) | regno;
+				set_palette_entry(rinfo, regno << 2, rinfo->palette[regno >> 1].red,
+					green, rinfo->palette[regno >> 1].blue);
+				if(regno > 31)
+					return 0;
+				regno <<= 1;
+				green = rinfo->palette[regno].green;
+				regno <<= 2;
+			}
+			break;
+
+		case 32:
+			if(regno < 16)
+				rinfo->con_cmap.cfb32[regno] = (regno << 16) | (regno << 8) | regno;
+			break;
 	}
 
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
-#endif
-#ifdef FBCON_HAS_CFB32
-	        	case 32: {
-            			u32 i;    
-   
-  		       		i = (regno << 8) | regno;
-            			rinfo->con_cmap.cfb32[regno] = (i << 16) | i;
-		        	break;
-        		}
-#endif
-		}
-        }
+	set_palette_entry(rinfo, regno, red, green, blue);
+
 	return 0;
 }
 
-
-
 static void radeon_save_state (struct radeonfb_info *rinfo,
                                struct radeon_regs *save)
 {
@@ -2373,8 +2417,10 @@
 	int primary_mon = PRIMARY_MONITOR(rinfo);
 	int depth = var_to_depth(mode);
 
+	bytpp = mode->bits_per_pixel >> 3;
 	rinfo->xres = mode->xres;
 	rinfo->yres = mode->yres;
+	rinfo->pitch = mode->xres_virtual * bytpp;
 	rinfo->pixclock = mode->pixclock;
 
 	hSyncStart = mode->xres + mode->right_margin;
@@ -2404,9 +2450,9 @@
 	h_sync_pol = sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
 	v_sync_pol = sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
 
-	RTRACE("hStart = %d, hEnd = %d, hTotal = %d\n",
+	RTRACE("hStart = %d, hEnd = %d, hTotal = %d",
 		hSyncStart, hSyncEnd, hTotal);
-	RTRACE("vStart = %d, vEnd = %d, vTotal = %d\n",
+	RTRACE("vStart = %d, vEnd = %d, vTotal = %d",
 		vSyncStart, vSyncEnd, vTotal);
 
 	hsync_wid = (hSyncEnd - hSyncStart) / 8;
@@ -2427,7 +2473,6 @@
 	cSync = mode->sync & FB_SYNC_COMP_HIGH_ACT ? (1 << 4) : 0;
 
 	format = radeon_get_dstbpp(depth);
-	bytpp = mode->bits_per_pixel >> 3;
 
 	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD))
 		hsync_fudge = hsync_fudge_fp[format-1];
@@ -2463,7 +2508,7 @@
 	newmode.crtc_v_sync_strt_wid = (((vSyncStart - 1) & 0xfff) |
 					 (vsync_wid << 16) | (v_sync_pol  << 23));
 
-	newmode.crtc_pitch = (mode->xres >> 3);
+	newmode.crtc_pitch = mode->xres_virtual >> 3;
 	newmode.crtc_pitch |= (newmode.crtc_pitch << 16);
 
 #if defined(__BIG_ENDIAN)
@@ -2479,12 +2524,9 @@
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
@@ -2493,8 +2535,10 @@
 	rinfo->bpp = mode->bits_per_pixel;
 	rinfo->depth = depth;
 
+#if 0
 	rinfo->hack_crtc_ext_cntl = newmode.crtc_ext_cntl;
 	rinfo->hack_crtc_v_sync_strt_wid = newmode.crtc_v_sync_strt_wid;
+#endif
 
 	if (freq > rinfo->pll.ppll_max)
 		freq = rinfo->pll.ppll_max;
@@ -2532,9 +2576,9 @@
 		newmode.ppll_div_3 = rinfo->fb_div | (post_div->bitvalue << 16);
 	}
 
-	RTRACE("post div = 0x%x\n", rinfo->post_div);
-	RTRACE("fb_div = 0x%x\n", rinfo->fb_div);
-	RTRACE("ppll_div_3 = 0x%x\n", newmode.ppll_div_3);
+	RTRACE("post div = 0x%x", rinfo->post_div);
+	RTRACE("fb_div = 0x%x", rinfo->fb_div);
+	RTRACE("ppll_div_3 = 0x%x", newmode.ppll_div_3);
 
 	/* DDA */
 	vclk_freq = round_div(rinfo->pll.ref_clk * rinfo->fb_div,
@@ -2554,8 +2598,8 @@
 	       xclk_per_trans) << (11 - useable_precision);
 	roff = xclk_per_trans_precise * (32 - 4);
 
-	RTRACE("ron = %d, roff = %d\n", ron, roff);
-	RTRACE("vclk_freq = %d, per = %d\n", vclk_freq, xclk_per_trans_precise);
+	RTRACE("ron = %d, roff = %d", ron, roff);
+	RTRACE("vclk_freq = %d, per = %d", vclk_freq, xclk_per_trans_precise);
 
 	if ((ron + rinfo->ram.rloop) >= roff) {
 		printk("radeonfb: error ron out of range\n");
@@ -2621,6 +2665,11 @@
 		newmode.tmds_crc = rinfo->init_state.tmds_crc;
 		newmode.tmds_transmitter_cntl = rinfo->init_state.tmds_transmitter_cntl;
 
+		/* XXX                                                  :pdh *
+		 * this doesn't work with some DFPs. a different driver that *
+		 * does work loads the FP CRTC registers from initial saved  *
+		 * values and doesn't tweak with tmds_transmitter_cntl ????? */
+
 		if (primary_mon == MT_LCD) {
 			newmode.lvds_gen_cntl |= (LVDS_ON | LVDS_BLON);
 			newmode.fp_gen_cntl &= ~(FP_FPON | FP_TMDS_EN);
@@ -2657,15 +2706,13 @@
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
@@ -2743,7 +2790,7 @@
 	}
 
 	/* unblank screen */
-	OUTREG8(CRTC_EXT_CNTL + 1, 0);
+	OUTREG(CRTC_EXT_CNTL, mode->crtc_ext_cntl);
 
 	return;
 }
@@ -2957,7 +3004,7 @@
 			       int dsty, int dstx, int height, int width)
 {
 	struct radeonfb_info *rinfo = (struct radeonfb_info *)(p->fb_info);
-	u32 dp_cntl = DST_LAST_PEL;
+	u32 dp_cntl;
 
 	srcx *= fontwidth(p);
 	srcy *= fontheight(p);
@@ -2966,6 +3013,8 @@
 	width *= fontwidth(p);
 	height *= fontheight(p);
 
+	dp_cntl = 0;
+
 	if (srcy < dsty) {
 		srcy += height - 1;
 		dsty += height - 1;
@@ -2989,25 +3038,14 @@
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
@@ -3018,19 +3056,75 @@
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
 	clear_margins:		fbcon_cfb8_clear_margins,
+	fontwidthmask:		FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
+};
+#endif
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
+static struct display_switch fbcon_radeon16 = {
+	setup:			fbcon_cfb16_setup,
+	bmove:			fbcon_radeon_bmove,
+	clear:			fbcon_radeon16_clear,
+	putc:			fbcon_cfb16_putc,
+	putcs:			fbcon_cfb16_putcs,
+	revc:			fbcon_cfb16_revc,
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
+static struct display_switch fbcon_radeon32 = {
+	setup:			fbcon_cfb32_setup,
+	bmove:			fbcon_radeon_bmove,
+	clear:			fbcon_radeon32_clear,
+	putc:			fbcon_cfb32_putc,
+	putcs:			fbcon_cfb32_putcs,
+	revc:			fbcon_cfb32_revc,
+	clear_margins:		fbcon_cfb32_clear_margins,
 	fontwidthmask:		FONTWIDTH(4)|FONTWIDTH(8)|FONTWIDTH(12)|FONTWIDTH(16)
 };
 #endif
diff -ur linux-2.4.19-pre2/include/linux/fb.h linux.pdh/include/linux/fb.h
--- linux-2.4.19-pre2/include/linux/fb.h	Sat Apr  6 16:34:40 2002
+++ linux.pdh/include/linux/fb.h	Tue Apr  9 06:41:47 2002
@@ -94,6 +94,7 @@
 #define FB_ACCEL_IGS_CYBER5000	35	/* CyberPro 5000		*/
 #define FB_ACCEL_SIS_GLAMOUR    36	/* SiS 300/630/540              */
 #define FB_ACCEL_3DLABS_PERMEDIA3 37	/* 3Dlabs Permedia 3		*/
+#define FB_ACCEL_ATI_RADEON	38	/* ATI Radeon			*/
 
 struct fb_fix_screeninfo {
 	char id[16];			/* identification string eg "TT Builtin" */
