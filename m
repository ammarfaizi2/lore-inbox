Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWGXQwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWGXQwR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWGXQwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:52:17 -0400
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:7625 "EHLO
	outbound2-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932217AbWGXQwQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:52:16 -0400
X-BigFish: V
X-Server-Uuid: 519AC16A-9632-469E-B354-112C592D09E8
From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH 3/4] [PATCH] gxfb: Support flat panel timings
Date: Mon, 24 Jul 2006 10:56:05 -0600
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       blizzard@redhat.com, dwmw2@redhat.com
Message-ID: <20060724165605.18822.96789.stgit@cosmic.amd.com>
In-Reply-To: <20060724165454.18822.30310.stgit@cosmic.amd.com>
References: <20060724165454.18822.30310.stgit@cosmic.amd.com>
User-Agent: StGIT/0.9
X-OriginalArrivalTime: 24 Jul 2006 16:52:02.0565 (UTC)
 FILETIME=[7CA65B50:01C6AF41]
MIME-Version: 1.0
X-WSS-ID: 68DA2538380800878-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=fixed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jordan.crouse@amd.com>

Support TFT panels by correctly setting up the flat panel registers

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/geode/display_gx.h |    4 ++
 drivers/video/geode/gxfb_core.c  |   10 +++++
 drivers/video/geode/video_gx.c   |   76 +++++++++++++++++++++++++++++++++-----
 drivers/video/geode/video_gx.h   |   16 ++++++++
 4 files changed, 95 insertions(+), 11 deletions(-)

diff --git a/drivers/video/geode/display_gx.h b/drivers/video/geode/display_gx.h
index e962c76..ba0ccc8 100644
--- a/drivers/video/geode/display_gx.h
+++ b/drivers/video/geode/display_gx.h
@@ -16,6 +16,10 @@ int gx_line_delta(int xres, int bpp);
 
 extern struct geode_dc_ops gx_dc_ops;
 
+/* MSR that tells us if a TFT or CRT is attached */
+#define GLD_MSR_CONFIG   0xC0002001
+#define GLD_MSR_CONFIG_FMT_FP 0x01
+
 /* Display controller registers */
 
 #define DC_UNLOCK 0x00
diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index 742fd04..1e0d47e 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -308,6 +308,7 @@ static int __init gxfb_probe(struct pci_
 	struct geodefb_par *par;
 	struct fb_info *info;
 	int ret;
+	unsigned long val;
 
 	info = gxfb_init_fbinfo(&pdev->dev);
 	if (!info)
@@ -323,6 +324,15 @@ static int __init gxfb_probe(struct pci_
 		goto err;
 	}
 
+	/* Figure out if this is a TFT or CRT part */
+
+	rdmsrl(GLD_MSR_CONFIG, val);
+
+	if (val & GLD_MSR_CONFIG_FMT_FP)
+		par->enable_crt = 0;
+	else
+		par->enable_crt = 1;
+
 	ret = fb_find_mode(&info->var, info, mode_option,
 			   gx_modedb, ARRAY_SIZE(gx_modedb), NULL, 16);
 	if (ret == 0 || ret == 4) {
diff --git a/drivers/video/geode/video_gx.c b/drivers/video/geode/video_gx.c
index 616ce33..e6a4c70 100644
--- a/drivers/video/geode/video_gx.c
+++ b/drivers/video/geode/video_gx.c
@@ -175,10 +175,62 @@ static void gx_set_dclk_frequency(struct
 	} while (timeout-- && !(dotpll & MSR_GLCP_DOTPLL_LOCK));
 }
 
+static void
+gx_configure_tft(struct fb_info *info) {
+
+	struct geodefb_par *par = info->par;
+	unsigned long val;
+	unsigned long fp;
+
+	/* Set up the DF pad select MSR */
+
+	rdmsrl(GX_VP_MSR_PAD_SELECT, val);
+	val &= ~GX_VP_PAD_SELECT_MASK;
+	val |= GX_VP_PAD_SELECT_TFT;
+	wrmsrl(GX_VP_MSR_PAD_SELECT, val);
+
+	/* Turn off the panel */
+
+	fp = readl(par->vid_regs + GX_FP_PM);
+	fp &= ~GX_FP_PM_P;
+	writel(fp, par->vid_regs + GX_FP_PM);
+
+	/* Set timing 1 */
+
+	fp = readl(par->vid_regs + GX_FP_PT1);
+	fp &= GX_FP_PT1_VSIZE_MASK;
+	fp |= info->var.yres << GX_FP_PT1_VSIZE_SHIFT;
+	writel(fp, par->vid_regs + GX_FP_PT1);
+
+	/* Timing 2 */
+	/* Set bits that are always on for TFT */
+
+	fp = 0x0F100000;
+
+	/* Add sync polarity */
+
+	if (!(info->var.sync & FB_SYNC_VERT_HIGH_ACT))
+		fp |= GX_FP_PT2_VSP;
+
+	if (!(info->var.sync & FB_SYNC_HOR_HIGH_ACT))
+		fp |= GX_FP_PT2_HSP;
+
+	writel(fp, par->vid_regs + GX_FP_PT2);
+
+	/*  Set the dither control */
+	writel(0x70, par->vid_regs + GX_FP_DFC);
+
+	/* Turn on the device */
+
+	fp = readl(par->vid_regs + GX_FP_PM);
+	fp |= GX_FP_PM_P;
+	writel(fp, par->vid_regs + GX_FP_PM);
+}
+
 static void gx_configure_display(struct fb_info *info)
 {
 	struct geodefb_par *par = info->par;
-	u32 dcfg, fp_pm, misc;
+	u32 dcfg, misc;
 
 	/* Set up the MISC register */
 
@@ -222,11 +274,10 @@ static void gx_configure_display(struct 
 
 	writel(dcfg, par->vid_regs + GX_DCFG);
 
-	/* Power on flat panel. */
+	/* Set up the flat panel (if it is enabled) */
 
-	fp_pm = readl(par->vid_regs + GX_FP_PM);
-	fp_pm |= GX_FP_PM_P;
-	writel(fp_pm, par->vid_regs + GX_FP_PM);
+	if (par->enable_crt == 0)
+		gx_configure_tft(info);
 }
 
 static int gx_blank_display(struct fb_info *info, int blank_mode)
@@ -267,12 +318,15 @@ static int gx_blank_display(struct fb_in
 	writel(dcfg, par->vid_regs + GX_DCFG);
 
 	/* Power on/off flat panel. */
-	fp_pm = readl(par->vid_regs + GX_FP_PM);
-	if (blank_mode == FB_BLANK_POWERDOWN)
-		fp_pm &= ~GX_FP_PM_P;
-	else
-		fp_pm |= GX_FP_PM_P;
-	writel(fp_pm, par->vid_regs + GX_FP_PM);
+
+	if (par->enable_crt == 0) {
+		fp_pm = readl(par->vid_regs + GX_FP_PM);
+		if (blank_mode == FB_BLANK_POWERDOWN)
+			fp_pm &= ~GX_FP_PM_P;
+		else
+			fp_pm |= GX_FP_PM_P;
+		writel(fp_pm, par->vid_regs + GX_FP_PM);
+	}
 
 	return 0;
 }
diff --git a/drivers/video/geode/video_gx.h b/drivers/video/geode/video_gx.h
index 238181a..8f1e85b 100644
--- a/drivers/video/geode/video_gx.h
+++ b/drivers/video/geode/video_gx.h
@@ -13,6 +13,11 @@ #define __VIDEO_GX_H__
 
 extern struct geode_vid_ops gx_vid_ops;
 
+/* GX Flatpanel control MSR */
+#define GX_VP_MSR_PAD_SELECT           0x2011
+#define GX_VP_PAD_SELECT_MASK          0x3FFFFFFF
+#define GX_VP_PAD_SELECT_TFT           0x1FFFFFFF
+
 /* Geode GX video processor registers */
 
 #define GX_DCFG		0x0008
@@ -36,9 +41,20 @@ #define GX_MISC_DAC_PWRDN  0x00000400
 #define GX_MISC_A_PWRDN    0x00000800
 
 /* Geode GX flat panel display control registers */
+
+#define GX_FP_PT1 0x0400
+#define GX_FP_PT1_VSIZE_MASK 0x7FF0000
+#define GX_FP_PT1_VSIZE_SHIFT 16
+
+#define GX_FP_PT2 0x408
+#define GX_FP_PT2_VSP (1 << 23)
+#define GX_FP_PT2_HSP (1 << 22)
+
 #define GX_FP_PM 0x410
 #  define GX_FP_PM_P 0x01000000
 
+#define GX_FP_DFC 0x418
+
 /* Geode GX clock control MSRs */
 
 #define MSR_GLCP_SYS_RSTPLL	0x4c000014


