Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266033AbUFDW1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266033AbUFDW1m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 18:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266035AbUFDW1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 18:27:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:56762 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266033AbUFDW1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 18:27:34 -0400
Date: Fri, 4 Jun 2004 15:30:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: <anil.s.keshavamurthy@intel.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] speedup flush_workqueue for singlethread_workqueue
Message-Id: <20040604153018.00768aab.akpm@osdl.org>
In-Reply-To: <ORSMSX409uejPw8Zyai00000001@orsmsx409.amr.corp.intel.com>
References: <ORSMSX409uejPw8Zyai00000001@orsmsx409.amr.corp.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Anil" <anil.s.keshavamurthy@intel.com> wrote:
>
> 	In the flush_workqueue function for a single_threaded_worqueue case the code seemed to loop the same cpu_workqueue_struct
> for each_online_cpu's. The attached patch checks this condition and bails out of for loop there by speeding up the flush_workqueue
> for a singlethreaded_workqueue.


OK, thanks.  I think it's a bit clearer to do it as below.  I haven't
tested it though.



From: "Anil" <anil.s.keshavamurthy@intel.com>

In flush_workqueue() for a single_threaded_worqueue case the code flushes the
same cpu_workqueue_struct for each online_cpu.

Change things so that we only perform the flush once in this case.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/kernel/workqueue.c |   66 +++++++++++++++++++++++----------------------
 1 files changed, 35 insertions(+), 31 deletions(-)

diff -puN kernel/workqueue.c~speedup-flush_workqueue-for-singlethread_workqueue kernel/workqueue.c
--- 25/kernel/workqueue.c~speedup-flush_workqueue-for-singlethread_workqueue	Fri Jun  4 15:22:50 2004
+++ 25-akpm/kernel/workqueue.c	Fri Jun  4 15:27:24 2004
@@ -218,6 +218,33 @@ static int worker_thread(void *__cwq)
 	return 0;
 }
 
+static void flush_cpu_workqueue(struct cpu_workqueue_struct *cwq)
+{
+	if (cwq->thread == current) {
+		/*
+		 * Probably keventd trying to flush its own queue. So simply run
+		 * it by hand rather than deadlocking.
+		 */
+		run_workqueue(cwq);
+	} else {
+		DEFINE_WAIT(wait);
+		long sequence_needed;
+
+		spin_lock_irq(&cwq->lock);
+		sequence_needed = cwq->insert_sequence;
+
+		while (sequence_needed - cwq->remove_sequence > 0) {
+			prepare_to_wait(&cwq->work_done, &wait,
+					TASK_UNINTERRUPTIBLE);
+			spin_unlock_irq(&cwq->lock);
+			schedule();
+			spin_lock_irq(&cwq->lock);
+		}
+		finish_wait(&cwq->work_done, &wait);
+		spin_unlock_irq(&cwq->lock);
+	}
+}
+
 /*
  * flush_workqueue - ensure that any scheduled work has run to completion.
  *
@@ -234,42 +261,19 @@ static int worker_thread(void *__cwq)
  */
 void fastcall flush_workqueue(struct workqueue_struct *wq)
 {
-	struct cpu_workqueue_struct *cwq;
-	int cpu;
-
 	might_sleep();
-
 	lock_cpu_hotplug();
-	for_each_online_cpu(cpu) {
-		DEFINE_WAIT(wait);
-		long sequence_needed;
 
-		if (is_single_threaded(wq))
-			cwq = wq->cpu_wq + 0; /* Always use cpu 0's area. */
-		else
-			cwq = wq->cpu_wq + cpu;
-
-		if (cwq->thread == current) {
-			/*
-			 * Probably keventd trying to flush its own queue.
-			 * So simply run it by hand rather than deadlocking.
-			 */
-			run_workqueue(cwq);
-			continue;
-		}
-		spin_lock_irq(&cwq->lock);
-		sequence_needed = cwq->insert_sequence;
+	if (is_single_threaded(wq)) {
+		/* Always use cpu 0's area. */
+		flush_cpu_workqueue(wq->cpu_wq + 0);
+	} else {
+		int cpu;
 
-		while (sequence_needed - cwq->remove_sequence > 0) {
-			prepare_to_wait(&cwq->work_done, &wait,
-					TASK_UNINTERRUPTIBLE);
-			spin_unlock_irq(&cwq->lock);
-			schedule();
-			spin_lock_irq(&cwq->lock);
-		}
-		finish_wait(&cwq->work_done, &wait);
-		spin_unlock_irq(&cwq->lock);
+		for_each_online_cpu(cpu)
+			flush_cpu_workqueue(wq->cpu_wq + cpu);
 	}
+
 	unlock_cpu_hotplug();
 }
 
_

