Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVDZGgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVDZGgg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 02:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbVDZGgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 02:36:36 -0400
Received: from user-edvans3.msk.internet2.ru ([217.25.93.4]:42685 "EHLO
	vocord.com") by vger.kernel.org with ESMTP id S261344AbVDZGgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 02:36:32 -0400
Subject: Re: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: dtor_core@ameritech.net
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <d120d500050425132250916bcb@mail.gmail.com>
References: <200504210207.02421.dtor_core@ameritech.net>
	 <1114089504.29655.93.camel@uganda>
	 <d120d50005042107314cbacdea@mail.gmail.com>
	 <1114420131.8527.52.camel@uganda>
	 <d120d50005042509326241a302@mail.gmail.com>
	 <20050426001500.6a199399@zanzibar.2ka.mipt.ru>
	 <d120d500050425132250916bcb@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-O51ZvYCQEpaBFyj7zYSN"
Organization: MIPT
Date: Tue, 26 Apr 2005 10:43:36 +0400
Message-Id: <1114497816.8527.66.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 26 Apr 2005 10:36:09 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-O51ZvYCQEpaBFyj7zYSN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-04-25 at 15:22 -0500, Dmitry Torokhov wrote:
> On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > While thinking about locking schema
> > with respect to sysfs files I recalled,
> > why I implemented such a logic -
> > now one can _always_ remove _any_ module
> > [corresponding object is removed from accessible
> > pathes and waits untill all exsting users are gone],
> > which is very good - I really like it in networking model,
> > while with whole device driver model
> > if we will read device's file very quickly
> > in several threads we may end up not unloading it at all.
>=20
> I am sorrry, that is complete bull*. sysfs also allows removing
> modules at an arbitrary time (and usually without annoying "waiting
> for refcount" at that)... You just seem to not understand how driver
> code works, thus the need of inventing your own schema.

Ok, let's try again - now with explanation,=20
since it looks like you did not even try to understand what I said.
If you will remove objects from ->remove() callback
you may end up with rmmod being stuck.
Explanation: each read still gets reference counter,=20
while in rmmod path there is a wait until it is zero.
If there are too many simultaneous reads - even
if each will put reference counter at the end, we still can have
non zero refcnt each time we check it in rmmod path.
That is why object must be removed from accessible pathes
first, and only freed in ->remove() callback.

> BTW, I am looking at the connector code ATM and I am just amazed at
> all wied refounting stuff that is going on there. what a single
> actomic_dec_and_test() call without checkng reurn vaue is supposed to
> do again?

It has explicit barrieres, which guarantees that
there will not be atomic operation vs. non atomic
reordering.=20

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-O51ZvYCQEpaBFyj7zYSN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCbeMYIKTPhE+8wY0RAi3kAJ4wGAKdNeAMumqVFB5xhO5MhJKZDwCfVHbj
CDbMlO9NGJTD++tqdz1HGc0=
=RC+z
-----END PGP SIGNATURE-----

--=-O51ZvYCQEpaBFyj7zYSN--

