Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbTERIeV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 04:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbTERIeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 04:34:20 -0400
Received: from [193.10.185.236] ([193.10.185.236]:7178 "HELO
	smtp.dormnet.his.se") by vger.kernel.org with SMTP id S261222AbTERIeM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 04:34:12 -0400
Date: Sun, 18 May 2003 10:44:19 +0200
From: Andreas Henriksson <andreas@fjortis.info>
To: jsimmons@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: About the fbdev optimize patch and i810fb
Message-ID: <20030518084419.GA590@foo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
X-gpg-key: http://fjortis.info/andreas_henriksson.gpg
X-gpg-fingerprint: C51F 9B43 4390 95BB A22E  16F2 00EF 6094 449E 0434
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: multipart/mixed; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi James!

I recently posted about the console getting stuck when I use 2.5.69-mm6
=2E.. I'm just letting you know that I've now tried 2.5.69-bk12 with and
without your optimize patch. It works without it but the console get
stuck while booting when I use the patch... (not on the same place as
-mm6 gets stuck though).

davej was amazed I even got the i810fb working at all.... so maybee
that is works without the patch might be a coincidense ... Though the
i810fb has worked for me on all the 2.5's I've tried.. (starting from
around 2.5.50).

(I attached the patch if you wonder which one I'm talking about...=20
slightly modified to apply on -bk12 ..)

Regards,
Andreas Henriksson

--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: attachment; filename="fbopt.diff"
Content-Transfer-Encoding: quoted-printable

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	Mon May 12 13:39:09 2003
+++ b/drivers/video/console/fbcon.c	Mon May 12 13:39:09 2003
@@ -304,97 +304,6 @@
 }
=20
 /*
- * drawing helpers
- */
-static void putcs_unaligned(struct vc_data *vc, struct fb_info *info,
-			    struct fb_image *image, int count,
-			    const unsigned short *s)
-{
-	unsigned short charmask =3D vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int width =3D (vc->vc_font.width + 7) >> 3;
-	unsigned int cellsize =3D vc->vc_font.height * width;
-	unsigned int maxcnt =3D info->pixmap.size/cellsize;
-	unsigned int shift_low =3D 0, mod =3D vc->vc_font.width % 8;
-	unsigned int shift_high =3D 8, size, pitch, cnt, k;
-	unsigned int buf_align =3D info->pixmap.buf_align - 1;
-	unsigned int scan_align =3D info->pixmap.scan_align - 1;
-	unsigned int idx =3D vc->vc_font.width >> 3;
-	u8 mask, *src, *dst, *dst0;
-
-	while (count) {
-		if (count > maxcnt)
-			cnt =3D k =3D maxcnt;
-		else
-			cnt =3D k =3D count;
-
-		image->width =3D vc->vc_font.width * cnt;
-		pitch =3D ((image->width + 7) >> 3) + scan_align;
-		pitch &=3D ~scan_align;
-		size =3D pitch * vc->vc_font.height + buf_align;
-		size &=3D ~buf_align;
-		dst0 =3D info->pixmap.addr + fb_get_buffer_offset(info, size);
-		image->data =3D dst0;
-		while (k--) {
-			src =3D vc->vc_font.data + (scr_readw(s++) & charmask)*
-			cellsize;
-			dst =3D dst0;
-			mask =3D (u8) (0xfff << shift_high);
-			move_buf_unaligned(info, dst, src, pitch, image->height,
-					mask, shift_high, shift_low, mod, idx);
-			shift_low +=3D mod;
-			dst0 +=3D (shift_low >=3D 8) ? width : width - 1;
-			shift_low &=3D 7;
-			shift_high =3D 8 - shift_low;
-		}
-		info->fbops->fb_imageblit(info, image);
-		image->dx +=3D cnt * vc->vc_font.width;
-		count -=3D cnt;
-		atomic_dec(&info->pixmap.count);
-		smp_mb__after_atomic_dec();
-	}
-}
-
-static void putcs_aligned(struct vc_data *vc, struct fb_info *info,
-			  struct fb_image *image, int count,
-			  const unsigned short *s)
-{
-	unsigned short charmask =3D vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int width =3D vc->vc_font.width >> 3;
-	unsigned int cellsize =3D vc->vc_font.height * width;
-	unsigned int maxcnt =3D info->pixmap.size/cellsize;
-	unsigned int scan_align =3D info->pixmap.scan_align - 1;
-	unsigned int buf_align =3D info->pixmap.buf_align - 1;
-	unsigned int pitch, cnt, size, k;
-	u8 *src, *dst, *dst0;
-
-	while (count) {
-		if (count > maxcnt)
-			cnt =3D k =3D maxcnt;
-		else
-			cnt =3D k =3D count;
-	=09
-		pitch =3D width * cnt + scan_align;
-		pitch &=3D ~scan_align;
-		size =3D pitch * vc->vc_font.height + buf_align;
-		size &=3D ~buf_align;
-		image->width =3D vc->vc_font.width * cnt;
-		dst0 =3D info->pixmap.addr + fb_get_buffer_offset(info, size);
-		image->data =3D dst0;
-		while (k--) {
-			src =3D vc->vc_font.data + (scr_readw(s++)&charmask)*cellsize;
-			dst =3D dst0;
-			move_buf_aligned(info, dst, src, pitch, width, image->height);
-			dst0 +=3D width;
-		}
-		info->fbops->fb_imageblit(info, image);
-		image->dx +=3D cnt * vc->vc_font.width;
-		count -=3D cnt;
-		atomic_dec(&info->pixmap.count);
-		smp_mb__after_atomic_dec();
-	}
-}
-
-/*
  * Accelerated handlers.
  */
 void accel_bmove(struct vc_data *vc, struct fb_info *info, int sy,=20
@@ -428,48 +337,21 @@
 	info->fbops->fb_fillrect(info, &region);
 }=09
