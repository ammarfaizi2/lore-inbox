Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVCHECC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVCHECC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 23:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVCHECC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 23:02:02 -0500
Received: from gate.crashing.org ([63.228.1.57]:41383 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261326AbVCHD7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 22:59:13 -0500
Subject: [PATCH] (#2) radeonfb: PLL access workaround
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Alessandro Suardi <alessandro.suardi@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>
In-Reply-To: <1110243597.13594.224.camel@gaston>
References: <1110243597.13594.224.camel@gaston>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 14:54:53 +1100
Message-Id: <1110254093.13607.244.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-08 at 11:59 +1100, Benjamin Herrenschmidt wrote:
> Hi !
> 
> So you remember all those weird lockups at boot that happened in late
> 2.6.11-rc with radeonfb. I posted a "workaround" which just moved code
> around a bit and it appeared to work. I finally got some real infos
> about the problem from ATI, and it seems my "workaround" is not very
> safe and there are other potential issues realted to HW bugs when
> accessing the PLL registers.
> 
> This patch implements all of these workarounds (and puts back the code
> where it was before my previous fix). 
> 
> Please test and let me know if it works. If it's fine, then it should go
> to -mm, and eventually after a while, to a 2.6.11.x update.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Here's a new one adding a missing bit..

Index: linux-work/drivers/video/aty/radeonfb.h
===================================================================
--- linux-work.orig/drivers/video/aty/radeonfb.h	2005-03-08 11:30:37.000000000 +1100
+++ linux-work/drivers/video/aty/radeonfb.h	2005-03-08 14:49:24.000000000 +1100
@@ -22,11 +22,6 @@
 
 #include <video/radeon.h>
 
-/* Some weird black magic use by Apple driver that we don't use for
- * now --BenH
- */
-#undef HAS_PLL_M9_GPIO_MAGIC
-
 /***************************************************************
  * Most of the definitions here are adapted right from XFree86 *
  ***************************************************************/
@@ -312,7 +307,6 @@
 	int			is_mobility;
 	int			is_IGP;
 	int			R300_cg_workaround;
-	int			m9p_workaround;
 	int			reversed_DAC;
 	int			reversed_TMDS;
 	struct panel_info	panel_info;
@@ -397,6 +391,11 @@
 
 #define OUTREGP(addr,val,mask)	_OUTREGP(rinfo, addr, val,mask)
 
+/* This function is required to workaround a hardware bug in some (all?)
+ * revisions of the R300.  This workaround should be called after every
+ * CLOCK_CNTL_INDEX register access.  If not, register reads afterward
+ * may not be correct.
+ */
 static inline void R300_cg_workardound(struct radeonfb_info *rinfo)
 {
 	u32 save, tmp;
@@ -407,35 +406,36 @@
 	OUTREG(CLOCK_CNTL_INDEX, save);
 }
 
+/*
+ * PLL accesses suffer from various HW issues on the different chip
+ * families. Some R300's need the above workaround, rv200 & friends
+ * need a couple of dummy reads after any write of CLOCK_CNTL_INDEX,
+ * and some RS100/200 need a dummy read before writing to
+ * CLOCK_CNTL_INDEX as well. Instead of testing every chip revision,
+ * we just unconditionally do  the workarounds at once since PLL
+ * accesses are far from beeing performance critical. Except for R300
+ * one which stays separate for now
+ */
+
+static inline void radeon_pll_workaround_before(struct radeonfb_info *rinfo)
+{
+	(void)INREG(CRTC_GEN_CNTL);	
+}
+
+static inline void radeon_pll_workaround_after(struct radeonfb_info *rinfo)
+{
+	(void)INREG(CLOCK_CNTL_DATA); 
+	(void)INREG(CRTC_GEN_CNTL); 
+}
 
 static inline u32 __INPLL(struct radeonfb_info *rinfo, u32 addr)
 {
 	u32 data;
-#ifdef HAS_PLL_M9_GPIO_MAGIC
-	u32 sv[3];
-
-	if (rinfo->m9p_workaround) {
-		sv[0] = INREG(0x19c);
-		sv[1] = INREG(0x1a0);
-		sv[2] = INREG(0x198);
-		OUTREG(0x198, 0);
-		OUTREG(0x1a0, 0);
-		OUTREG(0x19c, 0);
-	}
-#endif /* HAS_PLL_M9_GPIO_MAGIC */
 
+	radeon_pll_workaround_before(rinfo);
 	OUTREG8(CLOCK_CNTL_INDEX, addr & 0x0000003f);
-	data = (INREG(CLOCK_CNTL_DATA));
-
-#ifdef HAS_PLL_M9_GPIO_MAGIC
-	if (rinfo->m9p_workaround) {
-		(void)INREG(CRTC_GEN_CNTL);
-		data = INREG(CLOCK_CNTL_DATA);
-		OUTREG(0x19c, sv[0]);
-		OUTREG(0x1a0, sv[1]);
-		OUTREG(0x198, sv[2]);
-	}
-#endif /* HAS_PLL_M9_GPIO_MAGIC */
+	radeon_pll_workaround_after(rinfo);
+	data = INREG(CLOCK_CNTL_DATA);
 	if (rinfo->R300_cg_workaround)
 		R300_cg_workardound(rinfo);
 	return data;
@@ -455,32 +455,16 @@
 #define INPLL(addr)		_INPLL(rinfo, addr)
 
 
-static inline void __OUTPLL(struct radeonfb_info *rinfo, unsigned int index, u32 val)
+static inline void __OUTPLL(struct radeonfb_info *rinfo, unsigned int index,
+			    u32 val)
 {
-#ifdef HAS_PLL_M9_GPIO_MAGIC
-	u32 sv[3];
-
-	if (rinfo->m9p_workaround) {
-		sv[0] = INREG(0x19c);
-		sv[1] = INREG(0x1a0);
-		sv[2] = INREG(0x198);
-		OUTREG(0x198, 0);
-		OUTREG(0x1a0, 0);
-		OUTREG(0x19c, 0);
-		mdelay(1);
-	}
-#endif /* HAS_PLL_M9_GPIO_MAGIC */
 
+	radeon_pll_workaround_before(rinfo);
 	OUTREG8(CLOCK_CNTL_INDEX, (index & 0x0000003f) | 0x00000080);
+	radeon_pll_workaround_after(rinfo);
 	OUTREG(CLOCK_CNTL_DATA, val);
-
-#ifdef HAS_PLL_M9_GPIO_MAGIC
-	if (rinfo->m9p_workaround) {
-		OUTREG(0x19c, sv[0]);
-		OUTREG(0x1a0, sv[1]);
-		OUTREG(0x198, sv[2]);
-	}
-#endif /* HAS_PLL_M9_GPIO_MAGIC */
+	if (rinfo->R300_cg_workaround)
+		R300_cg_workardound(rinfo);
 }
 
 static inline void _OUTPLL(struct radeonfb_info *rinfo, unsigned int index, u32 val)
Index: linux-work/drivers/video/aty/radeon_base.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_base.c	2005-03-08 11:30:37.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_base.c	2005-03-08 14:49:24.000000000 +1100
@@ -530,7 +530,11 @@
         break;
 	}
 
+	radeon_pll_workaround_before(rinfo);
 	ppll_div_sel = INREG8(CLOCK_CNTL_INDEX + 1) & 0x3;
+	radeon_pll_workaround_after(rinfo);
+	if (rinfo->R300_cg_workaround)
+		R300_cg_workardound(rinfo);
 
 	n = (INPLL(PPLL_DIV_0 + ppll_div_sel) & 0x7ff);
 	m = (INPLL(PPLL_REF_DIV) & 0x3ff);
@@ -1168,7 +1172,11 @@
 	save->vclk_ecp_cntl = INPLL(VCLK_ECP_CNTL);
 
 	/* PLL regs */
+	radeon_pll_workaround_before(rinfo);
 	save->clk_cntl_index = INREG(CLOCK_CNTL_INDEX) & ~0x3f;
+	radeon_pll_workaround_after(rinfo);
+	if (rinfo->R300_cg_workaround)
+		R300_cg_workardound(rinfo);
 	save->ppll_div_3 = INPLL(PPLL_DIV_3);
 	save->ppll_ref_div = INPLL(PPLL_REF_DIV);
 }
@@ -1195,9 +1203,13 @@
 			/* We still have to force a switch to selected PPLL div thanks to
 			 * an XFree86 driver bug which will switch it away in some cases
 			 * even when using UseFDev */
+			radeon_pll_workaround_before(rinfo);
 			OUTREGP(CLOCK_CNTL_INDEX,
 				mode->clk_cntl_index & PPLL_DIV_SEL_MASK,
 				~PPLL_DIV_SEL_MASK);
+			radeon_pll_workaround_after(rinfo);
+			if (rinfo->R300_cg_workaround)
+				R300_cg_workardound(rinfo);
             		return;
 		}
 	}
