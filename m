Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129244AbRBBSzP>; Fri, 2 Feb 2001 13:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129623AbRBBSzF>; Fri, 2 Feb 2001 13:55:05 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:57604 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S129244AbRBBSyy>;
	Fri, 2 Feb 2001 13:54:54 -0500
Date: Fri, 2 Feb 2001 19:53:45 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vuser.vu.union.edu
Subject: [PATCH] G450 and lockup
Message-ID: <20010202195345.A1389@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan, hi others,
  source of problems with matroxfb on G450 was revealed: BIOS forgets
to initialize ZORG (0x1C0C) register, and although matroxfb does not use
it, it must contain reasonable value, as it was proved that otherwise it
does not work...
  Patch contains:
1) matroxfb_DAC1064.c: changed copyright header of file to point you
   to matroxfb_base.c for complete listing, plus increased version number
2) matroxfb_DAC1064.c: initialize ZORG on G450
3) matroxfb_base.c: increase version number
4) matroxfb_base.c, matroxfb_base.h: move global_disp to matroxfb_base.c,
   otherwise matroxfb does not compile with -fno-common without multihead
5) matroxfb_base.h: simplify (remove) source code. GCC is clueful enough
   to found that it should check %al instead of %eax & 0xFF, and on some
   little endian architectures (alpha) inl is much better than inb... Also
   matrox recommends always using 32bit accesses, so...
  Patch is for 2.4.0-ac1, but important part (second hunk of DAC1064.c)
should apply to any kernel which has G450 support.
  Alan, I'm sending it to you and not to Linus, as ac1 contains newer
matroxfb than Linus tree and doing otherwise would make your work harder
without any reason. But please make sure that Linus's 2.4.2 will contain
this fix.
                                            Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/drivers/video/matrox/matroxfb_DAC1064.c linux/drivers/video/matrox/matroxfb_DAC1064.c
--- linux/drivers/video/matrox/matroxfb_DAC1064.c	Fri Dec 29 22:07:23 2000
+++ linux/drivers/video/matrox/matroxfb_DAC1064.c	Fri Feb  2 17:30:42 2001
@@ -1,81 +1,12 @@
 /*
  *
- * Hardware accelerated Matrox Millennium I, II, Mystique, G100, G200 and G400
- *
- * (c) 1998,1999,2000 Petr Vandrovec <vandrove@vc.cvut.cz>
- *
- * Version: 1.50 2000/08/10
- *
- * MTRR stuff: 1998 Tom Rini <trini@kernel.crashing.org>
- *
- * Contributors: "menion?" <menion@mindless.com>
- *                     Betatesting, fixes, ideas
- *
- *               "Kurt Garloff" <garloff@suse.de>
- *                     Betatesting, fixes, ideas, videomodes, videomodes timmings
- *
- *               "Tom Rini" <trini@kernel.crashing.org>
- *                     MTRR stuff, PPC cleanups, betatesting, fixes, ideas
- *
- *               "Bibek Sahu" <scorpio@dodds.net>
- *                     Access device through readb|w|l and write b|w|l
- *                     Extensive debugging stuff
- *
- *               "Daniel Haun" <haund@usa.net>
- *                     Testing, hardware cursor fixes
- *
- *               "Scott Wood" <sawst46+@pitt.edu>
- *                     Fixes
- *
- *               "Gerd Knorr" <kraxel@goldbach.isdn.cs.tu-berlin.de>
- *                     Betatesting
- *
- *               "Kelly French" <targon@hazmat.com>
- *               "Fernando Herrera" <fherrera@eurielec.etsit.upm.es>
- *                     Betatesting, bug reporting
- *
- *               "Pablo Bianucci" <pbian@pccp.com.ar>
- *                     Fixes, ideas, betatesting
- *
- *               "Inaky Perez Gonzalez" <inaky@peloncho.fis.ucm.es>
- *                     Fixes, enhandcements, ideas, betatesting
- *
- *               "Ryuichi Oikawa" <roikawa@rr.iiij4u.or.jp>
- *                     PPC betatesting, PPC support, backward compatibility
- *
- *               "Paul Womar" <Paul@pwomar.demon.co.uk>
- *               "Owen Waller" <O.Waller@ee.qub.ac.uk>
- *                     PPC betatesting
- *
- *               "Thomas Pornin" <pornin@bolet.ens.fr>
- *                     Alpha betatesting
- *
- *               "Pieter van Leuven" <pvl@iae.nl>
- *               "Ulf Jaenicke-Roessler" <ujr@physik.phy.tu-dresden.de>
- *                     G100 testing
- *
- *               "H. Peter Arvin" <hpa@transmeta.com>
- *                     Ideas
- *
- *               "Cort Dougan" <cort@cs.nmt.edu>
- *                     CHRP fixes and PReP cleanup
- *
- *               "Mark Vojkovich" <mvojkovi@ucsd.edu>
- *                     G400 support
- *
- *               "Ken Aaker" <kdaaker@rchland.vnet.ibm.com>
- *                     memtype extension (needed for GXT130P RS/6000 adapter)
- *
- * (following author is not in any relation with this code, but his code
- *  is included in this driver)
+ * Hardware accelerated Matrox Millennium I, II, Mystique, G100, G200, G400 and G450.
  *
- * Based on framebuffer driver for VBE 2.0 compliant graphic boards
- *     (c) 1998 Gerd Knorr <kraxel@cs.tu-berlin.de>
+ * (c) 1998-2001 Petr Vandrovec <vandrove@vc.cvut.cz>
  *
- * (following author is not in any relation with this code, but his ideas
- *  were used when writting this driver)
+ * Version: 1.52 2001/02/02
  *
- *		 FreeVBE/AF (Matrox), "Shawn Hargreaves" <shawn@talula.demon.co.uk>
+ * See matroxfb_base.c for contributors.
  *
  */
 
