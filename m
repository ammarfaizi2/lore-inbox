Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVBJBDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVBJBDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 20:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbVBJBDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 20:03:30 -0500
Received: from irulan.endorphin.org ([80.68.90.107]:31242 "EHLO
	irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261998AbVBJBCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 20:02:40 -0500
Subject: Re: [PATCH 01/04] Adding cipher mode context information to
	crypto_tfm
From: Fruhwirth Clemens <clemens@endorphin.org>
To: James Morris <jmorris@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       michal@logix.cz, "David S. Miller" <davem@davemloft.net>,
       "Adam J. Richter" <adam@yggdrasil.com>
In-Reply-To: <Xine.LNX.4.44.0502091859540.6222-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0502091859540.6222-100000@thoron.boston.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xp7E6smbfau27jWoyRnO"
Date: Thu, 10 Feb 2005 02:02:38 +0100
Message-Id: <1107997358.7645.24.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xp7E6smbfau27jWoyRnO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-02-09 at 19:30 -0500, James Morris wrote:
> On Wed, 9 Feb 2005, Fruhwirth Clemens wrote:
>=20
> > I can't code for the case of two. Because, first, that's the idea of
> > generic in the name "generic scatterwalk", second, I need at least 3
> > scatterlists in parallel for LRW.
>=20
> Can you explain why you need a third scatterlist for the LRW tweak?

Because a tweak is different from an IV. There can be an arbitrary
number of tweaks. For instance, EME takes 1 tweak per 512 bytes. If you
have a 4k page to encrypt, you have to process 8 tweaks of whatever
size.=20
 Therefore, you need 3 scatterlists: src, dst and the running along
tweak.

However, I don't want to limit the discussion to the specific needs of
LRW or EME. I wanted to write something nice and generic for other
people to use, thus scatterwalk_walk.=20

There must be a solution to get an arbitrary number of kmappings in
softirq problem. If it's possible for 2 pages, I can't see a reason why
this ain't possible for more. The use of scratch buffers and constant
switching of kmap_atomic mapping is just ridiculously stupid.

> My understanding is that the tweak value is calculated from the disk
> position of the plaintext block and and the secondary key.

That's only partially correct. The tweak value _is_ the location on
disk. The value which is XORed twice is computed from the tweak and the
secondary key. In LRW, you need a tweak value per block. So, if you
encode 256 blocks, you need 256 tweaks. That's what the additional
scatterlist is for.

> It would be useful to see the original patch (which seems to be
> unavailable now), with dm-crypt integration, to see how the entire
> mechanism works beyond the test vectors.

Frankly, I don't see a point escalating this discussion. It must be
possible to process more than 2 mappings in softirq context. If not, I
feel emotionally offended.
--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-xp7E6smbfau27jWoyRnO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCCrKubjN8iSMYtrsRAnTSAJ9g3mHc2YnXUoStXh45saa5XTwyugCfd16q
tuNXG2JEl7412TD+Wf37UmE=
=j8Eh
-----END PGP SIGNATURE-----

--=-xp7E6smbfau27jWoyRnO--
