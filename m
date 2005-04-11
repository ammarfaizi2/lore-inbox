Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVDKLRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVDKLRR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 07:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVDKLRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 07:17:17 -0400
Received: from dea.vocord.ru ([217.67.177.50]:55168 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261776AbVDKLRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 07:17:08 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Thomas Graf <tgraf@suug.ch>
Cc: jamal <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, jmorris@redhat.com,
       ijc@hellion.org.uk, guillaume.thouvenin@bull.net, greg@kroah.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       netdev <netdev@oss.sgi.com>
In-Reply-To: <20050411104550.GK26731@postel.suug.ch>
References: <1112942924.28858.234.camel@uganda>
	 <E1DKZ7e-00070D-00@gondolin.me.apana.org.au>
	 <20050410143205.18bff80d@zanzibar.2ka.mipt.ru>
	 <1113131325.6994.66.camel@localhost.localdomain>
	 <20050410153757.104fe611@zanzibar.2ka.mipt.ru>
	 <20050410121005.GF26731@postel.suug.ch>
	 <20050410161549.3abe4778@zanzibar.2ka.mipt.ru>
	 <1113143959.1089.316.camel@jzny.localdomain>
	 <20050410192727.GI26731@postel.suug.ch> <20050411092228.A32699@2ka.mipt.ru>
	 <20050411104550.GK26731@postel.suug.ch>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vzWhPJXCUTTEheqMzsZW"
Organization: MIPT
Date: Mon, 11 Apr 2005 15:19:53 +0400
Message-Id: <1113218393.16303.13.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 11 Apr 2005 15:13:05 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vzWhPJXCUTTEheqMzsZW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-04-11 at 12:45 +0200, Thomas Graf wrote:
> * Evgeniy Polyakov <20050411092228.A32699@2ka.mipt.ru> 2005-04-11 09:22
> > On Sun, Apr 10, 2005 at 09:27:27PM +0200, Thomas Graf (tgraf@suug.ch) w=
rote:
> > > +       size =3D NLMSG_SPACE(sizeof(*msg) + msg->len);
> > > +
> > > +       skb =3D alloc_skb(size, GFP_ATOMIC);
> > > +       if (!skb) {
> > > +               printk(KERN_ERR "Failed to allocate new skb with size=
=3D%u.\n", size);
> > > +               return;
> > > +       }
> > > +
> > > +       nlh =3D NLMSG_PUT(skb, 0, msg->seq, NLMSG_DONE, size - sizeof=
(*nlh));
> > >=20
> > > This is not correct, what happens is:
> > > size =3D NLMSG_SPACE(sizeof(*msg) + msg->len);
> > >  --> align(hdr)+align(data)
> > > size - sizeof(*nlh)
> > >  --> (align(hdr)-hdr)+align(data)
> > > NLMSG_PUT pads again to get to the end of the data block (NLMSG_LENGT=
H)
> > >  --> align(hdr)+(align(hdr)-hdr)+align(data)
> > >=20
> > > At the moment align(hdr) =3D=3D hdr since nlmsghdr is already aligned
> > > but this might change and your code will break.
> >=20
> > As far as I remember, header is always supposed to be aligned properly
> > "by design", so it even could be nonaligned here.
>=20
> No, have a look at the macros:
>=20
> #define NLMSG_LENGTH(len) ((len)+NLMSG_ALIGN(sizeof(struct nlmsghdr)))
> #define NLMSG_SPACE(len) NLMSG_ALIGN(NLMSG_LENGTH(len))
>=20
> NLMSG_LENGTH points to the end of the payload in the message, NLMSG_SPACE
> represents the total size aligned properly for a possible next multipart
> message.
>=20
> It is unlikely that nlmsghdr will ever be unaligned but there can be no
> reason to introduce code that can break with perfectly legal changes just
> because of that.

But NLMSG_ALIGN(sizeof(hdr)) is always equal to sizeof(hdr), that size
was select not accidentally.

I will change it, no problem, it is good from aesthetic point of view.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-vzWhPJXCUTTEheqMzsZW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCWl1ZIKTPhE+8wY0RAktFAJwOb5Pr2YO1WXRGX0k0MmT22wij2QCfboNE
FqAh2pJaYdFCilvLbPwvVhc=
=8sSt
-----END PGP SIGNATURE-----

--=-vzWhPJXCUTTEheqMzsZW--

