Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261998AbVANOVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbVANOVQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 09:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVANOVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 09:21:16 -0500
Received: from use.the.admin.shell.to.set.your.reverse.dns.for.this.ip ([80.68.90.107]:13319
	"EHLO irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S261998AbVANOUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 09:20:49 -0500
Subject: Re: [PATCH 1/2] CryptoAPI: prepare for processing multiple buffers
	at a time
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Michal Ludvig <michal@logix.cz>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       cryptoapi@lists.logix.cz, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0501141356310.10530@maxipes.logix.cz>
References: <Xine.LNX.4.44.0411301009560.11945-100000@thoron.boston.redhat.com>
	 <Pine.LNX.4.61.0411301722270.4409@maxipes.logix.cz>
	 <20041130222442.7b0f4f67.davem@davemloft.net>
	 <Pine.LNX.4.61.0412031353120.17402@maxipes.logix.cz>
	 <Pine.LNX.4.61.0501111805470.2233@maxipes.logix.cz>
	 <Pine.LNX.4.61.0501141356310.10530@maxipes.logix.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-q3JU4L/gSZD8Lz5fbSBh"
Date: Fri, 14 Jan 2005 15:20:46 +0100
Message-Id: <1105712446.18687.33.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q3JU4L/gSZD8Lz5fbSBh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-01-14 at 14:10 +0100, Michal Ludvig wrote:

> This patch extends crypto/cipher.c for offloading the whole chaining mode=
s
> to e.g. hardware crypto accelerators. It is much faster to let the=20
> hardware do all the chaining if it can do so.

Is there any connection to Evgeniy Polyakov's acrypto work? It appears,
that there are two project for one objective. Would be nice to see both
parties pulling on one string.

> +	void (*cia_ecb)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> +			size_t nbytes, int encdec, int inplace);
> +	void (*cia_cbc)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> +			size_t nbytes, int encdec, int inplace);
> +	void (*cia_cfb)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> +			size_t nbytes, int encdec, int inplace);
> +	void (*cia_ofb)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> +			size_t nbytes, int encdec, int inplace);
> +	void (*cia_ctr)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> +			size_t nbytes, int encdec, int inplace);

What's the use of adding mode specific functions to the tfm struct? And
why do they all have the same function type? For instance, the "iv" or
"inplace" argument is meaningless for ECB.

Have a look at
http://clemens.endorphin.org/patches/lrw/2-tweakable-cipher-interface.diff

This patch takes the following approach to handle the=20
cipher mode/interface issue:

Every mode is associated with one or more interfaces. This interface is
either cit_encrypt, cit_encrypt_iv, or cit_encrypt_tweaks. How these
interfaces are associated with cipher modes, is handled in
crypto_init_cipher_flags.=20

Except for CBC, every mode associates with just one interface. In CBC,
the CryptoAPI caller can use the IV interface to supply an IV, or use
the current tfm's IV by using cit_encrypt instead of cit_encrypt_iv.

I don't see a gain to through dozens of pointers into the tfm, as a tfm
is always assigned a single mode.
=20
>  /*
>   * Generic encrypt/decrypt wrapper for ciphers, handles operations acros=
s
> @@ -47,22 +101,101 @@ static inline void xor_128(u8 *a, const=20
>  static int crypt(struct crypto_tfm *tfm,
>  		 struct scatterlist *dst,
>  		 struct scatterlist *src,
> -                 unsigned int nbytes, cryptfn_t crfn,
> -                 procfn_t prfn, int enc, void *info)

Your patch heavily interferes with my cleanup patch for crypt(..). To
put it briefly, I consider crypt(..) a mess. The function definition of
crypto and the procfn_t function is just a patchwork of stuff, added
when needed.=20

I've rewritten a generic scatterwalker, that's a generic replacement for
crypto, that can apply any processing function with arbitrary argument
length to the data associated with a set of scatterlists. I think this
function shouldn't be in crypto/ but in some more generic location, as I
think it could be useful for much more things.=20

http://clemens.endorphin.org/patches/lrw/1-generic-scatterwalker.diff
is the generic scatterwalk patch.=20

int scatterwalk_walker_generic(void (function)(void *priv, int length,
void **buflist), void *priv, int steps, int nsl, ...)=20

"function" is applied to the scatterlist data.=20
"priv" is a private data structure for bookkeeping. It's supplied to the
function as first parameter.
"steps" is the number of times function is called.
"nsl" is the number of scatterlists following.

After "nsl", the scatterlists follow in a tuple of data:
<struct scatterlist *, int steplength, int ioflag>

ECB, for example:
	...
struct ecb_process_priv priv =3D {=20
	.tfm =3D tfm,
	.crfn =3D tfm->__crt_alg->cra_cipher.cia_decrypt,
};
int bsize =3D crypto_tfm_alg_blocksize(tfm);
scatterwalk_walker_generic(ecb_process_gw, 	// processing function
	&priv,		// private data
	nbytes/bsize,	// number of steps
	2, 		// number of scatterlists
	dst, bsize, 1, 	// first, ioflag set to output
	src, bsize, 0);	// second, ioflag set to input

..
static void ecb_process_gw(void *_priv, int nsg, void **buf)=20
{
	struct ecb_process_priv *priv =3D (struct ecb_process_priv *)_priv;
	char *dst =3D buf[0];	// pointer to correctly kmapped and copied dst
	char *src =3D buf[1];	// pointer to correctly kmapped and copied src
	priv->crfn(crypto_tfm_ctx(priv->tfm), dst, src);
}

Well, I recognize that I'm somehow off-topic now. But, it demonstrates
clearly, why we should get rid of crypt(..) and replace it with
something more generic.

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-q3JU4L/gSZD8Lz5fbSBh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB59U+W7sr9DEJLk4RAqd1AJ45m9g+sTpzgXtqX37B3xkmDRVjbwCgjORi
01LK6eMqtL4YFLYrowFYQBI=
=PkDL
-----END PGP SIGNATURE-----

--=-q3JU4L/gSZD8Lz5fbSBh--
