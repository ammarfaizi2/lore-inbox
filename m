Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbVF1Anl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVF1Anl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 20:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261453AbVF1Anl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 20:43:41 -0400
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:36536 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S261192AbVF1Anc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 20:43:32 -0400
Message-ID: <42C09D31.5030207@bigpond.net.au>
Date: Tue, 28 Jun 2005 10:43:29 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] sched: consider migration thread with smp nice
References: <200506261825.19740.kernel@kolivas.org>
In-Reply-To: <200506261825.19740.kernel@kolivas.org>
Content-Type: multipart/mixed;
 boundary="------------040104060504010400020800"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 28 Jun 2005 00:43:29 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040104060504010400020800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Con Kolivas wrote:
> This patch improves throughput with the smp nice balancing code. Many thanks 
> to Martin Bligh for the usage of his regression testing bed to confirm the 
> effectiveness of various patches.

Con,
	This doesn't build on non SMP systems due to the migration_thread field 
only being defined for SMP.  Attached is a copy of a slightly modified 
PlugSched version of the patch which I used to fix the problem in 
PlugSched.  Even though it's for a different file it should be easy to 
copy over.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

--------------040104060504010400020800
Content-Type: text/x-diff;
 name="migration_thread.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="migration_thread.diff"

Index: MM-2.6.12/include/linux/sched_pvt.h
===================================================================
--- MM-2.6.12.orig/include/linux/sched_pvt.h	2005-06-28 10:11:47.000000000 +1000
+++ MM-2.6.12/include/linux/sched_pvt.h	2005-06-28 10:37:14.000000000 +1000
@@ -393,6 +393,11 @@
 {
 	rq->prio_bias -= MAX_STATIC_PRIO - prio;
 }
+
+static inline int is_migration_thread(const task_t *p, const runqueue_t *rq)
+{
+	return p == rq->migration_thread;
+}
 #else
 static inline void inc_prio_bias(runqueue_t *rq, int prio)
 {
@@ -401,23 +406,35 @@
 static inline void dec_prio_bias(runqueue_t *rq, int prio)
 {
 }
+
+static inline int is_migration_thread(const task_t *p, const runqueue_t *rq)
+{
+	return 0;
+}
 #endif
 
 static inline void inc_nr_running(task_t *p, runqueue_t *rq)
 {
 	rq->nr_running++;
-	if (rt_task(p))
-		inc_prio_bias(rq, p->prio);
-	else
+	if (rt_task(p)) {
+		if (!is_migration_thread(p, rq))
+			/*
+			 * The migration thread does the actual balancing. Do
+			 * not bias by its priority as the ultra high priority
+			 * will skew balancing adversely.
+			 */
+			inc_prio_bias(rq, p->prio);
+	} else
 		inc_prio_bias(rq, p->static_prio);
 }
 
 static inline void dec_nr_running(task_t *p, runqueue_t *rq)
 {
 	rq->nr_running--;
-	if (rt_task(p))
-		dec_prio_bias(rq, p->prio);
-	else
+	if (rt_task(p)) {
+		if (!is_migration_thread(p, rq))
+			dec_prio_bias(rq, p->prio);
+	} else
 		dec_prio_bias(rq, p->static_prio);
 }
 

--------------040104060504010400020800--
