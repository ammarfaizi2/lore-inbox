Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423595AbWJZQNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423595AbWJZQNQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 12:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161426AbWJZQNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 12:13:15 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10702 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161399AbWJZQNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 12:13:14 -0400
Date: Thu, 26 Oct 2006 09:12:45 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: akpm@osdl.org, Peter Williams <pwil3058@bigpond.net.au>,
       linux-kernel@vger.kernel.org,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [PATCH 2/5] Extract load calculation from rebalance_tick
In-Reply-To: <4540A404.5090406@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0610260907100.16978@schroedinger.engr.sgi.com>
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
 <20061024183114.4530.95231.sendpatchset@schroedinger.engr.sgi.com>
 <4540A404.5090406@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Oct 2006, Nick Piggin wrote:

> 'time_slice' should be static, and it should be named better, and you
> may as well also put the "task has expired but not rescheduled" part
> in there too. That is part of the same logical op (which is to resched
> the task when it finishes timeslice).

This way?

Index: linux-2.6.19-rc3/kernel/sched.c
===================================================================
--- linux-2.6.19-rc3.orig/kernel/sched.c	2006-10-26 11:04:43.000000000 -0500
+++ linux-2.6.19-rc3/kernel/sched.c	2006-10-26 11:11:20.458202627 -0500
@@ -3044,8 +3044,13 @@ void account_steal_time(struct task_stru
 		cpustat->steal = cputime64_add(cpustat->steal, tmp);
 }
 
-void time_slice(struct rq *rq, struct task_struct *p)
+static void task_running_tick(struct rq *rq, struct task_struct *p)
 {
+	if (p->array != rq->active) {
+		/* Task has expired but was not scheduled yet */
+		set_tsk_need_resched(p);
+		return;
+	}
 	spin_lock(&rq->lock);
 	/*
 	 * The task was running during this tick - update the
@@ -3135,14 +3140,8 @@ void scheduler_tick(void)
 	if (p == rq->idle)
 		/* Task on the idle queue */
 		wake_priority_sleeper(rq);
-	else {
-		/* Task on cpu queue */
-		if (p->array != rq->active)
-			/* Task has expired but was not scheduled yet */
-			set_tsk_need_resched(p);
-		else
-			time_slice(rq, p);
-	}
+	else
+		task_running_tick(rq, p);
 #ifdef CONFIG_SMP
 	update_load(rq);
 	if (jiffies >= __get_cpu_var(next_balance))
