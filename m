Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291885AbSBARp5>; Fri, 1 Feb 2002 12:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291883AbSBARpk>; Fri, 1 Feb 2002 12:45:40 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:8979 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S291880AbSBARpW>; Fri, 1 Feb 2002 12:45:22 -0500
Date: Fri, 1 Feb 2002 15:45:08 -0200
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: quintela@mandrakesoft.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Fixes supermount Oopses when mount options are not given
Message-ID: <20020201174507.GA1860@rayden.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following patch fixes two Oopses on supermount.
The first one happens when the dev=3D option is not given to supermount, ip=
ut()
is called after dput(), but iput() is already called by dput().
The other one happens when the fs=3D option is not given. subfs_mount() doe=
sn't
check if sbi->s_type is NULL.

Regards,

--
Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
http://www.boto.f2s.com
04BE D2EF 5A56 E446 D424  4785 71A4 49EB AC35 9568
----

# ------------------------
diff -urN kernel-2.4.17/linux/fs/supermount/super.c kernel-2.4.17-supermoun=
tok/linux/fs/supermount/super.c
--- kernel-2.4.17/linux/fs/supermount/super.c	Fri Feb  1 14:10:39 2002
+++ kernel-2.4.17-supermountok/linux/fs/supermount/super.c	Fri Feb  1 11:56=
:36 2002
@@ -276,7 +276,7 @@
 	char **type =3D types_in_order;
=20
=20
-	if (strcmp(sbi->s_type, "auto"))
+	if (sbi->s_type && strcmp(sbi->s_type, "auto"))
 		return subfs_real_mount2 (sb, sbi->s_type);
 	=09
 	while (*type && retval) {
diff -urN kernel-2.4.17/linux/fs/supermount/super_operations.c kernel-2.4.1=
7-supermountok/linux/fs/supermount/super_operations.c
--- kernel-2.4.17/linux/fs/supermount/super_operations.c	Fri Feb  1 14:10:3=
9 2002
+++ kernel-2.4.17-supermountok/linux/fs/supermount/super_operations.c	Fri F=
eb  1 11:56:36 2002
@@ -279,10 +279,12 @@
 	return s;
 fail_parsing:
 	s->s_dev =3D 0;
-	dput (root);
 fail_allocating_root:
 	supermount_debug ("get root dentry failed");
-	iput (root_inode);
+	if(root)
+		dput (root);
+	else
+		iput (root_inode);
 	free_sbi (sbi);
 fail_no_memory:
 	return NULL;

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8WtQicaRJ66w1lWgRAvOMAJ9kZjzDYH2cA76e4+e7zNoFcJkzWgCfV9in
Ht9ZPdwhiz5Mwk0YOq77Gtw=
=6qbe
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
