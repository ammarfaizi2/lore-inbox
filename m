Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVDALJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVDALJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 06:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262710AbVDALJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 06:09:28 -0500
Received: from dea.vocord.ru ([217.67.177.50]:12182 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262708AbVDALJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 06:09:20 -0500
Subject: Re: cn_queue.c
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1112353944.9334.236.camel@uganda>
References: <20050331173215.49c959a0.akpm@osdl.org>
	 <1112341236.9334.97.camel@uganda> <20050331235706.5b5981db.akpm@osdl.org>
	 <1112344811.9334.146.camel@uganda> <20050401004804.52519e17.akpm@osdl.org>
	 <1112348048.9334.174.camel@uganda> <20050401015027.047783eb.akpm@osdl.org>
	 <1112351791.9334.208.camel@uganda>  <20050401024312.641946e2.akpm@osdl.org>
	 <1112353944.9334.236.camel@uganda>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rRTGeHK/sLag9pgjwhJW"
Organization: MIPT
Date: Fri, 01 Apr 2005 15:15:45 +0400
Message-Id: <1112354145.9334.239.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 15:09:06 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rRTGeHK/sLag9pgjwhJW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-01 at 15:12 +0400, Evgeniy Polyakov wrote:

> > > cn_queue_wrapper() atomically increments cbq->cb->refcnt if runs, so =
it
> > > will
> > > be caught in=20
> > > while (atomic_read(&cbq->cb->refcnt))=20
> > >   msleep(1000);
> > > in cn_queue_free_callback().
> > > If it does not run, then all will be ok.
> >=20
> > But there's a time window on entry to cn_queue_wrapper() where the recs=
ount
> > hasn't been incremented yet, and there's no locking.  If
> > cn_queue_free_callback() inspects the refcount in that window it will f=
ree
> > the cn_callback_entry() while cn_queue_wrapper() is playing with it?
>=20
> If we already run cn_queue_wrapper() [even before refcnt incrementing,
> probably it is not even needed there], then cancel_delayed_work() will
> sleep,
> since appropriate timer will be deleted in del_timer_sync(), which=20
> will wait untill it is finished on the different CPU.
>=20
> > > Btw, it looks like comments for del_timer_sync() and cancel_delayed_w=
ork
> > > ()
> > > are controversial - del_timer_sync() says that pending timer
> > > can not run on different CPU after returning,=20
> > > but cancel_delayed_work() says, that work to be cancelled still=20
> > > can run after returning.
> >=20
> > Not controversial - the timer can have expired and have been successful=
ly
> > deleted but the work_struct which the timer handler scheduled is still
> > pending, or has just started to run.
>=20
> Ugh, I see now.
> There are two levels of work deferring  - into cpu_workqueue_struct,=20
> and, in case of delayed work, into work->timer.
>=20
>=20
> Yes, I need to place flush_workqueue() in cn_queue_free_callback();
>=20

That actullay NULLifies above sentence about sleeping in
cancel_delayed_work().

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-rRTGeHK/sLag9pgjwhJW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTS1hIKTPhE+8wY0RAvarAKCKwxmo6xH8YFnzz4jrT24QCXBmRgCggUcm
k0I9fo7SXvE6+tGuL5fr8OM=
=GLWJ
-----END PGP SIGNATURE-----

--=-rRTGeHK/sLag9pgjwhJW--

