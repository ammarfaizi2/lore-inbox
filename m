Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263220AbVCKFut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbVCKFut (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 00:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263224AbVCKFuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 00:50:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:986 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263220AbVCKFml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 00:42:41 -0500
Subject: [PATCH] radeonfb: Implement proper workarounds for PLL accesses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 16:42:23 +1100
Message-Id: <1110519743.5810.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

After discussion with ATIs, it seems that the workarounds they initially
gave me were not completely correct.

This patch implements the proper ones, which includes sleeping in PLL
accesses, and thus requires the previous patch to make sure we do not
call unblank at interrupt time (unless oops_in_progress is set, in which
case I use an mdelay).

It also removes obsolete code that used to disable some power management
features in the accel init code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/aty/radeonfb.h
===================================================================
--- linux-work.orig/drivers/video/aty/radeonfb.h	2005-03-11 15:05:34.000000000 +1100
+++ linux-work/drivers/video/aty/radeonfb.h	2005-03-11 15:42:19.000000000 +1100
@@ -77,6 +77,15 @@
 	CHIP_HAS_CRTC2		= 0x00040000UL,	
 };
 
+/*
+ * Errata workarounds
+ */
+enum radeon_errata {
+	CHIP_ERRATA_R300_CG		= 0x00000001,
+	CHIP_ERRATA_PLL_DUMMYREADS	= 0x00000002,
+	CHIP_ERRATA_PLL_DELAY		= 0x00000004,
+};
+
 
 /*
  * Monitor types
@@ -295,6 +304,7 @@
 	int			chipset;
 	u8			family;
 	u8			rev;
+	unsigned int		errata;
 	unsigned long		video_ram;
 	unsigned long		mapped_vram;
 	int			vram_width;
@@ -305,7 +315,6 @@
 	int			has_CRTC2;
 	int			is_mobility;
 	int			is_IGP;
-	int			R300_cg_workaround;
 	int			reversed_DAC;
 	int			reversed_TMDS;
 	struct panel_info	panel_info;
@@ -369,6 +378,21 @@
  * IO macros
  */
 
+/* Note about this function: we have some rare cases where we must not schedule,
+ * this typically happen with our special "wake up early" hook which allows us to
+ * wake up the graphic chip (and thus get the console back) before everything else
+ * on some machines that support that mecanism. At this point, interrupts are off
+ * and scheduling is not permitted
+ */
+static inline void _radeon_msleep(struct radeonfb_info *rinfo, unsigned long ms)
+{
+	if (rinfo->no_schedule || oops_in_progress)
+		mdelay(ms);
+	else
+		msleep(ms);
+}
+
+
 #define INREG8(addr)		readb((rinfo->mmio_base)+addr)
 #define OUTREG8(addr,val)	writeb(val, (rinfo->mmio_base)+addr)
 #define INREG(addr)		readl((rinfo->mmio_base)+addr)
@@ -390,107 +414,85 @@
 
 #define OUTREGP(addr,val,mask)	_OUTREGP(rinfo, addr, val,mask)
 
-/* This function is required to workaround a hardware bug in some (all?)
- * revisions of the R300.  This workaround should be called after every
- * CLOCK_CNTL_INDEX register access.  If not, register reads afterward
- * may not be correct.
- */
-static inline void R300_cg_workardound(struct radeonfb_info *rinfo)
-{
-	u32 save, tmp;
-	save = INREG(CLOCK_CNTL_INDEX);
-	tmp = save & ~(0x3f | PLL_WR_EN);
-	OUTREG(CLOCK_CNTL_INDEX, tmp);
-	tmp = INREG(CLOCK_CNTL_DATA);
-	OUTREG(CLOCK_CNTL_INDEX, save);
-}
-
 /*
- * PLL accesses suffer from various HW issues on the different chip
- * families. Some R300's need the above workaround, rv200 & friends
- * need a couple of dummy reads after any write of CLOCK_CNTL_INDEX,
- * and some RS100/200 need a dummy read before writing to
- * CLOCK_CNTL_INDEX as well. Instead of testing every chip revision,
- * we just unconditionally do  the workarounds at once since PLL
- * accesses are far from beeing performance critical. Except for R300
- * one which stays separate for now
+ * Note about PLL register accesses:
+ *
+ * I have removed the spinlock on them on purpose. The driver now
+ * expects that it will only manipulate the PLL registers in normal
+ * task environment, where radeon_msleep() will be called, protected
+ * by a semaphore (currently the console semaphore) so that no conflict
+ * will happen on the PLL register index.
+ *
+ * With the latest changes to the VT layer, this is guaranteed for all
+ * calls except the actual drawing/blits which aren't supposed to use
+ * the PLL registers anyway
+ *
+ * This is very important for the workarounds to work properly. The only
+ * possible exception to this rule is the call to unblank(), which may
+ * be done at irq time if an oops is in progress.
  */