@@ -787,6 +718,11 @@
 
 	ACCESS_FBINFO(primout) = &m1064;
 
+	if (ACCESS_FBINFO(devflags.g450dac)) {
+		/* we must do this always, BIOS does not do it for us
+		   and accelerator dies without it */
+		mga_outl(0x1C0C, 0);
+	}
 	if (ACCESS_FBINFO(devflags.noinit))
 		return 0;
 	hw->MXoptionReg &= 0xC0000100;
diff -urdN linux/drivers/video/matrox/matroxfb_base.c linux/drivers/video/matrox/matroxfb_base.c
--- linux/drivers/video/matrox/matroxfb_base.c	Thu Feb  1 21:27:20 2001
+++ linux/drivers/video/matrox/matroxfb_base.c	Fri Feb  2 17:39:25 2001
@@ -4,7 +4,7 @@
  *
  * (c) 1998-2001 Petr Vandrovec <vandrove@vc.cvut.cz>
  *
- * Version: 1.51 2001/01/25
+ * Version: 1.52 2001/02/02
  *
  * MTRR stuff: 1998 Tom Rini <trini@kernel.crashing.org>
  *
@@ -2005,6 +2005,7 @@
 	u_int32_t cmd;
 #ifndef CONFIG_FB_MATROX_MULTIHEAD
 	static int registered = 0;
+	static struct display global_disp;
 #endif
 	DBG("matroxfb_probe")
 
diff -urdN linux/drivers/video/matrox/matroxfb_base.h linux/drivers/video/matrox/matroxfb_base.h
--- linux/drivers/video/matrox/matroxfb_base.h	Fri Dec 29 22:07:23 2000
+++ linux/drivers/video/matrox/matroxfb_base.h	Fri Feb  2 17:43:02 2001
@@ -589,7 +589,6 @@
 #else
 
 extern struct matrox_fb_info matroxfb_global_mxinfo;
-struct display global_disp;
 
 #define ACCESS_FBINFO(x) (matroxfb_global_mxinfo.x)
 #define ACCESS_FBINFO2(info, x) (matroxfb_global_mxinfo.x)
@@ -787,11 +786,7 @@
 #define mga_setr(addr,port,val) do { mga_outb(addr, port); mga_outb((addr)+1, val); } while (0)
 #endif
 
-#ifdef __LITTLE_ENDIAN
-#define mga_fifo(n)	do {} while (mga_inb(M_FIFOSTATUS) < (n))
-#else
 #define mga_fifo(n)	do {} while ((mga_inl(M_FIFOSTATUS) & 0xFF) < (n))
-#endif
 
 #define WaitTillIdle()	do {} while (mga_inl(M_STATUS) & 0x10000)
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
