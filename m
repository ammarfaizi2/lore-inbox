Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316105AbSEJUJg>; Fri, 10 May 2002 16:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316106AbSEJUJf>; Fri, 10 May 2002 16:09:35 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:10120 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316105AbSEJUJe>;
	Fri, 10 May 2002 16:09:34 -0400
Date: Fri, 10 May 2002 13:09:04 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: set_cpus_allowed() optimization
Message-ID: <20020510130903.B1544@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider the following optimization to set_cpus_allowed().
In the case where the task does not reside on a runqueue, is it
not safe/sufficient to simply set the task's cpu field?  This
would avoid scheduling the migration thread to perform the task.

Previously, set_cpus_allowed() was always called for a task that
resides on a runqueue.  With the introduction of the 'cpu affinity'
system calls, this is no longer the case.

Does this seem reasonable?

A patch for 2.5.15 is included below.

-- 
Mike

diff -Naur linux-2.5.15/kernel/sched.c linux-2.5.15-sca/kernel/sched.c
--- linux-2.5.15/kernel/sched.c	Thu May  9 22:22:53 2002
+++ linux-2.5.15-sca/kernel/sched.c	Fri May 10 19:51:58 2002
@@ -1670,13 +1670,22 @@
 	rq = task_rq_lock(p, &flags);
 	p->cpus_allowed = new_mask;
 	/*
-	 * Can the task run on the task's current CPU? If not then
-	 * migrate the process off to a proper CPU.
+	 * Can the task run on the task's current CPU?
+	 * If yes, we are done.
 	 */
 	if (new_mask & (1UL << p->thread_info->cpu)) {
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
+	/*
+	 * If the task is not on a runqueue, then it is safe to
+	 * simply update the task's cpu field.
+	 */
+	if (!p->array) {
+		p->thread_info->cpu = __ffs(p->cpus_allowed);
+		task_rq_unlock(rq, &flags);
+		goto out;
+	}
 
 	init_MUTEX_LOCKED(&req.sem);
 	req.task = p;