=20
-static void accel_putc(struct vc_data *vc, struct fb_info *info,
-                      int c, int ypos, int xpos)
+void accel_putcs(struct vc_data *vc, struct fb_info *info,
+			const unsigned short *s, int count, int yy, int xx)
 {
 	unsigned short charmask =3D vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	unsigned int width =3D (vc->vc_font.width + 7) >> 3;
+	unsigned int cellsize =3D vc->vc_font.height * width;
+	unsigned int maxcnt =3D info->pixmap.size/cellsize;
 	unsigned int scan_align =3D info->pixmap.scan_align - 1;
 	unsigned int buf_align =3D info->pixmap.buf_align - 1;
+	unsigned int shift_low =3D 0, mod =3D vc->vc_font.width % 8;
+	unsigned int shift_high =3D 8, pitch, cnt, size, k;
 	int bgshift =3D (vc->vc_hi_font_mask) ? 13 : 12;
 	int fgshift =3D (vc->vc_hi_font_mask) ? 9 : 8;
-	unsigned int size, pitch;
-	struct fb_image image;
-	u8 *src, *dst;
-
-	image.dx =3D xpos * vc->vc_font.width;
-	image.dy =3D ypos * vc->vc_font.height;
-	image.width =3D vc->vc_font.width;
-	image.height =3D vc->vc_font.height;
-	image.fg_color =3D attr_fgcol(fgshift, c);
-	image.bg_color =3D attr_bgcol(bgshift, c);
-	image.depth =3D 1;
-
-	pitch =3D width + scan_align;
-	pitch &=3D ~scan_align;
-	size =3D pitch * vc->vc_font.height;
-	size +=3D buf_align;
-	size &=3D ~buf_align;
-	dst =3D info->pixmap.addr + fb_get_buffer_offset(info, size);
-	image.data =3D dst;
-	src =3D vc->vc_font.data + (c & charmask) * vc->vc_font.height * width;
-
-	move_buf_aligned(info, dst, src, pitch, width, image.height);
-
-	info->fbops->fb_imageblit(info, &image);
-	atomic_dec(&info->pixmap.count);
-	smp_mb__after_atomic_dec();
-}
-
-void accel_putcs(struct vc_data *vc, struct fb_info *info,
-			const unsigned short *s, int count, int yy, int xx)
-{
-	int bgshift =3D (vc->vc_hi_font_mask) ? 13 : 12;
-	int fgshift =3D (vc->vc_hi_font_mask) ? 9 : 8;
+	unsigned int idx =3D vc->vc_font.width >> 3;
+	u8 *src, *dst, *dst0, mask;
 	struct fb_image image;
 	u16 c =3D scr_readw(s);
=20
@@ -480,10 +362,44 @@
 	image.height =3D vc->vc_font.height;
 	image.depth =3D 1;
=20
-	if (!(vc->vc_font.width & 7))
-               putcs_aligned(vc, info, &image, count, s);
-        else
-               putcs_unaligned(vc, info, &image, count, s);
+	while (count) {
+		if (count > maxcnt)
+			cnt =3D k =3D maxcnt;
+		else
+			cnt =3D k =3D count;
+
+		image.width =3D vc->vc_font.width * cnt;
+		pitch =3D ((image.width + 7) >> 3) + scan_align;
+		pitch &=3D ~scan_align;
+		size =3D pitch * vc->vc_font.height + buf_align;
+		size &=3D ~buf_align;
+		dst0 =3D info->pixmap.addr + fb_get_buffer_offset(info, size);
+		image.data =3D dst0;
+		while (k--) {
+			src =3D vc->vc_font.data + (scr_readw(s++) & charmask)*cellsize;
+			dst =3D dst0;
+	=09
+			if (mod) {
+				mask =3D (u8) (0xfff << shift_high);
+				move_buf_unaligned(info, dst, src, pitch,
+						   image.height, mask, shift_high,=20
+						   shift_low, mod, idx);
+				shift_low +=3D mod;
+				dst0 +=3D (shift_low >=3D 8) ? width : width - 1;
+				shift_low &=3D 7;
+				shift_high =3D 8 - shift_low;
+			} else {
+				move_buf_aligned(info, dst, src, pitch, idx,=20
+						 image.height);
+				dst0 +=3D width;
+			}=09
+		}
+		info->fbops->fb_imageblit(info, &image);
+		image.dx +=3D cnt * vc->vc_font.width;
+		count -=3D cnt;
+		atomic_dec(&info->pixmap.count);
+		smp_mb__after_atomic_dec();
+	}
 }
