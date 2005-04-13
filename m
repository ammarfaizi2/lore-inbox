Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVDMTHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVDMTHs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 15:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVDMTHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 15:07:48 -0400
Received: from fmr23.intel.com ([143.183.121.15]:7627 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261211AbVDMTHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 15:07:33 -0400
Date: Wed, 13 Apr 2005 12:07:14 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: nickpiggin@yahoo.com.au, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [patch] sched: fix active load balance
Message-ID: <20050413120713.A25137@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes to active load balance (sched2-fix-smt-scheduling-problems.patch
in -mm) is not resulting in any task movement from busiest to target_cpu.
Attached patch(ontop of -mm) fixes this issue.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.12-rc2-mm3/kernel/sched.c	2005-04-11 23:08:30.875103512 -0700
+++ linux/kernel/sched.c	2005-04-13 10:44:37.400829992 -0700
@@ -2131,7 +2131,7 @@
  */
 static void active_load_balance(runqueue_t *busiest_rq, int busiest_cpu)
 {
-	struct sched_domain *tmp = NULL, *sd;
+	struct sched_domain *sd;
 	runqueue_t *target_rq;
 	int target_cpu = busiest_rq->push_cpu;
 
@@ -2152,13 +2152,10 @@
 	double_lock_balance(busiest_rq, target_rq);
 
 	/* Search for an sd spanning us and the target CPU. */
-	for_each_domain(target_cpu, sd) {
+	for_each_domain(target_cpu, sd)
 		if ((sd->flags & SD_LOAD_BALANCE) &&
-			cpu_isset(busiest_cpu, sd->span)) {
-				sd = tmp;
+			cpu_isset(busiest_cpu, sd->span))
 				break;
-		}
-	}
 
 	if (unlikely(sd == NULL))
 		goto out;
