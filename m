Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbSLCUsK>; Tue, 3 Dec 2002 15:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbSLCUsK>; Tue, 3 Dec 2002 15:48:10 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:1921 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265843AbSLCUsI>;
	Tue, 3 Dec 2002 15:48:08 -0500
Subject: sysfs open should fail with -EACCES not -EPERM
From: Paul Larson <plars@linuxtestproject.org>
To: mochel@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-WQFPa0tyvE8GQfB2MnZT"
X-Mailer: Ximian Evolution 1.0.5 
Date: 03 Dec 2002 14:47:24 -0600
Message-Id: <1038948444.545.59.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WQFPa0tyvE8GQfB2MnZT
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I noticed that opening a file for write on sysfs that doesn't support it
returns -EPERM.  After checking the SuS, I believe the correct behavior
is to return -EACCES.

-Paul Larson

diff -Naur linux-2.5.50/fs/sysfs/inode.c linux-2.5.50-sysfsfix/fs/sysfs/ino=
de.c
--- linux-2.5.50/fs/sysfs/inode.c	Wed Nov 27 16:36:17 2002
+++ linux-2.5.50-sysfsfix/fs/sysfs/inode.c	Tue Dec  3 14:07:19 2002
@@ -279,9 +279,7 @@
 	 */
 	if (file->f_mode & FMODE_WRITE) {
=20
-		if (!(inode->i_mode & S_IWUGO))
-			goto Eperm;
-		if (!ops->store)
+		if (!(inode->i_mode & S_IWUGO) || !ops->store)
 			goto Eaccess;
=20
 	}
@@ -291,9 +289,7 @@
 	 * must be a show method for it.
 	 */
 	if (file->f_mode & FMODE_READ) {
-		if (!(inode->i_mode & S_IRUGO))
-			goto Eperm;
-		if (!ops->show)
+		if (!(inode->i_mode & S_IRUGO) || !ops->show)
 			goto Eaccess;
 	}
=20
@@ -308,9 +304,6 @@
 	goto Done;
  Eaccess:
 	error =3D -EACCES;
-	goto Done;
- Eperm:
-	error =3D -EPERM;
  Done:
 	return error;
 }


--=-WQFPa0tyvE8GQfB2MnZT
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEABECAAYFAj3tGFsACgkQbkpggQiFDqfKZACghneg9cKFA1As2T0esQrZKhz3
pQoAmwetFWprlX6xjQhQ6xmw3exfIfNP
=9lAr
-----END PGP SIGNATURE-----

--=-WQFPa0tyvE8GQfB2MnZT--

