Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVBXJPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVBXJPy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 04:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVBXJPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 04:15:53 -0500
Received: from ns2.vocord.com ([194.220.215.56]:20394 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262121AbVBXJPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:15:31 -0500
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       lkml <linux-kernel@vger.kernel.org>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Erich Focht <efocht@hpce.nec.com>
In-Reply-To: <1109227265.16029.154.camel@frecb000711.frec.bull.fr>
References: <1108649153.8379.137.camel@frecb000711.frec.bull.fr>
	 <1109148752.1738.105.camel@frecb000711.frec.bull.fr>
	 <20050223010747.0a572422.akpm@osdl.org>
	 <20050223140818.4261c4d0@zanzibar.2ka.mipt.ru>
	 <20050223025806.5a39f8fb.akpm@osdl.org>
	 <20050223144144.35d8985f@zanzibar.2ka.mipt.ru>
	 <1109227265.16029.154.camel@frecb000711.frec.bull.fr>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D0qWoW8Xf1jXRC5zyQ5C"
Organization: MIPT
Date: Thu, 24 Feb 2005 12:17:42 +0300
Message-Id: <1109236662.6728.40.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 24 Feb 2005 12:11:34 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D0qWoW8Xf1jXRC5zyQ5C
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-02-24 at 07:41 +0100, Guillaume Thouvenin wrote:
> On Wed, 2005-02-23 at 14:41 +0300, Evgeniy Polyakov wrote:
> > > Please assume that <whatever secret application the connector stuff w=
as
> > > originally written for> will always be listening.
> > >
> > > > > What happened to the idea of sending an on/off message down the n=
etlink
> > > > > socket?
> > > ...
> > > Arrange for the userspace daemon to send a message to the fork_connec=
tor
> > > subsystem turning it on or off.  So we can bypass all this code in th=
e
> > > common case where <secret application> is listening, but your daemon =
is
> > > not.
> >=20
> > Ok, now I see(I'm not a fork connector author, so I did not receive the=
m).
> > That will require to add real fork connector with callback routing.
> > Guillaume?
>=20
> Yes the connector's callback is a good solution. I will add a fork
> enable/disable callback in drivers/connector/connector.c that will
> switch a global variable when called from user space. It will be
> something like:
>=20
> void cn_fork_callback(void)
> {
> 	if (cn_already_initialized)=20
> 		cn_fork_enable =3D cn_fork_enable ? 0 : 1 ;
> }=20
>=20
> With cn_fork_enable set to 0 by default. In the do_fork() I will replace
> the statement "if (cn_already_initialized)" by "if (cn_fork_enable)"

Yes, it is right solution, but I do not think generic connector should
have it.
Create your own module that will "depend on CONNECTOR=3Dy", which will
register
callback and export some function that will be called from do_fork() if
FORK_CONNECTOR is defined and do nothing otherwise.
I think you even need to create some simple protocol over connector,
i.e.:

void cn_fork_callback(void *data)
{
	struct cn_msg *msg =3D (struct cn_msg *)data;

	if (msg->len !=3D sizeof(cn_fork_enable))
		return;

           memcpy(&cn_fork_enable, msg->data, sizeof(cn_fork_enable));
}

And register cn_for_callback() with the connector.

By default cn_fork_enable is zero and fork_connector() called from
do_fork()
will do nothing, otherwise cn_netlink_send(data, 0);
Since something is registered with connector then "0" here will select
appropriate group.
Or you may still use CN_IDX_FORK.

Userspace daemod, which is bound to the CN_IDX_FORK group will send
cn_msg with the appropriate
enable/disable message.

Or you can even create more complex protocol, which will enable/disable
various fork parameters to be logged...


> > > Without a lock you can have two messages with the same sequence numbe=
r.=20
> > > Even if the daemon which you're planning on implementing can handle t=
hat,
> > > we shouldn't allow it.
> >=20
> > Yes, they can have the same number, but does it cost atomic/lock overhe=
ad?
> > Anyway, simple spin_lock() should be enough in do_fork() context.
> > Guillaume?
>=20
> I will protect the incrementation by a spin_lock(&fork_cn_lock).
>=20
> Guillaume
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-D0qWoW8Xf1jXRC5zyQ5C
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCHZu2IKTPhE+8wY0RAnAEAJ9XOvdJMoPh06jQiPrq8Zw+bkO69gCfUG6e
33WhJlJAWlqs3IEEbILMwrk=
=ibWa
-----END PGP SIGNATURE-----

--=-D0qWoW8Xf1jXRC5zyQ5C--

