Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbTKQTqq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 14:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTKQTqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 14:46:46 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:55739 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261217AbTKQTql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 14:46:41 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       "Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
Date: Mon, 17 Nov 2003 20:46:13 +0100
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org, cat@zip.com.au, gawain@freda.homelinux.org,
       gene.heskett@verizon.net, papadako@csd.uoc.gr
References: <1069071092.3238.5.camel@localhost.localdomain> <3FB8C92E.7030201@gmx.de>
In-Reply-To: <3FB8C92E.7030201@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_JWSu/1Sp5XomtXd";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200311172046.17736.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_JWSu/1Sp5XomtXd
Content-Type: multipart/mixed;
  boundary="Boundary-01=_FWSu/MDC+mdRUe4"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_FWSu/MDC+mdRUe4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi!

On Monday 17 November 2003 14:12, Prakash K. Cheemplavam wrote:
> Ronny V. Vindenes wrote:
> > I've found that neither linus.patch nor
> > context-switch-accounting-fix.patch is causing the problem, but rather
> > acpi-pm-timer-fixes.patch & acpi-pm-timer.patch
> >
> > With these applied my cpu (athlon64) is detected as 0.0Mhz, bogomips
> > drops to 50% and anything cpu intensive destroys interactivity. Revert
> > them and performance is back at -mm2 level.
>
> Yup, works for me too. Reverting those patches and my machine is smooth
> again. :)
>
> Prakash

I was able to reproduce the interactivity problem, too. My simple testcase=
=20
was:
1. open a KDE Konsole
2. execute "while true; do a=3D2; done" in the Konsole
3. Move the Konsole window.

With test9-mm3 booted with "clock=3Dpit" or "clock=3Dpmtmr" moving the wind=
ow was=20
very sluggish... Booted with "clock=3Dtsc" made it work fine again. (Btw. w=
hich=20
kind of hardware is needed to make "clock=3Dhpet" work?)

The problem is that sched_clock() uses the TSC if the hardware supports it.=
=20
But the needed scaling factors are only initialized in init_tsc() and=20
init_hpet(). So there are 2 possibilities to fix this:
1. Call the neccessary parts of init_tsc() in init_pmtmr() and init_pit().
2. Use the TSC in sched_clock() only if "clock=3Dtsc" was set.

I've attached a small patch that does the 2nd thing. For me it fixed the=20
interactivity problem...

The 2nd attached patch adds the .name field to the timer_pmtmr struct. This=
=20
makes the kernel to show "Using pmtmr for high-res timesource" instead of=20
"Using NULL for high-res timesource" when booting...

Andrew, please consider applying the patches...

Btw. the BogoMIPS value is the argument for the __delay() function needed t=
o=20
wait 1 jiffy. The difference is that the TSC version of this function uses=
=20
the clock cycle count as its argument whereas the PMTMR and PIT versions ta=
ke=20
the count of loops to wait as their argument. Well, and it seems that each=
=20
loop iteration needs 2 clock cycles.

The problem with the shown CPU frequency is, that cpu_khz is only set in=20
init_tsc() and init_hpet(). But I don't know how this can be fixed without=
=20
using the TSC...

Best regards
   Thomas

--Boundary-01=_FWSu/MDC+mdRUe4
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix-sched_clock.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="fix-sched_clock.diff"

=2D-- linux-2.6.0-test9-mm3/arch/i386/kernel/timers/timer_tsc.c	Sat Nov 15 =
18:09:24 2003
+++ linux-2.6.0-test9-mm3_patched/arch/i386/kernel/timers/timer_tsc.c	Mon N=
ov 17 19:27:36 2003
@@ -32,7 +32,7 @@ int tsc_disable __initdata =3D 0;
 extern spinlock_t i8253_lock;
 extern volatile unsigned long jiffies;
=20
=2Dstatic int use_tsc;
+static int use_tsc =3D 0;
 /* Number of usecs that the last interrupt was delayed */
 static int delay_at_last_interrupt;
=20
@@ -139,7 +139,7 @@ unsigned long long sched_clock(void)
 	 * synchronized across all CPUs.
 	 */
 #ifndef CONFIG_NUMA
=2D	if (unlikely(!cpu_has_tsc))
+	if (!use_tsc)
 #endif
 		return (unsigned long long)jiffies * (1000000000 / HZ);
=20

--Boundary-01=_FWSu/MDC+mdRUe4
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="pmtmr-name-diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="pmtmr-name-diff"

=2D-- linux-2.6.0-test9-mm3/arch/i386/kernel/timers/timer_pm.c	Sat Nov 15 1=
8:09:24 2003
+++ linux-2.6.0-test9-mm3_patched/arch/i386/kernel/timers/timer_pm.c	Mon No=
v 17 19:29:30 2003
@@ -185,6 +185,7 @@ static unsigned long get_offset_pmtmr(vo
=20
 /* acpi timer_opts struct */
 struct timer_opts timer_pmtmr =3D {
+	.name			=3D "pmtmr",
 	.init 			=3D init_pmtmr,
 	.mark_offset		=3D mark_offset_pmtmr,
 	.get_offset		=3D get_offset_pmtmr,

--Boundary-01=_FWSu/MDC+mdRUe4--

--Boundary-03=_JWSu/1Sp5XomtXd
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/uSWJYAiN+WRIZzQRAnyDAKD+15i4RzX8WWaODMvH7fK4sn5fggCg1ce1
EL3x0ctwtUNuAtu5ge1shxE=
=q6zk
-----END PGP SIGNATURE-----

--Boundary-03=_JWSu/1Sp5XomtXd--
