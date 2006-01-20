Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWATU5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWATU5n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 15:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWATU5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 15:57:43 -0500
Received: from smtprelay04.ispgateway.de ([80.67.18.16]:47757 "EHLO
	smtprelay04.ispgateway.de") by vger.kernel.org with ESMTP
	id S932183AbWATU5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 15:57:42 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [robust-futex-4] futex: robust futex support
Date: Fri, 20 Jan 2006 18:41:18 +0100
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, david singleton <dsingleton@mvista.com>,
       drepper@gmail.com, mingo@elte.hu
References: <43C84D4B.70407@mvista.com> <F3EB614C-8892-11DA-AF83-000A959BB91E@mvista.com> <20060118212256.1553b0ec.akpm@osdl.org>
In-Reply-To: <20060118212256.1553b0ec.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart10552536.nZsdINY3zO";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601201841.24565.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart10552536.nZsdINY3zO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 19 January 2006 06:22, Andrew Morton wrote:
> david singleton <dsingleton@mvista.com> wrote:
> > +	if (mapping->robust_head =3D=3D NULL)
> > +		return;
> > +
> > +	if (list_empty(&mapping->robust_head->robust_list))
> > +		return;
> > +
> > +	mutex_lock(&mapping->robust_head->robust_mutex);
> > +
> > +	head =3D &mapping->robust_head->robust_list;
> > +	futex_head =3D mapping->robust_head;
> > +
> > +	list_for_each_entry_safe(this, next, head, list) {
> > +		list_del(&this->list);
> > +		kmem_cache_free(robust_futex_cachep, this);
> > +	}
>=20
> If we're throwing away the entire contents of the list, there's no need to
> detach items as we go.
=20
Couldn't even detach the list elements first by

list_splice_init(&mapping->robust_head->robust_list, head);

and free the list from "head" after releasing the mutex?=20
This would reduce lock contention, no?

> > +#ifdef CONFIG_ROBUST_FUTEX
> > +	robust_futex_cachep =3D kmem_cache_create("robust_futex", sizeof(stru=
ct futex_robust), 0, 0, NULL, NULL);
> > +	file_futex_cachep =3D kmem_cache_create("file_futex", sizeof(struct f=
utex_head), 0, 0, NULL, NULL);
> > +#endif
>=20
> A bit of 80-column wrapping needed there please.
>=20
> Are futex_heads likely to be allocated in sufficient volume to justify
> their own slab cache, rather than using kmalloc()?  The speed is the same=
 -
> if anything, kmalloc() will be faster because its text and data are more
> likely to be in CPU cache.
=20
The goal here was to do cheap futex accounting, as described in the=20
documentation to this patch.


Regards

Ingo Oeser


--nextPart10552536.nZsdINY3zO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD0SDEU56oYWuOrkARAtXcAKC3W5b84Lv/Z0V9T15gDskilWb57gCgsjw4
GlemIowOqSCDn80g5XKbsMA=
=mE5B
-----END PGP SIGNATURE-----

--nextPart10552536.nZsdINY3zO--
