Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbTHUJrN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 05:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262571AbTHUJrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 05:47:13 -0400
Received: from trappist.elis.UGent.be ([157.193.204.1]:39323 "EHLO
	trappist.elis.UGent.be") by vger.kernel.org with ESMTP
	id S262561AbTHUJrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 05:47:09 -0400
Subject: [PATCH] sched: sched_best_cpu
From: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 21 Aug 2003 11:47:07 +0200
Message-Id: <1061459227.19789.22.camel@tom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


Next patch slightly favors the local node when looking for the least
loaded cpu; when the task would not stay on our node we add 1 to the
load to simulate the influence the migration would have on the load.


Frank


--- sched.c.orig	2003-08-09 06:39:35.000000000 +0200
+++ sched.c	2003-08-21 11:45:04.000000000 +0200
@@ -776,29 +776,30 @@
  */
 static int sched_best_cpu(struct task_struct *p)
 {
-	int i, minload, load, best_cpu, node = 0;
+	int i, minload, load, best_cpu, node, pnode;
 	unsigned long cpumask;
 
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
+		 * If the node != our node we add the load of the task.
+		 * We multiply by NR_CPUS for better resolution.
 		 */
-		load = 10 * atomic_read(&node_nr_running[i]) / nr_cpus_node(i);
+		load = NR_CPUS * (atomic_read(&node_nr_running[i]) + (i != pnode)) / nr_cpus_node(i);
 		if (load < minload) {
 			minload = load;
 			node = i;
 		}
 	}
 
-	minload = 10000000;
+	minload = INT_MAX;
 	cpumask = node_to_cpumask(node);
 	for (i = 0; i < NR_CPUS; ++i) {
 		if (!(cpumask & (1UL << i)))

