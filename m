Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161158AbWJXScT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161158AbWJXScT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 14:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbWJXSbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 14:31:53 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14986 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161161AbWJXSbp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 14:31:45 -0400
Date: Tue, 24 Oct 2006 11:31:30 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Message-Id: <20061024183130.4530.83162.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 5/5] Only call rebalance_domains when needed from scheduler_tick
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Only call rebalance_domains when needed from scheduler_tick.

Call rebalance_domains from a tasklet with interrupt enabled.
Only call it when one of the sched domains is to be rebalanced.
The jiffies when the next balancing action is to take place is
kept in a per cpu variable next_balance.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc2-mm2/kernel/sched.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/sched.c	2006-10-24 10:40:32.000000000 -0500
+++ linux-2.6.19-rc2-mm2/kernel/sched.c	2006-10-24 10:42:02.135978934 -0500
@@ -2841,8 +2841,11 @@ static void update_load(struct rq *this_
 	}
 }
 
+static DEFINE_PER_CPU(unsigned long, next_balance);
+
 /*
- * rebalance_domains is called from the scheduler_tick.
+ * rebalance_domains is triggered when needed via a tasklet from the
+ * scheduler_tick.
  *
  * It checks each scheduling domain to see if it is due to be balanced,
  * and initiates a balancing operation if so.
@@ -2858,6 +2861,8 @@ static void rebalance_domains(unsigned l
 	/* Idle means on the idle queue without a runnable task */
 	enum idle_type idle = (this_rq->idle && !this_rq->nr_running) ?
 				SCHED_IDLE : NOT_IDLE;
+	/* Maximum time between calls to rebalance_domains */
+	unsigned long next_balance = jiffies + 60*HZ;
 
 	for_each_domain(this_cpu, sd) {
 		if (!(sd->flags & SD_LOAD_BALANCE))
@@ -2883,8 +2888,12 @@ static void rebalance_domains(unsigned l
 			}
 			sd->next_balance += interval;
 		}
+		next_balance = min(next_balance, sd->next_balance);
 	}
+      	__get_cpu_var(next_balance) = next_balance;
 }
+
+DECLARE_TASKLET(rebalance, &rebalance_domains, 0L);
 #else
 /*
  * on UP we do not need to balance between CPUs:
@@ -3137,7 +3146,8 @@ void scheduler_tick(void)
 	}
 #ifdef CONFIG_SMP
 	update_load(rq);
-	rebalance_domains(0L);
+	if (jiffies >= __get_cpu_var(next_balance))
+		tasklet_schedule(&rebalance);
 #endif
 }
 
