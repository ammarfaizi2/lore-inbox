Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbTANUFS>; Tue, 14 Jan 2003 15:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbTANUFS>; Tue, 14 Jan 2003 15:05:18 -0500
Received: from poup.poupinou.org ([195.101.94.96]:14087 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S265139AbTANUEk>; Tue, 14 Jan 2003 15:04:40 -0500
Date: Tue, 14 Jan 2003 21:13:28 +0100
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Which FB to use instead of vesafb?
Message-ID: <20030114201328.GB12522@poup.poupinou.org>
References: <20030114173348.GG20592@charite.de> <20030114182556.GB16359@kanoe.ludicrus.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20030114182556.GB16359@kanoe.ludicrus.net>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2003 at 10:25:56AM -0800, Joshua Kwan wrote:
> Try rivafb, but I hear it is broken in 2.5 :)

Sound like to be broken..

> On Tue, Jan 14, 2003 at 06:33:48PM +0100, Ralf Hildebrandt wrote:
> > Which framebuffer works with a:
> > 
> > 01:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 420 Go] (rev a3) (prog-if 00 [VGA])
> >         Subsystem: Toshiba America Info Systems: Unknown device 0001
> >         Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 10
> >         Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
> >         Memory at ec000000 (32-bit, prefetchable) [size=64M]
> >         Memory at ebf80000 (32-bit, prefetchable) [size=512K]
> >         Expansion ROM at <unassigned> [disabled] [size=128K]
> >         Capabilities: <available only to root>
> > 	

There were patch around for 2.4.  Search for Paul Richards on lkml, or
apply this one (Richards version diffed against 2.4.21-pre3).

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rivafb-2.4.diff"

--- linux-2.4/drivers/video/riva/Makefile	2003/01/14 19:08:35	1.1
+++ linux-2.4/drivers/video/riva/Makefile	2003/01/14 19:11:31
@@ -9,7 +9,8 @@
 
 O_TARGET := rivafb.o
 
-obj-y    := fbdev.o riva_hw.o accel.o
-obj-m    := $(O_TARGET)
+export-objs  := fbdev.o
+
+obj-$(CONFIG_FB_RIVA)      := fbdev.o nv_setup.o riva_hw.o accel.o
 
 include $(TOPDIR)/Rules.make
--- linux-2.4/drivers/video/riva/accel.c	2003/01/14 19:08:35	1.1
+++ linux-2.4/drivers/video/riva/accel.c	2003/01/14 19:10:44
@@ -243,10 +243,17 @@
 	setup:		fbcon_riva8_setup,
 	bmove:		fbcon_riva_bmove,
 	clear:		fbcon_riva8_clear,
+#ifdef __BIG_ENDIAN
+	putc:		fbcon_cfb8_putc,
+	putcs:		fbcon_cfb8_putcs,
+	revc:		fbcon_cfb8_revc,
+	clear_margins:	fbcon_cfb8_clear_margins,
+#else
 	putc:		fbcon_riva8_putc,
 	putcs:		fbcon_riva8_putcs,
 	revc:		fbcon_riva8_revc,
 	clear_margins:	fbcon_riva8_clear_margins,
+#endif
 	fontwidthmask:	FONTWIDTHRANGE(4, 16)
 };
 #endif
@@ -346,10 +353,17 @@
 	setup:		fbcon_riva16_setup,
 	bmove:		fbcon_riva_bmove,
 	clear:		fbcon_riva16_clear,
+#ifdef __BIG_ENDIAN
+	putc:		fbcon_cfb16_putc,
+	putcs:		fbcon_cfb16_putcs,
+	revc:		fbcon_cfb16_revc,
+	clear_margins:	fbcon_cfb16_clear_margins,
+#else
 	putc:		fbcon_riva16_putc,
 	putcs:		fbcon_riva16_putcs,
 	revc:		fbcon_riva1632_revc,
 	clear_margins:	fbcon_riva16_clear_margins,
+#endif
 	fontwidthmask:	FONTWIDTHRANGE(4, 16)
 };
 #endif
@@ -420,10 +434,17 @@
 	setup:		fbcon_riva32_setup,
 	bmove:		fbcon_riva_bmove,
 	clear:		fbcon_riva32_clear,
+#ifdef __BIG_ENDIAN
+	putc:		fbcon_cfb32_putc,
+	putcs:		fbcon_cfb32_putcs,
+	revc:		fbcon_cfb32_revc,
+	clear_margins:	fbcon_cfb32_clear_margins,
+#else
 	putc:		fbcon_riva32_putc,
 	putcs:		fbcon_riva32_putcs,
 	revc:		fbcon_riva1632_revc,
 	clear_margins:	fbcon_riva32_clear_margins,
+#endif
 	fontwidthmask:	FONTWIDTHRANGE(4, 16)
 };
 #endif
--- linux-2.4/drivers/video/riva/fbdev.c	2003/01/14 19:08:35	1.1
+++ linux-2.4/drivers/video/riva/fbdev.c	2003/01/14 19:10:44
@@ -14,6 +14,8 @@
  *
  *	Jindrich Makovicka:  Accel code help, hw cursor, mtrr
  *
+ *	Paul Richards:  Bug fixes, updates
+ *
  * Initial template from skeletonfb.c, created 28 Dec 1997 by Geert Uytterhoeven
  * Includes riva_hw.c from nVidia, see copyright below.
  * KGI code provided the basis for state storage, init, and mode switching.
@@ -55,7 +57,7 @@
 
 
 /* version number of this driver */
-#define RIVAFB_VERSION "0.9.3"
+#define RIVAFB_VERSION "0.9.4"
 
 
 
@@ -95,7 +97,11 @@
 #define CURSOR_HIDE_DELAY		(20)
 #define CURSOR_SHOW_DELAY		(3)
 
+#ifdef __BIG_ENDIAN
+#define CURSOR_COLOR		0xff7f
+#else
 #define CURSOR_COLOR		0x7fff
+#endif
 #define TRANSPARENT_COLOR	0x0000
 #define MAX_CURS		32
 
@@ -124,23 +130,43 @@
 	CH_RIVA_128 = 0,
 	CH_RIVA_TNT,
 	CH_RIVA_TNT2,
-	CH_RIVA_UTNT2,	/* UTNT2 */
-	CH_RIVA_VTNT2,	/* VTNT2 */
-	CH_RIVA_UVTNT2,	/* VTNT2 */
-	CH_RIVA_ITNT2,	/* ITNT2 */
+	CH_RIVA_UTNT2,
+	CH_RIVA_VTNT2,
+	CH_RIVA_UVTNT2,
+	CH_RIVA_ITNT2,
 	CH_GEFORCE_SDR,
 	CH_GEFORCE_DDR,
 	CH_QUADRO,
 	CH_GEFORCE2_MX,
+	CH_GEFORCE2_MX2,
+	CH_GEFORCE2_GO,
 	CH_QUADRO2_MXR,
 	CH_GEFORCE2_GTS,
+	CH_GEFORCE2_GTS2,
 	CH_GEFORCE2_ULTRA,
 	CH_QUADRO2_PRO,
-	CH_GEFORCE2_GO,
-        CH_GEFORCE3,
-        CH_GEFORCE3_1,
-        CH_GEFORCE3_2,
-        CH_QUADRO_DDC
+	CH_GEFORCE4_MX_460,
+	CH_GEFORCE4_MX_440,
+	CH_GEFORCE4_MX_420,
+	CH_GEFORCE4_440_GO,
+	CH_GEFORCE4_420_GO,
+	CH_GEFORCE4_420_GO_M32,
+	CH_QUADRO4_500XGL,
+	CH_GEFORCE4_440_GO_M64,
+	CH_QUADRO4_200,
+	CH_QUADRO4_550XGL,
+	CH_QUADRO4_500_GOGL,
+	CH_IGEFORCE2,
+	CH_GEFORCE3,
+	CH_GEFORCE3_1,
+	CH_GEFORCE3_2,
+	CH_QUADRO_DDC,
+	CH_GEFORCE4_TI_4600,
+	CH_GEFORCE4_TI_4400,
+	CH_GEFORCE4_TI_4200,
+	CH_QUADRO4_900XGL,
+	CH_QUADRO4_750XGL,
+	CH_QUADRO4_700XGL
 };
 
 /* directly indexed by riva_chips enum, above */
@@ -155,19 +181,39 @@
 	{ "RIVA-VTNT2", NV_ARCH_04 },
 	{ "RIVA-UVTNT2", NV_ARCH_04 },
 	{ "RIVA-ITNT2", NV_ARCH_04 },
-	{ "GeForce-SDR", NV_ARCH_10},
-	{ "GeForce-DDR", NV_ARCH_10},
-	{ "Quadro", NV_ARCH_10},
-	{ "GeForce2-MX", NV_ARCH_10},
-	{ "Quadro2-MXR", NV_ARCH_10},
-	{ "GeForce2-GTS", NV_ARCH_10},
-	{ "GeForce2-ULTRA", NV_ARCH_10},
-	{ "Quadro2-PRO", NV_ARCH_10},
-        { "GeForce2-Go", NV_ARCH_10},
-        { "GeForce3", NV_ARCH_20}, 
-        { "GeForce3 Ti 200", NV_ARCH_20},
-        { "GeForce3 Ti 500", NV_ARCH_20},
-        { "Quadro DDC", NV_ARCH_20}
+	{ "GeForce-SDR", NV_ARCH_10 },
+	{ "GeForce-DDR", NV_ARCH_10 },
+	{ "Quadro", NV_ARCH_10 },
+	{ "GeForce2-MX", NV_ARCH_10 },
+	{ "GeForce2-MX", NV_ARCH_10 },
+	{ "GeForce2-GO", NV_ARCH_10 },
+	{ "Quadro2-MXR", NV_ARCH_10 },
+	{ "GeForce2-GTS", NV_ARCH_10 },
+	{ "GeForce2-GTS", NV_ARCH_10 },
+	{ "GeForce2-ULTRA", NV_ARCH_10 },
+	{ "Quadro2-PRO", NV_ARCH_10 },
+	{ "GeForce4-MX-460", NV_ARCH_20 },
+	{ "GeForce4-MX-440", NV_ARCH_20 },
+	{ "GeForce4-MX-420", NV_ARCH_20 },
+	{ "GeForce4-440-GO", NV_ARCH_20 },
+	{ "GeForce4-420-GO", NV_ARCH_20 },
+	{ "GeForce4-420-GO-M32", NV_ARCH_20 },
+	{ "Quadro4-500-XGL", NV_ARCH_20 },
+	{ "GeForce4-440-GO-M64", NV_ARCH_20 },
+	{ "Quadro4-200", NV_ARCH_20 },
+	{ "Quadro4-550-XGL", NV_ARCH_20 },
+	{ "Quadro4-500-GOGL", NV_ARCH_20 },
+	{ "GeForce2", NV_ARCH_20 },
+	{ "GeForce3", NV_ARCH_20 }, 
+	{ "GeForce3 Ti 200", NV_ARCH_20 },
+	{ "GeForce3 Ti 500", NV_ARCH_20 },
+	{ "Quadro DDC", NV_ARCH_20 },
+	{ "GeForce4 Ti 4600", NV_ARCH_20 },
+	{ "GeForce4 Ti 4400", NV_ARCH_20 },
+	{ "GeForce4 Ti 4200", NV_ARCH_20 },
+	{ "Quadro4-900-XGL", NV_ARCH_20 },
+	{ "Quadro4-750-XGL", NV_ARCH_20 },
+	{ "Quadro4-700-XGL", NV_ARCH_20 }
 };
 
 static struct pci_device_id rivafb_pci_tbl[] __devinitdata = {
@@ -194,27 +240,63 @@
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_MX,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_MX },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_MX2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_MX },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_MX2 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GO,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_GO },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO2_MXR,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO2_MXR },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GTS,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_GTS },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GTS2,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_GTS },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_GTS2 },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_ULTRA,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_ULTRA },
 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO2_PRO,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO2_PRO },
