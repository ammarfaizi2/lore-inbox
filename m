Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264579AbUEJN2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264579AbUEJN2A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 09:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264652AbUEJN2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 09:28:00 -0400
Received: from havoc.gtf.org ([216.162.42.101]:3994 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264579AbUEJN16 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 09:27:58 -0400
Date: Mon, 10 May 2004 09:27:57 -0400
From: David Eger <eger@havoc.gtf.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6
Message-ID: <20040510132756.GA16907@havoc.gtf.org>
References: <Pine.LNX.4.58.0405091954240.3028@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405091954240.3028@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2004 at 07:58:01PM -0700, Linus Torvalds wrote:
> 
> Holler if I missed anything,

The -mm branch has two radeonfb bug fixes; please apply them.
One is BenH's.  Mine, which fixes a corruption problem with
overlapping copyarea()'s is below.

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
 
 
