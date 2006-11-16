Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162258AbWKPCvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162258AbWKPCvd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162248AbWKPCv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:51:29 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:6280 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1162258AbWKPCrR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:47:17 -0500
Message-Id: <20061116024823.045613000@sous-sol.org>
References: <20061116024332.124753000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 15 Nov 2006 18:43:55 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, maks@sternwelten.at,
       Wink Saville <wink@saville.com>
Subject: [patch 23/30] Patch for nvidia divide by zero error for 7600 pci-express card
Content-Disposition: inline; filename=patch-for-nvidia-divide-by-zero-error-for-7600-pci-express-card.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Wink Saville <wink@saville.com>

The following patch resolves the divide by zero error I encountered on my
system:

	http://marc.10east.com/?l=linux-fbdev-devel&m=116058257024413&w=2

I accomplished this by merging what I thought was appropriate from:

	http://webcvs.freedesktop.org/xorg/driver/xf86-video-nv/src/

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/video/nvidia/nv_hw.c    |   12 +++++++++---
 drivers/video/nvidia/nv_setup.c |   18 +++++++++++++++++-
 drivers/video/nvidia/nv_type.h  |    1 +
 drivers/video/nvidia/nvidia.c   |   24 ++++++++++++------------
 4 files changed, 39 insertions(+), 16 deletions(-)

--- linux-2.6.18.2.orig/drivers/video/nvidia/nv_hw.c
+++ linux-2.6.18.2/drivers/video/nvidia/nv_hw.c
@@ -145,12 +145,18 @@ static void nvGetClocks(struct nvidia_pa
 
 	if (par->Architecture >= NV_ARCH_40) {
 		pll = NV_RD32(par->PMC, 0x4020);
-		P = (pll >> 16) & 0x03;
+		P = (pll >> 16) & 0x07;
 		pll = NV_RD32(par->PMC, 0x4024);
 		M = pll & 0xFF;
 		N = (pll >> 8) & 0xFF;
-		MB = (pll >> 16) & 0xFF;
-		NB = (pll >> 24) & 0xFF;
+		if (((par->Chipset & 0xfff0) == 0x0290) ||
+				((par->Chipset & 0xfff0) == 0x0390)) {
+			MB = 1;
+			NB = 1;
+		} else {
+			MB = (pll >> 16) & 0xFF;
+			NB = (pll >> 24) & 0xFF;
+		}
 		*MClk = ((N * NB * par->CrystalFreqKHz) / (M * MB)) >> P;
 
 		pll = NV_RD32(par->PMC, 0x4000);
--- linux-2.6.18.2.orig/drivers/video/nvidia/nv_setup.c
+++ linux-2.6.18.2/drivers/video/nvidia/nv_setup.c
@@ -359,6 +359,7 @@ int NVCommonSetup(struct fb_info *info)
 	case 0x0186:
 	case 0x0187:
 	case 0x018D:
+	case 0x0228:
 	case 0x0286:
 	case 0x028C:
 	case 0x0316:
@@ -382,6 +383,10 @@ int NVCommonSetup(struct fb_info *info)
 	case 0x034C:
 	case 0x0160:
 	case 0x0166:
+	case 0x0169:
+	case 0x016B:
+	case 0x016C:
+	case 0x016D:
 	case 0x00C8:
 	case 0x00CC:
 	case 0x0144:
@@ -639,12 +644,23 @@ int NVCommonSetup(struct fb_info *info)
 		par->fpHeight = NV_RD32(par->PRAMDAC, 0x0800) + 1;
 		par->fpSyncs = NV_RD32(par->PRAMDAC, 0x0848) & 0x30000033;
 
-		printk("Panel size is %i x %i\n", par->fpWidth, par->fpHeight);
+		printk("nvidiafb: Panel size is %i x %i\n", par->fpWidth, par->fpHeight);
 	}
 
 	if (monA)
 		info->monspecs = *monA;
 
+	if (!par->FlatPanel || !par->twoHeads)
+		par->FPDither = 0;
+
+	par->LVDS = 0;
+	if (par->FlatPanel && par->twoHeads) {
+		NV_WR32(par->PRAMDAC0, 0x08B0, 0x00010004);
+		if (par->PRAMDAC0[0x08b4] & 1)
+			par->LVDS = 1;
+		printk("nvidiafb: Panel is %s\n", par->LVDS ? "LVDS" : "TMDS");
+	}
+
 	kfree(edidA);
 	kfree(edidB);
 done:
--- linux-2.6.18.2.orig/drivers/video/nvidia/nv_type.h
+++ linux-2.6.18.2/drivers/video/nvidia/nv_type.h
@@ -129,6 +129,7 @@ struct nvidia_par {
 	int fpHeight;
 	int PanelTweak;
 	int paneltweak;
+	int LVDS;
 	int pm_state;
 	u32 crtcSync_read;
 	u32 fpSyncs;
--- linux-2.6.18.2.orig/drivers/video/nvidia/nvidia.c
+++ linux-2.6.18.2/drivers/video/nvidia/nvidia.c
@@ -1145,20 +1145,20 @@ static u32 __devinit nvidia_get_arch(str
 	case 0x0340:		/* GeForceFX 5700 */
 		arch = NV_ARCH_30;
 		break;
-	case 0x0040:
-	case 0x00C0:
-	case 0x0120:
+	case 0x0040:		/* GeForce 6800 */
+	case 0x00C0:		/* GeForce 6800 */
+	case 0x0120:		/* GeForce 6800 */
 	case 0x0130:
-	case 0x0140:
-	case 0x0160:
-	case 0x01D0:
-	case 0x0090:
-	case 0x0210:
-	case 0x0220:
+	case 0x0140:		/* GeForce 6600 */
+	case 0x0160:		/* GeForce 6200 */
+	case 0x01D0:		/* GeForce 7200, 7300, 7400 */
+	case 0x0090:		/* GeForce 7800 */
+	case 0x0210:		/* GeForce 6800 */
+	case 0x0220:		/* GeForce 6200 */
 	case 0x0230:
-	case 0x0240:
-	case 0x0290:
-	case 0x0390:
+	case 0x0240:		/* GeForce 6100 */
+	case 0x0290:		/* GeForce 7900 */
+	case 0x0390:		/* GeForce 7600 */
 		arch = NV_ARCH_40;
 		break;
 	case 0x0020:		/* TNT, TNT2 */

--
