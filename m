Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVBTWKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVBTWKq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 17:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVBTWKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 17:10:45 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:38797 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261984AbVBTWKJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 17:10:09 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] /proc/kmalloc
Date: Sun, 20 Feb 2005 22:59:33 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <20050220204743.GE3120@waste.org>
In-Reply-To: <20050220204743.GE3120@waste.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_GhQGChgj9L/tbk8";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200502202259.34156.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_GhQGChgj9L/tbk8
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnndag 20 Februar 2005 21:47, Matt Mackall wrote:
> I've been sitting on this for over a year now, kicking it out in the
> hopes that someone finds it useful. kernel.org was down when I was
> tidying this up so it's against 2.6.10 which is what I had handy.
>
> /proc/kmalloc allocation tracing

Nice. I have done something similar for the buddy allocator but never
got around to sending it.

> This quick hack adds accounting for kmalloc/kfree callers. This can
> aid in tracking down memory leaks and large dynamic memory users. The
> stock version use ~280k of memory for hash tables and can track 32k
> active allocations.
>=20
> Here's some sample output from my laptop:
>=20
> total bytes allocated: 47118848  =20
> slack bytes allocated:  8717262
> net bytes allocated:    2825920
> number of allocs:        132796
> number of frees:         122629
> number of callers:          325
> lost callers:                 0
> lost allocs:                  0
> unknown frees:                0
>=20
>    total    slack      net alloc/free  caller
>    24576        0        0     3/3     copy_thread+0x1ad

The format is not really easy to parse, it probably makes sense to
split the two parts into separate files. I also think that debugfs
would be a more appropriate place to put this in than procfs.

> +void __kmalloc_account(const void *caller, const void *addr, int size, i=
nt req)
> +{
> +	int i, hasha, hashc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&kma_lock, flags);
> +	if(req >=3D 0) /* kmalloc */
> +	{
> +		/* find callers slot */
> +		hashc =3D kma_hash(caller, MAX_CALLER_TABLE);
> +		for (i =3D 0; i < MAX_CALLER_TABLE; i++) {
> +			if (!kma_caller[hashc].caller ||
> +			    kma_caller[hashc].caller =3D=3D caller)
> +				break;
> +			hashc =3D (hashc + 1) % MAX_CALLER_TABLE;
> +		}

The housekeeping that is needed for the hash implementation is rather
complicated. The code that I wrote did a static allocation from inside
a macro, like

#define kmalloc(_size, _gfp) \
	({ \
		static struct kma_caller _caller \
			__attribute__((section(".kmalloc.data"))) =3D { \
			.func =3D __FUNCTION__, \
			.line =3D __LINE__, \
		}; \
		_caller.count++; \
		_caller.size +=3D (_size); \
		__kmalloc((_size), (_gfp)); \
	})

Then I could simply print out all allocations by walking through the
special linker section. OTOH, your implementation has the advantage
that it can directly match kmalloc/kfree pairs and that it does not
rely on special linker magic.

	Arnd <><

--Boundary-02=_GhQGChgj9L/tbk8
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCGQhG5t5GS2LDRf4RAl/QAJ9dl4cyEnBEjl9rLRDSkaDs3q+CxwCfX9iN
uEQ0FQxi29JV23p7ZBiFiT8=
=5j8Z
-----END PGP SIGNATURE-----

--Boundary-02=_GhQGChgj9L/tbk8--
