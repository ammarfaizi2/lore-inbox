Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271938AbTG2WRw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 18:17:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272059AbTG2WRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 18:17:52 -0400
Received: from px125.warszawa.cvx.ppp.tpnet.pl ([217.99.7.125]:2308 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S271938AbTG2WRu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 18:17:50 -0400
Date: Wed, 30 Jul 2003 00:14:11 +0200
From: Jakub Bogusz <qboosh@pld.org.pl>
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: PATCH: tdfxfb palette fix for 2.6.0-test2
Message-ID: <20030729221411.GA3434@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: PLD Linux Distribution
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

In 2.6.0-test2 text palette is broken in 16/24/32bpp modes on tdfxfb
console (because of not using component length information).
This patch fixes it; see also note inside.


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/

--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-tdfxfb-palette.patch"

This fixes palette used for text in 16/24/32bpp modes on tdfxfb console.
Note that pseudo_palette is always referenced as array od 32-bit uints
in cfbimgblt.c, regardless of current bpp.

--- linux-2.6.0-test2/drivers/video/tdfxfb.c.orig	2003-07-14 05:32:29.000000000 +0200
+++ linux-2.6.0-test2/drivers/video/tdfxfb.c	2003-07-29 23:42:07.000000000 +0200
@@ -559,6 +559,8 @@
 			var->red.length = var->green.length = var->blue.length = 8;
 			break;
 	}
+	var->transp.offset = 32;
+	var->transp.length = 0;
 	var->height = var->width = -1;
   
 	var->accel_flags = FB_ACCELF_TEXT;
@@ -788,14 +790,10 @@
 			break;
 		/* Truecolor has no hardware color palettes. */
 		case FB_VISUAL_TRUECOLOR:
-			rgbcol = (red << info->var.red.offset) |
-				 (green << info->var.green.offset) |
-				 (blue << info->var.blue.offset) |
-				 (transp << info->var.transp.offset);
-			if (info->var.bits_per_pixel <= 16)
-				((u16*)(info->pseudo_palette))[regno] = rgbcol;
-			else
-				((u32*)(info->pseudo_palette))[regno] = rgbcol;
+			rgbcol = ((red >> (16 - info->var.red.length)) << info->var.red.offset) |
+				 ((green >> (16 - info->var.green.length)) << info->var.green.offset) |
+				 ((blue >> (16 - info->var.blue.length)) << info->var.blue.offset);
+			((u32*)(info->pseudo_palette))[regno] = rgbcol;
 			break;
 		default:
 			DPRINTK("bad depth %u\n", info->var.bits_per_pixel);

--u3/rZRmxL6MmkK24--
