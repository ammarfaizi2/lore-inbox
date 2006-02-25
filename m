Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932641AbWBYAU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641AbWBYAU5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 19:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbWBYAU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 19:20:57 -0500
Received: from mailfe08.tele2.fr ([212.247.154.236]:61676 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S932641AbWBYAUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 19:20:55 -0500
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Sat, 25 Feb 2006 01:20:30 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@pol.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: [Bugme-new] [Bug 6106] New: EGA problem since 2.6.14
Message-ID: <20060225002030.GA4461@bouh.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>,
	"Antonino A. Daplas" <adaplas@pol.net>,
	linux-kernel@vger.kernel.org
References: <20060219135521.69e9c974.akpm@osdl.org> <20060222014102.GB4956@bouh.residence.ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060222014102.GB4956@bouh.residence.ens-lyon.fr>
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is another fixup for EGA cursor resize function.

This corrects cursor resize on ega boards: registers are write-only, so
we shouldn't even try to read them. And on ega, 31/30 produces a flat
cursor. Using 31/31 is better: except with 32 pixels high fonts, it
shouldn't show up.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

--- drivers/video/console/vgacon.c.git	2006-02-24 10:43:25.000000000 +0100
+++ drivers/video/console/vgacon.c	2006-02-25 01:17:17.000000000 +0100
@@ -433,17 +433,22 @@ static void vgacon_set_cursor_size(int x
 	cursor_size_lastto = to;
 
 	spin_lock_irqsave(&vga_lock, flags);
-	outb_p(0x0a, vga_video_port_reg);	/* Cursor start */
-	curs = inb_p(vga_video_port_val);
-	outb_p(0x0b, vga_video_port_reg);	/* Cursor end */
-	cure = inb_p(vga_video_port_val);
+	if (vga_video_type >= VIDEO_TYPE_VGAC) {
+		outb_p(VGA_CRTC_CURSOR_START, vga_video_port_reg);
+		curs = inb_p(vga_video_port_val);
+		outb_p(VGA_CRTC_CURSOR_END, vga_video_port_reg);
+		cure = inb_p(vga_video_port_val);
+	} else {
+		curs = 0;
+		cure = 0;
+	}
 
 	curs = (curs & 0xc0) | from;
 	cure = (cure & 0xe0) | to;
 
-	outb_p(0x0a, vga_video_port_reg);	/* Cursor start */
+	outb_p(VGA_CRTC_CURSOR_START, vga_video_port_reg);
 	outb_p(curs, vga_video_port_val);
-	outb_p(0x0b, vga_video_port_reg);	/* Cursor end */
+	outb_p(VGA_CRTC_CURSOR_END, vga_video_port_reg);
 	outb_p(cure, vga_video_port_val);
 	spin_unlock_irqrestore(&vga_lock, flags);
 }
@@ -455,7 +460,10 @@ static void vgacon_cursor(struct vc_data
 	switch (mode) {
 	case CM_ERASE:
 		write_vga(14, (c->vc_pos - vga_vram_base) / 2);
-		vgacon_set_cursor_size(c->vc_x, 31, 30);
+	        if (vga_video_type >= VIDEO_TYPE_VGAC)
+			vgacon_set_cursor_size(c->vc_x, 31, 30);
+		else
+			vgacon_set_cursor_size(c->vc_x, 31, 31);
 		break;
 
 	case CM_MOVE:
@@ -493,7 +501,10 @@ static void vgacon_cursor(struct vc_data
 						10 ? 1 : 2));
 			break;
 		case CUR_NONE:
-			vgacon_set_cursor_size(c->vc_x, 31, 30);
+			if (vga_video_type >= VIDEO_TYPE_VGAC)
+				vgacon_set_cursor_size(c->vc_x, 31, 30);
+			else
+				vgacon_set_cursor_size(c->vc_x, 31, 31);
 			break;
 		default:
 			vgacon_set_cursor_size(c->vc_x, 1,
