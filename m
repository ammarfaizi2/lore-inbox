Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbVL2JGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbVL2JGG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 04:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbVL2JGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 04:06:05 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:14310 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965109AbVL2JGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 04:06:04 -0500
From: Chris White <chriswhite@gentoo.org>
Organization: Gentoo Linux
To: Anderson Lizardo <anderson.lizardo@indt.org.br>
Subject: Re: [patch 3/5] Add MMC password protection (lock/unlock) support V2
Date: Thu, 29 Dec 2005 18:07:11 +0900
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk,
       "Russell King - ARM Linux" <linux@arm.linux.org.uk>,
       David Brownell <david-b@pacbell.net>, Tony Lindgren <tony@atomide.com>,
       Anderson Briglia <anderson.briglia@indt.org.br>,
       Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
References: <20051228184014.571997000@localhost.localdomain> <20051228185412.736374000@localhost.localdomain>
In-Reply-To: <20051228185412.736374000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1271187.dYOYjQ24lb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512291807.16111.chriswhite@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1271187.dYOYjQ24lb
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 29 December 2005 03:40, Anderson Lizardo wrote:

Something that sort of caught my eye while looking at this (I generally don=
't=20
post here so I'm bitting the bullet and hoping I don't screw up), it seems=
=20
that this is an experimental driver, but doesn't contain any sort of unique=
ly=20
seperated verbose debug information.  Let me try and narrow that down:

> +int mmc_key_instantiate(struct key *key, const void *data, size_t datale=
n)
> +{
> +	struct mmc_key_payload *mpayload;
> +	struct device *dev;
> +	struct mmc_card *card;
> +	int ret;
> +
> +	ret =3D -EINVAL;
> +	if (datalen <=3D 0 || datalen > MMC_KEYLEN_MAXBYTES || !data)
> +		goto error;

Right here something about the data being passed to the function is invalid.

> +	ret =3D key_payload_reserve(key, datalen);
> +	if (ret < 0)
> +		goto error;
> +
> +	ret =3D -ENOMEM;
> +	mpayload =3D kmalloc(sizeof(*mpayload) + datalen, GFP_KERNEL);
> +	if (!mpayload)
> +		goto error;

Unable to allocate mpayload structure, or something of the like.

> +	/* attach the data */
> +	mpayload->datalen =3D datalen;
> +	memcpy(mpayload->data, data, datalen);
> +	rcu_assign_pointer(key->payload.data, mpayload);
> +
> +	ret =3D -EINVAL;
> +	dev =3D bus_find_device(&mmc_bus_type, NULL, NULL, mmc_match_lockable);
> +	if (!dev)
> +		goto error;

Unable to locate device.

> +	card =3D dev_to_mmc_card(dev);
> +	if (mmc_card_locked(card)) {
> +		ret =3D mmc_lock_unlock(card, key, MMC_LOCK_MODE_UNLOCK);
> +		mmc_remove_card(card);
> +		mmc_register_card(card);
> +	} else
> +		ret =3D mmc_lock_unlock(card, key, MMC_LOCK_MODE_SET_PWD);
> +	if (ret)
> +		ret =3D -EKEYREJECTED;

Key was rejected, though I suppose EKEYREJECTED pretty much states that.

[snip snip]
> +
> +/*
> + * update a mmc key
> + * - the key's semaphore is write-locked
> + */
> +int mmc_key_update(struct key *key, const void *data, size_t datalen)
> +{
> +	struct mmc_key_payload *mpayload, *zap;
> +	struct device *dev;
> +	struct mmc_card *card;
> +	int ret;
> +
> +	ret =3D -EINVAL;
> +	if (datalen <=3D 0 || datalen > MMC_KEYLEN_MAXBYTES || !data)
> +		goto error;

See above about invalid data

> +	/* construct a replacement payload */
> +	ret =3D -ENOMEM;
> +	mpayload =3D kmalloc(sizeof(*mpayload) + datalen, GFP_KERNEL);
> +	if (!mpayload)
> +		goto error;

This code almost seemed similiar to mmc_key_instantiate.. I almost wonder i=
f=20
the code could be consolidated into a single function with some sort of=20
update conditional code.  With that the debug information wouldn't be=20
duplicated. so snip

> +#ifdef	CONFIG_MMC_PASSWORDS
> +		else {
> +			ret =3D register_key_type(&mmc_key_type);
> +			if (ret) {

Something about the registration failing.

> +				class_unregister(&mmc_host_class);
> +				bus_unregister(&mmc_bus_type);
> +			}
> +		}
> +#endif
>  	}
>  	return ret;
>  }
> @@ -345,6 +501,9 @@ static void __exit mmc_exit(void)
>  {
>  	class_unregister(&mmc_host_class);
>  	bus_unregister(&mmc_bus_type);
> +#ifdef	CONFIG_MMC_PASSWORDS
> +	unregister_key_type(&mmc_key_type);
> +#endif
>  }
>
>  module_init(mmc_init);

That was mainly it.  The verbose debug information is more of a "this would=
 be=20
nice" sort of thing.  Just from a user's perspective of debuggin experiment=
al=20
drivers, this sort of thing is always nice.  The code duplication in=20
mmc_key_instantiate/update still catches my eye though, there may be a=20
functional code flow to this that I'm not aware of, so again I bite the=20
bullet.  Best hope that I don't make a fool of myself :).

Chris White

--nextPart1271187.dYOYjQ24lb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDs6dEFdQwWVoAgN4RAuidAKC02+5PhZ+iid72/LBN5KwD7+ChBgCgkt2h
84Nen47D/vlEHDH7+bzBz38=
=xSjD
-----END PGP SIGNATURE-----

--nextPart1271187.dYOYjQ24lb--
