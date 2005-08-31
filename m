Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVHaAv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVHaAv0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 20:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVHaAv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 20:51:26 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:57319 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932308AbVHaAvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 20:51:25 -0400
Date: Wed, 31 Aug 2005 02:51:07 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Knut Petersen <Knut_Petersen@t-online.de>
cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Jochen Hein <jochen@jochen.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
In-Reply-To: <4314DD2E.7060901@t-online.de>
Message-ID: <Pine.LNX.4.61.0508310159290.3728@scrub.home>
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be>
 <43149E5B.7040006@t-online.de> <Pine.LNX.4.61.0508302039160.3743@scrub.home>
 <4314DD2E.7060901@t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 31 Aug 2005, Knut Petersen wrote:

> How could I make it an inline function? It is used in console/bitblit.c,
> nvidia/nvidia.c,
> riva/fbdev.c and softcursor.c.

Something like below, which has the advantange that there is still only 
one implementation of the function and if it's still slower, we really 
need to check the compiler.

bye, Roman

 drivers/video/console/bitblit.c |    5 ++++-
 drivers/video/fbmem.c           |   10 +---------
 include/linux/fb.h              |   13 +++++++++++++
 3 files changed, 18 insertions(+), 10 deletions(-)

Index: linux-2.6/drivers/video/fbmem.c
===================================================================
--- linux-2.6.orig/drivers/video/fbmem.c	2005-08-30 21:17:44.000000000 +0200
+++ linux-2.6/drivers/video/fbmem.c	2005-08-31 01:20:37.000000000 +0200
@@ -80,15 +80,7 @@ EXPORT_SYMBOL(fb_get_color_depth);
  */
 void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u32 height)
 {
-	int i, j;
-
-	for (i = height; i--; ) {
-		/* s_pitch is a few bytes at the most, memcpy is suboptimal */
-		for (j = 0; j < s_pitch; j++)
-			dst[j] = src[j];
-		src += s_pitch;
-		dst += d_pitch;
-	}
+	__fb_pad_aligned_buffer(dst, d_pitch, src, s_pitch, height);
 }
 EXPORT_SYMBOL(fb_pad_aligned_buffer);
 
Index: linux-2.6/drivers/video/console/bitblit.c
===================================================================
--- linux-2.6.orig/drivers/video/console/bitblit.c	2005-08-30 01:55:20.000000000 +0200
+++ linux-2.6/drivers/video/console/bitblit.c	2005-08-31 01:25:30.000000000 +0200
@@ -175,7 +175,10 @@ static void bit_putcs(struct vc_data *vc
 					src = buf;
 				}
 
-				fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
+				if (likely(idx == 1))
+					__fb_pad_aligned_buffer(dst, pitch, src, 1, image.height);
+				else
+					fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
 				dst += width;
 			}
 		}
Index: linux-2.6/include/linux/fb.h
===================================================================
--- linux-2.6.orig/include/linux/fb.h	2005-08-30 01:56:29.000000000 +0200
+++ linux-2.6/include/linux/fb.h	2005-08-31 01:21:04.000000000 +0200
@@ -824,6 +824,19 @@ extern int fb_get_color_depth(struct fb_
 extern int fb_get_options(char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
 
+static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u32 height)
+{
+	int i, j;
+
+	d_pitch -= s_pitch;
+	for (i = height; i--; ) {
+		/* s_pitch is a few bytes at the most, memcpy is suboptimal */
+		for (j = 0; j < s_pitch; j++)
+			*dst++ = *src++;
+		dst += d_pitch;
+	}
+}
+
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 
