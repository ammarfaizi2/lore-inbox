Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbQLNSzT>; Thu, 14 Dec 2000 13:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130687AbQLNSzJ>; Thu, 14 Dec 2000 13:55:09 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:27143 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129602AbQLNSzC>;
	Thu, 14 Dec 2000 13:55:02 -0500
Date: Thu, 14 Dec 2000 19:20:21 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vuser.vu.union.edu
Subject: [PATCH] G450 support
Message-ID: <20001214192021.B3079@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
  this 20KB patch adds support for Matrox G450. It is very important
to apply this, as G450 uses same PCI ID as G400, but if it is programmed
as G400, PLL never syncs, causing printk() from driver causing deadlock
on console_lock causing ...

  Driver was tested on all G450 I have around (ie. 2), as no-one else
replied to my call-for-testing two weeks ago. It may be caused by total
lack of G450 pieces from Matrox...

  Driver currently supports second head only in monitor mode. I'm not
able to get TV mode to work without datasheet before Christmas, and as
2.4.0 is approaching...

  Patch touches only matroxfb, and all new code is either guarded by
if (g450dac), or by some ifdef, so it should not cause any problem.
Patch is for test13-pre1.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz



diff -urdN linux/Documentation/Configure.help linux/Documentation/Configure.help
--- linux/Documentation/Configure.help	Mon Dec 11 21:42:08 2000
+++ linux/Documentation/Configure.help	Thu Dec 14 17:44:26 2000
@@ -3210,9 +3210,9 @@
 CONFIG_FB_MATROX
   Say Y here if you have a Matrox Millennium, Matrox Millennium II,
   Matrox Mystique, Matrox Mystique 220, Matrox Productiva G100, Matrox
-  Mystique G200, Matrox Millennium G200, Matrox Marvel G200 video or
-  Matrox G400 card in your box. At this time, support for the G100,
-  Mystique G200 and Marvel G200 is untested.
+  Mystique G200, Matrox Millennium G200, Matrox Marvel G200 video,
+  Matrox G400 or G450 card in your box. At this time, support for the G100
+  is untested and support for G450 is highly experimental.
 
   This driver is also available as a module ( = code which can be
   inserted and removed from the running kernel whenever you want).
@@ -3241,13 +3241,13 @@
   packed pixel and 32 bpp packed pixel. You can also use font widths
   different from 8.
 
-Matrox G100/G200/G400 support
+Matrox G100/G200/G400/G450 support
 CONFIG_FB_MATROX_G100
-  Say Y here if you have a Matrox Productiva G100, Matrox Mystique
-  G200, Matrox Marvel G200 or Matrox Millennium G200 video card. If
-  you select "Advanced lowlevel driver options", you should check 8
-  bpp packed pixel, 16 bpp packed pixel, 24 bpp packed pixel and 32
-  bpp packed pixel. You can also use font widths different from 8.
+  Say Y here if you have a Matrox G100, G200, G400 or G450 based
+  video card. If you select "Advanced lowlevel driver options", you 
+  should check 8 bpp packed pixel, 16 bpp packed pixel, 24 bpp packed 
+  pixel and 32 bpp packed pixel. You can also use font widths 
+  different from 8.
 
   If you need support for G400 secondary head, you must first say Y to
   "I2C support" and "I2C bit-banging support" in the character devices
@@ -3270,6 +3270,8 @@
   
 Matrox G400 second head support
 CONFIG_FB_MATROX_MAVEN
+  WARNING !!! This support does not work with G450 !!!
+
   Say Y or M here if you want to use a secondary head (meaning two
   monitors in parallel) on G400 or MGA-TVO add-on on G200. Secondary
   head is not compatible with accelerated XFree 3.3.x SVGA servers -
@@ -3294,6 +3296,30 @@
   painting procedures (the secondary head does not use acceleration
   engine).
   
