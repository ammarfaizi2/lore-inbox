Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130335AbQKPO3Q>; Thu, 16 Nov 2000 09:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbQKPO3F>; Thu, 16 Nov 2000 09:29:05 -0500
Received: from tamqfl1-ar1-128-154.dsl.gtei.net ([4.33.128.154]:18160 "EHLO
	linus.southpark") by vger.kernel.org with ESMTP id <S130335AbQKPO2z>;
	Thu, 16 Nov 2000 09:28:55 -0500
Message-ID: <3A13E817.C4D01284@leoninedev.com>
Date: Thu, 16 Nov 2000 08:58:47 -0500
From: Bryan Mayland <bmayland@leoninedev.com>
Organization: Leonine Development, Inc.
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] VESA framebuffer memory detection fix
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all. I've seen a problem with the VESA framebuffer console using ywrap
scrolling. When you reach the end of the video memory, the y_scroll variable
wraps before the end of memory, leaving a "black hole" in the last bit of
memory until the rest of the screen wraps around in video memory to be linear
again. I've tried this on several laptops (all Dells, but different models)
around the office and they all behave the same. I tracked the problem down to
the video.S setup code, where the kernel calls the good 'ole INT 10h (AX =
4f00h), the amount of 64 KB video frames is coming back one lower than there
actually is. I therefore went ahead and modified the VESA frambuffer code to
allow the user to set the amount of memory from the command line with the
standard
mem=XXX[kKmM] format. I posted this patch back in the 2.3.18 days, but I've
still yet to see it show up in the kernel, and I've never even received
criticism for it  :)

Bry

diff -uNr linux/Documentation/fb/vesafb.txt
linux-2.4.0-test10/Documentation/fb/vesafb.txt
--- linux/Documentation/fb/vesafb.txt Fri Jul 28 15:50:51 2000
+++ linux-2.4.0-test10/Documentation/fb/vesafb.txt Fri Aug 18 17:13:27 2000
@@ -146,6 +146,12 @@

 mtrr setup memory type range registers for the vesafb framebuffer.

+mem     Override the amount of memory reported by the VESA BIOS
+ INT 10h (AX=4f00h). Some VBE implementations misreport the
+ amount of video memory, causing a "black hole" when using ywrap
+ every time the end of the memory is reached. If you enter a
+ value here larger than you actually have, you will more than
+ likely lock your system so be careful! Syntax is mem=XXX[kKmM]

 Have fun!

@@ -156,3 +162,4 @@

 Minor (mostly typo) changes
 by Nico Schmoigl <schmoigl@rumms.uni-mannheim.de>
+mem option added by Bryan Mayland <bmayland@leonindev.com>
--- linux/drivers/video/vesafb.c Wed Jul 26 14:08:41 2000
+++ linux-2.4.0-test10/drivers/video/vesafb.c Fri Aug 18 17:16:03 2000
@@ -452,7 +452,8 @@
 {
  char *this_opt;

- fb_info.fontname[0] = '\0';
+ fb_info.fontname[0] = '\0';
+ video_size = 0;

  if (!options || !*options)
   return 0;
@@ -476,6 +477,13 @@
    mtrr=1;
   else if (!strncmp(this_opt, "font:", 5))
    strcpy(fb_info.fontname, this_opt+5);
+  else if (!strncmp(this_opt, "mem=", 4)) {
+   video_size = simple_strtoul(this_opt + 4, &this_opt, 0);
+   if (*this_opt == 'K' || *this_opt == 'k')
+     video_size <<= 10;
+   else if (*this_opt=='M' || *this_opt=='m')
+    video_size <<= 20;
+  }
  }
  return 0;
 }
@@ -515,7 +523,9 @@
  video_width         = screen_info.lfb_width;
  video_height        = screen_info.lfb_height;
  video_linelength    = screen_info.lfb_linelength;
- video_size          = screen_info.lfb_size * 65536;
+    /* video_size may have been overriden by a command line option */
+  if (!video_size)
+    video_size = screen_info.lfb_size * 65536;
  video_visual = (video_bpp == 8) ?
   FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
