Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVA2SN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVA2SN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 13:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVA2SN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 13:13:57 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:56326 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261311AbVA2SNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 13:13:39 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Michal Ludvig <michal@logix.cz>
In-Reply-To: <Xine.LNX.4.44.0501251042020.26690-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0501251042020.26690-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1oAK91gjsdyDHgnMyPOf"
Date: Sat, 29 Jan 2005 19:13:36 +0100
Message-Id: <1107022416.25076.21.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1oAK91gjsdyDHgnMyPOf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-01-25 at 10:52 -0500, James Morris wrote:
> On Mon, 24 Jan 2005, Andrew Morton wrote:
>=20
> > These patches clash badly with Michael Ludvig's work:
> >=20
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc=
2/2.6.11-rc2-mm1/broken-out/cryptoapi-prepare-for-processing-multiple-buffe=
rs-at.patch
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc=
2/2.6.11-rc2-mm1/broken-out/cryptoapi-update-padlock-to-process-multiple-bl=
ocks-at.patch
> >=20
> > so someone's going to have to rework things.  Ordinarily Michael would =
go
> > first due to test coverage.
> >=20
> > James, your call please.  Also, please advise on the suitability of
> > Michael's patches for a 2.6.11 merge.
>
> Perhaps temporarily drop the multible block changes above until we get th=
e
> generic scatterwalk code in and a cleaned up design to handle cipher mode
> offload.

Andrew, do you agree with James on dropping this patches temporarily?
I'm running into a mess with patches for patches, and I'd be easier for
me to have my scatterwalk code in -mm to build on.

James, anything new on ipsec testing? Is there something else missing
for a "GO" from your side for scatterwalk generic?

I'm almost finished with my port of Michaels multiblock extensions, but
I run into a few single problems.

First, I'd set the bytes, a multiblock call can digest, to 4096, page
size. Why? Because, the scatterwalk code, even James original
implementation, will trigger heavy memcpy because the needscratch check
will always return true for page boundary crossing sections.

ATM max_nbytes isn't set to 4096, but to ((size_t)-1), the maximum value
of size_t. This is algorithm specific and set in padlock implementation.
(My port will drop these changes). But setting it to 4096 causes another
problem: the last fragment of a run might be shorter than 4096, but the
scatterwalk code (James and mine) wasn't designed to
change the stepsize/blocksize dynamically. Therefore, Michaels addition
to crypt(..) will wrongly process the whole last 4096 block, trashing
all data remaining data. That's not likely to break things, but the
behavior is certainly wrong.

So a lot of slippery details here. My advise is, drop Michaels patches
for now, merge scatterwalker and add an ability to change the stepsize
dynamically in the run. Then I will finish my port and post it.

If we can agree on this "agenda", I'll shift my focus to scatterwalker
testing.

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-1oAK91gjsdyDHgnMyPOf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB+9JPW7sr9DEJLk4RAgZxAKCIJ4b5D22DGq2iTkxH/NFl7c3WRACdFta2
37Qgk66Uu2UOzHeQ4c3km20=
=aFEs
-----END PGP SIGNATURE-----

--=-1oAK91gjsdyDHgnMyPOf--
