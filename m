Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbVICNei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVICNei (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 09:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbVICNei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 09:34:38 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:57010 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S1750833AbVICNei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 09:34:38 -0400
Date: Sat, 3 Sep 2005 15:34:29 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org
Subject: [PATCH] vga text console and stty cols/rows
Message-ID: <20050903133428.GA4258@implementation>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Some people use 66-cells braille devices for reading the console, and
hence would like to reduce the width of the screen by using:

stty cols 66

However, the vga text console doesn't behave correctly: the 14 first
characters of the second line are put on the right of the first line and
so forth.

Here is a patch to correct that. It corrects the disp_end and offset
registers of the vga board on console resize and console switch.

On usual screens, you then correctly get a right and/or bottom blank
margin. On some laptop panels, the output is resized so that text
actually gets magnified, which can be great for some people (see
http://dept-info.labri.fr/~thibault/ls.jpg ).

Regards,
Samuel

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

--- linux-2.6.13/drivers/video/console/vgacon.c	2005-09-02 18:18:38.000000000 +0200
+++ linux/drivers/video/console/vgacon.c	2005-09-03 01:18:05.000000000 +0200
@@ -497,6 +497,56 @@ static void vgacon_cursor(struct vc_data
 	}
 }
 
+static int vgacon_doresize(struct vc_data *c,
+		unsigned int width, unsigned int height) {
+	unsigned long flags;
+	unsigned int scanlines = height * c->vc_font.height;
+	u8 scanlines_lo, r7, vsync_end, mode;
+
+	spin_lock_irqsave(&vga_lock, flags);
+
+	outb_p(VGA_CRTC_MODE, vga_video_port_reg);
+	mode = inb_p(vga_video_port_val);
+
+	if (mode & 0x04)
+		scanlines >>= 1;
+
+	scanlines -= 1;
+	scanlines_lo = scanlines & 0xff;
+
+	outb_p(VGA_CRTC_OVERFLOW, vga_video_port_reg);
+	r7 = inb_p(vga_video_port_val) & ~0x42;
+
+	if (scanlines & 0x100)
+		r7 |= 0x02;
+	if (scanlines & 0x200)
+		r7 |= 0x40;
+
+	/* deprotect registers */
+	outb_p(VGA_CRTC_V_SYNC_END, vga_video_port_reg);
+	vsync_end = inb_p(vga_video_port_val);
+	outb_p(VGA_CRTC_V_SYNC_END, vga_video_port_reg);
+	outb_p(vsync_end & ~0x80, vga_video_port_val);
+
+	outb_p(VGA_CRTC_H_DISP, vga_video_port_reg);
+	outb_p(width - 1, vga_video_port_val);
+	outb_p(VGA_CRTC_OFFSET, vga_video_port_reg);
+	outb_p(width >> 1, vga_video_port_val);
+
+	outb_p(VGA_CRTC_V_DISP_END, vga_video_port_reg);
+	outb_p(scanlines_lo, vga_video_port_val);
+	outb_p(VGA_CRTC_OVERFLOW, vga_video_port_reg);
+	outb_p(r7,vga_video_port_val);
+
+	/* reprotect registers */
+	outb_p(VGA_CRTC_V_SYNC_END, vga_video_port_reg);
+	outb_p(vsync_end, vga_video_port_val);
+
+	spin_unlock_irqrestore(&vga_lock, flags);
+
+	return 0;
+}
+
 static int vgacon_switch(struct vc_data *c)
 {
 	/*
@@ -510,9 +560,12 @@ static int vgacon_switch(struct vc_data 
 	/* We can only copy out the size of the video buffer here,
 	 * otherwise we get into VGA BIOS */
 
-	if (!vga_is_gfx)
+	if (!vga_is_gfx) {
 		scr_memcpyw((u16 *) c->vc_origin, (u16 *) c->vc_screenbuf,
 			    c->vc_screenbuf_size > vga_vram_size ? vga_vram_size : c->vc_screenbuf_size);
+		vgacon_doresize(c, c->vc_cols, c->vc_rows);
+	}
+
 	return 0;		/* Redrawing not needed */
 }
 
@@ -962,6 +1015,15 @@ static int vgacon_font_get(struct vc_dat
 
 #endif
 
+static int vgacon_resize(struct vc_data *c, unsigned int width, unsigned int height) {
+	if (width % 2 || width > ORIG_VIDEO_COLS || height > ORIG_VIDEO_LINES)
+		return -EINVAL;
+
+	if (CON_IS_VISIBLE(c) && !vga_is_gfx) /* who knows */
+		vgacon_doresize(c, width, height);
+	return 0;
+}
+
 static int vgacon_scrolldelta(struct vc_data *c, int lines)
 {
 	if (!lines)		/* Turn scrollback off */
@@ -1103,6 +1165,7 @@ const struct consw vga_con = {
 	.con_blank = vgacon_blank,
 	.con_font_set = vgacon_font_set,
 	.con_font_get = vgacon_font_get,
+	.con_resize = vgacon_resize,
 	.con_set_palette = vgacon_set_palette,
 	.con_scrolldelta = vgacon_scrolldelta,
 	.con_set_origin = vgacon_set_origin,