-        { PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE2_GO,
-          PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE2_GO },
-        { PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3,
-          PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE3 },
-        { PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3_1,
-          PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE3_1 },
-        { PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3_2,
-          PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE3_2 },
-        { PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO_DDC,
-          PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO_DDC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_460,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_MX_460 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_440,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_MX_440 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_420,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_MX_420 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_440_GO,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_440_GO },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_420_GO,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_420_GO },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_420_GO_M32,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_420_GO_M32 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_500XGL,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_500XGL },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_440_GO_M64,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_440_GO_M64 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_200,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_200 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_550XGL,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_550XGL },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_500_GOGL,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_500_GOGL },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_IGEFORCE2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_IGEFORCE2 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE3 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3_1,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE3_1 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE3_2,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE3_2 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO_DDC,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO_DDC },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4600,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_TI_4600 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4400,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_TI_4400 },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4200,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_GEFORCE4_TI_4200 },
+ 	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_900XGL },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_750XGL },
+	{ PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, CH_QUADRO4_700XGL },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, rivafb_pci_tbl);
@@ -271,12 +353,14 @@
 
 /* command line data, set in rivafb_setup() */
 static char fontname[40] __initdata = { 0 };
-static char noaccel __initdata = 0;
-static char nomove = 0;
-static char nohwcursor __initdata = 0;
-static char noblink = 0;
+static int noaccel __initdata = 0;
+static int nomove = 0;
+static int nohwcursor __initdata = 0;
+static int noblink = 0;
+static int flatpanel __initdata = -1; /* Autodetect later */
+static int forceCRTC __initdata = -1;
 #ifdef CONFIG_MTRR
-static char nomtrr __initdata = 0;
+static int nomtrr __initdata = 0;
 #endif
 
 #ifndef MODULE
@@ -438,7 +522,7 @@
 	if (rinfo->cursor->vbl_cnt && --rinfo->cursor->vbl_cnt == 0) {
 		rinfo->cursor->on ^= 1;
 		if (rinfo->cursor->on)
-			*(rinfo->riva.CURSORPOS) = (rinfo->cursor->pos.x & 0xFFFF)
+			rinfo->riva.PRAMDAC[0x0000300/4] = (rinfo->cursor->pos.x & 0xFFFF)
 						   | (rinfo->cursor->pos.y << 16);
 		rinfo->riva.ShowHideCursor(&rinfo->riva, rinfo->cursor->on);
 		if (!noblink)
@@ -639,7 +723,7 @@
 		if (c->last_move_delay <= 1) { /* rapid cursor movement */
 			c->vbl_cnt = CURSOR_SHOW_DELAY;
 		} else {
-			*(rinfo->riva.CURSORPOS) = (x & 0xFFFF) | (y << 16);
+			rinfo->riva.PRAMDAC[0x0000300/4] = (x & 0xFFFF) | (y << 16);
 			rinfo->riva.ShowHideCursor(&rinfo->riva, 1);
 			if (!noblink) c->vbl_cnt = CURSOR_HIDE_DELAY;
 			c->on = 1;
@@ -863,6 +947,7 @@
 	struct riva_regs newmode;
 	int bpp, width, hDisplaySize, hDisplay, hStart,
 	    hEnd, hTotal, height, vDisplay, vStart, vEnd, vTotal, dotClock;
+	int hBlankStart, hBlankEnd, vBlankStart, vBlankEnd;
 
 	/* time to calculate */
 
@@ -878,7 +963,10 @@
 	hEnd = (hDisplaySize + video_mode->right_margin +
 		video_mode->hsync_len) / 8 - 1;
 	hTotal = (hDisplaySize + video_mode->right_margin +
-		  video_mode->hsync_len + video_mode->left_margin) / 8 - 1;
+		  video_mode->hsync_len + video_mode->left_margin) / 8 - 5;
+	hBlankStart = hDisplay;
+	hBlankEnd = hTotal + 4;
+
 	height = video_mode->yres_virtual;
 	vDisplay = video_mode->yres - 1;
 	vStart = video_mode->yres + video_mode->lower_margin - 1;
@@ -886,50 +974,101 @@
 	       video_mode->vsync_len - 1;
 	vTotal = video_mode->yres + video_mode->lower_margin +
 		 video_mode->vsync_len + video_mode->upper_margin + 2;
+	vBlankStart = vDisplay;
+	vBlankEnd = vTotal + 1;
 	dotClock = 1000000000 / video_mode->pixclock;
 
 	memcpy(&newmode, &reg_template, sizeof(struct riva_regs));
 
-	newmode.crtc[0x0] = Set8Bits (hTotal - 4);
+	if (rinfo->FlatPanel) {
+		vStart = vTotal - 3;
+		vEnd = vTotal - 2;
+		vBlankStart = vStart;
+		hStart = hTotal - 3;
+		hEnd = hTotal - 2;
+		hBlankEnd = hTotal + 4;
+	}
+
+	newmode.crtc[0x0] = Set8Bits (hTotal); 
 	newmode.crtc[0x1] = Set8Bits (hDisplay);
-	newmode.crtc[0x2] = Set8Bits (hDisplay);
-	newmode.crtc[0x3] = SetBitField (hTotal, 4: 0, 4:0) | SetBit (7);
+	newmode.crtc[0x2] = Set8Bits (hBlankStart);
+	newmode.crtc[0x3] = SetBitField (hBlankEnd, 4: 0, 4:0) | SetBit (7);
 	newmode.crtc[0x4] = Set8Bits (hStart);
-	newmode.crtc[0x5] = SetBitField (hTotal, 5: 5, 7:7)
+	newmode.crtc[0x5] = SetBitField (hBlankEnd, 5: 5, 7:7)
 		| SetBitField (hEnd, 4: 0, 4:0);
 	newmode.crtc[0x6] = SetBitField (vTotal, 7: 0, 7:0);
 	newmode.crtc[0x7] = SetBitField (vTotal, 8: 8, 0:0)
 		| SetBitField (vDisplay, 8: 8, 1:1)
 		| SetBitField (vStart, 8: 8, 2:2)
-		| SetBitField (vDisplay, 8: 8, 3:3)
+		| SetBitField (vBlankStart, 8: 8, 3:3)
 		| SetBit (4)
 		| SetBitField (vTotal, 9: 9, 5:5)
 		| SetBitField (vDisplay, 9: 9, 6:6)
 		| SetBitField (vStart, 9: 9, 7:7);
-	newmode.crtc[0x9] = SetBitField (vDisplay, 9: 9, 5:5)
+	newmode.crtc[0x9] = SetBitField (vBlankStart, 9: 9, 5:5)
 		| SetBit (6);
 	newmode.crtc[0x10] = Set8Bits (vStart);
 	newmode.crtc[0x11] = SetBitField (vEnd, 3: 0, 3:0)
 		| SetBit (5);
 	newmode.crtc[0x12] = Set8Bits (vDisplay);
-	newmode.crtc[0x13] = ((width / 8) * ((bpp + 1) / 8)) & 0xFF;
-	newmode.crtc[0x15] = Set8Bits (vDisplay);
-	newmode.crtc[0x16] = Set8Bits (vTotal + 1);
+	newmode.crtc[0x13] = (width / 8) * ((bpp + 1) / 8);
+	newmode.crtc[0x15] = Set8Bits (vBlankStart);
+	newmode.crtc[0x16] = Set8Bits (vBlankEnd);
+
+	newmode.ext.screen = SetBitField(hBlankEnd,6:6,4:4)
+		| SetBitField(vBlankStart,10:10,3:3)
+		| SetBitField(vStart,10:10,2:2)
+		| SetBitField(vDisplay,10:10,1:1)
+		| SetBitField(vTotal,10:10,0:0);
+	newmode.ext.horiz  = SetBitField(hTotal,8:8,0:0) 
+		| SetBitField(hDisplay,8:8,1:1)
+		| SetBitField(hBlankStart,8:8,2:2)
+		| SetBitField(hStart,8:8,3:3);
+	newmode.ext.extra  = SetBitField(vTotal,11:11,0:0)
+		| SetBitField(vDisplay,11:11,2:2)
+		| SetBitField(vStart,11:11,4:4)
+		| SetBitField(vBlankStart,11:11,6:6); 
 
+	/* CalcStateExt does this already */
+	/*
 	newmode.ext.bpp = bpp;
 	newmode.ext.width = width;
 	newmode.ext.height = height;
+	*/
+	newmode.ext.interlace = 0xff; /* interlace off */
+
+	if(rinfo->riva.Architecture >= NV_ARCH_10)
+		rinfo->riva.CURSOR = (U032 *)(rinfo->fb_base + rinfo->riva.CursorStart);
 
 	rinfo->riva.CalcStateExt(&rinfo->riva, &newmode.ext, bpp, width,
-				  hDisplaySize, hDisplay, hStart, hEnd,
-				  hTotal, height, vDisplay, vStart, vEnd,
-				  vTotal, dotClock);
+				  hDisplaySize, height, dotClock);
 
+	newmode.ext.scale = rinfo->riva.PRAMDAC[0x00000848/4] & 0xfff000ff;
+	if(rinfo->FlatPanel == 1) {
+		newmode.ext.pixel |= (1 << 7);
+		newmode.ext.scale |= (1 << 8) ;
+	}
+	if(rinfo->SecondCRTC) {
+		newmode.ext.head  = rinfo->riva.PCRTC0[0x00000860/4] & ~0x00001000;
+		newmode.ext.head2 = rinfo->riva.PCRTC0[0x00002860/4] | 0x00001000;
+		newmode.ext.crtcOwner = 3;
+		newmode.ext.pllsel |= 0x20000800;
+		newmode.ext.vpll2 = newmode.ext.vpll;
+	} else if(rinfo->riva.twoHeads) {
+		newmode.ext.head  =  rinfo->riva.PCRTC0[0x00000860/4] | 0x00001000;
+		newmode.ext.head2 =  rinfo->riva.PCRTC0[0x00002860/4] & ~0x00001000;
+		newmode.ext.crtcOwner = 0;
+		newmode.ext.vpll2 = rinfo->riva.PRAMDAC0[0x00000520/4];
+	}
+
+	newmode.ext.cursorConfig = 0x02000100;
 	rinfo->current_state = newmode;
 	riva_load_state(rinfo, &rinfo->current_state);
 
 	rinfo->riva.LockUnlock(&rinfo->riva, 0); /* important for HW cursor */
 	rivafb_download_cursor(rinfo);
+
+	rivafb_blank(0, (struct fb_info *)rinfo);
 }
 
 /**
@@ -992,6 +1131,52 @@
 	return board_list;
 }
 
+/* FIXME */
+
+LIST_HEAD(rivafb_driver_list);
+
+int rivafb_register_driver(struct rivafb_driver *drv)
+{
+	struct rivafb_info *rinfo;
+
+	list_add(&drv->node, &rivafb_driver_list);
+
+	for (rinfo = riva_boards; rinfo; rinfo = rinfo->next) {
+		void *p;
+
+		if (rinfo->drivers_count == RIVAFB_MAX_DRIVERS)
+			continue;
+		p = drv->probe(rinfo);
+		if (p) {
+			rinfo->drivers_data[rinfo->drivers_count] = p;
+			rinfo->drivers_count++;
+		}
+	}
+	return 0;
+}
+
+void rivafb_unregister_driver(struct rivafb_driver *drv)
+{
+	struct rivafb_info *rinfo;
+
+	list_del(&drv->node);
+	for (rinfo = riva_boards; rinfo; rinfo = rinfo->next) {
+		int i;
+
+		for (i = 0; i < rinfo->drivers_count; i++) {
+			if (rinfo->drivers[i] == drv) {
+				if (drv && drv->remove)
+					drv->remove(rinfo, rinfo->drivers_data[i]);
+				rinfo->drivers[i] = rinfo->drivers[--rinfo->drivers_count];
+				rinfo->drivers_data[i] = rinfo->drivers_data[rinfo->drivers_count];
+			} else
+				i++;
+		}
+	}
+}
+
+
+
 /**
  * rivafb_do_maximize - 
  * @rinfo: pointer to rivafb_info object containing info for current riva board
@@ -1780,6 +1965,10 @@
 		fb_find_mode(&rinfo->disp.var, &rinfo->info, mode_option,
 			     NULL, 0, NULL, 8);
 #endif
+	if (rinfo->use_default_var)
+		/* We will use the modified default var */
+		rinfo->disp.var = rivafb_default_var;
+	
 	return 0;
 }
 
@@ -1850,6 +2039,119 @@
 	return 0;
 }
 
