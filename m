Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbUKBOf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbUKBOf5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbUKBOMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:12:42 -0500
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:28111 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S262126AbUKBOBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 09:01:08 -0500
Message-ID: <41879312.5070009@kolivas.org>
Date: Wed, 03 Nov 2004 01:00:50 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] add requeue task redo
References: <418707E5.90705@kolivas.org> <20041102124252.GE15290@elte.hu>
In-Reply-To: <20041102124252.GE15290@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9580E769ECFE8AAEA436F7B7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9580E769ECFE8AAEA436F7B7
Content-Type: multipart/mixed;
 boundary="------------070509080001010306080903"

This is a multi-part message in MIME format.
--------------070509080001010306080903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

add requeue task redo



--------------070509080001010306080903
Content-Type: text/x-patch;
 name="sched-add_requeue_task-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-add_requeue_task-1.diff"

We can requeue tasks for cheaper then doing a complete dequeue followed by
an enqueue. Add the requeue_task function and perform it where possible.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2.orig/kernel/sched.c	2004-11-03 00:54:33.157137840 +1100
+++ linux-2.6.10-rc1-mm2/kernel/sched.c	2004-11-03 00:55:48.638171430 +1100
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
@@ -3569,8 +3578,14 @@ asmlinkage long sys_sched_yield(void)
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


--------------070509080001010306080903--

--------------enig9580E769ECFE8AAEA436F7B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBh5MSZUg7+tp6mRURAts9AKCMeLc3/kXDfjPdYixg3/lg/e89mQCfTB1E
mbSjmlhRmWkNifiQA76d0KM=
=eT9v
-----END PGP SIGNATURE-----

--------------enig9580E769ECFE8AAEA436F7B7--
