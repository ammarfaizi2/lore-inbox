Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268056AbTBMPMP>; Thu, 13 Feb 2003 10:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268057AbTBMPMP>; Thu, 13 Feb 2003 10:12:15 -0500
Received: from aramis.rutgers.edu ([128.6.4.2]:32479 "EHLO aramis.rutgers.edu")
	by vger.kernel.org with ESMTP id <S268056AbTBMPMM>;
	Thu, 13 Feb 2003 10:12:12 -0500
Subject: Re: O_DIRECT foolish question
From: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
To: Andrew Morton <akpm@digeo.com>
Cc: cw@f00f.org, linux-kernel@vger.kernel.org
In-Reply-To: <20030212211221.3f73ba45.akpm@digeo.com>
References: <20030212140338.6027fd94.akpm@digeo.com>
	 <1045088991.4767.85.camel@urca.rutgers.edu>
	 <20030212224226.GA13129@f00f.org>
	 <1045090977.21195.87.camel@urca.rutgers.edu>
	 <20030212232443.GA13339@f00f.org>
	 <1045092802.4766.96.camel@urca.rutgers.edu>
	 <20030212233846.GA13540@f00f.org>
	 <1045093775.21195.99.camel@urca.rutgers.edu>
	 <20030212235130.GA13629@f00f.org>
	 <1045094589.4767.106.camel@urca.rutgers.edu>
	 <20030213001302.GA13833@f00f.org>
	 <1045096579.21195.121.camel@urca.rutgers.edu>
	 <20030212211221.3f73ba45.akpm@digeo.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4cqxCqhqhCBPAvoPP7Mt"
Organization: Rutgers University
Message-Id: <1045149719.4766.126.camel@urca.rutgers.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 13 Feb 2003 10:22:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4cqxCqhqhCBPAvoPP7Mt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Thanks, Andrew. So, no chances of getting this working correctly on 2.4
kernel for now (I mean, reading files with size !=3D n*block_size), and
I'd better give up on this... Is it the case, or you think there is
still something to do to get this working on ext2 and 2.4 kernel?

Bruno.

On Thu, 2003-02-13 at 00:12, Andrew Morton wrote:
> Bruno Diniz de Paula <diniz@cs.rutgers.edu> wrote:
> >
> > On Wed, 2003-02-12 at 19:13, Chris Wedgwood wrote:
> > > If I had to guess, write should work more or less the same as reads
> > > (ie. I should be able to write aligned-but-smaller-than-page-sized
> > > blocks to the end of files).
> > >=20
> > > Testing this however shows this is *not* the case.
> >=20
> > This is not the case, I have also tested here and the file written has
> > n*block_size always. The problem with writing is that we can't sign to
> > the kernel that the actual data has finished and from that point on it
> > should zero-fill the bytes. And what is worse, the information about th=
e
> > actual size is lost, since the write syscall will store what is passed
> > on the 3rd argument in the inode (field st_size of stat). This means
> > that after writing using O_DIRECT we can't read data correctly anymore.
> > The exception is when we write together with the data information about
> > the actual size and process disregarding information from stat, for
> > instance.
> >=20
> > Well, I am sure I am completely wrong because this doesn't make any
> > sense for me. Someone that has already dealt with this and can bring a
> > light to the discussion?
> >=20
>=20
> For writes, I don't think it is reasonable for the kernel to be have to
> handle byte-granular appends.  O_DIRECT is different.  For this case the
> application should ftruncate the file back to the desired size prior to
> closing it.
>=20
> For the short reads at EOF, the 2.4 kernel refuses to read anything, and
> returns zero.  The 2.5 kernel will return -EINVAL, which is better behavi=
our
> (shouldn't make it just look like the file is shorter than it really is).
>=20
> The ideal behaviour is that which I mistakenly described previously: we
> should fill with zeroes and return the partial result.  I'll look at
> converting 2.5 to do that.  As long as the changes are small - the direct=
-io
> code does a ton of stuff, is complex, is not tested a lot and breakage te=
nds
> to be subtle.
--=20
Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Rutgers University

--=-4cqxCqhqhCBPAvoPP7Mt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+S7gXZGORSF4wrt8RAnrnAKCMcX/efG6/QHZtxRivhYkzDqNgogCfTD0S
C+kJ69plgLAZO1TPMKNlYnw=
=4qEQ
-----END PGP SIGNATURE-----

--=-4cqxCqhqhCBPAvoPP7Mt--

