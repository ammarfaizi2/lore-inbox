Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270672AbTG1ULS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270724AbTG1ULS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:11:18 -0400
Received: from [80.146.195.226] ([80.146.195.226]:36836 "EHLO
	apollo.sven.bitebene.org") by vger.kernel.org with ESMTP
	id S270672AbTG1UKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:10:08 -0400
Date: Mon, 28 Jul 2003 22:10:06 +0200
From: Sven Schnelle <schnelle@kabelleipzig.de>
To: linux-kernel@vger.kernel.org
Subject: Framebuffer Console
Message-ID: <20030728201006.GA349@apollo.sven.bitebene.org>
Mail-Followup-To: Sven Schnelle <schnelle@kabelleipzig.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

while testing linux-2.6.0-test2 I have some strange framebuffer(rivafb,
but maybe this appears on other card's too)
behaviour:

1) Screen is not restored after switching from X11 back to textmode
2) Cursor shows wrong characters


This patch solve the problems for me:

-------------------------------------8<--------------------------------
diff -ur linux-2.6.0-test2/drivers/video/console/fbcon.c linux-2.6.0-test2-=
sv/drivers/video/console/fbcon.c
--- linux-2.6.0-test2/drivers/video/console/fbcon.c	2003-07-27 19:05:15.000=
000000 +0200
+++ linux-2.6.0-test2-sv/drivers/video/console/fbcon.c	2003-07-28 10:40:38.=
000000000 +0200
@@ -1056,7 +1056,7 @@
 			cursor.set |=3D FB_CUR_SETHOT;
 		}
=20
-		if ((cursor.set & FB_CUR_SETSIZE) || ((vc->vc_cursor_type & 0x0f) !=3D p=
->cursor_shape)) {
+		if ((cursor.set & FB_CUR_SETSIZE) || (cursor.set & FB_CUR_SETCUR) || ((v=
c->vc_cursor_type & 0x0f) !=3D p->cursor_shape)) {
 			char *mask =3D kmalloc(w*vc->vc_font.height, GFP_ATOMIC);
 			int cur_height, size, i =3D 0;
=20
@@ -1704,8 +1704,13 @@
 	if (blank < 0)		/* Entering graphics mode */
 		return 0;
=20
+	/* FIXME: Dirty Hack */
+	info->cursor.image.height =3D 0;	/* Need to set cursor size */
+	info->cursor.image.width =3D 0;
 	fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
=20
+	fbcon_clear(vc, 0, 0, vc->vc_rows, vc->vc_cols);
+	update_screen(vc->vc_num);
 	if (!info->fbops->fb_blank) {
 		if (blank) {
 			unsigned short oldc;
-----------------------------------8<--------------------------------------

don't know if this is the right way, but it works...

Regards,
--=20
Sven Schnelle, <schnelle@kabelleipzig.de>
-----------------------------------------

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/JYMe86MdxiXaIbERAgegAKCWcO9aNJ2wSXxFu0+X5hgEr2cqdACgrhRV
Z/hMsnprr+0hZgrSjkqAhYg=
=V4fc
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
