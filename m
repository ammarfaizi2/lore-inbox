Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161243AbVKIVva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161243AbVKIVva (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbVKIVv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:51:29 -0500
Received: from mail04.solnet.ch ([212.101.4.138]:7892 "EHLO mail04.solnet.ch")
	by vger.kernel.org with ESMTP id S1161243AbVKIVv1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:51:27 -0500
From: Damir Perisa <damir.perisa@solnet.ch>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [patch] Re: 2.6.14-rc5-mm1 - ide-cs broken!
Date: Wed, 9 Nov 2005 22:48:17 +0100
User-Agent: KMail/1.8.3
Cc: Richard Purdie <rpurdie@rpsys.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Kay Sievers <kay.sievers@vrfy.org>
References: <20051103220305.77620d8f.akpm@osdl.org> <1131557221.8506.76.camel@localhost.localdomain> <43726269.7020600@tmr.com>
In-Reply-To: <43726269.7020600@tmr.com>
X-Face: +)fhYFmn|<pyRIlgch_);krg#jn!^z'?xy(Ur#Z6rZi)KD+_-V<Y@i>0pOVfJ4<=?iso-8859-1?q?Q1/=26/=26z=0A=093cxqRa=3B7O=5C4g=5C=7C=5DF-!H0!ew9kx1LqK/?=
 =?iso-8859-1?q?iPOv8eXi=26I7=60Pez0V0VNMAxnqRL8-30qqKK=3DxGM=0A=09pExQc=5B?=
 =?iso-8859-1?q?2=7Cl6v=23?=<iwBvEO9+h|_YS[48z%/kuD2*aT*S/$0323VCL3V9?@}jq<
 =?iso-8859-1?q?Ns6V=3A0m=27Qia=0A=09?="[#oJg[RVe}Sy/lP95E@pa[vdKzqLqn&M`exb91"`,<k`3;Vt97cLjhub0.v+]m`%|>@Z(
 =?iso-8859-1?q?=0A=09EeC/zU7=25?=@"L6mi#..8Q^M
Alanine: true
Glycine: true
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4229888.xR6lfaXGis";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200511092248.23331.damir.perisa@solnet.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4229888.xR6lfaXGis
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le Wednesday 09 November 2005 21:56, Bill Davidsen a =E9crit=A0:
 | There are, at minimum, three possible hardware attach cases, each of
 | which may be on a distribution which uses udev or not. I'm assuming
 | that if this is a udev problem is would be fixed at the udev level,
 | but your comment on "userspace hacks" does sound like fixes to
 | userspace bugs.
=20
udev+hotplug interaction causing loops is only a bug, because the CF=20
(ide-cs) is detected as removable, but it is not. (at least that's how i=20
understand it) of course, one can start arguing, that such looping should=20
be somehow inhibited by udev or hotplug and i'm not very much used to the=20
procedures there that may have possibilities for such an inhibition for=20
looping, but it sounds to me like fighting symptoms. curing the patient=20
(sorry for this analogy) is in almost all cases better and this means=20
here --- as long i understand it --- to have a proper handling of CF in=20
the kernel, so that the userspace tools do not get the chance to mess=20
with procedures. :P

redhat and a lot of other distributions have udev workaround lines in=20
their udev.rules to hinder it looping, but in the end, this are only=20
workarounds and not solid solutions. (assigning "no_volume_id" to=20
something is not a really nice way)

 | The three attach methods are pcmcia, direct plugin slots (laptops only
 | AFAIK), and USB devices.
=20
on the macroscopic scale, you are right. but as far i know (i'm no kernel=20
coder), a USB-CF reader is identified as usb-storage device and the=20
controler in the CF itself is not used by the kernel but by the reader=20
itself. the kernel does not communicate with the CF card but with the=20
reader and thinks of it as a removable device (where the CF is the=20
medium). firewire-CF readers work in the same way using sbp2 driver=20
instead of usb-storage. the kernel thinks, it addresses just another=20
usb-storage or sbp2 device.=20

i think that's also the reason, why my girlfriend's fw-CF reader is=20
echo'ing this lines, if connected to the computer:
	sda: asking for cache data failed
	sda: assuming drive cache: write through
but that's another story...

the pcmcia attach method is different to the usb/fw-reader one. the CF is=20
directly accessed by the kernel and its controler directly communicating=20
with ide-cs. how this happens in detail, i don't know in detail, but the=20
difference is that the controler is directly addressed by the kernel and=20
is therefore the device. the media is in fact just the chips in the CF=20
inside in this case. (whereas in usb/fw-reader, the "media" is the whole=20
CF card) so in this case, you cannot remove the media if the CF is=20
plugged into your pcmcia slot. (except if you are very good at hardware=20
surgery and have money for new CF's ;)

so as summary:
there are at least four methods (usb reader, fw reader, direct slot,=20
pcmcia-cf) -- or 2 basically different ones (indirect (reader=3Ddevice=20
cf=3Dmedia) and direct (cf=3Ddevice with media inside))

now i hope that i didn't make a mistake here, because i'm no expert; only=20
longterm linux user with experience from 2.0-2.6 kernels. i try to use as=20
little workarounds as possible, because cure is always better than=20
fighting symptoms. :D

greetings,
Damir

=2D-=20
Youth is when you blame all your troubles on your parents; maturity is
when you learn that everything is the fault of the younger generation.

--nextPart4229888.xR6lfaXGis
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDcm6nPABWKV6NProRAm6DAJsHDIs0nGPTG0DmkCShXgzEPFsbpgCcDdEX
goyv3yncu7CQB8/WgQaxH10=
=jIot
-----END PGP SIGNATURE-----

--nextPart4229888.xR6lfaXGis--
