Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbUF0MAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbUF0MAd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 08:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262079AbUF0MAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 08:00:33 -0400
Received: from mail021.syd.optusnet.com.au ([211.29.132.132]:28345 "EHLO
	mail021.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261987AbUF0MA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 08:00:26 -0400
Message-ID: <40DEB6CC.4030208@kolivas.org>
Date: Sun, 27 Jun 2004 22:00:12 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staircase scheduler v7.4
References: <200406251840.46577.mbuesch@freenet.de> <200406252044.25843.mbuesch@freenet.de> <20040625190533.GI29808@alpha.home.local> <200406252148.37606.mbuesch@freenet.de>
In-Reply-To: <200406252148.37606.mbuesch@freenet.de>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFD08B295DDC3FCD18F9A3F2B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFD08B295DDC3FCD18F9A3F2B
Content-Type: multipart/mixed;
 boundary="------------030705080801040303020803"

This is a multi-part message in MIME format.
--------------030705080801040303020803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is an incremental patch from 2.6.7-staircase7.4 (without any later 
changes) to staircase7.6 which I hope addresses your problem of no 
timeslice tasks. Can you try it please? Sorry about the previous noise.

Con

P.S.
Those with ck kernels I'm about to post another diff for -ck addressing 
the same thing.

--------------030705080801040303020803
Content-Type: text/x-troff-man;
 name="from_2.6.7-staircase7.4_to_staircase7.6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="from_2.6.7-staircase7.4_to_staircase7.6"

Index: linux-2.6.7-ck2pre/kernel/sched.c
===================================================================
--- linux-2.6.7-ck2pre.orig/kernel/sched.c	2004-06-25 23:06:57.000000000 +1000
+++ linux-2.6.7-ck2pre/kernel/sched.c	2004-06-27 21:39:40.182630568 +1000
@@ -231,8 +231,8 @@
 
 static void enqueue_task(struct task_struct *p, runqueue_t *rq)
 {
-	if (rq->curr->flags & PF_PREEMPTED) {
-		rq->curr->flags &= ~PF_PREEMPTED;
+	if (p->flags & PF_PREEMPTED) {
+		p->flags &= ~PF_PREEMPTED;
 		list_add(&p->run_list, rq->queue + p->prio);
 	} else
 		list_add_tail(&p->run_list, rq->queue + p->prio);
@@ -268,7 +268,10 @@
 	rq->nr_running++;
 }
 
-// burst - extra intervals an interactive task can run for at best priority
+/*
+ * burst - extra intervals an interactive task can run for at best priority
+ * instead of descending priorities.
+ */
 static unsigned int burst(task_t *p)
 {
 	unsigned int task_user_prio;
@@ -297,7 +300,10 @@
 		p->burst--;
 }
 
-// slice - the duration a task runs before losing burst
+/*
+ * slice - the duration a task runs before getting requeued at it's best
+ * priority and has it's burst decremented.
+ */
 static unsigned int slice(task_t *p)
 {
 	unsigned int slice = RR_INTERVAL;
@@ -308,7 +314,9 @@
 	return slice;
 }
 
-// interactive - interactive tasks get longer intervals at best priority
+/*
+ * interactive - sysctl which allows interactive tasks to have bursts
+ */
 int interactive = 1;
 
 /*
@@ -346,20 +354,25 @@
 	return prio;
 }
 
+/*
+ * recalc_task_prio - this checks for tasks that run ultra short timeslices
+ * or have just forked a thread/process and make them continue their old
+ * slice instead of starting a new one at high priority.
+ */
 static void recalc_task_prio(task_t *p, unsigned long long now)
 {
 	unsigned long sleep_time = now - p->timestamp;
-	unsigned long run_time = NS_TO_JIFFIES(p->runtime);
-	unsigned long total_run = NS_TO_JIFFIES(p->totalrun) + run_time;
-	if ((!run_time && NS_TO_JIFFIES(p->runtime + sleep_time) < 
-		rr_interval(p)) || p->flags & PF_FORKED) {
+	unsigned long ns_totalrun = p->totalrun + p->runtime;
+	unsigned long total_run = NS_TO_JIFFIES(ns_totalrun);
+	if (p->flags & PF_FORKED || (!(NS_TO_JIFFIES(p->runtime)) && 
+		NS_TO_JIFFIES(p->runtime + sleep_time) < rr_interval(p))) {
 			p->flags &= ~PF_FORKED;
 			if (p->slice - total_run < 1) {
 				p->totalrun = 0;
 				dec_burst(p);
 			} else {
-				p->totalrun += p->runtime;
-				p->slice -= NS_TO_JIFFIES(p->totalrun);
+				p->totalrun = ns_totalrun;
+				p->slice -= total_run;
 			}
 	} else {
 		inc_burst(p);
@@ -786,7 +799,9 @@
 	unsigned long flags;
 	runqueue_t *rq = task_rq_lock(current, &flags);
 
-	//Forked process gets no burst to prevent fork bombs.
+	/* 
+	 * Forked process gets no burst to prevent fork bombs.
+	 */
 	p->burst = 0;
 	BUG_ON(p->state != TASK_RUNNING);
 
@@ -1768,11 +1783,15 @@
 	cpustat->system += sys_ticks;
 
 	spin_lock(&rq->lock);
-	// SCHED_FIFO tasks never run out of timeslice.
+	/*
+	 * SCHED_FIFO tasks never run out of timeslice.
+	 */
 	if (unlikely(p->policy == SCHED_FIFO))
 		goto out_unlock;
 	rq->cache_ticks++;
-	// Tasks lose burst each time they use up a full slice().
+	/*
+	 * Tasks lose burst each time they use up a full slice().
+	 */
 	if (!--p->slice) {
 		set_tsk_need_resched(p);
 		dequeue_task(p, rq);
@@ -3601,7 +3620,9 @@
 		for (j = 0; j <= MAX_PRIO; j++)
 			INIT_LIST_HEAD(&rq->queue[j]);
 		memset(rq->bitmap, 0, BITS_TO_LONGS(MAX_PRIO+1)*sizeof(long));
-		// delimiter for bitsearch
+		/*
+		 * delimiter for bitsearch
+		 */
 		__set_bit(MAX_PRIO, rq->bitmap);
 	}
 	/*

--------------030705080801040303020803--

--------------enigFD08B295DDC3FCD18F9A3F2B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA3rbPZUg7+tp6mRURArLOAJ4toTL/wB4oom/Bgj9v7gEaoW2gVwCeOnSv
RAUSNtJdMITkwYJ83BsXDZc=
=82c+
-----END PGP SIGNATURE-----

--------------enigFD08B295DDC3FCD18F9A3F2B--