=20
 void accel_clear_margins(struct vc_data *vc, struct fb_info *info,
@@ -724,15 +640,13 @@
 static void fbcon_set_display(struct vc_data *vc, int init, int logo)
 {
 	struct fb_info *info =3D registered_fb[(int) con2fb_map[vc->vc_num]];
+	int nr_rows, nr_cols, old_rows, old_cols, i, charcnt =3D 256;
 	struct display *p =3D &fb_display[vc->vc_num];
-	int nr_rows, nr_cols;
-	int old_rows, old_cols;
 	unsigned short *save =3D NULL, *r, *q;
-	int i, charcnt =3D 256;
 	struct font_desc *font;
=20
 	if (vc->vc_num !=3D fg_console || (info->flags & FBINFO_FLAG_MODULE) ||
-	    info->fix.type =3D=3D FB_TYPE_TEXT)
+	    (info->fix.type =3D=3D FB_TYPE_TEXT))
 		logo =3D 0;
=20
 	info->var.xoffset =3D info->var.yoffset =3D p->yscroll =3D 0;	/* reset wr=
ap/pan */
@@ -956,19 +870,50 @@
 		accel_clear(vc, info, real_y(p, sy), sx, height, width);
 }
=20
-
 static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
 {
 	struct fb_info *info =3D registered_fb[(int) con2fb_map[vc->vc_num]];
+	unsigned short charmask =3D vc->vc_hi_font_mask ? 0x1ff : 0xff;
+	unsigned int scan_align =3D info->pixmap.scan_align - 1;
+	unsigned int buf_align =3D info->pixmap.buf_align - 1;
+	unsigned int width =3D (vc->vc_font.width + 7) >> 3;
+	int bgshift =3D (vc->vc_hi_font_mask) ? 13 : 12;
+	int fgshift =3D (vc->vc_hi_font_mask) ? 9 : 8;
 	struct display *p =3D &fb_display[vc->vc_num];
-
+	unsigned int size, pitch;
+	struct fb_image image;
+	u8 *src, *dst;
+=09
 	if (!info->fbops->fb_blank && console_blanked)
 		return;
=20
 	if (vt_cons[vc->vc_num]->vc_mode !=3D KD_TEXT)
 		return;
=20
-	accel_putc(vc, info, c, real_y(p, ypos), xpos);
+	image.dx =3D xpos * vc->vc_font.width;
+	image.dy =3D real_y(p, ypos) * vc->vc_font.height;
+	image.width =3D vc->vc_font.width;
+	image.height =3D vc->vc_font.height;
+	image.fg_color =3D attr_fgcol(fgshift, c);
+	image.bg_color =3D attr_bgcol(bgshift, c);
+	image.depth =3D 1;
+
+	src =3D vc->vc_font.data + (c & charmask) * vc->vc_font.height * width;
+
+	pitch =3D width + scan_align;
+	pitch &=3D ~scan_align;
+	size =3D pitch * vc->vc_font.height;
+	size +=3D buf_align;
+	size &=3D ~buf_align;
+
+	dst =3D info->pixmap.addr + fb_get_buffer_offset(info, size);
+	image.data =3D dst;
+=09
+	move_buf_aligned(info, dst, src, pitch, width, image.height);
+
+	info->fbops->fb_imageblit(info, &image);
+	atomic_dec(&info->pixmap.count);
+	smp_mb__after_atomic_dec();
 }
