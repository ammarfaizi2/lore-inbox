Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263645AbUDVHDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUDVHDy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263614AbUDVHDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:03:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:50597 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263645AbUDVHDu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:03:50 -0400
Date: Thu, 22 Apr 2004 00:03:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: rusty@au1.ibm.com, mingo@elte.hu, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: CPU Hotplug broken -mm5 onwards
Message-Id: <20040422000308.4ba47e03.akpm@osdl.org>
In-Reply-To: <20040421164436.GA11760@in.ibm.com>
References: <20040418170613.GA21769@in.ibm.com>
	<20040421023650.24b9f85a.akpm@osdl.org>
	<20040421095939.GB10767@in.ibm.com>
	<20040421164436.GA11760@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> Anyway patch below addresses the above races. Its against 2.6.6-rc2-mm1
>  and has been tested on a 4way Intel Pentium SMP m/c. I have added a
>  cpu_is_offlince check in migration_thread(). If that is true, migration
>  thread stop processing and just waits for kthread_stop.

I'll take the stunned silence as agreement ;)

It needed a warning fixup:

kernel/sched.c: In function `migration_call':
kernel/sched.c:3648: warning: unused variable `tmp'
kernel/sched.c:3648: warning: unused variable `req'
kernel/sched.c:3647: warning: unused variable `head'

---

 25-akpm/kernel/sched.c |   44 ++++++++++++++++++++++++--------------------
 1 files changed, 24 insertions(+), 20 deletions(-)

diff -puN kernel/sched.c~sched-remove_hotplug_lock_in_sched_migrate_task-warnings kernel/sched.c
--- 25/kernel/sched.c~sched-remove_hotplug_lock_in_sched_migrate_task-warnings	2004-04-21 23:56:43.736745848 -0700
+++ 25-akpm/kernel/sched.c	2004-04-21 23:58:42.628671528 -0700
@@ -3339,8 +3339,6 @@ static int migration_call(struct notifie
 	struct task_struct *p;
 	struct runqueue *rq;
 	unsigned long flags;
-	struct list_head *head;
-	migration_req_t *req, *tmp;
 
 	switch (action) {
 	case CPU_UP_PREPARE:
@@ -3363,25 +3361,31 @@ static int migration_call(struct notifie
 		/* Unbind it from offline cpu so it can run.  Fall thru. */
 		kthread_bind(cpu_rq(cpu)->migration_thread,smp_processor_id());
 	case CPU_DEAD:
-		rq = cpu_rq(cpu);
-		head = &rq->migration_queue;
-		spin_lock_irq(&rq->lock);
-		list_for_each_entry_safe(req, tmp, head, list) {
-
-			BUG_ON(req->type != REQ_MOVE_TASK);
-
-			list_del_init(&req->list);
-
-			/* No need to migrate the task in the request. It would
-	 		 * have already been migrated (maybe to a different
-			 * CPU). Just wake up the requestor.
-			 */
-			complete(&req->done);
+		{
+			struct list_head *head;
+			migration_req_t *req, *tmp;
+
+			rq = cpu_rq(cpu);
+			head = &rq->migration_queue;
+			spin_lock_irq(&rq->lock);
+			list_for_each_entry_safe(req, tmp, head, list) {
+
+				BUG_ON(req->type != REQ_MOVE_TASK);
+
+				list_del_init(&req->list);
+
+				/*
+				 * No need to migrate the task in the request.
+				 * It would have already been migrated (maybe to
+				 * a different CPU). Just wake up the requestor
+				 */
+				complete(&req->done);
+			}
+			spin_unlock_irq(&rq->lock);
+			kthread_stop(cpu_rq(cpu)->migration_thread);
+			cpu_rq(cpu)->migration_thread = NULL;
+	 		BUG_ON(cpu_rq(cpu)->nr_running != 0);
 		}
-		spin_unlock_irq(&rq->lock);
-		kthread_stop(cpu_rq(cpu)->migration_thread);
-		cpu_rq(cpu)->migration_thread = NULL;
- 		BUG_ON(cpu_rq(cpu)->nr_running != 0);
  		break;
 #endif
 	}

_

