Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275527AbTHNUTM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 16:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275529AbTHNUTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 16:19:11 -0400
Received: from pv36.warszawa.cvx.ppp.tpnet.pl ([217.99.5.36]:30985 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S275527AbTHNUTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 16:19:04 -0400
Date: Thu, 14 Aug 2003 22:13:25 +0200
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] tdfxfb in 2.6: fix for background used in fbcon_clear
Message-ID: <20030814201325.GB27236@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: Black Hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It was already posted to linux-fbdev-devel, but I haven't got any
comments...
Attached patch is rather simple and obvious.

----- Forwarded message from Jakub Bogusz <qboosh at pld.org.pl> -----

Date: Thu, 31 Jul 2003 01:43:27 +0200
From: Jakub Bogusz <qboosh at pld.org.pl>
To: linux-fbdev-devel at lists.sourceforge.net
Subject: [PATCH] tdfxfb: fix for background used in fbcon_clear

Hello,

This time I checked recent linux-fbdev-devel archives - and didn't see
any patch for this issue. So here is my fix.

There was wrong color used in fillrect in 16/24/32bpp (pseudo_palette
mapping was omitted), which resulted in ugly black (well, almost black)
rectangles painted when some "clear" terminal command was sent (like
"^[[J", "^[[K") with background colour different than black.
It was visible e.g. in mc's View.

[...]

-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/

--ZPt4rx8FFjLCG7dd
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

--ZPt4rx8FFjLCG7dd--