-
-static inline void radeon_pll_workaround_before(struct radeonfb_info *rinfo)
+static inline void radeon_pll_errata_after_index(struct radeonfb_info *rinfo)
 {
+	if (!(rinfo->errata & CHIP_ERRATA_PLL_DUMMYREADS))
+		return;
+
+	(void)INREG(CLOCK_CNTL_DATA);
 	(void)INREG(CRTC_GEN_CNTL);
 }
 
-static inline void radeon_pll_workaround_after(struct radeonfb_info *rinfo)
+static inline void radeon_pll_errata_after_data(struct radeonfb_info *rinfo)
 {
-	(void)INREG(CLOCK_CNTL_DATA);
-	(void)INREG(CRTC_GEN_CNTL);
+	if (rinfo->errata & CHIP_ERRATA_PLL_DELAY) {
+		/* we can't deal with posted writes here ... */
+		_radeon_msleep(rinfo, 5);
+	}
+	if (rinfo->errata & CHIP_ERRATA_R300_CG) {
+		u32 save, tmp;
+		save = INREG(CLOCK_CNTL_INDEX);
+		tmp = save & ~(0x3f | PLL_WR_EN);
+		OUTREG(CLOCK_CNTL_INDEX, tmp);
+		tmp = INREG(CLOCK_CNTL_DATA);
+		OUTREG(CLOCK_CNTL_INDEX, save);
+	}
 }
 
 static inline u32 __INPLL(struct radeonfb_info *rinfo, u32 addr)
 {
 	u32 data;
 
-	radeon_pll_workaround_before(rinfo);
 	OUTREG8(CLOCK_CNTL_INDEX, addr & 0x0000003f);
-	radeon_pll_workaround_after(rinfo);
+	radeon_pll_errata_after_index(rinfo);
 	data = INREG(CLOCK_CNTL_DATA);
-	if (rinfo->R300_cg_workaround)
-		R300_cg_workardound(rinfo);
+	radeon_pll_errata_after_data(rinfo);
 	return data;
 }
 
-static inline u32 _INPLL(struct radeonfb_info *rinfo, u32 addr)
-{
-       	unsigned long flags;
-	u32 data;
-
-	spin_lock_irqsave(&rinfo->reg_lock, flags);
-	data = __INPLL(rinfo, addr);
-	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
-	return data;
-}
-
-#define INPLL(addr)		_INPLL(rinfo, addr)
-
-
 static inline void __OUTPLL(struct radeonfb_info *rinfo, unsigned int index,
 			    u32 val)
 {
 
-	radeon_pll_workaround_before(rinfo);
 	OUTREG8(CLOCK_CNTL_INDEX, (index & 0x0000003f) | 0x00000080);
-	radeon_pll_workaround_after(rinfo);
+	radeon_pll_errata_after_index(rinfo);
 	OUTREG(CLOCK_CNTL_DATA, val);
-	if (rinfo->R300_cg_workaround)
-		R300_cg_workardound(rinfo);
+	radeon_pll_errata_after_data(rinfo);
 }
 
-static inline void _OUTPLL(struct radeonfb_info *rinfo, unsigned int index, u32 val)
-{
-       	unsigned long flags;
-	spin_lock_irqsave(&rinfo->reg_lock, flags);
-	__OUTPLL(rinfo, index, val);
-	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
-}
 
