Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbWFVXRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbWFVXRd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 19:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbWFVXRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 19:17:33 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:5568 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030460AbWFVXRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 19:17:32 -0400
Date: Fri, 23 Jun 2006 07:17:35 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched_exit: fix parent->time_slice calculation
Message-ID: <20060623031734.GA2608@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sched_exit:

	if (parent->time_slice > task_timeslice(p)))
		parent->time_slice = task_timeslice(p)

I think it should use task_timeslice(parent) instead.

The patch looks complicated, but it is not. It just caches the value
of 'p->parent'.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.17-rc6/kernel/sched.c~SCEX	2006-06-22 06:16:05.000000000 +0400
+++ 2.6.17-rc6/kernel/sched.c	2006-06-23 04:48:48.000000000 +0400
@@ -1479,6 +1479,7 @@ void fastcall wake_up_new_task(task_t *p
  */
 void fastcall sched_exit(task_t *p)
 {
+	task_t *parent = p->parent;
 	unsigned long flags;
 	runqueue_t *rq;
 
@@ -1486,14 +1487,14 @@ void fastcall sched_exit(task_t *p)
 	 * If the child was a (relative-) CPU hog then decrease
 	 * the sleep_avg of the parent as well.
 	 */
-	rq = task_rq_lock(p->parent, &flags);
-	if (p->first_time_slice && task_cpu(p) == task_cpu(p->parent)) {
-		p->parent->time_slice += p->time_slice;
-		if (unlikely(p->parent->time_slice > task_timeslice(p)))
-			p->parent->time_slice = task_timeslice(p);
+	rq = task_rq_lock(parent, &flags);
+	if (p->first_time_slice && task_cpu(p) == task_cpu(parent)) {
+		parent->time_slice += p->time_slice;
+		if (unlikely(parent->time_slice > task_timeslice(parent)))
+			parent->time_slice = task_timeslice(parent);
 	}
-	if (p->sleep_avg < p->parent->sleep_avg)
-		p->parent->sleep_avg = p->parent->sleep_avg /
+	if (p->sleep_avg < parent->sleep_avg)
+		parent->sleep_avg = parent->sleep_avg /
 		(EXIT_WEIGHT + 1) * EXIT_WEIGHT + p->sleep_avg /
 		(EXIT_WEIGHT + 1);
 	task_rq_unlock(rq, &flags);

