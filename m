Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbTELVWA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262805AbTELVWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:22:00 -0400
Received: from mbox2.netikka.net ([213.250.81.203]:15553 "EHLO
	mbox2.netikka.net") by vger.kernel.org with ESMTP id S262797AbTELVV4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:21:56 -0400
From: Thomas Backlund <tmb@iki.fi>
To: Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.4.21rc2-ac2 [suggested modifications to vesafb]
Date: Tue, 13 May 2003 00:34:33 +0300
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305130034.33944.tmb@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
[...]
> o	Allow user to override vesa video ram		(Thomas Backlund)
[...]
> o	Fix vesafb over allocation of I/O memory	(Adam Mercer)
> | VESA reports ram on card but that may be banked
> | and is more than we need to map. On 128/256Mb
> | cards we really don't want to have this happen

Since this change to the vesafb driver, 
we are actually allocating enough memory to do both doublebuffering and 3D 
(wich IMHO is a _good_ thing)

BUT...
It remaps more memory than the older card actually has... :-(
An example:
video_size = screen_info.lfb_width * screen_info.lfb_height * video_bpp;
translates on my laptop to: 1024 * 768 * 16 = 12288 kilobyte of ram...,
but the graphic card has only 8192 kilobytes of ram...

Now, there are three solutions to this (not counting the vram override):

1. add the previous discussed missing '/ 8' in the formula above...
 - IMHO this is a BAD solution since it removes all features to gain any speed,
   on any card... so keep reading ...



2. use the old calculation to test for video_size does not go above actual video ram... like this ...:

--- cut --- 
--- 2.4.21-rc2-ac2/drivers/video/vesafb.c	2003-05-12 23:14:15.000000000 +0300
+++ 2.4.21-rc2-ac2/drivers/video/vesafb.c.fix	2003-05-12 23:25:24.000000000 +0300
@@ -525,11 +525,19 @@
 	video_width         = screen_info.lfb_width;
 	video_height        = screen_info.lfb_height;
 	video_linelength    = screen_info.lfb_linelength;
-	video_size          = screen_info.lfb_width *	screen_info.lfb_height * video_bpp;
-	/* sets video_size according to vram boot option */
-	if (vram && vram * 1024 * 1024 > video_size)
-		video_size = vram * 1024 * 1024;
-
+
+	/* Remapping memory according to video mode, including space for doublebuffer and 3D */
+	video_size          = screen_info.lfb_width * screen_info.lfb_height * video_bpp;
+
+	/* To make sure we dont remap more videomemory than the system actually has, */
+	/* we use the old videomemory calculation... and sets it if needed ...       */
+
+	if (video_size > screen_info.lfb_size * 65536)
+		video_size = screen_info.lfb_size * 65536;
+
+	/* sets video_size according to vram boot option */
+        if (vram && vram * 1024 * 1024 != video_size)
+                video_size = vram * 1024 * 1024;
 	video_visual = (video_bpp == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;

--- cut ---



3. or we revert to the old system, using the new system only > 64MB videoram ... like this ...

--- cut ---
--- 2.4.21-rc2-ac2/drivers/video/vesafb.c	2003-05-12 23:14:15.000000000 +0300
+++ 2.4.21-rc2-ac2/drivers/video/vesafb.c.oldfix	2003-05-12 23:31:30.000000000 +0300
@@ -525,11 +525,18 @@
 	video_width         = screen_info.lfb_width;
 	video_height        = screen_info.lfb_height;
 	video_linelength    = screen_info.lfb_linelength;
-	video_size          = screen_info.lfb_width *	screen_info.lfb_height * video_bpp;
+
+	/* This one is safe for cards with 64MB or less... */
+	video_size 	    = screen_info.lfb_size * 65536;
+
+	/* If we have a card with more than 64 MB RAM we switch to this: 		     */
+	/* Remapping memory according to video mode, including space for doublebuffer and 3D */
+	if (video_size > 64 * 1024 *1024)
+	video_size          = screen_info.lfb_width * screen_info.lfb_height * video_bpp;
+
 	/* sets video_size according to vram boot option */
-	if (vram && vram * 1024 * 1024 > video_size)
-		video_size = vram * 1024 * 1024;
-
+        if (vram && vram * 1024 * 1024 != video_size)
+                video_size = vram * 1024 * 1024;
 	video_visual = (video_bpp == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;

--- cut ---



Both patches (2 and 3) are tested on my laptop, and it works with both...
And of course the modified vram option takes care of the rest that has problems (if any),
since I don't limit it in any way...

So... Comments ... Please...

And last, but not least...
 - remove the duplicate vram explanation in Docs...
 - modify the docs according to this latest patch ...

--- cut ---
--- 2.4.21-rc2-ac2/Documentation/fb/vesafb.txt	2003-05-12 23:14:11.000000000 +0300
+++ 2.4.21-rc2-ac2/Documentation/fb/vesafb.txt.fix	2003-05-12 23:17:58.000000000 +0300
@@ -139,22 +139,17 @@
 redraw	scroll by redrawing the affected part of the screen, this
 	is the safe (and slow) default.

-vram:n  remap 'n' MiB of video RAM. If 0 or not specified, remap memory
-        according to video mode. (2.5.66 patch/idea by Antonino Daplas
-	reversed to give override possibility (allocate more fb memory
-	than the kernel would) to 2.4 by tmb@iki.fi)
-
-
 vgapal	Use the standard vga registers for palette changes.
 	This is the default.
 pmipal	Use the protected mode interface for palette changes.

 mtrr	setup memory type range registers for the vesafb framebuffer.

-vram:n  remap 'n' MiB of video RAM. If 0 or not specified, remap memory
-        according to video mode. (2.5.66 patch/idea by Antonino Daplas
-	reversed to give override possibility (allocate more fb memory
-	than the kernel would) to 2.4 by tmb@iki.fi)
+vram:n  remap 'n' MiB of video RAM. If not specified, remap memory
+	according to video mode. (2.5.66 patch/idea by Antonino Daplas
+	reversed to give full override capability (remap less/more
+	vesafb memory than the kernel would) an remade for 2.4
+	by Thomas Bavklund <tmb@iki.fi>)


 Have fun!
--- cut ---



-- 
Regards

Thomas Backlund

http://www.iki.fi/tmb/
tmb@iki.fi