-static inline void _OUTPLLP(struct radeonfb_info *rinfo, unsigned int index,
-			    u32 val, u32 mask)
+static inline void __OUTPLLP(struct radeonfb_info *rinfo, unsigned int index,
+			     u32 val, u32 mask)
 {
-	unsigned long flags;
 	unsigned int tmp;
 
-	spin_lock_irqsave(&rinfo->reg_lock, flags);
 	tmp  = __INPLL(rinfo, index);
 	tmp &= (mask);
 	tmp |= (val);
 	__OUTPLL(rinfo, index, tmp);
-	spin_unlock_irqrestore(&rinfo->reg_lock, flags);
 }
 
 
-#define OUTPLL(index, val)		_OUTPLL(rinfo, index, val)
-#define OUTPLLP(index, val, mask)	_OUTPLLP(rinfo, index, val, mask)
+#define INPLL(addr)			__INPLL(rinfo, addr)
+#define OUTPLL(index, val)		__OUTPLL(rinfo, index, val)
+#define OUTPLLP(index, val, mask)	__OUTPLLP(rinfo, index, val, mask)
 
 
 #define BIOS_IN8(v)  	(readb(rinfo->bios_seg + (v)))
@@ -582,20 +584,6 @@
 	printk(KERN_ERR "radeonfb: Idle Timeout !\n");
 }
 
-/* Note about this function: we have some rare cases where we must not schedule,
- * this typically happen with our special "wake up early" hook which allows us to
- * wake up the graphic chip (and thus get the console back) before everything else
- * on some machines that support that mecanism. At this point, interrupts are off
- * and scheduling is not permitted
- */
-static inline void _radeon_msleep(struct radeonfb_info *rinfo, unsigned long ms)
-{
-	if (rinfo->no_schedule)
-		mdelay(ms);
-	else
-		msleep(ms);
-}
-
 
 #define radeon_engine_idle()		_radeon_engine_idle(rinfo)
 #define radeon_fifo_wait(entries)	_radeon_fifo_wait(rinfo,entries)
Index: linux-work/drivers/video/aty/radeon_monitor.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_monitor.c	2005-03-11 15:05:34.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_monitor.c	2005-03-11 15:19:02.000000000 +1100
@@ -657,11 +657,8 @@
 	    && rinfo->is_mobility) {
 		int ppll_div_sel;
 		u32 ppll_divn;
-		radeon_pll_workaround_before(rinfo);
 		ppll_div_sel = INREG8(CLOCK_CNTL_INDEX + 1) & 0x3;
-		radeon_pll_workaround_after(rinfo);
-		if (rinfo->R300_cg_workaround)
-			R300_cg_workardound(rinfo);
+		radeon_pll_errata_after_index(rinfo);
 		ppll_divn = INPLL(PPLL_DIV_0 + ppll_div_sel);
 		rinfo->panel_info.ref_divider = rinfo->pll.ref_div;
 		rinfo->panel_info.fbk_divider = ppll_divn & 0x7ff;
Index: linux-work/drivers/video/aty/radeon_base.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_base.c	2005-03-11 15:05:34.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_base.c	2005-03-11 15:37:44.000000000 +1100
@@ -1,4 +1,3 @@
-
 /*
  *	drivers/video/aty/radeon_base.c
  *
@@ -530,11 +529,8 @@
         break;
 	}
 
-	radeon_pll_workaround_before(rinfo);
 	ppll_div_sel = INREG8(CLOCK_CNTL_INDEX + 1) & 0x3;
-	radeon_pll_workaround_after(rinfo);
-	if (rinfo->R300_cg_workaround)
-		R300_cg_workardound(rinfo);
+	radeon_pll_errata_after_index(rinfo);
 
 	n = (INPLL(PPLL_DIV_0 + ppll_div_sel) & 0x7ff);
 	m = (INPLL(PPLL_REF_DIV) & 0x3ff);
@@ -1173,11 +1169,8 @@
 	save->vclk_ecp_cntl = INPLL(VCLK_ECP_CNTL);
 
 	/* PLL regs */
-	radeon_pll_workaround_before(rinfo);
 	save->clk_cntl_index = INREG(CLOCK_CNTL_INDEX) & ~0x3f;
-	radeon_pll_workaround_after(rinfo);
-	if (rinfo->R300_cg_workaround)
-		R300_cg_workardound(rinfo);
+	radeon_pll_errata_after_index(rinfo);
 	save->ppll_div_3 = INPLL(PPLL_DIV_3);
 	save->ppll_ref_div = INPLL(PPLL_REF_DIV);
 }
