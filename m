Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129703AbQKXUoL>; Fri, 24 Nov 2000 15:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129716AbQKXUoC>; Fri, 24 Nov 2000 15:44:02 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:7694 "EHLO zikova.cvut.cz")
        by vger.kernel.org with ESMTP id <S129703AbQKXUnn>;
        Fri, 24 Nov 2000 15:43:43 -0500
Date: Fri, 24 Nov 2000 21:13:33 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: linux-fbdev@vuser.vu.union.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] G450 support for matroxfb
Message-ID: <20001124211333.A29112@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  if there are unhappy owners of Matrox G450, I have gift for them.
Patch below is for 2.4.0-test11, and works on my dualhead G450,
16MB, DDR. 

  Because of there are no specs for this piece of hardware, currently:
(1) BIOS have to initialize hardware. Although chip presents
    itself as G400, there is at least one additional PCI configuration
    register :-( Not talking about completely new RAMDAC portion,
    new memory interface, and so on... Hit them with big stick.
(2) Second head does not work. No spec, no game... Maybe after I
    find some spare time.
(3) DAC is limited to 500MHz. Mine goes up to 959MHz, but without
    datasheet I want to be conservative. It was very hard to get
    this one piece...
(4) Everything is based on my piece of hardware; if it does not work
    for you, complain loudly...

BTW, XF4.0.1e is also very unhappy on this hardware.
					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz



diff -urdN linux/Documentation/Configure.help linux/Documentation/Configure.help
--- linux/Documentation/Configure.help	Sat Nov 18 00:43:42 2000
+++ linux/Documentation/Configure.help	Fri Nov 24 19:24:38 2000
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
diff -urdN linux/drivers/video/Config.in linux/drivers/video/Config.in
--- linux/drivers/video/Config.in	Mon Sep 18 22:15:22 2000
+++ linux/drivers/video/Config.in	Fri Nov 24 19:16:18 2000
@@ -104,7 +104,7 @@
 	 if [ "$CONFIG_FB_MATROX" != "n" ]; then
 	    bool '    Millennium I/II support' CONFIG_FB_MATROX_MILLENIUM
 	    bool '    Mystique support' CONFIG_FB_MATROX_MYSTIQUE
-	    bool '    G100/G200/G400 support' CONFIG_FB_MATROX_G100
+	    bool '    G100/G200/G400/G450 support' CONFIG_FB_MATROX_G100
             if [ "$CONFIG_I2C" != "n" ]; then
 	       dep_tristate '      Matrox I2C support' CONFIG_FB_MATROX_I2C $CONFIG_FB_MATROX $CONFIG_I2C_ALGOBIT
 	       if [ "$CONFIG_FB_MATROX_G100" = "y" ]; then
diff -urdN linux/drivers/video/matrox/matroxfb_DAC1064.c linux/drivers/video/matrox/matroxfb_DAC1064.c
--- linux/drivers/video/matrox/matroxfb_DAC1064.c	Thu Aug 10 19:34:31 2000
+++ linux/drivers/video/matrox/matroxfb_DAC1064.c	Fri Nov 24 19:25:40 2000
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
 
@@ -738,7 +758,11 @@
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
diff -urdN linux/drivers/video/matrox/matroxfb_base.c linux/drivers/video/matrox/matroxfb_base.c
--- linux/drivers/video/matrox/matroxfb_base.c	Mon Oct  2 03:35:16 2000
+++ linux/drivers/video/matrox/matroxfb_base.c	Fri Nov 24 19:13:17 2000
@@ -1421,12 +1421,14 @@
 #define DEVF_CRTC2		0x0800
 #define DEVF_MAVEN_CAPABLE	0x1000
 #define DEVF_PANELLINK_CAPABLE	0x2000
+#define DEVF_G450DAC		0x4000
 
 #define DEVF_GCORE	(DEVF_VIDEO64BIT | DEVF_SWAPS | DEVF_CROSS4MB | DEVF_DDC_8_2)
 #define DEVF_G2CORE	(DEVF_GCORE | DEVF_ANY_VXRES | DEVF_MAVEN_CAPABLE | DEVF_PANELLINK_CAPABLE)
 #define DEVF_G100	(DEVF_GCORE) /* no doc, no vxres... */
 #define DEVF_G200	(DEVF_G2CORE)
 #define DEVF_G400	(DEVF_G2CORE | DEVF_SUPPORT32MB | DEVF_TEXT16B | DEVF_CRTC2)
+#define DEVF_G450	(DEVF_G2CORE | DEVF_SUPPORT32MB | DEVF_TEXT16B | DEVF_CRTC2 | DEVF_G450DAC)
 
 static struct board {
 	unsigned short vendor, device, rev, svid, sid;
@@ -1554,18 +1556,24 @@
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
@@ -1627,7 +1635,7 @@
 		if (dfp)
 			ACCESS_FBINFO(output.ph) |= MATROXFB_OUTPUT_CONN_DFP;
 	}
-
+	ACCESS_FBINFO(devflags.g450dac) = b->flags & DEVF_G450DAC;
 	ACCESS_FBINFO(devflags.textstep) = ACCESS_FBINFO(devflags.vgastep) * ACCESS_FBINFO(devflags.textmode);
 	ACCESS_FBINFO(devflags.textvram) = 65536 / ACCESS_FBINFO(devflags.textmode);
 
diff -urdN linux/drivers/video/matrox/matroxfb_base.h linux/drivers/video/matrox/matroxfb_base.h
--- linux/drivers/video/matrox/matroxfb_base.h	Thu Aug 10 19:34:31 2000
+++ linux/drivers/video/matrox/matroxfb_base.h	Fri Nov 24 19:04:38 2000
@@ -531,6 +531,7 @@
 		unsigned int	ydstorg;	/* offset in bytes from video start to usable memory */
 						/* 0 except for 6MB Millenium */
 		int		memtype;
+		int		g450dac;
 			      } devflags;
 	struct display_switch	dispsw;
 	struct {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
