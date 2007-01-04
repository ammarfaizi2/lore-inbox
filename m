Return-Path: <linux-kernel-owner+w=401wt.eu-S1750699AbXADRVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbXADRVU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 12:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbXADRVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 12:21:20 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:37858 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbXADRVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 12:21:19 -0500
Date: Thu, 4 Jan 2007 09:18:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-Id: <20070104091850.c1feee76.akpm@osdl.org>
In-Reply-To: <20070104142936.GA179@tv-sign.ru>
References: <20061217223416.GA6872@tv-sign.ru>
	<20061218162701.a3b5bfda.akpm@osdl.org>
	<20061219004319.GA821@tv-sign.ru>
	<20070104113214.GA30377@in.ibm.com>
	<20070104142936.GA179@tv-sign.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007 17:29:36 +0300
Oleg Nesterov <oleg@tv-sign.ru> wrote:

> > In brief:
> > 
> > keventd thread					hotplug thread
> > --------------					--------------
> > 
> >   run_workqueue()
> > 	|
> >      work_fn()
> > 	 |
> > 	flush_workqueue()
> > 	     |	
> > 	   flush_cpu_workqueue
> > 		|				cpu_down()
> > 	     mutex_unlock(wq_mutex);		     |
> > 	(above opens window for hotplug)	   mutex_lock(wq_mutex);
> >     		|				   /* bring down cpu */	
> > 	     wait_for_completition();		     notifier(CPU_DEAD, ..)
> > 		| 				       workqueue_cpu_callback
> > 		| 				        cleanup_workqueue_thread
> > 		|					  kthread_stop()
> > 		|
> > 		|
> > 	     mutex_lock(wq_mutex); <- Can deadlock
> > 
> > 
> > The kthread_stop() will wait for keventd() thread to exit, but keventd()
> > is blocked on mutex_lock(wq_mutex) leading to a deadlock.

This?


--- a/kernel/workqueue.c~flush_workqueue-use-preempt_disable-to-hold-off-cpu-hotplug
+++ a/kernel/workqueue.c
@@ -419,18 +419,22 @@ static void flush_cpu_workqueue(struct c
 		 * Probably keventd trying to flush its own queue. So simply run
 		 * it by hand rather than deadlocking.
 		 */
-		mutex_unlock(&workqueue_mutex);
+		preempt_enable();
+		/*
+		 * We can still touch *cwq here because we are keventd, and
+		 * hot-unplug will be waiting us to exit.
+		 */
 		run_workqueue(cwq);
-		mutex_lock(&workqueue_mutex);
+		preempt_disable();
 	} else {
 		struct wq_barrier barr;
 
 		init_wq_barrier(&barr);
 		__queue_work(cwq, &barr.work);
 
-		mutex_unlock(&workqueue_mutex);
+		preempt_enable();	/* Can no longer touch *cwq */
 		wait_for_completion(&barr.done);
-		mutex_lock(&workqueue_mutex);
+		preempt_disable();
 	}
 }
 
@@ -449,7 +453,7 @@ static void flush_cpu_workqueue(struct c
  */
 void fastcall flush_workqueue(struct workqueue_struct *wq)
 {
-	mutex_lock(&workqueue_mutex);
+	preempt_disable();		/* CPU hotplug */
 	if (is_single_threaded(wq)) {
 		/* Always use first cpu's area. */
 		flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, singlethread_cpu));
@@ -459,7 +463,7 @@ void fastcall flush_workqueue(struct wor
 		for_each_online_cpu(cpu)
 			flush_cpu_workqueue(per_cpu_ptr(wq->cpu_wq, cpu));
 	}
-	mutex_unlock(&workqueue_mutex);
+	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(flush_workqueue);
 
_

