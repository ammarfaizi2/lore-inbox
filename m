Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312987AbSDBXB0>; Tue, 2 Apr 2002 18:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312991AbSDBXBM>; Tue, 2 Apr 2002 18:01:12 -0500
Received: from anchor-post-35.mail.demon.net ([194.217.242.93]:54799 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id <S312983AbSDBXAv>; Tue, 2 Apr 2002 18:00:51 -0500
Date: Wed, 3 Apr 2002 00:00:43 +0100
To: linux-kernel@vger.kernel.org
Cc: ajoshi@unixbox.com
Subject: [PATCH] 2.4.19pre2 radeonfb
Message-ID: <20020402230043.GA4330@berserk.demon.co.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org, ajoshi@unixbox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Horton <pdh@berserk.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small patch that fixes some issues with the Radeon frame buffer driver.

1) Pulled updated soft reset code from XFree86 (stopped my VE hanging the
machine when acceleration was enabled).

2) Added MTRR for frame buffer region.

3) Fixed a couple of buglets in the acceleration code. The driver now
enables acceleration by default (acceleration support for 8bpp mode
only).

P.

diff -ur linux.vanilla/drivers/video/radeon.h linux/drivers/video/radeon.h
--- linux.vanilla/drivers/video/radeon.h	Tue Apr  2 23:05:03 2002
+++ linux/drivers/video/radeon.h	Tue Apr  2 23:06:22 2002
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
--- linux.vanilla/drivers/video/radeonfb.c	Tue Apr  2 23:05:03 2002
+++ linux/drivers/video/radeonfb.c	Tue Apr  2 23:07:38 2002
@@ -44,6 +44,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
+#include <asm/mtrr.h>
 
 #include <asm/io.h>
 #if defined(__powerpc__)
@@ -261,6 +262,8 @@
 	u32 mmio_base;
 	u32 fb_base;
 
+	int mtrr_hdl;
+
 	struct pci_dev *pdev;
 
 	unsigned char *EDID;
@@ -484,7 +487,7 @@
 
 static void _radeon_engine_reset(struct radeonfb_info *rinfo)
 {
-	u32 clock_cntl_index, mclk_cntl, rbbm_soft_reset;
+	u32 clock_cntl_index, mclk_cntl, rbbm_soft_reset, host_path_cntl;
 
 	radeon_engine_flush (rinfo);
 
@@ -498,6 +501,9 @@
 			   FORCEON_YCLKB |
 			   FORCEON_MC |
 			   FORCEON_AIC));
+
+	host_path_cntl = INREG(HOST_PATH_CNTL);
+
 	rbbm_soft_reset = INREG(RBBM_SOFT_RESET);
 
 	OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset |
@@ -507,8 +513,7 @@
 				SOFT_RESET_RE |
 				SOFT_RESET_PP |
 				SOFT_RESET_E2 |
-				SOFT_RESET_RB |
-				SOFT_RESET_HDP);
+				SOFT_RESET_RB);
 	INREG(RBBM_SOFT_RESET);
 	OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset & (u32)
 				~(SOFT_RESET_CP |
@@ -517,13 +522,16 @@
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
@@ -595,6 +603,7 @@
 static char fontname[40] __initdata;
 static char *mode_option __initdata;
 static char noaccel __initdata = 0;
+static char nomtrr __initdata = 0;
 static int panel_yres __initdata = 0;
 static char force_dfp __initdata = 0;
 static struct radeonfb_info *board_list = NULL;
@@ -731,6 +740,8 @@
 			force_dfp = 1;
 		} else if (!strncmp(this_opt, "panel_yres:", 11)) {
 			panel_yres = simple_strtoul((this_opt+11), NULL, 0);
+		} else if (!strncmp(this_opt, "nomtrr", 6)) {
+			nomtrr = 1;
                 } else
 			mode_option = this_opt;
         }
@@ -960,9 +971,6 @@
 		return -ENODEV;
 	}
 
-	/* XXX turn off accel for now, blts aren't working right */
-	noaccel = 1;
-
 	/* currcon not yet configured, will be set by first switch */
 	rinfo->currcon = -1;
 
@@ -998,6 +1006,10 @@
 		return -ENODEV;
 	}
 
+#ifdef CONFIG_MTRR
+	rinfo->mtrr_hdl = nomtrr ? -1 : mtrr_add(rinfo->fb_base_phys, rinfo->video_ram, MTRR_TYPE_WRCOMB, 1);
+#endif
+
 	if (!noaccel) {
 		/* initialize the engine */
 		radeon_engine_init (rinfo);
@@ -1046,6 +1058,11 @@
 	/* restore original state */
         radeon_write_mode (rinfo, &rinfo->init_state);
  
+#ifdef CONFIG_MTRR
+	if(rinfo->mtrr_hdl >= 0)
+		mtrr_del(rinfo->mtrr_hdl, 0, 0);
+#endif
+
         unregister_framebuffer ((struct fb_info *) rinfo);
                 
         iounmap ((void*)rinfo->mmio_base);
@@ -1540,7 +1557,7 @@
 	radeon_engine_reset ();
 
 	radeon_fifo_wait (1);
-	OUTREG(DSTCACHE_MODE, 0);
+	OUTREG(RB2D_DSTCACHE_MODE, 0);
 
 	/* XXX */
 	rinfo->pitch = ((rinfo->xres * (rinfo->bpp / 8) + 0x3f)) >> 6;
@@ -1703,7 +1720,7 @@
         switch (disp->var.bits_per_pixel) {
 #ifdef FBCON_HAS_CFB8
                 case 8:
-                        disp->dispsw = &fbcon_cfb8;
+                        disp->dispsw = accel ? &fbcon_radeon8 : &fbcon_cfb8;
                         disp->visual = FB_VISUAL_PSEUDOCOLOR;
                         disp->line_length = disp->var.xres_virtual;
                         break;
@@ -2957,7 +2974,7 @@
 			       int dsty, int dstx, int height, int width)
 {
 	struct radeonfb_info *rinfo = (struct radeonfb_info *)(p->fb_info);
-	u32 dp_cntl = DST_LAST_PEL;
+	u32 dp_cntl;
 
 	srcx *= fontwidth(p);
 	srcy *= fontheight(p);
@@ -2966,6 +2983,8 @@
 	width *= fontwidth(p);
 	height *= fontheight(p);
 
+	dp_cntl = 0;
+
 	if (srcy < dsty) {
 		srcy += height - 1;
 		dsty += height - 1;
@@ -2989,6 +3008,8 @@
 	OUTREG(SRC_Y_X, (srcy << 16) | srcx);
 	OUTREG(DST_Y_X, (dsty << 16) | dstx);
 	OUTREG(DST_HEIGHT_WIDTH, (height << 16) | width);
+	
+	radeon_engine_idle();
 }
 
 
@@ -3018,6 +3039,8 @@
 	OUTREG(DP_CNTL, (DST_X_LEFT_TO_RIGHT | DST_Y_TOP_TO_BOTTOM));
 	OUTREG(DST_Y_X, (srcy << 16) | srcx);
 	OUTREG(DST_WIDTH_HEIGHT, (width << 16) | height);
+
+	radeon_engine_idle();
 }
 
 