+#ifdef CONFIG_ALL_PPC
+static int riva_get_EDID_OF(struct rivafb_info *rinfo)
+{
+	struct device_node *dp;
+	unsigned char *pedid = NULL;
+
+	dp = pci_device_to_OF_node(rinfo->pd);
+	pedid = (unsigned char *)get_property(dp, "EDID,B", 0);
+
+	if (pedid) {
+		rinfo->EDID = pedid;
+		return 1;
+	} else
+		return 0;
+}
+#endif /* CONFIG_ALL_PPC */
+
+static int riva_dfp_parse_EDID(struct rivafb_info *rinfo)
+{
+	unsigned char *block = rinfo->EDID;
+
+	if (!block)
+		return 0;
+
+	/* jump to detailed timing block section */
+	block += 54;
+
+	rinfo->clock = (block[0] + (block[1] << 8));
+	rinfo->panel_xres = (block[2] + ((block[4] & 0xf0) << 4));
+	rinfo->hblank = (block[3] + ((block[4] & 0x0f) << 8));
+	rinfo->panel_yres = (block[5] + ((block[7] & 0xf0) << 4));
+	rinfo->vblank = (block[6] + ((block[7] & 0x0f) << 8));
+	rinfo->hOver_plus = (block[8] + ((block[11] & 0xc0) << 2));
+	rinfo->hSync_width = (block[9] + ((block[11] & 0x30) << 4));
+	rinfo->vOver_plus = ((block[10] >> 4) + ((block[11] & 0x0c) << 2));
+	rinfo->vSync_width = ((block[10] & 0x0f) + ((block[11] & 0x03) << 4));
+	rinfo->interlaced = ((block[17] & 0x80) >> 7);
+	rinfo->synct = ((block[17] & 0x18) >> 3);
+	rinfo->misc = ((block[17] & 0x06) >> 1);
+	rinfo->hAct_high = rinfo->vAct_high = 0;
+	if (rinfo->synct == 3) {
+		if (rinfo->misc & 2)
+			rinfo->hAct_high = 1;
+		if (rinfo->misc & 1)
+			rinfo->vAct_high = 1;
+	}
+
+	printk(KERN_INFO PFX
+			"detected DFP panel size from EDID: %dx%d\n", 
+			rinfo->panel_xres, rinfo->panel_yres);
+
+	rinfo->got_dfpinfo = 1;
+
+	return 1;
+}
+
+static void riva_update_default_var(struct rivafb_info *rinfo)
+{
+	struct fb_var_screeninfo *var = &rivafb_default_var;
+
+        var->xres = rinfo->panel_xres;
+        var->yres = rinfo->panel_yres;
+        var->xres_virtual = rinfo->panel_xres;
+        var->yres_virtual = rinfo->panel_yres;
+        var->xoffset = var->yoffset = 0;
+        var->bits_per_pixel = 8;
+        var->pixclock = 100000000 / rinfo->clock;
+        var->left_margin = (rinfo->hblank - rinfo->hOver_plus - rinfo->hSync_width);
+        var->right_margin = rinfo->hOver_plus;
+        var->upper_margin = (rinfo->vblank - rinfo->vOver_plus - rinfo->vSync_width);
+        var->lower_margin = rinfo->vOver_plus;
+        var->hsync_len = rinfo->hSync_width;
+        var->vsync_len = rinfo->vSync_width;
+        var->sync = 0;
+
+        if (rinfo->synct == 3) {
+                if (rinfo->hAct_high)
+                        var->sync |= FB_SYNC_HOR_HIGH_ACT;
+                if (rinfo->vAct_high)
+                        var->sync |= FB_SYNC_VERT_HIGH_ACT;
+        }
+ 
+        var->vmode = 0;
+        if (rinfo->interlaced)
+                var->vmode |= FB_VMODE_INTERLACED;
+
+	if (!noaccel)
+		var->accel_flags |= FB_ACCELF_TEXT;
+        
+        rinfo->use_default_var = 1;
+}
+
+
+static void riva_get_EDID(struct rivafb_info *rinfo)
+{
+#ifdef CONFIG_ALL_PPC
+	if (!riva_get_EDID_OF(rinfo))
+		printk("rivafb: could not retrieve EDID from OF\n");
+#else
+	/* XXX use other methods later */
+#endif
+}
+
+
+static void riva_get_dfpinfo(struct rivafb_info *rinfo)
+{
+	if (riva_dfp_parse_EDID(rinfo))
+		riva_update_default_var(rinfo);
+
+	if (rinfo->got_dfpinfo == 1) /* if user specified flatpanel, we respect that */
+		rinfo->FlatPanel = 1;
+}
+
 
 
 /* ------------------------------------------------------------------------- *
@@ -1876,10 +2178,37 @@
 	rinfo->drvr_name = rci->name;
 	rinfo->riva.Architecture = rci->arch_rev;
 
+	rinfo->drivers_count = 0;
+	do {
+		int i;
+
+		for (i = 0; i <= RIVAFB_MAX_DRIVERS; i++) {
+			rinfo->drivers[i] = NULL;
+			rinfo->drivers_data[i] = NULL;
+		}
+	} while (0);
+
+	rinfo->Chipset = (pd->vendor << 16) | pd->device;
+	printk(KERN_INFO PFX "nVidia device/chipset %X\n", rinfo->Chipset);
+	
+	rinfo->FlatPanel = flatpanel;
+	if (flatpanel == 1)
+		printk(KERN_INFO PFX "flatpanel support enabled\n");
+	rinfo->forceCRTC = forceCRTC;
+	
 	rinfo->pd = pd;
 	rinfo->base0_region_size = pci_resource_len(pd, 0);
 	rinfo->base1_region_size = pci_resource_len(pd, 1);
 
+	{
+		/* enable IO and mem if not already done */
+		unsigned short cmd;
+
+		pci_read_config_word(pd, PCI_COMMAND, &cmd);
+		cmd |= (PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
+		pci_write_config_word(pd, PCI_COMMAND, cmd);
+	}
+	
 	rinfo->ctrl_base_phys = pci_resource_start(rinfo->pd, 0);
 	rinfo->fb_base_phys = pci_resource_start(rinfo->pd, 1);
 
@@ -1893,79 +2222,59 @@
 				   rinfo->base0_region_size);
 	if (!rinfo->ctrl_base) {
 		printk(KERN_ERR PFX "cannot ioremap MMIO base\n");
-		goto err_out_free_base1;
+		goto err_out_free_base0;
 	}
 	
-	rinfo->riva.EnableIRQ = 0;
-	rinfo->riva.PRAMDAC = (unsigned *)(rinfo->ctrl_base + 0x00680000);
-	rinfo->riva.PFB = (unsigned *)(rinfo->ctrl_base + 0x00100000);
-	rinfo->riva.PFIFO = (unsigned *)(rinfo->ctrl_base + 0x00002000);
-	rinfo->riva.PGRAPH = (unsigned *)(rinfo->ctrl_base + 0x00400000);
-	rinfo->riva.PEXTDEV = (unsigned *)(rinfo->ctrl_base + 0x00101000);
-	rinfo->riva.PTIMER = (unsigned *)(rinfo->ctrl_base + 0x00009000);
-	rinfo->riva.PMC = (unsigned *)(rinfo->ctrl_base + 0x00000000);
-	rinfo->riva.FIFO = (unsigned *)(rinfo->ctrl_base + 0x00800000);
-
-	rinfo->riva.PCIO = (U008 *)(rinfo->ctrl_base + 0x00601000);
-	rinfo->riva.PDIO = (U008 *)(rinfo->ctrl_base + 0x00681000);
-	rinfo->riva.PVIO = (U008 *)(rinfo->ctrl_base + 0x000C0000);
+	riva_get_EDID(rinfo);
 
-	rinfo->riva.IO = (MISCin(rinfo) & 0x01) ? 0x3D0 : 0x3B0;
+	riva_get_dfpinfo(rinfo);
 
-	if (rinfo->riva.Architecture == NV_ARCH_03) {
-		/*
-		 * We have to map the full BASE_1 aperture for Riva128's
-		 * because they use the PRAMIN set in "framebuffer" space
+	switch (rinfo->riva.Architecture) {
+	case NV_ARCH_03:
+		/* Riva128's PRAMIN is in the "framebuffer" space
+		 * Since these cards were never made with more than 8 megabytes
+		 * we can safely allocate this seperately.
 		 */
-		if (!request_mem_region(rinfo->fb_base_phys,
-					rinfo->base1_region_size, "rivafb")) {
-			printk(KERN_ERR PFX "cannot reserve FB region\n");
-			goto err_out_free_base0;
-		}
-	
-		rinfo->fb_base = ioremap(rinfo->fb_base_phys,
-					 rinfo->base1_region_size);
-		if (!rinfo->fb_base) {
-			printk(KERN_ERR PFX "cannot ioremap FB base\n");
+		if (!request_mem_region(rinfo->fb_base_phys + 0x00C00000,
+					 0x00008000, "rivafb")) {
+			printk(KERN_ERR PFX "cannot reserve PRAMIN region\n");
 			goto err_out_iounmap_ctrl;
 		}
-	}
-
-
-	switch (rinfo->riva.Architecture) {
-	case NV_ARCH_03:
-		rinfo->riva.PRAMIN = (unsigned *)(rinfo->fb_base + 0x00C00000);
+		rinfo->riva.PRAMIN = ioremap(rinfo->fb_base_phys + 0x00C00000,
+				 0x00008000);
+		if (!rinfo->riva.PRAMIN) {
+			printk(KERN_ERR PFX "cannot ioremap PRAMIN region\n");
+			goto err_out_free_nv3_pramin;
+		}
 		break;
 	case NV_ARCH_04:
 	case NV_ARCH_10:
 	case NV_ARCH_20:
-		rinfo->riva.PCRTC = (unsigned *)(rinfo->ctrl_base + 0x00600000);
+		rinfo->riva.PCRTC0 = (unsigned *)(rinfo->ctrl_base + 0x00600000);
 		rinfo->riva.PRAMIN = (unsigned *)(rinfo->ctrl_base + 0x00710000);
 		break;
 	}
 
-	RivaGetConfig(&rinfo->riva);
+	riva_common_setup(rinfo);
+
+	if (rinfo->riva.Architecture == NV_ARCH_03) {
+		rinfo->riva.PCRTC = rinfo->riva.PCRTC0 = rinfo->riva.PGRAPH;
+	}
 
 	rinfo->ram_amount = rinfo->riva.RamAmountKBytes * 1024;
 	rinfo->dclk_max = rinfo->riva.MaxVClockFreqKHz * 1000;
 
-	if (rinfo->riva.Architecture != NV_ARCH_03) {
-		/*
-		 * Now the _normal_ chipsets can just map the amount of
-		 * real physical ram instead of the whole aperture
-		 */
-		if (!request_mem_region(rinfo->fb_base_phys,
-					rinfo->ram_amount, "rivafb")) {
-			printk(KERN_ERR PFX "cannot reserve FB region\n");
-			goto err_out_free_base0;
-		}
+	if (!request_mem_region(rinfo->fb_base_phys,
+				rinfo->ram_amount, "rivafb")) {
+		printk(KERN_ERR PFX "cannot reserve FB region\n");
+		goto err_out_iounmap_nv3_pramin;
+	}
 	
-		rinfo->fb_base = ioremap(rinfo->fb_base_phys,
-					 rinfo->ram_amount);
-		if (!rinfo->fb_base) {
-			printk(KERN_ERR PFX "cannot ioremap FB base\n");
-			goto err_out_iounmap_ctrl;
-		}
+	rinfo->fb_base = ioremap(rinfo->fb_base_phys,
+				 rinfo->ram_amount);
+	if (!rinfo->fb_base) {
+		printk(KERN_ERR PFX "cannot ioremap FB base\n");
+		goto err_out_free_base1;
 	}
 
 #ifdef CONFIG_MTRR
@@ -2022,10 +2331,16 @@
 	rivafb_exit_cursor(rinfo);
 /* err_out_iounmap_fb: */
 	iounmap(rinfo->fb_base);
+err_out_free_base1:
+	release_mem_region(rinfo->fb_base_phys, rinfo->ram_amount);
+err_out_iounmap_nv3_pramin:
+	if (rinfo->riva.Architecture == NV_ARCH_03) 
+		iounmap((caddr_t)rinfo->riva.PRAMIN);
+err_out_free_nv3_pramin:
+	if (rinfo->riva.Architecture == NV_ARCH_03)
+		release_mem_region(rinfo->fb_base_phys + 0x00C00000, 0x00008000);
 err_out_iounmap_ctrl:
 	iounmap(rinfo->ctrl_base);
-err_out_free_base1:
-	release_mem_region(rinfo->fb_base_phys, rinfo->base1_region_size);
 err_out_free_base0:
 	release_mem_region(rinfo->ctrl_base_phys, rinfo->base0_region_size);
 err_out_kfree:
@@ -2063,6 +2378,11 @@
 	release_mem_region(board->fb_base_phys,
 			   board->ram_amount);
 
+	if (board->riva.Architecture == NV_ARCH_03) {
+		iounmap((caddr_t)board->riva.PRAMIN);
+		release_mem_region(board->fb_base_phys + 0x00C00000, 0x00008000);
+	}
+	
 	kfree(board);
 
 	pci_set_drvdata(pd, NULL);
@@ -2084,6 +2404,8 @@
 	if (!options || !*options)
 		return 0;
 
+	printk(KERN_DEBUG "rivafb: options = [%s]\n", options);
+
 	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!*this_opt)
 			continue;
@@ -2108,16 +2430,28 @@
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr = 1;
 #endif
+		} else if (!strncmp(this_opt, "forceCRTC", 9)) {
+			char *p;
+			
+			p = this_opt + 9;
+			if (!*p || !*(++p)) continue; 
+			forceCRTC = *p - '0';
+			if (forceCRTC < 0 || forceCRTC > 1) 
+				forceCRTC = -1;
+		} else if (!strncmp(this_opt, "flatpanel", 9)) {
+			flatpanel = 1;
 		} else if (!strncmp(this_opt, "nohwcursor", 10)) {
 			nohwcursor = 1;
-		} else
+		} else {
 			mode_option = this_opt;
+			printk(KERN_INFO "rivafb: mode_option = %s\n", mode_option);
+		}
 	}
 	return 0;
 }
 #endif /* !MODULE */
 
