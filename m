Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265169AbSK1E0x>; Wed, 27 Nov 2002 23:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbSK1E0x>; Wed, 27 Nov 2002 23:26:53 -0500
Received: from [203.167.79.9] ([203.167.79.9]:39684 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S265169AbSK1E0f>; Wed, 27 Nov 2002 23:26:35 -0500
Subject: [PATCH] FBDev: fix for fbcon Oops
From: Antonino Daplas <adaplas@pol.net>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-wEFP2w/Sle0UpRo1BkcO"
Message-Id: <1038468191.1092.48.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Nov 2002 12:24:46 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wEFP2w/Sle0UpRo1BkcO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Attached is a patch against 2.5.49 + James Simmons' latest fbdev.diff.

This fixes fbcon oopsing at load time which is due to the fb_cursor's
palette index entries being improperly updated.

A new kind of 'emacs glitch'  appeared, though. This can be described as
a block of text that is incompletely  copied, ie when "tabbing" a line
of text.  This is present with all hardware I tested, soft accel and
hardware accel, which indicates a problem in the higher layers (probably
fbcon). vgacon works okay.  

Other changes:

1. optimization of fbcon_accel_putcs()
2. enabling logo displays at all packed pixel formats (as long as
fb_imageblit is supported)
3. Various fbcon_accel_cursor() fixes which would have resulted in
wrong cursor colors or an invisible cursor.



Tony



--=-wEFP2w/Sle0UpRo1BkcO
Content-Disposition: attachment; filename=fbcon.c.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=fbcon.c.diff; charset=UTF-8

diff -Naur linux-2.5.49/drivers/video/Makefile linux/drivers/video/Makefile
--- linux-2.5.49/drivers/video/Makefile	2002-11-28 06:29:45.000000000 +0000
+++ linux/drivers/video/Makefile	2002-11-28 06:30:35.000000000 +0000
@@ -69,7 +69,7 @@
 obj-$(CONFIG_FB_TX3912)           +=3D tx3912fb.o cfbfillrect.o cfbcopyare=
a.o cfbimgblt.o
=20
 obj-$(CONFIG_FB_MATROX)		  +=3D matrox/
-obj-$(CONFIG_FB_RIVA)		  +=3D riva/
+obj-$(CONFIG_FB_RIVA)		  +=3D riva/ cfbfillrect.o cfbimgblt.o cfbcopyarea.=
o
 obj-$(CONFIG_FB_SIS)		  +=3D sis/
 obj-$(CONFIG_FB_ATY)		  +=3D aty/ cfbimgblt.o
=20
diff -Naur linux-2.5.49/drivers/video/console/fbcon.c linux/drivers/video/c=
onsole/fbcon.c
--- linux-2.5.49/drivers/video/console/fbcon.c	2002-11-28 06:30:09.00000000=
0 +0000
+++ linux/drivers/video/console/fbcon.c	2002-11-28 06:33:39.000000000 +0000
@@ -153,6 +153,8 @@
 static int cursor_on;
 static int cursor_blink_rate;
=20
+static u8 fbcon_pixmap[8192];
+
 static inline void cursor_undrawn(void)
 {
 	vbl_cursor_cnt =3D 0;
@@ -353,7 +355,8 @@
 {
 	struct fb_info *info =3D p->fb_info;
 	unsigned short charmask =3D p->charmask;
-	unsigned int width =3D ((vc->vc_font.width + 7) >> 3);
+	unsigned int width =3D ((vc->vc_font.width + 7)/8);
+	unsigned int cellsize =3D vc->vc_font.height * width;
 	struct fb_image image;
 	u16 c =3D scr_readw(s);
=20
@@ -361,16 +364,37 @@
 	image.bg_color =3D attr_bgcol(p, c);
 	image.dx =3D xx * vc->vc_font.width;
 	image.dy =3D yy * vc->vc_font.height;
-	image.width =3D vc->vc_font.width;
 	image.height =3D vc->vc_font.height;
 	image.depth =3D 1;
=20
-	while (count--) {
-		image.data =3D p->fontdata +=20
-			(scr_readw(s++) & charmask) * vc->vc_font.height * width;
+	if (!(vc->vc_font.width & 7) && fbcon_pixmap !=3D NULL) {
+		unsigned int pitch =3D width * count, i, j;
+		char *src, *dst, *dst0;
+
+		dst0 =3D fbcon_pixmap;
+		image.width =3D vc->vc_font.width * count;
+		image.data =3D fbcon_pixmap;
+		while (count--) {
+			src =3D p->fontdata + (scr_readw(s++) & charmask) * cellsize;
+			dst =3D dst0;
+			for (i =3D image.height; i--; ) {
+				for (j =3D 0; j < width; j++)=20
+					dst[j] =3D *src++;
+				dst +=3D pitch;
+			}
+			dst0 +=3D width;
+		}
 		info->fbops->fb_imageblit(info, &image);
-		image.dx +=3D vc->vc_font.width;
-	}=09
+	}
+	else {
+		image.width =3D vc->vc_font.width;
+		while (count--) {
+			image.data =3D p->fontdata +=20
+				(scr_readw(s++) & charmask) * vc->vc_font.height * width;
+			info->fbops->fb_imageblit(info, &image);
+			image.dx +=3D vc->vc_font.width;
+		}=09
+	}
 }
=20
 void fbcon_accel_clear_margins(struct vc_data *vc, struct display *p,
@@ -425,7 +449,7 @@
=20
 	if ((vc->vc_cursor_type & 0x0f) !=3D shape) {
 		shape =3D vc->vc_cursor_type & 0x0f;
-		cursor.set |=3D FB_CUR_SETSIZE;
+		cursor.set |=3D FB_CUR_SETSHAPE;
 	}
=20
 	c =3D scr_readw((u16 *) vc->vc_pos);
@@ -435,10 +459,7 @@
 		fgcolor =3D (int) attr_fgcol(p, c);
 		bgcolor =3D (int) attr_bgcol(p, c);
 		cursor.set |=3D FB_CUR_SETCMAP;
-		cursor.image.bg_color =3D bgcolor;
-		cursor.image.fg_color =3D fgcolor;
 	}
-
 	c &=3D p->charmask;
 	font =3D p->fontdata + (c * ((width + 7) / 8) * height);
 	if (font !=3D dest) {
@@ -453,7 +474,7 @@
=20
 	if (cursor.set & FB_CUR_SETSIZE) {
 		memset(image, 0xff, 64);
-		cursor.set |=3D FB_CUR_SETSIZE;
+		cursor.set |=3D FB_CUR_SETSHAPE;
 	}	=09
=20
 	if (cursor.set & FB_CUR_SETSHAPE) {
@@ -497,6 +518,8 @@
 	cursor.image.dy =3D yy * height;
 	cursor.image.depth =3D 1;
 	cursor.image.data =3D image;
+	cursor.image.bg_color =3D bgcolor;
+	cursor.image.fg_color =3D fgcolor;
 	cursor.mask =3D mask;
 	cursor.dest =3D dest;
 	cursor.rop =3D ROP_XOR;
@@ -2487,20 +2510,16 @@
 	struct display *p =3D &fb_display[fg_console];	/* draw to vt in foregroun=
d */
 	struct fb_info *info =3D p->fb_info;
 	struct vc_data *vc =3D info->display_fg;
-#ifdef CONFIG_FBCON_ACCEL
 	struct fb_image image;
 	u32 *palette =3D NULL, *saved_palette =3D NULL;
-#endif
 	int depth =3D info->var.bits_per_pixel;
-	int line =3D info->fix.line_length;
 	unsigned char *fb =3D info->screen_base;
-	unsigned char *logo;
-	unsigned char *dst, *src;
-	int i, j, n, x1, y1, x;
+	unsigned char *logo, *logo_new =3D NULL;
+	int i, j, n, x;
 	int logo_depth, done =3D 0;
=20
 	/* Return if the frame buffer is not mapped */
-	if (!fb)
+	if (!fb || !info->fbops->fb_imageblit)
 		return 0;
=20
 	/*
@@ -2543,65 +2562,114 @@
 		logo_depth =3D 1;
 	}
=20
-#if defined(CONFIG_FBCON_ACCEL)
-	if (info->fix.visual =3D=3D FB_VISUAL_TRUECOLOR) {
-		unsigned char mask[9] =3D
-		    { 0, 0x80, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc, 0xfe, 0xff };
+    {
+	    int needs_truepalette =3D 0;
+	    int needs_directpalette =3D 0;
+	    int needs_logo =3D 0;
+
+	    switch (info->fix.visual) {
+	    case FB_VISUAL_TRUECOLOR:
+		    needs_truepalette =3D 1;
+		    break;
+	    case FB_VISUAL_DIRECTCOLOR:
+		    if (depth >=3D 24)=20
+			    needs_directpalette =3D 1;
+		    /* 16 colors */
+		    else if (depth >=3D 16)
+			    needs_logo =3D 4;
+		    /* 2 colors */
+		    else
+			    needs_logo =3D 1;
+		    break;
+	    case FB_VISUAL_PSEUDOCOLOR:
+	    default:
+		    /* 16 colors */
+		    if (depth >=3D 4 && depth < 8)
+			    needs_logo =3D 4;
+		    /* 4 colors */
+		    else if (depth < 4)
+			    needs_logo =3D 1;
+		    break;
+	    }		   =20
+	if (needs_truepalette || needs_directpalette) {
+		unsigned char mask[9] =3D { 0,0x80,0xc0,0xe0,0xf0,0xf8,0xfc,0xfe,0xff };
 		unsigned char redmask, greenmask, bluemask;
 		int redshift, greenshift, blueshift;
=20
-		/* Bug: Doesn't obey msb_right ... (who needs that?) */
-		redmask =3D
-		    mask[info->var.red.length <
-			 8 ? info->var.red.length : 8];
-		greenmask =3D
-		    mask[info->var.green.length <
-			 8 ? info->var.green.length : 8];
-		bluemask =3D
-		    mask[info->var.blue.length <
-			 8 ? info->var.blue.length : 8];
-		redshift =3D
-		    info->var.red.offset - (8 - info->var.red.length);
-		greenshift =3D
-		    info->var.green.offset - (8 - info->var.green.length);
-		blueshift =3D
-		    info->var.blue.offset - (8 - info->var.blue.length);
-
 		/*
-		 * We have to create a temporary palette since console palette is only
+	 	 * We have to create a temporary palette since console palette is only
 		 * 16 colors long.
-		 */
+	 	 */
 		palette =3D kmalloc(256 * 4, GFP_KERNEL);
 		if (palette =3D=3D NULL)
-			return (LOGO_H + vc->vc_font.height - 1)/vc->vc_font.height;
+			return 1;
+
+		if (needs_truepalette) {
+			/* Bug: Doesn't obey msb_right ... (who needs that?) */
+			redmask   =3D mask[info->var.red.length   < 8 ? info->var.red.length   =
: 8];
+			greenmask =3D mask[info->var.green.length < 8 ? info->var.green.length =
: 8];
+			bluemask  =3D mask[info->var.blue.length  < 8 ? info->var.blue.length  =
: 8];
+			redshift   =3D info->var.red.offset   - (8 - info->var.red.length);
+			greenshift =3D info->var.green.offset - (8 - info->var.green.length);
+			blueshift  =3D info->var.blue.offset  - (8 - info->var.blue.length);
+
=20
-		for (i =3D 0; i < LINUX_LOGO_COLORS; i++) {
-			palette[i + 32] =3D
-			    (safe_shift
-			     ((linux_logo_red[i] & redmask),
-			      redshift) | safe_shift((linux_logo_green[i] &
-						      greenmask),
-						     greenshift) |
-			     safe_shift((linux_logo_blue[i] & bluemask),
-					blueshift));
+			for ( i =3D 0; i < LINUX_LOGO_COLORS; i++) {
+				palette[i+32] =3D (safe_shift((linux_logo_red[i]   & redmask), redshif=
t) |
+						 safe_shift((linux_logo_green[i] & greenmask), greenshift) |
+						 safe_shift((linux_logo_blue[i]  & bluemask), blueshift));
+			}
+		}
+		else {
+			redshift =3D info->var.red.offset;
+			greenshift =3D info->var.green.offset;
+			blueshift =3D info->var.blue.offset;
+
+			for (i =3D 32; i < LINUX_LOGO_COLORS; i++)=20
+				palette[i] =3D i << redshift | i << greenshift | i << blueshift;
 		}
 		saved_palette =3D info->pseudo_palette;
 		info->pseudo_palette =3D palette;
 	}
+	if (needs_logo) {
+		logo_new =3D kmalloc(LOGO_W * LOGO_H, GFP_KERNEL);
+		if (logo_new =3D=3D NULL)
+			return 1;
+
+		logo =3D logo_new;
+		switch (needs_logo) {
+		case 4:
+		{
+			for (i =3D 0; i < (LOGO_W * LOGO_H)/2; i++) {
+				logo_new[i*2] =3D linux_logo16[i] >> 4;
+				logo_new[(i*2)+1] =3D linux_logo16[i] & 0xf;
+			}
+		}
+		break;
+		case 1:
+		default:
+		{
+			int j;
+			for (i =3D 0; i < (LOGO_W * LOGO_H)/8; i++)=20
+				for (j =3D 0; j < 8; j++)=20
+					logo_new[i*2] =3D linux_logo_bw[i] &  (7 - j);
+		}
+		break;
+		}=20
+	}
 	image.width =3D LOGO_W;
 	image.height =3D LOGO_H;
 	image.depth =3D depth;
 	image.data =3D logo;
 	image.dy =3D 0;
-#endif
+    }
=20
 	for (x =3D 0; x < num_online_cpus() * (LOGO_W + 8) &&
 	     x < info->var.xres - (LOGO_W + 8); x +=3D (LOGO_W + 8)) {
-#if defined (CONFIG_FBCON_ACCEL)
 		image.dx =3D x;
 		info->fbops->fb_imageblit(info, &image);
 		done =3D 1;
-#endif
+#if 0 /* Turn off, should be removed soon enough... */
 #if defined(CONFIG_FBCON_AFB) || defined(CONFIG_FBCON_ILBM) || \
     defined(CONFIG_FBCON_IPLAN2P2) || defined(CONFIG_FBCON_IPLAN2P4) || \
     defined(CONFIG_FBCON_IPLAN2P8)
@@ -2733,14 +2801,14 @@
 			done =3D 1;
 		}
 #endif
+#endif /* Turn off for now... */
 	}
-
-#if defined (CONFIG_FBCON_ACCEL)
 	if (palette !=3D NULL)
 		kfree(palette);
 	if (saved_palette !=3D NULL)
 		info->pseudo_palette =3D saved_palette;
-#endif
+	if (logo_new !=3D NULL)
+		kfree(logo_new);
 	/* Modes not yet supported: packed pixels with depth !=3D 8 (does such a
 	 * thing exist in reality?) */
=20

--=-wEFP2w/Sle0UpRo1BkcO--


