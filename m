Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263875AbUECUGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUECUGQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 16:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbUECUGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 16:06:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:11453 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263875AbUECUGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 16:06:09 -0400
Date: Mon, 3 May 2004 13:08:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: rusty@rustcorp.com.au, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix deadlock in __create_workqueue
Message-Id: <20040503130829.5c43c6fe.akpm@osdl.org>
In-Reply-To: <20040503122412.GB7143@in.ibm.com>
References: <20040430113751.GA18296@in.ibm.com>
	<20040430191901.510ae947.akpm@osdl.org>
	<20040503122412.GB7143@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> On Fri, Apr 30, 2004 at 07:19:01PM -0700, Andrew Morton wrote:
> > Yes, the logic in worker_thread() is a bit dorky, but I
> > don't believe that there is a race in there.
> 
> worker_thread examines kthread_should_stop() while its state
> is TASK_RUNNING, after which it sets its state to TASK_INTERRUPTIBLE.
> If kthread_stop were to come after kthread_should_stop and before
> worker_thread has set its state to TASK_INTERRUPTIBLE (which is possible
> because of a CPU going dead), wouldn't kthread_stop block forever? 
> Note that in case of CPU going dead, it is possible that a worker
> thread bound to the dead cpu continues executing on a different cpu 
> before it is killed in CPU_DEAD processing.

yup, sorry, I misread the code.  Like this?


--- 25/kernel/workqueue.c~worker_thread-race-fix	Mon May  3 13:02:25 2004
+++ 25-akpm/kernel/workqueue.c	Mon May  3 13:07:34 2004
@@ -201,19 +201,20 @@ static int worker_thread(void *__cwq)
 	siginitset(&sa.sa.sa_mask, sigmask(SIGCHLD));
 	do_sigaction(SIGCHLD, &sa, (struct k_sigaction *)0);
 
+	set_current_state(TASK_INTERRUPTIBLE);
 	while (!kthread_should_stop()) {
-		set_task_state(current, TASK_INTERRUPTIBLE);
-
 		add_wait_queue(&cwq->more_work, &wait);
 		if (list_empty(&cwq->worklist))
 			schedule();
 		else
-			set_task_state(current, TASK_RUNNING);
+			__set_current_state(TASK_RUNNING);
 		remove_wait_queue(&cwq->more_work, &wait);
 
 		if (!list_empty(&cwq->worklist))
 			run_workqueue(cwq);
+		set_current_state(TASK_INTERRUPTIBLE);
 	}
+	__set_current_state(TASK_RUNNING);
 	return 0;
 }
 

_

