Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311969AbSCVLsv>; Fri, 22 Mar 2002 06:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311971AbSCVLsl>; Fri, 22 Mar 2002 06:48:41 -0500
Received: from [212.57.170.230] ([212.57.170.230]:14086 "EHLO zzz.zzz")
	by vger.kernel.org with ESMTP id <S311969AbSCVLsV>;
	Fri, 22 Mar 2002 06:48:21 -0500
Date: Fri, 22 Mar 2002 16:47:08 +0500
From: Denis Zaitsev <zzz@cd-club.ru>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] matroxfb_base.c - not a so little patch
Message-ID: <20020322164708.A555@natasha.zzz.zzz>
In-Reply-To: <144D3761283A@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, why I asked all my questions...  It's another patch for
matroxfb_decode_var.  I've replaced a very long if-else tree with
some, say, "table-driven" code.  It's much more compact.  The copule
of a remarks are:

a) Knowing you point of view for the #ifdef's - the table <must> be
splitted with #ifdef's, there is no way for compiler to optimize the
table.

b) There is another similar table (named "colors") somewhere in the
code.  I've made the separate one to make the patch as <little and
local> as possible.  If you approve the patch at whole, I'll merge
them thru some way.

The patch is against 2.5.5.  It seems that matroxfb_base.c is still
the same since that time.  And I assume matroxfb_base.c with
<if (var->bits_per_pixel == 4)> branch present, i.e. without my
previous little fix.

Petr, please, apply this patch.


--- drivers/video/matrox/matroxfb_base.c.orig	Mon Feb 25 21:38:33 2002
+++ drivers/video/matrox/matroxfb_base.c	Sat Mar 16 04:42:19 2002
@@ -483,89 +483,52 @@ static int matroxfb_decode_var(CPMINFO s
 		var->xoffset = var->xres_virtual - var->xres;
 	if (var->yoffset + var->yres > var->yres_virtual)
 		var->yoffset = var->yres_virtual - var->yres;
+{
+	struct {
+		unsigned char bpp;
+		struct {
+			unsigned char offset,
+				      length;
+		} rgbt[4];
+		char visual;
+	}
+	static const table[]= {
+#if defined FBCON_HAS_VGATEXT
+		{ 0,{{ 0,6},{0,6},{0,6},{ 0,0}},MX_VISUAL_PSEUDOCOLOR},
+#endif
+#if defined FBCON_HAS_CFB4\
+ || defined FBCON_HAS_CFB8
+		{ 8,{{ 0,8},{0,8},{0,8},{ 0,0}},MX_VISUAL_PSEUDOCOLOR},
+#endif
+#if defined FBCON_HAS_CFB16
+		{15,{{10,5},{5,5},{0,5},{15,1}},MX_VISUAL_DIRECTCOLOR},
+		{16,{{11,5},{5,6},{0,5},{ 0,0}},MX_VISUAL_DIRECTCOLOR},
+#endif
+#if defined FBCON_HAS_CFB24
+		{24,{{16,8},{8,8},{0,8},{ 0,0}},MX_VISUAL_DIRECTCOLOR},
+#endif
+#if defined FBCON_HAS_CFB32
+		{32,{{16,8},{8,8},{0,8},{24,8}},MX_VISUAL_DIRECTCOLOR}
+#endif
+	};
+	const unsigned char *p;
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
+	for (p= &table[0].bpp; *p < bpp; p+= sizeof table[0]);
+	var->red   .offset= *++p; var->red   .length= *++p;
+	var->green .offset= *++p; var->green .length= *++p;
+	var->blue  .offset= *++p; var->blue  .length= *++p;
+	var->transp.offset= *++p; var->transp.length= *++p;
+	*visual= *(signed char*)++p;
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
