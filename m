Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964962AbWEVAQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbWEVAQZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 20:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbWEVAQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 20:16:25 -0400
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:51870 "EHLO
	smtpq2.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S964962AbWEVAQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 20:16:24 -0400
Message-ID: <4471030B.9090008@keyaccess.nl>
Date: Mon, 22 May 2006 02:17:15 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Ingo Molnar <mingo@elte.hu>, Con Kolivas <kernel@kolivas.org>
Subject: Re: 2.6.17-rc2+ regression -- audio skipping
References: <4470CC8F.9030706@keyaccess.nl> <1148247047.20472.78.camel@mindpipe> <44710162.3070406@keyaccess.nl>
In-Reply-To: <44710162.3070406@keyaccess.nl>
Content-Type: multipart/mixed;
 boundary="------------050203020409080403060003"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050203020409080403060003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rene Herman wrote:

> --------------020706010703030706070708
 > Content-Type: text/plain;
>  name="unfix_interactive_task_starvation.diff" 
> Content-Transfer-Encoding: base64

Crap! Sorry guys, this is a Thunderbird bug, where it sends everything 
base64 encoded when text encoding is set to UTF-8. It for some reason 
decided to set it to UTF-8 now, so it went out base64...


--------------050203020409080403060003
Content-Type: text/plain;
 name="unfix_interactive_task_starvation.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="unfix_interactive_task_starvation.diff"

Index: local/kernel/sched.c
===================================================================
--- local.orig/kernel/sched.c	2006-05-08 20:47:06.000000000 +0200
+++ local/kernel/sched.c	2006-05-22 01:03:12.000000000 +0200
@@ -665,55 +665,13 @@ static int effective_prio(task_t *p)
 }
 
 /*
- * We place interactive tasks back into the active array, if possible.
- *
- * To guarantee that this does not starve expired tasks we ignore the
- * interactivity of a task if the first expired task had to wait more
- * than a 'reasonable' amount of time. This deadline timeout is
- * load-dependent, as the frequency of array switched decreases with
- * increasing number of running tasks. We also ignore the interactivity
- * if a better static_prio task has expired, and switch periodically
- * regardless, to ensure that highly interactive tasks do not starve
- * the less fortunate for unreasonably long periods.
- */
-static inline int expired_starving(runqueue_t *rq)
-{
-	int limit;
-
-	/*
-	 * Arrays were recently switched, all is well
-	 */
-	if (!rq->expired_timestamp)
-		return 0;
-
-	limit = STARVATION_LIMIT * rq->nr_running;
-
-	/*
-	 * It's time to switch arrays
-	 */
-	if (jiffies - rq->expired_timestamp >= limit)
-		return 1;
-
-	/*
-	 * There's a better selection in the expired array
-	 */
-	if (rq->curr->static_prio > rq->best_expired_prio)
-		return 1;
-
-	/*
-	 * All is well
-	 */
-	return 0;
-}
-
-/*
  * __activate_task - move a task to the runqueue.
  */
 static void __activate_task(task_t *p, runqueue_t *rq)
 {
 	prio_array_t *target = rq->active;
 
-	if (unlikely(batch_task(p) || (expired_starving(rq) && !rt_task(p))))
+	if (batch_task(p))
 		target = rq->expired;
 	enqueue_task(p, target);
 	rq->nr_running++;
@@ -2532,6 +2490,22 @@ unsigned long long current_sched_time(co
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
  * Account user cpu time to a process.
  * @p: the process that the cpu time gets accounted to
  * @hardirq_offset: the offset to subtract from hardirq_count()
@@ -2666,7 +2640,7 @@ void scheduler_tick(void)
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
-		if (!TASK_INTERACTIVE(p) || expired_starving(rq)) {
+		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			enqueue_task(p, rq->expired);
 			if (p->static_prio < rq->best_expired_prio)
 				rq->best_expired_prio = p->static_prio;

--------------050203020409080403060003--
