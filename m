Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266359AbSL2PFN>; Sun, 29 Dec 2002 10:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbSL2PFN>; Sun, 29 Dec 2002 10:05:13 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:24073 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S266359AbSL2PFL>; Sun, 29 Dec 2002 10:05:11 -0500
Subject: Re: [Linux-fbdev-devel] [FB PATCH] cfbimgblt isn't 64-bit clean
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0212290027590.14098-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0212290027590.14098-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1041173861.1013.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Dec 2002 22:58:43 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-29 at 09:16, James Simmons wrote:
> 
> > The text is written as if it's thinking about handling 64-bit
> > unsigned long, but it doesn't.  The tables that map bits to
> > pixels are completely unprepared for this.
> > 
> > I thought about widening the tables, but I thought they'd get
> > unreasonably large.  There's no reason not to go ahead and 
> > handle this 32-bits at a time.
> 
> I thought the tables would come back to haunt us. The only reason the 
> tables where introduced was for speed enhancements. I reason the code is 
> extra complex was so you could pass 64 bits of data across the bus. I 
> still like to see that happen still. What do you think?
> 

Only fast_imageblit() should be affected.  color_imageblit() and
slow_imageblit() will not be affected.  

fast_imageblit() is used only for 8, 16 and 32 bpp.  We can remove
fast_imageblit() and just use slow_imageblit() for all color depths, but
it will suffer a significant slowdown. 

Or we can change fast_imageblit() to always access the framebuffer
memory 32-bits at a time. The attached patch should fix this.

Tony

diff -Naur linux-2.5.42/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.5.42/drivers/video/cfbimgblt.c	2002-12-29 14:44:04.000000000 +0000
+++ linux/drivers/video/cfbimgblt.c	2002-12-29 14:44:23.000000000 +0000
@@ -88,11 +88,13 @@
 
 #if defined (__BIG_ENDIAN)
 #define LEFT_POS(bpp)          (BITS_PER_LONG - bpp)
+#define LEFT_POS32(bpp)        (32 - bpp)
 #define NEXT_POS(pos, bpp)     ((pos) -= (bpp))
 #define SHIFT_HIGH(val, bits)  ((val) >> (bits))
 #define SHIFT_LOW(val, bits)   ((val) << (bits))
 #else
 #define LEFT_POS(bpp)          (0)
+#define LEFT_POS32(bpp)        (0)
 #define NEXT_POS(pos, bpp)     ((pos) += (bpp))
 #define SHIFT_HIGH(val, bits)  ((val) << (bits))
 #define SHIFT_LOW(val, bits)   ((val) >> (bits))
@@ -223,25 +225,25 @@
 }
 
 static inline void fast_imageblit(struct fb_image *image, struct fb_info *p, u8 *dst1, 
-				  unsigned long fgcolor, unsigned long bgcolor) 
+				  u32 fgcolor, u32 bgcolor) 
 {
 	int i, j, k, l = 8, n;
-	unsigned long bit_mask, end_mask, eorx; 
-	unsigned long fgx = fgcolor, bgx = bgcolor, pad, bpp = p->var.bits_per_pixel;
-	unsigned long tmp = (1 << bpp) - 1;
-	unsigned long ppw = BITS_PER_LONG/bpp, ppos;
-	unsigned long *dst;
+	u32 bit_mask, end_mask, eorx; 
+	u32 fgx = fgcolor, bgx = bgcolor, pad, bpp = p->var.bits_per_pixel;
+	u32 tmp = (1 << bpp) - 1;
+	u32 ppw = 32/bpp, ppos;
+	u32 *dst;
 	u32 *tab = NULL;
 	char *src = image->data;
 		
-	switch (ppw) {
-	case 4:
+	switch (bpp) {
+	case 8:
 		tab = cfb_tab8;
 		break;
-	case 2:
+	case 16:
 		tab = cfb_tab16;
 		break;
-	case 1:
+	case 32:
 		tab = cfb_tab32;
 		break;
 	}
@@ -263,17 +265,17 @@
 	k = image->width/ppw;
 
 	for (i = image->height; i--; ) {
-		dst = (unsigned long *) dst1;
+		dst = (u32 *) dst1;
 		
 		for (j = k; j--; ) {
 			l -= ppw;
 			end_mask = tab[(*src >> l) & bit_mask]; 
-			FB_WRITEL((end_mask & eorx)^bgx, dst++);
+			fb_writel((end_mask & eorx)^bgx, dst++);
 			if (!l) { l = 8; src++; }
 		}
 		if (n) {
 			end_mask = 0;	
-			ppos = LEFT_POS(bpp);
+			ppos = LEFT_POS32(bpp);
 			for (j = n; j > 0; j--) {
 				l--;
 				if (*src & (1 << l))
@@ -281,7 +283,7 @@
 				NEXT_POS(ppos, bpp);
 				if (!l) { l = 8; src++; }
 			}
-			FB_WRITEL((end_mask & eorx)^bgx, dst++);
+			fb_writel((end_mask & eorx)^bgx, dst++);
 		}
 		l -= pad;		
 		dst1 += p->fix.line_length;	
@@ -337,7 +339,7 @@
 		
 		if (BITS_PER_LONG % bpp == 0 && !start_index && !pitch_index && 
 		    bpp >= 8 && bpp <= 32 && (image->width & 7) == 0) 
-			fast_imageblit(image, p, dst1, fgcolor, bgcolor);
+			fast_imageblit(image, p, dst1, (u32) fgcolor, (u32) bgcolor);
 		else 
 			slow_imageblit(image, p, dst1, fgcolor, bgcolor, start_index, pitch_index);
 	}

