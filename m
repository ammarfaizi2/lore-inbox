Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268183AbTALADs>; Sat, 11 Jan 2003 19:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268186AbTALADr>; Sat, 11 Jan 2003 19:03:47 -0500
Received: from r2n112.mistral.cz ([62.245.77.112]:15488 "EHLO ppc.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S268183AbTALADq>;
	Sat, 11 Jan 2003 19:03:46 -0500
Date: Sun, 12 Jan 2003 01:11:46 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: marcelo@conectiva.com.br
Cc: deller@gmx.de, lkml <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk
Subject: [PATCH] non-G450/G550 build of matroxfb in 2.4.21-pre3 (was Re: Linux 2.4.21-pre3)
Message-ID: <20030112001146.GB1650@ppc.vc.cvut.cz>
References: <Pine.LNX.4.50L.0301061932140.8257-100000@freak.distro.conectiva> <200301112315.11415.deller@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301112315.11415.deller@gmx.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2003 at 11:15:11PM +0100, Helge Deller wrote:
> On Monday 06 January 2003 22:32, Marcelo Tosatti wrote:
> > So here goes -pre3...
> 
> depmod: *** Unresolved symbols in /lib/modules/2.4.21-pre3/kernel/drivers/video/matrox/matroxfb_DAC1064.o
> depmod:         g450_mnp2f
> depmod:         matroxfb_g450_setpll_cond
> depmod:         matroxfb_g450_setclk

Hi Marcelo,
  please apply patch below.

Use g450/g550 related code only if we are building driver supporting
g450/g550. Otherwise we end up with couple of undefined symbols
related to the G450 PLL.

					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz

diff -urdN linux/drivers/video/matrox/matroxfb_DAC1064.c linux/drivers/video/matrox/matroxfb_DAC1064.c
--- linux/drivers/video/matrox/matroxfb_DAC1064.c	2003-01-12 00:43:23.000000000 +0100
+++ linux/drivers/video/matrox/matroxfb_DAC1064.c	2003-01-12 00:55:38.000000000 +0100
@@ -276,6 +276,7 @@
 	hw->MXoptionReg = mx;
 }
 
+#ifdef CONFIG_FB_MATROX_G450
 static void g450_set_plls(WPMINFO2) {
 	u_int32_t c2_ctl;
 	unsigned int pxc;
@@ -365,6 +366,7 @@
 		}
 	}
 }
+#endif
 
 void DAC1064_global_init(WPMINFO2) {
 	struct matrox_hw_state* hw = &ACCESS_FBINFO(hw);
@@ -372,6 +374,7 @@
 	hw->DACreg[POS1064_XMISCCTRL] &= M1064_XMISCCTRL_DAC_WIDTHMASK;
 	hw->DACreg[POS1064_XMISCCTRL] |= M1064_XMISCCTRL_LUT_EN;
 	hw->DACreg[POS1064_XPIXCLKCTRL] = M1064_XPIXCLKCTRL_PLL_UP | M1064_XPIXCLKCTRL_EN | M1064_XPIXCLKCTRL_SRC_PLL;
+#ifdef CONFIG_FB_MATROX_G450
 	if (ACCESS_FBINFO(devflags.g450dac)) {
 		hw->DACreg[POS1064_XPWRCTRL] = 0x1F;	/* powerup everything */
 		hw->DACreg[POS1064_XOUTPUTCONN] = 0x00;	/* disable outputs */
@@ -420,7 +423,9 @@
 		}
 		/* Now set timming related variables... */
 		g450_set_plls(PMINFO2);
-	} else {
+	} else
+#endif
+	{
 		if (ACCESS_FBINFO(outputs[1]).src == MATROXFB_SRC_CRTC1) {
 			hw->DACreg[POS1064_XPIXCLKCTRL] = M1064_XPIXCLKCTRL_PLL_UP | M1064_XPIXCLKCTRL_EN | M1064_XPIXCLKCTRL_SRC_EXT;
 			hw->DACreg[POS1064_XMISCCTRL] |= GX00_XMISCCTRL_MFC_MAFC | G400_XMISCCTRL_VDO_MAFC12;
@@ -622,6 +627,7 @@
 	.compute = m1064_compute,
 };
 
+#ifdef CONFIG_FB_MATROX_G450
 static int g450_compute(void* out, struct my_timming* m) {
 #define minfo ((struct matrox_fb_info*)out)
 	if (m->mnp < 0) {
@@ -639,6 +645,7 @@
 	.name	 = "Primary output",
 	.compute = g450_compute,
 };
+#endif
 
 #endif /* NEED_DAC1064 */
 
@@ -821,6 +828,7 @@
 #endif
 
 #ifdef CONFIG_FB_MATROX_G100
+#ifdef CONFIG_FB_MATROX_G450
 static void g450_mclk_init(WPMINFO2) {
 	/* switch all clocks to PCI source */
 	pci_write_config_dword(ACCESS_FBINFO(pcidev), PCI_OPTION_REG, ACCESS_FBINFO(hw).MXoptionReg | 4);
@@ -938,6 +946,10 @@
 	
 	return;
 }
+#else
+static inline void g450_preinit(WPMINFO2) {
+}
+#endif
 
 static int MGAG100_preinit(WPMINFO2) {
 	static const int vxres_g100[] = {  512,        640, 768,  800,  832,  960,
@@ -975,9 +987,12 @@
 	ACCESS_FBINFO(capable.plnwt) = ACCESS_FBINFO(devflags.accelerator) == FB_ACCEL_MATROX_MGAG100
 			? ACCESS_FBINFO(devflags.sgram) : 1;
 
+#ifdef CONFIG_FB_MATROX_G450
 	if (ACCESS_FBINFO(devflags.g450dac)) {
 		ACCESS_FBINFO(outputs[0]).output = &g450out;
-	} else {
+	} else
+#endif
+	{
 		ACCESS_FBINFO(outputs[0]).output = &m1064;
 	}
 	ACCESS_FBINFO(outputs[0]).src = MATROXFB_SRC_CRTC1;
