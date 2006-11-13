Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932784AbWKMSvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932784AbWKMSvX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755323AbWKMSvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:51:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:12701 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1755321AbWKMSvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:51:22 -0500
Date: Mon, 13 Nov 2006 18:51:19 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] fbmem: is bootup logo broken for monochrome
 LCD ?
In-Reply-To: <cda58cb80611131027h5052bf80va06003c23b844fe@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0611131850410.2366@pentafluge.infradead.org>
References: <45535C08.5020607@innova-card.com> 
 <Pine.LNX.4.64.0611122138030.9472@pentafluge.infradead.org> 
 <cda58cb80611130153n60579de0w2ebb59b050595b3b@mail.gmail.com> 
 <Pine.LNX.4.64.0611131415270.25397@pentafluge.infradead.org>
 <cda58cb80611131027h5052bf80va06003c23b844fe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Let me know if it works now.

On Mon, 13 Nov 2006, Franck Bui-Huu wrote:

> On 11/13/06, James Simmons <jsimmons@infradead.org> wrote:
> > 
> > >> There are quite a few bugs in the code. I have a patch I have been
> > working
> > >> on for some time. The patch does the following:
> > >>
> > >
> > > I'd like to give your patch a try but have some trouble to apply it
> > > cleanly. Care to resend it ?
> > 
> > Which tree are you working off ?> The patch is against linus git tree.
> > 
> 
> It seems that you use "format=flowed" with your mailer. Can you try to
> disable it ?
> 
> Even if I save the message to a file, the patch is still corrupted...
> 
> Thanks
> 

diff -urN -X linus-2.6/Documentation/dontdiff linus-2.6/drivers/video/cfbimgblt.c fbdev-2.6/drivers/video/cfbimgblt.c
--- linus-2.6/drivers/video/cfbimgblt.c	2006-11-07 05:38:36.000000000 -0500
+++ fbdev-2.6/drivers/video/cfbimgblt.c	2006-11-12 10:29:49.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  *  Generic BitBLT function for frame buffer with packed pixels of any depth.
  *
- *      Copyright (C)  June 1999 James Simmons
+ *      Copyright (C)  June 1999 - 2006 James Simmons
  *
  *  This file is subject to the terms and conditions of the GNU General Public
  *  License.  See the file COPYING in the main directory of this archive for
@@ -17,7 +17,7 @@
  *  their are cards with hardware that coverts images of various depths to the
  *  framebuffer depth. But not every card has this. All images must be rounded
  *  up to the nearest byte. For example a bitmap 12 bits wide must be two 
- *  bytes width. 
+ *  bytes width.
  *
  *  Tony: 
  *  Incorporate mask tables similar to fbcon-cfb*.c in 2.4 API.  This speeds 
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fb.h>
+#include <asm/byteorder.h>
 #include <asm/types.h>
 
 #define DEBUG
@@ -43,161 +44,99 @@
 #endif
 
 static u32 cfb_tab8[] = {
-#if defined(__BIG_ENDIAN)
     0x00000000,0x000000ff,0x0000ff00,0x0000ffff,
     0x00ff0000,0x00ff00ff,0x00ffff00,0x00ffffff,
     0xff000000,0xff0000ff,0xff00ff00,0xff00ffff,
     0xffff0000,0xffff00ff,0xffffff00,0xffffffff
-#elif defined(__LITTLE_ENDIAN)
-    0x00000000,0xff000000,0x00ff0000,0xffff0000,
-    0x0000ff00,0xff00ff00,0x00ffff00,0xffffff00,
-    0x000000ff,0xff0000ff,0x00ff00ff,0xffff00ff,
-    0x0000ffff,0xff00ffff,0x00ffffff,0xffffffff
-#else
-#error FIXME: No endianness??
-#endif
 };
 
 static u32 cfb_tab16[] = {
-#if defined(__BIG_ENDIAN)
     0x00000000, 0x0000ffff, 0xffff0000, 0xffffffff
-#elif defined(__LITTLE_ENDIAN)
-    0x00000000, 0xffff0000, 0x0000ffff, 0xffffffff
-#else
-#error FIXME: No endianness??
-#endif
 };
 
 static u32 cfb_tab32[] = {
 	0x00000000, 0xffffffff
 };
 
-#define FB_WRITEL fb_writel
-#define FB_READL  fb_readl
+#define FB_WRITEL		fb_writel
+#define FB_READL		fb_readl
 
