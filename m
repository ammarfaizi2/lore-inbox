Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbSLNWDU>; Sat, 14 Dec 2002 17:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265995AbSLNWDU>; Sat, 14 Dec 2002 17:03:20 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:6413 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S265987AbSLNWDT>; Sat, 14 Dec 2002 17:03:19 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH] fix endian problem in
	color_imageblit
From: Antonino Daplas <adaplas@pol.net>
To: Paul Mackerras <paulus@samba.org>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <15864.1386.543811.337732@argo.ozlabs.ibm.com>
References: <15864.1386.543811.337732@argo.ozlabs.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039914261.1131.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Dec 2002 06:05:24 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-12 at 08:41, Paul Mackerras wrote:
> This patch fixes the endian problems in color_imageblit().  With this
> patch, I get the penguin drawn properly on boot.
> 
> The main change is that on big-endian systems, when we load a pixel
> from the source, we now shift it to the left-hand (most significant)
> end of the word.  With this change the rest of the logic is correct on
> big-endian systems.  This may not be the most efficient way to do
> things but it is a simple change that works and avoids disturbing the
> rest of the code.
> 
Nice catch :-)  We also need a similar fix for slow_imageblit(), so
James can you apply the attached patch also:

Also, I noticed that some drivers load the pseudo_palette with entries 
whose length matches the length of the pixel.  The cfb_* functions 
always assume that each pseudo_palette entry is an "unsigned long", so 
bpp16 will segfault, and so will bpp24/32 for 64-bit machines.

Tony

diff -Naur linux-2.5.51/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.5.51/drivers/video/cfbimgblt.c	2002-12-15 00:54:04.000000000 +0000
+++ linux/drivers/video/cfbimgblt.c	2002-12-15 00:54:21.000000000 +0000
@@ -189,6 +189,7 @@
 				color = fgcolor;
 			else 
 				color = bgcolor;
+			color <<= LEFT_POS(bpp);
 			val |= SHIFT_HIGH(color, shift);
 			
 			/* Did the bitshift spill bits to the next long? */

Tony

