Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVDZG7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVDZG7s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 02:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261366AbVDZG7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 02:59:48 -0400
Received: from user-edvans3.msk.internet2.ru ([217.25.93.4]:60868 "EHLO
	vocord.com") by vger.kernel.org with ESMTP id S261364AbVDZG72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 02:59:28 -0400
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <200504260150.00948.dtor_core@ameritech.net>
References: <200504210207.02421.dtor_core@ameritech.net>
	 <d120d500050425132250916bcb@mail.gmail.com>
	 <1114497816.8527.66.camel@uganda>
	 <200504260150.00948.dtor_core@ameritech.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IHJt15E9uZek4eUmqNza"
Organization: MIPT
Date: Tue, 26 Apr 2005 11:06:42 +0400
Message-Id: <1114499202.8527.85.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 26 Apr 2005 10:59:12 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IHJt15E9uZek4eUmqNza
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-26 at 01:50 -0500, Dmitry Torokhov wrote:
> On Tuesday 26 April 2005 01:43, Evgeniy Polyakov wrote:
> > On Mon, 2005-04-25 at 15:22 -0500, Dmitry Torokhov wrote:
> > > On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > While thinking about locking schema
>  > > with respect to sysfs files I recalled,
> > > > why I implemented such a logic -
> > > > now one can _always_ remove _any_ module
> > > > [corresponding object is removed from accessible
> > > > pathes and waits untill all exsting users are gone],
> > > > which is very good - I really like it in networking model,
> > > > while with whole device driver model
> > > > if we will read device's file very quickly
> > > > in several threads we may end up not unloading it at all.
> > >=20
> > > I am sorrry, that is complete bull*. sysfs also allows removing
> > > modules at an arbitrary time (and usually without annoying "waiting
> > > for refcount" at that)... You just seem to not understand how driver
> > > code works, thus the need of inventing your own schema.
> >=20
> > Ok, let's try again - now with explanation,=20
> > since it looks like you did not even try to understand what I said.
> > If you will remove objects from ->remove() callback
> > you may end up with rmmod being stuck.
> > Explanation: each read still gets reference counter,=20
> > while in rmmod path there is a wait until it is zero.
> > If there are too many simultaneous reads - even
> > if each will put reference counter at the end, we still can have
> > non zero refcnt each time we check it in rmmod path.
> > That is why object must be removed from accessible pathes
> > first, and only freed in ->remove() callback.
>=20
> Please try to read the code. device_unregister and kobject_unregister
> do not require caller to wait for the last reference to drop, they rely
> on availability of release method to clean up the object when last user
> is gone. driver_unregister is blocking (like your family code) but
> teardown takes no time. If driver is in use (attributes are open) then
> module refcount is non-zero and instead of (possibly endless) "waiting fo=
r
> refcount to drop" message you will get nice -EBUSY.
>=20
> If you program so that you wait in module_exit for object release - you
> get what you deserve.=20

But we can remove objects not from rmmod path.
You pointed right example in one previous e-mail.

Using above "waiting for device..." message is for debug only.

> > > BTW, I am looking at the connector code ATM and I am just amazed at
> > > all wied refounting stuff that is going on there. what a single
> > > actomic_dec_and_test() call without checkng reurn vaue is supposed to
> > > do again?
> >=20
> > It has explicit barrieres, which guarantees that
> > there will not be atomic operation vs. non atomic
> > reordering.=20
>=20
> And you can't use explicit barriers - why exactly?

I used them - code was following:
smp_mb__before_atomic_dec();
atomic_dec();
smp_mb__after_atomic_dec();

I think simple atomic_dec_and_test() or even atomic_dec_and_lock()
is better.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-IHJt15E9uZek4eUmqNza
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCbeiCIKTPhE+8wY0RAtMKAKCQIO74iU44nByQb/toQSpFwbiZeQCfbExL
7lMvpBWL5+oe9TWQboyY3UI=
=czub
-----END PGP SIGNATURE-----

--=-IHJt15E9uZek4eUmqNza--