=20
 static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	Mon May 12 13:39:09 2003
+++ b/include/linux/fb.h	Mon May 12 13:39:09 2003
@@ -2,7 +2,6 @@
 #define _LINUX_FB_H
=20
 #include <linux/tty.h>
-#include <linux/workqueue.h>
 #include <asm/types.h>
 #include <asm/io.h>
=20
@@ -326,29 +325,31 @@
 	struct fb_image	image;	/* Cursor image */
 };
=20
+#ifdef __KERNEL__
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/workqueue.h>
+#include <linux/devfs_fs_kernel.h>
+
 #define FB_PIXMAP_DEFAULT 1     /* used internally by fbcon */
 #define FB_PIXMAP_SYSTEM  2     /* memory is in system RAM  */
 #define FB_PIXMAP_IO      4     /* memory is iomapped       */
 #define FB_PIXMAP_SYNC    256   /* set if GPU can DMA       */
=20
 struct fb_pixmap {
-        __u8  *addr;                      /* pointer to memory            =
 */ =20
-	__u32 size;                       /* size of buffer in bytes       */
-	__u32 offset;                     /* current offset to buffer      */
-	__u32 buf_align;                  /* byte alignment of each bitmap */
-	__u32 scan_align;                 /* alignment per scanline        */
-	__u32 flags;                      /* see FB_PIXMAP_*               */
-					  /* access methods                */
+	u8  *addr;		/* pointer to memory 			*/
+	u32 size;		/* size of buffer in bytes 		*/
+	u32 offset;		/* current offset to buffer 		*/
+	u32 buf_align;		/* byte alignment of each bitmap 	*/
+	u32 scan_align;		/* alignment per scanline 		*/
+	u32 flags;		/* see FB_PIXMAP_* 			*/
+	spinlock_t lock;	/* spinlock 				*/
+	atomic_t count;
+	/* access methods */
 	void (*outbuf)(u8 *dst, u8 *addr, unsigned int size);=20
 	u8   (*inbuf) (u8 *addr);
-	spinlock_t lock;                  /* spinlock                      */
-	atomic_t count;
 };
-#ifdef __KERNEL__
-
-#include <linux/fs.h>
-#include <linux/init.h>
-#include <linux/devfs_fs_kernel.h>
=20
 struct fb_info;
 struct vm_area_struct;
@@ -397,24 +398,23 @@
 };
=20
 struct fb_info {
-   int node;
-   int flags;
-   int open;                            /* Has this been open already ? */
+	int node;
+	int flags;
 #define FBINFO_FLAG_MODULE	1	/* Low-level driver is a module */
-   struct fb_var_screeninfo var;        /* Current var */
-   struct fb_fix_screeninfo fix;        /* Current fix */
-   struct fb_monspecs monspecs;         /* Current Monitor specs */
-   struct fb_cursor cursor;		/* Current cursor */=09
-   struct work_struct queue;		/* Framebuffer event queue */
-   struct fb_pixmap pixmap;	        /* Current pixmap */
-   struct fb_cmap cmap;                 /* Current cmap */
-   struct fb_ops *fbops;
-   char *screen_base;                   /* Virtual address */
-   struct vc_data *display_fg;		/* Console visible on this display */
-   int currcon;				/* Current VC. */=09
-   void *pseudo_palette;                /* Fake palette of 16 colors */=20
-   /* From here on everything is device dependent */
-   void *par;=09
+	struct fb_var_screeninfo var;	/* Current var */
+	struct fb_fix_screeninfo fix;	/* Current fix */
+	struct fb_monspecs monspecs;	/* Current Monitor specs */
+	struct fb_cursor cursor;	/* Current cursor */=09
+	struct work_struct queue;	/* Framebuffer event queue */
+	struct fb_pixmap pixmap;	/* Current pixmap */
+	struct fb_cmap cmap;		/* Current cmap */
+	struct fb_ops *fbops;
+	char *screen_base;		/* Virtual address */
+	struct vc_data *display_fg;	/* Console visible on this display */
+	void *pseudo_palette;		/* Fake palette of 16 colors */=20
+	int currcon;			/* Current VC. */=09
+	/* From here on everything is device dependent */
+	void *par;=09
 };
=20
 #ifdef MODULE


--TB36FDmn/VVEgNH/--

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+x0fjAO9glESeBDQRAuf/AKCn5x+CFPsrahHJTKGPCglG9GLA8QCgkZ/Y
K7awZwRBzPW5Npe58GUwVWE=
=gKH+
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
