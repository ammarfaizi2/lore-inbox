Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262438AbSI3QSw>; Mon, 30 Sep 2002 12:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262336AbSI3QRk>; Mon, 30 Sep 2002 12:17:40 -0400
Received: from [198.149.18.6] ([198.149.18.6]:56223 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262329AbSI3QRb>;
	Mon, 30 Sep 2002 12:17:31 -0400
Date: Mon, 30 Sep 2002 19:37:13 -0400
From: Christoph Hellwig <hch@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lord@sgi.com, arjanv@redhat.com, cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
Message-ID: <20020930193713.A13195@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Ingo Molnar <mingo@elte.hu>, lord@sgi.com, arjanv@redhat.com,
	cw@f00f.org, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209291927400.15706-100000@localhost.localdomain>; from mingo@elte.hu on Sun, Sep 29, 2002 at 07:52:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 07:52:17PM +0200, Ingo Molnar wrote:
> i've done the following cleanups/simplifications to task-queues:
> 
>  - removed the ability to define your own task-queue, what can be done is 
>    to schedule_task() a given task to keventd, and to flush all pending 
>    tasks.
> 
> this is actually a quite easy transition, since 90% of all task-queue
> users in the kernel used BH_IMMEDIATE - which is very similar in
> functionality to keventd.

But it breaks XFS.  Chris Wedgwood fixed it to use schedule_task()
instead (and I cleaned it up a littler more, see patch below), but
this does effectively simgle-thead XFS I/O completion.

Why?  XFS used to have a per-cpu task-queue, emptied by a per-cpu
kernel thread.  To get anywhere near the per-formance again we'd
need to merge the per-cpu keventd patch Arjan did for RH 2.1AS into
2.5.  Altennatively we could allow kernel code to create it's own
kevends with associated task-queues, but that sounds rather ugly..


diff -uNr -p linux-2.5.39-mm1/fs/xfs/pagebuf/page_buf.c linux-2.5.39/fs/xfs/pagebuf/page_buf.c
--- linux-2.5.39-mm1/fs/xfs/pagebuf/page_buf.c	Mon Sep 30 14:27:25 2002
+++ linux-2.5.39/fs/xfs/pagebuf/page_buf.c	Mon Sep 30 16:49:06 2002
@@ -160,8 +160,6 @@ pb_tracking_free(
 
 STATIC kmem_cache_t *pagebuf_cache;
 STATIC pagebuf_daemon_t *pb_daemon;
-STATIC struct list_head pagebuf_iodone_tq[NR_CPUS];
-STATIC wait_queue_head_t pagebuf_iodone_wait[NR_CPUS];
 STATIC void pagebuf_daemon_wakeup(int);
 
 /*
@@ -1157,15 +1155,6 @@ _pagebuf_wait_unpin(
 	current->state = TASK_RUNNING;
 }
 
-void
-pagebuf_queue_task(
-	struct tq_struct	*task)
-{
-	queue_task(task, &pagebuf_iodone_tq[smp_processor_id()]);
-	wake_up(&pagebuf_iodone_wait[smp_processor_id()]);
-}
-
-
 /*
  *	Buffer Utility Routines
  */
@@ -1210,9 +1199,8 @@ pagebuf_iodone(
 		INIT_TQUEUE(&pb->pb_iodone_sched,
 			pagebuf_iodone_sched, (void *)pb);
 
-		queue_task(&pb->pb_iodone_sched,
-				&pagebuf_iodone_tq[smp_processor_id()]);
-		wake_up(&pagebuf_iodone_wait[smp_processor_id()]);
+		schedule_task(&pb->pb_iodone_sched);
+
 	} else {
 		up(&pb->pb_iodonesema);
 	}
@@ -1666,62 +1654,6 @@ pagebuf_delwri_dequeue(
 	spin_unlock(&pb_daemon->pb_delwrite_lock);
 }
 
-
-/*
- * The pagebuf iodone daemon
- */
-
-STATIC int pb_daemons[NR_CPUS];
-
-STATIC int
-pagebuf_iodone_daemon(
-	void			*__bind_cpu)
-{
-	int			cpu = (long) __bind_cpu;
-	DECLARE_WAITQUEUE	(wait, current);
-
-	/*  Set up the thread  */
-	daemonize();
-
-	/* Avoid signals */
-	spin_lock_irq(&current->sig->siglock);
-	sigfillset(&current->blocked);
-	recalc_sigpending();
-	spin_unlock_irq(&current->sig->siglock);
-
-	/* Migrate to the right CPU */
-	set_cpus_allowed(current, 1UL << cpu);
-	if (smp_processor_id() != cpu)
-		BUG();
-
-	sprintf(current->comm, "pagebuf_io_CPU%d", cpu);
-	INIT_LIST_HEAD(&pagebuf_iodone_tq[cpu]);
-	init_waitqueue_head(&pagebuf_iodone_wait[cpu]);
-	__set_current_state(TASK_INTERRUPTIBLE);
-	mb();
-
-	pb_daemons[cpu] = 1;
-
-	for (;;) {
-		add_wait_queue(&pagebuf_iodone_wait[cpu],
-				&wait);
-
-		if (TQ_ACTIVE(pagebuf_iodone_tq[cpu]))
-			__set_task_state(current, TASK_RUNNING);
-		schedule();
-		remove_wait_queue(&pagebuf_iodone_wait[cpu],
-				&wait);
-		run_task_queue(&pagebuf_iodone_tq[cpu]);
-		if (pb_daemons[cpu] == 0)
-			break;
-		__set_current_state(TASK_INTERRUPTIBLE);
-	}
-
-	pb_daemons[cpu] = -1;
-	wake_up_interruptible(&pagebuf_iodone_wait[cpu]);
-	return 0;
-}
-
 /* Defines for pagebuf daemon */
 DECLARE_WAIT_QUEUE_HEAD(pbd_waitq);
 STATIC int force_flush;
@@ -1907,8 +1839,6 @@ STATIC int
 pagebuf_daemon_start(void)
 {
 	if (!pb_daemon) {
-		int		cpu;
-
 		pb_daemon = (pagebuf_daemon_t *)
 				kmalloc(sizeof(pagebuf_daemon_t), GFP_KERNEL);
 		if (!pb_daemon) {
@@ -1924,19 +1854,6 @@ pagebuf_daemon_start(void)
 
 		kernel_thread(pagebuf_daemon, (void *)pb_daemon,
 				CLONE_FS|CLONE_FILES|CLONE_VM);
-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
-			if (!cpu_online(cpu))
-				continue;
-			if (kernel_thread(pagebuf_iodone_daemon,
-					(void *)(long) cpu,
-					CLONE_FS|CLONE_FILES|CLONE_VM) < 0) {
-				printk("pagebuf_daemon_start failed\n");
-			} else {
-				while (!pb_daemons[cpu]) {
-					yield();
-				}
-			}
-		}
 	}
 	return 0;
 }
@@ -1950,24 +1867,12 @@ STATIC void
 pagebuf_daemon_stop(void)
 {
 	if (pb_daemon) {
-		int		cpu;
-
 		pb_daemon->active = 0;
 		pb_daemon->io_active = 0;
 
 		wake_up_interruptible(&pbd_waitq);
 		while (pb_daemon->active == 0) {
 			interruptible_sleep_on(&pbd_waitq);
-		}
-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
-			if (!cpu_online(cpu))
-				continue;
-			pb_daemons[cpu] = 0;
-			wake_up(&pagebuf_iodone_wait[cpu]);
-			while (pb_daemons[cpu] != -1) {
-				interruptible_sleep_on(
-					&pagebuf_iodone_wait[cpu]);
-			}
 		}
 
 		kfree(pb_daemon);
diff -uNr -p linux-2.5.39-mm1/fs/xfs/pagebuf/page_buf.h linux-2.5.39/fs/xfs/pagebuf/page_buf.h
--- linux-2.5.39-mm1/fs/xfs/pagebuf/page_buf.h	Mon Sep 30 14:13:46 2002
+++ linux-2.5.39/fs/xfs/pagebuf/page_buf.h	Mon Sep 30 16:15:25 2002
@@ -324,9 +324,6 @@ extern void pagebuf_unlock(		/* unlock b
 
 #define pagebuf_geterror(pb)	((pb)->pb_error)
 
-extern void pagebuf_queue_task(
-		struct tq_struct *);
-
 extern void pagebuf_iodone(		/* mark buffer I/O complete	*/
 		page_buf_t *);		/* buffer to mark		*/
 
diff -uNr -p linux-2.5.39-mm1/fs/xfs/xfs_log.c linux-2.5.39/fs/xfs/xfs_log.c
--- linux-2.5.39-mm1/fs/xfs/xfs_log.c	Mon Sep 30 14:15:55 2002
+++ linux-2.5.39/fs/xfs/xfs_log.c	Mon Sep 30 16:15:25 2002
@@ -2779,7 +2779,7 @@ xlog_state_release_iclog(xlog_t		*log,
 		case 0:
 			return xlog_sync(log, iclog, 0);
 		case 1:
-			pagebuf_queue_task(&iclog->ic_write_sched);
+		        schedule_task(&iclog->ic_write_sched);
 		}
 	}
 	return (0);
