Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750970AbWFYN5M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750970AbWFYN5M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 09:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWFYN5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 09:57:12 -0400
Received: from mail.konline.info ([212.227.56.75]:41477 "EHLO
	mail.konline.info") by vger.kernel.org with ESMTP id S1750970AbWFYN5K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 09:57:10 -0400
Date: Sun, 25 Jun 2006 15:59:26 +0200
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Cc: es186@fen-net.de
Subject: Bug in 2.6.17 / mdadm 2.5.1
Message-ID: <20060625135926.GA6253@defiant.crash>
References: <20060624104745.GA6352@defiant.crash>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20060624104745.GA6352@defiant.crash>
User-Agent: Mutt/1.5.11+cvs20060403
From: Ronald Lembcke <es186@fen-net.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There's a bug in Kernel 2.6.17 and / or mdadm which prevents (re)adding
a disk to a degraded RAID5-Array.

The mail I'm replying to was sent to linux-raid only. A summary of my
problem is in the quoted part, and everything you need to reproduce it
is below.
There's more information (kernel log, output of mdadm -E, ...) in the
original mail (
Subject: RAID5 degraded after mdadm -S, mdadm --assemble (everytime)
Message-ID: <20060624104745.GA6352@defiant.crash>
It can be found here for example:=20
http://www.spinics.net/lists/raid/msg12859.html )

More about this problem below the quoted pard.

On Sat Jun 24 12:47:45 2006, I wrote:
> I set up a RAID5 array of 4 disks. I initially created a degraded array
> and added the fourth disk (sda1) later.
>=20
> The array is "clean", but when I do =20
>   mdadm -S /dev/md0=20
>   mdadm --assemble /dev/md0 /dev/sd[abcd]1
> it won't start. It always says sda1 is "failed".
>=20
> When I remove sda1 and add it again everything seems to be fine until I
> stop the array.=20

CPU: AMD-K6(tm) 3D processor
Kernel: Linux version 2.6.17 (root@ganges) (gcc version 4.0.3 (Debian
4.0.3-1)) #2 Tue Jun 20 17:48:32 CEST 2006

The problem is: The superblocks get inconsistent, but I couldn't find
where this actually happens.

Here are some simple steps to reproduce it (don't forget to adjust the
device-names if you're allready using /dev/md1 or /dev/loop[0-3]):
The behaviour changes when you execute --zero-superblock in the example=20
below (it looks even more broken).
It also changes when you fail some other disk instead of loop2.
When loop3 is failed (without executing --zero-superblock) it can
successfully be re-added.


############################################
cd /tmp; mkdir raiddtest; cd raidtest
dd bs=3D1M count=3D1 if=3D/dev/zero of=3Ddisk0
dd bs=3D1M count=3D1 if=3D/dev/zero of=3Ddisk1
dd bs=3D1M count=3D1 if=3D/dev/zero of=3Ddisk2
dd bs=3D1M count=3D1 if=3D/dev/zero of=3Ddisk3
losetup /dev/loop0 disk0
losetup /dev/loop1 disk1
losetup /dev/loop2 disk2
losetup /dev/loop3 disk3
mdadm --create /dev/md1 --level=3D5 --raid-devices=3D4 /dev/loop0 /dev/loop=
1 /dev/loop2 /dev/loop3
mdadm /dev/md1 --fail /dev/loop2
mdadm /dev/md1 --remove /dev/loop2

#mdadm --zero-superblock /dev/loop2
# here something goes wrong
mdadm /dev/md1 --add /dev/loop2

mdadm --stop /dev/md1
# can't reassemble
mdadm --assemble /dev/md1 /dev/loop0 /dev/loop1 /dev/loop2 /dev/loop3
############################################


To cleanup everything :)
############################################
mdadm --stop /dev/md1
losetup -d /dev/loop0
losetup -d /dev/loop1
losetup -d /dev/loop2
losetup -d /dev/loop3
rm disk0 disk1 disk2 disk3
###########################################


After mdadm --create the superblocks are ok, but look a little bit
strange (the failed device):

dev_roles[i]: 0000 0001 0002 fffe 0003
the disks have dev_num: 0,1,2,4

But after --fail --remove --add=20
dev_roles[i]: 0000 0001 fffe fffe 0003 0002
but the disks still have dev_num: 0,1,2,4.
Either loop2 must have disk_num=3D5 or dev_roles needs to be
0,1,2,0xfffe,4.


Greetings,
           Roni

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEnpa+1AoV+KoUdT8RAu3ZAJ4qpO2JXAPCI7kvC349tOcb5S+uSQCfXo7C
F9H9A/GQ4WYiyrjpv6vg3lI=
=rcdC
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
