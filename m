Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268688AbUJKEb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268688AbUJKEb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 00:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268685AbUJKEb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 00:31:57 -0400
Received: from gate.crashing.org ([63.228.1.57]:33467 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268688AbUJKE20 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 00:28:26 -0400
Subject: [PATCH] (Test) rework radeonfb blanking
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Jeremy Kerr <jk@ozlabs.org>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1097468880.3249.6.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 11 Oct 2004 14:28:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch cleans up some old cruft in the manipulation of the LVDS
interface registers and fixes the blanking code to work with various
DVI flat panels.

Since this is all very sensitive stuff, I'm posting the patch here for
testing before submitting it upstream, though Andrew is welcome to put
it in -mm.

It also fix some problems with getting the right PLL setup on recent Mac
laptops, replacing the old hard coded list of values with cleaner code
that "probes" the PLL setup done by the firmware.

Ben.

diff -urN linux-2.5/drivers/video/aty/radeon_base.c linux-lappy/drivers/video/aty/radeon_base.c
--- linux-2.5/drivers/video/aty/radeon_base.c	2004-10-11 13:51:42.000000000 +1000
+++ linux-lappy/drivers/video/aty/radeon_base.c	2004-10-11 14:11:52.000000000 +1000
@@ -527,8 +527,7 @@
         break;
 	}
 
-	OUTREG8(CLOCK_CNTL_INDEX, 1);
-	ppll_div_sel = INREG8(CLOCK_CNTL_DATA + 1) & 0x3;
+	ppll_div_sel = INREG(CLOCK_CNTL_INDEX + 1) & 0x3;
 
 	n = (INPLL(PPLL_DIV_0 + ppll_div_sel) & 0x7ff);
 	m = (INPLL(PPLL_REF_DIV) & 0x3ff);
@@ -595,53 +594,10 @@
  */
 static void __devinit radeon_get_pllinfo(struct radeonfb_info *rinfo)
 {
-#ifdef CONFIG_PPC_OF
 	/*
-	 * Retreive PLL infos from Open Firmware first
-	 */
-       	if (!force_measure_pll && radeon_read_xtal_OF(rinfo) == 0) {
-       		printk(KERN_INFO "radeonfb: Retreived PLL infos from Open Firmware\n");
-       		rinfo->pll.ref_div = INPLL(PPLL_REF_DIV) & 0x3ff;
-		/* FIXME: Max clock may be higher on newer chips */
-       		rinfo->pll.ppll_min = 12000;
-       		rinfo->pll.ppll_max = 35000;
-		goto found;
-	}
-#endif /* CONFIG_PPC_OF */
-
-	/*
-	 * Check out if we have an X86 which gave us some PLL informations
-	 * and if yes, retreive them
-	 */
-	if (!force_measure_pll && rinfo->bios_seg) {
-		u16 pll_info_block = BIOS_IN16(rinfo->fp_bios_start + 0x30);
-
-		rinfo->pll.sclk		= BIOS_IN16(pll_info_block + 0x08);
-		rinfo->pll.mclk		= BIOS_IN16(pll_info_block + 0x0a);
-		rinfo->pll.ref_clk	= BIOS_IN16(pll_info_block + 0x0e);
-		rinfo->pll.ref_div	= BIOS_IN16(pll_info_block + 0x10);
-		rinfo->pll.ppll_min	= BIOS_IN32(pll_info_block + 0x12);
-		rinfo->pll.ppll_max	= BIOS_IN32(pll_info_block + 0x16);
-
-		printk(KERN_INFO "radeonfb: Retreived PLL infos from BIOS\n");
-		goto found;
-	}
-
-	/*
-	 * We didn't get PLL parameters from either OF or BIOS, we try to
-	 * probe them
-	 */
-	if (radeon_probe_pll_params(rinfo) == 0) {
-		printk(KERN_INFO "radeonfb: Retreived PLL infos from registers\n");
-		/* FIXME: Max clock may be higher on newer chips */
-       		rinfo->pll.ppll_min = 12000;
-       		rinfo->pll.ppll_max = 35000;
-		goto found;
-	}
-
-	/*
-	 * Neither of the above worked, we have a few default values, though
-	 * that's mostly incomplete
+	 * In the case nothing works, these are defaults; they are mostly
+	 * incomplete, however.  It does provide ppll_max and _min values
+	 * even for most other methods, however.
 	 */
 	switch (rinfo->chipset) {
 	case PCI_DEVICE_ID_ATI_RADEON_QW:
@@ -697,6 +653,47 @@
 	}
 	rinfo->pll.ref_div = INPLL(PPLL_REF_DIV) & 0x3ff;
 
+
+#ifdef CONFIG_PPC_OF
+	/*
+	 * Retreive PLL infos from Open Firmware first
+	 */
+       	if (!force_measure_pll && radeon_read_xtal_OF(rinfo) == 0) {
+       		printk(KERN_INFO "radeonfb: Retreived PLL infos from Open Firmware\n");
+		goto found;
+	}
+#endif /* CONFIG_PPC_OF */
+
+	/*
+	 * Check out if we have an X86 which gave us some PLL informations
+	 * and if yes, retreive them
+	 */
+	if (!force_measure_pll && rinfo->bios_seg) {
+		u16 pll_info_block = BIOS_IN16(rinfo->fp_bios_start + 0x30);
+
+		rinfo->pll.sclk		= BIOS_IN16(pll_info_block + 0x08);
+		rinfo->pll.mclk		= BIOS_IN16(pll_info_block + 0x0a);
+		rinfo->pll.ref_clk	= BIOS_IN16(pll_info_block + 0x0e);
+		rinfo->pll.ref_div	= BIOS_IN16(pll_info_block + 0x10);
+		rinfo->pll.ppll_min	= BIOS_IN32(pll_info_block + 0x12);
+		rinfo->pll.ppll_max	= BIOS_IN32(pll_info_block + 0x16);
+
+		printk(KERN_INFO "radeonfb: Retreived PLL infos from BIOS\n");
+		goto found;
+	}
+
+	/*
+	 * We didn't get PLL parameters from either OF or BIOS, we try to
+	 * probe them
+	 */
+	if (radeon_probe_pll_params(rinfo) == 0) {
+		printk(KERN_INFO "radeonfb: Retreived PLL infos from registers\n");
+		goto found;
+	}
+
+	/*
+	 * Fall back to already-set defaults...
+	 */
        	printk(KERN_INFO "radeonfb: Used default PLL infos\n");
 
 found:
@@ -715,6 +712,7 @@
 	       rinfo->pll.ref_div,
 	       rinfo->pll.mclk / 100, rinfo->pll.mclk % 100,
 	       rinfo->pll.sclk / 100, rinfo->pll.sclk % 100);
