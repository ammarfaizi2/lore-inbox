Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbVDGKHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbVDGKHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 06:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbVDGKG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 06:06:59 -0400
Received: from dea.vocord.ru ([217.67.177.50]:50923 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261281AbVDGKGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 06:06:39 -0400
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: guillaume.thouvenin@bull.net, greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050407013213.7bdb083e.akpm@osdl.org>
References: <1112859412.18360.31.camel@frecb000711.frec.bull.fr>
	 <1112860419.28858.76.camel@uganda> <20050407005852.36a1264b.akpm@osdl.org>
	 <1112862232.28858.102.camel@uganda> <20050407013213.7bdb083e.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-y6zbqanBX/1YQ765z6sh"
Organization: MIPT
Date: Thu, 07 Apr 2005 14:12:48 +0400
Message-Id: <1112868768.28858.156.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 07 Apr 2005 14:05:57 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y6zbqanBX/1YQ765z6sh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-07 at 01:32 -0700, Andrew Morton wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > >=20
> > > Plus, I'm still quite unsettled about the whole object lifecycle
> > > management, refcounting and locking in there.  The fact that the code=
 is
> > > littered with peculiar barriers says "something weird is happening he=
re",
> > > and it remains unobvious to me why such a very common kernel pattern =
was
> > > implemented in such an unusual manner.
> > >=20
> > > So.  I'd like to see the whole thing reexplained and resubmitted so w=
e can
> > > think about it all again.
> >=20
> > All those barriers can be replaced with atomic_dec_and_test(),=20
>=20
> What a shame you didn't say atomic_dec_and_lock()...

Oops...

> > i.e. with something that returns the value.
> > Methods that return value requires explicit barriers.
> >=20
> > Actually there are quite many places where we have:
> >=20
> > cpu0                             cpu1
> > use object
> > atomic_dec()
> >                                  if atomic_read/atomic_dec_and_test =3D=
=3D 0
> >                                     free object.
>=20
> Yes, but those places normally also use locking to prevent the obvious ra=
ce.

In case of connector all free/remove/destroy places=20
can be accessed only after appropriate object is unlinked
and no new work [only that work remains that already incremented the
counter]
can be assigned to the object.
It was design goal [the same is true for w1, superio, acrypto]
to create such a lifecycle:
object is created
work is assigned with atomical refcnt incrementing
object is "scheduled"[1] to be removed
object is destroyed if it is not used [i.e. it's refcnt is zero].

[1]: "scheduled" means that work [removal in our case] can be done not=20
now, but after some condition, like refcnt zeroing.

> Yes, atomic_dec_and_test() and barrier removal would be better.  Especial=
ly
> if it's associated with code commentary which explains why the whole thin=
g
> isn't racy (ie: explains why no other CPU can look this object up).

atomic_dec_and_test() is more expensive than 2 barriers + atomic_dec(),
but in case of connector I think the price is not so high.

Should questionable design notes be described in in-source
documentation=20
or patch description is enough?

> > > Which comments were not addressed?
> >=20
> > CBUS code comments [I did not get ack on CBUS itself], and two below
> > issues.
>=20
> I continue to not see any point in cbus.  It moves work from one place to
> another while increasing the amount of code and quite probably increasing
> the net amount of work too.

Ok.

Cache utilisation and ability to send events from any context
and under the locks are significant issues which are solved in CBUS,=20
but they are not the most important reasons.

Ability to not slow down fast pathes - that is the main reason.

Concider situation when one may want to have notification
of each new write system call - let's say without such
notification it took about 1 second to write one page from userspace,
now with notification sending, which is not so fast, it will take
1.5 seconds, but with CBUS write() still costs 1 second plus
later, when we do not care about writing performance and scheduler
decides to run CBUS thread, those notifications will take additional
0.5 seconds to be delivered.

But if one requires not delayed fact of the notification, but
almost immediate event - one can still use direct connector's methods.

So the main usage case for CBUS is sutuations when we do not want=20
to slow process down just to send notification about it,=20
instead we can create such a notification, and deliver it later.

It is design issue - queue events in fast pathes, lock contexts,=20
irq [soft irq] contexts and safely send them later.

It also provides better controlling mechanism over messages to be sent -
using limited number of messages to be sent in a time,=20
CBUS smoothes shape peaks which are created by huge amount of
notification
to be send in a time.

> IOW it looks like a net loss which happens to provide gains in one rather
> uninteresting microbenchmark.

No messages were lost during tests,
since there were no OOM condition [atomic allocation never fails]
and userspace application read it's socket queue properly,
so socket queue and thus connector was not starved by userspace.

That benchmark showed that CBUS/connector does not slow down fast
fork() path while delivering messages, and all notifications about
forks were delivered.

=46rom your point of view it is better to complete notification work
before event itself is finished, but you definitely want to
queue block requests before they reach low-level device driver,
and queue skbs but not process them in receive IRQ handler.

Last two cases are created exactly for not slowing down fast path,
so other fast events [new interrupts] may occure and all them=20
[and the real work can be done] can be processed later.

> I'll gleefully admit that I'm wrong, but I don't think that has been
> demonstrated yet.
>=20
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-y6zbqanBX/1YQ765z6sh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCVQegIKTPhE+8wY0RArUxAJwP27O7L7q9h3eF+r0pE95WbTQzNwCglimz
RkJMlw3buvsoZqjawWslvgE=
=iIEo
-----END PGP SIGNATURE-----

--=-y6zbqanBX/1YQ765z6sh--

