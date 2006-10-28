Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWJ1CnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWJ1CnQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 22:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751646AbWJ1Cmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 22:42:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:18153 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751632AbWJ1Cmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 22:42:40 -0400
Date: Fri, 27 Oct 2006 19:41:48 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Message-Id: <20061028024148.10809.19537.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061028024112.10809.15841.sendpatchset@schroedinger.engr.sgi.com>
References: <20061028024112.10809.15841.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 7/7] Call tasklet less frequently
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Schedule load balance tasklet less frequently

We schedule the tasklet before this patch always with the value in
sd->interval. However, if the queue is busy then it is sufficient
to schedule the tasklet with sd->interval*busy_factor.

So we modify the calculation of the next time to balance by taking
the interval added to last_balance again. This is only the
right value if the idle/busy situation continues as is.

There are two potential trouble spots:
- If the queue was idle and now gets busy then we call rebalance
  early. However, that is not a problem because we will then use
  the longer interval for the next period.

- If the queue was busy and becomes idle then we potentially
  wait too long before rebalancing. However, when the task
  goes idle then idle_balance is called. We add another calculation
  of the next balance time based on sd->interval in idle_balance
  so that we will rebalance soon.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc3/kernel/sched.c
===================================================================
--- linux-2.6.19-rc3.orig/kernel/sched.c	2006-10-27 20:36:37.269918493 -0500
+++ linux-2.6.19-rc3/kernel/sched.c	2006-10-27 20:41:10.765080822 -0500
@@ -2757,14 +2757,26 @@ out_balanced:
 static void idle_balance(int this_cpu, struct rq *this_rq)
 {
 	struct sched_domain *sd;
+	int pulled_task = 0;
+	unsigned long next_balance = jiffies + 60 *  HZ;
 
 	for_each_domain(this_cpu, sd) {
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
 			/* If we've pulled tasks over stop searching: */
-			if (load_balance_newidle(this_cpu, this_rq, sd))
+			pulled_task = load_balance_newidle(this_cpu,
+							this_rq, sd);
+			next_balance = min(next_balance,
+				sd->last_balance + sd->balance_interval);
+			if (pulled_task)
 				break;
 		}
 	}
+	if (!pulled_task)
+		/*
+		 * We are going idle. next_balance may be set based on
+		 * a busy processor. So reset next_balance.
+		 */
+		this_rq->next_balance = next_balance;
 }
 
 /*
@@ -2889,8 +2901,16 @@ static void rebalance_domains(unsigned l
 			}
 			sd->last_balance += interval;
 		}
+		/*
+		 * Calculate the next balancing point assuming that
+		 * the idle state does not change. If we are idle and then
+		 * start running a process then this will be recalculated.
+		 * If we are running a process and then become idle
+		 * then idle_balance will reset next_balance so that we
+		 * rebalance earlier.
+		 */
 		next_balance = min(next_balance,
-				sd->last_balance + sd->balance_interval);
+				sd->last_balance + interval);
 	}
 	this_rq->next_balance = next_balance;
 }