+	printk("radeonfb: PLL min %d max %d\n", rinfo->pll.ppll_min, rinfo->pll.ppll_max);
 }
 
 static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *info)
@@ -934,43 +932,82 @@
 }
 
 
-static int radeon_screen_blank (struct radeonfb_info *rinfo, int blank)
+static int radeon_screen_blank (struct radeonfb_info *rinfo, int blank, int sync)
 {
-        u32 val = INREG(CRTC_EXT_CNTL);
-	u32 val2 = 0;
+        u32 val;
+	u32 tmp_pix_clks;
 
-	if (rinfo->mon1_type == MT_LCD)
-		val2 = INREG(LVDS_GEN_CNTL) & ~LVDS_DISPLAY_DIS;
-	
-        /* reset it */
+	radeon_engine_idle();
+
+	val = INREG(CRTC_EXT_CNTL);
         val &= ~(CRTC_DISPLAY_DIS | CRTC_HSYNC_DIS |
                  CRTC_VSYNC_DIS);
-
         switch (blank) {
-                case VESA_NO_BLANKING:
-                        break;
-                case VESA_VSYNC_SUSPEND:
-                        val |= (CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS);
-                        break;
-                case VESA_HSYNC_SUSPEND:
-                        val |= (CRTC_DISPLAY_DIS | CRTC_HSYNC_DIS);
-                        break;
-                case VESA_POWERDOWN:
-                        val |= (CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS | 
-                                CRTC_HSYNC_DIS);
-			val2 |= (LVDS_DISPLAY_DIS);
-                        break;
+	case VESA_NO_BLANKING:
+		break;
+	case VESA_VSYNC_SUSPEND:
+		val |= (CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS);
+		break;
+	case VESA_HSYNC_SUSPEND:
+		val |= (CRTC_DISPLAY_DIS | CRTC_HSYNC_DIS);
+		break;
+	case VESA_POWERDOWN:
+		val |= (CRTC_DISPLAY_DIS | CRTC_VSYNC_DIS | 
+			CRTC_HSYNC_DIS);
+		break;
         }
+	OUTREG(CRTC_EXT_CNTL, val);
 
-	radeon_fifo_wait(1);
 	switch (rinfo->mon1_type) {
-		case MT_LCD:
-			OUTREG(LVDS_GEN_CNTL, val2);
-			break;
-		case MT_CRT:
-		default:
-		        OUTREG(CRTC_EXT_CNTL, val);
-			break;
+	case MT_DFP:
+		if (blank == VESA_NO_BLANKING)
+			OUTREGP(FP_GEN_CNTL, (FP_FPON | FP_TMDS_EN), ~(FP_FPON | FP_TMDS_EN));
+		else
+			OUTREGP(FP_GEN_CNTL, 0, ~(FP_FPON | FP_TMDS_EN));
+		break;
+	case MT_LCD:
+		val = INREG(LVDS_GEN_CNTL);
+		if (blank == VESA_NO_BLANKING) {
+			val &= ~LVDS_DISPLAY_DIS;
+			val |= LVDS_BLON | LVDS_EN
+				| (rinfo->init_state.lvds_gen_cntl & LVDS_DIGON);
+			del_timer_sync(&rinfo->lvds_timer);
+			OUTREG(LVDS_GEN_CNTL, val);
+			rinfo->pending_lvds_gen_cntl = val | LVDS_ON;
+			rinfo->init_state.lvds_gen_cntl &= ~LVDS_STATE_MASK;
+			rinfo->init_state.lvds_gen_cntl |= rinfo->pending_lvds_gen_cntl
+				& LVDS_STATE_MASK;
+			if (sync) {
+				msleep(rinfo->panel_info.pwr_delay);
+				OUTREG(LVDS_GEN_CNTL, rinfo->pending_lvds_gen_cntl);
+				
+			}
+			else
+				mod_timer(&rinfo->lvds_timer,
+					  jiffies + MS_TO_HZ(rinfo->panel_info.pwr_delay));
+		} else {
+			tmp_pix_clks = INPLL(PIXCLKS_CNTL);
+
+			if (rinfo->is_mobility || rinfo->is_IGP) {
+				/* Asic bug, when turning off LVDS_ON, we have to make sure
+				 * RADEON_PIXCLK_LVDS_ALWAYS_ON bit is off
+				 */
+				OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
+			}
+			val |= LVDS_DISPLAY_DIS;
+			OUTREG(LVDS_GEN_CNTL, val);			
+			val &= ~(LVDS_BLON | LVDS_ON);
+			OUTREG(LVDS_GEN_CNTL, val);			
+			rinfo->init_state.lvds_gen_cntl &= ~LVDS_STATE_MASK;
+			rinfo->init_state.lvds_gen_cntl |= val & LVDS_STATE_MASK;
+			if (rinfo->is_mobility || rinfo->is_IGP)
+				OUTPLL(PIXCLKS_CNTL, tmp_pix_clks);
+		}
+		break;
+	case MT_CRT:
+		// todo: powerdown DAC
+	default:
+		break;
 	}
 
 	return 0;
@@ -983,17 +1020,7 @@
 	if (rinfo->asleep)
 		return 0;
 		
-#ifdef CONFIG_PMAC_BACKLIGHT
-	if (rinfo->mon1_type == MT_LCD && _machine == _MACH_Pmac && blank)
-		set_backlight_enable(0);
-#endif
-                        
-	radeon_screen_blank(rinfo, blank);
-
-#ifdef CONFIG_PMAC_BACKLIGHT
-	if (rinfo->mon1_type == MT_LCD && _machine == _MACH_Pmac && !blank)
-		set_backlight_enable(1);
-#endif
+	radeon_screen_blank(rinfo, blank, 0);
 
 	return 0;
 }
