Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264920AbTLFBmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 20:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbTLFBlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 20:41:46 -0500
Received: from dm51.neoplus.adsl.tpnet.pl ([80.54.235.51]:14084 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S264920AbTLFBke
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 20:40:34 -0500
Date: Sat, 6 Dec 2003 02:45:10 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][RESEND] tdfxfb fixes for 2.6.0-test
Message-ID: <20031206014510.GC3914@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="p2kqVDKq5asng8Dg"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: PLD Linux Distribution
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

these patches has been already merged by James Simmons into "big" fbdev
update (known as fbdev.diff), but as it seems unlikely to be merged
before 2.6.0 release (or am I wrong? but it was removed from -mm some
time ago), I resend two small patches for tdfxfb, which can (and IMO
should, at least the first one; second would be nice) be merged in 2.6.0.

The first patch fixes text background colour used for terminal
"clear" commands in 16/24/32bpp modes.
The second one is just a port of my changes which were merged into
2.4.21 (double-scan and interlaced modes support).


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/

--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-tdfxfb-fillrect.patch"

This fixes background used for "clear" terminal commands (^[[J, ^[[K etc.)
in 16/24/32bpp modes.

	-- Jakub Bogusz <qboosh@pld-linux.org>

--- linux-2.6.0-test2/drivers/video/tdfxfb.c.orig	2003-07-30 08:31:57.000000000 +0200
+++ linux-2.6.0-test2/drivers/video/tdfxfb.c	2003-07-31 00:44:26.000000000 +0200
@@ -890,7 +890,11 @@
 
 	banshee_make_room(par, 5);
 	tdfx_outl(par,	DSTFORMAT, fmt);
-	tdfx_outl(par,	COLORFORE, rect->color);
+	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
+		tdfx_outl(par,	COLORFORE, rect->color);
+	} else { /* FB_VISUAL_TRUECOLOR */
+		tdfx_outl(par, COLORFORE, ((u32*)(info->pseudo_palette))[rect->color]);
+	}
 	tdfx_outl(par,	COMMAND_2D, COMMAND_2D_FILLRECT | (tdfx_rop << 24));
 	tdfx_outl(par,	DSTSIZE,    rect->width | (rect->height << 16));
 	tdfx_outl(par,	LAUNCH_2D,  rect->dx | (rect->dy << 16));

--p2kqVDKq5asng8Dg
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

--p2kqVDKq5asng8Dg--
