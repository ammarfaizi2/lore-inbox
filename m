Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263315AbTC0RHN>; Thu, 27 Mar 2003 12:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263311AbTC0RGQ>; Thu, 27 Mar 2003 12:06:16 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:6794 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S263307AbTC0RFl>; Thu, 27 Mar 2003 12:05:41 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Helge Hafting <helgehaf@aitel.hist.no>, Antonino Daplas <adaplas@pol.net>
Subject: Re: [Linux-fbdev-devel] Much better framebuffer fixes.
Date: Thu, 27 Mar 2003 18:16:24 +0100
User-Agent: KMail/1.5
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44.0303270017180.25001-100000@phoenix.infradead.org> <1048735712.1047.10.camel@localhost.localdomain> <3E82C580.1000801@aitel.hist.no>
In-Reply-To: <3E82C580.1000801@aitel.hist.no>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_uHzg+JHyI26cLFK";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200303271816.30636.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_uHzg+JHyI26cLFK
Content-Type: multipart/mixed;
  boundary="Boundary-01=_oHzg+My05grPlcR"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_oHzg+My05grPlcR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Helge Hafting wrote:
> Antonino Daplas wrote:
> > On Thu, 2003-03-27 at 08:18, James Simmons wrote:
> >=20
> >>Okay. Here are more framebuffer fixes. Please try these fixes and let m=
e=20
> >>know how they work out for you.
> >>
> >=20
> >=20
> > This is a resend of the patch I previously sent.  I see that you have
> > made changes to the logo drawing code targeted for monochrome logo
> > drawing to use mono expansion.  You still need a few changes though,
> > image->bg_color and image->fg_color must be initialized correctly when
> > image->depth =3D=3D 1.
>=20
> This applied on top of James Simmons' patch, but didn't compile.
> spin_lock_irqsave was "unknown".

I had that problem, too, so I changed some code to make it compile, remove=
=20
some warnings and even fix a possible memory leak... A patch is attached an=
d=20
applies after applying the patches fom James Simmons and Antonino Daplas.

With these changes my framebuffer works correctly again, I don't even have =
any=20
problem with a misshaped cursor anymore...

Regards
  Thomas Schlichter
--Boundary-01=_oHzg+My05grPlcR
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fbcon.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="fbcon.diff"

diff -ur linux-2.5.66/drivers/video/console/fbcon.c linux-2.5.66-bk2/driver=
s/video/console/fbcon.c
=2D-- linux-2.5.66/drivers/video/console/fbcon.c	Thu Mar 27 17:56:12 2003
+++ linux-2.5.66-bk2/drivers/video/console/fbcon.c	Thu Mar 27 16:06:04 2003
@@ -216,12 +216,14 @@
 	}
 }
=20
+#if defined(CONFIG_ATARI) || defined(CONFIG_MAC) || ( defined(__arm__) && =
defined(IRQ_VSYNCPULSE) )
 static void fb_vbl_handler(int irq, void *dev_id, struct pt_regs *fp)
 {
 	struct fb_info *info =3D dev_id;
=20
 	schedule_work(&info->queue);
 }
+#endif
=20
 static void cursor_timer_handler(unsigned long dev_addr);
=20
@@ -586,7 +588,7 @@
=20
 	font =3D get_default_font(info->var.xres, info->var.yres);=09
=20
=2D	vc =3D (struct vc_data *) kmalloc(sizeof(struct vc_data), GFP_ATOMIC);=
=20
+	vc =3D (struct vc_data *) kmalloc(sizeof(struct vc_data), GFP_KERNEL);=20
=20
 	if (!vc) {
 		if (softback_buf)
@@ -597,6 +599,8 @@
 	/* Allocate private data */
 	info->fbcon_priv =3D kmalloc(sizeof(struct fbcon_private), GFP_KERNEL);
 	if (info->fbcon_priv =3D=3D NULL) {
+		if (softback_buf)
+			kfree((void *) softback_buf);
 		kfree(vc);
 		return NULL;
 	}
diff -ur linux-2.5.66/drivers/video/fbmem.c linux-2.5.66-bk2/drivers/video/=
fbmem.c
=2D-- linux-2.5.66/drivers/video/fbmem.c	Thu Mar 27 17:56:12 2003
+++ linux-2.5.66-bk2/drivers/video/fbmem.c	Thu Mar 27 14:40:04 2003
@@ -471,7 +471,7 @@
 	atomic_inc(&info->pixmap.count);=09
 	smp_mb__after_atomic_inc();
=20
=2D	spin_unlock_irqrestore(&info->pixmap.lock);
+	spin_unlock(&info->pixmap.lock);
 	return offset;
 }
=20
@@ -566,9 +566,8 @@
 			       const struct linux_logo *logo, u8 *dst,
 			       int depth)
 {
=2D	int i, j, shift;
+	int i, j;
 	const u8 *src =3D logo->data;
=2D	u8 d, xor =3D 0;
=20
 	switch (depth) {
 	case 4:
@@ -649,7 +648,7 @@
 	/* What depth we asked for might be different from what we get */
 	if (fb_logo.logo->type =3D=3D LINUX_LOGO_CLUT224)
 		fb_logo.depth =3D 8;
=2D	else if (fb_logo.logo->type =3D LINUX_LOGO_VGA16)
+	else if (fb_logo.logo->type =3D=3D LINUX_LOGO_VGA16)
 		fb_logo.depth =3D 4;
 	else
 		fb_logo.depth =3D 1;	=09

--Boundary-01=_oHzg+My05grPlcR--

--Boundary-03=_uHzg+JHyI26cLFK
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+gzHuYAiN+WRIZzQRAtDIAJ9utHO2L2BdQGJQwDd0BGgJjXU60wCeP7Pf
SQbw4cRhDhN7mWTYEeYFhA0=
=5E66
-----END PGP SIGNATURE-----

--Boundary-03=_uHzg+JHyI26cLFK--

