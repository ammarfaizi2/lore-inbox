Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVAZQqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVAZQqt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVAZQo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:44:29 -0500
Received: from dea.vocord.ru ([217.67.177.50]:14512 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262383AbVAZQlR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:41:17 -0500
Subject: Re: 2.6.11-rc2-mm1
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: dtor_core@ameritech.net
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <d120d500050126082515bd68f9@mail.gmail.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <d120d5000501250811295c298e@mail.gmail.com>
	 <20050126001443.7f91bbbb@zanzibar.2ka.mipt.ru>
	 <200501252357.08946.dtor_core@ameritech.net>
	 <1106727902.5257.109.camel@uganda>
	 <d120d5000501260546536647e7@mail.gmail.com>
	 <1106751547.5257.162.camel@uganda>
	 <d120d5000501260726714e8251@mail.gmail.com>
	 <1106754848.5257.189.camel@uganda>
	 <d120d500050126082515bd68f9@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cam9hAVKHW6mg8wgGNE4"
Organization: MIPT
Date: Wed, 26 Jan 2005 19:46:14 +0300
Message-Id: <1106757974.5257.229.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 26 Jan 2005 16:40:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cam9hAVKHW6mg8wgGNE4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-26 at 11:25 -0500, Dmitry Torokhov wrote:
> On Wed, 26 Jan 2005 18:54:08 +0300, Evgeniy Polyakov
> <johnpol@2ka.mipt.ru> wrote:
> > On Wed, 2005-01-26 at 10:26 -0500, Dmitry Torokhov wrote:
> > > On Wed, 26 Jan 2005 17:59:07 +0300, Evgeniy Polyakov
> > > <johnpol@2ka.mipt.ru> wrote:
> > >
> > > > Each superio chip has the same logical devices inside.
> > > > With your approach we will have following schema:
> > > >
> > > > bus:
> > > > superio1 - voltage, temp, gpio, rtc, wdt, acb
> > > > superio2 - voltage, temp, gpio, rtc, wdt, acb
> > > > superio3 - voltage, temp, gpio, rtc, wdt, acb
> > > > superio4 - voltage, temp, gpio, rtc, wdt, acb
> > > >
> > > > Each logical device driver (for existing superio schema)
> > > > is about(more than) 150 lines of code.
> > > > With your approach above example will be 150*6*4 +
> > > > 4*superio_chip_driver_size bytes
> > > > of the code.
> > >
> > > ????? Let's count again, shall we? Suppose we have:
> > > > superio1 - voltage, temp, gpio, rtc, wdt, acb
> > > > superio2 - voltage, temp, gpio, rtc, wdt, acb
> > > superio1 is driven by scx200 hardware, superio2 is driven by pc8736x
> > > or whatever. So here, you have 2 drivers to manage chips. Plus you
> > > have 6 superio interface drivers - gpio, acb, etc...
> > > It is exactly the same as your cheme size-wise.
> > >
> > > There is no need to many-to-many relationship. Each chip is bound to
> > > only one chip driver which registers several interfaces. Each
> > > interface is bound to only one interface driver. Interface driver is
> > > not chip specific, it knows how to run a specific interface (gpio,
> > > temp) and relies on chip driver to properly manage access to the
> > > hardware. Each combination of inetrface + interface driver produce on=
e
> > > class_device (call it sio, serio, whatever). Class device provides
> > > unified view of the interface to the userspace.
> > >
> > > What am I missing?
> >=20
> > Since each logical device does not know who use it, it can not be,
> > for example, removed optimally.
> > You need to run through whole superio device set to find those one that
> > has reference to logical device being removed.
>=20
> What do you mean by removing optimally? Consider teher 2 scenarios:
>  - you unload logical device driver which knows all the logical
> devices (interfaces) it is bound to and it releases those devices.

It does not know chip drivers, which reference it.
We need to scan all superio chips to find that.

> - you unload chip driver which knows what logical devices it has
> registered and removes them. Logical devices in turn unbind themselves
> from the logical drivers thay are bound to (only one for each device
> and they have link).
> Seems pretty clean to me.

Yes, since there is sc->ldev relation.

> > And situation become much worse, when we have so called logical device
> > clones -
> > it is virtual logical device that emulates standard one, but inside
> > performs
> > in a different way. Clone creates inside superio device(for example suc=
h
> > device
> > can live at different address).
> > When you do not have ldev->sc relation, you must traverse through each
> > logical device
> > in each superio chip to find clones.
> > Thus you will need to traverse through each superio chip,
> > then through each logical device it references, just to remove one
> > logical device.
>=20
> I am confused and need a concrete example. I would think that cases
> such as these should not require eny special handling, hardware access
> should be hidden from logical drivers by the chip driver. Or if only
> difference is the port address then it probably should be set by the
> chip driver as attribute of logical device.

Consider sc.c and GPIO logical device in SC1100 (scx driver).

 		/*
		 * SuperIO core is registering logical device.=20
		 * SuperIO chip knows where it must live.
		 * If logical device being registered lives at the different location
		 * (for example when it was registered for all devices,=20
		 * but has address(index) corresponding to only one SuperIO chip)=20
		 * then we will register new logical device with the same name=20
		 * but with the different location(index).
		 *
		 * It is called clone.
		 */


> Look at the serio system again. psmouse module knows how to talk to
> i8042-type ports. It does not rellay matter to it whther the port is
> on actual i8042 controller or somewhere else. What matters that it is
> PS/2 port and it supports writes and reads and that is it. How exactly
> read is performed (what port address, locking, etc) is of no concern
> to psmouse. The same I think should be happening here.

psmouse and sport are completely different example.

Consider you have mouse, that is shared between several users.
Should it have reference to each user?

Consider directory that is bind-mounted, should it have reference to
it's=20
original parent tree?

Consider page, that must be swapped, should it have access to all
processes
that share it?

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-cam9hAVKHW6mg8wgGNE4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB98lWIKTPhE+8wY0RAqvnAJ45F1DnOnLUvv9RGX3FclKDsz4aMgCgi67S
o0d2zIAwn2+ocWKKOSd/Ew8=
=Ipiv
-----END PGP SIGNATURE-----

--=-cam9hAVKHW6mg8wgGNE4--

