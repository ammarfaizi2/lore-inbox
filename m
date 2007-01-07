Return-Path: <linux-kernel-owner+w=401wt.eu-S965221AbXAGVvS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965221AbXAGVvS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 16:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbXAGVvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 16:51:18 -0500
Received: from mail.screens.ru ([213.234.233.54]:44169 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965221AbXAGVvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 16:51:17 -0500
Date: Mon, 8 Jan 2007 00:51:03 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH] fix-flush_workqueue-vs-cpu_dead-race-update
Message-ID: <20070107215103.GA7960@tv-sign.ru>
References: <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107115957.6080aa08.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07, Andrew Morton wrote:
>
> Plus flush_workqueue() is on the way out.  We're slowly edging towards a
> working cancel_work() which will only block if the work which you're trying
> to cancel is presently running.  With that, pretty much all the
> flush_workqueue() calls go away, and all these accidental rarely-occurring
> deadlocks go away too.

So. If we can forget about the race we have - fine. Otherwise, how about the
patch below? It is untested and needs a review. I can't suggest any simpler
now.

Change flush_workqueue() to use for_each_possible_cpu(). This means that
flush_cpu_workqueue() may hit CPU which is already dead. However in that
case

	if (!list_empty(&cwq->worklist) || cwq->current_work != NULL)

means that CPU_DEAD in progress, it will do kthread_stop() + take_over_work()
so we can proceed and insert a barrier. We hold cwq->lock, so we are safe.

This patch replaces fix-flush_workqueue-vs-cpu_dead-race.patch which was
broken by switching to preempt_disable (now we don't need locking at all).
Note that migrate_sequence (was hotplug_sequence) is incremented under
cwq->lock. Since flush_workqueue does lock/unlock of cwq->lock on all CPUs,
it must see the new value if take_over_work() happened before we checked
this cwq, and this is the case we should worry about: otherwise we added
a barrier.

Srivatsa?

--- mm-6.20-rc3/kernel/workqueue.c~2_race	2007-01-08 00:07:07.000000000 +0300
+++ mm-6.20-rc3/kernel/workqueue.c	2007-01-08 00:28:55.000000000 +0300
@@ -65,6 +65,7 @@ struct workqueue_struct {
 
 /* All the per-cpu workqueues on the system, for hotplug cpu to add/remove
    threads to each one as cpus come/go. */
+static long migrate_sequence __read_mostly;
 static DEFINE_MUTEX(workqueue_mutex);
 static LIST_HEAD(workqueues);
 
@@ -422,13 +423,7 @@ static void flush_cpu_workqueue(struct c
 		 * Probably keventd trying to flush its own queue. So simply run
 		 * it by hand rather than deadlocking.
 		 */
-		preempt_enable();
-		/*
-		 * We can still touch *cwq here because we are keventd, and
-		 * hot-unplug will be waiting us to exit.
-		 */
 		run_workqueue(cwq);
-		preempt_disable();
 	} else {
 		struct wq_barrier barr;
 		int active = 0;
@@ -441,9 +436,7 @@ static void flush_cpu_workqueue(struct c
 		spin_unlock_irq(&cwq->lock);
 
 		if (active) {
-			preempt_enable();
 			wait_for_completion(&barr.done);
-			preempt_disable();
 		}
 	}
 }
@@ -463,17 +456,21 @@ static void flush_cpu_workqueue(struct c
  */
 void fastcall flush_workqueue(struct workqueue_struct *wq)
 {
-	preempt_disable();		/* CPU hotplug */
 	if (is_single_threaded(wq)) {
 		/* Always use first cpu's area. */
 		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu));
 	} else {
+		long sequence;
 		int cpu;
+again:
+		sequence = migrate_sequence;
 
-		for_each_online_cpu(cpu)
+		for_each_possible_cpu(cpu)
 			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu));
+
+		if (unlikely(sequence != migrate_sequence))
+			goto again;
 	}
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(flush_workqueue);
 
@@ -545,18 +542,22 @@ out:
 }
 EXPORT_SYMBOL_GPL(flush_work);
 
-static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
-						   int cpu, int freezeable)
+static void init_cpu_workqueue(struct workqueue_struct *wq,
+			struct cpu_workqueue_struct *cwq, int freezeable)
 {
-	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
-	struct task_struct *p;
-
 	spin_lock_init(&cwq->lock);
 	cwq->wq = wq;
 	cwq->thread = NULL;
 	cwq->freezeable = freezeable;
 	INIT_LIST_HEAD(&cwq->worklist);
 	init_waitqueue_head(&cwq->more_work);
+}
+
+static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
+						   int cpu)
+{
+	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
+	struct task_struct *p;
 
 	if (is_single_threaded(wq))
 		p = kthread_create(worker_thread, cwq, "%s", wq->name);
@@ -589,15 +590,20 @@ struct workqueue_struct *__create_workqu
 	mutex_lock(&workqueue_mutex);
 	if (singlethread) {
 		INIT_LIST_HEAD(&wq->list);
-		p = create_workqueue_thread(wq, singlethread_cpu, freezeable);
+		init_cpu_workqueue(wq, per_cpu_ptr(wq->cpu_wq, singlethread_cpu),
+					freezeable);
+		p = create_workqueue_thread(wq, singlethread_cpu);
 		if (!p)
 			destroy = 1;
 		else
 			wake_up_process(p);
 	} else {
 		list_add(&wq->list, &workqueues);
+		for_each_possible_cpu(cpu)
+			init_cpu_workqueue(wq, per_cpu_ptr(wq->cpu_wq, cpu),
+						freezeable);
 		for_each_online_cpu(cpu) {
-			p = create_workqueue_thread(wq, cpu, freezeable);
+			p = create_workqueue_thread(wq, cpu);
 			if (p) {
 				kthread_bind(p, cpu);
 				wake_up_process(p);
@@ -833,6 +839,7 @@ static void take_over_work(struct workqu
 
 	spin_lock_irq(&cwq->lock);
 	list_replace_init(&cwq->worklist, &list);
+	migrate_sequence++;
 
 	while (!list_empty(&list)) {
 		printk("Taking work for %s\n", wq->name);
@@ -859,7 +866,7 @@ static int __devinit workqueue_cpu_callb
 	case CPU_UP_PREPARE:
 		/* Create a new workqueue thread for it. */
 		list_for_each_entry(wq, &workqueues, list) {
-			if (!create_workqueue_thread(wq, hotcpu, 0)) {
+			if (!create_workqueue_thread(wq, hotcpu)) {
 				printk("workqueue for %i failed\n", hotcpu);
 				return NOTIFY_BAD;
 			}

