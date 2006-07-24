Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWGXQwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWGXQwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 12:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWGXQwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 12:52:12 -0400
Received: from outbound-kan.frontbridge.com ([63.161.60.23]:1344 "EHLO
	outbound1-kan-R.bigfish.com") by vger.kernel.org with ESMTP
	id S932216AbWGXQwK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 12:52:10 -0400
X-BigFish: V
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH 2/4] [PATCH] gxfb: Fixups for the AMD Geode GX
 framebuffer driver
Date: Mon, 24 Jul 2006 10:56:02 -0600
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       blizzard@redhat.com, dwmw2@redhat.com
Message-ID: <20060724165602.18822.56823.stgit@cosmic.amd.com>
In-Reply-To: <20060724165454.18822.30310.stgit@cosmic.amd.com>
References: <20060724165454.18822.30310.stgit@cosmic.amd.com>
User-Agent: StGIT/0.9
X-OriginalArrivalTime: 24 Jul 2006 16:52:00.0502 (UTC)
 FILETIME=[7B6B9160:01C6AF41]
MIME-Version: 1.0
X-WSS-ID: 68DA253A19S652318-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=fixed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jordan Crouse <jordan.crouse@amd.com>

We cannot assume that the BIOS will be correctly setting up the hardware,
so set some bits in various display registers to enable video output.
Allow an advanced user to specify a frambuffer size, rather then probing
the BIOS.  All of these fixes were prompted by the OLPC effort.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/geode/Kconfig      |   20 ++++++++++++++++++++
 drivers/video/geode/display_gx.c |    7 +++++++
 drivers/video/geode/display_gx.h |    1 +
 drivers/video/geode/gxfb_core.c  |    6 ++++++
 drivers/video/geode/video_gx.c   |   24 +++++++++++++++++++++++-
 drivers/video/geode/video_gx.h   |    7 +++++++
 6 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/drivers/video/geode/Kconfig b/drivers/video/geode/Kconfig
index 4e173ef..5704879 100644
--- a/drivers/video/geode/Kconfig
+++ b/drivers/video/geode/Kconfig
@@ -23,6 +23,26 @@ config FB_GEODE_GX
 
 	  If unsure, say N.
 
+config FB_GEODE_GX_SET_FBSIZE
+	bool "Manually specify the Geode GX framebuffer size"
+	depends on FB_GEODE_GX
+	default n
+	---help---
+	  If you want to manually specify the size of your GX framebuffer,
+	  say Y here, otherwise say N to dynamically probe it.
+	  
+	  Say N unless you know what you are doing.
+
+config FB_GEODE_GX_FBSIZE
+	hex "Size of the GX framebuffer, in bytes"
+	depends on FB_GEODE_GX_SET_FBSIZE
+	default "0x1600000"
+	---help---
+	  Specify the size of the GX framebuffer.  Normally, you will
+	  want this to be MB aligned.  Common values are 0x80000 (8MB)
+	  and 0x1600000 (16MB).  Don't change this unless you know what
+	  you are doing
+
 config FB_GEODE_GX1
 	tristate "AMD Geode GX1 framebuffer support (EXPERIMENTAL)"
 	depends on FB && FB_GEODE && EXPERIMENTAL
diff --git a/drivers/video/geode/display_gx.c b/drivers/video/geode/display_gx.c
index 0245169..7faf62a 100644
--- a/drivers/video/geode/display_gx.c
+++ b/drivers/video/geode/display_gx.c
@@ -21,6 +21,11 @@ #include <asm/delay.h>
 #include "geodefb.h"
 #include "display_gx.h"
 
+#ifdef CONFIG_FB_GEODE_GX_SET_FBSIZE
+unsigned int gx_frame_buffer_size(void) {
+	return CONFIG_FB_GEODE_GX_FBSIZE;
+}
+#else
 unsigned int gx_frame_buffer_size(void)
 {
 	unsigned int val;
@@ -35,6 +40,7 @@ unsigned int gx_frame_buffer_size(void)
 	val = (unsigned int)(inw(0xAC1E)) & 0xFFl;
 	return (val << 19);
 }
