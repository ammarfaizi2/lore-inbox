Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVAZIYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVAZIYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 03:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262391AbVAZIYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 03:24:44 -0500
Received: from dea.vocord.ru ([217.67.177.50]:35476 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262389AbVAZIYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 03:24:38 -0500
Subject: Re: 2.6.11-rc2-mm1
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: dmitry.torokhov@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200501252357.08946.dtor_core@ameritech.net>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <d120d5000501250811295c298e@mail.gmail.com>
	 <20050126001443.7f91bbbb@zanzibar.2ka.mipt.ru>
	 <200501252357.08946.dtor_core@ameritech.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vLpuuvKHc4WvBmQV2xoO"
Organization: MIPT
Date: Wed, 26 Jan 2005 11:25:02 +0300
Message-Id: <1106727902.5257.109.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 26 Jan 2005 08:19:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vLpuuvKHc4WvBmQV2xoO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-01-25 at 23:57 -0500, Dmitry Torokhov wrote:

> > > I have a slightly different concern - the superio is a completely new
> > > subsystem and it should be integtrated with the driver model
> > > ("superio" bus?). Right now it looks like it is reimplementing most o=
f
> > > the abstractions (device lists, driver lists, matching, probing).
> > > Moving to driver model significatntly affects lifetime rules for the
> > > objects, etc. etc. and will definitely not allow code such as above.
> > >=20
> > > It would be nice it we get things right from the start.
> >=20
> > bus model is not good here - we need bus in each logical device and
> > bus in each superio chip(or at least second case).
> > Each bus bus have some crosslinking to devices in other buses,=20
> > and each new device
> > must be checked in each bus and probably added to each device...
> >=20
> > It is not like I see it.
> >=20
> > Consider folowing example:=20
> > each device from set A belongs to each device from set B.
> > n <-> n, it is not the case when one bus can handle all features.
> >=20
> > That is why I did not use driver model there.
> > It is specific design feature, which is proven to work.
> >
>=20
> Ok, I briefly looked over the patches and that is what I understand
> (please correct me where I am wrong):
>=20
> - you have superio chips which are containers providing set of interfaces=
;
> - you have superio chip driver that detects superio chip and manages
>   (enables/disables) individual interfaces.
> - you have set of interface drivers (gpio, acb) that bind to individual
>   superio interfaces and provide unified userspace interface that allows
>   reading, writing and analog of ioctl.
>=20
> So the question is why you can't have superio bus where superio chips
> register their individual interfaces as individual devices. gpio, acb, et=
c
> are drivers that bind to superio devices and create class devices gpio.
>=20
> You could have:
>=20
> sys
> |-bus
> | |-superio
> | | |-devices
> | | | |-sio0 -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:03.0/sio=
0
> | | | |-sio1 -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:03.0/sio=
1
> | | | |-sio2 -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:04.0/sio=
2
> | | |-drivers
> | | | |-gpio
> | | | | |-sio1 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:02:03.=
0/sio1
> | | | | |-sio2 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:02:04.=
0/sio2
> | | | |-acb
> | | | | |-sio0 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:02:03.=
0/sio0
> |
> |-class
> | |-gpio
> | | |-gpio0
> | | |-gpio1
>=20
> gpioX have control and data attributes that allow reading and writing...
>=20
> Am I missing something?

You try to create n <-> 1 relation, but superio by design supposed to be
n <-> n.
Above schema does not allow linking from each logical device to
appropriate superio chips
or vice versa - sc chips do not have link to it's logical devices.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-vLpuuvKHc4WvBmQV2xoO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB91PeIKTPhE+8wY0RAmU3AKCFzsh1NuO6ur7sB0L8vbAduIBCHQCgjj+2
6XZisBvfIvPQFDf4FqKWzy4=
=80co
-----END PGP SIGNATURE-----

--=-vLpuuvKHc4WvBmQV2xoO--

