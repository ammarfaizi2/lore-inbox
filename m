Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293546AbSBZI4B>; Tue, 26 Feb 2002 03:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293547AbSBZIzw>; Tue, 26 Feb 2002 03:55:52 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:2321 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S293546AbSBZIzo>;
	Tue, 26 Feb 2002 03:55:44 -0500
Date: Tue, 26 Feb 2002 11:59:46 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove unneeded inode semaphores from driverfs
Message-ID: <20020226085946.GB278@pazke.ipt>
Mail-Followup-To: mochel@osdl.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.3-dj3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vni90+aGYgRvsTuO
Content-Type: multipart/mixed; boundary="Pk6IbRAofICFmK5e"
Content-Disposition: inline


--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

__remove_file() in driverfs/inode.c calls down(&dentry->d_inode->i_sem)
before calling vfs_unlink(dentry->d_parent->d_inode,dentry) which=20
tries to claim the same semaphore causing the livelock.
driverfs_remove_dir() makes the same calling vfs_rmdir().

These bugs are triggered by driverfs for IDE patch by Pavel Machek.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--Pk6IbRAofICFmK5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-driverfs-sem
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff /linux.vanilla/fs/driverfs/inode.c /linux/=
fs/driverfs/inode.c
--- /linux.vanilla/fs/driverfs/inode.c	Sun Feb 17 15:15:57 2002
+++ /linux/fs/driverfs/inode.c	Sat Feb 23 22:42:38 2002
@@ -698,11 +698,9 @@
 static void __remove_file(struct dentry * dentry)
 {
 	dget(dentry);
-	down(&dentry->d_inode->i_sem);
=20
 	vfs_unlink(dentry->d_parent->d_inode,dentry);
=20
-	up(&dentry->d_inode->i_sem);
 	dput(dentry);
=20
 	/* remove reference count from when file was created */
@@ -766,7 +764,6 @@
 	dentry =3D dget(dir->dentry);
 	dget(dentry->d_parent);
 	down(&dentry->d_parent->d_inode->i_sem);
-	down(&dentry->d_inode->i_sem);
=20
 	node =3D dir->files.next;
 	while (node !=3D &dir->files) {
@@ -782,7 +779,6 @@
=20
 	vfs_rmdir(dentry->d_parent->d_inode,dentry);
 	up(&dentry->d_parent->d_inode->i_sem);
-	up(&dentry->d_inode->i_sem);
=20
 	/* remove reference count from when directory was created */
 	dput(dentry);

--Pk6IbRAofICFmK5e--

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8e06CBm4rlNOo3YgRAlMRAKCCNvHG5tyq+vnsJf/NUS+H3RQMYQCfVcg/
pILRkUG1wuiyLBPJf+jhIbQ=
=sL/s
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
