Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVH3Iia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVH3Iia (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVH3Iia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:38:30 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:47255 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751240AbVH3Iia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:38:30 -0400
Subject: Checking keycodesize when adjusting keymaps breaks my IR remote
From: Ian Campbell <ijc@hellion.org.uk>
To: Dmitry Torokhov <dtor@mail.ru>, Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PdFiZLxPNXHs3cmlwqEK"
Date: Tue, 30 Aug 2005 09:38:26 +0100
Message-Id: <1125391106.6565.8.camel@azathoth.hellion.org.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PdFiZLxPNXHs3cmlwqEK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Gents,

This patch:
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D112227485202277&w=3D2
seems to break the remote control on my PVR-350 using ir-kbd-i2c.c.=20

The check "if (v >> (dev->keycodesize * 8))" in
evdev_ioctl:EVIOCSKEYCODE prevents me from loading the keymap. This is
because dev->keycodesize=3D4 so the size of the shift is 32 and the size
of v is also 32. For example it is called with v =3D=3D 82 which gives v >>
(dev->keycodesize * 8) =3D=3D 82 >> 32 which comes out as 82!

I think when the size of the shift is the size of the type, the result
of the shift is either undefined or triggers a bug in gcc (most likely
the former IMHO, but I don't have a reference to check).

There are no warnings when compiling the kernel because the shift size
is unknown at compile time, but if I explicitly write "v >> 32" then I
get:=20

	warning: right shift count >=3D width of type

I think the solution (workaround?) is to only perform this check if
keycodesize is less than sizeof(v). I'm unsure about adding a separate
check for keycodesize > sizeof(v). Casting v to a type > 32 bits also
does the trick if you prefer.

I wonder if the same applies in drivers/char/keyboard.c?

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>

Index: 2.6/drivers/input/evdev.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.6.orig/drivers/input/evdev.c	2005-08-29 10:40:22.000000000 +0100
+++ 2.6/drivers/input/evdev.c	2005-08-30 09:23:31.000000000 +0100
@@ -320,7 +320,7 @@
 			if (t < 0 || t >=3D dev->keycodemax || !dev->keycodesize) return -EINVA=
L;
 			if (get_user(v, ip + 1)) return -EFAULT;
 			if (v < 0 || v > KEY_MAX) return -EINVAL;
-			if (v >> (dev->keycodesize * 8)) return -EINVAL;
+			if (dev->keycodesize < sizeof(v) && v >> (dev->keycodesize * 8)) return=
 -EINVAL;
 			u =3D SET_INPUT_KEYCODE(dev, t, v);
 			clear_bit(u, dev->keybit);
 			set_bit(v, dev->keybit);


--=20
Ian Campbell

The biggest difference between time and space is that you can't reuse time.
		-- Merrick Furst

--=-PdFiZLxPNXHs3cmlwqEK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDFBsCM0+0qS9rzVkRAt4+AJ9lzTM3SmImJbCQz+CdVvpucpw5RQCeLFFp
/vJL1aLGB1dWkVJp3jvsUDs=
=XbLz
-----END PGP SIGNATURE-----

--=-PdFiZLxPNXHs3cmlwqEK--

