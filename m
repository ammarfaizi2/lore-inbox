Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266643AbSLDO3X>; Wed, 4 Dec 2002 09:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266652AbSLDO3X>; Wed, 4 Dec 2002 09:29:23 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:23823 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S266643AbSLDO2p>; Wed, 4 Dec 2002 09:28:45 -0500
Subject: [PATCH 2/3] FBDEV: vga16fb + save/restore state
From: Antonino Daplas <adaplas@pol.net>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-rNFG3FHV0R13t6kS0hmW"
Message-Id: <1039017474.1012.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 22:26:48 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rNFG3FHV0R13t6kS0hmW
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Attached is a patch against linux-2.5.50 + James Simmons' fbdev.diff.

Added support to save and restore VGA text mode.

Tony





--=-rNFG3FHV0R13t6kS0hmW
Content-Disposition: attachment; filename=vga16fb_state.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=vga16fb_state.diff; charset=UTF-8

diff -Naur linux-2.5.50-js/drivers/video/Makefile linux/drivers/video/Makef=
ile
--- linux-2.5.50-js/drivers/video/Makefile	2002-12-04 15:22:38.000000000 +0=
000
+++ linux/drivers/video/Makefile	2002-12-04 15:22:12.000000000 +0000
@@ -50,7 +50,8 @@
 obj-$(CONFIG_FB_S3TRIO)           +=3D S3triofb.o
 obj-$(CONFIG_FB_TGA)              +=3D tgafb.o
 obj-$(CONFIG_FB_VESA)             +=3D vesafb.o cfbfillrect.o cfbcopyarea.=
o cfbimgblt.o=20
-obj-$(CONFIG_FB_VGA16)            +=3D vga16fb.o cfbfillrect.o cfbcopyarea=
.o cfbimgblt.o=20
+obj-$(CONFIG_FB_VGA16)            +=3D vga16fb.o cfbfillrect.o cfbcopyarea=
.o \
+	                             cfbimgblt.o vgastate.o=20
 obj-$(CONFIG_FB_VIRGE)            +=3D virgefb.o
 obj-$(CONFIG_FB_G364)             +=3D g364fb.o cfbfillrect.o cfbcopyarea.=
o cfbimgblt.o
 obj-$(CONFIG_FB_FM2)              +=3D fm2fb.o cfbfillrect.o cfbcopyarea.o=
 cfbimgblt.o
diff -Naur linux-2.5.50-js/drivers/video/vga16fb.c linux/drivers/video/vga1=
6fb.c
--- linux-2.5.50-js/drivers/video/vga16fb.c	2002-12-04 15:22:42.000000000 +=
0000
+++ linux/drivers/video/vga16fb.c	2002-12-04 15:21:26.000000000 +0000
@@ -7,7 +7,8 @@
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
- * archive for more details.  */
+ * archive for more details. =20
+ */
=20
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -69,6 +70,8 @@
 		unsigned char	ModeControl;		/* CRT-Controller:17h */
 		unsigned char	ClockingMode;		/* Seq-Controller:01h */
 	} vga_state;
+	struct fb_vgastate state;
+	atomic_t ref_count;
 	int palette_blanked, vesa_blanked, mode, isVGA;
 	u8 misc, pel_msk, vss, clkdiv;
 	u8 crtc[VGA_CRT_C];
@@ -295,6 +298,34 @@
 			      =20
 #define FAIL(X) return -EINVAL
=20
+static int vga16fb_open(struct fb_info *info, int user)
+{
+	struct vga16fb_par *par =3D (struct vga16fb_par *) info->par;
+	int cnt =3D atomic_read(&par->ref_count);
+
+	if (!cnt) {
+		memset(&par->state, 0, sizeof(struct fb_vgastate));
+		par->state.flags =3D 8;
+		fb_save_vga(&par->state);
+	}
+	atomic_inc(&par->ref_count);
+	return 0;
+}
+
+static int vga16fb_release(struct fb_info *info, int user)
+{
+	struct vga16fb_par *par =3D (struct vga16fb_par *) info->par;
+	int cnt =3D atomic_read(&par->ref_count);
+
+	if (!cnt)
+		return -EINVAL;
+	if (cnt =3D=3D 1)
+		fb_restore_vga(&par->state);
+	atomic_dec(&par->ref_count);
+
+	return 0;
+}
+
 static int vga16fb_check_var(struct fb_var_screeninfo *var,
 			     struct fb_info *info)
 {
@@ -1346,6 +1377,8 @@
=20
 static struct fb_ops vga16fb_ops =3D {
 	.owner		=3D THIS_MODULE,
+	.fb_open        =3D vga16fb_open,
+	.fb_release     =3D vga16fb_release,
 	.fb_check_var	=3D vga16fb_check_var,
 	.fb_set_par	=3D vga16fb_set_par,
 	.fb_setcolreg 	=3D vga16fb_setcolreg,

--=-rNFG3FHV0R13t6kS0hmW--

