Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVKNBXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVKNBXr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 20:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVKNBXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 20:23:47 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:35503 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750820AbVKNBXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 20:23:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=I9daVlvOY3Hgi0pdAZ0vcv98Rjb3XEF2lpJRkQj7GSvaNwy5Mo7zaj1Rw6rPoRTYRGAHI5/T8RRKZts8Doi4U+XtWp6m+DVgZk3IvR5OV0rWFKeOqkdrWeswTW4Z2Vr/j0EPoA7gk0k89eJhzy5XdmW/PC/n/F23q4fAy2GT2Q0=
Message-ID: <4377E70A.8080609@gmail.com>
Date: Mon, 14 Nov 2005 09:23:22 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Wayne E. Harlan" <drharlan@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14.x kernel bug
References: <tkrat.9182ac9c6a13ef52@pacbell.net>
In-Reply-To: <tkrat.9182ac9c6a13ef52@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne E. Harlan wrote:
> I have found what appears to be a bug in versions 2.6.14 and following.
> Currently I have verified it in 2.6.14 as well as 2.6.14.2.  Here are the
> items requested on the web site
> http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html.
> -------------------------
> 
> [1.] One line summary of the problem:
> When the kernel option "vga=1" is used, additional tty's (alt+control+Fx
> with x=2,3,4,5, etc) do not provide the full 50 lines of output.  The first
> one does have 50 lines, however.
> 
> [2.] Full description of the problem/report:
> These addtitional tty's show only 39 lines plus the top pixel of the 40-th
> line.  The remaining lines are black and not shown.  Kernel version
> 2.6.13.4 does not show this problem.
> 

If you change the font to 8x16, with setfont for example, does it correct the
problem?  How about if you change back again to an 8x8 font? What is the
output of stty -a before and after each changes?

If nothing works, can you try this patch?

Tony

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

