Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVGQM1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVGQM1w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 08:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVGQM1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 08:27:51 -0400
Received: from ipp23-131.piekary.net ([80.48.23.131]:40874 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S261277AbVGQM1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 08:27:51 -0400
Date: Sun, 17 Jul 2005 14:27:47 +0200
From: Michal Januszewski <spock@gentoo.org>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: Update info->cmap when setting cmap from user-/kernelspace.
Message-ID: <20050717122747.GA25475@spock.one.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
X-PGP-Key: http://dev.gentoo.org/~spock/spock.gpg
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi.

The fb_info struct, as defined in include/linux/fb.h, contains an element
that is supposed to hold the current color map:
  struct fb_cmap cmap;            /* Current cmap */

This cmap is currently never updated when either fb_set_cmap() or
fb_set_user_cmap() are called. As a result, info->cmap contains the
default cmap that was set by a device driver/fbcon and a userspace
application using the FBIOGETCMAP ioctl will not always get the
*currently* used color map.

The patch fixes this by making sure the cmap is copied to info->cmap
after it is set correctly. It moves most of the code that is responsible
for setting the cmap to fb_set_cmap() and out of fb_set_user_cmap() to
avoid code-duplication.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---

diff -Nupr linux-2.6.12-orig/drivers/video/fbcmap.c linux-2.6.12/drivers/vi=
deo/fbcmap.c
--- linux-2.6.12-orig/drivers/video/fbcmap.c	2005-06-17 21:48:29.000000000 =
+0200
+++ linux-2.6.12/drivers/video/fbcmap.c	2005-07-17 13:32:49.000000000 +0200
@@ -212,7 +212,7 @@ int fb_cmap_to_user(struct fb_cmap *from
=20
 int fb_set_cmap(struct fb_cmap *cmap, struct fb_info *info)
 {
-	int i, start;
+	int i, start, rc =3D 0;
 	u16 *red, *green, *blue, *transp;
 	u_int hred, hgreen, hblue, htransp =3D 0xffff;
=20
@@ -225,75 +225,51 @@ int fb_set_cmap(struct fb_cmap *cmap, st
 	if (start < 0 || (!info->fbops->fb_setcolreg &&
 			  !info->fbops->fb_setcmap))
 		return -EINVAL;
-	if (info->fbops->fb_setcmap)
-		return info->fbops->fb_setcmap(cmap, info);
-	for (i =3D 0; i < cmap->len; i++) {
-		hred =3D *red++;
-		hgreen =3D *green++;
-		hblue =3D *blue++;
-		if (transp)
-			htransp =3D *transp++;
-		if (info->fbops->fb_setcolreg(start++,
-					      hred, hgreen, hblue, htransp,
-					      info))
-			break;
+	if (info->fbops->fb_setcmap) {
+		rc =3D info->fbops->fb_setcmap(cmap, info);
+	} else {
+		for (i =3D 0; i < cmap->len; i++) {
+			hred =3D *red++;
+			hgreen =3D *green++;
+			hblue =3D *blue++;
+			if (transp)
+				htransp =3D *transp++;
+			if (info->fbops->fb_setcolreg(start++,
+						      hred, hgreen, hblue,=20
+						      htransp, info))
+				break;
+		}
 	}
-	return 0;
+	if (rc =3D=3D 0)
+		fb_copy_cmap(cmap, &info->cmap);
+
+	return rc;
 }
=20
 int fb_set_user_cmap(struct fb_cmap_user *cmap, struct fb_info *info)
 {
-	int i, start;
-	u16 __user *red, *green, *blue, *transp;
-	u_int hred, hgreen, hblue, htransp =3D 0xffff;
-
-	red =3D cmap->red;
-	green =3D cmap->green;
-	blue =3D cmap->blue;
-	transp =3D cmap->transp;
-	start =3D cmap->start;
-
-	if (start < 0 || (!info->fbops->fb_setcolreg &&
-			  !info->fbops->fb_setcmap))
+	int rc, size =3D cmap->len * sizeof(u16);
+	struct fb_cmap umap;
+=09
+	if (cmap->start < 0 || (!info->fbops->fb_setcolreg &&
+			        !info->fbops->fb_setcmap))
 		return -EINVAL;
=20
-	/* If we can batch, do it */
-	if (info->fbops->fb_setcmap && cmap->len > 1) {
-		struct fb_cmap umap;
-		int size =3D cmap->len * sizeof(u16);
-		int rc;
-
-		memset(&umap, 0, sizeof(struct fb_cmap));
-		rc =3D fb_alloc_cmap(&umap, cmap->len, transp !=3D NULL);
-		if (rc)
-			return rc;
-		if (copy_from_user(umap.red, red, size) ||
-		    copy_from_user(umap.green, green, size) ||
-		    copy_from_user(umap.blue, blue, size) ||
-		    (transp && copy_from_user(umap.transp, transp, size))) {
-			rc =3D -EFAULT;
-		}
-		umap.start =3D start;
-		if (rc =3D=3D 0)
-			rc =3D info->fbops->fb_setcmap(&umap, info);
-		fb_dealloc_cmap(&umap);
+	memset(&umap, 0, sizeof(struct fb_cmap));
+	rc =3D fb_alloc_cmap(&umap, cmap->len, cmap->transp !=3D NULL);
+	if (rc)
 		return rc;
+	if (copy_from_user(umap.red, cmap->red, size) ||
+	    copy_from_user(umap.green, cmap->green, size) ||
+	    copy_from_user(umap.blue, cmap->blue, size) ||
+	    (cmap->transp && copy_from_user(umap.transp, cmap->transp, size))) {
+		fb_dealloc_cmap(&umap);
+		return -EFAULT;
 	}
-
-	for (i =3D 0; i < cmap->len; i++, red++, blue++, green++) {
-		if (get_user(hred, red) ||
-		    get_user(hgreen, green) ||
-		    get_user(hblue, blue) ||
-		    (transp && get_user(htransp, transp)))
-			return -EFAULT;
-		if (info->fbops->fb_setcolreg(start++,
-					      hred, hgreen, hblue, htransp,
-					      info))
-			return 0;
-		if (transp)
-			transp++;
-	}
-	return 0;
+	umap.start =3D cmap->start;
+	rc =3D fb_set_cmap(&umap, info);
+	fb_dealloc_cmap(&umap);
+	return rc;
 }
=20
 /**



--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC2k7DaQ0HSaOUe+YRAhYbAKCv/ZFYKGjP+be+3RebhW1msw2EeQCgikc1
2Ua6gLggDe4OvFqgu2/H2xM=
=Akfl
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
