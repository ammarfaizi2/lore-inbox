Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVAXXXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVAXXXz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVAXXXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:23:10 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:39948 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261728AbVAXXMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:12:44 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org,
       Michal Ludvig <michal@logix.cz>
In-Reply-To: <20050124143109.75ff1ab8.akpm@osdl.org>
References: <20050124115624.GA21457@ghanima.endorphin.org>
	 <20050124143109.75ff1ab8.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-j1I6oZ05PBNzQXbg4XoA"
Date: Tue, 25 Jan 2005 00:12:41 +0100
Message-Id: <1106608362.14058.58.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-j1I6oZ05PBNzQXbg4XoA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-01-24 at 14:31 -0800, Andrew Morton wrote:
> Fruhwirth Clemens <clemens@endorphin.org> wrote:
> >
> > This patch adds the ability for a cipher mode to store cipher mode spec=
ific
> > information in crypto_tfm. This is necessary for LRW's precomputed
> > GF-multiplication tables.
>=20
> These patches clash badly with Michael Ludvig's work:
>=20
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc2/=
2.6.11-rc2-mm1/broken-out/cryptoapi-prepare-for-processing-multiple-buffers=
-at.patch
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc2/=
2.6.11-rc2-mm1/broken-out/cryptoapi-update-padlock-to-process-multiple-bloc=
ks-at.patch
>=20
> so someone's going to have to rework things.  Ordinarily Michael would go
> first due to test coverage.

I already pointed that out to Michael. His reply was that he will look
at my tweakable extensions.

Let me bring forward a proposal to the multiblock function lookup of
Michael's patch in crypt(..)

I think this selection should be done much earlier, in
crypto_init_cipher_flags. The tfm's encrypt/decrypt interfaces (there
are three ATM, ECB, IV-based, tweak-based) should be initialized with an
appropriate pointer to a stub multiblock function, if there is one for
the given cipher mode and the given interface type.=20

Either this function is a stub like for instance my cbc_process_gw or
it's a stub for a multiblock function, that do the necessary
preprocessing (kmalloc). Both can then call the generic scatterwalker
after that. The different number of arguments are _no_ problem for the
generic scatterwalker, that's what it was designed for.

If the stub is for a software call, then we won't have to do the
somewhat expensive aligned kmalloc call, as this isn't needed for
software anyway. In the software implementation, one can set the .buf
field of the scatterwalker's walk_info to a stack based buffer, and in
the multiblock version, just do the kmalloc. My design allows any
variation.=20

That would be a way to deconcentrate the two code paths in crypt(..).

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-j1I6oZ05PBNzQXbg4XoA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB9YDoW7sr9DEJLk4RAqLvAJwKHmT1NRXjO4ymlj6b0fItxCJ8CACfVLQt
+Nx2edQPqxKAHWhjyQFfiZc=
=oRy6
-----END PGP SIGNATURE-----

--=-j1I6oZ05PBNzQXbg4XoA--