+  There is no need for enabling 'Matrox multihead support' if you have
+  only one Matrox card in the box.
+
+Matrox G450 second head support
+CONFIG_FB_MATROX_G450
+  Say Y or M here if you want to use a secondary head (meaning two
+  monitors in parallel) on G450.
+
+  If you compile it as module, two modules are created,
+  matroxfb_crtc2.o and matroxfb_g450.o. Both modules are needed if you
+  want two independent display devices.
+
+  The driver starts in monitor mode and currently does not support
+  output in TV modes. You must use the matroxset tool (available
+  at ftp://platan.vc.cvut.cz/pub/linux/matrox-latest) to swap primary
+  and secondary head outputs. Secondary head driver always start in
+  640x480 resolution and you must use fbset to change it.
+
+  Also do not forget that second head supports only 16 and 32 bpp
+  packed pixels, so it is a good idea to compile them into the kernel
+  too. You can use only some font widths, as the driver uses generic
+  painting procedures (the secondary head does not use acceleration
+  engine).
+
   There is no need for enabling 'Matrox multihead support' if you have
   only one Matrox card in the box.
 
diff -urdN linux/drivers/video/Config.in linux/drivers/video/Config.in
--- linux/drivers/video/Config.in	Mon Sep 18 22:15:22 2000
+++ linux/drivers/video/Config.in	Thu Dec 14 17:44:26 2000
@@ -104,13 +104,14 @@
 	 if [ "$CONFIG_FB_MATROX" != "n" ]; then
 	    bool '    Millennium I/II support' CONFIG_FB_MATROX_MILLENIUM
 	    bool '    Mystique support' CONFIG_FB_MATROX_MYSTIQUE
-	    bool '    G100/G200/G400 support' CONFIG_FB_MATROX_G100
+	    bool '    G100/G200/G400/G450 support' CONFIG_FB_MATROX_G100
             if [ "$CONFIG_I2C" != "n" ]; then
 	       dep_tristate '      Matrox I2C support' CONFIG_FB_MATROX_I2C $CONFIG_FB_MATROX $CONFIG_I2C_ALGOBIT
 	       if [ "$CONFIG_FB_MATROX_G100" = "y" ]; then
 	          dep_tristate '      G400 second head support' CONFIG_FB_MATROX_MAVEN $CONFIG_FB_MATROX_I2C
 	       fi
             fi
+            dep_tristate '      G450 second head support' CONFIG_FB_MATROX_G450 $CONFIG_FB_MATROX_G100
 	    bool '    Multihead support' CONFIG_FB_MATROX_MULTIHEAD
 	 fi
 	 tristate '  ATI Mach64 display support (EXPERIMENTAL)' CONFIG_FB_ATY
diff -urdN linux/drivers/video/matrox/Makefile linux/drivers/video/matrox/Makefile
--- linux/drivers/video/matrox/Makefile	Thu Dec 14 17:43:18 2000
+++ linux/drivers/video/matrox/Makefile	Thu Dec 14 17:44:26 2000
@@ -14,6 +14,7 @@
 obj-$(CONFIG_FB_MATROX)           += matroxfb_base.o matroxfb_accel.o matroxfb_DAC1064.o matroxfb_Ti3026.o matroxfb_misc.o
 obj-$(CONFIG_FB_MATROX_I2C)       += i2c-matroxfb.o
 obj-$(CONFIG_FB_MATROX_MAVEN)     += matroxfb_maven.o matroxfb_crtc2.o
+obj-$(CONFIG_FB_MATROX_G450)	  += matroxfb_g450.o matroxfb_crtc2.o
 
 include $(TOPDIR)/Rules.make
 
diff -urdN linux/drivers/video/matrox/matroxfb_DAC1064.c linux/drivers/video/matrox/matroxfb_DAC1064.c
--- linux/drivers/video/matrox/matroxfb_DAC1064.c	Thu Aug 10 19:34:31 2000
+++ linux/drivers/video/matrox/matroxfb_DAC1064.c	Thu Dec 14 17:44:26 2000
@@ -227,15 +227,35 @@
 	DBG("DAC1064_calcclock")
 
 	fvco = PLL_calcclock(PMINFO freq, fmax, in, feed, &p);
-	p = (1 << p) - 1;
-	if (fvco <= 100000)
-		;
-	else if (fvco <= 140000)
-		p |= 0x08;
-	else if (fvco <= 180000)
-		p |= 0x10;
-	else
-		p |= 0x18;
+	
+	if (ACCESS_FBINFO(devflags.g450dac)) {
+		if (fvco <= 300000)		/* 276-324 */
+			;
+		else if (fvco <= 400000)	/* 378-438 */
+			p |= 0x08;
+		else if (fvco <= 550000)	/* 540-567 */
+			p |= 0x10;
+		else if (fvco <= 690000)	/* 675-695 */
+			p |= 0x18;
+		else if (fvco <= 800000)	/* 776-803 */
+			p |= 0x20;
+		else if (fvco <= 891000)	/* 891-891 */
+			p |= 0x28;
+		else if (fvco <= 940000)	/* 931-945 */
+			p |= 0x30;
+		else				/* <959 */
+			p |= 0x38;
+	} else {
+		p = (1 << p) - 1;
+		if (fvco <= 100000)
+			;
+		else if (fvco <= 140000)
+			p |= 0x08;
+		else if (fvco <= 180000)
+			p |= 0x10;
+		else
+			p |= 0x18;
+	}
 	*post = p;
 }
 
