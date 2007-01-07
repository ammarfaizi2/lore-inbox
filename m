Return-Path: <linux-kernel-owner+w=401wt.eu-S965158AbXAGVB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbXAGVB5 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 16:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965164AbXAGVB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 16:01:57 -0500
Received: from mail.screens.ru ([213.234.233.54]:60438 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965158AbXAGVB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 16:01:56 -0500
Date: Mon, 8 Jan 2007 00:01:39 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: vatsa@in.ibm.com, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Gautham shenoy <ego@in.ibm.com>
Subject: [PATCH] flush_cpu_workqueue: don't flush an empty ->worklist
Message-ID: <20070107210139.GA2332@tv-sign.ru>
References: <20070104113214.GA30377@in.ibm.com> <20070104142936.GA179@tv-sign.ru> <20070104091850.c1feee76.akpm@osdl.org> <20070106151036.GA951@tv-sign.ru> <20070106154506.GC24274@in.ibm.com> <20070106163035.GA2948@tv-sign.ru> <20070106163851.GA13579@in.ibm.com> <20070106111117.54bb2307.akpm@osdl.org> <20070107110013.GD13579@in.ibm.com> <20070107115957.6080aa08.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107115957.6080aa08.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now when we have ->current_work we can avoid adding a barrier and waiting for
its completition when cwq's queue is empty.

Note: this change is also useful if we change flush_workqueue() to also check
the dead CPUs.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- mm-6.20-rc3/kernel/workqueue.c~1_opt	2007-01-07 23:15:50.000000000 +0300
+++ mm-6.20-rc3/kernel/workqueue.c	2007-01-07 23:26:45.000000000 +0300
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
@@ -429,13 +432,20 @@ static void flush_cpu_workqueue(struct c
 		preempt_disable();
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
 
-		preempt_enable();	/* Can no longer touch *cwq */
-		wait_for_completion(&barr.done);
-		preempt_disable();
+		if (active) {
+			preempt_enable();
+			wait_for_completion(&barr.done);
+			preempt_disable();
+		}
 	}
 }
 
@@ -482,8 +492,7 @@ static void wait_on_work(struct cpu_work
 
 	spin_lock_irq(&cwq->lock);
 	if (unlikely(cwq->current_work == work)) {
-		init_wq_barrier(&barr);
-		insert_work(cwq, &barr.work, 0);
+		insert_wq_barrier(cwq, &barr, 0);
 		running = 1;
 	}
 	spin_unlock_irq(&cwq->lock);

