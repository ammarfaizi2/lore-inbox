Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263116AbVG3Tum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263116AbVG3Tum (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 15:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263124AbVG3Tuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 15:50:32 -0400
Received: from smtp-out0.tiscali.nl ([195.241.79.175]:53440 "EHLO
	smtp-out0.tiscali.nl") by vger.kernel.org with ESMTP
	id S263116AbVG3TuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 15:50:02 -0400
From: Frans Pop <aragorn@tiscali.nl>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.8 Errors during initrd loading with / on LVM over RAID
Date: Sat, 30 Jul 2005 21:50:07 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1907078.8Cc89A67Xx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200507302150.16369.aragorn@tiscali.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1907078.8Cc89A67Xx
Content-Type: multipart/mixed;
  boundary="Boundary-01=_vn96CflbSq1dCM0"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_vn96CflbSq1dCM0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm aware that devfs is being removed in 2.6.13, but this patch may still=20
interest maintainers of older versions.
I've debugged this problem using kernel version 2.6.8, but a check showed=20
this code is unchanged in 2.6.12. My system is Debian Sarge.

During boot using an initrd on a system having / on LVM over RAID, I=20
noticed the following messages on console and in /var/log/kern.log:=20

kernel: Inspecting /boot/System.map-2.6.8-2-686
kernel: Loaded 27390 symbols from /boot/System.map-2.6.8-2-686.
kernel: Symbols match kernel version 2.6.8.
kernel: No module symbols loaded - kernel modules not enabled.
kernel: ould not append to parent for /disc
kernel: devfs_mk_dir: invalid argument.<4>devfs_mk_dev: could not append=20
to parent for /disc
last message repeated 151 times


Cleaned for a missing \n in a printk and with added debug printk's in
fs/devfs/base.c, this looks like:
kernel: devfs_mk_dir: invalid argument, buf: .
kernel: _devfs_append_entry: -EEXIST for :disc
kernel: devfs_mk_dev: could not append to parent for /disc
(repeated)

The last two errors are a consequence of the error in devfs_mk_dir, so
can be ignored. The basic problem is that buf is empty when devfs_mk_dir
is called.

Tracing back I ended up in fs/partitions/check.c, which has the following
code in function register_disk:

        /* No minors to use for partitions */
        if (disk->minors =3D=3D 1) {
                if (disk->devfs_name[0] !=3D '\0')
                        devfs_add_disk(disk);
                return;
        }

        /* always add handle for the whole disk */
        devfs_add_partitioned(disk);

This looks unlogical: why does the first statement check for empty
disk->devfs_name and is the second one called blindly?

Changing the last statement to:
        if (disk->devfs_name[0] !=3D '\0')
                devfs_add_partitioned(disk);
        else
                printk(KERN_WARNING "%s: No devfs_name for %s.\n",=20
__FUNCTION__, disk->disk_name);
resulted in the errors disappearing and the following log output:

kernel: register_disk: No devfs_name for md_d0.
kernel: register_disk: No devfs_name for md_d64.
kernel: register_disk: No devfs_name for md_d128.
kernel: register_disk: No devfs_name for md_d192.
kernel: register_disk: No devfs_name for md_d4.
kernel: register_disk: No devfs_name for md_d68.
kernel: register_disk: No devfs_name for md_d132.
kernel: register_disk: No devfs_name for md_d196.
(repeated to md_d255)

The attached patch fixes the problem (and adds the missing \n).


--Boundary-01=_vn96CflbSq1dCM0
Content-Type: text/x-diff;
  charset="us-ascii";
  name="devfs_md_initrd.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="devfs_md_initrd.patch"

=2D-- fs/partitions/check.c.orig	2005-05-19 12:52:23.000000000 +0200
+++ fs/partitions/check.c	2005-07-29 00:36:04.523385998 +0200
@@ -348,7 +348,8 @@
 	}
=20
 	/* always add handle for the whole disk */
=2D	devfs_add_partitioned(disk);
+	if (disk->devfs_name[0] !=3D '\0')
+		devfs_add_partitioned(disk);
=20
 	/* No such device (e.g., media were just removed) */
 	if (!get_capacity(disk))
=2D-- fs/devfs/base.c.orig	2005-07-29 00:32:03.329992027 +0200
+++ fs/devfs/base.c	2005-07-29 00:32:52.000008934 +0200
@@ -1644,7 +1644,7 @@
 	va_start(args, fmt);
 	n =3D vsnprintf(buf, 64, fmt, args);
 	if (n >=3D 64 || !buf[0]) {
=2D		printk(KERN_WARNING "%s: invalid argument.", __FUNCTION__);
+		printk(KERN_WARNING "%s: invalid argument.\n", __FUNCTION__);
 		return -EINVAL;
 	}
=20

--Boundary-01=_vn96CflbSq1dCM0--

--nextPart1907078.8Cc89A67Xx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC69n4gm/Kwh6ICoQRAvzuAKDUK4R59DFWznJwXhPc22BA4JhiOgCcCwts
/bsdwa9754LHpiozVOKPDAY=
=z2Ro
-----END PGP SIGNATURE-----

--nextPart1907078.8Cc89A67Xx--
