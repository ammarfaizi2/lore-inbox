Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbWCQOLS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbWCQOLS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 09:11:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWCQOLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 09:11:17 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:47307 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030184AbWCQOLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 09:11:17 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH] sched: activate SCHED BATCH expired
Date: Sat, 18 Mar 2006 01:11:00 +1100
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, ck@vds.kolivas.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200603081013.44678.kernel@kolivas.org> <200603180036.11326.kernel@kolivas.org> <441ABD9F.6060407@yahoo.com.au>
In-Reply-To: <441ABD9F.6060407@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603180111.01466.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 March 2006 00:46, Nick Piggin wrote:
> I guess it isn't doing the cmov because it doesn't want to do the
> extra load in the common case, which is fair enough (are you compiling
> for a pentiumpro+, without generic x86 support?

For pentium4 with no generic support.

> what about if you 
> turn off optimise for size?)

Dunno, sleep is taking me...

> At least other archtectures might be able to make better use of it,
> and I agree even for i386 the code looks better (and slightly smaller).

Good enough for me. Here's a respin, thanks!

Cheers,
Con
---
To increase the strength of SCHED_BATCH as a scheduling hint we can activate
batch tasks on the expired array since by definition they are latency
insensitive tasks.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 include/linux/sched.h |    1 +
 kernel/sched.c        |   10 +++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc6-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.16-rc6-mm1.orig/include/linux/sched.h	2006-03-13 20:12:22.000000000 +1100
+++ linux-2.6.16-rc6-mm1/include/linux/sched.h	2006-03-17 23:08:31.000000000 +1100
@@ -485,6 +485,7 @@ struct signal_struct {
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
 
 #define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))
+#define batch_task(p)		(unlikely((p)->policy == SCHED_BATCH))
 
 /*
  * Some day this will be a full-fledged user tracking system..
Index: linux-2.6.16-rc6-mm1/kernel/sched.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/kernel/sched.c	2006-03-13 20:12:15.000000000 +1100
+++ linux-2.6.16-rc6-mm1/kernel/sched.c	2006-03-18 01:05:02.000000000 +1100
@@ -737,9 +737,13 @@ static inline void dec_nr_running(task_t
 /*
  * __activate_task - move a task to the runqueue.
  */
-static inline void __activate_task(task_t *p, runqueue_t *rq)
+static void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, rq->active);
+	prio_array_t *target = rq->active;
+
+	if (batch_task(p))
+		target = rq->expired;
+	enqueue_task(p, target);
 	inc_nr_running(p, rq);
 }
 
@@ -758,7 +762,7 @@ static int recalc_task_prio(task_t *p, u
 	unsigned long long __sleep_time = now - p->timestamp;
 	unsigned long sleep_time;
 
-	if (unlikely(p->policy == SCHED_BATCH))
+	if (batch_task(p))
 		sleep_time = 0;
 	else {
 		if (__sleep_time > NS_MAX_SLEEP_AVG)
