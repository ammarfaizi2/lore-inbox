Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311647AbSDDVoe>; Thu, 4 Apr 2002 16:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311670AbSDDVoT>; Thu, 4 Apr 2002 16:44:19 -0500
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:35844 "EHLO
	anchor-post-33.mail.demon.net") by vger.kernel.org with ESMTP
	id <S311647AbSDDVoE>; Thu, 4 Apr 2002 16:44:04 -0500
Date: Thu, 4 Apr 2002 22:43:58 +0100
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Subject: [PATCH] radeonfb 2.4.19-pre2
Message-ID: <20020404214358.GA1811@berserk.demon.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org, alan@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@berserk.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spurred on by a little positive feedback, I've added more stuff to my
patch for the ATI Radeon frame buffer driver.


* Reinitialise accelerator on console switch. This ensures the
accelerator is in a known state after X exits.

* Added acceleration functions for 15/16/32 bit modes.

* Removed 24 bit support. It didn't work and the X source hints that
Radeon might not support 24 bit modes. If you ask for a 24 bit mode, the
driver will switch to a 32 bit one.

* Minor fix to video mode switch code which means 'fbset' now works
correctly. This also means the 'UseFBDev' option in X works. Commented out
a hack that looks like it was a failed attempt to work around this bug
previously.

* Hacked wildly at the colour support to get it to work. Removed use of
the palette for 15/16 bit modes (I can't fathom why it was there in the
first place). The palette is now initialised to an identity mapping for
15/16/32 bit modes. The consoles now work fine at all colour depths, and
the Tux logo is displayed correctly at all depths too :-)

* Added an untested fix for acceleration on flat panels. "Stuffed Crust"
reported garbled display when acceleration was enabled, this might fix it.

* Other minor cleanups.


P.


diff -ur linux.vanilla/drivers/video/radeon.h linux/drivers/video/radeon.h
--- linux.vanilla/drivers/video/radeon.h	Thu Apr  4 22:10:31 2002
+++ linux/drivers/video/radeon.h	Thu Apr  4 22:11:12 2002
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
diff -ur linux.vanilla/drivers/video/radeonfb.c linux/drivers/video/radeonfb.c
--- linux.vanilla/drivers/video/radeonfb.c	Thu Apr  4 22:10:31 2002
+++ linux/drivers/video/radeonfb.c	Thu Apr  4 22:12:37 2002
@@ -22,6 +22,10 @@
  *
  *	Special thanks to ATI DevRel team for their hardware donations.
  *
+ * 	2002-04-02	Added MTRR support. Fixed 8bpp acceleration. Added
+ * 			acceleration for 16/32bpp. Applied fix from XFree86
+ * 			for hard crash on accelerator reset. Fixed up the
+ * 			colour stuff. Peter Horton <pdh@colonel-panic.org>
  */
 
 
@@ -44,6 +48,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
+#include <asm/mtrr.h>
 
 #include <asm/io.h>
 #if defined(__powerpc__)
@@ -261,6 +266,8 @@
 	u32 mmio_base;
 	u32 fb_base;
 
+	int mtrr_hdl;
+
 	struct pci_dev *pdev;
 
 	unsigned char *EDID;
@@ -270,7 +277,7 @@
 	int currcon;
 	struct display *currcon_display;
 
-	struct { u8 red, green, blue, pad; } palette[256];
+	struct { u8 red, green, blue, alpha; } palette[256];
 
 	int chipset;
 	int video_ram;
@@ -299,17 +306,16 @@
 
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
@@ -478,13 +484,13 @@
 {
 	if (var->bits_per_pixel != 16)
 		return var->bits_per_pixel;
-	return (var->green.length == 6) ? 16 : 15;
+	return (var->green.length == 5) ? 15 : 16;
 }
 
 
 static void _radeon_engine_reset(struct radeonfb_info *rinfo)
 {
-	u32 clock_cntl_index, mclk_cntl, rbbm_soft_reset;
+	u32 clock_cntl_index, mclk_cntl, rbbm_soft_reset, host_path_cntl;
 
 	radeon_engine_flush (rinfo);
 
@@ -498,6 +504,9 @@
 			   FORCEON_YCLKB |
 			   FORCEON_MC |
 			   FORCEON_AIC));
