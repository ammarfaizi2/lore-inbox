Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbTKSHew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 02:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbTKSHew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 02:34:52 -0500
Received: from smtp01.web.de ([217.72.192.180]:5127 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263886AbTKSHet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 02:34:49 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: linux-2.6.0-test9-mm3_acpi-pm-monotonic-fix_A0
Date: Wed, 19 Nov 2003 08:34:23 +0100
User-Agent: KMail/1.5.9
Cc: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       "Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, cat@zip.com.au,
       gawain@freda.homelinux.org, gene.heskett@verizon.net,
       papadako@csd.uoc.gr, Dominik Brodowski <linux@brodo.de>
References: <1069071092.3238.5.camel@localhost.localdomain> <200311180046.14787.thomas.schlichter@web.de> <1069196353.11424.2179.camel@cog.beaverton.ibm.com>
In-Reply-To: <1069196353.11424.2179.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_/zxu/RY6OPGAphD";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200311190834.23873.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_/zxu/RY6OPGAphD
Content-Type: multipart/mixed;
  boundary="Boundary-01=_/zxu/g+R2ljaT6o"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_/zxu/g+R2ljaT6o
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 18 November 2003 23:59, john stultz wrote:
> On Mon, 2003-11-17 at 15:46, Thomas Schlichter wrote:
> > But when booting with the PMTMR clock selected, my Interactivity test
> > fails again. :-( Maybe there is a problem in the PMTMR's monotonic clock
> > part...?!
>
> Good call! I was mis-adding in conversion to nanoseconds. The patch
> below should fix it (Andrew, feel free to ignore this, I'll sync up all
> the acpi-pm changes with you later).

Well, your patch was the correct direction, but it did not completely reach=
=20
the target... :-( The 'monotonic_base' variable in the PMTMR stores its val=
ue=20
in microseconds. So the 'base' value has to be convertet to nanoseconds,=20
too...

A patch that corrects that is attached...

(Btw. another solution would be to store all the values in nanoseconds by=20
replacing the cyc2us function with a cyc2ns function...)

> Although I'm finding that the sched_clock->monotonic_clock patch doesn't
> look like a win. With that patch sched_clock takes ~400-700 cycles using
> clock=3Dpmtmr. With your "fix-sched_clock.diff" patch its less then 40
> cycles.
>
> While better accuracy is nice, I can't imagine the 10-20x cost of
> sched_clock is worth it. So I think your fix is the best solution.

I think you are right, but the sched_clock->monotonic_clock patch helped us=
=20
finding the problems in the monotonic_clock_pmtmr() function... ;-)

> thanks
> -john

np ;-)
   Thomas

--Boundary-01=_/zxu/g+R2ljaT6o
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="fix-monotonic_pmtmr-2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="fix-monotonic_pmtmr-2.diff"

=2D-- linux-2.6.0-test9-mm3_patched/arch/i386/kernel/timers/timer_pm.c.orig=
	Wed Nov 19 08:05:19 2003
+++ linux-2.6.0-test9-mm3_patched/arch/i386/kernel/timers/timer_pm.c	Wed No=
v 19 08:07:41 2003
@@ -150,7 +150,7 @@ static unsigned long long monotonic_cloc
=20
 	/* convert to nanoseconds */
 	ret =3D ((this_offset - last_offset) & ACPI_PM_MASK);
=2D	ret =3D base + (cyc2us(ret)*1000);
+	ret =3D (base + cyc2us(ret)) * NSEC_PER_USEC;
 	return ret;
 }
=20

--Boundary-01=_/zxu/g+R2ljaT6o--

--Boundary-03=_/zxu/RY6OPGAphD
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/uxz/YAiN+WRIZzQRAr/ZAKCTkdRJpKbMnMSoD7EsLlc0H+SpfACg1Aaw
6Td7D9BpQhOLA7CZgG5xvgY=
=uNzI
-----END PGP SIGNATURE-----

--Boundary-03=_/zxu/RY6OPGAphD--
