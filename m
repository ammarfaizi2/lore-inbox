Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSJWExL>; Wed, 23 Oct 2002 00:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262850AbSJWExL>; Wed, 23 Oct 2002 00:53:11 -0400
Received: from mx20b.rmci.net ([205.162.184.38]:18905 "HELO mx20b.rmci.net")
	by vger.kernel.org with SMTP id <S262838AbSJWExK>;
	Wed, 23 Oct 2002 00:53:10 -0400
Subject: [PATCH] niceness magic numbers, 2.4.20-pre11
From: Kristis Makris <devcore@freeuk.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-eLmEN2RV0tUCChKHk8BH"
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 Oct 2002 21:59:17 -0700
Message-Id: <1035349158.491.29.camel@mcmicro>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-eLmEN2RV0tUCChKHk8BH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This untested patch removes use of process priority magic numbers in
sys_nice, sys_setpriority, sys_getpriority, and properly uses their
#define'd values.

It would be nice if someone tested if it applies against 2.5.


--=-eLmEN2RV0tUCChKHk8BH
Content-Disposition: attachment; filename=niceness_magic_numbers.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=niceness_magic_numbers.patch; charset=ANSI_X3.4-1968

diff -ur linux-2.4.20-pre11.orig/include/linux/resource.h linux/include/lin=
ux/resource.h
--- linux-2.4.20-pre11.orig/include/linux/resource.h	Tue Jun 18 20:10:36 20=
02
+++ linux/include/linux/resource.h	Sat Oct 19 13:55:10 2002
@@ -43,7 +43,7 @@
 };
=20
 #define	PRIO_MIN	(-20)
-#define	PRIO_MAX	20
+#define	PRIO_MAX	19
=20
 #define	PRIO_PROCESS	0
 #define	PRIO_PGRP	1
diff -ur linux-2.4.20-pre11.orig/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.20-pre11.orig/kernel/sched.c	Sat Oct 19 13:26:59 2002
+++ linux/kernel/sched.c	Sat Oct 19 13:41:19 2002
@@ -870,17 +870,19 @@
 	if (increment < 0) {
 		if (!capable(CAP_SYS_NICE))
 			return -EPERM;
-		if (increment < -40)
-			increment =3D -40;
+
+		/* +1 to account for 0 in min<-->max range */
+		if (increment < PRIO_MIN - (PRIO_MAX + 1))
+			increment =3D PRIO_MIN - (PRIO_MAX + 1);
 	}
-	if (increment > 40)
-		increment =3D 40;
+	if (increment > -(PRIO_MIN - (PRIO_MAX + 1)))
+		increment =3D -(PRIO_MIN - (PRIO_MAX + 1));
=20
 	newprio =3D current->nice + increment;
-	if (newprio < -20)
-		newprio =3D -20;
-	if (newprio > 19)
-		newprio =3D 19;
+	if (newprio < PRIO_MIN)
+		newprio =3D PRIO_MIN;
+	if (newprio > PRIO_MAX)
+		newprio =3D PRIO_MAX;
 	current->nice =3D newprio;
 	return 0;
 }
diff -ur linux-2.4.20-pre11.orig/kernel/sys.c linux/kernel/sys.c
--- linux-2.4.20-pre11.orig/kernel/sys.c	Sat Oct 19 11:58:48 2002
+++ linux/kernel/sys.c	Sat Oct 19 13:37:48 2002
@@ -204,10 +204,10 @@
=20
 	/* normalize: avoid signed division (rounding problems) */
 	error =3D -ESRCH;
-	if (niceval < -20)
-		niceval =3D -20;
-	if (niceval > 19)
-		niceval =3D 19;
+	if (niceval < PRIO_MIN)
+		niceval =3D PRIO_MIN;
+	if (niceval > PRIO_MAX)
+		niceval =3D PRIO_MAX;
=20
 	read_lock(&tasklist_lock);
 	for_each_task(p) {
@@ -249,7 +249,8 @@
 		long niceval;
 		if (!proc_sel(p, which, who))
 			continue;
-		niceval =3D 20 - p->nice;
+		niceval =3D PRIO_MAX + 1 - p->nice; /* +1 to account for 0
+						   * in 0<-->max range */
 		if (niceval > retval)
 			retval =3D niceval;
 	}

--=-eLmEN2RV0tUCChKHk8BH--

