Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbSK1EZn>; Wed, 27 Nov 2002 23:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbSK1EZn>; Wed, 27 Nov 2002 23:25:43 -0500
Received: from [203.167.79.9] ([203.167.79.9]:33796 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S265154AbSK1EZ3>; Wed, 27 Nov 2002 23:25:29 -0500
Subject: [PATCh} FBDev: rivafb port
From: Antonino Daplas <adaplas@pol.net>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-28WjBxVVsQM/XIowjnob"
Message-Id: <1038467725.1092.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Nov 2002 12:23:29 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-28WjBxVVsQM/XIowjnob
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is a patch against 2.5.49 + James Simmons' latest fbdev.diff.

1. Added full hardware acceleration (should be 3 - 4x faster thant 2.4
version with the putcs optimization.)
2. Added hardware cursor support
3. Fixed wrong color at depths > 8bpp, at least for the Riva128.

Tony



--=-28WjBxVVsQM/XIowjnob
Content-Disposition: attachment; filename=rivafix.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=rivafix.diff; charset=UTF-8

diff -Naur linux-2.5.49/drivers/video/riva/Makefile linux/drivers/video/riv=
a/Makefile
--- linux-2.5.49/drivers/video/riva/Makefile	2002-11-28 06:35:57.000000000 =
+0000
+++ linux/drivers/video/riva/Makefile	2002-11-28 06:35:18.000000000 +0000
@@ -4,6 +4,6 @@
=20
 obj-$(CONFIG_FB_RIVA) +=3D rivafb.o
=20
-rivafb-objs :=3D fbdev.o riva_hw.o accel.o
+rivafb-objs :=3D fbdev.o riva_hw.o
=20
 include $(TOPDIR)/Rules.make
diff -Naur linux-2.5.49/drivers/video/riva/fbdev.c linux/drivers/video/riva=
/fbdev.c
--- linux-2.5.49/drivers/video/riva/fbdev.c	2002-11-28 06:35:49.000000000 +=
0000
+++ linux/drivers/video/riva/fbdev.c	2002-11-28 06:42:17.000000000 +0000
@@ -245,11 +245,8 @@
  * -----------------------------------------------------------------------=
-- */
=20
 /* command line data, set in rivafb_setup() */
-static char fontname[40] __initdata =3D { 0 };
 static u32  pseudo_palette[17];
 static char nomove =3D 0;
-static char nohwcursor __initdata =3D 0;
-static char noblink =3D 0;
 #ifdef CONFIG_MTRR
 static char nomtrr __initdata =3D 0;
 #endif
@@ -284,7 +281,7 @@
 	activate:	0,
 	height:		-1,
 	width:		-1,
-	accel_flags:	FB_ACCELF_TEXT,
+	accel_flags:	 FB_ACCELF_TEXT,=20
 	pixclock:	39721,
 	left_margin:	40,
 	right_margin:	24,
@@ -400,236 +397,60 @@
  * -----------------------------------------------------------------------=
-- */
=20
 /**
- * riva_cursor_timer_handler - blink timer
- * @dev_addr: pointer to riva_par object containing info for current riva =
board
- *
- * DESCRIPTION:
- * Cursor blink timer.
- */
-static void riva_cursor_timer_handler(unsigned long dev_addr)
-{
-	struct riva_par *par =3D (struct riva_par *) dev_addr;
-
-	if (!par->cursor) return;
-
-	if (!par->cursor->enable) goto out;
-
-	if (par->cursor->last_move_delay < 1000)
-		par->cursor->last_move_delay++;
-
-	if (par->cursor->vbl_cnt && --par->cursor->vbl_cnt =3D=3D 0) {
-		par->cursor->on ^=3D 1;
-		if (par->cursor->on)
-			*(par->riva.CURSORPOS) =3D (par->cursor->pos.x & 0xFFFF)
-						   | (par->cursor->pos.y << 16);
-		par->riva.ShowHideCursor(&par->riva, par->cursor->on);
-		if (!noblink)
-			par->cursor->vbl_cnt =3D par->cursor->blink_rate;
-	}
-out:
-	par->cursor->timer->expires =3D jiffies + (HZ / 100);
-	add_timer(par->cursor->timer);
-}
-
-/**
- * rivafb_init_cursor - allocates cursor structure and starts blink timer
- * @par: pointer to riva_par object containing info for current riva board
- *
- * DESCRIPTION:
- * Allocates cursor structure and starts blink timer.
- *
- * RETURNS:
- * Pointer to allocated cursor structure.
- *
- * CALLED FROM:
- * rivafb_init_one()
- */
-static struct riva_cursor * __init rivafb_init_cursor(struct riva_par *par=
)
-{
-	struct riva_cursor *cursor;
-
-	cursor =3D kmalloc(sizeof(struct riva_cursor), GFP_KERNEL);
-	if (!cursor) return 0;
-	memset(cursor, 0, sizeof(*cursor));
-
-	cursor->timer =3D kmalloc(sizeof(*cursor->timer), GFP_KERNEL);
-	if (!cursor->timer) {
-		kfree(cursor);
-		return 0;
-	}
-	memset(cursor->timer, 0, sizeof(*cursor->timer));
-
-	cursor->blink_rate =3D DEFAULT_CURSOR_BLINK_RATE;
-
-	init_timer(cursor->timer);
-	cursor->timer->expires =3D jiffies + (HZ / 100);
-	cursor->timer->data =3D (unsigned long)par;
-	cursor->timer->function =3D riva_cursor_timer_handler;
-	add_timer(cursor->timer);
-
-	return cursor;
-}
-
-/**
- * rivafb_exit_cursor - stops blink timer and releases cursor structure
- * @par: pointer to riva_par object containing info for current riva board
- *
- * DESCRIPTION:
- * Stops blink timer and releases cursor structure.
- *
- * CALLED FROM:
- * rivafb_init_one()
- * rivafb_remove_one()
- */
-static void rivafb_exit_cursor(struct riva_par *par)
-{
-	struct riva_cursor *cursor =3D par->cursor;
-
-	if (cursor) {
-		if (cursor->timer) {
-			del_timer_sync(cursor->timer);
-			kfree(cursor->timer);
-		}
-		kfree(cursor);
-		par->cursor =3D 0;
-	}
-}
-
-/**
- * rivafb_download_cursor - writes cursor shape into card registers
- * @info: pointer to fb_info object containing info for current riva board
- *
- * DESCRIPTION:
- * Writes cursor shape into card registers.
- *
- * CALLED FROM:
- * riva_load_video_mode()
- */
-static void rivafb_download_cursor(struct fb_info *info)
-{
-	struct riva_par *par =3D (struct riva_par *) info->par;
-	int i, save;
-	int *image;
-=09
-	if (!par->cursor) return;
-
-	image =3D (int *)par->cursor->image;
-	save =3D par->riva.ShowHideCursor(&par->riva, 0);
-	for (i =3D 0; i < (MAX_CURS*MAX_CURS*2)/sizeof(int); i++)
-		writel(image[i], par->riva.CURSOR + i);
-
-	par->riva.ShowHideCursor(&par->riva, save);
-}
-
-/**
- * rivafb_create_cursor - sets rectangular cursor
- * @info: pointer to fb_info object containing info for current riva board
- * @width: cursor width in pixels
- * @height: cursor height in pixels
- *
- * DESCRIPTION:
- * Sets rectangular cursor.
+ * rivafb_load_cursor_image - load cursor image to hardware
+ * @data: address to monochrome bitmap (1 =3D foreground color, 0 =3D back=
ground)
+ * @mask: address to mask (1 =3D write image pixel, 0 =3D do not write pix=
el)
+ * @par:  pointer to private data
+ * @w:    width of cursor image in pixels
+ * @h:    height of cursor image in scanlines
+ * @bg:   background color (ARGB1555) - alpha bit determines opacity
+ * @fg:   foreground color (ARGB1555)
+ *
+ * DESCRIPTiON:
+ * Loads cursor image based on a monochrome source and mask bitmap.  The
+ * mask bit determines if the image pixel is to be written to the framebuf=
fer
+ * or not.  The imaage bits determines the color of the pixel, 0 for=20
+ * background, 1 for foreground.  Only the affected region (as determined=20
+ * by @w and @h parameters) will be updated.
  *
  * CALLED FROM:
- * rivafb_set_font()
- * rivafb_set_var()
+ * rivafb_cursor()
  */
-static void rivafb_create_cursor(struct fb_info *info, int width, int heig=
ht)
+static void rivafb_load_cursor_image(u8 *data, u8 *mask, struct riva_par *=
par,=20
+				     int w, int h, u16 bg, u16 fg)
 {
-	struct riva_par *par =3D (struct riva_par *) info->par;
-	struct riva_cursor *c =3D par->cursor;
-	int i, j, idx;
-
-	if (c) {
-		if (width <=3D 0 || height <=3D 0) {
-			width =3D 8;
-			height =3D 16;
-		}
-		if (width > MAX_CURS) width =3D MAX_CURS;
-		if (height > MAX_CURS) height =3D MAX_CURS;
-
-		c->size.x =3D width;
-		c->size.y =3D height;
-	=09
-		idx =3D 0;
-
-		for (i =3D 0; i < height; i++) {
-			for (j =3D 0; j < width; j++,idx++)
-				c->image[idx] =3D CURSOR_COLOR;
-			for (j =3D width; j < MAX_CURS; j++,idx++)
-				c->image[idx] =3D TRANSPARENT_COLOR;
-		}
-		for (i =3D height; i < MAX_CURS; i++)
-			for (j =3D 0; j < MAX_CURS; j++,idx++)
-				c->image[idx] =3D TRANSPARENT_COLOR;
-	}
-}
-
-/**
- * rivafb_set_font - change font size
- * @p: pointer to display object
- * @width: font width in pixels
- * @height: font height in pixels
- *
- * DESCRIPTION:
- * Callback function called if font settings changed.
- *
- * RETURNS:
- * 1 (Always succeeds.)
- */
-static int rivafb_set_font(struct display *p, int width, int height)
-{
-	rivafb_create_cursor(p->fb_info, width, height);
-	return 1;
-}
-
-/**
- * rivafb_cursor - cursor handler
- * @p: pointer to display object
- * @mode: cursor mode (see CM_*)
- * @x: cursor x coordinate in characters
- * @y: cursor y coordinate in characters
- *
- * DESCRIPTION:
- * Cursor handler.
- */
-static void rivafb_cursor(struct display *p, int mode, int x, int y)
-{
-	struct fb_info *info =3D p->fb_info;
-	struct riva_par *par =3D (struct riva_par *) info->par;
-	struct riva_cursor *c =3D par->cursor;
-
-	if (!c)	return;
-
-	x =3D x * fontwidth(p) - p->var.xoffset;
-	y =3D y * fontheight(p) - p->var.yoffset;
-
-	if (c->pos.x =3D=3D x && c->pos.y =3D=3D y && (mode =3D=3D CM_ERASE) =3D=
=3D !c->enable)
-		return;
-
-	c->enable =3D 0;
-	if (c->on) par->riva.ShowHideCursor(&par->riva, 0);
-	=09
-	c->pos.x =3D x;
-	c->pos.y =3D y;
-
-	switch (mode) {
-	case CM_ERASE:
-		c->on =3D 0;
-		break;
-	case CM_DRAW:
-	case CM_MOVE:
-		if (c->last_move_delay <=3D 1) { /* rapid cursor movement */
-			c->vbl_cnt =3D CURSOR_SHOW_DELAY;
-		} else {
-			*(par->riva.CURSORPOS) =3D (x & 0xFFFF) | (y << 16);
-			par->riva.ShowHideCursor(&par->riva, 1);
-			if (!noblink) c->vbl_cnt =3D CURSOR_HIDE_DELAY;
-			c->on =3D 1;
+	int i, j, k =3D 0;
+	u32 b, m, tmp;
+      =20
+
+	for (i =3D 0; i < h; i++) {
+		b =3D *((u32 *)data)++;
+		m =3D *((u32 *)mask)++;
+		for (j =3D 0; j < w/2; j++) {
+			tmp =3D 0;
+#if defined (__BIG_ENDIAN)=20
+			if (m & (1 << 31))
+				tmp =3D (b & (1 << 31)) ? fg << 16 : bg << 16;
+			b <<=3D 1;
+			m <<=3D 1;
+
+			if (m & (1 << 31))
+				tmp |=3D (b & (1 << 31)) ? fg : bg;
+			b <<=3D 1;
+			m <<=3D 1;
+#else
+			if (m & 1)
+				tmp =3D (b & 1) ? fg : bg;
+			b >>=3D 1;
+			m >>=3D 1;
+			if (m & 1)
+				tmp |=3D (b & 1) ? fg << 16 : bg << 16;
+			b >>=3D 1;
+			m >>=3D 1;
+#endif
+			writel(tmp, par->riva.CURSOR + k++);
 		}
-		c->last_move_delay =3D 0;
-		c->enable =3D 1;
-		break;
+		k +=3D (MAX_CURS - w)/2;
 	}
 }
=20
@@ -833,9 +654,6 @@
=20
 	par->current_state =3D newmode;
 	riva_load_state(par, &par->current_state);
-
-	par->riva.LockUnlock(&par->riva, 0); /* important for HW cursor */
-	rivafb_download_cursor(info);
 }
=20
 /**
@@ -961,7 +779,339 @@
 	par->riva.Clip->TopLeft     =3D 0x0;
 	par->riva.Clip->WidthHeight =3D 0x80008000;
 	riva_setup_ROP(par);
+}
+
+/**
+ * rivafb_fillrect - hardware accelerated color fill function
+ * @info: pointer to fb_info structure
+ * @rect: pointer to fb_fillrect structure
+ *=20
+ * DESCRIPTION:
+ * This function fills up a region of framebuffer memory with a solid
+ * color with a choice of two different ROP's, copy or invert.
+ *
+ * CALLED FROM:
+ * framebuffer hook
+ */
+static void rivafb_fillrect(struct fb_info *info, struct fb_fillrect *rect=
)
+{
+	struct riva_par *par =3D (struct riva_par *) info->par;
+	u_int color, rop =3D 0;
+
+	if (info->var.bits_per_pixel =3D=3D 8)
+		color =3D rect->color;
+	else
+		color =3D par->riva_palette[rect->color];
+
+	switch (rect->rop) {
+	case ROP_XOR:
+		rop =3D 0x66;
+		break;
+	case ROP_COPY:
+	default:
+		rop =3D 0xCC;
+		break;
+	}
+
+	RIVA_FIFO_FREE(par->riva, Rop, 1);
+	par->riva.Rop->Rop3 =3D rop;
+
+	RIVA_FIFO_FREE(par->riva, Bitmap, 1);
+	par->riva.Bitmap->Color1A =3D color;
+
+	RIVA_FIFO_FREE(par->riva, Bitmap, 2);
+	par->riva.Bitmap->UnclippedRectangle[0].TopLeft =3D=20
+		(rect->dx << 16) | rect->dy;
+	par->riva.Bitmap->UnclippedRectangle[0].WidthHeight =3D
+		(rect->width << 16) | rect->height;
+}
+
+/**
+ * rivafb_copyarea - hardware accelerated blit function
+ * @info: pointer to fb_info structure
+ * @region: pointer to fb_copyarea structure
+ *
+ * DESCRIPTION:
+ * This copies an area of pixels from one location to another
+ *
+ * CALLED FROM:
+ * framebuffer hook
+ */
+static void rivafb_copyarea(struct fb_info *info, struct fb_copyarea *regi=
on)
+{
+	struct riva_par *par =3D (struct riva_par *) info->par;
+
+	RIVA_FIFO_FREE(par->riva, Blt, 3);
+	par->riva.Blt->TopLeftSrc  =3D (region->sy << 16) | region->sx;
+	par->riva.Blt->TopLeftDst  =3D (region->dy << 16) | region->dx;
+	par->riva.Blt->WidthHeight =3D (region->height << 16) | region->width;
+	wait_for_idle(par);
+}
+
+static u8 byte_rev[256] =3D {
+	0x00, 0x80, 0x40, 0xc0, 0x20, 0xa0, 0x60, 0xe0,=20
+	0x10, 0x90, 0x50, 0xd0, 0x30, 0xb0, 0x70, 0xf0,
+	0x08, 0x88, 0x48, 0xc8, 0x28, 0xa8, 0x68, 0xe8,=20
+	0x18, 0x98, 0x58, 0xd8, 0x38, 0xb8, 0x78, 0xf8,=20
+	0x04, 0x84, 0x44, 0xc4, 0x24, 0xa4, 0x64, 0xe4,=20
+	0x14, 0x94, 0x54, 0xd4, 0x34, 0xb4, 0x74, 0xf4,=20
+	0x0c, 0x8c, 0x4c, 0xcc, 0x2c, 0xac, 0x6c, 0xec,=20
+	0x1c, 0x9c, 0x5c, 0xdc, 0x3c, 0xbc, 0x7c, 0xfc,=20
+	0x02, 0x82, 0x42, 0xc2, 0x22, 0xa2, 0x62, 0xe2,=20
+	0x12, 0x92, 0x52, 0xd2, 0x32, 0xb2, 0x72, 0xf2,=20
+	0x0a, 0x8a, 0x4a, 0xca, 0x2a, 0xaa, 0x6a, 0xea,=20
+	0x1a, 0x9a, 0x5a, 0xda, 0x3a, 0xba, 0x7a, 0xfa,=20
+	0x06, 0x86, 0x46, 0xc6, 0x26, 0xa6, 0x66, 0xe6,=20
+	0x16, 0x96, 0x56, 0xd6, 0x36, 0xb6, 0x76, 0xf6,=20
+	0x0e, 0x8e, 0x4e, 0xce, 0x2e, 0xae, 0x6e, 0xee,=20
+	0x1e, 0x9e, 0x5e, 0xde, 0x3e, 0xbe, 0x7e, 0xfe,=20
+	0x01, 0x81, 0x41, 0xc1, 0x21, 0xa1, 0x61, 0xe1,=20
+	0x11, 0x91, 0x51, 0xd1, 0x31, 0xb1, 0x71, 0xf1,=20
+	0x09, 0x89, 0x49, 0xc9, 0x29, 0xa9, 0x69, 0xe9,=20
+	0x19, 0x99, 0x59, 0xd9, 0x39, 0xb9, 0x79, 0xf9,=20
+	0x05, 0x85, 0x45, 0xc5, 0x25, 0xa5, 0x65, 0xe5,=20
+	0x15, 0x95, 0x55, 0xd5, 0x35, 0xb5, 0x75, 0xf5,=20
+	0x0d, 0x8d, 0x4d, 0xcd, 0x2d, 0xad, 0x6d, 0xed,=20
+	0x1d, 0x9d, 0x5d, 0xdd, 0x3d, 0xbd, 0x7d, 0xfd,=20
+	0x03, 0x83, 0x43, 0xc3, 0x23, 0xa3, 0x63, 0xe3,
+	0x13, 0x93, 0x53, 0xd3, 0x33, 0xb3, 0x73, 0xf3,=20
+	0x0b, 0x8b, 0x4b, 0xcb, 0x2b, 0xab, 0x6b, 0xeb,
+	0x1b, 0x9b, 0x5b, 0xdb, 0x3b, 0xbb, 0x7b, 0xfb,=20
+	0x07, 0x87, 0x47, 0xc7, 0x27, 0xa7, 0x67, 0xe7,
+	0x17, 0x97, 0x57, 0xd7, 0x37, 0xb7, 0x77, 0xf7,=20
+	0x0f, 0x8f, 0x4f, 0xcf, 0x2f, 0xaf, 0x6f, 0xef,
+	0x1f, 0x9f, 0x5f, 0xdf, 0x3f, 0xbf, 0x7f, 0xff,
+};
+
+/**
+ * rivafb_imageblit: hardware accelerated color expand function
+ * @info: pointer to fb_info structure
+ * @image: pointer to fb_image structure
+ *
+ * DESCRIPTION:
+ * If the source is a monochrome bitmap, the function fills up a a region
+ * of framebuffer memory with pixels whose color is determined by the bit
+ * setting of the bitmap, 1 - foreground, 0 - background.
+ *
+ * If the source is not a monochrome bitmap, color expansion is not done.
+ * In this case, it is channeled to a software function.
+ *
+ * CALLED FROM:
+ * framebuffer hook
+ */
+static void rivafb_imageblit(struct fb_info *info, struct fb_image *image)
+{
+	struct riva_par *par =3D (struct riva_par *) info->par;
+	u8 *cdat =3D image->data, *dat;
+	int w, h, dx, dy;
+	volatile u32 *d;
+	u32 fgx =3D 0, bgx =3D 0, size, width, mod;
+	int i, j;
+
+	if (image->depth !=3D 1) {
+		wait_for_idle(par);
+		cfb_imageblit(info, image);
+		return;
+	}
+
+	w =3D image->width;
+	h =3D image->height;
+	dx =3D image->dx;
+	dy =3D image->dy;
+
+	width =3D (w + 7)/8;
+
+	size =3D width * h;
+	dat =3D cdat;
+	for (i =3D 0; i < size; i++) {
+		*dat =3D byte_rev[*dat];
+		dat++;
+	}
+
+	switch (info->var.bits_per_pixel) {
+	case 8:
+		fgx =3D image->fg_color | ~((1 << 8) - 1);
+		bgx =3D image->bg_color | ~((1 << 8) - 1);
+	=09
+		break;
+	case 16:
+		/* set alpha bit */
+		if (info->var.green.length =3D=3D 5) {
+			fgx =3D 1 << 15;
+			bgx =3D fgx;
+		}
+        /* Fall through... */
+	case 32:
+		fgx |=3D par->riva_palette[image->fg_color];
+		bgx |=3D par->riva_palette[image->bg_color];
+		break;
+	}
+
+        RIVA_FIFO_FREE(par->riva, Bitmap, 7);
+        par->riva.Bitmap->ClipE.TopLeft     =3D (dy << 16) | (dx & 0xFFFF)=
;
+        par->riva.Bitmap->ClipE.BottomRight =3D (((dy + h) << 16) |=20
+					       ((dx + w) & 0xffff));
+        par->riva.Bitmap->Color0E           =3D bgx;
+        par->riva.Bitmap->Color1E           =3D fgx;
+        par->riva.Bitmap->WidthHeightInE    =3D (h << 16) | ((w + 31) & ~3=
1);
+        par->riva.Bitmap->WidthHeightOutE   =3D (h << 16) | ((w + 31) & ~3=
1);
+        par->riva.Bitmap->PointE            =3D (dy << 16) | (dx & 0xFFFF)=
;
+=09
+	d =3D &par->riva.Bitmap->MonochromeData01E;
+
+	mod =3D width % 4;
+
+	if (width >=3D 4) {
+		while (h--) {
+			size =3D width / 4;
+			while (size >=3D 16) {
+				RIVA_FIFO_FREE(par->riva, Bitmap, 16);
+				for (i =3D 0; i < 16; i++)
+					d[i] =3D *((u32 *)cdat)++;
+				size -=3D 16;
+			}
+		=09
+			if (size) {
+				RIVA_FIFO_FREE(par->riva, Bitmap, size);
+				for (i =3D 0; i < size; i++)
+					d[i] =3D *((u32 *) cdat)++;
+			}
+		=09
+			if (mod) {
+				u32 tmp;
+				RIVA_FIFO_FREE(par->riva, Bitmap, 1);
+				for (i =3D 0; i < mod; i++)=20
+					((u8 *)&tmp)[i] =3D *cdat++;
+				d[i] =3D tmp;
+			}
+		}
+	}
+	else {
+		u32 k, tmp;
+
+		for (i =3D h; i > 0; i-=3D16) {
+			if (i >=3D 16)
+				size =3D 16;
+			else
+				size =3D i;
+			RIVA_FIFO_FREE(par->riva, Bitmap, size);
+			for (j =3D 0; j < size; j++) {
+				for (k =3D 0; k < width; k++)
+					((u8 *)&tmp)[k] =3D *cdat++;
+				d[j] =3D tmp;
+			}
+		}
+	}
+}
+
+/**
+ * rivafb_cursor - hardware cursor function
+ * @info: pointer to info structure
+ * @cursor: pointer to fbcursor structure
+ *
+ * DESCRIPTION:
+ * A cursor function that supports displaying a cursor image via hardware.
+ * Within the kernel, copy and invert rops are supported.  If exported
+ * to user space, only the copy rop will be supported.
+ *
+ * CALLED FROM
+ * framebuffer hook
+ */
+static int rivafb_cursor(struct fb_info *info, struct fb_cursor *cursor)=20
+{
+	static u8 data[MAX_CURS*MAX_CURS/8], mask[MAX_CURS*MAX_CURS/8];
+	struct riva_par *par =3D (struct riva_par *) info->par;
+	int i, j, d_idx =3D 0, s_idx =3D 0;
+	u16 flags =3D cursor->set, fg, bg;
+
+	/*
+	 * Can't do invert if one of the operands (dest) is missing,
+	 * ie, only opaque cursor supported.  This should be
+	 * standard for GUI apps.
+	 */
+	if (cursor->dest =3D=3D NULL && cursor->rop =3D=3D ROP_XOR)
+		return 1;
+
+	if (par->cursor_reset) {
+		flags =3D FB_CUR_SETALL;
+		par->cursor_reset =3D 0;
+	}
+
+	par->riva.ShowHideCursor(&par->riva, 0);
+
+	if (flags & FB_CUR_SETPOS) {
+		u32 xx, yy, temp;
+=09
+		yy =3D cursor->image.dy - info->var.yoffset;
+		xx =3D cursor->image.dx - info->var.xoffset;
+		temp =3D xx & 0xFFFF;
+		temp |=3D yy << 16;
+
+		*(par->riva.CURSORPOS) =3D temp;
+	}
+
+	if (flags & FB_CUR_SETSIZE) {
+		memset(data, 0, MAX_CURS * MAX_CURS/8);
+		memset(mask, 0, MAX_CURS * MAX_CURS/8);
+		memset_io(par->riva.CURSOR, 0, MAX_CURS * MAX_CURS * 2);
+	}
+
+	if (flags & (FB_CUR_SETSHAPE | FB_CUR_SETCMAP | FB_CUR_SETDEST)) {=20
+		int bg_idx =3D cursor->image.bg_color;
+		int fg_idx =3D cursor->image.fg_color;
+
+		switch (cursor->rop) {
+		case ROP_XOR:
+			for (i =3D 0; i < cursor->image.height; i++) {
+				for (j =3D 0; j < (cursor->image.width + 7)/8;
+				     j++) {
+					d_idx =3D i * MAX_CURS/8  + j;
+					data[d_idx] =3D  byte_rev[((u8 *)cursor->image.data)[s_idx] ^
+							       ((u8 *)cursor->dest)[s_idx]];
+					mask[d_idx] =3D byte_rev[((u8 *)cursor->mask)[s_idx]];
+					s_idx++;
+				}
+			}
+			break;
+		case ROP_COPY:
+		default:
+			for (i =3D 0; i < cursor->image.height; i++) {
+				for (j =3D 0; j < (cursor->image.width + 7)/8; j++) {
+					d_idx =3D i * MAX_CURS/8 + j;
+					data[d_idx] =3D byte_rev[((u8 *)cursor->image.data)[s_idx]];
+					mask[d_idx] =3D byte_rev[((u8 *)cursor->mask)[s_idx]];
+					s_idx++;
+				}
+			}
+			break;
+		}
+		=09
+		bg =3D ((par->cmap[bg_idx].red & 0xf8) << 7) |=20
+			((par->cmap[bg_idx].green & 0xf8) << 2) |
+			((par->cmap[bg_idx].blue & 0xf8) >> 3) | 1 << 15;
+	=09
+		fg =3D ((par->cmap[fg_idx].red & 0xf8) << 7) |=20
+			((par->cmap[fg_idx].green & 0xf8) << 2) |
+			((par->cmap[fg_idx].blue & 0xf8) >> 3) | 1 << 15;
+
+		par->riva.LockUnlock(&par->riva, 0);
+		rivafb_load_cursor_image(data, mask, par, cursor->image.width,=20
+					 cursor->image.height, bg, fg);
+	}
+=09
+	if (cursor->enable)
+		par->riva.ShowHideCursor(&par->riva, 1);
+
+	return 0;
+}
+
+static int rivafb_sync(struct fb_info *info)
+{
+	struct riva_par *par =3D (struct riva_par *) info->par;
+
 	wait_for_idle(par);
+=09
+	return 0;
 }
=20
 /* -----------------------------------------------------------------------=
-- *
@@ -992,23 +1142,18 @@
=20
 	assert(var !=3D NULL);
=20
-	switch (var->bits_per_pixel) {
-	case 8:
-		rc =3D 256;	/* pseudocolor... 256 entries HW palette */
-		break;
-	case 15:
-		rc =3D 15;	/* fix for 15 bpp depths on Riva 128 based cards */
+	switch (var->green.length) {
+	case 5:
+		rc =3D 32;	/* fix for 15 bpp depths on Riva 128 based cards */
 		break;
-	case 16:
-		rc =3D 16;	/* directcolor... 16 entries SW palette */
-		break;		/* Mystique: truecolor, 16 entries SW palette, HW palette hardwi=
red into 1:1 mapping */
-	case 32:
-		rc =3D 16;	/* directcolor... 16 entries SW palette */
+	case 6:
+		rc =3D 64;	/* directcolor... 16 entries SW palette */
 		break;		/* Mystique: truecolor, 16 entries SW palette, HW palette hardwi=
red into 1:1 mapping */
 	default:
-		/* should not occur */
+		rc =3D 256;	/* pseudocolor... 256 entries HW palette */
 		break;
 	}
+
 	return rc;
 }
=20
@@ -1021,8 +1166,13 @@
 static int rivafb_check_var(struct fb_var_screeninfo *var,
                             struct fb_info *info)
 {
+	struct riva_par *par =3D (struct riva_par *) info->par;
 	int nom, den;		/* translating from pixels->bytes */
 =09
+	if (par->riva.Architecture =3D=3D NV_ARCH_03 &&
+	    var->bits_per_pixel =3D=3D 16)
+		var->bits_per_pixel =3D 15;
+
 	switch (var->bits_per_pixel) {
 	case 1 ... 8:
 		var->bits_per_pixel =3D 8;
@@ -1098,7 +1248,6 @@
 	    var->green.msb_right =3D
 	    var->blue.msb_right =3D
 	    var->transp.offset =3D var->transp.length =3D var->transp.msb_right =
=3D 0;
-	var->accel_flags |=3D FB_ACCELF_TEXT;
 	return 0;
 }
=20
@@ -1108,7 +1257,21 @@
=20
 	//rivafb_create_cursor(info, fontwidth(dsp), fontheight(dsp));
 	riva_load_video_mode(info);
-	riva_setup_accel(par);
+	if (info->var.accel_flags) {
+		riva_setup_accel(par);
+		info->fbops->fb_fillrect  =3D rivafb_fillrect;
+		info->fbops->fb_copyarea  =3D rivafb_copyarea;
+		info->fbops->fb_imageblit =3D rivafb_imageblit;
+		info->fbops->fb_cursor    =3D rivafb_cursor;
+		info->fbops->fb_sync      =3D rivafb_sync;
+	}
+	else {
+		info->fbops->fb_fillrect  =3D cfb_fillrect;
+		info->fbops->fb_copyarea  =3D cfb_copyarea;
+		info->fbops->fb_imageblit =3D cfb_imageblit;
+		info->fbops->fb_cursor    =3D soft_cursor;
+		info->fbops->fb_sync      =3D NULL;
+	}
=20
 	info->fix.line_length =3D (info->var.xres_virtual * (info->var.bits_per_p=
ixel >> 3));
 	info->fix.visual =3D (info->var.bits_per_pixel =3D=3D 8) ?=20
@@ -1129,7 +1292,7 @@
  *
  * This call looks only at xoffset, yoffset and the FB_VMODE_YWRAP flag
  */
-static int rivafb_pan_display(struct fb_var_screeninfo *var, int con,
+static int rivafb_pan_display(struct fb_var_screeninfo *var,
 			      struct fb_info *info)
 {
 	struct riva_par *par =3D (struct riva_par *) info->par;
@@ -1152,9 +1315,7 @@
=20
 	base =3D var->yoffset * info->fix.line_length + var->xoffset;
=20
-	if (con =3D=3D info->currcon) {
-		par->riva.SetStartAddress(&par->riva, base);
-	}
+	par->riva.SetStartAddress(&par->riva, base);
=20
 	info->var.xoffset =3D var->xoffset;
 	info->var.yoffset =3D var->yoffset;
@@ -1163,6 +1324,15 @@
 		info->var.vmode |=3D FB_VMODE_YWRAP;
 	else
 		info->var.vmode &=3D ~FB_VMODE_YWRAP;
+
+	/*
+	 * HACK: The hardware cursor occasionally disappears during fast scrollin=
g.
+	 *       We just reset the cursor each time we change the start address.
+	 *       This also has a beneficial side effect of restoring the cursor=20
+	 *       image when switching from X.
+	 */
+	par->cursor_reset =3D 1;
+
 	DPRINTK("EXIT, returning 0\n");
 	return 0;
 }
@@ -1231,6 +1401,7 @@
 {
 	struct riva_par *par =3D (struct riva_par *) info->par;
 	RIVA_HW_INST *chip =3D &par->riva;
+	int i;
=20
 	if (regno >=3D riva_get_cmap_len(&info->var))
 		return -EINVAL;
@@ -1241,34 +1412,74 @@
 		    (red * 77 + green * 151 + blue * 28) >> 8;
 	}
=20
-	switch (info->var.bits_per_pixel) {
-	case 8:
-		/* "transparent" stuff is completely ignored. */
-		riva_wclut(chip, regno, red >> 8, green >> 8, blue >> 8);
-		break;
-	case 16:
-		assert(regno < 16);
-		if (info->var.green.length =3D=3D 5) {
-			/* 0rrrrrgg gggbbbbb */
-			((u16 *)(info->pseudo_palette))[regno] =3D
-			    ((red & 0xf800) >> 1) |
-			    ((green & 0xf800) >> 6) | ((blue & 0xf800) >> 11);
-		} else {
-			/* rrrrrggg gggbbbbb */
-			((u16 *)(info->pseudo_palette))[regno] =3D
-			    ((red & 0xf800) >> 0) |
-			    ((green & 0xf800) >> 5) | ((blue & 0xf800) >> 11);
+	if (!regno) {
+		for (i =3D 0; i < 256; i++) {
+			par->cmap[i].red =3D 0;
+			par->cmap[i].green =3D 0;
+			par->cmap[i].blue =3D 0;
+		}
+	}
+	par->cmap[regno].red   =3D (u8) red;
+	par->cmap[regno].green =3D (u8) green;
+	par->cmap[regno].blue  =3D (u8) blue;
+=09
+	if (info->var.green.length =3D=3D 5) {
+		 /* RGB555: all components have 32 entries, 8 indices apart */
+		for (i =3D 0; i < 8; i++)
+			riva_wclut(chip, (regno*8)+i, (u8) red, (u8) green, (u8) blue);
+	}
+	else if (info->var.green.length =3D=3D 6) {
+		/*=20
+		 * RGB 565: red and blue have 32 entries, 8 indices apart, while
+		 *          green has 64 entries, 4 indices apart
+		 */
+		if (regno < 32) {
+			for (i =3D 0; i < 8; i++) {
+				riva_wclut(chip, (regno*8)+i, (u8) red,=20
+					   par->cmap[regno*2].green,
+					   (u8) blue);
+			}
+		}
+		for (i =3D 0; i < 4; i++) {
+			riva_wclut(chip, (regno*4)+i, par->cmap[regno/2].red,
+				   (u8) green, par->cmap[regno/2].blue);
+	=09
+		}
+	}
+	else {
+		riva_wclut(chip, regno, (u8) red, (u8) green, (u8) blue);
+	}
+
+	if (regno < 16) {
+		switch (info->var.bits_per_pixel) {
+		case 16:
+			if (info->var.green.length =3D=3D 5) {
+				/* 0rrrrrgg gggbbbbb */
+				((u32 *)(info->pseudo_palette))[regno] =3D
+					(regno << 10) | (regno << 5) | regno;
+				par->riva_palette[regno] =3D=20
+					((red & 0xf800) >> 1) |
+					((green & 0xf800) >> 6) | ((blue & 0xf800) >> 11);
+
+			} else {
+				/* rrrrrggg gggbbbbb */
+				((u32 *)(info->pseudo_palette))[regno] =3D
+					(regno << 11) | (regno << 6) | regno;
+				par->riva_palette[regno] =3D ((red & 0xf800) >> 0) |
+					((green & 0xf800) >> 5) | ((blue & 0xf800) >> 11);
+			}
+			break;
+		case 32:
+			((u32 *)(info->pseudo_palette))[regno] =3D
+				(regno << 16) | (regno << 8) | regno;
+			par->riva_palette[regno] =3D
+				((red & 0xff00) << 8) |
+				((green & 0xff00)) | ((blue & 0xff00) >> 8);
+			break;
+		default:
+			/* do nothing */
+			break;
 		}
-		break;
-	case 32:
-		assert(regno < 16);
-		((u32 *)(info->pseudo_palette))[regno] =3D
-		    ((red & 0xff00) << 8) |
-		    ((green & 0xff00)) | ((blue & 0xff00) >> 8);
-		break;
-	default:
-		/* do nothing */
-		break;
 	}
 	return 0;
 }
@@ -1281,25 +1492,23 @@
=20
 /* kernel interface */
 static struct fb_ops riva_fb_ops =3D {
-	owner:		THIS_MODULE,
-	fb_set_var:	gen_set_var,
-	fb_get_cmap:	gen_get_cmap,
-	fb_set_cmap:	gen_set_cmap,
-	fb_check_var:	rivafb_check_var,
-	fb_set_par:	rivafb_set_par,
-	fb_setcolreg:	rivafb_setcolreg,
-	fb_pan_display:	rivafb_pan_display,
-	fb_blank:	rivafb_blank,
-	fb_fillrect:	cfb_fillrect,
-	fb_copyarea:	cfb_copyarea,
-	fb_imageblit:	cfb_imageblit,
+	.owner =3D	THIS_MODULE,
+	.fb_check_var =3D	rivafb_check_var,
+	.fb_set_par =3D	rivafb_set_par,
+	.fb_setcolreg =3D	rivafb_setcolreg,
+	.fb_pan_display=3Drivafb_pan_display,
+	.fb_blank =3D	rivafb_blank,
+	.fb_fillrect =3D	rivafb_fillrect,
+	.fb_copyarea =3D	rivafb_copyarea,
+	.fb_imageblit =3D	rivafb_imageblit,
+	.fb_cursor =3D    rivafb_cursor,
+	.fb_sync =3D      rivafb_sync,
 };
=20
 static int __devinit riva_set_fbinfo(struct fb_info *info)
 {
 	unsigned int cmap_len;
=20
-	strcpy(info->modename, rivafb_fix.id);
 	info->node =3D NODEV;
 	info->flags =3D FBINFO_FLAG_DEFAULT;
 	info->fbops =3D &riva_fb_ops;
@@ -1309,12 +1518,7 @@
 	/* FIXME: set monspecs to what??? */
 	info->display_fg =3D NULL;
 	info->pseudo_palette =3D pseudo_palette;
-	strncpy(info->fontname, fontname, sizeof(info->fontname));
-	info->fontname[sizeof(info->fontname) - 1] =3D 0;
=20
-	info->changevar =3D NULL;
-	info->switch_con =3D gen_switch;
-	info->updatevar =3D gen_update_var;
 	cmap_len =3D riva_get_cmap_len(&info->var);
 	fb_alloc_cmap(&info->cmap, cmap_len, 0);
 #ifndef MODULE
@@ -1341,8 +1545,7 @@
 	assert(pd !=3D NULL);
 	assert(rci !=3D NULL);
=20
-	info =3D kmalloc(sizeof(struct fb_info) + sizeof(struct display),
-			 GFP_KERNEL);
+	info =3D kmalloc(sizeof(struct fb_info), GFP_KERNEL);
 	if (!info)
 		goto err_out;
=20
@@ -1350,7 +1553,7 @@
 	if (!default_par)=20
 		goto err_out_kfree;
=20
-	memset(info, 0, sizeof(struct fb_info) + sizeof(struct display));
+	memset(info, 0, sizeof(struct fb_info));
 	memset(default_par, 0, sizeof(struct riva_par));
=20
 	strcat(rivafb_fix.id, rci->name);
@@ -1449,13 +1652,10 @@
 	CRTCout(default_par, 0x11, 0xFF);/* vgaHWunlock() + riva unlock(0x7F) */
 	default_par->riva.LockUnlock(&default_par->riva, 0);
 =09
-	info->disp =3D (struct display *)(info + 1);
 	info->par =3D default_par;
=20
 	riva_save_state(default_par, &default_par->initial_state);
=20
-	if (!nohwcursor) default_par->cursor =3D rivafb_init_cursor(default_par);
-
 	if (riva_set_fbinfo(info) < 0) {
 		printk(KERN_ERR PFX "error setting initial video mode\n");
 		goto err_out_cursor;
@@ -1482,7 +1682,6 @@
 err_out_load_state:
 	riva_load_state(default_par, &default_par->initial_state);
 err_out_cursor:
-	rivafb_exit_cursor(default_par);
 /* err_out_iounmap_fb: */
 	iounmap(info->screen_base);
 err_out_iounmap_ctrl:
@@ -1509,8 +1708,6 @@
=20
 	unregister_framebuffer(info);
=20
-	rivafb_exit_cursor(par);
-
 #ifdef CONFIG_MTRR
 	if (par->mtrr.vram_valid)
 		mtrr_del(par->mtrr.vram, info->fix.smem_start,
@@ -1545,27 +1742,12 @@
 	while ((this_opt =3D strsep(&options, ",")) !=3D NULL) {
 		if (!*this_opt)
 			continue;
-		if (!strncmp(this_opt, "font:", 5)) {
-			char *p;
-			int i;
-
-			p =3D this_opt + 5;
-			for (i =3D 0; i < sizeof(fontname) - 1; i++)
-				if (!*p || *p =3D=3D ' ' || *p =3D=3D ',')
-					break;
-			memcpy(fontname, this_opt + 5, i);
-			fontname[i] =3D 0;
-
-		} else if (!strncmp(this_opt, "noblink", 7)) {
-			noblink =3D 1;
-		} else if (!strncmp(this_opt, "nomove", 6)) {
+		if (!strncmp(this_opt, "nomove", 6)) {
 			nomove =3D 1;
 #ifdef CONFIG_MTRR
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr =3D 1;
 #endif
-		} else if (!strncmp(this_opt, "nohwcursor", 10)) {
-			nohwcursor =3D 1;
 		} else
 			mode_option =3D this_opt;
 	}
@@ -1616,10 +1798,6 @@
 MODULE_PARM_DESC(noaccel, "Disables hardware acceleration (0 or 1=3Ddisabl=
ed) (default=3D0)");
 MODULE_PARM(nomove, "i");
 MODULE_PARM_DESC(nomove, "Enables YSCROLL_NOMOVE (0 or 1=3Denabled) (defau=
lt=3D0)");
-MODULE_PARM(nohwcursor, "i");
-MODULE_PARM_DESC(nohwcursor, "Disables hardware cursor (0 or 1=3Ddisabled)=
 (default=3D0)");
-MODULE_PARM(noblink, "i");
-MODULE_PARM_DESC(noblink, "Disables hardware cursor blinking (0 or 1=3Ddis=
abled) (default=3D0)");
 #ifdef CONFIG_MTRR
 MODULE_PARM(nomtrr, "i");
 MODULE_PARM_DESC(nomtrr, "Disables MTRR support (0 or 1=3Ddisabled) (defau=
lt=3D0)");
diff -Naur linux-2.5.49/drivers/video/riva/rivafb.h linux/drivers/video/riv=
a/rivafb.h
--- linux-2.5.49/drivers/video/riva/rivafb.h	2002-11-28 06:35:53.000000000 =
+0000
+++ linux/drivers/video/riva/rivafb.h	2002-11-28 06:35:13.000000000 +0000
@@ -3,7 +3,6 @@
=20
 #include <linux/config.h>
 #include <linux/fb.h>
-#include <video/fbcon.h>
 #include "riva_hw.h"
=20
 /* GGI compatibility macros */
@@ -23,6 +22,10 @@
 	RIVA_HW_STATE ext;
 };
=20
+typedef struct {
+	unsigned char red, green, blue, transp;
+} riva_cfb8_cmap_t;
+
 struct riva_par {
 	RIVA_HW_INST riva;	/* interface to riva_hw.c */
=20
@@ -32,7 +35,10 @@
 	struct riva_regs initial_state;	/* initial startup video mode */
 	struct riva_regs current_state;
=20
-	struct riva_cursor *cursor;
+	riva_cfb8_cmap_t cmap[256];	/* VGA DAC palette cache */
+	u32 riva_palette[16];
+	u32 cursor_data[32 * 32/4];
+	int cursor_reset;
 #ifdef CONFIG_MTRR
 	struct { int vram; int vram_valid; } mtrr;
 #endif

--=-28WjBxVVsQM/XIowjnob--

