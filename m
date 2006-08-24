Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWHXMSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWHXMSa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWHXMSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:18:30 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:18223 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751177AbWHXMS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:18:29 -0400
Date: Thu, 24 Aug 2006 14:18:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] dubious process system time.
Message-ID: <20060824121825.GA4425@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch] dubious process system time.

The system time that is accounted to a process includes the time spent
in three different contexts: normal system time, hardirq time and
softirq time. To account hardirq time and sortirq time to a process
seems wrong, because the process could just happen to run when the
interrupt arrives that was caused by an i/o for a completly different
process. And the sum over stime and cstime of all processes won't
match cputstat->system either. 
The following patch changes the accounting of system time so that
hardirq and softirq time are not accounted to a process anymore.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 kernel/sched.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/kernel/sched.c linux-2.6-patched/kernel/sched.c
--- linux-2.6/kernel/sched.c	2006-08-01 10:09:55.000000000 +0200
+++ linux-2.6-patched/kernel/sched.c	2006-08-24 13:42:40.000000000 +0200
@@ -2939,17 +2939,16 @@ void account_system_time(struct task_str
 	struct rq *rq = this_rq();
 	cputime64_t tmp;
 
-	p->stime = cputime_add(p->stime, cputime);
-
 	/* Add system time to cpustat. */
 	tmp = cputime_to_cputime64(cputime);
 	if (hardirq_count() - hardirq_offset)
 		cpustat->irq = cputime64_add(cpustat->irq, tmp);
 	else if (softirq_count())
 		cpustat->softirq = cputime64_add(cpustat->softirq, tmp);
-	else if (p != rq->idle)
+	else if (p != rq->idle) {
+		p->stime = cputime_add(p->stime, cputime);
 		cpustat->system = cputime64_add(cpustat->system, tmp);
-	else if (atomic_read(&rq->nr_iowait) > 0)
+	} else if (atomic_read(&rq->nr_iowait) > 0)
 		cpustat->iowait = cputime64_add(cpustat->iowait, tmp);
 	else
 		cpustat->idle = cputime64_add(cpustat->idle, tmp);
