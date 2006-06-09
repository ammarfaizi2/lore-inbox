Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbWFIWte@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbWFIWte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbWFIWte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:49:34 -0400
Received: from pops.net-conex.com ([204.244.176.3]:6338 "EHLO
	mail.net-conex.com") by vger.kernel.org with ESMTP id S932292AbWFIWtd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:49:33 -0400
Date: Fri, 9 Jun 2006 15:49:36 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] tmpfs time granularity fix for [acm]time moving backwards.
Message-ID: <20060609224936.GA30611@curie-int.vc.shawcable.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Please CC me on replies].

I noticed a strange behavior in a tmpfs file system the other day, while
building packages - occasionally, and seemingly at random, make decided to
rebuild a target. However only on tmpfs.

A file would be created, and if checked, it had a sub-second timestamp.
However, after an utimes related call where sub-seconds should be set, they
were zeroed instead. In the case that a file was created, and utimes(...,NU=
LL)
was used on it in the same second, the timestamp on the file moved backward=
s.

Puesdo-code of my testcase:
	int fd =3D creat(name,0644);
	fstat(fd,&st);
	printf("...[acm]time...",...)
	futime(fd,NULL);
	fstat(fd,&st);
	printf("...[acm]time...",...)
	close(fd);

Tested against: linus 2.6.13, linus 2.6.17-rc6.

Test output from a filesystem not supporting sub-second timestamps (ext3, r=
eiserfs):
creat:   m=3D1149891410.0 c=3D1149891410.0 a=3D1149891407.0
futimes: m=3D1149891410.0 c=3D1149891410.0 a=3D1149891410.0

Test output from a filesystem supporting sub-second timestamps (jfs,xfs,ram=
fs):
creat:   m=3D1149891452.928796249 c=3D1149891452.928796249 a=3D1149891452.9=
28796249
futimes: m=3D1149891452.928796249 c=3D1149891452.928796249 a=3D1149891452.9=
28796249

Test output from the tmpfs filesystem before the fix:
creat:   m=3D1149892052.562029884 c=3D1149892052.562029884 a=3D1149892052.5=
62029884
futimes: m=3D1149892052.0         c=3D1149892052.0         a=3D1149892052.0

Test output from the tmpfs filesystem with the patch below:
creat:   m=3D1149892086.382150894 c=3D1149892086.382150894 a=3D1149892075.4=
73249075
futimes: m=3D1149892086.383150885 c=3D1149892086.383150885 a=3D1149892086.3=
83150885

After some digging, I found that this was being caused by tmpfs not having a
time granularity set, thus inheriting the default 1s granularity.

NOTE: This also indicates there is another bug at the VFS layer, where the
initial timestamp did not have the granularity applied to it.

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2102,6 +2102,7 @@ #endif
 	sb->s_blocksize_bits =3D PAGE_CACHE_SHIFT;
 	sb->s_magic =3D TMPFS_MAGIC;
 	sb->s_op =3D &shmem_ops;
+	sb->s_time_gran =3D 1;
=20
 	inode =3D shmem_get_inode(sb, S_IFDIR | mode, 0);
 	if (!inode)

--=20
Robin Hugh Johnson
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFEifsAPpIsIjIzwiwRAsKSAJ9Oqey0BepWssiuPwb3rP72OkRm1gCg3CA4
tcp52wxeuoIvzuc6aQxOB4Q=
=ym45
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