-static struct pci_driver rivafb_driver = {
+static struct pci_driver rivafb_pci_driver = {
 	name:		"rivafb",
 	id_table:	rivafb_pci_tbl,
 	probe:		rivafb_init_one,
@@ -2125,7 +2459,6 @@
 };
 
 
-
 /* ------------------------------------------------------------------------- *
  *
  * modularization
@@ -2138,9 +2471,10 @@
 #ifdef MODULE
 	if (font) strncpy(fontname, font, sizeof(fontname)-1);
 #endif
-	err = pci_module_init(&rivafb_driver);
+	err = pci_module_init(&rivafb_pci_driver);
 	if (err)
 		return err;
+	pci_register_driver(&rivafb_pci_driver);
 	return 0;
 }
 
@@ -2148,7 +2482,7 @@
 #ifdef MODULE
 static void __exit rivafb_exit(void)
 {
-	pci_unregister_driver(&rivafb_driver);
+	pci_unregister_driver(&rivafb_pci_driver);
 }
 
 module_init(rivafb_init);
@@ -2164,6 +2498,11 @@
 MODULE_PARM_DESC(nohwcursor, "Disables hardware cursor (0 or 1=disabled) (default=0)");
 MODULE_PARM(noblink, "i");
 MODULE_PARM_DESC(noblink, "Disables hardware cursor blinking (0 or 1=disabled) (default=0)");
+MODULE_PARM(flatpanel, "i");
+MODULE_PARM_DESC(flatpanel, "Enables experimental flat panel support for some chipsets. (0 or 1=enabled) (default=0)");
+MODULE_PARM(forceCRTC, "i");
+MODULE_PARM_DESC(forceCRTC, "Forces usage of a particular CRTC in case autodetection fails. (0 or 1) (default=autodetect)");
+
 #ifdef CONFIG_MTRR
 MODULE_PARM(nomtrr, "i");
 MODULE_PARM_DESC(nomtrr, "Disables MTRR support (0 or 1=disabled) (default=0)");
@@ -2171,5 +2510,8 @@
 #endif /* MODULE */
 
 MODULE_AUTHOR("Ani Joshi, maintainer");
-MODULE_DESCRIPTION("Framebuffer driver for nVidia Riva 128, TNT, TNT2");
+MODULE_DESCRIPTION("Framebuffer driver for nVidia Riva 128, TNT, TNT2, and the GeForce series");
 MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(rivafb_register_driver);
+EXPORT_SYMBOL(rivafb_unregister_driver);
--- linux-2.4/drivers/video/riva/riva_hw.c	2003/01/14 19:08:35	1.1
+++ linux-2.4/drivers/video/riva/riva_hw.c	2003/01/14 19:39:47
@@ -44,10 +44,14 @@
  * from this source.  -- Jeff Garzik <jgarzik@pobox.com>, 01/Nov/99 
  */
 
-/* $XFree86: xc/programs/Xserver/hw/xfree86/drivers/nv/riva_hw.c,v 1.8 2000/02/08 17:19:11 dawes Exp $ */
+/* $XFree86: xc/programs/Xserver/hw/xfree86/drivers/nv/riva_hw.c,v 1.33 2002/08/05 20:47:06 mvojkovi Exp $ */
 
+#include <linux/pci_ids.h>
+#include <linux/pci.h>
 #include "riva_hw.h"
 #include "riva_tbl.h"
+#include "nv_type.h"
+
 /*
  * This file is an OS-agnostic file used to make RIVA 128 and RIVA TNT
  * operate identically (except TNT has more memory and better 3D quality.
@@ -73,32 +77,39 @@
 {
     return ((chip->Rop->FifoFree < chip->FifoEmptyCount) || (chip->PGRAPH[0x00000700/4] & 0x01));
 }
-static void nv3LockUnlock
+
+static void vgaLockUnlock
 (
     RIVA_HW_INST *chip,
-    int           LockUnlock
+    int           Lock
 )
 {
-    VGA_WR08(chip->PVIO, 0x3C4, 0x06);
-    VGA_WR08(chip->PVIO, 0x3C5, LockUnlock ? 0x99 : 0x57);
+    U008 cr11;
+    VGA_WR08(chip->PCIO, 0x3D4, 0x11);
+    cr11 = VGA_RD08(chip->PCIO, 0x3D5);
+    if(Lock) cr11 |= 0x80;
+    else cr11 &= ~0x80;
+    VGA_WR08(chip->PCIO, 0x3D5, cr11);
 }
-static void nv4LockUnlock
+static void nv3LockUnlock
 (
     RIVA_HW_INST *chip,
-    int           LockUnlock
+    int           Lock
 )
 {
-    VGA_WR08(chip->PCIO, 0x3D4, 0x1F);
-    VGA_WR08(chip->PCIO, 0x3D5, LockUnlock ? 0x99 : 0x57);
+    VGA_WR08(chip->PVIO, 0x3C4, 0x06);
+    VGA_WR08(chip->PVIO, 0x3C5, Lock ? 0x99 : 0x57);
+    vgaLockUnlock(chip, Lock);
 }
-static void nv10LockUnlock
+static void nv4LockUnlock
 (
     RIVA_HW_INST *chip,
-    int           LockUnlock
+    int           Lock
 )
 {
     VGA_WR08(chip->PCIO, 0x3D4, 0x1F);
-    VGA_WR08(chip->PCIO, 0x3D5, LockUnlock ? 0x99 : 0x57);
+    VGA_WR08(chip->PCIO, 0x3D5, Lock ? 0x99 : 0x57);
+    vgaLockUnlock(chip, Lock);
 }
 
 static int ShowHideCursor
@@ -107,13 +118,13 @@
     int           ShowHide
 )
 {
-    int current;
-    current                     =  chip->CurrentState->cursor1;
+    int cursor;
+    cursor                      =  chip->CurrentState->cursor1;
     chip->CurrentState->cursor1 = (chip->CurrentState->cursor1 & 0xFE) |
-	                          (ShowHide & 0x01);
+                                  (ShowHide & 0x01);
     VGA_WR08(chip->PCIO, 0x3D4, 0x31);
     VGA_WR08(chip->PCIO, 0x3D5, chip->CurrentState->cursor1);
-    return (current & 0x01);
+    return (cursor & 0x01);
 }
 
 /****************************************************************************\
@@ -604,7 +615,7 @@
     nv3_sim_state sim_data;
     unsigned int M, N, P, pll, MClk;
     
-    pll = chip->PRAMDAC[0x00000504/4];
+    pll = chip->PRAMDAC0[0x00000504/4]; 
     M = (pll >> 0) & 0xFF; N = (pll >> 8) & 0xFF; P = (pll >> 16) & 0x0F;
     MClk = (N * chip->CrystalFreqKHz / M) >> P;
     sim_data.pix_bpp        = (char)pixelDepth;
@@ -791,10 +802,10 @@
     nv4_sim_state sim_data;
     unsigned int M, N, P, pll, MClk, NVClk, cfg1;
 
-    pll = chip->PRAMDAC[0x00000504/4];
+    pll = chip->PRAMDAC0[0x00000504/4];
     M = (pll >> 0)  & 0xFF; N = (pll >> 8)  & 0xFF; P = (pll >> 16) & 0x0F;
     MClk  = (N * chip->CrystalFreqKHz / M) >> P;
-    pll = chip->PRAMDAC[0x00000500/4];
+    pll = chip->PRAMDAC0[0x00000500/4];
     M = (pll >> 0)  & 0xFF; N = (pll >> 8)  & 0xFF; P = (pll >> 16) & 0x0F;
     NVClk  = (N * chip->CrystalFreqKHz / M) >> P;
     cfg1 = chip->PFB[0x00000204/4];
@@ -1052,10 +1063,10 @@
     nv10_sim_state sim_data;
     unsigned int M, N, P, pll, MClk, NVClk, cfg1;
 
-    pll = chip->PRAMDAC[0x00000504/4];
+    pll = chip->PRAMDAC0[0x00000504/4];
     M = (pll >> 0)  & 0xFF; N = (pll >> 8)  & 0xFF; P = (pll >> 16) & 0x0F;
     MClk  = (N * chip->CrystalFreqKHz / M) >> P;
-    pll = chip->PRAMDAC[0x00000500/4];
+    pll = chip->PRAMDAC0[0x00000500/4];
     M = (pll >> 0)  & 0xFF; N = (pll >> 8)  & 0xFF; P = (pll >> 16) & 0x0F;
     NVClk  = (N * chip->CrystalFreqKHz / M) >> P;
     cfg1 = chip->PFB[0x00000204/4];
@@ -1081,6 +1092,57 @@
     }
 }
 
+static void nForceUpdateArbitrationSettings
+(
+    unsigned      VClk,
+    unsigned      pixelDepth,
+    unsigned     *burst,
+    unsigned     *lwm,
+    RIVA_HW_INST *chip
+)
+{
+    nv10_fifo_info fifo_data;
+    nv10_sim_state sim_data;
+    unsigned int M, N, P, pll, MClk, NVClk;
+    unsigned int uMClkPostDiv;
+    struct pci_dev *dev;
+
+    dev = pci_find_slot(0, 3);
+    pci_read_config_dword(dev, 0x6C, &uMClkPostDiv);
+    uMClkPostDiv = (uMClkPostDiv >> 8) & 0xf;
+
+    if(!uMClkPostDiv) uMClkPostDiv = 4;
+    MClk = 400000 / uMClkPostDiv;
+
+    pll = chip->PRAMDAC0[0x00000500/4];
+    M = (pll >> 0)  & 0xFF; N = (pll >> 8)  & 0xFF; P = (pll >> 16) & 0x0F;
+    NVClk  = (N * chip->CrystalFreqKHz / M) >> P;
+    sim_data.pix_bpp        = (char)pixelDepth;
+    sim_data.enable_video   = 0;
+    sim_data.enable_mp      = 0;
+
+    dev = pci_find_slot(0, 1);
+    pci_read_config_dword(dev, 0x7C, &sim_data.memory_type);
+    sim_data.memory_type    = (sim_data.memory_type >> 12) & 1;
+
+    sim_data.memory_width   = 64;
+    sim_data.mem_latency    = 3;
+    sim_data.mem_aligned    = 1;
+    sim_data.mem_page_miss  = 10;
+    sim_data.gr_during_vid  = 0;
+    sim_data.pclk_khz       = VClk;
+    sim_data.mclk_khz       = MClk;
+    sim_data.nvclk_khz      = NVClk;
+    nv10CalcArbitration(&fifo_data, &sim_data);
+    if (fifo_data.valid)
+    {
+        int  b = fifo_data.graphics_burst_size >> 4;
+        *burst = 0;
+        while (b >>= 1) (*burst)++;
+        *lwm   = fifo_data.graphics_lwm >> 3;
+    }
+}
+
 /****************************************************************************\
 *                                                                            *
 *                          RIVA Mode State Routines                          *
@@ -1093,7 +1155,6 @@
 static int CalcVClock
 (
     int           clockIn,
-    int           double_scan,
     int          *clockOut,
     int          *mOut,
     int          *nOut,
@@ -1109,18 +1170,16 @@
     DeltaOld = 0xFFFFFFFF;
 
     VClk     = (unsigned)clockIn;
-    if (double_scan)
-        VClk *= 2;
     
-    if (chip->CrystalFreqKHz == 14318)
+    if (chip->CrystalFreqKHz == 13500)
     {
-        lowM  = 8;
-        highM = 14 - (chip->Architecture == NV_ARCH_03);
+        lowM  = 7;
+        highM = 13 - (chip->Architecture == NV_ARCH_03);
     }
     else
     {
-        lowM  = 7;
-        highM = 13 - (chip->Architecture == NV_ARCH_03);
+        lowM  = 8;
+        highM = 14 - (chip->Architecture == NV_ARCH_03);
     }                      
 
     highP = 4 - (chip->Architecture == NV_ARCH_03);
@@ -1131,7 +1190,8 @@
         {
             for (M = lowM; M <= highM; M++)
             {
-                N    = (VClk * M / chip->CrystalFreqKHz) << P;
+                N    = (VClk << P) * M / chip->CrystalFreqKHz;
+                if(N <= 255) {
                 Freq = (chip->CrystalFreqKHz * N / M) >> P;
                 if (Freq > VClk)
                     DeltaNew = Freq - VClk;
@@ -1148,6 +1208,7 @@
             }
         }
     }
+    }
     return (DeltaOld != 0xFFFFFFFF);
 }
 /*
@@ -1161,15 +1222,7 @@
     int            bpp,
     int            width,
     int            hDisplaySize,
-    int            hDisplay,
-    int            hStart,
-    int            hEnd,
-    int            hTotal,
     int            height,
-    int            vDisplay,
-    int            vStart,
-    int            vEnd,
-    int            vTotal,
     int            dotClock
 )
 {
@@ -1177,15 +1230,14 @@
     /*
      * Save mode parameters.
      */
-    state->bpp    = bpp;
+    state->bpp    = bpp;    /* this is not bitsPerPixel, it's 8,15,16,32 */
     state->width  = width;
     state->height = height;
     /*
      * Extended RIVA registers.
      */
     pixelDepth = (bpp + 1)/8;
-    CalcVClock(dotClock, hDisplaySize < 512,  /* double scan? */
-               &VClk, &m, &n, &p, chip);
+    CalcVClock(dotClock, &VClk, &m, &n, &p, chip);
 
     switch (chip->Architecture)
     {
@@ -1220,29 +1272,38 @@
             state->repaint1 = hDisplaySize < 1280 ? 0x04 : 0x00;
             break;
         case NV_ARCH_10:
-	case NV_ARCH_20:
-            nv10UpdateArbitrationSettings(VClk, 
+        case NV_ARCH_20:
+            if((chip->Chipset == NV_CHIP_IGEFORCE2) ||
+               (chip->Chipset == NV_CHIP_0x01F0))
+            {
+                nForceUpdateArbitrationSettings(VClk,
+                                          pixelDepth * 8,
+                                         &(state->arbitration0),
+                                         &(state->arbitration1),
+                                          chip);
+            } else {
+                nv10UpdateArbitrationSettings(VClk, 
                                           pixelDepth * 8, 
                                          &(state->arbitration0),
                                          &(state->arbitration1),
                                           chip);
-            state->cursor0  = 0x00;
-            state->cursor1  = 0xFC;
-            state->cursor2  = 0x00000000;
+            }
+            state->cursor0  = 0x80 | (chip->CursorStart >> 17);
+            state->cursor1  = (chip->CursorStart >> 11) << 2;
+            state->cursor2  = chip->CursorStart >> 24;
             state->pllsel   = 0x10000700;
             state->config   = chip->PFB[0x00000200/4];
             state->general  = bpp == 16 ? 0x00101100 : 0x00100100;
             state->repaint1 = hDisplaySize < 1280 ? 0x04 : 0x00;
             break;
     }
+
+    /* Paul Richards: below if block borks things in kernel for some reason */
+    /* if((bpp != 8) && (chip->Architecture != NV_ARCH_03))
+    state->general |= 0x00000030; */
+
     state->vpll     = (p << 16) | (n << 8) | m;
-    state->screen   = ((hTotal   & 0x040) >> 2)
-                    | ((vDisplay & 0x400) >> 7)
-                    | ((vStart   & 0x400) >> 8)
-                    | ((vDisplay & 0x400) >> 9)
-                    | ((vTotal   & 0x400) >> 10);
     state->repaint0 = (((width/8)*pixelDepth) & 0x700) >> 3;
-    state->horiz    = hTotal     < 260 ? 0x00 : 0x01;
     state->pixel    = pixelDepth > 2   ? 3    : pixelDepth;
     state->offset0  =
     state->offset1  =
@@ -1286,7 +1347,7 @@
             chip->Tri05 = (RivaTexturedTriangle05 *)&(chip->FIFO[0x0000E000/4]);
             break;
         case NV_ARCH_10:
-	case NV_ARCH_20:
+        case NV_ARCH_20:
             /*
              * Initialize state for the RivaTriangle3D05 routines.
              */
@@ -1395,7 +1456,13 @@
             chip->PGRAPH[0x0000067C/4] = state->pitch3;
             break;
         case NV_ARCH_10:
-	case NV_ARCH_20:
+        case NV_ARCH_20:
+            if(chip->twoHeads) {
+               VGA_WR08(chip->PCIO, 0x03D4, 0x44);
+               VGA_WR08(chip->PCIO, 0x03D5, state->crtcOwner);
+               chip->LockUnlock(chip, 0);
+            }
+
             LOAD_FIXED_STATE(nv10,PFIFO);
             LOAD_FIXED_STATE(nv10,PRAMIN);
             LOAD_FIXED_STATE(nv10,PGRAPH);
@@ -1425,30 +1492,53 @@
                     break;
             }
 
-	    if (chip->Architecture == NV_ARCH_10) {
-            	chip->PGRAPH[0x00000640/4] = state->offset0;
-            	chip->PGRAPH[0x00000644/4] = state->offset1;
-            	chip->PGRAPH[0x00000648/4] = state->offset2;
-            	chip->PGRAPH[0x0000064C/4] = state->offset3;
-            	chip->PGRAPH[0x00000670/4] = state->pitch0;
-            	chip->PGRAPH[0x00000674/4] = state->pitch1;
-            	chip->PGRAPH[0x00000678/4] = state->pitch2;
-            	chip->PGRAPH[0x0000067C/4] = state->pitch3;
-            	chip->PGRAPH[0x00000680/4] = state->pitch3;
-	    } else {
-		chip->PGRAPH[0x00000820/4] = state->offset0;
-		chip->PGRAPH[0x00000824/4] = state->offset1;
-		chip->PGRAPH[0x00000828/4] = state->offset2;
-		chip->PGRAPH[0x0000082C/4] = state->offset3;
-		chip->PGRAPH[0x00000850/4] = state->pitch0;
-		chip->PGRAPH[0x00000854/4] = state->pitch1;
-		chip->PGRAPH[0x00000858/4] = state->pitch2;
-		chip->PGRAPH[0x0000085C/4] = state->pitch3;
-		chip->PGRAPH[0x00000860/4] = state->pitch3;
-		chip->PGRAPH[0x00000864/4] = state->pitch3;
-		chip->PGRAPH[0x000009A4/4] = chip->PFB[0x00000200/4];
-		chip->PGRAPH[0x000009A8/4] = chip->PFB[0x00000204/4];
-	    }
+            if(chip->Architecture == NV_ARCH_10) {
+                chip->PGRAPH[0x00000640/4] = state->offset0;
+                chip->PGRAPH[0x00000644/4] = state->offset1;
+                chip->PGRAPH[0x00000648/4] = state->offset2;
+                chip->PGRAPH[0x0000064C/4] = state->offset3;
+                chip->PGRAPH[0x00000670/4] = state->pitch0;
+                chip->PGRAPH[0x00000674/4] = state->pitch1;
+                chip->PGRAPH[0x00000678/4] = state->pitch2;
+                chip->PGRAPH[0x0000067C/4] = state->pitch3;
+                chip->PGRAPH[0x00000680/4] = state->pitch3;
+        } else {
+        chip->PGRAPH[0x00000820/4] = state->offset0;
+        chip->PGRAPH[0x00000824/4] = state->offset1;
+        chip->PGRAPH[0x00000828/4] = state->offset2;
+        chip->PGRAPH[0x0000082C/4] = state->offset3;
+        chip->PGRAPH[0x00000850/4] = state->pitch0;
+        chip->PGRAPH[0x00000854/4] = state->pitch1;
+        chip->PGRAPH[0x00000858/4] = state->pitch2;
+        chip->PGRAPH[0x0000085C/4] = state->pitch3;
+        chip->PGRAPH[0x00000860/4] = state->pitch3;
+        chip->PGRAPH[0x00000864/4] = state->pitch3;
+        chip->PGRAPH[0x000009A4/4] = chip->PFB[0x00000200/4];
+        chip->PGRAPH[0x000009A8/4] = chip->PFB[0x00000204/4];
+        }
+            if(chip->twoHeads) {
+               chip->PCRTC0[0x00000860/4] = state->head;
+               chip->PCRTC0[0x00002860/4] = state->head2;
+            }
+            chip->PRAMDAC[0x00000404/4] |= (1 << 25);
+
+            chip->PMC[0x00008704/4] = 1;
+            chip->PMC[0x00008140/4] = 0;
+            chip->PMC[0x00008920/4] = 0;
+            chip->PMC[0x00008924/4] = 0;
+            chip->PMC[0x00008908/4] = 0x01ffffff;
+            chip->PMC[0x0000890C/4] = 0x01ffffff;
+            chip->PMC[0x00001588/4] = 0;
+
+            chip->PFB[0x00000240/4] = 0;
+            chip->PFB[0x00000244/4] = 0;
+            chip->PFB[0x00000248/4] = 0;
+            chip->PFB[0x0000024C/4] = 0;
+            chip->PFB[0x00000250/4] = 0;
+            chip->PFB[0x00000254/4] = 0;
+            chip->PFB[0x00000258/4] = 0;
+            chip->PFB[0x0000025C/4] = 0;
+
             chip->PGRAPH[0x00000B00/4] = chip->PFB[0x00000240/4];
             chip->PGRAPH[0x00000B04/4] = chip->PFB[0x00000244/4];
             chip->PGRAPH[0x00000B08/4] = chip->PFB[0x00000248/4];
@@ -1522,7 +1612,27 @@
             chip->PGRAPH[0x00000F50/4] = 0x00000040;
             for (i = 0; i < 4; i++)
                 chip->PGRAPH[0x00000F54/4] = 0x00000000;
-            break;
+
+            chip->PCRTC[0x00000810/4] = state->cursorConfig;
+
+            if(chip->flatPanel) {
+               if((chip->Chipset & 0x0ff0) == 0x0110) {
+                   chip->PRAMDAC[0x0528/4] = state->dither;
+               } else 
+               if((chip->Chipset & 0x0ff0) >= 0x0170) {
+                   chip->PRAMDAC[0x083C/4] = state->dither;
+               }
+            
+               VGA_WR08(chip->PCIO, 0x03D4, 0x53);
+               VGA_WR08(chip->PCIO, 0x03D5, 0);
+               VGA_WR08(chip->PCIO, 0x03D4, 0x54);
+               VGA_WR08(chip->PCIO, 0x03D5, 0);
+               VGA_WR08(chip->PCIO, 0x03D4, 0x21);
+               VGA_WR08(chip->PCIO, 0x03D5, 0xfa);
+            }
+
+            VGA_WR08(chip->PCIO, 0x03D4, 0x41);
+            VGA_WR08(chip->PCIO, 0x03D5, state->extra);
     }
     LOAD_FIXED_STATE(Riva,FIFO);
     UpdateFifoState(chip);