@@ -1225,7 +1252,8 @@
 
 	del_timer_sync(&rinfo->lvds_timer);
 
-	radeon_screen_blank(rinfo, VESA_POWERDOWN);
+	radeon_screen_blank(rinfo, VESA_POWERDOWN, 1);
+	msleep(100);
 
 	radeon_fifo_wait(31);
 	for (i=0; i<10; i++)
@@ -1265,35 +1293,9 @@
 		OUTREG(FP_GEN_CNTL, mode->fp_gen_cntl);
 		OUTREG(TMDS_CRC, mode->tmds_crc);
 		OUTREG(TMDS_TRANSMITTER_CNTL, mode->tmds_transmitter_cntl);
-
-		if (primary_mon == MT_LCD) {
-			unsigned int tmp = INREG(LVDS_GEN_CNTL);
-
-			/* HACK: The backlight control code may have modified init_state.lvds_gen_cntl,
-			 * so we update ourselves
-			 */
-			mode->lvds_gen_cntl &= ~LVDS_STATE_MASK;
-			mode->lvds_gen_cntl |= (rinfo->init_state.lvds_gen_cntl & LVDS_STATE_MASK);
-
-			if ((tmp & (LVDS_ON | LVDS_BLON)) ==
-			    (mode->lvds_gen_cntl & (LVDS_ON | LVDS_BLON))) {
-				OUTREG(LVDS_GEN_CNTL, mode->lvds_gen_cntl);
-			} else {
-				rinfo->pending_pixclks_cntl = INPLL(PIXCLKS_CNTL);
-				if (rinfo->is_mobility || rinfo->is_IGP)
-					OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
-				if (!(tmp & (LVDS_ON | LVDS_BLON)))
-					OUTREG(LVDS_GEN_CNTL, mode->lvds_gen_cntl | LVDS_BLON);
-				rinfo->pending_lvds_gen_cntl = mode->lvds_gen_cntl;
-				mod_timer(&rinfo->lvds_timer,
-					  jiffies + MS_TO_HZ(rinfo->panel_info.pwr_delay));
-			}
-		}
 	}
 
