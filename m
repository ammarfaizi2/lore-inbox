Return-Path: <linux-kernel-owner+w=401wt.eu-S1161099AbXAEOGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbXAEOGk (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 09:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161100AbXAEOGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 09:06:39 -0500
Received: from mail.screens.ru ([213.234.233.54]:56788 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161099AbXAEOGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 09:06:39 -0500
Date: Fri, 5 Jan 2007 17:07:17 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
Message-ID: <20070105140717.GA81@tv-sign.ru>
References: <20061217223416.GA6872@tv-sign.ru> <20061218162701.a3b5bfda.akpm@osdl.org> <20061219004319.GA821@tv-sign.ru> <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070104180901.GA344@tv-sign.ru> <20070104103107.e33768d7.akpm@osdl.org> <20070105090347.GC18088@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070105090347.GC18088@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05, Srivatsa Vaddagiri wrote:
>
> On Thu, Jan 04, 2007 at 10:31:07AM -0800, Andrew Morton wrote:
> > But before we do much more of this we should have a wrapper.  Umm
> > 
> > static inline void block_cpu_hotplug(void)
> > {
> > 	preempt_disable();
> > }
> 
> Nack.
> 
> This will only block cpu down, not cpu_up and hence is a misnomer. I would be 
> vary of ignoring cpu_up events totally in writing hotplug safe code.

How about block_cpu_down() ?

These cpu-hotplug races delayed the last workqueue patch I have in my queue.
flush_workqueue() misses an important optimization: we don't need to insert
a barrier and have an extra wake_up + wait_for_completion when cwq has no
pending works. But we need ->current_work (introduced in the next patch) to
implement this correctly.

I'll re-send the patch below later, when we finish with the bug you pointed
out, but it would be nice if you can take a look now.

Oleg.

--- mm-6.20-rc2/kernel/workqueue.c~4_speedup	2006-12-30 18:09:07.000000000 +0300
+++ mm-6.20-rc2/kernel/workqueue.c	2007-01-05 16:32:45.000000000 +0300
@@ -405,12 +405,15 @@ static void wq_barrier_func(struct work_
 	complete(&barr->done);
 }
 
-static inline void init_wq_barrier(struct wq_barrier *barr)
+static void insert_wq_barrier(struct cpu_workqueue_struct *cwq,
+					struct wq_barrier *barr, int tail)
 {
 	INIT_WORK(&barr->work, wq_barrier_func);
 	__set_bit(WORK_STRUCT_PENDING, work_data_bits(&barr->work));
 
 	init_completion(&barr->done);
+
+	insert_work(cwq, &barr->work, tail);
 }
 
 static void flush_cpu_workqueue(struct cpu_workqueue_struct *cwq)
@@ -425,13 +428,20 @@ static void flush_cpu_workqueue(struct c
 		mutex_lock(&workqueue_mutex);
 	} else {
 		struct wq_barrier barr;
+		int active = 0;
 
-		init_wq_barrier(&barr);
-		__queue_work(cwq, &barr.work);
+		spin_lock_irq(&cwq->lock);
+		if (!list_empty(&cwq->worklist) || cwq->current_work != NULL) {
+			insert_wq_barrier(cwq, &barr, 1);
+			active = 1;
+		}
+		spin_unlock_irq(&cwq->lock);
 
-		mutex_unlock(&workqueue_mutex);
-		wait_for_completion(&barr.done);
-		mutex_lock(&workqueue_mutex);
+		if (active) {
+			mutex_unlock(&workqueue_mutex);
+			wait_for_completion(&barr.done);
+			mutex_lock(&workqueue_mutex);
+		}
 	}
 }
 
@@ -478,8 +488,7 @@ static void wait_on_work(struct cpu_work
 
 	spin_lock_irq(&cwq->lock);
 	if (unlikely(cwq->current_work == work)) {
-		init_wq_barrier(&barr);
-		insert_work(cwq, &barr.work, 0);
+		insert_wq_barrier(cwq, &barr, 0);
 		running = 1;
 	}
 	spin_unlock_irq(&cwq->lock);

