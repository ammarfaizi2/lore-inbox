Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132302AbRAYSSl>; Thu, 25 Jan 2001 13:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135716AbRAYSSc>; Thu, 25 Jan 2001 13:18:32 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:31246 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S135249AbRAYSS0>;
	Thu, 25 Jan 2001 13:18:26 -0500
Date: Thu, 25 Jan 2001 19:17:33 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: display problem with matroxfb
Message-ID: <20010125191733.A2030@vana.vc.cvut.cz>
In-Reply-To: <200101242217.XAA21787@db0bm.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200101242217.XAA21787@db0bm.ampr.org>; from f5ibh@db0bm.ampr.org on Wed, Jan 24, 2001 at 11:17:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 11:17:45PM +0100, f5ibh wrote:
> > It looks like that there is some problem with screen offset computation then.
> > Can you try 'video=matrox:cross4MB' instead of '...:nopan'? I did not
> 
> video=matrox:cross4MB  works too !
> 

Hi Linus,
  can you apply following patch to 2.4.1-pre10? It does touch matroxfb only:
(1) copyright update for 2001 (hunks 1 & 6)
(2) removing few unused DEVF_* constants (hunks 2 & 3)
(3) changed PPC compatibility code - old code was checking wrong
    conditional defines (hunk 5)
(4) most important - get it to work on 8MB Mystique (hunk 4)

					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz



diff -urdN linux/drivers/video/matrox/matroxfb_base.c linux/drivers/video/matrox/matroxfb_base.c
--- linux/drivers/video/matrox/matroxfb_base.c	Fri Dec 29 22:07:23 2000
+++ linux/drivers/video/matrox/matroxfb_base.c	Thu Jan 25 17:31:50 2001
@@ -2,9 +2,9 @@
  *
  * Hardware accelerated Matrox Millennium I, II, Mystique, G100, G200 and G400
  *
- * (c) 1998,1999,2000 Petr Vandrovec <vandrove@vc.cvut.cz>
+ * (c) 1998-2001 Petr Vandrovec <vandrove@vc.cvut.cz>
  *
- * Version: 1.50 2000/08/10
+ * Version: 1.51 2001/01/25
  *
  * MTRR stuff: 1998 Tom Rini <trini@kernel.crashing.org>
  *
@@ -1409,12 +1409,12 @@
 
 #define DEVF_VIDEO64BIT		0x0001
 #define	DEVF_SWAPS		0x0002
-#define DEVF_MILLENNIUM		0x0004
-#define	DEVF_MILLENNIUM2	0x0008
+/* #define DEVF_recycled	0x0004 */
+/* #define DEVF_recycled	0x0008 */
 #define DEVF_CROSS4MB		0x0010
 #define DEVF_TEXT4B		0x0020
 #define DEVF_DDC_8_2		0x0040
-#define DEVF_DMA		0x0080
+/* #define DEVF_recycled	0x0080 */
 #define DEVF_SUPPORT32MB	0x0100
 #define DEVF_ANY_VXRES		0x0200
 #define DEVF_TEXT16B		0x0400
@@ -1441,19 +1441,19 @@
 #ifdef CONFIG_FB_MATROX_MILLENIUM
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MIL,	0xFF,
 		0,			0,
-		DEVF_MILLENNIUM | DEVF_TEXT4B,
+		DEVF_TEXT4B,
 		230000,
 		&vbMillennium,
 		"Millennium (PCI)"},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MIL_2,	0xFF,
 		0,			0,
-		DEVF_MILLENNIUM | DEVF_MILLENNIUM2 | DEVF_SWAPS,
+		DEVF_SWAPS,
 		220000,
 		&vbMillennium2,
 		"Millennium II (PCI)"},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MIL_2_AGP,	0xFF,
 		0,			0,
-		DEVF_MILLENNIUM | DEVF_MILLENNIUM2 | DEVF_SWAPS,
+		DEVF_SWAPS,
 		250000,
 		&vbMillennium2A,
 		"Millennium II (AGP)"},
@@ -1461,13 +1461,13 @@
 #ifdef CONFIG_FB_MATROX_MYSTIQUE
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MYS,	0x02,
 		0,			0,
-		DEVF_VIDEO64BIT,
+		DEVF_VIDEO64BIT | DEVF_CROSS4MB,
 		180000,
 		&vbMystique,
 		"Mystique (PCI)"},
 	{PCI_VENDOR_ID_MATROX,	PCI_DEVICE_ID_MATROX_MYS,	0xFF,
 		0,			0,
-		DEVF_VIDEO64BIT | DEVF_SWAPS,
+		DEVF_VIDEO64BIT | DEVF_SWAPS | DEVF_CROSS4MB,
 		220000,
 		&vbMystique,
 		"Mystique 220 (PCI)"},
@@ -1842,33 +1842,33 @@
 	}
 
 	/* FIXME: Where to move this?! */
-#if defined(CONFIG_PPC)
+#if defined(CONFIG_ALL_PPC)
 #if defined(CONFIG_FB_COMPAT_XPMAC)
 	strcpy(ACCESS_FBINFO(matrox_name), "MTRX,");	/* OpenFirmware naming convension */
 	strncat(ACCESS_FBINFO(matrox_name), b->name, 26);
 	if (!console_fb_info)
 		console_fb_info = &ACCESS_FBINFO(fbcon);
 #endif
-	if ((xres <= 640) && (yres <= 480)) {
+#ifndef MODULE
+	if (_machine == _MACH_Pmac) {
 		struct fb_var_screeninfo var;
-		if (default_vmode == VMODE_NVRAM) {
-			default_vmode = nvram_read_byte(NV_VMODE);
-			if (default_vmode <= 0 || default_vmode > VMODE_MAX)
-				default_vmode = VMODE_CHOOSE;
-		}
 		if (default_vmode <= 0 || default_vmode > VMODE_MAX)
 			default_vmode = VMODE_640_480_60;
+#ifdef CONFIG_NVRAM
 		if (default_cmode == CMODE_NVRAM)
 			default_cmode = nvram_read_byte(NV_CMODE);
+#endif
 		if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
 			default_cmode = CMODE_8;
 		if (!mac_vmode_to_var(default_vmode, default_cmode, &var)) {
 			var.accel_flags = vesafb_defined.accel_flags;
 			var.xoffset = var.yoffset = 0;
-			vesafb_defined = var; /* Note: mac_vmode_to_var() doesnot set all parameters */
+			/* Note: mac_vmode_to_var() does not set all parameters */
+			vesafb_defined = var;
 		}
 	}
-#endif /* CONFIG_PPC */
+#endif /* !MODULE */
+#endif /* CONFIG_ALL_PPC */
 	vesafb_defined.xres_virtual = vesafb_defined.xres;
 	if (nopan) {
 		vesafb_defined.yres_virtual = vesafb_defined.yres;
@@ -2502,8 +2502,8 @@
 
 /* *************************** init module code **************************** */
 
-MODULE_AUTHOR("(c) 1998,1999 Petr Vandrovec <vandrove@vc.cvut.cz>");
-MODULE_DESCRIPTION("Accelerated FBDev driver for Matrox Millennium/Mystique/G100/G200/G400");
+MODULE_AUTHOR("(c) 1998-2001 Petr Vandrovec <vandrove@vc.cvut.cz>");
+MODULE_DESCRIPTION("Accelerated FBDev driver for Matrox Millennium/Mystique/G100/G200/G400/G450");
 MODULE_PARM(mem, "i");
 MODULE_PARM_DESC(mem, "Size of available memory in MB, KB or B (2,4,8,12,16MB, default=autodetect)");
 MODULE_PARM(disabled, "i");
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
