Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbTLHCXO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 21:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbTLHCXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 21:23:14 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:30117
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S265303AbTLHCXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 21:23:05 -0500
Subject: Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
From: Ian Kumlien <pomac@vapor.com>
To: ross@datscreative.com.au
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200312081207.45297.ross@datscreative.com.au>
References: <1070827127.1991.16.camel@big.pomac.com>
	 <200312081207.45297.ross@datscreative.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-D94W1js+KXOXIkMxr7DN"
Message-Id: <1070850185.1992.39.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 08 Dec 2003 03:23:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D94W1js+KXOXIkMxr7DN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-12-08 at 03:07, Ross Dickson wrote:
> On Monday 08 December 2003 05:58, you wrote:
> > > There are three parts to this email.
> > > a) apic mods.
> > > Lockups are due to too fast an apic acknowledge of apic timer int.
> > > Apic hard locked up the system - no nmi debug available.
> > > Fixed it by introducing a delay of at least 500ns into=20
> > > smp_apic_timer_interrupt() just prior to ack_APIC_irq().
> >=20
> > I find this really odd... It works just fine...=20
> > As did disabling whats now active ie:
> > 'Halt Disconnect and Stop Grant Disconnect' bit is enabled.
> >=20
> > So it seems like these are the two most important factors, at least fro=
m
> > where i stand. Both enabled me to actually use my machine with IO-APIC.
> > (1, disabling Halt Disconnect and Stop Grand Disconnect bit or 2, Add a
> > delay on the irq ack.)
> > Anyone that has any clues?
>=20
> I started work on this about 2 weeks ago and have not yet tried the=20
> "Halt Disconnect patch and Stop Grand Disconnect bit or 2" patch.=20
> My lockups ceased with just the apic time delay. I agree the delay is
> wasteful but the code branches into other servicing routines which I
> did not want to try to rearrange as yet. Given the infrequent nature
> of the lockup in CPU cycles maybe we can get smarter and read the
> timer register and see if enough time has expired to safely ack it. Is
> the Apic read cycle fast like cache ram (assume as fast as bus
> cycles?) or slow like 8259?

It could be something like cpu-disconnect-while-apic-being-hammered
race... Hell i dunno, i can only see some patterns from my own
experiences.

> After all it counts bus cycles doesn't it.  Alternately perhaps there
> is a status bit in the apic somewhere to check against after we ack to
> ensure that it did its job although we would not want to hammer the
> apic with writes it cannot accept? Or maybe it is not too bad for now,
> I note that there is an existing fixed 400ns delay in the IDE command
> routines ide-iops.c ide_execute_command() which we currently tolerate.

A status bit would be preferred since that would fix any races that
might exist. As for ide it would be preferred to have non-static delays
but if it's not possible to solve in another way then, by all means =3D).

But in this case, this is a specific workaround, and it works without it
if you disable the AMD cooler thing.

> > > b) io-apic mods
> > > So I have fixed it too (tested on both my epox and albatron MOBOs).
> > > Firstly I found 8254 connected directly to pin 0 not pin 2 of io-apic=
.
> > > I have modified check_timer() in io_apic.c to trial connect pin and=20
> > > test for it after the existing test for connection to io-apic.
> >=20
> > Good job, i wonder if it could be more generalized and integrated with
> > the rest of the code (i haven't even checked the rest of the code, but
> > this seemed separated).
> >=20
> > One thing though, I get a lot more NMI's now than with nmi_watchdog=3D2=
...
> > NMI:      85520
> > LOC:      85477
> >=20
> > I usually had a 3 figure number by now... but.. =3D)

> I have not tested the nmi against the b) io-apic mods. We may have a
> vector clash? Perhaps the new apic mpparse.c patch lets the existing
> check_timer() routines work properly?
> I have not yet tried it.

I dunno, i have never used a machine with IO-APIC on so i dunno whats
normal. But it grows a lot faster than nmi_watchdog=3D2.

> > > c) ide driver mods
> >=20
> > Cool..=20
> >=20
> > I applied all patches and it survived my grep test so i think it works.

6h 46 mins tells me that this works.
(peak nonworking uptime is still below 2hours)

--=20
Ian Kumlien <pomac () vapor ! com> -- http://pomac.netswarm.net

--=-D94W1js+KXOXIkMxr7DN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0+CJ7F3Euyc51N8RAiCiAJwLJJ2zr0kVNV52h6qka5uDHOKt5gCfR6YX
RrhMcplDxtkuhGCimZ49eh0=
=RYHl
-----END PGP SIGNATURE-----

--=-D94W1js+KXOXIkMxr7DN--

