Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVDAH4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVDAH4w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 02:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbVDAH4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 02:56:52 -0500
Received: from dea.vocord.ru ([217.67.177.50]:48287 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262660AbVDAH4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 02:56:46 -0500
Subject: Re: connector.c
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050331234213.0c06ba71.akpm@osdl.org>
References: <20050331173026.3de81a05.akpm@osdl.org>
	 <1112339238.9334.66.camel@uganda>  <20050331234213.0c06ba71.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aO5OskQokGxx+f2IAdSJ"
Organization: MIPT
Date: Fri, 01 Apr 2005 12:03:15 +0400
Message-Id: <1112342595.9334.120.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 11:56:37 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-aO5OskQokGxx+f2IAdSJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-31 at 23:42 -0800, Andrew Morton wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > > What happens if we expect a reply to our message but userspace never =
sends
> > > one?  Does the kernel leak memory?  Do other processes hang?
> >=20
> > It is only advice, one may easily skip seq/ack initialization.
> > I could remove it totally from the header, but decided to=20
> > place it to force people to use more reliable protocols over netlink
> > by introducing such overhead.
>=20
> hm.  I don't know what that means.

Messages that are passed between agents must have only id,
but I decided to force people to use provided seq/ack fields
to store there some information about message order.
Neither kernel nor userspace requires that fields to be=20
somehow initialized.

> > > > 	nlh =3D NLMSG_PUT(skb, 0, msg->seq, NLMSG_DONE, size - sizeof(*nlh=
));
> > > >=20
> > > > 	data =3D (struct cn_msg *)NLMSG_DATA(nlh);
> > >=20
> > > Unneeded typecast.
> >=20
> > Is it really an issue?
>=20
> Well it adds clutter, but more significantly the cast defeats typecheckin=
g.
> If someone was to change NLMSG_DATA() to return something other than
> void*, the compiler wouldn't complain.
>=20
> > >=20
> > > Why is spin_lock_bh() being used here?
> >=20
> > skb may be delivered in soft irq context, and may race with sending.
> > And actually it can be sent from irq context, like it is done in test
> > module.
>=20
> But spin_lock_bh() in irq context will deadlock if interruptible context =
is
> also doing spin_lock_bh().

skbs are delivered in softirq context and, yes,
I need to exactly point that sending also must be limited to soft irq
context.

> > > What's all the above code doing?  What do `a' and `b' mean?  Needs
> > > commentary and better-chosen identifiers.
> >=20
> > It searches for idx and val to match requested notification,=20
> > if "a" is true - idx is found, if b - val is found.
>=20
> Let me rephrase: please comment the code and choose identifiers in a mann=
er
> which makes it clearer what's going on.

Sure.

> > > Please document all functions with comments.  Functions which constit=
ute
> > > part of the external API should be commented using the kernel-doc for=
mat.
> >=20
> > There is Documentation/connector/connector.txt which describes all
> > exported functions and structures.
> > Should it be ported to docbook?
>=20
> connector.txt is pitched at about the right level: an in-kernel and
> userspace API description.  It's rather unclear with respect to mesage
> directions though - whether the callback is invoked after kernel->user
> messages, or for user->kernel or what, for example.  Some clarification
> there would help. =20

Callback is invoked each time message is received - either=20
from userspace [original aim] or from kernelspace
[one can send notification request or just send a message from one=20
kernelspace subsystem to another].
Callback can also be called when notification for given idx/val range
was requested and new callback is being registered/unregistered=20
which mathces given idx/val range.

> But an API description is a different thing from code commentary which
> explains the internal design - the latter should be coupled to the code
> itself.=20

I will begin create in-code documentation after all technical issues=20
are resolved. Patches will be ready soon I think.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-aO5OskQokGxx+f2IAdSJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTQBDIKTPhE+8wY0RAkkUAJ9CWs6KqDk3RR8PN5qkWyUaKbCUEwCgjV8b
FxZ/76EMK4YJZnCFi09IZ3w=
=YIPS
-----END PGP SIGNATURE-----

--=-aO5OskQokGxx+f2IAdSJ--

