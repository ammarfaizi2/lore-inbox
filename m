Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268956AbRG0Tr6>; Fri, 27 Jul 2001 15:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268931AbRG0Trt>; Fri, 27 Jul 2001 15:47:49 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:1545 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S268060AbRG0Trd>; Fri, 27 Jul 2001 15:47:33 -0400
Date: Fri, 27 Jul 2001 12:47:36 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Pavel Machek <pavel@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>,
        "David S. Miller" <davem@redhat.com>,
        Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@redhat.com>,
        David Woodhouse <dwmw2@redhat.com>, linux-scsi@vger.kernel.org,
        Andrew Morton <andrewm@uow.edu.au>
Subject: Re: 2.4.7-pre9..
Message-ID: <20010727124736.B12304@one-eyed-alien.net>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Pavel Machek <pavel@suse.cz>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Alexander Viro <viro@math.psu.edu>,
	"David S. Miller" <davem@redhat.com>,
	Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@redhat.com>,
	David Woodhouse <dwmw2@redhat.com>, linux-scsi@vger.kernel.org,
	Andrew Morton <andrewm@uow.edu.au>
In-Reply-To: <20010727091858.C10787@one-eyed-alien.net> <Pine.LNX.4.33.0107271029340.21738-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0107271029340.21738-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Jul 27, 2001 at 10:46:44AM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hrm... just to be clear, then... this only is a problem with semaphores
that are declared on the local stack?

IIRC, usb-storage only uses semaphores that are allocated via kfree, so I
think we're okay.  Tho, I think the new semantics are probably better, and
will probably switch to them.  Later.

Matt

On Fri, Jul 27, 2001 at 10:46:44AM -0700, Linus Torvalds wrote:
>=20
> On Fri, 27 Jul 2001, Matthew Dharm wrote:
> >
> > It looks like I missed an important discussion in the torrent of e-mail
> > that I receive... could someone give me the 30-second executive summary=
 so
> > I can look at what may need to change in usb-storage?
>=20
> The basic summary is that we had this (fairly common) way of waiting for
> certain events by having a locked semaphore on the stack of the waiter,
> and then having the waiter do a "down()" which caused it to block until
> the thing it was waiting for did an "up()".
>=20
> This works fairly well, _but_ it has a really small (and quite unlikely)
> race on SMP, that is not so much a race of the idea itself, as of the
> implementation of the semaphores. We could have fixed the semaphores, but
> there were a few reasons not to:
>=20
>  - the semaphores are optimized (on purpose) for the non-contention case.
>    The "wait for completion" usage has the opposite default case
>  - the semaphores are quite involved and architecture-specific, exactly
>    due to this optimization. Trying to change them is painful as hell.
>=20
> So instead, I introduced the notion of "wait for completion":
>=20
> 	struct completion event;
>=20
> 	init_completion(&event);
> 	.. pass of event pointer to waker ..
> 	wait_for_completion(&event);
>=20
> where the thing we're waiting for just does "complete(event)" and we're
> all done.
>=20
> This has the advantage of being a bit more obvious just from a syntactic
> angle about what is going on. It also ends up being slightly more
> efficient than semaphores because we can handle the right expected case,
> and it also avoids the implementation issue that made for the race in the
> first place.
>=20
> Switching over to the new format is really trivial:
>=20
>  struct semaphore	-> struct completion
>  init_MUTEX_LOCKED	-> init_completion
>  DECLARE_MUTEX_LOCKED	-> DECLARE_COMPLETION
>  down()			-> wait_for_completion()
>  up()			-> complete()
>=20
> and you can in fact maintain 2.2.x compatibility by just having a 2.2.x
> compatibility file that does the reverse mappings.
>=20
> In case anybody cares, the race was that Linux semaphores only protect the
> accesses _inside_ the semaphore, while the accesses by the semaphores
> themselves can "race" in the internal implementation. That helps make an
> efficient implementation, but it means that the race was:
>=20
> 	cpu #1				cpu #2
>=20
> 	DECLARE_MUTEX_LOCKED(sem);
> 	..
> 	down(&sem);			up(&sem);
> 	return;
> 					wake_up(&sem.wait) /*BOOM*/
>=20
> where the waker still touches the semaphore data structure after the
> sleeper has become happy with it no longer being locked - and free'd the
> data structure by virtue of freeing the stack.
>=20
> 		Linus

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Hey Chief.  We've figured out how to save the technical department.  We=20
need to be committed.
					-- The Techs
User Friendly, 1/22/1998

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7YcVXz64nssGU+ykRAu/XAKCICgQ6Yi2ZO0toDwYGVr0g1EasCACg9zpo
swre5izhjxvPVjyYpSSkO+Y=
=7KQM
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
