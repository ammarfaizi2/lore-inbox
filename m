Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbWBDRVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbWBDRVy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 12:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932533AbWBDRVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 12:21:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:1937 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932532AbWBDRVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 12:21:53 -0500
Message-ID: <43E4E318.1030304@redhat.com>
Date: Sat, 04 Feb 2006 09:23:36 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Thunderbird 1.5 (X11/20060128)
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: One more unlock missing in error case
X-Enigmail-Version: 0.93.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0185D4A117D31086E0543D4E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0185D4A117D31086E0543D4E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This patch is needed to in addition to the other unlocking fix which is
already applied.  It should be obvious that the system will deadlock in
case this isn't done.

(Andrew, I once again used a goto in the third error case because the
common code is again larger.)

Signed-Off-By: Ulrich Drepper <drepper@redhat.com>

--- fs/namei.c	2006-02-01 09:29:49.000000000 -0800
+++ fs/namei.c-new	2006-02-04 09:18:02.000000000 -0800
@@ -1096,6 +1096,7 @@

 		file =3D fget_light(dfd, &fput_needed);
 		if (!file) {
+			read_unlock(&current->fs->lock);
 			retval =3D -EBADF;
 			goto out_fail;
 		}
@@ -1104,15 +1105,15 @@

 		if (!S_ISDIR(dentry->d_inode->i_mode)) {
 			retval =3D -ENOTDIR;
+		unlock_fail:
 			fput_light(file, fput_needed);
+			read_unlock(&current->fs->lock);
 			goto out_fail;
 		}

 		retval =3D file_permission(file, MAY_EXEC);
-		if (retval) {
-			fput_light(file, fput_needed);
-			goto out_fail;
-		}
+		if (retval)
+			goto unlock_fail;

 		nd->mnt =3D mntget(file->f_vfsmnt);
 		nd->dentry =3D dget(dentry);


--=20
=E2=9E=A7 Ulrich Drepper =E2=9E=A7 Red Hat, Inc. =E2=9E=A7 444 Castro St =
=E2=9E=A7 Mountain View, CA =E2=9D=96


--------------enig0185D4A117D31086E0543D4E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFD5OMY2ijCOnn/RHQRAm98AKDE+QR1O4yP2gCGb/vL7iqckZA7nQCdF6U4
2Yin2eR0avQCzEpwuO51nTg=
=YRKe
-----END PGP SIGNATURE-----

--------------enig0185D4A117D31086E0543D4E--
