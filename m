Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262139AbVDRRla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVDRRla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 13:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVDRRl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 13:41:29 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:52376 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262139AbVDRRlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 13:41:25 -0400
Subject: [PATCH] RLIMIT_NPROC enforcement during execve() calls
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jvNPF/gQLtUKrE+vEaJp"
Date: Mon, 18 Apr 2005 19:38:57 +0200
Message-Id: <1113845937.17341.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jvNPF/gQLtUKrE+vEaJp
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Enforces the RLIMIT_NPROC limit by adding an additional check for
execve(), as
such limit is checked only during fork() calls.

The patch is also available at:
http://pearls.tuxedo-es.org/patches/security/rlimit_nproc-enforcing-execve.=
patch

Signed-off-by: Lorenzo Hernandez Garcia-Hierro <lorenzo@gnu.org>
---

 linux-2.6.11-lorenzo/fs/compat.c |    8 ++++++++
 linux-2.6.11-lorenzo/fs/exec.c   |    9 +++++++++
 2 files changed, 17 insertions(+)

diff -puN fs/exec.c~rlimit_nproc-enforcing-execve fs/exec.c
--- linux-2.6.11/fs/exec.c~rlimit_nproc-enforcing-execve	2005-04-16
16:28:56.000000000 +0200
+++ linux-2.6.11-lorenzo/fs/exec.c	2005-04-16 19:26:47.000000000 +0200
@@ -1140,6 +1140,15 @@ int do_execve(char * filename,
 	if (IS_ERR(file))
 		goto out_kfree;
=20
+	/* RLIMIT_NPROC enforcement */
+	if (current->user && (atomic_read(&current->user->processes) >
+	     current->signal->rlim[RLIMIT_NPROC].rlim_cur) &&
+	    !capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE)) {
+		allow_write_access(file);
+		fput(file);
+		return -EAGAIN;
+	}
+
 	sched_exec();
=20
 	bprm->p =3D PAGE_SIZE*MAX_ARG_PAGES-sizeof(void *);
diff -puN fs/compat.c~rlimit_nproc-enforcing-execve fs/compat.c
--- linux-2.6.11/fs/compat.c~rlimit_nproc-enforcing-execve	2005-04-16
16:28:56.000000000 +0200
+++ linux-2.6.11-lorenzo/fs/compat.c	2005-04-16 19:26:58.000000000 +0200
@@ -1450,6 +1450,14 @@ int compat_do_execve(char * filename,
 	if (!bprm->mm)
 		goto out_file;
=20
+	/* RLIMIT_NPROC enforcement */
+	retval =3D -EAGAIN;
+	if (current->user && (atomic_read(&current->user->processes) >
+	     current->signal->rlim[RLIMIT_NPROC].rlim_cur) &&
+	    !capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE)) {
+		goto out_file;
+	}
+
 	retval =3D init_new_context(current, bprm->mm);
 	if (retval < 0)
 		goto out_mm;
_

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-jvNPF/gQLtUKrE+vEaJp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCY/CxDcEopW8rLewRAlpxAJ9efOfUjMWNjtBXNyr45ZRHhlLiTwCgt8FW
jNUYmeQfLAni7uogBVX4C5M=
=zXJG
-----END PGP SIGNATURE-----

--=-jvNPF/gQLtUKrE+vEaJp--

