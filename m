Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWCEB0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWCEB0O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 20:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWCEB0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 20:26:13 -0500
Received: from mail.anathoth.gen.nz ([202.78.241.50]:47547 "EHLO
	mail.anathoth.gen.nz") by vger.kernel.org with ESMTP
	id S1751272AbWCEB0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 20:26:13 -0500
Subject: PROBLEM:  rt_sigsuspend() does not return EINTR on 2.6.16-rc2+
From: Matthew Grant <grantma@anathoth.gen.nz>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PTM5BacX+v2nqRnDPoZU"
Organization: Matthew's UNIX Box
Date: Sun, 05 Mar 2006 14:26:00 +1300
Message-Id: <1141521960.7628.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PTM5BacX+v2nqRnDPoZU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Problem is that new sys_rt_sigsuspend in kernel/signal.c in 2.6.16-rc2+
does not return EINTR.

System:  Ubuntu i386 breezy badger.
Arch: i386
Kernel version: 2.6.16-rc5, gcc 3.3

This break the removable media handling of nautilus on Ubuntu Breezy
Badger, Gnome 2.12, Drives mount, but mount status tracking in GNOME is
broken, and they are not shown as mounted.  What is going on is that
rt_sigsuspend() gets called as part of the external call to pmount-hal
to mount the device.  The reads of the FIFOs and sockets between hald
and Nautilus get are not retried as rt_sigsuspend(2) does not return
EINTR.


Here is the strace output for 2.6.16-rc5 for nautilus when trying to
mount a drive (problem happening):


read(3, "\1\2m$\0\0\0\0]\0 \1\4\0\0\0\0\0\0\0$\344\1\0000\375\246"...,
32) =3D 32
access("/usr/bin/pmount-hal", X_OK)     =3D 0
getuid32()                              =3D 1000
rt_sigprocmask(SIG_SETMASK, NULL, [RTMIN], 8) =3D 0
write(20, "`\230\217@\0\0\0\0\0\0\0\0\362\372i@\370}W\10\0\0\0\200"...,
148) =3D 148
rt_sigprocmask(SIG_SETMASK, NULL, [RTMIN], 8) =3D 0
rt_sigsuspend([])                       =3D ? ERESTARTNOHAND (To be
restarted)
--- SIGRTMIN (Unknown signal 32) @ 0 (0) ---
sigreturn()                             =3D ? (mask now [RTMIN])
gettimeofday({1141503088, 150962}, NULL) =3D 0
poll([{fd=3D4, events=3DPOLLIN}, {fd=3D3, events=3DPOLLIN, revents=3DPOLLIN=
},
{fd=3D8, events=3DPOLLIN|POLLPRI}, {fd=3D10, events=3DPOLLIN|POLLPRI}, {fd=
=3D14,
events=3DPOLLIN}], 5, 0) =3D 1


Comparitive strace output under kernel 2.6.15.4:

poll([{fd=3D4, events=3DPOLLIN}, {fd=3D3, events=3DPOLLIN}, {fd=3D8,
events=3DPOLLIN|POLLPRI}, {fd=3D10, events=3DPOLLIN|POLLPRI}, {fd=3D14,
events=3DPOLLIN}], 5, 0) =3D 0
gettimeofday({1141488494, 765282}, NULL) =3D 0
access("/usr/bin/pmount-hal", X_OK)     =3D 0
getuid32()                              =3D 1000
rt_sigprocmask(SIG_SETMASK, NULL, [RTMIN], 8) =3D 0
write(20, "`\230\217@\0\0\0\0\0\0\0\0\362\372i@@\2U\10\0\0\0\200\0"...,
148) =3D 148
rt_sigprocmask(SIG_SETMASK, NULL, [RTMIN], 8) =3D 0
rt_sigsuspend([] <unfinished ...>
--- SIGRTMIN (Unknown signal 32) @ 0 (0) ---
<... rt_sigsuspend resumed> )           =3D -1 EINTR (Interrupted system
call)
sigreturn()                             =3D ? (mask now [RTMIN])
gettimeofday({1141488494, 778060}, NULL) =3D 0
poll([{fd=3D4, events=3DPOLLIN}, {fd=3D3, events=3DPOLLIN}, {fd=3D8,
events=3DPOLLIN|POLLPRI}, {fd=3D10, events=3DPOLLIN|POLLPRI}, {fd=3D14,
events=3DPOLLIN}], 5, 0) =3D 0
write(3, "*\2\3\0]\0 \1\344r\2\0+\0\1\0\22\0\7\0\\\0 \1\2\1\0\0\6"...,
44) =3D 44
ioctl(3, FIONREAD, [160])               =3D=20

I think David woodhouse may be responsible for this....

Regards,

Matthew Grant


--=20
Matthew Grant <grantma@anathoth.gen.nz>
Matthew's UNIX Box

--=-PTM5BacX+v2nqRnDPoZU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBECj4ouk55Di7iAnARAm4nAKCobFy3yH5ttytKoU+aP+qdfi0gKwCeO/hJ
wl2SfINy0sypVHClkTTMAS0=
=wWpv
-----END PGP SIGNATURE-----

--=-PTM5BacX+v2nqRnDPoZU--

