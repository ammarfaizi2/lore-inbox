Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbTK1CWL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 21:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTK1CWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 21:22:11 -0500
Received: from dialin-212-144-182-198.arcor-ip.net ([212.144.182.198]:384 "EHLO
	dbintra.dmz.lightweight.ods.org") by vger.kernel.org with ESMTP
	id S261879AbTK1CV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 21:21:59 -0500
Date: Fri, 28 Nov 2003 02:36:54 +0100
From: Tonnerre Anklin <thunder@keepsake.ch>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [FBDEV] Console switch/resolution change fix
Message-ID: <20031128013654.GB1635@dbintra.dmz.lightweight.ods.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
X-GPG-KeyID: 0xDEBA90FF
X-GPG-Fingerprint: 6288 DAF3 13F7 276D 77A5  0914 CA04 0D20 DEBA 90FF
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

The VT is  not resized by the framebuffer driver.   However, as we set
the framebuffer resolution  on VT switch based on the  VT size, we end
up  having  always  the same  VT  size.  This  patch  adds a  call  to
vt_resize()  to   the  state  change   manager  and  updates   the  VT
layer.  Thus, if  we  resize the  framebuffer,  the VT  is resized  as
well. This fixes the resolution changeback bug.

It also  fixes a wrong name  in the Makefile and  makes some printk()s
more informative.

This patch relies on the Framebuffer patch by James Simmons.

More on this patch can be found at
<URL:http://keepsake.keepsake.ch/~thunder/noyau/2.6.0-test11-ta1/fbcon_reso=
lution_change.xml>

				Thunder

diff -Nur linux-2.6.0-test11-fbdev/drivers/video/console/fbcon.c linux-2.6.=
0-test11-ta1/drivers/video/console/fbcon.c
--- linux-2.6.0-test11-fbdev/drivers/video/console/fbcon.c	2003-11-27 23:29=
:57.000000000 +0100
+++ linux-2.6.0-test11-ta1/drivers/video/console/fbcon.c	2003-11-27 17:59:0=
1.000000000 +0100
@@ -962,7 +962,7 @@
 		int s_pitch =3D (vc->vc_font.width + 7) >> 3;
 		int size =3D s_pitch * vc->vc_font.height;
 		struct fb_cursor cursor;
-		int cur_height, c, i;
+		int cur_height =3D 0, c, i;
 		u8 *dst;
 	=09
 		memset(&cursor, 0, sizeof(struct fb_cursor));
@@ -1620,7 +1620,8 @@
 	}
 	if (info)
 		info->var.yoffset =3D p->yscroll =3D 0;
-        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
+
+	fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
 	switch (p->scrollmode & __SCROLL_YMASK) {
 	case __SCROLL_YWRAP:
 		scrollback_phys_max =3D p->vrows - vc->vc_rows;
@@ -2260,10 +2261,24 @@
 		case RESOLUTION_CHANGE:	{
 			// Switch resolution size
 			int rows, cols;
-		=09
-			rows =3D info->var.xres / vc->vc_font.height;
-			cols =3D info->var.yres / vc->vc_font.width;
-        		fbcon_resize(vc, cols, rows);
+
+			rows =3D info->var.yres / vc->vc_font.height;
+			cols =3D info->var.xres / vc->vc_font.width;
+			if (info->var.activate & FB_ACTIVATE_ALL) {
+				int i;
+
+				for (i =3D 0; i < MAX_NR_CONSOLES; i++)
+					if (vc_cons_allocated(i)) {
+						vc_resize(i, cols, rows);
+						vc_cons[i].d->vc_rows =3D rows;
+						vc_cons[i].d->vc_cols =3D cols;
+					}
+			} else {
+				vc_resize(fg_console, cols, rows);
+				vc_cons[fg_console].d->vc_rows =3D rows;
+				vc_cons[fg_console].d->vc_cols =3D cols;
+			}
+			fbcon_resize(vc, cols, rows);
 			info->state |=3D flag;
 			}
 			break;
diff -Nur linux-2.6.0-test11-fbdev/drivers/video/Makefile linux-2.6.0-test1=
1-ta1/drivers/video/Makefile
--- linux-2.6.0-test11-fbdev/drivers/video/Makefile	2003-11-27 23:29:57.000=
000000 +0100
+++ linux-2.6.0-test11-ta1/drivers/video/Makefile	2003-11-27 17:59:01.00000=
0000 +0100
@@ -32,7 +32,7 @@
 obj-$(CONFIG_FB_CYBER)            +=3D cyberfb.o
 obj-$(CONFIG_FB_CYBER2000)        +=3D cyber2000fb.o cfbfillrect.o cfbcopy=
area.o cfbimgblt.o
 obj-$(CONFIG_FB_SGIVW)            +=3D sgivwfb.o cfbfillrect.o cfbcopyarea=
=2Eo cfbimgblt.o
-obj-$(CONFIG_FB_3DFX)             +=3D tdfxfb.o cfbimgblit.o
+obj-$(CONFIG_FB_3DFX)             +=3D tdfxfb.o cfbimgblt.o
 obj-$(CONFIG_FB_MAC)              +=3D macfb.o macmodes.o cfbfillrect.o cf=
bcopyarea.o cfbimgblt.o=20
 obj-$(CONFIG_FB_HP300)            +=3D hpfb.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_OF)               +=3D offb.o cfbfillrect.o cfbimgblt.o cf=
bcopyarea.o
diff -Nur linux-2.6.0-test11-fbdev/drivers/video/riva/fbdev.c linux-2.6.0-t=
est11-ta1/drivers/video/riva/fbdev.c
--- linux-2.6.0-test11-fbdev/drivers/video/riva/fbdev.c	2003-11-27 23:29:58=
=2E000000000 +0100
+++ linux-2.6.0-test11-ta1/drivers/video/riva/fbdev.c	2003-11-28 02:35:03.0=
00000000 +0100
@@ -957,13 +957,13 @@
 =09
 	if (var->xres_virtual < var->xres) {
 		printk(KERN_ERR PFX
-		       "virtual X resolution (%d) is smaller than real\n", var->xres_vir=
tual);
+		       "virtual X resolution (%d) is smaller than real (%d)\n", var->xre=
s_virtual, var->xres);
 		return -EINVAL;
 	}
=20
 	if (var->yres_virtual < var->yres) {
 		printk(KERN_ERR PFX
-		       "virtual Y resolution (%d) is smaller than real\n", var->yres_vir=
tual);
+		       "virtual Y resolution (%d) is smaller than real (%d)\n", var->yre=
s_virtual, var->yres);
 		return -EINVAL;
 	}
 	return 0;
@@ -1161,7 +1161,7 @@
=20
 	riva_load_video_mode(info);
 	riva_setup_accel(par);
-=09
+
 	info->fix.line_length =3D (info->var.xres_virtual * (info->var.bits_per_p=
ixel >> 3));
 	info->fix.visual =3D (info->var.bits_per_pixel =3D=3D 8) ?
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/xqa2ygQNIN66kP8RAnTcAJ46mXRHLQ3e/QAqGwz3aOGG/uWwZwCfZw+4
+gKIKCQkZgw6DZw0VyXoaCI=
=xt3h
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
