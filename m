Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312083AbSCUQeM>; Thu, 21 Mar 2002 11:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311871AbSCUQeD>; Thu, 21 Mar 2002 11:34:03 -0500
Received: from 12-216-36-250.client.mchsi.com ([12.216.36.250]:3484 "EHLO
	united.lan.codewhore.org") by vger.kernel.org with ESMTP
	id <S311868AbSCUQdq>; Thu, 21 Mar 2002 11:33:46 -0500
Date: Thu, 21 Mar 2002 11:32:01 -0500
From: David Brown <dave@codewhore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Patch, forward release() return values to the close() call
Message-ID: <20020321113201.A26882@codewhore.org>
In-Reply-To: <200203210747.IAA25949@merlin.gams.co.at> <3C999633.2060104@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi:

Forgive me if I'm not completely understanding this, but isn't release()
only called when the refcount of the file structure drops to zero? e.g.:
           =20
  [18]Note that release isn't invoked every time a process calls close.
  Whenever a file structure is shared (for example, after a fork or a
  dup), release won't be invoked until all copies are closed. If you need
  to flush pending data when any copy is closed, you should implement the
  flush method.

Seems to me that even /with/ a change in semantics of close(), only the
last call to close() would actually get notified of the failure.

Thinking to NFS, would flush() be a better file_operation to use?


Regards,

- Dave
  dave@codewhore.org


On Thu, Mar 21, 2002 at 03:13:39AM -0500, Jeff Garzik wrote:
> Axel Kittenberger wrote:
>=20
> >Here goes my liitle patchy, once again :o)
> >
> >Whats it's about?
> >
> >When close()ing an charcter device one expects the return value of the=
=20
> >charcter drivers release() call to be forwarded to the close() called in=
=20
> >userspace. However thats not the case, the kernel swallows the release()=
=20
> >value, and always returns 0 to the userspace's close(). (tha char driver=
s=20
> >release() function is called in fput() as it would have a void return va=
lue)
> >
> >It may sound weired at first but there are actually device drivers than =
can=20
> >fail on close(), in my case it's a driver to program a LCA, the userspac=
e=20
> >application signals end of data by closing the device, the driver finali=
zes=20
> >the download, and the LCA reports if it has accepted it's new program, i=
f not=20
> >close() should return a non-zero value, indicating the operation did not=
=20
> >complete successfully.
> >
>=20
> Do you see how many places call fput() ?   Are you going to audit=20
> __all__ those paths and prove to us that changing the semantics of=20
> close(2) in Linux doesn't break things in the kernel or in userland?
>=20
> Your driver is buggy, if it thinks it can fail f_op->release.
>=20
>     Jeff

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjyaCwEACgkQcHEtmM/AAyY/7QCdFI1ygQABHDJkl74Cjosk39E4
7XgAn3wHeLcO90iMKkz7/XS9pVzY/j3e
=JXFj
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
