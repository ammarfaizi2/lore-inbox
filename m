Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbVAOMqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVAOMqB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 07:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbVAOMqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 07:46:01 -0500
Received: from use.the.admin.shell.to.set.your.reverse.dns.for.this.ip ([80.68.90.107]:42505
	"EHLO irulan.endorphin.org") by vger.kernel.org with ESMTP
	id S262271AbVAOMpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 07:45:40 -0500
Subject: Re: [PATCH 1/2] CryptoAPI: prepare for processing multiple buffers
	at a time
From: Fruhwirth Clemens <clemens@endorphin.org>
To: Michal Ludvig <michal@logix.cz>
Cc: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       cryptoapi@lists.logix.cz, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0501141709250.17481@maxipes.logix.cz>
References: <Xine.LNX.4.44.0411301009560.11945-100000@thoron.boston.redhat.com>
	 <Pine.LNX.4.61.0411301722270.4409@maxipes.logix.cz>
	 <20041130222442.7b0f4f67.davem@davemloft.net>
	 <Pine.LNX.4.61.0412031353120.17402@maxipes.logix.cz>
	 <Pine.LNX.4.61.0501111805470.2233@maxipes.logix.cz>
	 <Pine.LNX.4.61.0501141356310.10530@maxipes.logix.cz>
	 <1105712446.18687.33.camel@ghanima>
	 <Pine.LNX.4.61.0501141709250.17481@maxipes.logix.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XApFMbo5IVPs47fQe/OQ"
Date: Sat, 15 Jan 2005 13:45:37 +0100
Message-Id: <1105793137.16065.17.camel@ghanima>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XApFMbo5IVPs47fQe/OQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-01-14 at 17:40 +0100, Michal Ludvig wrote:=20
> > Is there any connection to Evgeniy Polyakov's acrypto work? It appears,
> > that there are two project for one objective. Would be nice to see both
> > parties pulling on one string.
>=20
> These projects do not compete at all. Evgeniy's work is a complete=20
> replacement for current cryptoapi and brings the asynchronous=20
> operations at the first place. My patches are simple and straightforward=20
> extensions to current cryptoapi that enable offloading the chaining to=20
> hardware where possible.

Fine, I just saw in Evgeniy's reply, that he took your padlock
implementation. I thought both of you have been working on different
implementations.=20

But actually both aim for the same goal. Hardware crypto-offloading.
With padlock the need for a async interface isn't that big, because it's
not "off-loading" as it's done on the same chip and in the same thread.=20

However, developing two different APIs isn't particular efficient. I
know, at the moment there isn't much choice, as J.Morris hasn't commited
to acrypto in anyway. But I think it would be good to replace the
synchronized CryptoAPI implementation altogether, put the missing
internals of CryptoAPI into acrypto, and back the interfaces of
CryptoAPI with small stubs, that do like

somereturnvalue synchronized_interface(..) {
	acrypto_kick_some_operation(acrypto_struct);
	wait_for_completion(acrypto_struct);
	return fetch_result(acrypto_struct);
}

The other way round, a asynchron interface using a synchronized
interface doesn't seem natural to me.
(That doesn't mean I oppose your patches, merely that we should start to
think in different directions)

> > > +	void (*cia_ecb)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> > > +			size_t nbytes, int encdec, int inplace);
> > > +	void (*cia_cbc)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> > > +			size_t nbytes, int encdec, int inplace);
> > > +	void (*cia_cfb)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> > > +			size_t nbytes, int encdec, int inplace);
> > > +	void (*cia_ofb)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> > > +			size_t nbytes, int encdec, int inplace);
> > > +	void (*cia_ctr)(void *ctx, u8 *dst, const u8 *src, u8 *iv,
> > > +			size_t nbytes, int encdec, int inplace);
> >=20
> > What's the use of adding mode specific functions to the tfm struct? And
> > why do they all have the same function type? For instance, the "iv" or
> > "inplace" argument is meaningless for ECB.
>=20
> The prototypes must be the same in my implementation, because in crypt()=20
> only a pointer to the appropriate mode function is taken and further used=
=20
> as "(func*)(arg, arg, ...)".
>=20
> BTW these functions are not added to "struct crypto_tfm", but to "struct=20
> crypto_alg" which describes what a particular module supports (i.e. along=
=20
> with the block size, algorithm name, etc). In this case it can say that=20
> e.g. padlock.ko supports encryption in CBC mode in addition to a common=20
> single-block processing.

Err, right. I overlooked that it's cia and not cit. However, I don't
like the idea of extending structs when there is a new cipher mode. I
think the API should not have to be extended for every addition, but
should be designed for such extension right from the start.

What about a "selector" function, which returns the appropriate
encryption function for a mode?

typedef void (procfn_t)(struct crypto_tfm *, u8 *,
                        u8*, cryptfn_t, int enc, void *, int);

put=20
	procfn_t (*cia_modesel)(u32 function, int iface, int encdec);
into struct crypto_alg;

then in crypto_init_cipher_ops, instead of

	switch (tfm->crt_cipher.cit_mode) {
..
	case CRYPTO_TFM_MODE_CFB:
        	ops->cit_encrypt =3D cfb_encrypt;
		ops->cit_decrypt =3D cfb_decrypt;
..
}
we do,
	struct cipher_alg *cia =3D &tfm->__crt_alg->cra_cipher;
=09
	switch (tfm->crt_cipher.cit_mode) {
..
		case CRYPTO_TFM_MODE_CFB:
			ops->cit_encrypt =3D cia->cia_modesel(cit_mode, 0, IFACE_ECB);
			ops->cit_decrypt =3D cia->cia_modesel(cit_mode, 1, IFACE_ECB);
			ops->cit_encrypt_iv =3D cia->cia_modesel(cit_mode, 0, IFACE_IV);
			ops->cit_decrypt_iv =3D cia->cia_modesel(cit_mode, 1, IFACE_IV);
..

Alternatively, we could also add a lookup table. But I like this better,
since this is much easier to read for people, and tfm's aren't alloced
that often.

Probably, we can add a wrapper for cia_modesel, that when cia_modesel is
NULL, it falls back to the old behaviour. This way, we don't have to
patch all algorithm implementations to include cia_modesel.

How you like that idea?

--=20
Fruhwirth Clemens <clemens@endorphin.org>  http://clemens.endorphin.org

--=-XApFMbo5IVPs47fQe/OQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB6RBxW7sr9DEJLk4RAn3zAJ939GNhTSNdYh4hvlhcB77zR2G2wwCePUx6
G0Shbw9Ud5+m5FSGpcxT5K8=
=6EbM
-----END PGP SIGNATURE-----

--=-XApFMbo5IVPs47fQe/OQ--
