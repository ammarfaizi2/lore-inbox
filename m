Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318162AbSIEVvw>; Thu, 5 Sep 2002 17:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318215AbSIEVvt>; Thu, 5 Sep 2002 17:51:49 -0400
Received: from hermes.domdv.de ([193.102.202.1]:36617 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S318162AbSIEVu5>;
	Thu, 5 Sep 2002 17:50:57 -0400
Message-ID: <3D77B50E.30808@domdv.de>
Date: Thu, 05 Sep 2002 21:48:30 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, geert@linux-m68k.org
Subject: 2.4.20pre5 atyfb patch for ATI Rage Mobility P/M AGP
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060108030706040503040209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060108030706040503040209
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch enables the usage of the ATI framebuffer for the ATI
Rage Mobility of my Gateway Solo 9300 Laptop. I did send this patch to
Geert Uytterhoeven in September 2001 but he doesn't seem interested.
There are, however, more people for which the standard atyfb doesn't
work (garbled display). These reports can be easily found using search
engines. I do hope that this patch enables atyfb for them.
It doesn't matter if this patch is never accepted, it was already
ignored for a year by the maintainer and in a few years the problematic
laptops will be dead anyway...

System info regarding ATI:

lspci output:

01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility 
P/M AGP 2x (rev 64)

System boot info:

atyfb: using auxiliary register aperture
atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SGRAM, 29.498928 MHz 
XTAL, 23
5 MHz PLL, 63 Mhz MCLK
Console: switching to colour frame buffer device 128x48
fb0: ATY Mach64 frame buffer device on PCI
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH



--------------060108030706040503040209
Content-Type: text/plain;
 name="ati-rage-mobility-solo-2.4.20pre5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ati-rage-mobility-solo-2.4.20pre5.patch"

diff -rNu linux/drivers/video/aty/atyfb_base.c linux-custom/drivers/video/aty/atyfb_base.c
--- linux/drivers/video/aty/atyfb_base.c	2002-08-03 02:39:45.000000000 +0200
+++ linux-custom/drivers/video/aty/atyfb_base.c	2002-09-05 15:13:11.000000000 +0200
@@ -359,7 +359,7 @@
     { 0x4c50, 0x4c50, 0x00, 0x00, m64n_ltp_p,   230, 100, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP },
 
     /* 3D RAGE Mobility */
-    { 0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_p,   230,  50, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS },
+    { 0x4c4d, 0x4c4d, 0x00, 0x00, m64n_mob_p,   235,  63, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS | M64F_XL_DLL },
     { 0x4c4e, 0x4c4e, 0x00, 0x00, m64n_mob_a,   230,  50, M64F_GT | M64F_INTEGRATED | M64F_RESET_3D | M64F_GTB_DSP | M64F_MOBIL_BUS },
 #endif /* CONFIG_FB_ATY_CT */
 };
@@ -754,7 +754,10 @@
     aty_set_crtc(info, &par->crtc);
     aty_st_8(CLOCK_CNTL + info->clk_wr_offset, 0, info);
 					/* better call aty_StrobeClock ?? */
-    aty_st_8(CLOCK_CNTL + info->clk_wr_offset, CLOCK_STROBE, info);
+    if (M64_HAS(MOBIL_BUS)&&M64_HAS(XL_DLL))
+	aty_st_8(CLOCK_CNTL + info->clk_wr_offset, CLOCK_STROBE|CLOCK_SEL|CLOCK_DIV, info);
+    else
+	aty_st_8(CLOCK_CNTL + info->clk_wr_offset, CLOCK_STROBE, info);
 
     info->dac_ops->set_dac(info, &par->pll, par->crtc.bpp, accelmode);
     info->pll_ops->set_pll(info, &par->pll);
diff -rNu linux/drivers/video/aty/mach64_ct.c linux-custom/drivers/video/aty/mach64_ct.c
--- linux/drivers/video/aty/mach64_ct.c	2001-07-31 23:43:29.000000000 +0200
+++ linux-custom/drivers/video/aty/mach64_ct.c	2002-09-05 15:13:11.000000000 +0200
@@ -204,6 +204,11 @@
 	    break;
     }
 
+    if (M64_HAS(MOBIL_BUS)&&M64_HAS(XL_DLL)) {
+	pll->pll_ext_cntl |= 0xc8;
+	pll->mclk_fb_div -= 1;
+    }
+
     pll->pll_vclk_cntl = 0x03;	/* VCLK = PLL_VCLK/VCLKx_POST */
     pll->vclk_post_div = vpostdiv;
 }
@@ -250,8 +255,10 @@
 	else
 	    aty_st_pll(DLL_CNTL, 0xa0, info);
 	aty_st_pll(VFC_CNTL, 0x1b, info);
-	aty_st_le32(DSP_CONFIG, pll->ct.dsp_config, info);
-	aty_st_le32(DSP_ON_OFF, pll->ct.dsp_on_off, info);
+	if (!(M64_HAS(MOBIL_BUS)&&M64_HAS(XL_DLL))) {
+	    aty_st_le32(DSP_CONFIG, pll->ct.dsp_config, info);
+	    aty_st_le32(DSP_ON_OFF, pll->ct.dsp_on_off, info);
+	}
     }
 }
 



--------------060108030706040503040209--