@@ -1211,9 +1223,13 @@
 		~(PPLL_RESET | PPLL_ATOMIC_UPDATE_EN | PPLL_VGA_ATOMIC_UPDATE_EN));
 
 	/* Switch to selected PPLL divider */
+	radeon_pll_workaround_before(rinfo);
 	OUTREGP(CLOCK_CNTL_INDEX,
 		mode->clk_cntl_index & PPLL_DIV_SEL_MASK,
 		~PPLL_DIV_SEL_MASK);
+	radeon_pll_workaround_after(rinfo);
+	if (rinfo->R300_cg_workaround)
+		R300_cg_workardound(rinfo);
 
 	/* Set PPLL ref. div */
 	if (rinfo->family == CHIP_FAMILY_R300 ||
@@ -2359,6 +2375,15 @@
 	radeon_save_state (rinfo, &rinfo->init_state);
 	memcpy(&rinfo->state, &rinfo->init_state, sizeof(struct radeon_regs));
 
+	/* Setup Power Management capabilities */
+	if (default_dynclk < -1) {
+		/* -2 is special: means  ON on mobility chips and do not
+		 * change on others
+		 */
+		radeonfb_pm_init(rinfo, rinfo->is_mobility ? 1 : -1);
+	} else
+		radeonfb_pm_init(rinfo, default_dynclk);
+
 	pci_set_drvdata(pdev, info);
 
 	/* Register with fbdev layer */
@@ -2369,13 +2394,6 @@
 		goto err_unmap_fb;
 	}
 
