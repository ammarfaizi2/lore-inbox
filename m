Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbSK1E0H>; Wed, 27 Nov 2002 23:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbSK1E0H>; Wed, 27 Nov 2002 23:26:07 -0500
Received: from [203.167.79.9] ([203.167.79.9]:37380 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S265168AbSK1E0A>; Wed, 27 Nov 2002 23:26:00 -0500
Subject: [PATCH] FBDev: vga16fb port
From: Antonino Daplas <adaplas@pol.net>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-todKmU3+dFjGCg4ykc38"
Message-Id: <1038468176.1091.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Nov 2002 12:24:12 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-todKmU3+dFjGCg4ykc38
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is a patch against 2.5.49 + James Simmons' latest fbdev.diff.

Added support for logo drawing.
Fixed vga16fb_imageblit() limitation of 8-pixel wide bitmap blitting
only.

Tony



--=-todKmU3+dFjGCg4ykc38
Content-Disposition: attachment; filename=vga16fb.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=vga16fb.diff; charset=UTF-8

diff -Naur linux-2.5.49/drivers/video/vga16fb.c linux/drivers/video/vga16fb=
.c
--- linux-2.5.49/drivers/video/vga16fb.c	2002-11-28 06:44:07.000000000 +000=
0
+++ linux/drivers/video/vga16fb.c	2002-11-28 06:47:06.000000000 +0000
@@ -1062,8 +1062,10 @@
                 }
         } else {
                 line_ofs =3D info->fix.line_length - area->width;
-                dest =3D info->screen_base + area->dx + area->width + (are=
a->dy + height - 1) * info->fix.line_length;
-                src =3D info->screen_base + area->sx + area->width + (area=
->sy + height - 1) * info->fix.line_length;
+                dest =3D info->screen_base + area->dx + area->width +
+			(area->dy + height - 1) * info->fix.line_length;
+                src =3D info->screen_base + area->sx + area->width +
+			(area->sy + height - 1) * info->fix.line_length;
                 while (height--) {
                         for (x =3D 0; x < area->width; x++) {
                                 --src;
@@ -1147,8 +1149,10 @@
 					dst +=3D line_ofs;
 				}
 			} else {
-				dst =3D info->screen_base + (area->dx/8) + width + (area->dy + height =
- 1) * info->fix.line_length;
-				src =3D info->screen_base + (area->sx/8) + width + (area->sy + height =
 - 1) * info->fix.line_length;
+				dst =3D info->screen_base + (area->dx/8) + width +=20
+					(area->dy + height - 1) * info->fix.line_length;
+				src =3D info->screen_base + (area->sx/8) + width +=20
+					(area->sy + height  - 1) * info->fix.line_length;
 				while (height--) {
 					for (x =3D 0; x < width; x++) {
 						dst--;
@@ -1222,65 +1226,123 @@
         setindex(oldindex);
 }
=20
-void vga16fb_imageblit(struct fb_info *info, struct fb_image *image)
+void vga_imageblit_expand(struct fb_info *info, struct fb_image *image)
 {
-	char *where =3D info->screen_base + (image->dx/image->width) + image->dy =
* info->fix.line_length;
+	char *where =3D info->screen_base + (image->dx/8) +=20
+		image->dy * info->fix.line_length;
 	struct vga16fb_par *par =3D (struct vga16fb_par *) info->par;
-	u8 *cdat =3D image->data;
-	int y;
+	u8 *cdat =3D image->data, *dst;
+	int x, y;
=20
 	switch (info->fix.type) {
-		case FB_TYPE_VGA_PLANES:
-			if (info->fix.type_aux =3D=3D FB_AUX_VGA_PLANES_VGA4) {
-				if (par->isVGA) {
-					setmode(2);
-					setop(0);
-					setsr(0xf);
-					setcolor(image->fg_color);
-					selectmask();
+	case FB_TYPE_VGA_PLANES:
+		if (info->fix.type_aux =3D=3D FB_AUX_VGA_PLANES_VGA4) {
+			if (par->isVGA) {
+				setmode(2);
+				setop(0);
+				setsr(0xf);
+				setcolor(image->fg_color);
+				selectmask();
+			=09
+				setmask(0xff);
+				writeb(image->bg_color, where);
+				rmb();
+				readb(where); /* fill latches */
+				setmode(3);
+				wmb();
+				for (y =3D 0; y < image->height; y++) {
+					dst =3D where;
+					for (x =3D image->width/8; x--;)=20
+						writeb(*cdat++, dst++);
+					where +=3D info->fix.line_length;
+				}
+				wmb();
+			} else {
+				setmode(0);
+				setop(0);
+				setsr(0xf);
+				setcolor(image->bg_color);
+				selectmask();
+			=09
+				setmask(0xff);
+				for (y =3D 0; y < image->height; y++) {
+					dst =3D where;
+					for (x=3Dimage->width/8; x--;){
+						rmw(dst);
+						setcolor(image->fg_color);
+						selectmask();
+						if (*cdat) {
+							setmask(*cdat++);
+							rmw(dst++);
+						}
+					}
+					where +=3D info->fix.line_length;
+				}
+			}
+		} else=20
+			vga_8planes_imageblit(info, image);
+		break;
+#ifdef FBCON_HAS_VGA
+	case FB_TYPE_TEXT:
+		break;
+#endif
+	case FB_TYPE_PACKED_PIXELS:
+	default:
+		cfb_imageblit(info, image);
+		break;
+	}
+}
=20
-					setmask(0xff);
-					writeb(image->bg_color, where);
-					rmb();
-					readb(where); /* fill latches */
-					setmode(3);
-					wmb();
-					for (y =3D 0; y < image->height; y++, where +=3D info->fix.line_lengt=
h)
-						writeb(cdat[y], where);
-						wmb();
-				} else {
-					setmode(0);
-					setop(0);
-					setsr(0xf);
-					setcolor(image->bg_color);
-					selectmask();
+void vga_imageblit_color(struct fb_info *info, struct fb_image *image)=20
+{
+	/*
+	 * Draw logo=20
+	 */
+	struct vga16fb_par *par =3D (struct vga16fb_par *) info->par;
+	char *where =3D info->screen_base + image->dy * info->fix.line_length +=20
+		image->dx/8;
+	char *cdat =3D image->data, *dst;
+	int x, y;
=20
-					setmask(0xff);
-					for (y =3D 0; y < image->height; y++, where +=3D info->fix.line_lengt=
h)
-						rmw(where);
+	switch (info->fix.type) {
+	case FB_TYPE_VGA_PLANES:
+		if (info->fix.type_aux =3D=3D FB_AUX_VGA_PLANES_VGA4 &&
+		    par->isVGA) {
+			setsr(0xf);
+			setop(0);
+			setmode(0);
+		=09
+			for (y =3D 0; y < image->height; y++) {
+				for (x =3D 0; x < image->width; x++) {
+					dst =3D where + x/8;
=20
-					where -=3D info->fix.line_length * y;
-					setcolor(image->fg_color);
+					setcolor(*cdat);
 					selectmask();
-					for (y =3D 0; y < image->height; y++, where +=3D info->fix.line_lengt=
h)
-					if (cdat[y]) {
-						setmask(cdat[y]);
-						rmw(where);
-					}
+					setmask(1 << (7 - (x % 8)));
+					fb_readb(dst);
+					fb_writeb(0, dst);
+
+					cdat++;
 				}
-			} else=20
-				vga_8planes_imageblit(info, image);
-			break;
-#ifdef FBCON_HAS_VGA
-		case FB_TYPE_TEXT:
-			break;
-#endif
-		case FB_TYPE_PACKED_PIXELS:
-		default:
-			cfb_imageblit(info, image);
-			break;
+				where +=3D info->fix.line_length;
+			}
+		}
+		break;
+	case FB_TYPE_PACKED_PIXELS:
+		cfb_imageblit(info, image);
+		break;
+	default:
+		break;
 	}
 }
+			=09
+void vga16fb_imageblit(struct fb_info *info, struct fb_image *image)
+{
+	if (image->depth =3D=3D 1)
+		vga_imageblit_expand(info, image);
+	else if (image->depth =3D=3D info->var.bits_per_pixel)
+		vga_imageblit_color(info, image);
+}
=20
 static struct fb_ops vga16fb_ops =3D {
 	.owner		=3D THIS_MODULE,
@@ -1292,6 +1354,7 @@
 	.fb_fillrect	=3D vga16fb_fillrect,
 	.fb_copyarea	=3D vga16fb_copyarea,
 	.fb_imageblit	=3D vga16fb_imageblit,
+	.fb_cursor      =3D soft_cursor,
 };
=20
 int vga16fb_setup(char *options)
@@ -1343,6 +1406,11 @@
 	i =3D (vga16fb_defined.bits_per_pixel =3D=3D 8) ? 256 : 16;
 	fb_alloc_cmap(&vga16fb.cmap, i, 0);
=20
+	if (vga16fb_check_var(&vga16fb.var, &vga16fb))
+		return -EINVAL;
+
+	vga16fb_update_fix(&vga16fb);
+
 	if (register_framebuffer(&vga16fb) < 0) {
 		iounmap(vga16fb.screen_base);
 		return -EINVAL;

--=-todKmU3+dFjGCg4ykc38--

