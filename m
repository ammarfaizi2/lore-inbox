Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262690AbVDAKaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262690AbVDAKaU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 05:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbVDAKaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 05:30:19 -0500
Received: from dea.vocord.ru ([217.67.177.50]:38377 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262690AbVDAKaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 05:30:05 -0500
Subject: Re: cn_queue.c
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050401015027.047783eb.akpm@osdl.org>
References: <20050331173215.49c959a0.akpm@osdl.org>
	 <1112341236.9334.97.camel@uganda> <20050331235706.5b5981db.akpm@osdl.org>
	 <1112344811.9334.146.camel@uganda> <20050401004804.52519e17.akpm@osdl.org>
	 <1112348048.9334.174.camel@uganda>  <20050401015027.047783eb.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xuvjXMPnEXt45q4SgJwO"
Organization: MIPT
Date: Fri, 01 Apr 2005 14:36:31 +0400
Message-Id: <1112351791.9334.208.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Fri, 01 Apr 2005 14:29:52 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xuvjXMPnEXt45q4SgJwO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-04-01 at 01:50 -0800, Andrew Morton wrote:
> Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> >
> > cn_queue_free_dev() will wait until dev->refcnt hits zero=20
> >  before freeing any resources,
> >  but it can happen only after cn_queue_del_callback() does=20
> >  it's work on given callback device [actually when all callbacks=20
> >  are removed].
> >  When new callback is added into device, it's refcnt is incremented
> >  [before adition btw, if addition fails in the middle, reference is
> >  decremented], when callbak is removed, device's reference counter
> >  is decremented aromically after all work is finished.
>=20
> hm.
>=20
> How come cn_queue_del_callback() uses all those barriers if no other CPU
> can grab new references against cbq->cb->refcnt?

The work may be already assigned to that callback device,=20
new work cant, barriers are there to ensure that
reference counters are updated in proper places, but not=20
before.
It would be a bug to update dev->refcnt before assigned work is finished
and callback removed.

> cn_queue_free_callback() forgot to do flush_workqueue(), so
> cn_queue_wrapper() can still be running while cn_queue_free_callback()
> frees up the cn_callback_entry, I think.

cn_queue_wrapper() atomically increments cbq->cb->refcnt if runs, so it
will
be caught in=20
while (atomic_read(&cbq->cb->refcnt))=20
  msleep(1000);
in cn_queue_free_callback().
If it does not run, then all will be ok.

Btw, it looks like comments for del_timer_sync() and cancel_delayed_work
()
are controversial - del_timer_sync() says that pending timer
can not run on different CPU after returning,=20
but cancel_delayed_work() says, that work to be cancelled still=20
can run after returning.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-xuvjXMPnEXt45q4SgJwO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCTSQvIKTPhE+8wY0RAniMAJ9M6EwaDdhh3Djk9/8CGv9qG62taQCeMb5W
UqeSfbO+BbLOj0jRwXhDr4U=
=tsik
-----END PGP SIGNATURE-----

--=-xuvjXMPnEXt45q4SgJwO--

