Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315920AbSEGRxJ>; Tue, 7 May 2002 13:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315921AbSEGRxI>; Tue, 7 May 2002 13:53:08 -0400
Received: from zero.tech9.net ([209.61.188.187]:4880 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S315920AbSEGRxF>;
	Tue, 7 May 2002 13:53:05 -0400
Subject: [PATCH] 2.4-ac: more yield abstractions
From: Robert Love <rml@tech9.net>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-ZfO7Q8s7Xj7LoPttHme3"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-3) 
Date: 07 May 2002 10:53:05 -0700
Message-Id: <1020793986.800.21.camel@bigsur>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZfO7Q8s7Xj7LoPttHme3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Alan,

The attached patch should replace the remaining occurrences of

	current->policy |= SCHED_YIELD;
	schedule();

with

	yield();

I missed this previously because they are in arch-dependent non-x86
code.  Patch is against 2.4.19-pre7-ac4, please apply.

	Robert Love


--=-ZfO7Q8s7Xj7LoPttHme3
Content-Disposition: attachment; filename=sched-yield-rml-2.4.19-pre7-ac4-1.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=sched-yield-rml-2.4.19-pre7-ac4-1.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.19-pre7-ac4/arch/alpha/mm/fault.c linux/arch/alpha/mm/f=
ault.c
--- linux-2.4.19-pre7-ac4/arch/alpha/mm/fault.c	Mon Apr 29 12:34:59 2002
+++ linux/arch/alpha/mm/fault.c	Mon Apr 29 12:40:04 2002
@@ -196,8 +196,7 @@
  */
 out_of_memory:
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre7-ac4/arch/arm/mm/fault-common.c linux/arch/arm/m=
m/fault-common.c
--- linux-2.4.19-pre7-ac4/arch/arm/mm/fault-common.c	Mon Apr 29 12:35:15 20=
02
+++ linux/arch/arm/mm/fault-common.c	Mon Apr 29 12:40:18 2002
@@ -225,8 +225,7 @@
 	 * If we are out of memory for pid1,
 	 * sleep for a while and retry
 	 */
-	tsk->policy |=3D SCHED_YIELD;
-	schedule();
+	yield();
 	goto survive;
=20
 check_stack:
diff -urN linux-2.4.19-pre7-ac4/arch/ia64/mm/fault.c linux/arch/ia64/mm/fau=
lt.c
--- linux-2.4.19-pre7-ac4/arch/ia64/mm/fault.c	Mon Apr 29 12:35:19 2002
+++ linux/arch/ia64/mm/fault.c	Mon Apr 29 12:41:10 2002
@@ -196,8 +196,7 @@
   out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre7-ac4/arch/m68k/mm/fault.c linux/arch/m68k/mm/fau=
lt.c
--- linux-2.4.19-pre7-ac4/arch/m68k/mm/fault.c	Mon Apr 29 12:35:12 2002
+++ linux/arch/m68k/mm/fault.c	Mon Apr 29 12:40:48 2002
@@ -188,8 +188,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre7-ac4/arch/mips/mm/fault.c linux/arch/mips/mm/fau=
lt.c
--- linux-2.4.19-pre7-ac4/arch/mips/mm/fault.c	Mon Apr 29 12:35:02 2002
+++ linux/arch/mips/mm/fault.c	Mon Apr 29 12:40:26 2002
@@ -211,8 +211,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (tsk->pid =3D=3D 1) {
-		tsk->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre7-ac4/arch/mips64/mm/fault.c linux/arch/mips64/mm=
/fault.c
--- linux-2.4.19-pre7-ac4/arch/mips64/mm/fault.c	Mon Apr 29 12:35:22 2002
+++ linux/arch/mips64/mm/fault.c	Mon Apr 29 12:41:45 2002
@@ -240,8 +240,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (tsk->pid =3D=3D 1) {
-		tsk->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre7-ac4/arch/ppc/mm/fault.c linux/arch/ppc/mm/fault=
.c
--- linux-2.4.19-pre7-ac4/arch/ppc/mm/fault.c	Mon Apr 29 12:35:07 2002
+++ linux/arch/ppc/mm/fault.c	Mon Apr 29 12:40:37 2002
@@ -197,8 +197,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre7-ac4/arch/s390/mm/fault.c linux/arch/s390/mm/fau=
lt.c
--- linux-2.4.19-pre7-ac4/arch/s390/mm/fault.c	Mon Apr 29 12:35:23 2002
+++ linux/arch/s390/mm/fault.c	Mon Apr 29 12:41:54 2002
@@ -290,8 +290,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (tsk->pid =3D=3D 1) {
-		tsk->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre7-ac4/arch/s390x/mm/fault.c linux/arch/s390x/mm/f=
ault.c
--- linux-2.4.19-pre7-ac4/arch/s390x/mm/fault.c	Mon Apr 29 12:35:24 2002
+++ linux/arch/s390x/mm/fault.c	Mon Apr 29 12:42:06 2002
@@ -290,8 +290,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (tsk->pid =3D=3D 1) {
-		tsk->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}
diff -urN linux-2.4.19-pre7-ac4/arch/sh/mm/fault.c linux/arch/sh/mm/fault.c
--- linux-2.4.19-pre7-ac4/arch/sh/mm/fault.c	Mon Apr 29 12:35:18 2002
+++ linux/arch/sh/mm/fault.c	Mon Apr 29 12:41:01 2002
@@ -207,8 +207,7 @@
 out_of_memory:
 	up_read(&mm->mmap_sem);
 	if (current->pid =3D=3D 1) {
-		current->policy |=3D SCHED_YIELD;
-		schedule();
+		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
 	}

--=-ZfO7Q8s7Xj7LoPttHme3--

