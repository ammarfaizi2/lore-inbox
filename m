Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262449AbVA0C4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbVA0C4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 21:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVAZXQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:16:49 -0500
Received: from dea.vocord.ru ([217.67.177.50]:18614 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262449AbVAZRep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:34:45 -0500
Subject: Re: 2.6.11-rc2-mm1
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: dtor_core@ameritech.net
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <d120d50005012608556ab05a96@mail.gmail.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <20050126001443.7f91bbbb@zanzibar.2ka.mipt.ru>
	 <200501252357.08946.dtor_core@ameritech.net>
	 <1106727902.5257.109.camel@uganda>
	 <d120d5000501260546536647e7@mail.gmail.com>
	 <1106751547.5257.162.camel@uganda>
	 <d120d5000501260726714e8251@mail.gmail.com>
	 <1106754848.5257.189.camel@uganda>
	 <d120d500050126082515bd68f9@mail.gmail.com>
	 <1106757974.5257.229.camel@uganda>
	 <d120d50005012608556ab05a96@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6rXb/FIoohnVh/Y5sEUe"
Organization: MIPT
Date: Wed, 26 Jan 2005 20:39:36 +0300
Message-Id: <1106761176.5257.246.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 26 Jan 2005 17:33:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6rXb/FIoohnVh/Y5sEUe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-26 at 11:55 -0500, Dmitry Torokhov wrote:
> On Wed, 26 Jan 2005 19:46:14 +0300, Evgeniy Polyakov
> <johnpol@2ka.mipt.ru> wrote:
> > On Wed, 2005-01-26 at 11:25 -0500, Dmitry Torokhov wrote:
> > > On Wed, 26 Jan 2005 18:54:08 +0300, Evgeniy Polyakov
> > > <johnpol@2ka.mipt.ru> wrote:
> > > > On Wed, 2005-01-26 at 10:26 -0500, Dmitry Torokhov wrote:
> > > > > On Wed, 26 Jan 2005 17:59:07 +0300, Evgeniy Polyakov
> > > > > <johnpol@2ka.mipt.ru> wrote:
> > > > >
> > > > > > Each superio chip has the same logical devices inside.
> > > > > > With your approach we will have following schema:
> > > > > >
> > > > > > bus:
> > > > > > superio1 - voltage, temp, gpio, rtc, wdt, acb
> > > > > > superio2 - voltage, temp, gpio, rtc, wdt, acb
> > > > > > superio3 - voltage, temp, gpio, rtc, wdt, acb
> > > > > > superio4 - voltage, temp, gpio, rtc, wdt, acb
> > > > > >
> > > > > > Each logical device driver (for existing superio schema)
> > > > > > is about(more than) 150 lines of code.
> > > > > > With your approach above example will be 150*6*4 +
> > > > > > 4*superio_chip_driver_size bytes
> > > > > > of the code.
> > > > >
> > > > > ????? Let's count again, shall we? Suppose we have:
> > > > > > superio1 - voltage, temp, gpio, rtc, wdt, acb
> > > > > > superio2 - voltage, temp, gpio, rtc, wdt, acb
> > > > > superio1 is driven by scx200 hardware, superio2 is driven by pc87=
36x
> > > > > or whatever. So here, you have 2 drivers to manage chips. Plus yo=
u
> > > > > have 6 superio interface drivers - gpio, acb, etc...
> > > > > It is exactly the same as your cheme size-wise.
> > > > >
> > > > > There is no need to many-to-many relationship. Each chip is bound=
 to
> > > > > only one chip driver which registers several interfaces. Each
> > > > > interface is bound to only one interface driver. Interface driver=
 is
> > > > > not chip specific, it knows how to run a specific interface (gpio=
,
> > > > > temp) and relies on chip driver to properly manage access to the
> > > > > hardware. Each combination of inetrface + interface driver produc=
e one
> > > > > class_device (call it sio, serio, whatever). Class device provide=
s
> > > > > unified view of the interface to the userspace.
> > > > >
> > > > > What am I missing?
> > > >
> > > > Since each logical device does not know who use it, it can not be,
> > > > for example, removed optimally.
> > > > You need to run through whole superio device set to find those one =
that
> > > > has reference to logical device being removed.
> > >
> > > What do you mean by removing optimally? Consider teher 2 scenarios:
> > >  - you unload logical device driver which knows all the logical
> > > devices (interfaces) it is bound to and it releases those devices.
> >=20
> > It does not know chip drivers, which reference it.
>=20
> Of course it does, every logical device has one parent. Individual
> GPIO pins are not spread across your motherboard. Every one of them
> lives on some chip. They can all be driven by the same driver but they
> are different devices. It is like all your IDE drives are driven by
> the same driver but (unless LVM which is diffrent layer comes to play)
> they are still different drives.

No, there is no "parent".
Each logical device is "shared" between several superio chips.
It is presented design.
More below.

> > We need to scan all superio chips to find that.
> >=20
> > > - you unload chip driver which knows what logical devices it has
> > > registered and removes them. Logical devices in turn unbind themselve=
s
> > > from the logical drivers thay are bound to (only one for each device
> > > and they have link).
> > > Seems pretty clean to me.
> >=20
> > Yes, since there is sc->ldev relation.
> >=20
> > > > And situation become much worse, when we have so called logical dev=
ice
> > > > clones -
> > > > it is virtual logical device that emulates standard one, but inside
> > > > performs
> > > > in a different way. Clone creates inside superio device(for example=
 such
> > > > device
> > > > can live at different address).
> > > > When you do not have ldev->sc relation, you must traverse through e=
ach
> > > > logical device
> > > > in each superio chip to find clones.
> > > > Thus you will need to traverse through each superio chip,
> > > > then through each logical device it references, just to remove one
> > > > logical device.
> > >
> > > I am confused and need a concrete example. I would think that cases
> > > such as these should not require eny special handling, hardware acces=
s
> > > should be hidden from logical drivers by the chip driver. Or if only
> > > difference is the port address then it probably should be set by the
> > > chip driver as attribute of logical device.
> >=20
> > Consider sc.c and GPIO logical device in SC1100 (scx driver).
> >=20
> >                /*
> >                 * SuperIO core is registering logical device.
> >                 * SuperIO chip knows where it must live.
> >                 * If logical device being registered lives at the diffe=
rent location
> >                 * (for example when it was registered for all devices,
> >                 * but has address(index) corresponding to only one Supe=
rIO chip)
> >                 * then we will register new logical device with the sam=
e name
> >                 * but with the different location(index).
> >                 *
> >                 * It is called clone.
> >                 */
> >=20
>=20
> In this sense every device is a clone. Consider I have 2 EtherExpress
> cards in my box. They surely live at different addresses but PCI
> system does not mess with "clones". And network layer does not care
> whether both of them driven by e100 or one is e100 and the other is
> RTL.

It is not the same as two different devices on the bus.

Consider sc1100 - GPIO lives in PCI aperture, absolutely not where
superio lives.
(And it is actully not logical device in this case, but it fits well
into design).


You skipped my examples, but presented design is very convenient to the
situation,
when you have two different sets of devices, or classes of devices, each
of which
can have link to any device from the other set.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-6rXb/FIoohnVh/Y5sEUe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB99XYIKTPhE+8wY0RAouKAJ9THtYE6pyrfEzjeAurpmtxR+iG4QCfX+4U
ZyF54cfVH1C/tWtJQD6toW8=
=xfyU
-----END PGP SIGNATURE-----

--=-6rXb/FIoohnVh/Y5sEUe--

