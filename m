Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315921AbSEGRyZ>; Tue, 7 May 2002 13:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315923AbSEGRyY>; Tue, 7 May 2002 13:54:24 -0400
Received: from zero.tech9.net ([209.61.188.187]:6928 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S315921AbSEGRyU>;
	Tue, 7 May 2002 13:54:20 -0400
Subject: [PATCH] 2.4-ac: separate max RT from max user RT
From: Robert Love <rml@tech9.net>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-3+LIWO5hSeqL/J6fdCSC"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-3) 
Date: 07 May 2002 10:54:28 -0700
Message-Id: <1020794069.807.27.camel@bigsur>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3+LIWO5hSeqL/J6fdCSC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

The attached patch separates the notion of "maximum real-time priority"
from what we actually export to user-space.  This will also us, in the
future, to have kernel threads with a greater RT priority than any user
task.

Right now the two values are set equal and thus the patch has no object
code changes.  It does provide a bit of a cleanup, however.

Patch is against 2.4.19-pre7-ac4, please apply.

	Robert Love


--=-3+LIWO5hSeqL/J6fdCSC
Content-Disposition: attachment; filename=sched-misc-rml-2.4.19-pre7-ac4-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=sched-misc-rml-2.4.19-pre7-ac4-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre7-ac4/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-pre7-ac4/kernel/sched.c	Mon Apr 29 12:33:23 2002
+++ linux/kernel/sched.c	Mon Apr 29 13:08:11 2002
@@ -22,13 +22,17 @@
 #include <linux/kernel_stat.h>
=20
 /*
- * Priority of a process goes from 0 to MAX_PRIO-1.  The
- * 0 to MAX_RT_PRIO-1 priority range is allocated to RT tasks,
- * the MAX_RT_PRIO to MAX_PRIO range is for SCHED_OTHER tasks.
- * Priority values are inverted: lower p->prio value means higher
- * priority.
+ * Priority of a process goes from 0 to 139. The 0-99
+ * priority range is allocated to RT tasks, the 100-139
+ * range is for SCHED_OTHER tasks. Priority values are
+ * inverted: lower p->prio value means higher priority.
+ *=20
+ * MAX_USER_RT_PRIO allows the actual maximum RT priority
+ * to be separate from the value exported to user-space.
+ * NOTE: MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
  */
 #define MAX_RT_PRIO		100
+#define MAX_USER_RT_PRIO	100
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
=20
 /*
@@ -1025,7 +1029,7 @@
  */
 int task_prio(task_t *p)
 {
-	return p->prio - MAX_RT_PRIO;
+	return p->prio - MAX_USER_RT_PRIO;
 }
=20
 int task_nice(task_t *p)
@@ -1082,11 +1086,11 @@
 	}
=20
 	/*
-	 * Valid priorities for SCHED_FIFO and SCHED_RR are 1..MAX_RT_PRIO-1,
-	 * valid priority for SCHED_OTHER is 0.
+	 * Valid priorities for SCHED_FIFO and SCHED_RR are
+	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_OTHER is 0.
 	 */
 	retval =3D -EINVAL;
-	if (lp.sched_priority < 0 || lp.sched_priority > MAX_RT_PRIO - 1)
+	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
 		goto out_unlock;
 	if ((policy =3D=3D SCHED_OTHER) !=3D (lp.sched_priority =3D=3D 0))
 		goto out_unlock;
@@ -1106,7 +1110,7 @@
 	p->policy =3D policy;
 	p->rt_priority =3D lp.sched_priority;
 	if (policy !=3D SCHED_OTHER)
-		p->prio =3D (MAX_RT_PRIO - 1) - p->rt_priority;
+		p->prio =3D MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio =3D p->static_prio;
 	if (array)
@@ -1229,7 +1233,7 @@
 	switch (policy) {
 	case SCHED_FIFO:
 	case SCHED_RR:
-		ret =3D MAX_RT_PRIO - 1;
+		ret =3D MAX_USER_RT_PRIO-1;
 		break;
 	case SCHED_OTHER:
 		ret =3D 0;

--=-3+LIWO5hSeqL/J6fdCSC--

