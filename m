Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbVKLWVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbVKLWVF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 17:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVKLWVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 17:21:04 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:62282 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932503AbVKLWVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 17:21:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=mnAvEzt9xeWx/Ni1KsXpq9c6qJMJcMx4AvR6ijgECdEoqI2pBkj/fTd5R3A7H4cuLlJGDr/6gGlVSH2AEWl1L0Bn9lePBs88dnIECzBlNzs9pPHoJkiHSNHZjfCyJdFcTes9KhkS9/ktYxqg4AXAP4JybpY+EXL5G2l0kkloDcw=
Message-ID: <43766AC5.9080406@gmail.com>
Date: Sun, 13 Nov 2005 06:20:53 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
CC: Dave Jones <davej@redhat.com>, Jason <dravet@hotmail.com>,
       Samuel Thibault <samuel.thibault@ens-lyon.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: [PATCH] vgacon: Workaround for resize bug in some chipsets
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reported from Redhat Bugzilla Bug 170450

"I updated to the development kernel and now during boot only the top of the
text is visable. For example the monitor screen the is the lines and I can
only  see text in the asterik area.
---------------------
| ****************  |
| *              *  |
| *              *  |
| ****************  |
|                   |
|                   |
|                   |
---------------------

I have a Silicon Graphics 1600sw LCD panel with a Number Nine Revolution 4
video card."

This bug seems to be a glitch in the VGA core of this chipset.  Resizing
the screen triggers the mentioned bug.

The workaround is to make vgacon avoid calling vgacon_doresize() if the
display parameters did not change. It also has a nice side effect of faster
console switches, but that will be barely noticeable.

Note that this bug may be triggered if the user changes the screen height
with stty, or using another font with different dimensions.

A definitive fix will need to be provided by someone who knows and has the
hardware.

This patch also converted hard-coded constants to a named constant
(VGACON_FONTWIDTH).

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 vgacon.c |   28 +++++++++++++++++++++-------
 1 files changed, 21 insertions(+), 7 deletions(-)


diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 274f905..5ce8348 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -56,6 +56,8 @@
 static DEFINE_SPINLOCK(vga_lock);
 static int cursor_size_lastfrom;
 static int cursor_size_lastto;
+static u32 vgacon_xres;
+static u32 vgacon_yres;
 static struct vgastate state;
 
 #define BLANK 0x0020
@@ -69,7 +71,7 @@ static struct vgastate state;
  * appear.
  */
 #undef TRIDENT_GLITCH
-
+#define VGA_FONTWIDTH       8   /* VGA does not support fontwidths != 8 */
 /*
  *  Interface used by the world
  */
@@ -325,6 +327,10 @@ static const char __init *vgacon_startup
 		vga_scan_lines =
 		    vga_video_font_height * vga_video_num_lines;
 	}
+
+	vgacon_xres = ORIG_VIDEO_COLS * VGA_FONTWIDTH;
+	vgacon_yres = vga_scan_lines;
+
 	return display_desc;
 }
 
@@ -507,6 +513,8 @@ static int vgacon_doresize(struct vc_dat
 
 	spin_lock_irqsave(&vga_lock, flags);
 
+	vgacon_xres = width * VGA_FONTWIDTH;
+	vgacon_yres = height * c->vc_font.height;
 	outb_p(VGA_CRTC_MODE, vga_video_port_reg);
 	mode = inb_p(vga_video_port_val);
 
@@ -551,6 +559,10 @@ static int vgacon_doresize(struct vc_dat
 
 static int vgacon_switch(struct vc_data *c)
 {
+	int x = c->vc_cols * VGA_FONTWIDTH;
+	int y = c->vc_rows * c->vc_font.height;
+	int rows = ORIG_VIDEO_LINES * vga_default_font_height/
+		c->vc_font.height;
 	/*
 	 * We need to save screen size here as it's the only way
 	 * we can spot the screen has been resized and we need to
@@ -566,10 +578,11 @@ static int vgacon_switch(struct vc_data 
 		scr_memcpyw((u16 *) c->vc_origin, (u16 *) c->vc_screenbuf,
 			    c->vc_screenbuf_size > vga_vram_size ?
 				vga_vram_size : c->vc_screenbuf_size);
-		if (!(vga_video_num_columns % 2) &&
-		    vga_video_num_columns <= ORIG_VIDEO_COLS &&
-		    vga_video_num_lines <= (ORIG_VIDEO_LINES *
-			vga_default_font_height) / c->vc_font.height)
+
+		if ((vgacon_xres != x || vgacon_yres != y) &&
+		    (!(vga_video_num_columns % 2) &&
+		     vga_video_num_columns <= ORIG_VIDEO_COLS &&
+		     vga_video_num_lines <= rows))
 			vgacon_doresize(c, c->vc_cols, c->vc_rows);
 	}
 
@@ -992,7 +1005,8 @@ static int vgacon_font_set(struct vc_dat
 	if (vga_video_type < VIDEO_TYPE_EGAM)
 		return -EINVAL;
 
-	if (font->width != 8 || (charcount != 256 && charcount != 512))
+	if (font->width != VGA_FONTWIDTH ||
+	    (charcount != 256 && charcount != 512))
 		return -EINVAL;
 
 	rc = vgacon_do_font_op(&state, font->data, 1, charcount == 512);
@@ -1009,7 +1023,7 @@ static int vgacon_font_get(struct vc_dat
 	if (vga_video_type < VIDEO_TYPE_EGAM)
 		return -EINVAL;
 
-	font->width = 8;
+	font->width = VGA_FONTWIDTH;
 	font->height = c->vc_font.height;
 	font->charcount = vga_512_chars ? 512 : 256;
 	if (!font->data)
