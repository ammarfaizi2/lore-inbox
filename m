Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVBJJsv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVBJJsv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 04:48:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVBJJsv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 04:48:51 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:63243 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S262083AbVBJJsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 04:48:47 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@redhat.com>, linux-kernel@vger.kernel.org,
       michal@logix.cz, davem@davemloft.net, adam@yggdrasil.com
In-Reply-To: <20050209171943.05e9816e.akpm@osdl.org>
References: <Xine.LNX.4.44.0502091859540.6222-100000@thoron.boston.redhat.com>
	 <1107997358.7645.24.camel@ghanima>  <20050209171943.05e9816e.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VnrkfhD6YPIHW2m9I8MQ"
Date: Thu, 10 Feb 2005 10:48:43 +0100
Message-Id: <1108028923.14335.44.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VnrkfhD6YPIHW2m9I8MQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-09 at 17:19 -0800, Andrew Morton wrote:
> Fruhwirth Clemens <clemens@endorphin.org> wrote:
> >
> > It must be
> >  possible to process more than 2 mappings in softirq context.
>=20
> Adding a few more fixmap slots wouldn't hurt anyone.  But if you want an
> arbitrarily large number of them then no, we cannot do that.

What magnitude is "few more"? 2, 10, 100?

> Taking more than one sleeping kmap at a time within the same process is
> deadlocky, btw.  You can end up with N such tasks all holding one kmap an=
d
> waiting for someone else to release one.
>=20
> Possibly one could arrange for the pages to not be in highmem at all.

Is there an easy way to bring pages to lowmem? The cryptoapi is called
from the backlog of the networking stack, which is assigned in irq
context first and processed softirq context. There is little opportunity
to bringt stuff to low mem. And we can't bringt stuff to lowmem on our
own as well, because (as I guess) this involves a page allocation, which
would have to be GFP_ATOMIC, which can fail. So we would need fallback
for the fallback mechanism, and that's still the tiny set of scratch
buffers.. hairy business..

Ok, what about the following plan:

If context =3D=3D softirq, use kmap_atomic until they all used, fall-back t=
o
scratch buffers, and printk in some DEBUG mode:"Warning slow, redesign
your client or raise the number of fixmaps".

If context =3D=3D user, use kmap_atomic until they all used, and fall-back
to kmap.

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-VnrkfhD6YPIHW2m9I8MQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCCy37bjN8iSMYtrsRAts/AJ9819t4f279DGCsIQz0O+5V7IGfCQCcDL4K
FuXIBfPbIeRevAzaZ8SySNs=
=5WQ7
-----END PGP SIGNATURE-----

--=-VnrkfhD6YPIHW2m9I8MQ--
