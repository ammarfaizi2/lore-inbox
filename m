Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbVDALGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbVDALGY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 06:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbVDALGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 06:06:24 -0500
Received: from dea.vocord.ru ([217.67.177.50]:61075 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262707AbVDALGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 06:06:09 -0500
Subject: Re: cn_queue.c
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050401024312.641946e2.akpm@osdl.org>
References: <20050331173215.49c959a0.akpm@osdl.org>
	 <1112341236.9334.97.camel@uganda> <20050331235706.5b5981db.akpm@osdl.org>
	 <1112344811.9334.146.camel@uganda> <20050401004804.52519e17.akpm@osdl.org>
	 <1112348048.9334.174.camel@uganda> <20050401015027.047783eb.akpm@osdl.org>
	 <1112351791.9334.208.camel@uganda>  <20050401024312.641946e2.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wkBCwMhq3FFpMyzbtX6/"
Organization: MIPT
Date: Fri, 01 Apr 2005 15:12:24 +0400
Message-Id: <1112353944.9334.236.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 15:05:45 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wkBCwMhq3FFpMyzbtX6/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-01 at 02:43 -0800, Andrew Morton wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > On Fri, 2005-04-01 at 01:50 -0800, Andrew Morton wrote:
> > > Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > >
> > > > cn_queue_free_dev() will wait until dev->refcnt hits zero=20
> > > >  before freeing any resources,
> > > >  but it can happen only after cn_queue_del_callback() does=20
> > > >  it's work on given callback device [actually when all callbacks=20
> > > >  are removed].
> > > >  When new callback is added into device, it's refcnt is incremented
> > > >  [before adition btw, if addition fails in the middle, reference is
> > > >  decremented], when callbak is removed, device's reference counter
> > > >  is decremented aromically after all work is finished.
> > >=20
> > > hm.
> > >=20
> > > How come cn_queue_del_callback() uses all those barriers if no other =
CPU
> > > can grab new references against cbq->cb->refcnt?
> >=20
> > The work may be already assigned to that callback device,=20
> > new work cant, barriers are there to ensure that
> > reference counters are updated in proper places, but not=20
> > before.
>=20
> What are the "proper places"?  What other control paths could be inspecti=
ng
> the refcount at this time?  (That's the problem with barriers - you can't
> tell what they are barriering against).

Device's refcnt must be updated after work is done, not before.
Callback's refcnt must be incremented before work is done, and
decremented after.

Without barriers all above cases can be mixed.

> > It would be a bug to update dev->refcnt before assigned work is finishe=
d
> > and callback removed.
> >=20
> > > cn_queue_free_callback() forgot to do flush_workqueue(), so
> > > cn_queue_wrapper() can still be running while cn_queue_free_callback(=
)
> > > frees up the cn_callback_entry, I think.
> >=20
> > cn_queue_wrapper() atomically increments cbq->cb->refcnt if runs, so it
> > will
> > be caught in=20
> > while (atomic_read(&cbq->cb->refcnt))=20
> >   msleep(1000);
> > in cn_queue_free_callback().
> > If it does not run, then all will be ok.
>=20
> But there's a time window on entry to cn_queue_wrapper() where the recsou=
nt
> hasn't been incremented yet, and there's no locking.  If
> cn_queue_free_callback() inspects the refcount in that window it will fre=
e
> the cn_callback_entry() while cn_queue_wrapper() is playing with it?

If we already run cn_queue_wrapper() [even before refcnt incrementing,
probably it is not even needed there], then cancel_delayed_work() will
sleep,
since appropriate timer will be deleted in del_timer_sync(), which=20
will wait untill it is finished on the different CPU.

> > Btw, it looks like comments for del_timer_sync() and cancel_delayed_wor=
k
> > ()
> > are controversial - del_timer_sync() says that pending timer
> > can not run on different CPU after returning,=20
> > but cancel_delayed_work() says, that work to be cancelled still=20
> > can run after returning.
>=20
> Not controversial - the timer can have expired and have been successfully
> deleted but the work_struct which the timer handler scheduled is still
> pending, or has just started to run.

Ugh, I see now.
There are two levels of work deferring  - into cpu_workqueue_struct,=20
and, in case of delayed work, into work->timer.


Yes, I need to place flush_workqueue() in cn_queue_free_callback();

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-wkBCwMhq3FFpMyzbtX6/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTSyYIKTPhE+8wY0RAkCcAKCUaZR/ITfOVDNOMAyDcIXt+mNH5wCgjvgG
LiW0zRSlWz7fdiE7HZ/Nb1A=
=lVv8
-----END PGP SIGNATURE-----

--=-wkBCwMhq3FFpMyzbtX6/--

