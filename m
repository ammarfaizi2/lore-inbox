Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932911AbWFWIQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932911AbWFWIQk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 04:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932932AbWFWIQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 04:16:40 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:11799 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932911AbWFWIQj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 04:16:39 -0400
Message-ID: <449BA349.6040901@openvz.org>
Date: Fri, 23 Jun 2006 12:16:09 +0400
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] sched: CPU hotplug race vs. set_cpus_allowed()
Content-Type: multipart/mixed;
 boundary="------------010105090808030405030208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010105090808030405030208
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Looks like there is a race between set_cpus_allowed()
and move_task_off_dead_cpu().
__migrate_task() doesn't report any err code, so
task can be left on its runqueue if its cpus_allowed mask
changed so that dest_cpu is not longer a possible target.
Also, chaning cpus_allowed mask requires rq->lock being held.

Signed-Off-By: Kirill Korotaev <dev@openvz.org>

Kirill
P.S. against 2.6.17-mm1


--------------010105090808030405030208
Content-Type: text/plain;
 name="diff-migrate-task"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-migrate-task"

--- linux-2.6.17-mm1s.orig/kernel/sched.c	2006-06-21 18:53:17.000000000 +0400
+++ linux-2.6.17-mm1.dev/kernel/sched.c	2006-06-23 12:09:16.000000000 +0400
@@ -4858,12 +4858,13 @@ EXPORT_SYMBOL_GPL(set_cpus_allowed);
  * So we race with normal scheduler movements, but that's OK, as long
  * as the task is no longer on this CPU.
  */
-static void __migrate_task(struct task_struct *p, int src_cpu, int dest_cpu)
+static int __migrate_task(struct task_struct *p, int src_cpu, int dest_cpu)
 {
 	runqueue_t *rq_dest, *rq_src;
+	int res = 0;
 
 	if (unlikely(cpu_is_offline(dest_cpu)))
-		return;
+		return 0;
 
 	rq_src = cpu_rq(src_cpu);
 	rq_dest = cpu_rq(dest_cpu);
@@ -4891,9 +4892,10 @@ static void __migrate_task(struct task_s
 		if (TASK_PREEMPTS_CURR(p, rq_dest))
 			resched_task(rq_dest->curr);
 	}
-
+	res = 1;
 out:
 	double_rq_unlock(rq_src, rq_dest);
+	return res;
 }
 
 /*
@@ -4964,10 +4966,13 @@ int sigstop_on_cpu_lost;
 /* Figure out where task on dead CPU should go, use force if neccessary. */
 static void move_task_off_dead_cpu(int dead_cpu, struct task_struct *tsk)
 {
-	int dest_cpu;
+	runqueue_t *rq;
+	unsigned long flags;
+	int dest_cpu, res;
 	cpumask_t mask;
 	int force = 0;
 
+restart:
 	/* On same node? */
 	mask = node_to_cpumask(cpu_to_node(dead_cpu));
 	cpus_and(mask, mask, tsk->cpus_allowed);
@@ -4979,8 +4984,10 @@ static void move_task_off_dead_cpu(int d
 
 	/* No more Mr. Nice Guy. */
 	if (dest_cpu == NR_CPUS) {
+		rq = task_rq_lock(tsk, &flags);
 		cpus_setall(tsk->cpus_allowed);
 		dest_cpu = any_online_cpu(tsk->cpus_allowed);
+		task_rq_unlock(rq, &flags);
 
 		/*
 		 * Don't tell them about moving exiting tasks or
@@ -5000,7 +5007,9 @@ static void move_task_off_dead_cpu(int d
 		if (tsk->mm && sigstop_on_cpu_lost)
 			force = 1;
 	}
-	__migrate_task(tsk, dead_cpu, dest_cpu);
+	res = __migrate_task(tsk, dead_cpu, dest_cpu);
+	if (!res)
+		goto restart;
 
 	if (force)
 		force_sig_specific(SIGSTOP, tsk);

--------------010105090808030405030208--
