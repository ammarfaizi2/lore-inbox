Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267633AbTAQSxj>; Fri, 17 Jan 2003 13:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267640AbTAQSxj>; Fri, 17 Jan 2003 13:53:39 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:29960 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S267633AbTAQSxb>; Fri, 17 Jan 2003 13:53:31 -0500
Subject: [PATCH][FBDEV]: rivafb fixes
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1042826815.936.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Jan 2003 02:54:04 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

The rivafb in linux-2.5.59 is now working on my hardware :-).  

I've attached a diff for linux-2.5.59 that reimplements
rivafb_imageblit() and rivafb_cursor().  The main fix is in
reverse_order() which only reverses the first 2 bytes instead of 4.


I've also attached another diff which should be applied on
top of the first patch.  It's up to you if you want to accept this or
not.  The diff fixes riva_get_cmaplen and includes initialization of 
the color registers.  Since rivafb exports its visual as DIRECTCOLOR,
the color registers must also be set accordingly.  Otherwise, user
applications running on top of rivafb will have wrong colors.  Try it
with XFBDev, and if the colors are wrong, try the attached patch.

I believe this is also a problem with the 2.4 version of rivafb.

Tony

PATCH 1 (rivafb_imageblit and rivafb_cursor)

diff -Naur linux-2.5.59/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
--- linux-2.5.59/drivers/video/riva/fbdev.c	2003-01-17 13:39:08.000000000 +0000
+++ linux/drivers/video/riva/fbdev.c	2003-01-17 13:50:14.000000000 +0000
@@ -458,7 +458,7 @@
 		m = *((u32 *)mask)++;
 		for (j = 0; j < w/2; j++) {
 			tmp = 0;
-#if defined (__BIG_ENDIAN__)
+#if defined (__BIG_ENDIAN)
 			if (m & (1 << 31))
 				tmp = (b & (1 << 31)) ? fg << 16 : bg << 16;
 			b <<= 1;
@@ -1156,13 +1156,13 @@
 	case 16:
 		if (info->var.green.length == 5) {
 			/* 0rrrrrgg gggbbbbb */
-			((u16 *)(info->pseudo_palette))[regno] =
+			((u32 *)(info->pseudo_palette))[regno] =
 					((red & 0xf800) >> 1) |
 					((green & 0xf800) >> 6) |
 					((blue & 0xf800) >> 11);
 		} else {
 			/* rrrrrggg gggbbbbb */
-			((u16 *)(info->pseudo_palette))[regno] =
+			((u32 *)(info->pseudo_palette))[regno] =
 					((red & 0xf800) >> 0) |
 					((green & 0xf800) >> 5) |
 					((blue & 0xf800) >> 11);
@@ -1288,6 +1288,8 @@
 {
 	u8 *a = (u8 *)l;
 	*a = byte_rev[*a], a++;
+	*a = byte_rev[*a], a++;
+	*a = byte_rev[*a], a++;
 	*a = byte_rev[*a];
 }
 
@@ -1318,10 +1320,10 @@
 static void rivafb_imageblit(struct fb_info *info, struct fb_image *image)
 {
 	struct riva_par *par = (struct riva_par *) info->par;
-	u32 fgx = 0, bgx = 0, width, mod;
-	u8 *cdat = image->data, *dat;
+	u32 fgx = 0, bgx = 0, width, mod, tmp;
+	u8 *cdat = image->data;
 	volatile u32 *d;
-	int i, j, size;
+	int i, j, k, size;
 
 	if (image->depth != 1) {
 		wait_for_idle(par);
@@ -1330,84 +1332,80 @@
 	}
 
 	width = (image->width + 7)/8;
-
-	size = image->width * image->height;
-	dat = cdat;
-/*
-	for (i = 0; i < size; i++) {
-		*dat = byte_rev[*dat];
-		dat++;
-	}
-*/
 	switch (info->var.bits_per_pixel) {
 	case 8:
 		fgx = image->fg_color;
 		bgx = image->bg_color;
 		break;
 	case 16:
-		fgx |= ((u16 *) (info->pseudo_palette))[image->fg_color];
-		bgx |= ((u16 *) (info->pseudo_palette))[image->bg_color];
+		fgx = ((u32 *) (info->pseudo_palette))[image->fg_color];
+		bgx = ((u32 *) (info->pseudo_palette))[image->bg_color];
 		if (info->var.green.length == 6)
 			convert_bgcolor_16(&bgx);	
 		break;
 	case 32:
-		fgx |= ((u32 *) (info->pseudo_palette))[image->fg_color];
-		bgx |= ((u32 *) (info->pseudo_palette))[image->bg_color];
+		fgx = ((u32 *) (info->pseudo_palette))[image->fg_color];
+		bgx = ((u32 *) (info->pseudo_palette))[image->bg_color];
 		break;
 	}
 
 	RIVA_FIFO_FREE(par->riva, Bitmap, 7);
-	par->riva.Bitmap->ClipE.TopLeft     = (image->dy << 16) | (image->dx & 0xFFFF);
-	par->riva.Bitmap->ClipE.BottomRight = (((image->dy + image->height) << 16) |
-                                       		((image->dx + image->width) & 0xffff));
+	par->riva.Bitmap->ClipE.TopLeft     = 
+		(image->dy << 16) | (image->dx & 0xFFFF);
+	par->riva.Bitmap->ClipE.BottomRight = 
+		(((image->dy + image->height) << 16) |
+		 ((image->dx + image->width) & 0xffff));
 	par->riva.Bitmap->Color0E           = bgx;
 	par->riva.Bitmap->Color1E           = fgx;
-	par->riva.Bitmap->WidthHeightInE    = (image->height << 16) | ((image->width + 31) & ~31);
-	par->riva.Bitmap->WidthHeightOutE   = (image->height << 16) | ((image->width + 31) & ~31);
-	par->riva.Bitmap->PointE            = (image->dy << 16) | (image->dx & 0xFFFF);
+	par->riva.Bitmap->WidthHeightInE    = 
+		(image->height << 16) | ((image->width + 31) & ~31);
+	par->riva.Bitmap->WidthHeightOutE   = 
+		(image->height << 16) | ((image->width + 31) & ~31);
+	par->riva.Bitmap->PointE            = 
+		(image->dy << 16) | (image->dx & 0xFFFF);
 
 	d = &par->riva.Bitmap->MonochromeData01E;
 
 	mod = width % 4;
 
 	if (width >= 4) {
-		while (image->height--) {
+		k = image->height;
+		while (k--) {
 			size = width / 4;
 			while (size >= 16) {
 				RIVA_FIFO_FREE(par->riva, Bitmap, 16);
-				for (i = 0; i < 16; i++)
-					d[i] = *((u32 *)cdat)++;
+				for (i = 0; i < 16; i++) {
+					tmp = *((u32 *)cdat)++;
+					reverse_order(&tmp);
+					d[i] = tmp;
+				}
 				size -= 16;
 			}
 
 			if (size) {
 				RIVA_FIFO_FREE(par->riva, Bitmap, size);
-				for (i = 0; i < size; i++)
-					d[i] = *((u32 *) cdat)++;
+				for (i = 0; i < size; i++) {
+					tmp = *((u32 *) cdat)++;
+					reverse_order(&tmp);
+					d[i] = tmp;
+				}
 			}
 
 			if (mod) {
-				u32 tmp;
 				RIVA_FIFO_FREE(par->riva, Bitmap, 1);
 				for (i = 0; i < mod; i++)
 					((u8 *)&tmp)[i] = *cdat++;
+				reverse_order(&tmp);
 				d[i] = tmp;
 			}
 		}
 	} else {
-		u32 tmp;
-
 		for (i = image->height; i > 0; i-=16) {
-			if (i >= 16)
-				size = 16;
-			else
-				size = i;
+			size = (i >= 16) ? 16 : i;
 			RIVA_FIFO_FREE(par->riva, Bitmap, size);
 			for (j = 0; j < size; j++) {
-				if (image->width <= 8)
-					tmp = *cdat++;
-				else
-					tmp = *((u16 *)cdat)++;
+				for (k = 0; k < width; k++) 
+					((u8 *) &tmp)[k] = *cdat++;
 				reverse_order(&tmp);
 				d[j] = tmp;
 			}
@@ -1470,14 +1468,19 @@
 	if (flags & (FB_CUR_SETSHAPE | FB_CUR_SETCMAP | FB_CUR_SETDEST)) {
 		int bg_idx = cursor->image.bg_color;
 		int fg_idx = cursor->image.fg_color;
+		int width = (cursor->image.width+7)/8;
+		u8 *dat = (u8 *) cursor->image.data;
+		u8 *dst = (u8 *) cursor->dest;
+		u8 *msk = (u8 *) cursor->mask;
 
 		switch (cursor->rop) {
 		case ROP_XOR:
 			for (i = 0; i < cursor->image.height; i++) {
-				for (j = 0; j < (cursor->image.width + 7)/8; j++) {
+				for (j = 0; j < width; j++) {
 					d_idx = i * MAX_CURS/8  + j;
-					data[d_idx] =  byte_rev[((u8 *)cursor->image.data)[s_idx] ^ ((u8 *)cursor->dest)[s_idx]]; 	
-					mask[d_idx] = byte_rev[((u8 *)cursor->mask)[s_idx]];
+					data[d_idx] =  byte_rev[dat[s_idx] ^ 
+								dst[s_idx]];
+					mask[d_idx] = byte_rev[msk[s_idx]];
 					s_idx++;
 				}
 			}
@@ -1485,24 +1488,24 @@
 		case ROP_COPY:
 		default:
 			for (i = 0; i < cursor->image.height; i++) {
-				for (j = 0; j < (cursor->image.width + 7)/8; j++) {
+				for (j = 0; j < width; j++) {
 					d_idx = i * MAX_CURS/8 + j;
-					data[d_idx] = byte_rev[((u8 *)cursor->image.data)[s_idx]];
-					mask[d_idx] = byte_rev[((u8 *)cursor->mask)[s_idx]];
+					data[d_idx] = byte_rev[dat[s_idx]];
+					mask[d_idx] = byte_rev[msk[s_idx]];
 					s_idx++;
 				}
 			}
 			break;
 		}
-/*
-		bg = ((par->cmap[bg_idx].red & 0xf8) << 7) |
-		     ((par->cmap[bg_idx].green & 0xf8) << 2) |
-		     ((par->cmap[bg_idx].blue & 0xf8) >> 3) | 1 << 15;
-
-		fg = ((par->cmap[fg_idx].red & 0xf8) << 7) |
-		     ((par->cmap[fg_idx].green & 0xf8) << 2) |
-		     ((par->cmap[fg_idx].blue & 0xf8) >> 3) | 1 << 15;
-*/
+
+		bg = ((info->cmap.red[bg_idx] & 0xf8) << 7) |
+		     ((info->cmap.green[bg_idx] & 0xf8) << 2) |
+		     ((info->cmap.blue[bg_idx] & 0xf8) >> 3) | 1 << 15;
+
+		fg = ((info->cmap.red[fg_idx] & 0xf8) << 7) |
+		     ((info->cmap.green[fg_idx] & 0xf8) << 2) |
+		     ((info->cmap.blue[fg_idx] & 0xf8) >> 3) | 1 << 15;
+
 		par->riva.LockUnlock(&par->riva, 0);
 		rivafb_load_cursor_image(data, mask, par, cursor->image.width,
 		cursor->image.height, bg, fg);
@@ -1538,8 +1541,8 @@
 	.fb_blank 	= rivafb_blank,
 	.fb_fillrect 	= rivafb_fillrect,
 	.fb_copyarea 	= rivafb_copyarea,
-	.fb_imageblit 	= cfb_imageblit,
-	.fb_cursor	= soft_cursor,	
+	.fb_imageblit 	= rivafb_imageblit,
+	.fb_cursor	= rivafb_cursor,	
 	.fb_sync 	= rivafb_sync,
 };
 

PATCH 2 (color register fix)

diff -Naur linux-2.5.59/drivers/video/riva/fbdev.c linux/drivers/video/riva/fbdev.c
--- linux-2.5.59/drivers/video/riva/fbdev.c	2003-01-17 16:21:54.000000000 +0000
+++ linux/drivers/video/riva/fbdev.c	2003-01-17 18:04:41.000000000 +0000
@@ -310,9 +310,9 @@
 	xres_virtual:	640,
 	yres_virtual:	480,
 	bits_per_pixel:	8,
-	red:		{0, 6, 0},
-	green:		{0, 6, 0},
-	blue:		{0, 6, 0},
+	red:		{0, 8, 0},
+	green:		{0, 8, 0},
+	blue:		{0, 8, 0},
 	transp:		{0, 0, 0},
 	activate:	FB_ACTIVATE_NOW,
 	height:		-1,
@@ -515,6 +515,31 @@
 }
 
 /**
+ * riva_rclut - read fromCLUT register
+ * @chip: pointer to RIVA_HW_INST object
+ * @regnum: register number
+ * @red: red component
+ * @green: green component
+ * @blue: blue component
+ *
+ * DESCRIPTION:
+ * Reads red, green, and blue from color register @regnum.
+ *
+ * CALLED FROM:
+ * rivafb_setcolreg()
+ */
+static void riva_rclut(RIVA_HW_INST *chip,
+		       unsigned char regnum, unsigned char *red,
+		       unsigned char *green, unsigned char *blue)
+{
+	
+	VGA_WR08(chip->PDIO, 0x3c8, regnum);
+	*red = VGA_RD08(chip->PDIO, 0x3c9);
+	*green = VGA_RD08(chip->PDIO, 0x3c9);
+	*blue = VGA_RD08(chip->PDIO, 0x3c9);
+}
+
+/**
  * riva_save_state - saves current chip state
  * @par: pointer to riva_par object containing info for current riva board
  * @regs: pointer to riva_regs object
@@ -870,21 +895,18 @@
  */
 static int riva_get_cmap_len(const struct fb_var_screeninfo *var)
 {
-	int rc = 16;		/* reasonable default */
+	int rc = 256;		/* reasonable default */
 
-	switch (var->bits_per_pixel) {
+	switch (var->green.length) {
 	case 8:
-		rc = 256;	/* pseudocolor... 256 entries HW palette */
+		rc = 256;	/* 256 entries (2^8), 8 bpp and RGB8888 */
 		break;
-	case 15:
-		rc = 15;	/* fix for 15 bpp depths on Riva 128 based cards */
+	case 5:
+		rc = 32;	/* 32 entries (2^5), 16 bpp, RGB555 */
 		break;
-	case 16:
-		rc = 16;	/* directcolor... 16 entries SW palette */
-		break;		/* Mystique: truecolor, 16 entries SW palette, HW palette hardwired into 1:1 mapping */
-	case 32:
-		rc = 16;	/* directcolor... 16 entries SW palette */
-		break;		/* Mystique: truecolor, 16 entries SW palette, HW palette hardwired into 1:1 mapping */
+	case 6:
+		rc = 64;	/* 64 entries (2^6), 16 bpp, RGB565 */
+		break;		
 	default:
 		/* should not occur */
 		break;
@@ -1138,6 +1160,7 @@
 {
 	struct riva_par *par = (struct riva_par *)info->par;
 	RIVA_HW_INST *chip = &par->riva;
+	int i;
 
 	if (regno >= riva_get_cmap_len(&info->var))
 		return -EINVAL;
@@ -1155,23 +1178,46 @@
 		break;
 	case 16:
 		if (info->var.green.length == 5) {
-			/* 0rrrrrgg gggbbbbb */
-			((u32 *)(info->pseudo_palette))[regno] =
+			if (regno < 16) {
+				/* 0rrrrrgg gggbbbbb */
+				((u32 *)info->pseudo_palette)[regno] =
 					((red & 0xf800) >> 1) |
 					((green & 0xf800) >> 6) |
 					((blue & 0xf800) >> 11);
+			}
+			for (i = 0; i < 8; i++) 
+				riva_wclut(chip, regno*8+i, red >> 8,
+					   green >> 8, blue >> 8);
 		} else {
-			/* rrrrrggg gggbbbbb */
-			((u32 *)(info->pseudo_palette))[regno] =
+			u8 r, g, b;
+
+			if (regno < 16) {
+				/* rrrrrggg gggbbbbb */
+				((u32 *)info->pseudo_palette)[regno] =
 					((red & 0xf800) >> 0) |
 					((green & 0xf800) >> 5) |
 					((blue & 0xf800) >> 11);
+			}
+			if (regno < 32) {
+				for (i = 0; i < 8; i++) {
+					riva_wclut(chip, regno*8+i, red >> 8, 
+						   green >> 8, blue >> 8);
+				}
+			}
+			for (i = 0; i < 4; i++) {
+				riva_rclut(chip, regno*2+i, &r, &g, &b);
+				riva_wclut(chip, regno*4+i, r, green >> 8, b);
+			}
 		}
 		break;
 	case 32:
-		((u32 *) (info->pseudo_palette))[regno] =
-		    		((red & 0xff00) << 8) |
-		    		((green & 0xff00)) | ((blue & 0xff00) >> 8);
+		if (regno < 16) {
+			((u32 *)info->pseudo_palette)[regno] =
+				((red & 0xff00) << 8) |
+				((green & 0xff00)) | ((blue & 0xff00) >> 8);
+			
+		}
+		riva_wclut(chip, regno, red >> 8, green >> 8, blue >> 8);
 		break;
 	default:
 		/* do nothing */
@@ -1200,7 +1246,7 @@
 	if (info->var.bits_per_pixel == 8)
 		color = rect->color;
 	else
-		color = ((u32 *)(info->pseudo_palette))[rect->color];
+		color = ((u32 *)info->pseudo_palette)[rect->color];
 
 	switch (rect->rop) {
 	case ROP_XOR:
@@ -1338,14 +1384,14 @@
 		bgx = image->bg_color;
 		break;
 	case 16:
-		fgx = ((u32 *) (info->pseudo_palette))[image->fg_color];
-		bgx = ((u32 *) (info->pseudo_palette))[image->bg_color];
+		fgx = ((u32 *)info->pseudo_palette)[image->fg_color];
+		bgx = ((u32 *)info->pseudo_palette)[image->bg_color];
 		if (info->var.green.length == 6)
 			convert_bgcolor_16(&bgx);	
 		break;
 	case 32:
-		fgx = ((u32 *) (info->pseudo_palette))[image->fg_color];
-		bgx = ((u32 *) (info->pseudo_palette))[image->bg_color];
+		fgx = ((u32 *)info->pseudo_palette)[image->fg_color];
+		bgx = ((u32 *)info->pseudo_palette)[image->bg_color];
 		break;
 	}
 
@@ -1557,7 +1603,7 @@
 	info->fix = rivafb_fix;
 	info->fbops = &riva_fb_ops;
 	info->pseudo_palette = pseudo_palette;
-	
+
 #ifndef MODULE
 	if (mode_option)
 		fb_find_mode(&info->var, info, mode_option,

