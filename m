Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286462AbSBGJHn>; Thu, 7 Feb 2002 04:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbSBGJHe>; Thu, 7 Feb 2002 04:07:34 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:50187 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S286462AbSBGJH0>;
	Thu, 7 Feb 2002 04:07:26 -0500
Date: Thu, 7 Feb 2002 12:10:53 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] read() from driverfs files can read more bytes then requested
Message-ID: <20020207091053.GA4332@pazke.ipt>
Mail-Followup-To: Patrick Mochel <mochel@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.3-dj3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bajzpZikUji1w+G9
Content-Type: multipart/mixed; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

small program below crashes on read() from driverfs file:

int main(void)
{
	int fd, ret;
	char buf[16];

	fd =3D open("/var/driver/root/pci0/status", 0);
	ret =3D read(fd, buf, sizeof(buf));
	close(fd);
}

it's because driverfs_read_file() function blindly uses entry->show()
return value without sanity check. As a result userspace process requested=
=20
16 bytes, but got ~45 and smashed stack as a bonus. You can also get this=
=20
effect pressing F3 in Midnight Commander on driverfs files.

Attached patch adds check that returned value is less then requested=20
byte count. I know that actual callback function device_read_status()
should also be fixed, but I found this bug after midnight and=20
decided to sleep a little :)

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-driverfs
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/dontdiff /linux.2.5.3-dj3/fs/driverfs/inode.c /linux/fs/d=
riverfs/inode.c
--- /linux.2.5.3-dj3/fs/driverfs/inode.c	Wed Feb  6 23:42:06 2002
+++ /linux/fs/driverfs/inode.c	Wed Feb  6 23:34:05 2002
@@ -255,6 +255,9 @@
=20
 		len =3D entry->show(dev,page,count,*ppos);
=20
+		if (len > count)
+			len =3D count;
+
 		if (len <=3D 0) {
 			if (len < 0)
 				retval =3D len;

--c3bfwLpm8qysLVxt--

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8YkSdBm4rlNOo3YgRAhEYAJ4zj2kpr4SzpNgYTW9NiAM7mDrN9wCeJGUk
/8+MhEHWORbuK7ur+p2R7Zs=
=9f53
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
