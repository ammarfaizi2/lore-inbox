Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161385AbWKOUAG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161385AbWKOUAG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 15:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161382AbWKOUAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 15:00:04 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:31138 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S1161381AbWKOT74
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:59:56 -0500
From: Mws <mws@twisted-brains.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Date: Wed, 15 Nov 2006 20:59:49 +0100
User-Agent: KMail/1.9.5
Cc: Jeff Garzik <jeff@garzik.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tiwai@suse.de, Olivier Nicolas <olivn@trollprod.org>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org> <455B688F.8070007@garzik.org> <Pine.LNX.4.64.0611151127560.3349@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611151127560.3349@woody.osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1360125.9uHMoJp6Hu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611152059.53845.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1360125.9uHMoJp6Hu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 15 November 2006 20:35, Linus Torvalds wrote:
>=20
> On Wed, 15 Nov 2006, Jeff Garzik wrote:
> >=20
> > The reason we cannot do this in the generic layer for non-PCI-Ex is onl=
y the
> > driver knows whether that PCI 2.2 bit was actually implemented in the d=
evice
> > or mapped to some other weird behavior we don't want to touch.  DISABLE=
=2DINTX
> > is a new bit not present in PCI 2.1 (alas!!).
>=20
> Ok, I would have a few suggestions, then:
>=20
>  - devices that don't support INTx disable should basically be considered=
=20
>    to not support MSI at all (ie a driver simply shouldn't even try to=20
>    enable MSI, since enabling MSI includes the implicit DISABLE-INTX)
>=20
>    This is likely ok, since MSI wasn't in PCI 2.1 _either_ afaik. So if=20
>    your hardware has MSI, it probably _does_ have DISABLE-INTX (or at=20
>    least that bit doesn't do anything bad, which is the other case)
>=20
>  - add a flag to "pci_enable_msi()". There really aren't that many users,=
=20
>    and they basically _all_ want this functionality. Making them call=20
>    another function is just a recipe for disaster, since somebody will=20
>    forget. Having to just say "do I support INTx disable" is much better,=
=20
>    since it makes the driver writer aware of having to _explicitly_ make=
=20
>    that choice.
>=20
> > Maybe a better solution is letting the driver say "pci_dev->intx_ok =3D=
 1" right
> > before it calls pci_enable_device().
>=20
> I hate that, for exactly the same reason I hate "pci_intx()". It just=20
> means that most drivers won't do it, because it's not even part of the=20
> normal sequence, and most people don't care. So again, it would actually=
=20
> be better in that case to just add a "flags" field to pci_enable_device()=
,=20
> although that's a _hell_ of a lot more painful than it would be to do the=
=20
> same to "pci_enable_msi()".
>=20
> > And if we do this, we can follow through on another suggestion I made:
> > disabling INTx on driver exit, to help eliminate any possibility of scr=
eaming
> > interrupts after driver unload.
>=20
> The thing is, I think that's a bad idea for the same reason it's a bad=20
> idea to disable the BAR's (which we tried and then reverted). It's just=20
> going to cause problems for soft rebooting etc with firmware that doesn't=
=20
> expect it.
>=20
> A driver should obviously quiesce the device on shutdown, and if it leave=
s=20
> a device in a state where it may still generate interrupts, that's a=20
> _bug_, so disabling INTx is just papering over a much more serious issue.
>=20
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20
i just recognised this thread, and i found a solution for some weird stuff
also reported days ago on alsa-users list.

short summary for your information:

asus m2n32 ws professional=20
amd x2 5000+
everything compiled as 64 bit.

i recognised strange behaviour from 2.6.19-rc1 on.
sound got crappy and if i tried to use snd_hda_intel as modules
rmmod & afterwards modprobe froze the machine completely.
even the kernel sys req key combination didn't work anymore.

after some small discussions on alsa-user ml i recognised this
thread today.=20
i thought my problem could also exist on this msi stuff.
i disabled msi in kernel config, reboot, and, after starting x & kde
i got immediately a freeze.
last and maybe important last try has been to
enable msi support _but_ boot kernel with cmdline pci=3Dnomsi
this finally did work out. i got a working sound environment again.

if i should supply more information on that, please contact me.

i find it a bit abnormal that the disabling msi in kernel config behaviour
is different from kernel cmdline pci=3Dnomsi option.

best regards
marcel

ps. i don't want to break this thread up into something different, but mayb=
e my=20
     report works out as usefull.



--nextPart1360125.9uHMoJp6Hu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFW3G5PpA+SyJsko8RAk8EAJ46IFTCkYBaxrxqpSE2Bn0VqcFa3wCfbE2r
PMFbu+5ApTKBsGxpN5sa3IA=
=pnAz
-----END PGP SIGNATURE-----

--nextPart1360125.9uHMoJp6Hu--
