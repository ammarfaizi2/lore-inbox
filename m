Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265587AbSLTTqz>; Fri, 20 Dec 2002 14:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265612AbSLTTqz>; Fri, 20 Dec 2002 14:46:55 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:7942 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S265587AbSLTTqw>; Fri, 20 Dec 2002 14:46:52 -0500
Date: Fri, 20 Dec 2002 19:54:52 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Antonino Daplas <adaplas@pol.net>
cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] [PATCH] fix endian problem in color_imageblit
In-Reply-To: <1039914261.1131.70.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0212201932150.6471-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Nice catch :-)  We also need a similar fix for slow_imageblit(), so
> James can you apply the attached patch also:

Applied.

> Also, I noticed that some drivers load the pseudo_palette with entries
> whose length matches the length of the pixel.  The cfb_* functions
> always assume that each pseudo_palette entry is an "unsigned long", so
> bpp16 will segfault, and so will bpp24/32 for 64-bit machines.

I just noticed that as well. Russell King pointed to it too. I fixed
the unsigned long problem in color_imageblit. All the pseudo_palette
in cfb_* are assumed u32. Is this safe for 16bpp or 8 bpp modes? I will
have test to see. The u16 problem might explain why some people have
trouble with the VESA framebuffer. To all the people having trouble
booting to certain modes for the VESA fraembuffer can you try this patch.
Tell me if it fixes your problems.

--- /usr/src/linus-2.5/drivers/video/cfbimgblt.c	Mon Dec  9 22:23:32 2002
+++ cfbimgblt.c	Fri Dec 20 12:35:25 2002
@@ -102,11 +102,10 @@
 				   unsigned long start_index, unsigned long pitch_index)
 {
 	/* Draw the penguin */
-	int i, n;
-	unsigned long bitmask = SHIFT_LOW(~0UL, BITS_PER_LONG - p->var.bits_per_pixel);
-	unsigned long *palette = (unsigned long *) p->pseudo_palette;
 	unsigned long *dst, *dst2, color = 0, val, shift;
-	unsigned long null_bits = BITS_PER_LONG - p->var.bits_per_pixel;
+	int i, n, bpp = p->var.bits_per_pixel;
+	unsigned long null_bits = BITS_PER_LONG - bpp;
+	u32 *palette = (u32 *) p->pseudo_palette;
 	u8 *src = image->data;

 	dst2 = (unsigned long *) dst1;
@@ -125,9 +124,10 @@
 		while (n--) {
 			if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
 			    p->fix.visual == FB_VISUAL_DIRECTCOLOR )
-				color = palette[*src] & bitmask;
+				color = palette[*src];
 			else
-				color = *src & bitmask;
+				color = *src;
+			color <<= LEFT_POS(bpp);
 			val |= SHIFT_HIGH(color, shift);
 			if (shift >= null_bits) {
 				FB_WRITEL(val, dst++);
@@ -136,7 +136,7 @@
 				else
 					val = SHIFT_LOW(color, BITS_PER_LONG - shift);
 			}
-			shift += p->var.bits_per_pixel;
+			shift += bpp;
 			shift &= (BITS_PER_LONG - 1);
 			src++;
 		}
@@ -188,6 +188,7 @@
 				color = fgcolor;
 			else
 				color = bgcolor;
+			color <<= LEFT_POS(bpp);
 			val |= SHIFT_HIGH(color, shift);

 			/* Did the bitshift spill bits to the next long? */





