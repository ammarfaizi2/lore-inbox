Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129627AbRAEPzP>; Fri, 5 Jan 2001 10:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129744AbRAEPy7>; Fri, 5 Jan 2001 10:54:59 -0500
Received: from tamqfl1-ar1-128-154.dsl.gtei.net ([4.33.128.154]:33781 "EHLO
	linus.southpark") by vger.kernel.org with ESMTP id <S131167AbRAEPyg>;
	Fri, 5 Jan 2001 10:54:36 -0500
Message-ID: <3A55EE29.EBE9D348@leoninedev.com>
Date: Fri, 05 Jan 2001 10:54:17 -0500
From: Bryan Mayland <bmayland@leoninedev.com>
Organization: Leonine Development, Inc.
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; I)
X-Accept-Language: en
MIME-Version: 1.0
To: kraxel@goldbach.in-berlin.de
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] VESA framebuffer w/ MTRR locks 2.4.0 on init
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On startup of a 2.4.0 kernel with VESA frambuffer console and MTRRs enabled, my
kernel hard locks before I can ever see anything displayed on my screen.  I
tracked the trouble down to 2 things:

1)  The amount of video memory is being incorrectly reported my the VESA call
used in arch/i386/video.S (INT 10h AX=4f00h).  My Dell Inspiron 3200 (NeoMagic
video) returns that it has 31 64k blocks of video memory, instead of the
correct 32.  This means that vesafb thinks that I've got 1984k of video ram,
when I actually have 2M.  This problem has been previously addressed by a patch
I sent (2 times) and has never made it into the kernel.

2)  When the vesafb goes to mtrr_add its range (with the incorrect 1984k size)
mtrr_add fails with -EINVAL.  The code in vesafb_init then goes into a while
loop with no exit, as each size mtrr fails.
                 while (mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB,
1)==-EINVAL) {
                         temp_size >>= 1;
                 }
If the kernel messages were visible at this time (which they aren't) you'd see
messages like:
    mtrr: base(0xfd000000) is not aligned on a size(0x1f0000) boundary
and then
    mtrr: size and base must be multiples of 4 kiB

Below is a patch which both prevents the endless loop problem, and adds a mem=
option the the video=vesa kernel command line.  I know that Linus hates it when
2 things are combined like this, but I think that they're closely enough
related (but have to do with memory size detection problems) to warrant it.  I
can split them if requested.  I've also CCed him on this message since this
will be my third submission of this patch without any response from the
maintainer or linux-kernel.

Bry

diff -urN linux-orig/Documentation/fb/vesafb.txt
linux/Documentation/fb/vesafb.txt
--- linux-orig/Documentation/fb/vesafb.txt Fri Jul 28 15:50:51 2000
+++ linux/Documentation/fb/vesafb.txt Fri Jan  5 10:22:20 2001
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
diff -urN linux-orig/drivers/video/vesafb.c linux/drivers/video/vesafb.c
--- linux-orig/drivers/video/vesafb.c Mon Oct 16 15:37:52 2000
+++ linux/drivers/video/vesafb.c Fri Jan  5 10:22:37 2001
@@ -453,6 +453,7 @@
  char *this_opt;

  fb_info.fontname[0] = '\0';
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

@@ -635,7 +645,7 @@

  if (mtrr) {
   int temp_size = video_size;
-  while (mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB, 1)==-EINVAL) {
+  while (temp_size && (mtrr_add(video_base, temp_size, MTRR_TYPE_WRCOMB,
1)==-EINVAL)) {
    temp_size >>= 1;
   }
  }


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
