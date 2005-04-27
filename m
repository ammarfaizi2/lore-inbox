Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261905AbVD0EAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261905AbVD0EAS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 00:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVD0EAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 00:00:18 -0400
Received: from user-edvans3.msk.internet2.ru ([217.25.93.4]:59837 "EHLO
	vocord.com") by vger.kernel.org with ESMTP id S261905AbVD0EAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 00:00:02 -0400
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number
	next.
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: dtor_core@ameritech.net
Cc: netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <d120d500050426130250ff9632@mail.gmail.com>
References: <20050411125932.GA19538@uganda.factory.vocord.ru>
	 <20050426203023.378e4831@zanzibar.2ka.mipt.ru>
	 <d120d50005042610342368cd72@mail.gmail.com>
	 <20050426220713.7915e036@zanzibar.2ka.mipt.ru>
	 <d120d50005042611203ce29dd8@mail.gmail.com>
	 <20050426223126.37b7aea1@zanzibar.2ka.mipt.ru>
	 <d120d50005042611426ec326e9@mail.gmail.com>
	 <20050426224833.3b6a0792@zanzibar.2ka.mipt.ru>
	 <d120d50005042612069b84ef@mail.gmail.com>
	 <20050426232812.0c7bb3a4@zanzibar.2ka.mipt.ru>
	 <d120d500050426130250ff9632@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xChfSW6ftMRamnhdz9P9"
Organization: MIPT
Date: Wed, 27 Apr 2005 08:06:49 +0400
Message-Id: <1114574809.14282.10.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 27 Apr 2005 07:59:22 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xChfSW6ftMRamnhdz9P9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-04-26 at 15:02 -0500, Dmitry Torokhov wrote:
> On 4/26/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > On Tue, 26 Apr 2005 14:06:36 -0500
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >=20
> > > On 4/26/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > On Tue, 26 Apr 2005 13:42:10 -0500
> > > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > > > Yes, that woudl work, although I would urge you to implement a me=
ssage
> > > > > queue for callbacks (probably limit it to 1000 messages or so) to
> > > > > allow bursting.
> > > >
> > > > It already exist, btw, but not exactly in that way -
> > > > we have skb queue, which can not be filled from userspace
> > > > if pressure is so strong so work queue can not be scheduled.
> > > > It is of course different and is influenced by other things
> > > > but it handles bursts quite well - it was tested on both
> > > > SMP and UP machines with continuous flows of forks with
> > > > shape addon of new running tasks [both fith fork bomb and not],
> > > > so I think it can be called real bursty test.
> > > >
> > >
> > > Ok, hear me out and tell me where I am wrong:
> > >
> > > By default a socket can receive at least 128 skbs with 258-byte
> > > payload, correct? That means that user of cn_netlink_send, if started
> > > "fresh", 128 average - size connector messages. If sender does not
> > > want to wait for anything (unlike your fork tests that do schedule)
> > > that means that 127 of those 128 messages will be dropped, although
> > > netlink would deliver them in time just fine.
> > >
> > > What am I missing?
> >=20
> > Concider netlink_broadcast - it delivers skb to the kernel
> > listener directly to the input callback - no queueing actually,
>=20
> Right, no queueing for in-kernel...=20
>=20
> But then we have the following: netlink will drop messages sent to
> in-kernel socket ony if it can not copy skb - which is i'd say a very
> rare scenario. Connector, on the other hand, is guaranteed to drop all
> but the very first message sent between 2 schedules. That makes
> connector several orders of magnitude less reliable than bare netlink
> protocol. And you don't see it with your fork tests because you do
> schedule when you fork.

Let's clarify that we are talking about userspace->kernelspace
direction.
Only for that messages callback path is invoked.
For such messages there is always scheduling after system call.
So if we have situation when after a schedule() call work queue can not
be scheduled, but userspace process in that situation can not be
scheduled
too, so no new message will be delivered and nothing can be dropped.

Actually you pointed to the interesting peice of code,=20
I've digged out some old pre-connector draft, where there is a note,=20
that it could be fine to
1. send messages to self, but first implementation was dropped.
2. call several callbacks in parallel, although it can not happen now.

So I will think of changing that code, although it works without unneded
drops now.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-xChfSW6ftMRamnhdz9P9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCbw/ZIKTPhE+8wY0RAn+pAJwMEpbhwecSXWugkfPuL5rnMMB/gQCfcEI8
cATo+yfCIRUya//Djg8VNIA=
=023L
-----END PGP SIGNATURE-----

--=-xChfSW6ftMRamnhdz9P9--

