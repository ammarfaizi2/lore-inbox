Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbVLGP4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbVLGP4w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVLGP4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:56:52 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:12954 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751153AbVLGP4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:56:51 -0500
Date: Wed, 7 Dec 2005 14:00:47 -0200
From: Eduardo Pereira Habkost <ehabkost@mandriva.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>,
       linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Message-ID: <20051207160047.GG20451@duckman.conectiva>
References: <Pine.LNX.4.44L0.0512071000120.21143-100000@iolanthe.rowland.org> <1133968943.2869.26.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JkW1gnuWHDypiMFO"
Content-Disposition: inline
In-Reply-To: <1133968943.2869.26.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--JkW1gnuWHDypiMFO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2005 at 04:22:23PM +0100, Arjan van de Ven wrote:
>=20
> > On the other hand, Oliver needs to be careful about claiming too much. =
 In=20
> > general atomic_t operations _are_ superior to the spinlock approach.
>=20
> No they're not. Both are just about equally expensive cpu wise,
> sometimes the atomic_t ones are a bit more expensive (like on parisc
> architecture). But on x86 in either case it's a locked cycle, which is
> just expensive no matter which side you flip the coin...=20

But if a lock is used exclusively to protect a int variable, an atomic_t
seems to be more appropriate to me. Isn't it?

>=20
> >   If=20
> > they weren't, atomic_t wouldn't belong in the kernel at all.
>=20
> there's different usage patterns where either makes sense.=20
> In this case it looks just disgusting on very first sight; the atomic
> are used to implement a lock, and that lock itself is then implemented
> with a spinlock again. For me, again on first sight, the real solution
> appears to be to use a linux primitive for the higher level lock in the
> first place, instead of reimplementing <your own thing> with <another
> own thing>.

The patches don't implement any new lock scheme neither change the
current behaviour. They just replace a spin_lock + integer variable
(the spinlock is used just to protect an integer variable) by an atomic_t.

The patches aren't adding any "own lock scheme", but just replacing
a spinlock that is used exclusively to protect an integer variable
(write_urb_busy) by an atomic_t.

The whole point of the changes is that using a spin_lock to protect only
a int variable doesn't look like a Right Thing.

Please, if you could, review the patches with this in mind: we aren't
changing any behaviour neither creating any weird lock scheme, we are
only doing two things:

1. Putting all the duplicated code that handles write_urb_busy (that
   already exists) in only one place
2. Replacing a spin_lock that is being used to protect only a single
   integer field by an atomic_t

People got scared when they looked at the patch that does (1), thinking
that we were creating new, weird, locking scheme (because we are doing (2)
at the same time). But we are just isolating the existing 'write_urb_busy'
scheme that is duplicated all around the usb-serial drivers.

I guess (1) is a Good Thing, so the only question is: do you really
disagree about doing (2)?

--=20
Eduardo

--JkW1gnuWHDypiMFO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDlwcvcaRJ66w1lWgRAknbAJsGNkqIgqxBImNpvePK/Q/TZWeWOACdEkcD
wN1jOjx5bIBFQquedciQj4s=
=IKSl
-----END PGP SIGNATURE-----

--JkW1gnuWHDypiMFO--
