Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275531AbTHNUVU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275529AbTHNUT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:19:27 -0400
Received: from pv36.warszawa.cvx.ppp.tpnet.pl ([217.99.5.36]:30729 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S275528AbTHNUTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:19:04 -0400
Date: Thu, 14 Aug 2003 22:19:51 +0200
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] interlace and doublescan modes support for tdfxfb in 2.6
Message-ID: <20030814201951.GC27236@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Like the second tdfxfb patch I've posted a while ago - it was posted to
linux-fbdev-devel few days ago, but I haven't got any feedback...

It works on my Voodoo4 4500 and shouldn't cause any problems on other
Voodoos - it's just a port of changes between 2.4.20 and 2.4.21.


----- Forwarded message from Jakub Bogusz <qboosh at pld-linux.org> -----

Date: Sun, 10 Aug 2003 01:24:55 +0200
From: Jakub Bogusz <qboosh at pld-linux.org>
To: linux-fbdev-devel at lists.sourceforge.net
Subject: [PATCH] interlace and doublescan modes support for tdfxfb in 2.6

Hello,

this patch adds interlace and doublescan modes support to tdfxfb in 2.6
(it's a port of changes already incorporated into 2.4.21).

[...]

-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/

--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-tdfxfb-interlace+double.patch"

This patch adds interlace and double-scan mode support to tdfxfb in 2.6.
It's a port of my changes (incorporated into 2.4.21) to Linux 2.6.

	-- Jakub Bogusz <qboosh@pld-linux.org>

--- linux-2.6.0-test3/include/video/tdfx.h.orig	2003-07-14 05:32:41.000000000 +0200
+++ linux-2.6.0-test3/include/video/tdfx.h	2003-08-09 21:28:04.000000000 +0200
@@ -114,6 +114,7 @@
 #define VGAINIT1_MASK                   0x1fffff
 #define VIDCFG_VIDPROC_ENABLE           BIT(0)
 #define VIDCFG_CURS_X11                 BIT(1)
+#define VIDCFG_INTERLACE                BIT(3)
 #define VIDCFG_HALF_MODE                BIT(4)
 #define VIDCFG_DESK_ENABLE              BIT(7)
 #define VIDCFG_CLUT_BYPASS              BIT(10)
--- linux-2.6.0-test3/drivers/video/tdfxfb.c.orig	2003-08-09 21:26:11.000000000 +0200
+++ linux-2.6.0-test3/drivers/video/tdfxfb.c	2003-08-09 22:52:20.000000000 +0200
@@ -508,8 +508,10 @@
 		return -EINVAL;
 	}
 
-	/* fixme: does Voodoo3 support interlace? Banshee doesn't */
-	if ((var->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED) {
+	/* Banshee doesn't support interlace, but Voodoo4/5 and probably Voodoo3 do. */
+	/* no direct information about device id now? use max_pixclock for this... */
+	if (((var->vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED) &&
+			(par->max_pixclock < VOODOO3_MAX_PIXCLOCK)) {
 		DPRINTK("interlace not supported\n");
 		return -EINVAL;
 	}
@@ -616,10 +618,17 @@
 	hbs = hd;
 	hbe = ht;
 
-	vbs = vd = info->var.yres - 1;
-	vs  = vd + info->var.lower_margin;
-	ve  = vs + info->var.vsync_len;
-	vbe = vt = ve + info->var.upper_margin - 1;
+	if ((info->var.vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE) {
+		vbs = vd = (info->var.yres << 1) - 1;
+		vs  = vd + (info->var.lower_margin << 1);
+		ve  = vs + (info->var.vsync_len << 1);
+		vbe = vt = ve + (info->var.upper_margin << 1) - 1;
+	} else {
+		vbs = vd = info->var.yres - 1;
+		vs  = vd + info->var.lower_margin;
+		ve  = vs + info->var.vsync_len;
+		vbe = vt = ve + info->var.upper_margin - 1;
+	}
   
 	/* this is all pretty standard VGA register stuffing */
 	reg.misc[0x00] = 0x0f | 
@@ -742,8 +751,16 @@
 	reg.gfxpll = do_calc_pll(..., &fout);
 #endif
 
-	reg.screensize = info->var.xres | (info->var.yres << 12);
-	reg.vidcfg &= ~VIDCFG_HALF_MODE;
+	if ((info->var.vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE) {
+		reg.screensize = info->var.xres | (info->var.yres << 13);
+		reg.vidcfg |= VIDCFG_HALF_MODE;
+		reg.crt[0x09] |= 0x80;
+	} else {
+		reg.screensize = info->var.xres | (info->var.yres << 12);
+		reg.vidcfg &= ~VIDCFG_HALF_MODE;
+	}
+	if ((info->var.vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED)
+		reg.vidcfg |= VIDCFG_INTERLACE;
 	reg.miscinit0 = tdfx_inl(par, MISCINIT0);
 
 #if defined(__BIG_ENDIAN)

--uQr8t48UFsdbeI+V--
