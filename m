Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288969AbSATXrH>; Sun, 20 Jan 2002 18:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288971AbSATXq6>; Sun, 20 Jan 2002 18:46:58 -0500
Received: from zero.tech9.net ([209.61.188.187]:10506 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288969AbSATXqq>;
	Sun, 20 Jan 2002 18:46:46 -0500
Subject: [PATCH] O(1) scheduler unlock_task_rq
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1011569639.850.354.camel@phantasy>
In-Reply-To: <1011569639.850.354.camel@phantasy>
Content-Type: multipart/mixed; boundary="=-3XPKomiSZwDPPGAcItvB"
X-Mailer: Evolution/1.0.1 
Date: 20 Jan 2002 18:50:52 -0500
Message-Id: <1011570657.850.362.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3XPKomiSZwDPPGAcItvB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

In Ingo's new O(1) scheduler, unlock_task_rq takes a pointless argument
(task_t * p).

This patch, against 2.5.3-pre2 + J2, removes the argument and fixes all
known uses of the function.

	Robert Love

--=-3XPKomiSZwDPPGAcItvB
Content-Disposition: attachment; filename=sched-fixes-2.5.3-pre2-J2.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=ISO-8859-1

--- linux-2.5.3-pre2-ingo-J2/kernel/sched.c	Sun Jan 20 18:35:58 2002
+++ linux/kernel/sched.c	Sun Jan 20 18:36:59 2002
@@ -70,11 +70,11 @@
 	return __rq;
 }
=20
-static inline void unlock_task_rq(runqueue_t *rq, task_t *p,
-							unsigned long *flags)
+static inline void unlock_task_rq(runqueue_t *rq, unsigned long *flags)
 {
 	spin_unlock_irqrestore(&rq->lock, *flags);
 }
+
 /*
  * Adding/removing a task to/from a priority array:
  */
@@ -202,10 +202,10 @@
 	}
 	rq =3D lock_task_rq(p, &flags);
 	if (unlikely(rq->curr =3D=3D p)) {
-		unlock_task_rq(rq, p, &flags);
+		unlock_task_rq(rq, &flags);
 		goto repeat;
 	}
-	unlock_task_rq(rq, p, &flags);
+	unlock_task_rq(rq, &flags);
 }
=20
 /*
@@ -260,7 +260,7 @@
 			resched_task(rq->curr);
 		success =3D 1;
 	}
-	unlock_task_rq(rq, p, &flags);
+	unlock_task_rq(rq, &flags);
 	return success;
 }
=20
@@ -639,7 +639,6 @@
 	spin_unlock_irq(&rq->lock);
=20
 	reacquire_kernel_lock(current);
-	return;
 }
=20
 /*
@@ -846,7 +845,7 @@
 			resched_task(rq->curr);
 	}
 out_unlock:
-	unlock_task_rq(rq, p, &flags);
+	unlock_task_rq(rq, &flags);
 }
=20
 #ifndef __alpha__
@@ -966,7 +965,7 @@
 		activate_task(p, task_rq(p));
=20
 out_unlock:
-	unlock_task_rq(rq, p, &flags);
+	unlock_task_rq(rq, &flags);
 out_unlock_tasklist:
 	read_unlock_irq(&tasklist_lock);
=20

--=-3XPKomiSZwDPPGAcItvB--

