Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317277AbSGDADA>; Wed, 3 Jul 2002 20:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317282AbSGDAC7>; Wed, 3 Jul 2002 20:02:59 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:28940 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S317277AbSGDAC5>; Wed, 3 Jul 2002 20:02:57 -0400
Date: Wed, 3 Jul 2002 17:05:21 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: usb storage cleanup
Message-ID: <20020703170521.E8033@one-eyed-alien.net>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <3D236950.5020307@colorfullife.com> <20020703144329.D8033@one-eyed-alien.net> <3D237870.7010600@colorfullife.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D237870.7010600@colorfullife.com>; from manfred@colorfullife.com on Thu, Jul 04, 2002 at 12:19:28AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2002 at 12:19:28AM +0200, Manfred Spraul wrote:
> Matthew Dharm wrote:
> > I don't understand what this patch is trying to do...
> >=20
> > You're reverting our new state machine changes... why?
> >=20
>=20
> Because the state machine doesn't work. I've degraded it into a=20
> debugging state.
> I've described it in a mail I send to you and linux-usb-devel a few=20
> weeks ago, without any reply.

I've got that mail, and it's on my todo list.

> E.g. queue_command stored new commands in ->queue_srb. The worker thread=
=20
> then moved it from queue_srb to srb and set sm_state to RUNNING.
>=20
> But what if command_abort() is called before the worker thread is schedul=
ed?

Then we have a serious problem, because the aborts are on the order of
several seconds.  If the thread hasn't gotten scheduled by then it _should_
cause a BUG_ON.

> State machines and asynchroneous command aborts are incompatible, that=20
> why I've moved command abortion out of sm_state.

I disagree here.  I think the clear state machine is the -only- way to get
this right.  We tried it without the state machine, and all we did was find
more and more corner cases which are not handled.

> > You're reverting the new mechanism to determine device state... why?
>=20
> Unnesessary duplication. Device disconnected is equivalent to=20
> ->pusb_dev=3D=3DNULL. Why do you need a special variable?

Because relying on a pointer has caused problems in the past, especially
when there are concerns that the pointer might be invalid.

> > You're removing the entire bus_reset() logic... why?
> >
> You are right, that change is not correct.
> Do you remember the reasons that lead to the current implementation?
>=20
> Hmm. Are you sure that the code can't cause data losses with unrelated=20
> devices?
> Suppose I have an usb hub installed, and behind that hub 2 usb disks. If=
=20
> bus_reset is called for the scsi controller that represents one disk,=20
> won't that affect the data transfer that go to the other disk?

The hub isn't reset, only the target device is.

> > This patch undoes most of the work done in the last few months.  I
> > _strongly_ oppose the patch without some better explanations.
>=20
> I've sent you a mail on 06/02 with details about all changes.
>=20
> http://www.geocrawler.com/archives/3/2571/2002/6/600/8821396/
>=20
> You did not reply, thus I assumed that you were too busy and I fixed=20
> everything myself.

I see.. thus skipping the 4 patches which address most of these issues
which are in my queue.

Look, I might not be that speedy on this, but did it at least occur to you
to contact _any_ of the other usb-storage people?  Bjorn?  Stern?

> The only new change is removing the call to usb_stor_CBI_irq() and=20
> replacing it with "up(&us->ip_waitq);" from usb_stor_abort_transport.=20
> Setting sm_state and then calling usb_stor_CBI_irq() is a=20
> synchronization nightmare.
> Situation: command is completed by the hardware and aborted by the scsi=
=20
> midlayer at the same time. usb_stor_abort_transport() could run on cpu1,=
=20
> _CBI_irq() on cpu2. Now imagine you run on Alpha, where both reads and=20
> writes are reordered. Initially I tried to fix it with memory barriers,=
=20
> but the new version is much simpler.

The only requirement in this condition is that the command state be
consistent at the end -- either completed or aborted.  I don't see how the
current code fails this requirement...

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

A:  The most ironic oxymoron wins ...
DP: "Microsoft Works"
A:  Uh, okay, you win.
					-- A.J. & Dust Puppy
User Friendly, 1/18/1998

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9I5FAIjReC7bSPZARAs5NAJ9CfxGyT7+lqXEqaWBCWBRzOBuRdACfe8xs
Sh5/UsqaFaMKUKV4MV0WvyY=
=5Ekn
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
