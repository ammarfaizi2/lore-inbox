Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264244AbUDSCSj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 22:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264249AbUDSCSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 22:18:38 -0400
Received: from havoc.gtf.org ([216.162.42.101]:17118 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264244AbUDSCSg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 22:18:36 -0400
Date: Sun, 18 Apr 2004 22:18:31 -0400
From: David Eger <eger@havoc.gtf.org>
To: Timothy Miller <miller@techsource.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: radeonfb broken
Message-ID: <20040419021831.GA27877@havoc.gtf.org>
References: <20040415202523.GA17316@codeblau.de> <407EFB08.6050307@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407EFB08.6050307@techsource.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My apologies; the bug is mine.  It's a simple issue of taking care
of overlapping regions in calls to copyarea().  I sent the fix to the
linux-fbdev mailing list earlier today.   The patch is reprinted below;
Hopefully Linus will take it for 2.6.6.

-dte

--- drivers/video/aty/radeon_accel.c.orig	2004-04-19 01:26:52.000000000 +0200
+++ drivers/video/aty/radeon_accel.c	2004-04-19 01:49:14.000000000 +0200
@@ -53,6 +53,18 @@
 static void radeonfb_prim_copyarea(struct radeonfb_info *rinfo, 
 				   const struct fb_copyarea *area)
 {
+	int xdir, ydir;
+	u32 sx, sy, dx, dy, w, h;
+
+	w = area->width; h = area->height;
+	dx = area->dx; dy = area->dy;
+	sx = area->sx; sy = area->sy;
+	xdir = sx - dx;
+	ydir = sy - dy;
+
+	if ( xdir < 0 ) { sx += w-1; dx += w-1; }
+	if ( ydir < 0 ) { sy += h-1; dy += h-1; }
+
 	radeon_fifo_wait(3);
 	OUTREG(DP_GUI_MASTER_CNTL,
 		rinfo->dp_gui_master_cntl /* i.e. GMC_DST_32BPP */
@@ -60,12 +72,13 @@
 		| ROP3_S 
 		| DP_SRC_RECT );
 	OUTREG(DP_WRITE_MSK, 0xffffffff);
-	OUTREG(DP_CNTL, (DST_X_LEFT_TO_RIGHT | DST_Y_TOP_TO_BOTTOM));
+	OUTREG(DP_CNTL, (xdir>=0 ? DST_X_LEFT_TO_RIGHT : 0)
+			| (ydir>=0 ? DST_Y_TOP_TO_BOTTOM : 0));
 
 	radeon_fifo_wait(3);
-	OUTREG(SRC_Y_X, (area->sy << 16) | area->sx);
-	OUTREG(DST_Y_X, (area->dy << 16) | area->dx);
-	OUTREG(DST_HEIGHT_WIDTH, (area->height << 16) | area->width);
+	OUTREG(SRC_Y_X, (sy << 16) | sx);
+	OUTREG(DST_Y_X, (dy << 16) | dx);
+	OUTREG(DST_HEIGHT_WIDTH, (h << 16) | w);
 }
 
 
