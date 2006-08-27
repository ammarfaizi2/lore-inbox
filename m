Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWH0IeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWH0IeA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 04:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbWH0IeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 04:34:00 -0400
Received: from adsl-230-146.dsl.uva.nl ([146.50.230.146]:40852 "EHLO
	pan.var.cx") by vger.kernel.org with ESMTP id S1750829AbWH0IeA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 04:34:00 -0400
Date: Sun, 27 Aug 2006 10:34:38 +0200
From: Frank v Waveren <fvw@var.cx>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ktime_t overflow from sys_nanosleep
Message-ID: <20060827083438.GA6931@var.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On systems where longs are 64 bits, nanosleep can pass a timespec with
tv_sec larger than 18446744073 (approx 2^34), which is then multiplied=20
by NSEC_PER_SEC and stuffed into a single s64 by ktime_set in
hrtimer_nanosleep. This overflows of course, and causes the sleep to
return early (instantly if you set the timespec to its maximum).

(this gets triggered by doing a "sleep inf" with the sleep from the
gnu coreutils).


I can think of two solutions, either increase the size of ktime_t to
something larger than 64 bits, which would probably bring along a host
of issues and and lose the entire point of having a single scalar, or
we can limit the range of sys_nanosleep, which is simple, but will have
to be documented and sleep(1) will still need fixing.

I've put the check in timespec_valid in the attached patch. This will
limit the range of timespecs in general, but since most of them seem
to end up as ktime_t's anyway, it seems like a reasonable precaution.

Signed-off-by: Frank v Waveren <fvw@var.cx>

diff -urpN linux-2.6.17.11/include/linux/time.h linux-2.6.17.11-fvw/include=
/linux/time.h
--- linux-2.6.17.11/include/linux/time.h	2006-08-23 23:16:33.000000000 +0200
+++ linux-2.6.17.11-fvw/include/linux/time.h	2006-08-27 10:21:07.000000000 =
+0200
@@ -68,11 +68,13 @@ extern unsigned long mktime(const unsign
 extern void set_normalized_timespec(struct timespec *ts, time_t sec, long =
nsec);
=20
 /*
- * Returns true if the timespec is norm, false if denorm:
+ * Returns true iff the timespec nanoseconds is less than one second=20
+ * ("normalised") and the seconds is in the range 0..2**31:
  */
 #define timespec_valid(ts) \
-	(((ts)->tv_sec >=3D 0) && (((unsigned long) (ts)->tv_nsec) < NSEC_PER_SEC=
))
-
+        (((ts)->tv_sec >=3D 0) && (((ts)->tv_sec) <=3D (~(1<<31))) && \
+        (((unsigned long) (ts)->tv_nsec) < NSEC_PER_SEC))
+         =20
 extern struct timespec xtime;
 extern struct timespec wall_to_monotonic;
 extern seqlock_t xtime_lock;

--=20
Frank v Waveren                                  Key fingerprint: BDD7 D61E
fvw@var.cx                                              5D39 CF05 4BFC F57A
Public key: hkp://wwwkeys.pgp.net/468D62C8              FA00 7D51 468D 62C8

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFE8Vke+gB9UUaNYsgRAk/2AJ4y4UK2guY53NcfbE8vMZ7ad3cRvwCfbxtA
Ozu9NkzBkCShZednOJ0UirQ=
=BMoO
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
