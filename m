Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132544AbRACQsz>; Wed, 3 Jan 2001 11:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132545AbRACQsp>; Wed, 3 Jan 2001 11:48:45 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:5115
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S132544AbRACQse>; Wed, 3 Jan 2001 11:48:34 -0500
Date: Wed, 3 Jan 2001 09:16:13 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-fbdev@vuser.vu.union.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] matroxfb as a module (PPC)
Message-ID: <20010103091613.Q26653@opus.bloom.county>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all.  I've recently been playing with modules on my PPC system, and
noticed that matroxfb doesn't work as a module, because of mac_vmode_to_par.
But, after looking at other drivers which did work (aty and aty128) I noticed
matroxfb was doing something it didn't need to be doing.
First, the code should never get compiled, if this is a module, and even then
the code only needs to be compiled on ALL_PPC (which is Pmac/PReP/CHRP).
Second, it's only valid to call the default_{vmode,cmode} code on a PMAC 
(tested on a pmac, and ran it by one of the IBM guys who agrees it shouldn't
break anything, but he's still working on making the machine boot to start
with. :))
Third, the nvram_read_byte needs to be protected by CONFIG_NVRAM.
Finally, the VMODE_CHOOSE stuff is 0'ed out in atyfb with a comment about this
not actually working, so I removed it.

Comments?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="matroxfb_base.patch"

===== drivers/video/matrox/matroxfb_base.c 1.13 vs edited =====
--- 1.13/drivers/video/matrox/matroxfb_base.c	Fri Dec 15 14:12:43 2000
+++ edited/drivers/video/matrox/matroxfb_base.c	Sun Dec 31 10:39:11 2000
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

--6sX45UoQRIJXqkqR--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
