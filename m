Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162588AbWLGRxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162588AbWLGRxg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 12:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162590AbWLGRxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 12:53:36 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50249 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162588AbWLGRxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 12:53:35 -0500
Date: Thu, 7 Dec 2006 09:52:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Message-Id: <20061207095253.30059224.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612070846550.3615@woody.osdl.org>
References: <1165125055.5320.14.camel@gullible>
	<20061203011625.60268114.akpm@osdl.org>
	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
	<20061205123958.497a7bd6.akpm@osdl.org>
	<6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
	<20061205132643.d16db23b.akpm@osdl.org>
	<adaac22c9cu.fsf@cisco.com>
	<20061205135753.9c3844f8.akpm@osdl.org>
	<Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
	<20061206075729.b2b6aa52.akpm@osdl.org>
	<Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>
	<Pine.LNX.4.64.0612061719420.3542@woody.osdl.org>
	<20061206224207.8a8335ee.akpm@osdl.org>
	<Pine.LNX.4.64.0612070846550.3615@woody.osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2006 08:49:02 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> 
> 
> On Wed, 6 Dec 2006, Andrew Morton wrote:
> >
> > But this will return to the caller if the callback is presently running on
> > a different CPU.  The whole point here is to be able to reliably kill off
> > the pending work so that the caller can free resources.
> 
> I mentioned that in one of the emails.
> 
> We do not _have_ the information to not do that. It simply doesn't exist. 
> We can either wait for _all_ pending entries on the to complete (by 
> waiting for the workqueue counters for added/removed to be the same), or 
> we can have the race.

Well we'll need to add the infrastructure to be able to do this, won't we? 
The whole point of calling flush_scheduled_work() (which we're trying to
replace/simplify) is to block the caller until it is safe to release
resources.

It might be a challenge to do this without adding more stuff to work_struct
though.

umm..  Putting a work_struct* into struct cpu_workqueue_struct and then
doing appropriate things with cpu_workqueue_struct.lock might work.

<hack, hack>

Something along these lines.  The keventd-calls-flush_work() case rather
sucks though.


diff -puN kernel/workqueue.c~a kernel/workqueue.c
--- a/kernel/workqueue.c~a
+++ a/kernel/workqueue.c
@@ -323,6 +323,7 @@ static void run_workqueue(struct cpu_wor
 		work_func_t f = work->func;
 
 		list_del_init(cwq->worklist.next);
+		cwq->current_work = work;
 		spin_unlock_irqrestore(&cwq->lock, flags);
 
 		BUG_ON(get_wq_data(work) != cwq);
@@ -342,6 +343,7 @@ static void run_workqueue(struct cpu_wor
 		}
 
 		spin_lock_irqsave(&cwq->lock, flags);
+		cwq->current_work = NULL;
 		cwq->remove_sequence++;
 		wake_up(&cwq->work_done);
 	}
@@ -425,6 +427,64 @@ static void flush_cpu_workqueue(struct c
 	}
 }
 
+static void wait_on_work(struct cpu_workqueue_struct *cwq,
+				struct work_struct *work)
+{
+	DEFINE_WAIT(wait);
+
+	spin_lock_irq(&cwq->lock);
+	while (cwq->current_work == work) {
+		prepare_to_wait(&cwq->work_done, &wait, TASK_UNINTERRUPTIBLE);
+		spin_unlock_irq(&cwq->lock);
+		schedule();
+		spin_lock_irq(&cwq->lock);
+	}
+	finish_wait(&cwq->work_done, &wait);
+	spin_unlock_irq(&cwq->lock);
+}
+
+static void flush_one_work(struct cpu_workqueue_struct *cwq,
+				struct work_struct *work)
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
+		wait_on_work(cwq, work);
+	}
+}
+
+void flush_work(struct work_struct *work)
+{
+	might_sleep();
+
+	if (is_single_threaded(wq)) {
+		/* Always use first cpu's area. */
+		flush_one_work(per_cpu_ptr(wq->cpu_wq, singlethread_cpu), work);
+	} else {
+		int cpu;
+
+		mutex_lock(&workqueue_mutex);
+		for_each_online_cpu(cpu)
+			flush_one_work(per_cpu_ptr(wq->cpu_wq, cpu), work);
+		mutex_unlock(&workqueue_mutex);
+	}
+}
+
 /**
  * flush_workqueue - ensure that any scheduled work has run to completion.
  * @wq: workqueue to flush
_

