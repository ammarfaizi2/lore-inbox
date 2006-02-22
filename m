Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbWBVBlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbWBVBlP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 20:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWBVBlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 20:41:15 -0500
Received: from mailfe08.tele2.fr ([212.247.154.236]:38371 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932362AbWBVBlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 20:41:14 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Wed, 22 Feb 2006 02:41:02 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "Antonino A. Daplas" <adaplas@pol.net>, linux-kernel@vger.kernel.org
Subject: Re: Fw: [Bugme-new] [Bug 6106] New: EGA problem since 2.6.14
Message-ID: <20060222014102.GB4956@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>,
	"Antonino A. Daplas" <adaplas@pol.net>,
	linux-kernel@vger.kernel.org
References: <20060219135521.69e9c974.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060219135521.69e9c974.akpm@osdl.org>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is a fixup (vgacon-no-vertical-resize-on-ega):

EGA boards suck: they mostly have write-only registers. This is
particularly problematic for the overflow register: for being able to
write to it, we would have to handle vertical sync & such too, which
(I'd say) would potentially break a lot of configurations. Instead, just
disabling vertical resize for EGA boards is just nice enough (horizontal
resize still works).

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

--- drivers/video/console/vgacon.c.2.6.15.4	2006-02-22 01:35:49.000000000 +0100
+++ drivers/video/console/vgacon.c	2006-02-22 01:43:41.000000000 +0100
@@ -503,52 +503,56 @@ static int vgacon_doresize(struct vc_dat
 {
 	unsigned long flags;
 	unsigned int scanlines = height * c->vc_font.height;
-	u8 scanlines_lo, r7, vsync_end, mode, max_scan;
+	u8 scanlines_lo = 0, r7 = 0, vsync_end = 0, mode, max_scan;
 
 	spin_lock_irqsave(&vga_lock, flags);
 
-	outb_p(VGA_CRTC_MAX_SCAN, vga_video_port_reg);
-	max_scan = inb_p(vga_video_port_val);
-
-	if (max_scan & 0x80)
-		scanlines <<= 1;
-
-	outb_p(VGA_CRTC_MODE, vga_video_port_reg);
-	mode = inb_p(vga_video_port_val);
-
-	if (mode & 0x04)
-		scanlines >>= 1;
-
-	scanlines -= 1;
-	scanlines_lo = scanlines & 0xff;
-
-	outb_p(VGA_CRTC_OVERFLOW, vga_video_port_reg);
-	r7 = inb_p(vga_video_port_val) & ~0x42;
-
-	if (scanlines & 0x100)
-		r7 |= 0x02;
-	if (scanlines & 0x200)
-		r7 |= 0x40;
-
-	/* deprotect registers */
-	outb_p(VGA_CRTC_V_SYNC_END, vga_video_port_reg);
-	vsync_end = inb_p(vga_video_port_val);
-	outb_p(VGA_CRTC_V_SYNC_END, vga_video_port_reg);
-	outb_p(vsync_end & ~0x80, vga_video_port_val);
+	if (vga_video_type >= VIDEO_TYPE_VGAC) {
+		outb_p(VGA_CRTC_MAX_SCAN, vga_video_port_reg);
+		max_scan = inb_p(vga_video_port_val);
+
+		if (max_scan & 0x80)
+			scanlines <<= 1;
+
+		outb_p(VGA_CRTC_MODE, vga_video_port_reg);
+		mode = inb_p(vga_video_port_val);
+
+		if (mode & 0x04)
+			scanlines >>= 1;
+
+		scanlines -= 1;
+		scanlines_lo = scanlines & 0xff;
+
+		outb_p(VGA_CRTC_OVERFLOW, vga_video_port_reg);
+		r7 = inb_p(vga_video_port_val) & ~0x42;
+
+		if (scanlines & 0x100)
+			r7 |= 0x02;
+		if (scanlines & 0x200)
+			r7 |= 0x40;
+
+		/* deprotect registers */
+		outb_p(VGA_CRTC_V_SYNC_END, vga_video_port_reg);
+		vsync_end = inb_p(vga_video_port_val);
+		outb_p(VGA_CRTC_V_SYNC_END, vga_video_port_reg);
+		outb_p(vsync_end & ~0x80, vga_video_port_val);
+	}
 
 	outb_p(VGA_CRTC_H_DISP, vga_video_port_reg);
 	outb_p(width - 1, vga_video_port_val);
 	outb_p(VGA_CRTC_OFFSET, vga_video_port_reg);
 	outb_p(width >> 1, vga_video_port_val);
 
-	outb_p(VGA_CRTC_V_DISP_END, vga_video_port_reg);
-	outb_p(scanlines_lo, vga_video_port_val);
-	outb_p(VGA_CRTC_OVERFLOW, vga_video_port_reg);
-	outb_p(r7,vga_video_port_val);
-
-	/* reprotect registers */
-	outb_p(VGA_CRTC_V_SYNC_END, vga_video_port_reg);
-	outb_p(vsync_end, vga_video_port_val);
+	if (vga_video_type >= VIDEO_TYPE_VGAC) {
+		outb_p(VGA_CRTC_V_DISP_END, vga_video_port_reg);
+		outb_p(scanlines_lo, vga_video_port_val);
+		outb_p(VGA_CRTC_OVERFLOW, vga_video_port_reg);
+		outb_p(r7,vga_video_port_val);
+
+		/* reprotect registers */
+		outb_p(VGA_CRTC_V_SYNC_END, vga_video_port_reg);
+		outb_p(vsync_end, vga_video_port_val);
+	}
 
 	spin_unlock_irqrestore(&vga_lock, flags);
 
