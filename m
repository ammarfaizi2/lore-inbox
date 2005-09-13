Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932517AbVIMVX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbVIMVX0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 17:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVIMVX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 17:23:26 -0400
Received: from [204.13.84.100] ([204.13.84.100]:54357 "EHLO
	stargazer.tbdnetworks.com") by vger.kernel.org with ESMTP
	id S932517AbVIMVX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 17:23:26 -0400
Subject: Re: 2.6.13.1 locks machine after some time, 2.6.12.5 work fine
From: Norbert Kiesel <nkiesel@tbdnetworks.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0509131016110.3351@g5.osdl.org>
References: <1126569577.25875.25.camel@defiant>
	 <Pine.LNX.4.58.0509121950340.3266@g5.osdl.org>
	 <20050913033814.GA879@tbdnetworks.com>
	 <Pine.LNX.4.58.0509130717360.3351@g5.osdl.org>
	 <1126631386.4555.13.camel@defiant>
	 <Pine.LNX.4.58.0509131016110.3351@g5.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZMrWe/ttO0kt2ldW+JzU"
Organization: TBD Networks
Date: Tue, 13 Sep 2005 14:23:25 -0700
Message-Id: <1126646605.4555.26.camel@defiant>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZMrWe/ttO0kt2ldW+JzU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-09-13 at 10:23 -0700, Linus Torvalds wrote:
>=20
> On Tue, 13 Sep 2005, Norbert Kiesel wrote:
> >=20
> > Ok, I applied the patch and I'm running it right now, so far so good.
> > Here is the the output of lspci from the patched 2.6.13.1 (not sure if =
a
> > diff to the unpatched 2.6.13.1 or the 2.6.12.5 would be more useful, so
> > I settled for no diff :-).
>=20
> Yes, now it looks better, except for a lspci quirk. You have:
>=20
> > 0000:00:10.0 RAID bus controller: Silicon Image, Inc. SiI 0649
> >		Ultra ATA/100 PCI to ATA Host Controller (rev 01)
>=20
> and lspci reports:
>=20
> > 	Expansion ROM at 40000000 [disabled] [size=3D512K]
>=20
> where the "disabled" comes from the fact that it looks at the sysfs data=20
> structures, and the resource is indeed marked as disabled there (because=20
> nothing enabled it explicitly).
>=20
> But then reading the HW registers, we see:
>=20
> > 30: 01 00 00 40 60 00 00 00 00 00 00 00 0c 01 02 04
>=20
> Ie now the ROM address value is 0x40000001, which means that as far as th=
e=20
> _hardware_ is concerned, the ROM is actually enabled.
>=20
> That's because the cmd64x driver enabled the ROM by just writing the=20
> enable bit directly, and never actually told the resource layer that it=20
> had done so. Not a big deal - we've properly allocated the resource=20
> region, so there's no overlap, there's just this strange disconnect=20
> between what the hardware thinks and what the resource handling things.
>=20
> Anyway, it all looks reasonable. Of course, exactly like with the hpt=20
> driver, there doesn't seem to be any real _reason_ to enable the ROM in=20
> the first place, and that code is #ifdef __i386__ anyway (so if there=20
> _was_ a reason, it wouldn't work on anything else than an x86), so I=20
> suspect we should just remove the ROM enable entirely.
>=20
> But it really shouldn't matter - at least we now enable the ROM
> _correctly_, and I'm pretty sure (and certainly sincerely hope ;) that
> your lockup is gone.
>=20
> 			Linus
>=20

Hi,
system is stable again (I'm way beyond the point where I got lockups
before).  Thanks a bunch for the quick fix!  I'd recommend to include
this patch in 2.6.13.2.

Best,
  Norbert


--=-ZMrWe/ttO0kt2ldW+JzU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDJ0NNOIJDAvi0wRwRApqaAJ4yEgEgGZ0Qda+iOs1Wy1vujdygAwCgs1+R
0w43Ivf+5PSHeKkq75FuAwU=
=YdYU
-----END PGP SIGNATURE-----

--=-ZMrWe/ttO0kt2ldW+JzU--

