Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVETNXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVETNXf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 09:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVETNXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:23:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:36501 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261463AbVETNXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:23:25 -0400
Date: Fri, 20 May 2005 09:23:25 -0400
From: Neil Horman <nhorman@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [Patch] vfs: increase scope of critical locked path in fget_light to avoid race
Message-ID: <20050520132325.GE19229@hmsendeavour.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patch to increase the scope of the locked critical path in fget_light to in=
clude
the conditional where there is only one reference to the passed file_struct.
Currently there is no protection against someone modifying that reference c=
ount
after it has been read in fget_light and falling into a code path where the=
 fd
array is modified.  The result is a race condition that leads to a corrupte=
d fd
table and potential oopses.  This patch corrects that by enforcing the lock=
ing
protocol that is used by all other accessors of the fd table on the 1 refer=
ence
case in fget_light.  Smoke tested by me, with no failures.

Signed-off-by: Neil Horman <nhorman@redhat.com>

 file_table.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

=20
--- linux-2.6.git/fs/file_table.c.racefix	2005-05-20 07:32:12.000000000 -04=
00
+++ linux-2.6.git/fs/file_table.c	2005-05-20 08:53:03.000000000 -0400
@@ -174,17 +174,17 @@ struct file fastcall *fget_light(unsigne
 	struct files_struct *files =3D current->files;
=20
 	*fput_needed =3D 0;
+	spin_lock(&files->file_lock);
 	if (likely((atomic_read(&files->count) =3D=3D 1))) {
 		file =3D fcheck_files(files, fd);
 	} else {
-		spin_lock(&files->file_lock);
 		file =3D fcheck_files(files, fd);
 		if (file) {
 			get_file(file);
 			*fput_needed =3D 1;
 		}
-		spin_unlock(&files->file_lock);
 	}
+	spin_unlock(&files->file_lock);
 	return file;
 }
=20
--=20
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCjeTNM+bEoZKnT6ERAmjKAJ93nRM9GdElxN+XGlXelQh93qkVVgCfRWSU
V6zBC0NV7TZEVJhUOh7FqM4=
=dDV9
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
