Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWIBLEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWIBLEl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Sep 2006 07:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWIBLEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Sep 2006 07:04:40 -0400
Received: from adsl-230-146.dsl.uva.nl ([146.50.230.146]:57730 "EHLO
	pan.var.cx") by vger.kernel.org with ESMTP id S1751040AbWIBLEk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Sep 2006 07:04:40 -0400
Date: Sat, 2 Sep 2006 13:04:45 +0200
From: Frank v Waveren <fvw@var.cx>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] prevent timespec/timeval to ktime_t overflow
Message-ID: <20060902110445.GC3335@var.cx>
References: <1156927468.29250.113.camel@localhost.localdomain> <20060831204612.73ed7f33.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <20060831204612.73ed7f33.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's a different patch, which should actually sleep for the
specified amount of time up to 2^64 seconds with a loop around the
sleeps and a tally of how long is left to sleep. It does mean we wake
up once every 300 years on long sleeps, but that shouldn't cause any
huge performance problems.

It's not particularly pretty, the restart handler means there's a
little code duplication and the limit of 4 args in the restart block
is heaps of fun, but on the bright side this may avoid the hangs
Andrew was complaining of. As it's a patch to nanosleep instead of
timespec_to_ktime, it won't catch it if there are any other buggy
users. It should be compatible with Thomas' patch though, so once the
hangs on FC3 are resolved both could be used.

Thomas: This doesn't exactly preserve the pre-ktime behaviour, but I
assume that's ok if instead it does what it says on the tin?

Syscall restarts and such are new territory to me, so if people could
cast a critical eye over this for bugs I'd be most grateful.

Signed-off-by: Frank v Waveren <fvw@var.cx>

diff -urpN linux-2.6.17.11/include/linux/ktime.h linux-2.6.17.11-fvw/includ=
e/linux/ktime.h
--- linux-2.6.17.11/include/linux/ktime.h	2006-08-23 23:16:33.000000000 +02=
00
+++ linux-2.6.17.11-fvw/include/linux/ktime.h	2006-09-02 10:48:43.000000000=
 +0200
@@ -57,6 +57,7 @@ typedef union {
 } ktime_t;
=20
 #define KTIME_MAX			(~((u64)1 << 63))
+#define KTIME_SEC_MAX                   (KTIME_MAX / NSEC_PER_SEC)
=20
 /*
  * ktime_t definitions when using the 64-bit scalar representation:
diff -urpN linux-2.6.17.11/kernel/hrtimer.c linux-2.6.17.11-fvw/kernel/hrti=
mer.c
--- linux-2.6.17.11/kernel/hrtimer.c	2006-08-23 23:16:33.000000000 +0200
+++ linux-2.6.17.11-fvw/kernel/hrtimer.c	2006-09-02 12:07:02.000000000 +0200
@@ -706,31 +706,46 @@ static long __sched nanosleep_restart(st
 {
 	struct hrtimer_sleeper t;
 	struct timespec __user *rmtp;
-	struct timespec tu;
+	struct timespec tu, touter, tinner;
 	ktime_t time;
=20
 	restart->fn =3D do_no_restart_syscall;
=20
-	hrtimer_init(&t.timer, restart->arg3, HRTIMER_ABS);
-	t.timer.expires.tv64 =3D ((u64)restart->arg1 << 32) | (u64) restart->arg0;
-
-	if (do_nanosleep(&t, HRTIMER_ABS))
-		return 0;
-
-	rmtp =3D (struct timespec __user *) restart->arg2;
-	if (rmtp) {
-		time =3D ktime_sub(t.timer.expires, t.timer.base->get_time());
-		if (time.tv64 <=3D 0)
-			return 0;
-		tu =3D ktime_to_timespec(time);
-		if (copy_to_user(rmtp, &tu, sizeof(tu)))
-			return -EFAULT;
-	}
-
-	restart->fn =3D nanosleep_restart;
-
-	/* The other values in restart are already filled in */
-	return -ERESTART_RESTARTBLOCK;
+	time.tv64=3D(((u64)restart->arg1 & 0xFFFFFF) << 32) | (u64) restart->arg0;
+	touter=3Dktime_to_timespec(time);
+        touter.tv_sec +=3D (u64)restart->arg1 >> 32;
+  =20
+        while (unlikely(touter.tv_sec > 0 || touter.tv_nsec > 0))
+   	{
+	        tinner.tv_sec =3D touter.tv_sec % KTIME_SEC_MAX;
+                touter.tv_sec -=3D tinner.tv_sec;
+                tinner.tv_nsec =3D touter.tv_nsec;
+                touter.tv_nsec =3D 0;
+
+
+	        hrtimer_init(&t.timer, restart->arg3, HRTIMER_ABS);
+		t.timer.expires =3D timespec_to_ktime(tinner);
+
+		if (do_nanosleep(&t, HRTIMER_ABS))
+			continue;
+
+		rmtp =3D (struct timespec __user *) restart->arg2;
+		if (rmtp) {
+			time =3D ktime_sub(t.timer.expires, t.timer.base->get_time());
+			if (time.tv64 <=3D 0)
+				continue;
+			tu =3D ktime_to_timespec(time);
+			if (copy_to_user(rmtp, &tu, sizeof(tu)))
+				return -EFAULT;
+		}
+
+		restart->fn =3D nanosleep_restart;
+
+		/* The other values in restart are already filled in */
+		return -ERESTART_RESTARTBLOCK;
+        }
+   =09
+   return 0;
 }
