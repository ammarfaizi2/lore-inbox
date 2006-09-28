Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030275AbWI1Rdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWI1Rdc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWI1Rdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:33:32 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:13971 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030273AbWI1Rda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:33:30 -0400
Date: Thu, 28 Sep 2006 23:03:20 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com,
       ckrm-tech@lists.sourceforge.net
Subject: [RFC, PATCH 8/9] CPU Controller V2 - task_cpu(p) needs to be correct always
Message-ID: <20060928173320.GI8746@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060928172520.GA8746@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928172520.GA8746@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We rely very much on task_cpu(p) to be correct at all times, so that we can
correctly find the task_grp_rq from which the task has to be removed or added
to.

There is however one place in the scheduler where this assumption of
task_cpu(p) being correct is broken. This patch fixes that piece of code.

(Thanks to Balbir Singh for pointing this out to me)

Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.18-root/kernel/sched.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff -puN kernel/sched.c~cpu_ctlr_setcpu kernel/sched.c
--- linux-2.6.18/kernel/sched.c~cpu_ctlr_setcpu	2006-09-28 16:40:37.844287616 +0530
+++ linux-2.6.18-root/kernel/sched.c	2006-09-28 17:23:14.896556584 +0530
@@ -5230,6 +5230,7 @@ static int __migrate_task(struct task_st
 {
 	struct rq *rq_dest, *rq_src;
 	int ret = 0;
+	struct prio_array *array;
 
 	if (unlikely(cpu_is_offline(dest_cpu)))
 		return ret;
@@ -5245,8 +5246,8 @@ static int __migrate_task(struct task_st
 	if (!cpu_isset(dest_cpu, p->cpus_allowed))
 		goto out;
 
-	set_task_cpu(p, dest_cpu);
-	if (p->array) {
+	array = p->array;
+	if (array) {
 		/*
 		 * Sync timestamp with rq_dest's before activating.
 		 * The same thing could be achieved by doing this step
@@ -5256,6 +5257,11 @@ static int __migrate_task(struct task_st
 		p->timestamp = p->timestamp - rq_src->timestamp_last_tick
 				+ rq_dest->timestamp_last_tick;
 		deactivate_task(p, rq_src);
+	}
+
+	set_task_cpu(p, dest_cpu);
+
+	if (array) {
 		__activate_task(p, rq_dest);
 		if (TASK_PREEMPTS_CURR(p, rq_dest))
 			resched_task(rq_dest->curr);
_
-- 
Regards,
vatsa
