Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSGDTrt>; Thu, 4 Jul 2002 15:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSGDTrt>; Thu, 4 Jul 2002 15:47:49 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:50960 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S313477AbSGDTrr>; Thu, 4 Jul 2002 15:47:47 -0400
Date: Thu, 4 Jul 2002 12:50:12 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: usb storage cleanup
Message-ID: <20020704125012.C17360@one-eyed-alien.net>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <3D236950.5020307@colorfullife.com> <20020703144329.D8033@one-eyed-alien.net> <3D237870.7010600@colorfullife.com> <20020703170521.E8033@one-eyed-alien.net> <3D248208.4060500@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jy6Sn24JjFx/iggw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D248208.4060500@colorfullife.com>; from manfred@colorfullife.com on Thu, Jul 04, 2002 at 07:12:40PM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jy6Sn24JjFx/iggw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2002 at 07:12:40PM +0200, Manfred Spraul wrote:
> Matthew Dharm wrote:
> >=20
> >>E.g. queue_command stored new commands in ->queue_srb. The worker threa=
d=20
> >>then moved it from queue_srb to srb and set sm_state to RUNNING.
> >>
> >>But what if command_abort() is called before the worker thread is sched=
uled?
> >=20
> >=20
> > Then we have a serious problem, because the aborts are on the order of
> > several seconds.  If the thread hasn't gotten scheduled by then it _sho=
uld_
> > cause a BUG_ON.
> >
>=20
> First of all, it's dead ugly. usb-storage crashes if the scheduler is=20
> overloaded. IMHO that's a bug, especially since it's simple to avoid it.
>=20
> And what about storage_disconnect()?
>=20
> Test case: user pulls out the usb cable while a transfer is in progress.=
=20
> urb submitted to the device, reply not yet received.
> Result: storage_disconnect() would hang for 20 seconds until=20
> command_abort() is called.

No, not quite.   The HCD accelerates the URBs to completion if the device
is removed with an URB pending on it.  It therefore shouldn't hang for the
timeout -- if you're seeing this behavior, then the HCD is broken.

> Read through my proposal: With current_urb_sem [I've called it urb_sem,=
=20
> but it's the same concept], the synchronization between abort and new=20
> commands is guaranteed.
>=20
> The only difference is that I've moved testing ->abort_cmd and=20
> down(&->urb_sem) into usb_stor_msg_common: Requesting that the callers=20
> must acquire the semaphore and check abort_cmd() is unnecessary code=20
> duplication and just asks for bugs.

The reason it was moved up was to save lots of processing (including memory
allocation paths) if the abort had already been requested.  Which is a
common case.

> >>>You're reverting the new mechanism to determine device state... why?
> >>
> >>Unnesessary duplication. Device disconnected is equivalent to=20
> >>->pusb_dev=3D=3DNULL. Why do you need a special variable?
> >=20
> >=20
> > Because relying on a pointer has caused problems in the past, especially
> > when there are concerns that the pointer might be invalid.
> >=20
>=20
> Could you explain a bit more? How could the pointer become invalid?

There was a large discussion of this in relation to another driver on
linux-usb-devel... basically, the pointer is just an address to a structure
owned by an HCD... it's entirely possible for the structure to go away on
us unexpectedly.  We _should_ get the notification via the _disconnect()
call, but real-world experience showed us that this wasn't always
happening.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I need a computer?
					-- Customer
User Friendly, 2/19/1998

--jy6Sn24JjFx/iggw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9JKb0IjReC7bSPZARAlnlAJ9slErArYmxFaRuzjzt3cDDSDZsEwCfRxXz
JiveefONmWR/FHImr+lbiys=
=yyVz
-----END PGP SIGNATURE-----

--jy6Sn24JjFx/iggw--