-	/* Setup Power Management capabilities */
-	if (default_dynclk < -1) {
-		/* -2 is special: means  ON on mobility chips and do not change on others */
-		radeonfb_pm_init(rinfo, rinfo->is_mobility ? 1 : -1);
-	} else
-		radeonfb_pm_init(rinfo, default_dynclk);
-
 #ifdef CONFIG_MTRR
 	rinfo->mtrr_hdl = nomtrr ? -1 : mtrr_add(rinfo->fb_base_phys,
 						 rinfo->video_ram,
Index: linux-work/drivers/video/aty/radeon_pm.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_pm.c	2005-03-04 17:22:13.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_pm.c	2005-03-08 11:47:11.000000000 +1100
@@ -1372,8 +1372,12 @@
 
 	/* Reconfigure SPLL charge pump, VCO gain, duty cycle */
 	tmp = INPLL(pllSPLL_CNTL);
+	radeon_pll_workaround_before(rinfo);
 	OUTREG8(CLOCK_CNTL_INDEX, pllSPLL_CNTL + PLL_WR_EN);
+	radeon_pll_workaround_after(rinfo);
 	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
+	if (rinfo->R300_cg_workaround)
+		R300_cg_workardound(rinfo);
 
 	/* Set SPLL feedback divider */
 	tmp = INPLL(pllM_SPLL_REF_FB_DIV);
@@ -1405,8 +1409,12 @@
 
 	/* Reconfigure MPLL charge pump, VCO gain, duty cycle */
 	tmp = INPLL(pllMPLL_CNTL);
+	radeon_pll_workaround_before(rinfo);
 	OUTREG8(CLOCK_CNTL_INDEX, pllMPLL_CNTL + PLL_WR_EN);
+	radeon_pll_workaround_after(rinfo);
 	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
+	if (rinfo->R300_cg_workaround)
+		R300_cg_workardound(rinfo);
 
 	/* Set MPLL feedback divider */
 	tmp = INPLL(pllM_SPLL_REF_FB_DIV);
@@ -1524,8 +1532,12 @@
 {
 	u32 tmp;
 
+	radeon_pll_workaround_before(rinfo);
 	OUTREG8(CLOCK_CNTL_INDEX, pllHTOTAL_CNTL + PLL_WR_EN);
+	radeon_pll_workaround_after(rinfo);
 	OUTREG8(CLOCK_CNTL_DATA, 0);
+	if (rinfo->R300_cg_workaround)
+		R300_cg_workardound(rinfo);
 
 	tmp = INPLL(pllVCLK_ECP_CNTL);
 	OUTPLL(pllVCLK_ECP_CNTL, tmp | 0x80);
@@ -1540,12 +1552,12 @@
 	 * probably useless since we already did it ...
 	 */
 	tmp = INPLL(pllPPLL_CNTL);
+	radeon_pll_workaround_before(rinfo);
 	OUTREG8(CLOCK_CNTL_INDEX, pllSPLL_CNTL + PLL_WR_EN);
+	radeon_pll_workaround_after(rinfo);
 	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
-
-	/* Not sure what was intended here ... */
-	tmp = INREG(CLOCK_CNTL_INDEX);
-	OUTREG(CLOCK_CNTL_INDEX, tmp);
+	if (rinfo->R300_cg_workaround)
+		R300_cg_workardound(rinfo);
 
 	/* Restore our "reference" PPLL divider set by firmware
 	 * according to proper spread spectrum calculations
@@ -1569,7 +1581,11 @@
 	mdelay(5);
 
 	/* Switch pixel clock to firmware default div 0 */
+	radeon_pll_workaround_before(rinfo);
 	OUTREG8(CLOCK_CNTL_INDEX+1, 0);
+	radeon_pll_workaround_after(rinfo);
+	if (rinfo->R300_cg_workaround)
+		R300_cg_workardound(rinfo);
 }
 
 static void radeon_pm_m10_reconfigure_mc(struct radeonfb_info *rinfo)
@@ -2752,8 +2768,6 @@
 		if (!strcmp(rinfo->of_node->name, "ATY,ViaParent")) {
 			rinfo->reinit_func = radeon_reinitialize_M9P;
 			rinfo->pm_mode |= radeon_pm_off;
-			/* Workaround not used for now */
-			rinfo->m9p_workaround = 1;
 		}
 
 		/* If any of the above is set, we assume the machine can sleep/resume.
Index: linux-work/drivers/video/aty/radeon_monitor.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_monitor.c	2005-03-05 16:04:38.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_monitor.c	2005-03-08 14:50:43.000000000 +1100
@@ -655,8 +655,14 @@
 	 */
 	if (!rinfo->panel_info.use_bios_dividers && rinfo->mon1_type == MT_LCD
 	    && rinfo->is_mobility) {
-		int ppll_div_sel = INREG8(CLOCK_CNTL_INDEX + 1) & 0x3;
-		u32 ppll_divn = INPLL(PPLL_DIV_0 + ppll_div_sel);
+		int ppll_div_sel;
+		u32 ppll_divn;
+		radeon_pll_workaround_before(rinfo);
+		ppll_div_sel = INREG8(CLOCK_CNTL_INDEX + 1) & 0x3;
+		radeon_pll_workaround_after(rinfo);
+		if (rinfo->R300_cg_workaround)
+			R300_cg_workardound(rinfo);
+		ppll_divn = INPLL(PPLL_DIV_0 + ppll_div_sel);
 		rinfo->panel_info.ref_divider = rinfo->pll.ref_div;
 		rinfo->panel_info.fbk_divider = ppll_divn & 0x7ff;
 		rinfo->panel_info.post_divider = (ppll_divn >> 16) & 0x7;


