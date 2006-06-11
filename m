Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWFKMA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWFKMA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 08:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWFKMA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 08:00:59 -0400
Received: from pops.net-conex.com ([204.244.176.3]:61663 "EHLO
	mail.net-conex.com") by vger.kernel.org with ESMTP id S1751156AbWFKMA7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 08:00:59 -0400
Date: Sun, 11 Jun 2006 04:54:21 -0700
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] tmpfs time granularity fix for [acm]time going backwards. Also VFS time granularity bug on creat(). (Repost, more content)
Message-ID: <20060611115421.GE26475@curie-int.vc.shawcable.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Please CC me on replies].

This patch should probably be included for 2.6.17, despite how long the
bug has been around. It's a one-liner, with no side-effects.

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

The output above of jfs/xfs/ramfs having identical ctime/mtime in the
utime/creat calls is just co-incidence, my box is reasonably fast, on a
slower machine, they do diverge more. My box is just fast enough that
they happened in the same tick (I have HZ=3D1000).

After some digging, I found that this was being caused by tmpfs not having a
time granularity set, thus inheriting the default 1s granularity.

NOTE: The further bug:
I believe this also indicates there is another bug at the VFS layer,
where the initial timestamp from the creat() operation did not have the
granularity applied to it. I haven't traced this problem down yet,
others that are more familiar with the VFS might have a bit better luck.
Unless this is fixed, similar issues may crop up with other filesystems.
It just needs a bit of code like this:
inode->i_[acm]time =3D current_fs_time(inode->i_sb);

Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>

--- mm/shmem.c
+++ mm/shmem.c
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

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks

iD8DBQFEjARtPpIsIjIzwiwRAo4IAJ4tqu0KUNYRGpX5OUOQLVLPoKPyPgCeMgJm
DEBSQ6NHm0mlaPIpdkmVW6Y=
=zZgW
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