-static inline void color_imageblit(const struct fb_image *image, 
-				   struct fb_info *p, u8 __iomem *dst1, 
-				   u32 start_index,
-				   u32 pitch_index)
+static inline void slow_imageblit(const struct fb_image *image, 
+				  struct fb_info *p, u8 __iomem *dst, 
+				  u32 start_index, u32 pitch_index)
 {
 	/* Draw the penguin */
-	u32 __iomem *dst, *dst2;
-	u32 color = 0, val, shift;
-	int i, n, bpp = p->var.bits_per_pixel;
-	u32 null_bits = 32 - bpp;
+	int spitch = (image->width * image->depth + 7) >> 3;
+	const u32 *src = (const u32 *) image->data;
+	int scan_align = p->pixmap.scan_align - 1;
 	u32 *palette = (u32 *) p->pseudo_palette;
-	const u8 *src = image->data;
+	int bpp = p->var.bits_per_pixel, i, n;
+	int mask = (1 << image->depth) - 1;
+	int bits = p->pixmap.access_align;
+	int bpw = bits >> 3, s = 32;
+	int null_bits = bits - bpp;
+	u32 color = 0, val, shift;
+	u32 __iomem *dst2;
+	u8 __iomem *dst1;
 
-	dst2 = (u32 __iomem *) dst1;
+	spitch = (spitch + scan_align) & ~scan_align;
+	dst2 = (u32 __iomem *) dst;
 	for (i = image->height; i--; ) {
 		n = image->width;
-		dst = (u32 __iomem *) dst1;
-		shift = 0;
-		val = 0;
-		
+		shift = val = 0;
+		dst1 = dst;
+
+		/* write leading bits */
 		if (start_index) {
-			u32 start_mask = ~(FB_SHIFT_HIGH(~(u32)0, start_index));
-			val = FB_READL(dst) & start_mask;
+			u32 start_mask = (~(u32)0 << start_index);
+			val = FB_READL(dst1);
+			val &= start_mask;
 			shift = start_index;
 		}
-		while (n--) {
-			if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
-			    p->fix.visual == FB_VISUAL_DIRECTCOLOR )
-				color = palette[*src];
-			else
-				color = *src;
-			color <<= FB_LEFT_POS(bpp);
-			val |= FB_SHIFT_HIGH(color, shift);
-			if (shift >= null_bits) {
-				FB_WRITEL(val, dst++);
-	
-				val = (shift == null_bits) ? 0 : 
-					FB_SHIFT_LOW(color, 32 - shift);
-			}
-			shift += bpp;
-			shift &= (32 - 1);
-			src++;
-		}
-		if (shift) {
-			u32 end_mask = FB_SHIFT_HIGH(~(u32)0, shift);
-
-			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
-		}
-		dst1 += p->fix.line_length;
-		if (pitch_index) {
-			dst2 += p->fix.line_length;
-			dst1 = (u8 __iomem *)((long __force)dst2 & ~(sizeof(u32) - 1));
 
-			start_index += pitch_index;
-			start_index &= 32 - 1;
-		}
-	}
-}
+		while (n--) {
+			if (!s) { src++; s = 32; }
+			s -= image->depth;
 
-static inline void slow_imageblit(const struct fb_image *image, struct fb_info *p, 
-				  u8 __iomem *dst1, u32 fgcolor,
-				  u32 bgcolor, 
-				  u32 start_index,
-				  u32 pitch_index)
-{
-	u32 shift, color = 0, bpp = p->var.bits_per_pixel;
-	u32 __iomem *dst, *dst2;
-	u32 val, pitch = p->fix.line_length;
-	u32 null_bits = 32 - bpp;
-	u32 spitch = (image->width+7)/8;
-	const u8 *src = image->data, *s;
-	u32 i, j, l;
-	
-	dst2 = (u32 __iomem *) dst1;
-	fgcolor <<= FB_LEFT_POS(bpp);
-	bgcolor <<= FB_LEFT_POS(bpp);
+			color = (swab32p(src) & (mask << s));
+			if (image->depth == 1)
+				color = color ? image->fg_color : image->bg_color;
+			else
+				color >>= s;
 
-	for (i = image->height; i--; ) {
-		shift = val = 0;
-		l = 8;
-		j = image->width;
-		dst = (u32 __iomem *) dst1;
-		s = src;
+			if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
+			    p->fix.visual == FB_VISUAL_DIRECTCOLOR)
+				color = palette[color];
 
-		/* write leading bits */
-		if (start_index) {
-			u32 start_mask = ~(FB_SHIFT_HIGH(~(u32)0,start_index));
-			val = FB_READL(dst) & start_mask;
-			shift = start_index;
-		}
+			val |= (color << shift);
 
-		while (j--) {
-			l--;
-			color = (*s & (1 << l)) ? fgcolor : bgcolor;
-			val |= FB_SHIFT_HIGH(color, shift);
-			
-			/* Did the bitshift spill bits to the next long? */
+			/* Did the bitshift spill bits into the next long? */
 			if (shift >= null_bits) {
-				FB_WRITEL(val, dst++);
-				val = (shift == null_bits) ? 0 :
-					FB_SHIFT_LOW(color,32 - shift);
+				FB_WRITEL(val, dst1);
+				dst1 += bpw;
+				val = (shift == null_bits) ? 0 : (color >> (bits - shift));
 			}
 			shift += bpp;
-			shift &= (32 - 1);
-			if (!l) { l = 8; s++; };
+			shift &= (bits - 1);
 		}
+		s -= (spitch << 3) - image->width * image->depth;
 
 		/* write trailing bits */
- 		if (shift) {
-			u32 end_mask = FB_SHIFT_HIGH(~(u32)0, shift);
+		if (shift) {
+			u32 end_mask = (~(u32)0 << shift);
 
-			FB_WRITEL((FB_READL(dst) & end_mask) | val, dst);
+			val = FB_READL(dst1);
+			val &= end_mask;
+			FB_WRITEL(val, dst1);
 		}
-		
-		dst1 += pitch;
-		src += spitch;	
+
+		dst += p->fix.line_length;
 		if (pitch_index) {
-			dst2 += pitch;
-			dst1 = (u8 __iomem *)((long __force)dst2 & ~(sizeof(u32) - 1));
+			dst2 += p->fix.line_length;
+			dst = (u8 __iomem *)((long __force)dst2 & ~(bpw - 1));
 			start_index += pitch_index;
-			start_index &= 32 - 1;
+			start_index &= bits - 1;
 		}
-		
 	}
 }
 
@@ -210,101 +149,105 @@
  *           beginning and end of a scanline is dword aligned
  */
 static inline void fast_imageblit(const struct fb_image *image, struct fb_info *p, 
-				  u8 __iomem *dst1, u32 fgcolor, 
-				  u32 bgcolor) 
+				  u8 __iomem *dst) 
 {
-	u32 fgx = fgcolor, bgx = bgcolor, bpp = p->var.bits_per_pixel;
-	u32 ppw = 32/bpp, spitch = (image->width + 7)/8;
-	u32 bit_mask, end_mask, eorx, shift;
+	int scan_align = p->pixmap.scan_align - 1, spitch = (image->width + 7) >> 3;
+	u32 bit_mask, end_mask = 0, eorx, fgx, fgcolor, bgx, bgcolor, val;
+	int access = p->pixmap.access_align, bpw = access >> 3, bits;
+	int bpp = p->var.bits_per_pixel, ppw, shift, i, j;
 	const char *s = image->data, *src;
-	u32 __iomem *dst;
+	u8 __iomem *dst1;
 	u32 *tab = NULL;
-	int i, j, k;
-		
+
+	spitch = (spitch + scan_align) & ~scan_align;
+
+	if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
+	    p->fix.visual == FB_VISUAL_DIRECTCOLOR) {
+		fgx = fgcolor = ((u32*)(p->pseudo_palette))[image->fg_color];
+		bgx = bgcolor = ((u32*)(p->pseudo_palette))[image->bg_color];
+	} else {
+		fgx = fgcolor = image->fg_color;
+		bgx = bgcolor = image->bg_color;
+	}
+
 	switch (bpp) {
 	case 8:
 		tab = cfb_tab8;
+		ppw = 4;
 		break;
 	case 16:
 		tab = cfb_tab16;
+		ppw = 2;
 		break;
 	case 32:
 	default:
 		tab = cfb_tab32;
+		ppw = 1;
 		break;
 	}
 
