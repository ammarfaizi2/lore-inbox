Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVECNNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVECNNz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 09:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVECNNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 09:13:55 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:53720 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261533AbVECNNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 09:13:50 -0400
Date: Tue, 3 May 2005 23:14:08 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Michael Kerrisk" <mtk-lkml@gmx.net>
Cc: heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
       andros@citi.umich.edu, matthew@wil.cx, schwidefsky@de.ibm.com,
       michael.kerrisk@gmx.net
Subject: Re: fcntl: F_SETLEASE/F_RDLCK question
Message-Id: <20050503231408.7c045648.sfr@canb.auug.org.au>
In-Reply-To: <2606.1115114418@www14.gmx.net>
References: <20050502210411.06226103.sfr@canb.auug.org.au>
	<2606.1115114418@www14.gmx.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Tue__3_May_2005_23_14_08_+1000_eiciMx1I553r/47J"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__3_May_2005_23_14_08_+1000_eiciMx1I553r/47J
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Tue, 3 May 2005 12:00:18 +0200 (MEST) "Michael Kerrisk" <mtk-lkml@gmx.ne=
t> wrote:
>
> Indeed the problem referred to is fixed, but it looks like another=20
> one may have been introduced.
>=20
> It now appears (I tested on 2.6.11.6) that if a process opens=20
> a file O_RDWR and then tries to place a read lease via that
> file descriptor, then the F_SETLEASE fails with EAGAIN,=20
> even though no other process has the file open for writing. =20
> (On the other hand, if the process opens the file=20
> O_WRONLY, then it can place either a read or a write lease. =20
> This is how I think things always worked, but it seems=20
> inconsistent with the aforementioned behaviour.) =20
>=20
> Some further testing showed the following (both open()=20
> and fcntl(F_SETLEASE) from same process):
>=20
>  open()  |  lease requested
>   flag   | F_RDLCK  | F_WRLCK
> ---------+----------+----------
> O_RDONLY | okay     |  okay
> O_WRONLY | EAGAIN   |  okay
> O_RDWR   | EAGAIN   |  okay
>=20
> This seems strange (I imagine the caller should be excluded=20
> from the list of processes being checked to see if the file=20
> is opened for writing), and differs from earlier kernel
> versions.  What is the intended behaviour here?

Thanks for the testing.  My expectation is that it shouldn't matter how
the current process opened the file for either type of lease.  However,
you are right (IMHO) that the current process should *not* be counted as a
writer in the case of trying to obtain a F_RDLCK lease.

How does this (completely untested, not even compiled) patch look?

diff -ruNP linus/fs/locks.c linus-leases.1/fs/locks.c
--- linus/fs/locks.c	2005-04-26 15:38:00.000000000 +1000
+++ linus-leases.1/fs/locks.c	2005-05-03 23:00:14.000000000 +1000
@@ -1288,7 +1288,8 @@
 		goto out;
=20
 	error =3D -EAGAIN;
-	if ((arg =3D=3D F_RDLCK) && (atomic_read(&inode->i_writecount) > 0))
+	if ((arg =3D=3D F_RDLCK) && (atomic_read(&inode->i_writecount)
+				 > ((filp->f_mode & FMODE_WRITE) ? 1 : 0)))
 		goto out;
 	if ((arg =3D=3D F_WRLCK)
 	    && ((atomic_read(&dentry->d_count) > 1)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__3_May_2005_23_14_08_+1000_eiciMx1I553r/47J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCd3kg4CJfqux9a+8RAhFeAJ45ZNUY8riHXsQe915+XHTWLLtODACdF1M0
t8oAWgUElGWDp5jdwWvMXfI=
=/k/A
-----END PGP SIGNATURE-----

--Signature=_Tue__3_May_2005_23_14_08_+1000_eiciMx1I553r/47J--
