Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbWFOOmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbWFOOmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 10:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbWFOOmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 10:42:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:52611 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030452AbWFOOmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 10:42:39 -0400
Date: Thu, 15 Jun 2006 09:42:33 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] kthread: convert kswapd from kernel_thread
Message-ID: <20060615144233.GA16046@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert kswapd from a (deprecated) kernel_thread to a kthread.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 mm/vmscan.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

fa35014607fbf5c98cd291abfc0e80ff149440f9
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 440a733..cc66dfe 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -34,6 +34,7 @@ #include <linux/cpuset.h>
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
 #include <linux/delay.h>
+#include <linux/kthread.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -1220,7 +1221,6 @@ static int kswapd(void *p)
 	};
 	cpumask_t cpumask;
 
-	daemonize("kswapd%d", pgdat->node_id);
 	cpumask = node_to_cpumask(pgdat->node_id);
 	if (!cpus_empty(cpumask))
 		set_cpus_allowed(tsk, cpumask);
@@ -1352,13 +1352,9 @@ static int __init kswapd_init(void)
 
 	swap_setup();
 	for_each_online_pgdat(pgdat) {
-		pid_t pid;
-
-		pid = kernel_thread(kswapd, pgdat, CLONE_KERNEL);
-		BUG_ON(pid < 0);
-		read_lock(&tasklist_lock);
-		pgdat->kswapd = find_task_by_pid(pid);
-		read_unlock(&tasklist_lock);
+		pgdat->kswapd = kthread_run(kswapd, pgdat, "kswapd%d",
+						pgdat->node_id);
+		BUG_ON(IS_ERR(pgdat->kswapd));
 	}
 	total_memory = nr_free_pagecache_pages();
 	hotcpu_notifier(cpu_callback, 0);
-- 
1.3.3

