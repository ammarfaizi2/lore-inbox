Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264492AbTLTPTk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 10:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264497AbTLTPTk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 10:19:40 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:61627 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264492AbTLTPTh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 10:19:37 -0500
Message-ID: <3FE46885.2030905@cyberone.com.au>
Date: Sun, 21 Dec 2003 02:19:33 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] 2.6.0 fix preempt ctx switch accounting
Content-Type: multipart/mixed;
 boundary="------------040907040109040307000003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040907040109040307000003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Make sure to count kernel preemption as a context switch. A short cut
has been preventing it.



--------------040907040109040307000003
Content-Type: text/plain;
 name="sched-ctx-count-preempt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-ctx-count-preempt.patch"


Make sure to count kernel preemption as a context switch. A short cut
has been preventing it.


 linux-2.6-npiggin/kernel/sched.c |   37 +++++++++++++++----------------------
 1 files changed, 15 insertions(+), 22 deletions(-)

diff -puN kernel/sched.c~sched-ctx-count-preempt kernel/sched.c
--- linux-2.6/kernel/sched.c~sched-ctx-count-preempt	2003-12-04 13:01:03.000000000 +1100
+++ linux-2.6-npiggin/kernel/sched.c	2003-12-04 13:01:26.000000000 +1100
@@ -1512,33 +1512,20 @@ need_resched:
 
 	spin_lock_irq(&rq->lock);
 
-	/*
-	 * if entering off of a kernel preemption go straight
-	 * to picking the next task.
-	 */
-	if (unlikely(preempt_count() & PREEMPT_ACTIVE))
-		goto pick_next_task;
-
-	switch (prev->state) {
-	case TASK_INTERRUPTIBLE:
-		if (unlikely(signal_pending(prev))) {
+	if (prev->state != TASK_RUNNING &&
+			likely(!(preempt_count() & PREEMPT_ACTIVE)) ) {
+		if (unlikely(signal_pending(prev)) &&
+				prev->state == TASK_INTERRUPTIBLE)
 			prev->state = TASK_RUNNING;
-			break;
-		}
-	default:
-		deactivate_task(prev, rq);
-		prev->nvcsw++;
-		break;
-	case TASK_RUNNING:
-		prev->nivcsw++;
+		else
+			deactivate_task(prev, rq);
 	}
-pick_next_task:
-	if (unlikely(!rq->nr_running)) {
+
 #ifdef CONFIG_SMP
+	if (unlikely(!rq->nr_running))
 		load_balance(rq, 1, cpu_to_node_mask(smp_processor_id()));
-		if (rq->nr_running)
-			goto pick_next_task;
 #endif
+	if (unlikely(!rq->nr_running)) {
 		next = rq->idle;
 		rq->expired_timestamp = 0;
 		goto switch_tasks;
@@ -1585,6 +1572,12 @@ switch_tasks:
 	prev->timestamp = now;
 
 	if (likely(prev != next)) {
+		if (prev->state == TASK_RUNNING ||
+				unlikely(preempt_count() & PREEMPT_ACTIVE))
+			prev->nivcsw++;
+		else
+			prev->nvcsw++;
+
 		next->timestamp = now;
 		rq->nr_switches++;
 		rq->curr = next;

_

--------------040907040109040307000003--