@@ -340,15 +360,19 @@
 	hw->DACreg[POS1064_XMISCCTRL] &= M1064_XMISCCTRL_DAC_WIDTHMASK;
 	hw->DACreg[POS1064_XMISCCTRL] |= M1064_XMISCCTRL_LUT_EN;
 	hw->DACreg[POS1064_XPIXCLKCTRL] = M1064_XPIXCLKCTRL_PLL_UP | M1064_XPIXCLKCTRL_EN | M1064_XPIXCLKCTRL_SRC_PLL;
-#if defined(CONFIG_FB_MATROX_MAVEN) || defined(CONFIG_FB_MATROX_MAVEN_MODULE)
+	hw->DACreg[POS1064_XOUTPUTCONN] = 0x01;	/* output #1 enabled */
 	if (ACCESS_FBINFO(output.ph) & MATROXFB_OUTPUT_CONN_SECONDARY) {
-		hw->DACreg[POS1064_XPIXCLKCTRL] = M1064_XPIXCLKCTRL_PLL_UP | M1064_XPIXCLKCTRL_EN | M1064_XPIXCLKCTRL_SRC_EXT;
-		hw->DACreg[POS1064_XMISCCTRL] |= GX00_XMISCCTRL_MFC_MAFC | G400_XMISCCTRL_VDO_MAFC12;
+		if (ACCESS_FBINFO(devflags.g450dac)) {
+			hw->DACreg[POS1064_XPIXCLKCTRL] = M1064_XPIXCLKCTRL_PLL_UP | M1064_XPIXCLKCTRL_EN | M1064_XPIXCLKCTRL_SRC_PLL2;
+			hw->DACreg[POS1064_XOUTPUTCONN] = 0x05;	/* output #1 enabled; CRTC1 connected to output #2 */
+		} else {
+			hw->DACreg[POS1064_XPIXCLKCTRL] = M1064_XPIXCLKCTRL_PLL_UP | M1064_XPIXCLKCTRL_EN | M1064_XPIXCLKCTRL_SRC_EXT;
+			hw->DACreg[POS1064_XMISCCTRL] |= GX00_XMISCCTRL_MFC_MAFC | G400_XMISCCTRL_VDO_MAFC12;
+		}
 	} else if (ACCESS_FBINFO(output.sh) & MATROXFB_OUTPUT_CONN_SECONDARY) {
 		hw->DACreg[POS1064_XMISCCTRL] |= GX00_XMISCCTRL_MFC_MAFC | G400_XMISCCTRL_VDO_C2_MAFC12;
-	} else 
-#endif	
-	if (ACCESS_FBINFO(output.ph) & MATROXFB_OUTPUT_CONN_DFP)
+		hw->DACreg[POS1064_XOUTPUTCONN] = 0x09; /* output #1 enabled; CRTC2 connected to output #2 */
+	} else if (ACCESS_FBINFO(output.ph) & MATROXFB_OUTPUT_CONN_DFP)
 		hw->DACreg[POS1064_XMISCCTRL] |= GX00_XMISCCTRL_MFC_PANELLINK | G400_XMISCCTRL_VDO_MAFC12;
 	else
 		hw->DACreg[POS1064_XMISCCTRL] |= GX00_XMISCCTRL_MFC_DIS;
