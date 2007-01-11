Return-Path: <linux-kernel-owner+w=401wt.eu-S1030231AbXAKXNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbXAKXNl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 18:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbXAKXNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 18:13:41 -0500
Received: from mail.screens.ru ([213.234.233.54]:52971 "EHLO mail.screens.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030231AbXAKXNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 18:13:40 -0500
Date: Fri, 12 Jan 2007 02:12:57 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Gautham shenoy <ego@in.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] workqueue: don't clear cwq->thread until it exits
Message-ID: <20070111231257.GA2987@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pointed out by Srivatsa Vaddagiri.

cleanup_workqueue_thread() sets cwq->thread = NULL and does kthread_stop().
This breaks the "if (cwq->thread == current)" logic in flush_cpu_workqueue()
and leads to deadlock.

Kill the thead first, then clear cwq->thread. workqueue_mutex protects us
from create_workqueue_thread() so we don't need cwq->lock.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- mm-6.20-rc3/kernel/workqueue.c~3_thread	2007-01-11 22:22:58.000000000 +0300
+++ mm-6.20-rc3/kernel/workqueue.c	2007-01-12 01:44:39.000000000 +0300
@@ -625,17 +625,12 @@ EXPORT_SYMBOL_GPL(__create_workqueue);
 
 static void cleanup_workqueue_thread(struct workqueue_struct *wq, int cpu)
 {
-	struct cpu_workqueue_struct *cwq;
-	unsigned long flags;
-	struct task_struct *p;
+	struct cpu_workqueue_struct *cwq = per_cpu_ptr(wq->cpu_wq, cpu);
 
-	cwq = per_cpu_ptr(wq->cpu_wq, cpu);
-	spin_lock_irqsave(&cwq->lock, flags);
-	p = cwq->thread;
-	cwq->thread = NULL;
-	spin_unlock_irqrestore(&cwq->lock, flags);
-	if (p)
-		kthread_stop(p);
+	if (cwq->thread) {
+		kthread_stop(cwq->thread);
+		cwq->thread = NULL;
+	}
 }
 
 /**

