Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbUCMCMX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 21:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262989AbUCMCMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 21:12:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:55752 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262800AbUCMCMM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 21:12:12 -0500
Date: Fri, 12 Mar 2004 18:12:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: thockin@Sun.COM, linux-kernel@vger.kernel.org
Subject: Re: calling flush_scheduled_work()
Message-Id: <20040312181214.15316729.akpm@osdl.org>
In-Reply-To: <1079140670.3166.87.camel@lade.trondhjem.org>
References: <20040312205814.GY1333@sun.com>
	<20040312152747.0b3f74d3.akpm@osdl.org>
	<1079140670.3166.87.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> På fr , 12/03/2004 klokka 18:27, skreiv Andrew Morton:
> > Seems simple enough to fix the workqueue code to handle this situation.
> > 
> > Wanna test this for me?
> 
> What if one of the workloads on the queue has another call to
> flush_scheduled_work()? (which again finds itself calling another
> instance, ...)

I fixed that with the old solution-via-changelog:


  Because keventd is a resource which is shared between unrelated parts
  of the kernel it is possible for one person's workqueue handler to
  accidentally call another person's flush_scheduled_work().  thockin
  managed it by calling mntput() from a workqueue handler.  It deadlocks.

  It's simple enough to fix: teach flush_scheduled_work() to go direct
  when it discovers that the calling thread is the one which should be
  running the work.

  Note that this can cause recursion.  The depth of that recursion is
  equal to the number of currently-queued works which themselves want to
  call flush_scheduled_work().  If this ever exceeds three I'll eat my hat.


Really, it's so unlikely it's hardly worth bothering about.

> This fix doesn't really resolve the deadlock issue. It just reduces the
> possibilities of it having any consequences...
> 
> Could you please at least include a dump_stack() before the call to
> run_workqueue()) so that we can catch the bug in the act, and attempt to
> fix it.

How's this?



Add a debug check for workqueues nested more than three deep via the
direct-run-workqueue() path.


---

 25-akpm/kernel/workqueue.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

diff -puN kernel/workqueue.c~flush_scheduled_work-recursion-detect kernel/workqueue.c
--- 25/kernel/workqueue.c~flush_scheduled_work-recursion-detect	2004-03-12 17:54:32.859424968 -0800
+++ 25-akpm/kernel/workqueue.c	2004-03-12 18:11:09.939845704 -0800
@@ -47,6 +47,7 @@ struct cpu_workqueue_struct {
 	struct workqueue_struct *wq;
 	task_t *thread;
 
+	int run_depth;		/* Detect run_workqueue() recursion depth */
 } ____cacheline_aligned;
 
 /*
@@ -140,6 +141,13 @@ static inline void run_workqueue(struct 
 	 * done.
 	 */
 	spin_lock_irqsave(&cwq->lock, flags);
+	cwq->run_depth++;
+	if (cwq->run_depth > 3) {
+		/* morton gets to eat his hat */
+		printk("%s: recusrion depth exceeded: %d\n",
+			__FUNCTION__, cwq->run_depth);
+		dump_stack();
+	}
 	while (!list_empty(&cwq->worklist)) {
 		struct work_struct *work = list_entry(cwq->worklist.next,
 						struct work_struct, entry);
@@ -157,6 +165,7 @@ static inline void run_workqueue(struct 
 		cwq->remove_sequence++;
 		wake_up(&cwq->work_done);
 	}
+	cwq->run_depth--;
 	spin_unlock_irqrestore(&cwq->lock, flags);
 }
 
@@ -286,6 +295,7 @@ struct workqueue_struct *create_workqueu
 	wq = kmalloc(sizeof(*wq), GFP_KERNEL);
 	if (!wq)
 		return NULL;
+	memset(wq, 0, sizeof(*wq));
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
 		if (!cpu_online(cpu))

_