+#endif
 
 int gx_line_delta(int xres, int bpp)
 {
@@ -90,6 +96,7 @@ static void gx_set_mode(struct fb_info *
 	writel(((info->var.xres * info->var.bits_per_pixel/8) >> 3) + 2,
 	       par->dc_regs + DC_LINE_SIZE);
 
+
 	/* Enable graphics and video data and unmask address lines. */
 	dcfg |= DC_DCFG_GDEN | DC_DCFG_VDEN | DC_DCFG_A20M | DC_DCFG_A18M;
 
diff --git a/drivers/video/geode/display_gx.h b/drivers/video/geode/display_gx.h
index 41e79f4..e962c76 100644
--- a/drivers/video/geode/display_gx.h
+++ b/drivers/video/geode/display_gx.h
@@ -93,4 +93,5 @@ #define DC_V_SYNC_TIMING   0x58
 #define DC_PAL_ADDRESS 0x70
 #define DC_PAL_DATA    0x74
 
+#define DC_GLIU0_MEM_OFFSET 0x84
 #endif /* !__DISPLAY_GX1_H__ */
diff --git a/drivers/video/geode/gxfb_core.c b/drivers/video/geode/gxfb_core.c
index a454dcb..742fd04 100644
--- a/drivers/video/geode/gxfb_core.c
+++ b/drivers/video/geode/gxfb_core.c
@@ -240,6 +240,12 @@ static int __init gxfb_map_video_memory(
 	if (!info->screen_base)
 		return -ENOMEM;
 
+	/* Set the 16MB aligned base address of the graphics memory region
+	 * in the display controller */
+
+	writel(info->fix.smem_start & 0xFF000000,
+			par->dc_regs + DC_GLIU0_MEM_OFFSET);
+
 	dev_info(&dev->dev, "%d Kibyte of video memory at 0x%lx\n",
 		 info->fix.smem_len / 1024, info->fix.smem_start);
 
diff --git a/drivers/video/geode/video_gx.c b/drivers/video/geode/video_gx.c
index 2b2a788..616ce33 100644
--- a/drivers/video/geode/video_gx.c
+++ b/drivers/video/geode/video_gx.c
@@ -178,7 +178,21 @@ static void gx_set_dclk_frequency(struct
 static void gx_configure_display(struct fb_info *info)
 {
 	struct geodefb_par *par = info->par;
-	u32 dcfg, fp_pm;
+	u32 dcfg, fp_pm, misc;
+
+	/* Set up the MISC register */
+
+	misc = readl(par->vid_regs + GX_MISC);
+
+	/* Power up the DAC */
+	misc &= ~(GX_MISC_A_PWRDN | GX_MISC_DAC_PWRDN);
+
+	/* Disable gamma correction */
+	misc |= GX_MISC_GAM_EN;
+
+	writel(misc, par->vid_regs + GX_MISC);
+
+	/* Write the display configuration */
 
 	dcfg = readl(par->vid_regs + GX_DCFG);
 
@@ -199,9 +213,17 @@ static void gx_configure_display(struct 
 	if (info->var.sync & FB_SYNC_VERT_HIGH_ACT)
 		dcfg |= GX_DCFG_CRT_VSYNC_POL;
 
+	/* Enable the display logic */
+	/* Set up the DACS to blank normally */
+
+	dcfg |= GX_DCFG_CRT_EN | GX_DCFG_DAC_BL_EN;
+
+	/* Enable the external DAC VREF? */
+
 	writel(dcfg, par->vid_regs + GX_DCFG);
 
 	/* Power on flat panel. */
+
 	fp_pm = readl(par->vid_regs + GX_FP_PM);
 	fp_pm |= GX_FP_PM_P;
 	writel(fp_pm, par->vid_regs + GX_FP_PM);
diff --git a/drivers/video/geode/video_gx.h b/drivers/video/geode/video_gx.h
index 2d9211f..238181a 100644
--- a/drivers/video/geode/video_gx.h
+++ b/drivers/video/geode/video_gx.h
@@ -28,6 +28,13 @@ #  define GX_DCFG_VG_CK			0x00100000
 #  define GX_DCFG_GV_GAM		0x00200000
 #  define GX_DCFG_DAC_VREF		0x04000000
 
+/* Geode GX MISC video configuration */
+
+#define GX_MISC 0x50
+#define GX_MISC_GAM_EN     0x00000001
+#define GX_MISC_DAC_PWRDN  0x00000400
+#define GX_MISC_A_PWRDN    0x00000800
+
 /* Geode GX flat panel display control registers */
 #define GX_FP_PM 0x410
 #  define GX_FP_PM_P 0x01000000