@@ -363,6 +387,10 @@
 	if (ACCESS_FBINFO(devflags.accelerator) == FB_ACCEL_MATROX_MGAG400) {
 		outDAC1064(PMINFO 0x20, 0x04);
 		outDAC1064(PMINFO 0x1F, 0x00);
+		if (ACCESS_FBINFO(devflags.g450dac)) {
+			outDAC1064(PMINFO M1064_X8B, 0xCC);	/* only matrox know... */
+			outDAC1064(PMINFO M1064_XOUTPUTCONN, hw->DACreg[POS1064_XOUTPUTCONN]);
+		}
 	}
 }
 
@@ -738,7 +766,11 @@
 	DBG("MGAG100_preinit")
 
 	/* there are some instabilities if in_div > 19 && vco < 61000 */
-	ACCESS_FBINFO(features.pll.vco_freq_min) = 62000;
+	if (ACCESS_FBINFO(devflags.g450dac)) {
+		ACCESS_FBINFO(features.pll.vco_freq_min) = 130000;	/* my sample: >118 */
+	} else {
+		ACCESS_FBINFO(features.pll.vco_freq_min) = 62000;
+	}
 	ACCESS_FBINFO(features.pll.ref_freq)	 = 27000;
 	ACCESS_FBINFO(features.pll.feed_div_min) = 7;
 	ACCESS_FBINFO(features.pll.feed_div_max) = 127;
diff -urdN linux/drivers/video/matrox/matroxfb_DAC1064.h linux/drivers/video/matrox/matroxfb_DAC1064.h
--- linux/drivers/video/matrox/matroxfb_DAC1064.h	Mon Dec 11 21:16:53 2000
+++ linux/drivers/video/matrox/matroxfb_DAC1064.h	Thu Dec 14 17:48:47 2000
@@ -63,6 +63,8 @@
 #define      M1064_XPIXCLKCTRL_SRC_PCI		0x00
 #define      M1064_XPIXCLKCTRL_SRC_PLL		0x01
 #define      M1064_XPIXCLKCTRL_SRC_EXT		0x02
+#define	     M1064_XPIXCLKCTRL_SRC_SYS		0x03	/* G200/G400 */
+#define      M1064_XPIXCLKCTRL_SRC_PLL2		0x03	/* G450 */
 #define      M1064_XPIXCLKCTRL_SRC_MASK		0x03
 #define      M1064_XPIXCLKCTRL_EN		0x00
 #define      M1064_XPIXCLKCTRL_DIS		0x04
@@ -132,6 +134,16 @@
 #define M1064_XPIXPLLCP		0x4E
 #define M1064_XPIXPLLSTAT	0x4F
 
