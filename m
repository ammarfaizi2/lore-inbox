Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263122AbTHVMuw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263194AbTHVMup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:50:45 -0400
Received: from trappist.elis.UGent.be ([157.193.204.1]:674 "EHLO
	trappist.elis.UGent.be") by vger.kernel.org with ESMTP
	id S263122AbTHVMck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 08:32:40 -0400
Subject: [PATCH] sched: sched_best_cpu
From: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 22 Aug 2003 14:32:39 +0200
Message-Id: <1061555559.3341.18.camel@tom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I repatched it against the latest bk.
This patch favors the local node more than the others to prevent unnecessary task migration by doing a better estimation of the after-migration load (see inline C documentation).


Frank.


 sched.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)


diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Thu Aug 21 16:10:41 2003
+++ b/kernel/sched.c	Thu Aug 21 16:10:41 2003
@@ -793,29 +793,33 @@
  */
 static int sched_best_cpu(struct task_struct *p)
 {
-	int i, minload, load, best_cpu, node = 0;
+	int i, minload, load, best_cpu, node, pnode;
 	cpumask_t cpumask;
 
 	best_cpu = task_cpu(p);
 	if (cpu_rq(best_cpu)->nr_running <= 2)
 		return best_cpu;
 
-	minload = 10000000;
+	minload = INT_MAX;
+	node = pnode = cpu_to_node(best_cpu);
 	for_each_node_with_cpus(i) {
 		/*
 		 * Node load is always divided by nr_cpus_node to normalise 
 		 * load values in case cpu count differs from node to node.
-		 * We first multiply node_nr_running by 10 to get a little
-		 * better resolution.   
+		 * If node != our node we add the load of the migrating task;
+		 * we only want to migrate if:
+		 * 	load(other node) + 1 < load(our node) - 1
+		 * The '+ 1' and '- 1' denote the migration.
+		 * We multiply by NR_CPUS for best resolution.
 		 */
-		load = 10 * atomic_read(&node_nr_running[i]) / nr_cpus_node(i);
+		load = NR_CPUS * (atomic_read(&node_nr_running[i]) + ((i != pnode) << 1)) / nr_cpus_node(i);
 		if (load < minload) {
 			minload = load;
 			node = i;
 		}
 	}
 
-	minload = 10000000;
+	minload = INT_MAX;
 	cpumask = node_to_cpumask(node);
 	for (i = 0; i < NR_CPUS; ++i) {
 		if (!cpu_isset(i, cpumask))



