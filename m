Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264662AbTFAQQn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 12:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264663AbTFAQQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 12:16:43 -0400
Received: from mbox2.netikka.net ([213.250.81.203]:49544 "EHLO
	mbox2.netikka.net") by vger.kernel.org with ESMTP id S264662AbTFAQQl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 12:16:41 -0400
From: Thomas Backlund <tmb@iki.fi>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.21-rc6-ac1] vesafb fixes...
Date: Sun, 1 Jun 2003 19:30:02 +0300
User-Agent: KMail/1.5
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Koi2+B94WArhOjN"
Message-Id: <200306011930.02086.tmb@iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Koi2+B94WArhOjN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here are 2 patches...

The "vesafb.txt.diff" removes duplicate text in the documentation...

The "vesafb.c.diff" changes the following:
 - it adds "* 2" to the video_size calculation to remap enough memory
   to do double buffering

 - to make sure that our double buffering calculation does not remap
   more memory than old cards actually have it uses the "old" code:

if video_size > (screen_info.lfb_size * 65536)
		video_size = screen_info.lfb_size * 65536;

 - and last but not least it changes my override to work both ways,
   so that the user can specify less or more memory to be remapped


I earlier got a comment that this double buffering thing is not needed,
but IMHO there will always be cards out there that are to new, so they
dont have driver support (yet), or they are too "weird" so the only thing
the user has to rely on is the vesafb driver, and I like the idea to get
atleast this support "out of the box"...

Best Regards

Thomas 
--Boundary-00=_Koi2+B94WArhOjN
Content-Type: text/x-diff;
  charset="us-ascii";
  name="vesafb.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="vesafb.c.diff"

diff -Naru ac1/drivers/video/vesafb.c tmb1/drivers/video/vesafb.c
--- ac1/drivers/video/vesafb.c	2003-06-01 18:29:51.000000000 +0300
+++ tmb1/drivers/video/vesafb.c	2003-06-01 18:50:18.000000000 +0300
@@ -525,12 +525,18 @@
 	video_width         = screen_info.lfb_width;
 	video_height        = screen_info.lfb_height;
 	video_linelength    = screen_info.lfb_linelength;
-	video_size          = screen_info.lfb_width *	screen_info.lfb_height * video_bpp / 8;
+
+	/* remap memory according to videomode, multiply by 2 to get space for doublebuffering */
+	video_size          = screen_info.lfb_width *	screen_info.lfb_height * video_bpp / 8 * 2;
+
+	/* check that we don't remap more memory than old cards have */
+	if video_size > (screen_info.lfb_size * 65536)
+		video_size = screen_info.lfb_size * 65536;
 	
 	/* FIXME: Should we clip against declared size for banked devices ? */
 	
 	/* sets video_size according to vram boot option */
-	if (vram && vram * 1024 * 1024 > video_size)
+	if (vram && vram * 1024 * 1024 != video_size)
 		video_size = vram * 1024 * 1024;
 		
 	video_visual = (video_bpp == 8) ?

--Boundary-00=_Koi2+B94WArhOjN
Content-Type: text/x-diff;
  charset="us-ascii";
  name="vesafb.txt.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="vesafb.txt.diff"

diff -Naru ac1/Documentation/fb/vesafb.txt tmb1/Documentation/fb/vesafb.txt
--- ac1/Documentation/fb/vesafb.txt	2003-06-01 18:29:40.000000000 +0300
+++ tmb1/Documentation/fb/vesafb.txt	2003-06-01 18:33:23.000000000 +0300
@@ -139,12 +139,6 @@
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

--Boundary-00=_Koi2+B94WArhOjN--

