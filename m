Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270610AbUKBEQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270610AbUKBEQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 23:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268465AbUKBEMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 23:12:16 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:26833 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S519239AbUKBEHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 23:07:12 -0500
Message-ID: <418707E5.90705@kolivas.org>
Date: Tue, 02 Nov 2004 15:07:01 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] add requeue task
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA09E8E700B16A2D07F64E51B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA09E8E700B16A2D07F64E51B
Content-Type: multipart/mixed;
 boundary="------------010502000306020307060400"

This is a multi-part message in MIME format.
--------------010502000306020307060400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

add requeue task



--------------010502000306020307060400
Content-Type: text/x-patch;
 name="sched-add_requeue_task.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-add_requeue_task.diff"

We can requeue tasks for cheaper then doing a complete dequeue followed by
an enqueue. Add the requeue_task function and perform it where possible.

Change the granularity code to requeue tasks at their best priority
instead of changing priority while they're running. This keeps tasks at
their top interactive level during their whole timeslice.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2.orig/kernel/sched.c	2004-11-02 14:48:54.686316718 +1100
+++ linux-2.6.10-rc1-mm2/kernel/sched.c	2004-11-02 14:52:51.805763544 +1100
@@ -579,6 +579,16 @@ static void enqueue_task(struct task_str
 }
 
 /*
+ * Put task to the end of the run list without the overhead of dequeue
+ * followed by enqueue.
+ */
+static void requeue_task(struct task_struct *p, prio_array_t *array)
+{
+	list_del(&p->run_list);
+	list_add_tail(&p->run_list, array->queue + p->prio);
+}
+
+/*
  * Used by the migration code - we pull tasks from the head of the
  * remote queue so we want these tasks to show up at the head of the
  * local queue:
@@ -2425,8 +2435,7 @@ void scheduler_tick(void)
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
-			dequeue_task(p, rq->active);
-			enqueue_task(p, rq->active);
+			requeue_task(p, rq->active);
 		}
 		goto out_unlock;
 	}
@@ -2467,10 +2476,8 @@ void scheduler_tick(void)
 			(p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
 			(p->array == rq->active)) {
 
-			dequeue_task(p, rq->active);
+			requeue_task(p, rq->active);
 			set_tsk_need_resched(p);
-			p->prio = effective_prio(p);
-			enqueue_task(p, rq->active);
 		}
 	}
 out_unlock:
@@ -3569,8 +3576,14 @@ asmlinkage long sys_sched_yield(void)
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


--------------010502000306020307060400--

--------------enigA09E8E700B16A2D07F64E51B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBhwfmZUg7+tp6mRURAjTiAKCTA7NYC6c0D7+uLKE3EyDw+GDeCQCgkAB0
DIPJL4mDJnxAT9MoM2T4a4Y=
=56ZX
-----END PGP SIGNATURE-----

--------------enigA09E8E700B16A2D07F64E51B--
