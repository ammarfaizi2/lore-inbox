Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319139AbSHTB3E>; Mon, 19 Aug 2002 21:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319140AbSHTB3E>; Mon, 19 Aug 2002 21:29:04 -0400
Received: from dp.samba.org ([66.70.73.150]:37284 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319139AbSHTB3C>;
	Mon, 19 Aug 2002 21:29:02 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15713.39843.741159.195405@argo.ozlabs.ibm.com>
Date: Tue, 20 Aug 2002 11:30:11 +1000 (EST)
To: James Simmons <jsimmons@infradead.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] fix endian problems in cfb_imageblit
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The cfb_imageblit() function in drivers/video/cfbimgblt.c is broken on
big-endian machines.  Using test_bit on the font data is a really bad
idea.  First, on big-endian machines it doesn't test the bit you
expect, and secondly, many architectures require the pointer argument
to be 4-byte or 8-byte aligned.  Finally, the loop was always doing
the pixels right-to-left within a 32-bit word, which is wrong on
big-endian machines.

Here is a patch that fixes these problems.

Paul.

diff -urN linux-2.5/drivers/video/cfbimgblt.c pmac-2.5/drivers/video/cfbimgblt.c
--- linux-2.5/drivers/video/cfbimgblt.c	Mon Jun 10 03:39:17 2002
+++ pmac-2.5/drivers/video/cfbimgblt.c	Sat Aug 17 21:15:26 2002
@@ -41,11 +41,21 @@
 #define DPRINTK(fmt, args...)
 #endif
 
+#ifdef __BIG_ENDIAN
+#define LEFT_POS(bpp)		(BITS_PER_LONG - bpp)
+#define NEXT_POS(pos, bpp)	((pos) -= (bpp))
+#else
+#define LEFT_POS(bpp)		(0)
+#define NEXT_POS(pos, bpp)	((pos) += (bpp))
+#endif
+
 void cfb_imageblit(struct fb_info *p, struct fb_image *image)
 {
 	int pad, ppw;
 	int x2, y2, n, i, j, k, l = 7;
-	unsigned long tmp = ~0 << (BITS_PER_LONG - p->var.bits_per_pixel);
+	int bpp = p->var.bits_per_pixel;
+	int ppos;
+	unsigned long tmp = (1 << bpp) - 1;
 	unsigned long fgx, bgx, fgcolor, bgcolor, eorx;	
 	unsigned long end_mask;
 	unsigned long *dst = NULL;
@@ -66,11 +76,11 @@
 	image->height = y2 - image->dy;
   
 	dst1 = p->screen_base + image->dy * p->fix.line_length + 
-		((image->dx * p->var.bits_per_pixel) >> 3);
+		((image->dx * bpp) >> 3);
   
-	ppw = BITS_PER_LONG/p->var.bits_per_pixel;
+	ppw = BITS_PER_LONG / bpp;
 
-	src = image->data;	
+	src = image->data;
 
 	if (image->depth == 1) {
 
@@ -83,8 +93,8 @@
 		}	
  
 		for (i = 0; i < ppw-1; i++) {
-			fgx <<= p->var.bits_per_pixel;
-			bgx <<= p->var.bits_per_pixel;
+			fgx <<= bpp;
+			bgx <<= bpp;
 			fgx |= fgcolor;
 			bgx |= bgcolor;
 		}
@@ -98,10 +108,12 @@
 		
 			for (j = image->width/ppw; j > 0; j--) {
 				end_mask = 0;
-		
+				ppos = LEFT_POS(bpp);
+
 				for (k = ppw; k > 0; k--) {
-					if (test_bit(l, (unsigned long *) src))
-						end_mask |= (tmp >> (p->var.bits_per_pixel*(k-1)));
+					if (*src & (1 << l))
+						end_mask |= tmp << ppos;
+					NEXT_POS(ppos, bpp);
 					l--;
 					if (l < 0) { l = 7; src++; }
 				}
@@ -110,10 +122,12 @@
 			}
 		
 			if (n) {
-				end_mask = 0;	
+				end_mask = 0;
+				ppos = LEFT_POS(bpp);
 				for (j = n; j > 0; j--) {
-					if (test_bit(l, (unsigned long *) src))
-						end_mask |= (tmp >> (p->var.bits_per_pixel*(j-1)));
+					if (*src & (1 << l))
+						end_mask |= tmp << ppos;
+					NEXT_POS(ppos, bpp);
 					l--;
 					if (l < 0) { l = 7; src++; }
 				}
@@ -125,7 +139,7 @@
 		}	
 	} else {
 		/* Draw the penguin */
-		n = ((image->width * p->var.bits_per_pixel) >> 3);
+		n = ((image->width * bpp) >> 3);
 		end_mask = 0;
 	}
 }
