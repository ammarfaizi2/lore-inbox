Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTKEW5V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 17:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263275AbTKEW5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 17:57:21 -0500
Received: from pD951C050.dip.t-dialin.net ([217.81.192.80]:46979 "EHLO
	defiant.crash") by vger.kernel.org with ESMTP id S263271AbTKEW5O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 17:57:14 -0500
From: Ronald Lembcke <es186@fen-net.de>
Date: Wed, 5 Nov 2003 23:57:24 +0100
To: linux-kernel@vger.kernel.org
Subject: PATCH: bugfix =?iso-8859-1?Q?f=FC?=
	=?iso-8859-1?Q?r?= RadeonFB (against 2.4.22-ac4, bug in 2.6.0-test9, too)
Message-ID: <20031105225724.GA21030@defiant.crash>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

As linux-fbdev-devel@lists.sourceforge.net didn't like me :(

<<< 550 rejected because 217.81.192.80 is in the DULS RBL
550 5.1.1 <linux-fbdev-devel@lists.sourceforge.net>... User unknown

I send the patches here.


All patches are against 2.4.22-ac4.

The first patch is a bugfix in radeonfb.
The bug is in 2.6.0-test9, too. The second red should be blue.

--- linux-2.4.22-ac4/drivers/video/radeonfb.c	2003-11-05 19:47:16.000000000 +0100
+++ linux-2.4.22-ac4_patched/drivers/video/radeonfb.c	2003-11-05 22:08:39.000000000 +0100
@@ -2362,7 +2362,7 @@
 			disp->visual = FB_VISUAL_DIRECTCOLOR;
 			v.red.offset = 10;
 			v.green.offset = 5;
-			v.red.offset = 0;
+			v.blue.offset = 0;
 			v.red.length = v.green.length = v.blue.length = 5;
 			v.transp.offset = v.transp.length = 0;
 			break;


The following patches make a few framebuffer-drivers behave (imho) more
sensible: (Matrox and Riva allready behave like this)

When selecting a video mode with bits_per_pixel == 16 is selected, but
green.length != 6 (... 0 because the calling programm made no assumtion
if the mode is 5/6/5 or maybe 6/5/5 or whatever) a 15 bpp mode is
selected with 5/5/5. 
That's not nice ... when 16 bpp were requested.

The patches change this behaviour. If not explictly green.length == 5 is
selected, green.length will be set to 6.

The patches for radeonfb, intelfb are straight forward, but I'm not so
sure if the patch for imsttfb is correct.


--- linux-2.4.22-ac4/drivers/video/radeonfb.c	2003-11-05 22:10:09.000000000 +0100
+++ linux-2.4.22-ac4_patched/drivers/video/radeonfb.c	2003-11-05 19:59:04.000000000 +0100
@@ -705,7 +705,7 @@
 {
 	if (var->bits_per_pixel != 16)
 		return var->bits_per_pixel;
-	return (var->green.length == 6) ? 16 : 15;
+	return (var->green.length == 5) ? 15 : 16;
 }
 
 
--- linux-2.4.22-ac4/drivers/video/intel/intelfbdrv.c	2003-11-05 19:46:46.000000000 +0100
+++ linux-2.4.22-ac4_patched/drivers/video/intel/intelfbdrv.c	2003-11-05 20:00:35.000000000 +0100
@@ -444,7 +444,7 @@
 
 	switch (var->bits_per_pixel) {
 	case 16:
-		return (var->green.length == 6) ? 16 : 15;
+		return (var->green.length == 5) ? 15 : 16;
 	case 32:
 		return 24;
 	default:



--- linux-2.4.22-ac4/drivers/video/imsttfb.c	2002-02-25 20:38:07.000000000 +0100
+++ linux-2.4.22-ac4_patched/drivers/video/imsttfb.c	2003-11-05 20:47:47.000000000 +0100
@@ -1348,12 +1348,12 @@
 #endif
 			break;
 		case 16:	/* RGB 555 or 565 */
-			if (disp->var.green.length != 6)
-				disp->var.red.offset = 10;
+			if (disp->var.green.length != 5)
+				disp->var.red.offset = 11;
 			disp->var.red.length = 5;
 			disp->var.green.offset = 5;
-			if (disp->var.green.length != 6)
-				disp->var.green.length = 5;
+			if (disp->var.green.length != 5)
+				disp->var.green.length = 6;
 			disp->var.blue.offset = 0;
 			disp->var.blue.length = 5;
 			disp->var.transp.offset = 0;
@@ -1495,10 +1495,10 @@
 
 	if (con == currcon) {
 		if (oldgreenlen != disp->var.green.length) {
-			if (disp->var.green.length == 6)
-				set_565(p);
-			else
+			if (disp->var.green.length == 5)
 				set_555(p);
+			else
+				set_565(p);
 		}
 		if (oldxres != disp->var.xres || oldyres != disp->var.yres || oldbpp != disp->var.bits_per_pixel)
 			set_imstt_regvals(p, disp->var.bits_per_pixel);
@@ -1680,10 +1680,10 @@
 		if (!compute_imstt_regvals(p, new->var.xres, new->var.yres))
 			return -1;
 		if (new->var.bits_per_pixel == 16) {
-			if (new->var.green.length == 6)
-				set_565(p);
-			else
+			if (new->var.green.length == 5)
 				set_555(p);
+			else
+				set_565(p);
 		}
 		set_imstt_regvals(p, new->var.bits_per_pixel);
 	}
@@ -1861,10 +1861,10 @@
 
 	if (!noaccel && p->ramdac == IBM)
 		imstt_cursor_init(p);
-	if (p->disp.var.green.length == 6)
-		set_565(p);
-	else
+	if (p->disp.var.green.length == 5)
 		set_555(p);
+	else
+		set_565(p);
 	set_imstt_regvals(p, p->disp.var.bits_per_pixel);
 
 	p->disp.var.pixclock = 1000000 / getclkMHz(p);
