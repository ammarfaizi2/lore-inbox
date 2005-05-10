Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVEJLzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVEJLzT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 07:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVEJLzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 07:55:19 -0400
Received: from pop.gmx.de ([213.165.64.20]:25324 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261617AbVEJLzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 07:55:06 -0400
X-Authenticated: #153925
From: Bernd Paysan <bernd.paysan@gmx.de>
To: Andi Kleen <ak@suse.de>
Subject: Re: [suse-amd64] False "lost ticks" on dual-Opteron system (=> timer twice as fast)
Date: Tue, 10 May 2005 13:54:53 +0200
User-Agent: KMail/1.8
Cc: suse-amd64@suse.com, linux-kernel@vger.kernel.org
References: <200505081445.26663.bernd.paysan@gmx.de> <200505091517.30555.bernd.paysan@gmx.de> <20050510111223.GH25612@wotan.suse.de>
In-Reply-To: <20050510111223.GH25612@wotan.suse.de>
MIME-Version: 1.0
Message-Id: <200505101355.00341.bernd.paysan@gmx.de>
Content-Type: multipart/signed;
  boundary="nextPart3714566.A4kaZjVG7S";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3714566.A4kaZjVG7S
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 10 May 2005 13:12, Andi Kleen wrote:
> > So that explains why nobody sees this problem. But the TSC-based
> > fallback timekeeping is still broken on SMP systems with PowerNow and
> > distributed IRQ handling, which both together seem to be rare enough
> > ;-).
>
> There is a patch pending for the TSC problem - using the pmtimer instead
> in this case.
>
> But the distributed timer interrupt problem is weird. It should not
> happen. You sure it was IRQ 0 that was duplicated and not "LOC" ?

Yes. Only one CPU actually gets and handles the timer interrupt, but which=
=20
one is somewhat random (for about 10 seconds, it's the same CPU, then it=20
switches over).

> When you watch -n1 cat /proc/interrupts does the rate roughly match
> up to 1000Hz?

Yes, and this is confirmed over longer time:

# grep timer /proc/interrupts; uptime
  0:   40347440   40582285    IO-APIC-edge  timer
  1:26pm  an  22:28,  1 user,  Durchschnittslast: 0,00, 0,01, 0,04
# echo $[(3600*22+28*60)*1000] $[40347440+40582285]
80880000 80929725

Given that uptime is only accurate to the minute, this sounds very=20
reasonable. The distribution also is close to 50:50. That's (almost) true=20
for all interrupt sources:

 # cat /proc/interrupts=20
           CPU0       CPU1      =20
  0:   40523846   40753939    IO-APIC-edge  timer
  1:          3        189    IO-APIC-edge  i8042
  8:        261        280    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 15:     364369     364479    IO-APIC-edge  ide1
169:      59195      55498   IO-APIC-level  3w-9xxx
177:     618198     604643   IO-APIC-level  3w-9xxx
185:    8195891    8147619   IO-APIC-level  aic79xx, eth1
193:          0         30   IO-APIC-level  aic79xx
201:          0          0   IO-APIC-level  ohci_hcd, ohci_hcd
NMI:       1184       1013=20
LOC:   81273966   81271958=20
ERR:          0
MIS:          0

=2D-=20
Bernd Paysan
"If you want it done right, you have to do it yourself"
http://www.jwdt.com/~paysan/

--nextPart3714566.A4kaZjVG7S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCgKEUi4ILt2cAfDARAg/HAKCtm/QVxwtRyFF9esYehFEVPQOZQQCg38XZ
IYGYrISsCry4CuCYkW2YvCI=
=0Q2S
-----END PGP SIGNATURE-----

--nextPart3714566.A4kaZjVG7S--
