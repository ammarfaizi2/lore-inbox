Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261994AbVDEXtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbVDEXtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 19:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbVDEXsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 19:48:41 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:32914 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261994AbVDEXrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 19:47:49 -0400
Message-ID: <425323A1.5030603@yahoo.com.au>
Date: Wed, 06 Apr 2005 09:47:45 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: [patch 4/5] sched: RCU sched domains
References: <425322E0.9070307@yahoo.com.au> <42532317.5000901@yahoo.com.au> <42532346.5050308@yahoo.com.au>
In-Reply-To: <42532346.5050308@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------080408020205050308070406"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080408020205050308070406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

4/5

--------------080408020205050308070406
Content-Type: text/plain;
 name="sched-rcu-domains.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-rcu-domains.patch"

One of the problems with the multilevel balance-on-fork/exec is that it
needs to jump through hoops to satisfy sched-domain's locking semantics
(that is, you may traverse your own domain when not preemptable, and
you may traverse others' domains when holding their runqueue lock).

balance-on-exec had to potentially migrate between more than one CPU before
finding a final CPU to migrate to, and balance-on-fork needed to potentially
take multiple runqueue locks.

So bite the bullet and make sched-domains go completely RCU. This actually
simplifies the code quite a bit.

Signed-off-by: Nick Piggin <nickpiggin@yahoo.com.au>

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c	2005-04-05 16:39:14.000000000 +1000
+++ linux-2.6/kernel/sched.c	2005-04-05 18:39:05.000000000 +1000
@@ -825,22 +825,12 @@ inline int task_curr(const task_t *p)
 }
 
 #ifdef CONFIG_SMP
-enum request_type {
-	REQ_MOVE_TASK,
-	REQ_SET_DOMAIN,
-};
-
 typedef struct {
 	struct list_head list;
-	enum request_type type;
 
-	/* For REQ_MOVE_TASK */
 	task_t *task;
 	int dest_cpu;
 
-	/* For REQ_SET_DOMAIN */
-	struct sched_domain *sd;
-
 	struct completion done;
 } migration_req_t;
 
@@ -862,7 +852,6 @@ static int migrate_task(task_t *p, int d
 	}
 
 	init_completion(&req->done);
-	req->type = REQ_MOVE_TASK;
 	req->task = p;
 	req->dest_cpu = dest_cpu;
 	list_add(&req->list, &rq->migration_queue);
@@ -4365,17 +4354,9 @@ static int migration_thread(void * data)
 		req = list_entry(head->next, migration_req_t, list);
 		list_del_init(head->next);
 
-		if (req->type == REQ_MOVE_TASK) {
-			spin_unlock(&rq->lock);
-			__migrate_task(req->task, cpu, req->dest_cpu);
-			local_irq_enable();
-		} else if (req->type == REQ_SET_DOMAIN) {
-			rq->sd = req->sd;
-			spin_unlock_irq(&rq->lock);
-		} else {
-			spin_unlock_irq(&rq->lock);
-			WARN_ON(1);
-		}
+		spin_unlock(&rq->lock);
+		__migrate_task(req->task, cpu, req->dest_cpu);
+		local_irq_enable();
 
 		complete(&req->done);
 	}
@@ -4606,7 +4587,6 @@ static int migration_call(struct notifie
 			migration_req_t *req;
 			req = list_entry(rq->migration_queue.next,
 					 migration_req_t, list);
-			BUG_ON(req->type != REQ_MOVE_TASK);
 			list_del_init(&req->list);
 			complete(&req->done);
 		}
@@ -4903,10 +4883,7 @@ static int __devinit sd_parent_degenerat
  */
 void __devinit cpu_attach_domain(struct sched_domain *sd, int cpu)
 {
-	migration_req_t req;
-	unsigned long flags;
 	runqueue_t *rq = cpu_rq(cpu);
-	int local = 1;
 	struct sched_domain *tmp;
 
 	/* Remove the sched domains which do not contribute to scheduling. */
@@ -4923,24 +4900,7 @@ void __devinit cpu_attach_domain(struct 
 
 	sched_domain_debug(sd, cpu);
 
-	spin_lock_irqsave(&rq->lock, flags);
-
-	if (cpu == smp_processor_id() || !cpu_online(cpu)) {
-		rq->sd = sd;
-	} else {
-		init_completion(&req.done);
-		req.type = REQ_SET_DOMAIN;
-		req.sd = sd;
-		list_add(&req.list, &rq->migration_queue);
-		local = 0;
-	}
-
-	spin_unlock_irqrestore(&rq->lock, flags);
-
-	if (!local) {
-		wake_up_process(rq->migration_thread);
-		wait_for_completion(&req.done);
-	}
+	rq->sd = sd;
 }
 
 /* cpus with isolated domains */
@@ -5215,6 +5175,7 @@ static int update_sched_domains(struct n
 	case CPU_DOWN_PREPARE:
 		for_each_online_cpu(i)
 			cpu_attach_domain(NULL, i);
+		synchronize_kernel();
 		arch_destroy_sched_domains();
 		return NOTIFY_OK;
 

--------------080408020205050308070406--

