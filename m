Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbVHBAnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbVHBAnW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 20:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVHBAnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 20:43:22 -0400
Received: from fmr22.intel.com ([143.183.121.14]:5011 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261326AbVHBAmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 20:42:33 -0400
Date: Mon, 1 Aug 2005 17:42:21 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: mingo@elte.hu, nickpiggin@yahoo.com.au
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, steiner@sgi.com
Subject: [Patch] don't kick ALB in the presence of pinned task
Message-ID: <20050801174221.B11610@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner brought this issue at my OLS talk.

Take a scenario where two tasks are pinned to two HT threads in a physical
package. Idle packages in the system will keep kicking migration_thread
on the busy package with out any success.

We will run into similar scenarios in the presence of CMP/NUMA.

Patch appended.

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

--- linux-2.6.13-rc4/kernel/sched.c~	2005-08-01 10:50:27.085884216 -0700
+++ linux-2.6.13-rc4/kernel/sched.c	2005-08-01 14:39:04.147573872 -0700
@@ -2098,6 +2098,16 @@
 		if (unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2)) {
 
 			spin_lock(&busiest->lock);
+
+			/* don't kick the migration_thread, if the curr
+			 * task on busiest cpu can't be moved to this_cpu
+			 */
+			if (!cpu_isset(this_cpu, busiest->curr->cpus_allowed)) {
+				spin_unlock(&busiest->lock);
+				all_pinned = 1;
+				goto out_one_pinned;
+			}
+
 			if (!busiest->active_balance) {
 				busiest->active_balance = 1;
 				busiest->push_cpu = this_cpu;
@@ -2135,6 +2145,7 @@
 out_balanced:
 	spin_unlock(&this_rq->lock);
 
+out_one_pinned:
 	schedstat_inc(sd, lb_balanced[idle]);
 
 	sd->nr_balance_failed = 0;
