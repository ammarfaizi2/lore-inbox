Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261503AbSJDLWv>; Fri, 4 Oct 2002 07:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261556AbSJDLWv>; Fri, 4 Oct 2002 07:22:51 -0400
Received: from node-d-1ef6.a2000.nl ([62.195.30.246]:27886 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S261503AbSJDLWt>; Fri, 4 Oct 2002 07:22:49 -0400
Subject: Re: export of sys_call_table
From: Arjan van de Ven <arjanv@redhat.com>
To: bidulock@openss7.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021004051932.A13743@openss7.org>
References: <20021003153943.E22418@openss7.org>
	<1033682560.28850.32.camel@irongate.swansea.linux.org.uk>
	<20021003170608.A30759@openss7.org>
	<1033722612.1853.1.camel@localhost.localdomain> 
	<20021004051932.A13743@openss7.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ajfApP6n2W1JvqdSNEOU"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 13:31:27 +0200
Message-Id: <1033731087.1853.11.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ajfApP6n2W1JvqdSNEOU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-10-04 at 13:19, Brian F. G. Bidulock wrote:

> > Why ?
> > Adding "unknown" syscalls is I doubt EVER a good idea.
> > LiS has *known* and *official* syscalls, they can easily live with a
> > stub like nfsd uses.... few lines of code and it's safe.
>=20
> Well, nfsd does something like this:
>=20
> 	struct nfsd_linkage *nfsd_linkage =3D NULL;
>=20
> 	long
> 	asmlinkage sys_nfsservctl(int cmd, void *argp, void *resp)
> 	{
> 		int ret =3D -ENOSYS;
> 	=09
> 		lock_kernel();
>=20
> 		if (nfsd_linkage ||
> 		    (request_module ("nfsd") =3D=3D 0 && nfsd_linkage))
> 			ret =3D nfsd_linkage->do_nfsservctl(cmd, argp, resp);
>=20
> 		unlock_kernel();
> 		return ret;
> 	}
> 	EXPORT_SYMBOL(nfsd_linkage);
>=20
> I take it that this system call is not in nsfd's main data flow
> (probably write() and read are()).  Taking the big kernel lock is
> excessive across every putpmsg() and getpmsg() operation and would
> seriously impact LiS performance on multiple processors.  In effect,
> only one processor would run for LiS.  A reader/write lock would be
> better.

The kernel has such locks too, no big deal
>=20
> Also, LiS does not require module loading on system call, but
> (questionably) needs unloading protection -- LiS does not really
> need to unload once loaded.  This turns into something more like:
>=20
> 	static int (*do_putpmsg) (int, void *, void *, int, int) =3D NULL;
> 	static int (*do_getpmsg) (int, void *, void *, int, int) =3D NULL;
> 	static int (*do_spipe) (int *) =3D NULL;
> 	static int (*do_fattach) (int, const char *) =3D NULL;
> 	static int (*do_fdetach) (const char *) =3D NULL;
>=20
> 	static rwlock_t streams_call_lock =3D RW_LOCK_UNLOCKED;
>=20
> 	static long asmlinkage sys_putpmsg(int fd, void *ctlptr,
> 					   void *dataptr, int band, int flags)
> 	{
> 		int ret =3D -ENOSYS;
> 		read_lock(&streams_call_lock);
> 		if (do_putpmsg)
> 			ret =3D do_putpmsg(fd, ctrptr, dataptr, band, flags);
> 		read_unlock(&streams_call_lock);
> 		return ret;
> 	}

not to bad...=20

>=20
> 	static long asmlinkage sys_spipe(int *fd)
> 	{
> 		int ret =3D -ENOSYS;
> 		read_lock(&streams_call_lock);
> 		if (do_spipe)
> 			ret =3D do_spipe(fd);
> 		read_unlock(&streams_call_lock);
> 		return ret;
> 	}

ehm sys_spipe doesn't exist, neither do all but 2 of the others you
showed.


>=20
> The module (LiS or iBCS) calls register_streams_calls after it loads and =
calls
> unregister_streams_calls before it unloads.

iBCS is dead. It's called linux-abi nowadays.....
=20
> But this is repetative and doesn't solve replacement of existing
> system calls for profilers and such.

Profilers don't actually NEED this.... OProfile is fixed for this for
example in the 2.5 branch.=20

Taking over "random" unimplemented system calls really sounds bad..... I
mean, for the next minor release of the kernel Linus can assign that
number to something official and different......

Greetings,
   Arjan van de Ven




--=-ajfApP6n2W1JvqdSNEOU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9nXwPxULwo51rQBIRAjOsAKCYeFTya4OQZOGy4IFJMpl+HD1FEwCePHH7
qJYRxEMC1UBD7JAn4lk8PDQ=
=mTzl
-----END PGP SIGNATURE-----

--=-ajfApP6n2W1JvqdSNEOU--