-	for (i = ppw-1; i--; ) {
+	for (i = 0; i < 32; i += bpp) {
 		fgx <<= bpp;
 		bgx <<= bpp;
 		fgx |= fgcolor;
 		bgx |= bgcolor;
 	}
-	
+
 	bit_mask = (1 << ppw) - 1;
 	eorx = fgx ^ bgx;
-	k = image->width/ppw;
 
 	for (i = image->height; i--; ) {
-		dst = (u32 __iomem *) dst1, shift = 8; src = s;
-		
-		for (j = k; j--; ) {
-			shift -= ppw;
-			end_mask = tab[(*src >> shift) & bit_mask];
-			FB_WRITEL((end_mask & eorx)^bgx, dst++);
-			if (!shift) { shift = 8; src++; }		
+		dst1 = dst, shift = 8, bits = 32; src = s;
+
+		for (j = image->width*bpp; j > 0; j -= access) {
+			bits += access;
+			if (bits >= 32) {
+				shift -= ppw;
+				end_mask = swab32(tab[(*src >> shift) & bit_mask]);
+				if (!shift) { shift = 8; src++; }
+				bits = 0;
+			}
+			val = (end_mask & eorx)^bgx;
+			FB_WRITEL(val, dst1);
+			dst1 += bpw;
 		}
-		dst1 += p->fix.line_length;
+		dst += p->fix.line_length;
 		s += spitch;
 	}
-}	
-	
+}
+
 void cfb_imageblit(struct fb_info *p, const struct fb_image *image)
 {
-	u32 fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
-	u32 bpl = sizeof(u32), bpp = p->var.bits_per_pixel;
-	u32 width = image->width;
-	u32 dx = image->dx, dy = image->dy;
+	u32 bits = p->pixmap.access_align, bpp = p->var.bits_per_pixel;
+	u32 width = image->width, dx = image->dx, dy = image->dy;
+	u32 start_index, bitstart, pitch_index = 0;
+	int bpl = bits >> 3;
 	u8 __iomem *dst1;
 
 	if (p->state != FBINFO_STATE_RUNNING)
 		return;
 
-	bitstart = (dy * p->fix.line_length * 8) + (dx * bpp);
-	start_index = bitstart & (32 - 1);
-	pitch_index = (p->fix.line_length & (bpl - 1)) * 8;
+	bitstart = ((dy * p->fix.line_length) << 3) + (dx * bpp);
+	start_index = bitstart & (bits - 1);
+	pitch_index = (p->fix.line_length & (bpl - 1)) << 3;
 
-	bitstart /= 8;
+	bitstart >>= 3;
 	bitstart &= ~(bpl - 1);
 	dst1 = p->screen_base + bitstart;
 
 	if (p->fbops->fb_sync)
 		p->fbops->fb_sync(p);
 
-	if (image->depth == 1) {
-		if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
-		    p->fix.visual == FB_VISUAL_DIRECTCOLOR) {
-			fgcolor = ((u32*)(p->pseudo_palette))[image->fg_color];
-			bgcolor = ((u32*)(p->pseudo_palette))[image->bg_color];
-		} else {
-			fgcolor = image->fg_color;
-			bgcolor = image->bg_color;
-		}	
-		
-		if (32 % bpp == 0 && !start_index && !pitch_index && 
-		    ((width & (32/bpp-1)) == 0) &&
-		    bpp >= 8 && bpp <= 32) 			
-			fast_imageblit(image, p, dst1, fgcolor, bgcolor);
-		else 
-			slow_imageblit(image, p, dst1, fgcolor, bgcolor,
-					start_index, pitch_index);
-	} else
-		color_imageblit(image, p, dst1, start_index, pitch_index);
+	if (bits % bpp == 0 && image->depth == 1 && !start_index && !pitch_index && bpp >= 8 && bpp <= 32
+	    && ((width & (bits/bpp-1)) == 0))
+		fast_imageblit(image, p, dst1);
+	else
+		slow_imageblit(image, p, dst1, start_index, pitch_index);
 }
 
 EXPORT_SYMBOL(cfb_imageblit);
 
