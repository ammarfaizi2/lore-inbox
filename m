Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbVIAGah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVIAGah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 02:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbVIAGah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 02:30:37 -0400
Received: from smtp08.web.de ([217.72.192.226]:23469 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S965032AbVIAGag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 02:30:36 -0400
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>, john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick
Date: Thu, 1 Sep 2005 08:29:32 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_P/pFDET6zAhQ9g1";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200509010829.35958.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_P/pFDET6zAhQ9g1
Content-Type: multipart/mixed;
  boundary="Boundary-01=_M/pFDrRbVL1iyCL"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_M/pFDrRbVL1iyCL
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Hi Srivatsa,=20

on LKML I did see your patch trying to increase the accuracy of tme pmtmr b=
y=20
directly converting the PM-timer-ticks to jiffies. I think this is a good=20
idea but as you already recognized, it is not completely correct...

There are at least these issues:
1. "offset_last" corresponds to the time when the last recognized
   jiffyoccoured. So "delta" always corresponds to the time from the last
   recognized jiffy to _now_. "monotonic_base" is increased by delta, so af=
ter
   the first run it will correspond to _now_. But the next time the
   offset-time between the last recognized jiffy and the last _now_ is added
   _again_. So the monotonic clock ist too fast...
2. "offset_last is modified outside the "monotonic_lock", what is not allow=
ed.

I fixed these issues by using most of the old code, but simply changed "del=
ta"=20
and "offset_delay" to always contain PM-timer-ticks and compute the lost=20
jiffies directly using PMTMR_TICKS_PER_JIFFY.

I tested the attached patch during the last night and it sems to work...

Best regards
  Thomas Schlichter

--Boundary-01=_M/pFDrRbVL1iyCL
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pmtmr_accuracy.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="pmtmr_accuracy.patch"

=2D-- linux-2.6.13/arch/i386/kernel/timers/timer_pm.c.orig	2005-08-31 23:34=
:11.000000000 +0200
+++ linux-2.6.13/arch/i386/kernel/timers/timer_pm.c	2005-09-01 00:08:20.000=
000000 +0200
@@ -28,6 +28,7 @@
 #define PMTMR_TICKS_PER_SEC 3579545
 #define PMTMR_EXPECTED_RATE \
   ((CALIBRATE_LATCH * (PMTMR_TICKS_PER_SEC >> 10)) / (CLOCK_TICK_RATE>>10))
+#define PMTMR_TICKS_PER_JIFFY (PMTMR_TICKS_PER_SEC / HZ)
=20
=20
 /* The I/O port the PMTMR resides at.
@@ -128,6 +129,11 @@ pm_good:
 		return -ENODEV;
=20
 	init_cpu_khz();
+
+	printk ("Using %u PM timer ticks per jiffy \n", PMTMR_TICKS_PER_JIFFY);
+
+	offset_tick =3D read_pmtmr();
+
 	return 0;
 }
=20
@@ -151,7 +157,6 @@ static inline u32 cyc2us(u32 cycles)
 static void mark_offset_pmtmr(void)
 {
 	u32 lost, delta, last_offset;
=2D	static int first_run =3D 1;
 	last_offset =3D offset_tick;
=20
 	write_seqlock(&monotonic_lock);
@@ -161,29 +166,23 @@ static void mark_offset_pmtmr(void)
 	/* calculate tick interval */
 	delta =3D (offset_tick - last_offset) & ACPI_PM_MASK;
=20
=2D	/* convert to usecs */
=2D	delta =3D cyc2us(delta);
=2D
 	/* update the monotonic base value */
=2D	monotonic_base +=3D delta * NSEC_PER_USEC;
+	monotonic_base +=3D cyc2us(delta) * NSEC_PER_USEC;
 	write_sequnlock(&monotonic_lock);
=20
 	/* convert to ticks */
 	delta +=3D offset_delay;
=2D	lost =3D delta / (USEC_PER_SEC / HZ);
=2D	offset_delay =3D delta % (USEC_PER_SEC / HZ);
+	lost =3D delta / PMTMR_TICKS_PER_JIFFY;
+	offset_delay =3D delta % PMTMR_TICKS_PER_JIFFY;
=20
=20
 	/* compensate for lost ticks */
 	if (lost >=3D 2)
 		jiffies_64 +=3D lost - 1;
=20
=2D	/* don't calculate delay for first run,
=2D	   or if we've got less then a tick */
=2D	if (first_run || (lost < 1)) {
=2D		first_run =3D 0;
+	/* don't calculate delay if we've got less then a tick */
+	if (lost < 1)
 		offset_delay =3D 0;
=2D	}
 }
=20
=20
@@ -233,9 +232,9 @@ static unsigned long get_offset_pmtmr(vo
=20
 	offset =3D offset_tick;
 	now =3D read_pmtmr();
=2D	delta =3D (now - offset)&ACPI_PM_MASK;
+	delta =3D (now - offset) & ACPI_PM_MASK;
=20
=2D	return (unsigned long) offset_delay + cyc2us(delta);
+	return (unsigned long) cyc2us(delta + offset_delay);
 }
=20
=20

--Boundary-01=_M/pFDrRbVL1iyCL--

--Boundary-03=_P/pFDET6zAhQ9g1
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBDFp/PYAiN+WRIZzQRAi2aAJ48MjGDZLMRcxGwmmIpgwJiep/5pACdE8lR
bK0AMsymfEEPCsy/55VFtjQ=
=4LRF
-----END PGP SIGNATURE-----

--Boundary-03=_P/pFDET6zAhQ9g1--

