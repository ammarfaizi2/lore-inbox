Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264329AbTLPEdU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 23:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbTLPEdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 23:33:20 -0500
Received: from web9506.mail.yahoo.com ([216.136.129.20]:21430 "HELO
	web9506.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264329AbTLPEdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 23:33:17 -0500
Message-ID: <20031216043316.9402.qmail@web9506.mail.yahoo.com>
Date: Mon, 15 Dec 2003 23:33:16 -0500 (EST)
From: Dave Muhlert <va7dav@yahoo.ca>
Subject: [PATCH] vesafb, kernel 2.4.23
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The 2.4.23 vesafb driver wasn't using all of my video
memory, so bootsplash images wouldn't load because
they didn't fit in the framebuffer.  I apologize in
advance for whatever Yahoo mail does to my formatting.

Relevant vesafb output before the patch:
Dec 14 00:14:31 blue vesafb: framebuffer at
0xe2000000, mapped to 0xd0813000, size 1536k
Dec 14 00:14:31 blue Looking for splash picture....
silenjpeg size 21768 bytes, does not fit into
framebuffer.

With the patched driver:
Dec 15 12:29:12 blue vesafb: framebuffer at
0xe2000000, mapped to 0xd0806000, size 32768k
Dec 15 12:29:12 blue Looking for splash picture....
silenjpeg size 21768 bytes, found (1024x768, 20089
bytes, v3).

I'm using the ck-sources-2.4.23-ck1 Gentoo ebuild (The
one with Con Kolivas's patchset), but the included
vesafb.c is identical to
http://mirror.trouble-free.net/kernel/v2.4/linux-2.4.23/drivers/video/vesafb.c.
(MD5sum: f3bbf3931f5301432a2ea20c6c67b52f)

Here's the patch I applied to fix the problem
(originally suggested by someone on the Gentoo forums
in response to someone else who had the same problem I
did.  I'll dig up the source if anyone asks).  It's
worked perfectly thus far.
-------------------------------------------------------------
dave@blue video $ diff -u vesafb-original.c
vesafb-modified.c
--- vesafb-original.c   2003-12-14 20:51:32.000000000
-0800
+++ vesafb-modified.c   2003-12-15 20:56:02.000000000
-0800
@@ -529,20 +529,7 @@
        video_width         = screen_info.lfb_width;
        video_height        = screen_info.lfb_height;
        video_linelength    =
screen_info.lfb_linelength;
-
-       /* remap memory according to videomode,
multiply by 2 to get space for doublebuffering */
-       video_size          = screen_info.lfb_width * 
 screen_info.lfb_height * video_bpp / 8 * 2;
-
-       /* check that we don't remap more memory than
old cards have */
-       if (video_size > screen_info.lfb_size * 65536)
-               video_size = screen_info.lfb_size *
65536;
-
-       /* FIXME: Should we clip against declared size
for banked devices ? */
-
-       /* sets video_size according to vram boot
option */
-       if (vram && vram * 1024 * 1024 != video_size)
-               video_size = vram * 1024 * 1024;
-
+       video_size          = screen_info.lfb_size *
65536;
        video_visual = (video_bpp == 8) ?
                FB_VISUAL_PSEUDOCOLOR :
FB_VISUAL_TRUECOLOR;
------------------------------------------------------------
System info:

Gentoo Linux 1.4, ck-sources 2.4.23 compiled with
genkernel
P3-Celeron(Coppermine) 800Mhz
Nvidia TNT2 M64 video card (32MB RAM)

Boot options from lilo.conf: append="root=/dev/hda8
init=/linuxrc hda=autotune video=vesa:ywrap,mtrr
splash=silent"

Relevant excerpts from .config:
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_SPLASHSCREEN=y

______________________________________________________________________ 
Post your free ad now! http://personals.yahoo.ca
