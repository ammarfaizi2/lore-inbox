Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVANOlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVANOlT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 09:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVANOlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 09:41:19 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:28060 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261959AbVANOlI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 09:41:08 -0500
Date: Fri, 14 Jan 2005 15:41:05 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cputime: fix account_steal_time.
Message-ID: <20050114144105.GA5416@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
after the cputime patches have hit BitKeeper, Uli had a look at them and
being Uli he found a bug. Actually three bugs but they are all in the
same function. The bugs are only relevant for an architecture that uses
account_steal_time which is currently s390 only.

blue skies,
  Martin.

---

[PATCH] cputime: fix account_steal_time.

From: Ulrich Weigand <uweigand@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>

account_steal_time called for idle doesn't work correctly:
1) steal time while idle needs to be added to the system time of idle
   to get correct uptime numbers
3) if there is an i/o request outstanding the steal time should be
   added to iowait, even if the hypervisor scheduled another virtual
   cpu since we are still waiting for i/o.
2) steal time while idle without an i/o request outstanding has to
   be added to cpustat->idle and not to cpustat->system.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 kernel/sched.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff -urN linux-2.6/kernel/sched.c linux-2.6-patched/kernel/sched.c
--- linux-2.6/kernel/sched.c	2005-01-14 15:02:43.000000000 +0100
+++ linux-2.6-patched/kernel/sched.c	2005-01-14 15:02:52.000000000 +0100
@@ -2383,13 +2383,17 @@
 void account_steal_time(struct task_struct *p, cputime_t steal)
 {
 	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
-	cputime64_t steal64 = cputime_to_cputime64(steal);
+	cputime64_t tmp = cputime_to_cputime64(steal);
 	runqueue_t *rq = this_rq();
 
-	if (p == rq->idle)
-		cpustat->system = cputime64_add(cpustat->system, steal64);
-	else
-		cpustat->steal = cputime64_add(cpustat->steal, steal64);
+	if (p == rq->idle) {
+		p->stime = cputime_add(p->stime, steal);
+		if (atomic_read(&rq->nr_iowait) > 0)
+			cpustat->iowait = cputime64_add(cpustat->iowait, tmp);
+		else
+			cpustat->idle = cputime64_add(cpustat->idle, tmp);
+	} else
+		cpustat->steal = cputime64_add(cpustat->steal, tmp);
 }
 
 /*
