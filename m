Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030585AbWBNOdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030585AbWBNOdS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 09:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030586AbWBNOdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 09:33:18 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:49644 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030585AbWBNOdR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 09:33:17 -0500
Date: Tue, 14 Feb 2006 15:33:16 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: time patches by Roman Zippel
In-Reply-To: <43F1F2B4.7205.6BBE301@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Message-ID: <Pine.LNX.4.61.0602141515500.30994@scrub.home>
References: <43F195DF.23967.551458C@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
 <43F1F2B4.7205.6BBE301@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811837-547308765-1139927596=:30994"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811837-547308765-1139927596=:30994
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Tue, 14 Feb 2006, Ulrich Windl wrote:

> > > 15_time_offset and 18_time_freq change some well-known constants (lik=
e MAXPHASE)
> > > by three orders of magnitude.
>=20
> --- linux-2.6-mm.orig/include/linux/timex.h=092005-12-21 12:12:00.0000000=
00 +0100
> +++ linux-2.6-mm/include/linux/timex.h=092005-12-21 12:12:08.000000000 +0=
100
> @@ -95,11 +95,11 @@
>  #define SHIFT_USEC 16=09=09/* frequency offset scale (shift) */
>  #define FINENSEC (1L << SHIFT_SCALE) /* ~1 ns in phase units */
> =20
> -#define MAXPHASE 512000L        /* max phase error (us) */
> +#define MAXPHASE 500000000L=09/* max phase error (ns) */
>  #define MAXFREQ (512L << SHIFT_USEC)  /* max frequency error (ppm) */
>  #define MINSEC 16L              /* min interval between updates (s) */
>  #define MAXSEC 1200L            /* max interval between updates (s) */
> -#define=09NTP_PHASE_LIMIT=09(MAXPHASE << 5)=09/* beyond max. dispersion =
*/
> +#define NTP_PHASE_LIMIT=09((MAXPHASE / 1000) << 5) /* beyond max. disper=
sion */

The reference timex.h has the same change for MAXPHASE and NTP_PHASE_LIMIT=
=20
is Linux specific. Where is the problem?

> > > the new adjtime() (16_time_adjust, 12_time_adj) changes the semantics=
: Since about
> > > Linux 0.99, adjtime() had the adjtime_is_accurate property, i.e. on t=
he long term
> > > it behaved like an addition.
> >=20
> > I disagree, could you please explain how you come to this conclusion?
>=20
> +=09=09=09tick_nsec_curr +=3D time_adjust * 1000 / HZ;
>=20
> Assuming 1024Hz interrupt frequency:
> (1=B5s * 1000) / 1024 =3D=3D 0ns; 0 * 1024 =3D=3D 0=B5s, not 1=B5s
> (2=B5s * 1000) / 1024 =3D=3D 1ns; 1 * 1024 =3D=3D 1.024=B5s, not 2=B5s

Ok, I didn't put much effort into optimizing it for uncommon HZ values.=20
Why is it so important? It's currently unused on any Linux machine=20
synchronized via NTP.

> > The patches don't change the behaviour beyond that they increase=20
> > resolution and precision. Only the final patch changes the ntp code to=
=20
> > match the behaviour of ntp reference code without including all its mes=
s.
>=20
> It's quite hard to tell: The code is very different what I've ever seen.

Actually it's not that hard, under http://www.xs4all.nl/~zippel/ntp/ you=20
can also find the user space test code I used to verify it.
kernel.tar.Z is the old reference code, which the current Linux code is=20
based on, under patches-kernel you can find a number of patches to convert=
=20
it to the new model and which match the new kernel implementation.
I updated the kern.dat and added a nano.sh script with matching test=20
parameters for nanokernel, so you can compare the output of both test=20
programms.

bye, Roman
---1463811837-547308765-1139927596=:30994--
