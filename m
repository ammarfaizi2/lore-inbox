Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163232AbWLGTh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163232AbWLGTh3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 14:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163238AbWLGTh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 14:37:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59577 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163232AbWLGTh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 14:37:27 -0500
Date: Thu, 7 Dec 2006 11:37:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>
Subject: Re: workqueue deadlock
Message-Id: <20061207113700.dc925068.akpm@osdl.org>
In-Reply-To: <20061207105148.20410b83.akpm@osdl.org>
References: <200612061726.14587.bjorn.helgaas@hp.com>
	<20061207105148.20410b83.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 10:51:48 -0800
Andrew Morton <akpm@osdl.org> wrote:

> +		if (!cpu_online(cpu))	/* oops, CPU got unplugged */
> +			goto bail;

hm, actually we can pull the same trick with flush_scheduled_work(). 
Should fix quite a few things...



From: Andrew Morton <akpm@osdl.org>

We have a class of deadlocks where the flush_scheduled_work() caller can get
stuck waiting for a work to complete, where that work wants to take
workqueue_mutex for some reason.

Fix this by not holding workqueue_mutex when waiting for a workqueue to flush.

The patch assumes that the per-cpu workqueue won't get freed up while there's
a task waiting on cpu_workqueue_struct.work_done.  If that can happen,
run_workqueue() would crash anyway.

Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Gautham shenoy <ego@in.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/workqueue.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff -puN kernel/workqueue.c~workqueue-dont-hold-workqueue_mutex-in-flush_scheduled_work kernel/workqueue.c
--- a/kernel/workqueue.c~workqueue-dont-hold-workqueue_mutex-in-flush_scheduled_work
+++ a/kernel/workqueue.c
@@ -325,14 +325,22 @@ static int worker_thread(void *__cwq)
 	return 0;
 }
 
-static void flush_cpu_workqueue(struct cpu_workqueue_struct *cwq)
+/*
+ * If cpu == -1 it's a single-threaded workqueue and the caller does not hold
+ * workqueue_mutex
+ */
+static void flush_cpu_workqueue(struct cpu_workqueue_struct *cwq, int cpu)
 {
 	if (cwq->thread == current) {
 		/*
 		 * Probably keventd trying to flush its own queue. So simply run
 		 * it by hand rather than deadlocking.
 		 */
+		if (cpu != -1)
+			mutex_unlock(&workqueue_mutex);
 		run_workqueue(cwq);
+		if (cpu != -1)
+			mutex_lock(&workqueue_mutex);
 	} else {
 		DEFINE_WAIT(wait);
 		long sequence_needed;
@@ -344,7 +352,14 @@ static void flush_cpu_workqueue(struct c
 			prepare_to_wait(&cwq->work_done, &wait,
 					TASK_UNINTERRUPTIBLE);
 			spin_unlock_irq(&cwq->lock);
+			if (cpu != -1)
+				mutex_unlock(&workqueue_mutex);
 			schedule();
+			if (cpu != -1) {
+				mutex_lock(&workqueue_mutex);
+				if (!cpu_online(cpu))
+					return; /* oops, CPU unplugged */
+			}
 			spin_lock_irq(&cwq->lock);
 		}
 		finish_wait(&cwq->work_done, &wait);
@@ -373,13 +388,14 @@ void fastcall flush_workqueue(struct wor
 
 	if (is_single_threaded(wq)) {
 		/* Always use first cpu's area. */
-		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu));
+		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu),
+					-1);
 	} else {
 		int cpu;
 
 		mutex_lock(&workqueue_mutex);
 		for_each_online_cpu(cpu)
-			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu));
+			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu), cpu);
 		mutex_unlock(&workqueue_mutex);
 	}
 }
_