@@ -1204,13 +1197,11 @@
 			/* We still have to force a switch to selected PPLL div thanks to
 			 * an XFree86 driver bug which will switch it away in some cases
 			 * even when using UseFDev */
-			radeon_pll_workaround_before(rinfo);
 			OUTREGP(CLOCK_CNTL_INDEX,
 				mode->clk_cntl_index & PPLL_DIV_SEL_MASK,
 				~PPLL_DIV_SEL_MASK);
-			radeon_pll_workaround_after(rinfo);
-			if (rinfo->R300_cg_workaround)
-				R300_cg_workardound(rinfo);
+			radeon_pll_errata_after_index(rinfo);
+			radeon_pll_errata_after_data(rinfo);
             		return;
 		}
 	}
@@ -1224,13 +1215,11 @@
 		~(PPLL_RESET | PPLL_ATOMIC_UPDATE_EN | PPLL_VGA_ATOMIC_UPDATE_EN));
 
 	/* Switch to selected PPLL divider */
-	radeon_pll_workaround_before(rinfo);
 	OUTREGP(CLOCK_CNTL_INDEX,
 		mode->clk_cntl_index & PPLL_DIV_SEL_MASK,
 		~PPLL_DIV_SEL_MASK);
-	radeon_pll_workaround_after(rinfo);
-	if (rinfo->R300_cg_workaround)
-		R300_cg_workardound(rinfo);
+	radeon_pll_errata_after_index(rinfo);
+	radeon_pll_errata_after_data(rinfo);
 
 	/* Set PPLL ref. div */
 	if (rinfo->family == CHIP_FAMILY_R300 ||
@@ -2248,11 +2237,29 @@
 	rinfo->has_CRTC2 = (ent->driver_data & CHIP_HAS_CRTC2) != 0;
 	rinfo->is_mobility = (ent->driver_data & CHIP_IS_MOBILITY) != 0;
 	rinfo->is_IGP = (ent->driver_data & CHIP_IS_IGP) != 0;
-		
+	
 	/* Set base addrs */
 	rinfo->fb_base_phys = pci_resource_start (pdev, 0);
 	rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
 
+	/*
+	 * Check for errata
+	 */
+	rinfo->errata = 0;
+	if (rinfo->family == CHIP_FAMILY_R300 &&
+	    (INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK)
+	    == CFG_ATI_REV_A11)
+		rinfo->errata |= CHIP_ERRATA_R300_CG;
+
+	if (rinfo->family == CHIP_FAMILY_RV200 ||
+	    rinfo->family == CHIP_FAMILY_RS200)
+		rinfo->errata |= CHIP_ERRATA_PLL_DUMMYREADS;
+
+	if (rinfo->family == CHIP_FAMILY_RV100 ||
+	    rinfo->family == CHIP_FAMILY_RS100 ||
+	    rinfo->family == CHIP_FAMILY_RS200)
+		rinfo->errata |= CHIP_ERRATA_PLL_DELAY;
+
 	/* request the mem regions */
 	ret = pci_request_regions(pdev, "radeonfb");
 	if (ret < 0) {
@@ -2310,13 +2317,6 @@
 	       rinfo->mapped_vram/1024);
 
 	/*
-	 * Check for required workaround for PLL accesses
-	 */
-	rinfo->R300_cg_workaround = (rinfo->family == CHIP_FAMILY_R300 &&
-				     (INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK)
-				     == CFG_ATI_REV_A11);
-
-	/*
 	 * Map the BIOS ROM if any and retreive PLL parameters from
 	 * the BIOS. We skip that on mobility chips as the real panel
 	 * values we need aren't in the ROM but in the BIOS image in
Index: linux-work/drivers/video/aty/radeon_pm.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_pm.c	2005-03-11 15:05:34.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_pm.c	2005-03-11 15:19:02.000000000 +1100
@@ -1372,12 +1372,10 @@
 
 	/* Reconfigure SPLL charge pump, VCO gain, duty cycle */
 	tmp = INPLL(pllSPLL_CNTL);
-	radeon_pll_workaround_before(rinfo);
 	OUTREG8(CLOCK_CNTL_INDEX, pllSPLL_CNTL + PLL_WR_EN);
-	radeon_pll_workaround_after(rinfo);
+	radeon_pll_errata_after_index(rinfo);
 	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
-	if (rinfo->R300_cg_workaround)
-		R300_cg_workardound(rinfo);
+	radeon_pll_errata_after_data(rinfo);
 
 	/* Set SPLL feedback divider */
 	tmp = INPLL(pllM_SPLL_REF_FB_DIV);
@@ -1409,12 +1407,10 @@
 
 	/* Reconfigure MPLL charge pump, VCO gain, duty cycle */
 	tmp = INPLL(pllMPLL_CNTL);
-	radeon_pll_workaround_before(rinfo);
 	OUTREG8(CLOCK_CNTL_INDEX, pllMPLL_CNTL + PLL_WR_EN);
-	radeon_pll_workaround_after(rinfo);
+	radeon_pll_errata_after_index(rinfo);
 	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
-	if (rinfo->R300_cg_workaround)
-		R300_cg_workardound(rinfo);
+	radeon_pll_errata_after_data(rinfo);
 
 	/* Set MPLL feedback divider */
 	tmp = INPLL(pllM_SPLL_REF_FB_DIV);
@@ -1532,12 +1528,10 @@
 {
 	u32 tmp;
 
-	radeon_pll_workaround_before(rinfo);
 	OUTREG8(CLOCK_CNTL_INDEX, pllHTOTAL_CNTL + PLL_WR_EN);
-	radeon_pll_workaround_after(rinfo);
+	radeon_pll_errata_after_index(rinfo);
 	OUTREG8(CLOCK_CNTL_DATA, 0);
-	if (rinfo->R300_cg_workaround)
-		R300_cg_workardound(rinfo);
+	radeon_pll_errata_after_data(rinfo);
 
 	tmp = INPLL(pllVCLK_ECP_CNTL);
 	OUTPLL(pllVCLK_ECP_CNTL, tmp | 0x80);
@@ -1552,12 +1546,10 @@
 	 * probably useless since we already did it ...
 	 */
 	tmp = INPLL(pllPPLL_CNTL);
-	radeon_pll_workaround_before(rinfo);
 	OUTREG8(CLOCK_CNTL_INDEX, pllSPLL_CNTL + PLL_WR_EN);
-	radeon_pll_workaround_after(rinfo);
+	radeon_pll_errata_after_index(rinfo);
 	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
-	if (rinfo->R300_cg_workaround)
-		R300_cg_workardound(rinfo);
+	radeon_pll_errata_after_data(rinfo);
 
 	/* Restore our "reference" PPLL divider set by firmware
 	 * according to proper spread spectrum calculations
@@ -1581,11 +1573,9 @@
 	mdelay(5);
 
 	/* Switch pixel clock to firmware default div 0 */
-	radeon_pll_workaround_before(rinfo);
 	OUTREG8(CLOCK_CNTL_INDEX+1, 0);
-	radeon_pll_workaround_after(rinfo);
-	if (rinfo->R300_cg_workaround)
-		R300_cg_workardound(rinfo);
+	radeon_pll_errata_after_index(rinfo);
+	radeon_pll_errata_after_data(rinfo);
 }
 
 static void radeon_pm_m10_reconfigure_mc(struct radeonfb_info *rinfo)
@@ -2173,7 +2163,9 @@
 
 	tmp = INPLL(MPLL_CNTL);
 	OUTREG8(CLOCK_CNTL_INDEX, MPLL_CNTL + PLL_WR_EN);
+	radeon_pll_errata_after_index(rinfo);
 	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
+	radeon_pll_errata_after_data(rinfo);
 
 	tmp = INPLL(M_SPLL_REF_FB_DIV);
 	OUTPLL(M_SPLL_REF_FB_DIV, tmp | 0x5900);
@@ -2194,7 +2186,9 @@
 
 	tmp = INPLL(SPLL_CNTL);
 	OUTREG8(CLOCK_CNTL_INDEX, SPLL_CNTL + PLL_WR_EN);
+	radeon_pll_errata_after_index(rinfo);
 	OUTREG8(CLOCK_CNTL_DATA + 1, (tmp >> 8) & 0xff);
+	radeon_pll_errata_after_data(rinfo);
 
 	tmp = INPLL(M_SPLL_REF_FB_DIV);
 	OUTPLL(M_SPLL_REF_FB_DIV, tmp | 0x780000);
@@ -2322,7 +2316,9 @@
 	OUTREG(CRTC_H_SYNC_STRT_WID, 0x008e0580);
 	OUTREG(CRTC_H_TOTAL_DISP, 0x009f00d2);
 	OUTREG8(CLOCK_CNTL_INDEX, HTOTAL_CNTL + PLL_WR_EN);
+	radeon_pll_errata_after_index(rinfo);
 	OUTREG8(CLOCK_CNTL_DATA, 0);
+	radeon_pll_errata_after_data(rinfo);
 	OUTREG(CRTC_V_SYNC_STRT_WID, 0x00830403);
 	OUTREG(CRTC_V_TOTAL_DISP, 0x03ff0429);
 	OUTREG(FP_CRTC_H_TOTAL_DISP, 0x009f0033);
@@ -2344,10 +2340,15 @@
 	INPLL(PPLL_REF_DIV);
 
 	OUTREG8(CLOCK_CNTL_INDEX, PPLL_CNTL + PLL_WR_EN);
+	radeon_pll_errata_after_index(rinfo);
 	OUTREG8(CLOCK_CNTL_DATA + 1, 0xbc);
+	radeon_pll_errata_after_data(rinfo);
 
 	tmp = INREG(CLOCK_CNTL_INDEX);
+	radeon_pll_errata_after_index(rinfo);
 	OUTREG(CLOCK_CNTL_INDEX, tmp & 0xff);
+	radeon_pll_errata_after_index(rinfo);
+	radeon_pll_errata_after_data(rinfo);
 
 	OUTPLL(PPLL_DIV_0, 0x48090);
 
Index: linux-work/drivers/video/aty/radeon_accel.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_accel.c	2005-02-24 08:37:56.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_accel.c	2005-03-11 15:43:33.000000000 +1100
@@ -189,32 +189,6 @@
 
 	radeon_engine_flush (rinfo);
 
-    	/* Some ASICs have bugs with dynamic-on feature, which are  
-     	 * ASIC-version dependent, so we force all blocks on for now
-     	 * -- from XFree86
-     	 * We don't do that on macs, things just work here with dynamic
-     	 * clocking... --BenH
-	 */
-#ifdef CONFIG_ALL_PPC
-	if (_machine != _MACH_Pmac && rinfo->hasCRTC2)
-#else
-	if (rinfo->has_CRTC2)
-#endif	
-	{
-		u32 tmp;
-
-		tmp = INPLL(SCLK_CNTL);
-		OUTPLL(SCLK_CNTL, ((tmp & ~DYN_STOP_LAT_MASK) |
-				   CP_MAX_DYN_STOP_LAT |
-				   SCLK_FORCEON_MASK));
-
-		if (rinfo->family == CHIP_FAMILY_RV200)
-		{
-			tmp = INPLL(SCLK_MORE_CNTL);
-			OUTPLL(SCLK_MORE_CNTL, tmp | SCLK_MORE_FORCEON);
-		}
-	}
-
 	clock_cntl_index = INREG(CLOCK_CNTL_INDEX);
 	mclk_cntl = INPLL(MCLK_CNTL);
 
@@ -274,8 +248,6 @@
 
 	OUTREG(CLOCK_CNTL_INDEX, clock_cntl_index);
 	OUTPLL(MCLK_CNTL, mclk_cntl);
-	if (rinfo->R300_cg_workaround)
-		R300_cg_workardound(rinfo);
 }
 
 void radeonfb_engine_init (struct radeonfb_info *rinfo)


