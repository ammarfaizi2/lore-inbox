Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbSK1I2h>; Thu, 28 Nov 2002 03:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265266AbSK1I2h>; Thu, 28 Nov 2002 03:28:37 -0500
Received: from dhcp31182033.columbus.rr.com ([24.31.182.33]:16133 "EHLO
	nineveh.rivenstone.net") by vger.kernel.org with ESMTP
	id <S265255AbSK1I2c>; Thu, 28 Nov 2002 03:28:32 -0500
From: "Joseph Fannin" <jhf@rivenstone.net>
Date: Thu, 28 Nov 2002 03:35:52 -0500
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: Fbdev 2.5.49 BK fixes.
Message-ID: <20021128083552.GB2703@zion.rivenstone.net>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
References: <3DE50A1D.856A8706@aitel.hist.no> <Pine.LNX.4.44.0211272254440.30951-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211272254440.30951-100000@phoenix.infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: multipart/mixed; boundary="5I6of5zJg18YgZEa"
Content-Disposition: inline


--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

    Whoops, I forgot to attach the patch.

--=20
Joseph Fannin
jhf@rivenstone.net

"For future reference - don't anybody else try to send patches as vi
scripts, please. Yes, it's manly, but let's face it, so is bungee-jumping
with the cord tied to your testicles." -- Linus Torvalds

--5I6of5zJg18YgZEa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vga16.patch"
Content-Transfer-Encoding: quoted-printable

diff -Nru a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
--- a/drivers/video/vga16fb.c	Thu Nov 28 03:03:45 2002
+++ b/drivers/video/vga16fb.c	Thu Nov 28 03:03:45 2002
@@ -22,6 +22,7 @@
 #include <linux/selection.h>
 #include <linux/ioport.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
=20
 #include <asm/io.h>
=20
@@ -81,22 +82,33 @@
 /* --------------------------------------------------------------------- */
=20
 static struct fb_var_screeninfo vga16fb_defined =3D {
-	640,480,640,480,/* W,H, W, H (virtual) load xres,xres_virtual*/
-	0,0,		/* virtual -> visible no offset */
-	4,		/* depth -> load bits_per_pixel */
-	0,		/* greyscale ? */
-	{0,0,0},	/* R */
-	{0,0,0},	/* G */
-	{0,0,0},	/* B */
-	{0,0,0},	/* transparency */
-	0,		/* standard pixel format */
-	FB_ACTIVATE_NOW,
-	-1,-1,
-	0,
-	39721, 48, 16, 39, 8,
-	96, 2, 0,	/* No sync info */
-	FB_VMODE_NONINTERLACED,
-	{0,0,0,0,0,0}
+        .xres           =3D 640,
+        .yres           =3D 480,
+        .xres_virtual   =3D 640,
+        .yres_virtual   =3D 480,
+        .bits_per_pixel =3D 4,
+        .activate       =3D FB_ACTIVATE_NOW,
+        .height         =3D -1,
+        .width          =3D -1,
+        .pixclock       =3D 39721,
+        .left_margin    =3D 48,
+        .right_margin   =3D 16,
+        .upper_margin   =3D 39,
+        .lower_margin   =3D 8,
+        .hsync_len      =3D 96,
+        .vsync_len      =3D 2,
+        .vmode          =3D FB_VMODE_NONINTERLACED,
+};
+
+static struct fb_fix_screeninfo vga16fb_fix __initdata =3D {
+        .id             =3D "VGA16 VGA",
+        .smem_start     =3D VGA_FB_PHYS,
+        .smem_len       =3D VGA_FB_PHYS_LEN,
+        .type           =3D FB_TYPE_VGA_PLANES,
+        .visual         =3D FB_VISUAL_PSEUDOCOLOR,
+        .xpanstep       =3D 8,
+        .ypanstep       =3D 1,
+        .line_length    =3D 640 / 8,
 };
=20
 static struct display disp;
@@ -121,69 +133,22 @@
 #endif
 }
