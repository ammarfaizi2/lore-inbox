Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbUKFKf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbUKFKf5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 05:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbUKFKf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 05:35:56 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:27009 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261354AbUKFKfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 05:35:40 -0500
Message-ID: <418CA8E8.9040506@kolivas.org>
Date: Sat, 06 Nov 2004 21:35:20 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] [sched-int-changes 3/5] add_requeue_task
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig928DC08AF3A4E04817F8917D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig928DC08AF3A4E04817F8917D
Content-Type: multipart/mixed;
 boundary="------------010907000808020607080700"

This is a multi-part message in MIME format.
--------------010907000808020607080700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

add_requeue_task

Please include in at least one -mm release.


--------------010907000808020607080700
Content-Type: text/x-patch;
 name="sched-add_requeue_task.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-add_requeue_task.diff"

We can requeue tasks for cheaper then doing a complete dequeue followed by
an enqueue. Add the requeue_task function and perform it where possible.

This will be hit frequently by upcoming changes to the requeueing in
timeslice granularity.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm3/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm3.orig/kernel/sched.c	2004-11-05 20:56:46.608179150 +1100
+++ linux-2.6.10-rc1-mm3/kernel/sched.c	2004-11-05 20:57:14.376900024 +1100
@@ -593,6 +593,15 @@ static void enqueue_task(struct task_str
 }
 
 /*
+ * Put task to the end of the run list without the overhead of dequeue
+ * followed by enqueue.
+ */
+static void requeue_task(struct task_struct *p, prio_array_t *array)
+{
+	list_move_tail(&p->run_list, array->queue + p->prio);
+}
+
+/*
  * Used by the migration code - we pull tasks from the head of the
  * remote queue so we want these tasks to show up at the head of the
  * local queue:
@@ -2456,8 +2465,7 @@ void scheduler_tick(void)
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
-			dequeue_task(p, rq->active);
-			enqueue_task(p, rq->active);
+			requeue_task(p, rq->active);
 		}
 		goto out_unlock;
 	}
@@ -3605,8 +3613,14 @@ asmlinkage long sys_sched_yield(void)
 	} else if (!rq->expired->nr_active)
 		schedstat_inc(rq, yld_exp_empty);
 
-	dequeue_task(current, array);
-	enqueue_task(current, target);
+	if (array != target) {
+		dequeue_task(current, array);
+		enqueue_task(current, target);
+	} else
+		/*
+		 * requeue_task is cheaper so perform that if possible.
+		 */
+		requeue_task(current, array);
 
 	/*
 	 * Since we are going to call schedule() anyway, there's


--------------010907000808020607080700--

--------------enig928DC08AF3A4E04817F8917D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBjKjoZUg7+tp6mRURApUxAJ0Xt4LHknfe0l5kquYTgGHB1OEqmwCgiZkX
8Ni+z1ZWLmeDPaXrsII9ZTY=
=+1Zg
-----END PGP SIGNATURE-----

--------------enig928DC08AF3A4E04817F8917D--