-	RTRACE("lvds_gen_cntl: %08x\n", INREG(LVDS_GEN_CNTL));
-
-	radeon_screen_blank(rinfo, VESA_NO_BLANKING);
+	radeon_screen_blank(rinfo, VESA_NO_BLANKING, 1);
 
 	radeon_fifo_wait(2);
 	OUTPLL(VCLK_ECP_CNTL, mode->vclk_ecp_cntl);
@@ -1329,7 +1331,7 @@
 	 * not sure which model starts having FP2_GEN_CNTL, I assume anything more
 	 * recent than an r(v)100...
 	 */
-#if 0
+#if 1
 	/* XXX I had reports of flicker happening with the cinema display
 	 * on TMDS1 that seem to be fixed if I also forbit odd dividers in
 	 * this case. This could just be a bandwidth calculation issue, I
@@ -1379,6 +1381,8 @@
 		freq = rinfo->pll.ppll_max;
 	if (freq*12 < rinfo->pll.ppll_min)
 		freq = rinfo->pll.ppll_min / 12;
+	RTRACE("freq = %lu, PLL min = %u, PLL max = %u\n",
+	       freq, rinfo->pll.ppll_min, rinfo->pll.ppll_max);
 
 	for (post_div = &post_divs[0]; post_div->divider; ++post_div) {
 		pll_output_freq = post_div->divider * freq;
@@ -1391,6 +1395,16 @@
 		    pll_output_freq <= rinfo->pll.ppll_max)
 			break;
 	}
+	
+	/* If we fall through the bottom, try the "default value"
+	   given by the terminal post_div->bitvalue */
+	if ( !post_div->divider ) {
+		post_div = &post_divs[post_div->bitvalue];
+		pll_output_freq = post_div->divider * freq;
+	}
+	RTRACE("ref_div = %d, ref_clk = %d, output_freq = %d\n",
+	       rinfo->pll.ref_div, rinfo->pll.ref_clk,
+	       pll_output_freq);
 
 	fb_div = round_div(rinfo->pll.ref_div*pll_output_freq,
 				  rinfo->pll.ref_clk);
@@ -1804,23 +1818,30 @@
 
 	del_timer_sync(&rinfo->lvds_timer);
 
