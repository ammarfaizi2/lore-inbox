Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269869AbTGOXJS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 19:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269870AbTGOXJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 19:09:17 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:32141 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S269869AbTGOXJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 19:09:12 -0400
Date: Wed, 16 Jul 2003 01:23:57 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
Subject: [PATCH] Make matroxfb independent of console subsystem
Message-ID: <20030715232357.GG17421@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,
  There is write-only 'palette' member in matroxfb which
was used for storing palette contents in the past. Now 
when generic layer takes care of reading palette registers,
it is possible to remove it.  And as a bonus matroxfb can be
built to the kernel without console support after change.

 matroxfb_base.c  |   18 ------------------
 matroxfb_base.h  |    1 -
 matroxfb_crtc2.c |    4 ----
 matroxfb_crtc2.h |    1 -
 4 files changed, 24 deletions(-)

					Thanks,
						Petr Vandrovec


diff -urdN linux/drivers/video/matrox/matroxfb_base.c linux/drivers/video/matrox/matroxfb_base.c
--- linux/drivers/video/matrox/matroxfb_base.c	2003-07-15 23:59:51.000000000 +0200
+++ linux/drivers/video/matrox/matroxfb_base.c	2003-07-16 00:14:35.000000000 +0200
@@ -627,11 +627,6 @@
 	if (regno >= ACCESS_FBINFO(curr.cmap_len))
 		return 1;
 
-	ACCESS_FBINFO(palette[regno].red)   = red;
-	ACCESS_FBINFO(palette[regno].green) = green;
-	ACCESS_FBINFO(palette[regno].blue)  = blue;
-	ACCESS_FBINFO(palette[regno].transp) = transp;
-
 	if (ACCESS_FBINFO(fbcon).var.grayscale) {
 		/* gray = 0.30*R + 0.59*G + 0.11*B */
 		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
@@ -748,19 +743,6 @@
 		else
 			ACCESS_FBINFO(curr.ydstorg.pixels) = (ydstorg * 8) / var->bits_per_pixel;
 		ACCESS_FBINFO(curr.final_bppShift) = matroxfb_get_final_bppShift(PMINFO var->bits_per_pixel);
-		if (visual == MX_VISUAL_PSEUDOCOLOR) {
-			int i;
-
-			for (i = 0; i < 16; i++) {
-				int j;
-
-				j = color_table[i];
-				ACCESS_FBINFO(palette[i].red)   = default_red[j];
-				ACCESS_FBINFO(palette[i].green) = default_grn[j];
-				ACCESS_FBINFO(palette[i].blue)  = default_blu[j];
-			}
-		}
-
 		{	struct my_timming mt;
 			struct matrox_hw_state* hw;
 			int out;
diff -urdN linux/drivers/video/matrox/matroxfb_base.h linux/drivers/video/matrox/matroxfb_base.h
--- linux/drivers/video/matrox/matroxfb_base.h	2003-07-15 23:59:02.000000000 +0200
+++ linux/drivers/video/matrox/matroxfb_base.h	2003-07-16 00:13:37.000000000 +0200
@@ -595,7 +595,6 @@
 					dll:1;
 				      } memory;
 			      } values;
-	struct { unsigned red, green, blue, transp; } palette[256];
 	u_int32_t cmap[17];
 };
 
diff -urdN linux/drivers/video/matrox/matroxfb_crtc2.c linux/drivers/video/matrox/matroxfb_crtc2.c
--- linux/drivers/video/matrox/matroxfb_crtc2.c	2003-07-16 00:00:26.000000000 +0200
+++ linux/drivers/video/matrox/matroxfb_crtc2.c	2003-07-16 00:14:04.000000000 +0200
@@ -33,10 +33,6 @@
 
 	if (regno >= 16)
 		return 1;
-	m2info->palette[regno].red = red;
-	m2info->palette[regno].blue = blue;
-	m2info->palette[regno].green = green;
-	m2info->palette[regno].transp = transp;
 	if (m2info->fbcon.var.grayscale) {
 		/* gray = 0.30*R + 0.59*G + 0.11*B */
 		red = green = blue = (red * 77 + green * 151 + blue * 28) >> 8;
diff -urdN linux/drivers/video/matrox/matroxfb_crtc2.h linux/drivers/video/matrox/matroxfb_crtc2.h
--- linux/drivers/video/matrox/matroxfb_crtc2.h	2003-07-15 23:57:41.000000000 +0200
+++ linux/drivers/video/matrox/matroxfb_crtc2.h	2003-07-16 00:13:43.000000000 +0200
@@ -30,7 +30,6 @@
 	int			interlaced:1;
 
 	u_int32_t cmap[17];
-	struct { unsigned red, green, blue, transp; } palette[17];
 };
 
 #endif /* __MATROXFB_CRTC2_H__ */