+
+	host_path_cntl = INREG(HOST_PATH_CNTL);
+
 	rbbm_soft_reset = INREG(RBBM_SOFT_RESET);
 
 	OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset |
@@ -507,8 +516,7 @@
 				SOFT_RESET_RE |
 				SOFT_RESET_PP |
 				SOFT_RESET_E2 |
-				SOFT_RESET_RB |
-				SOFT_RESET_HDP);
+				SOFT_RESET_RB);
 	INREG(RBBM_SOFT_RESET);
 	OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset & (u32)
 				~(SOFT_RESET_CP |
@@ -517,13 +525,16 @@
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
@@ -594,7 +605,8 @@
         
 static char fontname[40] __initdata;
 static char *mode_option __initdata;
-static char noaccel __initdata = 0;
+static char noaccel /*__initdata*/ = 0;
+static char nomtrr __initdata = 0;
 static int panel_yres __initdata = 0;
 static char force_dfp __initdata = 0;
 static struct radeonfb_info *board_list = NULL;
@@ -602,6 +614,12 @@
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
@@ -731,6 +749,8 @@
 			force_dfp = 1;
 		} else if (!strncmp(this_opt, "panel_yres:", 11)) {
 			panel_yres = simple_strtoul((this_opt+11), NULL, 0);
+		} else if (!strncmp(this_opt, "nomtrr", 6)) {
+			nomtrr = 1;
                 } else
 			mode_option = this_opt;
         }
@@ -960,9 +980,6 @@
 		return -ENODEV;
 	}
 
-	/* XXX turn off accel for now, blts aren't working right */
-	noaccel = 1;
-
 	/* currcon not yet configured, will be set by first switch */
 	rinfo->currcon = -1;
 
@@ -998,6 +1015,10 @@
 		return -ENODEV;
 	}
 
+#ifdef CONFIG_MTRR
+	rinfo->mtrr_hdl = nomtrr ? -1 : mtrr_add(rinfo->fb_base_phys, rinfo->video_ram, MTRR_TYPE_WRCOMB, 1);
+#endif
+
 	if (!noaccel) {
 		/* initialize the engine */
 		radeon_engine_init (rinfo);
@@ -1046,6 +1067,11 @@
 	/* restore original state */
         radeon_write_mode (rinfo, &rinfo->init_state);
  
+#ifdef CONFIG_MTRR
+	if(rinfo->mtrr_hdl >= 0)
+		mtrr_del(rinfo->mtrr_hdl, 0, 0);
+#endif
+
         unregister_framebuffer ((struct fb_info *) rinfo);
                 
         iounmap ((void*)rinfo->mmio_base);
@@ -1503,6 +1529,8 @@
 		rinfo->vSync_width = (unsigned short) ((tmp & FP_V_SYNC_WID_MASK) >>
 					FP_V_SYNC_WID_SHIFT);
 
+		radeon_update_default_var(rinfo);	/* XXX does this work ? */
+
 		return 1;
 	}
 
@@ -1540,7 +1568,7 @@
 	radeon_engine_reset ();
 
 	radeon_fifo_wait (1);
-	OUTREG(DSTCACHE_MODE, 0);
+	OUTREG(RB2D_DSTCACHE_MODE, 0);
 
 	/* XXX */
 	rinfo->pitch = ((rinfo->xres * (rinfo->bpp / 8) + 0x3f)) >> 6;
