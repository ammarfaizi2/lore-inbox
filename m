Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932280AbVLELBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbVLELBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 06:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVLELBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 06:01:16 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:18326 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932280AbVLELBP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 06:01:15 -0500
Date: Mon, 5 Dec 2005 16:32:39 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: paulmck@us.ibm.com, Dipankar <dipankar@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix RCU race in access of nohz_cpu_mask
Message-ID: <20051205110239.GE2385@in.ibm.com>
Reply-To: vatsa@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Accessing  nohz_cpu_mask before incrementing rcp->cur is racy. It can
cause tickless idle CPUs to be included in rsp->cpumask, which will
extend graceperiods unnecessarily.

Patch below (against 2.6.15-rc5-mm1) fixes this race. It has been tested using 
extensions to RCU torture module that forces various CPUs to become idle.

Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.15-rc5-mm1-root/kernel/rcupdate.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN kernel/rcupdate.c~rcu-lock kernel/rcupdate.c
--- linux-2.6.15-rc5-mm1/kernel/rcupdate.c~rcu-lock	2005-12-05 15:28:33.000000000 +0530
+++ linux-2.6.15-rc5-mm1-root/kernel/rcupdate.c	2005-12-05 15:28:40.000000000 +0530
@@ -244,15 +244,15 @@ static void rcu_start_batch(struct rcu_c
 
 	if (rcp->next_pending &&
 			rcp->completed == rcp->cur) {
-		/* Can't change, since spin lock held. */
-		cpus_andnot(rsp->cpumask, cpu_online_map, nohz_cpu_mask);
-
 		rcp->next_pending = 0;
 		/* next_pending == 0 must be visible in __rcu_process_callbacks()
 		 * before it can see new value of cur.
 		 */
 		smp_wmb();
 		rcp->cur++;
+		smp_mb();
+		cpus_andnot(rsp->cpumask, cpu_online_map, nohz_cpu_mask);
+
 	}
 }
 

_


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
