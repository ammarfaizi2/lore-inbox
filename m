Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263971AbUEMO4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbUEMO4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 10:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbUEMO4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 10:56:47 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:22433 "EHLO
	mail-relay-2.tiscali.i") by vger.kernel.org with ESMTP
	id S263971AbUEMO4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 10:56:36 -0400
Date: Thu, 13 May 2004 16:56:40 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040513145640.GA3430@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040513134847.GA2024@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kronos <kronos@kronoz.cjb.net> ha scritto:
> do_IRQ: stack overflow: 460
> Call Trace:
> [<c01086be>] do_IRQ+0x3fe/0x410
> [<c011c902>] __wake_up_locked+0x22/0x30
> [<c010633c>] common_interrupt+0x18/0x20
> [<c02e1baa>] radeon_write_pll_regs+0xbaa/0x1e10
> [<c011c902>] __wake_up_locked+0x22/0x30
> [<c02e3c5c>] radeon_calc_pll_regs+0xfc/0x120
> [<c02e333c>] radeon_write_mode+0x35c/0xb80
> [<c02e4509>] radeonfb_set_par+0x889/0xb50

I think that the problem is here:

int radeonfb_set_par(struct fb_info *info)
{
        struct radeonfb_info *rinfo = info->par;
        struct fb_var_screeninfo *mode = &info->var;
        struct radeon_regs newmode;
        
struct radeon_regs is huge: 2356 bytes
Quick fix (I'll test ASAP):

--- linux-2.6/drivers/video/aty/radeon_base.c~	2004-05-13 16:51:08.000000000 +0200
+++ linux-2.6/drivers/video/aty/radeon_base.c	2004-05-13 16:55:09.000000000 +0200
@@ -1397,7 +1397,7 @@
 {
 	struct radeonfb_info *rinfo = info->par;
 	struct fb_var_screeninfo *mode = &info->var;
-	struct radeon_regs newmode;
+	struct radeon_regs *newmode;
 	int hTotal, vTotal, hSyncStart, hSyncEnd,
 	    hSyncPol, vSyncStart, vSyncEnd, vSyncPol, cSync;
 	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};
@@ -1410,6 +1410,10 @@
 	int primary_mon = PRIMARY_MONITOR(rinfo);
 	int depth = var_to_depth(mode);
 
+	newmode = kmalloc(sizeof(*newmode), GFP_KERNEL);
+	if (!newmode)
+		return -ENOMEM;
+
 	/* We always want engine to be idle on a mode switch, even
 	 * if we won't actually change the mode
 	 */
@@ -1449,9 +1453,9 @@
 
 		if (rinfo->panel_info.use_bios_dividers) {
 			nopllcalc = 1;
-			newmode.ppll_div_3 = rinfo->panel_info.fbk_divider |
+			newmode->ppll_div_3 = rinfo->panel_info.fbk_divider |
 				(rinfo->panel_info.post_divider << 16);
-			newmode.ppll_ref_div = rinfo->panel_info.ref_divider;
+			newmode->ppll_ref_div = rinfo->panel_info.ref_divider;
 		}
 	}
 	dotClock = 1000000000 / pixClock;
@@ -1489,38 +1493,38 @@
 
 	hsync_start = hSyncStart - 8 + hsync_fudge;
 
-	newmode.crtc_gen_cntl = CRTC_EXT_DISP_EN | CRTC_EN |
+	newmode->crtc_gen_cntl = CRTC_EXT_DISP_EN | CRTC_EN |
 				(format << 8);
 
 	/* Clear auto-center etc... */
-	newmode.crtc_more_cntl = rinfo->init_state.crtc_more_cntl;
-	newmode.crtc_more_cntl &= 0xfffffff0;
+	newmode->crtc_more_cntl = rinfo->init_state.crtc_more_cntl;
+	newmode->crtc_more_cntl &= 0xfffffff0;
 	
 	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
-		newmode.crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN;
+		newmode->crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN;
 		if (mirror)
-			newmode.crtc_ext_cntl |= CRTC_CRT_ON;
+			newmode->crtc_ext_cntl |= CRTC_CRT_ON;
 
-		newmode.crtc_gen_cntl &= ~(CRTC_DBL_SCAN_EN |
+		newmode->crtc_gen_cntl &= ~(CRTC_DBL_SCAN_EN |
 					   CRTC_INTERLACE_EN);
 	} else {
-		newmode.crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN |
+		newmode->crtc_ext_cntl = VGA_ATI_LINEAR | XCRT_CNT_EN |
 					CRTC_CRT_ON;
 	}
 
-	newmode.dac_cntl = /* INREG(DAC_CNTL) | */ DAC_MASK_ALL | DAC_VGA_ADR_EN |
+	newmode->dac_cntl = /* INREG(DAC_CNTL) | */ DAC_MASK_ALL | DAC_VGA_ADR_EN |
 			   DAC_8BIT_EN;
 
-	newmode.crtc_h_total_disp = ((((hTotal / 8) - 1) & 0x3ff) |
+	newmode->crtc_h_total_disp = ((((hTotal / 8) - 1) & 0x3ff) |
 				     (((mode->xres / 8) - 1) << 16));
 
-	newmode.crtc_h_sync_strt_wid = ((hsync_start & 0x1fff) |
+	newmode->crtc_h_sync_strt_wid = ((hsync_start & 0x1fff) |
 					(hsync_wid << 16) | (h_sync_pol << 23));
 
-	newmode.crtc_v_total_disp = ((vTotal - 1) & 0xffff) |
+	newmode->crtc_v_total_disp = ((vTotal - 1) & 0xffff) |
 				    ((mode->yres - 1) << 16);
 
-	newmode.crtc_v_sync_strt_wid = (((vSyncStart - 1) & 0xfff) |
+	newmode->crtc_v_sync_strt_wid = (((vSyncStart - 1) & 0xfff) |
 					 (vsync_wid << 16) | (v_sync_pol  << 23));
 
 	if (!radeon_accel_disabled()) {
@@ -1529,18 +1533,18 @@
  				& ~(0x3f)) >> 6;
 
 		/* Then, re-multiply it to get the CRTC pitch */
-		newmode.crtc_pitch = (rinfo->pitch << 3) / ((mode->bits_per_pixel + 1) / 8);
+		newmode->crtc_pitch = (rinfo->pitch << 3) / ((mode->bits_per_pixel + 1) / 8);
 	} else
-		newmode.crtc_pitch = (mode->xres_virtual >> 3);
+		newmode->crtc_pitch = (mode->xres_virtual >> 3);
 
-	newmode.crtc_pitch |= (newmode.crtc_pitch << 16);
+	newmode->crtc_pitch |= (newmode->crtc_pitch << 16);
 
 	/*
 	 * It looks like recent chips have a problem with SURFACE_CNTL,
 	 * setting SURF_TRANSLATION_DIS completely disables the
 	 * swapper as well, so we leave it unset now.
 	 */
-	newmode.surface_cntl = 0;
+	newmode->surface_cntl = 0;
 
 #if defined(__BIG_ENDIAN)
 
@@ -1550,28 +1554,28 @@
 	 */
 	switch (mode->bits_per_pixel) {
 		case 16:
-			newmode.surface_cntl |= NONSURF_AP0_SWP_16BPP;
-			newmode.surface_cntl |= NONSURF_AP1_SWP_16BPP;
+			newmode->surface_cntl |= NONSURF_AP0_SWP_16BPP;
+			newmode->surface_cntl |= NONSURF_AP1_SWP_16BPP;
 			break;
 		case 24:	
 		case 32:
-			newmode.surface_cntl |= NONSURF_AP0_SWP_32BPP;
-			newmode.surface_cntl |= NONSURF_AP1_SWP_32BPP;
+			newmode->surface_cntl |= NONSURF_AP0_SWP_32BPP;
+			newmode->surface_cntl |= NONSURF_AP1_SWP_32BPP;
 			break;
 	}
 #endif
 
 	/* Clear surface registers */
 	for (i=0; i<8; i++) {
-		newmode.surf_lower_bound[i] = 0;
-		newmode.surf_upper_bound[i] = 0x1f;
-		newmode.surf_info[i] = 0;
+		newmode->surf_lower_bound[i] = 0;
+		newmode->surf_upper_bound[i] = 0x1f;
+		newmode->surf_info[i] = 0;
 	}
 
 	RTRACE("h_total_disp = 0x%x\t   hsync_strt_wid = 0x%x\n",
-		newmode.crtc_h_total_disp, newmode.crtc_h_sync_strt_wid);
+		newmode->crtc_h_total_disp, newmode->crtc_h_sync_strt_wid);
 	RTRACE("v_total_disp = 0x%x\t   vsync_strt_wid = 0x%x\n",
-		newmode.crtc_v_total_disp, newmode.crtc_v_sync_strt_wid);
+		newmode->crtc_v_total_disp, newmode->crtc_v_sync_strt_wid);
 
 	rinfo->bpp = mode->bits_per_pixel;
 	rinfo->depth = depth;
@@ -1580,9 +1584,9 @@
 	RTRACE("freq = %lu\n", (unsigned long)freq);
 
 	if (!nopllcalc)
-		radeon_calc_pll_regs(rinfo, &newmode, freq);
+		radeon_calc_pll_regs(rinfo, newmode, freq);
 
-	newmode.vclk_ecp_cntl = rinfo->init_state.vclk_ecp_cntl;
+	newmode->vclk_ecp_cntl = rinfo->init_state.vclk_ecp_cntl;
 
 	if ((primary_mon == MT_DFP) || (primary_mon == MT_LCD)) {
 		unsigned int hRatio, vRatio;
@@ -1592,35 +1596,35 @@
 		if (mode->yres > rinfo->panel_info.yres)
 			mode->yres = rinfo->panel_info.yres;
 
-		newmode.fp_horz_stretch = (((rinfo->panel_info.xres / 8) - 1)
+		newmode->fp_horz_stretch = (((rinfo->panel_info.xres / 8) - 1)
 					   << HORZ_PANEL_SHIFT);
-		newmode.fp_vert_stretch = ((rinfo->panel_info.yres - 1)
+		newmode->fp_vert_stretch = ((rinfo->panel_info.yres - 1)
 					   << VERT_PANEL_SHIFT);
 
 		if (mode->xres != rinfo->panel_info.xres) {
 			hRatio = round_div(mode->xres * HORZ_STRETCH_RATIO_MAX,
 					   rinfo->panel_info.xres);
-			newmode.fp_horz_stretch = (((((unsigned long)hRatio) & HORZ_STRETCH_RATIO_MASK)) |
-						   (newmode.fp_horz_stretch &
+			newmode->fp_horz_stretch = (((((unsigned long)hRatio) & HORZ_STRETCH_RATIO_MASK)) |
+						   (newmode->fp_horz_stretch &
 						    (HORZ_PANEL_SIZE | HORZ_FP_LOOP_STRETCH |
 						     HORZ_AUTO_RATIO_INC)));
-			newmode.fp_horz_stretch |= (HORZ_STRETCH_BLEND |
+			newmode->fp_horz_stretch |= (HORZ_STRETCH_BLEND |
 						    HORZ_STRETCH_ENABLE);
 		}
-		newmode.fp_horz_stretch &= ~HORZ_AUTO_RATIO;
+		newmode->fp_horz_stretch &= ~HORZ_AUTO_RATIO;
 
 		if (mode->yres != rinfo->panel_info.yres) {
 			vRatio = round_div(mode->yres * VERT_STRETCH_RATIO_MAX,
 					   rinfo->panel_info.yres);
-			newmode.fp_vert_stretch = (((((unsigned long)vRatio) & VERT_STRETCH_RATIO_MASK)) |
-						   (newmode.fp_vert_stretch &
+			newmode->fp_vert_stretch = (((((unsigned long)vRatio) & VERT_STRETCH_RATIO_MASK)) |
+						   (newmode->fp_vert_stretch &
 						   (VERT_PANEL_SIZE | VERT_STRETCH_RESERVED)));
-			newmode.fp_vert_stretch |= (VERT_STRETCH_BLEND |
+			newmode->fp_vert_stretch |= (VERT_STRETCH_BLEND |
 						    VERT_STRETCH_ENABLE);
 		}
-		newmode.fp_vert_stretch &= ~VERT_AUTO_RATIO_EN;
+		newmode->fp_vert_stretch &= ~VERT_AUTO_RATIO_EN;
 
-		newmode.fp_gen_cntl = (rinfo->init_state.fp_gen_cntl & (u32)
+		newmode->fp_gen_cntl = (rinfo->init_state.fp_gen_cntl & (u32)
 				       ~(FP_SEL_CRTC2 |
 					 FP_RMX_HVSYNC_CONTROL_EN |
 					 FP_DFP_SYNC_SEL |
@@ -1630,46 +1634,46 @@
 					 FP_CRTC_USE_SHADOW_VEND |
 					 FP_CRT_SYNC_ALT));
 
-		newmode.fp_gen_cntl |= (FP_CRTC_DONT_SHADOW_VPAR |
+		newmode->fp_gen_cntl |= (FP_CRTC_DONT_SHADOW_VPAR |
 					FP_CRTC_DONT_SHADOW_HEND);
 
-		newmode.lvds_gen_cntl = rinfo->init_state.lvds_gen_cntl;
-		newmode.lvds_pll_cntl = rinfo->init_state.lvds_pll_cntl;
-		newmode.tmds_crc = rinfo->init_state.tmds_crc;
-		newmode.tmds_transmitter_cntl = rinfo->init_state.tmds_transmitter_cntl;
+		newmode->lvds_gen_cntl = rinfo->init_state.lvds_gen_cntl;
+		newmode->lvds_pll_cntl = rinfo->init_state.lvds_pll_cntl;
+		newmode->tmds_crc = rinfo->init_state.tmds_crc;
+		newmode->tmds_transmitter_cntl = rinfo->init_state.tmds_transmitter_cntl;
 
 		if (primary_mon == MT_LCD) {
-			newmode.lvds_gen_cntl |= (LVDS_ON | LVDS_BLON);
-			newmode.fp_gen_cntl &= ~(FP_FPON | FP_TMDS_EN);
+			newmode->lvds_gen_cntl |= (LVDS_ON | LVDS_BLON);
+			newmode->fp_gen_cntl &= ~(FP_FPON | FP_TMDS_EN);
 		} else {
 			/* DFP */
-			newmode.fp_gen_cntl |= (FP_FPON | FP_TMDS_EN);
-			newmode.tmds_transmitter_cntl = (TMDS_RAN_PAT_RST | TMDS_ICHCSEL) &
+			newmode->fp_gen_cntl |= (FP_FPON | FP_TMDS_EN);
+			newmode->tmds_transmitter_cntl = (TMDS_RAN_PAT_RST | TMDS_ICHCSEL) &
 							 ~(TMDS_PLLRST);
 			/* TMDS_PLL_EN bit is reversed on RV (and mobility) chips */
 			if ((rinfo->family == CHIP_FAMILY_R300) ||
 			    (rinfo->family == CHIP_FAMILY_R350) ||
 			    (rinfo->family == CHIP_FAMILY_RV350) ||
 			    (rinfo->family == CHIP_FAMILY_R200) || !rinfo->has_CRTC2)
-				newmode.tmds_transmitter_cntl &= ~TMDS_PLL_EN;
+				newmode->tmds_transmitter_cntl &= ~TMDS_PLL_EN;
 			else
-				newmode.tmds_transmitter_cntl |= TMDS_PLL_EN;
-			newmode.crtc_ext_cntl &= ~CRTC_CRT_ON;
+				newmode->tmds_transmitter_cntl |= TMDS_PLL_EN;
+			newmode->crtc_ext_cntl &= ~CRTC_CRT_ON;
 		}
 
-		newmode.fp_crtc_h_total_disp = (((rinfo->panel_info.hblank / 8) & 0x3ff) |
+		newmode->fp_crtc_h_total_disp = (((rinfo->panel_info.hblank / 8) & 0x3ff) |
 				(((mode->xres / 8) - 1) << 16));
-		newmode.fp_crtc_v_total_disp = (rinfo->panel_info.vblank & 0xffff) |
+		newmode->fp_crtc_v_total_disp = (rinfo->panel_info.vblank & 0xffff) |
 				((mode->yres - 1) << 16);
-		newmode.fp_h_sync_strt_wid = ((rinfo->panel_info.hOver_plus & 0x1fff) |
+		newmode->fp_h_sync_strt_wid = ((rinfo->panel_info.hOver_plus & 0x1fff) |
 				(hsync_wid << 16) | (h_sync_pol << 23));
-		newmode.fp_v_sync_strt_wid = ((rinfo->panel_info.vOver_plus & 0xfff) |
+		newmode->fp_v_sync_strt_wid = ((rinfo->panel_info.vOver_plus & 0xfff) |
 				(vsync_wid << 16) | (v_sync_pol  << 23));
 	}
 
 	/* do it! */
 	if (!rinfo->asleep) {
-		radeon_write_mode (rinfo, &newmode);
+		radeon_write_mode (rinfo, newmode);
 		/* (re)initialize the engine */
 		if (!radeon_accel_disabled())
 			radeonfb_engine_init (rinfo);
@@ -1689,6 +1693,7 @@
 	btext_update_display(rinfo->fb_base_phys, mode->xres, mode->yres,
 			     rinfo->depth, info->fix.line_length);
 #endif
+	kfree(newmode);
 
 	return 0;
 }


Luca
-- 
Home: http://kronoz.cjb.net
Runtime error 6D at f000:a12f : user incompetente
