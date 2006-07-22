Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWGVPia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWGVPia (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 11:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWGVPiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 11:38:05 -0400
Received: from wm402rot.66.ADSL.NetSurf.Net ([66.135.97.66]:36226 "EHLO
	png3r11.pngxnet.com") by vger.kernel.org with ESMTP
	id S1750802AbWGVPhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 11:37:35 -0400
From: Dave Airlie <airlied@linux.ie>
To: linux-kernel@vger.kernel.org
Cc: Dave Airlie <airlied@linux.ie>
Subject: [PATCH] gpu/radeonfb: add GPU support to radeonfb (05/07)
Date: Sun, 23 Jul 2006 01:38:31 +1000
Message-Id: <11535827142307-git-send-email-airlied@linux.ie>
X-Mailer: git-send-email 1.4.1.ga3e6
In-Reply-To: <11535827141780-git-send-email-airlied@linux.ie>
References: <11535827134076-git-send-email-airlied@linux.ie> <11535827133352-git-send-email-airlied@linux.ie> <11535827131612-git-send-email-airlied@linux.ie> <11535827132905-git-send-email-airlied@linux.ie> <11535827141780-git-send-email-airlied@linux.ie>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to the radeonfb driver to use the new
GPU layer to driver the radeon.

Signed-off-by: Dave Airlie <airlied@linux.ie>
---
 drivers/video/Kconfig              |    1 
 drivers/video/aty/radeon_accel.c   |   18 +--
 drivers/video/aty/radeon_base.c    |  257 +++++++++++++++++-------------------
 drivers/video/aty/radeon_i2c.c     |   12 +-
 drivers/video/aty/radeon_monitor.c |   12 +-
 drivers/video/aty/radeon_pm.c      |  137 ++++++++++---------
 drivers/video/aty/radeonfb.h       |   84 +-----------
 7 files changed, 224 insertions(+), 297 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6602752..9872ab5 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1003,6 +1003,7 @@ config FB_MATROX_MULTIHEAD
 config FB_RADEON
 	tristate "ATI Radeon display support"
 	depends on FB && PCI
+	select GPU_RADEON
 	select I2C_ALGOBIT if FB_RADEON_I2C
 	select I2C if FB_RADEON_I2C
 	select FB_MODE_HELPERS
diff --git a/drivers/video/aty/radeon_accel.c b/drivers/video/aty/radeon_accel.c
index 3ca27cb..b0413d3 100644
--- a/drivers/video/aty/radeon_accel.c
+++ b/drivers/video/aty/radeon_accel.c
@@ -203,9 +203,9 @@ void radeonfb_engine_reset(struct radeon
 	host_path_cntl = INREG(HOST_PATH_CNTL);
 	rbbm_soft_reset = INREG(RBBM_SOFT_RESET);
 
-	if (rinfo->family == CHIP_FAMILY_R300 ||
-	    rinfo->family == CHIP_FAMILY_R350 ||
-	    rinfo->family == CHIP_FAMILY_RV350) {
+	if (rinfo->gpu_info->family == CHIP_FAMILY_R300 ||
+	    rinfo->gpu_info->family == CHIP_FAMILY_R350 ||
+	    rinfo->gpu_info->family == CHIP_FAMILY_RV350) {
 		u32 tmp;
 
 		OUTREG(RBBM_SOFT_RESET, (rbbm_soft_reset |
@@ -241,9 +241,9 @@ void radeonfb_engine_reset(struct radeon
 	INREG(HOST_PATH_CNTL);
 	OUTREG(HOST_PATH_CNTL, host_path_cntl);
 
-	if (rinfo->family != CHIP_FAMILY_R300 ||
-	    rinfo->family != CHIP_FAMILY_R350 ||
-	    rinfo->family != CHIP_FAMILY_RV350)
+	if (rinfo->gpu_info->family != CHIP_FAMILY_R300 ||
+	    rinfo->gpu_info->family != CHIP_FAMILY_R350 ||
+	    rinfo->gpu_info->family != CHIP_FAMILY_RV350)
 		OUTREG(RBBM_SOFT_RESET, rbbm_soft_reset);
 
 	OUTREG(CLOCK_CNTL_INDEX, clock_cntl_index);
@@ -260,9 +260,9 @@ void radeonfb_engine_init (struct radeon
 	radeonfb_engine_reset(rinfo);
 
 	radeon_fifo_wait (1);
-	if ((rinfo->family != CHIP_FAMILY_R300) &&
-	    (rinfo->family != CHIP_FAMILY_R350) &&
-	    (rinfo->family != CHIP_FAMILY_RV350))
+	if ((rinfo->gpu_info->family != CHIP_FAMILY_R300) &&
+	    (rinfo->gpu_info->family != CHIP_FAMILY_R350) &&
+	    (rinfo->gpu_info->family != CHIP_FAMILY_RV350))
 		OUTREG(RB2D_DSTCACHE_MODE, 0);
 
 	radeon_fifo_wait (3);
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 8d85fc5..2521148 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -68,6 +68,9 @@ #include <linux/pci.h>
 #include <linux/vmalloc.h>
 #include <linux/device.h>
 
+#include <linux/gpu_layer.h>
+#include <linux/radeon_gpu.h>
+
 #include <asm/io.h>
 #include <asm/uaccess.h>
 
@@ -224,7 +227,7 @@ static struct pci_device_id radeonfb_pci
 	CHIP_DEF(PCI_CHIP_RADEON_QG,	RADEON,	0),
 	{ 0, }
 };
-MODULE_DEVICE_TABLE(pci, radeonfb_pci_table);
+MODULE_DEVICE_TABLE(gpu, radeonfb_pci_table);
 
 
 typedef struct {
@@ -301,7 +304,7 @@ static int __devinit radeon_map_ROM(stru
 	rom = pci_map_rom(dev, &rom_size);
 	if (!rom) {
 		printk(KERN_ERR "radeonfb (%s): ROM failed to map\n",
-		       pci_name(rinfo->pdev));
+		       pci_name(rinfo->gpu_info->pdev));
 		return -ENOMEM;
 	}
 	
@@ -311,7 +314,7 @@ static int __devinit radeon_map_ROM(stru
 	if (BIOS_IN16(0) != 0xaa55) {
 		printk(KERN_DEBUG "radeonfb (%s): Invalid ROM signature %x "
 			"should be 0xaa55\n",
-			pci_name(rinfo->pdev), BIOS_IN16(0));
+			pci_name(rinfo->gpu_info->pdev), BIOS_IN16(0));
 		goto failed;
 	}
 	/* Look for the PCI data to check the ROM type */
@@ -343,7 +346,7 @@ static int __devinit radeon_map_ROM(stru
 	 */
 	if (BIOS_IN32(dptr) !=  (('R' << 24) | ('I' << 16) | ('C' << 8) | 'P')) {
 		printk(KERN_WARNING "radeonfb (%s): PCI DATA signature in ROM"
-		       "incorrect: %08x\n", pci_name(rinfo->pdev), BIOS_IN32(dptr));
+		       "incorrect: %08x\n", pci_name(rinfo->gpu_info->pdev), BIOS_IN32(dptr));
 		goto anyway;
 	}
 	rom_type = BIOS_IN8(dptr + 0x14);
@@ -583,7 +586,7 @@ static void __devinit radeon_get_pllinfo
 	 * incomplete, however.  It does provide ppll_max and _min values
 	 * even for most other methods, however.
 	 */
-	switch (rinfo->chipset) {
+	switch (rinfo->gpu_info->chipset) {
 	case PCI_DEVICE_ID_ATI_RADEON_QW:
 	case PCI_DEVICE_ID_ATI_RADEON_QX:
 		rinfo->pll.ppll_max = 35000;
@@ -859,7 +862,7 @@ static int radeonfb_ioctl (struct fb_inf
 		 *        routing to second output
 		 */
 		case FBIO_RADEON_SET_MIRROR:
-			if (!rinfo->is_mobility)
+			if (!rinfo->gpu_info->is_mobility)
 				return -EINVAL;
 
 			rc = get_user(value, (__u32 __user *)arg);
@@ -896,7 +899,7 @@ static int radeonfb_ioctl (struct fb_inf
 
 			return 0;
 		case FBIO_RADEON_GET_MIRROR:
-			if (!rinfo->is_mobility)
+			if (!rinfo->gpu_info->is_mobility)
 				return -EINVAL;
 
 			tmp = INREG(LVDS_GEN_CNTL);
@@ -1000,7 +1003,7 @@ int radeon_screen_blank(struct radeonfb_
 			 * RADEON_PIXCLK_LVDS_ALWAYS_ON bit is off
 			 */
 			tmp_pix_clks = INPLL(PIXCLKS_CNTL);
-			if (rinfo->is_mobility || rinfo->is_IGP)
+			if (rinfo->gpu_info->is_mobility || rinfo->gpu_info->is_IGP)
 				OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
 			val &= ~(LVDS_BL_MOD_EN);
 			OUTREG(LVDS_GEN_CNTL, val);
@@ -1014,7 +1017,7 @@ int radeon_screen_blank(struct radeonfb_
 				  msecs_to_jiffies(rinfo->panel_info.pwr_delay));
 			rinfo->init_state.lvds_gen_cntl &= ~LVDS_STATE_MASK;
 			rinfo->init_state.lvds_gen_cntl |= val & LVDS_STATE_MASK;
-			if (rinfo->is_mobility || rinfo->is_IGP)
+			if (rinfo->gpu_info->is_mobility || rinfo->gpu_info->is_IGP)
 				OUTPLL(PIXCLKS_CNTL, tmp_pix_clks);
 		}
 		break;
@@ -1119,14 +1122,14 @@ static int radeonfb_setcolreg (unsigned 
 	int rc;
 
         if (!rinfo->asleep) {
-		if (rinfo->is_mobility) {
+		if (rinfo->gpu_info->is_mobility) {
 			vclk_cntl = INPLL(VCLK_ECP_CNTL);
 			OUTPLL(VCLK_ECP_CNTL,
 			       vclk_cntl & ~PIXCLK_DAC_ALWAYS_ONb);
 		}
 
 		/* Make sure we are on first palette */
-		if (rinfo->has_CRTC2) {
+		if (rinfo->gpu_info->has_CRTC2) {
 			dac_cntl2 = INREG(DAC_CNTL2);
 			dac_cntl2 &= ~DAC2_PALETTE_ACCESS_CNTL;
 			OUTREG(DAC_CNTL2, dac_cntl2);
@@ -1135,7 +1138,7 @@ static int radeonfb_setcolreg (unsigned 
 
 	rc = radeon_setcolreg (regno, red, green, blue, transp, rinfo);
 
-	if (!rinfo->asleep && rinfo->is_mobility)
+	if (!rinfo->asleep && rinfo->gpu_info->is_mobility)
 		OUTPLL(VCLK_ECP_CNTL, vclk_cntl);
 
 	return rc;
@@ -1149,14 +1152,14 @@ static int radeonfb_setcmap(struct fb_cm
 	int i, start, rc = 0;
 
         if (!rinfo->asleep) {
-		if (rinfo->is_mobility) {
+		if (rinfo->gpu_info->is_mobility) {
 			vclk_cntl = INPLL(VCLK_ECP_CNTL);
 			OUTPLL(VCLK_ECP_CNTL,
 			       vclk_cntl & ~PIXCLK_DAC_ALWAYS_ONb);
 		}
 
 		/* Make sure we are on first palette */
-		if (rinfo->has_CRTC2) {
+		if (rinfo->gpu_info->has_CRTC2) {
 			dac_cntl2 = INREG(DAC_CNTL2);
 			dac_cntl2 &= ~DAC2_PALETTE_ACCESS_CNTL;
 			OUTREG(DAC_CNTL2, dac_cntl2);
@@ -1183,7 +1186,7 @@ static int radeonfb_setcmap(struct fb_cm
 			break;
 	}
 
-	if (!rinfo->asleep && rinfo->is_mobility)
+	if (!rinfo->asleep && rinfo->gpu_info->is_mobility)
 		OUTPLL(VCLK_ECP_CNTL, vclk_cntl);
 
 	return rc;
@@ -1233,7 +1236,7 @@ static void radeon_write_pll_regs(struct
 	radeon_fifo_wait(20);
 
 	/* Workaround from XFree */
-	if (rinfo->is_mobility) {
+	if (rinfo->gpu_info->is_mobility) {
 	        /* A temporal workaround for the occational blanking on certain laptop
 		 * panels. This appears to related to the PLL divider registers
 		 * (fail to lock?). It occurs even when all dividers are the same
@@ -1272,10 +1275,10 @@ static void radeon_write_pll_regs(struct
 	radeon_pll_errata_after_data(rinfo);
 
 	/* Set PPLL ref. div */
-	if (rinfo->family == CHIP_FAMILY_R300 ||
-	    rinfo->family == CHIP_FAMILY_RS300 ||
-	    rinfo->family == CHIP_FAMILY_R350 ||
-	    rinfo->family == CHIP_FAMILY_RV350) {
+	if (rinfo->gpu_info->family == CHIP_FAMILY_R300 ||
+	    rinfo->gpu_info->family == CHIP_FAMILY_RS300 ||
+	    rinfo->gpu_info->family == CHIP_FAMILY_R350 ||
+	    rinfo->gpu_info->family == CHIP_FAMILY_RV350) {
 		if (mode->ppll_ref_div & R300_PPLL_REF_DIV_ACC_MASK) {
 			/* When restoring console mode, use saved PPLL_REF_DIV
 			 * setting.
@@ -1435,7 +1438,7 @@ #if 1
 	 * divider. I'll find a better fix once I have more infos on the
 	 * real cause of the problem.
 	 */
-	while (rinfo->has_CRTC2) {
+	while (rinfo->gpu_info->has_CRTC2) {
 		u32 fp2_gen_cntl = INREG(FP2_GEN_CNTL);
 		u32 disp_output_cntl;
 		int source;
@@ -1446,10 +1449,10 @@ #if 1
 		/* Not all chip revs have the same format for this register,
 		 * extract the source selection
 		 */
-		if (rinfo->family == CHIP_FAMILY_R200 ||
-		    rinfo->family == CHIP_FAMILY_R300 ||
-		    rinfo->family == CHIP_FAMILY_R350 ||
-		    rinfo->family == CHIP_FAMILY_RV350) {
+		if (rinfo->gpu_info->family == CHIP_FAMILY_R200 ||
+		    rinfo->gpu_info->family == CHIP_FAMILY_R300 ||
+		    rinfo->gpu_info->family == CHIP_FAMILY_R350 ||
+		    rinfo->gpu_info->family == CHIP_FAMILY_RV350) {
 			source = (fp2_gen_cntl >> 10) & 0x3;
 			/* sourced from transform unit, check for transform unit
 			 * own source
@@ -1772,8 +1775,8 @@ #endif
 					FP_CRTC_DONT_SHADOW_HEND |
 					FP_PANEL_FORMAT);
 
-		if (IS_R300_VARIANT(rinfo) ||
-		    (rinfo->family == CHIP_FAMILY_R200)) {
+		if (IS_R300_VARIANT(rinfo->gpu_info) ||
+		    (rinfo->gpu_info->family == CHIP_FAMILY_R200)) {
 			newmode->fp_gen_cntl &= ~R200_FP_SOURCE_SEL_MASK;
 			if (use_rmx)
 				newmode->fp_gen_cntl |= R200_FP_SOURCE_SEL_RMX;
@@ -1795,8 +1798,8 @@ #endif
 			newmode->fp_gen_cntl |= (FP_FPON | FP_TMDS_EN);
 			newmode->tmds_transmitter_cntl &= ~(TMDS_PLLRST);
 			/* TMDS_PLL_EN bit is reversed on RV (and mobility) chips */
-			if (IS_R300_VARIANT(rinfo) ||
-			    (rinfo->family == CHIP_FAMILY_R200) || !rinfo->has_CRTC2)
+			if (IS_R300_VARIANT(rinfo->gpu_info) ||
+			    (rinfo->gpu_info->family == CHIP_FAMILY_R200) || !rinfo->gpu_info->has_CRTC2)
 				newmode->tmds_transmitter_cntl &= ~TMDS_PLL_EN;
 			else
 				newmode->tmds_transmitter_cntl |= TMDS_PLL_EN;
@@ -1873,7 +1876,7 @@ static int __devinit radeon_set_fbinfo (
 	info->screen_size = rinfo->mapped_vram;
 	/* Fill fix common fields */
 	strlcpy(info->fix.id, rinfo->name, sizeof(info->fix.id));
-        info->fix.smem_start = rinfo->fb_base_phys;
+        info->fix.smem_start = rinfo->gpu_info->fb_base_phys;
         info->fix.smem_len = rinfo->video_ram;
         info->fix.type = FB_TYPE_PACKED_PIXELS;
         info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
@@ -1881,7 +1884,7 @@ static int __devinit radeon_set_fbinfo (
         info->fix.ypanstep = 1;
         info->fix.ywrapstep = 0;
         info->fix.type_aux = 0;
-        info->fix.mmio_start = rinfo->mmio_base_phys;
+        info->fix.mmio_start = rinfo->gpu_info->mmio_base_phys;
         info->fix.mmio_len = RADEON_REGSIZE;
 	info->fix.accel = FB_ACCEL_ATI_RADEON;
 
@@ -1914,7 +1917,7 @@ static void fixup_memory_mappings(struct
 	u32 agp_base;
 
 	/* First, we disable display to avoid interfering */
-	if (rinfo->has_CRTC2) {
+	if (rinfo->gpu_info->has_CRTC2) {
 		save_crtc2_gen_cntl = INREG(CRTC2_GEN_CNTL);
 		OUTREG(CRTC2_GEN_CNTL, save_crtc2_gen_cntl | CRTC2_DISP_REQ_EN_B);
 	}
@@ -1956,12 +1959,12 @@ #endif
 	 */
 #ifdef SET_MC_FB_FROM_APERTURE
 	OUTREG(DISPLAY_BASE_ADDR, aper_base);
-	if (rinfo->has_CRTC2)
+	if (rinfo->gpu_info->has_CRTC2)
 		OUTREG(CRTC2_DISPLAY_BASE_ADDR, aper_base);
 	OUTREG(OV0_BASE_ADDR, aper_base);
 #else
 	OUTREG(DISPLAY_BASE_ADDR, 0);
-	if (rinfo->has_CRTC2)
+	if (rinfo->gpu_info->has_CRTC2)
 		OUTREG(CRTC2_DISPLAY_BASE_ADDR, 0);
 	OUTREG(OV0_BASE_ADDR, 0);
 #endif
@@ -1970,7 +1973,7 @@ #endif
 	/* Restore display settings */
 	OUTREG(CRTC_GEN_CNTL, save_crtc_gen_cntl);
 	OUTREG(CRTC_EXT_CNTL, save_crtc_ext_cntl);
-	if (rinfo->has_CRTC2)
+	if (rinfo->gpu_info->has_CRTC2)
 		OUTREG(CRTC2_GEN_CNTL, save_crtc2_gen_cntl);	
 
 	RTRACE("aper_base: %08x MC_FB_LOC to: %08x, MC_AGP_LOC to: %08x\n",
@@ -1986,9 +1989,9 @@ static void radeon_identify_vram(struct 
 	u32 tmp;
 
 	/* framebuffer size */
-        if ((rinfo->family == CHIP_FAMILY_RS100) ||
-            (rinfo->family == CHIP_FAMILY_RS200) ||
-            (rinfo->family == CHIP_FAMILY_RS300)) {
+        if ((rinfo->gpu_info->family == CHIP_FAMILY_RS100) ||
+            (rinfo->gpu_info->family == CHIP_FAMILY_RS200) ||
+            (rinfo->gpu_info->family == CHIP_FAMILY_RS300)) {
           u32 tom = INREG(NB_TOM);
           tmp = ((((tom >> 16) - (tom & 0xffff) + 1) << 6) * 1024);
 
@@ -2001,8 +2004,8 @@ static void radeon_identify_vram(struct 
           /* This is supposed to fix the crtc2 noise problem. */
           OUTREG(GRPH2_BUFFER_CNTL, INREG(GRPH2_BUFFER_CNTL) & ~0x7f0000);
 
-          if ((rinfo->family == CHIP_FAMILY_RS100) ||
-              (rinfo->family == CHIP_FAMILY_RS200)) {
+          if ((rinfo->gpu_info->family == CHIP_FAMILY_RS100) ||
+              (rinfo->gpu_info->family == CHIP_FAMILY_RS200)) {
              /* This is to workaround the asic bug for RMX, some versions
                 of BIOS dosen't have this register initialized correctly.
              */
@@ -2021,7 +2024,7 @@ static void radeon_identify_vram(struct 
 	 * reporting no ram
 	 */
 	if (rinfo->video_ram == 0) {
-		switch (rinfo->pdev->device) {
+		switch (rinfo->gpu_info->pdev->device) {
 	       	case PCI_CHIP_RADEON_LY:
 		case PCI_CHIP_RADEON_LZ:
 	       		rinfo->video_ram = 8192 * 1024;
@@ -2035,14 +2038,14 @@ static void radeon_identify_vram(struct 
 	/*
 	 * Now try to identify VRAM type
 	 */
-	if (rinfo->is_IGP || (rinfo->family >= CHIP_FAMILY_R300) ||
+	if (rinfo->gpu_info->is_IGP || (rinfo->gpu_info->family >= CHIP_FAMILY_R300) ||
 	    (INREG(MEM_SDRAM_MODE_REG) & (1<<30)))
 		rinfo->vram_ddr = 1;
 	else
 		rinfo->vram_ddr = 0;
 
 	tmp = INREG(MEM_CNTL);
-	if (IS_R300_VARIANT(rinfo)) {
+	if (IS_R300_VARIANT(rinfo->gpu_info)) {
 		tmp &=  R300_MEM_NUM_CHANNELS_MASK;
 		switch (tmp) {
 		case 0:  rinfo->vram_width = 64; break;
@@ -2050,9 +2053,9 @@ static void radeon_identify_vram(struct 
 		case 2:  rinfo->vram_width = 256; break;
 		default: rinfo->vram_width = 128; break;
 		}
-	} else if ((rinfo->family == CHIP_FAMILY_RV100) ||
-		   (rinfo->family == CHIP_FAMILY_RS100) ||
-		   (rinfo->family == CHIP_FAMILY_RS200)){
+	} else if ((rinfo->gpu_info->family == CHIP_FAMILY_RV100) ||
+		   (rinfo->gpu_info->family == CHIP_FAMILY_RS100) ||
+		   (rinfo->gpu_info->family == CHIP_FAMILY_RS200)){
 		if (tmp & RV100_MEM_HALF_MODE)
 			rinfo->vram_width = 32;
 		else
@@ -2069,7 +2072,7 @@ static void radeon_identify_vram(struct 
 	 */
 
 	RTRACE("radeonfb (%s): Found %ldk of %s %d bits wide videoram\n",
-	       pci_name(rinfo->pdev),
+	       pci_name(rinfo->gpu_info->pdev),
 	       rinfo->video_ram / 1024,
 	       rinfo->vram_ddr ? "DDR" : "SDRAM",
 	       rinfo->vram_width);
@@ -2096,8 +2099,8 @@ static ssize_t radeon_show_one_edid(char
 static ssize_t radeon_show_edid1(struct kobject *kobj, char *buf, loff_t off, size_t count)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct pci_dev *pdev = to_pci_dev(dev);
-        struct fb_info *info = pci_get_drvdata(pdev);
+	struct gpu_device *gdev = to_gpu_device(dev);
+        struct fb_info *info = gpu_get_drvdata(gdev);
         struct radeonfb_info *rinfo = info->par;
 
 	return radeon_show_one_edid(buf, off, count, rinfo->mon1_EDID);
@@ -2107,8 +2110,8 @@ static ssize_t radeon_show_edid1(struct 
 static ssize_t radeon_show_edid2(struct kobject *kobj, char *buf, loff_t off, size_t count)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
-	struct pci_dev *pdev = to_pci_dev(dev);
-        struct fb_info *info = pci_get_drvdata(pdev);
+	struct gpu_device *gdev = to_gpu_device(dev);
+        struct fb_info *info = gpu_get_drvdata(gdev);
         struct radeonfb_info *rinfo = info->par;
 
 	return radeon_show_one_edid(buf, off, count, rinfo->mon2_EDID);
@@ -2135,72 +2138,64 @@ static struct bin_attribute edid2_attr =
 };
 
 
-static int __devinit radeonfb_pci_register (struct pci_dev *pdev,
-				  const struct pci_device_id *ent)
+static int __devinit radeonfb_gpu_register (struct gpu_device *gdev, void *driver_id)
 {
 	struct fb_info *info;
 	struct radeonfb_info *rinfo;
+	struct radeon_gpu_info *gpu_info;
 	int ret;
+	struct pci_dev *pdev;
 
-	RTRACE("radeonfb_pci_register BEGIN\n");
-	
-	/* Enable device in PCI config */
-	ret = pci_enable_device(pdev);
-	if (ret < 0) {
-		printk(KERN_ERR "radeonfb (%s): Cannot enable PCI device\n",
-		       pci_name(pdev));
-		goto err_out;
-	}
+	/* get the radeon GPU info */
+	gpu_info = dev_get_drvdata(gdev->dev.parent);
+
+	pdev = gpu_info->pdev;
+	printk("radeonfb: %08lX\n", gpu_info->mmio_base_phys);
 
-	info = framebuffer_alloc(sizeof(struct radeonfb_info), &pdev->dev);
+	RTRACE("radeonfb_gpu_register BEGIN\n");
+
+	info = framebuffer_alloc(sizeof(struct radeonfb_info), &gdev->dev);
 	if (!info) {
-		printk (KERN_ERR "radeonfb (%s): could not allocate memory\n",
-			pci_name(pdev));
+		printk (KERN_ERR "radeonfb : could not allocate memory\n");
 		ret = -ENOMEM;
 		goto err_disable;
 	}
 	rinfo = info->par;
 	rinfo->info = info;	
-	rinfo->pdev = pdev;
 	
+	rinfo->gpu_info = gpu_info;
+	rinfo->gdev = gdev;
+
 	spin_lock_init(&rinfo->reg_lock);
 	init_timer(&rinfo->lvds_timer);
 	rinfo->lvds_timer.function = radeon_lvds_timer_func;
 	rinfo->lvds_timer.data = (unsigned long)rinfo;
 
 	strcpy(rinfo->name, "ATI Radeon XX ");
-	rinfo->name[11] = ent->device >> 8;
-	rinfo->name[12] = ent->device & 0xFF;
-	rinfo->family = ent->driver_data & CHIP_FAMILY_MASK;
-	rinfo->chipset = pdev->device;
-	rinfo->has_CRTC2 = (ent->driver_data & CHIP_HAS_CRTC2) != 0;
-	rinfo->is_mobility = (ent->driver_data & CHIP_IS_MOBILITY) != 0;
-	rinfo->is_IGP = (ent->driver_data & CHIP_IS_IGP) != 0;
-
-	/* Set base addrs */
-	rinfo->fb_base_phys = pci_resource_start (pdev, 0);
-	rinfo->mmio_base_phys = pci_resource_start (pdev, 2);
+
+	rinfo->name[11] = rinfo->gpu_info->ati_name[0];
+	rinfo->name[12] = rinfo->gpu_info->ati_name[1];
 
 	/* request the mem regions */
-	ret = pci_request_region(pdev, 0, "radeonfb framebuffer");
+	ret = pci_request_region(gpu_info->pdev, 0, "radeonfb framebuffer");
 	if (ret < 0) {
 		printk( KERN_ERR "radeonfb (%s): cannot request region 0.\n",
-			pci_name(rinfo->pdev));
+			pci_name(rinfo->gpu_info->pdev));
 		goto err_release_fb;
 	}
 
-	ret = pci_request_region(pdev, 2, "radeonfb mmio");
+	ret = pci_request_region(gpu_info->pdev, 2, "radeonfb mmio");
 	if (ret < 0) {
 		printk( KERN_ERR "radeonfb (%s): cannot request region 2.\n",
-			pci_name(rinfo->pdev));
+			pci_name(rinfo->gpu_info->pdev));
 		goto err_release_pci0;
 	}
 
 	/* map the regions */
-	rinfo->mmio_base = ioremap(rinfo->mmio_base_phys, RADEON_REGSIZE);
+	rinfo->mmio_base = ioremap(rinfo->gpu_info->mmio_base_phys, RADEON_REGSIZE);
 	if (!rinfo->mmio_base) {
 		printk(KERN_ERR "radeonfb (%s): cannot map MMIO\n",
-		       pci_name(rinfo->pdev));
+		       pci_name(rinfo->gpu_info->pdev));
 		ret = -EIO;
 		goto err_release_pci2;
 	}
@@ -2208,22 +2203,12 @@ static int __devinit radeonfb_pci_regist
 	rinfo->fb_local_base = INREG(MC_FB_LOCATION) << 16;
 
 	/*
-	 * Check for errata
+	 * Check for additional errata
 	 */
-	rinfo->errata = 0;
-	if (rinfo->family == CHIP_FAMILY_R300 &&
+	if (rinfo->gpu_info->family == CHIP_FAMILY_R300 &&
 	    (INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK)
 	    == CFG_ATI_REV_A11)
-		rinfo->errata |= CHIP_ERRATA_R300_CG;
-
-	if (rinfo->family == CHIP_FAMILY_RV200 ||
-	    rinfo->family == CHIP_FAMILY_RS200)
-		rinfo->errata |= CHIP_ERRATA_PLL_DUMMYREADS;
-
-	if (rinfo->family == CHIP_FAMILY_RV100 ||
-	    rinfo->family == CHIP_FAMILY_RS100 ||
-	    rinfo->family == CHIP_FAMILY_RS200)
-		rinfo->errata |= CHIP_ERRATA_PLL_DELAY;
+		rinfo->gpu_info->errata |= CHIP_ERRATA_R300_CG;
 
 #ifdef CONFIG_PPC_OF
 	/* On PPC, we obtain the OF device-node pointer to the firmware
@@ -2232,7 +2217,7 @@ #ifdef CONFIG_PPC_OF
 	rinfo->of_node = pci_device_to_OF_node(pdev);
 	if (rinfo->of_node == NULL)
 		printk(KERN_WARNING "radeonfb (%s): Cannot match card to OF node !\n",
-		       pci_name(rinfo->pdev));
+		       pci_name(rinfo->gpu_info->pdev));
 
 	/* On PPC, the firmware sets up a memory mapping that tends
 	 * to cause lockups when enabling the engine. We reconfigure
@@ -2247,19 +2232,19 @@ #endif /* CONFIG_PPC_OF */
 	rinfo->mapped_vram = min_t(unsigned long, MAX_MAPPED_VRAM, rinfo->video_ram);
 
 	do {
-		rinfo->fb_base = ioremap (rinfo->fb_base_phys,
+		rinfo->fb_base = ioremap (rinfo->gpu_info->fb_base_phys,
 					  rinfo->mapped_vram);
 	} while (   rinfo->fb_base == 0 &&
 		  ((rinfo->mapped_vram /=2) >= MIN_MAPPED_VRAM) );
 
 	if (rinfo->fb_base == NULL) {
 		printk (KERN_ERR "radeonfb (%s): cannot map FB\n",
-			pci_name(rinfo->pdev));
+			pci_name(rinfo->gpu_info->pdev));
 		ret = -EIO;
 		goto err_unmap_rom;
 	}
 
-	RTRACE("radeonfb (%s): mapped %ldk videoram\n", pci_name(rinfo->pdev),
+	RTRACE("radeonfb (%s): mapped %ldk videoram\n", pci_name(rinfo->gpu_info->pdev),
 	       rinfo->mapped_vram/1024);
 
 	/*
@@ -2273,8 +2258,8 @@ #endif /* CONFIG_PPC_OF */
 	 * archs who would store that elsewhere and/or could initialize
 	 * more than one adapter during boot).
 	 */
-	if (!rinfo->is_mobility)
-		radeon_map_ROM(rinfo, pdev);
+	if (!rinfo->gpu_info->is_mobility)
+		radeon_map_ROM(rinfo, rinfo->gpu_info->pdev);
 
 	/*
 	 * On x86, the primary display on laptop may have it's BIOS
@@ -2290,8 +2275,8 @@ #endif
 	/* If both above failed, try the BIOS ROM again for mobility
 	 * chips
 	 */
-	if (rinfo->bios_seg == NULL && rinfo->is_mobility)
-		radeon_map_ROM(rinfo, pdev);
+	if (rinfo->bios_seg == NULL && rinfo->gpu_info->is_mobility)
+		radeon_map_ROM(rinfo, rinfo->gpu_info->pdev);
 
 	/* Get informations about the board's PLL */
 	radeon_get_pllinfo(rinfo);
@@ -2312,9 +2297,9 @@ #endif
 
 	/* Register some sysfs stuff (should be done better) */
 	if (rinfo->mon1_EDID)
-		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
+		sysfs_create_bin_file(&gdev->dev.kobj, &edid1_attr);
 	if (rinfo->mon2_EDID)
-		sysfs_create_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
+		sysfs_create_bin_file(&gdev->dev.kobj, &edid2_attr);
 
 	/* save current mode regs before we switch into the new one
 	 * so we can restore this upon __exit
@@ -2327,32 +2312,32 @@ #endif
 		/* -2 is special: means  ON on mobility chips and do not
 		 * change on others
 		 */
-		radeonfb_pm_init(rinfo, rinfo->is_mobility ? 1 : -1);
+		radeonfb_pm_init(rinfo, rinfo->gpu_info->is_mobility ? 1 : -1);
 	} else
 		radeonfb_pm_init(rinfo, default_dynclk);
 
-	pci_set_drvdata(pdev, info);
+	gpu_set_drvdata(gdev, info);
 
 	/* Register with fbdev layer */
 	ret = register_framebuffer(info);
 	if (ret < 0) {
 		printk (KERN_ERR "radeonfb (%s): could not register framebuffer\n",
-			pci_name(rinfo->pdev));
+			pci_name(rinfo->gpu_info->pdev));
 		goto err_unmap_fb;
 	}
 
 #ifdef CONFIG_MTRR
-	rinfo->mtrr_hdl = nomtrr ? -1 : mtrr_add(rinfo->fb_base_phys,
+	rinfo->mtrr_hdl = nomtrr ? -1 : mtrr_add(rinfo->gpu_info->fb_base_phys,
 						 rinfo->video_ram,
 						 MTRR_TYPE_WRCOMB, 1);
 #endif
 
 	radeonfb_bl_init(rinfo);
 
-	printk ("radeonfb (%s): %s\n", pci_name(rinfo->pdev), rinfo->name);
+	printk ("radeonfb (%s): %s\n", pci_name(rinfo->gpu_info->pdev), rinfo->name);
 
 	if (rinfo->bios_seg)
-		radeon_unmap_ROM(rinfo, pdev);
+		radeon_unmap_ROM(rinfo, rinfo->gpu_info->pdev);
 	RTRACE("radeonfb_pci_register END\n");
 
 	return 0;
@@ -2368,7 +2353,7 @@ #ifdef CONFIG_FB_RADEON_I2C
 	radeon_delete_i2c_busses(rinfo);
 #endif
 	if (rinfo->bios_seg)
-		radeon_unmap_ROM(rinfo, pdev);
+		radeon_unmap_ROM(rinfo, rinfo->gpu_info->pdev);
 	iounmap(rinfo->mmio_base);
 err_release_pci2:
 	pci_release_region(pdev, 2);
@@ -2377,27 +2362,27 @@ err_release_pci0:
 err_release_fb:
         framebuffer_release(info);
 err_disable:
-err_out:
 	return ret;
 }
 
 
 
-static void __devexit radeonfb_pci_unregister (struct pci_dev *pdev)
+static void __devexit radeonfb_gpu_unregister(struct gpu_device *gdev)
 {
-        struct fb_info *info = pci_get_drvdata(pdev);
-        struct radeonfb_info *rinfo = info->par;
- 
-        if (!rinfo)
-                return;
+	struct fb_info *info = gpu_get_drvdata(gdev);
+	struct radeonfb_info *rinfo = info->par;
+	struct pci_dev *pdev = rinfo->gpu_info->pdev;
+
+	if (!rinfo)
+		return;
 
 	radeonfb_bl_exit(rinfo);
 	radeonfb_pm_exit(rinfo);
 
 	if (rinfo->mon1_EDID)
-		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid1_attr);
+		sysfs_remove_bin_file(&gdev->dev.kobj, &edid1_attr);
 	if (rinfo->mon2_EDID)
-		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
+		sysfs_remove_bin_file(&gdev->dev.kobj, &edid2_attr);
 
 #if 0
 	/* restore original state
@@ -2416,11 +2401,12 @@ #ifdef CONFIG_MTRR
 		mtrr_del(rinfo->mtrr_hdl, 0, 0);
 #endif
 
-        unregister_framebuffer(info);
+	gpu_set_drvdata(gdev, NULL);
+	unregister_framebuffer(info);
+
+	iounmap(rinfo->mmio_base);
+	iounmap(rinfo->fb_base);
 
-        iounmap(rinfo->mmio_base);
-        iounmap(rinfo->fb_base);
- 
 	pci_release_region(pdev, 2);
 	pci_release_region(pdev, 0);
 
@@ -2436,14 +2422,17 @@ #endif        
 }
 
 
-static struct pci_driver radeonfb_driver = {
+static struct gpu_driver radeonfb_driver = {
 	.name		= "radeonfb",
-	.id_table	= radeonfb_pci_table,
-	.probe		= radeonfb_pci_register,
-	.remove		= __devexit_p(radeonfb_pci_unregister),
+	.drv_type	= GPU_FB,
+	.probe		= radeonfb_gpu_register,
+	.remove		= __devexit_p(radeonfb_gpu_unregister),
+	.id_table	= (void *)radeonfb_pci_table,
 #ifdef CONFIG_PM
-	.suspend       	= radeonfb_pci_suspend,
-	.resume		= radeonfb_pci_resume,
+	.driver = {
+		.suspend		= radeonfb_gpu_suspend,
+		.resume		= radeonfb_gpu_resume,
+	}
 #endif /* CONFIG_PM */
 };
 
@@ -2493,13 +2482,13 @@ #ifndef MODULE
 		return -ENODEV;
 	radeonfb_setup(option);
 #endif
-	return pci_register_driver (&radeonfb_driver);
+	return radeon_gpu_register_driver(&radeonfb_driver, THIS_MODULE);
 }
 
 
 static void __exit radeonfb_exit (void)
 {
-	pci_unregister_driver (&radeonfb_driver);
+	gpu_unregister_driver (&radeonfb_driver);
 }
 
 module_init(radeonfb_init);
diff --git a/drivers/video/aty/radeon_i2c.c b/drivers/video/aty/radeon_i2c.c
index 9aaca58..c00990e 100644
--- a/drivers/video/aty/radeon_i2c.c
+++ b/drivers/video/aty/radeon_i2c.c
@@ -76,7 +76,7 @@ static int radeon_setup_i2c_bus(struct r
 	chan->adapter.owner		= THIS_MODULE;
 	chan->adapter.id		= I2C_HW_B_RADEON;
 	chan->adapter.algo_data		= &chan->algo;
-	chan->adapter.dev.parent	= &chan->rinfo->pdev->dev;
+	chan->adapter.dev.parent	= &chan->rinfo->gdev->dev;
 	chan->algo.setsda		= radeon_gpio_setsda;
 	chan->algo.setscl		= radeon_gpio_setscl;
 	chan->algo.getsda		= radeon_gpio_getsda;
@@ -94,9 +94,9 @@ static int radeon_setup_i2c_bus(struct r
 
 	rc = i2c_bit_add_bus(&chan->adapter);
 	if (rc == 0)
-		dev_dbg(&chan->rinfo->pdev->dev, "I2C bus %s registered.\n", name);
+		dev_dbg(&chan->rinfo->gdev->dev, "I2C bus %s registered.\n", name);
 	else
-		dev_warn(&chan->rinfo->pdev->dev, "Failed to register I2C bus %s.\n", name);
+		dev_warn(&chan->rinfo->gdev->dev, "Failed to register I2C bus %s.\n", name);
 	return rc;
 }
 
@@ -157,14 +157,14 @@ static u8 *radeon_do_probe_i2c_edid(stru
 
 	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
 	if (!buf) {
-		dev_warn(&chan->rinfo->pdev->dev, "Out of memory!\n");
+		dev_warn(&chan->rinfo->gdev->dev, "Out of memory!\n");
 		return NULL;
 	}
 	msgs[1].buf = buf;
 
 	if (i2c_transfer(&chan->adapter, msgs, 2) == 2)
 		return buf;
-	dev_dbg(&chan->rinfo->pdev->dev, "Unable to read EDID block.\n");
+	dev_dbg(&chan->rinfo->gdev->dev, "Unable to read EDID block.\n");
 	kfree(buf);
 	return NULL;
 }
@@ -249,7 +249,7 @@ int radeon_probe_i2c_connector(struct ra
 	}
 	if (edid[0x14] & 0x80) {
 		/* Fix detection using BIOS tables */
-		if (rinfo->is_mobility /*&& conn == ddc_dvi*/ &&
+		if (rinfo->gpu_info->is_mobility /*&& conn == ddc_dvi*/ &&
 		    (INREG(LVDS_GEN_CNTL) & LVDS_ON)) {
 			RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn);
 			return MT_LCD;
diff --git a/drivers/video/aty/radeon_monitor.c b/drivers/video/aty/radeon_monitor.c
index 98c05bc..7190bad 100644
--- a/drivers/video/aty/radeon_monitor.c
+++ b/drivers/video/aty/radeon_monitor.c
@@ -123,7 +123,7 @@ static int __devinit radeon_probe_OF_hea
         while (dp == NULL)
 		return MT_NONE;
 
-	if (rinfo->has_CRTC2) {
+	if (rinfo->gpu_info->has_CRTC2) {
 		char *pname;
 		int len, second = 0;
 
@@ -329,8 +329,8 @@ static int __devinit radeon_crt_is_conne
 	ulData            |=  (DAC_FORCE_BLANK_OFF_EN
 			       |DAC_FORCE_DATA_EN
 			       |DAC_FORCE_DATA_SEL_MASK);
-	if ((rinfo->family == CHIP_FAMILY_RV250) ||
-	    (rinfo->family == CHIP_FAMILY_RV280))
+	if ((rinfo->gpu_info->family == CHIP_FAMILY_RV250) ||
+	    (rinfo->gpu_info->family == CHIP_FAMILY_RV280))
 	    ulData |= (0x01b6 << DAC_FORCE_DATA_SHIFT);
 	else
 	    ulData |= (0x01ac << DAC_FORCE_DATA_SHIFT);
@@ -495,7 +495,7 @@ #endif /* DEBUG */
 		/*
 		 * Old single head cards
 		 */
-		if (!rinfo->has_CRTC2) {
+		if (!rinfo->gpu_info->has_CRTC2) {
 #ifdef CONFIG_PPC_OF
 			if (rinfo->mon1_type == MT_NONE)
 				rinfo->mon1_type = radeon_probe_OF_head(rinfo, 0,
@@ -561,7 +561,7 @@ #ifdef CONFIG_FB_RADEON_I2C
 				ddc_crt2_used = 1;
 		}
 #endif /* CONFIG_FB_RADEON_I2C */
-		if (rinfo->mon1_type == MT_NONE && rinfo->is_mobility &&
+		if (rinfo->mon1_type == MT_NONE && rinfo->gpu_info->is_mobility &&
 		    ((rinfo->bios_seg && (INREG(BIOS_4_SCRATCH) & 4))
 		     || (INREG(LVDS_GEN_CNTL) & LVDS_ON))) {
 			rinfo->mon1_type = MT_LCD;
@@ -633,7 +633,7 @@ #endif /* CONFIG_FB_RADEON_I2C */
 	       radeon_get_mon_name(rinfo->mon1_type));
 	if (rinfo->mon1_EDID)
 		printk(KERN_INFO "radeonfb: EDID probed\n");
-	if (!rinfo->has_CRTC2)
+	if (!rinfo->gpu_info->has_CRTC2)
 		return;
 	printk(KERN_INFO "radeonfb: Monitor 2 type %s found\n",
 	       radeon_get_mon_name(rinfo->mon2_type));
diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
index c709176..730624d 100644
--- a/drivers/video/aty/radeon_pm.c
+++ b/drivers/video/aty/radeon_pm.c
@@ -32,8 +32,8 @@ static void radeon_pm_disable_dynamic_mo
 	u32 tmp;
 
 	/* RV100 */
-	if ((rinfo->family == CHIP_FAMILY_RV100) && (!rinfo->is_mobility)) {
-		if (rinfo->has_CRTC2) {
+	if ((rinfo->gpu_info->family == CHIP_FAMILY_RV100) && (!rinfo->gpu_info->is_mobility)) {
+		if (rinfo->gpu_info->has_CRTC2) {
 			tmp = INPLL(pllSCLK_CNTL);
 			tmp &= ~SCLK_CNTL__DYN_STOP_LAT_MASK;
 			tmp |= SCLK_CNTL__CP_MAX_DYN_STOP_LAT | SCLK_CNTL__FORCEON_MASK;
@@ -50,7 +50,7 @@ static void radeon_pm_disable_dynamic_mo
 		return;
 	}
 	/* R100 */
-	if (!rinfo->has_CRTC2) {
+	if (!rinfo->gpu_info->has_CRTC2) {
                 tmp = INPLL(pllSCLK_CNTL);
                 tmp |= (SCLK_CNTL__FORCE_CP	| SCLK_CNTL__FORCE_HDP	|
 			SCLK_CNTL__FORCE_DISP1	| SCLK_CNTL__FORCE_TOP	|
@@ -63,7 +63,7 @@ static void radeon_pm_disable_dynamic_mo
 		return;
 	}
 	/* RV350 (M10/M11) */
-	if (rinfo->family == CHIP_FAMILY_RV350) {
+	if (rinfo->gpu_info->family == CHIP_FAMILY_RV350) {
                 /* for RV350/M10/M11, no delays are required. */
                 tmp = INPLL(pllSCLK_CNTL2);
                 tmp |= (SCLK_CNTL2__R300_FORCE_TCL |
@@ -130,7 +130,7 @@ static void radeon_pm_disable_dynamic_mo
 	/* XFree doesn't do that case, but we had this code from Apple and it
 	 * seem necessary for proper suspend/resume operations
 	 */
-	if (rinfo->is_mobility) {
+	if (rinfo->gpu_info->is_mobility) {
 		tmp |= 	SCLK_CNTL__FORCE_HDP|
 			SCLK_CNTL__FORCE_DISP1|
 			SCLK_CNTL__FORCE_DISP2|
@@ -147,8 +147,8 @@ static void radeon_pm_disable_dynamic_mo
 			SCLK_CNTL__FORCE_SUBPIC|
 			SCLK_CNTL__FORCE_OV0;
 	}
-	else if (rinfo->family == CHIP_FAMILY_R300 ||
-		   rinfo->family == CHIP_FAMILY_R350) {
+	else if (rinfo->gpu_info->family == CHIP_FAMILY_R300 ||
+		   rinfo->gpu_info->family == CHIP_FAMILY_R350) {
 		tmp |=  SCLK_CNTL__FORCE_HDP   |
 			SCLK_CNTL__FORCE_DISP1 |
 			SCLK_CNTL__FORCE_DISP2 |
@@ -159,7 +159,7 @@ static void radeon_pm_disable_dynamic_mo
     	OUTPLL(pllSCLK_CNTL, tmp);
 	radeon_msleep(16);
 
-	if (rinfo->family == CHIP_FAMILY_R300 || rinfo->family == CHIP_FAMILY_R350) {
+	if (rinfo->gpu_info->family == CHIP_FAMILY_R300 || rinfo->gpu_info->family == CHIP_FAMILY_R350) {
 		tmp = INPLL(pllSCLK_CNTL2);
 		tmp |=  SCLK_CNTL2__R300_FORCE_TCL |
 			SCLK_CNTL2__R300_FORCE_GA  |
@@ -173,7 +173,7 @@ static void radeon_pm_disable_dynamic_mo
 	OUTPLL(pllCLK_PIN_CNTL, tmp);
 	radeon_msleep(15);
 
-	if (rinfo->is_IGP) {
+	if (rinfo->gpu_info->is_IGP) {
 		/* Weird  ... X is _un_ forcing clocks here, I think it's
 		 * doing backward. Imitate it for now...
 		 */
@@ -184,7 +184,7 @@ static void radeon_pm_disable_dynamic_mo
 		radeon_msleep(16);
 	}
 	/* Hrm... same shit, X doesn't do that but I have to */
-	else if (rinfo->is_mobility) {
+	else if (rinfo->gpu_info->is_mobility) {
 		tmp = INPLL(pllMCLK_CNTL);
 		tmp |= (MCLK_CNTL__FORCE_MCLKA |
 			MCLK_CNTL__FORCE_MCLKB |
@@ -202,7 +202,7 @@ static void radeon_pm_disable_dynamic_mo
 		radeon_msleep(15);
 	}
 
-	if (rinfo->is_mobility) {
+	if (rinfo->gpu_info->is_mobility) {
 		tmp = INPLL(pllSCLK_MORE_CNTL);
 		tmp |= 	SCLK_MORE_CNTL__FORCE_DISPREGS|
 			SCLK_MORE_CNTL__FORCE_MC_GUI|
@@ -234,7 +234,7 @@ static void radeon_pm_enable_dynamic_mod
 	u32 tmp;
 
 	/* R100 */
-	if (!rinfo->has_CRTC2) {
+	if (!rinfo->gpu_info->has_CRTC2) {
                 tmp = INPLL(pllSCLK_CNTL);
 
 		if ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) > CFG_ATI_REV_A13)
@@ -249,7 +249,7 @@ static void radeon_pm_enable_dynamic_mod
 	}
 
 	/* M10/M11 */
-	if (rinfo->family == CHIP_FAMILY_RV350) {
+	if (rinfo->gpu_info->family == CHIP_FAMILY_RV350) {
 		tmp = INPLL(pllSCLK_CNTL2);
 		tmp &= ~(SCLK_CNTL2__R300_FORCE_TCL |
 			 SCLK_CNTL2__R300_FORCE_GA  |
@@ -334,7 +334,7 @@ static void radeon_pm_enable_dynamic_mod
 	}
 
 	/* R300 */
-	if (rinfo->family == CHIP_FAMILY_R300 || rinfo->family == CHIP_FAMILY_R350) {
+	if (rinfo->gpu_info->family == CHIP_FAMILY_R300 || rinfo->gpu_info->family == CHIP_FAMILY_R350) {
 		tmp = INPLL(pllSCLK_CNTL);
 		tmp &= ~(SCLK_CNTL__R300_FORCE_VAP);
 		tmp |= SCLK_CNTL__FORCE_CP;
@@ -371,9 +371,9 @@ static void radeon_pm_enable_dynamic_mod
 	tmp &= ~SCLK_CNTL__FORCEON_MASK;
 
 	/*RAGE_6::A11 A12 A12N1 A13, RV250::A11 A12, R300*/
-	if ((rinfo->family == CHIP_FAMILY_RV250 &&
+	if ((rinfo->gpu_info->family == CHIP_FAMILY_RV250 &&
 	     ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) < CFG_ATI_REV_A13)) ||
-	    ((rinfo->family == CHIP_FAMILY_RV100) &&
+	    ((rinfo->gpu_info->family == CHIP_FAMILY_RV100) &&
 	     ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) <= CFG_ATI_REV_A13))) {
 		tmp |= SCLK_CNTL__FORCE_CP;
 		tmp |= SCLK_CNTL__FORCE_VIP;
@@ -381,15 +381,15 @@ static void radeon_pm_enable_dynamic_mod
 	OUTPLL(pllSCLK_CNTL, tmp);
 	radeon_msleep(15);
 
-	if ((rinfo->family == CHIP_FAMILY_RV200) ||
-	    (rinfo->family == CHIP_FAMILY_RV250) ||
-	    (rinfo->family == CHIP_FAMILY_RV280)) {
+	if ((rinfo->gpu_info->family == CHIP_FAMILY_RV200) ||
+	    (rinfo->gpu_info->family == CHIP_FAMILY_RV250) ||
+	    (rinfo->gpu_info->family == CHIP_FAMILY_RV280)) {
 		tmp = INPLL(pllSCLK_MORE_CNTL);
 		tmp &= ~SCLK_MORE_CNTL__FORCEON;
 
 		/* RV200::A11 A12 RV250::A11 A12 */
-		if (((rinfo->family == CHIP_FAMILY_RV200) ||
-		     (rinfo->family == CHIP_FAMILY_RV250)) &&
+		if (((rinfo->gpu_info->family == CHIP_FAMILY_RV200) ||
+		     (rinfo->gpu_info->family == CHIP_FAMILY_RV250)) &&
 		    ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) < CFG_ATI_REV_A13))
 			tmp |= SCLK_MORE_CNTL__FORCEON;
 
@@ -399,8 +399,8 @@ static void radeon_pm_enable_dynamic_mod
 	
 
 	/* RV200::A11 A12, RV250::A11 A12 */
-	if (((rinfo->family == CHIP_FAMILY_RV200) ||
-	     (rinfo->family == CHIP_FAMILY_RV250)) &&
+	if (((rinfo->gpu_info->family == CHIP_FAMILY_RV200) ||
+	     (rinfo->gpu_info->family == CHIP_FAMILY_RV250)) &&
 	    ((INREG(CONFIG_CNTL) & CFG_ATI_REV_ID_MASK) < CFG_ATI_REV_A13)) {
 		tmp = INPLL(pllPLL_PWRMGT_CNTL);
 		tmp |= PLL_PWRMGT_CNTL__TCL_BYPASS_DISABLE;
@@ -426,7 +426,7 @@ static void radeon_pm_enable_dynamic_mod
 
 	/* X doesn't do that ... hrm, we do on mobility && Macs */
 #ifdef CONFIG_PPC_OF
-	if (rinfo->is_mobility) {
+	if (rinfo->gpu_info->is_mobility) {
 		tmp  = INPLL(pllMCLK_CNTL);
 		tmp &= ~(MCLK_CNTL__FORCE_MCLKA |
 			 MCLK_CNTL__FORCE_MCLKB |
@@ -507,7 +507,7 @@ static void radeon_pm_save_regs(struct r
 	rinfo->save_regs[37] = INREG(MPP_TB_CONFIG);
 	rinfo->save_regs[38] = INREG(FCP_CNTL);
 
-	if (rinfo->is_mobility) {
+	if (rinfo->gpu_info->is_mobility) {
 		rinfo->save_regs[12] = INREG(LVDS_PLL_CNTL);
 		rinfo->save_regs[43] = INPLL(pllSSPLL_CNTL);
 		rinfo->save_regs[44] = INPLL(pllSSPLL_REF_DIV);
@@ -517,7 +517,7 @@ static void radeon_pm_save_regs(struct r
 		rinfo->save_regs[81] = INREG(LVDS_GEN_CNTL);
 	}
 
-	if (rinfo->family >= CHIP_FAMILY_RV200) {
+	if (rinfo->gpu_info->family >= CHIP_FAMILY_RV200) {
 		rinfo->save_regs[42] = INREG(MEM_REFRESH_CNTL);
 		rinfo->save_regs[46] = INREG(MC_CNTL);
 		rinfo->save_regs[47] = INREG(MC_INIT_GFX_LAT_TIMER);
@@ -533,7 +533,7 @@ static void radeon_pm_save_regs(struct r
 	rinfo->save_regs[56] = INREG(PAD_CTLR_MISC);
 	rinfo->save_regs[57] = INREG(FW_CNTL);
 
-	if (rinfo->family >= CHIP_FAMILY_R300) {
+	if (rinfo->gpu_info->family >= CHIP_FAMILY_R300) {
 		rinfo->save_regs[58] = INMC(rinfo, ixR300_MC_MC_INIT_WR_LAT_TIMER);
 		rinfo->save_regs[59] = INMC(rinfo, ixR300_MC_IMP_CNTL);
 		rinfo->save_regs[60] = INMC(rinfo, ixR300_MC_CHP_IO_CNTL_C0);
@@ -598,7 +598,7 @@ static void radeon_pm_restore_regs(struc
 	OUTPLL(VCLK_ECP_CNTL, rinfo->save_regs[5]);
 	OUTPLL(PIXCLKS_CNTL, rinfo->save_regs[6]);
 	OUTPLL(MCLK_MISC, rinfo->save_regs[7]);
-	if (rinfo->family == CHIP_FAMILY_RV350)
+	if (rinfo->gpu_info->family == CHIP_FAMILY_RV350)
 		OUTPLL(SCLK_MORE_CNTL, rinfo->save_regs[34]);
 
 	OUTREG(SURFACE_CNTL, rinfo->save_regs[29]);
@@ -649,7 +649,7 @@ static void radeon_pm_disable_iopad(stru
 static void radeon_pm_program_v2clk(struct radeonfb_info *rinfo)
 {
 	/* Set v2clk to 65MHz */
-	if (rinfo->family <= CHIP_FAMILY_RV280) {
+	if (rinfo->gpu_info->family <= CHIP_FAMILY_RV280) {
 		OUTPLL(pllPIXCLKS_CNTL,
 			 __INPLL(rinfo, pllPIXCLKS_CNTL)
 			 & ~PIXCLKS_CNTL__PIX2CLK_SRC_SEL_MASK);
@@ -681,7 +681,7 @@ static void radeon_pm_low_current(struct
 	u32 reg;
 
 	reg  = INREG(BUS_CNTL1);
-	if (rinfo->family <= CHIP_FAMILY_RV280) {
+	if (rinfo->gpu_info->family <= CHIP_FAMILY_RV280) {
 		reg &= ~BUS_CNTL1_MOBILE_PLATFORM_SEL_MASK;
 		reg |= BUS_CNTL1_AGPCLK_VALID | (1<<BUS_CNTL1_MOBILE_PLATFORM_SEL_SHIFT);
 	} else {
@@ -761,7 +761,7 @@ static void radeon_pm_setup_for_suspend(
 			SCLK_CNTL__FORCE_TV_SCLK|
 			SCLK_CNTL__FORCE_SUBPIC|
 			SCLK_CNTL__FORCE_OV0;
-	if (rinfo->family <= CHIP_FAMILY_RV280)
+	if (rinfo->gpu_info->family <= CHIP_FAMILY_RV280)
 		sclk_cntl |= SCLK_CNTL__FORCE_RE;
 	else
 		sclk_cntl |= SCLK_CNTL__SE_MAX_DYN_STOP_LAT |
@@ -854,7 +854,7 @@ static void radeon_pm_setup_for_suspend(
 	OUTPLL( pllMCLK_MISC, tmp);
 	
 	/* AGP PLL control */
-	if (rinfo->family <= CHIP_FAMILY_RV280) {
+	if (rinfo->gpu_info->family <= CHIP_FAMILY_RV280) {
 		OUTREG(BUS_CNTL1, INREG(BUS_CNTL1) |  BUS_CNTL1__AGPCLK_VALID);
 
 		OUTREG(BUS_CNTL1,
@@ -1156,7 +1156,7 @@ static void radeon_pm_full_reset_sdram(s
 	OUTREG( CRTC2_GEN_CNTL, (crtcGenCntl2 | CRTC2_GEN_CNTL__CRTC2_DISP_REQ_EN_B) );
   
 	/* This is the code for the Aluminium PowerBooks M10 / iBooks M11 */
-	if (rinfo->family == CHIP_FAMILY_RV350) {
+	if (rinfo->gpu_info->family == CHIP_FAMILY_RV350) {
 		u32 sdram_mode_reg = rinfo->save_regs[35];
 		static u32 default_mrtable[] =
 			{ 0x21320032,
@@ -1217,7 +1217,7 @@ #endif /* CONFIG_PPC_OF */
 
 	}
 	/* Here come the desktop RV200 "QW" card */
-	else if (!rinfo->is_mobility && rinfo->family == CHIP_FAMILY_RV200) {
+	else if (!rinfo->gpu_info->is_mobility && rinfo->gpu_info->family == CHIP_FAMILY_RV200) {
 		/* Disable refresh */
 		memRefreshCntl 	= INREG( MEM_REFRESH_CNTL)
 			& ~MEM_REFRESH_CNTL__MEM_REFRESH_DIS;
@@ -1240,7 +1240,7 @@ #endif /* CONFIG_PPC_OF */
 
 	}
 	/* The M6 */
-	else if (rinfo->is_mobility && rinfo->family == CHIP_FAMILY_RV100) {
+	else if (rinfo->gpu_info->is_mobility && rinfo->gpu_info->family == CHIP_FAMILY_RV100) {
 		/* Disable refresh */
 		memRefreshCntl = INREG(EXT_MEM_CNTL) & ~(1 << 20);
 		OUTREG( EXT_MEM_CNTL, memRefreshCntl | (1 << 20));
@@ -1270,7 +1270,7 @@ #endif /* CONFIG_PPC_OF */
 		OUTREG(EXT_MEM_CNTL, memRefreshCntl);
 	}
 	/* And finally, the M7..M9 models, including M9+ (RV280) */
-	else if (rinfo->is_mobility) {
+	else if (rinfo->gpu_info->is_mobility) {
 
 		/* Disable refresh */
 		memRefreshCntl 	= INREG( MEM_REFRESH_CNTL)
@@ -1290,7 +1290,7 @@ #endif /* CONFIG_PPC_OF */
 		radeon_pm_yclk_mclk_sync(rinfo);
 
 		/* M6, M7 and M9 so far ... */
-		if (rinfo->family <= CHIP_FAMILY_RV250) {
+		if (rinfo->gpu_info->family <= CHIP_FAMILY_RV250) {
 			radeon_pm_program_mode_reg(rinfo, 0x2000, 1);
 			radeon_pm_program_mode_reg(rinfo, 0x2001, 1);
 			radeon_pm_program_mode_reg(rinfo, 0x2002, 1);
@@ -1298,7 +1298,7 @@ #endif /* CONFIG_PPC_OF */
 			radeon_pm_program_mode_reg(rinfo, 0x0032, 1);
 		}
 		/* M9+ (iBook G4) */
-		else if (rinfo->family == CHIP_FAMILY_RV280) {
+		else if (rinfo->gpu_info->family == CHIP_FAMILY_RV280) {
 			radeon_pm_program_mode_reg(rinfo, 0x2000, 1);
 			radeon_pm_program_mode_reg(rinfo, 0x0132, 1);
 			radeon_pm_program_mode_reg(rinfo, 0x0032, 1);
@@ -2418,7 +2418,7 @@ static void radeon_set_suspend(struct ra
 	 */
 	if (suspend) {
 		printk(KERN_DEBUG "radeonfb (%s): switching to D2 state...\n",
-		       pci_name(rinfo->pdev));
+		       pci_name(rinfo->gpu_info->pdev));
 
 		/* Disable dynamic power management of clocks for the
 		 * duration of the suspend/resume process
@@ -2430,7 +2430,7 @@ static void radeon_set_suspend(struct ra
 
 		/* Prepare mobility chips for suspend.
 		 */
-		if (rinfo->is_mobility) {
+		if (rinfo->gpu_info->is_mobility) {
 			/* Program V2CLK */
 			radeon_pm_program_v2clk(rinfo);
 		
@@ -2443,7 +2443,7 @@ static void radeon_set_suspend(struct ra
 			/* Prepare chip for power management */
 			radeon_pm_setup_for_suspend(rinfo);
 
-			if (rinfo->family <= CHIP_FAMILY_RV280) {
+			if (rinfo->gpu_info->family <= CHIP_FAMILY_RV280) {
 				/* Reset the MDLL */
 				/* because both INPLL and OUTPLL take the same
 				 * lock, that's why. */
@@ -2454,32 +2454,32 @@ static void radeon_set_suspend(struct ra
 		}
 
 		for (i = 0; i < 64; ++i)
-			pci_read_config_dword(rinfo->pdev, i * 4,
+			pci_read_config_dword(rinfo->gpu_info->pdev, i * 4,
 					      &rinfo->cfg_save[i]);
 
 		/* Switch PCI power managment to D2. */
-		pci_disable_device(rinfo->pdev);
+		pci_disable_device(rinfo->gpu_info->pdev);
 		for (;;) {
 			pci_read_config_word(
-				rinfo->pdev, rinfo->pm_reg+PCI_PM_CTRL,
+				rinfo->gpu_info->pdev, rinfo->pm_reg+PCI_PM_CTRL,
 				&pwr_cmd);
 			if (pwr_cmd & 2)
 				break;			
 			pci_write_config_word(
-				rinfo->pdev, rinfo->pm_reg+PCI_PM_CTRL,
+				rinfo->gpu_info->pdev, rinfo->pm_reg+PCI_PM_CTRL,
 				(pwr_cmd & ~PCI_PM_CTRL_STATE_MASK) | 2);
 			mdelay(500);
 		}
 	} else {
 		printk(KERN_DEBUG "radeonfb (%s): switching to D0 state...\n",
-		       pci_name(rinfo->pdev));
+		       pci_name(rinfo->gpu_info->pdev));
 
 		/* Switch back PCI powermanagment to D0 */
 		mdelay(200);
-		pci_write_config_word(rinfo->pdev, rinfo->pm_reg+PCI_PM_CTRL, 0);
+		pci_write_config_word(rinfo->gpu_info->pdev, rinfo->pm_reg+PCI_PM_CTRL, 0);
 		mdelay(500);
 
-		if (rinfo->family <= CHIP_FAMILY_RV250) {
+		if (rinfo->gpu_info->family <= CHIP_FAMILY_RV250) {
 			/* Reset the SDRAM controller  */
 			radeon_pm_full_reset_sdram(rinfo);
 
@@ -2500,7 +2500,7 @@ static int radeon_restore_pci_cfg(struct
 	static u32 radeon_cfg_after_resume[64];
 
 	for (i = 0; i < 64; ++i)
-		pci_read_config_dword(rinfo->pdev, i * 4,
+		pci_read_config_dword(rinfo->gpu_info->pdev, i * 4,
 				      &radeon_cfg_after_resume[i]);
 
 	if (radeon_cfg_after_resume[PCI_BASE_ADDRESS_0/4]
@@ -2509,21 +2509,22 @@ static int radeon_restore_pci_cfg(struct
 
 	for (i = PCI_BASE_ADDRESS_0/4; i < 64; ++i) {
 		if (radeon_cfg_after_resume[i] != rinfo->cfg_save[i])
-			pci_write_config_dword(rinfo->pdev, i * 4,
+			pci_write_config_dword(rinfo->gpu_info->pdev, i * 4,
 					       rinfo->cfg_save[i]);
 	}
-	pci_write_config_word(rinfo->pdev, PCI_CACHE_LINE_SIZE,
+	pci_write_config_word(rinfo->gpu_info->pdev, PCI_CACHE_LINE_SIZE,
 			      rinfo->cfg_save[PCI_CACHE_LINE_SIZE/4]);
-	pci_write_config_word(rinfo->pdev, PCI_COMMAND,
+	pci_write_config_word(rinfo->gpu_info->pdev, PCI_COMMAND,
 			      rinfo->cfg_save[PCI_COMMAND/4]);
 	return 1;
 }
 
-
-int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+int radeonfb_gpu_suspend(struct device *dev, pm_message_t state)
 {
-        struct fb_info *info = pci_get_drvdata(pdev);
-        struct radeonfb_info *rinfo = info->par;
+	struct gpu_device *gdev = to_gpu_device(dev);
+	struct fb_info *info = gpu_get_drvdata(gdev);
+	struct radeonfb_info *rinfo = info->par;
+	struct pci_dev *pdev = rinfo->gpu_info->pdev;
 	int i;
 
 	if (state.event == pdev->dev.power.power_state.event)
@@ -2581,7 +2582,7 @@ #endif /* CONFIG_PPC_PMAC */
 		mdelay(50);
 		radeon_pm_save_regs(rinfo, 1);
 
-		if (rinfo->is_mobility && !(rinfo->pm_mode & radeon_pm_d2)) {
+		if (rinfo->gpu_info->is_mobility && !(rinfo->pm_mode & radeon_pm_d2)) {
 			/* Switch off LVDS interface */
 			mdelay(1);
 			OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) & ~(LVDS_BL_MOD_EN));
@@ -2610,10 +2611,12 @@ #endif /* CONFIG_PPC_PMAC */
 	return 0;
 }
 
-int radeonfb_pci_resume(struct pci_dev *pdev)
+int radeonfb_gpu_resume(struct device *dev)
 {
-        struct fb_info *info = pci_get_drvdata(pdev);
-        struct radeonfb_info *rinfo = info->par;
+	struct gpu_device *gdev = to_gpu_device(dev);
+	struct fb_info *info = gpu_get_drvdata(gdev);
+	struct radeonfb_info *rinfo = info->par;
+	struct pci_dev *pdev = rinfo->gpu_info->pdev;
 	int rc = 0;
 
 	if (pdev->dev.power.power_state.event == PM_EVENT_ON)
@@ -2716,7 +2719,7 @@ #endif /* CONFIG_PM */
 void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk)
 {
 	/* Find PM registers in config space if any*/
-	rinfo->pm_reg = pci_find_capability(rinfo->pdev, PCI_CAP_ID_PM);
+	rinfo->pm_reg = pci_find_capability(rinfo->gpu_info->pdev, PCI_CAP_ID_PM);
 
 	/* Enable/Disable dynamic clocks: TODO add sysfs access */
 	rinfo->dynclk = dynclk;
@@ -2737,17 +2740,17 @@ #if defined(CONFIG_PM)
 	 */
 	/* Special case for Samsung P35 laptops
 	 */
-	if ((rinfo->pdev->vendor == PCI_VENDOR_ID_ATI) &&
-	    (rinfo->pdev->device == PCI_CHIP_RV350_NP) &&
-	    (rinfo->pdev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG) &&
-	    (rinfo->pdev->subsystem_device == 0xc00c)) {
+	if ((rinfo->gpu_info->pdev->vendor == PCI_VENDOR_ID_ATI) &&
+	    (rinfo->gpu_info->pdev->device == PCI_CHIP_RV350_NP) &&
+	    (rinfo->gpu_info->pdev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG) &&
+	    (rinfo->gpu_info->pdev->subsystem_device == 0xc00c)) {
 		rinfo->reinit_func = radeon_reinitialize_M10;
 		rinfo->pm_mode |= radeon_pm_off;
 	}
 #if defined(CONFIG_PPC_PMAC)
 	if (machine_is(powermac) && rinfo->of_node) {
-		if (rinfo->is_mobility && rinfo->pm_reg &&
-		    rinfo->family <= CHIP_FAMILY_RV250)
+		if (rinfo->gpu_info->is_mobility && rinfo->pm_reg &&
+		    rinfo->gpu_info->family <= CHIP_FAMILY_RV250)
 			rinfo->pm_mode |= radeon_pm_d2;
 
 		/* We can restart Jasper (M10 chip in albooks), BlueStone (7500 chip
diff --git a/drivers/video/aty/radeonfb.h b/drivers/video/aty/radeonfb.h
index 38657b2..2fa4ed3 100644
--- a/drivers/video/aty/radeonfb.h
+++ b/drivers/video/aty/radeonfb.h
@@ -20,6 +20,8 @@ #ifdef CONFIG_PPC_OF
 #include <asm/prom.h>
 #endif
 
+#include <linux/gpu_layer.h>
+#include <linux/radeon_gpu.h>
 #include <video/radeon.h>
 
 /***************************************************************
@@ -27,65 +29,6 @@ #include <video/radeon.h>
  ***************************************************************/
 
 
-/*
- * Chip families. Must fit in the low 16 bits of a long word
- */
-enum radeon_family {
-	CHIP_FAMILY_UNKNOW,
-	CHIP_FAMILY_LEGACY,
-	CHIP_FAMILY_RADEON,
-	CHIP_FAMILY_RV100,
-	CHIP_FAMILY_RS100,    /* U1 (IGP320M) or A3 (IGP320)*/
-	CHIP_FAMILY_RV200,
-	CHIP_FAMILY_RS200,    /* U2 (IGP330M/340M/350M) or A4 (IGP330/340/345/350),
-				 RS250 (IGP 7000) */
-	CHIP_FAMILY_R200,
-	CHIP_FAMILY_RV250,
-	CHIP_FAMILY_RS300,    /* Radeon 9000 IGP */
-	CHIP_FAMILY_RV280,
-	CHIP_FAMILY_R300,
-	CHIP_FAMILY_R350,
-	CHIP_FAMILY_RV350,
-	CHIP_FAMILY_RV380,    /* RV370/RV380/M22/M24 */
-	CHIP_FAMILY_R420,     /* R420/R423/M18 */
-	CHIP_FAMILY_LAST,
-};
-
-#define IS_RV100_VARIANT(rinfo) (((rinfo)->family == CHIP_FAMILY_RV100)  || \
-				 ((rinfo)->family == CHIP_FAMILY_RV200)  || \
-				 ((rinfo)->family == CHIP_FAMILY_RS100)  || \
-				 ((rinfo)->family == CHIP_FAMILY_RS200)  || \
-				 ((rinfo)->family == CHIP_FAMILY_RV250)  || \
-				 ((rinfo)->family == CHIP_FAMILY_RV280)  || \
-				 ((rinfo)->family == CHIP_FAMILY_RS300))
-
-
-#define IS_R300_VARIANT(rinfo) (((rinfo)->family == CHIP_FAMILY_R300)  || \
-				((rinfo)->family == CHIP_FAMILY_RV350) || \
-				((rinfo)->family == CHIP_FAMILY_R350)  || \
-				((rinfo)->family == CHIP_FAMILY_RV380) || \
-				((rinfo)->family == CHIP_FAMILY_R420))
-
-/*
- * Chip flags
- */
-enum radeon_chip_flags {
-	CHIP_FAMILY_MASK	= 0x0000ffffUL,
-	CHIP_FLAGS_MASK		= 0xffff0000UL,
-	CHIP_IS_MOBILITY	= 0x00010000UL,
-	CHIP_IS_IGP		= 0x00020000UL,
-	CHIP_HAS_CRTC2		= 0x00040000UL,	
-};
-
-/*
- * Errata workarounds
- */
-enum radeon_errata {
-	CHIP_ERRATA_R300_CG		= 0x00000001,
-	CHIP_ERRATA_PLL_DUMMYREADS	= 0x00000002,
-	CHIP_ERRATA_PLL_DELAY		= 0x00000004,
-};
-
 
 /*
  * Monitor types
@@ -276,20 +219,18 @@ enum radeon_pm_mode {
 struct radeonfb_info {
 	struct fb_info		*info;
 
+	struct radeon_gpu_info  *gpu_info;
 	struct radeon_regs 	state;
 	struct radeon_regs	init_state;
 
+	struct gpu_device       *gdev;
 	char			name[DEVICE_NAME_SIZE];
 
-	unsigned long		mmio_base_phys;
-	unsigned long		fb_base_phys;
-
 	void __iomem		*mmio_base;
 	void __iomem		*fb_base;
 
 	unsigned long		fb_local_base;
 
-	struct pci_dev		*pdev;
 #ifdef CONFIG_PPC_OF
 	struct device_node	*of_node;
 #endif
@@ -301,10 +242,6 @@ #endif
 	struct { u8 red, green, blue, pad; }
 				palette[256];
 
-	int			chipset;
-	u8			family;
-	u8			rev;
-	unsigned int		errata;
 	unsigned long		video_ram;
 	unsigned long		mapped_vram;
 	int			vram_width;
@@ -312,9 +249,6 @@ #endif
 
 	int			pitch, bpp, depth;
 
-	int			has_CRTC2;
-	int			is_mobility;
-	int			is_IGP;
 	int			reversed_DAC;
 	int			reversed_TMDS;
 	struct panel_info	panel_info;
@@ -435,7 +369,7 @@ #define OUTREGP(addr,val,mask)	_OUTREGP(
  */
 static inline void radeon_pll_errata_after_index(struct radeonfb_info *rinfo)
 {
-	if (!(rinfo->errata & CHIP_ERRATA_PLL_DUMMYREADS))
+	if (!(rinfo->gpu_info->errata & CHIP_ERRATA_PLL_DUMMYREADS))
 		return;
 
 	(void)INREG(CLOCK_CNTL_DATA);
@@ -444,11 +378,11 @@ static inline void radeon_pll_errata_aft
 
 static inline void radeon_pll_errata_after_data(struct radeonfb_info *rinfo)
 {
-	if (rinfo->errata & CHIP_ERRATA_PLL_DELAY) {
+	if (rinfo->gpu_info->errata & CHIP_ERRATA_PLL_DELAY) {
 		/* we can't deal with posted writes here ... */
 		_radeon_msleep(rinfo, 5);
 	}
-	if (rinfo->errata & CHIP_ERRATA_R300_CG) {
+	if (rinfo->gpu_info->errata & CHIP_ERRATA_R300_CG) {
 		u32 save, tmp;
 		save = INREG(CLOCK_CNTL_INDEX);
 		tmp = save & ~(0x3f | PLL_WR_EN);
@@ -598,8 +532,8 @@ extern void radeon_delete_i2c_busses(str
 extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid);
 
 /* PM Functions */
-extern int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state);
-extern int radeonfb_pci_resume(struct pci_dev *pdev);
+extern int radeonfb_gpu_suspend(struct device *dev, pm_message_t state);
+extern int radeonfb_gpu_resume(struct device *dev);
 extern void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk);
 extern void radeonfb_pm_exit(struct radeonfb_info *rinfo);
 
-- 
1.4.1.ga3e6