@@ -1547,15 +1657,26 @@
     VGA_WR08(chip->PCIO, 0x03D5, state->cursor0);
     VGA_WR08(chip->PCIO, 0x03D4, 0x31);
     VGA_WR08(chip->PCIO, 0x03D5, state->cursor1);
-    chip->PRAMDAC[0x00000300/4]  = state->cursor2;
-    chip->PRAMDAC[0x00000508/4]  = state->vpll;
-    chip->PRAMDAC[0x0000050C/4]  = state->pllsel;
+    VGA_WR08(chip->PCIO, 0x03D4, 0x2F);
+    VGA_WR08(chip->PCIO, 0x03D5, state->cursor2);
+    VGA_WR08(chip->PCIO, 0x03D4, 0x39);
+    VGA_WR08(chip->PCIO, 0x03D5, state->interlace);
+
+    if(!chip->flatPanel) {
+       chip->PRAMDAC0[0x00000508/4] = state->vpll;
+       chip->PRAMDAC0[0x0000050C/4] = state->pllsel;
+       if(chip->twoHeads)
+          chip->PRAMDAC0[0x00000520/4] = state->vpll2;
+    }  else {
+       chip->PRAMDAC[0x00000848/4]  = state->scale;
+    }  
     chip->PRAMDAC[0x00000600/4]  = state->general;