+#define M1064_XTVO_IDX		0x87
+#define M1064_XTVO_DATA		0x88
+
+#define M1064_XOUTPUTCONN	0x8A
+#define M1064_X8B		0x8B
+#define M1064_XPIXPLL2STAT	0x8C
+#define M1064_XPIXPLL2P		0x8D
+#define M1064_XPIXPLL2N		0x8E
+#define M1064_XPIXPLL2M		0x8F
+
 enum POS1064 {
 	POS1064_XCURADDL=0, POS1064_XCURADDH, POS1064_XCURCTRL,
 	POS1064_XCURCOL0RED, POS1064_XCURCOL0GREEN, POS1064_XCURCOL0BLUE,
@@ -141,7 +153,8 @@
 	POS1064_XMISCCTRL,
 	POS1064_XGENIOCTRL, POS1064_XGENIODATA, POS1064_XZOOMCTRL, POS1064_XSENSETEST,
 	POS1064_XCRCBITSEL,
-	POS1064_XCOLKEYMASKL, POS1064_XCOLKEYMASKH, POS1064_XCOLKEYL, POS1064_XCOLKEYH };
+	POS1064_XCOLKEYMASKL, POS1064_XCOLKEYMASKH, POS1064_XCOLKEYL, POS1064_XCOLKEYH,
+	POS1064_XOUTPUTCONN };
 
 
 #endif	/* __MATROXFB_DAC1064_H__ */
diff -urdN linux/drivers/video/matrox/matroxfb_base.c linux/drivers/video/matrox/matroxfb_base.c
--- linux/drivers/video/matrox/matroxfb_base.c	Mon Oct  2 03:35:16 2000
+++ linux/drivers/video/matrox/matroxfb_base.c	Thu Dec 14 17:44:26 2000
@@ -1421,12 +1421,15 @@
 #define DEVF_CRTC2		0x0800
 #define DEVF_MAVEN_CAPABLE	0x1000
 #define DEVF_PANELLINK_CAPABLE	0x2000
+#define DEVF_G450DAC		0x4000
 
 #define DEVF_GCORE	(DEVF_VIDEO64BIT | DEVF_SWAPS | DEVF_CROSS4MB | DEVF_DDC_8_2)
 #define DEVF_G2CORE	(DEVF_GCORE | DEVF_ANY_VXRES | DEVF_MAVEN_CAPABLE | DEVF_PANELLINK_CAPABLE)
 #define DEVF_G100	(DEVF_GCORE) /* no doc, no vxres... */
 #define DEVF_G200	(DEVF_G2CORE)
 #define DEVF_G400	(DEVF_G2CORE | DEVF_SUPPORT32MB | DEVF_TEXT16B | DEVF_CRTC2)
+/* if you'll find how to drive DFP... */
+#define DEVF_G450	(DEVF_GCORE | DEVF_ANY_VXRES | DEVF_SUPPORT32MB | DEVF_TEXT16B | DEVF_CRTC2 | DEVF_G450DAC)
 
 static struct board {
 	unsigned short vendor, device, rev, svid, sid;
@@ -1554,18 +1557,24 @@
 		230000,
 		&vbG200,
 		"unknown G200 (AGP)"},
-	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G400_AGP,	0xFF,
+	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G400_AGP,	0x80,
 		PCI_SS_VENDOR_ID_MATROX,	PCI_SS_ID_MATROX_MILLENNIUM_G400_MAX_AGP,
 		DEVF_G400,
 		360000,
 		&vbG400,
 		"Millennium G400 MAX (AGP)"},
-	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G400_AGP,	0xFF,
+	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G400_AGP,	0x80,
 		0,			0,
 		DEVF_G400,
 		300000,
 		&vbG400,
 		"unknown G400 (AGP)"},
+	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_G400_AGP,	0xFF,
+		0,			0,
+		DEVF_G450,
+		500000,		/* ??? vco goes up to 900MHz... */
+		&vbG400,
+		"unknown G450 (AGP)"},
 #endif
 	{0,			0,				0xFF,
 		0,			0,
@@ -1627,7 +1636,7 @@
 		if (dfp)
 			ACCESS_FBINFO(output.ph) |= MATROXFB_OUTPUT_CONN_DFP;
 	}
