Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313167AbSDOS5Y>; Mon, 15 Apr 2002 14:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313168AbSDOS5Y>; Mon, 15 Apr 2002 14:57:24 -0400
Received: from zero.tech9.net ([209.61.188.187]:35088 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313167AbSDOS5X>;
	Mon, 15 Apr 2002 14:57:23 -0400
Subject: [PATCH] migration_thread preempt fix
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 15 Apr 2002 14:57:26 -0400
Message-Id: <1018897046.857.20.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Attached is a resend of a patch to fix a race in migration_thread which
results in a deadlock on boot for some SMP systems.  The fix is to to
disable preemption inside of set_cpus_allowed.

Andrew Morton first noticed the problem and provided the following patch
a few weeks back.  I was not affected until the recent migration_init
fix, for some odd reason.  Neither Andrew nor I think this is actually
kernel preemption's fault but perhaps a race in the tricky behavior of
the migration code.

Patch is against 2.5.8, please apply.

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



