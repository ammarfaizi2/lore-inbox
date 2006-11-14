Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966335AbWKNUfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966335AbWKNUfb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966339AbWKNUe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:34:57 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:1442 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S966335AbWKNUdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:33:49 -0500
Date: Tue, 14 Nov 2006 12:33:32 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20061114203332.12761.27463.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
References: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 7/8] Call tasklet less frequently
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trigger softirq less frequently

We trigger the softirq before this patch using offset of
sd->interval. However, if the queue is busy then it is sufficient
to schedule the softirq with sd->interval * busy_factor.

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

V2->V3:
- Calculate rebalance time based on current jiffies and not
  based on the jiffies at the last time we load balanced.
  We no longer rely on staggering and therefore we can
  affort to do this now.

V3->V4:
- Use functions to do jiffy comparisons.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm1/kernel/sched.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/kernel/sched.c	2006-11-13 18:11:07.034196836 -0600
+++ linux-2.6.19-rc5-mm1/kernel/sched.c	2006-11-13 19:04:40.316317645 -0600
@@ -2777,14 +2777,28 @@ out_balanced:
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
+			if (time_after(next_balance,
+				  sd->last_balance + sd->balance_interval))
+				next_balance = sd->last_balance
+						+ sd->balance_interval;
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
@@ -2907,7 +2921,7 @@ static void run_rebalance_domains(struct
 				 */
 				idle = NOT_IDLE;
 			}
-			sd->last_balance += interval;
+			sd->last_balance = jiffies;
 		}
 		if (time_after(next_balance, sd->last_balance + interval))
 			next_balance = sd->last_balance + interval;
