Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314709AbSEYPxq>; Sat, 25 May 2002 11:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314743AbSEYPxq>; Sat, 25 May 2002 11:53:46 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:1987 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314709AbSEYPxp>; Sat, 25 May 2002 11:53:45 -0400
Date: Sat, 25 May 2002 10:53:42 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Meelis Roos <mroos@linux.ee>
cc: linux-kernel@vger.kernel.org
Subject: Re: matroxfb & 2.5.18 BK: unresolved symbols in modules
In-Reply-To: <Pine.GSO.4.43.0205251301100.25029-100000@romulus.cs.ut.ee>
Message-ID: <Pine.LNX.4.44.0205251051500.31650-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2002, Meelis Roos wrote:

> Matroxfb as module:
> 
> depmod: *** Unresolved symbols in /lib/modules/2.5.18/kernel/drivers/video/matrox/matroxfb_DAC1064.o
> depmod: 	matrox_init_putc
> depmod: *** Unresolved symbols in /lib/modules/2.5.18/kernel/drivers/video/matrox/matroxfb_Ti3026.o
> depmod: 	matrox_init_putc
> depmod: *** Unresolved symbols in /lib/modules/2.5.18/kernel/drivers/video/matrox/matroxfb_base.o
> depmod: 	matrox_text_round
> depmod: 	matrox_cfbX_init
> depmod: 	initMatrox

matroxfb still relied on implicitly exporting all symbols. Seems I 
overlooked it before making exporting no symbols default, sorry. This
patch will fix it.

--Kai


===== drivers/video/matrox/matroxfb_accel.c 1.4 vs edited =====
--- 1.4/drivers/video/matrox/matroxfb_accel.c	Tue Feb  5 01:52:39 2002
+++ edited/drivers/video/matrox/matroxfb_accel.c	Sat May 25 10:38:11 2002
@@ -143,6 +143,8 @@
 	ACCESS_FBINFO(accel.m_opmode) = mopmode;
 }
 
+EXPORT_SYMBOL(matrox_cfbX_init);
+
 static void matrox_cfbX_bmove(struct display* p, int sy, int sx, int dy, int dx, int height, int width) {
 	int pixx = p->var.xres_virtual, start, end;
 	CRITFLAGS
@@ -943,7 +945,7 @@
 	CRITEND
 }
 
-void matrox_text_createcursor(WPMINFO struct display* p) {
+static void matrox_text_createcursor(WPMINFO struct display* p) {
 	CRITFLAGS
 
 	if (ACCESS_FBINFO(currcon_display) != p)
@@ -1029,6 +1031,8 @@
 	var->xres_virtual = vxres * hf;
 }
 
+EXPORT_SYMBOL(matrox_text_round);
+
 static int matrox_text_setfont(struct display* p, int width, int height) {
 	DBG("matrox_text_setfont");
 
@@ -1223,6 +1227,8 @@
 	}
 }
 
+EXPORT_SYMBOL(initMatrox);
+
 void matrox_init_putc(WPMINFO struct display* p, void (*dac_createcursor)(WPMINFO struct display* p)) {
 	int i;
 
@@ -1245,4 +1251,7 @@
 		ACCESS_FBINFO(curr.putcs) = matrox_cfbX_putcs;
 	}
 }
+
+EXPORT_SYMBOL(matrox_init_putc);
+
 MODULE_LICENSE("GPL");
===== drivers/video/matrox/matroxfb_accel.h 1.1 vs edited =====
--- 1.1/drivers/video/matrox/matroxfb_accel.h	Tue Feb  5 11:40:16 2002
+++ edited/drivers/video/matrox/matroxfb_accel.h	Sat May 25 10:37:33 2002
@@ -5,7 +5,6 @@
 
 void matrox_init_putc(WPMINFO struct display* p, void (*)(WPMINFO struct display *p));
 void matrox_cfbX_init(WPMINFO struct display* p);
-void matrox_text_createcursor(WPMINFO struct display* p);
 void matrox_text_round(CPMINFO struct fb_var_screeninfo* var, struct display* p);
 void initMatrox(WPMINFO struct display* p);
 

