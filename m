Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262165AbUCQXZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbUCQXZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:25:10 -0500
Received: from aea152.neoplus.adsl.tpnet.pl ([83.31.137.152]:3844 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S262165AbUCQXY5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:24:57 -0500
Date: Thu, 18 Mar 2004 00:31:35 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH 2.6][RESEND] fbcon margins colour fix
Message-ID: <20040317233135.GB3510@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I sent it a few times to linux-kernel and at least one to
linux-fbdev-devel, but haven't seen any comments - and this annoying
changing margins colour seems to be still there in 2.6.4 (at least on
tdfxfb).


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-fbcon-margins.patch"

This fixes "margin colour" (colour used to clear top and bottom margins -
e.g. remaining half of line at the bottom of 100x37 console on 800x600
framebuffer).

I don't know what was the intention behind using attr_bgcol_ec() here,
but it caused using of background colour of last erase character to clear
margins (thus it was changing from time to time when switching consoles
or so).
I think that margin colour should be equal overscan colour, which seems
to be always black.
This patch changes margin colour to black (or colour 0 in palette modes)
in accel_clear_margins() and removes unused then bgshift variable.

	-- Jakub Bogusz <qboosh@pld-linux.org>

--- linux-2.6.4/drivers/video/console/fbcon.c.orig	2004-03-11 03:55:36.000000000 +0100
+++ linux-2.6.4/drivers/video/console/fbcon.c	2004-03-17 20:47:38.749388312 +0100
@@ -489,7 +489,6 @@
 void accel_clear_margins(struct vc_data *vc, struct fb_info *info,
 				int bottom_only)
 {
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	unsigned int cw = vc->vc_font.width;
 	unsigned int ch = vc->vc_font.height;
 	unsigned int rw = info->var.xres - (vc->vc_cols*cw);
@@ -498,7 +497,7 @@
 	unsigned int bs = info->var.yres - bh;
 	struct fb_fillrect region;
 
-	region.color = attr_bgcol_ec(bgshift, vc);
+	region.color = 0; /* margins color = overscan color */
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {

--jI8keyz6grp/JLjh--
