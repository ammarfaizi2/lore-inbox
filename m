Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269289AbTGUGQb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 02:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269266AbTGUGQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 02:16:31 -0400
Received: from turkey.mail.pas.earthlink.net ([207.217.120.126]:21198 "EHLO
	turkey.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S269294AbTGUGPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 02:15:48 -0400
From: Richard Drummond <lists@rcdrummond.net>
Reply-To: lists@rcdrummond.net
Organization: Private
To: <linux-fbdev-devel@lists.sourceforge.net>
Subject: [PATCH] Fix for image-blitting in tdfxfb driver in 2.6.0-test1
Date: Mon, 21 Jul 2003 01:34:21 -0500
User-Agent: KMail/1.5.2
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
MIME-Version: 1.0
Message-Id: <200307210132.58989.lists@rcdrummond.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tl4G/Cm7INirYOp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_tl4G/Cm7INirYOp
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The following patch fixes some bugs in the tdfxfb driver in 2.6.0-test1. 
Image-blitting in software or hardware should now work. Please apply.

This patch fixes

1) Problems with the driver's pseudo-palette in truecolor modes. Palette 
entries were being mangled, so the foreground and background colours of text 
written to the console was incorrect (this affected image-blitting of text 
whether either the software routine cfb_imageblit or the accelerated 
tdfxfb_imageblit was used).

2) Critical bug in tdfxfb_imageblit. Large blits would try and request more 
fifo entries from the hardware than are available, causing an infinite loop. 
I've fixed this by requesting fifo entries in small chunks rather than trying 
to do it all at once.

3) Various big-endian fixes.

I've also moved the tdfxfb entry in fbmem.c to the 'with resource management' 
section, because it now has it.

Cheers,
Rich


--Boundary-00=_tl4G/Cm7INirYOp
Content-Type: text/x-diff;
  charset="us-ascii";
  name="tdfxfb-2.6.1-test1-20030721.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="tdfxfb-2.6.1-test1-20030721.diff"

--- drivers/video/tdfxfb.c.orig	2003-07-20 02:35:33.000000000 -0500
+++ drivers/video/tdfxfb.c	2003-07-21 00:44:13.000000000 -0500
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
--- drivers/video/fbmem.c.orig	2003-05-26 23:06:02.000000000 -0500
+++ drivers/video/fbmem.c	2003-07-21 01:01:32.000000000 -0500
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

--Boundary-00=_tl4G/Cm7INirYOp--