-MODULE_AUTHOR("James Simmons <jsimmons@users.sf.net>");
+MODULE_AUTHOR("James Simmons <jsimmons@infradead.org>");
 MODULE_DESCRIPTION("Generic software accelerated imaging drawing");
 MODULE_LICENSE("GPL");
 
diff -urN -X linus-2.6/Documentation/dontdiff linus-2.6/drivers/video/fbmem.c fbdev-2.6/drivers/video/fbmem.c
--- linus-2.6/drivers/video/fbmem.c	2006-11-07 05:38:36.000000000 -0500
+++ fbdev-2.6/drivers/video/fbmem.c	2006-11-11 10:00:32.000000000 -0500
@@ -243,48 +243,6 @@
 		palette[i] = i << redshift | i << greenshift | i << blueshift;
 }
 
-static void fb_set_logo(struct fb_info *info,
-			       const struct linux_logo *logo, u8 *dst,
-			       int depth)
-{
-	int i, j, k;
-	const u8 *src = logo->data;
-	u8 xor = (info->fix.visual == FB_VISUAL_MONO01) ? 0xff : 0;
-	u8 fg = 1, d;
-
-	if (fb_get_color_depth(&info->var, &info->fix) == 3)
-		fg = 7;
-
-	if (info->fix.visual == FB_VISUAL_MONO01 ||
-	    info->fix.visual == FB_VISUAL_MONO10)
-		fg = ~((u8) (0xfff << info->var.green.length));
-
-	switch (depth) {
-	case 4:
-		for (i = 0; i < logo->height; i++)
-			for (j = 0; j < logo->width; src++) {
-				*dst++ = *src >> 4;
-				j++;
-				if (j < logo->width) {
-					*dst++ = *src & 0x0f;
-					j++;
-				}
-			}
-		break;
-	case 1:
-		for (i = 0; i < logo->height; i++) {
-			for (j = 0; j < logo->width; src++) {
-				d = *src ^ xor;
-				for (k = 7; k >= 0; k--) {
-					*dst++ = ((d >> k) & 1) ? fg : 0;
-					j++;
-				}
-			}
-		}
-		break;
-	}
-}
-
 /*
  * Three (3) kinds of logo maps exist.  linux_logo_clut224 (>16 colors),
  * linux_logo_vga16 (16 colors) and linux_logo_mono (2 colors).  Depending on
@@ -452,11 +410,9 @@
 
 	/* Return if no suitable logo was found */
 	fb_logo.logo = fb_find_logo(depth);
