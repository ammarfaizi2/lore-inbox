Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUGLNFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUGLNFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 09:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266782AbUGLNFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 09:05:41 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:52873 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S266758AbUGLNFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 09:05:35 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Wim Van Sebroeck <wim@iguana.be>
Subject: Re: watchdog infrastructure
Date: Mon, 12 Jul 2004 15:04:51 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200407011923.45226.arnd@arndb.de> <200407051454.48340.arnd@arndb.de> <20040712081939.GJ5726@infomag.infomag.iguana.be>
In-Reply-To: <20040712081939.GJ5726@infomag.infomag.iguana.be>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_zxo8Abm8gP8xDUj";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407121504.51995.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_zxo8Abm8gP8xDUj
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Montag, 12. Juli 2004 10:19, Wim Van Sebroeck wrote:

> > - Is there any reason having an alloc_watchdogdev function in the
> >   common code? Simply statically allocating the structure in each
> >   device driver should be a lot simpler.
>=20
> Oops: I forgot apparently: the experimental code is indeed more for
> 2.7 . Plan is to go in 2 stages: have a generic watchdog for v2.6
> which is just generic code that can be used by any single watchdog.
> This general code will contain the common things (basically the misc
> device + reboot_notifier). The second stage (and that's what's
> I actually created the experimetal directory) is to go to a general
> watchdog driver that supports sysfs and multiple watchdog-drivers
> (although only one driver will use /dev/watchdog).
ok.

> Because of the=20
> fact that you can use multiple watchdog-driver (even multiple cards
> of the same driver), you need to allocate it with alloc-watchdog.
Sorry, but I don't understand that argument. Drivers that only support
a single device can easily do static allocation. Drivers with potentially
multiple watchdogs can just do the allocation themselves with no
more complexity than calling alloc_watchdogdev. The advantage is that
you don't need to deal with magic pointers if you just embed the
struct watchdog_device in the drivers structure, like:

struct softdog_device {
	struct timer_list ticktock;
	struct watchdog_device dev;
};
#define to_softdog(wd) container_of((wd), struct softdog_device, dev)

static int softdog_keepalive(struct watchdog_device *wd_dev)
{
	struct softdog_private *softdog_info =3D to_softdog(wd_dev);
	/* ... */
}
static int softdog_init(void)
{
	struct softdog_device *sd;
	sd =3D kmalloc(sizeof(*sd), GFP_KERNEL);
	/* ... /*
	return register_watchdogdevice(&sd->dev);
}

> > - Keeping watchdog_ops out of watchdog_device will simplify=20
> >   the lifetime rules. Just put them in the same structure, add an
> >   owner field and get rid of the *private field.
>=20
> I'll have a look at that. The *private fiels is for the 2.7 code
> with multiple watchdogs.
ok.

> I don't see any reason why we should get the module reference
> count. Could you enlighten why this would be necessary?
> (This should only happen when you want to have a "nowayout").

If you want to allow unloading the device driver, you need to
prevent it from being unloaded while another thread is using it.
E.g. you might be in the middle of the keepalive function while
the function code is released from memory.
=20
> > - Maybe its easier to always register the misc devices when
> >   watchdog.ko is loaded, and then deny opening them when no
> >   actual watchdog driver is registered to it.
>=20
> Interesting idea. Although it's better now that we keep it like
> it is because else the daemon that poll's /dev/watchdog will
> will open something that's not there and think that everything
> is fine and that the system is monitored (which it isn't). A
> second problem you have is that this daemon absolutely doesn't
> know when it will need to reopen /dev/watchdog (to really start
> the hardware watchdog) after you've loaded a "working" watchdog
> device driver.

What I meant is that watchdog_open() would simply return -ENODEV
when no watchdog is registered, which looks to the application
just like no it does when the misc device is not registered.
You can even do request_module("watchdog") in watchdog_open()
do autoload the low-level driver.
BTW: with the current approach, the daemon won't be able to open
the device at all if you are using udev, so module autoload is
not possible either.

> > - Why do you need seperate operations for start and keepalive?
>=20
> Some watchdog devices/cards have seperate functions for starting
> their internal counters and for keeping the watchdog alive. Thus
> you need 2 different operations. For other cards this function
> is the same and thus the start and keepalive code is the same.

Ok. While this could of course be hidden in the device driver
by keeping a private state in order to reduce interface complexity,
You're probably right that reducing implementation complexity
gains more here.

> > - the reboot notifier and the nowayout parameter are probably
> >   common enough to be put into the generic module.
>=20
> The reboot notifier was the next step. That's indeed common.
> the nowayout parameter should stay together with the watchdog
> driver in my opinion (because if you would use more then 1
> watchdog device, you might want to set this for each device
> independently).

ok.

	Arnd <><

--Boundary-02=_zxo8Abm8gP8xDUj
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA8oxz5t5GS2LDRf4RAo/PAJ4/4yhP1CgS7WG2u4dJQwlvsU1UBACgm6PX
3YTHf5XWcgm4g/qCNiaj0Pg=
=oeVs
-----END PGP SIGNATURE-----

--Boundary-02=_zxo8Abm8gP8xDUj--