+
     /*
      * Turn off VBlank enable and reset.
      */
-    *(chip->VBLANKENABLE) = 0;
-    *(chip->VBLANK)       = chip->VBlankBit;
+    chip->PCRTC[0x00000140/4] = 0;
+    chip->PCRTC[0x00000100/4] = chip->VBlankBit;
     /*
      * Set interrupt enable.
      */    
@@ -1598,10 +1719,15 @@
     state->cursor0      = VGA_RD08(chip->PCIO, 0x03D5);
     VGA_WR08(chip->PCIO, 0x03D4, 0x31);
     state->cursor1      = VGA_RD08(chip->PCIO, 0x03D5);
-    state->cursor2      = chip->PRAMDAC[0x00000300/4];
-    state->vpll         = chip->PRAMDAC[0x00000508/4];
-    state->pllsel       = chip->PRAMDAC[0x0000050C/4];
+    VGA_WR08(chip->PCIO, 0x03D4, 0x2F);
+    state->cursor2      = VGA_RD08(chip->PCIO, 0x03D5);
+    VGA_WR08(chip->PCIO, 0x03D4, 0x39);
+    state->interlace    = VGA_RD08(chip->PCIO, 0x03D5);
+    state->vpll         = chip->PRAMDAC0[0x00000508/4];
+    state->vpll2        = chip->PRAMDAC0[0x00000520/4];
+    state->pllsel       = chip->PRAMDAC0[0x0000050C/4];
     state->general      = chip->PRAMDAC[0x00000600/4];
+    state->scale        = chip->PRAMDAC[0x00000848/4];
     state->config       = chip->PFB[0x00000200/4];
     switch (chip->Architecture)
     {
@@ -1626,7 +1752,7 @@
             state->pitch3   = chip->PGRAPH[0x0000067C/4];
             break;
         case NV_ARCH_10:
-	case NV_ARCH_20:
+        case NV_ARCH_20:
             state->offset0  = chip->PGRAPH[0x00000640/4];
             state->offset1  = chip->PGRAPH[0x00000644/4];
             state->offset2  = chip->PGRAPH[0x00000648/4];
@@ -1635,6 +1761,22 @@
             state->pitch1   = chip->PGRAPH[0x00000674/4];
             state->pitch2   = chip->PGRAPH[0x00000678/4];
             state->pitch3   = chip->PGRAPH[0x0000067C/4];
+            if(chip->twoHeads) {
+               state->head     = chip->PCRTC0[0x00000860/4];
+               state->head2    = chip->PCRTC0[0x00002860/4];
+               VGA_WR08(chip->PCIO, 0x03D4, 0x44);
+               state->crtcOwner = VGA_RD08(chip->PCIO, 0x03D5);
+            }
+            VGA_WR08(chip->PCIO, 0x03D4, 0x41);
+            state->extra = VGA_RD08(chip->PCIO, 0x03D5);
+            state->cursorConfig = chip->PCRTC[0x00000810/4];
+
+            if((chip->Chipset & 0x0ff0) == 0x0110) {
+                state->dither = chip->PRAMDAC[0x0528/4];
+            } else 
+            if((chip->Chipset & 0x0ff0) >= 0x0170) {
+                state->dither = chip->PRAMDAC[0x083C/4];
+            }
             break;
     }
 }
@@ -1644,6 +1786,15 @@
     unsigned      start
 )
 {
+    chip->PCRTC[0x800/4] = start;
+}
+
+static void SetStartAddress3
+(
+    RIVA_HW_INST *chip,
+    unsigned      start
+)
+{
     int offset = start >> 2;
     int pan    = (start & 3) << 1;
     unsigned char tmp;
@@ -1824,11 +1975,8 @@
                 break;
         }
     }        
-    chip->CrystalFreqKHz   = (chip->PEXTDEV[0x00000000/4] & 0x00000020) ? 14318 : 13500;
+    chip->CrystalFreqKHz   = (chip->PEXTDEV[0x00000000/4] & 0x00000040) ? 14318 : 13500;
     chip->CURSOR           = &(chip->PRAMIN[0x00008000/4 - 0x0800/4]);
-    chip->CURSORPOS        = &(chip->PRAMDAC[0x0300/4]);
-    chip->VBLANKENABLE     = &(chip->PGRAPH[0x0140/4]);
-    chip->VBLANK           = &(chip->PGRAPH[0x0100/4]);
     chip->VBlankBit        = 0x00000100;
     chip->MaxVClockFreqKHz = 256000;
     /*
@@ -1839,7 +1987,7 @@
     chip->CalcStateExt    = CalcStateExt;
     chip->LoadStateExt    = LoadStateExt;
     chip->UnloadStateExt  = UnloadStateExt;
-    chip->SetStartAddress = SetStartAddress;
+    chip->SetStartAddress = SetStartAddress3;
     chip->SetSurfaces2D   = nv3SetSurfaces2D;
     chip->SetSurfaces3D   = nv3SetSurfaces3D;
     chip->LockUnlock      = nv3LockUnlock;
@@ -1887,9 +2035,6 @@
     }
     chip->CrystalFreqKHz   = (chip->PEXTDEV[0x00000000/4] & 0x00000040) ? 14318 : 13500;
     chip->CURSOR           = &(chip->PRAMIN[0x00010000/4 - 0x0800/4]);
-    chip->CURSORPOS        = &(chip->PRAMDAC[0x0300/4]);
-    chip->VBLANKENABLE     = &(chip->PCRTC[0x0140/4]);
-    chip->VBLANK           = &(chip->PCRTC[0x0100/4]);
     chip->VBlankBit        = 0x00000001;
     chip->MaxVClockFreqKHz = 350000;
     /*
@@ -1907,38 +2052,57 @@
 }
 static void nv10GetConfig
 (
-    RIVA_HW_INST *chip
+    RIVA_HW_INST *chip,
+    unsigned int chipset
 )
 {
+    struct pci_dev* dev;
+    int amt;
+
+#ifdef __BIG_ENDIAN
+    /* turn on big endian register access */
+    chip->PMC[0x00000004/4] = 0x01000001;
+#endif
+
     /*
      * Fill in chip configuration.
      */