-	lvds_gen_cntl |= (LVDS_BL_MOD_EN | LVDS_BLON);
 	radeon_fifo_wait(3);
 	if (on && (level > BACKLIGHT_OFF)) {
-		lvds_gen_cntl |= LVDS_DIGON;
-		if (!(lvds_gen_cntl & LVDS_ON)) {
-			lvds_gen_cntl &= ~LVDS_BLON;
+		if (!(lvds_gen_cntl & LVDS_BLON)) {
+			lvds_gen_cntl &= ~LVDS_DISPLAY_DIS;
+			lvds_gen_cntl |= LVDS_BLON | LVDS_EN
+				| (rinfo->init_state.lvds_gen_cntl & LVDS_DIGON);
+			del_timer_sync(&rinfo->lvds_timer);
 			OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
-			(void)INREG(LVDS_GEN_CNTL);
-			mdelay(rinfo->panel_info.pwr_delay);/* OUCH !!! FIXME */
-			lvds_gen_cntl |= LVDS_BLON;
+			lvds_gen_cntl &= ~LVDS_BL_MOD_LEVEL_MASK;
+			lvds_gen_cntl |= (conv_table[level] <<
+					  LVDS_BL_MOD_LEVEL_SHIFT);
+			lvds_gen_cntl |= LVDS_ON;
+			rinfo->pending_lvds_gen_cntl = lvds_gen_cntl;
+			mod_timer(&rinfo->lvds_timer,
+				  jiffies + MS_TO_HZ(rinfo->panel_info.pwr_delay));
+		} else {
+			lvds_gen_cntl &= ~LVDS_BL_MOD_LEVEL_MASK;
+			lvds_gen_cntl |= (conv_table[level] <<
+					  LVDS_BL_MOD_LEVEL_SHIFT);
 			OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
 		}
-		lvds_gen_cntl &= ~LVDS_BL_MOD_LEVEL_MASK;
-		lvds_gen_cntl |= (conv_table[level] <<
-				  LVDS_BL_MOD_LEVEL_SHIFT);
-		lvds_gen_cntl |= (LVDS_ON | LVDS_EN);
-		lvds_gen_cntl &= ~LVDS_DISPLAY_DIS;
+		rinfo->init_state.lvds_gen_cntl &= ~LVDS_STATE_MASK;
+		rinfo->init_state.lvds_gen_cntl |= rinfo->pending_lvds_gen_cntl
+			& LVDS_STATE_MASK;
 	} else {
 		/* Asic bug, when turning off LVDS_ON, we have to make sure
 		   RADEON_PIXCLK_LVDS_ALWAYS_ON bit is off
@@ -1830,15 +1851,13 @@
 		lvds_gen_cntl &= ~LVDS_BL_MOD_LEVEL_MASK;
 		lvds_gen_cntl |= (conv_table[0] <<
 				  LVDS_BL_MOD_LEVEL_SHIFT);
-		lvds_gen_cntl |= LVDS_DISPLAY_DIS | LVDS_BLON;
+		lvds_gen_cntl |= LVDS_DISPLAY_DIS;
+		OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
+		lvds_gen_cntl &= ~(LVDS_ON | LVDS_BLON /* | LVDS_EN | LVDS_DIGON*/);
 		OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
-		mdelay(rinfo->panel_info.pwr_delay);/* OUCH !!! FIXME */
-		lvds_gen_cntl &= ~(LVDS_ON | LVDS_EN | LVDS_BLON | LVDS_DIGON);
+		if (rinfo->is_mobility || rinfo->is_IGP)
+			OUTPLL(PIXCLKS_CNTL, tmpPixclksCntl);
 	}
-
-	OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
-	if (rinfo->is_mobility || rinfo->is_IGP)
-		OUTPLL(PIXCLKS_CNTL, tmpPixclksCntl);
 	rinfo->init_state.lvds_gen_cntl &= ~LVDS_STATE_MASK;
 	rinfo->init_state.lvds_gen_cntl |= (lvds_gen_cntl & LVDS_STATE_MASK);
 
