Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262664AbVCWEq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262664AbVCWEq2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 23:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbVCWEq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 23:46:28 -0500
Received: from dea.vocord.ru ([217.67.177.50]:29908 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262664AbVCWEqP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 23:46:15 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Ram <linuxram@us.ibm.com>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <1111524168.5860.109.camel@localhost>
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>
	 <200503170856.57893.jbarnes@engr.sgi.com>
	 <20050318003857.4600af78@zanzibar.2ka.mipt.ru>
	 <200503171405.55095.jbarnes@engr.sgi.com>
	 <1111409303.8329.16.camel@frecb000711.frec.bull.fr>
	 <1111438349.5860.27.camel@localhost>
	 <1111475252.8465.23.camel@frecb000711.frec.bull.fr>
	 <1111515979.5860.57.camel@localhost>
	 <20050322222201.0fa25d34@zanzibar.2ka.mipt.ru>
	 <1111519086.5860.80.camel@localhost>
	 <20050322232524.67bf5054@zanzibar.2ka.mipt.ru>
	 <1111524168.5860.109.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uyeBDSG72iP5BeySF9Wd"
Organization: MIPT
Date: Wed, 23 Mar 2005 07:52:30 +0300
Message-Id: <1111553550.23532.52.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 23 Mar 2005 07:45:22 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uyeBDSG72iP5BeySF9Wd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-22 at 12:42 -0800, Ram wrote:
> On Tue, 2005-03-22 at 12:25, Evgeniy Polyakov wrote:
> > On Tue, 22 Mar 2005 11:18:07 -0800
> > Ram <linuxram@us.ibm.com> wrote:
> >=20
> > > > I still do not see why it is needed.
> > > > Super-user can run ip command and turn network interface off
> > > > not waiting while apache or named exits or unbind.
> > > >=20
> > > > In theory I can create some kind of userspace registration mechanis=
m,
> > > > when userspace application reports it's pid to the connector,=20
> > > > and then it sends data to the specified pids, but does not=20
> > > > allow controlling from userspace.
> > > > But I really do not think it is a good idea to permit
> > > > non-priviledged userspace processes to know about deep
> > > > kernel internals through connector's messages.
> > >=20
> > > Yes. non-priviledged userspace processes should not know
> > > any deep kernel internals through connector events.
> > >=20
> > > I think what I am driving at is, an application that is critically
> > > dependent on the fork-notification, suddenly stops receiving such
> > > notification because some other application has switched off the=20
> > > service without its notice.=20
> > >=20
> > > the reason I am concerned is I am planning to feed this fork-events
> > > to my in-kernel module. Side note: I would really like support for
> > > in-kernel listners through connector infrastructure.
> >=20
> > fork connector can be extended to send to the rest of the world
> > information that it was turned off or on.
>=20
> This will support the paradigm: "Let me know if this is switched off,
> and I don't mind any arbitrary process switching it off".  No
> applications can seriously rely on this service, because there is this
> *arbritray-application-being-able-to-control* component to it.

It is fork connector who will inform all it's listeners that it is not
working any more.
And it is only super-user who can turn it off.

> A ideal paradigm would be: "Don't switch it off, without my consent".
> Essentially this will give applications enough confidence to rely on it
> seriously.

Does ip command wait until apache or bind exited when trying to turn=20
network interface off? No. One can even unload network driver.
Because super-user must have ability to control the whole system.

> However an inbetween paradigm that would acceptable is:
> "Let me know if this is swtiched off provided only application that I
> can trust-on has the power to manage it".

I suppose fork connector [kernel module] is trusted enough application
that can inform external listeners about it's status.
But super-user still can turn it off by any program,
like one can turn network interface off using ip, ifconfig, your own=20
application that can, btw, do it using netlink socket.

> To me 2nd or 3rd paradigm seems acceptable, but not the 1st.

Ok, fork module can implement following controlling mechanism:
on insert time super-user provides pid of the controlling=20
program, later in fork callback it searches for the given pid,=20
sends some signal to it, and if it receives=20
magic message [with signal number for example] after it, then it is ok
to perform desired action.
I believe there are plenty of auth techniques that can be applied
here, but I strongly object against it.

What would happen with the system, if only one controlling daemon=20
is allowed to turn networking off, or change hard drive work modes,
or super-user could not be allowed to remove user's file using usual
rm comman, but not specially authentificated daemon?
Or if it should ask all user's application, do they agree
to remove user's files?

> Thanks,
> RP
>=20
> >=20
> > > RP
> >=20
> > 	Evgeniy Polyakov
> >=20
> > Only failure makes us experts. -- Theo de Raadt
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-uyeBDSG72iP5BeySF9Wd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQPYOIKTPhE+8wY0RApn0AKCA1RwtzLIrc5VYp8vyP2Xk9F7f4gCeKRve
C/LnzdqzfSKHfQpyGeVOOV0=
=XhXR
-----END PGP SIGNATURE-----

--=-uyeBDSG72iP5BeySF9Wd--

