Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262668AbVDAJ2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbVDAJ2G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 04:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbVDAJ2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 04:28:06 -0500
Received: from dea.vocord.ru ([217.67.177.50]:4547 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262668AbVDAJ14 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 04:27:56 -0500
Subject: Re: cn_queue.c
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050401004804.52519e17.akpm@osdl.org>
References: <20050331173215.49c959a0.akpm@osdl.org>
	 <1112341236.9334.97.camel@uganda> <20050331235706.5b5981db.akpm@osdl.org>
	 <1112344811.9334.146.camel@uganda>  <20050401004804.52519e17.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PmiqlSyrqT1ddrcgNai4"
Organization: MIPT
Date: Fri, 01 Apr 2005 13:34:08 +0400
Message-Id: <1112348048.9334.174.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 13:27:29 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PmiqlSyrqT1ddrcgNai4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-01 at 00:48 -0800, Andrew Morton wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> >  New object has 0 reference counter when created.
> >  If some work is appointed to the object, then it's counter is atomical=
ly
> >  incremented. It is decremented when the work is finished.
> >  If object is supposed to be removed while some work
> >  may be appointed to it, core ensures that no work _is_ appointed,=20
> >  and atomically disallows[for example removing workqueue, removing
> >  callback, all with appropriate locks being hold]=20
> >  any other work appointment for the given object.
> >  After it [when no work can be appointed to the object] if object
> >  still has pending work [and thus has it's refcounter not zero],=20
> >  removing path waits untill appropriate refcnt hits zero.=20
> >  Since no _new_ work can be appointed at that level it is just
> >  while (atomic_read(refcnt) !=3D 0)
> >    msleep();
>=20
> More like:
>=20
> 	while (atomic_read(&obj->refcnt))
> 		msleep();
> 	kfree(obj);

Yep :)

> which introduces the possibility of someone grabbing a new ref on the
> object just before the kfree().  If there is no means by which any other
> actor can acquire a ref to this object then OK, no race.

No, object is already removed from the pathes where someone may access
it.
It is only waiting until already assigned work is finished.

> But it's rather surprising that such a thing can be achieved without any
> locking.  What happens if another CPU has just entered
> cn_queue_del_callback(), for example?  It has a live cn_callback_entry in
> `cbq' which has a zero refcount - cn_queue_free_dev() can throw it away.

cn_queue_free_dev() will wait until dev->refcnt hits zero=20
before freeing any resources,
but it can happen only after cn_queue_del_callback() does=20
it's work on given callback device [actually when all callbacks=20
are removed].
When new callback is added into device, it's refcnt is incremented
[before adition btw, if addition fails in the middle, reference is
decremented], when callbak is removed, device's reference counter
is decremented aromically after all work is finished.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-PmiqlSyrqT1ddrcgNai4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTRWPIKTPhE+8wY0RAof4AKCW6GG+kZXoPstGRZDNni6YXM0/wQCfSpMW
OoVnHgzEn9haI6BhjAq9IUE=
=d1ZW
-----END PGP SIGNATURE-----

--=-PmiqlSyrqT1ddrcgNai4--

