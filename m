Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286980AbRL1SnQ>; Fri, 28 Dec 2001 13:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286979AbRL1SnH>; Fri, 28 Dec 2001 13:43:07 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:24080 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286984AbRL1Smy>; Fri, 28 Dec 2001 13:42:54 -0500
Date: Fri, 28 Dec 2001 10:45:50 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: lkml <linux-kernel@vger.kernel.org>
cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] scheduler values adjustment ...
Message-ID: <Pine.LNX.4.40.0112281042160.975-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, this change some default value after having observed values
distribution. dyn_prio changed to unsigned and increased mm affinity
bonus.



- Davide





diff -Nru linux-2.5.2-pre3.vanilla/include/linux/sched.h linux-2.5.2-pre3.psch/include/linux/sched.h
--- linux-2.5.2-pre3.vanilla/include/linux/sched.h	Thu Dec 27 20:11:25 2001
+++ linux-2.5.2-pre3.psch/include/linux/sched.h	Fri Dec 28 10:37:17 2001
@@ -302,7 +302,7 @@
  * all fields in a single cacheline that are needed for
  * the goodness() loop in schedule().
  */
-	long dyn_prio;
+	unsigned long dyn_prio;
 	long nice;
 	unsigned long policy;
 	struct mm_struct *mm;
@@ -452,7 +452,7 @@
  */
 #define _STK_LIM	(8*1024*1024)

-#define MAX_DYNPRIO	100
+#define MAX_DYNPRIO	40
 #define DEF_TSLICE	(6 * HZ / 100)
 #define MAX_TSLICE	(20 * HZ / 100)
 #define DEF_NICE	(0)
diff -Nru linux-2.5.2-pre3.vanilla/kernel/sched.c linux-2.5.2-pre3.psch/kernel/sched.c
--- linux-2.5.2-pre3.vanilla/kernel/sched.c	Thu Dec 27 20:11:25 2001
+++ linux-2.5.2-pre3.psch/kernel/sched.c	Fri Dec 28 09:29:36 2001
@@ -70,6 +70,7 @@

 #define NICE_TO_TICKS(nice)	(TICK_SCALE(20-(nice))+1)

+#define MM_AFFINITY_BONUS	4

 /*
  *	Init task must be ok at boot for the ix86 as we will check its signals
@@ -181,7 +182,7 @@

 		/* .. and a slight advantage to the current MM */
 		if (p->mm == this_mm || !p->mm)
-			weight += 1;
+			weight += MM_AFFINITY_BONUS;
 		weight += 20 - p->nice;
 		goto out;
 	}
@@ -533,7 +534,7 @@
 		p->need_resched = 1;
 	else {
 		if (!--p->time_slice) {
-			if (p->dyn_prio > 0) {
+			if (p->dyn_prio) {
 				--p->time_slice;
 				--p->dyn_prio;
 			}


