Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWCQMij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWCQMij (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 07:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWCQMij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 07:38:39 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:48871 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932084AbWCQMii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 07:38:38 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] sched: activate SCHED BATCH expired
Date: Fri, 17 Mar 2006 23:38:09 +1100
User-Agent: KMail/1.9.1
Cc: ck@vds.kolivas.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <200603081013.44678.kernel@kolivas.org> <200603090036.49915.kernel@kolivas.org> <20060317090653.GC13387@elte.hu>
In-Reply-To: <20060317090653.GC13387@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603172338.10107.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 March 2006 20:06, Ingo Molnar wrote:
> * Con Kolivas <kernel@kolivas.org> wrote:
> > Thinking some more on this I wonder if SCHED_BATCH isn't a strong
> > enough scheduling hint if it's not suitable for such an application.
> > Ingo do you think we could make SCHED_BATCH tasks always wake up on
> > the expired array?
>
> yep, i think that's a good idea. In the worst case the starvation
> timeout should kick in.

Ok here's a patch that does exactly that. Without an "inline" hint, gcc 4.1.0
chooses not to inline this function. I can't say I have a strong opinion
about whether it should be inlined or not (93 bytes larger inlined), so I've
decided not to given the current trend.

Cheers,
Con
---
To increase the strength of SCHED_BATCH as a scheduling hint we can activate
batch tasks on the expired array since by definition they are latency
insensitive tasks.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 include/linux/sched.h |    1 +
 kernel/sched.c        |    9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

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
+++ linux-2.6.16-rc6-mm1/kernel/sched.c	2006-03-17 23:08:12.000000000 +1100
@@ -737,9 +737,12 @@ static inline void dec_nr_running(task_t
 /*
  * __activate_task - move a task to the runqueue.
  */
-static inline void __activate_task(task_t *p, runqueue_t *rq)
+static void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, rq->active);
+	if (batch_task(p))
+		enqueue_task(p, rq->expired);
+	else
+		enqueue_task(p, rq->active);
 	inc_nr_running(p, rq);
 }
 
@@ -758,7 +761,7 @@ static int recalc_task_prio(task_t *p, u
 	unsigned long long __sleep_time = now - p->timestamp;
 	unsigned long sleep_time;
 
-	if (unlikely(p->policy == SCHED_BATCH))
+	if (batch_task(p))
 		sleep_time = 0;
 	else {
 		if (__sleep_time > NS_MAX_SLEEP_AVG)
