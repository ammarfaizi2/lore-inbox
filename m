Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273345AbRJ0R2b>; Sat, 27 Oct 2001 13:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273622AbRJ0R2W>; Sat, 27 Oct 2001 13:28:22 -0400
Received: from mout0.freenet.de ([194.97.50.131]:56754 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S273565AbRJ0R2G>;
	Sat, 27 Oct 2001 13:28:06 -0400
Date: Sat, 27 Oct 2001 19:01:17 +0200
From: Johannes Kloos <j.kloos@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Deadlock in current devfs with nested symlinks
Message-ID: <20011027190117.A13417@gandalf.yadha.dnsalias.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello kernel hackers,
I have found a deadlock in the current version of devfs.
It can be reproduced like this on a system with an IDE CD-ROM drive:
0. Make sure devfs is mounted on /dev and devfsd is running with
   MKOLDCOMPAT and MKNEWCOMPAT enabled.
1. Create a symlink from /dev/cdroms/cdrom0 to /dev/cdrom
2. rmmod ide-cd
3a. mount /dev/cdrom /mnt
or
3b. file -L /dev/cdrom

I've traced this bug to the symlink semaphore in devfs.
As far as I can tell, the following events lead to a deadlock:
1. file -L tries to stat(2) /dev/cdrom. stat will follow the symlinks
   and acquires symlink_rwsem for reading.
2. /dev/cdroms/cdrom0 doesn't exist, so the kernel tells devfsd
   to look up /dev/cdroms/cdrom0.
3. devfsd loads ide-cd.o. Then, it will try to create the appropriate
   symlinks in /dev.
4. devfs_do_symlink tries to acquire symlink_rwsem for writing - deadlock.

I've verified this on 2.4.12ac3 and 2.4.13. I had this problem on 2.4.12 as
well.
Updating to a current devfsd didn't help.

--=20
Johannes Kloos
Developer Version
 Programmpaket mit Dokumentation=20
-- Kristian K=F6hntopp

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Weitere Infos: siehe http://www.gnupg.org

iEYEARECAAYFAjva6F0ACgkQ847ACWNJQcx+DgCgmKOkgM76dx3nedQ52ok7TrX6
VnEAmQHg+IKsR7NzWENq9V1RUNt6QGY2
=5HLQ
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