@@ -1703,32 +1731,24 @@
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
-                        disp->visual = FB_VISUAL_DIRECTCOLOR;
+                        disp->visual = FB_VISUAL_TRUECOLOR;
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
-                        disp->visual = FB_VISUAL_DIRECTCOLOR;
+                        disp->visual = FB_VISUAL_TRUECOLOR;
                         disp->line_length = disp->var.xres_virtual * 4;
                         break;   
 #endif
@@ -1822,6 +1842,22 @@
                         
 
 
+static void set_palette_entry(struct radeonfb_info *rinfo, unsigned idx, unsigned red, unsigned grn, unsigned blu)
+{
+	OUTREG(PALETTE_INDEX, idx);
+	OUTREG(PALETTE_DATA, (red << 16) | (grn << 8) | blu);
+
+	udelay(1);	/* is this necessary ? */
+}
+
+static void reset_palette(struct radeonfb_info *rinfo)
+{
+	unsigned idx;
+
+	for(idx = 0; idx < 256; ++idx)
+		set_palette_entry(rinfo, idx, idx, idx, idx);
+}
+
 /*
  * fb ops
  */
@@ -1855,7 +1891,7 @@
 	if (noaccel)
 	        fix->accel = FB_ACCEL_NONE;
 	else
-		fix->accel = 40;	/* XXX */
+		fix->accel = FB_ACCEL_ATI_RADEON;
         
         return 0;
 }
@@ -1907,10 +1943,7 @@
 		case 9 ... 16:
 			v.bits_per_pixel = 16;
 			break;
-		case 17 ... 24:
-			v.bits_per_pixel = 24;
-			break;
-		case 25 ... 32:
+		case 17 ... 32:
 			v.bits_per_pixel = 32;
 			break;
 		default:
@@ -1934,10 +1967,10 @@
 			nom = 2;
 			den = 1;
 			disp->line_length = v.xres_virtual * 2;
-			disp->visual = FB_VISUAL_DIRECTCOLOR;
+			disp->visual = FB_VISUAL_TRUECOLOR;
 			v.red.offset = 10;
 			v.green.offset = 5;
-			v.red.offset = 0;
+			v.blue.offset = 0;
 			v.red.length = v.green.length = v.blue.length = 5;
 			v.transp.offset = v.transp.length = 0;
 			break;
@@ -1945,7 +1978,7 @@
                         nom = 2;
                         den = 1;
                         disp->line_length = v.xres_virtual * 2;
-                        disp->visual = FB_VISUAL_DIRECTCOLOR;
+                        disp->visual = FB_VISUAL_TRUECOLOR;
                         v.red.offset = 11;
                         v.green.offset = 5;
                         v.blue.offset = 0;
@@ -1956,25 +1989,12 @@
                         break;  
 #endif
                         
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
-#endif
 #ifdef FBCON_HAS_CFB32
                 case 32:
                         nom = 4;
                         den = 1;
                         disp->line_length = v.xres_virtual * 4;
-                        disp->visual = FB_VISUAL_DIRECTCOLOR;
+                        disp->visual = FB_VISUAL_TRUECOLOR;
                         v.red.offset = 16;
                         v.green.offset = 8;
                         v.blue.offset = 0;
@@ -2033,8 +2053,14 @@
          
         radeon_load_video_mode (rinfo, &v);
                 
+	if(v.bits_per_pixel > 8)
+		reset_palette(rinfo);
+
         do_install_cmap(con, info);
   
+	if(accel)
+		radeon_engine_init(rinfo);
+
         return 0;
 }
 
@@ -2144,12 +2170,14 @@
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
@@ -2239,10 +2267,10 @@
 	if (regno > 255)
 		return 1;
      
- 	*red = (rinfo->palette[regno].red<<8) | rinfo->palette[regno].red; 
-    	*green = (rinfo->palette[regno].green<<8) | rinfo->palette[regno].green;
-    	*blue = (rinfo->palette[regno].blue<<8) | rinfo->palette[regno].blue;
-    	*transp = 0;
+ 	*red	= (unsigned) rinfo->palette[regno].red << 8;
+    	*green	= (unsigned) rinfo->palette[regno].green << 8;
+    	*blue	= (unsigned) rinfo->palette[regno].blue << 8;
+    	*transp	= (unsigned) rinfo->palette[regno].alpha << 8;
 
 	return 0;
 }                            
