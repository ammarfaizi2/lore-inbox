Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbUKBEP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbUKBEP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 23:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269134AbUKBENF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 23:13:05 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:44724 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S519348AbUKBEHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 23:07:15 -0500
Message-ID: <418707E2.1060105@kolivas.org>
Date: Tue, 02 Nov 2004 15:06:58 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] consolidate task preempts
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD06D8832C469C2159CBDD94A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD06D8832C469C2159CBDD94A
Content-Type: multipart/mixed;
 boundary="------------090602000701030102040602"

This is a multi-part message in MIME format.
--------------090602000701030102040602
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

consolidate task preempts



--------------090602000701030102040602
Content-Type: text/x-patch;
 name="sched-consolidate_task_preempts.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-consolidate_task_preempts.diff"

TASK_PREEMPTS_CURR is only used when followed by resched_task. Consolidate
the two into a single function.

Allow tasks of equal dynamic priority to preempt tasks of lower static
priority.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2.orig/kernel/sched.c	2004-11-02 14:19:32.973509317 +1100
+++ linux-2.6.10-rc1-mm2/kernel/sched.c	2004-11-02 14:26:23.444588405 +1100
@@ -157,9 +157,6 @@
 	(JIFFIES_TO_NS(MAX_SLEEP_AVG * \
 		(MAX_BONUS / 2 + DELTA((p)) + 1) / MAX_BONUS - 1))
 
-#define TASK_PREEMPTS_CURR(p, rq) \
-	((p)->prio < (rq)->curr->prio)
-
 /*
  * task_timeslice() scales user-nice values [ -20 ... 0 ... 19 ]
  * to time slice values: [800ms ... 100ms ... 5ms]
@@ -810,6 +807,13 @@ inline int task_curr(const task_t *p)
 	return cpu_curr(task_cpu(p)) == p;
 }
 
+static void preempt(task_t *p, runqueue_t *rq)
+{
+	if (p->prio < rq->curr->prio || (p->prio == rq->curr->prio &&
+		p->static_prio < rq->curr->static_prio))
+			resched_task(rq->curr);
+}
+
 #ifdef CONFIG_SMP
 enum request_type {
 	REQ_MOVE_TASK,
@@ -1106,10 +1110,8 @@ out_activate:
 	 * to be considered on this CPU.)
 	 */
 	activate_task(p, rq, cpu == this_cpu);
-	if (!sync || cpu != this_cpu) {
-		if (TASK_PREEMPTS_CURR(p, rq))
-			resched_task(rq->curr);
-	}
+	if (!sync || cpu != this_cpu)
+		preempt(p, rq);
 	success = 1;
 
 out_running:
@@ -1263,8 +1265,7 @@ void fastcall wake_up_new_task(task_t * 
 		p->timestamp = (p->timestamp - this_rq->timestamp_last_tick)
 					+ rq->timestamp_last_tick;
 		__activate_task(p, rq);
-		if (TASK_PREEMPTS_CURR(p, rq))
-			resched_task(rq->curr);
+		preempt(p, rq);
 
 		schedstat_inc(rq, wunt_moved);
 		/*
@@ -1621,8 +1622,7 @@ void pull_task(runqueue_t *src_rq, prio_
 	 * Note that idle threads have a prio of MAX_PRIO, for this test
 	 * to be always true for them.
 	 */
-	if (TASK_PREEMPTS_CURR(p, this_rq))
-		resched_task(this_rq->curr);
+	preempt(p, this_rq);
 }
 
 /*
@@ -3306,8 +3306,8 @@ recheck:
 		if (task_running(rq, p)) {
 			if (p->prio > oldprio)
 				resched_task(rq->curr);
-		} else if (TASK_PREEMPTS_CURR(p, rq))
-			resched_task(rq->curr);
+		} else
+			preempt(p, rq);
 	}
 	task_rq_unlock(rq, &flags);
 out_unlock:
@@ -4008,8 +4008,7 @@ static void __migrate_task(struct task_s
 				+ rq_dest->timestamp_last_tick;
 		deactivate_task(p, rq_src);
 		activate_task(p, rq_dest, 0);
-		if (TASK_PREEMPTS_CURR(p, rq_dest))
-			resched_task(rq_dest->curr);
+		preempt(p, rq_dest);
 	}
 
 out:


--------------090602000701030102040602--

--------------enigD06D8832C469C2159CBDD94A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBhwfiZUg7+tp6mRURAvCSAKCK9EKXIDl/aBBl/bI3e/wYO3XJ7ACfTz74
r/E9CZDS2A/d1Zr7IOE6Qtk=
=csgo
-----END PGP SIGNATURE-----

--------------enigD06D8832C469C2159CBDD94A--
