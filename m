Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbUKMRpN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbUKMRpN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 12:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbUKMRpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 12:45:13 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:17893 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S261853AbUKMRo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 12:44:57 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] deprecate sleep_on()
Date: Sat, 13 Nov 2004 17:41:02 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_hkjlB3FLJuOIDBn";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411131741.06415.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_hkjlB3FLJuOIDBn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The use of sleep_on() and related functions has been discouraged
since before 2.4.0. Marking the calls deprecated hopefully
helps us phasing out the few remaining users. With this patch
we get eight new warnings in i386 defconfig, most of which
are about code that looks suspicious.

With i386 allmodconfig, I get new warnings in a total of 81 files,
mostly obscure device drivers.

=3D=3D=3D=3D=3D include/linux/wait.h 1.27 vs edited =3D=3D=3D=3D=3D
=2D-- 1.27/include/linux/wait.h	Tue Oct 19 11:40:20 2004
+++ edited/include/linux/wait.h	Sun Nov  7 16:26:13 2004
@@ -304,12 +304,35 @@
  * They are racy.  DO NOT use them, use the wait_event* interfaces above. =
=20
  * We plan to remove these interfaces during 2.7.
  */
=2Dextern void FASTCALL(sleep_on(wait_queue_head_t *q));
=2Dextern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
=2D				      signed long timeout));
=2Dextern void FASTCALL(interruptible_sleep_on(wait_queue_head_t *q));
=2Dextern long FASTCALL(interruptible_sleep_on_timeout(wait_queue_head_t *q,
=2D						    signed long timeout));
+void FASTCALL(__sleep_on(wait_queue_head_t *q));
+long FASTCALL(__sleep_on_timeout(wait_queue_head_t *q, signed long timeout=
));
+void FASTCALL(__interruptible_sleep_on(wait_queue_head_t *q));
+long FASTCALL(__interruptible_sleep_on_timeout(wait_queue_head_t *q,
+					    signed long timeout));
+
+static inline void __deprecated
+sleep_on(wait_queue_head_t *q)
+{
+	return __sleep_on(q);
+}
+
+static inline long __deprecated
+sleep_on_timeout(wait_queue_head_t *q, signed long timeout)
+{
+	return __sleep_on_timeout(q, timeout);
+}
+
+static inline void __deprecated
+interruptible_sleep_on(wait_queue_head_t *q)
+{
+	return __interruptible_sleep_on(q);
+}
+
+static inline long __deprecated
+interruptible_sleep_on_timeout(wait_queue_head_t *q, signed long timeout)
+{
+	return __interruptible_sleep_on_timeout(q, timeout);
+}
=20
 /*
  * Waitqueues which are removed from the waitqueue_head at wakeup time
=3D=3D=3D=3D=3D kernel/sched.c 1.377 vs edited =3D=3D=3D=3D=3D
=2D-- 1.377/kernel/sched.c	Sun Oct 31 17:38:43 2004
+++ edited/kernel/sched.c	Sun Nov  7 16:28:40 2004
@@ -2867,7 +2867,7 @@
 	__remove_wait_queue(q, &wait);			\
 	spin_unlock_irqrestore(&q->lock, flags);
=20
=2Dvoid fastcall __sched interruptible_sleep_on(wait_queue_head_t *q)
+void fastcall __sched __interruptible_sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
=20
@@ -2878,9 +2878,10 @@
 	SLEEP_ON_TAIL
 }
=20
=2DEXPORT_SYMBOL(interruptible_sleep_on);
+EXPORT_SYMBOL(__interruptible_sleep_on);
=20
=2Dlong fastcall __sched interruptible_sleep_on_timeout(wait_queue_head_t *=
q, long timeout)
+long fastcall __sched
+__interruptible_sleep_on_timeout(wait_queue_head_t *q, long timeout)
 {
 	SLEEP_ON_VAR
=20
@@ -2893,9 +2894,9 @@
 	return timeout;
 }
=20
=2DEXPORT_SYMBOL(interruptible_sleep_on_timeout);
+EXPORT_SYMBOL(__interruptible_sleep_on_timeout);
=20
=2Dvoid fastcall __sched sleep_on(wait_queue_head_t *q)
+void fastcall __sched __sleep_on(wait_queue_head_t *q)
 {
 	SLEEP_ON_VAR
=20
@@ -2906,9 +2907,9 @@
 	SLEEP_ON_TAIL
 }
=20
=2DEXPORT_SYMBOL(sleep_on);
+EXPORT_SYMBOL(__sleep_on);
=20
=2Dlong fastcall __sched sleep_on_timeout(wait_queue_head_t *q, long timeou=
t)
+long fastcall __sched __sleep_on_timeout(wait_queue_head_t *q, long timeou=
t)
 {
 	SLEEP_ON_VAR
=20
@@ -2921,7 +2922,7 @@
 	return timeout;
 }
=20
=2DEXPORT_SYMBOL(sleep_on_timeout);
+EXPORT_SYMBOL(__sleep_on_timeout);
=20
 void set_user_nice(task_t *p, long nice)
 {


--Boundary-02=_hkjlB3FLJuOIDBn
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBljkh5t5GS2LDRf4RAlNXAJsFmzAJaeLVkj1wfQ489FcRIQK0rQCfczMG
wnL19nSlgRwx+lSHoRIbTpA=
=lKmw
-----END PGP SIGNATURE-----

--Boundary-02=_hkjlB3FLJuOIDBn--
