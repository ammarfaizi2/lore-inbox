Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311577AbSDQSZ6>; Wed, 17 Apr 2002 14:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312410AbSDQSZ5>; Wed, 17 Apr 2002 14:25:57 -0400
Received: from zero.tech9.net ([209.61.188.187]:12304 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S311577AbSDQSZ4>;
	Wed, 17 Apr 2002 14:25:56 -0400
Subject: Re: 2.5.8: preemption + SMP broken ?
From: Robert Love <rml@tech9.net>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020417232253.A629@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 17 Apr 2002 14:25:57 -0400
Message-Id: <1019067957.1669.46.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-04-17 at 13:52, Dipankar Sarma wrote:
> My machine (4cpu x86) hangs while booting a kernel with SMP
> and preemption enabled. It hangs while executing one of
> the initcalls, probably BIO since that is where the
> next boot message comes from during a successful boot with SMP
> (or preemption) disabled.
> 
> Has anyone tried out preemption with SMP ?

Sure, all my testing is on SMP.  The problem manifested itself in
2.5.8-pre when some changes where made to the migration code.  The race
is in the migration code - I am not sure it is preempts fault, per se,
but the attached patch should fix it.  It is pending with Linus for the
next release.

	Robert Love

diff -urN linux-2.5.8/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.8/kernel/sched.c	Sun Apr 14 15:18:47 2002
+++ linux/kernel/sched.c	Mon Apr 15 14:47:18 2002
@@ -1649,6 +1649,7 @@
 	if (!new_mask)
 		BUG();
 
+	preempt_disable();
 	rq = task_rq_lock(p, &flags);
 	p->cpus_allowed = new_mask;
 	/*
@@ -1657,7 +1658,7 @@
 	 */
 	if (new_mask & (1UL << p->thread_info->cpu)) {
 		task_rq_unlock(rq, &flags);
-		return;
+		goto out;
 	}
 
 	init_MUTEX_LOCKED(&req.sem);
@@ -1667,6 +1668,8 @@
 	wake_up_process(rq->migration_thread);
 
 	down(&req.sem);
+out:
+	preempt_enable();
 }
 
 static volatile unsigned long migration_mask;


