Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161642AbWAMDTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161642AbWAMDTQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161648AbWAMDTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:19:16 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:25731 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161642AbWAMDTP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:19:15 -0500
Message-Id: <20060113032242.425265000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:44 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, samuel.thibault@ens-lyon.org,
       dravet@hotmail.com
Subject: [PATCH 06/17] [PATCH] vgacon: fix doublescan mode
Content-Disposition: inline; filename=vgacon-fix-doublescan-mode.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

When doublescan mode is in use, scanlines must be doubled.

Thanks to Jason Dravet <dravet@hotmail.com> for reporting and testing.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/video/console/vgacon.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- linux-2.6.15.y.orig/drivers/video/console/vgacon.c
+++ linux-2.6.15.y/drivers/video/console/vgacon.c
@@ -503,10 +503,16 @@ static int vgacon_doresize(struct vc_dat
 {
 	unsigned long flags;
 	unsigned int scanlines = height * c->vc_font.height;
-	u8 scanlines_lo, r7, vsync_end, mode;
+	u8 scanlines_lo, r7, vsync_end, mode, max_scan;
 
 	spin_lock_irqsave(&vga_lock, flags);
 
+	outb_p(VGA_CRTC_MAX_SCAN, vga_video_port_reg);
+	max_scan = inb_p(vga_video_port_val);
+
+	if (max_scan & 0x80)
+		scanlines <<= 1;
+
 	outb_p(VGA_CRTC_MODE, vga_video_port_reg);
 	mode = inb_p(vga_video_port_val);
 

--
