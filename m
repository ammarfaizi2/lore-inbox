Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVBCL6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVBCL6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbVBCLtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:49:31 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:56580 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S263622AbVBCLrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:47:45 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       michal@logix.cz, "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Xine.LNX.4.44.0502021728140.5000-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0502021728140.5000-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZgD0vFQZ8V8IuBm3gxeC"
Date: Thu, 03 Feb 2005 12:47:41 +0100
Message-Id: <1107431261.15236.29.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZgD0vFQZ8V8IuBm3gxeC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-02 at 17:46 -0500, James Morris wrote:
> On Sun, 30 Jan 2005, Fruhwirth Clemens wrote:

> > +#define scatterwalk_needscratch(walk, nbytes) 						\
> > +	((nbytes) <=3D (walk)->len_this_page &&						\
> > +	    (((unsigned long)(walk)->data) & (PAGE_CACHE_SIZE - 1)) + (nbytes=
) <=3D	\
> > +	    PAGE_CACHE_SIZE)								\
>=20
> This should be a static inline.

First attempt:

static inline int scatterwalk_needscratch(struct scatter_walk *walk, int
nbytes) {
       return ((nbytes) <=3D (walk)->len_this_page &&
               (((unsigned long)(walk)->data) & (PAGE_CACHE_SIZE - 1)) +
(nbytes) <=3D PAGE_CACHE_SIZE);
}

While trying to improve this unreadable monster I noticed, that=20
(((unsigned long)(walk)->data) & (PAGE_CACHE_SIZE - 1)) is always equal
to walk->offset. walk->data and walk->offset always grows together (see
scatterwalk_copychunks), and when the bitwise AND-ing of walk->data with
PAGE_CACHE_SIZE-1 would result walk->offset to be zero, in just that
moment, walk->offset is set zero (see scatterwalk_pagedone). So, better:

static inline int scatterwalk_needscratch(struct scatter_walk *walk, int
nbytes)=20
{
	return (nbytes <=3D walk->len_this_page &&
		(nbytes + walk->offset) <=3D PAGE_CACHE_SIZE);
}

Looks nicer, right? But in fact, it's redundant. walk->offset is never
intended to grow bigger than PAGE_CACHE_SIZE, and further it's illegal
to hand cryptoapi a scatterlist, where sg->offset is greater than
PAGE_CACHE_SIZE (I presume this from the calculations in
scatterwalk_start). Are these two conclusions correct, James?=20

If so, I can drop the redundant expression, and probably drop the entire
function, as it becomes trivial then. Dropping the check shows no
regressions btw.
--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-ZgD0vFQZ8V8IuBm3gxeC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCAg9cW7sr9DEJLk4RApJGAJwIKcjTA4r/2pJ5OdPQjNDFFMNQOACaAkOk
9c2CJYfxpXC0ZDXx7Q/yzL8=
=h0xq
-----END PGP SIGNATURE-----

--=-ZgD0vFQZ8V8IuBm3gxeC--
