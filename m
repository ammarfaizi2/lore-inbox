Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWKCUst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWKCUst (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWKCUrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:47:17 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52178 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932123AbWKCUrO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:47:14 -0500
Date: Fri, 3 Nov 2006 12:47:12 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20061103204712.15739.15921.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061103204636.15739.74831.sendpatchset@schroedinger.engr.sgi.com>
References: <20061103204636.15739.74831.sendpatchset@schroedinger.engr.sgi.com>
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

Index: linux-2.6.19-rc4-mm2/kernel/sched.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/kernel/sched.c	2006-11-03 12:58:39.263918629 -0600
+++ linux-2.6.19-rc4-mm2/kernel/sched.c	2006-11-03 12:59:12.906134941 -0600
@@ -2758,14 +2758,26 @@ out_balanced:
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
@@ -2890,8 +2902,16 @@ static void rebalance_domains(unsigned l
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