diff -urN linux-2.5/drivers/video/aty/radeon_monitor.c linux-lappy/drivers/video/aty/radeon_monitor.c
--- linux-2.5/drivers/video/aty/radeon_monitor.c	2004-10-11 13:51:42.000000000 +1000
+++ linux-lappy/drivers/video/aty/radeon_monitor.c	2004-10-11 11:39:04.000000000 +1000
@@ -632,43 +632,25 @@
  */
 static void radeon_fixup_panel_info(struct radeonfb_info *rinfo)
 {
+ #ifdef CONFIG_PPC_OF
 	/*
-	 * A few iBook laptop panels seem to need a fixed PLL setting
-	 *
-	 * We should probably do this differently based on the panel
-	 * type/model or eventually some other device-tree informations,
-	 * but these tweaks below work enough for now. --BenH
-	 */
-#ifdef CONFIG_PPC_OF
-	/* iBook2's */
-	if (machine_is_compatible("PowerBook4,3")) {
-		rinfo->panel_info.ref_divider = rinfo->pll.ref_div;
-		rinfo->panel_info.post_divider = 0x6;
-		rinfo->panel_info.fbk_divider = 0xad;
-		rinfo->panel_info.use_bios_dividers = 1;
-	}
-	/* Aluminium PowerBook 15" */
-	if (machine_is_compatible("PowerBook5,4")) {
-		rinfo->panel_info.ref_divider = rinfo->pll.ref_div;
-		rinfo->panel_info.post_divider = 0x2;
-		rinfo->panel_info.fbk_divider = 0x8e;
-		rinfo->panel_info.use_bios_dividers = 1;
-	}
-	/* Aluminium PowerBook 17" */
-	if (machine_is_compatible("PowerBook5,3") ||
-	    machine_is_compatible("PowerBook5,5")) {
-		rinfo->panel_info.ref_divider = rinfo->pll.ref_div;
-		rinfo->panel_info.post_divider = 0x4;
-		rinfo->panel_info.fbk_divider = 0x80;
-		rinfo->panel_info.use_bios_dividers = 1;
-	}
-	/* iBook G4 */
-        if (machine_is_compatible("PowerBook6,3") ||
-            machine_is_compatible("PowerBook6,5")) {
+	 * LCD Flat panels should use fixed dividers, we enfore that on
+	 * PowerMac only for now...
+	 */
+	if (!rinfo->panel_info.use_bios_dividers && rinfo->mon1_type == MT_LCD
+	    && rinfo->is_mobility) {
+		int ppll_div_sel = INREG8(CLOCK_CNTL_INDEX + 1) & 0x3;
+		u32 ppll_divn = INPLL(PPLL_DIV_0 + ppll_div_sel);
 		rinfo->panel_info.ref_divider = rinfo->pll.ref_div;
-		rinfo->panel_info.post_divider = 0x6;
-		rinfo->panel_info.fbk_divider = 0xad;
+		rinfo->panel_info.fbk_divider = ppll_divn & 0x7ff;
+		rinfo->panel_info.post_divider = (ppll_divn >> 16) & 0x7;
 		rinfo->panel_info.use_bios_dividers = 1;
+		
+		printk(KERN_DEBUG "radeonfb: Using Firmware dividers 0x%08x "
+		       "from PPLL %d\n",
+		       rinfo->panel_info.fbk_divider | 
+		       (rinfo->panel_info.post_divider << 16),
+		       ppll_div_sel);
 	}
 #endif /* CONFIG_PPC_OF */
 }
diff -urN linux-2.5/drivers/video/aty/radeon_pm.c linux-lappy/drivers/video/aty/radeon_pm.c
--- linux-2.5/drivers/video/aty/radeon_pm.c	2004-10-11 13:51:42.000000000 +1000
+++ linux-lappy/drivers/video/aty/radeon_pm.c	2004-10-11 13:23:58.000000000 +1000
@@ -465,7 +465,9 @@
 						
  	OUTPLL( pllPIXCLKS_CNTL, pixclks_cntl);
 
-
+	/* Switch off LVDS interface */
+	OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) &
+	       ~(LVDS_BLON | LVDS_EN | LVDS_ON | LVDS_DIGON));
 
 	/* Enable System power management */
 	pll_pwrmgt_cntl = INPLL( pllPLL_PWRMGT_CNTL);
diff -urN linux-2.5/include/video/radeon.h linux-lappy/include/video/radeon.h
--- linux-2.5/include/video/radeon.h	2004-10-11 13:51:52.000000000 +1000
+++ linux-lappy/include/video/radeon.h	2004-10-11 13:19:32.000000000 +1000
@@ -619,8 +619,7 @@
 #define LVDS_BLON				   (1 << 19)
 #define LVDS_SEL_CRTC2				   (1 << 23)
 #define LVDS_STATE_MASK	\
-	(LVDS_ON | LVDS_DISPLAY_DIS | LVDS_BL_MOD_LEVEL_MASK | \
-	 LVDS_EN | LVDS_DIGON | LVDS_BLON)
+	(LVDS_ON | LVDS_DISPLAY_DIS | LVDS_BL_MOD_LEVEL_MASK | LVDS_BLON)
 
 /* LVDS_PLL_CNTL bit constatns */
 #define HSYNC_DELAY_SHIFT			   0x1c