@@ -2250,78 +2278,51 @@
 
 
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
+	rinfo->palette[regno].alpha	= alpha;
 
-        /* default */
-        pindex = regno;
-        
-	if (rinfo->bpp == 16) {
-		pindex = regno * 8;
+	if(rinfo->bpp == 8) {
 
-		if (rinfo->depth == 16 && regno > 63)
-			return 1;
-		if (rinfo->depth == 15 && regno > 31)
-			return 1;
+		set_palette_entry(rinfo, regno, red, green, blue);
+		return 0;
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
+	if(regno > 15)
+		return 1;
+
+	if(rinfo->bpp == 32) {
+
+		rinfo->con_cmap.cfb32[regno] = (red << 16) | (green << 8) | blue;
+		return 0;
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
-	return 0;
-}
+	red	>>= 3;
+	green	>>= 2;
+	blue	>>= 3;
 
+	if(rinfo->depth == 15)
+		green >>= 1;
+	else
+		red <<= 1;
 
+	rinfo->con_cmap.cfb16[regno] = (red << 10) | (green << 5) | blue;
+
+	return 0;
+}
 
 static void radeon_save_state (struct radeonfb_info *rinfo,
                                struct radeon_regs *save)
@@ -2493,8 +2494,10 @@
 	rinfo->bpp = mode->bits_per_pixel;
 	rinfo->depth = depth;
 
+#if 0
 	rinfo->hack_crtc_ext_cntl = newmode.crtc_ext_cntl;
 	rinfo->hack_crtc_v_sync_strt_wid = newmode.crtc_v_sync_strt_wid;
+#endif
 
 	if (freq > rinfo->pll.ppll_max)
 		freq = rinfo->pll.ppll_max;
@@ -2657,15 +2660,13 @@
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
@@ -2743,7 +2744,7 @@
 	}
 
 	/* unblank screen */
-	OUTREG8(CRTC_EXT_CNTL + 1, 0);
+	OUTREG(CRTC_EXT_CNTL, mode->crtc_ext_cntl);
 
 	return;
 }
@@ -2957,7 +2958,7 @@
 			       int dsty, int dstx, int height, int width)
 {
 	struct radeonfb_info *rinfo = (struct radeonfb_info *)(p->fb_info);
-	u32 dp_cntl = DST_LAST_PEL;
+	u32 dp_cntl;
 
 	srcx *= fontwidth(p);
 	srcy *= fontheight(p);
@@ -2966,6 +2967,8 @@
 	width *= fontwidth(p);
 	height *= fontheight(p);
 
+	dp_cntl = 0;
+
 	if (srcy < dsty) {
 		srcy += height - 1;
 		dsty += height - 1;
@@ -2989,25 +2992,14 @@
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
@@ -3018,19 +3010,75 @@
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
diff -ur linux.vanilla/include/linux/fb.h linux/include/linux/fb.h
--- linux.vanilla/include/linux/fb.h	Thu Apr  4 22:10:42 2002
+++ linux/include/linux/fb.h	Thu Apr  4 22:11:12 2002
@@ -94,6 +94,7 @@
 #define FB_ACCEL_IGS_CYBER5000	35	/* CyberPro 5000		*/
 #define FB_ACCEL_SIS_GLAMOUR    36	/* SiS 300/630/540              */
 #define FB_ACCEL_3DLABS_PERMEDIA3 37	/* 3Dlabs Permedia 3		*/
+#define FB_ACCEL_ATI_RADEON	38	/* ATI Radeon			*/
 
 struct fb_fix_screeninfo {
 	char id[16];			/* identification string eg "TT Builtin" */
