Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbVAZO4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbVAZO4W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVAZO4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:56:22 -0500
Received: from dea.vocord.ru ([217.67.177.50]:40350 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262319AbVAZO4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:56:05 -0500
Subject: Re: 2.6.11-rc2-mm1
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: dtor_core@ameritech.net
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
In-Reply-To: <d120d5000501260546536647e7@mail.gmail.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	 <d120d5000501250811295c298e@mail.gmail.com>
	 <20050126001443.7f91bbbb@zanzibar.2ka.mipt.ru>
	 <200501252357.08946.dtor_core@ameritech.net>
	 <1106727902.5257.109.camel@uganda>
	 <d120d5000501260546536647e7@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kJ3wmC/MUieUF3OD+b3x"
Organization: MIPT
Date: Wed, 26 Jan 2005 17:59:07 +0300
Message-Id: <1106751547.5257.162.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Wed, 26 Jan 2005 14:53:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kJ3wmC/MUieUF3OD+b3x
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-01-26 at 08:46 -0500, Dmitry Torokhov wrote:
> On Wed, 26 Jan 2005 11:25:02 +0300, Evgeniy Polyakov
> <johnpol@2ka.mipt.ru> wrote:
> > On Tue, 2005-01-25 at 23:57 -0500, Dmitry Torokhov wrote:
> >=20
> > > > > I have a slightly different concern - the superio is a completely=
 new
> > > > > subsystem and it should be integtrated with the driver model
> > > > > ("superio" bus?). Right now it looks like it is reimplementing mo=
st of
> > > > > the abstractions (device lists, driver lists, matching, probing).
> > > > > Moving to driver model significatntly affects lifetime rules for =
the
> > > > > objects, etc. etc. and will definitely not allow code such as abo=
ve.
> > > > >
> > > > > It would be nice it we get things right from the start.
> > > >
> > > > bus model is not good here - we need bus in each logical device and
> > > > bus in each superio chip(or at least second case).
> > > > Each bus bus have some crosslinking to devices in other buses,
> > > > and each new device
> > > > must be checked in each bus and probably added to each device...
> > > >
> > > > It is not like I see it.
> > > >
> > > > Consider folowing example:
> > > > each device from set A belongs to each device from set B.
> > > > n <-> n, it is not the case when one bus can handle all features.
> > > >
> > > > That is why I did not use driver model there.
> > > > It is specific design feature, which is proven to work.
> > > >
> > >
> > > Ok, I briefly looked over the patches and that is what I understand
> > > (please correct me where I am wrong):
> > >
> > > - you have superio chips which are containers providing set of interf=
aces;
> > > - you have superio chip driver that detects superio chip and manages
> > >   (enables/disables) individual interfaces.
> > > - you have set of interface drivers (gpio, acb) that bind to individu=
al
> > >   superio interfaces and provide unified userspace interface that all=
ows
> > >   reading, writing and analog of ioctl.
> > >
> > > So the question is why you can't have superio bus where superio chips
> > > register their individual interfaces as individual devices. gpio, acb=
, etc
> > > are drivers that bind to superio devices and create class devices gpi=
o.
> > >
> > > You could have:
> > >
> > > sys
> > > |-bus
> > > | |-superio
> > > | | |-devices
> > > | | | |-sio0 -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:03.0=
/sio0
> > > | | | |-sio1 -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:03.0=
/sio1
> > > | | | |-sio2 -> ../../../devices/pci0000:00/0000:00:1e.0/0000:02:04.0=
/sio2
> > > | | |-drivers
> > > | | | |-gpio
> > > | | | | |-sio1 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:02=
:03.0/sio1
> > > | | | | |-sio2 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:02=
:04.0/sio2
> > > | | | |-acb
> > > | | | | |-sio0 -> ../../../../devices/pci0000:00/0000:00:1e.0/0000:02=
:03.0/sio0
> > > |
> > > |-class
> > > | |-gpio
> > > | | |-gpio0
> > > | | |-gpio1
> > >
> > > gpioX have control and data attributes that allow reading and writing=
...
> > >
> > > Am I missing something?
> >=20
> > You try to create n <-> 1 relation, but superio by design supposed to b=
e
> > n <-> n.
>=20
> What design? Hardware design or present implementation design?

Hardware: each superio chip can have exactly the same logical devices
like any=20
other(actually it is standard, which is not always followed). I mean not
the same device=20
set, but logical devices itself - voltage monitors are the same for any
standard superio chip.
So we have many chips with the same set of the similar hardware.

Reverse relation is created when we want to keep only=20
number_od_superio_chips + number_of_logical_device number of drivers,
but not it's multiplication.

> > Above schema does not allow linking from each logical device to
> > appropriate superio chips
> > or vice versa - sc chips do not have link to it's logical devices.
> >
>=20
> sc chip does have a link to its logical devices - look at 0000:02:03.0
> PCI device in the picture above - that your SuperIO chip with 2
> interfaces. Interface, when bound to a superio driver creates gpio
> class device which in turn has link to physical device (here one of
> the SuperIO interfaces).
>=20
>=20
> Yes, I am trying to do 1 - n relationship. I do not understand why
> logical device has to span across several physical devices. With the
> exception of device mapper/raid you don't have a logical device span
> several physical devices, with everything else there is a parent that
> has several children.
>=20
> You have a PCI bus that has several PCI devices, one of them happens
> to be a IDE host controller with 2 channels connected to it. The other
> is your SuperIO chip with 2 GPIO pins and something else, and another
> SuperIO chip with 3 GIPO pins. Let's say you 1st chip monitors
> temperature in the case and the second interfaces wth some custom
> equipment measuring some thersholds in some chemical process. Are you
> saying that all 5 GPIO pins should be presented as one logical device
> that provides 5 outputs not related to each other? No, you have 5
> distinct devices with similar interfaces providing 5 distinct reads.
> Userspace may chose to group them somehow, based on external
> information that kernel does not have, but that's it. Kernel only
> provides uniform interface.
>=20

Each superio chip has the same logical devices inside.
With your approach we will have following schema:

bus:
superio1 - voltage, temp, gpio, rtc, wdt, acb
superio2 - voltage, temp, gpio, rtc, wdt, acb
superio3 - voltage, temp, gpio, rtc, wdt, acb
superio4 - voltage, temp, gpio, rtc, wdt, acb

Each logical device driver (for existing superio schema)
is about(more than) 150 lines of code.
With your approach above example will be 150*6*4 +
4*superio_chip_driver_size bytes
of the code.
With my - only 150*6 + 4*superio_chip_driver_size.

And not the code size is matter, but that fact, that changing one driver
(for example add feature to more precise temperature conversation) will
end up fixing huge amount of driver, but not the one file.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-kJ3wmC/MUieUF3OD+b3x
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBB97A7IKTPhE+8wY0RAlHvAJ47ShqORwuxz9DNRnSC+8hdcOk/PACfZb6V
HIIxIryBWF3ycu3wNxOLJyQ=
=oGNf
-----END PGP SIGNATURE-----

--=-kJ3wmC/MUieUF3OD+b3x--

