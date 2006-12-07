Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163192AbWLGSwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163192AbWLGSwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 13:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163193AbWLGSwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 13:52:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55795 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163192AbWLGSwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 13:52:12 -0500
Date: Thu, 7 Dec 2006 10:51:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Myron Stowe <myron.stowe@hp.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: workqueue deadlock
Message-Id: <20061207105148.20410b83.akpm@osdl.org>
In-Reply-To: <200612061726.14587.bjorn.helgaas@hp.com>
References: <200612061726.14587.bjorn.helgaas@hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 17:26:14 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> I'm seeing a workqueue-related deadlock.  This is on an ia64
> box running SLES10, but it looks like the same problem should
> be possible in current upstream on any architecture.
> 
> Here are the two tasks involved:
> 
>   events/4:
>     schedule
>     __down
>     __lock_cpu_hotplug
>     lock_cpu_hotplug
>     flush_workqueue
>     kblockd_flush
>     blk_sync_queue
>     cfq_shutdown_timer_wq
>     cfq_exit_queue
>     elevator_exit
>     blk_cleanup_queue
>     scsi_free_queue
>     scsi_device_dev_release_usercontext
>     run_workqueue
> 
>   loadkeys:
>     schedule
>     flush_cpu_workqueue
>     flush_workqueue
>     flush_scheduled_work
>     release_dev
>     tty_release

This will go away if/when I get the proposed new flush_work(struct
work_struct *) implemented.  We can then convert blk_sync_queue() to do

	flush_work(&q->unplug_work);

which will only block if blk_unplug_work() is actually executing on this
queue, and which will return as soon as blk_unplug_work() has finished. 
(And a similar change in release_dev()).

It doesn't solve the fundamental problem though.  But I'm not sure what
that is.  If it is "flush_scheduled_work() waits on things which the caller
isn't interested in" then it will fix the fundamental problem.

Needs more work:

diff -puN kernel/workqueue.c~implement-flush_work kernel/workqueue.c
--- a/kernel/workqueue.c~implement-flush_work
+++ a/kernel/workqueue.c
@@ -53,6 +53,7 @@ struct cpu_workqueue_struct {
 
 	struct workqueue_struct *wq;
 	struct task_struct *thread;
+	struct work_struct *current_work;
 
 	int run_depth;		/* Detect run_workqueue() recursion depth */
 } ____cacheline_aligned;
@@ -243,6 +244,7 @@ static void run_workqueue(struct cpu_wor
 		work_func_t f = work->func;
 
 		list_del_init(cwq->worklist.next);
+		cwq->current_work = work;
 		spin_unlock_irqrestore(&cwq->lock, flags);
 
 		BUG_ON(get_wq_data(work) != cwq);
@@ -251,6 +253,7 @@ static void run_workqueue(struct cpu_wor
 		f(work);
 
 		spin_lock_irqsave(&cwq->lock, flags);
+		cwq->current_work = NULL;
 		cwq->remove_sequence++;
 		wake_up(&cwq->work_done);
 	}
@@ -330,6 +333,70 @@ static void flush_cpu_workqueue(struct c
 	}
 }
 
+static void wait_on_work(struct cpu_workqueue_struct *cwq,
+				struct work_struct *work, int cpu)
+{
+	DEFINE_WAIT(wait);
+
+	spin_lock_irq(&cwq->lock);
+	while (cwq->current_work == work) {
+		prepare_to_wait(&cwq->work_done, &wait, TASK_UNINTERRUPTIBLE);
+		spin_unlock_irq(&cwq->lock);
+		mutex_unlock(&workqueue_mutex);
+		schedule();
+		mutex_lock(&workqueue_mutex);
+		if (!cpu_online(cpu))	/* oops, CPU got unplugged */
+			goto bail;
+		spin_lock_irq(&cwq->lock);
+	}
+	spin_unlock_irq(&cwq->lock);
+bail:
+	finish_wait(&cwq->work_done, &wait);
+}
+
+static void flush_one_work(struct cpu_workqueue_struct *cwq,
+				struct work_struct *work, int cpu)
+{
+	spin_lock_irq(&cwq->lock);
+	if (test_and_clear_bit(WORK_STRUCT_PENDING, &work->management)) {
+		list_del_init(&work->entry);
+		spin_unlock_irq(&cwq->lock);
+		return;
+	}
+	spin_unlock_irq(&cwq->lock);
+
+	/* It's running, or it has completed */
+
+	if (cwq->thread == current) {
+		/* This stinks */
+		/*
+		 * Probably keventd trying to flush its own queue. So simply run
+		 * it by hand rather than deadlocking.
+		 */
+		run_workqueue(cwq);
+	} else {
+		wait_on_work(cwq, work, cpu);
+	}
+}
+
+void flush_work(struct workqueue_struct *wq, struct work_struct *work)
+{
+	might_sleep();
+
+	mutex_lock(&workqueue_mutex);
+	if (is_single_threaded(wq)) {
+		/* Always use first cpu's area. */
+		flush_one_work(per_cpu_ptr(wq->cpu_wq, singlethread_cpu), work,
+				singlethread_cpu);
+	} else {
+		int cpu;
+
+		for_each_online_cpu(cpu)
+			flush_one_work(per_cpu_ptr(wq->cpu_wq, cpu), work, cpu);
+	}
+	mutex_unlock(&workqueue_mutex);
+}
+
 /**
  * flush_workqueue - ensure that any scheduled work has run to completion.
  * @wq: workqueue to flush
_