=20
-static int vga16fb_update_var(int con, struct fb_info *info)
-{
-	vga16fb_pan_var(info, &fb_display[con].var);
-	return 0;
-}
-
-static int vga16fb_get_fix(struct fb_fix_screeninfo *fix, int con,
-			   struct fb_info *info)
-{
-	struct display *p;
-
-	if (con < 0)
-		p =3D &disp;
-	else
-		p =3D fb_display + con;
-
-	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id,"VGA16 VGA");
-
-	fix->smem_start =3D VGA_FB_PHYS;
-	fix->smem_len =3D VGA_FB_PHYS_LEN;
-	fix->type =3D FB_TYPE_VGA_PLANES;
-	fix->visual =3D FB_VISUAL_PSEUDOCOLOR;
-	fix->xpanstep  =3D 8;
-	fix->ypanstep  =3D 1;
-	fix->ywrapstep =3D 0;
-	fix->line_length =3D p->var.xres_virtual / 8;
-	return 0;
-}
-
-static int vga16fb_get_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info)
-{
-	if(con=3D=3D-1)
-		memcpy(var, &vga16fb_defined, sizeof(struct fb_var_screeninfo));
-	else
-		*var=3Dfb_display[con].var;
-	return 0;
-}
-
 static void vga16fb_set_disp(int con, struct vga16fb_info *info)
 {
-	struct fb_fix_screeninfo fix;
-	struct display *display;
-
-	if (con < 0)
-		display =3D &disp;
-	else
-		display =3D fb_display + con;
+        struct display *display =3D (con < 0) ? info->fb_info.disp : (fb_d=
isplay + con);
=20
-=09
-	vga16fb_get_fix(&fix, con, &info->fb_info);
-
-	display->visual =3D fix.visual;
-	display->type =3D fix.type;
-	display->type_aux =3D fix.type_aux;
-	display->ypanstep =3D fix.ypanstep;
-	display->ywrapstep =3D fix.ywrapstep;
-	display->line_length =3D fix.line_length;
-	display->next_line =3D fix.line_length;
 	display->can_soft_blank =3D 1;
+        display->dispsw_data =3D NULL;
+        display->var =3D info->fb_info.var;
 	display->inverse =3D 0;
=20
+        /*
+         * If we are setting all the virtual consoles, also set
+         * the defaults used to create new consoles.
+         */
+        if (con < 0 || info->fb_info.var.activate & FB_ACTIVATE_ALL)
+                info->fb_info.disp->var =3D info->fb_info.var;
+
 	if (info->isVGA)
 		display->dispsw =3D &fbcon_vga_planes;
 	else
@@ -500,13 +465,9 @@
 {
 	struct vga16fb_info *info =3D (struct vga16fb_info*)fb;
 	struct vga16fb_par par;
-	struct display *display;
+        struct display *display =3D (con < 0) ? fb->disp : (fb_display + c=
on);
 	int err;
=20
-	if (con < 0)
-		display =3D fb->disp;
-	else
-		display =3D fb_display + con;
 	if ((err =3D vga16fb_decode_var(var, &par, info)) !=3D 0)
 		return err;
 	vga16fb_encode_var(var, &par, info);
@@ -552,25 +513,6 @@
 	outb_p(0x20, 0x3C0); /* unblank screen */
 }
=20
-static int vga16_getcolreg(unsigned regno, unsigned *red, unsigned *green,
-			  unsigned *blue, unsigned *transp,
-			  struct fb_info *fb_info)
-{
-	/*
-	 *  Read a single color register and split it into colors/transparent.
-	 *  Return !=3D 0 for invalid regno.
-	 */
-
-	if (regno >=3D 16)
-		return 1;
-
-	*red   =3D palette[regno].red;
-	*green =3D palette[regno].green;
-	*blue  =3D palette[regno].blue;
-	*transp =3D 0;
-	return 0;
-}
-
 static void vga16_setpalette(int regno, unsigned red, unsigned green, unsi=
gned blue)
 {
 	outb(regno,       dac_reg);
@@ -615,19 +557,6 @@
 	return 0;
 }
=20
-static int vga16fb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-			   struct fb_info *info)
-{
-	if (con =3D=3D info->currcon) /* current console? */
-		return fb_get_cmap(cmap, kspc, vga16_getcolreg, info);
-	else if (fb_display[con].cmap.len) /* non default colormap? */
-		fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
-	else
-		fb_copy_cmap(fb_default_cmap(16),
-		     cmap, kspc ? 0 : 2);
-	return 0;
-}
-
 static int vga16fb_pan_display(struct fb_var_screeninfo *var, int con,
 			       struct fb_info *info)=20
 {
@@ -811,10 +740,8 @@
=20
 static struct fb_ops vga16fb_ops =3D {
 	.owner =3D	THIS_MODULE,
-	.fb_get_fix =3D	vga16fb_get_fix,
-	.fb_get_var =3D	vga16fb_get_var,
 	.fb_set_var =3D	vga16fb_set_var,
-	.fb_get_cmap =3D	vga16fb_get_cmap,
+	.fb_get_cmap =3D	gen_get_cmap,
 	.fb_set_cmap =3D	gen_set_cmap,
 	.fb_setcolreg =3D	vga16fb_setcolreg,
 	.fb_pan_display =3Dvga16fb_pan_display,
@@ -839,27 +766,6 @@
 	return 0;
 }
=20
-static int vga16fb_switch(int con, struct fb_info *fb)
-{
-	struct vga16fb_par par;
-	struct vga16fb_info *info =3D (struct vga16fb_info*)fb;
-
-	/* Do we have to save the colormap? */
-	if (fb_display[fb->currcon].cmap.len)
-		fb_get_cmap(&fb_display[fb->currcon].cmap, 1, vga16_getcolreg,
-			    fb);
-=09
-	fb->currcon =3D con;
-	vga16fb_decode_var(&fb_display[con].var, &par, info);
-	vga16fb_set_par(&par, info);
-	vga16fb_set_disp(con, info);
-
-	/* Install new colormap */
-	do_install_cmap(con, fb);
-/*	vga16fb_update_var(con, fb); */
-	return 1;
-}
-
 int __init vga16fb_init(void)
 {
 	int i,j;
@@ -895,18 +801,21 @@
=20
 	disp.var =3D vga16fb_defined;
=20
-	/* name should not depend on EGA/VGA */
-	strcpy(vga16fb.fb_info.modename, "VGA16 VGA");
+	strcpy(vga16fb.fb_info.modename, vga16fb_fix.id);
 	vga16fb.fb_info.changevar =3D NULL;
 	vga16fb.fb_info.node =3D NODEV;
+        vga16fb.fb_info.var =3D vga16fb_defined;
+        vga16fb.fb_info.fix =3D vga16fb_fix;
 	vga16fb.fb_info.fbops =3D &vga16fb_ops;
 	vga16fb.fb_info.screen_base =3D vga16fb.video_vbase;
 	vga16fb.fb_info.disp=3D&disp;
 	vga16fb.fb_info.currcon =3D -1;
-	vga16fb.fb_info.switch_con=3D&vga16fb_switch;
-	vga16fb.fb_info.updatevar=3D&vga16fb_update_var;
+	vga16fb.fb_info.switch_con=3D&gen_switch;
+	vga16fb.fb_info.updatevar=3D&gen_update_var;
 	vga16fb.fb_info.flags=3DFBINFO_FLAG_DEFAULT;
 	vga16fb_set_disp(-1, &vga16fb);
+
+	fb_alloc_cmap(&vga16fb.fb_info.cmap, 16, 0);
=20
 	if (register_framebuffer(&vga16fb.fb_info)<0) {
 		iounmap(vga16fb.video_vbase);

--5I6of5zJg18YgZEa--

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE95dVoWv4KsgKfSVgRAlq9AJ9xBzl+HZKCVYD1YanbBfjV/A4jAgCfYbwV
+syBtmBdUv9YVCA1KqIHLec=
=b6Tb
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
