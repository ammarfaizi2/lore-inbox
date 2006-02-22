Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWBVB66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWBVB66 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 20:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbWBVB66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 20:58:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17029 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932094AbWBVB65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 20:58:57 -0500
Date: Tue, 21 Feb 2006 17:57:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: adaplas@pol.net, linux-kernel@vger.kernel.org
Subject: Re: Fw: [Bugme-new] [Bug 6106] New: EGA problem since 2.6.14
Message-Id: <20060221175710.42579f44.akpm@osdl.org>
In-Reply-To: <20060222014102.GB4956@bouh.residence.ens-lyon.fr>
References: <20060219135521.69e9c974.akpm@osdl.org>
	<20060222014102.GB4956@bouh.residence.ens-lyon.fr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
>
> Here is a fixup (vgacon-no-vertical-resize-on-ega):

Thanks.  I'm 51% inclined to hold this off for 2.6.17 - vgacon seems to be
a bit accident-prone lately.

Your patch was against some prehistoric kernel which didn't have the
vgacon_xres and vgacon_yres initialisations in vgacon_doresize().

Please confirm that this is correct:




From: Samuel Thibault <samuel.thibault@ens-lyon.org>

EGA boards suck: they mostly have write-only registers.  This is
particularly problematic for the overflow register: for being able to write
to it, we would have to handle vertical sync & such too, which (I'd say)
would potentially break a lot of configurations.  Instead, just disabling
vertical resize for EGA boards is just nice enough (horizontal resize still
works).

Fixes http://bugzilla.kernel.org/show_bug.cgi?id=6106

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: Rafal Olearski <olearski@mail2.kim.net.pl>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/console/vgacon.c |   79 ++++++++++++++++---------------
 1 files changed, 41 insertions(+), 38 deletions(-)

diff -puN drivers/video/console/vgacon.c~vgacon-no-vertical-resizing-on-ega drivers/video/console/vgacon.c
--- devel/drivers/video/console/vgacon.c~vgacon-no-vertical-resizing-on-ega	2006-02-21 17:49:40.000000000 -0800
+++ devel-akpm/drivers/video/console/vgacon.c	2006-02-21 17:52:27.000000000 -0800
@@ -509,57 +509,60 @@ static int vgacon_doresize(struct vc_dat
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
 	vgacon_xres = width * VGA_FONTWIDTH;
 	vgacon_yres = height * c->vc_font.height;
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
-
 	return 0;
 }
 
_

