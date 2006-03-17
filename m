Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932743AbWCQRNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743AbWCQRNq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWCQRNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:13:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:11982 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932743AbWCQRNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:13:45 -0500
X-Authenticated: #14349625
Subject: Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1142592375.7895.43.camel@homer>
References: <200603081013.44678.kernel@kolivas.org>
	 <20060307152636.1324a5b5.akpm@osdl.org>
	 <cone.1141774323.5234.18683.501@kolivas.org>
	 <200603090036.49915.kernel@kolivas.org>  <20060317090653.GC13387@elte.hu>
	 <1142592375.7895.43.camel@homer>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 18:15:21 +0100
Message-Id: <1142615721.7841.15.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 11:46 +0100, Mike Galbraith wrote:
> On Fri, 2006-03-17 at 10:06 +0100, Ingo Molnar wrote:
> 
> > yep, i think that's a good idea. In the worst case the starvation 
> > timeout should kick in.
> 
> (I didn't want to hijack that thread ergo name change)
> 
> Speaking of the starvation timeout...
> 

<snip day late $ short idea>

Problem solved.  I now know why the starvation logic doesn't work.
Wakeups.  In the face of 10+ copies of httpd constantly waking up, it
seems it just takes ages to get around to switching arrays.

With the (urp) patch below, I now get...

[root]:# time netstat|grep :81|wc -l
   1648

real    0m27.735s
user    0m0.158s
sys     0m0.111s
[root]:# time netstat|grep :81|wc -l
   1817

real    0m13.550s
user    0m0.121s
sys     0m0.186s
[root]:# time netstat|grep :81|wc -l
   1641

real    0m17.022s
user    0m0.132s
sys     0m0.143s
[root]:# 

which certainly isn't pleasant, but it beats the heck out of minutes.

	-Mike

--- kernel/sched.c.org	2006-03-17 14:48:35.000000000 +0100
+++ kernel/sched.c	2006-03-17 17:41:25.000000000 +0100
@@ -662,11 +662,30 @@
 }
 
 /*
+ * We place interactive tasks back into the active array, if possible.
+ *
+ * To guarantee that this does not starve expired tasks we ignore the
+ * interactivity of a task if the first expired task had to wait more
+ * than a 'reasonable' amount of time. This deadline timeout is
+ * load-dependent, as the frequency of array switched decreases with
+ * increasing number of running tasks. We also ignore the interactivity
+ * if a better static_prio task has expired:
+ */
+#define EXPIRED_STARVING(rq) \
+	((STARVATION_LIMIT && ((rq)->expired_timestamp && \
+		(jiffies - (rq)->expired_timestamp >= \
+			STARVATION_LIMIT * ((rq)->nr_running) + 1))) || \
+			((rq)->curr->static_prio > (rq)->best_expired_prio))
+
+/*
  * __activate_task - move a task to the runqueue.
  */
 static inline void __activate_task(task_t *p, runqueue_t *rq)
 {
-	enqueue_task(p, rq->active);
+	prio_array_t *array = rq->active;
+	if (unlikely(EXPIRED_STARVING(rq)))
+		array = rq->expired;
+	enqueue_task(p, array);
 	rq->nr_running++;
 }
 
@@ -2461,22 +2480,6 @@
 }
 
 /*
- * We place interactive tasks back into the active array, if possible.
- *
- * To guarantee that this does not starve expired tasks we ignore the
- * interactivity of a task if the first expired task had to wait more
- * than a 'reasonable' amount of time. This deadline timeout is
- * load-dependent, as the frequency of array switched decreases with
- * increasing number of running tasks. We also ignore the interactivity
- * if a better static_prio task has expired:
- */
-#define EXPIRED_STARVING(rq) \
-	((STARVATION_LIMIT && ((rq)->expired_timestamp && \
-		(jiffies - (rq)->expired_timestamp >= \
-			STARVATION_LIMIT * ((rq)->nr_running) + 1))) || \
-			((rq)->curr->static_prio > (rq)->best_expired_prio))
-
-/*
  * Account user cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @hardirq_offset: the offset to subtract from hardirq_count()


