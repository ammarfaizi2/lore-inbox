Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbVC0SGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbVC0SGl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 13:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVC0SGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 13:06:40 -0500
Received: from websrv2.werbeagentur-aufwind.de ([213.239.197.240]:12209 "EHLO
	websrv2.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S261270AbVC0SFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 13:05:21 -0500
Subject: Re: x86-64 preemption fix from IRQ and BKL in 2.6.12-rc1-mm2
From: Christophe Saout <christophe@saout.de>
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050327172625.GC18506@muc.de>
References: <20050324044114.5aa5b166.akpm@osdl.org>
	 <1111778785.14840.13.camel@leto.cs.pocnet.net>
	 <20050327172625.GC18506@muc.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2uJLqZf+wLWqT6ecuFz4"
Date: Sun, 27 Mar 2005 20:05:13 +0200
Message-Id: <1111946713.20987.16.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2uJLqZf+wLWqT6ecuFz4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Sonntag, den 27.03.2005, 19:26 +0200 schrieb Andi Kleen:

> > preempt_schedule_irq is not an i386 specific function and seems to take
> > special care of BKL preemption and since reiserfs does use the BKL to d=
o
> > certain things I think this actually might be the problem...?
>=20
> Hmm, preempt_schedule_irq is not in mainline as far as I can see.
> My patches are always for mainline; i dont do a special
> patch kit for -mm*

PREEMPT_BKL has been in mainline since 2.6.11-rc1,  preempt_schedule_irq
made it in 2.6.11-rc3. Please look here:
http://linux.bkbits.net:8080/linux-2.6/search/?expr=3Dpreempt_schedule_irq&=
search=3DChangeSet+comments

For i386 the first change was to switch to preempt_schedule in this code
path: http://linux.bkbits.net:8080/linux-2.6/patch@1.1966.39.63

preempt_schedule takes care of setting PREEMPT_ACTIVE and resetting it
afterwards, so I removed that from the assembler code.

Then preempt_schedule_irq has been introduced to move the sti/cli back
around the call to schedule:
http://linux.bkbits.net:8080/linux-2.6/patch@1.1982.28.91

So in the end the only thing that the patch I proposed was doing is to
*additionally* handle the PREEMPT_BKL case so that schedule doesn't
accidentally release the BKL semaphore when it shouldn't because we are
preempting and nobody explicitly called schedule.

Several other archs have done the same. No bug has shown up until the
recent -mm kernel where the execution of this code path actually became
possible (the "jc -> jnc" fix some lines above).

> It looks like a unfortunate interaction with some other patches
> in mm. Andrew, can you disable CONFIG_PREEMPT on x86-64 in
> mm for now?

These things are in 2.6.11 (except that they never got called because of
the wrong interrupt flag check in the IRQ handler).

> > Unfortunately I don't have a amd64 machine to play with, so can somebod=
y
> > please check this?
>=20
> How did you generate the crash dumps above then?

Well, nobody minds if I play with a webserver in the middle of the
night, as long as it works during the day. Shoot me. :)

Both servers are running fine since I applied my patch last night.

Now that I looked into it I think that it's obviously the correct
solution.


--=-2uJLqZf+wLWqT6ecuFz4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCRvXZZCYBcts5dM0RApE9AKCGOrY05UWJn3YcclZNdsACdfo5oACeI1Pi
gWClf+TSyaWThJhMbX9jaWw=
=0Yio
-----END PGP SIGNATURE-----

--=-2uJLqZf+wLWqT6ecuFz4--