=20
 long hrtimer_nanosleep(struct timespec *rqtp, struct timespec __user *rmtp,
@@ -738,35 +753,55 @@ long hrtimer_nanosleep(struct timespec *
 {
 	struct restart_block *restart;
 	struct hrtimer_sleeper t;
-	struct timespec tu;
+	struct timespec tu, touter, tinner;
 	ktime_t rem;
=20
-	hrtimer_init(&t.timer, clockid, mode);
-	t.timer.expires =3D timespec_to_ktime(*rqtp);
-	if (do_nanosleep(&t, mode))
-		return 0;
-
-	/* Absolute timers do not update the rmtp value and restart: */
-	if (mode =3D=3D HRTIMER_ABS)
-		return -ERESTARTNOHAND;
-
-	if (rmtp) {
-		rem =3D ktime_sub(t.timer.expires, t.timer.base->get_time());
-		if (rem.tv64 <=3D 0)
-			return 0;
-		tu =3D ktime_to_timespec(rem);
-		if (copy_to_user(rmtp, &tu, sizeof(tu)))
-			return -EFAULT;
-	}
+        touter=3D*rqtp;
+       =20
+        while (touter.tv_sec > 0 || touter.tv_nsec > 0)
+        {
+	        tinner.tv_sec =3D touter.tv_sec % KTIME_SEC_MAX;
+                touter.tv_sec -=3D tinner.tv_sec;
+                tinner.tv_nsec =3D touter.tv_nsec;
+                touter.tv_nsec =3D 0;
+          =20
+        	hrtimer_init(&t.timer, clockid, mode);
+		t.timer.expires =3D timespec_to_ktime(tinner);
+		if (do_nanosleep(&t, mode))
+		       	continue;
+
+		/* Absolute timers do not update the rmtp value and restart: */
+		if (mode =3D=3D HRTIMER_ABS)
+			return -ERESTARTNOHAND;
+
+		if (rmtp) {
+			rem =3D ktime_sub(t.timer.expires, t.timer.base->get_time());
+			if (rem.tv64 <=3D 0)
+				continue;
+			tu =3D ktime_to_timespec(rem);
+                        tu.tv_sec+=3Dtouter.tv_sec; /* No need to add tv_n=
sec, it always
+                                                   * gets fully handled on=
 the first=20
+                                                   * iteration */
+			if (copy_to_user(rmtp, &tu, sizeof(tu)))
+				return -EFAULT;
+		}
+
+		restart =3D &current_thread_info()->restart_block;
+		restart->fn =3D nanosleep_restart;
+		restart->arg0 =3D t.timer.expires.tv64 & 0xFFFFFFFF;
+                /* Iff longs are 64 bits, we may have a non-zero touter.tv=
_sec.
+                 * As long is 64 bits, the restart args are also 64 bits so
+                 * we can store the touter.tv_sec in the high 32 bits of=
=20
+                 * arg2 */
+		restart->arg1 =3D (t.timer.expires.tv64 >> 32) + ((u64)touter.tv_sec << =
32);
+		restart->arg2 =3D (unsigned long) rmtp;
+		restart->arg3 =3D (unsigned long) t.timer.base->index;
=20
-	restart =3D &current_thread_info()->restart_block;
-	restart->fn =3D nanosleep_restart;
-	restart->arg0 =3D t.timer.expires.tv64 & 0xFFFFFFFF;
-	restart->arg1 =3D t.timer.expires.tv64 >> 32;
-	restart->arg2 =3D (unsigned long) rmtp;
-	restart->arg3 =3D (unsigned long) t.timer.base->index;
+		return -ERESTART_RESTARTBLOCK;
+        }
=20
-	return -ERESTART_RESTARTBLOCK;
+   return 0;
+=09
 }
=20
 asmlinkage long


--=20
Frank v Waveren                                  Key fingerprint: BDD7 D61E
fvw@var.cx                                              5D39 CF05 4BFC F57A
Public key: hkp://wwwkeys.pgp.net/468D62C8              FA00 7D51 468D 62C8

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFE+WVN+gB9UUaNYsgRAnSiAKChxWRTGcmTTMIje8ZoJwuOVYwa0QCghx6d
vaxtfsAJw3y399IFQVDOto0=
=9bJe
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--

-- 
VGER BF report: H 0.164661