-
+	ACCESS_FBINFO(devflags.g450dac) = b->flags & DEVF_G450DAC;
 	ACCESS_FBINFO(devflags.textstep) = ACCESS_FBINFO(devflags.vgastep) * ACCESS_FBINFO(devflags.textmode);
 	ACCESS_FBINFO(devflags.textvram) = 65536 / ACCESS_FBINFO(devflags.textmode);
 
diff -urdN linux/drivers/video/matrox/matroxfb_base.h linux/drivers/video/matrox/matroxfb_base.h
--- linux/drivers/video/matrox/matroxfb_base.h	Mon Dec 11 21:16:53 2000
+++ linux/drivers/video/matrox/matroxfb_base.h	Thu Dec 14 17:48:47 2000
@@ -374,7 +374,7 @@
 struct matrox_hw_state {
 	u_int32_t	MXoptionReg;
 	unsigned char	DACclk[6];
-	unsigned char	DACreg[64];
+	unsigned char	DACreg[80];
 	unsigned char	MiscOutReg;
 	unsigned char	DACpal[768];
 	unsigned char	CRTC[25];
@@ -531,6 +531,7 @@
 		unsigned int	ydstorg;	/* offset in bytes from video start to usable memory */
 						/* 0 except for 6MB Millenium */
 		int		memtype;
+		int		g450dac;
 			      } devflags;
 	struct display_switch	dispsw;
 	struct {
diff -urdN linux/drivers/video/matrox/matroxfb_crtc2.c linux/drivers/video/matrox/matroxfb_crtc2.c
--- linux/drivers/video/matrox/matroxfb_crtc2.c	Tue Aug 29 21:09:15 2000
+++ linux/drivers/video/matrox/matroxfb_crtc2.c	Thu Dec 14 17:44:26 2000
@@ -104,9 +104,14 @@
 		tmp |= 0x00000001;	/* enable CRTC2 */
 
 		if (ACCESS_FBINFO(output.sh) & MATROXFB_OUTPUT_CONN_SECONDARY) {
-			tmp |= 0x00000002; /* source from VDOCLK */
-			tmp |= 0xC0000000; /* enable vvidrst & hvidrst */
-			/* MGA TVO is our clock source */
+			if (ACCESS_FBINFO(devflags.g450dac)) {
+				tmp |= 0x00000006; /* source from secondary pixel PLL */
+				/* no vidrst */
+			} else {
+				tmp |= 0x00000002; /* source from VDOCLK */
+				tmp |= 0xC0000000; /* enable vvidrst & hvidrst */
+				/* MGA TVO is our clock source */
+			}
 		} else if (ACCESS_FBINFO(output.sh) & MATROXFB_OUTPUT_CONN_PRIMARY) {
 			tmp |= 0x00000004; /* source from pixclock */
 			/* PIXPLL is our clock source */
diff -urdN linux/drivers/video/matrox/matroxfb_g450.c linux/drivers/video/matrox/matroxfb_g450.c
--- linux/drivers/video/matrox/matroxfb_g450.c	Thu Jan  1 00:00:00 1970
+++ linux/drivers/video/matrox/matroxfb_g450.c	Thu Dec 14 17:44:26 2000
@@ -0,0 +1,201 @@
+#include "matroxfb_g450.h"
+#include "matroxfb_misc.h"
+#include "matroxfb_DAC1064.h"
+#include <linux/matroxfb.h>
+#include <asm/uaccess.h>
+
+static int matroxfb_g450_get_reg(WPMINFO int reg) {
+	int val;
+
+	matroxfb_DAC_lock();
+	val = matroxfb_DAC_in(PMINFO reg);
+	matroxfb_DAC_unlock();
+	return val;
+}
+
+static int matroxfb_g450_set_reg(WPMINFO int reg, int val) {
+	matroxfb_DAC_lock();
+	matroxfb_DAC_out(PMINFO reg, val);
+	matroxfb_DAC_unlock();
+	return 0;
+}
+
+static const struct matrox_pll_features maven_pll = {
+	110000,
+	27000,
+	4, 127,
+	2, 31,
+	3
+};
+
+static void DAC1064_calcclock(unsigned int freq, unsigned int fmax,
+		unsigned int* in, unsigned int* feed, unsigned int* post) {
+	unsigned int fvco;
+	unsigned int p;
+
+	fvco = matroxfb_PLL_calcclock(&maven_pll, freq, fmax, in, feed, &p);
+	/* 0 => 100 ... 275 MHz
+           1 => 243 ... 367 MHz
+           2 => 320 ... 475 MHz
+           3 => 453 ... 556 MHz
+           4 => 540 ... 594 MHz
+           5 => 588 ... 621 MHz
+           6 => 626 ... 637 MHz
+           7 => 631 ... 642 MHz
+
+           As you can see, never choose frequency > 621 MHz, there is unavailable gap...
+           Just to be sure, currently driver uses 110 ... 500 MHz range.
+         */
+	if (fvco <= 260000)
+		;
+	else if (fvco <= 350000)
+		p |= 0x08;
+	else if (fvco <= 460000)
+		p |= 0x10;
+	else if (fvco <= 550000)
+		p |= 0x18;
+	else if (fvco <= 590000)
+		p |= 0x20;
+	else
+		p |= 0x28;
+	*post = p;
+	return;
+}
+
+static inline int matroxfb_g450_compute_timming(struct matroxfb_g450_info* m2info,
+		struct my_timming* mt,
+		struct mavenregs* m) {
+	unsigned int a, b, c;
+
+	DAC1064_calcclock(mt->pixclock, 500000, &a, &b, &c);
+	m->regs[0x80] = a;
+	m->regs[0x81] = b;
+	m->regs[0x82] = c;
+	printk(KERN_DEBUG "PLL: %02X %02X %02X\n", a, b, c);
+	return 0;
+}
+
+static inline int matroxfb_g450_program_timming(struct matroxfb_g450_info* m2info, const struct mavenregs* m) {
+	MINFO_FROM(m2info->primary_dev);
+
+	matroxfb_g450_set_reg(PMINFO M1064_XPIXPLL2M, m->regs[0x81]);
+	matroxfb_g450_set_reg(PMINFO M1064_XPIXPLL2N, m->regs[0x80]);
+	matroxfb_g450_set_reg(PMINFO M1064_XPIXPLL2P, m->regs[0x82]);
+	return 0;
+}
+
+/******************************************************/
+
+static int matroxfb_g450_compute(void* md, struct my_timming* mt, struct matrox_hw_state* mr) {
+	return matroxfb_g450_compute_timming(md, mt, &mr->maven);
+}
+
+static int matroxfb_g450_program(void* md, const struct matrox_hw_state* mr) {
+	return matroxfb_g450_program_timming(md, &mr->maven);
+}
+
+static int matroxfb_g450_start(void* md) {
+	return 0;
+}
+
+static void matroxfb_g450_incuse(void* md) {
+	MOD_INC_USE_COUNT;
+}
+
+static void matroxfb_g450_decuse(void* md) {
+	MOD_DEC_USE_COUNT;
+}
+
+static int matroxfb_g450_set_mode(void* md, u_int32_t arg) {
+	if (arg == MATROXFB_OUTPUT_MODE_MONITOR) {
+		return 1;
+	}
+	return -EINVAL;
+}
+
+static int matroxfb_g450_get_mode(void* md, u_int32_t* arg) {
+	*arg = MATROXFB_OUTPUT_MODE_MONITOR;
+	return 0;
+}
+
+static struct matrox_altout matroxfb_g450_altout = {
+	matroxfb_g450_compute,
+	matroxfb_g450_program,
+	matroxfb_g450_start,
+	matroxfb_g450_incuse,
+	matroxfb_g450_decuse,
+	matroxfb_g450_set_mode,
+	matroxfb_g450_get_mode
+};
+
+static int matroxfb_g450_connect(struct matroxfb_g450_info* m2info) {
+	MINFO_FROM(m2info->primary_dev);
+
+	down_write(&ACCESS_FBINFO(altout.lock));
+	ACCESS_FBINFO(altout.device) = m2info;
+	ACCESS_FBINFO(altout.output) = &matroxfb_g450_altout;
+	up_write(&ACCESS_FBINFO(altout.lock));
+	ACCESS_FBINFO(output.all) |= MATROXFB_OUTPUT_CONN_SECONDARY;
+	return 0;
+}
+
+static void matroxfb_g450_shutdown(struct matroxfb_g450_info* m2info) {
+	MINFO_FROM(m2info->primary_dev);
+	
+	if (MINFO) {
+		ACCESS_FBINFO(output.all) &= ~MATROXFB_OUTPUT_CONN_SECONDARY;
+		ACCESS_FBINFO(output.ph) &= ~MATROXFB_OUTPUT_CONN_SECONDARY;
+		ACCESS_FBINFO(output.sh) &= ~MATROXFB_OUTPUT_CONN_SECONDARY;
+		down_write(&ACCESS_FBINFO(altout.lock));
+		ACCESS_FBINFO(altout.device) = NULL;
+		ACCESS_FBINFO(altout.output) = NULL;
+		up_write(&ACCESS_FBINFO(altout.lock));
+		m2info->primary_dev = NULL;
+	}
+}
+
+/* we do not have __setup() yet */
+static void* matroxfb_g450_probe(struct matrox_fb_info* minfo) {
+	struct matroxfb_g450_info* m2info;
+
+	/* hardware is not G450 incapable... */
+	if (!ACCESS_FBINFO(devflags.g450dac))
+		return NULL;
+	m2info = (struct matroxfb_g450_info*)kmalloc(sizeof(*m2info), GFP_KERNEL);
+	if (!m2info) {
+		printk(KERN_ERR "matroxfb_g450: Not enough memory for G450 DAC control structs\n");
+		return NULL;
+	}
+	memset(m2info, 0, sizeof(*m2info));
+	m2info->primary_dev = MINFO;
+	if (matroxfb_g450_connect(m2info)) {
+		kfree(m2info);
+		printk(KERN_ERR "matroxfb_g450: G450 DAC failed to initialize\n");
+		return NULL;
+	}
+	return m2info;
+}
+
+static void matroxfb_g450_remove(struct matrox_fb_info* minfo, void* g450) {
+	matroxfb_g450_shutdown(g450);
+	kfree(g450);
+}
+
+static struct matroxfb_driver g450 = {
+		name:	"Matrox G450 output #2",
+		probe:	matroxfb_g450_probe,
+		remove:	matroxfb_g450_remove };
+
+static int matroxfb_g450_init(void) {
+	matroxfb_register_driver(&g450);
+	return 0;
+}
+
+static void matroxfb_g450_exit(void) {
+	matroxfb_unregister_driver(&g450);
+}
+
+MODULE_AUTHOR("(c) 2000 Petr Vandrovec <vandrove@vc.cvut.cz>");
+MODULE_DESCRIPTION("Matrox G450 secondary output driver");
+module_init(matroxfb_g450_init);
+module_exit(matroxfb_g450_exit);
diff -urdN linux/drivers/video/matrox/matroxfb_g450.h linux/drivers/video/matrox/matroxfb_g450.h
--- linux/drivers/video/matrox/matroxfb_g450.h	Thu Jan  1 00:00:00 1970
+++ linux/drivers/video/matrox/matroxfb_g450.h	Thu Dec 14 17:48:52 2000
@@ -0,0 +1,11 @@
+#ifndef __MATROXFB_G450_H__
+#define __MATROXFB_G450_H__
+
+#include <linux/ioctl.h>
+#include "matroxfb_base.h"
+
+struct matroxfb_g450_info {
+	struct matrox_fb_info*	primary_dev;
+};
+
+#endif /* __MATROXFB_MAVEN_H__ */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
