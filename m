Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272676AbTG0XRK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 19:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272943AbTG0XB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 19:01:59 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272869AbTG0XA5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:00:57 -0400
Date: Sun, 27 Jul 2003 21:17:07 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200307272017.h6RKH7WU029737@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: tdfx framebuffer updates
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

((Richard Drummond)
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/video/fbmem.c linux-2.6.0-test2-ac1/drivers/video/fbmem.c
--- linux-2.6.0-test2/drivers/video/fbmem.c	2003-07-10 21:03:32.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/video/fbmem.c	2003-07-23 15:45:30.000000000 +0100
@@ -214,6 +214,9 @@
 #ifdef CONFIG_FB_RIVA
 	{ "rivafb", rivafb_init, rivafb_setup },
 #endif
+#ifdef CONFIG_FB_3DFX
+	{ "tdfxfb", tdfxfb_init, tdfxfb_setup },
+#endif
 #ifdef CONFIG_FB_RADEON
 	{ "radeonfb", radeonfb_init, radeonfb_setup },
 #endif
@@ -294,9 +297,6 @@
 	 * Chipset specific drivers that don't use resource management (yet)
 	 */
 
-#ifdef CONFIG_FB_3DFX
-	{ "tdfxfb", tdfxfb_init, tdfxfb_setup },
-#endif
 #ifdef CONFIG_FB_SGIVW
 	{ "sgivwfb", sgivwfb_init, sgivwfb_setup },
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.6.0-test2/drivers/video/tdfxfb.c linux-2.6.0-test2-ac1/drivers/video/tdfxfb.c
--- linux-2.6.0-test2/drivers/video/tdfxfb.c	2003-07-10 21:06:48.000000000 +0100
+++ linux-2.6.0-test2-ac1/drivers/video/tdfxfb.c	2003-07-23 15:45:30.000000000 +0100
@@ -1,3 +1,4 @@
+
 /*
  *
  * tdfxfb.c
@@ -177,7 +178,7 @@
 	.fb_pan_display	= tdfxfb_pan_display,
 	.fb_fillrect	= tdfxfb_fillrect,
 	.fb_copyarea	= tdfxfb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
+	.fb_imageblit	= tdfxfb_imageblit,
 	.fb_sync	= banshee_wait_idle,
 	.fb_cursor	= soft_cursor,
 };
@@ -316,7 +317,9 @@
 
 static inline void banshee_make_room(struct tdfx_par *par, int size)
 {
-	while((tdfx_inl(par, STATUS) & 0x1f) < size);
+	/* Note: The Voodoo3's onboard FIFO has 32 slots. This loop
+	 * won't quit if you ask for more. */
+	while((tdfx_inl(par, STATUS) & 0x1f) < size-1);
 }
  
 static int banshee_wait_idle(struct fb_info *info)
@@ -746,6 +749,7 @@
 #if defined(__BIG_ENDIAN)
 	switch (info->var.bits_per_pixel) {
 		case 8:
+		case 24:
 			reg.miscinit0 &= ~(1 << 30);
 			reg.miscinit0 &= ~(1 << 31);
 			break;
@@ -753,7 +757,6 @@
 			reg.miscinit0 |= (1 << 30);
 			reg.miscinit0 |= (1 << 31);
 			break;
-		case 24:
 		case 32:
 			reg.miscinit0 |= (1 << 30);
 			reg.miscinit0 &= ~(1 << 31);
@@ -771,6 +774,9 @@
 	return 0;	
 }
 
+/* A handy macro shamelessly pinched from matroxfb */
+#define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
+
 static int tdfxfb_setcolreg(unsigned regno, unsigned red, unsigned green,  
 			    unsigned blue,unsigned transp,struct fb_info *info) 
 {
@@ -788,13 +794,10 @@
 			break;
 		/* Truecolor has no hardware color palettes. */
 		case FB_VISUAL_TRUECOLOR:
-			rgbcol = (red << info->var.red.offset) |
-				 (green << info->var.green.offset) |
-				 (blue << info->var.blue.offset) |
-				 (transp << info->var.transp.offset);
-			if (info->var.bits_per_pixel <= 16)
-				((u16*)(info->pseudo_palette))[regno] = rgbcol;
-			else
+			rgbcol = (CNVT_TOHW( red, info->var.red.length) << info->var.red.offset) |
+				 (CNVT_TOHW( green, info->var.green.length) << info->var.green.offset) |
+				 (CNVT_TOHW( blue, info->var.blue.length) << info->var.blue.offset) |
+				 (CNVT_TOHW( transp, info->var.transp.length) << info->var.transp.offset);
 				((u32*)(info->pseudo_palette))[regno] = rgbcol;
 			break;
 		default:
@@ -934,6 +937,7 @@
 {
 	struct tdfx_par *par = (struct tdfx_par *) info->par;
 	int size = image->height * ((image->width * image->depth + 7)>>3);
+	int fifo_free;
 	int i, stride = info->fix.line_length;
 	u32 bpp = info->var.bits_per_pixel;
 	u32 dstfmt = stride | ((bpp+((bpp==8) ? 0 : 8)) << 13); 
@@ -946,10 +950,22 @@
 		cfb_imageblit(info, image);
 		return;
 	} else {
-		banshee_make_room(par, 8 + ((size + 3) >> 2));
+		banshee_make_room(par, 8);
+		switch (info->fix.visual) {
+			case FB_VISUAL_PSEUDOCOLOR:
 		tdfx_outl(par, COLORFORE, image->fg_color);
 		tdfx_outl(par, COLORBACK, image->bg_color);
+				break;
+			case FB_VISUAL_TRUECOLOR:
+			default:
+				tdfx_outl(par, COLORFORE, ((u32*)(info->pseudo_palette))[image->fg_color]);
+				tdfx_outl(par, COLORBACK, ((u32*)(info->pseudo_palette))[image->bg_color]);
+		}
+#ifdef __BIG_ENDIAN
+		srcfmt = 0x400000 | BIT(20);
+#else
 		srcfmt = 0x400000;
+#endif
 	}	
 
 	tdfx_outl(par,	SRCXY,     0);
@@ -959,13 +975,22 @@
 	tdfx_outl(par,	DSTFORMAT, dstfmt);
 	tdfx_outl(par,	DSTSIZE,   image->width | (image->height << 16));
 
+	/* A count of how many free FIFO entries we've requested.
+	 * When this goes negative, we need to request more. */
+	fifo_free = 0;
+
 	/* Send four bytes at a time of data */	
 	for (i = (size >> 2) ; i > 0; i--) { 
+		if(--fifo_free < 0) {
+			fifo_free=31;
+			banshee_make_room(par,fifo_free);
+		}
 		tdfx_outl(par,	LAUNCH_2D,*(u32*)chardata);
 		chardata += 4; 
 	}	
 
 	/* Send the leftovers now */	
+	banshee_make_room(par,3);
 	i = size%4;	
 	switch (i) {
 		case 0: break;
