Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310953AbSCWTbb>; Sat, 23 Mar 2002 14:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310972AbSCWTbO>; Sat, 23 Mar 2002 14:31:14 -0500
Received: from [212.57.170.74] ([212.57.170.74]:1540 "EHLO zzz.zzz")
	by vger.kernel.org with ESMTP id <S310953AbSCWTbE>;
	Sat, 23 Mar 2002 14:31:04 -0500
Date: Sun, 24 Mar 2002 00:29:53 +0500
From: Denis Zaitsev <zzz@cd-club.ru>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] matroxfb_base.c - not a so little patch
Message-ID: <20020324002952.A22396@natasha.zzz.zzz>
In-Reply-To: <2F43B06E5F@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2002 at 01:17:04PM +0100, Petr Vandrovec wrote:
> Did you verified effects on generated code/data size? 

   text	   data	    bss	    dec	    hex	filename
  15191	   1840	    516	  17547	   448b	matroxfb_base.o
  15431	   1840	    516	  17787	   457b	matroxfb_base.o.orig

I.e. 240 bytes.

> Please no. Access fields by their names, and do not assume anything
> about padding.

Oh, yes...  You are right.  So, the cured patch is below.


--- drivers/video/matrox/matroxfb_base.c.orig	Mon Feb 25 21:38:33 2002
+++ drivers/video/matrox/matroxfb_base.c	Sat Mar 23 23:41:21 2002
@@ -483,89 +483,59 @@ static int matroxfb_decode_var(CPMINFO s
 		var->xoffset = var->xres_virtual - var->xres;
 	if (var->yoffset + var->yres > var->yres_virtual)
 		var->yoffset = var->yres_virtual - var->yres;
+{
+	struct RGBT {
+		unsigned char bpp;
+		struct {
+			unsigned char offset,
+				      length;
+		} red,
+		  green,
+		  blue,
+		  transp;
+		signed char visual;
+	}
+	static const table[]= {
+#if defined FBCON_HAS_VGATEXT
+		{ 0,{ 0,6},{0,6},{0,6},{ 0,0},MX_VISUAL_PSEUDOCOLOR},
+#endif
+#if defined FBCON_HAS_CFB4\
+ || defined FBCON_HAS_CFB8
+		{ 8,{ 0,8},{0,8},{0,8},{ 0,0},MX_VISUAL_PSEUDOCOLOR},
+#endif
+#if defined FBCON_HAS_CFB16
+		{15,{10,5},{5,5},{0,5},{15,1},MX_VISUAL_DIRECTCOLOR},
+		{16,{11,5},{5,6},{0,5},{ 0,0},MX_VISUAL_DIRECTCOLOR},
+#endif
+#if defined FBCON_HAS_CFB24
+		{24,{16,8},{8,8},{0,8},{ 0,0},MX_VISUAL_DIRECTCOLOR},
+#endif
+#if defined FBCON_HAS_CFB32
+		{32,{16,8},{8,8},{0,8},{24,8},MX_VISUAL_DIRECTCOLOR}
+#endif
+	};
+	struct RGBT const *p;
+
+	unsigned char bpp= var->bits_per_pixel;
+	if (bpp == 16 && var->green.length == 5) bpp--;/* an artifical value - 15 */
 
-	if (var->bits_per_pixel == 0) {
-		var->red.offset = 0;
-		var->red.length = 6;
-		var->green.offset = 0;
-		var->green.length = 6;
-		var->blue.offset = 0;
-		var->blue.length = 6;
-		var->transp.offset = 0;
-		var->transp.length = 0;
-		*visual = MX_VISUAL_PSEUDOCOLOR;
-	} else if (var->bits_per_pixel == 4) {
-		var->red.offset = 0;
-		var->red.length = 8;
-		var->green.offset = 0;
-		var->green.length = 8;
-		var->blue.offset = 0;
-		var->blue.length = 8;
-		var->transp.offset = 0;
-		var->transp.length = 0;
-		*visual = MX_VISUAL_PSEUDOCOLOR;
-	} else if (var->bits_per_pixel <= 8) {
-		var->red.offset = 0;
-		var->red.length = 8;
-		var->green.offset = 0;
-		var->green.length = 8;
-		var->blue.offset = 0;
-		var->blue.length = 8;
-		var->transp.offset = 0;
-		var->transp.length = 0;
-		*visual = MX_VISUAL_PSEUDOCOLOR;
-	} else {
-		if (var->bits_per_pixel <= 16) {
-			if (var->green.length == 5) {
-				var->red.offset    = 10;
-				var->red.length    = 5;
-				var->green.offset  = 5;
-				var->green.length  = 5;
-				var->blue.offset   = 0;
-				var->blue.length   = 5;
-				var->transp.offset = 15;
-				var->transp.length = 1;
-			} else {
-				var->red.offset    = 11;
-				var->red.length    = 5;
-				var->green.offset  = 5;
-				var->green.length  = 6;
-				var->blue.offset   = 0;
-				var->blue.length   = 5;
-				var->transp.offset = 0;
-				var->transp.length = 0;
-			}
-		} else if (var->bits_per_pixel <= 24) {
-			var->red.offset    = 16;
-			var->red.length    = 8;
-			var->green.offset  = 8;
-			var->green.length  = 8;
-			var->blue.offset   = 0;
-			var->blue.length   = 8;
-			var->transp.offset = 0;
-			var->transp.length = 0;
-		} else {
-			var->red.offset    = 16;
-			var->red.length    = 8;
-			var->green.offset  = 8;
-			var->green.length  = 8;
-			var->blue.offset   = 0;
-			var->blue.length   = 8;
-			var->transp.offset = 24;
-			var->transp.length = 8;
-		}
+	for (p= table; p->bpp < bpp; p++);
+#define	SETCLR(clr)\
+	var->clr.offset= p->clr.offset;\
+	var->clr.length= p->clr.length
+	SETCLR(red);
+	SETCLR(green);
+	SETCLR(blue);
+	SETCLR(transp);
+#undef	SETCLR
+	*visual= p->visual;
+
+	if (bpp > 8)
 		dprintk("matroxfb: truecolor: "
-		       "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
-		       var->transp.length,
-		       var->red.length,
-		       var->green.length,
-		       var->blue.length,
-		       var->transp.offset,
-		       var->red.offset,
-		       var->green.offset,
-		       var->blue.offset);
-		*visual = MX_VISUAL_DIRECTCOLOR;
-	}
+			"size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
+			var->transp.length, var->red.length, var->green.length, var->blue.length,
+			var->transp.offset, var->red.offset, var->green.offset, var->blue.offset);
+}
 	*video_cmap_len = matroxfb_get_cmap_len(var);
 	dprintk(KERN_INFO "requested %d*%d/%dbpp (%d*%d)\n", var->xres, var->yres, var->bits_per_pixel,
 				var->xres_virtual, var->yres_virtual);
