Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272664AbTHMNAO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 09:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272778AbTHMNAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 09:00:14 -0400
Received: from trappist.elis.UGent.be ([157.193.204.1]:8360 "EHLO
	trappist.elis.UGent.be") by vger.kernel.org with ESMTP
	id S272664AbTHMNAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 09:00:09 -0400
Subject: [PATCH] sched_best_cpu
From: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Frank Cornelis <Frank.Cornelis@elis.ugent.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 13 Aug 2003 15:00:08 +0200
Message-Id: <1060779608.1723.30.camel@tom>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I ran across the '10 *' stuff (grrr... grrr...) in 
	linux-2.6.0-test3/kernel/sched.c:sched_best_cpu
I think next patch is more like it.


Frank.

--- sched.c.orig	2003-08-09 06:39:35.000000000 +0200
+++ sched.c	2003-08-13 14:55:05.000000000 +0200
@@ -776,7 +776,7 @@
  */
 static int sched_best_cpu(struct task_struct *p)
 {
-	int i, minload, load, best_cpu, node = 0;
+	int i, minload, load, best_cpu, node = 0, pnode;
 	unsigned long cpumask;
 
 	best_cpu = task_cpu(p);
@@ -784,14 +784,14 @@
 		return best_cpu;
 
 	minload = 10000000;
+	pnode = cpu_to_node(task_cpu(p));
 	for_each_node_with_cpus(i) {
 		/*
 		 * Node load is always divided by nr_cpus_node to normalise 
 		 * load values in case cpu count differs from node to node.
-		 * We first multiply node_nr_running by 10 to get a little
-		 * better resolution.   
+		 * If the node != our node we add the load of the task.
 		 */
-		load = 10 * atomic_read(&node_nr_running[i]) / nr_cpus_node(i);
+		load = (atomic_read(&node_nr_running[i]) + (i != pnode)) / nr_cpus_node(i);
 		if (load < minload) {
 			minload = load;
 			node = i;

