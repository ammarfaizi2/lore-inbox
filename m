Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVBSXpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVBSXpi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 18:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVBSXpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 18:45:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:36031 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262275AbVBSXpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 18:45:23 -0500
Subject: [PATCH] radeonfb: Workaround memory corruption accel problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
In-Reply-To: <1108855933.5584.2.camel@gaston>
References: <1108710554.5587.1.camel@gaston>
	 <1108855933.5584.2.camel@gaston>
Content-Type: text/plain
Date: Sun, 20 Feb 2005 10:45:08 +1100
Message-Id: <1108856708.5369.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

A conflict between X and radeonfb can cause system memory corruption
when switching console from X (note that this is not realted to the
recent radeonfb patches, the problem has been there forever as far as I
can tell).

This patch works around it in radeonfb by making sure the "offsets"
register that driver the memory mapping of the accel engine are always
properly set before every accel op. A better fix should be done in fbcon
ultimately.

Please apply to 2.6.11

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/aty/radeon_accel.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_accel.c	2005-01-24 17:09:44.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_accel.c	2005-02-20 10:41:37.000000000 +1100
@@ -4,6 +4,41 @@
  * "ACCEL_MMIO" ifdef branches in XFree86
  * --dte
  */
+
+static void radeon_fixup_offset(struct radeonfb_info *rinfo)
+{
+	u32 local_base;
+
+	/* *** Ugly workaround *** */
+	/*
+	 * On some platforms, the video memory is mapped at 0 in radeon chip space
+	 * (like PPCs) by the firmware. X will always move it up so that it's seen
+	 * by the chip to be at the same address as the PCI BAR.
+	 * That means that when switching back from X, there is a mismatch between
+	 * the offsets programmed into the engine. This means that potentially,
+	 * accel operations done before radeonfb has a chance to re-init the engine
+	 * will have incorrect offsets, and potentially trash system memory !
+	 *
+	 * The correct fix is for fbcon to never call any accel op before the engine
+	 * has properly been re-initialized (by a call to set_var), but this is a
+	 * complex fix. This workaround in the meantime, called before every accel
+	 * operation, makes sure the offsets are in sync.
+	 */
+
+	radeon_fifo_wait (1);
+	local_base = INREG(MC_FB_LOCATION) << 16;
+	if (local_base == rinfo->fb_local_base)
+		return;
+
+	rinfo->fb_local_base = local_base;
+
+	radeon_fifo_wait (3);
+	OUTREG(DEFAULT_PITCH_OFFSET, (rinfo->pitch << 0x16) |
+				     (rinfo->fb_local_base >> 10));
+	OUTREG(DST_PITCH_OFFSET, (rinfo->pitch << 0x16) | (rinfo->fb_local_base >> 10));
+	OUTREG(SRC_PITCH_OFFSET, (rinfo->pitch << 0x16) | (rinfo->fb_local_base >> 10));
+}
+
 static void radeonfb_prim_fillrect(struct radeonfb_info *rinfo, 
 				   const struct fb_fillrect *region)
 {
@@ -38,6 +73,8 @@
 		return;
 	}
 
+	radeon_fixup_offset(rinfo);
+
 	vxres = info->var.xres_virtual;
 	vyres = info->var.yres_virtual;
 
@@ -105,6 +142,8 @@
 		return;
 	}
 
+	radeon_fixup_offset(rinfo);
+
 	vxres = info->var.xres_virtual;
 	vyres = info->var.yres_virtual;
 



