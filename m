Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312235AbSCYCNv>; Sun, 24 Mar 2002 21:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312233AbSCYCNl>; Sun, 24 Mar 2002 21:13:41 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:34572 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S312235AbSCYCN2>; Sun, 24 Mar 2002 21:13:28 -0500
Message-ID: <3C9E8767.4F57CB0A@zip.com.au>
Date: Sun, 24 Mar 2002 18:11:51 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: preempt-related hangs
In-Reply-To: <3C9E8497.9355C462@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ..
> Kernel is 2.5.7, dual PIII.  When I enable preempt it
> locks during boot.

OK, this patch fixed it.  I don't know why.


--- linux-2.5.7/kernel/sched.c	Mon Mar 18 13:04:41 2002
+++ 25/kernel/sched.c	Sun Mar 24 18:09:09 2002
@@ -1545,6 +1545,8 @@ void set_cpus_allowed(task_t *p, unsigne
 	migration_req_t req;
 	runqueue_t *rq;
 
+	preempt_disable();
+
 	new_mask &= cpu_online_map;
 	if (!new_mask)
 		BUG();
@@ -1557,7 +1559,7 @@ void set_cpus_allowed(task_t *p, unsigne
 	 */
 	if (new_mask & (1UL << p->thread_info->cpu)) {
 		task_rq_unlock(rq, &flags);
-		return;
+		goto out;
 	}
 
 	init_MUTEX_LOCKED(&req.sem);
@@ -1567,6 +1569,8 @@ void set_cpus_allowed(task_t *p, unsigne
 	wake_up_process(rq->migration_thread);
 
 	down(&req.sem);
+out:
+	preempt_disable();
 }
 
 static volatile unsigned long migration_mask;


-