-    switch ((chip->PFB[0x0000020C/4] >> 20) & 0x000000FF)
-    {
-        case 0x02:
-            chip->RamAmountKBytes = 1024 * 2;
-            break;
-        case 0x04:
-            chip->RamAmountKBytes = 1024 * 4;
-            break;
-        case 0x08:
-            chip->RamAmountKBytes = 1024 * 8;
-            break;
-        case 0x10:
-            chip->RamAmountKBytes = 1024 * 16;
-            break;
-        case 0x20:
-            chip->RamAmountKBytes = 1024 * 32;
-            break;
-        case 0x40:
-            chip->RamAmountKBytes = 1024 * 64;
-            break;
-        case 0x80:
-            chip->RamAmountKBytes = 1024 * 128;
-            break;
-        default:
-            chip->RamAmountKBytes = 1024 * 16;
-            break;
+    if(chipset == NV_CHIP_IGEFORCE2) {
+        dev = pci_find_slot(0, 1);
+        pci_read_config_dword(dev, 0x7C, &amt);
+        chip->RamAmountKBytes = (((amt >> 6) & 31) + 1) * 1024;
+    } else if(chipset == NV_CHIP_0x01F0) {
+        dev = pci_find_slot(0, 1);
+        pci_read_config_dword(dev, 0x84, &amt);
+        chip->RamAmountKBytes = (((amt >> 4) & 127) + 1) * 1024;
+    } else {
+        switch ((chip->PFB[0x0000020C/4] >> 20) & 0x000000FF)
+        {
+            case 0x02:
+                chip->RamAmountKBytes = 1024 * 2;
+                break;
+            case 0x04:
+                chip->RamAmountKBytes = 1024 * 4;
+                break;
+            case 0x08:
+                chip->RamAmountKBytes = 1024 * 8;
+                break;
+            case 0x10:
+                chip->RamAmountKBytes = 1024 * 16;
+                break;
+            case 0x20:
+                chip->RamAmountKBytes = 1024 * 32;
+                break;
+            case 0x40:
+                chip->RamAmountKBytes = 1024 * 64;
+                break;
+            case 0x80:
+                chip->RamAmountKBytes = 1024 * 128;
+                break;
+            default:
+                chip->RamAmountKBytes = 1024 * 16;
+                break;
+        }
     }
     switch ((chip->PFB[0x00000000/4] >> 3) & 0x00000003)
     {
@@ -1949,11 +2113,24 @@
             chip->RamBandwidthKBytesPerSec = 1000000;
             break;
     }
-    chip->CrystalFreqKHz   = (chip->PEXTDEV[0x00000000/4] & 0x00000040) ? 14318 : 13500;
-    chip->CURSOR           = &(chip->PRAMIN[0x00010000/4 - 0x0800/4]);
-    chip->CURSORPOS        = &(chip->PRAMDAC[0x0300/4]);
-    chip->VBLANKENABLE     = &(chip->PCRTC[0x0140/4]);
-    chip->VBLANK           = &(chip->PCRTC[0x0100/4]);
+    chip->CrystalFreqKHz = (chip->PEXTDEV[0x0000/4] & (1 << 6)) ? 14318 :
+                                                                  13500;
+
+    switch (chipset & 0x0ff0) {
+    case 0x0170:
+    case 0x0180:
+    case 0x01F0:
+    case 0x0250:
+    case 0x0280:
+       if(chip->PEXTDEV[0x0000/4] & (1 << 22))
+           chip->CrystalFreqKHz = 27000;
+       break;
+    default:
+       break;
+    }
+
+    chip->CursorStart      = (chip->RamAmountKBytes - 128) * 1024;
+    chip->CURSOR           = NULL;  /* can't set this here */
     chip->VBlankBit        = 0x00000001;
     chip->MaxVClockFreqKHz = 350000;
     /*
@@ -1967,11 +2144,26 @@
     chip->SetStartAddress = SetStartAddress;
     chip->SetSurfaces2D   = nv10SetSurfaces2D;
     chip->SetSurfaces3D   = nv10SetSurfaces3D;
-    chip->LockUnlock      = nv10LockUnlock;
+    chip->LockUnlock      = nv4LockUnlock;
+
+    switch(chipset & 0x0ff0) {
+    case 0x0110:
+    case 0x0170:
+    case 0x0180:
+    case 0x01F0:
+    case 0x0250:
+    case 0x0280:
+        chip->twoHeads = TRUE;
+        break;
+    default:
+        chip->twoHeads = FALSE;
+        break;
+    }
 }
 int RivaGetConfig
 (
-    RIVA_HW_INST *chip
+    RIVA_HW_INST *chip,
+    unsigned int chipset
 )
 {
     /*
@@ -1990,12 +2182,13 @@
             nv4GetConfig(chip);
             break;
         case NV_ARCH_10:
-	case NV_ARCH_20:
-            nv10GetConfig(chip);
+        case NV_ARCH_20:
+            nv10GetConfig(chip, chipset);
             break;
         default:
             return (-1);
     }
+    chip->Chipset = chipset;
     /*
      * Fill in FIFO pointers.
      */
--- linux-2.4/drivers/video/riva/riva_hw.h	2003/01/14 19:08:35	1.1
+++ linux-2.4/drivers/video/riva/riva_hw.h	2003/01/14 19:41:15
@@ -44,11 +44,25 @@
  * from this source.  -- Jeff Garzik <jgarzik@pobox.com>, 01/Nov/99 
  */
 
-/* $XFree86: xc/programs/Xserver/hw/xfree86/drivers/nv/riva_hw.h,v 1.6 2000/02/08 17:19:12 dawes Exp $ */
+/* $XFree86: xc/programs/Xserver/hw/xfree86/drivers/nv/riva_hw.h,v 1.21 2002/10/14 18:22:46 mvojkovi Exp $ */
 #ifndef __RIVA_HW_H__
 #define __RIVA_HW_H__
 #define RIVA_SW_VERSION 0x00010003
 
+#ifndef Bool
+typedef int Bool;
+#endif
+
+#ifndef TRUE
+#define TRUE 1
+#endif
+#ifndef FALSE
+#define FALSE 0
+#endif
+#ifndef NULL
+#define NULL 0
+#endif
+
 /*
  * Typedefs to force certain sized values.
  */
@@ -59,8 +73,14 @@
 /*
  * HW access macros.
  */
+#if defined(__powerpc__)
+#include <asm/io.h>
+#define NV_WR08(p,i,d)	out_8(p+i, d)
+#define NV_RD08(p,i)	in_8(p+i)
+#else
 #define NV_WR08(p,i,d)  (((U008 *)(p))[i]=(d))
 #define NV_RD08(p,i)    (((U008 *)(p))[i])
+#endif
 #define NV_WR16(p,i,d)  (((U016 *)(p))[(i)/2]=(d))
 #define NV_RD16(p,i)    (((U016 *)(p))[(i)/2])
 #define NV_WR32(p,i,d)  (((U032 *)(p))[(i)/4]=(d))
@@ -88,8 +108,12 @@
 typedef volatile struct
 {
     U032 reserved00[4];
+#ifdef __BIG_ENDIAN
+    U032 FifoFree;
+#else
     U016 FifoFree;
     U016 Nop;
+#endif
     U032 reserved01[0x0BB];
     U032 Rop3;
 } RivaRop;
@@ -99,8 +123,12 @@
 typedef volatile struct
 {
     U032 reserved00[4];
+#ifdef __BIG_ENDIAN
+    U032 FifoFree;
+#else
     U016 FifoFree;
     U016 Nop;
+#endif
     U032 reserved01[0x0BD];
     U032 Shape;
     U032 reserved03[0x001];
@@ -114,8 +142,12 @@
 typedef volatile struct
 {
     U032 reserved00[4];
+#ifdef __BIG_ENDIAN
+    U032 FifoFree;
+#else
     U016 FifoFree;
     U016 Nop;
+#endif
     U032 reserved01[0x0BB];
     U032 TopLeft;
     U032 WidthHeight;
@@ -126,8 +158,12 @@
 typedef volatile struct
 {
     U032 reserved00[4];
+#ifdef __BIG_ENDIAN
+    U032 FifoFree;
+#else
     U016 FifoFree;
     U016 Nop[1];
+#endif
     U032 reserved01[0x0BC];
     U032 Color;
     U032 reserved03[0x03E];
@@ -140,8 +176,12 @@
 typedef volatile struct
 {
     U032 reserved00[4];
+#ifdef __BIG_ENDIAN
+    U032 FifoFree;
+#else
     U016 FifoFree;
     U016 Nop;
+#endif
     U032 reserved01[0x0BB];
     U032 TopLeftSrc;
     U032 TopLeftDst;
@@ -153,8 +193,12 @@
 typedef volatile struct
 {
     U032 reserved00[4];
+#ifdef __BIG_ENDIAN
+    U032 FifoFree;
+#else
     U016 FifoFree;
     U016 Nop[1];
+#endif
     U032 reserved01[0x0BC];
     U032 TopLeft;
     U032 WidthHeight;
@@ -168,8 +212,12 @@
 typedef volatile struct
 {
     U032 reserved00[4];
+#ifdef __BIG_ENDIAN
+    U032 FifoFree;
+#else
     U016 FifoFree;
     U016 Nop;
+#endif
     U032 reserved01[0x0BB];
     U032 reserved03[(0x040)-1];
     U032 Color1A;
@@ -230,8 +278,12 @@
 typedef volatile struct
 {
     U032 reserved00[4];
+#ifdef __BIG_ENDIAN
+    U032 FifoFree;
+#else
     U016 FifoFree;
     U016 Nop;
+#endif
     U032 reserved01[0x0BC];
     U032 TextureOffset;
     U032 TextureFormat;
@@ -256,8 +308,12 @@
 typedef volatile struct
 {
     U032 reserved00[4];
+#ifdef __BIG_ENDIAN
+    U032 FifoFree;
+#else
     U016 FifoFree;
     U016 Nop;
+#endif
     U032 reserved01[0x0BB];
     U032 ColorKey;
     U032 TextureOffset;
@@ -290,8 +346,12 @@
 typedef volatile struct
 {
     U032 reserved00[4];
+#ifdef __BIG_ENDIAN
+    U032 FifoFree;
+#else
     U016 FifoFree;
     U016 Nop[1];
+#endif
     U032 reserved01[0x0BC];
     U032 Color;             /* source color               0304-0307*/
     U032 Reserved02[0x03e];
@@ -321,16 +381,24 @@
 typedef volatile struct
 {
     U032 reserved00[4];
+#ifdef __BIG_ENDIAN
+    U032 FifoFree;
+#else
     U016 FifoFree;
     U016 Nop;
+#endif
     U032 reserved01[0x0BE];
     U032 Offset;
 } RivaSurface;
 typedef volatile struct
 {
     U032 reserved00[4];
+#ifdef __BIG_ENDIAN
+    U032 FifoFree;
+#else
     U016 FifoFree;
     U016 Nop;
+#endif
     U032 reserved01[0x0BD];
     U032 Pitch;
     U032 RenderBufferOffset;
@@ -343,6 +411,9 @@
 *                                                                           *
 \***************************************************************************/
 
+#define FP_ENABLE  1
+#define FP_DITHER  2
+
 struct _riva_hw_inst;
 struct _riva_hw_state;
 /*
@@ -355,6 +426,7 @@
      */
     U032 Architecture;
     U032 Version;
+    U032 Chipset;
     U032 CrystalFreqKHz;
     U032 RamAmountKBytes;
     U032 MaxVClockFreqKHz;
@@ -364,11 +436,15 @@
     U032 VBlankBit;
     U032 FifoFreeCount;
     U032 FifoEmptyCount;
+    U032 CursorStart;
+    U032 flatPanel;
+    Bool twoHeads;
     /*
      * Non-FIFO registers.
      */
+    volatile U032 *PCRTC0;
     volatile U032 *PCRTC;
-    volatile U032 *PRAMDAC;
+    volatile U032 *PRAMDAC0;
     volatile U032 *PFB;
     volatile U032 *PFIFO;
     volatile U032 *PGRAPH;
@@ -378,17 +454,17 @@
     volatile U032 *PRAMIN;
     volatile U032 *FIFO;
     volatile U032 *CURSOR;
-    volatile U032 *CURSORPOS;
-    volatile U032 *VBLANKENABLE;
-    volatile U032 *VBLANK;
+    volatile U008 *PCIO0;
     volatile U008 *PCIO;
     volatile U008 *PVIO;
+    volatile U008 *PDIO0;
     volatile U008 *PDIO;
+    volatile U032 *PRAMDAC;
     /*
      * Common chip functions.
      */
     int  (*Busy)(struct _riva_hw_inst *);
-    void (*CalcStateExt)(struct _riva_hw_inst *,struct _riva_hw_state *,int,int,int,int,int,int,int,int,int,int,int,int,int);
+    void (*CalcStateExt)(struct _riva_hw_inst *,struct _riva_hw_state *,int,int,int,int,int);
     void (*LoadStateExt)(struct _riva_hw_inst *,struct _riva_hw_state *);
     void (*UnloadStateExt)(struct _riva_hw_inst *,struct _riva_hw_state *);
     void (*SetStartAddress)(struct _riva_hw_inst *,U032);
@@ -421,17 +497,26 @@
     U032 bpp;
     U032 width;
     U032 height;
+    U032 interlace;
     U032 repaint0;
     U032 repaint1;
     U032 screen;
+    U032 scale;
+    U032 dither;
+    U032 extra;
     U032 pixel;
     U032 horiz;
     U032 arbitration0;
     U032 arbitration1;
     U032 vpll;
+    U032 vpll2;
     U032 pllsel;
     U032 general;
+    U032 crtcOwner;
+    U032 head; 
+    U032 head2; 
     U032 config;
+    U032 cursorConfig;	
     U032 cursor0;
     U032 cursor1;
     U032 cursor2;
@@ -447,16 +532,16 @@
 /*
  * External routines.
  */
-int RivaGetConfig(RIVA_HW_INST *);
+int RivaGetConfig(RIVA_HW_INST *, unsigned int);
 /*
  * FIFO Free Count. Should attempt to yield processor if RIVA is busy.
  */
 
-#define RIVA_FIFO_FREE(hwinst,hwptr,cnt)                           \
-{                                                                  \
-   while ((hwinst).FifoFreeCount < (cnt))                          \
-	(hwinst).FifoFreeCount = (hwinst).hwptr->FifoFree >> 2;        \
-   (hwinst).FifoFreeCount -= (cnt);                                \
+#define RIVA_FIFO_FREE(hwinst,hwptr,cnt)                            \
+{                                                                   \
+    while ((hwinst).FifoFreeCount < (cnt))                          \
+        (hwinst).FifoFreeCount = (hwinst).hwptr->FifoFree >> 2;     \
+    (hwinst).FifoFreeCount -= (cnt);                                \
 }
 #endif /* __RIVA_HW_H__ */
 
--- linux-2.4/drivers/video/riva/riva_tbl.h	2003/01/14 19:08:35	1.1
+++ linux-2.4/drivers/video/riva/riva_tbl.h	2003/01/14 19:40:01
@@ -44,7 +44,9 @@
  * from this source.  -- Jeff Garzik <jgarzik@pobox.com>, 01/Nov/99 
  */
 
-/* $XFree86: xc/programs/Xserver/hw/xfree86/drivers/nv/riva_tbl.h,v 1.5 2000/02/08 17:19:12 dawes Exp $ */
+/* $XFree86: xc/programs/Xserver/hw/xfree86/drivers/nv/riva_tbl.h,v 1.9 2002/01/30 01:35:03 mvojkovi Exp $ */
+
+
 /*
  * RIVA Fixed Functionality Init Tables.
  */
@@ -69,6 +71,7 @@
     {0x00001800, 0x80000010},
     {0x00002000, 0x80000011},
     {0x00002800, 0x80000012},
+    {0x00003000, 0x80000016},
     {0x00003800, 0x80000013}
 };
 static unsigned nv3TablePFIFO[][2] =
@@ -174,6 +177,8 @@
     {0x00000249, 0x00CC0346},
     {0x0000024C, 0x80000013},
     {0x0000024D, 0x00D70347},
+    {0x00000258, 0x80000016},
+    {0x00000259, 0x00CA034C},
     {0x00000D05, 0x00000000},
     {0x00000D06, 0x00000000},
     {0x00000D07, 0x00000000},
@@ -210,7 +215,10 @@
     {0x00000D2C, 0x10830200},
     {0x00000D2D, 0x00000000},
     {0x00000D2E, 0x00000000},
-    {0x00000D2F, 0x00000000} 
+    {0x00000D2F, 0x00000000},
+    {0x00000D31, 0x00000000},
+    {0x00000D32, 0x00000000},
+    {0x00000D33, 0x00000000}
 };
 static unsigned nv3TablePRAMIN_8BPP[][2] =
 {
@@ -222,7 +230,8 @@
     {0x00000D10, 0x10118203},
     {0x00000D14, 0x10110203},
     {0x00000D18, 0x10110203},
-    {0x00000D1C, 0x10419208}
+    {0x00000D1C, 0x10419208},
+    {0x00000D30, 0x10118203}
 };
 static unsigned nv3TablePRAMIN_15BPP[][2] =
 {
@@ -234,7 +243,8 @@
     {0x00000D10, 0x10118200},
     {0x00000D14, 0x10110200},
     {0x00000D18, 0x10110200},
-    {0x00000D1C, 0x10419208}
+    {0x00000D1C, 0x10419208},
+    {0x00000D30, 0x10118200}
 };
 static unsigned nv3TablePRAMIN_32BPP[][2] =
 {
@@ -246,7 +256,8 @@
     {0x00000D10, 0x10118201},
     {0x00000D14, 0x10110201},
     {0x00000D18, 0x10110201},
-    {0x00000D1C, 0x10419208}
+    {0x00000D1C, 0x10419208},
+    {0x00000D30, 0x10118201}
 };
 static unsigned nv4TableFIFO[][2] =
 {
@@ -370,6 +381,8 @@
     {0x00000009, 0x80011149},
     {0x0000000A, 0x80000015},
     {0x0000000B, 0x8001114A},
+    {0x0000000C, 0x80000016},
+    {0x0000000D, 0x8001114F},
     {0x00000020, 0x80000000},
     {0x00000021, 0x80011142},
     {0x00000022, 0x80000001},
@@ -437,7 +450,10 @@
     {0x00000537, 0x00000000},
     {0x00000538, 0x0000005B},
     {0x0000053A, 0x11401140},
-    {0x0000053B, 0x00000000} 
+    {0x0000053B, 0x00000000},
+    {0x0000053C, 0x0300A01C},
+    {0x0000053E, 0x11401140},
+    {0x0000053F, 0x00000000}
 };
 static unsigned nv4TablePRAMIN_8BPP[][2] =
 {
@@ -452,7 +468,8 @@
     {0x0000052D, 0x00000302},
     {0x0000052E, 0x00000302},
     {0x00000535, 0x00000000},
-    {0x00000539, 0x00000000} 
+    {0x00000539, 0x00000000},
+    {0x0000053D, 0x00000302}
 };
 static unsigned nv4TablePRAMIN_15BPP[][2] =
 {
@@ -467,7 +484,8 @@
     {0x0000052D, 0x00000902},
     {0x0000052E, 0x00000902},
     {0x00000535, 0x00000702},
-    {0x00000539, 0x00000702} 
+    {0x00000539, 0x00000702},
+    {0x0000053D, 0x00000902}
 };
 static unsigned nv4TablePRAMIN_16BPP[][2] =
 {
@@ -482,7 +500,8 @@
     {0x0000052D, 0x00000C02},
     {0x0000052E, 0x00000C02},
     {0x00000535, 0x00000702},
-    {0x00000539, 0x00000702} 
+    {0x00000539, 0x00000702},
+    {0x0000053D, 0x00000C02}
 };
 static unsigned nv4TablePRAMIN_32BPP[][2] =
 {
@@ -497,7 +516,8 @@
     {0x0000052D, 0x00000E02},
     {0x0000052E, 0x00000E02},
     {0x00000535, 0x00000E02},
-    {0x00000539, 0x00000E02} 
+    {0x00000539, 0x00000E02},
+    {0x0000053D, 0x00000E02}
 };
 static unsigned nv10TableFIFO[][2] =
 {
@@ -810,6 +830,8 @@
     {0x00000009, 0x80011149},
     {0x0000000A, 0x80000015},
     {0x0000000B, 0x8001114A},
+    {0x0000000C, 0x80000016},
+    {0x0000000D, 0x80011150},
     {0x00000020, 0x80000000},
     {0x00000021, 0x80011142},
     {0x00000022, 0x80000001},
@@ -830,29 +852,45 @@
     {0x00000501, 0x01FFFFFF},
     {0x00000502, 0x00000002},
     {0x00000503, 0x00000002},
+#ifdef __BIG_ENDIAN
+    {0x00000508, 0x01088043}, 
+#else
     {0x00000508, 0x01008043},
+#endif
     {0x0000050A, 0x00000000},
     {0x0000050B, 0x00000000},
+#ifdef __BIG_ENDIAN
+    {0x0000050C, 0x01088019},
+#else
     {0x0000050C, 0x01008019},
+#endif
     {0x0000050E, 0x00000000},
     {0x0000050F, 0x00000000},
-#if 1
-    {0x00000510, 0x01008018},
+#ifdef __BIG_ENDIAN
+    {0x00000510, 0x01088018},
 #else
-    {0x00000510, 0x01008044},
+    {0x00000510, 0x01008018},
 #endif
     {0x00000512, 0x00000000},
     {0x00000513, 0x00000000},
+#ifdef __BIG_ENDIAN
+    {0x00000514, 0x01088021},
+#else
     {0x00000514, 0x01008021},
+#endif
     {0x00000516, 0x00000000},
     {0x00000517, 0x00000000},
+#ifdef __BIG_ENDIAN
+    {0x00000518, 0x0108805F},
+#else
     {0x00000518, 0x0100805F},
+#endif
     {0x0000051A, 0x00000000},
     {0x0000051B, 0x00000000},
-#if 1
-    {0x0000051C, 0x0100804B},
+#ifdef __BIG_ENDIAN
+    {0x0000051C, 0x0108804B},
 #else
-    {0x0000051C, 0x0100804A},
+    {0x0000051C, 0x0100804B},
 #endif
     {0x0000051E, 0x00000000},
     {0x0000051F, 0x00000000},
@@ -868,10 +906,18 @@
     {0x00000529, 0x00000D01},
     {0x0000052A, 0x11401140},
     {0x0000052B, 0x00000000},
+#ifdef __BIG_ENDIAN
+    {0x0000052C, 0x00080058},
+#else
     {0x0000052C, 0x00000058},
+#endif
     {0x0000052E, 0x11401140},
     {0x0000052F, 0x00000000},
+#ifdef __BIG_ENDIAN
+    {0x00000530, 0x00080059},
+#else
     {0x00000530, 0x00000059},
+#endif
     {0x00000532, 0x11401140},
     {0x00000533, 0x00000000},
     {0x00000534, 0x0000005A},
@@ -882,7 +928,14 @@
     {0x0000053B, 0x00000000},
     {0x0000053C, 0x00000093},
     {0x0000053E, 0x11401140},
-    {0x0000053F, 0x00000000} 
+    {0x0000053F, 0x00000000},
+#ifdef __BIG_ENDIAN
+    {0x00000540, 0x0308A01C},
+#else
+    {0x00000540, 0x0300A01C},
+#endif
+    {0x00000542, 0x11401140},
+    {0x00000543, 0x00000000}
 };
 static unsigned nv10TablePRAMIN_8BPP[][2] =
 {
@@ -898,7 +951,8 @@
     {0x0000052E, 0x00000302},
     {0x00000535, 0x00000000},
     {0x00000539, 0x00000000},
-    {0x0000053D, 0x00000000} 
+    {0x0000053D, 0x00000000},
+    {0x00000541, 0x00000302}
 };
 static unsigned nv10TablePRAMIN_15BPP[][2] =
 {
@@ -914,7 +968,8 @@
     {0x0000052E, 0x00000902},
     {0x00000535, 0x00000902},
     {0x00000539, 0x00000902}, 
-    {0x0000053D, 0x00000902} 
+    {0x0000053D, 0x00000902},
+    {0x00000541, 0x00000902}
 };
 static unsigned nv10TablePRAMIN_16BPP[][2] =
 {
@@ -930,7 +985,8 @@
     {0x0000052E, 0x00000C02},
     {0x00000535, 0x00000C02},
     {0x00000539, 0x00000C02},
-    {0x0000053D, 0x00000C02} 
+    {0x0000053D, 0x00000C02},
+    {0x00000541, 0x00000C02}
 };
 static unsigned nv10TablePRAMIN_32BPP[][2] =
 {
@@ -946,6 +1002,7 @@
     {0x0000052E, 0x00000E02},
     {0x00000535, 0x00000E02},
     {0x00000539, 0x00000E02},
-    {0x0000053D, 0x00000E02} 
+    {0x0000053D, 0x00000E02},
+    {0x00000541, 0x00000E02}
 };
 
--- linux-2.4/drivers/video/riva/rivafb.h	2003/01/14 19:08:35	1.1
+++ linux-2.4/drivers/video/riva/rivafb.h	2003/01/14 19:10:44
@@ -16,6 +16,9 @@
 #define NUM_GRC_REGS		0x09
 #define NUM_ATC_REGS		0x15
 
+
+#define RIVAFB_MAX_DRIVERS	10
+
 /* holds the state of the VGA core and extended Riva hw state from riva_hw.c.
  * From KGI originally. */
 struct riva_regs {
@@ -27,11 +30,22 @@
 	RIVA_HW_STATE ext;
 };
 
+struct rivafb_info;
+struct rivafb_driver {
+	struct list_head node;
+	char *name;
+	void *(*probe)(struct rivafb_info *rinfo);
+	void *(*remove)(struct rivafb_info *rinfo, void *data);
+};
+
+int rivafb_register_driver(struct rivafb_driver *driver);
+void rivafb_unregister_driver(struct rivafb_driver *driver);
+
+
 typedef struct {
 	unsigned char red, green, blue, transp;
 } riva_cfb8_cmap_t;
 
-struct rivafb_info;
 struct rivafb_info {
 	struct fb_info info;	/* kernel framebuffer info */
 
@@ -51,12 +65,18 @@
 	struct riva_regs initial_state;	/* initial startup video mode */
 	struct riva_regs current_state;
 
+	unsigned char *EDID;
+
 	struct display disp;
 	int currcon;
 	struct display *currcon_display;
 
 	struct rivafb_info *next;
 
+	struct rivafb_driver	*(drivers[RIVAFB_MAX_DRIVERS]);
+	void			*(drivers_data[RIVAFB_MAX_DRIVERS]);
+	unsigned int		drivers_count;
+
 	struct pci_dev *pd;	/* pointer to board's pci info */
 	unsigned base0_region_size;	/* size of control register region */
 	unsigned base1_region_size;	/* size of framebuffer region */
@@ -67,6 +87,16 @@
 
 	riva_cfb8_cmap_t palette[256];	/* VGA DAC palette cache */
 
+	int panel_xres, panel_yres;
+	int clock;
+	int hOver_plus, hSync_width, hblank;
+	int vOver_plus, vSync_width, vblank;
+	int hAct_high, vAct_high, interlaced;
+	int synct, misc;
+
+	int use_default_var;
+	int got_dfpinfo;
+
 #if defined(FBCON_HAS_CFB16) || defined(FBCON_HAS_CFB32)
 	union {
 #ifdef FBCON_HAS_CFB16
@@ -80,6 +110,13 @@
 #ifdef CONFIG_MTRR
 	struct { int vram; int vram_valid; } mtrr;
 #endif
+	unsigned int Chipset;
+	int forceCRTC;
+	Bool SecondCRTC;
+	int FlatPanel;
 };
+
+void riva_common_setup(struct rivafb_info*);
+
 
 #endif /* __RIVAFB_H */
--- linux-2.4/include/linux/pci_ids.h	2003/01/14 19:12:34	1.1
+++ linux-2.4/include/linux/pci_ids.h	2003/01/14 19:19:51
@@ -912,12 +912,29 @@
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE2_GTS2	0x0151
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE2_ULTRA	0x0152
 #define PCI_DEVICE_ID_NVIDIA_QUADRO2_PRO	0x0153
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_460	0x0170
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_440	0x0171
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_MX_420	0x0172
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_440_GO	0x0174
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_420_GO	0x0175
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_420_GO_M32	0x0176
+#define PCI_DEVICE_ID_NVIDIA_QUADRO4_500XGL	0x0178
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_440_GO_M64	0x0179
+#define PCI_DEVICE_ID_NVIDIA_QUADRO4_200	0x017A
+#define PCI_DEVICE_ID_NVIDIA_QUADRO4_550XGL	0x017B
+#define PCI_DEVICE_ID_NVIDIA_QUADRO4_500_GOGL	0x017C
 #define PCI_DEVICE_ID_NVIDIA_IGEFORCE2		0x01a0
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_IDE		0x01bc
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3		0x0200
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_1		0x0201
 #define PCI_DEVICE_ID_NVIDIA_GEFORCE3_2		0x0202
 #define PCI_DEVICE_ID_NVIDIA_QUADRO_DDC		0x0203
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4600	0x0250
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4400	0x0251
+#define PCI_DEVICE_ID_NVIDIA_GEFORCE4_TI_4200	0x0253
+#define PCI_DEVICE_ID_NVIDIA_QUADRO4_900XGL	0x0258
+#define PCI_DEVICE_ID_NVIDIA_QUADRO4_750XGL	0x0259
+#define PCI_DEVICE_ID_NVIDIA_QUADRO4_700XGL	0x025B
 
 #define PCI_VENDOR_ID_IMS		0x10e0
 #define PCI_DEVICE_ID_IMS_8849		0x8849

--UlVJffcvxoiEqYs2--