-
-	if (!fb_logo.logo) {
+	if (!fb_logo.logo)
 		return 0;
-	}
-	
+
 	if (rotate == FB_ROTATE_UR || rotate == FB_ROTATE_UD)
 		yres = info->var.yres;
 	else
@@ -480,14 +436,13 @@
 int fb_show_logo(struct fb_info *info, int rotate)
 {
 	u32 *palette = NULL, *saved_pseudo_palette = NULL;
-	unsigned char *logo_new = NULL, *logo_rotate = NULL;
 	struct fb_image image;
 
 	/* Return if the frame buffer is not mapped or suspended */
 	if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING)
 		return 0;
 
-	image.depth = 8;
+	image.depth = fb_logo.depth;
 	image.data = fb_logo.logo->data;
 
 	if (fb_logo.needs_cmapreset)
@@ -508,17 +463,13 @@
 		info->pseudo_palette = palette;
 	}
 
-	if (fb_logo.depth <= 4) {
-		logo_new = kmalloc(fb_logo.logo->width * fb_logo.logo->height, 
-				   GFP_KERNEL);
-		if (logo_new == NULL) {
-			kfree(palette);
-			if (saved_pseudo_palette)
-				info->pseudo_palette = saved_pseudo_palette;
-			return 0;
+	if (fb_logo.depth == 1) {
+		if (info->fix.visual == FB_VISUAL_MONO01) {
+			u32 fg = image.fg_color;
+
+			image.fg_color = image.bg_color;
+			image.bg_color = fg;
 		}
-		image.data = logo_new;
-		fb_set_logo(info, fb_logo.logo, logo_new, fb_logo.depth);
 	}
 
 	image.dx = 0;
@@ -527,19 +478,17 @@
 	image.height = fb_logo.logo->height;
 
 	if (rotate) {
-		logo_rotate = kmalloc(fb_logo.logo->width *
-				      fb_logo.logo->height, GFP_KERNEL);
+		unsigned char *logo_rotate = kmalloc(fb_logo.logo->width *
+					fb_logo.logo->height, GFP_KERNEL);
 		if (logo_rotate)
 			fb_rotate_logo(info, logo_rotate, &image, rotate);
+		kfree(logo_rotate);
 	}
-
 	fb_do_show_logo(info, &image, rotate);
 
 	kfree(palette);
 	if (saved_pseudo_palette != NULL)
 		info->pseudo_palette = saved_pseudo_palette;
-	kfree(logo_new);
-	kfree(logo_rotate);
 	return fb_logo.logo->height;
 }
 #else
