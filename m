Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274006AbRISGQf>; Wed, 19 Sep 2001 02:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274007AbRISGQ0>; Wed, 19 Sep 2001 02:16:26 -0400
Received: from mail.sonytel.be ([193.74.243.200]:34265 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S274006AbRISGQL>;
	Wed, 19 Sep 2001 02:16:11 -0400
Date: Wed, 19 Sep 2001 08:16:21 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] fbdev config fixes
Message-ID: <Pine.GSO.4.21.0109190812220.14079-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Linus,

Fix fbdev config glitches that were introduced recently:
  - Remove selection of CONFIG_FB_ATY_CT_VAIO_LCD (code is not there yet. It
    exists in Alan's tree but is not mature)
  - Remove duplicate CONFIG_{FB_PMAG_BA,FB_PMAGB_B,FB_MAXINE}
  - Add missing initialization calls for pmagbafb, pmagbbfb, maxinefb,
    tx3912fb, and sstfb (code is there, so make it usable)

diff -urN linux-2.4.10-pre11/drivers/video/Config.in geert-2.4.10-pre11/drivers/video/Config.in
--- linux-2.4.10-pre11/drivers/video/Config.in	Thu Sep 13 10:37:07 2001
+++ geert-2.4.10-pre11/drivers/video/Config.in	Tue Sep 18 21:26:29 2001
@@ -135,9 +135,6 @@
 	 if [ "$CONFIG_FB_ATY" != "n" ]; then
 	    bool '    Mach64 GX support (EXPERIMENTAL)' CONFIG_FB_ATY_GX
 	    bool '    Mach64 CT/VT/GT/LT (incl. 3D RAGE) support' CONFIG_FB_ATY_CT
-	       if [ "$CONFIG_FB_ATY_CT" = "y" ]; then
-	          bool '      Sony Vaio C1VE 1024x480 LCD support' CONFIG_FB_ATY_CT_VAIO_LCD
-	       fi
 	 fi
  	 tristate '  ATI Radeon display support (EXPERIMENTAL)' CONFIG_FB_RADEON
 	 tristate '  ATI Rage128 display support (EXPERIMENTAL)' CONFIG_FB_ATY128
@@ -198,13 +195,6 @@
    fi
    if [ "$CONFIG_NINO" = "y" ]; then
       bool '  TMPTX3912/PR31700 frame buffer support' CONFIG_FB_TX3912
-   fi
-   if [ "$CONFIG_DECSTATION" = "y" ]; then
-     if [ "$CONFIG_TC" = "y" ]; then
-       bool '  PMAG-BA TURBOchannel framebuffer support' CONFIG_FB_PMAG_BA
-       bool '  PMAGB-B TURBOchannel framebuffer spport' CONFIG_FB_PMAGB_B
-       bool '  Maxine (Personal DECstation) onboard framebuffer spport' CONFIG_FB_MAXINE
-     fi
    fi
    if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
       tristate '  Virtual Frame Buffer support (ONLY FOR TESTING!)' CONFIG_FB_VIRTUAL
diff -urN linux-2.4.10-pre11/drivers/video/fbmem.c geert-2.4.10-pre11/drivers/video/fbmem.c
--- linux-2.4.10-pre11/drivers/video/fbmem.c	Tue Sep 18 10:52:36 2001
+++ geert-2.4.10-pre11/drivers/video/fbmem.c	Tue Sep 18 21:24:40 2001
@@ -118,12 +118,20 @@
 extern int sisfb_setup(char*);
 extern int stifb_init(void);
 extern int stifb_setup(char*);
+extern int pmagbafb_init(void);
+extern int pmagbafb_setup(char *);
+extern int pmagbbfb_init(void);
+extern int pmagbbfb_setup(char *options, int *ints);
+extern void maxinefb_init(void);
+extern int tx3912fb_init(void);
 extern int radeonfb_init(void);
 extern int radeonfb_setup(char*);
 extern int e1355fb_init(void);
 extern int e1355fb_setup(char*);
 extern int pvr2fb_init(void);
 extern int pvr2fb_setup(char*);
+extern int sstfb_init(void);
+extern int sstfb_setup(char*);
 
 static struct {
 	const char *name;
@@ -268,11 +276,26 @@
 #ifdef CONFIG_FB_HIT
 	{ "hitfb", hitfb_init, NULL },
 #endif
+#ifdef CONFIG_FB_TX3912
+	{ "tx3912", tx3912fb_init, NULL },
+#endif
 #ifdef CONFIG_FB_E1355
 	{ "e1355fb", e1355fb_init, e1355fb_setup },
 #endif
 #ifdef CONFIG_FB_PVR2
 	{ "pvr2", pvr2fb_init, pvr2fb_setup },
+#endif
+#ifdef CONFIG_FB_PMAG_BA
+	{ "pmagbafb", pmagbafb_init, pmagbafb_setup },
+#endif
+#ifdef CONFIG_FB_PMAGB_B
+	{ "pmagbbfb", pmagbbfb_init, pmagbbfb_setup },
+#endif
+#ifdef CONFIG_FB_MAXINE
+	{ "maxinefb", maxinefb_init, NULL },
+#endif
+#ifdef CONFIG_FB_VOODOO1
+	{ "sstfb", sstfb_init, sstfb_setup },
 #endif
 
 	/*

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

